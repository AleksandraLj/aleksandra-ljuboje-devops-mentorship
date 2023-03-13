#!/bin/bash
# testing $* and $@ to grab all the data 
# $* kupi sve ulazne parametre i cuva ih kao jedan string
# $@ kupi sve ulazne parametre i cuva ih kao odvojene objekte sto olaksava iteraciju kroz iste 
echo
echo "Using the \$* method: $*"
echo
echo "Using the \$@ method: $@"