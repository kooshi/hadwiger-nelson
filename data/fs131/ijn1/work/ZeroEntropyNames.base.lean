import Proofs.HadwigerNelson.Rigidity.Entropy
import Proofs.HadwigerNelson.Outside.OAI015Maximal
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecificLimits.Basic

/-!
# Names at entropy zero: few words with few bad starts, and no small name cells on a large set (FS-131, job FS131-KN7; proved by FS131-IN1L)

**Read aloud, against the derivation** (`plans/FS131-EN2-derivation.md` § 3.5, entries EN2-CNT and EN2-ZE; module M8a
of the chain, `data/fs131/kn3/claims-M8-zero-entropy-carried.md`).

* **EN2-CNT** (`card_words_badStarts_le`): over an alphabet `α` of `a ≥ 1` letters, with `k ≥ 1`, a set `𝒢` of words of
  length `k`, a real `g ≥ 2` with `#𝒢 ≤ g`, `θ ≥ 0` and `n ≥ k`, the words `w` of length `n` with at most `θ n` *bad starts*
  — positions `0 ≤ j ≤ n − k` whose block `w[j, j + k)` is not in `𝒢` (`badStarts`, over `wordBlock`) — number at most
  `(2a)^{θn + k} · g^{2n/k}`. Pure combinatorics; no measure.
* **EN2-ZE** (`exists_forall_exp_le_measureReal_nameCell`): for a probability measure `μ`, a map `T` preserving it, a
  measurable `P : X → Fin a` with `partitionEntropy μ T P = 0` (the infimum form, `inf_{n ≥ 1} H_n / n = 0`, the entry's
  hypothesis word for word), and `β, η > 0`, there are `N₀` and a measurable `X′` with `μ(X′) ≥ 1 − η` such that the cell
  of the name of every `x ∈ X′` through every time `n ≥ N₀` has mass at least `e^{−βn}`. No ergodicity, no limit theorem;
  its one classical input is the maximal ergodic inequality for an indicator (`measure_frequentVisits_le`).

**The name** of `x` through time `n` is `nameOf T P n x`; `nameCell T P n w` is its fibre over `w`
(`mem_nameCell_iff_nameOf`), and the block of a name at `j` is the name of `T^[j] x` (`wordBlock_nameOf`) — the identity
where the dynamics meets the count, the deriver's first place to attack (EN2 § 3.7).

**EN2-ZE's proof, in its children** (EN2 § 3.5 steps 1–6): (2) one block length `k` from `exists_blockEntropy_le_mul`
(`Rigidity/Entropy`, a leaf there), the heavy names of length `k` (`heavyNames`) few by `mul_card_heavyNames_le` and
Markov on the terms of `H_k` (`mul_measureReal_light_le_blockEntropy`); (3) the maximal inequality,
`measure_frequentVisits_le`; (4) off its exceptional set the bad starts of every name are visits to the light points
(`badStarts_nameOf_le_visits`) and EN2-CNT counts them, with the arithmetic in `rpow_mul_exp_le_exp`; (5) the light
cells of few names have small mass (`measureReal_lightCells_le`); (6) a geometric series.

**`measure_frequentVisits_le` is the release's `DukePrimeDegree.excessiveOccupation_measure_bound`**
(`[OAIMath2026]` family 015, `DukePrimeDegree/Dynamics/MaximalOccupation.lean`) with its two definitions unfolded
(`excessiveOccupation T A δ = {x | ∃ n, δ n < visitCount T A n x}`, `visitCount` = this module's `visits`). It is stated
here under a name of this library, and its proof is that theorem of the port (`Outside/OAI015Maximal`,
`Outside.OAI015.excessiveOccupation_measure_bound`), joined by FS131-IN1L with the statement not changed.

**Inhabitants.** `card_words_badStarts_le`: the entry's model (`a = 2`, `k = 3`, `𝒢 = {000}`, `g = 2`, `θ = 9/10`,
`n = 13`), its hypotheses checked in an `example`. EN2-ZE: `zeroEntropyNames_model`, the point mass on one point with the
identity and the one-label partition — degenerate; the entry's non-degenerate model is an irrational rotation with the
indicator of an arc, and its counter-model to the conclusion without the hypothesis is the fair-coin shift (both in
words only; neither is in the library).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory Filter

