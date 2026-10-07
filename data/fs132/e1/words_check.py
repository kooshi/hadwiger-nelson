#!/usr/bin/env python3
"""FS132-E1: the one finite-combinatorial step of the extraction that names the label count — a cyclically reduced closed
edge word in the complete graph on k labels contains a simple cycle (of length 3..k).  Exhaustive over k <= KMAX and word
length <= LMAX; prints the number of words WITHOUT one.  --fault drops 'reduced' (words may backtrack): must print > 0.
Usage: words_check.py [--fault]"""
import sys, itertools
fault = "--fault" in sys.argv
KMAX, LMAX = 6, 7
bad = total = 0
for k in range(3, KMAX + 1):
    for L in range(2, LMAX + 1):
        for w in itertools.product(range(k), repeat=L):          # vertices v_0..v_{L-1}, closed: v_L = v_0
            if w[0] != 0:
                continue                                         # up to relabelling the base vertex
            if any(w[i] == w[(i + 1) % L] for i in range(L)):
                continue                                         # no loop edges: a walk in a simple graph
            if not fault and any(w[i] == w[(i + 2) % L] for i in range(L)):
                continue                                         # cyclically reduced: no edge followed by its reverse
            total += 1
            ok = False
            for i in range(L):                                   # a contiguous closed sub-walk with distinct vertices, length >= 3
                for m in range(3, L + 1):
                    sub = [w[(i + t) % L] for t in range(m)]
                    if w[(i + m) % L] == sub[0] and len(set(sub)) == m:
                        ok = True
            bad += not ok
print(bad)
