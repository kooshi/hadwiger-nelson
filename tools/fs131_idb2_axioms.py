#!/usr/bin/env python3
"""FS131-IDB2 — read `data/fs131/idb2/axioms.txt` (from `data/fs131/idb2/lean/AxiomsIDB2.lean`): every record of the job's
modules must rest on a subset of the standard three axioms, no record on `sorryAx` or on a native axiom; both planted
records must show what was planted (a `sorry` → `sorryAx`; a `native_decide` → an axiom whose name holds `native`), or
the reader fails as blind. A missing MODULE line, or a module with no record, fails. Exit 0 only when all hold.
Usage: tools/fs131_idb2_axioms.py data/fs131/idb2/axioms.txt [--allow-sorry-through NAME ...]
"""
import re
import sys
from collections import Counter

STD = {'propext', 'Classical.choice', 'Quot.sound'}
EXPECTED_MODULES = 4


def main(argv):
    path = argv[1]
    allow = set(argv[argv.index('--allow-sorry-through') + 1:]) if '--allow-sorry-through' in argv else set()
    mods, recs, plants = [], [], {}
    for ln in open(path):
        if ln.startswith('MODULE '):
            mods.append(ln.split()[1])
        elif ln.startswith('REC '):
            m = re.match(r'REC (\S+) (\S+) (\S+) \[(.*)\]$', ln.rstrip('\n'))
            axs = [a.strip() for a in m.group(4).split(',') if a.strip()]
            recs.append((m.group(1), m.group(2), m.group(3), axs))
        elif ln.startswith('PLANT '):
            m = re.match(r'PLANT (\S+) \[(.*)\]$', ln.rstrip('\n'))
            plants[m.group(1)] = [a.strip() for a in m.group(2).split(',') if a.strip()]
    bad = []
    if len(mods) != EXPECTED_MODULES:
        bad.append(f'{len(mods)} MODULE lines, expected {EXPECTED_MODULES}')
    per = Counter(r[0] for r in recs)
    for m in mods:
        if per[m] == 0:
            bad.append(f'module {m} has no record')
    kinds = Counter()
    for m, k, n, axs in recs:
        extra = set(axs) - STD
        if extra:
            bad.append(f'{n}: {sorted(extra)}')
        kinds['axiom-free' if not axs else ('standard' if set(axs) <= STD else 'other')] += 1
    ps = plants.get('FS131IDB2Plant.withSorry')
    pn = plants.get('FS131IDB2Plant.withNative')
    sorry_seen = ps is not None and 'sorryAx' in ps
    native_seen = pn is not None and any('native' in a for a in pn)
    if not sorry_seen:
        bad.append(f'BLIND: the planted sorry record shows {ps}')
    if not native_seen:
        bad.append(f'BLIND: the planted native_decide record shows {pn}')
    print(f'{len(mods)} modules, {len(recs)} records: {dict(kinds)}; by kind {dict(Counter(r[1] for r in recs))}')
    print(f'plant sorry -> {ps}; plant native -> {pn}')
    for b in bad:
        print('FAIL', b)
    print('PASS' if not bad else 'FAIL')
    return 0 if not bad else 1


if __name__ == '__main__':
    sys.exit(main(sys.argv))
