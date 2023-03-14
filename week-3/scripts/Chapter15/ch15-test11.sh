#!/bin/bash
 # redirecting output to different locations
 exec 2>testerror #sve sto treba u STDERR ide u testerror file
 echo "This is the start of the script"
 echo "now redirecting all output to another location"
 exec 1>testout #STDOUT ide u testout
 echo "This output should go to the testout file"
 echo "but this should go to the testerror file" >&2