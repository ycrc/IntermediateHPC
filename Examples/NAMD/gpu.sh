#!/bin/bash
#SBATCH --partition=gpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=4G
#SBATCH --gpus=1
#SBATCH --time=10:00
#SBATCH --output=gpu-%j.out
#SBATCH --reservation=ihpc_gpu

module reset
module load NAMD/2.14-fosscuda-2020b

# When running CUDA NAMD always add +idlepoll to the command line. This is needed to poll the GPU for results rather than sleeping while idle.

namd2 +idlepoll +ppn $SLURM_CPUS_PER_TASK ../Data/stmv/stmv.namd 

