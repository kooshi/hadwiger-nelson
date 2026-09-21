#!/usr/bin/env python3
"""FS-66 phase 2, the PLANNER'S PROBE (floating point; a reading, never a certificate).

The second-level moment relaxation of the single-class fibre-density problem

    B1(p) = max  sum_x phi_x   over phi in [0,1]^(p^2)
            s.t. q(phi) := c*sum_x phi_x(1-phi_x) - sum_x sum_{s in S} phi_x phi_{x+s} >= 0     (c = 2)
                 phi_x + phi_y <= 1              on every edge of UD(F_p, 2)
                 phi_x + phi_y + phi_z <= 1      on every triangle (none when 3 is a non-square mod p)

with the symmetry group G = translations x O(2,p) (order 2 p^2 (p+1)) divided out.

  * moment variables: one per G-orbit of monomials (multisets of points) of degree <= 4;
  * the moment matrix M_2 in the translation-Fourier basis: one REAL block per O(2,p)-orbit of characters
    (u = 0 and one u per nonzero norm class), real because the monomial representatives are centred
    (phi_0, phi_{-h} phi_h) and the moments are invariant under negation;
  * localising matrices (order 1, size p^2+1) for phi_0 >= 0, 1-phi_0 >= 0, one edge cut, one triangle cut;
  * the localiser of q in the Fourier basis (a 2x2 block and one scalar per norm class);
  * optional scalar rows: every monomial moment >= 0 and y[alpha minus x] - y[alpha] >= 0 (the box, products of
    degree <= 4) -- the rows that let a rounded certificate absorb a residual of either sign.

Usage:  fs66_b1_probe.py P [--c 2] [--threads 8] [--no-absorb] [--no-edge] [--no-tri] [--no-q] [--no-qloc] [--out FILE]
Needs numpy, scipy, clarabel (venv ~/venvs/fs66).  Prints one JSON record on the last line.
"""
import sys, json, time, math, argparse
import numpy as np
import scipy.sparse as sp

ap = argparse.ArgumentParser()
ap.add_argument("p", type=int)
ap.add_argument("--c", type=float, default=2.0)
ap.add_argument("--no-absorb", action="store_true")
ap.add_argument("--no-edge", action="store_true")
ap.add_argument("--no-tri", action="store_true")
ap.add_argument("--no-q", action="store_true", help="drop the quadratic constraint entirely (control: reads p^2/2-ish)")
ap.add_argument("--no-qloc", action="store_true", help="keep only the scalar L(q) >= 0")
ap.add_argument("--pure", action="store_true", help="control: add phi^2 = phi (the 0/1 problem: Lasserre-2 for alpha)")
ap.add_argument("--threads", type=int, default=4)
ap.add_argument("--solver", default="clarabel", choices=["clarabel", "scs"])
ap.add_argument("--scs-iters", type=int, default=20000)
ap.add_argument("--scs-eps", type=float, default=1e-6)
ap.add_argument("--no-boxloc", action="store_true", help="drop the localisers of phi_0 and 1-phi_0 (scalar rows only)")
ap.add_argument("--sa", action="store_true", help="all box products prod phi_x prod (1-phi_y) of degree <= 4 as scalar rows")
ap.add_argument("--edge-rows", action="store_true", help="scalar rows L(cut * monomial) >= 0, monomial degree <= 3, for edge and triangle cuts")
ap.add_argument("--out", default=None)
args = ap.parse_args()
p, c = args.p, args.c
assert p % 4 == 3
n = p * p
T0 = time.time()

pts = [(a, b) for a in range(p) for b in range(p)]
ix = {z: i for i, z in enumerate(pts)}
S = [z for z in pts if (z[0] * z[0] + z[1] * z[1]) % p == 1]
assert len(S) == p + 1
add = np.array([[ix[((a[0] + b[0]) % p, (a[1] + b[1]) % p)] for b in pts] for a in pts], dtype=np.int32)
sub = np.array([[ix[((a[0] - b[0]) % p, (a[1] - b[1]) % p)] for b in pts] for a in pts], dtype=np.int32)
neg = sub[0]
Sidx = [ix[s] for s in S]
def rot(s, z): return ((s[0] * z[0] - s[1] * z[1]) % p, (s[0] * z[1] + s[1] * z[0]) % p)
Hperm = []
for s in S:
    Hperm.append([ix[rot(s, z)] for z in pts])
    Hperm.append([ix[rot(s, (z[0], (-z[1]) % p))] for z in pts])
