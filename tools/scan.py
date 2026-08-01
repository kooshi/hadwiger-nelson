#!/usr/bin/env python3
"""Find the plane isometries that map a point set into itself — **exactly**, and hand back the motion.

UNTRUSTED. What this tool finds is a *claim*: "these 791 points are these 791 points, moved". Lean
re-derives it — `Instances/DeGrey/Rotation.lean` decides 791 coordinate identities in
`ℚ(√3,√5,√7,√11)` — so a bug here costs a theorem and cannot buy one.

## What it is for

A construction leaves fingerprints. de Grey's 1581-point graph is two copies of a 791-point set, one
rotated onto the other; his paper says so, and M09 spent a session deriving the rotation by hand from
the paper. **This finds it from the coordinates alone**, and hands back exactly the eight field
values `Proofs/HadwigerNelson/Motion.lean`'s `Motion` wants — so the next copy costs one lemma
instead of one session.

That matters beyond archaeology. A gadget search proposes a placement; a placement *is* a motion; and
the motions worth trying are the ones a candidate's own geometry already exhibits.

## How, and why it is exact

A plane isometry is determined by where it sends two distinct points. Take a reference unit pair
`(p₀, p₁)` and, for every other unit pair `(q₀, q₁)` in the set and both orientations, there is
exactly one isometry with `p₀ ↦ q₀` and `p₁ ↦ q₁`. Apply it to every point and count how many land
back in the set.

No floating point anywhere. Coordinates are integer vectors over the basis of square roots the graph
lives in, cleared by a common denominator, so "lands on a point of the set" is an **integer
identity** and the answer is a fact rather than a tolerance. The motion is produced already cleared:
with `u = p₁ − p₀` and `v = q₁ − q₀` at denominator `d`,

    rotation:    a = u·v,        b = u × v,     A = [[a, −b], [b, a]]
    reflection:  a = ū·v,        b = ū × v,     A = [[a,  b], [b, −a]]
    scale = d⁴,  M = d²,         t = M·q₀ − A·p₀

and `a² + b² = |u|²·|v|² = d⁴`, which is `Motion`'s `col₁` on the nose.

    python3 tools/scan.py --graph tools/degrey_cert.json --lean --out found.json
    python3 tools/scan.py --graph tools/heule510.json --top 3
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

# Exact arithmetic in ℚ(√p₀, √p₁, √p₂, √p₃) lives in `tools/field.py` — one implementation, five
# importers. It used to live here too, and in `degrey.py`, `corespindle.py`, `heule.py` and
# `spindle.py`: five copies of one multiplication table, which is a role nobody had named. M12 named
# it, and this file now borrows rather than repeats.

from field import (DIM, add, const, is_zero, mul, mul_table, neg, render, scal, sub)  # noqa: E402,F401

# ---------------------------------------------------------------------------------------------


def load(path: Path) -> tuple[list[tuple[list[int], list[int]]], int, list[int],
                              list[tuple[int, int]]]:
    """`(points, denom, primes, edges)` from one of this repository's geometry JSONs."""
    d = json.load(open(path))
    pts = [(list(map(int, p[0])), list(map(int, p[1]))) for p in d["coords"]]
    return pts, int(d["denom"]), list(map(int, d["primes"])), \
        [(int(a), int(b)) for a, b in d["edges"]]


def motion_from_pairs(p0, p1, q0, q1, denom: int, flip: bool, tab):
    """The unique isometry carrying `p₀ ↦ q₀` and `p₁ ↦ q₁`, cleared of denominators.

    Returns `(a, b, c, d, e, f, M, scale)` — `Motion`'s eight fields — or `None` when the two source
    points are not the reference distance apart, which cannot happen for a listed edge.
    """
    ux, uy = sub(p1[0], p0[0]), sub(p1[1], p0[1])
    vx, vy = sub(q1[0], q0[0]), sub(q1[1], q0[1])
    if flip:
        uy = neg(uy)
    a = add(mul(ux, vx, tab), mul(uy, vy, tab))
    b = sub(mul(ux, vy, tab), mul(uy, vx, tab))
    if flip:
        c, dd = b, neg(a)
    else:
        c, dd = neg(b), a
    M = const(denom * denom)
    # `t = M·q₀ − A·p₀`, which is what makes `p₀` land on `q₀`.
    e = sub(mul(M, q0[0], tab), add(mul(a, p0[0], tab), mul(c, p0[1], tab)))
    f = sub(mul(M, q0[1], tab), add(mul(b, p0[0], tab), mul(dd, p0[1], tab)))
    return a, b, c, dd, e, f, M, denom ** 4


