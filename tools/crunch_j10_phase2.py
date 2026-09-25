#!/usr/bin/env python3
"""Crunch J10 (FS-91 S1V), phase 2: exact checks of J07's lemma statements (`data/fs91/j07/lemma-statements.md`) as re-derived
blind in `plans/FS91-S1V-character.md` Stage 3.  Seconds; no search.  Never runs J07's tools.

(D) Lemma C' (the unit-vector ring is the full stable local order): for fields where every place above p is stable, the image of
    R_F = Z[U_F] in O_L/pO_L (the F_p-span of sampled unit vectors u_a = (1+ia)/(1-ia), closed under products) has full rank
    [L:Q] exactly when C' predicts it (odd p; inert stable dyadic places) and a smaller rank at ramified stable dyadic places
    (FS86-CL2's Q(sqrt5), Q(sqrt17); Q(sqrt2) reported).  Full rank + Nakayama is the claim; a sample can only under-count, so a
    FULL rank is a proof and a deficient rank is only consistent with the ramified-dyadic failure (proved by hand there).
    PLANT D: at Q(sqrt3), p = 2, sample only a in 2*O_F (so every u_a is 1 mod 2): the level-zero span of mu_{q+1} is lost and the
    rank must drop below 4 while the faithful partner reaches 4.
(E) Local towers O_E/P^L with E/K unramified quadratic, K in {Q_3 (e=1), Q_7 (e=1), Q_3(sqrt3) (e=2), Q_2(sqrt3) (dyadic, e=2)}:
    every character of every exact level; the best band margin beta*(L') per exact level L'.  Checks LB (2 beta p^a <= 1),
    LB' (2 beta p^E <= p^(E-a) - 1), CLG-e (odd: no band-k above level one for k <= 2p; dyadic: no band-3 at any level, no band
    character at level one), the band-7 question at (e=1, L'=3) and (e=2, L'=5), and J10-L8 (the all-levels ratio: a character
    new at level L has |eigenvalue| <= c Q^(L-1), c = 2 odd / 1 dyadic, so lambda_min(L) = Q^(L-1) lambda_min(1)).  Eigenvalues are
    float sums of exact value counts (margin 1e-6).
    PLANT E: at Q_3, L = 2, keep one point per fibre of S_2 -> S_1; LB must then be violated (a band 6-character above level one).
    PLANT L8: the new-character bound with c = 1 at Q_3(sqrt3) must be violated if FS86-LP's attained bound is attained there.
(F) Level one: the value multiplicity #{z in mu_{q+1} : Tr(az) = t} = 1 - eta(t^2 - 4N(a)) (brute-forced at q = 7, 11, 19, 23), then
    no band-4 character of Gamma_q for prime q = 3 (mod 4), 11 <= q <= 59, and no band-5 at q in {23, 43, 59}; control: band 4 at 7.
    U_Q = Cay(F_{Q^2}, mu_{Q+1}) exact spectra (integers) at Q = 64, 128, 256: lambda_min and the Hoffman floor 1 - (Q+1)/lambda_min.
    PLANT F: flip eta's sign; the multiplicity formula must disagree with the brute force.
(G) The LB' arithmetic table at p = 3, k = 7: which (e, exact level) LB' leaves open.

Exit status 0 only if every unplanted check passes AND every plant fires.
"""
import subprocess
import sys
from fractions import Fraction
from math import ceil

import numpy as np

FAIL = []


def check(ok, msg):
    print(("  ok   " if ok else "  FAIL ") + msg)
    if not ok:
        FAIL.append(msg)


