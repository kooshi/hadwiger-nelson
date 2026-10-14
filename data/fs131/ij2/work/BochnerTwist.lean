import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Proofs.HadwigerNelson.Rigidity.Herglotz
import Mathlib.Analysis.Fourier.FiniteAbelian.PontryaginDuality
import Mathlib.Algebra.Order.Chebyshev

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs NumberField Filter Topology

noncomputable section

variable (F : Subfield ℝ)

theorem finite_quotient_nsmul [NumberField F] (N : ℕ) (hN : N ≠ 0) :
    Finite (unitRing F ⧸ (nsmulAddMonoidHom (α := unitRing F) N).range) := by
  sorry

open private archHom archTop_eq eventually_archTop norm_archHom_nsmul fivePow nsmul_fivePow inv_five_mem
  exists_nsmul_mem_of_mem_nhds_profTop from Proofs.HadwigerNelson.Rigidity.ContinuityGroup

/-! ### Private helpers: the subgroups `N·R`, small representatives of their cosets -/

/-- `N·R`. -/
private abbrev nR (N : ℕ) : AddSubgroup (unitRing F) := (nsmulAddMonoidHom (α := unitRing F) N).range

private theorem coe_fivePow (k : ℕ) (r : unitRing F) : ((fivePow F k r : unitRing F) : ℂ) = (5 : ℂ)⁻¹ ^ k * r :=
  rfl

/-- `1/5`, an element of `R`. -/
private def uFive : unitRing F := ⟨(5 : ℂ)⁻¹, inv_five_mem F⟩

private theorem five_mul_uFive : (5 : unitRing F) * uFive F = 1 := by
  apply Subtype.ext
  have h5 : ((5 : unitRing F) : ℂ) = 5 := map_ofNat (unitRing F).subtype 5
  rw [Subring.coe_mul, Subring.coe_one, h5]
  show (5 : ℂ) * (5 : ℂ)⁻¹ = 1
  norm_num

private theorem fivePow_eq (k : ℕ) (r : unitRing F) : fivePow F k r = uFive F ^ k * r := by
  apply Subtype.ext
  rw [coe_fivePow, Subring.coe_mul, Subring.coe_pow]
  rfl

private theorem fivePow_mem_nR {N : ℕ} (k : ℕ) {w : unitRing F} (h : w ∈ nR F N) : fivePow F k w ∈ nR F N := by
  obtain ⟨s, rfl⟩ := h
  refine ⟨fivePow F k s, ?_⟩
  simp only [nsmulAddMonoidHom_apply, fivePow_eq, nsmul_eq_mul]
  ring

private theorem fivePow_fivePow (a b : ℕ) (r : unitRing F) : fivePow F a (fivePow F b r) = fivePow F (a + b) r := by
  simp only [fivePow_eq, pow_add]
  ring

private theorem fivePow_sub (k : ℕ) (r s : unitRing F) : fivePow F k (r - s) = fivePow F k r - fivePow F k s := by
  simp only [fivePow_eq]
  ring

private theorem fivePow_zero (r : unitRing F) : fivePow F 0 r = r := by
  simp only [fivePow_eq, pow_zero, one_mul]

open scoped Classical in
private theorem norm_archHom_fivePow [NumberField F] (k : ℕ) (r : unitRing F) :
    ‖archHom F (fivePow F k r)‖ = ‖archHom F r‖ / 5 ^ k := by
  have h := norm_archHom_nsmul F (5 ^ k) (fivePow F k r)
  rw [nsmul_fivePow] at h
  rw [h]
  push_cast
  field_simp

