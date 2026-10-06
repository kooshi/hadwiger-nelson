#!/usr/bin/env python3
"""FS131-IS1: every declaration's statement in the two Lean files this job edits (`Terminal`, `HornShadow`) at a base commit is
unchanged in the tree (bodies may differ; new declarations are allowed; a missing or changed statement fails). A copy of FS131-IL2's
checker (`tools/fs131_il_stmt_check.py`, itself I5h's), re-aimed at these files with plants in them: IL2's first plant targets a
hypothesis FS131-M6 removed by ruling 389 (a), so its self-test no longer passes on this branch (standing rule 7 bars editing it).
Usage: fs131_is_stmt_check.py BASE [--self-test]."""
import re
import subprocess
import sys

FILES = ['Proofs/HadwigerNelson/Plane/ValidMap/' + f + '.lean' for f in ['Terminal', 'HornShadow']]
HEAD = re.compile(r'^(theorem|def|structure|noncomputable def|abbrev) ([^\s]+)', re.M)


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


def check(base, mutate=None):
    bad, read = [], 0
    for f in FILES:
        old = subprocess.run(['git', 'show', f'{base}:{f}'], capture_output=True, text=True, check=True).stdout
        new = open(f).read()
        if mutate:
            mutated = mutate(f, new)
            new = mutated
        so, sn = stmts(old), stmts(new)
        read += len(so)
        if not so:
            bad.append(('NO DECLARATIONS READ', f, ''))
        for name, s in so.items():
            if name not in sn:
                bad.append(('MISSING', f, name))
            elif sn[name] != s:
                bad.append(('CHANGED', f, name))
    return bad, read


def plant(suffix, old, new):
    """A mutation of one file; it must find its target (a plant that changes nothing is a broken plant, and says so)."""
    def m(f, t):
        if not f.endswith(suffix):
            return t
        if old not in t:
            raise SystemExit(f'PLANT TARGET MISSING in {suffix}: {old[:60]!r}')
        return t.replace(old, new, 1)
    return m


def main():
    base = sys.argv[1]
    if '--self-test' in sys.argv:
        plants = {
            'hypothesis dropped (stuckRun_ne_univ)': plant(
                'Terminal.lean', '(h3 : (F.coloursAt v).ncard ≤ 3) : F.stuckRun v α ≠ univ', ': F.stuckRun v α ≠ univ'),
            'conclusion changed (stuckRun_ne_univ)': plant(
                'Terminal.lean', ': F.stuckRun v α ≠ univ := by', ': F.stuckRun v α ≠ ∅ := by'),
            'declaration renamed (cv_l0)': plant('Terminal.lean', 'theorem cv_l0 ', 'theorem cv_l0_x '),
            'definition body changed (HornBoundsQR)': plant(
                'Terminal.lean', '(∀ κ₁ d, F.IsHorn w β κ₁ 1 d →', '(∀ κ₁ d, F.IsHorn w β κ₁ 0 d →'),
            'conclusion changed (shadow_hornSet_subset_S, HornShadow)': plant(
                'HornShadow.lean', 'shadow (hornSet v α ν ν\' r) ⊆ {y | TanAbove (v - e (α + π / 2)) α (curvDown ν) y} :=',
                'shadow (hornSet v α ν ν\' r) ⊆ {y | TanBelow (v - e (α + π / 2)) α (curvDown ν) y} :='),
            'hypothesis changed (mem_shadow_hornSet_N, HornShadow)': plant(
                'HornShadow.lean', '(h1 : -1 ≤ υ\') (h12 : υ\' < υ) (h2 : υ < 1) (hr : 0 < r)\n    (hr2 : r ≤ 1 / 2) :\n    ∃ ρ > 0, ∀ y, dist y (v + e',
                '(h1 : -1 ≤ υ\') (h12 : υ\' < υ) (h2 : υ ≤ 1) (hr : 0 < r)\n    (hr2 : r ≤ 1 / 2) :\n    ∃ ρ > 0, ∀ y, dist y (v + e'),
        }
        ok = True
        for name, m in plants.items():
            bad, _ = check(base, m)
            fired = bool(bad)
            print(f'plant {name}: {"FIRED " + str(bad[0]) if fired else "DID NOT FIRE"}')
            ok &= fired
        bad, read = check(base)
        print(f'unplanted control: {"PASS" if not bad else "FAIL"} ({read} statements read at {base})')
        sys.exit(0 if ok and not bad else 1)
    bad, read = check(base)
    for b in bad:
        print(*b)
    print(f'{read} statements read at {base} in {len(FILES)} files')
    print('RESULT:', 'PASS' if not bad else f'FAIL ({len(bad)})')
    sys.exit(0 if not bad else 1)


if __name__ == '__main__':
    main()
