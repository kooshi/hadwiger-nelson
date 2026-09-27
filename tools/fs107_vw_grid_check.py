"""FS107-VW: exact band check of a periodic partial colouring by half-open grid squares (job FS107-VW, 2026-09-27).

Object: squares [ih, (i+1)h) x [jh, (j+1)h), colour c(i, j) in {-1 (blank), 0..6}, periodic under an integer lattice
Lambda' (so also under D*Z^2, D = det Lambda').  Falsifier (claims.md, W's killing test 1): two squares of one colour whose
exact distance range [min, max] meets [1 - eps, 1 + eps] (strictly: max > 1 - eps and min < 1 + eps; touching at an
endpoint is a null set).  The range of two axis-parallel squares at index offset (di, dj) depends on the offset only and is
rational: min^2 = h^2 (max(0,|di|-1)^2 + max(0,|dj|-1)^2), max^2 = h^2 ((|di|+1)^2 + (|dj|+1)^2).  Every offset is
classified in Fractions; the colour comparison is exact integer.  How the colours were chosen (floats) is not trusted.

Usage: python3 tools/fs107_vw_grid_check.py   # known positive + an HX member, each with a planted fault; exit 0 iff as expected
"""
import math
import sys
from fractions import Fraction as F

import numpy as np

sys.path.insert(0, __file__.rsplit("/", 1)[0])


def bad_offsets(h, eps):
    lo2, hi2 = (1 - eps) ** 2, (1 + eps) ** 2
    reach = int(math.ceil(float((1 + eps) / h))) + 2
    out = []
    for di in range(-reach, reach + 1):
        for dj in range(-reach, reach + 1):
            mn2 = h * h * (max(0, abs(di) - 1) ** 2 + max(0, abs(dj) - 1) ** 2)
            mx2 = h * h * ((abs(di) + 1) ** 2 + (abs(dj) + 1) ** 2)
            if mx2 > lo2 and mn2 < hi2:
                out.append((di, dj))
    return out


class Torus:
    """colours on Z^2 / Lambda', Lambda' = <(A, 0), (B, C)> in Hermite form."""

    def __init__(self, g1, g2):
        (a1, b1), (a2, b2) = g1, g2
        C = math.gcd(b1, b2)
        # u b1 + v b2 = C
        def egcd(x, y):
            if y == 0:
                return (1 if x >= 0 else -1, 0)
            q, r = divmod(x, y)
            s, t = egcd(y, r)
            return (t, s - q * t)
        u, v = egcd(b1, b2)
        assert u * b1 + v * b2 == C
        det = abs(a1 * b2 - a2 * b1)
        self.A, self.C = det // C, C
        self.B = (u * a1 + v * a2) % self.A
        assert self.A * self.C == det

    def reduce(self, i, j):
        q = np.floor_divide(j, self.C)
        return np.mod(i - q * self.B, self.A), j - q * self.C


def check(col, tor, h, eps):
    offs = bad_offsets(h, eps)
    I, J = np.meshgrid(np.arange(tor.A), np.arange(tor.C), indexing="ij")
    viol = []
    for (di, dj) in offs:
        i2, j2 = tor.reduce(I + di, J + dj)
        same = (col >= 0) & (col == col[i2, j2])
        if same.any():
            k = np.argwhere(same)[0]
            viol.append(((int(k[0]), int(k[1])), (di, dj), int(col[k[0], k[1]])))
    return viol, len(offs)


