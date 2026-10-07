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

## Stage 2 — SAVED (FS124-L2): the join — the three-arcs branch merged, the leaf closed, `main` merged in

**The first merge**: `git merge --no-ff --no-commit 9af859b7dcf63899973c04b8ff3d00165e98940d` (the hash, never the
ref; `data/fs124/l2/merge-wk3.out`) — `Proofs.lean` merged automatically (the one import line of `Plane/ThreeArcs`
after this branch's seven); **one conflict, `ARCHITECTURE.md`, resolved by keeping both sides**: this branch's three
rows (`Plane/ClosePairWitness`, and the rows of `Plane/ClosePairModel` and `Plane/SectorPoint` with the imports cell
this branch gave them), then the other side's row of `Plane/ThreeArcs`. Checked by script before writing: the two
doubled rows differ between the sides in their imports cell only. **No conflict in a file under `Proofs/`.** Merge
commit `35704355`.

**The leaf** (`Proofs/HadwigerNelson/Plane/SectorPoint.lean`; `git diff` against the as-given file: 20 lines added, 10
removed): the import `Proofs.HadwigerNelson.Plane.ThreeArcs`; the body of `ThreePiece.IsSector.hasArcEdges` — the
`sorry` replaced by the kernel planner's two lines (`plans/FS124-kernel-plan-3.md` § 3.1), as written there:

```lean
  obtain ⟨r, hr, J, h1, h2, h3, h4, h5, -, h7⟩ := h
  exact fun i j hij => IsTriodCut.exists_arc ⟨⟨hr, h1, h2, h3, h4, h5⟩, D.isOpen_piece, D.isPreconnected_piece,
    fun _ _ hab => D.disjoint_piece hab, h7⟩ D.nbhd_mem hij
```

the spec example of its § 4.4 after `sectorPoint_isSector` — `example : sectorPoint.HasArcEdges :=
sectorPoint_isSector.hasArcEdges`, the lemma run on the model of its hypotheses; and two docstrings that the leaf's
closing makes false as written: the module header's title and its item on the leaf ("the θ-lemma is owed", "Owed as a
kernel job of its own") and the leaf's own docstring ("owed as a kernel job of its own") now say what the bridge rests
on — `IsTriodCut.exists_arc`, which half of the classical fact it proves, and that the definition's sixth clause is
not read. **No statement and no definition of the file is touched** (stage 3's kernel-side comparison).

**Built** (`data/fs124/l2/build-1-joined.log`): **exit 0** — "build: OK — 477 of 477 batches, 3 module(s) rebuilt, 0
module(s) with warnings, 8m44s" (`Plane.ThreeArcs`, `Plane.SectorPoint`, `Proofs`); lines holding "warning" in Lake's
full log: 0. **No `sorry` in the eight modules**: the narrow search (`^\s*sorry\s*$`, `:= sorry`, `by sorry`) over
`Proofs/` and `Proofs.lean` finds 0 lines; the word occurs in none of the eight files but in prose. The leaf and the
two theorems over it print the standard three (`data/fs124/l2/probes/checks-probe.out`: 26 prints, every one
`[propext, Classical.choice, Quot.sound]`) — on the as-given tree each of the three printed `sorryAx` (the third
implementer's controls). Commit `fb86127a` (the leaf), pushed to the branch.

**The second merge**, tried again on the joined tree (`data/fs124/l2/merge-trial-main.out`: the same one conflict)
and made by hash: `git merge --no-ff --no-commit a61ea9150aade8ebac38014a004bf4c732230232`
(`data/fs124/l2/merge-main.out`) — `main` had moved three commits past `9febc276` (FS-136's inventory and a brief:
`plans/` 2 paths, `data/` 2). `Proofs.lean` and `scripts/Axioms.lean` merged automatically; **one conflict,
`ARCHITECTURE.md`** — § 3.13's table, where `main` reworded the first module's three rows at its landing and this
branch added eight rows after them — **resolved by keeping both sides**: `main`'s three rows, then this branch's
eight. Checked: the resolved file differs from `main`'s by exactly eight added lines, and `Proofs.lean` from `main`'s
by exactly the eight import lines (316 import lines, none twice). **No conflict in a file under `Proofs/`.** Merge
commit `16cb9018`.

**Built** (`data/fs124/l2/build-2-merged.log`), with stage 3's docstring rewordings in the tree: **exit 0** — "build:
OK — 481 of 481 batches, 30 module(s) rebuilt, 0 module(s) with warnings, 10m15s". The thirty: the import module
(`main`'s licence sentence is a docstring, so it and everything downstream recompiled here — the nine ported modules,
the thirteen of `Plane/SixRing`, `Plane/RadiusOutside`), the five modules downstream of the reworded docstrings
(`Plane/ThreePiece`, `ClosePair`, `ClosePairWitness`, `ClosePairModel`, `SectorPoint`), and the root. The library is
1,877 modules: `main`'s 1,869 and the eight.
