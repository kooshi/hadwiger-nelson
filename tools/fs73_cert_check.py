#!/usr/bin/env python3
"""fs73_cert_check -- the standalone checker for FS-73's four-colour forcing certificates on de Grey's lattice (FROZEN once committed:
a change is a new file, never an edit).

STANDARD LIBRARY ONLY, and it imports nothing from tools/: it shares no code with the generator (tools/fs73_certify.py) or any solver.

The field.  E = Q(sqrt-3, sqrt-11), embedded in C by sqrt-3 -> i sqrt3, sqrt-11 -> i sqrt11, so that E sits in the plane R^2 = C and
its complex conjugation is the plane's reflection in the x-axis.  O_E = Z<1, z, w, z w> with z = (1 + sqrt-3)/2 (a sixth root of
unity), w = (1 + sqrt-11)/2; multiplication by z^2 = z - 1, w^2 = w - 3; conjugation z -> 1 - z, w -> 1 - w.  A point is written
Z = [a, b, c, d], standing for (a + b z + c w + d z w)/9; the point set (1/9) O_E is de Grey's lattice (FS-73 P1, the identity
Lambda = (1/9) O_E, checked there in exact integers).

What it certifies.  From WITNESS.json and PROOF.lrat[.gz] it
  1. checks the points are distinct integer 4-vectors;
  2. re-derives EVERY pair of points at distance exactly 1 -- the difference D has D * conj(D) = 81 in O_E exactly (the plane distance
     is |D|/9, and D * conj(D) lies in the real subfield Q(sqrt33), where the plane embedding is injective, so the test is
     equivalent) -- proposing pairs by floating-point distance in a unit grid and deciding every proposal in integers; the file's
     unit_edges must equal the derived set (a float miss can only make the sets differ, i.e. a refusal, never a false pass);
  3. checks the pair is two distinct points NOT at distance 1, and that pin_clique is a clique of G + {pair} with distinct colours
     (so pinning it is a symmetry reduction of a colourability question);
  4. builds the CNF itself, from ITS OWN edge set: x(v, k) = 4v + k + 1; per vertex [x(v,0) .. x(v,3)]; per edge (i, j), i < j, of the
     derived edges plus the pair, sorted, [-x(i,k) -x(j,k)] for k = 0..3; then [x(v,k)] per pin;
  5. checks the LRAT proof against that CNF with its own RUP checker (each added clause implied by unit propagation over exactly its
     listed hints, the last one falsified; deletions honoured; RAT steps refused); the proof must add the empty clause.
Then G + {pair} is not 4-colourable, so every proper 4-colouring of the plane (or of the unit-distance graph on (1/9) O_E) gives
the pair's two points one colour: the pair is FORCED at four colours.
  6. the transport: translations, z-rotation (multiplication by z, an isometry fixing 0 and preserving (1/9) O_E) and conjugation
     map forced pairs to forced pairs, and forced differences form a group, so every element of the Z-span of the orbit of the pair's
     difference delta under <z, conj> is forced.  The checker prints that span's Hermite normal form (in Z-coordinates) and, when it
     is 8 Z^4, the conclusion: every difference in (8/9) O_E = 8 Lambda is forced -- every proper 4-colouring of de Grey's lattice
     graph is 8 Lambda-periodic.

Usage:
  fs73_cert_check.py WITNESS.json [PROOF.lrat[.gz]]       -> CERTIFIED (exit 0) or REFUSED <CODE>: <detail> (exit 1)
  fs73_cert_check.py --controls WITNESS.json [PROOF]      -> planted faults, each refused for its named reason, plus the faithful twin
The proof defaults to witness.lrat.gz beside the witness file.
"""
import gzip
import hashlib
import json
import math
import os
import sys
import tempfile


class Refusal(Exception):
    def __init__(self, code, detail):
        super().__init__(f'{code}: {detail}')
        self.code, self.detail = code, detail


# ---------------------------------------------------------------- O_E arithmetic

def zmul(a, b):
    return (a[0] * b[0] - a[1] * b[1], a[0] * b[1] + a[1] * b[0] + a[1] * b[1])


