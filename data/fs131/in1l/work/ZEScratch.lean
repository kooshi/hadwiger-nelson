import Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames
import Proofs.HadwigerNelson.Outside.OAI015Maximal

namespace HadwigerNelson.Rigidity

open MeasureTheory Filter

open scoped ENNReal

variable {X : Type*}

/-- The tail of a geometric series: for `0 ≤ r < 1` and `η > 0` some `N` has `r^{N'}/(1 − r) ≤ η` for every `N' ≥ N`. -/
theorem exists_geom_tail_le' {r η : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) (hη : 0 < η) :
    ∃ N : ℕ, ∀ N' : ℕ, N ≤ N' → r ^ N' / (1 - r) ≤ η := by
  have h1 : 0 < 1 - r := by linarith
  have ht := tendsto_pow_atTop_nhds_zero_of_lt_one hr0 hr1
  obtain ⟨N, hN⟩ := (ht.eventually (gt_mem_nhds (mul_pos hη h1))).exists_forall_of_atTop
  refine ⟨N, fun N' hN' => ?_⟩
  rw [div_le_iff₀ h1]
  exact (hN N' hN').le

theorem en2ze' {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ]
    {T : X → X} (hT : MeasurePreserving T μ μ) {a : ℕ} {P : X → Fin a} (hP : Measurable P)
    (h0 : partitionEntropy μ T P = 0) {β η : ℝ} (hβ : 0 < β) (hη : 0 < η) :
    ∃ (N₀ : ℕ) (X' : Set X), MeasurableSet X' ∧ 1 - η ≤ μ.real X' ∧
      ∀ x ∈ X', ∀ n : ℕ, N₀ ≤ n → Real.exp (-(β * n)) ≤ μ.real (nameCell T P n (nameOf T P n x)) := by
  classical
  have hTm : Measurable T := hT.measurable
  -- Step 1: a letter exists; the parameters `γ = β/8` and `θ = min (η/2) (β/(8 log 2a))`.
  have ha : 1 ≤ a := by
    obtain ⟨x⟩ := nonempty_of_isProbabilityMeasure μ
    exact Nat.one_le_iff_ne_zero.mpr fun h => by subst h; exact (P x).elim0
  haveI : Nonempty (Fin a) := ⟨⟨0, ha⟩⟩
  have ha' : (1 : ℝ) ≤ a := by exact_mod_cast ha
  have hLpos : 0 < Real.log (2 * (a : ℝ)) := Real.log_pos (by linarith)
  have hγpos : 0 < β / 8 := by positivity
  set θ := min (η / 2) (β / (8 * Real.log (2 * (a : ℝ)))) with hθdef
  have hθpos : 0 < θ := lt_min (by positivity) (by positivity)
  have hθη : θ ≤ η / 2 := min_le_left _ _
  have hθL : θ * Real.log (2 * (a : ℝ)) ≤ β / 8 := by
    have h1 := min_le_right (η / 2) (β / (8 * Real.log (2 * (a : ℝ))))
    calc θ * Real.log (2 * (a : ℝ)) ≤ β / (8 * Real.log (2 * (a : ℝ))) * Real.log (2 * (a : ℝ)) :=
          mul_le_mul_of_nonneg_right h1 hLpos.le
      _ = β / 8 := by field_simp
  -- Step 2: one block length `k` with `γ k ≥ log 2` and `H_k ≤ γ θ² k`; the heavy names and the light points.
  obtain ⟨k, hKk, hkpos, hHk⟩ :=
    exists_blockEntropy_le_mul μ hT hP h0 (ε := β / 8 * θ ^ 2) (by positivity) ⌈Real.log 2 / (β / 8)⌉₊
  have hk1 : 1 ≤ k := hkpos
  have hkR : (0 : ℝ) < k := by exact_mod_cast hkpos
  have hγk : Real.log 2 ≤ β / 8 * k := by
    have h1 : Real.log 2 / (β / 8) ≤ k := (Nat.le_ceil _).trans (by exact_mod_cast hKk)
    rw [div_le_iff₀ hγpos] at h1
    linarith
  set 𝒢 := heavyNames μ T P k (Real.exp (-(β / 8 * k))) with h𝒢def
  have hg2 : 2 ≤ Real.exp (β / 8 * k) :=
    calc (2 : ℝ) = Real.exp (Real.log 2) := (Real.exp_log (by norm_num)).symm
      _ ≤ Real.exp (β / 8 * k) := Real.exp_le_exp.mpr hγk
  have h𝒢g : (𝒢.card : ℝ) ≤ Real.exp (β / 8 * k) := by
    have h := mul_card_heavyNames_le μ hTm hP k (Real.exp_pos (-(β / 8 * k)))
    have e : (𝒢.card : ℝ) = Real.exp (β / 8 * k) * (Real.exp (-(β / 8 * k)) * 𝒢.card) := by
      rw [← mul_assoc, ← Real.exp_add, add_neg_cancel, Real.exp_zero, one_mul]
    rw [e]
    calc Real.exp (β / 8 * k) * (Real.exp (-(β / 8 * k)) * 𝒢.card) ≤ Real.exp (β / 8 * k) * 1 :=
          mul_le_mul_of_nonneg_left h (Real.exp_pos _).le
      _ = Real.exp (β / 8 * k) := mul_one _
  set B := {x | nameOf T P k x ∉ 𝒢} with hBdef
  have hBm : MeasurableSet B :=
    measurable_nameOf hTm hP k (show MeasurableSet {w : Fin k → Fin a | w ∉ 𝒢} from (Set.toFinite _).measurableSet)
  have hB : μ.real B ≤ θ ^ 2 := by
    have h := mul_measureReal_light_le_blockEntropy μ hTm hP k hγpos.le
    have h2 : β / 8 * k * μ.real B ≤ β / 8 * k * θ ^ 2 :=
      calc β / 8 * k * μ.real B ≤ blockEntropy μ T P k := h
        _ ≤ β / 8 * θ ^ 2 * k := hHk
        _ = β / 8 * k * θ ^ 2 := by ring
    exact le_of_mul_le_mul_left h2 (by positivity)
  -- Step 3: the maximal inequality — the points that visit `B` too often have mass at most `θ`.
  set E := {x | ∃ n : ℕ, θ * n < (visits T B n x : ℝ)} with hEdef
  have hEm : MeasurableSet E := Outside.OAI015.measurableSet_excessiveOccupation hTm hBm θ
  have hE : μ E ≤ ENNReal.ofReal θ := by
    have h := measure_frequentVisits_le μ hT hBm hθpos
    have hμB : μ B ≤ ENNReal.ofReal θ * ENNReal.ofReal θ := by
      rw [← ENNReal.ofReal_mul hθpos.le, ← ofReal_measureReal]
      exact ENNReal.ofReal_le_ofReal (by nlinarith)
    exact (ENNReal.mul_le_mul_iff_right (ENNReal.ofReal_pos.mpr hθpos).ne' ENNReal.ofReal_ne_top).mp (h.trans hμB)
  -- Step 4: off `E`, every name has few bad starts, and few such names exist once `n ≥ max k ⌈k/θ⌉`.
  let W : (n : ℕ) → Finset (Fin n → Fin a) := fun n =>
    (Finset.univ : Finset (Fin n → Fin a)).filter fun w => (badStarts 𝒢 w : ℝ) ≤ θ * n
  have hWmem : ∀ x ∉ E, ∀ n, nameOf T P n x ∈ W n := by
    intro x hx n
    simp only [W, Finset.mem_filter, Finset.mem_univ, true_and]
    have h1 : (visits T B n x : ℝ) ≤ θ * n := by
      by_contra h
      exact hx ⟨n, not_le.mp h⟩
    exact le_trans (by exact_mod_cast badStarts_nameOf_le_visits μ hk1 (Real.exp (-(β / 8 * k))) n x) h1
  set N₁ := max k ⌈(k : ℝ) / θ⌉₊ with hN₁def
  have hWcard : ∀ n, N₁ ≤ n → ((W n).card : ℝ) ≤ Real.exp (β * n / 2) := by
    intro n hn
    have hkn : k ≤ n := le_trans (le_max_left _ _) hn
    have hkθ : (k : ℝ) ≤ θ * n := by
      have h1 : (k : ℝ) / θ ≤ n := (Nat.le_ceil _).trans (by exact_mod_cast le_trans (le_max_right _ _) hn)
      rw [div_le_iff₀ hθpos] at h1
      linarith
    have h1 := card_words_badStarts_le hk1 𝒢 hg2 h𝒢g hθpos.le hkn
    simp only [Fintype.card_fin] at h1
    have hgpow : Real.exp (β / 8 * k) ^ (2 * n / k : ℝ) = Real.exp (2 * (β / 8) * n) := by
      rw [← Real.exp_mul]
      congr 1
      field_simp
    have h2 := rpow_mul_exp_le_exp (a := (a : ℝ)) (n := (n : ℝ)) (k := (k : ℝ)) ha' hθpos.le hθL (by positivity) hkθ
    calc ((W n).card : ℝ) ≤ (2 * (a : ℝ)) ^ (θ * n + k) * Real.exp (β / 8 * k) ^ (2 * n / k : ℝ) := h1
      _ = (2 * (a : ℝ)) ^ (θ * n + k) * Real.exp (2 * (β / 8) * n) := by rw [hgpow]
      _ ≤ Real.exp (β * n / 2) := h2
  -- Step 5: the points with a counted name and a small cell have mass at most `e^{−βn/2} = r^n`.
  let S : ℕ → Set X := fun n =>
    {x | nameOf T P n x ∈ W n ∧ μ.real (nameCell T P n (nameOf T P n x)) < Real.exp (-(β * n))}
  have hSm : ∀ n, MeasurableSet (S n) := fun n =>
    measurable_nameOf hTm hP n (show MeasurableSet
      {w : Fin n → Fin a | w ∈ W n ∧ μ.real (nameCell T P n w) < Real.exp (-(β * n))} from
        (Set.toFinite _).measurableSet)
  set r := Real.exp (-(β / 2)) with hrdef
  have hr0 : 0 ≤ r := (Real.exp_pos _).le
  have hr1 : r < 1 := Real.exp_lt_one_iff.mpr (by linarith)
  have hSn : ∀ n, N₁ ≤ n → μ.real (S n) ≤ r ^ n := by
    intro n hn
    have h1 := measureReal_lightCells_le μ hTm hP n (W n) (Real.exp_pos (-(β * n))).le
    calc μ.real (S n) ≤ (W n).card * Real.exp (-(β * n)) := h1
      _ ≤ Real.exp (β * n / 2) * Real.exp (-(β * n)) :=
          mul_le_mul_of_nonneg_right (hWcard n hn) (Real.exp_pos _).le
      _ = r ^ n := by
          rw [← Real.exp_add, hrdef, ← Real.exp_nat_mul]
          congr 1
          ring
  -- Step 6: a geometric tail, and the set.
  obtain ⟨N₂, hN₂⟩ := exists_geom_tail_le' hr0 hr1 (half_pos hη)
  set N₀ := max N₁ N₂ with hN₀def
  have hN₁₀ : N₁ ≤ N₀ := le_max_left _ _
  have hN₂₀ : N₂ ≤ N₀ := le_max_right _ _
  let U : Set X := ⋃ n : ℕ, S (n + N₀)
  have hUm : MeasurableSet U := MeasurableSet.iUnion fun n => hSm _
  have hU : μ U ≤ ENNReal.ofReal (η / 2) := by
    have hsum : Summable fun n : ℕ => r ^ (n + N₀) := by
      simp_rw [pow_add]
      exact (summable_geometric_of_lt_one hr0 hr1).mul_right _
    have htail : ∑' n : ℕ, r ^ (n + N₀) = r ^ N₀ / (1 - r) := by
      simp_rw [pow_add]
      rw [tsum_mul_right, tsum_geometric_of_lt_one hr0 hr1]
      ring
    calc μ U ≤ ∑' n, μ (S (n + N₀)) := measure_iUnion_le _
      _ ≤ ∑' n, ENNReal.ofReal (r ^ (n + N₀)) := ENNReal.tsum_le_tsum fun n => by
          rw [← ofReal_measureReal]
          exact ENNReal.ofReal_le_ofReal (hSn _ (by omega))
      _ = ENNReal.ofReal (∑' n, r ^ (n + N₀)) :=
          (ENNReal.ofReal_tsum_of_nonneg (fun n => pow_nonneg hr0 _) hsum).symm
      _ ≤ ENNReal.ofReal (η / 2) := by
          rw [htail]
          exact ENNReal.ofReal_le_ofReal (hN₂ N₀ hN₂₀)
  refine ⟨N₀, (E ∪ U)ᶜ, (hEm.union hUm).compl, ?_, ?_⟩
  · have h1 : μ (E ∪ U) ≤ ENNReal.ofReal η :=
      calc μ (E ∪ U) ≤ μ E + μ U := measure_union_le _ _
        _ ≤ ENNReal.ofReal θ + ENNReal.ofReal (η / 2) := add_le_add hE hU
        _ = ENNReal.ofReal (θ + η / 2) := (ENNReal.ofReal_add hθpos.le (by positivity)).symm
        _ ≤ ENNReal.ofReal η := ENNReal.ofReal_le_ofReal (by linarith)
    have h2 : μ.real (E ∪ U) ≤ η := ENNReal.toReal_le_of_le_ofReal hη.le h1
    rw [measureReal_compl (hEm.union hUm), probReal_univ]
    linarith
  · intro x hx n hn
    simp only [Set.mem_compl_iff, Set.mem_union, not_or] at hx
    obtain ⟨hxE, hxU⟩ := hx
    have hxS : x ∉ S n := by
      intro h
      apply hxU
      refine Set.mem_iUnion.mpr ⟨n - N₀, ?_⟩
      rwa [Nat.sub_add_cancel hn]
    by_contra hlt
    exact hxS ⟨hWmem x hxE n, not_le.mp hlt⟩

end HadwigerNelson.Rigidity
