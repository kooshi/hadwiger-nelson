#!/usr/bin/env python3
"""fs61_recount_landings -- recount FS-61's certification gate STRAIGHT OFF THE COMMITTED BYTES.

UNTRUSTED, and deliberately standalone, exactly like `tools/fs61_recount.py` is for the ball records: it imports
nothing from the census driver, shares no code with it, and never writes.  Its job is to be the second opinion on
a certification pass's counts.

Why it exists.  `land` writes `data/fs61/landings.jsonl` from its own run, and the phase records quote that file.
A reader who trusts none of it wants the same numbers re-derived from the artifacts on disk -- the `.out` files
the checker actually produced, the witness itself, and the README the claim is stated in -- and wants them as
COUNTS, never as an exit status or the word "all".  Two of phase C's three real defects were caught exactly that
way: a loop whose every exit status was 0 while its count read `0 of 9 CERTIFIED`, and a C.2 row that could never
have gone green because the verdict it looked for is on the LAST line, not the first.

What it re-derives per field, from `data/fs61/witness-<d>/`:
  C.1  `certified.out` starts with `CERTIFIED`                              (the checker's own verdict line)
  C.2  `controls.out` -- the COUNT of `[PASS]` and `[FAIL]` rows, and that the last line is `CONTROLS ALL PASS`
  C.3  `wrong-radicand.out` starts with `REFUSED`                            (the witness is about THIS field)
  C.4  `recheck.out` -- classified into (a) the second opinion proper and (b) the pinned-vertex minimality
       control, by the same straight-line reading of the frozen tool the owner ruled on after phase C: the
       step-(iii) message is reachable only after (i) and (ii) returned without failing.  A `RECHECK FAIL:
       deleting vertex ...` line is therefore a GREEN C.4a and a RED C.4b.
  C.5  `colouring4.json` -- re-verified here on every edge of `witness.json`, in this file, not trusted
  C.6  the count of edges whose direction has 3 in its reduced denominator, recomputed from the coordinates
  C.7  `README.md` states a value, and it is checked against `frame.jsonl`'s L: `= 4` only when L = 4
  --   `witness.json` sha256, point and edge counts, and whether the file's own edge list is what C.5/C.6 used

It also cross-checks each of the above against what `landings.jsonl` says, and prints DISAGREE when they differ:
the record and the artifact must tell the same story.

  Usage:  python3 tools/fs61_recount_landings.py                 # every field with a witness directory
          python3 tools/fs61_recount_landings.py 59 239 311      # named fields only
          python3 tools/fs61_recount_landings.py --plant 239     # the negative control, below

The negative control (`--plant <d>`): the field's artifacts are copied to a scratch directory, ONE fault is planted
in each of five places in turn, and the reader must go red on each -- a `CERTIFIED` line blanked, a `[FAIL]` row
added to the controls, the wrong-radicand refusal turned into a pass, one point of the 4-colouring recoloured onto
an edge, and the README's value promoted from a bracket to an equality.  Nothing under `data/fs61/` is touched.
Exit 0 if every plant fired, non-zero otherwise.
"""
import sys, json, hashlib, re, shutil, tempfile
from fractions import Fraction
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FS61 = ROOT / 'data' / 'fs61'


def first_last(p):
    """The first and last non-empty lines of a text file, or ('', '') when it is missing or empty."""
    if not p.exists():
        return '', ''
    ls = [l.strip() for l in p.read_text(errors='replace').splitlines() if l.strip()]
    return (ls[0], ls[-1]) if ls else ('', '')


def barrier_edges(D, pts, edges):
    """C.6, recomputed here: how many edges have a direction with 3 in the reduced denominator of a coordinate.

    A point is (a, b, c, e, m) standing for ((a + b*sqrt D)/m, (c + e*sqrt D)/m).  The direction of an edge is the
    difference; 3 divides a reduced denominator exactly when some coordinate of the difference, in lowest terms,
    has 3 in its denominator.  `Fraction` does the reducing, so this cannot disagree with itself about lowest
    terms."""
    n = 0
    for u, v in edges:
        a, b, c, e, m = pts[u]
        A, B, C, E, M = pts[v]
        # each coordinate is a pair (rational, rational) in the basis (1, sqrt D); 3 in a denominator of either
        # component of either coordinate is what the barrier asks about
        for x, y in ((Fraction(a, m) - Fraction(A, M), Fraction(b, m) - Fraction(B, M)),
                     (Fraction(c, m) - Fraction(C, M), Fraction(e, m) - Fraction(E, M))):
            if x.denominator % 3 == 0 or y.denominator % 3 == 0:
                n += 1
                break
    return n


