#!/bin/bash
# Grabbing the last parameter
#
params=$#
echo
echo The last parameter is $params
echo The last parameter is ${!#}
echo
echo In this case script is confusing. It would be better like this:
echo
echo The number of parameters is $params
echo The last parameter is ${!#}