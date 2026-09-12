#!/usr/bin/env python3
"""D3 and D4: the expansion rule, and the loop that runs it. M63 acceptance clause 2(b).

The clause, verbatim (`plans/M63-parts-reproduction.md` §S.1 2(b)): *a rule, registered and
committed before it runs, starting from our 375-level accumulator (which equals his `A403`) with
no knowledge of his orbits, chooses the expansion, and the loop reaches `|M| <= 374` on the L side.*

**What this module may not see.** A rule reads only: the candidate, the current complete level, the
stored correction-set hypergraph `Y`, the reserve/admission order computed from the base, and the
loop's own history. It may not read his files, his tables, or any orbit name taken from them. `Ctx`
is the enforcement point and carries nothing else; `Ctx.check_clean()` is control d3.4.

**What the map already says, so nobody reads a column of zeros as a failure.** The complete
single-orbit sweep at the LATER accumulator `A412` returned 0 of 63 improving and 1 of 63 growing
(`data/m62/m63-map-A412.json`), and the small half's independent probe returned 0 of 10. So single
orbits are essentially never in an optimal solution at that state. At `A403` the only thing KNOWN
is that a SET of four orbits reaches 374 -- his own recorded move. **Whether any single orbit
suffices there is the open measurement, and neither the product owner, the advisor nor this module
may assert it.** That is why the rule is a set-valued rule with a single-orbit first rung, and why
`many_then_trim` -- his own second published strategy -- is implemented rather than deferred.

    python3 tools/parts_rule.py --self-test
    python3 tools/parts_rule.py freeze --out data/m62/m63-rule-freeze.json
    python3 tools/parts_rule.py loop --A v403e2112.vtx --incumbent 374 --out ...
"""
from __future__ import annotations
import argparse, json, os, random, sys, time
from dataclasses import dataclass, field, fields

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import parts_repro as P
import parts_report as R
import parts_reduce as RED
import parts_stage as PS
import parts_vtx as V
import parts_faces as F
import parts_loop as PL
import typem as T

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REF11 = os.path.join(ROOT, "data", "m62", "parts-ref11", "JP", "Large")
READING = PL.ADOPTED_READING

# THE LOOP IS ANCHORED, on its own starting level (`plans/M63-phaseG-bases-and-rotations.md` §A5).
# It used to pass `anchor_tuples=None`, which the sweep read as "no anchor" while still reporting
# `restriction-identity-holds` -- the verdict an anchored run produces.
#
# The anchor is a CONTROL and never a rule parameter: it enters no ranking, no target and no
# frozen config, so the rule hash is untouched (asserted in `_self_test`). It cannot change an
# answer, only cost, so it cannot invalidate a frozen comparison -- and it is the ONLY one of the
# four invariants that checks against a truth from outside the pipeline.
#
# The cost was quoted at 0.2 s per candidate when the ruling was made, and that was wrong by 30x:
# measured on the A403 sweep stage it is 6.46 s, almost all of it one 374-atom UNSAT proof. The
# ruling stands on the count rather than the ask -- this loop evaluates at most
# `candidates_evaluated_per_iteration x max_iterations` = 18 candidates, so the anchor costs about
# 116 s for a whole run.
# The freeze decision is three-valued too, for the same reason the anchor is: `--require-frozen`
# was `action="store_true"`, so a run that said nothing about the freeze checked nothing and its
# artifact looked exactly like a checked one's.
FREEZE_MISSING = "freeze-decision-missing"
FREEZE_REQUIRE = "freeze-required"


class Unfrozen:
    """A DECLARED unfrozen run, carrying the reason, stamped into the artifact.

    A tuning run, a rehearsal or a repair is a perfectly good reason not to check the freeze.
    Saying nothing is not."""

    MIN_REASON = 24

    def __init__(self, reason: str):
        if not isinstance(reason, str) or len(reason.strip()) < self.MIN_REASON:
            raise ValueError(
                f"an unfrozen run must be DECLARED with a reason of at least {self.MIN_REASON} "
                f"characters; got {reason!r}. A blank reason is `store_true` again.")
        self.reason = reason


def resolve_freeze(freeze, cfg, row, *, log=print) -> dict:
    """Require the freeze, or record a declared-unfrozen run. Saying nothing is fatal."""
    if freeze is FREEZE_MISSING:
        raise SystemExit(
            "this run made no decision about the freeze.\n"
            "  Pass --require-frozen, which checks the rule against the committed freeze and the\n"
            "  row against its registration, or --declare-unfrozen \"<why>\", whose reason is\n"
            "  printed and written into the artifact. The flag used to default to OFF, so an\n"
            "  unchecked run and a checked one produced indistinguishable artifacts.")
    if freeze is not FREEZE_REQUIRE and not isinstance(freeze, Unfrozen):
        raise SystemExit(f"unknown freeze decision {freeze!r}; one of FREEZE_REQUIRE, "
                         f"Unfrozen(reason), or the fatal default")
    if isinstance(freeze, Unfrozen):
        log(f"  FREEZE NOT CHECKED (declared): {freeze.reason}")
        return {"state": "declared-unfrozen", "reason": freeze.reason, "row": row,
                "consequence": "no claim in this artifact is a held-out claim"}
    rec = R.require_frozen(cfg, row=row)
    log(f"  freeze commit {rec['freeze_commit'][:12]}; row {row['row_id']}: {rec['reading']}")
    return {"state": "frozen", **rec}




