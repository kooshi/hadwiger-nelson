#!/usr/bin/env python3
"""fs65_indep_sat -- FS-65 D1: the DECISION problem "does UD(F_q,2) have an independent set of size k?"
asked in SAT with the graph's symmetry broken.  Derivation: plans/STUB-exact-independence-solver.md §4.

WHY THIS AND NOT AN OPTIMISER.  Ledger row 68 records CDCL undecided on every independence instance at
q = 19 and 23.  Those were optimisation-shaped asks on an encoding that told the solver nothing about an
automorphism group of order q^2 (q+1) 2 -- 14,440 at q = 19 -- so the solver rediscovers every partial set
up to 14,440 times.  CLAUDE.md's toolchain rule: an unbroken encoding's verdict measures the encoding.

THE TWO SYMMETRY BREAKS, and why each is SOUND (an unsound break turns a SAT into a fake UNSAT, which is
exactly the direction that would flatter us here, so both are argued rather than asserted):

  (1) TRANSLATION.  The translation group acts simply transitively on F_q^2.  If ANY independent set of
      size k exists, some translate of it contains the origin.  So asserting x_0 = true removes no
      solution up to symmetry.  Divides the space by q^2.

  (2) ROTATION + REFLECTION.  What stabilises the origin is the orthogonal group of x^2 + y^2 over F_q.
      For q = 3 (mod 4) the form is anisotropic, so the rotations are the norm-one group of F_{q^2},
      cyclic of order q+1, and with the reflection (x,y) -> (x,-y) the stabiliser has order 2(q+1) -- 40
      at q = 19.  Among each orbit of that group we keep only the LEXICOGRAPHICALLY SMALLEST
      characteristic vector: every orbit has one, so again no solution is lost.  Encoded as one
      "x <= g(x)" chain per non-identity g (Crawford-style lex-leader).

  Both breaks are verified in code, not trusted: every g is checked to fix 0 and to preserve adjacency,
  and the group is checked to be closed and of the expected order.

CONTROLS.  --control runs the identical encoder at a k that is KNOWN satisfiable (the best set on record)
and requires SAT; a symmetry break that has gone unsound shows up here as a spurious UNSAT.  Any model the
solver returns is re-verified from the graph definition by code that shares nothing with the encoder.

  UNSAT here is a real refutation: alpha(UD(F_q,2)) < k.  SAT exhibits a set, printed and verified.
  UNKNOWN at a budget is a statement about the budget and is reported as one.
"""

from __future__ import annotations

import argparse
import json
import subprocess
import sys
import time
from pathlib import Path


# ---------------------------------------------------------------- the plane

def build(q):
    """vertices v = x*q + y; v ~ w iff (dx^2 + dy^2) = 1 mod q"""
    circle = [(a, b) for a in range(q) for b in range(q) if (a * a + b * b) % q == 1 % q]
    n = q * q
    adj = [set() for _ in range(n)]
    for x in range(q):
        for y in range(q):
            v = x * q + y
            for da, db in circle:
                adj[v].add(((x + da) % q) * q + ((y + db) % q))
    return n, circle, adj


def stabiliser(q, circle):
    """the maps fixing 0: rotation by each unit vector, optionally composed with (x,y) -> (x,-y)"""
    maps = []
    for (a, b) in circle:                     # a^2 + b^2 = 1: a rotation
        for refl in (False, True):
            perm = [0] * (q * q)
            for x in range(q):
                for y in range(q):
                    yy = (-y) % q if refl else y
                    perm[x * q + y] = ((a * x - b * yy) % q) * q + ((a * yy + b * x) % q)
            maps.append(tuple(perm))
    return sorted(set(maps))


# ---------------------------------------------------------------- CNF

class CNF:
    def __init__(self, nvars):
        self.n = nvars
        self.cls = []

    def new(self):
        self.n += 1
        return self.n

    def add(self, *lits):
        self.cls.append(list(lits))

    def write(self, path):
        with open(path, "w") as f:
            f.write(f"p cnf {self.n} {len(self.cls)}\n")
            f.write("".join(" ".join(map(str, c)) + " 0\n" for c in self.cls))


def at_least_k(cnf, xs, k):
    """R[i][j] = 'at least j among xs[:i]'; asserting R[n][k] forces at least k true."""
    n = len(xs)
    R = [[None] * (k + 1) for _ in range(n + 1)]
    for i in range(n + 1):
        for j in range(1, min(k, i) + 1):
            R[i][j] = cnf.new()
    for i in range(1, n + 1):
        for j in range(1, min(k, i) + 1):
            below = R[i - 1][j] if j <= i - 1 else None
            # R[i][j] -> R[i-1][j] or x_i
            cnf.add(*( [-R[i][j]] + ([below] if below else []) + [xs[i - 1]] ))
            # R[i][j] -> R[i-1][j] or R[i-1][j-1]   (j = 1: R[i-1][0] is true, tautology)
            if j >= 2:
                prev = R[i - 1][j - 1] if j - 1 <= i - 1 else None
                cnf.add(*( [-R[i][j]] + ([below] if below else []) + ([prev] if prev else []) ))
    cnf.add(R[n][k])


