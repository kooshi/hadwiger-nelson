"""Implicit-hitting-set engine for μ (exact minimum d-edge counts), SAT-backed.

    μ = min |S ⊆ E_d| such that (unit ∪ S) has NO k-colouring satisfying `witness` (either "proper"
    = non-colourability, or "A ≠ B" = the forced-pair framing).

Loop: S := a minimum hitting set of the mono-sets collected so far (SAT + Sinz at-most-k counter,
bound raised from the running LB — every LB step is rigorous: any forcing S hits every collected
colouring's mono set, and each colouring is validated in-process); ask the oracle for a witness
colouring of unit ∪ S; if found, MINIMIZE its mono set (force edges of it proper one at a time while
a witness survives — a colouring whose mono set is single-edge-minimal is a much stronger row),
add the row, repeat; when the oracle says UNSAT, |S| = μ exactly. Oracle `unknown` at cap ends the
run with the sandwich [LB, UB] reported as such.
"""
from __future__ import annotations
import random, time
import sys
import os; sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import coloring, rigidity, forcer  # noqa
from twodist import _brk_full, _degree_order  # noqa


def atmost_k(xs: list[int], k: int, top: int) -> tuple[list[list[int]], int]:
    """Sinz sequential counter: at most k of the (positive) variables xs are true. Returns clauses
    and the new top variable. k >= 0; k == 0 forbids all."""
    m = len(xs)
    if k == 0:
        return [[-x] for x in xs], top
    if k >= m:
        return [], top
    s = [[0] * (k + 1) for _ in range(m + 1)]  # s[i][j], 1-based i in 1..m-1, j in 1..k
    for i in range(1, m):
        for j in range(1, k + 1):
            top += 1; s[i][j] = top
    cls = []
    x = [0] + xs
    cls.append([-x[1], s[1][1]])
    for j in range(2, k + 1): cls.append([-s[1][j]])
    for i in range(2, m):
        cls.append([-x[i], s[i][1]]); cls.append([-s[i - 1][1], s[i][1]])
        for j in range(2, k + 1):
            cls.append([-x[i], -s[i - 1][j - 1], s[i][j]]); cls.append([-s[i - 1][j], s[i][j]])
        cls.append([-x[i], -s[i - 1][k]])
    cls.append([-x[m], -s[m - 1][k]])
    return cls, top


def _selftest_atmost():
    import itertools
    for m in (3, 4, 5):
        for k in range(0, m + 1):
            xs = list(range(1, m + 1))
            cls, top = atmost_k(xs, k, m)
            for bits in itertools.product([0, 1], repeat=m):
                # unit-propagate by brute force over aux: satisfiable iff sum(bits) <= k
                assum = [[x] if b else [-x] for x, b in zip(xs, bits)]
                st, _ = forcer._solve(cls + assum, top, None)
                assert (st == "sat") == (sum(bits) <= k), (m, k, bits, st)
    return True


def _milp_hitting_set(sets, m):
    import numpy as np
    from scipy.optimize import milp, LinearConstraint, Bounds
    A = np.zeros((len(sets), m))
    for r, sset in enumerate(sets):
        A[r, sset] = 1
    res = milp(c=np.ones(m), constraints=LinearConstraint(A, lb=np.ones(len(sets)), ub=np.inf),
               integrality=np.ones(m), bounds=Bounds(0, 1))
    assert res.success, res.message
    return [j for j in range(m) if res.x[j] > 0.5]


def min_hitting_set(sets: list[list[int]], m: int, lb: int, sat_cap: float = 5.0) -> tuple[list[int], int]:
    """(S, lb') — a hitting set of minimum size (>= lb). SAT + Sinz counter finds one fast when it
    exists at the running bound; the UNSAT proof at a bound is pigeonhole-shaped and CDCL-hard, so on
    a SAT timeout the exact decision falls to the MILP (HiGHS, LP-bounded)."""
    if not sets: return [], max(lb, 0)
    base = [[j + 1 for j in s] for s in sets]
    k = max(lb, 1)
    while True:
        card, top = atmost_k(list(range(1, m + 1)), k, m)
        st, model = forcer._solve(base + card, top, sat_cap)
        if st == "sat":
            return [j for j in range(m) if (j + 1) in model], k
        if st == "unsat":
            k += 1; continue
        S = _milp_hitting_set(sets, m)
        assert len(S) >= k
        return S, len(S)


