#!/usr/bin/env python3
"""FS116-N1: the ring of a vertex of a held fragment, read piece by piece (FLOAT survey for aiming; the load-bearing facts are re-checked exactly
by `exact` below, in sympy).

For a vertex p of a held fragment (the strip, the disk, FS112-BOWTIE, the Y2 bowtie rebuild), it reports:
  P(p)            the colours at p (tiles whose closure holds p, read on a small circle about p);
  the ring word   the arcs of omega(p) in counter-clockwise order: an off-Gamma arc with its colour, or an arc of Gamma on omega(p) with its inner and
                  outer colours and its kind — (Q) (both sides colours of p), in-P (inner of p, outer absent), out-P (outer of p, inner absent: (R2)-like),
                  AA (both absent), seam (one colour both sides);
  the events      every point of Gamma on the ring that is not interior to an arc of Gamma on omega(p), with the colours around it, and whether it is a
                  change point (off-Gamma on both sides, colours differ);
  D               the ring points in the closure of a tile of a colour of p; its maximal complementary arcs and their lengths (a half-open 60-degree window
                  W with W u sigma(W) off D exists iff some complementary arc is longer than 120 degrees);
  the twist       at 3600 sample angles theta with theta and theta + 60 both off Gamma, whether the colours differ.
Run: python3 tools/fs116_n1_ring.py diskexact [--plant] [--noexit]  (the disk corner's two-colour change point, exactly; --noexit: exit 0 on FAIL)
     python3 tools/fs116_n1_ring.py survey [--plant]      (the plant recolours the strip's arch U1 from G to R: its ring loses both change points)
     python3 tools/fs116_n1_ring.py germ [--plant]         (RING-GERM's four germs at every change point, its predictions, and what the fragment has)
     python3 tools/fs116_n1_ring.py hyp                    (float readings of non-Siamese and simple on the disk and the strip)
     python3 tools/fs116_n1_ring.py summary [--plant]     (one line per vertex, for the record's controls)
     python3 tools/fs116_n1_ring.py exact                 (the load-bearing identities of the strip's midline ring, in sympy)
"""
from __future__ import annotations
import math
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb3_run as XR          # noqa: E402  (read-only import of FS114-YB3's converter)
import fs112_yb2_objects as O       # noqa: E402  (read-only import of FS112-YB2's objects)

EPS = 1e-9
TAU = 2 * math.pi


def f(p):
    return (float(p[0]), float(p[1]))


def fl_tiles(T):
    out = {}
    for nm, (col, ps) in T.items():
        qs = []
        for pc in ps:
            if pc.kind == "S":
                qs.append(("S", f(pc.P), f(pc.Q)))
            else:
                qs.append(("A", f(pc.C), float(pc.rho), f(pc.S), f(pc.E)))
        out[nm] = (col, qs)
    return out


def ang(v):
    return math.atan2(v[1], v[0]) % TAU


def on_arc(pc, x):
    _, C, rho, S, E = pc
    a0, a1, t = ang((S[0] - C[0], S[1] - C[1])), ang((E[0] - C[0], E[1] - C[1])), ang((x[0] - C[0], x[1] - C[1]))
    span = (a1 - a0) % TAU
    return (t - a0) % TAU <= span + 1e-9 or (a0 - t) % TAU <= 1e-9


def ray_hits(pc, x, d):
    """number of crossings of the ray x + s d (s > 0) with the piece."""
    if pc[0] == "S":
        a, b = pc[1], pc[2]
        e = (b[0] - a[0], b[1] - a[1])
        den = d[0] * (-e[1]) - d[1] * (-e[0])
        if abs(den) < 1e-15:
            return 0
        r = (a[0] - x[0], a[1] - x[1])
        s = (r[0] * (-e[1]) - r[1] * (-e[0])) / den
        t = (d[0] * r[1] - d[1] * r[0]) / den
        return 1 if (s > 0 and 0 <= t < 1) else 0
    _, C, rho, S, E = pc
    fx, fy = x[0] - C[0], x[1] - C[1]
    b = fx * d[0] + fy * d[1]
    c = fx * fx + fy * fy - rho * rho
    disc = b * b - c
    if disc <= 0:
        return 0
    n = 0
    for s in (-b - math.sqrt(disc), -b + math.sqrt(disc)):
        if s > 0:
            y = (x[0] + s * d[0], x[1] + s * d[1])
            if on_arc(pc, y) and math.dist(y, E) > 1e-12:
                n += 1
    return n


