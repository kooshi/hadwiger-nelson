#!/usr/bin/env python3
"""FS-81 phase 0 (P0.3): a STRUCTURAL Θ-emptiness certificate for B = {vᵏ : |k| ≤ 2}·U^(5^K) over ℚ(√d).  Untrusted; its
certificates are checked by `tools/fs81_struct_check.py`, which imports nothing from here and re-derives every step but the
Farkas vectors.

The reduction (hand; each step re-derived by the checker):
  S1  n = (d+1)/4, v = ((2n−1) + i√d)/(2n), t = v + v̄ = 2 − 1/n, v v̄ = 1, so v^(k+1) = t vᵏ − v^(k−1).
  S2  For θ ∈ Hom(span U, ℝ) put μ_k = (θ(vᵏ), θ(i vᵏ)) (θ extended ℚ-linearly).  For x = (p + iq)/5^K ∈ U^(5^K),
      θ(vᵏ x) = (p μ_k,1 + q μ_k,2)/5^K =: ⟨μ_k, x⟩; and μ_(k+1) = t μ_k − μ_(k−1), i.e. n Δ²μ_k + μ_k = 0 (k = −1, 0, 1).
  S3  θ ∈ Θ ⟹ μ_k ∈ Θ_K := {μ : ⟨μ, x⟩ mod 1 ∈ [1/3, 2/3] ∀x ∈ U^(5^K)} ⊆ c + (P ∪ F) + 5^K ℤ², with c = 5^K(½, ½),
      P = {δ : |⟨δ, x⟩| ≤ 1/6 ∀x}, F = {5^K(±1/6, ±1/6)} (the rational layer; the checker re-derives the inclusion at this K).
  S4  Writing μ_k = c + 5^K m_k + δ_k (m_k ∈ ℤ², δ_k ∈ P ∪ F), S2 gives, since Δ²c = 0 and c = 5^K(½, ½):
            L_k(δ) := n Δ²δ_k + δ_k = −5^K (n Δ²m_k + m_k + (½, ½)) ∈ 5^K (ℤ + ½)²      for k = −1, 0, 1.
  So Θ = ∅ whenever no δ_(−2..2) ∈ P ∪ F has L_k(δ) ∈ 5^K(ℤ + ½)² for k = −1, 0, 1.  The certificate lists, for every
  assignment of types (P or one of the four points) to the five layers and every combination of half-integer targets h_k whose
  5^K h_k meets the exact interval range of L_k, a Farkas vector showing that the linear system is infeasible.

Usage: fs81_struct.py d K OUT.json      (writes an EMPTY certificate, or reports a feasible case: then Θ may be nonempty)
"""
from __future__ import annotations

import itertools
import json
import math
import sys
import time
from fractions import Fraction as F

import numpy as np
from scipy.optimize import linprog

LAYERS = (-2, -1, 0, 1, 2)


def dirs(K):
    """Every (p, q) with p² + q² = 25^K, both signs, sorted: the row order of P's inequalities (the checker's order)."""
    m = 5 ** K
    out = set()
    for p in range(-m, m + 1):
        q2 = m * m - p * p
        q = math.isqrt(q2)
        if q * q == q2:
            for qq in {q, -q}:
                out.add((p, qq))
    return sorted(out)


def setup(d, K):
    n = (d + 1) // 4
    m = 5 ** K
    X = dirs(K)
    pts = [(F(sx * m, 6), F(sy * m, 6)) for sx in (1, -1) for sy in (1, -1)]
    return n, m, X, pts


def lk_coeffs(n, k):
    """L_k(δ) = n δ_(k+1) − (2n − 1) δ_k + n δ_(k−1): coefficient per layer."""
    return {k + 1: n, k: -(2 * n - 1), k - 1: n}


def interval(n, k, types, pts, r):
    """Exact range of each coordinate of L_k given the types (P ⊆ [−r, r]², a point exactly)."""
    lo, hi = [F(0), F(0)], [F(0), F(0)]
    for layer, c in lk_coeffs(n, k).items():
        t = types[layer]
        for j in range(2):
            if t == "P":
                lo[j] += -abs(c) * r
                hi[j] += abs(c) * r
            else:
                v = c * pts[t][j]
                lo[j] += v
                hi[j] += v
    return lo, hi


def targets(lo, hi, m):
    """Half-integer h (per coordinate) with m·h in [lo, hi]."""
    out = []
    for j in range(2):
        a = math.ceil(lo[j] / m - F(1, 2))
        b = math.floor(hi[j] / m - F(1, 2))
        out.append([F(2 * x + 1, 2) for x in range(a, b + 1)])
    return [(x, y) for x in out[0] for y in out[1]]


