#!/bin/bash

email_domain=@seas.upenn.edu

#check input
if [[ $1 = "" || $2 = "" ]]
then 
	echo "Usage: ./email_grade_to_one.sh pennkey assignment_label"
	exit 1
fi

pennkey=$1
assignment_label=$2

./generate_grade_file_for_one.sh $pennkey $assignment_label
cat "grade_files/${pennkey}_${assignment_label}_grade" | mail -s "Grade File for $pennkey" "${pennkey}${email_domain}"