open scoped Classical in
/-- Every coset of `N·R` has a member of archimedean size below any `δ > 0`: `r ↦ r/5` permutes the finite quotient,
so some power `r/5^{e}` lies in the coset of `r`, and so do all `r/5^{ek}`. -/
private theorem exists_small_rep [NumberField F] (N : ℕ) (hN : N ≠ 0) (r : unitRing F) {δ : ℝ} (hδ : 0 < δ) :
    ∃ x : unitRing F, x - r ∈ nR F N ∧ ‖archHom F x‖ < δ := by
  haveI := finite_quotient_nsmul F N hN
  obtain ⟨i, j, hij, hq⟩ := Finite.exists_ne_map_eq_of_infinite
    (fun k : ℕ => (QuotientAddGroup.mk (fivePow F k r) : unitRing F ⧸ nR F N))
  have key : ∀ i j : ℕ, i < j → (QuotientAddGroup.mk (fivePow F i r) : unitRing F ⧸ nR F N) =
      QuotientAddGroup.mk (fivePow F j r) → ∃ e, 0 < e ∧ fivePow F e r - r ∈ nR F N := by
    intro i j hij h
    refine ⟨j - i, by omega, ?_⟩
    rw [QuotientAddGroup.eq] at h
    have e : fivePow F (j - i) r - r = (5 ^ i) • (-fivePow F i r + fivePow F j r) := by
      have h5 : (5 : unitRing F) ^ i * uFive F ^ i = 1 := by rw [← mul_pow, five_mul_uFive, one_pow]
      have hj : uFive F ^ j = uFive F ^ (j - i) * uFive F ^ i := by rw [← pow_add, Nat.sub_add_cancel hij.le]
      rw [fivePow_eq, fivePow_eq, fivePow_eq, nsmul_eq_mul, hj]
      push_cast
      linear_combination (r - uFive F ^ (j - i) * r) * h5
    rw [e]
    exact (nR F N).nsmul_mem h _
  obtain ⟨e, he, hmem⟩ : ∃ e, 0 < e ∧ fivePow F e r - r ∈ nR F N := by
    rcases lt_or_gt_of_ne hij with h | h
    · exact key i j h hq
    · exact key j i h hq.symm
  have hiter : ∀ k, fivePow F (e * k) r - r ∈ nR F N := by
    intro k
    induction k with
    | zero => rw [Nat.mul_zero, fivePow_zero, sub_self]; exact (nR F N).zero_mem
    | succ k ih =>
      have h2 : fivePow F (e * (k + 1)) r - r = fivePow F e (fivePow F (e * k) r - r) + (fivePow F e r - r) := by
        rw [fivePow_sub, fivePow_fivePow, Nat.mul_succ, Nat.add_comm (e * k) e]
        abel
      rw [h2]
      exact add_mem (fivePow_mem_nR F e ih) hmem
  obtain ⟨k, hk⟩ : ∃ k : ℕ, ‖archHom F r‖ / δ < 5 ^ k := pow_unbounded_of_one_lt _ (by norm_num)
  refine ⟨fivePow F (e * k) r, hiter k, ?_⟩
  rw [norm_archHom_fivePow, div_lt_iff₀ (by positivity)]
  have h1 : ‖archHom F r‖ < δ * 5 ^ k := by
    rw [div_lt_iff₀ hδ] at hk
    linarith
  have h2 : (5 : ℝ) ^ k ≤ 5 ^ (e * k) := pow_le_pow_right₀ (by norm_num) (Nat.le_mul_of_pos_left k he)
  nlinarith

open scoped Classical in
/-- A section of the quotient by `N·R` by small representatives. -/
private theorem exists_reps [NumberField F] (N : ℕ) (hN : N ≠ 0) {δ : ℝ} (hδ : 0 < δ) :
    ∃ x : unitRing F ⧸ nR F N → unitRing F,
      (∀ c, (x c : unitRing F ⧸ nR F N) = c) ∧ ∀ c, ‖archHom F (x c)‖ < δ := by
  have h : ∀ c : unitRing F ⧸ nR F N, ∃ x : unitRing F, (x : unitRing F ⧸ nR F N) = c ∧ ‖archHom F x‖ < δ := by
    intro c
    obtain ⟨r, rfl⟩ := QuotientAddGroup.mk_surjective c
    obtain ⟨x, hx, hxs⟩ := exists_small_rep F N hN r hδ
    refine ⟨x, ?_, hxs⟩
    rw [QuotientAddGroup.eq]
    have : -x + r = -(x - r) := by abel
    rw [this]
    exact (nR F N).neg_mem hx
  choose x hx1 hx2 using h
  exact ⟨x, hx1, hx2⟩

