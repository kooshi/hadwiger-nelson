#!/usr/bin/env python3
"""Scratch: backward reachability in a text LRAT proof -> the original clauses the refutation uses -> the vertex/edge core."""
import sys, json, collections
cnf, lrat, k = sys.argv[1], sys.argv[2], int(sys.argv[3])
clauses = []
with open(cnf) as f:
    hdr = f.readline().split(); nv, nc = int(hdr[2]), int(hdr[3])
    for line in f:
        clauses.append([int(t) for t in line.split()[:-1]])
assert len(clauses) == nc
hints = {}; empty = None
with open(lrat) as f:
    for line in f:
        t = line.split()
        if len(t) > 1 and t[1] == 'd': continue
        cid = int(t[0]); z = t.index('0', 1)
        lits = t[1:z]; hs = [abs(int(h)) for h in t[z+1:-1]]
        hints[cid] = hs
        if not lits: empty = cid
assert empty is not None, "no empty clause"
used = set(); stack = [empty]; seen = set()
while stack:
    c = stack.pop()
    if c in seen: continue
    seen.add(c)
    if c <= nc: used.add(c)
    else: stack.extend(hints[c])
verts = set(); edges = set(); units = []; alo = 0
for c in used:
    cl = clauses[c-1]
    vs = sorted({(abs(l)-1)//k for l in cl})
    verts.update(vs)
    if len(cl) == 1: units.append(cl[0])
    elif all(l > 0 for l in cl): alo += 1
    elif len(vs) == 2: edges.add(tuple(vs))
print(f"original clauses used: {len(used)} of {nc}; derived clauses reached: {len(seen)-len(used)} of {len(hints)}")
print(f"core: {len(verts)} vertices, {len(edges)} edges, {alo} at-least-one clauses, units={units}")
json.dump({"verts": sorted(verts), "edges": sorted(edges), "units": units}, open(lrat + ".core.json", "w"))
