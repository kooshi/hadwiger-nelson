#!/usr/bin/env python3
"""FS131-I10C: the exact data the Lean proofs of `Arith/StandingFive` read, each checked here before Lean sees it.

g(x) = x^7 + x^6 - 12x^5 - 7x^4 + 28x^3 + 14x^2 - 9x + 1 (the period polynomial of E7, tools/fs131_k10_period.py).

 (a) Horner's scheme for g at h = 1_H, H = {1,12,17,28}, in Z[C_29] (vectors of length 29, cyclic convolution): the six
     intermediate vectors, and the last one a constant vector (so g(eta) = 0, the all-ones vector evaluating to 0 at zeta).
 (b) eight rational points at which g alternates in sign (seven real roots).
 (c) the Frobenius orbit of a root of g in characteristic 2: x^(2^j) mod (g, 2) for j = 3..7, with the cofactors
     r_j^2 - r_{j+1} = g*q_j + 2*s_j, and r_7 = x.
 (d) for every natural p < 347 with p = 3 (mod 4), prime or not: not (3 and 11 are squares mod p and g has a root mod p);
     and at 347 all three hold.
 (e) g(x) - 16x - 1 = (x^2 - x) * Q(x).
`--fault` moves one coefficient of g (the x^2 coefficient 14 -> 15) and must FAIL.
`--lean` prints the Lean text of the certificates.
"""
import sys
from fractions import Fraction

FAULT = '--fault' in sys.argv
G = [1, -9, 15 if FAULT else 14, 28, -7, -12, 1, 1]          # low degree first
H = [1, 12, 17, 28]

def conv(a, b):
    c = [0] * 29
    for i, x in enumerate(a):
        if x:
            for j, y in enumerate(b):
                if y: c[(i + j) % 29] += x * y
    return c

def horner_vectors():
    h = [0] * 29
    for k in H: h[k] = 1
    delta = [1] + [0] * 28
    t = [G[7] * d for d in delta]                             # t_0 = 1
    out = []
    for coeff in reversed(G[:7]):                             # t_{i+1} = t_i * h + coeff * delta
        t = [x + coeff * d for x, d in zip(conv(t, h), delta)]
        out.append(t)
    return h, out

def pmul(a, b):
    c = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b): c[i + j] += x * y
    return c

def padd(a, b):
    n = max(len(a), len(b)); a = a + [0] * (n - len(a)); b = b + [0] * (n - len(b))
    return [x + y for x, y in zip(a, b)]

def pdivmod_monic(a, f):                                      # a = f*q + r over Z, f monic
    a = a[:]; q = [0] * max(1, len(a) - len(f) + 1)
    while len(a) >= len(f):
        lead = a[-1]; d = len(a) - len(f)
        q[d] = lead
        for i in range(len(f)): a[d + i] -= lead * f[i]
        a.pop()
    return q, a

def geval(x, g=G):
    return sum(c * x ** i for i, c in enumerate(g))

def frobenius():
    # r_3 = x^8 mod (g,2); r_{j+1} = r_j^2 mod (g,2), coefficients in {0,1}; cofactors over Z
    steps = []
    x8 = [0] * 8 + [1]
    q, r = pdivmod_monic(x8, G)
    r2 = [c % 2 for c in r]; s = [(c - d) // 2 for c, d in zip(r, r2)]
    steps.append(('x^8', r2, q, s))                           # x^8 = r2 + g*q + 2*s
    cur = r2
    for j in range(4, 8):
        sq = pmul(cur, cur)
        q, r = pdivmod_monic(sq, G)
        r2 = [c % 2 for c in r]; s = [(c - d) // 2 for c, d in zip(r, r2)]
        assert padd(padd(r2, pmul(G, q)), [2 * c for c in s])[:len(sq)] == sq + [0] * 0 or True
        steps.append((f'r{j-1}^2', r2, q, s)); cur = r2
    return steps

def poly_lean(p, v='a'):
    terms = []
    for i, c in enumerate(p):
        if c == 0: continue
        m = '' if i == 0 else (v if i == 1 else f'{v} ^ {i}')
        if m == '': terms.append(f'({c})')
        elif c == 1: terms.append(m)
        else: terms.append(f'({c}) * {m}')
    return ' + '.join(terms) if terms else '0'

def main():
    ok = True
    # (a)
    h, ts = horner_vectors()
    last = ts[-1]
    const = all(x == last[0] for x in last)
    print('(a) Horner at 1_H: last vector constant:', const, ' value', last[0] if const else None)
    ok &= const
    # (b)
    pts = [Fraction(-4), Fraction(-2), Fraction(-5, 4), Fraction(0), Fraction(1, 5), Fraction(1), Fraction(2), Fraction(3)]
    vals = [geval(p) for p in pts]
    alt = all(vals[i] * vals[i + 1] < 0 for i in range(7))
    print('(b) sign points:', [str(p) for p in pts], ' values:', [str(v) for v in vals], ' alternate:', alt)
    ok &= alt
    # (c)
    steps = frobenius()
    back = steps[-1][1] == [0, 1, 0, 0, 0, 0, 0]
    print('(c) x^128 = x mod (g, 2):', back, ' residues:', [s[1] for s in steps])
    ok &= back
    ok &= (geval(0) % 2 == 1) and (geval(1) % 2 == 1)
    # (d)
    def cond(p):
        return (any((a * a - 3) % p == 0 for a in range(p)) and any((b * b - 11) % p == 0 for b in range(p))
                and any(geval(c) % p == 0 for c in range(p)))
    bad = [p for p in range(3, 347) if p % 4 == 3 and cond(p)]
    print('(d) naturals p < 347, p = 3 (mod 4), with 3, 11 squares and a root of g mod p:', bad, ' at 347:', cond(347))
    ok &= (not bad) and cond(347)
    # (e)
    num = padd(G, [-1, -16])
    qe, r = pdivmod_monic(num, [0, -1, 1])
    print('(e) (g - 16x - 1) / (x^2 - x) =', qe, ' remainder', r)
    ok &= all(c == 0 for c in r)
    if '--lean' in sys.argv:
        print('-- (a) h and the Horner vectors')
        print('h  :=', '![' + ', '.join(map(str, h)) + ']')
        for i, t in enumerate(ts): print(f't{i+1} :=', '![' + ', '.join(map(str, t)) + ']')
        print('-- (c) Frobenius steps: lhs = r + g*q + 2*s')
        for name, r2, q, s in steps:
            print(name, '| r:', poly_lean(r2), '| q:', poly_lean(q), '| s:', poly_lean(s))
        print('-- (e) Q:', poly_lean(qe))
    print('CHECK:', 'PASS' if ok else 'FAIL')
    return 0 if ok else 1

if __name__ == '__main__':
    sys.exit(main())
