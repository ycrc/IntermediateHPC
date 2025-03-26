#!/bin/bash
#SBATCH --partition=day
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=30:00
#SBATCH --output=single-%j.out
#SBATCH --reservation=ihpc

module reset
module load NAMD/2.14-multicore

namd2 ../Data/stmv/stmv.namd 

