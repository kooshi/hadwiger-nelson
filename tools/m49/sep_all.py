"""Enumerate, exactly and up to palette, the separating 5-colourings of H − e for every refusing
lower-bound edge e (the colourings a kill must destroy). Parallel over edges."""
import sys, json, time
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import twodist as T, coloring, rigidity, forcer, mechanism
mechanism.WORKERS = 8
H = T.ei_H(); n = len(H); c = T.classify(H); E1, E2 = c[1], c[4]; K = 5
iA, iB = H.index(T.EI_A), H.index(T.EI_B)
cen = json.load(open("/home/kooshi/source/lean-dir/build/m49-seed-edges.json"))
lb = [tuple(e) for e in [r for r in cen["rows"] if r["kind"]=="single-deletion-census"][-1]["essential_alone"]]
desc = json.load(open("/home/kooshi/source/lean-dir/build/m49-descent5.json"))
removed = set(tuple(r["target"]) for r in desc["rows"] if r.get("label")=="seed-k5-lb" and r.get("verdict")=="removed")
refusers = [e for e in lb if e not in removed]
ne = [[-coloring.var(iA, k, K), -coloring.var(iB, k, K)] for k in range(K)]
def enum(e):
    import os
    out = f"/home/kooshi/source/lean-dir/build/m49-sep-{e[0]}-{e[1]}.json"
    if os.path.exists(out):
        d = json.load(open(out))
        if d.get("exact"): return e, len(d["colourings"]), True, 0.0
    edges = E1 + [f for f in E2 if f != e]
    cls = coloring.base_clauses(n, edges, K) + rigidity.amo_clauses(n, K) + T._brk_full(n, K, T._degree_order(n, edges)) + ne
    found = []; t = time.time(); exact = False
    while len(found) < 50000:
        st, model = forcer._solve(cls, n * K, 1800)
        if st == "unsat": exact = True; break
        if st != "sat": break
        col = rigidity.decode(model, n, K); found.append(col)
        cls.append([-coloring.var(v, col[v], K) for v in range(n)])
    json.dump({"edge": e, "colourings": found, "exact": exact, "seconds": round(time.time()-t,1)}, open(out, "w"))
    return e, len(found), exact, time.time()-t
for e, m, exact, dt in mechanism.pmap(enum, refusers):
    print(f"refuser {e}: {m} separating colourings ({'exact' if exact else 'CAPPED'}) {dt:.0f}s", flush=True)
