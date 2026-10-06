#!/usr/bin/env python3
"""FS131-IR3: every declaration's statement at a base commit is unchanged in the tree, in the files this job may touch or must leave
alone: `Limit`, `Procedure`, `Terminal`, `Chain` (FS131-IL2's list) and the move modules `Surgery`, `Moves`, `MergeMove`, `OpenMove`,
`FlankUA`, where the brief allows new declarations only. Bodies may differ; new declarations are allowed; a missing or changed
statement fails. A copy of FS131-IL2's `tools/fs131_il_stmt_check.py` (standing rule 7 bars editing it) with three changes: the file
list; the head pattern also reads a declaration behind an attribute or `private`/`protected` (IL2's missed `@[simp] theorem
germDir_zero`-style heads); and plants that fire on the tree as it is (IL2's first plant names a hypothesis `badCount_lt_top` no
longer has, so its replace is a no-op and `--self-test` exits 1 with every other plant firing — found at FS131-IR3's Stage 23).

  python3 tools/fs131_ir_stmt_check.py BASE [--allow name,name]   # exit 0 iff nothing but the allowed names changed
  python3 tools/fs131_ir_stmt_check.py BASE --self-test           # six plants, each must fire; the unplanted run must pass
                                                                  # (`--allow` applies to the unplanted run and the plants alike)
"""
import re
import subprocess
import sys

D = 'Proofs/HadwigerNelson/Plane/ValidMap/'
FILES = [D + f + '.lean' for f in ['Limit', 'Procedure', 'Terminal', 'Chain', 'Surgery', 'Moves', 'MergeMove', 'OpenMove', 'FlankUA']]
HEAD = re.compile(r'^(?:@\[[^\]]*\]\s+)?(?:private\s+|protected\s+)?(theorem|def|structure|noncomputable def|abbrev) ([^\s]+)', re.M)


def stmts(txt):
    """A theorem's statement is its text up to its first `:=`; a definition's (or structure's) is its whole block, to the next blank
    line, since its body is its meaning."""
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


def check(base, allow, mutate=None):
    bad, read = [], 0
    for f in FILES:
        old = subprocess.run(['git', 'show', f'{base}:{f}'], capture_output=True, text=True, check=True).stdout
        new = open(f).read()
        if mutate:
            new2 = mutate(f, new)
            new = new2
        so, sn = stmts(old), stmts(new)
        read += len(so)
        if not so:
            bad.append(('NO DECLARATIONS READ', f, ''))
        for name, s in so.items():
            if name in allow:
                continue
            if name not in sn:
                bad.append(('MISSING', f, name))
            elif sn[name] != s:
                bad.append(('CHANGED', f, name))
    return bad, read


def plant(fname, old, new):
    """A mutation of one file; raises if its target text is absent, so a plant that cannot fire is an error, never a silent pass."""
    def m(f, t):
        if not f.endswith(fname):
            return t
        if old not in t:
            raise SystemExit(f'PLANT TARGET ABSENT in {fname}: {old[:60]!r}')
        return t.replace(old, new, 1)
    return m


def main():
    base = sys.argv[1]
    allow = set()
    if '--allow' in sys.argv:
        allow = set(sys.argv[sys.argv.index('--allow') + 1].split(','))
    if '--self-test' in sys.argv:
        plants = {
            'hypothesis dropped (exists_rayStep, Procedure)': plant('Procedure.lean', '(h23 : κ₂ < κ₃) (hH : F.IsHorn v α κ₁ κ₂ c) (hH\' : F.IsHorn v α κ₃ κ₄ c)\n    (h1 : -1 ≤ κ₁) (h4 : κ₄ ≤ 1) {m j : ℕ}', '(h23 : κ₂ < κ₃) (hH : F.IsHorn v α κ₁ κ₂ c) (hH\' : F.IsHorn v α κ₃ κ₄ c)\n    (h1 : -1 ≤ κ₁) {m j : ℕ}'),
            'conclusion changed (exists_clean, Limit)': plant('Limit.lean', 'F\'.Γ ⊆ F.Γ := by', 'F.Γ ⊆ F\'.Γ := by'),
            'declaration renamed (mergeAvailable_of_bothKind, Procedure)': plant('Procedure.lean', 'theorem mergeAvailable_of_bothKind ', 'theorem mergeAvailable_of_bothKind_x '),
            'definition body changed (treatPts, Procedure)': plant('Procedure.lean', 'def treatPts : Set ℂ := {v | F.IsSite v ∨', 'def treatPts : Set ℂ := {v | F.IsSite v ∧'),
            'definition changed (rayKeep, Moves)': plant('Moves.lean', 'κ₂ ≤ X.G.κ i ∧ X.G.κ i ≤ κ₃)}', 'κ₂ < X.G.κ i ∧ X.G.κ i ≤ κ₃)}'),
            'statement behind an attribute changed (germDir-style head, Limit)': None,
        }
        ok = True
        for name, m in plants.items():
            if m is None:
                # the head pattern itself: an `@[simp] theorem` must be read as a declaration
                got = stmts('@[simp] theorem foo (a : ℕ) : a = a := rfl\n')
                fired = 'foo' in got
            else:
                fired = bool(check(base, allow, m)[0])
            print(f'plant {name}: {"FIRED" if fired else "DID NOT FIRE"}')
            ok &= fired
        bad, read = check(base, allow)
        print(f'unplanted control: {"PASS" if not bad else "FAIL"} ({read} statements read)')
        sys.exit(0 if ok and not bad else 1)
    bad, read = check(base, allow)
    for b in bad:
        print(*b)
    print(f'{read} statements read at {base}; allowed to change: {sorted(allow) if allow else "none"}')
    print('RESULT:', 'PASS' if not bad else f'FAIL ({len(bad)})')
    sys.exit(0 if not bad else 1)


if __name__ == '__main__':
    main()
