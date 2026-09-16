"""Delsarte LP (Schrijver theta-prime) bound on alpha(U_64), reduced by the mu_65 rotations to 64 norm classes (FS-54).

  .venv/bin/python tools/fs54_char2_q64_lp.py

A float LP; it came out at exactly the Hoffman bound 768, so no certificate was built.
"""
import sys, numpy as np, time
sys.path.insert(0, "tools")
from fs54_wall_feedback_verify import GF2m
from scipy.optimize import linprog
E = GF2m(12); Q = 64; n = E.size
N = [E.pow(x, Q + 1) for x in range(n)]          # norm into F_64 (as field elements of F_4096)
F64 = sorted(set(N)); assert len(F64) == 64
idx = {t: i for i, t in enumerate(F64)}
one = idx[1]; zero = idx[0]
# K[s][t] = sum over x with N(x)=t of (-1)^Tr(a x), a any element with N(a)=s (s != 0); s = 0 means a = 0
rep = {}
for a in range(n):
    rep.setdefault(N[a], a)
K = np.zeros((64, 64), dtype=np.int64)
for s_el, a in rep.items():
    for x in range(n):
        K[idx[s_el], idx[N[x]]] += 1 - 2 * E.tr2(E.mul(a, x))
size = np.bincount([idx[t] for t in N], minlength=64)
assert K[zero].tolist() == size.tolist() and size[one] == 65
# check that K[s] depends only on norm: spot check with another a of the same norm
for s_el, a in [(s, a) for s, a in rep.items() if s != 0][:5]:
    b = next(y for y in range(n) if N[y] == s_el and y != a)
    row = np.zeros(64, dtype=np.int64)
    for x in range(n): row[idx[N[x]]] += 1 - 2 * E.tr2(E.mul(b, x))
    assert (row == K[idx[s_el]]).all()
# LP: maximize sum_t size_t g_t ; g_zero = 1 ; g_one = 0 ; g >= 0 ; K g >= 0
c = -size.astype(float)
A_ub = -K.astype(float); b_ub = np.zeros(64)
bounds = [(0, None)] * 64; bounds[zero] = (1, 1); bounds[one] = (0, 0)
r = linprog(c, A_ub=A_ub, b_ub=b_ub, bounds=bounds, method="highs")
print("Delsarte LP (theta') bound on alpha(U_64):", -r.fun, "status", r.status)
print("Hoffman 768; six needs 683; seven needs 586")
np.save("build/fs54-u64/lp64K.npy", K)
