# Brief FS131-K4 — wave 4 of the Lean backlog: plan its foundation and skeleton (valid maps: contact types, Woodall's merge, shadows, the unit-arc calculus)

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K4
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan wave 4's kernel module — its foundation sorry-free, its 29 rows as a skeleton with `sorry` at every leaf, each read back against its row, a plan per leaf, the implementer's handoff
  launch: now, beside FS131-I2 and FS131-I3 (waves 2 and 3's implementers, each in its own worktree)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization or shorter route, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K4.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w4-kernel-plan.md`
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4` (branch `fs131-w4`): new modules under `Proofs/HadwigerNelson/` (the opening plan names `Plane/ValidMap/Contact`, `Plane/ValidMap/UnitArc`, `Plane/ValidMap/BaseSteps`, `Plane/StuckChain`, `Plane/SVMap`; the layout is yours), supporting lemmas in the foundation modules under `Proofs/HadwigerNelson/Plane/` (wave 3's included, statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-w4-kernel-plan.md`, `tools/fs131_k4_*.py`, `data/fs131/k4/`, `data/fs131/reports/FS131-K4.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. You are planning the fourth wave of the milestone that turns this project's hand-derived results into kernel-checked ones. Wave 1 is landed
(14 rows held in the kernel); waves 2 and 3 are fully planned and their implementers are proving them now. Wave 4 is the calculus of **valid maps**
— the contact types of a boundary arc (in, out, both, inert), horns, Woodall's merge, unit shadows and shaving, stuck chains, the unit-arc
calculus, the base's steps of row 134's argument, and Sokolov–Voronov map-type colourings almost everywhere. It stands on wave 3's vocabulary of the
local geometry around a point, and waves 5–9 stand on it.

Read first: the opening plan `plans/FS131-kernel-plan.md` §§ 4–7 (its § 6 is the model your record should match; its § 7.3 is this job's checklist);
then wave 3's plan on its branch, `.claude/worktrees/fs131-w3/plans/FS131-w3-kernel-plan.md` §§ 2, 5 and 6 — the vocabulary you inherit, its read-back
conventions, and its three engines; your worktree holds wave 3's skeleton as committed (`05cb0a3e`), so its modules are in your tree.

A pattern worth knowing before you start: the two planners of each of waves 2 and 3 reached their context line before finishing, and each
handed back at a saved stage with a precise list for a successor. Plan for that: commit the foundation, then the skeleton module by module, and if
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

Read all six items of that section. Item 2 names this wave's likeliest statement defects: "sector" and "degree" at a cusp.

## Done means

1. **Wave 4's foundation** (the opening plan § 7.1's row for wave 4: sectors and degree at a point, cones as limit directions, contact types in, out,
   both and inert, horns, `𝓜_K`, "terminal modification" as a relation on `ArcMap 6`, Sokolov–Voronov map-type colourings with Conditions 2–6), **less what
   ruling 27 moved into wave 3** (finitely many tiles meet a small disc about a point; the germ dichotomy; each tile's cone at a point is one closed
   interval in a simple map — wave 3's `Plane/LocalStructure`, whose sector-structure engine `localSectors` may already give you sectors: reuse it, do not
   restate it). Sorry-free, with a spec example per definition, a named inhabitant per structure a theorem takes as a hypothesis, and one fresh
   `debruijn-domain-modeling` pass. Where a derivation never fixed a definition the rows' words need, write your choice, the alternatives, and which rows
   each would change — and message me if the choice changes what a row says.
2. **The skeleton**: every row of wave 4 in Lean with `sorry` at every leaf, building through the worktree's `./scripts/build.sh` with only the `sorry`
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

1. **The readback**: check the two quotations above against their sources; restate your rows, the merged rows, the rulings and the caution in your record.
   Confirm the worktree builds as given (one `./scripts/build.sh` run under the slot). Commit on the branch and push it (`git push -u origin fs131-w4`).
2. **The foundation**, sorry-free, validated, building, with the definitions' choices recorded. Commit.
3. **The skeleton and the read-backs**, module by module, committing after each. Message me the commit when all 29 are stated.
4. **The leaf plans and the obligation-modeling pass.** Commit.
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
