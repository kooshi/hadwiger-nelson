#!/usr/bin/env python3
"""FS-81 phase 0: standalone checker for a STRUCTURAL Θ-emptiness certificate of the listed configuration
B = {vᵏ : |k| ≤ 2}·U^(5^K) over ℚ(√d), n = (d+1)/4, v = ((2n−1) + i√d)/(2n).  Fractions and integers only; imports nothing from
this repository; re-derives every step from (d, K) except the Farkas vectors, which it checks.

The argument (each computational step is re-done below; the two hand steps are marked [hand]):
  R1  v v̄ = 1 and v + v̄ = t := 2 − 1/n, so v^(k+1) = t vᵏ − v^(k−1); every element of U = {vᵏ x : |k| ≤ 2, x ∈ U^(5^K)} is a unit
      vector of ℚ(√d)² (norm 1, computed exactly), where U^(5^K) = {(p + iq)/5^K : p² + q² = 25^K}.
  R2  [hand] For θ ∈ Hom(span U, ℝ), extended ℚ-linearly, put μ_k = (θ(vᵏ), θ(i vᵏ)).  Then θ(vᵏ x) = (p μ_k,1 + q μ_k,2)/5^K for
      x = (p + iq)/5^K, and by R1 μ_(k+1) + μ_(k−1) = t μ_k, i.e. n Δ²μ_k + μ_k = 0 for k = −1, 0, 1.
  R3  Θ_K := {μ : (p μ₁ + q μ₂)/5^K mod 1 ∈ [1/3, 2/3] for all (p, q)} ⊆ c + (P ∪ F) + 5^K ℤ², with c = 5^K(½, ½),
      P = {δ : |(p δ₁ + q δ₂)/5^K| ≤ 1/6 for all (p, q)} and F = {5^K(±1/6, ±1/6)}; proved here by induction on the level j = 0..K:
      level 0 is the square (1/3..2/3)² + ℤ²; at level j every one of the 25 lifts of every level-(j−1) piece is intersected
      exactly (closed half-planes, Fractions) with every band combination of the level's new directions, and each nonempty result
      is shown to lie in a translate of c_j + P_j or to be a point of c_j + F_j (+ 5^j ℤ²).
  R4  [hand] With μ_k = c + 5^K m_k + δ_k (m_k ∈ ℤ², δ_k ∈ P ∪ F), R2 gives L_k(δ) := n Δ²δ_k + δ_k ∈ 5^K (ℤ + ½)² (k = −1, 0, 1).
      Checked here: for every assignment of types (P or one of the four points) to the five layers, every combination of
      half-integer targets whose 5^K-multiple meets the exact interval range of L_k (P ⊆ [−1/6, 1/6]², from (p, q) = (5^K, 0),
      (0, 5^K)) carries a Farkas vector: y ≥ 0 on P's inequalities, z free on the target equalities, yA + zE = 0, y·b + z·e < 0.
  Hence no θ exists: Θ = ∅, so by the criterion's ⟹ direction (FS73-T22, T42) Cay(span U, ±U) is not 3-colourable, and it is a
  subgraph of the unit-distance graph of ℚ(√d)²: χ(ℚ(√d)²) ≥ 4.

Usage: fs81_struct_check.py CERT.json                 (exit 0 = PASS, 1 = FAIL with the reason)
       fs81_struct_check.py --self-test CERT.json      (plants; each must FAIL for its named reason)
"""
from __future__ import annotations

import copy
import gzip
import hashlib
import itertools
import json
import math
import sys
from fractions import Fraction as F

THIRD, TWOTHIRD, SIXTH, HALF = F(1, 3), F(2, 3), F(1, 6), F(1, 2)
LAYERS = (-2, -1, 0, 1, 2)


class Fail(Exception):
    pass


# ---------------------------------------------------------------- R1: the field and the configuration

def fmul(d, x, y):
    a, b, c, e = x
    a2, b2, c2, e2 = y
    return (a * a2 + d * b * b2 - c * c2 - d * e * e2, a * b2 + b * a2 - c * e2 - e * c2,
            a * c2 + d * b * e2 + c * a2 + d * e * b2, a * e2 + b * c2 + c * b2 + e * a2)


def level_dirs(j):
    m = 5 ** j
    out = set()
    for p in range(-m, m + 1):
        q = math.isqrt(m * m - p * p)
        if q * q == m * m - p * p:
            for qq in (q, -q):
                out.add((p, qq))
    return sorted(out)


