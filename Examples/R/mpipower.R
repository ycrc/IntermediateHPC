library(Rmpi)
source("powerfuns.R")

# every MPI task launched by srun runs this script
rank = mpi.comm.rank(0)
size = mpi.comm.size(0)
if (rank == 0) print_settings(size)

# task 0 makes the population and sends a copy to every other task
mpi.barrier(0)
timing = system.time({
 # mpi.bcast.Robj only returns the object on the receiving tasks
 if (rank == 0) {
  population <- make_population()
  mpi.bcast.Robj(population, rank=0, comm=0)
 } else {
  population <- mpi.bcast.Robj(NULL, rank=0, comm=0)
 }
})
if (rank == 0) print(timing)

# every task builds the same task list and takes every size-th task
tasks = make_tasks()
mine = which((seq_along(tasks) - 1) %% size == rank)

mpi.barrier(0)
timing = system.time({
 my_rejects <- lapply(tasks[mine], run_task)
 all_rejects <- mpi.gather.Robj(list(mine=mine, rejects=my_rejects), root=0, comm=0, simplify=FALSE)
})

if (rank == 0) {
 print(timing)
 rejects = vector("list", length(tasks))
 for (r in all_rejects) rejects[r$mine] = r$rejects
 print(summarize_power(tasks, rejects))
}

mpi.quit()
