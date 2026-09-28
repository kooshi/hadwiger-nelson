#!/usr/bin/env python3
"""FS112-Y2: CAL-DISK, [Polymath2021] Fig. 10's 6-tiling of a disk of radius sqrt(5/2 + 9/(2 sqrt5)), rebuilt in three separated steps.

Step 1 (committed before this tool existed): the combinatorics transcribed by eye -- plans/FS112-Y-construction.md, Stage 4 (26 tiles, 20 unit arcs
all centred at the five corners A_k of a central Reuleaux pentagon; the skeleton of five connected unit pentagons, [11.34]).
Step 2 (`solve`): the exact constraint system solved by computer algebra (sympy): the one unknown |OA| from "connected" (B_0 = rho(E_0)), then
every derived identity the transcription's rules imply, and the control r^2 = |OC|^2 = (25 + 9 sqrt5)/10 (and Parts's form phi^2 (15 + sqrt5)/10).
Step 3 (`check`): the 26 tiles built exactly in FS112-Y's tower checker (tools/fs112_y_check.py, run, never edited) over
    Q(sqrt5)(sqrt(10 + 2 sqrt5))(sqrt((sqrt5 - 1)/2))(sqrt((25 + 9 sqrt5)/10)),
every same-colour pair (each tile with itself) examined, pairs examined printed against the number the object has; closed_interval (tightness);
the unit arcs' kinds read off exactly; a float partition guard inside the disc (a guard, never a verdict).
`readoff`: closure types, the rings of the four-colour corners, the close covering pairs of vertices and their common unit points (YB-SEAMS for the
disk), and the rim points above which no colour is available (where the disk cannot be continued).
FS112-YB's checker (tools/fs112_yb_check.py) cannot represent this object: its field is Q(sqrt p : p prime <= 23), multiquadratic, and the disk needs
sin 72 = sqrt(10 + 2 sqrt5)/4, which generates a cyclic quartic field (`yb` section demonstrates the refusal).
Plants (--plant NAME, each beside the faithful disk, predicted in the record before the run): ring2_short (the ring-2 tops at radius 99/100 about A_k),
swap (U_0 and U'_0 exchange colours), chords (the central tile's arcs replaced by chords).
Run: python3 tools/fs112_y2_disk.py [solve|check|readoff|yb] [--plant NAME]
"""
from __future__ import annotations
import sys, os, math, itertools
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import fs112_y_check as Y          # noqa: E402

OK = True
PLANT = None


def say(ok, msg):
    global OK
    OK &= bool(ok)
    print(("ok       " if ok else "MISMATCH ") + msg)


