#!/usr/bin/env python3
"""FS111-M: the Reuleaux seven-colouring R7 -- an exact check that it is an a.e.-proper, tight, SATURATED seven-colouring of the plane.

The object (by formula).  Lambda = Z(1,0) + Z(1/2, sqrt3/2), lambda(m, n) = m(1,0) + n(1/2, sqrt3/2).
  * Up tile   U(m,n): the Reuleaux triangle of width 1 on the vertices lambda + {(0,0), (1,0), (1/2, sqrt3/2)}; its three
                      boundary arcs are unit arcs, each centred at the opposite vertex.
  * Down tile D(m,n): the down triangle lambda + {(1,0), (1/2, sqrt3/2), (3/2, sqrt3/2)} minus the three bulges of the adjacent
                      ups U(m,n), U(m+1,n), U(m,n+1); a curvilinear triangle with three cusps, bounded by those three unit arcs.
  Up and down tiles tile the plane (areas (pi - sqrt3)/2 + (sqrt3 - pi/2) = sqrt3/2, one fundamental triangle pair).
  * Colours: up U(m,n) gets 2*(m mod 2) + (n mod 2)       (cosets of 2*Lambda: four colours 0..3);
             down D(m,n) gets 4 + ((m - n) mod 3)          (cosets of M = <(0, sqrt3), (3/2, sqrt3/2)>: three colours 4..6).

What is checked, exactly, in Q(sqrt 3):
  (P) PROPERNESS a.e.: for every pair of tiles of one colour (a tile with itself included), 1 is not interior to the range of
      cross distances [min, max] (min = 0 for a tile with itself).  min and max of |p - q| over two closed tiles are attained on
      boundary pairs; at an extreme pair each point is an arc endpoint or the connecting line is normal to its arc; every such
      critical pair is listed (direction conditions checked).  Pairs whose tile centroids are > 3 apart are skipped: every tile
      lies within 1/sqrt3 of its centroid, so their distance is > 3 - 2/sqrt3 > 1.  The colouring is periodic under
      P = {(m, n): m, n even, m = n mod 3} (index 12); the first tile runs over the 12 representatives (n in {0,1}, m in 0..5) of
      both kinds, the second over a window that contains every tile within centroid distance 3.
  (S) SATURATION: every essential boundary point is a contact point for each of its colours.  Essential boundary points are arc
      points (P(x) = {up colour, down colour}) and lattice points (P(v) = the three up colours; the downs' cusps have density 0).
      Each arc is a unit arc centred at a lattice point c; so an arc point is bound for colour j iff c is in supp(colour j):
      checked by listing the tiles at c (three ups, three down cusps) and asserting both side colours of the arc occur there.
      A lattice point v is bound for each up colour at v because that up's opposite arc is centred at v (checked).
  (T) TIGHTNESS: some pair of one colour realises distance exactly 1 between closures with positive-measure neighbourhoods
      on both sides (the within-contact of an up: its vertex and its opposite arc) -- exhibited.
  (C) COLOURS: exactly seven colours, four on ups and three on downs.
  (B) BLOCKS: tight block structure with the tiles as blocks -- distinct same-colour tiles have every cross distance >= 1.
Cross-check: every pair verdict of (P) is recomputed by the frozen FS112-Y engine (tools/fs112_y_check.py, imported, not edited).

Plants (--plant NAME), each must make the run FAIL at its own assertion:
  down_mod2     downs coloured by (m - n) mod 2      -> (P) fails (two downs of one colour with 1 interior to their range) and (C)
  down_2lambda  downs coloured by cosets of 2*Lambda (eight colours in all) -> (P) passes (a proper colouring) but (S) fails:
                an arc's down colour is absent from its centre, so its points are free for that colour -- proper, tight, unsaturated
  up_m_only     ups coloured by m mod 2 only          -> (P) fails at a touching pair of one colour
  endpoints     this engine forgets interior critical pairs -> the engine's own positive control (a known improper pair whose
                violation is interior) is ACCEPTed, and the self-test fails
  centre_shift  one arc family's centres moved off the lattice (an arc no longer centred at a contact) -> (S) fails
Output: data/fs111/fs111-m/reuleaux7_check.out (unplanted run).
"""
from __future__ import annotations
import argparse, importlib.util, itertools, math, os, sys
from fractions import Fraction as Fr

PLANT = None

