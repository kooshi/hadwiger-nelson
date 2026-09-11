#!/usr/bin/env python3
"""[Parts2020a]'s reduction, phases 1 and 2, returning {M} rather than one minimum.

**What makes this his algorithm and not our descent.** A descent produces ONE 1-minimal object; his
loop's state variable is `A = union{M}`, the union of ALL minima at the current size, and his own
success criterion fires when `{M}` grows at fixed `|M|` (§5.5). Overcompression (§5.8) says the two
are genuinely different searches -- *"the minimal asymmetric graph is usually not a subgraph of the
minimal symmetric graph"* -- so a pipeline that returns one minimum cannot walk his path however
good that minimum is.

**The algorithm, and the invariant that makes it complete** (derived in
`plans/M63-parts-reproduction.md` §O). `R(S)` = *`W[S] u C` refuses four colours* is upward closed,
because non-4-colourability survives adding vertices -- and that is a property of the SHAPE, since
every key property here is expressed as non-colourability of `W u C`. By MCS/MUS duality

    R(S)  <=>  S meets every minimal correction set,

so his hypergraph `Y` IS the family of minimal correction sets and his phase 2 IS minimum hitting
set. Correction sets are harvested lazily, so at any instant `Y` is a SUBSET of the truth and
`mhs(Y) <= mhs(Y*)` -- the lower bound is rigorous and rising, and it is ATTAINED exactly when the
returned hitting set refuses.

For the level set, with `E` the optima found so far:

    INVARIANT.  E is a set of R-true selections of weight w*, and every R-true selection of
                weight w* not in E is still feasible for the current instance.

A blocking clause removes only a member of `E`; a new correction set removes only selections that
are not R-true. Neither ever removes an unrecorded R-true `w*` selection, so at UNSAT the
enumeration is COMPLETE. Each iteration grows `E` or grows `Y`, so it terminates.

**The step that is easy to get wrong**: when the hitting set turns out colourable, do NOT block it
-- add the correction set it misses, which removes it and infinitely many like it. And every
correction set must be VERIFIED before insertion (ours are read off an actual colouring), or the
lower bound stops being a bound and the optimality claim becomes unsound.

**What this reports and what it refuses to.** A `Bound(lower, upper, rung, undecided)`; there is no
verdict word for optimality, because at any rung above 1 the search is restricted to symmetric
selections and provably need not contain the true minimum. See `tools/parts_report.py`.

--------------------------------------------------------------------------------------------------
M63 phase C added three things, and each of them is a measurement that can now FAIL where it could
not before (`plans/M63-phaseC-joint-stage.md` C1.1-C1.3).

**1. The ask has a budget, and `undecided` is a number that can be nonzero.** As shipped, `ask` was
an unbounded `solve()`, so `Bound.undecided` was structurally 0 and "zero undecided asks" was not a
measurement at all (`G21`).

*The mechanism is a CONFLICT BUDGET, not a timer, and that is a finding rather than a choice.* The
subplan specified `solve_limited(expect_interrupt=True)` with a `threading.Timer` calling
`interrupt()`, and instructed the implementer to query that first. Measured 2026-09-11 on PySAT
1.9.dev15: **`Cadical153.interrupt()` and `.clear_interrupt()` raise
`NotImplementedError('Limited solve is currently unsupported by CaDiCaL.')`** -- and the Timer
thread does run during the solve, so the exception is raised inside that thread, printed to stderr
and swallowed, while the ask continues. That is precisely the wall that silently does nothing.
Glucose, MiniSat, MapleChrono and MergeSat do honour `interrupt()`; CaDiCaL 1.5.3 is measured best
on this workload (M63 §7), so the solver stays and the mechanism changes.

What CaDiCaL does honour is `conf_budget(n)` + `solve_limited()`, and the control that says so is
that an EASY instance still returns a real verdict under a budget of 10^9 (True / False), while a
hard one returns None at 1,000 conflicts. So a bounded ask is a loop over conflict slices:

    while no verdict and the elapsed wall has not passed:  conf_budget(slice); solve_limited()

which gives a genuine time wall built from deterministic slices, keeps the learned clauses across
slices (so the work is not thrown away), and costs exactly nothing in the normal regime, where the
first slice decides every ask. An 'unknown' is therefore always attributable: the wall, with the
slice size and the number of slices recorded beside it.

**2. A run resumes EXACTLY.** `ReductionState` is the checkpoint and the record at two times (§M):
`finish()` adds only derived views. A resume is refused on a problem mismatch (`Stage.identity`,
not `stage_fingerprint`, which cannot tell an L stage from an LS stage over one working graph) and
PERMITTED on a budget change, because a wall is a property of a launch -- raising it is exactly how
one continues a truncated run. On resume the undecided candidates go back into the pool and
phase-1 unknowns are re-asked; everything decided is a fact about a fixed finite graph and is kept.

**3. The vacuity verdicts are complete.** `companion-suffices` (the empty selection already
refuses, asked before phase 1) is new, and `no-reduction` now labels the branch it names -- as
shipped it sat on `w_star is None`, which is the truncated case.
"""
from __future__ import annotations
import argparse, hashlib, json, os, sys, time
from collections import defaultdict
from dataclasses import dataclass, field

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import parts_repro as P
import parts_report as R
import parts_stage as PS
import parts_vtx as V

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SLICE_CONFLICTS = 100_000          # ~1 s on this machine; the first slice decides a normal ask


