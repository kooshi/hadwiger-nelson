#!/usr/bin/env python3
"""J20 (crunch 2026-09-25), phase B2: exact structure of X_4(D) for NAMED sets D (no search).

For each D given: the essential window-state graph W (m-words occurring in points), its phases (cyclic SCCs), which are single
cycles, the rigid-rigid walls (pairs of rigid phases C != C' with a path C -> C'), each rigid phase's periodic word, whether that
periodic point is Kempe-FROZEN (every two-colour subgraph of the infinite periodic colouring connected; decided exactly by the
voltage gcd on the quotient mod the period), chirality (is the mirror phase a colour-permutation image), and the graph on rigid
phases given by single-strand Kempe swaps (swap one component of one two-colour subgraph of the periodic point).

Uses: KE and KE-sharp are refuted by any rigid-rigid wall between two frozen periodic points (KE's swap then only relabels a tail);
J19-AF-x and J18-DPR are tools-exact claims about {2,6,11,13,14} and {1,5,7,10,13,27,33}; J18-K0H needs a rigid-rigid wall (T30).

Plant (--plant nogcd): frozenness ignores the voltage gcd (quotient connectivity only) -> the control D={3,6,9}'s point
x -> (a,d,c,b)[x mod 4], whose {a,c}-lift has three components, must then read frozen, and the run must exit non-zero.
"""
import sys, collections, math, itertools, json

PLANT = None


def essential_graph(D, k=4):
    m = max(D); Ds = sorted(D)
    V = []
    def rec(w):
        if len(w) == m:
            V.append(tuple(w)); return
        L = len(w)
        for c in range(k):
            if all(w[L - d] != c for d in Ds if d <= L):
                w.append(c); rec(w); w.pop()
    rec([])
    Vs = set(V)
    succ = {v: [v[1:] + (c,) for c in range(k) if all(v[m - d] != c for d in Ds) and (v[1:] + (c,)) in Vs] for v in V}
    pred = collections.defaultdict(list)
    for v in V:
        for t in succ[v]: pred[t].append(v)
    outd = {v: len(succ[v]) for v in V}; ind = {v: len(pred[v]) for v in V}
    alive = set(V); q = collections.deque(v for v in V if outd[v] == 0 or ind[v] == 0)
    dead = set()
    while q:
        v = q.popleft()
        if v in dead: continue
        dead.add(v); alive.discard(v)
        for t in succ[v]:
            if t not in dead:
                ind[t] -= 1
                if ind[t] == 0: q.append(t)
        for s in pred[v]:
            if s not in dead:
                outd[s] -= 1
                if outd[s] == 0: q.append(s)
    E = {v: [t for t in succ[v] if t in alive] for v in alive}
    return m, alive, E


def sccs(V, E):
    order, seen = [], set()
    for v0 in V:
        if v0 in seen: continue
        st = [(v0, iter(E[v0]))]; seen.add(v0)
        while st:
            v, it = st[-1]
            for w in it:
                if w not in seen:
                    seen.add(w); st.append((w, iter(E[w]))); break
            else:
                st.pop(); order.append(v)
    R = collections.defaultdict(list)
    for s in V:
        for t in E[s]: R[t].append(s)
    comp = {}; comps = []
    for v0 in reversed(order):
        if v0 in comp: continue
        cid = len(comps); comps.append([]); stk = [v0]; comp[v0] = cid
        while stk:
            v = stk.pop(); comps[cid].append(v)
            for w in R[v]:
                if w not in comp: comp[w] = cid; stk.append(w)
    return comps, comp


def cycle_word(C, E, CS):
    """The periodic colouring of a single-cycle phase: follow the unique in-phase successor."""
    v0 = min(C); word = []; v = v0
    while True:
        word.append(v[0])
        nxt = [t for t in E[v] if t in CS]
        assert len(nxt) == 1
        v = nxt[0]
        if v == v0: break
    return tuple(word)


def lift_components(w, D, pair):
    """Components of the {a,b}-subgraph of the periodic colouring x -> w[x mod N]. Returns list of (residue->potential map, g):
    one entry per quotient component; the lift has g components (g = 0: infinitely many finite ones)."""
    N = len(w); a, b = pair
    R = [r for r in range(N) if w[r] in pair]
    adj = collections.defaultdict(list)
    for r in R:
        for d in D:
            for sgn in (1, -1):
                y = r + sgn * d; s = y % N; v = (y - s) // N
                if w[s] in pair: adj[r].append((s, v))
    out = []; seen = set()
    for r0 in R:
        if r0 in seen: continue
        phi = {r0: 0}; seen.add(r0); stk = [r0]; g = 0
        while stk:
            r = stk.pop()
            for s, v in adj[r]:
                if s not in phi:
                    phi[s] = phi[r] + v; seen.add(s); stk.append(s)
                else:
                    g = math.gcd(g, abs(phi[r] + v - phi[s]))
        out.append((phi, g))
    return out


def frozen(w, D):
    for pair in itertools.combinations(range(4), 2):
        comps = lift_components(w, D, pair)
        if PLANT == "nogcd":
            if len(comps) != 1: return False
            continue
        if len(comps) != 1 or comps[0][1] != 1: return False
    return True


def phase_of_word(w, m, comp):
    N = len(w)
    return comp.get(tuple(w[i % N] for i in range(m)))


