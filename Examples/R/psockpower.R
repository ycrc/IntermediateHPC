library(parallel)
source("powerfuns.R")

cores = as.integer(Sys.getenv("SLURM_CPUS_PER_TASK"))
print_settings(cores)

print(system.time(population <- make_population()))
tasks = make_tasks()

# socket workers are separate R processes, so each one needs its own copy of the data
print(system.time(cl <- makePSOCKcluster(cores)))
print(system.time(clusterExport(cl, c("population", "reps_per_task"))))

print(system.time(rejects <- parLapply(cl, tasks, run_task)))
stopCluster(cl)

print(summarize_power(tasks, rejects))
