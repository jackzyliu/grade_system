#!/bin/bash

filename=./191_sample.csv

#check null input
if [[ $1 = "" ]]
then 
	echo "Usage: ./generate_grade_file_for_all.sh assignment_label"
	exit 1
fi

assignment_label=$1

#initialize empty array
pennkeys=()

#read and append all the pennkeys
iterator=0
while read line
do
	if [[ "$iterator" = "0" || "$iterator" = "1" ]]
	then iterator=$((iterator+1))
	else	
		key=$(echo $line | cut -f1 -d',')
		pennkeys=("${pennkeys[@]}" "$key")
	fi
done < $filename

for pennkey in ${pennkeys[@]}
do 
	./generate_grade_file_for_one.sh $pennkey $assignment_label
	if [[ $? != 0 ]]
	then exit 2
	fi
done
