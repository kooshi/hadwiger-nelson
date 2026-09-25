#!/usr/bin/env python3
"""FS-89 Stage 0B: the orbit model of the band set Theta_k(U5), exact (Fractions), level by level.

THE MODEL (derived in plans/FS89-S0B-band-set.md §1).  Layers A_m = w^m Z[i] (w = (3+4i)/5 = pi/pibar, pi = 2+i).  A
character theta of R5 = Z[i][1/5] restricts to A_m as y -> <e_m, w^{-m} y> with e_m in C/Z[i]; compatibility on
A_m ∩ A_{m+1} = w^m pi Z[i] is  e_{m+1} - wbar e_m in pi^{-1} Z[i];  the family {A_m} is an interval family, so
compatible sequences are exactly the characters; theta(i^k w^m) = <e_m, i^k>, so the band [lo, hi] on U5 is
"e_m in Q = [lo, hi]^2 (mod Z[i])" for every m.  Q lies in one fundamental domain, so lift e_m uniquely into Q:

    Theta_k(U5)  <->  { (e_m)_{m in Z} : e_m in Q,  e_{m+1} - wbar*e_m in pi^{-1} Z[i] }.

Level K = the window |m| <= K = the characters of 5^{-K} Z[i] = sum_{|m|<=K} A_m with the band on {i^k w^m : |m| <= K}
(FS81-T8's Theta_K).  A 'piece' is a word (the digits c_m = e_{m+1} - wbar e_m for -K <= m < K) together with its set of
e_0, a convex polygon (every e_m is an isometric affine image of e_0 once the word is fixed).  Different words have
disjoint sets, so pieces are the connected components of Theta_K.

Usage: fs89_s0b_orbits.py --band 1/4 3/4 --depth 5 [--plant none|lattice-pibar|drop-imag] [--expect-t3] [--json F]
"""
from __future__ import annotations

import argparse
import json
import os
import sys
import time
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs81_verify_thetaR as T40  # frozen; imported only (exact closed half-plane clipping)

ONE = (Fr(1), Fr(0))
W = (Fr(3, 5), Fr(4, 5))
WB = (Fr(3, 5), Fr(-4, 5))


def cmul(p, q):
    return (p[0] * q[0] - p[1] * q[1], p[0] * q[1] + p[1] * q[0])


def cadd(p, q):
    return (p[0] + q[0], p[1] + q[1])


def conj(p):
    return (p[0], -p[1])


def lattice_points(gen, box):
    """Points g*z (z in Z[i]) inside box = (x0, x1, y0, y1), exact.  g = gen, a Gaussian rational."""
    x0, x1, y0, y1 = box
    # g*z = (g0 a - g1 b, g1 a + g0 b); invert: z = conj(g) * v / |g|^2
    n = gen[0] ** 2 + gen[1] ** 2
    corners = [(x, y) for x in (x0, x1) for y in (y0, y1)]
    zs = [cmul(conj(gen), c) for c in corners]
    a0 = min(z[0] for z in zs) / n
    a1 = max(z[0] for z in zs) / n
    b0 = min(z[1] for z in zs) / n
    b1 = max(z[1] for z in zs) / n
    out = []
    for a in range(int(a0) - 1, int(a1) + 2):
        for b in range(int(b0) - 1, int(b1) + 2):
            v = cmul(gen, (Fr(a), Fr(b)))
            if x0 <= v[0] <= x1 and y0 <= v[1] <= y1:
                out.append(v)
    return out


