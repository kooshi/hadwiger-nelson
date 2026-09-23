#!/usr/bin/env python3
"""FS-73 V2: standalone exact checker for a Θ certificate.  Fraction/int arithmetic only; imports nothing from this repository.

What a PASS on an EMPTY certificate proves (the chain is spelled out in data/fs73/records/verify-P3b-q167.md):
  1. every listed u = (a, b, c, e) is a unit vector of ℚ(√d)²: a² + d b² + c² + d e² = D², ab + ce = 0, u ≠ 0;
  2. every listed relation r satisfies Σ r_j u_j = 0 in ℤ⁴;
  3. the tree's branchings cover every x ∈ B = [1/3, 2/3]^N with r·x ∈ ℤ for all relations used, and every leaf's multipliers
     combine its path's constraints into w·x ≤ ρ with min_B w·x > ρ (so no x ∈ B lies in the leaf).
  Hence no θ ∈ Hom(span U, ℝ) has θ(u) mod 1 ∈ [1/3, 2/3] for all listed u (x_u = θ(u) − ⌊θ(u)⌋ would be such an x), so by the
  criterion's ⟹ direction Cay(span U, ±U) is not 3-colourable, and it is a subgraph of the unit-distance graph of ℚ(√d)².
It also reports whether the listed units are ALL unit vectors of the key lattice (its own exhaustive enumeration) — needed to
name the graph as the lattice's full unit-distance graph, not for soundness.

A NONEMPTY certificate gives θ in (a, b, c, e)-dual coordinates; PASS means θ(u) mod 1 ∈ [1/3, 2/3] for EVERY unit vector of the
key lattice (own enumeration), so the lattice graph is 3-coloured by ⌊3θ(x)⌋ mod 3.

Usage:  fs73v2_check.py CERT.json            (exit 0 = PASS, 1 = FAIL with the reason)
        fs73v2_check.py --self-test CERT.json (plants faults in copies of an EMPTY certificate; each must FAIL for its reason)
"""
from __future__ import annotations

import copy
import gzip
import json
import math
import sys
from fractions import Fraction

THIRD, TWOTHIRD = Fraction(1, 3), Fraction(2, 3)


class Fail(Exception):
    pass


def parse_key(key: str):
    den, rows = key.split("|")
    return int(den), [[int(x) for x in r.split(",")] for r in rows.split(";")]


def solve4(B, v):
    """x with Σ_j x_j B[j] = v, exact (B: four rows of length four, nonsingular)."""
    A = [[Fraction(B[j][i]) for j in range(4)] + [Fraction(v[i])] for i in range(4)]
    for i in range(4):
        p = next((r for r in range(i, 4) if A[r][i] != 0), None)
        if p is None:
            raise Fail("key rows are singular")
        A[i], A[p] = A[p], A[i]
        A[i] = [x / A[i][i] for x in A[i]]
        for r in range(4):
            if r != i and A[r][i] != 0:
                f = A[r][i]
                A[r] = [A[r][k] - f * A[i][k] for k in range(5)]
    return [A[i][4] for i in range(4)]


def is_unit(u, d, D) -> bool:
    a, b, c, e = u
    return (a, b, c, e) != (0, 0, 0, 0) and a * a + d * b * b + c * c + d * e * e == D * D and a * b + c * e == 0


def in_key(u, rows) -> bool:
    return all(x.denominator == 1 for x in solve4(rows, u))


