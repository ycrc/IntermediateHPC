#!/bin/bash
#SBATCH -c 8  
#SBATCH --mem=40g
#SBATCH -t 3:00

module purge
module load R
R CMD BATCH parboot.R
