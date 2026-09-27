#!/usr/bin/env python3
"""FS110-NB exact checks (no search): ring degree and swaps (N2-RING), tile parity (N2-FLIP).

A ring is a list of (start_degree, colour) arcs covering [0, 360), colours in {0, 1, 2}
(the cyclic order 0 -> 1 -> 2 -> 0 is the orientation).  Angles are Fractions.
  - proper: at every generic theta, colour(theta) != colour(theta + 60).
  - W: lifted degree / 3; swaps: parameters where (c(x), c(x+60)) exchanges.
  - claim N2-RING: no swap => |W| >= 2.
A tile is its cyclic neighbour sequence b_1..b_n (consecutive distinct).
  - s = #{i : b_{i-1} = b_{i+1}}; the transport composite on R_1 is odd iff s is odd.
--plant adds an improper ring declared proper; the checker must go red (exit 1) for that row alone.
Exit 0 iff every check reads as expected.
"""
import sys
from fractions import Fraction as F
from itertools import permutations


def colour(ring, th):
    th %= 360
    c = ring[-1][1]
    for start, col in ring:
        if start <= th:
            c = col
    return c


def events(ring):
    pts = sorted({F(a) % 360 for a, _ in ring} | {(F(a) - 60) % 360 for a, _ in ring})
    return pts


def analyse(ring):
    pts = events(ring)
    mids = [(pts[i] + (pts[(i + 1) % len(pts)] + (360 if i == len(pts) - 1 else 0))) / 2 for i in range(len(pts))]
    proper = all(colour(ring, m) != colour(ring, m + 60) for m in mids)
    # lift around once
    steps = 0
    prev = colour(ring, mids[-1] - 360)
    for m in mids:
        c = colour(ring, m)
        d = (c - prev) % 3
        steps += {0: 0, 1: 1, 2: -1}[d]
        prev = c
    W = F(steps, 3)
    swaps = []
    for i, p in enumerate(pts):
        before, after = mids[i - 1], mids[i]
        a0, b0 = colour(ring, before), colour(ring, before + 60)
        a1, b1 = colour(ring, after), colour(ring, after + 60)
        if (a1, b1) == (b0, a0) and a0 != b0:
            swaps.append(p)
    return proper, W, swaps


RINGS = {  # name: (ring, expect_proper, expect_W, expect_has_swap)
    "hexagonal d e f d e f": ([(0, 0), (60, 1), (120, 2), (180, 0), (240, 1), (300, 2)], True, 2, False),
    "reversed hexagonal": ([(0, 0), (60, 2), (120, 1), (180, 0), (240, 2), (300, 1)], True, -2, False),
    "two colours, 60-degree arcs": ([(0, 0), (60, 1), (120, 0), (180, 1), (240, 0), (300, 1)], True, 0, True),
    "d e d e f f (60 each)": ([(0, 0), (60, 1), (120, 0), (180, 1), (240, 2), (300, 2)], False, None, None),
    "three 120-degree arcs": ([(0, 0), (120, 1), (240, 2)], False, None, None),
    "hexagonal, shifted arcs 50/70 (a 70-degree arc: improper)": ([(0, 0), (50, 1), (120, 2), (180, 0), (230, 1), (300, 2)], False, None, None),
}

TILES = {  # neighbour sequence: expected s parity (1 = odd = reversed)
    "triangle b1 b2 b3": ([1, 2, 3], 0),
    "square b1 b2 b1 b2": ([1, 2, 1, 2], 0),
    "square b1 b2 b3 b2": ([1, 2, 3, 2], 0),
    "pentagon five distinct": ([1, 2, 3, 4, 5], 0),
    "pentagon b1 b2 b3 b4 b2": ([1, 2, 3, 4, 2], 1),
}


def tile_parity(b):
    n = len(b)
    S = [c for c in range(1, 6)]
    s = sum(1 for i in range(n) if b[i - 1] == b[(i + 1) % n])
    perm = {c: c for c in S}  # composite so far: maps R_1 elements

    def t(i):
        x, y = b[i - 1], b[(i + 1) % n]
        return {c: (y if c == x else x if c == y else c) for c in S}
    comp = {c: c for c in S}
    for i in range(n):
        ti = t(i)
        comp = {c: ti[comp[c]] for c in S}
    R1 = [c for c in S if c not in (b[-1], b[0])]
    assert sorted(comp[c] for c in R1) == sorted(R1), "transport does not preserve R_1"
    img = [comp[c] for c in R1]
    inv = sum(1 for i in range(3) for j in range(i + 1, 3) if R1.index(img[i]) > R1.index(img[j]))
    return s % 2, inv % 2


def main(plant):
    rings = dict(RINGS)
    if plant:
        rings["PLANT improper (partners coincide)"] = ([(0, 0), (180, 1)], True, 0, True)
    bad = 0
    for name, (ring, ep, eW, esw) in rings.items():
        proper, W, swaps = analyse(ring)
        ok = proper == ep and (not proper or (W == eW and bool(swaps) == esw))
        if proper and not swaps:
            ok = ok and abs(W) >= 2  # N2-RING
        bad += not ok
        print(f"{'OK ' if ok else 'BAD'} ring {name}: proper={proper} W={W if proper else '-'} swaps={[str(x) for x in swaps] if proper else '-'}")
    for name, (b, epar) in TILES.items():
        sp, pp = tile_parity(b)
        ok = sp == epar and pp == sp
        bad += not ok
        print(f"{'OK ' if ok else 'BAD'} tile {name}: s parity={sp} transport parity on R_1={pp}")
    print(f"unexpected={bad}")
    return bad


if __name__ == "__main__":
    sys.exit(1 if main("--plant" in sys.argv) else 0)
