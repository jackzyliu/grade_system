#!/bin/bash

filename=./191_sample.csv
#find the row the selected student is in
look_for_stud () {
local count=1
local position=0   
while read line
do
    #read the first column of every row
    i=$( echo $line | cut -f1 -d',' )
    if [[ "$1" != "$i" ]];then
	count=$(expr "$count" + 1)
    else
	position=$(expr "$count" + 0)
        count=$(expr "$count" + 1)
    fi
done < $filename
   
echo $position
}

#find the number of the col of the assignment
num_col() {
local count=1
local position=0
local assignments=$(cat $filename | head -1)
local temp_var="$1,"
for str in $assignments
do
    if [[ "$str" != "$temp_var" ]] && [[ "$str" != "$1" ]]
    then
        #echo $str 
	count=$(expr "$count" + 1)
    else
        position=$count
	count=$(expr "$count" + 1)
    fi
done

echo $position
}

#read inputs
echo "Pennkey:"
read pennkey
echo "Homework Label:"
read hw

# check valid input
if [[ "$pennkey" = "" ]] || [[ "$hw" = "" ]]
then
    echo "Invalid input"
else
    row_num=$(look_for_stud $pennkey)
    col_num=$(num_col $hw)
    if [[ "$row_num" = 0 ]] || [[ "$col_num" = 0 ]]
    then
	echo "Student or assignment not found"
    else  
        #if both the student and the assignment are found
        student=$(sed -n "${row_num}p" $filename)
        #take user input for the student score
        echo "Score:"
        read student_score
        ctr=0
        array=( )
        for str in $student
        do
            #use a counter to count the col "str" is in
	    ctr=$(expr $ctr + 1)
            if [[ "$ctr" != $col_num ]]
            then
		array=( "${array[@]}" "$str" )
 	    else
                #if we are in the col we want, we check if "str" contains a comma
		case $str
                in
		*",") array=( "${array[@]}" "$student_score," ) ;;
                 *) array=( "${array[@]}" "$student_score" ) ;;
                esac
            fi
        done
        #make the change to the original csv
	new_student=${array[@]}
        sed -i "$row_num c\\$new_student" $filename
	echo "Grade added successfully"
    fi   
fi    



