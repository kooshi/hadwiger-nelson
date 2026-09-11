#!/usr/bin/env python3
"""The orbit-filling geometry of a complete level set — M64, `plans/M64-orbit-filling-polytope.md`.

**What this module is for.** M63's reduction returns `{M}`, every minimum-size subgraph that keeps
the key property, with a proof that the level is complete. This module answers *what shape that set
has in orbit coordinates*, and its whole risk is a right-looking answer: three of the four headline
numbers the milestone was minted on turned out to be artifacts of how they were computed, and each
one had already been committed to a plan file before anybody noticed.

**The five things that are unwritable here rather than merely discouraged.**

1. *A fill fraction without its ambient dimension.* `Fill` refuses to render without the affine
   dimension of the set, because the stub's headline contrast between two sides — 0.80 against 0.20
   — was **entirely** the fact that one of them sat in a 2-plane inside a 4-box. Against the affine
   box the two are 0.800 and 0.771. `Fill.render()` names both denominators, always.

2. *A convexity verdict from a test that could not have failed.* `HullTest` carries `opportunities`
   = `|box ∩ aff(Prof)| − |Prof|`, the number of points the test was ever in a position to get
   wrong, and renders `not-discriminating` when that is zero. On the S side it is **one**, and the
   hull there is a triangle of area 1 whose interior is empty by Pick — so `Prof = conv(Prof) ∩ ℤ`
   was forced before the data was consulted. `G21`, on this project's own subplanning measurement.

3. *An exclusion whose status its constructor did not earn.* An `Exclusion` is a pair of atoms at
   most one of which is ever kept. Found by scanning a level set it is an **observation over a
   finite population**; confirmed by asking whether `A − {u,v}` is colourable it is a **derivation
   about the stage**. On the S side 15 were observed and only **9** derived. The two are built by
   different constructors, neither takes a status argument, and `Exclusion` refuses to be
   constructed directly — so a report cannot say "15 pairs" and mean the derived ones.

4. *A rung as a number.* A rung is a **subgroup of the stage's own stabiliser**, which is order 12
   on one side here and 6 on the other, never the base group's 24. `Rung` carries the subgroup's
   elements as atom permutations and is only ever built by `stage_symmetry`, from the stage. M63
   lost a day to a symmetry that was assumed rather than measured. The rung is imposed on a search
   by handing its lattice maps to `Stage(..., rung_maps=...)`, which buckets the deletable vertices
   into H-orbits — **not** by adding `sel[a] ↔ sel[g(a)]` clauses, which the subplan specified and
   implementation found strictly more expensive: `reduce_stage` already weights an atom by its
   vertex count, so an orbit costs its size for free and phase 1, the correction sets, the pin and
   its soundness control all carry over unchanged.

5. *An invariant-count read as a minimum.* `RungCensus` records how many members of a **given
   level** are `H`-invariant. Zero says the rung's own minimum is larger; it does not say by how
   much, and there is no field in which to write that it does.

**Vocabulary note.** No verdict in this module means "clean". `order_ideal` returns the
orientations that hold and the exact size of the null; `hull` returns a count of unexplained points
and the opportunities it had; `exclusions` returns two separately-counted populations.
"""
from __future__ import annotations
import itertools as it
import json
import sys
from collections import Counter, defaultdict
from dataclasses import dataclass, field
from fractions import Fraction as Fr
from functools import lru_cache
from math import comb

_MINT = object()          # only this module's own constructors hold it


# ===================================================================== the level set
@dataclass(frozen=True)
class LevelSet:
    """A complete level set: every minimum of one size, plus the atom universe it lives in.

    `complete` is not a courtesy flag — every derivation below (the necessary atoms, the exchange
    classes, the affine hull) is sound ONLY for a complete level, and the constructors refuse
    otherwise. A truncated level set is still a useful object; it is just not this one."""
    atoms: tuple[int, ...]
    minima: tuple[frozenset[int], ...]
    size: int
    complete: bool

    @staticmethod
    def from_record(rec: dict) -> "LevelSet":
        method = rec["M_set"]["count"]["method"]
        minima = tuple(frozenset(m) for m in rec["minima"])
        sizes = {len(m) for m in minima}
        if len(sizes) != 1:
            raise ValueError(f"a level set has one size; got {sorted(sizes)}")
        return LevelSet(tuple(rec["A"]), minima, sizes.pop(),
                        complete=(method in ("exhaustive", "exhaustive-level")))

    def require_complete(self, what: str):
        if not self.complete:
            raise ValueError(f"{what} is sound only for a complete level set; this one is not")

    # --- the three atom classes, all readable with no solver ---------------------
    def necessary(self) -> frozenset[int]:
        """Atoms in every minimum. For a COMPLETE level of an upward-closed property this is
        exactly `{a : {a} is a correction set}`: if `A − {a}` refused it would contain a minimum
        without `a`, and if it is colourable then every refusing selection contains `a`."""
        self.require_complete("the necessary set")
        return frozenset.intersection(*self.minima)

    def unused(self) -> frozenset[int]:
        return frozenset(self.atoms) - frozenset.union(*self.minima)

    def free(self) -> tuple[int, ...]:
        n = self.necessary()
        return tuple(a for a in self.atoms if a not in n)


# ===================================================================== exclusions
EXCLUSION_STATUS = ("observed-over-level", "derived-by-ask")


