import Proofs.HadwigerNelson.Brick
import Mathlib.Analysis.InnerProductSpace.PiL2

/-!
# The seven-colour brick colouring: `χ(ℝ²) ≤ 7`, kernel-checked (M36)

**The plane is properly 7-colourable**, and the witness is a 4:3 brick whose diagonal is
exactly the unit distance: half-open `4/5 × 3/5` cells, each row shifted `2/5` from the one
below, coloured by `(column + 3·row) mod 7`.

**Why that table.** Identify the cell lattice with `ℤ[ζ₆]` (a cell's neighbours in its own
row are `±1`, the row above is `+ζ₆`). The map `a + bζ₆ ↦ (a + 3b) mod 7` has a kernel that
is stable under multiplication by `ζ₆` — `(a, b) ↦ (−b, a + b)` sends the residue to
`3a + 2b ≡ 3·(a + 3b)` — hence an IDEAL, and it contains `τ = −3 + ζ₆` of norm
`9 − 3 + 1 = 7`, so by index it *is* `(τ)`. Two same-coloured cells therefore differ by
`τ·μ`, of norm `7·|μ|² ≥ 7`: **norm multiplicativity, not a lattice census, is what
separates the colour classes.** The coefficient `3` is not a choice with alternatives — it
and its conjugate `5` are exactly the roots of `x² − x + 1` in `𝔽₇`, i.e. the only images
`ζ₆` can have under a ring map to `𝔽₇`; at every other coefficient the kernel is a
subgroup and not an ideal, with a vector of norm 1 or 3 inside the unit distance
(`build/m36-design.py` reports the census, and the mutation control below is its Lean
half).

**Why exactly this shape.** Two offsets pin the geometry and leave no freedom. A cell shares
its own colour, so the cell diagonal must be at most 1: `w² + h² ≤ 1`. The coset offset
`(dc, dr) = (1, 2)` — the lattice vector `1 + 2ζ₆`, whose residue `1 + 3·2 = 7` vanishes —
translates by exactly `(2w, 2h)`, so the two cells' closest approach is `√(w² + h²)`, which
must be at least 1. Hence `w² + h² = 1` **exactly**: every brick seven-colouring in this
family is boundary-tight, and `(4/5, 3/5)` is the smallest-denominator rational point of
that circle satisfying the two remaining slack conditions (`w ≥ 2/3`, `h ≥ 1/2`). The
certificate is sound at the boundary because the cells are half-open — the realizable
offsets form an OPEN box (`Brick.sound`), so the extremal configurations are approached and
never attained.

**Attribution.** The seven-colouring of the plane is classical (Isbell's hexagonal argument;
half-open brick variants are folklore). Nothing about the construction is claimed as new.
What is ours: the kernel certificate, and the boundary-tight soundness that makes any
zero-margin colouring certifiable at all. Under strict separation — which is what this
repository's certificate demanded before M36, soundly, it simply refused more than it had
to — NO brick seven-colouring is certifiable, and a search run against such a check reports
the whole family as refusing. M35's phase 2 did exactly that (see M36 §0a C2); the numbers
were right and the conclusion drawn from them was not.

Nothing in this module rests on a search. The colouring is written down, not found, and the
certificate is decided by the kernel — `tools/` and `build/` are used to cross-check it and
are trusted for nothing.

