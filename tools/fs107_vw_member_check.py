"""FS107-VW: independent exact check of a grid-square member given as data (job FS107-VW, 2026-09-27; stage 4).

Reads a member JSON (fields 'h', 'eps', 'basis' = two integer period vectors in square-index units, 'cells' = [[i, j, colour], ...]),
uses only the data (never the producer's checker), reduces every cell modulo the period lattice with its own Hermite form, and checks
exactly: for every index offset whose distance range [min, max] (rational squared values) meets [1 - eps, 1 + eps], no two squares of one
colour.  Reported both in the null form (strict: max > 1 - eps and min < 1 + eps) and the closed form (>=, <=).  Also the exact slack:
min over same-colour offsets near 1 of the distance from 1 to [min, max], as 'h*sqrt(n) - 1' or '1 - h*sqrt(n)'.

Usage: python3 tools/fs107_vw_member_check.py <member.json> [...]
"""
import json
import math
import sys
from fractions import Fraction as F

import numpy as np

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from fs107_vw_grid_check import Torus  # noqa: E402


def load(path):
    d = json.load(open(path))
    cells = d["cells"]
    if isinstance(cells, str):
        cells = json.loads(cells)
    (g1, g2) = [tuple(v) for v in d["basis"]]
    tor = Torus(g1, g2)
    col = -np.ones((tor.A, tor.C), dtype=int)
    for (i, j, c) in cells:
        a, b = tor.reduce(np.array(i), np.array(j))
        a, b = int(a), int(b)
        if col[a, b] != -1:
            raise ValueError(f"cell {(i, j)} collides with another listed cell modulo the period lattice")
        col[a, b] = c
    return d, F(d["h"]), F(d["eps"]), tor, col


def analyse(path):
    d, h, eps, tor, col = load(path)
    I, J = np.meshgrid(np.arange(tor.A), np.arange(tor.C), indexing="ij")
    reach = int(math.ceil(float((1 + eps) / h))) + 3
    lo2, hi2 = (1 - eps) ** 2, (1 + eps) ** 2
    viol_strict, viol_closed = [], []
    slack = None  # (value float, expr)
    win = F(1, 10)
    for di in range(-reach, reach + 1):
        for dj in range(-reach, reach + 1):
            if di == 0 and dj == 0:
                continue
            nmin = max(0, abs(di) - 1) ** 2 + max(0, abs(dj) - 1) ** 2
            nmax = (abs(di) + 1) ** 2 + (abs(dj) + 1) ** 2
            mn2, mx2 = h * h * nmin, h * h * nmax
            if mx2 < (1 - win) ** 2 or mn2 > (1 + win) ** 2:
                continue
            i2, j2 = tor.reduce(I + di, J + dj)
            same = (col >= 0) & (col == col[i2, j2])
            if not same.any():
                continue
            if mx2 > lo2 and mn2 < hi2:
                viol_strict.append((di, dj))
            if mx2 >= lo2 and mn2 <= hi2:
                viol_closed.append((di, dj))
            # margin of this offset: distance from 1 to [h sqrt(nmin), h sqrt(nmax)]
            if mx2 < 1:
                m, e = 1 - float(h) * math.sqrt(nmax), f"1 - h*sqrt({nmax})"
            elif mn2 > 1:
                m, e = float(h) * math.sqrt(nmin) - 1, f"h*sqrt({nmin}) - 1"
            else:
                m, e = -1.0, "straddles 1"
            if slack is None or m < slack[0]:
                slack = (m, e, (di, dj))
    blank = F(int((col < 0).sum()), col.size)
    dens = {int(c): F(int((col == c).sum()), col.size) for c in np.unique(col) if c >= 0}
    return {"name": d.get("name"), "squares": col.size, "eps": str(eps), "viol_strict": len(viol_strict),
            "viol_closed": len(viol_closed), "verdict_null_form": "ACCEPT" if not viol_strict else "REJECT",
            "slack": slack, "uncovered": f"{blank.numerator}/{blank.denominator}", "uncovered_float": float(blank),
            "max_class": float(max(dens.values()))}


if __name__ == "__main__":
    for p in sys.argv[1:]:
        r = analyse(p)
        print(json.dumps(r, default=str))
