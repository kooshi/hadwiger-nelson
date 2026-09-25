import cmath, math, itertools
z6=cmath.exp(1j*math.pi/3); eta=(math.sqrt(33)+1j*math.sqrt(3))/6
assert abs(abs(eta)-1)<1e-12 and abs(eta**2-(5+1j*math.sqrt(11))/6)<1e-12
def V(n): return [0j]+[z6**i*eta**j for i in range(6) for j in range(-n,n+1)]
v=-(4/9)*(1+1j*math.sqrt(11))
# orbit of v under zeta6 and complex conjugation and the Galois flip (sqrt-11 -> -sqrt-11): v' = -(4/9)(1 - i sqrt11)
orb=set()
for base in (v, -(4/9)*(1-1j*math.sqrt(11))):
    for i in range(6):
        for w in (z6**i*base, (z6**i*base).conjugate()):
            orb.add((round(w.real,9),round(w.imag,9)))
print('orbit size', len(orb), '|v| =', abs(v), '8/sqrt27 =', 8/math.sqrt(27))
for n in (3,):
    S=V(n)
    pts={}
    for a,b,c in itertools.combinations_with_replacement(range(len(S)),3):
        p=S[a]+S[b]+S[c]
        key=(round(p.real,9),round(p.imag,9))
        if key not in pts: pts[key]=(a,b,c)
    hit=[k for k in orb if k in pts]
    onr=[k for k in pts if abs(math.hypot(*k)-8/math.sqrt(27))<1e-7]
    print(f'V{7+12*n}+V+V: {len(pts)} points; on radius 8/sqrt27: {len(onr)}; orbit points present: {len(hit)}')
    if hit:
        k=hit[0]; a,b,c=pts[k]; print('witness', k, [(x//(2*n+1) if x else None) for x in (a,b,c)], [S[a],S[b],S[c]])
S=V(3); pts={}
for a,b,c in itertools.combinations_with_replacement(range(len(S)),3):
    p=S[a]+S[b]+S[c]; key=(round(p.real,9),round(p.imag,9)); pts.setdefault(key,(a,b,c))
onr=[k for k in pts if abs(math.hypot(*k)-8/math.sqrt(27))<1e-7]
for k in sorted(onr): print(k, 'arg/deg', round(math.degrees(math.atan2(k[1],k[0])),6), 'vs (8/9)i*sqrt3*z6^m ->', [m for m in range(6) if abs(complex(*k)-(8/9)*1j*math.sqrt(3)*z6**m)<1e-8], pts[k])
# also: with V55 (n=4) as in his second sentence?
