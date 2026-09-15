#!/usr/bin/env python3
"""fplane_sdp_blocks — the triple-level SDP of `fplane_sdp.py` block-diagonalised (FS-50 §S4 D8′), so it runs at p = 83.

A rotation-invariant matrix Y on V = F_p² is determined by its ANGULAR PROFILES: fix a generator ζ of the rotation group
(order p+1) and a base point u_c on each circle C_c = {Q = c}; then Y[u_c ζ^θ, u_{c'} ζ^{θ'}] = f_{cc'}(θ' − θ). Its
blocks are the discrete Fourier transforms of the profiles: for j = 0 … p the vectors e^c_j(u_c ζ^θ) = ω^{jθ} (ω = e^{2πi/(p+1)})
span the ω^{−j}-eigenspace of the rotation, Y preserves it, and B_j[c, c'] = Σ_θ f_{cc'}(θ) ω^{jθ} is Hermitian with
Y ⪰ 0 ⟺ every B_j ⪰ 0 (the j = 0 block is bordered by the origin). Only rotation invariance is used here; the reflection,
the swap and the S₃ relabelling are imposed as identifications of the profile variables (a union-find over the index set
of profiles, never over the n² pairs), and B_{p+1−j} = conj(B_j) so j runs 0 … (p+1)/2. Each Hermitian block R + iI is
embedded as the real symmetric [[R, −I], [I, R]]. Controls: the value at 11 and 23 must reproduce the direct solve
(29.18, 108.55), and the verified set's blocks must be PSD. Floats (SCS); readings, never bounds."""
import argparse, json, sys, time
from pathlib import Path
import numpy as np
import scipy.sparse as sp
sys.path.insert(0, str(Path(__file__).resolve().parent))
import fplane_lp as L
import fplane
import fplane_cert_check as CC     # the Field: F_q for a prime power, named by its modulus

