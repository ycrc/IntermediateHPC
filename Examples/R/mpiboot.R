library(boot)
library(Rmpi)

# every MPI task launched by srun runs this script
rank = mpi.comm.rank(0)
size = mpi.comm.size(0)
if (rank == 0) print(size)

# tries 5 different regression models on data
volume_estimate <- function(data, indices){
 d = data[indices, ]
 H_relationship = lm(d$Volume~d$Height, data = d)
 H_r_sq = summary(H_relationship)$r.square
 G_relationship = lm(d$Volume~d$Girth, data = d)
 G_r_sq = summary(G_relationship)$r.square
 G_H_ratio = d$Girth / d$Height
 G_H_relationship = lm(d$Volume~G_H_ratio, data = d)
 G_H_r_sq = summary(G_H_relationship)$r.square
 combined_relationship = lm(d$Volume~d$Height + d$Girth, data = d)
 combined_r_sq = summary(combined_relationship)$r.square
 combined_2_relationship = lm(d$Volume~d$Height +d$Girth + G_H_ratio, data = d)
 combined_2_r_sq = summary(combined_2_relationship)$r.square
 relationships = c(H_r_sq, G_r_sq, G_H_r_sq, combined_r_sq, combined_2_r_sq)
 return(relationships)
}

# split the bootstrap replicates evenly across tasks
R_total = 300000
R_local = R_total %/% size + (rank < R_total %% size)

# give each task its own independent random number stream
RNGkind("L'Ecuyer-CMRG")
set.seed(12345)
for (i in seq_len(rank)) .Random.seed <- parallel::nextRNGStream(.Random.seed)

# bootstrap on tree data, then gather all replicates on task 0
mpi.barrier(0)
timing = system.time({
 res_local <- boot(data=trees, statistic=volume_estimate, R=R_local)
 all_res <- mpi.gather.Robj(res_local, root=0, comm=0, simplify=FALSE)
})

if (rank == 0) {
 print(timing)
 res = all_res[[1]]
 res$t = do.call(rbind, lapply(all_res, function(r) r$t))
 res$R = nrow(res$t)
 res$call$R = res$R
 print(res)
}

mpi.quit()
