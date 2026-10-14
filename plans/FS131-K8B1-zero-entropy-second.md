# FS131-K8B1 — the five-colour chain: M8b's parts 2–4 typed to their leaves over `TateModel F`, ending at `zeroEntropyCarried`

*de Bruijn, the planner (the eighth on this chain). Brief: `data/fs131/briefs/FS131-K8B1-zero-entropy-second.md` (on `main`).
Branch `fs131-wk8b`, cut from `fs131-wkt` at `392fc2b62`, in the worktree `.claude/worktrees/fs131-wch`. Working files:
`data/fs131/k8b1/`.*

## Theorems this phase proved

A planning job; it proves no theorem of the mathematics. (Compositions of typed leaves, each a few lines, are listed in the
stage that typed them.)

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`data/fs131/k8b1/readback.py` (FS131-KT1's reader, copied; unchanged in logic) reads every block of the brief that begins with
`> ` and ends with `> — source: <path>`, and checks its text, character for character, as a substring of the source on `main`.
**Seven quotations, seven matches** (`logs/readback.log`): W2 (`data/fs131/REQUEST-2026-10-13.md`), NF2-LEAF-21 and the three
dated lines (`data/fs131/claims-NF2.md`), inventory items 791 and 799 (`plans/FS131-close-inventory.md`). **The control**:
`--plant` changes one character of the first quotation; the run reports exactly that one `MISMATCH` (`logs/readback-plant.log`).

**One finding about the record the brief quotes, not about the brief:** items 791 and 799 say "12:45 UTC logged" and "14:20 UTC
logged", and this job started at 08:55 UTC (`date -u`); the commit that files item 799 is `fcb1922ed`, 2026-10-14 08:54 +0000
= 08:54 UTC. The inventory's "UTC" times run about five and a half hours ahead of the clock (a slip in the inventory's clock
line; the brief's own "08:54 UTC" is right).

### 1.2 The build of the branch

`lake build --no-build` under the slot: `exit=0`, "All targets up-to-date (6064 jobs)" (`logs/nobuild0.log`). The tree's build
is current for `392fc2b62`.

### 1.3 The three parts, restated from FS131-KN9 § 4.2, with what each reads of the interface, field by field

The interface's nine fields (`Rigidity/TateModel`): `π`; `continuous_π`; `π_unit_mul`; `surjective_π`; `ker_subset`;
`stableIntegers_le` (`O′ ⊆ Λ`); `exists_nat_mul_mem` (`Λ ⊆ d⁻¹O′`); `exists_isCompact` (`W = K + O′`); `arch_mem`. Its
theorems: `ker_eq`, `mul_mem_Λ`, `π_eq_π_iff`, `toSAdele_mem_torsionChars`, `mem_TA`, `isOpenMap`.

| part (KN9 § 4.2) | X01D | reads of the interface |
|---|---|---|
| **M8b-2**: thin boxes; Lemma PF; the expanding place; local injectivity; Lemma 3.1′ over EN2-ZE | §§ 3.1–3.3 | `exists_nat_mul_mem` (Lemma PF for `Λ`, through `d·Λ ⊆ O′`); `isOpenMap` (`π(c + Q(ε))` open, part (i)); `surjective_π` (the translates cover, part (i)); `π_unit_mul` (the orbit of a lift, part (ii)); `π_eq_π_iff` (lifts differ by `Λ`, part (ii)); `continuous_π` and `exists_isCompact` (images of closed sets are Borel: `W` σ-compact) |
| **M8b-3**: the pigeonhole over `z = 1 + 2bi`; two scales; one global point | §§ 3.4–3.6 | `π_unit_mul` (`v·B = π(v(x̃ + Q))`); `π_eq_π_iff` (the collision `r ∈ Λ`); `mul_mem_Λ` (`z = ℓ₂r₁ − ℓ₁r₂ ∈ Λ`); `exists_nat_mul_mem` (Lemma PF); `continuous_π`, `exists_isCompact` (measurability of the boxes' images) |
| **M8b-4**: leaves and wandering shells; the conclusion | §§ 3.7–3.8 | `π_eq_π_iff` (the leaf of a point is unique); `π_unit_mul` (a rotation moves a shell); `continuous_π`, `exists_isCompact` (shells are Borel); `mem_TA` (through `toSAdele_mem_torsionChars`, i.e. `stableIntegers_le`, and `arch_mem`) |

`ker_subset` is read only through `π_eq_π_iff`; `stableIntegers_le` only through `mem_TA` (the torsion half). Every field is read.

## Stage 2 — SAVED: part 2 typed (thin boxes and Lemma 3.1′), and the arithmetic every part reads

Three new modules, each elaborated with `sorry` at its leaves only (`data/fs131/k8b1/seq.sh`, which writes each new module's
`.olean` for the next and overwrites none Lake built; `logs/PlaceSizes-s2.log`, `Multipliers-s2.log`, `ThinBoxes-s2.log`, each
`exit=0`, warnings only `declaration uses 'sorry'`: 23, 6 and 14). Their lines are in `Proofs.lean` and `ARCHITECTURE.md` § 3.
Every Mathlib and library name below was `#check`ed at the pin under the modules' imports (`probes/Names.lean`,
`probes/Names2.lean`; `logs/Names1.log`, `logs/Names2.log`); a name the probes report unknown is not cited.

### 2.1 The cut (mine to decide)

| module | holds | X01D |
|---|---|---|
| `Rigidity/PlaceSizes` (M8b-2a) | the places of `W` and their sizes; the hyperplane `W_p`; the split height; Lemma PF for `O′` and for `Λ`; Step 0; the shells' multiplier; countability | §§ 3.1–3.2, 3.8 (the multiplier) |
| `Rigidity/Multipliers` (M8b-3a) | `v_b = (1 + 2bi)/(1 − 2bi)`: unit vectors, injective, archimedean isometries, height `≤ (1 + 2b)^{[L:ℚ]}` | § 3.4 on KN8's input |
| `Rigidity/ThinBoxes` (M8b-2b) | the boxes; σ-compactness of `W` and Borel images; Lemma 3.1′'s parts (i)–(iv); Lemma 3.1′; the choice of `ε` | § 3.3; EN2-L31 |

The places are an **inductive** `WPlace F` with constructors `arch v` and `split w`, not `InfinitePlace L ⊕ SplitPlace F`: the
first draft was the `abbrev` over `Sum`, and dot notation then looked for `Sum.size` (`logs/PlaceSizes-1.log`) — two named
constructors are what every statement reads, and the hard cases (the expanding place is archimedean or split) are then one
`match`, not two theorems.

### 2.2 Read aloud against X01D and EN2-L31

- `WPlace.size` / `WPlace.absAt`: "ordinary moduli inside, normalised outside" (X01D l. 226) — archimedean `normAtPlace v`
  (ordinary; `normAtPlace_apply : normAtPlace w (mixedEmbedding K x) = w x`), split `‖·‖` on `adicCompletion` (normalised:
  `FinitePlace.norm_def`, `‖x‖ = toNNReal (Nv) (v x)`); the normalised archimedean factor `|x|_v = |x|²` is `v x ^ v.mult`.
- `one_le_prod_absAt_of_mem_stableIntegers`: X01D l. 208, "for `y ∈ R ∖ {0}` the bound is `≥ 1`", for `O′ ⊇ R`, the split product
  read over any finite `T` outside which `x` is integral (equal to the product over all split primes, every other factor being
  `1` or less — the inequality goes the right way). `TateModel.IsGap C`: "for `y ∈ Λ ∖ {0}`, `∏_{v|∞}|y|_v · ∏_{w split}|y|_w ≥
  1/C_Λ`", as "smaller than `C` forces `0`"; `exists_isGap` gives `C = d^{−[L:ℚ]}`.
- `exists_one_lt_absAt`: X01D § 3.2, "`u*` non-torsion ⟹ some place `v*` of `L` in `W` … has `|u*|_{v*} > 1`". The route differs
  from X01D's (product formula, then Kronecker): **if `u*` is not integral** some prime has valuation `> 1`
  (`mem_integers_of_valuation_le_one`), and it is split since `u* ∈ R ⊆ O′` is integral at the stable primes
  (`mem_stableIntegers_iff_valuation`); **if `u*` is integral** and `v u* ≤ 1` at every archimedean `v`, then `v ū* = (v.comap σ) u*
  ≤ 1` too (`InfinitePlace.comap_apply`) and `v u* · v ū* = 1`, so every `v u* = 1`, and Kronecker
  (`Embeddings.pow_eq_one_of_norm_eq_one`) makes `u*` a root of unity. No product formula is read in Step 0.
- `exists_unitVector_absAt_lt_one`: X01D § 3.8 takes `g := γ/σ(γ)` with `(γ) = 𝔓_w^h`, `h` the class number. **Any `γ ∈ 𝔓_w`
  with `σγ ∉ 𝔓_w` serves** — it exists because `𝔓_w` and `σ⁻¹𝔓_w` are distinct maximal ideals (`w` split), so neither contains
  the other (`Ideal.IsMaximal.eq_of_le`, `SetLike.not_le_iff_exists`) — and then `|g|_w = |γ|_w < 1`. The class group leaves the
  inputs (a shorter route; § 4).
- `TateModel.thinBox_heavy`: EN2-L31's statement (quoted in the module docstring) with: `μ` a probability measure (`μ(R̂) = 1`;
  `ZeroEntropyCarried` is stated for probability measures, and EN2-L31's `μ(X′) > μ(R̂) − η` is `1 − η < μ.real X′`);
  `∏_{v|∞}(2ε(1 + |u*|_v^{1/2}))²` is `∏ v, (2 * ε * (1 + v u*)) ^ v.mult` (`|u*|_v^{1/2}` normalised is `v u*` ordinary, and the
  square at a complex place is `^ v.mult`); `∏_{w split} max(1,|u*|_w)` is `splitHeight`; `1/C_Λ` is any gap `C` (the lemma holds
  for each, and `exists_isGap` gives one); "every lift `x̃`" is `∀ xw, D.π xw = x →`; `Q_{v*}(2ε, δ)` is `thinBox p (2 * ε) δ`
  with X01D's open archimedean bounds. The hypotheses X01D sets above the lemma (`μ` invariant, `h_μ(u*) = 0`, `v*` expanding)
  are `hμ`, `h0`, `hp`; non-torsion is not one of them (it is read only by Step 0).
- `exists_orbit_box` takes `0 < n` — **with `n = 0` the statement is false** (every pair of points shares the empty name, and
  `y = π(x̃ + a)` with `a ∈ Q(2ε)` fails for `y` far from `x`): X01D's "Induction on `i < n − 1`" starts at `i = 0`, which needs one
  shared cell. The first draft of the leaf had no such hypothesis; the obligation reading below caught it before any proof.
- `exists_heavy_nameCells` is **proved** (three lines): `rot u` preserves `μ` (`measurable_rot`, `hμ u`) and the rate of `P` is at
  most `ksEntropy μ (rot u) = 0` (`partitionEntropy_le_ksEntropy`), so EN2-ZE (`exists_forall_exp_le_measureReal_nameCell`) applies
  word for word — the kernel's check that EN2-ZE as typed is what part (iii′) reads.

### 2.3 Models

`TateModel F` is a structure of data: every theorem over `(D : TateModel F)` is inhabited by `Rigidity.exists_tateModel` (lane T)
and by nothing before it (FS131-KT1 § 2.6). Lemma 3.1′'s measure hypotheses are inhabited at once by the point mass at `1`
(`zeroEntropyCarried_model`: invariant, entropy zero under every non-torsion rotation), with `u = (3 + 4i)/5`
(`exists_nonTorsion_unitVector`), an expanding place from `exists_one_lt_absAt`, a gap from `exists_isGap` and `ε` from
`exists_eps_lt` — every clause exercised, degenerate in that the measure is one atom (the conclusion then holds with `X′ = R̂`:
the image of a thin box at the lift `0` of `1` holds `1`). EN2-L31's non-degenerate model is EF-X's circle measure (X01D § 2.2),
not in the library. `exists_one_lt_absAt`'s hypothesis is inhabited by `(3 + 4i)/5`; `multiplier F 1 = (−3 + 4i)/5`
(`multiplier_one`). `IsGap` is a predicate on a constant: its model is `exists_isGap`'s.

### 2.4 A plan per leaf

**`Rigidity/PlaceSizes`.**

| leaf | route | names |
|---|---|---|
| `size_toSAdele` | `arch`: `normAtPlace_apply`; `split`: `rfl` (`toSplitAdele` is the coercion) | `mixedEmbedding.normAtPlace_apply` |
| `size_toSAdele_mul` | `arch`: `(toSAdele x * a).1 = mixedEmbedding x * a.1`, `normAtPlace` is a `MonoidWithZeroHom` (`map_mul`), then `normAtPlace_apply`; `split`: `norm_mul` | `map_mul`, `norm_mul` |
| `size_add_le`, `size_neg`, `size_nonneg` | `normAtPlace_add_le`, `normAtPlace_neg`, `normAtPlace_nonneg`; `norm_add_le`, `norm_neg`, `norm_nonneg` | as named |
| `size_add_le_max` | `IsUltrametricDist.norm_add_le_max` (the instance on `adicCompletion`; if instance search fails, `Valued.v.map_add` through `FinitePlace.norm_def` and the monotone `toNNReal`) | as named |
| `continuous_size` | `continuous_normAtPlace.comp continuous_fst`; `continuous_norm.comp ((RestrictedProduct.continuous_eval w).comp continuous_snd)` | as named |
| `absAt_mul`, `absAt_nonneg`, `absAt_eq_zero` | `map_mul`, `apply_nonneg`, `map_eq_zero` (an `InfinitePlace` is an `AbsoluteValue`); `norm_mul` with the coercion's `map_mul`, `norm_eq_zero` with the coercion's injectivity | `UniformSpace.Completion.coe_mul`, `norm_mul` |
| `absAt_natCast_le_one` | `FinitePlace.norm_embedding`, `adicAbv_natCast_le_one` | as named |
| `size_le_one_iff` | `FinitePlace.norm_def` and `mem_adicCompletionIntegers` (`Valued.v x ≤ 1`), `toNNReal` monotone and `toNNReal x ≤ 1 ↔ x ≤ 1` | `mem_adicCompletionIntegers` |
| `exists_finset_absAt_le_one` | `HeightOneSpectrum.Support.finite` on `x` (`{v : 1 < v.valuation x}` finite), its preimage under `Subtype.val` (as `toSplitAdele` does), `.toFinset` | `Support.finite` |
| `splitHeight_eq_prod` | `finprod_eq_prod_of_mulSupport_subset`: off `T`, `max 1 (absAt x) = 1` | as named |
| `one_le_splitHeight`, `absAt_le_splitHeight` | from `splitHeight_eq_prod` at a `T` of `exists_finset_absAt_le_one` (for the second, `T ∪ {w}`): `Finset.one_le_prod'` and a single factor below the product of factors `≥ 1` | `Finset.one_le_prod'`, `Finset.prod_le_prod_of_subset_of_one_le'` |
| `one_le_prod_absAt_of_mem_stableIntegers` | `prod_abs_eq_one hx0`; `finprod_comp_equiv FinitePlace.equivHeightOneSpectrum.symm` with `equivHeightOneSpectrum_symm_apply` turns the finite product into one over `HeightOneSpectrum`; it equals the product over a finite `S ⊇` the support (`hasFiniteMulSupport`), split by `Finset.prod_filter_mul_prod_filter_not` into stable primes (each `≤ 1`: `mem_stableIntegers_iff_valuation` and `adicAbv_def`) and split ones (`≤` the product over `T`, by `hT`); all factors positive | `prod_abs_eq_one`, `FinitePlace.equivHeightOneSpectrum_symm_apply`, `FinitePlace.hasFiniteMulSupport`, `mem_stableIntegers_iff_valuation` |
| `ofUnitRing_mem_stableIntegers` | `unitRing_le_stableIntegers` after `UnitRing.coe_mem_unitRingOver_iff` (FS131-KN9's reading of `R` in `L`) | as named |
| `TateModel.exists_isGap` | `C := (d : ℝ)⁻¹ ^ finrank ℚ L` from `exists_nat_mul_mem`; for `y ∈ Λ`, `d·y ∈ O′`; if `y ≠ 0`, PF for `d·y` with the same `T` (`absAt_natCast_le_one`, `absAt_mul`); `v (d y) = d · v y` and `∑ v.mult = finrank` (`InfinitePlace.sum_mult_eq`, `Finset.prod_pow_eq_pow_sum`) give `1 ≤ d^{[L:ℚ]} · (product for y) < d^{[L:ℚ]} C = 1` | `InfinitePlace.sum_mult_eq` |
| `exists_one_lt_absAt` | § 2.2's two cases; `IsIntegral ℤ (unitL u)` decided by `Classical.em`; in the integral case `IsIntegral ℤ ū` by `IsIntegral.map` along conjugation | `mem_integers_of_valuation_le_one`, `InfinitePlace.comap_apply`, `Embeddings.pow_eq_one_of_norm_eq_one`, `IsIntegral.map` |
| `exists_unitVector_absAt_lt_one` | § 2.2; `g := γ / conj γ` as an element of `fieldI F` with `‖g‖ = 1` in `ℂ` (`Complex.norm_conj`); `|γ|_w < 1` by `FinitePlace.norm_lt_one_iff_mem`, `|σγ|_w = 1` by `FinitePlace.norm_eq_one_iff_notMem` | `FinitePlace.norm_lt_one_iff_mem`, `FinitePlace.norm_eq_one_iff_notMem` |
| `countable_fieldI` | `Finsupp.Countable.of_moduleFinite (R := ℚ)` (as `ChainAtTA` does for `F`) | as named |
| `countable_splitPlace` | `Function.Injective.countable` through `w ↦ w.1.asIdeal` (`HeightOneSpectrum.ext`) into `⋃ n, {I | absNorm I = n}`, each finite (`Ideal.finite_setOf_absNorm_eq`), `Set.countable_iUnion` | as named |

**`Rigidity/Multipliers`.**

| leaf | route |
|---|---|
| `multiplier_mem` (private, a proof field) | `re`, `im` are casts of rationals (`SubfieldClass.ratCast_mem F q`, `push_cast`); `‖·‖ = 1` from `(1 − 4b²)² + (4b)² = (1 + 4b²)²` (`Complex.norm_def`, `Complex.normSq_mk`, `Real.sqrt_eq_one`, `field_simp`, `ring`) |
| `coe_multiplier`, `multiplier_one` | `Complex.ext` and `field_simp` (`1 − 2bi ≠ 0`), `norm_num` |
| `multiplier_injective` | equal real parts: `(1 − 4b²)/(1 + 4b²) = 1 − 2 + 2/(1 + 4b²)` is injective in `b ∈ ℕ` (`div_left_injective`-shape; or cross-multiply and `Nat.cast_inj`, `nlinarith`) |
| `absAt_multiplier_arch` | `v = InfinitePlace.mk φ` (`InfinitePlace.apply`); `φ` fixes `ℚ` and `φ(i)² = −1`, so `φ(i) = ±i` and `φ(v_b) ∈ {v_b, v̄_b}`, of norm `1`; `i` is the element `⟨I, _⟩` of `fieldI F` |
| `splitHeight_multiplier_le` | `v_b = z/z̄`, `z = 1 + 2bi`, `z̄` integral (`IsIntegral` of `1` and `i`); `max 1 |v_b|_w ≤ |z̄|_w⁻¹` (`|z|_w ≤ 1`: `FinitePlace.norm_le_one`); the split product `≤` the product over all finite places of `|z̄|_w⁻¹` (factors `≥ 1`; `finprod_le_finprod`, then `finprod` over a subtype `≤` the whole), `= |N z̄|` (`FinitePlace.prod_eq_inv_abs_norm`), `= ∏_v v(z̄)^{mult}` (`InfinitePlace.prod_eq_abs_norm`), `≤ (1 + 2b)^{∑ mult} = (1 + 2b)^{[L:ℚ]}` (`v z̄ ≤ 1 + 2b·v i = 1 + 2b`) |

**`Rigidity/ThinBoxes`.**

| leaf | route | names |
|---|---|---|
| `isOpen_box` | product of `⋂ v, {b : normAtPlace v b < ε}` (finite intersection, `continuous_normAtPlace`) and `{f | ∀ w, f w ∈ O_w}` (`RestrictedProduct.isOpen_forall_mem` with `Valued.isOpen_valuationSubring`, the module's `Fact`) — `IsOpen.prod` | as named |
| `isClosed_closedThinBox` | `isClosed_iInter` of `isClosed_le`; the split condition through `size_le_one_iff` as `⋂ w, {a | size (split w) a ≤ 1}`; `continuous_size` | as named |
| `zero_mem_box`, `sub_mem_box`, `size_le_of_mem_box` | `map_zero`; `normAtPlace` of a difference by `normAtPlace_add_le`/`normAtPlace_neg`, `ValuationSubring.sub_mem`; `size_le_one_iff` | as named |
| `TateModel.sigmaCompactSpace` | `SigmaCompactSpace.of_countable` on `{(· + toSAdele F x) '' K : x ∈ O′}`: countable (`countable_fieldI`, `Set.Countable.image`), compact (`IsCompact.image`, `continuous_add_right`), covering (`exists_isCompact`) | as named |
| `TateModel.measurableSet_image` | `IsSigmaCompact.of_isClosed_subset isSigmaCompact_univ hs`, `IsSigmaCompact.image D.continuous_π`; a σ-compact set is a countable union of compacts, each `IsCompact.measurableSet` (`borelSpace_dual` with `countable_unitRing`, `t2Space_dual`); `MeasurableSet.iUnion` (Mathlib has no `IsSigmaCompact.measurableSet`: probe) | as named |
| `TateModel.iterate_rot_π` | induction on `n`: `Function.iterate_succ_apply'`, `π_unit_mul`, `pow_succ`, `map_mul`, `mul_assoc` | as named |
| `TateModel.exists_box_partition` | the translates `U c := π '' ((c + ·) '' box ε)` are open (`isOpenMap`, `Homeomorph.addLeft`'s openness, `isOpen_box`) and cover (`surjective_π`, `zero_mem_box`); `compactSpace_dual` and `isCompact_univ.elim_finite_subcover` give a `Finset`, enumerated as `Fin k` (`Finset.equivFin`); `P x` := the least index whose set holds `x` (`Nat.find` on `Fin k`'s values, or `Fin.find`); `measurable_to_countable'` with `P ⁻¹' {j} = U_j ∖ ⋃_{i<j} U_i`, each Borel (`IsOpen.measurableSet`) | as named |
| `TateModel.exists_orbit_box` | X01D's induction, as the docstring: `a := q₂ − q₁` (`sub_mem_box`); the lift by `π_eq_π_iff`; at time `i+1` `iterate_rot_π` and `hP` on both points give `b ∈ Q(2ε)` and `y′ ∈ Λ` with `ι y′ = ι(u)·(u^i a) − b` (`mul_mem`-free: `Λ` is a subgroup); bounds by `size_toSAdele_mul`, `size_add_le`, `size_add_le_max`; `y′ = 0` by `hC` at `T :=` a support of `max 1 |u|_w` (`exists_finset_absAt_le_one`, `splitHeight_eq_prod`), `Finset.prod_le_prod` and `pow_le_pow_left₀` for the archimedean factors; strong induction on `i` (`Nat.rec` with the invariant "`u^j a ∈ Q(2ε)` for `j ≤ i`") | as named |
| `TateModel.nameCell_subset` | `mem_nameCell_iff_nameOf` and `exists_orbit_box`; at `i = n − 1`, `size_le_of_mem_box` and `size_toSAdele_mul` with `absAt_mul`/`pow`: `s^{n−1}·|a|_p ≤ max(2ε, 1)` | as named |
| `exists_delta_of_one_lt` | real arithmetic: `n := max (N₀ + 1) (⌈log(c/δ)/log s⌉₊ + 1)`-shaped, or `Nat.find` on `c·s⁻¹^(n−1) ≤ δ` (`tendsto_pow_atTop_nhds_zero_of_lt_one`); then `Real.exp_log`, `Real.rpow_natCast`, `Real.rpow_le_rpow_left_iff` and `δ₀ := min (c·s⁻¹^{N₀}) (c⁻¹·s⁻²)`-shaped | as named |
| `TateModel.thinBox_heavy` | the docstring's route; `measureReal_mono` (finite measure) from `nameCell_subset` and `thinBox_mono` (with `Set.image_mono` twice); `1 − η < 1 − η/2 ≤ μ.real X′` | `measureReal_mono` |
| `exists_eps_lt` | `A := max_v (1 + v x)` (a finite `sup'`; `InfinitePlace` nonempty), `ε := min (1/16) (min (1/(2A)) (C/(2·2A·splitHeight x)))`; every factor `(2εA)^{mult} ≤ 2εA ≤ 1` (`pow_le_of_le_one`, `one_le_mult`), and one factor exists, so the product `≤ 2εA` | `InfinitePlace.one_le_mult` |

## Stage 3 — SAVED: part 3 typed (the pigeonhole and the global point), on the shorter height input

One new module, `Rigidity/GlobalPoint` (11 leaves; `logs/GlobalPoint-s4.log`, `exit=0`, warnings only its `sorry`s), over
`Rigidity/ThinBoxes` and `Rigidity/Multipliers`.

### 3.1 The scales, on the second dated line

The dated line (FS131-KN8): "Lemma 3.2′(a)'s pigeonhole needs `#V_M ≥ c·M^{α′}` for some `α′ > 0` only (its `β` is chosen after
`α′`); `z = 1 + 2bi` gives `α′ = 1/(2[F:ℚ])`". Here the scales are indexed by `B`, the number of multipliers: `v_1, …, v_B`
have heights `≤ (1 + 2B)^D ≤ (3B)^D =: M(B)` (`D = [L:ℚ] = 2[F:ℚ]`; `splitHeight_multiplier_le`), so `#V = B = M^{1/D}/3`:
`α′ = 1/D`, the dated line's `1/(2[F:ℚ])`. X01D's constants with `α′` for `α`: `K = 16`, `β = α′/(2K) = 1/(32D)`
(`heavyExponent`), `δ(B) = M(B)^{−K}` (`scaleThin`). Then `δ(B)^β = (3B)^{−1/2}` and the pigeonhole's
`B·δ(B)^β = (B/3)^{1/2} > 1` holds for every `B ≥ 4` — the count's constant `c₀` and X01D's `M₁`, `M₂` become one explicit bound.
X01D's two scales `M` and `M²` are `B` and `3B²`: `M(3B²) = (9B²)^D = M(B)²` (`scaleHeight_three_mul_sq`).

### 3.2 Read aloud against X01D

- `Collision D x̃ p ε δ B`: X01D l. 255, "there are `v₁ ≠ v₂ ∈ V_M` and `a₁, a₂ ∈ Q_{v*}(2ε, δ(M))` with `r := v₁(x̃ + a₁) −
  v₂(x̃ + a₂) ∈ Λ`" — the data as a structure, `V_M` as `{v_b : 1 ≤ b ≤ B}`, `Q` as the closed box (`closedThinBox`: every bound
  of X01D's table reads `≤ 2ε`, `≤ δ`; the closed box's image is Borel, which the pigeonhole's additivity needs). `ℓ`, `point`,
  `mul_sub_point`: "`ℓ := v₁ − v₂ ∈ R ∖ {0}` and `e := ℓx̃ − r = v₂a₂ − v₁a₁`" (l. 256), "`t := r₁/ℓ₁`" (l. 275), "`e_j = ℓ_j(x̃ − t)`"
  (l. 281).
- `exists_collision`: Step 3 (ll. 254–256), with `B·μ(box) > 1` in place of `Σ_{v ∈ V_M} μ(vB) ≥ c₀M^{α/2} > μ(R̂)`.
- `Collision.point_eq`: Step 4 (ll. 270–275): "`z := ℓ₂r₁ − ℓ₁r₂ = ℓ₁e₂ − ℓ₂e₁ ∈ Λ` … `∏ ≤ (16ε)^{[L:ℚ]}·M^{9−K}` … `< 1/C_Λ`
  for `M` large (and `ε < 1/16`). (An archimedean `v*`: its factor is `≤ (8δ(M))²` …)" — here, both cases at once, the product
  is `≤ 8δ(B)M(B)²M(3B²)² = 8M(B)^{−10}`: at an archimedean `p` the archimedean product is `≤ (8δ)^{mult p} ≤ 8δ` (the other
  factors `≤ 16ε ≤ 1`), at a split `p` it is `≤ 1` and the split product carries `δ`. The hypothesis `8M(B)^{−10} < C` is X01D's
  "`M` large".
- `Collision.size_sub_point_le`: Step 5 (ll. 281–284), "`|ℓ_j|_{v*} ≥ 4^{−[L:ℚ]/2}·M_j^{−2}` … `|x̃ − t|_{v*} ≤ 2^{[L:ℚ]}·M_j^{3−K}`"; the
  bound is stated as `2^{D+2}·M(B)³·δ` for any thinness `δ`, with a factor of `4` of slack over the derivation's (an
  archimedean `p` gives `|ℓ|_p ≥ |ℓ|_p^{mult}/2`).
- `exists_point_of_heavy`: "Iterate the scales `M, M², M⁴, …` with one choice `(ℓ, r)` per scale; each consecutive pair gives
  `z = 0`, so all share one `t`. Letting `j → ∞`: `(x̃ − t)_{v*} = 0`" (ll. 283–284) — for a fixed lift (X01D: "a fixed lift"),
  so the hypothesis is the heavy bound at that lift only, a weaker hypothesis than Lemma 3.1′'s conclusion gives.
- `measure_leafSet_compl_eq_zero`: "So every `x ∈ X′` lies in `T + K_{v*}` …; as `η` was arbitrary, `μ(R̂ ∖ (T + K_{v*})) = 0`.
  **Borel:** `W_{v*}` is closed in the σ-compact `W`, so `π(W_{v*})` is σ-compact, and `T = π(L)` is countable" (ll. 286–287) —
  `leafSet p = π(L + W_p) = T + K_{v*}`, Borel by the same argument (`measurableSet_leafSet`).

### 3.3 Models

`Collision` is inhabited exactly when two moved boxes meet; at the point mass `δ_1` and the lift `0` (`π 0 = 1`), every
moved box holds `1`, so `exists_collision` gives one at every `B ≥ 2` (its hypothesis `1 < B · 1`); at `B = 1` the
hypothesis is false, as it must be — one multiplier makes no collision. The other statements take `(D : TateModel F)` (lane
T's `exists_tateModel`) and the measure hypotheses of Lemma 3.1′ (stage 2.3's model).

### 3.4 A plan per leaf

| leaf | route | names |
|---|---|---|
| `heavyExponent_pos` | `finrank_pos` and `positivity` | `Module.finrank_pos` |
| `scaleHeight_three_mul_sq` | `push_cast`, `mul_pow`, `pow_mul`: `(3·3B²)^D = ((3B)²)^D = ((3B)^D)²` | `ring` |
| `Collision.ℓ_ne_zero` | `sub_ne_zero`, `multiplier_injective` with `c.ne`, `unitL` injective (`Subtype.ext`) | as named |
| `Collision.ℓ_eq_ofUnitRing` | `unitL_eq_ofUnitRing`, `map_sub` | as named |
| `Collision.mul_sub_point` | `c.eq`, `map_mul`, `map_sub`, `map_div₀`, `mul_div_cancel₀` with `ℓ_ne_zero`, `ring` in the commutative ring `W` | as named |
| `Collision.point_eq` | `z := c₂.ℓ * c₁.y − c₁.ℓ * c₂.y ∈ Λ` (`mul_mem_Λ` with `ℓ_eq_ofUnitRing`, `AddSubgroup.sub_mem`); `ι z = ι(ℓ₁)e₂ − ι(ℓ₂)e₁` from `mul_sub_point` twice and `ring`; sizes by `size_toSAdele`, `size_toSAdele_mul`, `size_add_le`, `size_add_le_max`, `absAt_multiplier_arch` (`|ℓ|_v ≤ 2`), `absAt_le_splitHeight` with `splitHeight_multiplier_le` (`|v|_w ≤ M`), `size_le_one_iff` (split components of the box points integral); `T :=` the union of the four multipliers' supports and `p` if split (`exists_finset_absAt_le_one`); the split product `≤ ∏ max(1,·)` of the four, `= ∏ splitHeight ≤ M(B)²M(3B²)²` (`splitHeight_eq_prod`, `Finset.prod_le_prod`, `Finset.prod_mul_distrib`); `scaleHeight_three_mul_sq`; `hC z` with `z = 0` gives `ℓ₂y₁ = ℓ₁y₂`, `div_eq_div_iff` | as named |
| `Collision.size_sub_point_le` | `size_toSAdele_mul` on `mul_sub_point`: `|ℓ|_p·|x̃ − t|_p = |e|_p ≤ 2Mδ`; `|ℓ|_p ≥ 1/(2^{D}M²)` from `one_le_prod_absAt_of_mem_stableIntegers` for `ℓ ∈ O′` (`ofUnitRing_mem_stableIntegers`) with `T` the two multipliers' supports and `p`, every other factor bounded as in `point_eq`; `le_div_iff₀` | as named |
| `TateModel.exists_collision` | the `B` sets `t b := (rot v_b)⁻¹' S`, `S := π '' ((x̃ + ·) '' closedThinBox p (2ε) δ)`, Borel (`measurableSet_image` of the closed `(x̃ + ·) '' …`: `Homeomorph.addLeft` is a closed map, `isClosed_closedThinBox`; `measurable_rot`), each of measure `μ S` (`Measure.map_apply` with `hμ v_b`); `μ univ = 1 < B·μ S = ∑ μ (t b)` (`measureReal` and `ENNReal.ofReal` bookkeeping); `exists_nonempty_inter_of_measure_univ_lt_sum_measure`; for `χ` in two of them, `χ = π c` (`surjective_π`), `iterate_rot_π`/`π_unit_mul` and `π_eq_π_iff` give `ι v_{b}c ≡ x̃ + a_b (mod Λ)`; multiplying the first by `ι v_{b′}` and the second by `ι v_b` (`mul_mem_Λ`) gives `v_{b′}(x̃ + a_b) − v_b(x̃ + a_{b′}) ∈ ιΛ`, a collision with `(b₁, b₂) := (b′, b)` — preimages, not images: no inverse rotation is needed | `exists_nonempty_inter_of_measure_univ_lt_sum_measure`, `Measure.map_apply` |
| `TateModel.exists_point_of_heavy` | § 3.1's arithmetic for `B₀` (`scaleThin` and `8M^{−10}` tend to `0`: `tendsto_pow_atTop_nhds_zero_of_lt_one` on `M⁻¹`); `B_j := Nat.rec B₀ (fun _ B => 3B²)`; a collision at each (`exists_collision`, `Classical.choice`), the heavy bound transferred to the closed box (`measureReal_mono`, `thinBox_subset_closedThinBox`); `point_eq` by induction gives one `t`; `size_sub_point_le` and `le_of_forall_pos_lt_add`-shape on `2^{D+2}M(B_j)^{−13} → 0` (`M(B_j) ≥ 3^{2^j}`), so `p.size (x̃ − ι t) = 0` (`size_nonneg`) | as named |
| `TateModel.measurableSet_leafSet` | `leafSet = ⋃ t, π '' ((ι t + ·) '' hyperplane p)` (`Set.image_iUnion`, `sub_eq_iff_eq_add`); `MeasurableSet.iUnion` over the countable `L` (`countable_fieldI`), `measurableSet_image` of the closed `(ι t + ·) '' W_p` | as named |
| `TateModel.measure_leafSet_compl_eq_zero` | for `η > 0`: `thinBox_heavy` at `β = heavyExponent F` (`heavyExponent_pos`); for `x ∈ X′` a lift (`surjective_π`) and `exists_point_of_heavy` put `x` in `leafSet`; so `1 − η < μ.real X′ ≤ μ.real leafSet` for every `η`, `μ.real leafSet = 1`, and `μ leafSetᶜ = 0` (`prob_compl_eq_one_sub`, `measurableSet_leafSet`) | `prob_compl_eq_one_sub`, `measureReal_mono` |

## Stage 4 — SAVED: part 4 typed (leaves and wandering shells), ending at `zeroEntropyCarried`'s statement

Two new modules: `Rigidity/WanderingShells` (7 leaves; `logs/WanderingShells-s4.log`, `exit=0`) and `Rigidity/ZeroEntropyClosed`
(no leaf of its own; `logs/ZeroEntropyClosed-s4.log`, `exit=0`). **The composition is proved from the parts' statements**:
`zeroEntropyCarried_of_tateModel (D : TateModel F) : ZeroEntropyCarried F` (five lines over `exists_one_lt_absAt`,
`exists_isGap`, `exists_eps_lt`, `measure_leafSet_compl_eq_zero`, `measure_compl_TA_eq_zero`), and
`zeroEntropyCarried_of_numberField (F) [NumberField F] : ZeroEntropyCarried F := (exists_tateModel F).elim
zeroEntropyCarried_of_tateModel`. The kernel's print (`probes/KernelSigs.lean`, `logs/KernelSigs.log`):
`zeroEntropyCarried_of_numberField : ∀ (F : Subfield ℝ) [NumberField ↥F], ZeroEntropyCarried F`, axioms `[propext, sorryAx,
Classical.choice, Quot.sound]` (the `sorryAx` through the leaves of M8b and lane T); `zeroEntropyCarried`, for comparison,
`∀ (F) [NumberField ↥F], NoRamifiedStableDyadic F → ZeroEntropyCarried F`.

### 4.1 The shorter route for X01D §§ 3.7 (ii)–(iii) and 3.8 (a finding; sent to the coordinator at this stage)

X01D fixes `t`, takes the stabiliser `U_t` of finite index (finite `U`-orbits on `L/Λ`), pulls `μ` back to `ν_t` on `W_{v*}` along
the Borel isomorphism `φ_t`, and runs the shells for `g^k ∈ U_t`, `g = γ/σ(γ)` with `(γ) = 𝔓_w^h`. FS131-KN9 § 4.1 replaced
strong approximation by `O′/nO′` finite and Lusin–Souslin by σ-compactness. **Here none of these is read.** The shells are sets
of `R̂`, `S(t, c) := π(ι t + {a ∈ W_p : |a_w|_w = c})`, indexed by `t ∈ L` and `c > 0`, and they **wander** under `rot g` itself:
`(rot g)^m S(t, c) ⊆ S(g^m t, |g|_w^m c)`, and the uniqueness of the lift on a leaf (X01D's own § 3.7 (i), `ι(L) ∩ W_p = 0`) makes
that set disjoint from `S(t, c)` — the uniqueness does what the stabiliser did. A finite invariant measure makes `rot g`
conservative (Mathlib's `MeasurePreserving.conservative`), so every shell is null; countably many shells cover the leaf set
outside `π(L + L_∞)`. `g` needs only `|g|_w < 1`: `γ/γ̄` for any `γ ∈ 𝔓_w ∖ σ𝔓_w`. **Inputs that leave M8b:** the finiteness of
`O′/nO′`, the stabiliser, `ν_t` and the Borel isomorphism `φ_t`, the class group. The step reads `π_eq_π_iff`, `π_unit_mul`,
`mem_TA` and Borel images only.

### 4.2 Read aloud against X01D

- `TateModel.eq_of_π_add_eq`: X01D l. 291, "`t + a ≡ t′ + a′ (mod Λ)` forces `t − t′ − λ ∈ L ∩ W_{v*} = 0`" — its consequence
  `a = a′`, which is what is read.
- `TateModel.shell`, `iterate_rot_not_mem_shell`, `measure_shell_eq_zero`: X01D ll. 303–305, "the shells `A_j := {a ∈ W_{v*} :
  |a_w|_w = N𝔓_w^{j}}` … satisfy `g^k A_j = A_{j−hk}`, so `ν_t(A_j)` is periodic in `j`; their sum … is finite; so every
  `ν_t(A_j) = 0`" — here the shell is the image in `R̂` of `A_j` on the leaf of `t`, `N𝔓_w^j` is any `c > 0`, and "periodic and
  summable" is "wandering for a conservative map".
- `leafSet_subset`, `measure_compl_TA_eq_zero`: X01D ll. 305–306, "Over the countably many split `w`: `ν_t` is carried by
  `W_{v*} ∩ L_∞` … Hence `μ` is carried by `⋃_t π(t + L_∞) = T + A`", with `π(t + L_∞) ⊆ T + A` from `TateModel.mem_TA` (the
  inclusion Step 7 reads, FS131-KT1 § 2.5). The split place `v*` itself needs no case: its shells are empty (`a_{v*} = 0`).
- `zeroEntropyCarried_of_tateModel`, `zeroEntropyCarried_of_numberField`: EF_F⁺ (X01D l. 194, "every `U`-invariant finite
  positive Borel measure `μ` on `R̂` such that `h_μ(u*) = 0` for one non-torsion `u* ∈ U` satisfies `μ(R̂ ∖ (T + A)) = 0`") at a
  probability measure, which is `ZeroEntropyCarried`'s own reading.

### 4.3 Is `NoRamifiedStableDyadic F` read? (brief item 5)

**No step of the plan reads it.** Its parts read the interface's fields (stage 1.3), `R ⊆ O′` (`ofUnitRing_mem_stableIntegers`,
through `unitRing_le_stableIntegers`, proved over every real number field) and Mathlib; nothing reads `R = O′`
(`unitRing_eq_stableIntegers`, the only theorem of the chain that takes the scope's place) or the scope itself. The kernel
says the same of the statements: `zeroEntropyCarried_of_tateModel` and `zeroEntropyCarried_of_numberField` elaborate with no
scope binder, and the five parts they compose take none (`logs/KernelSigs.log`). Lane T's `exists_tateModel` takes none either
(FS131-KT1 § 1). So, once the leaves are proved, **the implementer of the landing drops the binder** under the standing rule
(inventory item 788's ruling), and EF_F⁺ — hence MR⁺ given `entropySplit` — holds over every real number field: the KN9 dated
line's reading, now typed. Where a reader might look for it and it is not: Lemma PF reads `O′`, not `R` (`c·O′ ⊆ R`,
`exists_mul_stableIntegers_le`, is not read either: the pigeonhole's `ℓ` lies in `R ⊆ O′`, and Lemma PF for `O′` is what bounds it).

### 4.4 The home of `zeroEntropyCarried`'s proof (proposed)

`Rigidity/ZeroEntropyClosed`, downstream of `Rigidity/WanderingShells` and `Rigidity/TateExists`. At the landing:
`zeroEntropyCarried` leaves `Rigidity/ChainAtTA` (upstream of the parts — an import cycle otherwise) and is stated in
`Rigidity/ZeroEntropyClosed` without its scope binder, proved by `zeroEntropyCarried_of_numberField` (or replaced by it); its
readers in `ChainAtTA` — `mrPlus` and `min_localBound_five_le_chromaticNumber_closed` — move with it, beside `entropySplit`'s move
downstream of `Rigidity/EntropySplitMax` (inventory item 761, ruling 5). If the landing prefers one assembly module for both
moves, `ZeroEntropyClosed` is its first half. I have not edited `ChainAtTA` (not mine).

### 4.5 Models

`TateModel.shell`'s lemmas: a finite invariant measure, `c > 0`, `|g|_w < 1` are met at once by `δ_1`, `c = 1`, and
`exists_unitVector_absAt_lt_one`. The shells are nonempty: `W_p` holds points with `|a_w|_w = 1` at a split `w ≠ p` (a point
of `W` whose only nonzero component is `1` at `w`), so the wandering statement is not vacuous. The composition's model is
`zeroEntropyCarried_model` (its conclusion at `δ_1`) and `exists_tateModel` (its structure).

### 4.6 A plan per leaf

| leaf | route | names |
|---|---|---|
| `TateModel.eq_of_π_add_eq` | `π_eq_π_iff`: `ι t + a = ι t′ + a′ + ι y`; `a − a′ = ι(t′ + y − t)` lies in `W_p` (`size_add_le`, `size_neg`, `size_nonneg`: `W_p` is a subgroup), so `t′ + y − t = 0` (`eq_zero_of_toSAdele_mem_hyperplane`) and `a = a′` | as named |
| `TateModel.measurableSet_shell` | `(ι t + ·) '' {a ∈ W_p : size (split w) a = c}` is closed (`isClosed_hyperplane`, `isClosed_eq (continuous_size _)`, `Homeomorph.addLeft`'s closedness); `measurableSet_image` | `Homeomorph.isClosedMap` |
| `TateModel.iterate_rot_not_mem_shell` | `χ = π(ι t + a)`; `iterate_rot_π`, `map_mul`, `mul_add`: `(rot g)^[m] χ = π(ι(g^m t) + ι(g^m)a)`, `ι(g^m)a ∈ W_p` (`toSAdele_mul_mem_hyperplane`); if it equals `π(ι t + a′)` with `a′` in the shell, `eq_of_π_add_eq` gives `ι(g^m)a = a′`, and `size_toSAdele_mul`, `absAt_mul` (power) give `|g|_w^m c = c`, against `pow_lt_one₀` (`absAt_nonneg`, `hm`) and `c > 0` | `pow_lt_one₀` |
| `TateModel.measure_shell_eq_zero` | `g` from `exists_unitVector_absAt_lt_one w`; `MeasurePreserving (rot g) μ μ` (`measurable_rot`, `hμ g`); `.conservative`; `by_contra`, `Conservative.exists_mem_iterate_mem` (`measurableSet_shell`'s `.nullMeasurableSet`) gives a returning point, against `iterate_rot_not_mem_shell` | `MeasurePreserving.conservative`, `Conservative.exists_mem_iterate_mem` |
| `exists_absAt_eq_norm` | `‖z‖ = toNNReal (Valued.v z)` (`FinitePlace.norm_def`); `Valued.v z = Valued.v y` for `y ∈ L` close to `z` (`UniformSpace.Completion.denseRange_coe` and the ultrametric `‖z − y‖ < ‖z‖ ⟹ ‖y‖ = ‖z‖`, `IsUltrametricDist.norm_add_eq_max_of_norm_ne_norm`-shape); `y ≠ 0` since `‖y‖ = ‖z‖ > 0` | as named; the last to confirm by `exact?` |
| `TateModel.leafSet_subset` | `χ = π a`, `a′ := a − ι t ∈ W_p`; if `∀ w, a′.2 w = 0` then `a′ = (a′.1, 0)` (`Prod.ext`, `RestrictedProduct.ext`) and `χ = π(ι t + (a′.1, 0)) ∈ TA F` (`mem_TA`); else `exists_absAt_eq_norm` at a `w` with `a′.2 w ≠ 0` puts `χ` in a shell (`Set.mem_iUnion`) | `RestrictedProduct.ext`, `TateModel.mem_TA` |
| `TateModel.measure_compl_TA_eq_zero` | `(TA F)ᶜ ⊆ (leafSet p)ᶜ ∪ ⋃ shells` (`leafSet_subset`, `Set.compl_subset_compl`); `measure_union_null` with `hY` and `measure_iUnion_null` four times (`countable_splitPlace`, `countable_fieldI`; each shell null by `measure_shell_eq_zero`, `c = absAt y > 0` by `absAt_eq_zero`, `absAt_nonneg`); `measure_mono_null` | `measure_iUnion_null`, `measure_mono_null` |

## Stage 5 — SAVED: the domain pass and the obligation pass

### 5.1 The domain pass (`debruijn-domain-modeling`, a fresh invocation, scoped to this job's new definitions)

- **`WPlace` an inductive with two named constructors** — the change stage 2 records (the `Sum` abbrev lost dot notation). The
  next lemma states in the vocabulary in one line (`size_toSAdele_mul`, `eq_zero_of_toSAdele_mem_hyperplane`), and every
  statement that must treat the expanding place as archimedean *or* split treats it as one `p : WPlace F`.
- **`size` (on `W`) and `absAt` (on `L`) are two costumes of one absolute value, bridged** by `size_toSAdele` — the bridge is
  typed the same day, so they cannot drift. `hyperplane p` is defined through `size`, which makes closedness and stability
  under the diagonal one line each, against a component-wise definition that would need both cases twice.
- **`splitHeight` is a `finprod` with no junk value**: its factors are `max 1 (·)`, equal to `1` off a finite set for every
  `x` (`exists_finset_absAt_le_one`), so the infinite-support case where `finprod` returns `1` never arises; consumers read it
  through `splitHeight_eq_prod` at a finite set of their choosing.
- **`IsGap C` is "smaller than `C` forces `0`" over every finite `T` outside which the point is integral**, not a `finprod` over
  all split primes: true for every such `T` (the omitted factors are at most `1`, so the product over `T` is at least the full
  one), and it lets each consumer — the orbit step, the two scales — choose its `T` without proving a support. The adversary
  `C ≤ 0` satisfies `IsGap` vacuously; `exists_isGap` asks `0 < C`, and every consumer that needs the gap to bite asks it too
  (`exists_point_of_heavy`'s `hC0`).
- **Four boxes, not two** (`box`/`closedBox`, `thinBox`/`closedThinBox`): considered as "declarations identical modulo naming"
  and kept. The open box is read by the partition (openness) and by Lemma 3.1′'s statement (EN2-L31's `Q_{v*}(2ε, δ)`, kept word
  for word); the closed one by the pigeonhole (Borel images). Collapsing to the closed box would weaken Lemma 3.1′'s statement
  below the derivation's; the transfer costs one `measureReal_mono`.
- **`multiplier` by its coordinates**, with `coe_multiplier` the bridge to `(1 + 2bi)/(1 − 2bi)`: membership in `unitVectors F` is
  then a fact about rationals.
- **`Collision` a structure of data** — Step 3's output is exactly this tuple and Step 4 consumes two; as an existential the
  two collisions' parts would be destructured and re-bound in every consumer. Its parameters `(D, x̃, p, ε, δ, B)` are what
  every bound reads.
- **`shell` indexed by a real `c` with `0 < c` a named hypothesis** rather than by `y ∈ Lˣ`: the hypothesis is per-use (the
  shell at `c = 0` is the large set `a_w = 0`, and only the wandering lemma excludes it); the union in `leafSet_subset` is over
  `y ≠ 0`.
- **Names**: no new declaration clashes with a name of the library (searched by full statement head, `data/fs131/k8b1` § 5.1's
  grep; the one `shell` elsewhere is `Coset`'s, in another namespace).
- **Unsampled member**: `F = ℚ` (`L = ℚ(i)`), where every definition reads as intended — the split primes lie over
  `p ≡ 1 (mod 4)`, `(3 + 4i)/5` expands at the prime `(2 − i)` above `5`, and `v_1 = (−3 + 4i)/5`. No definition changed by this
  pass beyond stage 2's.

### 5.2 The obligation pass (`debruijn-obligation-modeling`, a fresh invocation, scoped to this job's new statements)

The space of each nontrivial leaf, its induction, and what the pass changed:

- `exists_orbit_box`: induction on `i < n` with the statement's own conclusion as the invariant (`u^i a ∈ Q(2ε)`); the step reads
  the shared cell at time `i + 1` (from `hxy`) and the invariant at `i`, and closes by the gap — local, one application of
  `hC`. The base needs one shared cell: `0 < n` (stage 2.2; the statement is false without it).
- `exists_point_of_heavy`: induction on the scale index `j` with invariant "the point at scale `j` is the point at scale `0`";
  the step is `point_eq`, the limit is one inequality. The measure is the scale index, strictly increasing scales `B_{j+1} = 3B_j²`.
- `exists_delta_of_one_lt`: `n` is the least length thinner than `δ` — a `Nat.find`; no induction.
- **Mutation audit** (each hypothesis deleted once, in thought, against its proof route): `hu` of `exists_one_lt_absAt` is
  load-bearing (`u = 1` is isometric everywhere); `hc` of the shell lemmas (the shell at `c = 0` does not wander); `hC0` of
  `exists_point_of_heavy` (every `C ≤ 0` is a gap, and the scale condition `8M^{−10} < C` then fails); `hp` of Lemma 3.1′ (no
  thinning without expansion); `hε16` of `point_eq` (the archimedean factors `16ε`). **Dead hypotheses removed** (each implied by
  another binder, so each removal strengthens the statement and changes no reader): `(hε : 0 < ε)` of `exists_orbit_box` and
  `nameCell_subset` (`hP` makes `box ε` nonempty); `hε`, `hB` of `Collision.point_eq` (`hB` from `c₁.mem₁`); `hε16`, `hB`, `hδ` of
  `Collision.size_sub_point_le` (it reads no `ε`; `δ ≥ 0` and `B ≥ 1` follow from the collision's own fields); `hε` of
  `exists_point_of_heavy`. Re-elaborated: `logs/ThinBoxes-s5.log`, `GlobalPoint-s5.log`, `WanderingShells-s5.log`,
  `ZeroEntropyClosed-s5.log`, each `exit=0` with 14, 11, 7, 0 `sorry`s; the composition still elaborates.
- **Kept, though not strictly needed**: `hc : 0 < c` of `exists_delta_of_one_lt` (the least-`n` route takes `log(c/δ)`), and
  `hε : 0 < ε` of `thinBox_heavy` (the partition (i) reads it).
- **Prove / test / assume.** Prove: every leaf above. Test: the spec examples of each definition (`rfl`/`Iff.rfl`). Assume:
  nothing new — the module's only assumptions are the interface (a structure, inhabited by lane T) and the leaves of other
  lanes it cites by statement (`mem_stableIntegers_iff_valuation`, EN2-ZE, `DualGroup`'s scoped instances).

## Stage 6 — SAVED: the lanes, the price, the drafts, the checks

### 6.1 The lanes (none shares a file with another)

Every module's statements are typed and elaborate, so the five lanes can run beside each other now, each against the others'
statements; the order matters only for the landing.

| lane | writes | needs (statements only, unless said) | leaves |
|---|---|---|---|
| **K8-A** — the places | `Rigidity/PlaceSizes` | Mathlib; `mem_stableIntegers_iff_valuation` (lane T-C's leaf in `Rigidity/TateCharacter`); `unitRing_le_stableIntegers` (proved) | 23 |
| **K8-M** — the multipliers | `Rigidity/Multipliers` | K8-A's statements | 6 |
| **K8-B** — the thin boxes, Lemma 3.1′ | `Rigidity/ThinBoxes` | K8-A's; `TateModel.isOpenMap`, `π_eq_π_iff` (lane T-I); EN2-ZE (lane N, proved); `Rigidity/DualGroup`'s scoped instances (compact, Borel: KN8's M4 leaves) | 14 |
| **K8-G** — the pigeonhole and the global point | `Rigidity/GlobalPoint` | K8-A's, K8-M's, K8-B's; `TateModel.mul_mem_Λ`, `π_eq_π_iff` (T-I) | 11 |
| **K8-S** — the shells | `Rigidity/WanderingShells` | K8-G's; `TateModel.mem_TA` (proved over T-I's `toSAdele_mem_torsionChars`) | 7 |
| *(landing)* | `Rigidity/ZeroEntropyClosed`, the move of `zeroEntropyCarried` out of `Rigidity/ChainAtTA` (§ 4.4) | everything above and lane T (`exists_tateModel`) | — |

**What M8b needs of lane T**, for its records to print the standard three: T-I's four leaves of `Rigidity/TateModel`
(`mul_mem_Λ`, `π_eq_π_iff`, `toSAdele_mem_torsionChars`, `isOpenMap`), T-C's `mem_stableIntegers_iff_valuation`, and — through
`exists_tateModel` in the assembly — all of lane T. M8b reads no other lane-T name.

### 6.2 The price (from the plan's tables, not from an elaborated leaf — re-price from the first two)

About 1,600–1,900 lines: K8-A about 500 (Lemma PF and its `finprod` bookkeeping the bulk), K8-M about 150, K8-B about 450
(the orbit induction and the partition), K8-G about 500 (the bounds of `point_eq`), K8-S about 200. About two and a half
agent-days of implementer work; under a day of wall time with three lanes at once (K8-A, K8-B and K8-S first: none waits on
another's proofs). `LEAN.md`: "A kernel leaf priced from a plan's table is priced high" — the first two leaves re-price it.

### 6.3 Drafts for files I do not write

- **`data/fs131/claims-NF2.md` § Dated lines** (each follows the last line there):
  - "2026-10-14 — **M8b's parts 2–4 are typed over `TateModel F`, and EF_F⁺ is stated with no scope (FS131-K8B1).** Lemma PF,
    Step 0, the multipliers `(1 + 2bi)/(1 − 2bi)`, the thin boxes and Lemma 3.1′ (EN2-L31 word for word, its part (iii′) over
    EN2-ZE as typed), the pigeonhole, two scales, the global point, the leaves and the shells, in five modules
    (`Rigidity/PlaceSizes`, `Multipliers`, `ThinBoxes`, `GlobalPoint`, `WanderingShells`); their composition
    `Rigidity.zeroEntropyCarried_of_tateModel (D : TateModel F) : ZeroEntropyCarried F` is proved from the leaves, and with
    `exists_tateModel` gives `Rigidity.zeroEntropyCarried_of_numberField (F) [NumberField F] : ZeroEntropyCarried F`
    (`Rigidity/ZeroEntropyClosed`). No step reads `NoRamifiedStableDyadic F` or `R = O′`: once the leaves land, EF_F⁺ holds over
    every real number field (a plan, one mind; the kernel is its test)."
  - "2026-10-14 — **EF_F⁺'s Steps 6–7 on a shorter route (FS131-K8B1; a plan, one mind).** The lift of a point of a leaf
    `π(ι t + W_{v*})` is unique (`ι(L) ∩ W_{v*} = 0`), so the shells `π(ι t + {a ∈ W_{v*} : |a_w|_w = c})`, `c > 0`, wander under
    `rot g` for any unit vector `g` with `|g|_w < 1` — `g = γ/γ̄`, `γ ∈ 𝔓_w ∖ σ𝔓_w`, no class number — and a finite invariant measure
    makes `rot g` conservative: every shell is null. Finite `U`-orbits on `L/Λ`, the stabiliser `U_t`, the measure `ν_t` and the
    Borel isomorphism `φ_t` leave EF_F⁺'s inputs. Step 0 reads no product formula (integral or not, then Kronecker)."
- **`LEAN.md` § Searching — Lean**, new lines:
  - "An `abbrev` over `Sum` loses dot notation: `p.size` for `p : A ⊕ B` looks for `Sum.size` ('Invalid field'). A type of places
    of two kinds is an `inductive` with named constructors (`Rigidity.WPlace`, FS131-K8B1)."
  - "A combining character is not an identifier character: `x̃` (x with U+0303) is 'expected token' at the binder (FS131-K8B1)."
  - "At the pin `NumberField.mixedEmbedding.normAtPlace w` is a `MonoidWithZeroHom` (`mixedSpace K →*₀ ℝ`): `map_mul` is its
    multiplicativity (no `normAtPlace_mul` exists); there is no `IsSigmaCompact.measurableSet` (a countable union of
    `IsCompact.measurableSet`); `NumberField.Embeddings.pow_eq_one_of_norm_eq_one` is in
    `Mathlib.NumberTheory.NumberField.InfinitePlace.Embeddings` (FS131-K8B1, `data/fs131/k8b1/probes/Names*.lean`)."
  - "A wandering set of a finite invariant measure is null with no periodicity argument: `MeasurePreserving.conservative` and
    `Conservative.exists_mem_iterate_mem` (a null-measurable set of positive measure has a point returning under some
    `f^[m]`, `m ≠ 0`); the pigeonhole on measure is `exists_nonempty_inter_of_measure_univ_lt_sum_measure` (FS131-K8B1)."
  - "A new module that another new module imports needs its `.olean` for `lake env lean`: elaborate them in order with
    `lean -o` into the build directory, new modules only (`data/fs131/k8b1/seq.sh`, after FS131-KT1's `seq.sh`)."
- **`BIBLIOGRAPHY.md`**: no new row. This job read no outside source; it cites `[Tate1950]`, `[ChothiEverestWard1997]`
  and `[EinsiedlerFish2010]` only through X01D and EN2 (none read here), and Kronecker's theorem and the product formula as
  Mathlib's.
- **`ARCHITECTURE.md`**: written by this job (six rows, § 3); § Trust: nothing new (no axiom, no purchase).
- **`scripts/Axioms.lean`**: nothing to add while the modules are skeletons; at their landing,
  `zeroEntropyCarried_of_numberField` (and the moved `zeroEntropyCarried`) are records to audit.

### 6.4 The checks at the hand-back

- **Build 1** (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`): `exit=0`, 254 of 254 batches, 7 modules rebuilt (the six
  new ones and `Proofs`), 7 m 15 s (`logs/build1.log`). **Lint 1**: `exit=1` — `exists_heavy_nameCells` had an unused
  `[NumberField F]` (a proved theorem, so the linter reads it; `lake env lean` does not), and `unitL_eq_ofUnitRing` drew the
  build's unused-section-variable warning. Both now `omit [NumberField F] in` (`logs/lint.log`).
- **Build 2**: `exit=0`, 254 of 254, 7 rebuilt, 7 m 36 s; the six new modules' only warnings are their `sorry`s (gate log
  `build/gate/build/20261014T094320Z-2493748.log`; `logs/build2.log`). **Lint 2**: `exit=0`, `-- Linting passed for Proofs.`, 14
  linters `Passed` (`logs/lint2.log`).
- **Architecture** (`tools/check_architecture.py`): coverage `[1]` passes (376 rows, 376 modules, the six new ones included); `[2]`
  reports one failure, inherited — `Rigidity/ZeroEntropyNames`' imports cell, fixed on `fs131-wdg` by FS131-IDG1 (FS131-KN9 § 5.3,
  FS131-KT1 § 2.6); the six new rows pass (`logs/architecture.log`).
- **The kernel's print** after the passes (`logs/KernelSigs2.log`): `zeroEntropyCarried_of_numberField : ∀ (F : Subfield ℝ)
  [NumberField ↥F], ZeroEntropyCarried F`, axioms `[propext, sorryAx, Classical.choice, Quot.sound]`.
- **The gate's other steps** (axiom audit, vacuity, assumptions, doubled names) are the landing's: these modules are skeletons and
  print `sorryAx`, so `scripts/axioms.sh` reads them as debt by design. For the vacuity scan: every statement takes
  `(D : TateModel F)`, read `GENERIC`, inhabited by `exists_tateModel` (lane T); no colouring binder is added.
