#!/usr/bin/env python3
"""FS-86 verifier B1: spectra of residue towers at an odd stable place, by FFT of the connection set's indicator.

Rings: unramified  A = Z/p^k            (the split-prime tower UD(Z/p^k, 2), level k)
       ramified    A = Z_p[e]/(e^2 - p, e^m)   (the tower at the prime above p of Q(sqrt p), p | d; level m)
Graph: Cay(A^2, S), S = {(x,y) : x^2 + y^2 = 1}.  Eigenvalue of character chi = FFT of 1_S at chi (real, S = -S).
Claims checked (derived by hand in the record, Lemma P):
  (a) |S| = (p+1) p^(level-1);
  (b) characters pulled back from level one have eigenvalue p^(level-1) * (eigenvalue of Gamma_p);
  (c) every other character has |lambda| <= 2 p^(level-1)            (the primitive bound);
  (d) hence the Hoffman ratio at this level is max(Hoffman ratio of Gamma_p, 2/(p+3)).
Plant: --plant drops the constraint "x^2+y^2 = 1" to "x^2+y^2 = 1 mod the maximal ideal" (the full fibre, a blow-up):
  claim (c) must then FAIL (the blow-up has no primitive spectrum control of this form -- all non-pullback eigenvalues are 0
  and |S| is wrong), so (a) must fail."""
import sys, itertools
import numpy as np

def ring(p, kind, level):
    if kind == "unram":
        mods = (p**level,)
        def mul(x, y):  # x, y tuples
            return ((x[0]*y[0]) % mods[0],)
        def is_one(x): return x[0] % mods[0] == 1
        def to_res(x): return (x[0] % p,)      # residue in F_p (level one ring Z/p)
    else:
        ma, mb = p**((level+1)//2), p**(level//2)
        mods = (ma, mb)
        def mul(x, y):
            a, b = x; c, d = y
            return ((a*c + p*b*d) % ma, (a*d + b*c) % mb if mb > 1 else 0)
        def is_one(x): return x[0] % ma == 1 and (x[1] % mb if mb > 1 else 0) == 0
        def to_res(x): return (x[0] % p,)
    return mods, mul, is_one, to_res

def circle(p, kind, level, plant=False):
    mods, mul, is_one, to_res = ring(p, kind, level)
    elems = list(itertools.product(*[range(m) for m in mods]))
    sq = {e: mul(e, e) for e in elems}
    S = []
    for x in elems:
        for y in elems:
            s = tuple((u + v) for u, v in zip(sq[x], sq[y]))
            s = tuple(si % m for si, m in zip(s, mods))
            if plant:
                if (s[0] % p) == 1: S.append((x, y))
            elif is_one(s):
                S.append((x, y))
    return mods, S

def spectrum(p, kind, level, plant=False):
    mods, S = circle(p, kind, level, plant)
    shape = mods + mods
    ind = np.zeros(shape, dtype=np.float64)
    for (x, y) in S:
        ind[x + y] = 1.0
    lam = np.real(np.fft.fftn(ind))   # eigenvalue at character (k) = sum_s exp(-2 pi i <k,s>/N); real since S = -S
    return mods, len(S), lam

def classify(p, kind, level, mods, lam):
    # a character k (index tuple) is pulled back from level one iff it is trivial on the kernel of A^2 -> F_p^2 (resp. F_{p^2}).
    # Character of Z/M coordinate with index k: trivial on p*(Z/M) iff k is a multiple of M/p.
    # unramified: coordinates (x) with M = p^level; level-one characters: k % (p^(level-1)) == 0.
    # ramified: x = a + b e, level-one ring = A/eA = F_p (a mod p); kernel = {a in pZ, any b}; character (ka, kb) trivial on it
    #           iff kb == 0 and ka % (ma/p) == 0.
    idx = np.indices(lam.shape)
    if kind == "unram":
        M = mods[0]
        pull = (idx[0] % (M//p) == 0) & (idx[1] % (M//p) == 0)
    else:
        ma, mb = mods
        pull = (idx[0] % (ma//p) == 0) & (idx[1] == 0) & (idx[2] % (ma//p) == 0) & (idx[3] == 0)
    return pull

if __name__ == "__main__":
    plant = "--plant" in sys.argv
    cases = [(11, "unram", 2), (19, "unram", 2), (11, "ram", 2), (11, "ram", 3), (23, "ram", 2), (59, "ram", 2), (7, "unram", 3)]
    if plant: cases = [(11, "unram", 2), (11, "ram", 2)]
    from gamma_spectra import run as gamma_run
    for (p, kind, level) in cases:
        mods, nS, lam = spectrum(p, kind, level, plant)
        pull = classify(p, kind, level, mods, lam)
        g = gamma_run(p) if p % 4 == 3 else None
        deg_ok = nS == (p+1) * p**(level-1)
        prim = lam[~pull]
        prim_max = np.max(np.abs(prim)) if prim.size else 0.0
        prim_ok = prim_max <= 2 * p**(level-1) + 1e-6
        pull_min = np.min(lam[pull])
        pull_ok = g is None or abs(pull_min - p**(level-1) * float(g['lmin'])) < 1e-6
        lmin = lam.min(); d = nS
        hoff = -lmin/(d - lmin)
        pred = max(float(g['h']) if g else 0.0, 2/(p+3))
        print(f"p={p:3d} {kind:5s} level={level} |V|={lam.size:9d} deg={nS:6d} (a){'PASS' if deg_ok else 'FAIL'} "
              f"pulled-back min={pull_min:12.6f} (b){'PASS' if pull_ok else 'FAIL'} "
              f"max|primitive|={prim_max:10.4f} vs 2p^(l-1)={2*p**(level-1)} (c){'PASS' if prim_ok else 'FAIL'} "
              f"hoffman={hoff:.9f} predicted={pred:.9f} (d){'PASS' if abs(hoff-pred) < 1e-9 else 'FAIL'}")
