#!/usr/bin/env python3
"""Min-coverage: the distance-to-confinement gradient — M18's instrument.

UNTRUSTED, like everything in `tools/`. A `minCov = k` here is a *triage* result — it becomes a
claim only through the kernel (LRAT certificate, `Fan.of_unsat`); every other value is a tool
observation. A bug here can cost a theorem and can never buy one.

## The statement this measures

For a pivot `p` with `p ∉ C` (a distance class never contains its own pivot):

    Fan(G, k, p, C)  ⟺  every proper k-colouring puts all k colours on N(p) ∪ C

— the Lean side is `fan_iff_coverage` (`Proofs/HadwigerNelson/Coverage.lean`). So

    minCov(p, C) := min over proper k-colourings φ of |φ(N(p) ∪ C)|

is the *distance to confinement*: `minCov = k` is CONFINED, and `k − minCov` is how many colours
a construction still has to force onto the pivot's neighbourhood and class. This is the gradient
M17's binary separated/confined verdicts could not see.

## Why one SAT call per level

`base_clauses` is colour-symmetric — permuting colour indices is a bijection on proper
colourings — so "some `t` colours all miss `N(p) ∪ C`" is satisfiable iff "the *last* `t`
colours all miss it" is: one call with `t·|N(p)∪C|` forbidding unit clauses. Levels are monotone
(a model missing `t` colours misses `t − 1` of them), so the answer is a threshold:
`minCov = k − t*` with `t*` the largest satisfiable level. A level the budget cuts is UNKNOWN
and widens the reported bounds pair; it is never folded into either side. Every upper bound is
witnessed by a concrete colouring the tool re-checks; the lower bound trusts the solver's UNSAT,
which is exactly the trust the kernel route replaces if the number is ever promoted to a claim.

    python3 tools/coverage.py --self-test
    python3 tools/coverage.py --ledger-name Z3-closure-dg630x1/3 --r2 1/3
    python3 tools/coverage.py --ledger-name Z3-closure-dg630x1/3 --r2 1/3 --all-pivots
"""

from __future__ import annotations

import argparse
import json
import sys
import time
from collections import Counter
from dataclasses import dataclass, field as dc_field
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import construct as C  # noqa: E402
from coloring import base_clauses, var  # noqa: E402
from field import distsq, mul_table  # noqa: E402
from forcer import _solve  # noqa: E402
from narrow import classes_at, colour_of, is_rational  # noqa: E402
from rescan import interpret, ledger_read  # noqa: E402

TAB = mul_table()


# ------------------------------------------------------------------ the measurement

@dataclass
class MinCov:
    """One (pivot, class)'s answer as an honest bounds pair `lo ≤ minCov ≤ hi`.

    `hi` is always witnessed by a colouring in the pool that the tool re-verified; `lo` rests on
    solver UNSATs. `levels[t]` records each level actually solved. Exact iff the bounds meet;
    an UNKNOWN level leaves them apart and the line says so rather than concluding."""
    pivot: int
    n_cover: int
    k: int
    lo: int
    hi: int
    levels: dict[int, str]
    calls: int
    elapsed: float
    deferred: list[int] = dc_field(default_factory=list)

    def exact(self) -> bool:
        return self.lo == self.hi

    def line(self) -> str:
        if self.exact():
            tag = " ** CONFINED — coverage is total **" if self.hi == self.k else ""
            return (f"pivot {self.pivot}: minCov = {self.hi} of {self.k} "
                    f"(|N(p)∪C| = {self.n_cover}, {self.calls} calls, "
                    f"{self.elapsed:.1f}s){tag}")
        return (f"pivot {self.pivot}: minCov IN [{self.lo}, {self.hi}] of {self.k} — "
                f"NOT exact: budget cut level(s) {self.deferred}; no verdict at this pivot "
                f"(|N(p)∪C| = {self.n_cover}, {self.calls} calls, {self.elapsed:.1f}s)")


def cover_set(edges, p: int, Cls: list[int]) -> list[int]:
    """`N(p) ∪ C`, the set whose colour count is measured. Refuses the degenerate inputs by
    name rather than measuring nonsense."""
    if p in Cls:
        raise ValueError(f"pivot {p} listed in its own class — a class never contains its "
                         f"pivot (distance 0 is not a distance class)")
    nbr = {b if a == p else a for a, b in edges if a == p or b == p}
    cov = sorted(nbr | set(Cls))
    if p in cov:
        raise ValueError(f"pivot {p} adjacent to itself — the edge list carries a loop")
    if not cov:
        raise ValueError(f"pivot {p} has empty N(p) ∪ C — nothing to measure")
    return cov


