library(randomForest)
library(parallel)
source("rffuns.R")

cores = as.integer(Sys.getenv("SLURM_CPUS_PER_TASK"))
print_settings(cores)

# forked workers share the parent's memory, so train needs no copying,
# but each finished forest is copied back to the parent
train = make_data()
print(system.time(forests <- mclapply(1:rf_tasks, grow_trees, mc.cores=cores)))

print(system.time(evaluate(forests)))
