# FS131-IPA1 — the port of `[OAIMath2026]`'s transfer proof, lanes A (the spectral base) and B (the factor base)

*de Bruijn, the implementer; job FS131-IPA1 (brief: `data/fs131/briefs/FS131-IPA1-port-lanes-ab.md`, on `main`).
Branch `fs131-wpa`, cut from `fs131-wp1` at `89b6a57a3` in the worktree `.claude/worktrees/fs132-wi1`. Working files:
`data/fs131/ipa1/`. The plan is `plans/FS131-KO1-port-plan.md` (this branch). The outside release is `[OAIMath2026]`
family 158 at commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read, never written or
run).*

## Theorems this phase proved

None of this project's mathematics. The phase makes modules of the release's own lemmas, each elaborated at this pin
with every proof checked by this kernel (the farm of the plan's § 4.1: `lean -o` with the lakefile's options by flag,
not `./scripts/build.sh`); they are not registered in the library (lane D registers). The kernel receipts per module
are in the stages below.

## Stage 1 — SAVED: the readback

**1.1 The brief's quotations** — `tools/fs131_ipa1_readback.py` (the planner's reader, pointed at this brief and at the
main tree, where the brief and its sources are committed; this branch is cut before them): **3 matched, 0
mismatched**, exit 0 (`data/fs131/ipa1/readback-brief.out`) — W4 against `data/fs131/REQUEST-2026-10-13.md`; items
758 and 759 against `plans/FS131-close-inventory.md`. `--fault` (the last character of each quotation changed): 0
matched, 3 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.2 The branch.** `fs131-wpa` cut from `fs131-wp1` at `89b6a57a3` (the tree's head at launch, clean).

**1.3 The generator, frozen, run as item 759 says** (`tools/fs131_ko1_port.py`, unchanged):
- `--parse-all`: `PARSE OK: every file of the plan reads as scopes, declarations and scaffolding` (exit 0;
  `data/fs131/ipa1/gen-parse-all.out`);
- the trial's three modules generated into `Proofs/HadwigerNelson/Outside/` from their tables (`gen-trial-write.out`):
  `OAI158Basic` 928 lines sha256 `bb74393f…`, `OAI158InvariantMean` 1,234 `55d8909d…`, `OAI158Centers` 872
  `5c6193de…` — **byte-identical to the trial's copies** (`data/fs131/ko1/trial/generated/SHA256SUMS`, the full
  hashes equal);
- `--self-test`: `SELF-TEST OK: 19 plants refused and 2 partners accepted` (exit 0; `gen-selftest.out`);
- `--check --modules OAI158Basic,OAI158InvariantMean,OAI158Centers`: `CHECK OK` (exit 0; `gen-check-trial.out`).

**1.4 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the plan `plans/FS131-KO1-port-plan.md` whole; the generator whole; the three trial tables and the farm
script `data/fs131/ko1/farm1.sh`.

*A slip of order, recorded:* this stage's section was committed after lane A's first elaborations had begun (the
readback itself ran first, and nothing of it changed); nothing of stage 2 is claimed here.

## Stage 2 — SAVED: lane A, the spectral base — ten modules generated, elaborated and read back

*Everything here is from `lean -o` in the scratch farm (`data/fs131/ko1/farm1.sh`, unchanged, driven by
`data/fs131/ipa1/farm-run.sh` and `farm-all.sh`), not from `./scripts/build.sh`. Rulings received mid-stage: the
coordinator's three of Amendment 1 (quoted in his message of this session; the brief's amendment is on `main`), each
applied below.*

**2.1 The five receipts, per module.**

