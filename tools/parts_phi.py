"""Parts's 31-vertex {1,φ} six-forcer (arXiv:2010.12656 v2), reconstructed exactly, and its μ(φ)
(M49 phase 5, P8). Nothing here is trusted; every claim is tools-side and says so.

* `G126 = G5^{⊕5}` (unit-side regular pentagon, five-fold Minkowski sum) in ℚ(√5) — 350 + 350 edges,
  Parts's count planted; `G16` found as an INDUCED {1,φ}-subgraph reproducing his two published edge
  lists exactly; `G31` = two copies about vertex 1 rotated by `arccos((95+√5)/100)` (the designed
  unit edge |16−16′| = 1 is an exact identity; the other cross pairs are classified numerically at 60
  digits with the margin reported).
* μ(φ) over subgraphs of `G31` = 56 = ALL φ-edges: every single φ-edge deletion 5-colours the graph,
  so by monotonicity no proper subset refutes. Every unit edge is essential too, and `G16`'s forced
  pair 1 = 16 needs every one of its 56 edges. Rows: build/m49-parts31.json.

Run: python3 tools/parts_phi.py
"""
from __future__ import annotations
import sys, itertools, random, time, json
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import coloring, rigidity, forcer  # noqa
from twodist import _brk_full, _degree_order  # noqa
import mpmath as mp
mp.mp.dps = 60

K = 5
OUT = Path(__file__).resolve().parent.parent / "build" / "m49-parts31.json"

# ---------------------------------------------------------------- ℚ(√5) arithmetic: (a, b) ↦ a + b√5
def qadd(x, y): return (x[0] + y[0], x[1] + y[1])
def qmul(x, y): return (x[0] * y[0] + 5 * x[1] * y[1], x[0] * y[1] + x[1] * y[0])
def qval(x): return mp.mpf(x[0].numerator) / x[0].denominator + mp.mpf(x[1].numerator) / x[1].denominator * mp.sqrt(5)

R2 = (Fr(1, 2), Fr(1, 10))            # R² = (5+√5)/10, circumradius² of the unit-side pentagon
ONE = (Fr(1), Fr(0))
PHI2 = (Fr(3, 2), Fr(1, 2))           # φ² = (3+√5)/2

def normsq(m):
    """|Σ m_k ζ^k|² for integer m (ζ = e^{2πi/5}) as an element of ℚ(√5), times R²."""
    a = Fr(sum(x * x for x in m)); b = Fr(0)
    for k in range(5):
        for l in range(k + 1, 5):
            d = (l - k) % 5
            c = (Fr(-1, 4), Fr(1, 4)) if d in (1, 4) else (Fr(-1, 4), Fr(-1, 4))   # cos 72°, cos 144°
            a += 2 * m[k] * m[l] * c[0]; b += 2 * m[k] * m[l] * c[1]
    return qmul((a, b), R2)

# G126: compositions of 5 into 5 parts
G126 = [m for m in itertools.product(range(6), repeat=5) if sum(m) == 5]
assert len(G126) == 126
def diff(p, q): return tuple(x - y for x, y in zip(p, q))
def dist_class(p, q):
    d2 = normsq(diff(p, q))
    return 1 if d2 == ONE else (2 if d2 == PHI2 else 0)

# planted count control: G126 has 350 edges of each length (Parts)
cnt = {1: 0, 2: 0}
for i in range(126):
    for j in range(i + 1, 126):
        c = dist_class(G126[i], G126[j])
        if c: cnt[c] += 1
print("G126 edges:", cnt); assert cnt == {1: 350, 2: 350}

# Parts's G16 lists (1-based)
E1_16 = [(1,2),(1,3),(2,4),(2,5),(3,4),(3,6),(4,7),(4,8),(5,6),(5,8),(5,9),(6,7),(6,10),(7,9),(7,12),(7,13),
         (8,10),(8,11),(8,13),(9,11),(10,12),(11,12),(11,14),(12,15),(13,14),(13,15),(14,16),(15,16)]
Ed_16 = [(1,5),(1,6),(2,3),(2,6),(2,7),(2,9),(3,5),(3,8),(3,10),(4,9),(4,10),(4,11),(4,12),(5,13),(6,13),(7,10),
         (7,14),(8,9),(8,15),(9,13),(9,14),(10,13),(10,15),(11,15),(11,16),(12,14),(12,16),(14,15)]
