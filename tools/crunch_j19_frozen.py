#!/usr/bin/env python3
"""J19 (crunch 2026-09-25): which rigid periodic points of X_4(D) are Kempe-FROZEN (every two-colour subgraph connected, i.e. one
strand per colour pair), and where every PROPER strand swap of a non-frozen one lands (the phase of p with one strand of a >=2-strand
pair swapped; for n strands, every single-strand swap is listed).  Exact; analysis of ONE given D; uses J18's frozen tool and J19's
strand routine.

    crunch_j19_frozen.py D            report for one D
    crunch_j19_frozen.py --control    positive control {1,5,7,10} against a hand-derived strand count and J18's data (see control())
    crunch_j19_frozen.py --plant      the swap is skipped (the unswapped point is looked up); the control must then FAIL; exit 0 iff so
"""
import sys, os, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import crunch_j18_phases as T
import crunch_j19_ends as E

PLANT = False


def phase_of_periodic(A, w):
    m = A['m']; P = len(w)
    ww = w * (m // P + 3)
    return A['cid'].get(T.canon(tuple(ww[:m])))


def report(D):
    A = T.analyse(D)
    rig = {i for i, p in A['phases'].items() if p['rigid']}
    rows = []
    for i in sorted(rig):
        w = T.periodic_colouring(A, i)
        counts = {}
        swaps = []
        for pair in itertools.combinations(range(4), 2):
            N, lab, n = E.strands(w, D, pair)
            counts[pair] = n
            if n >= 2:
                for s in range(n):
                    big = [w[r % len(w)] for r in range(N)]
                    if not PLANT:
                        for r in range(N):
                            if lab[r] == s:
                                big[r] = pair[1] if big[r] == pair[0] else pair[0]
                    assert T.proper(big * 3, D, 0, 3 * N), 'strand swap not proper'
                    ph = phase_of_periodic(A, big)
                    swaps.append((pair, s, ph, 'rigid' if ph in rig else 'NONRIGID'))
        rows.append((i, len(w), T.chiral(w), counts, swaps))
    return A, rig, rows


def show(D):
    A, rig, rows = report(D)
    print('D', D, T.summary(A))
    nf = 0
    for i, P, ch, counts, swaps in rows:
        frozen = all(v == 1 for v in counts.values())
        nf += not frozen
        print(' phase', i, 'period', P, 'chiral', ch, 'frozen' if frozen else 'NON-FROZEN',
              {''.join(map(str, k)): v for k, v in counts.items() if v != 1})
        for s in swaps:
            print('    swap', s)
    print(' non-frozen rigid phases:', nf, 'of', len(rows))
    return rows


def control():
    """Positive control on {1,5,7,10}, against two facts NOT computed by this tool: (a) by hand (J19 §2.4): the period-4 phase
    (colouring x mod 4) has 5 strands for the pairs {0,2} and {1,3} (the only distance = 2 mod 4 is 10, so the even positions split
    into the 5 classes mod 10) and 1 strand for every other pair; (b) J18's swaptail data: in phase 65 a single {0,3}-strand swap
    lands in the non-rigid phase 57."""
    A, rig, rows = report([1, 5, 7, 10])
    byid = {r[0]: r for r in rows}
    p4 = [r for r in rows if r[1] == 4]
    a = len(p4) == 1 and p4[0][3] == {(0, 1): 1, (0, 2): 5, (0, 3): 1, (1, 2): 1, (1, 3): 5, (2, 3): 1}
    b = any(s[0] == (0, 3) and s[2] == 57 for s in byid[65][4])
    print('control {1,5,7,10}: (a) period-4 strand counts as derived by hand:', a, '; (b) a {0,3}-swap of phase 65 lands in 57:', b)
    return a and b


if __name__ == '__main__':
    if sys.argv[1:] == ['--control']:
        sys.exit(0 if control() else 1)
    if sys.argv[1:] == ['--plant']:
        PLANT = True
        ok = control()
        print('plant', 'FIRED' if not ok else 'DID NOT FIRE'); sys.exit(0 if not ok else 1)
    show([int(x) for x in sys.argv[1].split(',')])