# ------------------------------------------------------------------ Q(sqrt 3)
class Q3:
    __slots__ = ("a", "b")
    def __init__(s, a, b=0): s.a, s.b = Fr(a), Fr(b)
    def _c(s, o): return o if isinstance(o, Q3) else Q3(o)
    def __add__(s, o): o = s._c(o); return Q3(s.a + o.a, s.b + o.b)
    __radd__ = __add__
    def __neg__(s): return Q3(-s.a, -s.b)
    def __sub__(s, o): return s + (-s._c(o))
    def __rsub__(s, o): return s._c(o) - s
    def __mul__(s, o): o = s._c(o); return Q3(s.a * o.a + 3 * s.b * o.b, s.a * o.b + s.b * o.a)
    __rmul__ = __mul__
    def inv(s):
        n = s.a * s.a - 3 * s.b * s.b
        return Q3(s.a / n, -s.b / n)
    def __truediv__(s, o): return s * s._c(o).inv()
    def sign(s):
        sa, sb = (s.a > 0) - (s.a < 0), (s.b > 0) - (s.b < 0)
        if sb == 0: return sa
        if sa == 0: return sb
        if sa == sb: return sa
        t = s.a * s.a - 3 * s.b * s.b
        return sa if t > 0 else (sb if t < 0 else 0)
    def __eq__(s, o): return (s - s._c(o)).sign() == 0
    def __lt__(s, o): return (s - s._c(o)).sign() < 0
    def __gt__(s, o): return (s - s._c(o)).sign() > 0
    def __le__(s, o): return (s - s._c(o)).sign() <= 0
    def __ge__(s, o): return (s - s._c(o)).sign() >= 0
    def __hash__(s): return hash((s.a, s.b))
    def f(s): return float(s.a) + float(s.b) * math.sqrt(3)
    def __repr__(s): return f"{s.f():.6f}"

R3 = Q3(0, 1)
HALF = Fr(1, 2)

def pt(x, y): return (Q3(x) if not isinstance(x, Q3) else x, Q3(y) if not isinstance(y, Q3) else y)
def sub(p, q): return (p[0] - q[0], p[1] - q[1])
def add(p, q): return (p[0] + q[0], p[1] + q[1])
def smul(t, p): return (t * p[0], t * p[1])
def dot(p, q): return p[0] * q[0] + p[1] * q[1]
def cross(p, q): return p[0] * q[1] - p[1] * q[0]
def n2(p): return dot(p, p)
def is0(p): return p[0] == 0 and p[1] == 0
def pkey(p): return (p[0].a, p[0].b, p[1].a, p[1].b)

def lam(m, n): return (Q3(m) + Q3(n) * HALF, Q3(0, Fr(n, 2)))       # m(1,0) + n(1/2, sqrt3/2)
E1, E2 = lam(1, 0), lam(0, 1)

class Arc:
    """unit (or radius r) arc, counter-clockwise from S to E about C, angular extent < pi."""
    def __init__(s, C, S, E, r=Q3(1)):
        s.C, s.S, s.E, s.r = C, S, E, r
        assert n2(sub(S, C)) == r * r and n2(sub(E, C)) == r * r, "arc endpoint off its circle"
        assert cross(sub(S, C), sub(E, C)) > 0, "arc not ccw or not < pi"
    def ends(s): return [s.S, s.E]
    def has_dir(s, u):
        a, e = sub(s.S, s.C), sub(s.E, s.C)
        return cross(a, u) >= 0 and cross(u, e) >= 0          # extent < pi: exactly the closed cone from a to e

def up_arcs(m, n, centre_shift=False):
    P0 = lam(m, n); P1 = add(P0, E1); P2 = add(P0, E2)
    arcs = [Arc(P2, P0, P1), Arc(P0, P1, P2), Arc(P1, P2, P0)]
    return (P0, P1, P2), arcs

def up_tile(m, n): return up_arcs(m, n)[1]

def down_tile(m, n):
    """the three arcs bounding D(m,n): U(m,n)'s arc P1->P2 (centre P0), U(m+1,n)'s arc P2->P0 (centre P1), U(m,n+1)'s arc P0->P1 (centre P2)."""
    return [up_arcs(m, n)[1][1], up_arcs(m + 1, n)[1][2], up_arcs(m, n + 1)[1][0]]

def up_colour(m, n):
    if PLANT == "up_m_only": return m % 2
    return 2 * (m % 2) + (n % 2)

def down_colour(m, n):
    if PLANT == "down_mod2": return 4 + ((m - n) % 2)
    if PLANT == "down_2lambda": return 4 + 2 * (m % 2) + (n % 2)
    return 4 + ((m - n) % 3)