# ==================================================================== D3: the look-ahead
def look_ahead(base, A_tuples, companion, cand, necessary_tuples, *, batch=8, wall_ask=60.0,
               orc=None, log=None) -> dict:
    """**Price a candidate before paying to reduce it**: how many currently necessary atoms does
    this expansion free?

    An atom is *necessary* when it lies in every minimum of the COMPLETE level
    (`parts_faces.LevelSet.necessary()`), and an expansion helps exactly when the new material
    covers what such an atom covered alone. Re-derived on our 375 level: **336 necessary atoms,
    against `Y`'s harvested degree-1 layer of 312** -- the two are different objects and the
    distinction is load-bearing (§1(e)1), because `Y` is harvested lazily and is a subset.

    Priced by his §5.8 **8-4-2-1** batching: delete `batch` necessary atoms at once from the
    enlarged graph and ask. A refusal frees all of them in ONE ask -- sound because the property
    is upward closed, so if the graph still refuses with all eight gone it refuses with any one
    gone. A colourable answer splits the batch in half and recurses.

    An `unknown` ask counts the batch as NOT freed and is reported: a budget fact may never read
    as a graph fact.

    **This is a PREDICTOR and may never be an outcome column** (the frozen protocol's ban, Poros
    card 7(iii)): the temptation to grade it against itself arrives exactly when the primary
    outcome comes back all-zero."""
    t0 = time.time()
    W = PL.expanded(A_tuples, cand)
    stage = PS.Stage(base, W, sorted(companion), side="L", rung=1, pin=True)
    lab = {tuple(l[1]): i for i, l in enumerate(stage.atom_labels)}
    missing = [t for t in necessary_tuples if t not in lab]
    tgt = [lab[t] for t in necessary_tuples if t in lab]
    allA = set(range(len(stage.atoms)))
    own = orc is None
    orc = orc or RED.Oracle(stage, wall=wall_ask)
    freed, collapses, unknown = [], 0, 0

    def probe(group):
        nonlocal collapses, unknown
        if not group:
            return
        v, _ = orc.ask(sorted(allA - set(group)))
        if v == "unsat":
            freed.extend(group)
            collapses += 1
            return
        if v == "unknown":
            unknown += len(group)
            return
        if len(group) == 1:
            return
        h = len(group) // 2
        probe(group[:h])
        probe(group[h:])

    for i in range(0, len(tgt), batch):
        probe(tgt[i:i + batch])
    st = orc.stats()
    if own:
        orc.S.delete()
    return {"freed": len(freed), "of_necessary": len(tgt), "batch": batch,
            "batch_collapses": collapses, "undecided_atoms": unknown,
            "necessary_not_in_stage": len(missing),
            "asks": st["colourable"]["n"] + st["refusing"]["n"] + st["undecided"],
            "seconds": round(time.time() - t0, 1),
            "note": "a PREDICTOR, never an outcome column (the frozen protocol's ban)"}


def many_then_trim(base, A_tuples, ranked, oracle, *, n_orbits=6, min_final_degree=3,
                   reading=READING) -> "PL.Candidate":
    """His SECOND published strategy (`[Parts2020a]` §5.6, lines 544-545), which no earlier plan in
    this milestone carried: *"filling and (or) adding a relatively large number of orbits, but with
    the subsequent removal of new vertices with a small final degree."*

    Add the top `n_orbits` candidates' vertices at once, then drop added vertices whose degree INTO
    the enlarged graph stays below `min_final_degree`. It is the only published way to make a
    set-valued expansion cheap, because the trim is what keeps the gap -- and therefore the level
    -- small.

    **One reading stated rather than assumed:** *final* degree is taken to a FIXED POINT, since
    trimming a vertex lowers its neighbours' degrees; the single-pass count is reported beside it
    so the choice is visible and reversible."""
    add = set()
    for c, _ in ranked[:n_orbits]:
        add |= set(c.vertices)
    A = set(A_tuples)
    single = {t for t in add if oracle.deg(t, (A | add) - {t}, reading) >= min_final_degree}
    keep = set(add)
    while True:
        W = A | keep
        drop = {t for t in keep if oracle.deg(t, W - {t}, reading) < min_final_degree}
        if not drop:
            break
        keep -= drop
    return PL.Candidate(frozenset(keep), "many-then-trim",
                        frozenset({f"from-{n_orbits}-orbits", f"trim-{min_final_degree}",
                                   f"single-pass-would-keep-{len(single)}",
                                   f"added-{len(add)}"}))


