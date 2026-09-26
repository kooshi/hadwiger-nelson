#!/usr/bin/env python3
"""J52 (FS-75 planner): an existing Θ₃ certificate in the winding form, checked by an exact mirror of the Lean checker.

Input: a V2 relation-branching certificate (`tools/fs73v2_check.py`'s format; that tool is frozen and is not imported).
It is an EXACT TRANSFORMATION of an existing certificate, never a search: each leaf's rational multipliers num/den are
multiplied by the leaf's lcm of denominators L > 0, which multiplies the leaf's inequality `Σ λ·coef · x ≤ Σ λ·rhs` by L
and turns `min_B w·x > ρ` into the integer test `Σ_j min(Q_j, 2Q_j) > 3P` (Q = L·w, P = L·ρ).

The mirror implements exactly the semantics of `ThetaCert.Cert.check` in
`data/fs75/j52/skeleton/ThreeColourKernel.lean` (plan §S): children's constraints `(r, lo−1, ≤)`, `(r, k, =)` for k = lo..hi,
`(−r, −(hi+1), ≤)`; the path grows at its END (positions counted from the root, as in the JSON); a leaf needs every
position in range, a non-negative multiplier on every inequality, and `3P < Σ min(Q_j, 2Q_j)`; every relation must have
length ≤ the number of units and `Σ_j r_j u_j = 0`. Nothing here is trusted: the Lean checker re-checks the emitted literal.

Usage:
  j52_intcert.py CERT.json.gz                 check the integer form; print sizes
  j52_intcert.py --self-test CERT.json.gz     plant faults; each must be refused for its own reason
  j52_intcert.py --emit-lean OUT CERT.json.gz write the Lean literal `cert167` (units, relations, integer tree)
"""
from __future__ import annotations

import copy
import gzip
import json
import math
import sys


class Fail(Exception):
    pass


def load(path):
    with (gzip.open(path, "rt") if path.endswith(".gz") else open(path)) as f:
        return json.load(f)


