#!/usr/bin/env python3
"""fs66_check_witness -- re-checks, from the definition, a witness that the unit-distance graph over the ring of
integers modulo n cannot be coloured with k colours (FS-66; n = 121, k = 4 is the milestone's first case).

STANDARD LIBRARY ONLY, and it imports nothing from tools/: it shares no code with the graph builder
(tools/fs66_tower.py), with the minimiser, or with the solver. n and k are read from the witness, so the same
checker serves level three (n = 1331) and the prime 19 (n = 361) unchanged.

THE OBJECT. UD(Z/n, 2) has the n^2 points (a, b) of (Z/n)^2, with (a, b) ~ (c, e) exactly when
(a - c)^2 + (b - e)^2 = 1 in Z/n. A witness lists some of those points, some pairs of them, a pinned triangle,
and an LRAT refutation of the k-colouring formula of the listed pairs.

WHAT IS CHECKED, in order.
  1. Structure: the file has exactly the keys it should, n > 1 and k >= 3 are integers, the edge list is not
     empty, and k is at least the pin's size.
  2. Points: each is a pair of integers in [0, n), and no point is listed twice. (The duplicate test is
     HYGIENE, NOT SOUNDNESS: a repeated point would still make the listed graph a homomorphic image of
     UD(Z/n,2) and the refutation would still be valid. It is checked because a repeat is always a mistake.)
  3. Edges: each is a pair i < j of point indices, the list is sorted and has no repeat, and EVERY listed pair
     is re-verified from the definition in integer arithmetic. The number of unit pairs the listed points
     actually span is reported beside the listed number -- SUBSET SEMANTICS: a subgraph that refuses to be
     coloured refutes every graph containing it, so listing fewer pairs is sound (and cheaper for the kernel),
     and nothing is hidden because both counts are printed.
  4. The pin: its three vertices are distinct and pairwise LISTED edges. Colours are interchangeable, so fixing
     a clique's colours is a sound symmetry reduction -- but only while that clique is in the graph being
     refuted, which is why "listed" and not merely "at unit distance" is the test.
  5. The formula: this checker BUILDS the CNF itself, in the order of `Sat/Encoding.lean`'s
     `coloringCNF k n E ++ cubeCNF k n cube` -- variable x(v, c) = k*v + c + 1; clauses 1..P the at-least-one
     clauses in point order; then, per listed edge in listed order, its k conflict clauses; then one unit
     clause per pinned vertex, colours 0, 1, 2. One LRAT file therefore serves both this checker and the Lean
     certificate pipeline. (`--controls` checks that digest against a second, independent builder.)
  6. The proof: an LRAT check by this file's own reverse-unit-propagation checker -- every added clause implied
     using exactly its listed hints in order, every hint unit under the running assignment and the last one
     falsified, deletions honoured, clause ids strictly increasing, and the empty clause added at the end.

If all six pass, the listed graph has no proper k-colouring; it is a subgraph of UD(Z/n, 2), so UD(Z/n, 2) has
none either, and chi(UD(Z/n, 2)) > k.

THE CLOSED LIST OF REFUSAL CODES (nothing is accepted and ignored; every refusal is one of these):
  IO                     a file could not be read, or is not JSON / not an LRAT text
  BAD_WITNESS            the witness's shape: a missing or unknown key, a bad n or k, an empty edge list, or
                         k smaller than the pinned clique
  BAD_POINT              a point is not a pair of integers in [0, n)
  REPEATED_POINT         the same point is listed twice
  BAD_EDGE               an edge is not a pair i < j of point indices, or the list is unsorted or repeats one
  NOT_UNIT_PAIR          a listed pair is not at unit quadrance modulo n -- it is not an edge of UD(Z/n, 2)
  PIN_NOT_CLIQUE         the pinned vertices are not three distinct points that are pairwise listed edges
  PROOF_MALFORMED        a proof line is not an LRAT line
  PROOF_BAD_HINT         a hint names no clause in the database, or is satisfied, or is not unit, or is
                         falsified before the last hint
  PROOF_STEP_NOT_RUP     an added clause's hints propagate to no conflict, or its id is not fresh, or it uses
                         a variable the formula does not have
  PROOF_NO_EMPTY_CLAUSE  the proof ends without deriving the empty clause
  CNF_DIGEST_MISMATCH    (--controls only) a second, independent builder produces a different formula

USAGE
  fs66_check_witness.py WITNESS.json [PROOF.lrat[.gz]]   -> CERTIFIED (exit 0) or REFUSED <CODE>: … (exit 1)
  fs66_check_witness.py --controls WITNESS.json [PROOF]  -> one row per planted fault, each refused for its
                                                            named reason, plus a faithful twin; exit 0 only if
                                                            every row behaved
  fs66_check_witness.py --help                           -> this text
The proof defaults to witness.lrat.gz beside the witness file. CERTIFIED is this checker's word, NOT the Lean
kernel's; the kernel statement is a separate phase.
"""
import gzip
import hashlib
import json
import os
import shutil
import subprocess
import sys
import tempfile
import time

