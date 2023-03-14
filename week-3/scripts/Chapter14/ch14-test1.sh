#!/bin/bash
# using one command line parameter
#poziv funkcije ./ch14-test1.sh 5

factorial=1
for (( number = 1; number <= $1 ; number++ ))
do
 factorial=$((factorial * number))
done
echo The factorial of $1 is $factorial