#!/usr/bin/env python3
"""FS110-Y2's local seam fragments, given by formula and checked exactly by FS110-Y's checker (tools/fs110_y_check.py,
imported, not edited).

Every fragment lives on the d = 1 rhombus  u = (0,0), v = (1,0), w = (1/2, sqrt3/2), w' = (1/2, -sqrt3/2)  and covers small
neighbourhoods ("flowers") of the four points; all data lie in Q(sqrt 3).  A fragment is a dict  name -> (colour, [primitives]);
the SAME-COLOUR PAIRS ARE GENERATED FROM THE COLOUR MAP (every same-colour pair, every tile against itself), never listed by
hand, so a builder cannot omit a pair.  Verdict per pair: REJECT iff 1 is interior to the exact cross-distance range
(killing test 6 of data/fs110/claims.md).

Fragments (the record, plans/FS110-Y-construction.md § Continuation — FS110-Y2, gives each one's derivation):
  S1   a bowtie u whose unit circle carries two boundary arcs (arcs of Gamma, centred at u) through w and w'; v generic trivalent;
       w, w' two-colour edge points.                                    (the owner's (S1): a unit arc through w0 centred at a bowtie)
  T2   the double unit-arc seam: u on a full arc of omega(w) plus a ray along omega(w'); v its point reflection; w, w' four-colour
       vertices (quadrant squares).                                                                     (C-T2 (i))
  BB   the double bowtie: u and v bowties escaping at both w and w' (all straight, margins 30 deg); w, w' four-colour.   (C-BOW-K (i))
  MX   mixed: u a bowtie lying on a full arc of omega(w) (T2 at w, escape at w'), v the T2 vertex of fragment T2.

Planted faults (--plant NAME): each must turn its fragment's verdict to REJECT, for the reason named:
  s1_flat     S1 with the arc of Gamma through w replaced by its chord (the interface stops being an arc of omega(u))
  t2_flip     T2 with w's colours 1 and 3 swapped (a facing colour put in the away quadrant)
  t2_flat     T2 with u's two arcs of omega(w) replaced by chords (a T1 interface, curvature 0 against 1)
  t2_six      T2 with colour 6 put at w (v's colour-6 sector straddles the tangent line)
  bb_rot      BB with u's bowtie rotated by 60 deg (its repeated colour no longer holds the escape lines)
and FS110-Y's own checker plants are passed through (--yplant closed_interval: every tight contact at exactly 1 turns REJECT, which
certifies that the fragments are tight).
A float instrument (--geom) samples points and checks that tiles do not overlap and that each flower covers a disc about its
vertex: a geometry guard, NOT part of any verdict.
"""
from __future__ import annotations
import sys, os, math, itertools
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs110_y_check as C  # noqa: E402  (FS110-Y's frozen-by-convention checker; imported only)

Q3, Seg, Arc, R3 = C.Q3, C.Seg, C.Arc, C.R3
add, sub, mul, n2, pt = C.add, C.sub, C.mul, C.n2, C.pt
PLANT = None

# ------------------------------------------------------------------ exact geometry in Q(sqrt3)
COS = {0: (1, 0), 30: (R3 / 2, Fr(1, 2)), 60: (Fr(1, 2), R3 / 2), 90: (0, 1)}


def e(deg):
    """exact unit vector at a multiple of 30 degrees."""
    deg %= 360
    k, r = divmod(deg, 90)
    assert r in COS, deg
    x, y = COS[r]
    x, y = C.q(x), C.q(y)
    for _ in range(k):
        x, y = -y, x
    return (x, y)


def rot(v, deg):
    """rotate v by a multiple of 30 degrees, exactly."""
    c, s = e(deg)
    return (c * v[0] - s * v[1], s * v[0] + c * v[1])


def cpt(t):
    """rational point on the unit circle at angle 2*atan(t): ((1-t^2)/(1+t^2), 2t/(1+t^2))."""
    t = Fr(t)
    return (C.q((1 - t * t) / (1 + t * t)), C.q(2 * t / (1 + t * t)))


def on_circle(centre, base_deg, t, sign):
    """centre + unit vector at angle base_deg + sign*2*atan(t) (exact)."""
    c, s = cpt(t)
    return add(centre, rot((c, sign * s), base_deg))