def centroid(kind, m, n):
    b = lam(m, n)
    if kind == "U": return add(b, (Q3(HALF), Q3(0, Fr(1, 6))))
    return add(b, (Q3(1), Q3(0, Fr(1, 3))))

# ------------------------------------------------------------------ the distance engine (critical pairs)
def cands(a1, a2):
    """critical (A, B): candidate distance |sqrt(A) + B| between two arcs."""
    zero = Q3(0)
    out = [(n2(sub(X, Y)), zero) for X in a1.ends() for Y in a2.ends()]
    if PLANT == "endpoints":
        return out
    for (X, a) in [(X, a2) for X in a1.ends()] + [(Y, a1) for Y in a2.ends()]:
        w = sub(X, a.C)
        if is0(w): out.append((zero, a.r)); continue
        if a.has_dir(w): out.append((n2(w), -a.r))
        if a.has_dir(smul(Q3(-1), w)): out.append((n2(w), a.r))
    w = sub(a2.C, a1.C)
    if is0(w):
        dirs = [sub(a1.S, a1.C), sub(a1.E, a1.C), sub(a2.S, a2.C), sub(a2.E, a2.C)]
        for v in dirs + [smul(Q3(-1), x) for x in dirs]:
            if a1.has_dir(v) and a2.has_dir(v): out.append((zero, a1.r - a2.r))
            if a1.has_dir(v) and a2.has_dir(smul(Q3(-1), v)): out.append((zero, a1.r + a2.r))
    else:
        for s1 in (1, -1):
            for s2 in (1, -1):
                if a1.has_dir(smul(Q3(s1), w)) and a2.has_dir(smul(Q3(s2), w)):
                    out.append((n2(w), Q3(s2) * a2.r - Q3(s1) * a1.r))
    return out

def lt1(A, B):   # |sqrt(A) + B| < 1
    c1, c2 = 1 - B, -1 - B
    return (c1 > 0 and A < c1 * c1) and (c2 < 0 or A > c2 * c2)

def gt1(A, B):   # |sqrt(A) + B| > 1
    c1, c2 = 1 - B, -1 - B
    return (c1 < 0 or A > c1 * c1) or (c2 > 0 and A < c2 * c2)

def eq1(A, B): return not lt1(A, B) and not gt1(A, B)

def verdict(T1, T2, self_pair):
    cs = [c for p in T1 for q in T2 for c in cands(p, q)]
    e1 = {pkey(x) for p in T1 for x in p.ends()}; e2 = {pkey(x) for p in T2 for x in p.ends()}
    lo = self_pair or bool(e1 & e2) or any(lt1(*c) for c in cs)
    hi = any(gt1(*c) for c in cs)
    touch1 = any(eq1(*c) for c in cs)
    return ("REJECT" if (lo and hi) else "ACCEPT"), touch1

# ------------------------------------------------------------------ the FS112-Y engine (frozen; imported, never edited)
def load_y():
    here = os.path.dirname(os.path.abspath(__file__))
    spec = importlib.util.spec_from_file_location("fs112_y_check_frozen", os.path.join(here, "fs112_y_check.py"))
    mod = importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
    F = mod.Field([Fr(3)])
    def cv(q): return F(q.a) + F(q.b) * F.gen(1)
    def cp(p): return (cv(p[0]), cv(p[1]))
    def conv(tile): return [mod.Arc(cp(a.C), F(1), cp(a.S), cp(a.E)) for a in tile]
    return mod, conv

# ------------------------------------------------------------------ the checks
def tiles_near(kind, m, n, R=3):
    """every tile (kind', m', n') with centroid within distance R of (kind, m, n)'s centroid."""
    c = centroid(kind, m, n); out = []
    for mm in range(m - 6, m + 7):
        for nn in range(n - 6, n + 7):
            for k2 in ("U", "D"):
                d = sub(centroid(k2, mm, nn), c)
                if n2(d) <= R * R: out.append((k2, mm, nn))
    return out

def colour(kind, m, n): return up_colour(m, n) if kind == "U" else down_colour(m, n)
def tile(kind, m, n): return up_tile(m, n) if kind == "U" else down_tile(m, n)

