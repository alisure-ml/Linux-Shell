#!/bin/bash

a=100
let "a+=1"
echo "a=$a"  # a=101

b=xx3
echo "b=$b"  # b=xx3
declare -i b
echo "b=$b"  # b=xx3

let "b+=1"
echo "b=$b"  # b=1

echo "c=$c"  # c=
let "c+=1"
echo "c=$c"  # c=1

exit 0