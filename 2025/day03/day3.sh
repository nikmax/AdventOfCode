#!/bin/bash

part1(){
    local bank="$1"
    local len=${#bank}
    local pref=0
    local bat=$pref
    local post=1
    local bat1 bat2 joltage

    for (( cur = post; cur < len; cur++ )); do 
      [[ ${bank:cur:1} > ${bank:post:1} ]] && post=$cur
      [[ ${bank:bat:1} > ${bank:cur:1} ]] && continue
      [[ ${bank:bat:1} = ${bank:cur:1} ]] && continue
      pref=$bat
      bat=$cur
      post=$bat
      (( post++ ))
    done
    #echo " #$pref:$bat:$post"
    #[[ "$pref" == "$bat" ]] && bat=$post
    bat0=${bank:pref:1}
    bat1=${bank:bat:1}
    bat2=${bank:post:1}
    joltage=$bat1$bat2
    [[ $post = $len ]] && joltage=$bat0$bat1

    (( adding_up += joltage )) && echo -n " #$pref:$bat:$post #$joltage" 
}

steps=0
adding_up=0
echo "Day 3 Part 1"

echo

while read -r -a bank; do

      (( steps++ ))
    
      echo -n "$steps : $bank"
    
      part1 $bank

      echo

done < input.txt

echo
echo "the total output joltage is $adding_up"