# ==================================================================== D3: the ranking
@dataclass(frozen=True)
class Ctx:
    """Everything a rule may read, and nothing else (control d3.4).

    Adding a field is a change to what a rule can see, so it is a change to the frozen rule and
    must go through a new freeze commit. `check_clean` refuses any value that names his archive."""
    A_tuples: tuple
    census_rank: dict          # candidate name -> his decreasing-admission-degree position
    proxy: dict                # candidate name -> look_ahead dict, where it was computed
    n_new_max: int
    seed: int
    history: tuple = ()

    def check_clean(self):
        bad = []
        for f_ in fields(self):
            v = getattr(self, f_.name)
            s = json.dumps(v, default=str)
            for needle in ("parts-ref11", "v403e", "v412e", "v374e", "Table", "JP/Large"):
                if needle in s:
                    bad.append((f_.name, needle))
        if bad:
            raise ValueError(f"the context names his files or tables: {bad[:4]} -- a rule that can "
                             f"see his answers cannot support a reproduction claim (§6.1)")
        return {"verdict": "context-carries-no-answer-key", "fields": [f_.name for f_ in fields(self)]}


def _rank_ours(cands, ctx):
    """**Our rule, committed before it runs.**

    Rank by freed necessary atoms PER VERTEX ADDED, ties broken by his decreasing-admission-degree
    order, restricted to candidates of at most `n_new_max` vertices. Candidates the proxy cannot
    separate keep his order, so the rule degrades to his where it has no information."""
    out = []
    for c in cands:
        if c.n_new > ctx.n_new_max:
            continue
        p = ctx.proxy.get(c.name(_BASE))
        score = (p["freed"] / c.n_new) if (p and c.n_new) else None
        out.append((c, {"freed_per_vertex": score, "freed": (p or {}).get("freed"),
                        "n_new": c.n_new, "his_rank": ctx.census_rank.get(c.name(_BASE), 10 ** 6)}))
    out.sort(key=lambda r: (-(r[1]["freed_per_vertex"] if r[1]["freed_per_vertex"] is not None
                             else -1.0), r[1]["his_rank"]))
    return out


def _rank_his_degree(cands, ctx):
    out = [(c, {"his_rank": ctx.census_rank.get(c.name(_BASE), 10 ** 6), "n_new": c.n_new})
           for c in cands if c.n_new <= ctx.n_new_max]
    out.sort(key=lambda r: r[1]["his_rank"])
    return out


def _rank_random(cands, ctx):
    rng = random.Random(ctx.seed)
    out = [(c, {"n_new": c.n_new}) for c in cands if c.n_new <= ctx.n_new_max]
    rng.shuffle(out)
    return out


RULES = {"ours": _rank_ours, "his_degree": _rank_his_degree, "random": _rank_random}
_BASE = None                  # set by `rank`, so a rule never holds a base of its own


def rank(base, cands, rule: str, ctx: Ctx):
    """The frozen ranking, taken BY NAME so a control differs from the real run by one string."""
    global _BASE
    _BASE = base
    if rule not in RULES:
        raise SystemExit(f"unknown rule {rule!r}; one of {sorted(RULES)}")
    ctx.check_clean()
    return RULES[rule](cands, ctx)


# ==================================================================== D4: the loop
def frozen_config(*, rule="ours", n_new_max=24, batch=8, stall_limit=3, budget=3,
                  max_iterations=6, escalate=(12, 40), trim_degree=3, trim_orbits=6,
                  seed=20260911) -> dict:
    """The configuration that goes into the freeze COMMIT, so the code and the freeze cannot drift.

    `escalate` is his own stall escape -- *"increasing the number of new vertices introduced in the
    expansion stage"* -- as an explicit schedule of `n_new_max` values, and the last rung is where
    `many_then_trim` becomes reachable.

    **What happens if the held-out map is signal-free is part of the freeze, not of the reading
    afterwards** (Poros's fifth rule, adopted by the product owner): if no single orbit improves at
    `A403`, the rule is scored by outcome on one held-out row -- one bit -- and the acceptance says
    that plainly rather than implying a map stands behind it."""
    return {
        "rule": rule,
        "definition": ("rank by look_ahead.freed per vertex added, ties broken by his decreasing "
                       "admission-degree order, restricted to candidates of at most n_new_max "
                       "vertices; on a stall raise n_new_max (his own escape) and re-rank; at the "
                       "last rung propose his second strategy, many_then_trim"),
        "n_new_max": n_new_max, "escalation_schedule": list(escalate),
        "look_ahead_batch": batch, "stall_limit": stall_limit,
        "candidates_evaluated_per_iteration": budget, "max_iterations": max_iterations,
        "many_then_trim": {"orbits": trim_orbits, "min_final_degree": trim_degree,
                           "final_degree_is_a_fixed_point": True},
        "admission_reading": READING, "seed": seed,
        "held_out_state": "our 375-level accumulator, 403 vertices, which equals his v403e2112 "
                          "literally (zero differing vertices, re-derived 2026-09-11)",
        "incumbent_weight": 374,
        "target": "the primary decision asks target = incumbent - 1 = 373 atoms, i.e. |M| <= 374 "
                  "vertices, which is exactly clause 2(b)",
        "outcome": "clause 2(b) is met only by |M| <= 374; {M} growth at fixed |M| and fixed rung "
                   "in an iteration that added vertices is clause 2(c) and is recorded separately",
        "if_the_held_out_map_is_signal_free": (
            "then the rule is scored by outcome on ONE held-out row -- one bit -- and no map "
            "stands behind it. That is written here BEFORE the run so it is anticipated rather "
            "than salvaged. A column of zeros at A403 is the STRONGER outcome: it sits beside a "
            "demonstrated four-orbit success from the same state, making 'single-orbit expansion "
            "never works, even where a four-set does' a fact about single moves rather than about "
            "that state."),
        "bans": ["no ranking is scored against an outcome it also predicts (atoms-freed)",
                 "every arm reported in full, never the best",
                 "three outcome states -- improved, inert, undecided -- and a wall hit is never "
                 "folded into inert",
                 "no loop iteration started from a truncated level"],
    }


