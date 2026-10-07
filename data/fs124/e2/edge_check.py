#!/usr/bin/env python3
"""FS124-E2 — exact checks (sympy) for C124-EDGE-CLOSED and C124-FORCED-SEVEN.

  python3 data/fs124/e2/edge_check.py edge  [--fault]   the strip's top-edge point w = (1/4, sqrt15/4 + sqrt3/2): the six pieces kept below
        the line y = sqrt15/4, the side of each with respect to S(w), and the open set near w on which all six labels are barred.
        --fault reads the point w + (1/50, 0) instead (no longer at distance 1 from the four members): must print FAULT-SEEN.
  python3 data/fs124/e2/edge_check.py second [--fault]  the 36 label patterns of C124-SECOND (see the function)
  python3 data/fs124/e2/edge_check.py seven [--fault]   the honeycomb at circumradius 2/5: two vertices with disjoint label triples
        28/25 apart in squared distance and a common unit point strictly inside the inscribed disc of a hexagon of the seventh label.
        --fault pairs the first vertex only with vertices of its own orientation, whose triples always meet: must print FAULT-SEEN.
"""
import sys
import sympy as sp
FAULT = "--fault" in sys.argv
s3, s15 = sp.sqrt(3), sp.sqrt(15)
R = sp.Rational
def d2(p, q): return sp.expand((p[0] - q[0]) ** 2 + (p[1] - q[1]) ** 2)
def sgn(x): return int(sp.sign(sp.nsimplify(x))) if sp.simplify(x) != 0 else 0


def edge():
    P = lambda j: (R(j, 2), sp.Integer(0)); V = lambda m: (R(m, 2), s3 / 2); A = lambda j: (R(j, 2) + R(1, 4), s15 / 4)
    w = (R(1, 4) + (R(1, 50) if FAULT else 0), s15 / 4 + s3 / 2)
    ok = all(sp.simplify(d2(w, z) - 1) == 0 for z in (V(1), V(0), A(-1), A(1)))
    def arc_mid(C, p, q):                       # the point of S(C) on the bisector of p, q, on their side
        m = ((p[0] + q[0]) / 2 - C[0], (p[1] + q[1]) / 2 - C[1]); n = sp.sqrt(m[0] ** 2 + m[1] ** 2)
        return (C[0] + m[0] / n, C[1] + m[1] / n)
    # T_1 below the line: bounded by the arc V_1 A_0 of S(P_0), the arc V_1 A_1 of S(P_2) and the segment A_0 A_1
    inner_T1 = [sgn(d2(w, arc_mid(P(0), V(1), A(0))) - 1), sgn(d2(w, arc_mid(P(2), V(1), A(1))) - 1), sgn(d2(w, A(0)) - 1)]
    inner_T0 = [sgn(d2(w, arc_mid(P(1), V(0), A(0))) - 1), sgn(d2(w, arc_mid(P(-1), V(0), A(-1))) - 1), sgn(d2(w, A(0)) - 1)]
    # the circles S(P_0), S(P_2) meet S(w) exactly at {V_1, A_-1}, {V_1, A_1}: so the open arcs keep one side
    meet = all(sp.simplify(d2(P(j), z) - 1) == 0 for j, z in ((0, V(1)), (0, A(-1)), (2, V(1)), (2, A(1)), (1, V(0)), (1, A(1)), (-1, V(0)), (-1, A(-1))))
    outer_T2 = sgn(d2(w, V(2)) - 1)              # T_2's part below the line has V_2 in its closure
    # arches: U_j = {j/2 < x < (j+1)/2, y > 0, inside S(P_j) and S(P_{j+1})}; one point of each strictly inside S(w), one strictly outside
    def in_U(j, z): return R(j, 2) < z[0] < R(j + 1, 2) and z[1] > 0 and d2(z, P(j)) < 1 and d2(z, P(j + 1)) < 1
    pts = {0: ((R(1, 4), R(9, 10)), (R(1, 4), R(1, 10))), 1: ((R(51, 100), R(87, 100)), (R(3, 4), R(1, 10))),
           -1: ((R(-1, 100), R(87, 100)), (R(-1, 4), R(1, 10)))}
    cross = {j: (in_U(j, a) and in_U(j, b), sgn(d2(w, a) - 1), sgn(d2(w, b) - 1)) for j, (a, b) in pts.items()}
    # the direction (12, 5)/13 from w: outside S(V_1), outside S(A_-1), inside S(A_1), to first order
    dvec = (R(12, 13), R(5, 13)); dot = lambda z: sgn(dvec[0] * (w[0] - z[0]) + dvec[1] * (w[1] - z[1]))
    region = (dot(V(1)), dot(A(-1)), dot(A(1)))
    sys.path.insert(0, __import__("os").path.join(__import__("os").path.dirname(__import__("os").path.abspath(__file__)), "..", "..", "..", "tools"))
    import fs112_yb2_objects as O
    t = O.Strip().tiles(-2, 3); labs = [t[k][0] for k in ("T0", "T1", "T2", "U-1", "U0", "U1")]
    good = (ok and meet and inner_T1 == [-1, -1, -1] and inner_T0 == [-1, -1, -1] and outer_T2 == 1 and
            all(c == (True, -1, 1) for c in cross.values()) and region == (1, 1, -1) and len(set(labs)) == 6)
    print(f"w-at-distance-1-from-V1,V0,A-1,A1={ok} circles-meet-S(w)-at-the-members={meet} T1-part-inner={inner_T1} T0-part-inner={inner_T0} "
          f"T2-part-has-a-point-outside={outer_T2 == 1} arches-crossing={[cross[j] == (True, -1, 1) for j in (-1, 0, 1)]} "
          f"direction-(12,5)/13:outside-S(V1),outside-S(A-1),inside-S(A1)={region == (1, 1, -1)} labels-T0,T1,T2,U-1,U0,U1={''.join(labs)} "
          + ("edge: OK" if good else "edge: FAULT-SEEN"))
    return 0


