# FS133-LD1 — the density equality landed through the full gate, after the port

*de Bruijn, the implementer; job FS133-LD1 (brief: `data/fs133/briefs/FS133-LD1-landing.md`, on `main`). Branch
`fs133-wl1`, cut from `110f1c923` (FS133-IPQ1's head, branch `fs133-wpq`) in the worktree `.claude/worktrees/fs133-wk1`.
The recipe is `plans/FS131-KO1-port-plan.md` § 4.5 on `main` (steps 1–9; step 0 done, inventory item 798). Working
files: `data/fs133/ld1/`; the gate's logs `data/fs133/ld1/gate/`. "Std" is `[propext, Classical.choice, Quot.sound]`.*

## Theorems this phase proved

No new theorem is this job's: it lands FS-133's module (FS133-K1's statements; FS133-IA1, -IB1, -IB2, -ICD1 and
-IPQ1's proofs) through the gate on `860538ddf`. Its one proof edit is one simp argument (stage 2.4). The headlines it
lands, each **[kernel]**, each on `[propext, Classical.choice, Quot.sound]` as the gated audit prints them
(`data/fs133/ld1/gate/receipt-axioms-final.log`; all 77 records of the module the same or fewer):
- `HadwigerNelson.OneClass.finIndepRatio_plane_eq_mOne` — `α₁(ℝ²) = m₁(ℝ²)` (`Plane/OneClass/Algebraic`)
- `HadwigerNelson.OneClass.finIndepRatio_algPlane_eq_mOne` — `α₁(𝒜²) = m₁(ℝ²)` (`Algebraic`)
- `HadwigerNelson.OneClass.iSup_fractionalChromaticNumber_plane` — `χ_f,0(ℝ²) = 1/m₁(ℝ²)` (`Fractional`)
- `HadwigerNelson.OneClass.fractionalChromaticNumber_plane` — `χ_f(ℝ²) = 1/m₁(ℝ²)` (`Fractional`)
- `HadwigerNelson.OneClass.fractionalChromaticNumber_algPlane` — `χ_f(𝒜²) = 1/m₁(ℝ²)` (`Fractional`)
- `HadwigerNelson.OneClass.tendsto_minIndepNum_div` — `f(n)/n → m₁(ℝ²)` (`Algebraic`)
- `HadwigerNelson.OneClass.exists_admissibleOn_univ_iff_ae` — C133-PAIR, first clause (`Pair`)
- `HadwigerNelson.OneClass.exists_admissibleOn_univ_iff_algPlane` — C133-PAIR, second clause (`Pair`)
- `HadwigerNelson.OneClass.one_seventh_le_mOne` — `1/7 ≤ m₁(ℝ²)` (`Algebraic`)
- `HadwigerNelson.Outside.OAI158.Spectral.residual_fourier_cross` — two vectors, by polarisation (`Outside/OAI158Rigidity`)
- `HadwigerNelson.Plane.ofReal_integral_le_measure_pos` — for any measure, its binder dropped here (`SectionDensity`)

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

**2.13 The lint's planted control** (`data/fs133/ld1/lint-plant.sh`, FS131-LP1's script with this module, the plant's
name and the paths changed): an unused anonymous instance binder planted at the end of `Plane/OneClass/Pair` (a leaf:
only the root imports it), the tree built (`build: OK — 255 of 255 batches, 2 module(s) rebuilt`, 770 s), the lint run:
**`LINT CONTROL FIRED: exit 1, the plant named`** — `synTaut` and `unusedArguments` each `(2/2) Failed with 1
messages`, both the plant's (`Pair.lean:494:1: … @zz_ld1_lint_plant`), nothing else (`lint-plant.log`); the module
restored by `git checkout`, its digest the one taken before the plant (`lint-plant-restore.txt`: "RESTORED: the module
is the text it was"). The final pass rebuilds `Pair` and the root from the restored text.

## Stage 3 — SAVED (FS133-LD1): the two ruled corrections, from the kernel's side

**Correction 1 (item 789, ruling 1): the unread `[IsProbabilityMeasure μ]` of `Plane.ofReal_integral_le_measure_pos`
dropped.** Against stage 1's dump (before the merge), the dump after the join (2.6) reads **BINDER-DROPPED** for that
theorem and IDENTICAL for every other constant of the seven `Plane/OneClass` modules (180): its stored type is the old
one with exactly the second binder named `inst` — the probability instance; the first `inst` is `MeasurableSpace Ω`,
which the statement reads — removed, every de Bruijn index past it lowered by one, the erased print likewise, and no
index pointing at it (the binder was read nowhere). The reader's four plants on this verdict each fail the run
(2.6). Its one caller, `sectionDensity_setOf_pos`, passed the instance implicitly: its text is unchanged (2.2's
code-only check) and its stored statement IDENTICAL. The proof of the corrected theorem is unchanged in text; it holds
for any measure, and the docstring now says so. The linter's finding is gone (2.12). **The dropped binder is the only
change of a stored statement in the module.**

**Correction 2 (item 789, ruling 2): FS133-ICD1's block wording, corrected from FS133-IPQ1's DQ1.** FS133-ICD1's draft
block for `scripts/Axioms.lean` (`data/fs133/icd1/axioms-block.txt`) ended in a commented line "NOT YET FILED: Pair's
leaves Q4 and Q5 are outstanding; once proved, the first under CLEAN, the other three under IMPORTED", where the tags
on the lines below it, and the printed axioms, put the **second** record (`exists_admissibleOn_of_ae`) under CLEAN and
the first under IMPORTED (DQ1's correction owed). The block as filed (`scripts/Axioms.lean`, "FS133-LD1 block") has no
such line and no IMPORTED part: with `residual_fourier` a theorem of the port, all 77 records are under CLEAN, the four
of `Pair` among them, and the audit prints each on the standard three (2.8); the fourteen that FS133-ICD1's and
FS133-IPQ1's tables carried under IMPORTED are listed by name in `data/fs133/ld1/records-rf.txt` and checked to be
exactly the three. The drafts below carry the corrected wording where FS133-ICD1's DD1 and DD4 said "IMPORTED" or "on
the declared outside theorem": draft 3 (the front page), draft 9 (`ARCHITECTURE.md`'s rows), with C133-PAIR held
(FS133-ICD1's DD4 said it was not yet in the kernel).

## Stage 4 — SAVED (FS133-LD1): read aloud

*Each headline's statement as the kernel stores it — `#check @…` with every binder, from the built tree
(`data/fs133/ld1/lean/ReadAloud.lean` → `data/fs133/ld1/read-aloud.out`) — against its claim-list entry, verbatim
(`data/fs133/claims-K1.md`), and the definitions the statements name, printed in the same file.*

**The definitions, as stored.** `unitDistance V` joins `x, y` when `dist x y = 1`, exactly. `SimpleGraph.finIndepRatio G
:= ⨅ S, ⨅ (_ : S.Nonempty), ↑(G.induce ↑S).indepNum / ↑S.card` in `ℝ≥0∞`, over finite sets `S` of vertices — `α₁`, the
infimum of `α(G[S])/|S|`. `Plane.mOne := ⨆ A, ⨆ (_ : MeasurableSet A), ⨆ (_ : (unitDistance ℂ).IsIndepSet A),
upperDensity A` — `m₁(ℝ²)` over Borel sets with no two points at distance one (`mOne_eq_iSup_nullMeasurableSet`, a
record of the module, gives the same number over Lebesgue-measurable sets), `upperDensity S := limsup_{R→∞} vol(S ∩
B(0,R)) / vol(B(0,R))`. `Spectral.E := algebraicClosure ℚ ℂ` (the port's, the release's term) — `𝒜`, the algebraic
numbers, the plane `𝒜²` read in `ℂ`. `SimpleGraph.fractionalChromaticNumber G := ⨅ b n, ⨅ (_ : 0 < b), ⨅ (_ :
G.FractionalColorable b n), ↑n / ↑b` — `χ_f`. `Plane.minIndepNum n := ⨅ S : {S : Finset ℂ // S.card = n},
((unitDistance ℂ).induce S).indepNum` — `f(n)`. `AdmissibleOn N X ℓ := ∀ x ∈ X, ∀ y ∈ X, ¬ N (dist x y) (ℓ x) (ℓ y)`;
`AdmissibleAe N ℓ := ∀ r, ∀ᵐ p ∂(volume ⊗ arcLength), ¬ N r (ℓ p.1) (ℓ (p.1 + r·e(p.2)))` with `arcLength` Lebesgue
measure on `[0, 2π)` and `e θ = exp(iθ)`; `IsAlgPattern N`: the distances `{r | ∃ a b, N r a b}` countable, each
positive and algebraic over `ℚ`.

**K133-ONE** — "`α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`". Carried by five
theorems, each on `[propext, Classical.choice, Quot.sound]`:
- `OneClass.finIndepRatio_plane_eq_mOne : (unitDistance ℂ).finIndepRatio = Plane.mOne` — `α₁(ℝ²) = m₁(ℝ²)`;
- `OneClass.finIndepRatio_algPlane_eq_mOne : (unitDistance ↥E).finIndepRatio = Plane.mOne` — `α₁(𝒜²) = m₁(ℝ²)`;
- `OneClass.iSup_fractionalChromaticNumber_plane : ⨆ S, ((unitDistance ℂ).induce ↑S).fractionalChromaticNumber =
  mOne⁻¹` — `χ_f,0(ℝ²)`, the supremum over the finite subgraphs, is `1/m₁(ℝ²)`;
- `OneClass.fractionalChromaticNumber_plane : (unitDistance ℂ).fractionalChromaticNumber = mOne⁻¹` — `χ_f(ℝ²)`;
- `OneClass.fractionalChromaticNumber_algPlane : (unitDistance ↥E).fractionalChromaticNumber = mOne⁻¹` — `χ_f(𝒜²)`.
No hypothesis: each is a closed equation. `1/m₁` is `mOne⁻¹` in `ℝ≥0∞`; it is the reciprocal of a positive finite
number, since `7⁻¹ ≤ mOne` (`OneClass.one_seventh_le_mOne`, on the three) and `mOne ≤ 1` (`Plane.mOne_le_one`). **The
statements say what the entry says, and no more**: no value of `m₁(ℝ²)` is stated beyond `1/7 ≤ m₁(ℝ²) ≤ 1`, which
the entry's *not claimed* allows ("any value of `m₁(ℝ²)`" — the bound `1/7` is not a value), and nothing at a number
field's plane or at six colours.

**K133-FN** — "`f(n)/n → m₁(ℝ²)` as `n → ∞`, where `f(n)` is the minimum of `α(G)` over `n`-point subsets `G` of the
plane". Carried by `OneClass.tendsto_minIndepNum_div : Tendsto (fun n => ↑(minIndepNum n) / ↑n) atTop (𝓝 mOne)`, on the
three, the quotient in `ℝ≥0∞` (at `n = 0` it is `0/0 = 0` there, which a limit at infinity does not read). `minIndepNum
n` is the infimum over `n`-element `Finset`s, which is the minimum of the entry (a set of naturals attains its
infimum). Equal to the entry.

**K133-PAIR** — "an admissible `ℓ : ℝ² → Λ` exists if and only if a Lebesgue-measurable `ℓ : ℝ² → Λ` admissible almost
everywhere exists; and an admissible `ℓ : ℝ² → Λ` exists if and only if an admissible `ℓ : E → Λ` exists", in the
derivation's setting (`plans/FS133-E1-derivation.md` § Stage 6, its definitions: `Λ` finite, `R` a countable set of
positive real algebraic numbers, for each `r ∈ R` a symmetric `N_r ⊆ Λ × Λ`). Carried by:
- `OneClass.exists_admissibleOn_univ_iff_ae : ∀ {Λ} [Finite Λ] {N}, IsAlgPattern N → ((∃ ℓ, AdmissibleOn N univ ℓ) ↔ ∃
  ℓ, (∀ a, NullMeasurableSet (ℓ ⁻¹' {a}) volume) ∧ AdmissibleAe N ℓ)` — the first clause; "Lebesgue-measurable" is
  every fibre null-measurable (`LEAN.md`: the same as `NullMeasurable ℓ volume`);
- `OneClass.exists_admissibleOn_univ_iff_algPlane : ∀ {Λ} [Finite Λ] {N}, IsAlgPattern N → ((∃ ℓ, AdmissibleOn N univ
  ℓ) ↔ ∃ ℓ, AdmissibleOn N ↑E ℓ)` — the second clause;
both on the three. **Two differences of form, each said here.** (1) The second clause's right side is a labelling of
`ℂ` admissible on the set `E`, where the entry has `ℓ : E → Λ`: the same condition — a labelling of `ℂ` restricts to
`E` with the same distances, and a labelling of `E` extends to `ℂ` (by any label: `E` is not empty, so `Λ` is not) —
so the two sides say the same thing. (2) The pattern is a relation `N : ℝ → Λ → Λ → Prop` with the conditions of
`IsAlgPattern`, not required symmetric: `AdmissibleOn` reads every ordered pair `(x, y)`, so a pattern and its
symmetrisation have the same admissible labellings and the statement is the entry's, for every pattern the entry
allows. Its two directions also stand alone, and say more than the entry where they can:
`exists_measurable_admissibleAe` (forward, from the algebraic plane) gives a labelling with **Borel** fibres; and
`exists_admissibleOn_of_ae` (converse) asks only that the distances be positive — not algebraic, not countably many
(FS133-IPQ1's ruled drop) — and is on the three as it was before the join.

**K133-NC-ONE and K133-NC-ALL** (the not-claimed lines) hold of the statements: no value of `m₁(ℝ²)` or of a chromatic
number, `m₁(ℝ²) = δ_Croft` nowhere, no finite graph attaining `sup χ_f`, nothing at a number field's plane, nothing at
six colours; and the result is not this project's: `[Davies2026]` (posted 8 October 2026) proves the same sentence in
dimension four and up and names the plane as its aim — the kernel proof here is this project's, and
`Spectral.residual_fourier`, which the forward halves read, is `[OAIMath2026]`'s, ported.

**No statement says more or less than its entry**, but for the two differences of form in K133-PAIR, each equivalent
and said above. Nothing to message.

## Stage 5 — SAVED (FS133-LD1): the full gate on one commit — `860538ddf` — green on its first pass

One pass ran every step in order, one at a time, under the slot (`data/fs133/ld1/run-gate.sh final 80ac103c1 8`,
FS131-LP1's pass with this landing's steps, launched from a snapshot copy, `build/ld1-run-gate-snapshot.sh`). Every
log is under `data/fs133/ld1/gate/` with its exit status on its last line; `run-pass-final.out` holds every step's
exit, `measure-final.txt` every step's wall time and memory (the scope's charged peak and the largest process's
resident set, by FS131-LJ1's `in-scope.sh`), and `run-gate-final.head` the commit,
**`860538ddfcc8d420ff13970441aa58c03253b900`**, with **no tracked file modified at its start and none after it**.
**Every step exited 0 but the one planted control that must exit 1** (the scan difference's plants). The axiom
self-test's receipt is kept compressed (`receipt-axioms-self-test-final.log.xz`, 23 MB as text). Every count below is
read from the saved logs.

| step | result, read from its saved log (`data/fs133/ld1/gate/<step>-final.*`) | wall | peak / max-rss |
|---|---|---|---|
| build (`BATCH=8`, `--mem 10 --cpus 4`) | "build: OK — 255 of 255 batches, 2 module(s) rebuilt, 0 module(s) with warnings, 7m20s" (`Plane/OneClass/Pair`, restored after the lint's control, and the root); the one log line holding "warning" is that sentence; Lake's full log has 0; then `lake build --no-build Proofs`: "All targets up-to-date (6192 jobs)" | 444 s (slot wait included) | its batches are sibling scopes; 4.46 GiB the build wrapper's largest child |
| `sorry` | the narrow pattern over `Proofs/` and `Proofs.lean`: **0** lines; `\bsorry\b`: 55, every one prose, the port's landing's 55 (this module adds none); the search's plant fired before the pass (three forms appended to a copy of `Pair.lean`: 3 lines found; `data/fs133/ld1/sorry-plant.out`) | — | — |
| `axiom` lines in `Proofs/` | 3 line-initial: the two axioms (`no_proper_five_coloring`, `kloosterman_bound`) and one line of a docstring's code block — `main`'s three; `residual_fourier`'s is gone | — | — |
| doubled names, before the audit | "dupnames: OK — no name is declared by two modules (26 generated on demand)"; its self-test "OK — all 15 controls behaved" | 4.8 s; 25 s | 0.54 / 4.49 GiB; 0.67 / 1.53 |
| axioms | "audited: 9101 records — **9038 clean** on the standard axioms, **32 axiom-free**, **26 imported** (resting on a declared outside theorem), **5 declared purchase(s)**"; "declared imports (2): HadwigerNelson.StandingFive.kloosterman_bound, HadwigerNelson.Outside.OAI158.no_proper_five_coloring"; "axioms: OK"; `CLAUDE.md` § Trust ledger flagged stale, "8961 clean → 9038" (draft 1) | 11 s | 1.17 / 4.95 |
| its self-test | "axioms self-test: OK — every planted fault fired, and every partner passed" | 226 s | 1.39 / 5.21 |
| the records check (`tools/fs133_ld1_records.py`) | "records: PASS" (stage 2.8's eight checks, on this log); its five plants each "FAILED (as it must)" | 0.1 s | — |
| the generator | `tools/fs131_ko1_port.py --check` on the port's 31 modules: **CHECK OK** (unchanged by this job) | 0.8 s | — |
| vacuity | "scanned: **declarations=17902 refutations-skipped=234**"; "sites: **sites=1454 vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2**"; "vacuity: OK"; the baseline's header "match (9 of 9 compared)"; `CLAUDE.md` § The gate flagged stale, "declarations 17785 → 17902, refutations-skipped 232 → 234" (draft 2) | 142 s | 0.78 / 4.63 |
| the scan against the port's landing's, row for row (`tools/fs131_l5_vacdiff.py`) | the counter agrees with both scans; rows 1535 and 1535, lost 0, added 0; "by module: declarations +117, refutations +2: equal to the scans difference" — `Outside/OAI158Rigidity` +2, `Plane/OneClass/SectionDensity` +9, `Defs` +58 (1 refutation), `InvariantLaw` +9, `Field` +1, `Algebraic` +9, `Fractional` +8, `Pair` +21 (1 refutation); "vacdiff: PASS"; its plants "vacdiff: FAIL (5)", exit 1, as they must | 0.1 s | — |
| its self-test | "OK — all 65 controls behaved: every one fired, and the silent ones stayed silent." | 161 s | 0.65 / 4.62 |
| assumptions | "assumptions: OK — 2 outside theorem(s) as axioms, with **27** theorem(s) resting on them; 19 named and 14 inline hypotheses (7 outside, 21 ours, 5 open), taken by 102 statement(s) and mentioned by 1"; the ledger's header and `CLAUDE.md` § Trust ledger "match (9 of 9 compared)" | 164 s | 0.69 / 4.70 |
| its self-test | "OK — all 33 checks behaved: every planted fault fired, and every partner stayed silent." | 171 s | 0.72 / 4.73 |
| architecture | "RESULT: PASS" | 6.1 s | — |
| guarded lint (`lake lint --no-build -- --no-build --trace`, `--mem 8`) | exit 0, "-- Linting passed for Proofs.", 14 linters each "(2/2) Passed!"; its control red before the pass (stage 2.13) | 18 s | 1.27 / 5.09 |
| notes, as the last landing ran them | "notes read: 196 LOCAL-SAID=31 NO-OBJECT=48 NONE-SAID=59 no-conflict=58", the port's landing's count; "self-test: OK (6 controls, 1 planted)" | 4.9 s | — |
| the stored statements (recipe step 8, again) | the dump: "245 constants (58 by name)"; against stage 1's dump, `tools/fs133_ld1_moved.py --strict` with the ruled verdicts: **"MOVED OK"** — IDENTICAL 186, MOVED-IDENTICAL 52, MOVED-INSTANCES-ONLY 3, GENERATED-IDENTICAL 2, **AXIOM-PROVED 1** (`Spectral.residual_fourier`), **BINDER-DROPPED 1** (`ofReal_integral_le_measure_pos`), new 0; its 126 plants "CONTROL OK"; the dump's text is byte for byte the dump after the join (stage 2.6; one sha256, `0850fa7c…`) | 15 s; 0.5 s; 6.6 s | 0.65 / 3.87 |
| the edited files in text, block comments removed, against `74135d1b7` | every file AS-LISTED (stage 2.2's edits and 2.4's argument); the plant DIFFERS in all eight | — | — |
| the baseline and the scans' sources against `main`'s | baseline entries unchanged (2); lines that differ: `scripts/Axioms.lean` 97 (the block), `scripts/Assumptions.lean` 1 (the `.condition`), `scripts/vacuity-baseline.txt` 2 (the header's count line); every other script and the scans' own sources 0 | — | — |
| the three digests against the port's landing's receipts (`data/fs131/lp1/gate/receipt-*-final.log`) | **axioms**: 77 rows added (each `+ … CLEAN`), 0 removed, 0 changed; stale: `CLAUDE.md` § Trust ledger's "8961 clean" (with it the sentence's "9,024 records"). **vacuity**: "counts: declarations 17785 → 17902, refutations-skipped 232 → 234", "rows: none changed"; stale: `CLAUDE.md` § The gate's count line. **assumptions**: one row added, `CONDITION HadwigerNelson.OneClass.IsShiftInvariantLaw`; counts of the scan's own constants up by the module (constants 16893 → 17057, theorems 12750 → 12888, formers 379 → 386, conditions 40 → 41); the nine counts unchanged; nothing stale | — | — |

**The brief's prediction, and this landing's, against the gate**: the audit 9,101 records — 9,038 clean, 32
axiom-free, 26 imported, 5 purchases — with 2 declared imports and 2 library axioms; the nine assumption counts
unchanged; no new site. **Met, each count.** The two refutations the scan now skips are the module's, each a statement
whose conclusion the scan reads through to `→ False` and which refutes nothing: `Plane.isIndepSet_ball_half` (a disc of
radius `1/2` is independent: `IsIndepSet` is "no two points adjacent", a negation; the statement is closed) and
`OneClass.AdmissibleOn.mono` (admissibility on a subset; `AdmissibleOn` is a negation under binders) — both read here.
The module's binders that are hypotheses read `GENERIC` (no colouring binder of a tracked predicate): their models are
FS133-ICD1's DD2 and FS133-IPQ1's DQ2, checked by the elaborator in `data/fs133/ipq1/work/Models.lean`; the scan adds
no site for them.

**Read against the informal claim** (stage 4 in full). The claim of this landing: the density equality —
`α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, `f(n)/n → m₁(ℝ²)` — and the labelling claim
both ways are theorems of this library, checked by this kernel, on the standard three axioms, through `[OAIMath2026]`'s
rigidity step, whose proof is ported. What the gate shows: no `axiom` and no `sorry` enters `Proofs/`; the library
declares the same two axioms as before, neither of them this module's; every record of the module is audited on the
three or fewer; no name is declared twice, so each printed list is the list of the proof the kernel checked; the
axiom the branch declared is gone and the port's theorem of that name has its stored type; no stored statement of the
module moved between the build before the merge and this commit but the one ruled binder. **What the gate does not
show, and this record says**: that the result is new (it is not: `[Davies2026]`); any value of `m₁(ℝ²)`; that the
release's mathematics is right beyond what its Lean proves.

## Drafts for the front page (FS133-LD1)

*For the coordinator to file; this job files none of them. Each draft names its slot: the file, the section, and the
exact words it replaces or follows; `data/fs133/ld1/drafts-slots.py` checks that each slot occurs exactly once (on
this branch, whose front files are `main`'s unchanged and whose `ARCHITECTURE.md` rows are the ones the filing edits;
output `data/fs133/ld1/drafts-slots.out`: 29 slots, each once; the control string absent). Each count names the log
line it comes from; the gated commit and its logs are stage 5 (`data/fs133/ld1/gate/*-final.*`; the scans' full
outputs `receipt-axioms-final.log`, `receipt-vacuity-final.log`, `receipt-assumptions-final.log`).*

**Whose it is.** The statement is not new: a paper posted on 8 October 2026 proves the same sentence in dimension four
and up and names the plane as its aim (`[Davies2026]`; the claim list's K133-NC-ALL). The kernel proof — the
statements (FS133-K1's), the proofs (FS133-IA1, -IB1, -IB2, -ICD1, -IPQ1's) and this landing — is this project's.
The transfer and the residual Fourier step (`Outside.OAI158.Spectral.residual_fourier`: the release's Theorem 2.3
composed with the spectral theorem) are `[OAIMath2026]`'s, family 158, its proofs ported (FS131-KO1 to FS131-LP1).
No value moves: the kernel holds `1/7 ≤ m₁(ℝ²) ≤ 1` and nothing else about the number.

**1. `CLAUDE.md` § Trust ledger, the audit's sentence.** *Replaces* "the current audit reads 8961 clean and 5 declared
purchases, and 26 imported (and 32 axiom-free; 9,024 records at the landing of the port of `[OAIMath2026]`'s transfer
proof, FS131-LP1, 2026-10-14)". From `axioms-final.log`, "audited: 9101 records — 9038 clean on the standard axioms,
32 axiom-free, 26 imported (resting on a declared outside theorem), 5 declared purchase(s)":

> the current audit reads 9038 clean and 5 declared purchases, and 26 imported (and 32 axiom-free; 9,101 records at the
> landing of FS-133's density equality, FS133-LD1, 2026-10-14)

9,024 + 77 = 9,101 (the module's records: stage 2.9); clean 8,961 + 77 = 9,038; axiom-free, imported, purchases
unchanged.

**1b. The same paragraph.** *Follows* "its first import, `[Falconer1981]` Lemma 2 (i), is a theorem since FS131-IF1."
*with*

> The release's rigidity step `Outside.OAI158.Spectral.residual_fourier` (`[OAIMath2026]` family 158, `Ergodicity.lean`
> l. 403: its Theorem 2.3 composed with the spectral theorem) never entered `main` as an import: FS-133's branch
> declared it as an axiom over six copied definitions, and at the density equality's landing the copies and the axiom
> were deleted and the port's theorem read, its stored type the declared one's constant for constant (FS133-LD1); the
> fourteen records that rested on it there are clean.

**2. `CLAUDE.md` § The gate, the vacuity scan's counts.** *Replaces* "`declarations=17785 refutations-skipped=232
sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`." From `vacuity-final.log`, "scanned:
declarations=17902 refutations-skipped=234" and "sites: sites=1454 vacuous=0 stale=0 declared=3 witnessed=38
generic=1411 unknown=2":

> `declarations=17902 refutations-skipped=234 sites=1454`, `vacuous=0 stale=0 declared=3 witnessed=38 generic=1411 unknown=2`.

Two counts move: declarations +117, refutations +2, both the module's (stage 5's vacdiff, module by module). No site
is added. The baseline's header is refiled on the branch.

**3. `CLAUDE.md` § Trust ledger, the nine counts.** *No change.* `receipt-assumptions-final.log`'s totals read
`axioms=2 rests=27 named=19 inline=14 outside=7 ours=21 open=5 takes=102 mentions=1`, and the step reports
"recorded counts in CLAUDE.md § Trust ledger: match (9 of 9 compared)". The module adds no axiom and no declared
hypothesis; it adds one `.condition` (`OneClass.IsShiftInvariantLaw`, stage 2.10), which no count reads.

**4. `CLAUDE.md` § Frontier, Last filed.** *Replaces* "Last filed: **the landing of the port of `[OAIMath2026]`'s
transfer proof** (FS131-LP1, 2026-10-14:" *by*

> Last filed: **the landing of FS-133, the density equality** (FS133-LD1, 2026-10-14: `Outside/OAI158Rigidity` and
> the seven modules of `Plane/OneClass` through the gate on the standard three axioms — 77 records; `α₁(ℝ²) = α₁(𝒜²) =
> m₁(ℝ²)`, `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, `f(n)/n → m₁(ℝ²)` and the labelling claim both ways; the rigidity
> step `[OAIMath2026]`'s, ported; FS-133 Closed; the statement not new, `[Davies2026]`; no value moved); before it **the
> landing of the port of `[OAIMath2026]`'s transfer proof** (FS131-LP1, 2026-10-14:

**5. `CLAUDE.md` § Frontier, Open milestones, FS-133.** *Replaces* "**Derived 2026-10-07: FS-133, the one-class
transfer** (`plans/FS133-E1-derivation.md`, 13 entries, each derived, one mind; stub `plans/STUB-one-class-transfer.md`;
a short milestone, unranked — it bears none on six against seven): `α₁(ℝ²) = m₁(ℝ²)` and `χ_f,0(ℝ²) = χ_f(ℝ²) =
1/m₁(ℝ²)` with no hypothesis, over `[OAIMath2026]`'s rigidity theorem (row 129); Closed when its Lean module passes the
gate." *by*

> **Closed 2026-10-14: FS-133, the one-class transfer** (Derived 2026-10-07, `plans/FS133-E1-derivation.md`, 13
> entries, each derived, one mind; stub `plans/STUB-one-class-transfer.md`; a short milestone, unranked — it bears none
> on six against seven; its Lean module through the gate, FS133-LD1): `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, `χ_f,0(ℝ²) =
> χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)` and `f(n)/n → m₁(ℝ²)` with no hypothesis, and for a finite set of labels and forbidden
> pairs at countably many positive algebraic distances an admissible labelling of the plane exists iff one of the
> algebraic plane does, iff a Lebesgue-measurable one admissible almost everywhere does — each kernel-checked on the
> standard three axioms, through `[OAIMath2026]`'s rigidity step `Outside.OAI158.Spectral.residual_fourier`, ported
> (row 129; `OneClass.finIndepRatio_plane_eq_mOne`, `finIndepRatio_algPlane_eq_mOne`,
> `iSup_fractionalChromaticNumber_plane`, `fractionalChromaticNumber_plane`, `fractionalChromaticNumber_algPlane`,
> `tendsto_minIndepNum_div`, `exists_admissibleOn_univ_iff_ae`, `exists_admissibleOn_univ_iff_algPlane`). Not new:
> `[Davies2026]` proves the same sentence in dimension four and up and names the plane as its aim; the kernel proof is
> this project's.

**6. `CLAUDE.md` § Publication, "Held so far".** *Replaces* "with no hypothesis, over `[OAIMath2026]`'s rigidity
theorem, row 129 (FS-133; one mind) answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and `[MatolcsiEtAl2025]`
§2's equality question." *by*

> with no hypothesis, row 129's plane clause (FS-133) answers the first clause of `[DuczVarga2026]`'s Conjecture 1 and
> `[MatolcsiEtAl2025]` §2's equality question — formalized: in the kernel since FS133-LD1, on the standard three axioms,
> through `[OAIMath2026]`'s rigidity step, ported; the statement is not new (`[Davies2026]`, in dimension four and up,
> names the plane as its aim), the kernel proof is this project's.

(The list this clause sits in opens "Held so far at [hand]:"; with this clause in the kernel, the filing may want the
head to say so.)

**7. `CLAUDE.md` § The aim, the program.** *Replaces* "on `[OAIMath2026]`, **FS-132, six by the nerve**, and **FS-133,
the one-class transfer**;" *by* "on `[OAIMath2026]`, **FS-132, six by the nerve**, and **FS-133, the one-class transfer —
closed** (row 129; FS133-LD1);".

**8. `CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval".** *Follows* "The lower bound
of four against every colouring, the three-colour criterion and the clause for subfields are this project's, with every
kernel proof;" *with* (FS133-ICD1's DD4 and FS133-IPQ1's DQ3, corrected: on the standard three, C133-PAIR held)

> **the density equality for the plane** (FS-133, FS133-LD1): `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)` — the infimum of
> `α(G)/|G|` over finite point sets of the plane, and of the algebraic plane, is the supremum of the upper densities of
> the measurable sets with no two points at distance one — and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, and
> `f(n)/n → m₁(ℝ²)` (`[DuczVarga2026]` Conjecture 1, first clause; `[MatolcsiEtAl2025]` §2's equality question)
> (`OneClass.finIndepRatio_plane_eq_mOne`, `…_algPlane_eq_mOne`, `fractionalChromaticNumber_plane`,
> `iSup_fractionalChromaticNumber_plane`, `fractionalChromaticNumber_algPlane`, `tendsto_minIndepNum_div`); and
> labellings with forbidden pairs of labels at countably many positive algebraic distances — the plane has one admissible
> at every pair iff the algebraic plane has one, iff the plane has a Lebesgue-measurable one admissible almost
> everywhere (`OneClass.exists_admissibleOn_univ_iff_algPlane`, `…_iff_ae`; the converse at any positive distances,
> algebraic or not, `exists_admissibleOn_of_ae`); all on the standard three axioms, through `[OAIMath2026]`'s
> `Spectral.residual_fourier`, ported. Not claimed: any value of `m₁(ℝ²)` beyond `1/7 ≤ m₁(ℝ²)`, or of a chromatic
> number; `m₁(ℝ²) = δ_Croft`; anything at a number field's plane or at six colours; that the result is new
> (`[Davies2026]`). The kernel proof is this project's;

**9. `LEDGER.md` row 129, its grade.** *Replaces* "the plane's clause since FS-133 not MR's: C133-ONE [hand], one
mind, kernel pending, over `[OAIMath2026]` Theorem 2.3 (kernel-checked in the release's library, audited:
`plans/EXT-OAI1-audit.md`)" *by*

> the plane's clause since FS-133 not MR's: C133-ONE and C133-FN **[kernel]** since FS133-LD1
> (`OneClass.finIndepRatio_plane_eq_mOne`, `finIndepRatio_algPlane_eq_mOne`, `iSup_fractionalChromaticNumber_plane`,
> `fractionalChromaticNumber_plane`, `fractionalChromaticNumber_algPlane`, `tendsto_minIndepNum_div`; each on
> `[propext, Classical.choice, Quot.sound]`), through `[OAIMath2026]` Theorem 2.3 composed with the spectral theorem —
> the release's `Spectral.residual_fourier`, its proof ported (`Outside/OAI158Ergodicity`, FS131-KO1 to FS131-LP1);
> the interval `[4.04876, 4.35987]` for `1/m₁(ℝ²)` is the literature's (`[AmbrusEtAl2023]` Theorem 1; Croft's set), not
> the kernel's, which holds `1/7 ≤ m₁(ℝ²) ≤ 1`

The rest of the row keeps its grade: the field form (given MR), FS-103's certificates and the mechanism.

**10a. `plans/FRONTIER-STUBS.md` § Open milestones, FS-133.** The same slot and the same replacement as draft 5.

**10b. The same file, § Closed, absorbed and demoted.** *Follows* "## Closed, absorbed and demoted" *with* the line

> * **FS-133 the one-class transfer** — `plans/STUB-one-class-transfer.md`. Derivation `plans/FS133-E1-derivation.md`;
>   kernel plan `plans/FS133-kernel-plan.md`; landing `plans/FS133-LD1-landing.md`; close inventory
>   `plans/FS133-close-inventory.md`. **Closed 2026-10-14**: its Lean module (`Outside/OAI158Rigidity`, `Plane/OneClass`,
>   eight files, 77 records) through the gate on the standard three axioms (row 129's plane clause, C133-FN, C133-PAIR);
>   the rigidity step `[OAIMath2026]`'s, ported; the statement not new (`[Davies2026]`).

**10c. `plans/STUB-one-class-transfer.md`, the banner.** *Replaces* the banner line "> **Derived 2026-10-07 (FS133-E1;
FS-133 inventory item 3).** All four posed claims are derived, [hand], one mind, kernel pending: … Closed when its Lean
module passes the gate." (the whole line) *by*

> > **Closed 2026-10-14 (FS133-LD1): its Lean module passed the gate.** `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, `χ_f,0(ℝ²) =
> > χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`, `f(n)/n → m₁(ℝ²)` and the labelling claim both ways are kernel theorems on the
> > standard three axioms (`Plane/OneClass`; `plans/FS133-LD1-landing.md` stage 4 reads each aloud against the claim
> > list), through `[OAIMath2026]` family 158's rigidity step, ported (`Outside.OAI158.Spectral.residual_fourier`). Derived
> > 2026-10-07 (FS133-E1; FS-133 inventory item 3): `plans/FS133-E1-derivation.md`; row 129 carries it. Prior art: the
> > statement is not new — `[Davies2026]` (8 October 2026) proves it in dimension four and up and names the plane as its
> > aim (`plans/FS131-ER1-davies-reading.md`).

**11. `ARCHITECTURE.md`.**
- *(a) § Trust, Imported outside theorems:* the row whose head is "| `Outside.OAI158.Spectral.residual_fourier`
  (`Outside/OAI158Rigidity`) | `[OAIMath2026]` family 158, `lean/OAI/Analysis/PlaneSpectrum/Ergodicity.lean` line 403
  at commit `adc7f124`" *removed* (it came to `main` with this branch; the axiom is gone).
- *(b) the paragraph under the table, following* "is a theorem since FS131-IF1 — `falconer_lemma2_nonempty`, proved in
  `Plane/MetricalBoundary` — and is no longer in this table." *:* " `Outside.OAI158.Spectral.residual_fourier`
  (`[OAIMath2026]` family 158, `Ergodicity.lean` l. 403), declared on FS-133's branch over six copied definitions, never
  reached `main` as a purchase: at the density equality's landing it is the port's theorem (`Outside/OAI158Ergodicity`),
  its stored type the declared one's, and its fourteen consumers are clean (FS133-LD1)."
- *(c) the row of `Outside/OAI158Rigidity`, its description cell* (head "**FS-133 (planned by FS133-K1, proved by
  FS133-IA1; no `sorry`). One imported outside theorem**", to the cell's end "… (the regular representation on `ℓ²` of
  the algebraic plane, the point mass at the origin; on the standard three) are proved.") *replaced by* "**FS-133
  (planned by FS133-K1, proved by FS133-IA1; landed by FS133-LD1; no `sorry`).** Two vectors and a model, over
  `[OAIMath2026]`'s `Spectral.residual_fourier`, a theorem of the port (`Outside/OAI158Ergodicity`; the release's Lean
  lemma, `Ergodicity.lean` l. 403 — its Theorem 2.3 composed with the spectral theorem): `residual_fourier_cross` (two
  rotation-fixed vectors orthogonal to the continuous vectors are uncorrelated at every non-zero translate, by
  polarisation) and `residual_fourier_model` (the regular representation on `ℓ²` of the algebraic plane, the point mass
  at the origin), each on the standard three. The module first declared the lemma as an axiom over six copied
  definitions (FS133-IA1); the landing removed both and reads the port's (`plans/FS131-KO1-port-plan.md` § 4.5)."
- *(d) the seven rows of `Plane/OneClass`, their leads:* `SectionDensity`, `Defs`, `InvariantLaw` — "**FS-133 (FS133-K1;
  a skeleton).**" *by* "**FS-133 (FS133-K1's statements, FS133-IB1's proofs; landed by FS133-LD1; no `sorry`).**" for
  `SectionDensity`; the same with "FS133-IB1's proofs, two lemmas FS133-IB2's" for `InvariantLaw` and "FS133-IB2's
  proofs" for `Defs` (for `SectionDensity` add: "`ofReal_integral_le_measure_pos` for any measure: an unread
  `[IsProbabilityMeasure μ]` dropped at the landing (inventory item 789)"; for `Defs`: "three lemmas made public by
  FS133-ICD1 (`upperDensity_congr_ae`, `card_le_indepNum_induce`, `exists_indep_card_eq_indepNum`)"); `Field` —
  "**FS-133 (FS133-K1 the statement, FS133-IA1 the proof; no `sorry`), on the imported `Spectral.residual_fourier`.**"
  *by* "**FS-133 (FS133-K1 the statement, FS133-IA1 the proof; landed by FS133-LD1; no `sorry`), through `[OAIMath2026]`'s
  `Spectral.residual_fourier`, ported.**"; `Algebraic`, `Fractional`, `Pair` — "**FS-133 (FS133-K1; a skeleton), on the
  imported `Spectral.residual_fourier`.**" *by* "**FS-133 (FS133-K1's statements, FS133-ICD1's proofs [`Pair`: and
  FS133-IPQ1's]; landed by FS133-LD1; no `sorry`), through `[OAIMath2026]`'s `Spectral.residual_fourier`, ported.**" (for
  `Algebraic` add: "its imports include Mathlib's `Analysis.Subadditive` (FS133-ICD1, accepted by inventory item 779
  ruling 2)"; for `Pair`: "one unread binder dropped from `exists_admissibleOn_of_ae`, FS133-IPQ1").
- *(e) two stale names in those rows* (`tools/check_architecture.py` [3] lists both as declared nowhere): in
  `Algebraic`'s row "**C133-ALG** `IsInvariantLaw.measure_zero_le_mOne`" → "**C133-ALG**
  `IsInvariantLaw.measure_origin_le_mOne`"; in `InvariantLaw`'s row "C133-INV-CLASS: `IsShiftInvariantLaw.measure_zero_le`
  (any graph)" → "C133-INV-CLASS: `IsShiftInvariantLaw.measure_origin_le` (any graph)" (FS133-ICD1's naming note).

**12. `LEAN.md`** — the implementers' lines, from their records (none is on `main`), and this landing's.
- *(a) § Assumptions, the item-2 bullet, following* "the landing runs it again on the module as recompiled on the joined
  tree.": FS133-IA1's D5, verbatim from `plans/FS133-IA1-implementation.md` (on this branch) § Drafts, D5.
- *(b) § Searching — Lean, following its last bullet* (ending "and the linter's name must be declared where the
  attribute is elaborated (`data/fs131/lp1/nolint/probes/attrs.lean`; FS131-LP1)."), in this order and verbatim from
  the records on this branch: FS133-IA1's D6 (four bullets), FS133-IB1's DB6 (six), FS133-IB2's DC5 (three),
  FS133-ICD1's DD5 (five), FS133-IPQ1's DQ6 (three), and this landing's three:
  - *"A join that brings a port can turn a simp argument of a proof that stays unused: the port's `@[simp]` lemmas
    enter every module downstream of it, and a fact a proof gave `simp` by hand is found by `simp` itself — the build's
    `unusedSimpArgs` warning, which the gate's zero-warning line reads. `simp?` on a copy names the lemmas that took
    over (`Spectral.kCoeff_inv`, `kCoeff_ne_zero`, `Outside/OAI158Basic`; `residual_fourier_model`, FS133-LD1)."*
  - *"Across a join that deletes copies and reads a port's declarations, a statement dump made per module loses the
    moved constants: dump the old modules' every constant before the merge and, after it, the same names found where
    they are now declared (`env.getModuleIdxFor?`), then compare by name with the moves, the axiom proved and the
    instance-only values ruled (`data/fs133/ld1/lean/StatementDump.lean`, `tools/fs133_ld1_moved.py`, FS133-LD1). A
    statement with two instance binders prints both `inst`; a dropped one is named by its occurrence (`inst#2`)."*
  - *"A structure taken as a hypothesis whose only model is the projection of a child structure's model
    (`(isInvariantLaw_dirac G).toIsShiftInvariantLaw`) reads `undeclared-never-concluded` to the assumptions step:
    no declaration concludes it as stated. Declare it a `.condition` with that model in its reason
    (`OneClass.IsShiftInvariantLaw`, FS133-LD1)."*

**13. `tools/claude_md_fact_audit.py`, `GATE_CHANGES`.** One entry after `(("7531", "5"), ("8961", "5")):`'s:

```python
    (("8961", "5"), ("9038", "5")): "FS-133, the landing of the density equality — Outside/OAI158Rigidity and Plane/OneClass through the gate: alpha_1(R^2) = alpha_1(A^2) = m_1(R^2), chi_f,0(R^2) = chi_f(R^2) = chi_f(A^2) = 1/m_1(R^2), f(n)/n -> m_1(R^2) and the labelling claim both ways, on the standard three axioms through [OAIMath2026]'s Spectral.residual_fourier, ported (the copies and the axiom of FS-133's branch deleted at the join); the statement not new ([Davies2026]), the kernel proof ours (FS133-LD1; copy data/fs133/ld1/gate/receipt-axioms-final.log, gated commit 860538ddf): 9,101 records, 9,038 clean, 32 axiom-free, 26 imported, 5 purchases",
```

**13b. The same file's table of superseded counts.** Every token the drafts retire, in that table's form, each with its
value as the reason: `"8961"` (9038 clean); `"9,024"` and `"9024"` (9,101 records); `"declarations=17785"`,
`"17785"` (17902); `"refutations-skipped=232"`, `"232"` (234 — the bare number, which the audit tokenizes alone: FC4's
ruling on `"228"`); `"declarations=17785 refutations-skipped=232 sites=1454"` (17902, 234). The reason for each:
"superseded gate count, refiled at FS133-LD1's landing from data/fs133/ld1/gate/receipt-axioms-final.log (the vacuity
count from receipt-vacuity-final.log); the old count stays in data/fs131/lp1/gate/ and in GATE_CHANGES". **The next
landing's previous receipts are `data/fs133/ld1/gate/receipt-{axioms,vacuity,assumptions}-final.log`.**

**14. `BIBLIOGRAPHY.md`, `[OAIMath2026]`'s row, what rests on it.** *Follows* "is the release's theorem with its proof
ported since FS131-IPD1's switch and FS131-LP1's landing, and its twelve records are clean;" *with* " its rigidity step
`Spectral.residual_fourier` (`Ergodicity.lean` l. 403; Theorem 2.3 composed with the spectral theorem) is read by
FS-133's density equality as the port's theorem, and its fourteen consumers there are clean (FS133-LD1);".

## Open gate items at this landing

*Each named, with what would close it; none of them is a red check of this gate.*

1. **`lean4checker`** (the publication gate, `LEAN.md` § Trust ledger) has not been run over this module or the port.
2. **The proof edit in a kept declaration** (stage 2.4): `residual_fourier_model`'s `simp [hx, hne]` → `simp [hx]`,
   against the recipe's "character for character"; the `have hne` it fed stays, unread. The coordinator rules whether
   it stands or whether the dead `have` goes too.
3. **`IsShiftInvariantLaw` declared a `.condition`** (stage 2.10), on this landing's word; an alternative is a theorem
   concluding it at its model, which would be a new statement and is not this brief's.
4. **Item 798's three instances-only values** (`approxField`, `approxIndex`, `measurableField`) stand as ruled: their
   values cite other generated proof auxiliaries; nothing downstream stores them.
5. **Carried from the port's landing** (item 840), unchanged here: `scripts/Vacuity.lean` line 561's history paragraph;
   EXT-OAI1's line count; `hexShell_plane5`'s classing; the generator's text-only statement guard; ADAPTED_VALUE.
6. **`ARCHITECTURE.md`'s rows' prose** (draft 11) is the filing's; on this branch the rows still say "a skeleton" and
   "on the imported `Spectral.residual_fourier`", and `check_architecture.py` [3] lists the two stale names of draft
   11 (e), which do not fail it.

## Stage 6 — SAVED (FS133-LD1): the green line, and where the branch stands

- **The gated commit is `860538ddf`**, on `fs133-wl1` in `.claude/worktrees/fs133-wk1`; the commits after it add only
  records (this file, `data/fs133/ld1/`, the report). Nothing is pushed (the brief: the server is unreachable); the
  merge into `main` is the coordinator's. `main` has moved since the merge, in `data/` and `plans/` only (nine files,
  none the gate reads), so a merge of this branch into it should meet no conflict outside those.
- The tree's `.lake/build` is the gated build: `lake build --no-build Proofs` "All targets up-to-date (6192 jobs)".
- No process of this job is running or queued (`ps`, the slot's ledger: only other jobs' slots).
- The drafts' slots: `data/fs133/ld1/drafts-slots.py` "slots: 29 checked on HEAD, control absent: yes; SLOTS OK"
  (`drafts-slots.out`).
