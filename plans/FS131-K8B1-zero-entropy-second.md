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
