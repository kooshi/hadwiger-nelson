#!/usr/bin/env python3
"""FS114-YB's objects, each rebuilt from its rule in words and checked by tools/fs114_yb_exact.py.

THE STRIP ([AxenovichEtAl2014] Thm 4.2, as FS-112 rebuilt it: FS112-CAL-STRIP; YB's labels, plans/FS112-YB-verification.md stage 3).  Midline
y = 0, P_j = (j/2, 0).  Arch U_j over [j/2, (j+1)/2]: straight sides from P_j, P_{j+1} up to the unit circle about the opposite corner (V_j,
V_{j+1} at height sqrt3/2), arcs of radius 1 about the opposite corner meeting at the apex A_j = (j/2 + 1/4, sqrt15/4).  Top tile T_m over the
valley V_m = (m/2, sqrt3/2): below, the arcs through V_m (of the unit circles about P_{m-1} and P_{m+1}) from A_{m-1} to A_m; vertical sides up to
Q_{m-1} = (m/2 - 1/4, Y) and Q_m = (m/2 + 1/4, Y), Y = sqrt3/2 + sqrt15/4 (the rule |A_{m-1} - Q_m| = 1); top straight.  Inverted arch D_j and
bottom tile B_m: the mirror images in y = 0.  Colours: U_j P, G, B (j mod 3); D_j M, R, O; T_m R, O, M (m mod 3 = 0, 1, 2); B_m G, B, P.
THE CAPPED STRIP (the instance's object 1): each top tile's top segment replaced by the unit arc about its own valley V_m from Q_m to Q_{m-1}
(both at distance 1 from V_m); the bottom tiles by the mirror image.

THE DISK ([Polymath2021] Fig. 10, FS112-CAL-DISK), in Y2's labels (plans/FS112-Y-construction.md §4.1-4.4).  A_k = a e(90 + 72k), a = 1/(2 sin 72);
the unit regular pentagon A_k B_k C_k D_k E_k with B_k = A_k + e(144 + 72k), C_k = B_k + e(72 + 72k), D_k = C_k + e(72k) ("connected":
B_k = E_{k+1}, checked); Z^L_k, Z^R_k on the diagonals A_kC_k, A_kD_k at distance 1 from A_k; Y_k = A_k + L n_k, X_k = A_{k+1} + L n_k, n_k = e(126 + 72k),
L^2 = 1/phi (the parallel legs of T1_k, ending on the unit circles about A_{k+1} and A_k); u_k = r e(126 + 72k) on the rim (radial); rim radius r,
r^2 = (25 + 9 sqrt5)/10.  Tiles: C0 (Reuleaux pentagon, side A_kA_{k+1} a unit arc about A_{k+3}); T1_k = A_k, Y_k, B_k, X_k, A_{k+1}; T2_k = A_k,
X_{k-1}, Z^R_k, Z^L_k, Y_k (top a unit arc about A_k); R_k = D_k, C_k, Z^L_k, Z^R_k; U_k = C_k, u_k, B_k, Y_k, Z^L_k; U'_k = u_k, D_{k+1}, Z^R_{k+1}, X_k,
B_k.  Colours, c = (blue, green, yellow, orange, purple) by k mod 5: T2_k = c(k), T1_k = c(k+3), U_k = c(k-1), U'_k = c(k+2); C0, R_k red.
THE MOVED DISK (FS112-MOVE): R_k's straight sides Z^R_kD_k and C_kZ^L_k replaced by the unit arcs of the circles about C_k and D_k through the same
ends; the lenses go to R_k (U'_{k-1} and U_k lose them).

Tower of the disk: Q(sqrt5)(s)(L)(r), s = sqrt(10 + 2 sqrt5) = 4 sin 72.
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X   # noqa: E402

Seg, Arc, Tile = X.Seg, X.Arc, X.Tile
vadd, vsub, vmul, n2, dot, cross = X.vadd, X.vsub, X.vmul, X.n2, X.dot, X.cross


# =================================================================================== the strip
class Strip:
    UC = ["P", "G", "B"]
    DC = ["M", "R", "O"]
    TC = ["R", "O", "M"]
    BC = ["G", "B", "P"]

    def __init__(self, capped=False, plant=None):
        T = X.Tower.base()
        T = T.extend(3, "3")
        T = T.extend(5, "5")
        self.T = T
        r3, r5 = T.gen(1), T.gen(2)
        self.h = r3 / 2                 # sqrt3/2
        self.g = r3 * r5 / 4            # sqrt15/4
        self.Y = self.h + self.g
        self.one = T(1)
        self.capped, self.plant = capped, plant

    def q(self, x):
        return self.T(Fr(x))

    def P(self, j):
        return (self.q(Fr(j, 2)), self.q(0))

    def V(self, m, s=1):
        return (self.q(Fr(m, 2)), self.h * s)

    def A(self, j, s=1):
        return (self.q(Fr(j, 2) + Fr(1, 4)), self.g * s)

    def Q(self, m, s=1):
        return (self.q(Fr(m, 2) + Fr(1, 4)), self.Y * s)

    def arch(self, j):
        P0, P1, V0, V1, Ap = self.P(j), self.P(j + 1), self.V(j), self.V(j + 1), self.A(j)
        o = self.one
        return [Seg(P0, P1), Seg(P1, V1), Arc(P0, o, V1, Ap, True), Arc(P1, o, Ap, V0, True), Seg(V0, P0)]

    def top(self, m):
        Vm, Al, Ar, Ql, Qr = self.V(m), self.A(m - 1), self.A(m), self.Q(m - 1), self.Q(m)
        o = self.one
        ps = [Arc(self.P(m + 1), o, Vm, Ar, False), Seg(Ar, Qr)]
        if self.capped:
            if self.plant == "cap_bulge":      # plant: an arc of radius 5/12 through the same two corners, centre (m/2, Y - 1/3)
                ps.append(Arc((self.q(Fr(m, 2)), self.Y - Fr(1, 3)), self.q(Fr(5, 12)), Qr, Ql, True))
            else:
                ps.append(Arc(Vm, o, Qr, Ql, True))
        else:
            ps.append(Seg(Qr, Ql))
        ps += [Seg(Ql, Al), Arc(self.P(m - 1), o, Al, Vm, False)]
        return ps

    @staticmethod
    def mirror(ps):
        """the mirror image y -> -y of a counter-clockwise chain, returned counter-clockwise."""
        def m(p):
            return (p[0], -p[1])
        out = []
        for pc in reversed(ps):
            if pc.kind == "S":
                out.append(Seg(m(pc.Q), m(pc.P)))
            else:
                out.append(Arc(m(pc.C), pc.rho, m(pc.Q), m(pc.P), pc.ccw))
        return out

    def tiles(self, lo, hi):
        out = []
        for j in range(lo, hi + 1):
            out.append(Tile(f"U{j}", self.UC[j % 3], self.arch(j)))
            out.append(Tile(f"D{j}", self.DC[j % 3], self.mirror(self.arch(j))))
            out.append(Tile(f"T{j}", self.TC[j % 3], self.top(j)))
            out.append(Tile(f"B{j}", self.BC[j % 3], self.mirror(self.top(j))))
        if self.plant == "swap_U0_U1":
            for t in out:
                if t.name in ("U0",):
                    t.colour = "G"
        return out


# =================================================================================== the disk (Y2's labels)
class Disk:
    CS = ["blue", "green", "yellow", "orange", "purple"]

    def __init__(self, moved=False, plant=None):
        T = X.Tower.base()
        T = T.extend(5, "5")
        r5 = T.gen(1)
        T = T.extend(10 + 2 * r5, "s")
        r5 = T(r5)
        s = T.gen(2)
        T = T.extend((r5 - 1) / 2, "L")
        L = T.gen(3)
        T = T.extend((25 + 9 * T(r5)) / 10, "r")
        self.T, self.r5, self.s, self.L, self.r = T, T(r5), T(s), T(L), T.gen(4)
        self.phi = (1 + self.r5) / 2
        self.moved, self.plant = moved, plant
        self.pts = {}
        self._build_points()

    def cs(self, deg):
        """(cos, sin) of an integer multiple of 18 degrees, exact."""
        deg %= 360
        assert deg % 18 == 0
        T, r5, s = self.T, self.r5, self.s
        base = {0: (T(1), T(0)), 18: (s / 4, (r5 - 1) / 4), 36: ((1 + r5) / 4, r5 / s), 54: (r5 / s, (1 + r5) / 4),
                72: ((r5 - 1) / 4, s / 4), 90: (T(0), T(1))}
        q, rdeg = divmod(deg, 90)
        c, si = base[rdeg] if rdeg in base else None
        for _ in range(q):
            c, si = -si, c
        return (c, si)

    def e(self, deg):
        return self.cs(deg)

    def _build_points(self):
        a = 2 / self.s        # 1/(2 sin 72)
        P = self.pts
        for k in range(5):
            A = vmul(a, self.e(90 + 72 * k))
            P[("A", k)] = A
        for k in range(5):
            A = P[("A", k)]
            B = vadd(A, self.e(144 + 72 * k))
            C = vadd(B, self.e(72 + 72 * k))
            D = vadd(C, self.e(72 * k))
            E = vadd(A, self.e(36 + 72 * k))
            P[("B", k)], P[("C", k)], P[("D", k)], P[("E", k)] = B, C, D, E
            P[("ZL", k)] = vadd(A, vmul(1 / self.phi, vsub(C, A)))
            P[("ZR", k)] = vadd(A, vmul(1 / self.phi, vsub(D, A)))
            n = self.e(126 + 72 * k)
            P[("Y", k)] = vadd(A, vmul(self.L, n))
            P[("u", k)] = vmul(self.r, n)
        for k in range(5):
            n = self.e(126 + 72 * k)
            P[("X", k)] = vadd(P[("A", (k + 1) % 5)], vmul(self.L, n))

    def p(self, nm, k):
        return self.pts[(nm, k % 5)]

    def col(self, j):
        return self.CS[j % 5]

    def tiles(self):
        p, o, T = self.p, self.T(1), self.T
        O = (T(0), T(0))
        out = []
        c0 = []
        for k in range(5):
            c0.append(Arc(p("A", k + 3), o, p("A", k), p("A", k + 1), True))
        out.append(Tile("C0", "red", c0))
        for k in range(5):
            A, A1, Y, B, Xk = p("A", k), p("A", k + 1), p("Y", k), p("B", k), p("X", k)
            if self.plant == "chords":
                central = Seg(A1, A)
            else:
                central = Arc(p("A", k + 3), o, A1, A, False)
            out.append(Tile(f"T1_{k}", self.col(k + 3), [Seg(A, Y), Arc(A1, o, Y, B, True), Arc(A, o, B, Xk, True), Seg(Xk, A1), central]))
        for k in range(5):
            A, Xm, ZR, ZL, Y = p("A", k), p("X", k - 1), p("ZR", k), p("ZL", k), p("Y", k)
            out.append(Tile(f"T2_{k}", self.col(k), [Seg(A, Xm), Seg(Xm, ZR), Arc(A, o, ZR, ZL, True), Seg(ZL, Y), Seg(Y, A)]))
        for k in range(5):
            D, C, ZL, ZR = p("D", k), p("C", k), p("ZL", k), p("ZR", k)
            rim = Arc(O, self.r, D, C, True)
            if self.moved:
                s1 = Arc(D, o, C, ZL, True)          # the unit arc of the circle about D_k from C_k to Z^L_k, bulging out of R_k
                s2 = Arc(C, o, ZR, D, True)          # the unit arc of the circle about C_k from Z^R_k to D_k
            else:
                s1, s2 = Seg(C, ZL), Seg(ZR, D)
            out.append(Tile(f"R_{k}", "red", [rim, s1, Arc(p("A", k), o, ZL, ZR, False), s2]))
        for k in range(5):
            C, u, B, Y, ZL = p("C", k), p("u", k), p("B", k), p("Y", k), p("ZL", k)
            last = Arc(p("D", k), o, ZL, C, False) if self.moved else Seg(ZL, C)
            out.append(Tile(f"U_{k}", self.col(k - 1), [Arc(O, self.r, C, u, True), Seg(u, B), Arc(p("A", k + 1), o, B, Y, False),
                                                       Seg(Y, ZL), last]))
        for k in range(5):
            u, D1, ZR1, Xk, B = p("u", k), p("D", k + 1), p("ZR", k + 1), p("X", k), p("B", k)
            first = Arc(p("C", k + 1), o, D1, ZR1, False) if self.moved else Seg(D1, ZR1)
            out.append(Tile(f"U'_{k}", self.col(k + 2), [Arc(O, self.r, u, D1, True), first, Seg(ZR1, Xk),
                                                        Arc(p("A", k), o, Xk, B, False), Seg(B, u)]))
        if self.plant == "swap":
            for t in out:
                if t.name == "U_0":
                    t.colour = self.col(2)        # U_0 purple -> yellow
                elif t.name == "U'_0":
                    t.colour = self.col(4)        # U'_0 yellow -> purple
        return out


def disk_identities(Dk):
    """the rule's identities, exact; returns a list of (label, ok)."""
    p, one = Dk.p, Dk.T(1)
    out = []

    def eq(lbl, x, y):
        out.append((lbl, (x - y).is0()))
    O = (Dk.T(0), Dk.T(0))
    for k in range(5):
        eq(f"|A{k}A{k + 2}|^2 = 1", n2(vsub(p("A", k), p("A", k + 2))), one)
        eq(f"|A{k}B{k}|^2 = 1", n2(vsub(p("A", k), p("B", k))), one)
        eq(f"|A{k + 1}B{k}|^2 = 1", n2(vsub(p("A", k + 1), p("B", k))), one)
        eq(f"B{k} = E{k + 1} (x)", p("B", k)[0], p("E", k + 1)[0])
        eq(f"B{k} = E{k + 1} (y)", p("B", k)[1], p("E", k + 1)[1])
        eq(f"|A{k}C{k}|^2 = phi^2", n2(vsub(p("C", k), p("A", k))), Dk.phi * Dk.phi)
        eq(f"|A{k}ZL{k}|^2 = 1", n2(vsub(p("ZL", k), p("A", k))), one)
        eq(f"|A{k}ZR{k}|^2 = 1", n2(vsub(p("ZR", k), p("A", k))), one)
        eq(f"|ZL{k}D{k}|^2 = 1", n2(vsub(p("ZL", k), p("D", k))), one)
        eq(f"|ZR{k}C{k}|^2 = 1", n2(vsub(p("ZR", k), p("C", k))), one)
        eq(f"|Y{k}A{k + 1}|^2 = 1", n2(vsub(p("Y", k), p("A", k + 1))), one)
        eq(f"|X{k}A{k}|^2 = 1", n2(vsub(p("X", k), p("A", k))), one)
        eq(f"|C{k}|^2 = r^2", n2(p("C", k)), Dk.r * Dk.r)
        eq(f"|D{k}|^2 = r^2", n2(p("D", k)), Dk.r * Dk.r)
        eq(f"B{k} on the ray of u{k}", cross(p("B", k), p("u", k)), Dk.T(0))
        eq(f"A{k} + A{k + 1} - B{k} = A{k + 3} (x)", p("A", k)[0] + p("A", k + 1)[0] - p("B", k)[0], p("A", k + 3)[0])
        eq(f"A{k} + A{k + 1} - B{k} = A{k + 3} (y)", p("A", k)[1] + p("A", k + 1)[1] - p("B", k)[1], p("A", k + 3)[1])
    eq("r^2 = (25 + 9 sqrt5)/10", Dk.r * Dk.r, (25 + 9 * Dk.r5) / 10)
    eq("r^2 = phi^2 (15 + sqrt5)/10 ([11.34])", Dk.r * Dk.r, Dk.phi * Dk.phi * (15 + Dk.r5) / 10)
    _ = O
    return out


