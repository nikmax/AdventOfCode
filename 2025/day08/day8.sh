#!/bin/bash

###############################################################################
debug=1
total=0
nr=0
file="${1:-test.txt}"
points=()
distances=()
circuits=()
max=0

get_dist(){
  max="${#points[@]}"
  for ((x=0; x < max; x+=3)); do
    for ((y=x+3; y < max; )); do
      z="$y"
      (( a = (points[x+0]-points[y++])**2 ))
      (( b = (points[x+1]-points[y++])**2 ))
      (( c = (points[x+2]-points[y++])**2 ))
      (( s =  a + b + c )) 
      (( debug )) && printf "%5d - %3d %3d # %9d\n" "$nr" "$x" "$z" "$s"
      distances+=("$s" "$x" "$z")
      (( nr++ ))
    done
  done
}
sort_dist(){
  max="${#distances[@]}"
  for ((x=0; x < max; x+=3)); do
    (( n = distances[x+0] ))
    (( c = distances[x+1] ))
    (( d = distances[x+2] ))
    for ((y=x+3; y < max; y+=3)); do
      (( s = distances[y+0] ))
      (( a = distances[y+1] ))
      (( b = distances[y+2] ))
      if (( s < n )); then
        (( distances[x+0] = s))
        (( distances[x+1] = a))
        (( distances[x+2] = b))
        (( distances[y+0] = n ))
        (( distances[y+1] = c ))
        (( distances[y+2] = d ))
        (( n = distances[x+0] ))
        (( c = distances[x+1] ))
        (( d = distances[x+2] ))
      fi
    done
  done

  for ((y=0; y < max; )); do
    (( nr = y / 3 ))
    (( s = distances[y++] ))
    (( a = distances[y++] ))
    (( b = distances[y++] ))
    (( debug )) && printf "%5d - %3d %3d # %9d\n" "$nr" "$a" "$b" "$s"
  done
}

while IFS=',' read -r -a line; do
  points+=("${line[@]}")
done < $file

get_dist
sort_dist

#printf "\n==============\n Day 8 part 1 \n==============\n"
#printf "The size of the three largest circuits is %s.\n" $total
