#!/usr/bin/env python3
"""The search's win condition: which pairs of a configuration are **forced to share a colour**.

UNTRUSTED. Nothing here is believed. A pair this tool calls forced becomes a theorem only through
`Proofs/HadwigerNelson/Forcer.lean` — `Forces.of_edges (by decide +kernel)` at a size the kernel can
exhaust, `Forces.of_gadget` from a SAT certificate above it. A bug here can cost a theorem and can
never buy one.

## Why this is the thing to search for

Both known rungs of Hadwiger–Nelson are one argument, one colour apart. A configuration in which
every proper `k`-colouring paints two designated points `p` and `q` the same colour is a **forcer**;
place two copies sharing `p` so that the two images of `q` land a unit apart, and no `k`-colouring
survives. That is the Moser spindle at three colours (the forcer is a rhombus, four points) and de
Grey's graph at four (the forcer is 791 points). `not_colorable_of_spindled_forcer` is that argument
as a theorem, so anything this tool finds has somewhere to land.

The closing move is the spindle already in `construct.py`, and it is available exactly when
`4r² − 1` is a square in ℚ(√3,√5,√7,√11) — so the win condition is a forced pair *at a spindle-able
distance*, and `field.py` decides that for free.

## The three outcomes, and the one that must not be folded

A SAT call answers `forced` (no colouring separates the pair), `separated` (here is one that does),
or `unknown` (the search gave up). **`unknown` is never reported as `separated`.** This project has
twice shipped a check that reported nothing when it could not run, and "searched X, found nothing"
is a result it publishes — so a timeout that silently became "not forced" would be a lie rather
than a slowdown.

    python3 tools/forcer.py --self-test
    python3 tools/forcer.py --graph tools/spindle.json --pivot 0 --colours 3
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import tempfile
import time
from dataclasses import dataclass, field as dc_field
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

REPO = Path(__file__).resolve().parent.parent
CADICAL = os.environ.get("CADICAL") or str(
    Path(subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True,
                        check=True, cwd=REPO).stdout.strip()) / "bin" / "cadical")

from coloring import base_clauses, unvar, var  # noqa: E402
from field import spindle_available  # noqa: E402

FORCED, SEPARATED, UNKNOWN = "forced", "separated", "unknown"


# ------------------------------------------------------------------ the solver call

def _solve(clauses: list[list[int]], nvars: int, timeout: float | None):
    """`(status, model)` with status in `sat` / `unsat` / `unknown`. A model is a set of literals."""
    with tempfile.NamedTemporaryFile("w", suffix=".cnf", delete=False) as t:
        t.write(f"p cnf {nvars} {len(clauses)}\n")
        for c in clauses:
            t.write(" ".join(map(str, c)) + " 0\n")
        path = t.name
    try:
        try:
            r = subprocess.run([CADICAL, "-q", path], capture_output=True, text=True,
                               timeout=timeout)
        except subprocess.TimeoutExpired:
            return "unknown", None
        if r.returncode == 20:
            return "unsat", None
        if r.returncode != 10:
            return "unknown", None
        model = {int(x) for line in r.stdout.splitlines() if line.startswith("v ")
                 for x in line[2:].split() if x != "0"}
        return "sat", model
    finally:
        os.unlink(path)


# ------------------------------------------------------------------ one pair

def forces(n: int, edges, p: int, q: int, k: int, timeout: float | None = None) -> str:
    """Is every proper `k`-colouring of this graph equal at `p` and `q`?

    One SAT call: pin `p` to colour 0 and `q` to colour 1. Colour names are arbitrary, so refuting
    that one pattern refutes every colouring that separates them.

    Returns `forced`, `separated`, or `unknown` — **three outcomes, and the third is not folded into
    either other one.**
    """
    if p == q:
        raise ValueError(f"a point cannot be forced against itself (both are {p}); "
                         "pick a pivot and a distinct partner")
    st, _ = _solve(base_clauses(n, edges, k) + [[var(p, 0, k)], [var(q, 1, k)]], k * n, timeout)
    return {"unsat": FORCED, "sat": SEPARATED, "unknown": UNKNOWN}[st]


# ------------------------------------------------------------------ the identity, as a filter

REMOVABLE = "removable"
CRITICAL = "critical"


def removable(n: int, edges, p: int, k: int, timeout: float | None = None) -> str:
    """Does a `k`-colour fan of ANY width sit at `p`?

    M15 measured that the two questions are one: joining `p` to every other vertex asks exactly
    whether `G - p` still needs `k` colours, and `Fan.widen` makes the widest join the easiest fan
    there is. So one call at **`k-1` colours** settles every distance class at that pivot at once --
    measured 7.6x cheaper than the same question asked as a fan, and against one call per class.

    Returns `removable` (a fan sits here), `critical` (no fan at any width), or `unknown` --
    **three outcomes, and the third is never folded.** Read as `critical`, a timeout would claim
    "nothing here" on no evidence, which is the claim a certificate is later built on.

    The filter is one-sided by nature: it rejects a pivot outright and never promotes one, because
    a fan existing says nothing about its width, and width is the whole difficulty.
    """
    keep = [q for q in range(n) if q != p]
    idx = {q: i for i, q in enumerate(keep)}
    e2 = [(idx[a], idx[b]) for a, b in edges if a != p and b != p]
    st, _ = _solve(base_clauses(len(keep), e2, k - 1), (k - 1) * len(keep), timeout)
    return {"unsat": REMOVABLE, "sat": CRITICAL, "unknown": UNKNOWN}[st]


@dataclass
class Filtered:
    """Which pivots survive the filter, and how many were never settled.

    `line()` prints the unsettled count **unconditionally**. "0 pivots carry a fan" is a lie by
    omission when some pivot timed out, and the graph-level claim is the one a certificate rests
    on -- so the number that would make it false is never off the page.
    """

    total: int
    survivors: list[int]
    unsettled: list[int]

    @property
    def settled(self) -> bool:
        return not self.unsettled

    def line(self) -> str:
        head = (f"{len(self.survivors)} of {self.total} pivots carry a fan; "
                f"{len(self.unsettled)} unsettled")
        if self.unsettled:
            return (head + f" ** {self.unsettled[:8]} -- this is not a verdict about the graph, "
                    "raise the timeout **")
        if self.survivors:
            return head + f" -- narrow one: {self.survivors[:8]}"
        return head + " -- no fan anywhere in this graph, at any pivot, at any width"


def filter_pivots(n: int, edges, k: int, timeout: float | None = None,
                  pivots=None) -> Filtered:
    """Run `removable` over every pivot. The cheap rejection the hunt leads with."""
    survivors, unsettled = [], []
    for p in (range(n) if pivots is None else pivots):
        st = removable(n, edges, p, k, timeout)
        if st == REMOVABLE:
            survivors.append(p)
        elif st == UNKNOWN:
            unsettled.append(p)
    return Filtered(n if pivots is None else len(list(pivots)), survivors, unsettled)


# ------------------------------------------------------------------ one pivot, every partner

@dataclass
class Backbone:
    """Every partner one pivot forces, and every partner whose status is not settled.

    The loop that builds this maintains

        confirmed ⊆ BB ⊆ confirmed ∪ candidates ∪ unknown

    where `BB` is the true set of forced assignments, and it ends with `candidates` empty. So the
    answer is **exact exactly when `unknown` is empty** — which is why `unknown` is a set here and
    not a boolean: a caller that must re-ask needs to know which pivots to re-ask about.
    """
    pivot: int
    confirmed: dict[int, int] = dc_field(default_factory=dict)
    unknown: set[int] = dc_field(default_factory=set)
    colourable: bool = True
    calls: int = 0

    @property
    def exact(self) -> bool:
        return not self.unknown

    def partners(self) -> list[int]:
        """The vertices forced to the pivot's own colour — the search's candidates."""
        return sorted(v for v, c in self.confirmed.items() if c == 0 and v != self.pivot)

    def line(self) -> str:
        """One line, and it always states the unknown count — failure louder than success."""
        if not self.colourable:
            return (f"pivot {self.pivot}: the graph has no colouring at all, so nothing is forced "
                    f"by it — refute the graph directly instead")
        return (f"pivot {self.pivot}: {len(self.partners())} forced partners {self.partners()}, "
                f"{len(self.unknown)} unsettled, {self.calls} calls"
                f"{'' if self.exact else '  ** NOT EXACT: re-ask with more budget **'}")


def backbone(n: int, edges, pivot: int, k: int, timeout: float | None = None,
             budget: float | None = None) -> Backbone:
    """Every vertex whose colour is fixed once `pivot` is pinned.

    One computation per *pivot* rather than one per *pair*, so the oracle is O(vertices). Each SAT
    answer that comes back satisfiable kills many candidates at once, which is what makes this far
    cheaper than the pairwise loop it replaces.
    """
    base = base_clauses(n, edges, k) + [[var(pivot, 0, k)]]
    out = Backbone(pivot=pivot)
    st, model = _solve(base, k * n, timeout)
    out.calls = 1
    if st == "unsat":
        out.colourable = False
        return out
    if st == "unknown":
        out.unknown = set(range(n))
        return out
    cand = {x for x in model if x > 0}
    t0 = time.time()
    while cand:
        if budget is not None and time.time() - t0 > budget:
            out.unknown |= {unvar(x, k)[0] for x in cand}
            return out
        lit = min(cand)
        st, m2 = _solve(base + [[-lit]], k * n, timeout)
        out.calls += 1
        if st == "unsat":
            cand.discard(lit)
            base.append([lit])
            v, c = unvar(lit, k)
            out.confirmed[v] = c
        elif st == "sat":
            cand &= {x for x in m2 if x > 0}
        else:
            cand.discard(lit)
            out.unknown.add(unvar(lit, k)[0])
    return out


# ------------------------------------------------------------------ fans

FAN = "fan"


def fanEdges(edges, p: int, Q) -> list[tuple[int, int]]:
    """The pivot joined to every partner — **`fanEdges` in `Proofs/HadwigerNelson/Fan.lean`**.

    Written here rather than encoded as extra clauses so that the tool and Lean ask the *same*
    question of the *same* object. A fan is uncolourability of this graph, which is why
    `Fan.of_unsat` is one line over machinery M03 already shipped.
    """
    return list(edges) + [(p, q) for q in Q]


def fan(n: int, edges, p: int, Q, k: int, timeout: float | None = None) -> str:
    """Does every proper `k`-colouring paint `p` like at least one member of `Q`?

    One SAT call on the joined graph: a proper colouring of `edges + {p—q : q ∈ Q}` is exactly a
    proper colouring of `edges` that separates `p` from all of `Q`, so unsatisfiable means fan.

    Returns `fan`, `separated`, or `unknown` — **three outcomes, and the third is never folded into
    either other one.** A timeout read as `separated` would report a width that is too large; read
    as `fan` it would report one that is too small and the claim would be *false*.

    `forces` is this at `Q = [q]`.
    """
    if p in Q:
        raise ValueError(f"the pivot {p} is listed among its own partners, which makes the fan "
                         f"trivially true and says nothing — drop it from Q")
    st, _ = _solve(base_clauses(n, fanEdges(edges, p, Q), k), k * n, timeout)
    return {"unsat": FAN, "sat": SEPARATED, "unknown": UNKNOWN}[st]


@dataclass
class Fanned:
    """A fan and the word its width earned.

    `irredundant` is `True` only when **every** surviving partner was tried for removal and the
    oracle *settled* the attempt. A width from a greedy sweep is not a minimum — measured at M14
    subplanning, greedy reported 3 on a configuration whose true minimum is 1 — so this type
    refuses to say "minimum" and says "irredundant" instead.
    """
    pivot: int
    keep: list[int]
    irredundant: bool
    unsettled: list[int]
    calls: int

    @property
    def width(self) -> int | None:
        """The width, or `None` when the sweep did not settle — in which case there is no width."""
        return len(self.keep) if self.irredundant and not self.unsettled else None

    def line(self) -> str:
        if self.unsettled:
            return (f"width <= {len(self.keep)} at pivot {self.pivot}  "
                    f"** UNSETTLED: {len(self.unsettled)} drops timed out — this is not a width ** "
                    f"({self.calls} calls)")
        word = "irredundant" if self.irredundant else "NOT shown irredundant"
        tail = ("  -> width >= 3 cannot be closed by a spindle; narrow it"
                if len(self.keep) >= 3 else
                "  -> width 2 closes only with the partners opposite the pivot at r^2=1/2"
                if len(self.keep) == 2 else
                "  -> width 1 is a forced pair; spindle it" if len(self.keep) == 1 else
                "  -> width 0: the graph has no colouring at all")
        return (f"width {len(self.keep)} at pivot {self.pivot}  [{word}, 0 unsettled, "
                f"{self.calls} calls]{tail}")


def shrink_fan(n: int, edges, p: int, Q, k: int, timeout: float | None = None,
               log=None, oracle=None) -> Fanned:
    """Drop partners while the fan survives, then **certify** that none of the rest can go.

    Invariant: the kept set is a fan at every step. Measure: `len(keep)`, strictly decreasing on
    each accepted drop and bounded below by zero, so this terminates.

    The certifying sweep is the whole point. Dropping greedily and stopping gives a set nobody has
    shown to be irreducible; here every survivor has been tried and refused, and any attempt the
    oracle could not settle is **carried out in `unsettled`** rather than silently treated as a
    refusal — which would report a width that is too large and call it measured.

    `oracle` replaces the solver call, and exists for one reason: with a real solver the only way
    to reach the `unknown` branch below is a timeout, and a budget small enough to trigger it also
    starves the guard call above, so that branch is unreachable from outside. A negative control
    caught exactly that — deleting the branch left the self-test green. The production path is
    unchanged; the control passes a stub.
    """
    ask = oracle if oracle is not None else fan
    keep = [q for q in Q if q != p]
    calls = 0
    st = ask(n, edges, p, keep, k, timeout)
    calls += 1
    if st != FAN:
        return Fanned(p, keep, False, [] if st == SEPARATED else list(keep), calls)
    unsettled = []
    for q in list(keep):
        trial = [x for x in keep if x != q]
        st = ask(n, edges, p, trial, k, timeout)
        calls += 1
        if st == FAN:
            keep = trial
            if log:
                log(f"    dropped {q}, {len(keep)} left")
        elif st == UNKNOWN:
            unsettled.append(q)
    return Fanned(p, keep, not unsettled, unsettled, calls)


def best_fan(cfg, k: int, pivots=None, timeout: float | None = None,
             spindle_only: bool = True, log=None) -> Fanned | None:
    """The narrowest **irredundant** fan over one distance class, across the given pivots.

    One distance class at a time, because that is what the closing move needs: the two partners of
    a width-2 close have to be equidistant from the pivot, and `not_colorable_of_spindled_fan`'s
    join is only available then.

    Returns `None` when no pivot and no class carries a fan — and that is the **useful** answer, not
    a failure: it says the configuration is not merely short of forcing but has no disjunctive
    property to narrow at all.
    """
    n = len(cfg)
    edges = cfg.edges()
    adj = set(edges) | {(b, a) for (a, b) in edges}
    best = None
    for p in (range(n) if pivots is None else pivots):
        by_dist: dict = {}
        for q in range(n):
            if q == p or (p, q) in adj:
                continue
            r2 = cfg.distsq_rational(p, q)
            if r2 is None or (spindle_only and not spindleable(r2)):
                continue
            by_dist.setdefault(r2, []).append(q)
        for r2, Q in sorted(by_dist.items(), key=lambda t: len(t[1])):
            if best is not None and best.width is not None and len(Q) >= best.width:
                continue
            if fan(n, edges, p, Q, k, timeout) != FAN:
                continue
            got = shrink_fan(n, edges, p, Q, k, timeout, log)
            if log:
                log(f"  pivot {p} r^2={r2}: {got.line()}")
            if got.width is not None and (best is None or best.width is None
                                          or got.width < best.width):
                best = got
    return best


# ------------------------------------------------------------------ the win condition

def spindleable(r2: Fraction) -> bool:
    """Can a spindle close on a pair at this squared distance? `4r²−1` a square in the field."""
    return spindle_available(r2)


def wins(cfg, k: int, pivots=None, timeout: float | None = None,
         budget: float | None = None) -> tuple[list[tuple[int, int, Fraction]], list[Backbone]]:
    """Every `(pivot, partner, r²)` this configuration forces **at a spindle-able distance**.

    Returns the wins and every backbone computed, so a caller can see what was not settled rather
    than inferring completeness from an empty answer.
    """
    n = len(cfg)
    edges = cfg.edges()
    out, bbs = [], []
    for p in (range(n) if pivots is None else pivots):
        bb = backbone(n, edges, p, k, timeout, budget)
        bbs.append(bb)
        for q in bb.partners():
            r2 = cfg.distsq_rational(p, q)
            if r2 is not None and spindleable(r2):
                out.append((p, q, r2))
    return out, bbs


# ------------------------------------------------------------------ shrinking a forcer

@dataclass
class Shrunk:
    """The output of a shrink, and the word it earned.

    `irredundant` is `True` only after **every** surviving point has been tried for deletion and
    refused, with the oracle settling each attempt. A batch-greedy descent alone cannot claim it,
    so it is computed rather than assumed.
    """
    keep: list[int]
    irredundant: bool
    unsettled: list[int]
    calls: int

    def line(self) -> str:
        word = "irredundant" if self.irredundant else "NOT shown irredundant"
        tail = "" if not self.unsettled else f"; {len(self.unsettled)} deletions unsettled"
        return f"{len(self.keep)} points, {word}, {self.calls} oracle calls{tail}"


def shrink(n: int, edges, p: int, q: int, k: int, timeout: float | None = None,
           budget: float | None = None, rng=None, log=None) -> Shrunk:
    """Delete points while the pair stays forced, then **certify** what is left.

    Invariant: the pair is forced at every step. Measure: the point count, strictly decreasing on
    each accepted deletion and bounded below by two, so the loop terminates.

    Two phases, because the claim decides the loop rather than the reverse. The batch descent is
    fast and establishes nothing; the final single-point sweep over **every** survivor is what earns
    the word "irredundant", and any deletion the oracle could not settle is reported rather than
    counted as a refusal.
    """
    import random
    rng = rng or random.Random(0)
    say = log if log is not None else (lambda _: None)
    keep = set(range(n))
    calls = 0

    def still_forced(s: set[int]) -> str:
        order = sorted(s)
        ix = {v: i for i, v in enumerate(order)}
        e = [(ix[a], ix[b]) for a, b in edges if a in ix and b in ix]
        return forces(len(order), e, ix[p], ix[q], k, timeout)

    t0 = time.time()
    # phase 1 — batch descent, purely for speed
    block = max(1, len(keep) // 4)
    while block >= 1 and (budget is None or time.time() - t0 < budget):
        movable = [v for v in keep if v not in (p, q)]
        rng.shuffle(movable)
        progress = False
        for i in range(0, len(movable), block):
            if budget is not None and time.time() - t0 > budget:
                break
            drop = set(movable[i:i + block])
            if not drop:
                continue
            calls += 1
            if still_forced(keep - drop) == FORCED:
                keep -= drop
                progress = True
                say(f"  descent: -{len(drop)} -> {len(keep)} points "
                    f"({time.time() - t0:.0f}s, block {block})")
        if not progress:
            if block == 1:
                break
            block //= 2

    # phase 2 — the certifying sweep: every survivor tried, one at a time
    unsettled = []
    irredundant = True
    for v in sorted(keep):
        if v in (p, q):
            continue
        if budget is not None and time.time() - t0 > budget:
            irredundant = False
            break
        calls += 1
        st = still_forced(keep - {v})
        if st == FORCED:
            keep.discard(v)
            irredundant = False          # a removal succeeded, so the sweep must be redone
            say(f"  sweep: -1 -> {len(keep)} points ({time.time() - t0:.0f}s)")
        elif st == UNKNOWN:
            unsettled.append(v)
            irredundant = False
    return Shrunk(sorted(keep), irredundant and not unsettled, unsettled, calls)


# ------------------------------------------------------------------ controls

def self_test() -> None:
    """Every claim this tool makes, with the control that goes red beside it."""
    def expect(got, want, what):
        if got != want:
            raise SystemExit(f"SELF-TEST FAILED — {what}: got {got!r}, wanted {want!r}")
        print(f"  ok  {what}")

    # the rhombus: (0,1),(0,2),(1,2),(1,3),(2,3) — far corners 0 and 3, a distance √3 apart
    rh = [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3)]

    expect(forces(4, rh, 0, 3, 3), FORCED,
           "the rhombus forces its far corners at three colours")
    # the negative partner, and it is the whole reason the colour count is an argument
    expect(forces(4, rh, 0, 3, 4), SEPARATED,
           "and forces nothing at four — a satisfiable instance comes back separated, not forced")
    expect(forces(4, rh, 0, 1, 3), SEPARATED,
           "an adjacent pair is forced apart, never together")

    bb = backbone(4, rh, 0, 3)
    expect((bb.partners(), bb.exact), ([3], True),
           "the backbone from one pivot finds exactly the far corner, and knows it is exact")
    expect(backbone(4, rh, 0, 4).partners(), [],
           "at four colours the same pivot forces nothing")

    # a graph with no colouring at all forces nothing *by this route* and must say so rather than
    # reporting every vertex as forced, which is what a naive UNSAT-means-forced reading would do
    k4 = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3)]
    expect(backbone(4, k4, 0, 3).colourable, False,
           "an uncolourable graph is reported as such, not as forcing everything")

    # the pivot cannot be its own partner
    try:
        forces(4, rh, 2, 2, 3)
        raise SystemExit("SELF-TEST FAILED — a point forced against itself should be refused")
    except ValueError as ex:
        expect("cannot be forced against itself" in str(ex), True,
               "a pair with equal ends is refused by name")

    # an oracle that gave up must never look like a refusal
    b = Backbone(pivot=0, unknown={7})
    expect((b.exact, "NOT EXACT" in b.line()), (False, True),
           "an unsettled backbone says so, loudly, in its own report line")
    expect("NOT EXACT" in Backbone(pivot=0, confirmed={3: 0}).line(), False,
           "and a settled one does not cry wolf")

    # shrinking: the rhombus is already irredundant at three colours
    sh = shrink(4, rh, 0, 3, 3)
    expect((len(sh.keep), sh.irredundant), (4, True),
           "the rhombus is an irredundant forcer — all four points are load-bearing")
    # ...and the word is earned, not asserted: a shrink that could not finish must not claim it
    expect(Shrunk([0, 1], False, [5], 3).irredundant, False,
           "a shrink with an unsettled deletion does not claim irredundance")
    expect("NOT shown irredundant" in Shrunk([0, 1], False, [], 1).line(), True,
           "and its report line says the weaker thing")

    # the spindle filter, both directions
    expect(spindleable(Fraction(3)), True, "a pair √3 apart can be spindled — 4·3−1 = 11")
    expect(spindleable(Fraction(4, 3)), False, "a pair at r² = 4/3 cannot — it would need √39")

    # ---------------------------------------------------------------- fans
    # A **table**, not repeated code, and over the same edge lists Lean uses. Two of the controls
    # written by hand during M14 subplanning were wrong and both read as tool bugs: one indexed a
    # differently-numbered copy of the rhombus and asked about an edge, and one repeated the same
    # colour count on two rows so the four-colour case never ran. A duplicated row is visible as
    # duplicated data; a duplicated call is not.
    #
    # `pendantTriangle` is `Proofs/HadwigerNelson/Fan.lean`'s width-2 witness: a unit triangle with
    # a fourth point hanging off one corner.
    pt = [(0, 1), (0, 2), (1, 2), (0, 3)]

    #  graph  n  pivot  partners   k   expected
    table = [
        (pt, 4, 3, [1, 2], 3, FAN,       "the pendant point matches one of the far corners at three"),
        (pt, 4, 3, [1],    3, SEPARATED, "  ... and neither far corner alone will do"),
        (pt, 4, 3, [2],    3, SEPARATED, "  ... nor the other one"),
        (pt, 4, 3, [1, 2], 4, SEPARATED, "  ... and a fourth colour breaks it entirely"),
        (pt, 4, 3, [],     3, SEPARATED, "an empty fan means uncolourable, and this graph is not"),
        (rh, 4, 0, [3],    3, FAN,       "the rhombus is a width-one fan at three colours"),
        (rh, 4, 0, [3],    4, SEPARATED, "  ... and not at four"),
        (rh, 4, 0, [1],    3, SEPARATED, "a partner adjacent to the pivot is never a fan"),
        (rh, 4, 0, [],     2, FAN,       "an empty fan at two colours: the rhombus is not 2-colourable"),
    ]
    for edges, n, p, Q, k, want, what in table:
        expect(fan(n, edges, p, Q, k), want, what)

    # **The two encodings agree.** `forces` pins two colours; `fan` joins an edge and asks about
    # colourability. They are different formulas for one question, and at width one they must
    # answer alike — the cheapest cross-check this file can carry.
    for k in (3, 4):
        expect(fan(4, rh, 0, [3], k) == FAN, forces(4, rh, 0, 3, k) == FORCED,
               f"`fan` and `forces` agree at width one, {k} colours")

    # The pivot listed among its own partners is trivially true and says nothing, so it is refused
    # by name rather than answered.
    try:
        fan(4, rh, 0, [0, 3], 3)
        raise SystemExit("SELF-TEST FAILED — a pivot inside its own partner list was accepted")
    except ValueError:
        print("  ok  a pivot listed among its own partners is refused by name")

    # The certifying shrink earns its word: three partners in, two out, and nothing unsettled.
    got = shrink_fan(4, pt, 3, [0, 1, 2], 3)
    expect(got.width, 2, "shrink_fan drops the adjacent partner and certifies width two")
    expect(got.irredundant, True, "  ... and says so only after trying every survivor")

    # **An unsettled sweep has no width at all.** A timeout must not become a partner kept "to be
    # safe" — that reports a number the oracle never established. Forced here with a zero budget,
    # because a check nobody has watched fail is not known to work.
    # ... and the same when only the *drop* tests fail to settle, which no real timeout can
    # produce in isolation (a budget small enough to starve a drop also starves the guard). This is
    # the branch a negative control found untested, so it is now driven directly.
    def flaky(n_, e_, p_, Q_, k_, t_):
        return FAN if len(Q_) == 3 else UNKNOWN
    mid = shrink_fan(4, pt, 3, [0, 1, 2], 3, oracle=flaky)
    expect(mid.unsettled, [0, 1, 2], "an unsettled *drop* is recorded, never read as a refusal")
    expect(mid.width, None, "  ... so the sweep reports no width")

    starved = shrink_fan(4, pt, 3, [0, 1, 2], 3, timeout=1e-9)
    expect(starved.width, None, "a starved shrink_fan reports no width, rather than a large one")
    expect(starved.irredundant, False, "  ... and does not claim irredundance")
    expect("not a width" in starved.line(), True,
           "  ... and its report line says so where a reader will see it")

    # ---------------------------------------------------------------- the identity, as a filter
    # M15's finding, checked as **two formulas for one question** on the graphs Lean has committed:
    # asking for a fan by joining the pivot to everything, and asking whether the pivot is removable.
    # They must agree on every row, and they must agree at both colour counts, or the identity the
    # certificate rests on is not the one this tool computes.
    #
    #  graph  n  pivot   k   removable?
    ident = [
        (rh, 4, 0, 3, REMOVABLE, "the rhombus's far corner is removable at three colours"),
        (rh, 4, 3, 3, REMOVABLE, "  ... and so is the other one"),
        (rh, 4, 1, 3, CRITICAL,  "a corner of the shared edge is not — delete it and two colours do"),
        (rh, 4, 2, 3, CRITICAL,  "  ... nor the other one"),
        (pt, 4, 3, 3, REMOVABLE, "the pendant point is removable: the triangle needs three without it"),
        (pt, 4, 0, 3, CRITICAL,  "the corner it hangs from is not"),
        (rh, 4, 0, 4, CRITICAL,  "at four colours nothing is removable — the graph is 3-chromatic"),
    ]
    for edges, n, p, k, want, what in ident:
        expect(removable(n, edges, p, k), want, what)

    # And the two formulas cross-checked directly: `removable` must answer exactly as the widest
    # possible fan does. This is the control that would catch the identity being mis-implemented in
    # a way every hand-written row above happened to agree with.
    for edges, n, k in ((rh, 4, 3), (pt, 4, 3), (rh, 4, 4), (pt, 4, 4)):
        for p in range(n):
            widest = fan(n, edges, p, [q for q in range(n) if q != p], k)
            expect(removable(n, edges, p, k), REMOVABLE if widest == FAN else CRITICAL,
                   f"widest fan and removability agree at pivot {p}, k={k}, {len(edges)} edges")

    # The summary line must carry the unsettled count even when the news is good, and must never
    # read as a verdict about the graph when it is not one.
    good = filter_pivots(4, pt, 3)
    expect("unsettled" in good.line(), True, "the filter's line always states the unsettled count")
    starved = Filtered(4, [], [1, 2])
    expect("this is not a verdict about the graph" in starved.line(), True,
           "an unsettled sweep refuses to read as a verdict")
    expect(Filtered(4, [], []).line().endswith("at any width"), True,
           "a settled empty sweep is allowed to say so")

    print("self-test: OK")


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--graph", type=Path, help="a graph JSON with n/edges")
    ap.add_argument("--pivot", type=int)
    ap.add_argument("--colours", type=int, default=4)
    ap.add_argument("--timeout", type=float, default=None)
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return
    if args.graph is None or args.pivot is None:
        ap.error("nothing to do — try --self-test, or --graph G --pivot V")

    d = json.load(open(args.graph))
    n = int(d["n"]) if "n" in d else len(d["coords"])
    edges = [(int(a), int(b)) for a, b in d["edges"]]
    bb = backbone(n, edges, args.pivot, args.colours, args.timeout)
    print(bb.line())


if __name__ == "__main__":
    main()
