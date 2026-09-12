#!/usr/bin/env python3
"""The per-iteration minimum hitting set of `[Parts2020a]`'s reduction, solved INCREMENTALLY.

**The cost this exists to remove.** `parts_reduce.reduce_stage`'s loop alternates two solves: a
colouring ask (the SAT oracle) and a minimum hitting set over the harvested correction sets `Y`.
The oracle was assumed to be the cost. Measured on 2026-09-11 it is **27%** of the joint runs and
**2%** of the level-enumeration run D1b; the rest is the hitting set, which the loop rebuilds from
scratch every iteration -- a fresh `WCNF` and a fresh `RC2` over all of `Y` plus one soft clause per
atom.

**Why rebuilding is quadratic in the worst place.** `RC2` is core-guided: it starts from cost 0 and
raises a lower bound one unsatisfiable core at a time until the oracle reports SAT, so a solve whose
optimum is `w` costs about `w + 1` SAT calls. Here the optimum is nearly the whole graph -- 503 of
576 atoms on the joint stage -- so **every iteration pays ~504 SAT calls to re-derive the bound it
already knew**, and each of those calls is over a `Y` that has grown. Measured at the joint stage's
recorded family: 504 SAT calls, 18.1 s, of which 18.1 s is inside the oracle.

**The structural opening.** The family only ever grows: each iteration appends exactly one hard
clause -- a new correction set, or a blocking clause excluding an optimum just found -- to an
otherwise identical problem. So the cores `RC2` derived on iteration `i` are still cores on
iteration `i + 1`:

    SOUNDNESS.  Every core is an implicate of the hard clauses present when it was extracted.
                Adding hard clauses only strengthens the formula, so an earlier core stays a core
                and the accumulated cost stays a valid LOWER bound on the new optimum. The loop
                then raises it until the oracle returns SAT, which certifies optimality FOR THE
                CURRENT FORMULA. The optimum is therefore exact at every step, and the per-iteration
                cost falls to the cores the new clause actually creates -- usually none.

This is `RC2.enumerate`'s own pattern (it blocks a model with `add_clause` and calls `compute`
again), used on a family that grows for a different reason.

**What is identical and what is not.** The optimum WEIGHT is unique, and the two engines agree on it
iteration for iteration -- that is the claim, and `compare` is what checks it. The ARGMIN is not
unique, and **measured on the joint stage the two engines disagree on it almost always**: over
C4a's first 151 recorded iterations the optimum weight agreed **151/151** and the argmin agreed
**6/151**. So swapping the engine in keeps every BOUND and changes which candidate the loop asks
next at nearly every iteration -- a different trajectory, a different harvest, a different wall
clock, closing on the same level by the completeness invariant (`parts_reduce` §O2). That is a
decision for whoever integrates this, not a detail, and it is the same distinction
`parts_run.compare_records` already draws between the LEVEL (a defect if it differs) and the
HARVEST (a launch artifact). Model agreement is reported here, never gated.

**Where incrementality does NOT pay.** While the family is small the batch solve is trivial and the
incremental engine's accumulated relaxation machinery makes each of its few calls heavier: over
C4a's first 151 iterations batch spent 1.68 s and incremental 3.03 s, despite 66,860 SAT calls
against 602. The win arrives with size, which is exactly where the loop spends its hours -- so the
honest summary is that this removes a cost that grows, not a cost that is there from the start.

**Not wired in.** Nothing under `tools/` imports this module. Integration into `parts_reduce` is a
configuration freeze's business, not this module's: two five-hour reductions were running against
that file when this was written.

    python3 tools/parts_hitset.py --self-test
    python3 tools/parts_hitset.py attribution --checkpoint data/m62/ckpt/<f>.ckpt.json
    python3 tools/parts_hitset.py replay --checkpoint data/m62/ckpt/<f>.ckpt.json [--log L] \\
            [--iterations N] [--engines batch,incremental]
"""
from __future__ import annotations
import argparse, json, os, re, resource, sys, time
from dataclasses import dataclass, field

SINGLE_ATOM_WEIGHT = 1          # a rung-1 atom is one vertex


# ====================================================================== the answer
@dataclass(frozen=True)
class Optimum:
    """One solve's result: the minimum total weight of a hitting set, and one attaining it.

    `weight` is the quantity the reduction reports as its rigorous lower bound; `kept` is the
    candidate it asks next. Only `weight` is well defined -- see the module docstring."""
    weight: int
    kept: tuple[int, ...]
    sat_calls: int
    cpu_s: float


