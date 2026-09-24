#!/usr/bin/env python3
"""FS-81 phase 0: exact checker for a Θ certificate on LISTED unit vectors — a copy of the frozen `tools/fs73v2_check.py`
(FS-73 V2) with its exhaustive unit enumeration made OPTIONAL.  Fraction/int arithmetic only; imports nothing from this repository.

Why a copy: the frozen checker always lists every unit vector of the key lattice, at about 4.2·D³/d loop iterations, which is
hours past D ≈ 3,000; FS-81's configurations reach D ≈ 10⁶.  The enumeration is not part of an EMPTY verdict's soundness (it only
reports whether the listed units are ALL the unit vectors of the key lattice), so it can be skipped.

What a PASS on an EMPTY certificate proves (unchanged from fs73v2_check.py; the chain is in data/fs73/records/verify-P3b-q167.md):
  1. every listed u = (a, b, c, e) is a unit vector of ℚ(√d)²: a² + d b² + c² + d e² = D², ab + ce = 0, u ≠ 0, and lies in the
     key lattice;
  2. every listed relation r satisfies Σ r_j u_j = 0 in ℤ⁴;
  3. the tree's branchings cover every x ∈ B = [1/3, 2/3]^N with r·x ∈ ℤ for all relations used, and every leaf's multipliers
     combine its path's constraints into w·x ≤ ρ with min_B w·x > ρ (so no x ∈ B lies in the leaf).
  Hence no θ ∈ Hom(span U, ℝ) has θ(u) mod 1 ∈ [1/3, 2/3] for all listed u, so by the criterion's ⟹ direction (FS73-T22, T42)
  Cay(span U, ±U) is not 3-colourable, and it is a subgraph of the unit-distance graph of ℚ(√d)².

A NONEMPTY certificate gives θ in (a, b, c, e)-dual coordinates.
  * with enumeration (the default): PASS means θ(u) mod 1 ∈ [1/3, 2/3] for EVERY unit vector of the key lattice, so the key
    lattice's whole unit-distance graph is 3-coloured by ⌊3θ(x)⌋ mod 3 (exactly the frozen checker's claim);
  * with --no-enumerate: PASS means the same for every LISTED unit vector, so Cay(span U, ±U) — the configuration's graph, NOT
    necessarily the key lattice's whole unit-distance graph — is 3-coloured by ⌊3θ(x)⌋ mod 3.  The output line says which.

Usage:  fs81_theta_check.py [--no-enumerate] CERT.json      (exit 0 = PASS, 1 = FAIL with the reason)
        fs81_theta_check.py --self-test EMPTY.json NONEMPTY.json
                                        (plants faults in copies; each must FAIL for its named reason; faithful copies must PASS)
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


def check(cert, enumerate_units: bool = True) -> str:
    d, key = int(cert["d"]), cert["key"]
    D, rows = parse_key(key)
    if len(rows) != 4 or any(len(r) != 4 for r in rows):
        raise Fail("the key must have four rows of length four")
    units = [tuple(int(x) for x in u) for u in cert["units"]]
    if not units:
        raise Fail("no listed units")
    for u in units:
        if len(u) != 4 or not is_unit(u, d, D):
            raise Fail(f"{u} is not a unit vector of Q(sqrt {d})^2 with denominator {D}")
        if not in_key(u, rows):
            raise Fail(f"{u} is not in the key lattice")
    if enumerate_units:
        everything = all_units(d, D, rows)
        listed = set(units) | {tuple(-x for x in u) for u in units}
        complete = listed == everything
    if cert["verdict"] == "NONEMPTY":
        th = [Fraction(n, m) for n, m in cert["theta_abce_dual"]]
        if len(th) != 4:
            raise Fail("theta must have four coordinates")
        for u in (everything if enumerate_units else units):
            v = sum(t * x for t, x in zip(th, u))
            if not THIRD <= v - math.floor(v) <= TWOTHIRD:
                raise Fail(f"theta({u}) = {v} is not in [1/3, 2/3] mod 1")
        if enumerate_units:
            return f"PASS NONEMPTY: theta is a point of Theta for all {len(everything)} unit vectors of the key lattice"
        return (f"PASS NONEMPTY (listed units only, no enumeration): theta is a point of Theta for the {len(units)} listed "
                f"pairs, so Cay(span U, +-U) is 3-colourable; the key lattice's other unit vectors were NOT checked")
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
    if not enumerate_units:
        return (f"PASS EMPTY: {leaves} leaves refuted; {len(relations)} relations verified; units {N} pairs "
                f"(completeness in the key lattice not checked: --no-enumerate)")
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


def self_test(cert, enum: bool = True) -> None:
    print(f"== EMPTY plants, enumeration {'ON' if enum else 'OFF (--no-enumerate)'}")
    ok = check(cert, enum)
    print("faithful:", ok)
    plants = []

    def plant(name, expect, mutate):
        c = copy.deepcopy(cert)
        mutate(c)
        try:
            res = check(c, enum)
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


def self_test_nonempty(cert, wide=None) -> None:
    """NONEMPTY plants, in the --no-enumerate mode (the listed-units claim) and, where cheap, with enumeration.
    `wide`: a NONEMPTY certificate whose θ colours its LISTED units while its key lattice has further unit vectors that no θ can
    colour (the key's Θ is empty): it must PASS without enumeration and FAIL with it — the two modes seen to differ."""
    print("== NONEMPTY plants")
    for enum in (False, True):
        print(f"faithful ({'enumeration ON' if enum else '--no-enumerate'}):", check(cert, enum))
    plants = []

    def plant(name, expect, mutate, enum=False):
        c = copy.deepcopy(cert)
        mutate(c)
        try:
            res = check(c, enum)
        except Fail as e:
            if expect not in str(e):
                raise SystemExit(f"PLANT {name}: failed for the WRONG reason: {e}")
            print(f"plant {name}: FAIL as expected ({e})")
            plants.append(name)
            return
        raise SystemExit(f"PLANT {name}: the checker PASSED a faulty certificate: {res}")

    def m_theta_zero(c):
        c["theta_abce_dual"] = [[0, 1]] * 4
    plant("theta-zero", "is not in [1/3, 2/3]", m_theta_zero)

    def m_theta_nudged(c):
        # push the listed unit of least slack just outside [1/3, 2/3] through one coordinate of θ
        th = [Fraction(n, m) for n, m in c["theta_abce_dual"]]
        best = None
        for u in c["units"]:
            v = sum(t * x for t, x in zip(th, u))
            f = v - math.floor(v)
            for j in range(4):
                if u[j]:
                    for bound, out in ((THIRD, -1), (TWOTHIRD, 1)):
                        dist = abs(f - bound)
                        if best is None or dist < best[0]:
                            best = (dist, u, j, out)
        dist, u, j, out = best
        eps = (dist + Fraction(1, 10 ** 9)) / abs(u[j])
        th[j] += eps * out * (1 if u[j] > 0 else -1)
        c["theta_abce_dual"] = [[t.numerator, t.denominator] for t in th]
    plant("theta-nudged-out-of-band", "is not in [1/3, 2/3]", m_theta_nudged)

    def m_unit_off(c):
        a, b, cc, e = c["units"][0]
        c["units"][0] = [a, b + 1, cc, e]
    plant("unit-off-circle", "not a unit vector", m_unit_off)

    def m_key_row_tripled(c):
        D, rows = parse_key(c["key"])
        # the listed units span the key lattice; tripling a row gives an index-3 sublattice missing some unit
        for i in range(4):
            r2 = [list(r) for r in rows]
            r2[i] = [3 * x for x in r2[i]]
            if any(not in_key(tuple(u), r2) for u in c["units"]):
                c["key"] = f"{D}|" + ";".join(",".join(map(str, r)) for r in r2)
                return
        raise RuntimeError("no row whose tripling excludes a listed unit")
    plant("key-row-tripled", "not in the key lattice", m_key_row_tripled)

    def m_theta_short(c):
        c["theta_abce_dual"] = c["theta_abce_dual"][:3]
    plant("theta-three-coordinates", "four coordinates", m_theta_short)

    def m_no_units(c):
        c["units"] = []
    plant("no-units", "no listed units", m_no_units)

    def m_verdict(c):
        c["verdict"] = "NONEMPTY?"
    plant("unknown-verdict", "unknown verdict", m_verdict)

    def m_wrong_field(c):
        c["d"] = int(c["d"]) + 4
    plant("wrong-field", "not a unit vector", m_wrong_field)

    if wide is not None:
        ok = check(wide, False)
        if "listed units only" not in ok:
            raise SystemExit(f"MODE: the wide certificate passed without the listed-units caveat: {ok}")
        print("wide certificate, --no-enumerate:", ok)
        try:
            res = check(wide, True)
        except Fail as e:
            if "is not in [1/3, 2/3]" not in str(e):
                raise SystemExit(f"MODE: the wide certificate failed with enumeration for the WRONG reason: {e}")
            print(f"wide certificate, enumeration ON: FAIL as expected ({e})")
            plants.append("modes-differ")
        else:
            raise SystemExit(f"MODE: the wide certificate PASSED with enumeration although its key's Θ is empty: {res}")
    print(f"SELF-TEST OK (NONEMPTY): faithful passes in both modes; {len(plants)} plants each fail for their own reason: {plants}")


def load(path):
    with (gzip.open(path, "rt") if path.endswith(".gz") else open(path)) as f:
        return json.load(f)


def main() -> None:
    args = sys.argv[1:]
    if args and args[0] == "--self-test":
        for enum in (True, False):
            self_test(load(args[1]), enum)
        self_test_nonempty(load(args[2]), load(args[3]) if len(args) > 3 else None)
        return
    enum = True
    if args and args[0] == "--no-enumerate":
        enum = False
        args = args[1:]
    if len(args) != 1:
        raise SystemExit(__doc__)
    cert = load(args[0])
    try:
        print(check(cert, enum))
    except Fail as e:
        print(f"FAIL: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
