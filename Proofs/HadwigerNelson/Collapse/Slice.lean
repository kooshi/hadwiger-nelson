import Proofs.HadwigerNelson.Collapse.Dichotomy
import Proofs.HadwigerNelson.Rigidity.CountExtension

/-!
# Spectrum on `T + A` gives a measurable `k`-colouring of the slice `Δ × K` (FS-131, job FS131-KCL1; module C4)

**Read aloud, against the informal claim** (V1-L4, L5, L8, `plans/FS103-V1-verification.md` ll. 125–142; V2 L1 (b), L2, L-WA,
L4). An invariant random proper `k`-colouring of `Cay(R, U)` whose colour spectral measure is carried by `T + A` is continuous
in probability for the completion's topology (`tendsto_measure_ne_k`), so it extends to a jointly measurable random colouring
of the completion `G = (L ⊗ ℝ) × K` whose edges `(g, g + t)`, `t` in the closure of the unit vectors, are almost surely
bichromatic (`exists_extension_k`); a sample, read on the plane `Δ ⊂ L ⊗ ℝ` (`Rigidity.Counting.Delta`), is a measurable
colouring of `ℂ × K` with null monochromatic edges `(z, x) ~ (z + e^{iθ}, x + ιK u)` at every unit vector `u`
(`exists_slice_k`). This is the four-colour `Rigidity/CountExtension` at `Fin k`.

**What the slice replaces.** The derivation's strong approximation (V1-L4) is the completion's definition (the closure of
`R`, `Rigidity.Counting.Kgrp`); its weak approximation and diagonal merge (V1-L8; V2 L-WA, L4) are the one plane `Δ` and
`Rigidity.Counting.mem_closure_ιG`, at every number field, totally real or not; its measurable version (Doob–Cohn; V2-MV) is
`exists_extension`'s Borel–Cantelli route.

**`exists_slice_of_colorable`** composes the line so far: a proper `k`-colouring of `F²` gives such a slice colouring, over
every real number field — on `Rigidity.mrPlus` (the dichotomy) and nothing else beyond the standard three axioms.

**Models.** Over `ℚ` at `k = 2`: the residue colouring at the ramified prime above `2`, randomly translated, is an invariant
colouring with torsion spectrum, so in `T + A` (the four-colour module's model, `Rigidity/CountExtension`).
-/

namespace HadwigerNelson.Collapse

open SpectralChain SpectralInputs MeasureTheory NumberField Rigidity Rigidity.Counting Filter Topology Plane

noncomputable section

variable {F : Subfield ℝ} [NumberField F] {k : ℕ}

-- FS131-ICO2: the proofs, `Rigidity/CountExtension`'s at `Fin k`. The colour spectral measure's coefficient is
-- `P(c(0) = c(y))` itself, so `σ(R̂) = 1` and the defect is `1 − Re ∫ χ(y) dσ`, with no tetrahedral constant.

omit [NumberField F] in
/-- **The disagreement is the colour spectral measure's defect**: `P(c(0) ≠ c(y)) = 1 − Re ∫ χ(y) dσ` (the four-colour
`measure_ne_eq`, here with no tetrahedral constant: `σ(R̂) = P(c(0) = c(0)) = 1`). -/
theorem measure_ne_eq_k (μ : InvColouring F k) {σ : Measure (Dual F)} (hσ : IsColourSpectral μ.μ σ) (y : unitRing F) :
    (μ.μ {c | c 0 ≠ c y}).toReal = 1 - (∫ χ, (χ y : ℂ) ∂σ).re := by
  haveI := μ.isProb
  have hm : MeasurableSet {c : unitRing F → Fin k | c 0 = c y} :=
    measurableSet_eq_fun (measurable_pi_apply 0) (measurable_pi_apply y)
  have hc : {c : unitRing F → Fin k | c 0 ≠ c y} = {c | c 0 = c y}ᶜ := rfl
  rw [hσ.2 y, Complex.ofReal_re, hc, ← measureReal_def, measureReal_compl hm, probReal_univ]

