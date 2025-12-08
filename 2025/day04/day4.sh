#!/bin/bash

part(){
    local line="$1"
    local nbrs="$2"

    echo -n "#"

      for (( col = 0; col < ${#line}; col++ )); do 

        echo -n "${line:col:1}"

      done


    #(( adding_up += joltage )) && echo -n " #$joltage"
}

steps=0
adding_up=0
neighbors=4

echo "Day 3 Part 2"
echo

while read -r -a grid; do

      (( steps++ ))
    
      echo -n "$steps : $grid"
    
      part $grid $neighbors

      echo

done < test.txt

echo
#echo "the total output joltage is $adding_up"