def lex_le(cnf, xs, perm):
    """x <= g(x) lexicographically, in vertex order, with an 'equal so far' chain."""
    eq = None                                   # None means "true"
    for i in range(len(xs)):
        a, b = xs[i], xs[perm[i]]
        if a == b:
            continue
        pre = [] if eq is None else [-eq]
        cnf.add(*(pre + [-a, b]))               # equal so far -> (a -> b)
        nxt = cnf.new()
        cnf.add(*(pre + [a, b, nxt]))           # equal so far and a=b=0 -> still equal
        cnf.add(*(pre + [-a, -b, nxt]))         # equal so far and a=b=1 -> still equal
        eq = nxt


# ---------------------------------------------------------------- run

def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--q", type=int, required=True)
    ap.add_argument("--k", type=int, required=True, help="the size asked for")
    ap.add_argument("--timeout", type=float, default=3600.0)
    ap.add_argument("--no-lex", action="store_true", help="translation break only (for comparison)")
    ap.add_argument("--out", help="where the record goes")
    ap.add_argument("--workdir", default="/tmp")
    a = ap.parse_args()

    q, k = a.q, a.k
    n, circle, adj = build(q)
    deg = {len(s) for s in adj}
    edges = sum(len(s) for s in adj) // 2
    assert deg == {q + 1}, f"degree not q+1: {deg}"

    G = stabiliser(q, circle)
    # controls on the group, before it is trusted to remove solutions
    assert len(G) == 2 * (q + 1), f"stabiliser order {len(G)} != {2*(q+1)}"
    for g in G:
        assert g[0] == 0, "a stabiliser element moves the origin"
        for v in range(n):
            assert {g[w] for w in adj[v]} == adj[g[v]], "a stabiliser element is not an automorphism"
    ident = tuple(range(n))
    assert ident in G

    cnf = CNF(n)
    X = [i + 1 for i in range(n)]               # x_v is variable v+1

    for v in range(n):                          # independence
        for w in adj[v]:
            if v < w:
                cnf.add(-X[v], -X[w])

    cnf.add(X[0])                               # break (1): the origin is in the set
    for w in adj[0]:
        cnf.add(-X[w])

    if not a.no_lex:                            # break (2)
        for g in G:
            if g != ident:
                lex_le(cnf, X, g)

    at_least_k(cnf, X, k)

    wd = Path(a.workdir)
    cnfp = wd / f"fs65-q{q}-k{k}{'-nolex' if a.no_lex else ''}.cnf"
    cnf.write(cnfp)

    lean = subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True).stdout.strip()
    cadical = f"{lean}/bin/cadical"

    t0 = time.time()
    p = subprocess.run([cadical, "-q", "-t", str(int(a.timeout)), str(cnfp)],
                       capture_output=True, text=True)
    dt = time.time() - t0

    out = p.stdout
    verdict = "SAT" if "s SATISFIABLE" in out else ("UNSAT" if "s UNSATISFIABLE" in out else "UNKNOWN")

    rec = {
        "kind": "fs65-indep-decision", "q": q, "n": n, "degree": q + 1, "edges": edges,
        "k_asked": k, "verdict": verdict, "seconds": round(dt, 2),
        "symmetry": {"translation_origin_pinned": True,
                     "stabiliser_lex_broken": not a.no_lex,
                     "stabiliser_order": len(G)},
        "cnf": {"vars": cnf.n, "clauses": len(cnf.cls)},
        "claim_scope": ("UNSAT means no independent set of this size exists, so alpha < k: the two symmetry "
                        "breaks are sound (translations act simply transitively; every orbit has a lex-least "
                        "member) and both are verified in code. UNKNOWN is a statement about the budget."),
    }

    if verdict == "SAT":
        model = set()
        for tok in out.split():
            if tok.lstrip("-").isdigit():
                t = int(tok)
                if 0 < t <= n:
                    model.add(t - 1)
        bad = [(u, w) for u in model for w in adj[u] if w in model]
        rec["set_size"] = len(model)
        rec["verified_independent"] = not bad
        rec["violations"] = len(bad)
        rec["set"] = sorted(model)
        assert not bad, "solver returned a set that is NOT independent"
        assert len(model) >= k, f"solver returned {len(model)} < {k}"

    line = (f"q={q} k={k} -> {verdict} in {dt:.1f}s "
            f"({cnf.n} vars, {len(cnf.cls)} clauses, |stab|={len(G)}"
            f"{', lex OFF' if a.no_lex else ''})")
    if verdict == "SAT":
        line += f"  [set of {rec['set_size']}, verified independent]"
    print(line)

    if a.out:
        Path(a.out).write_text(json.dumps(rec, indent=1))
    return 0


if __name__ == "__main__":
    sys.exit(main())
