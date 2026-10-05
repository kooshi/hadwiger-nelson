#!/usr/bin/env python3
"""FS131-E4: the type count of the base's pigeonhole (row 134's base, Lemma 4's 10 + 1), exact over Fin 6.

Colours 0..5; u's colours U = {3, 4, 5} (the record's C); absent colours {0, 1, 2}.
Classes: the 3-subsets of Fin 6 up to complement (10 classes). A collision is two points of one class
(same multicolour, refuted at distance in [1, 2] by l3_base / pair_P' / vin_antipodal; or complementary,
refuted below 2 by cor3_base / eleventh_antipodal).

Prints, on one line:
  classes      the number of classes (10)
  endpoint     the number of endpoint types {a, c, i} (a, c absent, i in U) and of distinct classes they occupy
  ucls         whether any endpoint type lies in u's class (it must not)
  qcomp        for every q-type {x, j, k} (x absent, j, k in U): the number of endpoint types in its class (each must be 1)
  forced       whether nine endpoints of nine distinct types, plus u, are already forced to collide (they are not:
               the count needs a tenth point in the nine endpoint classes, which is what the eleventh point supplies)

--fault  plants a wrong complement (complement taken inside Fin 7), which must change the printed line.
"""
import itertools
import sys

FAULT = "--fault" in sys.argv
N = 6
UNIV = frozenset(range(7 if FAULT else N))
U = frozenset({3, 4, 5})
ABS = frozenset(range(N)) - U


def comp(s):
    return UNIV - s


def cls(s):
    s = frozenset(s)
    return min(tuple(sorted(s)), tuple(sorted(comp(s))))


triples = [frozenset(t) for t in itertools.combinations(range(N), 3)]
classes = {cls(t) for t in triples}
endpoint = [frozenset({a, c, i}) for a, c in itertools.combinations(sorted(ABS), 2) for i in sorted(U)]
qtypes = [frozenset({x, j, k}) for x in sorted(ABS) for j, k in itertools.combinations(sorted(U), 2)]
ep_classes = {cls(t) for t in endpoint}
ucls = any(cls(t) == cls(U) for t in endpoint)
qcomp = sorted({sum(1 for t in endpoint if cls(t) == cls(q)) for q in qtypes})
# nine endpoints with nine distinct types plus u: forced to collide iff two of them share a class
points = endpoint + [U]
forced = len({cls(p) for p in points}) < len(points)
print(f"classes={len(classes)} endpoint={len(endpoint)}/{len(ep_classes)} ucls={ucls} qcomp={qcomp} forced={forced}")
