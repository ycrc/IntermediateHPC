#!/bin/bash

#SBATCH --array 1-10
#SBATCH --mem=10g

job=$(printf %03d ${SLURM_ARRAY_TASK_ID})

module load SAMtools BWA; bwa mem ../Data/BWAIndex/genome.fa ../Data/Reads/reads_${job}.fq > Results/out${job}sam && samtools sort -O bam -o Results/out${job}bam Results/out${job}.sam