open scoped ENNReal

/-! ## Words, their blocks and their bad starts -/

section Words

variable {α : Type*}

/-- **The block of length `k` of the word `w` at position `j`**: `(w j, w (j + 1), …, w (j + k − 1))`, for `j + k ≤ n`. -/
def wordBlock {n : ℕ} (w : Fin n → α) (k j : ℕ) (h : j + k ≤ n) : Fin k → α :=
  fun i => w ⟨j + i, by omega⟩

/-- **A bad start of `w` for the good blocks `𝒢`**: a position `j` with `j + k ≤ n` whose block of length `k` is not in
`𝒢`. -/
def IsBadStart {n k : ℕ} (𝒢 : Finset (Fin k → α)) (w : Fin n → α) (j : ℕ) : Prop :=
  ∃ h : j + k ≤ n, wordBlock w k j h ∉ 𝒢

/-- Being a bad start is decidable when letters can be compared. -/
instance [DecidableEq α] {n k : ℕ} (𝒢 : Finset (Fin k → α)) (w : Fin n → α) :
    DecidablePred (IsBadStart 𝒢 w) := fun j => by
  unfold IsBadStart
  infer_instance

/-- **The number of bad starts of `w`**: the positions `0 ≤ j ≤ n − k` whose block of length `k` is not in `𝒢`. -/
def badStarts [DecidableEq α] {n k : ℕ} (𝒢 : Finset (Fin k → α)) (w : Fin n → α) : ℕ :=
  ((Finset.range (n + 1)).filter (IsBadStart 𝒢 w)).card

-- Spec: with `𝒢 = {000}` the word `00001` has one bad start (at `j = 2`; the blocks at `0` and `1` are `000`).
#guard badStarts ({![0, 0, 0]} : Finset (Fin 3 → Fin 2)) (![0, 0, 0, 0, 1] : Fin 5 → Fin 2) = 1
-- Spec: a word shorter than the block has no start at all.
#guard badStarts (∅ : Finset (Fin 3 → Fin 2)) (![1, 1] : Fin 2 → Fin 2) = 0
-- Spec: with no good block every start is bad: `n − k + 1` of them.
#guard badStarts (∅ : Finset (Fin 2 → Fin 2)) (![0, 1, 0, 1] : Fin 4 → Fin 2) = 3

section CountProof

/-! The proof of EN2-CNT (`plans/FS131-KN7-chain-next.md` § 5.4, N1): the greedy parse on lists, (A) the weighted
count, (B) its singles against the bad starts. -/

/-- The block of length `k` at position `j` of a list. -/
private def listBlock (l : List α) (k j : ℕ) (h : j + k ≤ l.length) : Fin k → α :=
  fun i => l[j + i]'(by omega)

/-- The bad starts of a list: the positions `j ≤ length − k` whose block is not in `𝒢`. -/
private def badSetL [DecidableEq α] {k : ℕ} (𝒢 : Finset (Fin k → α)) (l : List α) : Finset ℕ :=
  (Finset.range (l.length + 1)).filter fun j => ∃ h : j + k ≤ l.length, listBlock l k j h ∉ 𝒢

/-- **The greedy parse's singles**: read a good block at the head and skip it, or read one letter as a single. -/
private def singles [DecidableEq α] {k : ℕ} (𝒢 : Finset (Fin k → α)) : List α → ℕ
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

private theorem singles_nil : singles 𝒢 [] = 0 := by
  rw [singles]

private theorem singles_of_good {l : List α} (hk : 1 ≤ k) (h : ∃ hk : 0 + k ≤ l.length, listBlock l k 0 hk ∈ 𝒢) :
    singles 𝒢 l = singles 𝒢 (l.drop k) := by
  cases l with
  | nil =>
    obtain ⟨hk', _⟩ := h
    simp at hk'
    omega
  | cons x l => rw [singles, dif_pos ⟨hk, h⟩]

