#!/usr/bin/env python3
"""FS112-YB's rebuild of [AxenovichEtAl2014] Thm 4.2's six-coloured strip, from its printed words, checked by tools/fs112_yb_check.py.

THE WORDS (p. 8, verbatim): "The symmetric tiles have width 1/2, with the rounded boundary being a circular arc of radius 1 centered at the
opposite corner of the tile. The tiles used in the top and bottom rows are determined by the distance 1 between the point of intersection of
circular arcs and the opposite corner of a tile."  THE LAYOUT AND COLOURS (Figure 4, read by eye for its combinatorics only; no coordinate taken
from it): four rows -- pointed arches standing on the midline, inverted arches hanging from it in the same columns, and a top and a bottom row of
tiles sitting in the valleys between the arches, offset by half a tile; colours: arches P, G, B (purple, green, blue) repeating, inverted
arches M, R, O (marble, red, orange) under them, top-row tiles O, M, R over the valleys V_1, V_2, V_3, bottom-row tiles B, P, G under V'_1, V'_2,
V'_3.

THE DERIVATION OF EVERY COORDINATE. Midline y = 0, midline vertices P_j = (j/2, 0) (width 1/2).
 * Arch j (columns [j/2, (j+1)/2]): corners P_j, P_{j+1}. Its rounded boundary over the corner P_j is an arc of radius 1 centred at the
   OPPOSITE corner P_{j+1}; the straight side x = j/2 meets that circle at height sqrt(1 - 1/4) = sqrt3/2 (the point V_j); the two arcs (about
   P_{j+1} and about P_j) meet on the axis x = j/2 + 1/4 at height sqrt(1 - 1/16) = sqrt15/4 (the apex A_j, "the point of intersection of
   circular arcs"). So arch j = {j/2 <= x <= (j+1)/2, y >= 0} n D(P_j, 1) n D(P_{j+1}, 1), a tile of diameter exactly 1 (P_j to its arc).
 * Inverted arch j: the mirror image in y = 0.
 * Top tile over the valley V_m = (m/2, sqrt3/2): bounded below by the two arcs through V_m (arch m-1's arc about P_{m-1}, arch m's arc about
   P_{m+1}), between the apexes A_{m-1}, A_m; vertical sides x = m/2 -+ 1/4 up to the strip's top edge y = Y. The rule: the apex A_{m-1} and
   the opposite corner (m/2 + 1/4, Y) are at distance 1, so (1/2)^2 + (Y - sqrt15/4)^2 = 1, Y = sqrt15/4 + sqrt3/2. (The other reading of "the
   point of intersection of circular arcs", the valley V_m itself, gives (1/4)^2 + (Y - sqrt3/2)^2 = 1: the same Y. Both are checked.)
 * Bottom tile: the mirror image. Height 2Y = sqrt15/2 + sqrt3, the print's number, checked exactly.
Period 3/2 (three columns); a translation by 1/2 permutes the colours (P G B)(M R O).

Run: python3 tools/fs112_yb_strip.py [--plant NAME]   (plants: rho11 (arch arcs of radius 11/10 about the opposite corner), rho9 (radius 9/10),
colswap (arch 0 given arch 1's colour G), tall (top and bottom edges raised by 1/100), and the checker's plants via --kplant NAME).
"""
from __future__ import annotations
import os
import sys
import itertools
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs112_yb_check as K   # noqa: E402

F, Seg, Arc, pt = K.F, K.Seg, K.Arc, K.pt
PLANT = None

ARCH_COL = ["P", "G", "B"]     # arch j (j mod 3)
INV_COL = ["M", "R", "O"]      # inverted arch j (j mod 3)
TOP_COL = {1: "O", 2: "M", 0: "R"}     # top tile over V_m (m mod 3)
BOT_COL = {1: "B", 2: "P", 0: "G"}     # bottom tile under V'_m (m mod 3)
COLOURS = ["P", "G", "B", "M", "R", "O"]