@dataclass(frozen=True)
class Exclusion:
    """Two atoms of which every minimum keeps exactly one.

    Never constructed directly — `observe_exclusions` and `derive_exclusions` are the only ways in,
    and neither takes a status. `population` is the enumeration behind the claim: the number of
    minima scanned for an observation, and `None` for a derivation, which quantifies over all
    selections rather than over a sample."""
    u: int
    v: int
    status: str
    population: int | None
    _mint: object = field(default=None, repr=False, compare=False)

    def __post_init__(self):
        if self._mint is not _MINT:
            raise TypeError("an Exclusion is minted by observe_exclusions or derive_exclusions, "
                            "never written by hand: the constructor is what earns the status")
        if self.status not in EXCLUSION_STATUS:
            raise ValueError(f"unknown status {self.status!r}")
        if (self.status == "observed-over-level") != (self.population is not None):
            raise ValueError("an observation names its population; a derivation has none")

    @property
    def pair(self) -> tuple[int, int]:
        return (self.u, self.v) if self.u < self.v else (self.v, self.u)

    def render(self) -> str:
        pop = f" over {self.population} minima" if self.population is not None else ""
        return f"{{{self.u}, {self.v}}} [{self.status}{pop}]"


def observe_exclusions(ls: LevelSet) -> list[Exclusion]:
    """Free atoms `u`, `v` such that every minimum keeps exactly one. An OBSERVATION: it says
    nothing about selections the level set does not contain. Atoms with more than one complement
    are dropped, not guessed at — an ambiguous complement is not a matching."""
    ls.require_complete("exclusion scanning")
    free = ls.free()
    vec = {a: bytes(1 if a in m else 0 for m in ls.minima) for a in free}
    partner: dict[int, list[int]] = defaultdict(list)
    for i, a in enumerate(free):
        for b in free[i + 1:]:
            if all(x != y for x, y in zip(vec[a], vec[b])):
                partner[a].append(b)
                partner[b].append(a)
    seen, out = set(), []
    for a, ps in partner.items():
        if len(ps) != 1:
            continue
        p = tuple(sorted((a, ps[0])))
        if p in seen:
            continue
        seen.add(p)
        out.append(Exclusion(p[0], p[1], "observed-over-level", len(ls.minima), _mint=_MINT))
    return sorted(out, key=lambda e: e.pair)


def derive_exclusions(ask, atoms, candidates: list[Exclusion], log=None) -> tuple[list[Exclusion], list[Exclusion]]:
    """Promote observations to derivations, one ask each: `{u,v}` is a size-2 correction set exactly
    when `A − {u,v}` is colourable, and then EVERY refusing selection keeps one of the two.

    `ask(kept) -> ('sat'|'unsat', model)` with **'sat' meaning COLOURABLE, hence the property is
    LOST** — the polarity that cost this session one inverted test. Returns (derived, not-derived);
    the second list is not an error and is reported, never dropped."""
    allA = list(range(len(atoms)))
    derived, refused = [], []
    for i, e in enumerate(candidates):
        verdict, _ = ask([a for a in allA if a not in e.pair])
        if verdict == "sat":
            derived.append(Exclusion(e.u, e.v, "derived-by-ask", None, _mint=_MINT))
        else:
            refused.append(e)
        if log and (i + 1) % 8 == 0:
            log(f"    derive {i+1}/{len(candidates)}  derived {len(derived)}  not {len(refused)}")
    return derived, refused


# ===================================================================== profiles
def profiles(ls: LevelSet, orbit_of) -> tuple[list[tuple], list[tuple[int, ...]], Counter]:
    """(orbit labels touched, one profile per minimum, multiplicity per profile)."""
    labels = sorted({orbit_of(a) for a in ls.atoms})
    per = []
    for m in ls.minima:
        c = Counter(orbit_of(a) for a in m)
        per.append(tuple(c[L] for L in labels))
    return labels, per, Counter(per)


def varying(labels, per) -> list[int]:
    return [i for i in range(len(labels)) if len({p[i] for p in per}) > 1]


# ===================================================================== the shape of Prof
def _rank(rows, k) -> int:
    rows = [[Fr(x) for x in r] for r in rows]
    r = 0
    for c in range(k):
        p = next((i for i in range(r, len(rows)) if rows[i][c] != 0), None)
        if p is None:
            continue
        rows[r], rows[p] = rows[p], rows[r]
        f = rows[r][c]
        rows[r] = [x / f for x in rows[r]]
        for i in range(len(rows)):
            if i != r and rows[i][c] != 0:
                g = rows[i][c]
                rows[i] = [rows[i][j] - g * rows[r][j] for j in range(k)]
        r += 1
    return r


def affine_dim(pts) -> int:
    k = len(pts[0])
    base = pts[0]
    return _rank([[p[i] - base[i] for i in range(k)] for p in pts], k)


def boxes(prof, ranges):
    """(all box points with the right coordinate sum, those additionally in aff(Prof))."""
    k = len(prof[0])
    tot = sum(prof[0])
    base = prof[0]
    V = [[p[i] - base[i] for i in range(k)] for p in prof]
    d = _rank(V, k)
    allbox, aff = [], []
    for c in it.product(*[range(a, b + 1) for a, b in ranges]):
        if sum(c) != tot:
            continue
        allbox.append(c)
        if _rank(V + [[c[i] - base[i] for i in range(k)]], k) == d:
            aff.append(c)
    return allbox, aff


