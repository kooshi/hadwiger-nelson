"""The lookup screen. For a refusing edge e with its exact list S_e of separating 5-colourings of
H − e (up to palette), a candidate HALO (a set of new points with their unit adjacencies to the seed
and to each other) kills e iff under EVERY colouring in S_e the halo's tiny colouring problem is
infeasible. Candidates come from the partner lattice: depth-one points = intersections of unit
circles about seed pairs (complete for single-point kills), and pairs/triples of them that are
mutually unit-distant. No solver: bit masks over S_e. Any kill found is then CERTIFIED by the
standard route (UNSAT with the halo added, second encoding, minimality) — separately.
"""
import sys, json, math, itertools, time
from bisect import bisect_left
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import twodist as T
from collections import Counter, defaultdict

H = T.ei_H(); n = len(H)
xy = [T.approx(p) for p in H]
c = T.classify(H); E1, E2 = c[1], c[4]
K = 5; FULL = (1 << K) - 1

# ---- depth-one partner points (both intersections of unit circles about every seed pair with |uv|<2)
def partners(points):
    cands = []
    for u in range(len(points)):
        for v in range(u + 1, len(points)):
            dx, dy = points[v][0]-points[u][0], points[v][1]-points[u][1]; d2 = dx*dx+dy*dy
            if d2 >= 4 - 1e-9 or d2 < 1e-12: continue
            h = math.sqrt(1 - d2/4); mx, my = (points[u][0]+points[v][0])/2, (points[u][1]+points[v][1])/2
            d = math.sqrt(d2); ux, uy = -dy/d, dx/d
            for s in (1, -1): cands.append((mx + s*h*ux, my + s*h*uy))
    seen = {}; out = []
    for x, y in cands:
        g = (round(x, 6), round(y, 6))
        if g in seen: continue
        seen[g] = 1; out.append((x, y))
    return out

sxy = sorted((p[0], i) for i, p in enumerate(xy))
def seed_nbrs(x, y):
    out = []; lo = bisect_left(sxy, (x-1-1e-6, -1))
    for k in range(lo, len(sxy)):
        px, i = sxy[k]
        if px > x+1+1e-6: break
        if abs((px-x)**2 + (xy[i][1]-y)**2 - 1) < 1e-7: out.append(i)
    return out
def is_seed(x, y): return any(abs(x-p[0]) < 1e-7 and abs(y-p[1]) < 1e-7 for p in xy)

t0 = time.time()
P1 = [(x, y) for x, y in partners(xy) if not is_seed(x, y)]
NB = [seed_nbrs(x, y) for x, y in P1]
print(f"depth-one partner points: {len(P1)} (non-seed); neighbour-count histogram: {sorted(Counter(len(N) for N in NB).items())}  [{time.time()-t0:.1f}s]", flush=True)

# unit adjacency among partner points (grid)
grid = defaultdict(list)
for i, (x, y) in enumerate(P1): grid[(int(math.floor(x)), int(math.floor(y)))].append(i)
def unit_pairs(pts, idxs=None):
    idxs = range(len(pts)) if idxs is None else idxs
    out = []
    g = defaultdict(list)
    for i in idxs: g[(int(math.floor(pts[i][0])), int(math.floor(pts[i][1])))].append(i)
    for i in idxs:
        gx, gy = int(math.floor(pts[i][0])), int(math.floor(pts[i][1]))
        for dx in (-1, 0, 1):
            for dy in (-1, 0, 1):
                for j in g.get((gx+dx, gy+dy), []):
                    if j <= i: continue
                    if abs((pts[i][0]-pts[j][0])**2 + (pts[i][1]-pts[j][1])**2 - 1) < 1e-7: out.append((i, j))
    return out

# ---- the screen for one refuser
def avail_masks(cols, N):
    """for each colouring, the bitmask of colours NOT used on the seed neighbourhood N"""
    out = []
    for col in cols:
        used = 0
        for v in N: used |= 1 << col[v]
        out.append(FULL & ~used)
    return out

