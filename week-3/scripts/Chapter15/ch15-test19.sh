#!/bin/bash
 # creating and using a temp file

 tempfile1=$(mktemp test19.XXXXXX)

 exec 3>$tempfile1

 echo "This script writes to temp file $tempfile1"
 echo "This is the first line" >&3
 echo "This is the second line." >&3
 echo "This is the last line." >&3
 exec 3>&-

 echo "Done creating temp file. The contents are:"

 cat $tempfile1

 rm -f $tempfile1 2> /dev/null