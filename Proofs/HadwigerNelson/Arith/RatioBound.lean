import Mathlib.Analysis.Fourier.FiniteAbelian.PontryaginDuality
import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex

/-!
# The ratio bound for a Cayley graph on a finite abelian group, by characters (FS-131 wave 10, second planning pass)

**Read aloud, against the informal claim.** Hoffman's ratio bound, `α ≤ n·(−λ_min)/(d − λ_min)` for a `d`-regular graph on
`n` vertices, and its corollary `χ ≥ 1 + d/(−λ_min)` (`[Hoffman1970]`; the ratio bound itself is unpublished Hoffman,
`[Haemers2021]` §3). Stated **once, at the class its argument reads**: a finite abelian group `G`, *any* finite set `S ⊆ G`
(no symmetry is read, no regularity beyond the group's), and a real `m ≥ 0` with `Re Σ_{s ∈ S} ψ(s) ≥ −m` for every
non-trivial character `ψ : G → ℂ`. No adjacency matrix, no spectral theorem: for the indicator `f` of a set `I` with no
difference in `S`,

  `0 = #{(x, y) ∈ I² : y − x ∈ S}·n = Σ_ψ |f̂(ψ)|² λ_ψ ≥ |I|²·|S| − m·(n|I| − |I|²)`

by the orthogonality of characters (`AddChar.sum_apply_eq_ite`), with `λ_ψ = Σ_{s ∈ S} ψ(s)` and Parseval
`Σ_ψ |f̂(ψ)|² = n|I|`.

* `card_mul_le_of_indep`: `|I|·(|S| + m) ≤ m·|G|`.
* `le_chromaticNumber_of_charSum`: a graph on `G` in which every pair with difference in `S` is adjacent needs at least
  `N` colours as soon as `(N − 1)·m < |S| + m`.

Both finite-target floors of `Arith/StandingFive` (`χ(U₁₂₈) ≥ 7` and `χ(Γ_Q) ≥ 7`) are instances.

**Inhabitant.** `G = ZMod 2`, `S = {1}`, `m = 1`: the one non-trivial character has `ψ(1) = −1`; the bound reads
`|I|·2 ≤ 2` and `χ(K₂) ≥ 2` (the spec examples).
-/

namespace HadwigerNelson.RatioBound

open Finset

variable {G : Type*} [AddCommGroup G] [Fintype G] [DecidableEq G]

omit [DecidableEq G] in
/-- The triple sum behind both identities: `f̂(ψ)·conj f̂(ψ)·λ_ψ = Σ_{x,y ∈ I} Σ_{s ∈ S} ψ(x − y + s)`. -/
theorem fourier_sq_mul_charSum (I S : Finset G) (ψ : AddChar G ℂ) :
    (∑ x ∈ I, ψ x) * (starRingEnd ℂ) (∑ x ∈ I, ψ x) * ∑ s ∈ S, ψ s =
      ∑ x ∈ I, ∑ y ∈ I, ∑ s ∈ S, ψ (x - y + s) := by
  rw [map_sum, sum_mul_sum, sum_mul]
  refine sum_congr rfl fun x _ => ?_
  rw [sum_mul]
  refine sum_congr rfl fun y _ => ?_
  rw [mul_sum]
  refine sum_congr rfl fun s _ => ?_
  rw [← AddChar.map_neg_eq_conj, ← AddChar.map_add_eq_mul, ← AddChar.map_add_eq_mul, sub_eq_add_neg]

/-- With no difference of `I` in `S`, the weighted sum of the character sums of `S` vanishes. -/
theorem sum_fourier_sq_mul_charSum_eq_zero (S I : Finset G) (hI : ∀ x ∈ I, ∀ y ∈ I, x - y ∉ S) :
    ∑ ψ : AddChar G ℂ, (∑ x ∈ I, ψ x) * (starRingEnd ℂ) (∑ x ∈ I, ψ x) * ∑ s ∈ S, ψ s = 0 := by
  calc ∑ ψ : AddChar G ℂ, (∑ x ∈ I, ψ x) * (starRingEnd ℂ) (∑ x ∈ I, ψ x) * ∑ s ∈ S, ψ s
      = ∑ ψ : AddChar G ℂ, ∑ x ∈ I, ∑ y ∈ I, ∑ s ∈ S, ψ (x - y + s) :=
        sum_congr rfl fun ψ _ => fourier_sq_mul_charSum I S ψ
    _ = ∑ x ∈ I, ∑ y ∈ I, ∑ s ∈ S, ∑ ψ : AddChar G ℂ, ψ (x - y + s) := by
        rw [sum_comm]
        refine sum_congr rfl fun x _ => ?_
        rw [sum_comm]
        refine sum_congr rfl fun y _ => ?_
        rw [sum_comm]
    _ = 0 := by
        refine sum_eq_zero fun x hx => sum_eq_zero fun y hy => sum_eq_zero fun s hs => ?_
        rw [AddChar.sum_apply_eq_ite, if_neg]
        intro h
        have hs' : s = y - x := by rw [eq_neg_of_add_eq_zero_right h, neg_sub]
        exact hI y hy x hx (hs' ▸ hs)

/-- Parseval for an indicator: `Σ_ψ |f̂(ψ)|² = n·|I|`. -/
theorem sum_fourier_sq (I : Finset G) :
    ∑ ψ : AddChar G ℂ, (∑ x ∈ I, ψ x) * (starRingEnd ℂ) (∑ x ∈ I, ψ x) = (Fintype.card G : ℂ) * I.card := by
  have h1 : ∀ ψ : AddChar G ℂ, (∑ x ∈ I, ψ x) * (starRingEnd ℂ) (∑ x ∈ I, ψ x) = ∑ x ∈ I, ∑ y ∈ I, ψ (x - y) := by
    intro ψ
    rw [map_sum, sum_mul_sum]
    refine sum_congr rfl fun x _ => sum_congr rfl fun y _ => ?_
    rw [← AddChar.map_neg_eq_conj, ← AddChar.map_add_eq_mul, sub_eq_add_neg]
  calc ∑ ψ : AddChar G ℂ, (∑ x ∈ I, ψ x) * (starRingEnd ℂ) (∑ x ∈ I, ψ x)
      = ∑ ψ : AddChar G ℂ, ∑ x ∈ I, ∑ y ∈ I, ψ (x - y) := sum_congr rfl fun ψ _ => h1 ψ
    _ = ∑ x ∈ I, ∑ y ∈ I, ∑ ψ : AddChar G ℂ, ψ (x - y) := by
        rw [sum_comm]
        refine sum_congr rfl fun x _ => ?_
        rw [sum_comm]
    _ = ∑ x ∈ I, (Fintype.card G : ℂ) := by
        refine sum_congr rfl fun x hx => ?_
        simp only [AddChar.sum_apply_eq_ite, sub_eq_zero]
        rw [sum_ite_eq, if_pos hx]
    _ = (Fintype.card G : ℂ) * I.card := by rw [sum_const, nsmul_eq_mul, mul_comm]

/-- **The ratio bound, by characters.** If every non-trivial character sum of `S` has real part at least `−m`, a set `I`
with no difference in `S` has `|I|·(|S| + m) ≤ m·|G|`. -/
theorem card_mul_le_of_indep (S : Finset G) {m : ℝ} (hm : 0 ≤ m)
    (hS : ∀ ψ : AddChar G ℂ, ψ ≠ 1 → -m ≤ (∑ s ∈ S, ψ s).re) (I : Finset G)
    (hI : ∀ x ∈ I, ∀ y ∈ I, x - y ∉ S) :
    (I.card : ℝ) * (S.card + m) ≤ m * Fintype.card G := by
  -- the weights `N ψ = |f̂(ψ)|²` and the real parts `L ψ = Re λ_ψ`
  set N : AddChar G ℂ → ℝ := fun ψ => Complex.normSq (∑ x ∈ I, ψ x) with hN
  set L : AddChar G ℂ → ℝ := fun ψ => (∑ s ∈ S, ψ s).re with hL
  have hA : ∑ ψ : AddChar G ℂ, N ψ * L ψ = 0 := by
    have h := congrArg Complex.re (sum_fourier_sq_mul_charSum_eq_zero S I hI)
    rw [Complex.re_sum, Complex.zero_re] at h
    rw [← h]
    refine sum_congr rfl fun ψ _ => ?_
    rw [Complex.mul_conj, Complex.re_ofReal_mul]
  have hB : ∑ ψ : AddChar G ℂ, N ψ = Fintype.card G * I.card := by
    have h := congrArg Complex.re (sum_fourier_sq I)
    rw [Complex.re_sum] at h
    have h2 : ((Fintype.card G : ℂ) * (I.card : ℂ)).re = (Fintype.card G : ℝ) * I.card := by
      rw [← Nat.cast_mul, Complex.natCast_re, Nat.cast_mul]
    rw [h2] at h
    rw [← h]
    refine sum_congr rfl fun ψ _ => ?_
    rw [Complex.mul_conj, Complex.ofReal_re]
  -- the trivial character
  have hN1 : N 1 = (I.card : ℝ) * I.card := by
    simp only [hN, AddChar.one_apply, sum_const, nsmul_eq_mul, mul_one]
    exact Complex.normSq_natCast _
  have hL1 : L 1 = S.card := by
    simp only [hL, AddChar.one_apply, sum_const, nsmul_eq_mul, mul_one, Complex.natCast_re]
  have hsplitA := add_sum_erase (univ : Finset (AddChar G ℂ)) (fun ψ => N ψ * L ψ) (mem_univ 1)
  have hsplitB := add_sum_erase (univ : Finset (AddChar G ℂ)) N (mem_univ 1)
  have hNnn : ∀ ψ, 0 ≤ N ψ := fun ψ => Complex.normSq_nonneg _
  have hlow : -m * ∑ ψ ∈ (univ : Finset (AddChar G ℂ)).erase 1, N ψ ≤
      ∑ ψ ∈ (univ : Finset (AddChar G ℂ)).erase 1, N ψ * L ψ := by
    rw [mul_sum]
    refine sum_le_sum fun ψ hψ => ?_
    have := hS ψ (ne_of_mem_erase hψ)
    nlinarith [hNnn ψ]
  -- assemble: `c² d − m (n c − c²) ≤ 0`
  set c : ℝ := ((I.card : ℕ) : ℝ) with hc
  set d : ℝ := ((S.card : ℕ) : ℝ) with hd
  set n : ℝ := ((Fintype.card G : ℕ) : ℝ) with hn
  have hc0 : 0 ≤ c := Nat.cast_nonneg _
  have hn0 : 0 ≤ n := Nat.cast_nonneg _
  have key : c * c * d - m * (n * c - c * c) ≤ 0 := by
    have e1 : ∑ ψ ∈ (univ : Finset (AddChar G ℂ)).erase 1, N ψ = n * c - c * c := by linarith
    have e2 : ∑ ψ ∈ (univ : Finset (AddChar G ℂ)).erase 1, N ψ * L ψ = -(c * c * d) := by
      rw [hN1, hL1] at hsplitA
      linarith
    rw [e1, e2] at hlow
    linarith
  rcases eq_or_lt_of_le hc0 with h0 | hpos
  · rw [← h0]
    nlinarith
  · by_contra hlt
    push Not at hlt
    nlinarith [mul_pos hpos (sub_pos.mpr hlt)]

/-- **The chromatic corollary** (`χ ≥ 1 + d/m`, in a form with no division): a graph on `G` in which every two distinct
vertices with difference in `S` are adjacent, `0 ∉ S`, needs at least `N` colours when `(N − 1)·m < |S| + m`. -/
theorem le_chromaticNumber_of_charSum (S : Finset G) (h0 : (0 : G) ∉ S) (H : SimpleGraph G)
    (hH : ∀ x y, x ≠ y → x - y ∈ S → H.Adj x y) {m : ℝ} (hm : 0 < m)
    (hS : ∀ ψ : AddChar G ℂ, ψ ≠ 1 → -m ≤ (∑ s ∈ S, ψ s).re) (N : ℕ)
    (hN : ((N : ℝ) - 1) * m < S.card + m) : (N : ℕ∞) ≤ H.chromaticNumber := by
  rw [SimpleGraph.le_chromaticNumber_iff_colorable]
  intro k hk
  obtain ⟨C⟩ := hk
  by_contra hlt
  have hkN : (k : ℝ) ≤ (N : ℝ) - 1 := by
    have h1 : k < N := by exact_mod_cast not_le.mp hlt
    have h2 : k + 1 ≤ N := h1
    have h3 : ((k + 1 : ℕ) : ℝ) ≤ N := by exact_mod_cast h2
    push_cast at h3
    linarith
  -- each colour class has no difference in `S`
  have hclass : ∀ j : Fin k, ((univ.filter fun x => C x = j).card : ℝ) * (S.card + m) ≤ m * Fintype.card G := by
    intro j
    refine card_mul_le_of_indep S hm.le hS _ fun x hx y hy hxy => ?_
    by_cases hne : x = y
    · rw [hne, sub_self] at hxy
      exact h0 hxy
    · have hadj := hH x y hne hxy
      have hx' := (mem_filter.mp hx).2
      have hy' := (mem_filter.mp hy).2
      exact C.valid hadj (hx'.trans hy'.symm)
  have hsum : (Fintype.card G : ℝ) = ∑ j : Fin k, ((univ.filter fun x => C x = j).card : ℝ) := by
    have h := card_eq_sum_card_fiberwise (f := C) (s := (univ : Finset G)) (t := (univ : Finset (Fin k)))
      (fun x _ => mem_univ _)
    rw [card_univ] at h
    exact_mod_cast h
  have hn : (0 : ℝ) < Fintype.card G := by exact_mod_cast Fintype.card_pos
  have htot : (∑ j : Fin k, ((univ.filter fun x => C x = j).card : ℝ)) * (S.card + m) ≤
      k * (m * Fintype.card G) := by
    rw [sum_mul]
    calc ∑ j : Fin k, ((univ.filter fun x => C x = j).card : ℝ) * (S.card + m)
        ≤ ∑ _j : Fin k, m * Fintype.card G := sum_le_sum fun j _ => hclass j
      _ = k * (m * Fintype.card G) := by rw [sum_const, card_univ, Fintype.card_fin, nsmul_eq_mul]
  rw [← hsum] at htot
  have hfin : (S.card : ℝ) + m ≤ k * m := by
    by_contra hcon
    push Not at hcon
    nlinarith [mul_lt_mul_of_pos_left hcon hn]
  nlinarith

/-! ## Spec -/

-- `card_mul_le_of_indep` would drift if `m` and `|S|` were swapped: at `G = ZMod 2`, `S = {1}`, `m = 1` a set with no
-- difference in `S` has at most one point (`|I|·2 ≤ 2`).
example (hS : ∀ ψ : AddChar (ZMod 2) ℂ, ψ ≠ 1 → -(1 : ℝ) ≤ (∑ s ∈ ({1} : Finset (ZMod 2)), ψ s).re)
    (I : Finset (ZMod 2)) (hI : ∀ x ∈ I, ∀ y ∈ I, x - y ∉ ({1} : Finset (ZMod 2))) : (I.card : ℝ) * (1 + 1) ≤ 1 * 2 := by
  have h := card_mul_le_of_indep ({1} : Finset (ZMod 2)) zero_le_one hS I hI
  simpa using h

end HadwigerNelson.RatioBound