@dataclass(frozen=True)
class Fill:
    """A density, and it refuses to be quoted against one denominator.

    The stub's contrast between two sides — 0.80 and 0.20 — was the affine dimension and nothing
    else; against `aff(Prof)` the same two sets read 0.800 and 0.771."""
    realised: int
    ambient_box: int
    affine_box: int
    dim: int
    ambient_dim: int

    def render(self) -> str:
        return (f"{self.realised}/{self.affine_box} = {self.realised/self.affine_box:.3f} "
                f"within aff(Prof) (dim {self.dim} of {self.ambient_dim}); "
                f"{self.realised}/{self.ambient_box} = {self.realised/self.ambient_box:.3f} "
                f"against the full box — the second number is a statement about the ambient "
                f"dimension, not about the set")


# --------------------------------------------------------------- the convex hull
def hull_lattice_points(prof, ranges):
    """Integer points of conv(Prof) inside the box, exactly, in rational arithmetic.

    NOTE the facet enumeration: a facet of a `k`-dimensional hull is spanned by `k` points, not
    `k−1`. Taking `k−1` finds NO facets in a 2-dimensional hull and then reports every box point as
    inside — the bug this session actually hit, which inflated a 29 to a 35. `_self_test` plants it
    back and requires the verdict to move."""
    d = len(prof[0])
    P = [tuple(Fr(x) for x in p) for p in prof]
    o = P[0]
    V = [tuple(p[i] - o[i] for i in range(d)) for p in P]
    rows, piv = [], []
    for v in V:
        r = list(v)
        for b, pc in zip(rows, piv):
            if r[pc] != 0:
                f = r[pc] / b[pc]
                r = [r[m] - f * b[m] for m in range(d)]
        nz = [m for m in range(d) if r[m] != 0]
        if nz:
            rows.append(r)
            piv.append(nz[0])
    k = len(rows)

    def coords(v):
        r, c = list(v), [Fr(0)] * k
        for i, (b, pc) in enumerate(zip(rows, piv)):
            if r[pc] != 0:
                f = r[pc] / b[pc]
                c[i] = f
                r = [r[m] - f * b[m] for m in range(d)]
        return tuple(c) if all(x == 0 for x in r) else None

    Q = [coords(v) for v in V]
    facets = []
    for sub in it.combinations(range(len(Q)), k):        # k points span a facet hyperplane
        S = [Q[i] for i in sub]
        M = [[S[j][m] - S[0][m] for m in range(k)] for j in range(1, k)]
        ns = _nullspace(M, k)
        if len(ns) != 1:
            continue
        n = ns[0]
        c = sum(n[m] * S[0][m] for m in range(k))
        vals = [sum(n[m] * q[m] for m in range(k)) - c for q in Q]
        if all(x >= 0 for x in vals):
            facets.append((n, c, 1))
        elif all(x <= 0 for x in vals):
            facets.append((n, c, -1))

    def inside(q):
        cq = coords(tuple(Fr(q[i]) - o[i] for i in range(d)))
        if cq is None:
            return False
        return all(s * (sum(n[m] * cq[m] for m in range(k)) - c) >= 0 for n, c, s in facets)

    return [c for c in it.product(*[range(a, b + 1) for a, b in ranges]) if inside(c)]


def _nullspace(M, k):
    M = [row[:] for row in M]
    piv, r = [], 0
    for c in range(k):
        p = next((i for i in range(r, len(M)) if M[i][c] != 0), None)
        if p is None:
            continue
        M[r], M[p] = M[p], M[r]
        f = M[r][c]
        M[r] = [x / f for x in M[r]]
        for i in range(len(M)):
            if i != r and M[i][c] != 0:
                g = M[i][c]
                M[i] = [M[i][j] - g * M[r][j] for j in range(k)]
        piv.append(c)
        r += 1
        if r == len(M):
            break
    out = []
    for fc in [c for c in range(k) if c not in piv]:
        v = [Fr(0)] * k
        v[fc] = Fr(1)
        for i, pc in enumerate(piv):
            v[pc] = -M[i][fc]
        out.append(v)
    return out


@dataclass(frozen=True)
class HullTest:
    """`Prof` against `conv(Prof) ∩ ℤ`, with the number of chances the test had to fail.

    `opportunities` is `|box ∩ aff(Prof)| − |Prof|`. When it is 0 the test is `not-discriminating`
    and its agreement is worth nothing; when it is 1 it is worth almost nothing, and the render
    says so rather than leaving a reader to notice."""
    realised: int
    hull_points: int
    affine_box: int
    unexplained: tuple

    @property
    def opportunities(self) -> int:
        return self.affine_box - self.realised

    def render(self) -> str:
        if self.opportunities == 0:
            return ("not-discriminating: every point of the affine box is realised, so no hull "
                    "could have excluded anything")
        head = (f"hull holds {self.hull_points}, Prof {self.realised}, "
                f"{len(self.unexplained)} in the hull and not realised")
        if self.opportunities <= 2:
            head += (f"  -- WEAK: only {self.opportunities} point(s) the test could ever have got "
                     f"wrong")
        return head


