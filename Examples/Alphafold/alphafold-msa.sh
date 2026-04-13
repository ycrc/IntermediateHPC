#!/bin/bash

#SBATCH --job-name=alphafold-msa
#SBATCH --partition=day
#SBATCH --out="slurm-alphafold-msa-%j.out"
#SBATCH --time=1-00:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=80G

module load AlphaFold/3.0.1-20251021-foss-2024a-CUDA-12.6.0

# Select full path to working directory
RUNDIR=`readlink -f ${PWD}`

# Edit to specify input folder name containing initial alphafold_input.json
INPUT="af_input"

# Edit to specify output folder name for MSA
MSAFOLDER="af_msa"

mkdir -p ${RUNDIR}/${INPUT}
mkdir -p ${RUNDIR}/${MSAFOLDER}


# run alphafold
  alphafold \
  --jackhmmer_n_cpu=$((SLURM_CPUS_PER_TASK)) \
  --nhmmer_n_cpu=$((SLURM_CPUS_PER_TASK)) \
  --json_path=af_input/fold_input.json \
  --model_dir=models \
  --db_dir=$DB_DIR \
  --output_dir=$MSAFOLDER \
  --norun_inference
