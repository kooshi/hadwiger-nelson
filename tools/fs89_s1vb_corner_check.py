#!/usr/bin/env python3
"""FS-89 Stage 1, verifier I (V-B): exact checks of the derivation agent's finite corner lemmas at S = {5, 13}.

Written blind to the derivation agent's tools (tools/fs89_s1d_*), from the lemma STATEMENTS only
(data/fs89/briefs/S1-VB-lemma-statements.md): D1-L5, D1-L6, D1-C1 (band [1/4, 3/4]) and D5-L3 (band [1/5, 4/5]).

The model (verifier H's Theorem V5): a character of R_65 = Z[i][1/65] is an array (e_{m,n}) in C/Z[i],
  e_{m+1,n} - wb5  * e_{m,n} in pi5^{-1}  Z[i]   (5-direction; wb5  = conj(w5),  w5  = (3+4i)/5,  pi5  = 2+i)
  e_{m,n+1} - wb13 * e_{m,n} in pi13^{-1} Z[i]   (13-direction; wb13 = conj(w13), w13 = (5+12i)/13, pi13 = 3+2i)
and the band [lo, 1 - lo] holds iff every e_{m,n} has a lift into the square Q = [lo, 1 - lo]^2 (unique: side < 1).
The four corners are the characters x with 2x = parity, e in (1+i)/4 + (1/2)Z[i]; their array is c_{m,n} = (-1)^m c_0
(w5 = -1, w13 = 1 mod 4).

Every check is an exhaustive pass over a finite set the lemma names (lattice points in a bounded box), in exact
Gaussian-rational arithmetic. Nothing is searched for: each check asserts that the set of survivors is exactly the
corner (or corner-leaf) pattern. Planted faults (--plant NAME) must turn a check red, for the stated reason.
"""
from __future__ import annotations

import argparse
import sys
from fractions import Fraction as Fr
from itertools import product

# ---------------------------------------------------------------- Gaussian rationals as (re, im) pairs of Fractions
def g(a, b=0):
    return (Fr(a), Fr(b))


def add(x, y):
    return (x[0] + y[0], x[1] + y[1])


def sub(x, y):
    return (x[0] - y[0], x[1] - y[1])


def mul(x, y):
    return (x[0] * y[0] - x[1] * y[1], x[0] * y[1] + x[1] * y[0])


def conj(x):
    return (x[0], -x[1])


def div(x, y):
    n = y[0] * y[0] + y[1] * y[1]
    z = mul(x, conj(y))
    return (z[0] / n, z[1] / n)


def is_gauss_int(x):
    return x[0].denominator == 1 and x[1].denominator == 1


def norm2(x):
    return x[0] * x[0] + x[1] * x[1]


PI5, PI13 = g(2, 1), g(3, 2)
W5, W13 = div(g(3, 4), g(5)), div(g(5, 12), g(13))
PLANT = None  # set from argv


def step_lattice(direction):
    """The pi^{-1}Z[i] of the step rule e_{next} - wbar * e in pi^{-1}Z[i]; direction in {'5+','5-','13+','13-'}.
    Forward: e_{m+1} - wb e_m in pi^{-1}Z[i].  Backward (m -> m-1): e_{m-1} - w e_m in pibar^{-1}Z[i]."""
    p = {"5": PI5, "13": PI13}[direction[:-1]]
    if direction[-1] == "-":
        p = conj(p)
    if PLANT == "lattice" and direction == "5+":
        p = conj(p)  # the wrong forward lattice pibar5^{-1}Z[i]
    return p


def mult(direction):
    w = {"5": W5, "13": W13}[direction[:-1]]
    return conj(w) if direction[-1] == "+" else w


def in_lattice(z, p):
    """z in p^{-1}Z[i]  iff  p z in Z[i]."""
    return is_gauss_int(mul(p, z))


