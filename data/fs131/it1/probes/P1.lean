import Proofs.HadwigerNelson.Arith.ThreeColourCharacter

namespace HadwigerNelson.TorsionExtraction

/-- A form `2x + y + 2z + w` on the box `[−1/6, 1/6]⁴` of absolute value at least 1 sits at a corner. -/
private theorem abs_eq_of_one_le_abs_form {x y z w : ℝ} (hx : |x| ≤ 1 / 6) (hy : |y| ≤ 1 / 6) (hz : |z| ≤ 1 / 6)
    (hw : |w| ≤ 1 / 6) (h : 1 ≤ |2 * x + y + 2 * z + w|) :
    |x| = 1 / 6 ∧ |y| = 1 / 6 ∧ |z| = 1 / 6 ∧ |w| = 1 / 6 := by
  have hle : |2 * x + y + 2 * z + w| ≤ 2 * |x| + |y| + 2 * |z| + |w| :=
    abs_le.mpr ⟨by linarith [neg_abs_le x, neg_abs_le y, neg_abs_le z, neg_abs_le w],
      by linarith [le_abs_self x, le_abs_self y, le_abs_self z, le_abs_self w]⟩
  exact ⟨le_antisymm hx (by linarith), le_antisymm hy (by linarith), le_antisymm hz (by linarith),
    le_antisymm hw (by linarith)⟩

theorem layer_step {a b a' b' : ℝ} (ha : |a| ≤ 1 / 6) (hb : |b| ≤ 1 / 6) (ha' : |a'| ≤ 1 / 6) (hb' : |b'| ≤ 1 / 6)
    (h1 : ∃ n : ℤ, 2 * a' - b' - 2 * a - b = n) (h2 : ∃ n : ℤ, a' + 2 * b' + a - 2 * b = n) :
    (a' = (3 * a + 4 * b) / 5 ∧ b' = (-4 * a + 3 * b) / 5) ∨
      (|a| = 1 / 6 ∧ |b| = 1 / 6 ∧ |a'| = 1 / 6 ∧ |b'| = 1 / 6) := by
  obtain ⟨n1, hn1⟩ := h1
  obtain ⟨n2, hn2⟩ := h2
  have hint : ∀ n : ℤ, n ≠ 0 → (1 : ℝ) ≤ |(n : ℝ)| := fun n hn => by
    exact_mod_cast Int.one_le_abs hn
  by_cases h0 : n1 = 0 ∧ n2 = 0
  · left
    obtain ⟨rfl, rfl⟩ := h0
    rw [Int.cast_zero] at hn1 hn2
    constructor <;> linarith
  · right
    rcases not_and_or.mp h0 with h | h
    · -- the first form, `2a' + (−b') + 2(−a) + (−b)`, is `±1`
      have hf : 1 ≤ |2 * a' + -b' + 2 * -a + -b| := by
        rw [show 2 * a' + -b' + 2 * -a + -b = (n1 : ℝ) by rw [← hn1]; ring]
        exact hint n1 h
      have := abs_eq_of_one_le_abs_form ha' (by rwa [abs_neg]) (by rwa [abs_neg]) (by rwa [abs_neg]) hf
      simp only [abs_neg] at this
      exact ⟨this.2.2.1, this.2.2.2, this.1, this.2.1⟩
    · -- the second form, `2b' + a' + 2(−b) + a`, is `±1`
      have hf : 1 ≤ |2 * b' + a' + 2 * -b + a| := by
        rw [show 2 * b' + a' + 2 * -b + a = (n2 : ℝ) by rw [← hn2]; ring]
        exact hint n2 h
      have := abs_eq_of_one_le_abs_form hb' ha' (by rwa [abs_neg]) ha hf
      simp only [abs_neg] at this
      exact ⟨this.2.2.2, this.2.2.1, this.2.1, this.1⟩

