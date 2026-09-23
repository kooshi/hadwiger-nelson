#!/usr/bin/env python3
"""FS-73 independent verifier, task 2: Q(sqrt11)'s 3-integral lattice Lambda_10 at THREE colours; the claim F = P = 3 Lambda.

Written without reading tools/fs73_table.py or data/fs73/table/.  Reads FS-58's frozen forcer point sets (read only).

Representation (this file's own): z = x + i y with x, y in Q(sqrt11), stored on the Q-basis (1, i, sqrt11, i sqrt11), scaled by
10 to integers (p, q, r, s):  x = (p + r sqrt11)/10,  y = (q + s sqrt11)/10.  (FS-58 writes (a, b, c, e) for
x = (a + b sqrt11)/10, y = (c + e sqrt11)/10, so (p, q, r, s) = (a, c, b, e).)
  unit vector  <=>  x^2 + y^2 = 1  <=>  p^2 + q^2 + 11 r^2 + 11 s^2 = 100  and  p r + q s = 0      (exact integers)
Lambda_10 = Z-span of the unit vectors with x, y in (1/10) Z[sqrt11] (Z[sqrt11] is the ring of integers of Q(sqrt11)).
"""
from __future__ import annotations

import hashlib
import itertools
import json
import os
import random
import subprocess
import sys
import time
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs73v_lattice as L  # noqa: E402  (only the generic integer HNF / membership routines are reused)

SCR = "/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs73-verifier"
GLUCOSE = os.path.join(SCR, "glucose/simp/glucose_release")
DRAT = os.path.join(SCR, "drat-trim/drat-trim")
ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(SCR, "q11")


def is_unit(v):
    p, q, r, s = v
    return p * p + q * q + 11 * r * r + 11 * s * s == 100 and p * r + q * s == 0


def mul(z, w):
    """product in Q(i, sqrt11) on the basis (1, i, sqrt11, i sqrt11), Fraction coordinates (unscaled)."""
    a0, a1, a2, a3 = z
    b0, b1, b2, b3 = w
    # e1 = i, e2 = sqrt11, e3 = i sqrt11: e1^2 = -1, e2^2 = 11, e3^2 = -11, e1 e2 = e3, e1 e3 = -e2, e2 e3 = 11 e1
    return (a0 * b0 - a1 * b1 + 11 * a2 * b2 - 11 * a3 * b3,
            a0 * b1 + a1 * b0 + 11 * (a2 * b3 + a3 * b2),
            a0 * b2 + a2 * b0 - (a1 * b3 + a3 * b1),
            a0 * b3 + a3 * b0 + (a1 * b2 + a2 * b1))


def fs58(v):  # FS-58 (a, b, c, e) -> this file's (p, q, r, s)
    a, b, c, e = v
    return (a, c, b, e)


def load_forcers():
    f1 = json.load(open(os.path.join(ROOT, "data/fs58/witness-11/forcer.json")))
    f2 = None
    for line in open(os.path.join(ROOT, "data/fs58/witness-11/steps.jsonl")):
        d = json.loads(line)
        if d.get("step") == "forcer/scan/separate/u=-3,-2,-6,1/span3":
            f2 = d
    assert f1["source_step"] == "forcer/scan/separate/u=-6,0,8,0/span2" and f2 is not None
    return {"u1": ([fs58(p) for p in f1["points"]], fs58(f1["u"]), f1["verification"]["edges"]),
            "u2": ([fs58(p) for p in f2["forcer"]], fs58(f2["u"]), None)}


def graph(points, Uset):
    idx = {p: i for i, p in enumerate(points)}
    E = []
    for i, p in enumerate(points):
        for u in Uset:
            j = idx.get(tuple(a + b for a, b in zip(p, u)))
            if j is not None and j > i:
                E.append((i, j))
    return idx, E


