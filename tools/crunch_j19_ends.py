#!/usr/bin/env python3
"""J19 (crunch 2026-09-25): the ends partition of a heteroclinic wall point c of X_4(D), for every colour pair {e,f}.

For a rigid periodic point p (one period, from J18's frozen tool), its {e,f}-STRANDS are the components of the {e,f}-subgraph of
G(Z, D) coloured by p; each is two-sided infinite (K0-loc) and invariant under some multiple of the period.  They are computed on the
cycle Z/(P*t), t = the least multiple for which the component count is maximal among t <= 24 (the strand permutation's order).
A component K of the {e,f}-subgraph of c (computed on a long finite window of c) has LEFT ENDS = the p-strands whose far-left vertices
it contains, RIGHT ENDS likewise for q.  Printed: per pair, the strand counts of p and q, and every infinite component's (left ends,
right ends) and its type.  Exact; analysis of the ONE given D (no search).

    crunch_j19_ends.py D i j        the wall from rigid phase i to rigid phase j (labelled quotient ids of J18's tool)
    crunch_j19_ends.py --plant      planted fault: strands computed without the largest distance; on the control {1,5,7,10},
                                    wall 65 -> 55, the strand counts must then differ from the true ones (or an assertion fire);
                                    exit 0 iff the plant fires
"""
import sys, os, itertools, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import crunch_j18_phases as T

PLANT = False


def strands(word, D, pair):
    """Strands of the periodic point with one period `word`, for colour pair `pair`: returns (N, label) with label[r] the strand id of
    residue r mod N (None if word[r mod P] not in pair)."""
    P = len(word)
    best = None
    Dg = [d for d in D if d != max(D)] if PLANT else D     # the plant: strands computed without the largest distance
    for t in range(1, 25):
        N = P * t
        lab = [None] * N
        nid = 0
        for r0 in range(N):
            if word[r0 % P] in pair and lab[r0] is None:
                lab[r0] = nid; st = [r0]
                while st:
                    x = st.pop()
                    for d in Dg:
                        for y in ((x + d) % N, (x - d) % N):
                            if word[y % P] in pair and lab[y] is None:
                                lab[y] = nid; st.append(y)
                nid += 1
        if best is None or nid > best[2]:
            best = (N, lab, nid)
    return best


def ends(D, i, j):
    A = T.analyse(D)
    seq, jn = T.wall_point(A, i, j)
    n = len(seq); m = A['m']
    wp = T.periodic_colouring(A, i); wq = T.periodic_colouring(A, j)
    P, Q = len(wp), len(wq)
    # align: the left tail equals p shifted by a, i.e. seq[x] = wp'[(x) mod P] for some rotation/relabel; recover by reading seq
    left_word = seq[20 * m: 20 * m + P]      # one period of the actual left tail, starting at position 20m
    right_word = seq[n - 20 * m - Q: n - 20 * m]
    assert all(seq[x] == seq[x + P] for x in range(10 * m, 30 * m)), 'left tail not P-periodic'
    assert all(seq[x] == seq[x + Q] for x in range(n - 30 * m, n - 10 * m)), 'right tail not Q-periodic'
    out = []
    for pair in itertools.combinations(range(4), 2):
        Np, labp, sp = strands(left_word, D, pair)
        Nq, labq, sq = strands(right_word, D, pair)
        vs = {x for x in range(n) if seq[x] in pair}
        comp = {}
        for x0 in sorted(vs):
            if x0 in comp: continue
            comp[x0] = x0; st = [x0]
            while st:
                x = st.pop()
                for d in D:
                    for y in (x - d, x + d):
                        if y in vs and y not in comp:
                            comp[y] = x0; st.append(y)
        groups = collections.defaultdict(list)
        for x, r in comp.items(): groups[r].append(x)
        L0, L1 = 5 * m, 15 * m               # far-left region (positions), far-right region mirrored
        R0, R1 = n - 15 * m, n - 5 * m
        rows = []
        for r, xs in groups.items():
            le = sorted({labp[(x - 20 * m) % Np] for x in xs if L0 <= x < L1})
            ri = sorted({labq[(x - (n - 20 * m - Q)) % Nq] for x in xs if R0 <= x < R1})
            if not le and not ri:
                if max(xs) < L0 or min(xs) >= R1:
                    continue                    # a piece cut off by the finite window's own edge: an artifact, not a component of c
                if min(xs) < L1 or max(xs) >= R0:
                    raise AssertionError('a component reaches a tail region with no end: window too short')
                rows.append(('finite', (), (), len(xs), min(xs) - jn, max(xs) - jn)); continue
            kind = 'through' if (le and ri) else 'left-only' if le else 'right-only'
            rows.append((kind, tuple(le), tuple(ri), len(xs), min(xs) - jn, max(xs) - jn))
        # self-check: each p-strand's far-left vertices lie in ONE component (the one-endedness lemma, J19 §2.2)
        seen = collections.defaultdict(set)
        for r, xs in groups.items():
            for x in xs:
                if L0 <= x < L1: seen[labp[(x - 20 * m) % Np]].add(r)
        assert all(len(v) == 1 for v in seen.values()), 'a p-strand splits among components of c in the far-left region'
        out.append((pair, sp, sq, rows))
    return out, seq, jn


if __name__ == '__main__':
    if sys.argv[1:] == ['--plant']:
        PLANT = True
        try:
            o, _, _ = ends([1, 5, 7, 10], 65, 55)
            PLANT = False
            o2, _, _ = ends([1, 5, 7, 10], 65, 55)
            diff = any(a[1] != b[1] or a[2] != b[2] for a, b in zip(o, o2))
            print('plant', 'FIRED (strand counts differ)' if diff else 'DID NOT FIRE'); sys.exit(0 if diff else 1)
        except AssertionError as ex:
            print('plant FIRED:', ex); sys.exit(0)
    D = [int(x) for x in sys.argv[1].split(',')]
    i, j = int(sys.argv[2]), int(sys.argv[3])
    o, seq, jn = ends(D, i, j)
    print('D', D, 'wall', i, '->', j)
    for pair, sp, sq, rows in o:
        inf = [r for r in rows if r[0] != 'finite']
        fin = [r for r in rows if r[0] == 'finite']
        print(' pair', pair, 'p-strands', sp, 'q-strands', sq, 'finite comps', len(fin))
        for r in sorted(inf):
            print('   ', r[0], 'L', r[1], 'R', r[2], 'size', r[3], 'span', (r[4], r[5]))
