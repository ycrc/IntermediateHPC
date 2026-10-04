#!/bin/bash
# spread across nodes; raise these past one node's core count to go where multicore cannot
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=2G
#SBATCH --time=20:00
#SBATCH --output=mpipower-%j.out
#SBATCH --partition=day

module reset
module load R
export R_LIBS_USER=/nfs/roberts/courses/ihpc/R

# problem size; keep these the same across power*.sh to compare timings
export SIM_REPS=2000       # t-tests per task
export SIM_TASKS=32        # tasks per (n, effect) cell, 512 tasks in all
export SIM_DATA_MB=200     # size of the shared population

srun Rscript mpipower.R
