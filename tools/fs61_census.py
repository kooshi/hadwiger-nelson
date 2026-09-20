#!/usr/bin/env python3
"""fs61_census -- FS-61: the census of real quadratic fields Q(sqrt d), d = 11 (mod 12): which planes need four colours.

UNTRUSTED (tools/).  A thin layer over the FROZEN FS-58 instrument (tools/fs58_search.py, fs58_local.py, fs58_chain.py): this file
imports and calls them and never edits them.  Every edge and membership is exact integer arithmetic; floats only choose which lattice
points a ball holds (any choice is a legitimate graph) and predict sizes.  Solver verdicts are the solver's claims; SAT models are
verified edge by edge before they are recorded; a field is LANDED only when the frozen checker tools/fs58_check_witness.py prints
CERTIFIED.  Plan: plans/FS61-quadratic-census.md (sections 5, 6, 7 are the specification).

THE OBJECTS (plan section 7).  A LATTICE is a finitely generated subgroup L of F^2 = Q(sqrt d)^2, identified by a CANONICAL KEY --
the least denominator M with M*L inside Z^4, and the Hermite normal form of M*L -- so that the many class specs that produce one
lattice produce one key.  Its graph is always the FULL unit-distance graph on it: the generators are EVERY unit vector lying in L,
which is asserted per record (not assumed), because a missed generator is the one error that fails silently toward "colourable".
A lattice's STATE is one axis -- what is known about 3-colouring its graph:
    Colourable (form mod 2) | Colourable (form mod 3) | Colourable (periodic colouring verified)
    Refused (solver claim) | Refused (certified) | Refused (inherited from <key>)
    Open (no certificate among: ...)
Colourability is inherited downward along inclusion, refusal upward.  A BALL of radius R is the set of lattice points within R of the
origin in both real embeddings (a bidisc), with every unit distance among them as an edge; its verdict is one of
    Colourable (colouring verified) | Refused (solver claim) | Unknown (budget) | Over cap (not asked)
A field's LANDING is a certified witness; the route (ball or chain) is provenance, never part of the state.

SUBCOMMANDS (every record is a JSONL line, flushed and fsynced; RESUME = re-run the identical command, finished units are skipped;
an Unknown or Over cap unit is re-asked only when the wall or cap is larger than the one recorded).  Every command prints a headline
first and one summary line of counts last -- silence is never success.  Exit 0 pass, 1 a check failed, 2 usage.
  lattices D [--tier T] [--nmax N] [--reverify]   -> data/fs61/fields/D/lattices.jsonl: the tier's lattices, saturated, canonicalised
  filter   D [--tier T]                           -> data/fs61/fields/D/filter.jsonl: the exact certificates (forms mod 2 and mod 3)
  scan     D [--tier T] [--filter-off] [--key K] [--radius R] [--reverify]
                                                  -> data/fs61/fields/D/balls.jsonl: is the ball of radius R 3-colourable at all?
  status   [D ...]                                -> where each field stands, from the records alone
  selftest [--section S]                          -> the instrument's own checks, each with a planted fault that must fire
  regress  {lattices,refusals,certificates,controls,untouched,all}
                                                  -> the FS-58 regressions and the paired controls (gates 0.1-0.4, 0.6, 0.8)
  frame | atlas | land | table                    -> NOT IMPLEMENTED YET (phases A, C, B); they exit 2 and say so.

WHERE FS-58 WRITES.  fs58_search.outdir(D) is rebound to data/fs61/fields/D/ before any FS-58 command function is called, and the
worker pools use the 'fork' start method so the rebinding is inherited (Python 3.14's default is 'forkserver', which re-imports the
module and would silently write into data/fs58/).  selftest --section outdir checks both halves of that.
"""
import sys, os, json, math, time, hashlib, gzip, argparse, subprocess, itertools
from fractions import Fraction as Fr
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / 'tools'))
import fs58_search as FS                                     # noqa: E402  (frozen)
from fs58_local import units_d                               # noqa: E402  (frozen)

FS61 = ROOT / 'data' / 'fs61'
MACHINE = 'desktop (16 physical cores / 32 threads, 128 GB)'


# ================================================================ tiers (plan decision B, M1.6)
def tiers():
    p = FS61 / 'tiers.json'
    if not p.exists():
        die(f'missing {p} -- the tier definitions are data, not defaults')
    return json.loads(p.read_text())


def tier_def(tid):
    T = tiers()
    tid = str(tid)
    if tid not in T:
        die(f'unknown tier {tid}; known: {sorted(T)}')
    d = T[tid]
    d['_sha256'] = hashlib.sha256(json.dumps(d, sort_keys=True, separators=(',', ':')).encode()).hexdigest()[:16]
    return d


# ================================================================ records
def field_dir(D):
    p = FS61 / 'fields' / str(D)
    p.mkdir(parents=True, exist_ok=True)
    return p


def bind_outdir():
    """Point FS-58's record directory at FS-61's tree.  Called at import of this module AND re-asserted inside every worker."""
    FS.outdir = field_dir


bind_outdir()


def outdir_is_bound():
    p = Path(FS.outdir(11)).resolve()
    return FS61.resolve() in p.parents or p == FS61.resolve()


def load_jsonl(path, keyfield='key'):
    """key -> record, truncating a partial trailing line (FS-58's convention, its code, re-implemented for our key field)."""
    done = {}
    path = Path(path)
    if path.exists():
        raw = path.read_bytes()
        *complete, tail = raw.split(b'\n')
        for ln in complete:
            if ln.strip():
                r = json.loads(ln)
                done[r[keyfield]] = r
        if tail:
            with open(path, 'r+b') as f:
                f.truncate(len(raw) - len(tail))
    return done


def append(path, rec):
    with open(path, 'a') as f:
        f.write(json.dumps(rec, sort_keys=True, separators=(',', ':')) + '\n')
        f.flush()
        os.fsync(f.fileno())


def die(msg, code=2):
    print(f'DEFECT {msg}' if code == 1 else f'usage: {msg}', file=sys.stderr, flush=True)
    sys.exit(code)


def defect(msg):
    print(f'DEFECT {msg}', flush=True)


# ================================================================ exact lattice arithmetic (independent of FS-58's hnf_basis/inverse)
def hnf(rows):
    """The canonical row Hermite normal form of the integer lattice spanned by integer 4-vectors: echelon by leading column,
    positive pivots, every entry above a pivot reduced into [0, pivot).  Two generating sets span the same lattice iff this agrees."""
    work = [list(r) for r in rows if any(r)]
    basis = []
    for col in range(4):
        while len([r for r in work if r[col]]) > 1:
            nz = sorted((r for r in work if r[col]), key=lambda r: abs(r[col]))
            p = nz[0]
            for r in nz[1:]:
                q = r[col] // p[col]
                for j in range(4):
                    r[j] -= q * p[j]
            work = [r for r in work if any(r)]
        k = next((i for i, r in enumerate(work) if r[col]), None)
        if k is None:
            continue
        p = work.pop(k)
        if p[col] < 0:
            p = [-x for x in p]
        basis.append((col, p))
    for i in range(len(basis)):
        ci, pi = basis[i]
        for k in range(i):
            pk = basis[k][1]
            q = pk[ci] // pi[ci]
            if q:
                for j in range(4):
                    pk[j] -= q * pi[j]
    return tuple(tuple(r) for _, r in basis)


def in_lattice(H, v):
    """membership in the lattice with Hermite basis H (pivot columns increasing)"""
    v = list(v)
    for row in H:
        c = next(j for j in range(4) if row[j])
        if v[c] % row[c]:
            return False
        q = v[c] // row[c]
        if q:
            for j in range(4):
                v[j] -= q * row[j]
    return not any(v)


def canonicalise(M, W):
    """(M_can, H): the least denominator of the lattice spanned by {w/M : w in W} and the Hermite form of M_can * Lambda."""
    H0 = hnf(W)
    g = 0
    for r in H0:
        for x in r:
            g = math.gcd(g, x)
    t = math.gcd(M, g) if g else M
    return M // t, hnf([[x // t for x in r] for r in H0])


def key_of(M, H):
    return f'{M}|' + ';'.join(','.join(str(x) for x in r) for r in H)


def short_id(key):
    return 'L' + hashlib.sha256(key.encode()).hexdigest()[:8]


def parse_key(key):
    M, _, rows = key.partition('|')
    return int(M), tuple(tuple(int(x) for x in r.split(',')) for r in rows.split(';'))


def saturation(D, M, H):
    """every unit vector over M lying in the lattice.  Lambda is inside (1/M)Z^4, so these are ALL the unit vectors of Lambda."""
    return sorted(u for u in map(tuple, units_d(M, D)) if in_lattice(H, u))


def sha_vectors(S):
    return hashlib.sha256(json.dumps([list(v) for v in S], separators=(',', ':')).encode()).hexdigest()


# ================================================================ classes and the full spec of a lattice
_CLASS_CACHE = {}


def class_table(D, NMAX):
    if (D, NMAX) not in _CLASS_CACHE:
        _CLASS_CACHE[(D, NMAX)] = FS.classes(D, NMAX)
    return _CLASS_CACHE[(D, NMAX)]


def _spec_sort_key(name, C):
    N = C[name][0]
    rational = name.startswith('q')
    sub = name.split('.')
    return (0 if rational else 1, N, int(sub[1]) if len(sub) > 1 else 0)


def spec_full(D, NMAX, M, S):
    """The one spec naming every class the lattice contains; asserts FS.pool_vectors(spec) reproduces (M, S) exactly."""
    C = class_table(D, NMAX)
    where = {}
    for name, (N, vecs) in C.items():
        if M % N:
            continue
        s = M // N
        for v in vecs:
            where[tuple(x * s for x in v)] = name
    names = []
    for v in S:
        n = where.get(tuple(v))
        if n is None:
            return None, f'generator {list(v)} over {M} lies in no class of classes({D}, {NMAX})'
        if n not in names:
            names.append(n)
    names.sort(key=lambda n: _spec_sort_key(n, C))
    spec = '+'.join(names)
    M2, W2 = FS.pool_vectors(D, C, names)
    if M2 != M or sorted(map(tuple, W2)) != list(S):
        return spec, f'pool_vectors({spec}) = (M {M2}, {len(W2)} vectors) != (M {M}, {len(S)} vectors)'
    return spec, None