class Exhausted(Exception):
    """The hard part is unsatisfiable: no hitting set avoids every blocked set. The level is done."""


# ====================================================================== the engines
class _Engine:
    """The problem `reduce_stage` builds, once per iteration.

    atoms `0..n-1` with weights; hard: every correction set holds a kept atom, every blocked set
    holds a dropped atom, and (optionally) at least one atom of `require_any` is kept; soft: each
    atom is dropped, at weight. Minimum cost = minimum kept weight.

    `fault` plants a defect on purpose, so the equivalence check can be watched failing on the same
    code path that ships (a mutant copy of the engine would be free to drift from it):
      'skip-corr:K'  -- silently ignore the K-th correction set added (the constraint that never
                        got added -- the realistic bug, and the one an equivalence check exists for)
      'stale'        -- return the previous answer without re-solving (the check that cannot run)
      'unit-weights' -- pretend every atom weighs 1 (wrong on any rung above 1)
    """

    def __init__(self, weights, corr=(), blocked=(), require_any=None, fault=None, adapt=False):
        self.adapt = adapt
        self.w = list(weights)
        self.n = len(self.w)
        if self.n == 0:
            raise ValueError("a hitting set over no atoms is not a problem this loop can pose")
        if fault == "unit-weights":
            self.w = [1] * self.n
        self.require_any = sorted(require_any) if require_any else None
        self.fault = fault
        self.corr, self.blocked = [], []
        self.n_added = 0
        self.sat_calls = 0
        self.cpu_s = 0.0
        self.solves = 0
        self._last = None
        self._dead = False
        for c in corr:
            self.add_correction(c)
        for b in blocked:
            self.block(b)

    # --- the two ways the family grows -------------------------------------------
    def add_correction(self, c):
        """A new correction set: the kept selection must hold at least one of its atoms."""
        c = sorted(set(c))
        self.n_added += 1
        if self.fault and self.fault.startswith("skip-corr:") \
                and self.n_added == int(self.fault.split(":", 1)[1]):
            return                                   # planted: the clause is never added
        self.corr.append(c)
        self._on_hard([a + 1 for a in c])

    def block(self, b):
        """An optimum already reported, or an undecided candidate: never return this exact set."""
        b = sorted(set(b))
        self.blocked.append(b)
        self._on_hard([-(a + 1) for a in b])

    def optimum(self):
        """The minimum-weight hitting set, or `None` when none exists."""
        if self.fault == "stale" and self._last is not None:
            return self._last                        # planted: the answer that was never recomputed
        if self._dead:
            return None
        t0, c0 = time.process_time(), self.sat_calls
        kept = self._solve()
        dt = time.process_time() - t0
        self.cpu_s += dt
        self.solves += 1
        if kept is None:
            self._dead = True
            return None
        got = Optimum(weight=sum(self.w[a] for a in kept), kept=tuple(kept),
                      sat_calls=self.sat_calls - c0, cpu_s=dt)
        # Free internal control: constraints only ever grow, so the optimum can never fall. A
        # violation is a defect in the engine, not a result -- it is raised, never logged.
        if self._last is not None and got.weight < self._last.weight and not self.fault:
            raise AssertionError(
                f"the optimum FELL from {self._last.weight} to {got.weight} after adding a "
                f"constraint; the family only grows, so this is an engine defect")
        self._last = got
        return got

    def _on_hard(self, clause):                      # engines that keep solver state override this
        pass

    def _solve(self):
        raise NotImplementedError


class BatchHittingSet(_Engine):
    """What `parts_reduce` does today: a fresh `WCNF` and a fresh `RC2` per solve.

    ("Incumbent" is avoided here for this sense: `IncumbentHittingSet` below uses the
    word in its other sense, the incumbent BOUND.)

    The clauses are appended in exactly `reduce_stage`'s order -- correction sets, blocked sets,
    soft units, `require_any` -- because clause order is part of what decides which optimum the
    solver returns, and this engine is meant to be the same computation, not merely an equivalent
    one."""

    def _solve(self):
        from pysat.formula import WCNF
        from pysat.examples.rc2 import RC2
        f = WCNF()
        for c in self.corr:
            f.append([a + 1 for a in c])
        for b in self.blocked:
            f.append([-(a + 1) for a in b])
        for a in range(self.n):
            f.append([-(a + 1)], weight=self.w[a])
        if self.require_any:
            f.append([a + 1 for a in self.require_any])
        with _counting(RC2)(f, adapt=self.adapt) as rc:
            model = rc.compute()
            self.sat_calls += rc.n_sat_calls
            if model is None:
                return None
            return _kept(model, self.n)


