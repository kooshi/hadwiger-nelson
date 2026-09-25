#!/usr/bin/env python3
"""J18 (crunch 2026-09-25): the rank-one window-state graph of k-colourings of G(Z, D), labelled quotient by colour permutations
(one edge per extending colour of the canonical word, as FS-79's tool and T35/T36), its phases (cyclic SCCs), which are rigid,
which rigid phases are chiral, and walls (paths between distinct cyclic SCCs).  Independent of data/fs79/comp-debruijn/tools.

For a wall between two RIGID phases it reconstructs an actual heteroclinic colouring c (periodic on both sides), re-checks its
properness from the definition, and lists the two-colour Kempe components of c by type (left-infinite only, right-infinite only,
through, finite), swapping each one-sided infinite component and reading which phase the swapped tail lies in.

Exact; no search beyond the complete enumeration of proper m-words of ONE given D.  Usage:
    crunch_j18_phases.py D1,D2,...            analyse one D
    crunch_j18_phases.py --controls           the controls: {1} (not rigid), {1,2,3} (rigid, no wall), {1,5,7,10} (walls)
    crunch_j18_phases.py --plant              the planted faults; each must be seen to fire (exit 0 only if all fire)
"""
import sys, collections, itertools

PLANT = set()   # names of planted faults active in this process


def canon(w):
    m = {}
    out = []
    for c in w:
        if c not in m:
            m[c] = len(m)
        out.append(m[c])
    return tuple(out)


def ok_ext(w, c, D):
    L = len(w)
    for d in D:
        if 'drop-max' in PLANT and d == max(D):
            continue
        if d <= L and w[L - d] == c:
            return False
    return True


def build(D, k):
    m = max(D)
    states = set()
    stack = [()]
    while stack:
        w = stack.pop()
        if len(w) == m:
            states.add(w)
            continue
        top = (max(w) + 2) if w else 1
        for c in range(min(k, top)):
            if ok_ext(w, c, D):
                stack.append(w + (c,))
    edges = {}
    for s in states:
        lst = []
        for c in range(k):
            if ok_ext(s, c, D):
                lst.append((c, canon(s[1:] + (c,))))
        edges[s] = lst
    return states, edges


def tarjan(states, edges):
    index, low, on, st, comps = {}, {}, set(), [], []
    counter = 0
    for v0 in states:
        if v0 in index:
            continue
        index[v0] = low[v0] = counter; counter += 1
        st.append(v0); on.add(v0)
        work = [(v0, iter(edges[v0]))]
        while work:
            v, it = work[-1]
            advanced = False
            for _, w in it:
                if w not in index:
                    index[w] = low[w] = counter; counter += 1
                    st.append(w); on.add(w)
                    work.append((w, iter(edges[w])))
                    advanced = True
                    break
                elif w in on:
                    low[v] = min(low[v], index[w])
            if advanced:
                continue
            work.pop()
            if work:
                u = work[-1][0]
                low[u] = min(low[u], low[v])
            if low[v] == index[v]:
                comp = []
                while True:
                    w = st.pop(); on.discard(w); comp.append(w)
                    if w == v:
                        break
                comps.append(comp)
    return comps


def analyse(D, k=4):
    D = sorted(D)
    m = max(D)
    states, edges = build(D, k)
    comps = tarjan(states, edges)
    cid = {v: i for i, c in enumerate(comps) for v in c}
    phases = {}
    for i, c in enumerate(comps):
        cs = set(c)
        indeg = {v: sum(1 for _, w in edges[v] if w in cs) for v in c}
        if sum(indeg.values()) == 0:
            continue
        phases[i] = dict(size=len(c), rigid=all(x == 1 for x in indeg.values()))
    cadj = collections.defaultdict(set)
    for v in states:
        for _, w in edges[v]:
            if cid[v] != cid[w]:
                if 'no-cond' in PLANT:
                    continue
                cadj[cid[v]].add(cid[w])
    reach = {}
    for i in phases:
        seen = {i}; fr = [i]
        while fr:
            x = fr.pop()
            for y in cadj[x]:
                if y not in seen:
                    seen.add(y); fr.append(y)
        reach[i] = seen
    walls = [(i, j) for i in phases for j in phases if j != i and j in reach[i]]
    return dict(D=D, k=k, m=m, states=states, edges=edges, comps=comps, cid=cid, phases=phases, walls=walls, cadj=cadj)


