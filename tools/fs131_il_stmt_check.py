#!/usr/bin/env python3
"""FS131-IL2: every declaration's statement in lane A's files (`Limit`, `Procedure`) and the files whose statements the brief fences
(`Terminal`, `Chain`) at a base commit is unchanged in the tree (bodies may differ; new declarations are allowed; a missing or changed
statement fails). A copy of FS131-I5h's checker (`tools/fs131_i5h_stmt_check.py`), re-aimed at these files with plants in them.
Usage: fs131_il_stmt_check.py BASE [--self-test]."""
import re
import subprocess
import sys

FILES = ['Proofs/HadwigerNelson/Plane/ValidMap/' + f + '.lean' for f in ['Limit', 'Procedure', 'Terminal', 'Chain']]
HEAD = re.compile(r'^(theorem|def|structure|noncomputable def|abbrev) ([^\s]+)', re.M)


def stmts(txt):
    """A theorem's statement is its text up to its first `:=`; a definition's (or structure's) is its whole block, to the next blank
    line, since its body is its meaning. (FS131-I5h's single regex ran past a `def … := {…}` to the next `:= by`, so a lemma inserted
    after such a definition read as a change to it.)"""
    out = {}
    for m in HEAD.finditer(txt):
        rest = txt[m.end():]
        if m.group(1) == 'theorem':
            body = rest[:rest.index(':=')] if ':=' in rest else rest
        else:
            j = rest.find('\n\n')
            body = rest if j < 0 else rest[:j]
        out[m.group(2)] = re.sub(r'\s+', ' ', body).strip()
    return out


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
        for name, s in so.items():
            if name not in sn:
                bad.append(('MISSING', f, name))
            elif sn[name] != s:
                bad.append(('CHANGED', f, name))
    return bad


def main():
    base = sys.argv[1]
    if '--self-test' in sys.argv:
        plants = {
            'hypothesis changed (badCount_lt_top)': lambda f, t: t.replace(
                'theorem badCount_lt_top (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean)',
                'theorem badCount_lt_top (hF : F.Valid) (hP : F.IsPlaneMap)', 1) if f.endswith('Procedure.lean') else t,
            'conclusion changed (exists_clean)': lambda f, t: (lambda i: t[:i] + t[i:].replace('F\'.Γ ⊆ F.Γ', 'F.Γ ⊆ F\'.Γ', 1))(
                t.index('theorem exists_clean')) if f.endswith('Limit.lean') else t,
            'declaration renamed (mergeAvailable_of_bothKind)': lambda f, t: t.replace(
                'theorem mergeAvailable_of_bothKind ', 'theorem mergeAvailable_of_bothKind_x ', 1) if f.endswith('Procedure.lean') else t,
            'definition body changed (treatPts)': lambda f, t: t.replace(
                'def treatPts : Set ℂ := {v | F.IsSite v ∨', 'def treatPts : Set ℂ := {v | F.IsSite v ∧', 1) if f.endswith('Procedure.lean') else t,
            'definition changed (IsModification, Chain)': lambda f, t: t.replace(
                'structure IsModification (M : ArcMap k) : Prop', 'structure IsModification (M : ArcMap k) (n : ℕ) : Prop', 1)
                if f.endswith('Chain.lean') else t,
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
