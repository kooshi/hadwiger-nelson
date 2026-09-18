#!/usr/bin/env python3
"""Chromatic numbers of sum-of-squares Cayley graphs over finite fields, in any dimension.

    UD(F_q, n) = Cay(F_q^n, {v != 0 : sum v_i^2 = 1})

For n = 2 and q = 3 (mod 4) this is the finite Euclidean plane the field sieve uses
(tools/fplane.py is the production instrument for those; this one is deliberately naive and
independent, so it can serve as a control on them, and it generalises to any n).

Minted for FS-62 (CLAUDE.md G64): does the value 6 ever occur as the chromatic number of one of
these graphs?  Answer so far: not in dimension 2 anywhere it has been decided, and the dimension-3
probe is UNINFORMATIVE -- every case it can decide is 3 or >= 7, so a 6 was never reachable at
those sizes.  See data/fs62/README.md.

NOTHING HERE IS TRUSTED.  It proposes; a value is a value because a solver said UNSAT at k-1 and
SAT at k, and the only claims this project stands behind in the kernel are in Proofs/.

Positive control (run it before believing any zero, G30):

    python3 tools/fq_chi.py 2 3 7 9 11 19      -> 3, 4, 3, 5, 5

which are [Moorhouse2010] Table 6.1's values and the kernel's at 11.

Symmetry breaking (CLAUDE.md, "Break the symmetry before any (UN)SAT search"): a greedy clique is
pinned, and the residual colour symmetry is killed by a precedence ladder over the vertex order.
An UNKNOWN at a budget is a fact about this encoding, never about the graph.

Usage:  python3 tools/fq_chi.py <dim> <q> [<q> ...]     env: TO=<seconds per SAT call>
"""

import os
import subprocess
import sys
import time

CADICAL = os.path.join(
    os.environ.get("LEAN_PREFIX", "/home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0"),
    "bin", "cadical")
SCRATCH = os.environ.get("FQ_SCRATCH", "/tmp")

# Monic irreducible polynomials, coefficients low-to-high, degree k, for the prime powers we build.
IRR = {4: (2, [1, 1]), 8: (2, [1, 1, 0]), 9: (3, [1, 0]), 16: (2, [1, 1, 0, 0]),
       25: (5, [2, 0]), 27: (3, [1, 2, 0]), 32: (2, [1, 0, 1, 0, 0]), 49: (7, [1, 0]),
       64: (2, [1, 1, 0, 0, 0, 0]), 81: (3, [1, 2, 0, 0]), 121: (11, [1, 0]), 169: (13, [1, 0])}


def is_prime(n):
    return n > 1 and all(n % i for i in range(2, int(n ** 0.5) + 1))


def field(q):
    """Addition and squaring tables for F_q, elements indexed 0..q-1.

    In characteristic 2 the quadratic form x^2+y^2 = (x+y)^2 is degenerate and the graph is not the
    finite Euclidean plane; those targets are Cay(F_{Q^2}, mu_{Q+1}) instead (FS-54).  Refused here
    rather than silently computing the wrong object.
    """
    if is_prime(q):
        add = [[(a + b) % q for b in range(q)] for a in range(q)]
        sq = [(a * a) % q for a in range(q)]
        if q == 2:
            raise ValueError("characteristic 2: the form is degenerate, see FS-54")
        return add, sq
    if q not in IRR:
        raise ValueError(f"no irreducible polynomial on file for q={q}")
    p, c = IRR[q]
    if p == 2:
        raise ValueError(f"q={q} has characteristic 2: the form is degenerate, see FS-54")
    k = len(c)

    def tovec(i):
        v = []
        for _ in range(k):
            v.append(i % p)
            i //= p
        return v

    def frvec(v):
        s = 0
        for d in reversed(v):
            s = s * p + d
        return s

    def mul(a, b):
        va, vb = tovec(a), tovec(b)
        r = [0] * (2 * k - 1)
        for i in range(k):
            if va[i]:
                for j in range(k):
                    r[i + j] = (r[i + j] + va[i] * vb[j]) % p
        for d in range(2 * k - 2, k - 1, -1):
            co = r[d]
            if co:
                r[d] = 0
                for j in range(k):
                    r[d - k + j] = (r[d - k + j] - co * c[j]) % p
        return frvec(r[:k])

    def add2(a, b):
        va, vb = tovec(a), tovec(b)
        return frvec([(x + y) % p for x, y in zip(va, vb)])

    return ([[add2(a, b) for b in range(q)] for a in range(q)],
            [mul(a, a) for a in range(q)])