/-! ### Private helpers: characters of the finite quotients -/

variable {F}

/-- A complex character of a finite quotient of `R`, read as a character of `R`. -/
private def liftChar {H : AddSubgroup (unitRing F)} [Finite (unitRing F ⧸ H)] (ψ : AddChar (unitRing F ⧸ H) ℂ) :
    Dual F where
  toFun r := ⟨ψ (r : unitRing F ⧸ H), mem_sphere_zero_iff_norm.2 (AddChar.norm_apply ψ _)⟩
  map_zero_eq_one' := Circle.ext (by simp)
  map_add_eq_mul' a b := Circle.ext (by simp [AddChar.map_add_eq_mul])

private theorem coe_liftChar {H : AddSubgroup (unitRing F)} [Finite (unitRing F ⧸ H)]
    (ψ : AddChar (unitRing F ⧸ H) ℂ) (r : unitRing F) : ((liftChar ψ r : Circle) : ℂ) = ψ (r : unitRing F ⧸ H) :=
  rfl

private theorem liftChar_injective {H : AddSubgroup (unitRing F)} [Finite (unitRing F ⧸ H)] :
    Function.Injective (liftChar (H := H)) := by
  intro ψ ψ' h
  refine AddChar.ext _ _ fun g => ?_
  obtain ⟨r, rfl⟩ := QuotientAddGroup.mk_surjective g
  have := congrArg (fun χ : Dual F => ((χ r : Circle) : ℂ)) h
  simpa only [coe_liftChar] using this

/-- A character of `R` trivial on `H`, as a complex character of `R ⧸ H`. -/
private def descChar {H : AddSubgroup (unitRing F)} (t : Dual F) (ht : ∀ w ∈ H, t w = 1) :
    AddChar (unitRing F ⧸ H) ℂ where
  toFun g := Quotient.liftOn' g (fun r => ((t r : Circle) : ℂ)) fun a b hab => by
    have h1 : t (-a + b) = 1 := ht _ (QuotientAddGroup.leftRel_apply.1 hab)
    have h2 : t b = t a * t (-a + b) := by rw [← AddChar.map_add_eq_mul, add_neg_cancel_left]
    rw [h2, h1, mul_one]
  map_zero_eq_one' := by
    show ((t 0 : Circle) : ℂ) = 1
    rw [AddChar.map_zero_eq_one, Circle.coe_one]
  map_add_eq_mul' g g' := by
    induction g using QuotientAddGroup.induction_on with
    | H a =>
    induction g' using QuotientAddGroup.induction_on with
    | H b =>
    show ((t (a + b) : Circle) : ℂ) = (t a : ℂ) * (t b : ℂ)
    rw [AddChar.map_add_eq_mul, Circle.coe_mul]

private theorem liftChar_descChar {H : AddSubgroup (unitRing F)} [Finite (unitRing F ⧸ H)] (t : Dual F)
    (ht : ∀ w ∈ H, t w = 1) : liftChar (descChar t ht) = t :=
  AddChar.ext _ _ fun _ => Circle.ext rfl

/-- `conj (ψ g) = ψ (−g)` for a complex character of a finite group. -/
private theorem conj_addChar {G : Type*} [AddCommGroup G] [Finite G] (ψ : AddChar G ℂ) (g : G) :
    (starRingEnd ℂ) (ψ g) = ψ (-g) := by
  have h1 := AddChar.norm_apply ψ g
  have h2 : ψ (-g) * ψ g = 1 := by rw [← AddChar.map_add_eq_mul, neg_add_cancel, AddChar.map_zero_eq_one]
  have h3 : (starRingEnd ℂ) (ψ g) * ψ g = 1 := by
    rw [mul_comm, Complex.mul_conj, Complex.normSq_eq_norm_sq, h1]
    norm_num
  have h0 : ψ g ≠ 0 := fun h => by simp [h] at h1
  exact mul_right_cancel₀ h0 (h3.trans h2.symm)

