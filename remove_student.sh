#!/bin/bash

#retrieve the pennkeys of all students
count=1
position=0

#check valid input
if [[ "$1" = "" ]]
then
    echo "please type in a pennkey" 
else
    while read line
    do
        #read the first column of every row
        i=$( echo $line | cut -f1 -d',' )
        if [[ "$1" != "$i" ]]
        then 
	    count=$(expr "$count" + 1)
        else 
            position=$(expr "$count" + 0)
            count=$(expr "$count" + 1)
        fi
    done < 191_sample.csv
    if [[ "$position" = "0" ]]
    then
	echo "Student not found"
    else
        echo "The action is irreversible. Are you sure you want to continue? y/n" 
        read yn
        case $yn in
        [Yy]*) sed -i "${position}d" 191_sample.csv; echo "Student removed successfully" ;;
        [Nn]*) echo "Removal unsuccessful" ;;
        *) echo "Invalid input- program terminated" ;;
        esac 
    fi
fi