# ---------------------------------------------------------------- (D) Lemma C' by PARI
GP = r'''
default(parisize, "400M"); setrand(7);
cp(Fpols, p, N, B, dens, even) = {
  my(P = x^2+1, nf, ii, G, mons, rows = List(), bad = 0, M, rk0, rk, auts, c, pr, st = 0, ns = 0, a, u, v, e, cnt, nb, bas, prods);
  for(j = 1, #Fpols, P = polcompositum(P, Fpols[j])[1]);
  P = polredbest(subst(P, x, y)); nf = nfinit(P);
  ii = Mod(lift(nfroots(nf, x^2+1)[1]), P);
  G = vector(#Fpols, j, Mod(lift(nfroots(nf, Fpols[j])[1]), P));
  mons = [Mod(1, P)];
  for(j = 1, #Fpols, my(nm = List()); for(k = 1, #mons, for(t = 0, poldegree(Fpols[j]) - 1, listput(nm, mons[k] * G[j]^t))); mons = Vec(nm));
  auts = nfgaloisconj(nf); c = 0;
  for(k = 1, #auts, my(s = Mod(auts[k], P)); if(subst(lift(ii), y, s) == -ii && prod(j = 1, #G, subst(lift(G[j]), y, s) == G[j]), c = auts[k]));
  if(c == 0, error("no conjugation found"));
  pr = idealprimedec(nf, p);
  for(k = 1, #pr, if(idealhnf(nf, nfgaloisapply(nf, c, pr[k])) == idealhnf(nf, pr[k]), st++, ns++));
  for(n = 1, N,
    a = sum(k = 1, #mons, (random(2*B+1) - B) * mons[k]) / dens[random(#dens) + 1];
    if(even, a = 2 * a);
    u = (1 + ii*a) / (1 - ii*a);
    v = nfalgtobasis(nf, lift(u));
    if(denominator(v) % p == 0, bad++, listput(rows, v~ * Mod(1, p))));
  M = matconcat(Vec(rows)~); rk0 = matrank(M);
  bas = matimage(M~);
  cnt = 1;
  while(cnt,
    nb = #bas; prods = List();
    for(i = 1, nb, for(j = i, nb,
      my(e1 = nfbasistoalg(nf, lift(bas[, i])), e2 = nfbasistoalg(nf, lift(bas[, j])));
      listput(prods, nfalgtobasis(nf, e1 * e2) * Mod(1, p))));
    bas = matimage(matconcat([bas, matconcat(Vec(prods))]));
    cnt = (#bas > nb));
  rk = #bas;
  print([poldegree(P), st, ns, vector(#pr, k, [pr[k].e, pr[k].f]), bad, rk0, rk]);
}
'''

CP_TESTS = [
    # (label, F polynomials, p, sample, coefficient bound, denominators, even-plant, expected rank or None, "full"/"deficient"/"report")
    ("Q(sqrt3), p=3 (ramified in F, e=2, one stable place)", "[x^2-3]", 3, 400, 6, "[1,2,5,7]", 0, "full"),
    ("Q(sqrt7), p=3 (split in F: two stable places)", "[x^2-7]", 3, 400, 6, "[1,2,5]", 0, "full"),
    ("Q(sqrt11), p=7 (split: two stable places)", "[x^2-11]", 7, 400, 6, "[1,2,3,5]", 0, "full"),
    ("Q(sqrt3), p=2 (one inert stable dyadic place)", "[x^2-3]", 2, 400, 6, "[1,3,5,7]", 0, "full"),
    ("Q(sqrt3,sqrt17), p=2 (two inert stable dyadic places)", "[x^2-3, x^2-17]", 2, 600, 5, "[1,3,5]", 0, "full"),
    ("Q(alpha), alpha^3=alpha+1, p=3 (complex embeddings; residue F_27)", "[x^3-x-1]", 3, 600, 5, "[1,2,5,7]", 0, "full"),
    ("Q(alpha), alpha^3=alpha+1, p=23 (complex embeddings; ramified)", "[x^3-x-1]", 23, 600, 5, "[1,2,3,5]", 0, "full"),
    ("Q(sqrt5), p=2 (ramified stable dyadic; FS86-CL2)", "[x^2-5]", 2, 400, 6, "[1,3,5,7]", 0, "deficient"),
    ("Q(sqrt17), p=2 (two ramified stable dyadic; FS86-CL2)", "[x^2-17]", 2, 400, 6, "[1,3,5,7]", 0, "deficient"),
    ("Q(sqrt2), p=2 (ramified stable dyadic, residue F_2)", "[x^2-2]", 2, 400, 6, "[1,3,5,7]", 0, "report"),
    ("Q(alpha), p=2 (ramified stable dyadic, residue F_8)", "[x^3-x-1]", 2, 600, 5, "[1,3,5,7]", 0, "report"),
    ("PLANT D: Q(sqrt3), p=2, a in 2*O_F only", "[x^2-3]", 2, 400, 6, "[1,3,5,7]", 1, "plant"),
]


