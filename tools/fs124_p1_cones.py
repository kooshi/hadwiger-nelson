#!/usr/bin/env python3
"""FS124-P1 — the first-order cone count behind the asking lane's hunch C124-SIX (a hunch, not an entry).

A unit pair (q, q + e) is *tight* for (a inside, b outside) when near q + e the label a fills the inside of the
unit circle about q and b the outside. By C132-SHADOW (plans/FS132-derivation.md § 2), near q the label a then
lives in the closed unit disc about q + e and b outside the open one: to first order, a in the closed half-plane
{d : d.e >= 0} and b in {d : d.e <= 0}.

This script counts, on directions at half-degree offsets (every cone boundary is a multiple of 30 degrees, so no
sample is within 0.5 degrees of one):
  1. three half-planes with normals 120 degrees apart: all three signs equal -> no direction; otherwise a 60-degree cone;
  2. two label pairs, {a, b} tight at the three ring points psi + 0, 120, 240 and {c, d} tight at psi + 60, 180, 300,
     in every pattern of which label is inside at which point: the most of the 360 degrees at q that the four labels
     can cover between them.
Expected: equal-signs=[0, 0] mixed-signs-widths=[60] most-covered-by-four-labels=240 of 360.
--fault puts the three normals 90 degrees apart (0, 90, 180); the count must then differ and the script exits 1.
"""
import sys, itertools, math

fault = "--fault" in sys.argv
N3 = [0, 90, 180] if fault else [0, 120, 240]
dirs = [k + 0.5 for k in range(360)]

def cone(normals, signs):
    return {d for d in dirs if all(s * math.cos(math.radians(d - n)) >= 0 for n, s in zip(normals, signs))}

widths = {s: len(cone(N3, s)) for s in itertools.product([1, -1], repeat=3)}
eq = [widths[(1, 1, 1)], widths[(-1, -1, -1)]]
mixed = sorted({w for s, w in widths.items() if len(set(s)) > 1})
best = 0
N3b = [n + 60 for n in N3]
for sa in itertools.product([1, -1], repeat=3):
    for sc in itertools.product([1, -1], repeat=3):
        cover = (cone(N3, sa) | cone(N3, tuple(-s for s in sa))
                 | cone(N3b, sc) | cone(N3b, tuple(-s for s in sc)))
        best = max(best, len(cover))
print(f"equal-signs={eq} mixed-signs-widths={mixed} most-covered-by-four-labels={best} of 360")
sys.exit(0 if (eq == [0, 0] and mixed == [60] and best == 240) else 1)
