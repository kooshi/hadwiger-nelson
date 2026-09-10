#!/usr/bin/env python3
"""Analyse a set of minima: count it up to a named group, build `A`, and compare with his tables.

**Why the group must be named, and what it settles.** `[Parts2020a]` Table 1 reports
*"the number of non-isomorphic graphs in {M}"* and never says isomorphic under WHAT — §5.8 says
duplicates are removed by *"the set of permutations of the quotient group"*, which is a property of
his run's configuration and not of the mathematics. That is why `parts_report.SetSize` refuses a
bare integer, and it is why the S-subgraph reduction settles the convention by measurement rather
than by reading: our 48 raw minima fall into

    24 orbits under `Aut(A) n Aut(C)`   -- the stage's own input symmetry, order 2
     8 orbits under `Aut(A)` alone      -- isomorphism of the reduced graph itself, order 6
     8 orbits under the whole order-24 base group

and **his number is 8**. So *"non-isomorphic"* means up to the symmetry of the REDUCED graph, with
the companion free to move with it — which makes the quantity gateable for the rest of M63 where
it was un-gateable before.
"""
from __future__ import annotations
import json, os, sys
from collections import Counter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import typem as T
import parts_repro as P
import parts_report as R


def _images(G, kp, inv, S):
    for g in G:
        try:
            yield frozenset(inv[g(kp[t])] for t in S)
        except KeyError:
            continue


def stabiliser(base, S, G=None, kp=None, inv=None):
    G = G or T.parts_group()
    kp = kp or {t: P.kpoint(t) for t in base.tups}
    inv = inv or {v: k for k, v in kp.items()}
    F = frozenset(S)
    return [g for g in G if next(iter(_images([g], kp, inv, F)), None) == F]


def orbit_count(base, minima, group, kp=None, inv=None):
    """|{M}| up to `group`, and the canonical representative of each orbit."""
    kp = kp or {t: P.kpoint(t) for t in base.tups}
    inv = inv or {v: k for k, v in kp.items()}
    reps = {}
    for m in minima:
        c = min(tuple(sorted(x)) for x in _images(group, kp, inv, m))
        reps.setdefault(c, m)
    return reps


def analyse(base, minima, companion, candidates, his=None):
    """The full record for one reduction's level set. `his` is a dict of his published values."""
    G = T.parts_group()
    kp = {t: P.kpoint(t) for t in base.tups}
    inv = {v: k for k, v in kp.items()}
    autA = stabiliser(base, candidates, G, kp, inv)
    autC = stabiliser(base, companion, G, kp, inv)
    autWC = [g for g in autA if g in autC]
    A = set()
    for m in minima:
        A |= set(m)
    edges = Counter()
    for m in minima:
        E, _ = T.unit_edges_fast([P.kpoint(t) for t in sorted(m)])
        edges[len(E)] += 1
    out = {
        "minima_as_found": R.asdict(R.Count(len(minima), "exhaustive-level")),
        "distinct_as_found": len(set(minima)),
        "vertices": sorted({len(m) for m in minima}),
        "edge_multiset": dict(sorted(edges.items())),
        "A_vertices": len(A),
        "A_equals_candidates": A == set(candidates),
        "up_to": {
            "Aut(A) alone (order %d)" % len(autA): len(orbit_count(base, minima, autA, kp, inv)),
            "Aut(A) n Aut(C) (order %d)" % len(autWC): len(orbit_count(base, minima, autWC, kp, inv)),
            "the order-24 base group": len(orbit_count(base, minima, G, kp, inv)),
        },
    }
    if his:
        out["his"] = his
    return out