def csp_feasible(avails, adj):
    """small CSP: variables 0..m-1 with allowed colour masks `avails` and unit adjacencies `adj`;
    feasible iff some assignment exists (m <= 4: brute force with pruning)"""
    m = len(avails); order = list(range(m)); asg = [None]*m
    def bt(i):
        if i == m: return True
        v = order[i]; mask = avails[v]
        for a in adj.get(v, ()):
            if asg[a] is not None: mask &= ~(1 << asg[a])
        while mask:
            b = mask & -mask; cidx = b.bit_length()-1; mask ^= b
            asg[v] = cidx
            if bt(i+1): return True
        asg[v] = None
        return False
    return bt(0)

def screen(e, cols, want=("single", "pair", "triple")):
    res = {"edge": e, "ncols": len(cols)}
    # per candidate: avail masks per colouring
    AV = [avail_masks(cols, N) for N in NB]
    # singles: kill iff avail == 0 for every colouring
    singles = [i for i in range(len(P1)) if len(NB[i]) >= K and all(a == 0 for a in AV[i])]
    res["singles"] = singles
    # candidates that are "nearly" dead: avail has <= 2 colours in every colouring (potential pair members)
    near = [i for i in range(len(P1)) if all(bin(a).count("1") <= 2 for a in AV[i]) and len(NB[i]) >= 3]
    UP = unit_pairs(P1, near)
    pairs = []
    for i, j in UP:
        if all(not csp_feasible([AV[i][t], AV[j][t]], {0: [1], 1: [0]}) for t in range(len(cols))): pairs.append((i, j))
    res["pairs"] = pairs; res["near"] = len(near); res["near_unit_pairs"] = len(UP)
    # triples: connected triples among near (paths and triangles)
    adjn = defaultdict(set)
    for i, j in UP: adjn[i].add(j); adjn[j].add(i)
    triples = []
    if "triple" in want:
        seen = set()
        for i in adjn:
            for j in adjn[i]:
                for k in adjn[i] | adjn[j]:
                    if k in (i, j): continue
                    key = tuple(sorted((i, j, k)))
                    if key in seen: continue
                    seen.add(key)
                    idx = {key[0]: 0, key[1]: 1, key[2]: 2}
                    adj = defaultdict(list)
                    for a, b in itertools.combinations(key, 2):
                        if b in adjn[a]: adj[idx[a]].append(idx[b]); adj[idx[b]].append(idx[a])
                    if all(not csp_feasible([AV[key[0]][t], AV[key[1]][t], AV[key[2]][t]], adj) for t in range(len(cols))):
                        triples.append(key)
        res["triples"] = triples; res["triples_examined"] = len(seen)
    return res

if __name__ == "__main__":
    import glob
    files = sorted(glob.glob("/home/kooshi/source/lean-dir/build/m49-sep-*.json"))
    allres = {}
    for f in files:
        d = json.load(open(f))
        if not d.get("exact"): print(f"{d['edge']}: NOT exact, skipped"); continue
        e = tuple(d["edge"]); cols = d["colourings"]
        t = time.time(); r = screen(e, cols)
        print(f"edge {e}: {len(cols)} colourings | single kills {len(r['singles'])} | near-dead candidates {r['near']}, unit pairs among them {r['near_unit_pairs']}, pair kills {len(r['pairs'])} | triples examined {r.get('triples_examined')}, triple kills {len(r.get('triples', []))}  [{time.time()-t:.1f}s]", flush=True)
        allres[str(e)] = {**r, "singles_xy": [(P1[i], NB[i]) for i in r["singles"]][:20], "pairs_xy": [((P1[i], NB[i]), (P1[j], NB[j])) for i, j in r["pairs"]][:20], "triples_xy": [[(P1[i], NB[i]) for i in tr] for tr in r.get("triples", [])][:20]}
    json.dump(allres, open("/home/kooshi/source/lean-dir/build/m49-kill-screen.json", "w"))
    print("wrote build/m49-kill-screen.json")

