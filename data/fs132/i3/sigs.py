#!/usr/bin/env python3
"""FS132-I3: every leaf of the two modules as the kernel holds it now, against the planner's print of the skeleton.

Reads the planner's `data/fs132/k2/probe/Sigs.out` (`#check @leaf` of each leaf at the skeleton, commit e0c95ec1) and a
print of the same sixteen names made now by `data/fs132/i3/probe/SigsNow.lean`; splits each into records (a record
opens at column 0 with `name :` or `@name :`), and compares the sixteen record by record, whitespace normalized. (The seventeenth theorem of the two
modules, `shift_zero_left`, was proved in the skeleton and is not in the planner's print.)
Expected: fourteen identical, two changed — the two hypotheses dropped by the planner's permission (1).
Exit 0 iff the set of changed leaves is exactly EXPECTED_CHANGED and none is missing.
--fault: compares after deleting one hypothesis from one record of the new print; must exit 1 and name the leaf."""
import re, sys, pathlib
HERE = pathlib.Path(__file__).resolve().parent
ROOT = HERE.parents[2]
MINE = ['step_lemma', 'exists_step_or_density_triple', 'exists_window', 'exists_shiftMap', 'exists_density_pair',
        'volume_pattern_pos', 'step_at_of_change', 'volume_change_pairs_pos',
        'ringRadius_mem', 'shift_comm', 'shift_zero_right', 'dist_chart_chart_shift', 'shift_pos',
        'exists_shift_lipschitz', 'measurable_shift', 'exists_shiftBounds']
EXPECTED_CHANGED = {'exists_shiftMap', 'volume_change_pairs_pos'}
def records(text):
    recs, cur = {}, None
    for line in text.split('\n'):
        m = re.match(r'^@?([A-Za-z_][\w.\']*) :', line)
        if m:
            cur = m.group(1); recs[cur] = [re.sub(r'^@', '', line)]
        elif line[:1] in (' ', '\t') and cur:
            recs[cur].append(line)
        else:
            cur = None
    return {k: re.sub(r'\s+', ' ', ' '.join(v)).strip() for k, v in recs.items()}
then = records((ROOT / 'data/fs132/k2/probe/Sigs.out').read_text())
now = records((HERE / 'logs/sigs-now.out').read_text())
if '--fault' in sys.argv:
    assert '0 < κ → ' in now['step_lemma']
    now['step_lemma'] = now['step_lemma'].replace('0 < κ → ', '', 1)
missing = [n for n in MINE if n not in then or n not in now]
changed = {n for n in MINE if n not in missing and then[n] != now[n]}
for n in MINE:
    tag = 'MISSING' if n in missing else ('CHANGED' if n in changed else 'same')
    print(f'{tag:8s} {n}')
    if n in changed:
        print('   then:', then[n]); print('   now: ', now[n])
ok = not missing and changed == EXPECTED_CHANGED
print(f'leaves={len(MINE)} same={len(MINE) - len(changed) - len(missing)} changed={len(changed)} missing={len(missing)} '
      f'expected-changed={sorted(EXPECTED_CHANGED)} verdict={"OK" if ok else "FAIL"}')
sys.exit(0 if ok else 1)