| module | patches (source lines) | instances in the table | elaboration (final run) | read-back |
|---|---|---|---|---|
| `OAI158Basic` | 4 (the trial's) | 1 scoped, 15 global | 0 errors, 0 warnings | IDENTICAL / UP-TO-INSTANCES; 2 PIN-DIFFERENCE |
| `OAI158InvariantMean` | 0 | 2 global | 0, 0 | 1 PIN-DIFFERENCE |
| `OAI158SmallArcs` | 2: 160 `ite_eq_left` → `if_pos`; 266 `compProd_map_condDistrib` loses `hX` | — (2 `local`) | 0, 0 | clean |
| `OAI158PhaseEncoding` | 2: 118 `Finset.prod_le_prod₀` → `Finset.prod_le_prod`; 210 `Measurable.of_eval` → `measurable_pi_lambda` | — | 0, 0 | 2 UP-TO-INSTANCES by the ANTIDIAG rule |
| `OAI158Characters` | 2: 187 `Set.mem_ofPred_eq` → `Set.mem_setOf_eq`; 553 `Set.ofPred_true` → `Set.setOf_true` | 1 scoped (461, `Countable F`, `F` an abbreviation of Mathlib's `algebraicClosure ℚ ℝ`) | 0, 0 | clean |
| `OAI158PhaseCollision` | 1: 368 `dite_eq_left` → `dif_pos` | — (4 `local`) | 0, 0 | clean |
| `OAI158Multipliers` | 2: 38–39 `eLpNorm_congr_norm_ae` loses its two measurability arguments | 1 global (83) | 0, 0 | clean |
| `OAI158ConditionalSelection` | 3: 200 `condDistrib_comp` takes the map, and `have _ := hp` keeps the statement's `hp` referenced; 209 `condDistrib_self` takes the map; 330 the `IsProbabilityMeasure (μ.map p)` instance supplied by `haveI` from `hp` | — (2 `local`) | 0, 0 | clean |
| `OAI158FourierTests` | 1: 241 `infer_instance` → `exact Measure.isProbabilityMeasure_map (by fun_prop)` — the **RULED statement change** (2.3) | 1 global (238) | 0, 0 | 1 RULED |
| `OAI158ConditionalSpectrum` | 3: 130, 133 `(Complex.isIntegral_I ℚ)` → `Complex.isIntegral_rat_I`; 254 `Set.preimage_ofPred_eq` → `Set.preimage_setOf_eq` | 1 global (38, `PolishSpace D`) | 0, 0 | clean |

Receipt 1, `--check` on the ten: **`CHECK OK`** (`data/fs131/ipa1/gen-check-laneA.out`). Receipt 2: the final run in
dependency order, every module 0 errors and 0 warnings (`farm-laneA-final.out`; `farm/<module>-final.out`, and
`-final2.out` for FourierTests and ConditionalSpectrum after FourierTests' header was rewritten; every attempt's log is
kept, `farm/*-try*.out`). Seconds per module: 3–13, Basic 223 of which most was the slot's queue. Receipt 3, the
axioms (`data/fs131/ipa1/axioms/`, a footer that walks every constant the ten modules declare, instances, private and
generated ones included, through `Lean.collectAxioms`): **`SUMMARY constants=770 clean=770 other=0`** — every one a
subset of the standard three; the control (a scratch module `PlantSorry` with one theorem proved by `sorry`, imported
beside them): `NOTCLEAN PlantSorry ipa1PlantedSorry #[sorryAx]`, `constants=771 clean=770 other=1`. Receipt 4, the
read-back (2.2). Receipt 5, the tables (stage 4).

**2.2 The read-back across pins** — `tools/fs131_ipa1_readback_port.py` (FS132-I2's comparator imported as a module,
as FS133-IA1 did, with this job's table: every source declaration of each release file — whole files — and every
generated auxiliary the cone lists for it; both roots and this library's namespace written `§.`; `Set.ofPred` →
`setOf`; ANON, ANTIDIAG, PIN-DIFFERENCE, RULED and ADAPTED, each stated in its docstring). 690 constants printed at
each pin by one dumper (`data/fs131/ipa1/readback/laneA/`; `ReleaseDump` at the release's pin by
`data/fs131/ko1/leanrel.sh`, `HereDump` from the farm's oleans by `lean1.sh` with `data/fs131/ipa1/leanpath-farm.txt`;
109 s and 106 s). **`READBACK OK`** (`compare.out`; non-IDENTICAL rows in `verdicts.tsv`):

| class | IDENTICAL | UP-TO-INSTANCES | PIN-DIFFERENCE | RULED | AUX-ABSENT / AUX-DIFFERS |
|---|---|---|---|---|---|
| definitions (109) | 82 | 24 | 3 | — | — |
| lemmas (346) | 274 | 71 | — | 1 | — |
| generated auxiliaries (235) | 152 | 18 | 40 | — | 8 / 17 (counted, as in FS132-I2) |

83 constants differ inside instance and proof arguments, every one Mathlib's, core's or a generated proof
(`instance-constants.txt`, read). Self-test (`selftest.out`): **13 plants refused, the unplanted pair passes** — a
constant in a statement, a numeral in a definition, a binder kind, a declaration missing, a theorem made an axiom, a
truncated print, a stale record, the RULED binders with one other binder inserted and with a second `MeasurableInv`
inserted, the antidiagonal's type argument changed, the ANTIDIAG rule withdrawn, a PIN-DIFFERENCE owner's full type
changed, the `Set.ofPred` rename withdrawn.

*The naming class ANON, found by the first comparison:* an anonymous instance's generated name carries a suffix made
from the root of its module — `instMeasurableSpaceCircle_oAI_1` at the release, `…_proofs_1` here (twelve `local
instance`s and two `DecidableEq`s); the first run read them ABSENT and their users DIFFERENT; with the release's name
written `_proofs`, every one of them is IDENTICAL or UP-TO-INSTANCES.

**2.3 The three findings sent to the coordinator, and his rulings (Amendment 1).**
1. **`DifferenceFourier.differenceLaw_probability` (FourierTests.lean:238) needs two binders at this pin** —
   `differenceLaw ν κ := ((κ ×ₖ κ) ∘ₘ ν).map (fun p => p.1 / p.2)` over `[MeasurableSpace G] [CommGroup G]`; at v4.32.0
   `Measure.map` of a map that is not almost-everywhere measurable is `0`, so the release's statement is false here
   without the division's measurability. The proof patch pulled the section's `[MeasurableMul₂ G] [MeasurableInv G]`
   into the instance's stored type (an instance is elaborated like a definition: section variables its body uses become
   binders). **Ruled: accepted as a RULED statement change**, exactly those two binders, checked by the strip check
   (the erased type with one binder of each class removed and its `@k` renumbered equals the release's), with two
   planted controls refused, listed in the module's header (the patch's reason opens "RULED STATEMENT CHANGE"). Every
   later use elaborated here supplies them (ConditionalSpectrum, 0 errors).
2. **`Finset.HasAntidiagonal`'s class parameter** is `[AddMonoid A]` here, `[Add A]` there; a projection takes it
   implicitly, so the erased print kept it and `PhaseEncoding.newton_elem` and `filtered_antidiagonal_sum` read
   DIFFERENT. **Ruled: up to instances, by a named rule** (ANTIDIAG: that one argument written `_` in both erased prints),
   with two controls.
3. **Mathlib's `Monoid` changed its parents** (`extends Semigroup M, MulOneClass M, NPow M` here,
   `Algebra/Group/Defs.lean:673`; `extends One M, Mul M, Semigroup M, MulOneClass M, NPow M` there,
   `Algebra/Group/Monoid.lean:390`), so the values of the three `deriving` instances `Spectral.instCommGroupDiscreteE`,
   `Spectral.instCommGroupDiscreteF`, `InvariantMean.instAddCommGroupPeriodGroup` differ. **Ruled: a pin difference**
   (same text, same types — the comparator requires the full type prints identical —, values by this pin's Mathlib);
   nothing patched. `instCommGroupDiscreteE` stays identical at this pin to the density branch's copy (trial 3.4).

**A tool note for the generator's next revision (the coordinator's word: write it here, do not change the generator).**
The generator's statement guard is textual — a patch is refused before a declaration's top-level `:=` — so a patch to
the proof of a definition or an instance can still change its stored TYPE, through section-variable inclusion, and the
generator cannot see it; the read-back did. So the read-back is the gate for that class, per module, in every lane. And
the header's item "Patches …, each to a proof and none to a statement or a definition" is then wrong for such a patch
in letter; the reason text says so here. Also: the header's item 1 still reads "those the transfer
`proper_to_borel_weak` uses" over a whole-file selection ("110 of its 110 declarations"), and `--axioms-block` omits
instances and private declarations (this job's axioms footer walks every constant instead).

**2.4 Level one: risk 2 for lane A** (`level1.out`): every Mathlib or core constant the ten modules' stored types and
definitions' values name outside instance and proof arguments, printed one level down at both pins — **331 constants:
276 IDENTICAL, 27 MOVED (module only), 28 DIFFERENT.** The 28, each read at its first difference: 19 instance paths
inside class and structure types from the hierarchy's reflow (the `Monoid` parents; `Semifield` / `DivisionSemiring`;
`AddZeroClass`: `AddCommGroup`, `.mk`, `AddCommMonoid`, `CommGroup`, `.mk`, `Group`, `DivisionSemiring`,
`InnerProductSpace`, `.toDual`, `innerSL`, `NormedAddCommGroup`, `NormedSpace`, `SeminormedRing`, `IntermediateField`,
`.toSubalgebra`, `algebraicClosure`, `ContinuousLinearMap.compLeftContinuousBounded`, `Lp.const`,
`QuotientAddGroup.leftRel`); 3 a universe `max` with its arguments swapped (`LinearIsometry`, `.mk`,
`LinearIsometryEquiv`); 2 hygienic auxiliary names (`Measure.map` — itself the known class — and `tsum`); 1
`Finset.diag`'s implementation, which no statement names; 1 `Finset.HasAntidiagonal.antidiagonal` (ruling 2); and **2
from a fourth definition that changed, reported to the coordinator at once: `MeasureTheory.eLpNorm`** — at v4.34.1
`if AEStronglyMeasurable f μ then (the formula) else ∞`, with `MemLp f p μ := eLpNorm f p μ < ∞`; at v4.32.0 the
formula alone, with `MemLp := AEStronglyMeasurable f μ ∧ eLpNorm f p μ < ∞` (`LpSeminorm/Defs.lean`). The two `MemLp`
are equivalent, and so are the `Lp` subgroups; no statement or definition of lanes A–B names `eLpNorm` itself; `MemLp`
reaches one release statement (`LpMultiplier.mul_memLp`), `Lp` 24. Lanes C and D: a release statement naming
`eLpNorm` of a function not known to be measurable means another number at the two pins.

