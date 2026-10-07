# FS132-L1 — the import's landing: `[OAIMath2026]` family 158's two outside theorems through the gate and onto `main`, with the one question as a theorem

*Record of the landing implementer (de Bruijn, Opus 5.5). Brief: `data/fs132/briefs/FS132-L1-import-land.md` on `main` at
`f1febfb1`. Branch `fs132-wi1`, worktree `.claude/worktrees/fs132-wi1`, taken at `39d37838`. Working files: `data/fs132/l1/`.
Tools: `tools/fs132_l1_*.py`; the import's own (`tools/fs132_i1_*.py`) are run, never edited.*

## Theorems this phase proved

*Filled at the gate (the final list is at the end of this record, "Theorems this phase proved, final").* One theorem is
this job's own: `HadwigerNelson.Outside.OAI158.seven_le_chromaticNumber_plane_iff`. The module's other theorems are
FS132-I1's (`plans/FS132-I1-implementation.md` § Theorems this phase proved); this job gates and lands them.

## Stage 1 — SAVED (FS132-L1): the readback, what was read, the branch built as given

### The brief's quotations

`tools/fs132_i1_quotes.py` (the import's checker, run unedited) on the brief, relative sources read under `main`'s
checkout (`--root /home/kooshi/source/lean-dir`: the inventory, the request file and `CLAUDE.md` are `main`'s files) and
absolute ones as given: **14 quotations, 0 mismatches**, exit 0 (`data/fs132/l1/quotes.out`). By source: the module 5,
`CLAUDE.md` 4, the inventory 2, the left-out consequence's file 2, the request file 1. Its self-test plants a changed
word, a wrong source and an empty quotation: each **FIRED**, exit 0 (`data/fs132/l1/quotes-selftest.out`).

One thing the check shows that the launch context does not: the `CLAUDE.md` loaded into this session at launch is a
snapshot older than `main`'s (its § The aim item 5 reads "So, given MR, Hadwiger–Nelson is one question: can vanishing
holes save a colour?"); the brief's quotation is `main`'s text on disk ("So Hadwiger–Nelson is one question: can vanishing
holes save the seventh colour?"). Every front-page slot below is read from disk on the merged tree, never from the
snapshot.

### What was read

The brief whole; `plans/STANDING-RULES.md` whole; `LEAN.md` whole (as on `main`); `RUNNING.md` § Building and § Make the
gate fail, and watch it fail, whole. The import's record whole (`plans/FS132-I1-implementation.md`: stage 1's cross-pin
comparison and the table of 83 constants, stage 2, stage 3's probes and "At the join", its ten drafts, "What was checked,
and by whom", stage 4) and its report. The audit's Stage 8 and "What was checked, and by whom"
(`plans/EXT-OAI1-audit.md` ll. 611–751). The last landing's record, stages 5–6 and the head of its drafts
(`plans/FS131-L8A-landing.md` ll. 246–612). Inventory items 629 and 632 whole, 619 by its quoted head; the request file
whole (five words of Kooshi's). The module whole (316 lines) and the left-out consequence's file (8 lines).

### The branch as given

`./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8`, `MEMMAX=40G BATCH=4`, at `39d37838`: **exit 0** — "build:
OK — all 1832 modules already up to date, nothing built, 0 module(s) with warnings, 2s"
(`data/fs132/l1/build-0-as-given.log`).

### The join, tried before it is made

`main` has moved past the brief's commit: `origin/main` is `aca251ee` (one commit after `f1febfb1`, a handoff), 102
commits past the branch's base `8386c256`. `git merge-tree --write-tree --name-only HEAD origin/main`, nothing merged
(`data/fs132/l1/merge-trial.out`): **one conflict, `ARCHITECTURE.md`**; `Proofs.lean` and `scripts/Axioms.lean` merge
by themselves — as the import's dry run found. No Lean file under `Proofs/` conflicts: the branch touches one module
there (`Outside/OAI158.lean`, new), `main` twelve others (the ring calculus and `Plane/SimpleOn`, wave 8).