def setup(p):
    """`p` is a prime, or a `CC.Field` (F_q with q a prime power, the modulus named).  All the
    arithmetic below goes through the field, so for a prime it is the same `% p` it always was."""
    F = CC.as_field(p)
    q, one, zero = F.q, F.one, F.zero
    fadd, fsub, fmul, fneg = F.add, F.sub, F.mul, F.neg
    p = q                                   # every message below means the plane's size
    n = q * q; m = q + 1
    Q = lambda v: fadd(fmul(v[0], v[0]), fmul(v[1], v[1]))
    cmul = lambda a, b: (fsub(fmul(a[0], b[0]), fmul(a[1], b[1])), fadd(fmul(a[0], b[1]), fmul(a[1], b[0])))
    circ = fplane.circle(q) if F.f == 1 else [(x, y) for x in range(q) for y in range(q) if Q((x, y)) == one]
    zeta = None
    for a, b in circ:
        z = (a, b); k = 1
        while z != (one, zero):
            z = cmul(z, (a, b)); k += 1
        if k == m:
            zeta = (a, b); break
    assert zeta is not None
    # base points ON THE TWO REFLECTION AXES: (t, 0) for the square classes c = t², and t·w on the line through one fixed
    # non-square point w for the others (that line meets exactly the non-square classes). Then the reflection (x,y) ↦ (x,−y)
    # fixes every square-class base point and sends a non-square one to ū_c = u_c ζ^{k_c}; the DFT blocks B_j are
    # diag(ω^{j a_c}) · R_j · diag(ω^{−j a_c}) with a_c = k_c/2 and R_j REAL symmetric — half the embedded block size.
    base = {}; angle = {}
    for t in range(1, q):
        c = fmul(t, t)
        if c not in base: base[c] = (t, zero)
    w = None
    for x in range(q):
        for y in range(q):
            if (x, y) != (0, 0) and Q((x, y)) not in base:
                w = (x, y); break
        if w: break
    if w is not None:
        for t in range(1, q):
            tw = (fmul(t, w[0]), fmul(t, w[1]))
            c = Q(tw)
            if c not in base: base[c] = tw
    assert len(base) == q - 1
    for c, u in base.items():
        w = u
        for th in range(m):
            angle[w] = (c, th); w = cmul(w, zeta)
    assert len(angle) == n - 1
    kc = {c: angle[(u[0], fneg(u[1]))][1] for c, u in base.items()}   # ū_c = u_c ζ^{k_c}; k_c = 0 on the real axis
    classes = sorted(base)  # the q−1 circles
    ci = {c: i for i, c in enumerate(classes)}
    C = len(classes)
    # the profile index set: (c, c', θ) ↦ C*C*m + ...; zero-pairs (0, c) ↦ base0 + i; (0,0) ↦ last
    def idx_prof(c, cp_, th): return (ci[c] * C + ci[cp_]) * m + th
    NP = C * C * m; idx_zero = lambda c: NP + ci[c]; idx_00 = NP + C
    Ntot = NP + C + 1
    parent = np.arange(Ntot, dtype=np.int64)
    def find(i):
        r = i
        while parent[r] != r: r = parent[r]
        while parent[i] != r:
            parent[i], i = r, parent[i]
        return r
    def union(i, j):
        i, j = find(i), find(j)
        if i != j: parent[i] = j
    def pair_index(u, v):
        """the index of the profile variable holding Y[u, v] for nonzero/zero u, v"""
        if u == (0, 0) and v == (0, 0): return idx_00
        if u == (0, 0): return idx_zero(angle[v][0])
        if v == (0, 0): return idx_zero(angle[u][0])
        c, th = angle[u]; cp_, thp = angle[v]
        return idx_prof(c, cp_, (thp - th) % m)
    neg = lambda w: (fneg(w[0]), fneg(w[1]))
    sub = lambda a, b: (fsub(a[0], b[0]), fsub(a[1], b[1]))
    refl = lambda w: (w[0], fneg(w[1]))
    # identifications: swap, reflection, S3 — applied at every profile entry (u = base point, v = u_{c'} ζ^θ)
    for c in classes:
        u = base[c]
        for cp_ in classes:
            w = base[cp_]
            for th in range(m):
                i = idx_prof(c, cp_, th)
                union(i, pair_index(w, u))                       # swap
                union(i, pair_index(refl(u), refl(w)))            # the reflection
                union(i, pair_index(neg(u), sub(w, u)))           # S3: (u, v) ↦ (−u, v − u)
                w = cmul(w, zeta)
    for c in classes:
        union(idx_zero(c), pair_index(base[c], base[c]))           # Y[u,u] = Y[0,u] (S3 with v = u); also (0,u) ↔ (u,0) by swap
        union(idx_zero(c), pair_index(neg(base[c]), (0, 0)))
    roots = {}; cls = np.zeros(Ntot, dtype=np.int64)
    for i in range(Ntot):
        r = find(i)
        if r not in roots: roots[r] = len(roots)
        cls[i] = roots[r]
    K = len(roots)
    # killed classes (any pair touching a unit vector), and the diag class per circle
    killed = np.zeros(K, dtype=bool)
    for c in classes:
        u = base[c]
        for cp_ in classes:
            w = base[cp_]
            for th in range(m):
                if c == one or cp_ == one or Q(sub(u, w)) == one:
                    killed[cls[idx_prof(c, cp_, th)]] = True
                w = cmul(w, zeta)
    killed[cls[idx_zero(one)]] = True
    diag_cls = {c: cls[idx_zero(c)] for c in classes}
    g0 = cls[idx_00]
    # M profiles: M[u_c, u_{c'} ζ^θ] = g(Q(u_c − u_{c'} ζ^θ)) = the class of (0, that difference)
    Mcls = np.zeros(NP, dtype=np.int64)
    for c in classes:
        u = base[c]
        for cp_ in classes:
            w = base[cp_]
            for th in range(m):
                d = sub(u, w)
                Mcls[idx_prof(c, cp_, th)] = g0 if d == (zero, zero) else cls[idx_zero(Q(d))]
                w = cmul(w, zeta)
    return dict(p=p, field=F, n=n, m=m, C=C, classes=classes, ci=ci, cls=cls, K=K, killed=killed, diag_cls=diag_cls, g0=g0,
                NP=NP, Mcls=Mcls, idx_prof=idx_prof, idx_zero=idx_zero, base=base, angle=angle, zeta=zeta, Q=Q, kc=kc)