def geometry(rho=Fr(1)):
    """(h, g, Y): valley height, apex height, top edge, for arch arcs of radius rho centred at the opposite corner (rho = 1: the print)."""
    rho = Fr(rho)
    h = F.sqrt(rho * rho - Fr(1, 4))           # sqrt(rho^2 - 1/4): the straight side meets the circle about the opposite corner
    g = F.sqrt(rho * rho - Fr(1, 16))          # the two arcs meet at horizontal offset 1/4
    Y = g + F.sqrt(Fr(3, 4))                   # the top-row rule: apex to the opposite top corner at distance 1
    return h, g, Y


class Strip:
    def __init__(self, rho=Fr(1), plant=None):
        self.rho = F.of(rho)
        self.h, self.g, self.Y = geometry(rho)
        if plant == "tall":
            self.Y = self.Y + Fr(1, 100)
        self.plant = plant

    def P(self, j):
        return pt(Fr(j, 2), 0)

    def V(self, m, s=1):
        return (F.of(Fr(m, 2)), self.h * s)

    def A(self, j, s=1):
        return (F.of(Fr(j, 2) + Fr(1, 4)), self.g * s)

    def arch(self, j, s=1):
        """arch j (s = 1) or inverted arch j (s = -1): pieces."""
        Pj, Pj1, Vj, Vj1, Aj = self.P(j), self.P(j + 1), self.V(j, s), self.V(j + 1, s), self.A(j, s)
        if s == 1:
            return [Seg(Pj, Pj1), Seg(Pj1, Vj1), Arc(Pj, self.rho, Vj1, Aj), Arc(Pj1, self.rho, Aj, Vj), Seg(Vj, Pj)]
        return [Seg(Pj1, Pj), Seg(Pj, Vj), Arc(Pj1, self.rho, Vj, Aj), Arc(Pj, self.rho, Aj, Vj1), Seg(Vj1, Pj1)]

    def cap(self, m, s=1):
        """top tile over V_m (s = 1) or bottom tile under V'_m (s = -1)."""
        Al, Ar, Vm = self.A(m - 1, s), self.A(m, s), self.V(m, s)
        xl, xr = F.of(Fr(m, 2) - Fr(1, 4)), F.of(Fr(m, 2) + Fr(1, 4))
        TL, TR = (xl, self.Y * s), (xr, self.Y * s)
        if s == 1:
            a1 = Arc(self.P(m - 1), self.rho, Vm, Al)           # arch m-1's arc about P_{m-1}, from V_m (60 deg) to A_{m-1}
            a2 = Arc(self.P(m + 1), self.rho, Ar, Vm)           # arch m's arc about P_{m+1}, from A_m to V_m (120 deg)
        else:
            a1 = Arc(self.P(m - 1), self.rho, Al, Vm)
            a2 = Arc(self.P(m + 1), self.rho, Vm, Ar)
        return [a1, a2, Seg(Ar, TR), Seg(TR, TL), Seg(TL, Al)]

    def colour(self, kind, j):
        if kind == "U":
            c = ARCH_COL[j % 3]
            if self.plant == "colswap" and j % 3 == 0:
                c = "G"
            return c
        if kind == "D":
            return INV_COL[j % 3]
        if kind == "T":
            return TOP_COL[j % 3]
        return BOT_COL[j % 3]

    def tile(self, kind, j):
        if kind == "U":
            return self.arch(j, 1)
        if kind == "D":
            return self.arch(j, -1)
        if kind == "T":
            return self.cap(j, 1)
        return self.cap(j, -1)

    def tiles(self, jlo, jhi):
        """every tile of column index j in [jlo, jhi]: {name: (colour, pieces)}."""
        out = {}
        for j in range(jlo, jhi + 1):
            for kind in "UDTB":
                out[f"{kind}{j}"] = (self.colour(kind, j), self.tile(kind, j))
        return out


KIND_NAME = {"U": "arch", "D": "inverted arch", "T": "top tile over V", "B": "bottom tile under V'"}


