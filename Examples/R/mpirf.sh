#!/bin/bash
# spread across nodes; raise these past one node's core count to go where multicore cannot
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=4G
#SBATCH --time=20:00
#SBATCH --output=mpirf-%j.out
#SBATCH --partition=day

module reset
module load R
export R_LIBS_USER=/nfs/roberts/courses/ihpc/R

# problem size; keep these the same across the rf jobs to compare timings
export RF_ROWS=50000          # training rows
export RF_TASKS=64            # number of tasks
export RF_TREES_PER_TASK=8    # trees per task, 512 trees in all

srun Rscript mpirf.R
