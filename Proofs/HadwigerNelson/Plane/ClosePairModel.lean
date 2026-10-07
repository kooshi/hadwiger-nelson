import Proofs.HadwigerNelson.Plane.ClosePair

/-!
# Models for the close complementary pair: the hypotheses of the four statements are satisfiable (FS-124, second module)

Inhabitants for `Plane/ClosePair` (plan: `plans/FS124-kernel-plan-2.md` § the models). Each is a colouring of three
small discs about `x`, `y` and a common unit point `w`: such a set holds unit pairs only between the disc about `w`
and each of the other two (the pair is taken with `|x − y| ≠ 1`), so the colouring is a weak colouring as soon as it
separates those.

* `exists_closePair_not_separatesAt` — **six colours, one member alone**: near `w` only two labels of `x`, inside and
  outside the unit circle about `x`; the witness planned has `x` a three-piece point by the letter (a petal toward `w`, a sector away
  from it, the rest); `y` an ordinary three-sector point with no inner piece at `w`. The hypotheses of `closePair_forced_pieces` and
  of `closePair_lone` at once.
* `exists_closePair_full` — **six colours, both members arc-edged, one piece of each kind**: the witness planned is the unit square `x = 0`,
  `w = 1`, `y = 1 − i`; near `w` the four regions cut by the unit circles about `x` and `y` carry four labels, one
  each; at `x` the pieces are cut by the unit circles about `1` and `i`, at `y` by those about `1` and `−i`, so every
  edge is an arc of a unit circle from the point. The hypotheses of `closePair_both_separate`, `closePair_both_saved` and `closePair_four` at
  once.
* `exists_closePair_seven_not_separatesAt` — **the control on six**: with seven colours there is a close
  complementary pair with a common unit point at which **neither** member separates (the seventh label fills the disc
  about `w`). So `closePair_forced_pieces` is false at seven as it stands, and the cover hypothesis of
  `ClosePair.separatesAt_or` cannot be dropped.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric

/-- **Inhabitant of the hypotheses of `closePair_forced_pieces` and `closePair_lone`**: a weak six-colouring of an open set with a close
complementary pair and a common unit point in the set at which the second member does not separate. -/
theorem exists_closePair_not_separatesAt :
    ∃ (U : Set ℂ) (c : ℂ → Fin 6) (x y w : ℂ) (C : ClosePair U c x y),
      IsOpen U ∧ IsWeakColouringOn U c ∧ w ∈ U ∧ IsCommonUnitPoint x y w ∧ ¬ C.right.SeparatesAt w := by
  sorry

/-- **Inhabitant of the hypotheses of `closePair_both_separate`, `closePair_both_saved` and `closePair_four`**: a weak six-colouring of an open set
with a close complementary pair of arc-edged (hence full) members and a common unit point in the set at which each
has one inner, one outer and one crossing piece. -/
theorem exists_closePair_full :
    ∃ (U : Set ℂ) (c : ℂ → Fin 6) (x y w : ℂ) (C : ClosePair U c x y),
      IsOpen U ∧ IsWeakColouringOn U c ∧ w ∈ U ∧ IsCommonUnitPoint x y w ∧ C.left.HasArcEdges ∧
        C.right.HasArcEdges ∧ (∃ σ, C.left.OneOfEach w σ) ∧ ∃ τ, C.right.OneOfEach w τ := by
  sorry

/-- **The control on six**: with seven colours, a close complementary pair with a common unit point in the set at
which neither member separates. -/
theorem exists_closePair_seven_not_separatesAt :
    ∃ (U : Set ℂ) (c : ℂ → Fin 7) (x y w : ℂ) (C : ClosePair U c x y),
      IsOpen U ∧ IsWeakColouringOn U c ∧ w ∈ U ∧ IsCommonUnitPoint x y w ∧ ¬ C.left.SeparatesAt w ∧
        ¬ C.right.SeparatesAt w := by
  sorry

/-! ## Spec examples: the theorems run on their inhabitants -/

/-- `closePair_lone` on its inhabitant: some weak six-colouring has a three-piece point whose inner and outer pieces at a unit
point meet at the point only. -/
example : ∃ (U : Set ℂ) (c : ℂ → Fin 6) (x : ℂ) (D : ThreePiece U c x) (i j : Fin 3) (η : ℝ),
    0 < η ∧ closure (D.piece i) ∩ closure (D.piece j) ∩ ball x η = {x} := by
  obtain ⟨U, c, x, y, w, C, hU, hc, hw, hwu, hy⟩ := exists_closePair_not_separatesAt
  obtain ⟨σ, -, -, w', -, -, η', hη', -, -, h⟩ := closePair_lone hU hc C hw hwu hy
  exact ⟨U, c, x, C.left, σ 0, σ 1, η', hη', h⟩

/-- `closePair_four` on its inhabitant: some weak six-colouring has a point at which exactly four labels are present. -/
example : ∃ (U : Set ℂ) (c : ℂ → Fin 6) (w : ℂ), IsWeakColouringOn U c ∧ (presentAt U c w).ncard = 4 := by
  obtain ⟨U, c, x, y, w, C, hU, hc, hw, hwu, hax, hay, ⟨σ, hσ⟩, τ, hτ⟩ := exists_closePair_full
  exact ⟨U, c, w, hc, (closePair_four hU hc C hw hwu hax.isFull hay.isFull hσ hτ).2⟩

/-- `closePair_both_separate` and `closePair_both_saved` on their inhabitant. -/
example : ∃ (U : Set ℂ) (c : ℂ → Fin 6) (x y w : ℂ) (C : ClosePair U c x y),
    (C.left.SeparatesAt w ∧ C.right.SeparatesAt w) ∧ C.left.Saves w ∧ C.right.Saves w := by
  obtain ⟨U, c, x, y, w, C, hU, hc, hw, hwu, hax, hay, -⟩ := exists_closePair_full
  exact ⟨U, c, x, y, w, C, closePair_both_separate hU hc C hw hwu hax.isFull hay.isFull,
    closePair_both_saved hU hc C hw hwu hax hay⟩

end HadwigerNelson.Plane
