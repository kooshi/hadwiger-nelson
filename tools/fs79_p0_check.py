#!/usr/bin/env python3
"""fs79_p0_check -- the standalone checker for FS-79 phase 0's four-colourability witnesses over Q(sqrt d) (d = 167).

STANDARD LIBRARY ONLY; imports nothing from tools/.  Given a witness JSON it re-derives everything from (d, M, H):

  U     every unit vector over M: a^2 + d b^2 + c^2 + d e^2 = M^2, ab + ce = 0, enumerated TWICE by two different loops (over
        (b, e) and over (a, c)); the two sets must agree and have the witness's count.  The lattice is the Z-span of H (rows over
        M): H must be the Hermite normal form of U's span (so the graph is Cay(Z<U>, U), and every unit vector of that lattice is in
        U because the lattice lies in (1/M) Z[sqrt d]^2).
  rule  one of
        additive  phi : Lambda -> Z/4 or (Z/2)^2 given on H's rows; phi(u) != 0 for every u      (a proper 4-colouring, period ker phi)
        linear    theta : Lambda -> Q given on a basis B; every row of H has integer coordinates in B; theta(u) mod 1 in [1/k, 1-1/k]
                  for every u                                               (floor(k frac(theta(x) + beta)) is proper, period ker theta)
        residue   q prime, q not dividing M, s^2 = d (mod q); x -> ((a + b s)/M, (c + e s)/M) mod q is additive on Lambda; the
                  table (q^2 digits, x*q + y) is a proper colouring of Cay(F_q^2, U mod p), checked on every vertex and every image
        quotient  N, a basis B (rows over M) of Lambda; the table (N^r digits, coordinates mod N in lexicographic order) is a proper
                  colouring of Cay(Lambda/N Lambda, U mod N), no unit vector in N Lambda
  gap   if claims_gap: some colour is missing from the origin's closed neighbourhood (a fan gap: row 66 then frees every pair).

Prints CERTIFIED: ... or FAIL: <REASON>: ...  Exit 0 / 1.  --controls plants one fault per named reason and requires each to be
refused FOR THAT REASON, and the faithful witness to pass.
"""
import sys, json, math, copy
from fractions import Fraction as Fr


class Fail(Exception):
    def __init__(self, reason, msg=''):
        super().__init__(f'{reason}: {msg}')
        self.reason = reason