private theorem singles_cons_of_not_good {x : α} {l : List α}
    (h : ¬ (1 ≤ k ∧ ∃ hk : 0 + k ≤ (x :: l).length, listBlock (x :: l) k 0 hk ∈ 𝒢)) :
    singles 𝒢 (x :: l) = 1 + singles 𝒢 l := by
  rw [singles, dif_neg h]

private theorem singles_le_length (l : List α) : singles 𝒢 l ≤ l.length := by
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
private theorem image_badSetL_drop_subset (hk : 1 ≤ k) (s : ℕ) (l : List α) :
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

private theorem card_badSetL_drop_le (hk : 1 ≤ k) (s : ℕ) (l : List α) :
    (badSetL 𝒢 (l.drop s)).card ≤ (badSetL 𝒢 l).card := by
  rw [← Finset.card_image_of_injective _ (add_left_injective s)]
  exact Finset.card_le_card (image_badSetL_drop_subset 𝒢 hk s l)

private theorem card_badSetL_cons (hk : 1 ≤ k) {x : α} {l : List α} (hlen : k ≤ (x :: l).length)
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
private theorem singles_le_card_badSetL (hk : 1 ≤ k) (l : List α) : singles 𝒢 l ≤ (badSetL 𝒢 l).card + (k - 1) := by
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
private theorem card_badSetL_ofFn_le {n : ℕ} (w : Fin n → α) :
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
private def GoodL (l : List α) : Prop :=
  1 ≤ k ∧ ∃ hk : 0 + k ≤ l.length, listBlock l k 0 hk ∈ 𝒢

/-- **The weighted count of the words of length `m`**: `∑_w t^{singles w}`. -/
private noncomputable def weightSum [Fintype α] (t : ℝ) (m : ℕ) : ℝ :=
  ∑ w : Fin m → α, t ^ singles 𝒢 (List.ofFn w)

/-- The words whose head block is good, weighted. -/
private noncomputable def goodSum [Fintype α] (t : ℝ) (m : ℕ) : ℝ := by
  classical
  exact ∑ w : Fin m → α, if GoodL 𝒢 (List.ofFn w) then t ^ singles 𝒢 (List.ofFn w) else 0

/-- The words whose head block is not good, weighted. -/
private noncomputable def badSum [Fintype α] (t : ℝ) (m : ℕ) : ℝ := by
  classical
  exact ∑ w : Fin m → α, if GoodL 𝒢 (List.ofFn w) then 0 else t ^ singles 𝒢 (List.ofFn w)