def min_coverage(n: int, edges, p: int, Cls: list[int], k: int,
                 budget: float | None = 300.0, pool: list | None = None,
                 solve=None) -> MinCov:
    """Walk the forbidden-colour levels upward from the pool's witnessed bound.

    `pool` is shared and grown in place, exactly as in the M17 sweep: every model found here is
    a proper colouring of the same graph and serves every later (pivot, class) as a free upper
    bound."""
    do_solve = solve if solve is not None else _solve
    cov = cover_set(edges, p, Cls)
    if pool is None:
        pool = []
    mc = MinCov(pivot=p, n_cover=len(cov), k=k, lo=1, hi=k, levels={}, calls=0, elapsed=0.0)
    t0 = time.time()
    for m in pool:
        mc.hi = min(mc.hi, len({m[v] for v in cov}))
    # level t: forbid the last t colours on the cover set; sat ⟺ minCov ≤ k − t
    for t in range(k - mc.hi + 1, k):
        clauses = base_clauses(n, edges, k) + \
            [[-var(v, c, k)] for v in cov for c in range(k - t, k)]
        st, model = do_solve(clauses, k * n, budget)
        mc.calls += 1
        mc.levels[t] = st
        if st == "sat":
            colours = {v: colour_of(model, v, k) for v in range(n)}
            assert all(colours[a] != colours[b] for a, b in edges if a != b), \
                "level model is improper on the committed edges — encoding bug"
            assert all(colours[v] < k - t for v in cov), \
                "level model uses a forbidden colour on N(p)∪C — encoding bug"
            pool.append(colours)
            mc.hi = k - t
        elif st == "unsat":
            mc.lo = k - t + 1
            break  # monotone: every higher level is unsat too
        else:
            mc.deferred.append(t)
    if not mc.deferred and mc.hi < mc.lo:
        raise AssertionError(f"bounds crossed at pivot {p}: hi {mc.hi} < lo {mc.lo} — "
                             f"solver monotonicity violated, tool bug")
    if not mc.deferred:
        mc.lo = mc.hi  # walk ran to its threshold: every level below hi's is witnessed sat
    # every exact answer holds a witness: some pool colouring achieves exactly hi colours
    if mc.exact():
        assert any(len({m[v] for v in cov}) == mc.hi for m in pool) or mc.hi == k, \
            "exact minCov lacks a witnessing colouring — tool bug"
    mc.elapsed = time.time() - t0
    return mc


# ------------------------------------------------------------------ candidates by ledger name

def by_ledger_name(name: str) -> tuple[dict, C.Config]:
    led = ledger_read()
    for rec in led.values():
        if rec.get("name") == name and "error" not in rec:
            return rec, interpret(rec["recipe"])
    raise SystemExit(f"no ledger record named '{name}' — check tools/hunt_ledger.jsonl")


def locate_key(cfg: C.Config, key, denom_of_key: int) -> int:
    """A recipe pivot key names raw integers at *its* graph's denominator; re-locate the same
    plane point in `cfg` rationally (the H5 seam, `rescan.family_h5`)."""
    want = tuple(Fraction(x, denom_of_key) for x in key[0]) + \
           tuple(Fraction(y, denom_of_key) for y in key[1])
    for i in range(len(cfg)):
        got = tuple(Fraction(x, cfg.denom) for x in cfg.pts[i][0]) + \
              tuple(Fraction(y, cfg.denom) for y in cfg.pts[i][1])
        if got == want:
            return i
    raise ValueError("pivot key names no point of this configuration")


def class_of(coords, denom: int, p: int, r2: Fraction) -> list[int]:
    cl = classes_at(coords, p)
    for kk, Q in cl.items():
        if is_rational(kk) and Fraction(kk[0], denom * denom) == r2:
            return Q
    raise ValueError(f"pivot {p} has no class at r² = {r2}")


# ------------------------------------------------------------------ self-test

def self_test() -> None:
    """Every reading driven to its trigger; every guard watched refusing."""
    # rainbow control: K3 plus an isolated pivot, class = the triangle. Any proper colouring
    # paints a triangle with 3 colours and a 4th is never forced: minCov = 3 exactly.
    tri = [(0, 1), (0, 2), (1, 2)]
    mc = min_coverage(4, tri, 3, [0, 1, 2], 4, budget=60.0)
    assert mc.exact() and mc.hi == 3, mc.line()
    assert "CONFINED" not in mc.line()

    # floor control: a single-member class, nothing else in sight: minCov = 1.
    mc1 = min_coverage(4, tri, 3, [0], 4, budget=60.0)
    assert mc1.exact() and mc1.hi == 1, mc1.line()

    # confined control (the known hit): de Grey's 397-point configuration at four colours
    # confines the r² = 4 class at the origin (M14/M17). Coverage there must be total.
    cfg = C.orbit(C.degrey_seed(), C.hex12())
    coords = [(tuple(a), tuple(b)) for a, b in cfg.pts]
    E, origin = cfg.edges(), C.index_of(cfg, Fraction(0), Fraction(0))
    Q4cls = class_of(coords, cfg.denom, origin, Fraction(4))
    assert len(Q4cls) == 6, "the known hit's class lost members"
    mck = min_coverage(len(coords), E, origin, Q4cls, 4, budget=300.0)
    assert mck.exact() and mck.hi == 4 and "CONFINED" in mck.line(), mck.line()

    # separated control, same graph: the r² = 1 class at the origin IS N(p), and the sweep
    # separates it, so coverage must fall short of total.
    Q1cls = class_of(coords, cfg.denom, origin, Fraction(1))
    mcs = min_coverage(len(coords), E, origin, Q1cls, 4, budget=300.0)
    assert mcs.exact() and mcs.hi < 4, mcs.line()

    # a never-answering oracle leaves honest bounds and refuses a verdict
    mcu = min_coverage(4, tri, 3, [0, 1, 2], 4, solve=lambda *_: ("unknown", None))
    assert not mcu.exact() and "no verdict" in mcu.line() and "minCov =" not in mcu.line()

    # an oracle handing back an improper model is caught by the witness re-check
    bad_model = {var(v, 0, 4) for v in range(4)}  # everything colour 0 — improper on K3
    try:
        min_coverage(4, tri, 3, [0, 1, 2], 4, solve=lambda *_: ("sat", bad_model))
        raise SystemExit("SELF-TEST FAILED — an improper model should have been refused")
    except AssertionError as ex:
        assert "improper" in str(ex)

    # degenerate inputs are refused by name
    for args, msg in [((4, tri, 0, [0, 1], 4), "its own class"),
                      ((4, tri, 3, [], 4), "nothing to measure")]:
        try:
            min_coverage(*args)
            raise SystemExit(f"SELF-TEST FAILED — {args} should have been refused")
        except ValueError as ex:
            assert msg in str(ex), f"refusal lost its name: {ex}"

    # the pool is a real accelerator and stays honest: seeding with the k-colouring found
    # above must not change the rainbow answer, only the calls
    pool = [{v: c for v, c in enumerate([0, 1, 2, 3])}]
    mcp = min_coverage(4, tri, 3, [0, 1, 2], 4, budget=60.0, pool=pool)
    assert mcp.exact() and mcp.hi == 3, mcp.line()

    print("coverage.py self-test OK")


