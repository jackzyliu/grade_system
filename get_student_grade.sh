#!/bin/bash

#check valid input
if [[ "$1" = "" ]]
then 
	echo "Usage: ./get_student_grade.sh pennkey"
	exit 1
fi

filename=191_sample.csv
pennkey=$1

#read the list headers / categories
IFS=", " read -a categories <<< $(awk 'NR==1' "$filename")
IFS=", " read -a max_grades <<< $(awk 'NR==2' "$filename")


#read from file to find the line of the student with the given pennkey
line_num=0;
iterator=0;
while read line
do
	#read tge first column of every row
	key=$(echo $line | cut -f1 -d',' )
	if [[ "$pennkey" != "$key" ]]
	then iterator=$((iterator+1))
	else 	
		iterator=$((iterator+1))
		line_num=$iterator
	fi
done < $filename

#main
if [[ $line_num = "0" ]]
then 
	echo "Student not found"
	exit 2
else
	IFS=", " read -a student <<< $(awk "NR==${line_num}" "$filename")
	i=0
	sum=0;
	max=0;
	for header in ${categories[@]}
	do
		if [[ "$i" = "0" || "$i" = "1" || "$i" = "2" ]]
		then 
			echo "$header : ${student[$i]}" 
			i=$((i+1))
		else
			echo "$header : ${student[$i]}/${max_grades[$i]}"
			sum=$((sum+${student[$i]}))
			max=$((max+${max_grades[$i]}))
			i=$((i+1))
		fi
	done
	echo "total: $sum/$max"
fi
