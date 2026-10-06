#!/usr/bin/env python3
"""SEARCH-2026-10-06 — the exact checker: a combinatorial map and `CountData`'s fields, transcribed from Lean.

Source of every definition: `Proofs/HadwigerNelson/Plane/RouteT/Basic.lean` (`CMap`, `deg`, `len`, `chi2`, `Adj`, `EdgeAdj`,
`slots`, `mu`) and `Proofs/HadwigerNelson/Plane/RouteT/Count.lean` (`vertNbrs`, `CountData`, `CountData.tac`, `torusGrid`), read
in the worktree `.claude/worktrees/fs131-w7a` at its tip. No solver, no float: integers and sets only.

A map is given by its two permutations of the darts `0..n-1`: `sigma` (the next dart counter-clockwise at the vertex) and
`alpha` (the other half of the edge). `vert` is the cycle of `sigma` a dart lies on and `face` the cycle of
`phi = sigma^-1 * alpha` — so `vert_surj`, `face_surj`, `vert_σ`, `vert_trans`, `face_φ`, `face_trans` hold by construction,
and `alpha_invol`, `alpha_ne` are checked.

  search_20261006_check.py CERT.json     check a certificate; exit 0 iff every field holds, chi2 = 0 and the colours are < k

Certificate: {"k": 6, "map": {"kind": "torusGrid", "n": N, "m": M}, "col_cells": [[colour of cell (a, b) for b] for a]}
         or  {"k": 6, "map": {"sigma": [...], "alpha": [...]}, "col_darts": [colour of the face of dart d, for d]}.
"""
import json
import sys

FIELDS = ["three_le_deg", "mu_zero", "proper", "edge_rainbow", "repeat_one_side", "partner_unique", "absent_cap"]


def cycles(p):
    lab, k = [-1] * len(p), 0
    for s in range(len(p)):
        if lab[s] < 0:
            d = s
            while lab[d] < 0:
                lab[d] = k
                d = p[d]
            k += 1
    return lab, k


class CMap:
    def __init__(s, sigma, alpha):
        n = len(sigma)
        D = range(n)
        if len(alpha) != n or sorted(sigma) != list(D) or sorted(alpha) != list(D):
            raise ValueError("sigma and alpha must be permutations of the darts")
        if any(alpha[alpha[d]] != d or alpha[d] == d for d in D):
            raise ValueError("alpha_invol or alpha_ne fails")
        inv = [0] * n
        for d in D:
            inv[sigma[d]] = d
        s.n, s.sigma, s.alpha = n, list(sigma), list(alpha)
        s.phi = [inv[alpha[d]] for d in D]                      # phi = sigma^-1 * alpha
        s.vert, s.V = cycles(s.sigma)
        s.face, s.F = cycles(s.phi)
        s.deg, s.len = [0] * s.V, [0] * s.F                     # deg v = #{d | vert d = v}; len f = #{d | face d = f}
        for d in D:
            s.deg[s.vert[d]] += 1
            s.len[s.face[d]] += 1
        s.chi2 = 2 * s.V + 2 * s.F - n                          # 2 * card V + 2 * card F - card D
        atv = [set() for _ in range(s.V)]
        for d in D:
            atv[s.vert[d]].add(s.face[d])
        s.adj = [set() for _ in range(s.F)]                     # Adj f g: f != g, corners at one vertex
        s.eadj = [set() for _ in range(s.F)]                    # EdgeAdj f g: f != g, exists d, face d = f, face (alpha d) = g
        for fs in atv:
            for f in fs:
                s.adj[f] |= fs - {f}
        for d in D:
            f, g = s.face[d], s.face[s.alpha[d]]
            if f != g:
                s.eadj[f].add(g)
        s.vn = [s.adj[f] - s.eadj[f] for f in range(s.F)]       # vertNbrs f = {g | Adj f g and not EdgeAdj f g}
        s.mu = [0] * s.F                                        # mu f = slots f - degM f, slots f = sum over corners (deg - 2)
        for d in D:
            s.mu[s.face[d]] += s.deg[s.vert[d]] - 2
        for f in range(s.F):
            s.mu[f] -= len(s.adj[f])


