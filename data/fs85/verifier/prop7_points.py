"""Every adjacency the wiki's Prop. 7 (with omega = zeta6) writes, and each mirrored step, checked exactly:
the two base points lie in N+ = T0 + T0*theta (subset of Lambda), the difference of the two points is in U,
and the colour offset (a1 - a2 mod 2) is the one the wiki writes.  A step is (b1, a1, b2, a2, offset):
the relation is rho_{b1}(a) != rho_{b2}(a + (a2-a1)) + offset, from c(b1+a+a1) != c(b2+a+a2)."""
from field import *
from lattice import *
z, eta = ZETA, ETA
e2 = power(eta,2)
w = z                      # omega = zeta6
def P(*cs):                # element sum c_i
    x = ZERO
    for c in cs: x = add(x, c)
    return x
w2 = power(w,2)
U = {mul(power(z,a), power(eta,b)): (a,b) for a in range(6) for b in range(-4,5)}
theta = div(e2, SQ3)
HN = hnf([list(lam_coords(g)) for g in [ONE, z, theta, mul(theta,z)]])
def inN(x): return hnf(HN + [list(lam_coords(x))]) == HN
def f4(x):  # x in T0 -> F4 label
    return {(0,0):'0',(1,0):'1',(0,1):'w',(1,1):'w2'}[red_T0(x)]
b = {  # base points (coset representatives), z0 = 0
 '0': ZERO, 'e2': e2, 'we2': mul(w,e2), '-w2e2': neg(mul(w2,e2)), '(1+w)e2': mul(add(ONE,w),e2),
 '2e2': smul(2,e2), '(1-w2)e2': mul(sub(ONE,w2),e2), '2we2': smul(2,mul(w,e2)), '-2w2e2': smul(-2,mul(w2,e2)),
 '2/3(1+w)e2': smul(Fr(2,3), mul(add(ONE,w),e2)), '2/3(1-w2)e2': smul(Fr(2,3), mul(sub(ONE,w2),e2)),
}
for k, v in b.items(): assert inN(v), k
# (label, b1, shift a1 (in T0), b2, shift a2, offset the wiki writes)
wpw2 = add(w, w2)
steps = [
 ('P7.1 e2 vs 0',                'e2',0,'0',0,'0'),
 ('P7.1 we2 vs 0',               'we2',0,'0',0,'0'),
 ('P7.1 we2 vs e2',              'we2',0,'e2',0,'0'),
 ('P7.1 (4),(8): -w2e2 vs we2',  '-w2e2',wpw2,'we2',ZERO,'1'),
 ('P7.1 (1+w)e2 vs we2',         '(1+w)e2',0,'we2',0,'0'),
 ('P7.1 (4),(8): (1+w)e2 vs 0',  '(1+w)e2',ZERO,'0',add(ONE,w),'w2'),
 ('P7.1 (1+w)e2 vs e2',          '(1+w)e2',0,'e2',0,'0'),
 ('P7.1 2e2 vs (1+w)e2',         '2e2',0,'(1+w)e2',0,'0'),
 ('P7.1 (4),(8): 2e2 vs we2',    '2e2',ZERO,'we2',sub(ONE,w2),'w'),
 ('P7.1 -w2e2 vs 0',             '-w2e2',0,'0',0,'0'),
 ('P7.1 (4),(8): -w2e2 vs 2e2',  '-w2e2',ZERO,'2e2',neg(add(ONE,w)),'w2'),
 ('P7.1 (1-w2)e2 vs -w2e2 [mirror]','(1-w2)e2',0,'-w2e2',0,'0'),
 ('P7.1 (1-w2)e2 vs 0 [mirror]', '(1-w2)e2',ZERO,'0',sub(ONE,w2),'w'),
 ('P7.1 (1-w2)e2 vs e2 [mirror]','(1-w2)e2',0,'e2',0,'0'),
 ('P7.1 2e2 vs (1-w2)e2 [mirror]','2e2',0,'(1-w2)e2',0,'0'),
 ('P7.1 2e2 vs -w2e2 [mirror]',  '2e2',ZERO,'-w2e2',add(ONE,w),'w2'),
 ('P7.1 2we2 vs we2',            '2we2',0,'we2',0,'0'),
 ('P7.1 2we2 vs (1+w)e2',        '2we2',0,'(1+w)e2',0,'0'),
 ('P7.1 (4),(8): 2we2 vs e2',    '2we2',ZERO,'e2',wpw2,'1'),
 ('P7.1 -2w2e2 vs -w2e2 [mirror]','-2w2e2',0,'-w2e2',0,'0'),
 ('P7.1 -2w2e2 vs (1-w2)e2 [mirror]','-2w2e2',0,'(1-w2)e2',0,'0'),
 ('P7.1 -2w2e2 vs e2 [mirror]',  '-2w2e2',ZERO,'e2',neg(wpw2),'1'),
 ('P7.1 (4),(9): 2/3(1+w)e2 vs 2we2','2/3(1+w)e2',ZERO,'2we2',neg(wpw2),'1'),
 ('P7.1 (4),(9): 2/3(1+w)e2 vs 0','2/3(1+w)e2',ZERO,'0',add(ONE,w),'w2'),
 ('P7.1 (4),(9): 2/3(1+w)e2 vs 2e2','2/3(1+w)e2',ZERO,'2e2',sub(w2,ONE),'w'),
 ('P7.1 2/3(1-w2)e2 vs -2w2e2 [mirror]','2/3(1-w2)e2',ZERO,'-2w2e2',wpw2,'1'),
 ('P7.1 2/3(1-w2)e2 vs 0 [mirror]','2/3(1-w2)e2',ZERO,'0',sub(ONE,w2),'w'),
 ('P7.1 2/3(1-w2)e2 vs 2e2 [mirror]','2/3(1-w2)e2',ZERO,'2e2',neg(add(ONE,w)),'w2'),
 ('P7.1 (4),(8): 2/3(1+w)e2 vs 2/3(1-w2)e2','2/3(1+w)e2',ZERO,'2/3(1-w2)e2',wpw2,'1'),
 ('P7.3 -w2e2 vs we2 (4)',       '-w2e2',ZERO,'we2',neg(wpw2),'1'),
]
bad = 0
for lab, b1, a1, b2, a2, off in steps:
    a1 = ZERO if a1 == 0 else a1; a2 = ZERO if a2 == 0 else a2
    d = sub(add(b[b1], a1), add(b[b2], a2))
    unit = d in U
    o = f4(sub(a1, a2)) if a1 != a2 else '0'
    ok = unit and o == off
    bad += not ok
    print(f"{'ok ' if ok else 'BAD'} {lab:42s} diff = zeta^{U[d][0]} eta^{U[d][1]}" if unit else f"BAD {lab} diff not a unit vector",
          f"| offset {o} (wiki {off})")
print("steps:", len(steps), "failures:", bad)
