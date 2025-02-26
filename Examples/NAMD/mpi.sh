#!/bin/bash
#SBATCH --partition=day
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4G
#SBATCH --output=mpi-%j.out
#SBATCH --constraint=icelake

module reset
module load NAMD/2.14-foss-2022b-mpi

srun namd2 ../Data/stmv/stmv.namd


