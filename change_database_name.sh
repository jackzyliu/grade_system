#!/bin/bash

#check null input
if [[ $1 = "" ]]
then
  echo "Usage: ./change_database_name.sh new_filename"
  exit 1
fi

new_name=$1

#find all the sh files
read -a shfiles <<< $(ls | grep '.sh')

for shfile in ${shfiles[@]}
do
	if [[ "$shfile" = "change_database_name.sh" ]]
	then continue
	else
		sed -i "" "s/filename=.*/filename=$new_name/" $shfile
	fi
done
