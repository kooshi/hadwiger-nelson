import Proofs.HadwigerNelson.Rigidity.ChainAtTA

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain

open scoped Pointwise

section TAMeasurable

variable {G : Type*} [AddCommGroup G]

/-- (i) of `measurableSet_TA`'s route: a character is a torsion character times an archimedean one exactly when one of
its non-zero powers is archimedean (`⇐`: divide the lift by the power). -/
theorem mem_torsion_mul_arch_iff' (χ : AddChar G Circle) :
    χ ∈ torsionChars G * archChars G ↔ ∃ N : ℕ, N ≠ 0 ∧ χ ^ N ∈ archChars G := by
  constructor
  · rintro ⟨t, ⟨N, hN, ht⟩, a, ⟨ψ, hψ⟩, rfl⟩
    refine ⟨N, hN, N • ψ, fun r => ?_⟩
    rw [mul_pow, ht, one_mul, AddChar.pow_apply, hψ, AddMonoidHom.nsmul_apply, Circle.exp_nsmul]
  · rintro ⟨N, hN, ψ, hψ⟩
    have hN' : (N : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hN
    let ψ' : G →+ ℝ := AddMonoidHom.mk' (fun r => ψ r / N) fun x y => by rw [map_add, add_div]
    let a : AddChar G Circle :=
      { toFun := fun r => Circle.exp (ψ' r)
        map_zero_eq_one' := by rw [map_zero, Circle.exp_zero]
        map_add_eq_mul' := fun x y => by rw [map_add, Circle.exp_add] }
    have ha : ∀ r, a r ^ N = χ r ^ N := by
      intro r
      have h1 : (χ ^ N) r = Circle.exp (ψ r) := hψ r
      rw [AddChar.pow_apply] at h1
      rw [h1]
      show Circle.exp (ψ r / N) ^ N = Circle.exp (ψ r)
      rw [← Circle.exp_nsmul, nsmul_eq_mul, mul_div_cancel₀ _ hN']
    refine Set.mem_mul.mpr ⟨χ * a⁻¹, ⟨N, hN, ?_⟩, a, ⟨ψ', fun r => rfl⟩, inv_mul_cancel_right χ a⟩
    refine AddChar.ext _ _ fun r => ?_
    rw [AddChar.pow_apply, AddChar.mul_apply, AddChar.inv_apply', mul_pow, inv_pow, ha r, mul_inv_cancel,
      AddChar.one_apply]

/-- An additive map to `ℝ` that vanishes on `s` vanishes at every `g` whose image lies in the `ℚ`-span of the image of
`s` (a multiple of `g` lies in the subgroup `s` generates, and `ℝ` has no torsion). -/
theorem eq_zero_of_mem_span' {W : Type*} [AddCommGroup W] [Module ℚ W] (ι : G →+ W) (hι : Function.Injective ι)
    (Δ : G →+ ℝ) {s : Set G} (hs : ∀ g ∈ s, Δ g = 0) {g : G}
    (hg : ι g ∈ Submodule.span ℚ (ι '' s)) : Δ g = 0 := by
  have key : ∀ x ∈ Submodule.span ℚ (ι '' s),
      ∃ m : ℕ, m ≠ 0 ∧ ∃ y ∈ AddSubgroup.closure s, ι y = m • x := by
    intro x hx
    induction hx using Submodule.span_induction with
    | mem x hx =>
      obtain ⟨g', hg', rfl⟩ := hx
      exact ⟨1, one_ne_zero, g', AddSubgroup.subset_closure hg', (one_nsmul _).symm⟩
    | zero => exact ⟨1, one_ne_zero, 0, zero_mem _, by simp⟩
    | add x₁ x₂ _ _ h₁ h₂ =>
      obtain ⟨m₁, hm₁, y₁, hy₁, e₁⟩ := h₁
      obtain ⟨m₂, hm₂, y₂, hy₂, e₂⟩ := h₂
      refine ⟨m₁ * m₂, mul_ne_zero hm₁ hm₂, m₂ • y₁ + m₁ • y₂,
        add_mem (nsmul_mem hy₁ _) (nsmul_mem hy₂ _), ?_⟩
      rw [map_add, map_nsmul, map_nsmul, e₁, e₂, smul_add, ← mul_nsmul, ← mul_nsmul, mul_comm m₂ m₁]
    | smul c x _ h =>
      obtain ⟨m, hm, y, hy, e⟩ := h
      refine ⟨c.den * m, mul_ne_zero c.den_nz hm, c.num • y, zsmul_mem hy _, ?_⟩
      rw [map_zsmul, e, ← Int.cast_smul_eq_zsmul ℚ, ← Nat.cast_smul_eq_nsmul ℚ, ← Nat.cast_smul_eq_nsmul ℚ,
        smul_smul, smul_smul]
      congr 1
      rw [← Rat.den_mul_eq_num c]
      push_cast
      ring
  have hcl : ∀ y ∈ AddSubgroup.closure s, Δ y = 0 := by
    intro y hy
    induction hy using AddSubgroup.closure_induction with
    | mem x hx => exact hs x hx
    | zero => exact map_zero Δ
    | add x y _ _ hx hy => rw [map_add, hx, hy, add_zero]
    | neg x _ hx => rw [map_neg, hx, neg_zero]
  obtain ⟨m, hm, y, hy, e⟩ := key _ hg
  rw [← map_nsmul] at e
  have hy0 := hcl y hy
  rw [hι e, map_nsmul, nsmul_eq_mul] at hy0
  exact (mul_eq_zero.mp hy0).resolve_left (Nat.cast_ne_zero.mpr hm)

/-- **Rational coordinates for an additive map to `ℝ`**: if `G` embeds additively in a finite-dimensional `ℚ`-vector
space, there are finitely many additive coordinates `q j : G →+ ℚ` such that every additive `ψ : G → ℝ` is
`∑ j, q j · t j` for some real `t` — `t j` is `ψ` at the `j`-th member of a `ℚ`-basis of the span of `G` chosen inside
`G`. -/
theorem exists_rat_coords'.{u} {W : Type u} [AddCommGroup W] [Module ℚ W] [FiniteDimensional ℚ W] (ι : G →+ W)
    (hι : Function.Injective ι) :
    ∃ (κ : Type u) (_ : Fintype κ) (q : κ → G →+ ℚ),
      ∀ ψ : G →+ ℝ, ∃ t : κ → ℝ, ∀ g, ψ g = ∑ j, (q j g : ℝ) * t j := by
  classical
  obtain ⟨b, hbS, hspan, hli⟩ := exists_linearIndependent ℚ (Set.range ι)
  haveI : Finite b := hli.finite
  letI : Fintype b := Fintype.ofFinite b
  set V := Submodule.span ℚ (Set.range ((↑) : b → W)) with hV
  have hrange : Set.range ((↑) : b → W) = b := Subtype.range_coe
  have hmem : ∀ g, ι g ∈ V := fun g => by
    rw [hV, hrange, hspan]
    exact Submodule.subset_span ⟨g, rfl⟩
  let B : Module.Basis b ℚ V := Module.Basis.span hli
  let c : G →+ V :=
    { toFun := fun g => ⟨ι g, hmem g⟩
      map_zero' := by ext; simp
      map_add' := fun x y => by ext; simp }
  let q : b → G →+ ℚ := fun j => (B.coord j).toAddMonoidHom.comp c
  refine ⟨b, inferInstance, q, fun ψ => ?_⟩
  have hgen : ∀ i : b, ∃ g, ι g = i := fun i => hbS i.2
  choose gen hgen using hgen
  refine ⟨fun j => ψ (gen j), fun g => ?_⟩
  let Δ : G →+ ℝ := ψ - ∑ j, ψ (gen j) • ((Rat.castHom ℝ).toAddMonoidHom.comp (q j))
  have hΔ : ∀ g, Δ g = ψ g - ∑ j, (q j g : ℝ) * ψ (gen j) := by
    intro g
    simp only [Δ, AddMonoidHom.sub_apply, AddMonoidHom.finsetSum_apply, AddMonoidHom.smul_apply,
      AddMonoidHom.comp_apply, smul_eq_mul]
    congr 1
    refine Finset.sum_congr rfl fun j _ => ?_
    simp [mul_comm]
  have hcgen : ∀ i, c (gen i) = B i := by
    intro i
    apply Subtype.ext
    change ι (gen i) = ((Module.Basis.span hli i : V) : W)
    rw [Module.Basis.coe_span_apply, hgen i]
  have hs : ∀ g ∈ Set.range gen, Δ g = 0 := by
    rintro _ ⟨i, rfl⟩
    rw [hΔ, sub_eq_zero]
    have hq : ∀ j, q j (gen i) = if i = j then 1 else 0 := by
      intro j
      simp only [q, AddMonoidHom.comp_apply, LinearMap.toAddMonoidHom_coe, hcgen, Module.Basis.coord_apply,
        Module.Basis.repr_self, Finsupp.single_apply]
    have hq' : ∀ j, ((q j (gen i) : ℚ) : ℝ) = if i = j then 1 else 0 := by
      intro j
      rw [hq j]
      split_ifs <;> simp
    simp only [hq', ite_mul, one_mul, zero_mul, Finset.sum_ite_eq, Finset.mem_univ, if_true]
  have himage : ι '' Set.range gen = b := by
    ext w
    constructor
    · rintro ⟨_, ⟨i, rfl⟩, rfl⟩
      rw [hgen i]
      exact i.2
    · intro hw
      exact ⟨gen ⟨w, hw⟩, ⟨⟨w, hw⟩, rfl⟩, hgen ⟨w, hw⟩⟩
  have hg : ι g ∈ Submodule.span ℚ (ι '' Set.range gen) := by
    rw [himage, hspan]
    exact Submodule.subset_span ⟨g, rfl⟩
  have := eq_zero_of_mem_span' ι hι Δ hs hg
  rw [hΔ, sub_eq_zero] at this
  exact this

/-- **The archimedean values form a measurable set** of `G → ℂ` (product σ-algebra, `G` countable), given rational
coordinates: the set is the image of `ℝ^κ` under a continuous map, a countable union of compact images of closed
balls, each closed. -/
theorem measurableSet_archFun' [Countable G] {κ : Type*} [Fintype κ] (q : κ → G →+ ℚ)
    (hq : ∀ ψ : G →+ ℝ, ∃ t : κ → ℝ, ∀ g, ψ g = ∑ j, (q j g : ℝ) * t j) :
    MeasurableSet {f : G → ℂ | ∃ ψ : G →+ ℝ, ∀ g, f g = Circle.exp (ψ g)} := by
  let L : (κ → ℝ) → G →+ ℝ := fun t =>
    AddMonoidHom.mk' (fun g => ∑ j, (q j g : ℝ) * t j) fun g h => by
      simp only [map_add, Rat.cast_add, add_mul, Finset.sum_add_distrib]
  let Φ : (κ → ℝ) → G → ℂ := fun t g => (Circle.exp (L t g) : ℂ)
  have hΦ : Continuous Φ :=
    continuous_pi fun g => continuous_subtype_val.comp (Circle.exp.continuous.comp
      (continuous_finsetSum _ fun j _ => continuous_const.mul (continuous_apply j)))
  have hset : {f : G → ℂ | ∃ ψ : G →+ ℝ, ∀ g, f g = Circle.exp (ψ g)} =
      ⋃ k : ℕ, Φ '' Metric.closedBall 0 k := by
    ext f
    simp only [Set.mem_setOf_eq, Set.mem_iUnion, Set.mem_image]
    constructor
    · rintro ⟨ψ, hψ⟩
      obtain ⟨t, ht⟩ := hq ψ
      obtain ⟨k, hk⟩ := exists_nat_ge ‖t‖
      refine ⟨k, t, mem_closedBall_zero_iff.mpr hk, funext fun g => ?_⟩
      rw [hψ g, ht g]
      rfl
    · rintro ⟨k, t, -, rfl⟩
      exact ⟨L t, fun g => rfl⟩
  rw [hset]
  exact MeasurableSet.iUnion fun k => ((isCompact_closedBall _ _).image hΦ).isClosed.measurableSet

/-- scratch: the main theorem under another name -/
theorem measurableSet_TA' (F : Subfield ℝ) [NumberField F] : MeasurableSet (TA F) := by
  haveI : Countable F := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F)
  haveI : Countable (unitRing F) := countable_unitRing
  let ι : unitRing F →+ fieldI F :=
    { toFun := fun g => ⟨g, UnitRing.unitRingOver_le_planeOverSubring F g.2⟩
      map_zero' := rfl
      map_add' := fun _ _ => rfl }
  have hι : Function.Injective ι := fun x y h => by
    have h' := congrArg Subtype.val h
    exact Subtype.ext h'
  obtain ⟨κ, _, q, hq⟩ := exists_rat_coords' ι hι
  have hA := measurableSet_archFun' q hq
  let S : Set (unitRing F → ℂ) := ⋃ N : ℕ, ⋃ (_ : N ≠ 0),
    (fun f g => f g ^ N) ⁻¹' {f | ∃ ψ : unitRing F →+ ℝ, ∀ g, f g = Circle.exp (ψ g)}
  have hS : MeasurableSet S := MeasurableSet.iUnion fun N => MeasurableSet.iUnion fun _ =>
    (measurable_pi_lambda _ fun g => (measurable_pi_apply g).pow_const N) hA
  have hTA : TA F = (fun χ : Dual F => fun g => (χ g : ℂ)) ⁻¹' S := by
    ext χ
    rw [TA, mem_torsion_mul_arch_iff']
    simp only [S, Set.mem_preimage, Set.mem_iUnion, Set.mem_setOf_eq, archChars, exists_prop]
    refine exists_congr fun N => and_congr_right fun _ => exists_congr fun ψ => forall_congr' fun g => ?_
    rw [AddChar.pow_apply, ← Circle.coe_pow]  -- may need adjusting
    exact Circle.coe_inj.symm
  rw [hTA]
  exact ⟨S, hS, rfl⟩

end TAMeasurable

end HadwigerNelson.Rigidity

open HadwigerNelson.Rigidity in
#print axioms measurableSet_TA'
open HadwigerNelson.Rigidity in
#check @measurableSet_TA'
