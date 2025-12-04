#!/bin/bash

curl -s -b "session=...." https://adventofcode.com/2023/day/3/input |


awk   '
BEGIN {emp="*";p="";sum=0}
{
na=split($0,a,"")                                   # get array of symbols
np=split(p,ap,"")                                   # array of prev set

r=$0;print NR"  "$0                                 # store for manipulation
for (pos in a) if(a[pos] == emp)                    # first get all gears in input line 
  {nm=NR"_"pos;gears[nm] = 0;ratios[nm] = 0}        # and store it
of=0                                                # offset for deleted numbers
while(match(r,/[0-9]+/)){                           # loop throught a line and such a number
    if(RSTART>0){                                   # if found
		  m=substr(r,RSTART,RLENGTH)                    # get the number
		  l=RSTART+RLENGTH+of                           # l is next pos after number (right)
		  f=of+RSTART                                   # f is first pos before number (left)
	  	f--                                           # nightbor range f..l
		  sub(/[0-9]+/,"",r);of+=RLENGTH                # delete number from input string and calculate for next search
		  if(f<1){f=1} else if(a[f]==emp)               # is a gear left from number?
			{nm=NR"_"f
			 gears[nm]+=1                                 # increment adjacented part numbers
			 if(ratios[nm]!=0){ratios[nm]*=m} else ratios[nm] = m        # calculate ratios
			 print ratios[nm]":left:"gears[nm]" :"m       # debug
		  }
		  if(l>na){l=na} else if(a[l]==emp)             # is a gear right from number?
			{nm=NR"_"l
			 gears[nm]+=1
			 if(ratios[nm] == 0) {ratios[nm]=m} else ratios[nm] *= m
			 print ratios[nm]":right:"gears[nm]" :"m
		  }
		if(np>0){                                       # loop through a previous line and such a gear
			k=NR-1;	for (i=f;i<=l;i++) if(ap[i]==emp)
				{nm=k"_"i
				gears[nm]+=1
			    if(ratios[nm]!=0){ratios[nm]*=m} else ratios[nm] = m
			    print ratios[nm]":top:"gears[nm]" :"m
			}
		}
	} # if(RSTART>0)
} # while
if(np>0){
	of=0
	while(match(p,/[0-9]+/)){                               # loop through a previous line and such a number
		if(RSTART>0){
			m=substr(p,RSTART,RLENGTH)                      # get the number
			l=RSTART+RLENGTH+of                             # l is next pos after number (right)
			f=of+RSTART                                     # f is first pos before number (left)
		  	f--                                   # nm ist a array key for store
			sub(/[0-9]+/,"",p);of+=RLENGTH                  # delete number from input string and calculate for next search
			if(f<1){f=1} 
			if(l>na){l=na} 
			for (i=f;i<=l;i++) if(a[i]==emp)                 # if number first of line adjust a first pos for and compare  
				{nm=NR"_"i
				 gears[nm]+=1
				 if(ratios[nm]!=0){ratios[nm]*=m} else ratios[nm] = m
				 print ratios[nm]":bottom:"gears[nm]" :"m
			}
		}
	}
}

p=$0                                                    # store "top" line for check with next "bottom" line numbers
}
END {
	for(nm in gears) {
		if(gears[nm] == 2) sum += ratios[nm]
		c+=1
		#print nm": gears: "gears[nm]" ratios: "ratios[nm]
	}
	print "# "c" SUM: "sum
}
'  #input.txt