/-- A rotation step by `(3 − 4i)/5` between two points of the box has neither end at a corner: the other end would
have a coordinate `7/30 > 1/6`. -/
private theorem no_rotation_at_corner {a b a' b' : ℝ} (ha : |a| ≤ 1 / 6) (hb : |b| ≤ 1 / 6) (ha' : |a'| ≤ 1 / 6)
    (hb' : |b'| ≤ 1 / 6) (h1 : a' = (3 * a + 4 * b) / 5) (h2 : b' = (-4 * a + 3 * b) / 5)
    (hc : (|a| = 1 / 6 ∧ |b| = 1 / 6) ∨ (|a'| = 1 / 6 ∧ |b'| = 1 / 6)) : False := by
  rw [abs_le] at ha hb ha' hb'
  have hcase : ∀ x : ℝ, |x| = 1 / 6 → x = 1 / 6 ∨ x = -(1 / 6) := fun x hx => by
    rcases abs_cases x with ⟨h, _⟩ | ⟨h, _⟩
    · left; linarith
    · right; linarith
  rcases hc with ⟨h, h'⟩ | ⟨h, h'⟩ <;> rcases hcase _ h with e | e <;> rcases hcase _ h' with e' | e' <;> linarith

theorem layer_dichotomy {a b : ℤ → ℝ} (ha : ∀ m, |a m| ≤ 1 / 6) (hb : ∀ m, |b m| ≤ 1 / 6)
    (h1 : ∀ m, ∃ n : ℤ, 2 * a (m + 1) - b (m + 1) - 2 * a m - b m = n)
    (h2 : ∀ m, ∃ n : ℤ, a (m + 1) + 2 * b (m + 1) + a m - 2 * b m = n) :
    (∀ m, a (m + 1) = (3 * a m + 4 * b m) / 5 ∧ b (m + 1) = (-4 * a m + 3 * b m) / 5) ∨
      (∀ m, |a m| = 1 / 6 ∧ |b m| = 1 / 6) := by
  have step := fun m => layer_step (ha m) (hb m) (ha (m + 1)) (hb (m + 1)) (h1 m) (h2 m)
  by_cases hrot : ∀ m, a (m + 1) = (3 * a m + 4 * b m) / 5 ∧ b (m + 1) = (-4 * a m + 3 * b m) / 5
  · exact Or.inl hrot
  right
  obtain ⟨m₀, hm₀⟩ := not_forall.mp hrot
  -- the step at `m₀` is not a rotation, so `m₀` is at a corner
  have h0 : |a m₀| = 1 / 6 ∧ |b m₀| = 1 / 6 := by
    rcases step m₀ with h | h
    · exact absurd h hm₀
    · exact ⟨h.1, h.2.1⟩
  -- a corner propagates one step forward and one step back: the step is not a rotation
  have fwd : ∀ m, (|a m| = 1 / 6 ∧ |b m| = 1 / 6) → |a (m + 1)| = 1 / 6 ∧ |b (m + 1)| = 1 / 6 := by
    intro m hm
    rcases step m with h | h
    · exact (no_rotation_at_corner (ha m) (hb m) (ha (m + 1)) (hb (m + 1)) h.1 h.2 (Or.inl hm)).elim
    · exact ⟨h.2.2.1, h.2.2.2⟩
  have bwd : ∀ m, (|a (m + 1)| = 1 / 6 ∧ |b (m + 1)| = 1 / 6) → |a m| = 1 / 6 ∧ |b m| = 1 / 6 := by
    intro m hm
    rcases step m with h | h
    · exact (no_rotation_at_corner (ha m) (hb m) (ha (m + 1)) (hb (m + 1)) h.1 h.2 (Or.inr hm)).elim
    · exact ⟨h.1, h.2.1⟩
  intro m
  induction m using Int.inductionOn' (b := m₀) with
  | zero => exact h0
  | succ k _ ih => exact fwd k ih
  | pred k _ ih =>
    refine bwd (k - 1) ?_
    rwa [sub_add_cancel]

end HadwigerNelson.TorsionExtraction