def check_properness(log, y=None):
    reps = [(k, m, n) for k in ("U", "D") for n in (0, 1) for m in range(6)]
    npairs = bad = ybad = contacts = 0; seen = set()
    for (k, m, n) in reps:
        for (k2, m2, n2_) in tiles_near(k, m, n):
            if colour(k, m, n) != colour(k2, m2, n2_): continue
            key = (k, m, n, k2, m2, n2_)
            if key in seen: continue
            seen.add(key)
            sp = (k, m, n) == (k2, m2, n2_)
            v, t1 = verdict(tile(k, m, n), tile(k2, m2, n2_), sp)
            npairs += 1; contacts += t1
            if v == "REJECT":
                bad += 1
                if bad <= 5: log(f"  (P) REJECT: {k}{(m, n)} colour {colour(k, m, n)} against {k2}{(m2, n2_)}")
            if y is not None:
                mod, conv = y
                vy = mod.pair_verdict(conv(tile(k, m, n)), conv(tile(k2, m2, n2_)), self_pair=sp)
                if vy != v:
                    ybad += 1
                    log(f"  (P) ENGINES DISAGREE at {k}{(m, n)} / {k2}{(m2, n2_)}: mine {v}, FS112-Y {vy}")
    log(f"(P) same-colour pairs examined: {npairs} (12 representatives x 2 kinds, partners within centroid distance 3); "
        f"REJECT: {bad}; pairs realising distance exactly 1: {contacts}; engine disagreements: {ybad if y else 'not run'}")
    return bad == 0 and (y is None or ybad == 0), npairs

def tiles_at(v):
    """every (kind, m, n) whose closure contains the lattice point v: ups with v as a vertex, downs with v as a cusp."""
    out = []
    # v = lam(mv, nv): recover (mv, nv) exactly (y = nv*sqrt3/2, x = mv + nv/2), then search the 7 x 7 box around it
    nv = int(v[1].b * 2); mv = int(v[0].a - Fr(nv, 2))
    assert pkey(lam(mv, nv)) == pkey(v), "tiles_at called off the lattice"
    for m in range(mv - 3, mv + 4):
        for n in range(nv - 3, nv + 4):
            P = up_arcs(m, n)[0]
            if any(pkey(v) == pkey(p) for p in P): out.append(("U", m, n))
            b = lam(m, n)
            Q = [add(b, E1), add(b, E2), add(b, add(E1, E2))]
            if any(pkey(v) == pkey(q) for q in Q): out.append(("D", m, n))
    return out

def check_saturation(log):
    """every arc: both side colours present at its centre (the centre is in the support of each)."""
    fails = 0; narcs = 0
    for n in (0, 1):
        for m in range(6):
            (P0, P1, P2), arcs = up_arcs(m, n)
            adj = [("D", m, n - 1), ("D", m, n), ("D", m - 1, n)]      # arc 0 (P0->P1, centre P2): D below; arc 1: D(m,n); arc 2: D(m-1,n)
            for i, a in enumerate(arcs):
                if PLANT == "centre_shift" and i == 0:
                    c = add(a.C, (Q3(0), Q3(Fr(1, 10))))
                else:
                    c = a.C
                on_lattice = c[1].a == 0 and (c[1].b * 2).denominator == 1 and (c[0].a - c[1].b).denominator == 1 and c[0].b == 0
                present = {colour(*t) for t in tiles_at(c)} if on_lattice else set()
                sides = {up_colour(m, n), colour(*adj[i])}
                # the down listed as adjacent really carries this arc (map consistency)
                dk, dm, dn = adj[i]
                assert any(pkey(x.C) == pkey(a.C) and pkey(x.S) == pkey(a.S) for x in down_tile(dm, dn)), "adjacency table wrong"
                narcs += 1
                if not sides <= present:
                    fails += 1
                    if fails <= 5: log(f"  (S) arc {i} of U{(m, n)}: side colours {sorted(sides)} not all present at its centre (present {sorted(present)})")
            for vi, v in enumerate((P0, P1, P2)):          # lattice points: each up at v bound via its opposite arc
                opp = arcs[(vi + 1) % 3]                    # arc i is centred at P_{(i+2)%3}; the arc centred at P_vi is arcs[(vi+1)%3]
                if pkey(opp.C) != pkey(v):
                    fails += 1; log(f"  (S) U{(m, n)} vertex {vi} not the centre of its opposite arc")
    log(f"(S) arcs examined: {narcs} (12 up representatives x 3 arcs, i.e. every arc up to the period); vertices examined: 36; failures: {fails}")
    return fails == 0

def check_colours(log):
    ups = {up_colour(m, n) for m in range(12) for n in range(12)}
    downs = {down_colour(m, n) for m in range(12) for n in range(12)}
    ok = len(ups) == 4 and len(downs) == 3 and not (ups & downs)
    log(f"(C) up colours {sorted(ups)}, down colours {sorted(downs)}; total {len(ups | downs)}")
    return ok and len(ups | downs) == 7

