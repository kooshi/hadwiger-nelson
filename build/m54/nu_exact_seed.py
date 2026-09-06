import sys, json, time
sys.path.insert(0,'tools')
from five_dial import load_stage, colour_clauses, var, decode, verify_proper
from rigidity import amo_clauses
from pysat.solvers import Solver
class A: seed=True
st = load_stage(A()); n, E, k = st.n, st.edges, 5
cl = colour_clauses(n, E, k) + amo_clauses(n, k) + [[var(0,0,k)]]
seen=set(); mins=[]; t0=time.time(); models=0
with Solver(name="cadical153", bootstrap_with=cl) as s:
    while s.solve():
        col = decode(s.get_model(), n, k); assert verify_proper(col, E) is None; models += 1
        names={}; canon=tuple(names.setdefault(c,len(names)) for c in col)
        if canon not in seen:
            seen.add(canon); mins.append(min(col.count(c) for c in range(k)))
        s.add_clause([-var(v, col[v], k) for v in range(n)])
        if models % 100 == 0: print(f"[nu-exact] {models} models, {len(seen)} classes [{time.time()-t0:.0f}s]", flush=True)
print(f"[nu-exact] E–I seed: {models} models, {len(seen)} proper 5-colourings up to palette; smallest colour class over them: min {min(mins)}, max {max(mins)}; ν(H) = {min(mins)} [{time.time()-t0:.0f}s]", flush=True)
json.dump(dict(kind="nu-exact", stage=st.header(), k=5, models=models, colourings_up_to_palette=len(seen), nu=min(mins), min_class_sizes=sorted(mins),
               claim_scope="all proper 5-colourings enumerated by blocking clauses under the exactly-one encoding with vertex 0 pinned; deduplicated up to palette by first-occurrence canonical form; ν = the least colour-class size"),
          open('data/m54/nu-exact-EI-seed-12graph.json','w'), indent=1)
print("[nu-exact] wrote data/m54/nu-exact-EI-seed-12graph.json")
