#!/bin/bash
#SBATCH --mem=4G
#SBATCH --time=10:00
#SBATCH --output=boot-%j.out
#SBATCH --reservation=ihpc

module reset
module load R-bundle-CRAN
Rscript boot.R
