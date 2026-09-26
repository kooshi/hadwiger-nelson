#!/usr/bin/env python3
"""X26B exact checks (seconds): spectra of the level-one residue targets and of level two of ramified towers.

Gamma_q = Cay(F_{q^2}, mu_{q+1}) (q = p^f, q = 3 mod 4) and U_Q = Cay(F_{Q^2}, mu_{Q+1}) (Q = 2^f).
Eigenvalue at a: lam(a) = sum_{u in mu} psi(Tr_{F_{p^n}/F_p}(a u)), psi(t) = exp(2 pi i t / p).
Counts n_t = #{u : Tr(a u) = t} are exact integers; lam = sum_t n_t cos(2 pi t / p) is evaluated with mpmath at 50 digits.
Reported: d, lam_min, lam_min/d, Hoffman ratio h = -lam~/(1 - lam~), and h < 1/4.

Level-two control (the derivation's new-character bound): for F_v ramified (e = 2) over Q_p with residue field F_p, the ring
O_w / p_w^2 = F_{p^2}[eps]/(eps^2), conjugation = Frobenius on F_{p^2}, fixing eps; unit vectors at level 2:
{a + b eps : N(a) = 1, Tr(a b^c) = 0}. Every character of exact level 2 must have |lam| <= c0 * p * ... i.e.
|lam|/d <= 2/(p+1) (p odd) or 1/(p+1) (p = 2).

PLANT=1 replaces mu_{q+1} by mu_{q-1}-cosets' wrong exponent (uses the (q-1)-th roots of unity), which must break the controls.
"""
import os, sys, itertools
from mpmath import mp, mpf, cos, pi
mp.dps = 50
PLANT = os.environ.get("PLANT") == "1"

def polymulmod(a, b, f, p):
    n = len(f) - 1
    r = [0] * (2 * n - 1)
    for i, x in enumerate(a):
        if x:
            for j, y in enumerate(b):
                r[i + j] = (r[i + j] + x * y) % p
    for k in range(len(r) - 1, n - 1, -1):
        c = r[k]
        if c:
            for j in range(n + 1):
                r[k - n + j] = (r[k - n + j] - c * f[j]) % p
    return r[:n]

def field(p, n):
    """GF(p^n): find monic f of degree n with x primitive; return exp table (list of coefficient tuples), log dict."""
    N = p ** n
    for coeffs in itertools.product(range(p), repeat=n):
        f = list(coeffs) + [1]
        if f[0] == 0:
            continue
        x = [0] * n
        if n == 1:
            continue
        x[1] = 1
        e = [1] + [0] * (n - 1)
        seen = []
        ok = True
        for k in range(N - 1):
            seen.append(tuple(e))
            e = polymulmod(e, x, f, p)
            if tuple(e) == tuple([1] + [0] * (n - 1)) and k < N - 2:
                ok = False
                break
        if ok and len(set(seen)) == N - 1:
            return f, seen
    raise RuntimeError("no primitive polynomial")

def add(a, b, p):
    return tuple((x + y) % p for x, y in zip(a, b))

def trace_table(p, n, exp):
    N1 = p ** n - 1
    T = []
    for k in range(N1):
        s = tuple([0] * n)
        for i in range(n):
            s = add(s, exp[(k * p ** i) % N1], p)
        assert all(c == 0 for c in s[1:]), "trace not in prime field"
        T.append(s[0])
    return T

