#!/bin/bash

part(){
    local sum
    echo -n "   "
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
	echo -n "$sum"
      done
    fi
    line1=$line2
    line2=$line3
    line3=""
}

file="test.txt"
map=()
steps=0
neighbors=4
weight=1
roll="@"
sum=0

echo "Day 4 Part 1"
echo

while read -r -a line3; do
  map+=("$line3")
done < <( cat $file; echo "")
x=5
while (( 0 != x-- )); do
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
  #(( adding_up = 0 )) && break
done

echo
echo "$sum rolls of paper can be accessed by a forklift"
