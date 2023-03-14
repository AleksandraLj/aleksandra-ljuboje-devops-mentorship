#!/bin/bash
# Test running in the background

#NOTE: When you place the ampersand symbol after a command, it separates the command from 
#the bash shell and runs it as a separate background process on the system. The fi rst thing 
#that displays is the line:
#[1] 3231
#The number in the square brackets is the job number assigned by the shell to the background process. The next number is the Process ID (PID) the Linux system assigns to the 
#process. Every process running on the Linux system must have a unique PID.

#call of script ./ch16-test4.sh &
count=1
while [ $count -le 10 ]
do
 sleep 1
 count=$(($count + 1))
done