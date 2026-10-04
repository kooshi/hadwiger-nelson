#!/usr/bin/env python3
"""Exploration (not a control): on discretised rings of N cells (N = 6m), proper at 60 degrees (c[i] != c[i+m]),
compare FS110's total winding W (sum of +-1 over colour changes round the ring) with RINGWIND's hexagon winding h(k)
(k = 0..m-1) and with the count of 60-degree-apart change pairs."""
import itertools, collections
def d(x, y):
    return 0 if x == y else (1 if (y - x) % 3 == 1 else -1)
for N in (12, 18):
    m = N // 6
    stats = collections.Counter()
    for c in itertools.product(range(3), repeat=N):
        if c[0] != 0: continue
        if any(c[i] == c[(i + m) % N] for i in range(N)): continue
        W = sum(d(c[i], c[(i + 1) % N]) for i in range(N))
        hs = tuple(sum(d(c[(k + m * j) % N], c[(k + m * (j + 1)) % N]) for j in range(6)) // 3 for k in range(m))
        ch = [d(c[i], c[(i + 1) % N]) != 0 for i in range(N)]   # change at boundary between cell i and i+1
        pairs = any(ch[i] and ch[(i + m) % N] for i in range(N))
        stats[(W, hs, pairs)] += 1
    print('N =', N)
    for k in sorted(stats): print('  W=%3d h=%s pair60=%s : %d' % (k[0], k[1], k[2], stats[k]))
