#!/usr/bin/env python3
"""J20 (crunch 2026-09-25): exact checks of three derived claims about X_4(D), the proper 4-colourings of G(Z, D).

Each check is a complete exact computation on a D that a hand derivation named first (no search):

  Q1  D = {1} and D = {1,2}: the window-state graph W has a non-rigid phase, while the ORBIT quotient of W by colour
      permutations (vertices = orbits of m-words, edges = orbits of (m+1)-words, equivalently the simple image digraph)
      has every phase rigid -- A-Kq's rigidity clause fails for that quotient.  The TRANSFER quotient (out-edges of a
      canonical representative, with multiplicity: FS-79's `rank1_phases.py` definition) agrees with W.
  Q2  D = {1,3,6,9}: X_4(D) is finite (every phase rigid, no wall), the colouring x -> h(x mod 4), h = (a,d,c,b), lies in it
      with least period 4, and its {a,c}-subgraph has exactly three components, the classes of 2Z mod 6, none invariant
      under translation by 4 and each invariant under 12 -- J19-KC clause 1 fails if N is the point's least period.

Plants (--plant NAME) each flip one verdict and must make the run exit non-zero:
  dedupe   the transfer quotient deduplicates its edges           -> Q1's "transfer agrees with W" must fail
  add2     D = {1,2,3,6,9} in Q2 (2 joins the {a,c} classes)       -> Q2's "no class is 4-invariant" must fail
"""
import sys, itertools, collections

PLANT = None


def words(D, m, k=4):
    """All locally proper words of length m (every pair at distance d in D differs)."""
    out = []
    def rec(w):
        if len(w) == m:
            out.append(tuple(w)); return
        L = len(w)
        for c in range(k):
            if all(w[L - d] != c for d in D if d <= L):
                w.append(c); rec(w); w.pop()
    rec([])
    return out


def window_graph(D, k=4):
    m = max(D)
    V = set(words(D, m, k))
    E = collections.defaultdict(list)
    for w in V:
        for c in range(k):
            if all(w[m - d] != c for d in D):          # the (m+1)-word w.c is locally proper
                E[w].append(w[1:] + (c,))
    # prune to the essential core: vertices on bi-infinite paths = m-words occurring in some point
    changed = True
    while changed:
        changed = False
        indeg = collections.Counter(t for s in V for t in E[s] if t in V)
        for s in list(V):
            if indeg[s] == 0 or not any(t in V for t in E[s]):
                V.discard(s); changed = True
    E = {s: [t for t in E[s] if t in V] for s in V}
    return V, E


def sccs(V, E):
    V = list(V); idx = {v: i for i, v in enumerate(V)}
    order, seen = [], set()
    for v0 in V:
        if v0 in seen: continue
        stack = [(v0, iter(E[v0]))]; seen.add(v0)
        while stack:
            v, it = stack[-1]
            for w in it:
                if w not in seen:
                    seen.add(w); stack.append((w, iter(E[w]))); break
            else:
                stack.pop(); order.append(v)
    R = collections.defaultdict(list)
    for s in V:
        for t in E[s]: R[t].append(s)
    comp, comps = {}, []
    for v0 in reversed(order):
        if v0 in comp: continue
        cid = len(comps); comps.append([]); st = [v0]; comp[v0] = cid
        while st:
            v = st.pop(); comps[cid].append(v)
            for w in R[v]:
                if w not in comp:
                    comp[w] = cid; st.append(w)
    return comps, comp


def phase_report(V, E):
    """(number of phases, all phases rigid?, a wall exists?) for a digraph given as adjacency LISTS (multiplicity kept)."""
    comps, comp = sccs(V, E)
    phases = []
    for i, C in enumerate(comps):
        S = set(C)
        inner = [sum(1 for t in E[v] if t in S) for v in C]
        if sum(inner) == 0: continue
        phases.append((i, all(x == 1 for x in inner)))
    ids = {i for i, _ in phases}
    adj = collections.defaultdict(set)
    for s in V:
        for t in E[s]:
            if comp[s] != comp[t]: adj[comp[s]].add(comp[t])
    wall = False
    for i in ids:
        seen, fr = {i}, [i]
        while fr:
            x = fr.pop()
            for y in adj[x]:
                if y not in seen: seen.add(y); fr.append(y)
        if (seen - {i}) & ids: wall = True
    return len(phases), all(r for _, r in phases), wall


