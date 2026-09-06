#!/usr/bin/env python3
"""M57 B3 — the richness dial (plans/M57-additive-rigidity.md D4, §M1.6): the ℤ/5-hom count of a growing chunk as a
function of its direction set. Balls by point count about a centre in (i) de Grey's gen-1 half-spindle closure
(regenerated EXACTLY here from closure.py — the stored pts file holds floats), (ii) the F₂₄₇ depth-2 thickened stage,
(iii) Heule-510. Per row: points, radius², edges, rank, |S₅|, homs (exact or ≥ cap, or 0 with its mechanism).
    python3 tools/m57_richness.py --field degrey|f247|heule [--cap 300]"""
import sys, json, math, time, argparse
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, 'tools')
import numpy as np
import additive as AD, additive_rigid as AR

ap = argparse.ArgumentParser(); ap.add_argument("--field", required=True); ap.add_argument("--cap", type=int, default=300); ap.add_argument("--radii", default="", help="squared radii, comma-separated; default per field")
a = ap.parse_args()
OUT = Path("data/m57"); OUT.mkdir(exist_ok=True)
log = lambda *x: print(*x, flush=True)

def couple_to_chunk(pts, name, source):
    denom = 1
    for p in pts:
        for part in p:
            for x in part:
                denom = denom * Fr(x).denominator // math.gcd(denom, Fr(x).denominator)
    fr = AD.FrameField16([3, 5, 7, 11], denom)
    P = [tuple(Fr(x) for x in p[0]) + tuple(Fr(x) for x in p[1]) for p in pts]
    return P, fr

t0 = time.time()
if a.field == "degrey":
    import closure as CL
    pts, origin, centre2 = CL.degrey_points()
    g = CL.close_gen(pts, [origin, centre2], CL.GEN1_GENS)
    log(f"[richness] gen-1 closure regenerated exactly: {len(g['pts'])} points (+{g['new']}, {g['fusions']} fusions) [{time.time()-t0:.0f}s]")
    P, fr = couple_to_chunk(g["pts"], "degrey-gen1", "closure.close_gen(degrey_points, GEN1_GENS) regenerated exactly")
    centre = g['pts'].index(origin) if not isinstance(origin, int) else origin; radii = [float(x) for x in a.radii.split(",")] if a.radii else [1, 2, 4, 1e9]
    name, source = "degrey-gen1", "closure.py gen-1 half-spindle closure of the 1581 (⟨ζ12, σ, √ρ15, √ρ63⟩ about both centres), regenerated exactly"
elif a.field == "f247":
    ch = AR.load_depth2(); P, fr = ch.points, ch.frame
    centre = int(ch.meta.get("centre_index", 12) or 12); radii = [float(x) for x in a.radii.split(",")] if a.radii else [1, 2, 3, 4, 6, 8, 12, 1e9]
    name, source = "W-plus-cross-depth2", ch.source
elif a.field == "heule":
    ch = AD.load_chunk(type("A", (), dict(heule510=True))()); P, fr = ch.points, ch.frame
    centre = 0; radii = [float(x) for x in a.radii.split(",")] if a.radii else [0.5, 1, 2, 3, 4, 1e9]
    name, source = "heule510", ch.source + " (centre = vertex 0)"
else:
    raise SystemExit("--field degrey|f247|heule")

xy = np.array([AD.float_of(fr, p) for p in P]); c = xy[centre]
d2 = ((xy - c) ** 2).sum(axis=1); order = np.argsort(d2, kind="stable")
rows = []
for R2 in radii:
    keep = [int(i) for i in order if d2[i] <= R2 + 1e-9]; N = len(keep)
    r2 = min(R2, float(d2[keep[-1]]))
    sub = AD.Chunk(f"{name}-N{N}", [P[i] for i in keep], [], fr, f"{source}; the {N} points nearest vertex {centre}", "edges re-derived exactly below")
    E = AR.unit_pairs(sub.points, fr)
    sub = AD.Chunk(f"{name}-N{N}", [P[i] for i in keep], E, fr, sub.source, f"all unit pairs among the {N} points re-derived exactly (float proposal, exact disposal)")
    if sub.n and sub.edges:
        L, vecs, scale = AR.build_lattice_dirs(sub)      # distinct directions: the same lattice
        S5 = AD.unit_classes(L, vecs, 5)
        in5 = sum(1 for d in vecs if all(int(x) % 5 == 0 for x in L.coords(d)))
        if L.rank <= 8:
            homs = AD.enumerate_homs(L, vecs, (5,)); status = "enumerated"; count = len(homs)
        else:
            status, homs = AD.sat_homs(L, vecs, (5,), max_models=a.cap); count = len(homs)
        mech = None
        if count == 0:
            mech = "obstruct: a unit vector in 5Λ (exact)" if in5 else ("hyperplane cover (the hom SAT's UNSAT — the solver's claim)" if status == "unsat" else f"none found ({status})")
        row = dict(N=N, radius2_threshold=R2, radius2=r2, points=sub.n, edges=len(sub.edges), directions=len(vecs), components=len(sub.bases), rank=L.rank, unit_classes_mod5=len(S5), units_in_5L=in5,
                   homs=count, homs_status=("exact" if status in ("enumerated", "unsat", "sat-complete") else f"≥{count} (cap {a.cap})"), mechanism_at_zero=mech,
                   fingerprint=sub.fingerprint(), seconds=round(time.time() - t0, 1))
    else:
        row = dict(N=N, radius2_threshold=R2, radius2=r2, points=sub.n, edges=len(sub.edges), note="no edges")
    rows.append(row); log(f"[richness] {name} r²≤{R2:g} (N={N}, r²={r2:.3f}): edges {row.get('edges')} dirs {row.get('directions')} rank {row.get('rank')} |S5| {row.get('unit_classes_mod5')} units∈5Λ {row.get('units_in_5L')} homs {row.get('homs')} ({row.get('homs_status')}) {row.get('mechanism_at_zero') or ''} [{time.time()-t0:.0f}s]")
rec = dict(kind="additive-richness", field=a.field, stage=name, source=source, centre=centre, k=5, cap=a.cap, rows=rows,
           claim_scope="per row the ball of squared radius ≤ R² about the centre (N points), its unit pairs re-derived exactly, its lattice rank, the number of unit classes mod 5, the units in 5Λ, and the "
                       "ℤ/5-hom count (enumerated below rank 9, SAT above: exact when the solver ended UNSAT or complete, else a lower bound at the cap). A zero row's mechanism is exact "
                       "when a unit lies in 5Λ and the solver's claim otherwise. The dial's x-axis is (rank, |S5|); the radius is incidental (§M1.6).")
json.dump(rec, open(OUT / f"richness-{a.field}-k5.json", "w"), indent=1, default=str)
log(f"[richness] wrote data/m57/richness-{a.field}-k5.json")
