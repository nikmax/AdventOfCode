#!/usr/bin/env python3
import sys
import time

file = sys.argv[1] if len(sys.argv) > 1 else "test.txt"
stop = sys.argv[2] if len(sys.argv) > 2 else 0
stop = int(stop)
n = 0
show = ""

total = 0
entry = "S"
splitter = "^"
beams = []  # list of column positions

start = time.time()

with open(file, 'r') as f:
    for line_num, line in enumerate(f):
        line = line.rstrip('\n')
        max_len = len(line)
        show = line

        if not beams:
            # First line: find first 'S'
            for x in range(max_len):
                if line[x:x+1] == entry:
                    beams = [x]
                    total += 1  # matches your (( total++ ))
                    break
        else:
            # Process current beams (snapshot length to avoid processing new ones mid-line)
            n = len(beams)
            for i in range(n):
                b = beams[i]
                # Safe substring access: Python returns '' for out-of-range slicing
                if line[b:b+1] == splitter:
                    beams[i] = b - 1          # replace current beam with left
                    beams.append(b + 1)       # add right beam
                    total += 1
        print(f"{line} #{line_num} -  beams: {n}  total: {total}")
        if stop > 0 and line_num == stop:
            break
end = time.time()

print()
print("============")
print("Day 7 Part 1")
print("============")
print(f"The beam will be split a {total} times.")
print(f"Duration: {end - start:.6f} Seconds")
