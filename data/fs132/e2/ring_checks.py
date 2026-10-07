#!/usr/bin/env python3
"""FS132-E2 — exact checks of derived shapes. No search for a witness: each mode enumerates a finite set the derivation fixed
or evaluates a colouring given by formula.

  ring_checks.py skeleton [--fault]  the label graph K_k with triangles attached, k = 4..7, exact ranks over Q: H_1 of the
                                     full 2-skeleton; whether the 4-cycle 0-1-2-3 bounds in K_6 + {012, 023} and in
                                     K_6 + {012}.  --fault: attach no triangle through the edge 01 (the full skeleton's H_1 is
                                     then not 0).
  ring_checks.py index3 [--fault]    three labels on a ring of N = 6m positions, N = 18, 24, 30: every cyclic sequence with
                                     {c_j, c_j+1} disjoint from {c_j+m, c_j+m+1} for all j (the piecewise-linear loops whose
                                     supports are disjoint under the 60-degree rotation); its degree d = (sum of steps)/3.
                                     Prints the number of sequences and the set of d mod 6.  --fault: only c_j != c_j+m is
                                     asked (changes at j and j+m may be simultaneous).
  ring_checks.py strips [--fault]    sign patterns of the edges of a label cycle of length 3: in how many of the 8 patterns
                                     neither O (labels left after the endpoints of positive edges are removed) nor I (after
                                     the negative ones) is free of cycle labels.  --fault: a cycle of length 4 (16 patterns).
  ring_checks.py hexrel [--fault]    the hexagonal seven-colouring (circumradius 2/5), the unit circle about the vertex
                                     (0, 2/5): the labels on it and on the circles of radii 0.98 and 1.02; its closed walk in
                                     K_7 as an integral 1-chain; the sum of the triangle chains of the honeycomb vertices
                                     inside it; whether the two agree.  --fault: the vertices are counted inside radius 0.75
                                     (the honeycomb vertices within 1 of that vertex are at 0, 0.4, 0.693 and 0.8).
"""
import sys, math, itertools
from fractions import Fraction

fault = "--fault" in sys.argv
mode = sys.argv[1] if len(sys.argv) > 1 else ""


def rank(rows):
    rows = [[Fraction(v) for v in r] for r in rows if any(r)]
    rk, col, ncol = 0, 0, len(rows[0]) if rows else 0
    while rk < len(rows) and col < ncol:
        piv = next((i for i in range(rk, len(rows)) if rows[i][col] != 0), None)
        if piv is None:
            col += 1
            continue
        rows[rk], rows[piv] = rows[piv], rows[rk]
        for i in range(len(rows)):
            if i != rk and rows[i][col] != 0:
                f = rows[i][col] / rows[rk][col]
                rows[i] = [a - f * b for a, b in zip(rows[i], rows[rk])]
        rk += 1
        col += 1
    return rk


def tri_row(t, edges):
    a, b, c = t
    r = [0] * len(edges)
    r[edges[(a, b)]] += 1
    r[edges[(b, c)]] += 1
    r[edges[(a, c)]] -= 1
    return r


def skeleton():
    out = []
    for k in range(4, 8):
        edges = {e: i for i, e in enumerate(itertools.combinations(range(k), 2))}
        tris = [t for t in itertools.combinations(range(k), 3) if not (fault and t[0] == 0 and t[1] == 1)]
        z1 = len(edges) - (k - 1)
        out.append(f"k={k}:H1={z1 - rank([tri_row(t, edges) for t in tris])}")
    k = 6
    edges = {e: i for i, e in enumerate(itertools.combinations(range(k), 2))}
    cyc = [0] * len(edges)
    for a, b, s in ((0, 1, 1), (1, 2, 1), (2, 3, 1), (0, 3, -1)):
        cyc[edges[(a, b)]] += s

    def bounds(ts):
        m = [tri_row(t, edges) for t in ts]
        return rank(m) == rank(m + [cyc])
    out.append(f"4cycle-in-K6+012+023={bounds([(0, 1, 2), (0, 2, 3)])}")
    out.append(f"4cycle-in-K6+012={bounds([(0, 1, 2)])}")
    print(" ".join(out))


