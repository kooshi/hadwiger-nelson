#!/usr/bin/env python3
"""FS131-RW2's statement check: a declaration's statement (its docstring excluded; from its keyword line to the first `:=`
that ends the signature) must be byte-identical between a base git revision and the working tree.

usage: tools/fs131_rw_stmt_check.py <base-rev> <file>:<decl> [<file>:<decl> ...]
Prints one line per declaration (SAME / CHANGED / MISSING) and exits 1 unless every one is SAME. A declaration missing on
either side fails loudly: a check that could not run must never read as a pass.
"""
import re
import subprocess
import sys


def statement(text: str, decl: str):
    pat = re.compile(r'^(?:private |protected |noncomputable )*(?:theorem|lemma|def|structure|abbrev) ' + re.escape(decl) + r'[\s({\[:]',
                     re.M)
    ms = list(pat.finditer(text))
    if len(ms) != 1:
        return None
    start = ms[0].start()
    # the signature ends at the first `:=` or ` where` at bracket depth 0
    depth = 0
    i = start
    while i < len(text):
        c = text[i]
        if c in '([{⟨':
            depth += 1
        elif c in ')]}⟩':
            depth -= 1
        elif depth == 0 and text.startswith(':=', i):
            return text[start:i]
        elif depth == 0 and text.startswith(' where', i) and text[start:].startswith('structure'):
            return text[start:i]
        i += 1
    return None


def main() -> int:
    if len(sys.argv) < 3:
        print(__doc__)
        return 2
    base = sys.argv[1]
    ok = True
    for spec in sys.argv[2:]:
        path, decl = spec.rsplit(':', 1)
        try:
            old = subprocess.run(['git', 'show', f'{base}:{path}'], check=True, capture_output=True, text=True).stdout
        except subprocess.CalledProcessError as e:
            print(f'MISSING {spec}: git show {base}:{path} failed: {e.stderr.strip()}')
            ok = False
            continue
        new = open(path, encoding='utf-8').read()
        so, sn = statement(old, decl), statement(new, decl)
        if so is None or sn is None:
            print(f'MISSING {spec}: base={"found" if so else "absent/ambiguous"} tree={"found" if sn else "absent/ambiguous"}')
            ok = False
        elif so == sn:
            print(f'SAME    {spec} ({len(sn)} bytes)')
        else:
            print(f'CHANGED {spec}')
            ok = False
    print('PASS' if ok else 'FAIL')
    return 0 if ok else 1


if __name__ == '__main__':
    sys.exit(main())