def cnf3(n, E, pins, extra_edges=(), seed=1, k=3):
    rng = random.Random(seed)
    perm = list(range(n))
    rng.shuffle(perm)
    x = lambda v, c: c * n + perm[v] + 1
    cls = []
    for v in range(n):
        cls.append([x(v, c) for c in range(k)])
        for c1 in range(k):
            for c2 in range(c1 + 1, k):
                cls.append([-x(v, c1), -x(v, c2)])
    for (a, b) in list(E) + list(extra_edges):
        for c in range(k):
            cls.append([-x(a, c), -x(b, c)])
    for v, c in pins:
        cls.append([x(v, c)])
    rng.shuffle(cls)
    return cls, x, k * n


def write(path, cls, nv):
    with open(path, "w") as f:
        f.write(f"p cnf {nv} {len(cls)}\n")
        for c in cls:
            f.write(" ".join(map(str, c)) + " 0\n")
    return hashlib.sha256(open(path, "rb").read()).hexdigest()


def glucose(cnf, proof=None):
    cmd = [GLUCOSE, "-model"] + (["-certified", "-vbyte", f"-certified-output={proof}"] if proof else []) + [cnf]
    t = time.process_time()
    r = subprocess.run(cmd, capture_output=True, text=True)
    lits = [int(t) for l in r.stdout.splitlines() if l.startswith("v ") for t in l[2:].split()]
    return r.returncode, set(l for l in lits if l > 0)


def drat(cnf, proof):
    r = subprocess.run([DRAT, cnf, proof, "-t", "600"], capture_output=True, text=True)
    return [l for l in (r.stdout + r.stderr).splitlines() if l.startswith("s ")]


def colouring_from(model, n, x, k=3):
    col = []
    for v in range(n):
        cs = [c for c in range(k) if x(v, c) in model]
        assert len(cs) == 1
        col.append(cs[0])
    return col