def locate(TF, x):
    d = (math.cos(0.1234567), math.sin(0.1234567))
    return [nm for nm, (col, ps) in TF.items() if sum(ray_hits(pc, x, d) for pc in ps) % 2 == 1]


def around(TF, y, r=1e-6, n=144):
    tiles = set()
    for i in range(n):
        t = TAU * (i + 0.5) / n
        tiles.update(locate(TF, (y[0] + r * math.cos(t), y[1] + r * math.sin(t))))
    return tiles


def ring_events(TF, p):
    """angles (about p) of Gamma on omega(p); and the arcs of Gamma lying on omega(p)."""
    evs, rarcs = [], []
    for nm, (col, ps) in TF.items():
        for pc in ps:
            if pc[0] == "S":
                a, b = pc[1], pc[2]
                e = (b[0] - a[0], b[1] - a[1])
                w = (a[0] - p[0], a[1] - p[1])
                A_ = e[0] ** 2 + e[1] ** 2
                B_ = 2 * (w[0] * e[0] + w[1] * e[1])
                C_ = w[0] ** 2 + w[1] ** 2 - 1
                disc = B_ * B_ - 4 * A_ * C_
                if disc < -1e-12:
                    continue
                disc = max(disc, 0)
                for t in ((-B_ - math.sqrt(disc)) / (2 * A_), (-B_ + math.sqrt(disc)) / (2 * A_)):
                    if -1e-9 <= t <= 1 + 1e-9:
                        evs.append(ang((a[0] + t * e[0] - p[0], a[1] + t * e[1] - p[1])))
            else:
                _, C, rho, S, E = pc
                dcp = math.dist(C, p)
                if dcp < 1e-9 and abs(rho - 1) < 1e-9:
                    rarcs.append((ang((S[0] - p[0], S[1] - p[1])), ang((E[0] - p[0], E[1] - p[1]))))
                    continue
                if dcp < 1e-12 or dcp > 1 + rho + 1e-12 or dcp < abs(1 - rho) - 1e-12:
                    continue
                # circle-circle intersection
                a_ = (1 - rho * rho + dcp * dcp) / (2 * dcp)
                h2 = max(1 - a_ * a_, 0)
                ux, uy = (C[0] - p[0]) / dcp, (C[1] - p[1]) / dcp
                for sgn in (1, -1):
                    x = (p[0] + a_ * ux - sgn * math.sqrt(h2) * uy, p[1] + a_ * uy + sgn * math.sqrt(h2) * ux)
                    if on_arc(pc, x):
                        evs.append(ang((x[0] - p[0], x[1] - p[1])))
    for a0, a1 in rarcs:
        evs += [a0, a1]
    evs = sorted(set(round(e, 9) % TAU for e in evs))
    merged = []
    for e in evs:
        if not merged or e - merged[-1] > 1e-7:
            merged.append(e)
    if len(merged) > 1 and merged[0] + TAU - merged[-1] < 1e-7:
        merged.pop()
    return merged, rarcs


def in_rarc(rarcs, t):
    for a0, a1 in rarcs:
        if (t - a0) % TAU < (a1 - a0) % TAU:
            return True
    return False


def rp(p, t, r=1.0):
    return (p[0] + r * math.cos(t), p[1] + r * math.sin(t))


def cols(TF, ts):
    return sorted(set(TF[t][0] for t in ts), key=str)


