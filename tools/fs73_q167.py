#!/usr/bin/env python3
"""fs73_q167 -- FS-73 phase P2b: Q(sqrt167)'s lattice L3e1c94c6 at three colours, and FS-61's other lattices at 167.

UNTRUSTED (tools/).  Reads FS-58/FS-61's frozen code and records (tools/fs58_search.py, tools/fs61_census.py, data/fs61/) and never
writes there; writes only data/fs73/q167/.  Every edge, membership and residue is exact integer arithmetic; floats only choose which
lattice points a ball holds and price balls.  Record: data/fs73/records/phase-P2b-q167.md.

THE QUESTION (phase P2's informative instance).  L3e1c94c6 has no periodic proper 3-colouring at any admissible N <= 20, yet FS-61
three-coloured its 1,474,541-point degree-14 ball.  Either a denser ball refuses (chi(Q(sqrt167)^2) >= 4) or the lattice is
3-colourable with no short period.

POINTS.  A vector (a, b, c, e) over M is the point ((a + b sqrt167)/M, (c + e sqrt167)/M).  O_F = Z[sqrt167] (167 = 3 mod 4).

THE RESIDUE MAP.  For a rational prime q not dividing M with 167 a square mod q, choose s with s^2 = 167 (mod q): the prime
p = (q, sqrt167 - s) of F has residue field F_q, and (a, b, c, e)/M |-> ((a + b s)/M, (c + e s)/M) mod q is additive on any
lattice with denominators prime to q, and sends unit vectors to the circle x^2 + y^2 = 1 of F_q^2 (q + 1 points when q = 3 mod 4).
So a proper k-colouring of Cay(F_q^2, U mod p) pulls back to a proper k-colouring of Cay(Lambda, U) (Theorem A's residue map, row 52,
restricted to the circle points the lattice's unit vectors actually reach), periodic with period ker(reduction).

SUBCOMMANDS (each prints a headline first and a count line last; exit 0 pass, 1 a check failed, 2 usage)
  rebuild14                    rebuild FS-61's degree-14 ball exactly; verify the stored colouring's sha256 and every edge
  fourier                      the 4-D Fourier transform of omega^c on that ball: the dominant characters
  circular [--key K] [--nmax N] every rational circular colouring c = floor(3 frac(phi)), phi in (1/N)Z^4 on the reduced basis
  residue [--key K] [--qs ...] the residue targets Cay(F_q^2, U mod p) at 3 colours, plain and gap-aimed, for p | q
  agree                        FS-61's colouring against every circular colouring with N <= 47: best fit, and where the defects sit
  census [--qs ...]            residue screen over every FS-61 lattice at 167 -> data/fs73/q167/census.jsonl
  classify [--q Q] [--maxsize K]  every symmetric subset of the circle at Q (up to rotation and reflection): 3-colourable?
  extend [--qmax Q] [--nmax N] the census's survivors: every prime <= Q with residue field F_q, circular forms N <= nmax
  quotients [--ids A,B] [--nmin N0] [--nmax N1]  the full quotient Lambda/N Lambda at 3 colours (phase P2's ask; rows here)
  witnesses                    a standalone-checked witness for every FS-61 lattice at 167 a screen coloured
  cover [--mmin A] [--mmax B]  per denominator M: all unit vectors over M, their residue sets at 23 and 43, the lattice's price
  price                        G65's price of the dense balls of L3e1c94c6 (no ball is built)
  selftest                     planted faults that must fire
"""
import sys, os, json, math, time, gzip, hashlib, argparse, itertools
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
OUT = ROOT / 'data' / 'fs73' / 'q167'
MACHINE = 'desktop (16 physical cores / 32 threads, 128 GB)'
D = 167
KEY = '120|1,1,1,3;0,2,0,2;0,0,2,2;0,0,0,4'          # L3e1c94c6 (data/fs61/aiming-167.md)
R14 = 1.6656
MODEL14 = ROOT / 'data' / 'fs61' / 'fields' / '167' / 'models' / 'ea65e4e3687e5bc9.bin.gz'
MODEL14_SHA = 'ea65e4e3687e5bc932581e75d7346661f13349ab81c4296a3eaea4f6abd56893'


def die(msg, code=2):
    print(f'FAIL: {msg}', flush=True)
    sys.exit(code)


def append(path, rec):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, 'a') as f:
        f.write(json.dumps(rec, sort_keys=True) + '\n')
        f.flush()
        os.fsync(f.fileno())


def load_jsonl(path):
    path = Path(path)
    if not path.exists():
        return []
    return [json.loads(l) for l in open(path) if l.strip()]


# ================================================================ the lattice (FS-61's objects, rebuilt with FS-61's own code)
def lattice(key=KEY):
    """(M, S, B, coords): S every unit vector over M in the lattice (FS-61's saturation), B FS-58's reduced basis over M,
    coords the integer coordinates of S on B"""
    import fs61_census as C
    M, H = C.parse_key(key)
    S = C.saturation(D, M, H)
    B, coords, cov, mc = C.FS.reduce_pool(D, M, S)
    return M, [tuple(s) for s in S], [tuple(b) for b in B], [tuple(c) for c in coords], cov


def is_unit(v, M):
    a, b, c, e = v
    return a * a + D * b * b + c * c + D * e * e == M * M and a * b + c * e == 0


# ================================================================ residues
def sqrt_mod(n, q):
    n %= q
    for s in range(q):
        if s * s % q == n:
            return s
    return None


