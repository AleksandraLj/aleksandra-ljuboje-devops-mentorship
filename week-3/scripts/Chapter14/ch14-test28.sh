#!/bin/bash

# reading data from a file. Broji linije u fajlu i ispisuje sadrzaj linije
#
count=1
cat test | while read line
do
 echo "Line $count: $line"
 count=$(($count + 1))
done
echo "Finished processing the file"