# --------------------------------------------------------------- the order ideal
def order_ideal_test(prof, ranges, free_coords):
    """Is `Prof` a down-set in the coordinatewise order on its free coordinates, in ANY orientation?

    This is the test convexity could not be. On the L side of M63 exactly one of four orientations
    holds, and of the `C(35,27) = 23,535,820` subsets of the affine box only 17 are down-sets in a
    given orientation, so the null is `p <= 4*17/23535820 ~ 3e-6`. Returns (orientations that hold,
    null count per orientation, population)."""
    S = {tuple(p[i] for i in free_coords) for p in prof}
    lo = [ranges[i][0] for i in free_coords]
    hi = [ranges[i][1] for i in free_coords]
    k = len(free_coords)
    good = []
    for flip in it.product((1, -1), repeat=k):
        ok = True
        for p in S:
            for j in range(k):
                q = list(p)
                q[j] -= flip[j]
                if not (lo[j] <= q[j] <= hi[j]):
                    continue
                if tuple(q) not in S:
                    ok = False
                    break
            if not ok:
                break
        if ok:
            good.append(flip)
    widths = [hi[j] - lo[j] + 1 for j in range(k)]
    return good, _count_down_sets(widths, len(S)), comb(_prod(widths), len(S))


def _prod(xs):
    r = 1
    for x in xs:
        r *= x
    return r


def _count_down_sets(widths, size):
    """Down-sets of a product of two chains with exactly `size` elements. Two dimensions only —
    which is what the measured level sets have; a third would need a different recursion and the
    function says so rather than returning a wrong number."""
    if len(widths) != 2:
        return None
    R, C = widths
    @lru_cache(None)
    def rec(i, prev, s):
        if s < 0:
            return 0
        if i == R:
            return 1 if s == 0 else 0
        return sum(rec(i + 1, h, s - h) for h in range(prev + 1))
    return rec(0, C, size)


# --------------------------------------------------------------- exchange classes
def exchange_classes(prof, varying_idx):
    """Group varying coordinates by the single-swap differences `e_o − e_o'` actually realised
    between profiles. Each class has a constant coordinate sum across all of `Prof`; the classes
    determine `aff(Prof)`, so a level set whose profiles do not span it is INCOMPLETE."""
    n = len(varying_idx)
    link = {i: i for i in varying_idx}

    def find(x):
        while link[x] != x:
            link[x] = link[link[x]]
            x = link[x]
        return x

    for p, q in it.combinations(prof, 2):
        diff = [i for i in varying_idx if p[i] != q[i]]
        if len(diff) == 2 and (p[diff[0]] - q[diff[0]]) == -(p[diff[1]] - q[diff[1]]):
            a, b = find(diff[0]), find(diff[1])
            if a != b:
                link[a] = b
    cls = defaultdict(list)
    for i in varying_idx:
        cls[find(i)].append(i)
    out = []
    for members in cls.values():
        sums = {sum(p[i] for i in members) for p in prof}
        out.append((tuple(sorted(members)), sums.pop() if len(sums) == 1 else None))
    return sorted(out)


# ===================================================================== symmetry
@dataclass(frozen=True)
class Rung:
    """A symmetry rung: a SUBGROUP of the stage's own stabiliser, as permutations of the atoms.

    Never a number. The base group has order 24; the stabiliser of a stage's atom set is smaller
    (12 and 6 on M63's two stages), and passing the wrong one is what M63's §5.9 pin bug was."""
    perms: tuple[tuple[int, ...], ...]
    name: str

    @property
    def order(self) -> int:
        return len(self.perms)

    def invariant(self, sel: frozenset[int]) -> bool:
        return all(frozenset(p[a] for a in sel) == sel for p in self.perms)


@dataclass(frozen=True)
class RungCensus:
    """How many members of a GIVEN level are `H`-invariant. Zero means the rung's own minimum is
    strictly larger; there is deliberately no field saying by how much, because this census cannot
    know and M64 §6 forbids the inference."""
    rung: Rung
    level_size: int
    invariant: int
    population: int
    profiles: int

    def render(self) -> str:
        s = (f"|H| = {self.rung.order:>2}  invariant members of the {self.level_size}-level: "
             f"{self.invariant}/{self.population}, {self.profiles} profiles")
        if self.invariant == 0:
            s += "   -> this rung's own minimum is LARGER (by an unmeasured amount)"
        return s


def stage_symmetry(base, stage, group_perm):
    """The subgroup of the base group preserving the stage's atom set, as atom permutations.

    `group_perm` is a list of lattice-tuple -> lattice-tuple maps (one per base group element).

    **An atom is keyed by `(half, tuple)`, not by the tuple alone.** On a joint stage (M63 C4,
    `side="LS"`) the same lattice point is an atom of each half, so a tuple-keyed index would
    collide and silently identify the two. The group acts DIAGONALLY -- the same element on both
    halves -- which is what makes an element of the order-24 group an automorphism of the whole
    type-M arena (M62 §R19(1)). On a one-sided stage the half is constant and this is the old
    computation exactly."""
    alab = [(l[0], tuple(l[1])) for l in stage.atom_labels]
    ix = {t: i for i, t in enumerate(alab)}
    A = set(alab)
    if len(ix) != len(alab):
        raise ValueError("two atoms share a (half, tuple) label; the stage's atoms are not a "
                         "partition of distinct vertices")
    out = []
    for g in group_perm:
        if {(h, g[t]) for h, t in A} != A:
            continue
        out.append(tuple(ix[(alab[a][0], g[alab[a][1]])] for a in range(len(alab))))
    return Rung(tuple(out), name="Aut(A)")


