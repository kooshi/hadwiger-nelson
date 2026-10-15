import Proofs.HadwigerNelson.Rigidity.PlaceSizes

/-!
# The pigeonhole's multipliers `(1 + 2bi)/(1 − 2bi)` (FS-131, job FS131-K8B1; module M8b-3a; skeleton)

The multipliers of Lemma 3.2′(a) (X01D § 3.4, `plans/FS100-X01D-derivation.md` l. 248) on the shorter height input of
FS131-KN8 (`data/fs131/claims-NF2.md` § Dated lines, 2026-10-14: "`z = 1 + 2bi` gives `α′ = 1/(2[F:ℚ])` with no Pythagorean
count").

**Read aloud.** For `b ∈ ℕ`, `v_b := (1 + 2bi)/(1 − 2bi) = ((1 − 4b²) + 4b·i)/(1 + 4b²)` (`multiplier F b`, by its coordinates):

* a unit vector of `F²`, since its coordinates are rational (`multiplier`, `coe_multiplier`);
* `b ↦ v_b` is injective (`multiplier_injective`: the real part `(1 − 4b²)/(1 + 4b²)` is strictly decreasing);
* **an isometry at every archimedean place** of `L` (`absAt_multiplier_arch`; X01D l. 248: "every `v ∈ U_ℚ ⊂ ℚ(i)` has
  modulus 1 at every archimedean place of `L`" — an embedding sends `i` to `±i`);
* **its split height is at most `(1 + 2b)^{[L:ℚ]}`** (`splitHeight_multiplier_le`): `|v_b|_w ≤ |1 − 2bi|_w⁻¹` at every
  finite place, and `∏_w |1 − 2bi|_w⁻¹ = |N(1 − 2bi)| = ∏_v v(1 − 2bi)^{mult} ≤ (1 + 2b)^{[L:ℚ]}` (the product formula for
  an integer). So the `B` multipliers `v_1, …, v_B` have heights at most `(3B)^{[L:ℚ]} =: M`, and `B = M^{1/[L:ℚ]}/3`: the
  count `#V_M ≥ c·M^{α′}` with `α′ = 1/[L:ℚ] = 1/(2[F:ℚ])`, the dated line's exponent.

**Inhabitants.** `b = 1`: `v_1 = (−3 + 4i)/5` (`multiplier_one`).
-/

namespace HadwigerNelson.Rigidity

open SpectralChain NumberField

set_option Elab.async false
noncomputable section

variable (F : Subfield ℝ) [NumberField F]

-- The instance binder is the skeleton's (it is in the stored type of `multiplier`, which this job does not change); the
-- membership reads only `F`, so the unused-section-variable linter is silenced here, not the binder dropped.
set_option linter.unusedSectionVars false in
private theorem multiplier_mem (b : ℕ) :
    (⟨(1 - 4 * (b : ℝ) ^ 2) / (1 + 4 * (b : ℝ) ^ 2), 4 * (b : ℝ) / (1 + 4 * (b : ℝ) ^ 2)⟩ : ℂ) ∈ unitVectors F := by
  have hpos : (0 : ℝ) < 1 + 4 * (b : ℝ) ^ 2 := by positivity
  have h1 : ((((1 - 4 * (b : ℚ) ^ 2) / (1 + 4 * (b : ℚ) ^ 2) : ℚ) : ℝ)) ∈ F := SubfieldClass.ratCast_mem F _
  have h2 : ((((4 * (b : ℚ)) / (1 + 4 * (b : ℚ) ^ 2) : ℚ) : ℝ)) ∈ F := SubfieldClass.ratCast_mem F _
  push_cast at h1 h2
  refine ⟨⟨h1, h2⟩, ?_⟩
  rw [Complex.norm_def, Complex.normSq_mk, Real.sqrt_eq_one]
  field_simp
  ring

#eval show Lean.Elab.Command.CommandElabM Unit from do
  let e ← Lean.getEnv
  IO.println s!"GEN 46 {e.contains `HadwigerNelson.Rigidity.SAdeleRing.congr_simp} {e.contains `HadwigerNelson.Rigidity.TateModel.congr_simp} {e.contains `HadwigerNelson.Rigidity.WPlace.absAt.congr_simp} {e.contains `HadwigerNelson.Rigidity.multiplier.congr_simp} {e.contains `HadwigerNelson.Rigidity.splitHeight.congr_simp}"

/-- **The multiplier `v_b = (1 + 2bi)/(1 − 2bi)`**, given by its coordinates `((1 − 4b²) + 4b·i)/(1 + 4b²)`. -/
def multiplier (b : ℕ) : unitVectors F :=
  ⟨⟨(1 - 4 * (b : ℝ) ^ 2) / (1 + 4 * (b : ℝ) ^ 2), 4 * (b : ℝ) / (1 + 4 * (b : ℝ) ^ 2)⟩, multiplier_mem F b⟩

example (b : ℕ) : ((multiplier F b : ℂ)).re = (1 - 4 * (b : ℝ) ^ 2) / (1 + 4 * (b : ℝ) ^ 2) := rfl

#eval show Lean.Elab.Command.CommandElabM Unit from do
  let e ← Lean.getEnv
  IO.println s!"GEN 52 {e.contains `HadwigerNelson.Rigidity.SAdeleRing.congr_simp} {e.contains `HadwigerNelson.Rigidity.TateModel.congr_simp} {e.contains `HadwigerNelson.Rigidity.WPlace.absAt.congr_simp} {e.contains `HadwigerNelson.Rigidity.multiplier.congr_simp} {e.contains `HadwigerNelson.Rigidity.splitHeight.congr_simp}"

/-- `v_b = (1 + 2bi)/(1 − 2bi)`. -/
theorem coe_multiplier (b : ℕ) :
    (multiplier F b : ℂ) = (1 + 2 * (b : ℂ) * Complex.I) / (1 - 2 * (b : ℂ) * Complex.I) := by
  have hne : (1 - 2 * (b : ℂ) * Complex.I) ≠ 0 := fun h => by
    have := congrArg Complex.re h
    simp at this
  have hpos : (0 : ℝ) < 1 + 4 * (b : ℝ) ^ 2 := by positivity
  rw [eq_div_iff hne]
  apply Complex.ext <;> simp [multiplier] <;> field_simp <;> ring

#eval show Lean.Elab.Command.CommandElabM Unit from do
  let e ← Lean.getEnv
  IO.println s!"GEN 62 {e.contains `HadwigerNelson.Rigidity.SAdeleRing.congr_simp} {e.contains `HadwigerNelson.Rigidity.TateModel.congr_simp} {e.contains `HadwigerNelson.Rigidity.WPlace.absAt.congr_simp} {e.contains `HadwigerNelson.Rigidity.multiplier.congr_simp} {e.contains `HadwigerNelson.Rigidity.splitHeight.congr_simp}"

/-- `v_1 = (−3 + 4i)/5`. -/
theorem multiplier_one : (multiplier F 1 : ℂ) = ⟨-3 / 5, 4 / 5⟩ := by
  apply Complex.ext <;> simp [multiplier] <;> norm_num

#eval show Lean.Elab.Command.CommandElabM Unit from do
  let e ← Lean.getEnv
  IO.println s!"GEN 66 {e.contains `HadwigerNelson.Rigidity.SAdeleRing.congr_simp} {e.contains `HadwigerNelson.Rigidity.TateModel.congr_simp} {e.contains `HadwigerNelson.Rigidity.WPlace.absAt.congr_simp} {e.contains `HadwigerNelson.Rigidity.multiplier.congr_simp} {e.contains `HadwigerNelson.Rigidity.splitHeight.congr_simp}"

/-- **Distinct `b` give distinct multipliers**: the real part is strictly decreasing in `b`. -/
theorem multiplier_injective : Function.Injective (multiplier F) := by
  intro a b hab
  have h := congrArg (fun z : unitVectors F => (z : ℂ).re) hab
  change (1 - 4 * (a : ℝ) ^ 2) / (1 + 4 * (a : ℝ) ^ 2) = (1 - 4 * (b : ℝ) ^ 2) / (1 + 4 * (b : ℝ) ^ 2) at h
  have ha : (0 : ℝ) < 1 + 4 * (a : ℝ) ^ 2 := by positivity
  have hb : (0 : ℝ) < 1 + 4 * (b : ℝ) ^ 2 := by positivity
  rw [div_eq_div_iff ha.ne' hb.ne'] at h
  have h2 : (a : ℝ) ^ 2 = (b : ℝ) ^ 2 := by nlinarith
  have h3 : a ^ 2 = b ^ 2 := by exact_mod_cast h2
  exact Nat.pow_left_injective two_ne_zero h3

#eval show Lean.Elab.Command.CommandElabM Unit from do
  let e ← Lean.getEnv
  IO.println s!"GEN 78 {e.contains `HadwigerNelson.Rigidity.SAdeleRing.congr_simp} {e.contains `HadwigerNelson.Rigidity.TateModel.congr_simp} {e.contains `HadwigerNelson.Rigidity.WPlace.absAt.congr_simp} {e.contains `HadwigerNelson.Rigidity.multiplier.congr_simp} {e.contains `HadwigerNelson.Rigidity.splitHeight.congr_simp}"

/-- `i` as an element of `L`. -/
private def iL : fieldI F := ⟨Complex.I, by simp [zero_mem], by simp [one_mem]⟩

omit [NumberField F] in
#eval show Lean.Elab.Command.CommandElabM Unit from do
  let e ← Lean.getEnv
  IO.println s!"GEN 82 {e.contains `HadwigerNelson.Rigidity.SAdeleRing.congr_simp} {e.contains `HadwigerNelson.Rigidity.TateModel.congr_simp} {e.contains `HadwigerNelson.Rigidity.WPlace.absAt.congr_simp} {e.contains `HadwigerNelson.Rigidity.multiplier.congr_simp} {e.contains `HadwigerNelson.Rigidity.splitHeight.congr_simp}"

/-- Every embedding of `L` sends `i` to `±i`. -/
private theorem embedding_iL (φ : fieldI F →+* ℂ) : φ (iL F) = Complex.I ∨ φ (iL F) = -Complex.I := by
  have hiL : iL F ^ 2 = -1 := Subtype.ext Complex.I_sq
  have h : φ (iL F) ^ 2 = -1 := by rw [← map_pow, hiL, map_neg, map_one]
  have h0 : (φ (iL F) - Complex.I) * (φ (iL F) + Complex.I) = 0 := by linear_combination h - Complex.I_sq
  rcases mul_eq_zero.1 h0 with h1 | h1
  · left; linear_combination h1
  · right; linear_combination h1

omit [NumberField F] in
private theorem norm_embedding_iL (φ : fieldI F →+* ℂ) : ‖φ (iL F)‖ = 1 := by
  rcases embedding_iL F φ with h | h <;> rw [h] <;> simp

#eval show Lean.Elab.Command.CommandElabM Unit from do
  let e ← Lean.getEnv
  IO.println s!"GEN 95 {e.contains `HadwigerNelson.Rigidity.SAdeleRing.congr_simp} {e.contains `HadwigerNelson.Rigidity.TateModel.congr_simp} {e.contains `HadwigerNelson.Rigidity.WPlace.absAt.congr_simp} {e.contains `HadwigerNelson.Rigidity.multiplier.congr_simp} {e.contains `HadwigerNelson.Rigidity.splitHeight.congr_simp}"

/-- **An isometry at every archimedean place of `L`** (X01D l. 248). -/
theorem absAt_multiplier_arch (v : InfinitePlace (fieldI F)) (b : ℕ) :
    (WPlace.arch v).absAt (unitL (multiplier F b)) = 1 := by
  show v (unitL (multiplier F b)) = 1
  -- `v_b` has rational coordinates `q₁ + q₂ i`, and an embedding sends `i` to `±i`
  let q₁ : ℚ := (1 - 4 * (b : ℚ) ^ 2) / (1 + 4 * (b : ℚ) ^ 2)
  let q₂ : ℚ := 4 * (b : ℚ) / (1 + 4 * (b : ℚ) ^ 2)
  have hxC : (multiplier F b : ℂ) = (q₁ : ℂ) + (q₂ : ℂ) * Complex.I := by
    apply Complex.ext <;>
      simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ratCast_re,
        Complex.ratCast_im, Complex.I_re, Complex.I_im] <;> simp [multiplier, q₁, q₂]
  have hLC : (((q₁ : fieldI F) + (q₂ : fieldI F) * iL F : fieldI F) : ℂ) = (q₁ : ℂ) + (q₂ : ℂ) * Complex.I := by
    simp [iL]
  have hx : unitL (multiplier F b) = (q₁ : fieldI F) + (q₂ : fieldI F) * iL F :=
    Subtype.ext (hxC.trans hLC.symm)
  have hn : ‖(q₁ : ℂ) + (q₂ : ℂ) * Complex.I‖ = 1 := hxC ▸ (multiplier F b).2.2
  rw [← InfinitePlace.norm_embedding_eq v, hx, map_add, map_mul, map_ratCast, map_ratCast]
  rcases embedding_iL F v.embedding with h | h
  · rw [h]; exact hn
  · rw [h, ← hn, ← Complex.norm_conj]
    congr 1
    simp

#eval show Lean.Elab.Command.CommandElabM Unit from do
  let e ← Lean.getEnv
  IO.println s!"GEN 118 {e.contains `HadwigerNelson.Rigidity.SAdeleRing.congr_simp} {e.contains `HadwigerNelson.Rigidity.TateModel.congr_simp} {e.contains `HadwigerNelson.Rigidity.WPlace.absAt.congr_simp} {e.contains `HadwigerNelson.Rigidity.multiplier.congr_simp} {e.contains `HadwigerNelson.Rigidity.splitHeight.congr_simp}"

/-- **The height of `v_b`**: `∏_{w split} max(1, |v_b|_w) ≤ (1 + 2b)^{[L:ℚ]}`. -/
theorem splitHeight_multiplier_le (b : ℕ) :
    splitHeight (unitL (multiplier F b)) ≤ (1 + 2 * (b : ℝ)) ^ Module.finrank ℚ (fieldI F) := by
  -- `v_b = z / z̄`, `z = 1 + 2b·i`, `z̄ = 1 − 2b·i`, both integral
  set x := unitL (multiplier F b) with hxdef
  set zb : fieldI F := 1 - ((2 * b : ℕ) : fieldI F) * iL F with hzb
  set z : fieldI F := 1 + ((2 * b : ℕ) : fieldI F) * iL F with hz
  have hzbC : ((zb : fieldI F) : ℂ) = 1 - 2 * (b : ℂ) * Complex.I := by
    rw [hzb]; push_cast [iL]; simp only [show ((2 : fieldI F) : ℂ) = 2 from map_ofNat (fieldI F).subtype 2]
  have hzC : ((z : fieldI F) : ℂ) = 1 + 2 * (b : ℂ) * Complex.I := by
    rw [hz]; push_cast [iL]; simp only [show ((2 : fieldI F) : ℂ) = 2 from map_ofNat (fieldI F).subtype 2]
  have hzb0C : (1 - 2 * (b : ℂ) * Complex.I) ≠ 0 := fun h => by
    have := congrArg Complex.re h
    simp at this
  have hzb0 : zb ≠ 0 := fun h => hzb0C (by rw [← hzbC, h]; rfl)
  have hxz : x * zb = z := Subtype.ext (by
    show (multiplier F b : ℂ) * ((zb : fieldI F) : ℂ) = ((z : fieldI F) : ℂ)
    rw [hzbC, hzC, coe_multiplier, div_mul_cancel₀ _ hzb0C])
  have hiInt : IsIntegral ℤ (iL F) :=
    IsIntegral.of_pow (n := 2) (by norm_num) (by rw [show iL F ^ 2 = -1 from Subtype.ext Complex.I_sq]; exact isIntegral_one.neg)
  have hzbInt : IsIntegral ℤ zb := isIntegral_one.sub ((isIntegral_natCast _).mul hiInt)
  have hzInt : IsIntegral ℤ z := isIntegral_one.add ((isIntegral_natCast _).mul hiInt)
  have habs : ∀ y : fieldI F, IsIntegral ℤ y → ∀ w : SplitPlace F, (WPlace.split w).absAt y ≤ 1 := fun y hy w =>
    FinitePlace.norm_le_one (fieldI F) w.1 (⟨y, hy⟩ : 𝓞 (fieldI F))
  have hzbO : zb ∈ stableIntegers F := by
    refine (mem_stableIntegers_iff_valuation F).2 fun v _ => ?_
    show v.valuation (fieldI F) (algebraMap (𝓞 (fieldI F)) (fieldI F) ⟨zb, hzbInt⟩) ≤ 1
    rw [IsDedekindDomain.HeightOneSpectrum.valuation_of_algebraMap]
    exact v.intValuation_le_one _
  obtain ⟨T, hT⟩ := exists_finset_absAt_le_one x
  have hPF := one_le_prod_absAt_of_mem_stableIntegers hzbO hzb0 T fun w _ => habs zb hzbInt w
  have hpos : ∀ w : SplitPlace F, 0 < (WPlace.split w).absAt zb := fun w =>
    lt_of_le_of_ne (WPlace.absAt_nonneg _ _) fun h => hzb0 ((WPlace.absAt_eq_zero _).1 h.symm)
  -- each factor: `max(1, |v_b|_w) ≤ |z̄|_w⁻¹`
  have hfac : ∀ w : SplitPlace F, max 1 ((WPlace.split w).absAt x) ≤ ((WPlace.split w).absAt zb)⁻¹ := fun w => by
    have h1 : (WPlace.split w).absAt x * (WPlace.split w).absAt zb ≤ 1 := by
      rw [← WPlace.absAt_mul, hxz]; exact habs z hzInt w
    refine max_le ((one_le_inv₀ (hpos w)).2 (habs zb hzbInt w)) ?_
    have h2 := (le_div_iff₀ (hpos w)).2 h1
    rwa [one_div] at h2
  -- the archimedean product: `v(z̄) ≤ 1 + 2b`
  have hplace : ∀ v : InfinitePlace (fieldI F), v zb ≤ 1 + 2 * (b : ℝ) := fun v => by
    rw [← InfinitePlace.norm_embedding_eq v, hzb, map_sub, map_one, map_mul, map_natCast]
    calc ‖(1 : ℂ) - ((2 * b : ℕ) : ℂ) * v.embedding (iL F)‖
        ≤ ‖(1 : ℂ)‖ + ‖((2 * b : ℕ) : ℂ) * v.embedding (iL F)‖ := norm_sub_le _ _
      _ = 1 + 2 * (b : ℝ) := by
        rw [norm_one, norm_mul, Complex.norm_natCast, norm_embedding_iL, mul_one]; push_cast; ring
  have hA : (∏ v : InfinitePlace (fieldI F), v zb ^ v.mult) ≤ (1 + 2 * (b : ℝ)) ^ Module.finrank ℚ (fieldI F) := by
    rw [← InfinitePlace.sum_mult_eq, ← Finset.prod_pow_eq_pow_sum]
    exact Finset.prod_le_prod (fun v _ => pow_nonneg (apply_nonneg v zb) _) fun v _ =>
      pow_le_pow_left₀ (apply_nonneg v zb) (hplace v) _
  have hP : 0 < ∏ w ∈ T, (WPlace.split w).absAt zb := Finset.prod_pos fun w _ => hpos w
  have hinv : (∏ w ∈ T, (WPlace.split w).absAt zb)⁻¹ ≤ ∏ v : InfinitePlace (fieldI F), v zb ^ v.mult := by
    refine le_of_mul_le_mul_right ?_ hP
    rw [inv_mul_cancel₀ hP.ne']
    exact hPF
  calc splitHeight x = ∏ w ∈ T, max 1 ((WPlace.split w).absAt x) := splitHeight_eq_prod x T hT
    _ ≤ ∏ w ∈ T, ((WPlace.split w).absAt zb)⁻¹ :=
        Finset.prod_le_prod (fun w _ => zero_le_one.trans (le_max_left _ _)) fun w _ => hfac w
    _ = (∏ w ∈ T, (WPlace.split w).absAt zb)⁻¹ := Finset.prod_inv_distrib _
    _ ≤ _ := hinv.trans hA

#eval show Lean.Elab.Command.CommandElabM Unit from do
  let e ← Lean.getEnv
  IO.println s!"GEN 180 {e.contains `HadwigerNelson.Rigidity.SAdeleRing.congr_simp} {e.contains `HadwigerNelson.Rigidity.TateModel.congr_simp} {e.contains `HadwigerNelson.Rigidity.WPlace.absAt.congr_simp} {e.contains `HadwigerNelson.Rigidity.multiplier.congr_simp} {e.contains `HadwigerNelson.Rigidity.splitHeight.congr_simp}"

end

#eval show Lean.Elab.Command.CommandElabM Unit from do
  let e ← Lean.getEnv
  IO.println s!"GEN 182 {e.contains `HadwigerNelson.Rigidity.SAdeleRing.congr_simp} {e.contains `HadwigerNelson.Rigidity.TateModel.congr_simp} {e.contains `HadwigerNelson.Rigidity.WPlace.absAt.congr_simp} {e.contains `HadwigerNelson.Rigidity.multiplier.congr_simp} {e.contains `HadwigerNelson.Rigidity.splitHeight.congr_simp}"

end HadwigerNelson.Rigidity
