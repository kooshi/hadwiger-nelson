#!/usr/bin/env python3
"""FS131-IRU2 (a copy of FS131-IFR2's): the transitive dependents (within Proofs) of the given modules, by parsing `import` lines.
Usage: python3 -I cone.py <repo-root> <Module.Name> ...   (prints the cone's size and members)"""
import pathlib, re, sys
root = pathlib.Path(sys.argv[1]); targets = sys.argv[2:]
imports = {}
for p in list((root / 'Proofs').rglob('*.lean')) + [root / 'Proofs.lean']:
    mod = '.'.join(p.relative_to(root).with_suffix('').parts)
    imps = []
    for line in p.read_text().splitlines():
        m = re.match(r'^\s*(?:public\s+)?import\s+(\S+)', line)
        if m: imps.append(m.group(1))
    imports[mod] = imps
rev = {}
for m, imps in imports.items():
    for i in imps: rev.setdefault(i, set()).add(m)
seen, stack = set(), list(targets)
while stack:
    x = stack.pop()
    for d in rev.get(x, ()):
        if d not in seen: seen.add(d); stack.append(d)
print(len(seen), 'dependents of', targets, 'of', len(imports), 'modules')
for m in sorted(seen): print(' ', m)
