#!/bin/bash

get_worksheet(){
  while read -r line; do
    problems+=("$line")
  done < $file
}

show_problems(){
  for x in "${!problems[@]}"; do
    echo "$x : ${problems[x]}"
  done
}

###############################################################################

file="${1:-test.txt}"
problems=()
total=0

get_worksheet
show_problems

echo
echo "In this worksheet, the grand total is $total"