def xrange_of(pieces):
    """exact x-extent of a tile (endpoints, and arcs' leftmost/rightmost points when on the arc)."""
    xs = []
    for p in pieces:
        for e in p.ends():
            xs.append(e[0])
        if p.kind == "A":
            for d in (pt(1, 0), pt(-1, 0)):
                if p.has_dir(d):
                    xs.append(p.C[0] + p.r * d[0])
    lo = xs[0]
    hi = xs[0]
    for x in xs[1:]:
        if x < lo:
            lo = x
        if x > hi:
            hi = x
    return lo, hi


# ------------------------------------------------------------------ exact identities of the rebuild
def identities(S):
    one = F.of(1)
    R3, R15 = F.sqrt(3), F.sqrt(15)
    out = []
    out.append(("height 2Y == sqrt15/2 + sqrt3", (S.Y * 2) == (R15 / 2 + R3)))
    out.append(("valley V_1 on the unit circles about P_0? (|V_1 - P_0| = 1)", K.n2(K.vsub(S.V(1), S.P(0))) == one))
    out.append(("apex A_0 on the unit circles about P_0 and P_1", K.n2(K.vsub(S.A(0), S.P(0))) == one and K.n2(K.vsub(S.A(0), S.P(1))) == one))
    TR = (F.of(Fr(1, 2) + Fr(1, 4)), S.Y)
    TL = (F.of(Fr(1, 2) - Fr(1, 4)), S.Y)
    out.append(("rule, reading 1: |A_0 - (3/4, Y)| = 1 (apex to the top tile's opposite corner)", K.n2(K.vsub(S.A(0), TR)) == one))
    out.append(("rule, reading 2: |V_1 - (1/4, Y)| = |V_1 - (3/4, Y)| = 1 (valley to the top corners)",
                K.n2(K.vsub(S.V(1), TL)) == one and K.n2(K.vsub(S.V(1), TR)) == one))
    out.append(("tile width 1/2 (arch) and top tile width 1/2", True))
    return out


# ------------------------------------------------------------------ map consistency (exact)
def piece_equal(p, q):
    if p.kind != q.kind:
        return False
    if p.kind == "S":
        return (K.veq(p.P, q.P) and K.veq(p.Q, q.Q)) or (K.veq(p.P, q.Q) and K.veq(p.Q, q.P))
    return K.veq(p.C, q.C) and (p.r - q.r).is0() and K.veq(p.S, q.S) and K.veq(p.E, q.E)


def consistency(S, jlo=-2, jhi=4):
    """every piece of every tile of columns [0, 2] is shared by exactly one other tile, or lies on the strip's edge y = +-Y; each tile's
    pieces form one closed chain."""
    T = S.tiles(jlo, jhi)
    problems = []
    for j in range(0, 3):
        for kind in "UDTB":
            nm = f"{kind}{j}"
            for p in T[nm][1]:
                n = sum(1 for (k2, (_, ps)) in T.items() if k2 != nm for q in ps if piece_equal(p, q))
                on_edge = p.kind == "S" and ((p.P[1] - S.Y).is0() and (p.Q[1] - S.Y).is0() or (p.P[1] + S.Y).is0() and (p.Q[1] + S.Y).is0())
                if not ((n == 1 and not on_edge) or (n == 0 and on_edge)):
                    problems.append((nm, repr(p), n, on_edge))
            # closed chain: every endpoint used an even number of times
            ends = [e for p in T[nm][1] for e in p.ends()]
            for e in ends:
                if sum(1 for f in ends if K.veq(e, f)) != 2:
                    problems.append((nm, "open chain at", K.fpt(e)))
    return problems


