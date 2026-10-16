#!/usr/bin/env python3
"""FS131-KFR1: the radicand of the model at k = 7, by the Chinese remainder theorem (a formula, not a search).

d7 = 7 (mod 8) and, for each prime p = 3 (mod 4) below 142, d7 = n_p (mod p) with n_p the least quadratic
non-residue modulo p. Prints d7 and checks every congruence and non-residuosity; --plant breaks one residue and must fail.
"""
import sys
from math import prod

ps = [p for p in range(3, 142) if all(p % q for q in range(2, int(p ** 0.5) + 1)) and p % 4 == 3]
def is_sq(a, p): return pow(a % p, (p - 1) // 2, p) == 1
mods, ress = [8], [7]
for p in ps:
    n = next(a for a in range(2, p) if not is_sq(a, p))
    mods.append(p); ress.append(n)
M = prod(mods)
d = sum(r * (M // m) * pow(M // m, -1, m) for r, m in zip(ress, mods)) % M
if '--plant' in sys.argv:
    d += 8  # keeps d = 7 mod 8, moves every residue
ok = d % 8 == 7 and all(not is_sq(d, p) for p in ps)
print('primes', ps, len(ps))
print('d7', d, 'digits', len(str(d)))
print('OK' if ok else 'FAIL')
sys.exit(0 if ok else 1)
