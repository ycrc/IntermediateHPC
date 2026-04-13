#!/bin/bash

#SBATCH --job-name=alphafold-model
#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --out="slurm-alphafold-model-%j.out"
#SBATCH --time=8:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=80G

module load AlphaFold/3.0.1-20251021-foss-2024a-CUDA-12.6.0

# Select full path to current working directory
RUNDIR=`readlink -f ${PWD}`
mkdir -p ${RUNDIR}

# Edit to specify name of folder containing output from prior MSA run
MSAFOLDER="af_msa"

# Edit to specify name of final output folder for models 
OUTPUT="af_output"

# Enter prefix of output from previous MSA run; e.g., MyPrefix_data.json
# This is usually based on the name: field from your initial input.
MSA="2PV7"

#Edit to specify name of final output folder for models
OUTPUT="${MSA}_output"

mkdir -p ${RUNDIR}/${OUTPUT}

# run alphafold
alphafold \
  --jackhmmer_n_cpu=$((SLURM_CPUS_PER_TASK)) \
  --nhmmer_n_cpu=$((SLURM_CPUS_PER_TASK)) \
  --json_path=${MSAFOLDER}/${MSA}/${MSA}_data.json \
  --model_dir=models \
  --db_dir=$ALPHAFOLD_DATA_DIR \
  --output_dir=${MSA}_output \
  --norun_data_pipeline