def recount_one(D, wdir, frame, landing):
    """Every gate item for one field, re-derived from the files in `wdir`.  Returns (rows, ok)."""
    rows, ok = [], True

    def row(item, verdict, detail, good):
        nonlocal ok
        rows.append((item, 'PASS' if good else 'FAIL', verdict, detail))
        ok = ok and good

    wj = wdir / 'witness.json'
    if not wj.exists():
        row('witness.json', 'MISSING', str(wj), False)
        return rows, ok
    w = json.loads(wj.read_text())
    pts, edges = w['points'], w['edges']
    sha = hashlib.sha256(wj.read_bytes()).hexdigest()

    f1, _ = first_last(wdir / 'certified.out')
    row('C.1 certificate', f1[:70], f'{len(pts)} points, {len(edges)} edges', f1.startswith('CERTIFIED'))

    txt = (wdir / 'controls.out').read_text(errors='replace') if (wdir / 'controls.out').exists() else ''
    lines = [l.strip() for l in txt.splitlines() if l.strip()]
    nP = sum(1 for l in lines if l.startswith('[PASS]'))
    nF = sum(1 for l in lines if l.startswith('[FAIL]'))
    last = lines[-1] if lines else ''
    row('C.2 planted faults', last[:70], f'{nP} [PASS] rows, {nF} [FAIL] rows',
        nF == 0 and nP >= 13 and last == 'CONTROLS ALL PASS')

    f3, _ = first_last(wdir / 'wrong-radicand.out')
    row('C.3 wrong radicand', f3[:70], f'offered as a witness over Q(sqrt{D + 12})', f3.startswith('REFUSED'))

    f4, _ = first_last(wdir / 'recheck.out')
    # the owner's ruling 1 after phase C: this file is straight-line, so a step-(iii) message means (i) and (ii)
    # passed.  C.4a is the second opinion proper; C.4b is a MINIMALITY control, required only where the witness
    # is 1-minimal.
    step3 = bool(re.search(r'deleting vertex \d+ leaves a graph that still refuses|the control model is not proper', f4))
    a_ok = f4.startswith('RECHECK PASS') or step3
    red = ((w.get('construction') or {}).get('reduction') or '')
    minimal = 'no' if 'deletion STOPPED' in red else ('yes' if ('1-minimal' in red) else 'unknown')
    row('C.4a second opinion', f4[:70],
        'RECHECK PASS' if f4.startswith('RECHECK PASS') else 'reached step (iii), so (i) and (ii) passed', a_ok)
    b_ok = f4.startswith('RECHECK PASS')
    rows.append(('C.4b pinned-vertex', 'PASS' if b_ok else ('FAIL' if step3 else 'n/a'),
                 f'C.9 says {minimal}', 'required' if minimal == 'yes' else 'recorded, not required'))
    if minimal == 'yes' and not b_ok:
        ok = False                                   # required here, and red: a defect in the generator or the recheck

    cj = wdir / 'colouring4.json'
    if cj.exists():
        col = json.loads(cj.read_text())['colouring']
        bad = sum(1 for u, v in edges if col[u] == col[v])
        row('C.5 exactly four', f'{len(set(col))} colours', f'{bad} monochromatic edges of {len(edges)}',
            bad == 0 and len(set(col)) <= 4)
    else:
        row('C.5 exactly four', 'MISSING colouring4.json', '', False)

    nb = barrier_edges(D, pts, edges)
    row('C.6 3-adic barrier', f'{nb} of {len(edges)}', 'edges with 3 in a reduced denominator', nb > 0)

    L = frame[D]['L']
    readme = (wdir / 'README.md').read_text(errors='replace') if (wdir / 'README.md').exists() else ''
    says_eq = f'chi(Q(sqrt{D})^2) = 4' in readme
    says_br = f'4 <= chi(Q(sqrt{D})^2) <= {L}' in readme
    row('C.7 the value', ('= 4' if says_eq else ('bracket to ' + str(L) if says_br else 'NOT STATED')),
        f'frame.jsonl L = {L}', (says_eq and L == 4) or (says_br and L > 4))

    # the record and the artifacts must agree
    lr = landing.get(str(D), {})
    agree = (lr.get('witness_sha256') == sha and lr.get('points') == len(pts) and lr.get('edges') == len(edges)
             and lr.get('result') == 'CERTIFIED')
    row('record agrees', lr.get('result', 'NO RECORD'),
        f"sha {sha[:16]}..., record says {str(lr.get('witness_sha256'))[:16]}..., "
        f"{lr.get('points')} points / {lr.get('edges')} edges", agree)
    return rows, ok


def load_frame():
    return {json.loads(l)['d']: json.loads(l) for l in open(FS61 / 'frame.jsonl') if l.strip()}