WITNESS_KEYS = {'kind', 'n', 'k', 'points', 'edges', 'pin', 'provenance'}
REQUIRED_KEYS = {'kind', 'n', 'k', 'points', 'edges', 'pin'}


class Refusal(Exception):
    def __init__(self, code, detail):
        super().__init__(f'{code}: {detail}')
        self.code, self.detail = code, detail


# ---------------------------------------------------------------- 1. structure

def read_witness(path):
    try:
        with open(path, 'rb') as f:
            raw = f.read()
        W = json.loads(raw)
    except (OSError, ValueError) as ex:
        raise Refusal('IO', f'{path}: {ex}')
    if not isinstance(W, dict):
        raise Refusal('BAD_WITNESS', f'{path} is not a JSON object')
    extra = sorted(set(W) - WITNESS_KEYS)
    if extra:
        raise Refusal('BAD_WITNESS', f'unknown key {extra[0]!r} (this checker accepts only '
                                     f'{sorted(WITNESS_KEYS)} and refuses rather than ignore anything else)')
    missing = sorted(REQUIRED_KEYS - set(W))
    if missing:
        raise Refusal('BAD_WITNESS', f'missing key {missing[0]!r}')
    if W['kind'] != 'fs66-witness':
        raise Refusal('BAD_WITNESS', f'kind is {W["kind"]!r}, not "fs66-witness"')
    n, k = W['n'], W['k']
    if type(n) is not int or n < 2:
        raise Refusal('BAD_WITNESS', f'n is {n!r}; it must be an integer greater than 1 (the modulus)')
    if type(k) is not int or k < 3:
        raise Refusal('BAD_WITNESS', f'k is {k!r}; it must be an integer of at least 3 (the colour count)')
    return W, raw, n, k


# ---------------------------------------------------------------- 2. points

def read_points(raw_pts, n):
    if not isinstance(raw_pts, list) or not raw_pts:
        raise Refusal('BAD_WITNESS', 'points is not a non-empty list')
    pts = []
    for i, p in enumerate(raw_pts):
        if not (isinstance(p, list) and len(p) == 2 and all(type(x) is int for x in p)):
            raise Refusal('BAD_POINT', f'point {i} is not a pair of integers: {p!r}')
        if not (0 <= p[0] < n and 0 <= p[1] < n):
            raise Refusal('BAD_POINT', f'point {i} = ({p[0]}, {p[1]}) has a coordinate outside '
                                       f'[0, {n}), so it is not a point of (Z/{n})^2')
        pts.append((p[0], p[1]))
    seen = {}
    for i, p in enumerate(pts):
        if p in seen:
            raise Refusal('REPEATED_POINT', f'points {seen[p]} and {i} are both ({p[0]}, {p[1]})')
        seen[p] = i
    return pts


# ---------------------------------------------------------------- 3. edges, re-verified from the definition

def quadrance(n, u, v):
    """(a - c)^2 + (b - e)^2 reduced modulo n -- the one predicate the whole milestone agrees on."""
    return ((u[0] - v[0]) ** 2 + (u[1] - v[1]) ** 2) % n