def _start_state(base, rec: dict, companion_file: str):
    """The loop's starting state, in ONE place, so `register-row` registers exactly what the loop
    runs rather than a second derivation of it that can drift from it.

    Returns `(stage0, A_tuples, incumbent, level_set)`. `incumbent` is a WEIGHT in atoms, so
    `|M| = incumbent + 1` vertices."""
    if "A" not in rec or rec.get("A_sample"):
        raise SystemExit("d4.1: this starting record carries no complete A (or carries a sample). "
                         "The loop's state variable is the union of ALL minima; a sampled A "
                         "invents and hides candidates, because the reserve is non-monotone in "
                         "both directions (§3.3).")
    ls = F.LevelSet.from_record(rec)
    ls.require_complete("the loop's starting level")
    stage0 = PS.Stage(base, V.load_lattice(os.path.join(REF11, "v451e2400.vtx")),
                      V.load_lattice(os.path.join(REF11, "v136e564.vtx")),
                      side="L", rung=1, pin=True)
    if stage0.fingerprint() != rec["stage_fingerprint"]:
        raise SystemExit("the starting record was not produced by the stage this loop rebuilt")
    A_tuples = sorted({tuple(stage0.atom_labels[i][1]) for i in rec["A"]} |
                      {tuple(stage0.keys[stage0.A.centre])})
    return stage0, A_tuples, ls.size, ls


def row_state(row_id: str, stage0, A_tuples, incumbent: int, base, companion_tuples) -> dict:
    """The row this run actually starts from, **derived from the objects in hand**.

    The freeze carries `held_out_state`, `incumbent_weight` and `target` -- prose and a number
    about one starting state -- inside its config hash, while the runtime incumbent comes from
    the starting RECORD. So a frozen run on any other row passed `require_frozen` by hash
    equality while its receipt asserted the frozen row's state. This function is the replacement
    for that string: `parts_report.require_frozen` takes it, checks it, and puts it in the
    receipt, and a row that contradicts the freeze must carry its own committed registration.

    It also carries §S.5's two pins -- `cross_law` and the base -- which the 2026-09-11 freeze
    does not and may not be edited to include."""
    return {"row_id": row_id,
            "incumbent_weight": incumbent,
            "A_vertices": len(A_tuples),
            "A_fp": R.fp_tuples(sorted(A_tuples)),
            "companion_fp": R.fp_tuples(sorted(companion_tuples)),
            "stage_fingerprint": stage0.fingerprint(),
            "cross_law": {"name": stage0.cross_law.name, "cos": T.kstr(stage0.cross_law.cos)},
            "base_fp": R.fp_base(base),
            "base_r": base.r}


def step(base, A_tuples, companion, cands, *, incumbent, rule, ctx, budget, reference,
         anchor_tuples, ckpt_dir, wall_ask=600.0, log=print) -> dict:
    """One iteration: rank, then spend the expensive evaluation on the top `budget` candidates.

    His success criterion (§5.5), verbatim: *"The iteration is considered successful if it leads to
    a change in the graph A: that is, either to a reduction of the order of the minimum graph M or
    else to an expansion of the set of minimal graphs {M}."* Both are recorded; **neither is a
    measure** -- the loop has no termination measure and saying so is the finding (§O3)."""
    ranked = rank(base, cands, rule, ctx)
    log(f"  ranked {len(ranked)} candidates under {rule!r}, n_new_max {ctx.n_new_max}; "
        f"top: {', '.join(c.name(base) for c, _ in ranked[:3])}")
    tried = []
    for c, info in ranked[:budget]:
        e = PL.sweep_candidate(base, A_tuples, companion, c, incumbent=incumbent,
                               reference=reference, anchor_tuples=anchor_tuples,
                               ckpt_dir=ckpt_dir, secondary=True, wall_ask=wall_ask, log=log)
        e["rank_info"] = info
        tried.append(e)
        log(f"    {e['name']:<28} {e['verdict']:<8} grew={e.get('M_set_grew')}  "
            f"{e.get('cpu_seconds')}s")
        # d4.4 -- the rung must be re-resolved after an expansion, never inherited.
        if e.get("rung_used") not in (None, 1):
            raise NotImplementedError(
                "d4.4: this stage came back at a rung above 1. An expansion changes the vertex set, "
                "so the rung -- a subgroup of the STAGE's stabiliser -- must be re-derived on the "
                "enlarged stage (parts_faces.stage_symmetry) and may not be inherited from the "
                "previous iteration.")
        if e["verdict"] == "yes":
            return {"verdict": "improved", "accepted": e, "tried": tried}
    grew = [e for e in tried if e.get("M_set_grew") == "yes"]
    if grew:
        return {"verdict": "grew", "accepted": grew[0], "tried": tried}
    trunc = [e for e in tried if e.get("M_set_grew") == "yes-but-level-truncated"]
    if trunc:
        return {"verdict": "level-truncated", "accepted": None, "tried": tried}
    if any(e["verdict"] == "unknown" for e in tried):
        return {"verdict": "undecided", "accepted": None, "tried": tried}
    return {"verdict": "unchanged", "accepted": None, "tried": tried}


