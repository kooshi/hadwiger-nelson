#!/usr/bin/env python3
"""arena_sweep — the arity-2 compulsion sweep at a scale where the pair list cannot be
walked in Python.  M63 phase H4.

WHAT IT DECIDES.  For a graph G and a colour count k:
  * `Forces G k p q`     -- every proper k-colouring gives p and q the SAME colour;
  * `Separated G k p q`  -- every proper k-colouring gives them DIFFERENT colours, p,q non-adjacent.

SOUNDNESS, and it is the whole design.  A pair is REFUTED by exhibiting one proper
k-colouring that answers the other way.  Every colouring this tool consumes is re-verified
edge by edge before it is used, so a refutation is a witness and is sound **no matter how
the colouring was produced** -- the generator's coverage affects only how many pairs are
left over, never whether a refutation is correct.  The survivor set is therefore always a
SUPERSET of the true compulsion set: no positive can escape it.  That is the same superset
logic phase H2's refutation runs on.

WHY NOT `tools/rigidity.py`.  Same engine idea (draw models, refute in bulk), but its
book-keeping is a Python set of co-coloured pairs -- about 2.6e8 inserts per model at
n = 51,133 -- and its `ne_candidates` is a double loop over C(n,2) = 1.31e9.  Here the
co-colour relation is a packed bit matrix (n x ceil(n/8) uint8; 327 MB at n = 51,133) and
one model costs one `|=` per colour class.

UNTRUSTED like everything under tools/.  Nothing here is a certificate; the certificates
are the exhibited colourings, each re-verifiable against the edge list.
"""
from __future__ import annotations
import json, sys, time
import numpy as np


class Sweep:
    """Co-colour bookkeeping over a stream of verified proper colourings."""

    def __init__(self, n, edges, k):
        self.n, self.k = n, k
        self.edges = [(min(a, b), max(a, b)) for a, b in edges]
        self.W = (n + 7) // 8
        # seen[u] : packed bit row, bit v set once some consumed colouring gave u and v
        # the same colour.  Diagonal is set at the start (u is trivially u's own colour).
        self.seen = np.zeros((n, self.W), dtype=np.uint8)
        # a vertex is trivially "co-coloured" with itself: set the diagonal once, so the
        # counter never has to special-case it (and cannot double-subtract it).
        for v in range(n):
            self.seen[v, v >> 3] |= np.uint8(1 << (v & 7))
        self.sigs = None          # per-vertex colour history, for the forced-pair side
        self.models = 0
        self.adj = np.zeros((n, self.W), dtype=np.uint8)
        ea = np.array(self.edges, dtype=np.int64) if self.edges else np.zeros((0, 2), np.int64)
        self._ea = ea
        for a, b in ea:
            self.adj[a, b >> 3] |= np.uint8(1 << (b & 7))
            self.adj[b, a >> 3] |= np.uint8(1 << (a & 7))

    # ---------------------------------------------------------------- ingest
    def verify(self, col):
        """Refuse anything that is not a proper k-colouring.  Loud, not silent."""
        if len(col) != self.n:
            raise SystemExit(f"COLOURING REFUSED: length {len(col)} != n {self.n}")
        c = np.asarray(col, dtype=np.int64)
        if c.min() < 0 or c.max() >= self.k:
            raise SystemExit(f"COLOURING REFUSED: colour out of range 0..{self.k-1}")
        if self._ea.shape[0]:
            bad = np.flatnonzero(c[self._ea[:, 0]] == c[self._ea[:, 1]])
            if bad.size:
                a, b = self._ea[bad[0]]
                raise SystemExit(f"COLOURING REFUSED: improper at edge {(int(a), int(b))} "
                                 f"({bad.size} improper edges)")
        return c

    def add(self, col):
        c = self.verify(col)
        for cc in range(self.k):
            cls = np.flatnonzero(c == cc)
            if cls.size == 0:
                continue
            ind = np.zeros(self.n, dtype=bool)
            ind[cls] = True
            packed = np.packbits(ind, bitorder="little")
            self.seen[cls] |= packed
        self.sigs = c.reshape(-1, 1) if self.sigs is None else np.hstack([self.sigs, c.reshape(-1, 1)])
        self.models += 1

    # ------------------------------------------------------- the two survivor sets
    def forced_candidates(self):
        """Pairs agreeing in EVERY consumed colouring -- a superset of the forced pairs."""
        if self.sigs is None:
            raise SystemExit("no colourings consumed")
        buckets = {}
        for v in range(self.n):
            buckets.setdefault(self.sigs[v].tobytes(), []).append(v)
        out = []
        for m in buckets.values():
            if len(m) > 1:
                for i in range(len(m)):
                    for j in range(i + 1, len(m)):
                        out.append((m[i], m[j]))
        return out

    def separated_count(self):
        """How many NON-ADJACENT pairs were never co-coloured -- a superset of the
        virtual edges.  Counted from the packed rows; no pair list is built."""
        tot = 0
        for lo in range(0, self.n, 2048):
            hi = min(lo + 2048, self.n)
            blk = ~(self.seen[lo:hi] | self.adj[lo:hi])
            tot += int(np.bitwise_count(blk).sum())
        # subtract the lower triangle, the diagonal, and the padding bits
        pad = self.W * 8 - self.n
        tot -= self.n * pad                     # bits past n in every row, always clear
        assert tot % 2 == 0, "co-colour relation is not symmetric"
        return tot // 2

    def separated_candidates(self, cap=200000):
        out = []
        for v in range(self.n):
            blk = ~(self.seen[v] | self.adj[v])
            bits = np.unpackbits(blk, bitorder="little")[: self.n]
            bits[: v + 1] = 0
            for w in np.flatnonzero(bits):
                out.append((v, int(w)))
                if len(out) > cap:
                    return out, True
        return out, False


