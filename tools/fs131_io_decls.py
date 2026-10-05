#!/usr/bin/env python3
"""FS131-IO2: list the full names of the theorems a Lean file declares (tracking `namespace`/`section`/`end` and `_root_`), optionally only
those absent from a baseline revision of the same file. Iteration aid for the axioms print; never evidence. Exit 2 when no declaration is
found (a parse that sees nothing must not read as an empty list)."""
import re, subprocess, sys

def names(text):
    stack, out = [], []
    for line in text.split('\n'):
        m = re.match(r'^namespace\s+(\S+)', line)
        if m:
            stack.append(('ns', m.group(1))); continue
        m = re.match(r'^section\b\s*(\S*)', line)
        if m:
            stack.append(('sec', m.group(1))); continue
        m = re.match(r'^end\b\s*(\S*)', line)
        if m and stack:
            stack.pop(); continue
        m = re.match(r'^(?:private\s+|protected\s+)?theorem\s+(\S+)', line)
        if m:
            n = m.group(1)
            if n.startswith('_root_.'):
                out.append(n[len('_root_.'):])
            else:
                prefix = '.'.join(x for k, x in stack if k == 'ns')
                out.append(prefix + '.' + n if prefix else n)
    return out

path = sys.argv[1]
cur = names(open(path).read())
if len(sys.argv) > 2:
    base = names(subprocess.run(['git', 'show', f'{sys.argv[2]}:{path}'], capture_output=True, text=True, check=True).stdout)
    cur = [n for n in cur if n not in set(base)]
if not cur:
    print('no declarations found', file=sys.stderr); sys.exit(2)
print('\n'.join(cur))