class IncrementalHittingSet(_Engine):
    """One `RC2` for the life of the search; each new clause is added to it.

    The cores, the relaxation variables and the totalizers built for iteration `i` are all still
    valid at iteration `i + 1`, so the accumulated cost is a lower bound to resume from instead of
    a number to re-derive. Soundness is the module docstring's argument."""

    def __init__(self, weights, corr=(), blocked=(), require_any=None, fault=None, adapt=False):
        from pysat.formula import WCNF
        from pysat.examples.rc2 import RC2
        f = WCNF()
        for a in range(len(weights)):
            f.append([-(a + 1)], weight=(1 if fault == "unit-weights" else weights[a]))
        self.rc = _counting(RC2)(f, adapt=adapt)
        if require_any:
            self.rc.add_clause([a + 1 for a in sorted(require_any)])
        _Engine.__init__(self, weights, corr=corr, blocked=blocked, require_any=require_any,
                         fault=fault, adapt=adapt)

    def _on_hard(self, clause):
        self.rc.add_clause(clause)

    def _solve(self):
        model = self.rc.compute()
        # AtMost1 detection pays for itself exactly once, on the COLD formula: on the joint stage's
        # recorded family it cut the first solve from 504 SAT calls to 26 (15.8 s -> 6.3 s,
        # measured). Afterwards the soft clauses are already relaxed and re-running the detection
        # every iteration is pure cost, so it is switched off after the first solve. That first
        # solve is precisely what a RESUME pays, which is the path the flag is for.
        self.rc.adapt = False
        self.sat_calls = self.rc.n_sat_calls
        if model is None:
            return None
        kept = _kept(model, self.n)
        if sum(self.w[a] for a in kept) != self.rc.cost and not self.fault:
            raise AssertionError(f"RC2 cost {self.rc.cost} disagrees with the model's kept weight "
                                 f"{sum(self.w[a] for a in kept)}")
        return kept

    def close(self):
        self.rc.delete()


class IncumbentHittingSet(_Engine):
    """The DECISION formulation: one SAT solver, one cardinality constraint, one call per iteration.

    The two engines above both answer the question "what is the optimum?" from scratch every time --
    batch by climbing from cost 0 (`optimum + 1` SAT calls), incremental by carrying relaxation
    machinery that makes each of its few calls enormously more expensive. Measured on C4a's recorded
    family, both are bad for the same underlying reason: **the SAT calls are not the cost, the
    difficulty of each call is.**

    But the loop does not need the optimum re-derived. The family only grows, so the previous
    optimum is a valid LOWER bound, and the honest question is a decision:

        is there a hitting set of weight <= incumbent?

    one SAT call against an at-most-k constraint over the kept literals. SAT means the optimum is
    exactly the incumbent (it cannot be lower, by monotonicity); UNSAT means raise the incumbent by
    one and ask again. So an iteration that does not move the bound -- which is most of them --
    costs ONE call, and an iteration that raises it by k costs k + 1.

    The cardinality constraint is an incremental totalizer, built once and tightened in place, so
    the encoding is paid for once across the whole run rather than rebuilt per iteration.

    UNIT WEIGHTS ONLY. A totalizer counts literals, not weights, so this engine refuses a weighted
    instance rather than silently counting orbits as though they were vertices. Every rung-1 stage
    is unit-weight (one vertex per atom), which is every live run; above rung 1 use `incremental`.
    """

    def __init__(self, weights, corr=(), blocked=(), require_any=None, fault=None, adapt=False):
        from pysat.solvers import Solver
        if set(weights) != {1}:
            raise ValueError(
                f"the incumbent engine counts literals, so it needs unit weights; this instance has "
                f"weights {sorted(set(weights))}. Above rung 1 an atom is an ORBIT and its weight is "
                f"the orbit size -- use the `incremental` engine, which is weighted.")
        self.S = Solver(name="g3")
        self.tot = None
        self._tot_added = 0
        self.bound = 0
        self.calls = 0
        _Engine.__init__(self, weights, corr=corr, blocked=blocked, require_any=require_any,
                         fault=fault, adapt=adapt)
        # A free lower bound to start from: every atom forced by a singleton correction set is in
        # every hitting set. Starting at 0 would spend the first solve climbing through bounds that
        # are refuted by unit propagation alone.
        self.bound = len({c[0] for c in self.corr if len(c) == 1})

    def _on_hard(self, clause):
        self.S.add_clause(clause)

    def _ensure_totalizer(self, ub):
        """Count the KEPT atoms, to `ub`.

        The cheaper-looking encoding counts the DROPPED atoms instead -- "keep at most b" is "drop
        at least n - b", and the optimum drops only 73 of 576 where it keeps 503, so the counter
        would be a fraction of the size. **It does not work, and the self-test caught it within a
        minute of trying:** a totalizer is ONE-SIDED. Assuming `-rhs[k]` enforces `sum <= k`, but
        asserting `rhs[m-1]` does not force the sum UP to `m`, so a lower bound on the dropped count
        cannot be asserted against this encoding at all. A two-sided cardinality encoding would be
        needed, and is not what `ITotalizer` is. Recorded here because the idea is a good one and
        the next reader will have it too."""
        from pysat.card import ITotalizer
        if self.tot is None:
            self.tot = ITotalizer(lits=[a + 1 for a in range(self.n)], ubound=ub, top_id=self.n)
        elif ub > self.tot.ubound:
            self.tot.increase(ubound=ub)
        for cl in self.tot.cnf.clauses[self._tot_added:]:
            self.S.add_clause(cl)
        self._tot_added = len(self.tot.cnf.clauses)

    def _solve(self):
        w = self.bound
        while w <= self.n:
            self._ensure_totalizer(w)
            self.calls += 1
            self.sat_calls += 1
            if self.S.solve(assumptions=[-self.tot.rhs[w]]):
                self.bound = w
                return _kept(self.S.get_model(), self.n)
            w += 1
        return None                      # no hitting set at any weight: the level is exhausted

    def close(self):
        if self.tot is not None:
            self.tot.delete()
        self.S.delete()


