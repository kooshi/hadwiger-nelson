import Proofs.HadwigerNelson.Rigidity.ContinuityGroup
import Proofs.HadwigerNelson.Rigidity.Herglotz
import Mathlib.Analysis.Fourier.FiniteAbelian.PontryaginDuality
import Mathlib.Algebra.Order.Chebyshev

/-!
# Bochner's theorem for the topology `τ′_∅` (FS-131, job FS131-KR1; module M2b; skeleton)

**Read aloud, against the informal claim.** `bochnerOn_tauPrime : BochnerOn (tauPrime F)`: a finite measure on the dual of
`R = ℤ[U_F]` whose Fourier transform is continuous for the profinite-plus-archimedean topology is carried by the continuous
characters, which are `T + A` (`contChars_tauPrime`). It is J45 N2's `⟸` at `S = ∅` (`plans/FS84-SI-D-derivation.md`
ll. 128–130), the hypothesis `SpectralInputs.spectral_carried_iff` takes. The printed source of the step is Bochner's
theorem on a locally compact abelian group (`[Rudin1962]` 1.4.3, not held); this module proves it with no Bochner theorem on
`ℝ^m` and no profinite completion (`plans/FS131-KR1-chain-map.md` § 2.1, M2b).

**Route.** (1) `archimedean_support`: a measure whose transform is continuous for `archTop` is carried by `A` — restrict to
the lattices `5^{−k}c₀𝓞_L ⊆ R`, lift from their dual tori to `V*` through a box fundamental domain, bound the mass far out by
a one-variable Dirichlet-kernel inequality (tightness, uniform in `k`), take a limit by Prokhorov
(`isCompact_closure_of_isTightMeasureSet`), and compare the limit's characteristic function with the transform on the dense
subgroup `ℤ[1/5]c₀𝓞_L`; uniqueness (`measure_eq_of_fourier`) concludes. (2) `finite_quotient_nsmul` (J28V-7, `[LevitzMott1972]`
Thm 2.3): `R ⧸ N·R` is finite. (3) The profinite part: twisted Riemann sums over `R ⧸ N′·R` split `φ` into `Σ_{t ∈ T} ψ_t` with
each `t̄·ψ_t` positive-definite and archimedean-continuous; (1) carries each piece by `t·A`.

**Models.** `F = ⊥`; the point mass at the trivial character has constant transform, continuous for every topology, and is
carried by `TA F` (`one_mem_TA`).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs NumberField Filter Topology

noncomputable section

variable (F : Subfield ℝ)

/-- **J28V-7**: `N·R` has finite index in `R = ℤ[U_F]` for every `N ≥ 1` (`R` is torsion-free of rank `[L : ℚ]`). -/
theorem finite_quotient_nsmul [NumberField F] (N : ℕ) (hN : N ≠ 0) :
    Finite (unitRing F ⧸ (nsmulAddMonoidHom (α := unitRing F) N).range) := by
  sorry

/-- **Bochner in support form for the archimedean topology**: a finite measure on `R̂` whose transform is continuous for
`archTop F` is carried by the archimedean characters. -/
theorem archimedean_support [NumberField F] (ρ : Measure (Dual F)) [IsFiniteMeasure ρ]
    (h : @Continuous (unitRing F) ℂ (archTop F) _ fun y => ∫ χ, (χ y : ℂ) ∂ρ) : ρ (archChars (unitRing F))ᶜ = 0 := by
  sorry

open private archHom archTop_eq eventually_archTop norm_archHom_nsmul fivePow nsmul_fivePow inv_five_mem
  exists_nsmul_mem_of_mem_nhds_profTop from Proofs.HadwigerNelson.Rigidity.ContinuityGroup


section TwistedHelpers

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


/-- `t (a + b) = t a · t b`, in `ℂ`. -/
private theorem coe_char_add (t : Dual F) (a b : unitRing F) :
    ((t (a + b) : Circle) : ℂ) = (t a : ℂ) * (t b : ℂ) := by
  rw [AddChar.map_add_eq_mul, Circle.coe_mul]

/-! ### Private helpers: the measure side -/

section MeasureSide

variable (σ : Measure (Dual F)) [IsFiniteMeasure σ]

private theorem integrable_eval (y : unitRing F) : Integrable (fun χ : Dual F => (χ y : ℂ)) σ :=
  Integrable.of_bound (measurable_evalChar y).aestronglyMeasurable 1
    (Eventually.of_forall fun χ => by rw [Circle.norm_coe])

private theorem integrable_eval_mul (y : unitRing F) {V : Dual F → ℝ} (hV : Measurable V) (hV0 : ∀ χ, 0 ≤ V χ)
    (hV1 : ∀ χ, V χ ≤ 1) : Integrable (fun χ : Dual F => (χ y : ℂ) * (V χ : ℂ)) σ :=
  Integrable.of_bound ((measurable_evalChar y).mul (Complex.measurable_ofReal.comp hV)).aestronglyMeasurable 1
    (Eventually.of_forall fun χ => by
      rw [norm_mul, Circle.norm_coe, one_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (hV0 χ)]
      exact hV1 χ)

private theorem integrable_real {V : Dual F → ℝ} (hV : Measurable V) (hV0 : ∀ χ, 0 ≤ V χ) (hV1 : ∀ χ, V χ ≤ 1) :
    Integrable V σ :=
  Integrable.of_bound hV.aestronglyMeasurable 1
    (Eventually.of_forall fun χ => by rw [Real.norm_eq_abs, abs_of_nonneg (hV0 χ)]; exact hV1 χ)

/-- **A bounded non-negative weight on a finite measure, twisted by a character, has a positive-definite
transform.** -/
private theorem posDef_twisted (V : Dual F → ℝ) (hV : Measurable V) (hV0 : ∀ χ, 0 ≤ V χ) (hV1 : ∀ χ, V χ ≤ 1)
    (t : Dual F) :
    PosDef fun y => (starRingEnd ℂ) (t y : ℂ) * ∫ χ, (χ y : ℂ) * (V χ : ℂ) ∂σ := by
  intro s z
  set S : Dual F → ℂ := fun χ => ∑ a ∈ s, z a * (starRingEnd ℂ) (t a : ℂ) * (χ a : ℂ) with hS
  have hpt : ∀ χ : Dual F, (∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
      ((starRingEnd ℂ) (t (a - b) : ℂ) * ((χ (a - b) : ℂ) * (V χ : ℂ)))) =
      (((Complex.normSq (S χ) * V χ : ℝ)) : ℂ) := by
    intro χ
    rw [Complex.ofReal_mul, ← Complex.mul_conj, hS, map_sum, Finset.sum_mul_sum, Finset.sum_mul]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [coe_char_sub, coe_char_sub]
    simp only [map_mul, Complex.conj_conj, Complex.star_def]
    ring
  have hint : ∀ a b : unitRing F, Integrable (fun χ : Dual F => (χ (a - b) : ℂ) * (V χ : ℂ)) σ :=
    fun a b => integrable_eval_mul σ (a - b) hV hV0 hV1
  have hsum : (∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
      ((starRingEnd ℂ) (t (a - b) : ℂ) * ∫ χ, (χ (a - b) : ℂ) * (V χ : ℂ) ∂σ)) =
      ∫ χ, (((Complex.normSq (S χ) * V χ : ℝ)) : ℂ) ∂σ := by
    rw [← integral_congr_ae (Eventually.of_forall hpt),
      integral_finsetSum _ fun a _ => integrable_finsetSum _ fun b _ => ((hint a b).const_mul _).const_mul _]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [integral_finsetSum _ fun b _ => ((hint a b).const_mul _).const_mul _]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [integral_const_mul, integral_const_mul]
  dsimp only
  rw [hsum, integral_complex_ofReal]
  exact ⟨Complex.ofReal_im _, by
    rw [Complex.ofReal_re]
    exact integral_nonneg fun χ => mul_nonneg (Complex.normSq_nonneg _) (hV0 χ)⟩

