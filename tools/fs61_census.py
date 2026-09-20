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
import sys, os, re, json, math, time, hashlib, gzip, argparse, subprocess, itertools, collections, fcntl, contextlib
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


@contextlib.contextmanager
def record_lock(path, create=False):
    """Hold an exclusive advisory lock on one JSONL record file for a whole read-and-repair or a whole append.

    WHY (the owner's ruling 2 after phase B', and the last of phase B's three repairs).  `load_jsonl` REPAIRS a partial
    final line by truncating the file, so every READ in this driver is a WRITE, and the length it truncates to was
    measured earlier: if a writer appends a finished record in between, truncating to the stale length destroys it.
    Phase B' added a guard -- refuse to truncate if the file is no longer the length it was read at -- which narrows
    the window to the two syscalls between the `stat` and the `truncate` and does NOT close it.  A lock closes it:
    while a reader holds it no writer can append, and while a writer holds it no reader can be part-way through.

    Phase E is the first part of this milestone that runs a pooled job over the family while its records are read, so
    the lock is built before any pooled run of it.  The lock lives on the record file's own inode, so it is shared by
    every process that goes through these two functions -- which is every command in the driver -- and costs one
    `flock` syscall per record.  `create=True` is for the append path, which is allowed to make the file."""
    path = Path(path)
    flags = os.O_RDONLY if not create else (os.O_RDWR | os.O_CREAT)
    if not create and not path.exists():
        yield False
        return
    fd = os.open(str(path), flags, 0o644)
    try:
        fcntl.flock(fd, fcntl.LOCK_EX)
        yield True
    finally:
        try:
            fcntl.flock(fd, fcntl.LOCK_UN)
        finally:
            os.close(fd)


def read_records(path):
    """Every record in the file, in order, with NO deduplication and NO repair: a pure reader.

    `load_jsonl` returns the latest record per key -- the current VIEW -- and repairs the file.  Two consumers need the
    raw history instead: a tier that re-asks a recorded ball writes a new record under the same key and so shadows the
    old one in the view, and an accounting check whose scope is `the balls tier 1b left undecided` must read that scope
    from the history, or the tier erases its own obligation by answering it (a check that passes because its subject
    has disappeared is not a check).  A partial final line is skipped, never truncated."""
    out = []
    path = Path(path)
    if not path.exists():
        return out
    with record_lock(path):
        for ln in path.read_bytes().split(b'\n'):
            if not ln.strip():
                continue
            try:
                out.append(json.loads(ln))
            except json.JSONDecodeError:
                pass                                              # a partial final line: skipped, not repaired
    return out


def load_jsonl(path, keyfield='key'):
    """key -> record, truncating a partial trailing line (FS-58's convention, its code, re-implemented for our key field).

    The read and the repair happen under `record_lock`, so a writer cannot append between them (see that function)."""
    done = {}
    path = Path(path)
    if path.exists():
        with record_lock(path):
            raw = path.read_bytes()
            *complete, tail = raw.split(b'\n')
            for ln in complete:
                if ln.strip():
                    r = json.loads(ln)
                    done[r[keyfield]] = r
            if tail:
                _repair_partial_line(path, len(raw), len(tail))
    return done


def _repair_partial_line(path, read_len, tail_len):
    """Truncate a partial final line -- but ONLY if the file is still the length it was read at.

    A second line of defence behind `record_lock`, kept because it is cheap, because it has been seen to fire, and
    because it still guards the one case the lock cannot: a writer that does not go through `append` (an editor, a
    crashed process's leftovers, a hand-repaired file).  Returns True if it truncated."""
    if path.stat().st_size != read_len:
        print(f'NOTE {rel(path)} grew while it was being read ({read_len} -> {path.stat().st_size} bytes): its '
              f'partial final line is dropped in memory and the FILE IS LEFT ALONE. Another process is writing it '
              f'outside this driver\'s lock.', flush=True)
        return False
    with open(path, 'r+b') as f:
        f.truncate(read_len - tail_len)
    return True


def append(path, rec):
    with record_lock(path, create=True):
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


