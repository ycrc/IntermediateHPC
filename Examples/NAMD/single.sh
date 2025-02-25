#!/bin/bash

#SBATCH --partition=admintest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=30:00
#SBATCH --output=single-%j.out

module reset
module load NAMD/2.14-multicore

namd2 stmv.namd 

