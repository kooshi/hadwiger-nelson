#!/usr/bin/env python3
"""FS-70, the product owner's decorrelated verifier for point sets in Q(sqrt3, sqrt5)^2.

Shares no code with any finder, checker or tool under tools/.  Standard library only, except that the
`ask` command uses PySAT (an untrusted second opinion, never a certificate).

A point is an integer 9-tuple (a, b, c, d, e, f, g, h, m), m > 0, standing for
    x = (a + b*sqrt3 + c*sqrt5 + d*sqrt15) / m,   y = (e + f*sqrt3 + g*sqrt5 + h*sqrt15) / m.
Every verdict about edges comes from a sweep over ALL unordered pairs in exact integer arithmetic:
|P - Q|^2 = 1 holds iff the sqrt3, sqrt5, sqrt15 parts of the numerator vanish and the rational part
equals the squared denominator.  No bucketing, no floats, no proposal step.

Commands
  edges  FILE            re-derive every unit pair; print the count and compare with FILE's "edges" if present
  colour FILE            FILE has "colours" (one integer per point): verify it is proper on the re-derived edges,
                         and honours "pin_equal": [[i, j], ...] (each pair same colour) and "pin_distinct" if present
  ask    FILE K          untrusted second opinion: build the CNF from the re-derived edges, pin the first re-derived
                         triangle (or edge) as a symmetry break, add "pin_equal" / "pin_distinct" from FILE, and
                         ask K colours with two PySAT solvers.  UNSAT here is a proposal to be certified elsewhere.
  selftest               positive controls (rhombus, Haugland's five-point pigeonhole configuration, the FS-48
                         six-rhombus chain being 4-chromatic) and planted faults, each of which must be seen to fire.

Exit 0 only when the claim verified (or every control behaved).
"""
import json
import sys
from itertools import combinations

# ---------- exact arithmetic in Q(sqrt3, sqrt5): elements are integer 4-tuples (a, b, c, d) = a + b√3 + c√5 + d√15 ----------

def fmul(p, q):
    a1, b1, c1, d1 = p
    a2, b2, c2, d2 = q
    return (a1 * a2 + 3 * b1 * b2 + 5 * c1 * c2 + 15 * d1 * d2,
            a1 * b2 + b1 * a2 + 5 * (c1 * d2 + d1 * c2),
            a1 * c2 + c1 * a2 + 3 * (b1 * d2 + d1 * b2),
            a1 * d2 + d1 * a2 + b1 * c2 + c1 * b2)


def fadd(p, q):
    return tuple(x + y for x, y in zip(p, q))


def fsub(p, q):
    return tuple(x - y for x, y in zip(p, q))


def fscale(p, k):
    return tuple(k * x for x in p)


def parse_point(t):
    if not (isinstance(t, list) and len(t) == 9 and all(isinstance(v, int) for v in t) and t[8] > 0):
        raise ValueError(f"bad point {t!r}")
    return tuple(t)


def unit_apart(P, Q):
    """|P - Q|^2 == 1 exactly.  P, Q are 9-tuples; common denominator mP*mQ."""
    a, b, c, d, e, f, g, h, m = P
    a2, b2, c2, d2, e2, f2, g2, h2, m2 = Q
    # bring to the common denominator m*m2
    dx = fsub(fscale((a, b, c, d), m2), fscale((a2, b2, c2, d2), m))
    dy = fsub(fscale((e, f, g, h), m2), fscale((e2, f2, g2, h2), m))
    s = fadd(fmul(dx, dx), fmul(dy, dy))
    return s == ((m * m2) ** 2, 0, 0, 0)


def sq_dist_is(P, Q, target):
    """|P - Q|^2 == target, target an integer 4-tuple over denominator 1."""
    a, b, c, d, e, f, g, h, m = P
    a2, b2, c2, d2, e2, f2, g2, h2, m2 = Q
    dx = fsub(fscale((a, b, c, d), m2), fscale((a2, b2, c2, d2), m))
    dy = fsub(fscale((e, f, g, h), m2), fscale((e2, f2, g2, h2), m))
    s = fadd(fmul(dx, dx), fmul(dy, dy))
    return s == fscale(target, (m * m2) ** 2)


