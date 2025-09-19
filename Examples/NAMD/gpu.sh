#!/bin/bash
#SBATCH --partition=education_gpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4G
#SBATCH --gpus=1
#SBATCH --time=10:00
#SBATCH --output=gpu-%j.out

module reset
module load NAMD/3.0.2-foss-2024a-CUDA-12.6.0

# When running CUDA NAMD always add +idlepoll to the command line. This is needed to poll the GPU for results rather than sleeping while idle.

namd3 +idlepoll +ppn $SLURM_CPUS_PER_TASK ../Data/stmv/stmv.namd 