def survey(TF, p, label):
    Pp = set(cols(TF, around(TF, p)))
    evs, rarcs = ring_events(TF, p)
    word, Dset = [], []
    n = len(evs)
    gaps = []
    for i in range(n):
        a, b = evs[i], evs[(i + 1) % n]
        span = (b - a) % TAU
        mid = (a + span / 2) % TAU
        if in_rarc(rarcs, mid):
            ins = locate(TF, rp(p, mid, 1 - 1e-6))
            out = locate(TF, rp(p, mid, 1 + 1e-6))
            ci = cols(TF, ins)
            co = cols(TF, out)
            ki = [c in Pp for c in ci]
            ko = [c in Pp for c in co]
            if ci == co:
                kind = "seam"
            elif all(ki) and all(ko):
                kind = "(Q)"
            elif all(ki):
                kind = "in-P"
            elif all(ko):
                kind = "out-P"
            else:
                kind = "AA"
            gaps.append(("G", a, span, ci + co, kind))
        else:
            ts = locate(TF, rp(p, mid))
            gaps.append(("O", a, span, cols(TF, ts), ""))
    evinfo = []
    for i, e in enumerate(evs):
        y = rp(p, e)
        c = cols(TF, around(TF, y))
        before, after = gaps[i - 1], gaps[i]
        change = before[0] == "O" and after[0] == "O" and before[3] != after[3]
        evinfo.append((e, c, change, before, after))
    # D: events whose colours meet P, and Gamma-arcs with a side colour in P
    inD = []
    for e, c, _, _, _ in evinfo:
        inD.append(("pt", e, e, any(x in Pp for x in c)))
    for g in gaps:
        if g[0] == "G":
            inD.append(("arc", g[1], (g[1] + g[2]) % TAU, any(x in Pp for x in g[3])))
        else:
            inD.append(("arc", g[1], (g[1] + g[2]) % TAU, False))
    # maximal D-free arcs: walk the gaps; a D-free run is a union of D-free open gaps joined at D-free events
    Dfree = []
    run = 0.0
    start = None
    seq = []
    for i in range(n):
        e, c, _, _, _ = evinfo[i]
        seq.append(("pt", any(x in Pp for x in c), 0.0, e))
        g = gaps[i]
        seq.append(("gap", g[0] == "G" and any(x in Pp for x in g[3]), g[2], g[1]))
    # rotate so that we start at a D element
    k0 = next((i for i, s in enumerate(seq) if s[1]), None)
    if k0 is None:
        Dfree = [(0.0, TAU)]
    else:
        seq = seq[k0:] + seq[:k0]
        for s in seq:
            if s[1]:
                if start is not None:
                    Dfree.append((start, run))
                start, run = None, 0.0
            else:
                if start is None:
                    start = s[3]
                run += s[2]
        if start is not None:
            Dfree.append((start, run))
    # twist at samples
    bad, tested = 0, 0
    for i in range(3600):
        t = TAU * (i + 0.37) / 3600
        t2 = t + math.pi / 3
        if in_rarc(rarcs, t) or in_rarc(rarcs, t2):
            continue
        c1, c2 = cols(TF, locate(TF, rp(p, t))), cols(TF, locate(TF, rp(p, t2)))
        if len(c1) != 1 or len(c2) != 1:
            continue
        tested += 1
        bad += c1 == c2
    return dict(label=label, P=sorted(Pp, key=str), gaps=gaps, events=evinfo, Dfree=Dfree, twist=(tested, bad))


def deg(t):
    return f"{math.degrees(t):8.3f}"