# =================================================================================== calibration objects
def brick(i_range=range(-5, 6), j_range=range(-5, 6), w=Fr(4, 5), h=Fr(3, 5), s=Fr(2, 5), c=3):
    """Row 33's brick: cell (i, j) = [i w + j s, (i+1) w + j s] x [j h, (j+1) h], colour (i + c j) mod 7 (Seven.lean)."""
    T = X.Tower.base()
    out = []
    for i in i_range:
        for j in j_range:
            x0, y0 = i * w + j * s, j * h
            ps = [(T(x0), T(y0)), (T(x0 + w), T(y0)), (T(x0 + w), T(y0 + h)), (T(x0), T(y0 + h))]
            out.append(Tile(f"b{i},{j}", (i + c * j) % 7, poly(ps)))
    return out


def poly(ps):
    return [Seg(ps[i], ps[(i + 1) % len(ps)]) for i in range(len(ps))]


def hex7(rng=range(-4, 5), side=Fr(1, 2)):
    """flat-top regular hexagons of side `side`; centre q a1 + r a2, a1 = (3 side/2, sqrt3 side/2), a2 = (0, sqrt3 side); colour (q + 3r) mod 7."""
    T = X.Tower.base().extend(3, "3")
    r3 = T.gen(1)
    rho = T(side)
    a1 = (rho * Fr(3, 2), r3 * rho / 2)
    a2 = (T(0), r3 * rho)
    vs = [(rho, T(0)), (rho / 2, r3 * rho / 2), (-rho / 2, r3 * rho / 2), (-rho, T(0)), (-rho / 2, -r3 * rho / 2), (rho / 2, -r3 * rho / 2)]
    out = []
    for q in rng:
        for r in rng:
            c = vadd(vmul(T(q), a1), vmul(T(r), a2))
            out.append(Tile(f"h{q},{r}", (q + 3 * r) % 7, poly([vadd(c, v) for v in vs])))
    return out


