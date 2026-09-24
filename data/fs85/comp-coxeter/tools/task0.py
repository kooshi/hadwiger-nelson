"""Task 0: every point and every difference the wiki's Prop. 7 (all three parts) uses, checked exactly in Lambda.
Each wiki inequality 'rho_{z1}(a+s1) != rho_{z2}(a+s2) + t' compares the colours of the points z1+a+s1 and z2+a+s2;
it is a unit-edge statement iff their difference (z1+s1)-(z2+s2) lies in U.  omega is read as zeta6."""
from efield import *
from fractions import Fraction as Q
w=Z; e2=ETA**2
U=set(UNITS)
T=E(Q(2,3))
reps={ '0':E(0), 'eta2':e2, 'w eta2':w*e2, '-w2 eta2':-(w**2)*e2, '(1+w)eta2':(1+w)*e2, '2eta2':2*e2,
       '(1-w2)eta2':(1-w**2)*e2, '2w eta2':2*w*e2, '-2w2 eta2':-2*(w**2)*e2,
       '(2/3)(1+w)eta2':T*(1+w)*e2, '(2/3)(1-w2)eta2':T*(1-w**2)*e2 }
for k,v in reps.items(): print('rep %-18s in Lambda: %s  9*coords %s'%(k, v.in_lattice(), v.coords9()))
# (z1, s1, z2, s2) : points z1+s1 and z2+s2 (a common a dropped)
R=reps
ineq=[
 ('P7.1 rho_{w eta2}(a) != rho_{eta2}(a)',              R['w eta2'],0, R['eta2'],0),
 ('P7.1 (8): rho_{-w2eta2}(a+w+w2) != rho_{weta2}(a)+..', R['-w2 eta2'],w+w**2, R['w eta2'],0),
 ('P7.1 rho_{(1+w)eta2} != rho_{w eta2}',               R['(1+w)eta2'],0, R['w eta2'],0),
 ('P7.1 (8): rho_{(1+w)eta2}(a) != rho_0(a+1+w)+w2',     R['(1+w)eta2'],0, R['0'],1+w),
 ('P7.1 Cor5 rho_{(1+w)eta2} vs rho_{eta2}',            R['(1+w)eta2'],0, R['eta2'],0),
 ('P7.1 rho_{2eta2} != rho_{(1+w)eta2}',                 R['2eta2'],0, R['(1+w)eta2'],0),
 ('P7.1 (8): rho_{2eta2}(a) != rho_{weta2}(a+1-w2)+w',   R['2eta2'],0, R['w eta2'],1-w**2),
 ('P7.1 Cor5 rho_{2eta2} vs rho_{eta2}',                 R['2eta2'],0, R['eta2'],0),
 ('P7.1 rho_{-w2eta2} vs rho_0',                         R['-w2 eta2'],0, R['0'],0),
 ('P7.1 (8): rho_{-w2eta2} vs rho_{2eta2}',              R['-w2 eta2'],0, R['2eta2'],None),
 ('P7.1 rho_{(1-w2)eta2} vs rho_{-w2eta2}',              R['(1-w2)eta2'],0, R['-w2 eta2'],0),
 ('P7.1 rho_{2w eta2} vs rho_{w eta2}',                  R['2w eta2'],0, R['w eta2'],0),
 ('P7.1 rho_{2w eta2} vs rho_{(1+w)eta2}',               R['2w eta2'],0, R['(1+w)eta2'],0),
 ('P7.1 (8): rho_{2weta2}(a) != rho_{eta2}(a+w+w2)+1',   R['2w eta2'],0, R['eta2'],w+w**2),
 ('P7.1 rho_{-2w2eta2}(a) vs rho_{eta2}(a-w-w2)',        R['-2w2 eta2'],0, R['eta2'],-(w+w**2)),
 ('P7.1 (9): rho_{(2/3)(1+w)eta2}(a) vs rho_{2weta2}(a-w-w2)', R['(2/3)(1+w)eta2'],0, R['2w eta2'],-(w+w**2)),
 ('P7.1 (9): rho_{(2/3)(1+w)eta2}(a) vs rho_0(a+1+w)',   R['(2/3)(1+w)eta2'],0, R['0'],1+w),
 ('P7.1 (9): rho_{(2/3)(1+w)eta2}(a) vs rho_{2eta2}(a-1+w2)', R['(2/3)(1+w)eta2'],0, R['2eta2'],-1+w**2),
 ('P7.1 (9)-mirror: rho_{(2/3)(1-w2)eta2} vs rho_{-2w2eta2}(a+w+w2)', R['(2/3)(1-w2)eta2'],0, R['-2w2 eta2'],(w+w**2)),
 ('P7.1 (9)-mirror: rho_{(2/3)(1-w2)eta2} vs rho_0(a+1-w2)', R['(2/3)(1-w2)eta2'],0, R['0'],1-w**2),
 ('P7.1 (8): rho_{(2/3)(1+w)eta2}(a) vs rho_{(2/3)(1-w2)eta2}(a+w+w2)', R['(2/3)(1+w)eta2'],0, R['(2/3)(1-w2)eta2'],w+w**2),
 ('P7.3 rho_{w eta2}(a) vs rho_0(a)',                    R['w eta2'],0, R['0'],0),
 ('P7.3 rho_{-w2eta2}(a) vs rho_{w eta2}(a-w-w2)',       R['-w2 eta2'],0, R['w eta2'],-(w+w**2)),
]
for name,z1,s1,z2,s2 in ineq:
    if s2 is None:
        # the shift is not written in the wiki; find the Eisenstein shift s (|coords|<=3) making it a unit edge
        found=[]
        for x in range(-3,4):
            for y in range(-3,4):
                s=E(x,y)
                if (z1-(z2+s)) in U: found.append((x,y))
        print('%-70s shift not stated; Eisenstein shifts s with z1-(z2+s) in U: %s'%(name,found)); continue
    d=(z1+s1)-(z2+s2)
    tag='IN U' if d in U else ('NOT unit; |d|=%.6f'%abs(d.cx()))
    ex=''
    if d in U:
        j,k=[(j,k) for j in range(6) for k in range(-4,5) if Z**j*ETA**k==d][0]; ex='= zeta^%d eta^%d'%(j,k)
    print('%-70s diff %s %s'%(name,tag,ex))