class Oracle:
    """One incremental solver over the stage's one-time CNF, counting its asks by outcome.

    The two populations are counted SEPARATELY because they differ by ~20x on the measured stages
    -- a colourable ask is 0.006-0.009 s and a refusing one 0.02-0.11 s -- so any cost statement
    that merges them is a statement about a mixture nobody can reproduce. Both wall and CPU
    (user+sys, via `time.process_time`) are accumulated, because a cost compared across runs on a
    loaded machine must be CPU (CLAUDE.md § Two machines)."""

    def __init__(self, stage, wall=600.0, slice_conflicts=SLICE_CONFLICTS):
        from pysat.solvers import Solver
        cls, sel, top, loc = stage.cnf()
        self.sel, self.loc, self.stage = sel, loc, stage
        self.S = Solver(name="cadical153", bootstrap_with=cls)
        self.wall, self.slice = wall, slice_conflicts
        self.n_sat = self.n_unsat = self.n_unknown = 0
        self.t_sat = self.t_unsat = self.t_unknown = 0.0
        self.c_sat = self.c_unsat = self.c_unknown = 0.0
        self.slices = 0

    def ask(self, kept, wall="default", slice_conflicts=None):
        """('unsat' | 'sat' | 'unknown', model or None).

        'unsat' = the selection KEEPS the property (it refuses four colours); 'sat' = it loses it,
        and the model is returned so a correction set can be read off an actual colouring;
        'unknown' = the budget ran out, which is a statement about this launch and not about the
        graph. `wall=None` asks without any budget at all, and then 'unknown' cannot occur."""
        w = self.wall if wall == "default" else wall
        sl = self.slice if slice_conflicts is None else slice_conflicts
        a = [self.sel[x] for x in kept]
        t0, p0, n0 = time.time(), time.process_time(), self.slices
        st = None
        if w is None or not sl:
            st = self.S.solve(assumptions=a)
        else:
            while True:
                self.S.conf_budget(sl)
                self.slices += 1
                st = self.S.solve_limited(assumptions=a)
                if st is not None or time.time() - t0 >= w:
                    break
        dt, dc = time.time() - t0, time.process_time() - p0
        if st is None:
            self.n_unknown += 1; self.t_unknown += dt; self.c_unknown += dc
            return "unknown", None
        if st:
            self.n_sat += 1; self.t_sat += dt; self.c_sat += dc
            return "sat", self.S.get_model()
        self.n_unsat += 1; self.t_unsat += dt; self.c_unsat += dc
        return "unsat", None

    def stats(self):
        def pop(n, t, c):
            return {"n": n, "mean_s": round(t / max(n, 1), 4), "mean_cpu_s": round(c / max(n, 1), 4),
                    "total_cpu_s": round(c, 2)}
        return {"colourable": pop(self.n_sat, self.t_sat, self.c_sat),
                "refusing": pop(self.n_unsat, self.t_unsat, self.c_unsat),
                "undecided": self.n_unknown,
                "budget": {"wall_s": self.wall, "slice_conflicts": self.slice,
                           "slices_used": self.slices,
                           "mechanism": "conf_budget + solve_limited slices; cadical153 does not "
                                        "implement interrupt() (measured 2026-09-11)"}}


def kept_from_model(orc, model):
    """The atoms the solver left present -- a colourable superset of what was asked, free."""
    m = set(model)
    return {a for a, s in enumerate(orc.sel) if s in m}


