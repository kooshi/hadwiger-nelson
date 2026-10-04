#!/usr/bin/env python3
"""fs131_e1_count.py — FS131-E1: the arithmetic behind L-BAD's count in E1-NO45, checked exactly on a grid.

At a point P with k sectors whose angles are all at least π/3 (strict step 5), the exceptional points Y ∈ ω(P) of L-BAD
are (i) one per edge at P that is a unit arc (at most k), and (ii) one per sector of angle exactly π (both branches of
ω(Y) can then fall in that sector); and (iii) a whole ARC of exceptional Y for every sector of angle greater than π
(both branch directions ψ ± π/2 inside one open sector), of angular measure (angle − π). E1-NO45 needs: no sector of
angle > π, and k + #(angles equal to π) ≤ 5 < 6 for k ∈ {4, 5}.

The grid: every k-tuple of angles that are integer multiples of π/60, each ≥ the lower bound, summing to 2π (exact
integers, unit π/60). Prints, per k, the largest value of k + #(angles = π), the largest total arc of (iii) (in units
of π/60), and whether every tuple leaves an exceptional set smaller than six points.

--fault lowers the angle bound from π/3 to π/6 (strict step 5 dropped): sectors larger than π appear, (iii) is a
positive arc, and the claim must fail.
"""
import sys
from itertools import product

TURN, PI = 120, 60             # units of π/60: a full turn, and π
LOW = 10 if "--fault" in sys.argv else 20   # π/6 or π/3


def tuples(k):
    top = TURN - (k - 1) * LOW          # no angle can exceed this
    for t in product(range(LOW, top + 1), repeat=k - 1):
        last = TURN - sum(t)
        if last >= LOW:
            yield t + (last,)


def main():
    out = []
    ok_all = True
    for k in (4, 5):
        worst_pts, worst_arc, n = 0, 0, 0
        for t in tuples(k):
            n += 1
            pts = k + sum(1 for a in t if a == PI)
            arc = sum(max(0, a - PI) for a in t)
            worst_pts, worst_arc = max(worst_pts, pts), max(worst_arc, arc)
            if arc > 0 or pts >= 6:
                ok_all = False
        out.append(f"k={k}: tuples={n} max_points={worst_pts} max_arc_units={worst_arc}")
    print("; ".join(out) + f"; fewer_than_six_everywhere={ok_all}")


if __name__ == "__main__":
    main()