def main():
    os.makedirs(OUT, exist_ok=True)
    rep = {}
    # ---- check 1: the 36 unit vectors, Lambda_10, rank; bounds exact: 11*r^2 <= 100 -> |r| <= 3
    U = [v for v in itertools.product(range(-10, 11), range(-10, 11), range(-3, 4), range(-3, 4)) if is_unit(v)]
    Uset = set(U)
    H = L.hnf_rows([list(u) for u in U])
    det = 1
    for row in H:
        det *= next(t for t in row if t)
    rep["check1"] = {"unit_vectors_denominator_10": len(U), "rank": len(H), "hnf_10Lambda": H, "index_in_Z4": det,
                     "complete_U_note": "Lambda_10 is in (1/10)Z^4 (span of vectors there), so its unit vectors are exactly these",
                     "all_in_Lambda": all(L.member(H, u) is not None for u in U), "closed_under_minus": all(tuple(-t for t in u) in Uset for u in U)}
    assert len(H) == 4
    # ---- check 2 and 3: the forcers
    forc = load_forcers()
    rep["forcers"] = {}
    for name, (pts, u, rec_edges) in forc.items():
        pts = [tuple(p) for p in pts]
        assert is_unit(u), name
        three_u = tuple(3 * t for t in u)
        zero = (0, 0, 0, 0)
        idx, E = graph(pts, Uset)
        r = {"u_pqrs": u, "points": len(pts), "distinct": len(set(pts)), "edges": len(E), "recorded_edges": rec_edges,
             "all_in_Lambda": all(L.member(H, p) is not None for p in pts), "has_0": zero in idx, "has_3u": three_u in idx,
             "0_3u_adjacent": tuple(b - a for a, b in zip(zero, three_u)) in Uset}
        n = len(pts)
        o, t = idx[zero], idx[three_u]
        # control A: the graph alone is 3-colourable (else the forcing would be vacuous) -- colouring verified
        cls, x, nv = cnf3(n, E, [(o, 0)], seed=11)
        path = os.path.join(OUT, f"{name}-plain.cnf")
        write(path, cls, nv)
        ex, m = glucose(path)
        col = colouring_from(m, n, x)
        r["controlA_graph_3colourable"] = {"exit": ex, "mono_edges": sum(col[a] == col[b] for a, b in E), "c0_c3u": (col[o], col[t])}
        assert ex == 10 and r["controlA_graph_3colourable"]["mono_edges"] == 0
        # the ask: graph + edge {0, 3u}, pins c(0)=0, c(3u)=1 (the only break: 3 colours, two pinned, nothing left to permute)
        cls, x, nv = cnf3(n, E, [(o, 0), (t, 1)], extra_edges=[(o, t)], seed=7)
        path = os.path.join(OUT, f"{name}-ask.cnf")
        h = write(path, cls, nv)
        proof = os.path.join(OUT, f"{name}-ask.drat")
        ex, _ = glucose(path, proof)
        r["ask"] = {"cnf_sha256": h, "clauses": len(cls), "glucose_exit": ex, "verdict": {10: "SAT", 20: "UNSAT"}.get(ex, "?")}
        r["ask"]["drat_faithful"] = drat(path, proof)
        # planted: drop the added edge and the pin on 3u -> satisfiable (control A's colouring, relabelled, is a model)
        planted = [c for c in cls if c != [x(t, 1)] and not (len(c) == 2 and {abs(c[0]), abs(c[1])} in
                                                                 [{x(o, cc), x(t, cc)} for cc in range(3)] and c[0] < 0 and c[1] < 0)]
        # model check of the planted formula by control A's colouring with c(0) relabelled to 0
        colA = r["controlA_graph_3colourable"]
        pp = os.path.join(OUT, f"{name}-planted.cnf")
        write(pp, planted, nv)
        exp, mp = glucose(pp)
        r["ask"]["planted_sat"] = exp == 10
        r["ask"]["drat_planted"] = drat(pp, proof)
        r["ask"]["planted_removed_clauses"] = len(cls) - len(planted)
        # consistency: every vertex w of the forcer with w not in 3 Lambda must be separable from 0 in this graph
        H3 = [[3 * v for v in row] for row in H]
        sep, forced_in3 = [], []
        for w, j in idx.items():
            if j == o or tuple(b - a for a, b in zip(zero, w)) in Uset:
                continue
            c2, x2, nv2 = cnf3(n, E, [(o, 0), (j, 1)], seed=3)
            p2 = os.path.join(OUT, f"{name}-w.cnf")
            write(p2, c2, nv2)
            e2, m2 = glucose(p2)
            in3 = L.member(H3, w) is not None
            if e2 == 20:
                forced_in3.append((w, in3))
            else:
                colw = colouring_from(m2, n, x2)
                assert all(colw[a] != colw[b] for a, b in E) and colw[o] != colw[j]
                sep.append((w, in3))
        r["pairs_in_graph"] = {"separable": len(sep), "separable_in_3Lambda": sum(1 for _, b in sep if b),
                               "forced": [w for w, _ in forced_in3], "forced_all_in_3Lambda": all(b for _, b in forced_in3)}
        rep["forcers"][name] = r
    # ---- check 4: the point group, staged; basis (1, i, u2, i*u2)
    u2 = forc["u2"][1]
    one, ii = (10, 0, 0, 0), (0, 10, 0, 0)
    iu2 = tuple(int(t * 10) for t in mul(tuple(Fr(c, 10) for c in (0, 10, 0, 0)), tuple(Fr(c, 10) for c in u2)))
    basis = [one, ii, u2, iu2]
    assert all(b in Uset for b in basis) and len(L.hnf_rows([list(b) for b in basis])) == 4

    def solve(M, b):
        n = 4
        A = [[Fr(M[i][j]) for j in range(n)] + [Fr(b[i])] for i in range(n)]
        for c in range(n):
            piv = next(rr for rr in range(c, n) if A[rr][c] != 0)
            A[c], A[piv] = A[piv], A[c]
            pv = A[c][c]
            A[c] = [t / pv for t in A[c]]
            for rr in range(n):
                if rr != c and A[rr][c] != 0:
                    f = A[rr][c]
                    A[rr] = [a - f * bb for a, bb in zip(A[rr], A[c])]
        return [A[i][n] for i in range(n)]
    M = [[basis[j][i] for j in range(4)] for i in range(4)]
    co = {v: solve(M, v) for v in U}

    def img(ws, v):
        c = co[v] if v in co else solve(M, v)
        g = tuple(sum(c[j] * ws[j][i] for j in range(4)) for i in range(4))
        return g

    stage1 = [v for v in U if co[v][2] == 0 and co[v][3] == 0]
    G = []
    for w1, w2 in itertools.product(U, repeat=2):
        if not all(img((w1, w2, (0,) * 4, (0,) * 4), v) in {tuple(Fr(t) for t in uu) for uu in U} for v in stage1):
            continue
        for w3, w4 in itertools.product(U, repeat=2):
            ws = (w1, w2, w3, w4)
            ok = True
            ims = set()
            for v in U:
                g = img(ws, v)
                if any(t.denominator != 1 for t in g) or tuple(int(t) for t in g) not in Uset:
                    ok = False
                    break
                ims.add(tuple(int(t) for t in g))
            if ok and len(ims) == len(U) and len(L.hnf_rows([list(w) for w in ws])) == 4:
                G.append(ws)
    rep["check4"] = {"point_group_order": len(G), "stage1_rows": len(stage1)}

    def gimg(ws, v):
        g = img(ws, v)
        assert all(t.denominator == 1 for t in g)
        return tuple(int(t) for t in g)
    H3 = [[3 * v for v in row] for row in H]
    HH3 = L.hnf_rows(H3)

    def span(vs):
        Hs = L.hnf_rows([list(v) for v in vs])
        d = 1
        for row in Hs:
            d *= next(t for t in row if t)
        return {"rank": len(Hs), "index_in_Lambda": (d // det) if len(Hs) == 4 else None, "equals_3Lambda": Hs == HH3,
                "inside_3Lambda": all(L.member(H3, v) is not None for v in vs)}
    o1 = sorted({gimg(ws, tuple(3 * t for t in forc["u1"][1])) for ws in G})
    o2 = sorted({gimg(ws, tuple(3 * t for t in u2)) for ws in G})
    rep["check4"].update({"orbit_sizes": (len(o1), len(o2)), "span_3u1": span(o1), "span_3u2": span(o2), "span_both": span(o1 + o2)})
    # ---- check 5: Lambda/3Lambda, orbits of lines, 3Lambda-periodic 3-colourings
    cof = lambda v: tuple(t % 3 for t in L.member(H, v))
    Ucl = sorted({cof(u) for u in U})
    assert (0, 0, 0, 0) not in Ucl
    V = list(itertools.product(range(3), repeat=4))
    vid = {v: i for i, v in enumerate(V)}
    add = lambda a, b: tuple((x + y) % 3 for x, y in zip(a, b))
    QE = sorted({tuple(sorted((vid[v], vid[add(v, u)]))) for v in V for u in Ucl})
    lat = lambda c: tuple(sum(ci * H[i][j] for i, ci in enumerate(c)) for j in range(4))  # a lattice vector in class c
    lines = {}
    for c in V:
        if any(c):
            key = min(c, tuple((2 * t) % 3 for t in c))
            lines[key] = True
    seen, orbits = set(), []
    for l in sorted(lines):
        if l in seen:
            continue
        orb = set()
        for ws in G:
            g = cof(gimg(ws, lat(l)))
            orb.add(min(g, tuple((2 * t) % 3 for t in g)))
        seen |= orb
        orbits.append(sorted(orb))
    # a check ball to pull colourings back onto: lattice points with basis coefficients in [-3, 3]
    ball = [lat(c) for c in itertools.product(range(-3, 4), repeat=4)]
    bidx, bE = graph(ball, Uset)
    res5 = []
    for orb in orbits:
        rcl = orb[0]
        cls, x, nv = cnf3(81, QE, [(vid[(0, 0, 0, 0)], 0), (vid[rcl], 1)], seed=5)
        p5 = os.path.join(OUT, "quot.cnf")
        write(p5, cls, nv)
        e5, m5 = glucose(p5)
        entry = {"orbit_size": len(orb), "rep_class": rcl, "rep_vector_pqrs_over10": lat(rcl), "rep_adjacent_to_0": rcl in Ucl,
                 "verdict": {10: "SAT", 20: "UNSAT"}.get(e5)}
        if e5 == 10:
            col = colouring_from(m5, 81, x)
            entry["quotient_mono"] = sum(col[a] == col[b] for a, b in QE)
            bcol = [col[vid[cof(p)]] for p in ball]
            entry["pullback_points"], entry["pullback_edges"] = len(ball), len(bE)
            entry["pullback_mono"] = sum(bcol[a] == bcol[b] for a, b in bE)
            entry["c0_crep"] = (col[vid[(0, 0, 0, 0)]], col[vid[rcl]])
            # is the colouring affine? c(v) - c(0) linear over F3 in the class coordinates
            f = [(col[vid[e]] - col[vid[(0,) * 4]]) % 3 for e in [(1, 0, 0, 0), (0, 1, 0, 0), (0, 0, 1, 0), (0, 0, 0, 1)]]
            entry["affine"] = all((col[vid[v]] - col[vid[(0,) * 4]]) % 3 == sum(a * b for a, b in zip(f, v)) % 3 for v in V)
        res5.append(entry)
    rep["check5"] = {"lines": len(lines), "orbits_of_lines": [len(o) for o in orbits], "quotient_edges": len(QE),
                     "U_mod_3": len(Ucl), "asks": res5}
    return rep


if __name__ == "__main__" and "--exhaustive" not in sys.argv:
    print(json.dumps(main(), indent=1, default=str))


def exhaustive(points, U, target):
    """Solver-free leg: enumerate EVERY proper 3-colouring with c(0) = 0 by plain backtracking (vertices in BFS order from 0),
    and return (number of colourings, number with c(target) != 0).  Forcing holds iff the second number is 0 and the first > 0."""
    Uset = set(U)
    idx, E = graph([tuple(p) for p in points], Uset)
    n = len(points)
    adj = [[] for _ in range(n)]
    for a, b in E:
        adj[a].append(b)
        adj[b].append(a)
    o, t = idx[(0, 0, 0, 0)], idx[tuple(target)]
    order, seen = [o], {o}
    k = 0
    while k < len(order):
        for w in adj[order[k]]:
            if w not in seen:
                seen.add(w)
                order.append(w)
        k += 1
    order += [v for v in range(n) if v not in seen]
    col = [-1] * n
    total = bad = 0

    def rec(i):
        nonlocal total, bad
        if i == n:
            total += 1
            if col[t] != col[o]:
                bad += 1
            return
        v = order[i]
        for c in ((0,) if v == o else (0, 1, 2)):
            if all(col[w] != c for w in adj[v]):
                col[v] = c
                rec(i + 1)
                col[v] = -1
    sys.setrecursionlimit(10000)
    rec(0)
    return {"colourings_with_c0_0": total, "with_c3u_ne_c0": bad, "connected": len(seen) == n}


if __name__ == "__main__" and "--exhaustive" in sys.argv:
    U = [v for v in itertools.product(range(-10, 11), range(-10, 11), range(-3, 4), range(-3, 4)) if is_unit(v)]
    for name, (pts, u, _) in load_forcers().items():
        t0 = time.process_time()
        r = exhaustive(pts, U, tuple(3 * c for c in u))
        print(name, r, round(time.process_time() - t0, 2), "cpu s", flush=True)