/-- **C1, continuity in probability** at `k` colours: with spectrum on `T + A`, `P(c(0) ≠ c(y)) → 0` as `ιG y → 0`. -/
theorem tendsto_measure_ne_k (μ : InvColouring F k) {σ : Measure (Dual F)} (hσ : IsColourSpectral μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) : Tendsto (fun y => μ.μ {c | c 0 ≠ c y}) (comap (ιG F) (𝓝 0)) (𝓝 0) := by
  haveI : IsFiniteMeasure σ := hσ.1
  haveI := μ.isProb
  -- the coefficient tends to `σ univ` by dominated convergence
  have hpt : ∀ᵐ χ ∂σ, Tendsto (fun y : unitRing F => ((χ y : Circle) : ℂ)) (comap (ιG F) (𝓝 0)) (𝓝 (1 : ℂ)) := by
    have hae : ∀ᵐ χ ∂σ, χ ∈ TA F := by
      rw [ae_iff]; simpa [Set.compl_def] using hTA
    filter_upwards [hae] with χ hχ
    have hc : @Continuous (unitRing F) Circle (tauPrime F) _ fun y => χ y := TA_subset_contChars F hχ
    have h0 := (@Continuous.tendsto _ _ (tauPrime F) _ _ hc 0)
    rw [AddChar.map_zero_eq_one] at h0
    have hcoe : Continuous (fun z : Circle => (z : ℂ)) := by fun_prop
    have := ((hcoe.tendsto 1).comp h0).mono_left (comap_ιG_le_nhds_tauPrime F)
    rw [Circle.coe_one] at this
    exact this
  have hint : Tendsto (fun y : unitRing F => ∫ χ, ((χ y : Circle) : ℂ) ∂σ) (comap (ιG F) (𝓝 0))
      (𝓝 (∫ _χ, (1 : ℂ) ∂σ)) := by
    refine tendsto_integral_filter_of_dominated_convergence (fun _ => (1 : ℝ)) ?_ ?_ ?_ hpt
    · exact Eventually.of_forall fun y => (measurable_eval y).aestronglyMeasurable
    · exact Eventually.of_forall fun y => Eventually.of_forall fun χ => by simp
    · exact integrable_const _
  -- `σ univ = 1`, from the coefficient at `0`
  have h1 : (∫ _χ, (1 : ℂ) ∂σ) = 1 := by
    have h := hσ.2 0
    simp only [AddChar.map_zero_eq_one, Circle.coe_one] at h
    rw [h, Set.setOf_true, probReal_univ, Complex.ofReal_one]
  rw [h1] at hint
  have hre : Tendsto (fun y => (∫ χ, (χ y : ℂ) ∂σ).re) (comap (ιG F) (𝓝 0)) (𝓝 1) := by
    have := (Complex.continuous_re.tendsto 1).comp hint
    simpa [Function.comp_def] using this
  have hreal : Tendsto (fun y => (μ.μ {c | c 0 ≠ c y}).toReal) (comap (ιG F) (𝓝 0)) (𝓝 0) := by
    simp_rw [measure_ne_eq_k μ hσ]
    have := hre.const_sub (1 : ℝ)
    simpa using this
  have hfin : ∀ y, μ.μ {c | c 0 ≠ c y} ≠ ⊤ := fun y => measure_ne_top _ _
  have := (ENNReal.tendsto_ofReal hreal)
  rw [ENNReal.ofReal_zero] at this
  refine this.congr fun y => ?_
  exact ENNReal.ofReal_toReal (hfin y)