def analyse(D, strands=False):
    m, V, E = essential_graph(D)
    comps, comp = sccs(V, E)
    phases = {}
    for i, C in enumerate(comps):
        S = set(C); inner = [sum(1 for t in E[v] if t in S) for v in C]
        if sum(inner) == 0: continue
        phases[i] = all(x == 1 for x in inner)
    adj = collections.defaultdict(set)
    for s in V:
        for t in E[s]:
            if comp[s] != comp[t]: adj[comp[s]].add(comp[t])
    reach = {}
    for i in phases:
        seen, fr = {i}, [i]
        while fr:
            x = fr.pop()
            for y in adj[x]:
                if y not in seen: seen.add(y); fr.append(y)
        reach[i] = (seen - {i}) & set(phases)
    rigid = [i for i in phases if phases[i]]
    words = {i: cycle_word(comps[i], E, set(comps[i])) for i in rigid}
    rr_walls = [(i, j) for i in rigid for j in reach[i] if phases[j]]
    fro = {i: frozen(words[i], D) for i in rigid}
    # chirality: mirror of a rigid phase = phase of the reversed word; achiral iff some colour permutation maps it to itself
    chiral = {}
    for i in rigid:
        rev = tuple(reversed(words[i]))
        imgs = {phase_of_word(tuple(g[c] for c in rev), m, comp) for g in itertools.permutations(range(4))}
        chiral[i] = i not in imgs
    res = dict(D=sorted(D), m=m, states=len(V), phases=len(phases), rigid=len(rigid), nonrigid=len(phases) - len(rigid),
               walls_total=sum(len(reach[i]) for i in phases), rr_walls=len(rr_walls),
               rr_walls_frozen_both=sum(1 for i, j in rr_walls if fro[i] and fro[j]),
               rr_walls_frozen_one=sum(1 for i, j in rr_walls if fro[i] != fro[j]),
               rigid_frozen=sum(fro.values()), rigid_chiral=sum(chiral.values()),
               rr_wall_end_types=sorted(collections.Counter((len(words[i]), fro[i], chiral[i], len(words[j]), fro[j], chiral[j]) for i, j in rr_walls).items()))
    if strands:
        # single-strand swap graph on rigid phases
        g = collections.defaultdict(set)
        for i in rigid:
            w = words[i]; N = len(w)
            for pair in itertools.combinations(range(4), 2):
                for phi, gg in lift_components(w, D, pair):
                    if gg == 0: continue
                    for j in range(gg):
                        P = gg * N
                        w2 = list(w[x % N] for x in range(P))
                        for x in range(P):
                            r = x % N
                            if r in phi and (x // N - phi[r]) % gg == j:   # lift label of x = r + kN is k - phi(r) mod g
                                w2[x] = pair[1] if w2[x] == pair[0] else pair[0]
                        assert all(w2[x] != w2[(x + d) % P] for x in range(P) for d in D), "strand swap not proper"
                        t = phase_of_word(tuple(w2), m, comp)
                        g[i].add(t)
        tgt_nonrigid = any(t is None or (t in phases and not phases[t]) for i in g for t in g[i])
        seen, fr = {rigid[0]}, [rigid[0]]
        und = collections.defaultdict(set)
        for i in g:
            for t in g[i]:
                if t is not None: und[i].add(t); und[t].add(i)
        while fr:
            x = fr.pop()
            for y in und[x]:
                if y not in seen: seen.add(y); fr.append(y)
        mirror_joined = True
        for i in rigid:
            if chiral[i]:
                rev = tuple(reversed(words[i]))
                mi = phase_of_word(rev, m, comp)
                mirror_joined &= (mi in seen) == (i in seen)
        orbits = set()
        for i in rigid:
            w = words[i]; N = len(w)
            orbits.add(min(tuple(g[w[(r + t) % N]] for t in range(N)) for g in itertools.permutations(range(4)) for r in range(N)))
        res.update(rigid_orbits_mod_perm_and_shift=len(orbits))
        res.update(swap_graph_connected=(set(rigid) <= seen), swap_to_nonrigid=tgt_nonrigid, mirror_same_swap_component=mirror_joined)
    return res


if __name__ == "__main__":
    args = sys.argv[1:]
    if "--plant" in args:
        PLANT = args[args.index("--plant") + 1]
    # control: D={3,6,9}, point x -> (a,d,c,b)[x mod 4] is NOT frozen ({a,c} lift has 3 components)
    ctrl = frozen((0, 3, 2, 1), [3, 6, 9])
    print("control {3,6,9} (a,d,c,b) frozen:", ctrl, "(must be False)")
    ctrl2 = frozen((0, 1, 2, 3), [1, 2, 3])
    print("control {1,2,3} (a,b,c,d) frozen:", ctrl2, "(must be True)")
    ok = (ctrl is False) and (ctrl2 is True)
    sets = [([1, 5, 7, 10], False), ([3, 5, 9, 10], False), ([3, 7, 9, 10], False), ([5, 7, 9, 10], False),
            ([2, 6, 11, 13, 14], True), ([1, 5, 7, 10, 13, 27, 33], False)]
    only = [a for a in args if a.startswith("--only=")]
    if only:
        idx = [int(x) for x in only[0][7:].split(",")]
        sets = [sets[i] for i in idx]
    for D, st in sets:
        r = analyse(D, strands=st)
        print(json.dumps(r))
    print("controls", "PASS" if ok else "FAIL", "| plant", PLANT)
    sys.exit(0 if ok else 1)
