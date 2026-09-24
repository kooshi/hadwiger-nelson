"""Task 0: every point and difference vector used by the held step-1 pieces, checked exactly against Lambda = (1/9)O_E
and against its unit-vector set U (54 vectors). omega is read as zeta6 (FS85-A2)."""
from lam import *
U = load_U()
Uset = set(U)
eta = (Fr(0), Fr(1,6), Fr(0), Fr(-1,6))
def pw(a,k):
    r=ONE
    if k<0: a=inv(a); k=-k
    for _ in range(k): r=mul(r,a)
    return r
w = Z6  # the wiki's omega, read as zeta6
e2 = mul(eta,eta); e3 = mul(e2,eta)
def lin(*terms):  # sum of coeff*element, coeff rational or element
    r=(Fr(0),)*4
    for t in terms: r=add(r,t)
    return r
def W(k): return pw(w,k)
def c(q, a): return sc(q, a)
S3 = add(W(1),W(2))       # omega + omega^2 = sqrt(-3)
S45 = add(W(4),W(5))
# identities (8), (9) with omega = zeta6, and with omega = zeta3 (the page's stated reading) as the control that must fail
print('(8) zeta6:', eta == add(mul(S45,e2), S3), '  (9) zeta6:', e3 == add(mul(sc(Fr(2,3),S45),e2), S3))
z3 = W(2)
S3b = add(z3, pw(z3,2)); S45b = add(pw(z3,4), pw(z3,5))
print('(8) zeta3 (control, must be False):', eta == add(mul(S45b,e2), S3b), ' (9) zeta3:', e3 == add(mul(sc(Fr(2,3),S45b),e2), S3b))
# Prop 7 base points (z0 = 0), each must lie in Lambda
pts = {
 'eta2': e2, 'w eta2': mul(W(1),e2), '-w^2 eta2': sc(-1,mul(W(2),e2)), '(1+w)eta2': mul(add(ONE,W(1)),e2),
 '2eta2': sc(2,e2), '(1-w^2)eta2': mul(sub(ONE,W(2)),e2), '2w eta2': sc(2,mul(W(1),e2)), '-2w^2 eta2': sc(-2,mul(W(2),e2)),
 '(2/3)(1+w)eta2': sc(Fr(2,3),mul(add(ONE,W(1)),e2)), '(2/3)(1-w^2)eta2': sc(Fr(2,3),mul(sub(ONE,W(2)),e2)), '0': (Fr(0),)*4,
}
for k,v in pts.items(): print('point', k.ljust(18), 'in Lambda:', in_Lambda(v), ' 9*coords', fmt(tuple(9*x for x in coords(v))))
# relations (P, a_offset_P, Q, a_offset_Q): colours at P + a + offP and Q + a + offQ are adjacent => difference must be in U
R1 = lambda x: x
rels = [
 ('R2 rho_{w e2} vs rho_{e2}', pts['w eta2'], None, pts['eta2'], None),
 ('R6 (8): rho_{-w^2 e2}(a+w+w^2) vs rho_{w e2}(a)', pts['-w^2 eta2'], S3, pts['w eta2'], None),
 ('R7 rho_{(1+w)e2} vs rho_{w e2}', pts['(1+w)eta2'], None, pts['w eta2'], None),
 ('R8 rho_{(1+w)e2}(a) vs rho_0(a+1+w)', pts['(1+w)eta2'], None, pts['0'], add(ONE,W(1))),
 ('R9a rho_{2e2} vs rho_{(1+w)e2}', pts['2eta2'], None, pts['(1+w)eta2'], None),
 ('R9b rho_{2e2}(a) vs rho_{w e2}(a+1-w^2)', pts['2eta2'], None, pts['w eta2'], sub(ONE,W(2))),
 ('R10a rho_{-w^2e2} vs rho_0', pts['-w^2 eta2'], None, pts['0'], None),
 ('R10b rho_{-w^2e2}(a) vs rho_{2e2}(a-(2+w^2))?', pts['-w^2 eta2'], None, pts['2eta2'], sc(-1,add(sc(2,ONE),W(2)))),
 ('R12a rho_{2w e2} vs rho_{w e2}', pts['2w eta2'], None, pts['w eta2'], None),
 ('R12b rho_{2w e2} vs rho_{(1+w)e2}', pts['2w eta2'], None, pts['(1+w)eta2'], None),
 ('R12c rho_{2w e2}(a) vs rho_{e2}(a+w+w^2)', pts['2w eta2'], None, pts['eta2'], S3),
 ('R14a rho_{(2/3)(1+w)e2}(a) vs rho_{2w e2}(a-w-w^2)', pts['(2/3)(1+w)eta2'], None, pts['2w eta2'], sc(-1,S3)),
 ('R14b rho_{(2/3)(1+w)e2}(a) vs rho_0(a+1+w)', pts['(2/3)(1+w)eta2'], None, pts['0'], add(ONE,W(1))),
 ('R14c rho_{(2/3)(1+w)e2}(a) vs rho_{2e2}(a-1+w^2)', pts['(2/3)(1+w)eta2'], None, pts['2eta2'], add(sc(-1,ONE),W(2))),
 ('R15 rho_{(2/3)(1+w)e2}(a) vs rho_{(2/3)(1-w^2)e2}(a+w+w^2)', pts['(2/3)(1+w)eta2'], None, pts['(2/3)(1-w^2)eta2'], S3),
 ('P3 rho_{-w^2e2}(a) vs rho_{w e2}(a-w-w^2)', pts['-w^2 eta2'], None, pts['w eta2'], sc(-1,S3)),
 ('P3 rho_{w e2} vs rho_0', pts['w eta2'], None, pts['0'], None),
]
zero=(Fr(0),)*4
for name,P,oP,Q,oQ in rels:
    d = sub(add(P, oP or zero), add(Q, oQ or zero))
    print(name.ljust(55), 'diff in U:', d in Uset, ' in Lambda:', in_Lambda(d))
