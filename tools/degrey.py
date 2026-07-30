#!/usr/bin/env python3
"""Build de Grey's 1581-vertex 5-chromatic unit-distance graph with exact arithmetic.

Untrusted generator. Everything it emits is re-verified inside Lean: the edge list is
re-checked against exact field arithmetic, and non-4-colourability is re-checked from an
LRAT certificate. A bug here can only produce a graph Lean refuses to certify.

The construction is de Grey, arXiv:1804.02385v3 sec. 5.1, verbatim. All coordinates live in
the multiquadratic field Q(sqrt3, sqrt5, sqrt7, sqrt11): sqrt3/sqrt11/sqrt33 come from the
seed points S, sqrt15 from the rotation by 2*arcsin(1/4), and sqrt7 from the rotations by
pi/2 +- arcsin(1/8).
"""

from fractions import Fraction as F
from math import isqrt
import itertools, json, sys

PRIMES = [3, 5, 7, 11]          # bit i of a mask <-> PRIMES[i] is under the radical
N = 1 << len(PRIMES)            # 16 basis elements e_S = sqrt(prod S)

# e_i * e_j = SCALE[i][j] * e_{i xor j}
SCALE = [[  # product of the primes shared by masks i and j
    __import__('functools').reduce(lambda a, b: a * b,
        [PRIMES[k] for k in range(len(PRIMES)) if (i >> k) & 1 and (j >> k) & 1], 1)
    for j in range(N)] for i in range(N)]

ZERO = (F(0),) * N
ONE = (F(1),) + (F(0),) * (N - 1)


def sq(mask):
    """The basis element e_mask, as a field element."""
    return tuple(F(1) if i == mask else F(0) for i in range(N))


def bit(p):
    return 1 << PRIMES.index(p)


R3, R5, R7, R11 = (sq(bit(p)) for p in PRIMES)
R33 = sq(bit(3) | bit(11))
R15 = sq(bit(3) | bit(5))


def add(a, b):   return tuple(x + y for x, y in zip(a, b))
def sub(a, b):   return tuple(x - y for x, y in zip(a, b))
def neg(a):      return tuple(-x for x in a)
def smul(k, a):  return tuple(F(k) * x for x in a)


def mul(a, b):
    out = [F(0)] * N
    for i, ai in enumerate(a):
        if ai:
            for j, bj in enumerate(b):
                if bj:
                    out[i ^ j] += ai * bj * SCALE[i][j]
    return tuple(out)


def rat(q):
    """Embed a rational."""
    return (F(q),) + (F(0),) * (N - 1)


# ---------------------------------------------------------------- numeric shadow
import math
BVAL = [math.sqrt(math.prod(PRIMES[k] for k in range(len(PRIMES)) if (m >> k) & 1))
        for m in range(N)]


def num(a):
    return sum(float(x) * BVAL[i] for i, x in enumerate(a) if x)


# ---------------------------------------------------------------- points / motions
def padd(p, q):  return (add(p[0], q[0]), add(p[1], q[1]))
def psub(p, q):  return (sub(p[0], q[0]), sub(p[1], q[1]))


def rot(p, c, s):
    """Rotate p anticlockwise by the angle with cosine c and sine s."""
    x, y = p
    return (sub(mul(c, x), mul(s, y)), add(mul(s, x), mul(c, y)))


def rot_about(p, ctr, c, s):
    return padd(rot(psub(p, ctr), c, s), ctr)


def normsq(p):
    return add(mul(p[0], p[0]), mul(p[1], p[1]))


# ---------------------------------------------------------------- the seed set S
h = lambda n, d=1: rat(F(n, d))       # rational
def lin(*terms):
    """lin((c1, e1), (c2, e2), ...) = sum ci * ei with ci rational."""
    out = ZERO
    for c, e in terms:
        out = add(out, smul(c, e))
    return out


# 1/sqrt12 = sqrt3/6 ; 1/sqrt3 = sqrt3/3 ; sqrt12 = 2 sqrt3
INV_R12 = smul(F(1, 6), R3)
INV_R3 = smul(F(1, 3), R3)

