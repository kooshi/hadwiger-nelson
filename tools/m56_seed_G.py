#!/usr/bin/env python3
"""M56 B2′: Exoo–Ismailescu's smaller graph G (205 points, 966 unit + 423 distance-2 edges, exactly 18 five-colourings
per their Claim 2.1) — are ALL of its five-colourings additive? Enumerates G's colourings by SAT with blocking
(one representative per palette orbit), the admissible Z/5-homs of its unit lattice, and compares partitions."""
import sys, json, time
from pathlib import Path
sys.path.insert(0, 'tools')
import twodist as T
import additive as AD
from five_dial import colour_clauses, var, decode, verify_proper
from rigidity import amo_clauses
from pysat.solvers import Solver
G = T.ei_G(); c = T.classify(G, radii=(1, 4)); units, cheats = c[1], c[4]
print(f"[G] {len(G)} points, {len(units)} unit edges, {len(cheats)} distance-2 edges (paper: 205, 966, 423)")
ch = AD.Chunk("EI-G-unit", [tuple(p) for p in G], units, AD.FrameEI4(), "twodist.ei_G() unit edges", "twodist.dist2_is (exact)")
L, vecs, scale = AD.build_lattice(ch)
homs = AD.enumerate_homs(L, vecs, (5,))
cols = [AD.colouring_of_hom(ch, L, scale, h, (5,)) for h in homs]
parts = {AD.canon(cv): h for cv, h in zip(cols, homs)}
print(f"[G] lattice rank {L.rank}; {len(homs)} admissible Z/5-homs = {len(parts)} additive colourings up to palette; proper on unit ∪ cheats: {sum(1 for cv in cols if not [e for e in units + cheats if cv[e[0]] == cv[e[1]]])} of {len(cols)}")
n, E, k = len(G), units + cheats, 5
cl = colour_clauses(n, E, k) + amo_clauses(n, k) + [[var(0, 0, k)]]
seen = {}; t0 = time.time(); models = 0
with Solver(name="cadical153", bootstrap_with=cl) as s:
    while s.solve():
        col = decode(s.get_model(), n, k); assert verify_proper(col, E) is None; models += 1
        seen.setdefault(AD.canon(col), col)
        s.add_clause([-var(v, col[v], k) for v in range(n)])
allc = list(seen.values())
add = sum(1 for cv in allc if AD.canon(cv) in parts)
print(f"[G] {models} models, {len(allc)} five-colourings up to palette (paper: 18) [{time.time() - t0:.0f}s]; additive among them: {add} of {len(allc)}; additive colourings not among them: {sum(1 for p in parts if p not in seen)}")
json.dump(dict(kind="additive-seed-G", stage=ch.header(), k=5, unit_edges=len(units), cheats=len(cheats), homs=len(homs), additive_partitions=len(parts),
               colourings_up_to_palette=len(allc), models=models, additive_among_colourings=add, colourings=allc,
               claim_scope="all proper 5-colourings of G's unit ∪ distance-2 edges by SAT blocking under the exactly-one encoding with vertex 0 pinned, one per palette orbit; additivity = partition equality with an admissible Z/5-hom of the unit lattice"),
          open("data/m56/seed-G-additive-k5.json", "w"), indent=1)
print("[G] wrote data/m56/seed-G-additive-k5.json")
