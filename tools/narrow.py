#!/usr/bin/env python3
"""Does any fan confine to a single distance class? The M16 narrowing sweep.

UNTRUSTED, like everything in `tools/`. A pivot this tool calls narrow becomes a theorem only
through a kernel-checked refutation; a pivot it calls not-narrow becomes one only through
`Proofs/HadwigerNelson/NarrowFan.lean`'s certificate — explicit separating colourings the kernel
re-verifies against the committed edge list. A bug here can cost a theorem and can never buy one.

## The sweep, and why it is cheap

A *fan* at pivot `p` over partners `Q` holds when every proper `k`-colouring paints `p` like some
member of `Q`; the closing move needs the fan confined to vertices at ONE real distance from `p`.
Testing a class is one SAT call on the joined graph — and the model that call returns is a proper
colouring that separates `p` from every class whose members all miss `p`'s colour. **One colouring
rejects most classes at once** (measured 81% on de Grey's graph), so the pool of models replaces
almost every solver call: the full 1,340-class sweep of one de Grey pivot is ~8 calls and ~0.4 s.

## The triage rule, and what the presumption may never do

Every solve gets a budget. A solve that does not answer is **DEFERRED** — logged with everything
needed to rebuild it, never folded into either answer. The per-pivot report line is
self-auditing: `classes = pool + separated + confined + DEFERRED` by construction, the deferred
count prints unconditionally, and a nonzero deferred count downgrades the verdict to NO VERDICT.

    python3 tools/narrow.py --self-test
    python3 tools/narrow.py --cert degrey_cert --pivot 630 --colours 5
"""

from __future__ import annotations

import argparse
import json
import sys
import time
from dataclasses import dataclass, field as dc_field
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from coloring import base_clauses, var  # noqa: E402
from field import mul_table, distsq, spindle_available  # noqa: E402
from forcer import _solve, fanEdges  # noqa: E402

TAB = mul_table()


# ------------------------------------------------------------------ classes

def classes_at(coords, p: int):
    """The non-pivot vertices grouped by exact squared distance to `p`, as a dict from the
    16-component field value (scaled by denom²) to the member list."""
    cl: dict[tuple, list[int]] = {}
    for v in range(len(coords)):
        if v != p:
            cl.setdefault(tuple(distsq(coords[p], coords[v], TAB)), []).append(v)
    return cl


def is_rational(key: tuple) -> bool:
    return all(x == 0 for x in key[1:])


# ------------------------------------------------------------------ the sweep

@dataclass
class Sweep:
    """One pivot's answer, every category carried so the report line can be self-auditing.

    `confined` are UNSAT classes — a fan confined to that class. `deferred` are solves the budget
    cut: **presumed expensive, never presumed answered.** The verdict is a property of the counts,
    not a field anybody sets: it downgrades to NO VERDICT whenever `deferred` is nonempty."""
    pivot: int
    n_classes: int
    pool_rejected: int
    separated: list[tuple]
    confined: list[tuple[tuple, list[int]]]
    deferred: list[tuple[tuple, list[int], float]]
    models: list[dict[int, int]]
    calls: int
    elapsed: float
    #: the classes that resisted the pool and needed their own solver call, with the answer —
    #: the sweep's own tightness gradient (M17: the resisting histogram feeds the hunt's H5).
    called: list = dc_field(default_factory=list)

    def line(self) -> str:
        cats = self.pool_rejected + len(self.separated) + len(self.confined) + len(self.deferred)
        audit = "" if cats == self.n_classes else \
            f"  ** CATEGORY LEAK: {cats} != {self.n_classes} classes — tool bug **"
        head = (f"pivot {self.pivot}: {self.n_classes} classes = "
                f"{self.pool_rejected} pool-rejected + {len(self.separated)} separated + "
                f"{len(self.confined)} confined + {len(self.deferred)} DEFERRED "
                f"({self.calls} solver calls, {self.elapsed:.1f}s){audit}")
        if self.deferred:
            return head + "\n  NO VERDICT for this pivot: budget cut "\
                f"{len(self.deferred)} solves; run the deferred log at full budget first"
        if self.confined:
            return head + "\n  ** FAN CONFINED at this pivot — the narrowing target exists **"
        return head + "\n  no fan at this pivot is confined to any single distance class"


def colour_of(model: set[int], v: int, k: int) -> int:
    for c in range(k):
        if var(v, c, k) in model:
            return c
    raise AssertionError(f"vertex {v} carries no colour in the model")


