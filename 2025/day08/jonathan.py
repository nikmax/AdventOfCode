#!/usr/bin/python3
import sys
from functools import cache
from collections import defaultdict, Counter, deque

D = sys.stdin.read()

P = []
for line in D.splitlines():
    x,y,z = [int(x) for x in line.split(',')]
    P.append((x,y,z))

D = []
for i,(x1,y1,z1) in enumerate(P):
    for j,(x2,y2,z2) in enumerate(P):
        distance = (x1-x2)**2 + (y1-y2)**2 + (z1-z2)**2
        if i<j:
            D.append((distance, i, j))
D = sorted(D)

for a,b,c in D:
    print(f"  {a:9} # {b:3} -{c:3}")

UF = {i: i for i in range(len(P))}

def find(x):
    if x==UF[x]:
        return x
    UF[x] = find(UF[x])
    return UF[x]

def mix(x,y):
    UF[find(x)] = find(y)

for _d,i,j in D[:10]:
    mix(i,j)

SZ = defaultdict(int)
for x in range(len(P)):
    SZ[find(x)] += 1

S = sorted(SZ.values())
print(S[-1]*S[-2]*S[-3])

clusters = defaultdict(list)
for x in range(len(UF)):
    clusters[find(x)].append(x)

for root, nodes in clusters.items():
    print(root, ":", nodes)