# ------------------------------------------------------------------ exhaustive depth-one pairs/triples + depth-two singles
def screen_exhaustive(e, cols):
    AV = [avail_masks(cols, N) for N in NB]
    T_ = len(cols)
    UPall = unit_pairs(P1)
    pairs = [(i, j) for i, j in UPall if all(not csp_feasible([AV[i][t], AV[j][t]], {0: [1], 1: [0]}) for t in range(T_))]
    adjn = defaultdict(set)
    for i, j in UPall: adjn[i].add(j); adjn[j].add(i)
    # triples: connected, exhaustive over the unit graph on P1
    triples = []; seen = set()
    for i in adjn:
        for j in adjn[i]:
            for k in adjn[i] | adjn[j]:
                if k in (i, j): continue
                key = tuple(sorted((i, j, k)))
                if key in seen: continue
                seen.add(key)
                idx = {key[0]: 0, key[1]: 1, key[2]: 2}; adj = defaultdict(list)
                for a, b in itertools.combinations(key, 2):
                    if b in adjn[a]: adj[idx[a]].append(idx[b]); adj[idx[b]].append(idx[a])
                if all(not csp_feasible([AV[key[0]][t], AV[key[1]][t], AV[key[2]][t]], adj) for t in range(T_)): triples.append(key)
    return {"unit_pairs_all": len(UPall), "pairs": pairs, "triples_examined": len(seen), "triples": triples}

def depth_two_points(min_seed_nbrs=3):
    """intersections of unit circles about (seed ∪ strong depth-one points); returns new points with
    their neighbours among the seed AND among depth-one points"""
    strong = [i for i in range(len(P1)) if len(NB[i]) >= min_seed_nbrs]
    base = xy + [P1[i] for i in strong]
    P2 = partners(base)
    # drop those coinciding with seed or with any depth-one point
    seen = {(round(x, 6), round(y, 6)) for x, y in xy} | {(round(x, 6), round(y, 6)) for x, y in P1}
    P2 = [(x, y) for x, y in P2 if (round(x, 6), round(y, 6)) not in seen]
    # neighbours: seed and depth-one
    s1 = sorted((p[0], i) for i, p in enumerate(P1))
    def p1_nbrs(x, y):
        out = []; lo = bisect_left(s1, (x-1-1e-6, -1))
        for k in range(lo, len(s1)):
            px, i = s1[k]
            if px > x+1+1e-6: break
            if abs((px-x)**2 + (P1[i][1]-y)**2 - 1) < 1e-7: out.append(i)
        return out
    return P2, [seed_nbrs(x, y) for x, y in P2], [p1_nbrs(x, y) for x, y in P2], strong

if __name__ == "__main__" and "--deep" in sys.argv:
    import glob
    files = sorted(glob.glob("/home/kooshi/source/lean-dir/build/m49-sep-*.json"))
    t = time.time(); P2, NB2s, NB2p, strong = depth_two_points(3)
    print(f"depth-two points about seed ∪ {len(strong)} strong depth-one points: {len(P2)}; seed-nbr histogram {sorted(Counter(len(N) for N in NB2s).items())[:8]}; with >=1 depth-one nbr: {sum(1 for N in NB2p if N)}  [{time.time()-t:.0f}s]", flush=True)
    for f in files:
        d = json.load(open(f))
        if not d.get("exact"): continue
        e = tuple(d["edge"]); cols = d["colourings"]; T_ = len(cols)
        t = time.time(); r = screen_exhaustive(e, cols)
        # depth-two singles: point r with >=5 SEED neighbours (its depth-one nbrs are not in the object)
        AV2 = [avail_masks(cols, N) for N in NB2s]
        d2single = [i for i in range(len(P2)) if len(NB2s[i]) >= K and all(a == 0 for a in AV2[i])]
        # depth-two point + one depth-one neighbour as a pair halo
        AV1 = [avail_masks(cols, N) for N in NB]
        d2pairs = []
        for i in range(len(P2)):
            if len(NB2s[i]) < 3: continue
            for j in NB2p[i]:
                if len(NB[j]) < 3: continue
                if all(not csp_feasible([AV2[i][t], AV1[j][t]], {0: [1], 1: [0]}) for t in range(T_)): d2pairs.append((i, j))
        print(f"edge {e} ({T_} col): depth-1 exhaustive — unit pairs {r['unit_pairs_all']}, pair kills {len(r['pairs'])}, triples {r['triples_examined']}, triple kills {len(r['triples'])} | depth-2 single kills {len(d2single)}, depth-2+depth-1 pair kills {len(d2pairs)}  [{time.time()-t:.0f}s]", flush=True)