def hex_design(R, rho, h, mode):
    """rasterise the hex design (mode 'hex7blank' or 'hx') on a torus whose period lattice rounds L7 to the grid."""
    s3 = math.sqrt(3)
    a, b = np.array([s3 * R, 0.0]), np.array([s3 * R / 2, 1.5 * R])
    w1, w2 = 2 * a + b, -a + 3 * b
    g1 = (round(w1[0] / h), round(w1[1] / h))
    g2 = (round(w2[0] / h), round(w2[1] / h))
    tor = Torus(g1, g2)
    Mg = np.array([[g1[0] * h, g2[0] * h], [g1[1] * h, g2[1] * h]])
    M = np.column_stack([w1, w2]) @ np.linalg.inv(Mg)  # grid coords -> design coords, M(g h) = w
    distortion = np.linalg.svd(M, compute_uv=False)
    I, J = np.meshgrid(np.arange(tor.A), np.arange(tor.C), indexing="ij")
    P = M @ np.vstack([((I + 0.5) * h).ravel(), ((J + 0.5) * h).ravel()])  # square centres, design coords
    # reduce modulo the hexagonal lattice spanned by a, b: nearest lattice point by rounding in the (a,b) basis + neighbours
    Bm = np.column_stack([a, b])
    co = np.linalg.solve(Bm, P)
    best = None
    for dx in (-1, 0, 1):
        for dy in (-1, 0, 1):
            x, y = np.floor(co[0]) + dx, np.floor(co[1]) + dy
            c = Bm @ np.vstack([x, y])
            d = np.hypot(P[0] - c[0], P[1] - c[1])
            if best is None:
                best = (d, x, y, c)
            else:
                m = d < best[0]
                best = (np.where(m, d, best[0]), np.where(m, x, best[1]), np.where(m, y, best[2]),
                         np.where(m, c, best[3]))
    d, x, y, c = best
    hexcol = np.mod(x - 2 * y, 7).astype(int)
    col = hexcol.copy()
    if mode == "hex7blank":
        col[hexcol == 0] = -1
    else:  # hx: colour-0 hexagon -> neighbour across the nearest edge, void disc radius rho
        rel = P - c
        ang = np.degrees(np.arctan2(rel[1], rel[0])) % 360
        m = np.round(ang / 60).astype(int) % 6
        nb = np.array([(1, 0), (0, 1), (-1, 1), (-1, 0), (0, -1), (1, -1)])
        nbcol = np.mod(nb[:, 0] - 2 * nb[:, 1], 7)
        z = hexcol == 0
        col[z] = nbcol[m[z]]
        col[z & (d < rho)] = -1
    return col.reshape(tor.A, tor.C), tor, distortion


def main():
    ok = True
    h = F(1, 100)
    for (name, R, rho, eps, mode) in (("known positive: hex7 blank", 0.44, 0.0, F(1, 50), "hex7blank"),
                                      ("HX member R=.4365 rho=.30", 0.4365, 0.30, F(1, 100), "hx")):
        col, tor, dist = hex_design(R, rho, float(h), mode)
        blank = F(int((col < 0).sum()), col.size)
        viol, nb = check(col, tor, h, eps)
        good = not viol
        ok &= good
        print(f"{name}: torus {tor.A}x{tor.C} (Lambda' HNF), map singular values {dist.round(5)}, bad offsets {nb},"
              f" violations {len(viol)} -> {'PASS' if good else 'UNEXPECTED'}; blank density {float(blank):.6f}"
              f" (exact {blank.numerator}/{blank.denominator})")
        # planted fault: colour one blank square with the colour of a square at index distance ~1/h; faithful stub: leave it
        k = np.argwhere(col < 0)[0]
        target = tor.reduce(np.array(k[0] + int(1 / h)), np.array(k[1]))
        c2 = col.copy()
        c2[k[0], k[1]] = col[int(target[0]), int(target[1])] if col[int(target[0]), int(target[1])] >= 0 else 1
        v2, _ = check(c2, tor, h, eps)
        fired = any(v[0] == (int(k[0]), int(k[1])) or tuple(tor.reduce(np.array(v[0][0] + v[1][0]), np.array(v[0][1] + v[1][1]))) == (k[0], k[1]) for v in v2)
        ok &= bool(v2) and fired
        print(f"  planted square {tuple(int(x) for x in k)} coloured {c2[k[0], k[1]]}: violations {len(v2)}, at the plant {fired}"
              f" -> {'FIRES' if v2 and fired else 'UNEXPECTED'}; faithful stub (unplanted) passed above")
    print("ALL AS EXPECTED" if ok else "SOME CHECK UNEXPECTED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