def residue_primes(q):
    """the primes of F above q with residue field F_q, as (q, s): p = (q, sqrt167 - s); [] if 167 is not a square mod q"""
    if D % q == 0:
        return [(q, 0)]
    s = sqrt_mod(D, q)
    if s is None:
        return []
    return sorted({(q, s), (q, (-s) % q)})


def reduce_vec(v, M, q, s):
    a, b, c, e = v
    mi = pow(M, -1, q)
    return ((a + b * s) * mi % q, (c + e * s) * mi % q)


def circle(q):
    return [(x, y) for x in range(q) for y in range(q) if (x * x + y * y) % q == 1]


def residue_ask(Ubar, q, k=3, gap=False, wall=60.0, solver='cadical195', pins=True):
    """is Cay(F_q^2, Ubar) k-colourable (gap: with vertex 0's closed neighbourhood missing colour k-1)?  (verdict, colouring)"""
    from pysat.solvers import Solver
    n = q * q
    idx = lambda x, y: (x % q) * q + (y % q)
    var = lambda v, c: k * v + c + 1
    gens = sorted(set(Ubar))
    assert (0, 0) not in gens
    sv = Solver(name=solver)
    for v in range(n):
        sv.add_clause([var(v, c) for c in range(k)])
    import numpy as np
    X_, Y_ = [t.ravel() for t in np.meshgrid(np.arange(q), np.arange(q), indexing='ij')]
    src = X_ * q + Y_
    E_ = []
    for (gx, gy) in gens:
        dst = ((X_ + gx) % q) * q + (Y_ + gy) % q
        E_.append(np.stack([np.minimum(src, dst), np.maximum(src, dst)], 1))
    E_ = np.unique(np.concatenate(E_), axis=0) if E_ else np.zeros((0, 2), dtype=np.int64)
    edges = [tuple(e) for e in E_.tolist()]
    for c in range(k):
        sv.append_formula(np.stack([-(k * E_[:, 0] + c + 1), -(k * E_[:, 1] + c + 1)], 1).tolist())
    assum = [var(0, 0)] if pins else []
    if gap:
        nb = [idx(gx, gy) for gx, gy in gens]
        for v in [0] + nb:
            sv.add_clause([-var(v, k - 1)])
    else:
        # symmetry break: the origin colour 0 and one neighbour colour 1 (sound: colours are interchangeable; no precedence)
        if gens and pins:
            assum.append(var(idx(*gens[0]), 1))
    t0 = time.process_time()
    ok = sv.solve(assumptions=assum)
    dt = time.process_time() - t0
    col = None
    if ok:
        m = sv.get_model()
        col = [next(c for c in range(k) if m[var(v, c) - 1] > 0) for v in range(n)]
        assert all(col[a] != col[b] for a, b in edges), 'solver model not proper'
    sv.delete()
    return ('SAT' if ok else 'UNSAT'), col, round(dt, 3), len(edges)


def interval_colouring(Ubar, q):
    """every linear form psi on F_q^2 with 3*psi(u) in [q, 2q] for every u in Ubar: the circular 3-colourings c = floor(3 psi / q)"""
    out = []
    for al in range(q):
        for be in range(q):
            if (al, be) == (0, 0):
                continue
            if all(q <= 3 * ((al * x + be * y) % q) <= 2 * q for x, y in Ubar):
                out.append((al, be))
    return out


# ================================================================ commands
def cmd_rebuild14(save=True):
    import numpy as np
    import fs61_census as C
    print('fs73_q167 rebuild14: FS-61 tier 1c ball of L3e1c94c6 at R = 1.6656, and its stored colouring', flush=True)
    M, S, B, coords, cov = lattice()
    t0 = time.time()
    X, n = C.FS.piece(D, M, [list(b) for b in B], (0, 0, 0, 0), 'ball', R14, 2_000_000)
    E = C.FS.piece_edges(X, [list(c) for c in coords])
    raw = gzip.open(MODEL14).read()
    sha = hashlib.sha256(raw).hexdigest()
    col = np.frombuffer(raw, dtype=np.uint8)
    ok = (len(X) == 1474541 and len(E) == 10324022 and sha == MODEL14_SHA and len(col) == len(X)
          and bool((col[E[:, 0]] != col[E[:, 1]]).all()))
    rec = {'what': 'rebuild14', 'points': len(X), 'edges': int(len(E)), 'model_sha256': sha, 'units': len(S),
           'colour_counts': np.bincount(col, minlength=3).tolist(), 'proper_and_matches': ok, 'seconds': round(time.time() - t0, 1)}
    print(json.dumps(rec), flush=True)
    print(f'DONE rebuild14: {"PASS" if ok else "FAIL"}', flush=True)
    if not ok:
        sys.exit(1)
    return X, E, col, M, S, B, coords


def cmd_fourier(top=12):
    import numpy as np
    X, E, col, M, S, B, coords = cmd_rebuild14()
    lo = X.min(0)
    shape = tuple(int(2 ** math.ceil(math.log2(int(h - l + 1)))) for l, h in zip(lo, X.max(0)))
    f = np.zeros(shape, dtype=np.complex64)
    Y = X - lo
    f[Y[:, 0], Y[:, 1], Y[:, 2], Y[:, 3]] = np.exp(2j * np.pi * col / 3)
    A = np.abs(np.fft.fftn(f)) / len(X)
    idx = np.argsort(A.ravel())[::-1][:top]
    rows = []
    for i in idx:
        kk = np.unravel_index(i, shape)
        th = [round(k / p if k <= p / 2 else k / p - 1, 4) for k, p in zip(kk, shape)]
        rows.append({'amplitude': round(float(A.ravel()[i]), 4), 'theta_grid': th})
        print(rows[-1], flush=True)
    append(OUT / 'fourier.jsonl', {'what': 'fourier', 'grid': list(shape), 'top': rows, 'machine': MACHINE})
    print(f'DONE fourier: top amplitude {rows[0]["amplitude"]}', flush=True)


