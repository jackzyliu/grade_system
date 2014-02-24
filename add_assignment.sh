#!/bin/bash

filename=/home/zheyuan/student_grades.csv
#retrieve the first line of file
assignments=$(cat $filename | head -1)
#retrieve the second line
scores=$(sed -n '2p' $filename)

#check valid input
if [[ "$1" = "" ]]
then 
    echo "please type in an assignment"
else
    #check if the assignment already exists
    case $assignments in
	*"$1"*) echo "The assignment already exists." ;;
	*) new_assignments=$assignments", "$1
           #echo $assignments 
           sed -i "1 c\\$new_assignments" $filename
           echo "Max score: "
           read maxscore
           new_scores=$scores", "$maxscore
           sed -i "2 c\\$new_scores" $filename
           while read line
           do
              #echo $line 
              if [[ "$line" != $new_assignments ]] && [[ "$line" != $new_scores ]]
	      then
		  new_line=$line", 0"
		  sed -i "/$line/c \\$new_line" $filename
              fi
           done < $filename 
           echo "Assignment addded successfully"
          
    esac
fi  
