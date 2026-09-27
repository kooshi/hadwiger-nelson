#!/usr/bin/env python3
"""FS110-YB: controls, planted faults, and the four fragments S1, T2, BB, MX rebuilt from their formulas
(data/fs110/briefs/YB110-instance.md), checked with tools/fs110_yb_check.py.

Usage: python3 tools/fs110_yb_fragments.py [selftest|fragments|all]
Where a formula is silent on how a tile is closed, the closing is this file's choice, stated at the tile, and a second closing is checked beside it.
"""
import sys
import fs110_yb_check as K
from fs110_yb_check import Q3, Fr, P, add, sub, mul, e, e_pm_alpha, Seg, Arc, Tile, R3

# ---------------------------------------------------------------- builders
def poly(name, colour, pts):
    return Tile(name, colour, [Seg(pts[i], pts[(i + 1) % len(pts)]) for i in range(len(pts))])

def sector(name, colour, c, rho, A, B, chord=False):
    pa = add(c, mul(rho, e(A))); pb = add(c, mul(rho, e(B)))
    mid = Seg(pa, pb) if chord else Arc(c, rho, pa, pb)
    return Tile(name, colour, [Seg(c, pa), mid, Seg(pb, c)])

def hexagon(name, colour, c, R):
    return poly(name, colour, [add(c, mul(R, e(60 * k))) for k in range(6)])

def quad_squares(w, h, cols, prefix):
    """four quadrant squares of side h at w; cols = colours of quadrants (0,90),(90,180),(180,270),(270,360)"""
    x, y = (h, 0), (0, h)
    X, Y = P(h, 0), P(0, h); mX, mY = P(-h, 0), P(0, -h)
    sq = [[w, add(w, X), add(add(w, X), Y), add(w, Y)],
          [w, add(w, Y), add(add(w, Y), mX), add(w, mX)],
          [w, add(w, mX), add(add(w, mX), mY), add(w, mY)],
          [w, add(w, mY), add(add(w, mY), X), add(w, X)]]
    return [poly(f"{prefix}Q{i+1}", cols[i], sq[i]) for i in range(4)]

def halfturn(z):   # R: the half-turn about (1/2, 0)
    return (Q3(1) - z[0], -z[1])
INV = {1: 4, 2: 5, 3: 6, 4: 1, 5: 2, 6: 3}
def R_tiles(tiles, rename):
    return [t.mapped(halfturn, rename(t.name), INV[t.colour]) for t in tiles]

ZERO = P(0, 0); ONE = P(1, 0)
W = e(60); Wp = e(300)
Q = Fr(1, 4)

# ---------------------------------------------------------------- the fragments
def frag_S1(chord=False):
    u = ZERO; v = ONE
    t = [sector("u_a1", 1, u, Q, 300, 60, chord), sector("u_b", 2, u, Q, 60, 120, chord),
         sector("u_a2", 1, u, Q, 120, 240, chord), sector("u_c", 3, u, Q, 240, 300, chord),
         sector("v_4", 4, v, Q, 300, 60, chord), sector("v_5", 5, v, Q, 60, 180, chord), sector("v_6", 6, v, Q, 180, 300, chord)]
    for wn, ww, inner, outer in (("w", 60, 2, 3), ("wp", 300, 3, 2)):
        pm = e_pm_alpha(ww, -1); pp = e_pm_alpha(ww, +1)
        arc = lambda: Arc(u, 1, pm, pp)
        wv = e(ww)
        t.append(Tile(f"{wn}_in", inner, [arc(), Seg(pp, mul(Fr(9, 10), wv)), Seg(mul(Fr(9, 10), wv), pm)]))
        t.append(Tile(f"{wn}_out", outer, [arc(), Seg(pp, mul(Fr(11, 10), wv)), Seg(mul(Fr(11, 10), wv), pm)]))
    return t

