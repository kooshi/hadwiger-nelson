# Exact re-run of the branch-and-bound: every pruning and every leaf decided by sympy's exact rational simplex.
import itertools, math
from fractions import Fraction as Fr
from sympy import Matrix, Rational, symbols
from sympy.solvers.simplex import lpmin, lpmax
from sympy.core.relational import Ge, Le
def exact_theta(S, r, D, sub, M, Minv, Cu):
    ts = symbols('t0:%d' % r)
    reps = []; seen = set()
    for k in itertools.product(range(D), repeat=r):
        key = tuple(Fr(int(x.p), int(x.q)) % 1 for x in Minv*Matrix(k))
        if key not in seen: seen.add(key); reps.append(k)
        if len(reps) == D: break
    box = []
    for t in ts: box += [Ge(t, Rational(1,3)), Le(t, Rational(2,3))]
    points = []; nodes = 0
    for k in reps:
        stack = [(0, [])]
        while stack:
            idx, cons = stack.pop(); nodes += 1
            if idx == len(Cu):
                # leaf: exact extent per coordinate
                ext = []
                for t in ts:
                    a = lpmin(t, box + cons)[0]; b = lpmax(t, box + cons)[0]
                    ext.append((a, b))
                points.append((k, ext)); continue
            c = [Rational(x.numerator, x.denominator) for x in Cu[idx]]
            ck = sum(c[i]*k[i] for i in range(r))
            f = sum(c[i]*ts[i] for i in range(r))
            try:
                mn = lpmin(f, box + cons)[0]; mx = lpmax(f, box + cons)[0]
            except Exception as e:
                continue  # infeasible
            for j in range(math.floor(mn + ck - Rational(2,3)), math.ceil(mx + ck - Rational(1,3)) + 1):
                l = Rational(1,3) + j - ck; h = Rational(2,3) + j - ck
                if h < mn or l > mx: continue
                stack.append((idx+1, cons + [Ge(f, l), Le(f, h)]))
    return points, nodes, reps
