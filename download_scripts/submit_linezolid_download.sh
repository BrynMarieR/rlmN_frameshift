#!/bin/bash
#SBATCH -c 1  # Number of Cores per Task
#SBATCH --mem=8192  # Requested Memory
#SBATCH -t 24:00:00  # Job time limit
#SBATCH -o slurm-%j.out  # %j = job ID

./get_all_linezolid_assemblies.sh BVBRC_linezolid_phenotype_31Jul25_lab_method_biosamples.txt