def build(q, n):
    """Vertices F_q^n indexed 0..q^n-1; adjacency by the norm-one connection set."""
    add, sq = field(q)
    V = q ** n

    def tovec(i):
        v = []
        for _ in range(n):
            v.append(i % q)
            i //= q
        return v

    def frvec(v):
        s = 0
        for d in reversed(v):
            s = s * q + d
        return s

    S = []
    for i in range(1, V):
        v = tovec(i)
        t = 0
        for x in v:
            t = add[t][sq[x]]
        if t == 1:                       # the field element 1 is index 1 in both representations
            S.append(v)
    adj = [[frvec([add[v[t]][s[t]] for t in range(n)]) for s in S]
           for v in (tovec(i) for i in range(V))]
    return V, len(S), adj


def greedy_clique(adj):
    """A clique through vertex 0; the graph is vertex-transitive so 0 is no loss."""
    aset = [set(a) for a in adj]
    best = [0]
    cand = list(adj[0])
    while cand:
        pick = max(cand, key=lambda u: len(aset[u].intersection(cand)))
        best.append(pick)
        cand = [u for u in cand if u in aset[pick]]
    return best


def sat_colorable(V, adj, k, clique, timeout):
    """Is there a proper k-colouring?  True / False / None (budget exhausted)."""
    head = clique[:k]
    order = head + [v for v in range(V) if v not in set(head)]
    pos = {v: i for i, v in enumerate(order)}

    def x(v, c):
        return pos[v] * k + c + 1

    nx = V * k

    def u(i, c):                          # "colour c has appeared among order[0..i]"
        return nx + i * k + c + 1

    cls = [[x(v, c) for c in range(k)] for v in range(V)]
    for v in range(V):
        for w in adj[v]:
            if w > v:
                cls.extend([-x(v, c), -x(w, c)] for c in range(k))
    for j, v in enumerate(head):
        cls.append([x(v, j)])
    for i, v in enumerate(order):         # precedence ladder: kills the residual colour symmetry
        for c in range(k):
            cls.append([-x(v, c), u(i, c)])
            if i:
                cls.append([-u(i - 1, c), u(i, c)])
                cls.append([-u(i, c), u(i - 1, c), x(v, c)])
            else:
                cls.append([-u(i, c), x(v, c)])
            if c >= 1:
                cls.append([-x(v, c)] if i == 0 else [-x(v, c), u(i - 1, c - 1)])

    path = os.path.join(SCRATCH, f"fq-{os.getpid()}-{V}-{k}.cnf")
    with open(path, "w") as fh:
        fh.write(f"p cnf {nx + V * k} {len(cls)}\n")
        fh.write("".join(" ".join(map(str, c)) + " 0\n" for c in cls))
    t0 = time.time()
    out = subprocess.run([CADICAL, "-q", "-t", str(timeout), path],
                         capture_output=True, text=True).stdout
    elapsed = time.time() - t0
    os.remove(path)
    if "s SATISFIABLE" in out:
        return True, elapsed
    if "s UNSATISFIABLE" in out:
        return False, elapsed
    return None, elapsed


def chi(q, n, timeout, kmax=12):
    V, deg, adj = build(q, n)
    cl = greedy_clique(adj)
    res = {"q": q, "n": n, "V": V, "degree": deg, "clique": len(cl)}
    k = len(cl)
    while k <= kmax:
        ok, elapsed = sat_colorable(V, adj, k, cl, timeout)
        if ok is True:
            res.update(chi=k, lower=k, upper=k)
            return res
        if ok is None:
            res.update(lower=k, upper=None,
                       note=f"undecided at k={k} after {elapsed:.0f}s; k<{k} refuted")
            return res
        k += 1
    res.update(lower=k, upper=None, note=f"every k<{kmax} refuted")
    return res


if __name__ == "__main__":
    if len(sys.argv) < 3:
        sys.exit(__doc__)
    dim = int(sys.argv[1])
    for q in (int(a) for a in sys.argv[2:]):
        print(chi(q, dim, int(os.environ.get("TO", "120"))), flush=True)
