import Proofs.HadwigerNelson.Rigidity.DualGroup
import Mathlib.MeasureTheory.Measure.Prokhorov

/-!
# Herglotz–Bochner on a countable discrete abelian group, existence half (FS-131, job FS131-KR1; module M2a; skeleton)

**Read aloud, against the informal claim.** Every positive-definite `C : G → ℂ` on a countable abelian group `G` is the
Fourier–Stieltjes transform of a finite positive measure on the dual `Ĝ = AddChar G Circle`, and that measure is unique:
`bochnerHerglotz_of_countable : BochnerHerglotz G` — the library's `Prop` (`SpectralChain.BochnerHerglotz`), whose taker at
`G = unitRing F` is the headline's `hBH`. The printed theorem is `[Rudin1962]` 1.4.3 with 1.3.6 (not held, not read); this
module follows neither: **uniqueness** is `DualGroup.measure_eq_of_fourier` (no Herglotz–Bochner, inventory item 757), and
**existence** is a Fejér construction made here.

**The route (`plans/FS131-KR1-chain-map.md` § 2.1).** (i) `exists_almostInvariant_weights`: finitely supported weights
`w n ≥ 0` with `Σ (w n)² = 1` and `⟨w n, τ_z (w n)⟩ → 1` for every `z` — convolutions of uniform weights on the progressions
`{0, gⱼ, …, (M − 1)gⱼ}`, `j ≤ k`, normalised in `ℓ²`; no structure theorem for finitely generated groups is read.
(ii) `exists_fejer_measures`: the densities `p(χ) = Σ_{x,y} w(x)w(y)C(x − y)χ̄(x − y)`, non-negative because `C` is
positive-definite, times `dualHaar G`, are finite measures of mass `C 0` whose coefficients tend to `C`. (iii)
`exists_fourier_eq_of_tendsto`: on the compact dual, a sequence of measures of bounded mass whose coefficients converge has a
limit point with those coefficients (Prokhorov on a compact space, `isCompact_setOf_finiteMeasure_le_of_compactSpace`).

**Models.** `G` countable is the only hypothesis; `G = ℤ` and the trivial group are its members, and `C = 1` (the
transform of the point mass at the trivial character) is a positive-definite function on each.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory Filter Topology SpectralChain SpectralInputs

noncomputable section

variable (G : Type*) [AddCommGroup G]

/-! ### Private helpers: the box weights -/

/-- The box `{0, …, n}^n` of exponent vectors. -/
private def wBox (n : ℕ) : Finset (Fin n → ℕ) := Fintype.piFinset fun _ => Finset.range (n + 1)

/-- The point `Σ_j a_j g_j` of an exponent vector. -/
private def wPt {G : Type*} [AddCommGroup G] (g : ℕ → G) {n : ℕ} (a : Fin n → ℕ) : G := ∑ j, a j • g j

/-- The number of exponent vectors of the box at a point (the push-forward of the counting measure). -/
private def wCnt {G : Type*} [AddCommGroup G] [DecidableEq G] (g : ℕ → G) (n : ℕ) (x : G) : ℕ :=
  ((wBox n).filter fun a => wPt g a = x).card

