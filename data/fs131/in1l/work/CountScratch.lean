import Proofs.HadwigerNelson.Rigidity.ZeroEntropyNames

namespace HadwigerNelson.Rigidity

section CountScratch

variable {α : Type*}

/-- The block of length `k` at position `j` of a list. -/
def listBlock (l : List α) (k j : ℕ) (h : j + k ≤ l.length) : Fin k → α :=
  fun i => l[j + i]'(by omega)

/-- The bad starts of a list: the positions `j ≤ length − k` whose block is not in `𝒢`. -/
def badSetL [DecidableEq α] {k : ℕ} (𝒢 : Finset (Fin k → α)) (l : List α) : Finset ℕ :=
  (Finset.range (l.length + 1)).filter fun j => ∃ h : j + k ≤ l.length, listBlock l k j h ∉ 𝒢

/-- **The greedy parse's singles**: read a good block at the head and skip it, or read one letter as a single. -/
def singles [DecidableEq α] {k : ℕ} (𝒢 : Finset (Fin k → α)) : List α → ℕ
  | [] => 0
  | x :: l =>
    if h : 1 ≤ k ∧ ∃ hk : 0 + k ≤ (x :: l).length, listBlock (x :: l) k 0 hk ∈ 𝒢 then
      singles 𝒢 ((x :: l).drop k)
    else 1 + singles 𝒢 l
termination_by l => l.length
decreasing_by
  all_goals simp_wf
  all_goals omega

variable [DecidableEq α] {k : ℕ} (𝒢 : Finset (Fin k → α))

theorem singles_nil : singles 𝒢 [] = 0 := by
  rw [singles]

theorem singles_of_good {l : List α} (hk : 1 ≤ k) (h : ∃ hk : 0 + k ≤ l.length, listBlock l k 0 hk ∈ 𝒢) :
    singles 𝒢 l = singles 𝒢 (l.drop k) := by
  cases l with
  | nil =>
    obtain ⟨hk', _⟩ := h
    simp at hk'
    omega
  | cons x l => rw [singles, dif_pos ⟨hk, h⟩]

theorem singles_cons_of_not_good {x : α} {l : List α}
    (h : ¬ (1 ≤ k ∧ ∃ hk : 0 + k ≤ (x :: l).length, listBlock (x :: l) k 0 hk ∈ 𝒢)) :
    singles 𝒢 (x :: l) = 1 + singles 𝒢 l := by
  rw [singles, dif_neg h]

theorem singles_le_length (l : List α) : singles 𝒢 l ≤ l.length := by
  induction l using singles.induct (𝒢 := 𝒢) with
  | case1 => simp [singles_nil]
  | case2 x l h ih =>
    rw [singles_of_good 𝒢 h.1 h.2]
    exact ih.trans (by simp)
  | case3 x l h ih =>
    rw [singles_cons_of_not_good 𝒢 h]
    simp only [List.length_cons]
    omega

/-- A bad start of `l.drop s` at `j` is a bad start of `l` at `j + s`. -/
theorem image_badSetL_drop_subset (hk : 1 ≤ k) (s : ℕ) (l : List α) :
    (badSetL 𝒢 (l.drop s)).image (· + s) ⊆ badSetL 𝒢 l := by
  rw [Finset.image_subset_iff]
  intro j hj
  simp only [badSetL, Finset.mem_filter, Finset.mem_range, List.length_drop] at hj ⊢
  obtain ⟨-, h, hb⟩ := hj
  refine ⟨by omega, by omega, fun hm => hb ?_⟩
  convert hm using 1
  funext i
  simp only [listBlock, List.getElem_drop]
  congr 1
  omega

theorem card_badSetL_drop_le (hk : 1 ≤ k) (s : ℕ) (l : List α) :
    (badSetL 𝒢 (l.drop s)).card ≤ (badSetL 𝒢 l).card := by
  rw [← Finset.card_image_of_injective _ (add_left_injective s)]
  exact Finset.card_le_card (image_badSetL_drop_subset 𝒢 hk s l)

