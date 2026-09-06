#!/usr/bin/env python3
"""M56 D5: the RESIDUE-PER-COSET family on the witness W = core ∪ R(core) (M56 §S1 D4): each side coloured by
the residue colouring of K (both 2-adic branches), the copy's transported through R, under independent palette
injections F4 → {0..k−1}; the RR defect of a colouring is its least Hamming distance to that family. Also samples
4-colourings of W − v (W is vertex-critical) and reports their RR defect — the fifth-colour-on-one-vertex family.

    python3 tools/m56_rr_defect.py --colourings data/m56/colourings-sample-W-core-8over3-k5.json [--minus-v 40]
"""
import sys, json, time, argparse, itertools, random
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import numpy as np
import additive as AD
import residue_colouring as RC
from copy_exact_field import K
from five_dial import KExt, colour_clauses, var, decode, verify_proper
from pysat.solvers import Solver

ap = argparse.ArgumentParser(); ap.add_argument("--witness", default="data/m54/witness-exact-core-8over3.json")
ap.add_argument("--colourings"); ap.add_argument("--minus-v", type=int, default=0); ap.add_argument("--out")
a = ap.parse_args()
d = json.loads(Path(a.witness).read_text()); ch = AD.load_witness(a.witness); n = ch.n; k = 5
KExt.m = int(d["m"])
def kext(j):  # x, y as KExt
    (xA, xB), (yA, yB) = d["points"][j]
    return KExt(K(*(Fr(a_, b_) for a_, b_ in xA)), K(*(Fr(a_, b_) for a_, b_ in xB))), KExt(K(*(Fr(a_, b_) for a_, b_ in yA)), K(*(Fr(a_, b_) for a_, b_ in yB)))
P = [kext(j) for j in range(n)]
core = [j for j in range(n) if P[j][0].B.is_zero() and P[j][1].B.is_zero()]
copy = [j for j in range(n) if j not in set(core)]
c = d["centre_index"]
print(f"[rr] W: {n} points; K-side (B = 0) {len(core)}, copy side {len(copy)}; centre {c}")
# the copy ↔ core correspondence: R⁻¹(p_j) for j on the copy side equals some K-point of the core
cos = KExt.of_K(K(Fr(d["rotation"]["cos"])))
sinB = K(*(Fr(a_, b_) for a_, b_ in d["rotation"]["sin_B_coeffs"])); sin = KExt(K(), sinB)
cx, cy = P[c]
key = {(tuple(P[j][0].A.c), tuple(P[j][1].A.c)): j for j in core}
corr = {}
for j in copy:
    x, y = P[j][0] - cx, P[j][1] - cy
    xi = cos * x + sin * y; yi = -(sin * x) + cos * y        # R⁻¹ = rotation by −θ
    xi, yi = xi + cx, yi + cy
    assert xi.B.is_zero() and yi.B.is_zero(), ("R⁻¹ of a copy point is not a K-point", j)
    kk = (tuple(xi.A.c), tuple(yi.A.c))
    assert kk in key, ("R⁻¹ of a copy point is not a core point", j)
    corr[j] = key[kk]
print(f"[rr] copy ↔ core correspondence: {len(corr)} of {len(copy)} copy points map to core points (all)")
# residue colourings of the core (both branches), transported to the copy
core_pts = {j: (list(P[j][0].A.c), list(P[j][1].A.c)) for j in core}
core_edges = [(u, v) for u, v in ch.edges if u in core_pts and v in core_pts]
fams = []
for start in (17, -17):
    S = RC.sqrt33_2adic(start % 256)
    col, ncomp = RC.colour(core_pts, core_edges, S)
    res = [None] * n
    lab = {}
    for j in core:
        res[j] = lab.setdefault(col[j], len(lab))
    for j in copy:
        res[j] = res[corr[j]]
    assert all(r is not None for r in res) and ncomp == 1
    bad = [(u, v) for u, v in ch.edges if res[u] == res[v] and not ((u in corr or v in corr) and not (u in corr and v in corr))]
    fams.append((start, res))
    print(f"[rr] branch √33 ≡ {start}: residue colouring transported; same-side clashes {len(bad)} (must be 0); cross chords {len(d['cross_chords'])}")
    assert not bad
perms5 = list(itertools.permutations(range(5), 4))   # injections F4 → 5 colours
def rr_defect(colv):
    colv = np.array(colv); best = None
    for start, res in fams:
        res = np.array(res); tot = 0
        for side in (core, copy):
            idx = np.array(side); M = np.zeros((4, 5), dtype=np.int64); np.add.at(M, (res[idx], colv[idx]), 1)
            tot += max(sum(M[a_, pi[a_]] for a_ in range(4)) for pi in perms5)
        dd = n - tot
        best = dd if best is None else min(best, dd)
    return int(best)
out = dict(kind="rr-defect", stage=ch.header(), k=k, sides=dict(core=len(core), copy=len(copy), centre=c), branches=[s for s, _ in fams])
if a.colourings:
    cd = json.loads(Path(a.colourings).read_text()); assert cd["stage_fingerprint"] == ch.fingerprint()
    defs = [rr_defect(cv) for cv in cd["colourings"]]
    from collections import Counter
    out["colourings"] = dict(file=a.colourings, n=len(defs), defects=defs, histogram=dict(sorted(Counter(defs).items())))
    print(f"[rr] {len(defs)} sampled 5-colourings: RR defect histogram {dict(sorted(Counter(defs).items()))} (min {min(defs)}, of {n} vertices)")
if a.minus_v:
    rng = random.Random(56); vs = [565, 1152, c] + rng.sample([v for v in range(n) if v not in (565, 1152, c)], a.minus_v)
    rows = []
    for v in vs:
        E = [(x, y) for x, y in ch.edges if v not in (x, y)]
        cl = colour_clauses(n, E, 4) + [[var(0 if v != 0 else 1, 0, 4)]]
        with Solver(name="cadical153", bootstrap_with=cl) as s:
            ok = s.solve(); assert ok, ("W − v not 4-colourable?!", v)
            colv = decode(s.get_model(), n, 4); assert verify_proper(colv, E) is None
        # RR defect on W − v: count agreement over vertices ≠ v with injections F4 → 4 colours (the 5th colour is v's)
        colv = np.array(colv); best = None
        for start, res in fams:
            res = np.array(res); tot = 0
            for side in (core, copy):
                idx = np.array([j for j in side if j != v]); M = np.zeros((4, 4), dtype=np.int64); np.add.at(M, (res[idx], colv[idx]), 1)
                tot += max(sum(M[a_, pi[a_]] for a_ in range(4)) for pi in itertools.permutations(range(4)))
            dd = (n - 1) - tot; best = dd if best is None else min(best, dd)
        rows.append(dict(v=v, side="core" if v in core_pts else "copy", rr_defect=int(best)))
        print(f"[rr] W − {v} ({'core' if v in core_pts else 'copy'}): a 4-colouring's RR defect {best} (of {n - 1})")
    out["minus_v"] = rows
out["claim_scope"] = "RR family = residue colouring of K on the core (both 2-adic branches), transported to the copy through R⁻¹ (exact), each side under an independent palette injection; defect = least Hamming distance; the sampled colourings are a SAT sample (not uniform); W − v colourings are single SAT models"
path = Path(a.out) if a.out else AD.DATA / "rr-defect-W-core-8over3-k5.json"
path.write_text(json.dumps(out, indent=1)); print(f"[rr] wrote {path}")
