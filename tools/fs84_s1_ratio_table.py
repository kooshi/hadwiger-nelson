#!/usr/bin/env python3
"""fs84_s1_ratio_table -- FS-84 S1a's exact inputs: the stable places of Q(sqrt47), every stable place's
all-levels independence-ratio bound, the binding place and its margin, and two FFT controls of Lemma P.

The statement it serves (plans/FS84-S1-derivation.md, Theorem S1a):
    rho_per(Q(sqrt47)) := sup_L alpha(Cay(R/L, U+L)) / [R:L]  <  1/4,
the sup over finite-index L <= R = Z[U] with U n L empty.  The hand proof reduces it to: for every stable
place P of E = Q(sqrt47, i) (a prime of E fixed by complex conjugation), the all-levels ratio
    r_P := sup_m alpha(G_{P,m}) / |G_{P,m}|
is < 1/4, and sup_P r_P < 1/4.  This tool computes the numbers the hand proof cites:

  (A) the stable places below B, by the elementary rule (p = 3 mod 4 and (47/p) = 1, plus the ramified 47;
      2 is split in E/F) and, independently, by PARI (a prime of F is stable iff it does not split in E/F,
      i.e. iff E and F have the same number of primes above p);
  (B) lambda_min(Gamma_q), Gamma_q = Cay(F_q^2, {x^2+y^2=1}), in rigorous interval arithmetic (mpmath.iv),
      for q in {3, 7, 11, 19, 23, 31, 43, 47}; the tower's Hoffman ratio L/(q+1+L), L = max(|lambda_min|, 2)
      (Lemma P), decided against 1/4 by the exact test  L < (q+1)/3;
  (C) the FS-66 certificate bounds U(11), U(19), U(23), read as exact rationals from their files;
  (D) Weil's tail: 2 sqrt q < (q+1)/3  <=>  q^2 - 34 q + 1 > 0, true for every q >= 34 (exact integers);
  (E) Lemma P controls by FFT: the ramified 47-tower at level 2 (O/pi^2, |V| = 47^4) and the inert 31-tower at
      level 2 (UD(Z/961, 2)): |S_2| = (q+1)q, every primitive eigenvalue |lambda| <= 2q, and
      lambda_min(G_2) = q * lambda_min(G_1).

PLANTS (--plant NAME): 'seven' declares 7 stable (Gamma_7 has ratio 2/7 > 1/4: the max must fail);
'thirty-one' shifts lambda_min(Gamma_31) down by 2e-4 (past its margin 1.56e-4: the test must fail);
'lemmaP' checks the primitive bound against 2q - 1/2 (the bound is attained at the ramified 47: must fail).
A plant that does not fire exits 4.  Exit 0 = every assertion holds; 1 = an assertion failed; 4 = a plant
did not fire.  Standard library + mpmath + numpy; PARI via `gp -q`.
"""
import hashlib
import json
import math
import os
import subprocess
import sys
from fractions import Fraction as Fr

import mpmath
import numpy as np

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
D = 47
B = 400


def is_prime(n):
    if n < 2:
        return False
    i = 2
    while i * i <= n:
        if n % i == 0:
            return False
        i += 1
    return True


def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1


def stable_by_rule(bound):
    """p odd, p != 47: stable iff p splits in F ((47/p) = 1) and p = 3 mod 4; or p inert in F never
    (residue F_{p^2}, q = 1 mod 4, split in E/F).  47: ramified in F, residue F_47, 47 = 3 mod 4: inert in
    E/F, stable.  2: ramified in F (47 = 3 mod 4), and splits in E/F (-47 = 1 mod 8): not stable."""
    out = []
    for p in range(2, bound):
        if not is_prime(p):
            continue
        if p == 2:
            continue
        if p == D:
            out.append(p)
            continue
        if p % 4 == 3 and legendre(D, p) == 1:
            out.append(p)
    return out


