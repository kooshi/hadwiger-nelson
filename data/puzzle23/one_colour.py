#!/usr/bin/env python3
"""How many cells of the 23 board can one colour hold?  (largest clash-free set in the unit-step graph)

Two instruments, neither a proof of the maximum:
  A. exact search inside symmetric families: sets invariant under a rotation subgroup of order d about the origin.
     The cells fall into orbits; an orbit clashing with itself is out; two orbits clash if any two of their cells do.
     The best union of orbits is a maximum-weight independent set of that small orbit graph: exact (a plain branch and bound over
     bitsets, with a node cap that is reported if hit).  Exhaustive within the family, for each d tried.
  B. a tabu local search over all sets of a target size (no symmetry): a lower bound only.
Every set reported is re-checked cell by cell.
Usage: one_colour.py [seconds for B] [seed]
"""
import sys, time, random
import numpy as np

q = 23
S = [(a, b) for a in range(q) for b in range(q) if (a * a + b * b) % q == 1]
cells = [(x, y) for x in range(q) for y in range(q)]
idx = {c: i for i, c in enumerate(cells)}
nbr = [[idx[((x + a) % q, (y + b) % q)] for a, b in S] for x, y in cells]
N = q * q


def clashes(sel):
    s = set(sel)
    return sum(1 for v in s for w in nbr[v] if w in s) // 2


def rot(u, p):
    return ((u[0] * p[0] - u[1] * p[1]) % q, (u[1] * p[0] + u[0] * p[1]) % q)


def order(u):
    p, n = u, 1
    while p != (1, 0):
        p, n = rot(u, p), n + 1
    return n


