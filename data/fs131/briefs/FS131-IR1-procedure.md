# Brief FS131-IR1 — the procedure's last steps on `fs131-w5c`: OPEN merged in, the vertex and arc steps restated, `stuckRun_ne_univ`, and `exists_terminalSeq`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IR1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the termination procedure's implementer — merge OPEN (`origin/fs131-wop`) into `fs131-w5c`, restate the two step lemmas as ruled, then prove what is left under `exists_terminalMap` and in `Terminal` in an order you choose, saving after each leaf
  launch: now, beside FS131-CC2 (the collar bend's lane C, on `fs131-w5k`) and FS131-OL1 (OPEN's landing on `main`, on `fs131-wop`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a restated clause that looks false, a move's private detail you need exported from a landed module, a merge conflict that is more than keeping both sides, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IR1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-limit-kernel-plan.md` (the limit and procedure's record on branch `fs131-w5c`; you continue it from Stage 12, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`): the merge's files (`Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`: keep both sides); `Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean` (`exists_vertexStep` and `exists_arcStep` restated as § The statements says, `exists_terminalSeq`, and children beside them); a new module downstream of `Moves`, `MergeMove` and `OpenMove` for the moves' exported lemmas, if you want one; `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean` (`stuckRun_ne_univ` and children beside it); `Proofs/HadwigerNelson/Plane/ValidMap/FlankUA.lean` and `Proofs/HadwigerNelson/Plane/ValidMap/HornShadow.lean` for new supporting lemmas only; `scripts/Axioms.lean` (a block of your own, headed "FS131-IR1", above the `=== PURCHASED ===` banner), `plans/FS131-limit-kernel-plan.md`, `tools/fs131_ir_*.py`, `data/fs131/ir/`, `data/fs131/reports/FS131-IR1.md`; **not** `OpenMove.lean` (FS131-OL1 is landing it), nor a statement or definition in `Moves`, `MergeMove`, `Contact`, `UnitArc` or any module on `main` (ruling 372 (a): new declarations downstream only), nor `BaseDense`, `BendCollar`, `HexRing`, `exists_terminalMap`'s statement, `main`, or the gate scripts' recorded counts
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving the last steps of the termination procedure in the Lean backlog. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones; waves 1–4, Woodall's chain and MERGE are on `main`. On this branch the limit construction is done: `exists_terminalMap` (every valid
map of the plane has a modification that is a terminal valid map) is proved over one open child, `exists_terminalSeq`, which runs the moves at every point
until none is left. Under it are two step lemmas still `sorry`, and beside it in `Terminal` one theorem about terminal six-maps. Since FS131-KL1 planned
this, a deriver (FS131-E6) found that one case of the vertex step was false as stated and derived a fifth move, OPEN, that repairs it; OPEN is now proved, on
its own branch. This job joins the pieces. It is more than one session's work: take the leaves in the order that suits you, and hand back at a saved stage.
The work stopped for a day at a halt; nothing was lost.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`); `exists_red` and
`exists_terminal`, two of wave 5's backlog rows, are read off `exists_terminalMap`. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The rulings that launch you, and what the last jobs handed back:

> 411. **Rulings: the three slots, filled from the queue of the handoff.** (a) **FS131-CC2**, lane C's continuation on `fs131-w5k` (item 406 (d)). (b)
> — source: plans/FS131-close-inventory.md

> 403. **Ruling on CG1's slot: `stuckRun_ne_univ` and the procedure's last steps on `fs131-w5c`** (queue (2)), brief to be written from M6's and IL2's — **held
> — source: plans/FS131-close-inventory.md

