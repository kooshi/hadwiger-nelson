#!/usr/bin/env python3
"""FS131-K10: the usable residue fields of F = Q(sqrt3, sqrt11) . E7 (E7 the degree-7 subfield of Q(zeta_29)), by exact arithmetic.

For a rational prime p, the residue degree of F at a place above p is f = lcm(fK, f7):
  f7 = 1 if p^4 = 1 (mod 29) (p a 7th-power residue), 7 otherwise (p != 29; 29 is totally ramified in E7, f7 = 1);
  fK = residue degree in K = Q(sqrt3, sqrt11): the least f with 3 and 11 both squares in F_{p^f} (1 or 2), read off the
       three quadratic subfields; at p = 2, 3, 11 computed from the local behaviour (2: 33 = 1 mod 8, fK = 1; 3: 11 = 2 is a
       non-residue mod 3, fK = 2; 11: 3 = 5^2 mod 11, fK = 1).
A place is usable when q = p^f = 3 (mod 4), i.e. p = 3 (mod 4) and f odd.  The script lists the usable residue-field sizes
below a bound and prints the least; `--fault` plants a wrong residue test (drops the condition on 11) and must change the answer.

Run:    python3 tools/fs131_k10_usable.py            -> least usable size 347, none below
Fault:  python3 tools/fs131_k10_usable.py --fault    -> exit 1 (a smaller 'usable' size appears)
"""
import sys

def is_prime(n):
    if n < 2: return False
    i = 2
    while i * i <= n:
        if n % i == 0: return False
        i += 1
    return True

def is_square_mod(a, p):
    a %= p
    if a == 0: return True
    return pow(a, (p - 1) // 2, p) == 1

def fK(p, fault=False):
    if p == 2: return 1          # K (x) Q_2 = two copies of Q_2(sqrt3): e = 2, f = 1
    if p == 3: return 2          # 11 = 2 is a non-residue mod 3
    if p == 11: return 1         # 3 = 5^2 mod 11
    ok3 = is_square_mod(3, p)
    ok11 = True if fault else is_square_mod(11, p)
    return 1 if (ok3 and ok11) else 2

def f7(p):
    if p == 29: return 1
    return 1 if pow(p, 4, 29) == 1 else 7

def main():
    fault = '--fault' in sys.argv
    bound = 3 ** 7
    usable = []
    for p in range(2, bound):
        if not is_prime(p) or p % 4 != 3: continue
        f = fK(p, fault) * f7(p) if fK(p, fault) != f7(p) else fK(p, fault)   # lcm of {1,2} and {1,7}
        if f % 2 == 1:
            q = p ** f
            usable.append((q, p, f))
    usable.sort()
    below = [u for u in usable if u[0] < bound]
    print('usable residue fields of size < 3^7 (q, p, f):', below[:8], '...' if len(below) > 8 else '')
    least = usable[0][0] if usable else None
    print('least usable size:', least)
    # the controls the derivation prints (TC1-FIELDS): none of 3, 7, 11, 19, 23, 27, 31, 43, 47
    small = [u for u in usable if u[0] <= 47]
    print('usable of size <= 47:', small)
    # candidates with f7 = 1 below 347, each killed by fK = 2
    cands = [p for p in range(3, 347) if is_prime(p) and p % 4 == 3 and f7(p) == 1]
    print('p < 347, p = 3 mod 4, p^4 = 1 mod 29:', cands, '-> fK:', [fK(p) for p in cands])
    ok = (least == 347) and not small and cands == [59, 191, 307, 331]
    print('CHECK:', 'PASS' if ok else 'FAIL')
    return 0 if ok else 1

if __name__ == '__main__':
    sys.exit(main())