private theorem weightSum_eq_add [Fintype α] (t : ℝ) (m : ℕ) : weightSum 𝒢 t m = goodSum 𝒢 t m + badSum 𝒢 t m := by
  classical
  simp only [weightSum, goodSum, badSum, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun w _ => ?_
  split_ifs <;> simp

private theorem goodSum_eq_zero_of_lt [Fintype α] (t : ℝ) {m : ℕ} (hm : m < k) : goodSum 𝒢 t m = 0 := by
  classical
  simp only [goodSum]
  refine Finset.sum_eq_zero fun w _ => ?_
  rw [if_neg]
  rintro ⟨-, hk, -⟩
  simp at hk
  omega

omit [DecidableEq α] in
/-- The block at the head of `u ++ v` with `u` of length `k` is `u`. -/
private theorem listBlock_ofFn_append {r : ℕ} (u : Fin k → α) (v : Fin r → α) (h : 0 + k ≤ (List.ofFn u ++ List.ofFn v).length) :
    listBlock (List.ofFn u ++ List.ofFn v) k 0 h = u := by
  funext i
  simp only [listBlock]
  rw [List.getElem_append_left (by simp)]
  simp

private theorem goodSum_le [Fintype α] {t : ℝ} (hk : 1 ≤ k) (r : ℕ) :
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

private theorem badSum_le [Fintype α] {t : ℝ} (ht : 0 ≤ t) (r : ℕ) :
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
private theorem weightSum_le [Fintype α] {t ρ : ℝ} (ht : 0 ≤ t) (hat : Fintype.card α * t ≤ 1 / 2) (hρ : 1 ≤ ρ)
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

end CountProof

/-- **EN2-CNT, the count** (`plans/FS131-EN2-derivation.md` § 3.5, the entry at l. 458; [hand], one mind, checked by
enumeration on 228 cases): over an alphabet of `a ≥ 1` letters, with `k ≥ 1`, a set `𝒢` of words of length `k`, a real
`g ≥ 2` with `#𝒢 ≤ g`, `θ ≥ 0` and `n ≥ k`, at most `(2a)^{θn + k} · g^{2n/k}` words of length `n` have at most `θ n` bad
starts. -/
theorem card_words_badStarts_le [Fintype α] [DecidableEq α] [Nonempty α] {k : ℕ} (hk : 1 ≤ k)
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
      -- casts by `Nat.cast_le` and `rw`, no `simp`-based tactic over `badStarts`: one such tactic (the `linarith`
      -- this replaced) made Lean generate `badStarts.congr_simp` in this module, a public constant.
      have : ((singles 𝒢 (List.ofFn w) : ℕ) : ℝ) ≤ ((badStarts 𝒢 w + k : ℕ) : ℝ) := Nat.cast_le.mpr hs
      rw [Nat.cast_add] at this
      exact this.trans (add_le_add hb le_rfl)
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

/-- **A model of the hypotheses of `card_words_badStarts_le`**: the entry's (`a = 2`, `k = 3`, `𝒢 = {000}`, `g = 2`,
`θ = 9/10`, `n = 13`). -/
example : 1 ≤ 3 ∧ (2 : ℝ) ≤ 2 ∧ ((({![0, 0, 0]} : Finset (Fin 3 → Fin 2)).card : ℝ) ≤ 2) ∧ (0 : ℝ) ≤ 9 / 10 ∧ 3 ≤ 13 := by
  refine ⟨by norm_num, le_rfl, ?_, by norm_num, by norm_num⟩
  rw [Finset.card_singleton]
  norm_num

end Words

/-! ## Names along an orbit -/

section Names

variable {X : Type*}

/-- **The name of `x` through time `n`**: its labels along the orbit, `(P x, P (T x), …, P (T^[n − 1] x))`. The cells
`nameCell T P n w` are the fibres of this map. -/
def nameOf {a : ℕ} (T : X → X) (P : X → Fin a) (n : ℕ) (x : X) : Fin n → Fin a :=
  fun j => P (T^[j] x)

@[simp] theorem nameOf_apply {a : ℕ} (T : X → X) (P : X → Fin a) (n : ℕ) (x : X) (j : Fin n) :
    nameOf T P n x j = P (T^[j] x) := rfl

/-- The cell of a word is the fibre of the name over it. -/
theorem mem_nameCell_iff_nameOf {a : ℕ} {T : X → X} {P : X → Fin a} {n : ℕ} {w : Fin n → Fin a} {x : X} :
    x ∈ nameCell T P n w ↔ nameOf T P n x = w := by
  rw [mem_nameCell, funext_iff]
  rfl

/-- Every point lies in the cell of its own name. -/
theorem mem_nameCell_nameOf {a : ℕ} (T : X → X) (P : X → Fin a) (n : ℕ) (x : X) :
    x ∈ nameCell T P n (nameOf T P n x) :=
  mem_nameCell_iff_nameOf.mpr rfl

/-- The name is measurable when the map and the labels are. -/
theorem measurable_nameOf {m : MeasurableSpace X} {a : ℕ} {T : X → X} (hT : Measurable T) {P : X → Fin a}
    (hP : Measurable P) (n : ℕ) : Measurable (nameOf T P n) :=
  measurable_pi_lambda _ fun j => hP.comp (hT.iterate j)