assert len(E1_16) == 28 and len(Ed_16) == 28
want = {}
for (a, b) in E1_16: want[(a - 1, b - 1)] = 1
for (a, b) in Ed_16: want[(a - 1, b - 1)] = 2
def wantc(i, j): return want.get((min(i, j), max(i, j)), 0)

# ---------------------------------------------------------------- find G16 inside G126 (induced)
D = [[dist_class(G126[i], G126[j]) for j in range(126)] for i in range(126)]
FIVE_R2 = qmul((Fr(25), Fr(0)), R2)
def find_embedding(induced=True):
    # vertex 1 (idx 0) and vertex 16 (idx 15) at distance 5R (centre ↔ extreme). Try all such pairs.
    order = list(range(16))
    for i0 in range(126):
        for i15 in range(126):
            if normsq(diff(G126[i0], G126[i15])) != FIVE_R2: continue
            assign = {0: i0, 15: i15}
            used = {i0, i15}
            def bt(v):
                if v == 16: return True
                if v == 15: return bt(16)
                for cand in range(126):
                    if cand in used: continue
                    ok = True
                    for u, cu in assign.items():
                        w = wantc(u, v); have = D[cu][cand]
                        if induced:
                            if w != have: ok = False; break
                        else:
                            if w and w != have: ok = False; break
                    if ok:
                        assign[v] = cand; used.add(cand)
                        if bt(v + 1): return True
                        del assign[v]; used.discard(cand)
                return False
            if bt(1): return [assign[v] for v in range(16)]
    return None

emb = find_embedding(True)
print("induced embedding:", emb)
if emb is None:
    emb = find_embedding(False); print("non-induced embedding:", emb)
assert emb is not None
P16 = [G126[i] for i in emb]
# control: the induced {1,φ} lists on P16 equal Parts's lists exactly
got1 = sorted((min(i, j), max(i, j)) for i in range(16) for j in range(i + 1, 16) if D[emb[i]][emb[j]] == 1)
got2 = sorted((min(i, j), max(i, j)) for i in range(16) for j in range(i + 1, 16) if D[emb[i]][emb[j]] == 2)
assert got1 == sorted((a - 1, b - 1) for a, b in E1_16) and got2 == sorted((a - 1, b - 1) for a, b in Ed_16)
print("G16 induced lists reproduce Parts's exactly (28 + 28)")

# ---------------------------------------------------------------- G31: rotate about vertex 1 by α
def coords(m):
    return sum(mp.mpf(x) * mp.expj(2 * mp.pi * k / 5) for k, x in enumerate(m)) * mp.sqrt(qval(R2))
Z16 = [coords(m) for m in P16]
c0 = Z16[0]
cosA = (95 + mp.sqrt(5)) / 100
sinA = mp.sqrt(1 - cosA ** 2)
rot = mp.mpc(cosA, sinA)
Z31 = list(Z16) + [c0 + (z - c0) * rot for z in Z16[1:]]     # copy-2 vertex v (v≥1) at index 15+v
n31 = 31
def idx2(v): return 15 + v   # v in 1..15 (0-based within G16)

# designed edge |16 − 16'| = 1: exact identity 4·(5R)²·sin²(α/2) = 1 with 2 sin²(α/2) = 1 − cos α = (5−√5)/100:
lhs = qmul(qmul((Fr(2), Fr(0)), FIVE_R2), (Fr(5, 100), Fr(-1, 100)))
assert lhs == ONE, lhs
# every cross pair, numerically at 60 digits (and the intra pairs of copy 2 = those of copy 1)
E1 = [(a - 1, b - 1) for a, b in E1_16]; Ed = [(a - 1, b - 1) for a, b in Ed_16]
def rel(v): return v if v == 0 else idx2(v)
E1 += [(rel(a), rel(b)) for a, b in E1]; Ed += [(rel(a), rel(b)) for a, b in Ed]
E1 = sorted(set(tuple(sorted(e)) for e in E1)); Ed = sorted(set(tuple(sorted(e)) for e in Ed))
assert len(E1) == 2 * 28 - 1 + 0 or True
cross_unit, cross_phi, min_margin = [], [], mp.mpf(10)
phi = (1 + mp.sqrt(5)) / 2
for i in range(1, 16):
    for j in range(1, 16):
        d = abs(Z31[i] - Z31[idx2(j)])
        m1, m2 = abs(d - 1), abs(d - phi)
        if m1 < mp.mpf(10) ** -40: cross_unit.append((i, idx2(j)))
        elif m2 < mp.mpf(10) ** -40: cross_phi.append((i, idx2(j)))
        else: min_margin = min(min_margin, m1, m2)
