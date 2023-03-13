#!/bin/bash
# testing $* and $@
#da vidimo koliko imamo ulaznih parametara kada se koristi $* ili $@
echo
count=1
#
for param in "$*"
do
 echo "\$* Parameter #$count = $param"
 count=$(($count + 1 ))
done
#
echo
count=1
#
for param in "$@"
do
 echo "\$@ Parameter #$count = $param"
count=$(($count + 1 ))
done