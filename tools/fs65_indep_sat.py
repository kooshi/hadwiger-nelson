#!/usr/bin/env python3
"""fs65_indep_sat -- FS-65 D1: the DECISION problem "does UD(F_q,2) have an independent set of size k?"
asked in SAT with the graph's symmetry broken.  Derivation: plans/STUB-exact-independence-solver.md §4.

WHY THIS AND NOT AN OPTIMISER.  Ledger row 68 records CDCL undecided on every independence instance at
q = 19 and 23.  Those were optimisation-shaped asks on an encoding that told the solver nothing about an
automorphism group of order q^2 (q+1) 2 -- 14,440 at q = 19 -- so the solver rediscovers every partial set
up to 14,440 times.  CLAUDE.md's toolchain rule: an unbroken encoding's verdict measures the encoding.

THE TWO SYMMETRY BREAKS, and why each is SOUND (an unsound break turns a SAT into a fake UNSAT, which is
exactly the direction that would flatter us here, so both are argued rather than asserted):

  (1) TRANSLATION -- by the CENTROID, not by pinning the origin (--break centroid, the default).
      For a set S of size k with gcd(k, q) = 1 the sum c(S) = sum_{v in S} v over F_q^2 satisfies
      c(S + t) = c(S) + k*t, and t -> k*t is a bijection, so EXACTLY ONE translate of S has c = 0.
      Imposing

          sum_{(a,b) in S} a = 0 (mod q)   and   sum_{(a,b) in S} b = 0 (mod q)

      therefore keeps exactly one representative per translation orbit: the full q^2.

      RETRACTION, recorded so the error is not repeated.  This file used to pin the origin into the
      set (x_0 = true, --break origin), on the argument that some translate of any independent set
      contains the origin.  That is true and it is sound, but it is worth only q^2/k, not q^2: a
      78-set at q = 19 has trivial translation stabiliser, so its orbit has 361 members of which 78
      contain the origin -- a reduction of 4.63, not 361.  Every earlier reading of "the hardness is
      in the instance, not the encoding" was taken with a factor of 78 of the symmetry unbroken.
      (External review, 2026-09-18; verified here.)

  (2) ROTATION + REFLECTION.  What stabilises the origin is the orthogonal group of x^2 + y^2 over F_q.
      For q = 3 (mod 4) the form is anisotropic, so the rotations are the norm-one group of F_{q^2},
      cyclic of order q+1, and with the reflection (x,y) -> (x,-y) the stabiliser has order 2(q+1) -- 40
      at q = 19.  Among each orbit of that group we keep only the LEXICOGRAPHICALLY SMALLEST
      characteristic vector: every orbit has one, so again no solution is lost.  Encoded as one
      "x <= g(x)" chain per non-identity g (Crawford-style lex-leader).

      IT COMPOSES WITH THE CENTROID BREAK.  Every g here is linear, so c(g(S)) = g(c(S)) = g(0) = 0:
      the centroid-zero sets are stable under the orthogonal group, and taking the lex-least of each
      orbit inside that stable class loses nothing.  Together the two breaks quotient the full
      automorphism group of order q^2 * 2(q+1) -- 14,440 at q = 19.

  Both breaks are verified in code, not trusted: every g is checked to fix 0 and to preserve adjacency,
  the group is checked to be closed and of the expected order, gcd(k, q) = 1 is asserted before the
  centroid break is used, and any model is checked to satisfy the centroid equations.

CONTROLS (--selftest, one command, three of them):
  (a) the modular-sum encoding, two-sided: over a small residue ring every assignment is fixed by unit
      clauses and the solver's verdict compared against the arithmetic, so an encoding that forbids too
      much fails exactly as loudly as one that forbids too little;
  (b) q = 11, k = 28 must come back SAT -- alpha(UD(F_11,2)) = 28 exactly (ledger row 70) -- with the
      model re-verified independent from the graph definition;
  (c) q = 11, k = 29 must come back UNSAT.
  A symmetry break that has gone unsound shows up as a spurious UNSAT at (b).

  UNSAT here is a real refutation: alpha(UD(F_q,2)) < k.  SAT exhibits a set, printed and verified.
  UNKNOWN at a budget is a statement about the budget and is reported as one.
"""

from __future__ import annotations

import argparse
import json
import math
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


