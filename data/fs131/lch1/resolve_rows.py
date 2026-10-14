#!/usr/bin/env python3
"""FS131-LCH1: resolve ARCHITECTURE.md's one conflict hunk at a merge of an M13 line: the chain's rows kept, the incoming
line's rows taken for the modules that line owns (argv[1:], e.g. Rigidity/ClassRatio). Prints its decision."""
import sys
own = sys.argv[1:]
p = 'ARCHITECTURE.md'
L = open(p, encoding='utf-8').read().split('\n')
starts = [i for i, l in enumerate(L) if l.startswith('<<<<<<< ')]
assert len(starts) == 1, len(starts)
i = starts[0]; j = L.index('=======', i); k = next(n for n in range(j, len(L)) if L[n].startswith('>>>>>>> '))
ours, theirs = L[i+1:j], L[j+1:k]
def mod(l): return l.split('`')[1] if l.startswith('| `') else None
th = {mod(l): l for l in theirs}
keep, took = [], []
for l in ours:
    m = mod(l)
    if m in own and m in th: keep.append(th[m]); took.append(m)
    else: keep.append(l)
for m, l in th.items():
    if m in own and m not in took and m not in {mod(x) for x in ours}: keep.append(l); took.append(m)
print(f'ARCHITECTURE.md hunk: ours {len(ours)} rows, theirs {len(theirs)}; kept ours, took theirs for {took}')
L = L[:i] + keep + L[k+1:]
assert not any(l.startswith(('<<<<<<< ', '>>>>>>> ')) for l in L)
open(p, 'w', encoding='utf-8').write('\n'.join(L))