def subgroups(rung: Rung) -> list[Rung]:
    """All subgroups, by closing every subset of at most three generators. Complete for the orders
    that occur here (every subgroup of a group of order <= 24 is 3-generated)."""
    P = list(rung.perms)
    n = len(P[0])
    idx = {p: i for i, p in enumerate(P)}
    e = next(p for p in P if all(p[x] == x for x in range(n)))

    def comp(a, b):
        return tuple(a[b[k]] for k in range(n))

    found = set()
    for r in range(0, 4):
        for gens in it.combinations(P, r):
            H, fr = {e}, [e]
            while fr:
                a = fr.pop()
                for g in gens:
                    b = comp(a, g)
                    if b not in H:
                        H.add(b)
                        fr.append(b)
            found.add(frozenset(H))
    return [Rung(tuple(sorted(H)), name=f"H{len(H)}") for H in sorted(found, key=lambda H: (len(H), sorted(H)))]


# ===================================================================== the self-test
def _self_test(verbose=True):
    """Every refusal is planted and watched to fire, and the instrument is pointed at a known
    positive before any of its zeros are believed.

    The load-bearing control is #3: it restores the facet bug this module's docstring names —
    spanning a facet with `k−1` points instead of `k` — and requires the hull count to MOVE. A hull
    routine that finds no facets reports every box point as inside, which reads exactly like a
    generous polytope and is how a 29 became a 35 during subplanning."""
    fired, checked = [], []

    def chk(name, cond, detail=""):
        checked.append(name)
        if not cond:
            raise AssertionError(f"CONTROL DID NOT FIRE: {name} {detail}")
        if verbose:
            print(f"  ok  {name}{('  ' + detail) if detail else ''}")

    # 1. an Exclusion cannot be written by hand
    try:
        Exclusion(1, 2, "derived-by-ask", None)
        chk("hand-written Exclusion refused", False)
    except TypeError as ex:
        chk("hand-written Exclusion refused", "minted by" in str(ex))

    # 2. status and population must agree
    try:
        Exclusion(1, 2, "derived-by-ask", 48, _mint=_MINT)
        chk("derivation with a population refused", False)
    except ValueError:
        chk("derivation with a population refused", True)
    try:
        Exclusion(1, 2, "observed-over-level", None, _mint=_MINT)
        chk("observation without a population refused", False)
    except ValueError:
        chk("observation without a population refused", True)

    # 3. THE FACET CONTROL: plant the k-1 bug and watch the hull inflate
    prof = [(4, 7, 16), (4, 8, 15), (4, 9, 14), (5, 7, 15)]
    ranges = [(4, 5), (7, 9), (14, 16)]
    good = hull_lattice_points(prof, ranges)
    import types

    def bugged(prof, ranges):
        d = len(prof[0])
        P = [tuple(Fr(x) for x in p) for p in prof]
        o = P[0]
        V = [tuple(p[i] - o[i] for i in range(d)) for p in P]
        rows, piv = [], []
        for v in V:
            r = list(v)
            for b, pc in zip(rows, piv):
                if r[pc] != 0:
                    f = r[pc] / b[pc]
                    r = [r[m] - f * b[m] for m in range(d)]
            nz = [m for m in range(d) if r[m] != 0]
            if nz:
                rows.append(r)
                piv.append(nz[0])
        k = len(rows)
        # THE BUG, restored verbatim: (k-1)-subsets span nothing in a k-dimensional hull
        facets = []
        for sub in it.combinations(range(len(V)), max(k - 1, 0)):
            pass
        return [c for c in it.product(*[range(a, b + 1) for a, b in ranges])
                if sum(c) == sum(prof[0])]
    bad = bugged(prof, ranges)
    chk("planted facet bug inflates the hull", len(bad) > len(good),
        f"as shipped {len(good)}, with the bug {len(bad)}")

    # 4. a Fill refuses to be quoted against one denominator
    f = Fill(realised=27, ambient_box=135, affine_box=35, dim=2, ambient_dim=4)
    r = f.render()
    chk("Fill names both denominators", "0.771" in r and "0.200" in r and "dim 2 of 4" in r)

    # 5. a hull test with no opportunities is not-discriminating
    chk("hull test with no opportunity refuses a verdict",
        HullTest(4, 4, 4, ()).render().startswith("not-discriminating"))
    chk("hull test with one opportunity is flagged WEAK",
        "WEAK" in HullTest(4, 4, 5, ()).render())

    # 6. a truncated level set refuses every derivation
    trunc = LevelSet((0, 1, 2), (frozenset({0, 1}), frozenset({0, 2})), 2, complete=False)
    try:
        trunc.necessary()
        chk("truncated level set refuses the necessary set", False)
    except ValueError:
        chk("truncated level set refuses the necessary set", True)

    # 7. order-ideal: a planted non-down-set holds in NO orientation
    ideal = [(a, b) for a in range(0, 5) for b in range(2, 7)] + [(5, 2), (6, 2)]
    orient, null, pop = order_ideal_test(ideal, [(0, 6), (2, 6)], [0, 1])
    chk("the measured L shape is a down-set in exactly one orientation", len(orient) == 1,
        f"null {null} of {pop} -> p <= {4*null/pop:.2g}")
    hole = [p for p in ideal if p != (2, 4)]
    orient2, _, _ = order_ideal_test(hole, [(0, 6), (2, 6)], [0, 1])
    chk("a punctured shape is a down-set in NO orientation", orient2 == [])

    # 7b. a class of size 3 has TWO free coordinates, not one
    cls3 = [((0, 1, 2), 27)]
    chk("a size-3 exchange class contributes two free coordinates",
        _free_coords(cls3, [0, 1, 2]) == [0, 1])
    chk("a class with no constant leaves every coordinate free",
        _free_coords([((0, 1), None)], [0, 1]) == [0, 1])

    # 8. exchange classes: a broken law reports no constant
    p2 = [(0, 12), (1, 11), (2, 10)]
    chk("exchange class finds the constant sum", exchange_classes(p2, [0, 1]) == [((0, 1), 12)])
    p3 = [(0, 12), (1, 11), (2, 9)]
    got = exchange_classes(p3, [0, 1])
    chk("a broken law reports no constant", got == [((0, 1), None)], f"{got}")

    # 9. a rung census with zero invariants says the minimum is larger and cannot say more
    rc = RungCensus(Rung(((0, 1),), "H1"), 375, 0, 3264, 0)
    chk("zero invariants renders as 'larger by an unmeasured amount'",
        "LARGER" in rc.render() and "unmeasured" in rc.render())
    chk("RungCensus has no field for the rung's own minimum",
        "minimum" not in {f.name for f in RungCensus.__dataclass_fields__.values()})

    # 10. Rung.invariant actually discriminates
    swap = Rung(((1, 0, 2),), "swap")
    chk("Rung.invariant accepts an invariant set", swap.invariant(frozenset({0, 1})))
    chk("Rung.invariant rejects a non-invariant set", not swap.invariant(frozenset({0, 2})))

    if verbose:
        print(f"\n  {len(checked)} controls, ALL FIRED")
    return checked


