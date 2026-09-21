#!/usr/bin/env python3
"""fs66_mutation_audit -- break the checker on purpose and watch its controls go red (FS-66).

`tools/fs66_check_witness.py --controls` plants faults in the WITNESS and asserts the checker refuses each one.
That tests the checker. It does not test the controls: a control row whose failure mode is unreachable passes
exactly like one that works (CLAUDE.md, "Make the gate fail, and watch it fail"). So this tool plants faults in
the CHECKER ITSELF -- one load-bearing test removed at a time, in a COPY, never in the committed file -- and
asserts that the control rows which exist to catch that test do in fact turn red.

Each mutation names the rows that MUST go red. A mutation that changes nothing, or that leaves its rows green,
is reported as a failure of this audit. One entry names NO rows: it removes a test that another test is
deliberately redundant with, and its controls must therefore stay green -- the redundancy is the claim. Rows that go red beyond the named ones are listed, not failed: removing
the CNF order, for instance, legitimately also breaks the faithful twin.

Nothing is edited in place: the checker, `fs66_tower.py` and `coloring.py` are copied into a temporary
directory, the copy is mutated, and the copy is run. The committed files are re-verified at the end.

usage: fs66_mutation_audit.py WITNESS.json [PROOF.lrat.gz]
"""
import hashlib
import os
import shutil
import subprocess
import sys
import tempfile

TOOLS = os.path.dirname(os.path.abspath(__file__))

# (name, what is removed, the exact source text, its replacement, the control rows that must go red)
MUTATIONS = [
    ('CNF-ORDER', 'the pin clauses are emitted BEFORE the edge clauses, so the formula is not Lean\'s',
     """    for i, j in E:
        for c in range(k):
            cl.append((-x(i, c), -x(j, c)))
    for c, v in enumerate(pin):
        cl.append((x(v, c),))""",
     """    for c, v in enumerate(pin):
        cl.append((x(v, c),))
    for i, j in E:
        for c in range(k):
            cl.append((-x(i, c), -x(j, c)))""",
     ['second CNF builder', 'faithful twin']),
    ('UNIT-PAIR-ONE', 'the per-edge re-verification is skipped -- BUT the circle walk still catches it, '
     'which is the point: the two adjacency routes are redundant on purpose',
     '        if q != one:', '        if False:', []),
    ('UNIT-PAIR-BOTH', 'both routes to adjacency are skipped: the per-edge test AND the circle walk that '
     'cross-checks it',
     '        if q != one:', '        if False:',
     ['a point moved', 'the modulus doubled'],
     '''    missing = sorted(set(E) - induced)
    if missing:''', '''    missing = sorted(set(E) - induced)
    if False:'''),
    ('DUPLICATE-POINT', 'the "no point twice" test is skipped',
     '        if p in seen:', '        if False:',
     ['a point listed twice']),
    ('POINT-RANGE', 'the "every coordinate is in [0, n)" test is skipped',
     '        if not (0 <= p[0] < n and 0 <= p[1] < n):', '        if False:',
     ['a point outside the ring']),
    ('PIN-CLIQUE', 'the "the pin is a triangle OF THE LISTED GRAPH" test is skipped',
     '            if (i, j) not in ES:', '            if False:',
     ['the pin moved to a non-triangle', 'the pinned edge']),
    ('EDGE-ORDER', 'the "the edge list is sorted and repeats nothing" test is skipped',
     '        if E and (i, j) <= E[-1]:', '        if False:',
     ['the edge list reversed', 'listed twice']),
    ('RUP-CONFLICT', 'an added clause no longer has to propagate to a conflict',
     '                if not conflict:', '                if False:',
     ["a derivation's last hint dropped"]),
    ('FRESH-ID', 'a proof may reuse a clause id the formula already has',
     '            if cid <= last_id:', '            if False:',
     ['re-adds clause id 1']),
]


