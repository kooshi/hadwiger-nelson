#!/usr/bin/env python3
"""FS131-K10b: the spectrum of U_128 = Cay(F_{2^14}, mu_129), exactly, and the certificate the Lean module reads.

F_2[x] is coded in Python ints (bit i = coefficient of x^i). Everything is exact integer arithmetic.

  (1) P: the least primitive polynomial of degree 14 (irreducible by Rabin's test: P | x^(2^14) + x, gcd(P, x^(2^7) + x) = 1,
      gcd(P, x^(2^2) + x) = 1; primitive: x has order 16383 = 3 * 43 * 127 mod P).
  (2) the certificate: QBIG with clmul(P, QBIG) = x^16384 + x; Bezout pairs (A4, B4), (A128, B128) with
      A*P + B*(x^(2^d) + x) = 1 for d = 2, 7.
  (3) route A (the Lean route): t(n) = coefficient of x^0 in x^n mod P, n < 16383; c_i = #{n = i mod 127 : t(n) = 1};
      lambda_i = 129 - 2 c_i.  The packed accumulator ACC = sum_n t(n) << (8 * (n mod 127)).
  (4) route B (independent): lambda_a = sum over u in mu_129 of (-1)^Tr(a u), Tr the absolute trace, a over the 127 classes
      g^i, by field multiplication.  The two multisets must agree.
  (5) the floor: m = -min lambda; Hoffman: chi >= 1 + 129/m; seven needs 5 m < 129.

--fault : use the non-primitive irreducible found first (x of order < 16383). Expected: the order check fails, exit 1.
--json  : print the certificate as JSON (for the Lean generator).
"""
import json, sys
from collections import Counter

N, Q = 14, 128
ORD = (1 << N) - 1  # 16383


def deg(a):
    return a.bit_length() - 1


def clmul(a, b):
    r = 0
    while a:
        if a & 1:
            r ^= b
        a >>= 1
        b <<= 1
    return r


def pdivmod(a, b):
    q = 0
    db = deg(b)
    while a and deg(a) >= db:
        s = deg(a) - db
        q ^= 1 << s
        a ^= b << s
    return q, a


def pmod(a, b):
    return pdivmod(a, b)[1]


def xgcd(a, b):
    # returns (g, s, t) with s*a + t*b = g
    r0, r1, s0, s1, t0, t1 = a, b, 1, 0, 0, 1
    while r1:
        q, r = pdivmod(r0, r1)
        r0, r1 = r1, r
        s0, s1 = s1, s0 ^ clmul(q, s1)
        t0, t1 = t1, t0 ^ clmul(q, t1)
    return r0, s0, t0


def mulmod(a, b, P):
    return pmod(clmul(a, b), P)


def powmod(a, e, P):
    r = 1
    while e:
        if e & 1:
            r = mulmod(r, a, P)
        a = mulmod(a, a, P)
        e >>= 1
    return r


def irreducible(P):
    x = 2
    y = x
    for _ in range(N):
        y = mulmod(y, y, P)
    if y != x:
        return False
    for d in (2, 7):
        if xgcd(P, (1 << (1 << d)) ^ 2)[0] != 1:
            return False
    return True


def order_ok(P):
    return all(powmod(2, ORD // r, P) != 1 for r in (3, 43, 127))


def main():
    fault = "--fault" in sys.argv
    P = None
    for cand in range((1 << N) + 1, 1 << (N + 1), 2):
        if irreducible(cand):
            if fault and not order_ok(cand):
                P = cand
                break
            if not fault and order_ok(cand):
                P = cand
                break
    assert P is not None
    print(f"P = {P} = {bin(P)}  (taps {[i for i in range(N + 1) if P >> i & 1]})")
    if not order_ok(P):
        print("x is NOT of order 16383 modulo P: the route's generator hypothesis fails")
        sys.exit(1)
    # (2) certificate
    target = (1 << (1 << N)) ^ 2
    QBIG, rem = pdivmod(target, P)
    assert rem == 0 and clmul(P, QBIG) == target
    cert = {"P": P, "QBIG": QBIG}
    for d in (2, 7):
        h = (1 << (1 << d)) ^ 2
        g, s, t = xgcd(P, h)
        assert g == 1 and clmul(s, P) ^ clmul(t, h) == 1
        cert[f"A{1 << d}"], cert[f"B{1 << d}"] = s, t
    # (3) route A
    step = lambda x: ((x << 1) ^ P) if (x >> (N - 1)) & 1 else (x << 1)
    x, c, acc = 1, [0] * 127, 0
    for n in range(ORD):
        if x & 1:
            c[n % 127] += 1
            acc += 1 << (8 * (n % 127))
        x = step(x)
    assert x == 1, "x^16383 != 1"
    lamA = [129 - 2 * ci for ci in c]
    # (4) route B
    def tr(y):
        t, z = 0, y
        for _ in range(N):
            t ^= z
            z = mulmod(z, z, P)
        assert t in (0, 1)
        return t
    w = powmod(2, 127, P)
    mu, u = [], 1
    for _ in range(129):
        mu.append(u)
        u = mulmod(u, w, P)
    assert u == 1 and len(set(mu)) == 129
    lamB, a = [], 1
    for _ in range(127):
        lamB.append(sum(1 - 2 * tr(mulmod(a, v, P)) for v in mu))
        a = mulmod(a, 2, P)
    assert Counter(lamA) == Counter(lamB), "the two routes disagree"
    m = -min(lamA)
    cert.update({"ACC": acc, "cmax": max(c), "m": m})
    print("spectrum (value: multiplicity among the 127 classes):", dict(sorted(Counter(lamA).items())))
    print(f"lambda_min = {-m}, lambda_max(non-trivial) = {max(lamA)}; sum of squares = {sum(l * l for l in lamA)} (expect 2^14 - 129 = 16255)")
    print(f"Hoffman: chi >= 1 + 129/{m} = {1 + 129 / m:.4f}; 5m = {5 * m} < 129: {5 * m < 129}; 6m = {6 * m} < 129: {6 * m < 129}")
    print(f"max count c_i = {max(c)} (the Lean check: every c_i <= {(129 + m) // 2})")
    print(f"QBIG bits = {QBIG.bit_length()}, A4 bits = {cert['A4'].bit_length()}, A128 bits = {cert['A128'].bit_length()}, ACC bits = {acc.bit_length()}")
    if "--json" in sys.argv:
        print("JSON " + json.dumps({k: hex(v) for k, v in cert.items()}))
    sys.exit(0 if 5 * m < 129 else 1)


if __name__ == "__main__":
    main()
