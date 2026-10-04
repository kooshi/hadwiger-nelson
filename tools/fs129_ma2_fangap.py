#!/usr/bin/env python3
"""FS129-MA2 exact controls for the Falconer-fan family at one colour below (FS129-MA2-FALC-DICHO, FS129-MA2-FALC-GAP4).

Two checks, each exact over a set the derivation fixes (no search for a witness):

  gamma7   -- the kernel's four-colouring of the plane over F_7 (Instances/PlaneFreedom.lean: c(x, y) = circ7Table[projAlong (1, 2) (x, y)] = circ7Table[y - 2x],
              circ7Table = [0,1,2,0,1,2,3]) is proper on UD(F_7, 2), and some vertex has a colour absent from its closed
              neighbourhood (so, by translation, every vertex is gapped in some translate). Prints the counts.
  gapk K N -- the statements at K colours, on every labelled graph T with N vertices: for the unit rhombus H (apex a, tip t;
              a Falconer fan at four colours), (i) H is a fan at K = 4 (checked); (ii) no graph homomorphism rho: H -> T and
              proper (K-1)-colouring of T has a colour absent from N_T[rho(t)]  (GAP at K);  (iii) chi(H) >= K - 1, and if
              chi(H) = K - 1 then every proper (K-1)-colouring of H gives a and t one colour (DICHO at K). Prints the number
              of violations (expected 0).

Faults:  gamma7 --fault  plants an improper table ([0,1,2,0,1,2,0]: entries 6 and 0 are adjacent and equal);
         gapk  --fault   reads the gap on the OPEN neighbourhood N_T(rho(t)) instead of the closed one.
"""
import itertools
import sys

FAULT = "--fault" in sys.argv
args = [a for a in sys.argv[1:] if not a.startswith("--")]


def gamma7():
    p = 7
    circle = [(x, y) for x in range(p) for y in range(p) if (x * x + y * y) % p == 1]
    assert len(circle) == p + 1, circle
    table = [0, 1, 2, 0, 1, 2, 0] if FAULT else [0, 1, 2, 0, 1, 2, 3]
    col = {(x, y): table[(y - 2 * x) % p] for x in range(p) for y in range(p)}
    pts = list(col)
    improper = sum(1 for v in pts for (dx, dy) in circle
                   if col[v] == col[((v[0] + dx) % p, (v[1] + dy) % p)])
    gapped = 0
    for v in pts:
        closed = {col[v]} | {col[((v[0] + dx) % p, (v[1] + dy) % p)] for (dx, dy) in circle}
        if len(closed) < 4:
            gapped += 1
    print(f"circle points {len(circle)}; improper ordered pairs {improper}; gapped vertices {gapped} of {len(pts)}")
    print(f"proper={improper == 0} gapped={gapped}/{len(pts)}")


def proper_colourings(n, edges, k):
    for c in itertools.product(range(k), repeat=n):
        if all(c[u] != c[v] for (u, v) in edges):
            yield c


def gapk(K, N):
    # the unit rhombus: a=0, b=1, c=2, t=3; edges ab, ac, bc, bt, ct; t not adjacent to a
    H_n, H_edges, a, t = 4, [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3)], 0, 3
    # (i) fan at K: every proper K-colouring of H - a in which N(a) avoids two colours c1, c2 gives t one of them
    Na = {v for (u, v) in H_edges if u == a} | {u for (u, v) in H_edges if v == a}
    rest = [v for v in range(H_n) if v != a]
    rest_edges = [(u, v) for (u, v) in H_edges if a not in (u, v)]
    fan_ok = True
    for c in itertools.product(range(K), repeat=len(rest)):
        cc = dict(zip(rest, c))
        if any(cc[u] == cc[v] for (u, v) in rest_edges):
            continue
        for c1, c2 in itertools.combinations(range(K), 2):
            if all(cc[v] not in (c1, c2) for v in Na) and cc[t] not in (c1, c2):
                fan_ok = False
    # (iii) DICHO at K on H itself
    chiH = next(k for k in range(1, H_n + 1) if any(True for _ in proper_colourings(H_n, H_edges, k)))
    dicho_bad = int(chiH < K - 1)
    if chiH == K - 1:
        dicho_bad += sum(1 for c in proper_colourings(H_n, H_edges, K - 1) if c[a] != c[t])
    # (ii) GAP at K on every labelled graph with N vertices
    pairs = list(itertools.combinations(range(N), 2))
    violations = 0
    graphs = 0
    for mask in range(1 << len(pairs)):
        edges = [pairs[i] for i in range(len(pairs)) if mask >> i & 1]
        adj = [set() for _ in range(N)]
        for (u, v) in edges:
            adj[u].add(v)
            adj[v].add(u)
        # vertices that are rho(t) for some homomorphism rho: H -> T
        tips = set()
        for img in itertools.product(range(N), repeat=H_n):
            if all(img[v] in adj[img[u]] for (u, v) in H_edges):
                tips.add(img[t])
        if not tips:
            continue
        graphs += 1
        for c in proper_colourings(N, edges, K - 1):
            for w in tips:
                nb = {c[x] for x in adj[w]} if FAULT else {c[w]} | {c[x] for x in adj[w]}
                if len(nb) < K - 1:
                    violations += 1
    print(f"fan at {K}: {fan_ok}; chi(H) = {chiH}; DICHO violations {dicho_bad}; graphs with a homomorphism from H: {graphs}")
    print(f"K={K} N={N} violations={violations + dicho_bad + (0 if fan_ok else 1)}")


if __name__ == "__main__":
    if args[0] == "gamma7":
        gamma7()
    elif args[0] == "gapk":
        gapk(int(args[1]), int(args[2]))
    else:
        sys.exit("usage: fs129_ma2_fangap.py gamma7 [--fault] | gapk K N [--fault]")
