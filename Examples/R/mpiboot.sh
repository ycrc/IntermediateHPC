#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --mem=2G
#SBATCH --time=30:00
#SBATCH --output=mpiboot-%j.out
#SBATCH --partition=day

module reset
module load R-bundle-CRAN

# use the course copy of Rmpi if you don't have your own
export R_LIBS_SITE="${R_LIBS_SITE:+$R_LIBS_SITE:}/nfs/roberts/courses/ihpc/R"

# install Rmpi into your own R library if neither has it
Rscript install-packages.R Rmpi || exit 1

srun Rscript mpiboot.R

