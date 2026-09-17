#!/usr/bin/env python3
"""fs58_check_witness -- the checker for FS-58's witness that the plane over Q(sqrt11) needs four colours.

STANDARD LIBRARY ONLY, and it imports nothing from tools/: it shares no code with the generator (tools/fs58_witness.py) or the solver.

What it certifies. The witness file lists points (a, b, c, e, m) of integers, m > 0, gcd(a, b, c, e, m) = 1, each standing for the point
((a + b sqrt11)/m, (c + e sqrt11)/m) of Q(sqrt11)^2 -- the representation is membership in Q(sqrt11)^2. The checker
  1. checks every point is such a tuple and no point is listed twice;
  2. re-derives EVERY pair of points at distance exactly 1, in integer arithmetic (a bucketing by exact integer cell keys proposes pairs;
     the arithmetic decides), and refuses unless that set equals the file's edge list;
  3. checks that (0, 0) and (1, 0) are points and adjacent, and that the pinned pair is a re-derived edge;
  4. builds the CNF itself, from ITS OWN edge set: variable x(v, k) = 3v + k + 1 (vertex v has colour k); for each vertex in order the
     clause [x(v,0), x(v,1), x(v,2)]; for each edge (i, j), i < j, in sorted order, [-x(i,k), -x(j,k)] for k = 0, 1, 2; then the pin
     [x(p,0)] and [x(q,1)] for the pinned pair (p, q). The pin is a symmetry reduction: p and q are adjacent, so any proper 3-colouring
     can be recoloured to give them colours 0 and 1;
  5. checks the LRAT proof against that CNF with its own checker: each added clause must be implied by reverse unit propagation using
     exactly its listed hints in order (every hint unit under the running assignment, the last one falsified); deletions are honoured; the
     proof must add the empty clause.
If every step passes, no proper 3-colouring of the unit-distance graph on those points exists, so chi(Q(sqrt11)^2) >= 4.

Usage:
  fs58_check_witness.py WITNESS.json [PROOF.lrat[.gz]]   -> prints CERTIFIED (exit 0) or REFUSED <CODE>: <detail> (exit 1)
  fs58_check_witness.py --controls WITNESS.json [PROOF]  -> planted faults, each must be refused for its named reason, plus the faithful twin
The proof defaults to witness.lrat.gz beside the witness file.
"""
import sys, os, json, gzip, hashlib, math, tempfile, subprocess, shutil

RADICAND = 11


class Refusal(Exception):
    def __init__(self, code, detail):
        super().__init__(f'{code}: {detail}')
        self.code, self.detail = code, detail


# ---------------------------------------------------------------- 1. points

def read_points(raw):
    if not isinstance(raw, list) or not raw:
        raise Refusal('POINT_FORMAT', 'points is not a non-empty list')
    pts = []
    for k, p in enumerate(raw):
        if not (isinstance(p, list) and len(p) == 5 and all(type(x) is int for x in p)):
            raise Refusal('POINT_FORMAT', f'point {k} is not five integers: {p!r}')
        a, b, c, e, m = p
        if m <= 0:
            raise Refusal('POINT_FORMAT', f'point {k} has denominator {m} <= 0')
        g = 0
        for x in p:
            g = math.gcd(g, x)
        if g != 1:
            raise Refusal('POINT_FORMAT', f'point {k} = {p} is not reduced (gcd {g})')
        pts.append(tuple(p))
    seen = {}
    for k, p in enumerate(pts):
        if p in seen:
            raise Refusal('DUPLICATE_POINT', f'points {seen[p]} and {k} are both {list(p)}')
        seen[p] = k
    return pts


# ---------------------------------------------------------------- 2. unit distances, exactly