S = [
    (h(0), h(0)),
    (h(1, 3), h(0)),
    (h(1), h(0)),
    (h(2), h(0)),
    (lin((F(1, 6), R33), (F(-1, 2), ONE)), h(0)),                       # (sqrt33-3)/6

    (h(1, 2), INV_R12),
    (h(1), INV_R3),
    (h(3, 2), smul(F(1, 2), R3)),

    (h(7, 6), smul(F(1, 6), R11)),
    (h(1, 6), lin((F(1, 3), R3), (F(-1, 6), R11))),                     # (sqrt12-sqrt11)/6
    (h(5, 6), lin((F(1, 3), R3), (F(-1, 6), R11))),

    (h(2, 3), lin((F(1, 6), R11), (F(-1, 6), R3))),                     # (sqrt11-sqrt3)/6
    (h(2, 3), lin((F(1, 2), R3), (F(-1, 6), R11))),                     # (3sqrt3-sqrt11)/6
    (smul(F(1, 6), R33), INV_R12),

    (lin((F(1, 6), R33), (F(1, 2), ONE)), INV_R3),                      # (sqrt33+3)/6
    (lin((F(1, 6), R33), (F(1, 6), ONE)), lin((F(1, 2), R3), (F(-1, 6), R11))),
    (lin((F(1, 6), R33), (F(-1, 6), ONE)), lin((F(1, 2), R3), (F(-1, 6), R11))),

    (lin((F(1, 6), R33), (F(1, 6), ONE)), lin((F(1, 6), R11), (F(-1, 6), R3))),
    (lin((F(1, 6), R33), (F(-1, 6), ONE)), lin((F(1, 6), R11), (F(-1, 6), R3))),

    (lin((F(1, 6), R33), (F(-1, 3), ONE)), lin((F(1, 3), R3), (F(-1, 6), R11))),  # (2sqrt3-sqrt11)/6
    (lin((F(1, 6), R33), (F(-2, 3), ONE)), lin((F(1, 3), R3), (F(-1, 6), R11))),

    (lin((F(1, 12), R33), (F(13, 12), ONE)), lin((F(1, 12), R11), (F(-1, 12), R3))),
    (lin((F(1, 12), R33), (F(11, 12), ONE)), lin((F(1, 12), R3), (F(1, 12), R11))),

    (lin((F(1, 12), R33), (F(9, 12), ONE)), lin((F(1, 4), R11), (F(-1, 4), R3))),
    (lin((F(1, 12), R33), (F(9, 12), ONE)), lin((F(3, 12), R3), (F(1, 12), R11))),

    (lin((F(1, 12), R33), (F(7, 12), ONE)), lin((F(1, 12), R3), (F(1, 12), R11))),
    (lin((F(1, 12), R33), (F(7, 12), ONE)), lin((F(3, 12), R3), (F(-1, 12), R11))),

    (lin((F(1, 12), R33), (F(5, 12), ONE)), lin((F(5, 12), R3), (F(-1, 12), R11))),
    (lin((F(1, 12), R33), (F(5, 12), ONE)), lin((F(1, 12), R11), (F(-1, 12), R3))),

    (lin((F(1, 12), R33), (F(3, 12), ONE)), lin((F(3, 12), R11), (F(-5, 12), R3))),
    (lin((F(1, 12), R33), (F(3, 12), ONE)), lin((F(1, 12), R3), (F(1, 12), R11))),

    (lin((F(1, 12), R33), (F(3, 12), ONE)), lin((F(3, 12), R3), (F(-1, 12), R11))),
    (lin((F(1, 12), R33), (F(1, 12), ONE)), lin((F(1, 12), R11), (F(-1, 12), R3))),

    (lin((F(1, 12), R33), (F(-1, 12), ONE)), lin((F(3, 12), R3), (F(-1, 12), R11))),
    (lin((F(1, 12), R33), (F(-3, 12), ONE)), lin((F(1, 12), R11), (F(-1, 12), R3))),

    (lin((F(-1, 12), R33), (F(15, 12), ONE)), lin((F(1, 4), R11), (F(-1, 4), R3))),
    (lin((F(-1, 12), R33), (F(15, 12), ONE)), lin((F(7, 12), R3), (F(-3, 12), R11))),

    (lin((F(-1, 12), R33), (F(13, 12), ONE)), lin((F(3, 12), R3), (F(-1, 12), R11))),
    (lin((F(-1, 12), R33), (F(11, 12), ONE)), lin((F(1, 12), R11), (F(-1, 12), R3))),
]


def dedup(pts):
    seen, out = set(), []
    for p in pts:
        if p not in seen:
            seen.add(p)
            out.append(p)
    return out


def halves(G, Y, ctr, sin_):
    """Which vertices belong to each rotated copy of Y, as index sets.

    The construction's last step rotates one point set `Y` twice, so `G` is two copies of it. The
    two copies turn out to share exactly one vertex and to be joined by exactly one edge, which is
    de Grey's argument made visible -- and is what M06's proof is built on. Nothing here is trusted:
    Lean re-derives the split as a `List` identity (`deGrey_edges_split`, by `rfl`).
    """
    ix = {p: i for i, p in enumerate(G)}
    A = {ix[rot_about(p, ctr, h(-1, 8), sin_)] for p in Y}
    B = {ix[rot_about(p, ctr, h(1, 8), sin_)] for p in Y}
    return A, B