def canon(w):
    m = {}; return tuple(m.setdefault(c, len(m)) for c in w)


def orbit_quotient(V, E):
    """V/G with E/G: one edge per ORBIT of (m+1)-words (equivalently, per pair of orbits joined by some edge)."""
    QV = {canon(v) for v in V}
    QE = collections.defaultdict(set)
    for s in V:
        for t in E[s]:
            QE[canon(s)].add(canon(t))
    return QV, {q: sorted(QE[q]) for q in QV}


def transfer_quotient(V, E):
    """FS-79's quotient: out-edges of the canonical representative, one per admissible next colour (multiplicity kept)."""
    QV = {canon(v) for v in V}
    QE = {}
    for q in QV:
        rep = q                                  # the canonical word is itself a member of V (colour names are 0..k-1)
        tgt = [canon(t) for t in E[rep]]
        if PLANT == "dedupe": tgt = sorted(set(tgt))
        QE[q] = tgt
    return QV, QE


def check_Q1():
    ok = True
    for D in ([1], [1, 2]):
        V, E = window_graph(D)
        w = phase_report(V, E)
        o = phase_report(*orbit_quotient(V, E))
        t = phase_report(*transfer_quotient(V, E))
        print(f"Q1 D={D}: W phases/allrigid/wall = {w}; orbit quotient = {o}; transfer quotient = {t}")
        ok &= (w[1] is False) and (o[1] is True)        # the orbit quotient reads rigid where W is not
        ok &= (t[1] == w[1]) and (t[2] == w[2])          # the transfer quotient agrees with W
    return ok


def check_Q2():
    D = [1, 3, 6, 9] if PLANT != "add2" else [1, 2, 3, 6, 9]
    V, E = window_graph(D)
    n, allrigid, wall = phase_report(V, E)
    print(f"Q2 D={D}: {len(V)} essential states, {n} phases, all rigid = {allrigid}, wall = {wall}")
    ok = allrigid and not wall
    a, d_, c, b = 0, 1, 2, 3
    h = (a, d_, c, b)
    col = lambda x: h[x % 4]
    proper = all(col(x) != col(x + dd) for x in range(-40, 40) for dd in D)
    least = min(p for p in range(1, 13) if all(col(x) == col(x + p) for x in range(0, 48)))
    print(f"Q2 h(x mod 4) proper = {proper}, least period = {least}")
    ok &= proper and least == 4
    # {a,c}-subgraph on a window, components by union-find; read each class's residue set mod 12
    lo, hi = -120, 120
    pts = [x for x in range(lo, hi) if col(x) in (a, c)]
    par = {x: x for x in pts}
    def f(x):
        while par[x] != x: par[x] = par[par[x]]; x = par[x]
        return x
    for x in pts:
        for dd in D:
            y = x + dd
            if y in par and col(y) != col(x): par[f(x)] = f(y)
    inner = [x for x in pts if lo + 30 <= x < hi - 30]
    classes = collections.defaultdict(set)
    for x in inner: classes[f(x)].add(x)
    res = sorted({frozenset(x % 12 for x in cl) for cl in classes.values()}, key=sorted)
    print(f"Q2 {{a,c}} components meeting the inner window: {len(classes)}; residue sets mod 12: {[sorted(r) for r in res]}")
    inv4 = any(all((x + 4) in cl or not (lo + 30 <= x + 4 < hi - 30) for x in cl) for cl in classes.values())
    inv12 = all(all((x + 12) in cl or not (lo + 30 <= x + 12 < hi - 30) for x in cl) for cl in classes.values())
    print(f"Q2 some class invariant under +4: {inv4}; every class invariant under +12: {inv12}")
    ok &= (len(classes) == 3) and (not inv4) and inv12
    return ok


if __name__ == "__main__":
    if "--plant" in sys.argv:
        PLANT = sys.argv[sys.argv.index("--plant") + 1]
    r1, r2 = check_Q1(), check_Q2()
    print("Q1", "PASS" if r1 else "FAIL", "| Q2", "PASS" if r2 else "FAIL", "| plant", PLANT)
    sys.exit(0 if (r1 and r2) else 1)
