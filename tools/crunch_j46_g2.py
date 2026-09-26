#!/usr/bin/env python3
"""Crunch job J46, stage 3: an independent exact check of J45's G2-11 statement (read as a statement only).

Gamma_7 = UD(F_7, 2): vertices F_7^2, (x,y) ~ (x',y') iff (x-x')^2 + (y-y')^2 = 1 in F_7 (8 unit vectors, q = 7 = 3 mod 4).
gamma(x, y) = floor(4k/7), k = 2x + 3y mod 7 ("C9's colouring").  Checks, by complete evaluation of this one fixed colouring (not a search):
  (a) gamma is proper;
  (b) the gapped vertices (closed neighbourhood misses a colour) and their missing colours;
  (c) whether two ADJACENT gapped vertices share a missing colour (hypothesis (G2));
  (d) whether Zbar = {k = 0} is independent and every point of it is gapped with missing colour 3 (F2's recoloured set).
Plant: one vertex recoloured to a neighbour's colour must make (a) fail.  Exit 0 iff (a) holds, the plant fires, and the printed facts
are those asserted below.
"""
import sys

P = 7
V = [(x, y) for x in range(P) for y in range(P)]
UNIT = [(a, b) for a in range(P) for b in range(P) if (a * a + b * b) % P == 1]


def nbrs(v):
    return [((v[0] + a) % P, (v[1] + b) % P) for a, b in UNIT]


def colouring():
    return {(x, y): (4 * ((2 * x + 3 * y) % P)) // P for x, y in V}


def proper(col):
    return all(col[v] != col[w] for v in V for w in nbrs(v))


def main():
    assert len(UNIT) == 8, UNIT
    col = colouring()
    ok_proper = proper(col)
    planted = dict(col)
    v0 = (0, 0)
    planted[v0] = col[nbrs(v0)[0]]
    plant_fires = not proper(planted)
    missing = {}
    for v in V:
        seen = {col[w] for w in nbrs(v)} | {col[v]}
        m = set(range(4)) - seen
        if m:
            missing[v] = m
    ks = sorted({(2 * x + 3 * y) % P for (x, y) in missing})
    shared_adjacent = [(v, w) for v in missing for w in nbrs(v) if w in missing and missing[v] & missing[w]]
    zbar = [v for v in V if (2 * v[0] + 3 * v[1]) % P == 0]
    zbar_indep = all(w not in zbar for v in zbar for w in nbrs(v))
    zbar_miss3 = all(v in missing and 3 in missing[v] for v in zbar)
    print(f"(a) proper: {ok_proper};  plant (one vertex recoloured to a neighbour's colour) fires: {plant_fires}")
    print(f"(b) gapped vertices: {len(missing)}; their k = 2x+3y values: {ks}; missing-colour sets: {sorted({frozenset(m) for m in missing.values()}, key=sorted)}")
    print(f"(c) directed adjacent gapped pairs sharing a missing colour: {len(shared_adjacent)}")
    kpairs = sorted({((2*v[0]+3*v[1]) % P, (2*w[0]+3*w[1]) % P) for v, w in shared_adjacent})
    print(f"    their (k(v), k(w)) values: {kpairs}")
    print(f"(d) Zbar = {{k = 0}}: {len(zbar)} points, independent: {zbar_indep}, each gapped missing colour 3: {zbar_miss3}")
    good = ok_proper and plant_fires and len(missing) == 14 and ks == [0, 5] and len(shared_adjacent) > 0 and zbar_indep and zbar_miss3
    print("ALL AS ASSERTED" if good else "MISMATCH")
    return 0 if good else 1


if __name__ == "__main__":
    sys.exit(main())
