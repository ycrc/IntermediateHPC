#!/bin/bash
#SBATCH --partition=day
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4G
#SBATCH --time=10:00
#SBATCH --output=multi-%j.out
#SBATCH --reservation=ihpc

module reset
module load NAMD/2.14-multicore

namd2 +ppn $SLURM_CPUS_PER_TASK ../Data/stmv/stmv.namd 
