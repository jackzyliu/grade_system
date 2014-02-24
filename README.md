README
   
Created on Dec 30, 2013 by Zheyuan Liu

Friendly reminder : All the scripts recognizes the database under the default database name "$191_sample.csv" within the same directory. Please feel free to change the pathname for the database file using the "change_database_name.sh" file. It is recommended to run all the scripts in this directory.

Name: add_student.sh
Usage: ./add_student.sh 
Description: the user should enter relevant information when prompted; the script updates the database with a new row that takes in the student' pennkey, last name, and first name; the student's grades for all the missing assignments are zeros; 
script will notify if the action is successful or if any of three arguments are missing 

Name: remove_student.sh
Usage: ./add_student.sh [pennkey]
Description: with permission, removes a student that matches the pennkey along with all the existing grades
script will notify if the action is successful or if the student is not found

Name: add_an_assignment.sh
Usage: ./add_an_assignment.sh [assignment_label]
Desctiption: updates the database with a new assignment; the user will be prompted to enter the max score for the assignment; all the students' grades for this assignment will be set as 0.
script will notify if the action is successful

Name: add_student_grade.sh
Usage: ./add_student_grade.sh 
Description: the user will be prompted to enter the student's identity key, homework label, and score for the assignment; updates the database with the new assignment score
script will notify if the action is successful or if the student or assignment is not found


Name: get_student_grade.sh
Usage: ./get_student_grade.sh [pennkey]
Description: outputs complete grade information for the selected student including grade total
script will notify user if student is not found

Name: get_all_student_grades.sh
Usage: ./get_all_student_grades.sh 
Description: outputs grade totals for all students in the database
script will notify user if no students found
 
Name: generate_grade_file_for_one.sh
Usage: ./generate_grade_file_for_one.sh [pennkey] [assignment label]
Description: creates a grade report for a given pennkey and assignment. Files will be put in assignment directories with file name: [pennkey]_[assignmentlabel]_grade
script will notifiy user if assignment label or student was not found

Name: generate_grade_file_for_all.sh
Usage:./generate_grade_file_for_all.sh [assignment label]
Description: creates a grade reports for all students for a given assignment. Files will be put in assignment directories with file name: [pennkey]_[assignmentlabel]_grade/
script will notifiy user if assignment label was not found

Name: email_grade_to_one.sh
Usage: ./email_grade_to_one.sh [pennkey] [assignment label]
Desctipion: sends an email to the given student giving them a grade report for the given assignment label
script will notify user if assignment label or student was not found

Name: email_grade_to_all.sh
Usage: ./email_grade_to_all.sh [assignment label]
Description: sends an email to all students in the database giving them a grade report for the given assignment label
script will notify user if assignment label was not found

Name: change_database_name.sh
Usage: ./change_database_name.sh [new database filename]
Description: changes the filename other sh files use to the new database filename

