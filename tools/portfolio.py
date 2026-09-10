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


def greedy(hard, pres, weights, order=None, seed=0, budget=0, log=None, solver="cadical153"):
    """One seeded greedy 1-minimalisation over the groups. Returns a dict, never a bare number."""
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
        for g in order:
            trial = keep - {g}
            a = [pres[x] for x in sorted(trial)]
            if budget:
                s.conf_budget(budget)
                r = s.solve_limited(assumptions=a, expect_interrupt=False)
            else:
                r = s.solve(assumptions=a)
            if r is False:                      # still refuses four colours -> drop it
                keep = trial; dropped.append(g)
            elif r is True:                     # a colouring survives -> criticality witness
                witnessed.append(g)
            else:                               # budget exhausted: KEEP, and say so
                undecided.append(g)
            if log and (len(dropped)+len(witnessed)+len(undecided)) % 25 == 0:
                log(f"    seed {seed}: {len(dropped)} dropped, {len(witnessed)} witnessed, "
                    f"{len(undecided)} undecided, weight {sum(weights[x] for x in keep)} "
                    f"[{time.time()-t0:.0f}s]")
    return dict(status="ok" if not undecided else "ok-with-undecided",
                seed=seed, keep=sorted(keep), weight=sum(weights[x] for x in keep),
                groups=len(keep), dropped=len(dropped), witnessed=len(witnessed),
                undecided=undecided, seconds=round(time.time()-t0, 1),
                claim_scope="1-minimal for THIS order; an upper bound, never a minimum")