## Stage 3 — SAVED: lane B, the factor base — four of five modules elaborate; two generator revisions; the job stops here at its budget

**3.1 State per module** (farm, `data/fs131/ipa1/farm/`; tables `data/fs131/ko1/port/<Module>.json`; `--check` on the
five: `CHECK OK`, `gen-check-laneB.out`, before RelativeCenters was set aside).

| module | table | elaboration | axioms | read-back |
|---|---|---|---|---|
| `OAI158Amenability` | 1 patch: 385 `eventuallyEmptyOrUniv_iff.mp` → `Filter.eventuallyConst_set.mp` (`EventuallyEmptyOrUniv` is a definition new at v4.34.1) | 0, 0 (`-try2`) | clean (below) | in `laneB1` (below) |
| `OAI158NumberFields` | 2 patches: 483, 487 `isAlgebraic_natCast` → `isAlgebraic_nat` | 0, 0 (`-try1`) | clean | **8 DIFFERENT, not yet read** (below) |
| `OAI158Selections` | none | 0, 0 (`-try1`) | clean | in `laneB1` |
| `OAI158Centers` | the trial's 5 renames; 7 adaptations (350, 371, 560, 679, 680, 694 closed-term ADAPTED; **501 the RULED adaptation of `frequencyLaw`**); 5 more patches (567, 682, 688, 510, 511); 3 `drop_omit` (578, 600, 615) | **0 errors, 0 warnings** (`-try5`) | not run | **not run** |
| `OAI158RelativeCenters` | 4 global instances (427, 520, 525, 529), `drop_imports` | **13 errors, 1 warning** (`-try2`): not finished | — | — |

