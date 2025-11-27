#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 folder"
	exit 1
fi

folder="$1"

#rm logs/*
rm results/*.txt

./jobCollectData.sh $folder