def read_edges(raw_edges, pts, n):
    if not isinstance(raw_edges, list) or not raw_edges:
        raise Refusal('BAD_WITNESS', 'edges is an empty or non-list value; a refutation needs edges')
    P = len(pts)
    E = []
    for m, e in enumerate(raw_edges):
        if not (isinstance(e, list) and len(e) == 2 and all(type(x) is int for x in e)):
            raise Refusal('BAD_EDGE', f'edge {m} is not a pair of integers: {e!r}')
        i, j = e
        if not (0 <= i < j < P):
            raise Refusal('BAD_EDGE', f'edge {m} is [{i}, {j}]; it must be two point indices with '
                                      f'0 <= i < j < {P}')
        if E and (i, j) <= E[-1]:
            raise Refusal('BAD_EDGE', f'edge {m} = [{i}, {j}] does not come after edge {m - 1} = '
                                      f'{list(E[-1])}; the list must be sorted and repeat nothing '
                                      f'(the certificate addresses clauses by position)')
        E.append((i, j))
    one = 1 % n
    for m, (i, j) in enumerate(E):
        q = quadrance(n, pts[i], pts[j])
        if q != one:
            a, b = pts[i]
            c, e2 = pts[j]
            raise Refusal('NOT_UNIT_PAIR',
                          f'edge {m}: point {i} = ({a}, {b}) and point {j} = ({c}, {e2}): '
                          f'({a} - {c})^2 + ({b} - {e2})^2 = {(a - c) ** 2} + {(b - e2) ** 2} = '
                          f'{(a - c) ** 2 + (b - e2) ** 2} = {q} (mod {n}), not {one} -- '
                          f'they are not at unit distance, so this is not an edge of UD(Z/{n},2)')
    return E


def induced_unit_pairs(pts, n):
    """how many of the listed points' pairs ARE unit pairs, by walking the unit circle of (Z/n)^2 from each
    point -- a second route to adjacency, independent of the per-edge test above."""
    circle = [(x, y) for x in range(n) for y in range(n) if (x * x + y * y) % n == 1 % n]
    index = {p: i for i, p in enumerate(pts)}
    found = set()
    for i, (a, b) in enumerate(pts):
        for x, y in circle:
            j = index.get(((a + x) % n, (b + y) % n))
            if j is not None and j != i:
                found.add((min(i, j), max(i, j)))
    return found, len(circle)


# ---------------------------------------------------------------- 4. the pin

def read_pin(raw_pin, E, pts):
    P = len(pts)
    if not (isinstance(raw_pin, list) and len(raw_pin) == 3 and all(type(x) is int for x in raw_pin)):
        raise Refusal('PIN_NOT_CLIQUE', f'pin is not three integers: {raw_pin!r}')
    if not all(0 <= v < P for v in raw_pin):
        raise Refusal('PIN_NOT_CLIQUE', f'pin {raw_pin} names a vertex outside 0 .. {P - 1}')
    if len(set(raw_pin)) != 3:
        raise Refusal('PIN_NOT_CLIQUE', f'pin {raw_pin} repeats a vertex, so it is not a triangle')
    ES = set(E)
    for x in range(3):
        for y in range(x + 1, 3):
            i, j = sorted((raw_pin[x], raw_pin[y]))
            if (i, j) not in ES:
                raise Refusal('PIN_NOT_CLIQUE',
                              f'pin {raw_pin}: points {i} = {list(pts[i])} and {j} = {list(pts[j])} are not '
                              f'a listed edge, so giving the three pinned points three different colours is '
                              f'not a symmetry reduction of the listed graph')
    return tuple(raw_pin)


# ---------------------------------------------------------------- 5. the formula, in Lean's clause order

def build_cnf(P, E, pin, k):
    """`coloringCNF k P E ++ cubeCNF k P cube`: x(v, c) = k*v + c + 1."""
    x = lambda v, c: k * v + c + 1
    cl = [tuple(x(v, c) for c in range(k)) for v in range(P)]
    for i, j in E:
        for c in range(k):
            cl.append((-x(i, c), -x(j, c)))
    for c, v in enumerate(pin):
        cl.append((x(v, c),))
    return cl


def cnf_text(P, cl, k):
    return f'p cnf {k * P} {len(cl)}\n' + ''.join(' '.join(map(str, c)) + ' 0\n' for c in cl)


# ---------------------------------------------------------------- 6. the LRAT proof

def open_proof(path):
    try:
        with open(path, 'rb') as f:
            head = f.read(2)
        return gzip.open(path, 'rb') if head == b'\x1f\x8b' else open(path, 'rb')
    except OSError as ex:
        raise Refusal('IO', f'{path}: {ex}')


