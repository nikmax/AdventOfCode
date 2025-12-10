#!/bin/bash

calculate_problems(){
    local digit
    while IFS= read -r line; do
        for (( x=0; x < ${#line}; x++ )); do
            digit="${line:x:1}"
            [[ $digit == " " ]] && continue
            if [[ $digit == "+" || ${line:x:1} == "*" ]]; then
                total_ops="${line}"
                break
            fi

            if [[ -z ${total_mul[x]} ]]; then
                (( total_mul[x] = digit ))
            else
                (( total_mul[x] *= 10 ))
                (( total_mul[x] *= digit ))
            fi
            (( total_add[x] *= 10 ))
            (( total_add[x] += digit ))
        done
        echo "  : ${line}"
        #echo "* : ${total_mul[@]}"
        #echo "+ : ${total_add[@]}"
        #echo
    done < $file
}

calculate_total(){
    local operator op sum
    sum=0
    for x in ${!total_add[@]}; do
        op="${total_ops:x:1}"
        if [[ "$op" == "*" || "$op" == "+" ]]; then
            operator=$op
            (( total += sum ))
            (( total > 0 )) && echo " # ${sum} : ${total}"
            (( sum = total_add[x] ))
            echo -n "$x : $operator : $sum" 
            continue
        fi
        echo -n ",${total_add[x]}"
        [[ "${operator}" == "*" ]] && (( sum *= total_add[x] ))
        [[ "${operator}" == "+" ]] && (( sum += total_add[x] ))
    done
    (( total += sum ))
    echo " # ${sum} : ${total}"
}

###############################################################################

file="${1:-test.txt}"
total=0
total_add=()
total_ops=""

SECONDS=0

calculate_problems
echo "${total_add[@]}"
echo "${total_ops}"
echo "calulate total ..."
calculate_total

echo "============"
echo "Day 6 Part 2"
echo "============"
echo "In this worksheet, the grand total is $total"
echo "Duration: $SECONDS Seconds"
