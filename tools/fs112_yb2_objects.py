#!/usr/bin/env python3
"""FS112-YB2's objects, each given by formula and checked by tools/fs112_yb2_check.py.

1. THE STRIP ([AxenovichEtAl2014] Thm 4.2), rebuilt from its printed words (geometry) and its Figure 4 read by eye for the colour pattern only:
   midline vertices P_j = (j/2, 0); arch j over [j/2, (j+1)/2]: straight sides up to the unit circle about the opposite corner (height sqrt3/2), arcs of
   radius 1 about the opposite corner meeting at the apex (j/2 + 1/4, sqrt15/4); inverted arches mirrored; top tile over the valley (m/2, sqrt3/2) between
   the apexes, vertical sides, top at Y with |apex - opposite top corner| = 1, Y = sqrt15/4 + sqrt3/2; bottom tiles mirrored.  Colours: arches P, G, B
   (j mod 3); inverted arches M, R, O; top tiles over V_m: R, O, M (m mod 3 = 0, 1, 2); bottom tiles under V'_m: G, B, P.

2. THE DISK ([Polymath2021] Fig. 10), rebuilt from the transcription committed in plans/FS112-YB2-verification.md stage 3 (26fd1f84), with the
   pentagon words of p. 199 and [11.34]'s skeleton.  Tower: Q(sqrt5)(sqrt(10 + 2 sqrt5))(sqrt(1/phi))(sqrt r^2).
     Z: the Reuleaux pentagon of width 1 on A_0..A_4 (|A_0| = a = R5/phi, R5 = 1/(2 sin 36)); edge A_j A_{j+1} an arc of radius 1 about A_{j+3}.
     Sector 0 (then turned by 72k): B_0 = A_0 + e(144); C_0 = B_0 + e(72); D_0 = C_0 + (1, 0)  (the unit-edge regular pentagon A B C D E, E = B_4);
     X_0 = A_0 + s e(126), s = sqrt(1/phi)   (the arch P_0's straight side, parallel to its axis: the bound 126 deg met with equality; |X_0 - A_1| = 1);
     X'_0 = A_0 + s e(54) = Y_4;  U_0 = A_0 + e(108), U'_0 = A_0 + e(72)  (the bound 108 deg met with equality);  F_0 = r e(126)  (radial).
     W_0 = [A_0 X_0, X_0 U_0, arc U'_0->U_0 about A_0, U'_0 X'_0, X'_0 A_0];  P_0 = [A_0 X_0, arc X_0->B_0 about A_1, arc B_0->Y_0 about A_0, Y_0 A_1,
     arc A_0->A_1 about A_3];  R_0 = [U_0 C_0, rim D_0->C_0, D_0 U'_0, arc U'_0->U_0 about A_0];  S_0 = [arc X_0->B_0 about A_1, X_0 U_0, U_0 C_0,
     rim C_0->F_0, F_0 B_0];  T_0 = [D_0 U'_0, U'_0 X'_0, arc B_4->X'_0 about A_4, B_4 F_4, rim F_4->D_0].
     Colours: Z, R_k red; W_k c(k); P_k c(k+3); S_k c(k+4); T_k c(k+1), with c = (blue, green, yellow, orange, violet).
Run: python3 tools/fs112_yb2_objects.py strip|disk [--kplant NAME] [--plant NAME]
"""
from __future__ import annotations
import math
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs112_yb2_check as K   # noqa: E402

Seg, Arc = K.Seg, K.Arc
vadd, vsub, vmul, n2, dot, cross = K.vadd, K.vsub, K.vmul, K.n2, K.dot, K.cross


