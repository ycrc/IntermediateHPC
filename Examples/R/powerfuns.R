# shared code for the power simulation examples
# (power.R, mcpower.R, parallelpower.R, mpipower.R)
#
# see README.power for what a power simulation is
#
# estimates the power of a two-sample t-test for several sample sizes
# and effect sizes by running many simulated t-tests

# problem size, set in the job script
reps_per_task  = as.integer(Sys.getenv("SIM_REPS", "2000"))    # t-tests per task
tasks_per_cell = as.integer(Sys.getenv("SIM_TASKS", "32"))     # tasks per (n, effect) cell
data_mb        = as.numeric(Sys.getenv("SIM_DATA_MB", "200"))  # size of shared population in MB

sample_sizes = c(20, 50, 100, 200)
effects      = c(0, 0.2, 0.5, 0.8)

# large population that every task draws from, standing in for a big shared dataset
make_population <- function(){
 set.seed(1)
 rnorm(data_mb * 1e6 / 8)
}

# list of tasks; each (n, effect) cell is split into tasks_per_cell tasks
# n varies fastest so any contiguous block of tasks has a mix of cheap and costly ones
make_tasks <- function(){
 grid = expand.grid(n=sample_sizes, effect=effects, chunk=1:tasks_per_cell)
 grid$id = seq_len(nrow(grid))
 lapply(seq_len(nrow(grid)), function(i) grid[i, ])
}

# runs reps_per_task t-tests and counts how many reject at the 0.05 level
# seeding by task id gives the same answer no matter which worker runs the task
run_task <- function(task){
 set.seed(task$id)
 rejects = 0
 for (r in 1:reps_per_task) {
  x = sample(population, task$n)
  y = sample(population, task$n) + task$effect
  if (t.test(x, y)$p.value < 0.05) rejects = rejects + 1
 }
 rejects
}

# combines the task results into a table of power by n and effect
summarize_power <- function(tasks, rejects){
 df = do.call(rbind, tasks)
 df$rejects = unlist(rejects)
 cells = aggregate(rejects ~ n + effect, data=df, FUN=sum)
 cells$power = cells$rejects / (tasks_per_cell * reps_per_task)
 round(xtabs(power ~ n + effect, data=cells), 3)
}

print_settings <- function(workers){
 cat("workers:", workers, " tasks:", length(sample_sizes) * length(effects) * tasks_per_cell,
     " t-tests per task:", reps_per_task, " shared data MB:", data_mb, "\n")
}
