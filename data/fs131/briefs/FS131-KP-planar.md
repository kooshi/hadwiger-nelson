# Brief FS131-KP — the planar infrastructure: plan the plane topology wave 5's seven planar leaves need, and repair `IsHoleOf`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-KP
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan wave 5's planar core — settle the faithful `IsHoleOf` (and message me before changing it), choose and state the shared plane-topology lemmas Mathlib lacks, lay the seven planar leaves out as a skeleton over them with `sorry` at every leaf, read each back, give a plan per leaf, run the obligation pass, and write the implementer's handoff
  launch: now, beside FS131-IM2 (wave 4's moves, on `fs131-w4m`), FS131-I4l (wave 4, on `fs131-w4`) and FS131-I5c (wave 5's other leaves, on `fs131-w5`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for the `IsHoleOf` choice (before you change it), a statement defect, a piece of the literature you find used by statement, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-KP.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-planar-kernel-plan.md`
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p` (branch `fs131-w5p`): new modules for the planar infrastructure under `Proofs/HadwigerNelson/Plane/` (your layout, upstream of `MapGraph`, `BaseWalk` and `BaseDense`); in `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean` only `IsHoleOf`, `fill`, `IsOuterTile`, `filledGraph`, `cvb_thom_reduced`, `cvb_pinch_connected`, `cvb_hole_disconnected` and children you add beside them; in `Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean` only `BaseCtx.retArcs_nested`, `BaseCtx.exists_endpoint`, `BaseCtx.exists_eleventh`; in `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` only `exists_unenclosed_or_bad`; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-KP"), `plans/FS131-planar-kernel-plan.md`, `tools/fs131_kp_*.py`, `data/fs131/kp/`, `data/fs131/reports/FS131-KP.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. You are planning the plane topology that the last seven leaves of wave 5 of the Lean backlog share. The milestone, FS-131, turns this project's
hand-derived results into kernel-checked ones, wave by wave: waves 1, 2 and 3 are landed on `main`, wave 4 is being finished on three branches, and wave 5
(termination and density: the terminal valid map, the ends of stuck chains, row 134's base step with unit arcs, and the density results built on it) is
being proved on `fs131-w5` by FS131-I5c. Seven of wave 5's leaves read the same boundary topology of plane sets that Mathlib does not have, so they were held
back for one job that builds it once; and the definition of a hole of a tile turned out too weak. Your branch, `fs131-w5p`, is cut from `fs131-w5` at
`0db34854`.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 cannot
land with these seven open. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The seven leaves, all `sorry` on your branch: `cvb_thom_reduced`, `cvb_pinch_connected`, `cvb_hole_disconnected` in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean`; `BaseCtx.retArcs_nested`, `BaseCtx.exists_endpoint`, `BaseCtx.exists_eleventh` in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean`; `exists_unenclosed_or_bad` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean`. They are
read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-w5-kernel-plan.md` §§ 3.2, 8.2 and in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-w5base-kernel-plan.md`. The rulings that made this job:

> 239. **Ruling: the planar core goes to the planar-infrastructure job** — `cvb_thom_reduced`, `retArcs_nested`, `exists_endpoint`, `exists_eleventh`,
> — source: plans/FS131-close-inventory.md

> 242. **Ruling: `IsHoleOf`'s repair goes to the planar-infrastructure job, as its first question; `cvb_hole_disconnected` joins that job's leaves.** Choice: defer
> — source: plans/FS131-close-inventory.md

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

(read items 239, 241–242, 247 and 274 in full). The definition as it stands:

> def IsHoleOf (T Hc : Set ℂ) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean

The defect, as FS131-I5b found it (its counterexample follows there):

> **A statement defect, sent to Keryx mid-job (2026-10-04): `cvb_hole_disconnected` is false as written** — `IsHoleOf` counts a bounded component of
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-I5-implementation.md Stage 8 — SAVED: `Thomassen.lemma1` and `exists_holed_valid_fragment` proved; a statement defect in `cvb_hole_disconnected`

and what I5b read of the pinch clause:

> **`cvb_pinch_connected`** looks true as written (a weaker `IsHoleOf` strengthens "no hole"): it derives from the uniqueness of the unbounded
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-I5-implementation.md Stage 8 — SAVED: `Thomassen.lemma1` and `exists_holed_valid_fragment` proved; a statement defect in `cvb_hole_disconnected`

The definitions audit's note on the repair:

> f. **For item 242's design question** (the planar job): `cvb_pinch_connected` stays true only if the repaired `IsHoleOf` holds at every CVB
> — source: plans/FS131-QA3-audit.md 2.4 Notes (none is a defect; each is a precision a later job may want)

The source the definition must match, CVB's B1–B2 (read the whole section):

> *Frame.* A valid map is locally finite, its tiles open, connected, of diameter at most 1 (a connected open set of diameter above 1 holds a pair at distance
> — source: plans/FS114-CVB-verification.md 1.9 B1–B2 — C114-THOM-TOP's two clauses (the third mind) [hand; one mind]

## Done means

1. **Your readback first**: check every quotation above against its source; read the inventory items named, I5b's Stage 8, and CVB § 1.9 in full; build the
   branch once as given (`0db34854`); restate in your record what you are planning and what you may change. Commit and push (`git push origin fs131-w5p`).
2. **`IsHoleOf` settled**: the faithful definition, read against CVB § 1.9 and against every consumer (`fill`, `IsOuterTile`, `filledGraph`, the three `cvb_*`
   leaves), bound both ways as QA3's note says; I5b's counterexample as an adversary that the repaired definition must not count as a hole; an inhabitant that
   exercises every clause (`LEAN.md`'s inhabitant rule); the choice, the alternative and the statements it changes in your record, **and a message to me before
   you change the definition**.
3. **The route and the shared lemmas**: which plane topology the seven leaves read (a plane continuum's outer frontier, a finite plane graph's outer face, or
   another), what Mathlib has (confirmed with `#check`), and the shared lemmas stated as named declarations in your new module or modules, each read back.
4. **The skeleton**: the seven leaves reduced to the shared lemmas and named children, `sorry` at every leaf, building through the worktree's
   `./scripts/build.sh` with only `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated.
5. **Your record**, `plans/FS131-planar-kernel-plan.md`, in the opening plan's § 6 form: a plan per leaf (route, Mathlib lemmas confirmed with `#check`, named
   children, what is hard, a price), the obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), inhabitants for any structure the leaves take
   as a hypothesis, and a handoff for the planar implementer in the form of wave 4's plan § 14 — including how `fs131-w5p` merges back into `fs131-w5`, whose
   implementer does not edit the declarations in your touches.
