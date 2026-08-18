"""Whole-pool test at depth one: does the ENTIRE depth-one partner set (9,271 points, all their unit
adjacencies to each other and to the seed) kill refuser e? Per separating colouring c the question is
a list-colouring of the partner graph (lists = colours unused on each point's seed neighbourhood):
if it is FEASIBLE for some c, no subset of the partner set kills e (a superset has fewer colourings,
so feasibility is monotone the wrong way for us: a subset is easier to colour) — a COMPLETE depth-one
negative. If infeasible for every c, the whole set is a kill and we shrink it (ddmin, oracle = these
list-colourings) to a 1-minimal halo."""
import sys, json, glob, time
sys.path.insert(0, "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad")
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import importlib.util
spec = importlib.util.spec_from_file_location("ks", "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad/kill_screen.py")
ks = importlib.util.module_from_spec(spec); _argv = sys.argv; sys.argv = ["x"]; spec.loader.exec_module(ks); sys.argv = _argv
import forcer, mechanism
K = 5
P1, NB = ks.P1, ks.NB
UP = ks.unit_pairs(P1)
print(f"partner set: {len(P1)} points, {len(UP)} unit pairs among them", flush=True)
def list_col_feasible(idxs, cols_t_avail):
    """idxs: subset of P1 (as sorted list); cols_t_avail: avail mask per P1 index for ONE colouring.
    SAT: var(i,c) = i*5+c+1 for local index i."""
    loc = {p: i for i, p in enumerate(idxs)}
    cls = []
    for p in idxs:
        i = loc[p]; av = cols_t_avail[p]
        if av == 0: return False
        cls.append([i*K + c + 1 for c in range(K) if av >> c & 1])
    for a, b in UP:
        if a in loc and b in loc:
            for c in range(K):
                cls.append([-(loc[a]*K + c + 1), -(loc[b]*K + c + 1)])
    st, _ = forcer._solve(cls, len(idxs)*K, 600)
    assert st in ("sat", "unsat"), st
    return st == "sat"
files = sorted(glob.glob("/home/kooshi/source/lean-dir/build/m49-sep-*.json"))
allidx = list(range(len(P1)))
for f in files:
    d = json.load(open(f)); e = tuple(d["edge"]); cols = d["colourings"]
    AV = [ks.avail_masks(cols, N) for N in NB]   # AV[p][t]
    t0 = time.time()
    feas = [list_col_feasible(allidx, [AV[p][t] for p in allidx]) for t in range(len(cols))]
    verdict = "KILL (whole depth-one set)" if not any(feas) else f"no depth-one kill exists ({sum(feas)} of {len(cols)} colourings survive the whole set)"
    print(f"edge {e} ({len(cols)} col): {verdict}  [{time.time()-t0:.0f}s]", flush=True)
