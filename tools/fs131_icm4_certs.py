#!/usr/bin/env python3
"""FS131-ICM4: the certificates of `Proofs/HadwigerNelson/Arith/DyadicCerts.lean`, in exact integer arithmetic.

The register is the module's `BinaryField.step n P`: a code `x < 2^n` of an element of F_2[x]/(P) (bit i the
coefficient of x^i), multiplied by x: `x << 1`, xor `P` when bit n-1 of `x` was set. `P` is primitive when the
register's orbit of 1 returns to 1 first after N = 2^n - 1 steps (the module's `primCheck`). `s(t)` is bit 0 of the
t-th state: the coordinate-0 functional L0 at g^t, g the class of x.

* Four-colourings, n = 2f, Q = 2^f, f = 2..5: exponents (e1, e2) such that every u = g^((Q-1)j), j <= Q, of
  mu_{Q+1} has L0(g^e1 u) = 1 or L0(g^e2 u) = 1, i.e. s(e1 + (Q-1)j) = 1 or s(e2 + (Q-1)j) = 1. The colouring
  x -> (L0(g^e1 x), L0(g^e2 x)) is then proper on Cay(F_{Q^2}, mu_{Q+1}). The kernel of the pair is the codimension-2
  F_2-subspace {x : L0(a x) = 0 for a in V}, V = span(g^e1, g^e2): X26B-T1's encoding (`tools/x26b_uq_colour.py`,
  Tr(g^ia u), Tr(g^ib u)) with L0 for the trace, L0 = Tr(c .) for one c != 0, so V -> cV is a bijection between the
  two counts. CONTROL: the number of 2-dimensional V avoiding mu (unordered pairs / 3) must be X26B-T1's 10, 36, 68 at
  Q = 4, 8, 16, and the number of F_4-lines V = a F_4 (pairs (e, e + N/3), / 3) must be 11 at Q = 32 (G54).
  The certificate is the least good pair with e1 < Q - 1 (scaling by mu keeps a pair good).
* The spectrum at Q = 64 (n = 12): c_r = #{j <= 64 : s(r + 63 j) = 1}, r < 63; every character sum over mu_65 is
  65 - 2 c_r for some r, so the least is 65 - 2 max c_r. CONTROL: max c_r = 40 (lambda_min(U_64) = -15, X26B-T1).

--lean prints the module's certificate block; --check compares it with the block in the module (exit 1 on any
difference); --fault flips one bit of P12 before comparing (the planted fault: --check must then fail).

--plant: each check run again on a corrupted certificate, each of which must FAIL: for each colouring (e1, e1) — one
functional twice, a two-colouring by one hyperplane, which no U_Q with Q >= 4 has (chi(U_Q) = 4, G56) — and the
bound 39 for the spectrum. Exit 1 on any failure.
"""
import sys

PRIMS = {4: 0b10011, 6: 0b1000011, 8: 0b100011101, 10: 0b10000001001, 12: 0b1000001010011}
# x^4+x+1, x^6+x+1, x^8+x^4+x^3+x^2+1, x^10+x^3+1, x^12+x^6+x^4+x+1


def step(n, P, x):
    return ((x << 1) ^ P) if (x >> (n - 1)) & 1 else (x << 1)


def orbit(n, P):
    N = 2 ** n - 1
    states, x = [], 1
    for _ in range(2 * N + 1):
        states.append(x)
        x = step(n, P, x)
    return states


def prim_check(n, P):
    """The module's primCheck: 0 < n, P >> n == 1, step^[j] 1 != 1 for 0 < j < N, step^[N] 1 == 1."""
    N = 2 ** n - 1
    if not (0 < n and P >> n == 1):
        return False
    x = step(n, P, 1)
    for _ in range(N - 1):
        if x == 1:
            return False
        x = step(n, P, x)
    return x == 1


def colour_ok(s, Q, e1, e2):
    return all(s[e1 + (Q - 1) * j] & 1 or s[e2 + (Q - 1) * j] & 1 for j in range(Q + 1))