def sweep_pivot(n, edges, coords, p: int, k: int, budget: float | None = 300.0,
                solve=None, pool: list | None = None) -> Sweep:
    """Test every distance class at `p`, biggest spindle-able first, pool-rejecting between
    solver calls. `solve` is injectable for the never-answering-oracle control. `pool` is
    **shared and grown in place** when supplied — M17's all-pivots sweep passes one pool across
    every pivot of a candidate, since a separating colouring separates at every pivot at once."""
    do_solve = solve if solve is not None else _solve
    cl = classes_at(coords, p)
    keys = sorted(cl.keys(), key=lambda kk: (0 if is_rational(kk) else 1, -len(cl[kk])))
    if pool is None:
        pool = []
    sw = Sweep(pivot=p, n_classes=len(cl), pool_rejected=0, separated=[], confined=[],
               deferred=[], models=pool, calls=0, elapsed=0.0)
    t0 = time.time()
    for kk in keys:
        Q = cl[kk]
        if any(all(m[v] != m[p] for v in Q) for m in pool):
            sw.pool_rejected += 1
            continue
        t1 = time.time()
        st, model = do_solve(base_clauses(n, fanEdges(edges, p, Q), k), k * n, budget)
        sw.calls += 1
        sw.called.append((kk, st))
        if st == "sat":
            colours = {v: colour_of(model, v, k) for v in range(n)}
            assert all(colours[a] != colours[b] for a, b in edges if a != b), \
                "solver model is improper on the committed edges — encoding bug"
            assert all(colours[v] != colours[p] for v in Q), \
                "solver model does not separate the class it was solved for — encoding bug"
            pool.append(colours)
            sw.separated.append(kk)
        elif st == "unsat":
            sw.confined.append((kk, Q))
        else:
            sw.deferred.append((kk, Q, time.time() - t1))
    sw.elapsed = time.time() - t0
    return sw


# ------------------------------------------------------------------ self-test

def self_test() -> None:
    import construct as C

    # The known-hit control: de Grey's own 397-point opening configuration at four colours has
    # exactly one confined fan — the r² = 4 class at the origin (M14 § 0(b): width 3, and the
    # full class is 6). A sweep that cannot report a hit reports nothing.
    cfg = C.orbit(C.degrey_seed(), C.motion_group(C.hex12()))
    E, N = cfg.edges(), len(cfg.pts)
    origin = C.index_of(cfg, Fraction(0), Fraction(0))
    sw = sweep_pivot(N, E, cfg.pts, origin, 4)
    assert not sw.deferred, "control solves must settle"
    assert len(sw.confined) == 1, f"want exactly one confined class, got {len(sw.confined)}"
    key, Q = sw.confined[0]
    assert is_rational(key) and Fraction(key[0], cfg.denom ** 2) == 4, "the hit is not r² = 4"
    assert len(Q) == 6, f"the r² = 4 class at the origin has 6 members, got {len(Q)}"
    assert "FAN CONFINED" in sw.line()
    assert sw.pool_rejected + len(sw.separated) + len(sw.confined) == sw.n_classes

    # The never-answering oracle: every solve deferred, and the line refuses a verdict rather
    # than reporting "no fan found". The branch is unreachable with a real solver and a sane
    # budget, which is exactly why it is driven through an injected one (M14's lesson).
    sw2 = sweep_pivot(N, E, cfg.pts, origin, 4, solve=lambda *_: ("unknown", None))
    assert sw2.calls == sw2.n_classes and len(sw2.deferred) == sw2.n_classes
    assert "NO VERDICT" in sw2.line() and "DEFERRED" in sw2.line()
    assert "no fan at this pivot" not in sw2.line()

    # The category audit goes loud when a count is dropped on purpose.
    sw2.pool_rejected -= 1
    assert "CATEGORY LEAK" in sw2.line()
    sw2.pool_rejected += 1

    # Spindle-ability is decided by field.py and only rational classes qualify. r² = 4/3 is
    # M12's committed refusal (it would need √39 adjoined).
    assert spindle_available(Fraction(1))
    assert not spindle_available(Fraction(4, 3))

    print("narrow.py self-test OK")


# ------------------------------------------------------------------ main

def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--cert", help="certificate JSON under tools/ (e.g. degrey_cert)")
    ap.add_argument("--pivot", type=int, action="append", default=[])
    ap.add_argument("--colours", type=int, default=5)
    ap.add_argument("--budget", type=float, default=300.0)
    args = ap.parse_args()

    if args.self_test:
        self_test()
        return

    d = json.load(open(Path(__file__).resolve().parent / f"{args.cert}.json"))
    coords = [(tuple(c[0]), tuple(c[1])) for c in d["coords"]]
    edges = [tuple(e) for e in d["edges"]]
    for p in args.pivot:
        sw = sweep_pivot(len(coords), edges, coords, p, args.colours, args.budget)
        print(sw.line())
        for kk, Q, cut in sw.deferred:
            r2 = Fraction(kk[0], d["denom"] ** 2) if is_rational(kk) else "irrational"
            print(f"  DEFERRED r²={r2} |Q|={len(Q)} cut at {cut:.0f}s — "
                  f"pivot {p}, colours {args.colours}, cert {args.cert}")


if __name__ == "__main__":
    main()