ENGINES = {
    "batch": BatchHittingSet,
    "incremental": IncrementalHittingSet,
    "incumbent": IncumbentHittingSet,
    # `adapt` is RC2's AtMost1 detection, and it is a property of the COLD solve rather than of
    # the loop, so it is a separate engine and not a default. Measured on the joint stage's
    # recorded family it cuts the first solve 2.5x; the incremental engine turns it off after that
    # first solve. `exhaust=True` was measured on the same instance and is WORSE (29.6 s against
    # 15.8 s), so it is not offered.
    "batch-adapt": lambda w, **kw: BatchHittingSet(w, adapt=True, **kw),
    "incremental-adapt": lambda w, **kw: IncrementalHittingSet(w, adapt=True, **kw),
}


def _counting(RC2):
    """`RC2` with its SAT calls counted -- the cost model, since a solve is `optimum + 1` of them."""
    class Counting(RC2):
        n_sat_calls = 0

        def _call_oracle(self, assumptions=[], expect_interrupt=False):
            self.n_sat_calls += 1
            return RC2._call_oracle(self, assumptions=assumptions,
                                    expect_interrupt=expect_interrupt)
    return Counting


def _kept(model, n):
    """The atoms the model keeps. `reduce_stage` reads `model[a] > 0`; so does this, and it checks
    the indexing it is relying on rather than assuming it."""
    if len(model) < n:
        raise AssertionError(f"model has {len(model)} literals for {n} atoms")
    for a in (0, n - 1):
        if abs(model[a]) != a + 1:
            raise AssertionError(f"model[{a}] is variable {abs(model[a])}, not {a + 1}: the "
                                 f"position-to-variable correspondence this reads does not hold")
    return [a for a in range(n) if model[a] > 0]


# ====================================================================== the equivalence check
COMPARED_NOTHING = """the equivalence check DID NOT RUN: {why}.
  This is not a pass. A comparison that never happened must never read as agreement -- it is the
  failure mode this project keeps meeting (CLAUDE.md, 'Make the gate fail, and watch it fail')."""


def compare(a, b, names=("batch", "incremental")):
    """Two bound sequences, iteration for iteration. Only `identical` is a pass.

    The verdict is `not-compared` -- a failure -- whenever there was nothing to compare or the
    sequences are of different lengths, because a check that could not run must be louder than one
    that passed."""
    if not a or not b:
        return {"verdict": "not-compared", "compared": 0, "ok": False,
                "why": COMPARED_NOTHING.format(why=f"{names[0]} produced {len(a)} bounds and "
                                                   f"{names[1]} produced {len(b)}")}
    if len(a) != len(b):
        return {"verdict": "not-compared", "compared": 0, "ok": False,
                "why": COMPARED_NOTHING.format(
                    why=f"{names[0]} produced {len(a)} bounds and {names[1]} {len(b)}; a "
                        f"sequence that stopped early cannot be compared iteration for iteration")}
    diff = [(i + 1, x, y) for i, (x, y) in enumerate(zip(a, b)) if x != y]
    return {"verdict": "identical" if not diff else "DIFFERS", "ok": not diff,
            "compared": len(a), "first_difference": diff[0] if diff else None,
            "differences": len(diff),
            "bounds": {"first": a[0], "last": a[-1], "distinct": len(set(a))}}