/-- **The block of a name at `j` is the name of `T^[j] x`** — where the orbit meets the count (EN2 § 3.5 step 4). -/
theorem wordBlock_nameOf {a : ℕ} (T : X → X) (P : X → Fin a) {n k j : ℕ} (h : j + k ≤ n) (x : X) :
    wordBlock (nameOf T P n x) k j h = nameOf T P k (T^[j] x) := by
  funext i
  simp only [wordBlock, nameOf_apply]
  rw [add_comm, Function.iterate_add_apply]

/-- **The heavy names of length `n`**: the words whose cell has mass at least `c`. -/
noncomputable def heavyNames {m : MeasurableSpace X} (μ : Measure X) {a : ℕ} (T : X → X) (P : X → Fin a) (n : ℕ)
    (c : ℝ) : Finset (Fin n → Fin a) := by
  classical
  exact Finset.univ.filter fun w => c ≤ μ.real (nameCell T P n w)

theorem mem_heavyNames {m : MeasurableSpace X} {μ : Measure X} {a : ℕ} {T : X → X} {P : X → Fin a} {n : ℕ} {c : ℝ}
    {w : Fin n → Fin a} : w ∈ heavyNames μ T P n c ↔ c ≤ μ.real (nameCell T P n w) := by
  classical
  simp [heavyNames]

/-- The cell of a word is the preimage of the word under the name. -/
private theorem nameCell_eq_preimage {a : ℕ} (T : X → X) (P : X → Fin a) (n : ℕ) (w : Fin n → Fin a) :
    nameCell T P n w = nameOf T P n ⁻¹' {w} := by
  ext x
  exact mem_nameCell_iff_nameOf

/-- The points whose name lies in a set `W` of words have the mass of `W`'s cells together. -/
private theorem measureReal_nameOf_preimage {m : MeasurableSpace X} (μ : Measure X) [IsFiniteMeasure μ] {T : X → X}
    (hT : Measurable T) {a : ℕ} {P : X → Fin a} (hP : Measurable P) (n : ℕ) (W : Finset (Fin n → Fin a)) :
    μ.real (nameOf T P n ⁻¹' ↑W) = ∑ w ∈ W, μ.real (nameCell T P n w) := by
  rw [← sum_measureReal_preimage_singleton W fun w _ => measurable_nameOf hT hP n (measurableSet_singleton w)]
  simp only [nameCell_eq_preimage]

/-- The cells of the names of length `n` have total mass `1`. -/
private theorem sum_measureReal_nameCell {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ]
    {T : X → X} (hT : Measurable T) {a : ℕ} {P : X → Fin a} (hP : Measurable P) (n : ℕ) :
    ∑ w, μ.real (nameCell T P n w) = 1 := by
  rw [← measureReal_nameOf_preimage μ hT hP n Finset.univ, Finset.coe_univ, Set.preimage_univ, probReal_univ]

/-- **Few heavy names** (EN2 § 3.5 step 2, `#𝒢 ≤ e^{γk}`): the cells are disjoint and measurable, so at most `1/c` of them
have mass `≥ c`. -/
theorem mul_card_heavyNames_le {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ] {T : X → X}
    (hT : Measurable T) {a : ℕ} {P : X → Fin a} (hP : Measurable P) (n : ℕ) {c : ℝ} (hc : 0 < c) :
    c * (heavyNames μ T P n c).card ≤ 1 := by
  -- `0 < c` is not read: for `c ≤ 0` the bound is immediate, and the proof below covers every `c`.
  have _ := hc
  calc c * (heavyNames μ T P n c).card = ∑ _w ∈ heavyNames μ T P n c, c := by
        rw [Finset.sum_const, nsmul_eq_mul, mul_comm]
    _ ≤ ∑ w ∈ heavyNames μ T P n c, μ.real (nameCell T P n w) :=
        Finset.sum_le_sum fun w hw => mem_heavyNames.mp hw
    _ ≤ ∑ w, μ.real (nameCell T P n w) :=
        Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _) fun _ _ _ => measureReal_nonneg
    _ = 1 := sum_measureReal_nameCell μ hT hP n