def build_system(n, m, X, pts, types, hs):
    """Variables: δ_k (two each) for P-layers.  Rows: inequalities A δ ≤ b and equalities E δ = e, all exact."""
    var = {}
    for layer in LAYERS:
        if types[layer] == "P":
            var[layer] = len(var) * 2
    nv = 2 * len(var)
    A, b, E, e = [], [], [], []
    for layer, off in var.items():
        for (p, q) in X:
            row = [F(0)] * nv
            row[off], row[off + 1] = F(p, m), F(q, m)
            A.append(row)
            b.append(F(1, 6))
    for k, h in zip((-1, 0, 1), hs):
        for j in range(2):
            row = [F(0)] * nv
            rhs = m * h[j]
            for layer, c in lk_coeffs(n, k).items():
                if types[layer] == "P":
                    row[var[layer] + j] += c
                else:
                    rhs -= c * pts[types[layer]][j]
            E.append(row)
            e.append(rhs)
    return nv, A, b, E, e


def farkas(nv, A, b, E, e):
    """Exact y ≥ 0, z with yA + zE = 0 and y·b + z·e < 0, from the elastic LP's duals; None if the system is feasible."""
    if nv == 0:
        # no variables: infeasible iff some equality 0 = e_i with e_i ≠ 0 (or 0 ≤ b_i with b_i < 0)
        for i, ei in enumerate(e):
            if ei != 0:
                z = [F(0)] * len(e)
                z[i] = F(-1) if ei > 0 else F(1)
                return [F(0)] * len(A), z
        return None
    Af = np.array([[float(x) for x in r] for r in A]) if A else np.zeros((0, nv))
    Ef = np.array([[float(x) for x in r] for r in E]) if E else np.zeros((0, nv))
    # elastic: min Σ s⁺ + s⁻ over E δ + s⁺ − s⁻ = e, A δ ≤ b
    ne = len(E)
    c = np.concatenate([np.zeros(nv), np.ones(2 * ne)])
    Aeq = np.hstack([Ef, np.eye(ne), -np.eye(ne)])
    Aub = np.hstack([Af, np.zeros((len(A), 2 * ne))])
    res = linprog(c, A_ub=Aub, b_ub=np.array([float(x) for x in b]), A_eq=Aeq, b_eq=np.array([float(x) for x in e]),
                  bounds=[(None, None)] * nv + [(0, None)] * (2 * ne), method="highs")
    assert res.status == 0, res.message
    if res.fun < 1e-9:
        return None
    yf = -res.ineqlin.marginals                       # ≥ 0
    zf = -res.eqlin.marginals
    for den in (10 ** 3, 10 ** 6, 10 ** 9, 10 ** 12):
        for sign in (1, -1):
            y = [max(F(0), F(sign * v).limit_denominator(den)) for v in yf]
            z = [F(sign * v).limit_denominator(den) for v in zf]
            # repair yA + zE = 0 exactly is not attempted; accept only an exact certificate
            ok = all(sum(y[i] * A[i][j] for i in range(len(A))) + sum(z[i] * E[i][j] for i in range(len(E))) == 0
                     for j in range(nv))
            if ok and sum(y[i] * b[i] for i in range(len(A))) + sum(z[i] * e[i] for i in range(len(E))) < 0:
                return y, z
    # exact fallback: solve for an exact Farkas vector on the rows the float duals use
    cert = exact_farkas(nv, A, b, E, e, yf, zf)
    if cert is None:
        cert = simplex_farkas(nv, A, b, E, e, [i for i in range(len(A)) if yf[i] > 1e-9])
    if cert is None:
        cert = simplex_farkas(nv, A, b, E, e, list(range(len(A))))
    if cert is None:
        raise RuntimeError(f"elastic LP infeasible (violation {res.fun}) but no exact Farkas vector: never read as feasible")
    return cert


