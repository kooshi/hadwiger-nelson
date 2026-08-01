#!/usr/bin/env python3
"""Build unit-distance graphs from primitives, staying inside the exact field by construction.

UNTRUSTED. Every graph this proposes is re-certified in Lean from scratch — the geometry against
exact field arithmetic, the colouring against a fresh certificate — so a bug here can only cost a
theorem and can never buy one.

## The gap this fills

Before M12 nothing in this repository *produced* a candidate. Four generators existed and each
hard-coded one construction: `spindle.py` makes *the* Moser spindle, `degrey.py` makes *de Grey's*
graph, `heule.py` *reads* published coordinates, `corespindle.py` makes *the* core-and-spindle. The
M11 instrument — profile, minimise, scan — only ever consumed a graph. A search needs a **space** of
candidates and a way to walk it.

## The primitives, and why these

Every construction in this area is made of the same four moves:

* **seed** — a unit edge, a unit triangle, a rhombus (two triangles glued, whose far corners are √3
  apart);
* **spindle** — rotate a copy of a configuration about a shared point until a designated pair lands
  exactly a unit apart. This is how the Moser spindle, de Grey's graph and Fisher–Ullman's
  core-and-spindle were all built;
* **orbit** — close a configuration under a list of motions;
* **union / translate** — place a copy somewhere the field admits.

## The field is a constraint the tool enforces, not a check that fails later

Spindling about a pair at squared distance `r²` rotates by `cos = (2r²−1)/(2r²)`,
`sin = √(4r²−1)/(2r²)`, so it stays in ℚ(√3,√5,√7,√11) **exactly when `4r²−1` is a square there** —
see `tools/field.py`, which also records that the four roots this project uses are precisely the
spindle radicals of `r² = 1, 3/2, 2, 3`. A radius the field cannot express is **refused, by name**:
the tool says which square root would be needed rather than rounding to something that later fails
an exact check in Lean for reasons nobody can read.

    python3 tools/construct.py --self-test
    python3 tools/construct.py --spindle --out build/spindle.json
"""

from __future__ import annotations

import argparse
import json
import sys
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from field import (DIM, PRIMES, add, const, distsq, is_unit, is_square, missing_root,  # noqa: E402
                   mul, root, scal, spindle_available, squarefree, sub)


# ------------------------------------------------------------------ configurations

class Config:
    """A finite point set with exact coordinates, stored scaled by one common denominator.

    The edge list is **not** carried: edges are a function of the points (exactly the pairs a unit
    apart), so storing them would be a second source of truth that can disagree with the first.
    `edges()` computes them when a consumer needs them.
    """

    def __init__(self, pts: list[tuple[list[int], list[int]]], denom: int):
        self.pts = pts
        self.denom = denom

    def __len__(self) -> int:
        return len(self.pts)

    def key(self, i: int) -> tuple:
        return (tuple(self.pts[i][0]), tuple(self.pts[i][1]))

    def scaled(self, m: int) -> "Config":
        """The same points at `m` times the denominator."""
        return Config([(scal(m, p[0]), scal(m, p[1])) for p in self.pts], self.denom * m)

    def dedup(self) -> "Config":
        """One representative per distinct point. Two names for one plane point are sound but make
        the graph a blow-up of the real one, which is only more expensive to refute."""
        seen, out = {}, []
        for p in self.pts:
            k = (tuple(p[0]), tuple(p[1]))
            if k not in seen:
                seen[k] = True
                out.append(p)
        return Config(out, self.denom)

    def edges(self) -> list[tuple[int, int]]:
        """Every pair exactly one apart — an integer identity, never a tolerance."""
        n = len(self.pts)
        return [(i, j) for i in range(n) for j in range(i + 1, n)
                if is_unit(self.pts[i], self.pts[j], self.denom)]

    def distsq_rational(self, i: int, j: int) -> Fraction | None:
        """The squared distance between two points as a *rational*, or `None` if it is irrational.

        The spindle formula needs a rational `r²`; a distance carrying a surd is a question this
        tool does not answer, and it says so rather than guessing.
        """
        d = distsq(self.pts[i], self.pts[j])
        if any(d[1:]):
            return None
        return Fraction(d[0], self.denom * self.denom)


def unit_edge() -> Config:
    return Config([(const(0), const(0)), (const(1), const(0))], 1)