Axioms of Amenability, NumberFields and Selections (`axioms/AxiomslaneB1.out`): `SUMMARY constants=225 clean=225
other=0` (the control of stage 2.1 is the same footer). Read-back `laneB1` (195 constants): `READBACK FAILED` —
**8 DIFFERENT, all in `NumberFields`** (`AlgebraicCayley.minpoly_reverse_eval_ne_zero`, `linearFraction_polynomials`,
`reciprocal_denominator`, `realLine`, `coeff_polyLinear`, `eval_polyLinear`, `polyLinear_eq_zero_iff`,
`cayley_annihilation`); the first difference of each sits in a `CommSemiring`/`Semiring` instance path to ℚ
(`Rat.commSemiring`, `CommSemiring.toSemiring`) at an argument the erased print keeps — the shape of ANTIDIAG, at
another projection or class parameter. **Not read further; it is the successor's first item, and a ruling's if it is a
new class.** `compare.out`, `instance-constants.txt` (35, recorded from this failing run: read again before trusting).

**3.2 Rulings received in this stage, and what was done under each.**
- *Amendment 2 — the indented declaration* (`RelativeCenters.lean:40`, ` theorem finite_uniform_fibers`, the only one
  in the 31 files): the generator's `KEYWORD` allows leading whitespace, commit **`9138f57b3`**, its own; a self-test
  partner copies an indented declaration (it fails under the old `KEYWORD`: `gen-fix-selftest-oldkeyword.out`);
  `--check` on the 14 modules generated so far identical before and after, every file byte-identical
  (`gen-fix-check-{before,after}.out`, `gen-fix-files-before.sha256`); `--parse-all` passes; self-test **19 plants
  refused, 3 partners accepted**.
