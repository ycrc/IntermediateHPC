#!/bin/bash

#SBATCH --job-name=alphafold
#SBATCH --partition=admintest
#SBATCH --out="slurm-alphafold-bad-%j.out"
#SBATCH --time=1-00:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=80G
#SBATCH --gpus=1

module load AlphaFold/3.0.1-20251021-foss-2024a-CUDA-12.6.0

# Select full path to working directory
RUNDIR=`readlink -f ${PWD}`

# Edit to specify input folder name containing initial alphafold_input.json
INPUT="af_input"

#Edit to specify name of final output folder for models
OUTPUT="af_output"

mkdir -p ${RUNDIR}/${INPUT}


# run alphafold
  alphafold \
  --jackhmmer_n_cpu=$((SLURM_CPUS_PER_TASK)) \
  --nhmmer_n_cpu=$((SLURM_CPUS_PER_TASK)) \
  --json_path=${INPUT}/fold_input.json \
  --model_dir=models \
  --db_dir=$DB_DIR \
  --output_dir=$OUTPUT 