def u_T2_tiles(apex=Q):
    """u on a full arc of omega(w) (rays 150, 330: inner 3; outer 1 on the 150 half, 2 on the 330 half) plus a ray of omega(w') at 210
    (inner 2, outer 1). Arcs of half-angle alpha = 2 arctan(1/8) about their centres. Closing (this file's choice): segments from the
    arc ends to apexes at distance `apex` from u in the directions 60 (tile 3), 180 (tile 1), 270 (tile 2)."""
    P1 = add(W, e_pm_alpha(240, -1))      # end of the 150-half of omega(w)
    P3 = add(W, e_pm_alpha(240, +1))      # end of the 330-half
    P2 = add(Wp, e_pm_alpha(120, +1))     # end of the 210-ray of omega(w')
    u = ZERO
    A60, A180, A270 = mul(apex, e(60)), mul(apex, e(180)), mul(apex, e(270))
    t3 = Tile("u_3", 3, [Arc(W, 1, P1, P3), Seg(P3, A60), Seg(A60, P1)])
    t1 = Tile("u_1", 1, [Arc(W, 1, P1, u), Seg(P1, A180), Seg(A180, P2), Arc(Wp, 1, u, P2)])
    t2 = Tile("u_2", 2, [Arc(Wp, 1, u, P2), Seg(P2, A270), Seg(A270, P3), Arc(W, 1, u, P3)])
    return [t1, t2, t3], (P1, P2, P3)

def frag_T2(apex=Q, flat=False, flip=False, six=False):
    ut, (P1, P2, P3) = u_T2_tiles(apex)
    if flat:   # plant: the arcs of omega(w) at u replaced by chords
        u = ZERO; A60, A180, A270 = mul(apex, e(60)), mul(apex, e(180)), mul(apex, e(270))
        ut = [Tile("u_1", 1, [Seg(P1, u), Seg(P1, A180), Seg(A180, P2), Arc(Wp, 1, u, P2)]),
              Tile("u_2", 2, [Arc(Wp, 1, u, P2), Seg(P2, A270), Seg(A270, P3), Seg(u, P3)]),
              Tile("u_3", 3, [Seg(P1, u), Seg(u, P3), Seg(P3, A60), Seg(A60, P1)])]
    vt = R_tiles(ut, lambda n: "v" + n[1:])
    wc = [1, 4, 3, 5]
    if flip: wc = [3, 4, 1, 5]
    if six: wc = [1, 6, 3, 5]
    wt = quad_squares(W, Fr(1, 10), wc, "w")
    wpt = R_tiles(quad_squares(W, Fr(1, 10), [1, 4, 3, 5], "w"), lambda n: "wp" + n[1:])
    return ut + vt + wt + wpt

def frag_BB(chord=False, rot=0):
    u = ZERO
    S = lambda n, c, a, b: sector(n, c, u, Q, (a + rot) % 360, (b + rot) % 360, chord)
    ut = [S("u_1a", 1, 300, 60), S("u_2", 2, 60, 120), S("u_1b", 1, 120, 240), S("u_3", 3, 240, 300)]
    ut0 = [sector(n, c, u, Q, a, b, chord) for n, c, a, b in (("u_1a", 1, 300, 60), ("u_2", 2, 60, 120), ("u_1b", 1, 120, 240), ("u_3", 3, 240, 300))]
    vt = R_tiles(ut0, lambda n: "v" + n[1:])
    wt = quad_squares(W, Fr(1, 10), [3, 5, 2, 6], "w")
    wpt = R_tiles(wt, lambda n: "wp" + n[1:])
    return ut + vt + wt + wpt

def frag_MX(apex=Q):
    """u: bowtie 1 on (330,60) and (150,240), 2 on (60,150), 3 on (240,330), on a full arc of omega(w) (rays 150, 330 exact; 60, 240
    straight, truncated at 1/4). v = T2's v. w: 3,4,2,5; w': 6,3,4,2."""
    u = ZERO
    P1 = add(W, e_pm_alpha(240, -1)); P3 = add(W, e_pm_alpha(240, +1))
    A60, A240 = mul(apex, e(60)), mul(apex, e(240))
    ut = [Tile("u_1a", 1, [Arc(W, 1, u, P3), Seg(P3, A60), Seg(A60, u)]),
          Tile("u_2", 2, [Seg(u, A60), Seg(A60, P1), Arc(W, 1, P1, u)]),
          Tile("u_1b", 1, [Arc(W, 1, P1, u), Seg(u, A240), Seg(A240, P1)]),
          Tile("u_3", 3, [Seg(u, A240), Arc(W, 1, u, P3), Seg(P3, A240)])]
    ut2, _ = u_T2_tiles(apex)
    vt = R_tiles(ut2, lambda n: "v" + n[1:])
    wt = quad_squares(W, Fr(1, 10), [3, 4, 2, 5], "w")
    wpt = quad_squares(Wp, Fr(1, 10), [6, 3, 4, 2], "wp")
    return ut + vt + wt + wpt

