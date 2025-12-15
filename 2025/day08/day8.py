#!/usr/bin/env python3
import sys

DEBUG = True
FILE = sys.argv[1] if len(sys.argv) > 1 else "test.txt"

points = []
distances = []   # enthält Einträge wie [dist, i, j]
circuits = []

# Punkte einlesen
def load_points(filename):
  points = []
  with open(filename) as f:
    for line in f:
      parts = line.strip().split(",")
      if len(parts) == 3:
        points.append([int(parts[0]), int(parts[1]), int(parts[2])])
  return points

# Distanzen berechnen
def compute_distances(points):
  distances = []
  nr = 0
  for i in range(len(points)):
    for j in range(i+1, len(points)):
      x1, y1, z1 = points[i]
      x2, y2, z2 = points[j]
  
      dist = (x1 - x2)**2 + (y1 - y2)**2 + (z1 - z2)**2
  
      if DEBUG:
        print(f"{nr:5d} - {i:3d} {j:3d} # {dist:9.0f}")
  
      distances.append([dist, i, j])
      nr += 1
  return distances

def compute_circuits(points):
  nr = 0
  circuits[0].append(0)
  for d in range(1,len(distances)):
    dist1, a1, b1 = distances[d]
    for c in range(len(circuits)):
      for chain = circuits[c]
      dist2, a2, b2 = distances[chain]
      if len({a1, b1} & {a2, b2}) > 1:
        circuits[]


def main():
    points = load_points(FILE)
    distances = compute_distances(points)
    distances.sort(key=lambda x: x[0])

    if DEBUG:
        for idx, (d, i, j) in enumerate(distances):
            print(f"{idx:5d} - {i:3d} {j:3d} # {d:9.0f}")

if __name__ == "__main__":
    main()

