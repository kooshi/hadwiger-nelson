"""B2: Lambda_510's unit vectors in the dyadic completion O = Z2[w][sqrt3] of Q(sqrt59, i), and their residues mod P^m.

Embedding: Q2(sqrt59) = Q2(sqrt3) because 3*59 = 177 = 1 (mod 8); sqrt59 -> s*sqrt3 with s a 2-adic root of 59/3 (s^2 = 59*3^-1),
i -> (2w + 1)*sqrt3/3 (so i*sqrt3 = sqrt(-3) = 2w + 1).  A unit vector ((a + b sqrt59)/M, (c + e sqrt59)/M) is z = x + i y, whose
numerator a + b sqrt59 + i c + i e sqrt59 has coordinates (a + e s, 2 e s, b s + c/3, 2c/3) in the basis (1, w, sqrt3, w sqrt3).
All arithmetic is exact modulo 2^K; residues are used only mod P^m with 2^ceil(m/2) far below 2^(K-2).
Run: python3 embed.py  (seconds; writes embed.out and U510_O.npy, the embedded vectors mod 2^(K-1))
"""
import sys, numpy as np
sys.path.insert(0, '../stageA')
from units_fast import units_fast
from tower import mul, conj, canon, is_zero, circle, ONE

K = 24
MOD = 1 << K
D, M = 59, 510

def sqrt2adic(t, K):
    assert t % 8 == 1
    x = 1
    for j in range(3, K):
        if (x * x - t) % (1 << (j + 1)):
            x += 1 << (j - 1)
    assert (x * x - t) % (1 << K) == 0
    return x % (1 << K)

inv3 = pow(3, -1, MOD)
s = sqrt2adic(59 * inv3 % MOD, K)

def num_coords(a, b, c, e):
    return [(a + e * s) % MOD, (2 * e * s) % MOD, (b * s + c * inv3) % MOD, (2 * c * inv3) % MOD]

def embed(U):
    """Images of unit vectors in O mod 2^(K-1)."""
    out = []
    inv255 = pow(M // 2, -1, MOD >> 1)
    for (a, b, c, e) in U:
        v = num_coords(a, b, c, e)
        assert all(x % 2 == 0 for x in v), "numerator not in 2O"
        out.append([(x // 2) * inv255 % (MOD >> 1) for x in v])
    return np.array(out, dtype=np.int64)

if __name__ == '__main__':
    out = open('embed.out', 'w')
    def say(*a):
        print(*a); print(*a, file=out, flush=True)
    P = K - 2  # trusted precision: 2^P
    # the embedding is a ring map with the right conjugation (checked on generators)
    I = np.array([0, 0, inv3, 2 * inv3]) % MOD
    R59 = np.array([0, 0, s, 0])
    assert np.all((mul(I, I) + ONE) % (1 << P) == 0), "i^2 != -1"
    assert np.all((mul(R59, R59) - 59 * ONE) % (1 << P) == 0), "sqrt59^2 != 59"
    assert np.all((conj(I) + I) % (1 << P) == 0), "conj(i) != -i"
    assert np.all((conj(R59) - R59) % (1 << P) == 0), "conj(sqrt59) != sqrt59"
    assert np.all((mul(I, R59) - np.array(num_coords(0, 0, 0, 1))) % (1 << P) == 0)
    say(f"embedding: s = sqrt(59/3) mod 2^{K} = {s}; i^2 = -1, sqrt59^2 = 59, conj(i) = -i, conj(sqrt59) = sqrt59 mod 2^{P}: OK")
    U = units_fast(M, D)
    say(f"|U_510| = {len(U)}")
    Z = embed(U)
    # every image has norm one
    assert np.all(is_zero(mul(Z, conj(Z)) - ONE, 2 * P)), "an embedded unit vector is not norm one"
    say(f"every embedded unit vector has z*zbar = 1 mod P^{2*P}: OK")
    # (R3): Z2-span of U is O  <=>  images mod 2 span F2^4 (Nakayama)
    A = (Z % 2).astype(np.uint8)
    rk = 0; A = A.copy()
    for col in range(4):
        piv = np.nonzero(A[rk:, col])[0]
        if len(piv) == 0: continue
        p = rk + piv[0]; A[[rk, p]] = A[[p, rk]]
        A[(A[:, col] == 1) & (np.arange(len(A)) != rk)] ^= A[rk]
        rk += 1
    say(f"(R3) rank of U mod 2 over F2 = {rk}  ->  Z2-span of U = O: {rk == 4}")
    np.save('U510_O.npy', Z)
    # residues and saturation
    say("m | |S_m| | |T_m| = |U mod P^m| | T_m subset S_m | T_m = S_m | fibre sizes of U -> T_m (min..max)")
    mstar, minj = 0, None
    for m in range(1, 25):
        T = canon(Z, m)
        Tu, cnt = np.unique(T, axis=0, return_counts=True)
        S = circle(m) if m <= 20 else None
        if S is not None:
            Sset = {tuple(x) for x in S}
            sub = all(tuple(x) in Sset for x in Tu)
            full = sub and len(Tu) == len(S)
        else:
            sub = bool(np.all(is_zero(mul(Tu, conj(Tu)) - ONE, m))); full = False
        if full: mstar = m
        if minj is None and len(Tu) == len(U): minj = m
        say(f"{m} | {3 * 2 ** (m - 1)} | {len(Tu)} | {sub} | {full} | {cnt.min()}..{cnt.max()}")
        if minj is not None and m >= minj + 1: break
    say(f"saturation depth m* = {mstar}; injective from level {minj}")
