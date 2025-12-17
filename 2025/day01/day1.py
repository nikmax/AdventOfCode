#!/usr/bin/python3

import sys

file = sys.argv[1] if len(sys.argv) > 1 else "test.txt"

pos = 50
ans = 0

with open(file, 'r') as f:
  for line in f:
    line = line.rstrip('\n')
    d = line[0]
    amt = int(line[1:])
    if d == 'L':
        pos = (pos-amt+100)%100
    else:
        pos = (pos+amt)%100
    if pos == 0:
        ans += 1
print(ans)
