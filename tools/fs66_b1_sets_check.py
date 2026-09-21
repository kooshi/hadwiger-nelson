#!/usr/bin/env python3
"""FS-66 phase 2B -- verify the explicit level-one independent sets, from the definition.

What this checks, and why anyone should care.  The all-levels certificate
(tools/fs66_b1_cert_check.py) bounds the independence number of every level of the tower of
unit-distance graphs over Z/p^k from ABOVE.  The lower halves of the brackets in
plans/FS66-phase2-certificate.md §ST -- and only those -- rest on explicit independent sets of
LEVEL ONE:

    alpha(UD(Z/p^k, 2))  >=  alpha(UD(F_p, 2)) * p^(2(k-1)),

because reduction modulo p is a graph homomorphism UD(Z/p^k, 2) -> UD(F_p, 2), so the full
preimage of an independent set is independent.  A 14-set at p = 7 therefore gives 686 at level
two, which meets the certificate's ceiling of 686 exactly; a 28-set at p = 11 gives 3,388.

So this program reads data/fs66/b1/level-one-sets.json and checks, from p alone and with nothing
imported from tools/, that each listed set really is an independent set of the size claimed.  It
takes no one's word for the unit circle, the point numbering or the sets: it rebuilds the plane,
rebuilds the circle, and tests every pair.

It does NOT check that the sets are MAXIMUM.  Nothing in §ST needs that: alpha(G_1) >= 28 is what
the brackets use, never alpha(G_1) = 28 (which is FS-54's, by a different instrument).

  python3 tools/fs66_b1_sets_check.py [SETS.json]
  python3 tools/fs66_b1_sets_check.py --self-test [--sets SETS.json]

The last line always begins with one of three words, and the exit status says the same thing:

    VERIFIED   0   every listed set is independent, of the claimed size, at the claimed prime
    REFUSED C  1   some listed set is not; C names which of the closed list of faults
    ERROR   C  2   this program could not do its job (CANNOT_READ, USAGE, SELF_CHECK_FAILED, INTERNAL)

Refusal codes: MALFORMED (shape, a missing key, an unknown top-level key, a point index out of
range, a coordinate out of range), BAD_PRIME (p not prime or not 3 mod 4), DUPLICATE_POINT,
INCONSISTENT_INDEX (the [a, b] pair and the point index a*p + b disagree -- the one convention
error this format can carry twice), WRONG_SIZE, NOT_INDEPENDENT (naming the two points and the
unit vector between them).
"""

import hashlib
import json
import os
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DEFAULT = os.path.join(REPO, 'data', 'fs66', 'b1', 'level-one-sets.json')
FORMAT = 'fs66-b1-level-one-sets-v1'
TOP_KEYS = ('format', 'what', 'licenses', 'sets')
TOP_OPTIONAL = ('provenance',)


class Refusal(Exception):
    def __init__(self, code, detail):
        super().__init__(f'{code}: {detail}')
        self.code, self.detail = code, detail


class Failure(Exception):
    def __init__(self, code, detail):
        super().__init__(f'{code}: {detail}')
        self.code, self.detail = code, detail


def is_prime(m):
    if m < 2:
        return False
    if m % 2 == 0:
        return m == 2
    d = 3
    while d * d <= m:
        if m % d == 0:
            return False
        d += 2
    return True


def need(obj, key, path):
    if not isinstance(obj, dict) or key not in obj:
        raise Refusal('MALFORMED', f'{path} has no "{key}" key.')
    return obj[key]


def circle(p):
    """the unit circle of F_p^2, rebuilt: the p + 1 points with a^2 + b^2 = 1."""
    S = [(a, b) for a in range(p) for b in range(p) if (a * a + b * b) % p == 1]
    if len(S) != p + 1:
        raise Failure('SELF_CHECK_FAILED',
                      f'the unit circle of F_{p}^2 came out with {len(S)} points, not p + 1 = {p + 1}; '
                      f'this program rebuilt it wrongly, which is never the file\'s fault.')
    return S


