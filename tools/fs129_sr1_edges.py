#!/usr/bin/env python3
"""FS129-SR1, item 77: the lane-R edges that come from a "Rests on it: nothing …" sentence, sorted by reading.

Each edge (from -> to) means, in data/fs129/index/edges.csv, "to uses from". Classes (FS129-SR1 record, stage 4):
  real      — `to` (an open statement or a case of it) does rest on `from`
  route     — `from` is a step of a second mind's route to `to` (counted in `to`'s minds); not needed by `to`'s first proof
  false     — `to` does not use `from` (a corrected form, a successor's list, a crossing note, a wider form, a corollary inside a verification)
  reversed  — false as written; the true dependency runs `to -> from`
The script checks every classified edge is present in edges.csv, then removes the false and reversed ones and reports the lane-R cycles
(strongly connected components among all edges) that disappear, and FS121-D4-HOLE's transitive dependents before and after.
Fault: --fault (keep the FS121-D4-HOLE -> FS111-M-PINCH edge) — the report changes.
"""
import csv
import sys
from collections import defaultdict

EDGES = 'data/fs129/index/edges.csv'
SORTED = [
    ('FS111-C-HULL-SO', 'FS111-C-HULL', 'false'),
    ('FS111-M2-DISCK7-AS-PLACED', 'FS111-M2-DISCK7', 'false'),
    ('FS112-Y3-R1', 'FS112-N3-CHAINS', 'false'),
    ('FS114-K1', 'FS114-N7-HUB', 'false'),
    ('FS114-ROUTE-T', 'FS114-N2-LEMMAS', 'reversed'),
    ('FS116-O1-YESLIM', 'FS116-C114-LOCAL-F', 'real'),
    ('FS116-RING-Q', 'FS116-C114-LOCAL-F', 'real'),
    ('FS116-RING-TRANSFER-QC', 'FS116-C114-LOCAL-F', 'real'),
    ('FS116-S1-QF', 'FS116-C114-LOCAL-F', 'real'),
    ('FS116-S1-QF', 'FS116-SAT-STRIP', 'real'),
    ('FS116-SEMI-PAR3', 'FS116-C114-LOCAL-F', 'real'),
    ('FS116-V4-MEET', 'FS116-S1-KAPPA', 'route'),
    ('FS116-V4-OUTER', 'FS116-S1-KAPPA', 'route'),
    ('FS116-V4-PARTNER', 'FS116-S1-KAPPA', 'route'),
    ('FS116-V4-TWIST', 'FS116-S1-KAPPA', 'route'),
    ('FS116-V5-DICHO', 'FS116-N3-SEMI', 'route'),
    ('FS116-V5-LENS', 'FS116-Y3-SIX', 'route'),
    ('FS121-C1-GMAP', 'FS121-D3-GRUNDY', 'false'),
    ('FS121-D1-PENCILWIN', 'FS121-O1-OUT', 'false'),
    ('FS121-D2-PERFIN', 'FS121-D2-SYM', 'reversed'),
    ('FS121-D4-HOLE', 'FS111-M-PINCH', 'false'),
    ('FS121-DB1-L6', 'FS111-M2-INTRAD', 'false'),
    ('FS121-DB1-L7', 'FS121-O1-OUT', 'false'),
    ('FS121-V2-EROSION-DIAM', 'FS121-D1-EROSION', 'false'),
    ('FS121-V2-VT-W', 'FS121-D1-VT', 'false'),
    ('FS121-V3-CPI', 'FS121-V2-SECTOR', 'false'),
]


def sccs(nodes, succ):
    index, low, onstack, stack, out, counter = {}, {}, set(), [], [], [0]
    sys.setrecursionlimit(10000)

    def strong(v):
        index[v] = low[v] = counter[0]; counter[0] += 1
        stack.append(v); onstack.add(v)
        for w in succ[v]:
            if w not in index:
                strong(w); low[v] = min(low[v], low[w])
            elif w in onstack:
                low[v] = min(low[v], index[w])
        if low[v] == index[v]:
            comp = []
            while True:
                w = stack.pop(); onstack.discard(w); comp.append(w)
                if w == v:
                    break
            if len(comp) > 1:
                out.append(tuple(sorted(comp)))
    for v in sorted(nodes):
        if v not in index:
            strong(v)
    return set(out)


def reach(start, succ):
    seen, todo = set(), [start]
    while todo:
        v = todo.pop()
        for w in succ[v]:
            if w not in seen:
                seen.add(w); todo.append(w)
    return seen


def build(edges):
    succ, nodes = defaultdict(set), set()
    for a, b in edges:
        succ[a].add(b); nodes |= {a, b}
    return nodes, succ


def main():
    fault = '--fault' in sys.argv
    rows = [r for r in csv.reader(l for l in open(EDGES) if not l.startswith('#'))][1:]
    edges = {(r[0], r[1]) for r in rows}
    missing = [(a, b) for a, b, _ in SORTED if (a, b) not in edges]
    if missing:
        print('missing from edges.csv:', missing)
        return 1
    drop = {(a, b) for a, b, k in SORTED if k in ('false', 'reversed')}
    if fault:
        drop.discard(('FS121-D4-HOLE', 'FS111-M-PINCH'))
    nodes, succ = build(edges)
    before = {c for c in sccs(nodes, succ) if any(x.startswith(('FS10', 'FS11', 'FS12')) and x[2:5].isdigit() and int(x[2:5]) >= 104 for x in c)}
    dep_before = len(reach('FS121-D4-HOLE', succ))
    nodes2, succ2 = build(edges - drop)
    after = {c for c in sccs(nodes2, succ2) if c in before or any(x.startswith(('FS10', 'FS11', 'FS12')) and x[2:5].isdigit() and int(x[2:5]) >= 104 for x in c)}
    dep_after = len(reach('FS121-D4-HOLE', succ2))
    counts = defaultdict(int)
    for _, _, k in SORTED:
        counts[k] += 1
    broken = sorted(before - after)
    print('edges sorted: %d (real %d, route %d, false %d, reversed %d); lane-R cycles %d -> %d; D4-HOLE dependents %d -> %d'
          % (len(SORTED), counts['real'], counts['route'], counts['false'], counts['reversed'], len(before), len(after), dep_before, dep_after))
    if '--list' in sys.argv:
        for c in broken:
            print('  broken:', ', '.join(c))
        for c in sorted(after):
            print('  remains:', ', '.join(c))
    return 0


if __name__ == '__main__':
    rc = main()
    sys.exit(0 if '--fault' in sys.argv[1:] else rc)