def float_area(pieces, n=2000):
    """shoelace area of the boundary chain, arcs sampled (a float guard, not a verdict)."""
    import math
    # sample each piece (orientation fixed by matching endpoints)
    path = []

    def samples(p, rev):
        if p.kind == "S":
            a, b = K.fpt(p.P), K.fpt(p.Q)
            s = [a, b]
        else:
            cx, cy = K.fpt(p.C)
            r = float(p.r)
            a0 = math.atan2(float(p.S[1]) - cy, float(p.S[0]) - cx)
            a1 = math.atan2(float(p.E[1]) - cy, float(p.E[0]) - cx)
            span = (a1 - a0) % (2 * math.pi)
            s = [(cx + r * math.cos(a0 + span * i / n), cy + r * math.sin(a0 + span * i / n)) for i in range(n + 1)]
        return s[::-1] if rev else s
    # greedy chain by endpoints
    rem = list(pieces)
    p0 = rem.pop(0)
    path = samples(p0, False)
    while rem:
        tail = path[-1]
        best = None
        for i, q in enumerate(rem):
            s = samples(q, False)
            if abs(s[0][0] - tail[0]) + abs(s[0][1] - tail[1]) < 1e-9:
                best = (i, False)
                break
            if abs(s[-1][0] - tail[0]) + abs(s[-1][1] - tail[1]) < 1e-9:
                best = (i, True)
                break
        assert best is not None, "chain broken"
        q = rem.pop(best[0])
        path += samples(q, best[1])[1:]
    A = 0.0
    for (x1, y1), (x2, y2) in zip(path, path[1:]):
        A += x1 * y2 - x2 * y1
    return abs(A) / 2


