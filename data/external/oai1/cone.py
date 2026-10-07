#!/usr/bin/env python3
"""EXT-OAI1 stage 3: the import cone of a module of the release's Lean library, from `import` lines.

usage: cone.py <lean-root> <Module.Name> [--json out.json]
Reads only.  A module `A.B.C` is looked up as <lean-root>/A/B/C.lean; an import that
resolves to no file under <lean-root> is an *outside* import (Mathlib, core, a
dependency package) and is listed by name, not followed.
Import lines are parsed from the file's header: everything before the first line that
is neither blank, a comment, `module`, nor an (optionally `public`/`meta`/`private`) `import`.
"""
import sys, re, json, pathlib
root = pathlib.Path(sys.argv[1]); start = sys.argv[2]
IMPORT = re.compile(r'^\s*(?:(?:public|private|meta)\s+)*import\s+(?:all\s+)?(.+?)\s*$')
def header_imports(path):
    out, in_block = [], False
    all_import_lines_anywhere = []
    lines = path.read_text().splitlines()
    header_done = False
    for n, line in enumerate(lines, 1):
        s = line.strip()
        m = IMPORT.match(line)
        if m: all_import_lines_anywhere.append(n)
        if header_done: continue
        if in_block:
            if '-/' in s: in_block = False
            continue
        if s.startswith('/-'):
            if '-/' not in s: in_block = True
            continue
        if s == '' or s.startswith('--') or s == 'module' or s.startswith('prelude'): continue
        if m:
            for name in m.group(1).split():
                out.append(name)
            continue
        header_done = True
    return out, all_import_lines_anywhere
def file_of(mod): return root / (mod.replace('.', '/') + '.lean')
seen, outside, order, edges = {}, {}, [], {}
stack = [start]
while stack:
    m = stack.pop()
    if m in seen: continue
    f = file_of(m)
    if not f.is_file():
        outside.setdefault(m, 0); continue
    imps, anywhere = header_imports(f)
    seen[m] = (str(f.relative_to(root)), len(f.read_text().splitlines()), len(anywhere), len(imps))
    edges[m] = imps
    for i in imps:
        if file_of(i).is_file(): stack.append(i)
        else: outside[i] = outside.get(i, 0) + 1
inside = sorted(seen)
print(f"cone of {start}: modules={len(inside)} lines={sum(v[1] for v in seen.values())} outside-imports={len(outside)}")
for m in inside:
    f, n, anywhere, k = seen[m]
    flag = '' if anywhere == k or True else ' IMPORT-LINES-OUTSIDE-HEADER'
    print(f"  {m}  ({n} lines)  imports: {' '.join(edges[m])}")
print("outside imports (not followed):")
for m in sorted(outside): print(f"  {m}  x{outside[m]}")
if '--json' in sys.argv:
    out = sys.argv[sys.argv.index('--json') + 1]
    json.dump({'start': start, 'inside': {m: {'file': seen[m][0], 'lines': seen[m][1], 'imports': edges[m]} for m in inside}, 'outside': sorted(outside)}, open(out, 'w'), indent=1)