def seven():
    r = R(2, 5); ap = s3 * r / 2
    cen = lambda m, n: (m * 2 * ap + n * ap, n * 3 * r / 2); col = lambda m, n: (m + 3 * n) % 7
    # an up vertex is the centroid of the hexagons (m, n), (m + 1, n), (m, n + 1); a down vertex of (m + 1, n), (m, n + 1), (m + 1, n + 1)
    def vert(t, m, n):
        hs = [(m, n), (m + 1, n), (m, n + 1)] if t == "up" else [(m + 1, n), (m, n + 1), (m + 1, n + 1)]
        return tuple(sum(cen(*hx)[i] for hx in hs) / 3 for i in (0, 1)), {col(*hx) for hx in hs}
    (x, tx), found = vert("up", 0, 0), None
    for t in (("up",) if FAULT else ("up", "down")):                     # the first vertex of the window that works with x, in a fixed order: an instance, not a search
        for m in range(-3, 4):
            for n in range(-3, 4):
                y, ty = vert(t, m, n)
                dd = sp.simplify(d2(x, y))
                if found or (tx & ty) or not (0 < dd < 4): continue
                mid = ((x[0] + y[0]) / 2, (x[1] + y[1]) / 2); h = sp.sqrt(1 - dd / 4)
                nrm = ((y[1] - x[1]) / sp.sqrt(dd), -(y[0] - x[0]) / sp.sqrt(dd))
                w = (mid[0] + h * nrm[0], mid[1] + h * nrm[1])
                for a in range(-5, 6):
                    for b in range(-5, 6):
                        if not found and sp.N(d2(w, cen(a, b)) - ap ** 2) < 0 and sgn(d2(w, cen(a, b)) - ap ** 2) == -1 and col(a, b) not in tx | ty:
                            found = (t, m, n, sorted(ty), dd, (a, b), col(a, b))
    if found:
        print(f"circumradius={r} x=up(0,0) x-labels={sorted(tx)} y={found[0]}({found[1]},{found[2]}) y-labels={found[3]} squared-distance={found[4]} "
              f"common-unit-point-strictly-inside-the-inscribed-disc-of-hexagon={found[5]} of-label={found[6]} seven: OK")
    else:
        print(f"circumradius={r} x=up(0,0) x-labels={sorted(tx)} no vertex of the window has a disjoint triple under 2 apart with a common unit point "
              f"strictly inside an inscribed disc of the seventh label: seven: FAULT-SEEN")
    return 0


def second():
    """C124-SECOND's count: x's saving edges at w and w' are two of the pairs of {0,1,2}, y's two of the pairs of {3,4,5}; the three
    pairs read at a point are the two edges and the absent pair.  For every choice with different edges at the two points: the label
    sets' intersection size, whether the absent pairs are disjoint, whether the six pairs form one hexagon alternating between the
    points.  --fault allows the same edge of x at both points."""
    import itertools as I
    E3 = lambda S: list(I.combinations(S, 2)); cases = cyc = disj = 0; common = set()
    for xa, xb in I.product(E3((0, 1, 2)), repeat=2):
        for ya, yb in I.product(E3((3, 4, 5)), repeat=2):
            if (xa == xb and not FAULT) or ya == yb: continue
            third = lambda pr, S: (set(S) - set(pr)).pop()
            M = [xa, ya, (third(xa, (0, 1, 2)), third(ya, (3, 4, 5)))]; N = [xb, yb, (third(xb, (0, 1, 2)), third(yb, (3, 4, 5)))]
            cases += 1; common.add(len((set(xa) | set(ya)) & (set(xb) | set(yb)))); disj += not (set(M[2]) & set(N[2]))
            v, k, turn = 0, 0, 0
            while True:
                pr = next(q for q in (M, N)[turn] if v in q); v = pr[0] if pr[1] == v else pr[1]; k += 1; turn ^= 1
                if v == 0 and turn == 0 or k > 12: break
            cyc += k == 6
    print(f"cases={cases} labels-in-common={sorted(common)} absent-pairs-disjoint={disj} one-alternating-hexagon={cyc} " + ("second: OK" if (cases, disj, cyc) == (36, 36, 36) and common == {2} else "second: FAULT-SEEN"))
    return 0


if __name__ == "__main__":
    fn = {"edge": edge, "seven": seven, "second": second}.get(next((a for a in sys.argv[1:] if not a.startswith("--")), ""))
    if fn is None: print(__doc__); sys.exit(2)
    sys.exit(fn())