# ------------------------------------------------------------------ self-test
def self_test():
    ok = True

    def check(what, cond):
        nonlocal ok
        print(f"  [{'ok ' if cond else 'RED'}] {what}")
        ok = ok and cond

    # K5 minus the edge (0,1): at 4 colours {2,3,4} eats three colours and 0, 1 must both
    # take the fourth -- forced equal, and it is the only compulsion.  (At 3 colours the
    # graph is not colourable at all, which is why k = 4 is the live instantiation.)
    E = [(a, b) for a in range(5) for b in range(a + 1, 5) if (a, b) != (0, 1)]
    import itertools
    cols = [c for c in itertools.product(range(4), repeat=5) if all(c[a] != c[b] for a, b in E)]
    s = Sweep(5, E, 4)
    for c in cols:
        s.add(list(c))
    fc = s.forced_candidates()
    check(f"K5-e at k=4: forced candidates == [(0,1)]  (got {fc})", fc == [(0, 1)])
    check("K5-e at k=4: no virtual edge among non-adjacent pairs", s.separated_count() == 0)

    # PLANTED RED: a colouring that is improper must be refused, not absorbed.
    try:
        Sweep(5, E, 4).add([0, 0, 1, 2, 2])      # 3 and 4 adjacent, both colour 2
        check("an improper colouring is REFUSED", False)
    except SystemExit:
        check("an improper colouring is REFUSED", True)

    # PLANTED RED, the CONSTANT rather than the logic: a colour outside 0..k-1.
    try:
        Sweep(5, E, 4).add([0, 0, 1, 2, 4])
        check("an out-of-range colour is REFUSED", False)
    except SystemExit:
        check("an out-of-range colour is REFUSED", True)

    # PAIRED FAITHFUL STUB: the same shape, in range, must PASS -- so a reader can see the
    # refusal above came from the range check and not from the scaffolding.
    try:
        Sweep(5, E, 4).add([0, 0, 1, 2, 3])
        check("the in-range twin of that colouring is ACCEPTED", True)
    except SystemExit:
        check("the in-range twin of that colouring is ACCEPTED", False)

    # A triangle at 3 colours: every pair adjacent, so no separated candidates and no
    # forced candidates -- the uninformative outcome, confirmed reachable.
    T = [(0, 1), (1, 2), (0, 2)]
    s = Sweep(3, T, 3)
    for c in itertools.permutations(range(3)):
        s.add(list(c))
    check("triangle at k=3: 0 forced, 0 separated (the uninformative outcome fires)",
          s.forced_candidates() == [] and s.separated_count() == 0)

    # TWO-SIDED: a path 0-1-2 at 2 colours forces 0 and 2 EQUAL and has no virtual edge.
    P = [(0, 1), (1, 2)]
    s = Sweep(3, P, 2)
    for c in itertools.product(range(2), repeat=3):
        if all(c[a] != c[b] for a, b in P):
            s.add(list(c))
    check("path at k=2: forced candidates == [(0,2)]", s.forced_candidates() == [(0, 2)])

    # The separated counter against a brute-force count, on a random graph.
    import random
    rng = random.Random(7)
    n = 40
    E = sorted({(min(a, b), max(a, b)) for a, b in
                [(rng.randrange(n), rng.randrange(n)) for _ in range(120)] if a != b})
    nb = {v: set() for v in range(n)}
    for a, b in E: nb[a].add(b); nb[b].add(a)
    kk = max(len(x) for x in nb.values()) + 1      # greedy always succeeds at maxdeg+1
    s = Sweep(n, E, kk)
    cols = []
    for _ in range(40):
        c = [None] * n
        order = list(range(n)); rng.shuffle(order)
        for v in order:
            used = {c[w] for w in nb[v] if c[w] is not None}
            pal = [x for x in range(kk) if x not in used]
            c[v] = rng.choice(pal)
        assert not any(c[a] == c[b] for a, b in E)
        cols.append(c); s.add(c)
    brute = 0
    for u in range(n):
        for v in range(u + 1, n):
            if (u, v) in set(E): continue
            if all(c[u] != c[v] for c in cols): brute += 1
    check(f"packed separated count == brute force ({s.separated_count()} vs {brute})",
          s.separated_count() == brute)
    return ok


if __name__ == "__main__":
    if "--self-test" in sys.argv:
        sys.exit(0 if self_test() else 1)
    print(__doc__)
