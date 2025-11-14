#!/bin/bash

#SBATCH --job-name=callComparator
#SBATCH --mail-type=NONE
#SBATCH --mail-user=s342146@studenti.polito.it
#SBATCH --partition=cpu_sapphire
#SBATCH --time=01:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=logs/simulate.log
#SBATCH --mem-per-cpu=10M

if [[ $# -ne 2 ]]; then
	echo "Usage: $0 folder metric"
	exit 1
fi

folder=$1
metric=$2

./comparator.sh $folder $metric > "./results/${metric}.txt"
