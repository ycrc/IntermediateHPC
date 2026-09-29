#!/bin/bash
#SBATCH --partition=day
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=5G
#SBATCH --time=10:00
#SBATCH --output=multi-%j.out

module reset
module load NAMD/3.0.2-multicore-AVX512

namd3 +ppn $SLURM_CPUS_PER_TASK ../Data/stmv/stmv.namd 
