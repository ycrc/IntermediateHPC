#!/bin/bash
#SBATCH --mem=4G
#SBATCH --time=1:00:00
#SBATCH --output=power-%j.out
#SBATCH --partition=day

module reset
module load R-bundle-CRAN

# problem size; keep these the same across power*.sh to compare timings
export SIM_REPS=2000       # t-tests per task
export SIM_TASKS=32        # tasks per (n, effect) cell, 512 tasks in all
export SIM_DATA_MB=200     # size of the shared population

Rscript power.R
