"""Poros's language question on L21cc6506, vectorised: square types and monopoles in actual periodic 4-colourings (N=4, and N=8)."""
import sys, itertools, time
import numpy as np
from language import colourings, reps
for N, cap in ((4, 3000), (8, 300)):
    t = time.time()
    verts, vid, cols = colourings(N, cap)
    C = np.array(cols, dtype=np.int8)                       # (colourings, vertices)
    V = np.array(verts)                                      # (vertices, 4)
    def idx(*g):
        s = V.copy()
        for x in g: s = s + np.array(x)
        s %= N
        return ((s[:, 0]*N + s[:, 1])*N + s[:, 2])*N + s[:, 3]
    assert all(vid[v] == i for i, v in enumerate(verts)) and list(idx()) == list(range(len(verts)))
    miss = {'abab': 0, 'abac': 0, 'abcb': 0, 'abcd': 0}
    for s_, t_ in itertools.combinations(reps, 2):
        a, b, c, d = C[:, idx()], C[:, idx(s_)], C[:, idx(s_, t_)], C[:, idx(t_)]
        ac, bd = (a == c), (b == d)
        present = {'abab': (ac & bd).any(), 'abac': (ac & ~bd).any(), 'abcb': (~ac & bd).any(), 'abcd': (~ac & ~bd).any()}
        for k, v in present.items(): miss[k] += (not v)
    print(f'N={N}: {len(cols)} colourings; of {len(reps)*(len(reps)-1)//2} generator pairs, number missing each square type in the sample: {miss}  ({time.time()-t:.0f}s)', flush=True)
    t = time.time(); withmono = 0; ntr = 0
    for s_, t_, u_ in itertools.combinations(reps, 3):
        ntr += 1
        x0, xs, xt, xu = C[:, idx()], C[:, idx(s_)], C[:, idx(t_)], C[:, idx(u_)]
        xst, xsu, xtu, xstu = C[:, idx(s_, t_)], C[:, idx(s_, u_)], C[:, idx(t_, u_)], C[:, idx(s_, t_, u_)]
        m = (x0 == xstu) & (xs == xtu) & (xt == xsu) & (xu == xst) & (x0 != xst) & (x0 != xsu) & (x0 != xtu) & (xst != xsu) & (xst != xtu) & (xsu != xtu)
        withmono += bool(m.any())
    print(f'N={N}: generator triples with a monopole in some sampled colouring: {withmono} of {ntr}  ({time.time()-t:.0f}s)', flush=True)
