#!/bin/bash
#SBATCH --partition=education
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --output=mpi-%j.out

module reset
module load NAMD/3.0.2-foss-2024a-mpi

srun namd3 ../Data/stmv/stmv.namd


