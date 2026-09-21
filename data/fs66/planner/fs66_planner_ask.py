#!/usr/bin/env python3
"""Scratch: k-colourability CNF for G_2(p) = UD(Z/p^2,2) or its quotient by an order-p subgroup H of the p-torsion,
with symmetry breaking (pin a maximal clique at the origin; precedence on the remaining colours along BFS order).
usage: ask.py p k [--quot a,b] [--tlim SEC] [--out cnf]   (H = p*(a,b)*Z  inside p*(Z/p^2)^2)"""
import re, sys, argparse, subprocess, time, os, collections
from fs66_planner_g2 import circle

def build(p, quot=None):
    n = p*p
    S = circle(n)
    if quot is None:
        N = n*n
        idx = lambda a, b: (a % n)*n + (b % n)
        verts = [(a, b) for a in range(n) for b in range(n)]
        rep = lambda a, b: (a % n, b % n)
    else:
        ha, hb = quot  # H = { p*t*(ha,hb) : t in Z/p }
        H = [((p*t*ha) % n, (p*t*hb) % n) for t in range(p)]
        def rep(a, b):
            return min(((a + x) % n, (b + y) % n) for x, y in H)
        reps = sorted({rep(a, b) for a in range(n) for b in range(n)})
        pos = {r: i for i, r in enumerate(reps)}
        N = len(reps); verts = reps
        idx = lambda a, b: pos[rep(a, b)]
    adj = [set() for _ in range(N)]
    for i, (a, b) in enumerate(verts):
        for (x, y) in S:
            j = idx(a + x, b + y)
            assert j != i, "loop: H meets S"
            adj[i].add(j)
    return N, verts, adj, idx, S

def cnf(N, adj, k, clique, order):
    cl = []
    X = lambda v, c: v*k + c + 1
    nv = N*k
    for v in range(N):
        cl.append([X(v, c) for c in range(k)])
    for v in range(N):
        for w in adj[v]:
            if v < w:
                for c in range(k):
                    cl.append([-X(v, c), -X(w, c)])
    for c, v in enumerate(clique):
        cl.append([X(v, c)])
    q = len(clique)
    if q < k - 1:
        # precedence: colour c (> q-1... i.e. c >= q+1) may appear at order[i] only if c-1 already used at an earlier vertex
        Y = {}
        def y(i, c):
            nonlocal nv
            if (i, c) not in Y:
                nv += 1; Y[(i, c)] = nv
            return Y[(i, c)]
        for c in range(q, k):  # track usage of colours q..k-1
            for i, v in enumerate(order):
                # y(i,c) <-> y(i-1,c) or X(v,c)
                if i == 0:
                    cl.append([-y(0, c), X(v, c)]); cl.append([y(0, c), -X(v, c)])
                else:
                    cl.append([-y(i, c), y(i-1, c), X(v, c)]); cl.append([y(i, c), -y(i-1, c)]); cl.append([y(i, c), -X(v, c)])
        for c in range(q+1, k):
            for i, v in enumerate(order):
                if i == 0: cl.append([-X(v, c)])
                else: cl.append([-X(v, c), y(i-1, c-1)])
    return nv, cl

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("p", type=int); ap.add_argument("k", type=int)
    ap.add_argument("--quot"); ap.add_argument("--tlim", type=int, default=120); ap.add_argument("--out", default=None)
    ap.add_argument("--nosym", action="store_true")
    a = ap.parse_args()
    quot = tuple(int(t) for t in a.quot.split(",")) if a.quot else None
    t0 = time.time()
    N, verts, adj, idx, S = build(a.p, quot)
    degs = collections.Counter(len(x) for x in adj)
    # maximal clique at origin: greedy
    o = idx(0, 0); clique = [o]
    for w in sorted(adj[o]):
        if all(w in adj[u] for u in clique): clique.append(w)
        if len(clique) == a.k: break
    # BFS order from the clique
    seen = set(clique); order = list(clique); dq = collections.deque(clique)
    while dq:
        v = dq.popleft()
        for w in sorted(adj[v]):
            if w not in seen: seen.add(w); order.append(w); dq.append(w)
    assert len(order) == N, "disconnected"
    if a.nosym: clique = []
    nv, cl = cnf(N, adj, a.k, clique, order)
    out = a.out or f"g2-p{a.p}-k{a.k}-{'full' if quot is None else 'q%d_%d' % quot}.cnf"
    with open(out, "w") as f:
        f.write(f"p cnf {nv} {len(cl)}\n")
        f.write("".join(" ".join(map(str, c)) + " 0\n" for c in cl))
    print(f"p={a.p} k={a.k} quot={quot}: N={N} degrees={dict(degs)} clique={len(clique)} vars={nv} clauses={len(cl)} build={time.time()-t0:.1f}s", flush=True)
    cad = sorted(__import__('glob').glob(__import__('os').path.expanduser('~/.elan/toolchains/*/bin/cadical')))[-1]  # the toolchain's own CaDiCaL
    t1 = time.time()
    r = subprocess.run([cad, "-t", str(a.tlim), out], capture_output=True, text=True)
    dt = time.time() - t1
    verdict = {10: "SAT", 20: "UNSAT"}.get(r.returncode, f"UNKNOWN(rc={r.returncode})")
    stats = [l for l in r.stdout.splitlines() if re.search(r"^c (conflicts|decisions|propagations|total process time|maximum resident)", l)]
    print(f"   cadical: {verdict} in {dt:.1f}s", flush=True)
    for l in stats: print("     ", l)
    if r.returncode == 10:
        model = set()
        for line in r.stdout.splitlines():
            if line.startswith("v "):
                model.update(int(t) for t in line.split()[1:] if int(t) > 0)
        col = [next(c for c in range(a.k) if v*a.k + c + 1 in model) for v in range(N)]
        bad = sum(1 for v in range(N) for w in adj[v] if col[v] == col[w])
        print(f"   verified proper: {bad == 0} (monochromatic directed edges={bad}); class sizes={sorted(collections.Counter(col).values())}")
        import json; json.dump({"p": a.p, "k": a.k, "quot": quot, "verts": verts, "col": col}, open(out + ".col.json", "w"))
if __name__ == "__main__":
    main()
