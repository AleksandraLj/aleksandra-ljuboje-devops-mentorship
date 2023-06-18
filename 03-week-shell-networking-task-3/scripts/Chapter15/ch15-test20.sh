#!/bin/bash
 # creating a temp file in /tmp. To do this use -t to force mktemp to create dir in /temp/
  
 tempfile=$(mktemp -t tmp.XXXXXX)
 echo "This is a test file." > $tempfile
 echo "This is the second line of the test." >> $tempfile
 echo "The temp file is located at: $tempfile"
 cat $tempfile
 rm -f $tempfile