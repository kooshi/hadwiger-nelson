#!/usr/bin/env python3
"""J27D stage 2: exact checks of the stated constructions behind DA-1', DA-2' and GL's colouring (no search).
  A. DA-1': G = C5 with the gapped proper 3-colouring c = (0,1,0,1,2) (vertex 1 misses colour 2), H = K4; beta = c except beta(1, h0) = 2.
     Check beta proper on G x H and not constant on the fibre of vertex 1.  Plant: recolour to a colour seen by N(1) -> must be improper.
  B. DA-2' lemma: in K_k^G a gap-free proper colouring's only neighbour is itself; a gapped one has another neighbour.
     G = K4 (k=4, every colouring gap-free) and G = C5 (k=3, c gapped).
  C. GL's selection gamma(f) = least colour f repeats is a proper k-colouring of E_k(K_k), k = 3, 4.
     Plant: gamma(f) = least colour f misses -> must have a monochromatic edge.
Usage: crunch_j27d_da.py [--plant]"""
import itertools, sys
PLANT = "--plant" in sys.argv
def edges_cycle(n): return [(i, (i+1) % n) for i in range(n)]
def edges_complete(n): return [(i, j) for i in range(n) for j in range(n) if i < j]
def arcs(E): return E + [(v, u) for (u, v) in E]
def adj_exp(f, g, A): return all(f[u] != g[v] for (u, v) in A)   # f ~ g in K_k^G
ok = True
# A
G, H = arcs(edges_cycle(5)), arcs(edges_complete(4))
c = (0, 1, 0, 1, 2); x, b = 1, (1 if PLANT else 2)            # plant: colour 1 = c(x) itself? use a colour in c(N(x)) instead
if PLANT: b = 0                                               # 0 is c(N(1)) = {0}: must break properness
beta = {(v, h): c[v] for v in range(5) for h in range(4)}; beta[(x, 0)] = b
proper = all(beta[(u, h)] != beta[(v, k)] for (u, v) in G for (h, k) in H)
nonpull = len({beta[(x, h)] for h in range(4)}) > 1
print(f"A  DA-1' on C5 x K4: proper={proper} not-pulled-back={nonpull}")
ok &= proper and nonpull
# B
for name, n, E, k, cols in [("K4", 4, edges_complete(4), 4, None), ("C5", 5, edges_cycle(5), 3, [(0, 1, 0, 1, 2)])]:
    A = arcs(E); maps = list(itertools.product(range(k), repeat=n))
    props = [f for f in maps if all(f[u] != f[v] for (u, v) in A)]
    targets = cols if cols else props
    nbrs = {f: [g for g in maps if adj_exp(f, g, A)] for f in targets}
    iso = all(nbrs[f] == [f] for f in targets)
    print(f"B  {name}, k={k}: {len(props)} proper colourings; tested {len(targets)}; each has only itself as neighbour: {iso}")
    ok &= iso if name == "K4" else (not iso)
# C
for k in (3, 4):
    A = arcs(edges_complete(k))
    imp = [f for f in itertools.product(range(k), repeat=k) if len(set(f)) < k]
    gam = {}
    for f in imp:
        rep = [col for col in range(k) if f.count(col) >= 2]
        mis = [col for col in range(k) if col not in f]
        gam[f] = (mis if PLANT else rep)[0]
    mono = sum(1 for f in imp for g in imp if adj_exp(f, g, A) and gam[f] == gam[g])
    nedges = sum(1 for f in imp for g in imp if adj_exp(f, g, A)) // 2
    print(f"C  E_{k}(K_{k}): {len(imp)} vertices, {nedges} edges, monochromatic arcs under gamma: {mono}")
    ok &= (mono == 0)
print("ALL OK" if ok else "FAILED"); sys.exit(0 if ok else 1)
