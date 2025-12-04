#!/bin/bash
#

steps=0

IFS="," read -r -a ranges < test.txt

for range in "${ranges[@]}"; do
  (( steps++ ))

  echo "$steps : $range"

  start=${range%-*}
  end=${range#*-}

  for ((item=start; item<=end; item++)); do
    if [[ $(( ${#item} % 2 )) == 0 ]]; then
      echo $item
    fi
  done
done