def check_lrat(clauses, nvars, path):
    """the formula is clauses 1..M, in order. Returns (additions, deletion lines, the empty clause's id, the
    proof text's sha256, the line count)."""
    db = {m + 1: c for m, c in enumerate(clauses)}
    last_id = len(clauses)
    val = [0] * (nvars + 1)              # per variable: 1 true, -1 false, 0 unassigned
    adds = dels = 0
    sha = hashlib.sha256()
    lineno = 0
    with open_proof(path) as f:
        for lineno, line in enumerate(f, 1):
            sha.update(line)
            toks = line.split()
            if not toks:
                continue
            if len(toks) > 1 and toks[1] == b'd':
                try:
                    ids = [int(t) for t in toks[2:]]
                except ValueError:
                    raise Refusal('PROOF_MALFORMED', f'line {lineno}: a deletion id is not an integer')
                if not ids or ids[-1] != 0:
                    raise Refusal('PROOF_MALFORMED', f'line {lineno}: the deletion is not terminated by 0')
                for cid in ids[:-1]:
                    if db.pop(cid, None) is None:
                        raise Refusal('PROOF_BAD_HINT', f'line {lineno}: deletes clause {cid}, which is not '
                                                        f'in the database')
                dels += 1
                continue
            try:
                nums = [int(t) for t in toks]
            except ValueError:
                raise Refusal('PROOF_MALFORMED', f'line {lineno}: not a list of integers')
            cid = nums[0]
            try:
                z = nums.index(0, 1)
            except ValueError:
                raise Refusal('PROOF_MALFORMED', f'line {lineno}: the clause is not terminated by 0')
            lits, rest = nums[1:z], nums[z + 1:]
            if not rest or rest[-1] != 0 or 0 in rest[:-1]:
                raise Refusal('PROOF_MALFORMED', f'line {lineno}: the hints are not terminated by exactly one 0')
            hints = rest[:-1]
            if cid <= last_id:
                raise Refusal('PROOF_STEP_NOT_RUP', f'line {lineno}: clause id {cid} is not fresh (the last id '
                                                    f'in use is {last_id}), so this proof is not a proof of '
                                                    f'this formula')
            trail = []
            try:
                for l in lits:
                    v = abs(l)
                    if v > nvars or v == 0:
                        raise Refusal('PROOF_STEP_NOT_RUP', f'line {lineno}: literal {l} is outside the '
                                                            f'formula\'s {nvars} variables')
                    want = -1 if l > 0 else 1                     # assume the new clause false
                    if val[v] == -want:
                        raise Refusal('PROOF_STEP_NOT_RUP', f'line {lineno}: clause {cid} contains {l} and '
                                                            f'{-l}, so it is a tautology')
                    if val[v] == 0:
                        val[v] = want
                        trail.append(v)
                conflict = False
                for pos, h in enumerate(hints):
                    if h <= 0:
                        raise Refusal('PROOF_BAD_HINT', f'line {lineno}: hint {h} is not a positive clause id '
                                                        f'(this checker accepts RUP steps only, not RAT)')
                    D = db.get(h)
                    if D is None:
                        raise Refusal('PROOF_BAD_HINT', f'line {lineno}: hint {h} names no clause in the '
                                                        f'database')
                    free, nfree = None, 0
                    for l in D:
                        s = val[abs(l)]
                        if s == 0:
                            nfree += 1
                            free = l
                        elif (s == 1) == (l > 0):
                            raise Refusal('PROOF_BAD_HINT', f'line {lineno}: hint {h} is already satisfied, '
                                                            f'so it is not unit')
                    if nfree == 0:
                        if pos != len(hints) - 1:
                            raise Refusal('PROOF_BAD_HINT', f'line {lineno}: hint {h} is falsified at position '
                                                            f'{pos + 1} of {len(hints)}, before the last hint')
                        conflict = True
                        break
                    if nfree > 1:
                        raise Refusal('PROOF_BAD_HINT', f'line {lineno}: hint {h} has {nfree} unassigned '
                                                        f'literals, so it is not unit')
                    val[abs(free)] = 1 if free > 0 else -1
                    trail.append(abs(free))
                if not conflict:
                    raise Refusal('PROOF_STEP_NOT_RUP', f'line {lineno}: clause {cid}\'s {len(hints)} hints '
                                                        f'propagate without reaching a conflict, so the clause '
                                                        f'is not implied by reverse unit propagation')
            finally:
                for v in trail:
                    val[v] = 0
            db[cid] = tuple(lits)
            last_id = cid
            adds += 1
            if not lits:
                return adds, dels, cid, sha.hexdigest(), lineno
    raise Refusal('PROOF_NO_EMPTY_CLAUSE', f'the proof ends after {lineno} lines and {adds} additions without '
                                           f'deriving the empty clause')


# ---------------------------------------------------------------- the check

