#!/usr/bin/env python3
import sys

DEBUG = True
FILE = sys.argv[1] if len(sys.argv) > 1 else "test.txt"
max_dists = sys.argv[2] if len(sys.argv) > 2 else 10
max_dists = int(max_dists)

total = 0
points = []
distances = []   # enthält Einträge wie [dist, i, j]
circuits = []


def circuit_stats(circuit, distances):
    counts = {}
    for idx in circuit:
        _, a, b = distances[idx]
        counts[a] = counts.get(a, 0) + 1
        counts[b] = counts.get(b, 0) + 1

    endpoints = [p for p, c in counts.items() if c == 1]
    return endpoints, counts

def format_circuit(circuit, distances):
    parts = []
    for idx in circuit:
        _, a, b = distances[idx]
        parts.append(f"{idx}:({a}-{b})")
    return " -> ".join(parts)

def print_circuits(circuits, distances):
    print("\n==== CIRCUIT DEBUG ====")
    for ci, circuit in enumerate(circuits):
        endpoints, counts = circuit_stats(circuit, distances)

        print(f"Circuit {ci}")
        print(f"  length   : {len(circuit)}")
        print(f"  endpoints: {endpoints}")
        print(f"  chain    : {format_circuit(circuit, distances)}")

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
        print(f"{nr:5d} - {i:3d} {j:3d} # {dist:9.0f} - {(dist**0.5)}")
  
      distances.append([dist, i, j])
      nr += 1
  return distances

def get_endpoints(circuit, distances):
  counts = {}
  for idx in circuit:
    _, a, b = distances[idx]
    counts[a] = counts.get(a,0) + 1
    counts[b] = counts.get(b,0) + 1

  return {p for p,c in counts.items() if c == 1}, counts
 
def used_points(circuits, distances):
    pts = set()
    for circuit in circuits:
        for idx in circuit:
            _, a, b = distances[idx]
            pts.add(a)
            pts.add(b)
    return pts

def endpoints_of(circuit, distances):
    deg = {}
    for idx in circuit:
        _, a, b = distances[idx]
        deg[a] = deg.get(a, 0) + 1
        deg[b] = deg.get(b, 0) + 1
    return {p for p, d in deg.items() if d == 1}

def try_merge_new_chain(circuits, distances):
    if len(circuits) < 2:
        return circuits

    new_chain = circuits[-1]
    new_endpoints = endpoints_of(new_chain, distances)

    for i in range(len(circuits) - 1):
        chain = circuits[i]
        endpoints = endpoints_of(chain, distances)

        # gemeinsamer Endpunkt?
        if new_endpoints & endpoints:
            if DEBUG:
                print("POST-MERGE via", new_endpoints & endpoints)

            merged = chain + new_chain
            circuits[i] = merged
            circuits.pop()   # <-- Chain B entfernen
            return circuits

    return circuits


def compute_circuits(distances,max_dists):
  circuits = []

  for d_idx, (dist, a,b) in enumerate(distances):
    circuits = try_merge_new_chain(circuits, distances)
    if max_dists == 0:
          return circuits
    placed = False
    if DEBUG:
          print(f"{d_idx} - {a:3d} {b:3d} # {dist}")

    for circuit in circuits:
        endpoints, counts = get_endpoints(circuit, distances)

        # stern
        if counts.get(a,0) >= 2 or counts.get(b,0) >= 2:
            if DEBUG:
                print(f"      von der mitte ")
            placed = True
            circuit.append(d_idx)
            max_dists -= 1
            break

        # neue Strecke darf nur an EINEM Endpunkt andocken
        shared = {a,b} & endpoints
        if len(shared) != 1:
            if DEBUG:
                print(f"       nix")
            continue

        circuit.append(d_idx)
        max_dists -= 1
        if DEBUG:
            print(f"       add")
        placed = True


        break

    if placed:
        continue

    # neue Kette nur wenn mind. ein Punkt neu ist
    used = used_points(circuits, distances)
    if a in  used and b in used:
        if DEBUG:
          print(f"       verwerfen")
        continue

    circuits.append([d_idx])
    max_dists -= 1
    if DEBUG:
      print(f"       NEW CHAIN {len(circuits)-1}")


  return circuits

##############################################################################

points = load_points(FILE)
distances = compute_distances(points)
distances.sort(key=lambda x: x[0])

if DEBUG:
    for idx, (d, i, j) in enumerate(distances):
        print(f"{idx:5d} - {i:3d} {j:3d} # {d:9.0f}")

circuits = compute_circuits(distances, max_dists)

if DEBUG:
    #print(f"\nAdded distance {d_idx}: ({a}-{b}) dist={dist}")
    print_circuits(circuits, distances)

circuits.sort(key=len, reverse=True)
total = 1
for ci in circuits[:3]:
    total *= (len(ci) + 1)

print(f"\nThe multiplication of the sizes of the three largest circuits: {total}")

