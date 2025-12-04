#!/bin/bash
curl -s -b "session=...." https://adventofcode.com/2023/day/1/input | tr ' ' '\n' | awk ' {gsub(/[^0-9]/,""); a=substr($0,0,1);c=length($0);b=substr($0,c,1);d=a+''+b;sum += d} END {print sum}'