def block_maps(S, which):
    """for j = 0 … m/2: sparse real maps y ↦ vec([[R, −I],[I, R]]) of the Hermitian block B_j (size C, or C+1 at j = 0 with the
    origin); `which` = 'Y' (profile classes) or 'M' (the M classes)"""
    p, m, C, K = S["p"], S["m"], S["C"], S["K"]
    src = S["cls"][:S["NP"]] if which == "Y" else S["Mcls"]
    maps = []
    for j in range(0, m // 2 + 1):
        cosj = np.cos(2 * np.pi * j * np.arange(m) / m); sinj = np.sin(2 * np.pi * j * np.arange(m) / m)
        d = C + (1 if j == 0 else 0)          # block dimension (complex); the origin borders j = 0
        D = 2 * d                               # real embedding
        rows, cols, vals = [], [], []
        def put(r, c, k, v):
            rows.append(r * D + c); cols.append(k); vals.append(v)
        for a in range(C):
            for b in range(C):
                basei = (a * C + b) * m
                for th in range(m):
                    k = src[basei + th]; re, im = cosj[th], sinj[th]
                    # B[a,b] = Σ_θ f(θ) ω^{jθ}: R[a,b] += cos, I[a,b] += sin; embed R at (a,b),(a+d,b+d); −I at (a, b+d); I at (a+d, b)
                    if re: put(a, b, k, re); put(a + d, b + d, k, re)
                    if im: put(a, b + d, k, -im); put(a + d, b, k, im)
        if j == 0:
            # the origin row/column: B_0[orig, c] = Σ_θ Y[0, u_c ζ^θ]/√m normalised … we use the unnormalised symmetric border
            # ⟨e^0_orig, Y e^c_0⟩ with e_orig = √m · 1_0 so that the block stays a Gram matrix: entries √m · Y[0, u_c]
            o = C
            for a in range(C):
                k = (S["cls"][S["idx_zero"](S["classes"][a])] if which == "Y" else S["cls"][S["idx_zero"](S["classes"][a])])
                v = np.sqrt(m)
                put(o, a, k, v); put(a, o, k, v); put(o + d, a + d, k, v); put(a + d, o + d, k, v)
            k00 = S["g0"]
            put(o, o, k00, 1.0); put(o + d, o + d, k00, 1.0)
        A = sp.csr_matrix((np.array(vals), (np.array(rows), np.array(cols))), shape=(D * D, K))
        maps.append((j, d, A))
    return maps

def block_maps_real(S, which):
    """the REAL blocks R_j (size C, or C+1 at j = 0): R_j[c,c'] = Σ_θ f_{cc'}(θ) cos(2π j (2θ − k_{c'} + k_c) / (2m)) — the
    Hermitian B_j conjugated by diag(ω^{j k_c/2}); valid because the base points lie on the two reflection axes (setup)"""
    p, m, C, K = S["p"], S["m"], S["C"], S["K"]
    src = S["cls"][:S["NP"]] if which == "Y" else S["Mcls"]
    kc = [S["kc"][c] for c in S["classes"]]
    maps = []
    for j in range(0, m // 2 + 1):
        d = C + (1 if j == 0 else 0)
        rows, cols, vals = [], [], []
        for a in range(C):
            for b in range(C):
                basei = (a * C + b) * m
                shift = kc[a] - kc[b]
                for th in range(m):
                    k = src[basei + th]
                    v = np.cos(np.pi * j * (2 * th + shift) / m)
                    if abs(v) > 1e-15:
                        rows.append(a * d + b); cols.append(k); vals.append(v)
        if j == 0:
            o = C
            for a in range(C):
                k = S["cls"][S["idx_zero"](S["classes"][a])]; v = np.sqrt(m)
                rows += [o * d + a, a * d + o]; cols += [k, k]; vals += [v, v]
            rows.append(o * d + o); cols.append(S["g0"]); vals.append(1.0)
        A = sp.csr_matrix((np.array(vals), (np.array(rows), np.array(cols))), shape=(d * d, K))
        maps.append((j, d, A))
    return maps

def solve(S, solver="SCS", verbose=False, extra_eq=None, solver_opts=None, real=False):
    import cvxpy as cp
    K = S["K"]; y = cp.Variable(K, nonneg=True)
    cons = [y[S["g0"]] == 1]
    for k in np.nonzero(S["killed"])[0]:
        cons.append(y[int(k)] == 0)
    # entry ≤ diag, per class: y[k] ≤ y[diag(c)] for the classes appearing in circle c's profiles
    seen = set()
    for c in S["classes"]:
        dc = S["diag_cls"][c]
        for cp_ in S["classes"]:
            for th in range(S["m"]):
                k = int(S["cls"][S["idx_prof"](c, cp_, th)])
                if not S["killed"][k] and (k, dc) not in seen and k != dc:
                    cons.append(y[k] <= y[dc]); seen.add((k, dc))
    if real:
        Ymaps = block_maps_real(S, "Y"); Mmaps = block_maps_real(S, "M")
    else:
        Ymaps = block_maps(S, "Y"); Mmaps = block_maps(S, "M")
    for (j, d, A), (_, _, Am) in zip(Ymaps, Mmaps):
        D = d if real else 2 * d
        Yb = cp.reshape(A @ y, (D, D), order="C"); Mb = cp.reshape(Am @ y, (D, D), order="C")
        cons += [Yb >> 0, Mb - Yb >> 0]
    obj = y[S["g0"]] + S["m"] * sum(y[S["diag_cls"][c]] for c in S["classes"])   # tr Y = 1 + (p+1) Σ_c g(c)
    prob = cp.Problem(cp.Maximize(obj), cons)
    prob.solve(solver=solver, verbose=verbose, **(solver_opts or {}))
    return prob.value, prob.status, y.value

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--p", type=int, help="the plane over the PRIME field F_p")
    ap.add_argument("--q", type=int, help="the plane over the field with q elements; a prime power needs --modulus")
    ap.add_argument("--modulus", metavar="POLY",
                    help='the defining polynomial of F_q in t, for example "t^3-t-1"; required for a prime '
                         "power and never inferred (Z/27 is not F_27)")
    ap.add_argument("--solver", default="SCS"); ap.add_argument("--verbose", action="store_true")
    ap.add_argument("--out")
    ap.add_argument("--mkl", action="store_true", help="SCS's MKL Pardiso linear solver (multithreaded; MKL_NUM_THREADS)")
    ap.add_argument("--eps", type=float, default=None)
    ap.add_argument("--real", action="store_true", help="real blocks (base points on the reflection axes): half the embedded size")
    a = ap.parse_args()
    if (a.p is None) == (a.q is None):
        ap.error("give exactly one of --p (a prime field) and --q (any field, with --modulus if q is a prime power)")
    if a.p is not None and a.modulus is not None:
        ap.error("--modulus belongs to --q; a prime field needs none")
    try:
        field = CC.Field(a.q, a.modulus) if a.q is not None else CC.Field(a.p)
    except CC.Refusal as e:
        ap.error(str(e))
    a.p = field.q
    opts = {}
    if a.mkl: opts["mkl"] = True
    if a.eps: opts["eps"] = a.eps
    t0 = time.time(); S = setup(field)
    print(f"[blocks] {field.source}: {S['C']} circles, {S['K']} profile classes after swap/reflection/S3, {int(S['killed'].sum())} killed; setup {time.time()-t0:.1f} s", flush=True)
    t1 = time.time(); v, st, yv = solve(S, solver=a.solver, verbose=a.verbose, solver_opts=opts, real=a.real)
    print(f"[blocks] triple-level bound, block form: {v:.4f} ({st}) in {time.time()-t1:.1f} s", flush=True)
    rec = dict(kind="fplane-sdp-blocks", **CC._ident(field), edges_sha256=CC.graph_sha256(field),
               n=S["n"], real_blocks=a.real, classes=int(S["K"]), killed=int(S["killed"].sum()), value=v, status=st, solver=a.solver,
               seconds=time.time() - t0, claim_scope="a float reading of the block-diagonalised triple-level SDP (rotation-only DFT blocks; the reflection, swap and S3 as variable identifications); must reproduce fplane_sdp.py's direct value at 11 (29.18) and 23 (108.55); never a bound")
    if a.out:
        Path(a.out).write_text(json.dumps(rec, indent=1)); print(f"  wrote {a.out}")

if __name__ == "__main__":
    main()
