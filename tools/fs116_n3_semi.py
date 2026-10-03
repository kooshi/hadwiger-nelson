#!/usr/bin/env python3
"""FS116-N3: the semi-hub rule read on the held fragments (FLOAT readings of exact objects, through FS116-N1's ring tool, imported unedited).

For each change point y = r(psi) of each held four-colour vertex p (the strip's P0, P1, P2; the Y2 bowtie's centre; the disk's corner A0) it reports:
  the germ data   each of u-, u+, v-, v+ off (Q) arcs, or on a (Q) arc with its inner | outer colours;
  the kind        hub / semi-hub of kind O or T / closed; full; crossed or parallel (pairs of the two (Q) arcs of the other pair);
  PAIR            for a parallel full semi-hub, that the two arcs' inner colours differ (FS116-N3-PAIR);
  SEMI            which alternative of FS116-N3-SEMI the fragment realises (colours at y; tips; outer tiles);
  STAR2           p's edge directions relative to psi against the pinned windows of § 2.3 (crossed kind O; parallel kind O);
  CROSS           at a crossed full semi-hub of kind O: no tip of positive angle, outer colours inside {a', b'}, and with four colours O_y = {a', b'},
                  A(y) = {a, b}; and, where the fragment holds the ring of y (the strip), that p is a change point of y's ring with b just
                  counter-clockwise and a just clockwise, and a semi-hub of kind O of it.
Run: python3 tools/fs116_n3_semi.py [--plant | --plantpair]   (--plant reads every (Q) arc with inner and outer swapped: CROSS and RECIP must then
     fail on the strip; --plantpair swaps only the arcs at u-, u+: PAIR must then fail on the bowtie)
Last line: 'SEMI ALL OK' when every prediction holds, else 'SEMI VIOLATIONS n'.
"""
from __future__ import annotations
import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs116_n1_ring as RG          # noqa: E402  (read-only import of FS116-N1's ring tool)
import fs114_yb3_run as XR          # noqa: E402  (read-only, via FS116-N1's imports)
import fs112_yb2_objects as O       # noqa: E402  (read-only)

TAU = 2 * math.pi
TOL = 0.1     # degrees: the star is read on a 0.05-degree grid, and the bowtie meets its windows with equality
D = math.radians
PLANT = "--plant" in sys.argv
PLANTPAIR = "--plantpair" in sys.argv   # swap inner and outer of the (Q) arc at u+ / u- only: PAIR must then fail on the bowtie
bad = []


def deg(t):
    return math.degrees(t) % 360


def qarc_at(TF, p, S, t):
    """the (Q) arc of p's ring holding the ring point at angle t (a germ's midpoint), as (start, end, inner, outer), or None."""
    for g in S["gaps"]:
        if g[0] == "G" and g[4] == "(Q)" and (t - g[1]) % TAU <= g[2] + 1e-12:
            ins = RG.cols(TF, RG.locate(TF, RG.rp(p, t, 1 - 1e-6)))
            out = RG.cols(TF, RG.locate(TF, RG.rp(p, t, 1 + 1e-6)))
            a, b = ins[0], out[0]
            if PLANT or (PLANTPAIR and qarc_at.which == "u"):
                a, b = b, a
            return (g[1], (g[1] + g[2]) % TAU, a, b)
    return None


def locate2(TF, x):
    """the tiles holding x by ray parity, read along two rays (0.1234567 and 2.345678 rad) and a third on disagreement: a ray through a
    vertex miscounts (the first ray passes through p from the sample at 187.07 degrees, which read a phantom sliver)."""
    out = []
    for a in (0.1234567, 2.345678, 4.0123):
        d = (math.cos(a), math.sin(a))
        out.append(sorted(nm for nm, (col, ps) in TF.items() if sum(RG.ray_hits(pc, x, d) for pc in ps) % 2 == 1))
        if len(out) >= 2 and out[-1] == out[-2]:
            return out[-1]
    return max(out, key=out.count)


def star(TF, p, n=7200, r=1e-5):
    """p's tiles in counter-clockwise order with their cones [start, end] (radians), read on a small circle."""
    seq = []
    for i in range(n):
        t = TAU * (i + 0.5) / n
        ts = locate2(TF, (p[0] + r * math.cos(t), p[1] + r * math.sin(t)))
        seq.append((t, ts[0] if ts else None))
    cones, i0 = [], next(i for i in range(n) if seq[i][1] != seq[i - 1][1])
    cur, start = seq[i0][1], seq[i0][0]
    for k in range(1, n + 1):
        t, nm = seq[(i0 + k) % n]
        if nm != cur:
            cones.append((cur, start, t))
            cur, start = nm, t
    return cones