def r1(d, K):
    if d % 4 != 3 or d <= 3:
        raise Fail(f"d = {d} is not ≡ 3 (mod 4)")
    n = (d + 1) // 4
    v = (F(2 * n - 1, 2 * n), F(0), F(0), F(1, 2 * n))
    vb = (v[0], v[1], -v[2], -v[3])
    one = (F(1), F(0), F(0), F(0))
    if fmul(d, v, vb) != one:
        raise Fail("v v̄ ≠ 1")
    t = F(2 * n - 1, n)
    if (v[0] + vb[0], v[1] + vb[1], v[2] + vb[2], v[3] + vb[3]) != (t, F(0), F(0), F(0)):
        raise Fail("v + v̄ ≠ 2 − 1/n")
    powers = {0: one, 1: v, -1: vb}
    powers[2] = fmul(d, v, v)
    powers[-2] = fmul(d, vb, vb)
    for k in (-1, 0, 1):   # the recurrence, exactly
        lhs = powers[k + 1]
        rhs = tuple(t * a - b for a, b in zip(powers[k], powers[k - 1]))
        if lhs != rhs:
            raise Fail(f"v^{k + 1} ≠ t v^{k} − v^{k - 1}")
    m = 5 ** K
    count = 0
    for k in LAYERS:
        for p, q in level_dirs(K):
            u = fmul(d, powers[k], (F(p, m), F(0), F(q, m), F(0)))
            a, b, c, e = u
            if (a * a + d * b * b + c * c + d * e * e, a * b + c * e) != (1, 0):
                raise Fail(f"v^{k}·({p} + {q}i)/{m} is not a unit vector")
            count += 1
    return n, count


# ---------------------------------------------------------------- R3: the rational layer, by induction on the level

def clip(poly, a, b, c):
    """poly ∩ {a μ₁ + b μ₂ ≤ c}, exact; poly is a vertex list (a point or segment allowed)."""
    def val(P):
        return a * P[0] + b * P[1] - c
    if not poly:
        return []
    if len(poly) == 1:
        return poly if val(poly[0]) <= 0 else []
    out = []
    for i in range(len(poly)):
        P, Q = poly[i], poly[(i + 1) % len(poly)]
        vp, vq = val(P), val(Q)
        if vp <= 0:
            out.append(P)
        if vp * vq < 0:
            s = vp / (vp - vq)
            out.append((P[0] + s * (Q[0] - P[0]), P[1] + s * (Q[1] - P[1])))
    res = []
    for P in out:
        if P not in res:
            res.append(P)
    return res


def in_piece(pt, j, dirs_j, allow_points=True):
    """Is pt ∈ c_j + (P_j ∪ F_j) + 5^j ℤ²?  Returns 'P', 'F' or None."""
    m = 5 ** j
    rel = [pt[i] - F(m, 2) for i in range(2)]
    rel = [x - m * round(x / m) for x in rel]                      # nearest translate
    if all(abs((p * rel[0] + q * rel[1]) / m) <= SIXTH for p, q in dirs_j):
        return "P"
    if allow_points and all(abs(abs(x) - F(m, 6)) == 0 for x in rel):
        return "F"
    return None


def p_polygon(j):
    """c_j + P_j as an exact polygon: the square [−1, 1]² clipped by |⟨δ, x⟩| ≤ 1/6 for every level-j direction, shifted."""
    m = 5 ** j
    poly = [(F(-1), F(-1)), (F(1), F(-1)), (F(1), F(1)), (F(-1), F(1))]
    for p, q in level_dirs(j):
        poly = clip(poly, F(p, m), F(q, m), SIXTH)
    return [(x + F(m, 2), y + F(m, 2)) for x, y in poly]


