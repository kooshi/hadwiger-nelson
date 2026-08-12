import Proofs.HadwigerNelson.Brick

/-!
# The nine-colour brick colouring: `χ(ℝ²) ≤ 9`, kernel-checked (M35 L3's instance)

**The plane is properly 9-colourable**: the 3 × 3 rainbow of `2/3 × 2/3` half-open square
cells — cell diagonal `√(8/9) < 1`, nearest same-coloured cells a full `2` cells away with
box distance `4/3 > 1`. The certificate `Brick.check` verifies exactly that, over every
offset in its computed window, by kernel `decide`.

**Attribution and honest label** (M35 §0j/§0l): `χ(ℝ²) ≤ 7` is classical (the hexagonal
colouring); this NINE is deliberately weaker and exists as the machinery's demonstration
instance — the first certified upper bound in this repository, landing the interval
`5 ≤ χ(ℝ²) ≤ 9` kernel-side end to end. The registered brick sweeps (m35-periodic, 2,796
rows) found NO row-brick colouring at k ≤ 8 at any probed shape — row-aligned bricks cannot
interlock the way hexagons do — so the 9 is also the measured threshold of this tile family
at the probed resolutions. The `χ ≤ 7` instance needs genuinely polygonal cells and is
priced as future work.

The same table also witnesses the AVOIDANCE surface: it avoids the squared distance `3/2`
(no two same-coloured points at distance `√(3/2)`), certifying `Brick.avoids` live — the
consumer any future k = 6/5 avoider find would use.
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
first kernel-checked upper bound; with M06–M09's `χ(ℝ²) ≥ 5` the classical interval is now
bounded kernel-side from both ends (at `[5, 9]`; the classical `≤ 7` is future work). -/
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
    (by norm_num) nineBrick_check_avoid hd

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

-- the guard-list discipline: a too-close avoidance guard is refused (the same-cell offset
-- forces every guard above the cell diagonal 8/9)
#guard nineBrick.check [1, 8/9] = false

end HadwigerNelson
