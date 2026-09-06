# usable primes: p = 3 mod 4 such that every radicand d in the multiquadratic field is a square mod p (or 0 mod p)
def legendre(a, p):
    a %= p
    if a == 0: return 0
    return 1 if pow(a, (p-1)//2, p) == 1 else -1
def usable(rads, bound=1000):
    out = []
    for p in range(3, bound):
        if all(p % q for q in range(2, int(p**0.5)+1)) and p % 4 == 3:
            if all(legendre(d, p) >= 0 for d in rads):
                out.append(p)
    return out
fields = {
 "Q(sqrt3,sqrt11) = K": [3, 11],
 "Q(sqrt3,sqrt5,sqrt11) Heule": [3, 5, 11],
 "Q(sqrt3,sqrt5,sqrt7,sqrt11) de Grey": [3, 5, 7, 11],
 "K(sqrt5)": [3, 5, 11],
 "K(sqrt7)": [3, 7, 11],
 "K(sqrt5,sqrt7)": [3,5,7,11],
 "K(sqrt247) T20": [3, 11, 247],
 "K(sqrt5,sqrt247)": [3, 5, 11, 247],
 "K(sqrt35)": [3, 11, 35],
 "Q(sqrt3) hex fabric only": [3],
 "Q(sqrt11)": [11],
 "Q(sqrt5)": [5],
 "Q(sqrt7)": [7],
 "Q(sqrt2)": [2],
}
for name, r in fields.items():
    u = usable(r, 400)
    print(f"{name:40s} usable p<400: {u[:8]}")
