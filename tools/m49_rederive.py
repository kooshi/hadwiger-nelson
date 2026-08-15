"""Re-derive the Exoo–Ismailescu 6-chromatic {1,2}-graph (arXiv:1909.13177) exactly, from the
paper's data alone, and check every count it claims. Points are [a,b,c,d] := ((a√3+b√11)/12, (c+d√33)/12)
with a,b,c,d rational (integers in the paper; halves after the π/3 rotation; fiftieths after the spindle
rotation). Everything is exact: squared distance = (3α²+11β²+γ²+33δ² + 2(αβ+γδ)√33)/144, so
dist² = r  ⟺  3α²+11β²+γ²+33δ² = 144 r  ∧  αβ+γδ = 0.
"""
from fractions import Fraction as F
import itertools, subprocess, sys, os, time

S = [(0,0,0,0),(0,0,0,-4),(0,0,-6,-2),(0,0,-6,2),(-6,0,0,-2),(-4,0,0,0),(-4,0,-6,-2),(-4,0,-6,2),
     (-2,0,0,-2),(-2,0,-6,-4),(-2,0,-6,4),(0,-6,-6,0),(-5,-3,3,3),(-5,3,-3,3),(-2,-6,0,0),
     (-2,-6,0,-4),(-2,6,0,0),(-2,6,0,-4),(-6,-6,0,0),(-6,6,0,0),(-4,0,0,-4),(0,0,-12,0),(-8,0,0,0)]
assert len(S) == 23
S = [tuple(F(x) for x in p) for p in S]

def refl_x(p): a,b,c,d = p; return (a,b,-c,-d)     # (x,y) -> (x,-y)
def refl_y(p): a,b,c,d = p; return (-a,-b,c,d)     # (x,y) -> (-x,y)
def rot60(p):  a,b,c,d = p; return ((a-c)/2, (b-3*d)/2, (3*a+c)/2, (b+d)/2)
def rotA(p, A):
    # rotation about A by theta = arccos(49/50), sin = 3sqrt11/50; derived: for the vector v=[a,b,c,d]:
    # a' = (49a-33d)/50, b' = (49b-3c)/50, c' = (33b+49c)/50, d' = (3a+49d)/50
    a,b,c,d = (p[i]-A[i] for i in range(4))
    v = ((49*a-33*d)/50, (49*b-3*c)/50, (33*b+49*c)/50, (3*a+49*d)/50)
    return tuple(v[i]+A[i] for i in range(4))

def dist2_key(p, q):
    al,be,ga,de = (p[i]-q[i] for i in range(4))
    return (3*al*al + 11*be*be + ga*ga + 33*de*de, al*be + ga*de)   # (rational part *144, sqrt33 part *144/2)

def edges(pts):
    E1, E2 = [], []
    for i in range(len(pts)):
        for j in range(i+1, len(pts)):
            r, s = dist2_key(pts[i], pts[j])
            if s == 0:
                if r == 144: E1.append((i,j))
                elif r == 576: E2.append((i,j))
    return E1, E2

def dedup(pts):
    seen, out = set(), []
    for p in pts:
        if p not in seen: seen.add(p); out.append(p)
    return out

T = dedup(S + [refl_x(p) for p in S] + [refl_y(p) for p in S])
print("T:", len(T), "(paper: 57)")
V = []
cur = T
for k in range(6):
    V += cur
    cur = [rot60(p) for p in cur]
V = dedup(V)
print("V:", len(V), "(paper: 205)")
E1, E2 = edges(V)
print("G edges: unit", len(E1), "(966)  d2", len(E2), "(423)")

extra = [(-2,0,0,-6),(8,0,0,4),(-4,-6,-6,-4),(-4,6,6,-4),(-3,-3,-3,-5),(-4,0,-12,4),(-4,0,12,4),(7,-3,3,3),(7,3,-3,3)]
extra = [tuple(F(x) for x in p) for p in extra]
A, B = extra[0], extra[1]
Hpts = dedup(V + extra)
print("H:", len(Hpts), "(214)")
H1, H2 = edges(Hpts)
print("H edges: unit", len(H1), "(1004)  d2", len(H2), "(446)")
r, s = dist2_key(A, B); print("AB dist2 key:", r, s, "-> dist =", (r/144)**0.5, "(5)")

