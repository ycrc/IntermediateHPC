#!/bin/bash

#SBATCH --mem=20g
#SBATCH --partition=day_amd

module load SAMtools BWA

for i in $(seq 1 10); do
    index=$(printf "%03d" "$i")
    bwa mem ../Data/BWAIndex/genome.fa ../Data/Reads/reads_${index}.fq > Results/out${index}.sam && samtools sort -O bam -o Results/out${index}.bam Results/out${index}.sam
done
