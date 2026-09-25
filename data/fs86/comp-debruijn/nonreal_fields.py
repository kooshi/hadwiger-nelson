# Exact arithmetic only: find imaginary quadratic E = Q(sqrt(-d)) with
#  (a) Q2(sqrt(-d)) = Q2(sqrt3)  <=>  d = 5 mod 8
#  (b) 3, 7, 11, 19 inert in E (so no stable place with residue F3, F7, F11, F19)
#  (c) every prime factor of d is = 1 mod 4 (ramified places non-stable)
from sympy import factorint, legendre_symbol, isprime
def ok(d):
    if d % 8 != 5: return False
    f = factorint(d)
    if any(e > 1 for e in f.values()): return False
    if any(p % 4 != 1 for p in f): return False
    for p in (3, 7, 11, 19):
        if d % p == 0: return False
        if legendre_symbol((-d) % p, p) != -1: return False
    return True
hits = [d for d in range(1, 20000) if ok(d)]
print(len(hits), hits[:25])
# control: the real field Q(sqrt59): which of 3,7,11,19 are stable with residue F_p?
for p in (3,7,11,19,23,31):
    print('Q(sqrt59) at', p, 'legendre(59/p)=', legendre_symbol(59 % p, p))
