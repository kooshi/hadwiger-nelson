#!/usr/bin/env python3
"""FS131-M7: no statement of a declaration changed between a base commit and the working tree, but for the named ones.

After FS131-IR3's `tools/fs131_ir_stmt_check.py` (itself FS131-IL2's; standing rule 7 bars editing either), rewritten for a join:

  * the files are every Lean file under `Proofs/HadwigerNelson/Plane/ValidMap/` at BASE (not a fixed list), and every OTHER Lean
    path under `Proofs/` and `Proofs.lean` must be byte-identical to BASE (`git diff --name-only`), so an edit outside the two files
    this job may touch fails by name;
  * a declaration is keyed by (file, name as written, its occurrence index in the file), so a short name used in two namespaces of
    one file is two declarations, not one overwritten;
  * `--allow NAME[,NAME]` names declarations whose statement MAY change, `--gone FILE:NAME[,…]` declarations that MAY be missing from
    a file; each allowed name MUST in fact have changed and each gone name MUST in fact be missing — a stale allowance fails
    (a positive signal for the edit that was supposed to happen);
  * it prints the declarations ADDED since BASE.

A theorem's statement is its text up to its first `:=`; a definition's, structure's or instance's is its whole block, to the next
blank line, since its body is its meaning. Bodies of theorems may differ.

  python3 tools/fs131_m7_stmt_check.py BASE [--allow a,b] [--gone File.lean:name,…] [--touch File.lean,File.lean]
  python3 tools/fs131_m7_stmt_check.py BASE … --self-test    # six plants, each must fire; the unplanted run must pass
`--touch` lists the files (by base name) that may differ from BASE at all; default none.
"""
import collections
import re
import subprocess
import sys

D = 'Proofs/HadwigerNelson/Plane/ValidMap/'
HEAD = re.compile(r'^(?:@\[[^\]]*\]\s+)?(?:(?:private|protected|noncomputable|nonrec)\s+)*'
                  r'(theorem|lemma|def|structure|abbrev|instance|inductive|class) ([^\s:({\[]+)', re.M)


def git(*a):
    return subprocess.run(['git', *a], capture_output=True, text=True, check=True).stdout


def stmts(txt):
    out, seen = {}, collections.Counter()
    for m in HEAD.finditer(txt):
        rest = txt[m.end():]
        if m.group(1) in ('theorem', 'lemma'):
            body = rest[:rest.index(':=')] if ':=' in rest else rest
        else:
            j = rest.find('\n\n')
            body = rest if j < 0 else rest[:j]
        name = m.group(2)
        out[(name, seen[name])] = re.sub(r'\s+', ' ', body).strip()
        seen[name] += 1
    return out


def check(base, allow, gone, touch, mutate=None):
    """Returns (failure lines, statements read, added names). `mutate(path, text)` plants a fault in the working tree's text."""
    bad, read, added = [], 0, []
    files = [p for p in git('ls-tree', '-r', '--name-only', base, D).split() if p.endswith('.lean')]
    if not files:
        bad.append('NO FILES READ at ' + base)
    changed = [p for p in git('diff', '--name-only', base, '--', 'Proofs', 'Proofs.lean').split()]
    for p in changed:
        if p.rsplit('/', 1)[-1] not in touch:
            bad.append(f'TOUCHED {p}: differs from {base}, not in --touch')
    used_allow, used_gone = set(), set()
    for f in files:
        old = git('show', f'{base}:{f}')
        try:
            new = open(f).read()
        except FileNotFoundError:
            bad.append(f'FILE MISSING {f}')
            continue
        if mutate:
            new = mutate(f, new)
        so, sn = stmts(old), stmts(new)
        read += len(so)
        if not so:
            bad.append(f'NO DECLARATIONS READ {f}')
        short = f.rsplit('/', 1)[-1]
        for key, s in so.items():
            name = key[0]
            if key not in sn:
                if f'{short}:{name}' in gone:
                    used_gone.add(f'{short}:{name}')
                else:
                    bad.append(f'MISSING {f} {name}')
            elif sn[key] != s:
                if name in allow:
                    used_allow.add(name)
                else:
                    bad.append(f'CHANGED {f} {name}')
        added += [f'{short}:{k[0]}' for k in sn if k not in so]
    for a in sorted(allow - used_allow):
        bad.append(f'STALE ALLOWANCE {a}: allowed to change, but its statement is unchanged (or it is not declared)')
    for g in sorted(gone - used_gone):
        bad.append(f'STALE ALLOWANCE {g}: allowed to be gone, but it is still declared there (or never was)')
    return bad, read, added