def check_set(entry, i, narrate):
    p = need(entry, 'p', f'sets[{i}]')
    if not isinstance(p, int) or isinstance(p, bool):
        raise Refusal('MALFORMED', f'sets[{i}]["p"] is not an integer.')
    if not is_prime(p):
        raise Refusal('BAD_PRIME', f'sets[{i}]["p"] is {p}, which is not prime. These planes are built '
                                   f'only for a prime p = 3 (mod 4).')
    if p % 4 != 3:
        raise Refusal('BAD_PRIME', f'sets[{i}]["p"] is {p} = {p % 4} (mod 4). For p = 1 (mod 4) the '
                                   f'circle x^2 + y^2 = 1 has p - 1 points and nothing here was '
                                   f'examined for that case.')
    size = need(entry, 'size', f'sets[{i}]')
    pts = need(entry, 'points', f'sets[{i}]')
    idxs = need(entry, 'point_indices', f'sets[{i}]')
    if not isinstance(pts, list) or not isinstance(idxs, list):
        raise Refusal('MALFORMED', f'sets[{i}]["points"] and ["point_indices"] must both be lists.')
    if len(pts) != len(idxs):
        raise Refusal('MALFORMED', f'sets[{i}] lists {len(pts)} coordinate pairs and {len(idxs)} point '
                                   f'indices; they are two spellings of one set and must agree in length.')
    if size != len(pts):
        raise Refusal('WRONG_SIZE', f'sets[{i}]["size"] is {size} but {len(pts)} points are listed. The '
                                    f'size is the claim; the points are the evidence.')

    coords = []
    for j, (pt, ix) in enumerate(zip(pts, idxs)):
        if not (isinstance(pt, list) and len(pt) == 2 and all(isinstance(v, int) and not isinstance(v, bool)
                                                              for v in pt)):
            raise Refusal('MALFORMED', f'sets[{i}]["points"][{j}] is not a pair of integers [a, b].')
        a, b = pt
        if not (0 <= a < p and 0 <= b < p):
            raise Refusal('MALFORMED', f'sets[{i}]["points"][{j}] is {pt}; a coordinate of F_{p}^2 lies '
                                       f'in [0, {p}).')
        if not isinstance(ix, int) or isinstance(ix, bool) or not 0 <= ix < p * p:
            raise Refusal('MALFORMED', f'sets[{i}]["point_indices"][{j}] is {ix}, not a point index in '
                                       f'[0, {p * p}).')
        if ix != a * p + b:
            raise Refusal('INCONSISTENT_INDEX',
                          f'sets[{i}] entry {j}: the pair {pt} numbers as a*p + b = {a * p + b}, but the '
                          f'index listed is {ix}. The numbering of this project is (a, b) -> a*p + b '
                          f'(plan §G); one of the two spellings was edited without the other.')
        coords.append((a, b))
    if len(set(coords)) != len(coords):
        dup = next(c for c in coords if coords.count(c) > 1)
        raise Refusal('DUPLICATE_POINT', f'sets[{i}] lists the point {list(dup)} more than once, so it '
                                         f'has fewer than {size} distinct points.')

    S = circle(p)
    inset = set(coords)
    pairs = 0
    for (a, b) in coords:
        for (u, v) in S:
            w = ((a + u) % p, (b + v) % p)
            pairs += 1
            if w in inset:
                raise Refusal('NOT_INDEPENDENT',
                              f'sets[{i}] is not independent in UD(F_{p}, 2): the points {[a, b]} and '
                              f'{list(w)} differ by the unit vector {list((u, v))}, and '
                              f'{u}^2 + {v}^2 = {(u * u + v * v) % p} (mod {p}).')
    narrate(f'  p = {p}: {size} points, all distinct, coordinates and indices agreeing; no two differ '
            f'by any of the {len(S)} unit vectors ({pairs} (point, unit vector) pairs tested)')
    return p, size