/-- `Re u ≥ 1 − ‖u − 1‖`. -/
private theorem one_sub_norm_le_re (u : ℂ) : 1 - ‖u - 1‖ ≤ u.re := by
  have h := Complex.abs_re_le_norm (u - 1)
  rw [Complex.sub_re, Complex.one_re] at h
  linarith [neg_abs_le (u.re - 1)]

/-- `∫ Re χ(w) ≥ σ(univ) − ∫ ‖χ(w) − 1‖`. -/
private theorem re_integral_ge (w : unitRing F) :
    σ.real Set.univ - ∫ χ, ‖(χ w : ℂ) - 1‖ ∂σ ≤ (∫ χ, (χ w : ℂ) ∂σ).re := by
  have hre : ∫ χ, (χ w : ℂ).re ∂σ = (∫ χ, (χ w : ℂ) ∂σ).re := integral_re (integrable_eval σ w)
  rw [← hre]
  have h1 : Integrable (fun χ : Dual F => ‖(χ w : ℂ) - 1‖) σ := ((integrable_eval σ w).sub (integrable_const 1)).norm
  have h2 : ∫ χ, (1 - ‖(χ w : ℂ) - 1‖) ∂σ ≤ ∫ χ, (χ w : ℂ).re ∂σ :=
    integral_mono ((integrable_const (1 : ℝ)).sub h1) (integrable_eval σ w).re fun χ => one_sub_norm_le_re (χ w : ℂ)
  rw [integral_sub (integrable_const _) h1, integral_const, smul_eq_mul, mul_one] at h2
  exact h2

open scoped Classical in
/-- **The modulus of the transform at `M·R ∩ B_δ`**: from `τ′_∅`-continuity, `∫ ‖χ(w) − 1‖ dσ` is small on
`M·R ∩ B_δ` for some `M ≠ 0` and `δ > 0` (`‖u − 1‖ ≤ η + (2 − 2 Re u)/η` on the circle). -/
private theorem exists_E_small [NumberField F]
    (h : @Continuous (unitRing F) ℂ (tauPrime F) _ fun y => ∫ χ, (χ y : ℂ) ∂σ) {ε : ℝ} (hε : 0 < ε) :
    ∃ M : ℕ, M ≠ 0 ∧ ∃ δ > 0, ∀ s : unitRing F, ‖archHom F (M • s)‖ < δ →
      ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ < ε := by
  set m := σ.real Set.univ with hm
  set φ : unitRing F → ℂ := fun y => ∫ χ, (χ y : ℂ) ∂σ with hφ
  have hm0 : 0 ≤ m := measureReal_nonneg
  set η : ℝ := ε / (2 * (m + 1)) with hη
  have hη0 : 0 < η := by positivity
  have hct := @Continuous.tendsto _ _ (tauPrime F) _ φ h 0
  have hev : ∀ᶠ w in @nhds _ (tauPrime F) 0, ‖φ w - φ 0‖ < η * ε / 4 := by
    have := (Metric.tendsto_nhds.1 hct) (η * ε / 4) (by positivity)
    simpa [dist_eq_norm] using this
  rw [nhds_inf (t₁ := profTop F) (t₂ := archTop F)] at hev
  obtain ⟨t₁, ht₁, t₂, ht₂, hsub⟩ := Filter.mem_inf_iff_superset.1 hev
  obtain ⟨M, hM, hMt⟩ := exists_nsmul_mem_of_mem_nhds_profTop F ht₁
  obtain ⟨δ, hδ, hδt⟩ := (eventually_archTop F (p := fun r => r ∈ t₂)).1 ht₂
  refine ⟨M, hM, δ, hδ, fun s hs => ?_⟩
  have hw : ‖φ (M • s) - φ 0‖ < η * ε / 4 := hsub ⟨hMt s, hδt _ hs⟩
  have hφ0 : φ 0 = (m : ℂ) := by
    simp only [hφ, AddChar.map_zero_eq_one, Circle.coe_one, integral_const, Complex.real_smul, mul_one, hm]
  have hpt : ∀ χ : Dual F, ‖(χ (M • s) : ℂ) - 1‖ ≤ (η + 2 / η) - (2 / η) * (χ (M • s) : ℂ).re := by
    intro χ
    set u : ℂ := (χ (M • s) : ℂ)
    have hu : ‖u‖ = 1 := Circle.norm_coe _
    have hsq : ‖u - 1‖ ^ 2 = 2 - 2 * u.re := by
      have h1 := Complex.normSq_eq_norm_sq (u - 1)
      have h2 := Complex.normSq_eq_norm_sq u
      rw [hu, Complex.normSq_apply] at h2
      rw [← h1, Complex.normSq_apply]
      simp only [Complex.sub_re, Complex.one_re, Complex.sub_im, Complex.one_im, sub_zero]
      nlinarith
    have hfin : (η + 2 / η) - (2 / η) * u.re = η + (2 - 2 * u.re) / η := by ring
    rw [hfin, ← hsq]
    by_cases hle : ‖u - 1‖ ≤ η
    · have : 0 ≤ ‖u - 1‖ ^ 2 / η := by positivity
      linarith
    · push Not at hle
      have : ‖u - 1‖ ≤ ‖u - 1‖ ^ 2 / η := by
        rw [le_div_iff₀ hη0, sq]
        exact mul_le_mul_of_nonneg_left hle.le (norm_nonneg _)
      linarith
  have hint1 : Integrable (fun χ : Dual F => ‖(χ (M • s) : ℂ) - 1‖) σ :=
    ((integrable_eval σ (M • s)).sub (integrable_const 1)).norm
  have hintre : Integrable (fun χ : Dual F => (χ (M • s) : ℂ).re) σ := (integrable_eval σ (M • s)).re
  have hint2 : Integrable (fun χ : Dual F => (η + 2 / η) - (2 / η) * (χ (M • s) : ℂ).re) σ :=
    (integrable_const _).sub (hintre.const_mul _)
  have hre : ∫ χ, (χ (M • s) : ℂ).re ∂σ = (φ (M • s)).re := integral_re (integrable_eval σ (M • s))
  have hgap : m - (φ (M • s)).re < η * ε / 4 := by
    have := Complex.abs_re_le_norm (φ (M • s) - φ 0)
    rw [Complex.sub_re, hφ0, Complex.ofReal_re] at this
    rw [hφ0] at hw
    linarith [neg_abs_le ((φ (M • s)).re - m)]
  calc ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ ≤ ∫ χ, ((η + 2 / η) - (2 / η) * (χ (M • s) : ℂ).re) ∂σ :=
        integral_mono hint1 hint2 hpt
    _ = η * m + (2 / η) * (m - (φ (M • s)).re) := by
        rw [integral_sub (integrable_const _) (hintre.const_mul _), integral_const, integral_const_mul, hre,
          smul_eq_mul, ← hm]
        ring
    _ < ε / 2 + (2 / η) * (η * ε / 4) := by
        have h1 : η * m < ε / 2 := by
          rw [hη, div_mul_eq_mul_div, div_lt_div_iff₀ (by positivity) (by norm_num)]
          nlinarith
        have h2 : (2 / η) * (m - (φ (M • s)).re) < (2 / η) * (η * ε / 4) :=
          mul_lt_mul_of_pos_left hgap (by positivity)
        linarith
    _ = ε := by field_simp; ring

