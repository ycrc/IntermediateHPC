source("powerfuns.R")
print_settings(1)

# serial version
print(system.time(population <- make_population()))
tasks = make_tasks()

print(system.time(rejects <- lapply(tasks, run_task)))

print(summarize_power(tasks, rejects))