def lattice_points(p, box):
    """All z in p^{-1}Z[i] with z in box = ((xlo, xhi), (ylo, yhi)) (closed), exact. p^{-1}Z[i] subset (1/N(p))Z[i]."""
    n = int(norm2(p))
    (xlo, xhi), (ylo, yhi) = box
    out = []
    import math
    for a in range(math.floor(xlo * n), math.ceil(xhi * n) + 1):
        for b in range(math.floor(ylo * n), math.ceil(yhi * n) + 1):
            z = (Fr(a, n), Fr(b, n))
            if xlo <= z[0] <= xhi and ylo <= z[1] <= yhi and in_lattice(z, p):
                out.append(z)
    return out


def lift(z, lo):
    """The lift of z mod Z[i] into Q = [lo, 1-lo]^2, or None."""
    hi = 1 - lo
    out = []
    for c in (z[0], z[1]):
        r = c - (c.numerator // c.denominator)  # in [0, 1)
        cand = [r + k for k in (-1, 0, 1) if lo <= r + k <= hi]
        if not cand:
            return None
        out.append(cand[0])
    return (out[0], out[1])


def cls_eq(x, y):
    return is_gauss_int(sub(x, y))


CORNERS = [g(Fr(1, 4), Fr(1, 4)), g(Fr(3, 4), Fr(1, 4)), g(Fr(1, 4), Fr(3, 4)), g(Fr(3, 4), Fr(3, 4))]


def corner_at(c0, m):
    """(-1)^m c0 reduced into [0,1)^2 (the corner pattern; constant in n)."""
    if m % 2 == 0:
        return c0
    return (1 - c0[0], 1 - c0[1])


def check_corner_array(lo):
    """Sanity: every corner pattern satisfies both step rules in both directions, and lies in Q."""
    for c0 in CORNERS:
        for m in range(-3, 4):
            a, b = corner_at(c0, m), corner_at(c0, m + 1)
            assert lift(a, lo) == a, (c0, m)
            assert in_lattice(sub(b, mul(mult("5+"), a)), step_lattice("5+")), ("5+", c0, m)
            assert in_lattice(sub(a, mul(mult("5-"), b)), step_lattice("5-")), ("5-", c0, m)
            assert in_lattice(sub(a, mul(mult("13+"), a)), step_lattice("13+")), ("13+", c0, m)
            assert in_lattice(sub(a, mul(mult("13-"), a)), step_lattice("13-")), ("13-", c0, m)


# ---------------------------------------------------------------- the generic difference-chain check
def neighbour_candidates(base_dir, lo, centre, slack):
    """Differences delta in the step lattice of base_dir with centre + delta' in Q for some |delta'-delta|_inf <= slack,
    i.e. delta in (Q - centre) enlarged by slack (an over-approximation, sound for 'only delta = 0')."""
    hi = 1 - lo
    box = ((lo - centre[0] - slack, hi - centre[0] + slack), (lo - centre[1] - slack, hi - centre[1] + slack))
    return lattice_points(step_lattice(base_dir), box)


def chain_survivors(base_dir, chain_dir, centres, lo, slack):
    """Sites s_0..s_{L-1} along chain_dir, each a base_dir-neighbour of an exactly-known site. delta_j lies in the
    base_dir lattice and in the enlarged box about centres[j]; consecutive: delta_{j+1} - mult(chain_dir) delta_j in
    the chain_dir lattice. Return every chain (as a tuple) that satisfies all constraints."""
    cands = [neighbour_candidates(base_dir, lo, c, slack) for c in centres]
    chains = [(d,) for d in cands[0]]
    for j in range(1, len(centres)):
        nxt = []
        for ch in chains:
            for d in cands[j]:
                if in_lattice(sub(d, mul(mult(chain_dir), ch[-1])), step_lattice(chain_dir)):
                    nxt.append(ch + (d,))
        chains = nxt
    return chains


def nonzero(chains):
    return [ch for ch in chains if any(d != (0, 0) for d in ch)]


# ---------------------------------------------------------------- the lemmas
def check_L5(lo=Fr(1, 4), radius=Fr(13, 100)):
    """D1-L5: |e - c| < 0.13 at (m,n) and (m+1,n) forces equality. Two exact facts: (i) (2*radius)^2 < 1/5, the least
    nonzero squared norm in pi5^{-1}Z[i] (and in pibar5^{-1}Z[i]), so delta' = wb5 * delta; (ii) the cone of delta
    (Q - c, a closed quadrant at a corner) meets wb5^{-1} times the cone of delta' only in 0. Checked for every corner
    and both step directions."""
    minnorm = min(norm2(z) for z in lattice_points(PI5, ((-1, 1), (-1, 1))) if z != (0, 0))
    assert minnorm == Fr(1, 5), minnorm
    assert (2 * radius) ** 2 < minnorm, "radius too large for the norm step"
    bad = []
    for c0 in CORNERS:
        for m in (0, 1):
            for d in ("5+", "5-"):
                c_here = corner_at(c0, m)
                c_next = corner_at(c0, m + (1 if d == "5+" else -1))
                q_here = (1 if c_here[0] == lo else -1, 1 if c_here[1] == lo else -1)  # quadrant signs into Q
                q_next = (1 if c_next[0] == lo else -1, 1 if c_next[1] == lo else -1)
                gens = [g(q_here[0], 0), g(0, q_here[1])]
                rot = [mul(mult(d), x) for x in gens]  # delta' = mult * delta
                # does the cone spanned by rot meet the closed quadrant q_next outside 0?  2-D cones < 180 degrees:
                # they meet nontrivially iff a generator of one lies in the other
                def in_quadrant(x, q):
                    return x[0] * q[0] >= 0 and x[1] * q[1] >= 0

                def in_cone(x, a, b):  # x = s a + t b with s, t >= 0
                    det = a[0] * b[1] - a[1] * b[0]
                    s = (x[0] * b[1] - x[1] * b[0]) / det
                    t = (a[0] * x[1] - a[1] * x[0]) / det
                    return s >= 0 and t >= 0

                meet = any(in_quadrant(x, q_next) for x in rot) or any(
                    in_cone(y, rot[0], rot[1]) for y in (g(q_next[0], 0), g(0, q_next[1])))
                if PLANT == "cone":  # plant: pretend the next site's quadrant is the SAME as this one's
                    meet = any(in_quadrant(x, q_here) for x in rot) or any(
                        in_cone(y, rot[0], rot[1]) for y in (g(q_here[0], 0), g(0, q_here[1])))
                if meet:
                    bad.append((c0, m, d))
    return bad


def check_L6(lo=Fr(1, 4)):
    """D1-L6 (both halves), all corners, all directions: survivors must be the corner pattern (all deltas 0)."""
    rep = []
    seg_row = 2 if PLANT == "short-row" else 3
    for c0 in CORNERS:
        for m in (0, 1):
            # half 1: a vertical domino (m,n),(m,n+1) at the corner pattern; neighbour column m+-1, rows n, n+1.
            for d5 in ("5+", "5-"):
                mm = m + (1 if d5 == "5+" else -1)
                cen = [corner_at(c0, mm)] * 2
                for d13 in ("13+", "13-"):
                    s = nonzero(chain_survivors(d5, d13, cen, lo, Fr(0)))
                    rep.append(("L6a", c0, m, d5, d13, len(s)))
            # half 2: a row segment (m..m+seg-1, n) at the pattern; neighbour row n+-1 at those columns.
            cen = [corner_at(c0, m + j) for j in range(seg_row)]
            for d13 in ("13+", "13-"):
                s = nonzero(chain_survivors(d13, "5+", cen, lo, Fr(0)))
                rep.append(("L6b", c0, m, d13, "5+", len(s)))
    return rep


def check_C1(lo=Fr(1, 4), R=3):
    """D1-C1's first sentence by propagation: start from a vertical domino at the corner pattern, apply the L6 moves
    (each certified by check_L6) until a (2R+1) x (2R+1) box is exact, and confirm every move had zero survivors.
    Equivalent to the lemma given L6; the check is that the moves close up (no site is reached only by an unchecked move)."""
    known = {(0, 0), (0, 1)}
    changed = True
    while changed:
        changed = False
        for (m, n) in list(known):
            if (m, n + 1) in known:  # vertical domino -> columns m+-1
                for mm in (m - 1, m + 1):
                    for p in ((mm, n), (mm, n + 1)):
                        if abs(p[0]) <= R and abs(p[1]) <= R and p not in known:
                            known.add(p)
                            changed = True
            if (m + 1, n) in known and (m + 2, n) in known:  # row segment -> rows n+-1
                for nn in (n - 1, n + 1):
                    for p in ((m, nn), (m + 1, nn), (m + 2, nn)):
                        if abs(p[0]) <= R and abs(p[1]) <= R and p not in known:
                            known.add(p)
                            changed = True
    return len(known) == (2 * R + 1) ** 2


def check_D5L3(lo=Fr(1, 5), slack=Fr(6, 100)):
    """D5-L3: the array equals a corner-leaf array c + wb^{(m,n)} d' (|d'| <= 0.06) on a column segment of height 3
    -> equal on the neighbouring columns at those rows; on a row segment of length 4 -> equal on the neighbouring rows.
    The leaf value at a neighbour site is c_{site} + (something of sup-norm <= 0.06); the candidate differences are
    over-approximated by enlarging Q - c_{site} by 0.06 in each coordinate (sound for 'only delta = 0')."""
    if PLANT == "wide-leaf":
        slack = Fr(20, 100)
    hcol = 2 if PLANT == "short-col" else 3
    lrow = 3 if PLANT == "short-row5" else 4
    rep = []
    for c0 in CORNERS:
        for m in (0, 1):
            for d5 in ("5+", "5-"):
                mm = m + (1 if d5 == "5+" else -1)
                cen = [corner_at(c0, mm)] * hcol
                for d13 in ("13+", "13-"):
                    s = nonzero(chain_survivors(d5, d13, cen, lo, slack))
                    rep.append(("D5L3col", c0, m, d5, d13, len(s)))
            cen = [corner_at(c0, m + j) for j in range(lrow)]
            for d13 in ("13+", "13-"):
                s = nonzero(chain_survivors(d13, "5+", cen, lo, slack))
                rep.append(("D5L3row", c0, m, d13, "5+", len(s)))
    return rep


def main():
    global PLANT
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", default=None,
                    choices=[None, "lattice", "cone", "short-row", "short-col", "short-row5", "wide-leaf"])
    a = ap.parse_args()
    PLANT = a.plant
    ok = True
    try:
        check_corner_array(Fr(1, 4))
        check_corner_array(Fr(1, 5))
        print("corner arrays satisfy both step rules, both directions, both bands: OK")
    except AssertionError as e:
        print("corner array FAILS the step rules:", e)
        ok = False
    bad = check_L5()
    print(f"D1-L5: corner/direction cases where the cones meet: {len(bad)} {bad if bad else ''}")
    ok &= not bad
    r6 = check_L6()
    n6 = sum(x[-1] for x in r6)
    print(f"D1-L6: {len(r6)} cases, non-zero survivor chains in total: {n6}")
    if n6:
        print("   ", [x for x in r6 if x[-1]])
    ok &= n6 == 0
    c1 = check_C1()
    print(f"D1-C1 (propagation from a vertical domino closes a 7x7 box): {c1}")
    ok &= c1
    r5 = check_D5L3()
    n5 = sum(x[-1] for x in r5)
    print(f"D5-L3: {len(r5)} cases, non-zero survivor chains in total: {n5}")
    if n5:
        print("   ", [x for x in r5 if x[-1]])
    ok &= n5 == 0
    print("ALL CHECKS PASS" if ok else "SOME CHECK FAILED", f"(plant={PLANT})")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
