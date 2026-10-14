import Proofs.HadwigerNelson.Rigidity.CountResidue
import Mathlib.MeasureTheory.Measure.Haar.Basic
import Mathlib.Topology.Algebra.Group.Pointwise

/-!
# The count's completion: the stable profinite part `K`, its Haar measure, and the edges in the closure (FS-131, job FS131-K12A; module M12, block K; skeleton)

**Read aloud, against the derivation** (J28D § 3.2 C1–C3: `G_S := (L ⊗ ℝ) × ∏_{v stable} O_{L_v} × …`, "`R` embedded
diagonally", "dense", "`T_S` … is the closure of `U`"). The completion is built from residues only:

* `K F` — the closure in `∏_k Lev F k` (each level discrete and finite) of the diagonal image of `R`: a compact abelian group,
  the profinite part of `G_∅`. `ιK` is the diagonal map, `proj k` the level-`k` coordinate, `haarK` the Haar probability
  measure. No completion of a local field is named: what the count reads of `K` is its levels.
* `haarK_proj_preimage` — every level-`k` coset has measure `1/|level k image|`.
* `tendsto_haarK_bad` — **density along cosets**: for a measurable `Y ⊆ K`, the points of `Y` whose level-`k` coset `Y` fills
  to at most `1 − κ` have measure tending to `0` (approximation by clopen cylinders; Haar is regular). This replaces J28V's
  Vitali family on the non-doubling product: the count regularises in `ℂ` only (`Plane.densitySet_bandFree`).
* `G F := (L ⊗ ℝ) × K F`, `ιG` the diagonal map; `denseRange_ιG` (Mathlib's mixed space of `L` and module M9's
  `dense_mixedEmbedding_nsmul_unitRing`).
* `mem_closure_ιG` — **the edges**: `(Δ(e^{iθ}), ιK u) ∈ closure (ιG '' U)` for every `θ` and unit vector `u`. Route: the
  units of a finite ring have finite exponent `h`, so `w^h ≡ 1` at level `k` for every unit vector `w`;
  `Counting.mem_closure_pow` and `Counting.Delta_circle_mem_closure` give `w` with `e(u w^h) ≈ Δ(e^{iθ})`.

**Models.** `ιK 0 = 0`; the trivial colouring's level sets; `F = ℚ` has `level ℚ k` the stable primes of `ℚ(i)` of norm at
most `k`.
-/

namespace HadwigerNelson.Rigidity.Counting

open SpectralChain NumberField MeasureTheory Filter Topology

noncomputable section

variable (F : Subfield ℝ) [NumberField F]

instance (k : ℕ) : TopologicalSpace (Lev F k) := ⊥

instance (k : ℕ) : DiscreteTopology (Lev F k) := ⟨rfl⟩

instance (k : ℕ) : SecondCountableTopology (Lev F k) := DiscreteTopology.secondCountableTopology_of_countable

/-- The diagonal map of `R` into all levels. -/
def ιAll : unitRing F →+ ∀ k, Lev F k := AddMonoidHom.pi fun k => (levR F k).toAddMonoidHom

/-- **`K`**: the closure of the diagonal image of `R` in the product of the levels. -/
def Kgrp : AddSubgroup (∀ k, Lev F k) := (ιAll F).range.topologicalClosure

/-- The stable profinite part of the completion. -/
abbrev K := ↥(Kgrp F)

instance : CompactSpace (K F) := by
  haveI : ∀ k, CompactSpace (Lev F k) := fun k => Finite.compactSpace
  exact isCompact_iff_compactSpace.mp (AddSubgroup.isClosed_topologicalClosure _).isCompact

instance : SecondCountableTopology (K F) := TopologicalSpace.Subtype.secondCountableTopology _

instance : MeasurableSpace (K F) := borel (K F)

instance : BorelSpace (K F) := ⟨rfl⟩

/-- `R → K`. -/
def ιK : unitRing F →+ K F :=
  AddMonoidHom.codRestrict (ιAll F) (Kgrp F) fun r => (ιAll F).range.le_topologicalClosure ⟨r, rfl⟩

/-- The level-`k` coordinate of `K`. -/
def proj (k : ℕ) : K F →+ Lev F k := (Pi.evalAddMonoidHom (fun k => Lev F k) k).comp (Kgrp F).subtype

theorem proj_ιK (k : ℕ) (r : unitRing F) : proj F k (ιK F r) = levR F k r := rfl

theorem continuous_proj (k : ℕ) : Continuous (proj F k) :=
  (continuous_apply k).comp continuous_subtype_val

-- FS131-ICL2: a point of `K` lies in the closure of the diagonal image of `R`, and every set of a level is clopen.
private theorem mem_closure_range (x : K F) : (x : ∀ k, Lev F k) ∈ closure ((ιAll F).range : Set (∀ k, Lev F k)) := by
  rw [← AddSubgroup.topologicalClosure_coe]
  exact x.2

theorem range_proj (k : ℕ) : Set.range (proj F k) = Set.range (levR F k) := by
  ext a
  constructor
  · rintro ⟨x, rfl⟩
    have hcl : IsClosed {y : ∀ k, Lev F k | y k ∈ Set.range (levR F k)} :=
      (isClosed_discrete _).preimage (continuous_apply k)
    have hsub : ((ιAll F).range : Set (∀ k, Lev F k)) ⊆ {y | y k ∈ Set.range (levR F k)} := by
      rintro _ ⟨r, rfl⟩
      exact ⟨r, rfl⟩
    exact closure_minimal hsub hcl (mem_closure_range F x)
  · rintro ⟨r, rfl⟩
    exact ⟨ιK F r, rfl⟩

/-- A coarser level is read off a finer one on `K`. -/
theorem proj_eq_zero_of_le {k k' : ℕ} (hk : k' ≤ k) {x : K F} (hx : proj F k x = 0) : proj F k' x = 0 := by
  have hcl : IsClosed {y : ∀ k, Lev F k | y k = 0 → y k' = 0} :=
    (isClosed_discrete {p : Lev F k × Lev F k' | p.1 = 0 → p.2 = 0}).preimage
      ((continuous_apply k).prodMk (continuous_apply k'))
  have hsub : ((ιAll F).range : Set (∀ k, Lev F k)) ⊆ {y | y k = 0 → y k' = 0} := by
    rintro _ ⟨r, rfl⟩ hr
    show levR F k' r = 0
    have hr' : levR F k r = 0 := hr
    refine funext fun P => ?_
    have hPk : P.1 ∈ level F k := (mem_level F).2 (le_trans ((mem_level F).1 P.2) hk)
    have h1 : (levR F k r : ∀ P : level F k, 𝓞 (fieldI F) ⧸ P.1.P ^ k) ⟨P.1, hPk⟩ = resR P.1 k r := rfl
    have h0 : resR P.1 k r = 0 := by rw [← h1, hr']; rfl
    exact resR_eq_zero_of_le P.1 hk h0
  exact closure_minimal hsub hcl (mem_closure_range F x) hx

/-- **The level kernels are a basis of the neighbourhoods of `0` in `K`.** -/
theorem hasBasis_nhds_zero_K : (𝓝 (0 : K F)).HasBasis (fun _ : ℕ => True) (fun k => {x | proj F k x = 0}) := by
  refine Filter.hasBasis_iff.2 fun t => ⟨fun ht => ?_, ?_⟩
  · obtain ⟨u, hu, hut⟩ := (mem_nhds_subtype _ _ _).1 ht
    rw [nhds_pi, Filter.mem_pi] at hu
    obtain ⟨I, hI, t', ht', hIu⟩ := hu
    obtain ⟨k, hk⟩ := hI.bddAbove
    refine ⟨k, trivial, fun x hx => hut ?_⟩
    apply hIu
    intro i hi
    have h0 : proj F i x = 0 := proj_eq_zero_of_le F (hk hi) hx
    have hmem : (0 : Lev F i) ∈ t' i := mem_of_mem_nhds (ht' i)
    have hxi : (x : ∀ k, Lev F k) i = 0 := h0
    rw [hxi]
    exact hmem
  · rintro ⟨k, -, hk⟩
    refine Filter.mem_of_superset ?_ hk
    refine ((isOpen_discrete {(0 : Lev F k)}).preimage (continuous_proj F k)).mem_nhds ?_
    show proj F k 0 = 0
    exact map_zero _

/-- **The Haar probability measure of `K`.** -/
def haarK : Measure (K F) := Measure.addHaarMeasure ⊤

instance : IsProbabilityMeasure (haarK F) := by
  constructor
  have h := Measure.addHaarMeasure_self (G := K F) (K₀ := ⊤)
  simpa [haarK] using h

instance : (haarK F).IsAddLeftInvariant := by
  unfold haarK
  infer_instance

theorem haarK_proj_preimage (k : ℕ) {a : Lev F k} (ha : a ∈ Set.range (proj F k)) :
    haarK F (proj F k ⁻¹' {a}) = (Nat.card (Set.range (proj F k)) : ENNReal)⁻¹ := by
  -- Route: the level-`k` cosets are translates of one another, finitely many, and cover `K`.
  classical
  obtain ⟨x₀, rfl⟩ := ha
  have hmeas : ∀ b, MeasurableSet (proj F k ⁻¹' {b}) := fun b =>
    ((isOpen_discrete {b}).preimage (continuous_proj F k)).measurableSet
  have heq : ∀ b ∈ Set.range (proj F k), haarK F (proj F k ⁻¹' {b}) = haarK F (proj F k ⁻¹' {proj F k x₀}) := by
    rintro _ ⟨y, rfl⟩
    have e : proj F k ⁻¹' {proj F k y} = (fun x => (x₀ - y) + x) ⁻¹' (proj F k ⁻¹' {proj F k x₀}) := by
      ext x
      simp only [Set.mem_preimage, Set.mem_singleton_iff, map_add, map_sub]
      constructor
      · intro h
        rw [h]
        abel
      · intro h
        have := congrArg (· - (proj F k x₀ - proj F k y)) h
        simp only [add_sub_cancel_left] at this
        rw [this]
        abel
    rw [e, measure_preimage_add]
  have hfin : (Set.range (proj F k)).Finite := Set.toFinite _
  have hunion : (Set.univ : Set (K F)) = ⋃ b ∈ hfin.toFinset, proj F k ⁻¹' {b} := by
    ext x
    simp only [Set.mem_univ, Set.mem_iUnion, Set.Finite.mem_toFinset, Set.mem_preimage, Set.mem_singleton_iff,
      true_iff]
    exact ⟨proj F k x, ⟨x, rfl⟩, rfl⟩
  have hdisj : (↑hfin.toFinset : Set (Lev F k)).PairwiseDisjoint fun b => proj F k ⁻¹' {b} :=
    fun b _ b' _ hbb' => Set.disjoint_left.2 fun x hb hb' => hbb' ((Set.mem_singleton_iff.1 hb).symm.trans hb')
  have hsum := measure_biUnion_finset (μ := haarK F) hdisj fun b _ => hmeas b
  rw [← hunion, measure_univ, Finset.sum_congr rfl fun b hb => heq b (hfin.mem_toFinset.1 hb), Finset.sum_const,
    nsmul_eq_mul] at hsum
  have hcard : (hfin.toFinset.card : ENNReal) = (Nat.card (Set.range (proj F k)) : ENNReal) := by
    haveI := Fintype.ofFinite (Set.range (proj F k))
    rw [Set.Finite.card_toFinset, Nat.card_eq_fintype_card]
  rw [hcard] at hsum
  exact ENNReal.eq_inv_of_mul_eq_one_left (by rw [mul_comm]; exact hsum.symm)

/-- **Density along cosets.** -/
theorem tendsto_haarK_bad {Y : Set (K F)} (hY : MeasurableSet Y) {κ : ENNReal} (hκ : 0 < κ) :
    Tendsto (fun k => haarK F {x | x ∈ Y ∧
      haarK F (Y ∩ proj F k ⁻¹' {proj F k x}) ≤ (1 - κ) * haarK F (proj F k ⁻¹' {proj F k x})}) atTop (𝓝 0) := by
  sorry

/-- **The completion `G_∅ = (L ⊗ ℝ) × K`.** -/
abbrev G := NumberField.mixedEmbedding.mixedSpace (fieldI F) × K F

/-- `R → G_∅`, diagonally: the canonical embedding of `L` and `ιK`. -/
def ιG : unitRing F →+ G F :=
  AddMonoidHom.prod ((NumberField.mixedEmbedding (fieldI F)).toAddMonoidHom.comp (ofUnitRing F).toAddMonoidHom) (ιK F)

-- FS131-ICL2: a neighbourhood of a point `κ` of `K` holds the level-`k` coset of `κ` for some `k`.
private theorem exists_coset_subset {κ : K F} {t : Set (K F)} (ht : t ∈ 𝓝 κ) :
    ∃ k : ℕ, ∀ x : K F, proj F k (x - κ) = 0 → x ∈ t := by
  have h2 : (fun x => x + κ) ⁻¹' t ∈ 𝓝 (0 : K F) := by
    have hc := (continuous_add_const κ).continuousAt (x := (0 : K F))
    rw [ContinuousAt, zero_add] at hc
    exact hc ht
  obtain ⟨k, -, hk⟩ := (hasBasis_nhds_zero_K F).mem_iff.1 h2
  refine ⟨k, fun x hx => ?_⟩
  have := hk hx
  simpa using this

theorem denseRange_ιG : DenseRange (ιG F) := by
  -- Route: a neighbourhood of `(v, κ)` holds `t₁ × (the level-k coset of κ)`; `r₀` with `proj k (ιK r₀) = proj k κ`
  -- (`range_proj`), then `r = r₀ + M s` with `M = |Lev F k|`, which kills every level-`k` residue, and `e(M s)` near
  -- `v − e(r₀)` (`dense_mixedEmbedding_nsmul_unitRing`).
  intro p
  rw [mem_closure_iff_nhds]
  intro t ht
  rw [nhds_prod_eq, Filter.mem_prod_iff] at ht
  obtain ⟨t₁, ht₁, t₂, ht₂, ht⟩ := ht
  obtain ⟨k, hk⟩ := exists_coset_subset F ht₂
  obtain ⟨r₀, hr₀⟩ : proj F k p.2 ∈ Set.range (levR F k) := by
    rw [← range_proj F k]
    exact ⟨p.2, rfl⟩
  set M := Nat.card (Lev F k) with hM
  have hM0 : M ≠ 0 := Nat.card_pos.ne'
  set c₀ := NumberField.mixedEmbedding (fieldI F) (ofUnitRing F r₀) with hc₀
  have h1 : (fun y => c₀ + y) ⁻¹' t₁ ∈ 𝓝 (p.1 - c₀) := by
    have hc := (continuous_const_add c₀).continuousAt (x := p.1 - c₀)
    rw [ContinuousAt, add_sub_cancel] at hc
    exact hc ht₁
  obtain ⟨_, hy1, ⟨r, hr, rfl⟩⟩ :=
    mem_closure_iff_nhds.1 (dense_mixedEmbedding_nsmul_unitRing F M hM0 (p.1 - c₀)) _ h1
  set s : unitRing F := ⟨(r : ℂ), (UnitRing.coe_mem_unitRingOver_iff r).2 hr⟩ with hs
  refine ⟨ιG F (r₀ + M • s), ht ⟨?_, ?_⟩, ⟨r₀ + M • s, rfl⟩⟩
  · show NumberField.mixedEmbedding (fieldI F) (ofUnitRing F (r₀ + M • s)) ∈ t₁
    rw [map_add (ofUnitRing F), map_nsmul (ofUnitRing F), nsmul_eq_mul, map_add]
    exact hy1
  · show ιK F (r₀ + M • s) ∈ t₂
    refine hk _ ?_
    rw [map_sub, map_add, map_nsmul, map_add, map_nsmul, proj_ιK, proj_ιK, hr₀, card_nsmul_eq_zero', add_zero,
      sub_self]

/-- The unit vectors of `F²`, as elements of `R`. -/
def unitVectorsR : Set (unitRing F) := {r | (r : ℂ) ∈ unitVectors F}

/-- **The edges of the slices lie in the closure of `U`.** -/
theorem mem_closure_ιG (θ : ℝ) {u : unitRing F} (hu : u ∈ unitVectorsR F) :
    (Delta F (Complex.exp (θ * Complex.I)), ιK F u) ∈ closure (ιG F '' unitVectorsR F) := by
  -- Route: at level `k`, `h` the exponent of the units of `Lev F k`: `levR k (w^h) = 1` for a unit vector `w`, so `u w^h`
  -- has the residues of `u`; and `e(u) e(w)^h` comes near `Δ(e^{iθ})` (`Delta_circle_mul_mem_closure_pow` at `ū`).
  rw [mem_closure_iff_nhds]
  intro t ht
  rw [nhds_prod_eq, Filter.mem_prod_iff] at ht
  obtain ⟨t₁, ht₁, t₂, ht₂, ht⟩ := ht
  obtain ⟨k, hk⟩ := exists_coset_subset F ht₂
  set h := Monoid.exponent (Lev F k)ˣ with hhdef
  have hh : 1 ≤ h := Nat.one_le_iff_ne_zero.2 Monoid.exponent_ne_zero_of_finite
  set uL := ofUnitRing F u with huLdef
  have huL : uL ∈ normOneL F := (mem_normOneL_iff F).2 hu
  have hconjmem : ∀ x ∈ normOneL F, conjOn (fieldI_conj F) x ∈ normOneL F := fun x hx => by
    show conjOn (fieldI_conj F) x * conjOn (fieldI_conj F) (conjOn (fieldI_conj F) x) = 1
    rw [conjOn_conjOn, mul_comm]
    exact hx
  have hc := Delta_circle_mul_mem_closure_pow F θ (hconjmem uL huL) hh
  have hprod : NumberField.mixedEmbedding (fieldI F) uL *
      (Delta F (Complex.exp (θ * Complex.I)) * NumberField.mixedEmbedding (fieldI F) (conjOn (fieldI_conj F) uL)) =
        Delta F (Complex.exp (θ * Complex.I)) := by
    rw [mul_left_comm, ← map_mul, show uL * conjOn (fieldI_conj F) uL = 1 from huL, map_one, mul_one]
  have h1 : (fun y => NumberField.mixedEmbedding (fieldI F) uL * y) ⁻¹' t₁ ∈
      𝓝 (Delta F (Complex.exp (θ * Complex.I)) * NumberField.mixedEmbedding (fieldI F) (conjOn (fieldI_conj F) uL)) := by
    have hcm := (continuous_const_mul (NumberField.mixedEmbedding (fieldI F) uL)).continuousAt
      (x := Delta F (Complex.exp (θ * Complex.I)) * NumberField.mixedEmbedding (fieldI F) (conjOn (fieldI_conj F) uL))
    rw [ContinuousAt, hprod] at hcm
    exact hcm ht₁
  obtain ⟨_, hy1, ⟨_, ⟨v, hv, rfl⟩, rfl⟩⟩ := mem_closure_iff_nhds.1 hc _ h1
  obtain ⟨rv, hrv, -⟩ := exists_unitRing_of_normOneL hv
  obtain ⟨rv', hrv', -⟩ := exists_unitRing_of_normOneL (hconjmem v hv)
  have hinj : ∀ a b : unitRing F, ofUnitRing F a = ofUnitRing F b → a = b := fun a b hab =>
    Subtype.ext (show (a : ℂ) = (b : ℂ) from congrArg (fun z : fieldI F => (z : ℂ)) hab)
  have hrvu : rv * rv' = 1 := hinj _ _ (by rw [map_mul, hrv, hrv', map_one]; exact hv)
  have hunit : IsUnit (levR F k rv) := IsUnit.of_mul_eq_one (levR F k rv') (by rw [← map_mul, hrvu, map_one])
  have hpow1 : levR F k rv ^ h = 1 := by
    have := Monoid.pow_exponent_eq_one hunit.unit
    rw [← hhdef] at this
    have := congrArg Units.val this
    simpa using this
  have hw : ofUnitRing F (u * rv ^ h) ∈ normOneL F := by
    rw [map_mul, map_pow, hrv]
    exact mul_mem_normOneL F huL (pow_mem_normOneL F hv h)
  refine ⟨ιG F (u * rv ^ h), ht ⟨?_, ?_⟩, ⟨u * rv ^ h, (mem_normOneL_iff F).1 hw, rfl⟩⟩
  · show NumberField.mixedEmbedding (fieldI F) (ofUnitRing F (u * rv ^ h)) ∈ t₁
    rw [map_mul (ofUnitRing F), map_pow (ofUnitRing F), hrv, map_mul]
    exact hy1
  · show ιK F (u * rv ^ h) ∈ t₂
    refine hk _ ?_
    rw [map_sub, proj_ιK, proj_ιK, map_mul, map_pow, hpow1, mul_one, sub_self]

/-! ## Spec examples -/

example (k : ℕ) : proj F k (ιK F 0) = 0 := by
  rw [proj_ιK, map_zero]

end

end HadwigerNelson.Rigidity.Counting
