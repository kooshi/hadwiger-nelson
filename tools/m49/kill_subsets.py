"""Connected-subset kill search on the strong depth-one partner graph (points with >= 3 seed
neighbours; 284 points, 548 unit edges): every connected subset of size <= MAXK is a candidate halo;
it kills refuser e iff its list-colouring CSP (lists = colours unused on each member's seed
neighbourhood; halo unit edges as ≠ constraints) is infeasible under EVERY separating colouring."""
import sys, json, time, glob, itertools
_MAXK = int(sys.argv[1]) if len(sys.argv) > 1 and sys.argv[1].isdigit() else 5
sys.path.insert(0, "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad")
import importlib.util
spec = importlib.util.spec_from_file_location("ks", "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad/kill_screen.py")
ks = importlib.util.module_from_spec(spec); sys.argv = ["x"]; spec.loader.exec_module(ks)
from collections import defaultdict, Counter
MAXK = _MAXK
MINNB = 3
strong = [i for i in range(len(ks.P1)) if len(ks.NB[i]) >= MINNB]
sidx = {p: k for k, p in enumerate(strong)}
UP = ks.unit_pairs(ks.P1, strong)
adj = defaultdict(set)
for i, j in UP: adj[sidx[i]].add(sidx[j]); adj[sidx[j]].add(sidx[i])
m = len(strong)
# enumerate connected subsets with a canonical minimum vertex (all others larger than the root)
def connected_subsets(maxk):
    for root in range(m):
        # extension search: subset S (sorted list), candidates = neighbours of S greater than root not in S
        def grow(S, cand, excl):
            yield tuple(S)
            if len(S) == maxk: return
            cand = list(cand)
            for idx, v in enumerate(cand):
                newexcl = excl | set(cand[:idx+1])
                newcand = [w for w in (set(cand[idx+1:]) | (adj[v] - newexcl)) if w > root and w not in S and w not in newexcl]
                yield from grow(S + [v], sorted(set(newcand)), newexcl)
        yield from grow([root], sorted(w for w in adj[root] if w > root), {root})
files = sorted(glob.glob("/home/kooshi/source/lean-dir/build/m49-sep-*.json"))
edges = [(tuple(json.load(open(f))["edge"]), json.load(open(f))["colourings"]) for f in files]
AVs = {}
for e, cols in edges:
    AVs[e] = [ks.avail_masks(cols, ks.NB[p]) for p in strong]
t0 = time.time(); count = Counter(); kills = defaultdict(list)
for S in connected_subsets(MAXK):
    count[len(S)] += 1
    if len(S) < 2: continue
    loc = {v: k for k, v in enumerate(S)}
    adjS = {loc[v]: [loc[w] for w in adj[v] if w in loc] for v in S}
    for e, cols in edges:
        AV = AVs[e]
        ok = True
        for t in range(len(cols)):
            if ks.csp_feasible([AV[v][t] for v in S], adjS): ok = False; break
        if ok: kills[e].append(S)
print(f"connected subsets by size: {sorted(count.items())}  [{time.time()-t0:.0f}s]", flush=True)
for e, cols in edges:
    print(f"edge {e} ({len(cols)} col): {len(kills[e])} halo kills of size <= {MAXK}", flush=True)
json.dump({str(e): [[strong[v] for v in S] for S in kills[e]] for e, _ in edges}, open(f"/home/kooshi/source/lean-dir/build/m49-kill-subsets-{MAXK}.json", "w"))