theorem card_badSetL_cons (hk : 1 ≤ k) {x : α} {l : List α} (hlen : k ≤ (x :: l).length)
    (hb : ∀ hk : 0 + k ≤ (x :: l).length, listBlock (x :: l) k 0 hk ∉ 𝒢) :
    1 + (badSetL 𝒢 l).card ≤ (badSetL 𝒢 (x :: l)).card := by
  have h0 : 0 ∈ badSetL 𝒢 (x :: l) := by
    simp only [badSetL, Finset.mem_filter, Finset.mem_range]
    exact ⟨by omega, by omega, hb _⟩
  have hsub : insert 0 ((badSetL 𝒢 l).image (· + 1)) ⊆ badSetL 𝒢 (x :: l) := by
    refine Finset.insert_subset h0 ?_
    have := image_badSetL_drop_subset 𝒢 hk 1 (x :: l)
    simpa using this
  have hnot : (0 : ℕ) ∉ (badSetL 𝒢 l).image (· + 1) := by simp
  have := Finset.card_le_card hsub
  rw [Finset.card_insert_of_notMem hnot, Finset.card_image_of_injective _ (add_left_injective 1)] at this
  omega

/-- **(B)**: the singles of the parse are at most the bad starts plus `k − 1`. -/
theorem singles_le_card_badSetL (hk : 1 ≤ k) (l : List α) : singles 𝒢 l ≤ (badSetL 𝒢 l).card + (k - 1) := by
  induction l using singles.induct (𝒢 := 𝒢) with
  | case1 => simp [singles_nil]
  | case2 x l h ih =>
    rw [singles_of_good 𝒢 h.1 h.2]
    exact ih.trans (Nat.add_le_add_right (card_badSetL_drop_le 𝒢 hk k _) _)
  | case3 x l h ih =>
    rw [singles_cons_of_not_good 𝒢 h]
    by_cases hlen : k ≤ (x :: l).length
    · have hb : ∀ hk' : 0 + k ≤ (x :: l).length, listBlock (x :: l) k 0 hk' ∉ 𝒢 :=
        fun hk' hm => h ⟨hk, hk', hm⟩
      have := card_badSetL_cons 𝒢 hk hlen hb
      omega
    · have := singles_le_length 𝒢 l
      simp only [List.length_cons] at hlen
      omega

/-- The bad starts of a word, read on its list, are its bad starts. -/
theorem card_badSetL_ofFn_le {n : ℕ} (w : Fin n → α) :
    (badSetL 𝒢 (List.ofFn w)).card ≤ badStarts 𝒢 w := by
  unfold badStarts
  refine Finset.card_le_card fun j hj => ?_
  simp only [badSetL, Finset.mem_filter, Finset.mem_range, List.length_ofFn] at hj
  obtain ⟨hj, h, hb⟩ := hj
  refine Finset.mem_filter.mpr ⟨Finset.mem_range.mpr hj, h, fun hm => hb ?_⟩
  convert hm using 1
  funext i
  simp [listBlock, wordBlock]

/-- The good-head condition of the parse, on a list. -/
def GoodL (l : List α) : Prop :=
  1 ≤ k ∧ ∃ hk : 0 + k ≤ l.length, listBlock l k 0 hk ∈ 𝒢

/-- **The weighted count of the words of length `m`**: `∑_w t^{singles w}`. -/
noncomputable def weightSum [Fintype α] (t : ℝ) (m : ℕ) : ℝ :=
  ∑ w : Fin m → α, t ^ singles 𝒢 (List.ofFn w)

/-- The words whose head block is good, weighted. -/
noncomputable def goodSum [Fintype α] (t : ℝ) (m : ℕ) : ℝ := by
  classical
  exact ∑ w : Fin m → α, if GoodL 𝒢 (List.ofFn w) then t ^ singles 𝒢 (List.ofFn w) else 0

/-- The words whose head block is not good, weighted. -/
noncomputable def badSum [Fintype α] (t : ℝ) (m : ℕ) : ℝ := by
  classical
  exact ∑ w : Fin m → α, if GoodL 𝒢 (List.ofFn w) then 0 else t ^ singles 𝒢 (List.ofFn w)

