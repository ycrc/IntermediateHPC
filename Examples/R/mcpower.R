library(parallel)
source("powerfuns.R")

cores = as.integer(Sys.getenv("SLURM_CPUS_PER_TASK"))
print_settings(cores)

# forked workers share the parent's memory, so population needs no copying
print(system.time(population <- make_population()))
tasks = make_tasks()

print(system.time(rejects <- mclapply(tasks, run_task, mc.cores=cores)))

print(summarize_power(tasks, rejects))
