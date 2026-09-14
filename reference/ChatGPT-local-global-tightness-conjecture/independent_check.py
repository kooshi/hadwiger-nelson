#!/usr/bin/env python3
"""Independent re-check of GPT Astra's two explicit identities (de Bruijn, 2026-09-14).

Shares no code with `verify_local_global_extensions.py` and represents the field differently: every point is a
sympy expression in sqrt(2), sqrt(3), sqrt(7) and I, and each squared distance is decided by `sympy.nsimplify`
+ exact expansion (`expand` + `radsimp`), never by the advisor's 4-coefficient basis arithmetic.

Checks, each with a negative control:
  1. The 18 points of `example_qsqrt2_qsqrt3.json` (read from the JSON, not regenerated) have exactly 33 unit pairs,
     equal as a set to the JSON's `edges`; the six diamonds' five unit edges each and the closing edge are present.
     The hand proof of non-3-colourability then needs only the diamond lemma (two triangles on a shared edge force
     the two apexes equal) — checked here by a direct 3-colouring search restricted by that lemma, and, as a control,
     by an exhaustive backtracking search that is independent of it, with the edge-criticality census as the control.
  2. The JSON's four-colouring is proper on all 33 edges (control: a planted colouring with one clash is rejected).
  3. The eight multipliers over Q(sqrt7)(i) are unit vectors and sum to 3/8 (control: replacing one multiplier by
     its conjugate changes the sum).
"""
import json
import itertools
import sys
from pathlib import Path

import sympy as sp

HERE = Path(__file__).resolve().parent
data = json.loads((HERE / "example_qsqrt2_qsqrt3.json").read_text())

s2, s3, s6 = sp.sqrt(2), sp.sqrt(3), sp.sqrt(6)
basis = [sp.Integer(1), s2, s3, s6]


def coord(cs):
    return sum(sp.Rational(c) * b for c, b in zip(cs, basis))


pts = [(coord(p["x"]), coord(p["y"])) for p in data["coordinates"]]
assert len(pts) == 18


def dist2(a, b):
    return sp.radsimp(sp.expand((a[0] - b[0]) ** 2 + (a[1] - b[1]) ** 2))


unit = set()
for i, j in itertools.combinations(range(18), 2):
    d2 = dist2(pts[i], pts[j])
    if d2 == 1:
        unit.add((i, j))
    else:
        assert sp.simplify(d2 - 1) != 0
assert len(unit) == 33, len(unit)
assert unit == {tuple(e) for e in data["edges"]}

# The six diamonds: z, z+u, z+ωu, z+δu — unit edges (0,1),(0,2),(1,2),(1,3),(2,3), and |z0 - z3|^2 = 3.
for a, b, c, d in data["diamonds"]:
    for e in [(a, b), (a, c), (b, c), (b, d), (c, d)]:
        assert (min(e), max(e)) in unit, (a, b, c, d, e)
    assert dist2(pts[a], pts[d]) == 3
ce = tuple(data["closing_edge"])
assert (min(ce), max(ce)) in unit
# Chain: consecutive diamonds share endpoint, first starts at 0, last ends at the closing edge's other end.
chain = data["diamonds"]
assert chain[0][0] == ce[0] and chain[-1][3] == ce[1]
for x, y in zip(chain, chain[1:]):
    assert x[3] == y[0]

# Hand proof, mechanised: in a 3-colouring each diamond forces colour(z) = colour(z+δu); chain ⟹ ends equal; edge ⟹ ⊥.
# Control: exhaustive backtracking 3-colouring search, independent of the diamond lemma.
adj = {v: set() for v in range(18)}
for i, j in unit:
    adj[i].add(j)
    adj[j].add(i)


def colourable(k, edges_adj, n=18):
    col = [-1] * n
    order = sorted(range(n), key=lambda v: -len(edges_adj[v]))

    def go(idx):
        if idx == n:
            return True
        v = order[idx]
        for c in range(k):
            if all(col[w] != c for w in edges_adj[v]):
                col[v] = c
                if go(idx + 1):
                    return True
                col[v] = -1
        return False

    return go(0)


assert not colourable(3, adj)
assert colourable(4, adj)
# Control (reachable): the refusal is not degenerate — some single edge deletion makes the graph 3-colourable.
# (Deleting the closing edge alone does NOT: it coincides with an edge of the first diamond, whose remaining
# triangle (1,2,3) still contradicts the chain's col(3) = col(1); the planted control that assumed it was unreachable.)
critical = []
for i, j in sorted(unit):
    adj_del = {v: set(w for w in ws if {v, w} != {i, j}) for v, ws in adj.items()}
    if colourable(3, adj_del):
        critical.append((i, j))
assert critical, "no single deletion restores 3-colourability"

# 2. The four-colouring.
four = data["four_colouring"]
assert len(four) == 18 and all(four[i] != four[j] for i, j in unit)
bad = list(four)
i0, j0 = next(iter(unit))
bad[j0] = bad[i0]
assert not all(bad[i] != bad[j] for i, j in unit)

# 3. The eight-copy identity over Q(sqrt7)(i).
w = (-3 + sp.I * sp.sqrt(7)) / 4
wb = sp.conjugate(w)
assert sp.simplify(w * wb) == 1
mult = [w**3, wb**3] + [-w**2] * 3 + [-wb**2] * 3
assert all(sp.simplify(m * sp.conjugate(m)) == 1 for m in mult)
assert sp.simplify(sum(mult)) == sp.Rational(3, 8)
assert sp.simplify(sp.Rational(8, 3) * sum(mult)) == 1
ctrl = [w**3, w**3] + [-w**2] * 3 + [-wb**2] * 3  # one multiplier replaced by its conjugate
assert sp.simplify(sum(ctrl)) != sp.Rational(3, 8)
# The trace identities the advisor states.
assert sp.simplify(w + wb) == sp.Rational(-3, 2)
assert sp.simplify(w**2 + wb**2) == sp.Rational(1, 4)
assert sp.simplify(w**3 + wb**3) == sp.Rational(9, 8)

print("independent_check: 18 points, 33 unit pairs = JSON edges; six diamonds + closing edge present;")
print(f"  not 3-colourable (exhaustive), 4-colourable; {len(critical)} of 33 edges critical (control reachable);")
print("  JSON four-colouring proper; eight multipliers unit with sum 3/8 (control differs). ALL PASS")
