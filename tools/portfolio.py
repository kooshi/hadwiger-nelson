"""A portfolio of seeded greedy descents over vertex-groups (FS-32 §B4).

**Why a portfolio at all.** `plans/DESCENT-ALGORITHM.md` (WO-9, 2026-08-31) states the fact this is
built on: *"the shrink reaches a 1-minimal halo, and 1-minimal is not minimum: different deletion
orders reach different 1-minimal halos […] the one lever left is the shrink's deletion order."* A
greedy descent is a local search whose local minimum is chosen by its order, so the order is the
search space, and running many orders at once is the cheapest way to sample it.

**What each run does and does not prove.** A run ends 1-minimal: every kept group has a colouring
that survives its removal. By the downward-closure of criticality witnesses (same doc), each such
witness proves that group is in **every working subset of this run's own final set** — so a run's
answer is the unique minimal subset *of itself*, and says nothing about subsets it never contained.
**A portfolio therefore produces upper bounds only.** The rigorous lower bound comes from the
hitting-set side (`tools/gmus.py`), and the two meet: the portfolio's best is `UB`, the hitting-set
value is `LB`, and the pair is reported as a sandwich.

**Budget discipline (§M2).** An ask that exhausts its conflict budget is `undecided`; the group is
**kept** — declining a drop is always safe — and the run records it, because a descent that ends
with undecideds has converged to a fixed point of its budget and not of the mathematics.
"""
from __future__ import annotations
import random, time


def greedy(hard, pres, weights, order=None, seed=0, budget=0, log=None, solver="cadical153",
           chunked=True):
    """One seeded descent over the groups. Returns a dict, never a bare number.

    **Chunked, not one-at-a-time — this is the difference between minutes and an hour.** Measured
    2026-09-10 on the type-M arena: an ask costs 9 s on an idle box and 17-39 s under contention,
    and a one-at-a-time pass needs one ask per group (182). The halving schedule (`Parts2020a`'s own
    "8-4-2-1", which is QuickXplain) spends ONE expensive ask to drop a whole chunk, so the number
    of *accepting* asks falls from "one per dropped group" to "one per chunk". Rejections are cheap
    (a colouring turns up fast); acceptances are the UNSAT calls that cost.

    A chunk whose ask is `undecided` at budget is SPLIT rather than dropped or kept wholesale —
    the safe direction, since declining a drop never costs soundness."""
    from pysat.solvers import Solver
    m = len(pres)
    order = list(range(m)) if order is None else list(order)
    random.Random(seed).shuffle(order)
    keep = set(range(m))
    dropped, undecided, witnessed = [], [], []
    t0 = time.time()
    with Solver(name=solver, bootstrap_with=hard) as s:
        # CONTROL: the full selection must refuse, or the run is measuring a vacuous arena
        if budget: s.conf_budget(budget)
        r0 = s.solve_limited(assumptions=[pres[g] for g in sorted(keep)], expect_interrupt=False) \
             if budget else s.solve(assumptions=[pres[g] for g in sorted(keep)])
        if r0 is not False:
            return dict(status="vacuous-or-undecided", detail=str(r0), seed=seed)
        asks = [0]

        def refuses(trial):
            asks[0] += 1
            a = [pres[x] for x in sorted(trial)]
            if budget:
                s.conf_budget(budget)
                return s.solve_limited(assumptions=a, expect_interrupt=False)
            return s.solve(assumptions=a)

        def attempt(chunk):
            """Drop `chunk` wholesale if that still refuses; else halve; singletons are decided."""
            nonlocal keep
            if not chunk:
                return
            st = time.time()
            r = refuses(keep - set(chunk))
            if r is False:
                keep -= set(chunk); dropped.extend(chunk)
                if log: log(f"    seed {seed}: DROPPED chunk of {len(chunk)} -> "
                            f"{len(keep)} groups / weight {sum(weights[x] for x in keep)} "
                            f"[{time.time()-st:.0f}s, ask {asks[0]}, {time.time()-t0:.0f}s total]")
                return
            if len(chunk) == 1:
                (witnessed if r is True else undecided).append(chunk[0])
                if log and asks[0] % 20 == 0:
                    log(f"    seed {seed}: {len(dropped)} dropped, {len(witnessed)} witnessed, "
                        f"{len(undecided)} undecided, weight {sum(weights[x] for x in keep)} "
                        f"[ask {asks[0]}, {time.time()-t0:.0f}s]")
                return
            h = len(chunk) // 2
            attempt(chunk[:h]); attempt(chunk[h:])

        if chunked:
            attempt(order)
        else:
            for g in order:
                attempt([g])
    return dict(status="ok" if not undecided else "ok-with-undecided",
                seed=seed, keep=sorted(keep), weight=sum(weights[x] for x in keep),
                groups=len(keep), dropped=len(dropped), witnessed=len(witnessed),
                undecided=undecided, asks=asks[0], seconds=round(time.time()-t0, 1),
                claim_scope="1-minimal for THIS order; an upper bound, never a minimum")


def repair(hard, pres, weights, keep, candidates=None, budget=0, solver="cadical153", log=None):
    """Make a selection refuse four colours by ADDING groups, cheapest-first.

    **This is the move pure descent cannot make, and it is the whole reason a memetic layer beats a
    portfolio.** A greedy descent from the full base only ever removes, so it is trapped in the
    downward closure of wherever it started; `[Parts2020a]` §5.6 says in print that pure reduction
    cannot reach a minimum, and his method alternates reduction with **expansion** from a small
    accumulator plus a reserve graph. `repair` is that expansion: given a selection that does NOT
    refuse — a crossover child, or a deliberately over-shrunk one — put groups back until it does.

    Cheapest-first because the objective is vertices; the caller re-runs the local search after, so
    this only has to reach feasibility, not minimality. Returns None if even every candidate fails.
    """
    from pysat.solvers import Solver
    keep = set(keep)
    pool = sorted(set(range(len(pres))) - keep if candidates is None else set(candidates) - keep,
                  key=lambda g: weights[g])
    with Solver(name=solver, bootstrap_with=hard) as s:
        def refuses(sel):
            a = [pres[x] for x in sorted(sel)]
            if budget:
                s.conf_budget(budget)
                return s.solve_limited(assumptions=a, expect_interrupt=False)
            return s.solve(assumptions=a)
        if refuses(keep) is False:
            return sorted(keep)
        for g in pool:
            keep.add(g)
            r = refuses(keep)
            if r is False:
                if log: log(f"    repaired by adding {len(keep)} groups "
                            f"(weight {sum(weights[x] for x in keep)})")
                return sorted(keep)
            # an `unknown` here is NOT evidence either way; keep adding, which is the safe direction
    return None