Hrot = [rotA(p, A) for p in Hpts]
Kpts = dedup(Hpts + Hrot)
print("K:", len(Kpts), "(426)")
K1, K2 = edges(Kpts)
print("K edges: unit", len(K1), "(2009)  d2", len(K2), "(892)")
Bp = rotA(B, A); print("B,B' dist2 key:", dist2_key(B, Bp), "(unit expected)")

# ---- SAT ----
CADICAL = "/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical"
def cnf(n, E, k, pin=None, block=()):
    var = lambda v, c: v*k + c + 1
    cls = []
    for v in range(n):
        cls.append([var(v,c) for c in range(k)])
        for c in range(k):
            for c2 in range(c+1,k): cls.append([-var(v,c), -var(v,c2)])
    for (i,j) in E:
        for c in range(k): cls.append([-var(i,c), -var(j,c)])
    if pin:
        for v,c in pin: cls.append([var(v,c)])
    for b in block: cls.append(b)
    return cls, var
def solve(cls, nvars, timeout=600):
    txt = f"p cnf {nvars} {len(cls)}\n" + "\n".join(" ".join(map(str,c))+" 0" for c in cls) + "\n"
    t = time.time()
    r = subprocess.run([CADICAL, "-q", "-t", str(int(timeout))], input=txt, capture_output=True, text=True)
    dt = time.time()-t
    if r.returncode == 10:
        model = set(int(x) for line in r.stdout.splitlines() if line.startswith("v") for x in line.split()[1:] if int(x) > 0)
        return "SAT", model, dt
    if r.returncode == 20: return "UNSAT", None, dt
    return "UNKNOWN", None, dt

def run(name, pts, E, k):
    n = len(pts)
    cls, var = cnf(n, E, k)
    st, model, dt = solve(cls, n*k)
    print(f"{name}: k={k} -> {st} ({dt:.1f}s)")
    return st, model, var

def count_colourings(name, pts, E, k, clique_pin=None, cap=1000):
    """Count proper k-colourings up to colour permutation by pinning a clique to 0..len-1 and
    enumerating with blocking clauses (first-occurrence breaking would be more general; the pinned
    clique suffices if it has k vertices, else count is over the palette orbits partially)."""
    n = len(pts)
    pin = [(v, i) for i, v in enumerate(clique_pin)] if clique_pin else None
    cls, var = cnf(n, E, k, pin=pin)
    found = []
    while len(found) < cap:
        st, model, dt = solve(cls, n*k)
        if st != "SAT": break
        col = [next(c for c in range(k) if var(v,c) in model) for v in range(n)]
        found.append(col)
        cls.append([-var(v, col[v]) for v in range(n)])
    print(f"{name}: {len(found)} colourings (pin {clique_pin})")
    return found

def max_clique(pts, E, k):
    adj = {i:set() for i in range(len(pts))}
    for i,j in E: adj[i].add(j); adj[j].add(i)
    # greedy-ish exact small clique search up to size k
    best = []
    def ext(cl, cand):
        nonlocal best
        if len(cl) > len(best): best = list(cl)
        if len(cl) == k: return True
        for v in sorted(cand):
            if ext(cl+[v], cand & adj[v]): return True
        return False
    ext([], set(range(len(pts))))
    return best

if __name__ == "__main__":
    st, _, _ = run("G", V, E1+E2, 5)
    st, _, _ = run("H", Hpts, H1+H2, 5)
    st, _, _ = run("K", Kpts, K1+K2, 5)
    st4, _, _ = run("K", Kpts, K1+K2, 6)   # control: must be SAT
    stU, _, _ = run("K unit-only", Kpts, K1, 5)   # control: the UDG part alone must be 5-colourable
    cl = max_clique(V, E1+E2, 5); print("G max clique found:", cl, len(cl))
    cols = count_colourings("G", V, E1+E2, 5, clique_pin=cl if len(cl)==5 else cl[:4])
    clH = max_clique(Hpts, H1+H2, 5)
    colsH = count_colourings("H", Hpts, H1+H2, 5, clique_pin=clH if len(clH)==5 else clH[:4])
    iA, iB = Hpts.index(A), Hpts.index(B)
    print("A=B in all H colourings:", all(c[iA]==c[iB] for c in colsH), "count", len(colsH))