def translations(q):
    """the q^2 translations as permutations of the vertices."""
    return [tuple(((v // q + tx) % q) * q + ((v % q + ty) % q) for v in range(q * q))
            for tx in range(q) for ty in range(q)]


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


def at_most(cnf, lits, r):
    """Sinz sequential counter: at most r of lits are true."""
    n = len(lits)
    if r >= n: return
    R = [[cnf.new() for _ in range(r)] for _ in range(n)]
    cnf.add(-lits[0], R[0][0])
    for j in range(1, r): cnf.add(-R[0][j])
    for i in range(1, n):
        cnf.add(-lits[i], R[i][0])
        cnf.add(-R[i - 1][0], R[i][0])
        for j in range(1, r):
            cnf.add(-lits[i], -R[i - 1][j - 1], R[i][j])
            cnf.add(-R[i - 1][j], R[i][j])
        cnf.add(-lits[i], -R[i - 1][r - 1])


def mod_sum_zero(cnf, lits, coeffs, q):
    """sum_i coeffs[i] * lits[i] = 0 (mod q), by a BACKWARD residue chain.

    The state s_i^m means "the first i terms sum to m (mod q)".  Level 0 is the constant state 0 and
    the final level is the constant state 0 (that is the assertion).  Per level and state we emit only
    the two BACKWARD implications

        s_i^m -> ( x_i -> s_{i-1}^{m - c_i} )    and    s_i^m -> ( ~x_i -> s_{i-1}^{m} ),

    which is enough on its own: an assignment whose true sum is t chains the asserted final state down
    to s_0^{-t}, and level 0 admits only state 0, so t != 0 is refuted.  Nothing ever forces a state
    variable TRUE, so no at-most-one over the q states is needed -- that would have cost q(q-1)/2
    clauses per level, about 58,000 per equation at q = 19, against the 2q it costs this way.

    Terms with coefficient 0 (mod q) are dropped, so at q = 19 each equation runs over 342 of the 361
    variables.  Returns the number of auxiliary variables minted.
    """
    terms = [(l, c % q) for l, c in zip(lits, coeffs) if c % q]
    if not terms:
        return 0
    before = cnf.n
    prev = [True] + [False] * (q - 1)               # level 0: the empty sum is 0
    for j, (x, c) in enumerate(terms):
        last = j == len(terms) - 1
        cur = [(m == 0) if last else cnf.new() for m in range(q)]
        for m in range(q):
            s = cur[m]
            if s is False:
                continue                            # an unreachable final state: nothing to say
            for take, src in ((True, prev[(m - c) % q]), (False, prev[m])):
                if src is True:
                    continue                        # the implication is already satisfied
                cl = [] if s is True else [-s]
                cl.append(-x if take else x)
                if src is not False:
                    cl.append(src)
                cnf.add(*cl)
        prev = cur
    return cnf.n - before


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

def cadical_path():
    lean = subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True).stdout.strip()
    return f"{lean}/bin/cadical"


def run_cnf(cnf, path, timeout, cad=None):
    """write, solve, and return (verdict, the solver's stdout, seconds)."""
    cnf.write(path)
    t0 = time.time()
    p = subprocess.run([cad or cadical_path(), "-q", "-t", str(int(timeout)), str(path)],
                       capture_output=True, text=True)
    dt = time.time() - t0
    out = p.stdout
    v = "SAT" if "s SATISFIABLE" in out else ("UNSAT" if "s UNSATISFIABLE" in out else "UNKNOWN")
    return v, out, dt


def base_cnf(q, k, brk="centroid", lex=True, exact=False):
    """the symmetry-broken encoding of "alpha(UD(F_q,2)) >= k".

    THE ONE PLACE the encoding lives: the cube driver builds its base through this function too, so
    the two cannot drift apart and a break argued here is the break both of them run.  Returns
    (n, adj, cnf, X, G, aux_centroid); every group control is run before the breaks are applied."""
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

    aux_centroid = 0
    if brk == "origin":                         # break (1), the weak form: worth q^2/k only
        cnf.add(X[0])
        for w in adj[0]:
            cnf.add(-X[w])
    elif brk == "centroid":                     # break (1), the exact form: worth q^2
        assert math.gcd(k, q) == 1, (
            f"the centroid break needs gcd(k, q) = 1 (t -> k*t must be a bijection); "
            f"gcd({k}, {q}) = {math.gcd(k, q)}")
        aux_centroid += mod_sum_zero(cnf, X, [v // q for v in range(n)], q)
        aux_centroid += mod_sum_zero(cnf, X, [v % q for v in range(n)], q)
    elif brk == "lex":                          # break (1), a third form: lex-least of the orbit
        # Imposing x <= t(x) for every translation t keeps the lex-least member of each FULL orbit,
        # which no constraint can remove, so a subset of the group is as sound as all of it.  The
        # reduction is the full q^2 like the centroid, but encoded in chains rather than modular
        # counters -- the measurement that motivates it is in data/fs62/q19/README.md.
        ident_t = tuple(range(n))
        for t in translations(q):
            if t != ident_t:
                lex_le(cnf, X, t)
    elif brk != "none":
        raise ValueError(brk)

    if lex:                                     # break (2)
        for g in G:
            if g != ident:
                lex_le(cnf, X, g)

    at_least_k(cnf, X, k)
    if exact:
        at_most(cnf, X, k)
    return n, adj, cnf, X, G, aux_centroid


def decide(q, k, brk="centroid", lex=True, exact=False, timeout=3600.0, workdir="/tmp", cad=None):
    """the decision problem at (q, k) under the chosen symmetry breaks; returns the record."""
    n, adj, cnf, X, G, aux_centroid = base_cnf(q, k, brk, lex, exact)
    edges = sum(len(s) for s in adj) // 2

    tag = f"fs65-q{q}-k{k}-{brk}{'' if lex else '-nolex'}{'-exact' if exact else ''}"
    verdict, out, dt = run_cnf(cnf, Path(workdir) / f"{tag}.cnf", timeout, cad)

    rec = {
        "kind": "fs65-indep-decision", "q": q, "n": n, "degree": q + 1, "edges": edges,
        "k_asked": k, "verdict": verdict, "seconds": round(dt, 2),
        "symmetry": {"translation_break": brk,
                     "translation_orbit_reduction": (q * q if brk in ("centroid", "lex") else
                                                     round(q * q / k, 2) if brk == "origin" else 1),
                     "stabiliser_lex_broken": lex,
                     "stabiliser_order": len(G),
                     "cardinality_exact": exact,
                     "centroid_aux_vars": aux_centroid},
        "cnf": {"vars": cnf.n, "clauses": len(cnf.cls)},
        "claim_scope": ("UNSAT means no independent set of this size exists, so alpha < k. The breaks are "
                        "sound: with gcd(k,q)=1 exactly one translate of a k-set has coordinate sums zero, "
                        "the orthogonal group preserves that condition, and every orbit has a lex-least "
                        "member. UNKNOWN is a statement about the budget."),
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
        rec["centroid"] = [sum(v // q for v in model) % q, sum(v % q for v in model) % q]
        rec["set"] = sorted(model)
        assert not bad, "solver returned a set that is NOT independent"
        assert len(model) >= k, f"solver returned {len(model)} < {k}"
        if brk == "centroid" and len(model) == k:
            assert rec["centroid"] == [0, 0], "the model violates the centroid equations"

    return rec


def report(rec, lex, brk):
    line = (f"q={rec['q']} k={rec['k_asked']} -> {rec['verdict']} in {rec['seconds']:.1f}s "
            f"({rec['cnf']['vars']} vars, {rec['cnf']['clauses']} clauses, "
            f"break={brk}{'' if lex else ', lex OFF'})")
    if rec["verdict"] == "SAT":
        line += f"  [set of {rec['set_size']}, verified independent]"
    print(line, flush=True)


def centroid_orbit_control(q, ks, trials=200, seed=20260919):
    """THE LOAD-BEARING CLAIM, checked on sets rather than argued: for gcd(k,q) = 1 exactly one of
    the q^2 translates of a k-set satisfies both coordinate-sum equations, and for q | k the count
    is 0 or q^2 -- which is why the encoder refuses that case instead of answering it."""
    import random
    rng = random.Random(seed)
    rows = []
    for k in ks:
        counts = set()
        for _ in range(trials):
            S = rng.sample(range(q * q), k)
            hit = 0
            for tx in range(q):
                for ty in range(q):
                    if (sum((v // q + tx) % q for v in S) % q == 0 and
                            sum((v % q + ty) % q for v in S) % q == 0):
                        hit += 1
            counts.add(hit)
        rows.append((k, math.gcd(k, q), sorted(counts)))
    return rows


def selftest(workdir):
    """(a) the modular-sum encoding two-sided, (b) q=11 k=28 SAT, (c) q=11 k=29 UNSAT,
    (d) the translate count itself, on both sides of the gcd condition."""
    cad = cadical_path()
    ok = True

    # (a) every assignment of a small instance, fixed by unit clauses, against the arithmetic.
    qs, coeffs = 5, [3, 1, 4, 1, 0, 2, 3]
    wrong = 0
    for mask in range(1 << len(coeffs)):
        cnf = CNF(len(coeffs))
        xs = [i + 1 for i in range(len(coeffs))]
        mod_sum_zero(cnf, xs, coeffs, qs)
        for i, x in enumerate(xs):
            cnf.add(x if (mask >> i) & 1 else -x)
        v, _, _ = run_cnf(cnf, Path(workdir) / "fs65-selftest.cnf", 10, cad)
        want = "SAT" if sum(c for i, c in enumerate(coeffs) if (mask >> i) & 1) % qs == 0 else "UNSAT"
        if v != want:
            wrong += 1
    print(f"(a) modular sum, q={qs}, {1 << len(coeffs)} assignments: "
          f"{'PASS' if not wrong else f'FAIL ({wrong} disagree)'}", flush=True)
    ok &= not wrong

    # (b), (c) the value known exactly: alpha(UD(F_11,2)) = 28.
    for k, want in ((28, "SAT"), (29, "UNSAT")):
        rec = decide(11, k, brk="centroid", lex=True, timeout=600, workdir=workdir, cad=cad)
        good = rec["verdict"] == want
        print(f"({'b' if k == 28 else 'c'}) q=11 k={k}: {rec['verdict']} in {rec['seconds']:.1f}s "
              f"(want {want}) {'PASS' if good else 'FAIL'}"
              + (f"  centroid {rec['centroid']}, independent {rec['verified_independent']}"
                 if rec["verdict"] == "SAT" else ""), flush=True)
        ok &= good

    # (d) the normalisation itself, and its own failure mode
    for q, ks in ((19, (78, 76)), (11, (28, 29, 33))):
        for k, g, counts in centroid_orbit_control(q, ks):
            want = [1] if g == 1 else [0, q * q]
            good = all(c in want for c in counts)
            print(f"(d) q={q} k={k}: gcd={g}, translates with both sums zero = {counts} "
                  f"(want {'exactly 1' if g == 1 else '0 or q^2'}) {'PASS' if good else 'FAIL'}",
                  flush=True)
            ok &= good
            if g != 1:                           # and the encoder must REFUSE, not answer
                try:
                    base_cnf(q, k, brk="centroid")
                    print(f"(d) q={q} k={k}: the encoder ACCEPTED an unsound break  FAIL", flush=True)
                    ok = False
                except AssertionError:
                    print(f"(d) q={q} k={k}: the encoder refuses the unsound break  PASS", flush=True)

    print("SELFTEST " + ("PASS" if ok else "FAIL"))
    return 0 if ok else 1


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--q", type=int)
    ap.add_argument("--k", type=int, help="the size asked for")
    ap.add_argument("--timeout", type=float, default=3600.0)
    ap.add_argument("--break", dest="brk", choices=("centroid", "origin", "lex", "none"),
                    default="centroid",
                    help="how the translations are broken: centroid and lex are exact (q^2), "
                         "origin is worth only q^2/k")
    ap.add_argument("--no-lex", action="store_true", help="drop the orthogonal break (for comparison)")
    ap.add_argument("--exact", action="store_true", help="also cap the set at k (|S| = k exactly)")
    ap.add_argument("--expect", choices=("SAT", "UNSAT"), help="fail the run if the verdict differs")
    ap.add_argument("--selftest", action="store_true", help="run the controls and exit")
    ap.add_argument("--out", help="where the record goes")
    ap.add_argument("--workdir", default="/tmp")
    a = ap.parse_args()

    if a.selftest:
        return selftest(a.workdir)
    if a.q is None or a.k is None:
        ap.error("--q and --k are required unless --selftest")

    rec = decide(a.q, a.k, brk=a.brk, lex=not a.no_lex, exact=a.exact,
                 timeout=a.timeout, workdir=a.workdir)
    report(rec, not a.no_lex, a.brk)
    if a.out:
        Path(a.out).write_text(json.dumps(rec, indent=1))
    if a.expect and rec["verdict"] != a.expect:
        print(f"EXPECTED {a.expect}, GOT {rec['verdict']}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
