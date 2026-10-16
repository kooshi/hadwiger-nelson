import Proofs.HadwigerNelson.Collapse.Thick
import Proofs.HadwigerNelson.Arith.RatioBound

/-!
# Mixing on the completion: two sets with null edges across the unit vectors cannot both be large (FS-131, job FS131-KCL1; module C5)

**Read aloud, against the informal claim** (V1-L6's edge inequality, `plans/FS103-V1-verification.md` ll. 143–158; V2 L3,
ll. 153–160): for measurable `A, B` in the compact part `K` of the completion with `Haar(A ∩ (B − ιK u)) = 0` at every unit
vector `u`, and `a = Haar A`, `b = Haar B`,

  `ab ≤ c·√(a(1 − a))·√(b(1 − b))`

over a uniformly `c`-thick field. With `a, b ≥ θ > c/(1 + c)` the inequality fails, so two such sets are not both of measure
at least `θ` — the edge inequality the selection reads (`Collapse/Selection`).

**Route — the finite levels, no Fourier analysis on `K`** (record § 3.2, decision 3). At level `k` let `E_k` average over the
cosets of `ker (proj k)`. It commutes with every translation, so the edge integral splits into
* a **finite-group term** on the level group `LevImg F k` with connection set `levU F k` — `finite_mixing`, Fourier analysis on a
  finite abelian group (`RatioBound`'s technique, two-sided, for `[0, 1]`-valued functions), fed by `levelThick`; and
* a **remainder** bounded by `√(levelResid A k)·√(levelResid B k)` (Cauchy–Schwarz; the translations preserve Haar measure),
which tends to `0` (`tendsto_levelResid`, from `Rigidity.Counting.tendsto_haarK_bad`). So `mixing_at_level` holds at every level,
and `mixing_K` in the limit.

**Models.** `finite_mixing` at `G = ZMod 2`, `S = {1}`, `c = 1` (a spec example). `mixing_K`'s hypotheses hold with `B = ∅` at
every field; with `A, B` of positive measure they hold at a thick field exactly when the sets are spread over different cosets at
every level, as the slice's colour fibres are at the edges the selection reads.
-/

namespace HadwigerNelson.Collapse

open SpectralChain NumberField Rigidity Rigidity.Counting MeasureTheory Filter Topology

noncomputable section

/-! ## The finite-group mixing inequality -/

section FiniteMixing

open Finset

variable {G : Type*} [AddCommGroup G] [Fintype G] [DecidableEq G]

omit [DecidableEq G] in
-- FS131-ICO1: the Fourier coefficient `f̂(ψ) = Σ_x f(x) ψ(x)` of a real function.
private noncomputable def fhat (f : G → ℝ) (ψ : AddChar G ℂ) : ℂ := ∑ x, (f x : ℂ) * ψ x

-- FS131-ICO1: **the edge sum in characters**: `Σ_ψ f̂(ψ)·conj ĝ(ψ)·λ_ψ = |G|·Σ_x f(x) Σ_{s ∈ S} g(x + s)`, with
-- `f̂(ψ) = Σ_x f(x) ψ(x)` (orthogonality, `AddChar.sum_apply_eq_ite`).
private theorem sum_fourier_mul_charSum (S : Finset G) (f g : G → ℝ) :
    ∑ ψ : AddChar G ℂ, (∑ x, (f x : ℂ) * ψ x) * (starRingEnd ℂ) (∑ y, (g y : ℂ) * ψ y) * ∑ s ∈ S, ψ s =
      (Fintype.card G : ℂ) * ∑ x, (f x : ℂ) * ∑ s ∈ S, (g (x + s) : ℂ) := by
  have h1 : ∀ ψ : AddChar G ℂ, (∑ x, (f x : ℂ) * ψ x) * (starRingEnd ℂ) (∑ y, (g y : ℂ) * ψ y) * ∑ s ∈ S, ψ s =
      ∑ x, ∑ y, ∑ s ∈ S, (f x : ℂ) * (g y : ℂ) * ψ (x - y + s) := by
    intro ψ
    rw [map_sum, sum_mul_sum, sum_mul]
    refine sum_congr rfl fun x _ => ?_
    rw [sum_mul]
    refine sum_congr rfl fun y _ => ?_
    rw [mul_sum]
    refine sum_congr rfl fun s _ => ?_
    rw [map_mul, Complex.conj_ofReal, ← AddChar.map_neg_eq_conj, sub_eq_add_neg, AddChar.map_add_eq_mul,
      AddChar.map_add_eq_mul]
    ring
  calc ∑ ψ : AddChar G ℂ, (∑ x, (f x : ℂ) * ψ x) * (starRingEnd ℂ) (∑ y, (g y : ℂ) * ψ y) * ∑ s ∈ S, ψ s
      = ∑ ψ : AddChar G ℂ, ∑ x, ∑ y, ∑ s ∈ S, (f x : ℂ) * (g y : ℂ) * ψ (x - y + s) :=
        sum_congr rfl fun ψ _ => h1 ψ
    _ = ∑ x, ∑ y, ∑ s ∈ S, ∑ ψ : AddChar G ℂ, (f x : ℂ) * (g y : ℂ) * ψ (x - y + s) := by
        rw [sum_comm]
        refine sum_congr rfl fun x _ => ?_
        rw [sum_comm]
        refine sum_congr rfl fun y _ => ?_
        rw [sum_comm]
    _ = ∑ x, ∑ s ∈ S, ∑ y, (f x : ℂ) * (g y : ℂ) * (if y = x + s then (Fintype.card G : ℂ) else 0) := by
        refine sum_congr rfl fun x _ => ?_
        rw [sum_comm]
        refine sum_congr rfl fun s _ => sum_congr rfl fun y _ => ?_
        rw [← mul_sum, AddChar.sum_apply_eq_ite]
        congr 2
        apply propext
        constructor
        · intro h
          exact eq_of_sub_eq_zero (by rw [show y - (x + s) = -(x - y + s) by abel, h, neg_zero])
        · intro h; rw [h]; abel
    _ = (Fintype.card G : ℂ) * ∑ x, (f x : ℂ) * ∑ s ∈ S, (g (x + s) : ℂ) := by
        rw [mul_sum]
        refine sum_congr rfl fun x _ => ?_
        rw [mul_sum, mul_sum]
        refine sum_congr rfl fun s _ => ?_
        simp only [mul_ite, mul_zero, sum_ite_eq', mem_univ, if_true]
        ring

-- FS131-ICO1: **Parseval**: `Σ_ψ |f̂(ψ)|² = |G|·Σ_x f(x)²`.
private theorem sum_norm_fourier_sq (f : G → ℝ) :
    ∑ ψ : AddChar G ℂ, ‖∑ x, (f x : ℂ) * ψ x‖ ^ 2 = Fintype.card G * ∑ x, f x ^ 2 := by
  have h := sum_fourier_mul_charSum ({0} : Finset G) f f
  simp only [sum_singleton, AddChar.map_zero_eq_one, mul_one, add_zero] at h
  have h2 : ∀ ψ : AddChar G ℂ, (∑ x, (f x : ℂ) * ψ x) * (starRingEnd ℂ) (∑ y, (f y : ℂ) * ψ y) =
      ((‖∑ x, (f x : ℂ) * ψ x‖ ^ 2 : ℝ) : ℂ) := fun ψ => by
    rw [Complex.mul_conj, Complex.normSq_eq_norm_sq]
  rw [sum_congr rfl fun ψ _ => h2 ψ] at h
  have h3 := congrArg Complex.re h
  simp only [Complex.re_sum, Complex.ofReal_re] at h3
  rw [h3]
  have e : ((Fintype.card G : ℂ) * ∑ x, (f x : ℂ) * (f x : ℂ)) = ((Fintype.card G * ∑ x, f x ^ 2 : ℝ) : ℂ) := by
    push_cast
    simp only [sq]
  rw [e, Complex.ofReal_re]

-- FS131-ICO1: the edge sum and Parseval in `fhat`'s words.
private theorem sum_fhat_mul_charSum (S : Finset G) (f g : G → ℝ) :
    ∑ ψ : AddChar G ℂ, fhat f ψ * (starRingEnd ℂ) (fhat g ψ) * ∑ s ∈ S, ψ s =
      ((Fintype.card G * ∑ x, f x * ∑ s ∈ S, g (x + s) : ℝ) : ℂ) := by
  rw [show (fun ψ : AddChar G ℂ => fhat f ψ * (starRingEnd ℂ) (fhat g ψ) * ∑ s ∈ S, ψ s) =
    fun ψ => (∑ x, (f x : ℂ) * ψ x) * (starRingEnd ℂ) (∑ y, (g y : ℂ) * ψ y) * ∑ s ∈ S, ψ s from rfl,
    sum_fourier_mul_charSum]
  push_cast
  rfl

private theorem sum_norm_fhat_sq (f : G → ℝ) :
    ∑ ψ : AddChar G ℂ, ‖fhat f ψ‖ ^ 2 = Fintype.card G * ∑ x, f x ^ 2 :=
  sum_norm_fourier_sq f

omit [DecidableEq G] in
private theorem fhat_one (f : G → ℝ) : fhat f 1 = ((∑ x, f x : ℝ) : ℂ) := by
  simp only [fhat, AddChar.one_apply, mul_one]
  push_cast
  rfl

end FiniteMixing

/-- **The expander mixing inequality on a finite abelian group, two-sided, for `[0, 1]`-valued functions**: if every
non-trivial character sums over `S` to at most `c·|S|` in modulus, then for `f, g : G → [0, 1]` of means `a, b`,
`E_x f(x)·E_{s ∈ S} g(x + s) ≥ ab − c·√(a(1 − a))·√(b(1 − b))`. Route: expand in characters (orthogonality,
`AddChar.sum_apply_eq_ite`); the trivial character gives `ab`; the others are bounded by `c` times Cauchy–Schwarz over the
non-trivial Fourier coefficients, whose squares sum to `E f² − a² ≤ a − a²` (Parseval, as in `RatioBound.sum_fourier_sq`). -/
theorem finite_mixing {G : Type*} [AddCommGroup G] [Fintype G] [DecidableEq G] (S : Finset G) (hS : S.Nonempty)
    {c : ℝ} (hc : 0 ≤ c) (hchar : ∀ ψ : AddChar G ℂ, ψ ≠ 1 → ‖∑ s ∈ S, ψ s‖ ≤ c * S.card)
    (f g : G → ℝ) (hf0 : ∀ x, 0 ≤ f x) (hf1 : ∀ x, f x ≤ 1) (hg0 : ∀ x, 0 ≤ g x) (hg1 : ∀ x, g x ≤ 1) {a b : ℝ}
    (ha : ∑ x, f x = a * Fintype.card G) (hb : ∑ x, g x = b * Fintype.card G) :
    a * b - c * Real.sqrt (a * (1 - a)) * Real.sqrt (b * (1 - b)) ≤
      (∑ x, f x * ∑ s ∈ S, g (x + s)) / (S.card * Fintype.card G) := by
  classical
  set n : ℝ := (Fintype.card G : ℝ) with hn
  set m : ℝ := (S.card : ℝ) with hm
  have hn0 : 0 < n := by rw [hn]; exact_mod_cast Fintype.card_pos
  have hm0 : 0 < m := by rw [hm]; exact_mod_cast hS.card_pos
  set T := ∑ x, f x * ∑ s ∈ S, g (x + s) with hT
  -- the trivial character, split off
  have hsplit := Finset.add_sum_erase (Finset.univ : Finset (AddChar G ℂ))
    (fun ψ => fhat f ψ * (starRingEnd ℂ) (fhat g ψ) * ∑ s ∈ S, ψ s) (Finset.mem_univ 1)
  rw [sum_fhat_mul_charSum S f g] at hsplit
  simp only [fhat_one, ha, hb, AddChar.one_apply, Finset.sum_const, nsmul_eq_mul, mul_one, Complex.conj_ofReal]
    at hsplit
  set R := ∑ ψ ∈ Finset.univ.erase (1 : AddChar G ℂ), fhat f ψ * (starRingEnd ℂ) (fhat g ψ) * ∑ s ∈ S, ψ s with hR
  have hre : n * T = a * n * (b * n) * m + R.re := by
    have := congrArg Complex.re hsplit
    simp only [Complex.add_re, Complex.ofReal_re] at this
    rw [← this]
    simp [Complex.mul_re, hm]
  -- the non-trivial characters: `|R| ≤ c m Σ |f̂| |ĝ|`
  have hRle : ‖R‖ ≤ c * m * ∑ ψ ∈ Finset.univ.erase (1 : AddChar G ℂ), ‖fhat f ψ‖ * ‖fhat g ψ‖ := by
    refine (norm_sum_le _ _).trans ?_
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun ψ hψ => ?_
    have hψ1 : ψ ≠ 1 := Finset.ne_of_mem_erase hψ
    rw [norm_mul, norm_mul, Complex.norm_conj]
    have := hchar ψ hψ1
    have h0 : 0 ≤ ‖fhat f ψ‖ * ‖fhat g ψ‖ := by positivity
    calc ‖fhat f ψ‖ * ‖fhat g ψ‖ * ‖∑ s ∈ S, ψ s‖ ≤ ‖fhat f ψ‖ * ‖fhat g ψ‖ * (c * S.card) :=
          mul_le_mul_of_nonneg_left this h0
      _ = c * m * (‖fhat f ψ‖ * ‖fhat g ψ‖) := by rw [hm]; ring
  -- Cauchy–Schwarz and Parseval off the trivial character
  have hCS := Real.sum_mul_le_sqrt_mul_sqrt (Finset.univ.erase (1 : AddChar G ℂ)) (fun ψ => ‖fhat f ψ‖)
    (fun ψ => ‖fhat g ψ‖)
  have hpars : ∀ (h : G → ℝ) (e : ℝ), (∀ x, 0 ≤ h x) → (∀ x, h x ≤ 1) → ∑ x, h x = e * n →
      Real.sqrt (∑ ψ ∈ Finset.univ.erase (1 : AddChar G ℂ), ‖fhat h ψ‖ ^ 2) ≤ n * Real.sqrt (e * (1 - e)) := by
    intro h e h0 h1 he
    have hall := Finset.add_sum_erase (Finset.univ : Finset (AddChar G ℂ)) (fun ψ => ‖fhat h ψ‖ ^ 2)
      (Finset.mem_univ 1)
    rw [sum_norm_fhat_sq, fhat_one, he, Complex.norm_real, Real.norm_eq_abs, sq_abs] at hall
    have hsq : ∑ x, h x ^ 2 ≤ e * n := by
      rw [← he]
      exact Finset.sum_le_sum fun x _ => by nlinarith [h0 x, h1 x]
    have hle : ∑ ψ ∈ Finset.univ.erase (1 : AddChar G ℂ), ‖fhat h ψ‖ ^ 2 ≤ n ^ 2 * (e * (1 - e)) := by
      have : n * ∑ x, h x ^ 2 ≤ n * (e * n) := mul_le_mul_of_nonneg_left hsq hn0.le
      rw [← hn] at hall
      nlinarith
    calc Real.sqrt (∑ ψ ∈ Finset.univ.erase (1 : AddChar G ℂ), ‖fhat h ψ‖ ^ 2)
        ≤ Real.sqrt (n ^ 2 * (e * (1 - e))) := Real.sqrt_le_sqrt hle
      _ = n * Real.sqrt (e * (1 - e)) := by
        rw [Real.sqrt_mul (sq_nonneg n), Real.sqrt_sq hn0.le]
  have hfa := hpars f a hf0 hf1 ha
  have hgb := hpars g b hg0 hg1 hb
  have hsa := Real.sqrt_nonneg (a * (1 - a))
  have hsb := Real.sqrt_nonneg (b * (1 - b))
  have hs1 := Real.sqrt_nonneg (∑ ψ ∈ Finset.univ.erase (1 : AddChar G ℂ), ‖fhat f ψ‖ ^ 2)
  have hs2 := Real.sqrt_nonneg (∑ ψ ∈ Finset.univ.erase (1 : AddChar G ℂ), ‖fhat g ψ‖ ^ 2)
  have hprod : Real.sqrt (∑ ψ ∈ Finset.univ.erase (1 : AddChar G ℂ), ‖fhat f ψ‖ ^ 2) *
      Real.sqrt (∑ ψ ∈ Finset.univ.erase (1 : AddChar G ℂ), ‖fhat g ψ‖ ^ 2) ≤
      (n * Real.sqrt (a * (1 - a))) * (n * Real.sqrt (b * (1 - b))) :=
    mul_le_mul hfa hgb hs2 (by positivity)
  have hRre : -R.re ≤ c * m * (n * Real.sqrt (a * (1 - a))) * (n * Real.sqrt (b * (1 - b))) := by
    have h1 := (neg_le_abs R.re).trans (Complex.abs_re_le_norm R)
    have hcm : 0 ≤ c * m := by positivity
    have h2 := mul_le_mul_of_nonneg_left (hCS.trans hprod) hcm
    linarith
  rw [le_div_iff₀ (by positivity)]
  have key : n * ((a * b - c * Real.sqrt (a * (1 - a)) * Real.sqrt (b * (1 - b))) * (m * n)) ≤ n * T := by
    rw [hre]
    nlinarith
  exact le_of_mul_le_mul_left key hn0

/-! ## The levels of the completion -/

variable (F : Subfield ℝ) [NumberField F]

/-- **The level-`k` fill of `A` at `x`**: the Haar fraction of the level-`k` coset of `x` that `A` occupies — `E_k 1_A`. -/
def levelFill (A : Set (K F)) (k : ℕ) (x : K F) : ℝ :=
  (haarK F (A ∩ proj F k ⁻¹' {proj F k x})).toReal / (haarK F (proj F k ⁻¹' {proj F k x})).toReal

/-- **The level-`k` residual of `A`**: `‖1_A − E_k 1_A‖₂²`. -/
def levelResid (A : Set (K F)) (k : ℕ) : ℝ :=
  ∫ x, (A.indicator (fun _ => (1 : ℝ)) x - levelFill F A k x) ^ 2 ∂haarK F

variable {F}

/-- The residual is non-negative. -/
theorem levelResid_nonneg (A : Set (K F)) (k : ℕ) : 0 ≤ levelResid F A k :=
  integral_nonneg fun _ => sq_nonneg _

/-! ### The cosets of a level, as a finite partition of `K` (FS131-ICO1's helpers) -/

-- FS131-ICO1: Cauchy–Schwarz for bounded measurable real functions on a finite measure (Hölder at `p = q = 2`).
private theorem abs_integral_mul_le {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]
    {f g : α → ℝ} (hf : Measurable f) (hg : Measurable g) (hf1 : ∀ x, |f x| ≤ 1) (hg1 : ∀ x, |g x| ≤ 1) :
    |∫ x, f x * g x ∂μ| ≤ Real.sqrt (∫ x, f x ^ 2 ∂μ) * Real.sqrt (∫ x, g x ^ 2 ∂μ) := by
  have hfa : MemLp (fun x => |f x|) (ENNReal.ofReal 2) μ :=
    MemLp.of_bound (continuous_abs.measurable.comp hf).aestronglyMeasurable 1 (Eventually.of_forall fun x => by
      rw [Real.norm_eq_abs, abs_abs]; exact hf1 x)
  have hga : MemLp (fun x => |g x|) (ENNReal.ofReal 2) μ :=
    MemLp.of_bound (continuous_abs.measurable.comp hg).aestronglyMeasurable 1 (Eventually.of_forall fun x => by
      rw [Real.norm_eq_abs, abs_abs]; exact hg1 x)
  have hH := integral_mul_le_Lp_mul_Lq_of_nonneg Real.HolderConjugate.two_two
    (Eventually.of_forall fun x => abs_nonneg (f x)) (Eventually.of_forall fun x => abs_nonneg (g x)) hfa hga
  have e1 : ∀ h : α → ℝ, (∫ x, |h x| ^ (2 : ℝ) ∂μ) ^ (1 / (2 : ℝ)) = Real.sqrt (∫ x, h x ^ 2 ∂μ) := fun h => by
    rw [Real.sqrt_eq_rpow]
    congr 1
    refine integral_congr_ae (Eventually.of_forall fun x => ?_)
    simp only [Real.rpow_two, sq_abs]
  rw [e1, e1] at hH
  calc |∫ x, f x * g x ∂μ| ≤ ∫ x, |f x * g x| ∂μ := abs_integral_le_integral_abs
    _ = ∫ x, |f x| * |g x| ∂μ := by simp_rw [abs_mul]
    _ ≤ _ := hH

-- FS131-ICO1: every point of `K` lies over the level group.
private theorem proj_mem_levImg (k : ℕ) (x : K F) : proj F k x ∈ LevImg F k := by
  have : proj F k x ∈ Set.range (levR F k) := by rw [← range_proj]; exact ⟨x, rfl⟩
  obtain ⟨r, hr⟩ := this
  exact ⟨r, hr⟩

-- FS131-ICO1: the cosets are measurable (clopen).
private theorem measurableSet_coset (k : ℕ) (g : Lev F k) : MeasurableSet (proj F k ⁻¹' {g}) :=
  ((isOpen_discrete {g}).preimage (continuous_proj F k)).measurableSet

-- FS131-ICO1: a coset over the level group has measure `1/N`.
private theorem haarK_coset {k : ℕ} [Fintype (LevImg F k)] (g : LevImg F k) :
    (haarK F (proj F k ⁻¹' {(g : Lev F k)})).toReal = 1 / Fintype.card (LevImg F k) := by
  have hg : (g : Lev F k) ∈ Set.range (proj F k) := by
    rw [range_proj]
    obtain ⟨r, hr⟩ := g.2
    exact ⟨r, hr⟩
  rw [haarK_proj_preimage F k hg]
  have hc : Nat.card (Set.range (proj F k)) = Fintype.card (LevImg F k) := by
    rw [← Nat.card_eq_fintype_card, range_proj]
    rfl
  rw [hc, ENNReal.toReal_inv, ENNReal.toReal_natCast, one_div]

-- FS131-ICO1: the cosets over the level group have positive measure.
private theorem haarK_coset_pos {k : ℕ} [Fintype (LevImg F k)] (g : LevImg F k) :
    0 < (haarK F (proj F k ⁻¹' {(g : Lev F k)})).toReal := by
  rw [haarK_coset]
  have : 0 < Fintype.card (LevImg F k) := Fintype.card_pos_iff.2 ⟨0⟩
  positivity

/-- FS131-ICO1: the fill of `A` on the coset over `g`. -/
private def fillAt (A : Set (K F)) (k : ℕ) (g : Lev F k) : ℝ :=
  (haarK F (A ∩ proj F k ⁻¹' {g})).toReal / (haarK F (proj F k ⁻¹' {g})).toReal

private theorem levelFill_eq (A : Set (K F)) (k : ℕ) (x : K F) : levelFill F A k x = fillAt A k (proj F k x) := rfl

private theorem fillAt_nonneg (A : Set (K F)) (k : ℕ) (g : Lev F k) : 0 ≤ fillAt A k g :=
  div_nonneg ENNReal.toReal_nonneg ENNReal.toReal_nonneg

private theorem fillAt_le_one (A : Set (K F)) (k : ℕ) (g : Lev F k) : fillAt A k g ≤ 1 :=
  div_le_one_of_le₀ (ENNReal.toReal_mono (measure_ne_top _ _) (measure_mono Set.inter_subset_right))
    ENNReal.toReal_nonneg

-- FS131-ICO1: `|A ∩ C_g| = fill · |C_g|`.
private theorem haarK_inter_coset {k : ℕ} [Fintype (LevImg F k)] (A : Set (K F)) (g : LevImg F k) :
    (haarK F (A ∩ proj F k ⁻¹' {(g : Lev F k)})).toReal =
      fillAt A k g * (haarK F (proj F k ⁻¹' {(g : Lev F k)})).toReal :=
  (div_mul_cancel₀ _ (haarK_coset_pos g).ne').symm

-- FS131-ICO1: the fill is measurable (a function of the level, which is locally constant).
private theorem measurable_levelFill (A : Set (K F)) (k : ℕ) : Measurable (levelFill F A k) :=
  show Measurable ((fun g : Lev F k => fillAt A k g) ∘ proj F k) from
    (continuous_of_discreteTopology.comp (continuous_proj F k)).measurable

private theorem measurable_indicator_one {A : Set (K F)} (hA : MeasurableSet A) :
    Measurable (A.indicator fun _ => (1 : ℝ)) :=
  measurable_const.indicator hA

-- FS131-ICO1: **an integral over `K` is the sum of its integrals over the cosets of a level**.
private theorem integral_eq_sum_cosets {k : ℕ} [Fintype (LevImg F k)] {φ : K F → ℝ} (hφ : Integrable φ (haarK F)) :
    ∫ x, φ x ∂haarK F = ∑ g : LevImg F k, ∫ x in proj F k ⁻¹' {(g : Lev F k)}, φ x ∂haarK F := by
  have hU : (⋃ g : LevImg F k, proj F k ⁻¹' {(g : Lev F k)}) = Set.univ := by
    ext x
    simp only [Set.mem_iUnion, Set.mem_preimage, Set.mem_singleton_iff, Set.mem_univ, iff_true]
    exact ⟨⟨proj F k x, proj_mem_levImg k x⟩, rfl⟩
  rw [← integral_iUnion_fintype (fun g => measurableSet_coset k _) ?_ fun g => hφ.integrableOn, hU,
    Measure.restrict_univ]
  intro g g' hne
  exact Set.disjoint_left.2 fun x h1 h2 => hne (Subtype.ext ((Set.mem_singleton_iff.1 h1).symm.trans h2))

-- FS131-ICO1: the integral of `1_A` over a coset.
private theorem setIntegral_indicator_coset {k : ℕ} {A : Set (K F)} (hA : MeasurableSet A) (g : Lev F k) :
    ∫ x in proj F k ⁻¹' {g}, A.indicator (fun _ => (1 : ℝ)) x ∂haarK F = (haarK F (A ∩ proj F k ⁻¹' {g})).toReal := by
  rw [setIntegral_indicator hA, setIntegral_const, smul_eq_mul, mul_one, measureReal_def, Set.inter_comm]

-- FS131-ICO1: **the residual integrates to `0` over every coset**.
private theorem setIntegral_resid_coset {k : ℕ} [Fintype (LevImg F k)] {A : Set (K F)} (hA : MeasurableSet A)
    (g : LevImg F k) :
    ∫ x in proj F k ⁻¹' {(g : Lev F k)}, (A.indicator (fun _ => (1 : ℝ)) x - levelFill F A k x) ∂haarK F = 0 := by
  have hcongr : Set.EqOn (fun x => A.indicator (fun _ => (1 : ℝ)) x - levelFill F A k x)
      (fun x => A.indicator (fun _ => (1 : ℝ)) x - fillAt A k g) (proj F k ⁻¹' {(g : Lev F k)}) := by
    intro x hx
    simp only [levelFill_eq, Set.mem_preimage, Set.mem_singleton_iff] at hx ⊢
    rw [hx]
  rw [setIntegral_congr_fun (measurableSet_coset k _) hcongr, integral_sub, setIntegral_indicator_coset hA,
    setIntegral_const, smul_eq_mul, measureReal_def, haarK_inter_coset A g]
  · ring
  · exact (Integrable.of_bound (measurable_indicator_one hA).aestronglyMeasurable 1
      (Eventually.of_forall fun x => by
        by_cases h : x ∈ A <;> simp [h])).integrableOn
  · exact integrableOn_const (measure_ne_top _ _)

-- FS131-ICO1: **the residual as a sum over the cosets**: `levelResid A k = Σ_g |C_g| α_g (1 − α_g)`.
private theorem levelResid_eq {k : ℕ} [Fintype (LevImg F k)] {A : Set (K F)} (hA : MeasurableSet A) :
    levelResid F A k = ∑ g : LevImg F k, (haarK F (proj F k ⁻¹' {(g : Lev F k)})).toReal *
      (fillAt A k g * (1 - fillAt A k g)) := by
  unfold levelResid
  have hint : Integrable (fun x => (A.indicator (fun _ => (1 : ℝ)) x - levelFill F A k x) ^ 2) (haarK F) := by
    refine Integrable.of_bound (((measurable_indicator_one hA).sub (measurable_levelFill A k)).pow_const 2
      ).aestronglyMeasurable 1 (Eventually.of_forall fun x => ?_)
    have h0 := fillAt_nonneg A k (proj F k x)
    have h1 := fillAt_le_one A k (proj F k x)
    rw [levelFill_eq, Real.norm_eq_abs, abs_le]
    by_cases h : x ∈ A <;> simp only [h, Set.indicator_of_mem, Set.indicator_of_notMem, not_false_eq_true] <;>
      constructor <;> nlinarith
  rw [integral_eq_sum_cosets (k := k) hint]
  refine Finset.sum_congr rfl fun g _ => ?_
  have hcongr : Set.EqOn (fun x => (A.indicator (fun _ => (1 : ℝ)) x - levelFill F A k x) ^ 2)
      (fun x => A.indicator (fun _ => (1 : ℝ)) x * (1 - 2 * fillAt A k g) + fillAt A k g ^ 2)
      (proj F k ⁻¹' {(g : Lev F k)}) := by
    intro x hx
    simp only [levelFill_eq, Set.mem_preimage, Set.mem_singleton_iff] at hx ⊢
    rw [hx]
    by_cases h : x ∈ A <;> simp only [h, Set.indicator_of_mem, Set.indicator_of_notMem, not_false_eq_true] <;> ring
  rw [setIntegral_congr_fun (measurableSet_coset k _) hcongr, integral_add, integral_mul_const,
    setIntegral_indicator_coset hA, setIntegral_const, smul_eq_mul, measureReal_def, haarK_inter_coset A g]
  · ring
  · exact ((Integrable.of_bound (measurable_indicator_one hA).aestronglyMeasurable 1
      (Eventually.of_forall fun x => by
        by_cases h : x ∈ A <;> simp [h])).mul_const _).integrableOn
  · exact integrableOn_const (measure_ne_top _ _)

/-- **The residual tends to `0`** (the martingale convergence the selection needs, from density along cosets): with
`∫_{Aᶜ} E_k 1_A = ∫_A (1 − E_k 1_A)`, the residual is at most `2∫_A (1 − E_k 1_A)`, which is at most `2κ` plus twice the
Haar measure of the points of `A` whose coset `A` fills to at most `1 − κ` — and that tends to `0`
(`Rigidity.Counting.tendsto_haarK_bad`). -/
theorem tendsto_levelResid {A : Set (K F)} (hA : MeasurableSet A) : Tendsto (levelResid F A) atTop (𝓝 0) := by
  classical
  -- the bound at one level: the residual is at most the measure of the bad set plus `κ`
  have hbound : ∀ κ : ℝ, 0 < κ → ∀ k : ℕ, levelResid F A k ≤ (haarK F {x | x ∈ A ∧
      haarK F (A ∩ proj F k ⁻¹' {proj F k x}) ≤
        (1 - ENNReal.ofReal κ) * haarK F (proj F k ⁻¹' {proj F k x})}).toReal + κ := by
    intro κ hκ k
    haveI : Fintype (LevImg F k) := Fintype.ofFinite _
    rw [levelResid_eq hA]
    set bad := {x | x ∈ A ∧ haarK F (A ∩ proj F k ⁻¹' {proj F k x}) ≤
      (1 - ENNReal.ofReal κ) * haarK F (proj F k ⁻¹' {proj F k x})} with hbad
    set T := Finset.univ.filter fun g : LevImg F k => fillAt A k g ≤ 1 - κ with hT
    have hterm : ∀ g : LevImg F k, (haarK F (proj F k ⁻¹' {(g : Lev F k)})).toReal *
        (fillAt A k g * (1 - fillAt A k g)) ≤
        (if g ∈ T then (haarK F (A ∩ proj F k ⁻¹' {(g : Lev F k)})).toReal else 0) +
          κ * (haarK F (proj F k ⁻¹' {(g : Lev F k)})).toReal := by
      intro g
      have h0 := fillAt_nonneg A k g
      have h1 := fillAt_le_one A k g
      have hcp := haarK_coset_pos g
      rw [haarK_inter_coset A g]
      by_cases hg : g ∈ T
      · rw [if_pos hg]
        have : fillAt A k g * (1 - fillAt A k g) ≤ fillAt A k g := by nlinarith
        nlinarith
      · rw [if_neg hg]
        have hg' : 1 - κ < fillAt A k g := by
          simpa [hT] using hg
        have : fillAt A k g * (1 - fillAt A k g) ≤ κ := by nlinarith
        nlinarith
    -- the coset measures sum to `1`
    have hone : ∑ g : LevImg F k, (haarK F (proj F k ⁻¹' {(g : Lev F k)})).toReal = 1 := by
      have h := integral_eq_sum_cosets (k := k) (integrable_const (μ := haarK F) (1 : ℝ))
      simp only [integral_const, smul_eq_mul, mul_one, measureReal_def, measure_univ,
        ENNReal.toReal_one, Measure.restrict_apply MeasurableSet.univ, Set.univ_inter] at h
      exact h.symm
    -- the good part of the bad cosets lies in the bad set
    have hsub : (⋃ g ∈ T, A ∩ proj F k ⁻¹' {(g : Lev F k)}) ⊆ bad := by
      intro x hx
      simp only [Set.mem_iUnion, Set.mem_inter_iff, Set.mem_preimage, Set.mem_singleton_iff] at hx
      obtain ⟨g, hg, hxA, hxg⟩ := hx
      refine ⟨hxA, ?_⟩
      rw [hxg]
      have hgT : fillAt A k g ≤ 1 - κ := (Finset.mem_filter.1 hg).2
      have h0 := fillAt_nonneg A k g
      have hκ1 : 0 ≤ 1 - κ := h0.trans hgT
      have hr : (haarK F (A ∩ proj F k ⁻¹' {(g : Lev F k)})).toReal ≤
          (1 - κ) * (haarK F (proj F k ⁻¹' {(g : Lev F k)})).toReal := by
        rw [haarK_inter_coset A g]
        exact mul_le_mul_of_nonneg_right hgT ENNReal.toReal_nonneg
      calc haarK F (A ∩ proj F k ⁻¹' {(g : Lev F k)})
          = ENNReal.ofReal (haarK F (A ∩ proj F k ⁻¹' {(g : Lev F k)})).toReal :=
            (ENNReal.ofReal_toReal (measure_ne_top _ _)).symm
        _ ≤ ENNReal.ofReal ((1 - κ) * (haarK F (proj F k ⁻¹' {(g : Lev F k)})).toReal) := ENNReal.ofReal_le_ofReal hr
        _ = (1 - ENNReal.ofReal κ) * haarK F (proj F k ⁻¹' {(g : Lev F k)}) := by
          rw [ENNReal.ofReal_mul hκ1, ENNReal.ofReal_toReal (measure_ne_top _ _), ENNReal.ofReal_sub _ hκ.le,
            ENNReal.ofReal_one]
    have hdisj : Set.PairwiseDisjoint (↑T) fun g : LevImg F k => A ∩ proj F k ⁻¹' {(g : Lev F k)} :=
      fun g _ g' _ hne => Set.disjoint_left.2 fun x h1 h2 =>
        hne (Subtype.ext ((Set.mem_singleton_iff.1 h1.2).symm.trans h2.2))
    have hsumT : ∑ g ∈ T, (haarK F (A ∩ proj F k ⁻¹' {(g : Lev F k)})).toReal ≤ (haarK F bad).toReal := by
      rw [← ENNReal.toReal_sum fun g _ => measure_ne_top _ _,
        ← measure_biUnion_finset hdisj fun g _ => hA.inter (measurableSet_coset k _)]
      exact ENNReal.toReal_mono (measure_ne_top _ _) (measure_mono hsub)
    calc ∑ g : LevImg F k, (haarK F (proj F k ⁻¹' {(g : Lev F k)})).toReal * (fillAt A k g * (1 - fillAt A k g))
        ≤ ∑ g : LevImg F k, ((if g ∈ T then (haarK F (A ∩ proj F k ⁻¹' {(g : Lev F k)})).toReal else 0) +
          κ * (haarK F (proj F k ⁻¹' {(g : Lev F k)})).toReal) := Finset.sum_le_sum fun g _ => hterm g
      _ = ∑ g ∈ T, (haarK F (A ∩ proj F k ⁻¹' {(g : Lev F k)})).toReal + κ := by
        rw [Finset.sum_add_distrib, ← Finset.mul_sum, hone, mul_one, Finset.sum_ite_mem, Finset.univ_inter]
      _ ≤ (haarK F bad).toReal + κ := by linarith
  rw [Metric.tendsto_atTop]
  intro ε hε
  have hκ : (0 : ℝ) < ε / 2 := by positivity
  have hlim := (ENNReal.tendsto_toReal ENNReal.zero_ne_top).comp
    (tendsto_haarK_bad (F := F) hA (κ := ENNReal.ofReal (ε / 2)) (ENNReal.ofReal_pos.2 hκ))
  rw [ENNReal.toReal_zero] at hlim
  obtain ⟨N, hN⟩ := Metric.tendsto_atTop.1 hlim (ε / 2) hκ
  refine ⟨N, fun n hn => ?_⟩
  have h1 := hN n hn
  have h2 := hbound (ε / 2) hκ n
  simp only [Function.comp_apply] at h1
  rw [Real.dist_eq, sub_zero, abs_of_nonneg ENNReal.toReal_nonneg] at h1
  rw [Real.dist_eq, sub_zero, abs_of_nonneg (levelResid_nonneg A n)]
  linarith

-- FS131-ICO1: a bounded measurable function is integrable on `K`.
private theorem integrable_of_abs_le {f : K F → ℝ} (hf : Measurable f) {C : ℝ} (h : ∀ x, |f x| ≤ C) :
    Integrable f (haarK F) :=
  Integrable.of_bound hf.aestronglyMeasurable C (Eventually.of_forall fun x => by rw [Real.norm_eq_abs]; exact h x)

private theorem abs_indicator_one_le (A : Set (K F)) (x : K F) : |A.indicator (fun _ => (1 : ℝ)) x| ≤ 1 := by
  by_cases h : x ∈ A <;> simp [h]

private theorem abs_levelFill_le (A : Set (K F)) (k : ℕ) (x : K F) : |levelFill F A k x| ≤ 1 := by
  rw [levelFill_eq]
  exact abs_le.2 ⟨by linarith [fillAt_nonneg A k (proj F k x)], fillAt_le_one A k (proj F k x)⟩

private theorem abs_resid_le (A : Set (K F)) (k : ℕ) (x : K F) :
    |A.indicator (fun _ => (1 : ℝ)) x - levelFill F A k x| ≤ 1 := by
  rw [levelFill_eq]
  have h0 := fillAt_nonneg A k (proj F k x)
  have h1 := fillAt_le_one A k (proj F k x)
  by_cases h : x ∈ A <;> simp only [h, Set.indicator_of_mem, Set.indicator_of_notMem, not_false_eq_true] <;>
    exact abs_le.2 ⟨by linarith, by linarith⟩

-- FS131-ICO1: the fills sum to the measure over the level group: `Σ_g α_g = |A|·N`.
private theorem sum_fillAt {k : ℕ} [Fintype (LevImg F k)] {A : Set (K F)} (hA : MeasurableSet A) :
    ∑ g : LevImg F k, fillAt A k g = (haarK F A).toReal * Fintype.card (LevImg F k) := by
  have h := integral_eq_sum_cosets (k := k)
    (integrable_of_abs_le (measurable_indicator_one hA) (abs_indicator_one_le A))
  rw [integral_indicator_const _ hA, smul_eq_mul, mul_one, measureReal_def] at h
  simp only [setIntegral_indicator_coset hA, haarK_inter_coset A, haarK_coset] at h
  have hN : (0 : ℝ) < Fintype.card (LevImg F k) := by
    have : 0 < Fintype.card (LevImg F k) := Fintype.card_pos_iff.2 ⟨0⟩
    exact_mod_cast this
  rw [h, Finset.sum_mul]
  refine Finset.sum_congr rfl fun g _ => ?_
  field_simp

-- FS131-ICO1: **the edge integral at a translation over `s`, split at level `k`**: the fills give the finite-group term
-- `(1/N) Σ_g α_g β_{g+s}`, the cross terms vanish (the residual integrates to `0` over every coset, and the translation
-- carries cosets to cosets), and the residuals' product is left.
private theorem edge_split {k : ℕ} [Fintype (LevImg F k)] {A B : Set (K F)} (hA : MeasurableSet A)
    (hB : MeasurableSet B) (s : LevImg F k) (t : K F) (ht : proj F k t = (s : Lev F k)) :
    ∫ x, A.indicator (fun _ => (1 : ℝ)) x * B.indicator (fun _ => (1 : ℝ)) (x + t) ∂haarK F =
      (∑ g : LevImg F k, fillAt A k g * fillAt B k ((g + s : LevImg F k) : Lev F k)) / Fintype.card (LevImg F k) +
      ∫ x, (A.indicator (fun _ => (1 : ℝ)) x - levelFill F A k x) *
        (B.indicator (fun _ => (1 : ℝ)) (x + t) - levelFill F B k (x + t)) ∂haarK F := by
  set iA := A.indicator (fun _ => (1 : ℝ)) with hiA
  set iB := B.indicator (fun _ => (1 : ℝ)) with hiB
  set fA := levelFill F A k with hfA
  set fB := levelFill F B k with hfB
  have ht' : Measurable (fun x : K F => x + t) := measurable_add_const t
  have mA : Measurable iA := measurable_indicator_one hA
  have mB : Measurable (fun x => iB (x + t)) := (measurable_indicator_one hB).comp ht'
  have mfA : Measurable fA := measurable_levelFill A k
  have mfB : Measurable (fun x => fB (x + t)) := (measurable_levelFill B k).comp ht'
  have bA : ∀ x, |iA x| ≤ 1 := abs_indicator_one_le A
  have bB : ∀ x, |iB (x + t)| ≤ 1 := fun x => abs_indicator_one_le B _
  have bfA : ∀ x, |fA x| ≤ 1 := abs_levelFill_le A k
  have bfB : ∀ x, |fB (x + t)| ≤ 1 := fun x => abs_levelFill_le B k _
  have bm : ∀ {u v : ℝ}, |u| ≤ 1 → |v| ≤ 1 → |u * v| ≤ 1 := fun {u v} hu hv => by
    rw [abs_mul]; nlinarith [abs_nonneg u, abs_nonneg v]
  have bs : ∀ {u v : ℝ}, |u| ≤ 1 → |v| ≤ 1 → |u - v| ≤ 2 := fun hu hv => by
    rw [abs_le] at hu hv ⊢
    constructor <;> linarith [hu.1, hu.2, hv.1, hv.2]
  -- the translation carries the coset over `g` onto the coset over `g + s`
  have hmp : MeasurePreserving (fun x : K F => x + t) (haarK F) (haarK F) := measurePreserving_add_right _ t
  have hemb : MeasurableEmbedding (fun x : K F => x + t) := measurableEmbedding_addRight t
  have hpre : ∀ g : LevImg F k,
      (fun x : K F => x + t) ⁻¹' (proj F k ⁻¹' {((g + s : LevImg F k) : Lev F k)}) = proj F k ⁻¹' {(g : Lev F k)} := by
    intro g
    ext x
    simp only [Set.mem_preimage, Set.mem_singleton_iff, map_add, ht, AddSubgroup.coe_add, add_left_inj]
  have htrans : ∀ (g : LevImg F k) (φ : K F → ℝ), ∫ x in proj F k ⁻¹' {(g : Lev F k)}, φ (x + t) ∂haarK F =
      ∫ y in proj F k ⁻¹' {((g + s : LevImg F k) : Lev F k)}, φ y ∂haarK F := by
    intro g φ
    rw [← hpre g]
    exact hmp.setIntegral_preimage_emb hemb φ _
  have hfB_at : ∀ (g : LevImg F k) (x : K F), x ∈ proj F k ⁻¹' {(g : Lev F k)} →
      fB (x + t) = fillAt B k ((g + s : LevImg F k) : Lev F k) := by
    intro g x hx
    simp only [Set.mem_preimage, Set.mem_singleton_iff] at hx
    rw [hfB, levelFill_eq, map_add, hx, ht]
    rfl
  have hfA_at : ∀ (g : LevImg F k) (x : K F), x ∈ proj F k ⁻¹' {(g : Lev F k)} → fA x = fillAt A k g := by
    intro g x hx
    simp only [Set.mem_preimage, Set.mem_singleton_iff] at hx
    rw [hfA, levelFill_eq, hx]
  -- the four terms
  have hexp : (fun x => iA x * iB (x + t)) = fun x => fA x * fB (x + t) + fA x * (iB (x + t) - fB (x + t)) +
      ((iA x - fA x) * fB (x + t) + (iA x - fA x) * (iB (x + t) - fB (x + t))) := by
    funext x; ring
  have i1 : Integrable (fun x => fA x * fB (x + t)) (haarK F) :=
    integrable_of_abs_le (mfA.mul mfB) fun x => bm (bfA x) (bfB x)
  have i2 : Integrable (fun x => fA x * (iB (x + t) - fB (x + t))) (haarK F) :=
    integrable_of_abs_le (mfA.mul (mB.sub mfB)) (C := 2) fun x => by
      rw [abs_mul]; nlinarith [bfA x, bs (bB x) (bfB x), abs_nonneg (fA x), abs_nonneg (iB (x + t) - fB (x + t))]
  have i3 : Integrable (fun x => (iA x - fA x) * fB (x + t)) (haarK F) :=
    integrable_of_abs_le ((mA.sub mfA).mul mfB) (C := 2) fun x => by
      rw [abs_mul]; nlinarith [bfB x, bs (bA x) (bfA x), abs_nonneg (fB (x + t)), abs_nonneg (iA x - fA x)]
  have i4 : Integrable (fun x => (iA x - fA x) * (iB (x + t) - fB (x + t))) (haarK F) :=
    integrable_of_abs_le ((mA.sub mfA).mul (mB.sub mfB)) (C := 4) fun x => by
      rw [abs_mul]
      nlinarith [bs (bA x) (bfA x), bs (bB x) (bfB x), abs_nonneg (iA x - fA x), abs_nonneg (iB (x + t) - fB (x + t))]
  have i12 : Integrable (fun x => fA x * fB (x + t) + fA x * (iB (x + t) - fB (x + t))) (haarK F) := i1.add i2
  have i34 : Integrable (fun x => (iA x - fA x) * fB (x + t) + (iA x - fA x) * (iB (x + t) - fB (x + t)))
    (haarK F) := i3.add i4
  rw [hexp, integral_add i12 i34, integral_add i1 i2, integral_add i3 i4]
  -- (i) the fills
  have h1 : ∫ x, fA x * fB (x + t) ∂haarK F =
      (∑ g : LevImg F k, fillAt A k g * fillAt B k ((g + s : LevImg F k) : Lev F k)) / Fintype.card (LevImg F k) := by
    rw [integral_eq_sum_cosets (k := k) i1, Finset.sum_div]
    refine Finset.sum_congr rfl fun g _ => ?_
    rw [setIntegral_congr_fun (measurableSet_coset k _) (g := fun _ => fillAt A k g *
      fillAt B k ((g + s : LevImg F k) : Lev F k)) fun x hx => by
        simp only [hfA_at g x hx, hfB_at g x hx]]
    rw [setIntegral_const, smul_eq_mul, measureReal_def, haarK_coset]
    ring
  -- (ii) the fill of `A` against the residual of `B`
  have h2 : ∫ x, fA x * (iB (x + t) - fB (x + t)) ∂haarK F = 0 := by
    rw [integral_eq_sum_cosets (k := k) i2]
    refine Finset.sum_eq_zero fun g _ => ?_
    rw [setIntegral_congr_fun (measurableSet_coset k _) (g := fun x => fillAt A k g * (iB (x + t) - fB (x + t)))
      fun x hx => by simp only [hfA_at g x hx], integral_const_mul,
      htrans g (fun y => iB y - fB y), setIntegral_resid_coset hB (g + s), mul_zero]
  -- (iii) the residual of `A` against the fill of `B`
  have h3 : ∫ x, (iA x - fA x) * fB (x + t) ∂haarK F = 0 := by
    rw [integral_eq_sum_cosets (k := k) i3]
    refine Finset.sum_eq_zero fun g _ => ?_
    rw [setIntegral_congr_fun (measurableSet_coset k _)
      (g := fun x => (iA x - fA x) * fillAt B k ((g + s : LevImg F k) : Lev F k))
      fun x hx => by simp only [hfB_at g x hx], integral_mul_const, setIntegral_resid_coset hA g, zero_mul]
  rw [h1, h2, h3]
  ring

/-- **The mixing inequality at level `k`**: over a uniformly `c`-thick field, two measurable sets with null edges across every
unit vector satisfy `ab − c√(a(1 − a))√(b(1 − b)) ≤ √(levelResid A k)·√(levelResid B k)`. Route: average the null edge
integrals over representatives `u_s ∈ U` of the level's connection set; split `1_A = E_k 1_A + (1_A − E_k 1_A)` and likewise
`1_B`; the cross terms vanish (`E_k` commutes with translations); the first term is `finite_mixing` on `LevImg F k` with
`levelThick` (coset measures `1/|LevImg F k|`, `Rigidity.Counting.haarK_proj_preimage`; `0 ≤ E_k 1_A ≤ 1`); the last is bounded
by Cauchy–Schwarz. -/
theorem mixing_at_level {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1) {k : ℕ} (hk : 1 ≤ k) {A B : Set (K F)}
    (hA : MeasurableSet A) (hB : MeasurableSet B)
    (hnull : ∀ u ∈ unitVectorsR F, haarK F (A ∩ (fun x => x + ιK F u) ⁻¹' B) = 0) :
    (haarK F A).toReal * (haarK F B).toReal -
        c * Real.sqrt ((haarK F A).toReal * (1 - (haarK F A).toReal)) *
          Real.sqrt ((haarK F B).toReal * (1 - (haarK F B).toReal)) ≤
      Real.sqrt (levelResid F A k) * Real.sqrt (levelResid F B k) := by
  classical
  haveI : Fintype (LevImg F k) := Fintype.ofFinite _
  have hun : ∀ P : StablePrime F, ¬ IsRamified P := fun P => not_isRamified_of_thickAt (hT P) hc
  -- a unit vector over each point of the connection set
  have hrep : ∀ s : LevImg F k, ∃ u : unitRing F,
      s ∈ levU F k → u ∈ unitVectorsR F ∧ proj F k (ιK F u) = (s : Lev F k) := by
    intro s
    by_cases hs : s ∈ levU F k
    · have hs' : (s : Lev F k) ∈ levR F k '' {r | (r : ℂ) ∈ unitVectors F} := by
        rw [image_levR_unitVectors_of_unramified hun k]
        exact hs
      obtain ⟨r, hr, e⟩ := hs'
      exact ⟨r, fun _ => ⟨hr, by rw [proj_ιK]; exact e⟩⟩
    · exact ⟨0, fun h => absurd h hs⟩
  choose u hu using hrep
  set S := (finite_levU (F := F) k).toFinset with hSdef
  have hSne : S.Nonempty := by
    obtain ⟨s, hs⟩ := levU_nonempty (F := F) k
    exact ⟨s, (Set.Finite.mem_toFinset _).2 hs⟩
  have hNpos : (0 : ℝ) < Fintype.card (LevImg F k) := by
    have : 0 < Fintype.card (LevImg F k) := Fintype.card_pos_iff.2 ⟨0⟩
    exact_mod_cast this
  have hSpos : (0 : ℝ) < S.card := by exact_mod_cast hSne.card_pos
  -- the residual product at each `s`
  set I : LevImg F k → ℝ := fun s => ∫ x, (A.indicator (fun _ => (1 : ℝ)) x - levelFill F A k x) *
    (B.indicator (fun _ => (1 : ℝ)) (x + ιK F (u s)) - levelFill F B k (x + ιK F (u s))) ∂haarK F with hI
  have hedge : ∀ s ∈ S, (∑ g : LevImg F k, fillAt A k g * fillAt B k ((g + s : LevImg F k) : Lev F k)) /
      Fintype.card (LevImg F k) = -I s := by
    intro s hs
    obtain ⟨hus, hps⟩ := hu s ((Set.Finite.mem_toFinset _).1 hs)
    have hsplit := edge_split hA hB s (ιK F (u s)) hps
    have h0 : ∫ x, A.indicator (fun _ => (1 : ℝ)) x * B.indicator (fun _ => (1 : ℝ)) (x + ιK F (u s)) ∂haarK F = 0 := by
      have e : (fun x => A.indicator (fun _ => (1 : ℝ)) x * B.indicator (fun _ => (1 : ℝ)) (x + ιK F (u s))) =
          (A ∩ (fun x => x + ιK F (u s)) ⁻¹' B).indicator (fun _ => (1 : ℝ)) := by
        funext x
        by_cases h1 : x ∈ A <;> by_cases h2 : x + ιK F (u s) ∈ B <;> simp [h1, h2, Set.indicator]
      rw [e, integral_indicator_const _ (hA.inter (hB.preimage (measurable_add_const _))), measureReal_def,
        hnull _ hus]
      simp
    rw [h0] at hsplit
    simp only [hI]
    linarith
  -- each residual product is at most `√resA √resB` (Cauchy–Schwarz; the translation preserves Haar measure)
  have hIle : ∀ s : LevImg F k, -I s ≤ Real.sqrt (levelResid F A k) * Real.sqrt (levelResid F B k) := by
    intro s
    have hmp : MeasurePreserving (fun x : K F => x + ιK F (u s)) (haarK F) (haarK F) :=
      measurePreserving_add_right _ _
    have hcs := abs_integral_mul_le (μ := haarK F)
      (f := fun x => A.indicator (fun _ => (1 : ℝ)) x - levelFill F A k x)
      (g := fun x => B.indicator (fun _ => (1 : ℝ)) (x + ιK F (u s)) - levelFill F B k (x + ιK F (u s)))
      ((measurable_indicator_one hA).sub (measurable_levelFill A k))
      (((measurable_indicator_one hB).sub (measurable_levelFill B k)).comp (measurable_add_const (ιK F (u s))))
      (abs_resid_le A k) (fun x => abs_resid_le B k _)
    have hB' : ∫ x, (B.indicator (fun _ => (1 : ℝ)) (x + ιK F (u s)) - levelFill F B k (x + ιK F (u s))) ^ 2 ∂haarK F =
        levelResid F B k :=
      hmp.integral_comp (measurableEmbedding_addRight _)
        (fun y => (B.indicator (fun _ => (1 : ℝ)) y - levelFill F B k y) ^ 2)
    rw [hB'] at hcs
    exact (neg_le_abs _).trans hcs
  -- the finite-group mixing inequality on the level group
  have hfm := finite_mixing S hSne hc0 (levelThick hT hc hk) (fun g => fillAt A k g) (fun g => fillAt B k g)
    (fun g => fillAt_nonneg A k g) (fun g => fillAt_le_one A k g) (fun g => fillAt_nonneg B k g)
    (fun g => fillAt_le_one B k g) (sum_fillAt hA) (sum_fillAt hB)
  refine hfm.trans ?_
  have hswap : (∑ x : LevImg F k, fillAt A k x * ∑ s ∈ S, fillAt B k ((x + s : LevImg F k) : Lev F k)) =
      ∑ s ∈ S, ∑ g : LevImg F k, fillAt A k g * fillAt B k ((g + s : LevImg F k) : Lev F k) := by
    simp_rw [Finset.mul_sum]
    exact Finset.sum_comm
  rw [hswap, div_le_iff₀ (by positivity)]
  have hsum : (∑ s ∈ S, ∑ g : LevImg F k, fillAt A k g * fillAt B k ((g + s : LevImg F k) : Lev F k)) =
      Fintype.card (LevImg F k) * ∑ s ∈ S, -I s := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun s hs => ?_
    rw [← hedge s hs]
    field_simp
  rw [hsum]
  have hb : ∑ s ∈ S, -I s ≤ S.card * (Real.sqrt (levelResid F A k) * Real.sqrt (levelResid F B k)) := by
    have := Finset.sum_le_sum fun s (_ : s ∈ S) => hIle s
    simpa [Finset.sum_const, nsmul_eq_mul] using this
  nlinarith

/-- **The mixing inequality on `K`**: the levels' bound in the limit (`tendsto_levelResid` at `A` and at `B`). -/
theorem mixing_K {c : ℝ} (hT : Thick F c) (hc0 : 0 ≤ c) (hc : c < 1) {A B : Set (K F)} (hA : MeasurableSet A)
    (hB : MeasurableSet B) (hnull : ∀ u ∈ unitVectorsR F, haarK F (A ∩ (fun x => x + ιK F u) ⁻¹' B) = 0) :
    (haarK F A).toReal * (haarK F B).toReal ≤
      c * Real.sqrt ((haarK F A).toReal * (1 - (haarK F A).toReal)) *
        Real.sqrt ((haarK F B).toReal * (1 - (haarK F B).toReal)) := by
  have hlim : Tendsto (fun k => Real.sqrt (levelResid F A k) * Real.sqrt (levelResid F B k)) atTop (𝓝 0) := by
    have h1 := ((Real.continuous_sqrt.tendsto 0).comp (tendsto_levelResid hA)).mul
      ((Real.continuous_sqrt.tendsto 0).comp (tendsto_levelResid hB))
    simpa using h1
  have hle : ∀ᶠ k in atTop, (haarK F A).toReal * (haarK F B).toReal -
      c * Real.sqrt ((haarK F A).toReal * (1 - (haarK F A).toReal)) *
        Real.sqrt ((haarK F B).toReal * (1 - (haarK F B).toReal)) ≤
      Real.sqrt (levelResid F A k) * Real.sqrt (levelResid F B k) :=
    eventually_atTop.2 ⟨1, fun k hk => mixing_at_level hT hc0 hc hk hA hB hnull⟩
  have h0 := ge_of_tendsto hlim hle
  linarith

/-- **Two large sets cannot have null edges**: if `a, b ≥ θ > c/(1 + c)`, the mixing inequality fails — the form the selection
reads. -/
theorem not_both_ge_of_mixing {c θ a b : ℝ} (hc0 : 0 ≤ c) (hθ : c / (1 + c) < θ) (ha : θ ≤ a) (hb : θ ≤ b) (ha1 : a ≤ 1)
    (hb1 : b ≤ 1) : ¬ a * b ≤ c * Real.sqrt (a * (1 - a)) * Real.sqrt (b * (1 - b)) := by
  intro h
  have hθ0 : 0 < θ := lt_of_le_of_lt (div_nonneg hc0 (by linarith)) hθ
  have ha0 : 0 < a := lt_of_lt_of_le hθ0 ha
  have hb0 : 0 < b := lt_of_lt_of_le hθ0 hb
  have hθc : c * (1 - θ) < θ := by
    rw [div_lt_iff₀ (by linarith)] at hθ
    linarith
  have hac : c * (1 - a) < a := by nlinarith
  have hbc : c * (1 - b) < b := by nlinarith
  have hA : 0 ≤ a * (1 - a) := mul_nonneg ha0.le (by linarith)
  have hB : 0 ≤ b * (1 - b) := mul_nonneg hb0.le (by linarith)
  have hsA := Real.sq_sqrt hA
  have hsB := Real.sq_sqrt hB
  have hab0 : 0 < a * b := mul_pos ha0 hb0
  -- square both sides: `(ab)² ≤ c²·a(1 − a)·b(1 − b)`, so `ab ≤ c²(1 − a)(1 − b)`
  have hsq : (a * b) * (a * b) ≤ (c * Real.sqrt (a * (1 - a)) * Real.sqrt (b * (1 - b))) *
      (c * Real.sqrt (a * (1 - a)) * Real.sqrt (b * (1 - b))) := mul_self_le_mul_self hab0.le h
  have e : (c * Real.sqrt (a * (1 - a)) * Real.sqrt (b * (1 - b))) *
      (c * Real.sqrt (a * (1 - a)) * Real.sqrt (b * (1 - b))) = a * b * (c ^ 2 * ((1 - a) * (1 - b))) := by
    have : (c * Real.sqrt (a * (1 - a)) * Real.sqrt (b * (1 - b))) *
        (c * Real.sqrt (a * (1 - a)) * Real.sqrt (b * (1 - b))) =
        c ^ 2 * Real.sqrt (a * (1 - a)) ^ 2 * Real.sqrt (b * (1 - b)) ^ 2 := by ring
    rw [this, hsA, hsB]
    ring
  rw [e] at hsq
  have h2 : a * b ≤ c ^ 2 * ((1 - a) * (1 - b)) := le_of_mul_le_mul_left hsq hab0
  have hca0 : 0 ≤ c * (1 - a) := mul_nonneg hc0 (by linarith)
  have h3 : c * (1 - a) * (c * (1 - b)) < a * b :=
    calc c * (1 - a) * (c * (1 - b)) ≤ c * (1 - a) * b := mul_le_mul_of_nonneg_left hbc.le hca0
      _ < a * b := mul_lt_mul_of_pos_right hac hb0
  nlinarith

/-! ## Spec -/

-- the threshold arithmetic the selection reads: at `c = 1/5`, `θ = 1/5` exceeds `c/(1 + c) = 1/6`, and two masses of `1/5`
-- violate the inequality (`1/25 > (1/5)·(4/25)`).
example : ¬ (1 / 5 : ℝ) * (1 / 5) ≤ 1 / 5 * Real.sqrt (1 / 5 * (1 - 1 / 5)) * Real.sqrt (1 / 5 * (1 - 1 / 5)) :=
  not_both_ge_of_mixing (by norm_num) (by norm_num) le_rfl le_rfl (by norm_num) (by norm_num)

end

end HadwigerNelson.Collapse
