#!/bin/bash

# timing the data entry
#-t option to specify a timer. The -t option specifi es the number of seconds for 
#the read command to wait for input. When the timer expires, the read command returns a 
#non-zero exit status
#
if read -t 5 -p "Please enter your name: " name
then
 echo "Hello $name, welcome to my script"
else
 echo
 echo "Sorry, too slow! "
fi