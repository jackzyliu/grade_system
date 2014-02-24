#!/bin/bash

filename=/home/zheyuan/student_grades.csv

#the function takes in the line_num and returns the sum of all grades
get_grades(){
	line_num=$1
	IFS=", " read -a max_grades <<< $(awk "NR==$line_num" "$filename")
	max=0
	i=0
	for a in ${max_grades[@]}
	do
		if [[ "$i" = 0 || "$i" = 1 || "$i" = 2 ]]
		then i=$((i+1))
		else 
			i=$((i+1))
			max=$((max+a))
		fi
	done
	
	echo $max
}

#print line by line with each student's pennkey preceding his/her total grade
j=1
max_grade=$(get_grades 2)
while read line
do 
	if [[ "$j" = "1" || "$j" = "2" ]]
	then j=$((j+1))
	else
		key=$(echo $line | cut -f1 -d',')
		echo "$key : $(get_grades $j)/$max_grade"
		j=$((j+1))
	fi
done < $filename