/-- **Orthogonality**: `Σ_ψ conj ψ(g) = |G|·[g = 0]`. -/
private theorem sum_conj_addChar {G : Type*} [AddCommGroup G] [Fintype G] [DecidableEq G] (g : G) :
    ∑ ψ : AddChar G ℂ, (starRingEnd ℂ) (ψ g) = if g = 0 then (Fintype.card G : ℂ) else 0 := by
  simp only [conj_addChar]
  rw [AddChar.sum_apply_eq_ite]
  simp only [neg_eq_zero]

/-- `t (a − b) = t a · conj (t b)`. -/
private theorem coe_char_sub (t : Dual F) (a b : unitRing F) :
    ((t (a - b) : Circle) : ℂ) = (t a : ℂ) * (starRingEnd ℂ) (t b : ℂ) := by
  have h : t (a - b) = t a * (t b)⁻¹ := by
    rw [sub_eq_add_neg, AddChar.map_add_eq_mul, AddChar.map_neg_eq_inv]
  rw [h, Circle.coe_mul, Circle.coe_inv_eq_conj]

/-! ### Private helpers: the twisted weights at one level -/

section Level

variable {G : Type*} [Fintype G]

/-- The twisted sum `Σ_c t̄(x_c) χ(x_c)`. -/
private def twSum (x : G → unitRing F) (t χ : Dual F) : ℂ :=
  ∑ c, (starRingEnd ℂ) (t (x c) : ℂ) * (χ (x c) : ℂ)

/-- The weight `|Σ_c t̄(x_c) χ(x_c)|² / |G|²`, in `[0, 1]`. -/
private def twW (x : G → unitRing F) (t χ : Dual F) : ℝ := ‖twSum x t χ‖ ^ 2 / (Fintype.card G : ℝ) ^ 2

private theorem norm_twSum_le (x : G → unitRing F) (t χ : Dual F) : ‖twSum x t χ‖ ≤ Fintype.card G := by
  refine (norm_sum_le _ _).trans ?_
  simp only [norm_mul, RCLike.norm_conj, Circle.norm_coe, mul_one, Finset.sum_const, Finset.card_univ,
    nsmul_eq_mul]
  rfl

private theorem twW_nonneg (x : G → unitRing F) (t χ : Dual F) : 0 ≤ twW x t χ := by
  unfold twW
  positivity

private theorem twW_le_one [Nonempty G] (x : G → unitRing F) (t χ : Dual F) : twW x t χ ≤ 1 := by
  unfold twW
  have hG : (0 : ℝ) < Fintype.card G := by exact_mod_cast Fintype.card_pos
  rw [div_le_one (by positivity)]
  exact pow_le_pow_left₀ (norm_nonneg _) (norm_twSum_le x t χ) 2

private theorem measurable_twW (x : G → unitRing F) (t : Dual F) : Measurable (twW x t) := by
  unfold twW twSum
  refine Measurable.div_const (Measurable.pow_const ?_ 2) _
  exact (Finset.measurable_sum _ fun c _ => (measurable_evalChar (x c)).const_mul _).norm

/-- The weight as a double sum: `|G|² · twW = Σ_{c,c'} conj t(x_c − x_c') · χ(x_c − x_c')`. -/
private theorem twW_eq (x : G → unitRing F) (t χ : Dual F) :
    ((twW x t χ : ℝ) : ℂ) = ((Fintype.card G : ℂ) ^ 2)⁻¹ *
      ∑ c, ∑ c', (starRingEnd ℂ) (t (x c - x c') : ℂ) * (χ (x c - x c') : ℂ) := by
  unfold twW
  push_cast
  rw [div_eq_inv_mul]
  congr 1
  rw [← Complex.ofReal_pow, ← Complex.normSq_eq_norm_sq, ← Complex.mul_conj, twSum, map_sum, Finset.sum_mul_sum]
  refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun c' _ => ?_
  rw [coe_char_sub, coe_char_sub]
  simp only [map_mul, Complex.conj_conj]
  ring

end Level