# ================================================================== step 2: the exact system (sympy)
def solve():
    import sympy as sp
    print("== step 2: the exact constraint system (sympy)")
    a = sp.symbols("a", positive=True)
    E_ = lambda deg: sp.Matrix([sp.cos(sp.pi * deg / 180), sp.sin(sp.pi * deg / 180)])
    rot = lambda v, deg: sp.Matrix([[sp.cos(sp.pi * deg / 180), -sp.sin(sp.pi * deg / 180)], [sp.sin(sp.pi * deg / 180), sp.cos(sp.pi * deg / 180)]]) * v
    A = sp.Matrix([0, a])
    B = A + E_(144); C = B + E_(72); D = C + E_(0); E = D + E_(-72)
    say(sp.simplify((E + E_(-144)) - A) == sp.zeros(2, 1), "Pi_0 = ABCDE closes: a unit regular pentagon with A on the axis (edges at 144, 72, 0, -72, -144 deg)")
    # "connected": B_0 = rho(E_0), rho the rotation by 72 deg
    eqs = list(B - rot(E, 72))
    sol = sp.solve(eqs[0], a)
    say(len(sol) == 1, f"'connected' (B_0 = rho E_0): x-equation has one positive root a = {sol}")
    a0 = sp.nsimplify(sp.simplify(sol[0]))
    say(sp.simplify(eqs[1].subs(a, sol[0])) == 0, "the y-equation holds at that root (the system is consistent: one unknown, rank one)")
    s72 = sp.sin(2 * sp.pi / 5)
    say(sp.simplify(sol[0] - 1 / (2 * s72)) == 0, f"a = |OA| = 1/(2 sin 72) exactly (= {float(sol[0]):.9f}): the A_k form a regular pentagon of diagonal 1")
    phi = (1 + sp.sqrt(5)) / 2
    Cs = C.subs(a, sol[0]); Ds = D.subs(a, sol[0]); As = A.subs(a, sol[0]); Bs = B.subs(a, sol[0])
    r2 = sp.simplify(sp.expand(Cs.dot(Cs)))
    say(sp.simplify(r2 - (25 + 9 * sp.sqrt(5)) / 10) == 0, f"CONTROL: r^2 = |OC|^2 = {sp.nsimplify(r2)} = (25 + 9 sqrt5)/10 exactly; r = {math.sqrt(float(r2)):.9f}")
    say(sp.simplify(r2 - sp.Rational(5, 2) - 9 / (2 * sp.sqrt(5))) == 0, "   = 5/2 + 9/(2 sqrt5) (the caption)")
    say(sp.simplify(r2 - phi ** 2 * (15 + sp.sqrt(5)) / 10) == 0, "   = phi^2 (15 + sqrt5)/10 (Parts, [11.34])")
    say(sp.simplify(Ds.dot(Ds) - r2) == 0, "|OD| = |OC| (both on the rim)")
    A1 = rot(As, 72); A2 = rot(As, 144)
    say(sp.simplify((A1 - As).dot(A1 - As) - 1 / phi ** 2) == 0 and sp.simplify((A2 - As).dot(A2 - As) - 1) == 0,
        "|A_0A_1| = 1/phi, |A_0A_2| = 1: the central Reuleaux pentagon has width 1")
    ZL = As + (Cs - As) / phi; ZR = As + (Ds - As) / phi
    say(sp.simplify((Cs - As).dot(Cs - As) - phi ** 2) == 0, "|AC| = phi, so Z^L = A + (C - A)/phi is at distance 1 from A")
    BD = sp.Matrix.hstack(Ds - Bs, ZL - Bs)
    say(sp.simplify(BD.det()) == 0, "Z^L lies on BD: Z^L = AC cap BD (a pentagram point)")
    say(sp.simplify((ZL - Ds).dot(ZL - Ds) - 1) == 0 and sp.simplify((ZR - Cs).dot(ZR - Cs) - 1) == 0, "|Z^L D| = |Z^R C| = 1: the red rim tile has unit diagonals")
    L2 = 1 - 1 / phi ** 2
    say(sp.simplify(L2 - (sp.sqrt(5) - 1) / 2) == 0, "leg length L: L^2 = 1 - |A_0A_1|^2 = (sqrt5 - 1)/2 = 1/phi")
    n0 = E_(126)
    say(sp.simplify(n0.dot(A1 - As)) == 0, "the outward normal of side A_0A_1 is the unit vector at 126 deg")
    Yp = As + sp.sqrt(L2) * n0
    say(sp.simplify((Yp - A1).dot(Yp - A1) - 1) == 0, "Y_0 = A_0 + L n_0 lies on omega(A_1): the leg ends on the unit arc")
    say(sp.simplify((Bs - A1).dot(Bs - A1) - 1) == 0 and sp.simplify((Bs - As).dot(Bs - As) - 1) == 0, "|B_0A_0| = |B_0A_1| = 1")
    say(sp.simplify(Bs[0] * sp.sin(sp.pi * 126 / 180) - Bs[1] * sp.cos(sp.pi * 126 / 180)) == 0, "B_0 lies on the ray at 126 deg: u_0 = r e(126) is on the ray O B_0")
    # the pair (B_0, Z^R_0): complementary, its two common unit points
    say(sp.simplify((As - ZR).dot(As - ZR) - 1) == 0 and sp.simplify((Cs - Bs).dot(Cs - Bs) - 1) == 0,
        "(B_0, Z^R_0): |A_0 Z^R_0| = |A_0 B_0| = 1 and |C_0 Z^R_0| = |C_0 B_0| = 1 -- their common unit points are A_0 and C_0")
    return dict(a=sol[0], r2=r2)


# ================================================================== step 3: the tiles in FS112-Y's tower
def field():
    # d1 = 5; d2 = 10 + 2 sqrt5 (level 1); d3 = (sqrt5 - 1)/2 (level 2); d4 = (25 + 9 sqrt5)/10 (level 3)
    z = (Fr(0), Fr(0))
    return Y.Field([Fr(5), (Fr(10), Fr(2)), ((Fr(-1, 2), Fr(1, 2)), z), (((Fr(5, 2), Fr(9, 10)), z), (z, z))],
                   names=["5", "10+2r5", "(r5-1)/2", "(25+9r5)/10"])


