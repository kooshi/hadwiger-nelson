"""M56 B2: every proper 5-colouring of the E–I {1,2}-seed up to palette, DUMPED (m54_nu_exact_seed.py + the colourings).
Writes data/m56/colourings-EI-seed-12graph-k5.json with the unit-part stage fingerprint additive.py uses."""
import sys, json, time
sys.path.insert(0, 'tools')
from five_dial import load_stage, colour_clauses, var, decode, verify_proper
from rigidity import amo_clauses
from pysat.solvers import Solver
import additive as AD
class A: seed = True
st = load_stage(A()); n, E, k = st.n, st.edges, 5
unit = AD.load_seed()
cl = colour_clauses(n, E, k) + amo_clauses(n, k) + [[var(0, 0, k)]]
seen = {}; t0 = time.time(); models = 0
with Solver(name="cadical153", bootstrap_with=cl) as s:
    while s.solve():
        col = decode(s.get_model(), n, k); assert verify_proper(col, E) is None; models += 1
        names = {}; canon = tuple(names.setdefault(c, len(names)) for c in col)
        if canon not in seen:
            seen[canon] = list(canon)
        s.add_clause([-var(v, col[v], k) for v in range(n)])
        if models % 100 == 0: print(f"[dump] {models} models, {len(seen)} classes [{time.time()-t0:.0f}s]", flush=True)
cols = list(seen.values())
mins = sorted(min(c.count(x) for x in range(k)) for c in cols)
print(f"[dump] E–I seed: {models} models, {len(cols)} colourings up to palette; min class sizes {mins} [{time.time()-t0:.0f}s]", flush=True)
json.dump(dict(kind="colourings", stage=st.header(), graph_fingerprint=st.fingerprint(), stage_fingerprint=unit.fingerprint(),
               stage_note="vertex order = twodist.ei_H() (both the {1,2}-graph stage and additive.py's unit-part stage); stage_fingerprint is the UNIT-part stage's, graph_fingerprint the {1,2}-graph's",
               k=5, models=models, colourings=cols, min_class_sizes=mins,
               claim_scope="all proper 5-colourings of unit ∪ cheats enumerated by blocking clauses under the exactly-one encoding with vertex 0 pinned; one representative per palette orbit (first-occurrence canonical form)"),
          open('data/m56/colourings-EI-seed-12graph-k5.json', 'w'), indent=1)
print("[dump] wrote data/m56/colourings-EI-seed-12graph-k5.json")