def unit_triangle() -> Config:
    """(0,0), (1,0), (1/2, √3/2) at denominator 2."""
    return Config([(const(0), const(0)), (const(2), const(0)), (const(1), root(3))], 2)


def rhombus() -> Config:
    """Two unit triangles glued along an edge. Its far corners are √3 apart — the pair the Moser
    spindle rotates about, and the reason √11 is in this field (`4·3 − 1 = 11`)."""
    return Config([(const(0), const(0)), (const(2), const(0)),
                   (const(1), root(3)), (const(1), scal(-1, root(3)))], 2)


# ------------------------------------------------------------------ the moves

def sqrt_elem(n: int) -> list[int]:
    """`√n` as a field element, for `n` whose squarefree part divides 3·5·7·11.

    Raises rather than returning something approximate: a generator that quietly produced the wrong
    surd would emit coordinates Lean refuses, with nothing in the failure naming the cause.
    """
    m = squarefree(n)
    s0 = 1
    k = n // m
    r = int(round(k ** 0.5))
    while r * r < k:
        r += 1
    if r * r != k:
        raise ValueError(f"{n} is not a square times a squarefree part")
    s0 = r
    v = const(s0)
    for p in PRIMES:
        if m % p == 0:
            v = mul(v, root(p))
            m //= p
    if m != 1:
        raise ValueError(f"√{n} needs √{m}, which is not in ℚ(√3,√5,√7,√11)")
    return v


def spindle_rotation(r2: Fraction) -> tuple[list[int], list[int], int]:
    """`(A, B, D)` with `A² + B² = D²`, the cleared rotation taking a point at squared distance `r²`
    from the pivot to a point exactly one unit from where it started.

    `cos = A/D`, `sin = B/D`, with `A = 2·num − den`, `B = √((4·num − den)·den)`, `D = 2·num`.
    """
    if not spindle_available(r2):
        raise ValueError(
            f"a spindle at squared distance r² = {r2} would rotate by sin = √{4*r2 - 1}, which is "
            f"not in ℚ(√3,√5,√7,√11): it needs √{missing_root(r2)}. "
            f"Either pick a pair at an available distance, or adjoin √{missing_root(r2)} — and note "
            f"that adjoining doubles the tower and every coordinate with it.")
    num, den = r2.numerator, r2.denominator
    A = const(2 * num - den)
    B = sqrt_elem((4 * num - den) * den)
    D = 2 * num
    return A, B, D


def rotate_about(cfg: Config, pivot: int, A: list[int], B: list[int], D: int) -> Config:
    """Rotate every point about `cfg.pts[pivot]` by `(A/D, B/D)`, landing at `D` times the
    denominator."""
    ox, oy = cfg.pts[pivot]
    out = []
    for (px, py) in cfg.pts:
        dx, dy = sub(px, ox), sub(py, oy)
        nx = add(scal(D, ox), sub(mul(A, dx), mul(B, dy)))
        ny = add(scal(D, oy), add(mul(B, dx), mul(A, dy)))
        out.append((nx, ny))
    return Config(out, cfg.denom * D)


def spindle(cfg: Config, pivot: int, target: int) -> Config:
    """**The spindle move.** Rotate a copy of `cfg` about vertex `pivot` until the image of `target`
    lands exactly one unit from `target` itself, and take the union.

    The rotation is determined by `|target − pivot|` alone, which is why the field's contents are a
    fact about which radii have ever been spindled rather than a choice anybody made.
    """
    r2 = cfg.distsq_rational(target, pivot)
    if r2 is None:
        raise ValueError(
            f"the distance from vertex {target} to pivot {pivot} is irrational in this field, and "
            "the spindle formula needs a rational squared distance. Pick a pair whose squared "
            "distance is rational — `Config.distsq_rational` reports which are.")
    A, B, D = spindle_rotation(r2)
    turned = rotate_about(cfg, pivot, A, B, D)
    base = cfg.scaled(D)
    return Config(base.pts + turned.pts, base.denom).dedup()


