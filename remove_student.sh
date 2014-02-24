#!/bin/bash

filename=/home/zheyuan/student_grades.csv

#retrieve the pennkeys of all students
count=1
position=0

#check valid input
if [[ "$1" = "" ]]
then
    echo "Usage: ./remove_student.sh pennkey"
		exit 2 
fi

while read line
do
	#read the first column of every row
	i=$( echo $line | cut -f1 -d',' )
	if [[ "$1" != "$i" ]]
  then count=$((count+1))
  else 
  	position=$count
		break
  fi
done < $filename

if [[ "$position" = "0" ]]
then
	echo "Student not found"
else
  echo "The action is irreversible. Are you sure you want to continue? y/n" 
  read yn
  case $yn in
  [Yy]*) sed -i "" "${position}d" $filename; echo "Student removed successfully" ;;
  [Nn]*) echo "Removal unsuccessful" ;;
  *) echo "Invalid input- program terminated" ;;
  esac 
fi

