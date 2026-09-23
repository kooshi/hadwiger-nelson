"""FS-73 P3b — the second, independent route for L21cc6506: Θ through the lattice's product structure, exactly.

Route 1 (`tools/fs73_theta_cert.py` + either checker) is a branch-and-bound tree over [0,1]^4. This route shares no frame,
no order and no tree with it. It proves, in Fractions:

  S1  U = B5 · U_R: the 60 unit vectors are exactly {b·x : b ∈ B5, x ∈ U_R}, where U_R is the 12 rational unit vectors
      (±1, ±i, (±4±3i)/5, (±3±4i)/5) and B5 = {1, v, v̄, z, z̄} with v = (83+i√167)/84, z = (1+i)(15−i√167)/28 (products
      computed in ℚ(√167, i) and compared with an enumeration of U).
  S2  span U = (1/210)ℤ[i] ⊕ (v/5)ℤ[i]; so θ ↔ w = (θ(1/210), θ(i/210), θ(v/5), θ(iv/5)) ∈ ℝ⁴ with periods ℤ⁴, and for
      b ∈ B5 the map μ_b(w) = (θ(b), θ(bi)) ∈ ℝ² gives θ(b·x) = ⟨μ_b, x⟩ for x ∈ ℚ(i). Hence
          Θ ≠ ∅  ⟺  ∃ w ∈ [0,1)⁴ with μ_b(w) ∈ Θ_R for every b ∈ B5,
      Θ_R = {μ ∈ ℝ² : ⟨μ, x⟩ mod 1 ∈ [1/3, 2/3] for every x ∈ U_R}, which is 5ℤ²-periodic.
  S3  Θ_R = c0 + (D0 ∪ F4) + 5ℤ², c0 = (5/2, 5/2), D0 = {δ : |⟨δ, x⟩| ≤ 1/6 for x ∈ U_R} (a dodecagon), F4 = the four
      isolated points (±5/6, ±5/6): by exact vertex enumeration (every nonempty cell of the band arrangement has a vertex;
      a vertex lies in exactly one cell because distinct bands never touch).
  S4  μ_1(w) = 210(w1, w2) and ν(w) := μ_v(w) = 5(w3, w4). So on [0,1)⁴, μ_1 = c0 + 5k + δ1 with k ∈ {0..41}², ν = c0 + δ2,
      δ1, δ2 ∈ D0 ∪ F4 — every point of the domain with μ_1, ν ∈ Θ_R is covered exactly once by (k, piece1, piece2). For each
      of the 1764 · 25 cases, the three remaining conditions (b = v̄, z, z̄) are affine in (δ1, δ2): a case dies when some
      μ_b's exact bounding box misses every translate c0 + piece + 5m; the survivors are decided by exact LP certificates
      (a Farkas vector checked in Fractions, or an exact feasible point checked in Fractions).

Output: a JSON record of every surviving case and its Farkas certificate (labelled rows, nonzero multipliers only), and
the verdict. Pure Python Fractions (the exact simplex of fs73_theta_lib); every Farkas vector is re-checked here, and the
whole record by the standalone `tools/fs73_theta_struct_check.py`, which re-derives the reduction and the case sweep.

Usage: python3 tools/fs73_theta_struct.py OUT.json [CONDITIONS]   (CONDITIONS, e.g. "vbar", drops the others: a control)
"""
import itertools
import json
import math
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from fs73_theta_check import enumerate_units, hnf_rows, solve_rows  # noqa: E402  (the standalone checker's enumeration)
from fs73_theta_lib import exact_lp_max  # noqa: E402

KEY, D, M = "420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2", 167, 420
THIRD, TWO_THIRDS = Fr(1, 3), Fr(2, 3)