def phase1(M, rhs):
    """An exact w ≥ 0 with M w = rhs (Fractions), by the two-phase simplex's first phase with Bland's rule; None if none."""
    rows, cols = len(M), len(M[0])
    T = []
    for i in range(rows):
        sgn = -1 if rhs[i] < 0 else 1
        T.append([sgn * x for x in M[i]] + [F(1) if r == i else F(0) for r in range(rows)] + [sgn * rhs[i]])
    basis = [cols + i for i in range(rows)]
    ncol = cols + rows
    obj = [F(0)] * (ncol + 1)                       # minimise the sum of artificials: reduced costs
    for i in range(rows):
        obj = [o - t for o, t in zip(obj, T[i])]
    for i in range(rows):
        obj[cols + i] += 1
    while True:
        enter = next((j for j in range(ncol) if obj[j] < 0), None)
        if enter is None:
            break
        ratios = [(T[i][-1] / T[i][enter], basis[i], i) for i in range(rows) if T[i][enter] > 0]
        if not ratios:
            return None
        _, _, leave = min(ratios)
        pv = T[leave][enter]
        T[leave] = [x / pv for x in T[leave]]
        for i in range(rows):
            if i != leave and T[i][enter] != 0:
                f = T[i][enter]
                T[i] = [x - f * y for x, y in zip(T[i], T[leave])]
        f = obj[enter]
        obj = [x - f * y for x, y in zip(obj, T[leave])]
        basis[leave] = enter
    if obj[-1] != 0:
        return None
    w = [F(0)] * cols
    for i, bv in enumerate(basis):
        if bv < cols:
            w[bv] = T[i][-1]
        elif T[i][-1] != 0:
            return None
    return w


def simplex_farkas(nv, A, b, E, e, arows):
    """Exact Farkas vector on the inequality rows `arows` (all equality rows): y ≥ 0, z = z⁺ − z⁻, yA + zE = 0, yb + ze = −1."""
    cols = [("y", i) for i in arows] + [("z+", i) for i in range(len(E))] + [("z-", i) for i in range(len(E))]

    def entry(col, j):
        t, i = col
        if t == "y":
            return A[i][j] if j < nv else b[i]
        v = E[i][j] if j < nv else e[i]
        return v if t == "z+" else -v
    M = [[entry(c, j) for c in cols] for j in range(nv + 1)]
    rhs = [F(0)] * nv + [F(-1)]
    w = phase1(M, rhs)
    if w is None:
        return None
    y = [F(0)] * len(A)
    z = [F(0)] * len(E)
    for (t, i), val in zip(cols, w):
        if t == "y":
            y[i] = val
        elif t == "z+":
            z[i] += val
        else:
            z[i] -= val
    return y, z


def exact_farkas(nv, A, b, E, e, yf, zf):
    """Support of the float certificate, then an exact null-space vector on it scaled to make y·b + z·e = −1."""
    rows = [("A", i) for i in range(len(A)) if yf[i] > 1e-9] + [("E", i) for i in range(len(E)) if abs(zf[i]) > 1e-9]
    M = [[(A[i] if t == "A" else E[i])[j] for (t, i) in rows] for j in range(nv)]
    rhs_row = [(b[i] if t == "A" else e[i]) for (t, i) in rows]
    # solve M w = 0, rhs·w = −1 by exact elimination (least-norm not needed)
    Mat = [r + [F(0)] for r in M] + [rhs_row + [F(-1)]]
    ncol = len(rows)
    piv, rk = [], 0
    for col in range(ncol):
        p = next((i for i in range(rk, len(Mat)) if Mat[i][col] != 0), None)
        if p is None:
            continue
        Mat[rk], Mat[p] = Mat[p], Mat[rk]
        pv = Mat[rk][col]
        Mat[rk] = [x / pv for x in Mat[rk]]
        for i in range(len(Mat)):
            if i != rk and Mat[i][col] != 0:
                f = Mat[i][col]
                Mat[i] = [x - f * y for x, y in zip(Mat[i], Mat[rk])]
        piv.append(col)
        rk += 1
    if any(Mat[i][ncol] != 0 for i in range(rk, len(Mat))):
        return None
    w = [F(0)] * ncol
    free = [c for c in range(ncol) if c not in piv]
    for c in free:                                     # free variables from the float solution
        t, i = rows[c]
        w[c] = F(float(yf[i] if t == "A" else zf[i])).limit_denominator(10 ** 6)
    for r, c in enumerate(piv):
        w[c] = Mat[r][ncol] - sum(Mat[r][f] * w[f] for f in free)
    y = [F(0)] * len(A)
    z = [F(0)] * len(E)
    for (t, i), val in zip(rows, w):
        if t == "A":
            if val < 0:
                return None
            y[i] = val
        else:
            z[i] = val
    return y, z


