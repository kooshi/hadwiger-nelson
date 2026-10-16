# FS131-IRU2 — the ring of unit vectors: `main` merged, every landing's gate inputs kept, the full gate once

*de Bruijn, the implementer (successor to FS131-IRU1). Brief: `data/fs131/briefs/FS131-IRU2-ring.md` (on `main` at `d9959820f`).
Worktree `.claude/worktrees/il5`, branch `fs131-kru1`, starting at `5a22b1a34` (the predecessor's gate commit `ddb765bac` plus its
record and report). Working files: `data/fs131/iru2/`. Nothing in this milestone is blind.*

## Theorems this phase proved

None. This job proves no theorem and changes no proof or statement: it merges `main` into the branch, reconciles the gate's
input files, and runs the full gate once on the merge. The 40 kernel theorems of the ring of unit vectors are FS131-IRU1's (its
record, `plans/FS131-IRU1-ring.md` § Theorems this phase proved); this job's gate re-checks them on the merged tree.

## Stage 1 — SAVED: the readback

### 1.1 The quotations

`data/fs131/iru2/quote_check.py` (a copy of FS131-IFR2's checker) reads every block quotation of the brief and looks for it,
verbatim, in its named source. The brief has three, all from `plans/FS131-close-inventory.md` (items 1065, 1063, 1025), checked
against `main`'s tree at `d9959820f`: **all three VERBATIM** (2,155, 2,701 and 2,276 characters; `data/fs131/iru2/quote_check.out`,
exit 0). Control: `--plant` changes one character of the first and the check reports `MISMATCHES: 1`, exit 1, the other two still
VERBATIM (`data/fs131/iru2/quote_check_plant.out`).

**One figure of the brief is a slip, not a quotation:** `touches:` says the worktree's `.lake/build` "is the predecessor's gated
build of `e849029c3`". `e849029c3` is FS131-IFR1's commit (the density branch's vacuity header, an old hash from before that
branch's rewrite; no branch holds it now). The worktree's build is FS131-IRU1's gated build of `ddb765bac` (its build 3, on
`45de7612d`, record § 3.1): `lake build --no-build Proofs` under the slot reads "All targets up-to-date (6535 jobs)", exit 0
(`data/fs131/iru2/uptodate-premerge.log`), and `5a22b1a34` changes nothing under `Proofs/`, `Proofs.lean`, `scripts/` or the
package files after `ddb765bac` (`git diff --stat`: empty). Nothing in the work depends on it.

### 1.2 Where the trees stand

- **The branch** `fs131-kru1` at `5a22b1a34`, 20 commits ahead of the merge base `93d1914b8` (inventory item 1044, on `main`).
- **`main`** at `d9959820f`: since the base it brought two landings — the five colours by field and by class (FS131-KCS1,
  FS131-ICS1) and the density form of the collapse (FS131-KFR1, FS131-IFR1, FS131-IFR2; gated on `b8cef1f36`, merged as
  `dfba6bc68`) — and coordinator commits. Its gated build is in the main tree.
- **Files changed on both sides** since the base: `ARCHITECTURE.md`, `Proofs.lean`, `scripts/Axioms.lean`,
  `scripts/Assumptions.lean`, `scripts/vacuity-baseline.txt` (and the predecessor's record and report, which the coordinator copied
  to `main` unchanged). **No proof file is changed on both sides.** `scripts/Assumptions.lean`: both sides delete the same line,
  the `.condition` entry for `Arith.IsUsablePrime` (the branch because `Rigidity.exists_isUsablePrime` concludes it, `main` because
  FS131-ICS1's `SqrtTwentyThreeCbrtTwo.exists_usablePrime_eleven_F23` does), so it stays retired with no conflict.
  `scripts/axioms-controls.txt` and `scripts/assumptions-ledger.txt` changed on `main` only.
- **Names.** The three lemmas the branch made public in `Rigidity/AdmissiblePrime` (`exists_integral_primitive`,
  `exists_dvd_of_dvd_exponent`, `nonempty_residueHom`) are named nowhere on `main` outside that module (`git grep` over `Proofs/`
  and `scripts/` of `main`), and no `open private` of that module exists there. A full name intersection of the two lines'
  compiled constants is taken before the first build (stage 2).

### 1.3 What the merge must keep (the predecessor's record § 3.5 and its report's last held item)

1. `scripts/Axioms.lean`: this branch's CLEAN block (FS131-IRU1, 45 records) **and** `main`'s blocks (FS131-ICS1's and FS131-IFR1's,
   CLEAN and IMPORTED). The predecessor's aborted merge showed one conflict here, at the end of the CLEAN section: keep both.
   Check after: the coverage of the audit over this branch's records (`tools/fs131_iru1_audit_block.py --coverage` on a print
   from the merged build), and the other landings' coverage by their generators.
2. `scripts/Assumptions.lean`: the `.condition` entry for `Arith.IsUsablePrime` stays retired (both sides agree).
3. `scripts/axioms-controls.txt`: `main`'s state controls (`imported=120`, `121`) unchanged — this branch adds no imported record.
4. `scripts/assumptions-ledger.txt`: rewritten whole by `./scripts/assumptions.sh --write-ledger` on the merged build; this branch
   adds no `RESTS` or `TAKES` row, so `main`'s rows are expected unchanged.
5. `scripts/vacuity-baseline.txt`: the header's count line, from the merged gate's digest.
6. `ARCHITECTURE.md` and `Proofs.lean`: both sides' rows and import lines (the predecessor's aborted merge: no conflict there).

**The expected counts**, if each landing's records add independently: against the density gate (FS131-IFR2 on `b8cef1f36`,
`data/fs131/ifr2/gate/`), audit records 11,698 + 45 = **11,743**, clean 10,998 + 45 = **11,043**, axiom-free 575, imported 120,
purchases 5; vacuity `declarations=22683+45=22728`, `refutations-skipped=245+1=246`, `sites=1465` and its verdicts unchanged;
assumptions' nine counts `main`'s (`rests=168`), unchanged; dupnames' generated-on-demand count 31, unless the join makes a
shared `eq_n` or `congr_simp`. A difference from these is explained, not absorbed.

### 1.4 The order of work

1. **The merge**: `git merge main`; each gate-input conflict resolved keeping both sides; a conflict in a proof or a statement goes
   to the coordinator first. Commit the merge.
2. **The build**: before it, the name intersection of the two lines' compiled constants; the module cones of each side's changes,
   to choose which of `main`'s build files to copy (`main`'s compiled files are right for a module whose import closure holds no
   module this branch changed; this branch changed `Rigidity/AdmissiblePrime`, so the full copy would replace its build and its
   cone by builds of `main`'s private version — LEAN.md § Building, FS131-ICS1's line); the copy by checksum, a dry run first,
   checksum listings before and after; the build under the slot; a saved stage.
3. **The gate inputs** brought to the merged library (the audit block's coverage, `--write-ledger`, the vacuity header); the
   statement and axiom comparisons against the predecessor's gated prints and `main`'s; then the full gate
   (`data/fs131/iru2/run-gate.sh`, the steps of `data/fs131/clone1/run-gate.sh`) on one commit; `#print axioms` of the head
   statements. A saved stage.
4. **The drafts' counts.** A saved stage. The report.
