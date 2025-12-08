#!/bin/bash

part(){
    local sum
    if [[ "$line2" != "" ]]; then
      for (( col = 0; col < ${#line2}; col++ )); do 
	echo -n " #"
        sum=0
        (( i = col-1 ))
        [[ "$roll" != "${line2:col:1}" ]] && continue
	if (( i >= 0 )); then
	  [[ "$roll" = "${line1:i:1}" ]] && (( sum += weight ))
	  [[ "$roll" = "${line2:i:1}" ]] && (( sum += weight ))
	  [[ "$roll" = "${line3:i:1}" ]] && (( sum += weight ))
	fi
	(( i++ ))
	[[ "$roll" = "${line1:i:1}" ]] && (( sum += weight ))
	[[ "$roll" = "${line3:i:1}" ]] && (( sum += weight ))
	(( i++ ))
	if (( i < ${#line2} )); then
	  [[ "$roll" = "${line1:i:1}" ]] && (( sum += weight ))
	  [[ "$roll" = "${line2:i:1}" ]] && (( sum += weight ))
	  [[ "$roll" = "${line3:i:1}" ]] && (( sum += weight ))
	fi
        (( sum < neighbors )) && (( adding_up++ ))
      done
    fi
    line1=$line2
    line2=$line3
    line3=""
}

steps=0
adding_up=0
neighbors=4
weight=1
roll="@"
line1=""
line2=""

echo "Day 4 Part 1"
echo

while read -r -a line3; do

      (( steps++ ))
    
      echo -n "$steps : $line3"
      part 
      echo

done < <( cat input.txt; echo "")

echo
echo "$adding_up rolls of paper can be accessed by a forklift"
