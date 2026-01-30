#!/bin/bash
#SBATCH --mem=4G
#SBATCH --time=20:00
#SBATCH --output=boot-%j.out
#SBATCH --partition=education

module reset
module load R-bundle-CRAN
Rscript boot.R