def check(path, narrate=lambda s: None):
    try:
        with open(path, 'rb') as f:
            raw = f.read()
    except OSError as ex:
        raise Failure('CANNOT_READ', f'{path}: {ex.strerror or ex}. The file this program is about is '
                                     f'{os.path.relpath(DEFAULT, REPO)}.')
    try:
        doc = json.loads(raw.decode('utf-8'))
    except (ValueError, UnicodeDecodeError) as ex:
        raise Failure('CANNOT_READ', f'{path} is not JSON text: {ex}')
    sha = hashlib.sha256(raw).hexdigest()
    narrate(f'file sha256 {sha}  ({path})')
    narrate(f'this program sha256 {hashlib.sha256(open(os.path.abspath(__file__), "rb").read()).hexdigest()}')
    if not isinstance(doc, dict):
        raise Refusal('MALFORMED', 'the file is not a JSON object.')
    for k in doc:
        if k not in TOP_KEYS and k not in TOP_OPTIONAL:
            raise Refusal('MALFORMED', f'unknown top-level key "{k}"; the keys of {FORMAT} are '
                                       f'{", ".join(TOP_KEYS)} (plus the ignored {", ".join(TOP_OPTIONAL)}). '
                                       f'An unknown key is refused rather than ignored, so a misspelt '
                                       f'field cannot read as an absent one.')
    if doc.get('format') != FORMAT:
        raise Refusal('MALFORMED', f'"format" is {doc.get("format")!r}, not "{FORMAT}".')
    sets = need(doc, 'sets', 'the file')
    if not isinstance(sets, list) or not sets:
        raise Refusal('MALFORMED', '"sets" must be a non-empty list.')
    out = []
    for i, entry in enumerate(sets):
        out.append(check_set(entry, i, narrate))
    return sha, out


def last_line(sha, out):
    bits = '; '.join(f'alpha(UD(F_{p}, 2)) >= {s}, hence alpha(UD(Z/{p}^k, 2)) >= {s}*{p * p}^(k-1) '
                     f'at every level k' for p, s in out)
    return (f'VERIFIED: {len(out)} explicit independent set(s), checked from the definition against a '
            f'rebuilt unit circle (file sha256 {sha[:12]}…). {bits}. This program is the standard '
            f'library only, and it is NOT the Lean kernel.')


# ----------------------------------------------------------------------------- controls

