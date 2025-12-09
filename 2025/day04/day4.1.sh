#!/bin/bash

part(){
    local sum
    local newline
    echo -n "   "
    if [[ "$line2" != "" ]]; then
      newline="$line2"
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
        if (( sum < neighbors )); then
	      (( adding_up++ ))
	      newline="${newline:0:col}.${newline:col+1}"
	fi
	echo -n "$sum"
      done
      newmap+=("$newline")
    fi
    line1=$line2
    line2=$line3
    line3=""
}

file="input.txt"
map=()
steps=0
neighbors=4
weight=1
roll="@"
sum=0
adding_up=1

echo "Day 4 Part 2"
echo

while read -r -a line3; do
  map+=("$line3")
done < <( cat $file; echo "")

while (( 0 != adding_up )); do
  newmap=()
  line1=""
  line2=""
  adding_up=0
  for row in "${!map[@]}"; do
      line3="${map[$row]}"
      echo -n "$row : $line3"
      part 
      echo
  done
  echo "*** $adding_up"
  (( sum += adding_up ))
  map=()
  newmap+=("\n")
  map=("${newmap[@]}")
done

echo
echo "$sum rolls of paper can be accessed by a forklift"