class Disk:
    def __init__(self, plant=None):
        F = self.F = field()
        r5, s, L, r = F.gen(1), F.gen(2), F.gen(3), F.gen(4)
        self.r5, self.s, self.L, self.r = r5, s, L, r
        one = F(1)
        c18, s18 = s / 4, (r5 - 1) / 4                      # cos 18 = sin 72, sin 18 = cos 72
        def cmul(u, v): return (u[0] * v[0] - u[1] * v[1], u[0] * v[1] + u[1] * v[0])
        e = {0: (one, F(0))}
        for k in range(1, 20):
            e[18 * k] = cmul(e[18 * (k - 1)], (c18, s18))
        self.e = lambda deg: e[deg % 360]
        def rot(p, deg): return cmul(self.e(deg), p)
        self.rot = rot
        phi = (1 + r5) / 2
        a = 2 / s                                            # 1/(2 sin 72)
        A = (F(0), a)
        B = Y.add(A, self.e(144)); C = Y.add(B, self.e(72)); D = Y.add(C, self.e(0))
        assert Y.n2(C) == F(Fr(5, 2)) + F(Fr(9, 10)) * r5
        assert r * r == Y.n2(C)
        zr = 99 * one / 100 if plant == "ring2_short" else one
        ZL = Y.add(A, Y.mul(zr / phi, Y.sub(C, A))); ZR = Y.add(A, Y.mul(zr / phi, Y.sub(D, A)))
        n0 = self.e(126)
        A1 = rot(A, 72)
        Yp = Y.add(A, Y.mul(L, n0)); Xp = Y.add(A1, Y.mul(L, n0))
        u = Y.mul(r, self.e(126))
        P = {}
        for k in range(5):
            d = 72 * k
            for nm, p in [("A", A), ("B", B), ("C", C), ("D", D), ("ZL", ZL), ("ZR", ZR), ("Y", Yp), ("X", Xp), ("u", u)]:
                P[(nm, k)] = rot(p, d)
        self.P = P
        O = (F(0), F(0))
        self.O = O
        def g(nm, k): return P[(nm, k % 5)]
        def arc(Cn, rad, p, q):
            a1, a2 = Y.sub(p, Cn), Y.sub(q, Cn)
            return Y.Arc(Cn, rad, p, q) if Y.cross(a1, a2) > 0 else Y.Arc(Cn, rad, q, p)
        cmap = ["Bl", "G", "Yw", "O", "P"]
        c = lambda k: cmap[k % 5]
        T = {}
        cen = []
        for k in range(5):
            if plant == "chords":
                cen.append(Y.Seg(g("A", k), g("A", k + 1)))
            else:
                cen.append(arc(g("A", k + 3), one, g("A", k), g("A", k + 1)))
        T["C0"] = ("R", cen)
        for k in range(5):
            T[f"T1_{k}"] = (c(k + 3), [Y.Seg(g("A", k), g("Y", k)), arc(g("A", k + 1), one, g("Y", k), g("B", k)),
                                       arc(g("A", k), one, g("B", k), g("X", k)), Y.Seg(g("X", k), g("A", k + 1)), cen[k]])
            T[f"T2_{k}"] = (c(k), [Y.Seg(g("A", k), g("X", k - 1)), Y.Seg(g("X", k - 1), g("ZR", k)), arc(g("A", k), zr, g("ZR", k), g("ZL", k)),
                                   Y.Seg(g("ZL", k), g("Y", k)), Y.Seg(g("Y", k), g("A", k))])
            T[f"R_{k}"] = ("R", [arc(O, r, g("D", k), g("C", k)), Y.Seg(g("C", k), g("ZL", k)), arc(g("A", k), zr, g("ZL", k), g("ZR", k)),
                                 Y.Seg(g("ZR", k), g("D", k))])
            T[f"U_{k}"] = (c(k - 1), [arc(O, r, g("C", k), g("u", k)), Y.Seg(g("u", k), g("B", k)), arc(g("A", k + 1), one, g("B", k), g("Y", k)),
                                      Y.Seg(g("Y", k), g("ZL", k)), Y.Seg(g("ZL", k), g("C", k))])
            T[f"Up_{k}"] = (c(k + 2), [arc(O, r, g("u", k), g("D", k + 1)), Y.Seg(g("D", k + 1), g("ZR", k + 1)), Y.Seg(g("ZR", k + 1), g("X", k)),
                                       arc(g("A", k), one, g("X", k), g("B", k)), Y.Seg(g("B", k), g("u", k))])
        if plant == "swap":
            T["U_0"], T["Up_0"] = (T["Up_0"][0], T["U_0"][1]), (T["U_0"][0], T["Up_0"][1])
        self.T = T


