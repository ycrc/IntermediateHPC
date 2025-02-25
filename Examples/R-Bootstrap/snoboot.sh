#!/bin/bash
#SBATCH -c 8 
#SBATCH --mem-per-cpu=12g

# on grace do this
#module load Apps/R Rpkgs/RMPI Rpkgs/SNOW
# on farnam do this
module load R

R CMD BATCH snoboot.R
