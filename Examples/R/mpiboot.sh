#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --mem=2G
#SBATCH --time=30:00
#SBATCH --output=mpiboot-%j.out
#SBATCH --partition=education

module reset
module load R
export R_LIBS_USER=/nfs/roberts/project/ihpc/shared/R

srun Rscript mpiboot.R

