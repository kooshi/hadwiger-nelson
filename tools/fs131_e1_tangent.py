#!/usr/bin/env python3
"""fs131_e1_tangent.py — FS131-E1: the geometric core of L-BAD, exactly (sympy).

Coordinates: P = (0, 0), an edge e leaving P in direction σ = 0 (the positive x-axis), Y = (0, −1) ∈ ω(P), so that
ω(Y) is the unit circle through P tangent to e at P, curving toward Y. The edge is the segment along y = 0, or an arc of
the circle C_c: x² + (y − c)² = c² (centre (0, c), radius |c|; c > 0 curves away from Y, c < 0 toward Y).

Claimed (L-BAD): (1) e and ω(Y) meet only at P unless the edge lies on ω(Y), i.e. c = −1; (2) so near P the branch of
ω(Y) in direction σ lies strictly on one side of e: below it (on Y's side) when c > 0, for the segment, and when c < −1;
above it when −1 < c < 0.

Prints, for each edge, the number of intersection points with ω(Y) (solved exactly) and the side of ω(Y)'s branch at
x = 1/100 (exact sign of y_ω − y_e). --fault adds the edge c = −1 (the bad position itself): it lies on ω(Y), the
intersection is a whole circle, and the printed table must change.
"""
import sys
import sympy as sp

x, y = sp.symbols("x y", real=True)
h = sp.Rational(1, 100)
OMEGA = sp.Eq(x**2 + (y + 1)**2, 1)
EDGES = [("line", None), ("c=2", 2), ("c=1/2", sp.Rational(1, 2)), ("c=-3", -3), ("c=-3/2", sp.Rational(-3, 2)),
         ("c=-1/2", sp.Rational(-1, 2)), ("c=-1/3", sp.Rational(-1, 3))]
if "--fault" in sys.argv:
    EDGES.append(("c=-1", -1))


def main():
    y_om = -1 + sp.sqrt(1 - h**2)                  # ω(Y)'s branch through P, at x = h
    rows = []
    for name, c in EDGES:
        if c is None:
            eq, y_e = sp.Eq(y, 0), sp.Integer(0)
        else:
            eq = sp.Eq(x**2 + (y - c)**2, c**2)
            y_e = c - sp.sign(c) * sp.sqrt(c**2 - h**2)  # the branch of C_c through P
        diff = sp.simplify((x**2 + (y + 1)**2 - 1) - ((x**2 + (y - c)**2 - c**2) if c is not None else 0))
        if c is not None and sp.simplify(diff) == 0:
            npts = "circle"
        else:
            sols = sp.solve([OMEGA, eq], [x, y], dict=True)
            npts = str(len({(sp.nsimplify(s[x]), sp.nsimplify(s[y])) for s in sols}))
        d = sp.nsimplify(y_om - y_e)
        side = "below" if (d < 0) == True else ("above" if (d > 0) == True else "on")
        rows.append(f"{name}:{npts}:{side}")
    print(" ".join(rows))


if __name__ == "__main__":
    main()
