#!/bin/bash

calculate_problems(){
    while read -r -a line; do
        for x in "${!line[@]}"; do
            if [[ ${line[x]} == "+" || ${line[x]} == "*" ]]; then
                total_ops=("${line[@]}")
                continue
            fi
            [[ -z ${total_mul[x]} ]] && (( total_mul[x] = 1 ))
            (( total_mul[x] *= line[x] ))
            (( total_add[x] += line[x] ))
        done
        echo "${line[@]}"
        echo "${total_mul[@]}"
        echo "${total_add[@]}"
        echo
    done < $file
}

calculate_total(){
    for x in "${!total_ops[@]}"; do
        [[ "${total_ops[x]}" == "*" ]] && (( total += total_mul[x] ))
        [[ "${total_ops[x]}" == "+" ]] && (( total += total_add[x] ))
        echo "${total_ops[x]} : $total"
    done
}

###############################################################################

file="${1:-test.txt}"
total=0
total_mul=()
total_add=()
total_ops=()

SECONDS=0

calculate_problems
calculate_total

echo
echo "In this worksheet, the grand total is $total"
echo "Duration: $SECONDS Seconds"
