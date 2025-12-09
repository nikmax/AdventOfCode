#!/bin/bash
#

steps=0
adding_up=0
ranges=()
ids=()
block=1

while read -r line; do
  if [[ -z $line ]]; then
    ((block++))
  fi
  if (( block == 1 )); then
    ranges+=("$line")
  else
    ids+=("$line")
  fi
done < test.txt

for range in "${ranges[@]}"; do
  ((steps++))

  echo "$steps : $range"

  start=${range%-*}
  end=${range#*-}

  for ((item=start; item<=end; item++)); do
    echo "    $item"
  done
done
