"""Kill DESIGN, per colouring. Feasibility of a halo under a colouring is monotone (more points, more
constraints), so a halo kills e iff it kills every c in S_e, and kill(e) = UNION over c of kill(c).
Per colouring c the seed's colours are FIXED, so we can propagate: depth-one points get lists (colours
unused on their seed neighbourhood); a depth-two point r (unit-distant from >= 2 of seed ∪ depth-one)
is a kill of c iff the small CSP on {r} ∪ (its depth-one neighbours) is infeasible — in particular if
its seed neighbour and >= 4 singleton-list depth-one neighbours block all five colours.
For each refuser: which colourings survive depth one (from kill_whole), and for those, search
depth-two kill points. Then assemble a union halo, shrink it by ddmin (lookup oracle), report."""
import sys, json, glob, time, math, itertools
from bisect import bisect_left
from collections import defaultdict, Counter
sys.path.insert(0, "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad")
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import importlib.util
spec = importlib.util.spec_from_file_location("ks", "/tmp/claude-1000/-home-kooshi-source-lean-dir/d9176a06-7fb8-4bef-8c95-f31533521ed4/scratchpad/kill_screen.py")
ks = importlib.util.module_from_spec(spec); _argv = sys.argv; sys.argv = ["x"]; spec.loader.exec_module(ks); sys.argv = _argv
import forcer
K = 5; FULL = 31
P1, NB, xy = ks.P1, ks.NB, ks.xy
UP = ks.unit_pairs(P1)
adj1 = defaultdict(set)
for a, b in UP: adj1[a].add(b); adj1[b].add(a)
def list_col_feasible(idxs, avail):
    loc = {p: i for i, p in enumerate(idxs)}; cls = []
    for p in idxs:
        i = loc[p]; av = avail[p]
        if av == 0: return False
        cls.append([i*K + c + 1 for c in range(K) if av >> c & 1])
    for a in idxs:
        for b in adj1[a]:
            if b in loc and b > a:
                for c in range(K): cls.append([-(loc[a]*K + c + 1), -(loc[b]*K + c + 1)])
    st, _ = forcer._solve(cls, len(idxs)*K, 600); assert st in ("sat", "unsat"); return st == "sat"

def depth2_kills_for_colouring(col, verbose=False):
    """under the fixed seed colouring `col`: lists for P1; forced set F (singleton lists); candidate
    depth-two points = intersections about pairs from seed ∪ (P1 with |list| <= 2); a candidate kills
    iff CSP({r} ∪ small-list P1 neighbours) infeasible. Returns list of (r_xy, [P1 nbr idxs], seed nbrs)."""
    avail = []
    for N in NB:
        used = 0
        for v in N: used |= 1 << col[v]
        avail.append(FULL & ~used)
    small = [p for p in range(len(P1)) if bin(avail[p]).count("1") <= 2]
    F = [p for p in small if bin(avail[p]).count("1") == 1]
    base = xy + [P1[p] for p in small]; tag = [("s", i) for i in range(len(xy))] + [("p", p) for p in small]
    cands = ks.partners(base)
    seen = {(round(x, 6), round(y, 6)) for x, y in xy} | {(round(x, 6), round(y, 6)) for x, y in P1}
    cands = [(x, y) for x, y in cands if (round(x, 6), round(y, 6)) not in seen]
    # neighbours among seed and small P1
    s1 = sorted((P1[p][0], p) for p in small)
    def small_nbrs(x, y):
        out = []; lo = bisect_left(s1, (x-1-1e-6, -1))
        for k in range(lo, len(s1)):
            px, p = s1[k]
            if px > x+1+1e-6: break
            if abs((px-x)**2 + (P1[p][1]-y)**2 - 1) < 1e-7: out.append(p)
        return out
    kills = []
    for x, y in cands:
        sn = ks.seed_nbrs(x, y); pn = small_nbrs(x, y)
        if len(pn) + len(sn) < 4: continue
        used = 0
        for v in sn: used |= 1 << col[v]
        avr = FULL & ~used
        # CSP: r (list avr) + pn (their lists) with edges r–pn and pn–pn (unit)
        idx = {p: i+1 for i, p in enumerate(pn)}
        avails = [avr] + [avail[p] for p in pn]
        adj = defaultdict(list)
        for p in pn:
            adj[0].append(idx[p]); adj[idx[p]].append(0)
            for q in pn:
                if q > p and q in adj1[p]: adj[idx[p]].append(idx[q]); adj[idx[q]].append(idx[p])
        if not ks.csp_feasible(avails, adj):
            kills.append(((x, y), pn, sn))
    return kills, len(cands), len(small), len(F)

if __name__ == "__main__":
    files = sorted(glob.glob("/home/kooshi/source/lean-dir/build/m49-sep-*.json"))
    report = {}
    for f in files:
        d = json.load(open(f)); e = tuple(d["edge"]); cols = d["colourings"]
        AV = [ks.avail_masks(cols, N) for N in NB]
        allidx = list(range(len(P1)))
        t0 = time.time()
        surv = [t for t in range(len(cols)) if list_col_feasible(allidx, [AV[p][t] for p in allidx])]
        line = f"edge {e} ({len(cols)} col): {len(surv)} colourings survive depth one;"
        per = {}
        for t in surv:
            kills, ncand, nsmall, nF = depth2_kills_for_colouring(cols[t])
            per[t] = len(kills)
            line += f" c{t}: small-list depth-1 points {nsmall} (forced {nF}), depth-2 candidates {ncand}, DEPTH-2 KILLS {len(kills)};"
        print(line + f"  [{time.time()-t0:.0f}s]", flush=True)
        report[str(e)] = {"surviving": surv, "depth2_kills_per_colouring": per}
    json.dump(report, open("/home/kooshi/source/lean-dir/build/m49-kill-design.json", "w"))