def show(S):
    print(f"== {S['label']}: P(p) = {S['P']}")
    print("  ring word (counter-clockwise):")
    for (e, c, ch, _, _), g in zip(S["events"], S["gaps"]):
        tag = "CHANGE POINT" if ch else "event"
        print(f"    {deg(e)}  {tag:12s} colours {c}  ({len(c)} colours)")
        if g[0] == "G":
            print(f"      arc {deg(g[1])} +{deg(g[2])}  Gamma on the ring, inner|outer {g[3]}  kind {g[4]}")
        else:
            print(f"      arc {deg(g[1])} +{deg(g[2])}  off Gamma, colour {g[3]}")
    print("  D-free maximal arcs (start, length): " + ", ".join(f"({math.degrees(a):.3f}, {math.degrees(l):.3f})" for a, l in S["Dfree"]))
    print(f"  twist: {S['twist'][1]} violations in {S['twist'][0]} sampled pairs")


def summary(S):
    ch = [(round(math.degrees(e), 3), len(c), any(x in S["P"] for x in c)) for e, c, chg, _, _ in S["events"] if chg]
    q = sum(1 for g in S["gaps"] if g[0] == "G" and g[4] == "(Q)")
    mx = max((l for _, l in S["Dfree"]), default=0.0)
    ok4 = all(n >= 4 for _, n, _ in ch)
    return (f"{S['label']}: P={len(S['P'])} (Q)arcs={q} changepoints={len(ch)} all>=4colours={ok4} "
            f"maxDfree={math.degrees(mx):.3f} qualifying={'yes' if math.degrees(mx) > 120 + 1e-6 else 'no'} twistviolations={S['twist'][1]}")


def germs(TF, p, S):
    """for each change point y: the four germs at y +- 60 (u-, u+, v-, v+) and whether each lies on a (Q) arc; RING-GERM's predictions ((i) a tip,
    (ii) an outer tile of a colour of p) and what the fragment has at y (its tiles of p, and its tiles of p's colours that are not tiles of p)."""
    tp = around(TF, p)
    Pp = set(S["P"])
    qarcs = [(g[1], (g[1] + g[2]) % TAU) for g in S["gaps"] if g[0] == "G" and g[4] == "(Q)"]

    def onq(t):
        return any((t - a) % TAU <= (b - a) % TAU + 1e-12 for a, b in qarcs)
    rows = []
    d = 1e-4
    for e, c, chg, _, _ in S["events"]:
        if not chg:
            continue
        u, v = e + math.pi / 3, e - math.pi / 3
        g = {"u-": not onq(u - d), "u+": not onq(u + d), "v-": not onq(v - d), "v+": not onq(v + d)}
        ty = around(TF, rp(p, e))
        tips = sorted(t for t in ty if t in tp)
        outer = sorted(t for t in ty if t not in tp and TF[t][0] in Pp)
        pred_i = g["v-"] and g["u+"]
        pred_ii = g["u-"] and g["v+"]
        if "--plantrule" in sys.argv:          # planted: the tip read from the wrong pair of germs
            pred_i = g["u-"] and g["v+"]
        rows.append(f"  y={math.degrees(e):8.3f}  germs off (Q): {''.join(k for k, ok in g.items() if ok) or 'none'}  "
                    f"(i) tip forced={pred_i} has tip={bool(tips)}  (ii) outer forced={pred_ii} has outer={bool(outer)}  colours={len(c)}"
                    f"  {'CONSISTENT' if (not pred_i or tips) and (not pred_ii or outer) else 'VIOLATES RING-GERM'}")
    return rows