/-- The level-`n` twisted part `∫ χ(y) · twW(t, χ) dσ`. -/
private def twK {G : Type*} [Fintype G] (x : G → unitRing F) (t : Dual F) (y : unitRing F) : ℂ :=
  ∫ χ, (χ y : ℂ) * (twW x t χ : ℂ) ∂σ

section Level2

variable {G : Type*} [Fintype G] [Nonempty G]

omit [IsFiniteMeasure σ] [Nonempty G] in
private theorem twK_zero (x : G → unitRing F) (t : Dual F) :
    twK σ x t 0 = ((∫ χ, twW x t χ ∂σ : ℝ) : ℂ) := by
  simp only [twK, AddChar.map_zero_eq_one, Circle.coe_one, one_mul, integral_complex_ofReal]

private theorem norm_twK_le (x : G → unitRing F) (t : Dual F) (y : unitRing F) :
    ‖twK σ x t y‖ ≤ σ.real Set.univ := by
  have h := norm_integral_le_of_norm_le_const (μ := σ) (f := fun χ : Dual F => (χ y : ℂ) * (twW x t χ : ℂ))
    (C := 1) (Eventually.of_forall fun χ => by
      rw [norm_mul, Circle.norm_coe, one_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (twW_nonneg _ _ _)]
      exact twW_le_one _ _ _)
  rw [one_mul] at h
  exact h

private theorem posDef_twK (x : G → unitRing F) (t : Dual F) :
    PosDef fun y => (starRingEnd ℂ) (t y : ℂ) * twK σ x t y :=
  posDef_twisted σ (twW x t) (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t) t

end Level2

section Level3

variable {N : ℕ} [Fintype (unitRing F ⧸ nR F N)]

/-- **Parseval at one level**: the weights of the characters of `R ⧸ N·R` sum to `1`. -/
private theorem sum_twW_liftChar (x : unitRing F ⧸ nR F N → unitRing F)
    (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c) (χ : Dual F) :
    ∑ ψ : AddChar (unitRing F ⧸ nR F N) ℂ, twW x (liftChar ψ) χ = 1 := by
  classical
  apply Complex.ofReal_injective
  rw [Complex.ofReal_sum]
  simp only [twW_eq, coe_liftChar]
  rw [← Finset.mul_sum, Finset.sum_comm]
  have hin : ∀ c : unitRing F ⧸ nR F N, ∑ c', ∑ ψ : AddChar (unitRing F ⧸ nR F N) ℂ,
      (starRingEnd ℂ) (ψ ((x c - x c' : unitRing F) : unitRing F ⧸ nR F N)) * (χ (x c - x c') : ℂ) =
      Fintype.card (unitRing F ⧸ nR F N) := by
    intro c
    simp only [← Finset.sum_mul, sum_conj_addChar, QuotientAddGroup.mk_sub, hx, sub_eq_zero, ite_mul, zero_mul]
    rw [Finset.sum_ite_eq]
    simp
  rw [Finset.sum_congr rfl fun c _ => (Finset.sum_comm.trans (hin c)), Finset.sum_const, Finset.card_univ,
    nsmul_eq_mul, Complex.ofReal_one]
  have hG : (Fintype.card (unitRing F ⧸ nR F N) : ℂ) ≠ 0 := Nat.cast_ne_zero.2 Fintype.card_ne_zero
  field_simp

/-- A character of `R` trivial on `N·R`, unless `false`, read back from the quotient (the descent, or `1`). -/
private def descOr (t : Dual F) : AddChar (unitRing F ⧸ nR F N) ℂ :=
  open Classical in if h : ∀ w ∈ nR F N, t w = 1 then descChar t h else 1

/-- **Bessel at one level**: distinct characters trivial on `N·R` carry total weight at most `1`. -/
private theorem sum_twW_le (x : unitRing F ⧸ nR F N → unitRing F) (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c)
    (S : Finset (Dual F)) (hS : ∀ t ∈ S, ∀ w ∈ nR F N, t w = 1) (χ : Dual F) :
    ∑ t ∈ S, twW x t χ ≤ 1 := by
  classical
  have hld : ∀ t ∈ S, liftChar (descOr (N := N) t) = t := fun t ht => by
    rw [descOr, dif_pos (hS t ht), liftChar_descChar]
  have hinj : Set.InjOn (descOr (N := N)) (S : Set (Dual F)) := by
    intro a ha b hb hab
    rw [← hld a (Finset.mem_coe.1 ha), ← hld b (Finset.mem_coe.1 hb), hab]
  calc ∑ t ∈ S, twW x t χ = ∑ t ∈ S, twW x (liftChar (descOr (N := N) t)) χ :=
        Finset.sum_congr rfl fun t ht => by rw [hld t ht]
    _ = ∑ ψ ∈ S.image (descOr (N := N)), twW x (liftChar ψ) χ :=
        (Finset.sum_image (f := fun ψ => twW x (liftChar ψ) χ) hinj).symm
    _ ≤ ∑ ψ : AddChar (unitRing F ⧸ nR F N) ℂ, twW x (liftChar ψ) χ :=
        Finset.sum_le_univ_sum_of_nonneg fun ψ => twW_nonneg x _ χ
    _ = 1 := sum_twW_liftChar x hx χ

/-- **The remainder at one level**: `‖φ(y) − Σ_{t ∈ S} K_t(y)‖ ≤ σ(univ) − Σ_{t ∈ S} K_t(0)`. -/
private theorem norm_sub_sum_twK_le (x : unitRing F ⧸ nR F N → unitRing F)
    (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c) (S : Finset (Dual F)) (hS : ∀ t ∈ S, ∀ w ∈ nR F N, t w = 1)
    (y : unitRing F) :
    ‖(∫ χ, (χ y : ℂ) ∂σ) - ∑ t ∈ S, twK σ x t y‖ ≤ σ.real Set.univ - ∑ t ∈ S, ∫ χ, twW x t χ ∂σ := by
  set V : Dual F → ℝ := fun χ => 1 - ∑ t ∈ S, twW x t χ with hV
  have hV0 : ∀ χ, 0 ≤ V χ := fun χ => sub_nonneg.2 (sum_twW_le x hx S hS χ)
  have hVm : Measurable V := measurable_const.sub (Finset.measurable_sum _ fun t _ => measurable_twW x t)
  have hint : ∀ t ∈ S, Integrable (fun χ : Dual F => (χ y : ℂ) * (twW x t χ : ℂ)) σ := fun t _ =>
    integrable_eval_mul σ y (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t)
  have hintW : ∀ t ∈ S, Integrable (twW x t) σ := fun t _ =>
    integrable_real σ (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t)
  have h1 : (∫ χ, (χ y : ℂ) ∂σ) - ∑ t ∈ S, twK σ x t y = ∫ χ, (χ y : ℂ) * (V χ : ℂ) ∂σ := by
    have : (fun χ : Dual F => (χ y : ℂ) * (V χ : ℂ)) =
        fun χ => (χ y : ℂ) - ∑ t ∈ S, (χ y : ℂ) * (twW x t χ : ℂ) := by
      funext χ
      simp only [hV]
      push_cast
      rw [mul_sub, mul_one, Finset.mul_sum]
    rw [this, integral_sub (integrable_eval σ y) (integrable_finsetSum _ hint), integral_finsetSum _ hint]
    rfl
  rw [h1]
  refine (norm_integral_le_integral_norm _).trans (le_of_eq ?_)
  have h2 : (fun χ : Dual F => ‖(χ y : ℂ) * (V χ : ℂ)‖) = V := by
    funext χ
    rw [norm_mul, Circle.norm_coe, one_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (hV0 χ)]
  rw [h2, hV, integral_sub (integrable_const _) (integrable_finsetSum _ hintW), integral_finsetSum _ hintW,
    integral_const, smul_eq_mul, mul_one]

end Level3

end MeasureSide

/-! ### Private helpers: concentration on a fixed finite level, and continuity -/

section MeasureSide3

variable (σ : Measure (Dual F)) [IsFiniteMeasure σ]

/-- `|G|² ≤ |G₀| · #{(c, c') : π c = π c'}` (Cauchy–Schwarz on the fibre sizes). -/
private theorem card_sq_le_pairs {G G₀ : Type*} [Fintype G] [Fintype G₀] [DecidableEq G₀] (π : G → G₀) :
    ((Fintype.card G : ℝ)) ^ 2 ≤ Fintype.card G₀ * ∑ c : G, ∑ c' : G, if π c = π c' then (1 : ℝ) else 0 := by
  set f : G₀ → ℝ := fun g => ((Finset.univ.filter fun c => π c = g).card : ℝ) with hf
  have h1 : ∑ g, f g = Fintype.card G := by
    have := Finset.card_eq_sum_card_fiberwise (s := (Finset.univ : Finset G)) (t := (Finset.univ : Finset G₀))
      (f := π) fun _ _ => Finset.mem_coe.2 (Finset.mem_univ _)
    rw [Finset.card_univ] at this
    simp only [hf]
    exact_mod_cast this.symm
  have h2 : ∑ c : G, ∑ c' : G, (if π c = π c' then (1 : ℝ) else 0) = ∑ g, f g ^ 2 := by
    have hc : ∀ c : G, ∑ c' : G, (if π c = π c' then (1 : ℝ) else 0) = f (π c) := by
      intro c
      rw [Finset.sum_boole, hf]
      congr 2
      ext c'
      simp only [Finset.mem_filter, Finset.mem_univ, true_and, eq_comm]
    simp only [hc]
    rw [← Finset.sum_fiberwise (s := Finset.univ) (g := π) (f := fun c => f (π c))]
    refine Finset.sum_congr rfl fun g _ => ?_
    rw [Finset.sum_congr rfl fun c hc => by rw [(Finset.mem_filter.1 hc).2], Finset.sum_const, nsmul_eq_mul, sq]
  rw [h2, ← h1]
  have := sq_sum_le_card_mul_sum_sq (s := (Finset.univ : Finset G₀)) (f := f)
  rwa [Finset.card_univ] at this