def run_loop(base, start_record: str, *, companion_file, rule="ours", config=None,
             checkpoint=None, out=None, wall_ask=600.0, jobs=1, ckpt_dir=None,
             freeze=FREEZE_MISSING, row_id="A403", log=print) -> dict:
    """The loop, from a starting reduction RECORD rather than from a graph.

    Refuses a starting record carrying `A_sample` and no `A` (control d4.1): the loop's state
    variable is the union of ALL minima, and a sample is a different algorithm (§3.3). `stalled` is
    a VERDICT and not a success (d4.2). Exact resume per ITERATION (d4.3): a relaunch redoes at
    most one ranking, and the log line says so."""
    cfg = config or frozen_config(rule=rule)
    rec = json.load(open(start_record))
    stage0, A_tuples, incumbent, ls = _start_state(base, rec, companion_file)
    necessary = sorted(tuple(stage0.atom_labels[i][1]) for i in ls.necessary())
    companion = V.load_lattice(os.path.join(REF11, companion_file))
    # `Y`'s degree-1 layer is stored as a COUNT, not a list -- and it is 312 against the level's
    # 336 necessary atoms. The two are different objects: `Y` is harvested lazily and is a subset,
    # so a look-ahead reading it would under-count what an expansion has to free (§1(e)1).
    log(f"  start: |A| {len(A_tuples)}  |M| {incumbent + 1} vertices  |{{M}}| {len(ls.minima)}  "
        f"necessary {len(necessary)} (Y's degree-1 layer: {rec['hypergraph']['degree_1']})")

    # The freeze decision, THREE-VALUED and resolved before any expensive work: require it, or
    # declare this run unfrozen with a reason that lands in the artifact. Neither is fatal --
    # `--require-frozen` was `action="store_true"`, so the check defaulted to off and an
    # unchecked run and a checked one produced the same artifact.
    row = row_state(row_id, stage0, A_tuples, incumbent, base, companion)
    receipt = resolve_freeze(freeze, cfg, row, log=log)

    # The known-answer anchor, drawn from this level's own minima. A CONTROL, recorded beside the
    # rule and never inside it -- `row_state` does not carry it either, so a registered row is
    # not re-identified by a control that can be strengthened later.
    anchor = PL.anchor_from_level(stage0, ls.minima)
    log(f"  anchor: {len(anchor)} vertices from this level's own minima -- a control, not a rule "
        f"parameter; it cannot change a verdict, only cost (~6.5 s per candidate, ~"
        f"{cfg['candidates_evaluated_per_iteration'] * cfg['max_iterations'] * 6.5:.0f} s "
        f"for this run at most)")

    oracle = PL.EdgeOracle(base, companion, log=log)
    census = PL.menu_census(base, A_tuples, oracle, log=log)
    cands = PL.menu_candidates(base, A_tuples, census, reading=READING)
    census_rank = {c.name(base): i for i, c in enumerate(cands)}
    reference = PL.build_reference(base, A_tuples, companion)
    # The loop's per-candidate checkpoints need their OWN directory. `parts_loop.sweep_candidate`
    # names a checkpoint after the candidate's ORBITS -- `m63-map-(0,0,2,2):6.ckpt.json` -- and the
    # A412 sweep already wrote 89 files under those very names. The same orbit at a different
    # accumulator is a DIFFERENT search, so a shared directory would hand the loop the map's
    # checkpoints. `parts_reduce.load_checkpoint` refuses them by problem hash rather than resuming
    # (the refusal is an exception, not a log line), so the hazard was fatal rather than silent --
    # but a run that dies on its first candidate is still a run that does not happen.
    #
    # This is plumbing and not the rule: it changes WHERE bytes are written and nothing the rule
    # computes, which is why it is a post-freeze edit and why the freeze's own hash is untouched.
    ckpt_dir = ckpt_dir or os.path.join(ROOT, "data", "m62", "ckpt", "loop-A403")
    os.makedirs(ckpt_dir, exist_ok=True)

    state = {"iteration": 0, "A": [list(t) for t in A_tuples], "incumbent": incumbent,
             "stall": 0, "n_new_max": cfg["escalation_schedule"][0], "history": [], "rung": 1}
    if checkpoint and os.path.exists(checkpoint):
        state = json.load(open(checkpoint))
        A_tuples = sorted(tuple(t) for t in state["A"])
        log(f"  resumed at iteration {state['iteration']}; a relaunch redoes at most one ranking")

    t0 = time.time()
    verdict = "budget-spent"
    while state["iteration"] < cfg["max_iterations"]:
        it = state["iteration"] + 1
        pool = [c for c in cands if c.n_new <= state["n_new_max"]]
        proxy = {}
        for c in pool[:cfg["candidates_evaluated_per_iteration"] * 4]:
            proxy[c.name(base)] = look_ahead(base, A_tuples, companion, c, necessary,
                                             batch=cfg["look_ahead_batch"], wall_ask=60.0)
        ctx = Ctx(tuple(A_tuples), census_rank, proxy, state["n_new_max"], cfg["seed"],
                  tuple(map(tuple, state["history"])))
        if state["n_new_max"] >= cfg["escalation_schedule"][-1]:
            ranked0 = rank(base, pool, rule, ctx)
            mt = many_then_trim(base, A_tuples, ranked0, oracle,
                                n_orbits=cfg["many_then_trim"]["orbits"],
                                min_final_degree=cfg["many_then_trim"]["min_final_degree"])
            log(f"  stall escape: many_then_trim proposes {mt.n_new} vertices "
                f"({mt.name(base)[:80]})")
            pool = [mt] + pool
            proxy[mt.name(base)] = look_ahead(base, A_tuples, companion, mt, necessary,
                                              batch=cfg["look_ahead_batch"], wall_ask=60.0)
            ctx = Ctx(tuple(A_tuples), census_rank, proxy, mt.n_new, cfg["seed"],
                      tuple(map(tuple, state["history"])))
        r = step(base, A_tuples, companion, pool, incumbent=state["incumbent"], rule=rule, ctx=ctx,
                 budget=cfg["candidates_evaluated_per_iteration"], reference=reference,
                 anchor_tuples=anchor, ckpt_dir=ckpt_dir, wall_ask=wall_ask, log=log)
        state["iteration"] = it
        state["history"].append([it, r["verdict"], state["incumbent"] + 1, state["n_new_max"],
                                 round(time.time() - t0, 1)])
        log(f"  it {it}  {r['verdict']}  |M| {state['incumbent'] + 1}  n_new_max "
            f"{state['n_new_max']}  stall {state['stall']}/{cfg['stall_limit']}")
        if r["verdict"] == "improved":
            verdict = "improved"
            state["accepted"] = r["accepted"]["name"]
            mv = r["accepted"]["M"]
            if not isinstance(mv, int):
                # §A5: an unanchored refusal reports |M| as the STRING ">=N", and a bound may
                # never become the next incumbent. An accepted candidate always carries an exact
                # |M| (the reduction exhibits its own selection), so reaching this is a bug in the
                # entry, not a bound legitimately arriving -- and it must say so, not TypeError.
                raise SystemExit(
                    f"A5: the accepted candidate {state['accepted']} reports |M| = {mv!r}, which "
                    f"is a BOUND and not a value. An accepted (`reduced`) candidate exhibits its "
                    f"own selection, so its |M| is exact; a bound here means the entry came from "
                    f"the refused path and the loop must not adopt it as an incumbent.")
            state["incumbent"] = mv - 1
            break
        if r["verdict"] == "grew":
            state["stall"] = 0
            state["grew_at"] = r["accepted"]["name"]
        else:
            state["stall"] += 1
            if state["stall"] >= cfg["stall_limit"]:
                sched = cfg["escalation_schedule"]
                nxt = next((x for x in sched if x > state["n_new_max"]), None)
                if nxt is None:
                    verdict = "stalled"
                    break
                state["n_new_max"] = nxt
                state["stall"] = 0
        if checkpoint:
            json.dump(state, open(checkpoint + ".tmp", "w"))
            os.replace(checkpoint + ".tmp", checkpoint)
    rep = {"kind": "m63-loop", "schema": 1, "producer": "tools/parts_rule.py:run_loop",
           "rule": rule, "config": cfg, "verdict": verdict,
           "start": {"A": len(A_tuples), "M_vertices": incumbent + 1,
                     "M_set": len(ls.minima), "necessary": len(necessary)},
           "iterations": state["history"], "state": state,
           "row": row, "freeze_receipt": receipt,
           "controls": {"anchor": {
               "source": "the lexicographically least minimum of this loop's own starting level",
               "vertices": len(anchor), "atoms": len(anchor) - 1,
               "asks": "the minimum still refuses in the expanded stage; minus one atom is "
                       "colourable. Both answers are invariant under expansion, because "
                       "colourability depends on the selection and the companion alone",
               "in_the_rule_hash": False,
               "cost": "6.46 s per candidate measured on the A403 sweep stage (538 vertices, "
                       "402 atoms; min of 3), almost all of it the first ask's 374-atom UNSAT "
                       "proof; at most 18 candidates per run, so about 116 s for a whole loop",
               "note": "a control, never a rule parameter: it enters no ranking, no target and "
                       "no frozen config, and it cannot change a verdict, only cost"}},
           "clause_2b": ("MET -- the loop reached |M| <= 374 from our 375-level accumulator"
                         if verdict == "improved" else
                         f"NOT MET -- the loop ended `{verdict}` with the budget it had"),
           "seconds": round(time.time() - t0, 1),
           "provenance": R.provenance() if hasattr(R, "provenance") else {}}
    if out:
        json.dump(rep, open(out, "w"), indent=1)
    return rep