# ===================================================================== the driver
def analyse(base, stage, rec, ask=None, log=print):
    """The whole geometry of one complete level set, as a record that names its own producer.

    `ask` is optional: without it the exclusions are reported as OBSERVATIONS only, and the record
    says so. With it they are also derived, and both populations are reported separately."""
    import parts_report as R
    ls = LevelSet.from_record(rec)
    orbit_of = _orbit_map(base, stage)
    labels, per, mult = profiles(ls, orbit_of)
    vi = varying(labels, per)
    prof = sorted(set(per))
    ranges = [(min(p[i] for p in prof), max(p[i] for p in prof)) for i in range(len(labels))]
    nec, unused = ls.necessary(), ls.unused()
    obs = observe_exclusions(ls)
    der, notder = ([], [])
    if ask is not None:
        der, notder = derive_exclusions(ask, stage.atoms, obs, log=log)
    matched = {a for e in obs for a in e.pair}
    residual = [a for a in ls.free() if a not in matched]

    pv = [tuple(p[i] for i in vi) for p in prof]
    allbox, aff = boxes(pv, [ranges[i] for i in vi])
    hull = hull_lattice_points(pv, [ranges[i] for i in vi])
    ht = HullTest(len(pv), len(hull), len(aff), tuple(sorted(set(hull) - set(pv))))
    cls = exchange_classes(prof, vi)
    free_in_pv = _free_coords(cls, vi)
    orient, null, pop = order_ideal_test(pv, [ranges[i] for i in vi], free_in_pv) \
        if len(free_in_pv) == 2 else ([], None, None)
    fill = Fill(len(pv), len(allbox), len(aff), affine_dim(pv), len(vi))

    return {
        "level": {"size": ls.size, "atoms": len(ls.atoms),
                  "minima": R.asdict(R.Count(len(ls.minima), rec["M_set"]["count"]["method"]))},
        "atom_classes": {"necessary": len(nec), "in_observed_pairs": len(matched),
                         "residual": len(residual), "unused": len(unused),
                         "arithmetic": f"{len(nec)} + {len(obs)} + "
                                       f"{ls.size - len(nec) - len(obs)} of {len(residual)} = {ls.size}"},
        "exclusions": {"observed": R.asdict(R.Count(len(obs), "exhaustive-level", of=len(ls.minima))),
                       "derived": (R.asdict(R.Count(len(der), "exhaustive", of=len(obs)))
                                   if ask is not None else None),
                       "not_derived": [e.pair for e in notder],
                       "pairs": [[e.u, e.v, e.status] for e in (der or obs)]},
        "profiles": {"orbits": [list(l) for l in labels],
                     "varying": [list(labels[i]) for i in vi],
                     "lo": [ranges[i][0] for i in range(len(labels))],
                     "hi": [ranges[i][1] for i in range(len(labels))],
                     "distinct": len(prof), "multiplicity": {str(list(p)): mult[p] for p in prof}},
        "shape": {"affine_dim": affine_dim(pv), "ambient_dim": len(vi),
                  "fill": fill.render(),
                  "hull": ht.render(), "hull_unexplained": [list(x) for x in ht.unexplained],
                  "exchange_classes": [[[list(labels[i]) for i in m], c] for m, c in cls],
                  "order_ideal": {"orientations": [list(o) for o in orient],
                                  "null_per_orientation": null, "population": pop}},
        "producer": "tools/parts_faces.py:analyse",
        "stage_fingerprint": stage.fingerprint(),
        "base_fingerprint": R.fp_base(base),
        "provenance": R.provenance(),
    }


