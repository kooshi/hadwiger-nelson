#!/usr/bin/env python3
"""fs79_p0 -- FS-79 phase 0: Q(sqrt167)'s lattices at FOUR colours.  Which could need five, and what a direct refusal would cost.

UNTRUSTED (tools/).  Imports FS-58/FS-61/FS-73's frozen code and never writes there; writes only data/fs79/phase0/.  Every edge,
membership, residue and unit vector is exact integer arithmetic; floats choose LP branches, estimate spectra and price balls, and
every colouring they lead to is re-checked exactly (here, and by the standalone tools/fs79_p0_check.py).  Record:
data/fs79/records/phase-P0.md.  Spec: plans/FS79-invariant-question.md S.P0 (the planner's) plus the owner's five additions.

POINTS.  (a, b, c, e) over M is ((a + b sqrt167)/M, (c + e sqrt167)/M); O_F = Z[sqrt167].  U_M = every unit vector over M
(a^2 + 167 b^2 + c^2 + 167 e^2 = M^2, ab + ce = 0).  Lambda_M = Z<U_M> lies in (1/M) O_F^2, so U(Lambda_M) = U_M exactly, and
Lambda_M <= Lambda_M' whenever M | M'.

THE RESIDUE MAP (Theorem A at a prime, row 52; phase P2b's Theorem 8).  For q not dividing M and s^2 = 167 (mod q), (a,b,c,e)/M ->
((a + b s)/M, (c + e s)/M) mod q is additive and sends U_M onto a subset of the circle x^2 + y^2 = 1 of F_q^2; a proper k-colouring
of Cay(F_q^2, U_M mod p) pulls back to a proper k-colouring of Cay(Lambda_M, U_M) (gapped -> gapped: red is onto F_q^2 because the
image of Lambda_M spans F_q^2 whenever two image points are independent, which the checker asserts).

SUBCOMMANDS (each prints a headline first and a DONE line last; exit 0 pass, 1 a check failed, 2 usage)
  classify --q Q --k K [--maxsize S]   every antipodal subset of the circle mod Q up to dihedral symmetry: K-colourable? gapped?
  sweep --mmax M [--mmin A] [--mlist ...]  per denominator M: U_M, rank, 3-poles, covolume, residue sets at 23 and 43 (4 colours),
                                       G65 prices at degree 14/18/22/26, CANDIDATE flag, drop reasons
  screen --ids ...                     P0.3 on L21cc6506 (= Lambda_420) and candidates: theta4, residue targets, additive, quotients
  price                                P0.4 prices of survivors
  controls                             the spec's controls (de Grey's quotient, L3e1c94c6's residue, the price formula, plants)
  selftest                             planted faults that must fire
"""
import sys, os, json, math, time, argparse, itertools, hashlib
from pathlib import Path
from fractions import Fraction as Fr
import numpy as np

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
OUT = ROOT / 'data' / 'fs79' / 'phase0'
SCR = Path('/tmp/claude-1000/-home-kooshi-source-lean-dir/229be71b-1af0-4601-bef0-f695943ce757/scratchpad/fs79-phase0')
os.environ.setdefault('FS73_SCRATCH', str(SCR))
MACHINE = 'desktop (16 physical cores / 32 threads, 128 GB)'
D = 167
RES_PRIMES = ((23, 11), (23, 12), (43, 9), (43, 34))     # the two primes above 23 and the two above 43: p = (q, sqrt167 - s)
KEY420 = '420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2'            # L21cc6506 (T44: its 60 unit vectors span this key lattice)
PLANT = os.environ.get('FS79_PLANT')                      # selftest only


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


# ================================================================ unit vectors, two independent enumerations
def units_M(M):
    """U_M by FS-58's frozen enumerator (a loop over (b, e))"""
    from fs58_local import units_d
    return sorted(set(map(tuple, units_d(M, D))))


def units_M_ac(M):
    """U_M by a second enumeration, a loop over (a, c): (b, e) is then k (-c, a)/g with k^2 (a^2 + c^2)/g^2 = (M^2 - a^2 - c^2)/167"""
    out = set()
    MM = M * M
    for a in range(-M, M + 1):
        cm = math.isqrt(MM - a * a)
        for c in range(-cm, cm + 1):
            s = MM - a * a - c * c
            if s % D:
                continue
            t = s // D
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
    W = sorted(out)
    assert all(a * a + D * b * b + c * c + D * e * e == MM and a * b + c * e == 0 for a, b, c, e in W)
    return W


def vq(n, q):
    if n == 0:
        return 99
    v = 0
    while n % q == 0:
        n //= q
        v += 1
    return v


def integrality_violations(U, M, qs=(23, 43)):
    """addition 3: at a conjugation-stable prime every unit vector is integral, so q^v_q(M) divides gcd(a, b, c, e) for q = 23, 43.
    Returns the violating (q, u) -- a failure is a defect of the enumeration or the reduction, never of the theorem"""
    bad = []
    for q in qs:
        v = vq(M, q)
        if v == 0 or v == 99:
            continue
        for u in U:
            if vq(math.gcd(math.gcd(u[0], u[1]), math.gcd(u[2], u[3])), q) < v:
                bad.append((q, list(u)))
    return bad


def rank_of(U):
    return int(np.linalg.matrix_rank(np.array(U, dtype=float))) if U else 0


def three_poles(U, M):
    """3 is inert in Q(sqrt167) (167 = 2 mod 3): (a + b sqrt167)/M is 3-integral iff 3^v3(M) | a, b"""
    v = vq(M, 3)
    if v == 0:
        return 0
    return sum(1 for u in U if vq(math.gcd(math.gcd(u[0], u[1]), math.gcd(u[2], u[3])), 3) < v)


def phi_R(R):
    return (2 * R * R * math.acos(1 / (2 * R)) - 0.5 * math.sqrt(4 * R * R - 1)) / (math.pi * R * R)


def price(g, cov, degree):
    """G65: degree = g phi(R)^2; points = pi^2 R^4 / covolume (a bidisc).  None if the lattice never reaches the degree."""
    if g * phi_R(80.0) ** 2 <= degree:
        return None
    lo, hi = 0.5000001, 80.0
    for _ in range(100):
        mid = (lo + hi) / 2
        lo, hi = (mid, hi) if g * phi_R(mid) ** 2 < degree else (lo, mid)
    return {'R': round(hi, 4), 'points': int(math.pi ** 2 * hi ** 4 / cov)}


# ================================================================ residues
def reduce_vec(v, M, q, s):
    a, b, c, e = v
    mi = pow(M, -1, q)
    return ((a + b * s) * mi % q, (c + e * s) * mi % q)


def circle(q):
    return [(x, y) for x in range(q) for y in range(q) if (x * x + y * y) % q == 1]


def circle_gen(q):
    """(g, powers) for the cyclic circle at q = 3 mod 4 (order q + 1), or at q = 1 mod 4 (order q - 1)"""
    C = circle(q)
    mul = lambda a, b: ((a[0] * b[0] - a[1] * b[1]) % q, (a[0] * b[1] + a[1] * b[0]) % q)   # noqa: E731
    n = len(C)
    for g in C:
        pw, z = [], (1, 0)
        for _ in range(n):
            pw.append(z)
            z = mul(z, g)
        if len(set(pw)) == n:
            return g, pw
    raise AssertionError('no generator')


_GEN = {}


def pairs_of(points, q):
    """a symmetric subset of the circle -> its set of antipodal pair indices k (pair k = {g^k, g^(k+h)}), h = |circle|/2"""
    if q not in _GEN:
        _GEN[q] = circle_gen(q)
    g, pw = _GEN[q]
    h = len(pw) // 2
    idx = {p: k for k, p in enumerate(pw)}
    ks = {idx[p] % h for p in points}
    assert all(pw[k] in points and pw[k + h] in points for k in ks), 'the set is not antipodally symmetric'
    return tuple(sorted(ks)), h


