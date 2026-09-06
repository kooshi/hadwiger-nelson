#!/usr/bin/env python3
"""M57 B2 — the seed at five colours: G's Kempe closure and enumeration (P10), the seed's {1,2}-graph records, P3 on
M49's separating lists and on the 252-cheat object, and P9's counts (loose incidences vs defect-1 classes)."""
import sys, json, time, itertools
from pathlib import Path
sys.path.insert(0, 'tools')
import additive as AD, additive_rigid as AR, twodist as T
from collections import Counter
OUT = Path('data/m57'); OUT.mkdir(exist_ok=True)
quiet = lambda *x, **k: None
rec = dict(kind="m57-b2", parts={})

# (a) G: 205 points, 966 unit + 423 distance-2 edges
G = T.ei_G(); cG = T.classify(G, radii=(1, 4)); unitsG, cheatsG = cG[1], sorted((min(u, v), max(u, v)) for u, v in cG[4])
chG = AD.Chunk("EI-G-unit", [tuple(p) for p in G], unitsG, AD.FrameEI4(), "twodist.ei_G() unit edges", "twodist.dist2_is (exact)")
famG = AR.Family(chG, 5, cheatsG, log=quiet)
resG = AR.closure_census(chG, famG, chG.edges + cheatsG, log=quiet)
colsG, compG, modelsG, stG = AR.enumerate_colourings(chG.n, chG.edges + cheatsG, 5, 0, log=quiet)
vdsG = Counter(famG.is_additive(c) for c in colsG)
print(f"[b2] G {{1,2}}-graph k=5: γ = {resG['gamma']} over {len(famG.reps)} additive colourings × 10 pairs; disconnected {resG['disconnected']} of {resG['pairs_total']}; loose {resG['loose_incidences']} on {resG['loose_vertices']} vertices; "
      f"swaps non-additive {resG['swaps']['non_additive']} additive {resG['swaps']['additive']}; rigid: {len(colsG)} colourings ({stG}), {dict(vdsG)}")
resGu = AR.closure_census(chG, famG, chG.edges, log=quiet)
print(f"[b2] G unit part k=5: γ = {resGu['gamma']}; loose {resGu['loose_incidences']} on {resGu['loose_vertices']} of {chG.n}")
rec["parts"]["G"] = dict(stage=chG.header(), cheats=len(cheatsG), family=famG.summary(), closure_12={k: v for k, v in resG.items() if k not in ("hom_rows", "swap_records")},
                         closure_unit={k: v for k, v in resGu.items() if k not in ("hom_rows", "swap_records")}, rigid=dict(colourings=len(colsG), status=stG, verdicts=dict(vdsG)))

# (b) H: the seed's {1,2}-graph — closure and rigid through the CLI records (written by additive.py); here the numbers for P9
seed = AD.load_seed(); H = T.ei_H(); cH = T.classify(H, radii=(1, 4)); cheatsH = sorted((min(u, v), max(u, v)) for u, v in cH[4])
famH = AR.Family(seed, 5, cheatsH, log=quiet)
resH = AR.closure_census(seed, famH, seed.edges + cheatsH, log=quiet)
colsH, compH, modelsH, stH = AR.enumerate_colourings(seed.n, seed.edges + cheatsH, 5, 0, log=quiet)
rowsH = []
for c in colsH:
    vd = famH.is_additive(c)
    if vd == "additive":
        rowsH.append(dict(verdict=vd)); continue
    d, i = famH.defect(c); rowsH.append(dict(verdict=vd, defect=d))
defH = Counter(r.get("defect") for r in rowsH if r["verdict"] != "additive")
print(f"[b2] H {{1,2}}-graph k=5: γ = {resH['gamma']} (loose {resH['loose_incidences']} on {resH['loose_vertices']}, Kempe part {resH['kempe_part']}); swaps non-additive {resH['swaps']['non_additive']}, additive {resH['swaps']['additive']}; "
      f"rigid: {len(colsH)} colourings ({stH}), additive {sum(1 for r in rowsH if r['verdict']=='additive')}, defects {dict(sorted(defH.items()))}")
rec["parts"]["H"] = dict(closure_12={k: v for k, v in resH.items() if k not in ("hom_rows", "swap_records")}, rigid=dict(colourings=len(colsH), status=stH, defects=dict(sorted(defH.items()))))