def stable_by_pari(bound):
    gp = f"""
F = nfinit(x^2-{D});
E = nfinit(polcompositum(x^2-{D}, x^2+1)[1]);
v = List();
forprime(p = 2, {bound - 1}, if(#idealprimedec(E, p) == #idealprimedec(F, p), listput(v, p)));
print(Vec(v));
"""
    r = subprocess.run(['gp', '-q', '-f'], input=gp, capture_output=True, text=True, timeout=120)
    if r.returncode != 0:
        raise RuntimeError('gp failed: ' + r.stderr)
    return [int(t) for t in r.stdout.strip().strip('[]').split(',') if t.strip()]


def circle(q):
    return [(x, y) for x in range(q) for y in range(q) if (x * x + y * y - 1) % q == 0]


def lambda_min_interval(q, shift=0.0):
    """Every nontrivial eigenvalue of Gamma_q depends only on the norm n = a^2 + b^2 of the character's index
    (rotation invariance); q = 3 mod 4 so every n in 1..q-1 is a norm.  Returns (interval min, all)."""
    mpmath.iv.dps = 40
    S = circle(q)
    assert len(S) == q + 1, (q, len(S))
    reps = {}
    for a in range(q):
        for b in range(q):
            n = (a * a + b * b) % q
            if n and n not in reps:
                reps[n] = (a, b)
    assert len(reps) == q - 1
    vals = {}
    two_pi = 2 * mpmath.iv.pi
    for n, (a, b) in reps.items():
        s = mpmath.iv.mpf(0)
        for (x, y) in S:
            s += mpmath.iv.cos(two_pi * ((a * x + b * y) % q) / q)
        vals[n] = s + shift
    lo = min(vals.values(), key=lambda v: v.a)
    return lo, vals


def fft_control_unramified_level2(q):
    n = q * q
    grid = np.zeros((n, n))
    xs = np.arange(n)
    sq = (xs * xs) % n
    # (x, y) with x^2 + y^2 = 1 mod q^2
    cnt = 0
    for x in range(n):
        ys = np.nonzero((sq[x] + sq) % n == 1)[0]
        grid[x, ys] = 1.0
        cnt += len(ys)
    lam = np.fft.fft2(grid).real  # eigenvalues (S = -S, so the transform is real)
    k1 = np.arange(n)[:, None]
    k2 = np.arange(n)[None, :]
    primitive = ((k1 % q) != 0) | ((k2 % q) != 0)
    return cnt, lam, primitive


def fft_control_ramified_level2(q):
    # O/pi^2 = F_q[i][pi]/(pi^2), coordinates (a0, a1, b0, b1) for (a0 + a1 i) + pi (b0 + b1 i)
    grid = np.zeros((q, q, q, q))
    cnt = 0
    for a0 in range(q):
        for a1 in range(q):
            if (a0 * a0 + a1 * a1 - 1) % q:
                continue
            for b0 in range(q):
                # Tr(a conj b) = 2 (a0 b0 + a1 b1) = 0
                for b1 in range(q):
                    if (a0 * b0 + a1 * b1) % q == 0:
                        grid[a0, a1, b0, b1] = 1.0
                        cnt += 1
    lam = np.fft.fftn(grid).real
    kb0 = np.arange(q)[None, None, :, None]
    kb1 = np.arange(q)[None, None, None, :]
    primitive = np.broadcast_to((kb0 != 0) | (kb1 != 0), lam.shape)
    return cnt, lam, primitive