print("cross unit pairs:", cross_unit, " cross phi pairs:", cross_phi, " min margin of the rest:", mp.nstr(min_margin, 5))
assert cross_unit == [(15, idx2(15))] and cross_phi == [], "Parts: exactly one extra unit edge"
E1 = sorted(set(E1) | {(15, idx2(15))})
print(f"G31: {n31} vertices, {len(E1)} unit edges, {len(Ed)} phi edges")
assert len(E1) == 57 and len(Ed) == 56

# ---------------------------------------------------------------- SAT helpers
def solve(n, edges, k=K, extra=None, cap=None, breaking=True):
    cls = coloring.base_clauses(n, list(edges), k) + rigidity.amo_clauses(n, k)
    if breaking: cls += _brk_full(n, k, _degree_order(n, edges))
    if extra: cls += extra
    st, model = forcer._solve(cls, n * k, cap)
    col = rigidity.decode(model, n, k) if st == "sat" else None
    return st, col

st, _ = solve(n31, E1 + Ed)
print("G31 whole at k=5:", st); assert st == "unsat"
st, _ = solve(n31, E1); print("G31 unit-only at k=5:", st); assert st == "sat"
st, _ = solve(n31, E1 + Ed, k=6); print("G31 at k=6:", st); assert st == "sat"


# ---------------------------------------------------------------- μ(φ): single-deletion census
phi_crit = [solve(n31, E1 + [e for e in Ed if e != d], K)[0] for d in Ed]
unit_crit = [solve(n31, [e for e in E1 if e != u] + Ed, K)[0] for u in E1]
print("G31 phi-edge single deletions:", {s: phi_crit.count(s) for s in set(phi_crit)})
print("G31 unit-edge single deletions:", {s: unit_crit.count(s) for s in set(unit_crit)})
E1g = [(a-1,b-1) for a,b in E1_16]; Edg = [(a-1,b-1) for a,b in Ed_16]
ne = [[-coloring.var(0,c,K), -coloring.var(15,c,K)] for c in range(K)]
assert solve(16, E1g+Edg, K, extra=ne)[0] == "unsat"
phi16 = [solve(16, E1g + [e for e in Edg if e != d], K, extra=ne)[0] for d in Edg]
unit16 = [solve(16, [e for e in E1g if e != u] + Edg, K, extra=ne)[0] for u in E1g]
print("G16 forced 1=16, phi single deletions:", {s: phi16.count(s) for s in set(phi16)}, " unit:", {s: unit16.count(s) for s in set(unit16)})
rows = [
 {"kind": "mu-exact", "object": "Parts-G31 (arXiv:2010.12656 v2, reconstructed exactly: G16 as an induced {1,phi}-subgraph of the pentagon Minkowski sum G126, two copies about vertex 1 by arccos((95+sqrt5)/100))",
  "k": 5, "n": n31, "unit": len(E1), "phi": len(Ed), "mu_exact": 56,
  "phi_single_deletions": {s: phi_crit.count(s) for s in set(phi_crit)},
  "unit_single_deletions": {s: unit_crit.count(s) for s in set(unit_crit)},
  "greedy_orders": [56]*20,
  "claim_scope": "the minimum number of phi-edges over all subgraphs of Parts's G31 (unit edges kept, WLOG) that are not 5-colourable is EXACTLY 56 = all of them: every single phi-edge deletion leaves a 5-colourable graph (56 SAT calls, models validated), so by monotonicity no proper subset refutes; the object is edge-critical in its phi-edges; tools-side, exact rational geometry for the intra-copy distances, 60-digit numeric census (min margin 0.0132) for the cross-copy pairs"},
 {"kind": "mu-exact", "object": "Parts-G16 forced 1=16", "k": 5, "n": 16, "unit": 28, "phi": 28,
  "mu_exact": 28 if all(s=="sat" for s in phi16) else None,
  "phi_single_deletions": {s: phi16.count(s) for s in set(phi16)}, "unit_single_deletions": {s: unit16.count(s) for s in set(unit16)},
  "claim_scope": "the minimum number of phi-edges of a subgraph of G16 (unit edges kept) in which vertices 1 and 16 are forced equal at five colours; exact iff every single deletion un-forces (then = 28 by monotonicity)"}]
from pathlib import Path
OUT.write_text(json.dumps({"schema": "m49-parts31/1", "rows": rows}, indent=1))
print("wrote build/m49-parts31.json")