def poset_pairs(lat):
    """the inclusion pairs among a field's lattices: (sub, sup) with Lambda_sub contained in Lambda_sup.
    Exact: every Hermite basis vector of the smaller lattice, rescaled to a common denominator, lies in the larger."""
    items = [(k, parse_key(k)) for k in sorted(lat)]
    pairs = []
    for ka, (Ma, Ha) in items:
        for kb, (Mb, Hb) in items:
            if ka == kb:
                continue
            L = Ma * Mb // math.gcd(Ma, Mb)                      # compare inside (1/L)Z^4
            A = [[x * (L // Ma) for x in r] for r in Ha]
            B = [[x * (L // Mb) for x in r] for r in Hb]
            Hb2 = hnf(B)
            if all(in_lattice(Hb2, v) for v in A):
                pairs.append((ka, kb))
    return pairs


def cmd_poset(D, quiet=False):
    lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
    out = field_dir(D) / 'poset.jsonl'
    pairs = poset_pairs(lat)
    if out.exists():
        out.unlink()
    for a, b in pairs:
        append(out, {'key': f'{a}<{b}', 'D': D, 'sub': a, 'sup': b, 'sub_id': lat[a]['id'], 'sup_id': lat[b]['id'],
                     'claim_scope': 'exact'})
    if not quiet:
        print(f'  poset d={D}: {len(pairs)} strict inclusions among {len(lat)} lattices', flush=True)
    return pairs


def cmd_filter(D, tid, quiet=False, quotients=True):
    """The one state axis (plan section 7, decision C\'), cheapest certificate first and TOP-DOWN.

    A 3-colouring of a lattice\'s graph restricts to every sublattice, so colourability is inherited DOWNWARD along the
    inclusion poset and refusal UPWARD.  The finest lattices are certified first and everything under a colourable one
    is closed without being asked; that is the order of work, and B.1b checks both directions afterwards."""
    tier = tier_def(tid)
    lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
    if not lat:
        die(f'no lattices for d={D}: run `fs61_census.py lattices {D} --tier {tid}` first')
    out = field_dir(D) / 'filter.jsonl'
    done = load_jsonl(out)
    pairs = cmd_poset(D, quiet=True)
    sups = {}                                                   # key -> the keys strictly containing it
    for a, b in pairs:
        sups.setdefault(a, []).append(b)
    nq = tier['quotients'] if quotients else 0
    openstr = (f'Open (no certificate among: forms mod 2, 3; {nq} quotients)' if quotients else OPEN_PHASE0)
    if not quiet:
        print(f'fs61 filter d={D} tier={tid}: {len(lat)} lattices, {len(done)} on disk; exact forms, then '
              f'{nq} quotients each, then inheritance down the {len(pairs)} inclusions', flush=True)
    counts, errs = {}, []
    order = sorted(lat, key=lambda k: -lat[k]['size'])           # finest (most generators) first
    for key in order:
        r = lat[key]
        msg = barrier_violation(r)
        if msg:
            errs.append((key, 'barrier: 3-integral but no form mod 3'))
            defect(f'filter d={D} {r["id"]} {r["spec_full"]}: {msg}')
        if key in done:
            counts[done[key]['state']] = counts.get(done[key]['state'], 0) + 1
            continue
        si = r['state_inputs']
        inherited, cert, state = None, None, None
        if si['forms_mod2']:
            state, cert = 'Colourable (form mod 2)', {'kind': 'form2', 'form': si['form2']}
        elif si['forms_mod3']:
            state, cert = 'Colourable (form mod 3)', {'kind': 'form3', 'form': si['form3']}
        else:
            for sup in sups.get(key, []):                        # a colourable lattice above closes this one for free
                st = done.get(sup, {}).get('state', '')
                if st.startswith('Colourable'):
                    state, inherited = st, sup
                    cert = dict(done[sup].get('certificate') or {}, inherited=True)
                    break
        tried = 0
        if state is None and quotients and r['rank'] == 4:
            M, H = parse_key(key)
            S = saturation(D, M, H)
            tried, colourable, cov, coords = quotient_screen(D, M, H, S, lattices=nq, wall=tier['quotient_wall'],
                                                             save=field_dir(D) / 'quotients')
            if colourable:
                best = min(colourable, key=lambda c: c['order'])
                state = 'Colourable (periodic colouring verified)'
                cert = {'kind': 'quotient', 'order': best['order'], 'H': best['H'], 'snf': [t for t in smith(best['H']) if t != 1],
                        'colouring_sha256': best['colouring_sha256'], 'colourable_of_tried': [len(colourable), tried]}
        if state is None:
            state = openstr
        rec = {'key': key, 'id': r['id'], 'D': D, 'state': state, 'certificate': cert, 'inherited_from': inherited,
               'quotients_tried': tried, 'rank': r['rank'], 'tier': tid, 'tier_sha256': tier['_sha256'],
               'machine': MACHINE,
               'claim_scope': 'exact' if (cert or {}).get('kind') in ('form2', 'form3') else
                              'verified model' if cert else 'a statement about the search'}
        append(out, rec)
        done[key] = rec
        counts[state] = counts.get(state, 0) + 1
    if not quiet:
        print('  DONE filter ' + ', '.join(f'{v} {k}' for k, v in sorted(counts.items())) +
              f'; {len(errs)} defects', flush=True)
    return done, errs


def cmd_filter_reverify(D, quiet=False):
    """B.3: re-check every colourability certificate against the FULL generator set, re-derived from the key."""
    import numpy as np
    lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
    filt = load_jsonl(field_dir(D) / 'filter.jsonl')
    bad, n = [], 0
    for key, f in sorted(filt.items()):
        c = f.get('certificate')
        if not c or f.get('inherited_from'):
            continue
        M, H = parse_key(key)
        S = saturation(D, M, H)
        if sha_vectors(S) != lat[key]['generators_sha256']:
            bad.append((key, 'generators do not match the key')); continue
        B, coords, cov, mc = FS.reduce_pool(D, M, S)
        n += 1
        if c['kind'] in ('form2', 'form3'):
            p = 2 if c['kind'] == 'form2' else 3
            vals = [sum(a * b for a, b in zip(c['form'], co)) % p for co in coords]
            ok = all(v == 1 for v in vals) if p == 2 else all(vals)
            if not ok:
                bad.append((key, f'the recorded form mod {p} is zero on some generator'))
                defect(f'filter --reverify d={D} {f["id"]}: the recorded form mod {p} is zero on some generator')
        elif c['kind'] == 'quotient':
            g = FS.quotient_graph(coords, c['H'])
            if g is None:
                bad.append((key, 'a generator lies in the recorded quotient lattice'))
                defect(f'filter --reverify d={D} {f["id"]}: a generator lies in the recorded quotient lattice')
                continue
            nq, E, _ = g
            path = field_dir(D) / 'quotients' / f'{c["colouring_sha256"]}.bin.gz'
            if not path.exists():
                bad.append((key, 'quotient colouring file missing')); continue
            with gzip.open(path, 'rb') as fh:
                raw = fh.read()
            col = np.frombuffer(raw, dtype=np.uint8)
            if len(col) != nq or (len(E) and not bool((col[E[:, 0]] != col[E[:, 1]]).all())):
                bad.append((key, 'the stored quotient colouring is not proper'))
                defect(f'filter --reverify d={D} {f["id"]}: the stored quotient colouring is not proper')
    if not quiet:
        print(f'fs61 filter --reverify d={D}: {n} certificates re-checked against the full generator set, '
              f'{len(bad)} failures', flush=True)
    return bad


# ================================================================ balls
def _worker_memory():
    """Two numbers, because they measure different things and a worker is reused across balls (CLAUDE.md: a number
    travels with what it measures).  `rss_peak_kb` is this WORKER PROCESS's high-water mark -- it may have been set by
    an earlier ball in the same worker, so it is an upper bound per ball and the right number for sizing a pool.
    `rss_now_kb` is the resident size at the end of THIS ball, with the previous ball's memory already freed."""
    import resource
    out = {'rss_peak_kb': resource.getrusage(resource.RUSAGE_SELF).ru_maxrss}
    try:
        for ln in open('/proc/self/status'):
            if ln.startswith('VmRSS:'):
                out['rss_now_kb'] = int(ln.split()[1])
                break
    except OSError:
        pass
    return out


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
               'solve_seconds': round(dt, 2), 'seconds': round(time.time() - t0, 2), **_worker_memory()}
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


def cmd_scan(D, tid, filter_off=False, only_key=None, radii=None, jobs=16, quiet=False, budget=None,
              wall_override=None):
    import multiprocessing as mp
    tier = tier_def(tid)
    lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
    if not lat:
        die(f'no lattices for d={D}: run `fs61_census.py lattices {D} --tier {tid}` first')
    filt = load_jsonl(field_dir(D) / 'filter.jsonl')
    out = field_dir(D) / 'balls.jsonl'
    done = load_jsonl(out)
    radii = radii or tier['radii']
    cap, wall = tier['point_cap'], (wall_override or tier['solve_wall'])

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
    if radii is None and not filter_off and not only_key:
        radii = [tier['radii'][0]]                              # pass one: the census's comparable column
    todo = []
    for r in pool:
        gens = None
        for R in (radii or tier['radii']):
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
    landings = load_jsonl(FS61 / 'landings.jsonl')
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
        wit = certified_field(D, landings)
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


def certified_field(D, landings=None):
    """Is `d` **landed**?  On the checker's VERDICT, never on a file existing: `land` writes certified.out whatever
    the checker says, so an `.exists()` test would promote a REFUSED run to `Landed (certified)` (fixed 2026-09-20,
    found while phase C's first field ran).  Both halves must agree -- the landing record's own result, and the
    first line of the checker's committed output."""
    cf = FS61 / f'witness-{D}' / 'certified.out'
    if landings is None:
        landings = load_jsonl(FS61 / 'landings.jsonl')
    return (landings.get(str(D), {}).get('result') == 'CERTIFIED' and cf.exists()
            and cf.read_text().lstrip().startswith('CERTIFIED'))


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


def selftest_land(rnd):
    """Phase C's own machinery, through the SHIPPED functions, each with a plant and both outcomes shown reachable:
    the minimality reader (C.9), the four-colouring (C.5), the 3-adic barrier counter (C.6), the checkpoint repair,
    and the stop-by-pid verification."""
    import tempfile
    rows = []
    # --- C.9, the minimality reader.  Both outcomes reachable: the two provenance strings FS-58 actually writes.
    mk = lambda s: {'construction': {'reduction': s}}
    a = _minimality(mk('1-minimal refusing vertex set by Glucose4 core-guided deletion, translated by -p'))
    b = _minimality(mk('72 rounds of CaDiCaL assumption cores to a fixpoint (17169 -> 1737 points), then Glucose4 '
                       'deletion STOPPED after 363 of 1737 tests (the set is refusing, not 1-minimal), then '))
    c = _minimality({'construction': {}})
    rows.append(('C.9 the minimality reader says `yes` on FS-58\'s direct-witness provenance',
                 a['minimal'] == 'yes', a['note']))
    rows.append(('PLANT (C.9): FS-58\'s own stopped-deletion provenance (witness-95) is NOT reported as minimal',
                 b['minimal'] == 'no' and (b['stopped_at'], b['of_tests']) == (363, 1737), b['note']))
    rows.append(('C.9 an absent deletion phase reads `unknown`, never `yes`', c['minimal'] == 'unknown', c['note']))
    # --- C.5, the four-colouring.  Positive: a 5-cycle needs 3 and takes 4.  Plant: K_5 needs 5, so None.
    c5 = four_colour([(0, 0, 0, 0, 1)] * 5, [(0, 1), (1, 2), (2, 3), (3, 4), (0, 4)])
    k5 = four_colour([(0, 0, 0, 0, 1)] * 5, [(i, j) for i in range(5) for j in range(i + 1, 5)])
    rows.append(('C.5 four_colour finds and verifies a proper 4-colouring of a 5-cycle',
                 c5 is not None and all(c5[i] != c5[j] for i, j in [(0, 1), (1, 2), (2, 3), (3, 4), (0, 4)]),
                 f'colouring {c5}'))
    rows.append(('PLANT (C.5): K_5 is 5-chromatic, so four_colour must return nothing', k5 is None, f'{k5}'))
    # --- C.6, the 3-adic barrier counter.  Positive: FS-58's own certified 47 witness.  Plant: the same points with
    #     every denominator made prime to 3, which is exactly the hypothesis of the kernel barrier (row 72).
    w47 = json.loads((ROOT / 'data' / 'fs58' / 'witness-47' / 'witness.json').read_text())
    p47, e47 = [tuple(p) for p in w47['points']], [tuple(e) for e in w47['edges']]
    n47 = barrier_edge_count(47, p47, e47)
    flat = [(a_, b_, c_, e_, m // 3 ** v_p(m, 3) or 1) for a_, b_, c_, e_, m in p47]
    nflat = barrier_edge_count(47, flat, e47)
    rows.append(('C.6 FS-58\'s certified 47 witness has edges with 3 in the reduced denominator (row 72 says it must)',
                 n47 > 0, f'{n47} of {len(e47)} edges'))
    rows.append(('PLANT (C.6): the same edge list over 3-integral points counts zero, which is the defect reading',
                 nflat == 0, f'{nflat} of {len(e47)} edges'))
    # --- the checkpoint repair.  Both outcomes reachable: a clean file is untouched, a truncated one is repaired.
    with tempfile.TemporaryDirectory() as td:
        good = Path(td) / 'steps.jsonl'
        good.write_text(json.dumps({'step': 'deletion', 'position': 7, 'finished': False, 'kept': [[1, 2, 3, 4]]},
                                   separators=(',', ':')) + '\n')
        clean = good.read_bytes()
        rows.append(('the checkpoint repair leaves an intact steps.jsonl alone',
                     _repair_steps(good) is None and good.read_bytes() == clean, f'{len(clean)} bytes, unchanged'))
        rows.append(('the deletion state is read back from an intact checkpoint', _deletion_state(good) == (7, False),
                     f'{_deletion_state(good)}'))
        with open(good, 'ab') as f:
            f.write(b'{"step":"deletion","position":8,"finis')      # a SIGTERM between write and flush
        msg = _repair_steps(good)
        rows.append(('PLANT (checkpoint): a truncated final record is dropped, loudly, and nothing else is',
                     msg is not None and good.read_bytes() == clean and _deletion_state(good) == (7, False), msg))
    # --- C.4a / C.4b.  The inference under test is that the frozen second opinion is STRAIGHT-LINE, so its
    #     step-(iii) message proves steps (i) and (ii) passed.  Every arm below is exercised, both outcomes of
    #     each are reachable, and the wrong-reason guard is explicit: a step-(i) or step-(ii) failure must turn
    #     C.4a red WHATEVER C.9 says, because those are failures of the second opinion itself.
    SHA = RECHECK_TOOL_SHA256
    L3 = 'RECHECK FAIL: deleting vertex 7 leaves a graph that still refuses (control expected a colouring)'
    L2 = 'RECHECK FAIL: Lingeling finds a 3-colouring'
    L1 = 'RECHECK FAIL: 2828 unit pairs by Fraction arithmetic against 2829 in the file'
    LP = 'RECHECK PASS: 1004 points; 2829 unit pairs by Fraction arithmetic over all 503506 pairs = the file; …'
    a, b = classify_recheck(LP, 0, 'no', SHA)
    rows.append(('C.4a/C.4b: a RECHECK PASS passes both claims', a['ok'] and b['ok'] and not b['required'],
                 f"4a {a['step']}, 4b required={b['required']}"))
    a, b = classify_recheck(L3, 1, 'no', SHA)
    rows.append(('C.4a is GREEN on the step-(iii) line: in that file it is reachable only after (i) and (ii)',
                 a['ok'] is True and a['step'] == '(i)+(ii)', a['why']))
    rows.append(('C.4b is RED and merely RECORDED when C.9 says the witness is not 1-minimal (the d=95 case)',
                 b['ok'] is False and b['required'] is False, f"required={b['required']}"))
    a, b = classify_recheck(L3, 1, 'yes', SHA)
    rows.append(('PLANT (C.4b): the same line on a witness C.9 records as 1-minimal is REQUIRED, so it halts',
                 a['ok'] is True and b['ok'] is False and b['required'] is True, f"required={b['required']}"))
    for lab, ln, st in (('(ii), a solver finding a 3-colouring', L2, '(ii)'),
                        ('(i), the exact edge re-derivation disagreeing', L1, '(i)')):
        for m in ('no', 'yes'):
            a, b = classify_recheck(ln, 1, m, SHA)
            rows.append((f'PLANT (C.4a, wrong-reason guard): a failure at step {lab} turns C.4a RED with '
                         f'C.9 = {m}', a['ok'] is False and a['step'] == st and b['ok'] is None, a['why']))
    a, b = classify_recheck(L3, 1, 'no', '0' * 64)
    rows.append(('PLANT (the inference is about ONE file): at a different sha256 the step-(iii) inference is '
                 'REFUSED, not guessed', a['ok'] is False and a['step'] == 'refused' and b['ok'] is None, a['why']))
    real = hashlib.sha256((ROOT / 'tools' / 'fs58_recheck_witness.py').read_bytes()).hexdigest()
    rows.append(('the frozen second opinion on disk still has the sha256 the inference is stated for',
                 real == SHA, f'{real[:16]}…'))
    # --- `Landed (certified)` reads the checker's VERDICT, not a file's existence.  Both outcomes reachable on the
    #     real data: a landed field and the same field with each half of the test spoiled in turn.
    landings = load_jsonl(FS61 / 'landings.jsonl')
    cert = [d for d in LAND_ORDER if certified_field(d, landings)]
    rows.append(('the landed set is read from the landing records and the checker\'s own first line',
                 True, f'{len(cert)} of {len(LAND_ORDER)} fields landed: {cert}'))
    if cert:
        d0 = cert[0]
        rows.append((f'PLANT (landing): d={d0} with its landing record result mangled is NOT landed',
                     not certified_field(d0, dict(landings, **{str(d0): dict(landings[str(d0)],
                                                                            result='INCOMPLETE')})),
                     'a record that does not say CERTIFIED cannot promote a field'))
    else:
        rows.append(('PLANT (landing): no field is landed yet, so an existing certified.out alone does not land one',
                     not any((FS61 / f'witness-{d}' / 'certified.out').exists() and certified_field(d, landings)
                             for d in LAND_ORDER),
                     'both halves of the test are required'))
    # --- the stop-by-pid verification.  Both outcomes reachable on a real child: a live writer's digest MOVES, and
    #     the same child stopped by pid leaves it static.  (Never a pattern match: `p.pid`, and `p.wait()` reaps it.)
    with tempfile.TemporaryDirectory() as td:
        art = Path(td) / 'steps.jsonl'
        art.write_text('')
        prog = f'import time\nwhile True:\n open({str(art)!r}, "a").write("x" * 100 + "\\n"); time.sleep(0.05)'
        p = subprocess.Popen([sys.executable, '-c', prog])
        time.sleep(1.0)
        d1 = hashlib.sha256(art.read_bytes()).hexdigest()
        time.sleep(1.0)
        moving = d1 != hashlib.sha256(art.read_bytes()).hexdigest()
        rows.append(('the stop verification CAN fire: a live writer\'s artifact digest moves across the sample',
                     moving, 'digest changed while the child was still running'))
        with open(os.devnull, 'w') as dn:
            line, static = _stop_child(p, art, 'selftest', dn)
        rows.append(('PLANT resolved: the same child stopped BY PID is reaped and its artifact goes static',
                     static and p.poll() is not None, line))
    return rows


TIER_SHA_AT_MINT = {'1': '7a520f29e32724da', '1b': 'fb13bdf841cf581d', '2': '34763942a9797e27',
                    '1c': '7e833199a93662b0', '2l': '31490e13c24cffa6'}   # read off the records at mint, 2026-09-20


def selftest_ladder(rnd):
    """Phase B' (tier 1b): the ladder's rung rule, its accounting check, and the census's three null phrases.  Every
    clause is shown able to go RED, on fixtures built from the real records and never written back."""
    rows = []
    # (0) a standing control: tier 1's and tier 2's definitions are what the committed records were stamped against.
    #     The count is computed, never written down: a number in a check's message drifts, and a check whose message
    #     names a wrong number is this project's own failure mode (mine, 2026-09-20 -- it said 343, a figure from a
    #     different population, where the true count over every field is 1,745).
    stamped = collections.Counter()
    for D in FAMILY_500 + [2, 5, 7, 13, 19, 31, 43]:
        for ln in (field_dir(D) / 'balls.jsonl').read_bytes().split(b'\n') if (field_dir(D) / 'balls.jsonl').exists() else []:
            if ln.strip():
                stamped[json.loads(ln).get('tier_sha256')] += 1
    for t, sha in sorted(TIER_SHA_AT_MINT.items()):
        got = tier_def(t)['_sha256']
        rows.append((f'tier {t}\'s definition is unmoved -- every committed ball record stamped with it depends on that',
                     got == sha, f'{got} (minted {sha}); {stamped.get(sha, 0)} ball records carry it'))
    D, tid = 23, '1b'
    tier = tier_def(tid)
    cap = tier['point_cap']
    plan, out = ladder_plan(D, tid)
    balls = load_jsonl(field_dir(D) / 'balls.jsonl')
    if not plan:
        rows.append(('d=23 has lattices in the ladder\'s scope', False, 'none found -- the fixture is gone'))
        return rows
    # (1) scope: in only when the base ball was NOT asked; out with the reason, and both populations are non-empty.
    rows.append(('scope: every lattice in the plan has an `Over cap (not asked)` record at the base radius',
                 all(balls[f'{k}|ball{tier["base_radius"]}']['verdict'] == 'Over cap (not asked)' for k in plan),
                 f'{len(plan)} in scope at d={D}'))
    asked_out = {k: w for k, w in out.items() if w.startswith('asked at R=')}
    rows.append(('scope: a lattice whose base ball WAS asked is out of scope, with the verdict as the reason',
                 bool(asked_out), f'{len(asked_out)} of {len(out)} out-of-scope lattices, e.g. '
                                  f'{sorted(asked_out.values())[0] if asked_out else "-"}'))
    # (2) the rung is chosen by the predicted-points formula, and the choice MOVES when the cap moves (B'.1).
    key = sorted(plan, key=lambda k: (plan[k]['askable'] or [(0, 1 << 60)])[0][1])[0]
    e = plan[key]
    chosen = e['askable'][0][0] if e['askable'] else None
    first_fit = next((R for R, p in e['rungs'] if p is not None and p <= cap), None)
    rows.append(('the rung selected is the first whose PREDICTED points fit the cap', chosen == first_fit,
                 f'{e["id"]}: rungs ' + ', '.join(f'{R}:{p}' for R, p in e['rungs']) + f' -> R={chosen} at cap {cap}'))
    tight = e['rungs'][0][1] - 1                                   # a cap just under the top rung's prediction
    moved = next((R for R, p in e['rungs'] if p is not None and p <= tight), None)
    rows.append(('PLANT (rung rule): with the cap set just under the top rung\'s prediction the choice DESCENDS, so the '
                 'formula is what decides and both outcomes are reachable', moved is not None and moved != e['rungs'][0][0],
                 f'cap {tight} -> R={moved}, against R={e["rungs"][0][0]} at cap {cap}'))
    # (3) the accounting check.  Fixtures, never written back.
    R0, p0 = e['askable'][0]
    good = {f'{key}|ball{R0}': {'key': f'{key}|ball{R0}', 'tier': tid, 'verdict': 'Colourable (colouring verified)'}}
    ok, why = ladder_status(e, good, tid)
    rows.append(('a lattice answered at its selected rung is complete', ok, why))
    ok, why = ladder_status(e, {}, tid)
    rows.append(('PLANT (accounting): the record at the selected rung deleted -> the check names the rung', not ok, why))
    ok, why = ladder_status(e, {f'{key}|ball{R0}': dict(good[f'{key}|ball{R0}'], tier='1')}, tid)
    rows.append(('PLANT (accounting): a record at the right rung but stamped with the WRONG tier does not count',
                 not ok, why))
    over_exact = {'key': f'{key}|ball{R0}', 'tier': tid, 'verdict': 'Over cap (not asked)', 'over_cap_by': 'exact'}
    ok, why = ladder_status(e, {f'{key}|ball{R0}': over_exact}, tid)
    if len(e['askable']) > 1:
        rows.append(('PLANT (descent): an exact over-cap at the top rung with no record below it -> incomplete',
                     not ok, why))
        R1 = e['askable'][1][0]
        ok2, why2 = ladder_status(e, {f'{key}|ball{R0}': over_exact,
                                      f'{key}|ball{R1}': {'key': f'{key}|ball{R1}', 'tier': tid,
                                                          'verdict': 'Refused (solver claim)'}}, tid)
        rows.append(('PLANT resolved: with the descent record present the same ladder is complete', ok2, why2))
    ok, why = ladder_status(e, {f'{key}|ball{R0}': {'key': f'{key}|ball{R0}', 'tier': tid,
                                                   'verdict': 'Over cap (not asked)', 'over_cap_by': 'prediction'}}, tid)
    rows.append(('PLANT (consistency): `over cap by PREDICTION` at a rung the prediction fits is impossible under the '
                 'rule, and is caught', not ok, why))
    # (4) the census's three null phrases are three different strings, and each is reachable (ruling 6 plus its gap).
    L4 = {'k1': {'rank': 4}, 'k2': {'rank': 4}}
    phrases = {
        'by certificate': field_not_landed_reason(L4, {'k1': {'state': 'Colourable (form mod 3)'}}, {}),
        'by budget': field_not_landed_reason(L4, {'k1': {'state': 'Open (x)'}, 'k2': {'state': 'Open (x)'}},
                                             {'b': {'lattice': 'k1', 'verdict': 'Over cap (not asked)'}}),
        'asked': field_not_landed_reason(L4, {'k1': {'state': 'Open (x)'}, 'k2': {'state': 'Open (x)'}},
                                         {'b': {'lattice': 'k1', 'verdict': 'Colourable (colouring verified)'}}),
        'undecided': field_not_landed_reason(L4, {'k1': {'state': 'Open (x)'}, 'k2': {'state': 'Open (x)'}},
                                             {'b': {'lattice': 'k1', 'verdict': 'Unknown (budget)'}}),
    }
    rows.append(('the census null phrases are distinct and each is reachable',
                 len(set(phrases.values())) == 4 and phrases['by certificate'] == 'by certificate'
                 and phrases['by budget'].startswith('by budget: 2 Open lattices')
                 and phrases['asked'] == 'asked: 1 of 2 Open lattices, no refusal',
                 ' | '.join(phrases.values())))
    rows.append(('PLANT (phrases): a ball that ran to the wall must NOT read as "asked and not refused" -- it is '
                 'counted as undecided', phrases['undecided'].endswith(', 1 undecided at the wall'),
                 phrases['undecided']))
    rows.append(('PLANT (phrases): an UNASKED open lattice must never read as asked -- an Over cap record alone keeps '
                 'the field `by budget`', phrases['by budget'].startswith('by budget'), phrases['by budget']))
    # (5) A.8's 15 % bound on predicted-beside-actual: it fires, and it is a FINDING and not a defect.
    fix = {'predicted_points': 100000, 'points': 100000, 'verdict': 'Colourable (colouring verified)'}
    good8 = _ladder_decorate(fix, e, 'fixture', R0)
    bad8 = _ladder_decorate(dict(fix, points=200000), e, 'fixture', R0)
    rows.append(('B\'.1: every record carries predicted beside actual, with A.8\'s bound applied to the pair',
                 good8['within_A8_bound'] is True and good8['actual_over_predicted'] == 1.0,
                 f'ratio {good8["actual_over_predicted"]}, rungs {good8["ladder_rungs"]}'))
    rows.append(('PLANT (A.8): an actual count at twice the prediction is flagged outside the bound',
                 bad8['within_A8_bound'] is False, f'ratio {bad8["actual_over_predicted"]}'))
    # (6) reading a record file must never destroy a record another process appended while it was being read.
    import tempfile
    with tempfile.TemporaryDirectory() as td:
        p = Path(td) / 'balls.jsonl'
        p.write_text('{"key":"a"}\n{"key":"b"}\n{"key":"c"')          # a genuine partial final line
        raw = len(p.read_bytes())
        rows.append(('a quiescent file with a partial final line IS repaired',
                     _repair_partial_line(p, raw, len('{"key":"c"')) and p.read_text() == '{"key":"a"}\n{"key":"b"}\n',
                     f'{raw} bytes -> {p.stat().st_size}'))
        partial = '{"key":"c"'
        p.write_text(f'{{"key":"a"}}\n{{"key":"b"}}\n{partial}')
        stale = len(p.read_bytes())
        with open(p, 'a') as f:                                       # a writer finishes the line and appends another
            f.write('}\n{"key":"d"}\n')
        grew = p.read_text()
        rows.append(('PLANT (data loss): the same repair against a STALE length leaves the file alone instead of '
                     'destroying the records appended since', _repair_partial_line(p, stale, len(partial)) is False
                     and p.read_text() == grew, f'{stale} -> {p.stat().st_size} bytes, all {len(grew.splitlines())} '
                     f'lines intact; unguarded it would truncate to {stale - len(partial)} bytes and lose the last '
                     f'two records'))
        rows.append(('PLANT resolved: the stale-length read still returns the complete records it could parse',
                     list(load_jsonl(p)) == ['a', 'b', 'c', 'd'], f'{list(load_jsonl(p))}'))
    # (7) phase C's field list is read from the records, so a field this tier lands is not silently skipped.
    here = land_order(quiet=True)
    planted = land_order(refusing=set(LAND_ORDER) | {239}, quiet=True)
    # The invariant is `no refusing field is dropped`, NOT `the list is exactly the one phase C committed`.  As first
    # written this row asserted equality, and it went red the hour tier 1c refused at d = 311 -- a check reporting a
    # finding as a defect, and a snapshot in a check's assertion, which this repository has recorded before.
    extra = [d for d in here if d not in LAND_ORDER]
    rows.append(('phase C\'s committed priority order is a prefix of today\'s, with every field that has refused '
                 'since appended and named',
                 here[:len(LAND_ORDER)] == LAND_ORDER and all(d not in LAND_ORDER for d in extra),
                 f'{here}' + (f'  (appended since phase C: {extra})' if extra else '  (none appended)')))
    rows.append(('PLANT (land order): a field refusing for the first time is APPENDED, never dropped',
                 planted[:len(LAND_ORDER)] == LAND_ORDER and 239 in planted and 239 not in LAND_ORDER,
                 f'{planted}'))
    return rows


def selftest_phaseE(rnd):
    """Phase E's two new tiers: which records count as which tier's work (`_tier_counts`), which lattices a tier owns
    (`tier_nmax_scope`), that a re-ask tier's scope is read from the HISTORY and so cannot erase itself, and that a
    deeper tier's new certificates close the stale `Open` records under them.  Every clause is shown able to go RED."""
    import tempfile
    rows = []
    t1b, t1c, t2l = tier_def('1b'), tier_def('1c'), tier_def('2l')
    R = lambda t, v='Colourable (colouring verified)', **kw: dict({'tier': t, 'verdict': v}, **kw)
    # (1) which tier's record counts as which tier's work.  The two that matter are new; the one that must NOT count
    #     is the plant the ladder section already fires, restated here beside its siblings.
    rows.append(('a DEEPER tier\'s record counts for the shallower tier it shadows -- without this, a ball re-asked '
                 'at a deeper tier would read as a shallower tier\'s gap', _tier_counts(R('1c'), '1b'),
                 'tier 1c record, tier 1b asking'))
    rows.append(('PLANT: a shallower tier\'s record does NOT discharge a deeper tier\'s own obligation',
                 not _tier_counts(R('1b'), '1c'), 'tier 1b record, tier 1c asking'))
    rows.append(('a tier that REUSES a shallower tier\'s lattices counts that tier\'s balls (tier 2l over tier 1)',
                 _tier_counts(R('1'), '2l'), 'tier 1 record, tier 2l asking'))
    rows.append(('PLANT: a shallower tier that is NOT reused does not count (the tier-1b rule, unmoved)',
                 not _tier_counts(R('1'), '1b'), 'tier 1 record, tier 1b asking'))
    rows.append(('and settledness is still applied on top of the tier relation: a deeper record that ran to a '
                 'SMALLER wall than this tier\'s does not answer it',
                 _record_answers(R('1c', 'Unknown (budget)', wall=3600, cap=600000), '1b', t1b)
                 and not _record_answers(R('2l', 'Unknown (budget)', wall=60, cap=600000), '1b', t1b),
                 'wall 3600 answers tier 1b (600 s); wall 60 does not'))
    # (2) which lattices a tier owns.  Tier 2l adds lattices at NMAX = 420; without this, tier 1's accounting would
    #     report a gap on every one of them, for balls tier 1's definition never said it would ask.
    rows.append(('tier 2l owns tier 1\'s lattices (NMAX 180 <= 420) and tier 1 does NOT own tier 2l\'s',
                 tier_nmax_scope({'tier': '1'}, t2l) and not tier_nmax_scope({'tier': '2l'}, tier_def('1')),
                 f'nmax 180 in 420: True; nmax 420 in 180: False'))
    rows.append(('PLANT: a lattice from an unknown tier is counted, never silently dropped',
                 tier_nmax_scope({'tier': 'nosuchtier'}, tier_def('1')), 'unknown tier -> in scope'))
    # (3) a re-ask tier's scope is a historical fact.  Answering a ball must NOT remove it from the scope, or the
    #     accounting check passes because its subject disappeared.  `read_records` is what makes that true.
    with tempfile.TemporaryDirectory() as td:
        p = Path(td) / 'balls.jsonl'
        append(p, {'key': 'K|ball1.0', 'lattice': 'K', 'id': 'L0', 'R': 1.0, 'tier': '1b',
                   'verdict': 'Unknown (budget)', 'wall': 600, 'points': 10})
        view_before = load_jsonl(p)['K|ball1.0']['verdict']
        append(p, {'key': 'K|ball1.0', 'lattice': 'K', 'id': 'L0', 'R': 1.0, 'tier': '1c',
                   'verdict': 'Colourable (colouring verified)', 'wall': 3600, 'points': 10})
        view = load_jsonl(p)['K|ball1.0']
        hist = read_records(p)
        rows.append(('the re-ask record SHADOWS the record it re-asks in the view, while the history keeps both',
                     view_before == 'Unknown (budget)' and view['tier'] == '1c' and len(hist) == 2
                     and hist[0]['tier'] == '1b',
                     f'view: tier {view["tier"]} {view["verdict"]!r}; history: {[h["tier"] for h in hist]}'))
        scope_from_history = [h for h in hist if h['tier'] == '1b' and h['verdict'] == 'Unknown (budget)']
        scope_from_view = [v for v in load_jsonl(p).values() if v['tier'] == '1b' and v['verdict'] == 'Unknown (budget)']
        rows.append(('PLANT (self-erasing check): a scope defined by a verdict empties the moment the work is done, '
                     'so an accounting read from the VIEW would pass by having lost its subject; `read_records` '
                     'keeps the history, and the degree tier\'s own scope is a LATTICE STATE (`Open` or `Refused`) '
                     'for the same reason -- a lattice that refuses must not drop out of the check that owed it',
                     len(scope_from_history) == 1 and len(scope_from_view) == 0,
                     f'history 1 ball in scope, view {len(scope_from_view)}'))
    # (4) colourability inherited downward: a deeper tier's certificate closes the stale Open record under it.
    pairs = [('sub', 'sup'), ('other', 'sup')]
    filt = {'sub': {'state': 'Open (x)'}, 'sup': {'state': 'Colourable (periodic colouring verified)'},
            'other': {'state': 'Colourable (form mod 3)'}}
    got = colourability_closures(filt, pairs)
    rows.append(('a lattice recorded Open inside one recorded Colourable is closed from above, and one already '
                 'Colourable is left alone', got == [('sub', 'sup')], f'{got}'))
    rows.append(('PLANT: with the superlattice still Open nothing is closed -- the closure comes from the '
                 'certificate above, not from the inclusion',
                 colourability_closures({**filt, 'sup': {'state': 'Open (x)'}}, pairs) == [],
                 'sup Open -> no closure'))
    # (5) the degree tiers have no base-radius precondition, which is the point of `tier_nmax_scope`: a lattice tier
    #     1b skipped as `already asked` is still in a degree tier's scope, because that tier asks a different ball.
    D = 155
    p1b, o1b = ladder_plan(D, '1b')
    asked = {k for k, w in o1b.items() if w.startswith('asked at R=')}
    indeg = {it['key'] for it in degree_plan('1c', fields=[D])}
    rows.append((f'a lattice tier 1b skipped as `already asked at its base radius` is still in the degree tier\'s '
                 f'scope -- a degree tier asks a different ball, not a rung of the same ladder',
                 bool(asked) and bool(asked & indeg),
                 f'd={D}: {len(asked)} out of tier-1b scope as already asked, {len(asked & indeg)} of them in the '
                 f'tier-1c plan'))
    return rows


def selftest_degree(rnd):
    """Tier 1c's degree law and its radius rule (the owner's revision of E.1a, 2026-09-20).

    The law is checked against EVERY asked ball record on disk -- a real-data control, not a fixture -- and the rule
    is shown to move between all three of its arms when the cap moves, so none of them is unreachable."""
    rows = []
    tier = tier_def('1c')
    target, floor, cap = tier['target_degree'], tier['floor_degree'], tier['point_cap']
    # (1) the law, on every asked ball with a point count and an edge count.
    obs = []
    for pth in sorted((FS61 / 'fields').glob('*/balls.jsonl')):
        lat = load_jsonl(pth.parent / 'lattices.jsonl')
        for r in load_jsonl(pth).values():
            g = lat.get(r['lattice'], {}).get('size')
            if g and isinstance(r.get('points'), int) and isinstance(r.get('edges'), int) and r['points']:
                obs.append(((2 * r['edges'] / r['points']) / degree_of(g, r['R']), r))
    rat = sorted(x for x, _ in obs)
    med = rat[len(rat) // 2] if rat else 0
    rows.append((f'the degree law g*phi(R)^2 against every asked ball record on disk',
                 bool(rat) and abs(med - 1) < 0.02 and rat[0] > 0.6 and rat[-1] < 1.4,
                 f'{len(rat)} balls: observed/predicted median {med:.4f}, range {rat[0]:.3f}-{rat[-1]:.3f}, '
                 f'{sum(1 for x in rat if abs(x - 1) > 0.3)} outside +-30%'))
    # PLANT: the same law WITHOUT the bidisc square -- one disc instead of two -- must be visibly wrong.
    bad = sorted((2 * r['edges'] / r['points']) / (lat_g * degree_phi(r['R']))
                 for lat_g, r in [(load_jsonl(FS61 / 'fields' / str(r['D']) / 'lattices.jsonl')[r['lattice']]['size'], r)
                                  for _, r in obs[:60]])
    rows.append(('PLANT (the law): dropping the bidisc square -- g*phi(R) instead of g*phi(R)^2 -- is visibly wrong, '
                 'so the square is doing the work and the control can fail',
                 bool(bad) and abs(bad[len(bad) // 2] - 1) > 0.1,
                 f'median {bad[len(bad) // 2]:.3f} on a 60-ball sample, against {med:.4f} for the law'))
    # (2) the three arms are all reachable, and the cap is what moves between them.
    g, cov = 36, 5.154e-05                                        # d = 167's L3e1c94c6, the field's one askable lattice
    R14 = radius_for_degree(g, target)
    p14 = predicted_points(cov, R14)
    def arm(c):
        Rc = radius_for_points(cov, c / DEGREE_OVERSHOOT)
        if R14 is not None and predicted_points(cov, R14) <= c / DEGREE_OVERSHOOT:
            return 'R14'
        return 'Rcap' if degree_of(g, Rc) >= floor else 'overcap'
    rows.append(('the rule reaches all three arms as the cap moves, so none of them is unreachable',
                 (arm(cap), arm(600_000), arm(120_000)) == ('R14', 'Rcap', 'overcap'),
                 f'g={g}, covolume {cov:.3e}: cap {cap:,} -> {arm(cap)} (R={R14:.3f}, {p14:,} points); '
                 f'cap 600,000 -> {arm(600_000)}; cap 120,000 -> {arm(120_000)}'))
    rows.append(('PLANT (the degree target decides the radius): raising the target raises the radius it picks',
                 radius_for_degree(g, target + 6) > R14,
                 f'degree {target} -> R={R14:.3f}; degree {target + 6} -> R={radius_for_degree(g, target + 6):.3f}'))
    rows.append(('a lattice can never exceed its own generator count in degree, so the target is unreachable at '
                 'g <= target; and the search bound R <= 12 makes the answer CONSERVATIVE just above it, which '
                 'under-asks and never over-asks',
                 radius_for_degree(target, target) is None and radius_for_degree(target + 1, target) is None
                 and radius_for_degree(target + 6, target) is not None,
                 f'g={target} cannot reach degree {target} at any radius (degree rises to g and stops); g={target+1} '
                 f'reads {degree_of(target+1, 12):.2f} at the search bound R = 12 and is reported unreachable; '
                 f'g={target+6} reaches it at R = {radius_for_degree(target+6, target):.3f}'))
    # (3) the safety margin below the cap.  Aiming AT the cap overflows on the recorded ratios; aiming below does not.
    #     The ratio here is POINTS observed over points predicted -- NOT the degree ratio used above.  I first wrote
    #     the degree ratio into this row, which reads 1.0407 where the points ratio reads 1.1078: a number measuring
    #     one thing put to work deciding another, which is this repository's most repeated error, caught by the row
    #     below it going red for an unrelated reason.
    worst = max((r['points'] / r['predicted_points']
                 for _, r in obs if isinstance(r.get('points'), int) and r['points'] >= 100_000
                 and isinstance(r.get('predicted_points'), int) and r['predicted_points']), default=1.0)
    rows.append(('the rule aims below the point cap by the largest overshoot ever recorded on a ball of at least '
                 '100,000 points, so the EXACT count does not overflow the cap',
                 DEGREE_OVERSHOOT >= worst,
                 f'margin {DEGREE_OVERSHOOT}, worst recorded actual/predicted on such a ball {worst:.4f}'))
    rows.append(('PLANT (the margin): aiming AT the cap would overflow it at that worst ratio -- which is what the '
                 'first ball of this tier did, returning `Over cap (not asked)` instead of an answer',
                 cap * worst > cap, f'{cap:,} x {worst:.4f} = {cap * worst:,.0f} points, above the cap'))
    # (4) the scope is a LATTICE STATE, so a lattice this tier refuses does not drop out of the check that owed it.
    rows.append(('the scope is `Open` OR `Refused`, so answering a lattice does not remove it from the accounting\'s '
                 'subject', "st.startswith('Open') or st.startswith('Refused')" in s_scope_src(),
                 'degree_plan keeps a Refused lattice in scope'))
    return rows


def s_scope_src():
    import inspect
    return inspect.getsource(degree_plan)


def selftest_lock(rnd):
    """The lock in `append` and `load_jsonl` (the owner's ruling 2 after phase B', built before any pooled run of
    phase E).  Two things are shown, because one without the other proves nothing: the lock really EXCLUDES -- a
    writer in another process cannot append while a reader holds it -- and the window it closes really LOSES records
    when it is open.  The second is the code as it stood before phase B' added its size guard, run against the one
    interleaving that guard cannot see: a writer that appends between the reader's size check and its truncate."""
    import tempfile
    rows = []
    with tempfile.TemporaryDirectory() as td:
        # (1) the lock excludes.  The child is forked BEFORE the parent takes the lock (so it does not inherit it),
        #     and it says `ready` on a pipe immediately before calling `append`, so "the file did not grow" is about a
        #     writer that had reached the append and was blocked, not about a writer that had not started.
        #     The writer is a separate interpreter, not a fork: a forked child inherits this process's open file
        #     descriptions, so it could inherit the very lock the test is about.
        p = Path(td) / 'balls.jsonl'
        p.write_text('{"key":"a"}\n{"key":"b"}\n')
        before = p.stat().st_size
        ready, done_mark = Path(td) / 'ready', Path(td) / 'done'
        code = (f'import sys, time, pathlib\n'
                f'sys.path.insert(0, {str(ROOT / "tools")!r})\n'
                f'import fs61_census as C\n'
                f'pathlib.Path({str(ready)!r}).write_text("ready")\n'
                f't0 = time.time()\n'
                f'C.append(pathlib.Path({str(p)!r}), {{"key": "c"}})\n'
                f'pathlib.Path({str(done_mark)!r}).write_text(str(time.time() - t0))\n')
        with record_lock(p):
            child = subprocess.Popen([sys.executable, '-c', code])
            t0 = time.time()
            while not ready.exists() and time.time() - t0 < 60:
                time.sleep(0.02)
            reached = ready.exists()
            time.sleep(0.5)
            blocked = p.stat().st_size == before and child.poll() is None
            rows.append(('the lock EXCLUDES: a writer in another interpreter, stopped at its append, cannot grow the '
                         'file while a reader holds the lock', reached and blocked,
                         f'writer announced itself, then 0.5 s with the file at {p.stat().st_size} bytes against '
                         f'{before} before, and the writer {"alive" if child.poll() is None else "ALREADY FINISHED"} '
                         f'(pid {child.pid})'))
        child.wait(timeout=60)
        waited = float(done_mark.read_text()) if done_mark.exists() else -1.0
        keys = [r['key'] for r in read_records(p)]
        rows.append(('PLANT resolved: the moment the lock is released the writer lands, and nothing is lost',
                     keys == ['a', 'b', 'c'] and waited >= 0.4,
                     f'{keys}; the writer was blocked {waited:.2f} s inside `append`'))
        # (2) the window the size guard cannot close, and what it costs.  This is `load_jsonl`'s repair as it stood
        #     before phase B': read the length, then truncate to it.  The guard added at B' re-stats before the
        #     truncate; here the writer appends AFTER that check and BEFORE the truncate, which is the interleaving
        #     only a lock can exclude.
        q = Path(td) / 'unguarded.jsonl'
        q.write_text('{"key":"a"}\n{"key":"b"}\n{"key":"c"')
        read_len, tail_len = q.stat().st_size, len('{"key":"c"')
        assert q.stat().st_size == read_len                       # the guard's own check, passing
        with open(q, 'a') as f:                                   # the writer gets in here, after the check
            f.write('}\n{"key":"d"}\n')
        with open(q, 'r+b') as f:                                 # the repair, verbatim as it was
            f.truncate(read_len - tail_len)
        lost = [r['key'] for r in read_records(q)]
        rows.append(('PLANT (data loss): with no lock, a writer that appends between the size check and the truncate '
                     'loses every record it wrote -- the window the guard alone leaves open',
                     lost == ['a', 'b'], f'{lost} survive of a, b, c, d: two finished records destroyed'))
        # (3) the same interleaving through the driver's own path: the writer cannot be in that window at all.
        s = Path(td) / 'guarded.jsonl'
        s.write_text('{"key":"a"}\n{"key":"b"}\n{"key":"c"')
        ready2, done2 = Path(td) / 'ready2', Path(td) / 'done2'
        code2 = code.replace(str(p), str(s)).replace(str(ready), str(ready2)).replace(str(done_mark), str(done2)) \
                    .replace('"key": "c"', '"key": "d"')
        with record_lock(s):
            child2 = subprocess.Popen([sys.executable, '-c', code2])
            t0 = time.time()
            while not ready2.exists() and time.time() - t0 < 60:
                time.sleep(0.02)
            time.sleep(0.3)
            raw = s.read_bytes()                                  # the read the repair is measured against
            _repair_partial_line(s, len(raw), len('{"key":"c"'))  # safe: the writer is outside, holding nothing
        child2.wait(timeout=60)
        kept = [r['key'] for r in read_records(s)]
        rows.append(('PLANT resolved: through `record_lock` the same writer is outside the read-and-repair, so the '
                     'partial line is repaired AND the writer\'s record survives', kept == ['a', 'b', 'd'], f'{kept}'))
    return rows


SECTIONS = {'keys': selftest_keys, 'saturation': selftest_saturation, 'outdir': selftest_outdir,
            'barrier': selftest_barrier, 'predicted': selftest_predicted, 'atlas': selftest_atlas,
            'land': selftest_land, 'ladder': selftest_ladder, 'lock': selftest_lock,
            'phaseE': selftest_phaseE, 'degree': selftest_degree}


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


# ================================================================ A.5 the known witnesses' own lattices
WITNESS_PATHS = [(11, 'data/fs58/witness-11'), (23, 'data/fs58/witness-23'), (47, 'data/fs58/witness-47'),
                 (71, 'data/fs58/witness-71'), (95, 'data/fs58/witness-95'), (191, 'data/fs58/witness-191'),
                 (119, 'data/fs61/pricing/witness-119')]


def witness_lattice(D, path):
    """The Z-span of a witness's points, as a lattice of F^2 in the census's own coordinates (a, b, c, e)/M."""
    pts = json.loads((ROOT / path / 'witness.json').read_text())['points']
    M = 1
    for a, b, c, e, m in pts:
        M = M * m // math.gcd(M, m)
    W = [tuple(x * (M // m) for x in (a, b, c, e)) for a, b, c, e, m in pts]
    Mc, H = canonicalise(M, W)
    return Mc, H, len(pts), M


def quotient_screen(D, M, H, S, lattices=24, wall=30.0, seed=1, save=None):
    """FS-58's necessary filter, driven from a lattice rather than from a class spec: a 3-colourable finite quotient
    Cay(Lambda/L, S) with no generator in L gives a periodic 3-colouring of the whole Cayley graph, so no ball of the
    lattice can ever refuse.  Uses FS-58's frozen quotient_graph for the graph and verifies every model on every edge."""
    import numpy as np, random
    from pysat.solvers import Cadical195
    from fs58_chain import walled_solve
    B, coords, cov, mc = FS.reduce_pool(D, M, S)
    rnd = random.Random(seed)
    tried, colourable = 0, []
    Hs = [[[m if i == j else 0 for j in range(4)] for i in range(4)] for m in (3, 6, 8, 9, 10, 12)]
    while len(Hs) < lattices:
        diag = [rnd.choice([1, 2, 3, 4, 6, 8, 9]) for _ in range(4)]
        if math.prod(diag) < 8 or math.prod(diag) > 1296:
            continue
        Hs.append([[diag[i] if i == j else (rnd.randrange(diag[j]) if j > i else 0) for j in range(4)] for i in range(4)])
    for Hq in Hs:
        g = FS.quotient_graph(coords, Hq)
        if g is None:                                          # a generator lies in L: this quotient says nothing
            continue
        n, E, _ = g
        tried += 1
        sv = Cadical195()
        sv.append_formula([[3 * v + 1, 3 * v + 2, 3 * v + 3] for v in range(n)])
        for c in range(3):
            sv.append_formula(np.stack([-(3 * E[:, 0] + c + 1), -(3 * E[:, 1] + c + 1)], axis=1).tolist())
        r, dt = walled_solve(sv, [3 * 0 + 1], wall)
        if r:
            col = (np.array(sv.get_model()[:3 * n]).reshape(n, 3) > 0).argmax(axis=1)
            assert (col[E[:, 0]] != col[E[:, 1]]).all(), 'quotient model not proper'
            raw = col.astype('uint8').tobytes()
            sha = hashlib.sha256(raw).hexdigest()[:16]
            if save is not None:                               # kept so filter --reverify can re-check it on every edge
                save.mkdir(parents=True, exist_ok=True)
                with gzip.open(save / f'{sha}.bin.gz', 'wb') as fh:
                    fh.write(raw)
            colourable.append({'order': n, 'H': [list(r) for r in Hq], 'colouring_sha256': sha})
        sv.delete()
    return tried, colourable, cov, coords


def cmd_witness_lattices(quiet=False):
    """A.5 -- one of the plan's five halts: a finite graph with no proper 3-colouring cannot sit inside a lattice whose
    whole Cayley graph has one, so a `Colourable` verdict here is an instrument defect, not a discovery."""
    out = FS61 / 'witness-lattices.jsonl'
    done = load_jsonl(out)
    print(f'fs61 witness-lattices (A.5): the Z-span of each certified witness, filtered; {len(done)} on disk', flush=True)
    bad = []
    for D, path in WITNESS_PATHS:
        if str(D) in done:
            continue
        t0 = time.time()
        Mc, H, npts, Mraw = witness_lattice(D, path)
        key = key_of(Mc, H)
        S = saturation(D, Mc, H)
        f2 = bool(FS.forms_mod(FS.reduce_pool(D, Mc, S)[1], 2)) if len(H) >= 3 else False
        f3 = bool(FS.forms_mod(FS.reduce_pool(D, Mc, S)[1], 3)) if len(H) >= 3 else False
        tried, colourable, cov, coords = quotient_screen(D, Mc, H, S)
        state = ('Colourable (form mod 2)' if f2 else 'Colourable (form mod 3)' if f3 else
                 'Colourable (periodic colouring verified)' if colourable else
                 f'Open (no certificate among: forms mod 2, 3; {tried} quotients)')
        rec = {'key': str(D), 'D': D, 'path': path, 'points': npts, 'lattice_key': key, 'id': short_id(key),
               'M': Mc, 'rank': len(H), 'generators': len(S), 'covolume': cov, 'three_integral': Mc % 3 != 0,
               'forms_mod2': f2, 'forms_mod3': f3, 'quotients_tried': tried, 'quotients_colourable': colourable,
               'state': state, 'seconds': round(time.time() - t0, 1), 'machine': MACHINE,
               'claim_scope': 'verified model', 'result': 'PASS' if state.startswith('Open') else 'HALT'}
        append(out, rec)
        done[str(D)] = rec
        if rec['result'] != 'PASS':
            bad.append(D)
            defect(f'A.5 d={D}: the witness lattice is {state} -- a non-3-colourable finite graph cannot sit in a '
                   f'3-colourable lattice. HALT (plan rule 15).')
        print(f'  d={D:4d}: {npts} points -> lattice {short_id(key)} M={Mc} rank {len(H)} {len(S)} generators '
              f'cov {cov:.3g}; {tried} quotients, {len(colourable)} colourable -> {state} [{rec["seconds"]} s]', flush=True)
    fails = [r['D'] for r in done.values() if r['result'] != 'PASS']
    print(f'DONE witness-lattices: {len(done)} witnesses, {len(fails)} halts -> {rel(out)}', flush=True)
    return fails


# ================================================================ A.6 the killing-quotient table (D-Q)
def smith(Hm):
    """invariant factors of Z^4 / rowspace(H), by integer row/column reduction"""
    A = [list(r) for r in Hm]
    n, m = len(A), len(A[0])
    res = []
    r = c = 0
    while r < n and c < m:
        piv = None
        for i in range(r, n):
            for j in range(c, m):
                if A[i][j] and (piv is None or abs(A[i][j]) < abs(A[piv[0]][piv[1]])):
                    piv = (i, j)
        if piv is None:
            break
        i0, j0 = piv
        A[r], A[i0] = A[i0], A[r]
        for row in A:
            row[c], row[j0] = row[j0], row[c]
        again = True
        while again:
            again = False
            for i in range(r + 1, n):
                if A[i][c]:
                    q = A[i][c] // A[r][c]
                    for j in range(m):
                        A[i][j] -= q * A[r][j]
                    if A[i][c]:
                        A[r], A[i] = A[i], A[r]
                        again = True
            for j in range(c + 1, m):
                if A[r][j]:
                    q = A[r][j] // A[r][c]
                    for i in range(n):
                        A[i][j] -= q * A[i][c]
                    if A[r][j]:
                        for i in range(n):
                            A[i][c], A[i][j] = A[i][j], A[i][c]
                        again = True
        res.append(abs(A[r][c]))
        r += 1
        c += 1
    return res + [0] * (m - len(res))


def prime_support(n):
    out, k = [], 2
    while k * k <= n:
        if n % k == 0:
            out.append(k)
            while n % k == 0:
                n //= k
        k += 1
    if n > 1:
        out.append(n)
    return out


def cmd_dead_quotients(quiet=False):
    """A.6: the quotients that kill, read off FS-58's own qscreen records.  No new solving."""
    per = {}
    for f in sorted((ROOT / 'data' / 'fs58').glob('search-*/qscreen.jsonl')):
        D = int(f.parent.name.split('-')[1])
        for ln in f.read_text().splitlines():
            if not ln.strip():
                continue
            r = json.loads(ln)
            if 'colourable' not in r:                          # 'loop' rows: a generator lies in L, the quotient says nothing
                continue
            e = per.setdefault((D, r['pool']), {'tried': 0, 'colourable': []})
            e['tried'] += 1
            if r['colourable'] == 'SAT':
                e['colourable'].append((r['order'], r['H']))
    rows = []
    for (D, pool), e in sorted(per.items()):
        try:
            C, names = FS.spec_classes(D, pool)
            M, W = FS.pool_vectors(D, C, names)
            Mc, H = canonicalise(M, W)
            key, ti = key_of(Mc, H), Mc % 3 != 0
        except Exception:
            key, Mc, ti = None, None, None
        best = min(e['colourable']) if e['colourable'] else None
        row = {'key': f'{D}|{pool}', 'D': D, 'mod8': D % 8, 'pool': pool, 'lattice_key': key, 'M': Mc,
               'three_integral': ti, 'quotients_tried': e['tried'], 'quotients_colourable': len(e['colourable']),
               'dead': bool(e['colourable'])}
        if best:
            order, Hm = best
            sn = [s for s in smith(Hm) if s != 1]
            row.update({'min_order': order, 'min_H_diag': [Hm[i][i] for i in range(4)], 'smith': sn,
                        'prime_support': prime_support(order)})
        rows.append(row)
    # Reconciliation with FS-58's own per-pool verdicts, and with its README's count, which is by DISTINCT LATTICE
    # (decision C again): FS-58 reports "28 dead of 31 distinct lattices" from 32 non-bipartite lines.
    recon = []
    for f in sorted((ROOT / 'data' / 'fs58').glob('search-*/quotient-colourable.jsonl')):
        D = int(f.parent.name.split('-')[1])
        fs58 = {}
        for ln in f.read_text().splitlines():
            if ln.strip():
                r = json.loads(ln)
                fs58[r['key']] = r['verdict'].startswith('DEAD')
        mine = {r['pool']: r['dead'] for r in rows if r['D'] == D}
        shared = set(fs58) & set(mine)
        disagree = [k for k in shared if fs58[k] != mine[k]]
        bykey = {}
        for pool, isdead in fs58.items():
            r = next((x for x in rows if x['D'] == D and x['pool'] == pool), None)
            if r and r['lattice_key']:
                bykey.setdefault(r['lattice_key'], []).append(isdead)
        recon.append({'D': D, 'fs58_pools': len(fs58), 'fs58_dead_pools': sum(fs58.values()),
                      'distinct_lattices': len(bykey), 'distinct_dead': sum(1 for v in bykey.values() if any(v)),
                      'compared': len(shared), 'disagreements': disagree})
        for k in disagree:
            defect(f'A.6 d={D} {k}: FS-58 says dead={fs58[k]}, the qscreen records say dead={mine[k]}')
    out = FS61 / 'dead-quotients.jsonl'
    if out.exists():
        out.unlink()
    for r in rows:
        append(out, r)
    dead = [r for r in rows if r['dead']]
    by8 = {}
    for r in rows:
        k = (r['mod8'], bool(r['three_integral']))
        s = by8.setdefault(k, [0, 0])
        s[0] += 1
        s[1] += r['dead']
    sup = {}
    for r in dead:
        for p in r.get('prime_support', []):
            sup[p] = sup.get(p, 0) + 1
    ords = {}
    for r in dead:
        ords[r['min_order']] = ords.get(r['min_order'], 0) + 1
    L = ['# FS-61 A.6 — which quotients kill a lattice, from FS-58\'s own `qscreen.jsonl` (no new solving)', '',
         f'*Produced by `python3 tools/fs61_census.py dead-quotients`; records `data/fs61/dead-quotients.jsonl`.*', '',
         'A lattice is **dead** when some finite quotient `Cay(Λ/L, S)` with no generator in `L` is 3-colourable with a',
         'verified model: the colouring pulls back to a periodic 3-colouring of the whole Cayley graph, so no ball of',
         'that lattice can ever refuse three colours (FS-58\'s necessary filter, plan D-Q).', '',
         f'**{len(rows)} lattices screened over {len(set(r["D"] for r in rows))} fields; {len(dead)} dead.**', '',
         '| field | 3-integral | screened | dead |', '|---|---|---|---|']
    for (m8, ti), (n, k) in sorted(by8.items()):
        L.append(f'| d ≡ {m8} (mod 8) | {"yes" if ti else "no"} | {n} | {k} |')
    L += ['', '## The least-order killing quotient', '',
          '| order | how many dead lattices have it as their smallest | ',
          '|---|---|'] + [f'| {o} | {n} |' for o, n in sorted(ords.items())]
    L += ['', f'Prime support of the killing orders: ' +
          ', '.join(f'`{p}` in {n} of {len(dead)}' for p, n in sorted(sup.items())), '',
          '| d | pool | M | 3-int | tried | colourable | least order | Smith form | primes |', '|---|---|---|---|---|---|---|---|---|']
    for r in sorted(dead, key=lambda r: (r['D'], r.get('min_order', 0))):
        L.append(f'| {r["D"]} | `{r["pool"]}` | {r["M"]} | {"yes" if r["three_integral"] else "no"} | '
                 f'{r["quotients_tried"]} | {r["quotients_colourable"]} | {r["min_order"]} | '
                 f'{"×".join(map(str, r["smith"])) or "trivial"} | {", ".join(map(str, r["prime_support"]))} |')
    (FS61 / 'dead-quotients.md').write_text('\n'.join(L) + '\n')
    if not quiet:
        print(f'fs61 dead-quotients (A.6): {len(rows)} lattices screened over '
              f'{sorted(set(r["D"] for r in rows))}; {len(dead)} dead', flush=True)
        for D in sorted(set(r['D'] for r in rows)):
            n = [r for r in rows if r['D'] == D]
            print(f'  d={D:4d}: {sum(1 for r in n if r["dead"])} dead of {len(n)} screened', flush=True)
        print(f'  least killing order: {dict(sorted(ords.items()))}', flush=True)
        print(f'  prime support of those orders: {dict(sorted(sup.items()))}', flush=True)
        for r in recon:
            print(f'  reconcile d={r["D"]:4d}: FS-58 records {r["fs58_dead_pools"]} dead of {r["fs58_pools"]} pools = '
                  f'{r["distinct_dead"]} dead of {r["distinct_lattices"]} DISTINCT lattices; '
                  f'{r["compared"]} pools compared, {len(r["disagreements"])} disagreements', flush=True)
        print(f'DONE dead-quotients -> {rel(FS61 / "dead-quotients.md")}, {rel(out)}', flush=True)
    (FS61 / 'dead-quotients-reconcile.json').write_text(json.dumps(recon, indent=1) + '\n')
    return rows


# ================================================================ A.7 the rule behind the non-affine quotient colourings
#
# A solver's 3-colouring of Lambda/m*Lambda is one of many and hides the group that is really doing the work.  Theorem A's
# shape (row 57) is a homomorphism rho : Lambda -> A onto a SMALL finite abelian group, a set T = rho(S) with 0 not in T,
# and a proper 3-colouring of Cay(A, T); the kernel barrier (row 72) is the case A = F_3, T = F_3^x.  Rather than search
# sublattices, take a verified colouring c of Lambda/m*Lambda and compute its PERIOD GROUP
#       P = { t : c(x + t) = c(x) for every x },
# which is exact and cheap.  Then A = (Lambda/m*Lambda)/P is the smallest quotient THAT colouring factors through, rho is
# the projection, and c descends to Cay(A, rho(S)).  A_min over all colourings is at most this; one colouring already
# exposes the group.
def period_quotient(m, col):
    """the period subgroup of a colouring of (Z/m)^4 given as a flat array of length m^4, and the invariant factors of
    the quotient by it"""
    import numpy as np
    c = np.asarray(col, dtype=np.uint8).reshape(m, m, m, m)
    periods = []
    for t0 in range(m):
        for t1 in range(m):
            for t2 in range(m):
                for t3 in range(m):
                    if (t0 or t1 or t2 or t3) and np.array_equal(np.roll(c, (-t0, -t1, -t2, -t3), (0, 1, 2, 3)), c):
                        periods.append((t0, t1, t2, t3))
    L = [[m if i == j else 0 for j in range(4)] for i in range(4)] + [list(p) for p in periods]
    inv = [s for s in smith(L) if s != 1]
    return periods, inv, math.prod(inv) if inv else 1


def colour_quotient(m, coords, wall=30.0):
    """a verified proper 3-colouring of Cay((Z/m)^4, coords), or None"""
    import numpy as np
    from pysat.solvers import Cadical195
    from fs58_chain import walled_solve
    H = [[m if i == j else 0 for j in range(4)] for i in range(4)]
    g = FS.quotient_graph(coords, H)
    if g is None:
        return None, 'a generator lies in m*Lambda'
    n, E, _ = g
    sv = Cadical195()
    sv.append_formula([[3 * v + 1, 3 * v + 2, 3 * v + 3] for v in range(n)])
    for c in range(3):
        sv.append_formula(np.stack([-(3 * E[:, 0] + c + 1), -(3 * E[:, 1] + c + 1)], axis=1).tolist())
    r, dt = walled_solve(sv, [1], wall)
    if not r:
        sv.delete()
        return None, 'not 3-colourable' if r is False else 'unknown at the wall'
    col = (np.array(sv.get_model()[:3 * n]).reshape(n, 3) > 0).argmax(axis=1).astype(np.uint8)
    assert (col[E[:, 0]] != col[E[:, 1]]).all(), 'quotient model not proper'
    sv.delete()
    return col, None


A7_NAMED = [(59, 'q1+q5+30.1+30.2'), (35, 'q1+q5+6+30'), (11, 'q1+6+30.2')]
A7_MODULI = (3, 4, 6, 8, 9, 12)


def cmd_minimal_quotient(nsample=4, quiet=False):
    """A.7: expose the group behind each dead lattice's periodic 3-colouring, over a sweep of moduli.

    WHAT IS AND IS NOT MEASURED (G21).  For each (lattice, m) this takes ONE solver colouring of Lambda/m*Lambda and
    computes the minimal quotient THAT colouring factors through.  The true A_min, over all colourings and all m, is at
    most what is reported: every order below is an UPPER bound on A_min, so "A_min is large" is not established by a
    large reading, while "A_min is small" is established by a small one."""
    out = FS61 / 'minimal-quotients.jsonl'
    done = load_jsonl(out)
    dead = [json.loads(l) for l in open(FS61 / 'dead-quotients.jsonl')] if (FS61 / 'dead-quotients.jsonl').exists() else []
    sample = ([(r['D'], r['pool']) for r in dead if r['dead'] and r['D'] == 167][:nsample]
              + [(r['D'], r['pool']) for r in dead if r['dead'] and r['D'] == 23][:nsample])
    todo = list(A7_NAMED) + sample
    print(f'fs61 minimal-quotient (A.7): {len(todo)} dead lattices x moduli {A7_MODULI}; for each, a verified '
          f'3-colouring of Lambda/m*Lambda, its period group, and the quotient A it factors through', flush=True)
    rows = []
    for D, spec in todo:
        C, names = FS.spec_classes(D, spec)
        M, W = FS.pool_vectors(D, C, names)
        Mc, Hl = canonicalise(M, W)
        S = saturation(D, Mc, Hl)
        B, coords, cov, mc = FS.reduce_pool(D, Mc, S)
        best = None
        for m in A7_MODULI:
            key = f'{D}|{spec}|{m}'
            if key in done:
                rec = done[key]
            else:
                t0 = time.time()
                col, why = colour_quotient(m, coords, wall=20.0)
                if col is None:
                    rec = {'key': key, 'D': D, 'spec': spec, 'm': m, 'colourable': False, 'why': why,
                           'seconds': round(time.time() - t0, 1), 'machine': MACHINE, 'claim_scope': 'verified model'}
                else:
                    per, inv, order = period_quotient(m, col)
                    p3 = 1
                    for t in inv:
                        while t % 3 == 0:
                            p3 *= 3
                            t //= 3
                    rec = {'key': key, 'D': D, 'spec': spec, 'm': m, 'colourable': True, 'lattice_key': key_of(Mc, Hl),
                           'three_integral': Mc % 3 != 0, 'generators': len(S), 'covolume': cov,
                           'A_invariant_factors': inv, 'A_order': order, 'A_three_part': p3,
                           'T_size': len({_coset(c, per, m) for c in coords}), 'periods': len(per) + 1,
                           'seconds': round(time.time() - t0, 1), 'machine': MACHINE, 'claim_scope': 'verified model'}
                append(out, rec)
                done[key] = rec
            if rec.get('colourable'):
                if best is None or rec['A_order'] < best['A_order']:
                    best = rec
                if not quiet:
                    print(f"  d={D:4d} {spec:22s} m={rec['m']:2d}: A = "
                          f"{' x '.join('Z/' + str(t) for t in rec['A_invariant_factors']) or 'trivial'} "
                          f"of order {rec['A_order']}, 3-part {rec['A_three_part']}, |T| = {rec['T_size']}", flush=True)
        if best:
            rows.append(best)
    if rows:
        orders = sorted(r['A_order'] for r in rows)
        p3s = sorted(set(r['A_three_part'] for r in rows))
        print(f'  smallest quotient found per lattice: {orders}', flush=True)
        print(f'  their 3-parts: {p3s}', flush=True)
        common = max(set(orders), key=orders.count)
        print(f'  most common order {common}: {orders.count(common)} of {len(orders)} lattices '
              f'({orders.count(common) / len(orders):.0%}) -- the gate asks for 90%', flush=True)
    print(f'DONE minimal-quotient: {len(rows)} lattices -> {rel(out)}', flush=True)
    return rows


def _coset(c, periods, m):
    """a canonical name for the coset of c modulo the period group (the least element of c + P)"""
    best = tuple(x % m for x in c)
    for p in periods:
        t = tuple((c[i] + p[i]) % m for i in range(4))
        if t < best:
            best = t
    return best


# ================================================================ phase B: the census scan and the table
FAMILY_500 = [d for d in range(2, 500) if d % 12 == 11 and squarefree(d)]


def cmd_census_field(D, tid='1', jobs=16, budget=7200, quiet=False):
    """One field, tier 1, in the plan's order: lattices -> filter (top-down, inheritance) -> scan the Open lattices
    bottom-up.  Resumable at every unit; re-running the identical command continues."""
    t0 = time.time()
    tier = tier_def(tid)
    lat, e1 = cmd_lattices(D, tid, jobs=jobs, quiet=True)
    filt, e2 = cmd_filter(D, tid, quiet=True)
    print(f'fs61 census d={D} tier={tid}: {len(lat)} lattices -> '
          + ', '.join(f'{v} {k}' for k, v in sorted(collections.Counter(r['state'] for r in filt.values()).items())),
          flush=True)
    balls, e3 = cmd_scan(D, tid, jobs=jobs, quiet=True, budget=budget)
    # pass two: R = 1.8 only for the Open lattices whose R = 1.5 ball was colourable (the plan's order)
    r0, r1 = tier['radii']
    second = [k for k, f in filt.items()
              if f['state'].startswith('Open')
              and balls.get(f'{k}|ball{r0}', {}).get('verdict') == 'Colourable (colouring verified)']
    for k in second:
        cmd_scan(D, tid, only_key=k, radii=[r1], jobs=1, quiet=True)
    balls = load_jsonl(field_dir(D) / 'balls.jsonl')
    # onset radii, only for lattices that refused, at the short wall the plan prescribes
    refusing = sorted({b['lattice'] for b in balls.values() if b['verdict'].startswith('Refused')})
    for k in refusing:
        for R in (1.2, 1.0):
            if f'{k}|ball{R}' not in balls:
                cmd_scan(D, tid, only_key=k, radii=[R], jobs=1, quiet=True, wall_override=120.0)
    balls = load_jsonl(field_dir(D) / 'balls.jsonl')
    # refusal is inherited upward: a Refused ball closes every lattice above it
    prop = propagate_refusal(D, filt, balls)
    v = collections.Counter(b['verdict'] for b in balls.values())
    asked = sum(v.values()) - v['Over cap (not asked)']
    print(f'  d={D}: {len(balls)} ball records, {asked} asked -> '
          + ', '.join(f'{n} {k}' for k, n in sorted(v.items()))
          + f'; {prop} lattices Refused (inherited); {time.time() - t0:.0f} s', flush=True)
    return e1 + e2 + e3


def propagate_refusal(D, filt, balls):
    """A ball of Lambda that refuses three colours is an induced subgraph of every Lambda' containing Lambda, so the
    refusal is inherited UPWARD.  Recorded as its own certificate kind with the key it came from."""
    lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
    pairs = [(json.loads(l)['sub'], json.loads(l)['sup'])
             for l in open(field_dir(D) / 'poset.jsonl')] if (field_dir(D) / 'poset.jsonl').exists() else []
    refusing = {b['lattice'] for b in balls.values() if b['verdict'].startswith('Refused')}
    out = field_dir(D) / 'filter.jsonl'
    n = 0
    for sub, sup in pairs:
        if sub in refusing and sup in filt and not filt[sup]['state'].startswith('Refused'):
            if filt[sup]['state'].startswith('Colourable'):
                continue                                        # B.1b will name this pair; do not paper over it
            rec = dict(filt[sup], state=f'Refused (inherited from {lat[sub]["id"]})', inherited_from=sub,
                       certificate={'kind': 'refusal', 'from': sub}, claim_scope='solver claim')
            append(out, rec)
            filt[sup] = rec
            n += 1
    for key in {b['lattice'] for b in balls.values() if b['verdict'].startswith('Refused')}:
        if key in filt and not filt[key]['state'].startswith('Refused'):
            rec = dict(filt[key], state='Refused (solver claim)', certificate={'kind': 'ball'},
                       claim_scope='solver claim')
            append(out, rec)
            filt[key] = rec
            n += 1
    return n


# ================================================================ phase B': tier 1b, the radius ladder
#
# The owner's re-plan after phase B, ruling 2.  Tier 1 asked R = 1.5 of every rank-4 Open lattice whose ball fitted the
# 600,000-point cap, and left the rest unasked: 77 of the family's 110 rank-4 Open lattices have an R = 1.5 record
# reading `Over cap (not asked)`, and thirteen fields asked NOTHING for that reason alone.  A ball is a bidisc, so it
# holds points in proportion to R^4: the same lattice at R = 1.2 holds 0.41 of them, at R = 1.0 holds 0.20.  Every
# refusal anywhere on record sits at a radius between 1.0 and 1.5, so the ladder is asking the same question lower down,
# under the SAME cap and the SAME wall.  Tier 1's definition, records and verdicts do not move: this is a new tier id.
#
# TIER_ORDER is a code constant and NOT part of any tier's definition -- putting it in tiers.json would change tier 1's
# `_sha256`, which 343 committed ball records carry.
TIER_ORDER = {'1': 10, '1b': 15, '1c': 17, '2l': 18, '2': 20}
ONSET_WALL = 120.0          # phase B's wall for a follow-up ask below a refusal: the band under the threshold stalls

# Which SHALLOWER tiers' ball records a tier may count as its own work.  Tier 2l's lattices (NMAX = 420) contain tier
# 1's (NMAX = 180), so it meets balls tiers 1, 1b and 1c already asked under the same cap and the same wall; asking
# them again would buy nothing and would overwrite records the census's numbers are quoted from.  No other tier reuses
# anything: tier 1b's scope is lattices whose tier-1 R = 1.5 record is `Over cap`, so at its rungs no shallower record
# can exist, and the plant that a tier-1 record must not count as tier-1b work still fires.
TIER_REUSES = {'2l': ('1', '1b', '1c')}


def _tier_counts(rec, tid):
    """Is this record's TIER one whose work counts as tier `tid`'s?  The relationship only -- whether the record is
    also settled at this tier's budget is `_settled_at`, and the two are kept apart because the accounting check asks
    the first question and the runner asks both.  See `_record_answers` for why another tier's record may count:
      * a DEEPER tier re-asked the very same ball with more budget, so its record shadows the earlier one under the
        same key (tier 1c over tier 1b: same lattice, same radius, a 3,600 s wall in place of 600 s).  The shallower
        tier's accounting must accept that, or it reports a gap exactly where the question has been answered better;
      * a tier that REUSES a shallower tier's lattices meets balls that tier already asked (TIER_REUSES).
    A record from a shallower tier that does neither is not this tier's work and does not count."""
    t = str(rec.get('tier'))
    return t == str(tid) or TIER_ORDER.get(t, -1) > TIER_ORDER[str(tid)] or t in TIER_REUSES.get(str(tid), ())


def _record_answers(rec, tid, tier):
    """Does this record answer tier `tid`'s question at its rung, so the tier neither re-asks it nor reports a gap?
    Its tier must count (`_tier_counts`) AND it must be settled at this tier's budget (`_settled_at`, FS-58's rule:
    an `Unknown` is re-asked only at a larger wall, an `Over cap` only at a larger cap)."""
    return _tier_counts(rec, tid) and _settled_at(rec, tier['point_cap'], tier['solve_wall'])


def tier_nmax_scope(lat_rec, tier):
    """Is this lattice inside `tier`'s lattice set?  A lattice record carries the tier that first built it, and a
    tier's set is decided by its NMAX, so a tier owns every lattice a tier of no greater NMAX produced.  Without this
    a finer tier's new lattices would be counted against a shallower tier's accounting, which never asked for them."""
    other = tiers().get(str(lat_rec.get('tier')))
    return True if other is None else other['nmax'] <= tier['nmax']   # an unknown tier is counted, never dropped


def tiers_upto(tid):
    """Every tier at or above `tid` in depth, shallowest first -- the tiers whose accounting a table at `tid` must check."""
    if str(tid) not in TIER_ORDER:
        die(f'tier {tid} has no depth order; known: {sorted(TIER_ORDER)}')
    return [t for t in sorted(TIER_ORDER, key=TIER_ORDER.get) if TIER_ORDER[t] <= TIER_ORDER[str(tid)] and t in tiers()]


def deepest_tier_present(fields=None):
    """The deepest tier that has ball records anywhere in the family: the tier the derived table is AT.  Computed from
    the records so the table cannot claim a depth nobody ran."""
    seen = {'1'}
    for D in (fields or FAMILY_500):
        for b in load_jsonl(field_dir(D) / 'balls.jsonl').values():
            t = str(b.get('tier'))
            if t in TIER_ORDER:
                seen.add(t)
    return max(seen, key=TIER_ORDER.get)


def ladder_plan(D, tid='1b'):
    """The ladder's scope and its intended rung sequence for one field.  ONE definition, called by the runner AND by
    `table --check`, so the check re-derives the rule from the covolume and the cap instead of trusting the run that
    wrote the records.  Returns (plan, out_of_scope), the second mapping a key to the reason in words."""
    tier = tier_def(tid)
    if 'ladder_radii' not in tier:
        die(f'tier {tid} defines no radius ladder (ladder_radii)')
    base_r, cap = tier['base_radius'], tier['point_cap']
    lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
    filt = load_jsonl(field_dir(D) / 'filter.jsonl')
    balls = load_jsonl(field_dir(D) / 'balls.jsonl')
    plan, out = {}, {}
    for key, f in filt.items():
        if not f['state'].startswith('Open'):
            continue
        r = lat.get(key)
        if r is None:
            out[key] = 'no lattice record'
            continue
        if r['rank'] != 4:
            out[key] = f'rank {r["rank"]}: lattices below rank 4 are filtered and never scanned (plan M1.7)'
            continue
        if not tier_nmax_scope(r, tier):
            out[key] = f'built at tier {r.get("tier")}, whose NMAX is above this tier\'s {tier["nmax"]}'
            continue
        b = balls.get(f'{key}|ball{base_r}')
        if b is None:
            out[key] = f'no tier-{tier["deepens"]} R={base_r} record -- a gap B.1 reports, not a ladder question'
            continue
        if b['verdict'] != 'Over cap (not asked)':
            out[key] = f'asked at R={base_r}: {b["verdict"]}'
            continue
        cov = r['covolume']
        rungs = [(R, predicted_points(cov, R)) for R in tier['ladder_radii']]
        plan[key] = {'key': key, 'id': r['id'], 'D': D, 'lattice': r, 'rungs': rungs,
                     'base_radius': base_r, 'base_points': b.get('points'),
                     'askable': [(R, p) for R, p in rungs if p is not None and p <= cap]}
    return plan, out


def _settled_at(rec, cap, wall):
    """FS-58's rule, kept: an Unknown is re-asked only at a larger wall, an Over cap only at a larger cap."""
    if rec['verdict'] == 'Unknown (budget)':
        return rec.get('wall', 0) >= wall
    if rec['verdict'] == 'Over cap (not asked)':
        return rec.get('cap', 0) >= cap
    return True


def ladder_status(entry, balls, tid, tier=None):
    """Is one lattice's ladder complete, and why?  (ok, reason).  `ok` False is an accounting defect: the tier said it
    would ask this rung and there is no record of it."""
    key, tid = entry['key'], str(tid)
    tier = tier or tier_def(tid)

    def rec_at(R):
        rec = balls.get(f'{key}|ball{R}')
        return rec if rec is not None and _tier_counts(rec, tid) else None

    if not entry['askable']:
        R, p = entry['rungs'][0]
        rec = rec_at(R)
        if rec is None:
            return False, f'no tier-{tid} record at R={R}, where the rule writes one over-cap record'
        if rec['verdict'] != 'Over cap (not asked)':
            return False, f'R={R} is over cap by prediction ({p} points) yet its record says {rec["verdict"]}'
        return True, 'Over cap (not asked) at every rung, by prediction'
    for i, (R, p) in enumerate(entry['askable']):
        rec = rec_at(R)
        if rec is None:
            which = 'the rung the rule selects' if i == 0 else f'the rung below R={entry["askable"][i - 1][0]}'
            return False, f'no tier-{tid} record at R={R} (predicted {p} points, {which})'
        if rec['verdict'] == 'Over cap (not asked)':
            by = rec.get('over_cap_by')
            if by != 'exact':
                return False, (f'R={R} fits the cap by prediction ({p} points) yet its record is over cap '
                               f'by {by!r}, which the rule cannot produce at an askable rung')
            if i + 1 < len(entry['askable']):
                continue                                        # the exact count overflowed: descend one rung
            return True, f'Over cap (not asked) at R={R}, by the exact count, at the last rung'
        return True, f'{rec["verdict"]} at R={R}'
    return True, 'every askable rung over cap by its exact count'


def _ladder_work(D, entry, R, pred, tid, tsha, cap, wall):
    """One ball for `_ball_worker`, with the generators re-derived from the canonical key and checked against the
    lattice record's `generators_sha256` -- never read from a cache."""
    M, H = parse_key(entry['key'])
    gens = [list(v) for v in saturation(D, M, H)]
    if sha_vectors([tuple(v) for v in gens]) != entry['lattice']['generators_sha256']:
        die(f'lattice {entry["id"]}: the saturation of its key does not match the recorded generators_sha256', 1)
    return (D, entry['key'], gens, R, cap, wall, tid, tsha, pred)


def _ladder_decorate(rec, entry, reason, chosen):
    """B'.1: the record says which rungs the formula predicted, which one it selected and why, and -- once the ball is
    built -- the actual count beside the prediction, with A.8's 15 % bound applied to the pair."""
    rec = dict(rec)
    rec['ladder_rungs'] = {str(R): p for R, p in entry['rungs']}
    rec['ladder_rung_chosen'] = chosen
    rec['ladder_rung_reason'] = reason
    rec['base_radius'] = entry['base_radius']
    rec['base_verdict'] = 'Over cap (not asked)'
    p, a = rec.get('predicted_points'), rec.get('points')
    if isinstance(a, int) and isinstance(p, int) and p:
        rec['actual_over_predicted'] = round(a / p, 4)
        rec['within_A8_bound'] = abs(a / p - 1) <= 0.15
    return rec


def cmd_ladder(D, tid='1b', jobs=16, quiet=False, budget=None, show_plan=False):
    """Phase B': the radius ladder for one field.  Resume = re-run the identical command; every rung is its own JSONL
    record, so a kill at any instant redoes at most the balls in flight."""
    import multiprocessing as mp
    tier = tier_def(tid)
    cap, wall = tier['point_cap'], tier['solve_wall']
    plan, out = ladder_plan(D, tid)
    out_file = field_dir(D) / 'balls.jsonl'
    done = load_jsonl(out_file)
    n_ask = sum(1 for e in plan.values() if e['askable'])
    if not quiet or show_plan:
        print(f'fs61 ladder d={D} tier={tid}: {len(plan)} rank-4 Open lattices in scope (over cap at '
              f'R={tier["base_radius"]}), {len(out)} out of scope; {n_ask} with a rung under the {cap}-point cap; '
              f'rungs {tier["ladder_radii"]}, wall {wall} s', flush=True)
    if show_plan:
        for key in sorted(plan, key=lambda k: (plan[k]['askable'] or [(0, 1 << 60)])[0][1]):
            e = plan[key]
            rung = f'R={e["askable"][0][0]} ({e["askable"][0][1]} pts)' if e['askable'] else 'none under the cap'
            print(f'  {e["id"]}  rungs ' + ', '.join(f'{R}:{p}' for R, p in e['rungs']) + f'  -> {rung}', flush=True)
        for key, why in sorted(out.items()):
            print(f'  (out of scope) {short_id(key)}  {why}', flush=True)
        print(f'DONE ladder --plan d={D}: {n_ask} balls the rule would ask', flush=True)
        return []
    counts, errs, t0, outside = collections.Counter(), [], time.time(), []
    # (a) lattices with no rung under the cap: one over-cap record each, no enumeration and no solver
    for key in sorted(plan):
        e = plan[key]
        if e['askable']:
            continue
        R, p = e['rungs'][0]
        k = f'{key}|ball{R}'
        if k in done and _record_answers(done[k], tid, tier):
            continue
        rec = _ladder_decorate({'key': k, 'lattice': key, 'id': e['id'], 'D': D, 'shape': 'ball', 'R': R, 'tier': tid,
                                'tier_sha256': tier['_sha256'], 'machine': MACHINE, 'wall': wall, 'cap': cap,
                                'predicted_points': p, 'verdict': 'Over cap (not asked)',
                                'over_cap_by': 'prediction', 'claim_scope': 'float reading'},
                               e, 'no rung fits the cap by prediction', None)
        append(out_file, rec)
        done[k] = rec
        counts[rec['verdict']] += 1
    # (b) the ladder proper: walk the rungs, descending only when a rung's EXACT count overflows the cap
    for _ in range(len(tier['ladder_radii']) + 1):
        work, meta = [], {}
        for key in sorted(plan):
            e = plan[key]
            i = 0
            while i < len(e['askable']):
                R, _p = e['askable'][i]
                prev = done.get(f'{key}|ball{R}')
                if prev is None or not _record_answers(prev, tid, tier):
                    break
                if prev['verdict'] == 'Over cap (not asked)' and prev.get('over_cap_by') == 'exact':
                    i += 1
                    continue
                i = None
                break
            if i is None or i >= len(e['askable']):
                continue
            R, p = e['askable'][i]
            reason = ('the first rung whose prediction fits the cap' if i == 0 else
                      f'descended: the exact count at R={e["askable"][i - 1][0]} exceeded the cap')
            work.append(_ladder_work(D, e, R, p, tid, tier['_sha256'], cap, wall))
            meta[f'{key}|ball{R}'] = (e, reason, R)
        if not work:
            break
        with mp.get_context('fork').Pool(min(jobs, len(work))) as P:
            for rec, model in P.imap_unordered(_ball_worker, work):
                e, reason, R = meta[rec['key']]
                rec = _ladder_decorate(rec, e, reason, R)
                if model is not None:
                    with gzip.open(model_path(D, rec['model_sha256']), 'wb') as f:
                        f.write(model)
                append(out_file, rec)
                done[rec['key']] = rec
                counts[rec['verdict']] += 1
                if rec['verdict'] == 'ERROR':
                    errs.append((rec['key'], rec.get('error')))
                    defect(f'ladder d={D} {rec["key"]}: {rec.get("error")}')
                if rec.get('within_A8_bound') is False:
                    outside.append(rec)
                    print(f'  NOTE d={D} {rec["id"]} R={R}: {rec["points"]} points against {rec["predicted_points"]} '
                          f'predicted, ratio {rec["actual_over_predicted"]} -- outside A.8\'s 15 % bound, a FINDING '
                          f'(the owner\'s B\'.1), not a defect', flush=True)
                if rec['verdict'] in ('Refused (solver claim)', 'Unknown (budget)', 'Over cap (not asked)') and not quiet:
                    print(f'  {rec["id"]} R={R} {rec.get("points")} points {rec.get("edges", "-")} edges '
                          f'-> {rec["verdict"]} [{rec.get("solve_seconds", "-")} s]', flush=True)
                if budget and time.time() - t0 > budget:
                    print(f'  budget {budget} s reached: stopping (resume = re-run this command)', flush=True)
                    P.terminate()
                    break
        if budget and time.time() - t0 > budget:
            break
    # (c) the bonus ask below a refusal, as phase B's onset radii were: a smaller refusing ball for phase C
    for key in sorted(plan):
        e = plan[key]
        for i, (R, _p) in enumerate(e['askable']):
            rec = done.get(f'{key}|ball{R}')
            if rec is None or not _tier_counts(rec, tid) or not rec['verdict'].startswith('Refused'):
                continue
            if i + 1 >= len(e['askable']):
                continue
            R2, p2 = e['askable'][i + 1]
            if f'{key}|ball{R2}' in done:
                continue
            w = _ladder_work(D, e, R2, p2, tid, tier['_sha256'], cap, ONSET_WALL)
            r2, model = _ball_worker(w)
            r2 = _ladder_decorate(r2, e, f'onset follow-up below the refusal at R={R}', R2)
            if model is not None:
                with gzip.open(model_path(D, r2['model_sha256']), 'wb') as f:
                    f.write(model)
            append(out_file, r2)
            done[r2['key']] = r2
            counts[r2['verdict']] += 1
            print(f'  {r2["id"]} R={R2} (onset) {r2.get("points")} points -> {r2["verdict"]}', flush=True)
    # (d) refusal is inherited upward
    filt = load_jsonl(field_dir(D) / 'filter.jsonl')
    prop = propagate_refusal(D, filt, load_jsonl(out_file))
    if not quiet:
        print(f'DONE ladder d={D}: ' + (', '.join(f'{v} {k}' for k, v in sorted(counts.items())) or 'nothing to ask')
              + f'; {prop} lattices Refused (inherited); {len(outside)} outside A.8; {len(errs)} defects; '
              f'{time.time() - t0:.0f} s', flush=True)
    return errs


def ladder_pooled_pass(fields, tid, jobs, budget=None):
    """ONE pool over the whole family.  A pool opened inside a field is one to three workers wide, because that is how
    many balls a field has to ask -- measured 2026-09-20 on a sixteen-core machine: d = 11 used 2 workers, d = 23 used
    6, d = 47 used 3, and the machine sat idle for the rest.  This pass puts the FIRST askable rung of every in-scope
    lattice at every field into a single pool; the per-field pass then runs afterwards, finds them settled, and does
    only the cheap remainder (over-cap records, any descent, the onset follow-ups, the refusal propagation).
    `meta` is keyed by (field, ball) and never by the ball key alone: 154 of 817 lattice shapes are shared between
    fields (phase A finding 2), so the bare key collides across them."""
    import multiprocessing as mp
    tier = tier_def(tid)
    cap, wall = tier['point_cap'], tier['solve_wall']
    work, meta = [], {}
    for D in fields:
        plan, _ = ladder_plan(D, tid)
        done = load_jsonl(field_dir(D) / 'balls.jsonl')
        for key in sorted(plan):
            e = plan[key]
            if not e['askable']:
                continue
            R, p = e['askable'][0]
            prev = done.get(f'{key}|ball{R}')
            if prev is not None and _record_answers(prev, tid, tier):
                continue
            work.append(_ladder_work(D, e, R, p, tid, tier['_sha256'], cap, wall))
            meta[(D, f'{key}|ball{R}')] = (e, 'the first rung whose prediction fits the cap', R)
    work.sort(key=lambda w: w[8])
    width = min(jobs, len(work))
    print(f'fs61 ladder pooled pass tier={tid}: {len(work)} balls over {len({w[0] for w in work})} fields in ONE '
          f'pool {width} workers wide (a per-field pool would be 1-6); {sum(w[8] for w in work):,} points predicted '
          f'in total, largest {max((w[8] for w in work), default=0):,}; wall {wall} s each', flush=True)
    if not work:
        return []
    errs, counts, outside, t0 = [], collections.Counter(), [], time.time()
    with mp.get_context('fork').Pool(width) as P:
        for rec, model in P.imap_unordered(_ball_worker, work):
            D = rec['D']
            e, reason, R = meta[(D, rec['key'])]
            rec = _ladder_decorate(rec, e, reason, R)
            if model is not None:
                with gzip.open(model_path(D, rec['model_sha256']), 'wb') as f:
                    f.write(model)
            append(field_dir(D) / 'balls.jsonl', rec)
            counts[rec['verdict']] += 1
            if rec['verdict'] == 'ERROR':
                errs.append((rec['key'], rec.get('error')))
                defect(f'ladder d={D} {rec["key"]}: {rec.get("error")}')
            if rec.get('within_A8_bound') is False:
                outside.append(rec)
                print(f'  NOTE d={D} {rec["id"]} R={R}: {rec["points"]} points against {rec["predicted_points"]} '
                      f'predicted, ratio {rec["actual_over_predicted"]} -- outside A.8\'s 15 % bound, a FINDING '
                      f'(the owner\'s B\'.1), not a defect', flush=True)
            if rec['verdict'] != 'Colourable (colouring verified)':
                print(f'  d={D} {rec["id"]} R={R} {rec.get("points")} points {rec.get("edges", "-")} edges '
                      f'-> {rec["verdict"]} [{rec.get("solve_seconds", "-")} s]', flush=True)
            if budget and time.time() - t0 > budget:
                print(f'  budget {budget} s reached: stopping (resume = re-run this command)', flush=True)
                P.terminate()
                break
    print(f'DONE ladder pooled pass: ' + ', '.join(f'{v} {k}' for k, v in sorted(counts.items()))
          + f'; {len(outside)} outside A.8; {len(errs)} defects; {time.time() - t0:.0f} s', flush=True)
    return errs


def cmd_ladder_all(fields=None, tid='1b', jobs=16, budget=None):
    """Phase B' over the whole family, resumable by re-running the identical command: one pool over every field's
    first rung, then the cheap per-field remainder."""
    fields = fields or FAMILY_500
    state = FS61 / f'ladder-progress-{tid}.jsonl'
    done = load_jsonl(state)
    scope = {}
    for D in fields:
        plan, _ = ladder_plan(D, tid)
        if plan:
            scope[D] = sum(1 for e in plan.values() if e['askable'])
    print(f'fs61 ladder-all tier={tid}: {len(fields)} fields, {len(scope)} with a lattice in scope, '
          f'{sum(scope.values())} balls the rule would ask; {len(done)} fields already complete. '
          f'Resume = re-run this identical command.', flush=True)
    t0 = time.time()
    errs = ladder_pooled_pass([D for D in scope if str(D) not in done], tid, jobs, budget=budget)
    for D in sorted(scope, key=lambda d: (scope[d] == 0, d)):
        if str(D) in done:
            continue
        t1 = time.time()
        e = cmd_ladder(D, tid, jobs=jobs, budget=budget)
        append(state, {'key': str(D), 'd': D, 'seconds': round(time.time() - t1, 1), 'defects': len(e),
                       'tier': tid, 'machine': MACHINE})
        errs += e
    print(f'DONE ladder-all: {len(scope)} fields, {(time.time() - t0) / 60:.1f} min, {len(errs)} defects', flush=True)
    return errs


# ================================================================ phase E.1a: tier 1c, the degree-targeted ask
#
# The owner's revision of E.1a, 2026-09-20, on a measurement of his that I re-derived before acting on it.  Across
# the 734 asked ball records carrying both a point count and an edge count, what separates a decided ball from an
# undecided one is not its SIZE but its AVERAGE DEGREE, 2*edges/points:
#
#     degree   <4    4-6   6-8   8-10  10-14  14-20  >=20
#     Colour.  87    183   106   112    68     44     20
#     Unknown   0     39    14    11     6      0      0
#     Refused   0      0     3     6    13     15      7
#
# No ball below average degree 6.595 has ever refused (44 refusing balls); the 70 undecided ones sit at median degree
# 5.52.  Among balls of at least 200,000 points, all 43 at degree >= 14 decided -- 28 coloured, 15 refused, none
# undecided, the slowest in 259 s.  So the `Unknown`s are the classic hardness peak of sparse random-ish graphs, on
# the colourable side wherever they were decided, and the radius ladder of tier 1b stepped DOWN in degree: into that
# peak, or below the floor at which anything refuses.  This tier aims at degree instead of at size.
#
# THE LAW.  A ball of radius R on a lattice holding g unit vectors has predicted average degree g*phi(R)^2, where
# phi(R) is the area fraction a radius-R disc shares with its unit translate -- squared, because a ball here is a
# bidisc, one disc per real embedding.  Each of a ball's points has g candidate neighbours and each lands inside the
# ball with probability phi(R)^2.  Control: over the 734 records the ratio observed/predicted has median 1.0000 and
# range 0.715-1.184, 0 outside +-30% (`selftest --section degree`).
def degree_phi(R):
    """The area fraction a disc of radius R shares with its unit translate; 0 below R = 1/2, rising to 1 - 1/(pi R)."""
    if R <= 0.5:
        return 0.0
    return (2 * R * R * math.acos(1 / (2 * R)) - 0.5 * math.sqrt(4 * R * R - 1)) / (math.pi * R * R)


def degree_of(g, R):
    """The predicted average degree of the radius-R ball on a lattice with g unit vectors."""
    return g * degree_phi(R) ** 2


def radius_for_degree(g, target, hi=12.0):
    """The radius at which the predicted degree reaches `target`, or None when the lattice cannot reach it at any
    radius -- degree rises to g and no further, so a lattice with g <= target never gets there."""
    if degree_of(g, hi) < target:
        return None
    lo = 0.5 + 1e-9
    for _ in range(200):
        mid = (lo + hi) / 2
        if degree_of(g, mid) < target:
            lo = mid
        else:
            hi = mid
    return hi


def radius_for_points(cov, n):
    """The radius whose predicted points are exactly n (the bidisc law inverted)."""
    return (n * cov / math.pi ** 2) ** 0.25


# The predicted point count is a float law and the cap is enforced on the EXACT count, so a rule that aims at the cap
# overflows it about half the time -- which is not a near miss but a lost ask: `piece` returns nothing and the record
# reads `Over cap (not asked)`.  Found by running the first ball of this tier, which is what it cost.  The rule
# therefore aims at cap / OVERSHOOT, where OVERSHOOT is the largest actual/predicted ratio ever recorded here on a
# ball of at least 100,000 points (1.1078, over 327 such balls; on the fine lattices this tier actually asks, phase
# B' measured 0.9982-1.0094 over 37).  It is a margin on the RULE; the cap itself is unchanged, and an exact
# overflow is still recorded honestly if one happens.
DEGREE_OVERSHOOT = 1.11


def degree_plan(tid='1c', fields=None, nmax_scope=True):
    """One item per in-scope lattice: which radius the degree rule asks, by which arm, and what it predicts.

    Pure apart from reading records, and called by BOTH the runner and `table --check`, so the check re-derives the
    rule from the covolume, the generator count and the cap rather than trusting the run that wrote the records."""
    tier = tier_def(tid)
    target, floor, cap = tier['target_degree'], tier['floor_degree'], tier['point_cap']
    landings = load_jsonl(FS61 / 'landings.jsonl')
    items = []
    for D in (fields if fields is not None else FAMILY_500):
        if certified_field(D, landings):
            continue
        lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
        filt = load_jsonl(field_dir(D) / 'filter.jsonl')
        balls = load_jsonl(field_dir(D) / 'balls.jsonl')
        per = collections.defaultdict(list)
        for b in balls.values():
            per[b['lattice']].append(b)
        for key, r in lat.items():
            st = filt.get(key, {}).get('state', '')
            # `Refused` is in scope beside `Open` so that a lattice this tier refuses does not drop OUT of the
            # accounting's subject the moment it is answered (the self-erasing check again).
            if r['rank'] != 4 or not (st.startswith('Open') or st.startswith('Refused')):
                continue
            if nmax_scope and not tier_nmax_scope(r, tier):
                continue
            g, cov = r['size'], r['covolume']
            if not cov:
                continue
            R14 = radius_for_degree(g, target)
            Rcap = radius_for_points(cov, cap / DEGREE_OVERSHOOT)
            if R14 is not None and predicted_points(cov, R14) <= cap / DEGREE_OVERSHOOT:
                R, arm, dg = R14, 'R14', target
            elif degree_of(g, Rcap) >= floor:
                R, arm, dg = Rcap, 'Rcap', degree_of(g, Rcap)
            else:
                R, arm, dg = None, 'overcap', degree_of(g, Rcap)
            bs = per.get(key, [])
            decided = [b for b in bs if b['verdict'].startswith('Refused')
                       or b['verdict'] == 'Colourable (colouring verified)']
            Rdec = max([b['R'] for b in decided], default=None)
            item = {'D': D, 'key': key, 'id': r['id'], 'lattice': r, 'state': st, 'g': g, 'covolume': cov,
                    'R': None if R is None else round(R, 4), 'arm': arm, 'predicted_degree': round(dg, 3),
                    'predicted_points': None if R is None else predicted_points(cov, R),
                    'degree_at_cap': round(degree_of(g, Rcap), 3), 'radius_at_cap': round(Rcap, 4),
                    'decided_to_R': Rdec}
            # A lattice already decided at or above the target radius has had the higher-degree question answered.
            item['already'] = (R is not None and Rdec is not None and Rdec >= R - 1e-9)
            # The owner's revised E.1a scoped this tier to lattices whose BEST (largest-radius) ball record is
            # `Unknown` or `Over cap`.  The scope above is wider -- every `Open` (or `Refused`) rank-4 lattice -- for
            # one reason, stated here so both can be scored from the records: a lattice whose largest record is
            # `Colourable` was coloured at whatever radius happened to fit an EARLIER tier's cap, which for these is
            # 600,000 points, and colourability at a small radius is not a certificate.  Under this tier's cap a
            # strictly larger, denser ball of the same lattice fits, and that is the informative ask.  The rule can
            # only ask MORE, never fewer, and every record says which arm it came from.
            top = max(bs, key=lambda b: b['R']) if bs else None
            item['owner_arm'] = (top is None
                                 or top['verdict'] in ('Unknown (budget)', 'Over cap (not asked)'))
            items.append(item)
    items.sort(key=lambda it: (it['arm'] != 'R14', it['predicted_points'] or 1 << 60))
    return items


def cmd_degree_ask(tid='1c', fields=None, jobs=None, budget=None, show_plan=False, only_arm=None, limit=None):
    """Phase E.1a: one ball per in-scope lattice, at the radius the degree rule picks, in ONE pool over the family.

    Resume = the identical command; a settled record at the chosen radius is skipped, so a kill redoes at most the
    balls in flight.  `--jobs` has NO default here on purpose: at this tier's 2,000,000-point cap a worker wants
    10-16 GB, so the width is `available memory / measured peak` and must be a number someone measured."""
    import multiprocessing as mp
    tier = tier_def(tid)
    cap, wall = tier['point_cap'], tier['solve_wall']
    items = degree_plan(tid, fields)
    if only_arm:
        items = [it for it in items if it['arm'] == only_arm]
    if limit:
        items = items[:limit]
    todo, skipped = [], collections.Counter()
    for it in items:
        if it['arm'] == 'overcap':
            skipped['no radius reaches the degree floor under the cap'] += 1
            continue
        if it['already']:
            skipped['already decided at or above the target radius'] += 1
            continue
        done = load_jsonl(field_dir(it['D']) / 'balls.jsonl')
        prev = done.get(f'{it["key"]}|ball{it["R"]}')
        if prev is not None and _record_answers(prev, tid, tier):
            skipped['already asked at this tier'] += 1
            continue
        M, H = parse_key(it['key'])
        gens = [list(v) for v in saturation(it['D'], M, H)]
        if sha_vectors([tuple(v) for v in gens]) != it['lattice']['generators_sha256']:
            die(f'lattice {it["id"]}: the saturation of its key does not match the recorded generators_sha256', 1)
        todo.append((it, (it['D'], it['key'], gens, it['R'], cap, wall, tid, tier['_sha256'],
                          it['predicted_points'])))
    arms = collections.Counter(it['arm'] for it, _ in todo)
    print(f'fs61 degree-ask tier={tid}: {len(items)} lattices in scope over '
          f'{len({it["D"] for it in items})} fields; {len(todo)} balls to ask '
          f'({", ".join(f"{v} by arm {k}" for k, v in sorted(arms.items()))}), '
          f'{sum(v for v in skipped.values())} skipped ('
          f'{"; ".join(f"{v} {k}" for k, v in sorted(skipped.items()))}); '
          f'{sum(it["predicted_points"] for it, _ in todo):,} points predicted in total, largest '
          f'{max((it["predicted_points"] for it, _ in todo), default=0):,}; cap {cap:,}, wall {wall:.0f} s', flush=True)
    if show_plan:
        for it, _ in todo:
            print(f'  d={it["D"]:>3} {it["id"]} g={it["g"]:>3} R={it["R"]} arm={it["arm"]:<7} '
                  f'degree {it["predicted_degree"]:>6.2f} points {it["predicted_points"]:>9,}'
                  + (f'  [decided to R={it["decided_to_R"]}]' if it['decided_to_R'] else ''), flush=True)
        for it in items:
            if it['arm'] == 'overcap':
                print(f'  (no ask) d={it["D"]:>3} {it["id"]} g={it["g"]:>3}: at the cap R={it["radius_at_cap"]} the '
                      f'predicted degree is only {it["degree_at_cap"]:.2f}, below the floor '
                      f'{tier["floor_degree"]}', flush=True)
        print(f'DONE degree-ask --plan tier={tid}: {len(todo)} balls the rule would ask', flush=True)
        return []
    # the over-cap records: one per lattice the rule cannot ask, carrying the degree it would reach at the cap
    for it in items:
        if it['arm'] != 'overcap':
            continue
        k = f'{it["key"]}|ball{it["radius_at_cap"]}'
        out = field_dir(it['D']) / 'balls.jsonl'
        done = load_jsonl(out)
        if k in done and _record_answers(done[k], tid, tier):
            continue
        append(out, {'key': k, 'lattice': it['key'], 'id': it['id'], 'D': it['D'], 'shape': 'ball',
                     'R': it['radius_at_cap'], 'tier': tid, 'tier_sha256': tier['_sha256'], 'machine': MACHINE,
                     'wall': wall, 'cap': cap, 'predicted_points': cap, 'verdict': 'Over cap (not asked)',
                     'over_cap_by': 'prediction', 'claim_scope': 'float reading',
                     'degree_arm': 'overcap', 'generators': it['g'], 'covolume': it['covolume'],
                     'predicted_degree': it['degree_at_cap'],
                     'degree_note': f'no radius reaches degree {tier["floor_degree"]} under the '
                                    f'{cap:,}-point cap; at the cap (R = {it["radius_at_cap"]}) the predicted '
                                    f'degree is {it["degree_at_cap"]:.2f}'})
    if not todo:
        print(f'DONE degree-ask tier={tid}: nothing to ask', flush=True)
        return []
    if not jobs:
        die('degree-ask needs --jobs: at this cap a worker wants 10-16 GB, so the width is a measurement '
            '(available memory / measured peak), never a default')
    counts, errs, t0 = collections.Counter(), [], time.time()
    with mp.get_context('fork').Pool(min(jobs, len(todo))) as P:
        for rec, model in P.imap_unordered(_ball_worker, [w for _, w in todo]):
            it = next(i for i, w in todo if w[0] == rec['D'] and f'{w[1]}|ball{w[3]}' == rec['key'])
            # An over-cap record carries no edge count: `piece` never built the ball.  Reading one unconditionally
            # is how the first ball of this tier crashed the run, and it is the good direction to fail in.
            act = (2 * rec['edges'] / rec['points']) if isinstance(rec.get('points'), int) and rec.get('edges') else None
            rec = dict(rec, degree_arm=it['arm'], owner_arm=it['owner_arm'], generators=it['g'],
                       covolume=it['covolume'],
                       predicted_degree=it['predicted_degree'],
                       actual_degree=round(act, 3) if act else None,
                       degree_over_predicted=round(act / it['predicted_degree'], 4) if act else None,
                       decided_to_R_before=it['decided_to_R'], state_before=it['state'])
            if model is not None:
                with gzip.open(model_path(rec['D'], rec['model_sha256']), 'wb') as f:
                    f.write(model)
            append(field_dir(rec['D']) / 'balls.jsonl', rec)
            counts[rec['verdict']] += 1
            if rec['verdict'] == 'ERROR':
                errs.append((rec['key'], rec.get('error')))
                defect(f'degree-ask d={rec["D"]} {rec["key"]}: {rec.get("error")}')
            pts_s = f'{rec["points"]:,}' if isinstance(rec.get('points'), int) else str(rec.get('points'))
            print(f'  d={rec["D"]:>3} {rec["id"]} R={rec["R"]} arm={it["arm"]} {pts_s} points '
                  f'{rec.get("edges", "-")} edges degree {rec.get("actual_degree")} (predicted '
                  f'{it["predicted_degree"]}, predicted points {it["predicted_points"]:,}) -> {rec["verdict"]} '
                  f'[{rec.get("solve_seconds")} s, peak {rec.get("rss_peak_kb", 0) / 1048576:.2f} GB]', flush=True)
            if budget and time.time() - t0 > budget:
                print(f'  budget {budget} s reached: stopping (resume = re-run this command)', flush=True)
                P.terminate()
                break
    changed = 0
    for D in sorted({it['D'] for it, _ in todo}):
        filt = load_jsonl(field_dir(D) / 'filter.jsonl')
        changed += propagate_refusal(D, filt, load_jsonl(field_dir(D) / 'balls.jsonl'))
    print(f'DONE degree-ask tier={tid}: ' + ', '.join(f'{v} {k}' for k, v in sorted(counts.items()))
          + f'; {changed} lattices Refused (inherited); {len(errs)} defects; {(time.time() - t0) / 60:.1f} min',
          flush=True)
    return errs


# ================================================================ phase E.1b: tier 2l, deeper lattices at the same cap
def colourability_closures(filt, pairs):
    """The (sub, sup) inclusions where a lattice recorded `Open` sits inside one recorded `Colourable`, so the Open
    record is stale.  Pure, so both of its outcomes can be shown on fixtures; `propagate_colourability` writes them."""
    return [(sub, sup) for sub, sup in pairs
            if (filt.get(sub, {}).get('state', '').startswith('Open')
                and filt.get(sup, {}).get('state', '').startswith('Colourable'))]


def propagate_colourability(D, tid, quiet=True):
    """The dual of `propagate_refusal`, and the reason it is needed only now.  A 3-colouring of a lattice's graph
    restricts to every SUBlattice, so colourability is inherited DOWNWARD.  `cmd_filter` applies that inside one run,
    but it skips every lattice already on disk -- so when a deeper tier adds a lattice ABOVE one an earlier tier left
    `Open`, and that new lattice turns out colourable, the older record stays `Open` and the census over-counts its
    open population.  A new record is appended at this tier (the old one stays as the history), never rewritten."""
    lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
    filt = load_jsonl(field_dir(D) / 'filter.jsonl')
    pp = field_dir(D) / 'poset.jsonl'
    pairs = [(json.loads(l)['sub'], json.loads(l)['sup']) for l in open(pp)] if pp.exists() else []
    tier = tier_def(tid)
    out, n = field_dir(D) / 'filter.jsonl', 0
    for sub, sup in colourability_closures(filt, pairs):
        b = filt[sup]
        rec = {'key': sub, 'id': lat[sub]['id'], 'D': D, 'state': b['state'], 'certificate':
               dict(b.get('certificate') or {}, inherited=True), 'inherited_from': sup, 'quotients_tried': 0,
               'rank': lat[sub]['rank'], 'tier': tid, 'tier_sha256': tier['_sha256'], 'machine': MACHINE,
               'claim_scope': b.get('claim_scope', 'verified model')}
        append(out, rec)
        filt[sub] = rec
        n += 1
        if not quiet:
            print(f'  d={D} {lat[sub]["id"]} closed by {lat[sup]["id"]} above it: {b["state"]}', flush=True)
    return n


def cmd_deepen(fields=None, tid='2l', jobs=None, budget=None, stages='all', girth=False):
    """Phase E.1b: deeper lattices (this tier's NMAX) and their certificates at every field that has not landed, then
    the radius ladder over the Open ones, pooled over the whole family.  Resume = the identical command."""
    tier = tier_def(tid)
    landings = load_jsonl(FS61 / 'landings.jsonl')
    fields = [D for D in (fields or FAMILY_500) if not certified_field(D, landings)]
    state = FS61 / f'deepen-progress-{tid}.jsonl'
    done = load_jsonl(state)
    print(f'fs61 deepen tier={tid}: {len(fields)} census fields with no certified witness, lattices to '
          f'NMAX = {tier["nmax"]}, cap {tier["point_cap"]:,} points, wall {tier["solve_wall"]:.0f} s, target '
          f'degree {tier["target_degree"]} (floor {tier["floor_degree"]}); odd girth NOT computed at this tier; '
          f'{len(done)} fields already built. Resume = re-run this identical command.', flush=True)
    errs, t0 = [], time.time()
    if stages in ('all', 'lattices'):
        for D in fields:
            if str(D) in done:
                continue
            t1 = time.time()
            lat, e1 = cmd_lattices(D, tid, jobs=jobs or 16, quiet=True, girth=girth)
            filt, e2 = cmd_filter(D, tid, quiet=True)
            nc = propagate_colourability(D, tid)
            filt = load_jsonl(field_dir(D) / 'filter.jsonl')
            st = collections.Counter(f['state'].split(' (')[0] for f in filt.values())
            nopen = sum(1 for k, f in filt.items() if f['state'].startswith('Open') and lat[k]['rank'] == 4)
            print(f'  d={D:>3}: {len(lat)} lattices ({", ".join(f"{v} {k}" for k, v in sorted(st.items()))}), '
                  f'{nopen} rank-4 Open, {nc} closed from above; {time.time() - t1:.0f} s', flush=True)
            append(state, {'key': str(D), 'd': D, 'lattices': len(lat), 'open_rank4': nopen,
                           'closed_from_above': nc, 'seconds': round(time.time() - t1, 1), 'tier': tid,
                           'machine': MACHINE})
            errs += e1 + e2
        print(f'  DONE deepen lattices+filter: {len(fields)} fields, {(time.time() - t0) / 60:.1f} min, '
              f'{len(errs)} defects', flush=True)
    if stages in ('all', 'balls'):
        errs += cmd_degree_ask(tid, fields=fields, jobs=jobs, budget=budget)
    print(f'DONE deepen tier={tid}: {len(fields)} fields, {(time.time() - t0) / 60:.1f} min, {len(errs)} defects',
          flush=True)
    return errs


def cmd_census(fields=None, tid='1', jobs=16, budget=7200, projection_after=6):
    """Tier 1 over the family in ascending d, resumable.  Prints a projection after the first few fields so the tier
    can be re-planned before a day of machine time is spent rather than after (the owner's instruction, 2026-09-20)."""
    fields = fields or FAMILY_500
    state = FS61 / 'census-progress.jsonl'
    done = load_jsonl(state)
    print(f'fs61 census: {len(fields)} fields, tier {tid}, ascending d; {len(done)} already complete. '
          f'Resume = re-run this identical command.', flush=True)
    times, errs = [], []
    for D in fields:
        if str(D) in done:
            times.append(done[str(D)]['seconds'])
            continue
        t0 = time.time()
        e = cmd_census_field(D, tid, jobs=jobs, budget=budget)
        dt = time.time() - t0
        times.append(dt)
        append(state, {'key': str(D), 'd': D, 'seconds': round(dt, 1), 'defects': len(e), 'tier': tid,
                       'machine': MACHINE})
        errs += e
        n = len(times)
        if n == projection_after or (n > projection_after and n % 10 == 0):
            per = sum(times) / n
            left = (len(fields) - n) * per
            print(f'  PROJECTION after {n} fields: {sum(times) / 60:.1f} min spent, mean {per:.0f} s/field, '
                  f'{left / 3600:.1f} h projected for the remaining {len(fields) - n} '
                  f'(total {(sum(times) + left) / 3600:.1f} h)', flush=True)
    print(f'DONE census: {len(fields)} fields, {sum(times) / 3600:.2f} h, {len(errs)} defects', flush=True)
    return errs


CENSUS_LEGEND = '''# FS-61 — the census of real quadratic fields: which planes need four colours

*Derived by `python3 tools/fs61_census.py table` from `data/fs61/fields/<d>/*.jsonl`; never hand-edited. Plan:
`plans/FS61-quadratic-census.md`. Machine: {machine}.*

**Read this first.** Colour the points of the plane whose two coordinates lie in `ℚ(√d)` so that no two points exactly
1 apart share a colour; `χ(ℚ(√d)²)` is the fewest colours that suffice. The forty fields below are the only real
quadratic fields whose plane can need four (§1), and the project's local–global conjecture predicts every one of them
does. **"Not landed" means no certificate was found at the stated depth; it is not evidence that three colours
suffice — the conjecture predicts at least four for every row of this table.**

**The columns.**

* **d** — the field is `ℚ(√d)`. **mod 8** — 3 or 7; the two halves behave differently (R-mod8).
* **L** — the best upper bound the finite residue planes give, `[lower, upper]` when the target's own chromatic number
  is undecided. `χ(ℚ(√d)²) ≤ L`, prior art at hand level.
* **N₁, N₃** — the least denominator of a non-rational unit vector, and the least denominator divisible by 3. A witness
  needs a direction with 3 in a denominator (the kernel's 3-adic barrier, `CLAUDE.md` row 72).
* **lattices** — the tier's lattices by state: `C2`/`C3` colourable by a linear form mod 2 or mod 3 (exact),
  `Cq` by a verified periodic quotient colouring, `R` refused, `O` open.
* **balls asked / over cap / unknown** — of the ball records, how many were actually put to a solver. A lattice too
  fine for the tier's point cap is never built, so **a field with few asks has been looked at less than its lattice
  count suggests**.
* **bracket** — the refusal bracket of the best lattice: (largest radius verified colourable, smallest refused).
* **state** — `Landed (certified)` only when the frozen checker printed CERTIFIED; `Refusal claimed` is a solver's
  word; `Not landed at tier T` is a null at a depth, and it always says **which kind of null** (the owner's ruling 6,
  2026-09-20), because the three are different knowledge:
  * `(by certificate)` — the field has **no** open lattice left at this depth: every one carries a verified
    3-colouring of its whole infinite graph. More solver time at this depth is worth nothing; only deeper lattices
    (more classes, a larger `NMAX`) can land it.
  * `(by budget: k Open lattices, none askable)` — open lattices remain and **not one of them was ever put to a
    solver**: every ball the tier would build is over its point cap. Nothing about the field was measured.
  * `(asked: j of k Open lattices, no refusal)` — open lattices were asked and none refused at this depth.
* **evidence** — what backs **this row's** lower bound: `checker` (the frozen independent checker certified the
  witness in `data/fs61/witness-<d>/`), `solver claim` (a refusal no checker has confirmed), or `none`.
  **No row of this table is kernel-checked**; see the note under the table for `d = 11`.
* **value** — the bracket on `χ(ℚ(√d)²)` with a source for each end.

'''


CENSUS_KERNEL_NOTE = '''
**The kernel and this table.** **No row above is kernel-checked.** The Lean kernel does hold `χ(ℚ(√11)²) ≥ 4` —
`four_le_chromaticNumber_planeOver_eleven`, in `Proofs/HadwigerNelson/Instances/SqrtEleven.lean` — but it holds it
from FS-58's **204-point chain witness**, which is a *different graph* from the **189-point direct witness** this
census certified at `d = 11` (`data/fs61/witness-11/`). Every `evidence` cell above reading `checker` means the
frozen independent checker `tools/fs58_check_witness.py` printed `CERTIFIED` on that row's own witness, and nothing
more.
'''


def deepen_command(D, tid, why):
    """M3.7: a null row carries the command that would turn it into an answer.  Which command depends on WHY the null
    is a null -- a field closed by certificates needs deeper lattices, one closed by the cap needs a bigger budget."""
    if str(tid) == '1' and (why or '').startswith('by budget'):
        plan, _ = ladder_plan(D, '1b')
        if any(e['askable'] for e in plan.values()):
            return f'python3 tools/fs61_census.py ladder {D}'
    return f'python3 tools/fs61_census.py census-field {D} --tier 2'


def field_not_landed_reason(lat, filt, balls):
    """The owner's ruling 6, plus the case its two phrases do not cover.  A field that has not landed is in exactly one
    of three states, and merging any two of them repeats phase 0's 1,350-against-550 error one level up:
      no open lattice at all          -> the null is BY CERTIFICATE
      open lattices, none ever asked  -> the null is BY BUDGET, and nothing about the field was measured
      open lattices, some asked       -> the null is a measurement: they were asked and did not refuse."""
    open4 = [k for k, f in filt.items() if f['state'].startswith('Open') and lat.get(k, {}).get('rank') == 4]
    if not open4:
        return 'by certificate'
    asked = {b['lattice'] for b in balls.values()
             if b['lattice'] in open4 and b['verdict'] != 'Over cap (not asked)'}
    plural = 'lattice' if len(open4) == 1 else 'lattices'
    if not asked:
        return f'by budget: {len(open4)} Open {plural}, none askable'
    # "No refusal" would be read as "they came back colourable".  At tier 1b two thirds of the asks ran to the solver's
    # wall without deciding anything, which is a third kind of nothing and belongs in the sentence, not only in the
    # `unknown` column (de Bruijn, 2026-09-20).
    decided = {b['lattice'] for b in balls.values()
               if b['lattice'] in open4 and b['verdict'] == 'Colourable (colouring verified)'}
    undecided = asked - decided
    tail = f', {len(undecided)} undecided at the wall' if undecided else ''
    return f'asked: {len(asked)} of {len(open4)} Open {plural}, no refusal{tail}'


def census_rows(tid='1'):
    frame = {json.loads(l)['d']: json.loads(l) for l in open(FS61 / 'frame.jsonl')} if (FS61 / 'frame.jsonl').exists() else {}
    atlas = {json.loads(l)['d']: json.loads(l) for l in open(FS61 / 'atlas.jsonl')} if (FS61 / 'atlas.jsonl').exists() else {}
    landings = load_jsonl(FS61 / 'landings.jsonl')
    rows = []
    for D in FAMILY_500:
        fd = field_dir(D)
        lat = load_jsonl(fd / 'lattices.jsonl')
        filt = load_jsonl(fd / 'filter.jsonl')
        balls = load_jsonl(fd / 'balls.jsonl')
        st = collections.Counter(f['state'].split(' (')[0] + ('/' + f['state'].split('(')[1][:4] if '(' in f['state'] else '')
                                 for f in filt.values())
        kinds = collections.Counter()
        for f in filt.values():
            s = f['state']
            kinds['C2' if 'form mod 2' in s else 'C3' if 'form mod 3' in s else 'Cq' if 'periodic' in s
                  else 'R' if s.startswith('Refused') else 'O'] += 1
        v = collections.Counter(b['verdict'] for b in balls.values())
        asked = sum(v.values()) - v['Over cap (not asked)']
        # the CENSUS population is the balls on lattices the filter left open (or that a ball then refused).  Phase 0's
        # paired controls ran a --filter-off scan on d = 2, 5, 7, 13, 19, 31, 43 and 47, so 47 carries ball records on
        # lattices that already had a colourability certificate; those are real asks but not comparable column entries.
        cens = [b for b in balls.values()
                if not (filt.get(b['lattice'], {}).get('state', 'Open').startswith('Colourable'))]
        vc = collections.Counter(b['verdict'] for b in cens)
        asked_c = sum(vc.values()) - vc['Over cap (not asked)']
        best = None
        for b in balls.values():
            if b['verdict'].startswith('Refused'):
                if best is None or (isinstance(b.get('points'), int) and b['points'] < best.get('points', 1 << 60)):
                    best = b
        col = [b for b in balls.values() if b['verdict'] == 'Colourable (colouring verified)']
        lo = max((b['R'] for b in col), default=None)
        hi = min((b['R'] for b in balls.values() if b['verdict'].startswith('Refused')), default=None)
        wit = certified_field(D, landings)
        fr = frame.get(D, {})
        L = fr.get('L') or (f"[{fr.get('L_lower')}, {fr.get('L_upper') or '?'}]" if fr else None)
        why = None if (wit or hi is not None) else field_not_landed_reason(lat, filt, balls)
        state = ('Landed (certified)' if wit else 'Refusal claimed' if hi is not None
                 else f'Not landed at tier {tid} ({why})')
        ck = fr.get('chi_known')
        rows.append({'key': str(D), 'd': D, 'mod8': D % 8, 'L': L, 'L_prime': fr.get('L_prime'),
                     'N1': atlas.get(D, {}).get('N1'), 'N3': atlas.get(D, {}).get('N3'),
                     'lattices': len(lat), 'by_state': dict(kinds), 'ball_records': len(balls), 'balls_asked': asked,
                     'census_ball_records': len(cens), 'census_balls_asked': asked_c,
                     'census_over_cap': vc['Over cap (not asked)'], 'census_unknown': vc['Unknown (budget)'],
                     'over_cap': v['Over cap (not asked)'], 'unknown': v['Unknown (budget)'],
                     'refused': v['Refused (solver claim)'], 'colourable': v['Colourable (colouring verified)'],
                     'bracket': [lo, hi], 'best_refusing': (best or {}).get('id'),
                     'best_refusing_points': (best or {}).get('points'),
                     'state': state, 'not_landed_reason': why,
                     # `evidence` is about THIS row's witness.  d = 11 is NOT `kernel` here: the kernel's
                     # four_le_chromaticNumber_planeOver_eleven rests on FS-58's 204-point CHAIN witness, a different
                     # graph from the 189-point direct witness certified in data/fs61/witness-11 -- see the note under
                     # the table.  (Plan section 7 wrote `kernel (11 only)` before this census produced its own
                     # witness over 11; the owner's correction, 2026-09-20.)
                     'evidence': 'checker' if wit else 'solver claim' if hi is not None else 'none',
                     'value': [4 if hi is not None else None, L], 'chi_known': ck,
                     'deepen': (deepen_command(D, tid, why)
                                if state.startswith('Not landed') else
                                f'python3 tools/fs61_census.py land {D}' if state == 'Refusal claimed' else ''),
                     'tier': tid, 'machine': MACHINE,
                     'claim_scope': 'checker' if wit else 'solver claim' if hi is not None else 'verified model'})
    return rows


def tier_accounting(D, tid, lat, filt, balls):
    """One tier's own accounting rule: has it asked everything its definition says it would ask?  A tier with a radius
    ladder is checked against `ladder_plan`, re-derived here from the covolumes and the cap; a tier without one is
    checked against its base radius, which is what phase B's B.1 asked for."""
    tier = tier_def(tid)
    bad = []
    if 'target_degree' in tier:
        # A degree tier's obligation: every in-scope lattice has a record at the radius the RULE picks -- re-derived
        # here from the covolume, the generator count and the cap, never read back from the run that wrote it.  A
        # lattice already decided at or above that radius is discharged by that decision and says so.
        for item in degree_plan(tid, fields=[D]):
            R = item['R'] if item['arm'] != 'overcap' else item['radius_at_cap']
            rec = balls.get(f'{item["key"]}|ball{R}')
            if item['already']:
                continue
            if rec is None or not _tier_counts(rec, tid):
                bad.append((D, f'{item["id"]} tier-{tid} degree ask missing at R={R}'))
                defect(f'table --check d={D}: lattice {item["id"]} has no tier-{tid} record at R={R}, the radius '
                       f'the degree rule selects (arm {item["arm"]}, predicted degree '
                       f'{item["predicted_degree"]}, predicted points {item["predicted_points"] or item["D"]})')
    elif 'ladder_radii' in tier:
        plan, _ = ladder_plan(D, tid)
        for key in sorted(plan):
            ok, why = ladder_status(plan[key], balls, tid, tier)
            if not ok:
                bad.append((D, f'{plan[key]["id"]} tier-{tid} ladder incomplete: {why}'))
                defect(f'table --check d={D}: lattice {plan[key]["id"]} tier-{tid} ladder incomplete -- {why}')
    else:
        R0 = tier['radii'][0]
        for key, f in filt.items():
            if (f['state'].startswith('Open') and lat[key]['rank'] == 4 and tier_nmax_scope(lat[key], tier)
                    and f'{key}|ball{R0}' not in balls):
                bad.append((D, f'{f["id"]} Open with no R={R0} record'))
                defect(f'table --check d={D}: lattice {f["id"]} is Open with no R={R0} ball record')
    return bad


def cmd_table(check=False, tid=None):
    tid = str(tid) if tid else deepest_tier_present()
    rows = census_rows(tid)
    out_j, out_m = FS61 / 'census.jsonl', FS61 / 'census.md'
    if out_j.exists():
        out_j.unlink()
    for r in rows:
        append(out_j, r)
    T = tiers()
    L = [CENSUS_LEGEND.format(machine=MACHINE),
         f'**The depth this table is at: tier `{tid}`** — the deepest tier with ball records, read from the records '
         f'themselves. Tier definitions live in `data/fs61/tiers.json` and never change after their first record:',
         ''] + [f'* **tier `{t}`** — {T[t]["name"]}: lattices to `NMAX = {T[t]["nmax"]}`, '
                + (f'one ball per lattice at the radius where the predicted average degree reaches '
                   f'{T[t]["target_degree"]} (floor {T[t]["floor_degree"]})'
                   if T[t].get('target_degree') else f'radii {T[t].get("ladder_radii") or T[t]["radii"]}')
                + f', point cap {T[t]["point_cap"]:,}, solve wall '
                f'{T[t]["solve_wall"]} s.' + (f' Scope: {T[t]["scope"]}' if T[t].get('scope') else '')
                for t in tiers_upto(tid)] + [
         '',
         '| d | mod 8 | L | N₁ | N₃ | lattices (C2/C3/Cq/R/O) | balls asked / over cap / unknown | bracket | '
         'state | evidence | value | what would deepen it |', '|---|---|---|---|---|---|---|---|---|---|---|---|']
    for r in rows:
        k = r['by_state']
        L.append(f"| **{r['d']}** | {r['mod8']} | {r['L']} | {r['N1']} | {r['N3']} | "
                 f"{r['lattices']} ({k.get('C2',0)}/{k.get('C3',0)}/{k.get('Cq',0)}/{k.get('R',0)}/{k.get('O',0)}) | "
                 f"**{r['census_balls_asked']}** / {r['census_over_cap']} / {r['census_unknown']} | "
                 f"{r['bracket'][0] or '–'} … {r['bracket'][1] or '–'} | {r['state']} | {r['evidence']} | "
                 f"{'4 ≤ χ ≤ ' + str(r['L']) if r['value'][0] else '≤ ' + str(r['L'])} | "
                 f"`{r['deepen']}`" + ' |')
    tot = collections.Counter(r['state'].split(' (')[0] if r['state'].startswith('Not landed') else r['state']
                              for r in rows)
    kinds = collections.Counter(r['not_landed_reason'].split(':')[0] for r in rows if r['not_landed_reason'])
    L += ['', f"**{len(rows)} fields.** " + '; '.join(f'{n} {s}' for s, n in sorted(tot.items())) + '.'
          + (' Of the nulls: ' + ', '.join(f'{n} {k}' for k, n in sorted(kinds.items())) + '.' if kinds else ''),
          f"Balls on the census population (lattices the filter left open): "
          f"{sum(r['census_ball_records'] for r in rows)} records, **{sum(r['census_balls_asked'] for r in rows)} asked**, "
          f"{sum(r['census_over_cap'] for r in rows)} over cap, {sum(r['census_unknown'] for r in rows)} unknown. "
          f"Counting every record, including the balls phase 0's paired controls asked on already-certified lattices at "
          f"d = 47: {sum(r['ball_records'] for r in rows)} records, {sum(r['balls_asked'] for r in rows)} asked.",
          CENSUS_KERNEL_NOTE]
    out_m.write_text('\n'.join(L) + '\n')
    print(f'fs61 table: {len(rows)} fields -> {rel(out_m)}, {rel(out_j)}', flush=True)
    if not check:
        print('DONE table', flush=True)
        return []
    bad = []
    for r in rows:
        k = r['by_state']
        if sum(k.values()) != r['lattices']:
            bad.append((r['d'], f'{sum(k.values())} filtered against {r["lattices"]} lattices'))
            defect(f'table --check d={r["d"]}: {sum(k.values())} filtered states against {r["lattices"]} lattices')
        fd = field_dir(r['d'])
        lat, filt, balls = load_jsonl(fd / 'lattices.jsonl'), load_jsonl(fd / 'filter.jsonl'), load_jsonl(fd / 'balls.jsonl')
        for t in tiers_upto(tid):                      # every tier at or above this one is held to its own accounting
            bad += tier_accounting(r['d'], t, lat, filt, balls)
        bad += monotonicity_check(r['d'], lat, filt, balls)
    print(f'DONE table --check: {len(rows)} fields at tier {tid} (accounting checked at '
          f'{", ".join(tiers_upto(tid))}), {len(bad)} defects', flush=True)
    return bad


def monotonicity_check(D, lat, filt, balls):
    """B.1b, and it can fail: a failure is an instrument defect and one of the plan's five halts."""
    bad = []
    pp = field_dir(D) / 'poset.jsonl'
    pairs = [(json.loads(l)['sub'], json.loads(l)['sup']) for l in open(pp)] if pp.exists() else []
    for sub, sup in pairs:
        a, b = filt.get(sub, {}).get('state', ''), filt.get(sup, {}).get('state', '')
        if a.startswith('Refused') and b.startswith('Colourable'):
            bad.append((D, f'{lat[sub]["id"]} Refused inside {lat[sup]["id"]} {b}'))
            defect(f'DEFECT monotone d={D}: {lat[sub]["id"]} Refused inside {lat[sup]["id"]} '
                   f'{b} (certificate {filt[sup].get("certificate", {}).get("kind")}) -- HALT, plan rule 15')
    byl = {}
    for b in balls.values():
        byl.setdefault(b['lattice'], []).append(b)
    for key, bs in byl.items():
        ref = [b['R'] for b in bs if b['verdict'].startswith('Refused')]
        col = [b['R'] for b in bs if b['verdict'] == 'Colourable (colouring verified)']
        if ref and col and max(col) > min(ref):
            bad.append((D, f'{lat[key]["id"]} colourable at R={max(col)} above refused at R={min(ref)}'))
            defect(f'DEFECT monotone d={D}: {lat[key]["id"]} colourable at R={max(col)} above a refusal at '
                   f'R={min(ref)} -- HALT, plan rule 15')
    for key, r in lat.items():
        m = barrier_violation(r)
        if m:
            bad.append((D, f'{r["id"]} {m}'))
            defect(f'DEFECT barrier d={D}: {r["id"]} {m} -- HALT, plan rule 15')
    return bad


# ================================================================ phase C: certify every refusal (C.1-C.9)
def barrier_edge_count(D, pts, edges):
    """C.6: how many edges have a direction with 3 in its reduced denominator.  The kernel's 3-adic barrier (row 72)
    says a four-chromatic graph over these fields must have at least one, so zero here is a defect, not a curiosity."""
    n = 0
    for i, j in edges:
        a1, b1, c1, e1, m1 = pts[i]
        a2, b2, c2, e2, m2 = pts[j]
        L = m1 * m2 // math.gcd(m1, m2)
        d = [a1 * (L // m1) - a2 * (L // m2), b1 * (L // m1) - b2 * (L // m2),
             c1 * (L // m1) - c2 * (L // m2), e1 * (L // m1) - e2 * (L // m2)]
        g = 0
        for x in d:
            g = math.gcd(g, abs(x))
        den = L // math.gcd(L, g)
        if den % 3 == 0:
            n += 1
    return n


def four_colour(pts, edges):
    """C.5: a 4-colouring of the witness graph, verified on every edge by code that shares nothing with the search."""
    import numpy as np
    from pysat.solvers import Cadical195
    nv = len(pts)
    sv = Cadical195()
    sv.append_formula([[4 * v + k + 1 for k in range(4)] for v in range(nv)])
    E = np.array(edges, dtype=np.int64)
    for k in range(4):
        sv.append_formula(np.stack([-(4 * E[:, 0] + k + 1), -(4 * E[:, 1] + k + 1)], axis=1).tolist())
    if not sv.solve():
        sv.delete()
        return None
    col = (np.array(sv.get_model()[:4 * nv]).reshape(nv, 4) > 0).argmax(axis=1).astype(int).tolist()
    sv.delete()
    for i, j in edges:                                          # verified here, in plain Python, on every edge
        if col[i] == col[j]:
            return None
    return col


DELETION_BUDGET = 600.0    # seconds of stage-2 deletion per field; see run_generation for why it exists
GEN_CAP = 5400.0           # a backstop on one field's whole generation call, never the plan
DIRECT_WALL = 900.0        # `direct-witness` cannot checkpoint, so it gets a wall and then `extract` takes over
DIRECT_MAX_POINTS = 15_000 # above this a ball goes straight to the checkpointed generator


def _deletion_state(steps):
    """The last `deletion` checkpoint in FS-58's steps.jsonl as (position, finished), or None if stage 2 has not
    started.  Read from the tail: the file is megabytes of lattice coordinates and this is polled every ten seconds."""
    if not steps.exists():
        return None
    with open(steps, 'rb') as f:
        f.seek(0, 2)
        f.seek(max(0, f.tell() - 2_000_000))
        tail = f.read().decode('utf-8', 'replace')
    last = None
    for ln in tail.splitlines():
        if '"step":"deletion"' in ln:
            try:
                r = json.loads(ln)
            except ValueError:                      # a tail cut mid-record, or the partial line of a stopped run
                continue
            last = (r['position'], r['finished'])
    return last


def _repair_steps(steps):
    """A SIGTERM can land between FS-58's `f.write(record)` and its `flush()`, leaving a partial final line that
    the resume path (`json.loads` over every line) would die on.  Drop exactly that line, loudly, and never more."""
    if not steps.exists():
        return None
    raw = steps.read_bytes()
    if not raw:
        return None
    cut = raw.rfind(b'\n', 0, len(raw) - 1) + 1 if raw.endswith(b'\n') else raw.rfind(b'\n') + 1
    tail = raw[cut:]
    bad = bool(tail.strip())
    if bad:
        try:
            json.loads(tail.decode())
            bad = False
        except (ValueError, UnicodeDecodeError):
            bad = True
    if not bad:
        return None
    steps.write_bytes(raw[:cut])
    msg = f'steps.jsonl: dropped a truncated final record of {len(tail)} bytes, written as the generator was stopped'
    print(f'    [fs61] {msg}', flush=True)
    return msg


def _stop_child(p, artifact, reason, fh):
    """Stop the generator **by pid** (never a pattern that could match this shell) and verify **by effect**: we own
    this child, so `p.wait()` reaping it is proof it can no longer write anything; the artifact's digest held across
    five seconds is the belt-and-braces half.  Returns the verification line, which goes into the record."""
    dig = lambda: hashlib.sha256(artifact.read_bytes()).hexdigest() if artifact.exists() else None
    before = dig()
    print(f'    stopping the generator (pid {p.pid}): {reason}', flush=True)
    p.terminate()
    try:
        p.wait(timeout=30)
    except subprocess.TimeoutExpired:
        p.kill()
        p.wait()
    time.sleep(5)
    static = (before == dig())
    # The load-bearing half is the REAP: this is our own child, so `p.wait()` returning means the kernel has
    # collected it and it cannot write anything ever again -- strictly stronger than its absence from `ps`.  The
    # digest is the redundant belt, and it is only informative when the artifact was being written at all (which
    # for `direct-witness`, silent until it finishes, it is not); the selftest shows it able to fire.
    line = (f'pid {p.pid} reaped with exit {p.returncode} (a reaped child cannot write); {artifact.name} digest '
            f'{"static" if static else "STILL CHANGING"} across 5 s')
    print(f'    stopped: {line}', flush=True)
    fh.write(f'[fs61] generator stopped: {reason}; {line}\n')
    fh.flush()
    return line, static


def run_generation(D, spec, R, out, big, deletion_budget=DELETION_BUDGET, gen_cap=GEN_CAP,
                   direct_wall=DIRECT_WALL):
    """Run FS-58's generator for one field under a **deletion** budget, and resume it to emit the witness.

    Why a budget at all, and why on stage 2 only (the owner's ruling after phase C's first stall):
      * stage 1, the assumption-core rounds, is the reduction that matters -- 113,325 -> 2,830 points at d = 359 --
        and `extract` offers no way to stop it, so it runs to its fixpoint;
      * stage 2, deleting one vertex at a time down to 1-minimal, is a **nicety**: gate C.9 *records* minimality and
        never requires it, and FS-58's own 95 witness was certified with it stopped.  At d = 359 it ran at 45 s a
        step with ~700 steps left -- nine hours on one field, with eight fields queued behind it.  So it gets
        `deletion_budget` seconds from the moment its first checkpoint appears, and is then stopped and the witness
        emitted from the last checkpoint with `--stop-deletion`;
      * `gen_cap` is a backstop on the whole call, never the plan.  A field it stops is left resumable, not failed.

    Every stop is cheap because `extract` checkpoints each core round and every 60 s of deletion, so re-running
    `land` redoes at most one round or one minute (plan rule 1).

    **`direct-witness` neither checkpoints nor resumes**, so it gets a plain wall (`direct_wall`) and, if it hits
    it, is stopped and **replaced by `extract` on the same ball**.  The wall exists because ball size does not
    predict its cost: `direct-witness` takes one assumption core over the whole ball and then deletes one vertex at
    a time *against the whole ball's formula*, so the cost is set by the core, which is unknown until it is running
    -- 8,629 points took 5.7 s (core 169) and 13,605 took 51 s (core 456), while 17,169 was unfinished at 2,124 s.
    A threshold is a guess about that; a wall plus a checkpointed fallback is not.
    """
    steps, log = out / 'steps.jsonl', out / 'generate.out'
    EX = [sys.executable, str(ROOT / 'tools' / 'fs58_search.py'), 'extract', str(D), spec, str(R), str(out)]
    DW = [sys.executable, str(ROOT / 'tools' / 'fs58_search.py'), 'direct-witness', str(D), spec, str(R), str(out)]
    info = {'deletion_budget_s': deletion_budget, 'gen_cap_s': gen_cap,
            'direct_wall_s': None if big else direct_wall, 'generator': 'extract' if big else 'direct-witness',
            'passes': [], 'stopped': None, 'stop_verified': None}

    def one(cmd, tag, watch, wall=None):
        t0 = time.time()
        fh = open(log, 'a')
        fh.write(f'\n$ {" ".join(str(c) for c in cmd)}\n')
        fh.flush()
        p = subprocess.Popen(cmd, stdout=fh, stderr=subprocess.STDOUT, cwd=str(ROOT))
        del_t0, reason = None, None
        while True:
            try:
                p.wait(timeout=10)
                break
            except subprocess.TimeoutExpired:
                pass
            if wall and time.time() - t0 > wall:
                reason = f'direct-witness wall {wall:.0f} s spent with nothing on disk'
                info['stop_verified'], _ = _stop_child(p, log, reason, fh)
                info['stopped'] = reason
                break
            if not watch:
                continue
            st = _deletion_state(steps)
            if st and not st[1] and del_t0 is None:
                del_t0 = time.time()
                print(f'    stage 2 (deletion) started at position {st[0]}; budget {deletion_budget:.0f} s', flush=True)
            if del_t0 is not None and time.time() - del_t0 > deletion_budget:
                st = _deletion_state(steps)
                reason = (f'deletion budget {deletion_budget:.0f} s spent'
                          + (f' at position {st[0]}' if st else ''))
            elif gen_cap and time.time() - t0 > gen_cap:
                reason = f'generation cap {gen_cap:.0f} s spent'
            if reason:
                info['stop_verified'], _ = _stop_child(p, steps, reason, fh)
                info['stopped'] = reason
                break
        fh.close()
        if reason:
            info['steps_repair'] = _repair_steps(steps)
        info['passes'].append({'pass': tag, 'seconds': round(time.time() - t0, 1), 'exit': p.returncode,
                               'stopped': reason})
        print(f'    generation pass "{tag}": {time.time() - t0:.0f} s, exit {p.returncode}'
              + (f' -- {reason}' if reason else ''), flush=True)
        return reason

    if not big:
        if one(DW, 'direct-witness (whole, under its wall)', False, wall=direct_wall) is None:
            info['ok'] = (out / 'witness.json').exists()
            return info
        # the wall fired: fall back to the checkpointed generator on the same ball, and say so in the record
        info['generator'] = 'extract'
        info['fallback'] = (f'direct-witness hit its {direct_wall:.0f} s wall with nothing on disk; '
                            f'extract took over on the same ball')
        print(f'    {info["fallback"]}', flush=True)
    stopped = one(EX, 'deletion under budget', True)
    if stopped and not (out / 'witness.json').exists():
        one(EX + ['--stop-deletion'], 'emit from the last checkpoint', False)
    info['ok'] = (out / 'witness.json').exists()
    return info


def _minimality(w):
    """C.9, read out of the witness's own provenance rather than asserted: FS-58 writes either `1-minimal refusing
    vertex set` (direct-witness), `deletion to 1-minimal` (extract, run to the end) or `deletion STOPPED after k of
    m tests` (extract, stopped).  Minimality is recorded, never required."""
    red = ((w.get('construction') or {}).get('reduction') or '')
    m = re.search(r'deletion STOPPED after (\d+) of (\d+) tests', red)
    if m:
        return {'minimal': 'no', 'stopped_at': int(m.group(1)), 'of_tests': int(m.group(2)),
                'note': f'refusing but NOT 1-minimal: the deletion was stopped at position {m.group(1)} '
                        f'of {m.group(2)}'}
    if 'deletion to 1-minimal' in red or '1-minimal refusing vertex set' in red:
        return {'minimal': 'yes', 'stopped_at': None, 'of_tests': None,
                'note': '1-minimal: deleting any single vertex leaves a 3-colourable graph'}
    return {'minimal': 'unknown', 'stopped_at': None, 'of_tests': None,
            'note': 'the generator recorded no deletion phase'}


RECHECK_TOOL_SHA256 = '880f5bc48ef39b4ca18aa50535481156ab38e1977e88a7906b4682a24a819ed6'
_R3 = re.compile(r'deleting vertex \d+ leaves a graph that still refuses|the control model is not proper')
_R2 = re.compile(r'finds a 3-colouring')
_R1 = re.compile(r'unit pairs by Fraction arithmetic against')


def classify_recheck(line, exit_code, minimal, tool_sha):
    """Split the frozen second opinion's ONE line into the two claims it actually carries (the owner's ruling 1
    after phase C).  `tools/fs58_recheck_witness.py`, at sha256 880f5bc48ef39b4c..., is **straight-line**:

      (i)   every pair of points in exact `Fraction` arithmetic equals the file's edge list, else FAIL and return;
      (ii)  Lingeling, CaDiCaL 1.5.3 and MapleChrono each refuse three colours, else FAIL and return;
      (iii) deleting the pinned edge's second vertex leaves a 3-colourable graph, else FAIL and return.

    So the step-(iii) message is **reachable only after (i) and (ii) returned without failing** -- that is the whole
    inference, and it is an inference about *that file at that hash*, so a different hash refuses it instead of
    guessing.  (The phase-C record first said the opposite -- that at `d = 95` the second opinion was "not reached"
    because the control "exits at the first failure".  It is the LAST step, not the first; the second opinion was
    reached and passed, and only its PASS line was lost.  The owner caught it; an error against one's own work is
    still an error in the record.)

      C.4a = (i) + (ii), the second opinion proper.  **Required.**
      C.4b = (iii), pinned-vertex criticality.  **Required iff C.9 records the witness 1-minimal**, else recorded;
             a red C.4b on a 1-minimal witness is a defect in the generator or the recheck, and halts.

    `minimal` is C.9's own word (`yes` / `no` / `unknown`).  Returns (C.4a, C.4b) records.
    """
    req = (minimal == 'yes')
    if tool_sha != RECHECK_TOOL_SHA256:
        why = (f'the frozen second opinion is at sha256 {tool_sha[:16]}..., not {RECHECK_TOOL_SHA256[:16]}...: '
               f'the step-(iii) inference is about THAT file and is refused here')
        return ({'ok': False, 'line': line[:200], 'exit': exit_code, 'step': 'refused', 'why': why},
                {'ok': None, 'required': req, 'step': 'refused', 'why': why})
    if exit_code == 0 and line.startswith('RECHECK PASS'):
        return ({'ok': True, 'line': line[:200], 'exit': exit_code, 'step': '(i)+(ii)',
                 'why': 'RECHECK PASS: all pairs re-derived exactly, three outside solvers refuse'},
                {'ok': True, 'required': req, 'step': '(iii)',
                 'why': 'deleting the pinned vertex leaves a verified 3-colouring'})
    if _R3.search(line):
        return ({'ok': True, 'line': line[:200], 'exit': exit_code, 'step': '(i)+(ii)',
                 'why': 'reached step (iii), which in this file is reachable only after (i) and (ii) passed'},
                {'ok': False, 'required': req, 'step': '(iii)', 'why': line[:200]})
    step = '(i)' if _R1.search(line) else '(ii)' if _R2.search(line) else 'unrecognised'
    return ({'ok': False, 'line': line[:200], 'exit': exit_code, 'step': step,
             'why': f'the second opinion itself failed at step {step}'},
            {'ok': None, 'required': req, 'step': 'not reached',
             'why': 'step (iii) never ran: the second opinion failed before it'})


def cmd_land(D, tid='1', quiet=False, deletion_budget=DELETION_BUDGET, gen_cap=GEN_CAP,
             direct_wall=DIRECT_WALL, ball_rank=0):
    """One field, FS-58's full certification path on its cheapest refusing ball."""
    balls = load_jsonl(field_dir(D) / 'balls.jsonl')
    lat = load_jsonl(field_dir(D) / 'lattices.jsonl')
    ref = [b for b in balls.values() if b['verdict'].startswith('Refused') and isinstance(b.get('points'), int)]
    if not ref:
        die(f'no refusing ball on record for d={D}', 1)
    # Which refusing ball to extract from.  NOT the smallest: the smallest sits in the hard band just under the
    # threshold, where a single solve costs 100 s (O3, O4), and an extraction is thousands of solves.  Measured
    # 2026-09-20 at d = 47: the 3,565-point ball refuses in 103.72 s, the 8,629-point one in 0.45 s -- 230x per solve
    # for 2.4x the vertices.  So the cost proxy is points x (solve_seconds + 0.5), which keeps a fast refusal cheap
    # without picking an enormous graph just because the solver saw through it instantly.
    # `ball_rank` is the handle a null needs.  The proxy optimises GENERATION time, and at d = 95 the ball it
    # picks gives a witness whose pinned vertex is redundant, so C.4's minimality control cannot pass on it however
    # long the deletion runs (a resumed deletion skips -- see the phase record).  Ranks 1, 2, ... walk the same
    # ordering, into their own directory, so a standing witness is never overwritten by an experiment.
    ref.sort(key=lambda x: x['points'] * ((x.get('solve_seconds') or 600.0) + 0.5))
    if ball_rank >= len(ref):
        die(f'd={D} has {len(ref)} refusing balls on record; --ball-rank {ball_rank} is out of range', 1)
    b = ref[ball_rank]
    spec, R, pts_n = lat[b['lattice']]['spec_full'], b['R'], b['points']
    out = FS61 / (f'witness-{D}' if ball_rank == 0 else f'witness-{D}-rank{ball_rank}')
    out.mkdir(parents=True, exist_ok=True)
    frame = {json.loads(l)['d']: json.loads(l) for l in open(FS61 / 'frame.jsonl')}
    fr = frame[D]
    # `direct-witness` deletes vertex by vertex and does NOT checkpoint; `extract` runs assumption-core rounds to a
    # fixpoint and writes steps.jsonl after each, so a kill costs one round.  Measured 2026-09-20: direct-witness on
    # d = 359's 46,421-point ball was still running at 33 minutes with nothing on disk, while FS-58's `extract` did a
    # 440,077-point ball over d = 23 in about eleven.  Anything above ~20,000 points therefore goes the checkpointed
    # way -- both because it is faster here and because a run over ~15 minutes must be resumable (plan rule 1).
    big = pts_n > DIRECT_MAX_POINTS
    proxy = pts_n * ((b.get('solve_seconds') or 600.0) + 0.5)
    print(f'fs61 land d={D}: cheapest refusing ball {pts_n} points at R={R} on {spec} '
          f'(refused in {b.get("solve_seconds")} s; cost proxy {proxy:.0f}); '
          f'{"checkpointed extract" if big else "direct-witness"}', flush=True)
    rec = {'key': str(D) if ball_rank == 0 else f'{D}#rank{ball_rank}', 'd': D, 'ball_rank': ball_rank,
           'spec': spec, 'R': R, 'ball_points': pts_n, 'lattice': b['lattice'],
           'ball_solve_seconds': b.get('solve_seconds'), 'selection': 'points x (solve_seconds + 0.5)',
           'generator': 'extract' if big else 'direct-witness', 'machine': MACHINE, 'tier': tid,
           # The tier that ASKED the ball this witness comes from, read off the ball's own record.  `tier` above is
           # only the flag the command was given, and the two differ as soon as a later tier finds the refusal --
           # which is what phase B' (tier 1b) can do (2026-09-20).
           'ball_tier': b.get('tier'), 'ball_tier_sha256': b.get('tier_sha256')}
    # Re-ask only with a bigger budget -- FS-58's rule for `Unknown` balls, applied to the deletion.  A witness
    # whose deletion was stopped is not final: a larger `--deletion-budget` than the one that produced it is a
    # request to shrink it further, and skipping generation because witness.json exists would silently ignore the
    # flag (it did, at d = 95, 2026-09-20).  An equal or smaller budget still skips, so a plain re-run is cheap.
    prev = load_jsonl(FS61 / 'landings.jsonl').get(rec['key'], {})
    prev_budget = (prev.get('generation') or {}).get('deletion_budget_s')
    if ((prev.get('minimality') or {}).get('minimal') == 'no' and prev_budget is not None
            and deletion_budget > prev_budget and (out / 'witness.json').exists()):
        print(f'    deletion budget raised {prev_budget:.0f} -> {deletion_budget:.0f} s on a witness whose deletion '
              f'was stopped: regenerating from the checkpoint', flush=True)
        (out / 'witness.json').unlink()
    if not (out / 'witness.json').exists():
        t0 = time.time()
        gi = run_generation(D, spec, R, out, big, deletion_budget=deletion_budget, gen_cap=gen_cap,
                            direct_wall=direct_wall)
        rec['generate_seconds'] = round(time.time() - t0, 1)
        rec['generation'] = gi
        rec['generator'] = gi['generator']            # the fallback may have changed it; run-all.sh must match
        big = gi['generator'] == 'extract'
        if not gi['ok']:
            rec['result'] = 'FAIL: generation'
            defect(f'land d={D}: no witness.json after {rec["generate_seconds"]:.0f} s; '
                   f'see {rel(out / "generate.out")}. Re-running `land {D}` resumes from steps.jsonl.')
            append(FS61 / 'landings.jsonl', rec)
            return [D]
    else:
        rec['generate_seconds'] = 0.0
        rec['generation'] = {'ok': True, 'passes': [], 'stopped': None,
                             'note': 'witness.json was already on disk; generation skipped (resume)'}
    w = json.loads((out / 'witness.json').read_text())
    rec['minimality'] = mn = _minimality(w)
    pts, edges = w['points'], w['edges']
    rec.update({'points': len(pts), 'edges': len(edges), 'pinned_edge': w['pinned_edge'],
                'lcm_denominator': math.lcm(*[p[4] for p in pts]),
                'witness_sha256': hashlib.sha256((out / 'witness.json').read_bytes()).hexdigest()})
    steps = {}
    def run(name, cmd, want, fname, where='first'):
        """`want` = (the marker, the expected exit-zero-ness); `where` says which line carries it.  The frozen
        checker puts its verdict on the FIRST line, but `--controls` prints one `[PASS] …` row per planted fault
        and its verdict `CONTROLS ALL PASS` on the LAST -- so a first-line test can never see it, which is what
        it did until 2026-09-20.  The exit status is read from the command, never through a pipe (rule 8)."""
        t = time.time()
        p = subprocess.run(cmd, capture_output=True, text=True, cwd=str(ROOT))
        (out / fname).write_text(p.stdout + p.stderr)
        lines = p.stdout.strip().splitlines() or ['']
        line = lines[0] if where == 'first' else lines[-1]
        ok = (p.returncode == 0) == want[1] and line.startswith(want[0])
        steps[name] = {'exit': p.returncode, 'line': line[:200], 'ok': ok, 'verdict_line': where,
                       'seconds': round(time.time() - t, 1), 'file': fname,
                       'rows': {'PASS': sum(1 for l in lines if l.lstrip().startswith('[PASS]')),
                                'FAIL': sum(1 for l in lines if l.lstrip().startswith('[FAIL]'))}}
        print(f"    {name:22s} exit {p.returncode:2d}  {'PASS' if ok else 'FAIL'}  {line[:96]}", flush=True)
        return ok
    CK = [sys.executable, str(ROOT / 'tools' / 'fs58_check_witness.py')]
    ok = run('C.1 certificate', CK + ['--radicand', str(D), str(out / 'witness.json')], ('CERTIFIED', True), 'certified.out')
    ok &= run('C.2 planted faults', CK + ['--radicand', str(D), '--controls', str(out / 'witness.json')],
              ('CONTROLS ALL PASS', True), 'controls.out', where='last')
    ok &= run('C.3 wrong radicand', CK + ['--radicand', str(D + 12), str(out / 'witness.json')], ('REFUSED', False),
              'wrong-radicand.out')
    # C.4 is ONE command carrying TWO claims, scored separately since the owner's ruling 1 after phase C.
    tool = ROOT / 'tools' / 'fs58_recheck_witness.py'
    p4 = subprocess.run([sys.executable, str(tool), str(D), str(out / 'witness.json')],
                        capture_output=True, text=True, cwd=str(ROOT))
    (out / 'recheck.out').write_text(p4.stdout + p4.stderr)
    line4 = (p4.stdout.strip().splitlines() or [''])[0]
    a4, b4 = classify_recheck(line4, p4.returncode, mn['minimal'],
                              hashlib.sha256(tool.read_bytes()).hexdigest())
    a4['file'], a4['seconds'] = 'recheck.out', None
    steps['C.4a second opinion'] = a4
    steps['C.4b pinned-vertex'] = b4
    ok &= bool(a4['ok'])
    print(f"    {'C.4a second opinion':22s} exit {p4.returncode:2d}  {'PASS' if a4['ok'] else 'FAIL'}  {a4['why'][:96]}",
          flush=True)
    print(f"    {'C.4b pinned-vertex':22s}        "
          f"{'PASS' if b4['ok'] else ('FAIL' if b4['ok'] is False else 'n/a ')}  "
          f"{'required (C.9 says 1-minimal)' if b4['required'] else 'recorded, not required (C.9 says not 1-minimal)'}"
          f" -- {b4['why'][:70]}", flush=True)
    col = four_colour(pts, edges)
    steps['C.5 four colours'] = {'ok': col is not None, 'colours': len(set(col)) if col else None}
    if col:
        (out / 'colouring4.json').write_text(json.dumps({'colouring': col, 'colours': len(set(col)),
                                                         'verified': 'proper on every edge, checked in this file\'s producer'},
                                                        separators=(',', ':')) + '\n')
    print(f"    {'C.5 four colours':22s}        {'PASS' if col else 'FAIL'}  a proper 4-colouring using "
          f"{len(set(col)) if col else '-'} colours, verified on all {len(edges)} edges", flush=True)
    nb = barrier_edge_count(D, pts, edges)
    steps['C.6 3-adic barrier'] = {'ok': nb > 0, 'edges_with_3_in_denominator': nb}
    print(f"    {'C.6 3-adic barrier':22s}        {'PASS' if nb else 'FAIL'}  {nb} of {len(edges)} edges have a "
          f"direction with 3 in its reduced denominator", flush=True)
    L, Lp = fr['L'], fr['L_prime']
    src = ('the dyadic prime, inert in K, residue F_4 ([Fischer1990] Thm 9)' if Lp == 2 else
           f'the residue plane at {Lp} ([Moorhouse2010] Thm 8.1)')
    value = f'chi(Q(sqrt{D})^2) = 4' if L == 4 else f'4 <= chi(Q(sqrt{D})^2) <= {L}'
    steps['C.7 the value'] = {'ok': True, 'value': value, 'upper_source': src, 'L': L}
    mn = rec['minimality']
    steps['C.9 minimality'] = {'ok': True, **mn}          # recorded, never required (gate C.9)
    print(f"    {'C.9 minimality':22s}        NOTE  {mn['note']}", flush=True)
    # A named diagnosis for the one failure the deletion budget can cause.  C.4's third step asks whether deleting
    # the pinned edge's second vertex leaves a 3-colourable graph -- a MINIMALITY question, not a soundness one, so
    # it can fail on a witness the frozen checker has already CERTIFIED.  `extract` deletes outward-in, so the pin
    # (at the translated origin) is tested last and a stopped deletion never reaches it: whether it is load-bearing
    # is then luck.  Measured 2026-09-20: pass at d = 359, 143, 23 with stopped deletions, fail at d = 95.
    why = None
    if b4['ok'] is False and mn['minimal'] == 'no':
        why = (f'C.4b, the pinned-vertex MINIMALITY control, is red; C.4a -- the second opinion proper -- passed, '
               f'and so did C.1 and every one of C.2\'s plants. The deletion was stopped at {mn["stopped_at"]} of '
               f'{mn["of_tests"]}, leaving the pinned vertex redundant. A larger --deletion-budget CANNOT fix this: '
               f'the frozen extract resumes a deletion at a stale scan position and so skips, and only a '
               f'from-scratch run can be 1-minimal. Regenerate on a smaller ball: `land {D} --ball-rank <k>`.')
        print(f'    NOTE  {why}', flush=True)
    rec.update({'steps': steps, 'value': value, 'L': L, 'upper_source': src, 'diagnosis': why,
                'result': 'CERTIFIED' if (ok and col and nb) else 'INCOMPLETE'})
    write_witness_readme(D, out, rec, w, fr)
    write_witness_scripts(D, out, rec)
    append(FS61 / 'landings.jsonl', rec)
    man = {'key': rec['key'], 'd': D, 'ball_rank': ball_rank, 'path': rel(out), 'points': len(pts), 'edges': len(edges),
           'lcm_denominator': rec['lcm_denominator'], 'pinned_edge': w['pinned_edge'],
           'witness_sha256': rec['witness_sha256'],
           'lrat_sha256': hashlib.sha256((out / 'witness.lrat.gz').read_bytes()).hexdigest()
                          if (out / 'witness.lrat.gz').exists() else None,
           'found_by': 'ball', 'spec': spec, 'R': R, 'certified': rec['result'] == 'CERTIFIED',
           'minimal': mn['minimal'], 'deletion_stopped_at': mn['stopped_at'],
           'value': value, 'upper_source': src, 'machine': MACHINE, 'claim_scope': 'checker'}
    append(FS61 / 'witnesses.jsonl', man)
    print(f'  d={D}: {len(pts)} points, {len(edges)} edges -> {rec["result"]}; {value}; '
          f'{"1-minimal" if mn["minimal"] == "yes" else mn["minimal"]}', flush=True)
    if b4['required'] and b4['ok'] is False:
        # The owner's ruling: this HALTS.  The certificate is untouched (C.4a passed), so `result` stays
        # CERTIFIED and the census is right; what is wrong is that two recorded facts about the same witness
        # contradict each other -- C.9 says 1-minimal, step (iii) says the pinned vertex is redundant -- and a
        # human has to decide which is lying.  So it is named, and the exit status is non-zero.
        defect(f'land d={D}: C.4b is RED on a witness C.9 records as 1-minimal. The certificate stands (C.4a '
               f'passed), but the generator and the recheck disagree about this object. HALT: {b4["why"]}')
        return [D]
    return [] if rec['result'] == 'CERTIFIED' else [D]


def _c4b_readme(rec):
    """The README's one clause about the pinned-vertex control, which is a MINIMALITY question and not part of
    the certificate (C.9's clause, the owner's ruling 4)."""
    b = rec['steps'].get('C.4b pinned-vertex')
    if b is None:
        return 'this record predates the C.4a/C.4b split — re-run `land` on this field to score it'
    if b.get('ok'):
        return 'it passes'
    if b.get('ok') is False:
        return ('**it does not pass here** — this witness is not 1-minimal, which costs size and never soundness: '
                'a refusing set refuses whether or not it is smallest')
    return 'it was not reached'


def _kernel_note(D):
    """d = 11 is the one field where a kernel theorem exists, and it is about a DIFFERENT GRAPH.  A reader who meets
    `χ(ℚ(√11)²) ≥ 4` in two places must not conclude that this witness is the kernel-checked one (the owner's
    correction, 2026-09-20)."""
    if D != 11:
        return ''
    return ('\n\nA kernel proof of this field\'s lower bound does exist — `four_le_chromaticNumber_planeOver_eleven` '
            'in `Proofs/HadwigerNelson/Instances/SqrtEleven.lean` — but it is **not about this graph**. It rests on '
            'FS-58\'s **204-point chain witness**, built by a different route (a forcer copied along a chain, not a '
            'ball of a lattice). The 189 points here are this census\'s own, and they are certified by the checker '
            'above and by nothing stronger.')


def _gate_caveat(rec):
    """A reviewer reads this file, so a gate item that did not go green belongs in it -- above the claims, not in a
    phase record they will never open."""
    if not rec.get('diagnosis'):
        return ''
    return (f"**One gate item did not go green, and it is not about this certificate.** {rec['diagnosis']} The "
            f"certificate above is unaffected: the frozen checker re-derives the graph from the coordinates and "
            f"refutes it, and a refusing set refuses whether or not it is smallest.\n\n")


def _secs(x):
    """A measured time a reader can use.  Printing `0.0 s` for a check that really does finish instantly reads like
    a missing measurement, and `?` reads like a promise nobody made."""
    if x is None:
        return 'not timed on this run'
    return 'well under a second' if x < 1 else f'{x:.0f} s'


def write_witness_readme(D, out, rec, w, fr):
    n3 = rec['steps']['C.6 3-adic barrier']['edges_with_3_in_denominator']
    (out / 'README.md').write_text(f'''# `χ(ℚ(√{D})²) ≥ 4` — a witness, and the one command that re-checks it

**The claim.** The {rec['points']} points listed in `witness.json` all lie in `ℚ(√{D})²`, and the graph joining the pairs
exactly 1 apart has **no proper 3-colouring**. So the plane over `ℚ(√{D})` needs at least four colours.

**Re-check it with one command** ({_secs(rec['steps']['C.1 certificate'].get('seconds'))} on the machine that wrote this; it needs nothing from this project but Python):

```
python3 tools/fs58_check_witness.py --radicand {D} data/fs61/witness-{D}/witness.json
```

That checker is **standard library only and imports nothing from `tools/`** — it shares no code with the program that
found this graph. It (1) checks every point is a reduced integer tuple standing for a point of `ℚ(√{D})²`; (2)
**re-derives every pair at distance exactly 1 itself, in integer arithmetic**, and refuses unless that set equals the
edge list in the file; (3) checks the pinned pair is a real edge; (4) builds the CNF from *its own* edge set; and (5)
checks the LRAT proof against that CNF with its own checker. Output: `CERTIFIED` and exit 0, or `REFUSED <CODE>` and
exit 1.

{_gate_caveat(rec)}**What is not claimed.** The matching **upper** bound is prior art, not ours: {rec['upper_source']} gives
`χ(ℚ(√{D})²) ≤ {fr['L']}`. With it, **{rec['value']}**. Nothing here proves the upper bound.
**And nothing here is checked by the Lean kernel**: the certificate above is the standard-library checker's, and that
is a different and weaker thing.{_kernel_note(D)}

**What else was checked** (each file below is in this directory, the verbatim output of the command named):

| file | command | result |
|---|---|---|
| `certified.out` | the checker above | `{rec['steps']['C.1 certificate']['line'][:60]}…` |
| `controls.out` | `… --controls witness.json` | `{rec['steps']['C.2 planted faults']['line'][:40]}` — {rec['steps']['C.2 planted faults']['rows']['PASS']} rows pass, {rec['steps']['C.2 planted faults']['rows']['FAIL']} fail: the faithful twin certified, and each planted fault refused **for its named reason** |
| `wrong-radicand.out` | `… --radicand {D + 12} witness.json` | `REFUSED`, exit 1 — the witness is about **this** field |
| `recheck.out` | `tools/fs58_recheck_witness.py {D} witness.json` | **the second opinion** — every pair re-tested in exact `Fraction` arithmetic and three solvers outside the generator's (Lingeling, CaDiCaL 1.5.3, MapleChrono) refusing it: {(rec['steps'].get('C.4a second opinion') or {}).get('why', 'not scored on this record')[:90]}. Its last step is a separate, **minimality** question — does deleting the pinned vertex leave a 3-colouring — and {_c4b_readme(rec)} |
| `colouring4.json` | — | an explicit proper **4**-colouring, verified on all {rec['edges']} edges: four colours suffice for this graph, so it is exactly 4-chromatic |

**The 3-adic barrier, as a check on the object.** {n3} of the {rec['edges']} edges have a direction with 3 in its
reduced denominator. The kernel result (`ThreeAdicBarrier.lean`, `CLAUDE.md` row 72) says a graph over this field that
needs four colours **must** contain such a direction — directions integral at 3 are 3-colourable outright — so a zero
here would be a defect in the search, not a discovery.

**Sizes and hashes.** {rec['points']} points, {rec['edges']} edges, least common denominator
{rec['lcm_denominator']}; pinned edge {w['pinned_edge']}. `witness.json` sha256 `{rec['witness_sha256'][:32]}…`.

**How it was found** — provenance, never evidence. A ball of radius {rec['R']} about the origin in the saturated
lattice `{rec['spec']}` over `ℚ(√{D})` ({rec['ball_points']} points) was refused three colours by a solver, and that
refusal was shrunk by `tools/fs58_search.py {rec['generator']}`. **{rec['minimality']['note'][0].upper() + rec['minimality']['note'][1:]}.**
{'Minimality is not part of the claim and not part of the certificate: **a witness that is not 1-minimal is not a weaker certificate** — a refusing set refuses whether or not it is smallest, and minimality buys size (the checker time, and the kernel cost of a later formalisation), never soundness.' if rec['minimality']['minimal'] != 'yes' else ''}
None of this is part of the certificate either: the checker re-derives the graph from the coordinates alone.
Regenerate with `./run-all.sh` (read its header first if the deletion was stopped).
''')


def write_witness_scripts(D, out, rec):
    """`run-all.sh` and `.gitignore`, from the landing record alone.  `steps.jsonl` is the extraction checkpoint --
    megabytes of lattice coordinates, provenance and not evidence -- and FS-58 gitignores it in witness-23, -95 and
    -11 for exactly that reason; this follows FS-58, and says out loud what that costs a from-scratch rerun."""
    big, spec, R, mn = rec['generator'] == 'extract', rec['spec'], rec['R'], rec['minimality']
    if big:
        (out / '.gitignore').write_text('steps.jsonl\n')
    elif (out / '.gitignore').exists():
        (out / '.gitignore').unlink()
    stop_note = ('' if mn['minimal'] != 'no' else f'''#
# NOTE -- what "byte-identical" means here.  The pass condition is byte-identical witness.json from the
# COMMITTED WITNESS DIRECTORY, and this witness's deletion was STOPPED at position {mn["stopped_at"]} of
# {mn["of_tests"]}, so the gitignored steps.jsonl checkpoint is part of what makes that true: `--stop-deletion`
# below reproduces this file only with that SAME checkpoint present.  What a rerun WITHOUT it produces, both
# deterministic: with `--stop-deletion`, the core rounds rerun and the deletion stops at position 0, giving the
# LARGER core-round witness; without the flag, the full deletion runs and gives a SMALLER 1-minimal one (slow --
# at d = 359 it ran at 45 s a step).  A stopped deletion is never *finished* later: the frozen extract resumes at
# a stale scan position and skips, so only a from-scratch run is 1-minimal.  And none of this is the evidence:
# what a reviewer checks is `witness.json` + `witness.lrat.gz` AS COMMITTED, through the frozen checker.''')
    (out / 'run-all.sh').write_text(f'''#!/usr/bin/env bash
# Regenerate {rel(out)} (FS-61 phase C).  The generator is deterministic.{stop_note}
set -euo pipefail
cd "$(dirname "$0")/../../.."
source scripts/dev-env.sh >/dev/null 2>&1 || true
D={rel(out)}
python3 tools/fs58_search.py {'extract' if big else 'direct-witness'} {D} {spec} {R} $D{
        ' --stop-deletion' if mn['minimal'] == 'no' else ''} > $D/generate.out
python3 tools/fs58_check_witness.py --radicand {D} $D/witness.json > $D/certified.out
python3 tools/fs58_check_witness.py --radicand {D} --controls $D/witness.json > $D/controls.out
python3 tools/fs58_recheck_witness.py {D} $D/witness.json > $D/recheck.out
echo "run-all: done"
''')
    (out / 'run-all.sh').chmod(0o755)


def cmd_land_readme(fields=None):
    """Rewrite the consumer-facing files -- README.md, run-all.sh, .gitignore -- from the landing records already
    on disk, asking no solver and touching no certificate.  The README is the surface a reviewer reads, so it gets
    edited more often than the evidence does; without this, fixing a sentence in it would mean re-running the whole
    gate (seven minutes at d = 359) to regenerate one paragraph."""
    land = load_jsonl(FS61 / 'landings.jsonl')
    frame = {json.loads(l)['d']: json.loads(l) for l in open(FS61 / 'frame.jsonl')}
    todo = fields or [d for d in LAND_ORDER if land.get(str(d), {}).get('result') == 'CERTIFIED']
    bad = []
    for D in todo:
        rec = land.get(str(D))
        if not rec or 'steps' not in rec:      # a named field is rewritten whatever its result; a default sweep
            defect(f'land-readme d={D}: no landing record with gate steps')   # takes only the certified ones
            bad.append(D)
            continue
        out = FS61 / f'witness-{D}'
        w = json.loads((out / 'witness.json').read_text())
        write_witness_readme(D, out, rec, w, frame[D])
        write_witness_scripts(D, out, rec)
        print(f'  d={D}: README.md, run-all.sh rewritten from the landing record', flush=True)
    print(f'DONE land-readme: {len(todo)} fields, {len(bad)} without a record', flush=True)
    return bad


LAND_ORDER = [359, 11, 119, 143, 47, 95, 191, 71, 23]     # the owner's priority: the four with no certificate first


def land_order(refusing=None, quiet=False):
    """Every field with a refusing ball on record, in the owner's phase-C priority order, with any field that has
    refused SINCE that order was written appended and announced.  Read from the records, because a hardcoded list
    silently skips a field a later tier lands -- which is exactly what phase B' can produce.
    `refusing` is for the selftest: it plants a refusing field the committed order does not know about."""
    if refusing is None:
        refusing = {D for D in FAMILY_500
                    if any(b['verdict'].startswith('Refused')
                           for b in load_jsonl(field_dir(D) / 'balls.jsonl').values())}
    extra = sorted(D for D in refusing if D not in LAND_ORDER)
    if extra and not quiet:
        print(f'fs61 land-all: {len(extra)} field(s) refusing since the phase-C priority order was written, '
              f'appended: {extra}', flush=True)
    return LAND_ORDER + extra


def cmd_land_all(fields=None, tid='1', deletion_budget=DELETION_BUDGET, gen_cap=GEN_CAP,
                 direct_wall=DIRECT_WALL):
    """Phase C over every refusing field, resumable: a field whose landing record says CERTIFIED is skipped."""
    done = load_jsonl(FS61 / 'landings.jsonl')
    todo = fields or land_order()
    already = [d for d in todo if done.get(str(d), {}).get('result') == 'CERTIFIED']
    print(f'fs61 land-all: {len(todo)} fields in the order {todo}; {len(already)} already certified {already}, '
          f'{len(todo) - len(already)} to do. Deletion budget {deletion_budget:.0f} s per field, generation cap '
          f'{gen_cap:.0f} s. Resume = re-run this identical command.', flush=True)
    bad, cert, T0 = [], [], time.time()
    for n, D in enumerate(todo, 1):
        if done.get(str(D), {}).get('result') == 'CERTIFIED':
            continue
        t0 = time.time()
        r = cmd_land(D, tid, deletion_budget=deletion_budget, gen_cap=gen_cap, direct_wall=direct_wall)
        bad += r
        if not r:
            cert.append(D)
        print(f'  [{n}/{len(todo)} d={D} took {time.time() - t0:.0f} s; running total '
              f'{len(cert)} certified, {len(bad)} not, {time.time() - T0:.0f} s elapsed]', flush=True)
    print(f'DONE land-all: {len(todo)} fields, {len(cert)} certified here {cert}, {len(bad)} not certified {bad}, '
          f'{len(already)} skipped (already on record); {time.time() - T0:.0f} s', flush=True)
    return bad


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

    p = sub.add_parser('filter', help='the colourability certificates: forms, quotients, inheritance')
    p.add_argument('d', type=int); p.add_argument('--tier', default='1')
    p.add_argument('--reverify', action='store_true'); p.add_argument('--no-quotients', action='store_true')
    p = sub.add_parser('census-field', help='one field, tier 1: lattices -> filter -> scan')
    p.add_argument('d', type=int); p.add_argument('--tier', default='1'); p.add_argument('--jobs', type=int, default=16)
    p.add_argument('--budget', type=float, default=7200)
    p = sub.add_parser('census', help='tier 1 over the whole family in ascending d, resumable')
    p.add_argument('--tier', default='1'); p.add_argument('--jobs', type=int, default=16)
    p.add_argument('--budget', type=float, default=7200); p.add_argument('--fields', type=int, nargs='*')

    p = sub.add_parser('degree-ask', help='phase E.1a: one ball per Open lattice, at the radius the degree rule picks')
    p.add_argument('--tier', default='1c')
    p.add_argument('--jobs', type=int, help='pool width -- NO default: at this cap it is available memory / measured peak')
    p.add_argument('--budget', type=float); p.add_argument('--fields', type=int, nargs='*')
    p.add_argument('--arm', choices=('R14', 'Rcap'), help='ask only this arm (R14 first: 43 of 43 such balls decided)')
    p.add_argument('--limit', type=int, help='ask only the first N of the plan, in its own order')
    p.add_argument('--plan', action='store_true', help='print the balls the rule would ask and stop')

    p = sub.add_parser('deepen', help='phase E.1b: deeper lattices at the same cap, then the ladder over them')
    p.add_argument('--tier', default='2l')
    p.add_argument('--jobs', type=int, help='pool width; required for the ball stage (see degree-ask)')
    p.add_argument('--budget', type=float); p.add_argument('--fields', type=int, nargs='*')
    p.add_argument('--stages', default='all', choices=('all', 'lattices', 'balls'),
                   help='`lattices` builds and filters only (the priced stage); `balls` runs the ladder only')
    p.add_argument('--girth', action='store_true', help='compute the odd girth too (about 900x the cost)')

    p = sub.add_parser('ladder', help="phase B': the radius ladder for one field (tier 1b), resumable")
    p.add_argument('d', type=int); p.add_argument('--tier', default='1b'); p.add_argument('--jobs', type=int, default=16)
    p.add_argument('--budget', type=float, help='stop asking after this many seconds (resume = re-run)')
    p.add_argument('--plan', action='store_true', help='print the rung the rule selects for every lattice; ask nothing')
    p = sub.add_parser('ladder-all', help="phase B' over the whole family in ascending d, resumable")
    p.add_argument('--tier', default='1b'); p.add_argument('--jobs', type=int, default=16)
    p.add_argument('--budget', type=float); p.add_argument('--fields', type=int, nargs='*')

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
    sub.add_parser('witness-lattices', help="A.5: each certified witness's own lattice must not be Colourable")
    sub.add_parser('dead-quotients', help="A.6: which quotients kill, from FS-58's qscreen records")
    sub.add_parser('minimal-quotient', help='A.7: the group behind a dead lattice\'s periodic 3-colouring')
    p = sub.add_parser('table', help='the derived census table (never hand-edited)')
    p.add_argument('--check', action='store_true')
    p.add_argument('--tier', default=None, help='default: the deepest tier with ball records, read from the records')
    budget_help = ('seconds of one-vertex-at-a-time deletion per field before the generator is stopped and the '
                   'witness emitted from its last checkpoint; minimality is recorded, never required (gate C.9)')
    cap_help = 'a backstop on one field\'s whole generation call; 0 disables it. A field it stops stays resumable'
    wall_help = ('seconds before `direct-witness` -- which cannot checkpoint -- is stopped and the checkpointed '
                 '`extract` takes over the same ball')
    p = sub.add_parser('land', help="phase C: FS-58's full certification path on a field's cheapest refusing ball")
    p.add_argument('d', type=int); p.add_argument('--tier', default='1')
    p.add_argument('--deletion-budget', type=float, default=DELETION_BUDGET, help=budget_help)
    p.add_argument('--gen-cap', type=float, default=GEN_CAP, help=cap_help)
    p.add_argument('--direct-wall', type=float, default=DIRECT_WALL, help=wall_help)
    p.add_argument('--ball-rank', type=int, default=0,
                   help='which refusing ball to shrink, 0 = cheapest by the cost proxy; a non-zero rank writes to '
                        'data/fs61/witness-<d>-rank<k>/ and its own landing key, so the standing witness is safe')
    p = sub.add_parser('land-readme', help='rewrite README.md/run-all.sh from the landing records; no solver')
    p.add_argument('--fields', type=int, nargs='*')
    p = sub.add_parser('land-all', help='phase C over every refusing field, in priority order, resumable')
    p.add_argument('--tier', default='1'); p.add_argument('--fields', type=int, nargs='*')
    p.add_argument('--deletion-budget', type=float, default=DELETION_BUDGET, help=budget_help)
    p.add_argument('--gen-cap', type=float, default=GEN_CAP, help=cap_help)
    p.add_argument('--direct-wall', type=float, default=DIRECT_WALL, help=wall_help)

    a = ap.parse_args()
    t0 = time.time()
    bad = []
    if a.cmd == 'lattices':
        _, bad = cmd_lattices(a.d, a.tier, nmax=a.nmax, jobs=a.jobs, reverify=a.reverify, girth=not a.no_girth)
    elif a.cmd == 'filter':
        bad = cmd_filter_reverify(a.d) if a.reverify else cmd_filter(a.d, a.tier, quotients=not a.no_quotients)[1]
    elif a.cmd == 'census-field':
        bad = cmd_census_field(a.d, a.tier, jobs=a.jobs, budget=a.budget)
    elif a.cmd == 'census':
        bad = cmd_census(fields=a.fields or None, tid=a.tier, jobs=a.jobs, budget=a.budget)
    elif a.cmd == 'degree-ask':
        bad = cmd_degree_ask(a.tier, fields=a.fields or None, jobs=a.jobs, budget=a.budget, show_plan=a.plan,
                             only_arm=a.arm, limit=a.limit)
    elif a.cmd == 'deepen':
        bad = cmd_deepen(fields=a.fields or None, tid=a.tier, jobs=a.jobs, budget=a.budget, stages=a.stages,
                         girth=a.girth)
    elif a.cmd == 'ladder':
        bad = cmd_ladder(a.d, a.tier, jobs=a.jobs, budget=a.budget, show_plan=a.plan)
    elif a.cmd == 'ladder-all':
        bad = cmd_ladder_all(fields=a.fields or None, tid=a.tier, jobs=a.jobs, budget=a.budget)
    elif a.cmd == 'table':
        bad = cmd_table(check=a.check, tid=a.tier)
    elif a.cmd == 'scan':
        if a.reverify:
            bad = cmd_scan_reverify(a.d)
        else:
            _, bad = cmd_scan(a.d, a.tier, filter_off=a.filter_off, only_key=a.key, radii=a.radius, jobs=a.jobs, budget=a.budget)
    elif a.cmd == 'witness-lattices':
        bad = cmd_witness_lattices()
    elif a.cmd == 'dead-quotients':
        cmd_dead_quotients()
    elif a.cmd == 'minimal-quotient':
        cmd_minimal_quotient()
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
        bad = cmd_land(a.d, a.tier, deletion_budget=a.deletion_budget, gen_cap=a.gen_cap,
                       direct_wall=a.direct_wall, ball_rank=a.ball_rank)
    elif a.cmd == 'land-readme':
        bad = cmd_land_readme(a.fields or None)
    elif a.cmd == 'land-all':
        bad = cmd_land_all(a.fields or None, a.tier, deletion_budget=a.deletion_budget, gen_cap=a.gen_cap,
                           direct_wall=a.direct_wall)
    print(f'[{a.cmd}: {time.time() - t0:.1f} s wall on {MACHINE.split(" (")[0]}]', flush=True)
    sys.exit(1 if bad else 0)


if __name__ == '__main__':
    main()
