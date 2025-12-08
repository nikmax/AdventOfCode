#!/bin/bash

part(){
    local bank="$1"
    local deep="$2"
    local len=${#bank}
    local bat=0
    local joltage=""

    while (( deep > 0 )); do

      for (( cur = bat; cur < len - deep + 1; cur++ )); do 
        ((${bank:bat:1} >= ${bank:cur:1} )) && continue
        bat=$cur
      done

      joltage+=${bank:bat:1}

      (( deep-- ))
      (( bat++ ))
      cur=$bat

    done
    (( adding_up += joltage )) && echo -n " #$joltage"
}

deep=12
steps=0
adding_up=0

echo "Day 3 Part 2"

echo

while read -r -a bank; do

      (( steps++ ))
    
      echo -n "$steps : $bank"
    
      part $bank $deep

      echo

done < input.txt

echo
echo "the total output joltage is $adding_up"
