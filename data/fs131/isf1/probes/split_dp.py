"""FS131-ISF1 probe: choose uniform-depth splits by dynamic programming to minimise literal data."""
import sys, importlib.util
spec = importlib.util.spec_from_file_location('g', 'tools/fs131_kfs1_g27.py'); g = importlib.util.module_from_spec(spec); spec.loader.exec_module(g)
b = g.build(1, 10**9)
adj, root, D = b['adj'], b['root'], b['D']
N = 27
sys.setrecursionlimit(100000)
# the whole tree: node id -> (k, len, children ids)
nodes = []
def build(k, S, L):
    i = len(nodes); nodes.append([k, len(L), []])
    if k < N:
        bit = 1 << k; a = adj[k]
        nodes[i][2].append(build(k + 1, S, g.step_out(bit, L)))
        if a & S == 0:
            nodes[i][2].append(build(k + 1, S | bit, g.step_in(bit, a, L)))
    return i
build(0, 0, root)
print('nodes', len(nodes), flush=True)
work = [0] * len(nodes)
for i in range(len(nodes) - 1, -1, -1):
    work[i] = nodes[i][1] + sum(work[c] for c in nodes[i][2])
print('total work', work[0])
def level(i, d):
    """descendants of i at depth d, and the work of the nodes strictly above d"""
    out, pw, st = [], 0, [i]
    while st:
        j = st.pop()
        if nodes[j][0] == d: out.append(j); continue
        pw += nodes[j][1]; st.extend(nodes[j][2])
    return out, pw
WLEAF, WSPLIT = int(sys.argv[1]), int(sys.argv[2])
memo = {}
def best(i):
    if i in memo: return memo[i]
    if work[i] <= WLEAF:
        memo[i] = (nodes[i][1], None); return memo[i]
    k = nodes[i][0]; opt = None
    for d in range(k + 1, N + 1):
        kids, pw = level(i, d)
        if pw > WSPLIT: break
        cost = nodes[i][1] + sum(best(c)[0] for c in kids)
        if opt is None or cost < opt[0]: opt = (cost, d)
    if opt is None: raise SystemExit('no split')
    memo[i] = opt; return opt
tot, d0 = best(0)
splits = [i for i in memo if memo[i][1] is not None]
leafs = []
def walk(i):
    if memo[i][1] is None: leafs.append(i); return
    for c in level(i, memo[i][1])[0]: walk(c)
walk(0)
print(f'WLEAF {WLEAF} WSPLIT {WSPLIT}: literal entries {tot}; splits {len(splits)} '
      f'{sorted((nodes[i][0], memo[i][1], level(i, memo[i][1])[1]) for i in splits)}; leaf states {len(leafs)}, '
      f'leaf work {sum(work[i] for i in leafs)}, leaf literal {sum(nodes[i][1] for i in leafs)}', flush=True)
