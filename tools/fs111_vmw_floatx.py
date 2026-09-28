#!/usr/bin/env python3
"""FS111-VMW: an independent FLOAT cross-check of R7's properness (not a verdict; guards the exact engine's candidate sets).

Monte Carlo over same-colour tile pairs of R7 within centre distance 3: sampled interior points of each tile (rejection
sampling from the tile's defining inequalities, independent of the exact engine's boundary-piece model); a pair is flagged
if its sampled distances straddle 1 by more than 1e-9.  A planted twin (down tiles coloured by <3e1, e2>) must be flagged.
Usage: python3 tools/fs111_vmw_floatx.py [--seed N]
"""
import math
import random
import sys

S3 = math.sqrt(3.0)
E1, E2 = (1.0, 0.0), (0.5, S3 / 2)


def lat(a, b):
    return (a * E1[0] + b * E2[0], a * E1[1] + b * E2[1])


def in_reuleaux(p, x):
    A, B, C = p, (p[0] + 1, p[1]), (p[0] + 0.5, p[1] + S3 / 2)
    return all((x[0] - v[0]) ** 2 + (x[1] - v[1]) ** 2 < 1 for v in (A, B, C))


def in_deltoid(q, x):
    cs = [q, (q[0] + 2, q[1]), (q[0] + 1, q[1] + S3)]
    if any((x[0] - c[0]) ** 2 + (x[1] - c[1]) ** 2 <= 1 for c in cs):
        return False
    # inside the down triangle q+e1, q+e2, q+e1+e2
    v = [(q[0] + 1, q[1]), (q[0] + 0.5, q[1] + S3 / 2), (q[0] + 1.5, q[1] + S3 / 2)]
    def cr(a, b, c):
        return (b[0] - a[0]) * (c[1] - a[1]) - (b[1] - a[1]) * (c[0] - a[0])
    s = [cr(v[i], v[(i + 1) % 3], x) for i in range(3)]
    return all(t > 0 for t in s) or all(t < 0 for t in s)


def sample(kind, base, n, rng):
    pts = []
    bx, by = base
    while len(pts) < n:
        x = (bx + rng.uniform(-0.2, 1.7), by + rng.uniform(-0.2, 1.1))
        if (in_reuleaux if kind == "R" else in_deltoid)(base, x):
            pts.append(x)
    return pts


def run(down_col, rng, n=400, N=3):
    tiles = []
    for a in range(-N, N + 1):
        for b in range(-N, N + 1):
            p = lat(a, b)
            tiles.append(("R", p, ("R", a % 2, b % 2)))
            tiles.append(("D", p, ("D", down_col(a, b))))
    focus = [t for t in tiles if abs(t[1][0]) < 1.6 and abs(t[1][1]) < 1.0]
    cache = {}
    flagged = []
    for T in focus:
        for U in tiles:
            if U[2] != T[2] or U is T:
                continue
            if (T[1][0] - U[1][0]) ** 2 + (T[1][1] - U[1][1]) ** 2 > 9:
                continue
            for X in (T, U):
                if id(X) not in cache:
                    cache[id(X)] = sample(X[0], X[1], n, rng)
            ds = [math.dist(x, y) for x in cache[id(T)][:120] for y in cache[id(U)][:120]]
            lo, hi = min(ds), max(ds)
            if lo < 1 - 1e-9 and hi > 1 + 1e-9:
                flagged.append((T, U, lo, hi))
    return flagged


if __name__ == "__main__":
    seed = int(sys.argv[sys.argv.index("--seed") + 1]) if "--seed" in sys.argv else 111
    rng = random.Random(seed)
    f = run(lambda a, b: (a - b) % 3, rng)
    print(f"R7 faithful: flagged pairs {len(f)}")
    fp = run(lambda a, b: a % 3, rng)
    print(f"R7 planted (<3e1,e2>): flagged pairs {len(fp)}; e.g. {[(t[0], u[0], round(lo, 4), round(hi, 4)) for t, u, lo, hi in fp[:2]]}")
    assert not f and fp
    print("float cross-check agrees with the exact engine (faithful clean, plant flagged)")
