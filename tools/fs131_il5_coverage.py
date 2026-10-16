#!/usr/bin/env python3
"""FS131-IL5: every constant the compiled `Rigidity/MainClauseFive` declares has a `#print axioms` line in
`scripts/Axioms.lean`, under the section its printed axioms put it in (IMPORTED when the print names a declared import,
CLEAN when it names only the standard three).

Inputs: the kernel's print of the module (`data/fs131/il5/print-new.log`, from `data/fs131/il5/lean/PrintNew.lean`: the
module's constant list and each record's `#print axioms`) and `scripts/Axioms.lean`.

`--plant` adds one constant the audit does not file to the module's list, and the check must report it missing and exit 1;
`--plant-misfile` reads the model `localBound_bot_le_two` (standard three) as filed under IMPORTED, and the check must
report the section and exit 1; the run without either must exit 0. Each plant is read through the same path as real
data."""
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
PRINT = REPO / 'data/fs131/il5/print-new.log'
AUDIT = REPO / 'scripts/Axioms.lean'
STD = {'propext', 'Classical.choice', 'Quot.sound'}
PLANTED = 'HadwigerNelson.Rigidity.planted_not_filed'


def module_constants(text):
    m = re.search(r'^constants declared by the module: (\d+)\n((?:  \S+\n)*)', text, re.M)
    if not m:
        sys.exit('FAIL: the print holds no constant list; the probe did not run to its end')
    names = [ln.strip() for ln in m.group(2).splitlines()]
    if len(names) != int(m.group(1)):
        sys.exit(f'FAIL: the print announces {m.group(1)} constants and lists {len(names)}')
    return names


def printed_axioms(text):
    out = {}
    for m in re.finditer(r"^'([^']+)' depends on axioms: \[([^\]]*)\]", text, re.M):
        out[m.group(1)] = {a.strip() for a in m.group(2).split(',') if a.strip()}
    return out


def audit_sections(text):
    """Each `#print axioms <name>` line of the audit, with the banner it sits under."""
    sec, where = None, {}
    for ln in text.splitlines():
        b = re.match(r'#eval IO\.println "=== (\w+) ==="', ln)
        if b:
            sec = b.group(1)
            continue
        p = re.match(r'#print axioms (\S+)\s*$', ln)
        if p:
            where.setdefault(p.group(1), []).append(sec)
    return where


def main():
    plant = '--plant' in sys.argv[1:]
    misfile = '--plant-misfile' in sys.argv[1:]
    text = PRINT.read_text()
    names = module_constants(text)
    if plant:
        names.append(PLANTED)
    axioms = printed_axioms(text)
    where = audit_sections(AUDIT.read_text())
    if misfile:
        where['HadwigerNelson.Rigidity.localBound_bot_le_two'] = ['IMPORTED']
    bad = 0
    for n in names:
        secs = where.get(n, [])
        if len(secs) != 1:
            print(f'FAIL {n}: filed {len(secs)} times in scripts/Axioms.lean ({secs})')
            bad += 1
            continue
        ax = axioms.get(n)
        if ax is None:
            print(f'FAIL {n}: the print holds no axiom list for it')
            bad += 1
            continue
        want = 'CLEAN' if ax <= STD else 'IMPORTED'
        if secs[0] != want:
            print(f'FAIL {n}: filed under {secs[0]}, its axioms {sorted(ax)} put it under {want}')
            bad += 1
            continue
        print(f'ok   {n}: under {secs[0]}, axioms {sorted(ax)}')
    print(f'==> {len(names)} constant(s), {bad} not filed as their axioms require' + (' (planted run)' if plant or misfile else ''))
    sys.exit(1 if bad else 0)


if __name__ == '__main__':
    main()