def mul(p, q):
    A0, A1, B0, B1 = (p[0], p[1]), (p[2], p[3]), (q[0], q[1]), (q[2], q[3])
    c0, c1a, c1b, c2 = zmul(A0, B0), zmul(A0, B1), zmul(A1, B0), zmul(A1, B1)
    return (c0[0] - 3 * c2[0], c0[1] - 3 * c2[1], c1a[0] + c1b[0] + c2[0], c1a[1] + c1b[1] + c2[1])


def conj(p):
    a, b, c, d = p
    return (a + b + c + d, -b - d, -c - d, d)


def plane(p):
    """the float image in C of Z/9 (for proposing pairs only)"""
    a, b, c, d = p
    z = complex(0.5, math.sqrt(3) / 2)
    w = complex(0.5, math.sqrt(11) / 2)
    return (a + b * z + c * w + d * z * w) / 9


def is_unit(p, q):
    D = tuple(y - x for x, y in zip(p, q))
    return mul(D, conj(D)) == (81, 0, 0, 0)


# ---------------------------------------------------------------- the witness

def read_points(raw):
    if not isinstance(raw, list) or not raw:
        raise Refusal('POINT_FORMAT', 'points is not a non-empty list')
    pts = []
    for k, p in enumerate(raw):
        if not (isinstance(p, list) and len(p) == 4 and all(type(x) is int for x in p)):
            raise Refusal('POINT_FORMAT', f'point {k} is not four integers: {p!r}')
        pts.append(tuple(p))
    if len(set(pts)) != len(pts):
        raise Refusal('POINT_DUPLICATE', 'a point is listed twice')
    return pts


def derive_edges(pts):
    cells = {}
    fl = [plane(p) for p in pts]
    for k, c in enumerate(fl):
        cells.setdefault((math.floor(c.real), math.floor(c.imag)), []).append(k)
    out = set()
    proposed = 0
    for k, c in enumerate(fl):
        cx, cy = math.floor(c.real), math.floor(c.imag)
        for dx in (-1, 0, 1):
            for dy in (-1, 0, 1):
                for j in cells.get((cx + dx, cy + dy), ()):
                    if j > k and abs(abs(fl[j] - c) - 1) < 1e-6:
                        proposed += 1
                        if is_unit(pts[k], pts[j]):
                            out.add((k, j))
    return out, proposed


def read_edges(raw, n):
    if not isinstance(raw, list):
        raise Refusal('EDGE_FORMAT', 'unit_edges is not a list')
    out = set()
    for e in raw:
        if not (isinstance(e, list) and len(e) == 2 and all(type(x) is int and 0 <= x < n for x in e) and e[0] < e[1]):
            raise Refusal('EDGE_FORMAT', f'edge {e!r} is not two vertex indices i < j')
        out.add(tuple(e))
    if len(out) != len(raw):
        raise Refusal('EDGE_FORMAT', 'an edge is listed twice')
    return out


def build_cnf(n, edges, pins):
    clauses = [(4 * v + 1, 4 * v + 2, 4 * v + 3, 4 * v + 4) for v in range(n)]
    for i, j in sorted(edges):
        clauses += [(-(4 * i + k + 1), -(4 * j + k + 1)) for k in range(4)]
    clauses += [(4 * v + k + 1,) for v, k in pins]
    return clauses


def cnf_text(clauses, nvars):
    return f'p cnf {nvars} {len(clauses)}\n' + ''.join(' '.join(map(str, c)) + ' 0\n' for c in clauses)


# ---------------------------------------------------------------- LRAT

def open_proof(path):
    with open(path, 'rb') as f:
        head = f.read(2)
    return gzip.open(path, 'rb') if head == b'\x1f\x8b' else open(path, 'rb')