def run(d, K, out=None, r=F(1, 6), stop_at_feasible=False):
    t0 = time.time()
    n, m, X, pts = setup(d, K)
    cases, feasible, n_lp, n_notarget = [], [], 0, 0
    for tys in itertools.product(["P", 0, 1, 2, 3], repeat=5):
        types = dict(zip(LAYERS, tys))
        if stop_at_feasible and feasible:
            break
        tgt = [targets(*interval(n, k, types, pts, r), m) for k in (-1, 0, 1)]
        if any(not t for t in tgt):
            n_notarget += 1
            continue
        for hs in itertools.product(*tgt):
            nv, A, b, E, e = build_system(n, m, X, pts, types, hs)
            n_lp += 1
            cert = farkas(nv, A, b, E, e)
            if cert is None:
                feasible.append({"types": [str(x) for x in tys], "h": [[str(h[0]), str(h[1])] for h in hs]})
                if stop_at_feasible:
                    break
                continue
            y, z = cert
            cases.append({"types": [str(x) for x in tys], "h": [[str(h[0]), str(h[1])] for h in hs],
                          "y": {str(i): str(v) for i, v in enumerate(y) if v != 0},
                          "z": {str(i): str(v) for i, v in enumerate(z) if v != 0}})
    res = {"d": d, "K": K, "n": n, "verdict": "EMPTY" if not feasible else ("FEASIBLE (first case found; search stopped)" if stop_at_feasible
                                                      else "FEASIBLE CASES"),
           "assignments": 5 ** 5, "assignments_without_targets": n_notarget, "lps": n_lp, "cases": cases,
           "feasible": feasible[:20], "n_feasible": len(feasible), "wall_s": round(time.time() - t0, 2)}
    if out:
        with open(out, "w") as fh:
            json.dump(res, fh)
    return res


def k_b(d):
    """The verifier's threshold (FS81 T8): the least K with d < 21·5^(K−1)."""
    K = 1
    while not d < 21 * 5 ** (K - 1):
        K += 1
    return K


def sweep(fields, out_jsonl, certdir):
    """For each d: B at K_B(d) (must be EMPTY, certified by the standalone checker) and at K_B(d) − 1 (the other side: the
    δ-system is expected FEASIBLE there, so no certificate exists — a control that the generator can say so)."""
    import os
    import subprocess
    here = os.path.dirname(os.path.abspath(__file__))
    done = set()
    if os.path.exists(out_jsonl):
        done = {(json.loads(l)["d"], json.loads(l)["K"]) for l in open(out_jsonl) if l.strip()}
    for d in fields:
        for K in (k_b(d), k_b(d) - 1):
            if K < 1 or (d, K) in done:
                continue
            path = os.path.join(certdir, f"d{d}-B-K{K}.json")
            r = run(d, K, path if K == k_b(d) else None, stop_at_feasible=K != k_b(d))
            rec = {"d": d, "K": K, "K_B": k_b(d), "side": "at K_B (T8: EMPTY)" if K == k_b(d) else "at K_B − 1 (T8: NONEMPTY)",
                   "verdict": r["verdict"], "assignments_without_targets": r["assignments_without_targets"],
                   "lps": r["lps"], "n_feasible": r["n_feasible"], "wall_s": r["wall_s"]}
            if K == k_b(d) and r["verdict"] == "EMPTY":
                p = subprocess.run([sys.executable, os.path.join(here, "fs81_struct_check.py"), path], capture_output=True,
                                   text=True, timeout=3600)
                rec.update(check="PASS" if p.returncode == 0 else "FAIL", check_line=p.stdout.strip().splitlines()[-1],
                           cert=os.path.relpath(path, os.path.dirname(here)))
            elif K == k_b(d) and os.path.exists(path):
                os.remove(path)
            with open(out_jsonl, "a") as fh:
                fh.write(json.dumps(rec) + "\n")
                fh.flush()
                os.fsync(fh.fileno())
            print(d, K, rec["side"], rec["verdict"], rec.get("check", ""), rec["lps"], rec["wall_s"], flush=True)


if __name__ == "__main__" and len(sys.argv) > 1 and sys.argv[1] == "sweep":
    sweep([int(x) for x in sys.argv[2].split(",")], sys.argv[3], sys.argv[4])
    sys.exit(0)


if __name__ == "__main__":
    d, K = int(sys.argv[1]), int(sys.argv[2])
    r = run(d, K, sys.argv[3] if len(sys.argv) > 3 else None)
    print(d, K, r["verdict"], "assignments without targets", r["assignments_without_targets"], "LPs", r["lps"],
          "feasible", r["n_feasible"], "s", r["wall_s"])