def units_be(M, d, plant=None):
    out = set()
    bmax = math.isqrt(M * M // d)
    for b in range(-bmax, bmax + 1):
        for e in range(-bmax, bmax + 1):
            r = M * M - d * (b * b + e * e)
            if r < 0:
                continue
            if b == 0 and e == 0:
                for a in range(-M, M + 1):
                    c2 = r - a * a
                    if c2 >= 0 and math.isqrt(c2) ** 2 == c2:
                        out.add((a, 0, math.isqrt(c2), 0))
                        out.add((a, 0, -math.isqrt(c2), 0))
                continue
            g = math.gcd(b, e)
            base = (b * b + e * e) // (g * g)
            if r % base:
                continue
            k = math.isqrt(r // base)
            if k * k * base != r:
                continue
            for kk in (k, -k):
                out.add((kk * (-e) // g, b, kk * b // g, e))
    if plant == 'drop_unit' and out:
        out.discard(max(out))
    return out


def units_ac(M, d):
    out = set()
    for a in range(-M, M + 1):
        cm = math.isqrt(M * M - a * a)
        for c in range(-cm, cm + 1):
            s = M * M - a * a - c * c
            if s % d:
                continue
            t = s // d
            if a == 0 and c == 0:
                for b in range(-math.isqrt(t), math.isqrt(t) + 1):
                    e2 = t - b * b
                    if e2 >= 0 and math.isqrt(e2) ** 2 == e2:
                        out.add((0, b, 0, math.isqrt(e2)))
                        out.add((0, b, 0, -math.isqrt(e2)))
                continue
            if t == 0:
                out.add((a, 0, c, 0))
                continue
            g = math.gcd(a, c)
            base = (a * a + c * c) // (g * g)
            if t % base:
                continue
            k = math.isqrt(t // base)
            if k * k * base != t:
                continue
            for kk in (k, -k):
                out.add((a, kk * (-c) // g, c, kk * a // g))
    return out


def hnf(rows, n=4):
    """row Hermite normal form (upper triangular, positive pivots, entries above a pivot reduced into [0, pivot))"""
    A = [list(r) for r in rows if any(r)]
    H = []
    col = 0
    while A and col < n:
        A = [r for r in A if any(r)]
        nz = [r for r in A if r[col] != 0]
        if not nz:
            col += 1
            continue
        while len([r for r in A if r[col] != 0]) > 1:
            nz = sorted([r for r in A if r[col] != 0], key=lambda r: abs(r[col]))
            p = nz[0]
            for r in nz[1:]:
                q = r[col] // p[col]
                for j in range(n):
                    r[j] -= q * p[j]
        p = next(r for r in A if r[col] != 0)
        if p[col] < 0:
            p[:] = [-x for x in p]
        A.remove(p)
        H.append(p)
        col += 1
    for i, p in enumerate(H):
        pc = next(j for j in range(n) if p[j])
        for h in H[:i]:
            q = h[pc] // p[pc]
            for j in range(n):
                h[j] -= q * p[j]
    return [tuple(h) for h in H]


def coords_in(B, v):
    """integer coordinates of v in the basis B (square, invertible over Q), or None if not integral"""
    n = len(B)
    A = [[Fr(B[j][i]) for j in range(n)] + [Fr(v[i])] for i in range(n)]      # columns = basis vectors
    for c in range(n):
        piv = next((r for r in range(c, n) if A[r][c] != 0), None)
        if piv is None:
            raise Fail('BASIS_SINGULAR', 'the basis is not invertible')
        A[c], A[piv] = A[piv], A[c]
        for r in range(n):
            if r != c and A[r][c] != 0:
                f = A[r][c] / A[c][c]
                A[r] = [x - f * y for x, y in zip(A[r], A[c])]
    x = [A[i][n] / A[i][i] for i in range(n)]
    if any(t.denominator != 1 for t in x):
        return None
    return [int(t) for t in x]


def check(w, plant=None):
    d, M, k = w['d'], w['M'], w['k']
    H = [tuple(h) for h in w['H']]
    # 1. U, twice
    U1 = units_be(M, d, plant)
    U2 = units_ac(M, d)
    if U1 != U2:
        raise Fail('UNIT_ENUMERATION_DISAGREES', f'{len(U1)} vs {len(U2)}')
    U = sorted(U1)
    for a, b, c, e in U:
        if a * a + d * b * b + c * c + d * e * e != M * M or a * b + c * e != 0:
            raise Fail('NOT_A_UNIT', str((a, b, c, e)))
    if len(U) != w['unit_count']:
        raise Fail('UNIT_COUNT', f'{len(U)} enumerated, witness says {w["unit_count"]}')
    # 2. the lattice
    if hnf(U) != hnf(H) or hnf(H) != H:
        raise Fail('SPAN_MISMATCH', 'H is not the Hermite normal form of the span of U')
    CU = [coords_in(H, u) for u in U]
    if any(c is None for c in CU):
        raise Fail('SPAN_MISMATCH', 'a unit vector outside Z<H>')
    kind = w['kind']
    nbr_colours = None
    origin_colour = None
    if kind == 'additive':
        g = w['group']
        phi = w['phi_on_H']
        for u, c in zip(U, CU):
            if g == 'Z4':
                v = sum(ci * pi for ci, pi in zip(c, phi)) % 4
                if v == 0:
                    raise Fail('ADDITIVE_ZERO_ON_UNIT', str(u))
            elif g == 'V4':
                v = (sum(ci * p for ci, p in zip(c, phi[0])) % 2, sum(ci * p for ci, p in zip(c, phi[1])) % 2)
                if v == (0, 0):
                    raise Fail('ADDITIVE_ZERO_ON_UNIT', str(u))
            else:
                raise Fail('BAD_WITNESS', f'group {g}')
        if g == 'Z4':
            origin_colour = 0
            nbr_colours = {sum(ci * pi for ci, pi in zip(c, phi)) % 4 for c in CU}
        rule = f'additive into {g}'
    elif kind == 'linear':
        B = [tuple(b) for b in w['basis']]
        th = [Fr(t) for t in w['theta_on_basis']]
        for h in H:
            if coords_in(B, h) is None:
                raise Fail('SPAN_MISMATCH', 'a row of H is not an integer combination of the basis')
        lo, hi = Fr(1, k), 1 - Fr(1, k)
        for u in U:
            cu = coords_in(B, u)
            v = sum(ci * ti for ci, ti in zip(cu, th))
            f = v - math.floor(v)
            if not (lo <= f <= hi):
                raise Fail('THETA_OUT_OF_BAND', f'{u}: theta(u) mod 1 = {f}')
        rule = f'linear form of order {math.lcm(*[t.denominator for t in th])} on the basis'
    elif kind == 'residue':
        q, s = w['q'], w['s']
        if q < 2 or any(q % p == 0 for p in range(2, math.isqrt(q) + 1)):
            raise Fail('BAD_PRIME', str(q))
        if M % q == 0:
            raise Fail('BAD_PRIME', f'{q} divides M')
        if (s * s - d) % q:
            raise Fail('ROOT_NOT_SQUARE_ROOT', f'{s}^2 != {d} mod {q}')
        tab = w['table']
        if len(tab) != q * q or any(ch not in '0123456789'[:k] for ch in tab):
            raise Fail('BAD_TABLE', 'length or alphabet')
        mi = pow(M, -1, q)
        img = set()
        for a, b, c, e in U:
            p = ((a + b * s) * mi % q, (c + e * s) * mi % q)
            if (p[0] * p[0] + p[1] * p[1]) % q != 1:
                raise Fail('NOT_ON_CIRCLE', f'{(a, b, c, e)} -> {p}')
            img.add(p)
        for x in range(q):
            for y in range(q):
                cx = tab[x * q + y]
                for gx, gy in img:
                    if tab[((x + gx) % q) * q + (y + gy) % q] == cx:
                        raise Fail('IMPROPER_EDGE', f'({x},{y}) + ({gx},{gy})')
        origin_colour = tab[0]
        nbr_colours = {tab[gx * q + gy] for gx, gy in img}
        rule = f'residue colouring at ({q}, sqrt{d} - {s}), image {len(img)} of the circle'
    elif kind == 'quotient':
        N = w['N']
        B = [tuple(b) for b in w['basis']]
        r = len(B)
        if hnf(B) != hnf(H):
            raise Fail('SPAN_MISMATCH', 'the quotient basis does not span Lambda')
        tab = w['table']
        if len(tab) != N ** r:
            raise Fail('BAD_TABLE', 'length')
        CB = [coords_in(B, u) for u in U]
        if any(all(c % N == 0 for c in cu) for cu in CB):
            raise Fail('INADMISSIBLE', 'a unit vector lies in N Lambda')
        pw = [N ** (r - 1 - i) for i in range(r)]
        idx = lambda t: sum((ti % N) * p for ti, p in zip(t, pw))           # noqa: E731
        import itertools
        for t in itertools.product(range(N), repeat=r):
            ct = tab[idx(t)]
            for cu in CB:
                if tab[idx([a + b for a, b in zip(t, cu)])] == ct:
                    raise Fail('IMPROPER_EDGE', f'class {t} + {cu}')
        origin_colour = tab[0]
        nbr_colours = {tab[idx(cu)] for cu in CB}
        rule = f'periodic colouring of Lambda/{N}Lambda'
    else:
        raise Fail('BAD_WITNESS', f'kind {kind}')
    gap = None
    if nbr_colours is not None:
        present = {str(origin_colour)} | {str(c) for c in nbr_colours}
        gap = len(present) < k
    if w.get('claims_gap') and not gap:
        raise Fail('GAP_CLAIM_FALSE', 'the origin sees every colour')
    return f'CERTIFIED: Cay(Z<U_{M}>, U_{M}) over Q(sqrt{d}), {len(U)} unit vectors, is properly {k}-coloured by the {rule}' + \
        (f'; fan gap at the origin: {"yes" if gap else "no"}' if gap is not None else '')


def controls(w):
    """one planted fault per reason; each must be refused for its own reason; the faithful witness must pass"""
    res = []
    ok = check(w)
    res.append(('faithful', ok.split(':')[0]))
    plants = [('drop_unit', 'UNIT_ENUMERATION_DISAGREES', None)]
    w2 = copy.deepcopy(w); w2['unit_count'] += 1
    plants.append(('unit_count', 'UNIT_COUNT', w2))
    w3 = copy.deepcopy(w); w3['H'][-1] = [2 * x for x in w3['H'][-1]]
    plants.append(('sublattice_H', 'SPAN_MISMATCH', w3))
    kind = w['kind']
    if kind == 'residue':
        q = w['q']
        ns = next(t for t in range(q) if all((t - x * x) % q for x in range(q)))
        w4 = copy.deepcopy(w); w4['s'] = ns
        plants.append(('nonsquare_root', 'ROOT_NOT_SQUARE_ROOT', w4))
        w5 = copy.deepcopy(w)
        a, b, c, e = min(units_ac(w['M'], w['d']))
        mi = pow(w['M'], -1, q)
        g = ((a + b * w['s']) * mi % q, (c + e * w['s']) * mi % q)
        t = list(w5['table']); t[g[0] * q + g[1]] = t[0]                   # a neighbour of the origin given the origin's colour
        w5['table'] = ''.join(t)
        plants.append(('neighbour_same_colour', 'IMPROPER_EDGE', w5))
    if kind == 'additive':
        w6 = copy.deepcopy(w); w6['phi_on_H'] = [0] * len(w6['phi_on_H']) if w['group'] == 'Z4' else [[0] * 4, [0] * 4]
        plants.append(('zero_phi', 'ADDITIVE_ZERO_ON_UNIT', w6))
    if kind == 'linear':
        w7 = copy.deepcopy(w); w7['theta_on_basis'] = ['0'] * len(w7['theta_on_basis'])
        plants.append(('zero_theta', 'THETA_OUT_OF_BAND', w7))
    if kind == 'quotient':
        w8 = copy.deepcopy(w); w8['table'] = '0' * len(w8['table'])
        plants.append(('constant_table', 'IMPROPER_EDGE', w8))
    w9 = copy.deepcopy(w); w9['claims_gap'] = True
    if 'fan gap at the origin: no' in ok:
        plants.append(('false_gap_claim', 'GAP_CLAIM_FALSE', w9))
    for name, want, ww in plants:
        try:
            check(w if ww is None else ww, plant=name if ww is None else None)
            got = 'PASSED'
        except Fail as e:
            got = e.reason
        res.append((name, got, want))
    return res


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    w = json.load(open(args[0]))
    try:
        print(check(w))
    except Fail as e:
        print(f'FAIL: {e}')
        sys.exit(1)
    if '--controls' in sys.argv:
        bad = 0
        for row in controls(w):
            if row[0] == 'faithful':
                print(f'  control faithful: {row[1]}')
                bad += row[1] != 'CERTIFIED'
            else:
                name, got, want = row
                print(f'  control {name}: refused {got} (want {want})')
                bad += got != want
        print(f'CONTROLS: {"PASS" if not bad else f"{bad} FAILED"}')
        sys.exit(1 if bad else 0)


if __name__ == '__main__':
    main()
