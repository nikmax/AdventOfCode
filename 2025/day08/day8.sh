#!/bin/bash

###############################################################################
x=0 y=0 z=0 d=999999999 ind=0
total=0
nr=0
file="${1:-test.txt}"

while IFS=',' read -r -a line; do
  if (( nr == 0 )); then
    x=${line[0]}
    y=${line[1]}
    z=${line[2]}
    (( nr++ ))
    continue
  fi
  (( s = (line[0]-x)**2 + (line[1]-y)**2 + (line[2]-z)**2 )) 
  if (( s < d )); then
    ind=$nr
    d=$s
  fi
  printf "%2d - %3d %3d %3d #%9d\n" "$nr" "${line[@]}" "$d"
  (( nr++ ))
done < $file

echo $ind
#printf "\n==============\n Day 8 part 1 \n==============\n"
#printf "The size of the three largest circuits is %s.\n" $total
