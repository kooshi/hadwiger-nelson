"""Shrink the depth-two union-set kills to 1-minimal halos with the lookup oracle (per colouring a
list-colouring SAT on the subset). Edges: those whose every separating colouring dies on the union set."""
import sys, json, glob, time, math
from collections import defaultdict
sys.path.insert(0, "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad")
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import importlib.util
spec = importlib.util.spec_from_file_location("ks", "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad/kill_screen.py")
ks = importlib.util.module_from_spec(spec); _argv = sys.argv; sys.argv = ["x"]; spec.loader.exec_module(ks); sys.argv = _argv
import forcer, mechanism
mechanism.WORKERS = 16
K = 5; FULL = 31
t0 = time.time()
P2, NB2s, NB2p, strong = ks.depth_two_points(3)
ALL = ks.P1 + P2; NBall = ks.NB + NB2s
UP = ks.unit_pairs(ALL)
adj = defaultdict(set)
for a, b in UP: adj[a].add(b); adj[b].add(a)
print(f"union set {len(ALL)} points, {len(UP)} unit pairs [{time.time()-t0:.0f}s]", flush=True)
def feasible_subset(Q, col):
    Qs = set(Q); loc = {p: i for i, p in enumerate(Q)}; cls = []
    for p in Q:
        used = 0
        for v in NBall[p]: used |= 1 << col[v]
        av = FULL & ~used
        if av == 0: return False
        cls.append([loc[p]*K + c + 1 for c in range(K) if av >> c & 1])
    for a in Q:
        for b in adj[a]:
            if b in Qs and b > a:
                for c in range(K): cls.append([-(loc[a]*K + c + 1), -(loc[b]*K + c + 1)])
    st, _ = forcer._solve(cls, len(Q)*K, 1800); assert st in ("sat", "unsat"), st; return st == "sat"
def kills(Q, cols):
    return all(not feasible_subset(Q, col) for col in cols)
def ddmin(Q, cols):
    core = list(Q); chunk = max(1, len(core)//2)
    while core and chunk >= 1:
        pieces = [core[i:i+chunk] for i in range(0, len(core), chunk)]
        base = list(core)
        res = mechanism.pmap(lambda pc: kills([v for v in base if v not in set(pc)], cols), pieces)
        passing = [pc for pc, ok in zip(pieces, res) if ok]
        accepted = []
        if passing:
            union = set().union(*map(set, passing))
            if kills([v for v in core if v not in union], cols): core = [v for v in core if v not in union]; accepted = sorted(union)
            else:
                for pc in passing:
                    if kills([v for v in core if v not in set(pc)], cols): core = [v for v in core if v not in set(pc)]; accepted += pc
        if not accepted:
            if chunk == 1: break
            chunk = max(1, chunk//2)
        print(f"    chunk {chunk}: |core| = {len(core)}", flush=True)
    return core
targets = [(40,206), (56,168), (56,78), (77,94)]
out = {}
for e in targets:
    d = json.load(open(f"/home/kooshi/source/lean-dir/build/m49-sep-{e[0]}-{e[1]}.json")); cols = d["colourings"]
    # start from a radius-restricted subset if it already kills, else the whole set
    a0, b0 = ks.xy[e[0]], ks.xy[e[1]]; mx, my = (a0[0]+b0[0])/2, (a0[1]+b0[1])/2
    Q = None
    for R in (2.0, 3.0, 4.5, None):
        cand = list(range(len(ALL))) if R is None else [i for i in range(len(ALL)) if (ALL[i][0]-mx)**2 + (ALL[i][1]-my)**2 <= R*R]
        t = time.time(); ok = kills(cand, cols)
        print(f"edge {e}: radius {R} → {len(cand)} points: {'KILL' if ok else 'no'} [{time.time()-t:.0f}s]", flush=True)
        if ok: Q = cand; break
    assert Q is not None
    t = time.time(); core = ddmin(Q, cols)
    assert kills(core, cols)
    nec = [not kills([v for v in core if v != w], cols) for w in core]
    print(f"edge {e}: 1-minimal halo of {len(core)} points ({sum(nec)} necessary of {len(core)}) [{time.time()-t:.0f}s]", flush=True)
    info = []
    for w in core:
        kind = "depth1" if w < len(ks.P1) else "depth2"
        info.append({"xy": ALL[w], "kind": kind, "seed_nbrs": NBall[w], "halo_nbrs": [core.index(u) for u in adj[w] if u in core]})
        print(f"    {kind} at ({ALL[w][0]:.4f},{ALL[w][1]:.4f}): seed nbrs {NBall[w]}, halo nbrs {[core.index(u) for u in adj[w] if u in core]}")
    out[str(e)] = info
json.dump(out, open("/home/kooshi/source/lean-dir/build/m49-kill-halos-2.json", "w"))
