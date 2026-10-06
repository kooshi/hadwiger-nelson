#!/usr/bin/env python3
"""FS131-L10A: statement checks for a join — nothing changed but what a ruling names.

A declaration is a line beginning (after attributes and modifiers) with theorem, lemma, def, abbrev,
structure, class, inductive or instance, read to the next blank line that is followed by a
non-indented line. Its *statement* is: for a theorem or lemma, the text from the keyword to the first
` :=` (the proof is not read); for anything else, the whole declaration, body included. Its docstring
is the `/-- … -/` block ending on the line before it. Names are qualified by the enclosing
`namespace` lines, so two namespaces' declarations of one short name are two rows.

  present <ref> <file> [<file> ...]
      Every declaration of `<ref>:<file>` appears verbatim in the working tree's file — a theorem's
      statement followed by ` :=` (so nothing can be appended to a conclusion), its docstring too.
      Exit 0 iff none is missing. The merges' check: against each branch's tip.

  delta <ref> [--changed a,b] [--removed c,d] [--added e,f] [--docs g,h] <file> [<file> ...]
      Compares the declarations of `<ref>:<file>` and of the working tree's file by qualified name.
      PASS iff the set of declarations whose statement changed is exactly --changed, the set removed
      exactly --removed, the set added exactly --added, and every declaration whose docstring alone
      changed is in --docs (a docstring change on a --changed row is allowed). The tidies' check:
      exactly the ruled statements changed. Names are given qualified, as the tool prints them.

  --self-test <ref> <file>
      `present` and `delta` (no change expected) on the file as it stands must pass; then five plants
      on a scratch copy, each of which must fail with its own word: one character of a theorem's
      statement changed (CHANGED); a disjunct appended to a theorem's conclusion (CHANGED); a
      declaration dropped (REMOVED); a declaration added (ADDED); a docstring edited (DOC).
"""
import re
import subprocess
import sys

DECL = re.compile(r'^(?:@\[[^\]]*\]\s*)*(?:private |protected |noncomputable |scoped |local )*'
                  r'(theorem|def|abbrev|structure|instance|lemma|class|inductive)\b')
NS = re.compile(r'^namespace\s+(\S+)')
SEC = re.compile(r'^(?:noncomputable\s+)?section(?:\s+(\S+))?\s*$')
END = re.compile(r'^end(?:\s+(\S+))?\s*$')


def chunks(text):
    """[(qualified name, kind, docstring, statement, name as written)] in file order."""
    lines = text.split('\n')
    out, stack = [], []          # stack of ('ns'|'sec', name)
    anon = 0
    i, n = 0, len(lines)
    in_comment = False
    while i < n:
        ln = lines[i]
        # skip block comments and docstrings as scopes for namespace tracking
        if in_comment:
            if '-/' in ln:
                in_comment = False
            i += 1
            continue
        if ln.lstrip().startswith('/-') and '-/' not in ln:
            in_comment = True
            i += 1
            continue
        m = NS.match(ln)
        if m:
            stack.append(('ns', m.group(1)))
            i += 1
            continue
        m = SEC.match(ln)
        if m:
            stack.append(('sec', m.group(1) or ''))
            i += 1
            continue
        m = END.match(ln)
        if m and stack:
            stack.pop()
            i += 1
            continue
        m = DECL.match(ln)
        if not m:
            i += 1
            continue
        kind = m.group(1)
        doc = ''
        j = i - 1
        if j >= 0 and lines[j].rstrip().endswith('-/'):
            k = j
            while k >= 0 and '/--' not in lines[k] and '/-!' not in lines[k]:
                k -= 1
            if k >= 0 and '/--' in lines[k]:
                doc = '\n'.join(lines[k:j + 1])
        e = i + 1
        while e < n:
            if lines[e].strip() == '' and (e + 1 >= n or not lines[e + 1].startswith((' ', '\t'))):
                break
            e += 1
        body = '\n'.join(lines[i:e])
        rest = ln[m.end():].strip()
        short = rest.split()[0] if rest else ''
        if kind == 'instance' and (not short or short.startswith((':', '[', '(', '{'))):
            anon += 1
            short = f'<instance#{anon}>'
        short = short.rstrip(':')
        prefix = '.'.join(nm for t, nm in stack if t == 'ns')
        qual = f'{prefix}.{short}' if prefix else short
        if kind in ('theorem', 'lemma'):
            cut = body.find(' :=')
            stmt = body if cut < 0 else body[:cut]
        else:
            stmt = body
        out.append((qual, kind, doc, stmt, short))
        i = e
    return out


def show(ref, path):
    return subprocess.run(['git', 'show', f'{ref}:{path}'], capture_output=True, text=True,
                          check=True).stdout


def present(old, new):
    bad = []
    cs = chunks(old)
    for qual, kind, doc, stmt, _ in cs:
        needle = stmt + ' :=' if kind in ('theorem', 'lemma') and stmt != '' else stmt
        if needle not in new:
            bad.append(('MISSING', qual, kind))
        elif doc and doc not in new:
            bad.append(('DOC', qual, kind))
    return len(cs), bad


