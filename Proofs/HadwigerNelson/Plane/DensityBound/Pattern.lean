import Proofs.HadwigerNelson.Plane.DensityBound.Autocorr

/-!
# Dual certificates and the pattern expectation (FS-131: FS131-KDB1's statements, FS131-IDB2's proofs)

`[AmbrusEtAl2023]` Proposition 1 (pp. 13–14) is LP weak duality over the atoms of a Venn diagram, written for a periodic
set and an O(2)-average. Here it is one expectation over a **finite window**: for a bounded Borel 1-avoiding `E` and a
point configuration `X`, the *pattern* `pat(y, θ, b) = {i : y + ρ_{θ,b}(X i) ∈ E}` (`ρ_{θ,b}(z) = e^{iθ}(b ? z̄ : z)`) is
an independent set of `X`'s unit-distance graph; integrating over `y ∈ ℂ` (Lebesgue, unnormalized) and `(θ, b)`,
`N(I) := ∫ [I ⊆ pat]` is `4π vol E` on singletons, `4π F̊(|X i − X j|)` on pairs, and equal on congruent index sets, while
the nonempty patterns have total mass at most `4π vol B(x₀, R + D)`. A certificate whose `L(S) ≤ bound` on every nonempty
independent `S` therefore gives `w₁ vol E + Σ w₂ F̊ ≤ bound · vol B(x₀, R + D)`: no boundary error, because normalization
comes only at the end. Plan: `plans/FS131-KDB1-density-bound.md` § 3.
-/

namespace HadwigerNelson.DensityBound

open Real MeasureTheory Set Metric
open scoped ENNReal

section Helpers

open Complex

/-- `ρ_{θ,b}(z) = e^{iθ}(b ? z̄ : z)`, the element of `O(2)` the pattern expectation averages over. -/
private noncomputable def rho (θ : ℝ) (b : Bool) (z : ℂ) : ℂ :=
  cexp (θ * I) * (if b then (starRingEnd ℂ) z else z)

private theorem rho_sub (θ : ℝ) (b : Bool) (z w : ℂ) : rho θ b (z - w) = rho θ b z - rho θ b w := by
  cases b <;> simp [rho, mul_sub]

private theorem rho_add (θ : ℝ) (b : Bool) (z w : ℂ) : rho θ b (z + w) = rho θ b z + rho θ b w := by
  cases b <;> simp [rho, mul_add]

private theorem norm_rho (θ : ℝ) (b : Bool) (z : ℂ) : ‖rho θ b z‖ = ‖z‖ := by
  cases b <;> simp [rho, Complex.norm_exp_ofReal_mul_I]

private theorem rho_periodic (b : Bool) (z : ℂ) : Function.Periodic (fun θ => rho θ b z) (2 * π) := by
  intro θ
  simp only [rho]
  rw [show ((θ + 2 * π : ℝ) : ℂ) * I = θ * I + 2 * π * I by push_cast; ring, Complex.exp_add,
    Complex.exp_two_pi_mul_I, mul_one]

private theorem continuous_rho (b : Bool) (z : ℂ) : Continuous fun θ : ℝ => rho θ b z := by
  simp only [rho]; fun_prop