Hperm = [list(h) for h in Hperm]
subl = sub.tolist(); addl = add.tolist()

orbit_of = {}      # canonical tuple -> orbit index
memo = {}
def canon(m):
    """orbit index of the monomial m (a tuple of point indices, any order, repeats allowed)."""
    m = tuple(sorted(m))
    k = memo.get(m)
    if k is not None: return k
    if not m:
        best = ()
    else:
        best = None
        for base in set(m):
            row = [subl[i][base] for i in m]
            for h in Hperm:
                cand = tuple(sorted(h[i] for i in row))
                if best is None or cand < best: best = cand
    k = orbit_of.get(best)
    if k is None:
        k = len(orbit_of); orbit_of[best] = k
    memo[m] = k
    return k

assert canon(()) == 0

# ---- affine expressions over orbit variables: dict orbit -> coeff
def Lmono(m, coef=1.0, acc=None):
    acc = {} if acc is None else acc
    k = canon(m); acc[k] = acc.get(k, 0.0) + coef
    return acc
def Lq_times(m, acc=None, scale=1.0):
    """L(q * m) for a monomial m (tuple)."""
    acc = {} if acc is None else acc
    for x in range(n):
        Lmono(m + (x,), scale * c, acc)
        Lmono(m + (x, x), -scale * c, acc)
        ax = addl[x]
        for s in Sidx:
            Lmono(m + (x, ax[s]), -scale, acc)
    return acc

# ---- monomial representatives of the free translation orbits, centred
reps = [(0,)]
seen = set()
for h in range(n):
    key = min(h, int(neg[h]))
    if key in seen: continue
    seen.add(key)
    reps.append((int(neg[h]), h))
R = len(reps)
print(f"p={p} n={n} |S|={len(S)} |H|={len(Hperm)} reps={R}", flush=True)

# F[a][b][t] = orbit of a * tau_t(b)
F = np.zeros((R, R, n), dtype=np.int64)
for ia, a in enumerate(reps):
    for ib in range(ia, R):
        b = reps[ib]
        for t in range(n):
            F[ia, ib, t] = canon(a + tuple(addl[i][t] for i in b))
for ia in range(R):
    for ib in range(ia):
        F[ia, ib, :] = F[ib, ia, neg]          # F_ba(t) = F_ab(-t); equals F_ab(t) by centring (asserted below)
assert all((F[ia, ib] == F[ia, ib][neg]).all() for ia in range(R) for ib in range(ia, R)), "centring symmetry failed"
print(f"moment structure built: {len(orbit_of)} orbits so far, {time.time()-T0:.1f}s", flush=True)

# character representatives: u=0 and one u per nonzero norm class
norm = lambda z: (z[0] * z[0] + z[1] * z[1]) % p
ureps = {}
for z in pts[1:]:
    ureps.setdefault(norm(z), z)
ureps = [ureps[k] for k in sorted(ureps)]
assert len(ureps) == p - 1
dot = lambda u: np.array([(u[0] * z[0] + u[1] * z[1]) % p for z in pts])

psd_blocks = []     # each: (dim, list of (i, j, orbit, coef)) upper triangle i<=j, plus name
def add_block(name, dim, entries): psd_blocks.append((name, dim, entries))

# u = 0 block: basis 1, then averaged reps
ent = [(0, 0, 0, 1.0)]
for ia, a in enumerate(reps):
    ent.append((0, 1 + ia, canon(a), 1.0))
for ia in range(R):
    for ib in range(ia, R):
        ks, cnt = np.unique(F[ia, ib], return_counts=True)
        for k, m_ in zip(ks, cnt): ent.append((1 + ia, 1 + ib, int(k), float(m_) / n))
add_block("M2[u=0]", R + 1, ent)
for u in ureps:
    cosv = np.cos(2 * np.pi * dot(u) / p)
    ent = []
    for ia in range(R):
        for ib in range(ia, R):
            acc = {}
            for k, w in zip(F[ia, ib].tolist(), cosv.tolist()): acc[k] = acc.get(k, 0.0) + w
            for k, w in acc.items():
                if abs(w) > 1e-13: ent.append((ia, ib, k, w))
    add_block(f"M2[u={u}]", R, ent)

