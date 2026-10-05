#!/usr/bin/env python3
"""FS131-I5h: every declaration's statement in this lane's files (`Terminal`, `BaseDense`, `FlankUA`) at a base commit is unchanged in the
tree (bodies may differ; new declarations are allowed; a missing or changed statement fails). FS131-I5f's checker re-aimed at this lane's
files, with plants in them. Usage: fs131_i5h_stmt_check.py BASE [--self-test]."""
import re, subprocess, sys
FILES = ['Proofs/HadwigerNelson/Plane/ValidMap/' + f + '.lean' for f in ['Terminal', 'BaseDense', 'FlankUA']]
SIG = re.compile(r'^(theorem|def|structure|noncomputable def) ([^\s]+)(.*?)(:= by|:=\n|:= fun|:=$| where)', re.S | re.M)


def stmts(txt):
    return {m.group(2): re.sub(r'\s+', ' ', m.group(3)).strip() for m in SIG.finditer(txt)}


def check(base, mutate=None):
    bad = []
    for f in FILES:
        old = subprocess.run(['git', 'show', f'{base}:{f}'], capture_output=True, text=True, check=True).stdout
        new = open(f).read()
        if mutate:
            new = mutate(f, new)
        so, sn = stmts(old), stmts(new)
        if not so:
            bad.append(('NO DECLARATIONS READ', f, ''))
        for k, v in so.items():
            if k not in sn:
                bad.append(('MISSING', f, k))
            elif sn[k] != v:
                bad.append(('CHANGED', f, k))
    return bad


def main():
    base = sys.argv[1]
    if '--self-test' in sys.argv:
        plants = {
            'hypothesis changed (n3_end_of_not_inType)': lambda f, t: t.replace('(h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)\n    (hno',
                                                                           '(h3 : (F.coloursAt v).ncard ≤ 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c)\n    (hno', 1) if f.endswith('Terminal.lean') else t,
            'conclusion changed (cv_exists)': lambda f, t: t.replace('∃ x, 4 ≤', '∃ x, 3 ≤', 1) if f.endswith('BaseDense.lean') else t,
            'declaration renamed (cv_class)': lambda f, t: t.replace('theorem cv_class ', 'theorem cv_class_renamed ', 1) if f.endswith('Terminal.lean') else t,
        }
        ok = True
        for name, m in plants.items():
            fired = bool(check(base, m))
            print(f'plant {name}: {"FIRED" if fired else "DID NOT FIRE"}')
            ok &= fired
        clean = not check(base)
        print(f'unplanted control: {"PASS" if clean else "FAIL"}')
        sys.exit(0 if ok and clean else 1)
    bad = check(base)
    for b in bad:
        print(*b)
    print('RESULT:', 'PASS' if not bad else f'FAIL ({len(bad)})')
    sys.exit(0 if not bad else 1)


if __name__ == '__main__':
    main()
