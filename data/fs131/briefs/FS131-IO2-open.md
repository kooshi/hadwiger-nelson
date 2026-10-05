# Brief FS131-IO2 — OPEN finished: the five leaves of `exists_open`, on `fs131-wop`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IO2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: OPEN's second implementer — prove the five open leaves of `exists_open` (`open_hlc`, `open_valid`, `open_degree_horns`, `open_rim`, `open_allowedCone`) from FS131-IO1's Stage 3, each over its MERGE template, and the positive `HasHornCount` spec example, saving after each
  launch: now, beside FS131-KP2 (the collar construction's planner, on `fs131-w5`) and FS131-M6 (`fs131-w5` into `fs131-w5c`, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IO2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IO-implementation.md` (on branch `fs131-wop`; you continue it from Stage 4, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop` (branch `fs131-wop`): `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` (the five leaves, their children, the spec example; `exists_open`'s and `HasHornCount`'s statements unchanged); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-IO1", which you extend), `plans/FS131-IO-implementation.md`, `tools/fs131_io_*.py`, `data/fs131/io/`, `data/fs131/reports/FS131-IO2.md`; **not** any existing declaration of `main` (new declarations only), `MergeMove`, `Moves`, `Contact`, `Surgery`, nor `main` itself
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing OPEN, the fifth move the Lean backlog's terminal procedure needs (FS131-E6 found the case the filed procedure missed and derived the
move). FS131-IO1 settled its statement in `exists_merge`'s shape, proved its configuration on both sides and four of its eight clauses, and assembled
`exists_open` over five open leaves, each with a MERGE lemma as its template. They are yours.

## Why this job

A result counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and the procedure's
vertex step needs OPEN at every lone horn SHAVE cannot take. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

`exists_open`, in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` at `7b24117b` (read it whole there, with `HasHornCount`), its first line:

> theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean

The five leaves and their routes, in IO1's words — read its Stages 1–3 in full:

> 1. **`open_hlc`** (template `merge_hlc`, ~130 lines): add the cases a point of `W` (open, constant `c`); a point of the gap germ
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/plans/FS131-IO-implementation.md 3.3 What is left, and the plan (for whoever continues; no statement of `exists_open` changes)

> 2. **`open_valid`** (template `merge_valid`): `Valid.of_agreesOff` on `B̄(v, ρ)`; a recoloured point is a gap point or a wedge point,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/plans/FS131-IO-implementation.md 3.3 What is left, and the plan (for whoever continues; no statement of `exists_open` changes)

> 3. **`open_degree_horns`** (template `merge_hasSectors`, the partition at `r < ρ/2` by `encard_sectorsOf_of_partition`; here
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/plans/FS131-IO-implementation.md 3.3 What is left, and the plan (for whoever continues; no statement of `exists_open` changes)

> 4. **`open_rim`** (template `merge_not_hasRepeatedColour_rim`, `merge_ncard_coloursAt_rim`): near a rim point the new map equals MERGE's
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/plans/FS131-IO-implementation.md 3.3 What is left, and the plan (for whoever continues; no statement of `exists_open` changes)

> 5. **`open_allowedCone`** (template `merge_allowedCone` and its 19 children): the chain becomes `chain ∪ W ∪` the horn, open and clear for
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/plans/FS131-IO-implementation.md 3.3 What is left, and the plan (for whoever continues; no statement of `exists_open` changes)

What IO1 handed back, the rulings on it, and the derivation behind OPEN:

> 391. **FS131-IO1 handed back** (Stage 3 SAVED, harness ≈ 408k by the task notice; record `fs131-wop`'s `plans/FS131-IO-implementation.md`, Stages 1–3; report
> — source: plans/FS131-close-inventory.md

> 392. **Rulings on IO1's held items, and its slot.** (a) **The lone form `h1` is kept**: after MERGE is ruled out at `v`, a horn whose colour's cone is
> — source: plans/FS131-close-inventory.md

> 384. **FS131-E6 done: F6 is real, and repaired with no backlog statement changed** (harness ≈ 540k by the task notice; record `plans/FS131-E6-derivation.md`;
> — source: plans/FS131-close-inventory.md

> 385. **Rulings on E6's held items, and its slot.** (a) **`exists_arcStep`'s horn clause accepted** ("`∀ x j, F.HasHornCount x j → ∃ j′ ≤ j, F′.HasHornCount x
> — source: plans/FS131-close-inventory.md

MERGE, whose lemmas are your templates:

> 367. **FS131-IMM4 done: MERGE is proved** (harness ≈ 472k by the task notice; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`, Stages 10–12; report
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read IO1's record in full and E6's record § 4.2; build `fs131-wop` once as given
   (`7b24117b`) before editing anything. Commit and push.
2. **The five leaves**, in § 3.3's order (`open_hlc`, `open_valid`, `open_degree_horns`, `open_rim`, `open_allowedCone`), then the positive `HasHornCount` spec
   example (`cuspFrag` has `HasHornCount 0 2`); children in `OpenMove`; save after each; re-price after the first two; no statement changed, no new `axiom`, no
   `native_decide`. Do not edit a file while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans — if
   OPEN lands, `exists_open` and every `OpenMove` theorem within the standard three. You do not merge another branch into this one, run the gate, or touch
   `main` — OPEN's landing is a later job, on my word. Leave no background process running.
4. **Your record**, stages headed "Stage n — SAVED (FS131-IO2)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
   with leaves left, named, is a good report.

## What is yours to decide

The proofs, their children and order within the dependencies. IO1's routes are notes, not rules. If a leaf cannot be proved as written, stop it, message me
with the smallest counterexample or the missing hypothesis — a defect that reaches E6-OPEN goes back to Ephodos — and go on with the others. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one
level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence; IO1's
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/data/fs131/io/iter.sh` is yours. The worktree's `.lake/build` is its own copy; never replace it with a
symlink. Nothing with a `sorry` reaches `main`.