def bowtie_held(plant=None):
    """FS112-BOWTIE, built by FS112-YB3's own builder (tools/fs112_yb3_frags.py, imported and run, never edited) and converted exactly into
    this checker's pieces (the fragment lives in Q: every FS112-YB2 element there is a Fraction at tower level 0).  FS112-YB2's Arc(C, rho, S, E)
    is counter-clockwise from S to E; the traversal direction of each arc is read from the chain, and a chain found clockwise is reversed."""
    import fs112_yb3_frags as B3
    t = B3.bowtie(plant=plant)
    T = X.Tower.base()

    def cq(x):
        assert x.T.n == 0 and not isinstance(x.v, tuple), "BOWTIE is expected over Q"
        return T(Fr(x.v))

    def cp(q):
        return (cq(q[0]), cq(q[1]))
    out = []
    for nm, (col, ps) in t.items():
        raw = []
        for pc in ps:
            if pc.kind == "S":
                raw.append(("S", cp(pc.P), cp(pc.Q)))
            else:
                raw.append(("A", cp(pc.C), cq(pc.rho), cp(pc.S), cp(pc.E)))
        n = len(raw)

        def ends(r, fwd):
            a, b = (r[1], r[2]) if r[0] == "S" else (r[3], r[4])
            return (a, b) if fwd else (b, a)
        best = None
        for f0 in (True, False):
            dirs = [f0]
            ok = True
            for i in range(1, n):
                prev_end = ends(raw[i - 1], dirs[-1])[1]
                if X.veq(ends(raw[i], True)[0], prev_end):
                    dirs.append(True)
                elif X.veq(ends(raw[i], False)[0], prev_end):
                    dirs.append(False)
                else:
                    ok = False
                    break
            if ok and X.veq(ends(raw[-1], dirs[-1])[1], ends(raw[0], dirs[0])[0]):
                best = dirs
                break
        assert best is not None, f"BOWTIE tile {nm}: not a closed chain"
        pieces = []
        for r, fwd in zip(raw, best):
            a, b = ends(r, fwd)
            if r[0] == "S":
                pieces.append(Seg(a, b))
            else:
                pieces.append(Arc(r[1], r[2], a, b, fwd))
        tile = Tile(nm, col, pieces)
        if tile.area_float() < 0:
            tile = Tile(nm, col, [X.reverse(pc) for pc in reversed(pieces)])
        out.append(tile)
    return out
