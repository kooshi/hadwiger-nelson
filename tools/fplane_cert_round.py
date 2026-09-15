#!/usr/bin/env python3
"""fplane_cert_round — turn the triple-level semidefinite bound on alpha(UD(F_p, 2)) into an EXACT
rational certificate that `tools/fplane_cert_check.py` accepts.

It is the untrusted half of the pair: it may use a floating-point semidefinite solver, numpy, and
any heuristic at all, because nothing it produces is believed until the checker -- standard library,
exact arithmetic, its own rebuild of the constraint system -- has accepted it.

WHAT IT DOES.
  1. Solves Schrijver's linear form of the triple-level relaxation at p (the same problem as
     `tools/fplane_sdp.py --linear-only`, restated here so the dual variables are reachable):
         maximise  tr Y   over the orbit variables y >= 0,
         subject to  Y(y) >= 0,  M(y) - Y(y) >= 0,  g(0) = 1,  y_k = 0 on every orbit that touches a
                     unit vector,  and  y_k <= y_diag(k).
  2. Takes the two positive semidefinite dual matrices, averages them over the point stabiliser
     O(2, p) (which preserves both positive semidefiniteness and every orbit sum), drops the small
     eigenvalues, and rounds the resulting square-root factor B to rationals over a common
     denominator.  The certificate then carries B, and Z := B^T B is positive semidefinite for ANY
     rational B -- so nothing about the rounding is on the trust surface.
  3. Reads off the multipliers and N.  This is the part worth knowing: once Z1 and Z2 are fixed, the
     multipliers that minimise N are DETERMINED by a two-line rule (`solve_multipliers` in the
     checker, derived in `plans/FS50-certificate-soundness.md` section 5), and N is then an exact
     rational.  So every rounding candidate is scored by its exact N, and the search over
     denominators and eigenvalue thresholds is a search over a number we can compute exactly.
  4. Writes the certificate and runs the checker on it.

A consequence worth stating, because it says where the risk is NOT: any rational positive
semidefinite pair yields a VALID certificate for some N.  A bad rounding cannot produce an unsound
certificate; it can only produce a weak one.  The solver's entire job is to make N small.

THREE FORMS OF THE SAME CERTIFICATE.  `--blocks` presents each matrix as a sum of circulant blocks
instead of writing it out, which is the only form that fits at p = 83.  `--blocks --real` adds the
per-circle Fourier PHASE: with it each block of the SOLVE has size C rather than the 2C + 1 slots the
wire form carries, because the reflection makes the Hermitian Fourier block a diagonal-unitary
conjugate of a real symmetric one.  The reduced dual is pushed back onto the same wire form by an
explicit congruence, so THE CHECKER AND THE FILE FORMAT ARE UNTOUCHED -- see the block of comment
above `wire_block_arrays`, and `--check-real` for the controls.  Measured: at p = 23 the solve falls
from 882.9 s to 146.9 s at the same tolerance, and the bound is the same to six decimals.

USAGE
  build/venv-sdp/bin/python tools/fplane_cert_round.py --p 11 --out data/fs50/cert-p11-N29.json
  build/venv-sdp/bin/python tools/fplane_cert_round.py --p 23 --blocks --real --check-real
"""

from __future__ import annotations

import argparse
import json
import math
import subprocess
import sys
import time
from fractions import Fraction
from pathlib import Path

import numpy as np
import scipy.sparse as sp

sys.path.insert(0, str(Path(__file__).resolve().parent))
import fplane_cert_check as C     # the checker's orbit construction, so the indexing cannot diverge


# --------------------------------------------------------------------------------------------


