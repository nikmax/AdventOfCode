#!/bin/bash

###############################################################################

file="${1:-test.txt}"
total=0
max=0
cell=""
entry="S"
empty_space="."
splitter="^"

SECONDS=0

while read -r line; do
  max="${#line}"
  for (( x=0; x < $max; x++ )); do
    cell="${line:x:1}"
    [[ "$cell" == "$entry" ]] && start=$x
    echo -n "$cell"
  done
  echo
done < $file

echo "starts at position ${start} of ${max}"

echo "============"
echo "Day 7 Part 1"
echo "============"
echo "The beam will be spliti a $total times."
echo "Duration: $SECONDS Seconds"