# (c) P3: the 19 separating lists (H − e) and the 252-cheat object
import glob
p3 = []
for f in sorted(glob.glob('build/m49-sep-*.json')):
    x = json.load(open(f)); e = tuple(x['edge']); cols = x['colourings']
    E = seed.edges + [c for c in cheatsH if c != e]
    imp = sum(1 for c in cols if AD.verify_proper(c, E))
    ds = [famH.defect(c)[0] for c in cols]
    p3.append(dict(edge=list(e), colourings=len(cols), exact=x.get('exact'), improper_on_H_minus_e=imp, defects=ds, max_defect=max(ds) if ds else None))
print(f"[b2] P3 (M49 lists): {len(p3)} refuser edges; colourings {sum(r['colourings'] for r in p3)}; max defect per edge {[r['max_defect'] for r in p3]}; improper {sum(r['improper_on_H_minus_e'] for r in p3)}")
rec["parts"]["P3_lists"] = p3
# the 252 survivors: indices into the cheat list in twodist's classify order — checked against the 29 essential pairs
ess = [tuple(e) for e in json.load(open('build/m49-seed-edges.json'))['rows'][0]['essential_alone']]
S = json.load(open('build/m49-seed-edges-S.json'))['S']
cheats_m49 = [tuple(sorted(e)) for e in cH[4]]     # classify's own order (unsorted)
sub = [cheats_m49[i] for i in S]
ok = all(tuple(sorted(e)) in set(sub) for e in ess)
print(f"[b2] the 252-cheat object: indices resolved in classify order; contains all 29 essential pairs: {ok}")
if ok:
    t0 = time.time()
    cols252, comp252, models252, st252 = AR.enumerate_colourings(seed.n, seed.edges + sub, 5, 5000, wall=1800, log=quiet)
    ds = [famH.defect(c)[0] if famH.is_additive(c) != 'additive' else 0 for c in cols252]
    hist = Counter(ds)
    print(f"[b2] 252-cheat object: {len(cols252)} colourings up to palette ({st252}, {models252} models, {time.time()-t0:.0f}s); defect histogram {dict(sorted(hist.items()))}; max {max(ds) if ds else None}")
    rec["parts"]["P3_252"] = dict(colourings=len(cols252), status=st252, models=models252, defects=dict(sorted(hist.items())), max_defect=max(ds) if ds else None,
                                  cheats=sorted(sub), claim_scope="the M49 ddmin survivor set (build/m49-seed-edges-S.json 'S', indices into twodist.classify(ei_H)[4]) as extra edges; enumeration by palette-orbit blocking under a cap of 5000 / 1800 s")

# (d) P9: loose incidences (closure) vs defect-1 classes (rigid) on four stages
p9 = []
for name, ch, k, cheats in (("seed+cheats", seed, 5, cheatsH), ("moser", AD.planted("moser"), 4, []), ("hexball1", AR.hexball(1), 4, []), ("k4e", AD.planted("k4e"), 4, [])):
    fam = AR.Family(ch, k, cheats, log=quiet); res = AR.closure_census(ch, fam, ch.edges + cheats, log=quiet)
    cols, comp, models, st = AR.enumerate_colourings(ch.n, ch.edges + cheats, k, 0, log=quiet)
    d1 = sum(1 for c in cols if fam.is_additive(c) != 'additive' and fam.defect(c)[0] == 1)
    # distinct loose incidences up to palette: (hom partition, vertex, missing colour) — count as recorded (per rep)
    p9.append(dict(stage=name, k=k, loose_incidences=res['loose_incidences'], defect1_classes=d1, colourings=len(cols), le=d1 <= res['loose_incidences']))
    print(f"[b2] P9 {name} k={k}: loose incidences {res['loose_incidences']} vs defect-1 classes {d1} of {len(cols)} colourings → {'≤ holds' if d1 <= res['loose_incidences'] else 'VIOLATED'}")
rec["parts"]["P9"] = p9
json.dump(rec, open(OUT / 'b2-seed-k5.json', 'w'), indent=1, default=str)
print("[b2] wrote data/m57/b2-seed-k5.json")