open scoped Classical in
/-- **Concentration on a fixed level**: at any finer level whose representatives are small, the characters of
`R ⧸ N₀·R` carry weight at least `σ(univ) − ε`, once `∫ ‖χ(w) − 1‖ < ε` on `M·R ∩ B_δ` with `M ∣ N₀`. -/
private theorem concentration [NumberField F] {N N₀ : ℕ} [Fintype (unitRing F ⧸ nR F N)]
    [Fintype (unitRing F ⧸ nR F N₀)] (x : unitRing F ⧸ nR F N → unitRing F) {r : ℝ}
    (hr : ∀ c, ‖archHom F (x c)‖ < r) {M : ℕ} (hM : M ∣ N₀) {δ ε : ℝ} (hrδ : 2 * r ≤ δ)
    (hE : ∀ s, ‖archHom F (M • s)‖ < δ → ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ < ε) :
    σ.real Set.univ - ε ≤ ∑ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, ∫ χ, twW x (liftChar ψ) χ ∂σ := by
  set m := σ.real Set.univ with hm
  set π : unitRing F ⧸ nR F N → unitRing F ⧸ nR F N₀ := fun c => ((x c : unitRing F) : unitRing F ⧸ nR F N₀)
    with hπ
  have hcard : (0 : ℝ) < Fintype.card (unitRing F ⧸ nR F N) := by exact_mod_cast Fintype.card_pos
  have hcard₀ : (0 : ℝ) < Fintype.card (unitRing F ⧸ nR F N₀) := by exact_mod_cast Fintype.card_pos
  -- the pairs in one fibre are close in `N₀·R ∩ B_δ`
  have hpair : ∀ c c', π c = π c' → m - ε ≤ (∫ χ, (χ (x c - x c') : ℂ) ∂σ).re := by
    intro c c' h
    have hmem : x c - x c' ∈ nR F N₀ := by
      have h' := QuotientAddGroup.eq.1 h
      have e : x c - x c' = -(-x c + x c') := by abel
      rw [e]
      exact (nR F N₀).neg_mem h'
    obtain ⟨s, hs⟩ := hmem
    obtain ⟨k, hk⟩ := hM
    have hw : x c - x c' = M • (k • s) := by
      rw [← hs, nsmulAddMonoidHom_apply, hk, mul_nsmul']
    have hsmall : ‖archHom F (M • (k • s))‖ < δ := by
      rw [← hw, map_sub]
      calc ‖archHom F (x c) - archHom F (x c')‖ ≤ ‖archHom F (x c)‖ + ‖archHom F (x c')‖ := norm_sub_le _ _
        _ < r + r := add_lt_add (hr c) (hr c')
        _ = 2 * r := by ring
        _ ≤ δ := hrδ
    have h1 := hE (k • s) hsmall
    rw [← hw] at h1
    have h2 := re_integral_ge σ (x c - x c')
    linarith
  -- the weights of the level-`N₀` characters, as a double sum over the pairs in one fibre
  have hC : ∀ χ : Dual F, ((∑ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, twW x (liftChar ψ) χ : ℝ) : ℂ) =
      ((Fintype.card (unitRing F ⧸ nR F N) : ℂ) ^ 2)⁻¹ * ∑ c, ∑ c',
        (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℂ) else 0) * (χ (x c - x c') : ℂ) := by
    intro χ
    rw [Complex.ofReal_sum]
    simp only [twW_eq, coe_liftChar]
    rw [← Finset.mul_sum, Finset.sum_comm]
    congr 1
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun c' _ => ?_
    rw [← Finset.sum_mul, sum_conj_addChar, QuotientAddGroup.mk_sub]
    simp only [hπ, sub_eq_zero]
  have hintW : ∀ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, Integrable (twW x (liftChar ψ)) σ := fun ψ =>
    integrable_real σ (measurable_twW x _) (twW_nonneg x _) (twW_le_one x _)
  rw [← integral_finsetSum _ fun ψ _ => hintW ψ]
  set I := ∫ χ, ∑ ψ : AddChar (unitRing F ⧸ nR F N₀) ℂ, twW x (liftChar ψ) χ ∂σ with hI
  have hI0 : 0 ≤ I := integral_nonneg fun χ => Finset.sum_nonneg fun ψ _ => twW_nonneg x _ χ
  have hIC : (I : ℂ) = ((Fintype.card (unitRing F ⧸ nR F N) : ℂ) ^ 2)⁻¹ * ∑ c, ∑ c',
      (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℂ) else 0) * ∫ χ, (χ (x c - x c') : ℂ) ∂σ := by
    rw [hI, ← integral_complex_ofReal, integral_congr_ae (Eventually.of_forall hC), integral_const_mul,
      integral_finsetSum _ fun c _ => integrable_finsetSum _ fun c' _ => (integrable_eval σ _).const_mul _]
    congr 1
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [integral_finsetSum _ fun c' _ => (integrable_eval σ _).const_mul _]
    refine Finset.sum_congr rfl fun c' _ => ?_
    rw [integral_const_mul]
  have hIre : I = ((Fintype.card (unitRing F ⧸ nR F N) : ℝ) ^ 2)⁻¹ * ∑ c, ∑ c',
      (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℝ) * (∫ χ, (χ (x c - x c') : ℂ) ∂σ).re else 0) := by
    have := congrArg Complex.re hIC
    rw [Complex.ofReal_re] at this
    rw [this]
    have e : ((Fintype.card (unitRing F ⧸ nR F N) : ℂ) ^ 2)⁻¹ =
        (((Fintype.card (unitRing F ⧸ nR F N) : ℝ) ^ 2)⁻¹ : ℝ) := by push_cast; rfl
    rw [e, Complex.re_ofReal_mul, Complex.re_sum]
    congr 1
    refine Finset.sum_congr rfl fun c _ => ?_
    rw [Complex.re_sum]
    refine Finset.sum_congr rfl fun c' _ => ?_
    split_ifs
    · rw [← Complex.ofReal_natCast, Complex.re_ofReal_mul]
    · rw [zero_mul, Complex.zero_re]
  by_cases hme : m - ε ≤ 0
  · linarith
  push Not at hme
  have hlow : ((Fintype.card (unitRing F ⧸ nR F N₀) : ℝ) * (m - ε)) *
      (∑ c, ∑ c', if π c = π c' then (1 : ℝ) else 0) ≤
      ∑ c, ∑ c', (if π c = π c' then (Fintype.card (unitRing F ⧸ nR F N₀) : ℝ) *
        (∫ χ, (χ (x c - x c') : ℂ) ∂σ).re else 0) := by
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun c _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun c' _ => ?_
    split_ifs with h
    · rw [mul_one]
      exact mul_le_mul_of_nonneg_left (hpair c c' h) hcard₀.le
    · rw [mul_zero]
  have hcs := card_sq_le_pairs π
  rw [hIre]
  rw [← div_eq_inv_mul, le_div_iff₀ (pow_pos hcard 2)]
  nlinarith

open scoped Classical in
/-- **Continuity at one level**: the twisted part moves by at most `ε` under a shift `z` with
`‖z‖ + 2r < δ`, once `∫ ‖χ(w) − 1‖ < ε` on `M·R ∩ B_δ` with `M ∣ N` (reindex the cosets by `c ↦ c + [z]`). -/
private theorem twK_cont [NumberField F] {N : ℕ} [Fintype (unitRing F ⧸ nR F N)]
    (x : unitRing F ⧸ nR F N → unitRing F) (hx : ∀ c, (x c : unitRing F ⧸ nR F N) = c) {r : ℝ}
    (hr : ∀ c, ‖archHom F (x c)‖ < r) {t : Dual F} (ht : ∀ w ∈ nR F N, t w = 1) {M : ℕ} (hMN : M ∣ N)
    {δ ε : ℝ} (hE : ∀ s, ‖archHom F (M • s)‖ < δ → ∫ χ, ‖(χ (M • s) : ℂ) - 1‖ ∂σ < ε)
    (y z : unitRing F) (hz : ‖archHom F z‖ + 2 * r < δ) :
    ‖(starRingEnd ℂ) (t (y + z) : ℂ) * twK σ x t (y + z) - (starRingEnd ℂ) (t y : ℂ) * twK σ x t y‖ ≤ ε := by
  have hcard : (0 : ℝ) < Fintype.card (unitRing F ⧸ nR F N) := by exact_mod_cast Fintype.card_pos
  set zq : (unitRing F ⧸ nR F N) := (z : (unitRing F ⧸ nR F N)) with hzq
  set w : (unitRing F ⧸ nR F N) → unitRing F := fun c => z + x c - x (c + zq) with hw
  have hwmem : ∀ c, w c ∈ nR F N := by
    intro c
    rw [← QuotientAddGroup.eq_zero_iff, hw]
    simp only [QuotientAddGroup.mk_sub, QuotientAddGroup.mk_add, hx, hzq]
    abel
  have hwE : ∀ c, ∫ χ, ‖(χ (w c) : ℂ) - 1‖ ∂σ < ε := by
    intro c
    obtain ⟨s, hs⟩ := hwmem c
    obtain ⟨k, hk⟩ := hMN
    have hw' : w c = M • (k • s) := by rw [← hs, nsmulAddMonoidHom_apply, hk, mul_nsmul']
    rw [hw']
    refine hE (k • s) ?_
    rw [← hw', hw, map_sub, map_add]
    calc ‖archHom F z + archHom F (x c) - archHom F (x (c + zq))‖
        ≤ ‖archHom F z‖ + ‖archHom F (x c)‖ + ‖archHom F (x (c + zq))‖ := by
          refine (norm_sub_le _ _).trans ?_
          gcongr
          exact norm_add_le _ _
      _ < ‖archHom F z‖ + r + r := by linarith [hr c, hr (c + zq)]
      _ < δ := by linarith
  -- pointwise: `‖t̄(z)χ(z) − 1‖ · twW ≤ |(unitRing F ⧸ nR F N)|⁻¹ Σ_c ‖χ(w_c) − 1‖`
  have hpt : ∀ χ : Dual F, ‖(starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) - 1‖ * twW x t χ ≤
      (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * ∑ c, ‖(χ (w c) : ℂ) - 1‖ := by
    intro χ
    set a : (unitRing F ⧸ nR F N) → ℂ := fun c => (starRingEnd ℂ) (t (x c) : ℂ) * (χ (x c) : ℂ) with ha
    have hna : ∀ c, ‖a c‖ = 1 := fun c => by
      rw [ha, norm_mul, RCLike.norm_conj, Circle.norm_coe, Circle.norm_coe, one_mul]
    set v : ℂ := (starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) with hv
    have hA : twSum x t χ = ∑ c, a c := rfl
    have hshift : ∑ c, a c = ∑ c, a (c + zq) :=
      (Fintype.sum_equiv (Equiv.addRight zq) (fun c => a (c + zq)) a fun c => rfl).symm
    have hva : ∀ c, v * a c = a (c + zq) * (χ (w c) : ℂ) := by
      intro c
      have e : z + x c = x (c + zq) + w c := by
        show z + x c = x (c + zq) + (z + x c - x (c + zq))
        exact (add_sub_cancel _ _).symm
      have htw : ((t (w c) : Circle) : ℂ) = 1 := by rw [ht _ (hwmem c), Circle.coe_one]
      have h1 : v * a c = (starRingEnd ℂ) (t (z + x c) : ℂ) * (χ (z + x c) : ℂ) := by
        rw [hv, ha, coe_char_add, coe_char_add, map_mul]
        ring
      rw [h1, e, coe_char_add, coe_char_add, map_mul, htw, map_one, ha]
      ring
    have hdiff : ‖v * twSum x t χ - twSum x t χ‖ ≤ ∑ c, ‖(χ (w c) : ℂ) - 1‖ := by
      rw [hA, Finset.mul_sum, Finset.sum_congr rfl fun c _ => hva c, hshift, ← Finset.sum_sub_distrib]
      refine (norm_sum_le _ _).trans (Finset.sum_le_sum fun c _ => ?_)
      rw [← mul_sub_one, norm_mul, hna, one_mul]
    have hnA := norm_twSum_le x t χ
    have hkey : ‖v - 1‖ * ‖twSum x t χ‖ ≤ ∑ c, ‖(χ (w c) : ℂ) - 1‖ := by
      rw [← norm_mul, sub_one_mul]
      exact hdiff
    unfold twW
    rw [mul_div_assoc', div_le_iff₀ (by positivity)]
    have hS0 : 0 ≤ ∑ c, ‖(χ (w c) : ℂ) - 1‖ := Finset.sum_nonneg fun c _ => norm_nonneg _
    calc ‖v - 1‖ * ‖twSum x t χ‖ ^ 2 = (‖v - 1‖ * ‖twSum x t χ‖) * ‖twSum x t χ‖ := by ring
      _ ≤ (∑ c, ‖(χ (w c) : ℂ) - 1‖) * Fintype.card (unitRing F ⧸ nR F N) :=
          mul_le_mul hkey hnA (norm_nonneg _) hS0
      _ = (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * (∑ c, ‖(χ (w c) : ℂ) - 1‖) * (Fintype.card (unitRing F ⧸ nR F N) : ℝ) ^ 2 := by
          field_simp
  -- integrate
  have hint : ∀ u : unitRing F, Integrable (fun χ : Dual F => (χ u : ℂ) * (twW x t χ : ℂ)) σ := fun u =>
    integrable_eval_mul σ u (measurable_twW x t) (twW_nonneg x t) (twW_le_one x t)
  have hdiffK : (starRingEnd ℂ) (t (y + z) : ℂ) * twK σ x t (y + z) - (starRingEnd ℂ) (t y : ℂ) * twK σ x t y =
      ∫ χ, ((starRingEnd ℂ) (t y : ℂ) * (χ y : ℂ)) * (((starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) - 1) *
        (twW x t χ : ℂ)) ∂σ := by
    rw [twK, twK, ← integral_const_mul, ← integral_const_mul, ← integral_sub ((hint _).const_mul _)
      ((hint _).const_mul _)]
    refine integral_congr_ae (Eventually.of_forall fun χ => ?_)
    simp only [coe_char_add, map_mul]
    ring
  rw [hdiffK]
  have hintS : Integrable (fun χ : Dual F => (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * ∑ c, ‖(χ (w c) : ℂ) - 1‖) σ :=
    (integrable_finsetSum _ fun c _ => ((integrable_eval σ (w c)).sub (integrable_const 1)).norm).const_mul _
  calc ‖∫ χ, ((starRingEnd ℂ) (t y : ℂ) * (χ y : ℂ)) * (((starRingEnd ℂ) (t z : ℂ) * (χ z : ℂ) - 1) *
        (twW x t χ : ℂ)) ∂σ‖
      ≤ ∫ χ, (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * ∑ c, ‖(χ (w c) : ℂ) - 1‖ ∂σ := by
        refine norm_integral_le_of_norm_le hintS (Eventually.of_forall fun χ => ?_)
        rw [norm_mul, norm_mul, norm_mul, RCLike.norm_conj, Circle.norm_coe, Circle.norm_coe, one_mul, one_mul,
          Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (twW_nonneg x t χ)]
        exact hpt χ
    _ = (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * ∑ c, ∫ χ, ‖(χ (w c) : ℂ) - 1‖ ∂σ := by
        rw [integral_const_mul, integral_finsetSum (f := fun c (χ : Dual F) => ‖(χ (w c) : ℂ) - 1‖) _ fun c _ =>
          ((integrable_eval σ (w c)).sub (integrable_const 1)).norm]
    _ ≤ (Fintype.card (unitRing F ⧸ nR F N) : ℝ)⁻¹ * ∑ _c : (unitRing F ⧸ nR F N), ε := by
        gcongr with c
        exact (hwE c).le
    _ = ε := by
        rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
        field_simp

end MeasureSide3

/-- A character of `R ⧸ N·R`, read on `R`, kills `N·R`. -/
private theorem liftChar_eq_one {N : ℕ} [Finite (unitRing F ⧸ nR F N)] (ψ : AddChar (unitRing F ⧸ nR F N) ℂ)
    {w : unitRing F} (hw : w ∈ nR F N) : liftChar ψ w = 1 :=
  Circle.ext (by
    rw [coe_liftChar, (QuotientAddGroup.eq_zero_iff w).2 hw, AddChar.map_zero_eq_one, Circle.coe_one])

private theorem nR_mono {N N' : ℕ} (h : N ∣ N') : nR F N' ≤ nR F N := by
  rintro w ⟨s, rfl⟩
  obtain ⟨k, rfl⟩ := h
  exact ⟨k • s, by rw [nsmulAddMonoidHom_apply, nsmulAddMonoidHom_apply, mul_nsmul']⟩

end TwistedHelpers

/-- **The twisted parts** (the profinite step; the hard leaf of M2b): a finite measure on `R̂` with `τ′_∅`-continuous transform
`φ` has `φ = Σ_{t ∈ T} ψ_t` pointwise, with each `t̄·ψ_t` positive-definite and continuous for `archTop`, and the masses
`ψ_t 0` summable. `ψ_t(y) = lim_{N′} |R ⧸ N′R|⁻¹ Σ_c t̄(x_c) φ(y + x_c)` over arch-small representatives `x_c`. -/
theorem exists_twisted_parts [NumberField F] (σ : Measure (Dual F)) [IsFiniteMeasure σ]
    (h : @Continuous (unitRing F) ℂ (tauPrime F) _ fun y => ∫ χ, (χ y : ℂ) ∂σ) :
    ∃ ψ : torsionChars (unitRing F) → unitRing F → ℂ,
      (∀ t : torsionChars (unitRing F), PosDef fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y) ∧
      (∀ t : torsionChars (unitRing F),
        @Continuous (unitRing F) ℂ (archTop F) _ fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y) ∧
      Summable (fun t => (ψ t 0).re) ∧ ∀ y, HasSum (fun t => ψ t y) (∫ χ, (χ y : ℂ) ∂σ) := by
  classical
  set m := σ.real Set.univ with hm
  set φ : unitRing F → ℂ := fun y => ∫ χ, (χ y : ℂ) ∂σ with hφ
  -- the levels `(n + 1)!` and their small representatives
  have hNn0 : ∀ n : ℕ, (n + 1).factorial ≠ 0 := fun n => Nat.factorial_ne_zero _
  have hdvd : ∀ M : ℕ, M ≠ 0 → ∀ n : ℕ, M ≤ n + 1 → M ∣ (n + 1).factorial := fun M hM n hn =>
    Nat.dvd_factorial (Nat.pos_of_ne_zero hM) hn
  letI hfin : ∀ n : ℕ, Fintype (unitRing F ⧸ nR F (n + 1).factorial) := fun n =>
    @Fintype.ofFinite _ (finite_quotient_nsmul F _ (hNn0 n))
  have hrep := fun n : ℕ => exists_reps F ((n + 1).factorial) (hNn0 n) (δ := 1 / ((n : ℝ) + 1)) (by positivity)
  choose x hx hxr using hrep
  have hsmallr : ∀ η > 0, ∀ᶠ n : ℕ in atTop, 2 * (1 / ((n : ℝ) + 1)) < η := by
    intro η hη
    have h0 : Tendsto (fun n : ℕ => 2 * (1 / ((n : ℝ) + 1))) atTop (𝓝 0) := by
      simpa using tendsto_one_div_add_atTop_nhds_zero_nat.const_mul (2 : ℝ)
    exact h0.eventually (gt_mem_nhds hη)
  -- every torsion character is trivial on `(n + 1)!·R` from some level on
  have htriv : ∀ t : torsionChars (unitRing F), ∀ᶠ n : ℕ in atTop,
      ∀ w ∈ nR F (n + 1).factorial, (t : Dual F) w = 1 := by
    rintro ⟨t, N₀, hN₀, ht⟩
    filter_upwards [eventually_ge_atTop N₀] with n hn
    rintro w ⟨s, rfl⟩
    obtain ⟨k, hk⟩ := hdvd N₀ hN₀ n (by omega)
    show t (((n + 1).factorial) • s) = 1
    rw [hk, mul_nsmul', AddChar.map_nsmul_eq_pow, ← AddChar.pow_apply, ht, AddChar.one_apply]
  -- the parts at level `n`
  set P : ℕ → torsionChars (unitRing F) → unitRing F → ℂ := fun n t y =>
    if ∀ w ∈ nR F (n + 1).factorial, (t : Dual F) w = 1 then twK σ (x n) t y else 0 with hP
  have hPb : ∀ n t y, ‖P n t y‖ ≤ m := by
    intro n t y
    simp only [hP]
    split_ifs
    · exact norm_twK_le σ (x n) t y
    · rw [norm_zero]
      exact measureReal_nonneg
  -- an ultrafilter limit of the parts
  set U : Ultrafilter ℕ := Ultrafilter.of atTop with hUdef
  have hU : (U : Filter ℕ) ≤ atTop := Ultrafilter.of_le atTop
  have hlim : ∀ t y, ∃ L, Tendsto (fun n => P n t y) (U : Filter ℕ) (𝓝 L) := by
    intro t y
    obtain ⟨L, -, hL⟩ := (isCompact_closedBall (0 : ℂ) m).ultrafilter_le_nhds (U.map fun n => P n t y) (by
      rw [Ultrafilter.coe_map]
      exact Filter.le_principal_iff.2 (Filter.mem_map.2 (Filter.univ_mem' fun n =>
        mem_closedBall_zero_iff.2 (hPb n t y))))
    exact ⟨L, by rw [Ultrafilter.coe_map] at hL; exact hL⟩
  choose ψ hψ using hlim
  have hev : ∀ t : torsionChars (unitRing F), ∀ᶠ n in (U : Filter ℕ), P n t = twK σ (x n) t := fun t =>
    ((htriv t).filter_mono hU).mono fun n hn => funext fun y => by simp only [hP, if_pos hn]
  -- (1) each `t̄·ψ_t` is positive-definite: a limit of positive-definite functions
  have hPD : ∀ t : torsionChars (unitRing F), PosDef fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y := by
    intro t s z
    set Q : ℕ → ℂ := fun n => ∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
      ((starRingEnd ℂ) ((t : Dual F) (a - b) : ℂ) * P n t (a - b)) with hQ
    have hQt : Tendsto Q (U : Filter ℕ) (𝓝 (∑ a ∈ s, ∑ b ∈ s, z a * star (z b) *
        ((starRingEnd ℂ) ((t : Dual F) (a - b) : ℂ) * ψ t (a - b)))) :=
      tendsto_finsetSum _ fun a _ => tendsto_finsetSum _ fun b _ => ((hψ t (a - b)).const_mul _).const_mul _
    have hQev : ∀ᶠ n in (U : Filter ℕ), (Q n).im = 0 ∧ 0 ≤ (Q n).re := (hev t).mono fun n hn => by
      have h1 := posDef_twK σ (x n) (t : Dual F) s z
      simp only [hQ, hn]
      exact h1
    have him := (Complex.continuous_im.tendsto _).comp hQt
    have hre := (Complex.continuous_re.tendsto _).comp hQt
    exact ⟨tendsto_nhds_unique him (tendsto_const_nhds.congr' (hQev.mono fun n hn => hn.1.symm)),
      ge_of_tendsto hre (hQev.mono fun n hn => hn.2)⟩
  -- (2) each `t̄·ψ_t` is continuous for `archTop`: the level estimate passes to the limit
  have hcont : ∀ t : torsionChars (unitRing F),
      @Continuous (unitRing F) ℂ (archTop F) _ fun y => (starRingEnd ℂ) ((t : Dual F) y : ℂ) * ψ t y := by
    intro t
    refine (@continuous_iff_continuousAt _ _ (archTop F) _ _).2 fun y => ?_
    show Tendsto _ (@nhds _ (archTop F) y) _
    rw [archTop_eq, nhds_induced, Metric.tendsto_nhds]
    intro ε hε
    obtain ⟨M, hM, δ, hδ, hE⟩ := exists_E_small σ h (half_pos hε)
    have hball : (archHom F) ⁻¹' Metric.ball (archHom F y) (δ / 2) ∈
        Filter.comap (archHom F) (𝓝 (archHom F y)) :=
      Filter.preimage_mem_comap (Metric.ball_mem_nhds _ (half_pos hδ))
    filter_upwards [hball] with y' hy'
    rw [Set.mem_preimage, Metric.mem_ball, dist_eq_norm] at hy'
    have hyz : y + (y' - y) = y' := by abel
    have hzn : ‖archHom F (y' - y)‖ < δ / 2 := by rw [map_sub]; exact hy'
    have hlev : ∀ᶠ n in (U : Filter ℕ), ‖(starRingEnd ℂ) ((t : Dual F) y' : ℂ) * P n t y' -
        (starRingEnd ℂ) ((t : Dual F) y : ℂ) * P n t y‖ ≤ ε / 2 := by
      filter_upwards [hev t, (htriv t).filter_mono hU, (eventually_ge_atTop M).filter_mono hU, (hsmallr (δ / 2) (half_pos hδ)).filter_mono hU]
        with n hn hn1 hn2 hn3
      rw [hn, ← hyz]
      exact twK_cont σ (x n) (hx n) (hxr n) hn1 (hdvd M hM n (by omega)) hE y (y' - y) (by linarith)
    have hl := (((hψ t y').const_mul ((starRingEnd ℂ) ((t : Dual F) y' : ℂ))).sub
      ((hψ t y).const_mul ((starRingEnd ℂ) ((t : Dual F) y : ℂ)))).norm
    have := le_of_tendsto hl hlev
    rw [dist_eq_norm]
    linarith
  -- the remainder at level `n`, for a finite set of torsion characters
  have hlevS : ∀ n (S : Finset (torsionChars (unitRing F))) y,
      ‖φ y - ∑ t ∈ S, P n t y‖ ≤ m - ∑ t ∈ S, (P n t 0).re := by
    intro n S y
    set S' : Finset (Dual F) := (S.filter fun t : torsionChars (unitRing F) => ∀ w ∈ nR F (n + 1).factorial, (t : Dual F) w = 1).map
      (Function.Embedding.subtype _) with hS'
    have hS'triv : ∀ t ∈ S', ∀ w ∈ nR F (n + 1).factorial, t w = 1 := by
      intro t ht
      rw [hS', Finset.mem_map] at ht
      obtain ⟨t', ht', rfl⟩ := ht
      exact (Finset.mem_filter.1 ht').2
    have hsum : ∀ y, ∑ t ∈ S, P n t y = ∑ t ∈ S', twK σ (x n) t y := by
      intro y
      rw [hS', Finset.sum_map, Finset.sum_filter]
      rfl
    have hsum0 : ∑ t ∈ S, (P n t 0).re = ∑ t ∈ S', ∫ χ, twW (x n) t χ ∂σ := by
      rw [← Complex.re_sum, hsum 0, Complex.re_sum]
      refine Finset.sum_congr rfl fun t _ => ?_
      rw [twK_zero, Complex.ofReal_re]
    rw [hsum y, hsum0]
    exact norm_sub_sum_twK_le σ (x n) (hx n) S' hS'triv y
  -- (3) the masses: non-negative, with partial sums at most `σ(univ)`
  have hre0 : ∀ t, 0 ≤ (ψ t 0).re := fun t =>
    ge_of_tendsto ((Complex.continuous_re.tendsto _).comp (hψ t 0)) (Eventually.of_forall fun n => by
      simp only [Function.comp, hP]
      split_ifs
      · rw [twK_zero, Complex.ofReal_re]
        exact integral_nonneg fun χ => twW_nonneg _ _ _
      · rw [Complex.zero_re])
  have hpart : ∀ (S : Finset (torsionChars (unitRing F))) y,
      ‖φ y - ∑ t ∈ S, ψ t y‖ ≤ m - ∑ t ∈ S, (ψ t 0).re := by
    intro S y
    have h1 : Tendsto (fun n => ‖φ y - ∑ t ∈ S, P n t y‖) (U : Filter ℕ) (𝓝 ‖φ y - ∑ t ∈ S, ψ t y‖) :=
      (tendsto_const_nhds.sub (tendsto_finsetSum _ fun t _ => hψ t y)).norm
    have h2 : Tendsto (fun n => m - ∑ t ∈ S, (P n t 0).re) (U : Filter ℕ) (𝓝 (m - ∑ t ∈ S, (ψ t 0).re)) :=
      tendsto_const_nhds.sub (tendsto_finsetSum _ fun t _ => (Complex.continuous_re.tendsto _).comp (hψ t 0))
    exact le_of_tendsto_of_tendsto' h1 h2 fun n => hlevS n S y
  have hsummable : Summable fun t => (ψ t 0).re := summable_of_sum_le (fun t => hre0 t) fun S => by
    have := hpart S 0
    linarith [norm_nonneg (φ 0 - ∑ t ∈ S, ψ t 0)]
  -- (4) concentration on the characters of one finite level
  have hconc : ∀ ε > 0, ∃ S₀ : Finset (torsionChars (unitRing F)), m - ε ≤ ∑ t ∈ S₀, (ψ t 0).re := by
    intro ε hε
    obtain ⟨M, hM, δ, hδ, hE⟩ := exists_E_small σ h hε
    have hMN₀ : M ∣ (M + 1).factorial := hdvd M hM M (by omega)
    let lt : AddChar (unitRing F ⧸ nR F (M + 1).factorial) ℂ → torsionChars (unitRing F) := fun ψ' =>
      ⟨liftChar ψ', (M + 1).factorial, hNn0 M, AddChar.ext _ _ fun r => by
        rw [AddChar.pow_apply, ← AddChar.map_nsmul_eq_pow, AddChar.one_apply]
        exact liftChar_eq_one ψ' ⟨r, rfl⟩⟩
    have hlt_inj : Function.Injective lt := fun a b hab => liftChar_injective (congrArg Subtype.val hab)
    refine ⟨Finset.univ.image lt, ?_⟩
    rw [Finset.sum_image fun a _ b _ hab => hlt_inj hab]
    have hlev : ∀ᶠ n in (U : Filter ℕ), m - ε ≤ ∑ ψ' : AddChar (unitRing F ⧸ nR F (M + 1).factorial) ℂ,
        (P n (lt ψ') 0).re := by
      filter_upwards [(eventually_ge_atTop M).filter_mono hU, (hsmallr δ hδ).filter_mono hU] with n hn1 hn2
      have hdiv : (M + 1).factorial ∣ (n + 1).factorial := Nat.factorial_dvd_factorial (by omega)
      have htr : ∀ ψ' : AddChar (unitRing F ⧸ nR F (M + 1).factorial) ℂ,
          ∀ w ∈ nR F (n + 1).factorial, ((lt ψ' : torsionChars (unitRing F)) : Dual F) w = 1 :=
        fun ψ' w hw => liftChar_eq_one ψ' (nR_mono hdiv hw)
      have hval : ∀ ψ', (P n (lt ψ') 0).re = ∫ χ, twW (x n) (liftChar ψ') χ ∂σ := fun ψ' => by
        simp only [hP, if_pos (htr ψ')]
        rw [twK_zero, Complex.ofReal_re]
      simp only [hval]
      exact concentration σ (x n) (hxr n) hMN₀ hn2.le hE
    exact ge_of_tendsto (tendsto_finsetSum _ fun ψ' _ => (Complex.continuous_re.tendsto _).comp (hψ (lt ψ') 0))
      hlev
  refine ⟨ψ, hPD, hcont, hsummable, fun y => ?_⟩
  unfold HasSum
  rw [SummationFilter.unconditional_filter, Metric.tendsto_atTop]
  intro ε hε
  obtain ⟨S₀, hS₀⟩ := hconc (ε / 2) (half_pos hε)
  refine ⟨S₀, fun S hS => ?_⟩
  have h1 := hpart S y
  have h2 : ∑ t ∈ S₀, (ψ t 0).re ≤ ∑ t ∈ S, (ψ t 0).re :=
    Finset.sum_le_sum_of_subset_of_nonneg hS fun t _ _ => hre0 t
  rw [dist_eq_norm, norm_sub_rev]
  linarith

/-- **Bochner's theorem for `τ′_∅`** (J45 N2's `⟸` at `S = ∅`): each `t̄·ψ_t` of `exists_twisted_parts` is the transform of a
measure `ρ_t` (`bochnerHerglotz_of_countable`), carried by `A` (`archimedean_support`); `Σ_t (t ·)_* ρ_t` has transform `φ`
and is carried by `T·A`; uniqueness (`measure_eq_of_fourier`) identifies it with `σ`. -/
theorem bochnerOn_tauPrime [NumberField F] : BochnerOn (tauPrime F) := by
  sorry

end

end HadwigerNelson.Rigidity
