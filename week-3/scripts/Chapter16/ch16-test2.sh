#!/bin/bash

# Trapping the script exit; radi i kada se prekine izvrsenje sa ctrl+C

trap "echo Goodbye..." EXIT

count=1
while [ $count -le 5 ]
do
 echo "Loop #$count"
 sleep 1
 count=$(($count + 1))
done