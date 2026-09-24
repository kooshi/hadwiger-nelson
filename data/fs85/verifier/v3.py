from field import *
from lattice import *
from math import lcm
import itertools
z, eta = ZETA, ETA
eps = [ONE, z, power(z,2)]
exps = []; worst = None; zero_idx = 0
for choice in itertools.product(range(3), repeat=5):
    gens = [list(lam_coords(smul(2, mul(power(eta,k), eps[e])))) for k, e in zip(range(-2,3), choice)]
    inv = smith_exponent_invariants(gens, 4)
    if len(inv) < 4 or 0 in inv:
        zero_idx += 1; continue
    exps.append(inv[-1])
    # sanity: product of invariants equals index from HNF
    assert eval('*'.join(map(str,inv))) == det_of_hnf(hnf(gens)), (inv, det_of_hnf(hnf(gens)))
print("choices:", 243, "; infinite index:", zero_idx)
L = 1
for e in exps: L = lcm(L, e)
print("lcm of exponents of Lambda/L:", L, "=", {p: 0 for p in []} or L, "; distinct exponents:", sorted(set(exps)))
# the control: a choice with a repeated orientation (two generators in one orientation) must be infinite index
gens = [list(lam_coords(smul(2, g))) for g in [ONE, z, power(eta,2), mul(power(eta,2),z)]]
print("control: 2T0 + 2eta^2T0 invariants", smith_exponent_invariants(gens,4))
gens = [list(lam_coords(smul(2, g))) for g in [ONE, z, power(z,2)]]
print("control (rank-deficient): <2, 2zeta, 2zeta^2> invariants", smith_exponent_invariants(gens,4))
