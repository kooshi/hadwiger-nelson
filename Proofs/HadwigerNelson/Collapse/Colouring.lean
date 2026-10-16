import Proofs.HadwigerNelson.Rigidity.APlus

/-!
# Invariant random `k`-colourings of `Cay(ℤ[U_F], U_F)` (FS-131, job FS131-KCL1; module C2)

**Read aloud, against the informal claim** (V1-L0, `plans/FS103-V1-verification.md` l. 90: "If `F²` is `k`-colourable, `[k]^R`
carries an `R ⋊ U`-invariant probability `μ` on proper `k`-colourings of `Cay(R, U)`"). The five-colour chain holds this at
four colours (`SpectralChain.X4`, `InvariantColouring`, `exists_invariantColouring`, `Rigidity.invariantMeasureOnClosed_of_countable`);
this module states it at `k` colours, for the collapse, which reads `k = χ(F²) ≤ 6`.

* `Xk F k` — the proper `k`-colourings of `Cay(R, U)`; closed, measurable, stable under shifts and rotations.
* `InvColouring F k` — a translation- and rotation-invariant random proper `k`-colouring (the law `μ`).
* `xk_nonempty_of_colorable`, `exists_invColouring` — a proper `k`-colouring of `F²` gives one, over a number field.

**Route.** Each statement is its four-colour namesake with `Fin 4` replaced by `Fin k`; the four-colour proofs read no
property of `4` (`Rigidity/InvariantMeasure`: a common fixed point of the shifts on the compact space of probabilities carried by
`Xk`, then of the rotations, which normalise the shifts).

**Models.** Over `ℚ` at `k = 2`: `ℚ²` is two-colourable (the ramified stable prime above `2`), so `InvColouring ⊥ 2` is
inhabited (`nonempty_invColouring_bot`). At `k = 1` the set `Xk` is empty (`Xk_one_eq_empty`): the unit vector `1` is an edge.
-/

namespace HadwigerNelson.Collapse

open SpectralChain MeasureTheory SimpleGraph NumberField

noncomputable section

variable (F : Subfield ℝ) (k : ℕ)

/-- **`X_k(F)`**: the proper `k`-colourings of `Cay(R, U)`, `R = ℤ[U_F]`. -/
def Xk : Set (unitRing F → Fin k) := {c | ∀ x y : unitRing F, (y : ℂ) - x ∈ unitVectors F → c x ≠ c y}

/-- **An invariant random proper `k`-colouring** of `Cay(R, U)`: its law is a probability, carried by `X_k(F)`, invariant
under every translation `c ↦ c(· + y)` and every rotation `c ↦ c(u ·)`. -/
structure InvColouring where
  /-- The law of the random colouring. -/
  μ : Measure (unitRing F → Fin k)
  /-- It is a probability measure. -/
  isProb : IsProbabilityMeasure μ
  /-- It is carried by the proper colourings. -/
  carried : μ (Xk F k)ᶜ = 0
  /-- Invariant under every translation. -/
  shift_inv : ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ
  /-- Invariant under every rotation. -/
  rot_inv : ∀ u : unitVectors F, μ.map (fun c x => c (uvRing u * x)) = μ

variable {F k}

/-- A proper `k`-colouring of `F²` restricts to `Cay(R, U)`. -/
theorem xk_nonempty_of_colorable (h : ((unitDistance ℂ).induce (planeOver F)).Colorable k) : (Xk F k).Nonempty := by
  obtain ⟨C⟩ := h
  have hsub : ∀ x : unitRing F, (x : ℂ) ∈ planeOver F := fun x =>
    UnitRing.unitRingOver_le_planeOverSubring F x.2
  refine ⟨fun x => C ⟨x, hsub x⟩, fun x y hxy => C.valid ?_⟩
  show dist (x : ℂ) (y : ℂ) = 1
  rw [_root_.dist_comm, Complex.dist_eq]
  exact hxy.2

-- FS131-ICO1: `X_k(F)` as an intersection of one condition per pair (`SpectralChain.X4_eq_iInter` at `Fin k`).
private theorem Xk_eq_iInter : Xk F k = ⋂ x : unitRing F, ⋂ y : unitRing F,
    {c : unitRing F → Fin k | (y : ℂ) - x ∈ unitVectors F → c x ≠ c y} := by
  ext c
  simp [Xk]

-- FS131-ICO1: one pair's condition is a preimage of a set of pairs of colours.
private theorem setOf_pair_eq_k (x y : unitRing F) :
    {c : unitRing F → Fin k | (y : ℂ) - x ∈ unitVectors F → c x ≠ c y} =
      (fun c : unitRing F → Fin k => (c x, c y)) ⁻¹' {p | (y : ℂ) - x ∈ unitVectors F → p.1 ≠ p.2} := rfl

/-- `X_k(F)` is closed (an intersection of one clopen condition per pair). -/
theorem isClosed_Xk : IsClosed (Xk F k) := by
  rw [Xk_eq_iInter]
  exact isClosed_iInter fun x => isClosed_iInter fun y => by
    rw [setOf_pair_eq_k]
    exact IsClosed.preimage ((continuous_apply x).prodMk (continuous_apply y)) (isClosed_discrete _)

/-- `X_k(F)` is measurable when `R` is countable. -/
theorem measurableSet_Xk [Countable (unitRing F)] : MeasurableSet (Xk F k) := by
  rw [Xk_eq_iInter]
  exact MeasurableSet.iInter fun x => MeasurableSet.iInter fun y => by
    rw [setOf_pair_eq_k]
    exact ((measurable_pi_apply x).prodMk (measurable_pi_apply y)) (Set.to_countable _).measurableSet

/-- `X_k(F)` is stable under the translations. -/
theorem shift_mem_Xk (y : unitRing F) (c : unitRing F → Fin k) (hc : c ∈ Xk F k) : (fun x => c (x + y)) ∈ Xk F k :=
  fun x' y' h => hc (x' + y) (y' + y) (by
    have e : ((y' + y : unitRing F) : ℂ) - ((x' + y : unitRing F) : ℂ) = (y' : ℂ) - x' := by push_cast; ring
    rw [e]; exact h)

/-- `X_k(F)` is stable under the rotations. -/
theorem rot_mem_Xk (u : unitVectors F) (c : unitRing F → Fin k) (hc : c ∈ Xk F k) :
    (fun x => c (uvRing u * x)) ∈ Xk F k :=
  fun x' y' h => hc (uvRing u * x') (uvRing u * y') (by
    have e : ((uvRing u * y' : unitRing F) : ℂ) - ((uvRing u * x' : unitRing F) : ℂ) = (u : ℂ) * ((y' : ℂ) - x') := by
      push_cast; simp only [uvRing]; ring
    rw [e]
    exact ⟨(Chain.planeOverSubring F).mul_mem u.2.1 h.1, by rw [norm_mul, u.2.2, h.2, one_mul]⟩)

-- FS131-ICO1: the shift `c ↦ c(· + y)` and the rotation `c ↦ c(u ·)` are continuous.
private theorem continuous_shiftColK (y : unitRing F) :
    Continuous fun (c : unitRing F → Fin k) (x : unitRing F) => c (x + y) :=
  continuous_pi fun x => continuous_apply (x + y)

private theorem continuous_rotColK (u : unitVectors F) :
    Continuous fun (c : unitRing F → Fin k) (x : unitRing F) => c (uvRing u * x) :=
  continuous_pi fun x => continuous_apply (uvRing u * x)

-- FS131-ICO1: a map keeping `K` sends no measure carried by `K` off it.
private theorem map_compl_eq_zero_k {K : Set (unitRing F → Fin k)} (hmeas : MeasurableSet K)
    {g : (unitRing F → Fin k) → unitRing F → Fin k} (hg : Measurable g) (hgK : ∀ c ∈ K, g c ∈ K)
    {μ : Measure (unitRing F → Fin k)} (hμ : μ Kᶜ = 0) : (μ.map g) Kᶜ = 0 := by
  rw [Measure.map_apply hg hmeas.compl]
  exact measure_mono_null (fun c hc hcK => hc (hgK c hcK)) hμ

-- FS131-ICO1: a null set stays null under a uniform average (`Rigidity/InvariantMeasure`'s private helper).
private theorem avgMeasure_eq_zero_k {X ι : Type*} [MeasurableSpace X] (s : Finset ι) {μ : ι → Measure X} {A : Set X}
    (h : ∀ i ∈ s, μ i A = 0) : OneClass.avgMeasure s μ A = 0 := by
  rw [OneClass.avgMeasure_apply, Finset.sum_eq_zero h, mul_zero]

-- FS131-ICO1: a uniform average of measures that one map fixes is fixed by it.
private theorem avgMeasure_map_eq_k {X ι : Type*} [MeasurableSpace X] (s : Finset ι) {μ : ι → Measure X} {g : X → X}
    (hg : Measurable g) (h : ∀ i ∈ s, (μ i).map g = μ i) :
    (OneClass.avgMeasure s μ).map g = OneClass.avgMeasure s μ := by
  rw [OneClass.avgMeasure_map _ _ hg]
  unfold OneClass.avgMeasure
  congr 1
  exact Finset.sum_congr rfl h

-- FS131-ICO1: **step 1, a shift-invariant probability on `X_k(F)`** (`Rigidity.exists_shiftInvariant_on` at `Fin k`).
private theorem exists_shiftInvariant_k [Countable (unitRing F)] (hne : (Xk F k).Nonempty) :
    ∃ μ : Measure (unitRing F → Fin k), IsProbabilityMeasure μ ∧ μ (Xk F k)ᶜ = 0 ∧
      ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ := by
  obtain ⟨c₀, hc₀⟩ := hne
  suffices h : ∃ Q : ProbabilityMeasure (unitRing F → Fin k), (Q : Measure (unitRing F → Fin k)) (Xk F k)ᶜ = 0 ∧
      ∀ y : unitRing F, (Q : Measure (unitRing F → Fin k)).map (fun c x => c (x + y)) = Q by
    obtain ⟨Q, h1, h2⟩ := h
    exact ⟨Q, inferInstance, h1, h2⟩
  refine OneClass.exists_common_fixed (p := fun μ : Measure (unitRing F → Fin k) => μ (Xk F k)ᶜ = 0)
    (g := fun (y : unitRing F) (c : unitRing F → Fin k) (x : unitRing F) => c (x + y)) ?_
    ⟨⟨Measure.dirac c₀, inferInstance⟩, ?_⟩ (continuous_shiftColK (F := F)) ?_ ?_ ?_
  · refine OneClass.isClosed_setOf_of_tendsto (p := fun μ : Measure (unitRing F → Fin k) => μ (Xk F k)ᶜ = 0)
      fun L hL Q hQ h => ?_
    haveI := hL
    exact OneClass.measure_compl_eq_zero_of_tendsto hQ isClosed_Xk h
  · show (Measure.dirac c₀) (Xk F k)ᶜ = 0
    rw [Measure.dirac_apply' _ measurableSet_Xk.compl, Set.indicator_of_notMem (Set.notMem_compl_iff.2 hc₀)]
  · intro y z
    funext c x
    show c (x + y + z) = c (x + z + y)
    rw [add_right_comm]
  · intro y μ _ hμ
    exact map_compl_eq_zero_k measurableSet_Xk (continuous_shiftColK y).measurable (shift_mem_Xk y) hμ
  · intro s _ μ hμ
    exact avgMeasure_eq_zero_k s fun k hk => (hμ k hk).2

-- FS131-ICO1: **step 2, rotation averages of a shift-invariant measure** (`Rigidity.exists_rotInvariant_of_shiftInvariant`
-- at `Fin k`).
private theorem exists_rotInvariant_k [Countable (unitRing F)] (μ₀ : Measure (unitRing F → Fin k))
    (h₀ : IsProbabilityMeasure μ₀) (hK₀ : μ₀ (Xk F k)ᶜ = 0)
    (hs₀ : ∀ y : unitRing F, μ₀.map (fun c x => c (x + y)) = μ₀) :
    ∃ μ : Measure (unitRing F → Fin k), IsProbabilityMeasure μ ∧ μ (Xk F k)ᶜ = 0 ∧
      (∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ) ∧
      ∀ u : unitVectors F, μ.map (fun c x => c (uvRing u * x)) = μ := by
  suffices h : ∃ Q : ProbabilityMeasure (unitRing F → Fin k),
      ((Q : Measure (unitRing F → Fin k)) (Xk F k)ᶜ = 0 ∧
        ∀ y : unitRing F, (Q : Measure (unitRing F → Fin k)).map (fun c x => c (x + y)) = Q) ∧
      ∀ u : unitVectors F, (Q : Measure (unitRing F → Fin k)).map (fun c x => c (uvRing u * x)) = Q by
    obtain ⟨Q, ⟨h1, h2⟩, h3⟩ := h
    exact ⟨Q, inferInstance, h1, h2, h3⟩
  have hsr : ∀ (y : unitRing F) (u : unitVectors F),
      ((fun (c : unitRing F → Fin k) (x : unitRing F) => c (x + y)) ∘
        fun (c : unitRing F → Fin k) (x : unitRing F) => c (uvRing u * x)) =
      (fun (c : unitRing F → Fin k) (x : unitRing F) => c (uvRing u * x)) ∘
        fun (c : unitRing F → Fin k) (x : unitRing F) => c (x + uvRing u * y) := by
    intro y u
    funext c x
    show c (uvRing u * (x + y)) = c (uvRing u * x + uvRing u * y)
    rw [mul_add]
  refine OneClass.exists_common_fixed
    (p := fun μ : Measure (unitRing F → Fin k) => μ (Xk F k)ᶜ = 0 ∧
      ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ)
    (g := fun (u : unitVectors F) (c : unitRing F → Fin k) (x : unitRing F) => c (uvRing u * x)) ?_
    ⟨⟨μ₀, h₀⟩, hK₀, hs₀⟩ (continuous_rotColK (F := F)) ?_ ?_ ?_
  · refine OneClass.isClosed_setOf_of_tendsto (p := fun μ : Measure (unitRing F → Fin k) => μ (Xk F k)ᶜ = 0 ∧
      ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ) fun L hL Q hQ h => ?_
    haveI := hL
    exact ⟨OneClass.measure_compl_eq_zero_of_tendsto hQ isClosed_Xk (h.mono fun P hP => hP.1), fun y =>
      OneClass.map_eq_of_tendsto_of_eventually hQ (continuous_shiftColK y) (h.mono fun P hP => hP.2 y)⟩
  · intro u v
    funext c x
    show c (uvRing v * (uvRing u * x)) = c (uvRing u * (uvRing v * x))
    rw [mul_left_comm]
  · intro u μ _ hμ
    refine ⟨map_compl_eq_zero_k measurableSet_Xk (continuous_rotColK u).measurable (rot_mem_Xk u) hμ.1, fun y => ?_⟩
    rw [Measure.map_map (continuous_shiftColK y).measurable (continuous_rotColK u).measurable, hsr y u,
      ← Measure.map_map (continuous_rotColK u).measurable (continuous_shiftColK _).measurable, hμ.2]
  · intro s _ μ hμ
    exact ⟨avgMeasure_eq_zero_k s fun k hk => (hμ k hk).2.1, fun y =>
      avgMeasure_map_eq_k s (continuous_shiftColK y).measurable fun k hk => (hμ k hk).2.2 y⟩

/-- **An invariant colouring exists** over a number field as soon as `X_k(F)` is not empty (V1-L0; the four-colour
`exists_invariantColouring` with `invariantMeasureOnClosed_of_countable`, at `Fin k`). -/
theorem exists_invColouring [NumberField F] (h : (Xk F k).Nonempty) : Nonempty (InvColouring F k) := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  obtain ⟨μ₀, h₀, hK₀, hs₀⟩ := exists_shiftInvariant_k h
  obtain ⟨μ, hp, hK, hs, hr⟩ := exists_rotInvariant_k μ₀ h₀ hK₀ hs₀
  exact ⟨⟨μ, hp, hK, hs, hr⟩⟩

/-- **A proper `k`-colouring of `F²` gives an invariant one** of `Cay(R, U)`. -/
theorem nonempty_invColouring_of_colorable [NumberField F]
    (h : ((unitDistance ℂ).induce (planeOver F)).Colorable k) : Nonempty (InvColouring F k) :=
  exists_invColouring (xk_nonempty_of_colorable h)

/-! ## Models -/

/-- **The model**: over `ℚ`, an invariant random two-colouring (`ℚ²` is two-colourable at its ramified stable prime above
`2`). -/
theorem nonempty_invColouring_bot : Nonempty (InvColouring (⊥ : Subfield ℝ) 2) := by
  haveI := Rigidity.numberField_bot
  obtain ⟨P, -, hram⟩ := UpperHalf.exists_stablePrime_rat
  exact nonempty_invColouring_of_colorable (UpperHalf.colorable_two_planeOver_of_ramified P hram)

/-- **The adversary**: no proper one-colouring of `Cay(R, U)` (the pair `0, 1` is an edge). -/
theorem Xk_one_eq_empty : Xk F 1 = ∅ := by
  refine Set.eq_empty_of_forall_notMem fun c hc => hc 0 1 ?_ (Subsingleton.elim _ _)
  show ((1 : unitRing F) : ℂ) - ((0 : unitRing F) : ℂ) ∈ unitVectors F
  push_cast
  rw [sub_zero]
  exact ⟨(Chain.planeOverSubring F).one_mem, by simp⟩

/-! ## Spec -/

-- a one-colouring is never proper: `Xk` would drift if properness were dropped.
example : Xk F 1 = ∅ := Xk_one_eq_empty

end

end HadwigerNelson.Collapse
