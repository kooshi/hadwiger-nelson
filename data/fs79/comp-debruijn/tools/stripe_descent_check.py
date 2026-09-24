"""Check C1(c)'s direct proof: for gcd(p,q)=1, the stripe colouring of the triangular lattice, periodic under ker psi, descends to a
proper 4-colouring of G(Z, {p, q, p+q}).  Built explicitly on Z and checked on a long window."""
import math
def colouring(p, q):
    tri = [p, q, -(p + q)]               # psi-values of e1, e2, -(e1+e2)
    i = next(k for k in range(3) if tri[k] % 2 == 0)
    f1, f2 = tri[i], tri[(i + 1) % 3]    # psi(f1) even; {f1, f2, -f1-f2} is the triangle
    # a point of Z is psi(a f1 + b f2) = a*f1 + b*f2; pick any preimage (a, b): need a*f1 + b*f2 = n.  gcd(f1, f2) = 1.
    g, x0, y0 = ext(f1, f2); assert g in (1, -1)
    L = abs(f1)                          # phases defined on rows, extended by phi_r = phi_{r - psi(f1)} + psi(f2)
    def phi(r):
        k, r0 = divmod(r, L)             # r = r0 + k*L ; with psi(f1) = +-L
        sgn = 1 if f1 > 0 else -1
        # phi_{r} = phi_{r - f1} + f2  =>  phi_{r0 + k L} = phi_{r0} + k*sgn*f2
        return (k * sgn * f2) % 2
    def col(n):
        a, b = x0 * n * g, y0 * n * g    # a f1 + b f2 = n
        r = b                             # row = f2-coordinate
        pair = (0, 1) if r % 2 == 0 else (2, 3)
        return pair[(a + phi(r)) % 2]
    return col
def ext(a, b):
    if b == 0: return (a, 1, 0)
    g, x, y = ext(b, a % b); return (g, y, x - (a // b) * y)
bad = 0
for p in range(1, 30):
    for q in range(p + 1, 30):
        if math.gcd(p, q) != 1: continue
        c = colouring(p, q)
        for n in range(-300, 300):
            for d in (p, q, p + q):
                if c(n) == c(n + d): bad += 1; print('improper', p, q, n, d); break
            if bad: break
        if bad > 3: break
print('pairs checked, improper found:', bad)
