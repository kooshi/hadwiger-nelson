#!/usr/bin/env python3
"""fs81_colour_check -- K1: the standalone checker for FS-81 stage D's k-colourability witnesses of Q(sqrt d)'s lattice graphs
(plan plans/FS81-quadratic-four-colours.md S.D, acceptance row K1; built for d = 47).  A copy of tools/fs79_p0_check.py (FS-79, d = 167)
with d and k read from the witness and d checked: an integer > 1, squarefree (so O = Z[sqrt d] is the order the enumeration assumes
and sqrt d is irrational); the certified line names d, k and the witness's sha256.  --selftest runs the plan's plants on d = 47
fixtures (data/fs81/phaseD/k1-fixtures/, written by tools/fs81_phaseD.py k1-fixture with no solver).

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

What a CERTIFIED line licenses: the LATTICE graph Cay(Z<U_M>, U_M) is properly k-coloured (every translate of the rule is proper), so
it is k-colourable; it says nothing about Q(sqrt d)'s whole plane, and nothing about any other lattice.

Prints CERTIFIED: ... or FAIL: <REASON>: ...  Exit 0 / 1.  --controls plants one fault per named reason and requires each to be
refused FOR THAT REASON, and the faithful witness to pass.  --selftest runs --controls on every fixture plus the plan's plants.
"""
import sys, json, math, copy, hashlib, os, subprocess, tempfile
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
    roots = {}                                    # square roots mod d: c^2 = M^2 - a^2 (mod d) is necessary, so only those c
    for x in range(d):
        roots.setdefault(x * x % d, []).append(x)
    for a in range(-M, M + 1):
        cm = math.isqrt(M * M - a * a)
        cs = []
        for r0 in roots.get((M * M - a * a) % d, []):
            cs.extend(range(-cm + ((r0 + cm) % d), cm + 1, d))
        for c in cs:
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


def squarefree(d):
    return all(d % (p * p) for p in range(2, math.isqrt(d) + 1))


def check(w, plant=None):
    d, M, k = w.get('d'), w.get('M'), w.get('k')
    if not (type(d) is int and d > 1 and squarefree(d)):
        raise Fail('BAD_D', f'd = {d!r} is not a squarefree integer > 1')
    if not (type(M) is int and M > 0 and type(k) is int and 2 <= k <= 10):
        raise Fail('BAD_WITNESS', f'M = {M!r}, k = {k!r}')
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
    return f'CERTIFIED: the lattice graph Cay(Z<U_{M}>, U_{M}) over Q(sqrt{d}) (d = {d}), {len(U)} unit vectors, is properly {k}-coloured by the {rule}' + \
        (f'; fan gap at the origin: {"yes" if gap else "no"}' if gap is not None else '') + \
        f'. So that lattice graph is {k}-colourable (a typed null for the plane, never a colouring of Q(sqrt{d})^2)'


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
    # FS-81's plants (plan S.D, K1): a unit vector dropped from the witness's count; d changed to 167 with the witness unchanged;
    # d not squarefree; for a quotient witness, one class recoloured to a neighbour's colour and a period that is not a period (N = 1)
    w10 = copy.deepcopy(w); w10['unit_count'] -= 1
    plants.append(('unit_dropped_from_count', 'UNIT_COUNT', w10))
    if w['d'] != 167:
        w11 = copy.deepcopy(w); w11['d'] = 167
        plants.append(('d_changed_to_167', 'UNIT_COUNT', w11))
    w12 = copy.deepcopy(w); w12['d'] = 4 * w['d']
    plants.append(('d_not_squarefree', 'BAD_D', w12))
    if kind == 'quotient':
        N, B = w['N'], [tuple(b) for b in w['basis']]
        r = len(B)
        U = sorted(units_ac(w['M'], w['d']))
        cu = next(c for c in (coords_in(B, u) for u in U) if any(x % N for x in c))
        pw = [N ** (r - 1 - i) for i in range(r)]
        j = sum((x % N) * q for x, q in zip(cu, pw))
        w13 = copy.deepcopy(w); t = list(w13['table']); t[j] = t[0]; w13['table'] = ''.join(t)
        plants.append(('one_class_recoloured', 'IMPROPER_EDGE', w13))
        w14 = copy.deepcopy(w); w14['N'] = 1; w14['table'] = w['table'][0]
        plants.append(('period_not_a_period', 'INADMISSIBLE', w14))
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


def selftest():
    """--controls on every d = 47 fixture, each must print CONTROLS: PASS, and at least one fixture of each kind the plan's plants need
    (a quotient witness; a witness whose origin sees every colour, for the false gap claim; a gapped witness)"""
    fx = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'data', 'fs81', 'phaseD', 'k1-fixtures')
    files = sorted(f for f in os.listdir(fx) if f.endswith('.json')) if os.path.isdir(fx) else []
    bad, seen = 0, set()
    for f in files:
        r = subprocess.run([sys.executable, os.path.abspath(__file__), os.path.join(fx, f), '--controls'], capture_output=True, text=True)
        out = r.stdout.strip().splitlines()
        ok = r.returncode == 0 and out and out[-1] == 'CONTROLS: PASS'
        bad += not ok
        w = json.load(open(os.path.join(fx, f)))
        seen.add(w['kind'])
        if 'fan gap at the origin: no' in out[0]:
            seen.add('gap-free')
        if 'fan gap at the origin: yes' in out[0]:
            seen.add('gapped')
        print(f'  [{"PASS" if ok else "FAIL"}] {f}: {out[0][:150] if out else r.stderr[-200:]}')
        for ln in out[1:]:
            print('      ' + ln)
    need = {'quotient', 'additive', 'gap-free'}   # a gapped witness cannot be additive on a non-bipartite lattice graph (phi(U) = -phi(U)); its first test is D1's first gapped witness
    if not need <= seen:
        print(f'  [FAIL] the fixtures lack {sorted(need - seen)}')
        bad += 1
    print(f'SELFTEST {"ALL PASS" if not bad else f"{bad} FAILED"} ({len(files)} fixtures)')
    return 1 if bad else 0


def main():
    if sys.argv[1:] == ['--selftest']:
        sys.exit(selftest())
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    raw = open(args[0], 'rb').read()
    w = json.loads(raw)
    try:
        print(check(w) + f'; witness sha256 {hashlib.sha256(raw).hexdigest()[:16]}')
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
