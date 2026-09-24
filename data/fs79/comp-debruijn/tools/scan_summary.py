import json, collections, sys
rows=[json.loads(l) for l in open(sys.argv[1])]
c=collections.Counter()
for r in rows:
    if r['cyclic']==0: c['not 4-col']+=1
    elif r['rigid']==r['cyclic']: c['all rigid, walls>0' if r['walls'] else 'all rigid, no wall']+=1
    elif r['walls']>0: c['walls with entropy']+=1
    else: c['entropy, no wall']+=1
print(len(rows), 'max m so far', max(r['D'][-1] for r in rows), dict(c))
print('counterexamples:', [r['D'] for r in rows if r['counterexample']][:20])
