import Proofs.HadwigerNelson.RationalFour.Compulsion

/-!
# Which distances a four-colouring of rational four-space can forbid beside 1 (FS-131, FS131-KFS1; skeleton)

**The question** (`[Johnson2006]` p. 212): *"For which d > 0 does there exist a 4-coloring of ℚ⁴ which forbids both distances 1
and d?"*

**Read aloud, against the informal claim** (`CLOSED-QUESTIONS.md` § 3; LX-T6). For `d > 0`, a proper four-colouring of the
unit-distance graph on `ℚ⁴` in which no two points at distance `d` share a colour exists iff `d²` is not rational, or
`d² = p/q` with `p` and `q` odd natural numbers (`exists_coloring_forbidding_iff`). For `d² = p/q`, `p, q` odd, every proper
four-colouring forbids `d` (`coloring_forbids_of_odd`). On the rationals: for `r > 0`, a proper four-colouring forbidding
squared distance `r` exists iff `v₂(r) = 0` (`exists_coloring_forbidding_iff_padicValRat`).

**What it rests on:** the standard three axioms (planned). The *if* half is `[Johnson1990]` Thm 3; the *only if* half, which
p. 212 calls open, is the compulsion law (`RationalFour/Compulsion`) with a rational similarity of ratio `d`.

**Not claimed:** anything about colourings with more than four colours; that the answer is new (prior art: FS131-PAS2's to
find).
-/

namespace HadwigerNelson.RationalFour

open Quaternion

/-- **Lagrange over `ℚ`**: every positive rational is a squared distance in `ℚ⁴`. -/
theorem exists_sqDist4_eq {r : ℚ} (hr : 0 < r) : ∃ x : Fin 4 → ℚ, sqDist4 x 0 = r := by
  sorry

/-- A positive rational has `v₂ = 0` iff it is a quotient of two odd natural numbers. -/
theorem padicValRat_eq_zero_iff_odd {r : ℚ} (hr : 0 < r) :
    padicValRat 2 r = 0 ↔ ∃ p q : ℕ, Odd p ∧ Odd q ∧ r = p / q := by
  sorry

/-- **The answer on the rationals**: for `r > 0`, some proper four-colouring of `ℚ⁴` gives every pair at squared distance `r`
two colours iff `v₂(r) = 0`. -/
theorem exists_coloring_forbidding_iff_padicValRat {r : ℚ} (hr : 0 < r) :
    (∃ c : ratFourGraph.Coloring (Fin 4), ∀ x y, sqDist4 x y = r → c x ≠ c y) ↔ padicValRat 2 r = 0 := by
  sorry

/-- **Every proper four-colouring of `ℚ⁴` forbids `√(p/q)`** for odd `p` and `q` (`[Zaks1999]` Theorem 3 is `q = 1`, `p` an odd
square). -/
theorem coloring_forbids_of_odd {p q : ℕ} (hp : Odd p) (hq : Odd q) (c : ratFourGraph.Coloring (Fin 4))
    {x y : Fin 4 → ℚ} (h : sqDist4 x y = p / q) : c x ≠ c y := by
  sorry

/-- **Which distances a four-colouring of `ℚ⁴` can forbid beside 1** (`[Johnson2006]` p. 212's question): for `d > 0`, a proper
four-colouring of the unit-distance graph on `ℚ⁴` forbidding distance `d` exists iff `d²` is irrational (no pair of `ℚ⁴` is at
distance `d`) or `d² = p/q` with `p, q` odd. The *if* half is `[Johnson1990]` Thm 3; the *only if* half is the compulsion
law with a rational similarity of ratio `d`. -/
theorem exists_coloring_forbidding_iff {d : ℝ} (hd : 0 < d) :
    (∃ c : ratFourGraph.Coloring (Fin 4), ∀ x y, (sqDist4 x y : ℝ) = d ^ 2 → c x ≠ c y) ↔
      (∀ r : ℚ, (r : ℝ) ≠ d ^ 2) ∨ ∃ p q : ℕ, Odd p ∧ Odd q ∧ d ^ 2 = (p : ℝ) / q := by
  sorry

/-! ## Spec: Johnson's guess, and his `K` -/

/-- `√2` cannot be forbidden (`[Zaks1999]` Lemma 1; `v₂(2) = 1`). -/
example : ¬ ∃ c : ratFourGraph.Coloring (Fin 4), ∀ x y, sqDist4 x y = 2 → c x ≠ c y := by
  sorry

/-- `√(1/2)` cannot be forbidden either (`v₂ = −1`: the similarity argument). -/
example : ¬ ∃ c : ratFourGraph.Coloring (Fin 4), ∀ x y, sqDist4 x y = 1 / 2 → c x ≠ c y := by
  sorry

/-- `√(3/5)` is forbidden by every proper four-colouring. -/
example (c : ratFourGraph.Coloring (Fin 4)) {x y : Fin 4 → ℚ} (h : sqDist4 x y = 3 / 5) : c x ≠ c y :=
  coloring_forbids_of_odd (p := 3) (q := 5) (by decide) (by decide) c (by rw [h]; norm_num)

end HadwigerNelson.RationalFour
