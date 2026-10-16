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

## Stage 2 — SAVED: the merge and the build

### 2.1 The merge

`git merge main` at `d9ce6f214` (`main` had moved past the brief's `64a41b19a` by coordinator commits only), committed as
`8dbd69096` (`data/fs131/ifr2/merge.log`). Git merged `Rigidity/ClassRatio.lean`, `Proofs.lean` and `ARCHITECTURE.md` with no
conflict: their two sides' hunks are disjoint, and the merged texts are each side plus the other's insertions (checked by
`git diff` against both parents). **No proof or statement was in conflict.** Four gate inputs were, each resolved keeping
both sides (`data/fs131/ifr2/resolve_both.py` for the audit; the rest by a script whose text is in the commit's message):

| file | conflict | resolution |
|---|---|---|
| `scripts/Axioms.lean` | one hunk, end of CLEAN: `main`'s two CLEAN blocks (FS131-ICT3's three-colour, FS131-ICS1's five-colour; 121 lines) against FS131-IFR1's (90 lines) | both, `main`'s first; the IMPORTED lines of the three landings had merged with no conflict. The merged file is `main` + 118 lines and the branch + 140 lines, insertions only both ways |
| `scripts/axioms-controls.txt` | the counting paragraph and the two state controls (`imported=99`/`100` against `104`/`105`) | the merged totals by arithmetic over the three landings' own counts: the p-adic base 83 (Weil 64, five-colour theorem 7, E–L 27, E–L and Weil 14, all three 1), five-colour +16 (Weil 16, E–L 7, both 7), density +21 (Weil 10, five-colour theorem 3, E–L 20, both 9, all three 3): **imported 120** (`baseline`) and **121** (`imported_declared`); Weil 90, five-colour theorem 10, E–L 54, E–L and Weil 30, four of them on all three. The gate's self-test confirms the total |
| `scripts/vacuity-baseline.txt` | the header's two count lines | the expected merged counts: `main`'s plus this landing's `+117` declarations and `+2` refutations-skipped, no site: `declarations=22683 refutations-skipped=245 sites=1465`, `vacuous=0 stale=0 declared=3 witnessed=40 generic=1420 unknown=2`. The gate's digest confirms them |
| `scripts/assumptions-ledger.txt` | the header's count line; one hunk of `RESTS` rows | both sides' rows (168 = 145 + 128 − 105 common) and `rests=168`; then rewritten whole by `--write-ledger` on the merged build |

### 2.2 The build

`main`'s gated build (FS131-ICS1's, of `960882257`, in the main tree) copied in by checksum, no `--delete`
(`data/fs131/ifr2/copy_build.sh`): the dry run listed 124 files to copy (56 new, 68 changed: the three- and five-colour
modules, and `ClassRatio`'s cone as `main` compiled it), and 92 files whose content already agreed and only their times
differ. The real copy itemized the same 124; the source's SHA-256 over the 124 equal before and after the copy, and the copies
equal to the source (`copy-dryrun.txt`, `copy-list.txt`, `copy-rsync.txt`, `copy-src-before.sha`, `copy-src-after.sha`,
`copy-dst.sha`). Then the build under the brief's slot (`--mem 8 --cpus 5`, `MEMMAX=8G BATCH=3`):
exit 0, "build: OK — 740 of 740 batches, 26 module(s) rebuilt, 0 module(s) with warnings, 22m50s" (`build1.log`,
`build1-full.log`; the 26 in `build1-rebuilt.txt`): `Rigidity.ClassRatio` and its whole cone — the three density modules,
`Collapse/Headline`, the five-colour modules that import it (`FourColourPlaces`, `SqrtFiveClass`, `SqrtTwentyThreeCbrtTwo`),
the rest of `Collapse/` and `Rigidity/Count*`, the p-adic plane's two — and the root. `Plane/TriangularPacking`,
`Arith/StableAboveUsable` and `CayleyThree/*` are outside the cone and kept their compiled files (the predecessor's, and
`main`'s by the copy). Then `lake build --no-build Proofs`: exit 0, "All targets up-to-date (6538 jobs)"
(`uptodate-postbuild.log`).

### 2.3 What the merged build holds, read against both gated builds

- **Stored statements** (`tools/fs131_ifr2_statements.py`, new; the merged print `data/fs131/ifr2/statements-merged.txt.gz`
  from `data/fs131/ifr2/lean/StatementDump.lean`, 27 modules): every constant of FS131-IFR1's gated print (six modules) and
  of FS131-ICS1's gated print (twenty-one modules) that is not internal is in the merged build with the same kind, flags,
  stored type and, for a definition, the same value with proofs erased: **VERDICT CLEAN**, 755 SAME, 4 PUBLICIZED, 0 ADDED,
  0 CONFLICT, and no definition's full value moved (`statements.out`). The four PUBLICIZED are the two landings' ruled
  publicizations in `ClassRatio`, each private on the other side and public here with its stored type equal up to the
  hygienic hash of an instance binder's name (FS131-ICS1's finding): `ratioAtMost_of_charBound` (FS131-IFR1, item 1021),
  `exists_card_two_pow_sq`, `chromaticNumber_le_four_dyadic`, `chromaticNumber_le_four_of_small` (FS131-ICS1, items 1027,
  1029); each is also SAME against the side where it is public. The two sides' copies of `ClassRatio` and `Collapse/Headline`
  agree on every constant they share. `PadicPlane/Tower` and `Values` recompiled too and no gated print holds them: counted,
  not compared. Six plants, all fired: a density type changed, a density constant dropped, an unlisted public added, a
  publicized type changed, a five-colour type changed, FS131-ICS1's publicization undone. (The comparator was first run on a
  synthetic union of the two gated prints: clean, its plants firing, `statements-synthetic.out`.)
  The predecessor's own comparator against its skeleton's print (`statements-ifr1tool.out`) passes every one of its own
  rulings (PUBLICIZED, seven MOVED, two RULED) and reports 28 failures, each another landing's: the three privates
  FS131-ICS1 made public (MISSING, then ADDED-PUBLIC-UNLISTED), `ratioAtMost_dyadic_of_six_le` (ADDED-PUBLIC-UNLISTED), and
  21 modules its skeleton's print did not cover (MODULE-NEW). Read as it is, that is the expected result.
- **Every record's axioms** (`tools/fs131_ifr2_axioms_diff.py`, new; the merged print `data/fs131/ifr2/axioms-all.txt` from
  `data/fs131/ifr2/lean/AxiomsAll.lean`, ten modules, 385 records, no `sorryAx`): every record of FS131-IFR1's print (304) and
  of FS131-ICS1's (191) has the same axiom set in the merged build; nothing added or missing: **VERDICT CLEAN**
  (`axioms-diff.out`); four VISIBILITY lines, the four ruled publicizations. Four plants fired: an axiom set changed, a record
  dropped, a record added, a `sorryAx`.
- **The audit's coverage**: FS131-IFR1's generator and FS131-ICS1's, each with `--coverage` on the merged print against the
  merged `scripts/Axioms.lean`: `COVERAGE OK: every one of the 182 public records is filed under its class`
  (`coverage-ifr1gen.out`, `coverage-ics1gen.out`). The generator's plant has no target when every record is filed
  (`PLANT UNREACHABLE`), so it was run against `main`'s audit file (`git show 8dbd69096^2:scripts/Axioms.lean`): three STOPs —
  BAD, OPEN, MISFILED (`coverage-plant.out`). Against that file, too, the generator regenerates from the merged print exactly
  the predecessor's four blocks, byte for byte (`audit/regen.*`, `regen.out`: 85 CLEAN, 17 on E–L, 3 on the five-colour
  theorem, 1 on Weil's bound alone; 106 records unfiled on `main`, 76 filed).
- **The assumptions ledger**: `./scripts/assumptions.sh --write-ledger` under the slot (`write-ledger.log`): exit 0, 279
  rows; it moved two rows of FS131-ICS1's to their sorted place and changed nothing else — the row set is identical to the
  resolution's (`assumptions-ledger.resolved.txt`), `rests=168` as resolved.