def point_range(z, prims):
    """exact candidates (A, B) (distance |sqrt A + B|) from the point z to the boundary pieces: min and max of |z - q| over a tile not
    containing z are attained on its boundary at an endpoint, a segment foot, or a radial point of an arc."""
    zero = z[0] * 0
    out = []
    for p in prims:
        for X in p.ends():
            out.append((Y.n2(Y.sub(z, X)), zero))
        if isinstance(p, Y.Seg):
            d = Y.sub(p.Q, p.P); t = Y.dot(Y.sub(z, p.P), d) / Y.n2(d)
            if zero < t < zero + 1:
                out.append((Y.n2(Y.sub(z, Y.add(p.P, Y.mul(t, d)))), zero))
        else:
            w = Y.sub(z, p.C)
            if p.has_dir(w): out.append((Y.n2(w), -p.r))
            if p.has_dir(Y.mul(-1, w)): out.append((Y.n2(w), p.r))
    return out


def straddles(z, prims):
    cs = point_range(z, prims)
    return any(Y.lt1(*c) for c in cs) and any(Y.gt1(*c) for c in cs)


# ------------------------------------------------------------------ float helpers (guards and readings only)
def fpt(p): return (p[0].f(), p[1].f())


def tile_poly(prims, n=48):
    pts = []
    for ch in Y.polyline(prims, n):
        pts.append(ch)
    return pts


def locate(Tf, x, y):
    return [nm for nm, chains in Tf.items() if Y.inside(chains, x, y)]


