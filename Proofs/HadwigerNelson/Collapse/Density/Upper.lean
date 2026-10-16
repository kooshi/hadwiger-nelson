import Proofs.HadwigerNelson.Collapse.Density.Defs

/-!
# The density form of the collapse: the upper half, one class at a time (FS-131, jobs FS131-KFR1 and FS131-IFR1; module D2)

**Read aloud, against the informal claim** (FS103-F-FRAC, steps 1–7 and 9, `plans/FS103-F-fractional-shadow.md` § 2.3;
FS103-B § 2.1 D1–D8): "every `R ⋊ U`-invariant random independent set `I` of `Cay(R, U)` has `P(0 ∈ I) ≤ ρ(F)`", here
with MR proved (`Rigidity.mrPlus`, read through `Collapse.not_isSPWitness`) and at every real number field.

* **The Følner step** (FRAC 1, B-AMEN): `exists_indepLaw` — a law of density at least `α₁(Cay(R, U))`; and the averaging
  bound `IndepLaw.density_le_finIndepRatio`, the other way.
* **The dichotomy, one class** (FRAC 2–5): the indicator's spectral measure (`IsIndicatorSpectral`), SI-3 at `T + A`
  (`setIntegral_compl_TA_re_one`), MR⁺ (`integral_condOne_mul_eq_zero`), and the support set `{x : P(x ∈ I | 𝒜) > 0}`
  (`exists_indepLaw_TA`: a denser law with spectrum on `T + A`).
* **The extension and the slice, one class** (FRAC 6): `exists_extension_one`, `exists_slice_set`.
* **The count, one class** (FRAC 7): `exists_window_bound`, over the held descent (`Counting.volume_colour_le`,
  `tendsto_bad` at the indicator of the set, `PlaneZhang.sum_volume_inter_sq_le`, `FiniteZhang.ratioLe_pi`).
* `IndepLaw.density_le_localRatio` — **the per-law bound**, `P(0 ∈ I) ≤ α_loc(F)`.

**Route.** Each statement is the one-class namesake of a held colouring statement (`Collapse/Dichotomy`, `Collapse/Slice`,
`Rigidity/CountDescent`); the colouring's sums over colours drop out, and properness is replaced by the one event
`c x = true ∧ c (x + u) = true`. Plan per leaf: `plans/FS131-KFR1-density-plan.md` § 3.3.