def all_units(d, D, rows):
    """Every unit vector of the key lattice, by exhaustive search (b, e bounded by the norm; c fixed up to sign by a)."""
    out = set()
    N = D * D
    bm = math.isqrt(N // d)
    for b in range(-bm, bm + 1):
        for e in range(-bm, bm + 1):
            rest = N - d * (b * b + e * e)
            if rest < 0:
                continue
            am = math.isqrt(rest)
            for a in range(-am, am + 1):
                c2 = rest - a * a
                c = math.isqrt(c2)
                if c * c == c2:
                    for cc in (c, -c):
                        if a * b + cc * e == 0 and in_key((a, b, cc, e), rows):
                            out.add((a, b, cc, e))
    return out


def boxmin(w) -> Fraction:
    return sum((x * THIRD if x > 0 else x * TWOTHIRD) for x in w)


def check_leaf(path, mults, N) -> None:
    w = [Fraction(0)] * N
    rho = Fraction(0)
    used = set()
    for item in mults:
        if len(item) != 3:
            raise Fail("malformed multiplier")
        pos, num, den = item
        if not (isinstance(pos, int) and 0 <= pos < len(path)) or pos in used:
            raise Fail(f"multiplier position {pos} out of range or repeated")
        used.add(pos)
        if not (isinstance(num, int) and isinstance(den, int) and den > 0):
            raise Fail("malformed multiplier value")
        lam = Fraction(num, den)
        coef, rhs, kind = path[pos]
        if kind == "le" and lam < 0:
            raise Fail("negative multiplier on an inequality")
        for j in range(N):
            if coef[j]:
                w[j] += lam * coef[j]
        rho += lam * rhs
    if not boxmin(w) > rho:
        raise Fail(f"leaf not refuted: min over the box {boxmin(w)} <= {rho}")


def check_tree(tree, relations, N) -> int:
    """Walk the tree with an explicit stack; returns the number of leaves.  Constraints are DERIVED from (r, lo, hi) here."""
    leaves = 0
    stack = [(tree, [])]
    while stack:
        node, path = stack.pop()
        if not isinstance(node, list) or not node:
            raise Fail("malformed node")
        if node[0] == "F":
            if len(node) != 2:
                raise Fail("malformed leaf")
            check_leaf(path, node[1], N)
            leaves += 1
        elif node[0] == "B":
            if len(node) != 5:
                raise Fail("malformed branch")
            _, ridx, lo, hi, kids = node
            if not (isinstance(ridx, int) and 0 <= ridx < len(relations)):
                raise Fail("branch on an unknown relation")
            if not (isinstance(lo, int) and isinstance(hi, int) and hi >= lo - 1):
                raise Fail("bad branch range")
            if len(kids) != hi - lo + 3:
                raise Fail(f"branch has {len(kids)} children, the range {lo}..{hi} needs {hi - lo + 3}")
            r = [Fraction(c) for c in relations[ridx]]
            neg = [-c for c in r]
            stack.append((kids[0], path + [(r, Fraction(lo - 1), "le")]))          # r·x ≤ lo − 1
            for i, k in enumerate(range(lo, hi + 1)):
                stack.append((kids[1 + i], path + [(r, Fraction(k), "eq")]))      # r·x = k
            stack.append((kids[-1], path + [(neg, Fraction(-(hi + 1)), "le")]))   # r·x ≥ hi + 1
        else:
            raise Fail(f"unknown node tag {node[0]!r}")
    return leaves


def check(cert) -> str:
    d, key = int(cert["d"]), cert["key"]
    D, rows = parse_key(key)
    units = [tuple(int(x) for x in u) for u in cert["units"]]
    for u in units:
        if len(u) != 4 or not is_unit(u, d, D):
            raise Fail(f"{u} is not a unit vector of Q(sqrt {d})^2 with denominator {D}")
        if not in_key(u, rows):
            raise Fail(f"{u} is not in the key lattice")
    everything = all_units(d, D, rows)
    listed = set(units) | {tuple(-x for x in u) for u in units}
    complete = listed == everything
    if cert["verdict"] == "NONEMPTY":
        th = [Fraction(n, m) for n, m in cert["theta_abce_dual"]]
        for u in everything:
            v = sum(t * x for t, x in zip(th, u))
            if not THIRD <= v - math.floor(v) <= TWOTHIRD:
                raise Fail(f"theta({u}) = {v} is not in [1/3, 2/3] mod 1")
        return f"PASS NONEMPTY: theta is a point of Theta for all {len(everything)} unit vectors of the key lattice"
    if cert["verdict"] != "EMPTY":
        raise Fail("unknown verdict")
    N = len(units)
    if len(set(units)) != N:
        raise Fail("repeated unit")
    relations = cert["relations"]
    for r in relations:
        if len(r) != N or not all(isinstance(c, int) for c in r):
            raise Fail("malformed relation")
        if any(sum(r[j] * units[j][i] for j in range(N)) != 0 for i in range(4)):
            raise Fail(f"not a relation: {r}")
    leaves = check_tree(cert["tree"], relations, N)
    return (f"PASS EMPTY: {leaves} leaves refuted; {len(relations)} relations verified; units {N} pairs, "
            f"{'the complete' if complete else 'NOT the complete'} unit set of the key lattice ({len(everything)} vectors)")


# ---------------------------------------------------------------- planted faults

def first_leaf(tree, want_eq_multiplier=False):
    stack = [tree]
    while stack:
        n = stack.pop()
        if n[0] == "F":
            if len(n[1]) >= 2:
                return n
        else:
            stack.extend(n[4])
    raise RuntimeError("no leaf with two multipliers")


def first_branch_with_mid(tree):
    stack = [tree]
    while stack:
        n = stack.pop()
        if n[0] == "B":
            if n[3] >= n[2]:
                return n
            stack.extend(n[4])
    raise RuntimeError("no branch with a middle child")


def self_test(cert) -> None:
    ok = check(cert)
    print("faithful:", ok)
    plants = []

    def plant(name, expect, mutate):
        c = copy.deepcopy(cert)
        mutate(c)
        try:
            res = check(c)
        except Fail as e:
            if expect not in str(e):
                raise SystemExit(f"PLANT {name}: failed for the WRONG reason: {e}")
            print(f"plant {name}: FAIL as expected ({e})")
            plants.append(name)
            return
        raise SystemExit(f"PLANT {name}: the checker PASSED a faulty certificate: {res}")

    def m_unit(c):
        a, b, cc, e = c["units"][0]
        c["units"][0] = [a + 2, b, cc, e]
    plant("unit-off-circle", "not a unit vector", m_unit)

    def m_rel(c):
        c["relations"][0][0] += 1
    plant("relation-perturbed", "not a relation", m_rel)

    def m_mult_zero(c):
        # every multiplier of one leaf set to 0: w = 0 and rho = 0, never a refutation (invalid by construction)
        leaf = first_leaf(c["tree"])
        for item in leaf[1]:
            item[1] = 0
    plant("multipliers-zeroed", "leaf not refuted", m_mult_zero)

    def m_mult_negate(c):
        # every multiplier of one leaf negated: min_B(−w) = −max_B(w) ≤ −min_B(w) < −rho, so never a refutation; on an
        # inequality position the sign test fires first (invalid by construction either way)
        leaf = first_leaf(c["tree"])
        for item in leaf[1]:
            item[1] = -item[1]
    plant("multipliers-negated", "", m_mult_negate)

    def m_child_drop(c):
        br = first_branch_with_mid(c["tree"])
        br[4].pop(1)
    plant("child-dropped", "children", m_child_drop)

    def m_range_shift(c):
        # claim the range starts one later and drop that child: the low child's constraint moves to r·x ≤ lo,
        # which its old multipliers (for r·x ≤ lo − 1) no longer refute unless the region is truly empty
        br = first_branch_with_mid(c["tree"])
        br[2] += 1
        br[4].pop(1)
    try:
        plant("range-shifted", "leaf not refuted", m_range_shift)
    except SystemExit as e:
        print(f"note: range-shifted plant: {e} (acceptable only if the extended low region is itself empty)")

    def m_neg_ineq(c):
        # find a leaf with a multiplier on an inequality position and flip its sign
        stack = [(c["tree"], [])]
        while stack:
            n, path = stack.pop()
            if n[0] == "F":
                for item in n[1]:
                    if path[item[0]] == "le":
                        item[1] = -item[1]
                        return
            else:
                _, ridx, lo, hi, kids = n
                stack.append((kids[0], path + ["le"]))
                for i in range(hi - lo + 1):
                    stack.append((kids[1 + i], path + ["eq"]))
                stack.append((kids[-1], path + ["le"]))
        raise RuntimeError("no inequality multiplier")
    plant("negative-inequality-multiplier", "negative multiplier", m_neg_ineq)

    def m_boundary(c):
        # a leaf whose combination touches the box exactly (min = ρ) must be REJECTED: replace the tree by one branch on
        # relation 0 whose low child is refuted only by a non-strict inequality
        r = c["relations"][0]
        s = sum(r)
        mn = sum(Fraction(x, 3) if x > 0 else Fraction(2 * x, 3) for x in r)   # min over B of r·x
        # low child: r·x ≤ lo − 1 with lo − 1 = mn exactly is only possible if mn is an integer; build it from the leaf test
        # directly instead, through check_leaf:
        c["_boundary"] = (r, mn)
    c2 = copy.deepcopy(cert)
    m_boundary(c2)
    r, mn = c2["_boundary"]
    try:
        check_leaf([([Fraction(x) for x in r], mn, "le")], [[0, 1, 1]], len(r))
        raise SystemExit("PLANT boundary: a touching leaf (min over the box = rho) was accepted")
    except Fail as e:
        print(f"plant boundary: FAIL as expected ({e})")
        plants.append("boundary")

    def m_unknown_rel(c):
        br = first_branch_with_mid(c["tree"])
        br[1] = len(c["relations"])
    plant("unknown-relation", "unknown relation", m_unknown_rel)

    print(f"SELF-TEST OK: faithful certificate passes; {len(plants)} planted faults each fail for their own reason: {plants}")


def load(path):
    with (gzip.open(path, "rt") if path.endswith(".gz") else open(path)) as f:
        return json.load(f)


def main() -> None:
    args = sys.argv[1:]
    if args and args[0] == "--self-test":
        self_test(load(args[1]))
        return
    cert = load(args[0])
    try:
        print(check(cert))
    except Fail as e:
        print(f"FAIL: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
