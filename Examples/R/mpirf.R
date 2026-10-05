library(randomForest)
library(Rmpi)
source("rffuns.R")

# every MPI task launched by srun runs this script
rank = mpi.comm.rank(0)
size = mpi.comm.size(0)
if (rank == 0) print_settings(size)

# task 0 makes the data and sends a copy to every other task
mpi.barrier(0)
timing = system.time({
 # mpi.bcast.Robj only returns the object on the receiving tasks
 if (rank == 0) {
  train <- make_data()
  mpi.bcast.Robj(train, rank=0, comm=0)
 } else {
  train <- mpi.bcast.Robj(NULL, rank=0, comm=0)
 }
})
if (rank == 0) print(timing)

# each MPI task takes every size-th task, then sends its trees to task 0
mine = which((1:rf_tasks - 1) %% size == rank)

mpi.barrier(0)
timing = system.time({
 my_forests <- lapply(mine, grow_trees)
 all_forests <- mpi.gather.Robj(my_forests, root=0, comm=0, simplify=FALSE)
})

if (rank == 0) {
 print(timing)
 forests = do.call(c, all_forests)
 print(system.time(evaluate(forests)))
}

mpi.quit()