def image_map(pts, mot, index, tab, sample: list[int], allow: int) -> list[int] | None:
    """Where each point goes: the index of its image, or `-1` if the image is outside the set.

    **This is the tool's real output.** `Gadget.transport` and `UDCert.validOn_map_of_motion` both
    consume a vertex map, so a scanner that reported only "791 points land back" would have found the
    fact and withheld the thing the next step takes — the round-trip law, broken by one line.

    Aborts as soon as the sample has missed too often, which is what makes 31,508 candidates
    affordable.
    """
    a, b, c, dd, e, f, M, _ = mot
    missed = 0
    for i in sample:
        px, py = pts[i]
        gx = add(add(mul(a, px, tab), mul(c, py, tab)), e)
        gy = add(add(mul(b, px, tab), mul(dd, py, tab)), f)
        if (tuple(gx), tuple(gy)) not in index:
            missed += 1
            if missed > allow:
                return None
    out = []
    for px, py in pts:
        gx = add(add(mul(a, px, tab), mul(c, py, tab)), e)
        gy = add(add(mul(b, px, tab), mul(dd, py, tab)), f)
        out.append(index.get((tuple(gx), tuple(gy)), -1))
    return out


def self_test(repo: Path) -> None:
    """The tool's own controls, in both directions.

    A scanner that reported the identity as its answer would look successful on every input, and a
    scanner that found nothing would look the same as a graph with no symmetry. So:

      * the **Moser spindle** has a mirror symmetry covering all seven points, with a stated vertex
        map — and that map is a genuine permutation, not the identity;
      * **de Grey's 1581 points** split into 791 and 791, which is his construction, recovered from
        the coordinates and not from his paper.
    """
    def expect(got, want, what):
        if got != want:
            raise SystemExit(f"SELF-TEST FAILED — {what}: got {got}, wanted {want}")
        print(f"  ok  {what}")

    for name, expected in (("spindle.json", (7, [0, 5, 4, 6, 2, 1, 3])),
                           ("degrey_cert.json", (791, None))):
        pts, denom, primes, edges = load(repo / "tools" / name)
        tab = mul_table(primes)
        n = len(pts)
        Msc = denom * denom
        index = {(tuple(scal(Msc, x)), tuple(scal(Msc, y))): i for i, (x, y) in enumerate(pts)}
        sample = list(range(0, n, max(1, n // 10)))[:10]
        p0i, p1i = edges[0]
        best = []
        for (q0i, q1i) in edges:
            for (u, v) in ((q0i, q1i), (q1i, q0i)):
                for flip in (False, True):
                    mot = motion_from_pairs(pts[p0i], pts[p1i], pts[u], pts[v], denom, flip, tab)
                    phi = image_map(pts, mot, index, tab, sample, 4)
                    if phi is None:
                        continue
                    hits = sum(1 for j in phi if j >= 0)
                    if hits and phi != list(range(n)):
                        best.append((hits, phi))
        best.sort(key=lambda r: -r[0])
        if not best:
            raise SystemExit(f"SELF-TEST FAILED — {name}: no non-identity isometry found at all")
        hits, phi = best[0]
        want_hits, want_map = expected
        expect(hits, want_hits, f"{name}: best non-identity isometry covers {want_hits}")
        if want_map is not None:
            expect(phi, want_map, f"{name}: and its vertex map is the mirror")
    print("self-test: OK")


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--graph", type=Path)
    ap.add_argument("--ref", type=int, default=0, help="index of the reference edge")
    ap.add_argument("--sample", type=int, default=10)
    ap.add_argument("--allow", type=int, default=4,
                    help="misses tolerated in the sample before a candidate is abandoned")
    ap.add_argument("--top", type=int, default=5)
    ap.add_argument("--lean", action="store_true", help="print the winner as a `Motion` literal")
    ap.add_argument("--out", type=Path, help="write every isometry found, with its vertex map")
    ap.add_argument("--self-test", action="store_true", help="run the tool's own controls and exit")
    args = ap.parse_args()

    if args.self_test:
        self_test(Path(__file__).resolve().parent.parent)
        return

    if args.graph is None:
        ap.error("--graph is required unless --self-test")
    pts, denom, primes, edges = load(args.graph)
    tab = mul_table(primes)
    n = len(pts)
    # A point of the image sits at denominator `d·M`, so the set it must land in is the original
    # scaled by `M` — one multiplication per point, done once.
    Msc = denom * denom
    index = {(tuple(scal(Msc, x)), tuple(scal(Msc, y))): i for i, (x, y) in enumerate(pts)}
    sample = list(range(0, n, max(1, n // args.sample)))[:args.sample]

    p0i, p1i = edges[args.ref]
    p0, p1 = pts[p0i], pts[p1i]
    best: list[tuple[int, tuple, str, list[int]]] = []
    for (q0i, q1i) in edges:
        for (s, t) in ((q0i, q1i), (q1i, q0i)):
            for flip in (False, True):
                mot = motion_from_pairs(p0, p1, pts[s], pts[t], denom, flip, tab)
                phi = image_map(pts, mot, index, tab, sample, args.allow)
                if phi is None:
                    continue
                hits = sum(1 for j in phi if j >= 0)
                if hits > 0:
                    best.append((hits, mot, f"{'reflect' if flip else 'rotate'} "
                                            f"({p0i},{p1i}) → ({s},{t})", phi))
    best.sort(key=lambda r: -r[0])

    print(f"graph      {args.graph.name}: {n} points, {len(edges)} edges, denominator {denom}")
    print(f"reference  edge {args.ref} = ({p0i}, {p1i})")
    print(f"found      {len(best)} isometries mapping part of the set into itself")
    seen = set()
    shown = 0
    for hits, mot, how, phi in best:
        key = tuple(tuple(x) for x in mot[:6])
        if key in seen:
            continue
        seen.add(key)
        ident = all(is_zero(sub(mot[i], const(0))) for i in (1, 4, 5)) and \
            not is_zero(mot[0])
        print(f"  {hits:5d} / {n}  ({100 * hits // n:3d}%)  {how}"
              f"{'   [the identity]' if ident and hits == n else ''}")
        shown += 1
        if shown >= args.top:
            break

    if args.lean and best:
        # The best motion that is not the identity — the identity always covers everything and says
        # nothing, so reporting it as the answer would be the tool failing open.
        for hits, mot, how, phi in best:
            if hits < n:
                a, b, c, dd, e, f, M, scale = mot
                print(f"\n-- {how}: {hits} of {n} points\ndef scanned : Motion where")
                for name, val in (("a", a), ("b", b), ("c", c), ("d", dd),
                                  ("e", e), ("f", f), ("M", M)):
                    print(f"  {name} := {render(val, primes)}")
                print(f"  scale := {scale}\n  scale_ne := by decide\n  sq := by decide +kernel\n"
                      f"  col₁ := by decide +kernel\n  col₂ := by decide +kernel\n"
                      f"  orth := by decide +kernel")
                break
        else:
            print("\n-- no non-trivial isometry found: every hit was the identity")

    if args.out:
        _emit(best, n, args.out)
        print(f"\nwrote      {args.out}: {len(best)} isometries, each with its vertex map")


def _emit(best, n, out: Path) -> None:
    json.dump({"n": n, "isometries": [
        {"covers": hits, "how": how, "map": phi,
         "motion": {k: v for k, v in zip("abcdefM", (list(x) for x in mot[:7]))}
         | {"scale": mot[7]}}
        for hits, mot, how, phi in best]}, open(out, "w"))


if __name__ == "__main__":
    main()
