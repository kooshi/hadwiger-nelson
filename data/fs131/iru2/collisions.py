#!/usr/bin/env python3
"""FS131-IRU2: names two compiled libraries declare in different modules (LEAN.md l. 363, after FS131-LDB1).
Input: two files of 'Module name' lines (lean/AllNames.lean's print of each line's build). A name declared by two different
modules across the two lines is a collision the join would make. Also prints, per side, the modules the other side lacks.
Usage: python3 -I collisions.py <branch-names> <main-names> [--plant]
--plant: adds to the branch side a constant of main's newest module under another module name; it must be reported."""
import gzip, sys
args = [a for a in sys.argv[1:] if a != '--plant']; plant = '--plant' in sys.argv
def load(p):
    d = {}
    for ln in (gzip.open(p, 'rt') if p.endswith('.gz') else open(p)):
        m, n = ln.rstrip('\n').split(' ', 1); d.setdefault(n, set()).add(m)
    return d
b, m = load(args[0]), load(args[1])
if plant:
    victim = next(n for n, ms in m.items() if 'Proofs.HadwigerNelson.Collapse.Density.Headline' in ms and n not in b)
    b.setdefault(victim, set()).add('Proofs.HadwigerNelson.Rigidity.UsablePrime'); print('PLANT', victim)
dup_in_side = [(n, s) for d, s in ((b, 'branch'), (m, 'main')) for n, ms in d.items() if len(ms) > 1]
for n, s in dup_in_side: print('WITHIN', s, n, sorted(d for d in (b if s == 'branch' else m)[n]))
coll = sorted(n for n in b.keys() & m.keys() if b[n] != m[n])
for n in coll: print('COLLISION', n, 'branch:', sorted(b[n]), 'main:', sorted(m[n]))
bm = {x for ms in b.values() for x in ms}; mm = {x for ms in m.values() for x in ms}
print('modules only on the branch:', sorted(bm - mm)); print('modules only on main:', sorted(mm - bm))
print(f'names: branch {len(b)}, main {len(m)}, both {len(b.keys() & m.keys())}; collisions {len(coll)}; within-side {len(dup_in_side)}')
sys.exit(1 if coll else 0)