def spectrum(p, f):
    """Eigenvalues of Cay(F_{q^2}, mu_{q+1}), q = p^f, as exact count vectors per coset class of a."""
    q = p ** f
    n = 2 * f
    _, exp = field(p, n)
    T = trace_table(p, n, exp)
    N1 = q * q - 1
    step = (q + 1) if PLANT else (q - 1)          # mu_{q+1} = <g^{q-1}>; the plant takes <g^{q+1}> = mu_{q-1}
    mu = [(m * step) % N1 for m in range(N1 // step)]
    lams = {}
    for j in range(N1):
        cnt = [0] * p
        for m in mu:
            cnt[T[(j + m) % N1]] += 1
        key = tuple(cnt)
        lams[key] = lams.get(key, 0) + 1
    vals = []
    for cnt, mult in lams.items():
        lam = sum(mpf(c) * cos(2 * pi * t / p) for t, c in enumerate(cnt))
        vals.append((lam, mult, cnt))
    d = len(mu)
    return q, d, sorted(vals)

def level_two_ramified(p):
    """Exact eigenvalues of level 2 of a ramified (e = 2) tower with residue field F_p; returns (d, max |lam| over exact-level-2 chars, lam_min over all)."""
    f2, exp = field(p, 2)
    elems = [tuple([0, 0])] + exp
    log = {e: k for k, e in enumerate(exp)}
    N1 = p * p - 1
    def mul(a, b):
        if a == (0, 0) or b == (0, 0):
            return (0, 0)
        return exp[(log[a] + log[b]) % N1]
    def conj(a):
        return a if a == (0, 0) else exp[(log[a] * p) % N1]
    def tr(a):
        s = add(a, conj(a), p)
        assert s[1] == 0
        return s[0]
    def nm(a):
        s = mul(a, conj(a))
        assert s[1] == 0
        return s[0]
    S = [(a, b) for a in elems for b in elems if nm(a) == 1 and tr(mul(a, conj(b))) == 0]
    d = len(S)
    T = [0] * (N1 + 1)
    def trp(a):          # Tr_{F_{p^2}/F_p}
        return tr(a)
    # characters of F_{p^2}[eps]/eps^2: chi_{s,t}(a + b eps) = psi(Tr(s a) + Tr(t b)); exact level 2 iff t != 0
    newmax = mpf(0); lmin = mpf(10**9)
    for s in elems:
        for t in elems:
            cnt = [0] * p
            for a, b in S:
                cnt[(trp(mul(s, a)) + trp(mul(t, b))) % p] += 1
            lam = sum(mpf(c) * cos(2 * pi * k / p) for k, c in enumerate(cnt))
            if s == (0, 0) and t == (0, 0):
                assert lam == d
                continue
            lmin = min(lmin, lam)
            if t != (0, 0):
                newmax = max(newmax, abs(lam))
    return d, newmax, lmin

def main():
    out = []
    rows = []
    for (p, f) in [(3, 1), (7, 1), (11, 1), (19, 1), (23, 1), (3, 3), (31, 1), (43, 1), (47, 1),
                   (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7)]:
        q, d, vals = spectrum(p, f)
        lmin = vals[0][0]
        lt = lmin / d
        h = -lt / (1 - lt)
        weil = 2 * mp.sqrt(q)
        tot = sum(v * m for v, m, _ in vals) + d          # trace of adjacency over all q^2 characters must be 0
        rows.append((q, d, lmin, lt, h, h < mpf(1) / 4, max(abs(v) for v, _, _ in vals) <= weil + mpf(10) ** -30, tot))
        out.append(f"q={q:4d} d={d:4d} lam_min={mp.nstr(lmin, 12):>16} lam_min/d={mp.nstr(lt, 10):>14} "
                   f"Hoffman={mp.nstr(h, 12):>16} h<1/4={h < mpf(1)/4} |lam|<=2sqrt(q):{rows[-1][6]} trace={mp.nstr(tot, 5)}")
    print("\n".join(out))
    # controls (known values from the corpus)
    by = {r[0]: r for r in rows}
    ctl = []
    ctl.append(("U_2 = K4: lam_min = -1", abs(by[2][2] + 1) < mpf(10) ** -30))
    ctl.append(("U_32: lam_min = -11 (G54, tight at 4)", abs(by[32][2] + 11) < mpf(10) ** -30))
    ctl.append(("U_64: lam_min = -15 (G56)", abs(by[64][2] + 15) < mpf(10) ** -30))
    ctl.append(("Gamma_31: lam_min + 32/3 = 1.5617e-4 (G54)", abs(by[31][2] + mpf(32) / 3 - mpf("1.5617e-4")) < mpf("1e-7")))
    ctl.append(("Gamma_7: lam_min/d = -0.5617 (R88)", abs(by[7][3] + mpf("0.5617")) < mpf("5e-5")))
    ctl.append(("Gamma_3 tight at 3: lam_min = -2 = -d/2", abs(by[3][2] + 2) < mpf(10) ** -30))
    ctl.append(("every trace = 0", all(abs(r[7]) < mpf(10) ** -30 for r in rows)))
    bad = [n for n, ok in ctl if not ok]
    for n, ok in ctl:
        print(("CONTROL OK   " if ok else "CONTROL FAIL ") + n)
    # level two of ramified towers (the new-character bound)
    for p in [3, 7, 2]:
        d, newmax, lmin2 = level_two_ramified(p)
        bound = (mpf(2) if p > 2 else mpf(1)) / (p + 1)
        ok = newmax / d <= bound + mpf(10) ** -30
        print(f"level 2, ramified e=2, residue F_{p}: d={d} max|lam_new|/d={mp.nstr(newmax / d, 12)} bound={mp.nstr(bound, 6)} "
              f"ok={ok} lam_min/d(all)={mp.nstr(lmin2 / d, 12)}")
        if not ok:
            bad.append(f"level-2 bound at p={p}")
        if d != (p + 1) * p:
            bad.append(f"level-2 degree at p={p}: {d}")
    if bad:
        print("FAILED:", bad)
        sys.exit(1)
    print("ALL CONTROLS PASS")

if __name__ == "__main__":
    main()