def lift_step(word, label, k):
    """word: actual colours (tuple, length m); label: canonical colour for the next letter.  Return the actual colour."""
    s = canon(word)
    back = {}
    for a, cc in zip(word, s):
        back[cc] = a
    if label in back:
        return back[label]
    unused = [a for a in range(k) if a not in word]
    return unused[0]   # any choice gives a lift; on rigid phases windows carry >= k-1 colours so this is forced


def periodic_colouring(A, i):
    """Actual periodic colouring of rigid phase i: returns (word of one actual period, as a list)."""
    comp = A['comps'][i]; cs = set(comp); edges = A['edges']; k = A['k']; m = A['m']
    v = comp[0]
    seq = list(v)
    cur = v
    for _ in range(len(comp) * 24 * 2 + 2 * m):
        nxt = [(c, w) for c, w in edges[cur] if w in cs]
        assert len(nxt) == 1
        c, w = nxt[0]
        seq.append(lift_step(tuple(seq[-m:]), c, k))
        cur = w
    seq = seq[2 * m:]
    P = next(p for p in range(1, len(seq) // 2) if all(seq[t] == seq[t + p] for t in range(len(seq) - p)))
    return seq[:P]


def chiral(word):
    P = len(word)
    rev = word[::-1]
    return not any(canon(tuple(rev[(t + r) % P] for t in range(P))) == canon(tuple(word)) for r in range(P))


def proper(c, D, lo, hi):
    for x in range(lo, hi):
        for d in D:
            if x + d < hi and c[x] == c[x + d]:
                return False
    return True


def wall_point(A, i, j, reps=6):
    """A heteroclinic colouring from rigid phase i to rigid phase j, as a dict x -> colour on [lo, hi), periodic outside."""
    edges, comps, cid, k, m, D = A['edges'], A['comps'], A['cid'], A['k'], A['m'], A['D']
    # BFS from any vertex of comp i to any vertex of comp j
    src = comps[i]
    target = set(comps[j])
    prev = {}
    fr = collections.deque()
    for v in src:
        prev[v] = None; fr.append(v)
    end = None
    while fr:
        v = fr.popleft()
        if v in target:
            end = v; break
        for c, w in edges[v]:
            if w not in prev:
                prev[w] = (v, c); fr.append(w)
    assert end is not None
    path = []
    v = end
    while prev[v] is not None:
        u, c = prev[v]; path.append(c); v = u
    path.reverse()
    start = v
    # go round comp i backwards is awkward; instead: take the actual periodic colouring through `start`.
    ci = set(comps[i])
    seq = list(start)
    cur = start
    # we lift the path from `start`; the left side is the periodic continuation of start's cycle to the LEFT, built by going
    # forward round the cycle many times first and then taking the path from a later visit of `start`.
    Li = len(comps[i])
    for _ in range(Li * 24 * reps):
        c, w = [(c, w) for c, w in edges[cur] if w in ci][0]
        seq.append(lift_step(tuple(seq[-m:]), c, k)); cur = w
    # cur == start again (as canonical words), after a multiple of Li steps
    assert cur == start
    junction = len(seq)
    for c in path:
        nxt = dict(edges[cur])
        cur = nxt[c] if c in nxt else None
        seq.append(lift_step(tuple(seq[-m:]), c, k))
        cur = canon(tuple(seq[-m:]))
    cj = set(comps[j])
    assert cur in cj
    Lj = len(comps[j])
    for _ in range(Lj * 24 * reps):
        c, w = [(c, w) for c, w in edges[cur] if w in cj][0]
        seq.append(lift_step(tuple(seq[-m:]), c, k)); cur = w
    assert proper(seq, D, 0, len(seq)), 'reconstructed wall point is not proper'
    return seq, junction


def phase_of_window(A, w):
    return A['cid'].get(canon(tuple(w)))


def kempe_report(A, seq, junction):
    """Components of each two-colour subgraph of the finite window seq; 'left'/'right' = touches the first/last 3m positions."""
    D, m, k = A['D'], A['m'], A['k']
    n = len(seq)
    out = []
    for e, f in itertools.combinations(range(k), 2):
        verts = [x for x in range(n) if seq[x] in (e, f)]
        vs = set(verts)
        comp = {}
        for x0 in verts:
            if x0 in comp:
                continue
            comp[x0] = x0
            st = [x0]
            while st:
                x = st.pop()
                for d in D:
                    for y in (x - d, x + d):
                        if y in vs and y not in comp:
                            comp[y] = x0; st.append(y)
        groups = collections.defaultdict(list)
        for x, r in comp.items():
            groups[r].append(x)
        for r, xs in groups.items():
            lo, hi = min(xs), max(xs)
            L = lo < 3 * m
            R = hi >= n - 3 * m
            kind = 'through' if (L and R) else 'left-only' if L else 'right-only' if R else 'finite'
            item = dict(pair=(e, f), kind=kind, span=(lo - junction, hi - junction), size=len(xs))
            if kind in ('left-only', 'right-only', 'finite'):
                sw = list(seq)
                for x in xs:
                    sw[x] = f if seq[x] == e else e
                assert proper(sw, D, 0, n)
                item['left_phase'] = phase_of_window(A, sw[m:2 * m])
                item['right_phase'] = phase_of_window(A, sw[n - 2 * m:n - m])
            out.append(item)
    return out


def summary(A):
    ph = A['phases']
    return dict(D=A['D'], states=len(A['states']), cyclic=len(ph), rigid=sum(1 for p in ph.values() if p['rigid']),
                walls=len(A['walls']))


def controls():
    ok = True
    exp = {(1,): dict(cyclic=1, rigid=0, walls=0), (1, 2, 3): dict(cyclic=1, rigid=1, walls=0),
           (1, 5, 7, 10): dict(cyclic=18, rigid=17, walls=15)}
    for D, e in exp.items():
        s = summary(analyse(list(D)))
        got = {x: s[x] for x in e}
        flag = 'OK' if got == e else 'MISMATCH'
        ok &= got == e
        print(D, s, flag)
    return ok


if __name__ == '__main__':
    if sys.argv[1:] == ['--controls']:
        sys.exit(0 if controls() else 1)
    if sys.argv[1:] == ['--plant']:
        fired = []
        for p in ('drop-max', 'no-cond'):
            PLANT.clear(); PLANT.add(p)
            f = not controls()
            print('plant', p, 'FIRED' if f else 'DID NOT FIRE')
            fired.append(f)
        PLANT.clear()
        sys.exit(0 if all(fired) else 1)
    D = [int(x) for x in sys.argv[1].split(',')]
    A = analyse(D)
    print(summary(A))
    rig = {i for i, p in A['phases'].items() if p['rigid']}
    for i in sorted(rig):
        w = periodic_colouring(A, i)
        A['phases'][i]['word'] = ''.join(map(str, w)); A['phases'][i]['chiral'] = chiral(w)
    for i, p in sorted(A['phases'].items()):
        print('phase', i, p)
    rr = [(i, j) for i, j in A['walls'] if i in rig and j in rig]
    print('walls', A['walls'])
    print('rigid-rigid walls', rr)
    for i, j in rr[:int(sys.argv[2]) if len(sys.argv) > 2 else 2]:
        seq, jn = wall_point(A, i, j)
        print('WALL', i, '->', j, 'junction at', jn, 'length', len(seq))
        print('  around junction:', ''.join(map(str, seq[jn - 40:jn + 60])))
        for it in kempe_report(A, seq, jn):
            if it['kind'] != 'through':
                print('  ', it)
