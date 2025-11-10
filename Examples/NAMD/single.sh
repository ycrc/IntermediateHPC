#!/bin/bash
#SBATCH --partition=day
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=30:00
#SBATCH --output=single-%j.out

module reset
module load NAMD/3.0.2-multicore-AVX512

namd3 ../Data/stmv/stmv.namd 