def hyp():
    """FLOAT readings of RING-Q's class hypotheses on the held disk and strip: the least distance between two distinct tiles of one colour (non-Siamese:
    at least 1), and the tile pairs whose closures meet in more than one component (simple: none).  Boundaries sampled at 400 points per piece."""
    import itertools

    def samples(ps, n=400):
        pts = []
        for pc in ps:
            if pc[0] == "S":
                a, b = pc[1], pc[2]
                pts += [(a[0] + (b[0] - a[0]) * i / n, a[1] + (b[1] - a[1]) * i / n) for i in range(n + 1)]
            else:
                _, C, r, S_, E_ = pc
                a0 = math.atan2(S_[1] - C[1], S_[0] - C[0])
                sp_ = (math.atan2(E_[1] - C[1], E_[0] - C[0]) - a0) % TAU
                pts += [(C[0] + r * math.cos(a0 + sp_ * i / n), C[1] + r * math.sin(a0 + sp_ * i / n)) for i in range(n + 1)]
        return pts

    def ncomp(pts, th=0.01):
        pts = list(pts)
        lab = [-1] * len(pts)
        c = 0
        for i in range(len(pts)):
            if lab[i] >= 0:
                continue
            st = [i]
            lab[i] = c
            while st:
                j = st.pop()
                for k in range(len(pts)):
                    if lab[k] < 0 and math.dist(pts[j], pts[k]) < th:
                        lab[k] = c
                        st.append(k)
            c += 1
        return c
    dt = O.Disk().tiles()
    if "--plant" in sys.argv:              # planted: W1 recoloured violet, the colour of its neighbour P1 across the segment A1 X1
        dt["W1"] = ("violet", dt["W1"][1])
    for label, T in (("disk", dt), ("strip", O.Strip().tiles(-2, 3))):
        TF = fl_tiles(XR.conv_tiles(T))
        Sm = {nm: samples(ps) for nm, (c, ps) in TF.items()}
        worst = min(min(math.dist(x, y) for x in Sm[a][::3] for y in Sm[b][::3])
                    for a, b in itertools.combinations(TF, 2) if TF[a][0] == TF[b][0])
        multi = []
        for a, b in itertools.combinations(TF, 2):
            sh = [x for x in Sm[a] if any(_pdist(pc, x) < 1e-9 for pc in TF[b][1])]
            if sh and ncomp(set((round(x[0], 9), round(x[1], 9)) for x in sh)) > 1:
                multi.append((a, b))
        print(f"{label}: least distance between distinct tiles of one colour {worst:.6f}; tile pairs meeting in more than one component: {multi}")


def objects(plant=False):
    st = O.Strip().tiles(-4, 6)
    if plant:
        col, ps = st["U1"]
        st["U1"] = ("R", ps)
    yield "strip P0=(0,0)", XR.conv_tiles(st), (0.0, 0.0)
    yield "strip P1=(1/2,0)", XR.conv_tiles(st), (0.5, 0.0)
    dk = O.Disk()
    DT = XR.conv_tiles(dk.tiles())
    for k in (0,):
        A = f(dk.pt("A", k))
        yield f"disk corner A{k}", DT, A


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else "survey"
    plant = "--plant" in sys.argv
    if mode == "exact":
        return exact(plant)
    if mode == "hyp":
        return hyp()
    if mode == "diskexact":
        return diskexact(plant)
    objs = list(objects(plant))
    if mode == "germ" or "--bowtie" in sys.argv:
        import fs114_yb2_run as BW          # read-only import of FS114-YB2's bowtie rebuild
        objs.append(("Y2 bowtie centre", XR.conv_tiles(BW.Bowtie().tiles()), (0.0, 0.0)))
    for label, T, p in objs:
        TF = fl_tiles(T)
        S = survey(TF, p, label)
        if mode == "survey":
            show(S)
        elif mode == "germ":
            print(label)
            for r in germs(TF, p, S):
                print(r)
        else:
            print(summary(S))


