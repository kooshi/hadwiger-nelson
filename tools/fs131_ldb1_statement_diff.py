#!/usr/bin/env python3
"""FS131-LDB1 (FS131-IDB3's reader, the module count changed) — no statement and no definition of the density bound changed across the merge of main, from the kernel's side.

Compares two dumps of `data/fs131/ldb1/lean/StatementDump.lean` (every constant, internal ones included, of the 83
modules under `Plane/DensityBound` and `Plane/OneAvoidingDensity`: its stored type, a definition's stored value
by hash). The two dumps must name the same 83 modules. Fails (exit 1) when a constant of the base dump is missing from the new one, when
a stored TYPE differs, or when a definition's VALUE differs. Constants new in the second dump are listed: a private
helper (`_private.` prefix) or an internal name (`INTERNAL`) passes; any other new public constant fails (the job adds
no public declaration to these modules). A dump whose module headers are missing is refused, never read as empty.

The coordinator's ruling at this landing (the brief's Amendment, 2026-10-14 19:56 UTC) is read with two flags, and
without them the comparison fails on exactly what the ruling changed:
  --redefined=NAME:MODULE   NAME left the 83 modules (absent from their constants in AFTER) and is the constant AFTER's
                            `## BYNAME` section finds in MODULE, its stored TYPE identical to BEFORE's and its VALUE
                            another (a definition of `main`'s read in place of this line's): `REDEFINED`
  --added=NAME[,NAME]       public constants the ruling adds: `ADDED-RULED`

Usage: tools/fs131_ldb1_statement_diff.py BEFORE AFTER [--redefined=NAME:MODULE] [--added=NAME,…]
       tools/fs131_ldb1_statement_diff.py --self-test BEFORE    (plants a changed type, a changed value, a removed
                                                                   constant and a new public constant; each must fire)
"""
import sys

EXPECTED = 83


def parse(text, byname=None):
    mods, consts, cur = set(), {}, None
    for ln in text.splitlines():
        if ln.startswith('## BYNAME '):
            parts = ln.split()
            if byname is not None:
                byname[parts[2]] = {'absent': parts[3] == 'ABSENT', 'module': parts[3][len('module='):] if parts[3].startswith('module=') else None,
                                    'type': None, 'value': None}
            cur = ('BYNAME', parts[2])
        elif ln.startswith('## MODULE '):
            if not ln.startswith('## MODULES '):
                mods.add(ln.split()[2])
        elif ln.startswith('@@ '):
            parts = ln.split()
            cur = parts[2]
            consts[cur] = {'kind': parts[1], 'internal': 'INTERNAL' in parts[3:], 'type': None, 'value': None}
        elif ln.startswith('TYPE ') and cur:
            if isinstance(cur, tuple):
                if byname is not None: byname[cur[1]]['type'] = ln[5:]
            else:
                consts[cur]['type'] = ln[5:]
        elif ln.startswith('VALUE ') and cur:
            if isinstance(cur, tuple):
                if byname is not None: byname[cur[1]]['value'] = ln[6:]
            else:
                consts[cur]['value'] = ln[6:]
    if len(mods) != EXPECTED:
        raise SystemExit(f'REFUSED: dump names {len(mods)} modules, expected {EXPECTED}')
    if not consts:
        raise SystemExit('REFUSED: dump holds no constants')
    return consts