def check(witness_path, proof_path):
    t0 = time.time()
    W, wbytes, n, k = read_witness(witness_path)
    pts = read_points(W['points'], n)
    E = read_edges(W['edges'], pts, n)
    pin = read_pin(W['pin'], E, pts)
    if k < len(pin):
        raise Refusal('BAD_WITNESS', f'k = {k} is smaller than the {len(pin)} pinned colours')
    induced, circle_size = induced_unit_pairs(pts, n)
    missing = sorted(set(E) - induced)
    if missing:                                    # cannot happen after read_edges; a cross-check, not a gate
        raise Refusal('NOT_UNIT_PAIR', f'edge {list(missing[0])} passed the per-pair test but is not found by '
                                       f'the circle walk: the two adjacency routes disagree')
    cl = build_cnf(len(pts), E, pin, k)
    adds, dels, empty_id, psha, lines = check_lrat(cl, k * len(pts), proof_path)
    return {'n': n, 'k': k, 'points': len(pts), 'edges': len(E), 'induced': len(induced),
            'circle': circle_size, 'pin': pin, 'vars': k * len(pts), 'clauses': len(cl),
            'additions': adds, 'deletions': dels, 'empty_id': empty_id, 'lines': lines,
            'cnf_sha256': hashlib.sha256(cnf_text(len(pts), cl, k).encode()).hexdigest(),
            'witness_sha256': hashlib.sha256(wbytes).hexdigest(), 'proof_sha256': psha,
            'checker_sha256': self_sha256(), 'seconds': round(time.time() - t0, 2)}


def self_sha256():
    with open(os.path.abspath(__file__), 'rb') as f:
        return hashlib.sha256(f.read()).hexdigest()


def main_check(witness_path, proof_path):
    try:
        r = check(witness_path, proof_path)
    except Refusal as ex:
        print(f'REFUSED {ex.code}: {ex.detail}')
        return 1
    print(f'witness sha256 {r["witness_sha256"]}  ({witness_path})')
    print(f'proof   sha256 {r["proof_sha256"]}  ({proof_path}, uncompressed text)')
    print(f'checker sha256 {r["checker_sha256"]}  (this file)')
    print(f'n = {r["n"]} (the modulus), k = {r["k"]} (the colours refused)')
    print(f'points {r["points"]}; listed edges {r["edges"]}; unit pairs those points actually span '
          f'{r["induced"]} (the listed edges are a subset, which is sound and cheaper); '
          f'unit circle of (Z/{r["n"]})^2 has {r["circle"]} points')
    print(f'pinned triangle {list(r["pin"])} -> colours 0, 1, 2; CNF built here: {r["vars"]} variables, '
          f'{r["clauses"]} clauses, sha256 {r["cnf_sha256"]}')
    print(f'LRAT checked here: {r["lines"]} lines, {r["additions"]} additions, {r["deletions"]} deletion '
          f'lines, empty clause at id {r["empty_id"]}; {r["seconds"]} s')
    print(f'the listed graph ({r["points"]} points, {r["edges"]} edges, every pair re-verified as a unit pair '
          f'modulo {r["n"]}) has no proper {r["k"]}-colouring; it is a subgraph of UD(Z/{r["n"]},2), so '
          f'UD(Z/{r["n"]},2) has none')
    print('CERTIFIED by fs66_check_witness (standard-library checker; NOT the Lean kernel)')
    return 0


# ---------------------------------------------------------------- the controls: plant, watch it go red, restore

def run_self(witness, proof):
    r = subprocess.run([sys.executable, os.path.abspath(__file__), witness, proof],
                       capture_output=True, text=True)
    out = [l for l in r.stdout.strip().splitlines() if l.strip()]
    verdict = next((l for l in out if l.startswith(('REFUSED', 'CERTIFIED'))), '')
    if not verdict and out:
        verdict = out[-1]
    return r.returncode, (verdict or r.stderr.strip()[-300:] or '(no output at all)')