def index3():
    out = []
    for N in ((18,) if fault else (18, 24, 30)):   # with the fault the count is 66^m: N = 18 only
        m = N // 6
        c = [0] * N
        res, count = set(), 0

        def ok(j):
            a = {c[j % N], c[(j + 1) % N]}
            b = {c[(j + m) % N], c[(j + m + 1) % N]}
            if fault:
                return c[j % N] != c[(j + m) % N]
            return not (a & b)

        def rec(i):
            nonlocal count
            if i == N:
                if all(ok(j) for j in range(N - m - 1, N)):
                    s = 0
                    for j in range(N):
                        s += {0: 0, 1: 1, 2: -1}[(c[(j + 1) % N] - c[j]) % 3]
                    assert s % 3 == 0
                    res.add((s // 3) % 6)
                    count += 1
                return
            for v in range(3):
                c[i] = v
                if i >= m + 1 and not ok(i - m - 1):
                    continue
                if fault and i >= m and c[i - m] == v:
                    continue
                rec(i + 1)
        rec(0)
        out.append(f"N={N}:sequences={count},d-mod-6={sorted(res)}")
    print(" ".join(out))


def strips():
    ell = 4 if fault else 3
    bad = 0
    for signs in itertools.product((1, -1), repeat=ell):
        O = set(range(ell)) - {v for j in range(ell) if signs[j] > 0 for v in (j, (j + 1) % ell)}
        I = set(range(ell)) - {v for j in range(ell) if signs[j] < 0 for v in (j, (j + 1) % ell)}
        if O and I:
            bad += 1
    print(f"cycle-length={ell} patterns={2 ** ell} neither-side-pure={bad}")


R = 0.4
S3 = math.sqrt(3.0)
U = (S3 * R, 0.0)
W = (S3 * R / 2, 1.5 * R)


def centre(m, n):
    return (m * U[0] + n * W[0], m * U[1] + n * W[1])


def hexcol(z):
    b = z[1] / (1.5 * R)
    a = (z[0] - b * S3 * R / 2) / (S3 * R)
    best = None
    for m in range(math.floor(a) - 1, math.floor(a) + 3):
        for n in range(math.floor(b) - 1, math.floor(b) + 3):
            cx, cy = centre(m, n)
            d = math.hypot(z[0] - cx, z[1] - cy)
            if best is None or d < best[0]:
                best = (d, m, n)
    return (best[1] + 3 * best[2]) % 7


def walk_chain(labels):
    ch = {}
    prev = labels[-1]
    for v in labels:
        if v != prev:
            ch[(prev, v)] = ch.get((prev, v), 0) + 1
        prev = v
    net = {}
    for (a, b), n in ch.items():
        key, s = ((a, b), 1) if a < b else ((b, a), -1)
        net[key] = net.get(key, 0) + s * n
    return {k: v for k, v in net.items() if v}


def hexrel():
    X = (0.0, R)
    own = {hexcol((X[0] + 1e-3 * math.cos(a), X[1] + 1e-3 * math.sin(a))) for a in (-1.57, 0.52, 2.62)}
    K = 400000
    rings = {}
    for rad in (0.98, 1.0, 1.02):
        rings[rad] = [hexcol((X[0] + rad * math.cos(2 * math.pi * (i + 0.5) / K), X[1] + rad * math.sin(2 * math.pi * (i + 0.5) / K)))
                      for i in range(K)]
    ring = walk_chain(rings[1.0])
    crossings = sum(1 for i in range(K) if rings[1.0][i] != rings[1.0][i - 1])
    inside_r = 0.75 if fault else 1.0
    total, nv = {}, 0
    for m in range(-8, 9):
        for n in range(-8, 9):
            cx, cy = centre(m, n)
            for t in range(6):
                ang = math.pi / 2 + t * math.pi / 3
                v = (cx + R * math.cos(ang), cy + R * math.sin(ang))
                if t >= 2:
                    continue                      # each honeycomb vertex is the top or the upper-left corner of one hexagon
                if math.hypot(v[0] - X[0], v[1] - X[1]) < inside_r:
                    nv += 1
                    loop = [hexcol((v[0] + 1e-3 * math.cos(2 * math.pi * (s + 0.5) / 12), v[1] + 1e-3 * math.sin(2 * math.pi * (s + 0.5) / 12)))
                            for s in range(12)]
                    for k2, val in walk_chain(loop).items():
                        total[k2] = total.get(k2, 0) + val
    total = {k2: v for k2, v in total.items() if v}
    labs = {rad: sorted(set(rings[rad]) & own) for rad in rings}
    print(f"own-labels={sorted(own)} ring-labels={sorted(set(rings[1.0]))} own-on-rings={[labs[r] for r in (0.98, 1.0, 1.02)]} "
          f"crossings={crossings} vertices-inside={nv} relation-holds={ring == total}")


{"skeleton": skeleton, "index3": index3, "strips": strips, "hexrel": hexrel}[mode]()