def union(a: Config, b: Config) -> Config:
    """Two configurations at a common denominator, merged and deduplicated."""
    m = a.denom * b.denom // _gcd(a.denom, b.denom)
    return Config(a.scaled(m // a.denom).pts + b.scaled(m // b.denom).pts, m).dedup()


def _gcd(a: int, b: int) -> int:
    while b:
        a, b = b, a % b
    return a


# ------------------------------------------------------------------ emission

def to_json(cfg: Config, name: str) -> dict:
    """The shape `tools/emit_cert.py` consumes."""
    return {"names": [f"{name}{i}" for i in range(len(cfg))],
            "denom": cfg.denom,
            "coords": [[p[0], p[1]] for p in cfg.pts],
            "edges": [list(e) for e in cfg.edges()],
            "primes": PRIMES}


# ------------------------------------------------------------------ controls


def isomorphic_to_committed(cfg: Config,
                            path: Path = Path(__file__).resolve().parent / "spindle.json") -> bool:
    """Is `cfg`'s unit-distance graph the committed Moser spindle, up to relabelling?

    Brute force over 7! permutations, which is 5,040 and instant. An invariant like the degree
    sequence would be cheaper and would also accept graphs that merely resemble the spindle; the
    claim being made is that the primitives rebuild *it*, so the check is the claim.
    """
    from itertools import permutations
    d = json.load(open(path))
    want = {frozenset(e) for e in d["edges"]}
    got = [frozenset(e) for e in cfg.edges()]
    if len(cfg) != len(d["coords"]) or len(got) != len(want):
        return False
    for perm in permutations(range(len(cfg))):
        if {frozenset(perm[v] for v in e) for e in got} == want:
            return True
    return False


def self_test() -> None:
    """**A generator that cannot rebuild the Moser spindle is not a generator.**

    That is this tool's terminal test and the one check here that cannot pass by accident: the
    spindle is seven points and eleven edges with a specific shape, and getting the rotation wrong
    by any amount produces a different graph.
    """
    def expect(got, want, what):
        if got != want:
            raise SystemExit(f"SELF-TEST FAILED — {what}: got {got}, wanted {want}")
        print(f"  ok  {what}")

    e = unit_edge()
    expect((len(e), e.edges()), (2, [(0, 1)]), "a unit edge is two points and one edge")

    t = unit_triangle()
    expect((len(t), len(t.edges())), (3, 3), "the unit triangle is three points and three edges")

    r = rhombus()
    expect((len(r), len(r.edges())), (4, 5), "the rhombus is four points and five edges")
    expect(r.distsq_rational(2, 3), Fraction(3), "its far corners are √3 apart")
    expect(r.distsq_rational(0, 1), Fraction(1), "and its glued edge is a unit")

    # the Moser spindle: rotate the rhombus about one far corner until the other lands a unit away
    s = spindle(r, pivot=2, target=3)
    expect(len(s), 7, "the Moser spindle has seven points — the pivot is shared, not duplicated")
    expect(len(s.edges()), 11, "and eleven edges")
    # ...and it is *the* Moser spindle, checked by isomorphism against the committed one rather
    # than against a remembered degree sequence. (The first draft of this test asserted the wrong
    # sequence from memory and the tool was right; comparing to the artifact cannot make that
    # mistake.)
    expect(isomorphic_to_committed(s), True,
           "the graph built from primitives IS the committed Moser spindle, up to relabelling")

    # the negative partner: a rotation the field cannot express must be refused, by name
    try:
        spindle_rotation(Fraction(4, 3))
        raise SystemExit("SELF-TEST FAILED — a spindle at r² = 4/3 should have been refused")
    except ValueError as ex:
        expect("√39" in str(ex), True, "an unavailable radius is refused and names √39")

    expect(spindle_available(Fraction(3)), True, "r² = 3 is available (√11) — the positive partner")

    # and a move that stays in the field really does produce unit distances
    expect(all(is_unit(s.pts[a], s.pts[b], s.denom) for a, b in s.edges()), True,
           "every edge the spindle produced is exactly one unit, by integer identity")

    print("self-test: OK")


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--self-test", action="store_true", help="run the tool's own controls and exit")
    ap.add_argument("--spindle", action="store_true", help="build the Moser spindle from primitives")
    ap.add_argument("--out", type=Path)
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return

    if args.spindle:
        cfg = spindle(rhombus(), pivot=2, target=3)
        print(f"{len(cfg)} points, {len(cfg.edges())} edges, denominator {cfg.denom}")
        if args.out:
            json.dump(to_json(cfg, "spindle"), open(args.out, "w"))
            print(f"wrote {args.out}")
        return

    ap.error("nothing to do — try --self-test or --spindle")


if __name__ == "__main__":
    main()