# ====================================================================== recorded problems
@dataclass
class Recorded:
    """A reduction checkpoint read back as a growing family, with the order it grew in.

    For a run that has found no optimum (`minima == []`, `undecided == []`) the order is EXACT:
    every iteration appended exactly one correction set, so iteration `i` solved over the first
    `singletons + i - 1` of them, and the identity `iteration == len(corr) - singletons + 1` is
    checked here rather than assumed.

    For a run in the level-enumeration regime the stored state holds both lists but not their
    interleaving, so the replay uses a CANONICAL order -- every correction set, then the blocking
    clauses one at a time. It is a growing family with the same final instance and the same
    regime; it is not the exact trajectory, and `exact` says so."""
    path: str
    n_atoms: int
    weights: list
    corr: list
    minima: list
    undecided: list
    iteration: int
    w_star: int | None
    problem_line: str
    singletons: int
    exact: bool

    @staticmethod
    def load(path, weights=None):
        d = json.load(open(path))
        corr = [sorted(c) for c in d["corr"]]
        n = len(d["phase1"])
        line = d.get("problem_line", "")
        m = re.match(r"rung (\d+) orbits, (\d+) atoms", line)
        if weights is None:
            if not m:
                raise SystemExit(f"cannot read the rung from problem_line {line!r}; pass --weights")
            rung, natoms = int(m.group(1)), int(m.group(2))
            if natoms != n:
                raise SystemExit(f"problem_line says {natoms} atoms, phase1 holds {n}")
            if rung != 1:
                raise SystemExit(
                    f"{line}: above rung 1 an atom is an ORBIT and its weight is the orbit's size, "
                    f"which the checkpoint does not store (orbits can be shorter than the group). "
                    f"Pass --weights <file.json> built from the stage, or replay a rung-1 run.")
            weights = [SINGLE_ATOM_WEIGHT] * n
        sing = 0
        while sing < len(corr) and len(corr[sing]) == 1:
            sing += 1
        exact = not d["minima"] and not d["undecided"]
        if exact and not (0 <= d["iteration"] - (len(corr) - sing) <= 1):
            raise SystemExit(
                f"{path}: iteration {d['iteration']} does not match {len(corr) - sing} harvested "
                f"correction sets, so the recorded order cannot be reconstructed exactly")
        return Recorded(path=path, n_atoms=n, weights=list(weights), corr=corr,
                        minima=[sorted(x) for x in d["minima"]],
                        undecided=[sorted(x) for x in d["undecided"]],
                        iteration=d["iteration"], w_star=d["w_star"], problem_line=line,
                        singletons=sing, exact=exact)

    def steps(self, limit=None):
        """`(kind, set)` in the order the search grew the family, after the singleton prefix."""
        out = [("corr", c) for c in self.corr[self.singletons:]]
        out += [("block", b) for b in self.minima + self.undecided]
        return out[:limit] if limit else out

    def engine(self, kind, fault=None):
        return ENGINES[kind](self.weights, corr=self.corr[:self.singletons], fault=fault)


def logged_bounds(path):
    """`{iteration: lower bound}` from a live run's own log -- the incumbent code's answers, as it
    produced them. An external cross-check no replay of mine can fake."""
    out = {}
    for ln in open(path):
        m = re.match(r"\s*it (\d+): LB (\d+)", ln)
        if m:
            out[int(m.group(1))] = int(m.group(2))
    return out


# ====================================================================== the runs
def run_engine(rec: Recorded, kind, limit=None, fault=None, log=print, tick=200):
    """Replay the recorded family through one engine; return the bound sequence."""
    eng = rec.engine(kind, fault=fault)
    steps = rec.steps(limit)
    seq, t0 = [], time.time()
    o = eng.optimum()                                # iteration 1: the singleton prefix alone
    if o is None:
        raise Exhausted(f"{kind}: unsatisfiable before any harvested set")
    seq.append(o.weight)
    for i, (kindof, s) in enumerate(steps, 2):
        (eng.add_correction if kindof == "corr" else eng.block)(s)
        o = eng.optimum()
        if o is None:
            log(f"  {kind}: exhausted at iteration {i}")
            break
        seq.append(o.weight)
        if log and tick and i % tick == 0:
            log(f"    {kind} it {i:6d}  LB {o.weight:5d}  "
                f"[{eng.cpu_s:8.1f}s cpu, {eng.sat_calls:8d} SAT calls]", flush=True)
    return seq, eng, time.time() - t0


