#!/bin/bash

part2(){
    local item="$1"
    local len=${#item}
    local slen=1
    local number j

    while  (( slen < len )); do 
      number=${item:0:slen}
      count=1
      j=$slen
      while (( len > j )); do
        [[ $number != ${item:j:slen} ]] && break
	(( count++ ))
        (( j += slen ))
      done
      if (( len <= j )); then
        [[ $count -gt 1 ]] && (( adding_up += item )) && echo -n " #$item"
        return
      fi
      (( slen++ ))
    done
}

steps=0
adding_up=0
echo

IFS="," read -r -a ranges < input.txt

for range in "${ranges[@]}"; do
      (( steps++ ))
    
      echo -n "$steps : $range"
    
      start=${range%-*}
      end=${range#*-}
    
      for ((item=start; item<=end; item++)); do
          part2 $item
      done
      echo

done

echo
echo "Adding up all the invalid IDs in this case produces $adding_up"
