#!/bin/bash

###############################################################################

file="${1:-test.txt}"
total=0
max=0
cell=""
entry="S"
empty_space="."
splitter="^"
beam="|"
beams=()
show=""

SECONDS=0

while read -r line; do
  max="${#line}"
  show=""
  for (( x=0; x <= $max; x++ )); do
    cell="${line:x:1}"
    case "$cell" in
      "$entry")
        beams[x]="${beam}"
        ;;
      "$empty_space")
        [[ "${beams[x]}" == "$beam" ]] && cell="$beam"
        ;;
      "$splitter")
        if [[ "${beams[x]}" == "$beam" ]]; then

          beams[x]="$empty_space"
          (( total++ ))
          if (( x > 0 )); then
            (( x-- ))
            beams[x]="$beam"
            show="${show:0:x}${beam}"
            (( x++ ))
          fi
          if (( x < max -1 )); then
            show+="$cell"
            cell="$beam"
            (( x++ ))
            beams[x]="$beam"
          #  cell+="$empty_space"   # (( x-- ))
          fi
           
        fi
        ;;
    esac

    show+="$cell"
  done
  echo "$show $total"
done < $file

echo
echo "============"
echo "Day 7 Part 1"
echo "============"
echo "The beam will be split a $total times."
echo "Duration: $SECONDS Seconds"
