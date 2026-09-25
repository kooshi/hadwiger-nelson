"""B2, second code path: Q_{2k} = Cay(Lambda/2^k Lambda, U), computed in a Z-basis of Lambda_510 with no 2-adic embedding at all.

Why this is Q_{2k}: Lambda (x) Z2 = O (embed.py, (R3)), so Lambda / (Lambda cap 2^k O) has order 4^(2k) = [Lambda : 2^k Lambda]; hence
Lambda cap P^(2k) = 2^k Lambda and Q_{2k} = Cay(Lambda/2^k Lambda, U mod 2^k).  Characters are n in (Z/2^k)^4 on the dual basis.
Also: the symbol sigma(theta) = sum_u cos(2 pi <theta, c(u)>) of the infinite Cay(Lambda, U) on the 4-torus, whose values at the
2-power torsion points are exactly the spectra of all Q_m (float minimisation; aiming only).
Run: python3 lattice.py   (under a minute; writes lattice.out, lattice_coords.npy)
"""
import sys, numpy as np
from fractions import Fraction as Fr
from sympy import Matrix
from sympy.matrices.normalforms import hermite_normal_form
sys.path.insert(0, '../stageA')
from units_fast import units_fast

U = units_fast(510, 59)
V = Matrix([list(u) for u in U])            # rows (a, b, c, e): the vector ((a + b r)/510, (c + e r)/510)
H = hermite_normal_form(V.T).T                # rows span the same Z-module
B = Matrix([r for r in H.tolist() if any(r)]); assert B.shape == (4, 4)
C = (V * B.inv())                             # coordinates of U in the basis B
assert all(x.q == 1 for x in C), "non-integral coordinates"
C = np.array(C.tolist(), dtype=np.int64)
np.save('lattice_coords.npy', C)
out = open('lattice.out', 'w')
def say(*a):
    print(*a); print(*a, file=out, flush=True)
say("basis of Lambda_510 (rows, in (a,b,c,e)/510 coordinates):", B.tolist())
say("|U| =", len(C), " coordinates in [", C.min(), ",", C.max(), "]")
for k in range(1, 8):
    N = 1 << k
    T = np.unique(C % N, axis=0); d = len(T)
    f = np.zeros((N,) * 4)
    np.add.at(f, tuple(T.T), 1.0)
    F = np.fft.fftn(f).real
    lmin = F.min(); nmin = int((np.abs(F - lmin) < 1e-6).sum()); nb = int((F < -d / 3 - 1e-6).sum())
    say(f"level m={2 * k} (Lambda/{N}Lambda): d={d} -d/3={-d / 3:.4f} lambda_min={lmin:.6f} #minimisers={nmin} #below -d/3={nb} "
        f"-> {'TIGHT' if nb == 0 and abs(lmin + d / 3) < 1e-6 else 'SLACK'}")
