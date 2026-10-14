# FS131-LDB1 — the density bound `m₁(ℝ²) ≤ 0.2470` landed through the full gate

*de Bruijn, the implementer (Opus 5.5), 2026-10-14; job FS131-LDB1 (brief: `data/fs131/briefs/FS131-LDB1-landing.md`, on
`main`), with `plans/STANDING-RULES.md`. Branch `fs131-wldb`, cut from `fs131-wdb3` at `9fe574044` in the worktree
`.claude/worktrees/fs131-w10g`. Working files `data/fs131/ldb1/`; the gate's logs `data/fs131/ldb1/gate/`. "Std" is
`[propext, Classical.choice, Quot.sound]`. Resuming: read this file, check its last SAVED stage against `git log --
plans/FS131-LDB1-landing.md`, continue at the first stage not saved.*

## Theorems this phase proved

No new theorem is this job's: it lands the density bound (FS131-KDB1's statements; FS131-IDB1, -IDB2 and -IDB3's proofs)
through the gate. Its headline, as the four jobs left it, is `HadwigerNelson.Plane.oneAvoidingDensityBound :
Plane.OneAvoidingDensityBound` (`Plane/DensityBound/Theorem`) — `[AmbrusEtAl2023]` Theorem 1 — whose axioms the gate's
audit prints (stage 5).

## Stage 1 — SAVED (FS131-LDB1): the readback, and the dump before the merge

**1.1 The brief's quotations.** `tools/fs131_ldb1_readback.py` (FS133-LD1's reader with this job's brief, and the one
inline quotation, W6, added): **7 matched, 0 mismatched**, exit 0 (`data/fs131/ldb1/readback-brief.out`) — W2 and W6
against `data/fs131/REQUEST-2026-10-13.md`; the dated line of 2026-10-14 against `data/fs131/claims-NF2.md`; inventory
items 845, 866, 895 and 911 against `plans/FS131-close-inventory.md`, each read in the coordinator's tree. With `--fault`
(the last character of each quoted line changed): 0 matched, 7 mismatched, exit 1 (`readback-brief-fault.out`). No
finding about the brief's quotations.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole as it stands on `main` (§ Assumptions,
§ Trust ledger and § The gate among it); `RUNNING.md` § Building and § Make the gate fail; the last landing's record
(`plans/FS133-LD1-landing.md` on `main`, whole) and its pass script (`data/fs133/ld1/run-gate.sh`); FS131-IDB3's record
whole; the other three records' drafts as each is cited below. `main` stood at `7c8f9af82` when merged (the brief named
`dca30637f`; the three commits between touch only `data/fs131/briefs/`, `plans/FS131-close-inventory.md` and
`plans/SESSION-HANDOFF-2026-10-14.md`, none of which the gate reads).

**1.3 The trial merge** (`git merge-tree --write-tree --name-only HEAD main`, `data/fs131/ldb1/trial-merge.out`): exit 0,
**no conflict** — `ARCHITECTURE.md` and `Proofs.lean` merge by themselves. Since the merge base (`432c6f7cf`) this branch
adds 83 modules (`Plane/DensityBound/*`, `Plane/DensityBound/Cells/*`, `Plane/OneAvoidingDensity`) and edits
`ARCHITECTURE.md` and `Proofs.lean` only; `main` brings the port's 31 generated modules, `Outside/OAI158Collapse`, the
eight of the density equality, `Plane/LebesgueNumber`, `Plane/RadiusOutside`, and the gate's scripts
(`scripts/Axioms.lean`, `Assumptions.lean`, `assumptions-ledger.txt`, `axioms-controls.txt`, `vacuity-baseline.txt`).

**1.4 The build before the merge is current**: `lake build --no-build Proofs` under the slot reads `All targets
up-to-date (6096 jobs)`, exit 0 (`data/fs131/ldb1/nobuild-before.log`; 3.5 s, 0.88 GiB).

