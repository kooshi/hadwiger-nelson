#!/usr/bin/env python3
"""FS-89 close (inventory item 25): reconcile S0B's 29 depth-one cells with verifier H's 29 band torsion characters.

S0B's cells (`data/fs89/s0b/cells-k4.json`) are the components of the band set of `L = (1/5)Z[i]` on the rational
pattern, in coordinates mu in C/5Z[i] (a character of L is y -> <mu, y>). Verifier H's list (S1V-5) is the band
torsion characters of Q = Z[i][1/p : p = 1 mod 4]: orders 2, 3, 4, 7, 8. A torsion character of Q of order N (5 does
not divide N) restricts to L as the point mu in (5/N)Z^2 mod 5Z^2 whose values on Z[i] are the character's.

This locates every such point in S0B's cells, exactly (Fractions), and prints where each lands. It asserts the
correspondence derived at the close: parity in the 12-gon; order 3 in the four hexagons; order 7 inside the eight
quadrilaterals; order 4 at the eight order-4 point cells; order 8 at a vertex of each quadrilateral; and the eight
remaining point cells carry no torsion character of Q (order 20 on L) -- they are the four corners (1+i)/4 + (1/2)Z[i]
of D1-L4, each seen twice per period. A fixed list: the 119 primitive points of orders 2, 3, 4, 7, 8 (3 + 8 + 12 +
48 + 48); nothing is searched.

    python3 tools/fs89_close_cell_reconcile.py            # the check; exit 0 iff the correspondence holds
    python3 tools/fs89_close_cell_reconcile.py --plant    # order 8 replaced by order 9: must go red
"""
from __future__ import annotations

import json
import sys
from fractions import Fraction as F
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def inside(p, poly):
    """Closed convex polygon membership (vertices in order), exact."""
    signs = set()
    for i in range(len(poly)):
        (x1, y1), (x2, y2) = poly[i], poly[(i + 1) % len(poly)]
        cr = (x2 - x1) * (p[1] - y1) - (y2 - y1) * (p[0] - x1)
        if cr != 0:
            signs.add(cr > 0)
    return len(signs) <= 1


def primitive(a, b, n):
    from math import gcd
    return gcd(gcd(a, b), n) == 1


def main() -> int:
    plant = "--plant" in sys.argv
    cells = [[(F(a), F(b)) for a, b in c] for c in json.loads((ROOT / "data/fs89/s0b/cells-k4.json").read_text())["cells"]]
    orders = (2, 3, 4, 7, 9 if plant else 8)
    where: dict[int, list] = {}
    for n in orders:
        for a in range(n):
            for b in range(n):
                if not primitive(a, b, n):
                    continue
                p = (F(5 * a, n), F(5 * b, n))
                hits = [(len(c), "vertex" if p in c else "interior") for c in cells
                        if (len(c) > 1 and inside(p, c)) or (len(c) == 1 and c[0] == p)]
                if hits:
                    where.setdefault(n, []).append((p, hits))
    for n in orders:
        print(f"order {n}: {len(where.get(n, []))} band points")
        for p, h in where.get(n, []):
            print(f"    mu = ({p[0]}, {p[1]})  -> {h}")
    expect = {2: [(12, "interior")], 3: [(6, "interior")], 4: [(1, "vertex")], 7: [(4, "interior")], 8: [(4, "vertex")]}
    counts = {2: 1, 3: 4, 4: 8, 7: 8, 8: 8}
    ok = True
    for n, want in counts.items():
        got = where.get(n, [])
        if len(got) != want or any(h != expect[n] for _, h in got):
            print(f"MISMATCH at order {n}: {len(got)} points, expected {want} at {expect[n]}")
            ok = False
    pts = [c[0] for c in cells if len(c) == 1]
    torsion_pts = {p for n in (4, 8) for p, h in where.get(n, []) if h == [(1, "vertex")]}
    rest = [p for p in pts if p not in torsion_pts]
    corners = sorted({(p[0] % 1, p[1] % 1) for p in rest})
    print(f"point cells: {len(pts)}; carrying an order-4 character: {len(torsion_pts)}; the rest: {len(rest)}, "
          f"restricting to Z[i] as e in {[(str(x), str(y)) for x, y in corners]}")
    if len(rest) != 8 or corners != [(F(1, 4), F(1, 4)), (F(1, 4), F(3, 4)), (F(3, 4), F(1, 4)), (F(3, 4), F(3, 4))]:
        print("MISMATCH: the remaining point cells are not the four corners, twice each")
        ok = False
    print("RESULT:", "PASS" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
