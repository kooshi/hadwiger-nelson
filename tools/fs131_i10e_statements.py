#!/usr/bin/env python3
"""FS131-I10E: statement check against a base commit.

Every declaration of the base commit's version of a Lean file must appear in the working tree's version with its
statement unchanged: for a theorem, the text from its keyword to the first ` :=`; for anything else (def, abbrev,
structure, instance), the whole declaration, body included. A docstring is the statement's reading, so it is compared
too: it must be verbatim, or EXTENDED (the base docstring, less its closing `-/`, is a prefix of the new one) — an
extension is listed on every run and does not fail; any other docstring change fails.

(The checker is that of tools/fs131_i10d_statements.py, copied: this file is this job's own, with the docstring rule and a
self-test that says "not run" where a control has nothing to plant in.)

usage: fs131_i10e_statements.py <base-commit> <file> [<file> ...]   exit 0 = every base statement present verbatim
       fs131_i10e_statements.py --self-test <base-commit> <file>    plants four faults/partners, each must behave
"""
import re
import subprocess
import sys

DECL = re.compile(r'^(?:@\[[^\]]*\]\s*)*(?:private |protected |noncomputable )*'
                  r'(theorem|def|abbrev|structure|instance|lemma|class|inductive)\b')


def chunks(text):
    """Split into declaration chunks: (kind, name, docstring, statement_text)."""
    lines = text.split('\n')
    out = []
    i = 0
    n = len(lines)
    while i < n:
        m = DECL.match(lines[i])
        if not m:
            i += 1
            continue
        kind = m.group(1)
        doc = ''
        j = i - 1
        # skip attribute / `omit … in` lines between the docstring and the keyword
        while j >= 0 and (lines[j].startswith('@[') or lines[j].startswith('omit ')):
            j -= 1
        if j >= 0 and lines[j].rstrip().endswith('-/'):
            k = j
            while k >= 0 and '/--' not in lines[k]:
                k -= 1
            if k >= 0:
                doc = '\n'.join(lines[k:j + 1])
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


def base_text(base, path):
    return subprocess.run(['git', 'show', f'{base}:{path}'], capture_output=True, text=True, check=True).stdout


def check(base, path, new_text=None):
    """Returns (number of base declarations, failures, extensions)."""
    old = base_text(base, path)
    new = open(path).read() if new_text is None else new_text
    bad, ext = [], []
    cs = chunks(old)
    for kind, name, doc, stmt in cs:
        if stmt not in new:
            bad.append((kind, name, 'statement'))
            continue
        if doc and doc not in new:
            stem = doc.rstrip()
            assert stem.endswith('-/')
            stem = stem[:-2].rstrip()
            # extended: the base docstring's text, then more text, immediately followed by this very statement
            pos = new.find(stem)
            if pos >= 0:
                close = new.find('-/', pos + len(stem))
                after = new[close + 2:].lstrip('\n') if close >= 0 else ''
                if close >= 0 and after.startswith(stmt) and '/--' not in new[pos + 3:close]:
                    ext.append((kind, name, new[pos + len(stem):close].strip()))
                    continue
            bad.append((kind, name, 'docstring'))
    return len(cs), bad, ext


def self_test(base, path):
    text = open(path).read()
    n, bad, _ = check(base, path)
    if bad:
        print('SELF-TEST: the unplanted file already fails; cannot run the controls')
        return 2
    cs = chunks(base_text(base, path))
    ths = [c for c in cs if c[0] in ('theorem', 'lemma')]
    results = []
    # fault 1 (must fire): one character of a theorem's statement changed
    kind, name, doc, stmt = ths[len(ths) // 2]
    planted = text.replace(stmt, stmt[:-1] + ('x' if stmt[-1] != 'x' else 'y'), 1)
    assert planted != text
    _, b, _ = check(base, path, planted)
    results.append((f'theorem statement fault on `{name}`', any(x[1] == name and x[2] == 'statement' for x in b), True))
    # fault 2 (must fire): a definition's body changed
    ds = [c for c in cs if c[0] in ('def', 'abbrev', 'structure')]
    if ds:
        dname, dstmt = ds[0][1], ds[0][3]
        planted = text.replace(dstmt, dstmt[:-2], 1)
        assert planted != text
        _, b, _ = check(base, path, planted)
        results.append((f'definition fault on `{dname}`', any(x[1] == dname for x in b), True))
    else:
        print(f'SELF-TEST {path}: definition fault NOT RUN (the base file declares no definition)')
    # fault 3 (must fire): a docstring changed in its middle
    docd = [c for c in ths if len(c[2]) > 40]
    kind, name, doc, stmt = docd[0]
    mid = len(doc) // 2
    planted = text.replace(doc, doc[:mid] + 'ZZ' + doc[mid:], 1)
    assert planted != text
    _, b, _ = check(base, path, planted)
    results.append((f'docstring fault on `{name}`', any(x[1] == name and x[2] == 'docstring' for x in b), True))
    # partner (must pass, listed as EXTENDED): the same docstring extended at its end
    stem = doc.rstrip()[:-2].rstrip()
    planted = text.replace(doc, stem + ' An added sentence. -/', 1)
    assert planted != text
    _, b, e = check(base, path, planted)
    results.append((f'docstring extension on `{name}` (partner)',
                    (not b) and any(x[1] == name for x in e), True))
    ok = True
    for what, fired, want in results:
        good = fired == want
        ok = ok and good
        print(f'SELF-TEST {path}: {what}: ' + ('as required' if good else 'WRONG — the control did not behave'))
    return 0 if ok else 1


def main():
    args = sys.argv[1:]
    if args and args[0] == '--self-test':
        return self_test(args[1], args[2])
    base, files = args[0], args[1:]
    rc = 0
    for path in files:
        n, bad, ext = check(base, path)
        for kind, name, what in bad:
            rc = 1
            print(f'CHANGED {path}: {kind} {name} ({what})')
        for kind, name, added in ext:
            print(f'EXTENDED {path}: {kind} {name} — docstring gains: {added}')
        print(f'{path}: {n} base declarations, {n - len(set(b[1] for b in bad))} with statement and docstring kept, '
              f'{len(ext)} docstring(s) extended, {len(bad)} flagged')
    print('STATEMENTS: ' + ('PASS' if rc == 0 else 'FAIL'))
    return rc


if __name__ == '__main__':
    sys.exit(main())