# ---------------------------------------------------------------- controls
def hex7(R, span=3):
    g1 = mul(R * R3, e(30)); g2 = mul(R * R3, e(90))
    ts = []
    for m in range(-span, span + 1):
        for n in range(-span, span + 1):
            c = add(mul(m, g1), mul(n, g2))
            ts.append(hexagon(f"h{m},{n}", (m + 3 * n) % 7, c, R))
    return ts

def ctl_VV():
    s = Fr(4, 5); return [poly("sq", 1, [P(0, 0), P(s, 0), P(s, s), P(0, s)])]
def ctl_VS():
    return [poly("A", 1, [P(0, 0), P(Fr(-1, 20), Fr(1, 50)), P(Fr(-1, 20), Fr(-1, 50))]),
            poly("B", 1, [P(Fr(9, 10), Fr(-23, 50)), P(Fr(11, 10), Fr(-23, 50)), P(Fr(11, 10), Fr(23, 50)), P(Fr(9, 10), Fr(23, 50))])]
def ctl_VAfar():
    C = P(Fr(4, 5), 0); r = Fr(3, 10)
    a, b = add(C, mul(r, e(270))), add(C, mul(r, e(90)))
    return [poly("A", 1, [P(0, 0), P(Fr(-1, 20), Fr(1, 20)), P(Fr(-1, 10), Fr(1, 20))]),
            Tile("B", 1, [Arc(C, r, a, b), Seg(b, a)])]
def ctl_VAnear():
    C = P(-2, 0); ri, ro = Fr(149, 50), Fr(33, 10)
    i0, i1 = add(C, mul(ri, e(330))), add(C, mul(ri, e(30)))
    o0, o1 = add(C, mul(ro, e(330))), add(C, mul(ro, e(30)))
    return [poly("A", 1, [P(0, 0), P(Fr(-1, 20), Fr(1, 50)), P(Fr(-1, 20), Fr(-1, 50))]),
            Tile("B", 1, [Arc(C, ri, i0, i1), Seg(i1, o1), Arc(C, ro, o0, o1), Seg(o0, i0)])]
def ctl_AA():
    r = Fr(6, 5); CA_, CB = P(-1, 0), P(Fr(23, 10), 0)
    a0, a1 = add(CA_, mul(r, e(330))), add(CA_, mul(r, e(30)))
    b0, b1 = add(CB, mul(r, e(150))), add(CB, mul(r, e(210)))
    return [Tile("A", 1, [Arc(CA_, r, a0, a1), Seg(a1, a0)]), Tile("B", 1, [Arc(CB, r, b0, b1), Seg(b1, b0)])]
def ctl_SA():
    C = P(Fr(11, 10), 0); r = Fr(1, 5)
    b0, b1 = add(C, mul(r, e(120))), add(C, mul(r, e(240)))
    return [poly("A", 1, [P(Fr(-1, 20), Fr(-49, 100)), P(0, Fr(-49, 100)), P(0, Fr(49, 100)), P(Fr(-1, 20), Fr(49, 100))]),
            Tile("B", 1, [Arc(C, r, b0, b1), Seg(b1, b0)])]

CONTROLS = {"VV": ctl_VV, "VS": ctl_VS, "VAfar": ctl_VAfar, "VAnear": ctl_VAnear, "AA": ctl_AA, "SA": ctl_SA}

def run_controls(verbose=False):
    """each candidate-type control must REJECT, and REJECT through its own candidate type"""
    out = {}
    for name, f in CONTROLS.items():
        tiles = f()
        r = K.check(tiles, f"control {name}", verbose)
        # the control's designed pair: the cross pair (A, B), or the one tile with itself
        tgt = [x for x in r["res"] if (x["A"], x["B"]) == ((tiles[0].name, tiles[-1].name))][0]
        own = tgt["verdict"] == "REJECT" and any(name in k for k in tgt["lt_by"] + tgt["gt_by"])
        out[name] = (tgt["verdict"], own)
    return out

