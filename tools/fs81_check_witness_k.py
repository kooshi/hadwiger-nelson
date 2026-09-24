#!/usr/bin/env python3
"""fs81_check_witness_k -- K2: the standalone checker for k-colour refusals of finite unit-distance graphs over a real multiquadratic
field F = Q(sqrt d_1, ..., sqrt d_r), r >= 1 (FS-81 stage D; plan S.D, acceptance row K2).  A copy of the frozen
tools/fs58_check_witness.py (three colours over Q(sqrt D)) with four changes: the colour count k is read from the witness; the field may
have several radicands (X_A, the refusing control, lives over K = Q(sqrt3, sqrt11), not over a quadratic field); at most one named
NON-unit edge may be added, and then the conclusion is a forced pair, never a chromatic bound; and every symmetry clause (pins, value
precedence) is generated here from a rule stated below, whose soundness is argued below.

STANDARD LIBRARY ONLY, and it imports nothing from tools/: it shares no code with the generator (tools/fs81_d47.py, tools/fs81_phaseD.py)
or any solver.

THE FIELD.  radicands [d_1, ..., d_r], positive integers.  The basis of F over Q is beta_S = sqrt(prod_{i in S} d_i) for the subsets S of
{1..r}, indexed by the bitmask S (bit i-1 set iff d_i is in the product), B = 2^r elements; beta_S beta_T = (prod_{i in S & T} d_i)
beta_{S xor T}.  The checker REFUSES the radicands unless no nonempty sub-product prod_{i in S} d_i is a perfect square; then the 2^r
elements are Q-linearly independent (Besicovitch 1940; for r = 1 it is the irrationality of sqrt d, which is all fs58 used), so two field
elements are equal iff their coefficient vectors are.  For r = 1 the point format below is exactly fs58's (a, b, c, e, m).

What it certifies.  WITNESS.json holds
  k                  the colour count (an integer >= 2)
  radicands          [d_1, ..., d_r]
  points             each a list of 2B + 1 integers [x_0 .. x_{B-1}, y_0 .. y_{B-1}, m], m > 0, gcd of all = 1, for the point
                     (sum_S x_S beta_S / m, sum_S y_S beta_S / m) of F^2
  edges              the unit edges [i, j], i < j
  extra_edge         (optional) one pair [p, q] NOT at distance 1; its squared length is computed exactly and reported
  pins               a list of vertices [v_0, ..., v_{p-1}] pinned to colours 0, ..., p-1 in that order ("pinned_edge": [p, q] is
                     accepted as fs58's spelling of pins [p, q])
  precedence_chains  (optional) a list of colour pairs [f1, f2]
The checker
  1. checks the field (radicands as above), every point is such a reduced tuple, and no point is listed twice;
  2. re-derives EVERY pair of points at distance exactly 1 in integer arithmetic (integer cell keys propose, the coefficient test
     decides) and refuses unless that set equals the file's edge list, so the graph is the induced unit-distance graph on the points;
  3. checks the extra edge, if any, is two distinct points NOT at distance 1, and reports its exact squared length;
  4. THE SYMMETRY RULE.  pins: distinct vertices forming a clique of G' = (unit edges) + (extra edge), at most k of them, pinned to
     colours 0..p-1.  Sound: a proper k-colouring of G' gives a clique distinct colours, and a permutation of the colours makes them
     0..p-1.  precedence_chains: each [f1, f2] must satisfy f1 < f2 < k and BOTH f1 and f2 UNPINNED (>= p); a chain touching a pinned
     colour is REFUSED (PRECEDENCE_OVER_PINNED_COLOUR: with the pinned vertices placed anywhere but first in the vertex order it forbids
     colourings no permutation can repair -- plan S B.2.2, close inventory item 52).  For each chain, auxiliary variables s(0..n) are
     added and the clauses [-s(0)]; for v = 0..n-1 in vertex order [-x(v,f2), s(v)] and [-s(v+1), s(v), x(v,f1)].  Sound: given a proper
     k-colouring with the pins, relabel the UNPINNED colours in order of first appearance along the vertex order (unused ones last);
     this fixes every pin, and then for every unpinned f1 < f2 the first appearance of f1 precedes that of f2; setting s(v) = [f1 appears
     at some u < v] satisfies every chain clause.  So the chains never exclude every colouring of a colourable graph.
  5. builds the CNF itself, from ITS OWN edges: x(v, c) = k v + c + 1; for each vertex in order [x(v,0) .. x(v,k-1)]; for each edge
     (i, j), i < j, of the derived unit edges plus the extra edge, in sorted order, [-x(i,c), -x(j,c)] for c = 0..k-1; then [x(v_c, c)]
     per pin in order; then the chains' clauses, chain by chain, their s variables numbered k n + (chain index)(n + 1) + v + 1.  With
     k = 3, an edge pin and no chains this is fs58's CNF clause for clause, and with k = 4, a clique pin and no chains fs73's;
  6. checks the LRAT proof against that CNF with its own checker (fs58's routine: each added clause implied by reverse unit propagation
     over exactly its listed hints, in order, the last one falsified; deletions honoured; RAT steps refused); the proof must add the
     empty clause.
If every step passes:
  * with no extra edge: no proper k-colouring of the unit-distance graph on these points exists, so chi(F^2) >= k + 1;
  * with the extra edge {p, q}: no proper k-colouring of the unit-distance graph plus that ONE edge exists, so every proper k-colouring
    of the unit-distance graph gives p and q one colour -- a forced pair.  This is NOT a chromatic bound and is never printed as one.
It prints the CNF's sha256 (DIMACS text, 'p cnf V C' then one clause per line ending in ' 0'), so a solver run is tied to the formula
checked here; --write-cnf PATH writes that text (the input for a second, independently written RUP checker and a second solver).

Usage:
  fs81_check_witness_k.py WITNESS.json [PROOF.lrat[.gz]] [--write-cnf PATH]   -> CERTIFIED (exit 0) or REFUSED <CODE>: <detail> (exit 1)
  fs81_check_witness_k.py --selftest                                           -> the planted faults and controls (plan S.D, K2)
The proof defaults to witness.lrat.gz beside the witness file.
"""
import gzip
import hashlib
import json
import math
import os
import shutil
import subprocess
import sys
import tempfile


