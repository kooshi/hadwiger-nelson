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

def setup(p):
    n = p * p; m = p + 1
    Q = lambda v: (v[0] * v[0] + v[1] * v[1]) % p
    circ = fplane.circle(p)
    zeta = None
    for a, b in circ:
        z = (a, b); k = 1
        while z != (1, 0):
            z = L.mul(z, (a, b), p); k += 1
        if k == m:
            zeta = (a, b); break
    assert zeta is not None
    # base points: u_c = the first point of each circle in the (x, y) order; the angle index of every nonzero point
    base = {}; angle = {}
    for x in range(p):
        for y in range(p):
            c = Q((x, y))
            if c and c not in base:
                base[c] = (x, y)
    for c, u in base.items():
        w = u
        for th in range(m):
            angle[w] = (c, th); w = L.mul(w, zeta, p)
    assert len(angle) == n - 1
    classes = sorted(base)  # the p−1 circles
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
    neg = lambda w: ((-w[0]) % p, (-w[1]) % p)
    sub = lambda a, b: ((a[0] - b[0]) % p, (a[1] - b[1]) % p)
    refl = lambda w: (w[0], (-w[1]) % p)
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
                w = L.mul(w, zeta, p)
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
                if c == 1 or cp_ == 1 or Q(sub(u, w)) == 1:
                    killed[cls[idx_prof(c, cp_, th)]] = True
                w = L.mul(w, zeta, p)
    killed[cls[idx_zero(1)]] = True
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
                Mcls[idx_prof(c, cp_, th)] = g0 if d == (0, 0) else cls[idx_zero(Q(d))]
                w = L.mul(w, zeta, p)
    return dict(p=p, n=n, m=m, C=C, classes=classes, ci=ci, cls=cls, K=K, killed=killed, diag_cls=diag_cls, g0=g0,
                NP=NP, Mcls=Mcls, idx_prof=idx_prof, idx_zero=idx_zero, base=base, angle=angle, zeta=zeta, Q=Q)

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

def solve(S, solver="SCS", verbose=False, extra_eq=None):
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
    Ymaps = block_maps(S, "Y"); Mmaps = block_maps(S, "M")
    for (j, d, A), (_, _, Am) in zip(Ymaps, Mmaps):
        D = 2 * d
        Yb = cp.reshape(A @ y, (D, D), order="C"); Mb = cp.reshape(Am @ y, (D, D), order="C")
        cons += [Yb >> 0, Mb - Yb >> 0]
    obj = y[S["g0"]] + S["m"] * sum(y[S["diag_cls"][c]] for c in S["classes"])   # tr Y = 1 + (p+1) Σ_c g(c)
    prob = cp.Problem(cp.Maximize(obj), cons)
    prob.solve(solver=solver, verbose=verbose)
    return prob.value, prob.status, y.value

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--p", type=int, required=True); ap.add_argument("--solver", default="SCS"); ap.add_argument("--verbose", action="store_true")
    ap.add_argument("--out")
    a = ap.parse_args()
    t0 = time.time(); S = setup(a.p)
    print(f"[blocks] p={a.p}: {S['C']} circles, {S['K']} profile classes after swap/reflection/S3, {int(S['killed'].sum())} killed; setup {time.time()-t0:.1f} s", flush=True)
    t1 = time.time(); v, st, yv = solve(S, solver=a.solver, verbose=a.verbose)
    print(f"[blocks] triple-level bound, block form: {v:.4f} ({st}) in {time.time()-t1:.1f} s", flush=True)
    rec = dict(kind="fplane-sdp-blocks", p=a.p, n=S["n"], classes=int(S["K"]), killed=int(S["killed"].sum()), value=v, status=st, solver=a.solver,
               seconds=time.time() - t0, claim_scope="a float reading of the block-diagonalised triple-level SDP (rotation-only DFT blocks; the reflection, swap and S3 as variable identifications); must reproduce fplane_sdp.py's direct value at 11 (29.18) and 23 (108.55); never a bound")
    if a.out:
        Path(a.out).write_text(json.dumps(rec, indent=1)); print(f"  wrote {a.out}")

if __name__ == "__main__":
    main()
