library(randomForest)
library(parallel)
source("rffuns.R")

cores = as.integer(Sys.getenv("SLURM_CPUS_PER_TASK"))
print_settings(cores)

train = make_data()

# socket workers are separate R processes, so each one has to load
# randomForest and get its own copy of the data
print(system.time(cl <- makePSOCKcluster(cores)))
print(system.time({
 clusterEvalQ(cl, library(randomForest))
 clusterExport(cl, c("train", "rf_task_trees"))
}))

print(system.time(forests <- parLapply(cl, 1:rf_tasks, grow_trees)))
stopCluster(cl)

print(system.time(evaluate(forests)))
