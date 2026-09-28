#!/usr/bin/env python3
"""FS111-VM2: M2-INTRAD's conclusions checked exactly on the controls R7, SQ9, HEX9 and the strip (row 136).

M2-INTRAD (the claim under test) says, for an honest saturated colouring with a locally finite singular set: the unit parallel
of every (tangent) interface arc is again an interface arc (partner colour on the far side, another colour on the near side),
and every interface has integer radius of curvature (segments: infinite; arcs: integers >= 1).  On a control this is
checkable edge by edge:
  * a SEGMENT edge e between tile T (colour a) and T' (colour b), unit normal n_b into T': a segment is never a (split)
    interface (those are unit arcs), so at a saturated point it is (tangent) and INTRAD predicts
      LAD+  e + n_b is covered by edges of the tiling, the tile beyond it (side +n_b) has colour a, the tile before it does not;
      LAD-  e - n_b likewise with colour b beyond (side -n_b).
    If LAD fails, the tool reports whether the edge's midpoint is saturated at all for that colour (exact point-contact test:
    some tile of the colour has dmin <= 1 <= dmax from the point).  A failing LAD at a SATURATED point would refute INTRAD;
    at an unsaturated point INTRAD is silent (its hypothesis fails there).
  * an ARC edge (radius r, centre C) between colours a and b: KB  C lies in the closure of a tile of colour a and of a tile of
    colour b (a unit arc of kind both, M-PINCH's (split) case) -- then r = 1 is INTRAD's "stops at 1"; any other radius is
    reported with its value.
All arithmetic exact (FS112-Y's field tower, imported, not edited: ℚ(√3) for SQ9, HEX9; ℚ(√3, √5) for the strip); R7's
arc test is combinatorial on the lattice (closures at lattice points are the tiles' vertices and cusps, by construction).

Plants (--plant NAME), each must fail for its own reason while the faithful twin passes:
  sq16    SQ tiles of side 1/2 coloured (i mod 4, j mod 4): proper with slack -> LAD fails (colour beyond is not a), and the
          point test shows the edge midpoints unsaturated
  hex16   HEX9's tiles coloured by the 16 cosets of 4L': -> LAD fails
  r8      R7 with the downs coloured by the four cosets of 2L (eight colours) -> KB fails on the down side
  swap    FS112-Y's own 'swap' plant of the strip (C_1, C_2 exchange colours) -> KB fails at the swapped arcs
Output: data/fs111/fs111-vm2/intrad.out, intrad_plants.out.
"""
from __future__ import annotations
import sys, itertools
from fractions import Fraction as Fr
sys.path.insert(0, "tools")
import fs112_y_check as Y
from fs112_y_check import Field, Num, Seg, Arc, sub, add, mul, dot, cross, n2, is0, closure_type, strip, lt1, gt1

PLANT = None
for i, a in enumerate(sys.argv):
    if a == "--plant":
        PLANT = sys.argv[i + 1]

OUT = []


def say(s):
    print(s)
    OUT.append(s)


# ------------------------------------------------------------------ generic exact edge tests
def unit_normals(F):
    """unit vectors at multiples of 30 degrees, exact in any field containing sqrt3 (gen 1)."""
    r3 = F.gen(1); h = F(Fr(1, 2)); z = F(0); o = F(1)
    base = [(o, z), (r3 * h, h), (h, r3 * h), (z, o)]
    out = []
    for (x, y) in base:
        for (sx, sy) in ((1, 1), (-1, 1), (1, -1), (-1, -1)):
            v = (x * sx, y * sy)
            if all(not (v[0] == w[0] and v[1] == w[1]) for w in out):
                out.append(v)
    out += [(-y, x) for (x, y) in list(out)]
    res = []
    for v in out:
        if all(not (v[0] == w[0] and v[1] == w[1]) for w in res):
            res.append(v)
    return res


def normal_of(seg, F):
    d = sub(seg.Q, seg.P)
    for v in unit_normals(F):
        if dot(v, d) == 0:
            return v
    raise ValueError("no exact unit normal in the table")