def delta(old, new):
    """(changed, removed, added, doc-only) as sets of qualified names."""
    a, b = {}, {}
    for d, text in ((a, old), (b, new)):
        for qual, kind, doc, stmt, _ in chunks(text):
            key = qual
            k = 2
            while key in d:              # a name declared twice in one file: keep both rows
                key = f'{qual}#{k}'
                k += 1
            d[key] = (kind, doc, stmt)
    changed = {q for q in a if q in b and a[q][2] != b[q][2]}
    removed = {q for q in a if q not in b}
    added = {q for q in b if q not in a}
    doc = {q for q in a if q in b and a[q][2] == b[q][2] and a[q][1] != b[q][1]}
    return changed, removed, added, doc, len(a), len(b)


def run_delta(pairs, exp_changed, exp_removed, exp_added, exp_docs, label='delta'):
    changed, removed, added, doc = set(), set(), set(), set()
    na = nb = 0
    for old, new in pairs:
        c, r, a, d, x, y = delta(old, new)
        changed |= c
        removed |= r
        added |= a
        doc |= d
        na += x
        nb += y
    faults = []
    for q in sorted(changed - exp_changed):
        faults.append(f'CHANGED, not ruled: {q}')
    for q in sorted(exp_changed - changed):
        faults.append(f'NOT-CHANGED, ruled to change: {q}')
    for q in sorted(removed - exp_removed):
        faults.append(f'REMOVED, not ruled: {q}')
    for q in sorted(exp_removed - removed):
        faults.append(f'NOT-REMOVED, ruled to go: {q}')
    for q in sorted(added - exp_added):
        faults.append(f'ADDED, not expected: {q}')
    for q in sorted(exp_added - added):
        faults.append(f'NOT-ADDED, expected: {q}')
    for q in sorted(doc - exp_docs):
        faults.append(f'DOC changed alone, not listed: {q}')
    print(f'{label}: {na} declarations before, {nb} after; statements changed {len(changed)} '
          f'{sorted(changed)}; removed {len(removed)} {sorted(removed)}; added {len(added)} '
          f'{sorted(added)}; docstring alone {len(doc)} {sorted(doc)}')
    for f in faults:
        print('  ' + f)
    return faults


def names(arg):
    return {x for x in arg.split(',') if x}


def main(argv):
    if len(argv) >= 3 and argv[0] == 'present':
        ref, files = argv[1], argv[2:]
        rc = 0
        for path in files:
            n, bad = present(show(ref, path), open(path, encoding='utf-8').read())
            for word, qual, kind in bad:
                print(f'  {word} {path}: {kind} {qual}')
            print(f'{path} against {ref}: {n} declarations, {len(bad)} flagged')
            rc = rc or (1 if bad else 0)
        print('present: PASS' if rc == 0 else 'present: FAIL')
        return rc
    if len(argv) >= 3 and argv[0] == 'delta':
        ref = argv[1]
        opts = {'--changed': set(), '--removed': set(), '--added': set(), '--docs': set()}
        files, i = [], 2
        while i < len(argv):
            if argv[i] in opts:
                opts[argv[i]] = names(argv[i + 1])
                i += 2
            else:
                files.append(argv[i])
                i += 1
        pairs = [(show(ref, p), open(p, encoding='utf-8').read()) for p in files]
        faults = run_delta(pairs, opts['--changed'], opts['--removed'], opts['--added'],
                           opts['--docs'], label=f'delta against {ref} over {len(files)} file(s)')
        print('delta: PASS' if not faults else f'delta: FAIL ({len(faults)} fault(s))')
        return 1 if faults else 0
    if len(argv) == 3 and argv[0] == '--self-test':
        ref, path = argv[1], argv[2]
        old = show(ref, path)
        new = open(path, encoding='utf-8').read()
        n, bad = present(old, new)
        ok = not bad
        print(f'faithful present: {n} declarations, {len(bad)} flagged')
        ok = ok and not run_delta([(new, new)], set(), set(), set(), set(), label='faithful delta')
        cs = chunks(new)
        thms = [c for c in cs if c[1] == 'theorem' and c[3] and (c[3] + ' :=') in new]
        q, kind, doc, stmt, short = thms[len(thms) // 2]
        docd = [c for c in cs if c[2]][0]
        plants = [
            ('CHANGED', 'one character of a statement', new.replace(stmt, stmt[:-1] + ('x' if stmt[-1] != 'x' else 'y'), 1)),
            ('CHANGED', 'a disjunct appended to a conclusion', new.replace(stmt + ' :=', stmt + ' ∨ True :=', 1)),
            ('REMOVED', 'a declaration renamed away', new.replace(f'theorem {short} ', 'theorem zz_planted_gone ', 1)),
            ('ADDED', 'a declaration added', new + '\n\ntheorem zz_planted_new : True := trivial\n'),
            ('DOC', 'a docstring edited', new.replace(docd[2], docd[2].replace('/--', '/-- PLANTED', 1), 1)),
        ]
        for word, what, planted in plants:
            if planted == new:
                print(f'  plant ({what}): COULD NOT BE PLANTED')
                ok = False
                continue
            faults = run_delta([(new, planted)], set(), set(), set(), set(), label=f'plant ({what})')
            fired = any(f.startswith(word) for f in faults)
            if word == 'CHANGED':
                _, pbad = present(new, planted)
                fired = fired and any(b[0] == 'MISSING' for b in pbad)
            print(f'  -> {"fired" if fired else "DID NOT FIRE"} ({word})')
            ok = ok and fired
        print('self-test: PASS' if ok else 'self-test: FAIL')
        return 0 if ok else 1
    print(__doc__)
    return 2


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