omit [NumberField F] in
-- Shift invariance, read at a pair: `P(c(a) ≠ c(b)) = P(c(0) ≠ c(b − a))` (`CountExtension`'s private
-- `measure_ne_shift` at `Fin k`).
private theorem measure_ne_shift_k (μ : InvColouring F k) (a b : unitRing F) :
    μ.μ {c | c a ≠ c b} = μ.μ {c | c 0 ≠ c (b - a)} := by
  have hmeas : Measurable (fun (c : unitRing F → Fin k) (x : unitRing F) => c (x + a)) :=
    measurable_pi_lambda _ fun x => measurable_pi_apply _
  have hS : MeasurableSet {c : unitRing F → Fin k | c 0 ≠ c (b - a)} :=
    (measurableSet_eq_fun (measurable_pi_apply 0) (measurable_pi_apply (b - a))).compl
  calc μ.μ {c | c a ≠ c b} = μ.μ ((fun c x => c (x + a)) ⁻¹' {c | c 0 ≠ c (b - a)}) := by
        congr 1; ext c; simp [sub_add_cancel]
    _ = (μ.μ.map (fun c x => c (x + a))) {c | c 0 ≠ c (b - a)} := (Measure.map_apply hmeas hS).symm
    _ = μ.μ {c | c 0 ≠ c (b - a)} := by rw [μ.shift_inv a]

omit [NumberField F] in
-- An edge is almost surely bichromatic: `μ` is carried by the proper colourings (`CountExtension`'s private
-- `measure_eq_add_unit` at `Fin k`).
private theorem measure_eq_add_unit_k (μ : InvColouring F k) (a : unitRing F) {u : unitRing F}
    (hu : u ∈ unitVectorsR F) : μ.μ {c | c a = c (a + u)} = 0 := by
  refine measure_mono_null (show {c | c a = c (a + u)} ⊆ (Xk F k)ᶜ from fun c hc hX => ?_) μ.carried
  exact hX a (a + u) (by rw [Subring.coe_add, add_sub_cancel_left]; exact hu) hc

/-- **C2–C3 at `k` colours**: a jointly measurable random colouring of the completion, almost surely bichromatic on every
edge `(g, g + t)` with `t` in the closure of the unit vectors (the four-colour `Rigidity.Counting.exists_extension`). -/
theorem exists_extension_k (μ : InvColouring F k) {σ : Measure (Dual F)} (hσ : IsColourSpectral μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) :
    ∃ f : (unitRing F → Fin k) → G F → Fin k, Measurable (Function.uncurry f) ∧
      ∀ g t, t ∈ closure (ιG F '' unitVectorsR F) → μ.μ {c | f c g = f c (g + t)} = 0 := by
  classical
  haveI := μ.isProb
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  obtain ⟨en, hen⟩ := exists_surjective_nat (unitRing F)
  -- neighbourhoods `W n` of `0` on whose triple differences the disagreement is at most `2^{−n}`
  have hT := tendsto_measure_ne_k μ hσ hTA
  have hW : ∀ n : ℕ, ∃ W ∈ 𝓝 (0 : G F), ∀ a ∈ W, ∀ b ∈ W, ∀ d ∈ W, ∀ y : unitRing F,
      ιG F y = a - b - d → μ.μ {c | c 0 ≠ c y} ≤ (1 / 2) ^ n := by
    intro n
    have hε : (0 : ENNReal) < (1 / 2) ^ n := ENNReal.pow_pos (by norm_num) n
    obtain ⟨V, hV, hVsub⟩ := Filter.mem_comap.mp (hT (Iio_mem_nhds hε))
    have hcont : Continuous (fun p : G F × G F × G F => p.1 - p.2.1 - p.2.2) := by fun_prop
    have h2 : (fun p : G F × G F × G F => p.1 - p.2.1 - p.2.2) ⁻¹' V ∈ 𝓝 ((0 : G F), (0 : G F), (0 : G F)) :=
      hcont.continuousAt.preimage_mem_nhds (by simpa using hV)
    rw [nhds_prod_eq] at h2
    obtain ⟨W₁, hW₁, T₂, hT₂, hsub⟩ := Filter.mem_prod_iff.mp h2
    rw [nhds_prod_eq] at hT₂
    obtain ⟨W₂, hW₂, W₃, hW₃, hsub2⟩ := Filter.mem_prod_iff.mp hT₂
    refine ⟨W₁ ∩ W₂ ∩ W₃, inter_mem (inter_mem hW₁ hW₂) hW₃, fun a ha b hb d hd y hy => ?_⟩
    have hp : (a, b, d) ∈ (fun p : G F × G F × G F => p.1 - p.2.1 - p.2.2) ⁻¹' V :=
      hsub ⟨ha.1.1, hsub2 ⟨hb.1.2, hd.2⟩⟩
    have hyV : y ∈ ιG F ⁻¹' V := by
      simp only [Set.mem_preimage, hy]; exact hp
    exact (hVsub hyV).le
  choose W hWn hWp using hW
  -- open, decreasing, inside `W n`
  set O : ℕ → Set (G F) := fun n => ⋂ k ∈ Finset.range (n + 1), interior (W k) with hO
  have hOopen : ∀ n, IsOpen (O n) := fun n => isOpen_biInter_finset fun k _ => isOpen_interior
  have hO0 : ∀ n, (0 : G F) ∈ O n := fun n =>
    Set.mem_iInter₂.mpr fun k _ => mem_interior_iff_mem_nhds.mpr (hWn k)
  have hOsub : ∀ n, O n ⊆ W n := fun n x hx =>
    interior_subset (Set.mem_iInter₂.mp hx n (Finset.self_mem_range_succ n))
  have hOanti : ∀ n, O (n + 1) ⊆ O n := fun n x hx =>
    Set.mem_iInter₂.mpr fun k hk => Set.mem_iInter₂.mp hx k
      (Finset.mem_range.mpr (by have := Finset.mem_range.mp hk; omega))
  -- the approximants: the first element of `R` whose image lies in `g + O n`
  have hex : ∀ n (g : G F), ∃ j, ιG F (en j) - g ∈ O n := by
    intro n g
    have hopen : IsOpen {x : G F | x - g ∈ O n} := (hOopen n).preimage (continuous_sub_right g)
    obtain ⟨r, hr⟩ := (denseRange_ιG F).exists_mem_open hopen ⟨g, by simpa using hO0 n⟩
    obtain ⟨j, rfl⟩ := hen r
    exact ⟨j, hr⟩
  set π : ℕ → G F → unitRing F := fun n g => en (Nat.find (hex n g)) with hπ
  have hπmem : ∀ n g, ιG F (π n g) - g ∈ O n := fun n g => Nat.find_spec (hex n g)
  have hπm : ∀ n, Measurable (π n) := fun n =>
    Measurable.find (f := fun j _ => en j) (p := fun j g => ιG F (en j) - g ∈ O n) (fun _ => measurable_const)
      (fun j => ((hOopen n).preimage (continuous_const.sub continuous_id)).measurableSet) (hex n)
  have hev : Measurable (fun p : (unitRing F → Fin k) × unitRing F => p.1 p.2) :=
    measurable_from_prod_countable_left fun r => measurable_pi_apply r
  have hcm : ∀ n, Measurable (fun x : (unitRing F → Fin k) × G F => x.1 (π n x.2)) := fun n =>
    hev.comp (measurable_fst.prodMk ((hπm n).comp measurable_snd))
  -- the eventual value
  set stab : (unitRing F → Fin k) × G F → ℕ → Prop :=
    fun x N => ∀ n, N ≤ n → x.1 (π n x.2) = x.1 (π N x.2) with hstab
  have hstabm : ∀ N, MeasurableSet {x | stab x N} := fun N => by
    have : {x | stab x N} = ⋂ n, ⋂ (_ : N ≤ n), {x | x.1 (π n x.2) = x.1 (π N x.2)} := by
      ext x; simp [hstab]
    rw [this]
    exact MeasurableSet.iInter fun n => MeasurableSet.iInter fun _ => measurableSet_eq_fun (hcm n) (hcm N)
  set EC : Set ((unitRing F → Fin k) × G F) := {x | ∃ N, stab x N} with hEC
  have hECm : MeasurableSet EC := by
    have : EC = ⋃ N, {x | stab x N} := by ext; simp [hEC]
    rw [this]; exact MeasurableSet.iUnion hstabm
  have hp : ∀ x, ∃ N, stab x N ∨ x ∉ EC := fun x => by
    by_cases hx : x ∈ EC
    · obtain ⟨N, hN⟩ := hx; exact ⟨N, Or.inl hN⟩
    · exact ⟨0, Or.inr hx⟩
  have hpm : ∀ N, MeasurableSet {x | stab x N ∨ x ∉ EC} := fun N => (hstabm N).union hECm.compl
  set f : (unitRing F → Fin k) → G F → Fin k := fun c g => c (π (Nat.find (hp (c, g))) g) with hf
  have hfm : Measurable (Function.uncurry f) :=
    Measurable.find (f := fun n x => x.1 (π n x.2)) (p := fun N x => stab x N ∨ x ∉ EC) hcm hpm hp
  have hfval : ∀ x ∈ EC, ∀ n, Nat.find (hp x) ≤ n → x.1 (π n x.2) = f x.1 x.2 := by
    intro x hx n hn
    have hs : stab x (Nat.find (hp x)) := (Nat.find_spec (hp x)).resolve_right (not_not.mpr hx)
    exact hs n hn
  -- Borel–Cantelli: for each `g`, almost surely `c ∘ π · g` is eventually constant
  have hae : ∀ g, ∀ᵐ c ∂μ.μ, (c, g) ∈ EC := by
    intro g
    set s : ℕ → Set (unitRing F → Fin k) := fun n => {c | c (π n g) ≠ c (π (n + 1) g)} with hs
    have hsle : ∀ n, μ.μ (s n) ≤ (1 / 2) ^ n := by
      intro n
      rw [hs, measure_ne_shift_k]
      refine hWp n _ (hOsub n (hOanti n (hπmem (n + 1) g))) _ (hOsub n (hπmem n g)) 0 (hOsub n (hO0 n)) _ ?_
      rw [map_sub]
      abel
    have hsum : ∑' n, μ.μ (s n) ≠ ⊤ := by
      refine ne_top_of_le_ne_top ?_ (ENNReal.tsum_le_tsum hsle)
      rw [ENNReal.tsum_geometric]
      exact ENNReal.inv_ne_top.mpr (by norm_num)
    have hlim := measure_limsup_atTop_eq_zero hsum
    rw [measure_eq_zero_iff_ae_notMem] at hlim
    filter_upwards [hlim] with c hc
    have hevn : ∀ᶠ n in atTop, c (π n g) = c (π (n + 1) g) := by
      have h1 : ¬ ∃ᶠ n in atTop, c ∈ s n := fun h => hc (Filter.mem_limsup_iff_frequently_mem.mpr h)
      filter_upwards [Filter.not_frequently.mp h1] with n hn
      simpa [hs] using hn
    obtain ⟨N, hN⟩ := Filter.eventually_atTop.mp hevn
    refine ⟨N, fun n hn => ?_⟩
    induction n, hn using Nat.le_induction with
    | base => rfl
    | succ n hn ih => exact (hN n hn).symm.trans ih
  refine ⟨f, hfm, fun g t ht => ?_⟩
  -- the edge `t`: almost surely, from some `m` on, `c (π m g) = c (π m (g + t))`, an event of measure at most `2^{−m}`
  set C : ℕ → Set (unitRing F → Fin k) := fun m => {c | c (π m g) = c (π m (g + t))} with hC
  have hCle : ∀ m, μ.μ (C m) ≤ (1 / 2) ^ m := by
    intro m
    have hopen : IsOpen {x : G F | x - t ∈ O m} := (hOopen m).preimage (continuous_sub_right t)
    obtain ⟨_, hut, u, hu, rfl⟩ := mem_closure_iff.mp ht _ hopen (by simpa using hO0 m)
    set a := π m g
    set b := π m (g + t)
    have hsub : C m ⊆ {c | c a = c (a + u)} ∪ {c | c (a + u) ≠ c b} := by
      intro c hc
      by_cases h : c a = c (a + u)
      · exact Or.inl h
      · exact Or.inr fun h' => h (hc.trans h'.symm)
    refine (measure_mono hsub).trans ((measure_union_le _ _).trans ?_)
    rw [measure_eq_add_unit_k μ a hu, zero_add, measure_ne_shift_k]
    refine hWp m _ (hOsub m (hπmem m (g + t))) _ (hOsub m (hπmem m g)) _ (hOsub m hut) _ ?_
    rw [map_sub, map_add]
    abel
  have hnull : ∀ M, μ.μ (⋂ m, ⋂ (_ : M ≤ m), C m) = 0 := by
    intro M
    have h1 : ∀ m, M ≤ m → μ.μ (⋂ m, ⋂ (_ : M ≤ m), C m) ≤ (1 / 2) ^ m := fun m hm =>
      (measure_mono (Set.iInter₂_subset m hm)).trans (hCle m)
    have h2 : Tendsto (fun m : ℕ => (1 / 2 : ENNReal) ^ m) atTop (𝓝 0) :=
      ENNReal.tendsto_pow_atTop_nhds_zero_of_lt_one (by norm_num)
    exact le_antisymm (ge_of_tendsto h2 (eventually_atTop.mpr ⟨M, h1⟩)) zero_le
  have hbad : μ.μ ({c | (c, g) ∉ EC} ∪ {c | (c, g + t) ∉ EC}) = 0 := by
    refine measure_union_null ?_ ?_
    · exact measure_eq_zero_iff_ae_notMem.mpr ((hae g).mono fun c hc hn => hn hc)
    · exact measure_eq_zero_iff_ae_notMem.mpr ((hae (g + t)).mono fun c hc hn => hn hc)
  refine measure_mono_null (fun c hc => ?_) (measure_union_null hbad (measure_iUnion_null hnull))
  by_cases h1 : (c, g) ∈ EC
  · by_cases h2 : (c, g + t) ∈ EC
    · refine Or.inr (Set.mem_iUnion.mpr ⟨max (Nat.find (hp (c, g))) (Nat.find (hp (c, g + t))), ?_⟩)
      refine Set.mem_iInter₂.mpr fun m hm => ?_
      have e1 := hfval (c, g) h1 m (le_trans (le_max_left _ _) hm)
      have e2 := hfval (c, g + t) h2 m (le_trans (le_max_right _ _) hm)
      dsimp only at e1 e2
      show c (π m g) = c (π m (g + t))
      rw [e1, e2]
      exact hc
    · exact Or.inl (Or.inr h2)
  · exact Or.inl (Or.inl h1)