def solve(B, solver="CLARABEL", verbose=False, opts=None):
    """The linear form, with the duals kept.  Returns (value, Z1, Z2) as float matrices.

    `opts` is passed through to the solver: at p = 23 and above the default first-order tolerance
    (SCS: 1e-4) leaves a dual whose rounding costs more than the gap to the next integer, so the
    caller tightens it and pays the iterations."""
    import cvxpy as cp
    n, K, k0 = B["n"], B["K"], B["k0"]
    orb, g_orbit, sub, t = B["orb"], B["g_orbit"], B["sub"], B["t"]
    rowsidx = np.arange(n * n)
    A = sp.csr_matrix((np.ones(n * n), (rowsidx, np.array(orb))), shape=(n * n, K))
    Morb = np.array([g_orbit[sub[i % n][i // n]] for i in range(n * n)])
    Cm = sp.csr_matrix((np.ones(n * n), (rowsidx, Morb)), shape=(n * n, K))
    y = cp.Variable(K, nonneg=True)
    Y = cp.reshape(A @ y, (n, n), order="C")
    M = cp.reshape(Cm @ y, (n, n), order="C")
    cY, cMY = (Y >> 0), (M - Y >> 0)
    cons = [y[k0] == 1, cY, cMY]
    for k in range(K):
        if B["killed"][k]:
            cons.append(y[k] == 0)
    for k in range(K):
        if B["killed"][k] or k == k0:
            continue
        cons.append(y[k] <= y[B["g_orbit"][B["rep"][k][0]]])
    prob = cp.Problem(cp.Maximize(cp.sum(cp.multiply(np.array(t, dtype=float), y))), cons)
    prob.solve(solver=solver, verbose=verbose, **(opts or {}))
    return prob.value, prob.status, np.asarray(cY.dual_value), np.asarray(cMY.dual_value)


def symmetrise(B, Z):
    """Average Z over the full point stabiliser O(2, p) -- order 2(p+1), the rotations by each point
    of the unit circle and each of those composed with the reflection.  Conjugation by a permutation
    matrix preserves positive semidefiniteness AND every orbit sum, so this is free."""
    n = B["n"]
    rot = B["maps"][:-1]
    refl = B["maps"][-1]
    out = np.zeros_like(Z)
    g = 0
    for r in rot:
        r = np.array(r)
        for e in (0, 1):
            perm = r if e == 0 else np.array([r[refl[i]] for i in range(n)])
            out += Z[np.ix_(perm, perm)]
            g += 1
    return out / g


def gram_round(Z, thresh, den):
    """A rational Gram factor of (an approximation to) Z: eigendecompose, keep the eigenvalues above
    `thresh`, and round the square-root factor to multiples of 1/den.  Returns (rows of Python
    integers, the denominator) -- exact integers, never numpy floats."""
    Zs = (Z + Z.T) / 2
    w, V = np.linalg.eigh(Zs)
    keep = w > thresh
    if not keep.any():
        return [[0] * Z.shape[0]], 1
    Bf = np.sqrt(w[keep])[:, None] * V[:, keep].T
    return [[int(round(float(x))) for x in row] for row in Bf * den], den


def exact_from_gram(num, den, n):
    """Z = B^T B exactly, as integer numerators over den^2."""
    r = len(num)
    cols = [[num[i][u] for i in range(r)] for u in range(n)]
    flat = [0] * (n * n)
    for u in range(n):
        bu = cols[u]
        for v in range(u, n):
            bv = cols[v]
            s = 0
            for i in range(r):
                if bu[i] and bv[i]:
                    s += bu[i] * bv[i]
            flat[u * n + v] = s
            flat[v * n + u] = s
    return flat, den * den


def score(B, rows, num1, d1, num2, d2):
    """The exact N this rounding certifies, and the multipliers that reach it."""
    n = B["n"]
    f1, e1 = exact_from_gram(num1, d1, n)
    f2, e2 = exact_from_gram(num2, d2, n)
    mult, N = C.solve_multipliers(B, rows, f1, e1, f2, e2)
    return N, mult


def build_certificate(p, N, mult, B, rows, num1, d1, num2, d2, extra, psd=None):
    n = B["n"]
    import math
    cert = dict(
        kind=C.KIND, p=p, N=str(N), alpha_bound=math.floor(N),
        claim=(f"every independent set of the unit-distance graph on F_{p}^2 -- every set of points "
               f"no two of which differ by a vector of quadrance 1 -- has at most {math.floor(N)} points"),
        vertex_index=f"v = x*{p} + y for the point (x, y) of F_{p}^2, with 0 <= x, y < {p}",
        edge_rule=(f"two points are adjacent iff their difference (dx, dy) satisfies "
                   f"dx^2 + dy^2 = 1 in F_{p}"),
        symmetry=("O(2,p) x swap x S3 acting on ordered pairs (u, v) of points: (u, v) -> (gu, gv) "
                  "for g in the orthogonal group (the rotations by the points of the unit circle and "
                  "the reflection (x, y) -> (x, -y)); (u, v) -> (v, u); (u, v) -> (-u, v - u)"),
        orbits=[[u, v] for (u, v) in B["rep"]],
        constraints=[dict(kind=a, sense=b, coeffs={str(x): str(y) for x, y in c.items()}, rhs=str(d))
                     for (a, b, c, d) in rows],
        multipliers=[str(x) for x in mult],
        psd=psd if psd is not None else dict(
            Z1=dict(blocks=[dict(U=None, gram=dict(den=str(d1),
                                                   num=[[int(x) for x in row] for row in num1]))]),
            Z2=dict(blocks=[dict(U=None, gram=dict(den=str(d2),
                                                   num=[[int(x) for x in row] for row in num2]))])),
        derivation="plans/FS50-certificate-soundness.md",
        produced_by=("tools/fplane_cert_round.py (untrusted: a floating-point semidefinite solver "
                     "proposes, exact rational arithmetic disposes); checked by "
                     "tools/fplane_cert_check.py, which rebuilds the constraint system from p alone"),
        provenance=extra)
    return cert


# --------------------------------------------------------------------------------------------
# the block form: the only one that fits at p = 83
# --------------------------------------------------------------------------------------------


def weight_vectors(m, j):
    """The two real Fourier weights of index j over the m angles, as float arrays: cos and sin.

    They are the producer's CHOICE, not a premise of the check -- U Z U^T is positive semidefinite
    for any rational U -- but they are the choice that makes N small, because with them the block
    U_j^T Y U_j is exactly the j-th Fourier block of a rotation-invariant Y, which is what the
    relaxation's dual wants to be diagonal in.  At j = 0 and j = m/2 they are integers already."""
    th = np.arange(m)
    return np.cos(2 * np.pi * j * th / m), np.sin(2 * np.pi * j * th / m)


def block_setup(F):
    """The block maps of the SDP, in exactly the convention `fplane_cert_check.load_circulant` reads:
    for each j, the (2C+1)x(2C+1) symmetric matrix U_j^T Y(y) U_j as a sparse linear map of y, and the
    same for M(y).  Returns (js, maps_Y, maps_M, weights)."""
    m, C, K = F["m"], F["C"], F["K"]
    W = 2 * C + 1
    nz, ro, rd, zorb, k0 = F["nz"], F["rot_orb"], F["rot_diff"], F["zorb"], F["k0"]
    js = list(range(m // 2 + 1))
    mapsY, mapsM, weights = [], [], []
    for j in js:
        a, b = weight_vectors(m, j)
        o = 1.0 if j == 0 else 0.0
        Aaa = np.array([float(np.dot(a, np.roll(a, -d))) for d in range(m)])
        Aab = np.array([float(np.dot(a, np.roll(b, -d))) for d in range(m)])
        Aba = np.array([float(np.dot(b, np.roll(a, -d))) for d in range(m)])
        Abb = np.array([float(np.dot(b, np.roll(b, -d))) for d in range(m)])
        Sa, Sb = float(a.sum()), float(b.sum())
        weights.append((a, b, o))
        out = []
        for src in (ro, rd):
            rows, cols, vals = [], [], []

            def put(r, c, k, v):
                if v:
                    rows.append(r * W + c)
                    cols.append(k)
                    vals.append(v)

            for ca in range(C):
                for cb in range(C):
                    base = nz(ca, cb, 0)
                    for d in range(m):
                        k = src[base + d]
                        put(ca, cb, k, Aaa[d])
                        put(ca, C + cb, k, Aab[d])
                        put(C + ca, cb, k, Aba[d])
                        put(C + ca, C + cb, k, Abb[d])
            if o:
                for cb in range(C):
                    put(2 * C, cb, zorb[cb], o * Sa)
                    put(cb, 2 * C, zorb[cb], o * Sa)
                    put(2 * C, C + cb, zorb[cb], o * Sb)
                    put(C + cb, 2 * C, zorb[cb], o * Sb)
                put(2 * C, 2 * C, k0, o * o)
            out.append(sp.csr_matrix((np.array(vals), (np.array(rows), np.array(cols))),
                                     shape=(W * W, K)))
        mapsY.append(out[0])
        mapsM.append(out[1])
    return js, mapsY, mapsM, weights


def solve_blocks(F, rows, solver="SCS", verbose=False, opts=None):
    """The same relaxation as `solve`, block-diagonalised, with the duals kept.  Returns
    (value, status, [W_j], [V_j]) -- one dual matrix per block for Y and for M - Y."""
    import cvxpy as cp
    K, k0 = F["K"], F["k0"]
    js, mapsY, mapsM, weights = block_setup(F)
    W = 2 * F["C"] + 1
    y = cp.Variable(K, nonneg=True)
    cons = [y[k0] == 1]
    for k in range(K):
        if F["killed"][k]:
            cons.append(y[k] == 0)
    for (kind, _sense, coeffs, _rhs) in rows:
        if kind == "le_diag":
            neg = [x for x, c in coeffs.items() if c < 0][0]
            pos = [x for x, c in coeffs.items() if c > 0][0]
            cons.append(y[neg] <= y[pos])
    cY, cM = [], []
    for AY, AM in zip(mapsY, mapsM):
        Yb = cp.reshape(AY @ y, (W, W), order="C")
        Mb = cp.reshape(AM @ y, (W, W), order="C")
        c1, c2 = (Yb >> 0), (Mb - Yb >> 0)
        cons += [c1, c2]
        cY.append(c1)
        cM.append(c2)
    prob = cp.Problem(cp.Maximize(cp.sum(cp.multiply(np.array(F["t"], dtype=float), y))), cons)
    prob.solve(solver=solver, verbose=verbose, **(opts or {}))
    return (prob.value, prob.status, [np.asarray(c.dual_value) for c in cY],
            [np.asarray(c.dual_value) for c in cM], weights)


def round_weights(a, b, wden):
    return ([int(round(float(x) * wden)) for x in a], [int(round(float(x) * wden)) for x in b])


def circulant_psd(F, Ws, weights, sgn, thr, den, wden):
    """The wire form of one matrix: rounded weights and a rational Gram factor per block."""
    blocks = []
    scale = max(float(np.abs(Z).max()) for Z in Ws) or 1.0
    for (Z, (a, b, o)) in zip(Ws, weights):
        num, d = gram_round(sgn * Z, thr * scale, den)
        ai, bi = round_weights(a, b, wden)
        blocks.append(dict(a=ai, b=bi, o=int(round(o * wden)),
                           gram=dict(den=str(d), num=[[int(x) for x in row] for row in num])))
    return dict(circulant=dict(weight_den=str(wden), blocks=blocks))


def score_blocks(F, rows, psd1, psd2):
    quiet = lambda _s: None
    rot1, d1 = C.load_circulant(psd1["circulant"], F, "Z1", False, quiet)
    rot2, d2 = C.load_circulant(psd2["circulant"], F, "Z2", False, quiet)
    s1, _ = C.orbit_sums_from_rot(F, rot1, d1)
    s2y, s2m = C.orbit_sums_from_rot(F, rot2, d2)
    return C.multipliers_from_sums(F, rows, s1, d1, s2y, s2m, d2)


# --------------------------------------------------------------------------------------------
# the REAL block form: the same relaxation with half the block size, and no change to the checker
# --------------------------------------------------------------------------------------------
#
# WHY IT IS THE SAME CERTIFICATE.  A wire block (above, and `load_circulant`) carries ONE cosine and
# ONE sine weight vector shared by every circle, and its map into the plane is
#     U[(c, theta), c] = a[theta],  U[(c, theta), C + c] = b[theta],  U[origin, 2C] = o.
# The block-diagonalisation that makes the solve cheap wants a per-circle PHASE instead:
#     w_c[theta] = cos(pi j (2 theta + a_c) / m),   a_c the angle of the reflected base point,
# because with the base points fixed the reflection forces f_{cc'}(d) = f_{cc'}(a_c' - a_c - d), hence
# exp(i pi j (a_c - a_c')/m) B_j[c, c'] is REAL and the Hermitian block of size C -- which the wire
# form carries as a 2C-slot real embedding of twice the spectrum -- collapses to a real symmetric one
# of size C.  A per-circle weight is not expressible on the wire; but
#     w_c = cos(phi_c) a + sin(phi_c) b,      phi_c = pi j a_c / m,
# so the reduced map is V_j = U_j T_j for an explicit (2C+1) x d matrix T_j, and
#     <W, T_j^T (U_j^T Y U_j) T_j>  =  <T_j W T_j^T, U_j^T Y U_j>          identically in Y.
# So: solve with the reduced blocks, then push each reduced dual W through the congruence and write
# it on the wire exactly as before.  T_j W T_j^T is positive semidefinite whenever W is, whatever T_j
# is, so nothing here reaches the trust surface -- a wrong phase can only make N bigger.  At j = 0 and
# j = m / 2 the sine weight is identically zero, so T_j is a plain selection of the cosine slots (plus
# the origin at j = 0) and the reduction is trimming provable zeros.
# Controlled at p = 11 and 23 by `--check-real`: the vectorised wire arrays agree with `block_setup`
# entry by entry, the reduced map agrees with the explicit congruence, and the wire block's whole
# spectrum is the reduced block's with each eigenvalue doubled (so the reduction loses nothing).


def wire_block_arrays(F, j, which):
    """Block `j` of the wire map as (rows, cols, vals) over the W x W slots -- `block_setup`'s
    convention, which is `fplane_cert_check.load_circulant`'s, vectorised so that p = 83 is affordable.

    `which` is "Y" (the pair's own orbit) or "M" (the orbit of its difference)."""
    m, C, K, NP = F["m"], F["C"], F["K"], F["NP"]
    W = 2 * C + 1
    a, b = weight_vectors(m, j)
    o = 1.0 if j == 0 else 0.0
    corr = lambda x, y: np.array([float(np.dot(x, np.roll(y, -d))) for d in range(m)])
    Aaa, Aab, Aba, Abb = corr(a, a), corr(a, b), corr(b, a), corr(b, b)
    src = F["rot_orb"] if which == "Y" else F["rot_diff"]
    cols1 = np.asarray(src[:NP], dtype=np.int64)          # flat order (ca, cb, d), as `nz` numbers it
    ca = np.repeat(np.arange(C, dtype=np.int64), C * m)
    cb = np.tile(np.repeat(np.arange(C, dtype=np.int64), m), C)
    rows = np.concatenate([ca * W + cb, ca * W + C + cb,
                           (C + ca) * W + cb, (C + ca) * W + C + cb])
    cols = np.tile(cols1, 4)
    rep = lambda A: np.tile(A, C * C)
    vals = np.concatenate([rep(Aaa), rep(Aab), rep(Aba), rep(Abb)])
    if o:
        zorb = np.asarray(F["zorb"], dtype=np.int64)
        cc = np.arange(C, dtype=np.int64)
        Sa, Sb = float(a.sum()), float(b.sum())
        rows = np.concatenate([rows, 2 * C * W + cc, cc * W + 2 * C,
                               2 * C * W + C + cc, (C + cc) * W + 2 * C,
                               np.array([2 * C * W + 2 * C], dtype=np.int64)])
        cols = np.concatenate([cols, zorb, zorb, zorb, zorb,
                               np.array([F["k0"]], dtype=np.int64)])
        vals = np.concatenate([vals, np.full(C, o * Sa), np.full(C, o * Sa),
                               np.full(C, o * Sb), np.full(C, o * Sb), np.array([o * o])])
    return rows, cols, vals, W


def live_circles(F):
    """The circles whose profile orbits are not ALL killed by a unit vector.  A plant on a dead circle
    -- the unit circle itself, always -- moves nothing in the relaxation, so it is a control that
    cannot fire; this is what names it before it is believed."""
    C, m = F["C"], F["m"]
    ro, killed, nzf = F["rot_orb"], F["killed"], F["nz"]
    live = []
    for ca in range(C):
        if any(not killed[ro[nzf(ca, cb, d)]] for cb in range(C) for d in range(m)):
            live.append(ca)
    return live


def real_congruence(F, j, plant=None):
    """The congruence T_j of block `j`: wire slot s goes to reduced slot sigma[s] with weight wgt[s]
    (sigma = -1 drops the slot).  `plant` = (circle index, shift) perturbs one circle's reflection
    angle -- a NEGATIVE CONTROL, which must make the bound weaker and can never make it wrong."""
    m, C = F["m"], F["C"]
    W = 2 * C + 1
    a_off = np.asarray(F["a_off"], dtype=float).copy()
    if plant is not None:
        a_off[plant[0] % C] = (a_off[plant[0] % C] + plant[1]) % m
    sigma = np.full(W, -1, dtype=np.int64)
    wgt = np.zeros(W)
    cc = np.arange(C, dtype=np.int64)
    if j == 0 or 2 * j == m:
        d = C + (1 if j == 0 else 0)
        sigma[:C] = cc
        wgt[:C] = 1.0
        if j == 0:
            sigma[2 * C] = C
            wgt[2 * C] = 1.0
    else:
        d = C
        phi = np.pi * j * a_off / m
        sigma[:C] = cc
        wgt[:C] = np.cos(phi)
        sigma[C:2 * C] = cc
        wgt[C:2 * C] = np.sin(phi)
    T = np.zeros((W, d))
    for s in range(W):
        if sigma[s] >= 0:
            T[s, sigma[s]] = wgt[s]
    return d, sigma, wgt, T


def real_block_setup(F, plant=None):
    """The reduced real blocks: (js, dims, Ts, mapsY, mapsM, weights).  The wire arrays of one block
    are built and immediately pushed through the congruence, so the W x W maps -- four times the
    entries -- never all exist at once."""
    m, C, K = F["m"], F["C"], F["K"]
    js = list(range(m // 2 + 1))
    dims, Ts, mapsY, mapsM, weights = [], [], [], [], []
    for j in js:
        d, sigma, wgt, T = real_congruence(F, j, plant)
        a, b = weight_vectors(m, j)
        weights.append((a, b, 1.0 if j == 0 else 0.0))
        out = []
        for which in ("Y", "M"):
            rows, cols, vals, W = wire_block_arrays(F, j, which)
            s1, s2 = rows // W, rows % W
            keep = (sigma[s1] >= 0) & (sigma[s2] >= 0) & (vals != 0)
            nr = sigma[s1[keep]] * d + sigma[s2[keep]]
            nv = vals[keep] * wgt[s1[keep]] * wgt[s2[keep]]
            out.append(sp.coo_matrix((nv, (nr, cols[keep])), shape=(d * d, K)).tocsr())
            del rows, cols, vals, s1, s2, keep, nr, nv
        mapsY.append(out[0])
        mapsM.append(out[1])
        dims.append(d)
        Ts.append(T)
    return js, dims, Ts, mapsY, mapsM, weights


def build_real_problem(F, rows, plant=None):
    """The relaxation in the reduced real blocks, as a cvxpy problem plus the per-block congruences.
    Returns (prob, y, cY, cM, Ts, weights) -- `cY[j]`, `cM[j]` the two positive semidefinite
    constraints of block j, whose duals push back onto the wire form as `T_j W T_j^T`."""
    import cvxpy as cp
    K, k0 = F["K"], F["k0"]
    t0 = time.time()
    js, dims, Ts, mapsY, mapsM, weights = real_block_setup(F, plant)
    nnz = sum(A.nnz for A in mapsY) + sum(A.nnz for A in mapsM)
    print(f"[blocks] the real blocks: {len(js)} of sizes {min(dims)}-{max(dims)} (against "
          f"{2 * (2 * F['C'] + 1)} embedded in the Hermitian form), {nnz} map entries, "
          f"{time.time() - t0:.1f} s", flush=True)
    y = cp.Variable(K, nonneg=True)
    cons = [y[k0] == 1]
    for k in range(K):
        if F["killed"][k]:
            cons.append(y[k] == 0)
    for (kind, _sense, coeffs, _rhs) in rows:
        if kind == "le_diag":
            neg = [x for x, c in coeffs.items() if c < 0][0]
            pos = [x for x, c in coeffs.items() if c > 0][0]
            cons.append(y[neg] <= y[pos])
    cY, cM = [], []
    for d, AY, AM in zip(dims, mapsY, mapsM):
        Yb = cp.reshape(AY @ y, (d, d), order="C")
        Mb = cp.reshape(AM @ y, (d, d), order="C")
        c1, c2 = (Yb >> 0), (Mb - Yb >> 0)
        cons += [c1, c2]
        cY.append(c1)
        cM.append(c2)
    prob = cp.Problem(cp.Maximize(cp.sum(cp.multiply(np.array(F["t"], dtype=float), y))), cons)
    return prob, y, cY, cM, Ts, weights


def solve_blocks_real(F, rows, solver="SCS", verbose=False, opts=None, plant=None):
    """The same relaxation as `solve_blocks`, in the reduced real blocks, with the duals pushed back
    through the congruence so that everything downstream -- the sign probe, the rounding sweep, the
    wire form, the checker -- is byte-for-byte the same code as the Hermitian form uses."""
    prob, y, cY, cM, Ts, weights = build_real_problem(F, rows, plant)
    prob.solve(solver=solver, verbose=verbose, **(opts or {}))
    push = lambda T, c: T @ np.asarray(c.dual_value) @ T.T
    return (prob.value, prob.status, [push(T, c) for T, c in zip(Ts, cY)],
            [push(T, c) for T, c in zip(Ts, cM)], weights)


def solve_blocks_real_chunked(F, rows, eps=1e-8, chunk=2000, max_iters=200000, ckpt=None,
                              plant=None, round_only=False):
    """The same solve, driven through SCS's OWN API in warm-started chunks, so that it is observable
    (one flushed line per chunk: iterations, residuals, gap, objective) and RESUMABLE (the iterate
    x, y, s goes to `ckpt` after every chunk; a relaunch continues from it).

    Written 2026-09-15 after a four-hour solve at p = 83 was lost with nothing on disk -- the
    architecture is `tools/fplane_sdp_scs.py`'s, applied to the producer, whose duals then come out in
    the producer's own convention and need no translation.  cvxpy still builds and inverts the problem,
    so the cone data and the dual unpacking are the identical code path the one-shot solve uses; only
    the iteration loop is ours.  Controlled at 11 and 23: the chunked path must return the same float
    bound and produce the same exact N as the one-shot path."""
    import cvxpy as cp
    import scs as scs_mod
    prob, y, cY, cM, Ts, weights = build_real_problem(F, rows, plant)
    t0 = time.time()
    data, chain, inv = prob.get_problem_data(cp.SCS)
    dims = data["dims"]
    cone = dict(z=int(dims.zero), l=int(dims.nonneg), s=[int(x) for x in dims.psd])
    A, b, c = data["A"], data["b"], data["c"]
    print(f"[blocks] SCS data: A {A.shape} nnz {A.nnz}; {len(cone['s'])} positive semidefinite "
          f"blocks of size <= {max(cone['s'])}; built in {time.time() - t0:.0f} s", flush=True)
    ck = Path(ckpt) if ckpt else None
    x0 = yv = sv = None
    done = 0
    if ck is not None and ck.exists():
        z = np.load(ck)
        x0, yv, sv, done = z["x"], z["y"], z["s"], int(z["iters"])
        if x0.shape[0] != A.shape[1] or yv.shape[0] != A.shape[0]:
            raise SystemExit(f"[blocks] {ck} holds an iterate of shape {x0.shape}/{yv.shape}, but this "
                             f"problem is {A.shape}: wrong p, or a different formulation")
        print(f"[blocks] resumed from {ck}: {done} iterations already done", flush=True)
    if round_only:
        # ANYTIME: read the running solve's iterate and round a certificate from it, WITHOUT advancing
        # or overwriting it.  Any dual yields a sound certificate (section 4 of the derivation), so a
        # half-converged iterate gives a real bound -- weaker than the converged one, and available
        # hours earlier.  One SCS iteration is taken only because cvxpy inverts a solver RESULT, not a
        # bare vector; the checkpoint is not written back.
        if x0 is None:
            raise SystemExit(f"[blocks] --round-only wants an existing --scs-ckpt to round from")
        print(f"[blocks] --round-only: rounding the iterate at {done} iterations; the checkpoint is "
              f"NOT advanced and NOT rewritten", flush=True)
        solver = scs_mod.SCS(dict(A=A, b=b, c=c), cone, eps_abs=eps, eps_rel=eps, max_iters=1,
                             verbose=False, normalize=True)
        t1 = time.time()
        result = solver.solve(warm_start=True, x=x0, y=yv, s=sv)
        info = result["info"]
        print(f"[blocks] the iterate reads pobj {info['pobj']:.6f} dobj {info['dobj']:.6f} "
              f"res_pri {info['res_pri']:.2e} res_dual {info['res_dual']:.2e} gap {info['gap']:.2e} "
              f"({time.time() - t1:.0f} s)", flush=True)
        prob.unpack_results(result, chain, inv)
        push0 = lambda T, cc: T @ np.asarray(cc.dual_value) @ T.T
        return (prob.value, f"iterate at {done} iterations ({info['status']})",
                [push0(T, cc) for T, cc in zip(Ts, cY)],
                [push0(T, cc) for T, cc in zip(Ts, cM)], weights)
    solver = scs_mod.SCS(dict(A=A, b=b, c=c), cone, eps_abs=eps, eps_rel=eps, max_iters=chunk,
                         verbose=False, normalize=True)
    result = None
    nch = 0
    while done < max_iters:
        t1 = time.time()
        result = (solver.solve(warm_start=True, x=x0, y=yv, s=sv) if x0 is not None
                  else solver.solve())
        info = result["info"]
        x0, yv, sv = result["x"], result["y"], result["s"]
        done += int(info["iter"])
        nch += 1
        if ck is not None:
            ck.parent.mkdir(parents=True, exist_ok=True)
            np.savez(ck, x=x0, y=yv, s=sv, iters=done)
        print(f"[blocks] chunk {nch}: +{info['iter']} it ({done} total) in {time.time() - t1:.0f} s; "
              f"pobj {info['pobj']:.6f} dobj {info['dobj']:.6f} res_pri {info['res_pri']:.2e} "
              f"res_dual {info['res_dual']:.2e} gap {info['gap']:.2e} -- {info['status']}", flush=True)
        st = info["status"].lower()
        # THE TRAP THIS LOOP IS WRITTEN AROUND, caught by the control at p = 11: SCS ends EVERY chunk
        # with the status "solved (inaccurate - reached max_iters)", because max_iters IS the chunk.
        # A `startswith("solved")` break therefore stops after one chunk and reports a bound that is
        # merely wherever the iterate happened to be -- 29.2729 against the true 29.1768 at p = 11,
        # and it looks like a clean success.  Only a status that says "solved" and does NOT say
        # "inaccurate" is convergence.
        if st.startswith("solved") and "inaccurate" not in st:
            break
        if not st.startswith("solved"):
            print(f"[blocks] SCS stopped with status {info['status']!r} -- not a convergence and not "
                  f"a chunk boundary; the loop ends here and the dual is whatever it is (the "
                  f"certificate stays sound, the bound may be weak)", flush=True)
            break
    else:
        print(f"[blocks] the iteration cap {max_iters} was reached without convergence; the dual is "
              f"used as it stands (sound, possibly weak)", flush=True)
    prob.unpack_results(result, chain, inv)
    push = lambda T, cc: T @ np.asarray(cc.dual_value) @ T.T
    return (prob.value, prob.status, [push(T, cc) for T, cc in zip(Ts, cY)],
            [push(T, cc) for T, cc in zip(Ts, cM)], weights)


def check_real(p, out=sys.stdout):
    """The control on the real form, at a prime small enough to do everything twice.

    (1) the vectorised wire arrays equal `block_setup`'s map, entry by entry;
    (2) the reduced map equals the explicit congruence T^T A T;
    (3) the wire block's whole spectrum is the reduced block's with each eigenvalue doubled -- so the
        reduction loses NOTHING (a weaker reduction would show a narrower spectrum);
    (4) the planted wrong reflection angle and the flipped phase sign both LOSE (3): the controls are
        reachable, not merely unfired."""
    def log(s):
        print(s, file=out, flush=True)
    F = C.build_orbits_fast(p)
    m, Cc, K = F["m"], F["C"], F["K"]
    W = 2 * Cc + 1
    js = list(range(m // 2 + 1))
    rng = np.random.default_rng(12345)
    yv = rng.random(K)
    bad = 0
    if p <= 23:
        _js, mapsY, mapsM, _w = block_setup(F)
        for j, (AY, AM) in zip(js, zip(mapsY, mapsM)):
            for which, Aref in (("Y", AY), ("M", AM)):
                rows, cols, vals, WW = wire_block_arrays(F, j, which)
                Amine = sp.coo_matrix((vals, (rows, cols)), shape=(WW * WW, K)).tocsr()
                diff = np.abs((Amine - Aref) @ yv).max()
                if WW != W or diff > 1e-9:
                    log(f"  FAIL wire arrays p={p} j={j} {which}: max |mine - block_setup| = {diff:.3e}")
                    bad += 1
        log(f"  (1) the vectorised wire arrays agree with block_setup at every block, both matrices"
            if not bad else f"  (1) FAILED at {bad} block(s)")
    else:
        log(f"  (1) SKIPPED at p = {p}: `block_setup`'s Python loops cost 4 x {Cc}^2 x {m} appends per "
            f"block, which is why the vectorised arrays exist.  The agreement is checked at p = 3, 7, "
            f"11, 19, 23; here (3) below is the informative check and does not depend on (1).")
    WIRE = {}

    def wire_dense(j):
        if j not in WIRE:
            rows, cols, vals, WW = wire_block_arrays(F, j, "Y")
            A = sp.coo_matrix((vals, (rows, cols)), shape=(WW * WW, K)).tocsr()
            M = np.asarray(A @ yv).reshape(W, W)
            WIRE[j] = (M + M.T) / 2
        return WIRE[j]
    _js, dims, Ts, rY, rM, _w = real_block_setup(F)
    worst_cong = worst_spec = 0.0
    for j, d, T, A in zip(js, dims, Ts, rY):
        Aw = wire_dense(j)
        Ar = np.asarray(A @ yv).reshape(d, d)
        Ar = (Ar + Ar.T) / 2
        worst_cong = max(worst_cong, float(np.abs(Ar - T.T @ Aw @ T).max()))
        wr = np.linalg.eigvalsh(Ar)
        pred = np.concatenate([wr, wr]) if 0 < j < m // 2 else wr
        pred = np.sort(np.concatenate([pred, np.zeros(W - len(pred))]))
        worst_spec = max(worst_spec, float(np.abs(np.sort(np.linalg.eigvalsh(Aw)) - pred).max()))
    log(f"  (2) the reduced map equals T^T A T: max difference {worst_cong:.3e}")
    log(f"  (3) the wire spectrum is the reduced spectrum doubled: max difference {worst_spec:.3e}"
        f"  -- the reduction is exact")
    lc = [c for c in live_circles(F) if F["a_off"][c] % m]
    c0 = lc[0] if lc else live_circles(F)[0]
    for name, kw in ((f"a planted reflection angle (circle {c0}, quadrance "
                      f"{F['classes'][c0]}, live, +1)", dict(plant=(c0, 1))),
                     ("the flipped phase sign", dict(flip=True))):
        worst = 0.0
        for j in js:
            if not (0 < j < m // 2):
                continue
            d, sigma, wgt, T = real_congruence(F, j, kw.get("plant"))
            if kw.get("flip"):
                T = T.copy()
                T[Cc:2 * Cc, :] *= -1
            Aw = wire_dense(j)
            Ar = T.T @ Aw @ T
            wr = np.linalg.eigvalsh((Ar + Ar.T) / 2)
            pred = np.sort(np.concatenate([wr, wr, np.zeros(W - 2 * len(wr))]))
            worst = max(worst, float(np.abs(np.sort(np.linalg.eigvalsh(Aw)) - pred).max()))
        log(f"  (4) {name}: the doubling identity is off by {worst:.3f} "
            f"-- {'the control is REACHABLE' if worst > 1e-3 else 'DEAD CONTROL'}")
    ok = (bad == 0 and worst_cong < 1e-9 and worst_spec < 1e-8)
    log(f"  {'all real-form controls green' if ok else 'REAL-FORM CONTROLS FAILED'} at p = {p}")
    return ok


def main_blocks(a):
    """Phase E's producer: the certificate at a prime where the matrix cannot be written out."""
    t0 = time.time()
    plant = None
    if a.plant_phase:
        plant = tuple(int(x) for x in a.plant_phase.split(","))
        if len(plant) != 2:
            raise SystemExit("--plant-phase wants 'circle,shift'")
        if not a.real:
            raise SystemExit("--plant-phase is a control on the real block form; pass --real")
    F = C.build_orbits_fast(a.p)
    if plant is not None:
        live = live_circles(F)
        if plant[0] % F["C"] not in live:
            raise SystemExit(f"[blocks] --plant-phase {plant[0]},{plant[1]}: every orbit of circle "
                             f"{plant[0]} (quadrance {F['classes'][plant[0] % F['C']]}) is killed by a "
                             f"unit vector, so the plant moves NOTHING and the control cannot fire.  "
                             f"Live circles: {live[:8]}{' ...' if len(live) > 8 else ''}")
        print(f"[blocks] NEGATIVE CONTROL: the reflection angle of circle {plant[0]} (quadrance "
              f"{F['classes'][plant[0] % F['C']]}, a live circle) is shifted by {plant[1]}.  The "
              f"RELAXATION'S OPTIMUM can then only rise -- T^T A T >= 0 is implied by A >= 0 for any T, "
              f"so a planted T is a weaker constraint -- and the certificate stays SOUND whatever "
              f"happens.  N is that optimum plus a rounding error of order 1e-4, so N itself is not "
              f"monotone: read the float bound, not N, for the plant's effect.", flush=True)
    rows = C.canonical_constraints(F)
    print(f"[blocks] p = {a.p}: {F['n']} points, {F['C']} circles, {F['NR']} rotation orbits, "
          f"{F['K']} pair orbits, {sum(F['killed'])} killed, {len(rows)} canonical constraints "
          f"({time.time() - t0:.1f} s)", flush=True)
    cache = Path(a.dual_cache) if a.dual_cache else None
    if cache is not None and cache.exists():
        z = np.load(cache, allow_pickle=True)
        val, status = float(z["val"]), str(z["status"])
        Ws = [z[f"W{i}"] for i in range(int(z["nb"]))]
        Vs = [z[f"V{i}"] for i in range(int(z["nb"]))]
        weights = [(z[f"wa{i}"], z[f"wb{i}"], float(z[f"wo{i}"])) for i in range(int(z["nb"]))]
        print(f"[blocks] the float bound, from the cache {cache}: {val:.6f} ({status}); the solve is "
              f"skipped", flush=True)
    else:
        opts = {}
        if a.eps is not None:
            opts.update(eps_abs=a.eps, eps_rel=a.eps)
        if a.max_iters is not None:
            opts["max_iters"] = a.max_iters
        t1 = time.time()
        if a.real and a.chunk:
            val, status, Ws, Vs, weights = solve_blocks_real_chunked(
                F, rows, eps=(a.eps if a.eps is not None else 1e-8), chunk=a.chunk,
                max_iters=(a.max_iters or 200000), ckpt=a.scs_ckpt, plant=plant,
                round_only=a.round_only)
        elif a.real:
            val, status, Ws, Vs, weights = solve_blocks_real(F, rows, solver=a.solver,
                                                             verbose=a.verbose, opts=opts,
                                                             plant=plant)
        else:
            val, status, Ws, Vs, weights = solve_blocks(F, rows, solver=a.solver, verbose=a.verbose,
                                                        opts=opts)
        print(f"[blocks] the float bound: {val:.6f} ({status}, "
              f"{'SCS, chunked' if (a.real and a.chunk) else a.solver}, "
              f"{'real' if a.real else 'Hermitian'} blocks) in {time.time()-t1:.1f} s", flush=True)
        if cache is not None:
            cache.parent.mkdir(parents=True, exist_ok=True)
            d = dict(val=val, status=status, nb=len(Ws))
            for i, (Wm, Vm, (wa, wb, wo)) in enumerate(zip(Ws, Vs, weights)):
                d[f"W{i}"], d[f"V{i}"] = Wm, Vm
                d[f"wa{i}"], d[f"wb{i}"], d[f"wo{i}"] = wa, wb, wo
            np.savez_compressed(cache, **d)
            print(f"[blocks] the duals cached in {cache} "
                  f"({cache.stat().st_size / 1e6:.1f} MB)", flush=True)
    seen = {}
    ck = Path(a.ckpt) if a.ckpt else None
    if ck is not None and ck.exists():
        for line in ck.read_text().splitlines():
            if line.strip():
                r = json.loads(line)
                seen[(r["s1"], r["s2"], r["thr"], r["den"], r["wden"])] = Fraction(r["N"])
        print(f"[blocks] the checkpoint {ck} holds {len(seen)} scored candidate(s)", flush=True)

    def record(key, N):
        seen[key] = N
        if ck is None:
            return
        ck.parent.mkdir(parents=True, exist_ok=True)
        with ck.open("a") as fh:
            fh.write(json.dumps(dict(p=a.p, s1=key[0], s2=key[1], thr=key[2], den=key[3],
                                     wden=key[4], N=str(N), N_float=float(N))) + "\n")

    thresholds = [float(x) for x in a.thresholds.split(",")]
    denominators = [int(x) for x in a.denominators.split(",")]
    wdens = [int(x) for x in a.weight_denominators.split(",")]

    def try_candidate(key):
        """Score one rounding, exactly, through the checker's own arithmetic.  Returns N or None."""
        if key in seen:
            return seen[key], "  (from the checkpoint)"
        (s1, s2, thr, den, wd) = key
        t1 = time.time()
        psd1 = circulant_psd(F, Ws, weights, s1, thr, den, wd)
        psd2 = circulant_psd(F, Vs, weights, s2, thr, den, wd)
        try:
            _m, N = score_blocks(F, rows, psd1, psd2)
        except (ValueError, C.Refusal) as e:
            print(f"[blocks]   {key}: no certificate ({e})", flush=True)
            return None, ""
        record(key, N)
        return N, f"  ({time.time() - t1:.0f} s)"

    # 1. the dual SIGN convention is the solver's, not ours: one cheap probe settles it.  Any sign
    #    gives a SOUND certificate; only one gives a small N.
    probe = {}
    base_key = (thresholds[0], denominators[0], wdens[0])
    for s1 in (1, -1):
        for s2 in (1, -1):
            N, tag = try_candidate((s1, s2) + base_key)
            if N is None:
                continue
            probe[(s1, s2)] = N
            print(f"[blocks]   dual signs ({s1:+d},{s2:+d}): N = {float(N):.6f}{tag}", flush=True)
    if not probe:
        print("[blocks] no sign convention produced a certificate at all")
        return 1
    (s1, s2) = min(probe, key=lambda k: probe[k])
    print(f"[blocks] taking the dual signs ({s1:+d},{s2:+d})", flush=True)
    # 2. the sweep, every candidate scored by the exact bound it proves
    best = None
    for thr in thresholds:
        for den in denominators:
            for wd in wdens:
                key = (s1, s2, thr, den, wd)
                N, tag = try_candidate(key)
                if N is None:
                    continue
                if best is None or N < best[0]:
                    best = (N, key)
                    tag += "  <- best so far"
                print(f"[blocks]   cut {thr:g}, gram denominator {den}, weight denominator {wd}: "
                      f"N = {float(N):.6f}{tag}", flush=True)
    if best is None:
        print("[blocks] no candidate produced a certificate")
        return 1
    (N, (s1, s2, thr, den, wd)) = best
    psd1 = circulant_psd(F, Ws, weights, s1, thr, den, wd)
    psd2 = circulant_psd(F, Vs, weights, s2, thr, den, wd)
    mult, N2 = score_blocks(F, rows, psd1, psd2)
    if N2 != N:
        raise SystemExit(f"[blocks] the winner re-scored to {N2}, not the {N} the sweep recorded")
    print(f"[blocks] best exact N = {N} = {float(N):.6f}; alpha(UD(F_{a.p}, 2)) <= {math.floor(N)}",
          flush=True)
    extra = dict(float_bound=float(val), solver=a.solver, solver_status=status,
                 dual_signs=[s1, s2], eigenvalue_cut=thr, gram_denominator=den,
                 weight_denominator=wd, blocks=len(Ws), seconds=time.time() - t0,
                 block_form=("real (per-circle Fourier phase, pushed onto the wire's shared cosine "
                             "and sine slots by the congruence T of `real_block_setup`)"
                             if a.real else "Hermitian (the wire's 2C+1 slots directly)"),
                 planted_phase=(list(plant) if plant else None))
    cert = build_certificate(a.p, N, mult, F, rows, None, None, None, None, extra,
                             psd=dict(Z1=psd1, Z2=psd2))
    if a.out:
        Path(a.out).parent.mkdir(parents=True, exist_ok=True)
        Path(a.out).write_text(json.dumps(cert))
        print(f"[blocks] wrote {a.out} ({Path(a.out).stat().st_size / 1e6:.2f} MB)", flush=True)
        print("[blocks] handing it to the checker (a separate program, standard library only):",
              flush=True)
        r = subprocess.run(["python3", "tools/fplane_cert_check.py", a.out,
                            "--k", str(math.ceil(F["n"] / math.floor(N)) - 1)])
        return r.returncode
    return 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--p", type=int, required=True)
    ap.add_argument("--solver", default="CLARABEL")
    ap.add_argument("--out")
    ap.add_argument("--denominators", default="1000,10000,100000,1000000,10000000,100000000")
    ap.add_argument("--thresholds", default="1e-9,1e-7,1e-6,1e-5,1e-4,1e-3")
    ap.add_argument("--dual-cache", help="npz file holding the symmetrised float duals: written after "
                                         "the solve, read instead of solving when it already exists")
    ap.add_argument("--ckpt", help="JSON-lines file, one scored rounding candidate per line; a resume "
                                   "skips every candidate already in it")
    ap.add_argument("--eps", type=float, help="the solver's tolerance (SCS: eps_abs = eps_rel = eps)")
    ap.add_argument("--max-iters", type=int, help="the solver's iteration cap")
    ap.add_argument("--verbose", action="store_true")
    ap.add_argument("--blocks", action="store_true",
                    help="the circulant block form: the only one that fits at p = 83")
    ap.add_argument("--weight-denominators", default="1000000",
                    help="denominators for the rounded Fourier weights (block form only)")
    ap.add_argument("--real", action="store_true",
                    help="the REAL block form: the reduced blocks of size C (against 2C+1 embedded), "
                         "the duals pushed back onto the same wire form -- the checker is untouched")
    ap.add_argument("--plant-phase", metavar="CIRCLE,SHIFT",
                    help="negative control (needs --real): shift one circle's reflection angle, which "
                         "must leave the certificate sound and make N larger")
    ap.add_argument("--chunk", type=int,
                    help="with --real: drive SCS in warm-started chunks of this many iterations, "
                         "printing one flushed line each and checkpointing the iterate to --scs-ckpt, "
                         "so a long solve is observable and a kill costs one chunk")
    ap.add_argument("--scs-ckpt", help="where the chunked solve saves its iterate (npz); a relaunch "
                                       "with the same file continues from it")
    ap.add_argument("--round-only", action="store_true",
                    help="with --real --chunk --scs-ckpt: round a certificate from the checkpoint as "
                         "it stands, without advancing or rewriting it -- a sound (weaker) bound from "
                         "a solve still in flight")
    ap.add_argument("--check-real", action="store_true",
                    help="run the real form's controls at p and exit")
    a = ap.parse_args()
    if a.check_real:
        return 0 if check_real(a.p) else 1
    if a.blocks:
        return main_blocks(a)
    t0 = time.time()
    B = C.build_orbits(a.p)
    rows = C.canonical_constraints(B)
    n, K = B["n"], B["K"]
    print(f"[round] p = {a.p}: {n} points, {K} pair orbits, {sum(B['killed'])} killed, "
          f"{len(rows)} canonical constraints", flush=True)
    cache = Path(a.dual_cache) if a.dual_cache else None
    if cache is not None and cache.exists():
        z = np.load(cache)
        val, status, Z1f, Z2f = float(z["val"]), str(z["status"]), z["Z1"], z["Z2"]
        if Z1f.shape != (n, n):
            raise SystemExit(f"[round] {cache} holds {Z1f.shape} duals, not {n}x{n}: wrong p")
        print(f"[round] the float bound, from the cache {cache}: {val:.6f} ({status}); "
              f"the semidefinite solve is skipped", flush=True)
    else:
        opts = {}
        if a.eps is not None:
            opts.update(eps_abs=a.eps, eps_rel=a.eps) if a.solver == "SCS" else opts.update(tol_gap_abs=a.eps, tol_gap_rel=a.eps, tol_feas=a.eps)
        if a.max_iters is not None:
            opts["max_iters"] = a.max_iters
        val, status, Z1f, Z2f = solve(B, solver=a.solver, verbose=a.verbose, opts=opts)
        print(f"[round] the float bound: {val:.6f} ({status}, {a.solver}) in {time.time()-t0:.1f} s", flush=True)
        Z1f, Z2f = symmetrise(B, Z1f), symmetrise(B, Z2f)
        if cache is not None:
            cache.parent.mkdir(parents=True, exist_ok=True)
            np.savez_compressed(cache, val=val, status=status, Z1=Z1f, Z2=Z2f)
            print(f"[round] the duals cached in {cache} ({cache.stat().st_size / 1e6:.1f} MB): a resume "
                  f"re-reads them instead of solving", flush=True)
    # the checkpoint: every candidate ever scored, so a kill costs only the candidates in flight
    seen = {}
    ck = Path(a.ckpt) if a.ckpt else None
    if ck is not None and ck.exists():
        for line in ck.read_text().splitlines():
            if not line.strip():
                continue
            r = json.loads(line)
            seen[(r["s1"], r["s2"], r["thr"], r["den"])] = Fraction(r["N"])
        print(f"[round] the checkpoint {ck} holds {len(seen)} scored candidate(s); they are not re-scored",
              flush=True)

    def record(s1, s2, thr, den, N, ranks):
        seen[(s1, s2, thr, den)] = N
        if ck is None:
            return
        ck.parent.mkdir(parents=True, exist_ok=True)
        with ck.open("a") as fh:
            fh.write(json.dumps(dict(p=a.p, s1=s1, s2=s2, thr=thr, den=den, N=str(N),
                                     N_float=float(N), ranks=ranks)) + "\n")
    thresholds = [float(x) for x in a.thresholds.split(",")]
    denominators = [int(x) for x in a.denominators.split(",")]
    # 1. the dual SIGN convention is the solver's, not ours: settle it with one cheap probe rather
    #    than by reading cvxpy's Lagrangian.  Any sign gives a SOUND certificate (the checker sees to
    #    that); only one gives a small N.
    probe = {}
    for sgn1 in (1, -1):
        for sgn2 in (1, -1):
            key = (sgn1, sgn2, 1e-6, 10000)
            if key in seen:
                probe[(sgn1, sgn2)] = seen[key]
                print(f"[round]   dual signs ({sgn1:+d},{sgn2:+d}) at denominator 10^4: N = "
                      f"{float(seen[key]):.4f}  (from the checkpoint)", flush=True)
                continue
            num1, d1 = gram_round(sgn1 * Z1f, 1e-6 * np.abs(Z1f).max(), 10000)
            num2, d2 = gram_round(sgn2 * Z2f, 1e-6 * np.abs(Z2f).max(), 10000)
            try:
                N, _m = score(B, rows, num1, d1, num2, d2)
            except ValueError:
                continue
            probe[(sgn1, sgn2)] = N
            record(sgn1, sgn2, 1e-6, 10000, N, [len(num1), len(num2)])
            print(f"[round]   dual signs ({sgn1:+d},{sgn2:+d}) at denominator 10^4: N = {float(N):.4f}",
                  flush=True)
    if not probe:
        print("[round] no sign convention produced a certificate at all -- the dual is not usable")
        return 1
    (s1, s2) = min(probe, key=lambda k: probe[k])
    print(f"[round] taking the dual signs ({s1:+d},{s2:+d})", flush=True)
    # 2. sweep the eigenvalue cut and the rounding denominator; every candidate is scored by its
    #    EXACT N, so the sweep compares proofs and not residuals.
    best = None                      # (N, the candidate's key) -- the winner is re-scored once at the end
    for thr in thresholds:
        for den in denominators:
            key = (s1, s2, thr, den)
            if key in seen:
                N = seen[key]
                mark = "  <- best so far" if (best is None or N < best[0]) else ""
                if mark:
                    best = (N, key)
                print(f"[round]   cut {thr:g}, denominator {den:>11}: N = {float(N):.6f}{mark}"
                      f"  (from the checkpoint)", flush=True)
                continue
            num1, d1 = gram_round(s1 * Z1f, thr * np.abs(Z1f).max(), den)
            num2, d2 = gram_round(s2 * Z2f, thr * np.abs(Z2f).max(), den)
            try:
                N, _mult = score(B, rows, num1, d1, num2, d2)
            except ValueError:
                continue
            record(s1, s2, thr, den, N, [len(num1), len(num2)])
            mark = ""
            if best is None or N < best[0]:
                best = (N, key)
                mark = "  <- best so far"
            print(f"[round]   cut {thr:g}, denominator {den:>11}: ranks {len(num1):3d},{len(num2):3d}"
                  f"  N = {float(N):.6f}{mark}", flush=True)
    if best is None:
        print("[round] no candidate produced a certificate")
        return 1
    # re-score the winner: the sweep keeps only its N, so the matrices are rebuilt once, here
    (_N, (s1, s2, thr, den)) = best
    num1, d1 = gram_round(s1 * Z1f, thr * np.abs(Z1f).max(), den)
    num2, d2 = gram_round(s2 * Z2f, thr * np.abs(Z2f).max(), den)
    N, mult = score(B, rows, num1, d1, num2, d2)
    if N != _N:
        raise SystemExit(f"[round] the winner re-scored to {N}, not the {_N} the sweep recorded")
    import math
    print(f"[round] best exact N = {N} = {float(N):.6f}; alpha(UD(F_{a.p}, 2)) <= {math.floor(N)}",
          flush=True)
    extra = dict(float_bound=float(val), solver=a.solver, solver_status=status,
                 dual_signs=[s1, s2], eigenvalue_cut=thr, gram_denominator=den,
                 gram_ranks=[len(num1), len(num2)], seconds=time.time() - t0)
    cert = build_certificate(a.p, N, mult, B, rows, num1, d1, num2, d2, extra)
    if a.out:
        Path(a.out).parent.mkdir(parents=True, exist_ok=True)
        Path(a.out).write_text(json.dumps(cert))
        print(f"[round] wrote {a.out} ({Path(a.out).stat().st_size / 1e6:.2f} MB)", flush=True)
        print(f"[round] handing it to the checker (a separate program, standard library only):", flush=True)
        r = subprocess.run(["python3", "tools/fplane_cert_check.py", a.out,
                            "--k", str(math.ceil(n / math.floor(N)) - 1)], capture_output=False)
        return r.returncode
    return 0


if __name__ == "__main__":
    sys.exit(main())
