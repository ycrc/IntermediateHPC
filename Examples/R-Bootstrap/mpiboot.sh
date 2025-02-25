#!/bin/bash
#SBATCH -N 2 --tasks-per-node=4 --mem=12g

# on grace do this
#module load Apps/R Rpkgs/RMPI Rpkgs/SNOW
# on farnam do this
module load R

mpirun -n 1 R --slave -f mpiboot.R

