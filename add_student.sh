#!/bin/bash

#read the categories/assignments
categories=$(cat 191_sample.csv|head -1)
#echo $categories

#create a new student based on the input
new_student=$1", "$2", "$3
#echo $new_student

#check valid input
if [ $# -ne "3" ]
then
    #echo $#
    echo "invalid input"
else
    for str in $categories
    do
        #echo $str 
	if [ "$str" != "PENNKEY," ] || [ "$str" != "LAST_NAME," ] || [ "$str" != "FIRST_NAME," ]
        then 
	    #add a 0 for every missing homework
	    new_student=$new_student", 0"
	    #echo $new_student 
        fi
    done
    echo $new_student>> 191_sample.csv
    echo "Student added successfully"
fi

