#!/bin/bash
#SBATCH --mem=8G
#SBATCH --time=1:00:00
#SBATCH --output=rf-%j.out
#SBATCH --partition=day

module reset
module load R-bundle-CRAN

# problem size; keep these the same across the rf jobs to compare timings
export RF_ROWS=50000          # training rows
export RF_TASKS=64            # number of tasks
export RF_TREES_PER_TASK=8    # trees per task, 512 trees in all

Rscript rf.R
