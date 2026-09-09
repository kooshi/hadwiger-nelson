import Proofs.HadwigerNelson.Brick
import Proofs.HadwigerNelson.BrickDistance

/-!
# The nine-colour brick colouring: `χ(ℝ²) ≤ 9`, kernel-checked (M35 L3's instance)

**The plane is properly 9-colourable**: the 3 × 3 rainbow of `2/3 × 2/3` half-open square
cells — cell diagonal `√(8/9) < 1`, nearest same-coloured cells a full `2` cells away with
box distance `4/3 > 1`. The certificate `Brick.check` verifies exactly that, over every
offset in its computed window, by kernel `decide`.

**What this module is for, now that it is not the best bound.** `Instances/Seven.lean`
carries `χ(ℝ²) ≤ 7` — in the SAME tile family, by the same certificate. This NINE stays
because it is the certificate's most legible instance (every margin is slack: the cell
diagonal is `√(8/9)`, comfortably under 1, and the nearest same-coloured cells are a clear
`4/3` apart, so nothing here depends on the boundary-tight reasoning `Seven` needs), and
because it carries the avoidance surface at distances the seven-colouring does not avoid.
Its controls are the check's regression tests at a shape unlike `Seven`'s.

**A retraction, recorded rather than quietly edited.** This docstring previously reported
that the registered brick sweeps found no row-brick colouring at `k ≤ 8` at any probed
shape, and concluded that row-aligned bricks cannot interlock the way hexagons do and that
`χ ≤ 7` would need genuinely polygonal cells. The sweep numbers stand; **both conclusions
are false**. The sweeps were run against a certificate that demanded STRICT separation, and
against a grid filtered to cells of diagonal below 1 — and the seven-colouring in this
family has cell diagonal exactly 1, so it was excluded twice over. A search run against a
sufficient-but-not-necessary check measures the check. See M36 §0a C2.

The same table also witnesses the AVOIDANCE surface: it avoids the squared distance `3/2`
(no two same-coloured points at distance `√(3/2)`), certifying `Brick.avoids` live — the
consumer any future k = 6/5 avoider find would use.

**Two facts, one theorem** (FS-24 G7b). Proper colouring and distance avoidance are two
statements about one function, and `distanceGraph` (M49) is the object that holds them
together: the same certificate says `χ(ℝ²; {1, √(3/2)}) ≤ 9` — the plane with BOTH the unit
distance and `√(3/2)` forbidden needs at most nine colours. That is the form a future avoider
find is quoted in, and it is what this module says it exists for.
-/

namespace HadwigerNelson

open SimpleGraph

/-- The 3 × 3 rainbow on `2/3 × 2/3` cells: every cell its own colour. -/
def nineBrick : Brick 9 where
  m := 3
  n := 3
  w := 2/3
  h := 2/3
  s := 0
  table := fun i j => ⟨3 * i.1 + j.1, by omega⟩
  m_pos := by decide
  n_pos := by decide
  w_pos := by norm_num
  h_pos := by norm_num

/-- The certificate passes with the properness guard alone, and with the `3/2` avoidance
guard added. ONE kernel decide each. -/
theorem nineBrick_check : nineBrick.check [1] = true := by decide +kernel

theorem nineBrick_check_avoid : nineBrick.check [1, 3/2] = true := by decide +kernel

/-- **`χ(ℝ²) ≤ 9`.** The plane's unit-distance graph is 9-colourable — the repository's
first kernel-checked upper bound (M35), superseded as a bound by `plane_colorable_seven`
(M36) and kept as this certificate's slack-margin instance. -/
theorem plane_colorable_nine : (unitDistance ℂ).Colorable 9 :=
  nineBrick.colorable (List.mem_singleton.mpr rfl) nineBrick_check

