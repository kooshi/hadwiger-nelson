#!/usr/bin/env python3
"""FS-89 Stage 0B, step 2: the layer-transition graph of the rational pattern's band set (exact, Fractions).

A character theta of R5 = Z[i][1/5] is the compatible chain of its layers psi_m = (theta o w^m)|_L, L = (1/5)Z[i],
w = (3+4i)/5; psi_m = lambda_{mu_m}, mu_m in C/5Z[i] (FS81-C-verification §1.2).  Band on U5 <=> every mu_m in
Theta_R(lo, hi).  Compatibility on consecutive layers: mu_{m+1} = wbar*mu_m + delta_m, delta_m in pibar Z[i]
(pibar = 2 - i), with mu_m lifted to fixed representative cells P_j (the cells of fs89_s0b_cells.py).  Consecutive
compatibility suffices (the layers w^m L form an 'interval' family: (A_0+..+A_m) ∩ A_{m+1} = A_m ∩ A_{m+1}).

A cell P_j is the H-polytope { lo + n_u <= <mu, u> <= hi + n_u : u in the six directions } (n_u read off its centroid).
Edge (j -> k, delta): P_j ∩ { mu : wbar*mu + delta in P_k } nonempty, i.e. <mu, w u> in [lo + n_u - <delta,u>,
hi + n_u - <delta,u>] (since <wbar mu, u> = <mu, w u>).
"""
from __future__ import annotations

import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs81_verify_thetaR as T40  # frozen; imported only
import fs89_s0b_cells as CELLS

W = (Fr(3, 5), Fr(4, 5))        # w
WB = (Fr(3, 5), Fr(-4, 5))      # wbar
PIB = (Fr(2), Fr(-1))           # pibar


def cmul(p, q):
    return (p[0] * q[0] - p[1] * q[1], p[0] * q[1] + p[1] * q[0])


def dot(p, q):
    return p[0] * q[0] + p[1] * q[1]


def floor_fr(x: Fr) -> int:
    return x.numerator // x.denominator


BIG = [(Fr(-100), Fr(-100)), (Fr(100), Fr(-100)), (Fr(100), Fr(100)), (Fr(-100), Fr(100))]


def vrep(H):
    """Vertices of the H-polytope H = [(a, b)] meaning a.x <= b, by clipping a big box (degenerate results allowed)."""
    P = BIG
    for a, b in H:
        P = T40.clip(P, a, b)
        if not P:
            return []
    return P


class Band:
    def __init__(self, lo: Fr, hi: Fr, cells=None):
        self.lo, self.hi = lo, hi
        self.dirs = T40.directions(T40.rational_units())
        self.cells = cells if cells is not None else [CELLS.cyclic(P) for P in CELLS.cells(lo, hi, self.dirs)]
        self.n = []  # per cell, per direction, the band index
        for P in self.cells:
            c = (sum(p[0] for p in P) / len(P), sum(p[1] for p in P) / len(P))
            self.n.append([floor_fr(dot(c, u) - lo) for u in self.dirs])
        for j, P in enumerate(self.cells):  # sanity: the H-rep reproduces the cell
            assert sorted(vrep(self.H(j))) == sorted(P), j

    def H(self, j, shift=(Fr(0), Fr(0)), rot=(Fr(1), Fr(0))):
        """Half-planes on mu_prev such that rot*mu_prev + shift lies in cell j (rot a unit complex number, |rot| = 1).
        <rot*mu + s, u> = <mu, conj(rot) u> + <s, u>."""
        rc = (rot[0], -rot[1])
        out = []
        for u, nu in zip(self.dirs, self.n[j]):
            v = cmul(rc, u)
            su = dot(shift, u)
            out.append((v, self.hi + nu - su))
            out.append(((-v[0], -v[1]), -(self.lo + nu - su)))
        return out

    def edges(self):
        """All (j, k, delta, overlap-polygon) with delta in pibar Z[i]."""
        res = []
        for j, Pj in enumerate(self.cells):
            img = [cmul(WB, p) for p in Pj]
            ix = (min(p[0] for p in img), max(p[0] for p in img))
            iy = (min(p[1] for p in img), max(p[1] for p in img))
            for k, Pk in enumerate(self.cells):
                kx = (min(p[0] for p in Pk), max(p[0] for p in Pk))
                ky = (min(p[1] for p in Pk), max(p[1] for p in Pk))
                # delta in [kx0 - ix1, kx1 - ix0] x [ky0 - iy1, ky1 - iy0]
                dx0, dx1 = kx[0] - ix[1], kx[1] - ix[0]
                dy0, dy1 = ky[0] - iy[1], ky[1] - iy[0]
                for a in range(-12, 13):
                    for b in range(-12, 13):
                        d = cmul(PIB, (Fr(a), Fr(b)))
                        if not (dx0 <= d[0] <= dx1 and dy0 <= d[1] <= dy1):
                            continue
                        Q = vrep(self.H(j) + self.H(k, shift=d, rot=WB))
                        if Q:
                            res.append((j, k, d, Q))
        return res


def describe(band: Band):
    E = band.edges()
    out = {}
    for j, k, d, Q in E:
        out.setdefault(j, []).append((k, d, Q))
    return E, out


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--band", nargs=2, default=["1/4", "3/4"])
    a = ap.parse_args()
    B = Band(Fr(a.band[0]), Fr(a.band[1]))
    E, out = describe(B)
    print(f"band [{B.lo}, {B.hi}]: {len(B.cells)} cells, {len(E)} edges")
    for j in range(len(B.cells)):
        P = B.cells[j]
        c = (sum(p[0] for p in P) / len(P), sum(p[1] for p in P) / len(P))
        succ = out.get(j, [])
        print(f" cell {j:2d} ({len(P):2d}v, avg ({c[0]}, {c[1]})): "
              + "; ".join(f"->{k} d=({d[0]},{d[1]}) [{len(Q)}v]" for k, d, Q in succ))