def side(tile_prims, P, n):
    """+1 / -1: the side of the line through P with normal n on which the tile lies (all endpoints on one closed side)."""
    s = set()
    for p in tile_prims:
        for X in p.ends():
            v = dot(sub(X, P), n)
            if v > 0: s.add(1)
            elif v < 0: s.add(-1)
    assert len(s) == 1, "tile straddles the edge line: side undefined"
    return s.pop()


def seg_key(s):
    a, b = (s.P[0].key(), s.P[1].key()), (s.Q[0].key(), s.Q[1].key())
    return tuple(sorted([a, b]))


def edges_of(tiles):
    """shared primitives: {key: [(tile, colour, prim)]} for segments; arcs listed separately."""
    segs, arcs = {}, {}
    for nm, (c, prims) in tiles.items():
        for p in prims:
            if isinstance(p, Seg):
                segs.setdefault(seg_key(p), []).append((nm, c, p))
            else:
                k = (p.C[0].key(), p.C[1].key(), p.r.key(), tuple(sorted([(p.S[0].key(), p.S[1].key()), (p.E[0].key(), p.E[1].key())])))
                arcs.setdefault(k, []).append((nm, c, p))
    return segs, arcs


def covered(F, tiles, P, Q):
    """is the segment PQ covered by segment primitives of the tiling?  returns (bool, [(tile, colour, prim, lo, hi)])."""
    d = sub(Q, P); L = n2(d)
    ivs = []
    for nm, (c, prims) in tiles.items():
        for p in prims:
            if not isinstance(p, Seg): continue
            if cross(d, sub(p.P, P)) == 0 and cross(d, sub(p.Q, P)) == 0:
                s1, s2 = dot(sub(p.P, P), d) / L, dot(sub(p.Q, P), d) / L
                lo, hi = (s1, s2) if s1 < s2 else (s2, s1)
                ivs.append((nm, c, p, lo, hi))
    # union covers [0, 1]?
    reach = F(0); changed = True
    while changed:
        changed = False
        for (_, _, _, lo, hi) in ivs:
            if lo <= reach and hi > reach:
                reach = hi; changed = True
    return (reach >= F(1)), ivs


def colours_at(tiles, ivs, P, d, s, n):
    """colours of tiles on the +n and -n sides at the point P + s d of the covered line."""
    plus, minus = set(), set()
    for (nm, c, p, lo, hi) in ivs:
        if lo <= s <= hi:
            sd = side(tiles[nm][1], P, n)
            (plus if sd > 0 else minus).add(c)
    return plus, minus


def point_contact(tiles, X, colour):
    """exact: is some tile of `colour` at distance exactly 1 from X (dmin <= 1 <= dmax over the tile)?"""
    zero = X[0] * 0
    for nm, (c, prims) in tiles.items():
        if c != colour: continue
        cs = []
        for p in prims:
            for Yp in p.ends():
                cs.append((n2(sub(X, Yp)), zero))
            if isinstance(p, Seg):
                d = sub(p.Q, p.P); tt = dot(sub(X, p.P), d) / n2(d)
                if zero < tt < zero + 1:
                    cs.append((n2(sub(X, add(p.P, mul(tt, d)))), zero))
            else:
                w = sub(X, p.C)
                if is0(w): cs.append((zero, p.r)); continue
                if p.has_dir(w): cs.append((n2(w), -p.r))
                if p.has_dir(mul(-1, w)): cs.append((n2(w), p.r))
        inside = colour in closure_type({nm: tiles[nm]}, X)
        le1 = inside or any(not gt1(A, B) for (A, B) in cs)
        ge1 = any(not lt1(A, B) for (A, B) in cs)
        if le1 and ge1:
            return True, nm
    return False, None


