"""FS-73 P3b — build an exact branch-and-bound certificate for the three-colour rotation set Θ of an FS-61 lattice.

The certificate is in the format of the committed checker `data/fs73/coxeter-c3/certcheck.py` (Coxeter, FS-73 C-7), so
either that checker or `tools/fs73_theta_check.py` can verify it:

  Θ = {θ ∈ [0,1]^r : θ·s mod 1 ∈ [1/3, 2/3] for every s ∈ S}, coordinates dual to a ℤ-basis of span(U).
  A node is a path ((0, j0), (1, j1), …) meaning j_k + 1/3 ≤ θ·S[k] ≤ j_k + 2/3. At a node the next vector c = S[len(path)]
  gets multipliers yl, yu ≥ 0 certifying a range [L, U] for c·θ (the box by u = max(0, −(yA + c))); its children are every
  j with [j+1/3, j+2/3] meeting [L, U]. An infeasible node carries a Farkas vector. A node at depth |S| is a leaf: a
  nonempty cell. No leaves ⟹ Θ empty.

Floats (HiGHS) only PROPOSE multipliers; every bound written is recomputed here in Fractions exactly as the checker will,
and when a float proposal does not certify (degenerate or thin nodes) the node is redone by an exact simplex.

Resumable: nodes stream to <out>.nodes.jsonl; the DFS stack and counters are saved atomically to <out>.state.json every
--ckpt seconds and at exit. Re-running the same command resumes exactly (the nodes file is truncated to the saved count).

Usage:
  python3 tools/fs73_theta_cert.py build KEY D OUT [--order l1|given] [--basis hnf|dual] [--first-leaf] [--cap SECONDS]
  python3 tools/fs73_theta_cert.py assemble OUT          # writes OUT.json in certcheck.py's format
"""
from __future__ import annotations

import argparse
import json
import math
import os
import sys
import time
from fractions import Fraction as Fr

import numpy as np
from scipy.optimize import linprog

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fs73_theta_lib import (det_int, exact_lp_max, half_set, lattice_problem, parse_key,  # noqa: E402
                            solve_int_coords)

THIRD, TWO_THIRDS = Fr(1, 3), Fr(2, 3)


# --- exact bound arithmetic, identical in form to certcheck.py -------------------------------------------------------
def rows_of(S, path):
    A, b = [], []
    for (i, j) in path:
        c = S[i]
        A.append([Fr(x) for x in c]); b.append(Fr(3 * j + 2, 3))
        A.append([Fr(-x) for x in c]); b.append(Fr(-(3 * j + 1), 3))
    return A, b


def lower(A, b, c, y, r):
    yA = [sum(y[k] * A[k][i] for k in range(len(A))) for i in range(r)]
    u = [max(Fr(0), -(yA[i] + c[i])) for i in range(r)]
    return -(sum(y[k] * b[k] for k in range(len(A))) + sum(u))


def children(L, U):
    lo, hi = math.floor(L - TWO_THIRDS), math.ceil(U - THIRD)
    return [j for j in range(lo, hi + 1) if Fr(3 * j + 1, 3) <= U and Fr(3 * j + 2, 3) >= L]


def rat(v, den=10 ** 7):
    return Fr(v).limit_denominator(den)


# --- float proposals ------------------------------------------------------------------------------------------------
def float_min(A, b, c, r):
    """Minimise c·x over {A x <= b, 0 <= x <= 1}; returns ('opt', y>=0) or ('inf', None)."""
    if not A:
        return "opt", []
    Af = np.array([[float(x) for x in row] for row in A]); bf = np.array([float(x) for x in b])
    res = linprog([float(x) for x in c], A_ub=Af, b_ub=bf, bounds=[(0, 1)] * r, method="highs")
    if res.status == 2:
        return "inf", None
    if res.status != 0:
        return "err", None
    return "opt", [max(0.0, -x) for x in res.ineqlin.marginals]


def float_farkas(A, b, r):
    m = len(A)
    Af = np.array([[float(x) for x in row] for row in A]); bf = [float(x) for x in b]
    cobj = bf + [1.0] * r
    Aub = np.hstack([-Af.T, -np.eye(r)]); bub = np.zeros(r)
    Aeq = np.array([[1.0] * m + [0.0] * r]); beq = [1.0]
    res = linprog(cobj, A_ub=Aub, b_ub=bub, A_eq=Aeq, b_eq=beq, bounds=[(0, None)] * (m + r), method="highs")
    if res.status != 0:
        return None
    return [max(0.0, x) for x in res.x[:m]]


