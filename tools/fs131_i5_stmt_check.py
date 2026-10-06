#!/usr/bin/env python3
"""FS131-I5f: every declaration's statement in the lane's files at a base commit is unchanged in the tree (bodies may differ; new
declarations are allowed; a missing or changed statement fails). Usage: fs131_i5_stmt_check.py BASE [--self-test]."""
import re, subprocess, sys
FILES = ['Proofs/HadwigerNelson/Plane/ValidMap/' + f + '.lean' for f in ['Cor3', 'BaseWalk', 'BaseDense', 'HexRing', 'Dense']]
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
            'hypothesis changed': lambda f, t: t.replace('(hd : dist u u\' < 2)', '(hd : dist u u\' ≤ 2)', 1) if f.endswith('Cor3.lean') else t,
            'conclusion changed': lambda f, t: t.replace('dist u₁ u₂ < 2) : False', 'dist u₁ u₂ ≤ 2) : False', 1) if f.endswith('BaseWalk.lean') else t,
            'declaration deleted': lambda f, t: t.replace('theorem rot_out', 'theorem rot_out_renamed', 1) if f.endswith('HexRing.lean') else t,
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
