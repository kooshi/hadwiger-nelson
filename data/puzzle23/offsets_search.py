#!/usr/bin/env python3
"""Shifted-sequence colourings of the unit-step graph on F_q^2 (q prime, q = 3 mod 4).

Kooshi's idea (2026-10-07): lay one master sequence W of q colours along a chosen direction v;
every one of the q lines parallel to v carries the same sequence, started at its own offset g(u):

    c(t*v + u*w) = W[(t + g(u)) mod q].

Straight stripes are the case g linear.  Two direction types exist up to the graph's symmetries
(v scaled to a unit step, or not), and both are searched.

Exhaustive, not sampled.  What W must satisfy depends only on the set of "safe shifts"
D = { a + g(u+b) - g(u) : (a, b) a unit step in (v, w) coordinates, u in Z/q }:
W must be a proper colouring of the circulant Cay(Z/q, D).  So:
  for every maximal symmetric D with chi(Cay(Z/q, D)) <= k:  backtrack over g with g(0) = 0.
A second, independent route for the top question: can any colour sit at 4 clock positions
(a class of 4q cells)?  For every 4-set I containing 0, D_I = nonzero \\ (I - I), same backtrack.

Every colouring found is re-checked cell by cell against the 24-step rule in the original coordinates.
"""
import sys
from itertools import combinations

CAP = 30_000_000


class Cap(Exception):
    pass


def steps(q):
    return [(a, b) for a in range(q) for b in range(q) if (a * a + b * b) % q == 1]


def is_qr(n, q):
    return pow(n % q, (q - 1) // 2, q) == 1


def coords(q, v, w, S):
    det = (v[0] * w[1] - v[1] * w[0]) % q
    inv = pow(det, -1, q)
    return [(((X * w[1] - Y * w[0]) * inv) % q, ((v[0] * Y - v[1] * X) * inv) % q) for X, Y in S]


def rot(mask, d, q):
    d %= q
    return ((mask << d) | (mask >> (q - d))) & ((1 << q) - 1)


def circ_colour(q, Dm, k):
    """A proper k-colouring of Cay(Z/q, D) as a list, or None."""
    D = [d for d in range(1, q) if Dm >> d & 1]
    col = [-1] * q

    def rec(i, used):
        if i == q:
            return True
        forb = 0
        for d in D:
            c = col[(i + d) % q]
            if c >= 0:
                forb |= 1 << c
        for c in range(min(used + 1, k)):
            if forb >> c & 1:
                continue
            col[i] = c
            if rec(i + 1, max(used, c + 1)):
                return True
        col[i] = -1
        return False

    return col[:] if rec(0, 0) else None


def solve_g(q, Dm, AB):
    """g with g(0)=0 and a + g(u+b) - g(u) in D for every step (a,b), every u.  Returns (g or None, nodes)."""
    full = (1 << q) - 1
    P = {}
    for a, b in AB:
        if b == 0:
            if not Dm >> a & 1:
                return None, 0
            continue
        P[b] = P.get(b, full) & rot(Dm, -a, q)
    if any(m == 0 for m in P.values()):
        return None, 0
    g = [0] * q
    nodes = 0

    def rec(u):
        nonlocal nodes
        if u == q:
            return True
        m = full
        for up in range(u):
            pb = P.get(u - up)
            if pb is not None:
                m &= rot(pb, g[up], q)
                if not m:
                    return False
            pb = P.get((up - u) % q)
            if pb is not None:                      # g(up) - g(u) in P[up-u]  <=>  g(u) in g(up) - P
                neg = 0
                x = pb
                while x:
                    low = x & -x
                    e = low.bit_length() - 1
                    neg |= 1 << ((g[up] - e) % q)
                    x ^= low
                m &= neg
                if not m:
                    return False
        while m:
            low = m & -m
            m ^= low
            nodes += 1
            if nodes > CAP:
                raise Cap
            g[u] = low.bit_length() - 1
            if rec(u + 1):
                return True
        return False

    return (g[:] if rec(1) else None), nodes


def verify(q, v, w, g, W, S):
    c = {}
    for t in range(q):
        for u in range(q):
            c[((t * v[0] + u * w[0]) % q, (t * v[1] + u * w[1]) % q)] = W[(t + g[u]) % q]
    assert len(c) == q * q
    return sum(1 for (x, y), col in c.items() for a, b in S if c[((x + a) % q, (y + b) % q)] == col)


def sym_sets(q):
    half = list(range(1, (q + 1) // 2))
    for r in range(len(half) + 1):
        for sub in combinations(half, r):
            m = 0
            for d in sub:
                m |= (1 << d) | (1 << (q - d))
            yield m


def family(q, v, w, S, k):
    """(found?, detail) for k colours in the family with sequence direction v."""
    AB = coords(q, v, w, S)
    good = {m: W for m in sym_sets(q) if (W := circ_colour(q, m, k)) is not None}
    maximal = [m for m in good if not any(m != n and m & n == m for n in good)]
    tot = 0
    for m in maximal:
        try:
            g, nodes = solve_g(q, m, AB)
        except Cap:
            return "UNDECIDED", f"node cap {CAP} hit at D={m:#x}"
        tot += nodes
        if g is not None:
            clashes = verify(q, v, w, g, good[m], S)
            lin = all((g[(u + 1) % q] - g[u]) % q == g[1] for u in range(q))
            return ("FOUND" if clashes == 0 else "BUG"), dict(g=g, W=good[m], clashes=clashes, straight=lin)
    return "none", f"{len(maximal)} maximal shift-sets, {tot} nodes"


def four_positions(q, v, w, S, size=4):
    """Is there g making some set I of `size` clock positions a legal class (size*q cells)?"""
    AB = coords(q, v, w, S)
    nz = sum(1 << d for d in range(1, q))
    tot = 0
    for rest in combinations(range(1, q), size - 1):
        I = (0,) + rest
        diff = 0
        for i in I:
            for j in I:
                if i != j:
                    diff |= 1 << ((i - j) % q)
        try:
            g, nodes = solve_g(q, nz & ~diff, AB)
        except Cap:
            return "UNDECIDED", f"node cap at I={I}"
        tot += nodes
        if g is not None:
            cells = [((t * v[0] + u * w[0]) % q, (t * v[1] + u * w[1]) % q) for u in range(q) for t in range(q) if (t + g[u]) % q in I]
            cs = set(cells)
            bad = sum(1 for (x, y) in cells for a, b in S if ((x + a) % q, (y + b) % q) in cs)
            return ("FOUND" if bad == 0 else "BUG"), dict(I=I, g=g, cells=len(cells), clashes=bad)
    return "none", f"{tot} nodes"


def main():
    for q in [int(a) for a in sys.argv[1:]] or [7, 11, 19, 23]:
        S = steps(q)
        assert len(S) == q + 1
        v2 = next((1, m) for m in range(1, q) if not is_qr(1 + m * m, q))
        fams = [("along a clash step", (1, 0), (0, 1)), ("along a no-clash direction", v2, (0, 1))]
        print(f"q={q}  steps={len(S)}")
        for name, v, w in fams:
            for k in range(2, q + 1):
                res, det = family(q, v, w, S, k)
                if res != "none":
                    print(f"  [{name}, v={v}] least k = {k}: {res} {det}")
                    break
                print(f"  [{name}] k={k}: none ({det})")
            for size in (4, 5):
                res, det = four_positions(q, v, w, S, size)
                print(f"  [{name}] a colour at {size} clock positions ({size * q} cells): {res} {det}")
                if res == "none":
                    break
        sys.stdout.flush()


if __name__ == "__main__":
    main()
