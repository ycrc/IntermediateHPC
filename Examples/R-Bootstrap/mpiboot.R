library(boot)
library(snow)
library(Rmpi)

tasks=8 #as.integer(Sys.getenv("SLURM_NTASKS"))
print(tasks)

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

cl=makeMPIcluster(tasks-1) # need to leave one for master
# bootstrap on tree data
system.time(res<-boot(data=trees, statistic=volume_estimate, R=50000, parallel="snow", cl=cl))

stopCluster(cl)
print(res)
mpi.quit()

print(res)