variable (F) in
/-- **The monochromatic edges of a slice `k`-colouring are null at every unit vector**: the edges
`(z, x) ~ (z + e^{iθ}, x + ιK u)` of `UD(ℝ²) ⊗ Cay(K, U)` (the four-colour `Rigidity.Counting.SliceEdgeNull` at `Fin k`). -/
def SliceEdgeNullK (φ : ℂ × K F → Fin k) : Prop :=
  ∀ u ∈ unitVectorsR F, ((volume.prod (haarK F)).prod arcLength) {p | φ p.1 = φ (p.1.1 + e p.2, p.1.2 + ιK F u)} = 0

/-- **The slice `Δ × K` at `k` colours**: some sample gives a measurable `k`-colouring of `ℂ × K` whose monochromatic edges
are null at every unit vector (Tonelli over the sample; `R` is countable). -/
theorem exists_slice_k (μ : InvColouring F k) {σ : Measure (Dual F)} (hσ : IsColourSpectral μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) : ∃ φ : ℂ × K F → Fin k, Measurable φ ∧ SliceEdgeNullK F φ := by
  classical
  haveI := μ.isProb
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  obtain ⟨f, hfm, hf⟩ := exists_extension_k μ hσ hTA
  have hDm : Measurable fun p : ℂ × K F => (Delta F p.1, p.2) :=
    ((Delta F).continuous_of_finiteDimensional.measurable.comp measurable_fst).prodMk measurable_snd
  -- for each unit vector, almost surely the slice edges are null (Tonelli over the sample)
  have hu : ∀ u ∈ unitVectorsR F, ∀ᵐ c ∂μ.μ, ((volume.prod (haarK F)).prod arcLength)
      {p : (ℂ × K F) × ℝ | f c (Delta F p.1.1, p.1.2) = f c (Delta F (p.1.1 + e p.2), p.1.2 + ιK F u)} = 0 := by
    intro u hu
    set S : Set ((unitRing F → Fin k) × ((ℂ × K F) × ℝ)) :=
      {x | f x.1 (Delta F x.2.1.1, x.2.1.2) = f x.1 (Delta F (x.2.1.1 + e x.2.2), x.2.1.2 + ιK F u)} with hS
    have hm1 : Measurable fun x : (unitRing F → Fin k) × ((ℂ × K F) × ℝ) => f x.1 (Delta F x.2.1.1, x.2.1.2) :=
      hfm.comp (measurable_fst.prodMk (hDm.comp (measurable_fst.comp measurable_snd)))
    have hm2 : Measurable fun x : (unitRing F → Fin k) × ((ℂ × K F) × ℝ) =>
        f x.1 (Delta F (x.2.1.1 + e x.2.2), x.2.1.2 + ιK F u) := by
      refine hfm.comp (measurable_fst.prodMk (hDm.comp (f := fun x : (unitRing F → Fin k) × ((ℂ × K F) × ℝ) =>
        ((x.2.1.1 + e x.2.2, x.2.1.2 + ιK F u) : ℂ × K F)) ?_))
      exact ((measurable_fst.comp (measurable_fst.comp measurable_snd)).add
        (continuous_e.measurable.comp (measurable_snd.comp measurable_snd))).prodMk
        ((measurable_snd.comp (measurable_fst.comp measurable_snd)).add_const _)
    have hSm : MeasurableSet S := measurableSet_eq_fun hm1 hm2
    have hfib : ∀ w : (ℂ × K F) × ℝ, μ.μ ((fun c => (c, w)) ⁻¹' S) = 0 := by
      intro w
      have ht := mem_closure_ιG F w.2 hu
      have hpre : (fun c => (c, w)) ⁻¹' S =
          {c | f c (Delta F w.1.1, w.1.2) =
            f c ((Delta F w.1.1, w.1.2) + (Delta F (Complex.exp (w.2 * Complex.I)), ιK F u))} := by
        ext c
        simp only [hS, Set.mem_preimage, Set.mem_setOf_eq, map_add, Prod.mk_add_mk]
        rfl
      rw [hpre]
      exact hf _ _ ht
    have hprod : (μ.μ.prod ((volume.prod (haarK F)).prod arcLength)) S = 0 := by
      rw [Measure.prod_apply_symm hSm]
      simp only [hfib, lintegral_zero]
    filter_upwards [(Measure.measure_prod_null hSm).mp hprod] with c hc
    exact hc
  -- countably many unit vectors: one sample serves them all
  have hall : ∀ᵐ c ∂μ.μ, ∀ u : unitVectorsR F, ((volume.prod (haarK F)).prod arcLength)
      {p : (ℂ × K F) × ℝ | f c (Delta F p.1.1, p.1.2) = f c (Delta F (p.1.1 + e p.2), p.1.2 + ιK F u)} = 0 :=
    ae_all_iff.mpr fun u => hu u u.2
  obtain ⟨c, hc⟩ := hall.exists
  exact ⟨fun p => f c (Delta F p.1, p.2), hfm.comp (measurable_const.prodMk hDm), fun u hu' => hc ⟨u, hu'⟩⟩

/-- **A proper `k`-colouring of `F²` gives a slice colouring** — L0, the dichotomy closed by MR⁺, and the extension. -/
theorem exists_slice_of_colorable (h : ((unitDistance ℂ).induce (planeOver F)).Colorable k) :
    ∃ φ : ℂ × K F → Fin k, Measurable φ ∧ SliceEdgeNullK F φ := by
  obtain ⟨μ⟩ := nonempty_invColouring_of_colorable h
  obtain ⟨μ', hμ'⟩ := exists_invColouring_TA μ
  obtain ⟨σ', hσ'⟩ := exists_isColourSpectral μ'
  exact exists_slice_k μ' hσ' (hμ' σ' hσ')

end

end HadwigerNelson.Collapse