/-- `O(2)` composes: `ρ_{θ,b}(u·(b′ ? z̄ : z)) = ρ_{θ ± arg u, b ⊕ b′}(z)` for `‖u‖ = 1`. -/
private theorem rho_comp {u : ℂ} (hu : ‖u‖ = 1) (b' : Bool) (θ : ℝ) (b : Bool) (z : ℂ) :
    rho θ b (u * (if b' then (starRingEnd ℂ) z else z)) =
      rho (θ + (if b then -Complex.arg u else Complex.arg u)) (xor b b') z := by
  set α := Complex.arg u with hα
  have hu' : u = cexp (α * I) := by
    conv_lhs => rw [← Complex.norm_mul_exp_arg_mul_I u, hu]
    simp [hα]
  clear_value α
  subst hu'
  have hconj : (starRingEnd ℂ) (cexp (α * I)) = cexp ((-α : ℝ) * I) := by
    rw [← Complex.exp_conj]
    congr 1
    simp [Complex.conj_ofReal]
  cases b <;> cases b' <;>
    simp only [rho, Bool.false_xor, Bool.true_xor, Bool.not_false, Bool.not_true, ite_true, ite_false,
      map_mul, Complex.conj_conj, hconj, Bool.false_eq_true]
  all_goals (rw [← mul_assoc, ← Complex.exp_add]; congr 2; push_cast; ring)

/-- A `2π`-periodic function has the same lower integral over `(0, 2π]` after a shift. -/
private theorem lintegral_Ioc_shift {g : ℝ → ℝ≥0∞} (hg : Function.Periodic g (2 * π)) (α : ℝ) :
    ∫⁻ θ in Ioc 0 (2 * π), g (θ + α) = ∫⁻ θ in Ioc 0 (2 * π), g θ := by
  haveI : Fact (0 < 2 * π) := ⟨by positivity⟩
  have hg' : Function.Periodic (fun θ => g (θ + α)) (2 * π) := fun θ => by
    simp only; rw [show θ + 2 * π + α = θ + α + 2 * π by ring, hg]
  have h1 := AddCircle.lintegral_preimage (T := 2 * π) 0 hg.lift
  have h2 := AddCircle.lintegral_preimage (T := 2 * π) 0 hg'.lift
  rw [zero_add] at h1 h2
  simp only [Function.Periodic.lift_coe] at h1 h2
  rw [h1, h2]
  have hcomm : ∀ x : AddCircle (2 * π), hg'.lift x = hg.lift ((α : AddCircle (2 * π)) + x) := by
    intro x
    induction x using QuotientAddGroup.induction_on with
    | H θ =>
      rw [← QuotientAddGroup.mk_add]
      change hg'.lift (θ : AddCircle (2 * π)) = hg.lift ((α + θ : ℝ) : AddCircle (2 * π))
      rw [Function.Periodic.lift_coe, Function.Periodic.lift_coe, add_comm]
  simp_rw [hcomm]
  exact lintegral_add_left_eq_self _ _

end Helpers

section PatternSets

open Complex

variable {n : ℕ} (X : Fin n → ℂ) (E : Set ℂ)

/-- `g_I^b(θ) = vol{y : ∀ i ∈ I, y + ρ_{θ,b}(X i) ∈ E}`. -/
private noncomputable def hitVol (I : Finset (Fin n)) (b : Bool) (θ : ℝ) : ℝ≥0∞ :=
  volume {y : ℂ | ∀ i ∈ I, y + rho θ b (X i) ∈ E}

/-- `q_S^b(θ) = vol{y : pat(y, θ, b) = S}`. -/
private noncomputable def patVol (S : Finset (Fin n)) (b : Bool) (θ : ℝ) : ℝ≥0∞ :=
  volume {y : ℂ | ∀ i, i ∈ S ↔ y + rho θ b (X i) ∈ E}

private theorem continuous_shift (b : Bool) (z : ℂ) : Continuous fun p : ℂ × ℝ => p.1 + rho p.2 b z :=
  continuous_fst.add ((continuous_rho b z).comp continuous_snd)

private theorem measurableSet_hit (hE : MeasurableSet E) (I : Finset (Fin n)) (b : Bool) :
    MeasurableSet {p : ℂ × ℝ | ∀ i ∈ I, p.1 + rho p.2 b (X i) ∈ E} := by
  have h : {p : ℂ × ℝ | ∀ i ∈ I, p.1 + rho p.2 b (X i) ∈ E} =
      ⋂ i ∈ I, (fun p : ℂ × ℝ => p.1 + rho p.2 b (X i)) ⁻¹' E := by
    ext p; simp
  rw [h]
  exact Finset.measurableSet_biInter I fun i _ => hE.preimage (continuous_shift b (X i)).measurable

private theorem measurableSet_pat (hE : MeasurableSet E) (S : Finset (Fin n)) (b : Bool) :
    MeasurableSet {p : ℂ × ℝ | ∀ i, i ∈ S ↔ p.1 + rho p.2 b (X i) ∈ E} := by
  have h : {p : ℂ × ℝ | ∀ i, i ∈ S ↔ p.1 + rho p.2 b (X i) ∈ E} =
      ⋂ i, {p : ℂ × ℝ | i ∈ S ↔ p.1 + rho p.2 b (X i) ∈ E} := by
    ext p; simp
  rw [h]
  refine MeasurableSet.iInter fun i => ?_
  have hm : MeasurableSet ((fun p : ℂ × ℝ => p.1 + rho p.2 b (X i)) ⁻¹' E) :=
    hE.preimage (continuous_shift b (X i)).measurable
  by_cases hi : i ∈ S
  · have he : {p : ℂ × ℝ | i ∈ S ↔ p.1 + rho p.2 b (X i) ∈ E} = (fun p : ℂ × ℝ => p.1 + rho p.2 b (X i)) ⁻¹' E := by
      ext p; simp [hi]
    rw [he]; exact hm
  · have he : {p : ℂ × ℝ | i ∈ S ↔ p.1 + rho p.2 b (X i) ∈ E} =
        ((fun p : ℂ × ℝ => p.1 + rho p.2 b (X i)) ⁻¹' E)ᶜ := by
      ext p; simp [hi]
    rw [he]; exact hm.compl

private theorem measurable_hitVol (hE : MeasurableSet E) (I : Finset (Fin n)) (b : Bool) :
    Measurable (hitVol X E I b) :=
  measurable_measure_prodMk_right (measurableSet_hit X E hE I b)

private theorem measurable_patVol (hE : MeasurableSet E) (S : Finset (Fin n)) (b : Bool) :
    Measurable (patVol X E S b) :=
  measurable_measure_prodMk_right (measurableSet_pat X E hE S b)

private theorem measurableSet_patSlice (hE : MeasurableSet E) (S : Finset (Fin n)) (b : Bool) (θ : ℝ) :
    MeasurableSet {y : ℂ | ∀ i, i ∈ S ↔ y + rho θ b (X i) ∈ E} :=
  (measurableSet_pat X E hE S b).preimage measurable_prodMk_right

private theorem pairwiseDisjoint_pat (T : Finset (Finset (Fin n))) (b : Bool) (θ : ℝ) :
    (T : Set (Finset (Fin n))).PairwiseDisjoint fun S => {y : ℂ | ∀ i, i ∈ S ↔ y + rho θ b (X i) ∈ E} := by
  intro S _ S' _ hne
  rw [Function.onFun, Set.disjoint_left]
  intro y hy hy'
  apply hne
  ext i
  rw [(hy : ∀ i, i ∈ S ↔ _) i, (hy' : ∀ i, i ∈ S' ↔ _) i]

/-- **The Venn identity**, at each `(θ, b)`: the hits of `I` are the patterns containing `I`. -/
private theorem hitVol_eq_sum (hE : MeasurableSet E) (I : Finset (Fin n)) (b : Bool) (θ : ℝ) :
    hitVol X E I b θ = ∑ S ∈ Finset.univ.filter (I ⊆ ·), patVol X E S b θ := by
  classical
  have hU : {y : ℂ | ∀ i ∈ I, y + rho θ b (X i) ∈ E} =
      ⋃ S ∈ Finset.univ.filter (I ⊆ ·), {y : ℂ | ∀ i, i ∈ S ↔ y + rho θ b (X i) ∈ E} := by
    ext y
    simp only [mem_setOf_eq, mem_iUnion, Finset.mem_filter, Finset.mem_univ, true_and, exists_prop]
    constructor
    · intro hy
      refine ⟨Finset.univ.filter (fun i => y + rho θ b (X i) ∈ E), fun i hi => ?_, fun i => ?_⟩
      · simp [hy i hi]
      · simp
    · rintro ⟨S, hIS, hS⟩ i hi
      exact (hS i).1 (hIS hi)
  rw [hitVol, hU, measure_biUnion_finset (pairwiseDisjoint_pat X E _ b θ)
    (fun S _ => measurableSet_patSlice X E hE S b θ)]
  rfl

private theorem rho_add_two_pi (θ : ℝ) (b : Bool) (z : ℂ) : rho (θ + 2 * π) b z = rho θ b z :=
  rho_periodic b z θ

private theorem hitVol_periodic (I : Finset (Fin n)) (b : Bool) : Function.Periodic (hitVol X E I b) (2 * π) := by
  intro θ
  simp only [hitVol, rho_add_two_pi]

private theorem hitVol_single (i : Fin n) (b : Bool) (θ : ℝ) : hitVol X E {i} b θ = volume E := by
  have h : {y : ℂ | ∀ k ∈ ({i} : Finset (Fin n)), y + rho θ b (X k) ∈ E} = (fun y => y + rho θ b (X i)) ⁻¹' E := by
    ext y; simp
  rw [hitVol, h, measure_preimage_add_right]

private theorem hitVol_pair (hfin : volume E ≠ ∞) (i j : Fin n) (b : Bool) (θ : ℝ) :
    hitVol X E {i, j} b θ = ENNReal.ofReal (autocorr E (rho θ b (X j - X i))) := by
  have h : {y : ℂ | ∀ k ∈ ({i, j} : Finset (Fin n)), y + rho θ b (X k) ∈ E} =
      (fun y => y + rho θ b (X i)) ⁻¹' (E ∩ (fun y => y + rho θ b (X j - X i)) ⁻¹' E) := by
    ext y
    simp only [Finset.mem_insert, Finset.mem_singleton, forall_eq_or_imp, forall_eq, mem_setOf_eq, mem_preimage,
      mem_inter_iff, rho_sub]
    rw [show y + rho θ b (X i) + (rho θ b (X j) - rho θ b (X i)) = y + rho θ b (X j) by ring]
  rw [hitVol, h, measure_preimage_add_right, autocorr, ENNReal.ofReal_toReal]
  exact measure_ne_top_of_subset inter_subset_left hfin

private theorem lintegral_autocorr_rho (hE : MeasurableSet E) (hfin : volume E ≠ ∞) (b : Bool) (v : ℂ) :
    ∫⁻ θ in Ioc 0 (2 * π), ENNReal.ofReal (autocorr E (rho θ b v)) =
      ENNReal.ofReal (2 * π * Real.circleAverage (autocorr E) 0 ‖v‖) := by
  have hc : Continuous fun θ => autocorr E (rho θ b v) := (continuous_autocorr hE hfin).comp (continuous_rho b v)
  rw [← ofReal_integral_eq_lintegral_ofReal hc.integrableOn_Ioc
    (Filter.Eventually.of_forall fun θ => ENNReal.toReal_nonneg)]
  congr 1
  rw [← intervalIntegral.integral_of_le (by positivity)]
  set v' : ℂ := if b then (starRingEnd ℂ) v else v with hv'
  have hn : ‖v'‖ = ‖v‖ := by rw [hv']; split_ifs <;> simp
  have hrho : ∀ θ : ℝ, rho θ b v = circleMap 0 ‖v'‖ (θ + Complex.arg v') := by
    intro θ
    rw [circleMap, zero_add, Complex.ofReal_add, add_mul, Complex.exp_add, mul_left_comm,
      Complex.norm_mul_exp_arg_mul_I, rho, hv']
  rw [← hn, Real.circleAverage_eq_integral_add (Complex.arg v'), smul_eq_mul, ← mul_assoc,
    mul_inv_cancel₀ (by positivity), one_mul]
  congr 1; funext θ; rw [hrho]

private theorem hitVol_congr {u v : ℂ} {b' : Bool} (hu : ‖u‖ = 1) {I J : Finset (Fin n)}
    (hσ : (fun z => u * (if b' then (starRingEnd ℂ) z else z) + v) '' (X '' (I : Set (Fin n))) =
      X '' (J : Set (Fin n))) (b : Bool) (θ : ℝ) :
    hitVol X E J b θ = hitVol X E I (xor b b') (θ + if b then -Complex.arg u else Complex.arg u) := by
  have hset : {y : ℂ | ∀ j ∈ J, y + rho θ b (X j) ∈ E} =
      (fun y => y + rho θ b v) ⁻¹' {y : ℂ | ∀ i ∈ I,
        y + rho (θ + if b then -Complex.arg u else Complex.arg u) (xor b b') (X i) ∈ E} := by
    ext y
    simp only [mem_setOf_eq, mem_preimage]
    have e1 : (∀ j ∈ J, y + rho θ b (X j) ∈ E) ↔ ∀ w ∈ X '' (J : Set (Fin n)), y + rho θ b w ∈ E := by
      simp only [Set.forall_mem_image, Finset.mem_coe]
    rw [e1, ← hσ]
    simp only [Set.forall_mem_image, Finset.mem_coe]
    refine forall₂_congr fun i _ => ?_
    rw [rho_add, rho_comp hu, add_comm (rho _ _ _) (rho θ b v), add_assoc]
  rw [hitVol, hset, measure_preimage_add_right]
  rfl

private theorem patVol_eq_zero (h1 : ∀ a ∈ E, ∀ b ∈ E, dist a b ≠ 1) {S : Finset (Fin n)}
    (hS : ¬ ∀ i ∈ S, ∀ j ∈ S, dist (X i) (X j) ≠ 1) (b : Bool) (θ : ℝ) : patVol X E S b θ = 0 := by
  have h : {y : ℂ | ∀ i, i ∈ S ↔ y + rho θ b (X i) ∈ E} = ∅ := by
    ext y
    simp only [mem_setOf_eq, mem_empty_iff_false, iff_false]
    intro hy
    apply hS
    intro i hi j hj
    have hd : dist (X i) (X j) = dist (y + rho θ b (X i)) (y + rho θ b (X j)) := by
      rw [dist_add_left, dist_eq_norm, dist_eq_norm, ← rho_sub, norm_rho]
    rw [hd]
    exact h1 _ ((hy i).1 hi) _ ((hy j).1 hj)
  rw [patVol, h, measure_empty]

private theorem sum_patVol_le (hE : MeasurableSet E) {x₀ : ℂ} {R D : ℝ} (hER : E ⊆ ball x₀ R) (hD : ∀ i, ‖X i‖ ≤ D)
    (b : Bool) (θ : ℝ) :
    ∑ S ∈ Finset.univ.filter (fun S : Finset (Fin n) => S.Nonempty), patVol X E S b θ ≤ volume (ball x₀ (R + D)) := by
  simp only [patVol]
  rw [← measure_biUnion_finset (pairwiseDisjoint_pat X E _ b θ) (fun S _ => measurableSet_patSlice X E hE S b θ)]
  apply measure_mono
  intro y hy
  simp only [mem_iUnion, Finset.mem_filter, Finset.mem_univ, true_and, exists_prop, mem_setOf_eq] at hy
  obtain ⟨S, ⟨i, hi⟩, hS⟩ := hy
  have hin := hER ((hS i).1 hi)
  rw [mem_ball] at hin ⊢
  have h2 : dist y (y + rho θ b (X i)) = ‖X i‖ := by
    rw [dist_comm, dist_eq_norm, add_sub_cancel_left, norm_rho]
  calc dist y x₀ ≤ dist y (y + rho θ b (X i)) + dist (y + rho θ b (X i)) x₀ := dist_triangle _ _ _
    _ < R + D := by rw [h2]; linarith [hD i]

end PatternSets

/-- **A dual certificate** on `n` points: `[AmbrusEtAl2023]` Proposition 1's data without `w₀` (which lives on the
Fourier side): the points, the singleton weights `w₁`, the pair weights `w₂`, the congruence weights `w_c` and the bound
(`w_T + ν`). -/
structure DualCert (n : ℕ) where
  /-- The points. -/
  X : Fin n → ℂ
  /-- `w₁(i)`. -/
  w1 : Fin n → ℝ
  /-- `w₂(i, j)`, as a list of `(i, j, w)`. -/
  w2 : List (Fin n × Fin n × ℝ)
  /-- `w_c(I, J)`, as a list of `(I, J, w)`. -/
  wc : List (Finset (Fin n) × Finset (Fin n) × ℝ)
  /-- `w_T + ν`. -/
  bound : ℝ

namespace DualCert

variable {n : ℕ} (C : DualCert n)

/-- `L(S) = w_T − V(S)` of the paper's eq. (20): `Σ_{i∈S} w₁ + Σ_{i,j∈S} w₂ − Σ w_c([I ⊆ S] − [J ⊆ S])`. -/
noncomputable def L (S : Finset (Fin n)) : ℝ :=
  ∑ i ∈ S, C.w1 i + (C.w2.map fun e => if e.1 ∈ S ∧ e.2.1 ∈ S then e.2.2 else 0).sum -
    (C.wc.map fun e => e.2.2 * ((if e.1 ⊆ S then 1 else 0) - (if e.2.1 ⊆ S then 1 else 0))).sum

/-- `S` is independent in the unit-distance graph on `X`. -/
def IsIndep (S : Finset (Fin n)) : Prop := ∀ i ∈ S, ∀ j ∈ S, dist (C.X i) (C.X j) ≠ 1

/-- `X '' I` and `X '' J` are congruent: some isometry `z ↦ u·z + v` or `z ↦ u·z̄ + v` (`‖u‖ = 1`) carries one onto the
other. -/
def Congruent (I J : Finset (Fin n)) : Prop :=
  ∃ (u v : ℂ) (b : Bool), ‖u‖ = 1 ∧
    (fun z => u * (if b then (starRingEnd ℂ) z else z) + v) '' (C.X '' (I : Set (Fin n))) = C.X '' (J : Set (Fin n))

/-- **The certificate's hypotheses** (`[AmbrusEtAl2023]` Proposition 1's `V(ε) ≥ 0`, read with `ν` inside `bound`, on the
nonempty independent atoms only; the congruences of `C(X)`). -/
structure Valid : Prop where
  /-- Every listed congruence constraint is between congruent sets. -/
  cong : ∀ e ∈ C.wc, C.Congruent e.1 e.2.1
  /-- `V(S) ≥ 0`, i.e. `L(S) ≤ bound`, on every nonempty independent `S`. -/
  atoms : ∀ S : Finset (Fin n), S.Nonempty → C.IsIndep S → C.L S ≤ C.bound
  /-- The bound is nonnegative. -/
  bound_nonneg : 0 ≤ C.bound

/-- The Fourier-side function `ϕ(t) = w₀ J₀(t) + Σ w₁ + Σ w₂ J₀(t |X i − X j|)` (eq. (22)). -/
noncomputable def phi (w0 t : ℝ) : ℝ :=
  w0 * J0 t + ∑ i, C.w1 i + (C.w2.map fun e => e.2.2 * J0 (t * ‖C.X e.1 - C.X e.2.1‖)).sum


-- A finite sum against a list sum, exchanged.
private theorem sum_mul_list_sum {α β : Type*} (T : Finset β) (p : β → ℝ) (l : List α) (f : β → α → ℝ) :
    ∑ S ∈ T, p S * (l.map (f S)).sum = (l.map fun e => ∑ S ∈ T, p S * f S e).sum := by
  induction l with
  | nil => simp
  | cons a l ih => simp [List.map_cons, List.sum_cons, mul_add, Finset.sum_add_distrib, ih]

private theorem list_sum_mul_const {α : Type*} (l : List α) (f g : α → ℝ) (c : ℝ) :
    (l.map fun e => f e * (c * g e)).sum = c * (l.map fun e => f e * g e).sum := by
  induction l with
  | nil => simp
  | cons a l ih => simp [List.map_cons, List.sum_cons, ih]; ring

/-- `Σ_S p(S) L(S)`, expanded over the certificate's terms: each term reads `Σ_{S ⊇ I} p(S)` for one index set `I`. -/
private theorem sum_mul_L (T : Finset (Finset (Fin n))) (p : Finset (Fin n) → ℝ) :
    ∑ S ∈ T, p S * C.L S =
      ∑ i, C.w1 i * (∑ S ∈ T, if {i} ⊆ S then p S else 0) +
      (C.w2.map fun e => e.2.2 * ∑ S ∈ T, if {e.1, e.2.1} ⊆ S then p S else 0).sum -
      (C.wc.map fun e => e.2.2 * ((∑ S ∈ T, if e.1 ⊆ S then p S else 0) -
        ∑ S ∈ T, if e.2.1 ⊆ S then p S else 0)).sum := by
  classical
  simp only [L, mul_add, mul_sub, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  congr 1
  congr 1
  · have h : ∀ x : Finset (Fin n), p x * ∑ i ∈ x, C.w1 i = ∑ i, if i ∈ x then p x * C.w1 i else 0 := by
      intro x
      rw [Finset.mul_sum, ← Finset.sum_filter]
      congr 1; ext i; simp
    simp_rw [h]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun S _ => ?_
    simp only [Finset.singleton_subset_iff]
    split_ifs <;> ring
  · rw [sum_mul_list_sum]
    congr 1
    refine List.map_congr_left fun e _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun S _ => ?_
    simp only [Finset.insert_subset_iff, Finset.singleton_subset_iff]
    split_ifs <;> ring
  · rw [sum_mul_list_sum]
    congr 1
    refine List.map_congr_left fun e _ => ?_
    rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun S _ => ?_
    split_ifs <;> ring

/-- **The pattern expectation** (the atom half of Proposition 1, finite-window form). -/
theorem window_bound (hC : C.Valid) {E : Set ℂ} (hE : MeasurableSet E) (h1 : ∀ a ∈ E, ∀ b ∈ E, dist a b ≠ 1)
    {x₀ : ℂ} {R D : ℝ} (hER : E ⊆ ball x₀ R) (hD : ∀ i, ‖C.X i‖ ≤ D) :
    (∑ i, C.w1 i) * (volume E).toReal +
        (C.w2.map fun e => e.2.2 * Real.circleAverage (autocorr E) 0 ‖C.X e.1 - C.X e.2.1‖).sum ≤
      C.bound * (volume (ball x₀ (R + D))).toReal := by
  classical
  have hfin : volume E ≠ ∞ := (isBounded_ball.subset hER).measure_lt_top.ne
  set Ne : Finset (Finset (Fin n)) := Finset.univ.filter (fun S => S.Nonempty) with hNe
  set N : Finset (Fin n) → ℝ≥0∞ := fun I => ∑ b : Bool, ∫⁻ θ in Ioc 0 (2 * π), hitVol C.X E I b θ with hN
  set P : Finset (Fin n) → ℝ≥0∞ := fun S => ∑ b : Bool, ∫⁻ θ in Ioc 0 (2 * π), patVol C.X E S b θ with hP
  have hNP : ∀ I, N I = ∑ S ∈ Finset.univ.filter (I ⊆ ·), P S := by
    intro I
    simp only [hN, hP]
    simp_rw [hitVol_eq_sum C.X E hE I,
      lintegral_finsetSum _ (fun S _ => measurable_patVol C.X E hE S _)]
    exact Finset.sum_comm
  have h2pi : (volume (Ioc (0 : ℝ) (2 * π))) = ENNReal.ofReal (2 * π) := by
    rw [Real.volume_Ioc, sub_zero]
  have hN1 : ∀ i, N {i} = 2 * (volume E * ENNReal.ofReal (2 * π)) := by
    intro i
    simp only [hN, hitVol_single, setLIntegral_const, h2pi, Fintype.sum_bool]
    ring
  have hN2 : ∀ i j, N {i, j} = 2 * ENNReal.ofReal (2 * π * Real.circleAverage (autocorr E) 0 ‖C.X i - C.X j‖) := by
    intro i j
    simp only [hN, hitVol_pair C.X E hfin, lintegral_autocorr_rho E hE hfin, Fintype.sum_bool,
      norm_sub_rev (C.X j) (C.X i)]
    ring
  have hNc : ∀ I J, C.Congruent I J → N J = N I := by
    rintro I J ⟨u, v, b', hu, hσ⟩
    have hb : ∀ b, ∫⁻ θ in Ioc 0 (2 * π), hitVol C.X E J b θ =
        ∫⁻ θ in Ioc 0 (2 * π), hitVol C.X E I (xor b b') θ := by
      intro b
      simp_rw [hitVol_congr C.X E hu hσ b]
      exact lintegral_Ioc_shift (g := hitVol C.X E I (xor b b')) (hitVol_periodic C.X E I _) _
    simp only [hN, hb]
    cases b' <;> simp [add_comm]
  have hPind : ∀ S, ¬ C.IsIndep S → P S = 0 := by
    intro S hS
    simp only [hP, patVol_eq_zero C.X E h1 hS, lintegral_zero, Finset.sum_const_zero]
  have hPmass : ∑ S ∈ Ne, P S ≤ 2 * (volume (ball x₀ (R + D)) * ENNReal.ofReal (2 * π)) := by
    have hb : ∀ b, ∫⁻ θ in Ioc 0 (2 * π), ∑ S ∈ Ne, patVol C.X E S b θ ≤
        volume (ball x₀ (R + D)) * ENNReal.ofReal (2 * π) := fun b =>
      calc _ ≤ ∫⁻ θ in Ioc 0 (2 * π), volume (ball x₀ (R + D)) :=
            lintegral_mono fun θ => sum_patVol_le C.X E hE hER hD b θ
        _ = _ := by rw [setLIntegral_const, h2pi]
    simp only [hP]
    rw [Finset.sum_comm]
    simp_rw [← lintegral_finsetSum _ (fun S _ => measurable_patVol C.X E hE S _)]
    rw [Fintype.sum_bool]
    refine (add_le_add (hb true) (hb false)).trans (le_of_eq ?_)
    ring
  have hN1fin : ∀ i, N {i} ≠ ∞ := fun i => by
    rw [hN1]; exact ENNReal.mul_ne_top (by norm_num) (ENNReal.mul_ne_top hfin ENNReal.ofReal_ne_top)
  have hPfin : ∀ S ∈ Ne, P S ≠ ∞ := by
    intro S hS
    obtain ⟨i, hi⟩ := (Finset.mem_filter.1 hS).2
    refine ne_top_of_le_ne_top (hN1fin i) ?_
    rw [hNP {i}]
    exact Finset.single_le_sum (f := P) (fun _ _ => bot_le)
      (Finset.mem_filter.2 ⟨Finset.mem_univ _, Finset.singleton_subset_iff.2 hi⟩)
  -- to real numbers
  set p : Finset (Fin n) → ℝ := fun S => (P S).toReal with hp
  set nn : Finset (Fin n) → ℝ := fun I => ∑ S ∈ Ne, if I ⊆ S then p S else 0 with hnn_def
  have hnn : ∀ I : Finset (Fin n), I.Nonempty → nn I = (N I).toReal := by
    intro I hI
    have hfilt : Ne.filter (I ⊆ ·) = Finset.univ.filter (I ⊆ ·) := by
      ext S
      simp only [hNe, Finset.mem_filter, Finset.mem_univ, true_and, and_iff_right_iff_imp]
      exact fun h => hI.mono h
    show (∑ S ∈ Ne, if I ⊆ S then p S else 0) = (N I).toReal
    rw [← Finset.sum_filter, hfilt, hNP I, ENNReal.toReal_sum]
    intro S hS
    have hS' : S ∈ Ne.filter (I ⊆ ·) := by rwa [hfilt]
    exact hPfin S (Finset.mem_filter.1 hS').1
  have hval1 : ∀ i, nn {i} = 4 * π * (volume E).toReal := by
    intro i
    rw [hnn _ (Finset.singleton_nonempty i), hN1, ENNReal.toReal_mul, ENNReal.toReal_mul,
      ENNReal.toReal_ofReal (by positivity)]
    norm_num; ring
  have hval2 : ∀ i j, nn {i, j} = 4 * π * Real.circleAverage (autocorr E) 0 ‖C.X i - C.X j‖ := by
    intro i j
    have hnn0 : 0 ≤ Real.circleAverage (autocorr E) 0 ‖C.X i - C.X j‖ :=
      Real.circleAverage_nonneg_of_nonneg fun x _ => ENNReal.toReal_nonneg
    rw [hnn _ (Finset.insert_nonempty i {j}), hN2, ENNReal.toReal_mul, ENNReal.toReal_ofReal (by positivity)]
    norm_num; ring
  have hcong : ∀ e ∈ C.wc, nn e.1 = nn e.2.1 := by
    intro e he
    have hc := hC.cong e he
    rcases Finset.eq_empty_or_nonempty e.1 with h0 | hI
    · obtain ⟨u, v, b', hu, hσ⟩ := hc
      have hJ : e.2.1 = ∅ := by
        rw [h0, Finset.coe_empty, Set.image_empty, Set.image_empty, eq_comm, Set.image_eq_empty,
          Finset.coe_eq_empty] at hσ
        exact hσ
      rw [h0, hJ]
    · have hJ : e.2.1.Nonempty := by
        obtain ⟨u, v, b', hu, hσ⟩ := hc
        obtain ⟨i, hi⟩ := hI
        have hmem : (fun z => u * (if b' then (starRingEnd ℂ) z else z) + v) (C.X i) ∈ C.X '' (e.2.1 : Set (Fin n)) := by
          rw [← hσ]; exact Set.mem_image_of_mem _ (Set.mem_image_of_mem _ hi)
        obtain ⟨j, hj, _⟩ := hmem
        exact ⟨j, hj⟩
      rw [hnn _ hI, hnn _ hJ, hNc _ _ hc]
  have halg := sum_mul_L C Ne p
  have hzero : (C.wc.map fun e => e.2.2 * ((∑ S ∈ Ne, if e.1 ⊆ S then p S else 0) -
      ∑ S ∈ Ne, if e.2.1 ⊆ S then p S else 0)).sum = 0 := by
    rw [List.map_congr_left (g := fun _ => (0 : ℝ)) (fun e he => by
      have := hcong e he
      simp only [hnn_def] at this
      rw [this, sub_self, mul_zero])]
    simp
  have hle : ∑ S ∈ Ne, p S * C.L S ≤ C.bound * ∑ S ∈ Ne, p S := by
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun S hS => ?_
    by_cases hi : C.IsIndep S
    · rw [mul_comm (C.bound)]
      exact mul_le_mul_of_nonneg_left (hC.atoms S (Finset.mem_filter.1 hS).2 hi) ENNReal.toReal_nonneg
    · simp [hp, hPind S hi]
  have hmass : ∑ S ∈ Ne, p S ≤ 4 * π * (volume (ball x₀ (R + D))).toReal := by
    have hb : volume (ball x₀ (R + D)) ≠ ∞ := measure_ball_lt_top.ne
    rw [hp, ← ENNReal.toReal_sum hPfin]
    calc (∑ S ∈ Ne, P S).toReal ≤ (2 * (volume (ball x₀ (R + D)) * ENNReal.ofReal (2 * π))).toReal :=
          ENNReal.toReal_mono (ENNReal.mul_ne_top (by norm_num) (ENNReal.mul_ne_top hb ENNReal.ofReal_ne_top)) hPmass
      _ = 4 * π * (volume (ball x₀ (R + D))).toReal := by
          rw [ENNReal.toReal_mul, ENNReal.toReal_mul, ENNReal.toReal_ofReal (by positivity)]
          norm_num; ring
  -- assemble
  have hkey : 4 * π * ((∑ i, C.w1 i) * (volume E).toReal +
      (C.w2.map fun e => e.2.2 * Real.circleAverage (autocorr E) 0 ‖C.X e.1 - C.X e.2.1‖).sum) =
      ∑ S ∈ Ne, p S * C.L S := by
    rw [halg, hzero, sub_zero]
    simp only [hnn_def] at hval1 hval2
    simp_rw [hval1, hval2]
    rw [list_sum_mul_const, ← Finset.sum_mul]
    ring
  have hpos : (0 : ℝ) < 4 * π := by positivity
  have := hkey ▸ hle.trans (mul_le_mul_of_nonneg_left hmass hC.bound_nonneg)
  nlinarith [this]

end DualCert

/-- **A model of `DualCert.Valid`** with every field exercised at a nonzero value: one point, `w₁ = 1`, bound `1`; the
only nonempty set is `{0}`, independent, with `L = 1`. (It gives the trivial bound `vol E ≤ vol B(x₀, R)`.) -/
noncomputable def trivialCert : DualCert 1 := ⟨fun _ => 0, fun _ => 1, [], [], 1⟩

theorem trivialCert_valid : trivialCert.Valid := by
  refine ⟨fun e he => by simp [trivialCert] at he, fun S _ _ => ?_, zero_le_one⟩
  have hL : trivialCert.L S = S.card := by simp [DualCert.L, trivialCert]
  rw [hL]
  have : S.card ≤ 1 := by simpa using Finset.card_le_univ S
  change (S.card : ℝ) ≤ 1
  exact_mod_cast this

end HadwigerNelson.DensityBound
