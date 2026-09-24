#!/usr/bin/env python3
"""Edge-local cocycles on the LANGUAGE of X: square identities imposed only on the square patterns that occur in exhibited colourings
(closed under colour permutations, since X is Sym(4)-invariant).  If the exhibited colourings are ALL of X (de Grey: 380 pinned x 24),
this is the exact language; otherwise the patterns found are a subset of the language, so the nullity found is an UPPER bound on the
language-cocycle space (fewer equations) -- and if it meets the trivial dimension, triviality on the language is proved."""
import sys, itertools
from heights_edge import RowReducer, PAIRS, PIDX, canon_gens, neg, add, sub

PERMS = list(itertools.permutations(range(4)))

def occurring_patterns(gens, colourings):
    """colourings: list of (colour function on lattice points given as a callable) ; returns dict (i,j) -> set of 4-tuples"""
    n = len(gens)
    occ = {}
    for i, j in itertools.combinations(range(n), 2):
        occ[(i, j)] = set()
    return occ

def solve(gens, occ):
    n = len(gens)
    var = lambda i, a, b: 12 * i + PIDX[(a, b)]
    rr = RowReducer(12 * n)
    neq = 0
    for (i, j), pats in occ.items():
        full = set()
        for p in pats:
            for pi in PERMS:
                full.add(tuple(pi[c] for c in p))
        for (c0, c1, c2, c3) in full:
            row = {}
            for key, val in ((var(i, c0, c1), 1), (var(j, c1, c2), 1), (var(i, c3, c2), -1), (var(j, c0, c3), -1)):
                row[key] = row.get(key, 0) + val
            rr.add(row)
            neq += 1
    return 12 * n - rr.rank(), neq

def type_of(p):
    c0, c1, c2, c3 = p
    return {(True, True): 'I', (True, False): 'II', (False, True): 'III', (False, False): 'IV'}[(c0 == c2, c1 == c3)]
