#!/usr/bin/env python3
"""The search: shrink a rich universe toward a minimal forcer.

UNTRUSTED, like everything in `tools/`. What it proposes is certified in Lean or it is nothing.

## Why this shape and not the obvious one

M12's blind search *grew* configurations from seeds and exhausted at 1,961 graphs without reaching
five colours. M13 subplanning measured why growing cannot work here: **all 39 of de Grey's seed
points are irredundant** — drop any one and the forcing dies — so every proper subset of the answer
scores exactly zero and the objective is flat everywhere except at the answer itself. There is no
gradient to climb.

Shrinking has one. Every successful deletion is progress, every refusal is information, and the same
oracle answers both. It is also how Polymath16 went from de Grey's 1581 points to 553 to 510.

    python3 tools/hunt.py --shrink-degrey --colours 4 --budget 3600
    python3 tools/hunt.py --universe --colours 4 --budget 1800
"""

from __future__ import annotations

import argparse
import json
import sys
import time
from fractions import Fraction
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import construct as C  # noqa: E402
from forcer import FORCED, backbone, forces, shrink, spindleable  # noqa: E402


def report_universe(name: str, cfg: C.Config, k: int, budget: float, timeout: float | None) -> list:
    """Every forced pair at a spindle-able distance, with what was left unsettled.

    Prints the unsettled count whether or not it is zero: an empty answer only means "nothing is
    forced" when the oracle settled every question it was asked.
    """
    n = len(cfg)
    edges = cfg.edges()
    print(f"\n=== {name}: {n} points, {len(edges)} edges, {k} colours ===", flush=True)
    t0 = time.time()
    wins, unsettled_pivots, checked = [], 0, 0
    for p in range(n):
        if time.time() - t0 > budget:
            print(f"  budget spent after {checked} of {n} pivots", flush=True)
            break
        bb = backbone(n, edges, p, k, timeout, budget=timeout)
        checked += 1
        if not bb.exact:
            unsettled_pivots += 1
        if not bb.colourable:
            print(f"  {name} has no {k}-colouring at all — refute it directly, "
                  f"there is nothing to force", flush=True)
            return []
        for q in bb.partners():
            r2 = cfg.distsq_rational(p, q)
            tag = "SPINDLE-ABLE" if (r2 is not None and spindleable(r2)) else "not closable"
            print(f"  FORCED {p}->{q}  r^2={r2}  {tag}", flush=True)
            if r2 is not None and spindleable(r2):
                wins.append((p, q, r2))
    print(f"  {len(wins)} closable forced pairs from {checked} pivots, "
          f"{unsettled_pivots} pivots unsettled, {time.time()-t0:.0f}s", flush=True)
    if unsettled_pivots and not wins:
        print("  ** the empty answer is NOT a negative result: "
              f"{unsettled_pivots} pivots were not settled **", flush=True)
    return wins


def shrink_degrey(k: int, budget: float, timeout: float | None) -> None:
    """How small can de Grey's own forcer get while still forcing its pair?

    This is the tightness threshold measured from above, and its output is directly useful: a forcer
    of `m` points spindles into a `2m−1`-point 5-chromatic graph.
    """
    sa = C.orbit(C.degrey_seed(), C.hex12())
    cfg = C.spindle(sa, C.index_of(sa, 0, 0), C.index_of(sa, 2, 0))
    p, q = C.index_of(cfg, -2, 0), C.index_of(cfg, 2, 0)
    edges = cfg.edges()
    print(f"forcer before shrinking: {len(cfg)} points, {len(edges)} edges, "
          f"pair ({p},{q}) at r^2={cfg.distsq_rational(p, q)}", flush=True)
    st = forces(len(cfg), edges, p, q, k, timeout)
    print(f"  the pair is {st} at {k} colours", flush=True)
    if st != FORCED:
        return
    t0 = time.time()
    out = shrink(len(cfg), edges, p, q, k, timeout=timeout, budget=budget,
                 log=lambda m: print(m, flush=True))
    print(f"\nSHRUNK: {out.line()}  ({time.time()-t0:.0f}s)", flush=True)
    print(f"  spindling it would give a {2*len(out.keep)-1}-point 5-chromatic graph "
          f"(de Grey's is 1581; Polymath16's smallest is 509)", flush=True)
    json.dump({"keep": out.keep, "irredundant": out.irredundant,
               "unsettled": out.unsettled, "pair": [p, q]},
              open("build/forcer-shrunk.json", "w"))


def universe(k: int, budget: float, timeout: float | None) -> None:
    """Does anything the primitives reach — *without* de Grey's seed set — force a pair?

    The honest calibration, and the move ORDER is the whole lesson. Orbiting a lattice seed under
    the hexagonal group gives the 7-point patch and nothing else, because the tool's seeds — unit
    edge, triangle, rhombus — all live in the unit triangular lattice, and the `r² = 1` spindle *is*
    a 60° rotation the patch is already closed under. Measured: every such universe is 7 points.

    So spindle **first**, which is what leaves the lattice (the Moser spindle's `√11` coordinates are
    not lattice points), and orbit after. `orbit(moser spindle, hex12)` is 43 points and 108 edges.
    """
    frontier = [("rhombus", C.rhombus())]
    seen, level, t0 = set(), 0, time.time()
    while frontier and time.time() - t0 < budget and level < 4:
        level += 1
        nxt = []
        for name, cfg in frontier:
            n = len(cfg)
            for a in range(min(n, 8)):
                for b in range(n):
                    if a == b or time.time() - t0 > budget:
                        continue
                    r2 = cfg.distsq_rational(b, a)
                    if r2 is None or not spindleable(r2):
                        continue
                    try:
                        kid = C.orbit(C.spindle(cfg, a, b), C.hex12())
                    except ValueError:
                        continue
                    if len(kid) > 700 or len(kid) in seen:
                        continue
                    seen.add(len(kid))
                    label = f"orbit(spindle({name},{a},{b}) r^2={r2}, hex12)"
                    if report_universe(label, kid, k, budget, timeout):
                        print(f"\n*** A CLOSABLE FORCED PAIR: {label} ***", flush=True)
                        return
                    nxt.append((f"{name}+s{a}.{b}+o", kid))
        frontier = sorted(nxt, key=lambda t: len(t[1]))[:3]
        print(f"--- level {level}: {len(seen)} universes examined, frontier {len(frontier)}, "
              f"{time.time()-t0:.0f}s ---", flush=True)
    print(f"\n=== NO closable forced pair in {len(seen)} universes, {time.time()-t0:.0f}s ===",
          flush=True)


