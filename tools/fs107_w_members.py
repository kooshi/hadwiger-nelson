#!/usr/bin/env python3
"""FS107-W's members, each given by formula (never by search): writes member files for `fs107_w_check.py`.

A member is a periodic partial colouring by closed grid squares of side h (grid units throughout; see the checker's
docstring for the file format).  Every function here is a formula in its parameters; none optimises or searches.

  hex_seven_minus_one(U, V1, V2, h, eps)   the known positive: the hexagonal seven-colouring (Voronoi cells of the
                                           lattice Z(U,0) + Z(V1,V2), coloured by (m + 3n) mod 7), one class left
                                           uncovered, rasterised by square centres.  Uncovered density exactly 1/7.
  hex_absorb(rho, U, V1, V2, h, eps)       family HX(rho), FS107-W stage 2.6: the same seven-colouring with the colour-0
                                           hexagon cut into six triangles (apex its centre, base an edge), each triangle
                                           given to the neighbour across its base, and a void B(c0, rho) left at every
                                           colour-0 centre.  The split is argmax <p - c0, w>/|w|^2 over the six neighbour
                                           vectors w (exactly the fan through the Voronoi vertices), ties broken by a fixed
                                           order; all arithmetic exact.
"""

from __future__ import annotations

import json
import sys
from fractions import Fraction


def _nearest_lattice_point(cx2: int, cy2: int, u: tuple[int, int], v: tuple[int, int]):
    """Nearest point m*u + n*v of the lattice to the point (cx2/2, cy2/2), ties broken by a translation-invariant key
    on the offset (so the assignment is Lambda-equivariant and each lattice cell is one fundamental domain)."""
    det = u[0] * v[1] - u[1] * v[0]
    # real coordinates of the point in the (u, v) basis, then check a 3x3 neighbourhood of the rounded guess
    x, y = Fraction(cx2, 2), Fraction(cy2, 2)
    m0 = (x * v[1] - y * v[0]) / det
    n0 = (u[0] * y - u[1] * x) / det
    best = None
    for m in range(int(m0) - 2, int(m0) + 3):
        for n in range(int(n0) - 2, int(n0) + 3):
            px, py = m * u[0] + n * v[0], m * u[1] + n * v[1]
            ox, oy = 2 * px - cx2, 2 * py - cy2          # twice the offset, integer
            key = (ox * ox + oy * oy, ox, oy)
            if best is None or key < best[0]:
                best = (key, m, n)
    return best[1], best[2]


def hex_seven_minus_one(U: int = 31, V1: int = 15, V2: int = 27, h: str = "1/40", eps: str = "1/20",
                        drop: int = 0) -> dict:
    """The rasterised slack hexagonal seven-colouring with colour `drop` left uncovered (a six-colour partial
    colouring; uncovered density exactly 1/7).  Lattice u = (U, 0), v = (V1, V2) in grid units; the colour period
    lattice is {m u + n v : m + 3n = 0 mod 7}, with basis 7u and v - 3u."""
    u, v = (U, 0), (V1, V2)
    basis = [[7 * U, 0], [V1 - 3 * U, V2]]
    det = 7 * U * V2
    # canonical cells: take the HNF period cell of the colour lattice and colour each square by its centre
    sys.path.insert(0, __file__.rsplit("/", 1)[0])
    from fs107_w_check import Torus  # noqa: E402
    T = Torus(basis)
    cells = []
    for i in range(T.A):
        for j in range(T.C):
            m, n = _nearest_lattice_point(2 * i + 1, 2 * j + 1, u, v)
            col = (m + 3 * n) % 7
            if col == drop:
                continue
            c6 = col - 1 if col > drop else col
            cells.append([i, j, c6])
    assert T.A * T.C == det
    return {"name": f"hex7-minus-one U={U} v=({V1},{V2}) h={h} eps={eps}", "colours": 6, "h": h, "eps": eps,
            "basis": basis, "cells": cells,
            "provenance": "fs107_w_members.hex_seven_minus_one (formula; FS107-W stage 1 known positive)"}


def hex_absorb(rho: str, U: int = 31, V1: int = 15, V2: int = 27, h: str = "1/40", eps: str = "1/20") -> dict:
    """Family HX(rho) (FS107-W stage 2.6), rasterised by square centres; colours 1..6 -> 0..5."""
    u, v = (U, 0), (V1, V2)
    basis = [[7 * U, 0], [V1 - 3 * U, V2]]
    rho_g2 = (Fraction(rho) / Fraction(h)) ** 2          # squared void radius in grid units
    nbrs = [u, (-u[0], -u[1]), v, (-v[0], -v[1]), (v[0] - u[0], v[1] - u[1]), (u[0] - v[0], u[1] - v[1])]
    sys.path.insert(0, __file__.rsplit("/", 1)[0])
    from fs107_w_check import Torus  # noqa: E402
    T = Torus(basis)
    cells = []
    for i in range(T.A):
        for j in range(T.C):
            m, n = _nearest_lattice_point(2 * i + 1, 2 * j + 1, u, v)
            col = (m + 3 * n) % 7
            if col != 0:
                cells.append([i, j, col - 1])
                continue
            cx, cy = m * u[0] + n * v[0], m * u[1] + n * v[1]
            dx2, dy2 = 2 * i + 1 - 2 * cx, 2 * j + 1 - 2 * cy     # twice the offset from the centre
            if Fraction(dx2 * dx2 + dy2 * dy2, 4) < rho_g2:
                continue                                             # the void
            best = None
            for k, w in enumerate(nbrs):
                val = Fraction(dx2 * w[0] + dy2 * w[1], w[0] * w[0] + w[1] * w[1])
                if best is None or val > best[0]:
                    best = (val, k)
            w = nbrs[best[1]]
            # the neighbour's lattice coordinates: w is +-u, +-v or +-(v - u)
            dm, dn = {0: (1, 0), 1: (-1, 0), 2: (0, 1), 3: (0, -1), 4: (-1, 1), 5: (1, -1)}[best[1]]
            ncol = (m + dm + 3 * (n + dn)) % 7
            assert ncol != 0
            cells.append([i, j, ncol - 1])
    return {"name": f"HX rho={rho} U={U} v=({V1},{V2}) h={h} eps={eps}", "colours": 6, "h": h, "eps": eps,
            "basis": basis, "cells": cells,
            "provenance": "fs107_w_members.hex_absorb (formula; FS107-W stage 3, family HX(rho))"}


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("family", choices=["hex7m1", "hx"])
    ap.add_argument("--rho", default="3/10")
    ap.add_argument("--out", required=True)
    ap.add_argument("--h", default="1/40")
    ap.add_argument("--eps", default="1/20")
    a = ap.parse_args()
    if a.family == "hex7m1":
        d = hex_seven_minus_one(h=a.h, eps=a.eps)
    elif a.family == "hx":
        d = hex_absorb(a.rho, h=a.h, eps=a.eps)
    with open(a.out, "w") as f:
        json.dump(d, f)
    print(f"wrote {a.out}: {len(d['cells'])} coloured squares")
