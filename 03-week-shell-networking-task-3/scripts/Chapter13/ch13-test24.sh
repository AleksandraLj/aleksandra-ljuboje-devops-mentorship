#!/bin/bash

# piping a loop to another command

echo "------Bez sort komande--------"
 for state in "North Dakota" Connecticut Illinois Alabama Tennessee
 do
    echo "$state is the next place to go"
 done 
 echo "This completes our travels"

 echo "*****Kada proslijedimo izlaz sort komandi*****"
  for state in "North Dakota" Connecticut Illinois Alabama Tennessee
 do
    echo "$state is the next place to go"
 done  | sort
 echo "This completes our travels"