# ================================================================ a lattice record
def lattice_record(D, NMAX, M_spec, W, tier, tid, spec_hint=None, girth=True):
    """The census's unit of work.  W may be any generating set; the record is built from the SATURATION of its span, and the
    saturation is asserted (rule 6).  The generator list is NOT stored: it is a function of the key, recomputed in milliseconds
    by saturation(D, *parse_key(key)), so every consumer re-derives the graph from the canonical key rather than from a cache.
    Returns (record, error-or-None)."""
    M, H = canonicalise(M_spec, W)
    key = key_of(M, H)
    S = saturation(D, M, H)
    rec = {'key': key, 'id': short_id(key), 'D': D, 'M': M, 'rank': len(H), 'hnf': [list(r) for r in H],
           'size': len(S), 'size_generators': len(W), 'tier': tid, 'tier_sha256': tier['_sha256'], 'machine': MACHINE,
           'claim_scope': 'exact', 'generators_sha256': sha_vectors(S)}
    if not all(in_lattice(H, w) for w in W):
        return rec, 'the generating set does not lie in its own Hermite form (arithmetic defect)'
    if set(map(tuple, W)) != set(S):
        rec['saturated'] = False
        missing = sorted(set(S) - set(map(tuple, W)))
        rec['saturation_added'] = [list(v) for v in missing]
    else:
        rec['saturated'] = True
    spec, err = spec_full(D, NMAX, M, S)
    rec['spec_full'] = spec
    rec['spec_hint'] = spec_hint
    if err:
        return rec, f'spec_full: {err}'
    C = class_table(D, NMAX)
    rec['class_reps'] = {n: list(max(C[n][1])) for n in spec.split('+')}
    nonrat = [C[n][0] for n in spec.split('+') if not n.startswith('q')]
    rec['rel_height'] = round(min(nonrat) / math.sqrt(D), 6) if nonrat else None
    rec['three_integral'] = M % 3 != 0
    if len(H) < 3:
        rec['covolume'] = None
        rec['state_inputs'] = {'forms_mod2': 0, 'forms_mod3': 0}
        rec['odd_girth'] = {'length': None, 'none_up_to': None, 'status': 'not asked (rank below 3)'}
        return rec, None
    B, coords, cov, mc = FS.reduce_pool(D, M, S)
    f2, f3 = FS.forms_mod(coords, 2), FS.forms_mod(coords, 3)
    rec.update({'covolume': cov, 'max_coord': mc, 'bipartite': bool(f2),
                'state_inputs': {'forms_mod2': len(f2), 'forms_mod3': len(f3),
                                 'form2': f2[0] if f2 else None, 'form3': f3[0] if f3 else None}})
    # Never a bare integer: `length: null` alone is FS-58's O1 trap, where "no odd cycle found below the cap" reads as
    # "no odd cycle".  Every record says which of the three it is.
    if f2:
        og = {'length': None, 'none_up_to': None, 'status': 'bipartite (no odd cycle at any length)'}
    elif girth:
        g = FS.odd_girth(coords, tier['bfs_cap'])
        og = {'length': g.get('length'), 'none_up_to': g.get('none_up_to'), 'status': 'computed',
              'bfs_cap': tier['bfs_cap'], 'explored': g.get('explored'), 'levels': g.get('levels'),
              'closed_walk_edges_in_level': g.get('closed_walk_edges_in_level')}
    else:
        og = {'length': None, 'none_up_to': None, 'status': 'not asked'}
    rec['odd_girth'] = og
    rec['predicted_points_R15'] = predicted_points(cov, 1.5) if len(H) == 4 else None
    q = M * M
    gram = sorted(2 * sum(f * x * y for f, x, y in zip((1, D, 1, D), u, v)) for u in S for v in S)   # integers over M^2
    rec['iso_invariant'] = {'covolume': cov, 'size': len(S), 'gram_denominator': q,
                            'gram_sha256': hashlib.sha256(','.join(map(str, gram)).encode()).hexdigest()[:16],
                            'gram_distinct': len(set(gram))}
    return rec, None


def predicted_points(cov, R):
    """A ball is a bidisc, one disc per real embedding: about pi^2 R^4 / covolume points (plan section 0.1, D-H.3)."""
    return int(round(math.pi ** 2 * R ** 4 / cov)) if cov else None


def tier_combos(D, NMAX):
    """The tier's lattices: the axis plus one or two non-rational classes with lcm <= NMAX (FS-58's cmd_saturate rule)."""
    C = class_table(D, NMAX)
    nr = [n for n in C if not n.startswith('q')]
    combos = [(c,) for c in nr] + [(a, b) for a, b in itertools.combinations(nr, 2) if math.lcm(C[a][0], C[b][0]) <= NMAX]
    return C, [('q1',) + c for c in combos]


def _lattice_worker(args):
    D, NMAX, names, tier, tid, girth = args
    C = class_table(D, NMAX)
    M, W = FS.pool_vectors(D, C, names)
    rec, err = lattice_record(D, NMAX, M, W, tier, tid, spec_hint='+'.join(names), girth=girth)
    return rec, err


def cmd_lattices(D, tid, nmax=None, jobs=16, out=None, reverify=False, quiet=False, girth=True):
    import multiprocessing as mp
    tier = tier_def(tid)
    NMAX = nmax or tier['nmax']
    out = Path(out) if out else field_dir(D) / 'lattices.jsonl'
    # The UNIT OF WORK is a class combination; the RECORD is per distinct lattice, and many combinations give one lattice.
    # Resume therefore reads the spec ledger, not the lattice records -- otherwise every run redoes the 40 % of combinations
    # whose lattice was first recorded under a different spec.
    specs_out = out.with_name(out.stem + '-specs.jsonl')
    C, combos = tier_combos(D, NMAX)
    done = load_jsonl(out)
    done_specs = load_jsonl(specs_out)
    todo = [(D, NMAX, names, tier, tid, girth) for names in combos if '+'.join(names) not in done_specs]
    if not quiet:
        print(f'fs61 lattices d={D} tier={tid} (nmax={NMAX}): {len(combos)} class combinations, '
              f'{len(done_specs)} done ({len(done)} distinct lattices on disk) -> {len(todo)} combinations to build', flush=True)
    errs = []
    if todo:
        t0, seen = time.time(), 0
        with mp.get_context('fork').Pool(jobs) as P:
            for rec, err in P.imap_unordered(_lattice_worker, todo, chunksize=4):
                seen += 1
                if not quiet and (seen % 100 == 0 or seen == len(todo)):
                    print(f'  {seen}/{len(todo)} class combinations, {len(done)} distinct lattices '
                          f'({time.time() - t0:.0f} s)', flush=True)
                if err:
                    errs.append((rec['key'], err))
                    defect(f'lattice d={D} {rec.get("spec_hint")}: {err}')
                    continue
                append(specs_out, {'key': rec['spec_hint'], 'lattice': rec['key'], 'id': rec['id'], 'D': D, 'nmax': NMAX})
                done_specs[rec['spec_hint']] = None
                if rec['key'] in done:
                    prev = done[rec['key']]
                    if prev['generators_sha256'] != rec['generators_sha256']:
                        errs.append((rec['key'], 'two specs, one key, DIFFERENT generators'))
                        defect(f'lattice d={D} {rec["key"]}: two specs give one key but different generators')
                    continue
                done[rec['key']] = rec
                append(out, rec)
    if reverify:
        for key, rec in sorted(done.items()):
            M, H = parse_key(key)
            S = saturation(D, M, H)
            if sha_vectors(S) != rec['generators_sha256']:
                errs.append((key, 'saturation re-check failed'))
                defect(f'lattice d={D} {rec["id"]} {rec.get("spec_full")}: saturation re-check failed '
                       f'({len(S)} unit vectors in the lattice against {rec["size"]} recorded)')
        if not quiet:
            print(f'  reverified saturation of {len(done)} lattices independently of the record', flush=True)
    by_rank = {}
    for r in done.values():
        by_rank[r['rank']] = by_rank.get(r['rank'], 0) + 1
    if not quiet:
        print(f'DONE {len(done)} distinct lattices from {len(done_specs)} specs '
              f'({", ".join(f"rank {k}: {v}" for k, v in sorted(by_rank.items()))}); {len(errs)} defects -> {rel(out)}', flush=True)
    return done, errs


def rel(p):
    try:
        return str(Path(p).resolve().relative_to(ROOT))
    except ValueError:
        return str(p)


# ================================================================ the exact certificates (phase 0: forms mod 2 and mod 3)
OPEN_PHASE0 = 'Open (no certificate among: forms mod 2, 3)'


def barrier_violation(rec):
    """The kernel barrier (CLAUDE.md row 72) as a test on one lattice record: 3-integral implies a linear form mod 3.
    Returns the message to print, or None.  cmd_filter and selftest_barrier both call THIS function, never a copy of it."""
    if rec['three_integral'] != (rec['M'] % 3 != 0):
        return f'the record claims three_integral={rec["three_integral"]} while its own denominator is M={rec["M"]}'
    if rec['three_integral'] and not rec['state_inputs']['forms_mod3']:
        return (f'3-integral (3 does not divide M={rec["M"]}) but no linear form mod 3 -- the kernel barrier '
                f'(CLAUDE.md row 72) says there must be one')
    return None


def cmd_filter(D, tid, quiet=False):
    tier = tier_def(tid)
    lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
    if not lat:
        die(f'no lattices for d={D}: run `fs61_census.py lattices {D} --tier {tid}` first')
    out = field_dir(D) / 'filter.jsonl'
    done = load_jsonl(out)
    if not quiet:
        print(f'fs61 filter d={D} tier={tid}: {len(lat)} lattices, {len(done)} filtered on disk '
              f'-> {len(lat) - len(done)} to certify (exact forms only in phase 0; quotients are phase B)', flush=True)
    counts, errs = {}, []
    for key, r in sorted(lat.items()):
        si = r['state_inputs']
        if key in done:
            counts[done[key]['state']] = counts.get(done[key]['state'], 0) + 1
            continue
        if si['forms_mod2']:
            state, cert = 'Colourable (form mod 2)', {'kind': 'form2', 'form': si['form2']}
        elif si['forms_mod3']:
            state, cert = 'Colourable (form mod 3)', {'kind': 'form3', 'form': si['form3']}
        else:
            state, cert = OPEN_PHASE0, None
        msg = barrier_violation(r)
        if msg:
            errs.append((key, 'barrier: 3-integral but no form mod 3'))
            defect(f'filter d={D} {r["id"]} {r["spec_full"]}: {msg}')
        rec = {'key': key, 'id': r['id'], 'D': D, 'state': state, 'certificate': cert, 'inherited_from': None,
               'quotients_tried': 0, 'tier': tid, 'tier_sha256': tier['_sha256'], 'machine': MACHINE,
               'claim_scope': 'exact' if cert else 'a statement about the search'}
        append(out, rec)
        done[key] = rec
        counts[state] = counts.get(state, 0) + 1
    if not quiet:
        print('DONE ' + ', '.join(f'{v} {k}' for k, v in sorted(counts.items())) + f'; {len(errs)} defects -> {rel(out)}', flush=True)
    return done, errs


# ================================================================ balls
def _ball_worker(args):
    """The ball of radius R about the origin on a saturated lattice: FS-58's piece/piece_edges/CNF verbatim, plus the model."""
    import numpy as np
    from pysat.solvers import Cadical195
    from fs58_chain import walled_solve
    D, key, S, R, cap, wall, tid, tsha, pred = args
    M, H = parse_key(key)
    base = {'key': f'{key}|ball{R}', 'lattice': key, 'id': short_id(key), 'D': D, 'shape': 'ball', 'R': R,
            'tier': tid, 'tier_sha256': tsha, 'machine': MACHINE, 'wall': wall, 'cap': cap, 'predicted_points': pred}
    try:
        if not outdir_is_bound():
            return {**base, 'verdict': 'ERROR', 'error': 'fs58_search.outdir is not bound into data/fs61 in this worker'}, None
        S = [tuple(v) for v in S]
        t0 = time.time()
        B, coords, cov, mc = FS.reduce_pool(D, M, S)
        flat = all(c[3] == 0 for c in coords)
        X, n = FS.piece(D, M, B, (0, 0, 0, 0), 'ball', R, cap, flat=flat)
        if X is None:
            return {**base, 'points': str(n), 'verdict': 'Over cap (not asked)', 'over_cap_by': 'exact', 'claim_scope': 'exact'}, None
        E = FS.piece_edges(X, coords)
        nv = len(X)
        sv = Cadical195()
        sv.append_formula([[3 * v + 1, 3 * v + 2, 3 * v + 3] for v in range(nv)])
        for c in range(3):
            sv.append_formula(np.stack([-(3 * E[:, 0] + c + 1), -(3 * E[:, 1] + c + 1)], axis=1).tolist())
        i0 = FS.index_of(X, (0, 0, 0, 0))
        units = [3 * i0 + 1]                                   # symmetry break: origin colour 0, one neighbour colour 1 (rule 5)
        if len(E):
            j = int(E[E[:, 0] == i0][0, 1]) if (E[:, 0] == i0).any() else int(E[E[:, 1] == i0][0, 0])
            units.append(3 * j + 2)
        r, dt = walled_solve(sv, units, wall)
        rec = {**base, 'points': nv, 'edges': int(len(E)), 'covolume': cov, 'size': len(S),
               'solve_seconds': round(dt, 2), 'seconds': round(time.time() - t0, 2)}
        model = None
        if r is None:
            rec.update({'verdict': 'Unknown (budget)', 'claim_scope': 'nothing'})
        elif r is False:
            rec.update({'verdict': 'Refused (solver claim)', 'claim_scope': 'solver claim'})
        else:
            col = (np.array(sv.get_model()[:3 * nv]).reshape(nv, 3) > 0).argmax(axis=1).astype(np.uint8)
            if len(E) and not bool((col[E[:, 0]] != col[E[:, 1]]).all()):
                sv.delete()
                return {**base, 'verdict': 'ERROR', 'error': 'the solver returned a model that is not proper'}, None
            model = col.tobytes()
            rec.update({'verdict': 'Colourable (colouring verified)', 'claim_scope': 'verified model',
                        'model_sha256': hashlib.sha256(model).hexdigest()})
        sv.delete()
        return rec, model
    except AssertionError as ex:
        return {**base, 'verdict': 'ERROR', 'error': f'assertion: {ex}'}, None