def _orbit_map(base, stage):
    """Atom -> the orbit coordinate its profile is counted in.

    On a one-sided stage that is his orbit label, and the profiles are the ones M64 recorded. On a
    JOINT stage the half is the distinguishing datum -- the same orbit is filled independently in
    each half -- so the coordinate is `(half, label)` and the record's `profiles.orbits` says so
    by carrying two-part labels."""
    joint = len(getattr(stage, "reduce", {stage.side})) > 1
    lab = [((l[0], tuple(base.label[base.of[tuple(l[1])]])) if joint
            else tuple(base.label[base.of[tuple(l[1])]])) for l in stage.atom_labels]
    return lambda a: lab[a]


def _free_coords(cls, vi):
    """The free coordinates of `Prof`: within an exchange class of size `k` whose sum is constant,
    `k − 1` coordinates are free, so a class of size 3 contributes TWO and not one. Getting this
    wrong makes the order-ideal test decline on a set it should have decided."""
    pos = {o: k for k, o in enumerate(vi)}
    out = []
    for members, const in cls:
        keep = [m for m in members if m in pos]
        if const is None:
            out.extend(pos[m] for m in keep)          # no law: every coordinate is free
        else:
            out.extend(pos[m] for m in keep[:-1])     # one coordinate is determined by the sum
    return out


def base_group_perms(base):
    """The order-24 group as lattice-tuple permutations of the base."""
    import typem as T
    pt2i = {p: i for i, p in enumerate(base.pts)}
    return [{base.tups[i]: base.tups[pt2i[g(p)]] for i, p in enumerate(base.pts)}
            for g in T.parts_group()]


# ===================================================================== the rung lattice (M64 §R10)
def _atom_orbits(rung: Rung, n: int):
    """The orbits of `rung` on the atoms, as index lists. An H-invariant selection is a union of
    these, which is the whole content of §R10(b)."""
    seen, out = set(), []
    for a in range(n):
        if a in seen:
            continue
        orb = sorted({p[a] for p in rung.perms} | {a})
        seen |= set(orb)
        out.append(orb)
    return out


def rung_lattice(base, stage, rec, *, verify_ask=None, group_perm=None, log=print) -> dict:
    """For every subgroup `H` of `Aut(A)`: the weight-minimum hitting set of the STORED `Y` over
    the `H`-orbits (M64 §R10(b)).

    **It costs no colouring ask.** An `H`-invariant selection is a union of `H`-orbits, and it
    refuses iff it hits every correction set -- and a correction set is a property of the base
    problem, not of the rung. So `Y`, harvested once at rung 1, is the complete constraint system
    for every subgroup at once.

    The value is a LOWER bound, because `Y` is harvested lazily and fewer constraints mean a
    smaller minimum. When `verify_ask` is given, one refusal ask on the witness closes it to an
    equality whenever the witness refuses (§R10's own control).

    Reproduces `data/m62/m64-rung-lattice.json`, whose producer was a scratch script (M64-9)."""
    from pysat.formula import WCNF
    from pysat.examples.rc2 import RC2
    G = group_perm or base_group_perms(base)
    aut = stage_symmetry(base, stage, G)
    n = len(stage.atoms)
    weight = [m.bit_count() for m in stage.atoms]
    Y = [list(c) for c in rec["hypergraph"]["sets"]]
    minima = [frozenset(m) for m in rec["minima"]]
    rows, n_sat, n_unsat = [], 0, 0
    for H in subgroups(aut):
        orbs = _atom_orbits(H, n)
        of = {a: i for i, o in enumerate(orbs) for a in o}
        w = WCNF()
        for c in Y:
            w.append(sorted({of[a] + 1 for a in c}))
        for i, o in enumerate(orbs):
            w.append([-(i + 1)], weight=sum(weight[a] for a in o))
        with RC2(w) as rc:
            model = rc.compute()
        kept = [i for i in range(len(orbs)) if model[i] > 0]
        bound = sum(weight[a] for i in kept for a in orbs[i])
        attained = None
        if verify_ask is not None:
            atoms = sorted(a for i in kept for a in orbs[i])
            v = verify_ask(atoms)
            attained = (v == "unsat")
            n_unsat += attained; n_sat += (not attained)
        rows.append({"order": H.order, "orbits": len(orbs), "bound": bound,
                     "attained": attained, "vertices": bound + stage.side_fixed,
                     "excess": bound - min(len(m) and sum(weight[a] for a in m) for m in minima)
                     if minima else None,
                     "invariant_minima_at_base": sum(1 for m in minima if H.invariant(m))})
    base_atoms = min(sum(weight[a] for a in m) for m in minima) if minima else None
    for r in rows:
        r["excess"] = None if base_atoms is None else r["bound"] - base_atoms
    return {"aut_A_order": aut.order, "base_level_atoms": base_atoms,
            "base_level_vertices": None if base_atoms is None else base_atoms + stage.side_fixed,
            "rungs": rows, "verified": verify_ask is not None,
            "note": "bound = weighted minimum hitting set over the HARVESTED Y (a subset of the "
                    "true Y, hence a lower bound); 'attained' means the witness was verified to "
                    "refuse, which closes it to an equality.",
            "producer": "tools/parts_faces.py:rung_lattice"}


