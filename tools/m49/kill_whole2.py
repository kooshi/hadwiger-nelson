"""Whole-set test at depth two: candidate set = P1 (all 9,271 depth-one points) ∪ P2s (42,868
intersections about seed ∪ the 284 strong depth-one points). Per surviving colouring: list-colour the
whole set (lists from seed neighbours; all unit edges among the set). Feasible ⇒ no subset of it kills
that colouring."""
import sys, json, glob, time, math
from bisect import bisect_left
from collections import defaultdict
sys.path.insert(0, "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad")
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import importlib.util
spec = importlib.util.spec_from_file_location("ks", "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad/kill_screen.py")
ks = importlib.util.module_from_spec(spec); _argv = sys.argv; sys.argv = ["x"]; spec.loader.exec_module(ks); sys.argv = _argv
import forcer
K = 5; FULL = 31
t0 = time.time()
P2, NB2s, NB2p, strong = ks.depth_two_points(3)
ALL = ks.P1 + P2
NBall = ks.NB + NB2s           # seed neighbours for every point
UP = ks.unit_pairs(ALL)
print(f"union set: {len(ALL)} points ({len(ks.P1)} depth-one + {len(P2)} depth-two), unit pairs among them {len(UP)}  [{time.time()-t0:.0f}s]", flush=True)
def feasible(col):
    cls = []
    for i, N in enumerate(NBall):
        used = 0
        for v in N: used |= 1 << col[v]
        av = FULL & ~used
        if av == 0: return False
        cls.append([i*K + c + 1 for c in range(K) if av >> c & 1])
    for a, b in UP:
        for c in range(K): cls.append([-(a*K + c + 1), -(b*K + c + 1)])
    st, _ = forcer._solve(cls, len(ALL)*K, 3600); assert st in ("sat", "unsat"), st; return st == "sat"
design = json.load(open("/home/kooshi/source/lean-dir/build/m49-kill-design.json"))
for f in sorted(glob.glob("/home/kooshi/source/lean-dir/build/m49-sep-*.json")):
    d = json.load(open(f)); e = tuple(d["edge"]); cols = d["colourings"]
    surv = design.get(str(e), {}).get("surviving", [])
    if not surv: print(f"edge {e}: killed at depth one"); continue
    t = time.time(); res = [feasible(cols[t_]) for t_ in surv]
    print(f"edge {e}: {sum(res)} of {len(surv)} depth-one-surviving colourings ALSO survive the depth-two union set  [{time.time()-t:.0f}s]", flush=True)
