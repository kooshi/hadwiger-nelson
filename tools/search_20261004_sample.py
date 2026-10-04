#!/usr/bin/env python3
"""SEARCH-2026-10-04: an independent float sampler for a bicycle colouring certificate (a cross-check of search_20261004_check.py, not a proof).
Colours are looked up by float angle from the certificate's starts; random points of both circles are tested against their 60-degree
neighbours and their cross partners; pairs within 1e-7 degrees of a start or an exception are skipped (the exact checker owns those).
Usage: search_20261004_sample.py CERT.json [N]      exit 0 = no conflict seen, 1 = conflicts seen."""
import json, math, random, sys
from fractions import Fraction
cert = json.load(open(sys.argv[1])); N = int(sys.argv[2]) if len(sys.argv) > 2 else 200000
def val(s):
    import sympy as sp
    return float(sp.N(sp.sympify(s), 30))
d = float(Fraction(cert["d"]))
C = {"u": (0.0, 0.0), "v": (d, 0.0)}
def angle(c, x, y): return math.degrees(math.atan2(y - c[1], x - c[0])) % 360.0
st = {k: sorted((angle(C[k], val(a), val(b)), col) for a, b, col in cert[k + "_starts"]) for k in ("u", "v")}
exc = [(val(a), val(b)) for a, b, _ in cert["exceptions"]]
def col(k, a):
    s = st[k]; best = s[-1][1]
    for ang, c in s:
        if ang <= a: best = c
    return best
def near(k, a):
    return min(min(abs((a - g + 180) % 360 - 180) for g, _ in st[k]), min([abs((a - angle(C[k], *e) + 180) % 360 - 180) for e in exc] or [9])) < 1e-7
rng = random.Random(7); bad = skipped = 0
for _ in range(N):
    k = rng.choice("uv"); a = 360 * rng.random()
    a2 = (a + 60) % 360
    if near(k, a) or near(k, a2): skipped += 1
    elif col(k, a) == col(k, a2): bad += 1
    # cross: y on v, partners on u
    e = math.radians(360 * rng.random()); yx, yy = d + math.cos(e), math.sin(e); r = math.hypot(yx, yy)
    if r <= 2:
        ay = angle(C["v"], yx, yy); tc = math.degrees(math.atan2(yy, yx)); b = math.degrees(math.acos(r / 2))
        for th in (tc + b, tc - b):
            th %= 360
            if near("v", ay) or near("u", th): skipped += 1
            elif col("v", ay) == col("u", th): bad += 1
print(f"{sys.argv[1]}: {N} samples, conflicts {bad}, skipped near boundaries {skipped}")
sys.exit(1 if bad else 0)
