"""The kill engine (M49 §R8–§R9): the two-distance descent with the solver taken out of the loop.

For a refusing distance-2 edge `e` of a forced-pair carrier `H` (here Exoo–Ismailescu's 214-point
seed at five colours), the separating colourings of `H − e` are FEW (2–19 up to palette; enumerate
them exactly once by blocking clauses). A unit halo kills `e` iff its list-colouring problem — lists
= colours unused on each halo point's seed neighbourhood, halo unit edges as ≠ — is infeasible under
EVERY listed colouring: bit masks and tiny SATs, no forcing asks. Candidate points are the partner
lattice: depth one = intersections of unit circles about seed pairs (complete for any field: a point
with ≥ 2 seed neighbours is one of them), depth two = intersections about seed ∪ depth-one points.
Feasibility is monotone in the point set, so a whole-set test decides a depth completely, and a kill
shrinks by ddmin under the lookup oracle. A designed halo is then certified the standard way: exact
sympy coordinates from its defining circle pairs, every unit edge exact (10-s simplify budget, else
200-digit numeric, LABELLED), two solver encodings on the real object, the row recorded.
Nothing here is trusted; every claim reaches a row with its scope sentence.

Pieces (as functions; the campaign scripts in plans/M49 §R8–§R9 drive them):
  partners / seed_nbrs / unit_pairs / depth_two_points   — the candidate lattice (float, 1e-7)
  avail_masks / csp_feasible / screen / screen_exhaustive — small-halo screens
  list_col_feasible / kills_all / ddmin_lookup            — whole-set tests and the lookup shrink
  seed_exact / intersect / is_unit                        — exact geometry for designed points
"""
import sys, json, math, itertools, time
from bisect import bisect_left
sys.path.insert(0, str(__import__("pathlib").Path(__file__).resolve().parent))
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
P1_INFO = f"depth-one partner points: {len(P1)} (non-seed); neighbour-count histogram: {sorted(Counter(len(N) for N in NB).items())}"

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


# ------------------------------------------------------------------ whole-set list-colouring and the lookup shrink
def list_col_feasible(idxs, avail, adj):
    """list-colouring SAT on the subset `idxs` of a point set with per-point avail masks and adjacency"""
    import forcer
    loc = {p: i for i, p in enumerate(idxs)}; cls = []
    for p in idxs:
        av = avail[p]
        if av == 0: return False
        cls.append([loc[p]*K + c + 1 for c in range(K) if av >> c & 1])
    for a in idxs:
        for b in adj[a]:
            if b in loc and b > a:
                for c in range(K): cls.append([-(loc[a]*K + c + 1), -(loc[b]*K + c + 1)])
    st, _ = forcer._solve(cls, len(idxs)*K, 3600); assert st in ("sat", "unsat"), st; return st == "sat"

def avail_for(cols, NBset):
    """avail[p][t] masks for a point set with seed-neighbour lists NBset over colourings cols"""
    return [avail_masks(cols, N) for N in NBset]

def kills_all(Q, cols, AV, adj):
    return all(not list_col_feasible(Q, [AV[p][t] for p in range(len(AV))], adj) for t in range(len(cols)))

def ddmin_lookup(Q, cols, AV, adj, log=print):
    """parallel ddmin of a killing point set under the lookup oracle"""
    import mechanism
    core = list(Q); chunk = max(1, len(core)//2)
    while core and chunk >= 1:
        pieces = [core[i:i+chunk] for i in range(0, len(core), chunk)]; base = list(core)
        rr = mechanism.pmap(lambda pc: kills_all([v for v in base if v not in set(pc)], cols, AV, adj), pieces)
        passing = [pc for pc, ok in zip(pieces, rr) if ok]; accepted = []
        if passing:
            union = set().union(*map(set, passing))
            if kills_all([v for v in core if v not in union], cols, AV, adj): core = [v for v in core if v not in union]; accepted = sorted(union)
            else:
                for pc in passing:
                    if kills_all([v for v in core if v not in set(pc)], cols, AV, adj): core = [v for v in core if v not in set(pc)]; accepted += pc
        if not accepted:
            if chunk == 1: break
            chunk = max(1, chunk//2)
        log(f"    chunk {chunk}: |core| = {len(core)}")
    return core

# ------------------------------------------------------------------ exact geometry (sympy)
import sympy as sp
import signal
s3, s11, s33 = sp.sqrt(3), sp.sqrt(11), sp.sqrt(33)
def seed_exact(p):
    a, b, c, d = [sp.Rational(x.numerator, x.denominator) for x in p]
    return sp.Matrix([(a*s3 + b*s11)/12, (c + d*s33)/12])
def intersect(U, V, sign):
    D = V - U; d2 = sp.expand(D.dot(D))
    M = (U + V)/2
    R = sp.sqrt(4/d2 - 1)             # p = M ± ½ R (−Dy, Dx)
    P = M + sign*sp.Rational(1, 2)*R*sp.Matrix([-D[1], D[0]])
    return P
class _TO(Exception): pass
def _alarm(signum, frame): raise _TO()
def is_unit(P, W, budget=10):
    """exact (sympy simplify to 0, `budget` seconds) else 200-digit numeric agreement, labelled."""
    D = P - W; expr = sp.expand(D.dot(D) - 1)
    zn = sp.N(expr, 200)
    if abs(zn) > sp.Rational(1, 10**150): return False, "no"
    signal.signal(signal.SIGALRM, _alarm); signal.alarm(budget)
    try:
        z = sp.simplify(expr); signal.alarm(0)
        if z == 0: return True, "exact"
    except _TO:
        pass
    signal.alarm(0)
    return True, "numeric-200"

if __name__ == "__main__":
    print(P1_INFO)
    print("self-test: seed unit pair exact:", is_unit(seed_exact(H[E1[0][0]]), seed_exact(H[E1[0][1]])))