# ====================================================================== the state
@dataclass
class ReductionState:
    """**The checkpoint and the record are one object at two times** (§M). A checkpoint is this
    state with `status = "in-progress"`; the record is `finish()`, which adds only derived views.

    Two schemas would be two things to keep in agreement, and `blocked` was already a second copy
    of the minima: it is derived here, as `minima + undecided`, and never stored.

    `stage_identity` identifies WHAT is being searched (`Stage.identity`: the graph, the deletable
    set with halves, the atom partition, the pin and the law). `problem_sha256` is that plus the
    problem half of the config; `config_sha256` covers the budgets too. **A resume is refused on a
    problem mismatch and permitted on a budget change**, because a wall and a cap are properties of
    a launch, not of the search."""
    stage_identity: str
    problem_sha256: str
    problem_line: str = ""
    status: str = "in-progress"
    pin: dict = field(default_factory=dict)
    phase1: dict = field(default_factory=dict)        # str(atom) -> critical | droppable | unknown
    corr: list = field(default_factory=list)
    minima: list = field(default_factory=list)
    undecided: list = field(default_factory=list)
    w_star: int | None = None
    iteration: int = 0
    asks: dict = field(default_factory=dict)
    launches: list = field(default_factory=list)

    @property
    def blocked(self):
        """Derived, never stored: a second copy of the minima is a second thing to keep true."""
        return [list(m) for m in self.minima] + [list(u) for u in self.undecided]

    def to_json(self):
        return {"kind": "m63-reduction-checkpoint", "schema": 2,
                "producer": "tools/parts_reduce.py:ReductionState",
                **{k: getattr(self, k) for k in
                   ("stage_identity", "problem_sha256", "problem_line", "status", "pin", "phase1",
                    "corr", "minima", "undecided", "w_star", "iteration", "asks", "launches")}}

    @staticmethod
    def from_json(d):
        return ReductionState(**{k: d[k] for k in
                                 ("stage_identity", "problem_sha256", "problem_line", "status",
                                  "pin", "phase1", "corr", "minima", "undecided", "w_star",
                                  "iteration", "asks", "launches")})

    def save(self, path):
        """Atomic: a checkpoint half-written by a kill is a checkpoint that refuses to load."""
        os.makedirs(os.path.dirname(os.path.abspath(path)), exist_ok=True)
        tmp = path + ".tmp"
        with open(tmp, "w") as f:
            json.dump(self.to_json(), f)
        os.replace(tmp, path)


