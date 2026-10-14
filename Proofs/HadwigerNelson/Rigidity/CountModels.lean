import Proofs.HadwigerNelson.Rigidity.CountDescent
import Proofs.HadwigerNelson.Instances.UpperHalfValues

/-!
# The count's hypotheses inhabited at `F = ℚ` (FS-131, job FS131-ICM1; module M12's model)

**Read aloud.** Every theorem of `Rigidity/CountExtension` takes an invariant random four-colouring `μ` of `Cay(R, U)`
(`InvariantColouring F`), a trace spectral measure `σ` of it (`IsTraceSpectral F μ.μ σ`) and the clause `σ (T + A)ᶜ = 0`.
Here all three hold at once over the rationals (`F = ⊥`):

* `exists_invariantColouring_rat` — **the model**: at the stable prime `P` of `ℚ(i)` above `2` (`exists_stablePrime_rat`,
  ramified: conjugation is the identity on `𝓞 ⧸ P`) every unit vector has residue `1`, since its residue `ρ(u)` has
  `ρ(u)² = ρ(u)·ρ(ū) = 1` in a field of characteristic `2`. So the residue of `R` lies in `{0, 1}`, the bit `b(x)` of `x`
  is additive and rotation-invariant, and `b(x + u) = b(x) + 1` at every unit vector `u`. The law `μ = ½(δ_{c₀} + δ_{c₁})`
  of the two colourings `c_s(x) = b(x) + s` is carried by the proper four-colourings and invariant under every
  translation (which permutes `c₀`, `c₁`) and every rotation (which fixes both); its correlation is `1` where `b(y) = 0`
  and `−1/3` elsewhere, so `σ = ⅓ δ₁ + ⅔ δ_χ`, `χ(y) = (−1)^{b(y)}`, is a trace spectral measure, and both atoms are
  `2`-torsion characters, so `σ (T + A)ᶜ = 0`.