# ------------------------------------------------------------------ main

def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--ledger-name", help="candidate by its hunt_ledger name")
    ap.add_argument("--r2", default="1/3", help="the class, as an exact rational r²")
    ap.add_argument("--pivot", type=int, help="pivot index; default: the recipe's doubling pivot")
    ap.add_argument("--all-pivots", action="store_true",
                    help="pool-bounded coverage distribution across every pivot, SAT-exact "
                         "only where the pool bound stays at k−1 or above")
    ap.add_argument("--colours", type=int, default=5)
    ap.add_argument("--budget", type=float, default=300.0)
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return
    if not args.ledger_name:
        ap.error("nothing to do — try --self-test or --ledger-name")

    rec, cfg = by_ledger_name(args.ledger_name)
    coords = [(tuple(a), tuple(b)) for a, b in cfg.pts]
    n, E, k, r2 = len(coords), cfg.edges(), args.colours, Fraction(args.r2)
    print(f"{args.ledger_name}: {n} pts, {len(E)} edges, k = {k}, class r² = {r2}")

    if args.pivot is not None:
        pivots = [args.pivot]
    else:
        r = rec["recipe"]
        if r.get("op") != "double":
            ap.error("--pivot required: recipe is not a double, so no doubling pivot to default to")
        inner_denom = interpret(r["of"]).denom
        pivots = [locate_key(cfg, r["pivot"], inner_denom)]
        print(f"doubling pivot re-located at index {pivots[0]}")

    pool: list = []
    if args.all_pivots:
        # phase 1: exact answers at the named pivots seed the pool; phase 2: pool bounds
        # everywhere, SAT-exact only where the bound stays within one colour of total
        for p in pivots:
            mc = min_coverage(n, E, p, class_of(coords, cfg.denom, p, r2), k,
                              args.budget, pool)
            print(mc.line(), flush=True)
        covs: dict[int, list[int]] = {}
        t0 = time.time()
        for p in range(n):
            try:
                covs[p] = cover_set(E, p, class_of(coords, cfg.denom, p, r2))
            except ValueError:
                continue  # a pivot with no class at this r² is out of scope, not a zero
        high = [p for p, cov in covs.items()
                if min((len({m[v] for v in cov}) for m in pool), default=k) >= k - 1]
        print(f"{len(covs)} pivots carry an r²={r2} class ({time.time() - t0:.0f}s); "
              f"{len(high)} at initial pool bound ≥ {k - 1} get exact SAT walks:", flush=True)
        for p in high:
            cov = pcov = covs[p]
            if min((len({m[v] for v in pcov}) for m in pool), default=k) < k - 1:
                continue  # a walk earlier in this loop grew the pool past this pivot
            mc = min_coverage(n, E, p, class_of(coords, cfg.denom, p, r2), k,
                              args.budget, pool)
            print("  " + mc.line(), flush=True)
        hist: Counter = Counter()
        for p, cov in covs.items():
            hist[min((len({m[v] for v in cov}) for m in pool), default=k)] += 1
        print(f"final pool ({len(pool)} colourings) upper-bound histogram over "
              f"{sum(hist.values())} pivots: {dict(sorted(hist.items()))}")
    else:
        for p in pivots:
            mc = min_coverage(n, E, p, class_of(coords, cfg.denom, p, r2), k,
                              args.budget, pool)
            print(mc.line(), flush=True)


if __name__ == "__main__":
    main()