# --- exact fallback (my simplex, with the box as explicit rows; box multipliers are dropped, which only helps) --------
def exact_node(A, b, c, r):
    """Exact: ('inf', ray) or ('opt', yl, yu) for the node polytope with the box."""
    Ab = A + [[Fr(1) if i == k else Fr(0) for i in range(r)] for k in range(r)] + \
        [[Fr(-1) if i == k else Fr(0) for i in range(r)] for k in range(r)]
    bb = b + [Fr(1)] * r + [Fr(0)] * r
    m = len(A)
    st, x, y = exact_lp_max(Ab, bb, [-v for v in c])      # max -c.x  == min c.x
    if st == "infeasible":
        return ("inf", y[:m])
    assert st == "optimal"
    yl = y[:m]
    st2, x2, y2 = exact_lp_max(Ab, bb, c)
    assert st2 == "optimal"
    yu = y2[:m]
    return ("opt", yl, yu)


def certify_node(S, path, r, stats):
    """Returns a node dict (exactly certified) and its children list (None for an infeasible node)."""
    A, b = rows_of(S, path)
    c = [Fr(x) for x in S[len(path)]]
    st, yl = float_min(A, b, c, r)
    st2, yu = float_min(A, b, [-x for x in c], r) if st == "opt" else (st, None)
    if st == "opt" and st2 == "opt":
        yl = [rat(v) for v in yl]; yu = [rat(v) for v in yu]
        L = lower(A, b, c, yl, r); U = -lower(A, b, [-x for x in c], yu, r)
        if L <= U + Fr(1, 10 ** 6):          # sane (the true range is nonempty or nearly so)
            ch = children(L, U)
            return {"p": path, "yl": [str(v) for v in yl], "yu": [str(v) for v in yu], "ch": ch}, ch
    if st == "inf" or st2 == "inf":
        ray = float_farkas(A, b, r)
        if ray is not None:
            ray = [rat(v) for v in ray]
            if lower(A, b, [Fr(0)] * r, ray, r) > 0:
                return {"p": path, "farkas": [str(v) for v in ray]}, None
    # exact fallback
    stats["exact"] += 1
    res = exact_node(A, b, c, r)
    if res[0] == "inf":
        ray = res[1]
        assert lower(A, b, [Fr(0)] * r, ray, r) > 0
        return {"p": path, "farkas": [str(v) for v in ray]}, None
    _, yl, yu = res
    L = lower(A, b, c, yl, r); U = -lower(A, b, [-x for x in c], yu, r)
    ch = children(L, U)
    return {"p": path, "yl": [str(v) for v in yl], "yu": [str(v) for v in yu], "ch": ch}, ch


# --- the problem ----------------------------------------------------------------------------------------------------
def dual_reduce(C, r):
    """A unimodular W making every coefficient vector small: LLL of the dual lattice under Q(w) = Σ_u (w·c_u)²."""
    G = [[Fr(sum(c[i] * c[j] for c in C)) for j in range(r)] for i in range(r)]
    B = [[1 if i == j else 0 for j in range(r)] for i in range(r)]
    ip = lambda x, y: sum(x[i] * G[i][j] * y[j] for i in range(r) for j in range(r))
    delta = Fr(99, 100)
    k = 1
    while k < r:
        Bs, mu, nn = [], [[Fr(0)] * r for _ in range(r)], []
        for i in range(r):
            v = [Fr(t) for t in B[i]]
            for j in range(i):
                mu[i][j] = ip(B[i], Bs[j]) / nn[j]; v = [v[t] - mu[i][j] * Bs[j][t] for t in range(r)]
            Bs.append(v); nn.append(ip(v, v))
        changed = False
        for j in range(k - 1, -1, -1):
            q = round(mu[k][j])
            if q:
                B[k] = [B[k][t] - q * B[j][t] for t in range(r)]; changed = True; break
        if changed:
            continue
        if nn[k] >= (delta - mu[k][k - 1] ** 2) * nn[k - 1]:
            k += 1
        else:
            B[k], B[k - 1] = B[k - 1], B[k]; k = max(k - 1, 1)
    return B      # rows w_k: new coordinate k of u is w_k · c_u


