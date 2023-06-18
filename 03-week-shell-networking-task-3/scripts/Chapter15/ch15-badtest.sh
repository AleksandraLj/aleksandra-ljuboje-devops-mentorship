#!/bin/bash
 # testing closing file descriptors
 
 exec 3> test17file
 echo "This is a test line of data" >&3
 exec 3>&-   #closes fi le descriptor 3, preventing it from being used any more in the script
 echo "This won't work" >&3