def circular_search(coords, nmax, nmin=2, first_only=False):
    """every N in [nmin, nmax] with a phi in (Z/N)^4 (on the coordinate basis) giving N <= 3 (c.phi mod N) <= 2N on every unit"""
    import numpy as np
    half = [c for c in coords if tuple(c) > tuple(-t for t in c)]
    zero4 = [c for c in half if c[2] == 0 and c[3] == 0]
    rest = [c for c in half if not (c[2] == 0 and c[3] == 0)]
    out = []
    for N in range(nmin, nmax + 1):
        a = np.arange(N)
        A1, A2 = [t.ravel() for t in np.meshgrid(a, a, indexing='ij')]
        m = np.ones(len(A1), bool)
        for c in zero4:
            v = (c[0] * A1 + c[1] * A2) % N
            m &= (3 * v >= N) & (3 * v <= 2 * N)
        A3, A4 = [t.ravel() for t in np.meshgrid(a, a, indexing='ij')]
        sols = []
        for a1, a2 in zip(A1[m], A2[m]):
            mm = np.ones(len(A3), bool)
            for c in rest:
                v = (c[0] * int(a1) + c[1] * int(a2) + c[2] * A3 + c[3] * A4) % N
                mm &= (3 * v >= N) & (3 * v <= 2 * N)
                if not mm.any():
                    break
            for i in np.nonzero(mm)[0]:
                sols.append((int(a1), int(a2), int(A3[i]), int(A4[i])))
        if sols:
            out.append((N, sols))
            if first_only:
                break
    return out


def cmd_circular(key, nmax, nmin=2):
    print(f'fs73_q167 circular: rational circular 3-colourings of {key}, N <= {nmax}', flush=True)
    M, S, B, coords, cov = lattice(key)
    res = circular_search(coords, nmax, nmin=nmin)
    for N, sols in res:
        print(f'N = {N}: {len(sols)} forms, e.g. {sols[0]}', flush=True)
    rec = {'what': 'circular', 'key': key, 'nmin': nmin, 'nmax': nmax, 'units': len(S), 'basis': [list(b) for b in B],
           'N_with_solutions': [N for N, _ in res], 'solutions_at_least_N': res[0][1] if res else [],
           'least_N': res[0][0] if res else None, 'machine': MACHINE}
    append(OUT / 'circular.jsonl', rec)
    print(f'DONE circular: least N {rec["least_N"]}; N with solutions {rec["N_with_solutions"][:20]}', flush=True)
    return rec


def residue_screen(key, qs, gap=True):
    M, S, B, coords, cov = lattice(key)
    rows = []
    for q in qs:
        if M % q == 0:
            rows.append({'q': q, 'status': 'q divides the denominator (not integral)'}); continue
        ps = residue_primes(q)
        if not ps:
            rows.append({'q': q, 'status': '167 non-square mod q: no residue field F_q'}); continue
        for (qq, s) in ps:
            Ubar = [reduce_vec(v, M, q, s) for v in S]
            circ = set(circle(q))
            assert all(u in circ for u in Ubar), 'a unit vector did not reduce into the circle'
            img = sorted(set(Ubar))
            v, col, dt, ne = residue_ask(img, q, 3, False)
            row = {'q': q, 's': s, 'circle': len(circ), 'image': len(img), 'plain': v, 'plain_cpu_s': dt, 'edges': ne}
            if v == 'SAT' and gap:
                vg, colg, dtg, _ = residue_ask(img, q, 3, True)
                row.update({'gap': vg, 'gap_cpu_s': dtg})
            row['interval_forms'] = len(interval_colouring(img, q)) if q <= 97 else None
            rows.append(row)
    return M, S, rows


def cmd_residue(key, qs):
    print(f'fs73_q167 residue: residue targets of {key} at q in {qs}, 3 colours', flush=True)
    M, S, rows = residue_screen(key, qs)
    for r in rows:
        print(r, flush=True)
    append(OUT / 'residue.jsonl', {'what': 'residue', 'key': key, 'units': len(S), 'rows': rows, 'machine': MACHINE})
    ncol = sum(1 for r in rows if r.get('plain') == 'SAT')
    print(f'DONE residue: {ncol} residue targets 3-colourable of {sum(1 for r in rows if "plain" in r)} asked', flush=True)


