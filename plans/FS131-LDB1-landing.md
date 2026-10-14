# FS131-LDB1 — the density bound `m₁(ℝ²) ≤ 0.2470` landed through the full gate

*de Bruijn, the implementer (Opus 5.5), 2026-10-14; job FS131-LDB1 (brief: `data/fs131/briefs/FS131-LDB1-landing.md`, on
`main`), with `plans/STANDING-RULES.md`. Branch `fs131-wldb`, cut from `fs131-wdb3` at `9fe574044` in the worktree
`.claude/worktrees/fs131-w10g`. Working files `data/fs131/ldb1/`; the gate's logs `data/fs131/ldb1/gate/`. "Std" is
`[propext, Classical.choice, Quot.sound]`. Resuming: read this file, check its last SAVED stage against `git log --
plans/FS131-LDB1-landing.md`, continue at the first stage not saved.*

## Theorems this phase proved

One theorem is this job's, the ruled bridge; the rest it lands through the gate on `7a2acfef8` (FS131-KDB1's statements;
FS131-IDB1, -IDB2 and -IDB3's proofs). Each **[kernel]**, its axioms as the gated audit prints them
(`data/fs131/ldb1/gate/receipt-axioms-final.log`; all 723 records of the block on a subset of the standard three):
- `HadwigerNelson.Plane.mOne_eq_iSup_bandFree : mOne = ⨆ (A : Set ℂ) (_ : NullMeasurableSet A volume ∧ BandFree A 0),
  upperDensity A` (`Plane/OneAvoidingDensity`) — **this job's, a ruled new statement** (the brief's Amendment):
  `[propext, Classical.choice, Quot.sound]`.
- `HadwigerNelson.Plane.oneAvoidingDensityBound : Plane.OneAvoidingDensityBound` (`Plane/DensityBound/Theorem`) —
  `[AmbrusEtAl2023]` Theorem 1, landed: `[propext, Classical.choice, Quot.sound]`.
- `HadwigerNelson.Plane.mOne_le_of_oneAvoidingDensityBound`, `HadwigerNelson.Plane.mOne_lt_quarter` (`Plane/OneAvoidingDensity`)
  — now over `main`'s `Plane.mOne`, their proofs through the bridge: each `[propext, Classical.choice, Quot.sound]`.
- `HadwigerNelson.DensityBound.DualCert.oneAvoidingDensityBound_of` (`Plane/DensityBound/Window`), the route; `X23_valid`,
  `X23_phi`, `X23_ratio`, `X23_close`, `BesselCert.Cells.phiApprox_ge` — landed, each on the three.

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

## Stage 5 — SAVED (FS131-LDB1): the full gate on one commit — `7a2acfef8` — green on its first pass

One pass ran every step in order, one at a time, under the slot (`data/fs131/ldb1/run-gate.sh final 7c8f9af82 8`, FS133-LD1's
pass with this landing's steps, launched from a snapshot copy, `build/ldb1-run-gate-snapshot.sh`). Every log is under
`data/fs131/ldb1/gate/` with its exit status on its last line; `run-pass-final.out` holds every step's exit,
`measure-final.txt` every step's wall time and memory (the scope's charged peak and the largest process's resident set, by
FS131-LJ1's `in-scope.sh`), and `run-gate-final.head` the commit, **`7a2acfef820bbbbccebe8fc290d84139aeb87934`**, with **no
tracked file modified at its start and none after it** ("tracked files modified after the pass: 0"). **Every step exited 0
but the two controls that must exit 1** (the scan difference's plants; the statement comparison without the ruled
verdicts). Before the pass: the lint's planted control (stage 3's commit `7a2acfef8`'s parent tree, `lint-plant-run.out`:
"LINT CONTROL FIRED: exit 1, the plant named" — `synTaut` and `unusedArguments` each "(2/2) Failed with 1 messages", both at
`Theorem.lean:75:1 … @zz_ldb1_lint_plant`; "RESTORED: the module is the text it was"), and the sorry search's plant (stage
3.5). Every count below is read from the saved logs.

