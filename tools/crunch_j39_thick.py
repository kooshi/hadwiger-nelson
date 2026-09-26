"""J39: exact-to-float check of the mixing constant lambda* of the stable local planes of Q(sqrt167) at 23, 43, 59.

lambda*(p, level m) = max over characters xi of (Z/p^m)^2 that do not factor through a coarser level, of
|sum_{u in C_m} e(xi.u / p^m)| / |C_m|, where C_m = {(x, y) in (Z/p^m)^2 : x^2 + y^2 = 1} (the circle, |C_m| = p^(m-1)(p+1)
for p = 3 mod 4). Claim checked (J39 T-J39-4 input, J21-TH's table): at level one, lambda*(23) = 0.33170 lies in (1/4, 1/3):
23 is 4-thick and not 5-thick; lambda*(43) = 0.27187 and lambda*(59) = 0.24863 are below 1/3. At level two (23 only) the new
characters are at most 2/(p+1). Float sums of <= 552 unit-modulus terms: absolute error < 1e-9, far below every margin used.
Plants (--plant): include xi = 0 (must give 1, firing the "< 1/3" assertion) and use the wrong curve x^2 - y^2 = 1 (the split hyperbola, p - 1 points).
(First plant tried, x^2 + y^2 = 2, could not fire: 2 is a square mod 23, so it is a scaled copy with the same spectrum.)
"""
import sys
import numpy as np

def circle(q):
    x = np.arange(q)
    X, Y = np.meshgrid(x, x, indexing="ij")
    m = (X * X + Y * Y) % q == 1
    return np.stack([X[m], Y[m]], axis=1)

def circle_wrong(q):
    x = np.arange(q)
    X, Y = np.meshgrid(x, x, indexing="ij")
    m = (X * X - Y * Y) % q == 1
    return np.stack([X[m], Y[m]], axis=1)

def lam_star(p, level=1, include_zero=False, circ=circle):
    q = p ** level
    C = circ(q)
    xs = np.arange(q)
    best = 0.0
    for a in xs:
        # characters xi = (a, b), all b at once
        ph = (a * C[:, 0])[None, :] + xs[:, None] * C[None, :, 1]
        vals = np.abs(np.exp(2j * np.pi * (ph % q) / q).sum(axis=1)) / len(C)
        if level == 1:
            new = np.ones(q, bool)
            if a == 0 and not include_zero:
                new[0] = False
        else:
            # new characters: not both coordinates divisible by p
            new = ((xs % p) != 0) | (a % p != 0)
        if new.any():
            best = max(best, vals[new].max())
    return best, len(C)

def main(plant):
    out = []
    if plant == "zero":
        v, n = lam_star(23, include_zero=True)
        out.append(f"PLANT zero: lambda*(23) = {v:.6f}")
        assert v < 1 / 3, "plant fired: xi = 0 gives 1"
        return out
    if plant == "wrongcircle":
        v, n = lam_star(23, circ=circle_wrong)
        out.append(f"PLANT wrong curve: |C| = {n}, lambda* = {v:.6f}")
        assert n == 24 and abs(v - 0.33170) < 1e-4, "plant fired: the wrong circle does not reproduce J21's table"
        return out
    for p in (23, 43, 59):
        v, n = lam_star(p)
        assert n == p + 1, (p, n)
        out.append(f"p={p} level 1: |C|={n}, lambda* = {v:.6f}")
    v23, _ = lam_star(23)
    assert 1 / 4 < v23 < 1 / 3, v23           # 4-thick, not 5-thick
    assert abs(v23 - 0.33170) < 5e-5
    assert lam_star(43)[0] < 1 / 3 and lam_star(59)[0] < 1 / 3
    v2, n2 = lam_star(23, level=2)
    assert n2 == 23 * 24, n2
    out.append(f"p=23 level 2 new characters: |C|={n2}, max = {v2:.6f} (2/(p+1) = {2/24:.6f})")
    assert v2 <= 2 / 24 + 1e-9
    out.append("ALL ASSERTIONS PASS")
    return out

if __name__ == "__main__":
    plant = sys.argv[2] if len(sys.argv) > 2 and sys.argv[1] == "--plant" else None
    try:
        for line in main(plant):
            print(line)
    except AssertionError as e:
        print("ASSERTION FIRED:", e)
        sys.exit(1)
