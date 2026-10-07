#!/usr/bin/env python3
"""FS133-E1: exact control for the cross-term step of C133-PAIR (plans/FS133-E1-derivation.md, stage 6).

The derivation recovers a cross term B(b_i, b_j) = <b_i, M b_j> of a sesquilinear form from the values of the quadratic form
Q(v) = <v, M v> at the four vectors b_i, b_j, b_i + b_j, b_i + i*b_j:
    2 B(b_i, b_j) = S + i*D,   S = Q(b_i + b_j) - Q(b_i) - Q(b_j),   D = Q(b_i + i*b_j) - Q(b_i) - Q(b_j).
(So if Q vanishes at all four, the cross term vanishes.)  Here M is a fixed 3x3 matrix of Gaussian integers that is NOT
Hermitian (a translation operator is unitary, not self-adjoint), and b_i, b_j fixed Gaussian-integer vectors; arithmetic is exact
in Z[i].  Mode 'complex' prints whether 2 B(b_i, b_j) == S + i*D.  Mode 'real' (the fault: the real polarisation alone, without
the vector b_i + i*b_j) prints whether 2 B(b_i, b_j) == S, which fails because B(b_i, b_j) != B(b_j, b_i).
"""
import sys
mode = sys.argv[1]
def mul(a, b): return (a[0]*b[0] - a[1]*b[1], a[0]*b[1] + a[1]*b[0])
def add(a, b): return (a[0] + b[0], a[1] + b[1])
def sub(a, b): return (a[0] - b[0], a[1] - b[1])
def conj(a): return (a[0], -a[1])
I = (0, 1)
M = [[(1, 2), (0, -1), (3, 0)], [(2, 0), (1, 1), (0, 4)], [(-1, 1), (5, 0), (2, -3)]]
bi = [(1, 0), (2, -1), (0, 3)]
bj = [(0, 1), (1, 1), (-2, 0)]
def apply(M, v):
    return [reduce_sum(mul(M[r][c], v[c]) for c in range(3)) for r in range(3)]
def reduce_sum(it):
    s = (0, 0)
    for x in it: s = add(s, x)
    return s
def B(x, y):            # <x, M y>, linear in x, conjugate-linear in y
    My = apply(M, y)
    return reduce_sum(mul(x[a], conj(My[a])) for a in range(3))
def Q(v): return B(v, v)
vsum = [add(a, b) for a, b in zip(bi, bj)]
vimg = [add(a, mul(I, b)) for a, b in zip(bi, bj)]
S = sub(sub(Q(vsum), Q(bi)), Q(bj))
D = sub(sub(Q(vimg), Q(bi)), Q(bj))
twoB = add(B(bi, bj), B(bi, bj))
assert B(bi, bj) != B(bj, bi)
print(twoB == (add(S, mul(I, D)) if mode == "complex" else S))