def to_int_tree(node):
    """Scale each leaf's multipliers by the lcm of its denominators; positions and structure unchanged."""
    if node[0] == "F":
        L = 1
        for _, _, den in node[1]:
            if not (isinstance(den, int) and den > 0):
                raise Fail("malformed denominator")
            L = L * den // math.gcd(L, den)
        return ["F", [[pos, num * (L // den)] for pos, num, den in node[1]]]
    _, ridx, lo, hi, kids = node
    return ["B", ridx, lo, hi, [to_int_tree(k) for k in kids]]


def add_l(a, b):
    n = max(len(a), len(b))
    return [(a[i] if i < len(a) else 0) + (b[i] if i < len(b) else 0) for i in range(n)]


def box_min_l(q):
    return sum(min(x, 2 * x) for x in q)


def child_cons(r, lo, hi):
    cons = [(r, lo - 1, False)]
    cons += [(r, k, True) for k in range(lo, hi + 1)]
    cons.append(([-x for x in r], -(hi + 1), False))
    return cons


def leaf_ok(path, mults, why):
    for pos, lam in mults:
        if not (0 <= pos < len(path)):
            raise Fail(f"{why}: position {pos} out of range")
        if not path[pos][2] and lam < 0:
            raise Fail(f"{why}: negative multiplier on an inequality")
    Q, P = [], 0
    for pos, lam in mults:
        coef, rhs, _ = path[pos]
        Q = add_l([lam * x for x in coef], Q)
        P += lam * rhs
    if not 3 * P < box_min_l(Q):
        raise Fail(f"{why}: leaf not refuted: 3P = {3 * P} >= boxMin = {box_min_l(Q)}")


def check_tree(rels, tree):
    """Explicit stack; returns (leaves, multiplier entries, max depth). Mirrors checkTree/checkKids."""
    leaves = entries = depth = 0
    stack = [(tree, [])]
    while stack:
        node, path = stack.pop()
        depth = max(depth, len(path))
        if node[0] == "F":
            leaf_ok(path, node[1], f"leaf at depth {len(path)}")
            leaves += 1
            entries += len(node[1])
            continue
        _, ridx, lo, hi, kids = node
        if not (0 <= ridx < len(rels)):
            raise Fail("branch on an unknown relation")
        if not (lo - 1 <= hi):
            raise Fail("bad branch range")
        cons = child_cons(rels[ridx], lo, hi)
        if len(kids) != len(cons):
            raise Fail(f"branch has {len(kids)} children, the range {lo}..{hi} needs {len(cons)}")
        for k, con in zip(kids, cons):
            stack.append((k, path + [con]))
    return leaves, entries, depth


def check(cert):
    units, rels = cert["units"], cert["relations"]
    for u in units:  # first, as the Lean side's separate `cert167_units`: the unit test `Sqrt167.unitOk` (d = 167, D = 420)
        a, b, c, e = u
        if not (a * a + 167 * b * b + c * c + 167 * e * e == 420 * 420 and a * b + c * e == 0):
            raise Fail(f"not a unit vector: {u}")
    for r in rels:
        if len(r) > len(units):
            raise Fail("relation longer than the unit list")
        comb = [0] * max(len(u) for u in units)
        for k, u in zip(r, units):
            comb = add_l([k * x for x in u], comb)
        if any(comb):
            raise Fail(f"not a relation: {r}")
    return check_tree(rels, cert["itree"])


def prepare(cert):
    if cert.get("verdict") != "EMPTY" or cert.get("d") != 167:
        raise Fail("expected an EMPTY certificate over d = 167")
    cert = dict(cert)
    cert["itree"] = to_int_tree(cert["tree"])
    return cert


def first(tree, pred):
    stack = [tree]
    while stack:
        n = stack.pop()
        if pred(n):
            return n
        if n[0] == "B":
            stack.extend(reversed(n[4]))
    raise Fail("no node for the plant")


def self_test(cert):
    base = check(cert)

    def plant(name, expect, mutate):
        c = copy.deepcopy(cert)
        mutate(c)
        try:
            check(c)
        except Fail as e:
            if expect not in str(e):
                raise SystemExit(f"PLANT {name}: refused for the WRONG reason: {e}")
            print(f"  plant {name}: refused ({e})")
            return
        raise SystemExit(f"PLANT {name}: NOT refused")

    def neg_ineq(c):  # a leaf citing an inequality position gets a negative multiplier
        stack = [(c["itree"], [])]
        while stack:
            n, kinds = stack.pop()
            if n[0] == "F":
                for item in n[1]:
                    if not kinds[item[0]]:
                        item[1] = -abs(item[1]) - 1
                        return
                continue
            k = n[3] - n[2] + 1
            for i, kid in enumerate(n[4]):
                stack.append((kid, kinds + [0 < i <= k]))
        raise Fail("no inequality multiplier")

    def bad_rel(c):
        c["relations"] = copy.deepcopy(c["relations"])
        r = c["relations"][0]
        j = next(i for i, x in enumerate(r) if x)
        r[j] += 1

    def drop_child(c):
        first(c["itree"], lambda n: n[0] == "B")[4].pop()

    def shift_range(c):  # same child count, range moved by one: the children's constraints no longer match
        b = first(c["itree"], lambda n: n[0] == "B")
        b[2] += 1
        b[3] += 1

    def zero_leaf(c):  # one leaf's multipliers all zero: Q = 0, P = 0, and 3P < boxMin(Q) reads 0 < 0.
        # (The first version tripled one multiplier; that leaf still refuted, so the plant could not fire — G21.)
        f = first(c["itree"], lambda n: n[0] == "F")
        for item in f[1]:
            item[1] = 0

    def bad_unit(c):
        c["units"] = copy.deepcopy(c["units"])
        c["units"][0][0] += 1

    plant("negative multiplier on an inequality", "negative multiplier", neg_ineq)
    plant("non-relation", "not a relation", bad_rel)
    plant("dropped child", "children", drop_child)
    plant("shifted range", "not refuted", shift_range)
    plant("zeroed leaf", "not refuted", zero_leaf)
    plant("non-unit", "not a unit vector", bad_unit)
    # restore check: the unmutated certificate still passes with the same counts
    if check(cert) != base:
        raise SystemExit("RESTORE FAILED: the base certificate changed under the plants")
    print("  restore: base certificate re-checked, counts unchanged")


def lean_tree(n):
    if n[0] == "F":
        return ".leaf [" + ", ".join(f"({p}, {l})" for p, l in n[1]) + "]"
    arg = lambda z: f"({z})" if z < 0 else str(z)  # `.branch 0 -2 0` would parse as a subtraction
    return f".branch {n[1]} {arg(n[2])} {arg(n[3])} [" + ", ".join(lean_tree(k) for k in n[4]) + "]"


def emit_lean(cert, out):
    ints = lambda v: "[" + ", ".join(str(x) for x in v) + "]"
    with open(out, "w") as f:
        f.write("-- Emitted by tools/j52_intcert.py from data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz; untrusted data.\n")
        f.write("def cert167Data : ThetaCert.Cert where\n")
        f.write("  units := [" + ", ".join(ints(u) for u in cert["units"]) + "]\n")
        f.write("  rels := [" + ", ".join(ints(r) for r in cert["relations"]) + "]\n")
        f.write("  tree := " + lean_tree(cert["itree"]) + "\n")


def main():
    args = sys.argv[1:]
    try:
        if args and args[0] == "--self-test":
            cert = prepare(load(args[1]))
            leaves, entries, depth = check(cert)
            print(f"PASS base: {leaves} leaves, {entries} multiplier entries, depth {depth}")
            self_test(cert)
            print("SELF-TEST PASS")
        elif args and args[0] == "--emit-lean":
            cert = prepare(load(args[2]))
            check(cert)
            emit_lean(cert, args[1])
            print(f"emitted {args[1]}")
        else:
            cert = prepare(load(args[0]))
            leaves, entries, depth = check(cert)
            mx = max(abs(l) for n in [cert["itree"]] for l in _mults(n))
            print(f"PASS: {len(cert['units'])} units, {len(cert['relations'])} relations, {leaves} leaves, "
                  f"{entries} multiplier entries, depth {depth}, max |integer multiplier| {mx}")
    except Fail as e:
        print(f"FAIL: {e}")
        sys.exit(1)


def _mults(n):
    if n[0] == "F":
        yield from (l for _, l in n[1])
    else:
        for k in n[4]:
            yield from _mults(k)


if __name__ == "__main__":
    main()