# ================================================================== the strip
class Strip:
    ARCH = ["P", "G", "B"]
    INV = ["M", "R", "O"]
    TOP = {0: "R", 1: "O", 2: "M"}
    BOT = {0: "G", 1: "B", 2: "P"}

    def __init__(self):
        T = K.Tower.base().extend(3, "3").extend(5, "5")
        self.T = T
        r3 = T.gen(1)
        r5 = T.gen(2)
        self.h = r3 / 2                     # sqrt(1 - 1/4)
        self.g = r3 * r5 / 4                # sqrt(1 - 1/16) = sqrt15/4
        self.Y = self.g + self.h            # the rule: |apex - opposite top corner| = 1  =>  (1/2)^2 + (Y - g)^2 = 1
        self.one = T(1)

    def P(self, j): return (self.T(Fr(j, 2)), self.T(0))
    def V(self, m, s): return (self.T(Fr(m, 2)), self.h * s)
    def A(self, j, s): return (self.T(Fr(j, 2) + Fr(1, 4)), self.g * s)

    def arch(self, j, s):
        P0, P1, V0, V1, Ap = self.P(j), self.P(j + 1), self.V(j, s), self.V(j + 1, s), self.A(j, s)
        o = self.one
        if s == 1:   # left arc about P1 (from V0 at 120 deg to Ap), right arc about P0 (from Ap down to V1 at 60 deg)
            return [Seg(P0, P1), Seg(P1, V1), Arc(P0, o, V1, Ap), Arc(P1, o, Ap, V0), Seg(V0, P0)]
        return [Seg(P1, P0), Seg(P0, V0), Arc(P1, o, V0, Ap), Arc(P0, o, Ap, V1), Seg(V1, P1)]

    def cap(self, m, s):
        Al, Ar, Vm = self.A(m - 1, s), self.A(m, s), self.V(m, s)
        xl, xr = self.T(Fr(m, 2) - Fr(1, 4)), self.T(Fr(m, 2) + Fr(1, 4))
        TL, TR = (xl, self.Y * s), (xr, self.Y * s)
        o = self.one
        if s == 1:
            arcs = [Arc(self.P(m - 1), o, Vm, Al), Arc(self.P(m + 1), o, Ar, Vm)]
        else:
            arcs = [Arc(self.P(m - 1), o, Al, Vm), Arc(self.P(m + 1), o, Vm, Ar)]
        return arcs + [Seg(Ar, TR), Seg(TR, TL), Seg(TL, Al)]

    def tiles(self, lo, hi):
        out = {}
        for j in range(lo, hi + 1):
            out[f"U{j}"] = (self.ARCH[j % 3], self.arch(j, 1))
            out[f"D{j}"] = (self.INV[j % 3], self.arch(j, -1))
            out[f"T{j}"] = (self.TOP[j % 3], self.cap(j, 1))
            out[f"B{j}"] = (self.BOT[j % 3], self.cap(j, -1))
        return out


def xrange_of(ps):
    xs = []
    for p in ps:
        xs += [p.ends()[0][0], p.ends()[1][0]]
        if p.kind == "A":                       # an arc's extreme x may be interior: C +- rho in direction (+-1, 0)
            for sg in (1, -1):
                if p.has_dir((p.C[0].T(sg), p.C[0].T(0))):
                    xs.append(p.C[0] + p.rho * sg)
    lo = xs[0]
    hi = xs[0]
    for x in xs[1:]:
        lo = x if x < lo else lo
        hi = x if x > hi else hi
    return lo, hi


