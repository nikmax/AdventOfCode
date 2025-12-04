#!/bin/bash
#
password=0 pointing_at=50 dial=100 steps=0

while IFS= read -r line; do
  (( steps++ ))

  rotation=${line:0:1} 
  distance=${line:1}

  [[ $rotation  == "L" && $pointing_at -ne 0 ]] && (( pointing_at = dial - pointing_at ))

  (( pointing_at = (pointing_at + distance) % dial ))

  [[ $rotation  == "L" && $pointing_at -ne 0 ]] && (( pointing_at = dial - pointing_at ))

  [[ $pointing_at -eq 0 ]] && (( password++ ))

  echo "$steps: $line $pointing_at $password"

  test $1 && if [[ $steps -gt $1 ]]; then  break; fi

done < input.txt

echo "the new password would be $password"