def check_lrat(clauses, nvars, path):
    db = {k + 1: c for k, c in enumerate(clauses)}
    last_id = len(clauses)
    val = [0] * (nvars + 1)
    adds = dels = 0
    sha = hashlib.sha256()
    with open_proof(path) as f:
        for lineno, line in enumerate(f, 1):
            sha.update(line)
            toks = line.split()
            if not toks:
                continue
            try:
                if toks[1] == b'd':
                    ids = [int(x) for x in toks[2:]]
                    if not ids or ids[-1] != 0:
                        raise Refusal('PROOF_MALFORMED', f'line {lineno}: deletion not terminated by 0')
                    for cid in ids[:-1]:
                        if db.pop(cid, None) is None:
                            raise Refusal('PROOF_STEP', f'line {lineno}: deletes clause {cid}, which is not in the database')
                    dels += 1
                    continue
                nums = [int(x) for x in toks]
            except ValueError:
                raise Refusal('PROOF_MALFORMED', f'line {lineno}: not integers')
            except IndexError:
                raise Refusal('PROOF_MALFORMED', f'line {lineno}: too short')
            cid = nums[0]
            try:
                z1 = nums.index(0, 1)
            except ValueError:
                raise Refusal('PROOF_MALFORMED', f'line {lineno}: clause not terminated by 0')
            lits, rest = nums[1:z1], nums[z1 + 1:]
            if not rest or rest[-1] != 0 or 0 in rest[:-1]:
                raise Refusal('PROOF_MALFORMED', f'line {lineno}: hints not terminated by exactly one 0')
            hints = rest[:-1]
            if cid <= last_id:
                raise Refusal('PROOF_STEP', f'line {lineno}: clause id {cid} is not fresh (last id {last_id})')
            trail = []
            try:
                for lit in lits:
                    v = abs(lit)
                    if v > nvars:
                        raise Refusal('PROOF_STEP', f'line {lineno}: literal {lit} is outside the formula\'s {nvars} variables')
                    want = -1 if lit > 0 else 1
                    if val[v] == -want:
                        raise Refusal('PROOF_STEP', f'line {lineno}: clause {cid} is a tautology or repeats a literal')
                    if val[v] == 0:
                        val[v] = want
                        trail.append(v)
                conflict = False
                for hk, h in enumerate(hints):
                    if h <= 0:
                        raise Refusal('PROOF_STEP', f'line {lineno}: hint {h} is not a positive clause id (RAT steps are not accepted)')
                    D = db.get(h)
                    if D is None:
                        raise Refusal('PROOF_STEP', f'line {lineno}: hint {h} names no clause in the database')
                    free, nfree = None, 0
                    for lit in D:
                        s = val[abs(lit)]
                        if s == 0:
                            nfree += 1
                            free = lit
                        elif (s == 1) == (lit > 0):
                            raise Refusal('PROOF_STEP', f'line {lineno}: hint {h} is already satisfied, so it is not unit')
                    if nfree == 0:
                        if hk != len(hints) - 1:
                            raise Refusal('PROOF_STEP', f'line {lineno}: hint {h} is falsified before the last hint')
                        conflict = True
                        break
                    if nfree > 1:
                        raise Refusal('PROOF_STEP', f'line {lineno}: hint {h} has {nfree} unassigned literals, so it is not unit')
                    val[abs(free)] = 1 if free > 0 else -1
                    trail.append(abs(free))
                if not conflict:
                    raise Refusal('PROOF_STEP', f'line {lineno}: clause {cid}: its hints propagate to no conflict')
            finally:
                for v in trail:
                    val[v] = 0
            db[cid] = tuple(lits)
            last_id = cid
            adds += 1
            if not lits:
                return adds, dels, cid, sha.hexdigest()
    raise Refusal('NO_EMPTY_CLAUSE', f'the proof ends after {adds} additions without deriving the empty clause')


# ---------------------------------------------------------------- the transport

