#!/bin/bash

let delta=10

if [[ $# -eq 1 ]]; then
	let delta=$1
fi

while [[ $(squeue --me | wc -l) -ne 1 ]]
do
	echo "$(squeue --me)"
	sleep $delta
done