def r3(K, with_points=True):
    """Prove Θ_K ⊆ S_K := c_K + (P_K ∪ F_K) + 5^K ℤ² by induction: Θ_0 = S_0 = [1/3, 2/3]² + ℤ², and Θ_j ⊆ S_(j−1) ∩ (the new
    directions' bands) ⊆ S_j, checked on every lift of every piece of S_(j−1) (the polygon c + P and the four points c + F).
    Returns the number of nonempty lifted pieces examined."""
    pieces = [[(THIRD, THIRD), (TWOTHIRD, THIRD), (TWOTHIRD, TWOTHIRD), (THIRD, TWOTHIRD)]]      # S_0 per period (F_0 ⊆ P_0)
    examined = 0
    for j in range(1, K + 1):
        m, pm = 5 ** j, 5 ** (j - 1)
        dj = level_dirs(j)
        new = [(p, q) for p, q in dj if p % 5 or q % 5]
        for base in pieces:
            for a0, a1 in itertools.product(range(5), repeat=2):
                poly = [(x + a0 * pm, y + a1 * pm) for x, y in base]
                cells = [poly]
                for p, q in new:
                    vals = [(p * x + q * y) / m for x, y in poly]
                    ks = range(math.floor(min(vals)) - 1, math.ceil(max(vals)) + 1)
                    nc = []
                    for cell in cells:
                        for k in ks:
                            piece = clip(clip(cell, F(-p, m), F(-q, m), -(k + THIRD)), F(p, m), F(q, m), k + TWOTHIRD)
                            if piece:
                                nc.append(piece)
                    cells = nc
                for cell in cells:
                    examined += 1
                    kinds = {in_piece(P, j, dj, with_points) for P in cell}
                    if len(cell) == 1 and kinds == {"F"}:
                        continue
                    if kinds == {"P"} and len({tuple(m * round((P[i] - F(m, 2)) / m) for i in range(2)) for P in cell}) == 1:
                        continue
                    raise Fail(f"R3: at level {j} a piece of Θ lies outside c + (P ∪ F) + 5^{j}ℤ²: {cell}")
        c = F(m, 2)
        pieces = [p_polygon(j)] + [[(c + sx * F(m, 6), c + sy * F(m, 6))] for sx in (1, -1) for sy in (1, -1)]
    return examined


# ---------------------------------------------------------------- R4: the δ-system

def lk(n, k):
    return {k + 1: n, k: -(2 * n - 1), k - 1: n}


def points(m):
    return [(F(sx * m, 6), F(sy * m, 6)) for sx in (1, -1) for sy in (1, -1)]


def targets(n, m, k, types, pts):
    lo, hi = [F(0), F(0)], [F(0), F(0)]
    for layer, c in lk(n, k).items():
        for i in range(2):
            if types[layer] == "P":
                lo[i] -= abs(c) * SIXTH
                hi[i] += abs(c) * SIXTH
            else:
                lo[i] += c * pts[types[layer]][i]
                hi[i] += c * pts[types[layer]][i]
    per = []
    for i in range(2):
        a = math.ceil(lo[i] / m - HALF)
        b = math.floor(hi[i] / m - HALF)
        per.append([F(2 * x + 1, 2) for x in range(a, b + 1)])
    return [(x, y) for x in per[0] for y in per[1]]


def system(n, m, dirs_K, pts, types, hs):
    var = {}
    for layer in LAYERS:
        if types[layer] == "P":
            var[layer] = 2 * len(var)
    nv = 2 * len(var)
    A, b, E, e = [], [], [], []
    for layer, off in var.items():
        for p, q in dirs_K:
            row = [F(0)] * nv
            row[off], row[off + 1] = F(p, m), F(q, m)
            A.append(row)
            b.append(SIXTH)
    for k, h in zip((-1, 0, 1), hs):
        for i in range(2):
            row = [F(0)] * nv
            rhs = m * h[i]
            for layer, c in lk(n, k).items():
                if types[layer] == "P":
                    row[var[layer] + i] += c
                else:
                    rhs -= c * pts[types[layer]][i]
            E.append(row)
            e.append(rhs)
    return nv, A, b, E, e


def r4(cert, n, K):
    m = 5 ** K
    dirs_K = level_dirs(K)
    pts = points(m)
    table = {}
    for cs in cert["cases"]:
        table[(tuple(cs["types"]), tuple(tuple(h) for h in cs["h"]))] = cs
    notarget = refuted = 0
    for tys in itertools.product(["P", 0, 1, 2, 3], repeat=5):
        types = dict(zip(LAYERS, tys))
        tg = [targets(n, m, k, types, pts) for k in (-1, 0, 1)]
        if any(not t for t in tg):
            notarget += 1
            continue
        for hs in itertools.product(*tg):
            key = (tuple(str(x) for x in tys), tuple((str(h[0]), str(h[1])) for h in hs))
            cs = table.get(key)
            if cs is None:
                raise Fail(f"R4: no certificate for the case types {key[0]}, targets {key[1]}")
            nv, A, b, E, e = system(n, m, dirs_K, pts, types, hs)
            y = [F(0)] * len(A)
            z = [F(0)] * len(E)
            for i, val in cs["y"].items():
                i = int(i)
                if not 0 <= i < len(A):
                    raise Fail("R4: a multiplier index out of range")
                y[i] = F(val)
                if y[i] < 0:
                    raise Fail(f"R4: negative multiplier on an inequality in case {key}")
            for i, val in cs["z"].items():
                i = int(i)
                if not 0 <= i < len(E):
                    raise Fail("R4: a multiplier index out of range")
                z[i] = F(val)
            for jv in range(nv):
                if sum(y[i] * A[i][jv] for i in range(len(A))) + sum(z[i] * E[i][jv] for i in range(len(E))) != 0:
                    raise Fail(f"R4: Farkas vector does not cancel the variables in case {key}")
            if not sum(y[i] * b[i] for i in range(len(A))) + sum(z[i] * e[i] for i in range(len(E))) < 0:
                raise Fail(f"R4: Farkas vector does not give 0 < 0 in case {key}")
            refuted += 1
    return notarget, refuted


