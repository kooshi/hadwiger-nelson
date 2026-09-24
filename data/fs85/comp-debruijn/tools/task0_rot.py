"""Transfer check for the wiki's Prop. 7 / Cor. 8 in the rotated orientations eta^k T0, k in {-1,-2}: every base point and every
relation of the original configuration AND of its complex-conjugate mirror (the wiki's 'similarly / by conjugation symmetry' steps),
multiplied by eta^k, must lie in Lambda with differences in U. (Orientations +1, +2 follow by conjugation of the whole lattice.)"""
import importlib, io, contextlib
with contextlib.redirect_stdout(io.StringIO()):
    import task0 as T
from lam import *
U = set(load_U())
eta = T.eta
def pw(a,k):
    r=ONE
    if k<0: a=inv(a); k=-k
    for _ in range(k): r=mul(r,a)
    return r
zero=(Fr(0),)*4
pts = list(T.pts.values())
rels = [(P, oP or zero, Q, oQ or zero) for _, P, oP, Q, oQ in T.rels]
for k in (0, -1, -2):
    r = pw(eta, k); ok_pts = ok_rel = True; bad = []
    for mirror in (False, True):
        f = (lambda x: mul(r, conj(x))) if mirror else (lambda x: mul(r, x))
        for p in pts:
            if not in_Lambda(f(p)): ok_pts = False; bad.append(('pt', mirror, fmt(p)))
        for P, oP, Q, oQ in rels:
            d = sub(f(add(P, oP)), f(add(Q, oQ)))
            if d not in U: ok_rel = False; bad.append(('rel', mirror))
        # Cor. 8 steps: z + a*eta^2 with a in mu6: the rotated generator eta^k * eta^2 * zeta6^j (mirror: eta^k * eta^-2 * zeta6^j)
        for j in range(6):
            g = f(mul(pw(Z6,j), mul(eta,eta)))
            if not in_Lambda(g): ok_pts = False; bad.append(('cor8', mirror, j))
    print('orientation eta^%d: all points in Lambda: %s, all relation differences in U: %s %s' % (k, ok_pts, ok_rel, bad[:4]))

print('--- the wiki\'s "similarly" steps are the PARTIAL conjugation alpha + beta*eta^2 -> conj(alpha) + conj(beta)*eta^2 (alpha, beta in Q(zeta6)):')
import sympy
def split(x):
    """write x = alpha + beta*eta^2 with alpha, beta in Q(zeta6) (exact, via the Q-basis 1, zeta6, eta^2, zeta6 eta^2)."""
    e2 = mul(eta, eta)
    B = [ONE, Z6, e2, mul(Z6, e2)]
    Mx = sympy.Matrix([[sympy.Rational(b[i].numerator, b[i].denominator) for b in B] for i in range(4)])
    v = sympy.Matrix([sympy.Rational(t.numerator, t.denominator) for t in x])
    s = Mx.LUsolve(v); s = [Fr(int(q.p), int(q.q)) for q in s]
    return (s[0], s[1]), (s[2], s[3])
def zc(c):  # conj of c0 + c1*zeta6 : zeta6 -> 1 - zeta6
    return (c[0] + c[1], -c[1])
def pconj(x):
    (a0, a1), (b0, b1) = split(x)
    e2 = mul(eta, eta)
    A = zc((a0, a1)); Bc = zc((b0, b1))
    return add(add(sc(A[0], ONE), sc(A[1], Z6)), mul(add(sc(Bc[0], ONE), sc(Bc[1], Z6)), e2))
for k in (0, -1, -2):
    r = pw(eta, k); ok = True
    for f in (lambda x: mul(r, x), lambda x: mul(r, pconj(x))):
        for p in pts:
            ok &= in_Lambda(f(p))
        for P, oP, Q, oQ in rels:
            ok &= sub(f(add(P, oP)), f(add(Q, oQ))) in U
    print('orientation eta^%d with the partial-conjugate mirror: all points in Lambda and all differences in U: %s' % (k, ok))
