import itertools, collections, random
from heights_edge import sym, neg, sub, analyse
def comps(S):
    Sset = set(S); Sl = sorted(Sset); idx = {s:k for k,s in enumerate(Sl)}; par = list(range(len(Sl)))
    def f(x):
        while par[x] != x: par[x] = par[par[x]]; x = par[x]
        return x
    for s, t in itertools.combinations(Sl, 2):
        if t != neg(s) and sub(s, t) not in Sset: par[f(idx[s])] = f(idx[t])
    cs = collections.defaultdict(set)
    for s in Sl: cs[f(idx[s])].add(s)
    return list(cs.values())
tally = collections.Counter()
random.seed(1)
cases = []
box = [(a, b) for a in range(0, 4) for b in range(-3, 4) if (a, b) > (0, 0)]
for k in (2, 3, 4, 5):
    for G in itertools.combinations(box, k):
        cases.append(G)
box3 = [(a,b,c) for a in range(0,2) for b in range(-1,2) for c in range(-1,2) if (a,b,c) > (0,0,0)]
for k in (3,4,5):
    for G in itertools.combinations(box3, k): cases.append(G)
for G in cases:
    S = sym(G); cs = comps(S)
    withpm = sum(1 for K in cs if any(neg(s) in K for s in K))
    kind = 'connected' if len(cs) == 1 else ('all-pm-free' if withpm == 0 else ('mixed' if withpm < len(cs) else 'all-contain-pm'))
    tally[kind] += 1
print(len(cases), dict(tally))
# extra on a sample of each kind
for kind in ('all-pm-free', 'mixed', 'all-contain-pm'):
    for G in cases:
        S = sym(G); cs = comps(S)
        withpm = sum(1 for K in cs if any(neg(s) in K for s in K))
        k2 = 'connected' if len(cs) == 1 else ('all-pm-free' if withpm == 0 else ('mixed' if withpm < len(cs) else 'all-contain-pm'))
        if k2 == kind:
            print(kind, G, analyse(S)['extra'], [len(K) for K in cs]); break
# component counts and extra for every split case
cc = collections.Counter()
for G in cases:
    S = sym(G); cs = comps(S)
    if len(cs) > 1:
        cc[(len(cs), analyse(S)['extra'])] += 1
print('split cases by (components, extra):', dict(cc))
