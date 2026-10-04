# shared code for the random forest examples
# (rf.R, mcrf.R, psockrf.R, mpirf.R)
#
# see README.rf for what a random forest is
#
# grows a random forest in pieces: each task grows a few trees,
# then the pieces are combined into one forest and tested on held-out data

# problem size, set in the job script
rf_rows       = as.integer(Sys.getenv("RF_ROWS", "50000"))        # training rows
rf_tasks      = as.integer(Sys.getenv("RF_TASKS", "64"))          # number of tasks
rf_task_trees = as.integer(Sys.getenv("RF_TREES_PER_TASK", "8"))  # trees grown per task

features  = 20
test_rows = 10000

# synthetic classification data with a nonlinear signal
make_data <- function(){
 set.seed(1)
 n = rf_rows + test_rows
 x = matrix(rnorm(n * features), n, features, dimnames=list(NULL, paste0("x", 1:features)))
 signal = x[,1] + x[,2]^2 - x[,3]*x[,4] + sin(3*x[,5])
 y = factor(signal + rnorm(n) > median(signal))
 test = 1:test_rows
 list(x=x[-test, ], y=y[-test], xtest=x[test, ], ytest=y[test])
}

# grows rf_task_trees trees on the training data
# seeding by task id gives the same forest no matter which worker runs the task
grow_trees <- function(task){
 set.seed(task)
 randomForest(train$x, train$y, ntree=rf_task_trees)
}

# combines the pieces into one forest and reports its accuracy on the test rows
evaluate <- function(forests){
 forest = do.call(combine, forests)
 pred = predict(forest, train$xtest)
 cat("trees:", forest$ntree, " test accuracy:", round(mean(pred == train$ytest), 4), "\n")
}

print_settings <- function(workers){
 cat("workers:", workers, " tasks:", rf_tasks, " trees per task:", rf_task_trees,
     " training rows:", rf_rows, "\n")
}