def compare(a, b, byname=None, redefined=None, added=()):
    bad, notes = [], []
    redefined = redefined or {}
    for n, mod in redefined.items():
        bn = (byname or {}).get(n)
        if n in b:
            bad.append(f'REDEFINED-NOT {n}: still a constant of the 83 modules')
        elif bn is None or bn['absent']:
            bad.append(f'REDEFINED-NOT {n}: not found by name in the second dump')
        elif bn['module'] != mod:
            bad.append(f'REDEFINED-NOT {n}: found in {bn["module"]}, not {mod}')
        elif n not in a or bn['type'] != a[n]['type']:
            bad.append(f'REDEFINED-NOT {n}: its stored TYPE is not the first dump\'s')
        elif bn['value'] == a[n]['value']:
            bad.append(f'REDEFINED-NOT {n}: its VALUE is the first dump\'s (nothing was redefined)')
        else:
            notes.append(f'REDEFINED {n}: now {mod}\'s, TYPE identical, VALUE {a[n]["value"]} -> {bn["value"]}')
    for n in added:
        if n not in b:
            bad.append(f'ADDED-RULED-MISSING {n}: the ruling adds it, and the second dump does not hold it')
    for n, c in a.items():
        if n in redefined:
            continue
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
        elif n in added:
            notes.append(f'ADDED-RULED {d["kind"]} {n}')
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
    flags = [x for x in argv[1:] if x.startswith('--')]
    pos = [x for x in argv[1:] if not x.startswith('--')]
    if len(pos) != 2:
        print(__doc__)
        return 2
    redefined, added = {}, ()
    for f in flags:
        if f.startswith('--redefined='):
            n, m = f[len('--redefined='):].split(':')
            redefined[n] = m
        elif f.startswith('--added='):
            added = tuple(x for x in f[len('--added='):].split(',') if x)
        elif f != '--controls':
            print(f'unknown flag {f}'); return 2
    byname = {}
    a, b = parse(open(pos[0]).read()), parse(open(pos[1]).read(), byname)
    if '--controls' in flags:
        return controls(a, open(pos[1]).read(), redefined, added)
    bad, notes, checked = compare(a, b, byname, redefined, added)
    for x in notes:
        print(x)
    for x in bad:
        print('FAIL', x)
    print(f'checked {checked} constants of the base dump; {len(bad)} differences; {len(notes)} private additions')
    print('PASS' if not bad else 'FAIL')
    return 0 if not bad else 1


def controls(a, after_text, redefined, added):
    """The ruled verdicts' own plants, on the second dump's text: each must fail; the unplanted text must pass."""
    import re as _re
    ok = True
    def run(txt):
        bn = {}
        bad, _, _ = compare(a, parse(txt, bn), bn, redefined, added)
        return bad
    base_bad = run(after_text)
    print(f'unplanted: {"PASS" if not base_bad else "FAIL " + str(base_bad[:2])}')
    ok &= not base_bad
    n, mod = next(iter(redefined.items()))
    i = after_text.index(f'## BYNAME {n} ')
    j = after_text.index('TYPE ', i)
    plants = {
        'the redefined constant left in the 83 modules': after_text.replace('## MODULES', f'@@ DEF {n}\nTYPE {a[n]["type"]}\nVALUE 0\n## MODULES', 1),
        'the redefined constant found in another module': after_text[:i] + after_text[i:].replace(f'module={mod}', 'module=Proofs.Elsewhere', 1),
        'the redefined constant absent by name': after_text[:i] + f'## BYNAME {n} ABSENT\n' + after_text[after_text.index('\n', j) + 1:],
        'the redefined constant\'s TYPE changed': after_text[:j] + 'TYPE 0 PLANT ' + after_text[j + 5:],
        'the redefined constant\'s VALUE the old one': _re.sub(r'(## BYNAME [^\n]*\nTYPE [^\n]*\nVALUE )\S+', lambda m: m.group(1) + a[n]['value'], after_text, count=1),
        'a ruled addition missing, an unruled one added': after_text.replace(f'@@ THM {added[0]}\n', '@@ THM HadwigerNelson.Plane.zz_unruled\n', 1),
    }
    for what, txt in plants.items():
        bad = run(txt)
        print(f'plant {what}: {"FIRED" if bad else "SILENT"}' + (f' ({bad[0][:100]})' if bad else ''))
        ok &= bool(bad)
    print('CONTROLS', 'PASS' if ok else 'FAIL')
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main(sys.argv))
