#!/bin/bash

curl -s -b "session=...." https://adventofcode.com/2023/day/3/input |

awk   '
BEGIN {emp=".";p="";sum=0}
{
na=split($0,a,"")                                       # get array of symbols
np=split(p,ap,"")                                       # array of prev set
r=$0;print $0                                           # store for manipulation
for(nm in am){                                          # check first stored numbers
    m=am[nm]; f=af[nm]; l=al[nm]	
    for(i=f;i<=l;i++)                                   # for each stored numbers
        if(a[i]!=emp){print m":b:"a[i];sum=sum+m;break} # check the current(bottom) line for not '.'
    delete am[nm];delete af[nm];delete al[nm]           # delete stored number              
}
of=0                                                    # offset for deleted numbers
while(match(r,/[0-9]+/)){                               # loop throught a line and such a number
    if(RSTART>0){                                       # if found
        m=substr(r,RSTART,RLENGTH)                      # get the number
	l=RSTART+RLENGTH+of                             # l is next pos after number (right)
	f=of+RSTART                                     # f is first pos before number (left)
  	nm=NR"_"f;f--                                   # nm ist a array key for store
	sub(/[0-9]+/,"",r);of+=RLENGTH                  # delete number from input string and calculate for next search
	if(f<1){f=1} else if(a[f]!=emp)                 # if number first of line adjust a first pos for and compare  
            {print m":1:"a[f];sum=sum+m;continue}       #    at the same time left nightbor
	if(l>na){l=na} else if(a[l]!=emp)               # the same, if the number at the end of line ....
            {print m":2:"a[l];sum=sum+m;continue}       #  ...
	if(np>0){                                       # if previous line already exists
	    for (i=f;i<=l;i++) if(ap[i]!=emp)           # check it
		{print m":3:"ap[i];sum=sum+m;break}     # not found '.' add the nummber and leave for loop
	    if(i<=l){continue}                          # and go to the next number	
	}                                               
	am[nm]=m;af[nm]=f;al[nm]=l                      # only '.' found - store the number in array for check with next input line
	print "store: "m" "f" "l" "i" "nm
    }
}
p=$0                                                    # store 'top' line for check with next 'bottom' line numbers
}
END {for(nm in am) print am[nm]":"nm;print "sum: "sum}'  # done!