class Refusal(Exception):
    def __init__(self, code, detail):
        super().__init__(f'{code}: {detail}')
        self.code, self.detail = code, detail


# ---------------------------------------------------------------- 1. the field and the points

def read_field(raw):
    if not (isinstance(raw, list) and 1 <= len(raw) <= 6 and all(type(d) is int and d > 1 for d in raw)):
        raise Refusal('RADICAND', f'radicands must be a list of 1..6 integers > 1: {raw!r}')
    r = len(raw)
    prods = []
    for S in range(1 << r):
        p = 1
        for i in range(r):
            if S >> i & 1:
                p *= raw[i]
        prods.append(p)
        if S and math.isqrt(p) ** 2 == p:
            raise Refusal('RADICAND', f'the sub-product {p} of {raw} is a perfect square, so the basis would be dependent')
    return raw, prods


def basis_name(radicands, S):
    ds = [str(d) for i, d in enumerate(radicands) if S >> i & 1]
    return '1' if not ds else 'sqrt' + '*'.join(ds)


def read_points(raw, B):
    if not isinstance(raw, list) or not raw:
        raise Refusal('POINT_FORMAT', 'points is not a non-empty list')
    pts = []
    for k, p in enumerate(raw):
        if not (isinstance(p, list) and len(p) == 2 * B + 1 and all(type(x) is int for x in p)):
            raise Refusal('POINT_FORMAT', f'point {k} is not {2 * B + 1} integers: {p!r}')
        if p[-1] <= 0:
            raise Refusal('POINT_FORMAT', f'point {k} has denominator {p[-1]} <= 0')
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

