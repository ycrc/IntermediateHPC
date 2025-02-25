#!/bin/bash
#SBATCH --mem=40g

module purge
module load R
/usr/bin/time -a R CMD BATCH boot.R