- *Amendment 3 — `CosetCenter.Embedding.frequencyLaw`* (Centers.lean:496–501, a definition): at the release's pin
  `frequencyLaw` and `center` take no `[MeasurableMul₂ G] [MeasurableInv G]` (`probes/FrequencyLawRelease.out`); at
  this pin the proof field `inferInstance` needs the measurability of `d ↦ e.coordinate (d / z)`, which only the
  section's two instances give. **Ruled (a)**: the adaptation at 501 inserts the release's own term
  `(e.measurable_coordinate.comp (measurable_id.div_const z)).aemeasurable`, and exactly the two section variables
  become binders of `frequencyLaw` and of every declaration whose type names it or `center` (the cascade).
- *Amendment 4 — `drop_omit`*: the cascade met three `omit [MeasurableMul₂ G] [MeasurableInv G] in` lines
  (`center_mem_coset` 578, `quotient_center` 600, `center_mem_ordinary_iff` 615: `cannot omit referenced section
  variable`), which no table key reached. The generator's new key `drop_omit: [[line, reason]]`, commit
  **`666fafdc4`**, its own: refused unless the line is a one-line `omit … in` attached to a copied declaration, refused
  unused, listed in the header; a plant (an entry on a line that is no omit) refused, a partner (an entry removes exactly
  that line, on Centers) accepted; `--check` on the 14 modules identical before and after, every file byte-identical
  (`gen-fix2-*`); `--parse-all` passes; self-test **20 plants refused, 4 partners accepted**. *Its limit:* the plant is
  refused as an unused entry; the branch that refuses an `… in` line that is not an `omit` (an `include … in`) is not
  exercised by a plant.