/-- A mass below `e^{−s}` has its entropy term at least `s` times itself: `log p < −s`. -/
private theorem mul_le_negMulLog_of_lt_exp {p s : ℝ} (hp : 0 ≤ p) (hps : p < Real.exp (-s)) :
    s * p ≤ Real.negMulLog p := by
  rcases hp.eq_or_lt with rfl | hp
  · simp
  have h1 : Real.log p < -s := by
    rw [← Real.log_exp (-s)]
    exact Real.log_lt_log hp hps
  rw [Real.negMulLog]
  nlinarith

/-- **Markov on the terms of `H_n`** (EN2 § 3.5 step 2, `H_k ≥ γk · μ(B)`): the points whose name's cell is lighter than
`e^{−γn}` have mass at most `H_n / (γ n)`. Each light cell's term `−p log p` is at least `γ n · p`, and every term is
non-negative. -/
theorem mul_measureReal_light_le_blockEntropy {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ]
    {T : X → X} (hT : Measurable T) {a : ℕ} {P : X → Fin a} (hP : Measurable P) (n : ℕ) {γ : ℝ} (hγ : 0 ≤ γ) :
    γ * n * μ.real {x | nameOf T P n x ∉ heavyNames μ T P n (Real.exp (-(γ * n)))} ≤ blockEntropy μ T P n := by
  classical
  -- `0 ≤ γ` is not read: the Markov step holds for every `γ`.
  have _ := hγ
  set S := heavyNames μ T P n (Real.exp (-(γ * n)))
  have hset : {x | nameOf T P n x ∉ S} = nameOf T P n ⁻¹' ↑(Sᶜ) := by
    ext x
    simp
  rw [hset, measureReal_nameOf_preimage μ hT hP n, Finset.mul_sum, blockEntropy]
  calc ∑ w ∈ Sᶜ, γ * n * μ.real (nameCell T P n w) ≤ ∑ w ∈ Sᶜ, Real.negMulLog (μ.real (nameCell T P n w)) := by
        refine Finset.sum_le_sum fun w hw => mul_le_negMulLog_of_lt_exp measureReal_nonneg ?_
        have hw' : w ∉ S := Finset.mem_compl.mp hw
        rw [mem_heavyNames] at hw'
        exact not_le.mp hw'
    _ ≤ ∑ w, Real.negMulLog (μ.real (nameCell T P n w)) :=
        Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _) fun _ _ _ =>
          Real.negMulLog_nonneg measureReal_nonneg measureReal_le_one

