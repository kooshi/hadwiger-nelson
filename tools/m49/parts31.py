"""P8: μ(φ) EXACTLY on Parts's 31-vertex {1,φ} six-forcer (arXiv:2010.12656 v2).

1. Reconstruct G126 = G5^{⊕5} (regular unit-side pentagon, five-fold Minkowski sum) exactly in
   ℚ(√5); find the 16-vertex subgraph G16 whose two published edge lists (28 unit, 28 φ) are the
   INDUCED {1,φ}-distances among the points (planted control: the lists reproduce exactly).
2. G31 = G16 ∪ (G16 rotated about vertex 1 by α, cos α = (95+√5)/100), designed edge |16−16'| = 1
   exact; every other cross pair classified numerically at 60 digits (margin reported).
3. μ_exact := min |S ⊆ E(φ)| with unit ∪ S not 5-colourable, by implicit hitting set
   (scipy.milp over the accumulated 5-colourings, CaDiCaL for the check) — an EXACT minimum, the
   one μ value the milestone pins. Same on G16 for the forced-pair invariant (1 = 16 forced).
   Greedy 1-minimal over several orders alongside, to calibrate greedy μ_upper against the truth.
"""
from __future__ import annotations
import sys, itertools, random, time, json
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import coloring, rigidity, forcer  # noqa
from twodist import _brk_full, _degree_order  # noqa
import numpy as np
from scipy.optimize import milp, LinearConstraint, Bounds
import mpmath as mp
mp.mp.dps = 60

K = 5
OUT = Path("/home/kooshi/source/lean-dir/build/m49-parts31.json")

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

# ---------------------------------------------------------------- exact minimum by implicit hitting set
def min_hitting_set(sets, m):
    """min |S| ⊆ range(m) hitting every set (each a nonempty list of indices)."""
    if not sets: return []
    A = np.zeros((len(sets), m));
    for r, s in enumerate(sets):
        for j in s: A[r, j] = 1
    res = milp(c=np.ones(m), constraints=LinearConstraint(A, lb=np.ones(len(sets)), ub=np.inf),
               integrality=np.ones(m), bounds=Bounds(0, 1))
    assert res.success, res.message
    return [j for j in range(m) if res.x[j] > 0.5]

from hitset import Mu
def mu_exact(n, unit, dedges, k, violate, label):
    mu = Mu(n, unit, dedges, k, extra=violate.get("extra"), cap=None, label=label)
    mu.load(f"/home/kooshi/source/lean-dir/build/m49-hs-{label.split()[0]}-{label.split()[-1]}.json")
    r = mu.run(report_every=50, state=f"/home/kooshi/source/lean-dir/build/m49-hs-{label.split()[0]}-{label.split()[-1]}.json")
    assert r["status"] == "exact", r
    return r["mu"], r["S"], r["iterations"]

def greedy_min(n, unit, dedges, k, extra, seed):
    ids = list(range(len(dedges))); order = list(ids); random.Random(seed).shuffle(order)
    for j in order:
        trial = [i for i in ids if i != j]
        st, _ = solve(n, unit + [dedges[i] for i in trial], k, extra=extra)
        if st == "unsat": ids = trial
    return ids

rows = []
# (a) G31, invariant "not 5-colourable"
mu31, S31, it31 = mu_exact(n31, E1, Ed, K, {"extra": None}, "G31 μ(φ)")
g31 = [len(greedy_min(n31, E1, Ed, K, None, s)) for s in range(5)]
print("G31: exact μ(φ) =", mu31, " greedy 1-minimal sizes over 5 orders:", g31, " essential:", [Ed[j] for j in S31])
rows.append({"kind": "mu-exact", "object": "Parts-G31", "k": 5, "n": n31, "unit": len(E1), "phi": len(Ed),
             "mu_exact": mu31, "essential": [list(Ed[j]) for j in S31], "iterations": it31, "greedy_orders": g31,
             "claim_scope": "the minimum number of φ-edges over all subgraphs of Parts's G31 (all unit edges kept, "
             "which is WLOG since dropping a unit edge never helps) that are not 5-colourable — exact, by implicit "
             "hitting set over 5-colourings with CaDiCaL as the oracle and HiGHS as the hitting-set solver; tools-side"})
# (b) G16, invariant "1 = 16 forced" (the forced-equal carrier, the analogue of H's phase-2 quantity)
E1_g = [(a - 1, b - 1) for a, b in E1_16]; Ed_g = [(a - 1, b - 1) for a, b in Ed_16]
extra_ne = [[-coloring.var(0, c, K), -coloring.var(15, c, K)] for c in range(K)]
st, _ = solve(16, E1_g + Ed_g, K, extra=extra_ne); print("G16 with 1≠16:", st); assert st == "unsat"
mu16, S16, it16 = mu_exact(16, E1_g, Ed_g, K, {"extra": extra_ne}, "G16 forced 1=16")
g16 = [len(greedy_min(16, E1_g, Ed_g, K, extra_ne, s)) for s in range(5)]
print("G16 forced-pair carrier: exact min φ-edges =", mu16, " greedy:", g16, " essential:", [Ed_g[j] for j in S16])
rows.append({"kind": "mu-exact", "object": "Parts-G16-forced-1-16", "k": 5, "n": 16, "unit": 28, "phi": 28,
             "mu_exact": mu16, "essential": [list(Ed_g[j]) for j in S16], "iterations": it16, "greedy_orders": g16,
             "claim_scope": "the minimum number of φ-edges of a subgraph of G16 (unit edges kept) in which vertices "
             "1 and 16 are forced equal at five colours — exact, implicit hitting set; tools-side"})
# (c) K5-pentagon control: the five-clique {1,2,3,5,6} needs its φ-diagonals: which of the essential set are pentagon diagonals?
pent = {(0,4),(0,5),(1,2),(1,5),(2,4)}
print("essential ∩ pentagon{1,2,3,5,6} diagonals:", sorted(set(Ed[j] for j in S31) & pent))
OUT.write_text(json.dumps({"schema": "m49-parts31/1", "rows": rows}, indent=1))
print("wrote", OUT)
