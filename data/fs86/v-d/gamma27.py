"""Verifier D: least eigenvalue of Gamma_q = Cay(F_q^2, {x^2+y^2=1}) for q = 27 (and controls q = 7, 11, 23, 31),
to read Hoffman's ratio h = -lmin/(d - lmin) against 1/4 (VD-C's per-place bound needs h < 1/4, i.e. lmin > -(q+1)/3).
F_27 = F_3[t]/(t^3 - t - 1). Eigenvalue of character (a,b): sum over circle of cos(2 pi Tr(a x + b y)/3). Exact up to float
summation of 28 cosines; the margin is read at 1e-9 and compared with the prime controls (B1's exact table)."""
import itertools, math, sys

def field(p, f, modpoly):
    # elements as tuples of length f over F_p; modpoly: coefficients c0..c_{f-1} with t^f = sum c_i t^i
    els = list(itertools.product(range(p), repeat=f))
    def add(u, v): return tuple((a + b) % p for a, b in zip(u, v))
    def mul(u, v):
        prod = [0] * (2 * f - 1)
        for i, a in enumerate(u):
            for j, b in enumerate(v):
                prod[i + j] = (prod[i + j] + a * b) % p
        for k in range(2 * f - 2, f - 1, -1):   # reduce t^k, k >= f
            c = prod[k]; prod[k] = 0
            for i, m in enumerate(modpoly):
                prod[k - f + i] = (prod[k - f + i] + c * m) % p
        return tuple(prod[:f])
    return els, add, mul

def trace_fn(p, f, els, mul, add):
    # Tr(x) = x + x^p + ... ; returns the F_p component (constant term)
    def frob(x):
        r = tuple([1] + [0] * (f - 1)); b = x; e = p
        while e:
            if e & 1: r = mul(r, b)
            b = mul(b, b); e >>= 1
        return r
    def tr(x):
        s = x; y = x
        for _ in range(f - 1):
            y = frob(y); s = add(s, y)
        assert all(c == 0 for c in s[1:]), "trace not in F_p"
        return s[0]
    return tr

def lmin(p, f, modpoly):
    els, add, mul = field(p, f, modpoly)
    one = tuple([1] + [0] * (f - 1))
    circ = [(x, y) for x in els for y in els if add(mul(x, x), mul(y, y)) == one]
    tr = trace_fn(p, f, els, mul, add)
    best = None
    for a in els:
        for b in els:
            lam = sum(math.cos(2 * math.pi * tr(add(mul(a, x), mul(b, y))) / p) for x, y in circ)
            if best is None or lam < best: best = lam
    return len(circ), best

if __name__ == "__main__":
    plant = len(sys.argv) > 1 and sys.argv[1] == "--plant"
    cases = [(7, 1, [0]), (11, 1, [0]), (23, 1, [0]), (31, 1, [0]), (3, 3, [1, 1, 0])]  # F_27: t^3 = 1 + t (irreducible over F_3)
    for p, f, mp in cases:
        if f == 1:
            mp = [0]
        d, lm = lmin(p, f, mp) if not (plant and f == 3) else lmin(3, 3, [0, 1, 0])  # plant: t^3 = t, a reducible modulus (not a field)
        q = p ** f
        assert d == q + 1, f"circle has {d} points, expected q+1 = {q+1} (not a field?)"
        h = -lm / (d - lm)
        print(f"q={q:3d} degree={d:3d} lmin={lm:+.9f}  lmin+(q+1)/3={lm + (q + 1) / 3:+.9f}  Hoffman ratio={h:.9f}  <1/4: {h < 0.25}")
