#!/bin/bash
# demonstrating a multi-position shift
#
echo
echo "The original parameters: $*"
echo
echo Default shift command result: 
shift 
echo "Here's the new first parameter: $1"
echo
echo "The parameters now $*"
echo
echo "Shift with parameter: shift 2 to shift 2 places to the left"
shift 2 #za koliko pozicija zelimo da se siftamo u lijevo
echo "Here's the new first parameter: $1"