def canon(T, h):
    best = None
    for r in range(h):
        for refl in (False, True):
            img = tuple(sorted(((-k if refl else k) + r) % h for k in T))
            if best is None or img < best:
                best = img
    return best


def points_of(T, q):
    if q not in _GEN:
        _GEN[q] = circle_gen(q)
    g, pw = _GEN[q]
    h = len(pw) // 2
    return [pw[k] for k in T] + [pw[k + h] for k in T]


def cay_edges(q, S):
    X, Y = [t.ravel() for t in np.meshgrid(np.arange(q), np.arange(q), indexing='ij')]
    src = X * q + Y
    E = []
    for gx, gy in sorted(set(S)):
        dst = ((X + gx) % q) * q + (Y + gy) % q
        E.append(np.stack([np.minimum(src, dst), np.maximum(src, dst)], 1))
    return np.unique(np.concatenate(E), axis=0) if E else np.zeros((0, 2), dtype=np.int64)


def hoffman(q, S):
    """the ratio (Hoffman) floor 1 + d/|lambda_min| of Cay(F_q^2, S), floats; the eigenvalues are sum_s cos(2 pi <chi, s>/q)"""
    S = sorted(set(S))
    A, B = [t.ravel() for t in np.meshgrid(np.arange(q), np.arange(q), indexing='ij')]
    lam = np.zeros(q * q)
    for x, y in S:
        lam += np.cos(2 * np.pi * ((A * x + B * y) % q) / q)
    lmin = float(lam.min())
    return len(S), lmin, (1 + len(S) / -lmin) if lmin < -1e-12 else float('inf')


# ================================================================ SAT: pins (a clique through the origin) + value precedence
CADICAL = os.path.expanduser('~/.elan/toolchains/leanprover--lean4---v4.32.0/bin/cadical')


def colour_cnf(n, E, k, pins, gap_vertices=None, precedence=True):
    """(clauses as a list of int lists, nvars): at-least-one per vertex, one binary clause per edge and colour, the pinned clique,
    the gap (colour k-1 forbidden on gap_vertices), and value precedence on the colours neither pinned nor the gap colour (sound:
    those colours are interchangeable given the pins)"""
    x = lambda v, c: k * v + c + 1                                           # noqa: E731
    cls = [[x(v, c) for c in range(k)] for v in range(n)]
    E = np.asarray(E, dtype=np.int64).reshape(-1, 2)
    for c in range(k):
        cls += np.stack([-(k * E[:, 0] + c + 1), -(k * E[:, 1] + c + 1)], 1).tolist()
    for v, c in pins:
        cls.append([x(v, c)])
    gapc = k - 1 if gap_vertices is not None else None
    if gap_vertices is not None:
        cls += [[-x(v, gapc)] for v in gap_vertices]
    used = {c for _, c in pins}
    free = [c for c in range(k) if c not in used and c != gapc] if precedence else []
    nv = k * n
    for f1, f2 in zip(free, free[1:]):
        base = nv
        nv += n + 1
        s_ = lambda v, base=base: base + v + 1                              # noqa: E731
        cls.append([-s_(0)])
        for v in range(n):
            cls.append([-x(v, f2), s_(v)])
            cls.append([-s_(v + 1), s_(v), x(v, f1)])
    return cls, nv


def run_solver(cls, nv, budget, solver='kissat', tag='a'):
    """an external solver on a DIMACS file, killed at the budget (subprocess timeout: the budget is enforced by the parent, not
    trusted to the solver).  Returns (verdict, set of true variables or None, wall_s, cpu_s)."""
    import subprocess
    SCR.mkdir(parents=True, exist_ok=True)
    path = SCR / f'ask-{os.getpid()}-{tag}.cnf'
    with open(path, 'w') as f:
        f.write(f'p cnf {nv} {len(cls)}\n')
        f.write(''.join(' '.join(map(str, c)) + ' 0\n' for c in cls))
    exe = CADICAL if solver == 'cadical' else solver
    t0, r0 = time.time(), os.times()
    try:
        p = subprocess.run([exe, '-q', str(path)], capture_output=True, text=True, timeout=budget)
        out, rc = p.stdout, p.returncode
    except subprocess.TimeoutExpired:
        out, rc = '', None
    r1 = os.times()
    wall = round(time.time() - t0, 2)
    cpu = round((r1.children_user - r0.children_user) + (r1.children_system - r0.children_system), 2)
    path.unlink()
    sline = next((l for l in out.splitlines() if l.startswith('s ')), None)
    if rc == 10 and sline == 's SATISFIABLE':
        lits = [int(t) for l in out.splitlines() if l.startswith('v ') for t in l[2:].split()]
        return 'SAT', {l for l in lits if l > 0}, wall, cpu
    if rc == 20 and sline == 's UNSATISFIABLE':
        return 'UNSAT', None, wall, cpu
    return 'UNKNOWN', None, wall, cpu


def sat_colour(n, E, k, pins, gap_vertices=None, budget=60.0, solver='kissat', precedence=True):
    """proper k-colouring of the graph (n, E) with the pinned (vertex, colour) clique; gap_vertices: colour k-1 forbidden there.
    Returns (verdict, colouring or None, cpu_s); a SAT model is re-verified proper here."""
    cls, nv = colour_cnf(n, E, k, pins, gap_vertices, precedence)
    v, pos, wall, cpu = run_solver(cls, nv, budget, solver)
    col = None
    if v == 'SAT':
        col = []
        for u in range(n):
            cs = [c for c in range(k) if k * u + c + 1 in pos]
            assert cs, 'solver model leaves a vertex uncoloured'
            col.append(cs[0])
        E_ = np.asarray(E, dtype=np.int64).reshape(-1, 2)
        assert not np.any(np.array(col)[E_[:, 0]] == np.array(col)[E_[:, 1]]), 'solver model not proper'
        assert all(col[u] == c for u, c in pins)
        if gap_vertices is not None:
            assert all(col[u] != k - 1 for u in gap_vertices)
    return v, col, cpu


def residue_pins(q, S, k, gap):
    """origin 0, least neighbour 1, and a triangle's third vertex 2 when one exists and colour 2 is not the gap colour"""
    Sset = set(S)
    s1 = min(Sset)
    pins = [(0, 0), (s1[0] * q + s1[1], 1)]
    if k >= 3 and not (gap and k - 1 == 2):
        for s2 in sorted(Sset):
            if ((s2[0] - s1[0]) % q, (s2[1] - s1[1]) % q) in Sset:
                pins.append((s2[0] * q + s2[1], 2))
                break
    return pins


