#!/bin/bash
#SBATCH --mem=4G
#SBATCH --time=10:00
#SBATCH --output=boot-%j.out
#SBATCH --partition=education

module reset
module load R-bundle-CRAN/2024.06-foss-2022b
Rscript boot.R