def all_edges(points):
    n = len(points)
    return [(i, j) for i in range(n) for j in range(i + 1, n) if unit_apart(points[i], points[j])]


def normalise(P):
    """Divide out the gcd of all nine entries so equal points compare equal."""
    from math import gcd
    g = 0
    for v in P:
        g = gcd(g, abs(v))
    g = g or 1
    return tuple(v // g for v in P)


# ---------- geometry helpers (used by selftest; exact) ----------

def rot_rho15(P):
    """(x, y) -> ((7x - sqrt15 y)/8, (sqrt15 x + 7y)/8) — the type-M n = 4 rotation, which lies in the field."""
    a, b, c, d, e, f, g, h, m = P
    x = (a, b, c, d)
    y = (e, f, g, h)
    r15 = (0, 0, 0, 1)
    nx = fsub(fscale(x, 7), fmul(r15, y))
    ny = fadd(fmul(r15, x), fscale(y, 7))
    return normalise(nx + ny + (8 * m,))


def rot_pi3(P):
    """(x, y) -> (x/2 - sqrt3 y/2, sqrt3 x/2 + y/2)."""
    a, b, c, d, e, f, g, h, m = P
    x = (a, b, c, d)
    y = (e, f, g, h)
    r3 = (0, 1, 0, 0)
    nx = fsub(x, fmul(r3, y))
    ny = fadd(fmul(r3, x), y)
    return normalise(nx + ny + (2 * m,))


def translate(P, T):
    a, b, c, d, e, f, g, h, m = P
    ta, tb, tc, td, te, tf, tg, th, tm = T
    nx = fadd(fscale((a, b, c, d), tm), fscale((ta, tb, tc, td), m))
    ny = fadd(fscale((e, f, g, h), tm), fscale((te, tf, tg, th), m))
    return normalise(nx + ny + (m * tm,))


def pt(x, y, m=1):
    """x, y as 4-tuples over a common denominator m."""
    return normalise(tuple(x) + tuple(y) + (m,))


# ---------- commands ----------

def load(path):
    with open(path) as fh:
        data = json.load(fh)
    points = [normalise(parse_point(t)) for t in data["points"]]
    if len(set(points)) != len(points):
        raise SystemExit("REFUSED DUPLICATE: a point is listed twice")
    return data, points


def cmd_edges(path):
    data, points = load(path)
    E = all_edges(points)
    print(f"points={len(points)} edges(re-derived)={len(E)}")
    if "edges" in data:
        claimed = {tuple(sorted(e)) for e in data["edges"]}
        mine = set(E)
        if claimed != mine:
            print(f"REFUSED EDGES: file lists {len(claimed)}, re-derived {len(mine)}; "
                  f"missing-from-file={len(mine - claimed)} extra-in-file={len(claimed - mine)}")
            return 1
        print("edge list matches the re-derivation")
    return 0


def cmd_colour(path):
    data, points = load(path)
    col = data["colours"]
    if len(col) != len(points):
        print("REFUSED LENGTH: colours do not cover the points")
        return 1
    E = all_edges(points)
    for i, j in E:
        if col[i] == col[j]:
            print(f"REFUSED CLASH: edge ({i},{j}) monochromatic with colour {col[i]}")
            return 1
    for i, j in data.get("pin_equal", []):
        if col[i] != col[j]:
            print(f"REFUSED PIN: pair ({i},{j}) should be equal, has {col[i]} and {col[j]}")
            return 1
    for i, j in data.get("pin_distinct", []):
        if col[i] == col[j]:
            print(f"REFUSED PIN: pair ({i},{j}) should differ, both {col[i]}")
            return 1
    print(f"VERIFIED: proper on {len(E)} re-derived edges with {len(set(col))} colours; pins honoured")
    return 0


def build_cnf(n, E, k, pin_equal=(), pin_distinct=(), break_sym=True):
    var = lambda v, c: v * k + c + 1
    cnf = []
    for v in range(n):
        cnf.append([var(v, c) for c in range(k)])
        for c1, c2 in combinations(range(k), 2):
            cnf.append([-var(v, c1), -var(v, c2)])
    for i, j in E:
        for c in range(k):
            cnf.append([-var(i, c), -var(j, c)])
    for i, j in pin_equal:
        for c in range(k):
            cnf.append([-var(i, c), var(j, c)])
            cnf.append([var(i, c), -var(j, c)])
    for i, j in pin_distinct:
        for c in range(k):
            cnf.append([-var(i, c), -var(j, c)])
    if break_sym and E:
        adj = {}
        for i, j in E:
            adj.setdefault(i, set()).add(j)
            adj.setdefault(j, set()).add(i)
        tri = None
        for i, j in E:
            common = adj[i] & adj[j]
            if common:
                tri = (i, j, min(common))
                break
        pins = tri if tri else E[0]
        for c, v in enumerate(pins[:k]):
            cnf.append([var(v, c)])
    return cnf, n * k


def cmd_ask(path, k):
    from pysat.solvers import Solver
    data, points = load(path)
    E = all_edges(points)
    cnf, nv = build_cnf(len(points), E, k, data.get("pin_equal", []), data.get("pin_distinct", []))
    print(f"points={len(points)} edges={len(E)} k={k} vars={nv} clauses={len(cnf)}")
    verdicts = []
    for name in ("cadical195", "glucose4"):
        with Solver(name=name, bootstrap_with=cnf) as s:
            sat = s.solve()
            verdicts.append((name, sat))
            print(f"  {name}: {'SAT' if sat else 'UNSAT'}")
            if sat:
                model = set(x for x in s.get_model() if x > 0)
                col = [next(c for c in range(k) if v * k + c + 1 in model) for v in range(len(points))]
                for i, j in E:
                    assert col[i] != col[j]
                print("  (model re-verified proper on the re-derived edges)")
    if len({v for _, v in verdicts}) != 1:
        print("REFUSED DISAGREEMENT between solvers")
        return 2
    return 0


# ---------- selftest ----------

def rhombus():
    # 0, 1, (1/2, √3/2), (3/2, √3/2)
    return [pt((0, 0, 0, 0), (0, 0, 0, 0)), pt((1, 0, 0, 0), (0, 0, 0, 0)),
            pt((1, 0, 0, 0), (0, 1, 0, 0), 2), pt((3, 0, 0, 0), (0, 1, 0, 0), 2)]


def fs48_chain():
    """Six rhombi chained by the identity 1/√3 = −(1 + u + ū)(ζ₁₂ + ζ̄₁₂), u = (−2 + i√5)/3.
    Each rhombus forces its far tips (distance √3 apart) equal in every 3-colouring; the chain of six
    steps of length 1/√3 · √3 = 1 ... assembled as: tip pairs at difference √3·w_j for the six unit
    vectors w_j with Σ √3·w_j = ... — here we simply build the 18-point object as six rhombi whose far
    tips chain from 0 to a point at distance 1 from 0, then add that closing edge, and ask 3 colours."""
    # Unit vectors w with Σ_j w_j = 1/√3 (six of them): -(1+u+ū)(ζ12+ζ12^-1) expanded.
    # ζ12 = (√3/2, 1/2), ζ12^-1 = (√3/2, -1/2); u = (-2/3, √5/3), ū = (-2/3, -√5/3); as complex numbers.
    def cx(x, y, m):  # complex number with field coords over denominator m
        return (tuple(x), tuple(y), m)

    def cmul(p, q):
        x1, y1, m1 = p
        x2, y2, m2 = q
        return (fsub(fmul(x1, x2), fmul(y1, y2)), fadd(fmul(x1, y2), fmul(y1, x2)), m1 * m2)

    def cneg(p):
        return (fscale(p[0], -1), fscale(p[1], -1), p[2])

    one = cx((1, 0, 0, 0), (0, 0, 0, 0), 1)
    u = cx((-2, 0, 0, 0), (0, 0, 1, 0), 3)
    ub = cx((-2, 0, 0, 0), (0, 0, -1, 0), 3)
    z = cx((0, 1, 0, 0), (1, 0, 0, 0), 2)
    zb = cx((0, 1, 0, 0), (-1, 0, 0, 0), 2)
    ws = [cneg(cmul(a, b)) for a in (one, u, ub) for b in (z, zb)]
    # each w_j is a unit vector; the rhombus on the segment from p to p + √3·(direction w_j) is:
    # tips p and p + √3 w_j i.e. p + w_j·(√3): the rhombus with tips T0, T1 = T0 + √3 w has side vertices
    # T0 + w·ζ12^{-1}·... simpler: an equilateral-triangle pair on the base from T0 to T0 + w·√3... we use the
    # standard rhombus: vertices T0, T0 + w·e^{iπ/6}, T0 + w·e^{-iπ/6}, T0 + w·√3 (all unit sides).
    e6 = cx((0, 1, 0, 0), (1, 0, 0, 0), 2)     # e^{iπ/6} = (√3/2, 1/2)
    e6b = cx((0, 1, 0, 0), (-1, 0, 0, 0), 2)   # e^{-iπ/6}
    s3 = cx((0, 1, 0, 0), (0, 0, 0, 0), 1)     # √3

    def cadd(p, q):
        x1, y1, m1 = p
        x2, y2, m2 = q
        return (fadd(fscale(x1, m2), fscale(x2, m1)), fadd(fscale(y1, m2), fscale(y2, m1)), m1 * m2)

    def topt(p):
        return normalise(p[0] + p[1] + (p[2],))

    pts = []
    structural = []  # the 5 edges of each rhombus, as point pairs, plus the closing edge
    T = cx((0, 0, 0, 0), (0, 0, 0, 0), 1)
    start = topt(T)
    for w in ws:
        t0, s1, s2 = topt(T), topt(cadd(T, cmul(w, e6))), topt(cadd(T, cmul(w, e6b)))
        T = cadd(T, cmul(w, s3))
        t1 = topt(T)
        pts += [t0, s1, s2]
        structural += [(t0, s1), (t0, s2), (s1, s2), (s1, t1), (s2, t1)]
    end = topt(T)
    pts.append(end)
    structural.append((start, end))
    # the chain's total displacement is √3 · Σ w_j = √3 · (1/√3) = 1, so start and end are at distance 1
    pts = list(dict.fromkeys(pts))
    idx = {p: i for i, p in enumerate(pts)}
    structural = sorted({tuple(sorted((idx[p], idx[q]))) for p, q in structural})
    return pts, start, end, structural


def cmd_selftest():
    ok = True

    def check(name, cond):
        nonlocal ok
        print(f"  [{'ok' if cond else 'FAIL'}] {name}")
        ok = ok and cond

    R = rhombus()
    E = all_edges(R)
    check("rhombus has 5 unit edges", len(E) == 5)
    check("rhombus far tips at distance √3", sq_dist_is(R[0], R[3], (3, 0, 0, 0)))
    check("ρ₁₅ preserves unit distance (rotated rhombus has 5 edges)", len(all_edges([rot_rho15(p) for p in R])) == 5)
    check("ρ₁₅ of (1,0) is (7/8, √15/8)", rot_rho15(pt((1, 0, 0, 0), (0, 0, 0, 0))) == pt((7, 0, 0, 0), (0, 0, 0, 1), 8))
    check("π/3 rotation preserves unit distance", len(all_edges([rot_pi3(p) for p in R])) == 5)
    # Haugland's five points: (−1,0),(0,0),(1,0),(−1/2,√3/2),(1/2,√3/2): 7 unit edges, 2 pairs at √3, 1 pair at 2
    H = [pt((-1, 0, 0, 0), (0, 0, 0, 0)), pt((0, 0, 0, 0), (0, 0, 0, 0)), pt((1, 0, 0, 0), (0, 0, 0, 0)),
         pt((-1, 0, 0, 0), (0, 1, 0, 0), 2), pt((1, 0, 0, 0), (0, 1, 0, 0), 2)]
    EH = all_edges(H)
    s3pairs = [(i, j) for i, j in combinations(range(5), 2) if sq_dist_is(H[i], H[j], (3, 0, 0, 0))]
    two = [(i, j) for i, j in combinations(range(5), 2) if sq_dist_is(H[i], H[j], (4, 0, 0, 0))]
    check("Haugland's five points: 7 unit edges", len(EH) == 7)
    check("… two pairs at √3: (−1,0)-(½,√3/2) and (1,0)-(−½,√3/2)", set(s3pairs) == {(0, 4), (2, 3)})
    check("… one pair at 2: (−1,0)-(1,0)", two == [(0, 2)])
    # the pigeonhole: with the √3 pairs as distinct-pins, four colours force (0,2) equal
    try:
        from pysat.solvers import Solver
        cnf, _ = build_cnf(5, EH, 4, pin_distinct=s3pairs + [(0, 2)], break_sym=False)
        with Solver(name="cadical195", bootstrap_with=cnf) as s:
            check("pigeonhole: 4 colours with the two √3 pins AND (−1,0)≠(1,0) is UNSAT", not s.solve())
        cnf, _ = build_cnf(5, EH, 4, pin_distinct=s3pairs, break_sym=False)
        with Solver(name="cadical195", bootstrap_with=cnf) as s:
            check("pigeonhole: 4 colours with only the two √3 pins is SAT", s.solve())
        # FS-48's six-rhombus chain: 3 colours UNSAT with the closing edge, 4 colours SAT
        C, a, b, ST = fs48_chain()
        EC = all_edges(C)
        ia, ib = C.index(a), C.index(b)
        check(f"FS-48 chain: 19 points, closing pair at distance 1 (got {len(C)} points)", len(C) == 19 and (ia, ib) in set(EC))
        check(f"FS-48 chain: the 31 structural edges (6 rhombi × 5 + the closing edge) are all re-derived; total {len(EC)} "
              f"(the 3 extra are coincidental unit distances in the field)", len(ST) == 31 and set(ST) <= set(EC) and len(EC) == 34)
        cnf, _ = build_cnf(len(C), EC, 3)
        with Solver(name="cadical195", bootstrap_with=cnf) as s:
            check("FS-48 chain refuses 3 colours", not s.solve())
        cnf, _ = build_cnf(len(C), EC, 4)
        with Solver(name="cadical195", bootstrap_with=cnf) as s:
            check("FS-48 chain admits 4 colours", s.solve())
        # planted fault: drop the closing edge (remove the end point) — must become 3-colourable
        C2 = [p for p in C if p != b]
        cnf, _ = build_cnf(len(C2), all_edges(C2), 3)
        with Solver(name="cadical195", bootstrap_with=cnf) as s:
            check("plant: chain without its closing point is 3-colourable (the closing edge is load-bearing)", s.solve())
    except ImportError:
        check("PySAT available for the solver controls", False)
    # planted faults on the edge sweep
    R2 = list(R)
    R2[3] = pt((3, 0, 0, 0), (1, 1, 0, 0), 2)  # move a point off the circle
    check("plant: moved point loses its two edges", len(all_edges(R2)) == 3)
    R3 = list(R)
    R3[3] = pt((3, 0, 0, 1), (0, 1, 0, 0), 2)  # add a √15/2 to x: not unit apart from anything
    check("plant: a √15 perturbation is refused as an edge", len(all_edges(R3)) == 3)
    print("SELFTEST", "PASSED" if ok else "FAILED")
    return 0 if ok else 1


def main(argv):
    if len(argv) < 2:
        print(__doc__)
        return 2
    cmd = argv[1]
    if cmd == "edges":
        return cmd_edges(argv[2])
    if cmd == "colour":
        return cmd_colour(argv[2])
    if cmd == "ask":
        return cmd_ask(argv[2], int(argv[3]))
    if cmd == "selftest":
        return cmd_selftest()
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))
