# FS-86 stage A spec checks (seconds): splitting, stability, local dyadic field, unit vectors of the saturated chain.
import math, sys
from sympy import legendre_symbol, isprime, factorint
def split_table(d, P=60):
    rows=[]
    for p in range(3,P):
        if not isprime(p): continue
        if d % p == 0: kind='ram'; q=p
        elif legendre_symbol(d % p, p)==1: kind='split'; q=p
        else: kind='inert'; q=p*p
        stable = (q % 4 == 3)
        rows.append((p,kind,q,'STABLE' if stable else 'nonstable'))
    return rows
for d in (59,83,131,11,167,47):
    print(d, 'd mod 8 =', d%8, 'd mod 12 =', d%12, 'd mod 7 =', d%7, ' d*3 mod 8 =', (3*d)%8, '(Q2(sqrt d)=Q2(sqrt3) iff 3d = 1 mod 8)')
    print('  ', [(p,k,q,s) for (p,k,q,s) in split_table(d)])