/-- **The visits of the orbit of `x` to `B` before time `n`**: the number of `0 ≤ j < n` with `T^[j] x ∈ B` (the
release's `visitCount`, `PrimePackets/InverseEntropy.lean` l. 247, with the same decidability instance). -/
noncomputable def visits (T : X → X) (B : Set X) (n : ℕ) (x : X) : ℕ := by
  classical
  exact ((Finset.range n).filter fun j => T^[j] x ∈ B).card

/-- **The maximal ergodic inequality for an indicator** (Hopf; EN2 § 3.5 step 3, `θ μ(E) ≤ μ(B)`): the points whose orbit
visits `B` more than `θ n` times before some time `n` have mass at most `μ(B)/θ`. **The release's
`DukePrimeDegree.excessiveOccupation_measure_bound`** with its definitions unfolded, stated under this library's name;
its proof is the port's `Outside.OAI015.excessiveOccupation_measure_bound` (module docstring). -/
theorem measure_frequentVisits_le {m : MeasurableSpace X} (μ : Measure X) [IsFiniteMeasure μ] {T : X → X}
    (hT : MeasurePreserving T μ μ) {B : Set X} (hB : MeasurableSet B) {θ : ℝ} (hθ : 0 < θ) :
    ENNReal.ofReal θ * μ {x | ∃ n : ℕ, θ * n < (visits T B n x : ℝ)} ≤ μ B :=
  Outside.OAI015.excessiveOccupation_measure_bound μ hT hB hθ

/-- **The bad starts of a name are visits to the light points** (EN2 § 3.5 step 4): with the heavy names of length
`k ≥ 1` as the good blocks, a bad start `j` of the name of `x` is a time `j < n` at which `T^[j] x` has a light name of
length `k` (`wordBlock_nameOf`). -/
theorem badStarts_nameOf_le_visits {m : MeasurableSpace X} (μ : Measure X) {T : X → X} {a : ℕ} {P : X → Fin a}
    {k : ℕ} (hk : 1 ≤ k) (c : ℝ) (n : ℕ) (x : X) :
    badStarts (heavyNames μ T P k c) (nameOf T P n x) ≤
      visits T {y | nameOf T P k y ∉ heavyNames μ T P k c} n x := by
  unfold badStarts visits
  rw [Finset.filter_congr_decidable (Finset.range n)]
  refine Finset.card_le_card fun j hj => ?_
  obtain ⟨hjr, hjk, hbad⟩ := Finset.mem_filter.mp hj
  have hjn : j < n := by omega
  refine Finset.mem_filter.mpr ⟨Finset.mem_range.mpr hjn, ?_⟩
  rw [wordBlock_nameOf] at hbad
  exact hbad

/-- **The arithmetic of step 4** (EN2 § 3.5): with `γ = β/8` and `θ log(2a) ≤ β/8`, once `k ≤ θ n` the count's bound
`(2a)^{θn + k} · e^{2γn}` is at most `e^{βn/2}`. A real-variable lemma (`LEAN.md`: one inequality, its own hypotheses). -/
theorem rpow_mul_exp_le_exp {a β θ n k : ℝ} (ha : 1 ≤ a) (hθ : 0 ≤ θ) (hθβ : θ * Real.log (2 * a) ≤ β / 8)
    (hn : 0 ≤ n) (hkn : k ≤ θ * n) :
    (2 * a) ^ (θ * n + k) * Real.exp (2 * (β / 8) * n) ≤ Real.exp (β * n / 2) := by
  -- `0 ≤ θ` is not read: `k ≤ θ n` and `0 ≤ n` carry what the exponent needs.
  have _ := hθ
  have h2a : 1 < 2 * a := by linarith
  rw [Real.rpow_def_of_pos (by linarith), ← Real.exp_add, Real.exp_le_exp]
  have hlog : 0 < Real.log (2 * a) := Real.log_pos h2a
  have h1 : 0 ≤ Real.log (2 * a) * (θ * n - k) := mul_nonneg hlog.le (by linarith)
  have h2 : 0 ≤ n * (β / 8 - θ * Real.log (2 * a)) := mul_nonneg hn (by linarith)
  linarith only [h1, h2]

/-- **The light cells of few names are light in total** (EN2 § 3.5 step 5): the points whose name lies in `W` and whose
cell has mass below `c ≥ 0` have mass at most `#W · c`. -/
theorem measureReal_lightCells_le {m : MeasurableSpace X} (μ : Measure X) [IsFiniteMeasure μ] {T : X → X}
    (hT : Measurable T) {a : ℕ} {P : X → Fin a} (hP : Measurable P) (n : ℕ) (W : Finset (Fin n → Fin a)) {c : ℝ}
    (hc : 0 ≤ c) :
    μ.real {x | nameOf T P n x ∈ W ∧ μ.real (nameCell T P n (nameOf T P n x)) < c} ≤ W.card * c := by
  classical
  set W' := W.filter fun w => μ.real (nameCell T P n w) < c
  have hset : {x | nameOf T P n x ∈ W ∧ μ.real (nameCell T P n (nameOf T P n x)) < c} = nameOf T P n ⁻¹' ↑W' := by
    ext x
    simp [W']
  rw [hset, measureReal_nameOf_preimage μ hT hP n]
  calc ∑ w ∈ W', μ.real (nameCell T P n w) ≤ ∑ _w ∈ W', c :=
        Finset.sum_le_sum fun w hw => (Finset.mem_filter.mp hw).2.le
    _ = W'.card * c := by rw [Finset.sum_const, nsmul_eq_mul]
    _ ≤ W.card * c := by
        gcongr
        exact Finset.filter_subset _ W

/-- The tail of a geometric series: for `0 ≤ r < 1` and `η > 0` some `N` has `r^{N'}/(1 − r) ≤ η` for every `N' ≥ N`. -/
private theorem exists_geom_tail_le {r η : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) (hη : 0 < η) :
    ∃ N : ℕ, ∀ N' : ℕ, N ≤ N' → r ^ N' / (1 - r) ≤ η := by
  have h1 : 0 < 1 - r := by linarith
  have ht := tendsto_pow_atTop_nhds_zero_of_lt_one hr0 hr1
  obtain ⟨N, hN⟩ := (ht.eventually (gt_mem_nhds (mul_pos hη h1))).exists_forall_of_atTop
  refine ⟨N, fun N' hN' => ?_⟩
  rw [div_le_iff₀ h1]
  exact (hN N' hN').le

/-- **EN2-ZE, entropy zero puts no small name cell on a large set** (`plans/FS131-EN2-derivation.md` § 3.5, the entry at
l. 506; [hand], one mind): for a probability measure that `T` preserves and a measurable partition `P` with
`partitionEntropy μ T P = 0` (`inf_{n ≥ 1} H_n / n = 0`), for every `β > 0` and `η > 0` there are `N₀` and a measurable
`X′` with `μ(X′) ≥ 1 − η` such that the cell of the name of each `x ∈ X′` through each time `n ≥ N₀` has mass at least
`e^{−βn}`. In place of Shannon–McMillan–Breiman for Lemma 3.1′ (EN2-L31). -/
theorem exists_forall_exp_le_measureReal_nameCell {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ]
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
    refine Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_⟩
    have h1 : (visits T B n x : ℝ) ≤ θ * n := by
      by_contra h
      exact hx ⟨n, not_le.mp h⟩
    exact le_trans (Nat.cast_le.mpr (badStarts_nameOf_le_visits μ hk1 (Real.exp (-(β / 8 * k))) n x)) h1
  set N₁ := max k ⌈(k : ℝ) / θ⌉₊ with hN₁def
  have hWcard : ∀ n, N₁ ≤ n → ((W n).card : ℝ) ≤ Real.exp (β * n / 2) := by
    intro n hn
    have hkn : k ≤ n := le_trans (le_max_left _ _) hn
    have hkθ : (k : ℝ) ≤ θ * n := by
      have h1 : (k : ℝ) / θ ≤ n := (Nat.le_ceil _).trans (by exact_mod_cast le_trans (le_max_right _ _) hn)
      rw [div_le_iff₀ hθpos] at h1
      linarith
    have h1 := card_words_badStarts_le hk1 𝒢 hg2 h𝒢g hθpos.le hkn
    rw [Fintype.card_fin] at h1
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
  obtain ⟨N₂, hN₂⟩ := exists_geom_tail_le hr0 hr1 (half_pos hη)
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

/-- **A model of the hypotheses of `exists_forall_exp_le_measureReal_nameCell`**: the point mass on one point, the
identity, the one-label partition — every cell is the whole space, every `H_n` is `0`. Degenerate (one atom); the entry's
model with infinitely many names is an irrational rotation, not in the library. -/
theorem zeroEntropyNames_model :
    IsProbabilityMeasure (Measure.dirac ()) ∧ MeasurePreserving (id : Unit → Unit) (Measure.dirac ()) (Measure.dirac ()) ∧
      Measurable (fun _ : Unit => (0 : Fin 1)) ∧
      partitionEntropy (Measure.dirac ()) (id : Unit → Unit) (fun _ : Unit => (0 : Fin 1)) = 0 := by
  refine ⟨inferInstance, MeasurePreserving.id _, measurable_const, ?_⟩
  have hcell : ∀ (n : ℕ) (w : Fin n → Fin 1),
      nameCell (id : Unit → Unit) (fun _ : Unit => (0 : Fin 1)) n w = Set.univ :=
    fun n w => Set.eq_univ_of_forall fun _ j => Subsingleton.elim _ _
  simp [partitionEntropy, blockEntropy, hcell]

end Names

end HadwigerNelson.Rigidity