def split_order(E, A, B):
    """`E` reordered as (inside copy A) ++ (inside copy B) ++ (crossing), each group sorted.

    M06 needs each half to be a *contiguous segment* of the edge list, so that "every edge of a half
    is an edge of the graph" is `List.subset_append_left` rather than 3.1e7 kernel comparisons.
    """
    Ea = [e for e in E if e[0] in A and e[1] in A]
    Eb = [e for e in E if e[0] in B and e[1] in B]
    cross = [e for e in E if e not in Ea and e not in Eb]
    assert len(Ea) + len(Eb) + len(cross) == len(E), "the halves must partition the edges"
    return Ea + Eb + cross, [len(Ea), len(Eb), len(cross)]


def build():
    # step 2: S_a = orbit of S under the 6 rotations by multiples of 60 deg and y-negation
    c60, s60 = h(1, 2), smul(F(1, 2), R3)
    orbit = []
    for p in S:
        for flip in (False, True):
            q = (p[0], neg(p[1])) if flip else p
            r = q
            for _ in range(6):
                orbit.append(r)
                r = rot(r, c60, s60)
    Sa = dedup(orbit)

    # step 3: S_b = S_a rotated by 2 arcsin(1/4):  cos = 7/8, sin = sqrt15/8
    Sb = [rot(p, h(7, 8), smul(F(1, 8), R15)) for p in Sa]

    # step 4: Y = (S_a u S_b) \ {(1/3,0), (-1/3,0)}
    drop = {(h(1, 3), h(0)), (h(-1, 3), h(0))}
    Y = [p for p in dedup(Sa + Sb) if p not in drop]

    # steps 5-6: rotate Y about (-2,0) by pi/2 +- arcsin(1/8)
    #   cos(pi/2 + a) = -sin a = -1/8,  sin(pi/2 + a) = cos a = 3 sqrt7 / 8
    #   cos(pi/2 - a) =  sin a =  1/8,  sin(pi/2 - a) = cos a = 3 sqrt7 / 8
    ctr = (h(-2), h(0))
    sin_ = smul(F(3, 8), R7)
    Ya = [rot_about(p, ctr, h(-1, 8), sin_) for p in Y]
    Yb = [rot_about(p, ctr, h(1, 8), sin_) for p in Y]

    G = dedup(Ya + Yb)
    return Sa, Sb, Y, G


def edges(V):
    """Exact unit-distance pairs, with a float grid to cut the candidate set."""
    xy = [(num(p[0]), num(p[1])) for p in V]
    cell = {}
    for i, (x, y) in enumerate(xy):
        cell.setdefault((int(x // 1.0), int(y // 1.0)), []).append(i)
    out = []
    for i, (x, y) in enumerate(xy):
        cx, cy = int(x // 1.0), int(y // 1.0)
        for dx in (-1, 0, 1):
            for dy in (-1, 0, 1):
                for j in cell.get((cx + dx, cy + dy), ()):
                    if j <= i:
                        continue
                    d = (xy[j][0] - x) ** 2 + (xy[j][1] - y) ** 2
                    if abs(d - 1.0) > 1e-7:
                        continue
                    if normsq(psub(V[j], V[i])) == ONE:   # exact
                        out.append((i, j))
    return sorted(out)


if __name__ == "__main__":
    Sa, Sb, Y, G = build()
    print(f"|S| = {len(S)}   (paper: 39 listed)", file=sys.stderr)
    print(f"|S_a| = {len(Sa)}  (paper: 397)", file=sys.stderr)
    print(f"|Y| = {len(Y)}", file=sys.stderr)
    print(f"|G| = {len(G)}  (paper: 1581)", file=sys.stderr)
    E = edges(G)
    print(f"|E(G)| = {len(E)}", file=sys.stderr)

    ctr, sin_ = (h(-2), h(0)), smul(F(3, 8), R7)
    A, B = halves(G, Y, ctr, sin_)
    E, hsz = split_order(E, A, B)
    shared = sorted(A & B)
    cross = E[hsz[0] + hsz[1]:]
    print(f"halves: {len(A)} + {len(B)} vertices sharing {shared}; "
          f"edges {hsz[0]} + {hsz[1]} + {hsz[2]} crossing {cross}", file=sys.stderr)
    json.dump({"n": len(G), "edges": E, "halves": hsz, "shared": shared},
              open("tools/degrey_graph.json", "w"))

    # Integer-leaf export, one global denominator, same shape as tools/spindle.json.
    from math import gcd
    L = 1
    for p in G:
        for comp in p:
            for f in comp:
                L = L * f.denominator // gcd(L, f.denominator)
    coords = [[[int(f * L) for f in comp] for comp in p] for p in G]
    json.dump({"names": [str(i) for i in range(len(G))], "denom": L, "coords": coords,
               "edges": E, "primes": PRIMES, "halves": hsz, "shared": shared},
              open("tools/degrey_cert.json", "w"))
    print(f"common denominator: {L}", file=sys.stderr)
