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

USAGE
  build/venv-sdp/bin/python tools/fplane_cert_round.py --p 11 --out data/fs50/cert-p11-N29.json
"""

from __future__ import annotations

import argparse
import json
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


def solve(B, solver="CLARABEL", verbose=False):
    """The linear form, with the duals kept.  Returns (value, Z1, Z2) as float matrices."""
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
    prob.solve(solver=solver, verbose=verbose)
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


def build_certificate(p, N, mult, B, rows, num1, d1, num2, d2, extra):
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
        psd=dict(
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


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--p", type=int, required=True)
    ap.add_argument("--solver", default="CLARABEL")
    ap.add_argument("--out")
    ap.add_argument("--denominators", default="1000,10000,100000,1000000,10000000,100000000")
    ap.add_argument("--thresholds", default="1e-9,1e-7,1e-6,1e-5,1e-4,1e-3")
    a = ap.parse_args()
    t0 = time.time()
    B = C.build_orbits(a.p)
    rows = C.canonical_constraints(B)
    n, K = B["n"], B["K"]
    print(f"[round] p = {a.p}: {n} points, {K} pair orbits, {sum(B['killed'])} killed, "
          f"{len(rows)} canonical constraints", flush=True)
    val, status, Z1f, Z2f = solve(B, solver=a.solver)
    print(f"[round] the float bound: {val:.6f} ({status}, {a.solver}) in {time.time()-t0:.1f} s", flush=True)
    Z1f, Z2f = symmetrise(B, Z1f), symmetrise(B, Z2f)
    thresholds = [float(x) for x in a.thresholds.split(",")]
    denominators = [int(x) for x in a.denominators.split(",")]
    # 1. the dual SIGN convention is the solver's, not ours: settle it with one cheap probe rather
    #    than by reading cvxpy's Lagrangian.  Any sign gives a SOUND certificate (the checker sees to
    #    that); only one gives a small N.
    probe = {}
    for sgn1 in (1, -1):
        for sgn2 in (1, -1):
            num1, d1 = gram_round(sgn1 * Z1f, 1e-6 * np.abs(Z1f).max(), 10000)
            num2, d2 = gram_round(sgn2 * Z2f, 1e-6 * np.abs(Z2f).max(), 10000)
            try:
                N, _m = score(B, rows, num1, d1, num2, d2)
            except ValueError:
                continue
            probe[(sgn1, sgn2)] = N
            print(f"[round]   dual signs ({sgn1:+d},{sgn2:+d}) at denominator 10^4: N = {float(N):.4f}",
                  flush=True)
    if not probe:
        print("[round] no sign convention produced a certificate at all -- the dual is not usable")
        return 1
    (s1, s2) = min(probe, key=lambda k: probe[k])
    print(f"[round] taking the dual signs ({s1:+d},{s2:+d})", flush=True)
    # 2. sweep the eigenvalue cut and the rounding denominator; every candidate is scored by its
    #    EXACT N, so the sweep compares proofs and not residuals.
    best = None
    for thr in thresholds:
        for den in denominators:
            num1, d1 = gram_round(s1 * Z1f, thr * np.abs(Z1f).max(), den)
            num2, d2 = gram_round(s2 * Z2f, thr * np.abs(Z2f).max(), den)
            try:
                N, mult = score(B, rows, num1, d1, num2, d2)
            except ValueError:
                continue
            mark = ""
            if best is None or N < best[0]:
                best = (N, mult, num1, d1, num2, d2, (s1, s2, thr, den))
                mark = "  <- best so far"
            print(f"[round]   cut {thr:g}, denominator {den:>11}: ranks {len(num1):3d},{len(num2):3d}"
                  f"  N = {float(N):.6f}{mark}", flush=True)
    N, mult, num1, d1, num2, d2, (s1, s2, thr, den) = best
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
