# FS131-T5 — the gate enumerates what the library assumes

*The record of job FS131-T5 (de Bruijn, the implementer; a tooling job). Brief:
`data/fs131/briefs/FS131-T5-gate-assumptions.md` on `main`'s working tree (untracked there when read; the copy this job read is
`data/fs131/t5/brief-as-read.md`). Branch `fs131-t5`, cut from `main` at `3bfc7d2e`. Everything this record cites is under
`data/fs131/t5/`.*

## Theorems this phase proved

None. This is a tooling job: it adds a step to the gate and changes no file under `Proofs/`, so it proves no theorem and
moves no axiom count.

## Stage 1 — SAVED (FS131-T5): the readback, the build as given, and a census taken before the design

**The quotations.** The brief quotes fifteen statements, each as a first line with its source. All fifteen are whole lines of
their sources, verbatim (`tools/fs131_t5_readback.py`, output `data/fs131/t5/readback.out`: `quotations=15 mismatched=0`). The
tool's own control (`--self-test`, `data/fs131/t5/readback-selftest.out`): a faithful quotation reads MATCH and the same line
with one character changed reads MISMATCH.

**What was read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail,
and watch it fail; `scripts/axioms.sh`; `scripts/Axioms.lean`'s header, its instruments (`inScope`, `isBibKey`, `hasBibKey`,
`declareImport`, `libraryAxioms`), the IMPORTED banner with its procedure, and the file's end; `scripts/Vacuity.lean` and
`scripts/vacuity.sh`; `scripts/gate_report.py`; `scripts/gate-log.sh`; the header and first controls of
`scripts/axioms-controls.txt`; inventory items 548 and 551; `plans/FS131-L10A-landing.md` draft 5 (the table of named
hypotheses) and draft 6; `plans/FS131-kernel-plan.md` § 7.4; `ARCHITECTURE.md` § 5; and each quoted definition with its
docstring.

**The build as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0:
"All targets up-to-date (5814 jobs)", "all 1805 modules already up to date, nothing built, 0 module(s) with warnings"
(`data/fs131/t5/logs/build-stage1.log`).

**A census, taken before the design** (`data/fs131/t5/census/census.lean`, output `census.out`; read-only, declares nothing;
not the step). It reads every hand-written constant's statement as written and classifies each hypothesis — a binder whose
type is a proposition. What it measured on `main`'s tree at `3bfc7d2e`, the numbers the design below is fitted to:

| quantity | count |
|---|---|
| hand-written library constants read | 12,738, of them 8,956 theorems; none failed to telescope |
| binders, all constants | 51,178 |
| hypotheses (binders whose type is a proposition) | 16,492, of them 275 instance-implicit |
| **closed hypotheses** (the type holds no free variable) | **1,468**, every one explicit, every one in a theorem |
| — of those, `HadwigerNelson.Justified … <a watermark>` (the LRAT chain steps) | 1,431 |
| — the rest | 37, in 26 theorems |
| library `Prop`-formers (non-theorem constants whose type ends in `Prop`) | 275 |
| — taken as a hypothesis by some constant | 222 |
| — taken as a hypothesis and concluded by no theorem | 45 |
| hypotheses whose head is a library former / another constant / no constant | 4,625 / 9,753 / 2,114 |

Three readings of it that decide the design:

1. **A closed hypothesis is the assumption's own shape, and the class is small.** A hypothesis with no free variable is a
   statement about the world, not a condition on the theorem's parameters. Of the 37 that are not LRAT chain steps, every one
   is one of: a named assumption at a closed instance (`RealAlgebraicDescent` six times, `StandingFloor 7` and `5`,
   `BochnerHerglotz` and `InvariantMeasureOnClosed` at `ℚ(√47)`, `OrderBound … 168`, `Row130M1`, `Voronov11`, `G4`); a hand
   result or a computed bound written out in the binder (`cl2`'s `hRQ4`, `hRQ5`; `five_le_chromaticNumber`'s `hRow123`; the
   three `(finitePlane q).indepNum ≤ N`); an open question or a design target a theorem is conditional on (the forced-pair
   hypotheses of the `χ ≥ 6` and `χ ≥ 7` targets, `∀ R > 0, ∃ F p, F.Covers p R ∧ F.Valid`, `∀ ε > 0, mu 6 ε < 1`); a
   statement another library theorem proves (`¬ (edgeGraph 1581 deGrey.edges).Colorable 4` and the two Heule graphs'); or the
   one hypothesis of a refutation (three "planted false twin" theorems concluding `False`). The 1,431 chain steps are the
   fourth kind: each takes the previous watermark, which the previous step concludes.
2. **"Taken and never concluded" finds seventeen of the named assumptions and twenty-eight ordinary predicates.** Among the 45:
   `RealAlgebraicDescent`, `OrderBound`, `Row130M1`, `G4`, `BochnerHerglotz`, `InvariantMeasureOnClosed`, `StandingFloor`,
   `TCA`, and `Interface.{RU, APlus0, APlusOfR88, Count, PE2, EFPlus, MulStable, NegCircle}` — and beside them `IsUsablePrime`,
   `NoAffFieldHyp`, `BaseCtx`, `Terminal`, `Near.RayConfig` and the like, conditions on a theorem's parameters whose instances
   are proved inside proofs, in `example`s, or nowhere. It misses the assumptions some theorem does conclude: `BochnerOn`
   (`bochnerOn_bot`, at one topology), `Interface.MR` (`mr_of_pe2_efPlus`, from two other assumptions), `Voronov11`
   (`voronov11_of_forall_mu_lt`, from the open question).
3. **Some assumptions on `main` have no name and no closed form**, and nothing in a type tells them from a condition:
   `min_localBound_five_le_chromaticNumber` takes `hRow99 : localBound F ≤ 4 → localBound F ≤ χ(F²)` (row 99, ours) and
   `hCLS : 5 ≤ localBound F → TCA F` (X23D-CLS, ours) beside `hL : localBound F ≤ 5` in its corollary, which is a condition on
   `F`; `falconerFan_five_mem_eight` takes `hR78` over any lattice. Binder names do not separate them either: 32 binders are
   named like `hR1`, most of them `R ≤ 1`.

**An assumption the brief's seed list lacks**: `Bridge.RealAlgebraicDescent` (Tarski; Artin–Lang), taken by six theorems of
`Proofs/HadwigerNelson/Bridge.lean`. A record of ours does name it (`CLAUDE.md` § Where the problem stands: "the bridge
`χ(ℝ²) = max_F χ(F²)` conditional on one named true hypothesis", row 107), so it is no message; it is in the enumeration.
