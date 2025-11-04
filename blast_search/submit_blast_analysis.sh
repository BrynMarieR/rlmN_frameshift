#!/bin/bash
#SBATCH -c 1  # Number of Cores per Task
#SBATCH --mem=8192  # Requested Memory
#SBATCH -t 01:00:00  # Job time limit
#SBATCH -o slurm-%j.out  # %j = job ID

# modules loaded
module load blast-plus/2.14.1

# set up task array
INFILE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" downloaded_assemblies_split.txt)

while read line; do
  # move and unzip the input file
  cp ../linezolid_assemblies/${line}.fa.gz ./blast_results
  gunzip ./blast_results/${line}.fa.gz

  # BLAST database
  makeblastdb -in ./blast_results/${line}.fa -dbtype nucl -title ${line}_Assembly

  # Run jobs
  ./run_blast_analysis.sh ${line}

  # File clean-up
  rm ./blast_results/${line}.fa*
done < ${INFILE}