theorem weightSum_eq_add [Fintype α] (t : ℝ) (m : ℕ) : weightSum 𝒢 t m = goodSum 𝒢 t m + badSum 𝒢 t m := by
  classical
  simp only [weightSum, goodSum, badSum, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun w _ => ?_
  split_ifs <;> simp

theorem goodSum_eq_zero_of_lt [Fintype α] (t : ℝ) {m : ℕ} (hm : m < k) : goodSum 𝒢 t m = 0 := by
  classical
  simp only [goodSum]
  refine Finset.sum_eq_zero fun w _ => ?_
  rw [if_neg]
  rintro ⟨-, hk, -⟩
  simp at hk
  omega

omit [DecidableEq α] in
/-- The block at the head of `u ++ v` with `u` of length `k` is `u`. -/
theorem listBlock_ofFn_append {r : ℕ} (u : Fin k → α) (v : Fin r → α) (h : 0 + k ≤ (List.ofFn u ++ List.ofFn v).length) :
    listBlock (List.ofFn u ++ List.ofFn v) k 0 h = u := by
  funext i
  simp only [listBlock]
  rw [List.getElem_append_left (by simp)]
  simp

theorem goodSum_le [Fintype α] {t : ℝ} (hk : 1 ≤ k) (r : ℕ) :
    goodSum 𝒢 t (k + r) ≤ 𝒢.card * weightSum 𝒢 t r := by
  classical
  simp only [goodSum, weightSum]
  rw [← (Fin.appendEquiv k r).sum_comp, Fintype.sum_prod_type]
  simp only [Fin.appendEquiv, Equiv.coe_fn_mk, List.ofFn_fin_append]
  have hgood : ∀ (u : Fin k → α) (v : Fin r → α), GoodL 𝒢 (List.ofFn u ++ List.ofFn v) ↔ u ∈ 𝒢 := by
    intro u v
    simp only [GoodL]
    constructor
    · rintro ⟨-, h, hm⟩
      rwa [listBlock_ofFn_append] at hm
    · intro hu
      refine ⟨hk, by simp, ?_⟩
      rwa [listBlock_ofFn_append]
  have hsing : ∀ (u : Fin k → α) (v : Fin r → α), u ∈ 𝒢 →
      singles 𝒢 (List.ofFn u ++ List.ofFn v) = singles 𝒢 (List.ofFn v) := by
    intro u v hu
    rw [singles_of_good 𝒢 hk ⟨by simp, by rwa [listBlock_ofFn_append]⟩]
    congr 1
    rw [List.drop_append_of_le_length (by simp), List.drop_of_length_le (by simp), List.nil_append]
  calc ∑ u : Fin k → α, ∑ v : Fin r → α,
        (if GoodL 𝒢 (List.ofFn u ++ List.ofFn v) then t ^ singles 𝒢 (List.ofFn u ++ List.ofFn v) else 0)
      = ∑ u : Fin k → α, if u ∈ 𝒢 then ∑ v : Fin r → α, t ^ singles 𝒢 (List.ofFn v) else 0 := by
        refine Finset.sum_congr rfl fun u _ => ?_
        by_cases hu : u ∈ 𝒢
        · rw [if_pos hu]
          refine Finset.sum_congr rfl fun v _ => ?_
          rw [if_pos ((hgood u v).mpr hu), hsing u v hu]
        · rw [if_neg hu]
          exact Finset.sum_eq_zero fun v _ => by rw [if_neg (fun h => hu ((hgood u v).mp h))]
    _ = 𝒢.card * ∑ v : Fin r → α, t ^ singles 𝒢 (List.ofFn v) := by
        rw [← Finset.sum_filter, Finset.sum_const, nsmul_eq_mul]
        congr 2
        simp
    _ ≤ 𝒢.card * ∑ v : Fin r → α, t ^ singles 𝒢 (List.ofFn v) := le_rfl

theorem badSum_le [Fintype α] {t : ℝ} (ht : 0 ≤ t) (r : ℕ) :
    badSum 𝒢 t (r + 1) ≤ Fintype.card α * t * weightSum 𝒢 t r := by
  classical
  simp only [badSum, weightSum]
  have hterm : ∀ w : Fin (r + 1) → α,
      (if GoodL 𝒢 (List.ofFn w) then 0 else t ^ singles 𝒢 (List.ofFn w)) ≤
        t * t ^ singles 𝒢 (List.ofFn fun i => w i.succ) := by
    intro w
    split_ifs with h
    · positivity
    · rw [List.ofFn_succ] at h ⊢
      rw [singles_cons_of_not_good 𝒢 h, pow_add, pow_one, mul_comm]
  calc ∑ w : Fin (r + 1) → α, (if GoodL 𝒢 (List.ofFn w) then 0 else t ^ singles 𝒢 (List.ofFn w))
      ≤ ∑ w : Fin (r + 1) → α, t * t ^ singles 𝒢 (List.ofFn fun i => w i.succ) :=
        Finset.sum_le_sum fun w _ => hterm w
    _ = ∑ p : α × (Fin r → α), t * t ^ singles 𝒢 (List.ofFn p.2) := by
        rw [← (Fin.consEquiv fun _ => α).sum_comp]
        rfl
    _ = ∑ _x : α, ∑ v : Fin r → α, t * t ^ singles 𝒢 (List.ofFn v) := Fintype.sum_prod_type _
    _ = Fintype.card α * t * ∑ v : Fin r → α, t ^ singles 𝒢 (List.ofFn v) := by
        rw [Finset.sum_const, Finset.card_univ, nsmul_eq_mul, ← Finset.mul_sum, mul_assoc]

/-- **(A), the weighted count**: with `|α| t ≤ 1/2`, `ρ ≥ 1` and `2 #𝒢 ≤ ρ^k`, every `∑_w t^{singles w}` over the words
of length `m` is at most `ρ^m`. -/
theorem weightSum_le [Fintype α] {t ρ : ℝ} (ht : 0 ≤ t) (hat : Fintype.card α * t ≤ 1 / 2) (hρ : 1 ≤ ρ)
    (hG : 2 * (𝒢.card : ℝ) ≤ ρ ^ k) (hk : 1 ≤ k) (m : ℕ) : weightSum 𝒢 t m ≤ ρ ^ m := by
  induction m using Nat.strong_induction_on with
  | _ m ih =>
    rcases m with _ | r
    · simp [weightSum, singles_nil]
    · rw [weightSum_eq_add]
      have hbad : badSum 𝒢 t (r + 1) ≤ 1 / 2 * ρ ^ (r + 1) := by
        calc badSum 𝒢 t (r + 1) ≤ Fintype.card α * t * weightSum 𝒢 t r := badSum_le 𝒢 ht r
          _ ≤ 1 / 2 * ρ ^ r := by
              have h1 := ih r (Nat.lt_succ_self r)
              have h0 : 0 ≤ weightSum 𝒢 t r := Finset.sum_nonneg fun _ _ => pow_nonneg ht _
              have hc : 0 ≤ (Fintype.card α : ℝ) * t := by positivity
              calc (Fintype.card α : ℝ) * t * weightSum 𝒢 t r ≤ 1 / 2 * weightSum 𝒢 t r :=
                    mul_le_mul_of_nonneg_right hat h0
                _ ≤ 1 / 2 * ρ ^ r := by linarith
          _ ≤ 1 / 2 * ρ ^ (r + 1) := by
              have : ρ ^ r ≤ ρ ^ (r + 1) := pow_le_pow_right₀ hρ (Nat.le_succ r)
              linarith
      have hgood : goodSum 𝒢 t (r + 1) ≤ 1 / 2 * ρ ^ (r + 1) := by
        by_cases hkr : k ≤ r + 1
        · obtain ⟨r', hr'⟩ := Nat.exists_eq_add_of_le hkr
          rw [hr']
          have h1 := ih r' (by omega)
          have h0 : 0 ≤ (𝒢.card : ℝ) := Nat.cast_nonneg _
          have hρ0 : 0 ≤ ρ ^ r' := pow_nonneg (by linarith) _
          calc goodSum 𝒢 t (k + r') ≤ 𝒢.card * weightSum 𝒢 t r' := goodSum_le 𝒢 hk r'
            _ ≤ 𝒢.card * ρ ^ r' := mul_le_mul_of_nonneg_left h1 h0
            _ ≤ 1 / 2 * ρ ^ (k + r') := by
                rw [pow_add]
                have := mul_le_mul_of_nonneg_right hG hρ0
                linarith
        · rw [goodSum_eq_zero_of_lt 𝒢 t (by omega)]
          positivity
      linarith

omit [DecidableEq α] in
theorem card_words_badStarts_le' [Fintype α] [DecidableEq α] [Nonempty α] {k : ℕ} (hk : 1 ≤ k)
    (𝒢 : Finset (Fin k → α)) {g : ℝ} (hg : 2 ≤ g) (h𝒢 : (𝒢.card : ℝ) ≤ g) {θ : ℝ} (hθ : 0 ≤ θ) {n : ℕ}
    (hn : k ≤ n) :
    (((Finset.univ : Finset (Fin n → α)).filter fun w => (badStarts 𝒢 w : ℝ) ≤ θ * n).card : ℝ) ≤
      (2 * (Fintype.card α : ℝ)) ^ (θ * n + k) * g ^ (2 * n / k : ℝ) := by
  have _ := hθ
  have _ := hn
  have ha : (1 : ℝ) ≤ Fintype.card α := by exact_mod_cast Fintype.card_pos
  have h2a : (0 : ℝ) < 2 * Fintype.card α := by linarith
  set t : ℝ := (2 * (Fintype.card α : ℝ))⁻¹ with ht_def
  have ht0 : 0 < t := inv_pos.mpr h2a
  have ht1 : t ≤ 1 := inv_le_one_of_one_le₀ (by linarith)
  have hat : (Fintype.card α : ℝ) * t ≤ 1 / 2 := by
    rw [ht_def, mul_inv, ← mul_assoc, mul_comm (Fintype.card α : ℝ), mul_assoc,
      mul_inv_cancel₀ (by linarith), mul_one]
    norm_num
  have hk0 : (k : ℝ) ≠ 0 := by
    have : (1 : ℝ) ≤ k := by exact_mod_cast hk
    linarith
  set ρ : ℝ := g ^ (2 / k : ℝ) with hρ_def
  have hρ : 1 ≤ ρ := Real.one_le_rpow (by linarith) (by positivity)
  have hρk : ρ ^ k = g ^ 2 := by
    rw [hρ_def, ← Real.rpow_natCast, ← Real.rpow_mul (by linarith), div_mul_cancel₀ _ hk0]
    norm_num
  have hG : 2 * (𝒢.card : ℝ) ≤ ρ ^ k := by
    rw [hρk]
    nlinarith
  have hW := weightSum_le 𝒢 ht0.le hat hρ hG hk n
  set W := (Finset.univ : Finset (Fin n → α)).filter fun w => (badStarts 𝒢 w : ℝ) ≤ θ * n
  have hx : ∀ w ∈ W, t ^ (θ * n + k) ≤ t ^ singles 𝒢 (List.ofFn w) := by
    intro w hw
    have hb : (badStarts 𝒢 w : ℝ) ≤ θ * n := (Finset.mem_filter.mp hw).2
    have hs : singles 𝒢 (List.ofFn w) ≤ badStarts 𝒢 w + k :=
      ((singles_le_card_badSetL 𝒢 hk _).trans (Nat.add_le_add_right (card_badSetL_ofFn_le 𝒢 w) _)).trans
        (by omega)
    have hs' : (singles 𝒢 (List.ofFn w) : ℝ) ≤ θ * n + k := by
      have : (singles 𝒢 (List.ofFn w) : ℝ) ≤ badStarts 𝒢 w + k := by exact_mod_cast hs
      linarith
    rw [← Real.rpow_natCast]
    exact Real.rpow_le_rpow_of_exponent_ge ht0 ht1 hs'
  have hsum : (W.card : ℝ) * t ^ (θ * n + k) ≤ ρ ^ n := by
    calc (W.card : ℝ) * t ^ (θ * n + k) = ∑ _w ∈ W, t ^ (θ * n + k) := by
          rw [Finset.sum_const, nsmul_eq_mul]
      _ ≤ ∑ w ∈ W, t ^ singles 𝒢 (List.ofFn w) := Finset.sum_le_sum hx
      _ ≤ ∑ w, t ^ singles 𝒢 (List.ofFn w) :=
          Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _) fun _ _ _ => by positivity
      _ = weightSum 𝒢 t n := rfl
      _ ≤ ρ ^ n := hW
  have htx : t ^ (θ * n + k) = ((2 * (Fintype.card α : ℝ)) ^ (θ * n + k))⁻¹ := Real.inv_rpow h2a.le _
  have hpos : 0 < (2 * (Fintype.card α : ℝ)) ^ (θ * n + k) := Real.rpow_pos_of_pos h2a _
  have hρn : ρ ^ n = g ^ (2 * n / k : ℝ) := by
    rw [hρ_def, ← Real.rpow_natCast, ← Real.rpow_mul (by linarith)]
    congr 1
    ring
  rw [htx, ← div_eq_mul_inv, div_le_iff₀ hpos, hρn] at hsum
  linarith [mul_comm (g ^ (2 * n / k : ℝ)) ((2 * (Fintype.card α : ℝ)) ^ (θ * n + k))]

end CountScratch

end HadwigerNelson.Rigidity
