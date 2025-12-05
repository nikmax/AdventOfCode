#!/bin/bash
#

steps=0
adding_up=0

IFS="," read -r -a ranges < input.txt

for range in "${ranges[@]}"; do
  (( steps++ ))

  echo "$steps : $range"

  start=${range%-*}
  end=${range#*-}

  for ((item=start; item<=end; item++)); do
    if [[ $(( ${#item} % 2 )) == 0 ]]; then
      len=${#item}
      half=$((len/2))
      left=${item:0:half}
      right=${item:half}
      [[ "$left" == "$right" ]] && (( adding_up +=item ))
    fi
  done
done

echo "Adding up all the invalid IDs in this case produces $adding_up"
