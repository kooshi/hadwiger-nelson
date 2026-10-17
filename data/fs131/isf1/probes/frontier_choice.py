"""FS131-ISF1 probe: frontier depths -- per-state subtree work, literal sizes, coefficient sizes."""
import sys
sys.path.insert(0, 'tools')
import importlib.util
spec = importlib.util.spec_from_file_location('g', 'tools/fs131_kfs1_g27.py'); g = importlib.util.module_from_spec(spec); spec.loader.exec_module(g)
b = g.build(5, 10**9)
adj, root, D = b['adj'], b['root'], b['D']
print('D bits', D.bit_length())
maxbits = max(abs(g.tcf(t)).bit_length() for t in root)
print('root max coef bits', maxbits)
for K in (5, 6, 7, 8, 10, 12):
    fr = g.collect(adj, 0, 0, root, K, [])
    works = []
    mb = 0
    for S, L in fr:
        w, lv, worst, ok = g.dfs_cost(adj, K, S, L, D)
        works.append(w)
        for t in L: mb = max(mb, abs(g.tcf(t)).bit_length())
    ent = sum(len(L) for _, L in fr)
    print(f'K={K}: states {len(fr)} entries {ent} maxcoefbits {mb} subtree work total {sum(works)} max {max(works)} top5 {sorted(works)[-5:]}', flush=True)