def main():
    plant = None
    if '--plant' in sys.argv:
        plant = sys.argv[sys.argv.index('--plant') + 1]
    fails = []
    out = {'field': f'Q(sqrt{D})', 'plant': plant}

    # (A)
    rule = stable_by_rule(B)
    pari = stable_by_pari(B)
    print(f'(A) stable places below {B}: rule {rule}')
    print(f'    PARI (E and F have equally many primes above p): {pari}')
    if rule != pari:
        fails.append('stable-place rule disagrees with PARI')
    stable = list(rule)
    if plant == 'seven':
        stable = sorted(set(stable) | {7})
    out['stable_below_B'] = stable

    # (B)
    table = {}
    for q in (3, 7, 11, 19, 23, 31, 43, 47):
        shift = -2e-4 if (plant == 'thirty-one' and q == 31) else 0.0
        lo, vals = lambda_min_interval(q, shift)
        Lsup = max(-lo.a, mpmath.iv.mpf(2)).b  # upper end of L = max(|lambda_min|, 2)
        third = mpmath.iv.mpf(q + 1) / 3
        below = Lsup < third.a  # rigorous: L < (q+1)/3  <=>  L/(q+1+L) < 1/4
        lam_lo = mpmath.mpf(lo.a)
        hoff = float(-lam_lo / (q + 1 - lam_lo))
        margin_lambda = float(third.a - Lsup)
        table[q] = dict(lambda_min=float(lam_lo), lambda_min_width=float(lo.delta),
                        hoffman_ratio=hoff, ratio_below_quarter=bool(below),
                        quarter_minus_ratio=0.25 - hoff, margin_in_lambda=margin_lambda,
                        weil_2sqrtq=2 * math.sqrt(q))
        print(f'(B) q={q:3d} lambda_min(Gamma_q) = {float(lam_lo):+.9f} (interval width '
              f'{float(lo.delta):.1e}); tower Hoffman ratio L/(q+1+L) = {hoff:.9f}; 1/4 - ratio = '
              f'{0.25 - hoff:.4e}; below 1/4: {below}')
    out['hoffman'] = table

    # (C)
    certs = {}
    for p in (11, 19, 23):
        path = os.path.join(REPO, f'data/fs66/b1/cert-p{p}.json')
        raw = open(path, 'rb').read()
        d = json.loads(raw)
        U = Fr(d['U_num'], d['scale'])
        r = U / (p * p)
        certs[p] = dict(file=f'data/fs66/b1/cert-p{p}.json', sha256=hashlib.sha256(raw).hexdigest(),
                        U=float(U), ratio=float(r), ratio_below_quarter=bool(r < Fr(1, 4)),
                        four_U_lt_p2=bool(4 * U < p * p))
        print(f'(C) FS-66 certificate p={p}: U = {float(U):.6f}, U/p^2 = {float(r):.6f} (< 1/4: {r < Fr(1, 4)}); '
              f'sha256 {hashlib.sha256(raw).hexdigest()[:12]}')
    out['certificates'] = certs

    # the per-place all-levels bound
    per_place = {}
    for q in stable:
        if q in certs:
            per_place[q] = (certs[q]['ratio'], 'FS-66 certificate (all levels, links L1-L6)')
            if q in table:  # also report Hoffman for comparison
                pass
        elif q in table:
            per_place[q] = (table[q]['hoffman_ratio'], 'Hoffman at level one + Lemma P (all levels)')
        else:
            w = 2 * math.sqrt(q) / (q + 1 + 2 * math.sqrt(q))
            per_place[q] = (w, 'Weil + Hoffman + Lemma P (all levels)')
    # (D) Weil tail, exact
    tail_ok = all(q * q - 34 * q + 1 > 0 for q in range(34, 10 ** 5))
    print(f'(D) Weil tail: q^2 - 34q + 1 > 0 for 34 <= q < 1e5: {tail_ok} (and for all q >= 34, as q(q-34)+1 >= 1)')
    if not tail_ok:
        fails.append('Weil tail inequality')
    big = [q for q in stable if q > 47]
    tail_first = big[0] if big else None
    tail_sup = 2 * math.sqrt(tail_first) / (tail_first + 1 + 2 * math.sqrt(tail_first)) if tail_first else 0
    print(f'    first stable q above 47: {tail_first}; the tail (every stable q >= {tail_first}) is bounded by '
          f'h({tail_first}) = {tail_sup:.6f}, h(q) = 2 sqrt q / (q + 1 + 2 sqrt q) decreasing')
    binding = max(per_place.items(), key=lambda kv: kv[1][0])
    print('(S1a) per stable place (below B), the all-levels ratio bound used:')
    for q in stable:
        print(f'      q={q:3d}: {per_place[q][0]:.9f}  [{per_place[q][1]}]')
    print(f'(S1a) binding place q={binding[0]}: bound {binding[1][0]:.9f}; 1/4 - bound = {0.25 - binding[1][0]:.4e}')
    for q, (r, how) in per_place.items():
        if q in table and q not in certs and not table[q]['ratio_below_quarter']:
            fails.append(f'q={q}: tower Hoffman ratio not below 1/4')
        if q in certs and not certs[q]['ratio_below_quarter']:
            fails.append(f'q={q}: certificate ratio not below 1/4')
        if q not in table and q not in certs and not (q * q - 34 * q + 1 > 0):
            fails.append(f'q={q}: Weil tail not applicable')
    out['per_place'] = {str(q): v for q, v in per_place.items()}
    out['binding'] = dict(q=binding[0], bound=binding[1][0], margin=0.25 - binding[1][0])

    # (E) Lemma P controls
    bound_slack = -0.5 if plant == 'lemmaP' else 0.0
    ctrl = {}
    cnt, lam, prim = fft_control_ramified_level2(47)
    lm1 = table[47]['lambda_min']
    mp = float(np.abs(lam[prim]).max())
    lmin2 = float(lam.min())
    ok = (cnt == 48 * 47) and (mp <= 2 * 47 + bound_slack + 1e-6) and abs(lmin2 - 47 * lm1) < 1e-6
    ctrl['ram47_level2'] = dict(S2=cnt, max_abs_primitive=mp, bound=2 * 47, lambda_min_level2=lmin2,
                                q_times_lambda_min_level1=47 * lm1, ok=bool(ok))
    print(f'(E) ramified 47, level 2 (|V| = 47^4): |S_2| = {cnt} (expect {48 * 47}); max|primitive| = {mp:.6f} '
          f'vs 2q = 94; lambda_min(G_2) = {lmin2:.6f} vs 47 lambda_min(G_1) = {47 * lm1:.6f}: {"PASS" if ok else "FAIL"}')
    if not ok:
        fails.append('Lemma P control at the ramified 47, level 2')
    del lam, prim
    cnt, lam, prim = fft_control_unramified_level2(31)
    lm1 = table[31]['lambda_min']
    mp = float(np.abs(lam[prim]).max())
    lmin2 = float(lam.min())
    ok = (cnt == 32 * 31) and (mp <= 2 * 31 + 1e-6) and abs(lmin2 - 31 * lm1) < 1e-6
    ctrl['inert31_level2'] = dict(S2=cnt, max_abs_primitive=mp, bound=2 * 31, lambda_min_level2=lmin2,
                                  q_times_lambda_min_level1=31 * lm1, ok=bool(ok))
    print(f'(E) inert 31, level 2 (|V| = 961^2): |S_2| = {cnt} (expect {32 * 31}); max|primitive| = {mp:.6f} vs '
          f'2q = 62; lambda_min(G_2) = {lmin2:.6f} vs 31 lambda_min(G_1) = {31 * lm1:.6f}: {"PASS" if ok else "FAIL"}')
    if not ok:
        fails.append('Lemma P control at the inert 31, level 2')
    out['lemmaP_controls'] = ctrl
    out['fails'] = fails

    if plant:
        if fails:
            print(f'PLANT {plant} FIRED: {fails}')
            return 0
        print(f'PLANT {plant} DID NOT FIRE')
        return 4
    with open(os.path.join(REPO, 'data/fs84/s1/ratio_table.json'), 'w') as f:
        json.dump(out, f, indent=1)
    if fails:
        print('FAIL:', fails)
        return 1
    print('ALL PASS: every stable place of Q(sqrt47) has all-levels ratio bound < 1/4; the sup is attained at the '
          f'binding place q={binding[0]}.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