def check(cert):
    if cert.get("verdict") != "EMPTY":
        raise Fail("not an EMPTY certificate")
    d, K = int(cert["d"]), int(cert["K"])
    n, count = r1(d, K)
    examined = r3(K)
    notarget, refuted = r4(cert, n, K)
    return (f"PASS EMPTY (structural): d = {d}, K = {K}, n = {n}; B = {{v^k : |k| <= 2}}.U^(5^{K}), {count} unit vectors "
            f"({count // 2} pairs); rational layer proved at every level <= {K} ({examined} lifted pieces); of 3125 layer-type "
            f"assignments {notarget} have no target and {refuted} target combinations are refuted by checked Farkas vectors. "
            f"So Cay(span U, +-U), a subgraph of the unit-distance graph of Q(sqrt {d})^2, is not 3-colourable: "
            f"chi(Q(sqrt {d})^2) >= 4 [cert + hand: the reduction R2, R4 and FS73-T22 =>]")


# ---------------------------------------------------------------- planted faults

def self_test(cert):
    print("faithful:", check(cert))
    plants = []

    def plant(name, expect, mutate):
        c = copy.deepcopy(cert)
        mutate(c)
        try:
            res = check(c)
        except Fail as ex:
            if expect not in str(ex):
                raise SystemExit(f"PLANT {name}: failed for the WRONG reason: {ex}")
            print(f"plant {name}: FAIL as expected ({ex})")
            plants.append(name)
            return
        raise SystemExit(f"PLANT {name}: the checker PASSED a faulty certificate: {res}")

    if cert["cases"]:
        plant("case-dropped", "no certificate for the case", lambda c: c["cases"].pop(0))

        def m_y(c):
            cs = next(x for x in c["cases"] if x["y"])
            i = next(iter(cs["y"]))
            cs["y"][i] = str(F(cs["y"][i]) * 2)
        plant("multiplier-doubled", "Farkas vector", m_y)

        def m_neg(c):
            cs = next(x for x in c["cases"] if x["y"])
            i = next(iter(cs["y"]))
            cs["y"][i] = str(-F(cs["y"][i]))
        plant("multiplier-negated", "negative multiplier", m_neg)

        def m_z(c):
            cs = next(x for x in c["cases"] if x["z"])
            for i in cs["z"]:
                cs["z"][i] = "0"
        plant("equality-multipliers-zeroed", "Farkas vector", m_z)
    # a field past the threshold: the same (empty) case list cannot cover it
    plant("wider-field", "no certificate for the case", lambda c: c.update(d=int(c["d"]) + 24 * 40))
    plant("lower-level", "no certificate for the case", lambda c: c.update(K=int(c["K"]) - 1) if int(c["K"]) > 1 else
          c.update(d=int(c["d"]) + 24 * 40))
    plant("not-3-mod-4", "is not ≡ 3 (mod 4)", lambda c: c.update(d=int(c["d"]) + 2))
    # R3 must be able to fail: without the order-3 points the inclusion is false (they are real points of Θ_K)
    try:
        r3(int(cert["K"]), with_points=False)
    except Fail as ex:
        if "outside" not in str(ex):
            raise SystemExit(f"PLANT r3-without-points: failed for the WRONG reason: {ex}")
        print(f"plant r3-without-points: FAIL as expected ({ex})"[:200])
        plants.append("r3-without-points")
    else:
        raise SystemExit("PLANT r3-without-points: R3 passed with the order-3 points removed")
    print(f"SELF-TEST OK: faithful certificate passes; {len(plants)} planted faults each fail for their own reason: {plants}")


def load(path):
    with (gzip.open(path, "rt") if path.endswith(".gz") else open(path)) as fh:
        return json.load(fh)


def main():
    args = sys.argv[1:]
    if args and args[0] == "--self-test":
        self_test(load(args[1]))
        return
    if len(args) != 1:
        raise SystemExit(__doc__)
    cert = load(args[0])
    with open(args[0], "rb") as fh:
        sha = hashlib.sha256(fh.read()).hexdigest()[:16]
    try:
        print(f"{check(cert)} [certificate file sha256 {sha}]")
    except Fail as ex:
        print(f"FAIL: {ex}")
        sys.exit(1)


if __name__ == "__main__":
    main()
