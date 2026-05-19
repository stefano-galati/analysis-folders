#!/bin/bash

#SBATCH --job-name=manyCollections
#SBATCH --mail-type=NONE
#SBATCH --mail-user=s342146@studenti.polito.it
#SBATCH --partition=cpu_sapphire
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=logs/manyCollections.log
#SBATCH --mem-per-cpu=10M

waiting(){
	delta=30

	while [[ $(squeue --name callComparator | wc -l) -ne 1 ]]
	do
        	echo "$(squeue --name callComparator)"
        	sleep $delta
	done
}

RESFOLDER=../HPC-folders/results

rm -rf results
mkdir results

echo "convolution"
./collectData.sh $RESFOLDER/convolution
waiting
mv results convolution
mkdir results

echo "multiplication"
./collectData.sh $RESFOLDER/multiplication
waiting
mv results multiplication
mkdir results

echo "fft"
./collectData.sh $RESFOLDER/fft
waiting
mv results fft
mkdir results

echo "qsort"
./collectData.sh $RESFOLDER/qsort
waiting 
mv results qsort
mkdir results

echo "dijkstra"
./collectData.sh $RESFOLDER/dijkstra
waiting
mv results dijkstra
mkdir results

echo "Done"