def rows_of(output):
    """the control rows, as (label, ok) pairs -- read from the output the checker actually printed."""
    out = []
    for line in output.splitlines():
        s = line.strip()
        if s.startswith('[ok  ]'):
            out.append((s[6:].strip(), True))
        elif s.startswith('[FAIL]'):
            out.append((s[6:].strip(), False))
    return out


def run_controls(tools_dir, witness, proof):
    r = subprocess.run([sys.executable, os.path.join(tools_dir, 'fs66_check_witness.py'), '--controls',
                        witness, proof], capture_output=True, text=True)
    return r.returncode, r.stdout + r.stderr


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 2
    witness = os.path.abspath(sys.argv[1])
    proof = os.path.abspath(sys.argv[2]) if len(sys.argv) > 2 else os.path.join(
        os.path.dirname(witness), 'witness.lrat.gz')
    src = open(os.path.join(TOOLS, 'fs66_check_witness.py')).read()
    print(f'checker sha256 {hashlib.sha256(src.encode()).hexdigest()}')
    print(f'witness {witness}\nproof   {proof}\n')

    rc, out = run_controls(TOOLS, witness, proof)
    base = rows_of(out)
    green = [lbl for lbl, ok in base if ok]
    print(f'baseline: the committed checker\'s controls -> exit {rc}, {len(green)} of {len(base)} rows green')
    if rc != 0 or len(green) != len(base):
        print('the baseline is not clean; a mutation audit over it would mean nothing')
        return 1

    fails = 0
    for entry in MUTATIONS:
        name, what, find, repl, must_redden = entry[:5]
        pairs = [(find, repl)] + [(entry[i], entry[i + 1]) for i in range(5, len(entry), 2)]
        if any(src.count(f) != 1 for f, _ in pairs):
            print(f'[FAIL] {name}: a text to mutate occurs {[src.count(f) for f, _ in pairs]} times, '
                  f'not once each -- this audit is out of step with the checker')
            fails += 1
            continue
        tmp = tempfile.mkdtemp(prefix=f'fs66-mut-{name.lower()}-')
        for f in ('fs66_check_witness.py', 'fs66_tower.py', 'coloring.py'):
            shutil.copy(os.path.join(TOOLS, f), tmp)
        p = os.path.join(tmp, 'fs66_check_witness.py')
        mutated = src
        for f_, r_ in pairs:
            mutated = mutated.replace(f_, r_)
        with open(p, 'w') as f:
            f.write(mutated)
        changed = open(p).read() != src
        rc, out = run_controls(tmp, witness, proof)
        red = [lbl for lbl, ok in rows_of(out) if not ok]
        hit = [m for m in must_redden if any(m in lbl for lbl in red)]
        extra = [lbl for lbl in red if not any(m in lbl for m in must_redden)]
        ok = changed and len(hit) == len(must_redden) and (rc != 0 if must_redden else rc == 0)
        fails += not ok
        print(f'[{"ok  " if ok else "FAIL"}] {name}: {what}')
        print(f'         must redden: {must_redden}')
        print(f'         reddened   : {red if red else "nothing"}'
              + ('' if must_redden or red else ' (as expected: another test still catches every plant)'))
        if extra:
            print(f'         also red (allowed): {[e[:70] for e in extra]}')
        shutil.rmtree(tmp)

    rc, out = run_controls(TOOLS, witness, proof)
    after = rows_of(out)
    ok = rc == 0 and all(o for _, o in after) and len(after) == len(base)
    fails += not ok
    print(f'[{"ok  " if ok else "FAIL"}] the committed checker afterwards: exit {rc}, '
          f'{sum(o for _, o in after)} of {len(after)} rows green (nothing was edited in place)')
    print(f'MUTATION AUDIT: {len(MUTATIONS) + 2 - fails} of {len(MUTATIONS) + 2} behaved')
    print('ALL MUTATIONS SEEN RED' if fails == 0 else f'{fails} DID NOT')
    return 1 if fails else 0


if __name__ == '__main__':
    sys.exit(main())