**Models.** `IndepLaw F` at density `0` (`nonempty_indepLaw`) satisfies every hypothesis here; a law of positive density with
spectrum on `T + A` is the residue law over `ℚ` (the random translate of the residue two-colouring's class `{b = 1}` at the
ramified prime above `2`, `Rigidity.exists_invariantColouring_rat`'s bit): torsion spectrum, density `1/2`.
-/

namespace HadwigerNelson.Collapse

open SpectralChain SpectralInputs MeasureTheory NumberField Rigidity Rigidity.Counting Filter Topology Plane
open scoped ENNReal

noncomputable section

variable {F : Subfield ℝ}

variable (F) in
/-- **`Cay(R, U)`**: the unit-distance graph on `R = ℤ[U_F]`. -/
def cayR : SimpleGraph (unitRing F) := SimpleGraph.fromRel fun x y => (y : ℂ) - x ∈ unitVectors F

example (x y : unitRing F) : (cayR F).Adj x y ↔ x ≠ y ∧ ((y : ℂ) - x ∈ unitVectors F ∨ (x : ℂ) - y ∈ unitVectors F) :=
  Iff.rfl

/-- **The shift of an indicator** by `y ∈ R`: `c ↦ c(· + y)`. -/
def indShift (y : unitRing F) (c : unitRing F → Bool) : unitRing F → Bool := fun x => c (x + y)

theorem IndepLaw.measurePreserving_shift (μ : IndepLaw F) (y : unitRing F) :
    MeasurePreserving (indShift y) μ.μ μ.μ :=
  ⟨measurable_pi_lambda _ fun _ => measurable_pi_apply _, μ.shift_inv y⟩

/-! ### Helpers (FS131-IFR1): the shifts and rotations of an indicator, and membership in `IndepSets F` -/

private theorem measurable_indShift (y : unitRing F) : Measurable (indShift (F := F) y) :=
  measurable_pi_lambda _ fun _ => measurable_pi_apply _

private theorem continuous_indShift (y : unitRing F) : Continuous (indShift (F := F) y) :=
  continuous_pi fun x => continuous_apply (x + y)

-- the shifts are an action of `R` fixing `0`
private theorem indShift_add (x y : unitRing F) : indShift (F := F) (x + y) = indShift x ∘ indShift y := by
  funext c z
  simp only [indShift, Function.comp_apply, add_assoc]

private theorem indShift_zero : indShift (F := F) 0 = id := by
  funext c x
  simp [indShift]

/-- The rotation of an indicator by a unit vector: `c ↦ c(u ·)`. -/
private def indRot (u : unitVectors F) (c : unitRing F → Bool) : unitRing F → Bool := fun x => c (uvRing u * x)

private theorem measurable_indRot (u : unitVectors F) : Measurable (indRot (F := F) u) :=
  measurable_pi_lambda _ fun _ => measurable_pi_apply _

private theorem continuous_indRot (u : unitVectors F) : Continuous (indRot (F := F) u) :=
  continuous_pi fun x => continuous_apply (uvRing u * x)

private theorem IndepLaw.measurePreserving_rot (μ : IndepLaw F) (u : unitVectors F) :
    MeasurePreserving (indRot u) μ.μ μ.μ :=
  ⟨measurable_indRot u, μ.rot_inv u⟩

attribute [local instance] IndepLaw.isProb

/-- `Cay(R, U)` is the unit-distance graph on `R`. -/
private theorem cayR_adj_iff (x y : unitRing F) : (cayR F).Adj x y ↔ dist (x : ℂ) (y : ℂ) = 1 := by
  have hsub : ∀ z : unitRing F, (z : ℂ) ∈ planeOver F := fun z => UnitRing.unitRingOver_le_planeOverSubring F z.2
  constructor
  · intro h
    rcases ((SimpleGraph.fromRel_adj _ _ _).1 h).2 with h | h
    · rw [dist_comm, Complex.dist_eq]; exact h.2
    · rw [Complex.dist_eq]; exact h.2
  · intro h
    refine (SimpleGraph.fromRel_adj _ _ _).2 ⟨fun hxy => by rw [hxy, dist_self] at h; exact zero_ne_one h, Or.inl ?_⟩
    refine ⟨(Chain.planeOverSubring F).sub_mem (hsub y) (hsub x), ?_⟩
    rw [← Complex.dist_eq, dist_comm]; exact h

-- an independent set of `Cay(R, U)` (a finset) is a point of `IndepSets F`
private theorem decide_mem_indepSets {J : Finset (unitRing F)} (hJ : (cayR F).IsIndepSet (J : Set (unitRing F))) :
    (fun x => decide (x ∈ J)) ∈ IndepSets F := by
  intro x y hxy hc
  simp only [decide_eq_true_eq] at hc
  have hne : x ≠ y := by
    rintro rfl
    simp [unitVectors] at hxy
  exact hJ hc.1 hc.2 hne ((SimpleGraph.fromRel_adj _ _ _).2 ⟨hne, Or.inl hxy⟩)

-- the shifts and the rotations keep `IndepSets F`
private theorem indShift_mem (y : unitRing F) {c : unitRing F → Bool} (hc : c ∈ IndepSets F) :
    indShift y c ∈ IndepSets F :=
  fun x' y' h => hc (x' + y) (y' + y) (by
    have e : ((y' + y : unitRing F) : ℂ) - ((x' + y : unitRing F) : ℂ) = (y' : ℂ) - x' := by push_cast; ring
    rw [e]; exact h)

private theorem indRot_mem (u : unitVectors F) {c : unitRing F → Bool} (hc : c ∈ IndepSets F) :
    indRot u c ∈ IndepSets F :=
  fun x' y' h => hc (uvRing u * x') (uvRing u * y') (by
    have e : ((uvRing u * y' : unitRing F) : ℂ) - ((uvRing u * x' : unitRing F) : ℂ) = (u : ℂ) * ((y' : ℂ) - x') := by
      push_cast; simp only [uvRing]; ring
    rw [e]
    exact ⟨(Chain.planeOverSubring F).mul_mem u.2.1 h.1, by rw [norm_mul, u.2.2, h.2, one_mul]⟩)

-- the event `x ∈ I` is measurable (stated through the preimage, which `measurable_pi_apply` elaborates against)
private theorem measurableSet_apply_true (x : unitRing F) : MeasurableSet {c : unitRing F → Bool | c x = true} :=
  show MeasurableSet ((fun c : unitRing F → Bool => c x) ⁻¹' {true}) from
    measurable_pi_apply x (measurableSet_singleton true)

-- the event `x, y ∈ I` is measurable
private theorem measurableSet_both (x y : unitRing F) :
    MeasurableSet {c : unitRing F → Bool | c x = true ∧ c y = true} :=
  (measurableSet_apply_true x).inter (measurableSet_apply_true y)

-- the event `0 ∈ I` is clopen
private theorem isClopen_origin : IsClopen {c : unitRing F → Bool | c 0 = true} :=
  (isClopen_discrete {true}).preimage (continuous_apply (0 : unitRing F))

/-! ## Følner and averaging -/

/-- `Cay(R, U)` is an induced subgraph of `F²`, so `α₁(F²) ≤ α₁(Cay(R, U))` (`finIndepRatio_le_of_embedding`). -/
theorem finIndepRatio_planeOver_le_cayR :
    ((unitDistance ℂ).induce (planeOver F)).finIndepRatio ≤ (cayR F).finIndepRatio := by
  have hsub : ∀ z : unitRing F, (z : ℂ) ∈ planeOver F := fun z => UnitRing.unitRingOver_le_planeOverSubring F z.2
  let f : cayR F ↪g (unitDistance ℂ).induce (planeOver F) :=
    { toFun := fun x => ⟨x, hsub x⟩
      inj' := fun x y h => Subtype.ext (congrArg (fun z : planeOver F => (z : ℂ)) h)
      map_rel_iff' := fun {x y} => by
        show dist (x : ℂ) (y : ℂ) = 1 ↔ (cayR F).Adj x y
        exact (cayR_adj_iff x y).symm }
  exact SimpleGraph.finIndepRatio_le_of_embedding f

-- `OneClass/InvariantLaw`'s private helpers, copied (FS131-IFR1): a translate of a finite set moves a bounded sum by at
-- most twice the bound times the points translated out; the measure of a clopen set is continuous along a weak limit.
private theorem abs_sum_add_sub_sum_le' {A : Type*} [AddCommGroup A] (S : Finset A) (z : A) (h : A → ℝ) {M : ℝ}
    (hM : ∀ a, |h a| ≤ M) :
    |∑ r ∈ S, h (r + z) - ∑ r ∈ S, h r| ≤ 2 * M * ({a | a ∈ S ∧ a + z ∉ S}.ncard : ℝ) := by
  classical
  set S' : Finset A := S.map (addRightEmbedding z) with hS'
  have hsum : ∑ r ∈ S, h (r + z) = ∑ s ∈ S', h s := by
    rw [hS', Finset.sum_map]; rfl
  have hcard : S'.card = S.card := Finset.card_map _
  have hout : (S' \ S).card = {a | a ∈ S ∧ a + z ∉ S}.ncard := by
    have h1 : S' \ S = (S.filter fun a => a + z ∉ S).map (addRightEmbedding z) := by
      ext s
      simp only [hS', Finset.mem_sdiff, Finset.mem_map, Finset.mem_filter, addRightEmbedding_apply]
      constructor
      · rintro ⟨⟨a, ha, rfl⟩, hs⟩
        exact ⟨a, ⟨ha, hs⟩, rfl⟩
      · rintro ⟨a, ⟨ha, hs⟩, rfl⟩
        exact ⟨⟨a, ha, rfl⟩, hs⟩
    have h2 : {a | a ∈ S ∧ a + z ∉ S} = ((S.filter fun a => a + z ∉ S : Finset A) : Set A) := by
      ext a; simp
    rw [h1, Finset.card_map, h2, Set.ncard_coe_finset]
  have hbd : ∀ T : Finset A, |∑ s ∈ T, h s| ≤ T.card * M := fun T =>
    (Finset.abs_sum_le_sum_abs _ _).trans <| by
      simpa [nsmul_eq_mul] using Finset.sum_le_card_nsmul T (fun s => |h s|) M fun s _ => hM s
  rw [hsum, ← Finset.sum_sdiff_sub_sum_sdiff]
  have h3 := hbd (S' \ S)
  have h4 := hbd (S \ S')
  rw [Finset.card_sdiff_comm hcard.symm, hout] at h4
  rw [hout] at h3
  have h5 := abs_sub (∑ s ∈ S' \ S, h s) (∑ s ∈ S \ S', h s)
  linarith

private theorem tendsto_measure_of_isClopen' {X : Type*} [TopologicalSpace X] [MeasurableSpace X] [BorelSpace X]
    [HasOuterApproxClosed X] {ι : Type*} {L : Filter ι} {ν : ι → ProbabilityMeasure X}
    {Q : ProbabilityMeasure X} (hν : Tendsto ν L (𝓝 Q)) {Z : Set X} (hZ : IsClopen Z) :
    Tendsto (fun i => (ν i : Measure X) Z) L (𝓝 ((Q : Measure X) Z)) :=
  ProbabilityMeasure.tendsto_measure_of_null_frontier_of_tendsto' hν (by rw [hZ.frontier_eq]; exact measure_empty)

-- FS131-IFR1: **step 1, Følner averages** (`OneClass.exists_shiftInvariant_of_foelner` on `R`, labels `Bool`): a
-- shift-invariant probability carried by `IndepSets F` whose density is at least `α₁(Cay(R, U))`.
private theorem exists_shiftInvariant_indep [Countable (unitRing F)] :
    ∃ Q : Measure (unitRing F → Bool), IsProbabilityMeasure Q ∧ Q (IndepSets F)ᶜ = 0 ∧
      (∀ y : unitRing F, Q.map (indShift y) = Q) ∧ (cayR F).finIndepRatio ≤ Q {c | c 0 = true} := by
  classical
  obtain ⟨Fs, hF, hFz⟩ := OneClass.exists_foelner_finset (unitRing F)
  set α := (cayR F).finIndepRatio with hα
  have hJ : ∀ n, ∃ J : Finset (unitRing F), J ⊆ Fs n ∧ (cayR F).IsIndepSet (J : Set (unitRing F)) ∧
      α * (Fs n).card ≤ J.card := fun n => ((cayR F).le_finIndepRatio_iff.1 le_rfl) (Fs n) (hF n)
  choose J hJF hJi hJc using hJ
  set ℓ : ℕ → unitRing F → Bool := fun n x => decide (x ∈ J n) with hℓ
  have hℓC : ∀ n, ℓ n ∈ IndepSets F := fun n => decide_mem_indepSets (hJi n)
  set μn : ℕ → Measure (unitRing F → Bool) :=
    fun n => OneClass.avgMeasure (Fs n) fun r => Measure.dirac (indShift r (ℓ n)) with hμn
  have hprob : ∀ n, IsProbabilityMeasure (μn n) := fun n =>
    OneClass.isProbabilityMeasure_avgMeasure (hF n) fun r _ => Measure.dirac.isProbabilityMeasure
  set ν : ℕ → ProbabilityMeasure (unitRing F → Bool) := fun n => ⟨μn n, hprob n⟩ with hν
  obtain ⟨Q, -, hQ⟩ := isCompact_univ.ultrafilter_le_nhds ((Ultrafilter.of atTop).map ν) (by simp)
  have hlim : Tendsto ν ((Ultrafilter.of atTop : Ultrafilter ℕ) : Filter ℕ) (𝓝 Q) := hQ
  have hint : ∀ (n : ℕ) (f : BoundedContinuousFunction (unitRing F → Bool) ℝ) (g : (unitRing F → Bool) → unitRing F → Bool),
      ∫ y, f (g y) ∂(ν n : Measure (unitRing F → Bool)) =
        ((Fs n).card : ℝ)⁻¹ * ∑ r ∈ Fs n, f (g (indShift r (ℓ n))) := by
    intro n f g
    have := OneClass.integral_avgMeasure (Fs n) (μ := fun r => Measure.dirac (indShift r (ℓ n)))
      (f := fun y => f (g y)) fun r _ => integrable_dirac (by simp)
    show ∫ y, f (g y) ∂OneClass.avgMeasure (Fs n) (fun r => Measure.dirac (indShift r (ℓ n))) = _
    simpa using this
  refine ⟨Q, inferInstance, ?_, fun z => ?_, ?_⟩
  · -- carried by `IndepSets F`
    refine OneClass.measure_compl_eq_zero_of_tendsto hlim isClosed_indepSets (Eventually.of_forall fun n => ?_)
    show OneClass.avgMeasure (Fs n) (fun r => Measure.dirac (indShift r (ℓ n))) (IndepSets F)ᶜ = 0
    rw [OneClass.avgMeasure_apply, Finset.sum_eq_zero, mul_zero]
    intro r _
    rw [Measure.dirac_apply' _ measurableSet_indepSets.compl, Set.indicator_of_notMem]
    exact fun h => h (indShift_mem r (hℓC n))
  · -- invariant under the shift by `z`
    refine OneClass.map_eq_of_tendsto hlim (continuous_indShift z) fun f => ?_
    have hbound : ∀ n : ℕ,
        ‖∫ y, f (indShift z y) ∂(ν n : Measure (unitRing F → Bool)) -
            ∫ y, f y ∂(ν n : Measure (unitRing F → Bool))‖ ≤
          2 * ‖f‖ * (({a | a ∈ Fs n ∧ a + z ∉ Fs n}.ncard : ℝ) / (Fs n).card) := by
      intro n
      have e1 := hint n f (fun y => y)
      have e2 := hint n f (indShift z)
      have e3 : ∀ r : unitRing F, indShift z (indShift r (ℓ n)) = indShift (r + z) (ℓ n) := fun r => by
        funext x
        show ℓ n (x + z + r) = ℓ n (x + (r + z))
        rw [add_assoc, add_comm z r]
      simp only [e3] at e2
      rw [e1, e2, ← mul_sub, Real.norm_eq_abs, abs_mul,
        abs_of_nonneg (by positivity : (0 : ℝ) ≤ ((Fs n).card : ℝ)⁻¹)]
      have := abs_sum_add_sub_sum_le' (Fs n) z (fun r => f (indShift r (ℓ n))) (M := ‖f‖)
        fun a => f.norm_coe_le_norm _
      calc ((Fs n).card : ℝ)⁻¹ * |∑ r ∈ Fs n, f (indShift (r + z) (ℓ n)) - ∑ r ∈ Fs n, f (indShift r (ℓ n))|
          ≤ ((Fs n).card : ℝ)⁻¹ * (2 * ‖f‖ * ({a | a ∈ Fs n ∧ a + z ∉ Fs n}.ncard : ℝ)) :=
            mul_le_mul_of_nonneg_left this (by positivity)
        _ = 2 * ‖f‖ * (({a | a ∈ Fs n ∧ a + z ∉ Fs n}.ncard : ℝ) / (Fs n).card) := by ring
    have h0 : Tendsto (fun n : ℕ => 2 * ‖f‖ * (({a | a ∈ Fs n ∧ a + z ∉ Fs n}.ncard : ℝ) / (Fs n).card)) atTop
        (𝓝 0) := by
      simpa using (hFz z).const_mul (2 * ‖f‖)
    exact (squeeze_zero_norm hbound h0).mono_left (Ultrafilter.of_le atTop)
  · -- the density
    have hZm : MeasurableSet {c : unitRing F → Bool | c 0 = true} := isClopen_origin.isOpen.measurableSet
    have hsum : ∀ n, ∑ r ∈ Fs n, Measure.dirac (indShift r (ℓ n)) {c : unitRing F → Bool | c 0 = true} =
        ((J n).card : ℝ≥0∞) := by
      intro n
      rw [← Finset.inter_eq_right.2 (hJF n), ← Finset.filter_mem_eq_inter, Finset.card_filter, Nat.cast_sum]
      refine Finset.sum_congr rfl fun r _ => ?_
      rw [Measure.dirac_apply' _ hZm]
      by_cases h : r ∈ J n
      · rw [Set.indicator_of_mem (by simp [indShift, hℓ, h]), if_pos h]; simp
      · rw [Set.indicator_of_notMem (by simp [indShift, hℓ, h]), if_neg h]; simp
    refine ge_of_tendsto' (tendsto_measure_of_isClopen' hlim isClopen_origin) fun n => ?_
    show α ≤ OneClass.avgMeasure (Fs n) (fun r => Measure.dirac (indShift r (ℓ n))) {c | c 0 = true}
    have hc0 : ((Fs n).card : ℝ≥0∞) ≠ 0 := by simpa using (hF n).ne_empty
    rw [OneClass.avgMeasure_apply, hsum n, ← ENNReal.div_eq_inv_mul,
      ENNReal.le_div_iff_mul_le (Or.inl hc0) (Or.inl (ENNReal.natCast_ne_top _))]
    exact hJc n

-- FS131-IFR1: **step 2, the rotations** (`OneClass.exists_turnInvariant` on `R`, labels `Bool`): a shift-invariant
-- probability carried by `IndepSets F` has a sibling invariant under the rotations too, with the same density.
private theorem exists_rotInvariant_indep [Countable (unitRing F)] {Q₀ : Measure (unitRing F → Bool)}
    [IsProbabilityMeasure Q₀] (h0 : Q₀ (IndepSets F)ᶜ = 0) (hinv : ∀ y, Q₀.map (indShift y) = Q₀) :
    ∃ P : Measure (unitRing F → Bool), IsProbabilityMeasure P ∧ P (IndepSets F)ᶜ = 0 ∧
      (∀ y, P.map (indShift y) = P) ∧ (∀ u, P.map (indRot u) = P) ∧
      P {c | c 0 = true} = Q₀ {c | c 0 = true} := by
  classical
  have hZ : MeasurableSet {c : unitRing F → Bool | c 0 = true} := isClopen_origin.isOpen.measurableSet
  suffices h : ∃ Q : ProbabilityMeasure (unitRing F → Bool),
      ((Q : Measure (unitRing F → Bool)) (IndepSets F)ᶜ = 0 ∧
        (∀ y, (Q : Measure (unitRing F → Bool)).map (indShift y) = Q) ∧
        (Q : Measure (unitRing F → Bool)) {c | c 0 = true} = Q₀ {c | c 0 = true}) ∧
      ∀ u : unitVectors F, (Q : Measure (unitRing F → Bool)).map (indRot u) = Q by
    obtain ⟨Q, ⟨h1, h2, h3⟩, h4⟩ := h
    exact ⟨Q, inferInstance, h1, h2, h4, h3⟩
  refine OneClass.exists_common_fixed
    (p := fun μ : Measure (unitRing F → Bool) => μ (IndepSets F)ᶜ = 0 ∧ (∀ y, μ.map (indShift y) = μ) ∧
      μ {c | c 0 = true} = Q₀ {c | c 0 = true})
    (g := fun u : unitVectors F => indRot u) ?_ ⟨⟨Q₀, inferInstance⟩, h0, hinv, rfl⟩
    (continuous_indRot (F := F)) ?_ ?_ ?_
  · -- the class is closed
    refine OneClass.isClosed_setOf_of_tendsto (X := unitRing F → Bool)
      (p := fun μ : Measure (unitRing F → Bool) => μ (IndepSets F)ᶜ = 0 ∧ (∀ y, μ.map (indShift y) = μ) ∧
        μ {c | c 0 = true} = Q₀ {c | c 0 = true}) fun L hL Q hQ h => ?_
    haveI := hL
    refine ⟨OneClass.measure_compl_eq_zero_of_tendsto hQ isClosed_indepSets (h.mono fun P hP => hP.1), fun y =>
      OneClass.map_eq_of_tendsto_of_eventually hQ (continuous_indShift y) (h.mono fun P hP => hP.2.1 y), ?_⟩
    exact tendsto_nhds_unique (tendsto_measure_of_isClopen' hQ isClopen_origin)
      (tendsto_const_nhds.congr' (h.mono fun P hP => hP.2.2.symm))
  · -- the rotations commute
    intro u v
    funext c x
    show c (uvRing v * (uvRing u * x)) = c (uvRing u * (uvRing v * x))
    rw [mul_left_comm]
  · -- a rotation keeps the class
    rintro u μ hμ ⟨hμC, hμs, hμa⟩
    refine ⟨?_, fun y => ?_, ?_⟩
    · rw [Measure.map_apply (measurable_indRot u) measurableSet_indepSets.compl]
      exact measure_mono_null (fun c hc hcC => hc (indRot_mem u hcC)) hμC
    · have hcov : indShift y ∘ indRot u = indRot u ∘ indShift (uvRing u * y) := by
        funext c x
        show c (uvRing u * (x + y)) = c (uvRing u * x + uvRing u * y)
        rw [mul_add]
      rw [Measure.map_map (measurable_indShift y) (measurable_indRot u), hcov,
        ← Measure.map_map (measurable_indRot u) (measurable_indShift _), hμs]
    · rw [Measure.map_apply (measurable_indRot u) hZ, ← hμa]
      congr 1
      ext c
      show c (uvRing u * 0) = true ↔ c 0 = true
      rw [mul_zero]
  · -- an average keeps the class
    intro s hs μ hμ
    refine ⟨?_, fun y => ?_, ?_⟩
    · rw [OneClass.avgMeasure_apply, Finset.sum_eq_zero fun k hk => (hμ k hk).2.1, mul_zero]
    · rw [OneClass.avgMeasure_map _ _ (measurable_indShift y)]
      unfold OneClass.avgMeasure
      congr 1
      exact Finset.sum_congr rfl fun k hk => (hμ k hk).2.2.1 y
    · rw [OneClass.avgMeasure_apply, Finset.sum_congr rfl fun k hk => (hμ k hk).2.2.2, Finset.sum_const,
        nsmul_eq_mul, ← mul_assoc, ENNReal.inv_mul_cancel (by simpa using hs.ne_empty) (ENNReal.natCast_ne_top _),
        one_mul]

/-- **The Følner step** (FRAC 1; FS-133's C133-INV-CLASS on `R`): some invariant random independent set of `Cay(R, U)` has
density at least `α₁(Cay(R, U))`. -/
theorem exists_indepLaw [NumberField F] : ∃ μ : IndepLaw F, (cayR F).finIndepRatio ≤ μ.density := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  obtain ⟨Q₀, h₀, hK₀, hs₀, hd₀⟩ := exists_shiftInvariant_indep (F := F)
  obtain ⟨P, hp, hK, hs, hr, hd⟩ := exists_rotInvariant_indep hK₀ hs₀
  exact ⟨⟨P, hp, hK, hs, hr⟩, by rw [IndepLaw.density, hd]; exact hd₀⟩

/-- **The averaging bound** (B-AMEN's `α₁ ≥ α_inv`): a translation-invariant random independent set has density at most
`α₁(Cay(R, U))` (`OneClass.IsShiftInvariantLaw.measure_origin_le` on `R`). -/
theorem IndepLaw.density_le_finIndepRatio [NumberField F] (μ : IndepLaw F) : μ.density ≤ (cayR F).finIndepRatio := by
  classical
  have hT : ∀ g : unitRing F, MeasurableSet {I : unitRing F → Bool | I g = true} := fun g =>
    show MeasurableSet ((fun I : unitRing F → Bool => I g) ⁻¹' {true}) from
      measurable_pi_apply g (measurableSet_singleton true)
  have hshift : ∀ g : unitRing F, μ.μ {I | I g = true} = μ.μ {I | I 0 = true} := by
    intro g
    have h1 : μ.μ.map (indShift g) {I | I 0 = true} = μ.μ {I | I 0 = true} := by
      rw [(μ.measurePreserving_shift g).map_eq]
    rw [Measure.map_apply (measurable_indShift g) (hT 0)] at h1
    rw [← h1]
    congr 1
    ext I
    show I g = true ↔ I (0 + g) = true
    rw [zero_add]
  rw [SimpleGraph.le_finIndepRatio_iff]
  intro S _
  obtain ⟨J, hJmem, hJmax⟩ := Finset.exists_max_image
    (S.powerset.filter fun J : Finset (unitRing F) => (cayR F).IsIndepSet (J : Set (unitRing F)))
    Finset.card ⟨∅, Finset.mem_filter.2 ⟨Finset.empty_mem_powerset S, by simp⟩⟩
  obtain ⟨hJS, hJ⟩ := Finset.mem_filter.1 hJmem
  refine ⟨J, Finset.mem_powerset.1 hJS, hJ, ?_⟩
  calc μ.density * S.card = ∑ g ∈ S, μ.μ {I | I g = true} := by
        rw [Finset.sum_congr rfl fun g _ => hshift g, Finset.sum_const, nsmul_eq_mul, mul_comm]
        rfl
    _ = ∫⁻ I, ∑ g ∈ S, ({I : unitRing F → Bool | I g = true}.indicator 1 I : ℝ≥0∞) ∂μ.μ := by
        rw [lintegral_finsetSum _ fun g _ => measurable_one.indicator (hT g)]
        exact Finset.sum_congr rfl fun g _ => (lintegral_indicator_one (hT g)).symm
    _ ≤ ∫⁻ _, (J.card : ℝ≥0∞) ∂μ.μ := by
        refine lintegral_mono_ae ((measure_eq_zero_iff_ae_notMem.1 μ.carried).mono fun I hI => ?_)
        have hI' : I ∈ IndepSets F := Set.notMem_compl_iff.1 hI
        have hsum : ∑ g ∈ S, ({I : unitRing F → Bool | I g = true}.indicator 1 I : ℝ≥0∞) =
            ((S.filter fun g => I g = true).card : ℝ≥0∞) := by
          rw [Finset.card_filter, Nat.cast_sum]
          refine Finset.sum_congr rfl fun g _ => ?_
          by_cases hg : I g = true
          · rw [Set.indicator_of_mem (show I ∈ {I : unitRing F → Bool | I g = true} from hg), if_pos hg]; simp
          · rw [Set.indicator_of_notMem (show I ∉ {I : unitRing F → Bool | I g = true} from hg), if_neg hg]; simp
        have hind : (cayR F).IsIndepSet ((S.filter fun g => I g = true : Finset (unitRing F)) : Set (unitRing F)) := by
          intro x hx y hy _ hadj
          have hx' := (Finset.mem_filter.1 hx).2
          have hy' := (Finset.mem_filter.1 hy).2
          rcases ((SimpleGraph.fromRel_adj _ _ _).1 hadj).2 with h | h
          · exact hI' x y h ⟨hx', hy'⟩
          · exact hI' y x h ⟨hy', hx'⟩
        rw [hsum]
        exact_mod_cast hJmax _ (Finset.mem_filter.2 ⟨Finset.mem_powerset.2 (Finset.filter_subset _ S), hind⟩)
    _ = J.card := by rw [lintegral_const, measure_univ, mul_one]


/-! ## The dichotomy, one class -/

/-- **The indicator's spectral measure**: `∫ χ(y) dσ = P(0 ∈ I, y ∈ I)` for every `y ∈ R`. -/
def IsIndicatorSpectral (μ : Measure (unitRing F → Bool)) (σ : Measure (Dual F)) : Prop :=
  IsFiniteMeasure σ ∧ ∀ y : unitRing F, ∫ χ, (χ y : ℂ) ∂σ = ((μ.real {c | c 0 = true ∧ c y = true} : ℝ) : ℂ)

-- FS131-IFR1: **the indicator** `1{κ₀ = true}` in `L²(μ)` (`Collapse/Dichotomy`'s private `colourIndK` at `Bool`).
private def boolInd {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsFiniteMeasure μ] (κ₀ : Ω → Bool)
    (hκ₀ : Measurable κ₀) : Lp ℝ 2 μ :=
  indicatorConstLp 2 (hκ₀ (measurableSet_singleton true)) (measure_ne_top μ _) 1

-- FS131-IFR1: **its Koopman correlation**: `⟨e, V_y e⟩ = μ(κ(0), κ(y))` (`integral_colourIndK_mul_comp` at `Bool`).
private theorem integral_boolInd_mul_comp {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]
    (T : unitRing F → Ω → Ω) (hT : ∀ y, MeasurePreserving (T y) μ μ) (κ : Ω → unitRing F → Bool)
    (hκ : ∀ x, Measurable fun ω => κ ω x) (hequiv : ∀ y, ∀ᵐ ω ∂μ, κ (T y ω) 0 = κ ω y) (y : unitRing F) :
    ∫ ω, boolInd μ (fun ω => κ ω 0) (hκ 0) ω *
        Lp.compMeasurePreserving (T y) (hT y) (boolInd μ (fun ω => κ ω 0) (hκ 0)) ω ∂μ =
      μ.real {ω | κ ω 0 = true ∧ κ ω y = true} := by
  have h1 : (boolInd μ (fun ω => κ ω 0) (hκ 0) : Ω → ℝ) =ᵐ[μ]
      ((fun ω => κ ω 0) ⁻¹' ({true} : Set Bool)).indicator fun _ => (1 : ℝ) :=
    indicatorConstLp_coeFn
  have h2 := Lp.coeFn_compMeasurePreserving (boolInd μ (fun ω => κ ω 0) (hκ 0)) (hT y)
  have h3 := h1.comp_tendsto (hT y).quasiMeasurePreserving.tendsto_ae
  have hmeas : MeasurableSet {ω | κ ω 0 = true ∧ κ ω y = true} :=
    ((hκ 0) (measurableSet_singleton true)).inter ((hκ y) (measurableSet_singleton true))
  rw [← integral_indicator_one hmeas]
  refine integral_congr_ae ?_
  filter_upwards [h1, h2, h3, hequiv y] with ω e1 e2 e3 e4
  rw [e2, e3, e1]
  simp only [Function.comp_apply, Set.indicator_apply, Set.mem_setOf_eq, Pi.one_apply]
  by_cases ha : κ ω 0 = true <;> by_cases hb : κ ω y = true <;> simp [ha, hb, e4]

-- the shifts of `R → Bool` move the identity equivariantly at `0`
private theorem indShift_equiv_id (y : unitRing F) (c : unitRing F → Bool) :
    (fun c : unitRing F → Bool => c) (indShift y c) 0 = c y := by
  simp [indShift]

/-- Herglotz–Bochner on the countable `R` (`Rigidity.exists_isSpectralMeasureOf` for the indicator). -/
theorem exists_isIndicatorSpectral [NumberField F] (μ : IndepLaw F) :
    ∃ σ : Measure (Dual F), IsIndicatorSpectral μ.μ σ := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  obtain ⟨σ, hσ⟩ := exists_isSpectralMeasureOf indShift μ.measurePreserving_shift indShift_add
    (boolInd μ.μ (fun c => c 0) (measurable_pi_apply 0))
  refine ⟨σ, hσ.1, fun y => ?_⟩
  rw [hσ.2 y, integral_boolInd_mul_comp μ.μ indShift μ.measurePreserving_shift (fun c => c)
    (fun x => measurable_pi_apply x) (fun y => Eventually.of_forall fun c => indShift_equiv_id y c) y]

/-- It is rotation-invariant (FRAC 2): the law is (`Rigidity.measure_eq_of_fourier`). -/
theorem IsIndicatorSpectral.rotInv [NumberField F] (μ : IndepLaw F) {σ : Measure (Dual F)}
    (hσ : IsIndicatorSpectral μ.μ σ) : RotInv F σ := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  haveI := hσ.1
  intro u
  have hcoef : ∀ y, μ.μ.real {c : unitRing F → Bool | c 0 = true ∧ c (uvRing u * y) = true} =
      μ.μ.real {c | c 0 = true ∧ c y = true} := by
    intro y
    have hmeas : MeasurableSet {c : unitRing F → Bool | c 0 = true ∧ c y = true} :=
      (measurableSet_apply_true 0).inter
        (measurableSet_apply_true y)
    have e : {c : unitRing F → Bool | c 0 = true ∧ c (uvRing u * y) = true} =
        indRot u ⁻¹' {c | c 0 = true ∧ c y = true} := by
      ext c
      simp only [Set.mem_setOf_eq, Set.mem_preimage, indRot, mul_zero]
    rw [e, measureReal_def, measureReal_def, ← Measure.map_apply (measurable_indRot u) hmeas,
      (μ.measurePreserving_rot u).map_eq]
  haveI : IsFiniteMeasure (σ.map (rot u)) := Measure.isFiniteMeasure_map σ (rot u)
  refine measure_eq_of_fourier fun y => ?_
  rw [integral_map (measurable_rot u).aemeasurable (measurable_evalChar y).aestronglyMeasurable]
  show ∫ χ, (χ (uvRing u * y) : ℂ) ∂σ = _
  rw [hσ.2, hσ.2, hcoef]

/-- At a unit vector its coefficient is `0`: the set is independent. -/
theorem IsIndicatorSpectral.integral_unit (μ : IndepLaw F) {σ : Measure (Dual F)} (hσ : IsIndicatorSpectral μ.μ σ)
    (u : unitVectors F) : ∫ χ, (χ (uvRing u) : ℂ) ∂σ = 0 := by
  rw [hσ.2]
  have hsub : {c : unitRing F → Bool | c 0 = true ∧ c (uvRing u) = true} ⊆ (IndepSets F)ᶜ := fun c hc hI =>
    hI 0 (uvRing u) (by simp [uvRing]) hc
  rw [measureReal_def, measure_mono_null hsub μ.carried, ENNReal.toReal_zero, Complex.ofReal_zero]

/-- **`𝒜`, the factor of the `τ′_∅`-continuous vectors** of an invariant random independent set (`Collapse.factorK`'s
one-class namesake). -/
abbrev factorOne [NumberField F] (μ : IndepLaw F) : MeasurableSpace (unitRing F → Bool) :=
  haveI := μ.isProb
  factorSigma (indShift (F := F)) μ.measurePreserving_shift (@nhds _ (tauPrime F) 0)

/-- **The conditional law at `x`**: `p(x) = P(x ∈ I | 𝒜)`. -/
def condOne [NumberField F] (μ : IndepLaw F) (x : unitRing F) : (unitRing F → Bool) → ℝ :=
  condExp (factorOne μ) μ.μ (Set.indicator {c : unitRing F → Bool | c x = true} fun _ => (1 : ℝ))

/-! ### The conditional laws (FS131-IFR1's helpers: `Collapse/Dichotomy`'s at `Bool`, one class) -/

private theorem integrable_indOne (μ : IndepLaw F) (x : unitRing F) :
    Integrable (Set.indicator {c : unitRing F → Bool | c x = true} fun _ => (1 : ℝ)) μ.μ :=
  (integrable_const (1 : ℝ)).indicator (measurableSet_apply_true x)

private theorem measurable_condOne [NumberField F] (μ : IndepLaw F) (x : unitRing F) :
    Measurable[factorOne μ] (condOne μ x) :=
  (stronglyMeasurable_condExp (m := factorOne μ) (μ := μ.μ)
    (f := Set.indicator {c : unitRing F → Bool | c x = true} fun _ => (1 : ℝ))).measurable

private theorem measurable_condOne' [NumberField F] (μ : IndepLaw F) (x : unitRing F) : Measurable (condOne μ x) :=
  (measurable_condOne μ x).mono (factorSigma_le _ _ _) le_rfl

private theorem condOne_nonneg [NumberField F] (μ : IndepLaw F) (x : unitRing F) : 0 ≤ᵐ[μ.μ] condOne μ x :=
  condExp_nonneg (Filter.Eventually.of_forall fun ω => Set.indicator_nonneg (fun _ _ => zero_le_one) ω)

private theorem condOne_le_one [NumberField F] (μ : IndepLaw F) (x : unitRing F) : ∀ᵐ c ∂μ.μ, condOne μ x c ≤ 1 := by
  have h := condExp_mono (m := factorOne μ) (integrable_indOne μ x) (integrable_const (1 : ℝ))
    (Filter.Eventually.of_forall fun ω => Set.indicator_le_self' (fun _ _ => zero_le_one) ω)
  rw [condExp_const (factorSigma_le _ _ _)] at h
  exact h

-- `I ⊆ {p > 0}` almost surely: `P(p(x) ≤ 0, x ∈ I) = 0` (`measure_condLawK_nonpos_inter` at `Bool`)
private theorem measure_condOne_nonpos_inter [NumberField F] (μ : IndepLaw F) (x : unitRing F) :
    μ.μ ({c | condOne μ x c ≤ 0} ∩ {c | c x = true}) = 0 := by
  have hA : MeasurableSet {c : unitRing F → Bool | c x = true} :=
    measurableSet_apply_true x
  have hs : MeasurableSet[factorOne μ] {c | condOne μ x c ≤ 0} := measurable_condOne μ x measurableSet_Iic
  have h1 : ∫ c in {c | condOne μ x c ≤ 0}, (Set.indicator {c : unitRing F → Bool | c x = true}
      fun _ => (1 : ℝ)) c ∂μ.μ = μ.μ.real ({c | condOne μ x c ≤ 0} ∩ {c | c x = true}) := by
    rw [setIntegral_indicator hA, setIntegral_const, smul_eq_mul, mul_one]
  have h2 : μ.μ.real ({c | condOne μ x c ≤ 0} ∩ {c | c x = true}) ≤ 0 := by
    rw [← h1, ← setIntegral_condExp (factorSigma_le _ _ _) (integrable_indOne μ x) hs]
    exact setIntegral_nonpos (factorSigma_le _ _ _ _ hs) fun c hc => hc
  have h3 := le_antisymm h2 measureReal_nonneg
  rwa [measureReal_def, ENNReal.toReal_eq_zero_iff, or_iff_left (measure_ne_top μ.μ _)] at h3

-- **the conditional laws move with the shifts**: `p(x) ∘ shift_y = p(x + y)` almost surely
private theorem condOne_comp_indShift [NumberField F] (μ : IndepLaw F) (x y : unitRing F) :
    condOne μ x ∘ indShift y =ᵐ[μ.μ] condOne μ (x + y) := by
  have hS𝒜 : (factorOne μ).comap (indShift y) = factorOne μ :=
    comap_factorSigma_eq_of_action indShift μ.measurePreserving_shift indShift_add indShift_zero _ y
  have h := condExp_comp_measurePreserving (factorOne μ) μ.μ (factorSigma_le _ _ _) (μ.measurePreserving_shift y)
    hS𝒜 (integrable_indOne μ x)
  have e : (Set.indicator {c' : unitRing F → Bool | c' x = true} fun _ => (1 : ℝ)) ∘ indShift y =
      Set.indicator {c' | c' (x + y) = true} fun _ => (1 : ℝ) := by
    funext c
    by_cases hc : c (x + y) = true <;> simp [indShift, Set.indicator, hc]
  rw [e] at h
  exact h

-- the conjugate of a unit vector (`Collapse/Dichotomy`'s private `conjUVK`)
private def conjUV' (u : unitVectors F) : unitVectors F :=
  ⟨starRingEnd ℂ u, UnitRing.conj_mem_planeOver u.2.1, by rw [Complex.norm_conj]; exact u.2.2⟩

private theorem uvRing_mul_conjUV' (u : unitVectors F) (y : unitRing F) : uvRing u * (uvRing (conjUV' u) * y) = y := by
  have h1 : (u : ℂ) * starRingEnd ℂ u = 1 := by
    rw [Complex.mul_conj', u.2.2]
    simp
  apply Subtype.ext
  change (u : ℂ) * (starRingEnd ℂ u * y) = y
  rw [← mul_assoc, h1, one_mul]

-- the rotated preimage of an event of `𝒜` is an event of `𝒜` (`colourRotK_preimage_mem` at `Bool`)
private theorem indRot_preimage_mem [NumberField F] (μ : IndepLaw F) (u : unitVectors F)
    {A : Set (unitRing F → Bool)} (hA : MeasurableSet[factorOne μ] A) :
    MeasurableSet[factorOne μ] (indRot u ⁻¹' A) := by
  rw [measurableSet_factorSigma_iff] at hA ⊢
  obtain ⟨hAm, h⟩ := (mem_factorSets_iff indShift μ.measurePreserving_shift _).mp hA
  refine (mem_factorSets_iff indShift μ.measurePreserving_shift _).mpr ⟨hAm.preimage (measurable_indRot u), ?_⟩
  have key : ∀ y, μ.μ (symmDiff (indShift y ⁻¹' (indRot u ⁻¹' A)) (indRot u ⁻¹' A)) =
      μ.μ (symmDiff (indShift (uvRing (conjUV' u) * y) ⁻¹' A) A) := by
    intro y
    have e1 : indShift y ⁻¹' (indRot u ⁻¹' A) = indRot u ⁻¹' (indShift (uvRing (conjUV' u) * y) ⁻¹' A) := by
      have e : ∀ c : unitRing F → Bool, indRot u (indShift y c) = indShift (uvRing (conjUV' u) * y) (indRot u c) := by
        intro c
        funext x
        simp only [indRot, indShift]
        rw [mul_add, uvRing_mul_conjUV']
      ext c
      simp only [Set.mem_preimage, e]
    rw [e1, ← Set.preimage_symmDiff, (μ.measurePreserving_rot u).measure_preimage
      ((hAm.preimage (measurable_indShift _)).symmDiff hAm).nullMeasurableSet]
  simp only [key]
  exact h.comp (tendsto_mul_nhds_tauPrime (uvRing (conjUV' u)))

-- **`𝒜` is rotation-invariant** (`comap_colourRotK_factorK` at `Bool`)
private theorem comap_indRot_factorOne [NumberField F] (μ : IndepLaw F) (u : unitVectors F) :
    (factorOne μ).comap (indRot u) = factorOne μ := by
  apply le_antisymm
  · intro s hs
    obtain ⟨A, hA, rfl⟩ := MeasurableSpace.measurableSet_comap.mp hs
    exact indRot_preimage_mem μ u hA
  · intro B hB
    refine MeasurableSpace.measurableSet_comap.mpr ⟨indRot (conjUV' u) ⁻¹' B, indRot_preimage_mem μ (conjUV' u) hB, ?_⟩
    have e : ∀ c : unitRing F → Bool, indRot (conjUV' u) (indRot u c) = c := by
      intro c
      funext x
      simp only [indRot]
      rw [uvRing_mul_conjUV']
    ext c
    simp only [Set.mem_preimage, e]

-- **the conditional laws move with the rotations**: `p(x) ∘ rot_u = p(u x)` almost surely
private theorem condOne_comp_indRot [NumberField F] (μ : IndepLaw F) (x : unitRing F) (u : unitVectors F) :
    condOne μ x ∘ indRot u =ᵐ[μ.μ] condOne μ (uvRing u * x) := by
  have h := condExp_comp_measurePreserving (factorOne μ) μ.μ (factorSigma_le _ _ _) (μ.measurePreserving_rot u)
    (comap_indRot_factorOne μ u) (integrable_indOne μ x)
  have e : (Set.indicator {c' : unitRing F → Bool | c' x = true} fun _ => (1 : ℝ)) ∘ indRot u =
      Set.indicator {c' | c' (uvRing u * x) = true} fun _ => (1 : ℝ) := by
    funext c
    by_cases hc : c (uvRing u * x) = true <;> simp [indRot, Set.indicator, hc]
  rw [e] at h
  exact h

-- **`Πe`**, the continuous part of the indicator, and its correlations `⟨Πe, V_y Πe⟩ = E[p(0) p(y)]`
private def indCond [NumberField F] (μ : IndepLaw F) : Lp ℝ 2 μ.μ :=
  condExpL2 ℝ ℝ (factorSigma_le _ μ.measurePreserving_shift (@nhds _ (tauPrime F) 0))
    (boolInd μ.μ (fun c => c 0) (measurable_pi_apply 0))

private theorem indCond_ae_eq_condOne [NumberField F] (μ : IndepLaw F) :
    (indCond μ : (unitRing F → Bool) → ℝ) =ᵐ[μ.μ] condOne μ 0 :=
  MemLp.condExpL2_ae_eq_condExp (𝕜 := ℝ) (factorSigma_le _ μ.measurePreserving_shift _)
    (memLp_indicator_const 2 (measurableSet_apply_true 0) (1 : ℝ)
      (Or.inr (measure_ne_top _ _)))

private theorem integral_indCond_mul_comp [NumberField F] (μ : IndepLaw F) (y : unitRing F) :
    ∫ c, indCond μ c * Lp.compMeasurePreserving (indShift y) (μ.measurePreserving_shift y) (indCond μ) c ∂μ.μ =
      ∫ c, condOne μ 0 c * condOne μ y c ∂μ.μ := by
  have h5 := indCond_ae_eq_condOne μ
  have h2 := Lp.coeFn_compMeasurePreserving (indCond μ) (μ.measurePreserving_shift y)
  have h3 := h5.comp_tendsto (μ.measurePreserving_shift y).quasiMeasurePreserving.tendsto_ae
  have h4 := condOne_comp_indShift μ 0 y
  rw [zero_add] at h4
  refine integral_congr_ae ?_
  filter_upwards [h5, h2, h3, h4] with c e5 e2 e3 e4
  rw [e2, e3, e5, e4]

/-- **SI-3 at `T + A`, one class** (FRAC 3, D3): `∫_{R̂∖(T+A)} Re χ(u) dσ = −E[p(0) p(u)]`. -/
theorem setIntegral_compl_TA_re_one [NumberField F] (μ : IndepLaw F) {σ : Measure (Dual F)}
    (hσ : IsIndicatorSpectral μ.μ σ) (u : unitVectors F) :
    ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ = -∫ c, condOne μ 0 c * condOne μ (uvRing u) c ∂μ.μ := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  haveI := hσ.1
  obtain ⟨σ₀, hσ₀⟩ := exists_isSpectralMeasureOf indShift μ.measurePreserving_shift indShift_add
    (boolInd μ.μ (fun c => c 0) (measurable_pi_apply 0))
  haveI := hσ₀.1
  -- `σ` is the indicator's spectral measure (Fourier uniqueness)
  have H : σ = σ₀ := measure_eq_of_fourier fun y => by
    rw [hσ.2 y, hσ₀.2 y, integral_boolInd_mul_comp μ.μ indShift μ.measurePreserving_shift (fun c => c)
      (fun x => measurable_pi_apply x) (fun y => Eventually.of_forall fun c => indShift_equiv_id y c) y]
  subst H
  have hA : MeasurableSet (TA F) := measurableSet_TA F
  have hτ : MeasurableSet (contChars (tauPrime F)) := by
    rw [contChars_tauPrime]
    exact hA
  have hsplit := integral_add_compl hA (integrable_evalChar σ (uvRing u))
  have htot : ∫ χ, ((χ (uvRing u) : Circle) : ℂ) ∂σ = 0 := IsIndicatorSpectral.integral_unit μ hσ u
  have hpart := (isSpectralMeasureOf_condExpL2 (tauPrime F) (isTopologicalAddGroup_tauPrime F)
    (isCountablyGenerated_nhds_tauPrime F) (bochnerOn_tauPrime F) hτ indShift μ.measurePreserving_shift
    indShift_add hσ₀).1
  rw [contChars_tauPrime] at hpart
  have hTA : ∫ χ in TA F, ((χ (uvRing u) : Circle) : ℂ) ∂σ =
      ((∫ c, condOne μ 0 c * condOne μ (uvRing u) c ∂μ.μ : ℝ) : ℂ) := by
    rw [hpart.2 (uvRing u)]
    exact congrArg _ (integral_indCond_mul_comp μ (uvRing u))
  rw [htot, hTA] at hsplit
  have hX : ∫ χ in (TA F)ᶜ, ((χ (uvRing u) : Circle) : ℂ) ∂σ =
      (((-∫ c, condOne μ 0 c * condOne μ (uvRing u) c ∂μ.μ) : ℝ) : ℂ) := by
    push_cast
    linear_combination hsplit
  have hre := integral_re (𝕜 := ℂ) (integrable_evalChar (σ.restrict (TA F)ᶜ) (uvRing u))
  simp only [RCLike.re_to_complex] at hre
  rw [hre, hX, Complex.ofReal_re]

-- the integral off `T + A` is the same at every unit vector (`σ` and `T + A` are rotation-invariant)
private theorem setIntegral_compl_TA_rot_one [NumberField F] (μ : IndepLaw F) {σ : Measure (Dual F)}
    (hσ : IsIndicatorSpectral μ.μ σ) (u : unitVectors F) :
    ∫ χ in (TA F)ᶜ, (χ (uvRing u) : ℂ).re ∂σ = ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ := by
  have hrot : σ.map (rot u) = σ := hσ.rotInv μ u
  have hA : MeasurableSet (TA F)ᶜ := (measurableSet_TA F).compl
  have hm : Measurable fun χ : Dual F => (χ 1 : ℂ).re := Complex.measurable_re.comp (measurable_evalChar 1)
  conv_rhs => rw [← hrot]
  rw [setIntegral_map hA hm.aestronglyMeasurable (measurable_rot u).aemeasurable, Set.preimage_compl,
    rot_preimage_TA]
  simp only [rot_apply, mul_one]

/-- **MR⁺, one class** (FRAC 4, D4): `E[p(0) p(u)] = 0` at every unit vector — otherwise `σ|_{(T+A)ᶜ}` is an SP witness
(`Collapse.not_isSPWitness`, on `Rigidity.mrPlus`). -/
theorem integral_condOne_mul_eq_zero [NumberField F] (μ : IndepLaw F) (u : unitVectors F) :
    ∫ c, condOne μ 0 c * condOne μ (uvRing u) c ∂μ.μ = 0 := by
  obtain ⟨σ, hσ⟩ := exists_isIndicatorSpectral μ
  haveI := hσ.1
  have hnn : 0 ≤ ∫ c, condOne μ 0 c * condOne μ (uvRing u) c ∂μ.μ := by
    refine integral_nonneg_of_ae ?_
    filter_upwards [condOne_nonneg μ 0, condOne_nonneg μ (uvRing u)] with c h1 h2
    exact mul_nonneg h1 h2
  by_cases hneg : ∫ χ in (TA F)ᶜ, (χ 1 : ℂ).re ∂σ < 0
  · exfalso
    refine not_isSPWitness (F := F) subset_rfl (σ.restrict (TA F)ᶜ) ⟨inferInstance, rotInv_restrict_compl_TA
      (hσ.rotInv μ), ?_, hneg⟩
    rw [Measure.restrict_apply (measurableSet_TA F), Set.inter_compl_self, measure_empty]
  · have h1 := not_lt.mp hneg
    have h2 := setIntegral_compl_TA_re_one μ hσ u
    rw [setIntegral_compl_TA_rot_one μ hσ u] at h2
    linarith

-- the product of the conditional laws vanishes across every edge: shift invariance carries `(0, u)` to `(x, y)`
private theorem integral_condOne_mul_eq_zero_of_adj [NumberField F] (μ : IndepLaw F) {x y : unitRing F}
    (hxy : (y : ℂ) - x ∈ unitVectors F) : ∫ c, condOne μ x c * condOne μ y c ∂μ.μ = 0 := by
  let u : unitVectors F := ⟨(y : ℂ) - x, hxy⟩
  have hu : uvRing u = y - x := Subtype.ext (by simp [uvRing, u])
  have h0 := integral_condOne_mul_eq_zero μ u
  rw [hu] at h0
  have e1 := condOne_comp_indShift μ 0 x
  have e2 := condOne_comp_indShift μ (y - x) x
  rw [zero_add] at e1
  rw [sub_add_cancel] at e2
  have hS := μ.measurePreserving_shift x
  have hg : Measurable fun c => condOne μ 0 c * condOne μ (y - x) c :=
    (measurable_condOne' μ 0).mul (measurable_condOne' μ (y - x))
  have hmap := integral_map (μ := μ.μ) hS.measurable.aemeasurable hg.aestronglyMeasurable
  rw [hS.map_eq] at hmap
  rw [← h0, hmap]
  refine integral_congr_ae ?_
  filter_upwards [e1, e2] with c h1 h2
  rw [← h1, ← h2]
  rfl

-- `p(x) p(y) = 0` almost surely across every edge
private theorem ae_condOne_mul_eq_zero [NumberField F] (μ : IndepLaw F) {x y : unitRing F}
    (hxy : (y : ℂ) - x ∈ unitVectors F) : ∀ᵐ c ∂μ.μ, condOne μ x c * condOne μ y c = 0 := by
  have hnn : 0 ≤ᵐ[μ.μ] fun c => condOne μ x c * condOne μ y c := by
    filter_upwards [condOne_nonneg μ x, condOne_nonneg μ y] with c h1 h2
    exact mul_nonneg h1 h2
  have hint : Integrable (fun c => condOne μ x c * condOne μ y c) μ.μ := by
    refine Integrable.mono' (integrable_condExp (m := factorOne μ) (μ := μ.μ)
      (f := Set.indicator {c : unitRing F → Bool | c y = true} fun _ => (1 : ℝ))).norm
      ((integrable_condExp (m := factorOne μ)).aestronglyMeasurable.mul
        (integrable_condExp (m := factorOne μ)).aestronglyMeasurable) ?_
    filter_upwards [condOne_nonneg μ x, condOne_le_one μ x] with c h1 h2
    rw [norm_mul]
    refine mul_le_of_le_one_left (norm_nonneg _) ?_
    rw [Real.norm_eq_abs, abs_le]
    exact ⟨by have : (0 : ℝ) ≤ condOne μ x c := h1; linarith, h2⟩
  exact (integral_eq_zero_iff_of_nonneg_ae hnn hint).mp (integral_condOne_mul_eq_zero_of_adj μ hxy)

/-! ### The support set `J = {x : p(x) > 0}` -/

-- the support set of the conditional laws
private def suppSet [NumberField F] (μ : IndepLaw F) (c : unitRing F → Bool) : unitRing F → Bool :=
  fun x => decide (0 < condOne μ x c)

private theorem measurable_suppSet_apply [NumberField F] (μ : IndepLaw F) (x : unitRing F) :
    Measurable[factorOne μ] fun c => suppSet μ c x := by
  have hpos : MeasurableSet[factorOne μ] {c | 0 < condOne μ x c} := measurable_condOne μ x measurableSet_Ioi
  refine @measurable_to_countable' Bool _ _ _ (factorOne μ) _ fun b => ?_
  cases b
  · have e : (fun c => suppSet μ c x) ⁻¹' {false} = {c | 0 < condOne μ x c}ᶜ := by
      ext c; simp [suppSet]
    rw [e]; exact hpos.compl
  · have e : (fun c => suppSet μ c x) ⁻¹' {true} = {c | 0 < condOne μ x c} := by
      ext c; simp [suppSet]
    rw [e]; exact hpos

private theorem measurable_suppSet [NumberField F] (μ : IndepLaw F) : Measurable (suppSet μ) :=
  measurable_pi_lambda _ fun x => (measurable_suppSet_apply μ x).mono (factorSigma_le _ _ _) le_rfl

private theorem suppSet_shift_ae [NumberField F] (μ : IndepLaw F) (y : unitRing F) :
    ∀ᵐ c ∂μ.μ, suppSet μ (indShift y c) = indShift y (suppSet μ c) := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have h : ∀ᵐ c ∂μ.μ, ∀ x, condOne μ x (indShift y c) = condOne μ (x + y) c :=
    ae_all_iff.mpr fun x => condOne_comp_indShift μ x y
  filter_upwards [h] with c hc
  funext x
  simp only [suppSet, indShift, hc x]

private theorem suppSet_rot_ae [NumberField F] (μ : IndepLaw F) (u : unitVectors F) :
    ∀ᵐ c ∂μ.μ, suppSet μ (indRot u c) = indRot u (suppSet μ c) := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  have h : ∀ᵐ c ∂μ.μ, ∀ x, condOne μ x (indRot u c) = condOne μ (uvRing u * x) c :=
    ae_all_iff.mpr fun x => condOne_comp_indRot μ x u
  filter_upwards [h] with c hc
  funext x
  simp only [suppSet, indRot, hc x]

-- **the law of the support set** is an invariant random independent set
private def suppLaw [NumberField F] (μ : IndepLaw F) : IndepLaw F where
  μ := μ.μ.map (suppSet μ)
  isProb := Measure.isProbabilityMeasure_map (measurable_suppSet μ).aemeasurable
  carried := by
    haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
    haveI : Countable (unitRing F) := countable_unitRing
    rw [Measure.map_apply (measurable_suppSet μ) measurableSet_indepSets.compl]
    refine measure_eq_zero_iff_ae_notMem.mpr ?_
    have h : ∀ᵐ c ∂μ.μ, ∀ x y : unitRing F, (y : ℂ) - x ∈ unitVectors F → condOne μ x c * condOne μ y c = 0 := by
      refine ae_all_iff.mpr fun x => ae_all_iff.mpr fun y => ?_
      by_cases hxy : (y : ℂ) - x ∈ unitVectors F
      · filter_upwards [ae_condOne_mul_eq_zero μ hxy] with c hc _ using hc
      · exact Eventually.of_forall fun c h => absurd h hxy
    filter_upwards [h] with c hc hcI
    refine hcI fun x y hxy hb => ?_
    simp only [suppSet, decide_eq_true_eq] at hb
    exact (mul_pos hb.1 hb.2).ne' (hc x y hxy)
  shift_inv y := by
    have hae : (fun (c : unitRing F → Bool) x => c (x + y)) ∘ suppSet μ =ᵐ[μ.μ] suppSet μ ∘ indShift y := by
      filter_upwards [suppSet_shift_ae μ y] with c hc
      exact hc.symm
    rw [Measure.map_map (g := fun (c : unitRing F → Bool) x => c (x + y)) (measurable_indShift y)
      (measurable_suppSet μ), Measure.map_congr hae, ← Measure.map_map (measurable_suppSet μ) (measurable_indShift y)]
    exact congrArg (Measure.map (suppSet μ)) (μ.shift_inv y)
  rot_inv u := by
    have hae : (fun (c : unitRing F → Bool) x => c (uvRing u * x)) ∘ suppSet μ =ᵐ[μ.μ] suppSet μ ∘ indRot u := by
      filter_upwards [suppSet_rot_ae μ u] with c hc
      exact hc.symm
    rw [Measure.map_map (g := fun (c : unitRing F → Bool) x => c (uvRing u * x)) (measurable_indRot u)
      (measurable_suppSet μ), Measure.map_congr hae, ← Measure.map_map (measurable_suppSet μ) (measurable_indRot u)]
    exact congrArg (Measure.map (suppSet μ)) (μ.rot_inv u)

-- the support set holds the random set, so it is at least as dense
private theorem density_le_suppLaw [NumberField F] (μ : IndepLaw F) : μ.density ≤ (suppLaw μ).density := by
  show μ.μ {c | c 0 = true} ≤ (μ.μ.map (suppSet μ)) {c | c 0 = true}
  rw [Measure.map_apply (measurable_suppSet μ) (measurableSet_apply_true 0)]
  refine measure_mono_ae ?_
  have h0 := measure_eq_zero_iff_ae_notMem.mp (measure_condOne_nonpos_inter μ 0)
  filter_upwards [h0] with c hc h1
  show decide (0 < condOne μ 0 c) = true
  rw [decide_eq_true_eq]
  by_contra hle
  exact hc ⟨not_lt.mp hle, h1⟩

-- **the support set's indicator spectral measure is carried by `T + A`**: its indicator is `𝒜`-measurable
private theorem suppLaw_spectral_null [NumberField F] (μ : IndepLaw F) {σ' : Measure (Dual F)}
    (hσ' : IsIndicatorSpectral (suppLaw μ).μ σ') : σ' (TA F)ᶜ = 0 := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  haveI := hσ'.1
  have hκ : ∀ x, Measurable fun c => suppSet μ c x := fun x =>
    (measurable_suppSet_apply μ x).mono (factorSigma_le _ _ _) le_rfl
  have hequiv : ∀ y, ∀ᵐ c ∂μ.μ, suppSet μ (indShift y c) 0 = suppSet μ c y := by
    intro y
    filter_upwards [suppSet_shift_ae μ y] with c hc
    rw [hc]
    simp [indShift]
  obtain ⟨σ₀, hσ₀⟩ := exists_isSpectralMeasureOf indShift μ.measurePreserving_shift indShift_add
    (boolInd μ.μ (fun c => suppSet μ c 0) (hκ 0))
  haveI := hσ₀.1
  have H : σ' = σ₀ := measure_eq_of_fourier fun y => by
    rw [hσ'.2 y, hσ₀.2 y, integral_boolInd_mul_comp μ.μ indShift μ.measurePreserving_shift (suppSet μ) hκ hequiv y,
      measureReal_def, measureReal_def]
    show (((μ.μ.map (suppSet μ)) {c | c 0 = true ∧ c y = true}).toReal : ℂ) = _
    rw [Measure.map_apply (measurable_suppSet μ) (measurableSet_both 0 y)]
    rfl
  have hmem : boolInd μ.μ (fun c => suppSet μ c 0) (hκ 0) ∈
      contVec indShift μ.measurePreserving_shift (@nhds _ (tauPrime F) 0) := by
    rw [contVec_eq_lpMeas]
    exact mem_lpMeas_indicatorConstLp (factorSigma_le _ _ _)
      ((measurable_suppSet_apply μ 0) (measurableSet_singleton true)) (measure_ne_top _ _)
  have h := (spectral_carried_iff (tauPrime F) (isTopologicalAddGroup_tauPrime F)
    (isCountablyGenerated_nhds_tauPrime F) (bochnerOn_tauPrime F) indShift μ.measurePreserving_shift
    indShift_add hσ₀).mpr hmem
  rw [contChars_tauPrime] at h
  rw [H]
  exact h

/-- **The support set** (FRAC 5, D5): `J = {x : p(x) > 0}` is an invariant random independent set containing `I`, with its
spectrum on `T + A`. -/
theorem exists_indepLaw_TA [NumberField F] (μ : IndepLaw F) :
    ∃ μ' : IndepLaw F, μ.density ≤ μ'.density ∧
      ∀ σ : Measure (Dual F), IsIndicatorSpectral μ'.μ σ → σ (TA F)ᶜ = 0 :=
  ⟨suppLaw μ, density_le_suppLaw μ, fun _ hσ => suppLaw_spectral_null μ hσ⟩

/-! ## The extension and the slice, one class -/

-- shift invariance read at a point: `P(y ∈ I) = P(0 ∈ I)`
private theorem measure_apply_eq_density (μ : IndepLaw F) (y : unitRing F) :
    μ.μ {c | c y = true} = μ.density := by
  have h1 : μ.μ.map (indShift y) {c | c 0 = true} = μ.μ {c | c 0 = true} := by
    rw [(μ.measurePreserving_shift y).map_eq]
  rw [Measure.map_apply (measurable_indShift y) (measurableSet_apply_true 0)] at h1
  rw [IndepLaw.density, ← h1]
  congr 1
  ext c
  show c y = true ↔ c (0 + y) = true
  rw [zero_add]

-- the disagreement is twice the defect: `P(c 0 ≠ c y) = 2 (P(0 ∈ I) − P(0, y ∈ I))`
private theorem measure_ne_eq_one (μ : IndepLaw F) (y : unitRing F) :
    (μ.μ {c | c 0 ≠ c y}).toReal = 2 * ((μ.density).toReal - μ.μ.real {c | c 0 = true ∧ c y = true}) := by
  have hm : ∀ x : unitRing F, MeasurableSet {c : unitRing F → Bool | c x = true} := fun x =>
    measurableSet_apply_true x
  set A := {c : unitRing F → Bool | c 0 = true} with hAdef
  set B := {c : unitRing F → Bool | c y = true} with hBdef
  have hne : {c : unitRing F → Bool | c 0 ≠ c y} = (A \ B) ∪ (B \ A) := by
    ext c
    simp only [Set.mem_setOf_eq, Set.mem_union, Set.mem_sdiff, hAdef, hBdef]
    cases c 0 <;> cases c y <;> simp
  have hAB : {c : unitRing F → Bool | c 0 = true ∧ c y = true} = A ∩ B := rfl
  have h1 := measureReal_sdiff_add_inter (μ := μ.μ) (s := A) (hm y)
  have h2 := measureReal_sdiff_add_inter (μ := μ.μ) (s := B) (hm 0)
  have hBA : μ.μ.real B = μ.μ.real A := by
    rw [measureReal_def, measureReal_def, hBdef, measure_apply_eq_density μ y]
    rfl
  have hcomm : μ.μ.real (B ∩ A) = μ.μ.real (A ∩ B) := by rw [Set.inter_comm]
  have hd : (μ.density).toReal = μ.μ.real A := rfl
  rw [hne, ← measureReal_def, measureReal_union disjoint_sdiff_sdiff ((hm y).diff (hm 0)), hd, hAB]
  linarith

/-- **Continuity in probability** (FRAC 6, C1): with spectrum on `T + A`, `P(c(0) ≠ c(y)) → 0` as `ιG y → 0`
(`P(c 0 ≠ c y) = 2(σ(R̂) − Re ∫ χ(y) dσ)`). -/
theorem tendsto_measure_ne_one [NumberField F] (μ : IndepLaw F) {σ : Measure (Dual F)}
    (hσ : IsIndicatorSpectral μ.μ σ) (hTA : σ (TA F)ᶜ = 0) :
    Tendsto (fun y => μ.μ {c | c 0 ≠ c y}) (comap (ιG F) (𝓝 0)) (𝓝 0) := by
  haveI : IsFiniteMeasure σ := hσ.1
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
  -- `σ(R̂) = P(0 ∈ I)`, the coefficient at `0`
  have h1 : (∫ _χ, (1 : ℂ) ∂σ) = (((μ.density).toReal : ℝ) : ℂ) := by
    have h := hσ.2 0
    simp only [AddChar.map_zero_eq_one, Circle.coe_one, and_self] at h
    rw [h]
    rfl
  rw [h1] at hint
  have hre : Tendsto (fun y => (∫ χ, (χ y : ℂ) ∂σ).re) (comap (ιG F) (𝓝 0)) (𝓝 (μ.density).toReal) := by
    have := (Complex.continuous_re.tendsto _).comp hint
    simpa [Function.comp_def] using this
  have hreal : Tendsto (fun y => (μ.μ {c | c 0 ≠ c y}).toReal) (comap (ιG F) (𝓝 0)) (𝓝 0) := by
    have heq : ∀ y, (μ.μ {c | c 0 ≠ c y}).toReal = 2 * ((μ.density).toReal - (∫ χ, (χ y : ℂ) ∂σ).re) := by
      intro y
      rw [measure_ne_eq_one μ y, hσ.2 y, Complex.ofReal_re]
    simp_rw [heq]
    have := (hre.const_sub (μ.density).toReal).const_mul 2
    simpa using this
  have hfin : ∀ y, μ.μ {c | c 0 ≠ c y} ≠ ⊤ := fun y => measure_ne_top _ _
  have := ENNReal.tendsto_ofReal hreal
  rw [ENNReal.ofReal_zero] at this
  refine this.congr fun y => ?_
  exact ENNReal.ofReal_toReal (hfin y)

-- shift invariance read at a pair (`Collapse/Slice`'s private `measure_ne_shift_k` at `Bool`)
private theorem measure_ne_shift_one (μ : IndepLaw F) (a b : unitRing F) :
    μ.μ {c | c a ≠ c b} = μ.μ {c | c 0 ≠ c (b - a)} := by
  have hS : MeasurableSet {c : unitRing F → Bool | c 0 ≠ c (b - a)} :=
    (measurableSet_eq_fun (measurable_pi_apply 0) (measurable_pi_apply (b - a))).compl
  calc μ.μ {c | c a ≠ c b} = μ.μ (indShift a ⁻¹' {c | c 0 ≠ c (b - a)}) := by
        congr 1; ext c; simp [indShift, sub_add_cancel]
    _ = (μ.μ.map (indShift a)) {c | c 0 ≠ c (b - a)} := (Measure.map_apply (measurable_indShift a) hS).symm
    _ = μ.μ {c | c 0 ≠ c (b - a)} := by rw [(μ.measurePreserving_shift a).map_eq]

-- an edge does not hold both its ends, almost surely
private theorem measure_both_add_unit (μ : IndepLaw F) (a : unitRing F) {u : unitRing F}
    (hu : u ∈ unitVectorsR F) : μ.μ {c | c a = true ∧ c (a + u) = true} = 0 := by
  refine measure_mono_null
    (show {c | c a = true ∧ c (a + u) = true} ⊆ (IndepSets F)ᶜ from fun c hc hX => ?_) μ.carried
  exact hX a (a + u) (by rw [Subring.coe_add, add_sub_cancel_left]; exact hu) hc

-- the measures of sets whose indicators converge almost everywhere converge (Mathlib's
-- `MeasureTheory.tendsto_measure_of_ae_tendsto_indicator_of_isFiniteMeasure`, whose module this one does not import: its proof)
private theorem tendsto_measure_of_ae_eventually_iff {α ι : Type*} [MeasurableSpace α] {μ : Measure α}
    [IsFiniteMeasure μ] (L : Filter ι) [L.IsCountablyGenerated] {A : Set α} {As : ι → Set α}
    (A_mble : MeasurableSet A) (As_mble : ∀ i, MeasurableSet (As i)) (h_lim : ∀ᵐ x ∂μ, ∀ᶠ i in L, x ∈ As i ↔ x ∈ A) :
    Tendsto (fun i => μ (As i)) L (𝓝 (μ A)) := by
  simp_rw [← lintegral_indicator_one A_mble, ← lintegral_indicator_one (As_mble _)]
  refine tendsto_lintegral_filter_of_dominated_convergence (Set.univ.indicator (1 : α → ℝ≥0∞))
    (Eventually.of_forall fun i => Measurable.indicator measurable_const (As_mble i)) ?_ ?_ ?_
  · exact Eventually.of_forall fun i => Eventually.of_forall fun x =>
      Set.indicator_le_indicator_of_subset (Set.subset_univ _) (fun _ => zero_le) x
  · rw [lintegral_indicator_one MeasurableSet.univ]
    exact measure_ne_top μ _
  · simpa only [Pi.one_def, tendsto_indicator_const_apply_iff_eventually] using h_lim

/-- **The extension, one class** (FRAC 6, C2–C3; `Collapse.exists_extension_k` with the edge event `true ∧ true`): a jointly
measurable random set of the completion, of the law's density at every point, almost surely not holding both ends of any
edge `(g, g + t)`, `t` in the closure of the unit vectors. -/
theorem exists_extension_one [NumberField F] (μ : IndepLaw F) {σ : Measure (Dual F)} (hσ : IsIndicatorSpectral μ.μ σ)
    (hTA : σ (TA F)ᶜ = 0) :
    ∃ f : (unitRing F → Bool) → G F → Bool, Measurable (Function.uncurry f) ∧
      (∀ g, μ.μ {c | f c g = true} = μ.density) ∧
      ∀ g t, t ∈ closure (ιG F '' unitVectorsR F) → μ.μ {c | f c g = true ∧ f c (g + t) = true} = 0 := by
  classical
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  obtain ⟨en, hen⟩ := exists_surjective_nat (unitRing F)
  -- neighbourhoods `W n` of `0` on whose triple differences the disagreement is at most `2^{−n}`
  have hT := tendsto_measure_ne_one μ hσ hTA
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
  have hev : Measurable (fun p : (unitRing F → Bool) × unitRing F => p.1 p.2) :=
    measurable_from_prod_countable_left fun r => measurable_pi_apply r
  have hcm : ∀ n, Measurable (fun x : (unitRing F → Bool) × G F => x.1 (π n x.2)) := fun n =>
    hev.comp (measurable_fst.prodMk ((hπm n).comp measurable_snd))
  -- the eventual value
  set stab : (unitRing F → Bool) × G F → ℕ → Prop :=
    fun x N => ∀ n, N ≤ n → x.1 (π n x.2) = x.1 (π N x.2) with hstab
  have hstabm : ∀ N, MeasurableSet {x | stab x N} := fun N => by
    have : {x | stab x N} = ⋂ n, ⋂ (_ : N ≤ n), {x | x.1 (π n x.2) = x.1 (π N x.2)} := by
      ext x; simp [hstab]
    rw [this]
    exact MeasurableSet.iInter fun n => MeasurableSet.iInter fun _ => measurableSet_eq_fun (hcm n) (hcm N)
  set EC : Set ((unitRing F → Bool) × G F) := {x | ∃ N, stab x N} with hEC
  have hECm : MeasurableSet EC := by
    have : EC = ⋃ N, {x | stab x N} := by ext; simp [hEC]
    rw [this]; exact MeasurableSet.iUnion hstabm
  have hp : ∀ x, ∃ N, stab x N ∨ x ∉ EC := fun x => by
    by_cases hx : x ∈ EC
    · obtain ⟨N, hN⟩ := hx; exact ⟨N, Or.inl hN⟩
    · exact ⟨0, Or.inr hx⟩
  have hpm : ∀ N, MeasurableSet {x | stab x N ∨ x ∉ EC} := fun N => (hstabm N).union hECm.compl
  set f : (unitRing F → Bool) → G F → Bool := fun c g => c (π (Nat.find (hp (c, g))) g) with hf
  have hfm : Measurable (Function.uncurry f) :=
    Measurable.find (f := fun n x => x.1 (π n x.2)) (p := fun N x => stab x N ∨ x ∉ EC) hcm hpm hp
  have hfval : ∀ x ∈ EC, ∀ n, Nat.find (hp x) ≤ n → x.1 (π n x.2) = f x.1 x.2 := by
    intro x hx n hn
    have hs : stab x (Nat.find (hp x)) := (Nat.find_spec (hp x)).resolve_right (not_not.mpr hx)
    exact hs n hn
  -- Borel–Cantelli: for each `g`, almost surely `c ∘ π · g` is eventually constant
  have hae : ∀ g, ∀ᵐ c ∂μ.μ, (c, g) ∈ EC := by
    intro g
    set s : ℕ → Set (unitRing F → Bool) := fun n => {c | c (π n g) ≠ c (π (n + 1) g)} with hs
    have hsle : ∀ n, μ.μ (s n) ≤ (1 / 2) ^ n := by
      intro n
      rw [hs, measure_ne_shift_one]
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
  refine ⟨f, hfm, fun g => ?_, fun g t ht => ?_⟩
  · -- the one-point law: `f c g` is almost surely the eventual value of `c (π n g)`, each of law `P(0 ∈ I)`
    have hA : MeasurableSet {c : unitRing F → Bool | f c g = true} :=
      (hfm.comp (measurable_id.prodMk measurable_const)) (measurableSet_singleton true)
    have hlim := tendsto_measure_of_ae_eventually_iff (μ := μ.μ) atTop hA
      (As := fun n => {c : unitRing F → Bool | c (π n g) = true})
      (fun n => measurableSet_apply_true _) (by
        filter_upwards [hae g] with c hc
        filter_upwards [eventually_ge_atTop (Nat.find (hp (c, g)))] with n hn
        have e := hfval (c, g) hc n hn
        dsimp only at e
        show c (π n g) = true ↔ f c g = true
        rw [e])
    simp only [measure_apply_eq_density] at hlim
    exact tendsto_nhds_unique hlim tendsto_const_nhds
  -- the edge `t`: almost surely, from some `m` on, `c` holds both `π m g` and `π m (g + t)`, of measure at most `2^{−m}`
  set C : ℕ → Set (unitRing F → Bool) := fun m => {c | c (π m g) = true ∧ c (π m (g + t)) = true} with hC
  have hCle : ∀ m, μ.μ (C m) ≤ (1 / 2) ^ m := by
    intro m
    have hopen : IsOpen {x : G F | x - t ∈ O m} := (hOopen m).preimage (continuous_sub_right t)
    obtain ⟨_, hut, u, hu, rfl⟩ := mem_closure_iff.mp ht _ hopen (by simpa using hO0 m)
    set a := π m g
    set b := π m (g + t)
    have hsub : C m ⊆ {c | c a = true ∧ c (a + u) = true} ∪ {c | c (a + u) ≠ c b} := by
      intro c hc
      by_cases h : c (a + u) = c b
      · exact Or.inl ⟨hc.1, h.trans hc.2⟩
      · exact Or.inr h
    refine (measure_mono hsub).trans ((measure_union_le _ _).trans ?_)
    rw [measure_both_add_unit μ a hu, zero_add, measure_ne_shift_one]
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
      show c (π m g) = true ∧ c (π m (g + t)) = true
      rw [e1, e2]
      exact hc
    · exact Or.inl (Or.inr h2)
  · exact Or.inl (Or.inl h1)

/-- **The slice, one class, with its density**: in any window, some sample gives a measurable set of `ℂ × K` with null
edges holding at least the law's density of the window (Tonelli over the sample for both). -/
theorem exists_slice_set [NumberField F] (μ : IndepLaw F)
    (hTA : ∀ σ : Measure (Dual F), IsIndicatorSpectral μ.μ σ → σ (TA F)ᶜ = 0) (a : ℂ) {s : ℝ} (hs : 0 < s) :
    ∃ W : Set (ℂ × K F), MeasurableSet W ∧ SetEdgeNull F W ∧
      μ.density * ENNReal.ofReal (s ^ 2) ≤ (volume.prod (haarK F)) (W ∩ squareWin a s ×ˢ Set.univ) := by
  classical
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  obtain ⟨σ, hσ⟩ := exists_isIndicatorSpectral μ
  obtain ⟨f, hfm, hf1, hf⟩ := exists_extension_one μ hσ (hTA σ hσ)
  have hDm : Measurable fun p : ℂ × K F => (Delta F p.1, p.2) :=
    ((Delta F).continuous_of_finiteDimensional.measurable.comp measurable_fst).prodMk measurable_snd
  set ν := (volume : Measure ℂ).prod (haarK F) with hν
  -- the random set of the slice
  set Wc : (unitRing F → Bool) → Set (ℂ × K F) := fun c => {p | f c (Delta F p.1, p.2) = true} with hWc
  have hWm : ∀ c, MeasurableSet (Wc c) := fun c =>
    (hfm.comp (measurable_const.prodMk hDm)) (measurableSet_singleton true)
  -- for each unit vector, almost surely the slice edges are null (Tonelli over the sample)
  have hu : ∀ u ∈ unitVectorsR F, ∀ᵐ c ∂μ.μ, ((volume.prod (haarK F)).prod arcLength)
      {p : (ℂ × K F) × ℝ | p.1 ∈ Wc c ∧ (p.1.1 + e p.2, p.1.2 + ιK F u) ∈ Wc c} = 0 := by
    intro u hu
    set S : Set ((unitRing F → Bool) × ((ℂ × K F) × ℝ)) :=
      {x | f x.1 (Delta F x.2.1.1, x.2.1.2) = true ∧
        f x.1 (Delta F (x.2.1.1 + e x.2.2), x.2.1.2 + ιK F u) = true} with hS
    have hm1 : Measurable fun x : (unitRing F → Bool) × ((ℂ × K F) × ℝ) => f x.1 (Delta F x.2.1.1, x.2.1.2) :=
      hfm.comp (measurable_fst.prodMk (hDm.comp (measurable_fst.comp measurable_snd)))
    have hm2 : Measurable fun x : (unitRing F → Bool) × ((ℂ × K F) × ℝ) =>
        f x.1 (Delta F (x.2.1.1 + e x.2.2), x.2.1.2 + ιK F u) := by
      refine hfm.comp (measurable_fst.prodMk (hDm.comp (f := fun x : (unitRing F → Bool) × ((ℂ × K F) × ℝ) =>
        ((x.2.1.1 + e x.2.2, x.2.1.2 + ιK F u) : ℂ × K F)) ?_))
      exact ((measurable_fst.comp (measurable_fst.comp measurable_snd)).add
        (continuous_e.measurable.comp (measurable_snd.comp measurable_snd))).prodMk
        ((measurable_snd.comp (measurable_fst.comp measurable_snd)).add_const _)
    have hSm : MeasurableSet S := (hm1 (measurableSet_singleton true)).inter (hm2 (measurableSet_singleton true))
    have hfib : ∀ w : (ℂ × K F) × ℝ, μ.μ ((fun c => (c, w)) ⁻¹' S) = 0 := by
      intro w
      have ht := mem_closure_ιG F w.2 hu
      have hpre : (fun c => (c, w)) ⁻¹' S =
          {c | f c (Delta F w.1.1, w.1.2) = true ∧
            f c ((Delta F w.1.1, w.1.2) + (Delta F (Complex.exp (w.2 * Complex.I)), ιK F u)) = true} := by
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
  have hall : ∀ᵐ c ∂μ.μ, SetEdgeNull F (Wc c) := by
    have := ae_all_iff.mpr fun u : unitVectorsR F => hu u u.2
    filter_upwards [this] with c hc u hu'
    exact hc ⟨u, hu'⟩
  -- the mean mass in the window is the density times its area (Tonelli)
  have hwin : MeasurableSet (squareWin a s ×ˢ (Set.univ : Set (K F))) :=
    (measurableSet_squareWin a s).prod MeasurableSet.univ
  set T : Set ((unitRing F → Bool) × (ℂ × K F)) :=
    {x | f x.1 (Delta F x.2.1, x.2.2) = true ∧ x.2 ∈ squareWin a s ×ˢ (Set.univ : Set (K F))} with hT
  have hTm : MeasurableSet T :=
    ((hfm.comp (measurable_fst.prodMk (hDm.comp measurable_snd))) (measurableSet_singleton true)).inter
      (measurable_snd hwin)
  have hint : ∫⁻ c, ν (Wc c ∩ squareWin a s ×ˢ Set.univ) ∂μ.μ = μ.density * ENNReal.ofReal (s ^ 2) := by
    have h1 : ∫⁻ c, ν (Wc c ∩ squareWin a s ×ˢ Set.univ) ∂μ.μ = (μ.μ.prod ν) T := by
      rw [Measure.prod_apply hTm]
      rfl
    have h2 : (μ.μ.prod ν) T = ∫⁻ p, (squareWin a s ×ˢ (Set.univ : Set (K F))).indicator (fun _ => μ.density) p ∂ν := by
      rw [Measure.prod_apply_symm hTm]
      refine lintegral_congr fun p => ?_
      by_cases hp : p.1 ∈ squareWin a s
      · rw [Set.indicator_of_mem (show p ∈ squareWin a s ×ˢ (Set.univ : Set (K F)) from ⟨hp, trivial⟩)]
        have e : (fun c => (c, p)) ⁻¹' T = {c | f c (Delta F p.1, p.2) = true} := by
          ext c; simp [hT, hp]
        rw [e, hf1]
      · rw [Set.indicator_of_notMem (show p ∉ squareWin a s ×ˢ (Set.univ : Set (K F)) from fun h => hp h.1)]
        have e : (fun c => (c, p)) ⁻¹' T = ∅ := by
          ext c; simp [hT, hp]
        rw [e, measure_empty]
    rw [h1, h2, lintegral_indicator_const hwin, hν, Measure.prod_prod, measure_univ, mul_one,
      volume_squareWin a hs.le]
  -- some sample with null edges reaches the mean (the first moment method)
  have hfin : ∫⁻ c, ν (Wc c ∩ squareWin a s ×ˢ Set.univ) ∂μ.μ ≠ ⊤ := by
    rw [hint]
    exact ENNReal.mul_ne_top (ne_top_of_le_ne_top ENNReal.one_ne_top prob_le_one) ENNReal.ofReal_ne_top
  obtain ⟨c, hcN, hc⟩ := exists_notMem_null_laverage_le (μ := μ.μ)
    (f := fun c => ν (Wc c ∩ squareWin a s ×ˢ Set.univ)) (N := {c | ¬ SetEdgeNull F (Wc c)})
    (IsProbabilityMeasure.ne_zero μ.μ) hfin (ae_iff.1 hall)
  rw [laverage_eq_lintegral, hint] at hc
  exact ⟨Wc c, hWm c, not_not.1 hcN, hc⟩

/-! ## The count, one class -/

open Classical in
/-- A set of the slice read as a colouring by `Fin 4` (colour `1` on the set): the held descent's input. -/
def setCol [NumberField F] (W : Set (ℂ × K F)) : ℂ × K F → Fin 4 := fun p => if p ∈ W then 1 else 0

-- the colouring is measurable, and colour `1` is the set
private theorem measurable_setCol [NumberField F] {W : Set (ℂ × K F)} (hW : MeasurableSet W) :
    Measurable (setCol W) := by
  classical
  exact Measurable.ite hW measurable_const measurable_const

private theorem setCol_eq_one [NumberField F] {W : Set (ℂ × K F)} {p : ℂ × K F} : setCol W p = 1 ↔ p ∈ W := by
  classical
  by_cases h : p ∈ W <;> simp [setCol, h]

/-- **Every level has ratio at most `c`**, with no ramified stable prime in place of `TCA F`
(`Counting.ratioLe_levR_range` through `Collapse.image_levR_unitVectors_of_unramified`). -/
theorem ratioLe_levR_range_of_unramified [NumberField F] (hun : ∀ P : StablePrime F, ¬ IsRamified P) {c : ℝ}
    (hc0 : 0 ≤ c) (hc : ∀ P : StablePrime F, RatioAtMost P c) {k : ℕ} (hk : 1 ≤ k) :
    RatioLe {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k} c := by
  have hpi : RatioLe (normOneLev F k) c :=
    ratioLe_pi (H := fun P : level F k => 𝓞 (fieldI F) ⧸ P.1.P ^ k) (S := fun P => normOneQ P.1 k) hc0
      (fun P _ hs => neg_mem_normOneQ P.1 k hs) (fun P => ratioLe_normOneQ P.1 (hc P.1) hk)
  refine ratioLe_subgroup (levR F k).range.toAddSubgroup ?_ hpi
  intro d hd
  rw [← image_levR_unitVectors_of_unramified hun k] at hd
  obtain ⟨r, _, rfl⟩ := hd
  exact ⟨r, rfl⟩

-- `Rigidity/CountDescent`'s private helpers, copied: a level coset is measurable; two subsets each filling more than
-- three quarters of a set of finite measure are not almost disjoint.
private theorem measurableSet_proj_preimage' [NumberField F] (k : ℕ) (a : Lev F k) :
    MeasurableSet (proj F k ⁻¹' {a}) :=
  ((isOpen_discrete {a}).preimage (continuous_proj F k)).measurableSet

private theorem false_of_three_quarters' {a b c : ENNReal} (hc : c ≠ ⊤) (ha : 3 / 4 * c < a) (hb : 3 / 4 * c < b)
    (hab : a + b ≤ c) : False := by
  have hac : a ≤ c := le_trans le_self_add hab
  have hbc : b ≤ c := le_trans le_add_self hab
  have ha' : a ≠ ⊤ := ne_top_of_le_ne_top hc hac
  have hb' : b ≠ ⊤ := ne_top_of_le_ne_top hc hbc
  have h34 : (3 / 4 : ENNReal) ≠ ⊤ := ENNReal.div_ne_top (by norm_num) (by norm_num)
  have e34 : ((3 / 4 : ENNReal) * c).toReal = 3 / 4 * c.toReal := by
    rw [ENNReal.toReal_mul, ENNReal.toReal_div]
    norm_num
  have h1 := (ENNReal.toReal_lt_toReal (ENNReal.mul_ne_top h34 hc) ha').2 ha
  have h2 := (ENNReal.toReal_lt_toReal (ENNReal.mul_ne_top h34 hc) hb').2 hb
  have h3 := (ENNReal.toReal_le_toReal (ENNReal.add_ne_top.2 ⟨ha', hb'⟩) hc).2 hab
  rw [ENNReal.toReal_add ha' hb'] at h3
  rw [e34] at h1 h2
  have h0 : 0 ≤ c.toReal := ENNReal.toReal_nonneg
  linarith

/-- **The level rows of a set with null edges have null edges** (`Counting.rowsEdgeNull_levelRows`, reading one colour). -/
theorem rowsEdgeNull_levelRows_set [NumberField F] (hun : ∀ P : StablePrime F, ¬ IsRamified P) {W : Set (ℂ × K F)}
    (hW : MeasurableSet W) (h : SetEdgeNull F W) (k : ℕ) :
    RowsEdgeNull {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k} (levelRows (setCol W) 1 k) := by
  have hφ := measurable_setCol hW
  intro q s hs
  obtain ⟨u, hu, hus⟩ : ∃ u : unitRing F, (u : ℂ) ∈ unitVectors F ∧ levR F k u = (s : Lev F k) := by
    have hs' : (s : Lev F k) ∈ levR F k '' {r | (r : ℂ) ∈ unitVectors F} := by
      rw [image_levR_unitVectors_of_unramified hun k]
      exact hs
    obtain ⟨u, hu, e⟩ := hs'
    exact ⟨u, hu, e⟩
  set C : Set (K F) := proj F k ⁻¹' {(q : Lev F k)} with hC
  set C' : Set (K F) := proj F k ⁻¹' {((q + s : (levR F k).range.toAddSubgroup) : Lev F k)} with hC'
  set g : K F := ιK F u with hg
  -- translation by `g` carries `C` onto `C'`
  have hshift : ∀ x : K F, x + g ∈ C' ↔ x ∈ C := by
    intro x
    simp only [hC, hC', Set.mem_preimage, Set.mem_singleton_iff, map_add, hg, proj_ιK, hus,
      AddSubgroup.coe_add]
    exact add_left_inj _
  have hpre : ∀ T : Set (K F), haarK F ((fun x => x + g) ⁻¹' T) = haarK F T := by
    intro T
    have e : (fun x : K F => x + g) = fun x => g + x := funext fun x => add_comm x g
    rw [e]
    exact measure_preimage_add (haarK F) g T
  have hCC' : haarK F C = haarK F C' := by
    rw [← hpre C']
    congr 1
    ext x
    exact (hshift x).symm
  -- the slice edges at `u` holding both ends in `W`, reordered to `((z, θ), x)`
  set M : Set ((ℂ × K F) × ℝ) := {p | p.1 ∈ W ∧ (p.1.1 + e p.2, p.1.2 + ιK F u) ∈ W} with hM
  have hM0 : ((volume.prod (haarK F)).prod arcLength) M = 0 := h u hu
  have hgp : MeasurePreserving (fun p : (ℂ × ℝ) × K F => ((p.1.1, p.2), p.1.2))
      (((volume : Measure ℂ).prod arcLength).prod (haarK F)) (((volume : Measure ℂ).prod (haarK F)).prod arcLength) := by
    have h1 := measurePreserving_prodAssoc (volume : Measure ℂ) arcLength (haarK F)
    have h2 := (MeasurePreserving.id (volume : Measure ℂ)).prod
      (Measure.measurePreserving_swap (μ := arcLength) (ν := haarK F))
    have h3 := (measurePreserving_prodAssoc (volume : Measure ℂ) (haarK F) arcLength).symm
    exact (h3.comp h2).comp h1
  set N : Set ((ℂ × ℝ) × K F) := (fun p : (ℂ × ℝ) × K F => ((p.1.1, p.2), p.1.2)) ⁻¹' M with hN
  have hN0 : (((volume : Measure ℂ).prod arcLength).prod (haarK F)) N = 0 :=
    hgp.quasiMeasurePreserving.preimage_null hM0
  have hae := Measure.measure_ae_null_of_prod_null hN0
  -- every row pair has a section of positive measure
  have hsub : pairSet (levelRows (setCol W) 1 k q) (levelRows (setCol W) 1 k (q + s)) ⊆
      {p | ¬ (haarK F (Prod.mk p ⁻¹' N) = (0 : ℂ × ℝ → ENNReal) p)} := by
    rintro ⟨z, θ⟩ ⟨hz, hz'⟩ hnull
    set A : Set (K F) := {x | setCol W (z, x) = 1} ∩ C with hA
    set B : Set (K F) := (fun x => x + g) ⁻¹' ({y | setCol W (z + e θ, y) = 1} ∩ C') with hB
    have hAm : MeasurableSet A :=
      (hφ.comp measurable_prodMk_left (measurableSet_singleton 1)).inter (measurableSet_proj_preimage' k _)
    have hBm : MeasurableSet B :=
      ((hφ.comp measurable_prodMk_left (measurableSet_singleton 1)).inter
        (measurableSet_proj_preimage' k _)).preimage (measurable_add_const g)
    have hAC : A ⊆ C := Set.inter_subset_right
    have hBC : B ⊆ C := fun x hx => (hshift x).1 hx.2
    have hAB : A ∩ B ⊆ Prod.mk (z, θ) ⁻¹' N := by
      rintro x ⟨hxA, hxB⟩
      show (z, x) ∈ W ∧ (z + e θ, x + ιK F u) ∈ W
      exact ⟨setCol_eq_one.1 hxA.1, setCol_eq_one.1 hxB.1⟩
    have hAB0 : haarK F (A ∩ B) = 0 := measure_mono_null hAB hnull
    have hsum : haarK F A + haarK F B ≤ haarK F C := by
      rw [← measure_union_add_inter A hBm, hAB0, add_zero]
      exact measure_mono (Set.union_subset hAC hBC)
    have hB' : haarK F B = haarK F ({y | setCol W (z + e θ, y) = 1} ∩ C') := hpre _
    have hzB : 3 / 4 * haarK F C < haarK F B := by
      rw [hB', hCC']
      exact hz'
    exact false_of_three_quarters' (measure_ne_top (haarK F) C) hz hzB hsum
  exact measure_mono_null hsub (ae_iff.1 hae)

/-- **The count, one class** (FRAC 7; `Counting.false_of_slice` without the four colours): for every `ε > 0` some window
`squareWin 0 s₀` in which every measurable set of `ℂ × K` with null edges holds at most `(max(m₁, c) + 2ε)s₀²`. -/
theorem exists_window_bound [NumberField F] (hun : ∀ P : StablePrime F, ¬ IsRamified P) {c : ℝ} (hc0 : 0 ≤ c)
    (hcP : ∀ P : StablePrime F, RatioAtMost P c) {ε : ℝ} (hε : 0 < ε) :
    ∃ s₀ : ℝ, 0 < s₀ ∧ ∀ W : Set (ℂ × K F), MeasurableSet W → SetEdgeNull F W →
      (volume.prod (haarK F)) (W ∩ squareWin 0 s₀ ×ˢ Set.univ) ≤
        ENNReal.ofReal ((max mOne.toReal c + 2 * ε) * s₀ ^ 2) := by
  classical
  obtain ⟨s₀, hs₀, hN⟩ := Plane.exists_nrWindow hε
  refine ⟨s₀, hs₀, fun W hW hnull => ?_⟩
  have hφ : Measurable (setCol W) := measurable_setCol hW
  have hset : {p : ℂ × K F | setCol W p = 1} = W := by
    ext p
    exact setCol_eq_one
  set M := max mOne.toReal c with hM
  obtain ⟨k, hk, hkbad⟩ := ((eventually_ge_atTop 1).and ((tendsto_bad hφ 1 0 s₀).eventually
    (gt_mem_nhds (by positivity : (0 : ℝ) < ε * s₀ ^ 2)))).exists
  have h1 := volume_colour_le hφ 1 k 0 s₀
  have hS : ∀ s ∈ {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k},
      -s ∈ {d : (levR F k).range.toAddSubgroup | (d : Lev F k) ∈ normOneLev F k} :=
    fun s hs P => neg_mem_normOneQ P.1 k (hs P)
  have h2 := sum_volume_inter_sq_le hS (ratioLe_levR_range_of_unramified hun hc0 hcP hk) hc0
    (measurableSet_levelRows hφ 1 k) (rowsEdgeNull_levelRows_set hun hW hnull k) hN 0 (le_refl s₀)
  have hn : (0 : ℝ) < Nat.card (levR F k).range.toAddSubgroup := by exact_mod_cast Nat.card_pos
  have h3 : (Nat.card (levR F k).range.toAddSubgroup : ℝ)⁻¹ *
      ∑ q, volume.real (levelRows (setCol W) 1 k q ∩ squareWin 0 s₀) ≤ (M + ε) * s₀ ^ 2 := by
    rw [inv_mul_le_iff₀ hn]
    calc _ ≤ (M + ε) * (Nat.card (levR F k).range.toAddSubgroup : ℝ) * s₀ ^ 2 := h2
      _ = _ := by ring
  rw [hset] at h1
  have hreal : (volume.prod (haarK F)).real (W ∩ squareWin 0 s₀ ×ˢ Set.univ) ≤ (M + 2 * ε) * s₀ ^ 2 := by
    linarith
  have hfin : (volume.prod (haarK F)) (W ∩ squareWin 0 s₀ ×ˢ Set.univ) ≠ ⊤ := by
    refine ne_top_of_le_ne_top ?_ (measure_mono Set.inter_subset_right)
    rw [Measure.prod_prod, measure_univ, mul_one, volume_squareWin 0 hs₀.le]
    exact ENNReal.ofReal_ne_top
  rw [← ENNReal.ofReal_toReal hfin]
  exact ENNReal.ofReal_le_ofReal hreal

/-! ## The per-law bound -/

/-- With no ramified stable prime and a uniform ratio bound `c`: every invariant random independent set has density at most
`max(m₁, c)`. -/
theorem IndepLaw.density_le_max_of_unramified [NumberField F] (hun : ∀ P : StablePrime F, ¬ IsRamified P) {c : ℝ}
    (hc0 : 0 ≤ c) (hcP : ∀ P : StablePrime F, RatioAtMost P c) (μ : IndepLaw F) :
    μ.density ≤ max mOne (ENNReal.ofReal c) := by
  obtain ⟨μ', hμμ', hTA⟩ := exists_indepLaw_TA μ
  refine hμμ'.trans (ENNReal.le_of_forall_pos_le_add fun ε hε _ => ?_)
  have hm1 : mOne ≠ ⊤ := ne_top_of_le_ne_top ENNReal.one_ne_top mOne_le_one
  have hε2 : (0 : ℝ) < (ε : ℝ) / 2 := by positivity
  obtain ⟨s₀, hs₀, hbound⟩ := exists_window_bound hun hc0 hcP hε2
  obtain ⟨W, hWm, hWnull, hW⟩ := exists_slice_set μ' hTA 0 hs₀
  have h := hW.trans (hbound W hWm hWnull)
  set M := max mOne.toReal c with hM
  have hM0 : 0 ≤ M := le_max_of_le_right hc0
  have e1 : (M + 2 * ((ε : ℝ) / 2)) * s₀ ^ 2 = (M + ε) * s₀ ^ 2 := by ring
  rw [e1, ENNReal.ofReal_mul (by positivity)] at h
  have hs2 : ENNReal.ofReal (s₀ ^ 2) ≠ 0 := by
    rw [ne_eq, ENNReal.ofReal_eq_zero, not_le]; positivity
  have h' : μ'.density ≤ ENNReal.ofReal (M + ε) := (ENNReal.mul_le_mul_iff_left hs2 ENNReal.ofReal_ne_top).1 h
  refine h'.trans (le_of_eq ?_)
  rw [ENNReal.ofReal_add hM0 ε.coe_nonneg, ENNReal.ofReal_coe_nnreal, hM, ENNReal.ofReal_max, ENNReal.ofReal_toReal hm1]

-- `α₁(Cay(R, U)) ≤ 1/2`: `0` and `1` are adjacent
private theorem cayR_finIndepRatio_le_half : (cayR F).finIndepRatio ≤ 2⁻¹ := by
  classical
  have hab : (0 : unitRing F) ≠ 1 := zero_ne_one
  have hadj : (cayR F).Adj 0 1 := by
    rw [cayR_adj_iff]
    simp
  have hS : ({0, 1} : Finset (unitRing F)).Nonempty := ⟨0, by simp⟩
  have key := (cayR F).finIndepRatio_le_of_forall_card_le hS (a := 1) ?_
  · rw [Finset.card_pair hab] at key
    simpa using key
  · intro I hI hind
    by_contra hlt
    push Not at hlt
    have hIeq : I = {0, 1} := Finset.eq_of_subset_of_card_le hI (by rw [Finset.card_pair hab]; omega)
    exact hind (by rw [hIeq]; simp) (by rw [hIeq]; simp) hab hadj

/-- **The per-law bound** (FRAC's first sentence, with MR proved): every invariant random independent set of `Cay(R, U)`
has density at most `α_loc(F)`. At a ramified stable prime `α_loc ≥ 1/2` and the density is at most `α₁(Cay(R, U)) ≤ 1/2`;
otherwise `c = (⨆_P r_P).toReal` and the line above. -/
theorem IndepLaw.density_le_localRatio [NumberField F] (μ : IndepLaw F) : μ.density ≤ localRatio F := by
  by_cases hram : ∃ P : StablePrime F, IsRamified P
  · obtain ⟨P, hP⟩ := hram
    exact μ.density_le_finIndepRatio.trans (cayR_finIndepRatio_le_half.trans
      ((half_le_stableRatio_of_isRamified hP).trans (stableRatio_le_localRatio P)))
  · push Not at hram
    have hsup : (⨆ P : StablePrime F, stableRatio P) ≤ 1 := iSup_le fun P => stableRatio_le_one P
    have hsupt : (⨆ P : StablePrime F, stableRatio P) ≠ ⊤ := ne_top_of_le_ne_top ENNReal.one_ne_top hsup
    set c := (⨆ P : StablePrime F, stableRatio P).toReal with hc
    have hc0 : 0 ≤ c := ENNReal.toReal_nonneg
    have hcP : ∀ P, RatioAtMost P c := fun P => ratioAtMost_of_stableRatio_le P hc0
      (by rw [hc, ENNReal.ofReal_toReal hsupt]; exact le_iSup (fun P => stableRatio P) P)
    refine (μ.density_le_max_of_unramified hram hc0 hcP).trans (le_of_eq ?_)
    rw [hc, ENNReal.ofReal_toReal hsupt]
    rfl

end

end HadwigerNelson.Collapse