def family_A(d, limit_nodes=140):
    gen = next(u for u in S if order(u) == q + 1)
    r = (1, 0)
    for _ in range((q + 1) // d):
        r = rot(gen, r)                      # r has order d
    seen, orbits = set(), []
    for c in cells:
        if c in seen:
            continue
        o, p = [], c
        while p not in o:
            o.append(p)
            p = rot(r, p)
        seen.update(o)
        orbits.append([idx[p] for p in o])
    good = [o for o in orbits if clashes(o) == 0]
    if len(good) > limit_nodes:
        return f"d={d}: {len(orbits)} orbits, {len(good)} usable — skipped (orbit graph too large for the exact search here)"
    where = {}
    for i, o in enumerate(good):
        for v in o:
            where[v] = i
    n = len(good)
    adj = [0] * n
    for i, o in enumerate(good):
        for v in o:
            for w in nbr[v]:
                j = where.get(w)
                if j is not None and j != i:
                    adj[i] |= 1 << j
    wts = [len(o) for o in good]
    best = [0, 0]
    nodes = [0]
    CAPN = 4_000_000

    def total(m):
        t = 0
        while m:
            low = m & -m
            t += wts[low.bit_length() - 1]
            m ^= low
        return t

    def rec(cand, cur, cs):
        nodes[0] += 1
        if nodes[0] > CAPN:
            return
        if cur + total(cand) <= best[0]:
            return
        bv, bd, m = -1, 0, cand
        while m:
            low = m & -m
            v = low.bit_length() - 1
            m ^= low
            dg = bin(adj[v] & cand).count("1")
            if dg > bd:
                bv, bd = v, dg
        if bv < 0:                               # no clash left among the candidates: take them all
            best[0], best[1] = cur + total(cand), cs | cand
            return
        rec(cand & ~adj[bv] & ~(1 << bv), cur + wts[bv], cs | (1 << bv))
        rec(cand & ~(1 << bv), cur, cs)

    t0 = time.time()
    rec((1 << n) - 1, 0, 0)
    sel = [v for i in range(n) if best[1] >> i & 1 for v in good[i]]
    assert len(sel) == best[0] and clashes(sel) == 0
    tag = "exact in this family" if nodes[0] <= CAPN else f"NODE CAP HIT — a lower bound only"
    return f"d={d}: {len(orbits)} orbits, {n} usable; best union = {best[0]} cells ({tag}, {nodes[0]} nodes, {time.time() - t0:.1f}s)"


def tabu(seconds, seed):
    rng = random.Random(seed)
    A = np.zeros((N, N), dtype=np.int16)
    for v in range(N):
        A[v, nbr[v]] = 1
    # start: the stripes class of 69 cells (three parallel lines of 3x+5y)
    inS = np.array([((3 * x + 5 * y) % q) < 3 for x, y in cells])
    import os
    if os.environ.get("START") == "random":      # a random maximal clash-free set instead of the stripes class
        inS[:] = False
        order_ = list(range(N))
        rng.shuffle(order_)
        blocked = np.zeros(N, dtype=bool)
        for v in order_:
            if not blocked[v]:
                inS[v] = True
                blocked[v] = True
                blocked[nbr[v]] = True
    assert clashes(np.flatnonzero(inS)) == 0
    best = int(inS.sum())
    print(f"  B: start = {best} cells", flush=True)
    best_set = np.flatnonzero(inS).copy()
    t_end = time.time() + seconds
    it_total = 0
    while time.time() < t_end:
        # grow by one cell (the one with fewest neighbours inside), then repair by swaps
        c = A[:, inS].sum(axis=1)
        cand = np.flatnonzero(~inS)
        v = cand[np.argmin(c[cand] + np.array([rng.random() for _ in cand]))]
        inS[v] = True
        c = c + A[:, v]
        tabu_until = np.zeros(N, dtype=np.int64)
        it = 0
        K = int(inS.sum())
        budget = 60000
        while it < budget and time.time() < t_end:
            it += 1
            conf = int((c[inS]).sum()) // 2
            if conf == 0:
                break
            ins = np.flatnonzero(inS)
            score = c[ins] + np.where(tabu_until[ins] > it, -100, 0) + np.random.random(len(ins))
            u = ins[np.argmax(score)]
            out = np.flatnonzero(~inS)
            sc = c[out] - A[u, out] + np.where(tabu_until[out] > it, 100, 0) + np.random.random(len(out))
            w = out[np.argmin(sc)]
            inS[u] = False
            inS[w] = True
            c = c - A[:, u] + A[:, w]
            tabu_until[u] = it + 7 + rng.randrange(10)
            tabu_until[w] = it + 3 + rng.randrange(5)
        it_total += it
        if int((c[inS]).sum()) == 0:
            sel = np.flatnonzero(inS)
            assert clashes(sel) == 0
            if len(sel) > best:
                best, best_set = len(sel), sel.copy()
                print(f"  B: clash-free set of {best} cells (t={seconds - (t_end - time.time()):.0f}s)", flush=True)
        else:                                  # could not repair at size K: fall back to the best and perturb it
            inS[:] = False
            inS[best_set] = True
            drop = rng.sample(list(best_set), 6)
            inS[drop] = False
            for _ in range(5):
                c = A[:, inS].sum(axis=1)
                free = np.flatnonzero((~inS) & (c == 0))
                if len(free) == 0:
                    break
                inS[rng.choice(list(free))] = True
    return best, best_set, it_total


if __name__ == "__main__":
    secs = int(sys.argv[1]) if len(sys.argv) > 1 else 120
    seed = int(sys.argv[2]) if len(sys.argv) > 2 else 1
    np.random.seed(seed)
    print(f"q={q}: {N} cells, {len(S)} steps; seven colours need a colour on >= {-(-N // 7)} cells, six on >= {-(-N // 6)}; ceiling 105")
    print("A. rotation-invariant sets, exact per family:")
    for d in (24, 12, 8, 6, 4, 3):
        print("  " + family_A(d), flush=True)
    print(f"B. tabu local search, {secs}s, seed {seed}, from the stripes class of 69:")
    best, best_set, its = tabu(secs, seed)
    print(f"  B: best clash-free set found = {best} cells ({its} swap moves)")
    print("  cells:", " ".join(f"{cells[v][0]},{cells[v][1]}" for v in best_set))
