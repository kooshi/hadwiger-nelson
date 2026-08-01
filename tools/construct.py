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

from field import (DIM, PRIMES, add, const, distsq, is_unit, is_square, missing_root, neg,  # noqa: E402
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
    if n == 0:
        # `r² = 1/4`: the two points are half a unit apart, so the spindle is a half-turn — sin = 0,
        # cos = −1, and the image really does land a unit away. A valid move with a zero radical,
        # found by running a real search rather than by the self-test, which never generated it.
        return const(0)
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


# ------------------------------------------------------------------ the orbit move

class Motion:
    """A linear map of the plane with a common denominator: `(x,y) ↦ ((a·x + b·y)/D, (c·x + d·y)/D)`.

    Rotations about the origin and reflections in a line through it, which is every symmetry de
    Grey's step 2 uses. Translations are not here because the orbit move does not need them and an
    unused generality is an index somebody threads forever.
    """

    def __init__(self, a, b, c, d, D: int):
        self.m = (a, b, c, d)
        self.D = D
        self._reduce()

    def _reduce(self) -> None:
        """Lowest terms. Without this the group closure's denominators grow without bound and two
        equal motions compare unequal, so the closure never terminates."""
        g = self.D
        for v in self.m:
            for x in v:
                g = _gcd(g, abs(x))
        if g > 1:
            self.m = tuple(scal_div(v, g) for v in self.m)
            self.D //= g

    def key(self) -> tuple:
        return (tuple(tuple(v) for v in self.m), self.D)

    def __eq__(self, other) -> bool:
        return isinstance(other, Motion) and self.key() == other.key()

    def __hash__(self) -> int:
        return hash(self.key())

    def apply(self, p) -> tuple:
        a, b, c, d = self.m
        return (add(mul(a, p[0]), mul(b, p[1])), add(mul(c, p[0]), mul(d, p[1])))

    def then(self, other: "Motion") -> "Motion":
        """`self` followed by `other` — matrix product, denominators multiplied."""
        a, b, c, d = self.m
        e, f, g, h = other.m
        return Motion(add(mul(e, a), mul(f, c)), add(mul(e, b), mul(f, d)),
                      add(mul(g, a), mul(h, c)), add(mul(g, b), mul(h, d)), self.D * other.D)


def scal_div(v: list[int], g: int) -> list[int]:
    return [x // g for x in v]


def identity_motion() -> Motion:
    return Motion(const(1), const(0), const(0), const(1), 1)


def rotation(A: list[int], B: list[int], D: int) -> Motion:
    """Rotation by the angle with `cos = A/D`, `sin = B/D`."""
    return Motion(A, neg(B), B, A, D)


def reflection_x() -> Motion:
    """Reflection in the x-axis — de Grey's y-negation."""
    return Motion(const(1), const(0), const(0), const(-1), 1)


def hex12() -> list[Motion]:
    """**The order-12 hexagonal group**: six rotations by multiples of 60° and reflection in the
    x-axis. de Grey's step 2, and the group whose orbits collapse the search over pivots.

    Returned as the whole group rather than as generators, so a caller can see its size.
    """
    return motion_group([rotation(const(1), root(3), 2), reflection_x()])


def motion_group(gens: list[Motion], cap: int = 256) -> list[Motion]:
    """The finite group generated by `gens`, closed to a fixpoint.

    Closing to a fixpoint is what makes `orbit` an orbit: applying a non-closed *set* of motions
    would give a set that is not invariant, and a search that then assumed symmetry would be
    assuming something false. `cap` refuses an infinite group by name rather than hanging.
    """
    seen = {identity_motion()}
    frontier = list(seen)
    while frontier:
        nxt = []
        for m in frontier:
            for g in gens:
                c = m.then(g)
                if c not in seen:
                    if len(seen) >= cap:
                        raise ValueError(
                            f"the motions generate more than {cap} elements, so they are not a "
                            f"finite group this tool will close — check that each generator has "
                            f"finite order")
                    seen.add(c)
                    nxt.append(c)
        frontier = nxt
    return sorted(seen, key=lambda m: m.key())


def orbit(cfg: Config, group: list[Motion]) -> Config:
    """**The orbit move.** Close a configuration under a finite group of motions.

    The one primitive de Grey's construction needs that this tool lacked. His step 2 is exactly
    `orbit(S, hex12())`, and it is what turns a scattered seed set into something tight enough to
    force a colour.

    All images land at one denominator — the configuration's, times the product of what each group
    element needs — so the result is a `Config` like any other and composes with `spindle`.
    """
    D = 1
    for m in group:
        D = D * m.D // _gcd(D, m.D)
    pts = []
    for m in group:
        k = D // m.D
        for p in cfg.pts:
            q = m.apply(p)
            pts.append((scal(k, q[0]), scal(k, q[1])))
    return Config(pts, cfg.denom * D).dedup()


def delete(cfg: Config, idxs) -> Config:
    """**The deletion move.** Drop the listed points, keeping the rest in order.

    de Grey's step 4 removes two points. Measured at M13 subplanning, that deletion is *not* what
    makes his graph work — the set before it forces the same pair — so this is a size optimization
    there, and the shrinker's only move everywhere else.
    """
    drop = set(idxs)
    bad = [i for i in drop if not 0 <= i < len(cfg)]
    if bad:
        raise ValueError(f"cannot delete points {bad}: the configuration has {len(cfg)}")
    return Config([p for i, p in enumerate(cfg.pts) if i not in drop], cfg.denom)


def index_of(cfg: Config, x: Fraction, y: Fraction) -> int:
    """The index of a **rational** point of the configuration.

    How a caller names a pivot — `index_of(cfg, -2, 0)` rather than a magic number that silently
    means a different vertex after the previous move renumbered everything. Raises rather than
    returning `None`: a pivot that is not there is a bug in the construction, not a case to handle.
    """
    want = (tuple(_rat_vec(Fraction(x), cfg.denom)), tuple(_rat_vec(Fraction(y), cfg.denom)))
    for i, p in enumerate(cfg.pts):
        if (tuple(p[0]), tuple(p[1])) == want:
            return i
    raise ValueError(f"({x}, {y}) is not a point of this {len(cfg)}-point configuration")


def _rat_vec(x: Fraction, denom: int) -> list[int]:
    num = x * denom
    if num.denominator != 1:
        raise ValueError(f"{x} is not expressible at denominator {denom}")
    return const(int(num))


# ------------------------------------------------------------------ de Grey, from the primitives

def degrey_seed() -> Config:
    """de Grey's 39 hand-chosen seed points, read from `tools/degrey.py` rather than re-typed.

    Read rather than copied because two transcriptions of the same 39 points are two things that
    can disagree, and the one in `degrey.py` is the one the committed certificate was built from.
    """
    import degrey as D
    L = 1
    for pt in D.S:
        for comp in pt:
            for f in comp:
                L = L * f.denominator // _gcd(L, f.denominator)
    pts = [([int(f * L) for f in pt[0]], [int(f * L) for f in pt[1]]) for pt in D.S]
    return Config(pts, L)


def degrey_from_primitives() -> Config:
    """**de Grey's 1581-point graph, built from four primitive moves.**

        spindle( delete₂( spindle( orbit(S, hex₁₂), (0,0), (2,0) ) ), (−2,0), (2,0) )

    Measured at M13 subplanning and verified by exact equality of the point sets, which is why the
    committed coordinates are *derived* data rather than transcribed data. Two consequences worth
    knowing: his rotation by `2·arcsin(1/4)` is the spindle at `|pq| = 2` and his rotation by
    `π/2 ± arcsin(1/8)` is the spindle at `|pq| = 4`, so no "rotate about an arbitrary centre"
    primitive is needed; and √15 and √7 are in the field precisely because they are those two
    spindles' radicals.

    The result differs from the committed table by one global rotation, because de Grey turns *both*
    copies by ±a about the centre while the spindle move holds one copy still. `degrey_matches_committed`
    applies it and compares.
    """
    sa = orbit(degrey_seed(), hex12())
    sasb = spindle(sa, index_of(sa, 0, 0), index_of(sa, 2, 0))
    y = delete(sasb, [index_of(sasb, Fraction(1, 3), 0), index_of(sasb, Fraction(-1, 3), 0)])
    return spindle(y, index_of(y, -2, 0), index_of(y, 2, 0))


def degrey_matches_committed(
        path: Path = Path(__file__).resolve().parent / "degrey_cert.json") -> bool:
    """Is the primitive build the committed de Grey graph, point for point?

    Not "isomorphic to" and not "the same size" — **the same set of plane points**, exactly, in the
    exact field. The one global rotation relating the two conventions is applied first, and it is a
    rotation the field expresses (`cos = 1/8`, `sin = 3√7/8`, about `(−2,0)`).
    """
    g = degrey_from_primitives()
    turned = rotate_about(g, index_of(g, -2, 0), const(1), scal(3, root(7)), 8)
    d = json.load(open(path))
    want = {(tuple(Fraction(v, d["denom"]) for v in c[0]),
             tuple(Fraction(v, d["denom"]) for v in c[1])) for c in d["coords"]}
    got = {(tuple(Fraction(v, turned.denom) for v in p[0]),
            tuple(Fraction(v, turned.denom) for v in p[1])) for p in turned.pts}
    return got == want


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

    # the degenerate half-turn: r² = 1/4 has radicand 0, which is a square, so the move is legal and
    # must not divide by zero on the way to discovering that
    half = spindle_rotation(Fraction(1, 4))
    expect((half[0][0], half[1], half[2]), (-2, const(0), 2),
           "the r² = 1/4 spindle is a half-turn: cos = −1, sin = 0")
    expect(len(spindle(unit_triangle(), 0, 1)) > len(unit_triangle()), True,
           "and a spindle from the unit triangle really adds points")

    # and a move that stays in the field really does produce unit distances
    expect(all(is_unit(s.pts[a], s.pts[b], s.denom) for a, b in s.edges()), True,
           "every edge the spindle produced is exactly one unit, by integer identity")

    # --- the orbit move (M13) ---------------------------------------------------------------
    g = hex12()
    expect(len(g), 12, "the hexagonal group has twelve elements")
    ho = orbit(unit_edge(), g)
    expect((len(ho), len(ho.edges())), (7, 12),
           "orbiting a unit edge gives the hexagonal patch: a centre and six neighbours")

    # **the control for a closure that is not closed.** An orbit is only an orbit if applying the
    # group again adds nothing; a `motion_group` that stopped one step early would fail here and
    # nowhere else, and a search that then assumed symmetry would be assuming something false.
    def pointset(c):
        return {tuple(Fraction(x, c.denom) for x in a) + tuple(Fraction(y, c.denom) for y in b)
                for a, b in c.pts}
    expect(pointset(orbit(ho, g)) == pointset(ho), True,
           "the orbit is idempotent — applying the group again adds no point")

    # a generator of infinite order is refused by name rather than hanging
    try:
        motion_group([Motion(const(3), const(0), const(0), const(3), 1)])
        raise SystemExit("SELF-TEST FAILED — a scaling generates an infinite group; it should be refused")
    except ValueError as ex:
        expect("finite group" in str(ex), True, "a generator of infinite order is refused by name")

    # --- deletion (M13) ---------------------------------------------------------------------
    expect(len(delete(ho, [0, 1])), 5, "deleting two points leaves five")
    try:
        delete(ho, [99])
        raise SystemExit("SELF-TEST FAILED — deleting a point that is not there should be refused")
    except ValueError as ex:
        expect("has 7" in str(ex), True, "deleting an out-of-range point is refused by name")

    # a pivot named by coordinates rather than by a magic index, which the moves renumber
    expect(index_of(ho, 0, 0), 0, "the centre of the hexagonal patch is found by its coordinates")
    try:
        index_of(ho, 17, 0)
        raise SystemExit("SELF-TEST FAILED — a point that is not there should be refused")
    except ValueError as ex:
        expect("is not a point" in str(ex), True, "a pivot that is not there is refused by name")

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
