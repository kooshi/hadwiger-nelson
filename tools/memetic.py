"""Memetic search over vertex-groups: crossover + repair + greedy local search (FS-32 §B5).

**Why this and not more portfolio.** A greedy descent only ever removes, so every run is trapped in
the downward closure of wherever it started, and `plans/DESCENT-ALGORITHM.md` (WO-9) says the only
lever it has is its deletion order. `[Parts2020a]` §5.6 says in print — twice — that pure reduction
cannot reach a minimum, and his own method alternates reduction with **expansion**: an accumulator
`A` that grows from a reserve `R` and shrinks again. The memetic loop is that alternation:

    parents  ->  crossover  ->  repair (ADD groups until it refuses)  ->  greedy (REMOVE)  ->  child

`repair` is the expansion stage and it is what a portfolio structurally cannot do. Kooshi's framing:
*"parallel solvers with different seeds might be better able to find local minima, or genetic algo if
we can break the graph into units"* — the units are the 182 symmetry orbits, which is why this is
now possible at all and was not before FS-31 corrected the base.

**File-based and resumable by construction**: workers append one JSON line per child to a results
file and re-read the population between children; there is no IPC to wedge and a kill costs one
child. Every child is independently re-verified before it can enter the population.
"""
from __future__ import annotations
import json, os, random, time


def crossover(a, b, rng, m):
    """Uniform crossover on the group masks: the agreement is kept, the disagreement is coin-flipped.

    The agreement `a ∩ b` is what two good selections have decided together; the symmetric difference
    is where they disagree and is exactly what there is to search. A child need not refuse four
    colours — that is `repair`'s job — so no feasibility is assumed here."""
    A, B = set(a), set(b)
    child = A & B
    for g in A ^ B:
        if rng.random() < 0.5:
            child.add(g)
    return sorted(child)


def mutate(keep, rng, m, rate=0.03):
    """Flip each group with small probability. Dropping may break feasibility; `repair` restores it."""
    K = set(keep)
    for g in range(m):
        if rng.random() < rate:
            K.discard(g) if g in K else K.add(g)
    return sorted(K)


def load_population(path):
    if not os.path.exists(path):
        return []
    return json.load(open(path))


def update_population(path, results_path, cap=12, seen=None):
    """Fold every finished child into the population, keeping the `cap` lightest DISTINCT ones."""
    pop = {tuple(p["keep"]): p for p in load_population(path)}
    if os.path.exists(results_path):
        for line in open(results_path):
            line = line.strip()
            if not line:
                continue
            try:
                r = json.loads(line)
            except Exception:
                continue
            if r.get("status", "").startswith("ok") and r.get("verified") == "unsat":
                pop[tuple(r["keep"])] = r
    best = sorted(pop.values(), key=lambda p: p["weight"])[:cap]
    json.dump(best, open(path, "w"))
    return best