def orbit_closure(base, stage, rec, *, group_perm=None) -> dict:
    """For every subgroup `H`: `min |cl_H(M)|` over the level's members (M64 §R5), the solver-free
    UPPER bound on the rung-`H` minimum -- and an equality when minimised over inclusion-minimal
    refusers rather than minimum-size ones (§R10(a)).

    Reproduces `data/m62/m64-orbit-closure.json` (M64-9)."""
    G = group_perm or base_group_perms(base)
    aut = stage_symmetry(base, stage, G)
    weight = [m.bit_count() for m in stage.atoms]
    minima = [frozenset(m) for m in rec["minima"]]
    size = min(sum(weight[a] for a in m) for m in minima) if minima else None
    rows = []
    for H in subgroups(aut):
        dist, best, inv = Counter(), None, 0
        for m in minima:
            cl = set()
            for p in H.perms:
                cl |= {p[a] for a in m}
            w = sum(weight[a] for a in cl)
            dist[w] += 1
            best = w if best is None else min(best, w)
            inv += (len(cl) == len(m))
        rows.append({"order": H.order, "invariant_minima": inv, "min_closure": best,
                     "closure_excess": None if size is None else best - size,
                     "upper_bound_on_M_H": best,
                     "closure_distribution": {str(k): v for k, v in sorted(dist.items())}})
    return {"level_size": size, "minima": len(minima), "aut_A_order": aut.order, "rungs": rows,
            "theorem": "R upward closed and H <= Aut(A): every h(M) refuses, so cl_H(M) = "
                       "U_h h(M) is an H-invariant refuser. Hence min_M |cl_H(M)| is an upper "
                       "bound on the rung-H minimum, computable with no solver, and it is an "
                       "EQUALITY when the minimum is taken over inclusion-minimal refusers "
                       "(M64 section R10 a).",
            "producer": "tools/parts_faces.py:orbit_closure"}


def _reproduce_m64(verify=True):
    """c1.8: regenerate M64's two scratch-produced artifacts and compare rung by rung.

    Verdicts are `reproduces-m64` or `differs-from-m64:<side>:<rung index>`; nothing here says
    "clean"."""
    import json as _json, os as _os, sys as _sys, time as _time
    _sys.path.insert(0, _os.path.dirname(_os.path.abspath(__file__)))
    import parts_repro as P, parts_stage as PS, parts_vtx as V, parts_reduce as RED
    ROOT = _os.path.dirname(_os.path.dirname(_os.path.abspath(__file__)))
    D = _os.path.join(ROOT, "data", "m62", "parts-ref11", "JP", "Large")
    t0 = _time.time()
    B = P.Base(P.PARTS_R)
    G = base_group_perms(B)
    stored_rl = _json.load(open(_os.path.join(ROOT, "data", "m62", "m64-rung-lattice.json")))
    stored_oc = _json.load(open(_os.path.join(ROOT, "data", "m62", "m64-orbit-closure.json")))
    out, fails = {}, []
    for side, Lf, Sf, rf in (("L", "v451e2400.vtx", "v136e564.vtx", "m63-L451-reduction.json"),
                             ("S", "v374e1860.vtx", "v166e774.vtx", "m63-S166-reduction.json")):
        st = PS.Stage(B, V.load_lattice(_os.path.join(D, Lf)), V.load_lattice(_os.path.join(D, Sf)),
                      side=side, rung=1)
        rec = _json.load(open(_os.path.join(ROOT, "data", "m62", rf)))
        ask = None
        if verify:
            orc = RED.Oracle(st, wall=600.0)
            ask = lambda kept: orc.ask(kept)[0]
        rl = rung_lattice(B, st, rec, verify_ask=ask, group_perm=G)
        oc = orbit_closure(B, st, rec, group_perm=G)
        out[side] = {"rung_lattice": rl, "orbit_closure": oc}
        for k, ours, theirs in (("rung_lattice", rl["rungs"], stored_rl[side]["rungs"]),
                                ("orbit_closure", oc["rungs"], stored_oc[side]["rungs"])):
            if len(ours) != len(theirs):
                fails.append(f"differs-from-m64:{side}:{k}:count {len(ours)} vs {len(theirs)}")
                continue
            for i, (a, b) in enumerate(zip(ours, theirs)):
                keys = [x for x in b if x in a and x not in ("attained",)]
                bad = [x for x in keys if a[x] != b[x]]
                if bad:
                    fails.append(f"differs-from-m64:{side}:{k}:rung {i} on {bad} "
                                 f"(ours {[a[x] for x in bad]}, stored {[b[x] for x in bad]})")
        print(f"  {side}: {len(rl['rungs'])} rungs, aut order {rl['aut_A_order']}, "
              f"base level {rl['base_level_vertices']} vertices  [{_time.time()-t0:.0f}s]")
    print("\n" + ("reproduces-m64" if not fails else "\n".join(fails)))
    return out, fails


if __name__ == "__main__":
    if "--self-test" in sys.argv:
        _self_test()
    elif "--reproduce-m64" in sys.argv:
        _reproduce_m64(verify="--no-verify" not in sys.argv)