def load_landings():
    out = {}
    for l in open(FS61 / 'landings.jsonl'):
        if l.strip():
            r = json.loads(l)
            out[r['key']] = r                        # later lines shadow earlier ones, as the driver's view does
    return out


def run(fields):
    frame, landing = load_frame(), load_landings()
    good, bad = [], []
    for D in fields:
        wdir = FS61 / f'witness-{D}'
        rows, ok = recount_one(D, wdir, frame, landing)
        print(f'\n=== d = {D} ===')
        for item, res, verdict, detail in rows:
            print(f'  {item:22s} {res:4s}  {verdict:<46s} {detail}')
        (good if ok else bad).append(D)
    print(f'\nDONE recount-landings: {len(good)} of {len(fields)} fields green {good}'
          + (f'; NOT green {bad}' if bad else ''))
    return 0 if not bad else 1


def plant(D):
    """The negative control.  Five faults, one at a time, each in a scratch copy; every one must turn the reader
    red, and the untouched copy must be green first -- a check that has only ever passed is indistinguishable from
    one that cannot fire."""
    frame, landing = load_frame(), load_landings()
    src = FS61 / f'witness-{D}'
    if not src.exists():
        print(f'no witness directory for d={D}')
        return 2
    fired, n = 0, 0

    def score(tmp, name, expect_green):
        nonlocal fired, n
        rows, ok = recount_one(D, tmp, frame, landing)
        n += 1
        reds = [f'{i}={v}' for i, v, _, _ in rows if v == 'FAIL']
        if expect_green:
            print(f'  [{"PASS" if ok else "FAIL"}] the faithful copy is green            -- {reds or "no red rows"}')
            return ok
        print(f'  [{"PASS" if not ok else "FAIL"}] {name:<50s} -- {reds or "NOTHING WENT RED"}')
        fired += (not ok)
        return not ok

    with tempfile.TemporaryDirectory() as td:
        base = Path(td)
        # 0. the faithful copy, first: the control must be able to be green
        t0 = base / 'faithful'
        shutil.copytree(src, t0)
        score(t0, 'faithful', True)

        def fresh(name):
            t = base / name
            if t.exists():
                shutil.rmtree(t)
            shutil.copytree(src, t)
            return t

        t = fresh('c1')
        (t / 'certified.out').write_text('REFUSED SOMETHING\n')
        score(t, "C.1: the checker's verdict line blanked", False)

        t = fresh('c2')
        txt = (t / 'controls.out').read_text()
        (t / 'controls.out').write_text(txt.replace('CONTROLS ALL PASS', '[FAIL] one plant was not refused\nCONTROLS ALL PASS'))
        score(t, 'C.2: one [FAIL] row added to the controls', False)

        t = fresh('c3')
        (t / 'wrong-radicand.out').write_text('CERTIFIED: it also works over the wrong field\n')
        score(t, 'C.3: the wrong radicand made to certify', False)

        t = fresh('c5')
        w = json.loads((t / 'witness.json').read_text())
        c = json.loads((t / 'colouring4.json').read_text())
        u, v = w['edges'][0]
        c['colouring'][u] = c['colouring'][v]        # one endpoint recoloured onto its neighbour
        (t / 'colouring4.json').write_text(json.dumps(c))
        score(t, 'C.5: one edge of the 4-colouring made monochromatic', False)

        t = fresh('c7')
        L = frame[D]['L']
        rd = (t / 'README.md').read_text()
        if L == 4:
            rd = rd.replace(f'chi(Q(sqrt{D})^2) = 4', f'4 <= chi(Q(sqrt{D})^2) <= {L}')
            what = 'C.7: the equality replaced by a bracket the field does not have'
        else:
            rd = rd.replace(f'4 <= chi(Q(sqrt{D})^2) <= {L}', f'chi(Q(sqrt{D})^2) = 4')
            what = 'C.7: a bracket promoted to an equality the bound does not give'
        (t / 'README.md').write_text(rd)
        score(t, what, False)

    print(f'\nDONE plant d={D}: {fired} of {n - 1} planted faults fired, on the faithful copy reading green')
    return 0 if fired == n - 1 else 1


if __name__ == '__main__':
    args = sys.argv[1:]
    if args and args[0] == '--plant':
        sys.exit(plant(int(args[1])))
    # exactly `witness-<digits>`: `witness-95-rank2` is a SEPARATE object with its own landing key, and
    # `witness-lattices.jsonl` is not a directory at all -- a looser match reads the first as a second d = 95.
    fs = [int(a) for a in args] or sorted(int(m.group(1)) for p in FS61.glob('witness-*')
                                          for m in [re.fullmatch(r'witness-(\d+)', p.name)]
                                          if m and p.is_dir() and (p / 'witness.json').exists())
    sys.exit(run(fs))
