# FS133-LD1 — the density equality landed through the full gate, after the port

*de Bruijn, the implementer; job FS133-LD1 (brief: `data/fs133/briefs/FS133-LD1-landing.md`, on `main`). Branch
`fs133-wl1`, cut from `110f1c923` (FS133-IPQ1's head, branch `fs133-wpq`) in the worktree `.claude/worktrees/fs133-wk1`.
The recipe is `plans/FS131-KO1-port-plan.md` § 4.5 on `main` (steps 1–9; step 0 done, inventory item 798). Working
files: `data/fs133/ld1/`; the gate's logs `data/fs133/ld1/gate/`. "Std" is `[propext, Classical.choice, Quot.sound]`.*

## Theorems this phase proved

None of its own: this job proves no new theorem. It lands FS-133's module (FS133-K1's statements, FS133-IA1 to
FS133-IPQ1's proofs) through the gate; the kernel theorems it lands are listed, with their axioms as the gate prints
them, in the stage that reads them aloud.

## Stage 1 — SAVED (FS133-LD1): the readback, and the dump before the merge

**1.1 The brief's quotations.** `tools/fs133_ld1_readback.py` (FS133-IPQ1's reader with this job's brief; each quoted
line a substring of its source, read in the coordinator's tree): **11 matched, 0 mismatched**, exit 0
(`data/fs133/ld1/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; K133-ONE, K133-FN, K133-PAIR,
K133-NC-ONE and K133-NC-ALL against `data/fs133/claims-K1.md`; inventory items 779, 789, 798, 840 and 841 against
`plans/FS131-close-inventory.md`. With `--fault` (the last character of each quoted line changed): 0 matched, 11
mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief's quotations.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole as it stands on `main` (§ Assumptions,
§ Trust ledger and § The gate among it); `RUNNING.md` § Building and § Make the gate fail; the recipe
(`plans/FS131-KO1-port-plan.md` §§ 4.4–4.6, on `main`); FS133-IPQ1's record whole and FS133-ICD1's record whole (this
tree).

**1.3 The build before the merge** is current: `lake build --no-build` under the slot reads `All targets up-to-date
(6048 jobs)`, exit 0, with no warning replayed (`data/fs133/ld1/nobuild-before.log`; 4.9 s, 0.9 GiB).

**1.4 Recipe step 1 — every constant of the modules, from this tree's build, before the merge.**
`data/fs133/ld1/lean/StatementDump.lean`: FS132-I2's dumper body as FS133-IPQ1 used it, copied by `sed` unchanged, and
a driver that reads its module list from a file and, for the second side of the join, a list of names to be found
wherever they are then declared. Before the merge it dumps nine modules — the eight of the density equality
(`Outside/OAI158Rigidity` and the seven of `Plane/OneClass`) and `Outside/OAI158Transfer`, which the join deletes, so
that its constants can be found again in the port: `data/fs133/ld1/moved/before.out.xz` (sha256 of the text in
`before.sha256`; 11.9 s, 3.5 GiB resident) — **245 constants: `OAI158Rigidity` 10 named and 4 private,
`OAI158Transfer` 50 named (two of them the generated `approxField.congr_simp`, `approxIndex.congr_simp`),
`SectionDensity` 9 and 3, `Defs` 53 and 4, `InvariantLaw` 9 and 19, `Field` 1 and 30, `Algebraic` 9 and 1,
`Fractional` 7 and 11, `Pair` 19 and 6**; no `ABSENT`. Rigidity's ten named: the six copied definitions
(`Spectral.E`, `K`, `DiscreteE`, `kCoeff`, `ContinuousVectors.op`, `space`), the derived
`Spectral.instCommGroupDiscreteE`, the `axiom` `Spectral.residual_fourier`, and `residual_fourier_cross`,
`residual_fourier_model`.

**The dumper is faithful to the last implementer's**: FS133-IPQ1's reader, `--strict`, its built dump
(`data/fs133/ipq1/moved/built.out.xz`) against this one: **181 constants of the seven `Plane/OneClass` modules, 181
IDENTICAL**, the 64 of Rigidity and Transfer new on this side (`moved/ipq1built-vs-before.txt`).

## Stage 2 — SAVED (FS133-LD1): the join — recipe steps 2–9

**2.1 Step 2, the merge.** A trial first (`git merge-tree --write-tree --name-only HEAD main`, `data/fs133/ld1/trial-merge.out`):
**one conflict, `ARCHITECTURE.md`**; `Proofs.lean` auto-merged; `scripts/Axioms.lean` untouched by this branch, so no
conflict there. The merge of `main` at `80ac103c1` (commit `cdef151c1`) resolved the two hunks keeping both sides'
changes: in § 3, `main`'s row of `Plane/LebesgueNumber` (which this branch had not changed: its line was the merge
base's) followed by this branch's ten FS-133 rows; in § Trust, `main`'s removal of `proper_to_borel_weak`'s row
(this branch's line was the base's) and this branch's row of `Spectral.residual_fourier` (for the filing to rework:
draft 9). The merged index against `main` differs, outside `plans/` and `data/`, only in this branch's own files
(`ARCHITECTURE.md`, `Proofs.lean`, the nine Lean modules, the earlier implementers' `tools/fs133_*`).

**2.2 Steps 3–5, and the two ruled corrections** (commit `01351c476`, the source edits unbuilt):
- step 3: `Outside/OAI158Transfer.lean` deleted (`git rm`), its `Proofs.lean` line and its `ARCHITECTURE.md` row
  removed; it had no block in `scripts/Axioms.lean` (this branch never registered it). `rg -uu OAI158Transfer Proofs
  scripts ARCHITECTURE.md Proofs.lean` then finds only `Field`'s import (step 5), one docstring of `Field` (reworded)
  and `Field`'s imports cell (fixed below).
- step 4: `Outside/OAI158Rigidity` — the six copied definitions with the `deriving` clause, and the `axiom
  residual_fourier`, deleted; `import Proofs.HadwigerNelson.Outside.OAI158Ergodicity` added (the seven Mathlib imports
  kept); `residual_fourier_cross`, `residual_fourier_model` and the four private helpers kept; the module docstring
  rewritten (the theorem is the port's; what is this module's own). Two docstrings of the kept theorems reworded where
  they called it "the import" (prose only, the brief's touches).
- step 5: `Plane/OneClass/Field`: `import …Outside.OAI158Transfer` → `import …Outside.OAI158BorelTransfer`.
- **correction 1** (item 789, ruling 1): `[IsProbabilityMeasure μ]` dropped from
  `Plane.ofReal_integral_le_measure_pos` (`Plane/OneClass/SectionDensity`); its one caller, `sectionDensity_setOf_pos`
  in the same file, passes the instance implicitly and is unchanged in text. Its docstring now says it holds for any
  measure.
- docstrings, prose only: thirteen places in `Algebraic`, `Fractional`, `Pair` and `Field` that said "the declared
  outside theorem `Spectral.residual_fourier`" now say "`[OAIMath2026]`'s ported theorem `Spectral.residual_fourier`";
  `Field`'s pointer to `Outside/OAI158Transfer` now points to the port's modules.
- `ARCHITECTURE.md`, as the gate requires (`tools/check_architecture.py` [2] named three imports cells): `Rigidity`
  "Mathlib only" → `Outside/OAI158Ergodicity`; `Field` `Outside/OAI158Transfer` → `Outside/OAI158BorelTransfer`;
  `Algebraic` gains `Instances/Seven` (FS133-ICD1's import, accepted by its Amendment 1). The rows' prose is drafted
  for the filing (draft 9), not edited here.

**The edits in text** (`tools/fs133_ld1_code_only.py`, FS131-LC1's comment-stripping comparison with the expected
edits listed, each required to occur exactly once, against `74135d1b7`, the branch before the merge;
`data/fs133/ld1/code-only.out`): `Defs`, `InvariantLaw`, `Algebraic`, `Fractional`, `Pair` — no code character
changed; `Field` — the one import; `SectionDensity` — the one binder; `Rigidity` — the code from `theorem
residual_fourier_cross` to the end the same but for one simp argument (2.4), the seven listed declarations deleted,
and the one import the only new word. With `--plant` (one code character altered in each file in memory) every file
reads DIFFERS (`code-only-plant.out`).

**2.3 Step 7, the build** (`data/fs133/ld1/build-sampled.sh build-join`: the slot at 10 GiB and 4 cpus, `MEMMAX=10G
BATCH=8`, with FS131-LC1's sampler beside it): **`build: OK — 255 of 255 batches, 75 module(s) rebuilt, 1 module(s)
with warnings, 14m19s`**, exit 0, 893 s with the slot's wait (`data/fs133/ld1/build-join.log`; Lake's full output
`receipt-build-join.log`; sampler `build-join.mem`: largest single compiler 3.95 GiB, `Plane/OneClass/Fractional`;
largest sum over six compilers 20.8 GiB of resident sets, which counts shared `.olean` pages once per process). The 75
are the port's 31 generated modules and `Outside/OAI158Collapse`, `main`'s new and changed modules since the branch's
base, their downstream, and this module. **The one warning** is new and the join's: `Outside/OAI158Rigidity.lean:208:16:
This simp argument is unused: hne`, in `residual_fourier_model`'s proof (2.4).

**2.4 The warning, and the one proof edit it asks.** In `residual_fourier_model`'s proof, `simp [hx, hne]` closed a goal
`hne` (`kCoeff k⁻¹ * x ≠ 0`) was given for; with the port in the environment `simp` proves that itself. `simp?` on a
copy (`data/fs133/ld1/work/RigidityProbeA.lean`, `.out`) names the lemmas: `kCoeff_inv, ne_eq, mul_eq_zero,
inv_eq_zero, kCoeff_ne_zero, hx, or_self, not_false_eq_true, Pi.single_eq_of_ne` — `Spectral.kCoeff_inv` and
`Spectral.kCoeff_ne_zero` are `@[simp]` in the port (`Outside/OAI158Basic` ll. 857, 863); before the join
`kCoeff_ne_zero` was `@[simp]` in `Outside/OAI158Transfer` too, but `kCoeff_inv` was in neither copy, and without it
`simp` could not reach `kCoeff k⁻¹ * x ≠ 0`.
**The edit: `simp [hx, hne]` → `simp [hx]`**, the linter's own hint; on a copy it elaborates with no warning at all
(`RigidityProbeB.out`), the `have hne` above it left in place (no linter reads it as unused). It is a proof edit in a
declaration the recipe keeps "character for character": no stored statement moves (2.6 shows it), and the code-only
check lists it as the one change in that tail. The alternative — `set_option linter.unusedSimpArgs false in` above the
theorem, keeping the bytes — was declined: it silences the linter where the edit removes what it reports. Held for the
coordinator in the report.

**2.5 Step 6, the doubled names, before the audit** (on the build of 2.3; `data/fs133/ld1/dupnames-join.log`):
**`dupnames: OK — no name is declared by two modules (26 generated on demand, listed above)`**, exit 0 — the 26
generated names exactly the port's landing's (`data/fs131/lp1/gate/receipt-dupnames-final.log`, sorted and compared:
identical). So the 63 shared constants of the plan's § 2.3 are each declared once, and this module adds no generated
name to the list (FS133-ICD1's `Subadditive.lim.congr_simp` is gone, as its record says).

**2.6 Step 8, the dump again, compared** (`data/fs133/ld1/moved/after-join.out`, 10.6 s, 3.9 GiB): the eight modules'
own constants and, by name, every constant of the dump before the merge wherever it is now declared — **245
constants, none absent; 58 found by name in the port** (8 in `OAI158Basic`, 27 in `OAI158Representations`, 22 in
`OAI158BorelTransfer`, 1 in `OAI158Ergodicity`). `tools/fs133_ld1_moved.py` (FS133-IPQ1's reader, copied, with three
ruled verdicts of the join and their plants), `--strict`, before against after
(`moved/before-to-after-join.txt`): **`MOVED OK`** —
- **the eight density modules**: `Plane/OneClass` 180 IDENTICAL and **1 BINDER-DROPPED**
  (`ofReal_integral_le_measure_pos`, the second binder named `inst`: the full print equals the first's with that `pi`
  removed and every index beneath it past it lowered, the erased print likewise, and the binder read nowhere);
  `Rigidity` 6 IDENTICAL (`residual_fourier_cross`, `residual_fourier_model`, the four private helpers), 7
  MOVED-IDENTICAL (the six definitions and `instCommGroupDiscreteE`, now in `OAI158Basic` and
  `OAI158Representations`, full prints identical), and **`Spectral.residual_fourier` AXIOM-PROVED** — an `axiom`
  before, a `theorem` of `Outside/OAI158Ergodicity` after, **its stored type IDENTICAL in the full print** (every
  constant, instance, binder and universe level), so the recipe's kernel `Eq.refl` check (for INSTANCES-ONLY) is not
  needed. This agrees with the port's landing's receipt (item 840: the ported `residual_fourier` has that branch's
  axiom's type).
- **`OAI158Transfer`'s 50**: 45 MOVED-IDENTICAL; the two generated `approxField.congr_simp`, `approxIndex.congr_simp`
  GENERATED-IDENTICAL (now in `OAI158BorelTransfer`); and **`approxField`, `approxIndex`, `measurableField`
  MOVED-INSTANCES-ONLY** — item 798's three: stored types identical in full, values identical with instance and proof
  arguments erased, the full values citing other generated proof auxiliaries (`Koopman.isometry._proof_1`, `_2` before;
  `LabelModel.projected._proof_1` and `approxIndex._proof_1`/`_2` after), as that ruling has it.
- New in the second dump: none.
**Controls** (`moved/control-after-join.txt`): 126 plants, each read as planted, the unplanted run clean — FS133-IPQ1's
(a dropped binder left in, another change beside the drop, the named binder absent from the first print — now made at
any binder kind, since an instance binder prints `pi.c` —, the dropped binder read; a constant changed in both prints,
in the full print only under `--strict`, removed, made an axiom, compiled elsewhere; each moved constant changed or left
in its old module) and this job's (the proved axiom's type changed, the proved axiom left an axiom; each
moved-instances definition's type changed, its erased value changed, left in its old module; each generated theorem's
type changed).

**2.7 The rebuild after the edit of 2.4** (`build-sampled.sh build-fix`): **`build: OK — 255 of 255 batches, 8 module(s)
rebuilt, 0 module(s) with warnings, 8m11s`**, exit 0, 495 s (`data/fs133/ld1/build-fix.log`; Lake's full output
`receipt-build-fix.log`, 0 lines holding "warning"). The eight are `Outside/OAI158Rigidity`, the seven of
`Plane/OneClass` below it, and the root.

**2.8 Step 9, the axioms** (`scripts/axioms.sh` on the build of 2.7, with this landing's 77 records filed under CLEAN —
`scripts/Axioms.lean`, the block "FS133-LD1" above the PURCHASED banner; `data/fs133/ld1/axioms-join.log`, receipt
`receipt-axioms-join.log`): **`axioms: OK — 9038 clean, 32 axiom-free, 26 imported, 5 declared purchase(s)`**,
"declared imports: 2", "library axioms other than native auxiliaries: 2, every one declared" — 9,101 records, the
brief's 9,024 and the module's 77 (2.9). `Spectral.residual_fourier_cross` and `OneClass.exists_field` each print
`[propext, Classical.choice, Quot.sound]`; `scripts/Axioms.lean` declares no `residual_fourier` import (it never did on
this branch: the import was filed only in drafts). **The records check** (`tools/fs133_ld1_records.py`, FS131-LP1's
with this landing's claims; `records-join.txt`): **`records: PASS`** — the port's `residual_fourier` under CLEAN on
exactly the three; the module's 77 records each once under CLEAN on a non-empty subset of the three; the fourteen that
rested on the declared theorem (the plan's § 5.5 IMPORTED list: `residual_fourier_cross`, `exists_field`, nine of
`Algebraic` and `Fractional`, three of `Pair`) each on exactly the three; no record rests on `residual_fourier` and no
`DECLARED IMPORT` names it; declared imports exactly Weil's bound and the five-colouring theorem; IMPORTED 26 = 20 + 6;
9,101 records, none twice. Its five plants each FAILED, as they must (`records-plant-join.txt`).

**2.9 The prediction, before the run, against it.** From the module's records: FS133-ICD1's list has 125 records, 50 of
them in `HadwigerNelson.Outside.OAI158` — 48 of those 50 already audited on `main` as the port's generated records (the
six definitions, the derived instance and `residual_fourier`, and 40 of `OAI158Transfer`'s constants) and two new
(`residual_fourier_cross`, `residual_fourier_model`); so 75 + 2 = 77 records join the audit, each printed by
FS133-IPQ1 on the standard three (61) or on those and the declared theorem (14), none axiom-free. Predicted: 9,024 + 77
= 9,101 records, clean 8,961 + 77 = 9,038, axiom-free 32, imported 26, purchases 5. **Met, each count.** The module's
public declarations that are not records are the generated API of its four structures (`casesOn`, `rec`, `mk`, the
fields), as FS133-K1's plan files them.

**2.10 The assumptions step: one failure, and its disposition.** `./scripts/assumptions.sh` on the joined tree failed
once (`assumptions-join.log`): **`FAIL undeclared-never-concluded HadwigerNelson.OneClass.IsShiftInvariantLaw`** —
taken as a hypothesis by `IsShiftInvariantLaw.measure_origin_le`, concluded by no theorem (the law the library
exhibits is the projection `(isInvariantLaw_dirac G).toIsShiftInvariantLaw` of an invariant one, which no declaration
states). It is a condition on the theorem's law, not an assumption, so it is declared as one, by `LEAN.md` §
The gate's rule (the `.condition` disposition, `Plane.IsTriod` at FS124-L2): one line of `AssumptionAudit.declared` in
`scripts/Assumptions.lean`, `.condition ``HadwigerNelson.OneClass.IsShiftInvariantLaw "…"`. With it
(`assumptions-join2.log`, receipt `receipt-assumptions-join2.log`): **`assumptions: OK — 2 outside theorem(s) as
axioms, with 27 theorem(s) resting on them; 19 named and 14 inline hypotheses (7 outside, 21 ours, 5 open), taken by 102
statement(s) and mentioned by 1`**; the ledger's header and `CLAUDE.md` § Trust ledger "match (9 of 9 compared)" — the
module adds no axiom and no declared hypothesis, so the nine counts are unchanged and the ledger is not rewritten.

**2.11 The vacuity scan** (`vacuity-join.log`, receipt `receipt-vacuity-join.log`): **`vacuity: OK`**, "scanned:
declarations=17902 refutations-skipped=234", "sites: sites=1454 vacuous=0 stale=0 declared=3 witnessed=38
generic=1411 unknown=2" — declarations +117 and refutations +2 against the port's landing (17,785, 232), no site
added; the baseline's header and `CLAUDE.md` § The gate read stale, as they must. The baseline's header count line is
refiled on this branch (17785 → 17902, 232 → 234; its entries unchanged); `CLAUDE.md` is draft 2. The final pass
reconciles the +117 and the +2 module by module.

**2.12 The guarded lint** (`lake lint --no-build -- --no-build --trace` under the slot, `lint-join.log`): exit 0,
**`-- Linting passed for Proofs.`**, every linter `(2/2) Passed!` — FS133-IPQ1's one finding (the unused
`[IsProbabilityMeasure μ]` of `ofReal_integral_le_measure_pos`) gone with correction 1.
