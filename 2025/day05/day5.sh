#!/bin/bash

is_fresh(){
  local range="$1" id="$2"
  local start end

  start=${range%-*}
  end=${range#*-}

  (( id <= end && id >= start)) && return 0
  return 1
}


file="${1:-test.txt}"
steps=0
adding_up=0
ranges=()
ids=()
block=1
fresh=0

while read -r line; do
  if [[ -z $line ]]; then
    ((block++)) && continue
  fi
  if (( block == 1 )); then
    ranges+=("$line")
  else
    ids+=("$line")
  fi
done < $file

for id in "${ids[@]}"; do
  ((steps++))

  for range in "${ranges[@]}"; do
    echo -n "$steps : $range"
    if is_fresh $range $id; then
      echo " #$id: 1"
	  ((fresh++))
	  break
    else
      echo " #$id: 0"
	fi
  done

done

echo
echo "$fresh of the available ingredient IDs are fresh"
