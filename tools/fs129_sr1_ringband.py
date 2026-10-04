#!/usr/bin/env python3
"""FS129-SR1-RINGBAND: the band of D, one lemma under FS110-N2-RING, FS110-Y3-GP and FS129-OA1-RINGWIND.

Discretised rings: N = 6m cells round a circle (cell i covers angles [i, i+1) * 360/N), each coloured in Z/3, proper at 60 degrees
(c[i] != c[i+m]); change points are cell boundaries where the colour differs. For a position k (a cell) and j = 0..5 put the
hexagon cells k + m j, the lift L (sum of +-1 over changes, extended past one turn by the winding), D_j = L[k+m(j+1)] - L[k+mj],
m_j = floor(D_j / 3), n2 = #{j : D_j = 2 mod 3}, h = (1/3) sum_j d(c_j, c_{j+1}) (RINGWIND's W), W = (L[k+6m] - L[k]) / 3 (the turns).
Checks, on every proper ring with N = 12 and N = 18 (first cell fixed), and on 4000 seeded random proper rings with N in 24..60:
  (I)  h = (6 - 2 n2) / 3, in {-2, 0, 2}                                      (RINGWIND's W is FS110's n2, read position by position)
  (II) W = sum_j m_j + 3 - h/2 at every position                              (the identity)
  (III) h changes between consecutive positions only if the boundary crossed carries two change points 60 degrees apart (RINGWIND)
  (IV) a ring with no two change points 60 degrees apart has all m_j equal, h = 0 and W = 6m + 3   (FS110-Y3-GP, through the band)
  (V)  a ring with no swap point has W in [6M + 2, 6M + 4] for one M, and W = 6M + 3 unless its change set is invariant under the
       60-degree rotation                                                      (FS110-N2-RING, refined)
Fault: --fault (the identity read without its + 3) — (II) fails.  Prints 'ringband ok' and the counts; exits 1 on any failure.
"""
import random
import sys


STATS = {'nopair': 0, 'noswap': 0, 'noswap_invariant': 0}


def d(x, y):
    if x == y:
        return 0
    return 1 if (y - x) % 3 == 1 else -1


def check_ring(c, fault):
    N = len(c)
    m = N // 6
    steps = [d(c[i], c[(i + 1) % N]) for i in range(N)]   # step at the boundary after cell i
    W3 = sum(steps)
    if W3 % 3:
        return 'winding not a multiple of 3'
    W = W3 // 3
    L = [0] * (2 * N + 1)
    for i in range(2 * N):
        L[i + 1] = L[i] + steps[i % N]
    change = [x != 0 for x in steps]
    pair60 = [change[i] and change[(i + m) % N] for i in range(N)]
    any_pair = any(pair60)
    # swap point (FS110-N-proof.md 4.3): a change at boundary b with c(sigma x -) = c(x +) and c(sigma x +) = c(x -), or with sigma^-1
    def is_swap(b):
        if not change[b]:
            return False
        xm, xp = c[b], c[(b + 1) % N]
        for bb in ((b + m) % N, (b - m) % N):
            if change[bb] and c[bb] == xp and c[(bb + 1) % N] == xm:
                return True
        return False
    any_swap = any(is_swap(b) for b in range(N))
    invariant = all(change[i] == change[(i + m) % N] for i in range(N))
    hs, ms = [], []
    for k in range(N):
        D = [L[k + m * (j + 1)] - L[k + m * j] for j in range(6)]
        if any(x % 3 == 0 for x in D):
            return 'D = 0 mod 3 (properness broken)'
        mj = [x // 3 for x in D]
        n2 = sum(1 for x in D if x % 3 == 2)
        h3 = sum(d(c[(k + m * j) % N], c[(k + m * (j + 1)) % N]) for j in range(6))
        if h3 % 3:
            return 'hexagon winding not a multiple of 3'
        h = h3 // 3
        if h not in (-2, 0, 2) or 3 * h != 6 - 2 * n2:
            return 'I fails at %d' % k
        rhs = sum(mj) + (0 if fault else 3) - h // 2
        if W != rhs:
            return 'II fails at %d: W=%d rhs=%d' % (k, W, rhs)
        hs.append(h)
        ms.append(mj)
    for k in range(N):
        if hs[k] != hs[(k + 1) % N]:
            # moving from cell k to k+1 crosses boundary k + m j for every j
            if not any(pair60[(k + m * j) % N] for j in range(6)):
                return 'III fails at %d' % k
    if not any_pair:
        if any(len(set(mj)) != 1 for mj in ms) or any(h != 0 for h in hs) or (W - 3) % 6:
            return 'IV fails'
    if not any_swap:
        lo = min(min(mj) for mj in ms)
        if not (6 * lo + 2 <= W <= 6 * lo + 4) or any(len(set(mj)) != 1 for mj in ms):
            return 'V (band) fails'
        if not invariant and W != 6 * lo + 3:
            return 'V (refinement) fails'
    STATS['nopair'] += not any_pair
    STATS['noswap'] += not any_swap
    STATS['noswap_invariant'] += (not any_swap) and invariant
    return None


def rings_exhaustive(N):
    """Every proper ring with c[0] = 0, by depth-first extension (c[i] != c[i - m] while building, the wrap checked at the end)."""
    m = N // 6
    c = [0] * N

    def rec(i):
        if i == N:
            if all(c[j] != c[(j + m) % N] for j in range(N - m, N)):
                yield tuple(c)
            return
        for col in range(3):
            if i >= m and c[i - m] == col:
                continue
            c[i] = col
            yield from rec(i + 1)

    yield from rec(1)


def ring_random(N, rng):
    m = N // 6
    while True:
        # build by runs so change points are sparse, then test properness
        c, col = [], rng.randrange(3)
        while len(c) < N:
            run = rng.randint(1, m)
            c.extend([col] * run)
            col = (col + rng.choice((1, 2))) % 3
        c = c[:N]
        if all(c[i] != c[(i + m) % N] for i in range(N)):
            return tuple(c)


def main():
    fault = '--fault' in sys.argv
    count = nopair = noswap = 0
    for N in (12, 18):
        for c in rings_exhaustive(N):
            err = check_ring(c, fault)
            count += 1
            if err:
                print('ring', c, ':', err)
                return 1
    rng = random.Random(20261003)
    for _ in range(4000):
        N = 6 * rng.randint(4, 10)
        c = ring_random(N, rng)
        err = check_ring(c, fault)
        count += 1
        if err:
            print('ring', c, ':', err)
            return 1
    print('ringband ok (%d rings; no 60-degree pair %d, no swap point %d, of which rotation-invariant %d)'
          % (count, STATS['nopair'], STATS['noswap'], STATS['noswap_invariant']))
    return 0


if __name__ == '__main__':
    rc = main()
    # a planted fault must run cleanly and print its failure (the derive gate's rule); only the unfaulted run exits non-zero on failure
    sys.exit(0 if any(a.startswith('--fault') for a in sys.argv[1:]) else rc)
