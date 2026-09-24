#!/usr/bin/env python3
"""Rank-1 window-state graph of k-colourings of G(Z, D), modulo colour permutation: its cyclic SCCs (phases), which are rigid (a single
cycle), which are chiral, and which pairs of phases are joined by a wall (a path between distinct cyclic SCCs).  Exact."""
import sys, itertools, collections
sys.setrecursionlimit(100000)

def canon(w):
    m = {}; out = []
    for c in w:
        if c not in m: m[c] = len(m)
        out.append(m[c])
    return tuple(out)

def build(D, k=4):
    m = max(D)
    Ds = sorted(D)
    def ok_ext(w, c):   # w has length m; appending c at position m
        L = len(w)
        return all(w[L - d] != c for d in Ds if d <= L)
    # enumerate proper words of length m (mod perm) by DFS
    states = set()
    def dfs(w):
        if len(w) == m:
            states.add(canon(w)); return
        for c in range(min(k, (max(w) + 2) if w else 1)):
            if ok_ext(w, c): dfs(w + (c,))
    dfs(())
    edges = collections.defaultdict(list)
    for s in states:
        for c in range(k):
            if ok_ext(s, c):
                t = canon(s[1:] + (c,))
                edges[s].append(t)
    return states, edges

def sccs(states, edges):
    index = {}; low = {}; on = set(); st = []; out = []; idx = [0]
    for v0 in states:
        if v0 in index: continue
        stack = [(v0, iter(edges[v0]))]
        index[v0] = low[v0] = idx[0]; idx[0] += 1; st.append(v0); on.add(v0)
        while stack:
            v, it = stack[-1]
            for w in it:
                if w not in index:
                    index[w] = low[w] = idx[0]; idx[0] += 1; st.append(w); on.add(w)
                    stack.append((w, iter(edges[w]))); break
                elif w in on:
                    low[v] = min(low[v], index[w])
            else:
                stack.pop()
                if stack:
                    low[stack[-1][0]] = min(low[stack[-1][0]], low[v])
                if low[v] == index[v]:
                    comp = []
                    while True:
                        w = st.pop(); on.discard(w); comp.append(w)
                        if w == v: break
                    out.append(comp)
    return out

def analyse(D, k=4):
    states, edges = build(D, k)
    comps = sccs(states, edges)
    cid = {}
    for i, c in enumerate(comps):
        for v in c: cid[v] = i
    cyclic = []
    for i, c in enumerate(comps):
        cs = set(c)
        inner = sum(1 for v in c for w in edges[v] if w in cs)
        if inner == 0: continue       # transient single node
        rigid = all(sum(1 for w in edges[v] if w in cs) == 1 for v in c)
        cyclic.append((i, rigid, len(c)))
    # reachability between cyclic components through the condensation
    cadj = collections.defaultdict(set)
    for v in states:
        for w in edges[v]:
            if cid[v] != cid[w]: cadj[cid[v]].add(cid[w])
    cyc_ids = {i for i, _, _ in cyclic}
    walls = []
    for i in cyc_ids:
        seen = {i}; fr = [i]
        while fr:
            x = fr.pop()
            for y in cadj[x]:
                if y not in seen:
                    seen.add(y); fr.append(y)
        for j in cyc_ids:
            if j != i and j in seen: walls.append((i, j))
    # chirality of rigid phases: the periodic word; reversed word canonical-equal to a rotation?
    info = {}
    for i, rigid, size in cyclic:
        if not rigid: info[i] = dict(rigid=False, size=size); continue
        v0 = comps[i][0]; cs = set(comps[i])
        word = []; v = v0
        for _ in range(size):
            nxt = [w for w in edges[v] if w in cs][0]
            word.append(nxt[-1]); v = nxt
        # actual colouring period: iterate the colour-level walk until colours repeat exactly
        # chirality test on a long window: reversed colouring vs all shifts of forward colouring, mod relabelling
        m = max(D)
        # reconstruct a genuine colouring: start with v0 (canonical) and extend with the SCC's successors choosing actual colours
        seq = list(v0)
        vv = v0
        for _ in range(8 * size * 24 + 3 * m):
            nxt = [w for w in edges[vv] if w in cs][0]
            # the new colour: the canonical form tells equality pattern with the last m colours
            window = seq[-m:]
            last = nxt[-1]
            # find actual colour c with canon(window[1:]+[c]) == nxt
            cands = [c for c in range(4) if all(window[m - d] != c for d in D) and canon(tuple(window[1:]) + (c,)) == nxt]
            assert len(cands) == 1, ('reconstruction ambiguous or empty', cands)
            for c in cands:
                if True:
                    seq.append(c); break
            vv = nxt
        seq = seq[3 * m:]
        # least period of seq
        P = next(p for p in range(1, len(seq) // 2) if all(seq[t] == seq[t + p] for t in range(len(seq) - p)))
        fwd = seq[:P]
        rev = fwd[::-1]
        achiral = any(canon(tuple((rev[(t + r) % P] for t in range(P)))) == canon(tuple(fwd)) for r in range(P))
        info[i] = dict(rigid=True, size=size, period=P, word=''.join(map(str, fwd)), achiral=achiral)
    return dict(D=D, states=len(states), cyclic=len(cyclic), rigid=sum(1 for _, r, _ in cyclic if r),
                walls=len(walls), wall_pairs=[(info[i], info[j]) for i, j in walls][:6],
                phases=[info[i] for i, _, _ in cyclic][:12])

if __name__ == '__main__':
    for D in ([1, 5, 7, 10], [3, 5, 9, 10], [3, 7, 9, 10], [5, 7, 9, 10], [1, 2, 3], [1, 3, 4, 5]):
        r = analyse(D)
        print(r['D'], 'states', r['states'], 'cyclic SCCs', r['cyclic'], 'rigid', r['rigid'], 'walls', r['walls'])
        for w in r['wall_pairs'][:4]:
            print('   wall', w)
        rp = [p for p in r['phases'] if p['rigid']]
        print('   rigid phases:', rp[:6])