U, V = pt(0, 0), pt(1, 0)
W, W2 = (Q3(Fr(1, 2)), R3 / 2), (Q3(Fr(1, 2)), -R3 / 2)


def Rpt(p):          # the point reflection about (1/2, 0): u <-> v, w <-> w'
    return (1 - p[0], -p[1])


def Rprim(p):
    if isinstance(p, Seg):
        return Seg(Rpt(p.P), Rpt(p.Q))
    return Arc(Rpt(p.C), p.r, Rpt(p.S), Rpt(p.E))      # a half-turn keeps orientation


def poly(*pts):
    return [Seg(pts[i], pts[(i + 1) % len(pts)]) for i in range(len(pts))]


def sector_poly(c, rho, degs):
    """straight sector at c through the listed ray angles (multiples of 30), truncated by the chord path at radius rho."""
    return poly(c, *[add(c, mul(C.q(rho), e(d))) for d in degs])


def quadrants(c, rho, colours):
    """four axis-aligned squares of side rho about c: colours for (0,90), (90,180), (180,270), (270,360)."""
    r = C.q(rho)
    out = {}
    for k, col in enumerate(colours):
        a, b = e(90 * k), e(90 * k + 90)
        out[k] = (col, poly(c, add(c, mul(r, a)), add(c, add(mul(r, a), mul(r, b))), add(c, mul(r, b))))
    return out


# ------------------------------------------------------------------ the fragments
TA = Fr(1, 8)     # half-angle parameter of the unit arcs at u (2*atan(1/8) ~ 14.25 deg)
RHO_U = Fr(1, 4)  # straight-ray radius at u, v
RHO_W = Fr(1, 10)  # quadrant size at w, w'


def generic_v(cols=(4, 5, 6)):
    """a generic trivalent vertex at v: sectors (300,60), (60,180), (180,300)."""
    return {"v_A": (cols[0], sector_poly(V, RHO_U, [300, 0, 60])),
            "v_B": (cols[1], sector_poly(V, RHO_U, [60, 120, 180])),
            "v_C": (cols[2], sector_poly(V, RHO_U, [180, 240, 300]))}


def frag_S1():
    """(S1): u a bowtie a,b,a,c (a = 1 in (300,60) and (120,240); b = 2 in (60,120); c = 3 in (240,300)); two boundary arcs of
    omega(u) (centred at u) through w (inner b | outer c) and through w' (inner c | outer b); v generic (4,5,6)."""
    T = {"u_a1": (1, sector_poly(U, RHO_U, [300, 0, 60])), "u_a2": (1, sector_poly(U, RHO_U, [120, 180, 240])),
         "u_b": (2, sector_poly(U, RHO_U, [60, 120])), "u_c": (3, sector_poly(U, RHO_U, [240, 300]))}
    T.update(generic_v())
    for (x, deg, inner, outer, tag) in [(W, 60, 2, 3, "w"), (W2, 300, 3, 2, "w'")]:
        p1, p2 = on_circle(U, deg, TA, -1), on_circle(U, deg, TA, +1)     # the arc of omega(u) from p1 to p2 (ccw about u)
        arc = [Arc(U, 1, p1, x), Arc(U, 1, x, p2)]
        if PLANT == "s1_flat" and tag == "w":
            arc = [Seg(p1, x), Seg(x, p2)]                                  # the chord path: no longer an arc of omega(u)
        din, dout = mul(C.q(Fr(9, 10)), x), mul(C.q(Fr(11, 10)), x)          # closing points inside / outside D(u)
        T[f"{tag}_in"] = (inner, arc + [Seg(p2, din), Seg(din, p1)])
        T[f"{tag}_out"] = (outer, arc + [Seg(p2, dout), Seg(dout, p1)])
    return T


