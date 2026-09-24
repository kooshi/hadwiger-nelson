import sys, itertools, collections
import numpy as np
from degrey_lang import load
from lang_heights import solve, type_of
from heights_edge import canon_gens, neg
H, U8, U, cols = load()
A = np.array([[int(ch) for ch in c] for c in cols], dtype=np.int64).reshape(len(cols), 8, 8, 8, 8)
S = sorted(set(tuple(u) for u in U) | set(neg(tuple(u)) for u in U))
gens = canon_gens(S)
n = len(gens)
def shift(arr, v):
    # value at p of the result = arr at p + v
    return np.roll(arr, shift=tuple(-x for x in v), axis=(1, 2, 3, 4))
# properness check (control)
for u in gens:
    assert not np.any(A == shift(A, u)), 'improper'
occ = {}
types = collections.Counter()
for i, j in itertools.combinations(range(n), 2):
    s, t = gens[i], gens[j]
    st = tuple(a + b for a, b in zip(s, t))
    code = A * 64 + shift(A, s) * 16 + shift(A, st) * 4 + shift(A, t)
    u = np.unique(code)
    pats = {(int(c) // 64, (int(c) // 16) % 4, (int(c) // 4) % 4, int(c) % 4) for c in u}
    occ[(i, j)] = pats
    types[tuple(sorted({type_of(q) for q in pats}))] += 1
null, neq = solve(gens, occ)
print('n', n, 'language nullity mod p', null, 'trivial', 3 + n, 'extra', null - 3 - n, 'equations', neq)
print('pair type-sets:', dict(types))
import pickle; pickle.dump((gens, occ), open('degrey_occ.pkl', 'wb'))
