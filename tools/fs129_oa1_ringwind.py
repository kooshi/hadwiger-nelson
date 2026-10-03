#!/usr/bin/env python3
"""FS129-OA1-RINGWIND, exact control on a discretised ring.

The ring is cut into N = 6m cells (cell i covers [i, i+1) * 360/N degrees); a colouring gives each cell one of three colours and is
*proper* when cells 60 degrees apart (i and i+m) differ.  The hexagon at cell i is (i, i+m, ..., i+5m); its winding is
W(i) = (1/3) sum_j d(c[i+jm], c[i+(j+1)m]), d(x, y) = +1 if y = x+1 (mod 3) and -1 if y = x-1.
The lemma: W(i+1) != W(i) only if, at the boundary between cells i and i+1, two hexagon positions 60 degrees apart (i+jm+1 and
i+(j+1)m+1, j some index) both change colour.  This script checks it over EVERY proper colouring for m = 2 and m = 3 (N = 12, 18)
and prints the number of violations (expect 0) and the number of colourings checked. Default m = 2 (seconds); --m3 adds m = 3
(about a minute; recorded in plans/FS129-OA1-audit.md: 97,284 colourings for m = 2 and 3 together, 0 violations).

--fault: drops the properness filter (improper colourings let a single change move the winding): violations become non-zero.
"""
import itertools
import sys

FAULT = "--fault" in sys.argv


def d(x, y):
    return 1 if (y - x) % 3 == 1 else (-1 if (y - x) % 3 == 2 else 0)


def check(m):
    N = 6 * m
    viol = checked = 0
    for c in itertools.product(range(3), repeat=N):
        if c[0] != 0:            # colour symmetry: fix the first cell
            continue
        if not FAULT and any(c[i] == c[(i + m) % N] for i in range(N)):
            continue
        checked += 1
        W = [sum(d(c[(i + j * m) % N], c[(i + (j + 1) * m) % N]) for j in range(6)) for i in range(N)]
        for i in range(N):
            if W[(i + 1) % N] != W[i]:
                ch = [c[(i + 1 + j * m) % N] != c[(i + j * m) % N] for j in range(6)]
                if not any(ch[j] and ch[(j + 1) % 6] for j in range(6)):
                    viol += 1
    return viol, checked


tot_v = tot_c = 0
for m in ((2, 3) if "--m3" in sys.argv else (2,)):
    v, k = check(m)
    tot_v += v
    tot_c += k
print(f"colourings checked: {tot_c}")
print(f"violations: {tot_v}")