def colourings(plant):
    bad = 0
    out = {}
    expect = {2: 10, 3: 36, 4: 68}
    for f in range(2, 6):
        n, Q = 2 * f, 2 ** f
        N, P = 2 ** n - 1, PRIMS[2 * f]
        assert prim_check(n, P), f"P at n={n} is not primitive"
        s = orbit(n, P)
        # the certificate: least good (e1, e2) with e1 < Q - 1
        cert = next(((e1, e2) for e1 in range(Q - 1) for e2 in range(N) if e2 != e1 and colour_ok(s, Q, e1, e2)), None)
        # the control count
        if f <= 4:
            good = sum(1 for a in range(N) for b in range(a + 1, N) if colour_ok(s, Q, a, b))
            assert good % 3 == 0
            cnt, want, what = good // 3, expect[f], "2-dim V avoiding mu (unordered pairs / 3)"
        else:
            good = sum(1 for a in range(N) if colour_ok(s, Q, a, (a + N // 3) % N))
            assert good % 3 == 0
            cnt, want, what = good // 3, 11, "F_4-lines V avoiding mu (pairs (e, e+N/3) / 3)"
        ok_count = cnt == want
        if cert is None:
            print(f"f={f} Q={Q} n={n} P={P}: NO CERTIFICATE")
            bad += 1
            continue
        e1, e2 = cert
        ok = colour_ok(s, Q, e1, e2)
        line = f"f={f} Q={Q} n={n} P={P}: e1={e1} e2={e2} check={'PASS' if ok else 'FAIL'}; {what}: {cnt} (X26B-T1: {want}) {'MATCH' if ok_count else 'DIFFER'}"
        if plant:
            pok = colour_ok(s, Q, e1, e1)
            line += f"; PLANT (e1, e1): {'FAILS (good)' if not pok else 'PASSES (bad)'}"
            bad += pok
        print(line)
        bad += (not ok) + (not ok_count)
        out[f] = (P, e1, e2)
    return bad, out


def spectrum(plant):
    n, Q = 12, 64
    N, P = 2 ** n - 1, PRIMS[12]
    assert prim_check(n, P)
    s = orbit(n, P)
    c = [sum(s[r + 63 * j] & 1 for j in range(Q + 1)) for r in range(Q - 1)]
    mx, mn = max(c), min(c)
    sums = sorted(set(Q + 1 - 2 * x for x in c))
    ok = mx == 40
    print(f"n=12 Q=64 P={P}: max c_r = {mx} at r={c.index(mx)}, min c_r = {mn}; least sum 65 - 2*{mx} = {Q + 1 - 2 * mx}; "
          f"the sums: {sums}; CONTROL lambda_min = -15: {'MATCH' if ok else 'DIFFER'}")
    bad = not ok
    if plant:
        pok = all(x <= 39 for x in c)
        print(f"  PLANT bound 39: {'FAILS (good)' if not pok else 'PASSES (bad)'}")
        bad += pok
    return bad, (P, mx)


MOD = __import__("pathlib").Path(__file__).resolve().parent.parent / "Proofs/HadwigerNelson/Arith/DyadicCerts.lean"
BEGIN, END = "-- BEGIN CERTIFICATE (generated: tools/fs131_icm4_certs.py)", "-- END CERTIFICATE"
NAMES = {4: "`x⁴ + x + 1`", 6: "`x⁶ + x + 1`", 8: "`x⁸ + x⁴ + x³ + x² + 1`", 10: "`x¹⁰ + x³ + 1`",
         12: "`x¹² + x⁶ + x⁴ + x + 1`"}


def block(cols, spec, fault=False):
    """The module's certificate block, from the values computed here."""
    lines = [BEGIN]
    for n in (4, 6, 8, 10, 12):
        P = PRIMS[n] ^ (2 if fault and n == 12 else 0)
        lines += [f"/-- {NAMES[n]}, primitive over `𝔽₂`. -/", f"def P{n} : ℕ := {P}"]
    for f, (P, e1, e2) in cols.items():
        Q = 2 ** f
        extra = f" (an `𝔽₄`-hyperplane: `{e2} = {e1} + {(4 ** f - 1)}/3`)" if f == 5 else ""
        lines += [f"/-- The two exponents of the four-colouring at `Q = {Q}`{extra}. -/", f"def E{Q} : ℕ × ℕ := ({e1}, {e2})"]
    lines += ["/-- The largest class count of the bit-0 sequence at `Q = 64`. -/", f"def B64 : ℕ := {spec[1]}", END]
    return "\n".join(lines)


def main():
    plant = "--plant" in sys.argv
    b1, cols = colourings(plant)
    b2, spec = spectrum(plant)
    print("LEAN:")
    for f, (P, e1, e2) in cols.items():
        print(f"  f={f}: primCheck {2 * f} {P}; colourCheck {2 ** f} {e1} {e2}")
    print(f"  n=12: primCheck 12 {spec[0]}; countsOk bound {spec[1]}")
    bad = b1 + b2
    if "--lean" in sys.argv:
        print(block(cols, spec))
    if "--check" in sys.argv or "--fault" in sys.argv:
        text = MOD.read_text()
        have = text[text.index(BEGIN):text.index(END) + len(END)]
        same = have == block(cols, spec, fault="--fault" in sys.argv)
        print(f"MODULE BLOCK: {'IDENTICAL' if same else 'DIFFERS'} ({MOD.name})")
        bad += not same
    print("ALL PASS" if not bad else f"FAILED ({bad})")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