def six(budget: float, timeout: float | None) -> None:
    """The hunt at five colours, led by M15's filter.

    The route to six, by analogy with the one that reached five: find a **fan** at a pivot -- every
    proper 5-colouring paints it like one of a handful of partners -- narrow it to width one, and
    spindle. M15's identity says a fan sits at `p` exactly when `p` is removable, so the existence
    question is a *four*-colour one and costs a second.

    Where the candidates come from. A fan needs a removable vertex, and all three of this project's
    five-chromatic witnesses are five-vertex-critical -- measured, and now proved for two of them --
    so nothing we hold carries one. The cheapest configuration that does is **two copies of a
    witness sharing a vertex**: every vertex of one copy is removable, because the other copy still
    refutes four colours on its own. Fans are therefore free there, and **narrowness is the entire
    problem** -- which is the same thing M14 found at four colours.

    What would count as a win: a fan of width one at a spindle-able distance, or width two with the
    partners diametrically opposite the pivot at r^2 = 1/2. Anything wider cannot be closed -- two
    unit circles meet twice.
    """
    import json
    from forcer import CRITICAL, REMOVABLE, UNKNOWN, fan, removable, shrink_fan, spindleable

    src = Path(__file__).resolve().parent / "heule510.json"
    d = json.load(open(src))
    base = C.Config([(c[0], c[1]) for c in d["coords"]], d["denom"])
    print(f"=== the hunt at five colours ===\nbase: Heule's 510-point witness, "
          f"{len(base.edges())} unit edges, five-chromatic and five-vertex-CRITICAL "
          f"(so it carries no fan itself -- proved in Lean)", flush=True)

    t0 = time.time()
    # every spindle-able distance from vertex 0, as the seam to glue a second copy at
    seams = []
    for q in range(1, len(base)):
        r2 = base.distsq_rational(0, q)
        if r2 is not None and spindleable(r2) and r2 != 0:
            seams.append((r2, q))
    seams.sort()
    print(f"{len(seams)} spindle-able seams from vertex 0", flush=True)

    examined = 0
    for r2, q in seams:
        if time.time() - t0 > budget:
            print(f"  budget spent after {examined} candidates", flush=True)
            break
        cand = C.spindle(base, 0, q)
        n, edges = len(cand), cand.edges()
        examined += 1
        # the added copy's vertices are removable by construction; confirm on one, then narrow
        newv = [v for v in range(len(base), n)]
        if not newv:
            continue
        p = newv[0]
        st = removable(n, edges, p, 5, timeout)
        print(f"  spindle at r^2={r2} -> {n} pts, {len(edges)} edges; pivot {p}: {st}", flush=True)
        if st != REMOVABLE:
            continue
        # narrow: one distance class at a time, at FIVE colours
        adj = set(edges) | {(b, a) for (a, b) in edges}
        by = {}
        for u in range(n):
            if u == p or (p, u) in adj:
                continue
            s2 = cand.distsq_rational(p, u)
            if s2 is None or not spindleable(s2):
                continue
            by.setdefault(s2, []).append(u)
        hits = 0
        for s2, Q in sorted(by.items(), key=lambda t: len(t[1])):
            if fan(n, edges, p, Q, 5, timeout) != "fan":
                continue
            hits += 1
            got = shrink_fan(n, edges, p, Q, 5, timeout)
            print(f"    *** r^2={s2}, |Q|={len(Q)}: {got.line()}", flush=True)
        if not hits:
            print(f"    no fan at any of {len(by)} spindle-able classes -- "
                  f"the fan at this pivot is wider than any single distance", flush=True)

    print(f"\n=== {examined} candidates examined in {time.time()-t0:.0f}s. "
          f"No closable five-colour fan found. ===", flush=True)


def main() -> None:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--shrink-degrey", action="store_true")
    ap.add_argument("--universe", action="store_true")
    ap.add_argument("--six", action="store_true")
    ap.add_argument("--colours", type=int, default=4)
    ap.add_argument("--budget", type=float, default=1800.0)
    ap.add_argument("--timeout", type=float, default=120.0)
    args = ap.parse_args()
    Path("build").mkdir(exist_ok=True)
    if args.shrink_degrey:
        shrink_degrey(args.colours, args.budget, args.timeout)
    elif args.universe:
        universe(args.colours, args.budget, args.timeout)
    elif args.six:
        six(args.budget, args.timeout)
    else:
        ap.error("nothing to do — try --shrink-degrey or --universe")


if __name__ == "__main__":
    main()
