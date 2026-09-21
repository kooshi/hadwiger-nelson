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
ap.add_argument("--round", type=int, default=0, help="PROTOTYPE of the exact rounding: digits for the PSD blocks and multipliers (0 = off)")
ap.add_argument("--wdigits", type=int, default=9, help="digits of the rational cosine/sine weights")
ap.add_argument("--shift", type=float, default=1e-6, help="relative diagonal shift added to each dual block before rounding")
ap.add_argument("--cert-out", default=None, help="with --round: write the prototype certificate (format fs66-b1-cert-v1) here")
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
block_off = []
for name, d, ent in psd_blocks:
    block_off.append(r)
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
    zdual = np.array(sol.z)
    solver_name = "clarabel " + clarabel.__version__
else:
    import scs
    cone = dict(z=len(eq_rows), l=len(scalar_rows), s=[d for _, d, _ in psd_blocks])
    sv = scs.SCS(dict(A=A, b=b, c=qobj), cone, eps_abs=args.scs_eps, eps_rel=args.scs_eps, max_iters=args.scs_iters, verbose=True)
    res = sv.solve()
    val, dval, status, iters = -res["info"]["pobj"], -res["info"]["dobj"], res["info"]["status"], res["info"]["iter"]
    zdual = np.array(res["y"])
    solver_name = "scs " + scs.__version__
rec = dict(p=p, c=c, n=n, orbits=K, blocks=[(nm, d) for nm, d, _ in psd_blocks], scalar_rows=len(scalar_rows),
           options=dict(absorb=not args.no_absorb, edge=not args.no_edge, tri=(tri is not None and not args.no_tri),
                        q=not args.no_q, qloc=not args.no_qloc, pure=args.pure, boxloc=not args.no_boxloc, sa=args.sa, edge_rows=args.edge_rows),
           status=status, value=val, dual_value=dval, iterations=iters,
           build_s=round(T1 - T0, 1), solve_s=round(time.time() - T1, 1), solver=solver_name)
