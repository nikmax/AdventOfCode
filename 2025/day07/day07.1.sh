#!/bin/bash

sum(){
for (( i=0; i < $max; i++ )); do
  (( total += beams[i] ))
done
}
show(){
  for (( y=0; y < $max; y++ )); do
    (( beams[y] == 0 )) && echo -n " " || echo -n " ${beams[y]}"
  done
}

###############################################################################

file="${1:-test.txt}"
stop="${2:-0}"
total=0
max=0
declare -a beams
num=0

SECONDS=0

while read -r line; do
  max="${#line}"
  for (( x=0; x < $max; x++ )); do
    [[ -n "${beams[x]}" ]] || beams[x]=0
    case "${line:x:1}" in
      "S")
        beams[x]=1
        #(( total++ ))
        continue
        ;;
      "^")
        (( beams[(x-1)]+=beams[x] ))
        (( beams[(x+1)]+=beams[x] ))
        beams[x]=0
        ;;
    esac
  done
  total=0
  sum
  echo -n "$line - "
  echo " # $num : $total"
  (( num++ ))
  (( stop > 0 && num == stop )) && break
done < $file

echo
echo "============"
echo "Day 7 Part 2"
echo "============"
echo "The beam will be split a $total times."
echo "Duration: $SECONDS Seconds"
