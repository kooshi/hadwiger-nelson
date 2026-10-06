# Brief FS131-IO1 — OPEN, the fifth move: the one-sector wedge-opening (`exists_open`, `HasHornCount`) built over `MergeMove`, on `fs131-wop`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IO1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: OPEN's implementer — settle `HasHornCount` and `exists_open`'s statements from FS131-E6's drafts (read back against E6-OPEN), lay them out in a new module downstream of `MergeMove`, and prove them by E6's route (a), reusing MERGE's lemmas, saving after each part
  launch: now, beside FS131-M5 (`main` into `fs131-w5`, on `fs131-w5`) and FS131-IL2 (the limit's lane A, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a clause of E6-OPEN that cannot be proved as derived, a statement that looks false, a lemma it needs that is private to another module, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IO1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IO-implementation.md` (new, on branch `fs131-wop`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop` (branch `fs131-wop`): a new module `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` (importing `MergeMove` and what it needs); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-IO1", above the `=== PURCHASED ===` banner), `plans/FS131-IO-implementation.md`, `tools/fs131_io_*.py`, `data/fs131/io/`, `data/fs131/reports/FS131-IO1.md`; **not** any existing declaration of `main` (new declarations only), `MergeMove`, `Moves`, `Contact`, `Surgery`, nor `main` itself
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are building a new move for the Lean backlog's terminal procedure. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–4, Woodall's chain and MERGE are on `main`. Wave 5's last two leaves rest on a procedure of local moves whose limit is a terminal
map. FS131-E6 has just shown, with an exact model, that the filed procedure misses a case — a lone horn where SHAVE's only admissible split is a unit circle —
and derived the repair: OPEN, recolouring a thin wedge beside the horn with the horn's colour, on the interior side of its allowed cone (FS110 § 2.8's sketch,
now with unit arcs allowed). Your branch is cut from `main` (MERGE's machinery is there); OPEN lands on its own or with wave 5.

## Why this job

A result counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and the
procedure's vertex step needs OPEN at every horn SHAVE cannot take. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

E6's Lean drafts — the statements are yours to settle, read back against E6-OPEN (record § 4.2) — their first lines (read each whole in its record § 4.5):

> def HasHornCount (v : ℂ) (j : ℕ) : Prop :=
> — source: plans/FS131-E6-derivation.md 4.5 Lean-level drafts (for Keryx to file; the statements are de Bruijn's to settle)

> theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
> — source: plans/FS131-E6-derivation.md 4.5 Lean-level drafts (for Keryx to file; the statements are de Bruijn's to settle)

The shape it follows, MERGE's statement on `main` (read it whole there):

> theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean

What E6 found and derived, and the rulings that launch you:

> 382. **FS131-E6, by message (mid-job): F6 is real; `exists_vertexStep`'s degree clause is false at an exact model; the repair is a fifth move.** (1) **Realized**
> — source: plans/FS131-close-inventory.md

> 384. **FS131-E6 done: F6 is real, and repaired with no backlog statement changed** (harness ≈ 540k by the task notice; record `plans/FS131-E6-derivation.md`;
> — source: plans/FS131-close-inventory.md

> 385. **Rulings on E6's held items, and its slot.** (a) **`exists_arcStep`'s horn clause accepted** ("`∀ x j, F.HasHornCount x j → ∃ j′ ≤ j, F′.HasHornCount x
> — source: plans/FS131-close-inventory.md

MERGE, whose machinery you reuse:

> 367. **FS131-IMM4 done: MERGE is proved** (harness ≈ 472k by the task notice; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`, Stages 10–12; report
> — source: plans/FS131-close-inventory.md

> 375. **MERGE LANDED on `main`, held in the kernel: FS131-ML1 done** (harness ≈ 334k by the task notice; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`,
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read E6's record §§ 3–4 in full and MERGE's record (`fs131-w4mm`'s
   `plans/FS131-IMM-implementation.md`, by `git show origin/fs131-w4mm:plans/FS131-IMM-implementation.md`) for the reused lemmas; build `fs131-wop` once as given
   (`11a34d9d`; its `.lake/build` was copied from `fs131-w4mm`, so the first build rebuilds little) before editing anything; open your record with what you may
   and may not change. Commit and push.
2. **The statements settled**: `HasHornCount` (or a horn count read off `BranchGerms`, E6's alternative — your choice, said in the record) with a spec example,
   and `exists_open`, each read back against E6-OPEN clause by clause in the record; `OpenMove` created with them `sorry`; build. Commit.
3. **OPEN proved**, by route (a): the gap ending at a new ray, `cone_side`, `clear_near_end`, `dist_ne_one_of_isOpen_isClear` and `merge_allowedCone`'s route
   reused; children in `OpenMove`; save after each; re-price after the first two; no existing statement of `main` changed, no new `axiom`, no `native_decide`. Do
   not edit a file while a build of it runs.
4. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control on `sorryAx` while one remains. You do not merge another branch into this one, run the gate, or touch `main` — OPEN's landing is a later
   job, on my word. Leave no background process running.
5. **Your record**, stages headed "Stage n — SAVED (FS131-IO1)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
   with parts left, named, is a good report.

## What is yours to decide

The statements' exact form within E6-OPEN's clauses, the horn count's encoding, the construction (route (a) is E6's preference, (b) — `Near.move` with the ray
and then a cleaning step — its alternative), the children and their order. If a clause of E6-OPEN cannot be proved as derived, stop it and message me with
the configuration: that goes back to Ephodos. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start
no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.
