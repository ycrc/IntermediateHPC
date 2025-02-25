#!/bin/bash
#SBATCH --partition=admintest
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --output=mpi-%j.out

module reset
module load NAMD/2.14-foss-2022b-mpi

srun namd2 stmv.namd