def model_path(D, sha):
    p = field_dir(D) / 'models'
    p.mkdir(parents=True, exist_ok=True)
    return p / f'{sha[:16]}.bin.gz'


def cmd_scan(D, tid, filter_off=False, only_key=None, radii=None, jobs=16, quiet=False, budget=None):
    import multiprocessing as mp
    tier = tier_def(tid)
    lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
    if not lat:
        die(f'no lattices for d={D}: run `fs61_census.py lattices {D} --tier {tid}` first')
    filt = load_jsonl(field_dir(D) / 'filter.jsonl')
    out = field_dir(D) / 'balls.jsonl'
    done = load_jsonl(out)
    radii = radii or tier['radii']
    cap, wall = tier['point_cap'], tier['solve_wall']

    def settled(k):
        r = done.get(k)
        if r is None:
            return False
        if r['verdict'] == 'Unknown (budget)':
            return r.get('wall', 0) >= wall
        if r['verdict'] == 'Over cap (not asked)':
            return r.get('cap', 0) >= cap
        return True

    keys = [only_key] if only_key else sorted(lat)
    if only_key and only_key not in lat:
        m = [k for k in lat if k.startswith(only_key) or lat[k]['id'] == only_key or lat[k].get('spec_full') == only_key]
        if len(m) != 1:
            die(f'--key {only_key!r} matches {len(m)} lattices of d={D}')
        keys = m
    pool = []
    skipped_state = 0
    for key in keys:
        r = lat[key]
        if r['rank'] != 4:
            continue
        if not filter_off and not only_key:
            st = filt.get(key, {}).get('state', '')
            if st.startswith('Colourable'):
                skipped_state += 1
                continue
        pool.append(r)
    pool.sort(key=lambda r: r['predicted_points_R15'] or 1 << 60)
    todo = []
    for r in pool:
        gens = None
        for R in radii:
            k = f'{r["key"]}|ball{R}'
            if settled(k):
                continue
            if gens is None:                                   # re-derived from the canonical key, never read from a cache
                M, H = parse_key(r['key'])
                gens = [list(v) for v in saturation(D, M, H)]
                if sha_vectors([tuple(v) for v in gens]) != r['generators_sha256']:
                    die(f'lattice {r["id"]}: the saturation of its key does not match the recorded generators_sha256', 1)
            todo.append((D, r['key'], gens, R, cap, wall, tid, tier['_sha256'], predicted_points(r['covolume'], R)))
    if not quiet:
        print(f'fs61 scan d={D} tier={tid}{" (filter off)" if filter_off else ""}: {len(pool)} rank-4 lattices to ask '
              f'({skipped_state} closed by a colourability certificate), radii {radii}, cap {cap} points, wall {wall} s '
              f'-> {len(todo)} balls to ask, {len(done)} on disk', flush=True)
    counts, errs = {}, []
    asked = 0
    t0 = time.time()
    prescreen = 0
    work = []
    for a in todo:                                             # predicted-size prescreen: piece() builds a box in memory, and a
        pred = a[8]                                            # lattice of tiny covolume would ask for gigabytes before saying no
        if pred is not None and pred > 1.3 * cap:
            rec = {'key': f'{a[1]}|ball{a[3]}', 'lattice': a[1], 'id': short_id(a[1]), 'D': D, 'shape': 'ball', 'R': a[3],
                   'tier': tid, 'tier_sha256': tier['_sha256'], 'machine': MACHINE, 'wall': wall, 'cap': cap,
                   'predicted_points': pred, 'verdict': 'Over cap (not asked)', 'over_cap_by': 'prediction',
                   'claim_scope': 'float reading'}
            append(out, rec)
            done[rec['key']] = rec
            counts[rec['verdict']] = counts.get(rec['verdict'], 0) + 1
            prescreen += 1
        else:
            work.append(a)
    if work:
        with mp.get_context('fork').Pool(jobs) as P:
            for rec, model in P.imap_unordered(_ball_worker, work):
                asked += 1
                if model is not None:
                    with gzip.open(model_path(D, rec['model_sha256']), 'wb') as f:
                        f.write(model)
                append(out, rec)
                done[rec['key']] = rec
                counts[rec['verdict']] = counts.get(rec['verdict'], 0) + 1
                if rec['verdict'] == 'ERROR':
                    errs.append((rec['key'], rec.get('error')))
                    defect(f'ball d={D} {rec["key"]}: {rec.get("error")}')
                if rec['verdict'] in ('Refused (solver claim)', 'Unknown (budget)') and not quiet:
                    print(f'  {rec["id"]} R={rec["R"]} {rec.get("points")} points {rec.get("edges")} edges '
                          f'-> {rec["verdict"]} [{rec.get("solve_seconds")} s]', flush=True)
                if budget and time.time() - t0 > budget:
                    print(f'  budget {budget} s reached after {asked} balls: stopping (resume = re-run this command)', flush=True)
                    P.terminate()
                    break
    if not quiet:
        print('DONE ' + (', '.join(f'{v} {k}' for k, v in sorted(counts.items())) or 'no balls asked')
              + f'; {prescreen} over cap by prediction; {len(errs)} defects -> {rel(out)}', flush=True)
    return done, errs


def cmd_scan_reverify(D, fraction=0.10, seed=61):
    """Re-read the stored models of a sample of Colourable balls and check every edge again (plan B.2)."""
    import numpy as np, random
    lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
    balls = [r for r in load_jsonl(field_dir(D) / 'balls.jsonl').values() if r['verdict'] == 'Colourable (colouring verified)']
    rnd = random.Random(seed)
    sample = rnd.sample(balls, max(1, int(math.ceil(fraction * len(balls))))) if balls else []
    print(f'fs61 scan --reverify d={D}: {len(balls)} verified colourings on disk -> re-checking {len(sample)}', flush=True)
    bad = []
    for r in sample:
        p = model_path(D, r['model_sha256'])
        if not p.exists():
            bad.append((r['key'], 'model file missing')); defect(f'reverify {r["key"]}: model file {rel(p)} missing'); continue
        with gzip.open(p, 'rb') as f:
            raw = f.read()
        if hashlib.sha256(raw).hexdigest() != r['model_sha256']:
            bad.append((r['key'], 'model sha256 mismatch')); defect(f'reverify {r["key"]}: model sha256 mismatch'); continue
        col = np.frombuffer(raw, dtype=np.uint8)
        M, H = parse_key(r['lattice'])
        S = saturation(r['D'], M, H)
        B, coords, cov, mc = FS.reduce_pool(r['D'], M, S)
        flat = all(c[3] == 0 for c in coords)
        X, n = FS.piece(r['D'], M, B, (0, 0, 0, 0), 'ball', r['R'], r['cap'], flat=flat)
        E = FS.piece_edges(X, coords)
        if len(X) != len(col) or int(len(E)) != r['edges']:
            bad.append((r['key'], 'graph changed')); defect(f'reverify {r["key"]}: graph changed'); continue
        if len(E) and not bool((col[E[:, 0]] != col[E[:, 1]]).all()):
            bad.append((r['key'], 'colouring not proper')); defect(f'reverify {r["key"]}: the stored colouring is not proper')
    print(f'DONE reverify d={D}: {len(sample)} models re-checked on the full exact edge set, {len(bad)} failures', flush=True)
    return bad


# ================================================================ status
def cmd_status(fields):
    if not fields:
        fields = sorted(int(p.name) for p in (FS61 / 'fields').glob('*') if p.name.isdigit())
    if not fields:
        print('fs61 status: no fields on disk yet')
        return []
    print(f'fs61 status: {len(fields)} fields with records under {rel(FS61 / "fields")}', flush=True)
    rows = []
    for D in fields:
        lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
        filt = load_jsonl(field_dir(D) / 'filter.jsonl')
        balls = load_jsonl(field_dir(D) / 'balls.jsonl')
        st, bv = {}, {}
        for r in filt.values():
            st[r['state']] = st.get(r['state'], 0) + 1
        for r in balls.values():
            bv[r['verdict']] = bv.get(r['verdict'], 0) + 1
        wit = (FS61 / f'witness-{D}' / 'certified.out').exists()
        rows.append({'d': D, 'lattices': len(lat), 'states': st, 'balls': bv, 'witness': wit})
        print(f'  d={D:4d}: {len(lat):4d} lattices ({", ".join(f"{v} {k}" for k, v in sorted(st.items())) or "not filtered"}); '
              f'balls {", ".join(f"{v} {k}" for k, v in sorted(bv.items())) or "none asked"}; '
              f'witness {"certified" if wit else "none"}', flush=True)
    print(f'DONE status: {len(fields)} fields', flush=True)
    return rows


# ================================================================ FS-58 regressions (gate 0.1, 0.2, 0.3, 0.8)
FS58_DEPTH = {11: 180, 23: 300, 35: 180, 47: 180, 59: 180, 71: 180, 83: 180, 95: 180,
              107: 180, 131: 180, 143: 180, 167: 420, 179: 180, 191: 180}
FS58_REFUSALS = [(47, 'q1+12+60', 1.5, 8629, 41144), (71, 'q1+q5+60.2+120.2', 1.5, 47597, 227726),
                 (95, 'q1+12+60.2', 1.5, 17169, 82206), (191, 'q1+q5+20+60.1', 1.5, 53177, 325524),
                 (23, 'q1+q5+12.1+60.2', 1.3, 248213, 1220300)]
FS58_WITNESSES = [23, 47, 71, 95, 191]


def regress_dir():
    p = FS61 / 'regress'
    p.mkdir(parents=True, exist_ok=True)
    return p


def _fs58_key_worker(args):
    """The canonical key of one of FS-58's recorded saturated lattices, from its own `saturated` vector list."""
    D, rec = args
    W = [tuple(v) for v in rec['saturated']]
    M, H = canonicalise(rec['M'], W)
    return rec['key'], key_of(M, H), sha_vectors(sorted(set(W)))


