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

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 folder"
	exit 1
fi

folder="$1"

while IFS= read -r line; do
	if [[ $line != "---------- Begin Simulation Statistics ----------" ]] && \
   	[[ $line != "---------- End Simulation Statistics   ----------" ]] && \
   	[[ -n $line ]]; then
		stat=$(echo $line | cut -d " " -f 1)
	       	echo $stat
		./callComparator.sh $folder $stat	
	fi
done < statsList.txt

