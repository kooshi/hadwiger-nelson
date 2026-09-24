"""Kind 1_edge at k colours: nullity mod p of the square system versus the trivial dimension (k - 1) + n."""
import itertools, sys
from heights_edge import RowReducer, canon_gens, add, sub, sym
def analyse_k(S, k):
    gens = canon_gens(S); n = len(gens); Sset = set(S)
    pairs = [(a, b) for a in range(k) for b in range(k) if a != b]; pidx = {p: i for i, p in enumerate(pairs)}
    npair = len(pairs)
    var = lambda i, a, b: npair * i + pidx[(a, b)]
    rr = RowReducer(npair * n)
    for i, j in itertools.combinations(range(n), 2):
        s, t = gens[i], gens[j]; d02 = add(s, t) in Sset; d13 = sub(s, t) in Sset
        for c in itertools.product(range(k), repeat=4):
            c0, c1, c2, c3 = c
            if c0 == c1 or c1 == c2 or c2 == c3 or c3 == c0: continue
            if d02 and c0 == c2: continue
            if d13 and c1 == c3: continue
            row = {}
            for key, val in ((var(i, c0, c1), 1), (var(j, c1, c2), 1), (var(i, c3, c2), -1), (var(j, c0, c3), -1)):
                row[key] = row.get(key, 0) + val
            rr.add(row)
    return npair * n - rr.rank() - (k - 1) - n
for k in (3, 4, 5, 6):
    out = []
    for name, G in (('grid', [(1,0),(0,1)]), ('tri', [(1,0),(0,1),(1,1)]), ('tri+(2,-1)', [(1,0),(0,1),(1,1),(2,-1)]),
                    ('{1,2}', [(1,),(2,)]), ('{1,2,3}', [(1,),(2,),(3,)]), ('{1,3,7}', [(1,),(3,),(7,)])):
        out.append((name, analyse_k(sym(G), k)))
    print('k =', k, 'extra (nullity - trivial):', out)