# ==================================================================== controls
def _self_test(log=print):
    fails = []

    def chk(name, cond, detail=""):
        log(f"  {'ok  ' if cond else 'FAIL'} {name}{('  ' + detail) if detail else ''}")
        if not cond:
            fails.append(name)

    # d3.1 -- a candidate that adds nothing is unrepresentable
    try:
        PL.Candidate(frozenset(), "reserve")
        chk("d3.1 the empty expansion is refused", False)
    except ValueError as e:
        chk("d3.1 the empty expansion is refused", "no-op-expansion" in str(e))

    # d3.4 -- the context may not name his files
    c = Ctx(((0, 0, 0, 0),), {}, {}, 12, 1)
    chk("d3.4 a clean context passes", c.check_clean()["verdict"] == "context-carries-no-answer-key")
    dirty = Ctx((("parts-ref11/JP/Large/v403e2112.vtx",),), {}, {}, 12, 1)
    try:
        dirty.check_clean()
        chk("d3.4 a context naming his archive is refused", False)
    except ValueError:
        chk("d3.4 a context naming his archive is refused", True)

    # the rule is taken by name, and an unknown name is refused rather than defaulted
    try:
        rank(None, [], "not-a-rule", c)
        chk("an unknown rule name is refused", False)
    except SystemExit:
        chk("an unknown rule name is refused", True)

    # d3.2/d3.3 -- the look-ahead reads a COMPLETE level or refuses
    trunc = F.LevelSet(atoms=(0, 1), minima=(frozenset({0}),), size=1, complete=False)
    try:
        trunc.necessary()
        chk("d3.2 a truncated level cannot supply necessary atoms", False)
    except ValueError:
        chk("d3.2 a truncated level cannot supply necessary atoms", True)

    # d4.1 -- a starting record with no complete A is refused
    import tempfile
    with tempfile.NamedTemporaryFile("w", suffix=".json", delete=False) as f:
        json.dump({"A_sample": [1, 2]}, f)
        p = f.name
    try:
        run_loop(None, p, companion_file="v136e564.vtx")
        chk("d4.1 a sampled starting A is refused", False)
    except SystemExit as e:
        chk("d4.1 a sampled starting A is refused", "d4.1" in str(e))
    os.unlink(p)

    # the frozen config states its own signal-free branch, which is the thing a later reader needs
    cfg = frozen_config()
    chk("the freeze anticipates a signal-free map",
        "one bit" in cfg["if_the_held_out_map_is_signal_free"])
    chk("the freeze bans self-scoring", any("atoms-freed" in b for b in cfg["bans"]))

    # --- the freeze decision is THREE-VALUED, like the anchor. `--require-frozen` was
    # `action="store_true"`, so a run that said nothing checked nothing and produced an artifact
    # indistinguishable from a checked run's.
    #
    # THE UNINFORMATIVE OUTCOME: "it raised" proves nothing if it raised for another reason, so
    # each refusal is matched on its own message; and a pair of refusals proves nothing if the
    # ACCEPT arm is broken, so the declared arm is asserted to return with its reason intact.
    fake_row = {"row_id": "control", "incumbent_weight": 1}
    try:
        resolve_freeze(FREEZE_MISSING, cfg, fake_row, log=lambda *a: None)
        chk("a run that says nothing about the freeze is FATAL", False)
    except SystemExit as e:
        chk("a run that says nothing about the freeze is FATAL",
            "no decision about the freeze" in str(e) and "--declare-unfrozen" in str(e))
    try:
        Unfrozen("tuning")
        chk("an unfrozen run with a token reason is refused", False)
    except ValueError as e:
        chk("an unfrozen run with a token reason is refused", "at least" in str(e))
    u = resolve_freeze(Unfrozen("a rehearsal of the loop's plumbing, scored against nothing"),
                       cfg, fake_row, log=lambda *a: None)
    chk("ACCEPT ARM: a declared-unfrozen run returns, carrying its reason into the artifact",
        u["state"] == "declared-unfrozen" and "rehearsal" in u["reason"] and u["row"] == fake_row)
    chk("the descriptive fields are OUT of the compared rule hash, so hash equality no longer "
        "certifies a starting state",
        all(k not in R.rule_portion(cfg) for k in R.ROW_DESCRIPTIVE)
        and all(k in cfg for k in R.ROW_DESCRIPTIVE),
        f"excluded {list(R.ROW_DESCRIPTIVE)}")
    chk("the rule portion is still almost all of the config (the exclusion is surgical)",
        len(R.rule_portion(cfg)) == len(cfg) - len(R.ROW_DESCRIPTIVE),
        f"{len(R.rule_portion(cfg))} of {len(cfg)} keys")

    # --- the anchor is a CONTROL and never a rule parameter. The ruling that wired it into the
    # loop rests on exactly this: it cannot invalidate a frozen comparison because it enters no
    # ranking, no target and no frozen config. Pinned by value, so any edit that lets it (or
    # anything else) leak into the rule goes red here and not at the next held-out run.
    RULE_SHA = "a2113b8f796e2288e0d336e96ebc2839016b1bc485fed3688375b73da4344405"
    chk("the anchor does not enter the rule hash, which is byte-for-byte what it was before it "
        "was wired in", R.config_sha256(R.rule_portion(cfg)) == RULE_SHA,
        R.config_sha256(R.rule_portion(cfg))[:16])
    chk("and that hash is the committed freeze's own, so the pin is not a private constant",
        R.config_sha256(R.rule_portion(
            json.load(open(os.path.join(ROOT, "data", "m62", "m63-freeze.json")))["config"]))
        == RULE_SHA)
    chk("no anchor word appears anywhere in the frozen config",
        "anchor" not in json.dumps(cfg).lower())
    # the pin must be DISCRIMINATING: a rule change has to move it, or it is pinning nothing
    chk("the rule hash is discriminating: changing a rule field moves it",
        R.config_sha256(R.rule_portion(frozen_config(n_new_max=25))) != RULE_SHA)
    log(f"  {'ALL CONTROLS FIRE' if not fails else 'FAILURES: ' + ', '.join(fails)}")
    return not fails


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--self-test", action="store_true", dest="selftest")
    sub = ap.add_subparsers(dest="cmd")
    f = sub.add_parser("freeze")
    f.add_argument("--out", required=True)
    l = sub.add_parser("loop")
    l.add_argument("--record", default="data/m62/m63-L451-reduction.json")
    l.add_argument("--companion", default="v136e564.vtx")
    l.add_argument("--rule", default="ours")
    l.add_argument("--checkpoint")
    l.add_argument("--ckpt-dir", dest="ckptdir",
                   help="where the PER-CANDIDATE checkpoints go; defaults to a loop-specific "
                        "directory, because the candidate names collide with the A412 sweep's")
    l.add_argument("--wall-ask", type=float, default=600.0)
    l.add_argument("--require-frozen", action="store_true",
                   help="check the RULE against the committed freeze and the ROW against its "
                        "committed registration, and stamp the receipt into the artifact")
    l.add_argument("--declare-unfrozen", dest="unfrozen", metavar="REASON",
                   help="run without checking the freeze, declaring why in one sentence. The "
                        "reason is printed and written into the artifact. Exactly one of this "
                        "and --require-frozen is required: the flag used to default to off")
    l.add_argument("--row-id", dest="rowid", default="A403",
                   help="which row this run starts from; its registration lives at "
                        "data/m62/m63-rows/<row-id>.json")
    l.add_argument("--out")
    rr = sub.add_parser("register-row", help="register a row's ACTUAL starting state, derived "
                                             "from the record and the base, so a frozen run on "
                                             "it can be checked without re-freezing")
    rr.add_argument("--record", default="data/m62/m63-L451-reduction.json")
    rr.add_argument("--companion", default="v136e564.vtx")
    rr.add_argument("--row-id", dest="rowid", required=True)
    rr.add_argument("--note", required=True,
                    help="what this row is and when it was registered, in one sentence")
    a = ap.parse_args()
    if a.selftest:
        return 0 if _self_test() else 1
    if a.cmd == "freeze":
        cfg = frozen_config()
        json.dump({"kind": "m63-rule-freeze", "schema": 1, "config": cfg,
                   "producer": "tools/parts_rule.py:frozen_config"}, open(a.out, "w"), indent=1)
        print(f"  wrote {a.out}; commit it BEFORE the scored run")
        return 0
    if a.cmd == "register-row":
        base = P.Base(P.PARTS_R)
        rec = json.load(open(a.record))
        stage0, A_tuples, incumbent, _ls = _start_state(base, rec, a.companion)
        comp = V.load_lattice(os.path.join(REF11, a.companion))
        row = row_state(a.rowid, stage0, A_tuples, incumbent, base, comp)
        path = R.row_path(a.rowid)
        os.makedirs(os.path.dirname(path), exist_ok=True)
        json.dump({"kind": "m63-row", "schema": 1,
                   "producer": "tools/parts_rule.py:register-row",
                   "note": a.note, "record": a.record, "companion": a.companion,
                   "registered": time.strftime("%Y-%m-%d"), "row": row},
                  open(path, "w"), indent=1, sort_keys=True)
        print(f"  wrote {path}\n  COMMIT IT before the run it registers:\n"
              f"    git add {path} && git commit -m \"register row {a.rowid}\"")
        return 0
    if a.cmd == "loop":
        cfg = frozen_config(rule=a.rule)
        if a.require_frozen and a.unfrozen:
            ap.error("--require-frozen and --declare-unfrozen are exclusive")
        # Refuse at the command line, before the base is built: `run_loop` refuses too, but a
        # minute of base construction before a refusal teaches people to skip the flag.
        if not a.require_frozen and not a.unfrozen:
            ap.error("give --require-frozen or --declare-unfrozen \"<why this run is not "
                     "scored>\". Neither is not an option: the flag used to default to off, so a "
                     "run that checked nothing produced an artifact indistinguishable from one "
                     "that did.")
        freeze = (Unfrozen(a.unfrozen) if a.unfrozen
                  else (FREEZE_REQUIRE if a.require_frozen else FREEZE_MISSING))
        base = P.Base(P.PARTS_R)
        r = run_loop(base, a.record, companion_file=a.companion, rule=a.rule, config=cfg,
                     checkpoint=a.checkpoint, out=a.out, wall_ask=a.wall_ask,
                     ckpt_dir=a.ckptdir, freeze=freeze, row_id=a.rowid)
        print(f"\n  {r['verdict'].upper()}: {r['clause_2b']}")
        return 0
    ap.print_help()
    return 1


if __name__ == "__main__":
    sys.exit(main())