**1.5 Every constant of the density bound, from this tree's build, before the merge.**
`data/fs131/ldb1/lean/StatementDump.lean` (FS131-IDB3's dumper, its import made the headline's module and its count 83)
→ `statements-before.txt`: **83 modules, 4,083 constants** (kind, full name, stored type; a definition's value by hash),
exit 0 (5.1 s, 3.02 GiB). Its reader `tools/fs131_ldb1_statement_diff.py` (FS131-IDB3's, the count changed),
`--self-test` on this dump: the faithful copy 0 findings over 4,083 constants, each of the four plants FIRED, `SELF-TEST
PASS` (`statements-selftest.out`). **Faithful to the last implementer's**: the 56 modules of FS131-IDB3's dump after its
last build (`data/fs131/idb3/statements-after.txt`) are identical line for line to the same modules here
(`statements-vs-idb3.out`: 56 of 56; the 27 others are lane X's own).

**1.6 Noted for the coordinator, not this merge's**: `Plane/OneAvoidingDensity` came to this line from `fs131-wkr`
(`affb9142e`, "text unchanged"), and FS131-IDB2 proved its one leaf here. `fs131-wkr` (`3fabd5e10`) still holds the
file with its `sorry` (sha256 `b5f55c5e…` against this branch's `72b78784…`): wherever the chain's line carries that copy,
the join of the two lines meets the module twice at one path, and should keep this branch's.

## Stage 2 — SAVED (FS131-LDB1): the merge, the build, and one name both lines define

**2.1 The merge.** `git merge main` (`7c8f9af82`) — merge commit **`e2084c999`**, no conflict, exit 0
(`data/fs131/ldb1/merge.out`). Against `main` the merged tree differs outside `data/` and `plans/` only in this line's own
files: the 83 modules, `ARCHITECTURE.md`, `Proofs.lean`, and the earlier implementers' `tools/fs131_idb*`, `tools/fs131_kdb1_x23.py`.

**2.2 The build** (`data/fs131/ldb1/build-sampled.sh build-join`: the slot at 10 GiB and 4 cpus, `MEMMAX=10G BATCH=8`, with
FS131-LC1's sampler beside it): **`build: FAIL — 266 of 266 batches, 65 module(s) rebuilt, 0 module(s) with warnings,
13m43s`**, exit 1, 827 s (`data/fs131/ldb1/build-join.log`; Lake's full output `build/gate/build/20261014T193853Z-316136.log`;
sampler `build-join.mem`: largest single compiler 4.00 GiB, `Plane/OneClass/Fractional`). The 65 are `main`'s port, the density
equality's eight and their downstream; none of the density bound's 83 (their imports are unchanged). **The one failure is the
root**, twice (the script's retry): `error: Proofs.lean:1:0: import Proofs.HadwigerNelson.Plane.OneClass.Defs failed,
environment already contains 'HadwigerNelson.Plane.mOne' from Proofs.HadwigerNelson.Plane.OneAvoidingDensity`.

**2.3 The diagnosis.** Both lines define `HadwigerNelson.Plane.mOne`, in modules that do not import each other, so git merged
them in silence and Lean refuses the second definition at the first import that holds both (two definitions are refused even
when identical: `LEAN.md` § The gate, doubled names). The two are different terms for one number:
- this line's (FS131-KR1's, `Plane/OneAvoidingDensity` l. 40): `⨆ (A : Set ℂ) (_ : NullMeasurableSet A volume ∧ BandFree A
  0), upperDensity A` — Lebesgue-measurable sets;
- `main`'s (FS-133's, `Plane/OneClass/Defs` l. 189): `⨆ A, ⨆ (_ : MeasurableSet A), ⨆ (_ : (unitDistance ℂ).IsIndepSet A),
  upperDensity A` — Borel sets; `main`'s `mOne_eq_iSup_nullMeasurableSet` gives the same number over null-measurable sets.

**It is the only such name.** Every constant of `main`'s library without the density bound (`data/fs131/ldb1/lean/MainNames.lean`
→ `main-names.out`: 27,930 constants of the root's other imports, 24.7 s, 4.47 GiB) against the 4,083 of the 83 modules
(stage 1.5's dump): **one name in both, `HadwigerNelson.Plane.mOne`** (`collisions.out`). Removing or renaming either definition
is a definition change, which the brief does not give me: **messaged to the coordinator at once** (2026-10-14, about 20:00 UTC),
with option (a) — this line's `mOne` deleted, `Plane/OneAvoidingDensity` importing `Plane/OneClass/Defs`, the two corollaries
(`mOne_le_of_oneAvoidingDensityBound`, `mOne_lt_quarter`) unchanged in text and read over `main`'s `mOne`, proved through
`mOne_le_iff` and `isIndepSet_unitDistance_iff` — and option (b), a rename with an equality lemma. Every gate step after the
build waits on the ruling.

**2.4 Done meanwhile, none of it waiting on the root** (each from the compiled modules, which the failed root does not touch):
- **The audit's block** (`scripts/Axioms.lean`, CLEAN section, after FS133-LD1's block, banner "FS131-LDB1"): the three
  implementers' drafts filed unchanged — FS131-IDB1's 264 records, FS131-IDB2's 41, FS131-IDB3's 418, **723**, distinct
  (`data/fs131/ldb1/axioms-block.txt`). Their convention, kept: every public constant of the modules as the kernel stores
  them, inductive types, constructors and recursors left out (the structures' other generated declarations — `casesOn`,
  `noConfusion`, `mk.injEq`, … — kept as the drafts list them; FS133-LD1 filed none of those for its structures), the 847
  cell theorems and 847 cell definitions read through their parts' `segNN_ok`.
- **The prediction**, from the three implementers' printed axioms (`data/fs131/ldb1/prediction-axioms.txt`): of the 723, 400
  on a non-empty subset of the three and 323 axiom-free, none on anything else; so the audit at **9,824 records — 9,438
  clean, 355 axiom-free, 26 imported, 5 purchases**, the two declared imports unchanged.
- **The coverage** (`data/fs131/ldb1/lean/Coverage.lean` → `coverage-join.out`, 4.2 s, 3.02 GiB): 83 modules, 4,083
  constants, 2,490 public; 723 records, none absent; **every one of the other 1,767 public constants reached from a record**
  through stored types and values (so its axioms are inside a printed list); 0 unreached. Its control — the same rule with
  FS131-IDB3's 418 records taken out — reports all 418 and the 9 inductive types, constructors and recursors of lane X's three
  structures, 427, which is lane X's whole public surface (FS131-IDB3's count). A first version of the control removed
  records by name prefix (`…DensityBound.X23…`) and missed `dists_ok`, which reached 36 others; the control now removes
  exactly the drafted list.
- **The read-aloud's print** (`data/fs131/ldb1/lean/ReadAloud.lean` → `read-aloud.out`): the headline's stored type, the
  definitions it names, the corollaries, and their axioms (stage 3).
- **Tools written, each with its control seen to fire**: `tools/fs131_ldb1_records.py` (the records and the coverage; seven
  plants); `tools/fs131_ldb1_code_only.py` (the 83 files without block comments against `9fe574044`; before the docstring
  edits it reads the six files to be reworded as DIFFERS, "text untouched (listed)", exit 1 — the edit that has not happened
  is caught); `data/fs131/ldb1/docstring-edits.py` (dry run: ten replacements in six files, each old text found once) — not
  applied: one of the six is `Plane/OneAvoidingDensity`, which the ruling may change; `data/fs131/ldb1/run-gate.sh` (the
  final pass), `lint-plant.sh` (the lint's control on `Plane/DensityBound/Theorem`, a leaf).
- **Stale prose found** (for the edits): `OneAvoidingDensityBound`'s docstring says "External: a named hypothesis standing
  for an outside theorem, not proved in the library" — the assumptions step fails a former whose docstring says "named
  hypothesis" or "external" and that no entry declares (`FAIL undeclared-by-docstring`), so the rewording is needed for the
  gate, not only for the reader; the two corollaries say "given the outside theorem"; five module headers and
  `OneAvoidingDensity`'s say "skeleton".