**3.3 The cascade, as far as measured.** Elaboration shows it reaches at least: `frequencyLaw` (the adaptation),
`center`, and the three theorems whose `omit` was dropped. **The full list is not measured**: it is the read-back of
Centers (verdict RULED per declaration, with the strip check of `tools/fs131_ipa1_readback_port.py`, whose `RULED`
table must then list every member) — the successor's second item, owed to the coordinator for lanes C and D (Amendment
3, condition 3). The other five `omit` lines of Centers (525, 539, 634, 646, 653) stay.

**3.4 RelativeCenters** (generated text kept at `data/fs131/ipa1/pending/OAI158RelativeCenters.lean`, sha256
`cb82af80…`, *not* under `Proofs/`: it does not elaborate). Its 13 errors, by source line: the `ProbabilityMeasure.map`
class at 103 (`μ.map (e.center μ)`, whose measurability is to be found in its context) and 382; `eventuallyEmptyOrUniv_iff`
at 129 (Amenability's patch); `compProd_map_condDistrib` with two arguments at 163, 261, 293, 443 (SmallArcs' patch);
`condDistrib_comp` taking the map at 189 (ConditionalSelection's patch); `cannot omit referenced section variable` at the
declaration of line 344 (`centerMap_law_ordinary` region: the cascade reaching RelativeCenters — a `drop_omit` under
Amendment 4 if its statement names `center`), and the unsolved goals that follow.

**3.5 Re-pricing (Done item 5), from what lanes A and B cost.** Lane A: 22 patches in 5,035 lines (one per ~230 lines),
all renames or argument changes in proofs, each 3–15 minutes; the real cost was the read-back (one comparator with five
named classes, ~1.5 h) and four findings needing rulings. Lane B: Centers' adaptation class was as the trial said
(about ten sites), but **one site needed a binder** and cascaded, and the file needed two generator revisions. For lane C
(the adaptation class densest, `ProbabilityMeasure` on 91 lines of its files) and lane D: expect the cascade of 3.3 to
continue wherever `Embedding.center` or `frequencyLaw` is named, more definitions whose proof field is `inferInstance` of
a `map` (each a RULED-class question, not an adaptation, when the map's measurability needs a section instance), and
the `eLpNorm`/`MemLp` change (2.4) wherever a statement names `eLpNorm`. Price per lane: C 6–10 h, D 6–10 h with its
build, against the plan's 4–6 h each; the read-back per lane is now a reuse of this job's comparator (minutes), the
rulings are not.

**3.6 Every table entry has its reason** (in its table; patches and adaptations with the Mathlib file and line at each
pin), and **no entry touches a protected declaration**: the generator refuses an adaptation on the two targets and on
every declaration the density branch shares (`shared_names()`), and was asked to place none there; no lane A or B
module holds a declaration a statement of ours names (our statements name only `Outside/OAI158`'s and
`Outside/OAI158Palette`'s copies, which are upstream, not regenerated); the RULED entries (`differenceLaw_probability`,
`frequencyLaw` and its cascade) are in neither class. *Lane D's check of the last condition, across the whole port, is
still owed (plan § 4.3).*

**3.7 Not done** (for the successor, in order): (1) read NumberFields' 8 DIFFERENT (3.1); (2) the read-back of Centers,
with the RULED list of the cascade measured and the ADAPTED strip check for its six closed-term sites (the comparator's
`ADAPTED` table is empty: each site is `ProbabilityMeasure.map` with 7 arguments here, the 7th inserted) and its
planted control, written as `tools/fs131_ipa1_strip.py` if the plan's name is wanted; (3) RelativeCenters' entries
(3.4); (4) axioms and level one for Centers and RelativeCenters; (5) the pricing dump, not started.
