"""Depth-one single-point kill census for the 17 refusing lower-bound edges: for each refuser e and
each of the 51 candidate points p (non-seed intersections of unit circles about seed pairs with >= 5
seed neighbours — the COMPLETE list of points, in ANY field, that could be uncolourable at five
colours with only seed neighbours), ask: is there a proper 5-colouring of H − e with A ≠ B in which
N(p) misses some colour (palette-WLOG: misses colour 4)? UNSAT = p kills e. A refuser with no killer
among the 51 has NO single-point depth-one kill in any field whatsoever."""
import sys, json, time, math
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import twodist as T, coloring, rigidity, forcer, mechanism
mechanism.WORKERS = 28
H = T.ei_H(); n = len(H); c = T.classify(H); E1, E2 = c[1], c[4]; K = 5
iA, iB = H.index(T.EI_A), H.index(T.EI_B)
xy = [T.approx(p) for p in H]
cen = json.load(open("/home/kooshi/source/lean-dir/build/m49-seed-edges.json"))
lb = [tuple(e) for e in [r for r in cen["rows"] if r["kind"]=="single-deletion-census"][-1]["essential_alone"]]
desc = json.load(open("/home/kooshi/source/lean-dir/build/m49-descent5.json"))
removed = set(tuple(r["target"]) for r in desc["rows"] if r.get("label")=="seed-k5-lb" and r.get("verdict")=="removed")
refusers = [e for e in lb if e not in removed]
assert len(refusers) == 17
big = json.load(open("/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad/kill_census.json"))["big"]
def nbrs(x, y): return [i for i, p in enumerate(xy) if abs((p[0]-x)**2 + (p[1]-y)**2 - 1) < 1e-7]
cands = [(x, y, nbrs(x, y)) for x, y, key, uv, dg in big]
print(f"{len(refusers)} refusers × {len(cands)} candidates", flush=True)
ne = [[-coloring.var(iA, k, K), -coloring.var(iB, k, K)] for k in range(K)]
def ask(args):
    e, ci = args
    x, y, N = cands[ci]
    base = coloring.base_clauses(n, E1 + [f for f in E2 if f != e], K) + rigidity.amo_clauses(n, K)
    avoid = [[-coloring.var(v, 4, K)] for v in N]
    st, _ = forcer._solve(base + ne + avoid, n * K, 900)
    return (e, ci, st)
t0 = time.time()
jobs = [(e, ci) for e in refusers for ci in range(len(cands))]
res = mechanism.pmap(ask, jobs)
out = {}
for e, ci, st in res:
    out.setdefault(str(e), {})[ci] = st
summary = {}
for e in refusers:
    sts = out[str(e)]
    kills = [ci for ci, st in sts.items() if st == "unsat"]; unk = [ci for ci, st in sts.items() if st == "unknown"]
    summary[str(e)] = {"kills": kills, "unknown": len(unk), "sat": sum(1 for st in sts.values() if st == "sat")}
    print(f"edge {e}: {len(kills)} single-point kills, {len(unk)} unknown, {summary[str(e)]['sat']} sat", flush=True)
print(f"done in {time.time()-t0:.0f}s", flush=True)
json.dump({"candidates": [(x, y, N) for x, y, N in cands], "results": summary, "cap": 900,
           "claim_scope": "depth-one single-point kill census on the seventeen refusing lower-bound edges: candidates are ALL non-seed points at unit distance from >= 5 seed vertices (intersections of unit circles about seed pairs; complete for any field); unsat = the candidate's neighbourhood is forced rainbow in every separating 5-colouring of H − e, so adding it kills the edge; tools-side, float geometry with 1e-7 tolerance for the candidate list (a pool is a choice, not a claim)"},
          open("/home/kooshi/source/lean-dir/build/m49-kill-census.json", "w"))