def _sha(obj) -> str:
    return hashlib.sha256(json.dumps(obj, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


def problem_hash(stage, config) -> str:
    """WHAT is being searched: the stage's identity plus the problem half of the config."""
    return _sha({"identity": stage.identity(), "problem": (config or {}).get("problem", {})})


CHECKPOINT_REFUSAL = """checkpoint refused: it belongs to a different search.
  its problem   {theirs}   identity {tid}
  this problem  {ours}   identity {oid}
  A checkpoint may be resumed onto the same problem with different budgets, never onto another
  problem. Start a fresh run:  --checkpoint {suggest}"""


class CheckpointMismatch(Exception):
    """Raised rather than returned: a resume onto the wrong search must not be a log line."""


def load_checkpoint(path, stage, config, log=print):
    """The stored state, or None when there is no file. Refuses a checkpoint from another search."""
    if not path or not os.path.exists(path):
        return None
    d = json.load(open(path))
    st = ReductionState.from_json(d)
    if st.stage_identity != stage.identity() or st.problem_sha256 != problem_hash(stage, config):
        raise CheckpointMismatch(CHECKPOINT_REFUSAL.format(
            theirs=st.problem_line or "(unrecorded)", tid=st.stage_identity[:8],
            ours=stage.problem_line(), oid=stage.identity()[:8],
            suggest=os.path.join(os.path.dirname(path) or ".", "<new name>.ckpt.json")))
    log(f"  resuming from {path}: phase1 {len(st.phase1)} decided, {len(st.corr)} correction sets, "
        f"{len(st.minima)} minima, w* {st.w_star}, iteration {st.iteration}; "
        f"{len(st.undecided)} undecided candidates returned to the pool")
    st.undecided = []                      # a launch fact: re-asked under the new budget
    for a, v in list(st.phase1.items()):   # so are phase-1 unknowns
        if v == "unknown":
            del st.phase1[a]
    return st


# ====================================================================== the phases
def phase1(orc, atoms, state, log=print, ckpt=None, tick=20.0):
    """His degree-1 layer: an atom whose lone deletion loses the property is FIXED (critical).

    Sound from monotonicity alone: if `all - {a}` is colourable then so is every selection missing
    `a`, since colourability is downward closed. An UNDECIDED ask counts as *not critical*: that
    omits a degree-1 hyperedge, so `Y` shrinks, and `mhs(Y) <= mhs(Y*)` stays a lower bound either
    way. The unknowns are listed, because the omission is a fact about this launch."""
    allA = list(range(len(atoms)))
    todo = [a for a in allA if str(a) not in state.phase1]
    t0, last = time.time(), time.time()
    for i, a in enumerate(todo):
        v, _ = orc.ask([x for x in allA if x != a])
        state.phase1[str(a)] = {"sat": "critical", "unsat": "droppable", "unknown": "unknown"}[v]
        if time.time() - last > tick or i + 1 == len(todo):
            last = time.time()
            crit = sum(1 for x in state.phase1.values() if x == "critical")
            log(f"    phase1 {len(state.phase1)}/{len(allA)}  critical {crit}  "
                f"droppable-alone {len(state.phase1) - crit}  [{time.time()-t0:.0f}s]")
            if ckpt:
                state.save(ckpt)
    crit = [a for a in allA if state.phase1.get(str(a)) == "critical"]
    drop = [a for a in allA if state.phase1.get(str(a)) == "droppable"]
    unk = [a for a in allA if state.phase1.get(str(a)) == "unknown"]
    return crit, drop, unk


def minimal_correction(orc, allA, T, log=None, tick=20.0):
    """Shrink `allA - T` to a minimal correction set.

    An undecided ask is treated as 'still needed', which keeps the result a valid (if possibly
    non-minimal) correction set -- and a non-minimal correction set is still a sound constraint,
    because every R-true selection meets every correction set, minimal or not."""
    left = sorted(set(allA) - set(T))
    i, t0, last = 0, time.time(), time.time()
    minimal = True
    while i < len(left):
        if log and time.time() - last > tick:
            last = time.time()
            log(f"      shrinking correction set: {i}/{len(left)} examined, size now {len(left)}"
                f"  [{time.time()-t0:.0f}s]")
        trial = left[:i] + left[i + 1:]
        if not trial:
            break
        v, _ = orc.ask([x for x in allA if x not in set(trial)])
        if v == "sat":
            left = trial
        else:
            if v == "unknown":
                minimal = False
            i += 1
    return left, minimal


def reduce_stage(stage, *, wall_ask=600.0, max_minima=0, phase2_wall=0.0, checkpoint=None,
                 config=None, log=print, slice_conflicts=SLICE_CONFLICTS, _stop_after=None,
                 tick=20.0):
    """Phases 1 and 2, returning the record -- never a bare number.

    RESUME. If `checkpoint` names an existing file the run continues from it EXACTLY. The file is
    REFUSED when the stage's identity or the problem hash differs, and accepted when only budgets
    differ. On resume the `undecided` list is CLEARED back into the candidate pool -- an ask a
    60-second wall could not decide is exactly what a longer wall should re-ask -- and phase-1
    atoms recorded `unknown` are re-asked too. A relaunch therefore re-asks nothing that was
    decided, and everything that was not.

    What resume does NOT promise: the correction sets harvested AFTER the resume point may differ
    from an uninterrupted run's. A fresh incremental solver can return a different model for the
    same colourable ask, and the shrink starts from that model. The LEVEL -- the minima as a set,
    `w*`, the method -- is identical, by the completeness invariant (§O2).

    `_stop_after` (tests only): raise `PlantedInterruption` after that many level iterations, so a
    self-test can kill a run at an arbitrary point without a signal."""
    from pysat.formula import WCNF
    from pysat.examples.rc2 import RC2
    t0, cpu0 = time.time(), time.process_time()
    atoms = stage.atoms
    weight = [m.bit_count() for m in atoms]
    allA = list(range(len(atoms)))
    total_weight = sum(weight)

    state = load_checkpoint(checkpoint, stage, config, log=log) or ReductionState(
        stage_identity=stage.identity(), problem_sha256=problem_hash(stage, config),
        problem_line=stage.problem_line())
    state.status = "in-progress"
    state.launches.append({"started": time.strftime("%Y-%m-%dT%H:%M:%S"),
                           "budgets": {"wall_ask": wall_ask, "max_minima": max_minima,
                                       "phase2_wall": phase2_wall,
                                       "slice_conflicts": slice_conflicts},
                           "machine": os.uname().nodename,
                           "git_commit": R._git("rev-parse", "HEAD", default="unknown")})
    orc = Oracle(stage, wall=wall_ask, slice_conflicts=slice_conflicts)

    def finish(verdict, note=None, **extra):
        state.asks = orc.stats()
        state.launches[-1]["seconds"] = round(time.time() - t0, 1)
        state.launches[-1]["cpu_seconds"] = round(time.process_time() - cpu0, 1)
        if checkpoint:
            state.save(checkpoint)
        rec = {"verdict": verdict, "seconds": round(time.time() - t0, 1),
               "cpu_seconds": round(time.process_time() - cpu0, 1), "asks": state.asks}
        if note:
            rec["note"] = note
        rec.update(extra)
        rec["state"] = state
        return rec

    # --- the three guards, each with its own verdict word (§O5) ---------------------
    if not state.pin:
        state.pin = stage.pin_is_sound()
    pin = state.pin
    log(f"  pin control: {pin['verdict']} ({pin.get('checked', 0)} checks)")
    if pin["verdict"] == "pin-changes-answers":
        state.status = "complete"
        return finish("pin-unsound", pin=pin,
                      note="the symmetry break changes answers, so every refusal it produced is a "
                           "statement about a larger graph than was asked for")

    v, _ = orc.ask(allA, wall=None)
    if v != "unsat":
        state.status = "complete"
        return finish("base-fails",
                      note="the working graph itself does not keep the key property, so every "
                           "claim downstream would quantify over an empty set")
    v0, _ = orc.ask([], wall=None)
    if v0 == "unsat":
        state.status = "complete"
        return finish("companion-suffices",
                      note="the EMPTY selection already refuses four colours: the companion alone "
                           "carries the key property and the working graph is doing no work. A bug "
                           "in the setup, not a result -- no bound is emitted.")
    log(f"  base keeps the property, companion alone does not ({stage.describe()})")

    crit, drop, unk = phase1(orc, atoms, state, log=log, ckpt=checkpoint, tick=tick)
    if not state.corr:
        state.corr = [[a] for a in crit]                  # degree-1 hyperedges
    log(f"  phase1: {len(crit)} critical / {len(drop)} droppable-alone of {len(atoms)} atoms"
        f"{f', {len(unk)} UNDECIDED' if unk else ''}  [{time.time()-t0:.0f}s]")
    if checkpoint:
        state.save(checkpoint)

    truncated_wall = False
    last_tick, last_ckpt = time.time(), time.time()
    while True:
        state.iteration += 1
        it = state.iteration
        w = WCNF()
        for c in state.corr:
            w.append([a + 1 for a in c])                  # kept-set must hit every correction set
        for b in state.blocked:
            w.append([-(a + 1) for a in b])               # exclude this exact optimum / undecided
        for a in allA:
            w.append([-(a + 1)], weight=weight[a])        # minimise total kept weight
        with RC2(w) as rc:
            model = rc.compute()
        if model is None:
            log(f"  level exhausted after {len(state.minima)} minima  [{time.time()-t0:.0f}s]")
            break
        h = sorted(a for a in allA if model[a] > 0)
        wh = sum(weight[a] for a in h)
        if time.time() - last_tick > tick:
            last_tick = time.time()
            s = orc.stats()
            age = f"{time.time()-last_ckpt:.0f}s ago" if checkpoint else "no checkpoint"
            log(f"    it {it}: LB {wh}{'' if state.w_star is None else f' = w* {state.w_star}'}"
                f"  minima {len(state.minima)}  Y {len(state.corr)} (min size "
                f"{min(len(c) for c in state.corr) if state.corr else '-'})"
                f"  undecided {len(state.undecided)}   asks {s['colourable']['n']} colourable "
                f"@{s['colourable']['mean_s']}s / {s['refusing']['n']} refusing "
                f"@{s['refusing']['mean_s']}s  [{time.time()-t0:.0f}s]  ckpt {age}")
        if state.w_star is not None and wh > state.w_star:
            log(f"  next candidate weighs {wh} > {state.w_star}: the level is complete"
                f"  [{time.time()-t0:.0f}s]")
            break
        v, mdl = orc.ask(h)
        if v == "unsat":
            if state.w_star is None:
                state.w_star = wh
                log(f"  OPTIMUM FOUND: weight {state.w_star} (kept {len(h)} atoms) at iteration {it}"
                    f"  [{time.time()-t0:.0f}s]")
            state.minima.append(h)
            if len(state.minima) % 5 == 0 or len(state.minima) == 1:
                log(f"    minima {len(state.minima)}  |A| "
                    f"{len(set().union(*(set(x) for x in state.minima)))} atoms  "
                    f"Y {len(state.corr)}  [{time.time()-t0:.0f}s]")
            if max_minima and len(state.minima) >= max_minima:
                log(f"  stopping at max_minima={max_minima}: the level is TRUNCATED")
                break
        elif v == "sat":
            c, minimal = minimal_correction(orc, allA, kept_from_model(orc, mdl), log=log, tick=tick)
            state.corr.append(c)
        else:
            # An undecided candidate is neither a minimum nor a correction set. Blocking it keeps
            # the loop going, but it may remove an unrecorded R-true selection of weight w*, so the
            # completeness invariant is LOST and the count method becomes bounded-below (§O3).
            state.undecided.append(h)
            log(f"    UNDECIDED candidate at weight {wh} (ask hit the budget): blocked and "
                f"recorded; the level is now bounded-below")
        if checkpoint and time.time() - last_ckpt > 30.0:
            state.save(checkpoint); last_ckpt = time.time()
        if phase2_wall and time.time() - t0 > phase2_wall:
            log(f"  phase-2 wall reached at {time.time()-t0:.0f}s: the level is TRUNCATED-AT-WALL")
            truncated_wall = True
            break
        if _stop_after is not None and it >= _stop_after:
            if checkpoint:
                state.save(checkpoint)
            raise PlantedInterruption(f"planted stop after iteration {it}")

    E = state.minima
    capped = bool(max_minima and len(E) >= max_minima)
    complete = (state.w_star is not None) and not truncated_wall and not capped and not state.undecided
    state.status = ("complete" if complete else
                    "truncated-at-wall" if truncated_wall else "truncated-at-budget")
    if state.w_star is None:
        verdict = "truncated-before-optimum"
    elif state.w_star >= total_weight:
        verdict = "no-reduction"
    else:
        verdict = "reduced"
    bound = R.Bound(lower=state.w_star or 0, upper=state.w_star or total_weight, rung=stage.rung,
                    undecided=len(state.undecided))
    method = ("exhaustive-level" if complete else
              "bounded-below" if state.undecided else
              "truncated-at-wall" if truncated_wall else "truncated-at-budget")
    Aatoms = sorted(set().union(*(set(x) for x in E))) if E else []
    rec = finish(verdict,
                 bound=R.asdict(bound), bound_render=bound.render(),
                 M_vertices=None if state.w_star is None else state.w_star + stage.side_fixed,
                 M_set=R.asdict(R.SetSize(
                     R.Count(len(E), method, of=None if method in ("exhaustive-level", "bounded-below")
                             else len(E)),
                     up_to="as found (the companion fixed); canonical counts are the audit's")),
                 minima=[sorted(x) for x in E],
                 undecided_candidates=[sorted(x) for x in state.undecided],
                 A_atoms=len(Aatoms),
                 **({"A": Aatoms} if not capped else {"A_sample": Aatoms}),
                 hypergraph={"degree_1": len(crit), "correction_sets": len(state.corr),
                             "sets": sorted((sorted(c) for c in state.corr), key=lambda c: (len(c), c)),
                             "harvest": R.asdict(R.Count(len(state.corr), "harvested")),
                             "note": "harvested lazily, so this is a SUBSET of the true minimal "
                                     "correction sets; every hitting-set bound over it is a lower "
                                     "bound, closed by the SAT step (M63 section O(1)).",
                             "by_size": {k: sum(1 for c in state.corr if len(c) == k)
                                         for k in sorted({len(c) for c in state.corr})}},
                 phase1_unknown=unk,
                 stage_fingerprint=stage.fingerprint(), stage_identity=stage.identity())
    if capped:
        rec["A_note"] = ("the level was CAPPED at max_minima, so the union of the minima found is a "
                         "SAMPLE of A and not A: his A is the union of ALL minima at the size, and "
                         "nothing here bounds which members a cap holds. No loop may start from it "
                         "(Poros card 9).")
    return rec


class PlantedInterruption(Exception):
    """Only `_stop_after` raises this: a kill at an arbitrary point, without a signal."""


# ====================================================================== self-test
def _self_test(quick=True):
    """Plant every refusal and watch it fire. C1.1-C1.3's controls live here.

    c1.3 the budget is real     -- a one-conflict slice with a 1 ms wall on a REFUSING ask returns
                                   'unknown', the bound renders open, and `Bound.closed` is false;
                                   the same ask with the default budget returns 'unsat', so the
                                   control discriminates rather than always saying unknown;
    c1.4 companion-suffices     -- a stub oracle answering 'unsat' on the empty selection;
    c1.2 checkpoint mismatch    -- a checkpoint from one rung offered to another is REFUSED, and
                                   the refusal names both problems.
    The exact-resume control (c1.1) runs the S166 order-3 rung twice and is minutes, so it lives in
    `--resume-control` rather than in the default self-test."""
    import parts_faces as F
    fails = []

    def chk(name, cond, detail=""):
        print(f"  {'ok  ' if cond else 'FAIL'} {name}{('  ' + detail) if detail else ''}")
        if not cond:
            fails.append(name)

    D = os.path.join(ROOT, "data", "m62", "parts-ref11", "JP", "Large")
    B = P.Base(P.PARTS_R)
    st = PS.Stage(B, V.load_lattice(os.path.join(D, "v451e2400.vtx")),
                  V.load_lattice(os.path.join(D, "v136e564.vtx")), side="L", rung=1)
    allA = list(range(len(st.atoms)))
    # The budget must be tested on a FRESH solver. Asking the same question twice is no test at
    # all: the first ask leaves learned clauses behind and the repeat is decided by propagation
    # with zero conflicts, so a one-conflict budget never bites and the control reads 'unsat'.
    # That is what it did when first written, and it is the same shape as the failure the wall
    # exists to catch -- a limit that cannot fire looks exactly like a limit that is generous.
    orc = Oracle(st, wall=0.001, slice_conflicts=1)
    v2, _ = orc.ask(allA)
    chk("c1.3 the budget is real: one conflict, 1 ms -> unknown", v2 == "unknown", f"verdict {v2!r}")
    b = R.Bound(374, 374, 1, undecided=1 if v2 == "unknown" else 0)
    chk("c1.3 an undecided candidate keeps the bound open",
        (not b.closed) and "undecided" in b.render(), b.render())
    chk("c1.3 the undecided ask is counted", orc.stats()["undecided"] == 1,
        str(orc.stats()["undecided"]))
    v, _ = orc.ask(allA, wall=None)
    chk("c1.3 control positive: the same ask decides under no budget, on the same solver, so an "
        "exhausted budget leaves the oracle usable", v == "unsat",
        f"verdict {v!r}, {orc.stats()['refusing']['mean_s']}s")

    # c1.2: a checkpoint from one search offered to another
    ck = os.path.join(ROOT, "build", "gate", "m63", "selftest.ckpt.json")
    stS = PS.Stage(B, V.load_lattice(os.path.join(D, "v451e2400.vtx")),
                   V.load_lattice(os.path.join(D, "v136e564.vtx")), side="S", rung=1)
    stt = ReductionState(stage_identity=stS.identity(), problem_sha256=problem_hash(stS, None),
                         problem_line=stS.problem_line())
    stt.save(ck)
    try:
        load_checkpoint(ck, st, None, log=lambda *a: None)
        chk("c1.2 checkpoint-problem-mismatch is refused", False, "it was ACCEPTED")
    except CheckpointMismatch as e:
        txt = str(e)
        chk("c1.2 checkpoint-problem-mismatch is refused",
            "different search" in txt and "reduce {S}" in txt and "reduce {L}" in txt,
            txt.splitlines()[1].strip())
    ok = load_checkpoint(ck, stS, None, log=lambda *a: None)
    chk("c1.2 the same problem with different budgets is accepted", ok is not None)
    os.unlink(ck)

    # c1.4: companion-suffices, on a stub oracle
    class Stub(Oracle):
        def __init__(self, stage):
            self.stage, self.sel = stage, []
            self.n_sat = self.n_unsat = self.n_unknown = 0
            self.t_sat = self.t_unsat = self.t_unknown = 0.0
            self.c_sat = self.c_unsat = self.c_unknown = 0.0
            self.wall, self.slice, self.slices = 600.0, SLICE_CONFLICTS, 0

        def ask(self, kept, wall="default", slice_conflicts=None):
            self.n_unsat += 1
            return "unsat", None
    real_oracle = globals()["Oracle"]
    globals()["Oracle"] = lambda stage, wall=600.0, slice_conflicts=SLICE_CONFLICTS: Stub(stage)
    try:
        rec = reduce_stage(st, log=lambda *a: None)
    finally:
        globals()["Oracle"] = real_oracle
    chk("c1.4 companion-suffices fires when the empty selection refuses",
        rec["verdict"] == "companion-suffices" and "bound" not in rec, rec["verdict"])

    print(f"\n{'ALL CONTROLS FIRED' if not fails else 'FAILED: ' + ', '.join(fails)}")
    return not fails


def _resume_control(rung_order=3):
    """c1.1, the exact-resume control: the S166 stage at its order-3 rung, once uninterrupted and
    once killed mid-level and resumed, must agree on the LEVEL -- the minima as a set, `w*` and the
    method -- and on the pre-interruption prefix of `Y`. The post-resume harvest is COMPARED and
    REPORTED, never gated: a fresh solver may return a different model for the same colourable ask,
    so demanding an identical `Y` would assert something false about correct code (§O2)."""
    import parts_faces as F
    D = os.path.join(ROOT, "data", "m62", "parts-ref11", "JP", "Large")
    B = P.Base(P.PARTS_R)
    G = F.base_group_perms(B)
    st0 = PS.Stage(B, V.load_lattice(os.path.join(D, "v374e1860.vtx")),
                   V.load_lattice(os.path.join(D, "v166e774.vtx")), side="S", rung=1)
    aut = F.stage_symmetry(B, st0, G)
    subs = [h for h in F.subgroups(aut) if h.order == rung_order]
    if len(subs) != 1:
        raise SystemExit(f"{len(subs)} subgroups of order {rung_order}; name one explicitly")
    keep = {tuple(l[1]) for l in st0.atom_labels}
    maps = [g for g in G if {g[t] for t in keep} == keep]
    sub = subs[0]
    # the rung's lattice maps: the base-group elements whose atom permutation lies in the subgroup
    atup = [tuple(l[1]) for l in st0.atom_labels]
    ix = {t: i for i, t in enumerate(atup)}
    rung_maps = [g for g in maps
                 if tuple(ix[g[atup[a]]] for a in range(len(atup))) in set(sub.perms)]
    mk = lambda: PS.Stage(B, V.load_lattice(os.path.join(D, "v374e1860.vtx")),
                          V.load_lattice(os.path.join(D, "v166e774.vtx")), side="S",
                          rung_maps=rung_maps)
    print(f"rung {rung_order}: {len(rung_maps)} maps, {len(mk().atoms)} atoms")
    t0 = time.time()
    a = reduce_stage(mk(), log=print)
    print(f"  uninterrupted: {a['bound_render']}, {len(a['minima'])} minima, "
          f"{a['hypergraph']['correction_sets']} correction sets, {a['seconds']}s")
    ck = os.path.join(ROOT, "build", "gate", "m63", "resume-control.ckpt.json")
    if os.path.exists(ck):
        os.unlink(ck)
    half = max(2, a["state"].iteration // 2)
    try:
        reduce_stage(mk(), checkpoint=ck, log=lambda *x: None, _stop_after=half)
        print("  PLANT DID NOT FIRE: the run finished without the planted interruption")
        return False
    except PlantedInterruption as e:
        pre = json.load(open(ck))
        print(f"  killed at iteration {pre['iteration']} ({e}); checkpoint holds "
              f"{len(pre['corr'])} correction sets, {len(pre['minima'])} minima")
    b = reduce_stage(mk(), checkpoint=ck, log=print)
    same_level = ({tuple(m) for m in a["minima"]} == {tuple(m) for m in b["minima"]}
                  and a["bound"] == b["bound"] and a["M_set"]["count"]["method"] ==
                  b["M_set"]["count"]["method"])
    prefix = [sorted(c) for c in pre["corr"]]
    got = b["hypergraph"]["sets"]
    prefix_ok = all(p in got for p in prefix)
    print(f"  resume-identical: {same_level}   (minima {len(b['minima'])}, {b['bound_render']})")
    print(f"  pre-interruption Y prefix preserved: {prefix_ok} ({len(prefix)} sets)")
    print(f"  Y compared, NOT gated: {a['hypergraph']['correction_sets']} uninterrupted vs "
          f"{b['hypergraph']['correction_sets']} resumed")
    print("\n" + ("RESUME CONTROL FIRES" if same_level and prefix_ok else
                  "RESUME CONTROL FAILED"))
    return same_level and prefix_ok


if __name__ == "__main__":
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--resume-control", action="store_true")
    a = ap.parse_args()
    if a.resume_control:
        sys.exit(0 if _resume_control() else 1)
    sys.exit(0 if _self_test() else 1)