def cmd_regress_lattices(jobs=16):
    """Gate 0.1 (canonical keys agree with FS-58's records) and gate 0.6 (saturation, recomputed independently)."""
    import multiprocessing as mp
    out = regress_dir() / 'lattices.jsonl'
    done = load_jsonl(out, keyfield='d')
    print(f'fs61 regress lattices: FS-58\'s 14 fields at FS-58\'s own depth {FS58_DEPTH}; {len(done)} on disk', flush=True)
    bad = []
    for D, NMAX in sorted(FS58_DEPTH.items()):
        if D in done:                                           # load_jsonl keys by the record's own `d`, an int
            continue
        t0 = time.time()
        src = ROOT / 'data' / 'fs58' / f'search-{D}' / 'saturate.jsonl'
        fs58 = {}
        for ln in src.read_text().splitlines():
            if ln.strip():
                r = json.loads(ln)
                fs58[r['key']] = r
        rank4 = {k: r for k, r in fs58.items() if r.get('rank') == 4}
        with mp.get_context('fork').Pool(jobs) as P:
            got = list(P.imap_unordered(_fs58_key_worker, [(D, r) for r in rank4.values()], chunksize=4))
        fs58_keys = {}
        for spec, key, gsha in got:
            fs58_keys.setdefault(key, []).append((spec, gsha))
        tid = f'fs58-regression-N{NMAX}'
        # girth off: this regression compares LATTICES and GENERATOR SETS (gates 0.1 and 0.6); the odd girth is a phase-B
        # analysis column and its 400,000-point BFS costs up to 7 s on a 300-generator lattice for nothing that is compared here.
        lat, errs = cmd_lattices(D, 1, nmax=NMAX, jobs=jobs, out=regress_dir() / f'lattices-{D}.jsonl', quiet=True, girth=False)
        ours_rank4 = {k: r for k, r in lat.items() if r['rank'] == 4}
        only_ours = sorted(set(ours_rank4) - set(fs58_keys))
        only_fs58 = sorted(set(fs58_keys) - set(ours_rank4))
        gen_mismatch = [k for k in set(ours_rank4) & set(fs58_keys)
                        if any(g != ours_rank4[k]['generators_sha256'] for _, g in fs58_keys[k])]
        rec = {'d': D, 'nmax': NMAX, 'tier': tid, 'machine': MACHINE, 'claim_scope': 'exact',
               'fs58_records': len(fs58), 'fs58_records_rank4': len(rank4), 'fs58_distinct_keys': len(fs58_keys),
               'fs61_specs': len(lat), 'fs61_distinct_keys_rank4': len(ours_rank4),
               'keys_only_in_fs61': only_ours, 'keys_only_in_fs58': only_fs58,
               'generator_sha_mismatches': gen_mismatch, 'lattice_build_errors': [list(e) for e in errs],
               'multi_spec_keys': sum(1 for v in fs58_keys.values() if len(v) > 1),
               'seconds': round(time.time() - t0, 1)}
        ok = not (only_ours or only_fs58 or gen_mismatch or errs)
        rec['verdict'] = 'PASS' if ok else 'FAIL'
        if not ok:
            bad.append(D)
            defect(f'regress lattices d={D}: only-fs61 {len(only_ours)}, only-fs58 {len(only_fs58)}, '
                   f'generator mismatches {len(gen_mismatch)}, build errors {len(errs)}')
        append(out, rec)
        done[D] = rec
        print(f'  d={D:4d} nmax={NMAX}: {len(fs58)} FS-58 records ({len(rank4)} rank 4) -> {len(fs58_keys)} distinct lattices; '
              f'FS-61 {len(lat)} specs -> {len(ours_rank4)} rank-4 keys; {rec["multi_spec_keys"]} keys carry more than one spec; '
              f'{rec["verdict"]} [{rec["seconds"]} s]', flush=True)
    fails = [r['d'] for r in done.values() if r['verdict'] != 'PASS']
    print(f'DONE regress lattices: {len(done)} fields, {len(fails)} failures -> {rel(out)}', flush=True)
    return fails


def cmd_regress_refusals(jobs=8):
    """Gate 0.2: FS-58's five refusing balls, re-asked through the census's own scan on its own lattice records."""
    out = regress_dir() / 'refusals.jsonl'
    done = load_jsonl(out)
    print(f'fs61 regress refusals: FS-58\'s five refusing balls re-asked through `scan`; {len(done)} on disk', flush=True)
    bad = []
    for D, spec, R, pts, edg in FS58_REFUSALS:
        k = f'{D}|{spec}|{R}'
        if k in done:
            continue
        C = class_table(D, max(int(n.lstrip('qL').split('.')[0]) for n in spec.split('+')))
        M, W = FS.pool_vectors(D, C, spec.split('+'))
        Mc, H = canonicalise(M, W)
        key = key_of(Mc, H)
        lat, _ = cmd_lattices(D, 1, jobs=jobs, quiet=True)
        if key not in lat:
            defect(f'regress refusals d={D}: FS-58\'s pool {spec} is not a tier-1 lattice of the census')
            bad.append(k)
            continue
        cmd_scan(D, 1, only_key=key, radii=[R], jobs=1, quiet=True)
        rec = load_jsonl(field_dir(D) / 'balls.jsonl')[f'{key}|ball{R}']
        ok = (rec['verdict'] == 'Refused (solver claim)' and rec['points'] == pts and rec['edges'] == edg)
        row = {'key': k, 'D': D, 'fs58_spec': spec, 'lattice_key': key, 'id': short_id(key), 'R': R,
               'fs58_points': pts, 'fs58_edges': edg, 'points': rec['points'], 'edges': rec['edges'],
               'verdict': rec['verdict'], 'solve_seconds': rec.get('solve_seconds'), 'machine': MACHINE,
               'claim_scope': 'solver claim', 'spec_full': lat[key]['spec_full'],
               'saturated_equals_fs58_pool': lat[key]['size'] == len(W), 'result': 'PASS' if ok else 'FAIL'}
        append(out, row)
        done[k] = row
        if not ok:
            bad.append(k)
            defect(f'regress refusals d={D} {spec} R={R}: {rec["verdict"]} with {rec["points"]} points / {rec["edges"]} edges '
                   f'against FS-58\'s {pts} / {edg}')
        print(f'  d={D:4d} {spec:20s} R={R}: {rec["points"]} points, {rec["edges"]} edges -> {rec["verdict"]} '
              f'[{rec.get("solve_seconds")} s] (FS-58: {pts}, {edg}) {row["result"]}', flush=True)
    fails = [r['key'] for r in done.values() if r['result'] != 'PASS']
    print(f'DONE regress refusals: {len(done)} balls, {len(fails)} failures -> {rel(out)}', flush=True)
    return fails


def cmd_regress_certificates():
    """Gate 0.3: the frozen checker still certifies FS-58's witnesses; the exit status is read from the command, never a pipe."""
    out = regress_dir() / 'certificates.jsonl'
    done = load_jsonl(out)
    print(f'fs61 regress certificates: the frozen tools/fs58_check_witness.py on FS-58\'s witnesses; {len(done)} on disk', flush=True)
    bad = []
    for D in FS58_WITNESSES + [11]:
        k = str(D)
        if k in done:
            continue
        w = ROOT / 'data' / 'fs58' / f'witness-{D}' / 'witness.json'
        cmd = ['python3', str(ROOT / 'tools' / 'fs58_check_witness.py'), '--radicand', str(D), str(w)]
        p = subprocess.run(cmd, capture_output=True, text=True)
        line = (p.stdout.strip().splitlines() or [''])[0]
        ok = p.returncode == 0 and line.startswith('CERTIFIED')
        rec = {'key': k, 'D': D, 'command': ' '.join(rel(c) if str(c).startswith(str(ROOT)) else c for c in cmd),
               'exit_status': p.returncode, 'first_line': line, 'machine': MACHINE, 'claim_scope': 'checker',
               'result': 'PASS' if ok else 'FAIL'}
        append(out, rec)
        done[k] = rec
        if not ok:
            bad.append(k)
            defect(f'regress certificates d={D}: exit {p.returncode}, {line}')
        print(f'  d={D:4d}: exit {p.returncode} -- {line[:120]}', flush=True)
    fails = [r['key'] for r in done.values() if r['result'] != 'PASS']
    print(f'DONE regress certificates: {len(done)} witnesses, {len(fails)} failures -> {rel(out)}', flush=True)
    return fails


CONTROL_FIELDS = {7: 3, 19: 3, 31: 3, 43: 3, 2: 2, 5: 2, 13: 2}     # field -> the chromatic number prior art gives it
CONTROL_POSITIVE = 47                                               # the same code path, on a field that MUST refuse


def cmd_regress_controls(tid='1', jobs=16, budget=None, fields=None):
    """Gate 0.4 (decision E): the paired negative controls.  A three-chromatic plane cannot contain a ball that refuses
    three colours and a two-chromatic one cannot contain a non-bipartite lattice, so a refusal or a non-bipartite lattice
    here is an INSTRUMENT DEFECT and one of the plan's five halts.  The pairing is what makes it evidence: the identical
    filter-off command runs on d = 47, where a ball must refuse."""
    out = regress_dir() / 'controls.jsonl'
    done = load_jsonl(out, keyfield='d')
    todo = fields or (sorted(CONTROL_FIELDS) + [CONTROL_POSITIVE])
    print(f'fs61 regress controls: {len(todo)} fields ({", ".join(map(str, todo))}), tier {tid}, filter OFF '
          f'(every rank-4 lattice under the point cap is asked, whatever its certificate); {len(done)} on disk', flush=True)
    bad = []
    for D in todo:
        if D in done:                                           # load_jsonl keys by the record's own `d`, an int
            continue
        t0 = time.time()
        lat, e1 = cmd_lattices(D, tid, jobs=jobs, quiet=True)
        filt, e2 = cmd_filter(D, tid, quiet=True)
        balls, e3 = cmd_scan(D, tid, filter_off=True, jobs=jobs, quiet=True, budget=budget)
        mine = {k: r for k, r in balls.items() if r['D'] == D}
        verdicts = {}
        for r in mine.values():
            verdicts[r['verdict']] = verdicts.get(r['verdict'], 0) + 1
        refused = [r for r in mine.values() if r['verdict'].startswith('Refused')]
        nonbip = [r for r in lat.values() if r['rank'] >= 3 and not r.get('bipartite')]
        expect = CONTROL_FIELDS.get(D)
        problems = []
        if expect is not None:
            for r in refused:
                problems.append(f'lattice {r["id"]} ball R={r["R"]} Refused -- a {expect}-chromatic plane cannot refuse')
                defect(f'control field d={D}: lattice {r["lattice"]} ball R={r["R"]} Refused -- '
                       f'a {expect}-chromatic plane cannot refuse')
            if expect == 2 and nonbip:
                for r in nonbip[:5]:
                    problems.append(f'lattice {r["id"]} ({r["spec_full"]}) is not bipartite -- chi(Q(sqrt{D})^2) = 2')
                    defect(f'control field d={D}: lattice {r["id"]} ({r["spec_full"]}) is not bipartite -- '
                           f'chi(Q(sqrt{D})^2) = 2, so every unit-distance graph over it is')
        else:                                                       # the positive half of the pair
            if not refused:
                problems.append('no ball refused -- the filter-off code path cannot refuse, so the negatives are worthless')
                defect(f'control field d={D}: no ball refused on the SAME filter-off path -- the seven negatives above '
                       f'measure a path that has not been shown able to go red')
        rec = {'d': D, 'key': str(D), 'role': 'negative control' if expect is not None else 'positive control',
               'expected_chi': expect, 'tier': tid, 'machine': MACHINE, 'claim_scope': 'verified model / solver claim',
               'lattices': len(lat), 'lattices_rank4': sum(1 for r in lat.values() if r['rank'] == 4),
               'lattices_bipartite': sum(1 for r in lat.values() if r.get('bipartite')),
               'lattices_non_bipartite': len(nonbip), 'balls': len(mine), 'ball_verdicts': verdicts,
               'refused': [r['key'] for r in refused], 'problems': problems,
               'seconds': round(time.time() - t0, 1), 'result': 'PASS' if not problems else 'FAIL'}
        append(out, rec)
        done[D] = rec
        if problems:
            bad.append(D)
        print(f'  d={D:3d} ({rec["role"]}, chi={expect if expect else "at least 4"}): {rec["lattices"]} lattices '
              f'({rec["lattices_bipartite"]} bipartite), {len(mine)} balls -> '
              f'{", ".join(f"{v} {k}" for k, v in sorted(verdicts.items())) or "none"}; {rec["result"]} [{rec["seconds"]} s]',
              flush=True)
    write_controls_md(done)
    print(f'DONE regress controls: {len(done)} fields, {len(bad)} failures -> {rel(out)}, {rel(FS61 / "controls.md")}',
          flush=True)
    return bad


