#!/bin/bash
#SBATCH --partition=admintest
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH -t 10:00
#SBATCH --output=multi-%j.out

module reset
module load NAMD/2.14-multicore

namd2 +ppn $SLURM_CPUS_PER_TASK stmv.namd 
