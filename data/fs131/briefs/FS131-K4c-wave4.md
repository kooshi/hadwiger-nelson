# Brief FS131-K4c — wave 4 of the Lean backlog, finished: the nine unit-arc items, the obligation-modeling pass, the implementer's handoff

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K4c
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: the third planner on wave 4 — state the nine unit-arc items K4b left, read each back, plan every leaf of the wave, run the domain- and obligation-modeling passes over the whole wave, and write the implementer's handoff
  launch: now, beside FS131-I2d and FS131-I3c (waves 2 and 3's implementers, each in its own worktree)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization or shorter route, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K4c.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w4-kernel-plan.md` (on branch `fs131-w4`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): new modules under `Proofs/HadwigerNelson/` (the opening plan names `Plane/ValidMap/Contact`, `Plane/ValidMap/UnitArc`, `Plane/ValidMap/BaseSteps`, `Plane/StuckChain`, `Plane/SVMap`; the layout is yours), supporting lemmas in the foundation modules under `Proofs/HadwigerNelson/Plane/` (wave 3's included, statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-w4-kernel-plan.md`, `tools/fs131_k4_*.py`, `data/fs131/k4/`, `data/fs131/reports/FS131-K4c.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. You are the third planner on wave 4. FS131-K4 wrote its foundation and nine rows; FS131-K4b (both de Bruijn on Opus, like you) stated eight more — FS106-L and FS106-TS-T in `Plane/SVMap`, and FS112-BOWTIE with four base steps in `Plane/ValidMap/BaseSteps` — moved FS112-C-DOUBLE to wave 5 (item 69), and handed back with nine unit-arc items left and their open choices written down (the record's Stage 9). Neither ran the modeling passes over its additions; you owe both, over the whole wave. The rest of this letter is the original brief, kept for the whole picture: you are planning the fourth wave of the milestone that turns this project's hand-derived results into kernel-checked ones. Wave 1 is landed
(14 rows held in the kernel); waves 2 and 3 are fully planned and their implementers are proving them now. Wave 4 is the calculus of **valid maps**
— the contact types of a boundary arc (in, out, both, inert), horns, Woodall's merge, unit shadows and shaving, stuck chains, the unit-arc
calculus, the base's steps of row 134's argument, and Sokolov–Voronov map-type colourings almost everywhere. It stands on wave 3's vocabulary of the
local geometry around a point, and waves 5–9 stand on it.

Read first: the opening plan `plans/FS131-kernel-plan.md` §§ 4–7 (its § 6 is the model your record should match; its § 7.3 is this job's checklist);
then wave 3's plan on its branch, `.claude/worktrees/fs131-w3/plans/FS131-w3-kernel-plan.md` §§ 2, 5 and 6 — the vocabulary you inherit, its read-back
conventions, and its three engines; your worktree holds wave 3's skeleton as committed (`05cb0a3e`), so its modules are in your tree.

A pattern worth knowing: every wave's first planner so far reached its context line before finishing. Plan for that: commit the foundation, then the skeleton module by module, and if
your context runs short, hand back with what is left named — that is a good report, not a failure.

## Why this job

Since Workflow 3.1 a milestone closes only when its Lean module passes the gate; this milestone formalizes the hand results the milestones before
it left on paper. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your rows are the 29 rows of `data/fs131/k1/dispositions.csv` with wave 4 and disposition *formalize*: FS106-L, FS106-TS-T, FS106-WO, FS106-TW,
FS106-AE-MAP6, FS110-N3-CONF, FS110-N3-DEG, FS110-N4-SHADOW, FS110-N4-SHAVE, FS110-N4-STUCK, FS110-N4-FIN, FS110-W-MERGE, FS112-A4SIX, FS112-BOWTIE,
FS112-C-DOUBLE, FS112-FLANK, FS112-ISO, FS112-LOCK, FS112-N2-BENDS, FS112-N2-FLANK-Q, FS112-N2-RAY, FS112-N3-ANTI, FS112-N3-FAIL, FS112-N3-NOBOTH,
FS112-N3-END, FS112-N3-PAIRS, FS112-NB4P, FS112-U1, FS114-L60-LE. Two more rows merge into them and must be carried: FS112-BEND into FS112-N2-BENDS,
FS114-L60-WALK into FS114-L60-LE (ruling R8 of the opening plan: a statement about proofs, checked when its consumers are formalized over the
non-strict bound). Three carry a ruling of the opening plan (R9: the verdict clause dropped, the mathematics formalized): FS106-WO, FS106-TW,
FS112-N2-RAY. FS112-C-DOUBLE is governed by caution C116 — formalize it with the errata filed under it, which `plans/LEAN-BACKLOG.md` quotes at its row.
Each row's statement is quoted, with its errata and merge notes, in `plans/LEAN-BACKLOG.md` at the row's heading; the definitions are in its derivation
file (`plans/FS106-derivation.md`, `plans/FS110-derivation.md`, `plans/FS112-derivation.md`, `plans/FS114-derivation.md`) at the address the backlog
gives — and for the FS-112 rows, which are in the older grammar, read `plans/FS112-derivation.md`'s errata section too (`plans/LEAN-BACKLOG.md` quotes
its items 7 and 8 at the top). The opening plan's rule for how every row is stated:

> 3. **States every row at the class its argument reads** (G92), reports each widening to Keryx as a generalization, and reads each statement back in
> — source: plans/FS131-kernel-plan.md § 7.3 What each wave's planning job must hold

Read all six items of that section. (K4 found that the defect item 2 expected at a cusp does not arise: a cusp horn is one sector.)

**What is yours now** is K4b's Stage 9:

> K4b reached its context line here (brief: hand back before about 480k). **Stated in wave 4 so far: 17 of the 28 rows now in the wave** (C-DOUBLE moved
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § Stage 9 — SAVED (K4b): what is left, and the handoff to the next planner

The table below it gives each of the nine items (FS112-U1's shadow clause; FS114-L60-LE's L60-EQ and L60-REAL; FS112-N2-BENDS with FS112-BEND, and its ENV lemma; FS112-ISO; FS112-FLANK; FS112-N2-FLANK-Q; FS112-A4SIX; FS112-NB4P) with what is settled and the open choice. Woodall's three rows are FS131-W's (item 54), Lebesgue's covering theorem FS131-LEB's (item 66; keep `lebesgue_covering_square` a `sorry`ed theorem), C-DOUBLE wave 5's (item 69). Rulings in force: items 53, 67, 68; the narrowings K4b recorded (item 74) stand unless your passes show a better statement.

## Done means

1. **The foundation stands** (K4's and K4b's additions, sorry-free); add to it only what your items need, each addition with a spec example, and run
   `debruijn-domain-modeling` fresh over the whole of it (K4b's choices are in its record §§ 7.1–7.4 and 8.1). For reference, the brief K4 had:
   **Wave 4's foundation** (the opening plan § 7.1's row for wave 4: sectors and degree at a point, cones as limit directions, contact types in, out,
   both and inert, horns, `𝓜_K`, "terminal modification" as a relation on `ArcMap 6`, Sokolov–Voronov map-type colourings with Conditions 2–6), **less what
   ruling 27 moved into wave 3** (finitely many tiles meet a small disc about a point; the germ dichotomy; each tile's cone at a point is one closed
   interval in a simple map — wave 3's `Plane/LocalStructure`, whose sector-structure engine `localSectors` may already give you sectors: reuse it, do not
   restate it). Sorry-free, with a spec example per definition, a named inhabitant per structure a theorem takes as a hypothesis, and one fresh
   `debruijn-domain-modeling` pass. Where a derivation never fixed a definition the rows' words need, write your choice, the alternatives, and which rows
   each would change — and message me if the choice changes what a row says.
2. **The skeleton**: the nine items in Lean with `sorry` at every leaf, building through the worktree's `./scripts/build.sh` with only the `sorry`
   warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated on the branch.
3. **Your record**, `plans/FS131-w4-kernel-plan.md` on the branch, in the opening plan's § 6 form: the read-back of each formal statement against its row,
   a plan per leaf (route, Mathlib lemmas confirmed with `#check`, named children, what is hard), the obligation-modeling pass
   (`debruijn-obligation-modeling`, invoked fresh), and a handoff section for the implementer in the form of wave 3's § 7. Stages headed
   "Stage n — SAVED"; "Theorems this phase proved" (usually none).
4. The report, in standing rule 11's form.

## What is yours to decide

The representation, the module layout, the order of the rows, and any outside theorem (the opening plan expects none: Woodall's and Townsend's
mathematics enter as ours, ruling R9; formalize anything under about an hour of agent work, else an `axiom` with the four items of `LEAN.md`
§ Assumptions — never one of our own hand results). If a row cannot be stated without a hypothesis its derivation hid, or a term is never fixed, that is
a finding: message me at once. A widening the kernel allows is a generalization: message me as well. If a wave-4 row turns out to need a wave-2 or
wave-5 row, say so and stop that leaf: the table says wave 4 rests only on waves 1 and 3.

## Stages

1. **The readback**: check the three quotations above against their sources; restate the nine items, the rulings and the narrowings in your record. Confirm
   the worktree builds as K4b left it (`daac5779`). Commit on the branch and push.
2. **The domain-modeling pass** over the wave's foundation and vocabulary. Commit.
3. **The nine items and their read-backs**, committing after each module change. Message me the commit when every wave-4 row except Woodall's three and C-DOUBLE is stated.
4. **The leaf plans for every leaf of the wave** (K4's and K4b's sketches confirmed with `#check`) **and the obligation-modeling pass.** Commit.
5. **The handoff section**, then report.

## The machine, the branch, and the landing

- **The worktree is ready**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4`, branch `fs131-w4` at `05cb0a3e` (wave 3's skeleton, which already
  merged `main` with wave 1 landed), `.lake/packages` a symlink to the main tree's and `.lake/build` its own copy, made by the project's recipe. Never
  replace that copy with a symlink: two trees compiling into one build race on the same compiled files.
- **Builds** only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G
  BATCH=4 ./scripts/build.sh`; never `lake build`. Up to two such builds from different worktrees may run at once when the slot admits them — with two
  implementers building beside you, expect to wait on exit 75 (wait ten minutes and retry). `lake env lean` (with `-DautoImplicit=false
  -DrelaxedAutoImplicit=false`) is for iteration only, never evidence that a module is green.
- **Nothing with a `sorry` reaches `main`** (the opening plan § 7.5): your work stays on `fs131-w4` and lands with the wave, after its implementer's gate.
  Wave 3's statements may still gain children as its implementer works, but never change: build on them as committed.

