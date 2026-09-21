#!/usr/bin/env python3
"""Scratch measurements for the FS-66 plan: G_r(p) = UD(Z/p^r, 2) from the definition; structure checks."""
import sys, itertools, time
import numpy as np

def circle(n):
    """all (a,b) in (Z/n)^2 with a^2+b^2 = 1"""
    sq = [(a*a) % n for a in range(n)]
    return [(a, b) for a in range(n) for b in range(n) if (sq[a] + sq[b]) % n == 1]

def spectrum(n, S):
    ind = np.zeros((n, n))
    for a, b in S: ind[a, b] = 1
    lam = np.fft.fft2(ind)
    assert np.abs(lam.imag).max() < 1e-6
    return lam.real

if __name__ == "__main__":
    for p in (3, 7, 11, 19, 23):
        n = p*p
        S1 = circle(p); S2 = circle(n)
        assert len(S1) == p+1 and len(S2) == p*(p+1), (p, len(S1), len(S2))
        lam1 = spectrum(p, S1); lam2 = spectrum(n, S2)
        # inherited characters: u in p*(Z/n)^2  <-> indices multiple of p
        inh = np.zeros((n, n), bool); inh[::p, ::p] = True
        new = lam2[~inh]
        hoff1 = -lam1.min() / (len(S1) - lam1.min()); hoff2 = -lam2.min() / (len(S2) - lam2.min())
        print(f"p={p}: |S1|={len(S1)} |S2|={len(S2)} directed edges G2={n*n*len(S2)}  lam_min(G1)={lam1.min():.4f} lam_min(G2)={lam2.min():.4f} (p*lam1min={p*lam1.min():.4f})")
        print(f"      new-character eigenvalues of G2: min={new.min():.4f} max={new.max():.4f}  bound 2p={2*p}  distinct≈{len(set(np.round(new,6)))}")
        print(f"      Hoffman ratio G1={hoff1:.6f} G2={hoff2:.6f}; Hoffman alpha bound G1={hoff1*p*p:.3f} G2={hoff2*n*n:.2f}; inherited check max|lam2[inh]-p*lam1|={np.abs(lam2[::p, ::p] - p*lam1).max():.2e}")