def common_scale(pts):
    """every point over one denominator L: (X0, X1, Y0, Y1) with x = (X0 + X1 sqrt11)/L, y = (Y0 + Y1 sqrt11)/L"""
    L = 1
    for p in pts:
        L = L * p[4] // math.gcd(L, p[4])
    return L, [(a * (L // m), b * (L // m), c * (L // m), e * (L // m)) for a, b, c, e, m in pts]


def floor_div_sqrt(X0, X1, L):
    """an integer within 1 of floor((X0 + X1 sqrt(RADICAND)) / L), computed without floats: isqrt brackets X1 sqrt(RADICAND) in an
    interval of length < 1, so the numerator is bracketed within 1 and the quotient's floor within 1"""
    s = math.isqrt(RADICAND * X1 * X1)
    return (X0 + (s if X1 >= 0 else -s)) // L


def derive_unit_edges(pts):
    """all pairs (i, j), i < j, at Euclidean distance exactly 1. Distance 1 between (X0 + X1 r)/L and (Z0 + Z1 r)/L, r = sqrt(RADICAND)
    irrational, is dX0^2 + r^2 dX1^2 + dY0^2 + r^2 dY1^2 = L^2 together with dX0 dX1 + dY0 dY1 = 0 (the rational and sqrt parts).
    Candidates: integer cell keys within 1 of floor(x) and floor(y); two points at distance <= 1 have floors differing by <= 1, hence
    keys differing by <= 3, so all cell pairs with offsets in [-3, 3]^2 are searched (each unordered pair once)."""
    L, S = common_scale(pts)
    LL = L * L
    cells = {}
    for i, (X0, X1, Y0, Y1) in enumerate(S):
        cells.setdefault((floor_div_sqrt(X0, X1, L), floor_div_sqrt(Y0, Y1, L)), []).append(i)
    offsets = [(dx, dy) for dx in range(-3, 4) for dy in range(-3, 4) if (dx, dy) > (0, 0)]
    edges, tested = set(), 0

    def test(i, j):
        X0, X1, Y0, Y1 = S[i]
        Z0, Z1, W0, W1 = S[j]
        d0, d1, e0, e1 = X0 - Z0, X1 - Z1, Y0 - W0, Y1 - W1
        return d0 * d1 + e0 * e1 == 0 and d0 * d0 + e0 * e0 + RADICAND * (d1 * d1 + e1 * e1) == LL

    for key, mem in cells.items():
        for x in range(len(mem)):
            for y in range(x + 1, len(mem)):
                tested += 1
                if test(mem[x], mem[y]):
                    edges.add((min(mem[x], mem[y]), max(mem[x], mem[y])))
        for dx, dy in offsets:
            other = cells.get((key[0] + dx, key[1] + dy))
            if not other:
                continue
            for i in mem:
                for j in other:
                    tested += 1
                    if test(i, j):
                        edges.add((min(i, j), max(i, j)))
    return edges, tested, test


def read_edges(raw, n):
    if not isinstance(raw, list):
        raise Refusal('EDGE_FORMAT', 'edges is not a list')
    E = []
    for k, e in enumerate(raw):
        if not (isinstance(e, list) and len(e) == 2 and all(type(x) is int for x in e) and 0 <= e[0] < e[1] < n):
            raise Refusal('EDGE_FORMAT', f'edge {k} is not a pair i < j of vertex indices: {e!r}')
        E.append((e[0], e[1]))
    if len(set(E)) != len(E):
        raise Refusal('EDGE_FORMAT', 'an edge is listed twice')
    return set(E)


# ---------------------------------------------------------------- 5. LRAT

def open_proof(path):
    with open(path, 'rb') as f:
        head = f.read(2)
    return gzip.open(path, 'rb') if head == b'\x1f\x8b' else open(path, 'rb')


def check_lrat(clauses, nvars, path):
    """clauses: the formula, numbered 1..M in order. Returns (additions, deletions, id of the empty clause, sha256 of the proof text)."""
    db = {k + 1: c for k, c in enumerate(clauses)}
    last_id = len(clauses)
    val = [0] * (nvars + 1)          # 1 true, -1 false, 0 unassigned (by variable)
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
                for l in lits:
                    v = abs(l)
                    if v > nvars:
                        raise Refusal('PROOF_STEP', f'line {lineno}: literal {l} is outside the formula\'s {nvars} variables')
                    want = -1 if l > 0 else 1          # assume the clause false
                    if val[v] == -want:
                        raise Refusal('PROOF_STEP', f'line {lineno}: clause {cid} is a tautology or repeats a literal with both signs')
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
                    free = None
                    nfree = 0
                    for l in D:
                        s = val[abs(l)]
                        if s == 0:
                            nfree += 1
                            free = l
                        elif (s == 1) == (l > 0):
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
                return adds, dels, cid, sha.hexdigest(), lineno
    raise Refusal('NO_EMPTY_CLAUSE', f'the proof ends after {adds} additions without deriving the empty clause')


# ---------------------------------------------------------------- the check

def check(witness_path, proof_path):
    try:
        with open(witness_path, 'rb') as f:
            wbytes = f.read()
        W = json.loads(wbytes)
    except (OSError, ValueError) as ex:
        raise Refusal('WITNESS_UNREADABLE', str(ex))
    pts = read_points(W.get('points'))
    n = len(pts)
    file_edges = read_edges(W.get('edges'), n)
    derived, tested, is_unit = derive_unit_edges(pts)
    for e in sorted(file_edges):
        if not is_unit(*e):
            raise Refusal('EDGE_NOT_UNIT', f'the file lists edge {list(e)} between {list(pts[e[0]])} and {list(pts[e[1]])}, which are not at distance 1')
    for e in sorted(derived):
        if e not in file_edges:
            raise Refusal('EDGE_MISSING', f'points {e[0]} and {e[1]} ({list(pts[e[0]])}, {list(pts[e[1]])}) are at distance 1 but the file omits the edge')
    assert derived == file_edges
    index = {p: k for k, p in enumerate(pts)}
    o, one = index.get((0, 0, 0, 0, 1)), index.get((1, 0, 0, 0, 1))
    if o is None or one is None:
        raise Refusal('NO_UNIT_SEGMENT', 'the points (0, 0) and (1, 0) are not both listed')
    if (min(o, one), max(o, one)) not in derived:
        raise Refusal('NO_UNIT_SEGMENT', '(0, 0) and (1, 0) are not adjacent')
    pin = W.get('pinned_edge')
    if not (isinstance(pin, list) and len(pin) == 2 and all(type(x) is int and 0 <= x < n for x in pin) and pin[0] != pin[1]):
        raise Refusal('PIN_FORMAT', f'pinned_edge is not two distinct vertex indices: {pin!r}')
    p, q = pin
    if (min(p, q), max(p, q)) not in derived:
        raise Refusal('PIN_NOT_EDGE', f'the pinned pair {pin} is not at distance 1, so colouring it 0 and 1 is not a symmetry reduction')
    x = lambda v, k: 3 * v + k + 1
    clauses = [(x(v, 0), x(v, 1), x(v, 2)) for v in range(n)]
    for i, j in sorted(derived):
        for k in range(3):
            clauses.append((-x(i, k), -x(j, k)))
    clauses += [(x(p, 0),), (x(q, 1),)]
    adds, dels, empty_id, psha, lines = check_lrat(clauses, 3 * n, proof_path)
    return {'points': n, 'edges': len(derived), 'pairs_tested': tested, 'pin': (p, q), 'origin': o, 'one': one, 'vars': 3 * n,
            'clauses': len(clauses), 'additions': adds, 'deletions': dels, 'empty_id': empty_id, 'proof_sha256': psha,
            'witness_sha256': hashlib.sha256(wbytes).hexdigest(), 'claimed_proof_sha256': W.get('proof_sha256_uncompressed')}


def main_check(witness_path, proof_path):
    try:
        r = check(witness_path, proof_path)
    except Refusal as ex:
        print(f'REFUSED {ex.code}: {ex.detail}')
        return 1
    print(f'CERTIFIED: {r["points"]} points of Q(sqrt11)^2, each a reduced (a, b, c, e, m); all {r["edges"]} pairs at distance exactly 1 '
          f're-derived in integer arithmetic ({r["pairs_tested"]} candidate pairs tested) and equal to the file\'s edge list; (0, 0) = vertex '
          f'{r["origin"]} and (1, 0) = vertex {r["one"]} adjacent; pinned edge {list(r["pin"])} adjacent; CNF built here with {r["vars"]} variables '
          f'and {r["clauses"]} clauses; LRAT checked here: {r["additions"]} additions, {r["deletions"]} deletion lines, empty clause at id '
          f'{r["empty_id"]}. No proper 3-colouring exists, so chi(Q(sqrt11)^2) >= 4.')
    print(f'  witness sha256 {r["witness_sha256"]}; proof text sha256 {r["proof_sha256"]}'
          + ('' if r['claimed_proof_sha256'] in (None, r['proof_sha256']) else f' (the witness file names {r["claimed_proof_sha256"]}: the files are out of step)'))
    return 0


# ---------------------------------------------------------------- planted faults

def run_self(witness, proof):
    r = subprocess.run([sys.executable, os.path.abspath(__file__), witness, proof], capture_output=True, text=True)
    out = r.stdout.strip().splitlines()
    return r.returncode, (out[0] if out else r.stderr.strip()[-300:])


def sha_file(path):
    with open(path, 'rb') as f:
        return hashlib.sha256(f.read()).hexdigest()


def controls(witness_path, proof_path):
    W = json.loads(open(witness_path, 'rb').read())
    with open_proof(proof_path) as f:
        proof_lines = f.read().split(b'\n')
    n = len(W['points'])
    pts = [tuple(p) for p in W['points']]
    edges = [tuple(e) for e in W['edges']]
    adj = {}
    for i, j in edges:
        adj.setdefault(i, set()).add(j)
        adj.setdefault(j, set()).add(i)
    p0, q0 = W['pinned_edge']
    tmp = tempfile.mkdtemp(prefix='fs58-controls-')
    wsha, psha = sha_file(witness_path), hashlib.sha256(b'\n'.join(proof_lines)).hexdigest()
    fails = 0

    def put_w(name, obj):
        path = os.path.join(tmp, name + '.json')
        with open(path, 'w') as f:
            json.dump(obj, f)
        return path

    def put_p(name, lines):
        path = os.path.join(tmp, name + '.lrat')
        with open(path, 'wb') as f:
            f.write(b'\n'.join(lines))
        return path

    def expect(label, wpath, ppath, codes):
        """a planted fault: the planted files must differ in content from the faithful ones (so the plant fired), and the checker must
        refuse with one of the named codes"""
        nonlocal fails
        code, line = run_self(wpath, ppath)
        with open(wpath, 'rb') as f:
            wobj = json.loads(f.read())
        with open_proof(ppath) as f:
            plines = f.read().split(b'\n')
        changed = wobj != W or [l for l in plines if l.strip()] != [l for l in proof_lines if l.strip()]
        ok = changed and code == 1 and any(line.startswith(f'REFUSED {c}:') for c in codes)
        fails += not ok
        print(f'  [{"PASS" if ok else "FAIL"}] {label}: expected REFUSED {" or ".join(codes)}; got exit {code}: {line[:260]}'
              + ('' if changed else ' [THE PLANT CHANGED NOTHING]'))

    faithful_p = put_p('faithful', proof_lines)
    faithful_w = put_w('faithful', W)
    # the twin must be byte-identical in content: re-serialising the JSON changes bytes, so compare the parsed objects instead
    code, line = run_self(faithful_w, faithful_p)
    ok = code == 0 and line.startswith('CERTIFIED') and json.loads(open(faithful_w).read()) == W and sha_file(faithful_p) == psha
    fails += not ok
    print(f'  [{"PASS" if ok else "FAIL"}] positive twin (the faithful files, re-serialised): expected CERTIFIED; got exit {code}: {line[:160]}')

    # 1. a point moved: shift one non-pinned vertex of positive degree by 1/m in x (numerator a + 1), reduced; the edges at it vanish
    for v in sorted(adj, key=lambda v: -len(adj[v])):
        if v in (p0, q0):
            continue
        a, b, c, e, m = pts[v]
        g = math.gcd(math.gcd(math.gcd(math.gcd(a + 1, b), c), e), m)
        moved = [(a + 1) // g, b // g, c // g, e // g, m // g]
        if tuple(moved) not in pts:
            break
    Wm = dict(W, points=[list(p) for p in pts])
    Wm['points'][v] = moved
    expect(f'a point moved (vertex {v}, degree {len(adj[v])}, a -> a + 1)', put_w('moved', Wm), faithful_p, ['EDGE_NOT_UNIT'])

    # 2. a non-unit pair inserted as an edge
    ins = next((i, j) for i in range(n) for j in range(i + 1, n) if j not in adj.get(i, ()))
    Wi = dict(W, edges=sorted(edges + [ins]))
    expect(f'a non-unit pair {list(ins)} inserted as an edge', put_w('inserted', Wi), faithful_p, ['EDGE_NOT_UNIT'])

    # 3. the proof truncated (first half of its lines)
    body = [l for l in proof_lines if l.strip()]
    expect(f'the proof truncated to {len(body) // 2} of {len(body)} lines', faithful_w, put_p('truncated', body[:len(body) // 2]),
           ['NO_EMPTY_CLAUSE'])

    # 4. one hint corrupted: in the addition line nearest the middle with at least two hints, the first hint replaced by clause 1
    adds = [k for k, l in enumerate(body) if l.split()[1:2] != [b'd']]
    for k in sorted(adds, key=lambda k: abs(k - len(body) // 2)):
        toks = body[k].split()
        z = toks.index(b'0', 1)
        hints = toks[z + 1:-1]
        if len(hints) >= 2 and hints[0] != b'1':
            toks[z + 1] = b'1'
            corrupted = body[:k] + [b' '.join(toks)] + body[k + 1:]
            break
    expect(f'one hint corrupted (proof line {k + 1}: first hint {hints[0].decode()} -> 1)', faithful_w, put_p('corrupted', corrupted),
           ['PROOF_STEP'])

    # 4b. a derivation's last hint dropped: the remaining hints propagate but reach no conflict
    for k2 in sorted(adds, key=lambda k: abs(k - len(body) // 3)):
        toks = body[k2].split()
        z = toks.index(b'0', 1)
        if len(toks) - z - 2 >= 2 and z > 1:
            dropped = toks[-2]
            short = body[:k2] + [b' '.join(toks[:-2] + [b'0'])] + body[k2 + 1:]
            break
    expect(f'a derivation\'s last hint dropped (proof line {k2 + 1}: hint {dropped.decode()} removed)', faithful_w,
           put_p('last-hint-dropped', short), ['PROOF_STEP'])

    # 5. the pin reversed: (p, q) -> (q, p). Still a legitimate symmetry reduction, but not the formula the proof refutes
    expect(f'the pin reversed ({p0}, {q0}) -> ({q0}, {p0})', put_w('pin-reversed', dict(W, pinned_edge=[q0, p0])), faithful_p, ['PROOF_STEP'])

    # 6. the pinned edge removed from the edge list
    expect(f'the pinned edge ({min(p0, q0)}, {max(p0, q0)}) removed from the edge list',
           put_w('pin-edge-removed', dict(W, edges=[list(e) for e in edges if set(e) != {p0, q0}])), faithful_p, ['EDGE_MISSING'])

    # 7. the pin moved to a non-adjacent pair (colouring it 0, 1 is no longer a symmetry reduction)
    far = next(j for j in range(n) if j != p0 and j not in adj.get(p0, ()))
    expect(f'the pin moved to the non-adjacent pair ({p0}, {far})', put_w('pin-not-edge', dict(W, pinned_edge=[p0, far])), faithful_p,
           ['PIN_NOT_EDGE'])

    # 8. a vertex deleted, the file kept self-consistent (edges at it dropped, indices renumbered): the proof no longer matches
    dv = next(v for v in range(n - 1, -1, -1) if v not in (p0, q0) and v in adj)
    ren = lambda i: i - (i > dv)
    Wd = dict(W, points=[list(p) for k, p in enumerate(pts) if k != dv],
              edges=sorted([ren(i), ren(j)] for i, j in edges if dv not in (i, j)), pinned_edge=[ren(p0), ren(q0)])
    expect(f'a vertex deleted (vertex {dv}, degree {len(adj[dv])}; file renumbered consistently)', put_w('vertex-deleted', Wd), faithful_p,
           ['PROOF_STEP', 'NO_EMPTY_CLAUSE'])

    # 9. a point duplicated in place of another
    Wdup = dict(W, points=[list(p) for p in pts])
    Wdup['points'][dv] = list(pts[p0])
    expect('a point listed twice', put_w('duplicate', Wdup), faithful_p, ['DUPLICATE_POINT'])

    # 10. a point not reduced (every entry doubled)
    Wnr = dict(W, points=[list(p) for p in pts])
    Wnr['points'][dv] = [2 * x for x in pts[dv]]
    expect('a point not in reduced form', put_w('unreduced', Wnr), faithful_p, ['POINT_FORMAT'])

    # 11. the bucketing proposes every unit pair: an all-pairs exact test on this witness finds exactly the same edge set
    allpairs = set()
    L, S = common_scale(pts)
    for i in range(n):
        X0, X1, Y0, Y1 = S[i]
        for j in range(i + 1, n):
            Z0, Z1, V0, V1 = S[j]
            d0, d1, e0, e1 = X0 - Z0, X1 - Z1, Y0 - V0, Y1 - V1
            if d0 * d1 + e0 * e1 == 0 and d0 * d0 + e0 * e0 + RADICAND * (d1 * d1 + e1 * e1) == L * L:
                allpairs.add((i, j))
    bucketed = derive_unit_edges(pts)[0]
    ok = allpairs == bucketed == set(edges) and len(allpairs) > 0
    fails += not ok
    print(f'  [{"PASS" if ok else "FAIL"}] bucketing completeness: the all-pairs exact test over {n * (n - 1) // 2} pairs finds '
          f'{len(allpairs)} unit pairs, the bucketed search {len(bucketed)}, the file {len(edges)}')

    shutil.rmtree(tmp)
    print(f'CONTROLS {"ALL PASS" if fails == 0 else f"{fails} FAILED"}')
    return 1 if fails else 0


def main():
    args = sys.argv[1:]
    ctl = '--controls' in args
    args = [a for a in args if a != '--controls']
    if not args or len(args) > 2:
        print(__doc__)
        return 2
    wpath = args[0]
    ppath = args[1] if len(args) == 2 else os.path.join(os.path.dirname(os.path.abspath(wpath)), 'witness.lrat.gz')
    return controls(wpath, ppath) if ctl else main_check(wpath, ppath)


if __name__ == '__main__':
    sys.exit(main())