def hnf(rows):
    """row Hermite normal form of an integer matrix (list of 4-vectors), zero rows dropped"""
    A = [list(r) for r in rows]
    out, col = [], 0
    ncols = len(A[0]) if A else 0
    while A and col < ncols:
        nz = [r for r in A if r[col] != 0]
        if not nz:
            col += 1
            continue
        while len([r for r in A if r[col] != 0]) > 1:
            nz = sorted((r for r in A if r[col] != 0), key=lambda r: abs(r[col]))
            p = nz[0]
            A = [r if (r is p or r[col] == 0) else [a - (r[col] // p[col]) * b for a, b in zip(r, p)] for r in A]
        p = next(r for r in A if r[col] != 0)
        if p[col] < 0:
            p = [-x for x in p]
        A = [r for r in A if r[col] == 0 and any(r)]
        out.append(p)
        col += 1
    for i, r in enumerate(out):                      # reduce above the pivots
        pc = next(c for c in range(ncols) if r[c] != 0)
        for j in range(i):
            q = out[j][pc] // r[pc]
            out[j] = [a - q * b for a, b in zip(out[j], r)]
    return out


def transport(delta):
    orbit, front = {tuple(delta)}, [tuple(delta)]
    zeta = (0, 1, 0, 0)
    while front:
        nxt = []
        for d in front:
            for e in (mul(zeta, d), conj(d)):
                if e not in orbit:
                    orbit.add(e)
                    nxt.append(e)
        front = nxt
    return sorted(orbit), hnf(sorted(orbit))


# ---------------------------------------------------------------- the check

def check(witness_path, proof_path, quiet=False):
    try:
        W = json.load(open(witness_path))
    except (OSError, ValueError) as ex:
        raise Refusal('WITNESS_UNREADABLE', str(ex))
    pts = read_points(W.get('points'))
    n = len(pts)
    file_edges = read_edges(W.get('unit_edges'), n)
    derived, proposed = derive_edges(pts)
    for e in sorted(file_edges):
        if not is_unit(pts[e[0]], pts[e[1]]):
            raise Refusal('EDGE_NOT_UNIT', f'the file lists {list(e)}, whose points are not at distance 1')
    for e in sorted(derived):
        if e not in file_edges:
            raise Refusal('EDGE_MISSING', f'points {e[0]} and {e[1]} are at distance 1 but the file omits the edge')
    assert derived == file_edges
    pair = W.get('pair')
    if not (isinstance(pair, list) and len(pair) == 2 and all(type(x) is int and 0 <= x < n for x in pair) and pair[0] != pair[1]):
        raise Refusal('PAIR_FORMAT', f'pair is not two distinct vertex indices: {pair!r}')
    a, b = pair
    pe = (min(a, b), max(a, b))
    if pe in derived:
        raise Refusal('PAIR_IS_EDGE', 'the pair is at distance 1, so the claim would be trivial')
    edges = derived | {pe}
    pins = W.get('pin_clique')
    if not (isinstance(pins, list) and pins and all(isinstance(p, list) and len(p) == 2 and type(p[0]) is int and 0 <= p[0] < n
                                                     and type(p[1]) is int and 0 <= p[1] < 4 for p in pins)):
        raise Refusal('PIN_FORMAT', f'pin_clique is not a list of [vertex, colour]: {pins!r}')
    pv = [p[0] for p in pins]
    if len(set(pv)) != len(pv) or len({p[1] for p in pins}) != len(pins):
        raise Refusal('PIN_NOT_CLIQUE', 'pinned vertices or colours repeat')
    for i in range(len(pv)):
        for j in range(i + 1, len(pv)):
            if (min(pv[i], pv[j]), max(pv[i], pv[j])) not in edges:
                raise Refusal('PIN_NOT_CLIQUE', f'pinned vertices {pv[i]} and {pv[j]} are not adjacent in G + pair')
    clauses = build_cnf(n, edges, [tuple(p) for p in pins])
    nvars = 4 * n
    csha = hashlib.sha256(cnf_text(clauses, nvars).encode()).hexdigest()
    adds, dels, eid, psha = check_lrat(clauses, nvars, proof_path)
    delta = [y - x for x, y in zip(pts[a], pts[b])]
    orbit, H = transport(delta)
    eight = H == [[8 if i == j else 0 for j in range(4)] for i in range(4)]
    return {'points': n, 'unit_edges': len(derived), 'float_proposals': proposed, 'cnf_clauses': len(clauses), 'cnf_sha256': csha,
            'cnf_sha256_matches_file': csha == W.get('cnf_sha256'), 'lrat_additions': adds, 'lrat_deletions': dels,
            'lrat_sha256': psha, 'delta_Z': delta, 'orbit': len(orbit), 'span_hnf': H, 'span_is_8OE': eight}


def report(r):
    print(f"CERTIFIED: {r['points']} points, {r['unit_edges']} unit edges (re-derived exactly; {r['float_proposals']} float proposals), "
          f"plus the pair; CNF {r['cnf_clauses']} clauses (sha256 {r['cnf_sha256'][:16]}, equal to the file's: "
          f"{r['cnf_sha256_matches_file']}); LRAT {r['lrat_additions']} additions, {r['lrat_deletions']} deletions, empty clause "
          f"derived (sha256 {r['lrat_sha256'][:16]}).")
    print(f"  => the pair at difference delta = {r['delta_Z']}/9 is forced at four colours.")
    print(f"  transport: the orbit of delta under <zeta6, conj> has {r['orbit']} elements; its Z-span has HNF {r['span_hnf']}"
          + (" = 8 Z^4: every difference in (8/9) O_E = 8 Lambda is forced, so every proper 4-colouring of de Grey's lattice "
             "graph is 8 Lambda-periodic." if r['span_is_8OE'] else '.'))


def controls(wpath, ppath):
    W = json.load(open(wpath))
    tmp = tempfile.mkdtemp()
    fails = []

    def run(name, W2, proof=ppath, want=None):
        p = os.path.join(tmp, name + '.json')
        json.dump(W2, open(p, 'w'))
        try:
            check(p, proof, quiet=True)
            got = 'CERTIFIED'
        except Refusal as e:
            got = e.code
        ok = got == (want or 'CERTIFIED')
        print(f"  [{'ok ' if ok else 'FAIL'}] {name}: {got} (want {want or 'CERTIFIED'})", flush=True)
        if not ok:
            fails.append(name)

    run('faithful twin', W)
    W1 = json.loads(json.dumps(W))
    k = next(i for i in range(len(W1['points'])) if i not in W1['pair'] and i not in [p[0] for p in W1['pin_clique']])
    W1['points'][k] = [W1['points'][k][0] + 90, *W1['points'][k][1:]]          # moved 10 along the x-axis, off the point set
    run('a point moved by ten units', W1, want='EDGE_NOT_UNIT')
    W2 = json.loads(json.dumps(W))
    W2['unit_edges'] = W2['unit_edges'][1:]
    run('an edge dropped from the file', W2, want='EDGE_MISSING')
    W3 = json.loads(json.dumps(W))
    free = [i for i in range(len(W3['points'])) if i not in W3['pair']]
    W3['pair'] = [W3['pair'][0], next(i for i in free if (min(i, W3['pair'][0]), max(i, W3['pair'][0])) not in
                                      {tuple(e) for e in W3['unit_edges']} and i != W3['pair'][0])]
    W3['pin_clique'] = [[W3['pair'][0], 0], [W3['pair'][1], 1]]
    run('the pair replaced by another non-adjacent pair (the proof is for a different CNF)', W3, want='PROOF_STEP')
    W4 = json.loads(json.dumps(W))
    E4 = {tuple(e) for e in W4['unit_edges']}
    far = next(i for i in free if (min(i, W4['pair'][0]), max(i, W4['pair'][0])) not in E4)
    W4['pin_clique'] = W4['pin_clique'][:2] + [[far, 2]]
    run('a pin on a vertex outside the clique', W4, want='PIN_NOT_CLIQUE')
    # a corrupted proof: the first addition with at least two hints loses its last hint (the conflicting one), so its unit
    # propagation ends without a conflict (a hint falsified earlier would already have been an error in the original)
    bad = os.path.join(tmp, 'bad.lrat')
    with open_proof(ppath) as f, open(bad, 'wb') as g:
        done = False
        for line in f:
            t = line.split()
            if not done and len(t) > 3 and t[1] != b'd':
                z1 = t.index(b'0', 1)
                hints = t[z1 + 1:-1]
                if len(hints) > 1:
                    line = b' '.join(t[:z1 + 1] + hints[:-1] + [b'0']) + b'\n'
                    done = True
            g.write(line)
    run('the proof with one step\'s last hint dropped', W, proof=bad, want='PROOF_STEP')
    print('CONTROLS PASSED' if not fails else 'CONTROLS FAILED: ' + ', '.join(fails))
    return 0 if not fails else 1


def main():
    a = sys.argv[1:]
    ctl = '--controls' in a
    a = [x for x in a if x != '--controls']
    if not a:
        print(__doc__)
        return 2
    wpath = a[0]
    ppath = a[1] if len(a) > 1 else os.path.join(os.path.dirname(os.path.abspath(wpath)), 'witness.lrat.gz')
    if ctl:
        return controls(wpath, ppath)
    try:
        report(check(wpath, ppath))
        return 0
    except Refusal as e:
        print(f'REFUSED {e.code}: {e.detail}')
        return 1


if __name__ == '__main__':
    sys.exit(main())
