"""FS131-ICO2: the residue facts behind le_of_isSquare_635087 and le_of_isSquare_deGrey, by exhaustion (exact).
Prints, for each prime p = 3 (mod 4) below the bound, which radicands are non-squares modulo p; fails if one is unrefuted.
--plant: drop 635087's refutation at p = 83 by pretending 635087 is a square there; the check must fail."""
import sys
plant = '--plant' in sys.argv
def isprime(n): return n > 1 and all(n % d for d in range(2, int(n**0.5) + 1))
def issq(a, p): return any((r * r - a) % p == 0 for r in range(p))
bad = 0
ps = [p for p in range(2, 103) if isprime(p) and p % 4 == 3]
for p in ps:
    ok = not issq(635087, p) and not (plant and p == 83)
    print(f'635087 mod {p}: {"non-square" if ok else "SQUARE"}')
    bad += not ok
print(f'635087: {len(ps)} primes below 103; square mod 103: {issq(635087, 103)}; prime: {isprime(635087)}; mod 8: {635087 % 8}')
qs = [p for p in range(2, 131) if isprime(p) and p % 4 == 3]
for p in qs:
    ns = [d for d in (3, 5, 7, 11) if not issq(d, p)]
    print(f'deGrey mod {p}: non-squares {ns}')
    bad += not ns
allsq = [p for p in range(131, 200) if isprime(p) and p % 4 == 3 and all(issq(d, p) for d in (3, 5, 7, 11))]
print(f'deGrey: {len(qs)} primes below 131; first p = 3 mod 4 with all four squares: {allsq[:1]}')
print('FAIL' if bad else 'PASS', bad)
sys.exit(1 if bad else 0)
