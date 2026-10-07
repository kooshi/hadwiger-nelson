#!/usr/bin/env python3
"""FS132-E3 control `three-axes` (of C132-M-AXES).

Six hubs k in Z/6 at 60 degrees, four continua j in Z/4 (continuum j joins labels j and j+1), a tip label
tau(k) in Z/4 at each hub with tau(k+3) = tau(k) + 2.  Continuum j lies on the positive side of axis k
(k = 0, 1, 2; the side of hub k) exactly when j is tau(k) - 1 or tau(k).  Because e_1 = e_0 + e_2, no
non-zero vector has the sign vector (+, -, +) or (-, +, -) against (e_0, e_1, e_2).
Prints the number of tau with no forbidden sign vector, how many of those are of kind A (some label is the tip
at three consecutive hubs) and of kind B (no label at three, two labels at two consecutive hubs each), and the number
with no two cyclically adjacent hubs of equal tip.
--fault: forgets the relation e_1 = e_0 + e_2 (allows every sign vector); the count is then positive."""
import sys, itertools
fault = "--fault" in sys.argv
count = 0; consistent = 0; kindA = 0; kindB = 0
for t in itertools.product(range(4), repeat=3):
    tau = [t[0], t[1], t[2], (t[0]+2) % 4, (t[1]+2) % 4, (t[2]+2) % 4]
    ok = True
    for j in range(4):
        sv = tuple(+1 if j in ((tau[k]-1) % 4, tau[k]) else -1 for k in range(3))
        if not fault and sv in ((1, -1, 1), (-1, 1, -1)): ok = False
    if not ok: continue
    consistent += 1
    three = any(tau[k] == tau[(k+1) % 6] == tau[(k+2) % 6] for k in range(6))
    doubles = sum(tau[k] == tau[(k+1) % 6] for k in range(6))
    kindA += three
    kindB += (not three) and doubles == 2
    if all(tau[k] != tau[(k+1) % 6] for k in range(6)): count += 1
print(f"sign-consistent={consistent} of 64; kind-A={kindA} kind-B={kindB}; with no adjacent equal tips={count}")
