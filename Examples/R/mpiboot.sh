#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=4
#SBATCH --mem=2G
#SBATCH --time=10:00
#SBATCH --output=mpiboot-%j.out
#SBATCH --roservation=ihpc

module reset
module load R/4.2.0-foss-2020b

srun Rscript mpiboot.R