/-- The avoidance surface, live: a proper 9-colouring of the plane with NO monochromatic
pair at distance `√(3/2)` — the consumer shape any future avoider find would instantiate
(at k = 6 it would bound seven-forcers; at k = 5 it would prove `χ(ℝ²) ≤ 5`). -/
theorem nine_avoids_sqrt_three_halves :
    ∃ C : (unitDistance ℂ).Coloring (Fin 9), ∀ z z' : ℂ,
      dist z z' = Real.sqrt ((3/2 : ℚ) : ℝ) → C z ≠ C z' := by
  refine ⟨Coloring.mk nineBrick.color fun hadj =>
    nineBrick.sound nineBrick_check_avoid List.mem_cons_self
      (by rw [unitDistance_adj.mp hadj]; norm_num), fun z z' hd => ?_⟩
  exact nineBrick.avoids (List.mem_cons_of_mem _ (List.mem_singleton.mpr rfl))
    nineBrick_check_avoid hd

/-- **`χ(ℝ²; {1, √(3/2)}) ≤ 9`, as one theorem.** The plane's graph with both the unit distance
and `√(3/2)` forbidden is 9-colourable — `plane_colorable_nine` and `nine_avoids_sqrt_three_halves`
above, which are two statements about the same function, joined into the object that carries both.
No new mathematics and no new certificate: one `decide` (`nineBrick_check_avoid`) does all of it. -/
theorem plane_colorable_nine_avoiding_sqrt_three_halves :
    (distanceGraph ℂ {1, Real.sqrt ((3/2 : ℚ) : ℝ)}).Colorable 9 :=
  nineBrick.colorable_avoiding List.mem_cons_self
    (List.mem_cons_of_mem _ (List.mem_singleton.mpr rfl)) nineBrick_check_avoid

/-- The same in chromatic-number form, which is how the record states it. Note the honest reading:
a two-distance upper bound is a bound on a graph *containing* the unit-distance graph, so it is a
STRONGER statement than `χ(ℝ²) ≤ 9` (`chromaticNumber_unitDistance_le_distanceGraph`) — the extra
content is exactly the avoidance. -/
theorem chromaticNumber_plane_avoiding_sqrt_three_halves_le_nine :
    (distanceGraph ℂ {1, Real.sqrt ((3/2 : ℚ) : ℝ)}).chromaticNumber ≤ 9 :=
  plane_colorable_nine_avoiding_sqrt_three_halves.chromaticNumber_le

/-! ### Controls — compiled, every build -/

-- the computable twin agrees with Python's samples: cell (0,0) wears 0, its right
-- neighbour's column wears 3, the wrap returns, negatives wrap correctly
#guard nineBrick.colorQ 0 0 = (0 : Fin 9)
#guard nineBrick.colorQ (2/3) 0 = (3 : Fin 9)
#guard nineBrick.colorQ 0 (2/3) = (1 : Fin 9)
#guard nineBrick.colorQ 2 2 = (0 : Fin 9)
#guard nineBrick.colorQ (-1/3) 0 = (6 : Fin 9)
#guard nineBrick.colorQ (1/3) (1/3) = (0 : Fin 9)

-- the adversarial member: repeat a colour on adjacent cells and the check must fail
#guard ({ nineBrick with table := fun _ _ => 0 } : Brick 9).check [1] = false

-- the guard-list discipline: a guard STRICTLY inside the same-cell offset's interval is
-- refused, and no relaxation of the certificate can ever accept one
#guard nineBrick.check [1, 1/2] = false

-- the degenerate guard is unrepresentable by a passing certificate: `0 ≤ loAt 0 0` would
-- otherwise be accepted and `sound` would then deny a point its own colour
#guard nineBrick.check [0] = false
#guard nineBrick.check [1, 0] = false

-- the boundary itself is admissible, and the mathematics agrees: the cell diagonal is
-- exactly `√(8/9)`, approached and never attained (half-open cells), so this colouring
-- avoids that distance too — M35's control asserted the opposite because the certificate
-- then demanded strict separation (M36 §0a C1)
#guard nineBrick.check [1, 8/9] = true

end HadwigerNelson
