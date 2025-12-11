#!/bin/bash

###############################################################################

file="${1:-test.txt}"
total=0
max=0
entry="S"
splitter="^"
declare -a beams
num=0

SECONDS=0

while read -r line; do
  max="${#line}"
  len="${#beams[@]}"
  if (( len == 0));then
    for (( x=0; x < $max; x++ )); do
      [[ "${line:x:1}" != "$entry" ]] && continue
      beams[0]="$x"
      (( total++ ))
      break
    done
  else
    for (( x = 0; x < len; x++ )); do
      b="${beams[x]}"
      if [[ "${line:b:1}" == "$splitter" ]]; then
        beams[x]="$((b-1))"
        beams+=("$((b+1))")
        (( total++ ))
      fi
    done
  fi
done < $file

echo
echo "============"
echo "Day 7 Part 1"
echo "============"
echo "The beam will be split a $total times."
echo "Duration: $SECONDS Seconds"
