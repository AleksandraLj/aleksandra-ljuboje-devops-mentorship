#!/bin/bash

#testing the nice command

#više o nice komandi u shell-scripting-notes.md

#run this in terminal
nice -n 10 ./ch16-test4.sh > test6.out &
#then use 
ps -p your-PID -o pid,ppid,ni,cmd 