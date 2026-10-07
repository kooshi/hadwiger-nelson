# FS124-L2 — the landing: the one-piece and close-pair statements, their witnesses and the three-arcs lemma, through the gate and onto `main`

*Record of the landing implementer (de Bruijn, Opus 5.5). Brief: `data/fs124/briefs/FS124-L2-landing.md` on `main` at
`2698f666`. Branch `fs124-wi3`, worktree `.claude/worktrees/fs124-wi3`, at `e33b5088` when this job began. Working
files: `data/fs124/l2/`. Tools: `tools/fs124_l2_*.py`; other jobs' tools are run, never edited. The record is written
in stages; each is committed before the next starts.*

## Theorems this phase proved

*The final list, with the gated commit and the axioms as the gate printed them, is at the end of this record
("Theorems this phase proved, final").* This job proves one leaf of its own, by the kernel planner's two lines —
`ThreePiece.IsSector.hasArcEdges` (`Plane/SectorPoint`) — and gates and lands the statements of FS124-K2 and FS124-K3
(planners) with the proofs of FS124-I2, -I3, -I4 and -I5 (implementers): the eight modules `Plane/CircleCrossing`,
`OnePiece`, `ThreePiece`, `ClosePair`, `ClosePairWitness`, `ClosePairModel`, `ThreeArcs`, `SectorPoint`.

## Stage 1 — SAVED (FS124-L2): the readback, what was read, the branch built as given, the merges tried

### The brief's quotations

`tools/fs132_i1_quotes.py` (FS132-I1's checker, run unedited) on the brief, relative sources read under `main`'s
checkout (`--root /home/kooshi/source/lean-dir`) and absolute ones as given: **25 quotations, 0 mismatches**, exit 0
(`data/fs124/l2/quotes.out`). By source: `Plane/OnePiece.lean` 5, `Plane/ClosePair.lean` 5, `Plane/SectorPoint.lean`
2 (in this worktree), `CLAUDE.md` 4, `LEDGER.md` 2 (rows 162 and 163, whole), `plans/FS124-close-inventory.md` 6, the
request file 1. Its self-test plants a changed word, a wrong source and an empty quotation: each **FIRED**, exit 0
(`data/fs124/l2/quotes-selftest.out`). No finding about a quotation.

**Two notes on the brief** (neither changes the job):
1. `main` has moved since the brief was written: `07bf6096` → `2698f666` (the brief's own regeneration) → `9febc276`
   (inventory item 49 and the handoff: `plans/`, two paths, nothing else).
2. The brief's item 2 lists eight modules to hold no `sorry`; `Plane/ClosePairWitness` is the third implementer's
   helper module (its row in the architecture file is that job's), so the count is eight, as listed.

### What was read

Whole: the brief; `plans/STANDING-RULES.md`; `LEAN.md` as on `main`; `RUNNING.md` § Building and § Make the gate
fail, and watch it fail; the last landing's record `plans/FS124-L1-landing.md` (ten stages, its drafts, its slips —
stage 8: the audit's self-test went red on the two controls that read the count of IMPORTED records). By section:
the planner's record `plans/FS124-kernel-plan-2.md` § 3.7 and § 4.6; the implementers' records —
`plans/FS124-I2-implementation.md` Stage 4 and its drafts, `plans/FS124-I3-implementation.md` § 3.3 and its drafts,
`plans/FS124-I4-implementation.md` Stage 4 (§ 4.1–4.5) and its drafts; on the other branch,
`plans/FS124-kernel-plan-3.md` § 3.1, § 4.4, § 4.5 and `plans/FS124-I5-implementation.md` Stage 4 and its drafts.
`CLAUDE.md` § Trust ledger and § The gate **from disk on `main`** (the copy loaded at launch is an older snapshot).

### The branch as given

`./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`, at `e33b5088`: **exit 0** —
"build: OK — all 1854 modules already up to date, nothing built, 1 module(s) with warnings, 3s"; **one `declaration
uses sorry` warning, `Proofs/HadwigerNelson/Plane/SectorPoint.lean:52:8` — the θ-leaf — and no other**
(`data/fs124/l2/build-0-as-given.log`).

### The two merges, tried before either is made

`git merge-tree --write-tree --name-only`, the branch tip `e33b5088` against each:

- **`origin/fs124-wk3` at `9af859b7`** (`data/fs124/l2/merge-trial-wk3.out`): exit 1, **one conflict —
  `ARCHITECTURE.md`** (each side added a row after the same row); `Proofs.lean` merges automatically. Against the
  merge base `fb515b25` that branch changes, outside `plans/` and `data/`: `ARCHITECTURE.md` (1 line), `Proofs.lean`
  (1 line), `Proofs/HadwigerNelson/Plane/ThreeArcs.lean` (new, 855 lines). **No conflict in a file under `Proofs/`.**
- **`origin/main` at `9febc276`** (`data/fs124/l2/merge-trial-main-before-join.out`): exit 1, **one conflict —
  `ARCHITECTURE.md`**; `Proofs.lean`, `scripts/Axioms.lean` merge automatically. The merge base is `80ee1983` (the
  first module's branch tip); since it `main` changes 24 paths under `Proofs/` (FS132-L2's 22 modules, its licence
  copy, the import module's licence sentence), `Proofs.lean`, 5 under `scripts/`, 9 under `tools/`,
  `ARCHITECTURE.md`, and the coordinator's files; this branch changes 7 under `Proofs/` (its seven modules),
  `Proofs.lean`, `ARCHITECTURE.md`, `data/`, `plans/`. **No conflict in a file under `Proofs/`**, as the brief's
  trial found. It is tried again on the joined tree before it is made (stage 2).