def ladder(F, tiles, test_keys, label):
    """LAD+ / LAD- for every segment edge whose key is in test_keys."""
    segs, _ = edges_of(tiles)
    n_ok = n_bad = n_uns = 0
    for key in test_keys:
        owners = segs[key]
        if len(owners) != 2:
            continue
        (ta, ca, pa), (tb, cb, pb) = owners
        P, Q = pa.P, pa.Q; d = sub(Q, P)
        n = normal_of(pa, F)
        sa = side(tiles[ta][1], P, n)
        n_b = n if sa < 0 else mul(-1, n)          # points from T_a into T_b
        for (col, shift, lab) in ((ca, n_b, "LAD+"), (cb, mul(-1, n_b), "LAD-")):
            P2, Q2 = add(P, shift), add(Q, shift)
            cov, ivs = covered(F, tiles, P2, Q2)
            good = cov
            detail = ""
            if cov:
                for s in (F(Fr(1, 3)), F(Fr(1, 2)), F(Fr(2, 3))):
                    plus, minus = colours_at(tiles, ivs, P2, d, s, shift)
                    if not (plus == {col} and col not in minus and len(minus) >= 1):
                        good = False
                        detail = f"at s={s}: beyond {sorted(plus)}, before {sorted(minus)}, wanted {col} beyond only"
                        break
            else:
                detail = "the unit parallel is not covered by edges"
            if good:
                n_ok += 1
            else:
                Xm = add(P, mul(F(Fr(1, 2)), d))
                sat, via = point_contact(tiles, Xm, col)
                if sat:
                    n_bad += 1
                    say(f"  {label} {lab} edge {ta}|{tb} colour {col}: FAIL at a SATURATED point (contact via {via}) -- {detail}")
                else:
                    n_uns += 1
                    say(f"  {label} {lab} edge {ta}|{tb} colour {col}: ladder absent -- {detail}; the edge midpoint is "
                        f"NOT saturated for colour {col} (no tile of that colour at distance exactly 1): INTRAD silent here")
    return n_ok, n_bad, n_uns


def kind_both(tiles, label, keep=lambda nm: True):
    """KB for every arc edge both of whose tiles pass `keep`: its centre lies in the closures (over the whole window) of both
    side colours; report radii."""
    _, arcs = edges_of(tiles)
    ok = bad = 0; radii = set()
    for key, owners in arcs.items():
        if len(owners) != 2 or not all(keep(nm) for nm, _, _ in owners): continue
        (ta, ca, pa), (tb, cb, pb) = owners
        radii.add(pa.r.f())
        cl = closure_type(tiles, pa.C)
        if ca in cl and cb in cl:
            ok += 1
        else:
            bad += 1
            say(f"  {label} KB arc {ta}|{tb} (colours {ca},{cb}), centre closure colours {sorted(cl)}: NOT kind both")
    return ok, bad, radii


# ------------------------------------------------------------------ the objects
def sq_tiles(mod):
    F = Field([Fr(3)], names=["3"])
    h = F(Fr(1, 2))
    tiles = {}
    for i in range(-4, 8):
        for j in range(-4, 8):
            x0, y0 = h * i, h * j
            c = (i % mod, j % mod)
            A, B, C, D = (x0, y0), (x0 + h, y0), (x0 + h, y0 + h), (x0, y0 + h)
            tiles[f"S{i},{j}"] = (c, [Seg(A, B), Seg(B, C), Seg(C, D), Seg(D, A)])
    fund = []
    for i in range(0, 3):
        for j in range(0, 3):
            prims = tiles[f"S{i},{j}"][1]
            fund += [seg_key(p) for p in prims]
    return F, tiles, sorted(set(fund))


def hex_tiles(mod):
    """hexagons of width 1/2 (apothem 1/4) centred at (1/2)L, L = Z(1,0) + Z(1/2, sqrt3/2); colour: L/mod L."""
    F = Field([Fr(3)], names=["3"])
    r3 = F.gen(1)
    circ = r3 / 6                       # circumradius = apothem * 2/sqrt3 = (1/4)(2/sqrt3) = sqrt3/6
    # vertices at 30 + 60k degrees: (circ*cos, circ*sin)
    half = F(Fr(1, 2))
    vdirs = [(r3 * half, half), (F(0), F(1)), (-r3 * half, half), (-r3 * half, -half), (F(0), F(-1)), (r3 * half, -half)]
    tiles = {}
    for m in range(-6, 9):
        for n in range(-6, 9):
            cx = half * (F(m) + F(n) * half)
            cy = half * (F(n) * r3 * half)
            vs = [(cx + circ * a, cy + circ * b) for (a, b) in vdirs]
            prims = [Seg(vs[k], vs[(k + 1) % 6]) for k in range(6)]
            c = (m % mod, n % mod)
            tiles[f"H{m},{n}"] = (c, prims)
    fund = []
    for m in range(0, 3):
        for n in range(0, 3):
            fund += [seg_key(p) for p in tiles[f"H{m},{n}"][1]]
    return F, tiles, sorted(set(fund))


