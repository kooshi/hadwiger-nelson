#!/usr/bin/env python3
"""FS131-I10B: statement check — nothing of the skeleton changed but the proofs of its open leaves.

Two checks of the working tree's version of a Lean file against the base commit's version:

 (A) per declaration. Every declaration of the base (theorem, def, abbrev, structure, instance, ...) must appear verbatim
     in the working tree, exactly once: for a theorem, the text from its keyword up to the first ` :=`, AND that text must be
     followed by ` :=` in the working tree (so nothing can be appended to a conclusion: `… : B` is a prefix of `… : B ∨ C`);
     for anything else the whole declaration, body included. A declaration's docstring (the `/-- … -/` block ending on the
     line before it) must appear verbatim too.
 (B) per line. The base's lines, with the lines that are exactly a `sorry` proof removed, must be a subsequence of the
     working tree's lines: the skeleton may gain lines, it may not lose or alter one (imports, the module docstring,
     `variable`/`attribute`/`open` lines, the spec examples).

usage: fs131_i10b_statements.py <base-commit> <file> [<file> ...]   exit 0 = PASS
       fs131_i10b_statements.py --self-test <base-commit> <file>    plants five faults, each must fire; exit 0 = all fired

The repository root is the current directory (paths are relative to it, as `git show <base>:<path>` reads them).
"""
import re
import subprocess
import sys

DECL = re.compile(r'^(?:@\[[^\]]*\]\s*)*(?:private |protected |noncomputable )*'
                  r'(theorem|def|abbrev|structure|instance|lemma|class|inductive)\b')


def chunks(text):
    """Split a file into declaration chunks: (kind, name, docstring, statement_text)."""
    lines = text.split('\n')
    out = []
    i, n = 0, len(lines)
    while i < n:
        m = DECL.match(lines[i])
        if not m:
            i += 1
            continue
        kind = m.group(1)
        doc = ''
        j = i - 1
        if j >= 0 and lines[j].rstrip().endswith('-/'):
            k = j
            while k >= 0 and '/--' not in lines[k]:
                k -= 1
            if k >= 0:
                doc = '\n'.join(lines[k:j + 1])
        # the declaration runs to the next blank line followed by a non-indented line (or the end of the file)
        e = i + 1
        while e < n:
            if lines[e].strip() == '' and (e + 1 >= n or not lines[e + 1].startswith((' ', '\t'))):
                break
            e += 1
        body = '\n'.join(lines[i:e])
        rest = lines[i][m.end():].strip()
        name = rest.split()[0] if rest else '<anonymous>'
        if kind in ('theorem', 'lemma'):
            cut = body.find(' :=')
            stmt = body if cut < 0 else body[:cut]
        else:
            stmt = body
        out.append((kind, name, doc, stmt))
        i = e
    return out


def is_sorry_line(line):
    return line.strip() == 'sorry'


def subsequence_miss(old_lines, new_lines):
    """First base line (sorry lines dropped) that cannot be matched, in order, in the new lines; None if all match."""
    pos = 0
    for idx, line in enumerate(old_lines):
        if is_sorry_line(line):
            continue
        while pos < len(new_lines) and new_lines[pos] != line:
            pos += 1
        if pos == len(new_lines):
            return idx + 1, line
        pos += 1
    return None


def check(base, path, new_text=None):
    old = subprocess.run(['git', 'show', f'{base}:{path}'], capture_output=True, text=True, check=True).stdout
    new = open(path).read() if new_text is None else new_text
    bad = []
    cs = chunks(old)
    for kind, name, doc, stmt in cs:
        needle = stmt + ' :=' if kind in ('theorem', 'lemma') else stmt
        c = new.count(needle)
        if c != 1:
            bad.append((kind, name, f'statement found {c} times, expected 1'))
        elif doc and new.count(doc) < 1:
            bad.append((kind, name, 'docstring missing or changed'))
    miss = subsequence_miss(old.split('\n'), new.split('\n'))
    if miss is not None:
        bad.append(('line', f'base line {miss[0]}', f'not found in order: {miss[1][:90]!r}'))
    return len(cs), len(old.split('\n')), bad


def self_test(base, path):
    text = open(path).read()
    n, nl, bad = check(base, path)
    if bad:
        print('SELF-TEST: the unplanted file already fails; the controls cannot run')
        for b in bad:
            print('   ', b)
        return 2
    old = subprocess.run(['git', 'show', f'{base}:{path}'], capture_output=True, text=True, check=True).stdout
    cs = chunks(old)
    thms = [c for c in cs if c[0] == 'theorem']
    defs = [c for c in cs if c[0] in ('def', 'abbrev', 'structure')]
    results = []
    # fault 1: one character of a theorem's statement changed
    kind, name, doc, stmt = thms[len(thms) // 2]
    planted = text.replace(stmt, stmt[:-1] + ('x' if stmt[-1] != 'x' else 'y'), 1)
    results.append(('theorem statement, one character changed', name, any(b[1] == name for b in check(base, path, planted)[2])))
    # fault 2: a conclusion widened by appending to it (the base statement stays a prefix)
    kind, name, doc, stmt = thms[-1]
    planted = text.replace(stmt + ' :=', stmt + ' ∨ True :=', 1)
    results.append(('conclusion widened by an appended disjunct', name, any(b[1] == name for b in check(base, path, planted)[2])))
    # fault 3: a line of a definition dropped
    kind, name, doc, stmt = defs[0]
    planted = text.replace(stmt, stmt.rsplit('\n', 1)[0] if '\n' in stmt else stmt[:-2], 1)
    results.append(('definition, last line dropped', name, any(b[1] == name for b in check(base, path, planted)[2])))
    # fault 4: a docstring changed
    with_doc = [c for c in cs if c[2]]
    kind, name, doc, stmt = with_doc[len(with_doc) // 2]
    planted = text.replace(doc, doc.replace('-/', ' (edited) -/'), 1)
    results.append(('docstring edited', name, any(b[1] == name for b in check(base, path, planted)[2])))
    # fault 5: a non-declaration line of the skeleton removed (the last `example` line of the base, or its last import)
    old_lines = old.split('\n')
    cand = [l for l in old_lines if l.startswith('example')] or [l for l in old_lines if l.startswith('import ')]
    victim = cand[-1]
    planted = text.replace(victim + '\n', '', 1)
    results.append(('skeleton line removed', victim[:50], any(b[0] == 'line' for b in check(base, path, planted)[2])))
    ok = True
    for what, where, fired in results:
        print(f'SELF-TEST {path}: {what} [{where}] — ' + ('FIRED' if fired else 'SILENT'))
        ok = ok and fired
    print('SELF-TEST: ' + ('all five faults fired' if ok else 'A FAULT WAS SILENT'))
    return 0 if ok else 1


def main():
    args = sys.argv[1:]
    if len(args) < 2:
        print(__doc__)
        return 2
    if args[0] == '--self-test':
        return self_test(args[1], args[2])
    base, files = args[0], args[1:]
    rc = 0
    for path in files:
        n, nl, bad = check(base, path)
        for kind, name, what in bad:
            rc = 1
            print(f'CHANGED {path}: {kind} {name} ({what})')
        print(f'{path}: {n} base declarations and {nl} base lines checked, {len(bad)} flagged')
    print('STATEMENTS: ' + ('PASS' if rc == 0 else 'FAIL'))
    return rc


if __name__ == '__main__':
    sys.exit(main())
