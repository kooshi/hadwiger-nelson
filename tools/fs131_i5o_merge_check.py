#!/usr/bin/env python3
"""FS131-I5o: check a merge's Lean statements against both parents, byte for byte.

For each file, every declaration of each parent is split out (attributes, modifiers and keyword through the statement):
a `theorem`/`lemma` up to its first `:=` (or ` where`), every other declaration (`def`, `structure`, `inductive`, `abbrev`, `class`,
`instance`, `opaque`, `axiom`) whole, up to the next declaration or docstring. Keys are the declared name with its occurrence index
in the file (a name declared twice in different namespaces is two keys). Three-way, per key, against the merge base:
  - a key whose statement only one parent changed (or added) must appear in the merge byte-identical to that parent's;
  - a key neither parent changed must appear identical to the base's;
  - a key both parents changed differently is reported CONFLICT (the merge must be stopped and the hunks sent).
A key present in a parent and missing from the merge is MISSING (a deleted declaration).
Also: every .lean file under Proofs/ or scripts/ that only one parent changed must equal that parent's file byte for byte.

Usage: fs131_i5o_merge_check.py BASE OURS THEIRS [--merged-ref REF] [--self-test]
  the merged side is the working tree unless --merged-ref names a commit.
Exit 0 only on PASS. --self-test plants a changed hypothesis, a deleted declaration and a changed one-sided file in the merged
text and requires each to be caught, beside the unplanted run, which must pass.
"""
import re
import subprocess
import sys

STMT_FILES = ['Proofs/HadwigerNelson/Plane/ValidMap/' + f + '.lean' for f in ['BaseWalk', 'BaseDense', 'MapGraph', 'MapTopology']] + \
    ['Proofs/HadwigerNelson/Plane/CurveGraph.lean', 'Proofs/HadwigerNelson/Plane/PlaneTopology.lean', 'Proofs/HadwigerNelson/Thomassen.lean']

KW = r'(?:theorem|lemma|def|structure|inductive|abbrev|class|instance|opaque|axiom)'
START = re.compile(r'^(?:@\[[^\]]*\]\s*)*(?:(?:private|protected|noncomputable|nonrec|partial|unsafe)\s+)*(' + KW + r')\b\s*([^\s:({\[⦃]*)', re.M)
BOUND = re.compile(r'^(?:/--|/-!|namespace |end\b|section\b|open |variable|@\[|(?:(?:private|protected|noncomputable|nonrec|partial|unsafe)\s+)*' + KW + r'\b|#|set_option|attribute)', re.M)


def git_show(ref, path):
    r = subprocess.run(['git', 'show', f'{ref}:{path}'], capture_output=True, text=True)
    return r.stdout if r.returncode == 0 else None


def decls(txt):
    if txt is None:
        return {}
    out, seen = {}, {}
    ms = list(START.finditer(txt))
    for m in ms:
        kind, name = m.group(1), m.group(2) or '<anon>'
        nxt = None
        for b in BOUND.finditer(txt, m.end()):
            if b.start() > m.start():
                nxt = b.start()
                break
        chunk = txt[m.start():nxt].rstrip()
        if kind in ('theorem', 'lemma'):
            cut = [i for i in (chunk.find(':='), chunk.find(' where')) if i >= 0]
            chunk = chunk[:min(cut)] if cut else chunk
        k = seen.get(name, 0)
        seen[name] = k + 1
        out[(name, k)] = chunk
    return out


def merged_text(ref, path):
    if ref is None:
        try:
            return open(path, encoding='utf-8').read()
        except FileNotFoundError:
            return None
    return git_show(ref, path)


def changed_files(base, ref):
    r = subprocess.run(['git', 'diff', '--name-only', base, ref, '--', 'Proofs', 'scripts', 'Proofs.lean'], capture_output=True, text=True, check=True)
    return {f for f in r.stdout.split() if f.endswith('.lean')}


def check(base, ours, theirs, mref=None, mutate=None):
    bad, n = [], 0
    for f in STMT_FILES:
        b, o, t = decls(git_show(base, f)), decls(git_show(ours, f)), decls(git_show(theirs, f))
        mtxt = merged_text(mref, f)
        if mutate:
            mtxt = mutate(f, mtxt)
        m = decls(mtxt)
        for key in set(o) | set(t):
            n += 1
            oc, tc, bc = o.get(key) != b.get(key), t.get(key) != b.get(key), None
            if oc and tc and o.get(key) != t.get(key):
                bad.append(('CONFLICT', f, key))
                continue
            want = o.get(key) if oc else (t.get(key) if tc else b.get(key))
            if want is None:
                continue
            if key not in m:
                bad.append(('MISSING', f, key))
            elif m[key] != want:
                bad.append(('CHANGED', f, key))
    co, ct = changed_files(base, ours), changed_files(base, theirs)
    for f in sorted(co ^ ct):
        if f in STMT_FILES:
            continue
        side = ours if f in co else theirs
        want = git_show(side, f)
        got = merged_text(mref, f)
        if mutate:
            got = mutate(f, got)
        if want != got:
            bad.append(('FILE DIFFERS', f, side))
    return bad, n, len(co ^ ct)


def main():
    a = sys.argv[1:]
    base, ours, theirs = a[0], a[1], a[2]
    mref = a[a.index('--merged-ref') + 1] if '--merged-ref' in a else None
    if '--self-test' in a:
        plants = {
            'hypothesis changed (BaseWalk)': lambda f, t: t.replace('(hF : F.Valid)', '(hF : F.Valid) (hX : True)', 1) if t and f.endswith('BaseWalk.lean') else t,
            'declaration deleted (MapGraph)': lambda f, t: t.replace('theorem cvb_thom_reduced', 'theorem cvb_thom_reduced_gone', 1) if t and f.endswith('MapGraph.lean') else t,
            'one-sided file changed (HexRing)': lambda f, t: t + '\n-- planted\n' if t and f.endswith('HexRing.lean') else t,
        }
        ok = True
        for name, mu in plants.items():
            bad, _, _ = check(base, ours, theirs, mref, mu)
            print(f'plant {name}: {"FIRED " + str(bad[:2]) if bad else "DID NOT FIRE"}')
            ok &= bool(bad)
        bad, n, nf = check(base, ours, theirs, mref)
        print(f'unplanted: {"PASS" if not bad else "FAIL " + str(bad[:5])} ({n} declaration keys, {nf} one-sided files)')
        ok &= not bad
        print('SELF-TEST', 'PASS' if ok else 'FAIL')
        return 0 if ok else 1
    bad, n, nf = check(base, ours, theirs, mref)
    for x in bad:
        print(*x)
    print(f'{n} declaration keys over {len(STMT_FILES)} files, {nf} one-sided files compared whole')
    print('RESULT:', 'PASS' if not bad else f'FAIL ({len(bad)})')
    return 0 if not bad else 1


if __name__ == '__main__':
    sys.exit(main())
