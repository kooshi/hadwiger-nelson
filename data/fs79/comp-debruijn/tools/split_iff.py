"""Empirical check of the converse of C1 on every S+ subset of a small box: split (some s not joined to -s) <=> extra > 0 ?"""
import itertools, collections
from heights_edge import analyse, sym
box = [(a, b) for a in range(0, 3) for b in range(-2, 3) if (a, b) > (0, 0)]
tally = collections.Counter(); examples = {}
for k in (2, 3, 4):
    for G in itertools.combinations(box, k):
        r = analyse(sym(G))
        key = (not r['every_s_joined_to_minus_s'], r['extra'])
        tally[key] += 1
        examples.setdefault(key, G)
for k, v in sorted(tally.items()):
    print('split' if k[0] else 'joined', 'extra', k[1], ':', v, 'e.g.', examples[k])
