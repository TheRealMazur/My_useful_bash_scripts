#!/usr/bin/env bash

# Define a timestamp function
timestamp() {
  date +"%T"
}

if [[ -z "$1" ]]; then
  echo "Please specify a process name as a parameter!"
  exit 0
else
	pid=$(pgrep $1| awk 'NR==1{print}')
	if [[ -z $pid ]]; then
	echo "Process not found!"
	exit 0
	fi
fi
echo "Pid found: $pid"
lastmem=$(ps -v -p $pid | awk 'END{print $8}')
difference=0
echo -e $(timestamp)"\t"$lastmem" KB"
while true; do
	mem=$(ps -v -p $pid | awk 'END{print $8}')
	if [[ $mem != $lastmem ]]; then
	difference=$(($mem - $lastmem))
	echo -e $(timestamp)"\t"$mem" KB\tDifference: "$difference
	lastmem=$mem
	sleep 0.5
	fi
done
	