def part_D():
    print("(D) Lemma C' by PARI: [deg L, #stable, #non-stable, [e,f] above p, p-denominators, rank(sample), rank(closed ring)]")
    script = GP + "\n".join(f"cp({f}, {p}, {n}, {b}, {d}, {ev});" for (_, f, p, n, b, d, ev, _) in CP_TESTS) + "\nquit\n"
    out = subprocess.run(["gp", "-q", "-f"], input=script, capture_output=True, text=True, timeout=600)
    lines = [l for l in out.stdout.splitlines() if l.startswith("[")]
    check(len(lines) == len(CP_TESTS), f"gp returned {len(lines)} result lines for {len(CP_TESTS)} tests" + (f"; stderr: {out.stderr[-400:]}" if out.stderr else ""))
    for (label, *_rest), line in zip(CP_TESTS, lines):
        kind = _rest[-1]
        vals = line.strip("[]").split(", ")
        deg, st, ns = int(vals[0]), int(vals[1]), int(vals[2])
        rk = int(vals[-1])
        bad = int(vals[-3])
        print(f"    {label}: {line}")
        if kind == "full":
            check(ns == 0 and bad == 0 and rk == deg, f"C' full rank {rk} = [L:Q] = {deg} ({label})")
        elif kind == "deficient":
            check(ns == 0 and bad == 0 and rk < deg, f"ramified-dyadic control: rank {rk} < {deg} ({label})")
        elif kind == "plant":
            check(rk < deg, f"PLANT D fires: rank {rk} < {deg} with every u_a = 1 mod 2 ({label})")
        else:
            print(f"    (report only) rank {rk} of {deg}")


# ---------------------------------------------------------------- (E) local towers
class Tower:
    """O_E/P^L for E/K unramified quadratic.  Elements: integer coordinate vectors w.r.t. a fixed Z_p-basis of O_E; P^L is
    diagonal in that basis (moduli(L)).  mul, conj, norm_is_one act on (n, dim) arrays."""

    def __init__(self, name, p, e, Q, dim, moduli, mul, conj, pi):
        self.name, self.p, self.e, self.Q, self.dim = name, p, e, Q, dim
        self.moduli, self.mul, self.conj, self.pi = moduli, mul, conj, pi

    def elements(self, L):
        m = self.moduli(L)
        grids = np.meshgrid(*[np.arange(k) for k in m], indexing="ij")
        return np.stack([g.ravel() for g in grids], axis=1).astype(np.int64)

    def reduce(self, z, L):
        return z % np.array(self.moduli(L))

    def circle(self, L):
        z = self.elements(L)
        n = self.reduce(self.mul(z, self.conj(z)), L)
        one = np.zeros(self.dim, dtype=np.int64)
        one[0] = 1
        return z[np.all(n == self.reduce(one[None, :], L), axis=1)]


def zi(p):
    def mul(a, b):
        return np.stack([a[:, 0] * b[:, 0] - a[:, 1] * b[:, 1], a[:, 0] * b[:, 1] + a[:, 1] * b[:, 0]], axis=1)
    return Tower(f"Z_{p}[i]", p, 1, p, 2, lambda L: (p ** L, p ** L), mul, lambda a: np.stack([a[:, 0], -a[:, 1]], axis=1), [p, 0])