def mul(u, v):
    """Product of ((a+b√d)+i(c+e√d))/M elements, returned as integer (a,b,c,e)/M (asserting integrality)."""
    a1, b1, c1, e1 = u
    a2, b2, c2, e2 = v
    xr = (a1 * a2 + D * b1 * b2) - (c1 * c2 + D * e1 * e2)
    xs = (a1 * b2 + b1 * a2) - (c1 * e2 + e1 * c2)
    yr = (a1 * c2 + D * b1 * e2) + (c1 * a2 + D * e1 * b2)
    ys = (a1 * e2 + b1 * c2) + (c1 * b2 + e1 * a2)
    t = [xr, xs, yr, ys]
    assert all(x % M == 0 for x in t)
    return tuple(x // M for x in t)


def band(t):
    f = t - math.floor(t)
    return THIRD <= f <= TWO_THIRDS


def dot(mu, x):
    return mu[0] * x[0] + mu[1] * x[1]


def main(out, rest=("vbar", "z", "zbar")):
    rec = {"key": KEY, "d": D}
    # ---- S1 ----
    _, _, U = enumerate_units(KEY, D)
    UR = [u for u in U if u[1] == 0 and u[3] == 0]
    assert len(UR) == 12
    B5 = {"1": (420, 0, 0, 0), "v": (415, 0, 0, 5), "vbar": (415, 0, 0, -5), "z": (225, 15, 225, -15),
          "zbar": (225, 15, -225, 15)}
    prods = {mul(b, x) for b in B5.values() for x in UR}
    assert prods == set(U) and len(U) == 60, "S1 fails"
    rec["S1"] = "U = B5 * U_R (60 = 5 x 12, set equality with the enumeration)"
    # ---- S2 ----
    basis = [[2, 0, 0, 0], [0, 0, 2, 0], [83, 0, 0, 1], [0, -1, 83, 0]]     # 1/210, i/210, v/5, iv/5
    assert hnf_rows(basis) == hnf_rows(U), "S2 fails: the basis does not span span(U)"
    I = (0, 0, 420, 0)
    coord = lambda u: [Fr(t) for t in solve_rows(basis, u)]
    # μ_b(w) = (c_b · w, c_{b i} · w): a 2×4 matrix per b
    Mb = {n: [coord(b), coord(mul(b, I))] for n, b in B5.items()}
    assert all(t.denominator == 1 for n in Mb for row in Mb[n] for t in row)
    assert Mb["1"] == [[210, 0, 0, 0], [0, 210, 0, 0]] and Mb["v"] == [[0, 0, 5, 0], [0, 0, 0, 5]]
    # θ(b·x) = ⟨μ_b, x⟩ for x ∈ U_R: check the coordinates of b·x equal x_r c_b + x_i c_{bi}
    for n, b in B5.items():
        for x in UR:
            xr, xi = Fr(x[0], M), Fr(x[2], M)
            lhs = coord(mul(b, x))
            rhs = [xr * Mb[n][0][k] + xi * Mb[n][1][k] for k in range(4)]
            assert lhs == rhs
    rec["S2"] = {"basis_abce": basis, "mu_b_matrices": {n: [[str(t) for t in r] for r in Mb[n]] for n in Mb}}
    # ---- S3: Θ_R by exact vertex enumeration over one period [0,5)^2 ----
    X = [(Fr(u[0], M), Fr(u[2], M)) for u in UR]
    Xh = []
    for x in X:
        if (-x[0], -x[1]) not in Xh:
            Xh.append(x)
    lines = []
    for (a, b) in Xh:
        vals = [a * p + b * q for p in (0, 5) for q in (0, 5)]
        for k in range(math.floor(3 * min(vals)) - 1, math.ceil(3 * max(vals)) + 2):
            if k % 3:
                lines.append((a, b, Fr(k, 3)))
    V = set()
    for (a1, b1, c1), (a2, b2, c2) in itertools.combinations(lines, 2):
        det = a1 * b2 - a2 * b1
        if det == 0:
            continue
        p = (c1 * b2 - c2 * b1) / det
        q = (a1 * c2 - a2 * c1) / det
        if 0 <= p < 5 and 0 <= q < 5 and all(band(dot((p, q), x)) for x in Xh):
            V.add((p, q))
    c0 = (Fr(5, 2), Fr(5, 2))
    cells = {}
    for v in V:
        cells.setdefault(tuple(math.floor(dot(v, x)) for x in Xh), []).append(v)
    # D0: the cell of c0; its j-vector is floor(<c0,x>) and its constraints are exactly |<δ, x>| <= 1/6
    j0 = tuple(math.floor(dot(c0, x)) for x in Xh)
    assert all(dot(c0, x) - math.floor(dot(c0, x)) == Fr(1, 2) for x in Xh)
    assert j0 in cells and len(cells[j0]) == 12
    F4 = [(Fr(s1 * 5, 6), Fr(s2 * 5, 6)) for s1 in (1, -1) for s2 in (1, -1)]
    others = sorted(k for k in cells if k != j0)
    assert len(others) == 4 and sorted(len(cells[k]) for k in others) == [1, 1, 1, 1]
    assert sorted((v[0] - c0[0], v[1] - c0[1]) for k in others for v in cells[k]) == sorted(F4)
    rec["S3"] = {"vertices": len(V), "D0_vertices": len(cells[j0]),
                 "isolated_points": [[str(t) for t in f] for f in F4]}
    # ---- S4: the case sweep ----
    # D0 as inequalities in δ: <δ,x> <= 1/6 and -<δ,x> <= 1/6 for x in Xh (x and -x cover U_R)
    D0rows = [(x[0], x[1]) for x in Xh] + [(-x[0], -x[1]) for x in Xh]
    vx = cells[j0]
    D0lo = (min(v[0] for v in vx) - c0[0], min(v[1] for v in vx) - c0[1])
    D0hi = (max(v[0] for v in vx) - c0[0], max(v[1] for v in vx) - c0[1])
    pieces = ["D0"] + [f"F{t}" for t in range(4)]
    def piece_box(pc):
        if pc == "D0":
            return D0lo, D0hi
        f = F4[int(pc[1])]
        return f, f
    rest = list(rest)
    survivors = []
    ncases = 0
    for k1 in range(42):
        for k2 in range(42):
            for p1 in pieces:
                for p2 in pieces:
                    ncases += 1
                    # w as affine function of (δ1, δ2): w1 = (c0 + 5k + δ1)_p / 210, w3 = (c0 + δ2)_p / 5, ...
                    lo1, hi1 = piece_box(p1); lo2, hi2 = piece_box(p2)
                    base = [(c0[0] + 5 * k1) / 210, (c0[1] + 5 * k2) / 210, c0[0] / 5, c0[1] / 5]
                    # partial derivatives of w wrt (δ1p, δ1q, δ2p, δ2q)
                    J = [[Fr(1, 210), 0, 0, 0], [0, Fr(1, 210), 0, 0], [0, 0, Fr(1, 5), 0], [0, 0, 0, Fr(1, 5)]]
                    dlo = [lo1[0], lo1[1], lo2[0], lo2[1]]; dhi = [hi1[0], hi1[1], hi2[0], hi2[1]]
                    targets = {}
                    dead = False
                    for n in rest:
                        rng = []
                        for row in Mb[n]:
                            cst = sum(row[t] * base[t] for t in range(4)) - c0[len(rng)]
                            g = [sum(row[t] * J[t][s] for t in range(4)) for s in range(4)]
                            lo = cst + sum(min(g[s] * dlo[s], g[s] * dhi[s]) for s in range(4))
                            hi = cst + sum(max(g[s] * dlo[s], g[s] * dhi[s]) for s in range(4))
                            rng.append((lo, hi, cst, g))
                        # candidate (piece, m): piece box + 5m meets [lo,hi] in both coordinates
                        cand = []
                        for pc in pieces:
                            plo, phi = piece_box(pc)
                            ms = []
                            for ax in range(2):
                                lo, hi = rng[ax][0], rng[ax][1]
                                ms.append([m for m in range(math.floor((lo - phi[ax]) / 5), math.ceil((hi - plo[ax]) / 5) + 1)
                                           if plo[ax] + 5 * m <= hi and phi[ax] + 5 * m >= lo])
                            for m0 in ms[0]:
                                for m1 in ms[1]:
                                    cand.append((pc, m0, m1))
                        if not cand:
                            dead = True
                            break
                        targets[n] = (cand, rng)
                    if dead:
                        continue
                    survivors.append(((k1, k2, p1, p2), targets))
    rec["cases"] = ncases
    rec["box_survivors"] = len(survivors)
    print(f"S4: {ncases} cases, {len(survivors)} survive the exact bounding-box test", flush=True)
    # exact LP on each survivor x each target combination
    decided = []
    nonempty = []
    for (case, targets) in survivors:
        k1, k2, p1, p2 = case
        combos = list(itertools.product(*[targets[n][0] for n in rest]))
        for combo in combos:
            A, b, labels = [], [], []
            # variables δ = (δ1p, δ1q, δ2p, δ2q)
            def add_piece(who, pc, coefs, cst, shift):
                """constrain  (coefs·δ + cst) - 5*shift  ∈ piece  (coefs: 2 rows of 4); every row is labelled."""
                if pc == "D0":
                    for (xa, xb) in D0rows:
                        row = [xa * coefs[0][s] + xb * coefs[1][s] for s in range(4)]
                        A.append(row); b.append(Fr(1, 6) - (xa * (cst[0] - 5 * shift[0]) + xb * (cst[1] - 5 * shift[1])))
                        labels.append([who, "x", int(xa * M), int(xb * M)])
                else:
                    f = F4[int(pc[1])]
                    for ax in range(2):
                        val = cst[ax] - 5 * shift[ax] - f[ax]
                        A.append(list(coefs[ax])); b.append(-val); labels.append([who, "pt", ax, 1])
                        A.append([-t for t in coefs[ax]]); b.append(val); labels.append([who, "pt", ax, -1])
            E = lambda i: [Fr(1) if s == i else Fr(0) for s in range(4)]
            add_piece("d1", p1, [E(0), E(1)], (Fr(0), Fr(0)), (0, 0))
            add_piece("d2", p2, [E(2), E(3)], (Fr(0), Fr(0)), (0, 0))
            for n, (pc, m0, m1) in zip(rest, combo):
                rng = targets[n][1]
                add_piece(n, pc, [rng[0][3], rng[1][3]], (rng[0][2], rng[1][2]), (m0, m1))
            st, x, y = exact_lp_max(A, b, [0, 0, 0, 0])
            if st == "infeasible":
                # verify the Farkas vector here, independently of the simplex: y >= 0, yA = 0, y.b < 0
                assert all(t >= 0 for t in y)
                assert all(sum(y[i] * A[i][s] for i in range(len(A))) == 0 for s in range(4))
                assert sum(y[i] * b[i] for i in range(len(A))) < 0
                decided.append({"case": list(case), "targets": {n: list(c) for n, c in zip(rest, combo)},
                                "farkas": [labels[i] + [str(y[i])] for i in range(len(A)) if y[i] != 0]})
            else:
                assert st == "optimal"
                assert all(sum(A[i][s] * x[s] for s in range(4)) <= b[i] for i in range(len(A)))
                nonempty.append({"case": list(case), "targets": [list(c) for c in combo], "delta": [str(t) for t in x]})
    rec["conditions"] = rest
    rec["B5"] = {n: list(b) for n, b in B5.items()}
    rec["basis"] = basis
    rec["lp_decided_empty"] = len(decided)
    rec["nonempty"] = nonempty
    rec["verdict"] = "EMPTY" if not nonempty else "NONEMPTY"
    rec["farkas_certificates"] = decided
    json.dump(rec, open(out, "w"), indent=1)
    print(f"S4: {len(decided)} target combinations refuted by verified Farkas vectors, {len(nonempty)} feasible;"
          f" verdict Θ {rec['verdict']}")


if __name__ == "__main__":
    # a second argument drops conditions, for the control that the sweep can return NONEMPTY (e.g. "vbar")
    main(sys.argv[1], sys.argv[2].split(",") if len(sys.argv) > 2 else ("vbar", "z", "zbar"))
