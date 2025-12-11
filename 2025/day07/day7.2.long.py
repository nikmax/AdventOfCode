#!/usr/bin/env python3
import sys
from collections import defaultdict

def solve(filename):
    with open(filename) as f:
        grid = [line.rstrip('\n') for line in f if line.strip()]

    # Find S in first row
    s_col = None
    for c, ch in enumerate(grid[0]):
        if ch == 'S':
            s_col = c
            break
    if s_col is None:
        raise ValueError("No 'S' found")

    # Part 1: count split events (beams hitting '^')
    beams = [s_col]
    splits = 0

    for row in grid[1:]:
        new_beams = []
        for b in beams:
            if 0 <= b < len(row) and row[b] == '^':
                splits += 1
                new_beams.append(b - 1)
                new_beams.append(b + 1)
            else:
                new_beams.append(b)
        beams = new_beams

    # Part 2: quantum timelines (count multiplicities)
    state = {s_col: 1}
    for row in grid[1:]:
        next_state = defaultdict(int)
        for col, cnt in state.items():
            if 0 <= col < len(row) and row[col] == '^':
                next_state[col - 1] += cnt
                next_state[col + 1] += cnt
            else:
                next_state[col] += cnt
        state = next_state

    timelines = sum(state.values())
    return splits, timelines

if __name__ == "__main__":
    file = sys.argv[1] if len(sys.argv) > 1 else "input.txt"
    part1, part2 = solve(file)
    print("============")
    print("Day 7 Part 1")
    print("============")
    print(f"The beam will be split {part1} times.")
    print()
    print("============")
    print("Day 7 Part 2")
    print("============")
    print(f"Number of timelines: {part2}")
