#!/bin/bash

filename=/home/zheyuan/student_grades.csv
directory=grade_files

#check valid input
if [[ "$1" = "" || "$2" = "" ]]
then
	echo "Usage: ./generate_grade_file_for_one.sh pennkey assignment_label"
	exit 1
fi

pennkey=$1
assignment_label=$2

IFS=", " read -a assignments <<< $(awk 'NR==1' "$filename")

#find the position of the assignment label in the header array
find_assignment_position(){
	iterator=0
	position=0
	for a in ${assignments[@]}
	do
		if [[ "$iterator" = "0" || "$iterator" = "1" || "$iterator" = "2" ]]
		then iterator=$((iterator+1))
		else
			if [[ "$a" = "$assignment_label" ]]
			then 			
				position=$iterator
				break
			else iterator=$((iterator+1))
			fi
		fi
	done
	
	echo $position
}

#main
i=$(find_assignment_position)

#check if exist
if [[ "$i" = "0" ]]
then 
	echo "Assignment not found"
	exit 2
else
	IFS=", " read -a max_grades <<< $(awk 'NR==2' "$filename")
	max_grade=${max_grades[$i]}
	assignment=${assignments[$i]}
fi

#find student
line_num=0
iterator=0
while read line
do 
	#read the first column of every row
	key=$(echo $line | cut -f1 -d',' )
	if [[ "$pennkey" != "$key" ]]
	then iterator=$((iterator+1))
	else
		iterator=$((iterator+1))
		line_num=$iterator
		break	
	fi
done < $filename

if [[ "$line_num" = "0" ]]
then 
	echo "Student not found"
	exit 2
else
	IFS=", " read -a student <<< $(awk "NR==${line_num}" "$filename")
	#format: last_name, first_name (pennkey)
	student_info="${student[1]},${student[2]} (${student[0]})"
	student_grade=${student[$i]}
fi

if [[ -e "$directory" ]] 
then 
	echo $student_info > "$directory/${pennkey}_${assignment_label}_grade"
	echo "$assignment : $student_grade/$max_grade" >> "$directory/${pennkey}_${assignment_label}_grade"
else 
	mkdir $directory
	echo $student_info > "$directory/${pennkey}_${assignment_label}_grade"
	echo "$assignment : $student_grade/$max_grade" >> "$directory/${pennkey}_${assignment_label}_grade"
fi	
