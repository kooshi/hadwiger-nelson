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
"""
from __future__ import annotations
import argparse, json, os, pickle, sys, time
from collections import defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import parts_repro as P
import parts_report as R
import parts_stage as PS
import parts_vtx as V

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


class Oracle:
    """One incremental solver over the stage's one-time CNF, counting its asks by outcome.

    The two populations are counted SEPARATELY because they differ by ~400x -- a colourable ask is
    0.02-3 s and a refusing one 10-15 s -- so any cost statement that merges them is a statement
    about a mixture nobody can reproduce."""

    def __init__(self, stage, wall=600.0):
        from pysat.solvers import Solver
        cls, sel, top, loc = stage.cnf()
        self.sel, self.loc, self.stage = sel, loc, stage
        self.S = Solver(name="cadical153", bootstrap_with=cls, use_timer=True)
        self.n_sat = self.n_unsat = self.n_unknown = 0
        self.t_sat = self.t_unsat = 0.0

    def ask(self, kept):
        """'unsat' (keeps the property) or 'sat' (loses it). Returns (verdict, model_or_None)."""
        t = time.time()
        ok = self.S.solve(assumptions=[self.sel[a] for a in kept])
        dt = time.time() - t
        if ok:
            self.n_sat += 1; self.t_sat += dt
            return "sat", self.S.get_model()
        self.n_unsat += 1; self.t_unsat += dt
        return "unsat", None

    def stats(self):
        return {"colourable": {"n": self.n_sat, "mean_s": round(self.t_sat / max(self.n_sat, 1), 3)},
                "refusing": {"n": self.n_unsat, "mean_s": round(self.t_unsat / max(self.n_unsat, 1), 3)},
                "undecided": self.n_unknown}


def kept_from_model(orc, model):
    """The atoms the solver left present -- a colourable superset of what was asked, free."""
    m = set(model)
    return {a for a, s in enumerate(orc.sel) if s in m}


def phase1(orc, atoms, log=print):
    """His degree-1 layer: an atom whose lone deletion loses the property is FIXED.

    Sound from monotonicity alone: if `all - {a}` is colourable then so is every selection missing
    `a`, since colourability is downward closed."""
    allA = list(range(len(atoms)))
    crit, drop = [], []
    t0 = time.time()
    for i, a in enumerate(allA):
        v, _ = orc.ask([x for x in allA if x != a])
        (crit if v == "sat" else drop).append(a)
        if (i + 1) % 25 == 0 or i + 1 == len(allA):
            log(f"    phase1 {i+1}/{len(allA)}  critical {len(crit)}  droppable-alone {len(drop)}"
                f"  [{time.time()-t0:.0f}s]")
    return crit, drop


def minimal_correction(orc, allA, T, log=None, tick=20.0):
    """Shrink `allA - T` to a minimal correction set.

    An undecided ask is treated as 'still needed', which keeps the result a valid (if possibly
    non-minimal) correction set -- and a non-minimal correction set is still a sound constraint,
    because every R-true selection meets every correction set, minimal or not."""
    left = sorted(set(allA) - set(T))
    i, t0, last = 0, time.time(), time.time()
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
            i += 1
    return left


def reduce_stage(stage, wall=600.0, max_minima=0, log=print, checkpoint=None,
                 phase2_wall=0.0):
    """Phases 1 and 2. Returns the record; never a bare number."""
    from pysat.formula import WCNF
    from pysat.examples.rc2 import RC2
    t0 = time.time()
    atoms = stage.atoms
    weight = [m.bit_count() for m in atoms]
    allA = list(range(len(atoms)))
    orc = Oracle(stage, wall)

    pin = stage.pin_is_sound()
    log(f"  pin control: {pin['verdict']} ({pin.get('checked', 0)} checks)")
    if pin["verdict"] == "pin-changes-answers":
        return {"verdict": "pin-unsound", "pin": pin,
                "note": "the symmetry break changes answers, so every refusal it produced is a "
                        "statement about a larger graph than was asked for"}

    v, _ = orc.ask(allA)
    if v != "unsat":
        return {"verdict": "base-fails",
                "note": "the working graph itself does not keep the key property, so every claim "
                        "downstream would quantify over an empty set"}
    log(f"  base keeps the property ({stage.describe()})")

    crit, drop = phase1(orc, atoms, log=log)
    corr = [[a] for a in crit]                          # degree-1 hyperedges
    log(f"  phase1: {len(crit)} critical / {len(drop)} droppable-alone of {len(atoms)} atoms"
        f"  [{time.time()-t0:.0f}s]")

    truncated_wall = False
    E, blocked, w_star = [], [], None
    it, last_tick = 0, time.time()
    while True:
        it += 1
        w = WCNF()
        for c in corr:
            w.append([a + 1 for a in c])                 # kept-set must hit every correction set
        for b in blocked:
            w.append([-(a + 1) for a in b])              # exclude this exact optimum
        for a in allA:
            w.append([-(a + 1)], weight=weight[a])       # minimise total kept weight
        with RC2(w) as rc:
            model = rc.compute()
            cost = rc.cost if model is not None else None
        if model is None:
            log(f"  level exhausted after {len(E)} minima  [{time.time()-t0:.0f}s]")
            break
        h = sorted(a for a in allA if model[a] > 0)
        wh = sum(weight[a] for a in h)
        if time.time() - last_tick > 20.0:
            last_tick = time.time()
            s = orc.stats()
            log(f"    it {it}: LB {wh}{'' if w_star is None else f' = w* {w_star}'}"
                f"  minima {len(E)}  corr {len(corr)} (smallest {min(len(c) for c in corr)})"
                f"  asks: {s['colourable']['n']} colourable @{s['colourable']['mean_s']}s / "
                f"{s['refusing']['n']} refusing @{s['refusing']['mean_s']}s  [{time.time()-t0:.0f}s]")
        if w_star is not None and wh > w_star:
            log(f"  next candidate weighs {wh} > {w_star}: the level is complete"
                f"  [{time.time()-t0:.0f}s]")
            break
        v, mdl = orc.ask(h)
        if v == "unsat":
            if w_star is None:
                w_star = wh
                log(f"  OPTIMUM FOUND: weight {w_star} (kept {len(h)} atoms) at iteration {it}"
                    f"  [{time.time()-t0:.0f}s]")
            E.append(h); blocked.append(h)
            if len(E) % 5 == 0 or len(E) == 1:
                log(f"    minima {len(E)}  |A| {len(set().union(*(set(x) for x in E)))} atoms"
                    f"  corr {len(corr)}  [{time.time()-t0:.0f}s]")
            if max_minima and len(E) >= max_minima:
                log(f"  stopping at max_minima={max_minima}: the level is TRUNCATED")
                break
        else:
            corr.append(minimal_correction(orc, allA, kept_from_model(orc, mdl), log=log))
        if phase2_wall and time.time() - t0 > phase2_wall:
            log(f"  phase-2 wall reached at {time.time()-t0:.0f}s: the level is TRUNCATED-AT-WALL")
            truncated_wall = True
            break
        if checkpoint and it % 20 == 0:
            pickle.dump({"corr": corr, "E": E, "blocked": blocked, "w_star": w_star, "it": it},
                        open(checkpoint, "wb"))

    complete = (w_star is not None) and not truncated_wall and not (
        max_minima and len(E) >= max_minima)
    bound = R.Bound(lower=w_star or 0, upper=w_star or sum(weight), rung=stage.rung,
                    undecided=orc.n_unknown)
    method = ("exhaustive-level" if complete else
              "truncated-at-wall" if truncated_wall else "truncated-at-budget")
    Aatoms = sorted(set().union(*(set(x) for x in E))) if E else []
    return {
        "verdict": "reduced" if w_star is not None else "no-reduction",
        "bound": R.asdict(bound), "bound_render": bound.render(),
        "M_vertices": None if w_star is None else w_star + stage.side_fixed,
        "M_set": R.asdict(R.SetSize(R.Count(len(E), method, of=None if complete else len(E)),
                                    up_to="as-found frames (no canonicalisation yet)")),
        "A_atoms": len(Aatoms),
        "minima": [sorted(x) for x in E],
        "A": Aatoms,
        "hypergraph": {"degree_1": len(crit), "correction_sets": len(corr),
                       "by_size": dict(sorted(defaultdict(int, {
                           k: sum(1 for c in corr if len(c) == k)
                           for k in sorted({len(c) for c in corr})}).items()))},
        "asks": orc.stats(),
        "stage_fingerprint": stage.fingerprint(),
        "seconds": round(time.time() - t0, 1),
    }
