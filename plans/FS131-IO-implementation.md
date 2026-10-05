# FS131-IO — OPEN, the fifth move (`HasHornCount`, `exists_open`) in `Plane/ValidMap/OpenMove`

*The record of FS131-IO1 (de Bruijn, the implementer, on Opus), branch `fs131-wop` cut from `main` at `11a34d9d`, in the worktree
`.claude/worktrees/fs131-wop`. Brief: `data/fs131/briefs/FS131-IO1-open.md` (on `main`). Report: `data/fs131/reports/FS131-IO1.md`.*

## Theorems this phase proved

(Filled at each saved stage; see the stages below.)

## Stage 1 — SAVED (FS131-IO1): the readback, the as-given build, and what this job may change

### 1.1 The brief's quotations against their sources (standing rule 3)

Each quotation was compared with its source by reading the source text (the branch's files, and `main`'s
`plans/FS131-close-inventory.md` by `git show main:…` where the branch predates it):

| quotation (first words) | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time." | `CLAUDE.md` § Counter-priors | **matches** |
| "def HasHornCount (v : ℂ) (j : ℕ) : Prop :=" | `plans/FS131-E6-derivation.md` § 4.5 (1), l. 404 | **matches** |
| "theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}" | same, l. 416 | **matches** |
| "theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)" | `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` l. 1525 | **matches** |
| item 382, "**FS131-E6, by message (mid-job): F6 is real; …** (1) **Realized**" | inventory l. 3388 | **matches** |
| item 384, "**FS131-E6 done: F6 is real, and repaired with no backlog statement changed** (harness ≈ 540k …" | `main`'s inventory l. 3411 | **matches** (on `main` at `4f1ec821`, after this branch's cut; not on `fs131-wop`) |
| item 385, "**Rulings on E6's held items, and its slot.** (a) **`exists_arcStep`'s horn clause accepted** …" | `main`'s inventory l. 3435 | **matches** (same note) |
| item 367, "**FS131-IMM4 done: MERGE is proved** (harness ≈ 472k …" | inventory l. 3187 | **matches** |
| item 375, "**MERGE LANDED on `main`, held in the kernel: FS131-ML1 done** (harness ≈ 334k …" | inventory l. 3302 | **matches** |

No mismatch.

### 1.2 Read for this job

- `plans/STANDING-RULES.md`, `LEAN.md` in full; `RUNNING.md` § Building and § Make the gate fail, and watch it fail.
- `plans/FS131-E6-derivation.md` §§ 3–4 in full (the model, E6-NODROP, E6-CONE, **E6-OPEN** § 4.2, E6-ROUTE, the trace, the drafts § 4.5,
  the entries).
- MERGE's record, `git show origin/fs131-w4mm:plans/FS131-IMM-implementation.md` (the theorem lists, §§ 4, 5.2, Stages 7–12) for the reused
  lemmas and the construction's shape.
- The code: `ValidMap/Basic.lean` (definitions), `Surgery.lean` (`surgery`, `Near`, the surgery's clause lemmas), `MergeMove.lean`'s
  declaration list and `cone_side`, `gap_assemble`, `clear_near_end`; `Moves.exists_merge_aux` (the assembly); `Sectors.lean`'s partition
  lemmas (`isSector_iff_of_partition`, `encard_sectors_of_partition`, `IsSectorChart.isSector_cone_or_horn`, `IsSectorChart.hasDegree`);
  `Cone.lean`'s `e_eq_of_mem_coneAt_hornSet`.

### 1.3 The branch builds as given

Under the slot (`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`), before any edit: **OK — "all 1766 modules
already up to date, nothing built, 0 module(s) with warnings"** (the copied `.lake/build` was current), log
`build/gate/build/20261005T101839Z-3305996.log`, terminal output `data/fs131/io/build-0.log`, exit 0.

### 1.4 What this job may and may not change

- **May**: create `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` (new declarations only, importing `Contact`, which imports
  `Moves` and `MergeMove`); add it to `Proofs.lean` and `ARCHITECTURE.md`; add an "FS131-IO1" block to `scripts/Axioms.lean` above the
  `=== PURCHASED ===` banner; write this record, `tools/fs131_io_*.py`, `data/fs131/io/`, `data/fs131/reports/FS131-IO1.md`. The
  statements of `HasHornCount` and `exists_open` are mine to settle within E6-OPEN's clauses.
- **May not**: change any existing declaration of `main` (`MergeMove`, `Moves`, `Contact`, `Surgery` and every other module stay as
  they are); merge another branch; run the gate; touch `main`; add an `axiom` or a `native_decide`.

## Stage 1 — SAVED (FS131-IO1)