def interval_forms(q, S, k):
    """every linear form psi on F_q^2 with psi(s) mod q in [ceil(q/k), q - ceil(q/k)] for every s in S: then c = floor(k((psi + b)
    mod q)/q) is a proper k-colouring of Cay(F_q^2, S) for every shift b (a class of length <= ceil(q/k) never holds both ends of an
    edge).  Vectorised over all q^2 forms."""
    lo = -(-q // k)
    hi = q - lo
    A, B = [t.ravel() for t in np.meshgrid(np.arange(q), np.arange(q), indexing='ij')]
    ok = (A + B) > 0
    for x, y in set(S):
        v = (A * x + B * y) % q
        ok &= (v >= lo) & (v <= hi)
    return [(int(a), int(b)) for a, b in zip(A[ok], B[ok])]


def form_colouring(q, form, k, shift):
    a, b = form
    return [(k * (((a * x + b * y) + shift) % q)) // q for x in range(q) for y in range(q)]


def theta_prime(q, S):
    """Schrijver's theta' of Cay(F_q^2, S) by the Delsarte LP (floats): max sum f, f(0) = 1, f = 0 on S, f >= 0, Re f^ >= 0.
    alpha <= theta'; the graph is vertex-transitive, so theta' < q^2/k refuses k colours."""
    from scipy.optimize import linprog
    Sset = set(S)
    X = np.array([(x, y) for x in range(q) for y in range(q)], dtype=np.int64)
    Ch = np.cos(2 * np.pi * ((X @ X.T) % q) / q)
    free = [i for i, (x, y) in enumerate(X.tolist()) if (x, y) != (0, 0) and (x, y) not in Sset]
    r = linprog(-np.ones(len(free)), A_ub=-Ch[:, free], b_ub=Ch[:, 0], bounds=[(0, None)] * len(free), method='highs')
    return (1 - r.fun) if r.status == 0 else None


def residue_ask(q, S, k, gap=False, budget=60.0, spectral=True, solver='kissat', precedence=True):
    """Cay(F_q^2, S) at k colours (gap: colour k-1 missing from the origin's closed neighbourhood).  In order: the linear
    (interval) colourings; the Hoffman floor and Schrijver's theta' (refusals, floats, margins recorded; theta' only for q <= 47);
    then SAT with the pinned clique and value precedence, killed at the budget.  Returns a record; 'colouring' as digits if SAT."""
    S = sorted(set(S))
    rec = {'q': q, 'k': k, 'gap': gap, 'pairs': len(S) // 2}
    if spectral:
        for f in interval_forms(q, S, k):
            for sh in range(q):
                col = form_colouring(q, f, k, sh)
                if gap and (k - 1) in {col[0]} | {col[x * q + y] for x, y in S}:
                    continue
                rec.update({'verdict': 'SAT', 'by': f'linear form {f} shift {sh}', 'colouring': ''.join(map(str, col))})
                return rec
            if not gap:
                break
        d, lmin, floor = hoffman(q, S)
        rec['hoffman_floor'] = round(floor, 6)
        if floor > k + 1e-6:
            rec.update({'verdict': 'UNSAT', 'by': f'Hoffman ratio bound {floor:.6f} > {k} (floats; margin {floor - k:.3g})'})
            return rec
        if q <= 47 and not gap:
            th = theta_prime(q, S)
            rec['theta_prime'] = round(th, 6) if th is not None else None
            if th is not None and th < q * q / k * (1 - 1e-7):
                rec.update({'verdict': 'UNSAT', 'by': f"Schrijver theta' {th:.6f} < q^2/k = {q * q / k} (float LP; margin "
                                                      f"{q * q / k - th:.3g})"})
                return rec
    E = cay_edges(q, S)
    gv = [0] + [x * q + y for x, y in S] if gap else None
    pins = residue_pins(q, S, k, gap) if precedence else []
    v, col, dt = sat_colour(q * q, E, k, pins, gv, budget=budget, solver=solver, precedence=precedence)
    rec.update({'verdict': v, 'by': f'{solver}, pins {pins}, precedence {precedence}, budget {budget} s', 'cpu_s': dt})
    if col is not None:
        rec['colouring'] = ''.join(map(str, col))
    return rec


# ================================================================ P0.1 classification
def cmd_classify(q, k, maxsize=None, replicate=True, budget=120.0):
    """every symmetric subset of the circle mod q, up to rotation z -> g z and reflection (x, y) -> (x, -y), asked at k colours:
    colourable?  if so, with a gap?  One record per orbit in classify-q{q}-k{k}.jsonl (resumable), a summary record at the end."""
    g, pw = circle_gen(q)
    _GEN[q] = (g, pw)
    h = len(pw) // 2
    path = OUT / f'classify-q{q}-k{k}.jsonl'
    done = {tuple(r['orbit']): r for r in load_jsonl(path) if r.get('what') == 'orbit'}
    print(f'fs79_p0 classify q = {q}, k = {k}: circle of {len(pw)} points, {h} antipodal pairs, generator {g}; '
          f'{len(done)} orbits already recorded', flush=True)
    orbits = {}
    sizes = range(0, h + 1) if maxsize is None else range(0, maxsize + 1)
    for sz in sizes:
        for T in itertools.combinations(range(h), sz):
            orbits.setdefault(canon(T, h), None)
    order = sorted(orbits, key=lambda t: (len(t), t))
    print(f'  {len(orbits)} dihedral orbits', flush=True)
    t0 = time.time()
    for c in order:
        if c in done:
            orbits[c] = done[c]['verdict']
            continue
        S = points_of(c, q)
        if not S:
            rec = {'what': 'orbit', 'orbit': [], 'verdict': 'SAT', 'gapped': 'SAT', 'by': 'empty set'}
        else:
            r1 = residue_ask(q, S, k, False, budget=budget)
            rec = {'what': 'orbit', 'orbit': list(c), 'verdict': r1['verdict'], 'by': r1['by'], 'cpu_s': r1.get('cpu_s'),
                   'hoffman_floor': r1.get('hoffman_floor')}
            if r1['verdict'] == 'SAT':
                r2 = residue_ask(q, S, k, True, budget=budget)
                rec['gapped'] = r2['verdict']
            elif r1['verdict'] == 'UNSAT' and replicate and 'Hoffman' not in r1['by']:
                r3 = residue_ask(q, S, k, False, budget=budget, spectral=False, solver='cadical', precedence=False)
                rec['replication'] = r3['verdict'] + ' (cadical, no pins, no precedence)'
                assert r3['verdict'] != 'SAT', f'orbit {c}: break-free encoding SAT where the broken one refused'
        append(path, rec)
        orbits[c] = rec['verdict']
        done[c] = rec
    recs = [done[c] for c in order]
    bysize = {}
    for r in recs:
        bysize.setdefault(len(r['orbit']), {'SAT': 0, 'UNSAT': 0, 'UNKNOWN': 0})[r['verdict']] += 1
    col = [tuple(r['orbit']) for r in recs if r['verdict'] == 'SAT']
    ref = [tuple(r['orbit']) for r in recs if r['verdict'] == 'UNSAT']
    unk = [tuple(r['orbit']) for r in recs if r['verdict'] == 'UNKNOWN']
    mono_bad = 0
    for c in ref:
        for j in range(h):
            if j not in c:
                d_ = canon(tuple(sorted(c + (j,))), h)
                if orbits.get(d_) == 'SAT':
                    mono_bad += 1
    minimal_ref = [list(c) for c in ref if all(orbits.get(canon(tuple(x for x in c if x != j), h)) == 'SAT' for j in c)]
    maximal_col = ([list(c) for c in col if all(orbits.get(canon(tuple(sorted(c + (j,))), h)) == 'UNSAT'
                                                for j in range(h) if j not in c)] if maxsize is None else 'not computed (size-capped run)')
    nogap = [list(r['orbit']) for r in recs if r['verdict'] == 'SAT' and r.get('gapped') != 'SAT']
    spectral = sum(1 for r in recs if 'Hoffman' in (r.get('by') or ''))
    repl_bad = [list(r['orbit']) for r in recs if 'replication' in r and not r['replication'].startswith('UNSAT')]
    summ = {'what': 'summary', 'q': q, 'k': k, 'generator': list(g), 'pairs': h, 'orbits': len(orbits), 'maxsize': maxsize,
            'by_size': {str(s): v for s, v in sorted(bysize.items())}, 'colourable': len(col), 'refusing': len(ref),
            'unknown': [list(c) for c in unk], 'refused_by_spectrum': spectral, 'monotonicity_violations': mono_bad,
            'minimal_refusing': minimal_ref, 'maximal_colourable': maximal_col, 'colourable_without_gapped_colouring': nogap,
            'replications_not_unsat': repl_bad, 'seconds_this_run': round(time.time() - t0, 1), 'machine': MACHINE,
            'convention': 'pair j = {g^j, g^(j+h)}, powers in (x1x2 - y1y2, x1y2 + x2y1)'}
    append(path, summ)
    for s, v in sorted(bysize.items()):
        print(f'  {s:2d} pairs: {v}', flush=True)
    print(f'  minimal refusing ({len(minimal_ref)}): {minimal_ref[:10]}', flush=True)
    if maxsize is None:
        print(f'  maximal colourable ({len(maximal_col)}): {maximal_col[:10]}', flush=True)
    print(f'  colourable without a gapped colouring: {nogap[:10]}; unknown: {unk[:10]}; replications not UNSAT: {repl_bad[:5]}',
          flush=True)
    print(f'DONE classify q = {q}, k = {k}: {len(col)} colourable, {len(ref)} refusing, {len(unk)} unknown, '
          f'monotonicity violations {mono_bad}', flush=True)
    return summ


# ================================================================ P0.2 the denominator sweep
CACHE = OUT / 'residue-cache.jsonl'
_cache = None


def cached_residue(q, T, k, gap=False, budget=120.0):
    """a residue ask on the canonical pair set T at q, cached (addition 2: sets beyond the table are asked directly)"""
    global _cache
    if _cache is None:
        _cache = {(r['q'], tuple(r['orbit']), r['k'], r['gap']): r for r in load_jsonl(CACHE)}
    h = (q + 1) // 2
    T = canon(tuple(T), h)
    key = (q, T, k, gap)
    if key in _cache:
        return _cache[key]
    if q == 23 and k in (3, 4) and not gap:
        tab = {tuple(r['orbit']): r for r in load_jsonl(OUT / f'classify-q23-k{k}.jsonl') if r.get('what') == 'orbit'}
        if T in tab:
            return {'q': q, 'orbit': list(T), 'k': k, 'gap': gap, 'verdict': tab[T]['verdict'], 'how': 'P0.1 table'}
    r = residue_ask(q, points_of(T, q), k, gap, budget=budget)
    rec = {'q': q, 'orbit': list(T), 'k': k, 'gap': gap, 'verdict': r['verdict'], 'by': r['by'], 'cpu_s': r.get('cpu_s'),
           'hoffman_floor': r.get('hoffman_floor'), 'how': 'direct ask'}
    append(CACHE, rec)
    _cache[key] = rec
    return rec


def cmd_sweep(mlist):
    import fs58_search as FS58
    path = OUT / 'sweep.jsonl'
    done = {r['M'] for r in load_jsonl(path)}
    print(f'fs79_p0 sweep: {len(mlist)} denominators ({mlist[0]}..{mlist[-1]}); {len(done)} already recorded', flush=True)
    t0 = time.time()
    for M in mlist:
        if M in done:
            continue
        t1 = time.time()
        rec = {'what': 'sweep', 'M': M, 'machine': MACHINE}
        U = units_M(M)
        rec['units'] = len(U)
        bad = integrality_violations(U, M)
        rec['integrality_violations'] = len(bad)
        if bad:
            print(f'FAIL: M = {M}: {len(bad)} unit vectors with 23 or 43 in the denominator, e.g. {bad[:2]}', flush=True)
            sys.exit(1)
        drop = []
        M0 = 1
        for u in U:
            M0 = math.lcm(M0, M // math.gcd(math.gcd(M, u[0]), math.gcd(math.gcd(u[1], u[2]), u[3])))
        rec['true_denominator'] = M0
        if M0 < M and len(U) > 0:
            drop.append(f'same lattice as M = {M0}: every unit vector over {M} already has denominator dividing {M0}')
        elif M % 23 == 0 or M % 43 == 0:
            drop.append('23 or 43 divides M: U_M = U_(M without its 23, 43 part) by integrality (asserted), nothing new')
        r = rank_of(U)
        rec['rank'] = r
        rec['units_with_3_pole'] = three_poles(U, M)
        if drop:
            pass
        elif r < 4:
            drop.append(f'rank {r} < 4')
        if not drop and rec['units_with_3_pole'] == 0:
            drop.append('3-integral: 3-colourable by the kernel 3-adic barrier (row 72)')
        if not drop:
            B, coords, cov, mc = FS58.reduce_pool(D, M, [tuple(u) for u in U])
            rec['covolume'] = cov
            for deg in (14, 18, 22, 26):
                rec[f'price{deg}'] = price(len(U), cov, deg)
            res = {}
            for q, s in RES_PRIMES:                  # 23 first (the P0.1 table, free); 43 is asked only if both 23-sets refuse
                Ub = sorted({reduce_vec(u, M, q, s) for u in U})
                T, h = pairs_of(set(Ub), q)
                if q == 43 and any(v['k4'] != 'UNSAT' for k_, v in res.items() if k_.startswith('23/')):
                    res[f'{q}/{s}'] = {'pairs': len(T), 'orbit': list(canon(T, h)), 'k4': 'not asked', 'how': 'a set at 23 colours'}
                    continue
                c = cached_residue(q, T, 4)
                res[f'{q}/{s}'] = {'pairs': len(T), 'orbit': list(canon(T, h)), 'k4': c['verdict'], 'how': c['how']}
            rec['residues'] = res
            refuse_all = all(v['k4'] == 'UNSAT' for v in res.values())
            rec['all_residue_sets_refuse_four'] = refuse_all
            if not refuse_all:
                col_at = [k_ for k_, v in res.items() if v['k4'] == 'SAT']
                unk_at = [k_ for k_, v in res.items() if v['k4'] not in ('SAT', 'UNSAT')]
                if col_at:
                    drop.append(f'four-colourable: the residue set at {col_at[0]} colours (pulled back, Theorem A)')
                else:
                    drop.append(f'undecided residue sets at {unk_at} (typed UNKNOWN; not a candidate claim)')
        rec['drop'] = drop
        rec['candidate'] = not drop
        rec['seconds'] = round(time.time() - t1, 2)
        append(path, rec)
        if rec['candidate'] or (M % 60 == 0 and not drop[:1] == ['rank']):
            p18 = (rec.get('price18') or {}).get('points')
            print(f'M {M}: units {len(U)} rank {r} candidate {rec["candidate"]} '
                  f'{ {k_: (v["pairs"], v["k4"]) for k_, v in rec.get("residues", {}).items()} } N18 {p18} drop {drop[:1]}',
                  flush=True)
    allr = load_jsonl(path)
    cands = [r['M'] for r in allr if r.get('candidate')]
    print(f'DONE sweep: {len(allr)} denominators recorded; candidates {cands[:40]}{"..." if len(cands) > 40 else ""} '
          f'({len(cands)}); {round(time.time() - t0, 1)} s', flush=True)


# ================================================================ P0.3 the periodic four-colour screens
SCREEN_QS = (23, 43, 59, 67, 71, 79, 83, 29, 167)      # usable q <= 100, plus 29 (split, q = 1 mod 4) and 167's ramified prime (T18)


def lattice_M(M, U):
    """Lambda_M = Z<U_M> as an FS-73 Lattice over Q(sqrt167): H its Hermite basis over M, U the unit vectors in H-coordinates.
    U(Lambda_M) = U_M because Lambda_M lies in (1/M) O_F^2 ('gens' saturation is therefore complete)."""
    import fs73_lattice as FL
    F = FL.Field((D,))
    lat = FL.Lattice(F, [(tuple(u), M) for u in U], name=f'Q167|Lambda_{M}', M=M)
    lat.saturate('gens', gens=[tuple(u) for u in U])
    return lat


def half_rows(C):
    return [tuple(c) for c in C if tuple(c) > tuple(-t for t in c)]


def exact_theta_ok(Cint, th, k=4):
    lo, hi = Fr(1, k), 1 - Fr(1, k)
    for c in Cint:
        v = sum(ci * ti for ci, ti in zip(c, th))
        f = v - math.floor(v)
        if not (lo <= f <= hi):
            return False
    return True


def exact_point(Cint, A, th_float, k=4):
    """a rational theta with every c.theta mod 1 in [1/k, 1 - 1/k], near the float point th_float, or None"""
    from scipy.optimize import linprog
    for den in (1, 2, 3, 4, 6, 8, 12, 24, 60, 120, 240, 1000, 10 ** 4, 10 ** 5, 10 ** 6):
        th = [Fr(float(t)).limit_denominator(den) for t in th_float]
        if exact_theta_ok(Cint, th, k):
            return th
    # the cell of th_float: fix every band, maximise the slack, rationalise its centre; then snap to a vertex exactly
    lo, hi = 1 / k, 1 - 1 / k
    vals = A @ th_float
    n = np.floor(vals - lo + 1e-9)
    r = A.shape[1]
    rows = np.vstack([np.c_[-A, np.ones(len(A))], np.c_[A, np.ones(len(A))]])
    rhs = np.r_[-(n + lo), n + hi]
    res = linprog(np.r_[np.zeros(r), -1.0], A_ub=rows, b_ub=rhs, bounds=[(None, None)] * r + [(-1, 0.5)], method='highs')
    if res.status != 0 or -res.fun < -1e-9:
        return None
    x = res.x[:r]
    for den in (60, 120, 240, 1000, 10 ** 4, 10 ** 5, 10 ** 6, 10 ** 7):
        th = [Fr(float(t)).limit_denominator(den) for t in x]
        if exact_theta_ok(Cint, th, k):
            return th
    tight = []
    for i in range(len(A)):
        for tgt in (n[i] + lo, n[i] + hi):
            if abs(A[i] @ x - tgt) < 1e-7:
                tight.append((i, Fr(int(n[i])) + (Fr(1, k) if tgt == n[i] + lo else 1 - Fr(1, k))))
    # Gaussian elimination over Q on r independent tight rows
    basis, rhs_ = [], []
    for i, t in tight:
        row = [Fr(int(v)) for v in Cint[i]]
        trial = basis + [row]
        if np.linalg.matrix_rank(np.array([[float(v) for v in rr] for rr in trial])) == len(trial):
            basis.append(row)
            rhs_.append(t)
        if len(basis) == r:
            break
    if len(basis) < r:
        return None
    Mx = [basis[j] + [rhs_[j]] for j in range(r)]
    for col in range(r):
        piv = next(j for j in range(col, r) if Mx[j][col] != 0)
        Mx[col], Mx[piv] = Mx[piv], Mx[col]
        for j in range(r):
            if j != col and Mx[j][col] != 0:
                f = Mx[j][col] / Mx[col][col]
                Mx[j] = [a - f * b for a, b in zip(Mx[j], Mx[col])]
    th = [Mx[j][r] / Mx[j][j] for j in range(r)]
    return th if exact_theta_ok(Cint, th, k) else None


def theta_search(C, k=4, node_cap=2_000_000, time_cap=900.0, branch='l1'):
    """Theta_k = {theta in Hom(Lambda, R) : c.theta mod 1 in [1/k, 1 - 1/k] for every unit vector c (coordinates on a Z-basis)}.
    A point gives the proper periodic colouring floor(k {theta(x) + beta}) (T22's <= half; at k = 4 it is one-sided).  Depth-first
    branch and bound over integer bands, float LPs (HiGHS) for pruning and ranges; a point found is re-verified exactly (Fractions).
    Returns (status, theta or None, nodes): FOUND | EXHAUSTED (empty per float LPs: not a certificate) | CAPPED."""
    from scipy.optimize import linprog
    Cint = half_rows(C)
    A = np.array(Cint, dtype=float)
    m, r = A.shape
    lo, hi = 1 / k, 1 - 1 / k
    L1 = np.abs(A).sum(1)

    def lp(fixed, obj, sfloor):
        rows, rhs = [], []
        for i, n in fixed:
            rows.append(np.r_[-A[i], 1.0])
            rhs.append(-(n + lo))
            rows.append(np.r_[A[i], 1.0])
            rhs.append(n + hi)
        return linprog(obj, A_ub=np.array(rows) if rows else None, b_ub=np.array(rhs) if rows else None,
                       bounds=[(0, 1)] * r + [(sfloor, 0.5)], method='highs')
    slack_obj = np.r_[np.zeros(r), -1.0]
    stack = [()]
    nodes, t0, snap_fail = 0, time.time(), 0
    while stack:
        if nodes >= node_cap or time.time() - t0 > time_cap:
            return 'CAPPED', None, nodes, snap_fail
        fixed = stack.pop()
        nodes += 1
        res = lp(fixed, slack_obj, -1.0)
        if res.status != 0 or -res.fun < -1e-9:
            continue
        th = res.x[:r]
        vals = A @ th
        fr = vals - np.floor(vals)
        viol = np.maximum(lo - fr, fr - hi)
        fidx = {i for i, _ in fixed}
        cand = [i for i in range(m) if i not in fidx and viol[i] > 1e-9]
        if not cand:
            pt = exact_point(Cint, A, th, k)
            if pt is not None:
                return 'FOUND', pt, nodes, snap_fail
            snap_fail += 1
            cand = [i for i in range(m) if i not in fidx]
            if not cand:
                continue
            i = min(cand, key=lambda j: min(fr[j] - lo, hi - fr[j]))
        else:
            i = min(cand, key=lambda j: (L1[j], -viol[j])) if branch == "l1" else max(cand, key=lambda j: viol[j])
        e = np.zeros(r + 1)
        e[:r] = A[i]
        rmin, rmax = lp(fixed, e, 0.0), lp(fixed, -e, 0.0)
        if rmin.status != 0 or rmax.status != 0:
            continue
        a_, b_ = rmin.fun, -rmax.fun
        bands = list(range(math.ceil(a_ - hi - 1e-9), math.floor(b_ - lo + 1e-9) + 1))
        bands.sort(key=lambda n: -abs(n + 0.5 - vals[i]))
        for n in bands:
            stack.append(fixed + ((i, n),))
    return 'EXHAUSTED', None, nodes, snap_fail


def theta_order(th):
    """the order of theta in Hom(Lambda, Q/Z): the index of its kernel (the colouring's period group)"""
    return math.lcm(*[t.denominator for t in th])


def additive_screen(C):
    """every homomorphism Lambda -> Z/4 and Lambda -> V4 = (Z/2)^2 on the basis, nonzero on every unit vector: an additive 4-colouring"""
    C = np.array(C, dtype=np.int64)
    r = C.shape[1]
    P4 = np.array(list(itertools.product(range(4), repeat=r)), dtype=np.int64)
    ok4 = ((P4 @ C.T) % 4 != 0).all(1)
    P2 = np.array(list(itertools.product(range(2), repeat=r)), dtype=np.int64)
    V2 = (P2 @ C.T) % 2
    v4 = [(i, j) for i in range(len(P2)) for j in range(i + 1, len(P2)) if ((V2[i] | V2[j]) != 0).all()]
    return {'Z4': [P4[i].tolist() for i in np.nonzero(ok4)[0]], 'V4': [[P2[i].tolist(), P2[j].tolist()] for i, j in v4]}


def cmd_screen(ids, qbudget=120.0, quot_nmax=24, quot_total=2700.0, theta_cap=900.0, quotients=True):
    """P0.3 on each lattice id ('M' for Lambda_M; 'L21cc6506' is Lambda_420): (c) additive, (a) Theta_4, (b) residue targets,
    (d) full quotients.  One record per (lattice, screen) in screen.jsonl (resumable); a verdict row per lattice in verdicts.jsonl;
    each colouring found is written as a standalone witness under witnesses/ for tools/fs79_p0_check.py."""
    import fs58_search as FS58
    path = OUT / 'screen.jsonl'
    have = {(r['lattice'], r['screen']): r for r in load_jsonl(path)}
    for lid in ids:
        M = 420 if lid == 'L21cc6506' else int(lid)
        U = units_M(M)
        lat = lattice_M(M, U)
        C = [tuple(c) for c in lat.U]
        print(f'== {lid}: M {M}, {len(U)} unit vectors, rank {lat.rank}, H {lat.H}', flush=True)
        found = []

        def put(screen, rec):
            rec.update({'lattice': lid, 'M': M, 'screen': screen, 'machine': MACHINE})
            append(path, rec)
            have[(lid, screen)] = rec
            return rec
        # (c) additive
        if (lid, 'additive') not in have:
            ad = additive_screen(C)
            put('additive', {'Z4_count': len(ad['Z4']), 'V4_count': len(ad['V4']), 'Z4_example': ad['Z4'][:1],
                             'V4_example': ad['V4'][:1], 'basis': 'H'})
        r_ = have[(lid, 'additive')]
        print(f'  additive: Z/4 {r_["Z4_count"]}, V4 {r_["V4_count"]}', flush=True)
        if r_['Z4_count']:
            found.append(('additive', {'group': 'Z4', 'phi_on_H': r_['Z4_example'][0]}, None))
        elif r_['V4_count']:
            found.append(('additive', {'group': 'V4', 'phi_on_H': r_['V4_example'][0]}, None))
        # (a) Theta_4 on the reduced basis
        tkey = f'theta4@{int(theta_cap)}'
        if not any(have[(l_, k_)]['status'] == 'FOUND' for (l_, k_) in have if l_ == lid and k_.startswith('theta4')) and (lid, tkey) not in have:
            B, coords, cov, mc = FS58.reduce_pool(D, M, [tuple(u) for u in U])
            t0 = time.time()
            st, th, nodes, sf = theta_search(coords, 4, time_cap=theta_cap)
            rec = {'status': st, 'nodes': nodes, 'snap_failures': sf, 'seconds': round(time.time() - t0, 1),
                   'basis': [list(b) for b in B], 'max_coord': mc,
                   'note': 'EXHAUSTED = empty per float LPs, not a certificate; circular forms floor(4 frac(phi)) are points of Theta_4'}
            if th is not None:
                rec['theta_on_basis'] = [str(t) for t in th]
                rec['order'] = theta_order(th)
                rec['in_theta3'] = exact_theta_ok(half_rows(coords), th, 3)
            put(tkey, rec)
        tks = [have[(l_, k_)] for (l_, k_) in have if l_ == lid and k_.startswith('theta4')]
        r_ = next((t for t in tks if t['status'] == 'FOUND'), tks[-1])
        print(f'  Theta_4: {r_["status"]} after {r_["nodes"]} nodes, {r_["seconds"]} s; order {r_.get("order")}', flush=True)
        if r_['status'] == 'FOUND':
            found.append(('linear', {'basis': r_['basis'], 'theta_on_basis': r_['theta_on_basis']}, None))
        # (b) residue targets
        for q in SCREEN_QS:
            if M % q == 0 or any(g for _, _, g in found):
                continue
            for s_ in sorted({x for x in range(q) if x * x % q == D % q}):
                key = f'residue:{q}/{s_}'
                if (lid, key) not in have:
                    Ub = sorted({reduce_vec(u, M, q, s_) for u in U})
                    circ = set(circle(q))
                    assert all(p in circ for p in Ub), 'a unit vector did not reduce into the circle'
                    rp = residue_ask(q, Ub, 4, False, budget=qbudget)
                    rec = {'q': q, 's': s_, 'image': len(Ub), 'circle': len(circ), 'plain': rp['verdict'], 'plain_by': rp['by']}
                    if rp['verdict'] == 'SAT':
                        rg = residue_ask(q, Ub, 4, True, budget=qbudget)
                        rec.update({'gap': rg['verdict'], 'gap_by': rg['by']})
                        rec['colouring'] = rg.get('colouring') or rp.get('colouring')
                        rec['colouring_gapped'] = rg['verdict'] == 'SAT'
                    put(key, rec)
                r_ = have[(lid, key)]
                print(f'  residue {q}/{s_}: image {r_["image"]}/{r_["circle"]} plain {r_["plain"]} gap {r_.get("gap")}', flush=True)
                if r_['plain'] == 'SAT':
                    found.append(('residue', {'q': q, 's': s_, 'table': r_['colouring']}, r_['colouring_gapped']))
        # (d) full quotients, only while no gapped colouring is known
        gapped_known = any(g for _, _, g in found)
        if not gapped_known and quotients and not found:
            import fs73_table as TB
            import fs73_screen as SC
            TB.COLDIR = str(OUT / 'colourings')
            TB.SCRATCH = str(SCR)
            rows = TB.Rows(str(OUT / 'quotients.jsonl'))
            spent = 0.0
            for N in range(2, quot_nmax + 1):
                Qt = SC.Quot(SC.NW(N, lat.rank), lat.rank)
                if not Qt.admissible(lat.U):
                    continue
                if spent > quot_total:
                    put(f'quotient:stop', {'note': f'quotient budget {quot_total} s spent before N = {N}'})
                    break
                for aim in (('gap', 'plain') if not found else ('gap',)):
                    t0 = time.time()
                    rec, col = TB.ask_k(rows, f'Q167|L{M}|k4|N{N}|{aim}', Qt, lat.U, 4, aim, None, f'Q167|L{M}')
                    spent += time.time() - t0
                    print(f'  quotient N {N} ({Qt.n} classes) {aim}: {rec["verdict"]} ({rec.get("cpu_s")} s)', flush=True)
                    if col is not None:
                        digs = np.array(list(itertools.product(range(N), repeat=lat.rank)), dtype=np.int64)
                        table = ''.join(map(str, col[Qt.cls(digs)].tolist()))
                        found.append(('quotient', {'N': N, 'basis': [list(h) for h in lat.H], 'table': table}, aim == 'gap'))
                        break
                if found and found[-1][0] == 'quotient' and found[-1][2]:
                    break
                if found and found[-1][0] == 'quotient':
                    break
        # the verdict row and witnesses
        wd = OUT / 'witnesses'
        wd.mkdir(parents=True, exist_ok=True)
        wits = []
        for kind, data, gapped in found:
            w = {'lattice': lid, 'M': M, 'd': D, 'H': [list(h) for h in lat.H], 'unit_count': len(U), 'k': 4, 'kind': kind,
                 'claims_gap': bool(gapped), **data}
            tag = f'{lid}-{kind}' + (f'-{data["q"]}-{data["s"]}' if kind == 'residue' else '') + (f'-N{data["N"]}' if kind == 'quotient' else '')
            (wd / f'{tag}.json').write_text(json.dumps(w))
            wits.append(tag)
        v = {'what': 'verdict', 'lattice': lid, 'M': M, 'units': len(U),
             'verdict': 'FOUR-COLOURABLE' if found else 'SURVIVOR', 'rules': [f[0] for f in found],
             'gapped': any(g for _, _, g in found), 'witnesses': wits,
             'screens_searched': sorted(k_ for (l_, k_) in have if l_ == lid), 'machine': MACHINE}
        append(OUT / 'verdicts.jsonl', v)
        print(f'VERDICT {lid}: {v["verdict"]} by {v["rules"]}; gapped {v["gapped"]}', flush=True)
    print('DONE screen', flush=True)


def cmd_additive(mmax):
    """the owner's request: for every distinct lattice Lambda_M (M its true denominator, rank 4), do additive four-colourings into
    Z/4 or V4 survive?  (Fischer 1990 Ex. 4: the full plane has no additive k-colouring for k < 11, so they die somewhere up the
    chain; the first M where none survives is a landmark, not a claim about five.)"""
    path = OUT / 'additive.jsonl'
    done = {r['M'] for r in load_jsonl(path)}
    rows = [r for r in load_jsonl(OUT / 'sweep.jsonl') if r['M'] <= mmax and r.get('true_denominator') == r['M'] and r.get('rank') == 4]
    print(f'fs79_p0 additive: {len(rows)} distinct rank-4 lattices up to M = {mmax}', flush=True)
    for r in sorted(rows, key=lambda r: r['M']):
        M = r['M']
        if M in done:
            continue
        U = units_M(M)
        lat = lattice_M(M, U)
        ad = additive_screen([tuple(c) for c in lat.U])
        rec = {'what': 'additive', 'M': M, 'units': len(U), 'Z4': len(ad['Z4']), 'V4': len(ad['V4']),
               'Z4_example_on_H': ad['Z4'][:1], 'V4_example_on_H': ad['V4'][:1], 'H': [list(h) for h in lat.H],
               'candidate': r.get('candidate'), 'machine': MACHINE}
        append(path, rec)
        print(f'M {M}: units {len(U)} additive Z/4 {rec["Z4"]} V4 {rec["V4"]} candidate {r.get("candidate")}', flush=True)
    allr = sorted(load_jsonl(path), key=lambda r: r['M'])
    none = [r['M'] for r in allr if r['Z4'] == 0 and r['V4'] == 0]
    print(f'DONE additive: {len(allr)} lattices; no additive four-colouring at M = {none[:30]}', flush=True)


def refusal_ask(n, E, k=4, budget=1800.0, solvers=('kissat', 'cadical')):
    """P0.5's encoder: pin one edge's two colours (omega = 2 over Q(sqrt167), G57), value precedence on the other k - 2; each solver
    killed at the budget.  Returns {solver: (verdict, cpu_s)}."""
    E = np.asarray(E, dtype=np.int64).reshape(-1, 2)
    a, b = map(int, E[0])
    cls, nv = colour_cnf(n, E, k, [(a, 0), (b, 1)], None, True)
    out = {}
    for sv in solvers:
        v, pos, wall, cpu = run_solver(cls, nv, budget, sv, tag=f'ref-{sv}')
        out[sv] = {'verdict': v, 'wall_s': wall, 'cpu_s': cpu}
    return out, len(cls), nv


def cmd_controls():
    """the spec's controls, each with the outcome that would make it fail named"""
    import fs73_lattice as FL
    import fs73_table as TB
    import fs73_screen as SC
    import fs73_q167 as Q7
    path = OUT / 'controls.jsonl'
    have = {r['control'] for r in load_jsonl(path)}
    TB.COLDIR = str(OUT / 'colourings')
    TB.SCRATCH = str(SCR)
    # 1. de Grey's lattice over K by the same quotient code: SAT at N = 8, UNSAT at 5 and 7 (row 78: F = P = 8 Lambda)
    if 'degrey-quotients' not in have:
        lat = FL.degrey()
        lat.saturate('trace')
        rows = TB.Rows(str(OUT / 'controls-quotients.jsonl'))
        got = {}
        for N in (5, 7, 8):
            Qt = SC.Quot(SC.NW(N, lat.rank), lat.rank)
            rec, col = TB.ask_k(rows, f'K|degrey|k4|N{N}|plain', Qt, lat.U, 4, 'plain', None, 'K|degrey')
            got[N] = rec['verdict']
        ok = got == {5: 'UNSAT', 7: 'UNSAT', 8: 'SAT'}
        append(path, {'control': 'degrey-quotients', 'units': len(lat.U), 'verdicts': got, 'pass': ok,
                      'fails_if': 'N = 8 not SAT, or N = 5 or 7 not UNSAT'})
        print(f'control degrey-quotients: {got} -> {"PASS" if ok else "FAIL"}', flush=True)
    # 2. L3e1c94c6 must be coloured by the residue screen at (23, 11), at 3 colours (with a gap) and at 4
    if 'L3e1c94c6-residue' not in have:
        M, S, B, coords, cov = Q7.lattice(Q7.KEY)
        Ub = sorted({reduce_vec(u, M, 23, 11) for u in S})
        r3 = residue_ask(23, Ub, 3, True, budget=60)
        r4 = residue_ask(23, Ub, 4, False, budget=60)
        ok = r3['verdict'] == 'SAT' and r4['verdict'] == 'SAT'
        append(path, {'control': 'L3e1c94c6-residue', 'image': len(Ub), 'k3_gap': r3['verdict'], 'k3_by': r3['by'],
                      'k4': r4['verdict'], 'pass': ok, 'fails_if': 'either ask is not SAT'})
        print(f'control L3e1c94c6-residue: image {len(Ub)}, k=3 gapped {r3["verdict"]}, k=4 {r4["verdict"]} -> '
              f'{"PASS" if ok else "FAIL"}', flush=True)
    # 3. the plant: a NON-square s at 23 must send some unit vector off the circle (phase P2b's defect 2: 12 is the other root)
    if 'wrong-root-plant' not in have:
        U = units_M(420)
        roots = [t for t in range(23) if t * t % 23 == D % 23]
        ns = next(t for t in range(23) if all((t - x * x) % 23 for x in range(23)))
        circ = set(circle(23))
        off = sum(1 for u in U if reduce_vec(u, 420, 23, ns) not in circ)
        on_true = all(reduce_vec(u, 420, 23, t) in circ for u in U for t in roots)
        ok = off > 0 and on_true
        append(path, {'control': 'wrong-root-plant', 'roots': roots, 'planted_nonsquare': ns, 'units_off_circle_under_plant': off,
                      'all_on_circle_under_true_roots': on_true, 'pass': ok,
                      'fails_if': 'the planted non-square sends every unit vector onto the circle'})
        print(f'control wrong-root-plant: s = {ns} (non-square) sends {off}/{len(U)} units off the circle; true roots {roots} '
              f'keep all on: {on_true} -> {"PASS" if ok else "FAIL"}', flush=True)
    # 4. the price formula against G65's de Grey number, and the measured mean degree of de Grey's ball at R = 1.5
    if 'price-formula' not in have:
        lat = FL.degrey()
        lat.saturate('trace')
        g = len(lat.U)
        pred = g * phi_R(1.5) ** 2
        pts = SC.minkowski_ball(lat, 1.5)
        idx, E = SC.ball_graph(pts, [tuple(u) for u in lat.U])
        meas = 2 * len(E) / len(pts)
        ok = abs(pred - 18.4) / 18.4 < 0.02
        append(path, {'control': 'price-formula', 'units': g, 'predicted_degree_R1.5': round(pred, 3), 'G65_value': 18.4,
                      'ball_points': len(pts), 'measured_mean_degree': round(meas, 3), 'pass': ok,
                      'fails_if': 'the formula differs from 18.4 by 2 % or more'})
        print(f'control price-formula: g = {g}, g phi(1.5)^2 = {pred:.3f} vs 18.4; ball {len(pts)} points, measured mean degree '
              f'{meas:.3f} -> {"PASS" if ok else "FAIL"}', flush=True)
    print('DONE controls', flush=True)


def cmd_refusal_controls(budget):
    """the refusing controls through P0.5's encoder: FS-73's 2,044-point certificate graph (ball + the edge {0, v}) and Heule-510,
    both must be UNSAT at four colours under both solvers"""
    path = OUT / 'controls.jsonl'
    have = {r['control'] for r in load_jsonl(path)}
    graphs = []
    w = json.load(open(ROOT / 'data' / 'fs73' / 'census' / 'cert' / 't-16_8_8_0-R1.5' / 'witness.json'))
    graphs.append(('fs73-2044-plus-pair', len(w['points']), [tuple(e) for e in w['unit_edges']] + [tuple(sorted(w['pair']))]))
    h = json.load(open(ROOT / 'tools' / 'heule510.json'))
    graphs.append(('heule510', len(h['names']), [tuple(e) for e in h['edges']]))
    for name, n, E in graphs:
        if f'refusal-{name}' in have:
            continue
        E = sorted({tuple(sorted(e)) for e in E})
        out, ncl, nv = refusal_ask(n, E, 4, budget)
        ok = all(v['verdict'] == 'UNSAT' for v in out.values())
        append(path, {'control': f'refusal-{name}', 'vertices': n, 'edges': len(E), 'clauses': ncl, 'vars': nv, 'solvers': out,
                      'pass': ok, 'fails_if': 'either solver does not return UNSAT'})
        print(f'control refusal-{name}: {n} vertices, {len(E)} edges: {out} -> {"PASS" if ok else "FAIL"}', flush=True)
    print('DONE refusal controls', flush=True)


def cmd_price():
    """P0.4 (arithmetic only): each survivor's G65 ball radius and point count at degree 14, 18, 22, 26; the cheapest named"""
    sw = {r['M']: r for r in load_jsonl(OUT / 'sweep.jsonl')}
    ver = {}
    for r in load_jsonl(OUT / 'verdicts.jsonl'):
        ver[r['lattice']] = r
    surv = [v for v in ver.values() if v['verdict'] == 'SURVIVOR']
    rows = []
    for v in surv:
        M = v['M']
        rec = sw.get(M) or {}
        rows.append({'lattice': v['lattice'], 'M': M, 'units': v['units'], 'covolume': rec.get('covolume'),
                     **{f'price{d}': rec.get(f'price{d}') for d in (14, 18, 22, 26)}})
    rows.sort(key=lambda r: ((r.get('price18') or {}).get('points') or 10 ** 30))
    rec = {'what': 'price', 'survivors': rows, 'cheapest': rows[0]['lattice'] if rows else None, 'machine': MACHINE}
    append(OUT / 'price.jsonl', rec)
    for r in rows:
        print(r, flush=True)
    print(f'DONE price: {len(rows)} survivors; cheapest at degree 18: {rec["cheapest"]}', flush=True)


def cmd_recheck(budget):
    """re-ask every UNKNOWN residue-cache entry at a longer budget (kissat, then cadical), append the new verdicts (the cache keeps the
    last record per key), and remove from sweep.jsonl the records dropped as 'undecided', so a rerun of the sweep re-evaluates them"""
    global _cache
    rs = load_jsonl(CACHE)
    last = {}
    for r in rs:
        last[(r['q'], tuple(r['orbit']), r['k'], r['gap'])] = r
    unk = [r for r in last.values() if r['verdict'] == 'UNKNOWN']
    print(f'fs79_p0 recheck: {len(unk)} undecided residue sets, budget {budget} s', flush=True)
    for r in unk:
        rr = None
        for sv in ('kissat',):
            rr = residue_ask(r['q'], points_of(tuple(r['orbit']), r['q']), r['k'], r['gap'], budget=budget, spectral=False, solver=sv)
            if rr['verdict'] != 'UNKNOWN':
                break
        rec = {'q': r['q'], 'orbit': r['orbit'], 'k': r['k'], 'gap': r['gap'], 'verdict': rr['verdict'], 'by': rr['by'],
               'cpu_s': rr.get('cpu_s'), 'how': 'direct ask (recheck)'}
        append(CACHE, rec)
        print(f'  q {r["q"]} {r["orbit"]}: {rr["verdict"]} ({rr["by"][:60]})', flush=True)
    _cache = None
    sw = load_jsonl(OUT / 'sweep.jsonl')
    keep = [r for r in sw if not any(d.startswith('undecided') for d in r.get('drop', []))]
    if len(keep) < len(sw):
        tmp = OUT / 'sweep.jsonl.tmp'
        with open(tmp, 'w') as f:
            for r in keep:
                f.write(json.dumps(r, sort_keys=True) + '\n')
            f.flush()
            os.fsync(f.fileno())
        os.replace(tmp, OUT / 'sweep.jsonl')
    print(f'DONE recheck: {len(sw) - len(keep)} sweep records removed for re-evaluation', flush=True)


def auto_ids(which='all'):
    """'all': every distinct candidate lattice (and every lattice left undecided by the residue sets), cheapest first;
    'survivors': the lattices whose latest verdict is SURVIVOR"""
    if which == 'survivors':
        last = {}
        for r in load_jsonl(OUT / 'verdicts.jsonl'):
            last[r['lattice']] = r
        return [l for l, r in last.items() if r['verdict'] == 'SURVIVOR']
    sw = [r for r in load_jsonl(OUT / 'sweep.jsonl')
          if r.get('candidate') or any(d.startswith('undecided') for d in r.get('drop', []))]
    sw.sort(key=lambda r: ((r.get('price18') or {}).get('points') or 10 ** 30))
    return [('L21cc6506' if r['M'] == 420 else str(r['M'])) for r in sw]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('cmd')
    ap.add_argument('--q', type=int, default=23)
    ap.add_argument('--k', type=int, default=4)
    ap.add_argument('--maxsize', type=int, default=None)
    ap.add_argument('--budget', type=float, default=120.0)
    ap.add_argument('--mmin', type=int, default=1)
    ap.add_argument('--mmax', type=int, default=2520)
    ap.add_argument('--mlist', default=None)
    ap.add_argument('--ids', default=None)
    ap.add_argument('--norep', action='store_true')
    ap.add_argument('--quot_total', type=float, default=900.0)
    ap.add_argument('--theta_cap', type=float, default=300.0)
    ap.add_argument('--noquot', action='store_true')
    a = ap.parse_args()
    if a.cmd == 'classify':
        cmd_classify(a.q, a.k, a.maxsize, replicate=not a.norep, budget=a.budget)
    elif a.cmd == 'price':
        cmd_price()
    elif a.cmd == 'controls':
        cmd_controls()
    elif a.cmd == 'refusal-controls':
        cmd_refusal_controls(a.budget)
    elif a.cmd == 'additive':
        cmd_additive(a.mmax)
    elif a.cmd == 'screen':
        ids = auto_ids(a.ids) if a.ids in ('all', 'survivors') else a.ids.split(',')
        cmd_screen(ids, qbudget=a.budget, quot_total=a.quot_total, theta_cap=a.theta_cap, quotients=not a.noquot)
    elif a.cmd == 'recheck':
        cmd_recheck(a.budget)
    elif a.cmd == 'sweep':
        ml = [int(t) for t in a.mlist.split(',')] if a.mlist else list(range(a.mmin, a.mmax + 1))
        cmd_sweep(ml)
    else:
        print(f'unknown command {a.cmd}')
        sys.exit(2)


if __name__ == '__main__':
    main()