def u_T2_flower(cols=(1, 2, 3)):
    """u on a full arc of omega(w) (rays 150, 330) plus a ray along omega(w') at 210.  Colours: (150,210) cols[0] outside both
    discs; (210,330) cols[1] inside D(w') outside D(w); (330,150) cols[2] inside D(w)."""
    p1, p2 = on_circle(W, 240, TA, -1), on_circle(W, 240, TA, +1)        # omega(w) about 240 deg: p1 on the 150 side
    p3 = on_circle(W2, 120, TA, +1)                                      # omega(w') from u (120 deg about w'), the 210 ray
    arcw1, arcw2, arcw2p = Arc(W, 1, p1, U), Arc(W, 1, U, p2), Arc(W2, 1, U, p3)
    if PLANT == "t2_flat":
        arcw1, arcw2 = Seg(p1, U), Seg(U, p2)
    q = mul(C.q(Fr(1, 5)), e(60))
    return {"u_1": (cols[0], [arcw1, arcw2p, Seg(p3, p1)]),
            "u_2": (cols[1], [arcw2, Seg(p2, p3), arcw2p]),
            "u_3": (cols[2], [arcw1, arcw2, Seg(p2, q), Seg(q, p1)])}


def reflect(tiles, cmap, prefix):
    return {prefix + k[1:]: (cmap[c], [Rprim(p) for p in prims]) for k, (c, prims) in tiles.items()}


def frag_T2():
    cmap = {1: 4, 2: 5, 3: 6, 4: 1, 5: 2, 6: 3}
    uf = u_T2_flower()
    T = dict(uf)
    T.update(reflect(uf, cmap, "v"))
    wc = [1, 4, 3, 5]
    if PLANT == "t2_flip":
        wc = [3, 4, 1, 5]
    if PLANT == "t2_six":
        wc = [1, 6, 3, 5]
    for k, (c, prims) in quadrants(W, RHO_W, wc).items():
        T[f"w_{k}"] = (c, prims)
    wq = {f"w_{k}": v for k, v in quadrants(W, RHO_W, wc).items()}
    T.update(reflect(wq, cmap, "W"))           # w' = R(w), names W_k
    return T


def bowtie_u(cols=(1, 2, 3), turn=0):
    a, b, c = cols
    s = lambda degs: sector_poly(U, RHO_U, [(d + turn) % 360 for d in degs])
    return {"u_a1": (a, s([300, 0, 60])), "u_a2": (a, s([120, 180, 240])), "u_b": (b, s([60, 120])), "u_c": (c, s([240, 300]))}


def frag_BB():
    cmap = {1: 4, 2: 5, 3: 6, 4: 1, 5: 2, 6: 3}
    uf = bowtie_u(turn=60 if PLANT == "bb_rot" else 0)
    T = dict(bowtie_u())
    T.update(reflect(bowtie_u(), cmap, "v"))
    if PLANT == "bb_rot":
        T.update(uf)
    wc = [3, 5, 2, 6]                         # (0,90) c, (90,180) b', (180,270) b, (270,360) c'
    wq = {f"w_{k}": v for k, v in quadrants(W, RHO_W, wc).items()}
    T.update(wq)
    T.update(reflect(wq, cmap, "W"))
    return T


def frag_MX():
    """u: a bowtie a1 (330,60), b (60,150), a2 (150,240), c (240,330) lying on a full arc of omega(w) (rays 150, 330 exact), rays
    60, 240 straight; v the T2 vertex of frag_T2 (colours 4,5,6); w: c,4,b,5; w': 6,c,4,b."""
    p1, p2 = on_circle(W, 240, TA, -1), on_circle(W, 240, TA, +1)
    m60, m240 = mul(C.q(RHO_U), e(60)), mul(C.q(RHO_U), e(240))
    arc1, arc2 = Arc(W, 1, p1, U), Arc(W, 1, U, p2)
    T = {"u_b": (2, [Seg(U, m60), Seg(m60, p1), arc1]),
         "u_a1": (1, [arc2, Seg(p2, m60), Seg(m60, U)]),
         "u_a2": (1, [arc1, Seg(U, m240), Seg(m240, p1)]),
         "u_c": (3, [Seg(U, m240), Seg(m240, p2), arc2])}
    cmap = {1: 4, 2: 5, 3: 6, 4: 1, 5: 2, 6: 3}
    T.update(reflect(u_T2_flower(), cmap, "v"))
    for k, (c, prims) in quadrants(W, RHO_W, [3, 4, 2, 5]).items():
        T[f"w_{k}"] = (c, prims)
    for k, (c, prims) in quadrants(W2, RHO_W, [6, 3, 4, 2]).items():
        T[f"W_{k}"] = (c, prims)
    return T


FRAGS = {"S1": frag_S1, "T2": frag_T2, "BB": frag_BB, "MX": frag_MX}


