#!/bin/bash
input=$(curl -s -b "session=...." https://adventofcode.com/2023/day/2/input | tr -d ' ') # get input and remove all whitespaces


sum=0
for el in "$input"; do
sum=$((sum + 
$(echo $el | awk -F ";" -v red=1 -v green=1 -v blue=1 ' {  # set vars and set field separator ";"
    for (i=1; i<=NF; i++) {                                   # loop throught sets
        sub(/.*:/,"",$i)                                      # on first field remove "Game id,"        
	      split($i,f,",")                                       # create array of sets
        for (k in f){                                         # for each set get cubes and compare throught colors
		        x=index(f[k],"red"); if (x > 0) {x=x-1;y=substr(f[k],1,x); z= y-red; if (z > 0) {red=y} }
		        x=index(f[k],"green"); if (x > 0) {x=x-1;y=substr(f[k],1,x); z= y-green; if (z > 0) {green=y} }
		        x=index(f[k],"blue"); if (x > 0) {x=x-1;y=substr(f[k],1,x); z= y-blue; if (z > 0) {blue=y} }
	      }	
    }
    print red*green*blue
}
')))
done
echo $sum
