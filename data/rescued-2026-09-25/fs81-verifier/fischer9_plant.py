"""Negative control for §F.5 (C3): Fischer 1990 Thm 9's additive 3-colourings of Q(sqrt N)^2, N = 3, 7 (mod 12), checked
nonzero mod 3 on every primitive unit vector ((a1+b1 i) + (a2+b2 i) sqrt N)/c with c <= C (exact integers)."""
import math, sys
def fischer(N, a1, b1, a2, b2, c):
    if c % 3 == 0:
        return None
    num = (a1 + b1 + a2 + b2)
    return (num * pow(c, -1, 3)) % 3
for N in (11, 23, 35):
    C = 60 if N < 20 else 40
    count = bad = cdiv3 = 0
    for c in range(1, C + 1):
        for a2 in range(-c, c + 1):
            for b2 in range(-c, c + 1):
                r = c * c - N * (a2 * a2 + b2 * b2)
                if r < 0:
                    continue
                for a1 in range(-math.isqrt(r), math.isqrt(r) + 1):
                    b1s = r - a1 * a1
                    b1 = math.isqrt(b1s)
                    if b1 * b1 != b1s:
                        continue
                    for bb in {b1, -b1}:
                        if a1 * a2 + bb * b2 != 0:
                            continue
                        if math.gcd(math.gcd(math.gcd(a1, bb), math.gcd(a2, b2)), c) != 1:
                            continue
                        count += 1
                        v = fischer(N, a1, bb, a2, b2, c)
                        if v is None:
                            cdiv3 += 1
                        elif v == 0:
                            bad += 1
    print(f"N={N:>3} (N mod 12 = {N % 12:>2}): {count} primitive unit vectors with c <= {C}; c divisible by 3: {cdiv3}; Fischer's map zero: {bad}")
