"""FS131-ISF1 probe: an adaptive split tree for the residual DFS (literal states, declarations of bounded work)."""
import sys, importlib.util
spec = importlib.util.spec_from_file_location('g', 'tools/fs131_kfs1_g27.py'); g = importlib.util.module_from_spec(spec); spec.loader.exec_module(g)
b = g.build(1, 10**9)
adj, root, D = b['adj'], b['root'], b['D']
N = 27
WLEAF = int(sys.argv[1]); WSPLIT = int(sys.argv[2])
memo = {}
def subtree(k, S, L):
    w, lv, worst, ok = g.dfs_cost(adj, k, S, L, D)
    assert ok
    return w
def prefix_work(k, S, L, d):
    """work of the nodes at depths k..d-1 below (k,S,L) and the states at depth d"""
    work = 0; out = []
    stack = [(k, S, L)]
    while stack:
        kk, SS, LL = stack.pop()
        if kk == d: out.append((kk, SS, LL)); continue
        work += len(LL)
        bit = 1 << kk; a = adj[kk]
        if a & SS == 0: stack.append((kk + 1, SS | bit, g.step_in(bit, a, LL)))
        stack.append((kk + 1, SS, g.step_out(bit, LL)))
    return work, out[::-1]
splits = []   # (depth, d', work, nchildren, literal entries of the node)
leaves = []
def node(k, S, L):
    w = subtree(k, S, L)
    if w <= WLEAF:
        leaves.append((k, S, L, w)); return
    # deepest d' with prefix work <= WSPLIT
    best = None
    for d in range(k + 1, N + 1):
        pw, kids = prefix_work(k, S, L, d)
        if pw > WSPLIT: break
        best = (d, pw, kids)
    if best is None:
        raise SystemExit(f'cannot split node at depth {k} with |L|={len(L)}')
    d, pw, kids = best
    splits.append((k, d, pw, len(kids), len(L)))
    for kk, SS, LL in kids:
        node(kk, SS, LL)
node(0, 0, root)
lit_split = sum(s[4] for s in splits)
lit_leaf = sum(len(l[2]) for l in leaves)
print(f'WLEAF {WLEAF} WSPLIT {WSPLIT}: splits {len(splits)} (work {sum(s[2] for s in splits)}, max {max(s[2] for s in splits)}), '
      f'leaves {len(leaves)} (work {sum(l[3] for l in leaves)}, max {max(l[3] for l in leaves)}), '
      f'literal entries: split nodes {lit_split} (incl. root {len(root)}), leaf states {lit_leaf}, total {lit_split + lit_leaf}')
print('split depths', [(s[0], s[1], s[2], s[3]) for s in splits][:40])