def setup(key, d, basis_mode="dual", order="l1", given=None, basis_rows=None, order_units=None):
    U, Bm, S = lattice_problem(key, d)
    r = len(Bm)
    if basis_rows is not None:
        # an explicit ℤ-basis (rows in (a,b,c,e)); it must span exactly span(U) (the checkers re-verify this)
        Bm = [list(map(int, row.split(","))) for row in basis_rows.split(";")]
        S = half_set([solve_int_coords(Bm, u) for u in U])
        basis_mode = "given"
        if order_units is not None:
            want = [tuple(x) for x in json.load(open(order_units))]
            Uset = set(U)
            assert all(w in Uset for w in want) and len(want) == len(S), "order file must list one unit per ± pair"
            S = [solve_int_coords(Bm, w) for w in want]
            assert set(map(tuple, S)) | {tuple(-x for x in s) for s in S} == \
                {tuple(c) for c in (solve_int_coords(Bm, u) for u in U)}
            return U, Bm, S, r
    if basis_mode == "dual":
        W = dual_reduce(S, r)
        assert abs(det_int(W)) == 1
        # new coordinates c' = W c; the new primal basis is W^{-T} applied to the old basis rows: B' = W^{-T} B
        S = [[sum(W[k][i] * c[i] for i in range(r)) for k in range(r)] for c in S]
        Winv_T = invert_unimodular_T(W)
        Bm = [[sum(Winv_T[k][i] * Bm[i][t] for i in range(r)) for t in range(len(Bm[0]))] for k in range(r)]
        # sanity: each unit is its coordinate combination of the new basis
        for u in U:
            cu = solve_int_coords(Bm, u)
            assert tuple(cu) in {tuple(s) for s in S} | {tuple(-x for x in s) for s in S}
    if order == "l1":
        S = sorted(S, key=lambda s: (sum(abs(x) for x in s), s))
    elif order == "given":
        S = [S[i] for i in given]
    return U, Bm, S, r


def invert_unimodular_T(W):
    r = len(W)
    Wf = [[Fr(x) for x in row] for row in W]
    # inverse by Gauss-Jordan
    Mx = [Wf[i] + [Fr(1) if i == j else Fr(0) for j in range(r)] for i in range(r)]
    for col in range(r):
        piv = next(i for i in range(col, r) if Mx[i][col] != 0)
        Mx[col], Mx[piv] = Mx[piv], Mx[col]
        inv = 1 / Mx[col][col]; Mx[col] = [v * inv for v in Mx[col]]
        for i in range(r):
            if i != col and Mx[i][col] != 0:
                f = Mx[i][col]; Mx[i] = [Mx[i][t] - f * Mx[col][t] for t in range(2 * r)]
    inv = [[Mx[i][r + j] for j in range(r)] for i in range(r)]
    assert all(v.denominator == 1 for row in inv for v in row)
    return [[int(inv[j][i]) for j in range(r)] for i in range(r)]    # transpose


# --- resumable DFS --------------------------------------------------------------------------------------------------
def build(args):
    out = args.out
    state_f, nodes_f = out + ".state.json", out + ".nodes.jsonl"
    given = list(map(int, args.given.split(","))) if args.given else None
    U, Bm, S, r = setup(args.key, args.d, args.basis, args.order, given, args.basis_rows, args.order_units)
    if os.path.exists(state_f):
        st = json.load(open(state_f))
        assert st["key"] == args.key and st["d"] == args.d and st["S"] == S, "resume: problem differs from the saved state"
        stack = [[tuple(x) for x in p] for p in st["stack"]]
        nnodes, leaves, stats = st["nnodes"], st["leaves"], st["stats"]
        # truncate nodes file to nnodes lines
        with open(nodes_f, "rb+") as fh:
            lines = 0; pos = 0
            for line in fh:
                if lines == nnodes: break
                lines += 1; pos += len(line)
            assert lines == nnodes, "nodes file shorter than the saved count"
            fh.truncate(pos)
        print(f"resumed: {nnodes} nodes, stack {len(stack)}, leaves {len(leaves)}", flush=True)
    else:
        stack = [[]]; nnodes = 0; leaves = []; stats = {"exact": 0, "elapsed": 0.0}
        open(nodes_f, "w").close()
        json.dump({"key": args.key, "d": args.d, "basis": Bm, "S": S}, open(out + ".meta.json", "w"))
    t0 = time.time(); last = t0; el0 = stats["elapsed"]
    fh = open(nodes_f, "a")

    def save():
        fh.flush(); os.fsync(fh.fileno())
        stats["elapsed"] = el0 + (time.time() - t0)
        tmp = state_f + ".tmp"
        json.dump({"key": args.key, "d": args.d, "S": S, "stack": stack, "nnodes": nnodes, "leaves": leaves,
                   "stats": stats}, open(tmp, "w"))
        os.replace(tmp, state_f)

    done = "exhausted"
    while stack:
        if args.cap and el0 + time.time() - t0 > args.cap:
            done = "cap"; break
        path = stack.pop()
        if len(path) == len(S):
            leaves.append(path)
            if args.first_leaf:
                done = "leaf"; break
            continue
        node, ch = certify_node(S, path, r, stats)
        fh.write(json.dumps(node) + "\n"); nnodes += 1
        if ch:
            for j in reversed(ch):
                stack.append(path + [(len(path), j)])
        if time.time() - last > args.ckpt:
            save(); last = time.time()
            print(f"  {nnodes} nodes, stack {len(stack)}, depth {len(path)}, leaves {len(leaves)}, exact {stats['exact']},"
                  f" {stats['elapsed']:.0f} s", flush=True)
    save(); fh.close()
    print(f"{done}: {nnodes} nodes, leaves {len(leaves)}, exact fallbacks {stats['exact']}, {stats['elapsed']:.1f} s",
          flush=True)
    return done, leaves


