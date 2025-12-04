#!/bin/bash
input=$(curl -s -b "session=...." https://adventofcode.com/2023/day/1/input) 

#
#
######################
# print a digit if   #
# recognized in args #
######################
function get_digit(){
   echo $1 | awk '
   	BEGIN { split("one two three four five six seven eight nine",n," ")}
      	{for (i=1; i<10; i++) { if ( substr($0,1,1) == i || index($0,n[i]) == 1 ) { print i; break } } } '
}
sum=0
for el in "$input"; do #  $@; do       # get item from array in $el
  echo -e "*"                          # simplest show progress
  w1=0                                 # first digit
  for (( i = 0; i < ${#el}; i++ ));    # pass through  from begin vfoneb18nnlcc9: v.vf.vfo.vfon.....
  do
    w1=$(get_digit ${el:$i})           # found a digit in a substring?
    test -n "$w1" && break             # yes - done !
  done
  w2=0                                 # last digit
  for (( i = ${#el}-1; i >= 0; i-- )); # pass through from end vfoneb18nnlcc9: 9.c9.cc9.lcc9.nlcc9..
  do 
    w2=$(get_digit ${el:$i});          # found a digit in a substring?
    test -n "$w2" && break             # yes - done !
  done
  sum=$((sum+=w1*10+w2))               # calculate sum 
done
echo
echo "Sum: "$sum
