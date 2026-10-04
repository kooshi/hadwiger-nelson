import Proofs.HadwigerNelson.Topology.SpernerGrid
import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.Complex.ReImTopology
import Mathlib.Topology.MetricSpace.Pseudo.Lemmas

/-!
# Lebesgue's covering theorem for the square (two dimensions, three sets)

**Lebesgue's covering theorem** (Hurewicz–Wallman, *Dimension Theory*, Princeton 1948, Ch. IV § 3,
Thm IV 2, p. 42): if an `n`-cube is the union of finitely many closed sets none of which contains points
of two opposite faces, then some `n + 1` of them have a common point. This module proves the case
`n = 2`, for any closed rectangle `[a, b] × [c, d]` of `ℂ` (`lebesgue_covering_rect`), and restates it
over the square `closedSquare c s` exactly as FS-131 wave 4 states it (`lebesgue_covering_square`).
Job FS131-LEB; the plan is `plans/FS131-LEB-kernel-plan.md`.

The route, in three steps.
1. **Grouping** (Hurewicz–Wallman's own first step, p. 43): `L₀` is the union of the sets meeting the
   left side, `L₁` the union of the other sets meeting the bottom side, `L₂` the union of the rest. Each
   original set lies in exactly one group, so a common point of the three groups lies in three sets with
   distinct indices (`lebesgue_covering_rect` from `exists_mem_inter_three`).
2. **The three-set form** (`exists_mem_inter_three`, a cubical KKM lemma): closed `G 0, G 1, G 2`
   covering the rectangle, with the left side inside `G 0`, the right side outside `G 0`, the bottom
   side inside `G 0 ∪ G 1` and the top side outside `G 1`, have a common point in the rectangle.
3. **Sperner and compactness**, in place of Hurewicz–Wallman's appeal to Brouwer's fixed-point theorem:
   were there no common point, the Lebesgue number lemma gives `δ > 0` such that every `δ`-ball about a
   point of the rectangle misses one of the three sets; label the vertices of a grid finer than `δ` by
   the least `k` whose set contains them; the boundary conditions are Sperner's
   (`HadwigerNelson.SpernerGrid.exists_rainbowCell`), so some grid triangle carries all three labels,
   and its three vertices lie in one `δ`-ball, which meets all three sets.
-/

namespace HadwigerNelson.LebesgueCovering

open Set Metric Complex HadwigerNelson.SpernerGrid

/-! ## Labelling a point by the least set containing it -/

open Classical in
/-- The least `k : Fin 3` with `z ∈ G k` (and `2` when `z` lies in none of the three sets). -/
noncomputable def leastLabel {α : Type*} (G : Fin 3 → Set α) (z : α) : Fin 3 :=
  if z ∈ G 0 then 0 else if z ∈ G 1 then 1 else 2

/-- A point of `⋃ k, G k` lies in the set its least label names. -/
theorem mem_leastLabel {α : Type*} {G : Fin 3 → Set α} {z : α} (hz : z ∈ ⋃ k, G k) :
    z ∈ G (leastLabel G z) := by
  obtain ⟨k, hk⟩ := mem_iUnion.1 hz
  unfold leastLabel
  split_ifs with h0 h1
  · exact h0
  · exact h1
  · fin_cases k
    · exact absurd hk h0
    · exact absurd hk h1
    · exact hk

/-- A point of `G 0` is labelled `0`. -/
theorem leastLabel_eq_zero {α : Type*} {G : Fin 3 → Set α} {z : α} (hz : z ∈ G 0) :
    leastLabel G z = 0 := by
  simp [leastLabel, hz]

/-- A point outside `G 0` is not labelled `0`. -/
theorem leastLabel_ne_zero {α : Type*} {G : Fin 3 → Set α} {z : α} (hz : z ∉ G 0) :
    leastLabel G z ≠ 0 := by
  unfold leastLabel
  split_ifs with h0 h1
  · exact absurd h0 hz
  · decide
  · decide

/-- A point of `G 0 ∪ G 1` is not labelled `2`. -/
theorem leastLabel_ne_two {α : Type*} {G : Fin 3 → Set α} {z : α} (hz : z ∈ G 0 ∪ G 1) :
    leastLabel G z ≠ 2 := by
  unfold leastLabel
  rcases hz with h | h
  · simp [h]
  · by_cases h0 : z ∈ G 0 <;> simp [h0, h]

/-- A point outside `G 1` is not labelled `1`. -/
theorem leastLabel_ne_one {α : Type*} {G : Fin 3 → Set α} {z : α} (hz : z ∉ G 1) :
    leastLabel G z ≠ 1 := by
  unfold leastLabel
  -- `split_ifs` discharges the test `z ∈ G 1` by `hz` itself
  split_ifs <;> decide

/-! ## The grid -/

/-- The grid point `(a + i (b - a) / N, c + j (d - c) / N)` of the rectangle `[a, b] × [c, d]`. -/
noncomputable def gridPt (a b c d : ℝ) (N i j : ℕ) : ℂ :=
  ⟨a + i * ((b - a) / N), c + j * ((d - c) / N)⟩

/-- Grid points with indices at most `N` lie in the rectangle. -/
theorem gridPt_mem {a b c d : ℝ} (hab : a ≤ b) (hcd : c ≤ d) {N i j : ℕ} (hN : 0 < N) (hi : i ≤ N)
    (hj : j ≤ N) : gridPt a b c d N i j ∈ Icc a b ×ℂ Icc c d := by
  have hN' : (0 : ℝ) < N := Nat.cast_pos.2 hN
  have hi' : (i : ℝ) ≤ N := Nat.cast_le.2 hi
  have hj' : (j : ℝ) ≤ N := Nat.cast_le.2 hj
  have h1 : 0 ≤ (b - a) / N := div_nonneg (sub_nonneg.2 hab) hN'.le
  have h2 : 0 ≤ (d - c) / N := div_nonneg (sub_nonneg.2 hcd) hN'.le
  have h3 : (N : ℝ) * ((b - a) / N) = b - a := by field_simp
  have h4 : (N : ℝ) * ((d - c) / N) = d - c := by field_simp
  have h5 : (i : ℝ) * ((b - a) / N) ≤ N * ((b - a) / N) := mul_le_mul_of_nonneg_right hi' h1
  have h6 : (j : ℝ) * ((d - c) / N) ≤ N * ((d - c) / N) := mul_le_mul_of_nonneg_right hj' h2
  have h7 : 0 ≤ (i : ℝ) * ((b - a) / N) := mul_nonneg (Nat.cast_nonneg i) h1
  have h8 : 0 ≤ (j : ℝ) * ((d - c) / N) := mul_nonneg (Nat.cast_nonneg j) h2
  refine mem_reProdIm.2 ⟨⟨?_, ?_⟩, ⟨?_, ?_⟩⟩ <;> simp only [gridPt] <;> linarith

/-- The left column of the grid lies on the left side. -/
theorem gridPt_re_zero (a b c d : ℝ) (N j : ℕ) : (gridPt a b c d N 0 j).re = a := by
  simp [gridPt]

/-- The right column of the grid lies on the right side. -/
theorem gridPt_re_self (a b c d : ℝ) {N : ℕ} (hN : 0 < N) (j : ℕ) : (gridPt a b c d N N j).re = b := by
  have hN' : (N : ℝ) ≠ 0 := (Nat.cast_pos.2 hN).ne'
  simp only [gridPt]
  field_simp
  ring

/-- The bottom row of the grid lies on the bottom side. -/
theorem gridPt_im_zero (a b c d : ℝ) (N i : ℕ) : (gridPt a b c d N i 0).im = c := by
  simp [gridPt]

/-- The top row of the grid lies on the top side. -/
theorem gridPt_im_self (a b c d : ℝ) {N : ℕ} (hN : 0 < N) (i : ℕ) : (gridPt a b c d N i N).im = d := by
  have hN' : (N : ℝ) ≠ 0 := (Nat.cast_pos.2 hN).ne'
  simp only [gridPt]
  field_simp
  ring

/-- Each corner of grid cell `(i, j)` is within `(b - a) / N + (d - c) / N` of the corner `(i, j)`. -/
theorem dist_gridPt_le {a b c d : ℝ} (hab : a ≤ b) (hcd : c ≤ d) (N i j : ℕ) {p q : ℕ} (hp : p ≤ 1)
    (hq : q ≤ 1) : dist (gridPt a b c d N i j) (gridPt a b c d N (i + p) (j + q)) ≤ (b - a) / N + (d - c) / N := by
  have h1 : 0 ≤ (b - a) / N := div_nonneg (sub_nonneg.2 hab) (Nat.cast_nonneg N)
  have h2 : 0 ≤ (d - c) / N := div_nonneg (sub_nonneg.2 hcd) (Nat.cast_nonneg N)
  have hp' : (p : ℝ) ≤ 1 := by exact_mod_cast hp
  have hq' : (q : ℝ) ≤ 1 := by exact_mod_cast hq
  have hx : (gridPt a b c d N i j - gridPt a b c d N (i + p) (j + q)).re = -(p * ((b - a) / N)) := by
    simp only [gridPt, sub_re]; push_cast; ring
  have hy : (gridPt a b c d N i j - gridPt a b c d N (i + p) (j + q)).im = -(q * ((d - c) / N)) := by
    simp only [gridPt, sub_im]; push_cast; ring
  rw [Complex.dist_eq]
  refine (norm_le_abs_re_add_abs_im _).trans ?_
  rw [hx, hy, abs_neg, abs_neg, abs_of_nonneg (mul_nonneg (Nat.cast_nonneg p) h1),
    abs_of_nonneg (mul_nonneg (Nat.cast_nonneg q) h2)]
  exact add_le_add (mul_le_of_le_one_left h1 hp') (mul_le_of_le_one_left h2 hq')

/-! ## The three-set form -/

/-- **Lebesgue's covering theorem, three-set (cubical KKM) form, for a rectangle.** Closed sets
`G 0, G 1, G 2` covering `[a, b] × [c, d]`, such that the left side lies in `G 0`, the right side misses
`G 0`, the bottom side lies in `G 0 ∪ G 1` and the top side misses `G 1`, have a common point in the
rectangle. -/
theorem exists_mem_inter_three {a b c d : ℝ} (hab : a < b) (hcd : c < d) (G : Fin 3 → Set ℂ)
    (hG : ∀ k, IsClosed (G k)) (hcov : Icc a b ×ℂ Icc c d ⊆ ⋃ k, G k)
    (hleft : ∀ z ∈ Icc a b ×ℂ Icc c d, z.re = a → z ∈ G 0)
    (hright : ∀ z ∈ Icc a b ×ℂ Icc c d, z.re = b → z ∉ G 0)
    (hbot : ∀ z ∈ Icc a b ×ℂ Icc c d, z.im = c → z ∈ G 0 ∪ G 1)
    (htop : ∀ z ∈ Icc a b ×ℂ Icc c d, z.im = d → z ∉ G 1) :
    ∃ z ∈ Icc a b ×ℂ Icc c d, ∀ k, z ∈ G k := by
  by_contra hno
  push Not at hno
  -- were there no common point, a Lebesgue number `δ`: every `δ`-ball about a point of the rectangle misses a set
  have hcov' : Icc a b ×ℂ Icc c d ⊆ ⋃ k, (G k)ᶜ := fun z hz => by
    obtain ⟨k, hk⟩ := hno z hz
    exact mem_iUnion.2 ⟨k, hk⟩
  obtain ⟨δ, hδ, hball⟩ := lebesgue_number_lemma_of_metric (isCompact_Icc.reProdIm isCompact_Icc)
    (fun k => (hG k).isOpen_compl) hcov'
  -- a grid finer than `δ`
  obtain ⟨N, hN⟩ := exists_nat_gt ((b - a + (d - c)) / δ)
  have hNpos : 0 < N := by
    have h0 : (0 : ℝ) < (b - a + (d - c)) / δ := div_pos (by linarith) hδ
    exact_mod_cast h0.trans hN
  have hmesh : (b - a) / N + (d - c) / N < δ := by
    have hN' : (0 : ℝ) < N := Nat.cast_pos.2 hNpos
    rw [div_lt_iff₀ hδ] at hN
    rw [← add_div, div_lt_iff₀ hN']
    linarith
  have hmem : ∀ i j, i ≤ N → j ≤ N → gridPt a b c d N i j ∈ Icc a b ×ℂ Icc c d :=
    fun i j hi hj => gridPt_mem hab.le hcd.le hNpos hi hj
  -- label the grid by the least set containing each vertex: the boundary conditions are Sperner's
  obtain ⟨i, hi, j, hj, hcell⟩ := exists_rainbowCell N (fun i j => leastLabel G (gridPt a b c d N i j))
    (fun j hj => leastLabel_eq_zero (hleft _ (hmem 0 j (Nat.zero_le _) hj) (gridPt_re_zero a b c d N j)))
    (fun j hj => leastLabel_ne_zero (hright _ (hmem N j le_rfl hj) (gridPt_re_self a b c d hNpos j)))
    (fun i hi => leastLabel_ne_two (hbot _ (hmem i 0 hi (Nat.zero_le _)) (gridPt_im_zero a b c d N i)))
    (fun i hi => leastLabel_ne_one (htop _ (hmem i N hi le_rfl) (gridPt_im_self a b c d hNpos i)))
  -- the corners of the rainbow cell lie in one `δ`-ball, which misses some `G k`
  obtain ⟨k, hk⟩ := hball _ (hmem i j hi.le hj.le)
  have hnear : ∀ p q, p ≤ 1 → q ≤ 1 →
      gridPt a b c d N (i + p) (j + q) ∈ ball (gridPt a b c d N i j) δ ∧
        gridPt a b c d N (i + p) (j + q) ∈ G (leastLabel G (gridPt a b c d N (i + p) (j + q))) :=
    fun p q hp hq =>
      ⟨mem_ball.2 (by rw [dist_comm]; exact (dist_gridPt_le hab.le hcd.le N i j hp hq).trans_lt hmesh),
        mem_leastLabel (hcov (hmem _ _ (by omega) (by omega)))⟩
  have hcontra : ∀ p₁ q₁ p₂ q₂ p₃ q₃, p₁ ≤ 1 → q₁ ≤ 1 → p₂ ≤ 1 → q₂ ≤ 1 → p₃ ≤ 1 → q₃ ≤ 1 →
      ¬ Rainbow (leastLabel G (gridPt a b c d N (i + p₁) (j + q₁)))
        (leastLabel G (gridPt a b c d N (i + p₂) (j + q₂)))
        (leastLabel G (gridPt a b c d N (i + p₃) (j + q₃))) := by
    intro p₁ q₁ p₂ q₂ p₃ q₃ h₁ h₁' h₂ h₂' h₃ h₃' hr
    rcases hr.exhaust k with h | h | h
    · obtain ⟨hb, hm⟩ := hnear p₁ q₁ h₁ h₁'
      exact hk hb (h ▸ hm)
    · obtain ⟨hb, hm⟩ := hnear p₂ q₂ h₂ h₂'
      exact hk hb (h ▸ hm)
    · obtain ⟨hb, hm⟩ := hnear p₃ q₃ h₃ h₃'
      exact hk hb (h ▸ hm)
  rcases hcell with h | h
  · exact hcontra 0 0 1 0 1 1 (by omega) (by omega) le_rfl (by omega) le_rfl le_rfl h
  · exact hcontra 0 0 0 1 1 1 (by omega) (by omega) (by omega) le_rfl le_rfl le_rfl h

/-! ## Lebesgue's covering theorem -/

/-- **Lebesgue's covering theorem for a rectangle, the form its proof reads** (`n = 2`): if the closed
rectangle `[a, b] × [c, d]` is covered by finitely many closed sets, none of which meets both vertical
sides, and none of which **misses the left side** while meeting both horizontal sides, some point of the
rectangle lies in three of them. A set meeting the left side may run from the bottom to the top: the
grouping puts it with the left side's sets, and only the other sets' horizontal sides are read. This is
strictly wider than `lebesgue_covering_rect`, whose hypotheses force at least four sets (the four
corners lie in four distinct sets), while here three can do (a left strip from bottom to top and two
squares on the right). -/
theorem lebesgue_covering_rect' {ι : Type*} [Finite ι] {a b c d : ℝ} (hab : a < b) (hcd : c < d)
    (F : ι → Set ℂ) (hF : ∀ i, IsClosed (F i)) (hcov : Icc a b ×ℂ Icc c d ⊆ ⋃ i, F i)
    (hLR : ∀ i, ¬ ((∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.re = a) ∧ ∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.re = b))
    (hBT : ∀ i, ¬ (∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.re = a) →
      ¬ ((∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.im = c) ∧ ∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.im = d)) :
    ∃ z ∈ Icc a b ×ℂ Icc c d, ∃ i j l : ι, i ≠ j ∧ i ≠ l ∧ j ≠ l ∧ z ∈ F i ∧ z ∈ F j ∧ z ∈ F l := by
  classical
  -- Hurewicz–Wallman's grouping: `0` for the sets meeting the left side, `1` for the other sets meeting
  -- the bottom side, `2` for the rest
  let g : ι → Fin 3 := fun i =>
    if ∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.re = a then 0
    else if ∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.im = c then 1 else 2
  have hg0 : ∀ i, g i = 0 ↔ ∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.re = a := by
    intro i
    simp only [g]
    split_ifs with h1 h2 <;> simp_all
  have hg1 : ∀ i, g i = 1 → ∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.im = c := by
    intro i
    simp only [g]
    split_ifs with h1 h2 <;> simp_all
  let G : Fin 3 → Set ℂ := fun k => ⋃ i ∈ {i | g i = k}, F i
  have hmemG : ∀ {z : ℂ} {k : Fin 3}, z ∈ G k ↔ ∃ i, g i = k ∧ z ∈ F i := by
    intro z k
    simp [G]
  have hGc : ∀ k, IsClosed (G k) := fun k => (Set.toFinite _).isClosed_biUnion fun i _ => hF i
  obtain ⟨z, hz, hall⟩ := exists_mem_inter_three hab hcd G hGc
    (fun z hz => by
      obtain ⟨i, hi⟩ := mem_iUnion.1 (hcov hz)
      exact mem_iUnion.2 ⟨g i, hmemG.2 ⟨i, rfl, hi⟩⟩)
    (fun z hz hre => by
      obtain ⟨i, hi⟩ := mem_iUnion.1 (hcov hz)
      exact hmemG.2 ⟨i, (hg0 i).2 ⟨z, ⟨hi, hz⟩, hre⟩, hi⟩)
    (fun z hz hre hz0 => by
      obtain ⟨i, hi, hzi⟩ := hmemG.1 hz0
      exact hLR i ⟨(hg0 i).1 hi, z, ⟨hzi, hz⟩, hre⟩)
    (fun z hz him => by
      obtain ⟨i, hi⟩ := mem_iUnion.1 (hcov hz)
      by_cases hl : ∃ w ∈ F i ∩ Icc a b ×ℂ Icc c d, w.re = a
      · exact Or.inl (hmemG.2 ⟨i, (hg0 i).2 hl, hi⟩)
      · refine Or.inr (hmemG.2 ⟨i, ?_, hi⟩)
        simp only [g]
        rw [if_neg hl, if_pos ⟨z, ⟨hi, hz⟩, him⟩])
    (fun z hz him hz1 => by
      obtain ⟨i, hi, hzi⟩ := hmemG.1 hz1
      refine hBT i (fun hl => ?_) ⟨hg1 i hi, z, ⟨hzi, hz⟩, him⟩
      have h0 := (hg0 i).2 hl
      rw [hi] at h0
      exact absurd h0 (by decide))
  obtain ⟨i₀, hi₀, hz₀⟩ := hmemG.1 (hall 0)
  obtain ⟨i₁, hi₁, hz₁⟩ := hmemG.1 (hall 1)
  obtain ⟨i₂, hi₂, hz₂⟩ := hmemG.1 (hall 2)
  refine ⟨z, hz, i₀, i₁, i₂, ?_, ?_, ?_, hz₀, hz₁, hz₂⟩
  · rintro rfl; rw [hi₀] at hi₁; exact absurd hi₁ (by decide)
  · rintro rfl; rw [hi₀] at hi₂; exact absurd hi₂ (by decide)
  · rintro rfl; rw [hi₁] at hi₂; exact absurd hi₂ (by decide)

/-- **Lebesgue's covering theorem for a rectangle** (`n = 2`): if the closed rectangle `[a, b] × [c, d]`
is covered by finitely many closed sets none of which meets both vertical sides or both horizontal
sides, some point of the rectangle lies in three of them. Hurewicz–Wallman, *Dimension Theory* (1948),
Ch. IV § 3, Thm IV 2, p. 42 (the `n`-cube, `n + 1` sets). -/
theorem lebesgue_covering_rect {ι : Type*} [Finite ι] {a b c d : ℝ} (hab : a < b) (hcd : c < d)
    (F : ι → Set ℂ) (hF : ∀ i, IsClosed (F i)) (hcov : Icc a b ×ℂ Icc c d ⊆ ⋃ i, F i)
    (hLR : ∀ i, ¬ ((∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.re = a) ∧ ∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.re = b))
    (hBT : ∀ i, ¬ ((∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.im = c) ∧ ∃ z ∈ F i ∩ Icc a b ×ℂ Icc c d, z.im = d)) :
    ∃ z ∈ Icc a b ×ℂ Icc c d, ∃ i j l : ι, i ≠ j ∧ i ≠ l ∧ j ≠ l ∧ z ∈ F i ∧ z ∈ F j ∧ z ∈ F l :=
  lebesgue_covering_rect' hab hcd F hF hcov hLR fun i _ => hBT i

/-- The closed axis-parallel square `[c.re, c.re + s] × [c.im, c.im + s]` (the same body as FS-131 wave
4's `HadwigerNelson.Plane.closedSquare`, so the two unfold to one term). -/
def closedSquare (c : ℂ) (s : ℝ) : Set ℂ := {z | c.re ≤ z.re ∧ z.re ≤ c.re + s ∧ c.im ≤ z.im ∧ z.im ≤ c.im + s}

/-- The square as a product of intervals. -/
theorem closedSquare_eq_reProdIm (c : ℂ) (s : ℝ) :
    closedSquare c s = Icc c.re (c.re + s) ×ℂ Icc c.im (c.im + s) := by
  ext z
  simp [closedSquare, mem_reProdIm, and_assoc]

/-- **Lebesgue's covering theorem for the square** (`n = 2`): if a closed square is covered by finitely
many closed sets none of which meets two opposite sides, some point of the square lies in three of
them. Hurewicz–Wallman, *Dimension Theory* (1948), Ch. IV § 3, Thm IV 2, p. 42 (the `n`-cube, `n + 1`
sets). The statement is FS-131 wave 4's `HadwigerNelson.Plane.lebesgue_covering_square`, verbatim. -/
theorem lebesgue_covering_square {m : ℕ} (c : ℂ) {s : ℝ} (hs : 0 < s) (F : Fin m → Set ℂ) (hF : ∀ i, IsClosed (F i))
    (hcov : closedSquare c s ⊆ ⋃ i, F i)
    (hLR : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.re = c.re) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.re = c.re + s))
    (hBT : ∀ i, ¬ ((∃ z ∈ F i ∩ closedSquare c s, z.im = c.im) ∧ ∃ z ∈ F i ∩ closedSquare c s, z.im = c.im + s)) :
    ∃ z ∈ closedSquare c s, ∃ i j l : Fin m, i ≠ j ∧ i ≠ l ∧ j ≠ l ∧ z ∈ F i ∧ z ∈ F j ∧ z ∈ F l := by
  simp only [closedSquare_eq_reProdIm] at hcov hLR hBT ⊢
  exact lebesgue_covering_rect (by linarith) (by linarith) F hF hcov hLR hBT

/-! ## Spec examples, and a model of the square theorem's hypotheses -/

example : leastLabel (fun _ => (univ : Set ℂ)) 0 = 0 ∧ leastLabel (fun k => if k = 2 then (univ : Set ℂ) else ∅) 0 = 2 := by
  simp [leastLabel]

example : gridPt 0 1 0 1 2 1 1 = ⟨1 / 2, 1 / 2⟩ ∧ gridPt 0 1 0 1 2 2 0 = 1 := by
  refine ⟨?_, ?_⟩ <;> apply Complex.ext <;> simp [gridPt]

example : (⟨1 / 2, 1⟩ : ℂ) ∈ closedSquare 0 1 ∧ (⟨2, 0⟩ : ℂ) ∉ closedSquare 0 1 := by
  constructor
  · norm_num [closedSquare]
  · norm_num [closedSquare]

/-- The four closed quadrants of the unit square `closedSquare 0 1`: quadrant `i` has lower-left corner
`(½ (i mod 2), ½ (i div 2))` and side `½`. -/
def quadrant (i : Fin 4) : Set ℂ :=
  Icc ((![0, 1 / 2, 0, 1 / 2] : Fin 4 → ℝ) i) ((![0, 1 / 2, 0, 1 / 2] : Fin 4 → ℝ) i + 1 / 2) ×ℂ
    Icc ((![0, 0, 1 / 2, 1 / 2] : Fin 4 → ℝ) i) ((![0, 0, 1 / 2, 1 / 2] : Fin 4 → ℝ) i + 1 / 2)

/-- **A model of `lebesgue_covering_square`'s hypotheses**: the four quadrants of the unit square are
closed, cover it, and none meets two opposite sides (so the theorem is not vacuous; four sets is the
fewest its hypotheses allow, one for each corner). -/
theorem quadrant_hypotheses :
    (∀ i, IsClosed (quadrant i)) ∧ closedSquare 0 1 ⊆ ⋃ i, quadrant i ∧
    (∀ i, ¬ ((∃ z ∈ quadrant i ∩ closedSquare 0 1, z.re = (0 : ℂ).re) ∧
      ∃ z ∈ quadrant i ∩ closedSquare 0 1, z.re = (0 : ℂ).re + 1)) ∧
    (∀ i, ¬ ((∃ z ∈ quadrant i ∩ closedSquare 0 1, z.im = (0 : ℂ).im) ∧
      ∃ z ∈ quadrant i ∩ closedSquare 0 1, z.im = (0 : ℂ).im + 1)) := by
  refine ⟨fun i => isClosed_Icc.reProdIm isClosed_Icc, fun z hz => ?_, ?_, ?_⟩
  · simp only [closedSquare, zero_re, zero_im, zero_add, mem_setOf_eq] at hz
    obtain ⟨h1, h2, h3, h4⟩ := hz
    rw [mem_iUnion]
    rcases le_total z.re (1 / 2) with hx | hx <;> rcases le_total z.im (1 / 2) with hy | hy
    · exact ⟨0, mem_reProdIm.2 ⟨⟨show (0 : ℝ) ≤ z.re by linarith, show z.re ≤ 0 + 1 / 2 by linarith⟩,
        ⟨show (0 : ℝ) ≤ z.im by linarith, show z.im ≤ 0 + 1 / 2 by linarith⟩⟩⟩
    · exact ⟨2, mem_reProdIm.2 ⟨⟨show (0 : ℝ) ≤ z.re by linarith, show z.re ≤ 0 + 1 / 2 by linarith⟩,
        ⟨show (1 / 2 : ℝ) ≤ z.im by linarith, show z.im ≤ 1 / 2 + 1 / 2 by linarith⟩⟩⟩
    · exact ⟨1, mem_reProdIm.2 ⟨⟨show (1 / 2 : ℝ) ≤ z.re by linarith, show z.re ≤ 1 / 2 + 1 / 2 by linarith⟩,
        ⟨show (0 : ℝ) ≤ z.im by linarith, show z.im ≤ 0 + 1 / 2 by linarith⟩⟩⟩
    · exact ⟨3, mem_reProdIm.2 ⟨⟨show (1 / 2 : ℝ) ≤ z.re by linarith, show z.re ≤ 1 / 2 + 1 / 2 by linarith⟩,
        ⟨show (1 / 2 : ℝ) ≤ z.im by linarith, show z.im ≤ 1 / 2 + 1 / 2 by linarith⟩⟩⟩
  -- a quadrant's sides are `½` long, so it cannot reach from `0` to `1` in either coordinate
  · rintro i ⟨⟨z, ⟨⟨⟨hz1, -⟩, -⟩, -⟩, hz0⟩, ⟨w, ⟨⟨⟨-, hw1⟩, -⟩, -⟩, hw0⟩⟩
    simp only [zero_re, zero_add] at hz0 hw0
    linarith
  · rintro i ⟨⟨z, ⟨⟨-, ⟨hz1, -⟩⟩, -⟩, hz0⟩, ⟨w, ⟨⟨-, ⟨-, hw1⟩⟩, -⟩, hw0⟩⟩
    simp only [zero_im, zero_add] at hz0 hw0
    linarith

end HadwigerNelson.LebesgueCovering