def cmd_replay(args):
    rec = Recorded.load(args.checkpoint, weights=_weights(args))
    kinds = args.engines.split(",")
    print(f"{os.path.basename(rec.path)}: {rec.problem_line}; {len(rec.corr)} correction sets "
          f"({rec.singletons} singletons), {len(rec.minima)} minima, iteration {rec.iteration}; "
          f"order {'EXACT' if rec.exact else 'CANONICAL (corr, then blocks) -- not the trajectory'}")
    n = args.iterations or (len(rec.steps()) + 1)
    print(f"replaying {n} iterations through: {', '.join(kinds)}")
    out = {}
    for k in kinds:
        seq, eng, wall = run_engine(rec, k, limit=n - 1, fault=args.fault if k == args.fault_on
                                    else None)
        out[k] = dict(seq=seq, cpu=eng.cpu_s, wall=wall, calls=eng.sat_calls, solves=eng.solves)
        print(f"  {k:12s} {len(seq):6d} bounds  {eng.cpu_s:9.1f}s cpu  {eng.sat_calls:9d} SAT "
              f"calls  {eng.cpu_s/max(len(seq),1)*1000:8.1f} ms/iteration")
    if len(kinds) == 2:
        c = compare(out[kinds[0]]["seq"], out[kinds[1]]["seq"], names=tuple(kinds))
        print(f"\n  equivalence: {c['verdict']} over {c['compared']} iterations"
              + (f"; first difference {c['first_difference']}" if c.get("first_difference") else ""))
        if not c["ok"] and "why" in c:
            print(c["why"])
        sp = out[kinds[0]]["cpu"] / max(out[kinds[1]]["cpu"], 1e-9)
        print(f"  speedup: {sp:.1f}x cpu, "
              f"{out[kinds[0]]['calls'] / max(out[kinds[1]]['calls'], 1):.1f}x SAT calls")
    if args.log:
        lg = logged_bounds(args.log)
        seq = out[kinds[-1]]["seq"]
        both = [(i, lg[i], seq[i - 1]) for i in sorted(lg) if 1 <= i <= len(seq)]
        bad = [(i, x, y) for i, x, y in both if x != y]
        if not both:
            raise SystemExit(COMPARED_NOTHING.format(
                why=f"{args.log} holds {len(lg)} logged bounds, none of them inside the "
                    f"{len(seq)} iterations replayed"))
        print(f"  against the live log {os.path.basename(args.log)}: {len(both)} ticks compared, "
              f"{'ALL AGREE' if not bad else f'{len(bad)} DISAGREE: {bad[:4]}'}")
    print(f"  peak RSS {resource.getrusage(resource.RUSAGE_SELF).ru_maxrss/1048576:.2f} GB")
    return out