def violations(M, col, k):
    """Every field of `CountData M k` at the colouring `col` (by face index): the list of its counterexamples."""
    F = range(M.F)
    bad = {x: [] for x in FIELDS}
    bad["three_le_deg"] = [v for v in range(M.V) if M.deg[v] < 3]
    bad["mu_zero"] = [f for f in F if M.mu[f] != 0]
    bad["proper"] = [(f, g) for f in F for g in M.adj[f] if col[f] == col[g]]
    bad["edge_rainbow"] = [(f, g, h) for f in F for g in M.eadj[f] for h in M.eadj[f] if g != h and col[g] == col[h]]
    for d in range(M.n):
        f, g = M.face[d], M.face[M.alpha[d]]
        for z in M.vn[f]:
            if col[z] == col[g]:
                bad["repeat_one_side"] += [(d, z, z2) for z2 in M.vn[g] if col[z2] == col[f]]
    for f in F:
        for z in M.vn[f]:
            for z2 in M.vn[f]:
                if col[z] == col[z2] and any(col[g] == col[z] for g in M.eadj[f]) and z != z2:
                    bad["partner_unique"].append((f, z, z2))
        for j in range(k):
            if all(col[g] != j for g in M.eadj[f]) and sum(1 for z in M.vn[f] if col[z] == j) > 3:
                bad["absent_cap"].append((f, j))
    return bad


def tac(M, col):
    """`CountData.tac`: the darts d with a vertex-only neighbour of face d coloured as the face across d."""
    return [d for d in range(M.n) if any(col[z] == col[M.face[M.alpha[d]]] for z in M.vn[M.face[d]])]


STEP = [(1, 0), (0, 1), (-1, 0), (0, -1)]       # gridStep
CORNER = [(0, 0), (1, 0), (1, 1), (0, 1)]       # gridCorner


def grid_dart(n, m, a, b, j):
    return ((a % n) * m + (b % m)) * 4 + (j % 4)


def torus_grid(n, m):
    """`torusGrid n m`: darts ((a, b), j); sigma = j + 1; alpha = (v + gridStep j, j + 2); face d = d.1 - gridCorner d.2.
    Returns the map and the list `cell` with cell[f] = Lean's name (a, b) of the face f (asserted to be a bijection)."""
    N = n * m * 4
    sigma, alpha, lean_face = [0] * N, [0] * N, [None] * N
    for a in range(n):
        for b in range(m):
            for j in range(4):
                d = grid_dart(n, m, a, b, j)
                sigma[d] = grid_dart(n, m, a, b, j + 1)
                alpha[d] = grid_dart(n, m, a + STEP[j][0], b + STEP[j][1], j + 2)
                lean_face[d] = ((a - CORNER[j][0]) % n, (b - CORNER[j][1]) % m)
    M = CMap(sigma, alpha)
    cell = {}
    for d in range(N):
        if cell.setdefault(M.face[d], lean_face[d]) != lean_face[d]:
            raise ValueError("Lean's face label is not constant on a cycle of phi")
    if M.F != n * m or len(set(cell.values())) != n * m:
        raise ValueError("Lean's face labels are not the cycles of phi")
    return M, [cell[f] for f in range(M.F)]


def load(cert):
    k, mp = cert["k"], cert["map"]
    if mp.get("kind") == "torusGrid":
        M, cell = torus_grid(mp["n"], mp["m"])
        col = [cert["col_cells"][a][b] for (a, b) in cell]
    else:
        M = CMap(mp["sigma"], mp["alpha"])
        cd = cert["col_darts"]
        col = [None] * M.F
        for d in range(M.n):
            if col[M.face[d]] not in (None, cd[d]):
                raise ValueError("col_darts is not constant on a face")
            col[M.face[d]] = cd[d]
    return M, col, k


def main(path):
    M, col, k = load(json.load(open(path)))
    bad = violations(M, col, k)
    inrange = all(isinstance(c, int) and 0 <= c < k for c in col)
    print(f"map: darts {M.n}, V {M.V}, F {M.F}, chi2 {M.chi2}; degrees {sorted(set(M.deg))}, face lengths {sorted(set(M.len))}; k = {k}")
    for x in FIELDS:
        print(f"  {x:16s} {'PASS' if not bad[x] else 'FAIL  first counterexample ' + str(bad[x][0])}")
    print(f"  colours < k      {'PASS' if inrange else 'FAIL'}")
    print(f"  chi2 = 0         {'PASS' if M.chi2 == 0 else 'FAIL'}")
    ok = inrange and M.chi2 == 0 and not any(bad.values())
    print(f"tactic darts: {len(tac(M, col))}")
    print("ACCEPTED: a CountData M k with M.chi2 = 0" if ok else "REJECTED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1]))
