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

## Stage 3 — SAVED (FS131-LDB1): the ruling, the ruled edit, the build, and the join's gate steps

**3.1 The ruling** (the coordinator's message, and the brief's `## Amendment — 2026-10-14 19:56 UTC`, on `main`): option (a)
with a bridge. This line's `def mOne` deleted; `Plane/OneAvoidingDensity` imports `Plane/OneClass/Defs`;
`mOne_le_of_oneAvoidingDensityBound` and `mOne_lt_quarter` keep their text and read `main`'s `mOne`; one new theorem states
the deleted definition as an equality, its right-hand side the deleted definition's text verbatim. Touches extended to the
import line, the new theorem and the docstring's sentence on the definition in that file.

**3.2 The ruled edit** (commit `d09c6df27`, written in a copy first, `data/fs131/ldb1/work/OneAvoidingDensity.lean`):
- `import Proofs.HadwigerNelson.Plane.OneClass.Defs` added;
- `noncomputable def mOne : ENNReal := ⨆ (A : Set ℂ) (_ : NullMeasurableSet A volume ∧ BandFree A 0), upperDensity A`
  deleted, and in its place **the ruled new statement**
  `theorem mOne_eq_iSup_bandFree : mOne = ⨆ (A : Set ℂ) (_ : NullMeasurableSet A volume ∧ BandFree A 0), upperDensity A`
  — its right-hand side the deleted line 41 character for character — proved in nine lines from `main`'s
  `mOne_eq_iSup_nullMeasurableSet`, `iSup_and`, `isIndepSet_unitDistance_iff` and `ne_iff_lt_or_gt`, on the standard three
  (it needed no hypothesis);
- `mOne_le_of_oneAvoidingDensityBound`'s proof routed through it (`mOne_eq_iSup_bandFree ▸ iSup₂_le …`, the rest as it was);
  `mOne_lt_quarter`'s proof unchanged;
- the module docstring's sentence on the definition rewritten (`mOne` defined once, in `Plane/OneClass/Defs`, over Borel sets;
  the bridge states it over Lebesgue-measurable sets with `BandFree A 0`, the form this module first defined it by).

With it, the stale prose (`data/fs131/ldb1/docstring-edits.py`, ten replacements in six files, each old text found once):
`OneAvoidingDensityBound`'s docstring ("External: a named hypothesis standing for an outside theorem, not proved in the
library" → "Proved in the library: `oneAvoidingDensityBound` (`Plane/DensityBound/Theorem`), from the paper's certificate"),
the module header and its "An external theorem … a named hypothesis" sentence, the two corollaries' "given the outside
theorem", and "skeleton" in the headers of `Autocorr`, `Window`, `BesselDefect`, `Bessel` and `Pattern`.

**In text** (`tools/fs131_ldb1_code_only.py`, the 83 files with every block comment removed against `9fe574044`, the three
code edits listed; `data/fs131/ldb1/code-only.out`): **83 of 83 as listed** — 77 files untouched; the five headers reworded,
code the same; `OneAvoidingDensity` reworded, its code the base's with exactly the three listed edits. With `--plant` every
file DIFFERS (`code-only-plant.out`). Before the edits the same tool read the six files as "text untouched (listed)" and
failed — the control for an edit that did not happen.