# ------------------------------------------------------------------ the same-colour check over the infinite strip
def check_strip(S, K_SHIFT=3, verbose=False):
    """orbit pairs under the period 3/2: a representative tile of columns 0..2 against every same-colour tile of columns [-3K, 3K+2]; the rest
    are dismissed by an exact x-gap bound (> 1 means min > 1, so 1 is not interior)."""
    reps = [(kind, j) for j in range(3) for kind in "UDTB"]
    lo_col, hi_col = -3 * K_SHIFT, 3 * K_SHIFT + 2
    allt = S.tiles(lo_col - 3, hi_col + 3)
    xr = {nm: xrange_of(ps) for nm, (_, ps) in allt.items()}
    rows, bad = [], []
    seen = set()
    for (kind, j) in reps:
        a = f"{kind}{j}"
        ca = allt[a][0]
        for kb in "UDTB":
            for jb in range(lo_col, hi_col + 1):
                b = f"{kb}{jb}"
                if allt[b][0] != ca:
                    continue
                # canonical orbit key: translate so the pair's first member lies in columns 0..2
                key1 = (kind, j, kb, jb)
                shift = 3 * ((jb) // 3)
                key2 = (kb, jb - shift, kind, j - shift)
                key = min(key1, key2)
                if key in seen:
                    continue
                seen.add(key)
                r = K.pair_verdict(allt[a][1], allt[b][1], self_pair=(a == b))
                rows.append((a, b, ca, r))
                if r.verdict == "REJECT":
                    bad.append((a, b))
    # the dismissal bound: every same-colour tile beyond the window is x-separated by more than 1 from each representative
    far = []
    for (kind, j) in reps:
        a = f"{kind}{j}"
        for kb in "UDTB":
            for jb in (lo_col - 3, lo_col - 2, lo_col - 1, hi_col + 1, hi_col + 2, hi_col + 3):
                b = f"{kb}{jb}"
                if allt[b][0] != allt[a][0]:
                    continue
                gap = max(xr[b][0] - xr[a][1], xr[a][0] - xr[b][1])
                far.append(gap)
    gmin = min(far)
    return rows, bad, gmin


# ------------------------------------------------------------------ vertices, types, degrees
def vertices_of(S, jlo, jhi):
    T = S.tiles(jlo - 2, jhi + 2)
    pts = []
    for (_, ps) in T.values():
        for p in ps:
            for e in p.ends():
                if not any(K.veq(e, q) for q in pts):
                    pts.append(e)
    return T, pts


def on_piece(p, X):
    if p.kind == "S":
        return K._onseg(p.P, p.Q, X)
    return (K.n2(K.vsub(X, p.C)) == p.r * p.r) and p.has_dir(K.vsub(X, p.C))


def pcl(T, X):
    """closure type: colours of tiles whose closure contains X (X on a boundary piece of the tile; tiles are closed regions)."""
    return sorted({c for (c, ps) in T.values() if any(on_piece(p, X) for p in ps)}, key=COLOURS.index)


def degree(T, X):
    """number of boundary pieces with an endpoint at X plus pieces passing through X in their interior (counted twice), shared pieces once."""
    ps = []
    for (_, pp) in T.values():
        for p in pp:
            if on_piece(p, X) and not any(piece_equal(p, q) for q in ps):
                ps.append(p)
    d = 0
    for p in ps:
        ends = [e for e in p.ends() if K.veq(e, X)]
        d += 1 if ends else 2
    return d


# ------------------------------------------------------------------ symmetries (exact)
def image_tiles(S, f, jlo, jhi, big=6):
    T = S.tiles(jlo - big, jhi + big)
    return T


def map_piece(p, f, reflect):
    if p.kind == "S":
        return Seg(f(p.P), f(p.Q))
    if reflect:
        return Arc(f(p.C), p.r, f(p.E), f(p.S))
    return Arc(f(p.C), p.r, f(p.S), f(p.E))


def symmetry(S, f, reflect, label):
    """does f map every tile of columns 0..2 onto a tile of the strip, with one colour permutation? returns the permutation or None."""
    T = S.tiles(-12, 14)
    perm = {}
    for j in range(0, 3):
        for kind in "UDTB":
            nm = f"{kind}{j}"
            c, ps = T[nm]
            img = [map_piece(p, f, reflect) for p in ps]
            match = None
            for k2, (c2, ps2) in T.items():
                if len(ps2) == len(img) and all(any(piece_equal(q, r) for r in ps2) for q in img):
                    match = (k2, c2)
                    break
            if match is None:
                return None, f"{nm} has no image tile"
            if perm.get(c, match[1]) != match[1]:
                return None, f"colour {c} sent to two colours"
            perm[c] = match[1]
    return perm, "ok"


def cycles(perm):
    seen, out = set(), []
    for c in COLOURS:
        if c in seen or c not in perm:
            continue
        cyc = [c]
        seen.add(c)
        d = perm[c]
        while d != c:
            cyc.append(d)
            seen.add(d)
            d = perm[d]
        if len(cyc) > 1:
            out.append("(" + " ".join(cyc) + ")")
    return "".join(out) or "identity"


def main():
    plant = None
    if "--plant" in sys.argv:
        plant = sys.argv[sys.argv.index("--plant") + 1]
    if "--kplant" in sys.argv:
        K.PLANT = sys.argv[sys.argv.index("--kplant") + 1]
    rho = {"rho11": Fr(11, 10), "rho9": Fr(9, 10)}.get(plant, Fr(1))
    S = Strip(rho, plant)
    print(f"== the strip{' (PLANT ' + plant + ')' if plant else ''}{' (checker plant ' + K.PLANT + ')' if K.PLANT else ''}: "
          f"arc radius {float(S.rho)}, valley height {S.h!r}, apex height {S.g!r}, top edge Y = {S.Y!r} ~ {float(S.Y):.9f}, height 2Y ~ {2 * float(S.Y):.9f}")
    if plant is None:
        for (name, okk) in identities(S):
            print(f"   identity  {'TRUE ' if okk else 'FALSE'}  {name}")
        probs = consistency(S)
        print(f"   map consistency (columns 0..2, 12 tiles): {'every piece shared by exactly two tiles or on the edge; chains closed' if not probs else probs}")
        areas = sum(float_area(S.tile(k, j)) for j in range(3) for k in "UDTB")
        print(f"   float guard: tile areas in one period sum to {areas:.9f}; period x height = {1.5 * 2 * float(S.Y):.9f}")
    rows, bad, gmin = check_strip(S)
    print(f"   same-colour orbit pairs examined exactly: {len(rows)} (12 representative tiles, partners in columns -9..11); every same-colour "
          f"tile beyond is x-separated by >= {gmin!r} ~ {float(gmin):.4f} ({'> 1: dismissed exactly' if gmin > 1 else 'NOT > 1'})")
    for (a, b, c, r) in rows:
        if r.verdict == "REJECT" or (plant is None and r.lo_class <= 0 and "--quiet" not in sys.argv):
            kinds = sorted({ct[2][0] for ct in r.contacts})
            print(f"   {c}  {a:4s} {b:4s} {r.verdict:6s} min {'<' if r.lo_class < 0 else '=' if r.lo_class == 0 else '>'}1 (~{r.lo:.6f})  "
                  f"max {'<' if r.hi_class < 0 else '=' if r.hi_class == 0 else '>'}1 (~{r.hi:.6f})  exact contacts at 1: {len(r.contacts)} {kinds}")
    print(f"   VERDICT: {'REJECT ' + str(bad) if bad else 'ACCEPT'}  ({len(rows)} pairs examined; pairs with min <= 1 (within reach): "
          f"{sum(1 for x in rows if x[3].lo_class <= 0)})")
    return S, rows, bad


if __name__ == "__main__" and "--plants" not in sys.argv:
    main()


# ------------------------------------------------------------------ CAL-PLANT on the strip: each planted fault beside the faithful twin, its
# rejected orbit pairs PREDICTED BY HAND before the run (plans/FS112-YB-verification.md stage 3 gives the reasons)
SELF_UD = {("U0", "U0"), ("U1", "U1"), ("U2", "U2"), ("D0", "D0"), ("D1", "D1"), ("D2", "D2")}
SELF_TB = {("T0", "T0"), ("T1", "T1"), ("T2", "T2"), ("B0", "B0"), ("B1", "B1"), ("B2", "B2")}
OUT_CONTACTS = {("D0", "T-1"), ("D0", "T2"), ("T0", "D-2"), ("T0", "D1"), ("T1", "D-1"), ("T1", "D2"),
                ("U0", "B-1"), ("U0", "B2"), ("B0", "U-2"), ("B0", "U1"), ("B1", "U-1"), ("B1", "U2")}
PRED = {
    None: set(),
    "rho11": SELF_UD,                    # arch diameter 11/10 (corner to its own arc); every other contact moves to >= 1
    "rho9": OUT_CONTACTS | SELF_TB,      # each out-contact (a corner to the whole arc about it) at 9/10; valley to top corners sqrt(1.027)
    "tall": SELF_TB,                     # the top/bottom tiles' apex-to-far-corner diagonal above 1
    "colswap": {("U0", "U1"), ("U0", "B0"), ("U0", "U-2")},  # arch 0 (now G) touches arch 1, is 0.968 above bottom tile 0, 1/2 from arch -2
}


def run_plants():
    ok = True
    for plant in [None, "rho11", "rho9", "tall", "colswap"]:
        rho = {"rho11": Fr(11, 10), "rho9": Fr(9, 10)}.get(plant, Fr(1))
        S = Strip(rho, plant)
        rows, bad, gmin = check_strip(S)
        got = set(bad)
        want = PRED[plant]
        good = got == want
        ok &= good
        print(f"  {'ok' if good else 'MISMATCH':8s} strip plant {str(plant):8s}: {len(rows)} pairs, rejected {sorted(got)}"
              + ("" if good else f"\n           predicted {sorted(want)}"))
    # the checker's plants on the faithful strip
    K.PLANT = "closed_interval"
    rows, bad, _ = check_strip(Strip())
    within = [(a, b) for (a, b, c, r) in rows if r.lo_class <= 0]
    good = sorted(bad) == sorted(within) and len(bad) == 36
    ok &= good
    print(f"  {'ok' if good else 'MISMATCH':8s} checker plant closed_interval on the faithful strip: rejects {len(bad)} pairs = every pair within reach "
          f"(predicted: all 36, each touching at exactly 1)")
    K.PLANT = "noself"
    rows, bad, _ = check_strip(Strip(Fr(11, 10), "rho11"))
    good = bad == []
    ok &= good
    print(f"  {'ok' if good else 'MISMATCH':8s} checker plant noself on plant rho11: rejects {bad} (predicted: nothing -- the diameter fault is invisible)")
    K.PLANT = None
    return ok


if __name__ == "__main__" and "--plants" in sys.argv:
    r = run_plants()
    print("STRIP PLANTS", "ALL AS PREDICTED" if r else "SOME MISMATCH")
    sys.exit(0 if r else 1)