def ok_mul(sq, cross):
    """O_K = Z_p[t], t^2 = sq + cross*t; coordinates (x, y) for x + y t."""
    def m(x, y, u, v):
        return x * u + sq * y * v, x * v + y * u + cross * y * v
    return m


def ram3():
    """K = Q_3(s), s^2 = 3 (e = 2); E = K(i); coords (x1, y1, x2, y2) for (x1 + y1 s) + i (x2 + y2 s)."""
    km = ok_mul(3, 0)

    def mul(a, b):
        ac = km(a[:, 0], a[:, 1], b[:, 0], b[:, 1]); bd = km(a[:, 2], a[:, 3], b[:, 2], b[:, 3])
        ad = km(a[:, 0], a[:, 1], b[:, 2], b[:, 3]); bc = km(a[:, 2], a[:, 3], b[:, 0], b[:, 1])
        return np.stack([ac[0] - bd[0], ac[1] - bd[1], ad[0] + bc[0], ad[1] + bc[1]], axis=1)
    mod = lambda L: (3 ** ceil(L / 2), 3 ** (L // 2), 3 ** ceil(L / 2), 3 ** (L // 2))
    conj = lambda a: np.stack([a[:, 0], a[:, 1], -a[:, 2], -a[:, 3]], axis=1)
    return Tower("Q_3(sqrt3)(i)", 3, 2, 3, 4, mod, mul, conj, [0, 1, 0, 0])


def dy3():
    """K = Q_2(pi), pi = 1 + sqrt3, pi^2 = 2 + 2 pi (e = 2, residue F_2); E = K(w), w^2 = -1 - w (unramified; E = K(i));
    coords (x1, y1, x2, y2) for A + B w, A = x1 + y1 pi, B = x2 + y2 pi; conj: w -> w^2 = -1 - w."""
    km = ok_mul(2, 2)

    def mul(a, b):
        ac = km(a[:, 0], a[:, 1], b[:, 0], b[:, 1]); bd = km(a[:, 2], a[:, 3], b[:, 2], b[:, 3])
        ad = km(a[:, 0], a[:, 1], b[:, 2], b[:, 3]); bc = km(a[:, 2], a[:, 3], b[:, 0], b[:, 1])
        return np.stack([ac[0] - bd[0], ac[1] - bd[1], ad[0] + bc[0] - bd[0], ad[1] + bc[1] - bd[1]], axis=1)
    mod = lambda L: (2 ** ceil(L / 2), 2 ** (L // 2), 2 ** ceil(L / 2), 2 ** (L // 2))
    conj = lambda a: np.stack([a[:, 0] - a[:, 2], a[:, 1] - a[:, 3], -a[:, 2], -a[:, 3]], axis=1)
    return Tower("Q_2(sqrt3)(w)", 2, 2, 2, 4, mod, mul, conj, [0, 1, 0, 0])


def tower_scan(T, L, S=None, chunk=4096):
    """Every character of O_E/P^L: exact level, band margin min_s ||lambda(s)|| (as Fraction), eigenvalue sum_s cos."""
    m = np.array(T.moduli(L)); M = int(m.max())
    S = T.circle(L) if S is None else S
    scale = M // m
    Sv = (S * scale[None, :]) % M                                  # value numerators: lambda(s) = sum c_j * Sv_j / M
    basis = np.eye(T.dim, dtype=np.int64)
    pis = []                                                          # images of pi^j * basis, j = 0..L (generators of P^j)
    cur = basis.copy()
    pie = np.array([T.pi] * T.dim, dtype=np.int64)
    for j in range(L + 1):
        pis.append((T.reduce(cur, L) * scale[None, :]) % M)
        cur = T.reduce(T.mul(cur, pie), L)
    chars = T.elements(L)
    res_level, res_margin, res_eig = [], [], []
    for i0 in range(0, len(chars), chunk):
        C = chars[i0:i0 + chunk]
        V = (C @ Sv.T) % M
        d = np.minimum(V, M - V).min(axis=1)
        eig = np.cos(2 * np.pi * V / M).sum(axis=1)
        lev = np.full(len(C), L, dtype=np.int64)
        for j in range(L, -1, -1):
            kills = np.all((C @ pis[j].T) % M == 0, axis=1)
            lev = np.where(kills, j, lev)
        res_level.append(lev); res_margin.append(d); res_eig.append(eig)
    return M, len(S), np.concatenate(res_level), np.concatenate(res_margin), np.concatenate(res_eig)


def part_E():
    print("(E) local towers: per exact level L': best band margin beta*, LB / LB' / CLG-e, band-7, J10-L8")
    runs = [(zi(3), 4), (zi(7), 3), (ram3(), 5), (dy3(), 6)]
    lam1 = {}
    for T, Lmax in runs:
        p, e, Q = T.p, T.e, T.Q
        for L in range(1, Lmax + 1):
            M, nS, lev, dmin, eig = tower_scan(T, L)
            check(nS == (Q + 1) * Q ** (L - 1), f"{T.name} L={L}: |S_L| = {nS} = (Q+1)Q^(L-1)")
            if L == 1:
                lam1[T.name] = eig.min()
            lmin = eig.min()
            check(abs(lmin - Q ** (L - 1) * lam1[T.name]) < 1e-6,
                  f"{T.name} L={L}: lambda_min = {lmin:.6f} = Q^(L-1) * lambda_min(1) = {Q ** (L - 1) * lam1[T.name]:.6f} (J10-L8)")
            if L >= 2:
                new = lev == L
                cbound = (2 if p % 2 else 1) * Q ** (L - 1)
                check(np.abs(eig[new]).max() <= cbound + 1e-6,
                      f"{T.name} L={L}: new characters |eig| <= {cbound} (max {np.abs(eig[new]).max():.4f}) (J10-L8)")
            if L != Lmax:
                continue
            for Lp in range(1, Lmax + 1):
                sel = lev == Lp
                if not sel.any():
                    continue
                beta = Fraction(int(dmin[sel].max()), M)
                kmin = None if beta == 0 else ceil(1 / beta)
                line = f"{T.name}: exact level {Lp}: beta* = {beta} (least band k = {kmin})"
                if Lp >= 2 and p % 2:
                    a = ceil((Lp // 2) / e); E = ceil(Lp / e)
                    check(2 * beta * p ** a <= 1, line + f"; LB 2*beta*p^a <= 1 (a={a})")
                    check(2 * beta * p ** E <= p ** (E - a) - 1, f"    LB' 2*beta*p^E <= p^(E-a) - 1 (E={E}): {2 * beta * p ** E} <= {p ** (E - a) - 1}")
                    check(beta < Fraction(1, 2 * p), f"    CLG-e: no band-k above level one for k <= 2p = {2 * p}")
                    if p == 3:
                        n7 = int((sel & (7 * dmin >= M)).sum())
                        print(f"    band-7 characters of exact level {Lp}: {n7}")
                elif p == 2:
                    check(beta < Fraction(1, 3), line + "; CLG-e dyadic: no band-3 character")
                    if Lp == 1:
                        check(beta == 0, "    CLG-e dyadic: U_Q has no band character at all (beta* = 0 at level one)")
                else:
                    print("  info " + line)
    # PLANT E: one point per fibre of S_2 -> S_1 at Z_3[i]
    T = zi(3); S2 = T.circle(2)
    keep, seen = [], set()
    for s in S2:
        key = (int(s[0]) % 3, int(s[1]) % 3)
        if key not in seen:
            seen.add(key); keep.append(s)
    M, _, lev, dmin, _ = tower_scan(T, 2, S=np.array(keep))
    b = Fraction(int(dmin[lev == 2].max()), M)
    check(b >= Fraction(1, 6), f"PLANT E fires: with the fibres deleted a level-2 character reaches beta = {b} >= 1/6 (LB violated)")
    # PLANT L8: c = 1 at Q_3(sqrt3)
    T = ram3(); viol = False
    for L in range(2, 5):
        M, _, lev, _, eig = tower_scan(T, L)
        viol |= bool(np.abs(eig[lev == L]).max() > 3 ** (L - 1) + 1e-6)
    check(viol, "PLANT L8 fires: the new-character bound with c = 1 is violated on Q_3(sqrt3)(i) (so c = 2 is needed and attained)")


# ---------------------------------------------------------------- (F) level one
def legendre(a, q):
    a %= q
    return 0 if a == 0 else (1 if pow(a, (q - 1) // 2, q) == 1 else -1)


def mult_formula(q, N, sign=1):
    return {t: 1 - sign * legendre(t * t - 4 * N, q) for t in range(q)}


def mult_brute(q, a1, a2):
    z = [(x, y) for x in range(q) for y in range(q) if (x * x + y * y) % q == 1]
    out = {t: 0 for t in range(q)}
    for x, y in z:
        out[(2 * (a1 * x - a2 * y)) % q] += 1                     # Tr(a z) = 2 Re(a z)
    return out


def band_at(q, k):
    """Norm classes N in F_q^* carrying a band-k character of Gamma_q (by the multiplicity formula)."""
    return [N for N in range(1, q) if all(k * min(t, q - t) >= q for t, c in mult_formula(q, N).items() if c > 0)]


def gf2_mul(a, b, poly, n):
    r = 0
    while b:
        if b & 1:
            r ^= a
        b >>= 1; a <<= 1
        if a >> n & 1:
            a ^= poly
    return r


def gf2_irreducible(n):
    """Least irreducible polynomial of degree n over F_2 (Rabin's test), as an int with bit n set."""
    def pmod(a, f):
        df = f.bit_length() - 1
        while a and a.bit_length() - 1 >= df:
            a ^= f << (a.bit_length() - 1 - df)
        return a

    def pmulmod(a, b, f):
        r = 0
        while b:
            if b & 1:
                r ^= a
            b >>= 1; a = pmod(a << 1, f)
        return r

    def pgcd(a, b):
        while b:
            a, b = b, pmod(a, b)
        return a

    def x_pow_2k(k, f):
        r = 2
        for _ in range(k):
            r = pmulmod(r, r, f)
        return r
    primes = [r for r in range(2, n + 1) if n % r == 0 and all(r % s for s in range(2, r))]
    for f in range((1 << n) + 1, 1 << (n + 1), 2):
        if x_pow_2k(n, f) != 2:
            continue
        if all(pgcd(f, x_pow_2k(n // r, f) ^ 2) == 1 for r in primes):
            return f
    raise RuntimeError


def uq_spectrum(Q):
    n = 2 * (Q.bit_length() - 1); poly = gf2_irreducible(n); size = 1 << n
    def pw(a, k):
        r = 1
        while k:
            if k & 1:
                r = gf2_mul(r, a, poly, n)
            a = gf2_mul(a, a, poly, n); k >>= 1
        return r
    fac = [r for r in range(2, Q + 2) if (Q + 1) % r == 0 and all(r % s for s in range(2, r))]
    g = next(g for g in (pw(y, Q - 1) for y in range(2, size)) if all(pw(g, (Q + 1) // r) != 1 for r in fac))
    mu = [1]
    for _ in range(Q):
        mu.append(gf2_mul(mu[-1], g, poly, n))
    assert len(set(mu)) == Q + 1 and gf2_mul(mu[-1], g, poly, n) == 1
    def trace(x):
        s, y = 0, x
        for _ in range(n):
            s ^= y; y = gf2_mul(y, y, poly, n)
        assert s in (0, 1)
        return s
    tmask = sum(trace(1 << j) << j for j in range(n))
    W = np.array([sum(trace(gf2_mul(1 << j, z, poly, n)) << j for j in range(n)) for z in mu], dtype=np.int64)
    A = np.arange(size, dtype=np.int64)
    pop = np.array([bin(i).count("1") & 1 for i in range(1 << 16)], dtype=np.int64)
    eig = np.zeros(size, dtype=np.int64)
    for w in W:
        x = A & w
        par = (pop[x & 0xFFFF] + pop[(x >> 16) & 0xFFFF]) & 1
        eig += 1 - 2 * par
    assert eig[0] == Q + 1 and tmask
    return int(eig.min())


def part_F():
    print("(F) level one")
    for q in (7, 11, 19, 23):
        agree = all(mult_brute(q, a1, a2) == mult_formula(q, (a1 * a1 + a2 * a2) % q)
                    for a1 in range(q) for a2 in range(q) if (a1, a2) != (0, 0))
        check(agree, f"multiplicity formula 1 - eta(t^2 - 4N) = brute force at q = {q}")
    plant = all(mult_brute(7, a1, a2) == mult_formula(7, (a1 * a1 + a2 * a2) % 7, sign=-1)
                for a1 in range(7) for a2 in range(7) if (a1, a2) != (0, 0))
    check(not plant, "PLANT F fires: the sign-flipped formula disagrees with the brute force at q = 7")
    check(len(band_at(7, 4)) > 0, f"control: Gamma_7 carries band-4 characters (norm classes {band_at(7, 4)}; C9)")
    qs = [q for q in range(11, 60) if q % 4 == 3 and all(q % s for s in range(2, q))]
    for q in qs:
        check(band_at(q, 4) == [], f"no band-4 character of Gamma_{q}")
    for q in (23, 43, 59):
        check(band_at(q, 5) == [], f"no band-5 character of Gamma_{q}")
    for q in (11, 19):
        print(f"  info band-5 norm classes at q = {q}: {band_at(q, 5)}")
    check(67 - 8 * 67 ** 0.5 + 1 > 0 and 59 - 8 * 59 ** 0.5 + 1 < 0, "Hoffman-Weil: q - 8 sqrt q + 1 > 0 from q = 67 (ratio < 1/5), not yet at 59")
    for Q in (64, 128, 256):
        lm = uq_spectrum(Q)
        floor = 1 - Fraction(Q + 1, lm)
        print(f"  U_{Q}: lambda_min = {lm}, Hoffman floor 1 - (Q+1)/lambda_min = {float(floor):.4f}, Weil bound 2 sqrt Q = {2 * Q ** 0.5:.2f}")
        check(abs(lm) <= 2 * Q ** 0.5, f"U_{Q}: |lambda_min| <= 2 sqrt Q")
        if Q == 64:
            check(lm == -15 and 5 < floor < 6, "U_64: lambda_min = -15, floor 5.33 (so k >= 6)")
        else:
            check(floor > 7, f"U_{Q}: Hoffman floor > 7 (so no (E2) at k <= 7)")


def part_G():
    print("(G) LB' at p = 3: pairs (e, exact level L') that LB' leaves open at k = 7 (beta = 1/7)")
    p, beta = 3, Fraction(1, 7)
    open_ = []
    for e in range(1, 5):
        for Lp in range(2, 13):
            a = ceil((Lp // 2) / e); E = ceil(Lp / e)
            if 2 * beta * p ** a <= 1 and 2 * beta * p ** E <= p ** (E - a) - 1:
                open_.append((e, Lp))
    print(f"  open: {open_}")
    check(open_ == [(e, 2 * e + 1) for e in range(1, 5)], "LB' leaves exactly (e, 2e + 1) open at k = 7, for every e")


if __name__ == "__main__":
    part_D(); part_E(); part_F(); part_G()
    print(f"\n{len(FAIL)} failure(s)")
    sys.exit(1 if FAIL else 0)