# ------------------------------------------------------------------ the exact check, pairs generated from the colour map
def fdist_range(T1, T2):
    cs = [c for p1 in T1 for p2 in T2 for c in C.cands(p1, p2)]
    vals = [abs(math.sqrt(max(A.f(), 0.0)) + B.f()) for (A, B) in cs]
    return min(vals), max(vals)


def check_fragment(T):
    names = sorted(T)
    pairs = [(a, b) for a, b in itertools.combinations_with_replacement(names, 2) if T[a][0] == T[b][0]]
    tiles = {k: v[1] for k, v in T.items()}
    rows, bad = [], []
    for a, b in pairs:
        v = C.pair_verdict(tiles[a], tiles[b], self_pair=(a == b))
        lo, hi = fdist_range(tiles[a], tiles[b]) if a != b else (0.0, fdist_range(tiles[a], tiles[a])[1])
        rows.append((a, b, T[a][0], v, lo, hi))
        if v == "REJECT":
            bad.append((a, b))
    return rows, bad


# ------------------------------------------------------------------ float geometry guard (not a verdict)
def polyline(prims, n=24):
    out = []
    for p in prims:
        if isinstance(p, Seg):
            out.append([(p.P[0].f(), p.P[1].f()), (p.Q[0].f(), p.Q[1].f())])
        else:
            cx, cy = p.C[0].f(), p.C[1].f(); r = p.r.f()
            a0 = math.atan2(p.S[1].f() - cy, p.S[0].f() - cx); a1 = math.atan2(p.E[1].f() - cy, p.E[0].f() - cx)
            span = (a1 - a0) % (2 * math.pi)
            assert span < math.pi / 2, "arc span >= 90 deg: wrong orientation?"
            out.append([(cx + r * math.cos(a0 + span * i / n), cy + r * math.sin(a0 + span * i / n)) for i in range(n + 1)])
    return out


def inside(prims, x, y):
    """even-odd rule on the polyline boundary (segments only; the chains need not be ordered)."""
    cnt = 0
    for ch in polyline(prims):
        for (x1, y1), (x2, y2) in zip(ch, ch[1:]):
            if (y1 > y) != (y2 > y) and x < x1 + (y - y1) * (x2 - x1) / (y2 - y1):
                cnt += 1
    return cnt % 2 == 1


def geom(T, r_cover=0.05):
    tiles = {k: v[1] for k, v in T.items()}
    over, holes = 0, 0
    for (cx, cy) in [(0, 0), (1, 0), (0.5, 3 ** 0.5 / 2), (0.5, -3 ** 0.5 / 2)]:
        for i in range(-12, 13):
            for j in range(-12, 13):
                x, y = cx + r_cover * i / 12 + 1e-7, cy + r_cover * j / 12 + 2e-7
                if (x - cx) ** 2 + (y - cy) ** 2 > r_cover ** 2: continue
                k = sum(inside(p, x, y) for p in tiles.values())
                over += k > 1; holes += k == 0
    return over, holes


if __name__ == "__main__":
    args = sys.argv[1:]
    if "--plant" in args: PLANT = args[args.index("--plant") + 1]
    if "--yplant" in args: C.PLANT = args[args.index("--yplant") + 1]
    only = args[args.index("--frag") + 1] if "--frag" in args else None
    verbose = "--verbose" in args
    allok = True
    for name, f in FRAGS.items():
        if only and name != only: continue
        T = f()
        rows, bad = check_fragment(T)
        verdict = "REJECT" if bad else "ACCEPT"
        print(f"== fragment {name}: {len(T)} tiles, {len(rows)} same-colour pairs (self included): {verdict}")
        for (a, b, c, v, lo, hi) in rows:
            if verbose or v == "REJECT":
                print(f"   colour {c}  {a:6s} {b:6s} {v:6s} range ~[{lo:.6f}, {hi:.6f}]")
        if bad: print("   REJECTED PAIRS:", bad)
        if "--geom" in args:
            ov, ho = geom(T)
            print(f"   geometry guard (float): overlapping samples {ov}, uncovered samples within 0.05 of a vertex {ho}")
        allok &= (verdict == "ACCEPT")
    print("PLANT", PLANT, "YPLANT", C.PLANT, "ALL ACCEPT" if allok else "SOME REJECT")
    sys.exit(0 if allok else 1)