def write_controls_md(done):
    rows = sorted(done.values(), key=lambda r: (r['role'], r['d']))
    L = ['# FS-61 — the paired controls on the census instrument (gate 0.4)', '',
         '*Produced by `python3 tools/fs61_census.py regress controls`. Source of truth: `data/fs61/regress/controls.jsonl`',
         'and the per-field `data/fs61/fields/<d>/balls.jsonl`. Machine: ' + MACHINE + '.*', '',
         'Seven fields whose plane needs two or three colours (prior art: `[Johnson1987]`, `[Fischer1990]` Thms 8-9) are',
         'scanned with the 3-integrality filter OFF, so every rank-4 lattice under the point cap is asked whatever its',
         'certificate. None of them may contain a ball that refuses three colours, and over the two-chromatic ones no',
         'lattice may be non-bipartite. Beside them, the identical command on `d = 47`, where a ball must refuse: a',
         'control that cannot go red has not been tested by passing.', '',
         '| d | role | chi | lattices (bipartite) | balls asked | verdicts | result |', '|---|---|---|---|---|---|---|']
    for r in rows:
        v = ', '.join(f'{n} {k}' for k, n in sorted(r['ball_verdicts'].items())) or 'none'
        L.append(f'| {r["d"]} | {r["role"]} | {r["expected_chi"] or "at least 4"} | '
                 f'{r["lattices"]} ({r["lattices_bipartite"]}) | {r["balls"]} | {v} | **{r["result"]}** |')
    L += ['', 'Any `FAIL` row is an instrument defect and one of the plan\'s five halts (§5 rule 15): stop and report, '
          'never repair and continue.', '']
    (FS61 / 'controls.md').write_text('\n'.join(L))


def cmd_regress_untouched():
    """Gate 0.8: FS-58's code and records have not moved."""
    p = subprocess.run(['git', 'status', '--porcelain', 'data/fs58'] + sorted(str(q.relative_to(ROOT)) for q in
                       (ROOT / 'tools').glob('fs58_*')), cwd=ROOT, capture_output=True, text=True)
    dirty = [ln for ln in p.stdout.splitlines() if ln.strip()]
    rec = {'key': 'untouched', 'command': 'git status --porcelain data/fs58 tools/fs58_*', 'exit_status': p.returncode,
           'dirty': dirty, 'machine': MACHINE, 'claim_scope': 'exact', 'result': 'PASS' if not dirty else 'FAIL'}
    append(regress_dir() / 'untouched.jsonl', rec)
    for ln in dirty:
        defect(f'FS-58 is not untouched: {ln}')
    print(f'fs61 regress untouched: `git status --porcelain data/fs58 tools/fs58_*` -> {len(dirty)} modified paths', flush=True)
    print(f'DONE regress untouched: {rec["result"]} -> {rel(regress_dir() / "untouched.jsonl")}', flush=True)
    return dirty


# ================================================================ selftest
def _outdir_probe(_):
    return str(Path(FS.outdir(11)).resolve()), outdir_is_bound()


def _unimodular(rnd, n=4):
    U = [[1 if i == j else 0 for j in range(n)] for i in range(n)]
    for _ in range(12):
        i, j = rnd.sample(range(n), 2)
        q = rnd.choice([-2, -1, 1, 2])
        for c in range(n):
            U[i][c] += q * U[j][c]
    return U


def selftest_keys(rnd):
    """Gate 0.5: one lattice, many specs -> one key; a different lattice -> a different key; any basis -> the same key."""
    rows = []
    D, NMAX = 119, 180
    C = class_table(D, NMAX)
    a = FS.pool_vectors(D, C, ['q1', '60.1'])
    b = FS.pool_vectors(D, C, ['q1', '12', '60.1'])
    ka = key_of(*canonicalise(*a))
    kb = key_of(*canonicalise(*b))
    rows.append(('two specs of one lattice (119: q1+60.1, q1+12+60.1) -> one key', ka == kb, f'{short_id(ka)} vs {short_id(kb)}'))
    c = FS.pool_vectors(D, C, ['q1', '12'])
    kc = key_of(*canonicalise(*c))
    rows.append(('a different lattice (119: q1+12) -> a different key', kc != ka, f'{short_id(kc)} vs {short_id(ka)}'))
    Mb, Hb = canonicalise(*b)
    same = True
    for _ in range(25):
        U = _unimodular(rnd)
        basis = [[sum(U[i][k] * Hb[k][j] for k in range(len(Hb))) for j in range(4)] for i in range(len(Hb))]
        rnd.shuffle(basis)
        basis = [[-x for x in r] if rnd.random() < 0.5 else r for r in basis]
        same &= key_of(*canonicalise(Mb, basis)) == kb
    rows.append(('25 permuted, sign-flipped, unimodularly transformed bases -> the same key', same, 'all 25' if same else 'FAILED'))
    # the plant: a NON-saturated generating set.  Two sub-cases, and they behave differently -- see the phase record.
    S = saturation(D, Mb, Hb)
    rec_ok, err_ok = lattice_record(D, NMAX, Mb, S, tier_def(1), 1)
    rec_raw, err_raw = lattice_record(D, NMAX, a[0], a[1], tier_def(1), 1)          # q1+60.1's own 12 vectors: same lattice
    rows.append(('PLANT a: a non-saturated generating set spanning the same lattice is flagged `not saturated`',
                 rec_raw['saturated'] is False and rec_ok['saturated'] is True,
                 f'raw {len(a[1])} generators flagged saturated={rec_raw["saturated"]}, '
                 f'saturation added {len(rec_raw.get("saturation_added", []))} vectors'))
    rows.append(('PLANT a, second half: its KEY does NOT differ -- only the assertion catches it (finding, plan 0.5)',
                 key_of(*canonicalise(a[0], a[1])) == kb, 'same key, as the lattice is the same'))
    # Derived, not tested: dropping ONE generator can never change the lattice, because the generator set is closed under
    # negation (FS-58's orbit()), so -v remains and Zv is still spanned.  The key is a function of the lattice alone, so no
    # key test can detect an unsaturated generator set: only lattice_record's explicit assertion can (gate 0.6).
    drop_never = all(key_of(*canonicalise(Mb, [v for v in S if v != w])) == kb for w in S)
    rows.append(('derived, and confirmed on all 28 single-generator deletions: dropping one generator leaves the key unchanged',
                 drop_never, 'the generator set is closed under negation, so the span cannot move'))
    pert = [list(r) for r in Hb]
    piv = next(j for j in range(4) if pert[-1][j])
    pert[-1][piv] *= 2                                           # a genuinely different (index-2) lattice
    Mp, Hp = canonicalise(Mb, pert)
    kp = key_of(Mp, Hp)
    witness = next((v for v in S if in_lattice(Hb, v) and not in_lattice(Hp, v)), None)
    rows.append(('PLANT b: a genuinely different lattice (one Hermite pivot doubled) gets a different key, and the difference '
                 'is exhibited', kp != kb and witness is not None,
                 f'{short_id(kp)} vs {short_id(kb)}; {list(witness) if witness else "no separating vector"} is in one, not the other'))
    return rows


