"""Scratch driver (committed for reproducibility): count realizable layer-words of length n at a band, exactly.
A word is (j_0, d_0, j_1, ..., j_{n-1}); its E-set (in the last layer's coordinates) is
E_{t+1} = (wbar*E_t + d_t) ∩ P_{j_{t+1}}.  Prints |W_n| and the number of distinct (cell, polygon) states."""
import sys, os, time
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "../../../tools"))
from fractions import Fraction as Fr
import fs81_verify_thetaR as T40
import fs89_s0b_graph as G

def step(B, out, words, cap):
    new = []
    for (j, E, hist) in words:
        for k, d, _Q in out.get(j, []):
            img = [G.cmul(G.WB, p) for p in E]
            img = [(p[0] + d[0], p[1] + d[1]) for p in img]
            Q = img
            # clip by cell k's half-planes
            for a, b in B.H(k):
                Q = T40.clip(Q, a, b)
                if not Q:
                    break
            if Q:
                new.append((k, Q, hist + ((k, d),)))
        if len(new) > cap:
            raise SystemExit(f"CAP {cap} exceeded")
    return new

if __name__ == "__main__":
    lo, hi, N = Fr(sys.argv[1]), Fr(sys.argv[2]), int(sys.argv[3])
    B = G.Band(lo, hi)
    E, out = G.describe(B)
    words = [(j, list(P), ((j, None),)) for j, P in enumerate(B.cells)]
    t0 = time.time()
    for n in range(1, N + 1):
        states = len({(j, tuple(sorted(E))) for j, E, _ in words})
        npts = sum(1 for _, E, _ in words if len(E) == 1)
        print(f"n={n:3d}  |W_n|={len(words):8d}  states={states:8d}  point-sets={npts:7d}  t={time.time()-t0:.1f}s", flush=True)
        if n < N:
            words = step(B, out, words, 2_000_000)