class Plane:
    """the points over one common denominator L: X[i] = (x_S), Y[i] = (y_S) with x = sum x_S beta_S / L"""

    def __init__(self, radicands, prods, pts):
        self.rad, self.prods, self.B = radicands, prods, len(prods)
        B = self.B
        L = 1
        for p in pts:
            L = L * p[-1] // math.gcd(L, p[-1])
        self.L = L
        self.X = [tuple(c * (L // p[-1]) for c in p[:B]) for p in pts]
        self.Y = [tuple(c * (L // p[-1]) for c in p[B:2 * B]) for p in pts]
        # c(S, T) = prod_{i in S & T} d_i
        self.cst = [[prods[S & T] for T in range(B)] for S in range(B)]

    def square(self, v):
        """the coefficient vector of (sum_S v_S beta_S)^2"""
        B, out = self.B, [0] * self.B
        for S in range(B):
            a = v[S]
            if not a:
                continue
            for T in range(B):
                b = v[T]
                if b:
                    out[S ^ T] += a * b * self.cst[S][T]
        return out

    def sqdist_coeffs(self, i, j):
        """(the coefficient vector of L^2 |P_i - P_j|^2)"""
        dx = [a - b for a, b in zip(self.X[i], self.X[j])]
        dy = [a - b for a, b in zip(self.Y[i], self.Y[j])]
        return [a + b for a, b in zip(self.square(dx), self.square(dy))]

    def is_unit(self, i, j):
        # the rational part first (a necessary condition, cheap), then every coefficient
        dx = [a - b for a, b in zip(self.X[i], self.X[j])]
        dy = [a - b for a, b in zip(self.Y[i], self.Y[j])]
        rat = sum(self.prods[S] * (dx[S] * dx[S] + dy[S] * dy[S]) for S in range(self.B))
        if rat != self.L * self.L:
            return False
        c = self.sqdist_coeffs(i, j)
        return c[0] == self.L * self.L and not any(c[1:])

    def approx_floor(self, v):
        """an integer within e of floor(sum v_S beta_S / L): each irrational term is bracketed by isqrt within 1, so the numerator is
        within B - 1, and the quotient within e = ceil((B - 1)/L) (at least 1)"""
        N = v[0]
        for S in range(1, self.B):
            a = v[S]
            if a:
                s = math.isqrt(a * a * self.prods[S])
                N += s if a > 0 else -s
        return N // self.L


def derive_unit_edges(plane, n):
    """all pairs (i, j), i < j, at distance exactly 1.  Two points at distance <= 1 have floors of x and of y differing by <= 1, keys
    within e of the floors, so keys differing by <= 1 + 2e; every cell pair with offsets in [-(1+2e), 1+2e]^2 is searched once."""
    e = max(1, -(-(plane.B - 1) // plane.L))
    w = 1 + 2 * e
    cells = {}
    for i in range(n):
        cells.setdefault((plane.approx_floor(plane.X[i]), plane.approx_floor(plane.Y[i])), []).append(i)
    offsets = [(dx, dy) for dx in range(-w, w + 1) for dy in range(-w, w + 1) if (dx, dy) > (0, 0)]
    edges, tested = set(), 0
    for key, mem in cells.items():
        for x in range(len(mem)):
            for y in range(x + 1, len(mem)):
                tested += 1
                if plane.is_unit(mem[x], mem[y]):
                    edges.add((min(mem[x], mem[y]), max(mem[x], mem[y])))
        for dx, dy in offsets:
            other = cells.get((key[0] + dx, key[1] + dy))
            if not other:
                continue
            for i in mem:
                for j in other:
                    tested += 1
                    if plane.is_unit(i, j):
                        edges.add((min(i, j), max(i, j)))
    return edges, tested


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


# ---------------------------------------------------------------- 4-5. the symmetry rule and the CNF

def read_symmetry(W, n, k):
    pins = W.get('pins', W.get('pinned_edge') if 'pins' not in W else None)
    if not (isinstance(pins, list) and all(type(v) is int and 0 <= v < n for v in pins)):
        raise Refusal('PIN_FORMAT', f'pins is not a list of vertex indices: {pins!r}')
    if len(set(pins)) != len(pins) or len(pins) > k:
        raise Refusal('PIN_FORMAT', f'pins repeat a vertex or exceed k = {k}: {pins!r}')
    chains = W.get('precedence_chains', [])
    if not (isinstance(chains, list) and all(isinstance(c, list) and len(c) == 2 and all(type(f) is int for f in c) for c in chains)):
        raise Refusal('PRECEDENCE_FORMAT', f'precedence_chains is not a list of colour pairs: {chains!r}')
    p = len(pins)
    for f1, f2 in chains:
        if not (0 <= f1 < f2 < k):
            raise Refusal('PRECEDENCE_FORMAT', f'chain [{f1}, {f2}] is not two colours f1 < f2 < k = {k}')
        if f1 < p or f2 < p:
            raise Refusal('PRECEDENCE_OVER_PINNED_COLOUR', f'chain [{f1}, {f2}] touches a pinned colour (colours 0..{p - 1} are pinned); '
                                                             'the rule admits value precedence over UNPINNED colours only')
    if len({tuple(c) for c in chains}) != len(chains):
        raise Refusal('PRECEDENCE_FORMAT', 'a chain is listed twice')
    return list(pins), [tuple(c) for c in chains]


def build_cnf(n, k, edges, pins, chains):
    x = lambda v, c: k * v + c + 1          # noqa: E731
    clauses = [tuple(x(v, c) for c in range(k)) for v in range(n)]
    for i, j in sorted(edges):
        for c in range(k):
            clauses.append((-x(i, c), -x(j, c)))
    clauses += [(x(v, c),) for c, v in enumerate(pins)]
    nvars = k * n
    for ci, (f1, f2) in enumerate(chains):
        base = k * n + ci * (n + 1)
        s = lambda v: base + v + 1          # noqa: E731
        clauses.append((-s(0),))
        for v in range(n):
            clauses.append((-x(v, f2), s(v)))
            clauses.append((-s(v + 1), s(v), x(v, f1)))
        nvars = base + n + 1
    return clauses, nvars


def cnf_text(clauses, nvars):
    return f'p cnf {nvars} {len(clauses)}\n' + ''.join(' '.join(map(str, c)) + ' 0\n' for c in clauses)


# ---------------------------------------------------------------- 6. LRAT (fs58's routine, unchanged)

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


# ---------------------------------------------------------------- the check

def check(witness_path, proof_path, write_cnf=None):
    try:
        with open(witness_path, 'rb') as f:
            wbytes = f.read()
        W = json.loads(wbytes)
    except (OSError, ValueError) as ex:
        raise Refusal('WITNESS_UNREADABLE', str(ex))
    k = W.get('k')
    if not (type(k) is int and k >= 2):
        raise Refusal('K_FORMAT', f'k is not an integer >= 2: {k!r}')
    radicands, prods = read_field(W.get('radicands'))
    B = len(prods)
    pts = read_points(W.get('points'), B)
    n = len(pts)
    file_edges = read_edges(W.get('edges'), n)
    pins, chains = read_symmetry(W, n, k)          # the symmetry rule is checked before any expensive step
    plane = Plane(radicands, prods, pts)
    for e in sorted(file_edges):
        if not plane.is_unit(*e):
            raise Refusal('EDGE_NOT_UNIT', f'the file lists edge {list(e)} between {list(pts[e[0]])} and {list(pts[e[1]])}, which are not at '
                                            'distance 1')
    derived, tested = derive_unit_edges(plane, n)
    for e in sorted(derived):
        if e not in file_edges:
            raise Refusal('EDGE_MISSING', f'points {e[0]} and {e[1]} ({list(pts[e[0]])}, {list(pts[e[1]])}) are at distance 1 but the file omits '
                                           'the edge')
    assert derived == file_edges
    extra = W.get('extra_edge')
    extra_sq = None
    if extra is not None:
        if not (isinstance(extra, list) and len(extra) == 2 and all(type(v) is int and 0 <= v < n for v in extra) and extra[0] != extra[1]):
            raise Refusal('EXTRA_EDGE_FORMAT', f'extra_edge is not two distinct vertex indices: {extra!r}')
        ee = (min(extra), max(extra))
        if ee in derived:
            raise Refusal('EXTRA_EDGE_IS_UNIT', f'the extra edge {list(ee)} is at distance 1: it is already a unit edge')
        c = plane.sqdist_coeffs(*ee)
        g = math.gcd(*c, plane.L * plane.L)
        num = ' + '.join((f'{ci // g}' if S == 0 else f'{ci // g}*{basis_name(radicands, S)}') for S, ci in enumerate(c) if ci)
        extra_sq = (f'{num}/{plane.L * plane.L // g}' if sum(1 for ci in c if ci) == 1 and c[0] else f'({num})/{plane.L * plane.L // g}')
        edges = derived | {ee}
    else:
        edges = derived
    for a in range(len(pins)):
        for b in range(a + 1, len(pins)):
            if (min(pins[a], pins[b]), max(pins[a], pins[b])) not in edges:
                raise Refusal('PIN_NOT_CLIQUE', f'pinned vertices {pins[a]} and {pins[b]} are not adjacent, so colouring them apart is not '
                                                 'a symmetry reduction')
    clauses, nvars = build_cnf(n, k, edges, pins, chains)
    text = cnf_text(clauses, nvars)
    csha = hashlib.sha256(text.encode()).hexdigest()
    if write_cnf:
        with open(write_cnf, 'w') as f:
            f.write(text)
    adds, dels, empty_id, psha = check_lrat(clauses, nvars, proof_path)
    return {'k': k, 'radicands': radicands, 'points': n, 'edges': len(derived), 'pairs_tested': tested, 'extra': extra, 'extra_sq': extra_sq,
            'pins': pins, 'chains': chains, 'vars': nvars, 'clauses': len(clauses), 'cnf_sha256': csha, 'additions': adds, 'deletions': dels,
            'empty_id': empty_id, 'proof_sha256': psha, 'witness_sha256': hashlib.sha256(wbytes).hexdigest(),
            'claimed_cnf_sha256': W.get('cnf_sha256')}


def field_name(radicands):
    return 'Q(' + ', '.join(f'sqrt{d}' for d in radicands) + ')'


def certified_line(r):
    F = field_name(r['radicands'])
    head = (f'CERTIFIED: {r["points"]} points of {F}^2; all {r["edges"]} pairs at distance exactly 1 re-derived in integer arithmetic '
            f'({r["pairs_tested"]} candidate pairs tested) and equal to the file\'s edge list; ')
    if r['extra'] is not None:
        head += f'plus ONE non-unit edge {r["extra"]} of squared length {r["extra_sq"]}; '
    head += (f'pins {r["pins"]} to colours 0..{len(r["pins"]) - 1} (a clique); precedence chains {[list(c) for c in r["chains"]]} over '
             f'unpinned colours; CNF built here at k = {r["k"]}: {r["vars"]} variables, {r["clauses"]} clauses, sha256 {r["cnf_sha256"][:16]}; '
             f'LRAT checked here: {r["additions"]} additions, {r["deletions"]} deletion lines, empty clause at id {r["empty_id"]}.')
    if r['extra'] is None:
        concl = (f' No proper {r["k"]}-colouring of this unit-distance graph exists, hence chi({F}^2) >= {r["k"] + 1}.')
    else:
        p, q = r['extra']
        concl = (f' The unit-distance graph plus that one edge has no proper {r["k"]}-colouring, hence every proper {r["k"]}-colouring of '
                 f'the unit-distance graph on these points gives points {p} and {q} one colour: a FORCED PAIR at {r["k"]} colours. This '
                 f'is not a chromatic bound.')
    return head + concl


def main_check(witness_path, proof_path, write_cnf=None):
    try:
        r = check(witness_path, proof_path, write_cnf)
    except Refusal as ex:
        print(f'REFUSED {ex.code}: {ex.detail}')
        return 1
    print(certified_line(r))
    print(f'  witness sha256 {r["witness_sha256"]}; cnf sha256 {r["cnf_sha256"]}; proof text sha256 {r["proof_sha256"]}'
          + ('' if r['claimed_cnf_sha256'] in (None, r['cnf_sha256'])
             else f' (the witness file names cnf {r["claimed_cnf_sha256"]}: the files are out of step)'))
    return 0


# ---------------------------------------------------------------- the self-test (plan S.D, K2's plants and controls)

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
FIX = os.path.join(ROOT, 'data', 'fs81', 'phaseD', 'k2-fixtures')


def run_self(wpath, ppath):
    r = subprocess.run([sys.executable, os.path.abspath(__file__), wpath, ppath], capture_output=True, text=True)
    out = r.stdout.strip().splitlines()
    return r.returncode, (out[0] if out else r.stderr.strip()[-400:])


def selftest():
    tmp = tempfile.mkdtemp(prefix='fs81-k2-selftest-')
    fails = []

    def put(name, obj):
        path = os.path.join(tmp, name + '.json')
        with open(path, 'w') as f:
            json.dump(obj, f)
        return path

    def expect(label, wpath, ppath, codes, must_contain=(), must_not_contain=()):
        code, line = run_self(wpath, ppath)
        if codes == 'CERTIFIED':
            ok = code == 0 and line.startswith('CERTIFIED') and all(s in line for s in must_contain) and not any(s in line for s in must_not_contain)
            want = 'CERTIFIED' + (f' containing {list(must_contain)}' if must_contain else '') + (f' and not {list(must_not_contain)}' if must_not_contain else '')
        else:
            ok = code == 1 and any(line.startswith(f'REFUSED {c}:') for c in codes)
            want = 'REFUSED ' + ' or '.join(codes)
        if not ok:
            fails.append(label)
        print(f'  [{"PASS" if ok else "FAIL"}] {label}: expected {want}; got exit {code}: {line[:300]}', flush=True)

    # ---- controls at k = 3 over quadratic fields: FS-58's witnesses, with k and radicands declared, certify as the frozen checker does
    for D in (11, 47):
        wd = os.path.join(ROOT, 'data', 'fs58', f'witness-{D}')
        W = json.load(open(os.path.join(wd, 'witness.json')))
        W3 = dict(W, k=3, radicands=[D])
        pf = os.path.join(wd, 'witness.lrat.gz')
        expect(f'control: FS-58 Q(sqrt{D}) witness at k = 3', put(f'fs58-{D}-k3', W3), pf, 'CERTIFIED',
               must_contain=(f'hence chi(Q(sqrt{D})^2) >= 4',), must_not_contain=('FORCED PAIR',))
        expect(f'control: the same witness and proof at k = 4 (the graph is four-colourable; no proof can exist)',
               put(f'fs58-{D}-k4', dict(W3, k=4)), pf, ['PROOF_STEP'])
        if D == 11:
            fr = subprocess.run([sys.executable, os.path.join(HERE, 'fs58_check_witness.py'), '--radicand', str(D),
                                 os.path.join(wd, 'witness.json'), pf], capture_output=True, text=True)
            code, line = run_self(put(f'fs58-{D}-k3b', W3), pf)
            same = fr.returncode == 0 and code == 0
            # the frozen checker's CNF: same clause count and variables (it does not print its sha); compare counts from both lines
            import re
            a = re.search(r'(\d+) variables and (\d+) clauses', fr.stdout)
            b = re.search(r'(\d+) variables, (\d+) clauses', line)
            same = same and a and b and a.groups() == b.groups()
            print(f'  [{"PASS" if same else "FAIL"}] control: the frozen fs58 checker and K2 agree on Q(sqrt11) (both certify; variables '
                  f'and clauses {a.groups() if a else None} vs {b.groups() if b else None})', flush=True)
            if not same:
                fails.append('frozen agreement')

    # ---- the k = 4 fixtures: X_A's certified core in K2's format, (a) under fs73's triangle pin with fs73's own LRAT,
    #      (b) under a unit-edge pin plus the chain [2, 3] with a CaDiCaL LRAT made for this self-test (tools/fs81_phaseD.py k2-fixture)
    a_w, a_p = os.path.join(FIX, 'xa-core-tri', 'witness.json'), os.path.join(FIX, 'xa-core-tri', 'witness.lrat.gz')
    b_w, b_p = os.path.join(FIX, 'xa-core-edge-prec', 'witness.json'), os.path.join(FIX, 'xa-core-edge-prec', 'witness.lrat.gz')
    for p in (a_w, a_p, b_w, b_p):
        if not os.path.exists(p):
            print(f'  [FAIL] fixture missing: {p} (build it with tools/fs81_phaseD.py k2-fixture)')
            fails.append('fixture ' + p)
    if not fails or all(not f.startswith('fixture') for f in fails):
        WA, WB = json.load(open(a_w)), json.load(open(b_w))
        expect('twin (a): X_A core, triangle pin, fs73 LRAT', put('xa-a', WA), a_p, 'CERTIFIED', must_contain=('FORCED PAIR',),
               must_not_contain=('hence chi(',))
        expect('twin (b): X_A core, unit-edge pin + chain [2, 3], CaDiCaL LRAT', put('xa-b', WB), b_p, 'CERTIFIED',
               must_contain=('FORCED PAIR', 'precedence chains [[2, 3]]'), must_not_contain=('hence chi(',))
        n = len(WB['points'])
        E = {tuple(e) for e in WB['edges']}
        pins = WB['pins']
        # 1. a point moved off the lattice: a vertex of positive degree, not pinned, not on the extra edge, x_0 += 1 (reduced)
        adj = {}
        for i, j in E:
            adj.setdefault(i, set()).add(j)
            adj.setdefault(j, set()).add(i)
        v = next(v for v in sorted(adj, key=lambda v: -len(adj[v])) if v not in pins and v not in WB['extra_edge'])
        P = list(WB['points'][v])
        P[0] += 1                                    # x += 1/m: the point leaves the lattice
        g = 0
        for t in P:
            g = math.gcd(g, t)
        P = [t // g for t in P]
        Wm = json.loads(json.dumps(WB))
        Wm['points'][v] = P
        expect(f'plant: a point moved off the lattice (vertex {v}, degree {len(adj[v])}, x += 1/m)', put('moved', Wm), b_p, ['EDGE_NOT_UNIT'])
        # 2. an edge added that is not unit
        ins = next((i, j) for i in range(n) for j in range(i + 1, n) if (i, j) not in E and [i, j] != sorted(WB['extra_edge']))
        expect(f'plant: a non-unit pair {list(ins)} added to the edge list', put('inserted', dict(WB, edges=sorted([list(e) for e in E] + [list(ins)]))),
               b_p, ['EDGE_NOT_UNIT'])
        # 3. one edge dropped from the list
        dropped = sorted(E)[len(E) // 2]
        expect(f'plant: one edge {list(dropped)} dropped from the list', put('dropped', dict(WB, edges=sorted(list(e) for e in E if e != dropped))),
               b_p, ['EDGE_MISSING'])
        # 4. the pin moved to a non-adjacent pair
        far = next(j for j in range(n) if j != pins[0] and (min(j, pins[0]), max(j, pins[0])) not in E and sorted([j, pins[0]]) != sorted(WB['extra_edge']))
        expect(f'plant: the pin moved to the non-adjacent pair ({pins[0]}, {far})', put('pin-far', dict(WB, pins=[pins[0], far])), b_p, ['PIN_NOT_CLIQUE'])
        # 5. k changed from 4 to 3, the proof unchanged
        expect('plant: k changed from 4 to 3 with the proof unchanged (triangle-pinned twin)', put('k3', dict(WA, k=3)), a_p, ['PROOF_STEP'])
        expect('plant: k changed from 4 to 3 with the proof unchanged (edge-pinned twin; its chain [2, 3] is then over a colour >= k)',
               put('k3b', dict(WB, k=3)), b_p, ['PRECEDENCE_FORMAT'])
        # 6. a precedence clause over a pinned colour: the edge pin pins colours 0, 1; the chain [1, 2] touches pinned colour 1
        expect('plant: a precedence chain [1, 2] over pinned colour 1', put('prec-pinned', dict(WB, precedence_chains=[[1, 2]])), b_p,
               ['PRECEDENCE_OVER_PINNED_COLOUR'])
        expect('plant: a precedence chain [2, 3] under the triangle pin (colour 2 pinned)', put('prec-pinned-tri', dict(WA, precedence_chains=[[2, 3]])),
               a_p, ['PRECEDENCE_OVER_PINNED_COLOUR'])
        # 6b. the chain removed: the formula changes, so the proof (which may use the chain's clauses) must not certify silently
        #     -- an uninformative control if the proof never used them, so its verdict is printed, not required
        code, line = run_self(put('prec-removed', dict(WB, precedence_chains=[])), b_p)
        print(f'  [INFO] the chain removed from twin (b): exit {code}: {line[:160]}  (a PASS here would mean the proof never used the chain)')
        # 7. the proof truncated
        with open_proof(b_p) as f:
            body = [ln for ln in f.read().split(b'\n') if ln.strip()]
        tp = os.path.join(tmp, 'truncated.lrat')
        with open(tp, 'wb') as f:
            f.write(b'\n'.join(body[:len(body) // 2]) + b'\n')
        expect(f'plant: the proof truncated to {len(body) // 2} of {len(body)} lines', put('xa-b2', WB), tp, ['NO_EMPTY_CLAUSE'])
        # 8. the extra edge replaced by a unit edge (it would then be a unit pair, so the forced-pair reading is void)
        u = sorted(E)[0]
        expect(f'plant: the extra edge replaced by the unit edge {list(u)}', put('extra-unit', dict(WB, extra_edge=list(u))), b_p, ['EXTRA_EDGE_IS_UNIT'])
        # 9. dependent radicands (the sub-product 3 * 12 = 36 is a square)
        expect('plant: radicands [3, 12] (dependent basis)', put('rad', dict(WB, radicands=[3, 12])), b_p, ['RADICAND'])
        # 10. bucketing completeness on twin (b): an all-pairs exact test finds exactly the derived edges (the bucketed search's
        #     completeness, which EDGE_MISSING rests on)
        rad, prods = read_field(WB['radicands'])
        pts = read_points(WB['points'], len(prods))
        pl = Plane(rad, prods, pts)
        allpairs = {(i, j) for i in range(n) for j in range(i + 1, n) if pl.is_unit(i, j)}
        bucketed = derive_unit_edges(pl, n)[0]
        ok = allpairs == bucketed == E and allpairs
        print(f'  [{"PASS" if ok else "FAIL"}] bucketing completeness: all-pairs {len(allpairs)}, bucketed {len(bucketed)}, file {len(E)}', flush=True)
        if not ok:
            fails.append('bucketing')
    shutil.rmtree(tmp)
    print(f'SELFTEST {"ALL PASS" if not fails else f"{len(fails)} FAILED: " + "; ".join(fails)}')
    return 1 if fails else 0


def main():
    args = sys.argv[1:]
    if args == ['--selftest']:
        return selftest()
    wc = None
    if '--write-cnf' in args:
        i = args.index('--write-cnf')
        wc = args[i + 1]
        del args[i:i + 2]
    if not args or len(args) > 2:
        print(__doc__)
        return 2
    wpath = args[0]
    ppath = args[1] if len(args) == 2 else os.path.join(os.path.dirname(os.path.abspath(wpath)), 'witness.lrat.gz')
    return main_check(wpath, ppath, wc)


if __name__ == '__main__':
    sys.exit(main())
