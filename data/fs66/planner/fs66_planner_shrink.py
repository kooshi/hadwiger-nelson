#!/usr/bin/env python3
"""Scratch: iterate 'solve core with LRAT -> backward-reachable core' to a fixpoint. Input/outputs are edge-list JSONs."""
import json, sys, subprocess, os, collections, random
CAD = sorted(__import__('glob').glob(__import__('os').path.expanduser('~/.elan/toolchains/*/bin/cadical')))[-1]  # the toolchain's own CaDiCaL
k = int(sys.argv[2]); d = json.load(open(sys.argv[1])); seed = int(sys.argv[3]) if len(sys.argv) > 3 else 0
V = d["verts"]; E = [tuple(e) for e in d["edges"]]
rnd = 0
while True:
    pos = {v: i for i, v in enumerate(V)}
    adj = collections.defaultdict(set)
    for u, v in E: adj[u].add(v); adj[v].add(u)
    # pin a triangle if there is one (sound: colours are interchangeable)
    if rnd == 0:
        tri = None
        for u, v in E:
            c = adj[u] & adj[v]
            if c: tri = (u, v, min(c)); break
        print("pinned triangle:", tri)
    cl = [[pos[v]*k + c + 1 for c in range(k)] for v in V]
    for (u, v) in E:
        for c in range(k): cl.append([-(pos[u]*k + c + 1), -(pos[v]*k + c + 1)])
    if tri and k >= 3:
        for c, v in enumerate(tri): cl.append([pos[v]*k + c + 1])
    nc = len(cl)
    with open("shrink.cnf", "w") as f:
        f.write(f"p cnf {len(V)*k} {nc}\n"); f.write("".join(" ".join(map(str, c)) + " 0\n" for c in cl))
    r = subprocess.run([CAD, "--lrat", "--no-binary", "-q", f"--seed={seed+rnd}", "shrink.cnf", "shrink.lrat"], capture_output=True, text=True)
    assert r.returncode == 20, f"not UNSAT (rc={r.returncode})"
    hints = {}; empty = None
    for line in open("shrink.lrat"):
        t = line.split()
        if len(t) > 1 and t[1] == 'd': continue
        cid = int(t[0]); z = t.index('0', 1)
        hints[cid] = [abs(int(h)) for h in t[z+1:-1]]
        if z == 1: empty = cid
    used = set(); stack = [empty]; seen = set()
    while stack:
        c = stack.pop()
        if c in seen: continue
        seen.add(c)
        if c <= nc: used.add(c)
        else: stack.extend(hints[c])
    nV = set(); nE = set()
    for c in used:
        vs = sorted({V[(abs(l)-1)//k] for l in cl[c-1]})
        nV.update(vs)
        if len(vs) == 2: nE.add(tuple(vs))
    if tri:  # the pin is sound only while the triangle's edges are in the graph: keep them
        a, b, c3 = tri
        for e in ((a, b), (a, c3), (b, c3)): nE.add(tuple(sorted(e))); nV.update(e)
    rnd += 1
    print(f"round {rnd}: {len(V)} v / {len(E)} e  ->  {len(nV)} v / {len(nE)} e   (lrat {os.path.getsize('shrink.lrat')//1024} KB)", flush=True)
    if len(nV) == len(V) and len(nE) == len(E): break
    V = sorted(nV); E = sorted(nE)
    if rnd >= 40: break
json.dump({"verts": V, "edges": E}, open(sys.argv[1].replace(".json", "") + ".shrunk.json", "w"))
