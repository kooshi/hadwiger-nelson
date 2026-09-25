"""Is sqrt(-3) = 1 + 2*omega congruent mod P^m to a norm-one unit?  n = 12 (row 67's tower) vs n = 24 (Q(sqrt2,sqrt3))."""
import itertools
from tower import setup
for n in (12, 24):
    d, mul, power_x, conj = setup(n)
    e = 2 if n == 12 else 4
    one = [1]+[0]*(d-1)
    zeta = power_x(n//8) if n % 8 == 0 else power_x(n//4)
    pi = [one[j]-zeta[j] for j in range(d)]; omega = power_x(n//3)
    r3 = [one[j] + 2*omega[j] for j in range(d)]          # sqrt(-3)
    assert mul(r3, r3) == [-3*one[j] for j in range(d)]
    out = []
    for m in range(1, 7):
        k = -(-m//e)
        def ppow(t):
            r = one
            for _ in range(t): r = mul(r, pi)
            return r
        shift = ppow(e*k - m)
        in_Pm = lambda y: all(c % (2**k) == 0 for c in mul(y, shift))
        pis = [ppow(j) for j in range(m)]
        digs = [[0]*d, one, omega, [one[t]+omega[t] for t in range(d)]]
        found = False
        for choice in itertools.product(range(4), repeat=m):
            v = [0]*d
            for j,c in enumerate(choice):
                if c:
                    t = mul(pis[j], digs[c]); v = [v[q]+t[q] for q in range(d)]
            if in_Pm([a-b for a,b in zip(mul(v, conj(v)), one)]) and in_Pm([a-b for a,b in zip(v, r3)]):
                found = True; break
        out.append(f"m={m}:{'yes' if found else 'no'}")
    print(f"n={n} (e={e}): sqrt(-3) ≡ norm-one unit mod P^m?", ", ".join(out))