def holds(cone, t):
    _, a, b = cone
    return (t - a) % TAU <= (b - a) % TAU


def classify(TF, p, S, y_ang, d=1e-4):
    u, v = y_ang + math.pi / 3, y_ang - math.pi / 3
    g = {}
    for k, t in (("u-", u - d), ("u+", u + d), ("v-", v - d), ("v+", v + d)):
        qarc_at.which = k[0]
        g[k] = qarc_at(TF, p, S, t)
    tip_off = g["v-"] is None and g["u+"] is None
    out_off = g["u-"] is None and g["v+"] is None
    kind = "hub" if tip_off and out_off else "O" if out_off else "T" if tip_off else "closed"
    other = ("v-", "u+") if kind == "O" else ("u-", "v+") if kind == "T" else None
    full = other is not None and all(g[k] is not None for k in other)
    rel = None
    if full:
        p1, p2 = {g[other[0]][2], g[other[0]][3]}, {g[other[1]][2], g[other[1]][3]}
        rel = "crossed" if not (p1 & p2) else "parallel" if p1 == p2 else "neither"
    return g, kind, full, rel, other


def report(label, TF, p, recip=None):
    S = RG.survey(TF, p, label)
    tp = RG.around(TF, p)
    Pp = set(S["P"])
    cones = star(TF, p)
    print(f"== {label}: P(p) = {S['P']}; star: " + ", ".join(f"{TF[nm][0]}[{deg(a):.2f},{deg(b):.2f}]" for nm, a, b in cones))
    for e, c, chg, before, after in S["events"]:
        if not chg:
            continue
        y = RG.rp(p, e)
        g, kind, full, rel, other = classify(TF, p, S, e)
        ty = RG.around(TF, y)
        Cy = set(RG.cols(TF, ty))
        tips = sorted({TF[t][0] for t in ty if t in tp}, key=str)
        outer = sorted({TF[t][0] for t in ty if t not in tp and TF[t][0] in Pp}, key=str)
        Ay = sorted(Pp - Cy, key=str)
        gtxt = " ".join(f"{k}:{'off' if g[k] is None else str(g[k][2]) + '|' + str(g[k][3])}" for k in ("u-", "u+", "v-", "v+"))
        print(f"  y={deg(e):8.3f}  {gtxt}  kind={kind}{' full ' + rel if full else ''}  C(y)={sorted(Cy, key=str)} tips={tips} outer={outer} A(y)={Ay}")
        if kind in ("O", "T"):
            # SEMI: the first alternative is the only one a held fragment can show without a three-colour semi-hub
            alt = "four colours" if len(Cy) >= 4 else "three colours"
            print(f"     SEMI: {alt}")
            if len(Cy) < 4:
                bad.append(f"{label} y={deg(e):.2f}: a three-colour semi-hub (not predicted absent; inspect)")
        if full and rel == "parallel":
            i1, i2 = g[other[0]][2], g[other[1]][2]
            ok = i1 != i2
            print(f"     PAIR: inner colours {i1}, {i2} — {'differ' if ok else 'EQUAL (violation)'}")
            if not ok:
                bad.append(f"{label} y={deg(e):.2f}: PAIR")
        if full and kind == "O":
            A_, B_ = g["u+"], g["v-"]
            l, m = deg(A_[1] - A_[0]) % 360, deg(B_[1] - B_[0]) % 360
            relang = [(nm, (deg(a - e)) % 360, (deg(b - e)) % 360) for nm, a, b in cones]
            if rel == "crossed":
                a, a2, b, b2 = A_[2], A_[3], B_[2], B_[3]
                okt = not tips
                oko = set(outer) <= {a2, b2}
                ok4 = len(Cy) < 4 or (set(outer) == {a2, b2} and set(Ay) == {a, b})
                order = [TF[nm][0] for nm, _, _ in cones]
                k = order.index(b)
                rot = order[k:] + order[:k]
                okord = rot == [b, a, b2, a2]
                edge = {TF[nm][0]: (s, t) for nm, s, t in relang}

                def inwin(x, lo, hi):
                    return (x - lo + TOL) % 360 <= (hi - lo) % 360 + 2 * TOL
                e1, e2, e3, e4 = edge[a][0], edge[b2][0], edge[a2][0], edge[b][0]
                okw = (inwin(e1, l - 30, 30 - m) and inwin(e2, 30, 150) and inwin(e3, 150 + l, 210 - m) and inwin(e4, 210, 330) and l + m <= 60 + 1e-6)
                print(f"     CROSS: a={a} a'={a2} b={b} b'={b2} (l={l:.3f}, m={m:.3f}); no tip {okt}; outer in {{a',b'}} {oko}; four colours => "
                      f"O={{a',b'}}, A={{a,b}} {ok4}; star order b,a,b',a' {okord}; edges e1..e4 = {e1:.2f},{e2:.2f},{e3:.2f},{e4:.2f} in windows {okw}")
                for nmk, okk in (("no tip", okt), ("outer", oko), ("four", ok4), ("order", okord), ("windows", okw)):
                    if not okk:
                        bad.append(f"{label} y={deg(e):.2f}: CROSS {nmk}")
                if recip is not None and abs(deg(e)) < 1e-6 or (recip is not None and abs(deg(e) - 360) < 1e-6):
                    yl, TY, yp = recip
                    SY = RG.survey(TY, yp, yl)
                    hit = [ev for ev in SY["events"] if math.dist(RG.rp(yp, ev[0]), p) < 1e-6]
                    if not hit:
                        print("     RECIP: p is not an event of y's ring (violation)")
                        bad.append(f"{label}: RECIP p not on y's ring events")
                    else:
                        ev = hit[0]
                        ccw, cw = ev[4][3], ev[3][3]
                        gy, kindy, fully, rely, _ = classify(TY, yp, SY, ev[0])
                        okr = ev[2] and ccw == [b] and cw == [a] and kindy == "O"
                        print(f"     RECIP: p is a change point of y's ring: {ev[2]}; y's ring just ccw of p {ccw}, just cw {cw} (predicted [{b}], [{a}]); "
                              f"p is of kind {kindy}{' full ' + rely if fully else ''} for y — {'OK' if okr else 'VIOLATION'}")
                        if not okr:
                            bad.append(f"{label}: RECIP")
            elif rel == "parallel":
                a, a2 = A_[2], A_[3]
                cn = {TF[nm][0]: (s, t) for nm, s, t in relang}

                def inside(c, lo, hi):
                    s, t = cn[c]
                    return ((s - lo + TOL) % 360 <= (hi - lo) % 360 + 2 * TOL and (t - lo + TOL) % 360 <= (hi - lo) % 360 + 2 * TOL
                        and (t - s) % 360 <= (hi - lo) % 360 + 2 * TOL)
                front = [TF[nm][0] for nm, s, t in relang if (0 - s) % 360 < (t - s) % 360]
                back = [TF[nm][0] for nm, s, t in relang if (180 - s) % 360 < (t - s) % 360]
                okp = inside(a, 30, 150) and inside(a2, 210, 330)
                okt = set(tips) <= set(front) and set(outer) <= set(back) | {a, a2}
                print(f"     STAR2 (parallel): t_a in [30,150] and t_a' in [210,330]: {okp}; front tile {front}, back tile {back}; tips within front, "
                      f"outer within back or {{a,a'}}: {okt}")
                if not okp:
                    bad.append(f"{label} y={deg(e):.2f}: STAR2 parallel")
                if not okt:
                    bad.append(f"{label} y={deg(e):.2f}: tips/outer parallel")


qarc_at.which = ""


def main():
    st = O.Strip().tiles(-4, 8)
    TS = RG.fl_tiles(XR.conv_tiles(st))
    report("strip P0=(0,0)", TS, (0.0, 0.0), recip=("strip P2=(1,0)", TS, (1.0, 0.0)))
    report("strip P1=(1/2,0)", TS, (0.5, 0.0), recip=("strip P3=(3/2,0)", TS, (1.5, 0.0)))
    import fs114_yb2_run as BW      # read-only import of FS114-YB2's bowtie rebuild
    report("Y2 bowtie centre", RG.fl_tiles(XR.conv_tiles(BW.Bowtie().tiles())), (0.0, 0.0))
    dk = O.Disk()
    report("disk corner A0", RG.fl_tiles(XR.conv_tiles(dk.tiles())), RG.f(dk.pt("A", 0)))
    for b_ in bad:
        print("  VIOLATION:", b_)
    print("SEMI ALL OK" if not bad else f"SEMI VIOLATIONS {len(bad)}")


if __name__ == "__main__":
    main()