def assemble(out):
    meta = json.load(open(out + ".meta.json")); st = json.load(open(out + ".state.json"))
    assert not st["stack"], "the tree is not finished"
    nodes = [json.loads(line) for line in open(out + ".nodes.jsonl")]
    assert len(nodes) == st["nnodes"]
    cert = {"key": meta["key"], "d": meta["d"], "basis": meta["basis"], "S": meta["S"], "nodes": nodes,
            "leaves": st["leaves"]}
    json.dump(cert, open(out + ".json", "w"))
    print("wrote", out + ".json", "nodes", len(nodes), "leaves", len(st["leaves"]))


def point(out, dest):
    """Exact point of the first leaf: maximise the slack s inside the leaf's cell, then write ψ on (a,b,c,e)."""
    meta = json.load(open(out + ".meta.json")); st = json.load(open(out + ".state.json"))
    assert st["leaves"], "no leaf"
    S, Bm = meta["S"], meta["basis"]; r = len(Bm)
    path = [tuple(x) for x in st["leaves"][0]]
    A, b = [], []
    for (i, j) in path:
        c = S[i]
        A.append([Fr(x) for x in c] + [Fr(1)]); b.append(Fr(3 * j + 2, 3))
        A.append([Fr(-x) for x in c] + [Fr(1)]); b.append(Fr(-(3 * j + 1), 3))
    A.append([Fr(0)] * r + [Fr(1)]); b.append(Fr(1, 6))
    stt, x, _ = exact_lp_max(A, b, [0] * r + [1])
    assert stt == "optimal" and x[r] >= 0, stt
    theta = x[:r]
    # ψ on (a,b,c,e): ψ·B_k = θ_k
    cols = list(range(len(Bm[0])))
    Mx = [[Fr(Bm[k][t]) for t in cols] + [theta[k]] for k in range(r)]
    for col in range(r):
        piv = next(i for i in range(col, r) if Mx[i][col] != 0); Mx[col], Mx[piv] = Mx[piv], Mx[col]
        inv = 1 / Mx[col][col]; Mx[col] = [v * inv for v in Mx[col]]
        for i in range(r):
            if i != col and Mx[i][col] != 0:
                f = Mx[i][col]; Mx[i] = [Mx[i][t] - f * Mx[col][t] for t in range(r + 1)]
    psi = [Mx[i][r] for i in range(r)]
    assert all(sum(psi[t] * Bm[k][t] for t in range(r)) == theta[k] for k in range(r))
    rec = {"key": meta["key"], "d": meta["d"], "psi": [str(v) for v in psi], "slack": str(x[r]),
           "theta_basis": [str(v) for v in theta], "basis": Bm, "leaf": path}
    json.dump(rec, open(dest, "w"), indent=1)
    print("psi", [str(v) for v in psi], "slack", x[r], float(x[r]))


def main():
    ap = argparse.ArgumentParser()
    sub = ap.add_subparsers(dest="cmd", required=True)
    b = sub.add_parser("build")
    b.add_argument("key"); b.add_argument("d", type=int); b.add_argument("out")
    b.add_argument("--order", default="l1", choices=["l1", "given", "none"])
    b.add_argument("--given", default=None)
    b.add_argument("--basis", default="dual", choices=["dual", "hnf"])
    b.add_argument("--first-leaf", action="store_true")
    b.add_argument("--basis-rows", default=None, help="explicit basis rows 'a,b,c,e;...'")
    b.add_argument("--order-units", default=None, help="JSON list of (a,b,c,e) unit vectors, one per ± pair, in order")
    b.add_argument("--cap", type=float, default=0)
    b.add_argument("--ckpt", type=float, default=60)
    a = sub.add_parser("assemble"); a.add_argument("out")
    pt = sub.add_parser("point"); pt.add_argument("out"); pt.add_argument("dest")
    args = ap.parse_args()
    if args.cmd == "build":
        build(args)
    elif args.cmd == "point":
        point(args.out, args.dest)
    else:
        assemble(args.out)


if __name__ == "__main__":
    main()
