"""B2: Q_m for m >= 11 (U mod P^m injective from 11, so d = 324 at every such level): float spectrum by a real FFT over (Z/N)^4,
the minimum, the characters at or below -d/3, their exact eigenvalues in Z[zeta_N] and their conductor levels.
Run: scripts/slot.py --mem 12 --cpus 4 -- python3 qhigh.py 12 13 14   (minutes; appends to qhigh.out)
"""
import sys, numpy as np
from tower import canon, exact_eig, to_float, modulus
from qprofile import level_of

MARGIN = 1e-6
Z = np.load('U510_O.npy')
out = open('qhigh.out', 'a')
def say(*a):
    print(*a); print(*a, file=out, flush=True)

for m in map(int, sys.argv[1:]):
    N = modulus(m)
    T = np.unique(canon(Z, m), axis=0); d = len(T)
    f = np.zeros((N, N, N, N), dtype=np.float32)
    if m % 2 == 0:
        lifts = T
    else:
        k = m // 2
        sh = np.array([[0, 0, 0, 0], [1, 0, 1, 0], [0, 1, 0, 1], [1, 1, 1, 1]]) << k
        lifts = ((T[:, None, :] + sh[None]) % N).reshape(-1, 4)
    np.add.at(f, tuple(lifts.T), 1.0)
    F = np.fft.rfftn(f.astype(np.float64)).real
    del f
    if m % 2 == 1:
        F /= 4.0
    thr = -d / 3
    lmin = F.min()
    idx = np.argwhere(F <= thr + MARGIN)
    say(f"m={m} N={N} d={d} -d/3={thr:.4f} float lambda_min={lmin:.6f} #grid points (half-spectrum, u ~ -u) with lambda <= -d/3 + 1e-6: {len(idx)}")
    if len(idx) <= 5000:
        u = idx.astype(np.int64)
        E = exact_eig(u, T, m)
        lf = to_float(E, m)
        eq = np.all(3 * E + np.eye(E.shape[1], dtype=np.int64)[0] * d == 0, axis=1)
        below = lf < thr - MARGIN
        lv = {}
        for x, e, b in zip(u, eq, below):
            key = 'EQ' if e else ('BELOW' if b else 'NEAR-NOT-EQUAL')
            lv.setdefault(key, set()).add(level_of(x, m))
        say(f"   exact: {int(eq.sum())} at exactly -d/3, {int(below.sum())} below, {int((~eq & ~below).sum())} near but not equal; conductor levels {lv}")
        if below.any():
            j = np.argmin(lf)
            say(f"   the least: u={u[j].tolist()} lambda={lf[j]:.9f} exact coefficients (zeta_N basis) nonzero: "
                f"{[(r, int(c)) for r, c in enumerate(E[j]) if c]}")
    # the next distinct value above -d/3 (the margin that certifies 'nothing else at -d/3')
    above = F[F > thr + MARGIN]
    say(f"   least float value above -d/3 + 1e-6: {above.min():.6f} (gap {above.min() - thr:.6f})")
    del F