def prune(sets: list[list[int]]) -> list[list[int]]:
    """Drop supersets (they are implied) and duplicates."""
    ss = sorted((frozenset(s) for s in sets), key=len)
    keep: list[frozenset] = []
    for s in ss:
        if any(t <= s for t in keep): continue
        keep.append(s)
    return [sorted(s) for s in keep]


class Mu:
    def __init__(self, n, unit, dedges, k, extra=None, cap=None, label="μ", log=print, seed=0):
        self.n, self.unit, self.d, self.k = n, list(unit), list(dedges), k
        self.extra = extra or []; self.cap = cap; self.label = label; self.log = log
        self.rng = random.Random(seed)
        self.sets: list[list[int]] = []
        self.lb = 0; self.it = 0; self.oracle_calls = 0

    def save(self, path):
        import json
        json.dump({"sets": self.sets, "lb": self.lb, "it": self.it, "oracle_calls": self.oracle_calls}, open(path, "w"))

    def load(self, path):
        import json, os
        if not os.path.exists(path): return False
        d = json.load(open(path)); self.sets, self.lb, self.it, self.oracle_calls = d["sets"], d["lb"], d["it"], d["oracle_calls"]
        return True

    def oracle(self, S, forced_proper=()):
        edges = self.unit + [self.d[j] for j in S] + [self.d[j] for j in forced_proper]
        cls = coloring.base_clauses(self.n, edges, self.k) + rigidity.amo_clauses(self.n, self.k)
        cls += _brk_full(self.n, self.k, _degree_order(self.n, edges)) + self.extra
        self.oracle_calls += 1
        st, model = forcer._solve(cls, self.n * self.k, self.cap)
        if st != "sat": return st, None
        col = rigidity.decode(model, self.n, self.k)
        for a, b in edges: assert col[a] != col[b]
        return st, col

    def mono(self, col):
        return [j for j, (a, b) in enumerate(self.d) if col[a] == col[b]]

    def minimize(self, S, col, budget=None):
        """Force the mono edges proper one at a time (random order); keep the last surviving
        colouring. Returns a colouring whose mono set is minimal under single-edge forcing."""
        forced = []
        M = self.mono(col)
        self.rng.shuffle(M)
        calls = 0
        for j in M:
            if budget is not None and calls >= budget: break
            if col[self.d[j][0]] != col[self.d[j][1]]: continue  # already proper in the current col
            calls += 1
            st, col2 = self.oracle(S, forced + [j])
            if st == "sat":
                forced.append(j); col = col2
            elif st != "unsat":
                break  # cap: keep what we have
        return col

    def run(self, minimize=True, report_every=25, max_iters=None, budget=None, checkpoint=None, state=None):
        t0 = time.time()
        while True:
            S, self.lb = min_hitting_set(self.sets, len(self.d), self.lb)
            self.it += 1
            st, col = self.oracle(S)
            if st == "unsat":
                self.log(f"[{self.label}] EXACT mu = {len(S)} after {self.it} iterations, "
                         f"{self.oracle_calls} oracle calls, {time.time()-t0:.0f}s")
                return {"status": "exact", "mu": len(S), "S": S, "iterations": self.it,
                        "oracle_calls": self.oracle_calls, "seconds": round(time.time() - t0, 1)}
            if st != "sat":
                self.log(f"[{self.label}] STALL: oracle unknown at cap with |S| = {len(S)}; LB = {self.lb}")
                return {"status": "stalled", "lb": self.lb, "candidate": S, "iterations": self.it,
                        "oracle_calls": self.oracle_calls, "seconds": round(time.time() - t0, 1)}
            if minimize: col = self.minimize(S, col, budget)
            M = self.mono(col)
            assert M, "a witness colouring proper on every d-edge: the object does not force"
            self.sets.append(M)
            if self.it % report_every == 0:
                self.sets = prune(self.sets)
                self.log(f"[{self.label}] it {self.it}: LB = {self.lb}  rows {len(self.sets)}  "
                         f"oracle {self.oracle_calls}  {time.time()-t0:.0f}s")
                if checkpoint: checkpoint(self)
                if state: self.save(state)
            if max_iters and self.it >= max_iters:
                return {"status": "paused", "lb": self.lb, "iterations": self.it}


if __name__ == "__main__":
    print("atmost_k self-test:", _selftest_atmost())