def check_strip(W=9):
    """every same-colour pair with its first tile in columns 0..2 (one period) and its second in columns [-W, W+2], a tile with itself included,
    each unordered orbit pair once; tiles beyond the window are dismissed by an exact x-gap > 1."""
    S = Strip()
    allt = S.tiles(-W - 3, W + 5)
    reps = [f"{k}{j}" for j in range(3) for k in "UDTB"]
    seen, rows, bad = set(), [], []
    for a in reps:
        ka, ja = a[0], int(a[1:])
        for kb in "UDTB":
            for jb in range(-W, W + 3):
                b = f"{kb}{jb}"
                if allt[b][0] != allt[a][0]:
                    continue
                sh = 3 * (jb // 3)
                key = min((ka, ja, kb, jb), (kb, jb - sh, ka, ja - sh))
                if key in seen:
                    continue
                seen.add(key)
                r = K.pair_verdict(allt[a][1], allt[b][1], self_pair=(a == b))
                rows.append((a, b, allt[a][0], r))
                if r.verdict == "REJECT":
                    bad.append((a, b))
    xr = {nm: xrange_of(ps) for nm, (_, ps) in allt.items()}
    gaps = []
    for a in reps:
        for kb in "UDTB":
            for jb in (-W - 3, -W - 2, -W - 1, W + 3, W + 4, W + 5):
                b = f"{kb}{jb}"
                if allt[b][0] == allt[a][0]:
                    gaps.append(max(xr[b][0] - xr[a][1], xr[a][0] - xr[b][1]))
    g = gaps[0]
    for x in gaps[1:]:
        g = x if x < g else g
    return S, rows, bad, g


# ================================================================== the disk
class Disk:
    NONRED = ["blue", "green", "yellow", "orange", "violet"]

    def __init__(self, theta_x=None, theta_u=None, plant=None):
        T = K.Tower.base().extend(5, "5")
        r5 = T.gen()
        T = T.extend(10 + 2 * r5, "10+2*sqrt5")
        sig = T.gen()
        phi = (1 + r5) / 2
        iphi = (r5 - 1) / 2
        T = T.extend(iphi, "1/phi")
        s = T.gen()
        self.r5, self.sig, self.phi, self.s = T(r5), T(sig), T(phi), s
        sin36 = T(r5) / T(sig)
        cos36 = T(phi) / 2
        c72, s72 = (T(r5) - 1) / 4, T(sig) / 4
        self.c = {0: (T(1), T(0)), 36: (cos36, sin36), 54: (sin36, cos36), 72: (c72, s72), 90: (T(0), T(1)), 108: (-c72, s72),
                  126: (-sin36, cos36), 144: (-cos36, sin36)}
        e = self.c
        R5 = T(sig) / (2 * T(r5))
        a = R5 / T(phi)
        self.a = a
        A0 = (T(0), a)
        B0 = vadd(A0, e[144])
        C0 = vadd(B0, e[72])
        D0 = vadd(C0, (T(1), T(0)))
        r2 = n2(C0)
        T = T.extend(r2, "r^2")
        self.T = T
        rr = T.gen()
        self.r, self.r2 = rr, T(r2)
        L = lambda p: (T(p[0]), T(p[1]))
        A0, B0, C0, D0 = L(A0), L(B0), L(C0), L(D0)
        sx = s if plant != "sx" else s * Fr(99, 100)
        X0 = L(vadd(A0, vmul(sx, e[126])))
        Xp0 = L(vadd(A0, vmul(sx, e[54])))
        U0 = L(vadd(A0, e[108]))
        Up0 = L(vadd(A0, e[72]))
        F0 = L(vmul(rr, e[126]))
        self.rot1 = (T(c72), T(s72))
        base = dict(A=A0, B=B0, C=C0, D=D0, X=X0, Xp=Xp0, U=U0, Up=Up0, F=F0)
        self.P = {}
        for k in range(5):
            for nm, p in base.items():
                self.P[(nm, k)] = self.rotk(p, k)
        self.plant = plant

    def rotk(self, p, k):
        c, s = self.rot1
        for _ in range(k % 5):
            p = (c * p[0] - s * p[1], s * p[0] + c * p[1])
        return p

    def pt(self, nm, k):
        if nm == "Y":                       # Y_k = X'_{k+1}
            return self.P[("Xp", (k + 1) % 5)]
        return self.P[(nm, k % 5)]

    def col(self, j):
        return self.NONRED[j % 5]

    def tiles(self):
        T = self.T
        one = T(1)
        O = (T(0), T(0))
        p = self.pt
        t = {}
        t["Z"] = ("red", [Arc(p("A", j + 3), one, p("A", j), p("A", j + 1)) for j in range(5)])
        for k in range(5):
            A, A1, A3, A4 = p("A", k), p("A", k + 1), p("A", k + 3), p("A", k + 4)
            X, Xp, U, Up, B, C, D, F, Y = (p("X", k), p("Xp", k), p("U", k), p("Up", k), p("B", k), p("C", k), p("D", k), p("F", k),
                                           p("Y", k))
            B4, F4 = p("B", k + 4), p("F", k + 4)
            t[f"W{k}"] = (self.col(k), [Seg(A, X), Seg(X, U), Arc(A, one, Up, U), Seg(Up, Xp), Seg(Xp, A)])
            t[f"P{k}"] = (self.col(k + 3), [Seg(A, X), Arc(A1, one, X, B), Arc(A, one, B, Y), Seg(Y, A1), Arc(A3, one, A, A1)])
            t[f"R{k}"] = ("red", [Seg(U, C), Arc(O, self.r, D, C), Seg(D, Up), Arc(A, one, Up, U)])
            t[f"S{k}"] = (self.col(k + 4), [Arc(A1, one, X, B), Seg(X, U), Seg(U, C), Arc(O, self.r, C, F), Seg(F, B)])
            t[f"T{k}"] = (self.col(k + 1), [Seg(D, Up), Seg(Up, Xp), Arc(A4, one, B4, Xp), Seg(B4, F4), Arc(O, self.r, F4, D)])
        if self.plant == "swap":             # a colour swap: W_0 given S_0's colour (violet)
            t["W0"] = (self.col(4), t["W0"][1])
        return t


# ------------------------------------------------------------------ exact identities of the disk
def disk_identities(Dk):
    T = Dk.T
    p = Dk.pt
    one = T(1)
    rows = []

    def eq(label, x, y):
        rows.append((label, x == y, float(x), float(y)))

    r5 = Dk.r5
    eq("r^2 = (25 + 9 sqrt5)/10  (the instance's form)", Dk.r2, (25 + 9 * r5) / 10)
    eq("r^2 = 5/2 + 9/(2 sqrt5)  (Fig. 10's caption)", Dk.r2, Fr(5, 2) + 9 / (2 * r5))
    eq("r^2 = phi^2 (15 + sqrt5)/10  ([11.34])", Dk.r2, Dk.phi * Dk.phi * (15 + r5) / 10)
    for k in range(5):
        eq(f"|A_{k} A_{k+2}| = 1 (Z has width 1)", n2(vsub(p("A", k), p("A", k + 2))), one)
        eq(f"|A_{k} B_{k}| = 1", n2(vsub(p("A", k), p("B", k))), one)
        eq(f"|A_{k+1} B_{k}| = 1", n2(vsub(p("A", k + 1), p("B", k))), one)
        eq(f"|B_{k} C_{k}| = 1", n2(vsub(p("B", k), p("C", k))), one)
        eq(f"|C_{k} D_{k}| = 1", n2(vsub(p("C", k), p("D", k))), one)
        eq(f"|D_{k} B_{k-1}| = 1 (DE)", n2(vsub(p("D", k), p("B", k - 1))), one)
        eq(f"|A_{k} C_{k}| = phi (diagonal)", n2(vsub(p("A", k), p("C", k))), Dk.phi * Dk.phi)
        eq(f"|X_{k} A_{k+1}| = 1", n2(vsub(p("X", k), p("A", k + 1))), one)
        eq(f"|Y_{k} A_{k}| = 1", n2(vsub(p("Y", k), p("A", k))), one)
        eq(f"|U_{k} A_{k}| = 1", n2(vsub(p("U", k), p("A", k))), one)
        eq(f"|U'_{k} A_{k}| = 1", n2(vsub(p("Up", k), p("A", k))), one)
        eq(f"|C_{k}|^2 = r^2", n2(p("C", k)), Dk.r2)
        eq(f"|D_{k}|^2 = r^2", n2(p("D", k)), Dk.r2)
        eq(f"|F_{k}|^2 = r^2", n2(p("F", k)), Dk.r2)
        eq(f"X_{k} - A_{k} parallel to B_{k}'s ray (126 deg)", cross(vsub(p("X", k), p("A", k)), p("B", k)), T(0))
    return rows


def piece_key(p):
    f = lambda q: (round(float(q[0]), 9), round(float(q[1]), 9))
    if p.kind == "S":
        return ("S",) + tuple(sorted([f(p.P), f(p.Q)]))
    return ("A", f(p.C), round(float(p.rho), 9)) + tuple(sorted([f(p.S), f(p.E)]))


def consistency(tiles, rim_rho=None):
    """exact: every piece of a tile is shared (as a point set) by exactly one other tile, or is a rim arc; float keys only index candidates."""
    occ = {}
    for nm, (_, ps) in tiles.items():
        for p in ps:
            occ.setdefault(piece_key(p), []).append((nm, p))
    bad = []
    for key, lst in occ.items():
        if len(lst) == 2:
            (n1, p1), (n2_, p2) = lst
            same = (p1.kind == p2.kind and set(map(lambda q: (float(q[0]), float(q[1])), p1.ends())) and
                    all(any(K.veq(x, y) for y in p2.ends()) for x in p1.ends()))
            if p1.kind == "A":
                same = same and K.veq(p1.C, p2.C) and p1.rho == p2.rho
            if not same:
                bad.append(("mismatch", key))
        elif len(lst) == 1:
            p = lst[0][1]
            if not (p.kind == "A" and rim_rho is not None and K.is0v(p.C) and p.rho == rim_rho):
                bad.append(("unshared, not rim", lst[0][0], key))
        else:
            bad.append(("shared by more than two", key, [n for n, _ in lst]))
    return bad, len(occ)


def float_area(ps, n=400):
    """float area of a tile by Green's theorem over its pieces, oriented as a closed chain (a guard, never a verdict)."""
    # order the pieces into a chain
    segs = []
    for p in ps:
        if p.kind == "S":
            pts = [(float(p.P[0]), float(p.P[1])), (float(p.Q[0]), float(p.Q[1]))]
        else:
            cx, cy, r = float(p.C[0]), float(p.C[1]), float(p.rho)
            a0 = math.atan2(float(p.S[1]) - cy, float(p.S[0]) - cx)
            a1 = math.atan2(float(p.E[1]) - cy, float(p.E[0]) - cx)
            sp = (a1 - a0) % (2 * math.pi)
            pts = [(cx + r * math.cos(a0 + sp * i / n), cy + r * math.sin(a0 + sp * i / n)) for i in range(n + 1)]
        segs.append(pts)
    chain = segs[0][:]
    rest = segs[1:]
    while rest:
        end = chain[-1]
        for i, s in enumerate(rest):
            if math.dist(s[0], end) < 1e-9:
                chain += s[1:]
                rest.pop(i)
                break
            if math.dist(s[-1], end) < 1e-9:
                chain += s[::-1][1:]
                rest.pop(i)
                break
        else:
            raise ValueError("pieces do not form a chain")
    assert math.dist(chain[0], chain[-1]) < 1e-9, "chain not closed"
    return abs(sum(x0 * y1 - x1 * y0 for (x0, y0), (x1, y1) in zip(chain, chain[1:]))) / 2


def run_disk(plant=None):
    Dk = Disk(plant=plant)
    print(f"tower: {Dk.T}")
    ok = True
    ids = disk_identities(Dk)
    nbad = sum(1 for r in ids if not r[1])
    print(f"exact identities: {len(ids) - nbad} of {len(ids)} hold")
    for lab, good, x, y in ids:
        if not good or lab.startswith("r^2"):
            print(f"   {'ok ' if good else 'FAIL'} {lab}   ({x:.9f} vs {y:.9f})")
    ok &= nbad == 0 or plant is not None
    tiles = Dk.tiles()
    bad, npieces = consistency(tiles, rim_rho=Dk.r)
    print(f"map consistency (exact): {npieces} distinct pieces; defects {bad if bad else 'none'}")
    areas = {nm: float_area(ps) for nm, (_, ps) in tiles.items()}
    tot = sum(areas.values())
    print(f"float area guard: sum of the 26 tile areas {tot:.9f}; pi r^2 {math.pi * float(Dk.r2):.9f}")
    rows, badp, npres = K.check_object(tiles)
    print(f"pairs examined {len(rows)} / present {npres}")
    for a, b, c, r in rows:
        tight = " TIGHT" if (r.mcmp == "=" or (a == b and r.Mcmp == "=")) else ""
        print(f"   {c:7s} {a:3s} {b:3s} {r}{tight}")
    print("VERDICT:", "REJECT " + str(badp) if badp else "ACCEPT")
    return Dk, rows, badp


if __name__ == "__main__":
    args = sys.argv[1:]
    if "--kplant" in args:
        K.PLANT = args[args.index("--kplant") + 1]
    plant = args[args.index("--plant") + 1] if "--plant" in args else None
    if "strip" in args:
        S, rows, bad, g = check_strip()
        print(f"strip: height 2Y = sqrt15/2 + sqrt3 exactly: {2 * S.Y == S.T.gen(1) * S.T.gen(2) / 2 + S.T.gen(1)}")
        tight = sum(1 for a, b, c, r in rows if r.mcmp == "=" or (a == b and r.Mcmp == "="))
        print(f"strip: orbit pairs examined {len(rows)}; REJECT {bad if bad else 'none'}; exact contacts at 1: {tight}; x-gap beyond the window "
              f"{float(g):.3f} (exact > 1: {g > 1})")
        print("VERDICT:", "REJECT" if bad else "ACCEPT")
    if "disk" in args:
        run_disk(plant)