* `not_r88TCA_rat` — the count's conclusion fails at `ℚ` (`(chainInterface ⊥).R88TCA` is false); with the count
  (`count_of_oneAvoidingDensityBound`) this says that `TCA ℚ` fails given the density bound, as it does outright at the
  ramified prime `(1 + i)` (ratio `1/2`, `Rigidity/ClassRatio`'s docstring).

**Not claimed:** anything new; this is the gate's model (`LEAN.md` § The gate) for `CountExtension` and `CountDescent`.
-/

namespace HadwigerNelson.Rigidity.Counting

open SpectralChain NumberField MeasureTheory UpperHalf

noncomputable section

-- FS131-ICM1: the dyadic stable prime of `ℚ(i)`, with its two clauses.
private def P₀ : StablePrime (⊥ : Subfield ℝ) := exists_stablePrime_rat.choose

private theorem two_mem_P₀ : (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P₀.P := exists_stablePrime_rat.choose_spec.1

private theorem ram_P₀ : ∀ x : 𝓞 (fieldI (⊥ : Subfield ℝ)), conjO ⊥ x - x ∈ P₀.P :=
  exists_stablePrime_rat.choose_spec.2

private theorem countable_unitRing_bot : Countable (unitRing (⊥ : Subfield ℝ)) := by
  haveI : Countable (⊥ : Subfield ℝ) := Finsupp.Countable.of_moduleFinite (R := ℚ) (M := (⊥ : Subfield ℝ))
  exact countable_unitRing

/-- The residue of `R` at the dyadic stable prime of `ℚ(i)`. -/
private def ρ : unitRing (⊥ : Subfield ℝ) →+* 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P₀.P ^ 1 := resR P₀ 1

private theorem quotientMap_conj_eq (y : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P₀.P ^ 1) :
    Ideal.quotientMap (P₀.P ^ 1) (conjO ⊥) (P₀.le_comap 1) y = y := by
  obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective y
  rw [Ideal.quotientMap_mk, Ideal.Quotient.eq, pow_one]
  exact ram_P₀ x

private theorem two_eq_zero : (2 : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P₀.P ^ 1) = 0 := by
  rw [show (2 : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P₀.P ^ 1) = Ideal.Quotient.mk _ 2 from (map_ofNat _ 2).symm,
    Ideal.Quotient.eq_zero_iff_mem, pow_one]
  exact two_mem_P₀

private theorem isPrime_pow_one : (P₀.P ^ 1).IsPrime := by rw [pow_one]; exact P₀.isMaximal.isPrime

private theorem one_ne_zero_quot : (1 : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P₀.P ^ 1) ≠ 0 := by
  haveI := isPrime_pow_one
  exact one_ne_zero

private theorem eq_one_of_sq_eq_one {y : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P₀.P ^ 1} (h : y * y = 1) : y = 1 := by
  haveI := isPrime_pow_one
  have h0 : (y - 1) * (y - 1) = 0 := by linear_combination h + (1 - y) * two_eq_zero
  have := mul_self_eq_zero.1 h0
  exact sub_eq_zero.1 this

-- FS131-ICM1: every unit vector has residue `1`.
private theorem ρ_unit {u : unitRing (⊥ : Subfield ℝ)} (hu : u ∈ unitVectorsR (⊥ : Subfield ℝ)) : ρ u = 1 := by
  have hx : ofUnitRing ⊥ u ∈ normOneL ⊥ := (mem_normOneL_iff ⊥).2 hu
  have hn : P₀.residue 1 (toLocal P₀ u) *
      Ideal.quotientMap (P₀.P ^ 1) (conjO ⊥) (P₀.le_comap 1) (P₀.residue 1 (toLocal P₀ u)) = 1 := by
    rw [← UpperHalf.residue_conj, ← map_mul, ← map_one (P₀.residue 1)]
    congr 1
    exact Subtype.ext hx
  rw [quotientMap_conj_eq] at hn
  exact eq_one_of_sq_eq_one hn

-- FS131-ICM1: the residue of `R` lies in `{0, 1}` (the unit vectors generate `R`).
private theorem ρ_dichotomy (x : unitRing (⊥ : Subfield ℝ)) : ρ x = 0 ∨ ρ x = 1 := by
  have h11 : (1 : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P₀.P ^ 1) + 1 = 0 := by rw [one_add_one_eq_two, two_eq_zero]
  have key : ∀ (z : ℂ) (hz : z ∈ unitRing (⊥ : Subfield ℝ)),
      ρ ⟨z, hz⟩ = 0 ∨ ρ ⟨z, hz⟩ = 1 := by
    intro z hz
    induction hz using Subring.closure_induction with
    | mem z hz => exact Or.inr (ρ_unit (u := ⟨z, Subring.subset_closure hz⟩) (show z ∈ unitVectors ⊥ from hz))
    | zero => exact Or.inl (map_zero ρ)
    | one => exact Or.inr (map_one ρ)
    | add a b ha hb iha ihb =>
      rw [show (⟨a + b, add_mem ha hb⟩ : unitRing (⊥ : Subfield ℝ)) = ⟨a, ha⟩ + ⟨b, hb⟩ from Subtype.ext rfl,
        map_add]
      rcases iha with h1 | h1 <;> rcases ihb with h2 | h2 <;> rw [h1, h2]
      · exact Or.inl (add_zero 0)
      · exact Or.inr (zero_add 1)
      · exact Or.inr (add_zero 1)
      · exact Or.inl h11
    | neg a ha ih =>
      rw [show (⟨-a, neg_mem ha⟩ : unitRing (⊥ : Subfield ℝ)) = -⟨a, ha⟩ from Subtype.ext rfl, map_neg]
      rcases ih with h | h <;> rw [h]
      · exact Or.inl neg_zero
      · exact Or.inr (by linear_combination (-1 : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P₀.P ^ 1) * h11)
    | mul a b ha hb iha ihb =>
      rw [show (⟨a * b, mul_mem ha hb⟩ : unitRing (⊥ : Subfield ℝ)) = ⟨a, ha⟩ * ⟨b, hb⟩ from Subtype.ext rfl,
        map_mul]
      rcases iha with h1 | h1 <;> rcases ihb with h2 | h2 <;> rw [h1, h2]
      · exact Or.inl (mul_zero 0)
      · exact Or.inl (zero_mul 1)
      · exact Or.inl (mul_zero 1)
      · exact Or.inr (mul_one 1)
  exact key x.1 x.2

open Classical in
/-- The bit of `x ∈ R`: its residue at the dyadic prime, read in `ZMod 2`. -/
private def bit (x : unitRing (⊥ : Subfield ℝ)) : ZMod 2 := if ρ x = 0 then 0 else 1

private theorem bit_add (x y : unitRing (⊥ : Subfield ℝ)) : bit (x + y) = bit x + bit y := by
  have hxy : ρ (x + y) = ρ x + ρ y := map_add ρ x y
  have h11 : (1 : 𝓞 (fieldI (⊥ : Subfield ℝ)) ⧸ P₀.P ^ 1) + 1 = 0 := by rw [one_add_one_eq_two, two_eq_zero]
  have h10 := one_ne_zero_quot
  rcases ρ_dichotomy x with hx | hx <;> rcases ρ_dichotomy y with hy | hy <;>
    simp only [bit, hxy, hx, hy, add_zero, zero_add, h11, h10, if_true, if_false]
  all_goals decide

private theorem bit_zero : bit 0 = 0 := by simp [bit, map_zero]

private theorem bit_unit {u : unitRing (⊥ : Subfield ℝ)} (hu : u ∈ unitVectorsR (⊥ : Subfield ℝ)) : bit u = 1 := by
  simp [bit, ρ_unit hu, one_ne_zero_quot]

private theorem bit_mul_unit {u : unitRing (⊥ : Subfield ℝ)} (hu : u ∈ unitVectorsR (⊥ : Subfield ℝ))
    (x : unitRing (⊥ : Subfield ℝ)) : bit (u * x) = bit x := by
  unfold bit
  rw [map_mul, ρ_unit hu, one_mul]

/-- The bit, as an additive map. -/
private def bitHom : unitRing (⊥ : Subfield ℝ) →+ ZMod 2 where
  toFun := bit
  map_zero' := bit_zero
  map_add' := bit_add

/-- The two colourings `c_s(x) = b(x) + s`, read in `Fin 4`. -/
private def col (s : ZMod 2) (x : unitRing (⊥ : Subfield ℝ)) : Fin 4 := if bit x + s = 0 then 0 else 1

private theorem col_shift (s : ZMod 2) (y : unitRing (⊥ : Subfield ℝ)) :
    (fun x => col s (x + y)) = col (s + bit y) := by
  funext x
  simp only [col, bit_add]
  rw [show bit x + bit y + s = bit x + (s + bit y) by ring]

private theorem col_rot (s : ZMod 2) (u : unitVectors (⊥ : Subfield ℝ)) :
    (fun x => col s (uvRing u * x)) = col s := by
  funext x
  simp only [col, bit_mul_unit (u := uvRing u) u.2]

private theorem col_mem_X4 (s : ZMod 2) : col s ∈ X4 (⊥ : Subfield ℝ) := by
  intro x y hxy
  have hu : y - x ∈ unitVectorsR (⊥ : Subfield ℝ) := by
    show ((y - x : unitRing (⊥ : Subfield ℝ)) : ℂ) ∈ unitVectors ⊥
    simpa using hxy
  have hb : bit y = bit x + 1 := by
    rw [show y = x + (y - x) by abel, bit_add, bit_unit hu]
  simp only [col, hb]
  have key : ∀ a b : ZMod 2, (if a + b = 0 then (0 : Fin 4) else 1) ≠ if a + 1 + b = 0 then 0 else 1 := by decide
  exact key _ _

private theorem two_cases (b : ZMod 2) : b = 0 ∨ b = 1 := by
  fin_cases b
  · exact Or.inl rfl
  · exact Or.inr rfl

/-- The law `½(δ_{c₀} + δ_{c₁})`. -/
private def μ₀ : Measure (unitRing (⊥ : Subfield ℝ) → Fin 4) := (2⁻¹ : ENNReal) • (Measure.dirac (col 0) + Measure.dirac (col 1))

private theorem map_μ₀ {T : (unitRing (⊥ : Subfield ℝ) → Fin 4) → (unitRing (⊥ : Subfield ℝ) → Fin 4)}
    (hT : Measurable T) : μ₀.map T = (2⁻¹ : ENNReal) • (Measure.dirac (T (col 0)) + Measure.dirac (T (col 1))) := by
  haveI := countable_unitRing_bot
  rw [μ₀, Measure.map_smul, Measure.map_add _ _ hT, Measure.map_dirac, Measure.map_dirac]

/-- **The model's colouring**: an invariant random proper four-colouring of `Cay(R, U)` over `ℚ`. -/
def ratColouring : InvariantColouring (⊥ : Subfield ℝ) where
  μ := μ₀
  isProb := by
    constructor
    rw [μ₀, Measure.smul_apply, Measure.add_apply, measure_univ, measure_univ, one_add_one_eq_two, smul_eq_mul,
      ENNReal.inv_mul_cancel two_ne_zero ENNReal.ofNat_ne_top]
  carried := by
    haveI := countable_unitRing_bot
    rw [μ₀, Measure.smul_apply, Measure.add_apply, Measure.dirac_apply, Measure.dirac_apply,
      Set.indicator_of_notMem (show col 0 ∉ (X4 ⊥)ᶜ from not_not_intro (col_mem_X4 0)),
      Set.indicator_of_notMem (show col 1 ∉ (X4 ⊥)ᶜ from not_not_intro (col_mem_X4 1)),
      add_zero, smul_zero]
  shift_inv y := by
    have hT : Measurable (fun (c : unitRing (⊥ : Subfield ℝ) → Fin 4) x => c (x + y)) :=
      measurable_pi_lambda _ fun x => measurable_pi_apply (x + y)
    rw [map_μ₀ hT]
    show _ = μ₀
    rw [col_shift, col_shift, μ₀]
    rcases two_cases (bit y) with h | h <;> rw [h]
    · rw [add_zero, add_zero]
    · rw [zero_add, show (1 : ZMod 2) + 1 = 0 from rfl, add_comm (Measure.dirac (col 1))]
  rot_inv u := by
    have hT : Measurable (fun (c : unitRing (⊥ : Subfield ℝ) → Fin 4) x => c (uvRing u * x)) :=
      measurable_pi_lambda _ fun x => measurable_pi_apply (uvRing u * x)
    rw [map_μ₀ hT]
    show _ = μ₀
    rw [col_rot, col_rot, μ₀]

/-- The character `χ(y) = (−1)^{b(y)}`. -/
private def χ₀ : Dual (⊥ : Subfield ℝ) := (ZMod.toCircle (N := 2)).compAddMonoidHom bitHom

private theorem χ₀_apply (y : unitRing (⊥ : Subfield ℝ)) :
    ((χ₀ y : Circle) : ℂ) = if bit y = 0 then 1 else -1 := by
  show ((ZMod.toCircle (bit y) : Circle) : ℂ) = _
  rcases two_cases (bit y) with h | h <;> rw [h]
  · simp
  · rw [ZMod.toCircle_apply]
    simp only [if_neg (show (1 : ZMod 2) ≠ 0 by decide)]
    rw [show ((1 : ZMod 2).val : ℂ) = 1 from by simp [ZMod.val_one], mul_one,
      show 2 * (Real.pi : ℂ) * Complex.I / ((2 : ℕ) : ℂ) = Real.pi * Complex.I by push_cast; ring,
      Complex.exp_pi_mul_I]

private theorem χ₀_mem_TA : χ₀ ∈ TA (⊥ : Subfield ℝ) := by
  refine Set.mem_mul.mpr ⟨χ₀, ⟨2, two_ne_zero, ?_⟩, 1, ⟨0, fun r => by simp⟩, mul_one χ₀⟩
  ext y
  rw [AddChar.pow_apply, AddChar.one_apply]
  rw [Circle.coe_pow, χ₀_apply]
  split_ifs <;> simp

-- FS131-ICM1: the characters of `R` over `ℚ` have measurable points (`R` is countable).
private theorem measurableSet_singleton_dual (a : Dual (⊥ : Subfield ℝ)) : MeasurableSet ({a} : Set _) := by
  haveI := countable_unitRing_bot
  refine MeasurableSpace.measurableSet_comap.2 ⟨{fun g => ((a g : Circle) : ℂ)}, measurableSet_singleton _, ?_⟩
  ext χ
  simp only [Set.mem_preimage, Set.mem_singleton_iff]
  constructor
  · intro h
    ext g
    exact congrFun h g
  · rintro rfl
    rfl

private theorem dirac_TA_compl {a : Dual (⊥ : Subfield ℝ)} (ha : a ∈ TA (⊥ : Subfield ℝ)) :
    Measure.dirac a (TA (⊥ : Subfield ℝ))ᶜ = 0 := by
  have hsub : (TA (⊥ : Subfield ℝ))ᶜ ⊆ ({a} : Set _)ᶜ := fun χ hχ h => hχ ((Set.mem_singleton_iff.1 h) ▸ ha)
  refine le_antisymm ((measure_mono hsub).trans (le_of_eq ?_)) zero_le
  rw [Measure.dirac_apply' a (measurableSet_singleton_dual a).compl, Set.indicator_of_notMem (by simp)]

/-- The trace spectral measure `⅓ δ₁ + ⅔ δ_χ`. -/
private def σ₀ : Measure (Dual (⊥ : Subfield ℝ)) :=
  (3⁻¹ : ENNReal) • Measure.dirac 1 + (2 / 3 : ENNReal) • Measure.dirac χ₀

private theorem tetra_col (s : ZMod 2) (y : unitRing (⊥ : Subfield ℝ)) :
    tetra (col s 0) (col s y) = if bit y = 0 then 1 else -1 / 3 := by
  have key : ∀ a b : ZMod 2, ((if 0 + a = 0 then (0 : Fin 4) else 1) = if b + a = 0 then 0 else 1) ↔ b = 0 := by
    decide
  have e : (col s 0 = col s y) ↔ bit y = 0 := by
    unfold col
    rw [bit_zero]
    exact key s (bit y)
  unfold tetra
  simp only [e]

private theorem corr_ratColouring (y : unitRing (⊥ : Subfield ℝ)) :
    corr ⊥ ratColouring.μ y = if bit y = 0 then 1 else -1 / 3 := by
  haveI := countable_unitRing_bot
  have hint : ∀ s : ZMod 2, Integrable (fun c : unitRing (⊥ : Subfield ℝ) → Fin 4 => tetra (c 0) (c y))
      (Measure.dirac (col s)) := fun s => integrable_dirac (by simp)
  show ∫ c, tetra (c 0) (c y) ∂μ₀ = _
  rw [μ₀, integral_smul_measure, integral_add_measure (hint 0) (hint 1), integral_dirac, integral_dirac]
  rw [tetra_col, tetra_col, smul_eq_mul, ← two_mul, ← mul_assoc, ENNReal.toReal_inv, ENNReal.toReal_ofNat,
    inv_mul_cancel₀ two_ne_zero, one_mul]

/-- **The count's hypotheses inhabited at `F = ℚ`**: an invariant random proper four-colouring of `Cay(R, U)` over `ℚ`
with a trace spectral measure carried by `T + A` — the hypotheses `(μ : InvariantColouring F)`, `IsTraceSpectral F μ.μ σ`
and `σ (TA F)ᶜ = 0` of `measure_ne_eq`, `tendsto_measure_ne`, `exists_extension` and `exists_slice`, at once. -/
theorem exists_invariantColouring_rat :
    ∃ (μ : InvariantColouring (⊥ : Subfield ℝ)) (σ : Measure (Dual (⊥ : Subfield ℝ))),
      IsTraceSpectral ⊥ μ.μ σ ∧ σ (TA (⊥ : Subfield ℝ))ᶜ = 0 := by
  haveI := countable_unitRing_bot
  refine ⟨ratColouring, σ₀, ⟨?_, fun y => ?_⟩, ?_⟩
  · refine ⟨?_⟩
    rw [σ₀, Measure.add_apply, Measure.smul_apply, Measure.smul_apply, measure_univ, measure_univ, smul_eq_mul,
      smul_eq_mul, mul_one, mul_one]
    exact ENNReal.add_lt_top.2 ⟨ENNReal.inv_lt_top.2 (by norm_num), ENNReal.div_lt_top (by norm_num) (by norm_num)⟩
  · have hm : ∀ a : Dual (⊥ : Subfield ℝ), MeasurableSingletonClass (Dual (⊥ : Subfield ℝ)) :=
      fun _ => ⟨measurableSet_singleton_dual⟩
    haveI := hm 1
    have hint : ∀ a : Dual (⊥ : Subfield ℝ), Integrable (fun χ : Dual (⊥ : Subfield ℝ) => ((χ y : Circle) : ℂ))
        (Measure.dirac a) := fun a => integrable_dirac (by simp)
    rw [σ₀, integral_add_measure ((hint 1).smul_measure (by simp)) ((hint χ₀).smul_measure (ENNReal.div_lt_top (by norm_num) (by norm_num)).ne),
      integral_smul_measure, integral_smul_measure, integral_dirac, integral_dirac, corr_ratColouring, χ₀_apply]
    rcases two_cases (bit y) with h | h <;> simp [h] <;> norm_num
  · rw [σ₀, Measure.add_apply, Measure.smul_apply, Measure.smul_apply, dirac_TA_compl (one_mem_TA ⊥),
      dirac_TA_compl χ₀_mem_TA, smul_zero, smul_zero, add_zero]

/-- **The count's conclusion fails at `ℚ`**: some invariant colouring over `ℚ` has its spectrum on `T + A`. -/
theorem not_r88TCA_rat : ¬ (chainInterface (⊥ : Subfield ℝ)).R88TCA := fun h =>
  let ⟨μ, σ, hσ, hTA⟩ := exists_invariantColouring_rat
  h μ σ hσ hTA

/-! ## Spec examples -/

-- the model's correlation at the unit vector `1` is `−1/3`: its two colourings change colour along every unit edge
example : corr ⊥ ratColouring.μ 1 = -1 / 3 := by
  have hu : (1 : unitRing (⊥ : Subfield ℝ)) ∈ unitVectorsR (⊥ : Subfield ℝ) := by
    show ((1 : unitRing (⊥ : Subfield ℝ)) : ℂ) ∈ unitVectors ⊥
    exact ⟨⟨by simp, by simp⟩, by simp⟩
  rw [corr_ratColouring, bit_unit hu, if_neg (by decide)]

-- the model feeds the count's slice
example : ∃ φ : ℂ × K (⊥ : Subfield ℝ) → Fin 4, Measurable φ ∧ SliceEdgeNull φ :=
  let ⟨μ, _, hσ, hTA⟩ := exists_invariantColouring_rat
  exists_slice μ hσ hTA

-- given the density bound, the count and the model refute `TCA ℚ`
example (hOA : Plane.OneAvoidingDensityBound) : ¬ TCA (⊥ : Subfield ℝ) := fun hT =>
  not_r88TCA_rat (count_of_oneAvoidingDensityBound hOA hT)

end

end HadwigerNelson.Rigidity.Counting
