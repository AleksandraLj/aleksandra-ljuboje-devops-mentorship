#!/bin/bash
# testing two command line parameters
#poziv funkcije $ ./ch14-test2.sh 2 5

total=$(( $1 * $2 )) 
echo The first parameter is $1.
echo The second parameter is $2.
echo The total value is $total.