**3.3 The build** (`build-sampled.sh build-fix`): **`build: OK — 264 of 264 batches, 12 module(s) rebuilt, 0 module(s) with
warnings, 8m28s`**, exit 0, 513 s (`data/fs131/ldb1/build-fix.log`; Lake's full output, 0 lines holding "warning"). The 12
are the six edited modules, `BesselCert`, `Cells/Covering`, `X23`, `X23Dist`, `Theorem` and the root — the predicted set
(`data/fs131/lc1/dependents.py`); none of the 46 cell parts and none of the 21 certificate check modules.

**3.4 Every constant of the density bound, after** (`StatementDump.lean`, now with a by-name section for `Plane.mOne` →
`statements-after-fix.txt`), against stage 1.5's dump, `tools/fs131_ldb1_statement_diff.py` with the ruled verdicts
(`statements-ruled-flags.txt`; `statements-fix-diff.txt`): **PASS, 0 differences over 4,083 constants**, and four ruled
readings:
- **`Plane.mOne` REDEFINED**: gone from the 83 modules; by name it is `Proofs.HadwigerNelson.Plane.OneClass.Defs`'s, stored
  type identical (`ENNReal`), value hash `3605416353 → 3350729776`. So the two corollaries' stored types, identical in text,
  now name `main`'s `mOne`: the change of constant the ruling asked shown.
- **`Plane.mOne_eq_iSup_bandFree` ADDED-RULED** (a theorem).
- **`DualCert.window_le` and `DualCert.limsup_le` INSTANCES-ONLY**, which the ruling did not name and the import brought:
  `Plane/OneClass/Defs` puts the port's `CommCStarAlgebra ℂ` in `Plane/DensityBound/Window`'s closure, and in the two stored
  types `NormedCommRing ℂ` is now `CommCStarAlgebra.toNormedCommRing ℂ instCommCStarAlgebraComplex` where it was
  `NormedField.toNormedCommRing ℂ Complex.instNormedField` — three places each, the rest of each type the same character for
  character. **The kernel's check** (`data/fs131/ldb1/lean/InstanceCheck.lean` → `instance-check.out`): each old type rebuilt
  from the new by replacing exactly that instance term, its hash **equal to the dump made before the merge**
  (3481863677, 2608129148); `Eq.refl new : old = new` **accepted by the kernel** for both (`Environment.addDeclCore`); the
  control, one theorem's old type against the other's new type, **refused**; the two instance terms equal by `rfl` in the
  kernel. Sent to the coordinator as a notice.
- Every other stored type and definition value identical. Unruled, the same comparison fails on exactly these five
  (`statements-fix-unruled.txt`: REMOVED `mOne`, ADDED public bridge, TYPE ×2 — before the instances verdict existed).
  The ruled verdicts' plants (`--controls`, `statements-fix-controls.txt`): eight, each FIRED — the redefined constant left in
  the modules, found in another module, absent by name, its type changed, its value the old one; the ruled addition missing;
  an instances-only type changed elsewhere too; one moved to another instance — and the unplanted text passes. The reader's
  own four plants pass as before (`--self-test`).

**3.5 The join's gate steps, each on this build** (the final pass, stage 5, runs them again on one commit):
- **doubled names** (`dupnames-join.log`): "dupnames: OK — no name is declared by two modules (26 generated on demand)" —
  `mOne` once.
- **axioms** (`axioms-join.log`, receipt `receipt-axioms-join.log`): **"audited: 9824 records — 9438 clean on the standard
  axioms, 355 axiom-free, 26 imported (resting on a declared outside theorem), 5 declared purchase(s)"**, "axioms: OK" —
  stage 2.4's prediction, each count. Its first run read "audited more than once: HadwigerNelson.Plane.mOne": FS131-IDB2's
  block listed this line's `mOne` and FS133-LD1's block lists `main`'s, now one constant. The block's `Plane.mOne` record is
  replaced by the bridge's (`scripts/Axioms.lean`, with a comment; the counts are unchanged by the swap, both on the three).
- **coverage and records** (`coverage-join.out`, `records-join.txt`): **"records: PASS"** — the 723 records each once under
  CLEAN on a subset of the three, 400 and 323; the headline on exactly the three; IMPORTED 26 = 20 + 6; 9,824 records, none
  twice; the coverage 83 modules, 4,084 constants, 2,490 public = 723 records + 1,767 reached, 0 unreached, the control 418
  of 418. Its seven plants each FAILED, as they must (`records-plant-join.txt`).
- **vacuity** (`vacuity-join.log`, receipt `receipt-vacuity-join.log`): **"scanned: declarations=20563
  refutations-skipped=234"**, **"sites: sites=1454 vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2"**,
  "vacuity: OK" — the prediction written before it ran (`prediction-vacuity.txt`: the counter's 20,563 = 17,902 + 2,662 − 1,
  the −1 a generated-on-demand theorem, `MeasureTheory.Measure.addHaar.congr_simp`, now attributed to Mathlib's
  `Analysis.Calculus.BumpFunction.FiniteDimension`, which the density bound brings into the closure). Against the last
  landing row for row (`tools/fs131_l5_vacdiff.py`, `vacdiff-join.txt`): **"vacdiff: PASS"**, no row lost or added, "by
  module: declarations +2661, refutations +0: equal to the scans difference" — `Arith.StationaryRatio` −1,
  `OAI158Palette` −1 and `OAI158BoundedFunctions` +1 (`measureUnivNNReal.eq_1` re-attributed), the 83 modules +2,662. The
  baseline's header count line refiled on this branch (17902 → 20563; its entries unchanged); `CLAUDE.md` § The gate is a
  draft.
- **assumptions** (`assumptions-join.log`): one failure, **`FAIL undeclared-never-concluded
  HadwigerNelson.DensityBound.DualCert.IsIndep`** — taken by `X23Check.X23_atoms`, concluded by no theorem. It is a
  condition on the theorem's own set `S` ("`S` is independent in the unit-distance graph on the certificate's points"), so it
  is declared one, by `LEAN.md` § The gate's rule: `.condition ``HadwigerNelson.DensityBound.DualCert.IsIndep "…"` in
  `AssumptionAudit.declared` (`scripts/Assumptions.lean`). With it (`assumptions-join2.log`, receipt
  `receipt-assumptions-join2.log`): **"assumptions: OK — 2 outside theorem(s) as axioms, with 27 theorem(s) resting on them;
  19 named and 14 inline hypotheses (7 outside, 21 ours, 5 open), taken by 102 statement(s) and mentioned by 1"**; the
  ledger's header and `CLAUDE.md` § Trust ledger "match (9 of 9 compared)" — the nine counts unchanged; conditions 41 → 42.
  `OneAvoidingDensityBound`'s three closed takers (`upperDensity_le_of_…`, `mOne_le_of_…`, `mOne_lt_quarter`) read
  **`CLOSED ESTABLISHED`**: the library proves the hypothesis they take. With its docstring as FS131-KR1 wrote it ("named
  hypothesis", "External") the step would have failed it as `undeclared-by-docstring`.
- **the guarded lint** (`lint-join.log`): exit 0, "-- Linting passed for Proofs.", 14 linters "(2/2) Passed!".
- **the sorry search's plant** (`sorry-plant.out`): the narrow pattern finds the three forms appended to a copy of
  `Plane/DensityBound/Theorem.lean`, and 0 lines in the module.
- **the generators**, each rewriting its modules in place (`gen-x23-pre.txt`, `gen-cells-chain-pre.txt`,
  `gen-cells-modules-pre.txt`): `tools/fs131_kdb1_x23.py --write` (5.8 s) and `tools/fs131_idb1_cells.py chain` then
  `modules` (about 1 s each) — **no tracked file changed** (`git status`): the 23 certificate modules, `summary.json`, the 48
  covering modules and `Chain.lean` are each the generator's output byte for byte. Neither generator has a `--check` mode;
  this rewrite-and-compare is that check. `Chain.out` (the compiled evaluator's run of the chain) was not recomputed.

## Stage 4 — SAVED (FS131-LDB1): read aloud

*The headline as the kernel stores it — `#check`/`#print` from the built tree (`data/fs131/ldb1/lean/ReadAloud.lean` →
`data/fs131/ldb1/read-aloud.out`, run again on the final build, stage 5) — against `[AmbrusEtAl2023]` Theorem 1, read by me
this job from the held v3 (`~/source/library/pdf/arXiv-2207.14179-…pdf`, sha256 `12850eb7…`, FS131-IDB3's; `pdftotext
-layout`, pp. 2 and 4).*

**The paper, word for word.** Theorem 1 (p. 4): "Any Lebesgue measurable, 1-avoiding planar set has upper density at most
0.2470." Its definitions (p. 2): "A set A ⊂ Rd which is independent in the unit distance graph is said to avoid unit
distances, or to be 1-avoiding or unit-distance free. Assume that A ⊂ Rd is measurable. The upper density of A, denoted by
δ(A), is defined by δ(A) = lim sup_{R→∞} λd(A ∩ Bd(x, R)) / λd(Bd(x, R)), where x ∈ Rd is fixed, λd is the d-dimensional
Lebesgue measure, and Bd(x, R) denotes the d-dimensional ball of radius R centered at x. The definition is valid since the
upper density is known to be independent of the choice of x ∈ Rd."

**The library, as stored.** `HadwigerNelson.Plane.oneAvoidingDensityBound : HadwigerNelson.Plane.OneAvoidingDensityBound`,
on `[propext, Classical.choice, Quot.sound]`, no hypothesis; the definition it names, as stored:
`∀ (A : Set (EuclideanSpace ℝ (Fin 2))), MeasureTheory.NullMeasurableSet A MeasureTheory.volume → (∀ a ∈ A, ∀ b ∈ A, dist a
b ≠ 1) → ∀ (x : EuclideanSpace ℝ (Fin 2)), Filter.limsup (fun (R : ℝ) => MeasureTheory.volume (A ∩ Metric.ball x R) /
MeasureTheory.volume (Metric.ball x R)) Filter.atTop ≤ ENNReal.ofReal 0.2470`.

**Clause by clause.** "planar set" — `A : Set (EuclideanSpace ℝ (Fin 2))`, the Euclidean plane; "Lebesgue measurable" —
`NullMeasurableSet A volume`, `volume` the Lebesgue measure of `EuclideanSpace ℝ (Fin 2)` (null-measurable for Lebesgue
measure is Lebesgue measurability: `LEAN.md` § Searching — Lean); "1-avoiding", independent in the unit-distance graph — `∀ a
∈ A, ∀ b ∈ A, dist a b ≠ 1` (for `a = b` the distance is `0`, so the clause asks no more than independence); "upper density"
— the `limsup` as `R → ∞` of `vol(A ∩ B(x, R)) / vol(B(x, R))` in `ℝ≥0∞`, `B(x, R)` the open ball (the closed ball differs by a
null sphere); "at most 0.2470" — `≤ ENNReal.ofReal 0.2470`. **The centre**: the paper fixes one `x` and states that the value
does not depend on it; the library states the bound at every `x` (`∀ x`), which is the paper's statement read at each centre
it allows, and so asks no help from the independence fact. **No word of the sentence is missing from the statement, and the
statement adds none**: it says what Theorem 1 says.

**The three places the library asks for less** (FS131-IDB2's reading, its record § Stage 4, read again here against the
same pages). They are in the route theorem `DualCert.oneAvoidingDensityBound_of : ∀ {n} (C : DualCert n), C.Valid → ∀ {w0 mu
: ℝ}, mu < 1 → (∀ t, 0 ≤ t → 1 - mu ≤ C.phi w0 t) → C.bound / (1 - mu) ≤ 0.2470 → OneAvoidingDensityBound` (Proposition 1 in
finite-window form), whose hypotheses `X23_valid`, `X23_phi` and `X23_ratio` discharge for the paper's certificate; asking
less there makes the route theorem stronger and leaves the headline the paper's:
1. **Atoms.** The paper asks `V(ε) ≥ 0` for every `ε ∈ σ(n)` (eq. (20), p. 16); `Valid.atoms` asks `L S ≤ bound` only for
   non-empty independent `S`, with `bound ≥ 0` (`Valid.bound_nonneg`) for `S = ∅` — `V = bound − L(S)` term for term.
2. **Congruent pairs.** The paper's `C(X)` (p. 9) asks `I ≠ J`; `Valid.cong` does not.
3. **`ϕ`.** The library asks `ϕ ≥ 1 − µ` on all of `[0, ∞)` (one hypothesis), where the paper shows `ϕ(t) > 1 − µ` on `[0, T]`
   and `ϕ(t) > 1` past `T` (p. 18): the paper's two facts imply the library's one, which asks nothing past `T` beyond
   `1 − µ`.

**The certificate is the paper's**: `ν = 10⁻⁵` (p. 16) and `µ = 6·10⁻⁵` (p. 18), so `X23.bound/(1 − µ) = 0.24699745… ≤
0.2470` (`X23_ratio`, the paper's p. 19 "(wT + ν)/(1 − µ) = 0.24699 … < 0.2470"); Table 1 is the notebook's point list and
Table 2 is `g23.csv`, exactly (FS131-IDB3 § 2.2). One misprint of the paper, not material: p. 18's "J0′(t) = J1(t)" is
`−J1(t)` (`Bessel.hasDerivAt_J0`); the proof reads only `|J0′|`.

**The corollaries, after the ruling.** `Plane.mOne_le_of_oneAvoidingDensityBound : OneAvoidingDensityBound → mOne ≤
ENNReal.ofReal 0.2470` and `Plane.mOne_lt_quarter : OneAvoidingDensityBound → mOne < ENNReal.ofReal (1 / 4)`, each on the
standard three, over the one `Plane.mOne` of `Plane/OneClass/Defs`, `⨆ A, ⨆ (_ : MeasurableSet A), ⨆ (_ : (unitDistance
ℂ).IsIndepSet A), upperDensity A`, `upperDensity` the `limsup` along discs about `0` (`Plane/Suprema`); the ruled bridge
`Plane.mOne_eq_iSup_bandFree : mOne = ⨆ (A : Set ℂ) (_ : NullMeasurableSet A volume ∧ BandFree A 0), upperDensity A`
(standard three) is the same number over Lebesgue-measurable sets, `BandFree A 0` being no pair at distance exactly `1`.
**With no hypothesis**, `m₁(ℝ²) ≤ 0.2470` and `m₁(ℝ²) < 1/4` are the terms `mOne_le_of_oneAvoidingDensityBound
oneAvoidingDensityBound` and `mOne_lt_quarter oneAvoidingDensityBound` (the second `#check`ed in `read-aloud.out`): the
library holds them, and no declaration states them closed — a front-page sentence should name them as the application.
With `main`'s `OneClass.one_seventh_le_mOne` and `Plane.mOne_le_one`, the kernel holds `1/7 ≤ m₁(ℝ²) ≤ 0.2470` on one
constant.

**Nothing to message**: the statement says what the paper's sentence says. **Whose it is**: the theorem and its certificate
are `[AmbrusEtAl2023]`'s; the finite-window route (no periodic reduction, no Bessel citation: `J₀` by its integral, its ODE
and the antitone `‖J₀ + iJ₁‖`), the formalization and the kernel check are this project's (FS131-KDB1, -IDB1, -IDB2,
-IDB3; this landing).
