#!/usr/bin/env python3
"""FS131-PAS3: exact checks for the reading of Kubicki-Lehel-Morayne 2002 (J. Combin. Theory Ser. B 84, 45-53).

Three checks, each in exact rational arithmetic over a named finite set, each with a planted fault that must make it fail:

  matrix   KLM p. 50 (proof of Thm 4.3): for every rational unit vector y of Q^4 in the set UNITS4, the paper's matrix A(y)
           is orthogonal, A y = (1,0,0,0), and {0, y, A^-1 u', A^-1 w'} is a regular unit tetrahedron (u', w' as printed).
           Prints the number of failures (expect 0).  --plant matrix: flips the sign of the entry -y3 in row 3.
  residue  the residue map of the 2-integral rational quaternions R onto R/P (P = {w >= 1}, w = v_2 of the norm), read through
           the tetrahedron T = {0, 1, h, h'}: on UNITS4 it never takes the class of 0, it is multiplicative (the class of uv is a
           function of the classes of u and v), and the three nonzero classes form a group of order 3 under that product.
           Prints "ok <classes hit>" or "FAIL <reason>".  --plant residue: tests z in P by w >= 2 instead of w >= 1.
  mirror   KLM Thm 4.6's 3-colouring of Q^2 on the 3-integral points is f(a, b) = b - a (mod 3); its mirror image under
           (a, b) -> (a, -b) is g(a, b) = -(a + b) (mod 3).  Checks, on every rational unit vector of UNITS2, f(u) != 0 and
           g(u) != 0 (both additive, so both proper on the component of the origin), and the witness pair 0 and
           (7/5, 7/5) = (3/5, 4/5) + (4/5, 3/5): one class under f, two under g.  Prints "<failures> <f-same> <g-same>"
           (expect "0 True False").  --plant mirror: replaces f by a (mod 3), which is not proper.

Usage: python3 -I fs131_pas3_check.py {matrix|residue|mirror} [--plant {matrix|residue|mirror}]
"""
import sys
from fractions import Fraction as F
from itertools import product

# ---------- quaternions over Q: (a, b, c, d) = a + b i + c j + d k ----------

def qmul(p, q):
    a1, b1, c1, d1 = p
    a2, b2, c2, d2 = q
    return (a1*a2 - b1*b2 - c1*c2 - d1*d2,
            a1*b2 + b1*a2 + c1*d2 - d1*c2,
            a1*c2 - b1*d2 + c1*a2 + d1*b2,
            a1*d2 + b1*c2 - c1*b2 + d1*a2)

def conj(q):
    return (q[0], -q[1], -q[2], -q[3])

def norm(q):
    return sum(F(x) * F(x) for x in q)

def scale(q, s):
    return tuple(F(x) * s for x in q)

def sub(p, q):
    return tuple(F(x) - F(y) for x, y in zip(p, q))

def v2(r):
    r = F(r)
    if r == 0:
        return None  # +infinity
    n, d, v = r.numerator, r.denominator, 0
    while n % 2 == 0:
        n //= 2; v += 1
    while d % 2 == 0:
        d //= 2; v -= 1
    return v

def units4():
    """Rational unit quaternions: q^2/N(q) and q x qbar/N(q) for x in {i, j, k}, q over small integer quaternions,
    with their left products by h and h' on every third of them."""
    out = set()
    for q in product(range(-2, 3), repeat=4):
        if q == (0, 0, 0, 0):
            continue
        n = norm(q)
        out.add(scale(qmul(q, q), 1 / n))
        for x in ((0, 1, 0, 0), (0, 0, 1, 0), (0, 0, 0, 1)):
            out.add(scale(qmul(qmul(q, x), conj(q)), 1 / n))
    hs = (tuple(F(1, 2) for _ in range(4)), (F(1, 2), F(1, 2), F(1, 2), F(-1, 2)))
    out |= {qmul(t, u) for t in hs for u in list(out)[::3]}
    out = sorted(out)
    assert all(norm(u) == 1 for u in out)
    return out

# ---------- check 1: the paper's matrix ----------

