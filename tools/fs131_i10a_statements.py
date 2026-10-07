#!/usr/bin/env python3
"""FS131-I10A: statement check. Every declaration of the base commit's version of a Lean file must appear in the
working tree's version with its statement unchanged: for a theorem, the text from its keyword to the first ` :=`;
for anything else (def, abbrev, structure, instance), the whole declaration, body included. Docstrings are compared too
(the text between the `/--` that precedes the declaration and the keyword), since a docstring is the statement's reading.

usage: fs131_i10a_statements.py <base-commit> <file> [<file> ...]      exit 0 = every base statement present verbatim
       fs131_i10a_statements.py --self-test <base-commit> <file>       plants a fault and requires the check to fire
"""
import re, subprocess, sys

DECL = re.compile(r'^(?:@\[[^\]]*\]\s*)*(?:private |protected |noncomputable )*(theorem|def|abbrev|structure|instance|lemma|class|inductive)\b')

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
        # docstring: scan back for a `/--` block ending right before line i
        doc = ''
        j = i - 1
        if j >= 0 and lines[j].rstrip().endswith('-/'):
            k = j
            while k >= 0 and '/--' not in lines[k]:
                k -= 1
            if k >= 0:
                doc = '\n'.join(lines[k:j + 1])
        # body: until the next blank line that is followed by a non-indented line, or EOF
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

def check(base, path, new_text=None):
    old = subprocess.run(['git', 'show', f'{base}:{path}'], capture_output=True, text=True, check=True).stdout
    new = open(path).read() if new_text is None else new_text
    bad = []
    cs = chunks(old)
    for kind, name, doc, stmt in cs:
        if stmt not in new:
            bad.append((kind, name, 'statement'))
        elif doc and doc not in new:
            bad.append((kind, name, 'docstring'))
    return len(cs), bad

def main():
    args = sys.argv[1:]
    if args and args[0] == '--self-test':
        base, path = args[1], args[2]
        text = open(path).read()
        n, bad = check(base, path)
        if bad:
            print('SELF-TEST: the unplanted file already fails; cannot run the control'); return 2
        old = subprocess.run(['git', 'show', f'{base}:{path}'], capture_output=True, text=True, check=True).stdout
        cs = [c for c in chunks(old) if c[0] == 'theorem']
        kind, name, doc, stmt = cs[len(cs) // 2]
        # fault 1: weaken a theorem's statement by one token (drop its last hypothesis-or-conclusion character run)
        planted = text.replace(stmt, stmt[:-1] + ('x' if stmt[-1] != 'x' else 'y'), 1)
        n1, bad1 = check(base, path, planted)
        # fault 2: delete a definition's body line
        ds = [c for c in chunks(old) if c[0] in ('def', 'abbrev', 'structure')]
        ok2 = True
        if ds:
            dstmt = ds[0][3]
            planted2 = text.replace(dstmt, dstmt.rsplit('\n', 1)[0] if '\n' in dstmt else dstmt[:-2], 1)
            n2, bad2 = check(base, path, planted2)
            ok2 = any(b[1] == ds[0][1] for b in bad2)
        ok1 = any(b[1] == name for b in bad1)
        print(f'SELF-TEST {path}: theorem fault on `{name}` ' + ('FIRED' if ok1 else 'SILENT') +
              '; definition fault ' + ('FIRED' if ok2 else 'SILENT'))
        return 0 if (ok1 and ok2) else 1
    base, files = args[0], args[1:]
    rc = 0
    for path in files:
        n, bad = check(base, path)
        if bad:
            rc = 1
            for kind, name, what in bad:
                print(f'CHANGED {path}: {kind} {name} ({what})')
        print(f'{path}: {n} base declarations, {n - len(set(b[1] for b in bad))} unchanged, {len(bad)} flagged')
    print('STATEMENTS: ' + ('PASS' if rc == 0 else 'FAIL'))
    return rc

if __name__ == '__main__':
    sys.exit(main())