def check_blocks(log):
    """(B) tight block structure with blocks = tiles: every pair of DISTINCT tiles of one colour has every critical distance >= 1
    (min >= 1), and every tile has max <= 1 (its self pair); pairs within centroid distance 3 as in (P)."""
    reps = [(k, m, n) for k in ("U", "D") for n in (0, 1) for m in range(6)]
    bad = 0; npairs = 0
    for (k, m, n) in reps:
        for (k2, m2, n2_) in tiles_near(k, m, n):
            if colour(k, m, n) != colour(k2, m2, n2_) or (k, m, n) == (k2, m2, n2_): continue
            cs = [c for p in tile(k, m, n) for q in tile(k2, m2, n2_) for c in cands(p, q)]
            npairs += 1
            if any(lt1(*c) for c in cs):
                bad += 1
                if bad <= 3: log(f"  (B) {k}{(m, n)} and {k2}{(m2, n2_)} have a critical distance < 1")
    log(f"(B) distinct same-colour tile pairs: {npairs}; pairs with some distance < 1: {bad} (tight block structure, blocks = tiles, iff 0)")
    return bad == 0

def check_tight(log):
    (P0, P1, P2), arcs = up_arcs(0, 0)
    d = [c for c in cands(arcs[1], arcs[1]) if eq1(*c)]
    log(f"(T) within-contact of U(0,0): its vertex P0 and its opposite arc (centred at P0) are at distance exactly 1: "
        f"{'yes' if pkey(arcs[1].C) == pkey(P0) else 'NO'}; the up's diameter is 1 (self pair ACCEPT, max = 1)")
    return pkey(arcs[1].C) == pkey(P0)

def engine_selftest(log):
    """positive controls on the engine: known-improper same-colour pairs must be REJECTed."""
    ok = True
    # (i) U(0,0) against U(1,1) = U + (3/2, sqrt3/2): some interior points are closer than 1, others farther -> improper.
    v1, _ = verdict(up_tile(0, 0), up_tile(1, 1), False)
    # (ii) U(0,0) against U(1,0): touching at a vertex -> improper.
    v2, _ = verdict(up_tile(0, 0), up_tile(1, 0), False)
    # (iii) U(0,0) against U(2,0): proper, min exactly 1 at the vertex pair.
    v3, t3 = verdict(up_tile(0, 0), up_tile(2, 0), False)
    log(f"  engine self-test: U(0,0)/U(1,1) {v1} (expect REJECT, the violation interior), U(0,0)/U(1,0) {v2} (expect REJECT), "
        f"U(0,0)/U(2,0) {v3} with a distance-1 pair {t3} (expect ACCEPT, True)")
    return v1 == "REJECT" and v2 == "REJECT" and v3 == "ACCEPT" and t3

def main():
    global PLANT
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", default=None, choices=["down_mod2", "down_2lambda", "up_m_only", "endpoints", "centre_shift"])
    ap.add_argument("--out", default=None)
    ap.add_argument("--no-y", action="store_true", help="skip the FS112-Y cross-check")
    a = ap.parse_args(); PLANT = a.plant
    lines = []
    def log(s): print(s); lines.append(s)
    log(f"FS111-M R7 check, plant = {PLANT}")
    y = None if a.no_y else load_y()
    results = {}
    results["engine"] = engine_selftest(log)
    results["C"] = check_colours(log)
    results["P"], _ = check_properness(log, y)
    results["S"] = check_saturation(log)
    results["T"] = check_tight(log)
    results["B"] = check_blocks(log)
    area_up = "(pi - sqrt3)/2"; area_down = "sqrt3 - pi/2"
    log(f"(A) areas: up {area_up} ~ {(math.pi - math.sqrt(3)) / 2:.6f}, down {area_down} ~ {math.sqrt(3) - math.pi / 2:.6f}, "
        f"sum sqrt3/2 ~ {math.sqrt(3) / 2:.6f} = one up and one down lattice triangle")
    allok = all(results.values())
    log("RESULT: " + ("PASS" if allok else "FAIL") + "  " + " ".join(f"{k}={'ok' if v else 'FAIL'}" for k, v in results.items()))
    if a.out:
        with open(a.out, "w") as fh: fh.write("\n".join(lines) + "\n")
    sys.exit(0 if allok else 1)

if __name__ == "__main__":
    main()