class Model:
    def __init__(self, lo: Fr, hi: Fr, plant: str = "none"):
        self.lo, self.hi, self.plant = lo, hi, plant
        # forward digit lattice pi^{-1} Z[i] = (pibar/5) Z[i]; backward w pi^{-1} Z[i] = pibar^{-1} Z[i] = (pi/5) Z[i]
        self.fgen = (Fr(2, 5), Fr(-1, 5))
        self.bgen = (Fr(2, 5), Fr(1, 5))
        if plant == "lattice-pibar":        # planted fault: the wrong prime in the forward step
            self.fgen = (Fr(2, 5), Fr(1, 5))

    def Q_halfplanes(self, rot, sh):
        """Half-planes (a, b): a.x <= b on e_0 such that rot*e_0 + sh lies in Q = [lo, hi]^2.
        Re(rot e + sh) = <conj(rot)... >: Re(rot*e) = r0 e0 - r1 e1, Im(rot*e) = r1 e0 + r0 e1."""
        r0, r1 = rot
        re = (r0, -r1)
        im = (r1, r0)
        hp = [(re, self.hi - sh[0]), ((-re[0], -re[1]), -(self.lo - sh[0]))]
        if self.plant != "drop-imag":
            hp += [(im, self.hi - sh[1]), ((-im[0], -im[1]), -(self.lo - sh[1]))]
        return hp

    def start(self):
        lo, hi = self.lo, self.hi
        E = [(lo, lo), (hi, lo), (hi, hi), (lo, hi)]
        if self.plant == "drop-imag":
            E = [(lo, Fr(-1, 2)), (hi, Fr(-1, 2)), (hi, Fr(3, 2)), (lo, Fr(3, 2))]
        # piece: (E, frot, fsh, brot, bsh, word)   e_K = frot*e_0 + fsh ; e_{-K} = brot*e_0 + bsh
        return [(E, ONE, (Fr(0), Fr(0)), ONE, (Fr(0), Fr(0)), ())]

    def extend(self, pieces, side):
        new = []
        for E, frot, fsh, brot, bsh, word in pieces:
            if side == "f":
                rot = cmul(WB, frot)
                base = cmul(WB, fsh)
                gen = self.fgen
            else:
                rot = cmul(W, brot)
                base = cmul(W, bsh)
                gen = self.bgen
            img = [cadd(cmul(rot, p), base) for p in E]
            box = (self.lo - max(p[0] for p in img), self.hi - min(p[0] for p in img),
                   self.lo - max(p[1] for p in img), self.hi - min(p[1] for p in img))
            if self.plant == "drop-imag":
                box = (box[0], box[1], Fr(-3), Fr(3))
            for c in lattice_points(gen, box):
                sh = cadd(base, c)
                P = E
                for a, b in self.Q_halfplanes(rot, sh):
                    P = T40.clip(P, a, b)
                    if not P:
                        break
                if P:
                    if side == "f":
                        new.append((P, rot, sh, brot, bsh, word + (("f", c),)))
                    else:
                        new.append((P, frot, fsh, rot, sh, (("b", c),) + word))
        return new


def classify(pieces, lo, hi):
    P0 = ((lo + hi) / 2, (lo + hi) / 2)
    npt = sum(1 for p in pieces if len(p[0]) == 1)
    nseg = sum(1 for p in pieces if len(p[0]) == 2)
    npoly = len(pieces) - npt - nseg
    containsP = 0
    for E, *_ in pieces:
        if len(E) >= 3:
            inside = all(T40.clip([P0], a, b) for a, b in _edges_hp(E))
            containsP += inside
    return npt, nseg, npoly, containsP


def _edges_hp(E):
    import fs89_s0b_cells as C
    V = C.cyclic(E)
    hp = []
    for k in range(len(V)):
        p, q = V[k], V[(k + 1) % len(V)]
        a = (q[1] - p[1], -(q[0] - p[0]))  # outward normal for ccw order
        hp.append((a, a[0] * p[0] + a[1] * p[1]))
    return hp


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--band", nargs=2, default=["1/4", "3/4"])
    ap.add_argument("--depth", type=int, default=4)
    ap.add_argument("--plant", default="none", choices=["none", "lattice-pibar", "drop-imag", "band-hi"])
    ap.add_argument("--expect-t3", action="store_true")
    ap.add_argument("--json")
    a = ap.parse_args()
    lo, hi = Fr(a.band[0]), Fr(a.band[1])
    if a.plant == "band-hi":              # planted fault: the band's top edge moved in by 1/15
        hi = hi - Fr(1, 15)
    M = Model(lo, hi, a.plant)
    pieces = M.start()
    t0 = time.time()
    ok = True
    rows = []
    for K in range(0, a.depth + 1):
        if K > 0:
            pieces = M.extend(pieces, "f")
            pieces = M.extend(pieces, "b")
        npt, nseg, npoly, cP = classify(pieces, lo, hi)
        rows.append({"K": K, "pieces": len(pieces), "points": npt, "segments": nseg, "polygons": npoly,
                     "polygons_containing_centre": cP})
        print(f"K={K}  pieces={len(pieces):7d}  points={npt:6d}  segments={nseg:5d}  polygons={npoly:6d}  "
              f"polygons containing the centre: {cP}   t={time.time() - t0:.1f}s", flush=True)
        if a.expect_t3 and K >= 1:
            # FS81-T3/T8 in this model: exactly one polygon (around P = (1/2,1/2)) and the four X3 points
            pts = sorted(p[0][0] for p in pieces if len(p[0]) == 1)
            x3 = sorted((Fr(x, 3), Fr(y, 3)) for x in (1, 2) for y in (1, 2))
            good = (len(pieces) == 5 and npoly == 1 and cP == 1 and pts == x3)
            ok = ok and good
    if a.json:
        with open(a.json, "w") as fh:
            json.dump({"band": [str(lo), str(hi)], "plant": a.plant, "rows": rows}, fh, indent=1)
    if a.expect_t3:
        print("CONTROL:", "FS81-T3/T8 reproduced in the orbit model (one polygon around the centre + the four X3 points "
              "at every depth)" if ok else "DIFFERENT from FS81-T3")
        return 0 if ok else 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