def run_polygonal(name, maker, mod):
    F, tiles, fund = maker(mod)
    ok, bad, uns = ladder(F, tiles, fund, name)
    say(f"{name}: {len(fund)} fundamental edges x 2 sides: ladder present {ok}, FAIL at saturated points {bad}, "
        f"absent at unsaturated points {uns}; all radii infinite (segments)")
    return bad == 0 and uns == 0


def run_strip():
    F, tiles, top = strip(-6, 8, plant=("swap" if PLANT == "swap" else None))
    segs, _ = edges_of(tiles)
    fund = []
    for key, owners in segs.items():
        if len(owners) == 2 and all(int(nm[1:]) in (0, 1, 2) for nm, _, _ in owners):
            fund.append(key)
    ok, bad, uns = ladder(F, tiles, fund, "strip")
    kok, kbad, radii = kind_both(tiles, "strip", keep=lambda nm: -2 <= int(nm[1:]) <= 4)
    say(f"strip: {len(fund)} interior segment edges in columns 0..2, x 2 sides: ladder present {ok}, FAIL at saturated points {bad}, "
        f"absent at unsaturated points {uns}; arcs (columns -2..4): kind both {kok}, not {kbad}; arc radii {sorted(radii)}")
    return bad == 0 and kbad == 0


def run_r7():
    """R7 on the lattice: up U(m,n) colour 2(m%2)+(n%2); down D(m,n) = lambda+{e1,e2,e1+e2} colour 4+((m-n)%3) (r8: 4+2(m%2)+(n%2)).
    U(m,n)'s three arcs: centred at lambda (borders D(m,n)), at lambda+e1 (borders D(m-1,n)), at lambda+e2 (borders D(m,n-1)).
    Closure colours at a lattice point p = (a, b): ups with vertex p: U(a,b), U(a-1,b), U(a,b-1); downs with cusp p:
    D(a-1,b), D(a,b-1), D(a-1,b-1).  Every arc has radius 1 (a Reuleaux side of width 1)."""
    up = lambda m, n: 2 * (m % 2) + (n % 2)
    if PLANT == "r8":
        dn = lambda m, n: 10 + 2 * (m % 2) + (n % 2)
    else:
        dn = lambda m, n: 4 + ((m - n) % 3)
    def cl(a, b):
        return {up(a, b), up(a - 1, b), up(a, b - 1), dn(a - 1, b), dn(a, b - 1), dn(a - 1, b - 1)}
    ok = bad = 0
    for m in range(0, 12):
        for n in range(0, 12):
            for (cen, D) in (((m, n), (m, n)), ((m + 1, n), (m - 1, n)), ((m, n + 1), (m, n - 1))):
                colours = cl(*cen)
                if up(m, n) in colours and dn(*D) in colours:
                    ok += 1
                else:
                    bad += 1
                    if bad <= 3:
                        say(f"  R7 KB arc U{m},{n}|D{D} centred at {cen}: closure colours {sorted(colours)} lack {dn(*D)}: NOT kind both")
    say(f"R7: {ok + bad} arcs (12 x 12 ups x 3): kind both {ok}, not {bad}; all radii 1")
    return bad == 0


def main():
    say(f"plant = {PLANT}")
    res = {}
    if PLANT in (None, "sq16"):
        res["SQ"] = run_polygonal("SQ9" if PLANT is None else "SQ16", sq_tiles, 4 if PLANT == "sq16" else 3)
    if PLANT in (None, "hex16"):
        res["HEX"] = run_polygonal("HEX9" if PLANT is None else "HEX16", hex_tiles, 4 if PLANT == "hex16" else 3)
    if PLANT in (None, "r8"):
        res["R7"] = run_r7()
    if PLANT in (None, "swap"):
        res["strip"] = run_strip()
    say(f"RESULT {res}")


if __name__ == "__main__":
    main()