def selftest_saturation(rnd):
    """Gate 0.6's plant: a record whose generator set is missing a unit vector of the lattice is caught by name."""
    rows = []
    D, NMAX = 119, 180
    C = class_table(D, NMAX)
    M, W = FS.pool_vectors(D, C, ['q1', '12', '60.1'])
    Mc, H = canonicalise(M, W)
    S = saturation(D, Mc, H)
    rows.append(('the saturation of 119 q1+12+60.1 is its own generating set', set(S) == set(map(tuple, W)),
                 f'{len(S)} unit vectors of the lattice, {len(W)} generators'))
    victim = S[len(S) // 2]
    short = [v for v in S if v != victim]
    rec, err = lattice_record(D, NMAX, Mc, short, tier_def(1), 1)
    caught = rec['saturated'] is False and [list(victim)] == rec.get('saturation_added')
    rows.append(('PLANT: one generator removed is caught and NAMED', caught,
                 f'flagged saturated={rec["saturated"]}, named {rec.get("saturation_added")}'))
    # and the control that the plant fires for the named reason: the same vector really is a unit vector of the lattice
    rows.append(('the named vector is a unit vector of the lattice (the plant fired for its reason)',
                 in_lattice(H, victim) and sum(f * x * x for f, x in zip((1, D, 1, D), victim)) == Mc * Mc,
                 f'{list(victim)} over {Mc}'))
    return rows


NAIVE_PROBE = '''import sys, multiprocessing as mp
from pathlib import Path
ROOT = Path({root!r})
sys.path.insert(0, str(ROOT / 'tools'))
import fs58_search as FS
def probe(_):
    import fs58_search as F
    return str(F.outdir(11))
if __name__ == '__main__':
    FS.outdir = lambda D: ROOT / 'data' / 'fs61' / 'fields' / str(D)   # patched in __main__ AFTER the import
    for m in ('fork', 'forkserver', 'spawn'):
        with mp.get_context(m).Pool(1) as P:
            print(m, P.map(probe, [0])[0])
'''


def selftest_outdir(rnd):
    """The rebinding of FS-58's record directory: the guard that protects it, and the shape of the patch that loses it.

    Measured 2026-09-19: a monkeypatch applied in __main__ after the import is inherited under `fork` and LOST under
    `forkserver` (Python 3.14's default) and `spawn` -- the trap the plan names.  This tool is immune to it by construction,
    because bind_outdir() runs at fs61_census's module import, so any start method that imports this module gets it; the
    guard that catches what remains (a worker function living in fs58_search) is outdir_is_bound() inside _ball_worker."""
    import multiprocessing as mp, tempfile
    rows = [('in this process, fs58_search.outdir(11) is under data/fs61', outdir_is_bound(), rel(FS.outdir(11)))]
    for m in ('fork', 'forkserver', 'spawn'):
        with mp.get_context(m).Pool(1) as P:
            got = P.map(_outdir_probe, [0])
        rows.append((f'a `{m}` worker sees the rebinding (this module binds at import, so every start method does)',
                     got[0][1], rel(got[0][0])))
    with tempfile.NamedTemporaryFile('w', suffix='.py', delete=False) as f:
        f.write(NAIVE_PROBE.format(root=str(ROOT)))
        probe_path = f.name
    p = subprocess.run(['python3', probe_path], capture_output=True, text=True)
    os.unlink(probe_path)
    seen = dict(ln.split(None, 1) for ln in p.stdout.strip().splitlines()) if p.returncode == 0 else {}
    lost = [m for m in ('forkserver', 'spawn') if 'data/fs58' in seen.get(m, '')]
    rows.append(('PLANT: the same rebinding applied AFTER the import (the naive shape) is LOST under forkserver and spawn, '
                 'and those workers would write into data/fs58/', lost == ['forkserver', 'spawn'],
                 '; '.join(f'{m} -> {rel(v.strip())}' for m, v in seen.items()) or f'probe failed: {p.stderr[-200:]}'))
    orig = FS.outdir
    try:
        FS.outdir = FS.__dict__.get('_orig_outdir') or (lambda D: ROOT / 'data' / 'fs58' / f'search-{D}')
        unbound = not outdir_is_bound()
        C = class_table(119, 180)
        M, W = FS.pool_vectors(119, C, ['q1', '12', '60.1'])
        Mc, H = canonicalise(M, W)
        S = saturation(119, Mc, H)
        rec_bad, _ = _ball_worker((119, key_of(Mc, H), [list(v) for v in S], 1.0, 600000, 30, 1, 'x', 2745))
    finally:
        FS.outdir = orig
    rec_ok, _ = _ball_worker((119, key_of(Mc, H), [list(v) for v in S], 1.0, 600000, 30, 1, 'x', 2745))
    rows.append(('PLANT: with the binding removed, the ball worker refuses and names the reason (the guard, two-sided)',
                 unbound and rec_bad['verdict'] == 'ERROR' and rec_ok['verdict'].startswith('Colourable'),
                 f'unbound -> {rec_bad.get("error")}; rebound -> {rec_ok["verdict"]}'))
    return rows


def selftest_barrier(rnd):
    """The kernel barrier (CLAUDE.md row 72) as the instrument sees it, with a plant through the SHIPPED test function."""
    rows = []
    D, NMAX = 119, 180
    C = class_table(D, NMAX)
    recs = []
    for names in (['q1', '20'], ['q1', '12', '60.1'], ['q1', '80.2'], ['q1', '12'], ['q1', '16']):
        M, W = FS.pool_vectors(D, C, names)
        Mc, H = canonicalise(M, W)
        rec, err = lattice_record(D, NMAX, Mc, saturation(D, Mc, H), tier_def(1), 1)
        recs.append(rec)
    n3 = sum(1 for r in recs if r['three_integral'])
    bad = [r for r in recs if barrier_violation(r)]
    rows.append(('every 3-integral lattice among five over 119 has a linear form mod 3 (barrier_violation, the shipped test)',
                 not bad, f'{n3} of {len(recs)} are 3-integral, {len(bad)} violate the barrier'))
    # one plant per clause of the shipped test, each fired for ITS OWN reason (a red for the wrong reason is not evidence)
    v1 = next(r for r in recs if r['three_integral'] and r['state_inputs']['forms_mod3'])
    p1 = dict(v1, state_inputs=dict(v1['state_inputs'], forms_mod3=0, form3=None))
    m1 = barrier_violation(p1)
    rows.append(('PLANT 1 (the barrier clause): a genuinely 3-integral lattice with its forms mod 3 removed is reported',
                 bool(m1) and 'no linear form mod 3' in (m1 or '') and barrier_violation(v1) is None,
                 f'{v1["spec_full"]} (M={v1["M"]}): {m1}'))
    v2 = next(r for r in recs if not r['three_integral'])
    m2 = barrier_violation(dict(v2, three_integral=True))
    rows.append(('PLANT 2 (the consistency clause): a record whose three_integral flag disagrees with its own M is reported',
                 bool(m2) and 'disagree' not in (m2 or '') and 'while its own denominator' in (m2 or ''),
                 f'{v2["spec_full"]}: {m2}'))
    return rows


FS58_BALL_SIZES = [(47, 'q1+12+60', 1.5, 8629), (119, 'q1+12+60.1', 1.5, 13605), (95, 'q1+12+60.2', 1.5, 17169),
                   (71, 'q1+q5+60.2+120.2', 1.5, 47597), (191, 'q1+q5+20+60.1', 1.5, 53177),
                   (23, 'q1+q5+12.1+60.2', 1.5, 440077), (143, 'q1+q5+12+60', 1.5, 283485)]


def selftest_predicted(rnd):
    """The bidisc point law against FS-58's own recorded balls (the input to gate A.8, checked here because it is free)."""
    rows = []
    def worst_error(scale):
        worst, detail = 0.0, ''
        for D, spec, R, pts in FS58_BALL_SIZES:
            C = class_table(D, max(int(n.lstrip('qL').split('.')[0]) for n in spec.split('+')))
            M, W = FS.pool_vectors(D, C, spec.split('+'))
            B, coords, cov, mc = FS.reduce_pool(D, M, W)
            err = abs(predicted_points(cov * scale, R) - pts) / pts
            if err > worst:
                worst, detail = err, f'd={D} {spec} R={R}: predicted {predicted_points(cov * scale, R)}, actual {pts}'
        return worst, detail
    w, detail = worst_error(1.0)
    rows.append((f'pi^2 R^4 / covolume predicts every one of {len(FS58_BALL_SIZES)} recorded balls within 15 %',
                 w < 0.15, f'worst {w:.2%} ({detail})'))
    wp, dp = worst_error(2.0)
    rows.append(('PLANT: the same test with every covolume doubled fails the 15 % bound',
                 wp >= 0.15, f'worst {wp:.2%} ({dp})'))
    return rows


def brute_D(N, orthogonal=True):
    """D(N) by brute force over the defining equations themselves -- no units_d, no inverted parametrisation.
    A unit vector over N needs a^2 + c^2 + d(b^2 + e^2) = N^2, so d(b^2 + e^2) <= N^2 and d <= N^2."""
    out = set()
    for d in range(2, N * N + 1):
        if not squarefree(d):
            continue
        hit = False
        bm = math.isqrt(N * N // d)
        for b in range(-bm, bm + 1):
            for e in range(-bm, bm + 1):
                if b == 0 and e == 0:
                    continue
                r = N * N - d * (b * b + e * e)
                if r < 0:
                    continue
                for a in range(-N, N + 1):
                    c2 = r - a * a
                    if c2 < 0:
                        continue
                    c = math.isqrt(c2)
                    if c * c != c2:
                        continue
                    for cc in (c, -c):
                        if orthogonal and a * b + cc * e != 0:
                            continue
                        if FS.least_den((a, b, cc, e), N) == N:
                            hit = True
        if hit:
            out.add(d)
    return sorted(out)


def selftest_atlas(rnd):
    """A.2's plant: the orthogonality condition ab + ce = 0 is load-bearing, and D(12) changes without it."""
    rows = []
    good = brute_D(12, orthogonal=True)
    rows.append(('D(12) by brute force over the defining equations (no units_d, no inversion) is the plan\'s set',
                 good == [23, 47, 71, 95, 119, 143], f'{good}'))
    plant = brute_D(12, orthogonal=False)
    rows.append(('PLANT: dropping ab + ce = 0 changes D(12), and the change is exhibited',
                 plant != good and set(good) <= set(plant),
                 f'{len(plant)} fields instead of {len(good)}; the intruders are {sorted(set(plant) - set(good))}'))
    inv = sorted(d for d in atlas_scan_N(12, 200_000, dmin=2) if squarefree(d))
    rows.append(('the inverted enumeration agrees with the brute force on D(12)', inv == good, f'{inv}'))
    return rows


SECTIONS = {'keys': selftest_keys, 'saturation': selftest_saturation, 'outdir': selftest_outdir,
            'barrier': selftest_barrier, 'predicted': selftest_predicted, 'atlas': selftest_atlas}


def cmd_selftest(section=None):
    import random
    rnd = random.Random(61)
    names = [section] if section else list(SECTIONS)
    if section and section not in SECTIONS:
        die(f'unknown selftest section {section!r}; known: {list(SECTIONS)}')
    print(f'fs61 selftest: {len(names)} sections ({", ".join(names)})', flush=True)
    bad = []
    for n in names:
        print(f'  [{n}]', flush=True)
        for what, ok, detail in SECTIONS[n](rnd):
            print(f'    {"PASS" if ok else "FAIL"}  {what}  --  {detail}', flush=True)
            if not ok:
                bad.append((n, what))
    print(f'DONE selftest: {len(names)} sections, {len(bad)} failures', flush=True)
    return bad


# ================================================================ not yet implemented
# ================================================================ A.1 the frame: L(Q(sqrt d)) for every squarefree d < 2000
#
# The arithmetic, in one place (plan section 1, CLAUDE.md G56).  Identify F^2 with K = F(i); a unit vector is a norm-one
# element of K.  A prime p of F that does NOT split in K (a STABLE prime) makes every unit vector p-integral, and
# reduction is a graph homomorphism onto a finite graph, so chi(F^2) is at most that graph's chromatic number:
#   * p RAMIFIED in K/F: conjugation is trivial on the residue field, every unit vector reduces to 1, chi(F^2) <= 2;
#   * p INERT in K/F with Q = N(p): the target is Cay(F_{Q^2}, mu_{Q+1}) = UD(F_Q, 2), so the bound is chi(UD(F_Q,2));
#   * p SPLIT: no bound.
# For a real quadratic field the stable primes are exactly: the dyadic prime when d is NOT 7 mod 8 (ramified in K when
# d = 1, 2 mod 4, giving 2; inert with Q = 2 when d = 3 mod 8, giving Cay(F_4, mu_3) = K_4 and the bound 4), and the odd
# p = 3 (mod 4) with (d/p) != -1 (inert, Q = p).  An odd p = 1 (mod 4) always splits, because -1 is a square in its
# residue field; an odd p = 3 (mod 4) with (d/p) = -1 has residue field F_{p^2}, where -1 IS a square, so it splits too.
CHI_TARGET = {2: (4, 4, 'Cay(F_4, mu_3) = K_4'), 3: (3, 3, '[Moorhouse2010] Table 6.1'),
              7: (4, 4, '[Moorhouse2010] Table 6.1'), 11: (5, 5, 'chromaticNumber_finitePlane11 [kernel]'),
              19: (5, 5, 'FS-58 / [Moorhouse2010]'), 23: (6, 8, 'FS-56 cert: five refused, alpha <= 105'),
              31: (5, 8, 'FS-53 window'), 43: (6, 8, 'FS-53 cert: five refused'), 47: (6, 10, 'FS-53 cert: five refused'),
              59: (7, None, 'FS-53 cert: six refused'), 67: (7, None, 'FS-53 cert'), 71: (7, None, 'exact spectrum'),
              79: (7, None, 'FS-53 cert'), 83: (7, None, 'FS-50 cert')}
USABLE_ODD = [p for p in (3, 7, 11, 19, 23, 31, 43, 47, 59, 67, 71, 79, 83, 103, 107, 127, 131, 139, 151, 163, 167,
                          179, 191, 199) if p % 4 == 3]
CHI_ESTABLISHED = {                                    # (lo, hi, source) -- what this project and prior art have pinned
    11: (4, 4, 'lower: four_le_chromaticNumber_planeOver_eleven [kernel, FS-58]; upper: residue plane at 7 [prior art]'),
    23: (4, 4, 'lower: FS-58 witness, frozen checker; upper: residue plane at 7 [prior art]'),
    47: (4, 5, 'lower: FS-58 witness, frozen checker; upper: residue plane at 11 [prior art]'),
    71: (4, 4, 'lower: FS-58 witness, frozen checker; upper: residue plane at 7 [prior art]'),
    95: (4, 4, 'lower: FS-58 witness, frozen checker; upper: residue plane at 7 [prior art]'),
    191: (4, 4, 'lower: FS-58 witness, frozen checker; upper: residue plane at 7 [prior art]'),
}


def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1


def squarefree(n):
    k = 2
    while k * k <= n:
        if n % (k * k) == 0:
            return False
        k += 1
    return True


def stable_primes_congruence(d):
    """Route A: the stable primes of Q(sqrt d) and their bounds, from congruences and Legendre symbols alone."""
    out = []
    if d % 4 != 3:
        out.append({'p': 2, 'Q': 4 if d % 8 == 5 else 2, 'relative': 'ramified', 'bound_lo': 2, 'bound_hi': 2})
    elif d % 8 == 3:
        out.append({'p': 2, 'Q': 2, 'relative': 'inert', 'bound_lo': CHI_TARGET[2][0], 'bound_hi': CHI_TARGET[2][1]})
    for p in USABLE_ODD:
        if legendre(d, p) != -1:
            lo, hi, _ = CHI_TARGET.get(p, (7, None, ''))       # every usable q >= 59 has chi >= 7 (FS-50, FS-53, Weil)
            out.append({'p': p, 'Q': p, 'relative': 'inert', 'bound_lo': lo, 'bound_hi': hi})
    return out


def frame_row(d):
    """L(F) = min over the stable primes of the chromatic number of that prime's target graph.  Several of those
    chromatic numbers are themselves undecided (23, 31, 43, 47 are FS-53's open window), so L is recorded as a BRACKET
    [L_lower, L_upper] and is an exact integer only when the two ends meet.  Writing `L >= 6` where the first usable
    prime is 31 would be wrong: chi(UD(F_31,2)) is open at 5."""
    st = stable_primes_congruence(d)
    los = [s['bound_lo'] for s in st] or [7]
    his = [s['bound_hi'] for s in st if s['bound_hi'] is not None]
    L_lo = min(los)
    L_hi = min(his) if his else None
    L = L_lo if (L_hi is not None and L_hi == L_lo) else None
    Lp = next((s['p'] for s in st if s['bound_lo'] == L_lo and s['bound_hi'] == L_lo), None) if L else None
    if L is not None:
        reason = '2 (dyadic, ramified in K)' if L == 2 else (f'{L} (dyadic)' if Lp == 2 else f'{L} ({Lp})')
    else:
        first = [s['p'] for s in st][:3]
        reason = (f'[{L_lo}, {L_hi if L_hi else "?"}] (undecided; first usable primes '
                  f'{", ".join(map(str, first)) if first else "all above 200"})')
    lo, hi, src = CHI_ESTABLISHED.get(d, (None, None, None))
    return {'key': str(d), 'd': d, 'mod4': d % 4, 'mod3': d % 3, 'mod8': d % 8,
            'family': d % 12 == 11, 'stable_primes': st, 'L': L, 'L_lower': L_lo, 'L_upper': L_hi,
            'L_prime': Lp, 'L_reason': reason, 'chi_known': [lo, hi] if lo else None, 'chi_source': src,
            'claim_scope': 'exact', 'machine': MACHINE}


def pari_frame(ds, primes=(2, 3, 7, 11, 19, 23, 31, 43, 47)):
    """Route B: PARI's own prime decomposition in F and in K = Q(sqrt d, i), independently of every congruence above."""
    lines = ['{', 'for (j = 1, %d,' % len(ds), '  d = [%s][j];' % ','.join(map(str, ds)),
             '  F = nfinit(x^2 - d); K = nfinit(polcompositum(x^2 - d, x^2 + 1)[1]);',
             '  for (k = 1, %d,' % len(primes), '    p = [%s][k];' % ','.join(map(str, primes)),
             '    PF = idealprimedec(F, p); PK = idealprimedec(K, p);',
             '    gF = #PF; gK = #PK; eF = PF[1].e; fF = PF[1].f; eK = PK[1].e; fK = PK[1].f;',
             '    rel = if (gK == gF, if (fK/fF == 2, "inert", "ramified"), "split");',
             '    print(d, " ", p, " ", p^fF, " ", rel);', '  );', ');', '}', 'quit']
    src = Path(os.environ.get('TMPDIR', '/tmp')) / f'fs61-frame-{os.getpid()}.gp'
    src.write_text('\n'.join(lines) + '\n')
    p = subprocess.run(['gp', '-q'], stdin=open(src), capture_output=True, text=True)
    src.unlink()
    if p.returncode != 0:
        die(f'gp failed: {p.stderr[-400:]}', 1)
    out = {}
    for ln in p.stdout.split('\n'):
        f = ln.split()
        if len(f) == 4:
            out.setdefault(int(f[0]), {})[int(f[1])] = (int(f[2]), f[3])
    return out


def cmd_frame(dmax=2000, quiet=False):
    out = FS61 / 'frame.jsonl'
    ds = [d for d in range(2, dmax) if squarefree(d)]
    if not quiet:
        print(f'fs61 frame: {len(ds)} squarefree d in [2, {dmax}); route A congruences + Legendre symbols, '
              f'route B PARI prime decomposition in F and in K = Q(sqrt d, i); they must agree on every row', flush=True)
    pari = pari_frame(ds)
    rows, errs = [], []
    for d in ds:
        r = frame_row(d)
        mism = []
        for s in r['stable_primes']:
            got = pari.get(d, {}).get(s['p'])
            if got is None:
                continue
            if got[0] != s['Q'] or got[1] != s['relative']:
                mism.append(f'p={s["p"]}: congruences say N={s["Q"]} {s["relative"]}, PARI says N={got[0]} {got[1]}')
        known = {s['p'] for s in r['stable_primes']}
        for q, (Qn, relk) in sorted(pari.get(d, {}).items()):        # `rel` is this module's path helper: do not shadow it
            if relk != 'split' and q not in known:
                mism.append(f'p={q}: PARI says {relk} (N={Qn}) and the congruences call it split')
        r['pari'] = {str(p): list(v) for p, v in sorted(pari.get(d, {}).items())}
        r['routes_agree'] = not mism
        if mism:
            errs.append((d, mism))
            defect(f'frame d={d}: ' + '; '.join(mism))
        rows.append(r)
    if out.exists():
        out.unlink()
    for r in rows:
        append(out, r)
    fam = [r['d'] for r in rows if r['family'] and r['d'] < 500]
    by = {}
    for r in rows:
        k = r['L'] if r['L'] is not None else f'[{r["L_lower"]}, {r["L_upper"] or "?"}]'
        by[k] = by.get(k, 0) + 1
    if not quiet:
        print(f'  {len(fam)} fields d = 11 (mod 12) below 500: {fam}', flush=True)
        print(f'  L over all {len(rows)} fields: ' +
              ', '.join(f'{k}: {v}' for k, v in sorted(by.items(), key=lambda kv: str(kv[0]))), flush=True)
        print(f'DONE frame: {len(rows)} fields, {len(errs)} rows where the two routes disagree -> {rel(out)}', flush=True)
    return rows, errs


# ================================================================ A.2 the atlas: the parameter enumerated first (D-H.1)
#
# A unit vector ((a + b sqrt d)/N, (c + e sqrt d)/N) satisfies a^2 + c^2 + d(b^2 + e^2) = N^2 and ab + ce = 0.  FS-58's
# units_d(N, d) fixes d and solves for the vectors; here N is fixed and d is SOLVED FOR, so every field gets a row
# whether or not anything was found at it, and no field can be silently omitted the way a per-field scan at a fixed
# depth can (plan D-H.1).  The inversion is exact, from units_d's own parametrisation: writing g = gcd(b, e) and
# base = (b^2 + e^2)/g^2, a non-rational unit vector is (k(-e)/g, b, kb/g, e) with k^2 * base = N^2 - d(b^2 + e^2),
# so    d = (N^2 - k^2 * base) / (g^2 * base)    for every integer k with k^2 * base < N^2.  Orthogonality is not an
# extra filter here: it holds identically for that shape (ab + ce = k(-e)b/g + k b e/g = 0), which is why the plant
# that drops it has to be built from a brute-force enumeration instead (selftest --section atlas).
def rational_classes(N):
    """the orbits of unit vectors with b = e = 0 and least denominator N (the same for every field)"""
    vecs = set()
    for a in range(-N, N + 1):
        c2 = N * N - a * a
        c = math.isqrt(c2)
        if c * c == c2 and math.gcd(math.gcd(abs(a), c), N) == 1:
            vecs |= {(a, 0, c, 0), (a, 0, -c, 0)}
    return orbits_of(vecs)


def orbits_of(vecs):
    """group a set of vectors into orbits of FS-58's frozen order-16 group"""
    seen, out = set(), []
    for w in sorted(vecs):
        if w in seen:
            continue
        o = FS.orbit(w)
        seen |= o
        out.append(sorted(o))
    return out


def atlas_scan_N(N, dmax, dmin=2, keep=None):
    """d -> the non-rational unit vectors of least denominator exactly N over Q(sqrt d), by solving for d"""
    import numpy as np
    B = math.isqrt(N * N // dmin)
    found = {}
    for b in range(0, B + 1):
        for e in range(-B if b else 0, B + 1):
            if b == 0 and e == 0:
                continue
            g = math.gcd(b, abs(e))
            base = (b * b + e * e) // (g * g)
            den = g * g * base
            if den * dmin > N * N:
                continue
            kmax = math.isqrt((N * N) // base)
            ks = np.arange(0, kmax + 1, dtype=np.int64)
            nums = N * N - ks * ks * base
            ok = (nums > 0) & (nums % den == 0)
            for k, dd in zip(ks[ok].tolist(), (nums[ok] // den).tolist()):
                if dd < dmin or dd >= dmax or (keep and not keep(dd)):
                    continue
                for kk in (k, -k):
                    w = (kk * (-e) // g, b, kk * b // g, e)
                    if FS.least_den(w, N) == N:
                        found.setdefault(dd, set()).add(w)
    return found


def cmd_atlas(nmax=420, dmax=2000, quiet=False):
    out = FS61 / 'atlas.jsonl'
    keep = lambda d: d % 12 == 11 and squarefree(d)
    if not quiet:
        print(f'fs61 atlas: denominators N <= {nmax} enumerated FIRST, then d solved for; keeping squarefree '
              f'd = 11 (mod 12) below {dmax}', flush=True)
    per_d = {}
    rat = {}
    t0 = time.time()
    for N in range(1, nmax + 1):
        rc = rational_classes(N)
        if rc:
            rat[N] = len(rc)
        for d, vecs in atlas_scan_N(N, dmax, dmin=11, keep=keep).items():   # 11 is the smallest family member
            per_d.setdefault(d, {})[N] = len(orbits_of(vecs))
        if not quiet and N % 60 == 0:
            print(f'  N <= {N}: {len(per_d)} fields carry a non-rational class ({time.time() - t0:.0f} s)', flush=True)
    ds = sorted(d for d in range(2, dmax) if keep(d))
    if out.exists():
        out.unlink()
    for d in ds:
        nr = per_d.get(d, {})
        Ns = sorted(set(nr) | set(rat))
        classes = []
        for N in Ns:
            a, b = rat.get(N, 0), nr.get(N, 0)
            classes.append({'N': N, 'orbits': a + b, 'orbits_rational': a, 'orbits_nonrational': b,
                            'v2': (N & -N).bit_length() - 1, 'v3': v_p(N, 3), 'rational': b == 0})
        N1 = min(nr) if nr else None
        N3 = min((N for N in Ns if N % 3 == 0 and (rat.get(N, 0) or nr.get(N, 0))), default=None)
        append(out, {'key': str(d), 'd': d, 'mod8': d % 8, 'nmax': nmax, 'classes': classes, 'N1': N1, 'N3': N3,
                     'n_classes': sum(c['orbits'] for c in classes), 'claim_scope': 'exact', 'machine': MACHINE})
    if not quiet:
        print(f'DONE atlas: {len(ds)} fields, {sum(1 for d in ds if d in per_d)} with a non-rational class at N <= {nmax}; '
              f'{time.time() - t0:.0f} s -> {rel(out)}', flush=True)
    return per_d, rat


def v_p(n, p):
    v = 0
    while n % p == 0:
        n //= p
        v += 1
    return v


def cmd_atlas_check(nmax=180, quiet=False):
    """A.2's cross-check: the inverted enumeration must reproduce FS-58's per-field classes() exactly, and D(6), D(12)."""
    fields = sorted(FS58_DEPTH) + [119, 155, 299]
    print(f'fs61 atlas --check: (denominator, orbit count) lists against FS-58\'s classes(D, {nmax}) on '
          f'{len(fields)} fields', flush=True)
    bad = []
    for D in fields:
        C = class_table(D, nmax)
        want = {}
        for n, (N, vecs) in C.items():
            want[N] = want.get(N, 0) + 1
        got = {N: c for N, c in ((N, len(rational_classes(N))) for N in range(1, nmax + 1)) if c}
        for N in range(1, nmax + 1):
            f = atlas_scan_N(N, D + 1, dmin=D, keep=lambda x: x == D)
            if D in f:
                got[N] = got.get(N, 0) + len(orbits_of(f[D]))
        if got != want:
            diff = {N: (want.get(N, 0), got.get(N, 0)) for N in set(want) | set(got) if want.get(N, 0) != got.get(N, 0)}
            bad.append((D, diff))
            defect(f'atlas d={D}: (denominator, orbit count) differs from classes(): {diff}')
        print(f'  d={D:4d}: {sum(want.values())} classes over {len(want)} denominators -> '
              f'{"PASS" if got == want else "FAIL"}', flush=True)
    # O6's sets.  D(N) here is over EVERY squarefree d -- the plan's O6 states D(6) and D(18) within the family
    # (d = 11 mod 12) and D(12) over every squarefree d, which is the stronger of the two statements and is why it is
    # the one quoted without qualification.  Both forms are printed so the quantifier is visible.
    dn = {}
    for N in (6, 12, 18, 24):
        f = atlas_scan_N(N, 200_000, dmin=2)
        dn[N] = sorted(d for d in f if squarefree(d))
    fam = lambda L: [d for d in L if d % 12 == 11]
    for N in (6, 12, 18, 24):
        print(f'  D({N:2d}) = {dn[N]}', flush=True)
        print(f'          within the family (d = 11 mod 12): {fam(dn[N])}', flush=True)
    for label, got, want in (('D(6) within the family', fam(dn[6]), [11, 35]),
                             ('D(12) over every squarefree d', dn[12], [23, 47, 71, 95, 119, 143]),
                             ('D(18) within the family', fam(dn[18]), [11, 35, 155, 203, 299, 323])):
        ok = got == want
        if not ok:
            bad.append((label, got))
            defect(f'atlas {label} = {got}, expected {want}')
        print(f'  {label} = the plan\'s set: {"PASS" if ok else "FAIL"}', flush=True)
    for label, L, cond, name in (('D(6), D(18) within the family', fam(dn[6]) + fam(dn[18]), lambda d: d % 8 == 3, '3 mod 8'),
                                 ('D(12), D(24) within the family', fam(dn[12]) + fam(dn[24]), lambda d: d % 8 == 7, '7 mod 8')):
        ok = all(cond(d) for d in L)
        if not ok:
            bad.append((label, [d for d in L if not cond(d)]))
            defect(f'atlas {label}: {[d for d in L if not cond(d)]} are not {name}')
        print(f'  {label}: every member is {name}: {"PASS" if ok else "FAIL"}', flush=True)
    print(f'DONE atlas --check: {len(fields)} fields + the O6 sets; {len(bad)} failures', flush=True)
    return bad


# ================================================================ A.3 the laws of D-H.2, on every atlas row
def cmd_atlas_laws(quiet=False):
    """Four statements about which denominators can occur, tested on every (field, denominator) the atlas holds.

    Three are PROVED (plan D-H.2), so a violation is a defect in the enumerator, not news:
      L1  height floor: a non-rational class has d <= d(b^2+e^2) <= N^2, so N >= sqrt(d);
      L2  prime support: an odd p = 3 (mod 4) divides a class denominator only if (d/p) = -1, because every unit vector
          is a unit at every stable prime and the primes above such a p are stable when (d/p) is 0 or 1;
      L3  the dyadic law at d = 3 (mod 8): v_2(N) <= 1, since 2 = p^2 there with p stable.
    One is OBSERVED only (O6, and prediction P1):
      L4  at d = 7 (mod 8): v_2(N) != 1.
    Rational classes (b = e = 0) have odd hypotenuse denominators whose odd prime factors are all 1 (mod 4), so they
    satisfy L2, L3 and L4 vacuously; the laws bite on the non-rational classes and are reported on those."""
    rows = [json.loads(l) for l in open(FS61 / 'atlas.jsonl')]
    if not quiet:
        print(f'fs61 atlas --laws: D-H.2 on {sum(len(r["classes"]) for r in rows)} (field, denominator) pairs '
              f'over {len(rows)} fields', flush=True)
    viol = {1: [], 2: [], 3: [], 4: []}
    n_nr = 0
    for r in rows:
        d = r['d']
        for c in r['classes']:
            if not c['orbits_nonrational']:
                continue
            n_nr += 1
            N = c['N']
            if N * N < d:
                viol[1].append((d, N))
            for p in range(3, N + 1, 2):
                if N % p == 0 and p % 4 == 3 and all(p % q for q in range(3, math.isqrt(p) + 1, 2)):
                    if legendre(d, p) != -1:
                        viol[2].append((d, N, p, legendre(d, p)))
            if d % 8 == 3 and c['v2'] > 1:
                viol[3].append((d, N, c['v2']))
            if d % 8 == 7 and c['v2'] == 1:
                viol[4].append((d, N, c['v2']))
    names = {1: 'L1 height floor N >= sqrt(d)                                  [proved]',
             2: 'L2 odd p = 3 (mod 4) divides N only if (d/p) = -1             [proved]',
             3: 'L3 v_2(N) <= 1 at d = 3 (mod 8)                               [proved]',
             4: 'L4 v_2(N) != 1 at d = 7 (mod 8)                               [OBSERVED, P1]'}
    for k in (1, 2, 3, 4):
        if not quiet:
            print(f'  {names[k]}: {len(viol[k])} violations', flush=True)
        for v in viol[k][:20]:
            defect(f'atlas law L{k}: {v}')
    v2s = {}
    for r in rows:
        for c in r['classes']:
            if c['orbits_nonrational']:
                v2s.setdefault(r['mod8'], {}).setdefault(c['v2'], 0)
                v2s[r['mod8']][c['v2']] += 1
    if not quiet:
        for m in sorted(v2s):
            print(f'  v_2 of the non-rational denominators at d = {m} (mod 8): '
                  f'{dict(sorted(v2s[m].items()))}', flush=True)
        print(f'DONE atlas --laws: {n_nr} non-rational (field, denominator) pairs, '
              f'{sum(len(v) for v in viol.values())} violations', flush=True)
    out = FS61 / 'atlas-laws.json'
    out.write_text(json.dumps({'pairs_nonrational': n_nr, 'violations': {str(k): v[:200] for k, v in viol.items()},
                               'v2_by_mod8': {str(m): v2s[m] for m in sorted(v2s)}, 'machine': MACHINE}, indent=1) + '\n')
    return [v for k in viol for v in viol[k]]


def not_yet(name, phase):
    print(f'fs61 {name}: NOT IMPLEMENTED YET -- this subcommand is phase {phase} of plans/FS61-quadratic-census.md', flush=True)
    sys.exit(2)


# ================================================================ CLI
def main():
    ap = argparse.ArgumentParser(prog='fs61_census.py', description=__doc__.split('\n')[0],
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest='cmd', required=True)

    p = sub.add_parser('lattices', help="the tier's lattices for one field, saturated and canonicalised")
    p.add_argument('d', type=int); p.add_argument('--tier', default='1'); p.add_argument('--nmax', type=int)
    p.add_argument('--jobs', type=int, default=16); p.add_argument('--reverify', action='store_true')
    p.add_argument('--no-girth', action='store_true', help='skip the odd-girth search (records say `not asked`, never `null`)')

    p = sub.add_parser('filter', help='the exact colourability certificates (forms mod 2 and mod 3)')
    p.add_argument('d', type=int); p.add_argument('--tier', default='1')

    p = sub.add_parser('scan', help='ask whether balls of the field\'s lattices are 3-colourable')
    p.add_argument('d', type=int); p.add_argument('--tier', default='1'); p.add_argument('--filter-off', action='store_true')
    p.add_argument('--key'); p.add_argument('--radius', type=float, action='append')
    p.add_argument('--jobs', type=int, default=16); p.add_argument('--reverify', action='store_true')
    p.add_argument('--budget', type=float, help='stop asking after this many seconds (resume = re-run)')

    p = sub.add_parser('status', help='where each field stands, from the records alone')
    p.add_argument('d', type=int, nargs='*')

    p = sub.add_parser('selftest', help="the instrument's own checks, each with a planted fault that must fire")
    p.add_argument('--section', choices=sorted(SECTIONS))

    p = sub.add_parser('regress', help='the FS-58 regressions')
    p.add_argument('part', choices=['lattices', 'refusals', 'certificates', 'controls', 'untouched', 'all'])
    p.add_argument('--budget', type=float, help='controls: stop a field\'s scan after this many seconds')
    p.add_argument('--jobs', type=int, default=16)

    p = sub.add_parser('frame', help='L(Q(sqrt d)) for every squarefree d, by two independent routes')
    p.add_argument('--dmax', type=int, default=2000)
    p = sub.add_parser('atlas', help='class denominators by inverted enumeration: N first, d solved for')
    p.add_argument('--nmax', type=int, default=420); p.add_argument('--dmax', type=int, default=2000)
    p.add_argument('--check', action='store_true', help='cross-check against FS-58 classes() and the O6 sets')
    p.add_argument('--laws', action='store_true', help='test D-H.2 on every atlas row (A.3)')
    for name, phase in (('land', 'C'), ('table', 'B')):
        sub.add_parser(name, help=f'NOT IMPLEMENTED YET (phase {phase})')

    a = ap.parse_args()
    t0 = time.time()
    bad = []
    if a.cmd == 'lattices':
        _, bad = cmd_lattices(a.d, a.tier, nmax=a.nmax, jobs=a.jobs, reverify=a.reverify, girth=not a.no_girth)
    elif a.cmd == 'filter':
        _, bad = cmd_filter(a.d, a.tier)
    elif a.cmd == 'scan':
        if a.reverify:
            bad = cmd_scan_reverify(a.d)
        else:
            _, bad = cmd_scan(a.d, a.tier, filter_off=a.filter_off, only_key=a.key, radii=a.radius, jobs=a.jobs, budget=a.budget)
    elif a.cmd == 'status':
        cmd_status(a.d)
    elif a.cmd == 'selftest':
        bad = cmd_selftest(a.section)
    elif a.cmd == 'regress':
        if a.part in ('lattices', 'all'):
            bad += cmd_regress_lattices(jobs=a.jobs)
        if a.part in ('refusals', 'all'):
            bad += cmd_regress_refusals()
        if a.part in ('certificates', 'all'):
            bad += cmd_regress_certificates()
        if a.part in ('controls', 'all'):
            bad += cmd_regress_controls(jobs=a.jobs, budget=a.budget)
        if a.part in ('untouched', 'all'):
            bad += cmd_regress_untouched()
    elif a.cmd == 'frame':
        _, bad = cmd_frame(dmax=a.dmax)
    elif a.cmd == 'atlas':
        if a.check:
            bad = cmd_atlas_check()
        elif a.laws:
            bad = cmd_atlas_laws()
        else:
            cmd_atlas(nmax=a.nmax, dmax=a.dmax); bad = []
    elif a.cmd == 'land':
        not_yet(a.cmd, 'C')
    elif a.cmd == 'table':
        not_yet(a.cmd, 'B')
    print(f'[{a.cmd}: {time.time() - t0:.1f} s wall on {MACHINE.split(" (")[0]}]', flush=True)
    sys.exit(1 if bad else 0)


if __name__ == '__main__':
    main()