With `chromaticNumber_plane_ge_five` (M06–M09, de Grey's graph) this closes the classical
interval **`5 ≤ χ(ℝ²) ≤ 7`** kernel-side at both ends; the read-aloud statement is
`Instances/Interval.lean`.
-/

namespace HadwigerNelson

open SimpleGraph

/-- The coset brick family: `7 × 7` torus, cells `w × h`, row shear `s`, cell `(i, j)`
coloured `(i + c·j) mod 7`. The coefficient `c` is DATA so that the mutation audit below is
a numeral change — at `c = 3` the kernel of the colour map is an ideal of norm 7, and at
`c = 2` it is not an ideal at all (it contains `−2 + ζ₆`, of norm 3). -/
def cosetBrick (c : ℕ) (w h s : ℚ) (hw : 0 < w) (hh : 0 < h) : Brick 7 where
  m := 7
  n := 7
  w := w
  h := h
  s := s
  table := fun i j => ⟨(i.1 + c * j.1) % 7, by omega⟩
  m_pos := by decide
  n_pos := by decide
  w_pos := hw
  h_pos := hh

/-- **The seven-colouring**: `4/5 × 3/5` half-open cells, row shear `2/5`, colour
`(column + 3·row) mod 7`. The cell diagonal is exactly `1` — the 3–4–5 triangle. -/
def sevenBrick : Brick 7 := cosetBrick 3 (4/5) (3/5) (2/5) (by norm_num) (by norm_num)

/-- The certificate passes with the properness guard. ONE kernel decide over the computed
window (9 × 11 offsets, a 49-cell table scan each). -/
theorem sevenBrick_check : sevenBrick.check [1] = true := by decide +kernel

/-- **`χ(ℝ²) ≤ 7`.** The plane's unit-distance graph is 7-colourable: there is an
assignment of seven colours to every point of the plane under which no two points at
distance exactly 1 share a colour. -/
theorem plane_colorable_seven : (unitDistance ℂ).Colorable 7 :=
  sevenBrick.colorable (List.mem_singleton.mpr rfl) sevenBrick_check

/-- The same bound over the plane in its standard presentation, `EuclideanSpace ℝ (Fin 2)`
— the carrier `chromaticNumber_plane_ge_five` uses. -/
theorem chromaticNumber_plane_le_seven :
    (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber ≤ 7 := by
  rw [← chromaticNumber_unitDistance_congr Complex.orthonormalBasisOneI.repr.toIsometryEquiv]
  exact plane_colorable_seven.chromaticNumber_le

/-! ### Controls — compiled, every build

The boundary-tightness of the certificate is the milestone's load-bearing fact, so it is
pinned twice (both ends, exactly `1`), and the geometry and the coset coefficient are each
mutated and seen to refuse. -/

-- the computable twin agrees with the design script's exact samples (build/m36-design.py)
#guard sevenBrick.colorQ 0 0 = (0 : Fin 7)
#guard sevenBrick.colorQ (4/5) 0 = (1 : Fin 7)
#guard sevenBrick.colorQ 0 (3/5) = (2 : Fin 7)
#guard sevenBrick.colorQ (8/5) (6/5) = (0 : Fin 7)
#guard sevenBrick.colorQ (-1/5) 0 = (6 : Fin 7)
#guard sevenBrick.colorQ 2 2 = (3 : Fin 7)
#guard sevenBrick.colorQ (-4/5) (-3/5) = (3 : Fin 7)

-- BOUNDARY-TIGHT, both ends, exactly at the guard: the cell's own diagonal reaches `1`,
-- and the nearest same-coloured cell (offset `(1, 2)`, translation `(8/5, 6/5)`) closes to
-- exactly `1`. A strictly-separating certificate accepts neither.
#guard sevenBrick.hiAt 0 0 = 1
#guard sevenBrick.loAt 1 2 = 1

-- the geometry is load-bearing in BOTH directions: a shorter cell (diagonal² = 89/100 < 1)
-- lets the `(1, 2)` offset straddle the guard, a wider one (34/25 > 1) lets the cell's own
-- diagonal straddle it
#guard (cosetBrick 3 (4/5) (1/2) (2/5) (by norm_num) (by norm_num)).check [1] = false
#guard (cosetBrick 3 1 (3/5) (1/2) (by norm_num) (by norm_num)).check [1] = false

-- the coset coefficient is load-bearing: at 2 the colour map's kernel is not an ideal and
-- contains a vector of norm 3, so a same-coloured pair sits far inside the unit distance
#guard (cosetBrick 2 (4/5) (3/5) (2/5) (by norm_num) (by norm_num)).check [1] = false

-- the shear is load-bearing: unstaggered rows are not the hexagonal lattice
#guard (cosetBrick 3 (4/5) (3/5) 0 (by norm_num) (by norm_num)).check [1] = false

-- the CONJUGATE coset map certifies too, at this shear and at `w/3` — the second root of
-- `x² − x + 1` in `𝔽₇`, so the docstring's algebra is pinned and not merely asserted. The
-- `w/3` row is also the pipeline end to end: `tools/periodic.py` FOUND that table by SAT,
-- `build/m36-design.py` re-derived it, and the kernel accepts it here.
#guard (cosetBrick 5 (4/5) (3/5) (2/5) (by norm_num) (by norm_num)).check [1] = true
#guard (cosetBrick 5 (4/5) (3/5) (4/15) (by norm_num) (by norm_num)).check [1] = true

-- and the coefficients that are NOT ideal fail at every shear tried (build/m36-design.py
-- reports the full 7 × 5 census; c = 3 and c = 5 are the only ones that ever pass)
#guard (cosetBrick 4 (4/5) (3/5) (2/5) (by norm_num) (by norm_num)).check [1] = false
#guard (cosetBrick 6 (4/5) (3/5) (2/5) (by norm_num) (by norm_num)).check [1] = false

-- the adversarial member: one colour everywhere must fail
#guard ({ sevenBrick with table := fun _ _ => 0 } : Brick 7).check [1] = false

-- and the degenerate guard, which the boundary-tight certificate would otherwise accept
-- at the self-offset: refused, so `sound` can never be handed it
#guard sevenBrick.check [0] = false

end HadwigerNelson
