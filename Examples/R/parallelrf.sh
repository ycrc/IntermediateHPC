#!/bin/bash
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=20:00
#SBATCH --output=psockrf-%j.out
#SBATCH --partition=day

module reset
module load R-bundle-CRAN

# problem size; keep these the same across the rf jobs to compare timings
export RF_ROWS=50000          # training rows
export RF_TASKS=64            # number of tasks
export RF_TREES_PER_TASK=8    # trees per task, 512 trees in all

Rscript psockrf.R
