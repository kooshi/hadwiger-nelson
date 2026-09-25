import json, sys, subprocess
name, S = sys.argv[1], sys.argv[2]
info = json.load(open(f'{S}/units-{name}.json'))
pos = info['pos']
N = len(pos)
M = '[' + ';'.join(','.join(str(pos[j][i]) for j in range(N)) for i in range(4)) + ']'
gp = f'K = matkerint({M}); print(matsize(K)); for(j=1,#K, print(Vec(K[,j])))\n'
out = subprocess.run(['gp', '-q', '-f'], input=gp, capture_output=True, text=True).stdout.split('\n')
print(out[0])
rels = [json.loads(l.replace(' ', '')) for l in out[1:] if l.strip()]
for r in rels:
    assert all(sum(r[j]*pos[j][i] for j in range(N)) == 0 for i in range(4))
l1 = sorted(sum(map(abs, r)) for r in rels)
print('relation basis l1 norms:', l1)
json.dump(rels, open(f'{S}/rels-{name}.json', 'w'))
