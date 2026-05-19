#!/bin/bash

if [[ $# -ne 2 ]]; then
	echo "Usage: $0 folder metric"
	echo "Example: $0 resultsFolder/matrixMultiplication simTicks"
	exit 1
fi

folder=$1
stat=$2


find $folder -type f -name "stats.txt" > tmp.txt

while IFS= read -r line; do
	# read the simulation ID (Test1_1_1)
	simId=$(echo "$line" | awk -F'/' '{print $(NF-1)}')
	#echo "simId = $simId"
	
	# find line in mergedSimRes.txt containing simId
	result=$(cat "$folder/mergedSimRes.txt" | grep "^$simId>" | cut -d ">" -f 2)
	#echo $result	
	if [[ $result == *"DUE (infinite loop)"* ]]; then
		result="DUE(inf)"
	elif [[ $result == *"DUE"* ]]; then
                result="DUE"
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