def exact(plant=False):
    """the strip's midline ring about P0 = (0, 0), exactly (sympy): the four (Q) arcs' ends on omega(P0); the change points P(+-2) on it; the colours.
    --plant: the apex height sqrt15/4 replaced by 97/100 (the ogive's apex moved off omega(P0))."""
    import sympy as sp
    out = print if "--line" not in sys.argv else (lambda *a, **k: None)
    r3, r15 = sp.sqrt(3), (sp.Rational(97 * 4, 100) if plant else sp.sqrt(15))
    pts = {"V1": (sp.Rational(1, 2), r3 / 2), "A0": (sp.Rational(1, 4), r15 / 4), "Vm1": (-sp.Rational(1, 2), r3 / 2),
           "Am1": (-sp.Rational(1, 4), r15 / 4), "P2": (sp.Integer(1), sp.Integer(0)), "Pm2": (sp.Integer(-1), sp.Integer(0))}
    ok = True
    for nm, (x, y) in pts.items():
        v = sp.simplify(x * x + y * y - 1)
        out(f"|{nm}|^2 - 1 = {v}")
        ok &= v == 0
    S = O.Strip()
    col = {f"U{j}": S.ARCH[j % 3] for j in range(-3, 4)}
    col.update({f"D{j}": S.INV[j % 3] for j in range(-3, 4)})
    P0 = sorted({col["U-1"], col["U0"], col["D-1"], col["D0"]})
    P2 = sorted({col["U1"], col["U2"], col["D1"], col["D2"]})
    out(f"P(P0) = {P0}; P(P2) = {P2}; P(P2) meets P(P0) in {sorted(set(P0) & set(P2))}")
    out(f"ring colours: (0,60) in U1 = {col['U1']}, (-60,0) in D1 = {col['D1']}; absent at P0: {sorted(set('BGMOPR') - set(P0))}")
    ok &= set(P0) == {"B", "M", "O", "P"} and len(P2) == 4
    print("EXACT", "OK" if ok else "FAIL")
    sys.exit(0 if (ok or "--noexit" in sys.argv) else 1)


