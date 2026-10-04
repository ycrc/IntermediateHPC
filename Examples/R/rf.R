library(randomForest)
source("rffuns.R")
print_settings(1)

# serial version
train = make_data()
print(system.time(forests <- lapply(1:rf_tasks, grow_trees)))

print(system.time(evaluate(forests)))
