#!/bin/bash
#SBATCH --cpus-per-task=8  
#SBATCH --mem=4G
#SBATCH --time=10:00
#SBATCH --output=parboot-%j.out

module reset
module load R-bundle-CRAN
Rscript parboot.R
