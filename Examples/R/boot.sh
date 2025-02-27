#!/bin/bash
#SBATCH --mem=4G
#SBATCH --time=10:00
#SBATCH --output=boot-%j.out

module reset
module load R-bundle-CRAN
Rscript boot.R
