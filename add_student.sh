#!/bin/bash

filename=./191_sample.csv
#read the categories/assignments
IFS=", " read -a categories <<< $(cat $filename|head -1)
#echo $categories

#create a new student based on the input
echo "Pennkey:"
read pennkey
echo "Last name:"
read lastname
echo "First name:"
read firstname
new_student=$pennkey", "$lastname", "$firstname
#echo $new_student

#check valid input
if [ $pennkey == "" ] || [ $lastname == "" ] || [ $firstname == "" ]
then
    #echo $#
    echo "invalid input"
else
    for str in ${categories[@]}
    do
      #echo $str 
	  	if [[ "$str" == "PENNKEY" ]] || [[ "$str" == "LAST_NAME" ]] || [[ "$str" == "FIRST_NAME" ]]
    	then continue
			else
	    	#add a 0 for every missing homework
	  		new_student=$new_student", 0"
	    	#echo $new_student 
    	fi
    done
    echo $new_student>> $filename
    echo "Student added successfully"
fi