| step | result, read from its saved log (`data/fs131/ldb1/gate/<step>-final.*`) | wall | peak / max-rss |
|---|---|---|---|
| build (`BATCH=8`, `--mem 10 --cpus 4`) | "build: OK — 264 of 264 batches, 2 module(s) rebuilt, 0 module(s) with warnings, 7m16s" (`Plane/DensityBound/Theorem`, restored after the lint's control, and the root); the one log line holding "warning" is that sentence; Lake's full log has 0; then `lake build --no-build Proofs`: "All targets up-to-date (6278 jobs)" | 490 s (slot wait included) | sibling scopes; 0.88 GiB the up-to-date check |
| `sorry` | the narrow pattern over `Proofs/` and `Proofs.lean`: **0** lines; `\bsorry\b`: 55, every one prose, FS133-LD1's 55 in the same files with the same counts (none in the 83 modules); the plant fired before the pass (`sorry-plant.out`) | — | — |
| `axiom` lines in `Proofs/` | 3 line-initial — `main`'s three (`no_proper_five_coloring`, `kloosterman_bound`, one line of a docstring's code block); `native_decide` in no file of the density bound (`native-density-final.txt`: 0) | — | — |
| doubled names, before the audit | "dupnames: OK — no name is declared by two modules (26 generated on demand, listed above)"; its self-test "OK — all 15 controls behaved" | 5.4 s; 27 s | 0.54 / 4.50 GiB; 0.67 / 1.53 |
| axioms | "audited: 9824 records — **9438 clean** on the standard axioms, **355 axiom-free**, **26 imported** (resting on a declared outside theorem), **5 declared purchase(s)**"; "declared imports (2): HadwigerNelson.StandingFive.kloosterman_bound, HadwigerNelson.Outside.OAI158.no_proper_five_coloring"; "axioms: OK"; nothing audited twice; `CLAUDE.md` § Trust ledger flagged stale, "9038 clean → 9438" (draft 1) | 13 s | 1.29 / 5.13 |
| its self-test | "axioms self-test: OK — every planted fault fired, and every partner passed." (23 controls) | 273 s | 1.50 / 5.37 |
| coverage and records (`Coverage.lean`, `tools/fs131_ldb1_records.py`) | coverage "MODULES 83", "CONSTANTS 4084 PUBLIC 2490", "RECORDS 723 ABSENT 0", "REACHED 1767", "CONTROL-REMOVED 418", no `UNREACHED`; "records: PASS" (eleven checks: the 723 each once under CLEAN, 400 + 323 as predicted, the headline on exactly the three, IMPORTED 26 = 20 + 6, 9,824 records none twice, the coverage and its control 418 of 418, 427 in all); its seven plants each "FAILED (as it must)" | 2.9 s; 0.5 s | 0.46 / 3.67 |
| the generators | `tools/fs131_ko1_port.py --check` on the port's 31: **CHECK OK**; `tools/fs131_idb1_cells.py chain` and `modules` and `tools/fs131_kdb1_x23.py --write`, each rewriting its modules in place: "count=0" tracked files changed (`gen-identical-final.txt`) — the 48 covering modules, the 23 certificate modules, `Chain.lean` and `summary.json` byte for byte | 0.7 s; 0.9 s, 1.0 s; 5.5 s | — |
| vacuity | "scanned: **declarations=20563 refutations-skipped=234**"; "sites: **sites=1454 vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2**"; "vacuity: OK"; the baseline's header "match (9 of 9 compared)"; `CLAUDE.md` § The gate flagged stale, "declarations 17902 → 20563" (draft 2) | 142 s | 0.60 / 4.65 |
| the scan against FS133-LD1's, row for row (`tools/fs131_l5_vacdiff.py`) | the counter (`count-modules-final.out`: "TOTAL declarations=20563 refutations=234") agrees with both scans; "main rows 1535, landing rows 1535; lost 0 (0 with a removed declaration); added 0"; "by module: declarations +2661, refutations +0: equal to the scans difference" — the 83 modules +2,662, `Arith.StationaryRatio` −1, `OAI158Palette` −1, `OAI158BoundedFunctions` +1 (two generated-on-demand theorems re-attributed, stage 3.5); "vacdiff: PASS"; its plants "vacdiff: FAIL (5)", exit 1, as they must | 0.1 s | — |
| its self-test | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent." | 151 s | 0.61 / 4.66 |
| assumptions | "assumptions: OK — 2 outside theorem(s) as axioms, with **27** theorem(s) resting on them; 19 named and 14 inline hypotheses (7 outside, 21 ours, 5 open), taken by 102 statement(s) and mentioned by 1"; "decided: … conditions=42 fails=0"; the ledger's header and `CLAUDE.md` § Trust ledger "match (9 of 9 compared)" | 132 s | 0.68 / 4.72 |
| its self-test | "OK — all 33 checks behaved: every planted fault fired, and every partner stayed silent." | 131 s | 0.70 / 4.74 |
| architecture | "RESULT: PASS" (with the imports cell of `Plane/OneAvoidingDensity`, the one the ruled import required) | 4.1 s | — |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!"; its control red before the pass | 17 s | 1.42 / 5.16 |
| notes, as the last landing ran them | "notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58", FS133-LD1's count; "self-test: OK (6 controls, 1 planted)" | 3.8 s | — |
| the stored statements (stage 1.5's dump against this one) | the dump "## MODULES 83", byte for byte stage 3.4's (one sha256, `056b93a2…`); `tools/fs131_ldb1_statement_diff.py` with the ruled verdicts: **"PASS"**, "checked 4083 constants of the base dump; 0 differences" — `Plane.mOne` REDEFINED (now `Plane/OneClass/Defs`'s, type identical), `DualCert.window_le` and `limsup_le` INSTANCES-ONLY (3 instance arguments each), `Plane.mOne_eq_iSup_bandFree` ADDED-RULED; its eight ruled plants "CONTROLS PASS"; unruled "FAIL" on exactly those four (exit 1, as it must); its self-test "SELF-TEST PASS" | 5.2 s; 0.1 s | 0.46 / 3.66 |
| the instance-only moves, by the kernel (`InstanceCheck.lean`) | both old types rebuilt "MATCH" the dump before; "KERNEL-OK … Eq.refl new : old = new" for both; "CONTROL REFUSED (as it must be)"; "INSTANCES KERNEL-OK" | 2.7 s | 0.46 / 3.66 |
| the 83 files in text, block comments removed, against `9fe574044` | "files read: 83; as listed: 83" — six reworded, `OneAvoidingDensity`'s three listed code edits; the plant DIFFERS in all 83 | 2.5 s | — |
| the baseline and the scans' sources against `main`'s | baseline entries unchanged (2); lines that differ: `scripts/Axioms.lean` 750 (the block and its banner), `scripts/Assumptions.lean` 1 (the `.condition`), `scripts/vacuity-baseline.txt` 2 (the header's count line); every other script and the scans' own sources 0 | — | — |
| the three digests against FS133-LD1's receipts (`data/fs133/ld1/gate/receipt-*-final.log`) | **axioms**: 723 rows added, 0 removed; stale: `CLAUDE.md` § Trust ledger's "9038 clean" (and with it the sentence's 9,101 records and 32 axiom-free). **vacuity**: "counts: declarations 17902 → 20563", "rows: none changed"; stale: `CLAUDE.md` § The gate's count line. **assumptions**: four rows added — `CLOSED ESTABLISHED` for the three takers of `Plane.OneAvoidingDensityBound` and `CONDITION HadwigerNelson.DensityBound.DualCert.IsIndep`; the scan's own counts up by the density bound (constants 17057 → 19661, theorems 12888 → 14299, formers 386 → 406, conditions 41 → 42, established 1435 → 1438); the nine counts unchanged; nothing stale | — | — |

**Predicted before the run, against it.** The audit at 9,824 records — 9,438 clean, 355 axiom-free, 26 imported, 5 purchases —
with 2 declared imports (stage 2.4, from the implementers' printed axioms); the vacuity scan at declarations 20,563,
refutations 234, sites 1,454 and every site count unchanged (stage 3.5's `prediction-vacuity.txt`, with the −1 named before
the scan ran); the nine assumption counts unchanged. **Met, each count.** (The brief's dated counts were `main`'s; the first
build's failure, stage 2, is not a count.)

**The headline, read again on this build** (`read-aloud.out`, after the pass): `HadwigerNelson.Plane.oneAvoidingDensityBound
: HadwigerNelson.Plane.OneAvoidingDensityBound`, "depends on axioms: [propext, Classical.choice, Quot.sound]"; `Plane.mOne`
printed as `main`'s Borel supremum; `Plane.mOne_eq_iSup_bandFree` with the deleted definition's right-hand side, on the
three; `Plane.mOne_le_one` and `OneClass.one_seventh_le_mOne` on the same constant. Stage 4's reading holds as written.

**What the gate shows, and what it does not.** It shows: no `sorry` and no `axiom` enters `Proofs/`; the library declares the
same two axioms as before; every one of the block's 723 records is audited on the three or fewer, and every other public
constant of the 83 modules is reached from one; no name is declared twice, so each printed list is the list of the proof the
kernel checked; across the merge no stored statement of the density bound moved but the ruled ones (`mOne`'s home, the
bridge) and two instance-only moves the kernel accepts as `rfl`. It does not show: that the result is new (it is not: the
theorem is `[AmbrusEtAl2023]`'s); any value of `m₁(ℝ²)`; anything the independent kernel replay would add (`lean4checker`
not run).

## Drafts for the front page (FS131-LDB1)

*For the coordinator to file; this job files none of them. Each draft names its slot: the file, the section, and the exact
words it replaces or follows. `data/fs131/ldb1/drafts-slots.py` checks that each slot occurs exactly once (on `main` for
the front files, on this branch for the `ARCHITECTURE.md` rows, whose imports cell the gate required here;
`data/fs131/ldb1/drafts-slots.out`: 25 slots, each once, the control absent; the same check at `9fe574044`, before the
merge, fails on 10 slots — `drafts-slots-plant.out`). Each count names the log line it comes from; the gated commit and its
logs are stage 5 (`data/fs131/ldb1/gate/*-final.*`; the scans' full outputs `receipt-axioms-final.log`,
`receipt-vacuity-final.log`, `receipt-assumptions-final.log`).*

**Whose it is.** The theorem is `[AmbrusEtAl2023]`'s — Theorem 1 and its certificate (Table 1, Table 2, the notebook's
points, `g23.csv`), used unchanged. The finite-window route (no periodic reduction, no Bessel citation), the formalization
and the kernel check are this project's: FS131-KDB1's statements and plan, FS131-IDB1's covering and Bessel lemmas,
FS131-IDB2's Fourier side, patterns and window, FS131-IDB3's certificate instance, and this landing. No value of
`χ(ℝ²)` moves; `m₁(ℝ²) ≤ 0.2470` is a known bound, and the kernel proof is new.

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 9038 clean and 5 declared
purchases, and 26 imported (and 32 axiom-free; 9,101 records at the landing of FS-133's density equality, FS133-LD1,
2026-10-14)". From `axioms-final.log`, "audited: 9824 records — 9438 clean on the standard axioms, 355 axiom-free, 26
imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 9438 clean and 5 declared purchases, and 26 imported (and 355 axiom-free; 9,824 records at the
> landing of the density bound, FS131-LDB1, 2026-10-14)

9,101 + 723 = 9,824 (the block's records, stage 2.4); clean 9,038 + 400 = 9,438; axiom-free 32 + 323 = 355; imported and
purchases unchanged.

**2. `CLAUDE.md` § The gate, the vacuity scan's counts.** *Replaces* "`declarations=17902 refutations-skipped=234
sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`." From `vacuity-final.log`, "scanned:
declarations=20563 refutations-skipped=234" and "sites: sites=1454 vacuous=0 stale=0 declared=3 witnessed=38
generic=1411 unknown=2":

> `declarations=20563 refutations-skipped=234 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`.

One count moves: declarations +2,661 — the 83 modules' 2,662, less one generated-on-demand theorem
(`MeasureTheory.Measure.addHaar.congr_simp`) that the joined closure attributes to a Mathlib module (stage 3.5; the scan
difference, module by module, `vacdiff-final.txt`). No site is added: the density bound's binders are no tracked carrier.
The baseline's header is refiled on the branch.

**3. `CLAUDE.md` § Trust ledger, the nine counts.** *No change.* `receipt-assumptions-final.log`'s totals read `axioms=2
rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1`, and the step reports "recorded counts in
CLAUDE.md § Trust ledger: match (9 of 9 compared)". The density bound adds no axiom and no declared hypothesis: it adds one
`.condition` (`DensityBound.DualCert.IsIndep`, stage 3.5), which no count reads, and it discharges a hypothesis no entry
declared — `Plane.OneAvoidingDensityBound`, taken by three theorems that now read `CLOSED ESTABLISHED`.

**4. `CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval".** *Follows* "anything at a number
field's plane or at six colours; that the result is new (`[Davies2026]`). The kernel proof is this project's;" *with*

> **the density bound** (FS-131, FS131-LDB1): every Lebesgue-measurable planar set with no two points at distance one has
> upper density at most `0.2470`, at every centre (`[AmbrusEtAl2023]` Theorem 1; `Plane.oneAvoidingDensityBound`), so
> `m₁(ℝ²) ≤ 0.2470` and `m₁(ℝ²) < 1/4` with no hypothesis (`Plane.mOne_le_of_oneAvoidingDensityBound` and
> `Plane.mOne_lt_quarter` applied to it), on the density equality's one `Plane.mOne` (its Lebesgue form
> `Plane.mOne_eq_iSup_bandFree`) — so the kernel holds `1/7 ≤ m₁(ℝ²) ≤ 0.2470`; proved from the paper's certificate,
> unchanged, by a finite-window route with no periodic reduction and no Bessel citation, the certificate's 2,321
> congruences, 13,552 independent atoms, 847 cells of the `J₀` covering and 27 distances checked by `decide +kernel` in
> core-only modules, with no `native_decide`; on the standard three axioms. The theorem is `[AmbrusEtAl2023]`'s; the route,
> the formalization and the kernel check are this project's;

**4b. The same sentence's density-equality clause.** *Replaces* "Not claimed: any value of `m₁(ℝ²)` beyond `1/7 ≤
m₁(ℝ²)`, or of a chromatic number;" *by* "Not claimed: any value of `m₁(ℝ²)` beyond `1/7 ≤ m₁(ℝ²) ≤ 0.2470` (the upper
end the density bound's, below), or of a chromatic number;".

**5. `CLAUDE.md` § Frontier, Last filed.** *Replaces* "Last filed: **the landing of FS-133, the density equality**
(FS133-LD1, 2026-10-14:" *by*

> Last filed: **the landing of the density bound** (FS131-LDB1, 2026-10-14: `Plane/DensityBound` and
> `Plane/OneAvoidingDensity` through the gate on the standard three axioms — 83 modules, 723 records;
> `Plane.oneAvoidingDensityBound`, `[AmbrusEtAl2023]` Theorem 1, `m₁(ℝ²) ≤ 0.2470`, from the paper's certificate with no
> periodic reduction and no Bessel citation; `Plane.mOne` defined once, the density equality's, the line's own deleted at the
> join with the bridge `Plane.mOne_eq_iSup_bandFree` (the coordinator's ruling); other people's theorem, the kernel proof
> ours; no value moved); before it **the landing of FS-133, the density equality** (FS133-LD1, 2026-10-14:

**6. `LEDGER.md` row 129, its grade note.** *Replaces* "the interval `[4.04876, 4.35987]` for `1/m₁(ℝ²)` is the
literature's (`[AmbrusEtAl2023]` Theorem 1; Croft's set), not the kernel's, which holds `1/7 ≤ m₁(ℝ²) ≤ 1`" *by*

> the interval `[4.04876, 4.35987]` for `1/m₁(ℝ²)` is the literature's (`[AmbrusEtAl2023]` Theorem 1; Croft's set); the
> kernel holds `1/7 ≤ m₁(ℝ²) ≤ 0.2470` — the upper end `[AmbrusEtAl2023]` Theorem 1 itself, **[kernel]** since FS131-LDB1
> (`Plane.oneAvoidingDensityBound`, with `Plane.mOne_le_of_oneAvoidingDensityBound`; standard three), so `1/m₁(ℝ²) ≥
> 1/0.2470 > 4.0485` there, short of the interval's `4.04876` (the paper's computed `0.24699…`)

The row's own claims keep their grades: the plane's clause is [kernel] already (FS133-LD1); the field form is given MR.

**7. `LEDGER.md` row 92, its real places.** *Replaces* "at every real place it rests on `[AmbrusEtAl2023]` Thm 1,
`m₁(ℝ²) ≤ 0.2470` — external, computer-assisted, published;" *by* "at every real place it rests on `[AmbrusEtAl2023]` Thm 1,
`m₁(ℝ²) ≤ 0.2470` — published, and a kernel theorem since FS131-LDB1 (`Plane.oneAvoidingDensityBound`, standard three);".
The row's grade is not raised by this: it rests on more than the bound.

**8. `LEDGER.md` row 112, its inputs.** *Replaces* "`[AmbrusEtAl2023]` Thm 1 (its certificate re-checked, cert + hand: J26
exact, J49 ball arithmetic; `m₁(ℝ²) ≤ 0.246989`)" *by* "`[AmbrusEtAl2023]` Thm 1 (its certificate re-checked, cert + hand:
J26 exact, J49 ball arithmetic; `m₁(ℝ²) ≤ 0.246989`; `m₁(ℝ²) ≤ 0.2470` a kernel theorem since FS131-LDB1,
`Plane.oneAvoidingDensityBound`)". The row's grade is not raised: it rests on more.

**9. `ARCHITECTURE.md`, the rows' prose** (on this branch: the imports cell of `Plane/OneAvoidingDensity` was the gate's and
is done; the rest is the filing's).
- *(a) the row of `Plane/OneAvoidingDensity`*, its description cell (head "**FS-131 (FS131-KR1), skeleton: 1 leaf
  `sorry`.**", to the cell's end "`mOne_lt_quarter`.") *replaced by* "**FS-131 (FS131-KR1's statements, the leaf FS131-IDB2's;
  landed by FS131-LDB1; no `sorry`).** Module M12's input: `OneAvoidingDensityBound` — `[AmbrusEtAl2023]` Thm 1 (arXiv v3,
  p. 4) in the paper's form, **a theorem** (`Plane.oneAvoidingDensityBound`, `Plane/DensityBound/Theorem`), never declared;
  `mOne_eq_iSup_bandFree` (the ruled bridge: `main`'s `mOne`, from `Plane/OneClass/Defs`, over Lebesgue-measurable sets with
  `BandFree A 0`, the form this module first defined; its own `def mOne` deleted at the landing, the brief's Amendment);
  `oneAvoidingDensityBound_model`; `upperDensity_le_of_oneAvoidingDensityBound`; `mOne_le_of_oneAvoidingDensityBound`,
  `mOne_lt_quarter`."
- *(b) the five rows* `Plane/DensityBound/Bessel`, `BesselDefect`, `Autocorr`, `Pattern`, `Window`: their leads "**FS-131
  (FS131-KDB1), skeleton: N leaves `sorry`.**" *by* "**FS-131 (FS131-KDB1's statements, FS131-IDB1's proofs; landed by
  FS131-LDB1; no `sorry`).**" for `Bessel` and `BesselDefect`, and the same with "FS131-IDB2's proofs" for `Autocorr`,
  `Pattern` and `Window`.
- *(c) § Trust*, the paragraph under the table, *following* "its stored type the declared one's, and its fourteen
  consumers are clean (FS133-LD1).": " `Plane.OneAvoidingDensityBound` (`[AmbrusEtAl2023]`
  Theorem 1) never entered as a purchase: it was a hypothesis of three theorems (FS131-KR1) and is the theorem
  `Plane.oneAvoidingDensityBound` since FS131-LDB1, from the paper's certificate checked by `decide +kernel` — no
  `native_decide`, no axiom."

**10. `BIBLIOGRAPHY.md`, `[AmbrusEtAl2023]`.**
- *(a) the role column, following* "so `m₁(ℝ²) ≤ 0.246989 < 0.2470` is [cert + hand] here; its eq. (23) has a typo —
  `w1(4)` should be `w1(1)` — and its ν is 1e-5 where the notebook's is 1e-6, both valid (J26 §2.3, §4.1)": "; **Theorem 1
  is a kernel theorem since FS131-LDB1** (`HadwigerNelson.Plane.oneAvoidingDensityBound`, on the standard three axioms):
  the paper's certificate, unchanged, read at scale `10²¹` (`ν = 10⁻⁵`, `µ = 6·10⁻⁵`, `(wT + ν)/(1 − µ) = 0.24699745…`),
  on a finite-window route with no periodic reduction (`[deOV10]`, `[KMOR2016]`'s torus) and no Watson §§ 7.21, 13.74, 15.31
  (FS131-KDB1's plan; FS131-IDB1, -IDB2, -IDB3); p. 18's `J0′(t) = J1(t)` should read `−J1(t)`, not material (the proof reads
  `|J0′|`)".
- *(b) the read column, following* "Theorem 1, p. 19's computed `0.24699…` and §4's Remark re-read 2026-09-26 (FS105-W)":
  "; re-read in full, §§ 1–9 and Tables 1–2 (FS131-KDB1, 2026-10-14); pp. 4, 5–6, 9, 13–14, 16–19 against the library
  (FS131-IDB2); pp. 4, 16–19, 23–24, Tables 1–2 line by line against the notebook's points and `g23.csv`, exactly
  (FS131-IDB3); pp. 2 and 4 against the headline (FS131-LDB1)".
- *(c) the library line*, "| `[AmbrusEtAl2023]` | read — §1–§9 in full, with the proofs of Lemmas 1–2, Corollaries 1–2 and
  Proposition 1; Tables 1–2 not line by line (J26, 2026-09-25); the authors' notebook read in full |" *by* "| `[AmbrusEtAl2023]`
  | read — §1–§9 in full, with the proofs of Lemmas 1–2, Corollaries 1–2 and Proposition 1 (J26, 2026-09-25; again
  FS131-KDB1, 2026-10-14); Tables 1–2 line by line (FS131-IDB3, 2026-10-14); the authors' notebook read in full |".

**11. `BIBLIOGRAPHY.md`, `[KMOR2016]`.**
- *(a) the role column, following* "On `𝔽_p²` the three lemmas hold verbatim (densities are counts over `p²`, translates
  are the group) and were measured: 12% below Delsarte at 11, 0.2% at 83": ". Lemma 3.2 (1) in finite-window form is a
  kernel theorem (`DensityBound.autocorr_eq_zero_of_norm_eq_one`, FS131-IDB2), a step of the kernel proof of
  `[AmbrusEtAl2023]` Theorem 1 (FS131-LDB1); the periodic reduction is not used".
- *(b) the read column*, "read — §3 (Lemma 3.2 with its proof, Remarks 3.3–3.4; 2026-09-14) |" *by* "read — §3 (Lemma 3.2
  with its proof, Remarks 3.3–3.4; 2026-09-14); § 3, Lemma 3.2 and pp. 9–11 again (FS131-KDB1, 2026-10-14) |".

**12. `LEAN.md` § The kernel's cost model**, *following* its line on `∀ x ∈ l` (ending "recover the per-element form with
`List.all_eq_true`."), in this order, verbatim from the records:
- FS131-KDB1's two (`plans/FS131-KDB1-density-bound.md` § Stage 6, "**`LEAN.md` § The kernel's cost model**"): the chained
  covering re-pays computed states (21.8 s against 1.5 s per cell); a kernel DFS of mask tests at about 100 µs and 15 KB of
  cache per test, split into theorems of at most about 100 k tests.
- FS131-IDB1's: **its record holds none** — its § "Drafts for the front page" is a copy of FS133-LD1's (lines 264–507, a
  copy slip noted in item 895) and its report's "§ 5.1–5.2" do not exist in any committed version of the record. What
  survives is in its report's INVENTORY (`data/fs131/reports/FS131-IDB1.md` lines 13, 14 and 17 on `fs131-wdb3`), from which
  this draft: *"A certificate's checker in a core-only module, its soundness in a second, and the generated modules importing
  only the first: the 46 cell modules of the `J₀` covering then load no Mathlib (1.95 GB resident against 4.60 GB with
  Mathlib, the same module) and outlive every edit to the Bessel proofs (`Plane/DensityBound/BesselCheck`, `BesselCert`,
  `Cells/*`; FS131-IDB1). A module of 18–29 `decide +kernel` theorems peaks at about one theorem's memory (1.6–2.4 GB)."*
- FS131-IDB2's: none (its § 5.3: "nothing new measured").
- FS131-IDB3's three (`plans/FS131-IDB3-implementation.md` D2): the DFS of mask tests at about 140 µs per test below a
  depth-15 frontier checked once against the DFS's own prefix; a congruence row as an explicit isometry in `ℤ[√3, √11]` at
  about 27 ms; read a certificate's decimals at the scale that makes every one exact (`10²¹`, not `10²⁰`).

**13. `LEAN.md` § Searching — Lean**, *following* its last bullet (ending "Declare it a `.condition` with that model in its
reason (`OneClass.IsShiftInvariantLaw`, FS133-LD1)."), in this order, verbatim from the records: FS131-KDB1's three (§ Stage
6: the 4,669-pair list literal; `Real.circleAverage` and no Bessel function in Mathlib; the micro sign `µ`), FS131-IDB2's
four (§ 5.3: Gaussian regularization with no normalization; the `2π`-periodic `lintegral` shift; `- c⁻¹ * ‖w‖ ^ 2` in `ℂ`;
`simp`'s `measurableSet_setOf` and `two_mul`), FS131-IDB3's four (D3: `Nat.testBit_lor` is Mathlib's; `simp` rewrites `1 &&&
U = 1`; induction on a `List.Forall₂` of applied functions; `bif` in a core-only checker), and this landing's five:
  - *"A join with no conflict in git can still declare one name twice: two lines that each define `Plane.mOne`, in modules
    that do not import each other, merge in silence, every module compiles, and only the root fails, after the whole walk
    (`environment already contains 'HadwigerNelson.Plane.mOne'`); `scripts/dupnames.sh` cannot run until the root builds.
    Before a join's first build, list every constant of the incoming modules and of the other line's library and intersect
    them by name (`data/fs131/ldb1/lean/MainNames.lean`, `collisions.out`; FS131-LDB1)."*
  - *"An import added at a join moves stored types downstream by instance alone: `Plane/OneClass/Defs` brings the port's
    `CommCStarAlgebra ℂ` into `Plane/DensityBound/Window`'s closure, and two of its theorems then store `NormedCommRing ℂ`
    through `CommCStarAlgebra.toNormedCommRing` (three places each). Rebuild the old type from the new by replacing that one
    instance term (`Expr.replace`), check its hash against the dump made before, and have the kernel accept `Eq.refl new :
    old = new` with `Environment.addDeclCore`, a mismatched pair refused (`data/fs131/ldb1/lean/InstanceCheck.lean`;
    FS131-LDB1)."*
  - *"An audit block is checked for coverage as well as for its records' axioms: follow every constant the records' stored
    types and values name, within the landed modules, and require each public constant to be a record or reached
    (`data/fs131/ldb1/lean/Coverage.lean`: 723 records reach the other 1,767 of 2,490 public constants); its control removes
    one implementer's records and must see each reported — removing by name prefix missed one (`dists_ok`) that reached 36
    others (FS131-LDB1)."*
  - *"A former whose docstring calls it a named hypothesis, or external, fails the assumptions step as undeclared once a
    theorem proves it (`undeclared-by-docstring`): the landing that proves it rewords the docstring, and its closed takers then
    read `CLOSED ESTABLISHED` (`Plane.OneAvoidingDensityBound`, FS131-LDB1)."*
  - *"A generator with no `--check` mode is checked by rewriting its modules in place and requiring `git status` clean
    (`tools/fs131_idb1_cells.py chain`, `modules`; `tools/fs131_kdb1_x23.py --write`: the covering's 48 modules and the
    certificate's 23 byte for byte; FS131-LDB1)."*

**14. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`.** One entry after `(("8961", "5"), ("9038", "5")):`'s:

```python
    (("9038", "5"), ("9438", "5")): "FS-131, the landing of the density bound — Plane/DensityBound and Plane/OneAvoidingDensity through the gate: [AmbrusEtAl2023] Theorem 1, every Lebesgue-measurable 1-avoiding planar set has upper density at most 0.2470 (Plane.oneAvoidingDensityBound), from the paper's certificate by decide +kernel with no native_decide, on the standard three axioms; Plane.mOne defined once (the line's own deleted at the join, the bridge mOne_eq_iSup_bandFree, the coordinator's ruling); the theorem [AmbrusEtAl2023]'s, the kernel proof ours (FS131-LDB1; copy data/fs131/ldb1/gate/receipt-axioms-final.log, gated commit 7a2acfef8): 9,824 records, 9,438 clean, 355 axiom-free, 26 imported, 5 purchases",
```

**14b. The same file's table of superseded counts**, every token the drafts retire, each only if the filing leaves it
nowhere in the files the audit joins (the tool flags only a disappearance): `"9038"` (9438 clean); `"9,101"` and `"9101"`
(9,824 records); `"declarations=17902"` and `"17902"` (20563); `"declarations=17902 refutations-skipped=234 sites=1454"`
(20563, 234, 1454). The reason for each: "superseded gate count, refiled at FS131-LDB1's landing from
data/fs131/ldb1/gate/receipt-axioms-final.log (the vacuity count from receipt-vacuity-final.log); the old count stays in
data/fs133/ld1/gate/ and in GATE_CHANGES". The axiom-free count's old `32` is not a retired token: it occurs elsewhere on the
front page ("norm at most 32"). **The next landing's previous receipts are
`data/fs131/ldb1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**15. `data/fs131/claims-NF2.md` § Dated lines**, *following* its last line ("- 2026-10-14 — **The certificate's analytic
half is priced in the kernel** (FS131-KDB1) …"): FS131-IDB3's D5, verbatim from its record, then

> - 2026-10-14 — **The density bound is landed** (FS131-LDB1): `HadwigerNelson.Plane.oneAvoidingDensityBound` through the
>   full gate on one commit (`7a2acfef8`), 723 records of the 83 modules each on a subset of `[propext, Classical.choice,
>   Quot.sound]`, every other public constant reached from them; `Plane.mOne` is the density equality's, this line's own
>   deleted at the join, with `Plane.mOne_eq_iSup_bandFree` (the brief's Amendment); `1/7 ≤ m₁(ℝ²) ≤ 0.2470` on one constant.

**16. The Proof Atlas grade.** `[AmbrusEtAl2023]` Theorem 1 (`m₁(ℝ²) ≤ 0.2470`): from [external] to **[kernel]**
(`Plane.oneAvoidingDensityBound`); `m₁(ℝ²) < 1/4` (the count's input, `Plane.mOne_lt_quarter`): its hypothesis discharged.

## Open gate items at this landing

*Each named, with what would close it; none is a red check of this gate.*

1. **`lean4checker`** (the publication gate, `LEAN.md` § Trust ledger) has not been run over the density bound.
2. **The two instances-only moves** (`DualCert.window_le`, `DualCert.limsup_le`, stage 3.4), which the ruling did not name:
   accepted here on the kernel's `old = new` by `rfl`, sent to the coordinator as a notice; the coordinator rules whether they
   stand.
3. **`DualCert.IsIndep` declared a `.condition`** (stage 3.5), on this landing's word; the alternative, a theorem concluding
   it at a model (the empty set), is a new statement and is not this brief's.
4. **`m₁(ℝ²) < 1/4` with no hypothesis is a term, not a stored theorem** (`mOne_lt_quarter oneAvoidingDensityBound`): a
   closed corollary, if the front page or the chain wants one by name, is a new statement for a planner.
5. **`Chain.out`** (the compiled evaluator's run of the `J₀` chain, the covering generator's input) was not recomputed; the
   kernel re-checks every cell from the literals it produced, so it is an untrusted planning instrument, not a gate input.
6. **FS131-IDB1's record** carries FS133-LD1's drafts in place of its own (item 895's correction owed, still owed); its
   `LEAN.md` drafts are lost but for its report's inventory (draft 12).
7. **The chain's line**: `fs131-wkr`'s copy of `Plane/OneAvoidingDensity` (with its `sorry` and its `def mOne`) meets this
   branch's at one path; the ruling's bridge is the rewrite the chain's readers of the old definition take (the coordinator's
   ruling, part 3).
8. **`ARCHITECTURE.md`'s rows' prose** (draft 9) is the filing's; on this branch the six rows still say "skeleton".

## Stage 6 — SAVED (FS131-LDB1): the green line, and where the branch stands

- **The gated commit is `7a2acfef8`**, on `fs131-wldb` in `.claude/worktrees/fs131-w10g`; the commits after it add only
  records (this file, `data/fs131/ldb1/`, the report). Nothing is pushed (the brief: the server is unreachable); the merge
  into `main` is the coordinator's. Since the merge `main` has moved only if the coordinator moved it; at the pass,
  `main` was the merged `7c8f9af82`.
- The tree's `.lake/build` is the gated build: `lake build --no-build Proofs` "All targets up-to-date (6278 jobs)".
- No process of this job is running or queued (the pass's pid gone; the slot's ledger holds no `ldb1` slot).
- The drafts' slots: `data/fs131/ldb1/drafts-slots.py` "slots: 25 checked, control absent: yes; SLOTS OK"
  (`drafts-slots.out`); at `9fe574044` it fails on 10 (`drafts-slots-plant.out`), as it must.
- The coordinator was told by one line when the gate was green (2026-10-14, about 21:12 UTC).