def cmd_attribution(args):
    """Time the incumbent solve at recorded prefixes: the cost curve, measured, not inferred."""
    rec = Recorded.load(args.checkpoint, weights=_weights(args))
    steps = rec.steps()
    marks = sorted({0, len(steps)//8, len(steps)//4, len(steps)//2, 3*len(steps)//4, len(steps)})
    print(f"{os.path.basename(rec.path)}: {rec.problem_line}, {len(rec.corr)} correction sets")
    print(f"  {'iteration':>10} {'|Y|':>6} {'blocked':>8} {'LB':>6} {'SAT calls':>10} {'cpu s':>9}")
    for m in marks:
        eng = rec.engine("batch")
        for kindof, s in steps[:m]:
            (eng.add_correction if kindof == "corr" else eng.block)(s)
        o = eng.optimum()
        print(f"  {m+1:>10} {len(eng.corr):>6} {len(eng.blocked):>8} {o.weight:>6} "
              f"{o.sat_calls:>10} {o.cpu_s:>9.2f}", flush=True)


def _weights(args):
    if not args.weights:
        return None
    return json.load(open(args.weights))


# ====================================================================== self-test
def _self_test():
    """Plant every fault and watch it fire (CLAUDE.md, 'Make the gate fail, and watch it fail').

    The positive control comes first and must read `identical` over the FULL length: a check that
    is always red discriminates nothing, and neither does one that compares two iterations."""
    fails = []

    def chk(name, cond, detail=""):
        print(f"  {'ok  ' if cond else 'FAIL'} {name}{('  ' + detail) if detail else ''}")
        if not cond:
            fails.append(name)

    import random
    rng = random.Random(20260911)
    n = 40
    weights = [1 + (a % 3) for a in range(n)]        # a weighted instance: rung > 1 is the norm
    fam = [sorted(rng.sample(range(n), rng.randint(1, 5))) for _ in range(120)]

    def seq(kind, fault=None, steps=None):
        eng = ENGINES[kind](weights, fault=fault)
        out = []
        for c in (steps or fam):
            eng.add_correction(c)
            o = eng.optimum()
            out.append(o.weight if o else None)
        return out, eng

    a, ea = seq("batch")
    b, eb = seq("incremental")
    c = compare(a, b)
    chk("the positive control: batch and incremental agree, iteration for iteration",
        c["ok"] and c["compared"] == len(fam), f"{c['verdict']} over {c['compared']} iterations")
    chk("the bounds actually move (a constant sequence would agree trivially)",
        c["bounds"]["distinct"] > 3,
        f"{c['bounds']['distinct']} distinct values, {c['bounds']['first']} -> {c['bounds']['last']}")
    chk("incremental spends fewer SAT calls than batch on the same family",
        eb.sat_calls < ea.sat_calls, f"{eb.sat_calls} against {ea.sat_calls}")
    d, _ = seq("incremental-adapt")
    cd = compare(a, d, names=("batch", "incremental-adapt"))
    chk("the adapt variant agrees with batch too, iteration for iteration",
        cd["ok"] and cd["compared"] == len(fam), f"{cd['verdict']} over {cd['compared']}")

    # --- the planted faults ------------------------------------------------------
    # A dropped constraint moves the BOUNDS only when it is BINDING, and the first version of this
    # control did not fire: it skipped a random correction set, and the set it skipped was implied
    # by the others, so every bound was unchanged and the check read `identical` -- a fault that is
    # real and invisible. Both halves of that are now controls. The binding one is DESIGNED so its
    # effect is provable rather than hoped for: atom `hi` appears in exactly one correction set,
    # the singleton `{hi}`, and in no other, so that clause forces `hi` kept and contributes
    # exactly `weights[hi]` to every optimum from the iteration it is added. Dropping it must move
    # every later bound by exactly that much.
    hi = n - 1
    designed = [sorted(rng.sample(range(n - 1), rng.randint(1, 5))) for _ in range(120)]
    mark, dup = 30, 61
    designed.insert(mark - 1, [hi])                 # the 30th set added: binding by construction
    designed.insert(dup - 1, list(designed[0]))     # the 61st: a duplicate, binding on nothing
    base, _ = seq("batch", steps=designed)
    f1, _ = seq("incremental", fault=f"skip-corr:{mark}", steps=designed)
    c1 = compare(base, f1)
    chk("PLANTED a dropped correction set that BINDS (the constraint that never got added): "
        "the check goes red", not c1["ok"] and c1["verdict"] == "DIFFERS",
        f"{c1['verdict']}, first difference {c1['first_difference']}")
    gap = {x - y for x, y in zip(base[mark - 1:], f1[mark - 1:])}
    chk("...and by exactly the weight the dropped clause forced, at every later iteration",
        gap == {weights[hi]}, f"differences {sorted(gap)}, expected {{{weights[hi]}}}")
    f1b, _ = seq("incremental", fault=f"skip-corr:{dup}", steps=designed)
    c1b = compare(base, f1b)
    chk("STATED BLIND SPOT: dropping a REDUNDANT correction set moves no bound, so this check "
        "cannot see it (it is not a false pass -- it is the check's reach)",
        c1b["ok"], f"{c1b['verdict']} over {c1b['compared']} iterations")
    f2, _ = seq("incremental", fault="stale")
    c2 = compare(a, f2)
    chk("PLANTED a stale answer (returned without re-solving): the check goes red",
        not c2["ok"] and c2["verdict"] == "DIFFERS", f"{c2['verdict']}, first difference "
        f"{c2['first_difference']}")
    f3, _ = seq("incremental", fault="unit-weights")
    c3 = compare(a, f3)
    chk("PLANTED unit weights on a weighted instance: the check goes red",
        not c3["ok"] and c3["verdict"] == "DIFFERS", f"{c3['verdict']}, first difference "
        f"{c3['first_difference']}")

    # --- the check's own failure mode: it must never read as agreement when it did not run ---
    chk("a comparison of nothing is NOT a pass", not compare([], [])["ok"]
        and compare([], [])["verdict"] == "not-compared", compare([], [])["verdict"])
    chk("a truncated sequence is NOT a pass", not compare(a, b[:10])["ok"]
        and compare(a, b[:10])["verdict"] == "not-compared", compare(a, b[:10])["verdict"])
    chk("the monotonicity control is armed: a falling optimum raises",
        _monotonicity_fires(weights, fam))

    # --- the decision engine, on a unit-weight instance (it refuses weighted ones) ---
    ufam = [sorted(rng.sample(range(n), rng.randint(1, 5))) for _ in range(120)]
    def useq(kind, fault=None):
        eng = ENGINES[kind]([1] * n, fault=fault)
        out = []
        for c in ufam:
            eng.add_correction(c)
            o = eng.optimum()
            out.append(o.weight if o else None)
        return out, eng
    ub, _ = useq("batch")
    ui, eui = useq("incumbent")
    cu = compare(ub, ui, names=("batch", "incumbent"))
    chk("the decision engine agrees with batch, iteration for iteration",
        cu["ok"] and cu["compared"] == len(ufam), f"{cu['verdict']} over {cu['compared']}")
    chk("...and it spends about one SAT call per iteration",
        eui.sat_calls < 2 * len(ufam), f"{eui.sat_calls} calls for {len(ufam)} iterations")
    uf, _ = useq("incumbent", fault="stale")
    chk("...and a planted stale answer on it goes red", not compare(ub, uf)["ok"],
        compare(ub, uf)["verdict"])
    try:
        ENGINES["incumbent"]([1, 3, 1])
        chk("the decision engine REFUSES a weighted instance", False, "it was accepted")
    except ValueError as e:
        chk("the decision engine REFUSES a weighted instance rather than counting orbits as "
            "vertices", "unit weights" in str(e), str(e).splitlines()[0][:70])

    # --- blocking clauses: the level-enumeration regime -------------------------
    # Poros card 6. As first written this control let EACH engine block ITS OWN optimum, so the
    # two clause streams could diverge legitimately and the comparison tested nothing; and the
    # bounds can sit at w* for every iteration, in which case two constant sequences agree no
    # matter what the engines do. Both are fixed: one stream is fed to both engines, and the
    # sequence is required to MOVE before the agreement counts for anything.
    ea2 = ENGINES["batch"](weights, corr=fam)
    eb2 = ENGINES["incremental"](weights, corr=fam)
    sa, sb = [], []
    for _ in range(40):
        oa, ob = ea2.optimum(), eb2.optimum()
        if oa is None or ob is None:
            break
        sa.append(oa.weight); sb.append(ob.weight)
        ea2.block(oa.kept); eb2.block(oa.kept)      # the SAME clause to both
    cb = compare(sa, sb)
    chk("blocking clauses too: the two engines agree while enumerating a level",
        cb["ok"] and cb["compared"] >= 20, f"{cb['verdict']} over {cb['compared']} iterations")
    chk("...and that control is not vacuous: the level exhausts and the bound MOVES",
        len(set(sa)) > 1, f"{len(set(sa))} distinct bounds, {sa[0]} -> {sa[-1]}")

    print(f"\n{'ALL CONTROLS FIRED' if not fails else 'FAILED: ' + ', '.join(fails)}")
    return not fails


def _monotonicity_fires(weights, fam):
    """The engine's own invariant, planted against: a hand-made falling optimum must raise."""
    eng = ENGINES["incremental"](weights, corr=fam[:5])
    eng.optimum()
    eng._last = Optimum(weight=10 ** 6, kept=(), sat_calls=0, cpu_s=0.0)
    try:
        eng.add_correction(fam[5])
        eng.optimum()
        return False
    except AssertionError:
        return True


def main():
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    sub = ap.add_subparsers(dest="cmd")
    for name, fn in (("replay", cmd_replay), ("attribution", cmd_attribution)):
        p = sub.add_parser(name)
        p.add_argument("--checkpoint", required=True)
        p.add_argument("--weights", help="JSON list of atom weights; required above rung 1")
        if name == "replay":
            p.add_argument("--engines", default="batch,incremental")
            p.add_argument("--iterations", type=int, default=0)
            p.add_argument("--log", help="a live run's log, to cross-check the bounds it printed")
            p.add_argument("--fault", default=None, help="plant a fault (see _Engine)")
            p.add_argument("--fault-on", dest="fault_on", default="incremental")
        p.set_defaults(f=fn)
    a = ap.parse_args()
    if a.selftest:
        sys.exit(0 if _self_test() else 1)
    if not getattr(a, "f", None):
        ap.error("give a subcommand or --self-test")
    a.f(a)


if __name__ == "__main__":
    main()
