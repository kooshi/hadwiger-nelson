# FS131-IFR2 — the density form of the collapse: `main` merged, every landing's gate inputs kept, the full gate once

*de Bruijn, the implementer (successor to FS131-IFR1). Brief: `data/fs131/briefs/FS131-IFR2-density.md` (on `main`). Worktree
`.claude/worktrees/kcl1`, branch `fs131-kfr1`, starting at `9e9739eb5` (the predecessor's gate commit `e849029c3` plus its record
and report). Working files: `data/fs131/ifr2/`.*

## Theorems this phase proved

None. This job proves no theorem and changes no proof or statement: it merges `main` into the branch, reconciles the gate's
input files, and runs the full gate once on the merge. The 75 kernel theorems of the density form are FS131-IFR1's (its record,
`plans/FS131-IFR1-density.md` § Theorems this phase proved); this job's gate re-checks them on the merged tree.

## Stage 1 — SAVED: the readback

### 1.1 The quotations

`data/fs131/ifr2/quote_check.py` (a copy of FS131-IFR1's checker) reads every block quotation of the brief and looks for it,
verbatim, in its named source. The brief has four, all from `plans/FS131-close-inventory.md` (items 1048, 1050, 1055, 1025),
checked against `main`'s tree at `fed57f25c`: **all four VERBATIM** (`data/fs131/ifr2/quote_check.out`, exit 0). Control:
`--plant` changes one character of the first and the check reports `MISMATCHES: 1`, exit 1
(`data/fs131/ifr2/quote_check_plant.out`). No finding about the brief.

### 1.2 Where the trees stand

- **The branch** `fs131-kfr1` at `9e9739eb5`; its `.lake/build` is the predecessor's gated build of `e849029c3`
  (`lake build --no-build Proofs` under the slot: exit 0, "All targets up-to-date (6531 jobs)",
  `data/fs131/ifr2/uptodate-premerge.log`). `9e9739eb5` changes nothing under `Proofs/` or `scripts/` after `e849029c3`.
- **`main`** at `fed57f25c` when read (and moving: coordinator commits since, to `d9ce6f214`): the brief's `64a41b19a` plus
  coordinator commits (the brief, inventory items, the README, the handoff), none touching `Proofs/`, `scripts/` or the package files. Its gate-relevant tree is the five-colour gate's
  `960882257` (item 1055's receipt).
- **The merge base** is `cf2d262e7`. Since it, `main` brought two landings (the three-colour criterion, FS131-KTC1 and FS131-ICT1–ICT3,
  `8ebb647bc`; the five-colour fields, FS131-KCS1 and FS131-ICS1, `3466820ee`) and this branch the density form (FS131-IFR1's).
- **Files changed on both sides** since the base: `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`,
  `scripts/axioms-controls.txt`, `scripts/assumptions-ledger.txt`, `scripts/vacuity-baseline.txt` — the gate inputs the brief
  names — and **one proof file, `Proofs/HadwigerNelson/Rigidity/ClassRatio.lean`**. Its two sides touch disjoint hunks: this
  branch makes `ratioAtMost_of_charBound` public (l. 92, ruling 2 of item 1021); `main` makes `exists_card_two_pow_sq`,
  `chromaticNumber_le_four_dyadic` and `chromaticNumber_le_four_of_small` public and adds `ratioAtMost_dyadic_of_six_le`
  (l. 1042 on; FS131-ICS1, items 1027 and 1029), which calls `ratioAtMost_of_charBound` by its short name — the name resolves
  whether it is private or public. A textual merge with no conflict is expected there; if git reports one, it is a proof file
  and goes to the coordinator before anything else. Two non-gate files are on both sides with identical text
  (`plans/FS131-IFR1-density.md`, `data/fs131/reports/FS131-IFR1.md`: the coordinator copied them to `main` in `84c39fdc5`).
- **The recompilation the merge forces.** The merged `ClassRatio` is a third text, equal to neither gated build's, so it and
  its whole cone recompile: on the branch 22 modules depend on it (`data/fs131/ifr2/cone.py`), the density modules among
  them, and `main`'s five-colour modules add to that. Every density module is therefore recompiled against the merged upstream,
  which is why the predecessor's statement comparison is run again on the new build.

### 1.3 What the merge must keep (the predecessor's list, its record § "What is left")

1. `scripts/Axioms.lean`: the predecessor's four blocks (one `exists_model_seven` line under the Weil block; three lines after
   the five-colour-theorem block; seventeen after the E–L block; an 85-line CLEAN block before `=== PURCHASED ===`) **and** both
   `main` landings' blocks. Check after: `tools/fs131_ifr1_audit_block.py … --coverage` prints `COVERAGE OK`; `--plant` three
   STOPs.
2. `scripts/axioms-controls.txt`: the two state controls at the merged total of imported records — the p-adic base 83, plus
   this landing's 21, plus the two `main` landings' (`main` reads 99, so 16) — expected `imported=120` (`baseline`) and `121`
   (`imported_declared`), confirmed by the self-test's "got:" line, with the `digest old` texts and the counting paragraph
   brought to the merged totals.
3. `scripts/assumptions-ledger.txt`: rewritten whole by `./scripts/assumptions.sh --write-ledger` on the merged library.
4. `scripts/vacuity-baseline.txt`: the header's count line only, from the merged gate's digest.
5. `ARCHITECTURE.md`: both sides' rows.
6. `Proofs.lean`: both sides' import lines.

**The expected audit counts**, if each landing's records add independently: records 11,466 (the p-adic gate) + 106 (density)
+ 126 (three- and five-colour, `main`'s 11,592 − 11,466) = 11,698; clean 10,804 + 84 + 110 = 10,998; imported 83 + 21 + 16 = 120;
axiom-free 575; purchases 5. Vacuity declarations 22,566 (`main`) + 117 = 22,683, refutations-skipped `main`'s + 2, sites
`main`'s 1,465. A difference from these is explained, not absorbed.

### 1.4 The order of work

1. `git merge main`; resolve each gate-input conflict keeping both sides; any conflict in a proof or statement → the coordinator.
2. Commit the merge. Copy `main`'s `.lake/build` in by checksum (`rsync -a --checksum`, no `--delete`; a dry run first; checksum
   listings before and after). Build under the slot. Save stage 2.
3. Bring the gate inputs to the merged library (the audit block coverage, the state controls, `--write-ledger`, the vacuity
   header), each commit before the gate; then the full gate (`data/fs131/ifr2/run-gate.sh`, the steps of
   `data/fs131/clone1/run-gate.sh`) on one commit. Statement dump and comparison; `#print axioms` of the head statements.
   Save stage 3.
4. The drafts' counts. Save stage 4. The report.