> 398. **FS131-M6 handed back: `fs131-w5` merged into `fs131-w5c`** (Stage 55 SAVED, harness ≈ 446k by the task notice; record `fs131-w5c`'s
> — source: plans/FS131-close-inventory.md

> 388. **FS131-IL2 done: the limit's lane A is complete** (harness ≈ 525k by the task notice; record `fs131-w5c`'s `plans/FS131-limit-kernel-plan.md`, Stages 9–11;
> — source: plans/FS131-close-inventory.md

> 408. **FS131-IO3 done — OPEN held** (Stage 15 SAVED at Kooshi's halt, all three of its items finished; harness ≈ 384k by the task notice; record `fs131-wop`'s
> — source: plans/FS131-close-inventory.md

The finding that changed the vertex step, and its rulings:

> 382. **FS131-E6, by message (mid-job): F6 is real; `exists_vertexStep`'s degree clause is false at an exact model; the repair is a fifth move.** (1) **Realized**
> — source: plans/FS131-close-inventory.md

> 383. **Rulings on items 381–382.** (a) **E6's finding accepted** (realized, controls firing): no backlog statement changes; N4-TERM as filed has a gap at a
> — source: plans/FS131-close-inventory.md

> 384. **FS131-E6 done: F6 is real, and repaired with no backlog statement changed** (harness ≈ 540k by the task notice; record `plans/FS131-E6-derivation.md`;
> — source: plans/FS131-close-inventory.md

> 385. **Rulings on E6's held items, and its slot.** (a) **`exists_arcStep`'s horn clause accepted** ("`∀ x j, F.HasHornCount x j → ∃ j′ ≤ j, F′.HasHornCount x
> — source: plans/FS131-close-inventory.md

> 372. **Rulings on item 371.** (a) **`ArcMap.clean` accepted** as the plan's repair, with the moves' new exported lemmas as **new declarations only** (no landed
> — source: plans/FS131-close-inventory.md

## The statements

No backlog statement changes in this job. Two `sorry` children of `exists_terminalSeq` are **restated** — statement changes to internal children, ruled in
items 383 (b) and 385 (a). As they stand now, and the leaves beside them (`fs131-w5c` at `87e95385`; read each whole there), their first lines:

> theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : v ∈ F.dom)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> theorem exists_arcStep (hF : F.Valid) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> theorem exists_terminalSeq (hF : F.Valid) (hP : F.IsPlaneMap) (hc : F.IsClean) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> theorem stuckRun_ne_univ {F : ArcMap 6} (hM : F.IsTerminalMap) {v : ℂ} {α : ℝ} (hv : F.StuckAlong v α)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean

**`exists_vertexStep`, restated** — E6's draft, which you settle against the kernel (read the whole block in the source; these are its changed lines: a
horn-count hypothesis, and a conclusion that lowers degree plus horns in place of the degree alone):

> theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : v ∈ F.dom)
> — source: plans/FS131-E6-derivation.md 4.5 Lean-level drafts (for Keryx to file; the statements are de Bruijn's to settle)

>     (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
> — source: plans/FS131-E6-derivation.md 4.5 Lean-level drafts (for Keryx to file; the statements are de Bruijn's to settle)

>       (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
> — source: plans/FS131-E6-derivation.md 4.5 Lean-level drafts (for Keryx to file; the statements are de Bruijn's to settle)

**`exists_arcStep`'s owed clause** (no bend raises a site's horn count), and what `acted_finitely` then counts — the paragraph that ends with this line:

> "`(∀ x m, F.HasDegree x m → F'.HasDegree x m)`": `(∀ x j, F.HasHornCount x j → ∃ j' ≤ j, F'.HasHornCount x j')`.
> — source: plans/FS131-E6-derivation.md 4.5 Lean-level drafts (for Keryx to file; the statements are de Bruijn's to settle)

The route of the repaired vertex step (read § 4.3 whole: MERGE; else MERGE-RAY; else SHAVE where the horn's colour has an allowed cone with empty interior;
else OPEN), which opens:

> At a site `v` of a clean valid map with an available move, for every `δ > 0`, a clean valid modification that is a local step on a disc of radius
> — source: plans/FS131-E6-derivation.md 4.3 E6-ROUTE — the vertex step repaired (priority form, F7)

OPEN, which you cite and do not edit, as it stands on `fs131-wop` at `a20bb6f5`:

> theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean

> def HasHornCount (v : ℂ) (j : ℕ) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean

KL1's plan for each leaf (read its rows for `exists_vertexStep`, `exists_arcStep`, `exists_terminalSeq` and `stuckRun_ne_univ` whole), and the moves'
exported lemmas the steps need:

> | `stuckRun_ne_univ` | derives **given one new child** | along `univ` every vertex is stuck along `±α`; bounds `≠ ±1` (`cv_l0` at the neighbour: a bound `1` puts an arc of `ω(N)` in `Γ` centred at a chain vertex); child **`shadow_recursion`**: for consecutive run vertices `w`, `w + n`, `λ_w ≤ curvDown λ_{w+n}` and `curvUp υ_w ≤ υ_{w+n}` (no SHAVE at a stuck vertex: `shaveAvailable_of_not_doublyShadowed`'s contrapositive with unit arcs, then SH1 `shadow_hornSet_subset_S`/`_N` places the flank's shadow) — then `n4_fin`. Wave 4's `stuck_chain` did the propagation under Condition 5 without the recursion. **M–H** |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md 3.1 The pass, statement by statement (each: what the proof derives from; children; a missing hypothesis)

> Each is proved by re-opening a construction, after this branch merges `main`, in `Plane/ValidMap/Procedure` (its imports then gain
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md 3.3 The moves' lemmas, for the module downstream of `Moves` and `MergeMove` (ruling 372 (a); new declarations only)

Two things in that plan are superseded: `shave_step_gen` is not needed (every lone horn with a bound outside `[−1, 1]` is opened, not shaved — E6 § 4.3's
last line), and E6-CONE, `horn_bounds_of_interior_empty` in E6's § 4.5, is a new lemma yours to prove (`horn_bounds_of_noMerge`'s proof in `FlankUA`, with
its cone hypothesis made direct).

## Done means

1. **Your readback first**: check every quotation above against its source; read KL1's plan §§ 2–4 and IL1's and IL2's stages in the record, E6's
   derivation §§ 4.2–4.5, and OPEN's record's last stage (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/plans/FS131-IO-implementation.md`); build `fs131-w5c` once as
   given (`87e95385`; expect it up to date) before editing anything; open Stage 12 with what you may and may not change. Commit and push.
2. **The merge** (item 411 (d)): `git merge a20bb6f5` (the tip of `origin/fs131-wop`: `main` plus `OpenMove`) into `fs131-w5c`. Keep both sides in `Proofs.lean`,
   `ARCHITECTURE.md` and `scripts/Axioms.lean`; a conflict beyond those is a message to me. Check by script that no statement of either side changed and that
   no declaration is now defined twice (M6's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/tools/fs131_m6_dupes.py`, with its plant). Build. An axioms print against the merged build:
   `exists_open` on the standard three, a control on `sorryAx`. Commit the merge as its own stage and push.
3. **The restatement**: `exists_vertexStep` in E6's form and `exists_arcStep` with the horn clause, both still `sorry`, with a diff of each statement in your
   record and the docstrings brought up to date (the vertex step's now names four moves). Build with no warning but `sorry`. Commit.
4. **The leaves**, in an order you choose, saving after each and re-pricing in the record after the first two. A suggestion, not a rule:
   `horn_bounds_of_interior_empty`; `exists_vertexStep` by E6 § 4.3 (the moves' lemmas of KL1 § 3.3 as it needs them — `LocalStep`, the rim clauses, the
   degree count after `exists_clean`); `stuckRun_ne_univ` with its child `shadow_recursion`; `exists_terminalSeq` with `acted_finitely` (counting degree plus
   horns at a site), `supports_locallyFinite` and `fair`; `exists_arcStep` last. No other statement changed, no new `axiom`, no `native_decide`. Do not edit a
   file while a build of it runs.
5. **`exists_arcStep`'s bends** (item 411 (e)): `bend_toward` and `bend_away_whole` are on this branch. If the out-only case with a partial witness needs
   N2-TAN's tangent bend, which is not proved anywhere yet, state it as a `sorry` child (`bend_away_part`) and prove the step over it — do not build the bend
   here; say exactly what statement the step needs from it. The step's last clause is KL1's question (5), one mind's sketch: if its proof fails, message me
   with where.
6. **The handover**: your record's last stage says what is proved and what is left, each open leaf with the route it is ready for, with the build log and an
   axioms print against that build's oleans — `exists_terminalMap` by name (on `sorryAx` until its children close: say through which), and a control. You do
   not merge into `fs131-w5`, take `main` into this branch beyond the merge above, run the full gate, or touch `main`. Leave no background process running.
7. **Your record**, stages headed "Stage n — SAVED (FS131-IR1)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
   with leaves left, named, is a good report.

## What is yours to decide

The proofs, their children, the order, where the moves' exported lemmas live (in `Procedure` or a new module downstream of the three move modules), and the
final form of the two restated statements where the kernel shows E6's draft needs a change — a draft is a draft: change it, record the diff and the reason,
and tell me in your report; a change that would touch `exists_terminalSeq`'s or `exists_terminalMap`'s statement is a message first. If a move's construction
hides a detail you need (KL1 § 3.3 marks two), message me with the declaration; do not edit the landed module. If a leaf cannot be proved as written, stop
it, message me with the smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a dispatch to
the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.