def selftest():
    print("#### SELF-TEST")
    ok = True
    base = run_controls(verbose=True)
    for n, (v, own) in base.items():
        good = (v == "REJECT" and own)
        ok &= good
        print(f"control {n}: designed pair {v}, through its own candidate type: {own} -> {'ok' if good else 'FAIL'}")
    hx = K.check(hex7(Fr(1, 2)), "ACCEPT control: tight hexagonal seven-colouring, circumradius 1/2", verbose=False)
    good = hx["verdict"] == "ACCEPT" and hx["contacts"] > 0 and hx["count_ok"]
    print(f"hex7 R=1/2: {hx['verdict']} pairs={hx['pairs']} contacts={hx['contacts']} (self diameters exactly 1) -> {'ok' if good else 'FAIL'}; class density 1/7 = {float(Fr(1,7)):.4f} <= 0.2470")
    ok &= good
    hb = K.check(hex7(Fr(11, 20)), "REJECT control: hexagonal seven-colouring, circumradius 11/20", verbose=False)
    good = hb["verdict"] == "REJECT"
    print(f"hex7 R=11/20: {hb['verdict']} rejects={hb['rejects']} -> {'ok' if good else 'FAIL'}")
    ok &= good
    # plants: each candidate type removed; its own control must stop rejecting, the others must not change
    for pl in ["VV", "VS", "VAfar", "VAnear", "AA", "SA"]:
        K.PLANT = pl
        res = run_controls()
        K.PLANT = None
        fired = res[pl][0] != "REJECT"
        others = all(res[n][0] == base[n][0] for n in res if n != pl)
        print(f"plant drop-{pl}: own control -> {res[pl][0]} (fired: {fired}); other controls unchanged: {others}")
        ok &= fired
    # plant: arcs read as full circles; T2 must go REJECT
    K.PLANT = "ARCFULL"; r = K.check(frag_T2(), "T2 under plant ARCFULL", verbose=False); K.PLANT = None
    print(f"plant arcs-as-full-circles on T2: {r['verdict']} (fired: {r['verdict'] == 'REJECT'})"); ok &= r["verdict"] == "REJECT"
    # plants: lost tile pairs; the count assertion must fire, and the REJECT control must stop reading REJECT from its self pairs
    for pl in ["SELF", "CROSS"]:
        K.PLANT = pl
        r1 = K.check(hex7(Fr(11, 20)), f"hex7 R=11/20 under plant {pl}", verbose=False)
        r2 = K.check(ctl_AA(), f"control AA under plant {pl}", verbose=False)
        K.PLANT = None
        print(f"plant lost-{pl}-pairs: count_ok={r1['count_ok']} (assertion fired: {not r1['count_ok']}); hex7-11/20 rejects={r1['rejects']}; control AA verdict={r2['verdict']}")
        ok &= (not r1["count_ok"]) and r2["verdict"] != "ACCEPT"
    print("SELF-TEST", "PASS" if ok else "FAIL")
    return ok

def fragments():
    print("#### FRAGMENTS")
    summary = {}
    for label, tiles in [("S1 (disc sectors)", frag_S1()), ("S1 (chord-closed sectors)", frag_S1(chord=True)),
                         ("T2 (apex 1/4)", frag_T2()), ("T2 (apex 1/5)", frag_T2(apex=Fr(1, 5))),
                         ("BB (disc sectors)", frag_BB()), ("BB (chord-closed sectors)", frag_BB(chord=True)),
                         ("MX (apex 1/4)", frag_MX()), ("MX (apex 1/5)", frag_MX(apex=Fr(1, 5)))]:
        r = K.check(tiles, label, verbose=True)
        summary[label] = (r["verdict"], r["pairs"], r["contacts"])
    print("#### PLANTED FAULTS ON THE FRAGMENTS (each must REJECT)")
    for label, tiles in [("T2 flip (colours 1, 3 swapped at w)", frag_T2(flip=True)),
                         ("T2 flat (arcs of omega(w) at u replaced by chords)", frag_T2(flat=True)),
                         ("T2 six (colour 6 in w's quadrant (90,180))", frag_T2(six=True)),
                         ("BB rot (u's bowtie turned 60 degrees)", frag_BB(rot=60))]:
        r = K.check(tiles, label, verbose=False)
        rej = [f"({x['A']},{x['B']}) [{x['lo']:.4f},{x['hi']:.4f}]" for x in r["res"] if x["verdict"] == "REJECT"]
        print(f"== {label}: {r['verdict']}  rejecting pairs: {rej}")
        summary[label] = (r["verdict"], r["pairs"], r["contacts"])
    print("#### SUMMARY")
    for k, v in summary.items(): print(f"{k}: {v[0]}, pairs={v[1]}, contacts at 1={v[2]}")
    return summary

if __name__ == "__main__":
    what = sys.argv[1] if len(sys.argv) > 1 else "all"
    ok = True
    if what in ("selftest", "all"): ok = selftest()
    if what in ("fragments", "all"): fragments()
    sys.exit(0 if ok else 1)
