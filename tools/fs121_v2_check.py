#!/usr/bin/env python3
"""FS121-V2 exact checks (standard library, plus sympy for `crossing`).

Each mode prints one summary line; `--plant` plants the fault named in the mode's docstring, and the summary must change.

  crossing  the unit parallels of a sector's two straight edges, on the sector's side, meet at the images of the points at distance
            cot(theta/2) from the vertex on both edges (sympy, theta symbolic).       plant: parallels on the outer side
  diameter  over theta = 1..179 degrees: 1/(2 sin(theta/2)) <= cot(theta/2) exactly when theta <= 120 (so the diameter bound
            min(L1, L2) <= 1/(2 sin(theta/2)) gives EROSION's first disjunct for theta <= 2pi/3).   plant: compares with cos
  sectors   the angular lemma of DB1-L3 on a half-degree grid: for W1 = (0, theta1), the directions allowed to a second region of the
            same colour by the two edge constraints, minus W1, hold no open arc (no two adjacent grid points), and for theta1 <= 180
            are exactly the two edge directions.                                       plant: drops the second edge's constraint
  comparison points of a circle of radius R >= 1 tangent to the x-axis at 0 (curvature 1/R <= 1, bending up) lie outside the open unit
            disc about (0, 1) (the zero-angle lemma's comparison, exact on rational points).   plant: R = 1/2
  sq9       the model: in SQ9 (square (i, j) of side 1/2 coloured (i mod 3, j mod 3)) the four squares at every vertex carry four
            distinct colours, so no colour occupies two sectors there.                  plant: colours (i + j) mod 2
"""
import sys
from fractions import Fraction as Fr


def crossing(plant):
    import sympy as sp
    th, t, s = sp.symbols("theta t s", real=True)
    h = th / 2
    d1, d2 = sp.Matrix([sp.cos(h), sp.sin(h)]), sp.Matrix([sp.cos(h), -sp.sin(h)])
    n1, n2 = sp.Matrix([-sp.sin(h), sp.cos(h)]), sp.Matrix([-sp.sin(h), -sp.cos(h)])  # outward normals of the sector's edges
    sgn = 1 if plant else -1  # the sector's side is -n; the plant takes +n
    eqs = list(t * d1 + sgn * n1 - (s * d2 + sgn * n2))
    sol = sp.solve(eqs, [t, s], dict=True)[0]
    ok_t = sp.simplify(sol[t] - sp.cot(h)) == 0
    ok_s = sp.simplify(sol[s] - sp.cot(h)) == 0
    Q = sp.simplify(sol[t] * d1 + sgn * n1)
    print(f"crossing: t = cot(theta/2): {ok_t}; s = cot(theta/2): {ok_s}; Q = ({sp.simplify(Q[0])}, {sp.simplify(Q[1])})")


def diameter(plant):
    import math
    hits = 0
    for deg in range(1, 180):
        h = math.radians(deg) / 2
        # exact form of 1/(2 sin h) <= cos h / sin h is cos h >= 1/2, i.e. h <= 60 degrees; checked here with integers
        exact = (deg <= 120)
        num = (2 * math.sin(h) if plant else 1.0) <= 2 * math.cos(h) + 1e-12  # 1 <= 2 cos h
        if exact != num:
            print(f"diameter: disagreement at {deg} degrees")
            return
        hits += exact
    print(f"diameter: the diameter bound gives the first disjunct at {hits} of 179 integer angles, exactly 1..120")


def in_closed_arc(d, a, b):  # directions in half-degrees mod 720; closed ccw arc from a to b
    return (d - a) % 720 <= (b - a) % 720


def sectors(plant):
    killed_outright = arcs_left = 0
    cusp_exact = 0
    for th in range(2, 720):  # theta1 in half-degrees, (0, 360) exclusive
        w1 = [d for d in range(1, th)]  # grid points strictly inside W1 = (0, theta1)
        sides = []
        for tau in (th, 0):  # the tangent lines of W1's two edges
            sA = lambda d, tau=tau: in_closed_arc(d, tau - 360, tau)
            sB = lambda d, tau=tau: in_closed_arc(d, tau, tau + 360)
            if all(sA(d) for d in w1):
                sides.append(sA)
            elif all(sB(d) for d in w1):
                sides.append(sB)
            else:
                sides.append(None)
        if plant:
            sides[1] = lambda d: True
        if None in sides:
            killed_outright += 1  # W1 itself fits no closed side: reflex, killed with no second region
            continue
        allowed = [d for d in range(720) if sides[0](d) and sides[1](d) and not (0 < d < th)]
        s = set(allowed)
        if any(((d + 1) % 720) in s for d in s):
            arcs_left += 1
        if th <= 360 and s == {0, th}:
            cusp_exact += 1
    print(f"sectors: reflex W1 killed outright {killed_outright}; theta1 leaving an arc for a second region {arcs_left}; "
          f"theta1 <= 180 whose allowed cusp directions are exactly the two edges {cusp_exact} of 359")


def comparison(plant):
    radii = [Fr(1, 2)] if plant else [Fr(1), Fr(3, 2), Fr(2), Fr(5), Fr(100)]
    inside = 0
    total = 0
    for R in radii:
        for k in range(-400, 401):
            if k == 0:
                continue
            t = Fr(k, 100)
            px, py = 2 * R * t / (1 + t * t), 2 * R * t * t / (1 + t * t)  # rational point of the circle about (0, R)
            if px * px < Fr(1, 4):  # the local part, |x| < 1/2
                total += 1
                if px * px + (py - 1) ** 2 < 1:
                    inside += 1
    print(f"comparison: points inside the open unit disc about (0, 1): {inside} of {total}")


def sq9(plant):
    col = (lambda i, j: (i + j) % 2) if plant else (lambda i, j: (i % 3, j % 3))
    bad = 0
    for i in range(9):
        for j in range(9):
            cs = [col(i - 1, j - 1), col(i, j - 1), col(i - 1, j), col(i, j)]
            bad += len(set(cs)) < 4
    print(f"sq9: vertices of one period with a repeated colour: {bad} of 81")


if __name__ == "__main__":
    mode = sys.argv[1]
    {"crossing": crossing, "diameter": diameter, "sectors": sectors, "comparison": comparison, "sq9": sq9}[mode]("--plant" in sys.argv)