def check():
    print(f"== step 3: the 26 tiles in FS112-Y's tower checker{'  [PLANT ' + PLANT + ']' if PLANT else ''}")
    Dk = Disk(PLANT)
    T = Dk.T
    pairs = Y.all_pairs(T)
    counts = {}
    for nm, (c, _) in T.items():
        counts[c] = counts.get(c, 0) + 1
    present = sum(n * (n + 1) // 2 for n in counts.values())
    v, bad, n = Y.check_pairs(T, pairs)
    print(f"   tiles {len(T)}, colour classes {dict(sorted(counts.items()))}; same-colour pairs examined {n} of {present} present")
    print(f"   VERDICT {v}; REJECT pairs {bad}")
    if PLANT is None:
        say(v == "ACCEPT" and n == present, f"CAL-DISK: {v} on {n}/{present} pairs")
        Y.PLANT = "closed_interval"
        v2, bad2, _ = Y.check_pairs(T, pairs)
        Y.PLANT = None
        selfs = [p for p in bad2 if p[0] == p[1]]
        cross = [p for p in bad2 if p[0] != p[1]]
        slack = [p for p in pairs if p not in bad2]
        print(f"   closed_interval: exact contacts at 1 -- {len(selfs)} self pairs (diameter exactly 1), {len(cross)} cross pairs {cross}")
        print(f"   slack pairs (1 outside the closed range): {len(slack)} {slack}")
        say(len(selfs) == 26, "every tile has diameter exactly 1")
        # float partition guard inside the disc
        Tf = {nm: tile_poly(prims) for nm, (c, prims) in T.items()}
        rr = Dk.r.f()
        used = over = hole = 0
        N = 90
        segs = [s for ch in Tf.values() for cc in ch for s in zip(cc, cc[1:])]
        def dseg(x, y, a, b):
            (x1, y1), (x2, y2) = a, b; dx, dy = x2 - x1, y2 - y1; L = dx * dx + dy * dy
            t = 0 if L == 0 else max(0, min(1, ((x - x1) * dx + (y - y1) * dy) / L))
            return math.hypot(x - x1 - t * dx, y - y1 - t * dy)
        for i in range(N):
            for j in range(N):
                x = -rr + 2 * rr * (i + 0.5) / N; y = -rr + 2 * rr * (j + 0.5) / N
                if x * x + y * y > (rr - 2e-3) ** 2: continue
                if min(dseg(x, y, a, b) for a, b in segs) < 2e-3: continue
                k = len(locate(Tf, x, y)); used += 1; over += k > 1; hole += k == 0
        say(over == 0 and hole == 0, f"float partition guard inside the disc: {used} samples, {over} overlaps, {hole} holes")
        # unit arcs and kinds
        arcs = {}
        for nm, (c, prims) in T.items():
            for p in prims:
                if isinstance(p, Y.Arc) and p.r == 1:
                    arcs.setdefault((Y.pkey(p.C), frozenset([Y.pkey(p.S), Y.pkey(p.E)])), []).append((nm, c, p))
        kinds = []
        for kk, lst in arcs.items():
            Cn = lst[0][2].C
            Pcl = Y.closure_type(T, Cn)
            inner = [(nm, c) for nm, c, _ in lst if c in Y.closure_type({nm: T[nm]}, Cn)]
            outer = [(nm, c) for nm, c, _ in lst if (nm, c) not in inner]
            if len(lst) != 2 or len(inner) != 1:
                kinds.append(("UNDECIDED", lst)); continue
            sin_, sout = inner[0][1], outer[0][1]
            kind = ("both" if (sin_ in Pcl and sout in Pcl) else "in" if sin_ in Pcl else "out" if sout in Pcl else "inert")
            cname = [k2 for k2, pp in Dk.P.items() if Y.is0(Y.sub(pp, Cn))]
            kinds.append((kind, cname[0], inner[0][0], outer[0][0], len(Pcl)))
        ks = sorted({k[0] for k in kinds})
        say(len(kinds) == 20 and ks == ["both"], f"unit arcs: {len(kinds)}; kinds {ks}; centres {sorted({k[1] for k in kinds})}; |P_cl| at centres {sorted({k[4] for k in kinds})}")
        for kd in sorted(kinds, key=lambda t: (t[1][1], t[1][0], t[2])):
            print(f"     arc centred {kd[1][0]}{kd[1][1]}: inner {kd[2]}, outer {kd[3]}, kind {kd[0]}")
    return Dk, v, bad


def readoff():
    print("== read-off (exact where stated; float only to locate)")
    Dk = Disk()
    T, P, F = Dk.T, Dk.P, Dk.F
    names = sorted(P)
    pcl = {k: Y.closure_type(T, P[k]) for k in names}
    for k in [("A", 0), ("B", 0), ("C", 0), ("D", 0), ("ZL", 0), ("ZR", 0), ("Y", 0), ("X", 0), ("u", 0)]:
        print(f"   P_cl({k[0]}_{k[1]}) = {sorted(pcl[k])}  (|.| = {len(pcl[k])}; radius {math.hypot(*fpt(P[k])):.6f})")
    four = [k for k in names if len(pcl[k]) >= 4]
    say(sorted({k[0] for k in four}) == ["A"], f"four-colour vertices: {len(four)}, all corners of the central tile: {sorted(four)}")
    Tf = {nm: tile_poly(prims) for nm, (c, prims) in T.items()}
    # (the ring of omega(A_0) is read in `seams`, with the arcs of Gamma marked exactly)
    # close covering pairs of vertices, and their common unit points
    print("   close covering pairs of vertices (types' union = all six, |u - v| < 2), sector 0 representatives, and their common unit points:")
    six = {"R", "Bl", "G", "Yw", "O", "P"}
    seen = set()
    rows = []
    for k1, k2 in itertools.combinations(names, 2):
        u, v = P[k1], P[k2]
        if not (pcl[k1] | pcl[k2]) >= six: continue
        d2 = Y.n2(Y.sub(u, v))
        if not d2 < 4: continue
        # sector-0 representative up to rotation
        key = tuple(sorted([(k1[0], (k1[1] - k2[1]) % 5), (k2[0], 0)]))
        key2 = tuple(sorted([(k2[0], (k2[1] - k1[1]) % 5), (k1[0], 0)]))
        kk = min(key, key2)
        if kk in seen: continue
        seen.add(kk)
        # common unit points: exact vertices at distance 1 from both
        comm = [k for k in names if Y.n2(Y.sub(P[k], u)) == 1 and Y.n2(Y.sub(P[k], v)) == 1]
        (ux, uy), (vx, vy) = fpt(u), fpt(v)
        dd = math.dist((ux, uy), (vx, vy)); h = math.sqrt(max(0.0, 1 - dd * dd / 4))
        mx, my = (ux + vx) / 2, (uy + vy) / 2; px, py = -(vy - uy) / dd, (vx - ux) / dd
        pts = [(mx + h * px, my + h * py), (mx - h * px, my - h * py)]
        where = []
        for (x, y) in pts:
            vtx = [k for k in comm if math.dist(fpt(P[k]), (x, y)) < 1e-9]
            if vtx:
                where.append(f"{vtx[0][0]}_{vtx[0][1]} (vertex, exact)")
            elif math.hypot(x, y) > Dk.r.f():
                where.append(f"({x:.4f},{y:.4f}) OUTSIDE the disc (radius {math.hypot(x, y):.4f})")
            else:
                hit = locate(Tf, x, y)
                onarc = [f"{nm}" for nm, (c, prims) in T.items() for p in prims if isinstance(p, Y.Arc)
                         and abs(math.dist(fpt(p.C), (x, y)) - p.r.f()) < 1e-9]
                where.append(f"({x:.4f},{y:.4f}) " + (f"ON a unit arc (tiles {sorted(set(onarc))}; float)" if onarc else f"in {hit if hit else 'on Gamma'}"))
        disj = not (pcl[k1] & pcl[k2])
        rows.append((dd, k1, k2, disj, where))
    for dd, k1, k2, disj, where in sorted(rows):
        print(f"     ({k1[0]}_{k1[1]}, {k2[0]}_{k2[1]}) d = {dd:.6f} {'complementary' if disj else 'covering (overlap)'} "
              f"{sorted(pcl[k1])} | {sorted(pcl[k2])}: {where[0]}; {where[1]}")
    return Dk


def rim_stop():
    """at C_0: is any colour available at z = C_0 + eps*e(theta), just outside the disc?  exact straddle test per tile."""
    print("== where the disk cannot be continued: points just outside the rim near C_0 and near the rim midpoint of U_0, exact")
    Dk = Disk()
    T, P, F = Dk.T, Dk.P, Dk.F
    C0 = P[("C", 0)]
    eps = F(Fr(1, 100))
    res = {}
    for deg in (36, 54, 72, 90, 108, 126, 144, 162):
        z = Y.add(C0, Y.mul(eps, Dk.e(deg)))
        if not Y.n2(z) > Dk.r * Dk.r:
            res[deg] = "inside the disc"; continue
        free = sorted({c for c in {"R", "Bl", "G", "Yw", "O", "P"}
                       if not any(straddles(z, prims) for nm, (cc, prims) in T.items() if cc == c)})
        res[deg] = free
        print(f"   z = C_0 + (1/100) e({deg}): colours free at z: {free if free else 'NONE'}")
    # control: a rim point far from C: the rim midpoint of U_0 pushed out by 1/100
    mid = Y.mul(Dk.r + eps, Dk.e(126))          # beyond u_0 on the ray O B_0
    free = sorted({c for c in {"R", "Bl", "G", "Yw", "O", "P"}
                   if not any(straddles(mid, prims) for nm, (cc, prims) in T.items() if cc == c)})
    print(f"   control z = (r + 1/100) e(126) (beyond u_0): colours free: {free if free else 'NONE'}")
    return res


def seams():
    """exact: the unsaved second common unit points of the complementary pairs (B_0, Z^R_0) and (X_0, Z^L_0); the ring of omega(A_0)."""
    print("== the disk's unsaved seams, exact; and the ring of omega(A_0) (the arcs exact, the colours by float sampling off the arcs)")
    Dk = Disk()
    T, P, F = Dk.T, Dk.P, Dk.F
    g = lambda nm, k: P[(nm, k % 5)]
    r2 = Dk.r * Dk.r
    def refl(pt, a, b):
        d = Y.sub(b, a); t = Y.dot(Y.sub(pt, a), d) / Y.n2(d)
        foot = Y.add(a, Y.mul(t, d))
        return Y.sub(Y.mul(F(2), foot), pt)
    A0 = g("A", 0)
    for lab, u, v in [("(B_0, Z^R_0)", g("B", 0), g("ZR", 0)), ("(X_0, Z^L_0)", g("X", 0), g("ZL", 0))]:
        pu, pv = Y.closure_type(T, u), Y.closure_type(T, v)
        w = refl(A0, u, v)
        dist1 = Y.n2(Y.sub(w, u)) == 1 and Y.n2(Y.sub(w, v)) == 1 and Y.n2(Y.sub(A0, u)) == 1 and Y.n2(Y.sub(A0, v)) == 1
        on_rim = Y.n2(w) == r2
        out = Y.n2(w) > r2
        others = [k for k, q in P.items() if Y.n2(Y.sub(q, w)) == 1]
        say(dist1 and not (pu & pv) and (pu | pv) == {"R", "Bl", "G", "Yw", "O", "P"},
            f"{lab}: complementary {sorted(pu)} | {sorted(pv)}, |u - v|^2 = {Y.n2(Y.sub(u, v))}; common unit points A_0 (four-colour; both emit arcs of "
            f"omega(A_0)) and w = {Y.n2(w) and (round(w[0].f(), 6), round(w[1].f(), 6))}, |w|^2 = {Y.n2(w)} ({'ON the rim' if on_rim else 'OUTSIDE the disc' if out else 'inside'}); "
            f"vertices at distance exactly 1 from w: {sorted(others)}; w on the ray at 126 deg: {Y.cross(w, Dk.e(126)) == 0}")
    # C_0 is the second seam of (B_0, Z^R_0): identify
    C0 = g("C", 0)
    w = refl(A0, g("B", 0), g("ZR", 0))
    say(Y.is0(Y.sub(w, C0)), "the second common unit point of (B_0, Z^R_0) is C_0 exactly: the disc's rim passes through it")
    # the ring of omega(A_0)
    arcs = []
    for nm, (c, prims) in T.items():
        for p in prims:
            if isinstance(p, Y.Arc) and Y.is0(Y.sub(p.C, A0)) and p.r == 1:
                arcs.append((math.degrees(math.atan2(*reversed(fpt(Y.sub(p.S, A0))))) % 360,
                             math.degrees(math.atan2(*reversed(fpt(Y.sub(p.E, A0))))) % 360, nm))
    arcs = sorted({(round(a, 6), round(b, 6)) for a, b, _ in arcs})
    Tf = {nm: tile_poly(prims) for nm, (c, prims) in T.items()}
    ax, ay = fpt(A0)
    onarc = lambda t: any((t - a) % 360 <= (b - a) % 360 for a, b in arcs)
    segs = []
    for i in range(3600):
        t = i / 10 + 0.05
        if onarc(t):
            lab = "Gamma"
        else:
            h = locate(Tf, ax + math.cos(math.radians(t)), ay + math.sin(math.radians(t)))
            lab = T[h[0]][0] + ":" + h[0] if len(h) == 1 else "?"
        if not segs or segs[-1][0] != lab:
            segs.append([lab, t, t])
        else:
            segs[-1][2] = t
    print("   ring of omega(A_0), P_cl(A_0) = " + str(sorted(Y.closure_type(T, A0))) + ": " +
          "; ".join(f"{s0} [{a:.1f}, {b:.1f}]" for s0, a, b in segs))
    cols = {s0.split(":")[0] for s0, _, _ in segs if s0 != "Gamma"}
    say(cols == {"G", "P"}, f"tile-interior ring colours {sorted(cols)} = the complement of P_cl(A_0); arcs of Gamma on omega(A_0): {arcs}, "
                            f"total {sum((b - a) % 360 for a, b in arcs):.3f} deg")


def yb():
    print("== FS112-YB's checker on the disk: its field cannot hold sin 72")
    import fs112_yb_check as K
    try:
        K.F.sqrt(Fr(10) + 2 * 0)            # fine: sqrt 10
        x = K.F.sqrt(5)
        s = K.F.sqrt(10 + 2 * x)            # 10 + 2 sqrt5 is not rational
        say(False, f"unexpected: YB's field took sqrt(10 + 2 sqrt5) = {s}")
    except Exception as ex:
        say(True, f"YB's F.sqrt refuses sqrt(10 + 2 sqrt5): {type(ex).__name__}: {str(ex)[:90]} -- the disk is outside YB's field by design")


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    if "--plant" in sys.argv:
        PLANT = sys.argv[sys.argv.index("--plant") + 1]
        args = [a for a in args if a != PLANT]
    todo = args or ["solve", "check", "readoff", "rim", "seams", "yb"]
    for s in todo:
        {"solve": solve, "check": check, "readoff": readoff, "rim": rim_stop, "seams": seams, "yb": yb}[s]()
    print("ALL AS EXPECTED" if OK else "SOME MISMATCH")
    sys.exit(0 if OK else 1)