def self_test(path):
    """every plant on a COPY of a verifying file, each red for a named reason, the faithful twin green
    beside it, and the plant's digest compared with the twin's -- a plant that did not apply is
    invisible wherever the expected word is VERIFIED."""
    import copy
    import tempfile
    with open(path, 'rb') as f:
        original = f.read()
    orig_sha = hashlib.sha256(original).hexdigest()
    doc = json.loads(original.decode('utf-8'))
    rows, bad = [], []
    tmpdir = tempfile.mkdtemp(prefix='fs66-sets-selftest-')

    def run(d, label):
        p = os.path.join(tmpdir, label.replace(' ', '_').replace('/', '_') + '.json')
        blob = json.dumps(d, indent=1).encode('utf-8')
        with open(p, 'wb') as f:
            f.write(blob)
        try:
            sha, out = check(p)
            return 'VERIFIED', None, hashlib.sha256(blob).hexdigest()
        except Refusal as ex:
            return 'REFUSED', ex.code, hashlib.sha256(blob).hexdigest()
        except Failure as ex:
            return 'ERROR', ex.code, hashlib.sha256(blob).hexdigest()

    twin_word, twin_code, twin_sha = run(copy.deepcopy(doc), 'twin')
    rows.append(('twin (the same file re-serialised, no fault)', 'VERIFIED', None, twin_word, twin_code, True))

    def plant(label, mutate, word, code):
        d = copy.deepcopy(doc)
        mutate(d)
        w, c, sha = run(d, label)
        applied = sha != twin_sha
        rows.append((label, word, code, w, c, applied))

    p0 = doc["sets"][0]["p"]

    # The fault that matters most, planted ONCE PER UNIT VECTOR.  A single plant at one unit vector
    # cannot tell a program that tests all p + 1 of them from one that tests only that one: a copy of
    # this file whose independence loop was cut to S[:1] passed the single-plant version of this
    # self-test.  One plant per unit vector makes "all of them are tested" a reachable failure.
    def move_onto(k):
        def mutate(d):
            s = d['sets'][0]
            a, b = s['points'][0]
            u, v = circle(s['p'])[k]
            w = [(a + u) % s['p'], (b + v) % s['p']]
            s['points'][-1] = w
            s['point_indices'][-1] = w[0] * s['p'] + w[1]
        return mutate

    for k, (u, v) in enumerate(circle(p0)):
        plant(f'the last point moved onto unit vector {k + 1}/{p0 + 1} = [{u}, {v}] of the first point',
              move_onto(k), 'REFUSED', 'NOT_INDEPENDENT')
    plant('the claimed size raised by one, the points untouched',
          lambda d: d['sets'][0].__setitem__('size', d['sets'][0]['size'] + 1), 'REFUSED', 'WRONG_SIZE')
    plant('a point repeated (size still matches the list length)',
          lambda d: (d['sets'][0]['points'].__setitem__(-1, d['sets'][0]['points'][0]),
                     d['sets'][0]['point_indices'].__setitem__(-1, d['sets'][0]['point_indices'][0])),
          'REFUSED', 'DUPLICATE_POINT')
    plant('one index edited away from its coordinate pair',
          lambda d: d['sets'][0]['point_indices'].__setitem__(
              0, (d['sets'][0]['point_indices'][0] + 1) % (d['sets'][0]['p'] ** 2)),
          'REFUSED', 'INCONSISTENT_INDEX')
    plant('a coordinate out of range',
          lambda d: (d['sets'][0]['points'].__setitem__(0, [d['sets'][0]['p'], 0]),
                     d['sets'][0]['point_indices'].__setitem__(0, d['sets'][0]['p'] ** 2 - 1)),
          'REFUSED', 'MALFORMED')
    plant('p edited to a composite', lambda d: d['sets'][0].__setitem__('p', 9), 'REFUSED', 'BAD_PRIME')
    plant('p edited to a prime = 1 (mod 4)', lambda d: d['sets'][0].__setitem__('p', 13),
          'REFUSED', 'BAD_PRIME')
    plant('a top-level key misspelt', lambda d: d.__setitem__('setts', d.pop('sets')),
          'REFUSED', 'MALFORMED')
    plant('the deliberately EMPTY plant (nothing changed): the "did not apply" branch must be reachable',
          lambda d: None, 'VERIFIED', None)

    print(f'--- {len(rows)} controls on a copy of {os.path.relpath(path, REPO)} '
          f'(scratch: {tmpdir})', flush=True)
    for label, ew, ec, ow, oc, applied in rows:
        ok = (ew == ow and ec == oc)
        note = ''
        if label.startswith('the deliberately EMPTY'):
            ok = ok and not applied
            note = '  [digest equals the twin\'s, as an empty plant must]'
        elif ew == 'VERIFIED':
            ok = ok and applied
        elif not applied:
            ok, note = False, '  [PLANT DID NOT APPLY: its digest equals the twin\'s]'
        print(f'  [{"ok  " if ok else "FAIL"}] {label}\n'
              f'         expected {ew}{" " + ec if ec else ""} | observed {ow}{" " + oc if oc else ""}{note}',
              flush=True)
        if not ok:
            bad.append(label)

    with open(path, 'rb') as f:
        now = hashlib.sha256(f.read()).hexdigest()
    ok = now == orig_sha
    print(f'  [{"ok  " if ok else "FAIL"}] the file itself is untouched by this run\n'
          f'         expected sha256 {orig_sha[:16]}… | observed {now[:16]}…', flush=True)
    if not ok:
        bad.append('the file was modified')
    if bad:
        print(f'SELF-TEST FAILED: {bad[0]}')
        return 1
    print(f'SELF-TEST PASSED: {len(rows) + 1} of {len(rows) + 1} controls behaved as designed')
    return 0


def main():
    argv = sys.argv[1:]
    try:
        if argv and argv[0] == '--self-test':
            path = DEFAULT
            rest = argv[1:]
            if rest[:1] == ['--sets'] and len(rest) == 2:
                path = rest[1]
            elif rest:
                print(__doc__.strip())
                print('ERROR USAGE: --self-test takes only [--sets SETS.json].')
                return 2
            return self_test(path)
        if len(argv) > 1 or (argv and argv[0].startswith('-') and argv[0] not in ('-h', '--help')):
            print(__doc__.strip())
            print(f'ERROR USAGE: unexpected arguments {argv}.')
            return 2
        if argv[:1] in (['-h'], ['--help']):
            print(__doc__.strip())
            return 0
        path = argv[0] if argv else DEFAULT
        sha, out = check(path, narrate=lambda s: print(s, flush=True))
        print(last_line(sha, out))
        return 0
    except Refusal as ex:
        print(f'REFUSED {ex.code}: {ex.detail}')
        return 1
    except Failure as ex:
        print(f'ERROR {ex.code}: {ex.detail}')
        return 2
    except Exception as ex:                                    # never a traceback, never exit 1
        print(f'ERROR INTERNAL: {type(ex).__name__}: {ex}')
        return 2


if __name__ == '__main__':
    sys.exit(main())