def diskexact(plant=False):
    """the disk's corner A0 (FS112-CAL-DISK): the ring omega(A0) crosses the segment A1 X1 (between W1, green, and P1, violet) at a point y strictly
    inside it, whose points at +-60 degrees on omega(A0) lie strictly inside the (Q) arcs A2->A3 (Z | P2) and B0->Y0 (P0 | T1).  Exact expressions,
    evaluated to 50 digits (every margin printed; the smallest is far above the precision).  --plant moves y by rotating it 20 degrees about A0,
    after which it is no longer on the segment and the +60 point leaves the arc A2->A3."""
    import sympy as sp
    dk = O.Disk()
    E = lambda nm, k: tuple(c.e for c in XR.conv_pt(dk.pt(nm, k)))
    A0, A1, A2, A3, X1, B0, Y0 = E("A", 0), E("A", 1), E("A", 2), E("A", 3), E("X", 1), E("B", 0), E("Y", 0)
    d = (X1[0] - A1[0], X1[1] - A1[1])
    w = (A1[0] - A0[0], A1[1] - A0[1])
    a_, b_, c_ = d[0] ** 2 + d[1] ** 2, 2 * (w[0] * d[0] + w[1] * d[1]), w[0] ** 2 + w[1] ** 2 - 1
    N = lambda z: sp.N(z, 50)
    disc = N(b_ * b_ - 4 * a_ * c_)
    roots = [(-N(b_) - sp.sqrt(disc)) / (2 * N(a_)), (-N(b_) + sp.sqrt(disc)) / (2 * N(a_))]
    t = [r for r in roots if 0 < r < 1]
    rows, ok = [], True
    rows.append(f"roots t of |A1 + t(X1 - A1) - A0| = 1: {[float(r) for r in roots]}; in (0, 1): {len(t)}")
    ok &= len(t) == 1
    t = t[0]
    y = (N(A1[0]) + t * N(d[0]), N(A1[1]) + t * N(d[1]))
    if plant:
        c, s_ = sp.cos(sp.pi / 9), sp.sin(sp.pi / 9)
        r0 = (y[0] - N(A0[0]), y[1] - N(A0[1]))
        y = (N(A0[0]) + c * r0[0] - s_ * r0[1], N(A0[1]) + s_ * r0[0] + c * r0[1])
    rel = (y[0] - N(A0[0]), y[1] - N(A0[1]))
    rows.append(f"|y - A0|^2 - 1 = {float(rel[0]**2 + rel[1]**2 - 1):.3e};  angle of y about A0 = {float(sp.atan2(rel[1], rel[0]) * 180 / sp.pi) % 360:.6f} deg")
    # y on the segment: collinearity and 0 < t < 1
    col = (y[0] - N(A1[0])) * N(d[1]) - (y[1] - N(A1[1])) * N(d[0])
    rows.append(f"cross(y - A1, X1 - A1) = {float(col):.3e}  (0 on the segment);  t = {float(t):.6f}, margins {float(t):.4f}, {float(1 - t):.4f}")
    ok &= abs(col) < 1e-40
    rot = lambda v, sg: (v[0] / 2 - sg * sp.sqrt(3) / 2 * v[1], sg * sp.sqrt(3) / 2 * v[0] + v[1] / 2)
    u = rot(rel, 1)
    v = rot(rel, -1)
    cr = lambda p_, q_: p_[0] * q_[1] - p_[1] * q_[0]
    rA2 = (N(A2[0] - A0[0]), N(A2[1] - A0[1]))
    rA3 = (N(A3[0] - A0[0]), N(A3[1] - A0[1]))
    rB0 = (N(B0[0] - A0[0]), N(B0[1] - A0[1]))
    rY0 = (N(Y0[0] - A0[0]), N(Y0[1] - A0[1]))
    m1, m2 = cr(rA2, u), cr(u, rA3)
    m3, m4 = cr(rB0, v), cr(v, rY0)
    rows.append(f"y + 60 strictly inside the arc A2 -> A3 about A0: cross(A2, u) = {float(m1):.5f} > 0, cross(u, A3) = {float(m2):.5f} > 0")
    rows.append(f"y - 60 strictly inside the arc B0 -> Y0 about A0: cross(B0, v) = {float(m3):.5f} > 0, cross(v, Y0) = {float(m4):.5f} > 0")
    ok &= m1 > 0 and m2 > 0 and m3 > 0 and m4 > 0
    line = "--line" in sys.argv
    for z in rows:
        if not line:
            print(z)
    # the side tiles, read in floats at distance 1e-4 along the ring (aiming; the pieces through y are listed exactly by the survey)
    TF = fl_tiles(XR.conv_tiles(dk.tiles()))
    A0f = (float(A0[0]), float(A0[1]))
    th = math.atan2(float(rel[1]), float(rel[0]))
    cw, ccw = locate(TF, rp(A0f, th - 1e-4)), locate(TF, rp(A0f, th + 1e-4))
    near = [nm for nm, (cl, ps) in TF.items() if any(_pdist(pc, (float(y[0]), float(y[1]))) < 1e-3 for pc in ps)]
    if not line:
        print(f"ring just clockwise of y in {[(n, TF[n][0]) for n in cw]}; just counter-clockwise in {[(n, TF[n][0]) for n in ccw]}; "
              f"tiles with a boundary piece within 1e-3 of y: {sorted(near)}")
    ok &= [TF[n][0] for n in cw] == ["green"] and [TF[n][0] for n in ccw] == ["violet"] and sorted(near) == ["P1", "W1"]
    print("DISKEXACT", "OK" if ok else "FAIL")
    sys.exit(0 if (ok or "--noexit" in sys.argv) else 1)


def _pdist(pc, x):
    if pc[0] == "S":
        a, b = pc[1], pc[2]
        e = (b[0] - a[0], b[1] - a[1])
        L = e[0] ** 2 + e[1] ** 2
        t = max(0.0, min(1.0, ((x[0] - a[0]) * e[0] + (x[1] - a[1]) * e[1]) / L))
        return math.dist(x, (a[0] + t * e[0], a[1] + t * e[1]))
    _, C, rho, S, E_ = pc
    dd = math.dist(x, C)
    if dd > 0:
        q = (C[0] + rho * (x[0] - C[0]) / dd, C[1] + rho * (x[1] - C[1]) / dd)
        if on_arc(pc, q):
            return abs(dd - rho)
    return min(math.dist(x, S), math.dist(x, E_))


if __name__ == "__main__":
    main()
