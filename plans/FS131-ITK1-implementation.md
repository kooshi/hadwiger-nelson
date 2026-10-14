# FS131-ITK1 — the five-colour chain: the adelic model finished (lane T-K), then the zero-entropy side's second half (M8b)

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ITK1-tate-m8b.md` (on `main`). Branch `fs131-wt2`, cut from
`fs131-wt1` at `72c8520a7` in the worktree `.claude/worktrees/fs131-wq1`. Working files: `data/fs131/itk1/`. Laptop: 12 cores,
31 GB.*

## Theorems this phase proved

Each [kernel], axioms `[propext, Classical.choice, Quot.sound]` as printed from the built tree; all under
`HadwigerNelson.Rigidity`.
- **T-K, `Rigidity/TateKernel`** (build 1; `data/fs131/itk1/logs/AxTK.log`): `exists_eq_mixedEmbedding_of_mem_oAnn`,
  `eq_zero_of_mem_oAnn`, `exists_nat_forall_mem_oAnn`, `tatePi_ker_subset`, `tatePi_exists_nat_mul_mem`,
  `tatePi_exists_isCompact`, `tatePi_eq_one_forall_imp`, `surjective_tatePi`. With them **`exists_tateModel : ∀ (F :
  Subfield ℝ) [NumberField ↥F], Nonempty (TateModel F)`** prints the standard three: lane T is complete.

## Stage 1 — SAVED: the readback; the stored statements before any edit

**1.1 The build of the tree.** `lake build --no-build` under the slot: `exit=0`, "All targets up-to-date (6078 jobs)" (the four
`sorry` warnings printed are `Rigidity/EntropySplitMax`'s, not this job's). The tree's build is current for `72c8520a7`.

**1.2 The brief's quotations** (standing rule 3). `tools/fs131_itk1_quotes.py` (FS131-ITT1's reader, unchanged in logic)
against `main`'s tree: **6 quotations, 6 MATCH** (`data/fs131/itk1/logs/quotes.log`) — W2 (`data/fs131/REQUEST-2026-10-13.md`),
the two dated lines of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 799, 811, 829 (`plans/FS131-close-inventory.md`).
**Control** (`--plant`): one character of each quotation changed in turn; each planted quotation MISMATCH and the other five
MATCH, 6 of 6 (`logs/quotes-plant.log`). No finding about the brief.

**1.3 The stored statements before any edit.** `data/fs131/itk1/lean/StatementDump.lean` (FS131-ITT1's dumper, aimed at the
six modules this job writes — `TateKernel`, `PlaceSizes`, `Multipliers`, `ThinBoxes`, `GlobalPoint`, `WanderingShells` — and
the two downstream of them it does not, `TateExists`, `ZeroEntropyClosed`), run on the built tree before any edit:
`statements-before.txt` (67 MB; committed as `.xz`, sha256 in `statements-before.sha256`), 176 constants (141 named, 35
internal). The reader is `tools/fs131_itk1_statements.py` (ITT1's, with no move). **Against itself:** PASS — 141 named
constants, 40 data definitions' values, 17 example heads (`statements-self.out`). **Its control** plants eight faults (a T-K
leaf's type, `box`'s value, a K8-A leaf missing, `zeroEntropyCarried_of_numberField`'s type downstream, `TateModel.shell` moved
to another module, a new public constant, an axiom, a leaf become a definition) and all 8 are reported, "the check can fail"
(`statements-control.out`).

**1.4 Each leaf, its statement in one line, beside its plan** (plans: T-K, `plans/FS131-KT1-tate.md` §§ 4.2–4.3; M8b,
`plans/FS131-K8B1-zero-entropy-second.md` §§ 2.4, 3.4, 4.6). `L = F(i)`, `W = SAdeleRing F`, `ι = toSAdele F`, `ψ = tateChar F`,
`π = tatePi F`, `O′ = stableIntegers F`, `R = unitRing F`.

| module | leaf | the statement | the plan's route |
|---|---|---|---|
| `TateKernel` (T-K) | `exists_eq_mixedEmbedding_of_mem_oAnn` | `a ∈ oAnn`, integral at every split prime ⇒ `a_∞ = ι_∞ y` with `Tr(y s) ∈ ℤ` for `s ∈ 𝓞 L` | § 4.2 step 2: `tateChar_of_integral`, `Circle.exp_eq_one`, `exists_eq_mixedEmbedding_of_archTrace_int` |
| | `eq_zero_of_mem_oAnn` | `c ∈ oAnn`, `c_∞ = 0`, integral at split primes ⇒ `c = 0` | § 4.2 step 4: `exists_trace_not_int_away`, `exists_approx_completion` at `t₀/c_{w₀}`, `tateCharFun_eq` at `t₀` |
| | `exists_nat_forall_mem_oAnn` | one `d₀ ≠ 0` with every `a ∈ oAnn` equal to `ι x`, `d₀ x ∈ O′` | § 4.2 steps 1–3 |
| | `tatePi_ker_subset` | `π a = 1` ⇒ `a = ι y` | `exists_mul_stableIntegers_le` (`c·O′ ⊆ R`) puts `ι c · a` in `oAnn` |
| | `tatePi_exists_nat_mul_mem` | some `d ≠ 0` has `π(ι y) = 1 ⇒ d y ∈ O′` | the same, `d = d₀ c` |
| | `tatePi_exists_isCompact` | `W = K + ι(O′)`, `K` compact | closure of `latticeBasis`'s fundamental domain × `∏ O_w`; approximant, then `ZSpan.floor` |
| | `tatePi_eq_one_forall_imp` | `π(a)(r) = 1` for all `a` ⇒ `r = 0` | `(b, 0)` with `Tr_∞(b r) = 1/2` (`archTrace_mixedEmbedding_one`) |
| | `surjective_tatePi` | `π` onto | `π(W) = π(K)` compact, closed; coannihilator `⊥`; `eq_top_of_isClosed_of_dualCoannihilator_eq_bot` |
| `PlaceSizes` (K8-A) | `size_toSAdele` | `|ι x|_p = |x|_p` | `normAtPlace_apply`; `rfl` |
| | `size_toSAdele_mul` | `|ι x · a|_p = |x|_p |a|_p` | `map_mul` of `normAtPlace`; `norm_mul` |
| | `size_add_le`, `size_neg`, `size_nonneg` | triangle, symmetry, nonnegativity of sizes | `normAtPlace_*`; `norm_*` |
| | `size_add_le_max` | ultrametric at a split prime | `IsUltrametricDist.norm_add_le_max` |
| | `continuous_size` | `p.size` continuous | `continuous_normAtPlace`; `RestrictedProduct.continuous_eval` |
| | `absAt_mul`, `absAt_nonneg`, `absAt_eq_zero` | `|·|_p` multiplicative, `≥ 0`, zero only at `0` | `map_mul`, `apply_nonneg`, `map_eq_zero`; `norm_*` |
| | `absAt_natCast_le_one` | `|n|_w ≤ 1` | `FinitePlace.norm_embedding`-shape |
| | `size_le_one_iff` | `|a|_w ≤ 1 ↔ a_w ∈ O_w` | `FinitePlace.norm_def`, `mem_adicCompletionIntegers` |
| | `exists_finset_absAt_le_one` | `x` integral off a finite set of split primes | `HeightOneSpectrum.Support.finite` |
| | `splitHeight_eq_prod` | `splitHeight x` = product over any such `T` | `finprod_eq_prod_of_mulSupport_subset` |
| | `one_le_splitHeight`, `absAt_le_splitHeight` | `1 ≤ splitHeight x`, `|x|_w ≤ splitHeight x` | from `splitHeight_eq_prod` |
| | `one_le_prod_absAt_of_mem_stableIntegers` | Lemma PF for `O′`: `1 ≤ ∏_v v(x)^{mult} · ∏_{w ∈ T} |x|_w` | the product formula, stable factors `≤ 1` |
| | `ofUnitRing_mem_stableIntegers` | `R ⊆ O′` read in `L` | `unitRing_le_stableIntegers` |
| | `TateModel.exists_isGap` | a gap `C > 0` for `Λ` | `C = d^{−[L:ℚ]}` from `exists_nat_mul_mem` and PF |
| | `exists_one_lt_absAt` | a non-torsion unit vector expands at some place of `W` | not integral ⇒ a split prime; integral ⇒ Kronecker |
| | `exists_unitVector_absAt_lt_one` | at each split `w` a unit vector with `|g|_w < 1` | `g = γ/γ̄`, `γ ∈ 𝔓_w ∖ σ𝔓_w` |
| | `countable_fieldI`, `countable_splitPlace` | `L` and the split primes countable | `Finsupp.Countable.of_moduleFinite`; `Ideal.finite_setOf_absNorm_eq` |
| `Multipliers` (K8-M) | `multiplier_mem` (private) | `((1 − 4b²) + 4b i)/(1 + 4b²)` is a unit vector of `F²` | rational coordinates; `(1 − 4b²)² + (4b)² = (1 + 4b²)²` |
| | `coe_multiplier`, `multiplier_one` | `v_b = (1 + 2bi)/(1 − 2bi)`; `v_1 = (−3 + 4i)/5` | `Complex.ext`, `field_simp` |
| | `multiplier_injective` | `b ↦ v_b` injective | real parts strictly decreasing |
| | `absAt_multiplier_arch` | `v(v_b) = 1` at every archimedean `v` | `φ(i) = ±i` |
| | `splitHeight_multiplier_le` | `splitHeight v_b ≤ (1 + 2b)^{[L:ℚ]}` | `v_b = z/z̄`, the product formula for `z̄` |
| `ThinBoxes` (K8-B) | `isOpen_box`, `isClosed_closedThinBox` | `Q(ε)` open; `Q̄_p(ε, δ)` closed | `IsOpen.prod`; `isClosed_iInter` |
| | `zero_mem_box`, `sub_mem_box`, `size_le_of_mem_box` | `0 ∈ Q(ε)`; `Q(ε) − Q(ε) ⊆ Q(2ε)`; sizes `≤ max ε 1` | `normAtPlace` arithmetic; `size_le_one_iff` |
| | `TateModel.measurableSet_image` | `π(closed)` is Borel | σ-compactness, compact images closed |
| | `TateModel.iterate_rot_π` | `(rot u)^[n] (π a) = π(ι(u^n) a)` | induction, `π_unit_mul` |
| | `TateModel.exists_box_partition` | finitely many translates of `π(Q(ε))` cover, a measurable label | `isOpenMap`, compactness, first index |
| | `TateModel.exists_orbit_box` | one name of length `n ≥ 1` ⇒ `y = π(x̃ + a)`, `u^i a ∈ Q(2ε)` for `i < n` | induction on `i`, the gap |
| | `TateModel.nameCell_subset` | the name cell lies in the image of a thin box | `exists_orbit_box` at `i = n − 1` |
| | `exists_delta_of_one_lt` | the scales `δ ↦ n` | real arithmetic, least `n` |
| | `TateModel.thinBox_heavy` | Lemma 3.1′ (EN2-L31) | (i), (iii′), (iv), `nameCell_subset` |
| | `exists_eps_lt` | a small `ε` with `16ε ≤ 1` and the gap product `< C` | the product tends to `0` |
| `GlobalPoint` (K8-G) | `heavyExponent_pos`, `scaleHeight_three_mul_sq` | `β > 0`; `M(3B²) = M(B)²` | `positivity`; `ring` |
| | `Collision.ℓ_ne_zero`, `ℓ_eq_ofUnitRing` | `ℓ = v₁ − v₂ ≠ 0`, `ℓ ∈ R` | `multiplier_injective`; `map_sub` |
| | `Collision.mul_sub_point` | `v₂a₂ − v₁a₁ = ℓ(x̃ − t)` | `c.eq`, ring arithmetic |
| | `Collision.point_eq` | two scales give one point | the gap at `z = ℓ₂y₁ − ℓ₁y₂` |
| | `Collision.size_sub_point_le` | `|x̃ − t|_p ≤ 2^{D+2} M(B)³ δ` | PF for `ℓ` |
| | `TateModel.exists_collision` | `B μ(π(x̃ + Q̄)) > 1` ⇒ a collision | measure pigeonhole |
| | `TateModel.exists_point_of_heavy` | heavy thin boxes at `x̃` ⇒ `x̃ − ι t ∈ W_p` | scales `B_{j+1} = 3B_j²` |
| | `TateModel.measurableSet_leafSet`, `measure_leafSet_compl_eq_zero` | the leaf set Borel, of full measure | countable union; Lemma 3.1′ |
| `WanderingShells` (K8-S) | `TateModel.eq_of_π_add_eq` | the lift on a leaf is unique | `π_eq_π_iff`, `eq_zero_of_toSAdele_mem_hyperplane` |
| | `TateModel.measurableSet_shell` | shells Borel | `measurableSet_image` |
| | `TateModel.iterate_rot_not_mem_shell` | shells wander under `rot g`, `|g|_w < 1` | `eq_of_π_add_eq`, sizes |
| | `TateModel.measure_shell_eq_zero` | shells null | `MeasurePreserving.conservative` |
| | `exists_absAt_eq_norm` | `‖L_w ∖ 0‖ = |L ∖ 0|_w` | density, ultrametric |
| | `TateModel.leafSet_subset`, `measure_compl_TA_eq_zero` | leaf set `⊆ T + A ∪` shells; `μ` carried by `T + A` | `mem_TA`; countable null union |

## Stage 2 — SAVED: lane T-K proved; `exists_tateModel` on the standard three

**2.1 The leaves**, all eight by the plan's routes (FS131-KT1 §§ 4.2–4.3), in two elaboration rounds (`logs/TK-1.log`: six
errors — `RestrictedProduct.ext`'s explicit arguments, two rewrites under a `show` that had unfolded the completion's
coercion, a `field_simp` under a `let`, the instance `Countable (unitRing F)`; `logs/TK-2.log`: exit 0, no warning). About
230 lines against the plan's ~350. Routes, where they differ in detail from the table:
- `eq_zero_of_mem_oAnn`: as § 4.2 step 4; the congruence at `w₀` is `c s − t₀ = −c(t₀/c − s)` (`mul_div_cancel₀`), at
  `w ≠ w₀` both terms integral.
- `exists_nat_forall_mem_oAnn`: steps 1–3 with `c := ι(d₀)·(b − ι y)` and `b = ι y` from `ι(d₀⁻¹)·c = b − ι y`.
- `tatePi_ker_subset`, `tatePi_exists_nat_mul_mem` through one private helper, `toSAdele_mul_mem_oAnn` (`π a = 1` and
  `c·O′ ⊆ R` put `ι(c)·a` in `oAnn`; the element `c s ∈ R` read as a point of `unitRing F` by
  `UnitRing.coe_mem_unitRingOver_iff`).
- `tatePi_exists_isCompact`: `K = closure(ZSpan.fundamentalDomain latticeBasis) ×ˢ range structureMap`; the integer part
  `ZSpan.floor` lies in `mixedEmbedding.integerLattice` (`mem_span_latticeBasis`), so is `ι_∞ s`, `s ∈ 𝓞 L`, and
  `a − ι(t + s)` has archimedean part `ZSpan.fract`.
- `tatePi_eq_one_forall_imp`: `b = ι_∞(q·x⁻¹)`, `q = 1/(2[L:ℚ])`; `e(2π·½) = 1` would make `½` an integer.
- `surjective_tatePi`: the range of `π.toMonoidHom` is `π(K)`; `Countable (unitRing F)` supplied in the proof from
  `SpectralChain.countable_unitRing` (no new import).
Eleven private helpers (`valuation_coe_le_one`, `coe_mem_integers_iff`, `coe_mem_stableIntegers`,
`mem_stableIntegers_of_away`, `snd_mul_apply`, `snd_sub_apply`, `toSAdele_snd_apply`, `exists_int_of_exp_eq_one`,
`toSAdele_injective`, `sub_toSAdele_mem_oAnn`, `toSAdele_mul_mem_oAnn`).

**2.2 Build 1** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`): `OK — 254 of 254 batches, 4 module(s)
rebuilt, 11 module(s) with warnings, 7m50s`, exit 0 (`logs/build1.log`; gate log
`build/gate/build/20261014T123916Z-3023456.log`). Rebuilt: `TateKernel`, `TateExists`, `ZeroEntropyClosed`, `Proofs`.
Every warning is ``declaration uses `sorry` ``, none from `TateKernel`.

**2.3 The axioms** (`probes/AxTK.lean` on build 1's tree, `logs/AxTK.log`): the eight leaves and `exists_tateModel`, each
`[propext, Classical.choice, Quot.sound]`; `zeroEntropyCarried_of_numberField` `[propext, sorryAx, Classical.choice,
Quot.sound]` (the M8b leaves). The one line was sent to the coordinator.

**2.4 No statement changed, from the kernel's side** (build 1's dump `statements-b1.txt`, `.xz` and sha256 committed,
against stage 1's): **PASS** — 141 named constants, 40 data definitions' values, 17 example heads; no new public
constant; the eleven private helpers listed; internal constants 35 → 37 (`statements-compare-b1.out`).

**2.5 Re-priced.** T-K came in at about two thirds of its plan, in two rounds for the whole lane.
