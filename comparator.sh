#!/bin/bash

if [[ $# -ne 2 ]]; then
	echo "Usage: $0 folder metric"
	echo "Example: $0 matrixIntMult/fl5 simTicks"
	exit 1
fi

folder=$1
stat=$2


find $folder -type f -name "stats.txt" > tmp.txt

while IFS= read -r line; do
	# read the simulation ID (Test1_1_1)
	simId=$(echo "$line" | awk -F'/' '{print $(NF-1)}')
	#echo "$simId"
	
	# MERGED SIM RES CHANGED INTO SIMRES
	# find line in simRes.txt containing simId
	result=$(cat "$folder/simRes.txt" | grep "$simId" | awk '{print $2}')
	
	if [[ $result == *"DUE (infinite loop)"* ]]; then
		result="DUE(inf)"
	elif [[ $result == *"DUE (segmentation fault)"* ]]; then
                result="DUE(seg)"
        elif [[ $result == *"SDC"* ]]; then
                result="SDC"
        elif [[ $result == *"masked"* ]]; then
                result="masked"
	fi

	# find line in stats.txt containing the wanted metric
	statsLine=$(cat $line | grep $stat)
	statValue=$(echo $statsLine | awk '{print $2}')

	if [[ "$statsLine" ]]; then
		echo "$simId;$result;$statValue"
	else
		echo "$simId;$result;no"
	fi

done < tmp.txt