# localisers of linear constraints g = g0 + sum_j gj*phi_xj   (list of (coef, monomial))
W = [()] + [(x,) for x in range(n)]
def localiser(name, g):
    ent = []
    for i in range(len(W)):
        for j in range(i, len(W)):
            acc = {}
            for coef, m in g: Lmono(m + W[i] + W[j], coef, acc)
            for k, w in acc.items():
                if w != 0.0: ent.append((i, j, k, w))
    add_block(name, len(W), ent)
if not args.no_boxloc:
    localiser("loc[phi_0]", [(1.0, (0,))])
    localiser("loc[1-phi_0]", [(1.0, ()), (-1.0, (0,))])
s0 = Sidx[0]
if not args.no_edge:
    localiser("loc[edge]", [(1.0, ()), (-1.0, (0,)), (-1.0, (s0,))])
tri = None
for s in Sidx:
    if s != s0 and int(sub[s][s0]) in Sidx: tri = s; break
if tri is not None and not args.no_tri:
    localiser("loc[triangle]", [(1.0, ()), (-1.0, (0,)), (-1.0, (s0,)), (-1.0, (tri,))])
print(f"triangles: {'yes' if tri is not None else 'none'}; localisers built, {len(orbit_of)} orbits, {time.time()-T0:.1f}s", flush=True)

scalar_rows = []    # affine expr dict, meaning expr >= 0
if not args.no_q:
    if args.no_qloc:
        scalar_rows.append(("L(q)", Lq_times(())))
    else:
        q1 = Lq_times(()); qa = Lq_times((0,))
        qt = [Lq_times((0, t)) for t in range(n)]
        ent = [(0, 0, k, w) for k, w in q1.items()] + [(0, 1, k, w) for k, w in qa.items()]
        acc = {}
        for t in range(n):
            for k, w in qt[t].items(): acc[k] = acc.get(k, 0.0) + w / n
        ent += [(1, 1, k, w) for k, w in acc.items()]
        add_block("locq[u=0]", 2, ent)
        for u in ureps:
            cosv = np.cos(2 * np.pi * dot(u) / p)
            acc = {}
            for t in range(n):
                for k, w in qt[t].items(): acc[k] = acc.get(k, 0.0) + w * cosv[t]
            scalar_rows.append((f"locq[u={u}]", acc))
    print(f"q rows built, {len(orbit_of)} orbits, {time.time()-T0:.1f}s", flush=True)

eq_rows = []
if args.pure:
    # phi_x^2 = phi_x: y[m with a repeated point] = y[m with the repeat removed]
    for m, k in list(orbit_of.items()):
        if len(set(m)) < len(m):
            eq_rows.append({k: 1.0, canon(tuple(sorted(set(m)))): -1.0})

if not args.no_absorb:
    for m, k in list(orbit_of.items()):
        if not m: continue
        scalar_rows.append(("nonneg", {k: 1.0}))
        for x in set(m):
            mm = list(m); mm.remove(x)
            k2 = canon(tuple(mm))
            if k2 != k: scalar_rows.append(("le", {k2: 1.0, k: -1.0}))
if args.sa:
    import itertools
    seen_rows = set()
    for m in list(orbit_of.keys()):
        if not m: continue
        for r_ in range(1, len(m) + 1):
            for Bpos in itertools.combinations(range(len(m)), r_):
                Bs = [m[i] for i in Bpos]; As = [m[i] for i in range(len(m)) if i not in Bpos]
                acc = {}
                for t_ in range(len(Bs) + 1):
                    for Tt in itertools.combinations(Bs, t_):
                        Lmono(tuple(As) + Tt, (-1.0) ** t_, acc)
                key = tuple(sorted((k_, round(w_, 9)) for k_, w_ in acc.items() if w_ != 0.0))
                if key and key not in seen_rows:
                    seen_rows.add(key); scalar_rows.append(("sa", dict(key)))
if args.edge_rows:
    cuts_ = [[(1.0, ()), (-1.0, (0,)), (-1.0, (s0,))]]
    if tri is not None: cuts_.append([(1.0, ()), (-1.0, (0,)), (-1.0, (s0,)), (-1.0, (tri,))])
    import itertools
    seen_rows = set()
    for g_ in cuts_:
        for d_ in range(0, 4):
            for m in itertools.combinations_with_replacement(range(n), d_):
                acc = {}
                for coef, mm in g_: Lmono(mm + m, coef, acc)
                key = tuple(sorted((k_, w_) for k_, w_ in acc.items() if w_ != 0.0))
                if key not in seen_rows:
                    seen_rows.add(key); scalar_rows.append(("cutrow", dict(key)))