private theorem wPt_add_single {G : Type*} [AddCommGroup G] (g : ℕ → G) {n : ℕ} (a : Fin n → ℕ) (m : Fin n) :
    wPt g (a + Pi.single m 1) = wPt g a + g m := by
  simp only [wPt, Pi.add_apply, add_smul, Finset.sum_add_distrib, Pi.single_apply, ite_smul, one_smul,
    zero_smul, Finset.sum_ite_eq', Finset.mem_univ, if_true]

private theorem card_wBox_pos (n : ℕ) : 0 < (wBox n).card := by
  rw [wBox, Fintype.card_piFinset]
  exact Finset.prod_pos fun _ _ => by simp

/-- The vectors of the box whose `m`-th exponent is below `n` are `n/(n+1)` of it. -/
private theorem card_wBox_lt (n : ℕ) (m : Fin n) :
    ((wBox n).filter fun a => a m < n).card * (n + 1) = (wBox n).card * n := by
  classical
  have hD : ((wBox n).filter fun a => a m < n) =
      Fintype.piFinset fun j => if j = m then Finset.range n else Finset.range (n + 1) := by
    ext a
    simp only [wBox, Finset.mem_filter, Fintype.mem_piFinset, Finset.mem_range]
    constructor
    · rintro ⟨h, hm⟩ j
      split_ifs with hj
      · subst hj; simpa using hm
      · simpa using h j
    · intro h
      refine ⟨fun j => ?_, ?_⟩
      · have := h j
        split_ifs at this with hj
        · simp at this; omega
        · simpa using this
      · simpa using h m
  rw [hD, wBox, Fintype.card_piFinset, Fintype.card_piFinset,
    ← Finset.mul_prod_erase Finset.univ _ (Finset.mem_univ m),
    ← Finset.mul_prod_erase Finset.univ (fun _ => (Finset.range (n + 1)).card) (Finset.mem_univ m)]
  have : ∏ x ∈ Finset.univ.erase m, (if x = m then Finset.range n else Finset.range (n + 1)).card =
      ∏ x ∈ Finset.univ.erase m, (Finset.range (n + 1)).card :=
    Finset.prod_congr rfl fun x hx => by rw [if_neg (Finset.ne_of_mem_erase hx)]
  rw [this]
  simp only [if_true, Finset.card_range]
  ring


/-- **Almost-invariant weights in `ℓ²`** on a countable abelian group: finitely supported, non-negative, of norm one, with
`⟨w n, τ_z (w n)⟩ = Σ_x w n x · w n (x + z) → 1` for every `z`. Read by M2a (here, with `w`) and M3
(`Rigidity/InvariantMeasure`, with the probability weights `(w n)²`: `Σ_x |w(x)² − w(x + z)²| ≤ 2‖w − τ_z w‖₂`). -/
theorem exists_almostInvariant_weights [Countable G] :
    ∃ w : ℕ → G →₀ ℝ, (∀ n x, 0 ≤ w n x) ∧ (∀ n, ∑ x ∈ (w n).support, w n x ^ 2 = 1) ∧
      ∀ z : G, Tendsto (fun n => ∑ x ∈ (w n).support, w n x * w n (x + z)) atTop (𝓝 1) := by
  classical
  obtain ⟨g, hg⟩ := exists_surjective_nat G
  -- `ν n x = #{a ∈ box : Σ a_j g_j = x} / #box`, and `w n = √(ν n)`
  let ν : ℕ → G → ℝ := fun n x => (wCnt g n x : ℝ) / (wBox n).card
  have hν0 : ∀ n x, 0 ≤ ν n x := fun n x => by positivity
  have hsupp : ∀ n x, √(ν n x) ≠ 0 → x ∈ (wBox n).image (wPt g) := by
    intro n x hx
    have hc : wCnt g n x ≠ 0 := by
      intro h0
      apply hx
      simp [ν, h0]
    obtain ⟨a, ha⟩ := Finset.card_ne_zero.1 hc
    rw [Finset.mem_filter] at ha
    exact Finset.mem_image.2 ⟨a, ha.1, ha.2⟩
  let w : ℕ → G →₀ ℝ := fun n => Finsupp.onFinset _ (fun x => √(ν n x)) (hsupp n)
  have hw : ∀ n x, w n x = √(ν n x) := fun n x => Finsupp.onFinset_apply
  have hBpos : ∀ n, (0 : ℝ) < (wBox n).card := fun n => by exact_mod_cast card_wBox_pos n
  -- the support is the image of the box
  have hS : ∀ n, (w n).support = (wBox n).image (wPt g) := by
    intro n
    refine Finset.Subset.antisymm (fun x hx => hsupp n x (by rw [← hw]; exact Finsupp.mem_support_iff.1 hx))
      fun x hx => ?_
    obtain ⟨a, ha, rfl⟩ := Finset.mem_image.1 hx
    rw [Finsupp.mem_support_iff, hw]
    have hc : 0 < wCnt g n (wPt g a) := Finset.card_pos.2 ⟨a, Finset.mem_filter.2 ⟨ha, rfl⟩⟩
    have : 0 < ν n (wPt g a) := div_pos (by exact_mod_cast hc) (hBpos n)
    exact (Real.sqrt_pos.2 this).ne'
  -- `Σ_x ν(x) = 1`, fibre by fibre
  have hsumcnt : ∀ n, ∑ x ∈ (wBox n).image (wPt g), (wCnt g n x : ℝ) = (wBox n).card := by
    intro n
    have := Finset.card_eq_sum_card_fiberwise (s := wBox n) (t := (wBox n).image (wPt g)) (f := wPt g)
      fun a ha => Finset.mem_coe.2 (Finset.mem_image_of_mem _ (Finset.mem_coe.1 ha))
    rw [this]
    push_cast
    rfl
  have hsq : ∀ n, ∑ x ∈ (w n).support, w n x ^ 2 = 1 := by
    intro n
    rw [hS]
    simp only [hw, Real.sq_sqrt (hν0 _ _), ν, ← Finset.sum_div, hsumcnt]
    exact div_self (hBpos n).ne'
  refine ⟨w, fun n x => by rw [hw]; exact Real.sqrt_nonneg _, hsq, fun z => ?_⟩
  obtain ⟨m, rfl⟩ := hg z
  -- the upper bound `1`, by `ab ≤ (a² + b²)/2`
  have hup : ∀ n, ∑ x ∈ (w n).support, w n x * w n (x + g m) ≤ 1 := by
    intro n
    have hshift : ∑ x ∈ (w n).support, w n (x + g m) ^ 2 ≤ 1 := by
      simp only [hw, Real.sq_sqrt (hν0 _ _), ν, ← Finset.sum_div]
      rw [div_le_one (hBpos n)]
      let s := (wBox n).filter fun a => wPt g a - g m ∈ (w n).support
      have hfib := Finset.card_eq_sum_card_fiberwise (s := s) (t := (w n).support) (f := fun a => wPt g a - g m)
        fun a ha => (Finset.mem_filter.1 (Finset.mem_coe.1 ha)).2
      have hle : (s.card : ℝ) ≤ (wBox n).card := by exact_mod_cast Finset.card_filter_le _ _
      refine le_of_eq_of_le ?_ hle
      rw [hfib]
      push_cast
      refine Finset.sum_congr rfl fun x hx => ?_
      have hfx : (s.filter fun a => wPt g a - g m = x) = (wBox n).filter fun a => wPt g a = x + g m := by
        ext a
        simp only [s, Finset.mem_filter, sub_eq_iff_eq_add]
        constructor
        · rintro ⟨⟨ha, _⟩, h⟩
          exact ⟨ha, h⟩
        · rintro ⟨ha, h⟩
          exact ⟨⟨ha, by rw [h, add_sub_cancel_right]; exact hx⟩, h⟩
      rw [hfx]
      rfl
    have h2 : ∀ x, w n x * w n (x + g m) ≤ (w n x ^ 2 + w n (x + g m) ^ 2) / 2 := fun x => by
      nlinarith [two_mul_le_add_sq (w n x) (w n (x + g m))]
    calc ∑ x ∈ (w n).support, w n x * w n (x + g m)
        ≤ ∑ x ∈ (w n).support, (w n x ^ 2 + w n (x + g m) ^ 2) / 2 := Finset.sum_le_sum fun x _ => h2 x
      _ = (∑ x ∈ (w n).support, w n x ^ 2 + ∑ x ∈ (w n).support, w n (x + g m) ^ 2) / 2 := by
          rw [← Finset.sum_div, Finset.sum_add_distrib]
      _ ≤ 1 := by rw [hsq]; linarith
  -- the lower bound `n/(n+1)` once `m < n`, by the vectors whose `m`-th exponent can grow
  have hlow : ∀ n, m < n → (n : ℝ) / (n + 1) ≤ ∑ x ∈ (w n).support, w n x * w n (x + g m) := by
    intro n hmn
    let mm : Fin n := ⟨m, hmn⟩
    let D := (wBox n).filter fun a => a mm < n
    have hcD : ∀ x, ((D.filter fun a => wPt g a = x).card : ℝ) ≤ wCnt g n x := fun x => by
      exact_mod_cast Finset.card_le_card (Finset.filter_subset_filter _ (Finset.filter_subset _ _))
    have hcD' : ∀ x, ((D.filter fun a => wPt g a = x).card : ℝ) ≤ wCnt g n (x + g m) := by
      intro x
      have : (D.filter fun a => wPt g a = x).card ≤ wCnt g n (x + g m) := by
        refine Finset.card_le_card_of_injOn (fun a => a + Pi.single mm 1) (fun a ha => ?_)
          (fun a _ b _ hab => add_right_cancel hab)
        simp only [D, Finset.mem_coe, Finset.mem_filter] at ha
        obtain ⟨⟨haB, ham⟩, hax⟩ := ha
        simp only [Finset.mem_coe, Finset.mem_filter, wBox, Fintype.mem_piFinset, Finset.mem_range]
        refine ⟨fun j => ?_, by rw [wPt_add_single, hax]⟩
        simp only [wBox, Fintype.mem_piFinset, Finset.mem_range] at haB
        by_cases hj : j = mm
        · subst hj; simp; omega
        · simp [hj, haB j]
      exact_mod_cast this
    have hterm : ∀ x, ((D.filter fun a => wPt g a = x).card : ℝ) / (wBox n).card ≤ w n x * w n (x + g m) := by
      intro x
      rw [hw, hw, ← Real.sqrt_mul (hν0 _ _)]
      refine Real.le_sqrt_of_sq_le ?_
      have h1 := div_le_div_of_nonneg_right (hcD x) (hBpos n).le
      have h2 := div_le_div_of_nonneg_right (hcD' x) (hBpos n).le
      have h0 : (0 : ℝ) ≤ (D.filter fun a => wPt g a = x).card / (wBox n).card := by positivity
      rw [sq]
      exact mul_le_mul h1 h2 h0 (hν0 _ _)
    have hsumD : ∑ x ∈ (w n).support, ((D.filter fun a => wPt g a = x).card : ℝ) = D.card := by
      have := Finset.card_eq_sum_card_fiberwise (s := D) (t := (w n).support) (f := wPt g) fun a ha => by
        rw [Finset.mem_coe, hS]
        exact Finset.mem_image_of_mem _ (Finset.mem_filter.1 (Finset.mem_coe.1 ha)).1
      rw [this]
      push_cast
      rfl
    have hD := card_wBox_lt n mm
    calc (n : ℝ) / (n + 1) = (D.card : ℝ) / (wBox n).card := by
          rw [div_eq_div_iff (by positivity) (hBpos n).ne', mul_comm]
          exact_mod_cast hD.symm
      _ = ∑ x ∈ (w n).support, ((D.filter fun a => wPt g a = x).card : ℝ) / (wBox n).card := by
          rw [← Finset.sum_div, hsumD]
      _ ≤ _ := Finset.sum_le_sum fun x _ => hterm x
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' (tendsto_natCast_div_add_atTop (1 : ℝ)) tendsto_const_nhds ?_
    (Filter.Eventually.of_forall hup)
  filter_upwards [Filter.eventually_gt_atTop m] with n hn
  exact hlow n hn

/-- The Fejér sum at `z x = w x · χ(−x)`, as a combination of characters. -/
private theorem fejer_sum_eq {G : Type*} [AddCommGroup G] (C : G → ℂ) (w : G →₀ ℝ) (χ : AddChar G Circle) :
    ∑ x ∈ w.support, ∑ x' ∈ w.support,
        ((w x : ℂ) * (χ (-x) : ℂ)) * star ((w x' : ℂ) * (χ (-x') : ℂ)) * C (x - x') =
      ∑ x ∈ w.support, ∑ x' ∈ w.support, ((w x : ℂ) * (w x' : ℂ) * C (x - x')) * (χ (x' - x) : ℂ) := by
  refine Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun x' _ => ?_
  have hc : χ (x' - x) = χ (-x) * (χ (-x'))⁻¹ := by
    rw [← AddChar.map_neg_eq_inv, ← AddChar.map_add_eq_mul]
    congr 1
    abel
  have hc' := congrArg (fun z : Circle => (z : ℂ)) hc
  simp only [Circle.coe_mul, Circle.coe_inv_eq_conj] at hc'
  rw [hc']
  simp only [star_mul', Complex.star_def, Complex.conj_ofReal]
  ring

private theorem integral_dualHaar_eval {G : Type*} [AddCommGroup G] [Countable G] [DecidableEq G] (s : G) :
    ∫ χ, (χ s : ℂ) ∂(dualHaar G) = if s = 0 then 1 else 0 := by
  split_ifs with hs
  · subst hs
    exact dualHaar_fourier_zero
  · exact (isHaarFourier_dualHaar G).2 s hs

private theorem integrable_dualHaar_eval {G : Type*} [AddCommGroup G] [Countable G] (c : ℂ) (s : G) :
    Integrable (fun χ : AddChar G Circle => c * (χ s : ℂ)) (dualHaar G) :=
  Integrable.of_bound ((measurable_evalChar s).const_mul c).aestronglyMeasurable ‖c‖
    (Filter.Eventually.of_forall fun χ => by rw [norm_mul, Circle.norm_coe, mul_one])

/-- The coefficients of the Fejér density: `∫ p(χ) χ(r) dχ = C(r) · Σ_x w(x) w(x − r)`. -/
private theorem integral_fejer {G : Type*} [AddCommGroup G] [Countable G] [DecidableEq G] (C : G → ℂ)
    (w : G →₀ ℝ) (r : G) :
    ∫ χ, (∑ x ∈ w.support, ∑ x' ∈ w.support, ((w x : ℂ) * (w x' : ℂ) * C (x - x')) * (χ (x' - x) : ℂ)) *
        (χ r : ℂ) ∂(dualHaar G) = C r * ∑ x ∈ w.support, (w x : ℂ) * (w (x - r) : ℂ) := by
  have h1 : (fun χ : AddChar G Circle =>
      (∑ x ∈ w.support, ∑ x' ∈ w.support, ((w x : ℂ) * (w x' : ℂ) * C (x - x')) * (χ (x' - x) : ℂ)) *
        (χ r : ℂ)) = fun χ => ∑ x ∈ w.support, ∑ x' ∈ w.support,
          ((w x : ℂ) * (w x' : ℂ) * C (x - x')) * (χ (x' - x + r) : ℂ) := by
    funext χ
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun x' _ => ?_
    rw [AddChar.map_add_eq_mul, Circle.coe_mul, mul_assoc]
  rw [h1, integral_finsetSum _ fun x _ => integrable_finsetSum _ fun x' _ => integrable_dualHaar_eval _ _,
    Finset.mul_sum]
  refine Finset.sum_congr rfl fun x _ => ?_
  rw [integral_finsetSum _ fun x' _ => integrable_dualHaar_eval _ _]
  have hc : ∀ x' : G, ∫ χ, ((w x : ℂ) * (w x' : ℂ) * C (x - x')) * (χ (x' - x + r) : ℂ) ∂(dualHaar G) =
      if x' = x - r then (w x : ℂ) * (w x' : ℂ) * C (x - x') else 0 := by
    intro x'
    rw [integral_const_mul, integral_dualHaar_eval]
    have : (x' - x + r = 0) ↔ (x' = x - r) := by
      constructor <;> intro h
      · rw [← sub_eq_zero, ← h]; abel
      · rw [h]; abel
    by_cases h : x' = x - r
    · rw [if_pos (this.2 h), if_pos h, mul_one]
    · rw [if_neg (mt this.1 h), if_neg h, mul_zero]
  rw [Finset.sum_congr rfl fun x' _ => hc x', Finset.sum_ite_eq']
  split_ifs with hx
  · rw [sub_sub_cancel]
    ring
  · rw [Finsupp.notMem_support_iff.1 hx]
    simp

/-- **Fejér measures**: a positive-definite `C` on a countable `G` is the limit, coefficient by coefficient, of finite
measures on `Ĝ` of mass `(C 0).re` (each a non-negative density times `dualHaar G`). -/
theorem exists_fejer_measures [Countable G] (C : G → ℂ) (hC : PosDef C) :
    ∃ σ : ℕ → Measure (AddChar G Circle), (∀ n, IsFiniteMeasure (σ n)) ∧
      (∀ n, σ n Set.univ = ENNReal.ofReal (C 0).re) ∧
      ∀ y : G, Tendsto (fun n => ∫ χ, (χ y : ℂ) ∂(σ n)) atTop (𝓝 (C y)) := by
  classical
  obtain ⟨w, -, hw1, hwt⟩ := exists_almostInvariant_weights G
  -- the Fejér density `q n χ`, real and `≥ 0` by `hC` at `z x = w x · χ(−x)`
  set q : ℕ → AddChar G Circle → ℂ := fun n χ => ∑ x ∈ (w n).support, ∑ x' ∈ (w n).support,
    ((w n x : ℂ) * (w n x' : ℂ) * C (x - x')) * (χ (x' - x) : ℂ) with hq
  have hq_pos : ∀ n χ, (q n χ).im = 0 ∧ 0 ≤ (q n χ).re := fun n χ => by
    have h := hC (w n).support fun x => (w n x : ℂ) * (χ (-x) : ℂ)
    rw [fejer_sum_eq] at h
    exact h
  have hq_real : ∀ n χ, (((q n χ).re : ℝ) : ℂ) = q n χ := fun n χ =>
    Complex.ext (by simp) (by rw [Complex.ofReal_im, (hq_pos n χ).1])
  have hq_meas : ∀ n, Measurable (q n) := fun n =>
    Finset.measurable_sum _ fun x _ => Finset.measurable_sum _ fun x' _ => (measurable_evalChar _).const_mul _
  set d : ℕ → AddChar G Circle → NNReal := fun n χ => Real.toNNReal (q n χ).re with hd_def
  have hd : ∀ n χ, ((d n χ : ℝ) : ℂ) = q n χ := fun n χ => by
    rw [hd_def, Real.coe_toNNReal _ (hq_pos n χ).2, hq_real]
  have hd_meas : ∀ n, Measurable (d n) := fun n => (Complex.measurable_re.comp (hq_meas n)).real_toNNReal
  set σ : ℕ → Measure (AddChar G Circle) := fun n => (dualHaar G).withDensity fun χ => (d n χ : ENNReal) with hσ
  have hcoef : ∀ n r, ∫ χ, (χ r : ℂ) ∂(σ n) = C r * ∑ x ∈ (w n).support, (w n x : ℂ) * (w n (x - r) : ℂ) := by
    intro n r
    rw [hσ, integral_withDensity_eq_integral_smul (hd_meas n), ← integral_fejer C (w n) r]
    refine integral_congr_ae (Filter.Eventually.of_forall fun χ => ?_)
    show d n χ • (χ r : ℂ) = q n χ * (χ r : ℂ)
    rw [NNReal.smul_def, Complex.real_smul, hd]
  have hbound : ∀ n χ, ‖((d n χ : ℝ))‖ ≤ ∑ x ∈ (w n).support, ∑ x' ∈ (w n).support,
      ‖(w n x : ℂ) * (w n x' : ℂ) * C (x - x')‖ := by
    intro n χ
    have h3 : ‖((d n χ : ℝ))‖ = ‖q n χ‖ := by rw [← hd, Complex.norm_real]
    rw [h3]
    refine (norm_sum_le _ _).trans (Finset.sum_le_sum fun x _ => (norm_sum_le _ _).trans
      (Finset.sum_le_sum fun x' _ => ?_))
    rw [norm_mul, Circle.norm_coe, mul_one]
  have hfin : ∀ n, IsFiniteMeasure (σ n) := fun n => by
    refine isFiniteMeasure_withDensity ?_
    rw [lintegral_coe_eq_integral _ (Integrable.of_bound (hd_meas n).coe_nnreal_real.aestronglyMeasurable _
      (Filter.Eventually.of_forall (hbound n)))]
    exact ENNReal.ofReal_ne_top
  have hsq : ∀ n, ∑ x ∈ (w n).support, (w n x : ℂ) * (w n (x - 0) : ℂ) = 1 := fun n => by
    have h := hw1 n
    simp only [sub_zero]
    exact_mod_cast (by simpa [sq] using h : ∑ x ∈ (w n).support, w n x * w n x = 1)
  refine ⟨σ, hfin, fun n => ?_, fun y => ?_⟩
  · -- the mass is the coefficient at `0`
    haveI := hfin n
    have h0 := hcoef n 0
    have h1 : ∀ χ : AddChar G Circle, ((χ 0 : Circle) : ℂ) = 1 := fun χ => by simp
    simp only [h1] at h0
    rw [hsq, mul_one] at h0
    have h0' : ∫ _χ, (1 : ℂ) ∂(σ n) = ((σ n).real Set.univ : ℂ) := by
      rw [integral_const, Complex.real_smul, mul_one]
    have hre : (σ n).real Set.univ = (C 0).re := by
      have := congrArg Complex.re (h0'.symm.trans h0)
      rwa [Complex.ofReal_re] at this
    rw [← ENNReal.ofReal_toReal (measure_ne_top (σ n) Set.univ), ← hre]
    rfl
  · have hlim : Tendsto (fun n => ∑ x ∈ (w n).support, (w n x : ℂ) * (w n (x - y) : ℂ)) atTop (𝓝 1) := by
      have h := (Complex.continuous_ofReal.tendsto 1).comp (hwt (-y))
      rw [Complex.ofReal_one] at h
      refine h.congr fun n => ?_
      simp only [Function.comp_apply, Complex.ofReal_sum, Complex.ofReal_mul, sub_eq_add_neg]
    have h := hlim.const_mul (C y)
    rw [mul_one] at h
    exact h.congr fun n => (hcoef n y).symm

/-- **A limit point keeps the limits of the coefficients**: on the compact dual of a countable group, finite measures of
mass at most `M < ∞` whose coefficients converge to `C` have a finite limit point with coefficients `C`. -/
theorem exists_fourier_eq_of_tendsto [Countable G] (σ : ℕ → Measure (AddChar G Circle))
    (hfin : ∀ n, IsFiniteMeasure (σ n)) (M : ENNReal) (hM : ∀ n, σ n Set.univ ≤ M) (hMtop : M ≠ ⊤) (C : G → ℂ)
    (hC : ∀ y : G, Tendsto (fun n => ∫ χ, (χ y : ℂ) ∂(σ n)) atTop (𝓝 (C y))) :
    ∃ σ' : Measure (AddChar G Circle), IsFiniteMeasure σ' ∧ ∀ y : G, ∫ χ, (χ y : ℂ) ∂σ' = C y := by
  let σF : ℕ → FiniteMeasure (AddChar G Circle) := fun n => ⟨σ n, hfin n⟩
  have hK := isCompact_setOf_finiteMeasure_le_of_compactSpace (AddChar G Circle) M.toNNReal
  have hle : Filter.map σF atTop ≤ Filter.principal {μ : FiniteMeasure (AddChar G Circle) | μ.mass ≤ M.toNNReal} := by
    rw [Filter.map_le_iff_le_comap, Filter.comap_principal, Filter.le_principal_iff]
    refine Filter.univ_mem' fun n => ?_
    show (σF n).mass ≤ M.toNNReal
    rw [← ENNReal.coe_le_coe, FiniteMeasure.ennreal_mass, ENNReal.coe_toNNReal hMtop]
    exact hM n
  obtain ⟨σ', -, hσ'⟩ := hK.exists_clusterPt hle
  refine ⟨σ', inferInstance, fun y => ?_⟩
  -- the coefficient at `y` is continuous on finite measures, and it tends to `C y`
  let f : BoundedContinuousFunction (AddChar G Circle) ℂ :=
    BoundedContinuousFunction.mkOfCompact ⟨fun χ => (χ y : ℂ), continuous_evalChar G y⟩
  have hf : Continuous fun μ : FiniteMeasure (AddChar G Circle) => ∫ χ, f χ ∂(μ : Measure (AddChar G Circle)) :=
    continuous_iff_continuousAt.2 fun μ =>
      (FiniteMeasure.tendsto_iff_forall_integral_rclike_tendsto ℂ).1 Filter.tendsto_id f
  have hcl := hσ'.map hf.continuousAt (Filter.tendsto_map' (hC y))
  exact eq_of_nhds_neBot hcl

/-- **Herglotz–Bochner on a countable discrete abelian group, with uniqueness** (`[Rudin1962]` 1.4.3 and 1.3.6, by another
route): existence from the Fejér measures and a limit point; uniqueness from `measure_eq_of_fourier`. -/
theorem bochnerHerglotz_of_countable [Countable G] : BochnerHerglotz G := by
  intro C hC
  obtain ⟨σ, hfin, hmass, hlim⟩ := exists_fejer_measures G C hC
  obtain ⟨σ', hσ', hF⟩ := exists_fourier_eq_of_tendsto G σ hfin _ (fun n => (hmass n).le) ENNReal.ofReal_ne_top C hlim
  refine ⟨σ', hσ', hF, fun σ'' h'' hF'' => ?_⟩
  haveI := hσ'
  haveI := h''
  exact measure_eq_of_fourier fun r => (hF'' r).trans (hF r).symm

end

end HadwigerNelson.Rigidity