def cmd_agree(nmax=47):
    """FS-61's colouring against every rational circular 3-colouring with N <= nmax (which include the residue colourings at 23):
    the best global fit (form, shift, colour relabelling), and where the defects sit, by radius and by degree in the ball"""
    import numpy as np
    X, E, col, M, S, B, coords = cmd_rebuild14()
    forms = [(N, phi) for N, sols in circular_search(coords, nmax, nmin=2) for phi in sols]
    perms = [np.array(p) for p in itertools.permutations(range(3))]
    best = (0.0, None)
    for N, phi in forms:
        v = (X @ np.array(phi, dtype=np.int64)) % N
        for sh in range(N):
            base = (3 * ((v + sh) % N)) // N
            for p in perms:
                a = float((p[base] == col).mean())
                if a > best[0]:
                    best = (a, (N, phi, sh, p.tolist()))
    agree, (N, phi, sh, perm) = best
    ref = np.array(perm)[(3 * (((X @ np.array(phi, dtype=np.int64)) % N + sh) % N)) // N]
    assert bool((ref[E[:, 0]] != ref[E[:, 1]]).all()), 'the circular colouring is not proper on the ball'
    bad = ref != col
    deg = np.bincount(E.ravel(), minlength=len(X))
    from fs58_search import embed_matrix
    Y = X @ embed_matrix(D, M, [list(b) for b in B])
    rad = np.maximum(np.hypot(Y[:, 0], Y[:, 1]), np.hypot(Y[:, 2], Y[:, 3]))
    bins = [0, 0.8, 1.0, 1.2, 1.4, 1.5, 1.6, 1.7]
    byrad = [{'max_embedding_radius': [lo_, hi_], 'points': int(((rad >= lo_) & (rad < hi_)).sum()),
              'defect_rate': round(float(bad[(rad >= lo_) & (rad < hi_)].mean()), 4)}
             for lo_, hi_ in zip(bins[:-1], bins[1:]) if ((rad >= lo_) & (rad < hi_)).any()]
    dq = [0, 9, 12, 17, 99]
    bydeg = [{'degree': [lo_, hi_], 'points': int(((deg >= lo_) & (deg < hi_)).sum()),
              'defect_rate': round(float(bad[(deg >= lo_) & (deg < hi_)].mean()), 4)} for lo_, hi_ in zip(dq[:-1], dq[1:])]
    rec = {'what': 'agree', 'forms_tested': len(forms), 'N': N, 'phi_on_reduced_basis': list(phi), 'shift': sh, 'perm': perm,
           'agreement': round(agree, 5), 'defects': int(bad.sum()), 'by_radius': byrad, 'by_degree': bydeg, 'machine': MACHINE,
           'reference_colouring_proper_on_ball': True}
    for r in byrad + bydeg:
        print(r, flush=True)
    append(OUT / 'agree.jsonl', rec)
    print(f'DONE agree: best circular form N = {N}, phi = {phi}: FS-61 colouring agrees on {agree:.4%} of {len(X)} points', flush=True)


def cmd_census(qs):
    print(f'fs73_q167 census: the residue screen at q in {qs} over every FS-61 lattice at 167', flush=True)
    rows = load_jsonl(ROOT / 'data' / 'fs61' / 'fields' / '167' / 'lattices.jsonl')
    done = {r['key'] for r in load_jsonl(OUT / 'census.jsonl')}
    n = 0
    for L in rows:
        if L['key'] in done:
            continue
        t0 = time.time()
        M, S, rr = residue_screen(L['key'], qs)
        col = [f'{r["q"]}/{r["s"]}' for r in rr if r.get('plain') == 'SAT']
        gap = [f'{r["q"]}/{r["s"]}' for r in rr if r.get('gap') == 'SAT']
        rec = {'what': 'census', 'id': L['id'], 'key': L['key'], 'units': len(S), 'three_integral': L.get('three_integral'),
               'covolume': L.get('covolume'), 'rank': L.get('rank'), 'rows': rr, 'coloured_at': col, 'gapped_at': gap,
               'seconds': round(time.time() - t0, 2), 'machine': MACHINE}
        append(OUT / 'census.jsonl', rec)
        n += 1
        print(f'{L["id"]} units {len(S)} 3int {L.get("three_integral")} coloured at {col} gapped at {gap}', flush=True)
    allr = load_jsonl(OUT / 'census.jsonl')
    unexplained = [r['id'] for r in allr if not r['coloured_at']]
    print(f'DONE census: {len(allr)} lattices, {len(allr) - len(unexplained)} 3-coloured by a residue target; '
          f'not coloured by any: {unexplained}', flush=True)


def cmd_extend(qmax, nmax):
    """the lattices the census leaves (no residue target at the census primes, not 3-integral): every prime q <= qmax with a
    residue field F_q (either class mod 4, and the ramified 167), and every circular form with N <= nmax"""
    import fs58_search  # noqa: F401  (FS-61's saturation path)
    cen = load_jsonl(OUT / 'census.jsonl')
    left = [r for r in cen if not r['coloured_at'] and not r.get('three_integral')]
    qs = [q for q in range(5, qmax + 1) if all(q % p for p in range(2, int(q ** 0.5) + 1))]
    print(f'fs73_q167 extend: {len(left)} lattices, primes 5..{qmax} with a residue field F_q, circular N <= {nmax}', flush=True)
    done = {r['key'] for r in load_jsonl(OUT / 'extend.jsonl')}
    for L in left:
        if L['key'] in done:
            continue
        t0 = time.time()
        M, S, rr = residue_screen(L['key'], [q for q in qs if residue_primes(q)], gap=True)
        col = [f'{r["q"]}/{r["s"]}' for r in rr if r.get('plain') == 'SAT']
        M_, S_, B_, coords, cov = lattice(L['key'])
        circ = circular_search(coords, nmax, first_only=True)
        rec = {'what': 'extend', 'id': L['id'], 'key': L['key'], 'units': len(S), 'qmax': qmax, 'nmax': nmax,
               'residue_rows': [{k: r[k] for k in ('q', 's', 'circle', 'image', 'plain', 'gap') if k in r} for r in rr if 'plain' in r],
               'coloured_at': col, 'circular_least_N': circ[0][0] if circ else None,
               'circular_example': circ[0][1][0] if circ else None, 'seconds': round(time.time() - t0, 1), 'machine': MACHINE}
        append(OUT / 'extend.jsonl', rec)
        img = {r['q']: f'{r["image"]}/{r["circle"]}' for r in rr if 'plain' in r and r['q'] <= 83}
        print(f'{L["id"]} units {len(S)} M {M}: coloured at {col[:6]}{"..." if len(col) > 6 else ""}; circular least N '
              f'{rec["circular_least_N"]}; images {img}; {rec["seconds"]} s', flush=True)
    allr = load_jsonl(OUT / 'extend.jsonl')
    left2 = [r['id'] for r in allr if not r['coloured_at'] and r['circular_least_N'] is None]
    print(f'DONE extend: {len(allr)} lattices; still with no residue or circular 3-colouring: {left2}', flush=True)


def circle_generator(q):
    """a generator g of the norm-one circle {x^2 + y^2 = 1} of F_q^2 (q = 3 mod 4: cyclic of order q + 1), and its powers"""
    mul = lambda a, b: ((a[0] * b[0] - a[1] * b[1]) % q, (a[0] * b[1] + a[1] * b[0]) % q)
    C = circle(q)
    for g in C:
        pw, z = [], (1, 0)
        for _ in range(q + 1):
            pw.append(z)
            z = mul(z, g)
        if len(set(pw)) == q + 1:
            return g, pw
    raise AssertionError('no generator')


def cmd_classify(q=23, maxsize=None):
    """every symmetric subset S of the circle at q (a union of antipodal pairs {g^k, g^(k + (q+1)/2)}), asked: is Cay(F_q^2, S)
    3-colourable?  Rotation z -> g z and reflection (x, y) -> (x, -y) are automorphisms of F_q^2 carrying S to gS and to its mirror,
    so the verdict is a function of the dihedral orbit of the pair set; every orbit is asked once."""
    g, pw = circle_generator(q)
    h = (q + 1) // 2
    idx_of = {pt: k for k, pt in enumerate(pw)}
    print(f'fs73_q167 classify q = {q}: circle of {q + 1} points, {h} antipodal pairs, generator {g}', flush=True)
    def canon(T):
        best = None
        for r in range(h):
            for refl in (False, True):
                img = tuple(sorted(((-k if refl else k) + r) % h for k in T))
                if best is None or img < best:
                    best = img
        return best
    orbits = {}
    sizes = range(0, h + 1) if maxsize is None else range(0, maxsize + 1)
    for sz in sizes:
        for T in itertools.combinations(range(h), sz):
            c = canon(T)
            if c not in orbits:
                orbits[c] = None
    print(f'  {len(orbits)} dihedral orbits of pair sets', flush=True)
    t0 = time.time()
    nogap, disagree = [], []
    for c in sorted(orbits, key=lambda t: (len(t), t)):
        S = [pw[k] for k in c] + [pw[k + h] for k in c]
        if not S:
            orbits[c] = 'SAT'; continue
        # downward closure: a subset of a colourable set is colourable; a superset of a refusing set refuses
        v, col, dt, ne = residue_ask(S, q, 3, False)
        orbits[c] = v
        if v == 'UNSAT':
            vr, _, _, _ = residue_ask(S, q, 3, False, solver='glucose4', pins=False)
            if vr != 'UNSAT':
                disagree.append(list(c))
        if v == 'SAT':
            vg, _, _, _ = residue_ask(S, q, 3, True)
            if vg != 'SAT':
                nogap.append(list(c))
    col_sets = [c for c, v in orbits.items() if v == 'SAT']
    ref_sets = [c for c, v in orbits.items() if v == 'UNSAT']
    # sanity: the verdict is monotone (checked on every orbit pair related by adding one pair)
    mono_bad = 0
    for c in col_sets:
        for k in range(h):
            if k not in c:
                pass
    for c in ref_sets:
        for k in range(h):
            if k not in c:
                d_ = canon(tuple(sorted(c + (k,))))
                if d_ in orbits and orbits[d_] == 'SAT':
                    mono_bad += 1
    maximal_col = [c for c in col_sets if all(canon(tuple(sorted(c + (k,)))) not in orbits or orbits[canon(tuple(sorted(c + (k,))))] == 'UNSAT'
                                             for k in range(h) if k not in c)]
    minimal_ref = [c for c in ref_sets if all(orbits[canon(tuple(x for x in c if x != k))] == 'SAT' for k in c)]
    bysize = {}
    for c, v in orbits.items():
        bysize.setdefault(len(c), [0, 0])[0 if v == 'SAT' else 1] += 1
    rec = {'what': 'classify', 'q': q, 'generator': list(g), 'pairs': h, 'orbits': len(orbits),
           'by_size_colourable_refusing': {str(k): v for k, v in sorted(bysize.items())},
           'maximal_colourable': [list(c) for c in maximal_col] if maxsize is None else 'not computed (size-capped run)',
           'minimal_refusing': [list(c) for c in minimal_ref], 'maxsize': maxsize,
           'monotonicity_violations': mono_bad, 'colourable_without_gapped_colouring': nogap,
           'refusals_replicated_by': 'glucose4, no pins, no symmetry break', 'replication_disagreements': disagree, 'seconds': round(time.time() - t0, 1), 'machine': MACHINE,
           'convention': 'pair k = {g^k, g^(k+h)}, g the generator above, powers in the multiplication (x1x2 - y1y2, x1y2 + x2y1)'}
    append(OUT / f'classify-{q}.jsonl', rec)
    for k, v in sorted(bysize.items()):
        print(f'  {k:2d} pairs: {v[0]} orbits colourable, {v[1]} refusing', flush=True)
    if maxsize is None:
        print(f'  maximal colourable (orbit reps): {[list(c) for c in maximal_col]}', flush=True)
    print(f'  minimal refusing (orbit reps, {len(minimal_ref)}): {[list(c) for c in minimal_ref][:12]}', flush=True)
    print(f'  refusals re-asked by glucose4 with no pins: {len(disagree)} disagreements {disagree[:5]}', flush=True)
    print(f'  colourable orbits with NO gapped colouring: {len(nogap)} {nogap[:10]}', flush=True)
    print(f'DONE classify q = {q}: {len(col_sets)} colourable orbits, {len(ref_sets)} refusing, monotonicity violations {mono_bad}', flush=True)
    return orbits, pw, canon


def cmd_cover(mmax, mmin=1):
    """for each denominator M: U_M = every unit vector of Q(sqrt167)^2 over M (FS-58's enumerator), its residue pair-sets at the two
    primes above 23 and above 43, each asked at 3 colours, and the lattice Z<U_M>'s covolume and G65 price.  U_M is a subset of the
    unit vectors of Z<U_M>, so a REFUSING residue set is a fact about Z<U_M>; a colourable one is a fact about U_M only (saturation
    may add vectors).  Which M first make both 23-sets refuse, i.e. give a lattice the residue screen at 23 cannot colour?"""
    from fs58_local import units_d
    import fs58_search as FS58
    done = {r['M'] for r in load_jsonl(OUT / 'cover.jsonl')}
    print(f'fs73_q167 cover: M in [{mmin}, {mmax}]', flush=True)
    for M in range(mmin, mmax + 1):
        if M in done:
            continue
        U = sorted(set(map(tuple, units_d(M, D))))
        rec = {'what': 'cover', 'M': M, 'units': len(U), 'machine': MACHINE}
        rows = {}
        for q in (23, 43):
            if M % q == 0:
                rows[str(q)] = 'q | M'
                continue
            for (qq, s_) in residue_primes(q):
                Ub = sorted({reduce_vec(v, M, q, s_) for v in U})
                v, _, _, _ = residue_ask(Ub, q, 3, False) if Ub else ('SAT', None, 0, 0)
                rows[f'{q}/{s_}'] = {'image': len(Ub), 'verdict': v}
        rec['residues'] = rows
        import numpy as np
        rank = int(np.linalg.matrix_rank(np.array(U, dtype=float))) if U else 0
        # 3-adic poles: 3 is inert in Q(sqrt167) (167 = 2 mod 3), so (a + b sqrt167)/M is 3-integral iff 3^v3(M) divides a and b
        v3 = lambda n: 0 if n == 0 else (1 + v3(n // 3) if n % 3 == 0 else 0)
        pole3 = [u for u in U if v3(math.gcd(math.gcd(math.gcd(math.gcd(M, u[0]), u[1]), u[2]), u[3])) < v3(M)]
        rec['units_with_3_pole'] = len(pole3)
        if rank == 4:
            B, coords, cov, mc = FS58.reduce_pool(D, M, [tuple(u) for u in U])
            g = len(U)
            rec['covolume'] = cov
            for target in (14, 18):
                if g * phi_R(50.0) ** 2 <= target:
                    rec[f'N{target}'] = None
                    continue
                lo, hi = 0.51, 50.0
                for _ in range(80):
                    mid = (lo + hi) / 2
                    lo, hi = (mid, hi) if g * phi_R(mid) ** 2 < target else (lo, mid)
                rec[f'N{target}'] = int(math.pi ** 2 * hi ** 4 / cov)
        rec['rank'] = rank
        ref23 = [k for k, r in rows.items() if k.startswith('23/') and isinstance(r, dict) and r['verdict'] == 'UNSAT']
        ref43 = [k for k, r in rows.items() if k.startswith('43/') and isinstance(r, dict) and r['verdict'] == 'UNSAT']
        rec['refuses_both_23'] = len(ref23) == 2
        rec['refuses_both_43'] = len(ref43) == 2
        rec['candidate'] = rank == 4 and len(pole3) > 0 and rec['refuses_both_23'] and rec['refuses_both_43']
        append(OUT / 'cover.jsonl', rec)
        if rec['candidate']:
            print(f'M {M}: {len(U)} units, rank {rank}, 23: {[(k, r["image"], r["verdict"]) for k, r in rows.items() if isinstance(r, dict) and k.startswith("23/")]}'
                  f', 43 both refuse {rec["refuses_both_43"]}, N14 {rec.get("N14")}, N18 {rec.get("N18")}', flush=True)
    allr = load_jsonl(OUT / 'cover.jsonl')
    hits = [r['M'] for r in allr if r.get('candidate')]
    print(f'DONE cover: {len(allr)} denominators; rank 4, with a 3-pole, refusing at both primes above 23 and above 43: {hits[:60]}',
          flush=True)


def cmd_quotients(ids, nmin, nmax):
    """the FULL periodic quotient Cay(Lambda/N Lambda, U mod N) at 3 colours, N in [nmin, nmax] admissible, by phase P2's own ask
    (tools/fs73_table.ask_k: kissat with the origin/neighbour pin, every refusal re-asked by cadical break-free), with rows and any
    colouring written HERE (data/fs73/q167/), never into P2's finished table.  Covers every colouring of period N Lambda, linear or not."""
    import fs73_table as TB
    import fs73_screen as SC
    TB.COLDIR = str(OUT / 'colourings')                       # P2's directory is finished: never write there
    rows = TB.Rows(str(OUT / 'quotients.jsonl'))
    keys = {r['id']: r['key'] for r in load_jsonl(ROOT / 'data' / 'fs61' / 'fields' / '167' / 'lattices.jsonl')}
    for name in ids:
        lat, _ = TB.fs61_shape(167, keys[name])
        lat.saturate('box')
        U, r = lat.U, lat.rank
        lid = f'Q167|fs61:{name}'
        for N in range(nmin, nmax + 1):
            Q = SC.Quot(SC.NW(N, r), r)
            if not Q.admissible(U):
                print(f'{name} N = {N}: inadmissible', flush=True)
                continue
            rec, col = TB.ask_k(rows, f'{lid}|k3|N{N}|plain', Q, U, 3, 'plain', None, lid)
            rep = (rec.get('replication') or {}).get('verdict')
            print(f'{name} N = {N}: {Q.n} classes, {rec["verdict"]} ({rec.get("cpu_s")} s; break-free cadical {rep})', flush=True)
    print('DONE quotients', flush=True)


def cmd_witnesses():
    """one standalone witness per lattice of FS-61 at 167 that a screen coloured (census: its least colouring prime, as a table of
    F_q^2; extend: its least residue prime, or the circular form), written to data/fs73/q167/witnesses/ and checked by the standalone
    checker tools/fs73_q167_check.py in a subprocess (it imports nothing from here)"""
    import subprocess
    from fractions import Fraction as Fr
    import fs61_census as C
    wd = OUT / 'witnesses'
    wd.mkdir(parents=True, exist_ok=True)
    recs = {r['id']: r for r in load_jsonl(OUT / 'census.jsonl')}
    ext = {r['id']: r for r in load_jsonl(OUT / 'extend.jsonl')}
    out = []
    for lid, r in sorted(recs.items()):
        key = r['key']
        M, H = C.parse_key(key)
        coloured = r['coloured_at'] or (ext.get(lid) or {}).get('coloured_at') or []
        w = {'lattice_id': lid, 'fs61_key': key, 'd': D, 'M': M, 'H': [list(h) for h in H], 'unit_count': r['units']}
        if coloured:
            q, s_ = map(int, coloured[0].split('/'))
            Mx, S, B, coords, cov = lattice(key)
            Ub = sorted({reduce_vec(v, M, q, s_) for v in S})
            v, col, dt, ne = residue_ask(Ub, q, 3, True)
            assert v == 'SAT'
            w.update({'kind': 'table', 'q': q, 's': s_, 'table': ''.join(map(str, col))})
        elif lid in ext and ext[lid].get('circular_least_N'):
            N = ext[lid]['circular_least_N']
            phiB = ext[lid]['circular_example']
            Mx, S, B, coords, cov = lattice(key)
            # phi on the rows of H: each H_i (over M) is an integer combination of the reduced basis B
            import numpy as np
            Binv = np.linalg.inv(np.array(B, dtype=float))
            phiH = []
            for h in H:
                c = [Fr(round(x)) for x in np.array(h, dtype=float) @ Binv]
                assert tuple(sum(int(c[j]) * B[j][t] for j in range(4)) for t in range(4)) == tuple(h)
                phiH.append(sum(int(c[j]) * phiB[j] for j in range(4)) % N)
            w.update({'kind': 'form_mod_N', 'N': N, 'phi_on_H_rows': phiH})
        else:
            out.append((lid, 'no colouring (not claimed)', r.get('three_integral')))
            continue
        path = wd / f'{lid}.json'
        path.write_text(json.dumps(w))
        p_ = subprocess.run([sys.executable, str(ROOT / 'tools' / 'fs73_q167_check.py'), str(path)], capture_output=True, text=True)
        verdict = p_.stdout.strip().splitlines()[-1].split(':')[0]
        out.append((lid, verdict, w['kind'], w.get('q', w.get('N'))))
        print(lid, verdict, w['kind'], w.get('q', w.get('N')), flush=True)
    append(OUT / 'witnesses.jsonl', {'what': 'witnesses', 'rows': out, 'machine': MACHINE})
    nc = sum(1 for o in out if o[1] == 'CERTIFIED')
    print(f'DONE witnesses: {nc} CERTIFIED of {len(out)} lattices; not certified: {[o for o in out if o[1] != "CERTIFIED"]}', flush=True)


def phi_R(R):
    return (2 * R * R * math.acos(1 / (2 * R)) - 0.5 * math.sqrt(4 * R * R - 1)) / (math.pi * R * R)


def cmd_price():
    M, S, B, coords, cov = lattice()
    g = len(S)
    print(f'fs73_q167 price: G65 degree law on L3e1c94c6, g = {g}, covolume {cov:.6g}', flush=True)
    out = []
    for target in (14, 16, 18, 20, 22, 24):
        lo, hi = 0.51, 20.0
        for _ in range(100):
            mid = (lo + hi) / 2
            if g * phi_R(mid) ** 2 < target:
                lo = mid
            else:
                hi = mid
        R = hi
        pts = math.pi ** 2 * R ** 4 / cov
        edges = target * pts / 2
        clauses = 3 * edges + pts
        # memory model: kissat ~ 24 B per binary clause (two watches + arena), cadical ~ 3x that; DIMACS ~ 22 B per clause
        rec = {'degree': target, 'R': round(R, 4), 'points': int(pts), 'edges': int(edges), 'clauses': int(clauses),
               'dimacs_GB': round(clauses * 22 / 1e9, 1), 'kissat_GB_est': round(clauses * 24 / 1e9, 1),
               'cadical_GB_est': round(clauses * 70 / 1e9, 1), 'build_GB_est': round(pts * 4 * 8 * 6 / 1e9 + edges * 16 * 3 / 1e9, 1)}
        out.append(rec)
        print(rec, flush=True)
    append(OUT / 'price.jsonl', {'what': 'price', 'units': g, 'covolume': cov, 'rows': out, 'machine': MACHINE})
    print('DONE price', flush=True)


def cmd_selftest():
    """planted faults: each must fire, and its faithful twin must pass"""
    print('fs73_q167 selftest', flush=True)
    fails = 0
    M, S, B, coords, cov = lattice()
    # 1. every saturated vector is a unit vector; a moved one is not
    assert all(is_unit(v, M) for v in S)
    v = S[0]
    fails += is_unit((v[0] + 1,) + v[1:], M)
    # 2. the residue map is additive on the basis and sends units to the circle at 23; a wrong root does not
    (q, s), = [p for p in residue_primes(23)][:1]
    circ = set(circle(23))
    good = all(reduce_vec(u, M, 23, s) in circ for u in S)
    bad_s = next(t for t in range(23) if t * t % 23 != D % 23)
    bad = all(reduce_vec(u, M, 23, bad_s) in circ for u in S)
    print(f'  residue: true root sends all {len(S)} units to the circle: {good}; a false root does: {bad} (must be False)')
    fails += (not good) + bad
    # 3. the interval form found must fail when one unit's residue is moved to the circle's middle third... planted by adding a
    #    circle point psi maps near 0 to the generator set
    Ubar = sorted({reduce_vec(u, M, 23, s) for u in S})
    forms = interval_colouring(Ubar, 23)
    al, be = forms[0]
    planted = next(p for p in circ if (al * p[0] + be * p[1]) % 23 in (0, 1, 22))
    forms_pl = interval_colouring(Ubar + [planted], 23)
    print(f'  interval forms: {len(forms)} faithful; with a planted circle point at psi ~ 0 the chosen form survives: '
          f'{(al, be) in forms_pl} (must be False)')
    fails += (al, be) in forms_pl
    # 4. the residue SAT ask: the full circle at 7 refuses 3 colours (chi(Gamma_7) = 4); the faithful image at 23 colours
    v7, _, _, _ = residue_ask(sorted(circle(7)), 7, 3, False)
    v23, _, _, _ = residue_ask(Ubar, 23, 3, False)
    print(f'  Cay(F_7^2, full circle) at 3 colours: {v7} (must be UNSAT); Cay(F_23^2, U mod p) at 3: {v23} (must be SAT)')
    fails += (v7 != 'UNSAT') + (v23 != 'SAT')
    print(f'DONE selftest: {fails} failures', flush=True)
    sys.exit(1 if fails else 0)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('cmd')
    ap.add_argument('--key', default=KEY)
    ap.add_argument('--nmax', type=int, default=100)
    ap.add_argument('--qmax', type=int, default=300)
    ap.add_argument('--q', type=int, default=23)
    ap.add_argument('--mmax', type=int, default=420)
    ap.add_argument('--ids', default='Ld14c588b,L21cc6506')
    ap.add_argument('--nmin', type=int, default=None)       # circular: 2; quotients: 13
    ap.add_argument('--mmin', type=int, default=1)
    ap.add_argument('--maxsize', type=int, default=None)
    ap.add_argument('--qs', default='7,11,19,23,43,47,59,67,71,79,83')
    a = ap.parse_args()
    qs = [int(t) for t in a.qs.split(',')]
    if a.cmd == 'rebuild14':
        cmd_rebuild14()
    elif a.cmd == 'fourier':
        cmd_fourier()
    elif a.cmd == 'circular':
        cmd_circular(a.key, a.nmax, a.nmin if a.nmin is not None else 2)
    elif a.cmd == 'residue':
        cmd_residue(a.key, qs)
    elif a.cmd == 'agree':
        cmd_agree()
    elif a.cmd == 'census':
        cmd_census(qs)
    elif a.cmd == 'classify':
        cmd_classify(a.q, a.maxsize)
    elif a.cmd == 'witnesses':
        cmd_witnesses()
    elif a.cmd == 'quotients':
        cmd_quotients(a.ids.split(','), a.nmin if a.nmin is not None else 13, a.nmax)
    elif a.cmd == 'cover':
        cmd_cover(a.mmax, a.mmin)
    elif a.cmd == 'extend':
        cmd_extend(a.qmax, a.nmax)
    elif a.cmd == 'price':
        cmd_price()
    elif a.cmd == 'selftest':
        cmd_selftest()
    else:
        die(f'unknown command {a.cmd}')


if __name__ == '__main__':
    main()
