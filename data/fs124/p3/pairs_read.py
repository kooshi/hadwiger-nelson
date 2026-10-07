#!/usr/bin/env python3
"""FS124-P3: read the second round's reader outputs pair by pair.

Input: data/fs124/e2/out/<object>.txt, the lines "w=(..) labels=.. pattern=(..)
<kind>(x,y) L:side,.. [SEP] ; <kind>(x,y) L:side,.. [SEP]" written by
data/fs124/e2/saves_read.py ([tools], one mind; floats).  This script adds no
geometry: it only groups those lines.  It prints, per object:

  pairs            distinct unordered pairs of members seen at a point inside
  both / one       pairs with two / one common unit points inside
  distances        the distinct distances between the two members (4 decimals)
  partners         histogram: number of distinct partners per member
  points           distinct common unit points, and how many pairs meet at each
  unsaved-point-at-distance  for a pair with one point inside: |w - w'| = 2 sqrt(1 - d^2/4)
  completions      pairs with both points inside for which y = w + w' - x holds
                   (true of every rhombus: printed as the tautology it is)
  beyond-three     members with more than three partners (FS112-C-PARTNERS's
                   bound for a valid map), each with its partners

What it cannot see: pairs neither of whose common unit points is inside the
object (the reader prints none); anything about pieces.  --fault drops the
second member of every line and must print pairs=0.
"""
import math
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path

OUT = Path(__file__).resolve().parents[1] / "e2" / "out"
PT = r"\((-?\d+\.\d+),(-?\d+\.\d+)\)"
LINE = re.compile(r"w=" + PT + r" labels=(\S*) pattern=\((\d), (\d)\) (\w+)" + PT + r" (\S+)( SEP)? ; (\w+)" + PT + r" (\S+)( SEP)?")


def key(x, y, nd=4):
    return (round(float(x), nd) + 0.0, round(float(y), nd) + 0.0)


def read(name, fault=False):
    pairs = defaultdict(set)
    labels = {}
    for line in (OUT / f"{name}.txt").read_text().splitlines():
        m = LINE.search(line)
        if not m:
            continue
        w = key(m.group(1), m.group(2))
        a = key(m.group(7), m.group(8))
        b = key(m.group(12), m.group(13))
        labels[a] = "".join(sorted(s.split(":")[0] for s in m.group(9).split(",")))
        labels[b] = "".join(sorted(s.split(":")[0] for s in m.group(14).split(",")))
        if fault:
            continue
        pairs[frozenset((a, b))].add(w)
    return pairs, labels


def report(name, fault=False):
    pairs, labels = read(name, fault)
    both = [p for p, ws in pairs.items() if len(ws) == 2]
    one = [p for p, ws in pairs.items() if len(ws) == 1]
    dist = Counter()
    partners = defaultdict(set)
    for p in pairs:
        a, b = tuple(p)
        dist[round(math.dist(a, b), 4)] += 1
        partners[a].add(b)
        partners[b].add(a)
    at = Counter()
    for ws in pairs.values():
        for w in ws:
            at[w] += 1
    comp = 0
    for p in both:
        a, b = tuple(p)
        w1, w2 = tuple(pairs[p])
        comp += math.dist((w1[0] + w2[0] - a[0], w1[1] + w2[1] - a[1]), b) < 5e-4
    hist = Counter(len(v) for v in partners.values())
    # the unsaved point of a pair with one common unit point inside lies at
    # 2*sqrt(1 - d^2/4) from the saved one (the rhombus's other diagonal)
    reach = Counter(round(2 * math.sqrt(1 - math.dist(*tuple(q)) ** 2 / 4), 3) for q in one)
    print(f"{name}: pairs={len(pairs)} both={len(both)} one={len(one)} "
          f"distances={dict(sorted(dist.items()))} partners-histogram={dict(sorted(hist.items()))} "
          f"points={len(at)} pairs-per-point={dict(sorted(Counter(at.values()).items()))} "
          f"unsaved-point-at-distance={dict(sorted(reach.items()))} "
          f"(tautology, not evidence: completions={comp}/{len(both)})")
    if "--detail" in sys.argv:
        for m, v in sorted(partners.items()):
            if len(v) > 3:
                print(f"   beyond-three {m} {labels[m]}: " + " ".join(f"{q}{labels[q]}" for q in sorted(v)))
        for w, n in sorted(at.items()):
            print(f"   point {w}: {n} pairs")


if __name__ == "__main__":
    names = [a for a in sys.argv[1:] if not a.startswith("--")] or ["strip", "disk", "capped", "kept", "T2", "BB", "S1", "MX"]
    for n in names:
        report(n, "--fault" in sys.argv)
