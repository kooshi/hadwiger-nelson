"""Exact (sympy) verification of designed kill points: a point defined as an intersection of unit
circles about two exact points is expressed in nested radicals; unit distances to seed points are
decided exactly (simplify to 0), with an 80-digit numeric fallback flagged as such."""
import sys, json
sys.path.insert(0, "/home/kooshi/source/lean-dir/tools")
import sympy as sp
import twodist as T
s3, s11, s33 = sp.sqrt(3), sp.sqrt(11), sp.sqrt(33)
def seed_exact(p):
    a, b, c, d = [sp.Rational(x.numerator, x.denominator) for x in p]
    return sp.Matrix([(a*s3 + b*s11)/12, (c + d*s33)/12])
def intersect(U, V, sign):
    D = V - U; d2 = sp.expand(D.dot(D))
    M = (U + V)/2
    R = sp.sqrt(4/d2 - 1)             # p = M ± ½ R (−Dy, Dx)
    P = M + sign*sp.Rational(1, 2)*R*sp.Matrix([-D[1], D[0]])
    return P
import signal
class _TO(Exception): pass
def _alarm(signum, frame): raise _TO()
def is_unit(P, W, budget=10):
    """exact (sympy simplify to 0, `budget` seconds) else 200-digit numeric agreement, labelled."""
    D = P - W; expr = sp.expand(D.dot(D) - 1)
    zn = sp.N(expr, 200)
    if abs(zn) > sp.Rational(1, 10**150): return False, "no"
    signal.signal(signal.SIGALRM, _alarm); signal.alarm(budget)
    try:
        z = sp.simplify(expr); signal.alarm(0)
        if z == 0: return True, "exact"
    except _TO:
        pass
    signal.alarm(0)
    return True, "numeric-200"
if __name__ == "__main__":
    # self-test: the seed's own unit edges via a partner point that IS a seed vertex
    H = T.ei_H(); c = T.classify(H)
    u, v = c[1][0]
    U, V = seed_exact(H[u]), seed_exact(H[v])
    print("seed pair", u, v, "unit exact:", is_unit(U, V))
    P = intersect(U, V, 1); Q = intersect(U, V, -1)
    print("intersection points unit to u,v:", is_unit(P, U), is_unit(P, V), is_unit(Q, U), is_unit(Q, V))
    # a seed vertex w at unit distance from both u and v should be one of P, Q
    W = [w for w in range(len(H)) if (min(u,w),max(u,w)) in set(c[1]) and (min(v,w),max(v,w)) in set(c[1])]
    for w in W:
        Wx = seed_exact(H[w]); print(" common nbr", w, "equals P?", sp.simplify((P-Wx).dot(P-Wx)) == 0, "equals Q?", sp.simplify((Q-Wx).dot(Q-Wx)) == 0)
