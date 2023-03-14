#!/bin/bash
# testing grabbing last parameter

#echo The last parameter was ${$#} ne radi! ERROR: To expand via indirection, use arrays, ${!name} or (for sh only) eval.

echo The last parameter was ${!#} is correct way.

