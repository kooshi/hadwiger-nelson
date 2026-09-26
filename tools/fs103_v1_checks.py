#!/usr/bin/env python3
"""FS103-V1 exact checks (pure Python; independent of the PARI scripts in data/fs103/fs103-v1/).

1. C-635-PL: 635087 prime, = 7 (mod 8); stable places of Q(sqrt d) below a bound: primes p = 3 (mod 4) split or ramified
   (odd stable <=> residue field F_q with q = 3 mod 4; in a quadratic field q = p exactly when p splits or ramifies);
   dyadic place: d = 7 (mod 8) => Q_2(sqrt d) = Q_2(sqrt 7) = Q_2(i), split in L/F.
2. Level-one mixing constants lambda*(Gamma_p) = max_{n != 0} |sum_{s^2+t^2=1} e((a s + b t)/p)| / (p+1), a^2+b^2 = n,
   with controls from LEDGER / FS100-derivation: Gamma_11 0.476413, Gamma_19 0.380486; Gamma_59 Hoffman ratio 0.199119854095.
3. F_dG stable primes below 600 by Legendre symbols (Frobenius trivial on all of sqrt3, sqrt5, sqrt7, sqrt11), vs PARI's 131, 479.
Plants: --plant-d (d -> 635083, = 3 mod 8: the dyadic check must fire), --plant-sign (drop the minus-one test: must mis-list),
--plant-spec (sum only half the circle: the controls must fire).
"""
import math, sys

PLANT = set(a for a in sys.argv[1:] if a.startswith('--plant'))
fails = []
def check(cond, msg):
    print(('PASS ' if cond else 'FAIL ') + msg)
    if not cond: fails.append(msg)

def isprime(n):
    if n < 2: return False
    i = 2
    while i * i <= n:
        if n % i == 0: return False
        i += 1
    return True

def legendre(a, p):
    a %= p
    if a == 0: return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1

# 1. C-635-PL
d = 635083 if '--plant-d' in PLANT else 635087
check(isprime(d) and d % 8 == 7, f"d={d} prime and = 7 mod 8 (dyadic place split in L/F)")
def stable_quadratic(d, bound):
    out = []
    for p in range(3, bound, 2):
        if not isprime(p): continue
        if '--plant-sign' not in PLANT and p % 4 != 3: continue
        if legendre(d, p) in (0, 1): out.append(p)
    return out
st = stable_quadratic(d, 200)
check(st[:5] == [103, 107, 127, 163, 191], f"first stable primes of Q(sqrt{d}): {st[:6]} (claim: 103, 107, 127, 163, 191)")
check(all(legendre(d, p) == -1 for p in range(3, 103) if isprime(p) and p % 4 == 3), "every p = 3 mod 4 below 103 inert")
check(d % 4 == 3, f"ramified place {d}: residue F_{d}, {d} = 3 mod 4, so stable")
check(d % 3 != 0 and legendre(d * 3, 3) != 1 and not any(d == 3 * k * k for k in range(1, 500)), "3d not a square: sqrt3 not in F (no unit triangle)")
st167 = stable_quadratic(167, 100)
check(st167[:2] == [23, 43] and 167 % 8 == 7, f"control Q(sqrt167): first stable {st167[:3]}, dyadic split")

# 2. level-one spectra
def lam_star(p):
    circ = [(s, t) for s in range(p) for t in range(p) if (s * s + t * t) % p == 1]
    if '--plant-spec' in PLANT: circ = circ[: len(circ) // 2]
    assert len(circ) == p + 1 or '--plant-spec' in PLANT
    reps = {}
    for a in range(p):
        for b in range(p):
            n = (a * a + b * b) % p
            if n and n not in reps: reps[n] = (a, b)
    best = 0.0
    for n, (a, b) in reps.items():
        v = sum(math.cos(2 * math.pi * ((a * s + b * t) % p) / p) for s, t in circ)
        best = max(best, abs(v) / (p + 1))
    return best
lam = {p: lam_star(p) for p in [3, 7, 11, 19, 23, 31, 43, 47, 59, 67, 71, 79, 83, 103, 107, 127, 131]}
for p, v in lam.items(): print(f"   lambda*(Gamma_{p}) level one = {v:.9f}   Weil 2sqrt(p)/(p+1) = {2*math.sqrt(p)/(p+1):.6f}")
check(abs(lam[11] - 0.476413) < 5e-6 and abs(lam[19] - 0.380486) < 5e-6, "controls: Gamma_11 0.476413, Gamma_19 0.380486")
# row 110's "59 has ratio 0.199119854095" is the Hoffman ratio lambda*/(1+lambda*), not lambda* (stage-2 correction of my stage-1 reading)
check(abs(lam[59] / (1 + lam[59]) - 0.199119854095) < 1e-9, "control: Gamma_59 Hoffman ratio 0.199119854095 (row 110)")
check(max(lam[p] for p in (103, 107, 127)) < 0.2 and 2 * math.sqrt(103) / 104 < 0.2, "103, 107, 127 and Weil at q >= 103 below 1/5")

check(lam[131] < 0.2 and abs(lam[131] - 0.168047) < 5e-6, f"C-131: lambda*(Gamma_131) = {lam[131]:.6f} (a positive eigenvalue) < 1/5; Weil 0.173417")
check(all(lam[p] >= 0.2 for p in (59, 67, 71, 79, 83)), "non-6-thick at level one: 59, 67, 71, 79, 83 (71 by its positive eigenvalue 0.2204; its lambda_min/d = -0.1968)")
# 3. F_dG stable primes (unramified p: stable iff f = 1 and p = 3 mod 4; f = 1 iff 3, 5, 7, 11 all squares mod p)
dg = [p for p in range(13, 600) if isprime(p) and p % 4 == 3 and all(legendre(r, p) == 1 for r in (3, 5, 7, 11))]
check(dg == [131, 479], f"F_dG stable primes below 600 (unramified): {dg}")
# ramified 3, 7, 11 (= 3 mod 4): residue field contains sqrt of a unit class that is a non-residue -> F_{p^2}, not stable
check(legendre(5, 3) == -1 and legendre(3, 7) == -1 and legendre(7, 11) == -1, "ramified 3, 7, 11: residue field F_{p^2} (5 mod 3, 3 mod 7, 7 mod 11 non-residues)")
print("FAILURES:", len(fails))
sys.exit(1 if fails else 0)
