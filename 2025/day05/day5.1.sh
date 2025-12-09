#!/bin/bash

get_ranges(){
  while read -r line; do
    [[ -n $line ]] && ranges+=("$line") || break
  done < $file
}

set_ranges(){
  local start1 end1 strt2 end2
  local length="${#ranges[@]}"
  for ((x = 0; x < length; x++ )); do
    [[ "${ranges[x]}" == "" ]] && continue 
    for ((y = x+1; y < length; y++ )); do
      [[ "${ranges[y]}" == "" ]] && continue 
      start1=${ranges[x]%-*} end1=${ranges[x]#*-}
      start2=${ranges[y]%-*} end2=${ranges[y]#*-}
      if (( start1 > start2 )); then
	    tmp="${ranges[y]}" ranges[y]="${ranges[x]}" ranges[x]="$tmp"
		start2="${start1}"       end2="${end1}"
        start1="${ranges[x]%-*}" end1="${ranges[x]#*-}"
		(( y = x ))
		continue
	  fi
      (( (end1+1) < start2 )) && continue 
	  (( (end2 > end1) )) && ranges[x]="${start1}-${end2}"
      ranges[y]=""
      (( y = x ))
      continue
    done
  done
}

calc_fresh(){
  local sum start end
  for x in "${!ranges[@]}"; do
    [[ "${ranges[x]}" == "" ]] && continue 
    start=${ranges[x]%-*}
    end=${ranges[x]#*-}
    (( sum = end - start + 1 ))
    echo "$x : ${ranges[x]} # ${sum}"
    (( fresh += sum ))
  done
}

###############################################################################

file="${1:-test.txt}"
ranges=() fresh=0

get_ranges
set_ranges
calc_fresh

echo
echo "$fresh of the available ingredient IDs are fresh"
