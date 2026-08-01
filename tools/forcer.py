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