6. The report, in standing rule 11's form. Stopping at a saved stage with what is left named is a good report.

## What is yours to decide

The route through plane topology, the layout and names of the new modules, how the seven leaves are cut into lemmas, and the definition of a hole (with the
message before you change it). Formalize any outside fact under about an hour of agent work; else an `axiom` with `LEAN.md` § Assumptions' four items —
never one of our own hand results. If a leaf is false as written, or the faithful definition breaks a statement that rests on it, that is a finding: message
me at once with the declaration and the smallest counterexample. You start no agents of your own (standing rule 1: delegation is one level deep, because the
coordinator can only review work it knows exists).

## The machine, the branch, and the landing

- **The worktree is ready**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p`, branch `fs131-w5p` at `0db34854`, `.lake/packages` a symlink to the main tree's and `.lake/build` its own copy (from an
  older wave-5 tree, so the first build rebuilds what differs). Never replace that copy with a symlink: two trees compiling into one build race on the same
  compiled files.
- **Builds** only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
  ./scripts/build.sh`; never `lake build`. Up to two such builds from different worktrees may run at once when the slot admits them; four agents are building,
  so on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only.
- **Nothing with a `sorry` reaches `main`**: your branch merges into `fs131-w5` when I say so, and lands with wave 5 after wave 4.


## Amendment, 2026-10-04 — `IsHoleOf` adopted (inventory items 276–277)

Your choice is logged as item 276 and ruled in item 277, whose first line is:

> 277. **Ruling on item 276: adopt KP's `IsHoleOf`; KP may rewrite `exists_holed_valid_fragment`'s proof.** Choice: the separated-part definition as sent; KP's
> — source: plans/FS131-close-inventory.md

Your touches gain the proof of `exists_holed_valid_fragment` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean`
(statement unchanged). You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows
exists).
