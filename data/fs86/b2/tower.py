"""FS-86 B2: the dyadic tower O/P^m of Q2(zeta_12) = Q2(sqrt3, i), built from the ring axioms (independent of FS-38's code).

O = Z2[w][sqrt3], w a primitive cube root of unity (w^2 = -1 - w), basis (1, w, sqrt3, w*sqrt3); an element is an integer
4-vector x meaning A + B*sqrt3 with A = x0 + x1 w, B = x2 + x3 w.  Complex conjugation: w -> w^2 = -1 - w, sqrt3 fixed.
P = pi*O with pi = 1 + sqrt3 (pi^2 = 2 + 2 pi, so P^2 = 2O).  Residues mod P^m are stored in canonical form:
  m = 2k   : coordinates mod 2^k;
  m = 2k+1 : coordinates mod 2^(k+1), with x0, x1 < 2^k (P^(2k+1) mod 2^(k+1) is spanned by 2^k(1,0,1,0), 2^k(0,1,0,1)).
Characters of O/P^m: u in (Z/N)^4, N = 2^ceil(m/2), chi_u(x) = zeta_N^(u.x); admissible iff u kills P^m
(m odd: u0 + u2 and u1 + u3 even).  Eigenvalues of Cay(O/P^m, T) are exact elements of Z[zeta_N], stored in the basis
zeta^0..zeta^(N/2-1) (zeta^(r+N/2) = -zeta^r); floats only for aiming and for sign tests with a stated margin.
"""
import numpy as np

def emul(a0, a1, c0, c1):
    return a0 * c0 - a1 * c1, a0 * c1 + a1 * c0 - a1 * c1

def mul(x, y):
    x = np.asarray(x)
    y = np.asarray(y)
    a0, a1, b0, b1 = (x[..., i] for i in range(4))
    c0, c1, d0, d1 = (y[..., i] for i in range(4))
    ac0, ac1 = emul(a0, a1, c0, c1)
    bd0, bd1 = emul(b0, b1, d0, d1)
    ad0, ad1 = emul(a0, a1, d0, d1)
    bc0, bc1 = emul(b0, b1, c0, c1)
    return np.stack([ac0 + 3 * bd0, ac1 + 3 * bd1, ad0 + bc0, ad1 + bc1], axis=-1)

def conj(x):
    x = np.asarray(x)
    return np.stack([x[..., 0] - x[..., 1], -x[..., 1], x[..., 2] - x[..., 3], -x[..., 3]], axis=-1)

def norm(x):
    return mul(x, conj(x))

def canon(x, m):
    """Canonical residue of x mod P^m (vectorised over leading axes)."""
    x = np.array(x, dtype=np.int64, copy=True)
    k = m // 2
    if m % 2 == 0:
        return x % (1 << k)
    x %= (1 << (k + 1))
    hi0 = (x[..., 0] >> k) & 1
    hi1 = (x[..., 1] >> k) & 1
    x[..., 0] -= hi0 << k; x[..., 2] -= hi0 << k
    x[..., 1] -= hi1 << k; x[..., 3] -= hi1 << k
    return x % (1 << (k + 1))

def modulus(m):
    return 1 << ((m + 1) // 2)

def encode(x, m):
    """Integer index of a canonical residue (injective on canonical forms)."""
    N = modulus(m)
    x = np.asarray(x, dtype=np.int64)
    return ((x[..., 0] * N + x[..., 1]) * N + x[..., 2]) * N + x[..., 3]

def is_zero(x, m):
    return np.all(canon(x, m) == 0, axis=-1)

ONE = np.array([1, 0, 0, 0])
PI = np.array([1, 0, 1, 0])

def all_residues(m):
    """Every canonical residue mod P^m (4^m of them)."""
    k = m // 2
    if m % 2 == 0:
        r = [np.arange(1 << k)] * 4
    else:
        r = [np.arange(1 << k)] * 2 + [np.arange(1 << (k + 1))] * 2
    g = np.stack(np.meshgrid(*r, indexing='ij'), -1).reshape(-1, 4)
    assert len(g) == 4 ** m
    return g

def circle(m, conj_fn=None):
    """S_m = {z in O/P^m : z zbar = 1}, by lifting level by level (each residue has four lifts; keep those of norm 1)."""
    cf = conj if conj_fn is None else conj_fn
    S = all_residues(1)
    S = S[is_zero(mul(S, cf(S)) - ONE, 1)]
    for mm in range(2, m + 1):
        k = (mm - 1) // 2
        # P^(mm-1)/P^mm has four elements: pi^(mm-1) * {0, 1, w, 1+w}
        pim = ONE
        for _ in range(mm - 1):
            pim = mul(pim, PI)
        hs = np.stack([np.zeros(4, dtype=np.int64), pim, mul(pim, [0, 1, 0, 0]), mul(pim, [1, 1, 0, 0])])
        L = (S[:, None, :] + hs[None, :, :]).reshape(-1, 4)
        L = canon(L, mm)
        L = L[is_zero(mul(L, cf(L)) - ONE, mm)]
        S = np.unique(L, axis=0)
    return canon(S, m)

def characters(m):
    N = modulus(m)
    u = np.stack(np.meshgrid(*[np.arange(N)] * 4, indexing='ij'), -1).reshape(-1, 4)
    if m % 2 == 1:
        u = u[((u[:, 0] + u[:, 2]) % 2 == 0) & ((u[:, 1] + u[:, 3]) % 2 == 0)]
    assert len(u) == 4 ** m
    return u

def exact_eig(u, T, m):
    """Exact eigenvalues for characters u (n x 4) on generator residues T (d x 4): integer arrays (n, max(N/2,1))."""
    N = modulus(m)
    r = (u @ T.T) % N  # (n, d)
    n = len(u)
    cnt = np.zeros((n, N), dtype=np.int64)
    for j in range(N):
        cnt[:, j] = (r == j).sum(1)
    if N == 1:
        return cnt
    h = N // 2
    return cnt[:, :h] - cnt[:, h:]

def to_float(E, m):
    N = modulus(m)
    h = E.shape[1]
    if N == 1:
        return E[:, 0].astype(float)
    return E @ np.cos(2 * np.pi * np.arange(h) / N)

def float_eigs_fft(T, m):
    """Float eigenvalue for every admissible character, via an FFT over (Z/N)^4; returns (u array, values)."""
    N = modulus(m)
    f = np.zeros((N, N, N, N))
    Tc = canon(T, m)
    if m % 2 == 0:
        lifts = Tc
    else:
        k = m // 2
        sh = np.array([[0, 0, 0, 0], [1, 0, 1, 0], [0, 1, 0, 1], [1, 1, 1, 1]]) << k
        lifts = ((Tc[:, None, :] + sh[None]) % N).reshape(-1, 4)
    np.add.at(f, tuple(lifts.T), 1.0)
    F = np.fft.fftn(f).real
    if m % 2 == 1:
        F /= 4.0
    u = characters(m)
    return u, F[tuple(u.T)]