if args.round:
    # ---------------- PROTOTYPE PRODUCER (untrusted): round the dual to the exact certificate of
    # plans/FS66-phase2-certificate.md (format fs66-b1-cert-v1) and compute the bound U it proves.  U is an OUTPUT.
    from fractions import Fraction
    assert not eq_rows and args.no_boxloc and not [1 for nm, _, _ in psd_blocks if nm.startswith("loc[")], "prototype covers the minimal relaxation only"
    T2 = time.time()
    DEN = 10 ** args.round; DW = 10 ** args.wdigits
    def getZ(bi):
        name, d, _ = psd_blocks[bi]; r0 = block_off[bi]; Z = np.zeros((d, d))
        for j in range(d):
            for i in range(j + 1):
                if args.solver == "clarabel": v = zdual[r0 + j * (j + 1) // 2 + i]
                else: v = zdual[r0 + i * d - i * (i - 1) // 2 + (j - i)]
                Z[i, j] = Z[j, i] = v if i == j else v / SQ2
        return Z
    def pd_int(Mi):                                   # Sylvester by fraction-free (Bareiss) elimination
        A_ = [row[:] for row in Mi]; prev = 1; d = len(A_)
        for k in range(d):
            if A_[k][k] <= 0: return False
            for i in range(k + 1, d):
                for j in range(i, d):
                    A_[i][j] = (A_[i][j] * A_[k][k] - A_[i][k] * A_[k][j]) // prev
                    A_[j][i] = A_[i][j]
            prev = A_[k][k]
        return True
    def rnd(Z, Dg):                                   # float dual block -> integer matrix over DEN: Dg (Z + shift*I) Dg,
        d = len(Z); sh = args.shift * float(np.max(np.diag(Z)))   # the shift applied in the solver's (well-scaled) basis
        Zs = Dg @ (Z + sh * np.eye(d)) @ Dg
        return [[int(round(Zs[i, j] * DEN)) for j in range(d)] for i in range(d)]
    names = [nm for nm, _, _ in psd_blocks]
    cert = dict(format="fs66-b1-cert-v1", p=p, m=None, c=2, den=DEN, weight_den=DW, blocks=[], q0=None, rows=[], U=None, slack="0")
    assert c == 2.0
    pdfail = []
    Dn = np.diag([1.0] + [1.0 / n] * R)
    R0 = rnd(getZ(names.index("M2[u=0]")), Dn)
    if not pd_int(R0): pdfail.append("M2[u=0]")
    cert["blocks"].append(dict(kind="trivial", R=R0))
    mu_of = {}
    for ri, (rn, e) in enumerate(scalar_rows):
        if rn.startswith("locq[u="): mu_of[rn[5:-1]] = max(0.0, float(zdual[len(eq_rows) + ri]))
    for u in ureps:
        th = 2 * np.pi * dot(u) / p
        Rb = rnd(getZ(names.index(f"M2[u={u}]")), np.eye(R) / math.sqrt(n))
        if not pd_int(Rb): pdfail.append(f"M2[u={u}]")
        cert["blocks"].append(dict(kind="character", u=list(u), wc=[int(round(v * DW)) for v in np.cos(th)],
                                   ws=[int(round(v * DW)) for v in np.sin(th)], R=Rb,
                                   mu=int(round(mu_of.get(f"u={u}", 0.0) / n * DEN))))
    if "locq[u=0]" in names:
        q0 = rnd(getZ(names.index("locq[u=0]")), np.diag([1.0, 1.0 / n]))
        if not pd_int(q0): pdfail.append("locq[u=0]")
    else: q0 = [[0, 0], [0, 0]]
    cert["q0"] = q0
    # ---- the linear form of the PSD parts, from the certificate's integers only (what the checker recomputes)
    Kk = K
    Qint = lambda m: {k: int(round(w)) for k, w in Lq_times(m).items()}
    Q_empty, Q_0 = Qint(()), Qint((0,))
    Q_t = [Qint((0, t)) for t in range(n)]
    form = [Fraction(0)] * Kk
    acc = [0] * Kk                                    # trivial block and q0, over DEN
    acc[0] += R0[0][0]
    for ia, a in enumerate(reps): acc[canon(a)] += 2 * n * R0[0][1 + ia]
    for ia in range(R):
        for ib in range(R):
            zz = n * R0[1 + ia][1 + ib]
            if zz:
                for k in F[ia, ib].tolist(): acc[k] += zz
    for k, w in Q_empty.items(): acc[k] += q0[0][0] * w
    for k, w in Q_0.items(): acc[k] += 2 * n * q0[0][1] * w
    for t in range(n):
        for k, w in Q_t[t].items(): acc[k] += n * q0[1][1] * w
    for k in range(Kk): form[k] += Fraction(acc[k], DEN)
    for blk in cert["blocks"][1:]:
        wc, ws, Rb = blk["wc"], blk["ws"], blk["R"]
        kap = [sum(wc[x] * wc[addl[x][t]] + ws[x] * ws[addl[x][t]] for x in range(n)) for t in range(n)]
        acc = [0] * Kk
        for ia in range(R):
            for ib in range(R):
                zz = Rb[ia][ib]
                if zz:
                    Fr = F[ia, ib].tolist()
                    for t in range(n): acc[Fr[t]] += zz * kap[t]
        if blk["mu"]:
            for t in range(n):
                for k, w in Q_t[t].items(): acc[k] += blk["mu"] * kap[t] * w
        for k in range(Kk):
            if acc[k]: form[k] += Fraction(acc[k], DEN * DW * DW)
    # ---- rows: the solver's own multipliers rounded (clipped at zero), then the remainder absorbed by the cascade
    inv = {k: m for m, k in orbit_of.items()}
    lam_plus, lam_le = {}, {}
    for ri, (rn, e) in enumerate(scalar_rows):
        if rn in ("nonneg", "le"):
            li = int(round(float(zdual[len(eq_rows) + ri]) * DEN))
            if li <= 0: continue
            if rn == "nonneg": (k,) = e.keys(); lam_plus[k] = lam_plus.get(k, 0) + li
            else:
                k = [kk for kk, w in e.items() if w < 0][0]; k2 = [kk for kk, w in e.items() if w > 0][0]
                lam_le[(k, k2)] = lam_le.get((k, k2), 0) + li
    need = [Fraction(0)] * Kk                          # need = U*y0 - n*y1 - form - rows ; U fixed at the end
    need[canon((0,))] -= n
    for k in range(Kk): need[k] -= form[k]
    for k, li in lam_plus.items(): need[k] -= Fraction(li, DEN)
    for (k, k2), li in lam_le.items(): need[k] += Fraction(li, DEN); need[k2] -= Fraction(li, DEN)
    extra_plus, extra_le = {}, {}
    for k in sorted(range(1, Kk), key=lambda k: -len(inv[k])):
        if need[k] > 0: extra_plus[k] = need[k]
        elif need[k] < 0:
            par = canon(inv[k][:-1]); extra_le[(k, par)] = -need[k]; need[par] += need[k]
        need[k] = Fraction(0)
    U = -need[0]                                       # U*y0 + need[0]*y0 = 0
    # ---- write format fs66-b1-cert-v2: integers only, ONE block type, ONE row type (plans/FS66-phase2-certificate.md §C)
    LAM = DEN * DW * DW                                # the scale: U = U_num / LAM
    def as_int(v):
        v = Fraction(v) * LAM; assert v.denominator == 1, "a multiplier is not an integer over the scale"; return int(v)
    weights = [[1] + [1] * n]                          # weight vectors on {[]} + V; index 0 is the all-ones vector
    out_blocks = [dict(times="1", weights=[0], R=[[v * DW * DW for v in row] for row in R0])]
    for blk in cert["blocks"][1:]:
        ic = len(weights); weights.append([0] + blk["wc"]); weights.append([0] + blk["ws"])
        Rb = blk["R"]; d = len(Rb)
        out_blocks.append(dict(times="1", weights=[ic, ic + 1], u=blk["u"],
                               R=[[1] + [0] * d] + [[0] + Rb[i] for i in range(d)]))
        if blk["mu"] > 0: out_blocks.append(dict(times="q", weights=[ic, ic + 1], u=blk["u"], R=[[1, 0], [0, blk["mu"]]]))
    if any(any(r_) for r_ in q0): out_blocks.append(dict(times="q", weights=[0], R=[[v * DW * DW for v in row] for row in q0]))
    rows = []
    for k in set(lam_plus) | set(extra_plus):
        rows.append([list(inv[k]), [], as_int(Fraction(lam_plus.get(k, 0), DEN) + extra_plus.get(k, 0))])
    for (k, k2) in set(lam_le) | set(extra_le):
        mk = list(inv[k]); x = next(x for x in set(mk) if canon(tuple(sorted(mk[:mk.index(x)] + mk[mk.index(x) + 1:]))) == k2)
        A_ = mk[:mk.index(x)] + mk[mk.index(x) + 1:]
        rows.append([A_, [x], as_int(Fraction(lam_le.get((k, k2), 0), DEN) + extra_le.get((k, k2), 0))])
    cert = dict(format="fs66-b1-cert-v2", p=p, scale=LAM, U_num=as_int(U), weights=weights, blocks=out_blocks, rows=rows)
    rec.update(dict(round_digits=args.round, weight_digits=args.wdigits, shift=args.shift, pd_failures=pdfail,
                    exact_U=float(U), exact_U_minus_float=float(U) - val, rows_in_certificate=len(cert["rows"]),
                    cascaded=len(extra_le), exact_seconds=round(time.time() - T2, 1)))
    print("EXACT PROTOTYPE:", json.dumps({k: rec[k] for k in ("pd_failures", "exact_U", "exact_U_minus_float", "rows_in_certificate", "cascaded", "exact_seconds")}))
    if args.cert_out and not pdfail:
        with open(args.cert_out, "w") as fh: json.dump(cert, fh, separators=(",", ":"))
        rec["cert_out"] = args.cert_out
print(json.dumps(rec))
if args.out:
    with open(args.out, "a") as f: f.write(json.dumps(rec) + "\n")
