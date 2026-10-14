# FS131-IPB1 — the port of `[OAIMath2026]`'s transfer proof, continued: lane B's last module and read-backs, then lane C

*de Bruijn, the implementer; job FS131-IPB1 (brief: `data/fs131/briefs/FS131-IPB1-port-lanes-bc.md`, on `main`).
Branch `fs131-wpb`, cut from `fs131-wpa` at `f97214de2` in the worktree `.claude/worktrees/fs132-wi1`. Working files:
`data/fs131/ipb1/`. The plan is `plans/FS131-KO1-port-plan.md`; the first implementer's record is
`plans/FS131-IPA1-implementation.md` (both this branch). The outside release is `[OAIMath2026]` family 158 at commit
`adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read, never written or run).*

## Theorems this phase proved

None of this project's mathematics. The phase makes modules of the release's own lemmas, each elaborated at this pin
with every proof checked by this kernel (the farm of the plan's § 4.1: `lean -o` with the lakefile's options by flag,
not `./scripts/build.sh`); they are not registered in the library (lane D registers). The kernel receipts per module
are in the stages below.

## Stage 1 — SAVED: the readback

**1.1 The brief's quotations** — `tools/fs131_ipb1_readback.py` (the first implementer's reader with the brief's path
changed, nothing else; pointed at the main tree, where the brief and its sources are committed): **8 matched, 0
mismatched**, exit 0 (`data/fs131/ipb1/readback-brief.out`) — W4 against `data/fs131/REQUEST-2026-10-13.md`; items
759, 763, 764, 766, 767, 768 and 769 against `plans/FS131-close-inventory.md`. `--fault` (the last character of each
quotation changed): 0 matched, 8 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.2 The branch.** `fs131-wpb` cut from `fs131-wpa` at `f97214de2` (the tree's head at launch, clean).

**1.3 The generator** (`tools/fs131_ko1_port.py` at `666fafdc4`, unchanged), on the 14 modules generated so far (lane
A's ten, and Amenability, NumberFields, Selections, Centers):
- `--parse-all`: `PARSE OK: every file of the plan reads as scopes, declarations and scaffolding` (exit 0;
  `data/fs131/ipb1/gen-parse-all.out`);
- `--self-test`: `SELF-TEST OK: 20 plants refused and 4 partners accepted` (exit 0; `gen-selftest.out`);
- `--check --modules` the 14: `CHECK OK` (exit 0; `gen-check-14.out`, every file and the licence copy OK).

*A stray run, recorded:* my first call of the generator was `--help`, which it does not know; with no `--modules` it
generated every module in memory and refused at `Kernels.lean:658` (an instance in neither table) before writing
anything — `git status` showed no file changed.

**1.4 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the plan's § 3.1–3.7 and § 4.1–4.7; the first implementer's record whole; the generator whole.

## Stage 2 — SAVED: lane B complete

*Everything here is from `lean -o` in the scratch farm (`data/fs131/ko1/farm1.sh`, unchanged, driven by
`data/fs131/ipb1/farm-run.sh` and `farm-all.sh`, FS131-IPA1's with their log folder changed), not from
`./scripts/build.sh`. One ruling received mid-stage (the coordinator's message, 2026-10-14), applied below.*

**2.1 NumberFields' eight DIFFERENT, read and classed** (`data/fs131/ipb1/readback/laneB1/`: FS131-IPA1's two prints
copied, their hashes checked against its `prints.sha256`; every differing site located by a walk of both erased prints,
not by the first difference only).
- **Seven of the eight, and the definition `realLine`**, differ only at argument 3 of `Algebra.algebraMap` — the class
  parameter `[Semiring A]`, which the projection takes implicitly, so the erased print keeps it:
  `CommSemiring.toSemiring L _` (or `Ring.toSemiring _ _` in `realLine`) at the release, `DivisionSemiring.toSemiring L _`
  here, the hierarchy's reflow. **Classed up to instances under item 769 ruling 2's standing word**, by a new comparator
  rule **CLASS_PARAMS** (`Algebra.algebraMap` ↦ position 3, written `_` in both erased prints; the full prints still
  differ, the constants recorded). Controls: another argument of the projection (position 2, `Rat.commSemiring`)
  changed — refused; the rule withdrawn — refused (7 failing).
- **Two of them**, `AlgebraicCayley.reciprocal_denominator` and `AlgebraicCayley.coeff_polyLinear`, differ also by a
  **fifth Mathlib definition changed between the pins, `Polynomial.coeff`**: `def coeff : R[X] → ℕ →₀ R | ⟨p⟩ =>
  p.coeff` at v4.34.1, `def coeff : R[X] → ℕ → R | ⟨p⟩ => p.coeff` at v4.32.0 (`Mathlib/Algebra/Polynomial/Basic.lean`
  l. 562 there, l. 563 here), so `p.coeff n` is stored as `DFunLike.coe (Polynomial.coeff p) n` there and as
  `Polynomial.coeff p n` here — the same coefficient. Sent to the coordinator; **ruled (by message): a comparator rule
  COEFF as proposed**, the two lemmas classed PIN-DIFFERENCE (COEFF) by name, level one's prints as evidence; with a
  standing word that a Mathlib definition whose type changed only in how an application is stored gets a named rule
  with planted controls and its lemmas listed, reported at hand-back. Built: **COEFF** (release side only;
  `DFunLike.coe` with six arguments, the first a `Finsupp` over `Nat`, the fifth `Polynomial.coeff` with three → the
  application; `COEFF_LEMMAS` lists the two; a rewrite on an unlisted constant fails, a listed one untouched is fatal).
  Controls: another coercion head at a site — refused; the rule withdrawn — refused (2 failing); a listed lemma taken
  out of the list — refused. Level one (2.4) prints the two definitions: there `(pi.d a (Polynomial R) (Finsupp ℕ R …))`,
  here `(pi.d a (Polynomial R) (pi.d a ℕ R))`, each by `Polynomial.support.match_1` on `⟨p⟩` to `p.coeff`, here under
  `DFunLike.coe` — so `⇑(coeff q) n` there is `coeff q n` here by unfolding.
- With both rules: `laneB1` **READBACK OK** on 195 constants (`compare.out`); 36 instance constants recorded and read
  (`instance-constants.txt`: Mathlib instance paths — `CommSemiring.toSemiring`, `DivisionSemiring.toSemiring`,
  `Semifield.to…`, `DivisionRing.toRing`, the `Subfield`/`IntermediateField` class paths — and three generated proofs
  `AlgebraicCayley.asN._proof_n`); FS131-IPA1's record of 35 lacked `DivisionRing.toRing`, as its own note warned.

**2.2 Centers read back; the ruled cascade's full list measured** (`data/fs131/ipb1/readback/laneB-centers/`, 119
constants: 103 declarations and 16 generated auxiliaries; dumps at both pins by `data/fs131/ipb1/dump.sh`). First
comparison: 18 DIFFERENT, every one the cascade or an adaptation (`compare.out` before the rule is not kept; the probe
that measured each one's strip is the table below). The comparator's new rule **STRIP**: per listed declaration, the
binders inserted (one of each of the release's own section variables `[MeasurableMul₂ G] [MeasurableInv G]`,
`Centers.lean:426`, on the type's `∀`s and on a definition's value's `fun`s, `@k` renumbered) and the heads whose
applications carry inserted arguments (`frequencyLaw` and `center`: positions 4, 5; `ProbabilityMeasure.map`: position
6 of exactly 7), every listed head required to occur; verdict RULED where a binder or a cascade head is listed, ADAPTED
where only `ProbabilityMeasure.map` is. With it: **READBACK OK**, 119 constants — 2 definitions RULED, 14 lemmas RULED,
2 lemmas ADAPTED, the rest IDENTICAL (no UP-TO-INSTANCES; 2 AUX-DIFFERS, `frequencyLaw._proof_2` and `center.eq_1`,
counted). Self-test: 14 plants refused, among them the six STRIP controls — one other binder inserted, a second
`MeasurableInv` inserted, another argument (3) changed at a `center` site, the map changed at a `ProbabilityMeasure.map`
site, the rule withdrawn (18 failing), a head listed where it does not occur.

**The ruled cascade, its full list across lane B** (Centers and RelativeCenters; measured, each by the strip check;
*for lane D's brief*):

| declaration | kind | binders inserted | inserted arguments at | also |
|---|---|---|---|---|
| `CosetCenter.Embedding.frequencyLaw` | def | the two | — | the RULED adaptation `Centers.lean:501` (in the proof field) |
| `CosetCenter.Embedding.center` | def | the two | `frequencyLaw` | |
| `CosetCenter.Embedding.center_mem_coset` | theorem | the two | `center` | `drop_omit` 578 |
| `CosetCenter.Embedding.quotient_center` | theorem | the two | `center` | `drop_omit` 600 |
| `CosetCenter.Embedding.center_mem_ordinary_iff` | theorem | the two | `center` | `drop_omit` 615 |
| `CosetCenter.Embedding.frequencyLaw_measure`, `measurable_frequencyLaw` | theorem | — | `frequencyLaw` | |
| `CosetCenter.Embedding.frequencyLaw_shift` | theorem | — | `frequencyLaw` ×2 | ADAPTED `ProbabilityMeasure.map` (560) |
| `CosetCenter.Embedding.frequencyLaw_equiv` | theorem | — | `frequencyLaw` ×2 | ADAPTED ×2 (679, 680) |
| `CosetCenter.Embedding.measurable_center`, `measurable_center_fixed` | theorem | — | `center` | |
| `CosetCenter.Embedding.center_mul_j`, `center_eq_of_mem_coset`, `center_eq_iff`, `preimage_center_singleton` | theorem | — | `center` ×2 | |
| `CosetCenter.Embedding.center_equivariant` | theorem | — | `center` ×2 | ADAPTED (694) |
| `CosetCenter.Embedding.finite_uniform_centers` (RelativeCenters) | theorem | — | `center` ×2 | |
| `CosetCenter.Embedding.center_law_ordinary` (RelativeCenters) | theorem | — | `center` | ADAPTED (`RelativeCenters.lean:103`) |
| `RelativeCenters.centerMap` | def | the two (variable inclusion: its value names `center`) | `center` | |
| `RelativeCenters.centerKernel` | def | the two (likewise) | `center` | |
| `RelativeCenters.centerMap_mem_ordinary_iff` | theorem | the two | `centerMap` | `drop_omit` 343 |
| `RelativeCenters.positive_mass_finite_centers`, `measurable_fiberCenter` | theorem | — | `center` (×2, ×1) | |
| `RelativeCenters.measurable_centerMap`, `centerMap_law_ordinary` | theorem | — | `centerMap` | |
| `RelativeCenters.centerMap_equivariant` | theorem | — | `centerMap` ×2 | |
| `RelativeCenters.finite_center_reduction` | theorem | — | `centerMap` ×6 | |
| `RelativeCenters.centerKernel_markov` (an instance) | theorem | — | `centerKernel` | |
| `RelativeCenters.centerKernel_apply` | theorem | — | `centerKernel`, `center` | |
| `RelativeCenters.condDistrib_centerMap`, `centerKernel_comp_map` | theorem | — | `centerMap`, `centerKernel` | |

**31 declarations in the cascade** (4 definitions, 27 theorems; 8 of them with the two binders inserted — the 4
definitions and the 4 theorems whose `omit` was dropped —, 23 only carrying the two extra instance arguments at the
applications of a cascade definition), plus **2 ADAPTED only**
(`Location.center_translate`, `center_orthogonal`: 350, 371). The cascade's **heads for lanes C and D** — a statement
naming one of them carries two inserted instance arguments at each application: `CosetCenter.Embedding.frequencyLaw`,
`CosetCenter.Embedding.center` (positions 4, 5), `RelativeCenters.centerMap`, `RelativeCenters.centerKernel`
(positions 5, 6). **The cascade stops at the Spectral end of RelativeCenters**: `Spectral.exact_finite_center_reduction`
names `centerMap` only in its proof, and its statement is UP-TO-INSTANCES. *What "through the cascade" was read to
cover*: the coordinator's ruling names `frequencyLaw` and `center`, and `center`'s release type does not name
`frequencyLaw` — it gains the binders because its value does; `centerMap` and `centerKernel` gain them by the same
mechanism through `center`, and every member is a declaration of the release whose stored type is the release's with
exactly the two section variables inserted at the cascade's own sites. None is a target, a shared declaration (the
generator's `shared_names()`: no lane B declaration is among the density branch's 129), or named by a statement of ours
(no module of the library outside the generated ones names a lane B namespace: `git ls-files Proofs` grepped).

**2.3 RelativeCenters: its entries, and the module elaborated** (its table `data/fs131/ko1/port/OAI158RelativeCenters.json`;
entries written with `data/fs131/ipb1/addentry.py`; the generated text at the first implementer's hand-back was
byte-identical to its pending copy, sha256 `cb82af80…`). Entries, each with its reason in the table:
- patches, all in proofs: 129 `eventuallyEmptyOrUniv_iff.mp` → `Filter.eventuallyConst_set.mp` (Amenability's); 163,
  261, 293, 443 `compProd_map_condDistrib` loses its first argument (SmallArcs'); 189 `condDistrib_comp` takes the map
  `p` in place of `hp.aemeasurable` (ConditionalSelection's), and its implicit `(mβ := inferInstance)` named, since the
  `have` has no expected type here to fix it (try3: `don't know how to synthesize implicit argument mβ`); 382 the
  `ProbabilityMeasure.map` of a `have` in `centerMap_equivariant`'s proof given `(f := …) (measurable_const_smul
  k).aemeasurable`;
- adaptation (ADAPTED, closed term): 103 `μ.map (e.center μ)` → `μ.map (f := e.center μ) (e.measurable_center_fixed
  μ).aemeasurable` in `center_law_ordinary`'s statement (the release's own lemma `Centers.lean:626`, no binder);
- `drop_omit` 343 (`centerMap_mem_ordinary_iff`, the cascade);
- the first implementer's four `global_instances` (427, 520, 525, 529) and `drop_imports`, unchanged.
Elaboration (`data/fs131/ipb1/farm/OAI158RelativeCenters-try3.out`: 3 errors, the `mβ` site; **`-try4.out`: 0 errors, 0
warnings**, 7 s), 739 generated lines, sha256 `5446daec…`.

**2.4 The five receipts, for every lane B module.**
1. `--check` on all fifteen generated modules (lanes A and B): **`CHECK OK`** (`data/fs131/ipb1/gen-check-15.out`).
2. All fifteen re-elaborated in dependency order (`farm-all.sh final`): **every module 0 errors, 0 warnings**
   (`data/fs131/ipb1/farm/*-final.out`, 3–12 s each); lane B's here-dump made before and after that re-elaboration is
   byte-identical (sha256 `769e68a9…`).
3. Axioms (`data/fs131/ipb1/axioms/`, FS131-IPA1's footer generator run unchanged — every constant the five modules
   declare, instances, private and generated ones included): **`SUMMARY constants=413 clean=413 other=0`**; the control
   (a scratch `PlantSorry` importing RelativeCenters, one theorem by `sorry`): `NOTCLEAN PlantSorry ipb1PlantedSorry
   #[sorryAx]`, `constants=414 clean=413 other=1`.
4. The read-back of all five (`data/fs131/ipb1/readback/laneB/`, 369 constants: 268 declarations, 101 auxiliaries):
   **`READBACK OK`** — definitions 46 IDENTICAL, 6 UP-TO-INSTANCES, 4 RULED; lemmas 144 IDENTICAL, 37 UP-TO-INSTANCES,
   27 RULED, 2 ADAPTED, 2 PIN-DIFFERENCE (COEFF); auxiliaries 73 IDENTICAL, 11 UP-TO-INSTANCES, 3 AUX-ABSENT, 14
   AUX-DIFFERS (counted: `asN._proof_n`, `frequencyLaw._proof_2`, `center.eq_1`, `centerKernel.eq_1`,
   `dualMulDistribAction._proof_n`); 40 instance constants recorded and read (the 36 of 2.1 and `Subgroup.toGroup`,
   `Subgroup.instSubgroupClass`, `SubgroupClass.toSubmonoidClass`, `Spectral.dualMulDistribAction._proof_3`).
   Self-test: **19 plants refused, the unplanted pair passes** (`selftest.out`). The revised comparator re-run on lane
   A's prints (copied to `readback/laneA-regress/`): READBACK OK with lane A's counts unchanged, self-test 13 plants.
   Level one (risk 2), lane B: **265 constants, 227 IDENTICAL, 12 MOVED, 26 DIFFERENT**, each read (`level1.out`): 17
   instance paths from the hierarchy's reflow (`AddCommGroup`, `AddGroup`, `CommGroup`, `Group`, `Field`,
   `NormedAddCommGroup`, `InnerProductSpace`, `.toDual`, `FiniteDimensional`, `IntermediateField`, `.adjoin`,
   `.toSubfield`, `Subfield.comap`, `LinearIsometry.toLinearIsometryEquiv`,
   `ContinuousLinearMap.compLeftContinuousBounded`, `Measure.restrict` (an instance name), `ProbabilityTheory.cond`);
   3 universe `max` orders (`LinearIsometry`, `.mk`, `LinearIsometryEquiv`); the known classes `Measure.map` (a
   hygienic name), `ProbabilityMeasure.map` (the adaptation class) and `Lp` (item 764); `Polynomial.coeff` (COEFF);
   and **`ErgodicSMul`, `ErgodicVAdd`**, whose field reads `… =ᵐ[μ] s → EventuallyEmptyOrUniv s (ae μ)` with the set
   equality stored as `Filter.EventuallyEqSet` at v4.34.1 and `… → EventuallyConst s (ae μ)` with `Filter.EventuallyEq
   … (Sort 0)` here. `Filter.EventuallyEqSet l s t := EventuallyEq l (· ∈ s) (· ∈ t)` (`Mathlib/Order/Filter/Defs.lean:310`
   there, a definition new at v4.34.1, like FS132-I2's `EventuallySubset`) and `EventuallyEmptyOrUniv s l :=
   EventuallyConst (· ∈ s) l` (`EventuallyConst.lean:77` there) are unfoldings to this pin's terms: the same class. No
   lane B statement stores either (all lane B statements naming `ErgodicSMul` are IDENTICAL or UP-TO-INSTANCES); a
   lane C statement that writes `s =ᵐ[μ] t` of sets would, and gets a named rule under the standing word.
5. Every table entry has its reason (in its table); no entry touches a protected declaration (2.2).

**2.5 A note on `Measure.map`'s class in definitions** (no ruling asked; for the record). `RelativeCenters.differenceLaw
ν κ := ((κ ×ₖ κ) ∘ₘ ν).map (fun p => p.1 / p.2)` is IDENTICAL as stored, and like lane A's `DifferenceFourier.differenceLaw`
(item 763) it names another measure at the two pins when the division is not measurable (§ 3.3: `Measure.map` is `0`
here on a map that is not AE-measurable). Every statement that names it carries `[MeasurableMul₂ G] [MeasurableInv G]`
(`differenceLaw_ordinary`, `sampledMass_integral`, `positive_mass_finite_centers`, `finite_center_reduction`, read from
the stored types), or is at `D`, whose instances the library holds (`exact_finite_center_reduction`): where the
division is measurable, the two pins agree.

**2.6 The generator's one new plant** (item 769 ruling 3; commit `e17b0772a`, its own): an entry of `drop_omit` on an `…
in` line attached to a copied declaration that is no `omit` (Centers' line 525 made `include e in` in a copy of the
source) must be refused by that branch, read from its message. `--check` on the fifteen modules byte-identical before and
after (`gen-plant-check-{before,after}.out`, `gen-plant-files-before.sha256`), `--parse-all` passes, self-test **21
plants refused and 4 partners accepted**; with the branch removed in a scratch copy the plant reads SILENT and the
self-test fails (`gen-plant-control-nobranch.out`).

## Stage 3 — SAVED: lane C, its first five modules (Approximation, ConditionalLimits, Kernels, BoundedFunctions, Functions)

**3.1 Instances of lane C, every one classed** (tables `data/fs131/ko1/port/OAI158<Stem>.json`): global, on a type
built from the release's own definitions — `Kernels.lean:658` (`IsProbabilityMeasure` of `RelativeProduct.law`),
`BoundedFunctions.lean:29` (`CoeFun (Func X)`), `Factors.lean` 52–56, 68, 76, 79 (`OrbitSpace K`) and 557 (`Preorder
(Model μ Good)`), `RelativeProducts.lean` 19 (a law), 210, 211 (`Family G X`), `Stationary.lean` 86, 87, 90
(`StationaryMean.measure t r x₀`) and 112 (`Countable K`, `K` the release's `def` subgroup of `Circle`, as Basic's
`MulAction K D`); **scoped**, on Mathlib's types — `RelativeProducts.lean:372` (`product_measurable_vadd :
MeasurableConstVAdd G (X × X)`, the product action of Mathlib's `Prod` over the section's variables).

**3.2 Per module** (elaboration logs `data/fs131/ipb1/farm/<Module>-<try>.out`; final `-c1b`):

| module | table (each entry with its reason) | elaboration |
|---|---|---|
| `OAI158Approximation` | renames `dite_eq_left`→`dif_pos`, `ite_eq_left`→`if_pos`, `ite_eq_right`→`if_neg`, `Measurable.of_eval`→`measurable_pi_lambda` (all `apply` or `simp` sites); patches 316, 354, 404: `haveI := Measure.isProbabilityMeasure_map (hp.aemeasurable (μ := μ));` before the tactic that needs `IsProbabilityMeasure (μ.map p)` | try1 17 errors; **0, 0** |
| `OAI158ConditionalLimits` | renames `ite_eq_left`, `ite_eq_right`, `Measurable.of_eval`→`measurable_pi_lambda`; patches 229, 292, 306, 356, 402, 639, 652: a `let : IsProbabilityMeasure (μ.map f) := inferInstance` given `Measure.isProbabilityMeasure_map` at the context's measurability (`hp`, `hv n`, `hb`, `hP`, `hq`); 562 `Measurable.of_eval (fun _ =>` → `measurable_pi_lambda _ (fun _ =>` (a term site); `drop_imports` `Mathlib.Order.CompletePartialOrder` | try1 21 errors; **0, 0** |
| `OAI158Kernels` | rename `Measurable.of_eval`→`measurable_pi_iff.mpr` (that lemma's own proof at the release; term and `apply` sites alike); patches 509 (the release's `change EventuallyEmptyOrUniv s (ae ν)` left out: at this pin the goal is already `EventuallyConst s (ae ν)`, and the `change` drew the linter's "does nothing", try1), 510 `eventuallyEmptyOrUniv_iff` → `Filter.eventuallyConst_set` (Amenability's); global instance 658; `drop_imports` | try1 0 errors 1 warning; **0, 0** |
| `OAI158BoundedFunctions` | global instance 29 | **0, 0** at try1 |
| `OAI158Functions` | renames `Measurable.of_eval`→`measurable_pi_iff.mpr`, `Set.mem_ofPred_eq`→`Set.mem_setOf_eq`; patches 128, 131 `dist_star_star` → `star_isometry.dist_eq` (the release's lemma is that term, `CStarAlgebra/Basic.lean:89` there; absent here); 551, 552, 588 `Isometry.lipschitzWith` → `Isometry.lipschitz` (renamed after v4.32.0; a patch per site, since a rename of the token would reach `lipschitzWith_thickenedIndicator`); 812 the `let`'s instance from `hπ` | try1 7 errors; **0, 0** |

*A slip, caught and redone:* the first elaboration and read-back of these five were made with
`Mathlib.Order.CompletePartialOrder` imported by ConditionalLimits and Kernels — the plan's § 4.1 leaves it out of every
module whose dump lists it, and I had not written the `drop_imports` entries. Found by grepping the generated imports
before saving; the entries written (and Factors' in advance), the five re-elaborated (`-c1b`) and every receipt below
re-run from the new oleans. The here-dump moved (sha256 `4b5afc55…` → `72c5816…`): six more instance constants, all
the supremum paths of § 3.5 (`CompletePartialOrder.toSupSet` at the release, the `ConditionallyCompletePartialOrderSup`
path here), UP-TO-INSTANCES.

**3.3 A sixth Mathlib definition that changed between the pins reaches a statement: `Filter.EventuallyEqSet`.**
`KernelCompact.exists_invariant_set` writes `s =ᵐ[μ] t` of sets; at v4.34.1 that elaborates to
`Filter.EventuallyEqSet l s t` (a definition new there, `Mathlib/Order/Filter/Defs.lean:310`, `EventuallyEq l (· ∈ s)
(· ∈ t)`), at v4.32.0 to `Filter.EventuallyEq l s t` at `Prop`. The same proposition by definition, stored another way:
**under the coordinator's standing word of 2026-10-14 a named comparator rule, EQSET** (release side only: the head
`Filter.EventuallyEqSet.{u} α` written `Filter.EventuallyEq.{u,0} α (Sort 0)`; `EQSET_LEMMAS` lists the one lemma, then
PIN-DIFFERENCE (EQSET)). Controls: another head at the site — refused; the rule withdrawn — refused; the lemma taken out
of the list — refused. The rewrite bookkeeping of COEFF was generalized to a table of release-side rules
(`RELEASE_REWRITES`), each with its flag and its list; lanes A and B re-compared after: READBACK OK, their counts
unchanged. *A tool fault of mine, caught on its first run:* the release-side rewrites parsed level-one lines (`levels=… |
type = … | …`), which are no single term; they now read stored terms only (a level-one line starts with `levels=`),
lane B's level one re-run byte-identical. *Owed:* the release kernel's `rfl` for `EventuallyEqSet l s t = EventuallyEq
l s t`, as FS132-I2 checked `EventuallySubset` — added to the level-one print of the stage that closes lane C.

**3.4 The five receipts, lane C's first five.**
1. `--check` on the five: **`CHECK OK`** (`data/fs131/ipb1/gen-check-laneC1.out`).
2. Each **0 errors, 0 warnings** (3.2; `-c1b`).
3. Axioms (`data/fs131/ipb1/axioms/AxiomslaneC1.out`): **`SUMMARY constants=212 clean=212 other=0`** (the footer's
   control is lane B's, the same generator).
4. Read-back (`data/fs131/ipb1/readback/laneC1/`, 199 constants: 155 declarations, 44 auxiliaries): **`READBACK OK`** —
   definitions 26 IDENTICAL, 3 UP-TO-INSTANCES; lemmas 102 IDENTICAL, 23 UP-TO-INSTANCES, 1 PIN-DIFFERENCE (EQSET);
   auxiliaries 33 IDENTICAL, 6 AUX-ABSENT, 5 AUX-DIFFERS (`BoundedMeasurable.l2._proof_n`, `Spectral.UniversalGood._proof_n`,
   `CompactFunctions.compact_mul._simp_1_1`, counted); 56 instance constants, read: Mathlib's instance paths (the
   `Complex`, `Subalgebra`, `AEEqFun`, `Lp` and `Pi` structures, the supremum paths) and seven generated proofs. Self-test
   **11 plants refused** (`selftest.out`). **No statement or definition of the five names `eLpNorm`** (no erased type
   or value of the release's print holds it; nor in lane B's). **The ruled cascade does not reach them**: no statement
   names `frequencyLaw`, `center`, `centerMap` or `centerKernel` (none is DIFFERENT, and STRIP lists none).
   Level one: **165 constants, 148 IDENTICAL, 8 MOVED, 9 DIFFERENT**, all of known classes — `Monoid`, `Group`,
   `CommGroup` (the `Monoid` parents, item 763 (3)); `IntermediateField`, `SeminormedAddCommGroup` (instance paths);
   `ErgodicSMul` (EQSET and `EventuallyEmptyOrUniv`, stage 2.4); `Lp`, `MemLp` (item 764); `Measure.map` (§ 3.3).
5. Every table entry has its reason; none touches a protected declaration (no lane C declaration is among the density
   branch's shared names — checked with the generator's `shared_names()`: none of the five's 157 copied declarations — and the library's own
   modules name none).