K = len(orbit_of)
print(f"orbits K={K}; PSD blocks {[(nm, d) for nm, d, _ in psd_blocks]}; scalar rows {len(scalar_rows)}; eq rows {len(eq_rows)}", flush=True)

# ---- assemble for Clarabel: minimise q'x, A x + s = b, s in K.  x = y[1..K-1]; y[0] = 1.
import clarabel
rows, cols, vals, bvec, cones = [], [], [], [], []
r = 0
if eq_rows:
    for e in eq_rows:
        b0 = 0.0
        for k, w in e.items():
            if k == 0: b0 -= w
            else: rows.append(r); cols.append(k - 1); vals.append(w)
        bvec.append(b0); r += 1
    cones.append(clarabel.ZeroConeT(len(eq_rows)))
for _, e in scalar_rows:                      # expr >= 0  <=>  s = expr = b - A x
    b0 = 0.0
    for k, w in e.items():
        if k == 0: b0 += w
        else: rows.append(r); cols.append(k - 1); vals.append(-w)
    bvec.append(b0); r += 1
if scalar_rows: cones.append(clarabel.NonnegativeConeT(len(scalar_rows)))
SQ2 = math.sqrt(2.0)
for name, d, ent in psd_blocks:
    if args.solver == "clarabel":
        pos = lambda i, j: j * (j + 1) // 2 + i      # column-major upper triangle, i <= j
    else:
        pos = lambda i, j, d=d: i * d - i * (i - 1) // 2 + (j - i)   # SCS: lower triangle column-major = (j,i) with j >= i
    bb = np.zeros(d * (d + 1) // 2)
    for i, j, k, w in ent:
        if i > j: i, j = j, i
        sc = 1.0 if i == j else SQ2
        if k == 0: bb[pos(i, j)] += sc * w
        else: rows.append(r + pos(i, j)); cols.append(k - 1); vals.append(-sc * w)
    bvec.extend(bb.tolist()); r += d * (d + 1) // 2
    cones.append(clarabel.PSDTriangleConeT(d))
A = sp.csc_matrix((vals, (rows, cols)), shape=(r, K - 1))
A.sum_duplicates()
b = np.array(bvec)
qobj = np.zeros(K - 1); qobj[canon((0,)) - 1] = -float(n)
P = sp.csc_matrix((K - 1, K - 1))
print(f"assembled: {A.shape}, nnz {A.nnz}, {time.time()-T0:.1f}s", flush=True)
T1 = time.time()
if args.solver == "clarabel":
    st = clarabel.DefaultSettings(); st.verbose = True; st.max_iter = 200; st.max_threads = args.threads
    sol = clarabel.DefaultSolver(P, qobj, A, b, cones, st).solve()
    val, dval, status, iters = -sol.obj_val, -sol.obj_val_dual, str(sol.status), sol.iterations
    solver_name = "clarabel " + clarabel.__version__
else:
    import scs
    cone = dict(z=len(eq_rows), l=len(scalar_rows), s=[d for _, d, _ in psd_blocks])
    sv = scs.SCS(dict(A=A, b=b, c=qobj), cone, eps_abs=args.scs_eps, eps_rel=args.scs_eps, max_iters=args.scs_iters, verbose=True)
    res = sv.solve()
    val, dval, status, iters = -res["info"]["pobj"], -res["info"]["dobj"], res["info"]["status"], res["info"]["iter"]
    solver_name = "scs " + scs.__version__
rec = dict(p=p, c=c, n=n, orbits=K, blocks=[(nm, d) for nm, d, _ in psd_blocks], scalar_rows=len(scalar_rows),
           options=dict(absorb=not args.no_absorb, edge=not args.no_edge, tri=(tri is not None and not args.no_tri),
                        q=not args.no_q, qloc=not args.no_qloc, pure=args.pure, boxloc=not args.no_boxloc, sa=args.sa, edge_rows=args.edge_rows),
           status=status, value=val, dual_value=dval, iterations=iters,
           build_s=round(T1 - T0, 1), solve_s=round(time.time() - T1, 1), solver=solver_name)
print(json.dumps(rec))
if args.out:
    with open(args.out, "a") as f: f.write(json.dumps(rec) + "\n")