def plant(fname, old, new):
    """A mutation of one file; raises if its target text is absent, so a plant that cannot fire is an error, never a silent pass."""
    def m(f, t):
        if not f.endswith('/' + fname):
            return t
        if old not in t:
            raise SystemExit(f'PLANT TARGET ABSENT in {fname}: {old[:70]!r}')
        return t.replace(old, new, 1)
    return m


def opt(flag):
    if flag in sys.argv:
        return {x for x in sys.argv[sys.argv.index(flag) + 1].split(',') if x}
    return set()


def main():
    base = sys.argv[1]
    allow, gone, touch = opt('--allow'), opt('--gone'), opt('--touch')
    if '--self-test' in sys.argv:
        plants = {
            'a hypothesis dropped (exists_vertexStep, Procedure)':
                plant('Procedure.lean', 'theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) ', 'theorem exists_vertexStep (hF : F.Valid) '),
            'a conclusion changed (ArcBend.dom_eq, ArcStep)':
                plant('ArcStep.lean', ': M.dom = F.dom := hB.step.agreesOff.1.symm', ': F.dom = M.dom := hB.step.agreesOff.1.symm'),
            'a declaration renamed (IsMaxRingArc.not_regularAt, Procedure)':
                plant('Procedure.lean', 'theorem IsMaxRingArc.not_regularAt ', 'theorem IsMaxRingArc.not_regularAt_x '),
            'a definition body changed (treatPts, Procedure)':
                plant('Procedure.lean', 'def treatPts : Set ℂ := {v | F.IsSite v ∨', 'def treatPts : Set ℂ := {v | F.IsSite v ∧'),
            'a structure field changed (ArcBend.side, ArcStep)':
                plant('ArcStep.lean', '  side : g = c ∨ g = c\'', '  side : g = c ∧ g = c\''),
        }
        ok = True
        for name, m in plants.items():
            b2 = check(base, allow, gone, touch, m)[0]
            fired = any(x.startswith(('CHANGED', 'MISSING')) for x in b2)
            print(f'plant — {name}: {"FIRED" if fired else "DID NOT FIRE"}  {b2[:1]}')
            ok &= fired
        b3 = check(base, allow | {'exists_vertexStep'}, gone, touch)[0]
        fired = any(x.startswith('STALE ALLOWANCE exists_vertexStep') for x in b3)
        print(f'plant — an allowance for a statement that did not change: {"FIRED" if fired else "DID NOT FIRE"}  {b3[:1]}')
        ok &= fired
        bad, read, _ = check(base, allow, gone, touch)
        print(f'unplanted control: {"PASS" if not bad else "FAIL"} ({read} statements read)  {bad[:2]}')
        print('SELF-TEST:', 'every plant fired, the unplanted run passed' if ok and not bad else 'FAILED')
        sys.exit(0 if ok and not bad else 1)
    bad, read, added = check(base, allow, gone, touch)
    for b in bad:
        print(b)
    print(f'{read} statements read at {base}; allowed to change: {sorted(allow) or "none"}; allowed gone: {sorted(gone) or "none"}; '
          f'files that may differ: {sorted(touch) or "none"}')
    print(f'added since {base}: {added or "none"}')
    print('RESULT:', 'PASS' if not bad else f'FAIL ({len(bad)})')
    sys.exit(0 if not bad else 1)


if __name__ == '__main__':
    main()
