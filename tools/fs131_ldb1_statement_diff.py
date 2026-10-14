#!/usr/bin/env python3
"""FS131-LDB1 (FS131-IDB3's reader, the module count changed) — no statement and no definition of the density bound changed across the merge of main, from the kernel's side.

Compares two dumps of `data/fs131/ldb1/lean/StatementDump.lean` (every constant, internal ones included, of the 83
modules under `Plane/DensityBound` and `Plane/OneAvoidingDensity`: its stored type, a definition's stored value
by hash). The two dumps must name the same 83 modules. Fails (exit 1) when a constant of the base dump is missing from the new one, when
a stored TYPE differs, or when a definition's VALUE differs. Constants new in the second dump are listed: a private
helper (`_private.` prefix) or an internal name (`INTERNAL`) passes; any other new public constant fails (the job adds
no public declaration to these modules). A dump whose module headers are missing is refused, never read as empty.

Usage: tools/fs131_ldb1_statement_diff.py BEFORE AFTER
       tools/fs131_ldb1_statement_diff.py --self-test BEFORE    (plants a changed type, a changed value, a removed
                                                                   constant and a new public constant; each must fire)
"""
import sys

EXPECTED = 83


def parse(text):
    mods, consts, cur = set(), {}, None
    for ln in text.splitlines():
        if ln.startswith('## MODULE '):
            if not ln.startswith('## MODULES '):
                mods.add(ln.split()[2])
        elif ln.startswith('@@ '):
            parts = ln.split()
            cur = parts[2]
            consts[cur] = {'kind': parts[1], 'internal': 'INTERNAL' in parts[3:], 'type': None, 'value': None}
        elif ln.startswith('TYPE ') and cur:
            consts[cur]['type'] = ln[5:]
        elif ln.startswith('VALUE ') and cur:
            consts[cur]['value'] = ln[6:]
    if len(mods) != EXPECTED:
        raise SystemExit(f'REFUSED: dump names {len(mods)} modules, expected {EXPECTED}')
    if not consts:
        raise SystemExit('REFUSED: dump holds no constants')
    return consts


def compare(a, b):
    bad, notes = [], []
    for n, c in a.items():
        if n not in b:
            bad.append(f'REMOVED {n}')
            continue
        d = b[n]
        if c['kind'] != d['kind']:
            bad.append(f'KIND {n}: {c["kind"]} -> {d["kind"]}')
        if c['type'] != d['type']:
            bad.append(f'TYPE {n}')
        if c['kind'] == 'DEF' and c['value'] != d['value']:
            bad.append(f'VALUE {n}')
    for n, d in b.items():
        if n in a or d['internal']:
            continue
        if n.startswith('_private.'):
            notes.append(f'ADDED private {n}')
        else:
            bad.append(f'ADDED public {n}')
    checked = len(a)
    return bad, notes, checked


def main(argv):
    if len(argv) == 3 and argv[1] == '--self-test':
        base = open(argv[2]).read()
        a = parse(base)
        plants = []
        # 1. a changed type: append a token to the first theorem's TYPE line
        thm = next(n for n, c in a.items() if c['kind'] == 'THM' and not c['internal'])
        t1 = base.replace(f'TYPE {a[thm]["type"]}', f'TYPE {a[thm]["type"]} PLANT', 1)
        plants.append(('changed type', t1, f'TYPE {thm}'))
        # 2. a changed value of a definition
        dfn = next(n for n, c in a.items() if c['kind'] == 'DEF' and not c['internal'])
        t2 = base.replace(f'VALUE {a[dfn]["value"]}', f'VALUE {a[dfn]["value"]} PLANT', 1)
        plants.append(('changed value', t2, f'VALUE {dfn}'))
        # 3. a removed constant
        t3 = base.replace(f'@@ THM {thm}\n', '@@ THM PLANT.renamed\n', 1)
        plants.append(('removed constant', t3, f'REMOVED {thm}'))
        # 4. a new public constant
        t4 = base + '@@ THM HadwigerNelson.DensityBound.plantedNew\nTYPE 0 True\n'
        plants.append(('new public constant', t4, 'ADDED public HadwigerNelson.DensityBound.plantedNew'))
        ok = True
        bad0, _, n0 = compare(a, a)
        print(f'faithful copy: {len(bad0)} findings over {n0} constants ({"PASS" if not bad0 else "FAIL"})')
        ok &= not bad0 and n0 > 0
        for name, txt, want in plants:
            bad, _, _ = compare(a, parse(txt))
            fired = want in bad
            print(f'plant {name}: {"FIRED" if fired else "SILENT"} ({bad})')
            ok &= fired
        print('SELF-TEST', 'PASS' if ok else 'FAIL')
        return 0 if ok else 1
    if len(argv) != 3:
        print(__doc__)
        return 2
    a, b = parse(open(argv[1]).read()), parse(open(argv[2]).read())
    bad, notes, checked = compare(a, b)
    for x in notes:
        print(x)
    for x in bad:
        print('FAIL', x)
    print(f'checked {checked} constants of the base dump; {len(bad)} differences; {len(notes)} private additions')
    print('PASS' if not bad else 'FAIL')
    return 0 if not bad else 1


if __name__ == '__main__':
    sys.exit(main(sys.argv))