# Hubai's five-rotation word, omega1 = zeta6, omega3 = eta^2; start point x, apply w1..w5 in order
def rot(r, p):
    return lambda z: add(p, mul(r, sub(z, p)))
Z3 = W(2); one=ONE; O=(Fr(0),)*4
word = [('zeta6^2 about 0', rot(Z3, O)), ('zeta6^-2 eta2 about 1', rot(mul(inv(Z3),e2), one)),
        ('zeta6^-2 eta^-2 about 0', rot(mul(inv(Z3),inv(e2)), O)), ('zeta6^2 eta^-2 about 1', rot(mul(Z3,inv(e2)), one)),
        ('eta2 about 0', rot(e2, O))]
for start_name, x in [('0', O), ('1', one), ('zeta6', W(1)), ('eta2', e2)]:
    z = x; trail=[]
    for nm,f in word:
        z = f(z); trail.append((nm, in_Lambda(z)))
    print('Hubai word from', start_name, '-> translation', fmt(sub(z,x)), '| intermediate points in Lambda:', [t[1] for t in trail])
print('8/3 in Lambda:', in_Lambda((Fr(8,3),Fr(0),Fr(0),Fr(0))), ' 9*coords', fmt(tuple(9*x for x in coords((Fr(8,3),Fr(0),Fr(0),Fr(0))))))
import lam as _L
Ww=_L.W
print('--- Hubai word on a Z-basis of Lambda (1/9)(1, zeta6, w, zeta6 w), and on eta:')
for nm, x in [('1/9', sc(Fr(1,9),ONE)), ('zeta6/9', sc(Fr(1,9),Z6)), ('w/9', sc(Fr(1,9),Ww)), ('zeta6 w/9', sc(Fr(1,9),mul(Z6,Ww))), ('eta', eta), ('eta^3', e3)]:
    z = x; flags=[]
    for n,f in word:
        z=f(z); flags.append(in_Lambda(z))
    print(nm.ljust(10), flags)
# which multiples: is Lambda closed under multiplication by eta^2?  (x in Lambda => eta2 x in Lambda?)
for nm, x in [('1/9', sc(Fr(1,9),ONE)), ('w/9', sc(Fr(1,9),Ww)), ('1', ONE), ('w', Ww)]:
    print('eta2 *', nm, 'in Lambda:', in_Lambda(mul(e2,x)))