def klm_matrix(y, plant):
    y1, y2, y3, y4 = y
    r3 = (y3 if plant else -y3, y4, y1, -y2)
    return [(y1, y2, y3, y4), (y2, -y1, y4, -y3), r3, (y4, y3, -y2, -y1)]

def check_matrix(plant):
    half = F(1, 2)
    e1, up, wp = (1, 0, 0, 0), (half,) * 4, (half, -half, half, half)
    fails = 0
    for y in units4():
        A = klm_matrix(y, plant)
        ok = all(sum(F(A[r][t]) * F(A[s][t]) for t in range(4)) == (1 if r == s else 0)
                 for r in range(4) for s in range(4))
        ok = ok and tuple(sum(F(A[r][t]) * F(y[t]) for t in range(4)) for r in range(4)) == e1
        if ok:  # A orthogonal: A^-1 = A^T
            inv = lambda v: tuple(sum(F(A[t][r]) * F(v[t]) for t in range(4)) for r in range(4))
            pts = [(0, 0, 0, 0), y, inv(up), inv(wp)]
            ok = all(norm(sub(pts[a], pts[b])) == 1 for a in range(4) for b in range(a + 1, 4))
        fails += not ok
    print(fails)

# ---------- check 2: the residue map onto F_4 ----------

H = (F(1, 2),) * 4                              # h  = (1 + i + j + k)/2
H2 = (F(1, 2), F(1, 2), F(1, 2), F(-1, 2))      # h' = (1 + i + j - k)/2
T = {"0": (0, 0, 0, 0), "1": (1, 0, 0, 0), "h": H, "h'": H2}

def in_P(z, plant):
    w = v2(norm(z))
    return w is None or w >= (2 if plant else 1)

def residue(z, plant):
    hits = [name for name, t in T.items() if in_P(sub(z, t), plant)]
    return hits[0] if len(hits) == 1 else None

def check_residue(plant):
    us = units4()
    cls = {}
    for u in us:
        c = residue(u, plant)
        if c is None or c == "0":
            print(f"FAIL class of unit {u}: {c}"); return
        cls[u] = c
    table = {}
    sample = [u for u in us if cls[u] != "1"][::5] + [u for u in us if cls[u] == "1"][::25]
    for u in sample:
        for v in sample:
            c = residue(qmul(u, v), plant)
            key = (cls[u], cls[v])
            if table.setdefault(key, c) != c:
                print(f"FAIL product class not a function of the factors' classes at {key}"); return
    one = cls[(1, 0, 0, 0)]
    nz = sorted({c for c in cls.values()})
    group = (len(nz) == 3 and all(table.get((one, a)) == a for a in nz)
             and all(any(table.get((a, b)) == one for b in nz) for a in nz))
    print(f"ok {','.join(nz)}" if group else "FAIL not a group of order 3")

# ---------- check 3: KLM Thm 4.6's colouring and its mirror ----------

def mod3(r):
    r = F(r)
    assert r.denominator % 3 != 0
    return (r.numerator * pow(r.denominator, -1, 3)) % 3

def units2():
    out = set()
    for m in range(1, 30):
        for n in range(0, m):
            a, b, c = m * m - n * n, 2 * m * n, m * m + n * n
            for x, y in ((a, b), (b, a)):
                for sx, sy in product((1, -1), repeat=2):
                    out.add((F(sx * x, c), F(sy * y, c)))
    assert all(x * x + y * y == 1 for x, y in out)
    return sorted(out)

def check_mirror(plant):
    f = (lambda a, b: mod3(a)) if plant else (lambda a, b: (mod3(b) - mod3(a)) % 3)
    g = lambda a, b: (-(mod3(a) + mod3(b))) % 3
    fails = sum(f(*u) == 0 or g(*u) == 0 for u in units2())
    w = (F(7, 5), F(7, 5))
    print(fails, f(*w) == f(0, 0), g(*w) == g(0, 0))

if __name__ == "__main__":
    which = sys.argv[1]
    plant = len(sys.argv) > 3 and sys.argv[2] == "--plant" and sys.argv[3] == which
    {"matrix": check_matrix, "residue": check_residue, "mirror": check_mirror}[which](plant)