def controls(witness_path, proof_path):
    try:
        W, wbytes, n, k = read_witness(witness_path)
        pts = read_points(W['points'], n)
        E = read_edges(W['edges'], pts, n)
        pin = read_pin(W['pin'], E, pts)
    except Refusal as ex:
        print(f'REFUSED {ex.code}: {ex.detail}')
        print('CONTROLS NOT RUN: the witness itself does not check, so no plant would mean anything')
        return 1
    with open_proof(proof_path) as f:
        proof_lines = f.read().split(b'\n')
    body = [l for l in proof_lines if l.strip()]
    adj = {}
    for i, j in E:
        adj.setdefault(i, set()).add(j)
        adj.setdefault(j, set()).add(i)
    tmp = tempfile.mkdtemp(prefix='fs66-controls-')
    before = hashlib.sha256(open(witness_path, 'rb').read()).hexdigest()
    before_p = hashlib.sha256(open(proof_path, 'rb').read()).hexdigest()
    rows = []

    def put_w(name, obj):
        p = os.path.join(tmp, name + '.json')
        with open(p, 'w') as f:
            json.dump(obj, f)
        return p

    def put_p(name, lines):
        p = os.path.join(tmp, name + '.lrat')
        with open(p, 'wb') as f:
            f.write(b'\n'.join(lines) + b'\n')
        return p

    def row(ok, label, expected, observed):
        rows.append(ok)
        print(f'  [{"ok  " if ok else "FAIL"}] {label}\n         expected {expected}\n         observed {observed}')

    def expect(label, wpath, ppath, codes):
        """a plant must (a) actually differ from the faithful files and (b) be refused with a named code."""
        rc, line = run_self(wpath, ppath)
        try:
            changed_w = json.loads(open(wpath, 'rb').read()) != W
        except ValueError:
            changed_w = True
        with open_proof(ppath) as f:
            changed_p = [l for l in f.read().split(b'\n') if l.strip()] != body
        changed = changed_w or changed_p
        hit = any(line.startswith(f'REFUSED {c}:') for c in codes)
        ok = changed and rc == 1 and hit
        row(ok, label, 'REFUSED ' + ' or '.join(codes),
            (line[:200] if changed else '[THE PLANT CHANGED NOTHING] ' + line[:160]))

    faithful_w = put_w('faithful', W)
    faithful_p = put_p('faithful', body)

    # 0. the faithful twin: the same scaffolding, no fault. If this does not certify, no plant below means a thing.
    rc, line = run_self(faithful_w, faithful_p)
    row(rc == 0 and line.startswith('CERTIFIED'), 'faithful twin (the witness re-serialised, the proof '
        'rewritten line by line -- same scaffolding, no fault)', 'CERTIFIED, exit 0', f'exit {rc}: {line[:160]}')

    # 0b. the second CNF builder: tools/coloring.py over the same witness must produce the same formula.
    mine = hashlib.sha256(cnf_text(len(pts), build_cnf(len(pts), E, pin, k), k).encode()).hexdigest()
    tower = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'fs66_tower.py')
    p2 = subprocess.run([sys.executable, tower, 'cnfdigest', witness_path], capture_output=True, text=True)
    theirs = (p2.stdout.split() + ['(the second builder printed nothing)'])[1] if p2.returncode == 0 else \
        f'(exit {p2.returncode}: {p2.stderr.strip()[-120:]})'
    row(theirs == mine, 'the second CNF builder (tools/coloring.py, via fs66_tower.py cnfdigest) agrees on the '
        'formula', f'sha256 {mine}', f'sha256 {theirs}')

    # 0c. the induced-pair count by the circle walk agrees with a plain all-pairs test over every pair.
    induced, _ = induced_unit_pairs(pts, n)
    one = 1 % n
    allpairs = {(i, j) for i in range(len(pts)) for j in range(i + 1, len(pts))
                if quadrance(n, pts[i], pts[j]) == one}
    row(allpairs == induced and set(E) <= allpairs,
        f'the circle walk and a plain all-pairs test over all {len(pts) * (len(pts) - 1) // 2} pairs agree',
        f'{len(allpairs)} unit pairs by all-pairs', f'{len(induced)} by the circle walk, {len(E)} listed')

    # 1. a point moved by one: the edges at it stop being unit pairs.
    v = max((v for v in adj if v not in pin), key=lambda v: len(adj[v]))
    moved = [list(p) for p in pts]
    moved[v] = [(pts[v][0] + 1) % n, pts[v][1]]
    expect(f'a point moved (point {v} = {list(pts[v])} -> {moved[v]}, degree {len(adj[v])})',
           put_w('moved', dict(W, points=moved)), faithful_p, ['NOT_UNIT_PAIR', 'REPEATED_POINT'])

    # 2. a point listed twice.
    dup = [list(p) for p in pts]
    dup[v] = list(pts[pin[0]])
    expect(f'a point listed twice (point {v} replaced by point {pin[0]})',
           put_w('dup', dict(W, points=dup)), faithful_p, ['REPEATED_POINT'])

    # 3. a point outside the ring.
    oor = [list(p) for p in pts]
    oor[v] = [n, pts[v][1]]
    expect(f'a point outside the ring (point {v} -> [{n}, {pts[v][1]}])',
           put_w('oor', dict(W, points=oor)), faithful_p, ['BAD_POINT'])

    # 4. the modulus changed to n - 1: points leave the ring, or pairs stop being unit.
    expect(f'the modulus reduced (n = {n} -> {n - 1})', put_w('nminus', dict(W, n=n - 1)), faithful_p,
           ['BAD_POINT', 'NOT_UNIT_PAIR'])

    # 5. the modulus doubled: every point is still in range, and the arithmetic is different.
    expect(f'the modulus doubled (n = {n} -> {2 * n}); the points still fit, the quadrances do not',
           put_w('ndouble', dict(W, n=2 * n)), faithful_p, ['NOT_UNIT_PAIR'])

    # 6. the pin moved to a non-triangle: colouring three points 0, 1, 2 is then not a symmetry reduction.
    far = next(j for j in range(len(pts)) if j != pin[0] and j not in adj.get(pin[0], ()))
    expect(f'the pin moved to a non-triangle ({list(pin)} -> [{pin[0]}, {pin[1]}, {far}])',
           put_w('pin-open', dict(W, pin=[pin[0], pin[1], far])), faithful_p, ['PIN_NOT_CLIQUE'])

    # 7. one of the pin's own edges deleted from the list (the pin stops being a clique OF THE LISTED GRAPH).
    drop = tuple(sorted((pin[0], pin[1])))
    expect(f'the pinned edge {list(drop)} removed from the edge list',
           put_w('pin-edge-gone', dict(W, edges=[list(e) for e in E if e != drop])), faithful_p,
           ['PIN_NOT_CLIQUE'])

    # 8. the proof truncated before the empty clause.
    expect(f'the proof truncated to {len(body) // 2} of {len(body)} lines', faithful_w,
           put_p('truncated', body[:len(body) // 2]), ['PROOF_NO_EMPTY_CLAUSE'])

    # 9. one hint id corrupted.
    adds = [m for m, l in enumerate(body) if l.split()[1:2] != [b'd']]
    corrupted = hint0 = at = None
    for m in sorted(adds, key=lambda m: abs(m - len(body) // 2)):
        t = body[m].split()
        z = t.index(b'0', 1)
        hints = t[z + 1:-1]
        if len(hints) >= 2 and hints[0] != b'1':
            hint0, at, t[z + 1] = hints[0], m, b'1'
            corrupted = body[:m] + [b' '.join(t)] + body[m + 1:]
            break
    if corrupted is None:
        row(False, 'one hint corrupted', 'a proof line with two or more hints to corrupt',
            'no such line in this proof: the plant could not be built, so nothing was tested')
    else:
        expect(f'one hint corrupted (proof line {at + 1}: first hint {hint0.decode()} -> 1)', faithful_w,
               put_p('hint', corrupted), ['PROOF_BAD_HINT', 'PROOF_STEP_NOT_RUP'])

    # 10. a derivation's last hint dropped: the rest propagate but reach no conflict.
    short = dropped = at2 = None
    for m2 in sorted(adds, key=lambda m: abs(m - len(body) // 3)):
        t = body[m2].split()
        z = t.index(b'0', 1)
        if len(t) - z - 2 >= 2:
            dropped, at2 = t[-2], m2
            short = body[:m2] + [b' '.join(t[:-2] + [b'0'])] + body[m2 + 1:]
            break
    if short is None:
        row(False, "a derivation's last hint dropped", 'a proof line with two or more hints',
            'no such line in this proof: the plant could not be built, so nothing was tested')
    else:
        expect(f'a derivation\'s last hint dropped (proof line {at2 + 1}: hint {dropped.decode()} removed)',
               faithful_w, put_p('short', short), ['PROOF_STEP_NOT_RUP', 'PROOF_BAD_HINT'])

    # 11. the k + 1 formula with the k proof: a SATISFIABLE formula handed to the checker.
    expect(f'k = {k} -> {k + 1}: a satisfiable formula (the listed graph does have {k + 1} colours) handed '
           f'the {k}-colour proof', put_w('kplus', dict(W, k=k + 1)), faithful_p,
           ['PROOF_STEP_NOT_RUP', 'PROOF_BAD_HINT', 'PROOF_NO_EMPTY_CLAUSE'])

    # 12. k below the pin.
    expect(f'k = {k} -> 2, below the three pinned colours', put_w('ksmall', dict(W, k=2)), faithful_p,
           ['BAD_WITNESS'])

    # 13. one edge deleted, the proof kept: the formula shifts under the proof's clause ids.
    gone = next(e for e in E if e != drop and e[0] not in pin and e[1] not in pin)
    expect(f'one edge {list(gone)} deleted, the original proof kept',
           put_w('edge-gone', dict(W, edges=[list(e) for e in E if e != gone])), faithful_p,
           ['PROOF_STEP_NOT_RUP', 'PROOF_BAD_HINT', 'PROOF_NO_EMPTY_CLAUSE'])

    # 14. the edge list reversed: sorted order is part of the contract, because positions address clauses.
    expect('the edge list reversed (positions address clauses, so order is part of the witness)',
           put_w('unsorted', dict(W, edges=[list(e) for e in reversed(E)])), faithful_p, ['BAD_EDGE'])

    # 15. an edge repeated.
    expect(f'edge {list(E[0])} listed twice', put_w('dupedge', dict(W, edges=[list(E[0])] + [list(e) for e in E])),
           faithful_p, ['BAD_EDGE'])

    # 16. an unknown key: nothing is accepted and ignored.
    expect('an unknown key "note" added to the witness', put_w('extra', dict(W, note='hello')), faithful_p,
           ['BAD_WITNESS'])

    # 17. the edge list emptied.
    expect('the edge list emptied', put_w('noedges', dict(W, edges=[])), faithful_p, ['BAD_WITNESS'])

    # 18. the proof replaced by a file that is not LRAT.
    expect('the proof replaced by text that is not LRAT', faithful_w, put_p('garbage', [b'this is not a proof']),
           ['PROOF_MALFORMED'])

    # 19. a proof line that re-adds a clause id the FORMULA already has, with a derivation that is itself
    #     valid reverse unit propagation (the clause is implied by itself). Only the "every added id must be
    #     fresh" test catches this; without it a proof could redefine a clause the formula already holds and
    #     then cite the redefinition. This plant exists because the mutation audit found no other row that
    #     goes red when that test is removed.
    first = build_cnf(len(pts), E, pin, k)[0]
    reuse = [b'1 ' + b' '.join(str(l).encode() for l in first) + b' 0 1 0'] + body
    expect('a proof line re-adds clause id 1 (a valid RUP derivation, but the id is not fresh)', faithful_w,
           put_p('reuse-id', reuse), ['PROOF_STEP_NOT_RUP'])

    shutil.rmtree(tmp)

    # the guarded state comes back: the committed files are untouched and still certify.
    after = hashlib.sha256(open(witness_path, 'rb').read()).hexdigest()
    after_p = hashlib.sha256(open(proof_path, 'rb').read()).hexdigest()
    rc, line = run_self(witness_path, proof_path)
    row(rc == 0 and line.startswith('CERTIFIED') and after == before and after_p == before_p,
        'the guarded state after all plants: the committed witness and proof are byte-identical and certify',
        f'CERTIFIED, witness {before[:12]}…, proof {before_p[:12]}…',
        f'exit {rc}, witness {after[:12]}…, proof {after_p[:12]}…: {line[:80]}')

    bad = rows.count(False)
    print(f'{len(rows)} controls: {len(rows) - bad} behaved, {bad} did not')
    print('ALL CONTROLS BEHAVED' if bad == 0 else f'{bad} CONTROLS DID NOT BEHAVE')
    return 1 if bad else 0


def main():
    args = sys.argv[1:]
    if not args or '--help' in args or '-h' in args:
        print(__doc__)
        return 0 if args else 2
    ctl = '--controls' in args
    args = [a for a in args if a != '--controls']
    if not args or len(args) > 2:
        print(__doc__)
        return 2
    wpath = args[0]
    ppath = args[1] if len(args) == 2 else os.path.join(os.path.dirname(os.path.abspath(wpath)),
                                                        'witness.lrat.gz')
    try:
        return controls(wpath, ppath) if ctl else main_check(wpath, ppath)
    except Refusal as ex:
        print(f'REFUSED {ex.code}: {ex.detail}')
        return 1


if __name__ == '__main__':
    sys.exit(main())
