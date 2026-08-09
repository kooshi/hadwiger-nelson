import Proofs.HadwigerNelson.MetaLadder

/-!
# M26 — The hexagram: six pivots and the metapivot, closed under all unit chords

The **hexagram**: the M24 ladders of the six pivots of the hexagon of circumradius
1/√3 about the metapivot `m = (1+ζ₆)/3` — the triangle `{0, 1, ζ₆}` PLUS its
point-reflection through `m`, the mirror centroids `{2m, 2m−1, 2m−ζ₆}` — together
with the metapivot's own ladder (M25's).  Fourteen `outerPt`/`innerPt` families.

**The self-seeding definition.**  The six pivots ARE the meta-inner hex layer at
seam height zero: `hexPivot a := innerPt m metaAnchor a 0` runs
`2m, ζ₆, 2m−1, 0, 2m−ζ₆, 1` as `a = 0..5` — the odd addresses are the M25 triangle,
the even addresses the mirror centroids, and M23's glue-point certification becomes
an address bookkeeping fact.  The 60° rotation about `m` (`rot6`) cycles the pivots
at address `+1`, squares to M25's 120° transport, and carries every ladder family to
a ladder family — so the 21 centre pairs fall into FOUR orbits (unit, adjacent,
opposite, pivot–meta) and only the adjacent and opposite master webs are new.

Census (§0, exact, B = 30, commit-registered predictions; the rot6 relabelling
verified as an automorphism of the whole exact edge set): the two new webs carry
**sixteen chords total** — adjacent oo is EMPTY, adjacent oi/io/ii and opposite oo
are four sporadics each (all |b| ≤ 2), opposite oi/io/ii are EMPTY, and all eight
new fusion families are EMPTY (the triple tangency at `m` is invisible: `m` is
never a lattice point).  Colour probe: k = 3 UNSAT (control), k = 4 SAT, and a
rot6-**equivariant** table exists — `colour(rot6 z) = τ(colour z)` for the 3-cycle
`τ = (0 1 2)` — so properness runs on orbit representatives.

**The engine** is M25's unchanged: the new separations clear through `g = 1 + ζ₆`
(`3·(q₂ − 0) = ḡ`, `3·(q₀ − 0) = 2g`), so every new master is a `ℤ[√3]`-combination
of `hexTrace` pairs over `ℤ[ζ₆, π]` — the opposite web at REFLECTED addresses
(`Tr(g·w̄)`, the `gTrace_clear_neg` currency) with doubled coefficients.
-/

namespace HadwigerNelson
namespace Hexagram

open Complex TwoCircle Ladder MetaLadder

/-! ## §0 Shared arithmetic (the house pattern: tiny facts re-derived locally) -/

private theorem sq_sqrt3 : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sqrt3_cast_sq : ((Real.sqrt 3 : ℝ) : ℂ) * ((Real.sqrt 3 : ℝ) : ℂ) = 3 := by
  rw [← Complex.ofReal_mul, sq_sqrt3]
  norm_num

private theorem sqrt3_ne : ((Real.sqrt 3 : ℝ) : ℂ) ≠ 0 := fun h => by
  have := sqrt3_cast_sq
  rw [h, zero_mul] at this
  norm_num at this

private theorem word_k0 (k : ZMod 6) : word k 0 = zeta6 ^ (k.val : ℤ) := by
  rw [word, zpow_zero, mul_one]

private theorem zeta6_minpoly : zeta6 ^ 2 - zeta6 + 1 = 0 := by
  rw [zeta6, pow_two]
  apply Complex.ext <;>
    simp only [Complex.mul_re, Complex.mul_im, Complex.sub_re, Complex.sub_im,
      Complex.add_re, Complex.add_im, Complex.one_re, Complex.one_im, Complex.zero_re,
      Complex.zero_im] <;> nlinarith [sq_sqrt3]

private theorem zeta6_cube' : zeta6 ^ 3 = -1 := by
  linear_combination (zeta6 + 1) * zeta6_minpoly

/-! ## §H The object -/

/-- The six hexagram pivots, indexed by their meta-inner hex address:
`a = 0..5` runs `2m, ζ₆, 2m−1, 0, 2m−ζ₆, 1` — the M25 triangle at odd addresses,
the mirror centroids at even ones. -/
noncomputable def hexPivot (a : ZMod 6) : ℂ := innerPt metaPivot metaAnchor a 0

/-- **The self-seeding identity**: the pivot hexagon is the metapivot's inner hex
layer, `hexPivot a = m·(1 + ζ₆^a)` — every hexagram coordinate is one metapivot
multiplication away from a hex root. -/
theorem hexPivot_eq (a : ZMod 6) : hexPivot a = metaPivot * (1 + word a 0) := by
  rw [hexPivot, innerPt, metaAnchor_sub]
  linear_combination -(word a 0) * meta_eq

/-- `3m = g = 1 + ζ₆`: the metapivot cleared of its denominator. -/
theorem three_metaPivot : 3 * metaPivot = 1 + zeta6 := by
  rw [meta_eq_centroid]; ring

private theorem three_hexPivot (a : ZMod 6) :
    3 * hexPivot a = (1 + zeta6) * (1 + word a 0) := by
  rw [hexPivot_eq, ← three_metaPivot]; ring

private theorem word_pow (k : ℕ) (hk : k < 6) : word (k : ZMod 6) 0 = zeta6 ^ k := by
  rw [word_k0, show (((k : ZMod 6)).val : ℤ) = (k : ℤ) by
    rw [ZMod.val_natCast_of_lt hk], zpow_natCast]

/-- Address 3 is the pivot `0` — M25's hub fact, verbatim. -/
theorem hexPivot_three : hexPivot 3 = 0 := metaInner_hub

theorem hexPivot_five : hexPivot 5 = 1 := by
  have h : word 5 0 = 1 - zeta6 := by
    rw [show (5 : ZMod 6) = ((5 : ℕ) : ZMod 6) from rfl, word_pow 5 (by norm_num),
      show (5 : ℕ) = 3 + 2 from rfl, pow_add, zeta6_cube']
    linear_combination -zeta6_minpoly
  have h3 := three_hexPivot 5
  rw [h] at h3
  have : (3 : ℂ) * hexPivot 5 = 3 * 1 := by
    rw [h3]; linear_combination -zeta6_minpoly
  exact mul_left_cancel₀ (by norm_num : (3 : ℂ) ≠ 0) this

theorem hexPivot_one : hexPivot 1 = zeta6 := by
  have h : word 1 0 = zeta6 := by
    rw [show (1 : ZMod 6) = ((1 : ℕ) : ZMod 6) from rfl, word_pow 1 (by norm_num), pow_one]
  have h3 := three_hexPivot 1
  rw [h] at h3
  have : (3 : ℂ) * hexPivot 1 = 3 * zeta6 := by
    rw [h3]; linear_combination zeta6_minpoly
  exact mul_left_cancel₀ (by norm_num : (3 : ℂ) ≠ 0) this

theorem hexPivot_zero : hexPivot 0 = 2 * metaPivot := by
  rw [hexPivot_eq, show word (0 : ZMod 6) 0 = 1 by
    rw [show (0 : ZMod 6) = ((0 : ℕ) : ZMod 6) from rfl, word_pow 0 (by norm_num), pow_zero]]
  ring

theorem hexPivot_two : hexPivot 2 = 2 * metaPivot - 1 := by
  have h : word 2 0 = zeta6 ^ 2 := by
    rw [show (2 : ZMod 6) = ((2 : ℕ) : ZMod 6) from rfl, word_pow 2 (by norm_num)]
  have h3 := three_hexPivot 2
  rw [h] at h3
  have hm := three_metaPivot
  have : (3 : ℂ) * hexPivot 2 = 3 * (2 * metaPivot - 1) := by
    rw [h3]
    linear_combination (zeta6 + 2) * zeta6_minpoly - 2 * hm
  exact mul_left_cancel₀ (by norm_num : (3 : ℂ) ≠ 0) this

theorem hexPivot_four : hexPivot 4 = 2 * metaPivot - zeta6 := by
  have h : word 4 0 = -zeta6 := by
    rw [show (4 : ZMod 6) = ((4 : ℕ) : ZMod 6) from rfl, word_pow 4 (by norm_num),
      show (4 : ℕ) = 3 + 1 from rfl, pow_add, zeta6_cube', pow_one]
    ring
  have h3 := three_hexPivot 4
  rw [h] at h3
  have hm := three_metaPivot
  have : (3 : ℂ) * hexPivot 4 = 3 * (2 * metaPivot - zeta6) := by
    rw [h3]
    linear_combination -zeta6_minpoly - 2 * hm
  exact mul_left_cancel₀ (by norm_num : (3 : ℂ) ≠ 0) this

/-- The pivot difference in closed form: `hexPivot (a+c) − hexPivot a
= m·ζ₆^a·(ζ₆^c − 1)` — the one computation behind every distance below. -/
theorem hexPivot_sub (a c : ZMod 6) :
    hexPivot (a + c) - hexPivot a = metaPivot * word a 0 * (word c 0 - 1) := by
  rw [hexPivot_eq, hexPivot_eq, show word (a + c) 0 = word a 0 * word c 0 by
    rw [← word_add, add_zero]]
  ring

private theorem normSq_metaPivot : normSq metaPivot = 1 / 3 := by
  rw [metaPivot, normSq_apply]
  show (1 : ℝ) / 2 * (1 / 2) + Real.sqrt 3 / 6 * (Real.sqrt 3 / 6) = 1 / 3
  nlinarith [sq_sqrt3]

private theorem norm_metaPivot : ‖metaPivot‖ = Real.sqrt 3 / 3 := by
  rw [Complex.norm_def, normSq_metaPivot,
    show (1 : ℝ) / 3 = (Real.sqrt 3 / 3) ^ 2 by nlinarith [sq_sqrt3],
    Real.sqrt_sq (by positivity)]

/-- The distance between two pivots is `‖ζ₆^c − 1‖/√3` — one lemma, five instances. -/
theorem dist_hexPivot (a c : ZMod 6) :
    dist (hexPivot (a + c)) (hexPivot a) = Real.sqrt 3 / 3 * ‖word c 0 - 1‖ := by
  rw [dist_eq_norm, hexPivot_sub, norm_mul, norm_mul, word_norm, mul_one, norm_metaPivot]

/-- Every pivot's anchor partner sits one unit away: the six ladders are M24
families. -/
theorem dist_hexPivot_anchor (a : ZMod 6) : dist (hexPivot a) (hexPivot a + 1) = 1 := by
  rw [dist_eq_norm, show hexPivot a - (hexPivot a + 1) = -1 by ring, norm_neg, norm_one]

/-- Second neighbours are unit-separated: the six unit pairs of the hexagram. -/
theorem dist_hexPivot_unit (a : ZMod 6) :
    dist (hexPivot (a + 2)) (hexPivot a) = 1 := by
  have hw : word (2 : ZMod 6) 0 - 1 = zeta6 ^ 2 - 1 := by
    rw [show (2 : ZMod 6) = ((2 : ℕ) : ZMod 6) from rfl, word_pow 2 (by norm_num)]
  have hn : ‖zeta6 ^ 2 - 1‖ = Real.sqrt 3 := by
    rw [Complex.norm_def, show normSq (zeta6 ^ 2 - 1) = 3 by
      rw [show zeta6 ^ 2 - 1 = zeta6 - 2 by linear_combination zeta6_minpoly, zeta6, normSq_apply]
      show (1 / 2 - 2 : ℝ) * (1 / 2 - 2) + (Real.sqrt 3 / 2 - 0) * (Real.sqrt 3 / 2 - 0) = 3
      nlinarith [sq_sqrt3]]
  rw [dist_hexPivot, hw, hn]
  nlinarith [sq_sqrt3, Real.sqrt_nonneg 3]

/-- Hexagon neighbours sit at the inner radius. -/
theorem dist_hexPivot_adjacent (a : ZMod 6) :
    dist (hexPivot (a + 1)) (hexPivot a) = Real.sqrt 3 / 3 := by
  have hw : word (1 : ZMod 6) 0 - 1 = zeta6 - 1 := by
    rw [show (1 : ZMod 6) = ((1 : ℕ) : ZMod 6) from rfl, word_pow 1 (by norm_num), pow_one]
  have hn : ‖zeta6 - 1‖ = 1 := by
    rw [Complex.norm_def, show normSq (zeta6 - 1) = 1 by
      rw [zeta6, normSq_apply]
      show (1 / 2 - 1 : ℝ) * (1 / 2 - 1) + (Real.sqrt 3 / 2 - 0) * (Real.sqrt 3 / 2 - 0) = 1
      nlinarith [sq_sqrt3], Real.sqrt_one]
  rw [dist_hexPivot, hw, hn, mul_one]

/-- Every pivot sits at the inner radius from the metapivot. -/
theorem dist_hexPivot_meta (a : ZMod 6) :
    dist (hexPivot a) metaPivot = Real.sqrt 3 / 3 := by
  rw [dist_eq_norm, hexPivot_eq, show metaPivot * (1 + word a 0) - metaPivot
    = metaPivot * word a 0 by ring, norm_mul, word_norm, mul_one, norm_metaPivot]

/-- Opposite pivots sit at twice the inner radius — the tangency distance. -/
theorem dist_hexPivot_opposite (a : ZMod 6) :
    dist (hexPivot (a + 3)) (hexPivot a) = 2 * (Real.sqrt 3 / 3) := by
  have hw : word (3 : ZMod 6) 0 - 1 = -2 := by
    rw [show (3 : ZMod 6) = ((3 : ℕ) : ZMod 6) from rfl, word_pow 3 (by norm_num), zeta6_cube']
    ring
  rw [dist_hexPivot, hw, show ‖(-2 : ℂ)‖ = 2 by
    rw [show (-2 : ℂ) = ((-2 : ℝ) : ℂ) by norm_num, Complex.norm_real]; norm_num]
  ring

/-- The hexagram: the six pivot ladders (outer and inner) and the metapivot's. -/
noncomputable def hexagram : Set ℂ :=
  (⋃ a : ZMod 6, ({z | ∃ x b, z = outerPt (hexPivot a) (hexPivot a + 1) x b}
    ∪ {z | ∃ x b, z = innerPt (hexPivot a) (hexPivot a + 1) x b}))
  ∪ ({z | ∃ x b, z = outerPt metaPivot metaAnchor x b}
    ∪ {z | ∃ x b, z = innerPt metaPivot metaAnchor x b})

theorem outer_mem_hexagram (a : ZMod 6) (x : ZMod 6) (b : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b ∈ hexagram :=
  Or.inl (Set.mem_iUnion.mpr ⟨a, Or.inl ⟨x, b, rfl⟩⟩)

theorem inner_mem_hexagram (a : ZMod 6) (x : ZMod 6) (b : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b ∈ hexagram :=
  Or.inl (Set.mem_iUnion.mpr ⟨a, Or.inr ⟨x, b, rfl⟩⟩)

theorem metaOuter_mem_hexagram (x : ZMod 6) (b : ℤ) :
    outerPt metaPivot metaAnchor x b ∈ hexagram := Or.inr (Or.inl ⟨x, b, rfl⟩)

theorem metaInner_mem_hexagram (x : ZMod 6) (b : ℤ) :
    innerPt metaPivot metaAnchor x b ∈ hexagram := Or.inr (Or.inr ⟨x, b, rfl⟩)

/-- M25's four-ladder object is the sub-object at pivot addresses `{3, 5, 1}` plus
the meta ladder: the χ ≥ 4 witness transports. -/
theorem fourLadder_subset_hexagram : fourLadder ⊆ hexagram := sorry

/-! ## §T Transport: the 60° rotation about the metapivot -/

private theorem word_succ' (x : ZMod 6) (b : ℤ) : word (x + 1) b = zeta6 * word x b := by
  have h : word (x + 1) (b + 0) = word x b * word 1 0 := word_add x 1 b 0
  rw [add_zero] at h
  rw [h, show word (1 : ZMod 6) 0 = zeta6 by
    rw [show (1 : ZMod 6) = ((1 : ℕ) : ZMod 6) from rfl, word_pow 1 (by norm_num), pow_one]]
  ring

private theorem normSq_zeta6 : normSq zeta6 = 1 := by
  rw [zeta6, normSq_apply]
  show (1 : ℝ) / 2 * (1 / 2) + Real.sqrt 3 / 2 * (Real.sqrt 3 / 2) = 1
  nlinarith [sq_sqrt3]

private theorem norm_zeta6 : ‖zeta6‖ = 1 := by
  rw [Complex.norm_def, normSq_zeta6, Real.sqrt_one]

private theorem zeta6_ne_zero : zeta6 ≠ 0 := fun h => by
  have := normSq_zeta6
  rw [h, map_zero] at this
  norm_num at this

/-- The 60° rotation about the metapivot — the hexagram's cyclic symmetry, the
square root of M25's 120° transport. -/
noncomputable def rot6 (z : ℂ) : ℂ := metaPivot + zeta6 * (z - metaPivot)

theorem dist_rot6 (z w : ℂ) : dist (rot6 z) (rot6 w) = dist z w := by
  rw [dist_eq_norm, dist_eq_norm, rot6, rot6,
    show metaPivot + zeta6 * (z - metaPivot) - (metaPivot + zeta6 * (w - metaPivot))
      = zeta6 * (z - w) by ring, norm_mul, norm_zeta6, one_mul]

theorem rot6_inj {z w : ℂ} (h : rot6 z = rot6 w) : z = w := by
  rw [rot6, rot6] at h
  have h2 : zeta6 * (z - metaPivot) = zeta6 * (w - metaPivot) := by linear_combination h
  have h3 := mul_left_cancel₀ zeta6_ne_zero h2
  linear_combination h3

/-- Two steps of `rot6` are M25's 120° rotation — the transport kits compose. -/
theorem rot6_rot6 (z : ℂ) :
    rot6 (rot6 z) = metaPivot + zeta6 ^ 2 * (z - metaPivot) := by
  rw [rot6, rot6]; ring

/-- `rot6` cycles the pivots along the meta-inner address. -/
theorem rot6_hexPivot (a : ZMod 6) : rot6 (hexPivot a) = hexPivot (a + 1) := by
  rw [rot6, hexPivot_eq, hexPivot_eq, word_succ']
  ring

/-- `rot6` carries pivot `a`'s outer ladder to pivot `a+1`'s at address `+1`. -/
theorem rot6_outer (a : ZMod 6) (x : ZMod 6) (b : ℤ) :
    rot6 (outerPt (hexPivot a) (hexPivot a + 1) x b)
      = outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) (x + 1) b := by
  rw [outerPt, outerPt, ← rot6_hexPivot, rot6, rot6, word_succ']
  ring

theorem rot6_inner (a : ZMod 6) (x : ZMod 6) (b : ℤ) :
    rot6 (innerPt (hexPivot a) (hexPivot a + 1) x b)
      = innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) (x + 1) b := by
  rw [innerPt, innerPt, ← rot6_hexPivot, rot6, rot6, word_succ']
  ring

/-- `rot6` fixes the metapivot's ladder up to the `+1` shift. -/
theorem rot6_metaOuter (x : ZMod 6) (b : ℤ) :
    rot6 (outerPt metaPivot metaAnchor x b)
      = outerPt metaPivot metaAnchor (x + 1) b := by
  rw [outerPt, outerPt, rot6, word_succ']
  ring

theorem rot6_metaInner (x : ZMod 6) (b : ℤ) :
    rot6 (innerPt metaPivot metaAnchor x b)
      = innerPt metaPivot metaAnchor (x + 1) b := by
  rw [innerPt, innerPt, rot6, word_succ']
  ring

/-- The iterated transports: `rot6^[k]` shifts the pivot index and the hex address
by `k`.  The uniform-in-`a` engine behind every web wrapper below. -/
private theorem rot6_iter_outer (k : ℕ) (a x : ZMod 6) (b : ℤ) :
    rot6^[k] (outerPt (hexPivot a) (hexPivot a + 1) x b)
      = outerPt (hexPivot (a + (k : ZMod 6))) (hexPivot (a + (k : ZMod 6)) + 1)
        (x + (k : ZMod 6)) b := by
  induction k with
  | zero => simp
  | succ j ih =>
    rw [Function.iterate_succ_apply', ih, rot6_outer]
    push_cast
    rw [show a + (j : ZMod 6) + 1 = a + ((j : ZMod 6) + 1) by ring,
      show x + (j : ZMod 6) + 1 = x + ((j : ZMod 6) + 1) by ring]

private theorem rot6_iter_inner (k : ℕ) (a x : ZMod 6) (b : ℤ) :
    rot6^[k] (innerPt (hexPivot a) (hexPivot a + 1) x b)
      = innerPt (hexPivot (a + (k : ZMod 6))) (hexPivot (a + (k : ZMod 6)) + 1)
        (x + (k : ZMod 6)) b := by
  induction k with
  | zero => simp
  | succ j ih =>
    rw [Function.iterate_succ_apply', ih, rot6_inner]
    push_cast
    rw [show a + (j : ZMod 6) + 1 = a + ((j : ZMod 6) + 1) by ring,
      show x + (j : ZMod 6) + 1 = x + ((j : ZMod 6) + 1) by ring]

private theorem rot6_iter_metaOuter (k : ℕ) (x : ZMod 6) (b : ℤ) :
    rot6^[k] (outerPt metaPivot metaAnchor x b)
      = outerPt metaPivot metaAnchor (x + (k : ZMod 6)) b := by
  induction k with
  | zero => simp
  | succ j ih =>
    rw [Function.iterate_succ_apply', ih, rot6_metaOuter]
    push_cast
    rw [show x + (j : ZMod 6) + 1 = x + ((j : ZMod 6) + 1) by ring]

private theorem rot6_iter_metaInner (k : ℕ) (x : ZMod 6) (b : ℤ) :
    rot6^[k] (innerPt metaPivot metaAnchor x b)
      = innerPt metaPivot metaAnchor (x + (k : ZMod 6)) b := by
  induction k with
  | zero => simp
  | succ j ih =>
    rw [Function.iterate_succ_apply', ih, rot6_metaInner]
    push_cast
    rw [show x + (j : ZMod 6) + 1 = x + ((j : ZMod 6) + 1) by ring]

private theorem dist_rot6_iter (k : ℕ) (z w : ℂ) :
    dist (rot6^[k] z) (rot6^[k] w) = dist z w := by
  induction k with
  | zero => simp
  | succ j ih => rw [Function.iterate_succ_apply', Function.iterate_succ_apply', dist_rot6, ih]

private theorem rot6_iter_inj {k : ℕ} {z w : ℂ} (h : rot6^[k] z = rot6^[k] w) : z = w := by
  induction k with
  | zero => simpa using h
  | succ j ih =>
    rw [Function.iterate_succ_apply', Function.iterate_succ_apply'] at h
    exact ih (rot6_inj h)

/-! ## §E The engine: one master, eight bridges

Both new axes clear into the SAME shape — `α·g·u − β·g·v − γ` with `α, β, γ` real —
because `ζ₁₂·g = √3·ζ₆` and the two separations are `3·(hexPivot 4) = ḡ` (adjacent)
and `3·(hexPivot 0) = 2g` (opposite).  Expanding its norm gives a constant plus
three conjugate pairs: the `g`-traces of `u` and `v`, and the plain trace of `u v̄`.
One lemma covers all eight families; the family only fixes `(α, β, γ, R)`. -/

private theorem word_mul_inv' (a : ZMod 6) (b : ℤ) : word a b * word (-a) (-b) = 1 := by
  rw [← word_add, add_neg_cancel, add_neg_cancel, word]
  simp

private theorem word_mul_neg' (a c : ZMod 6) (b d : ℤ) :
    word a b * word (-c) (-d) = word (a - c) (b - d) := by
  rw [← word_add, sub_eq_add_neg, sub_eq_add_neg]

/-- **The M26 master identity**: the norm equation of either new axis, expanded. -/
theorem hex_master {x y : ZMod 6} {b d : ℤ} {α β γ R : ℝ}
    (h : normSq ((α : ℂ) * gC * word x b - (β : ℂ) * gC * word y d - (γ : ℂ)) = R) :
    ((3 * α ^ 2 + 3 * β ^ 2 + γ ^ 2 - R : ℝ) : ℂ)
      - (α : ℂ) * (γ : ℂ) * gTr x b + (β : ℂ) * (γ : ℂ) * gTr y d
      - 3 * ((α : ℂ) * (β : ℂ)) * uTr (x - y) (b - d) = 0 := by
  have hu := word_mul_inv' x b
  have hv := word_mul_inv' y d
  have hX1 := word_mul_neg' x y b d
  have hX2 := word_mul_neg' y x d b
  have hX := Complex.mul_conj ((α : ℂ) * gC * word x b - (β : ℂ) * gC * word y d - (γ : ℂ))
  rw [h, map_sub, map_sub, map_mul, map_mul, map_mul, map_mul, gC_conj, Complex.conj_ofReal,
    Complex.conj_ofReal, Complex.conj_ofReal, word_conj, word_conj] at hX
  rw [gTr, gTr, uTr, show (-(x - y) : ZMod 6) = y - x by ring, show -(b - d) = d - b by ring]
  push_cast
  linear_combination (norm := (push_cast; ring)) hX
    - (α : ℂ) ^ 2 * (word x b * word (-x) (-b)) * gC_mul_gB - 3 * (α : ℂ) ^ 2 * hu
    - (β : ℂ) ^ 2 * (word y d * word (-y) (-d)) * gC_mul_gB - 3 * (β : ℂ) ^ 2 * hv
    + (α : ℂ) * (β : ℂ) * (word x b * word (-y) (-d)) * gC_mul_gB
    + (α : ℂ) * (β : ℂ) * (word y d * word (-x) (-b)) * gC_mul_gB
    + 3 * ((α : ℂ) * (β : ℂ)) * hX1 + 3 * ((α : ℂ) * (β : ℂ)) * hX2

/-! ### §E.1 The two scalings -/

private theorem inner_cast' :
    ((Real.sqrt 3 / 3 : ℝ) : ℂ) = ((Real.sqrt 3 : ℝ) : ℂ) / 3 := by push_cast; ring

private theorem zeta12_gC : zeta12 * gC = ((Real.sqrt 3 : ℝ) : ℂ) * zeta6 := by
  rw [gC]
  linear_combination -zeta12 * sqrt3_mul_zeta12 + ((Real.sqrt 3 : ℝ) : ℂ) * zeta12_sq

private theorem gB_word (x : ZMod 6) (b : ℤ) : gB * word x b = gC * word (x - 1) b := by
  have h : word x b = zeta6 * word (x - 1) b := by
    have := word_succ' (x - 1) b
    rwa [sub_add_cancel] at this
  rw [h, gC, gB]
  linear_combination -(word (x - 1) b) * zeta6_minpoly

private theorem sqrt3_zeta6_hexPivot_four :
    ((Real.sqrt 3 : ℝ) : ℂ) * zeta6 * hexPivot 4 = zeta12 := by
  have hw : word (4 : ZMod 6) 0 = -zeta6 := by
    rw [show (4 : ZMod 6) = ((4 : ℕ) : ZMod 6) from rfl, word_pow 4 (by norm_num),
      show (4 : ℕ) = 3 + 1 from rfl, pow_add, zeta6_cube', pow_one]
    ring
  rw [hexPivot_eq, hw, meta_eq, inner_cast']
  linear_combination (zeta6 * zeta12 * (1 - zeta6) / 3) * sqrt3_cast_sq
    - zeta12 * zeta6_minpoly

private theorem sqrt3_hexPivot_zero :
    ((Real.sqrt 3 : ℝ) : ℂ) * hexPivot 0 = 2 * zeta12 := by
  have hw : word (0 : ZMod 6) 0 = 1 := by
    rw [show (0 : ZMod 6) = ((0 : ℕ) : ZMod 6) from rfl, word_pow 0 (by norm_num), pow_zero]
  rw [hexPivot_eq, hw, meta_eq, inner_cast']
  linear_combination (2 * zeta12 / 3) * sqrt3_cast_sq

/-- The adjacent scaling: `√3·ζ₆` carries the difference onto the master shape. -/
private theorem scale_adj (r₁ r₂ u v : ℂ) :
    ((Real.sqrt 3 : ℝ) : ℂ) * zeta6 * ((hexPivot 3 + r₁ * u) - (hexPivot 4 + r₂ * v))
      = zeta12 * (r₁ * gC * u - r₂ * gC * v - 1) := by
  rw [hexPivot_three, zero_add]
  linear_combination -(r₁ * u - r₂ * v) * zeta12_gC - sqrt3_zeta6_hexPivot_four

/-- The opposite scaling: `√3` alone, at the `−1`-shifted addresses. -/
private theorem scale_opp (r₁ r₂ u v : ℂ) :
    ((Real.sqrt 3 : ℝ) : ℂ) * ((hexPivot 3 + r₁ * u) - (hexPivot 0 + r₂ * v))
      = zeta12 * (r₁ * gB * u - r₂ * gB * v - 2) := by
  rw [hexPivot_three, zero_add]
  have hgb : zeta12 * gB = ((Real.sqrt 3 : ℝ) : ℂ) := by
    have h1 := zeta12_gC
    have h2 : gC = zeta6 * gB := by rw [gC, gB]; linear_combination zeta6_minpoly
    rw [h2] at h1
    have hz : zeta6 * (zeta12 * gB) = zeta6 * ((Real.sqrt 3 : ℝ) : ℂ) := by
      linear_combination h1
    exact mul_left_cancel₀ zeta6_ne_zero hz
  linear_combination -(r₁ * u - r₂ * v) * hgb - sqrt3_hexPivot_zero

/-! ### §E.2 The chord and fusion bridges -/

private theorem zeta12_ne_zero' : zeta12 ≠ 0 := fun h => by
  have hn := normSq_zeta12
  rw [h, map_zero] at hn
  norm_num at hn

private theorem hex_fusion_gen {P Q k Z : ℂ} (hk : k ≠ 0)
    (h : k * (P - Q) = zeta12 * Z) : P = Q ↔ normSq Z = 0 := by
  constructor
  · intro he
    rw [he, sub_self, mul_zero] at h
    rcases mul_eq_zero.mp h.symm with h0 | h0
    · exact absurd h0 zeta12_ne_zero'
    · rw [h0, map_zero]
  · intro h0
    obtain hz : Z = 0 := Complex.normSq_eq_zero.mp h0
    rw [hz, mul_zero] at h
    rcases mul_eq_zero.mp h with h1 | h1
    · exact absurd h1 hk
    · exact sub_eq_zero.mp h1

private theorem normSq_sqrt3_zeta6 :
    normSq (((Real.sqrt 3 : ℝ) : ℂ) * zeta6) = 3 := by
  rw [map_mul, normSq_zeta6, mul_one, normSq_apply]
  show (Real.sqrt 3) * (Real.sqrt 3) + 0 * 0 = 3
  rw [sq_sqrt3]; ring

private theorem normSq_three_zeta6 : normSq ((3 : ℂ) * zeta6) = 9 := by
  rw [map_mul, normSq_zeta6, mul_one, normSq_apply]
  norm_num

private theorem normSq_sqrt3' : normSq ((Real.sqrt 3 : ℝ) : ℂ) = 3 := by
  rw [normSq_apply]
  show (Real.sqrt 3) * (Real.sqrt 3) + 0 * 0 = 3
  rw [sq_sqrt3]; ring

private theorem normSq_three' : normSq (3 : ℂ) = 9 := by
  rw [normSq_apply]; norm_num

private theorem sqrt3_zeta6_ne : ((Real.sqrt 3 : ℝ) : ℂ) * zeta6 ≠ 0 :=
  mul_ne_zero sqrt3_ne zeta6_ne_zero

private theorem three_zeta6_ne : (3 : ℂ) * zeta6 ≠ 0 :=
  mul_ne_zero (by norm_num) zeta6_ne_zero

private theorem outerPt_anchor (p : ℂ) (x : ZMod 6) (b : ℤ) :
    outerPt p (p + 1) x b = p + word x b := by
  rw [outerPt, add_sub_cancel_left, mul_one]

private theorem innerPt_anchor (p : ℂ) (x : ZMod 6) (b : ℤ) :
    innerPt p (p + 1) x b = p + ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word x b := by
  rw [innerPt, add_sub_cancel_left, mul_one]

/-! ### §E.3 The bridges, radius-parameterized

`r₁, r₂ ∈ {1, 1/√3}` selects outer/inner, so ONE bridge per axis and direction
covers all eight families. -/

/-- The adjacent chord bridge: `dist = 1` iff the cleared expression has norm 3. -/
theorem bridge_adj (r₁ r₂ : ℝ) (x y : ZMod 6) (b d : ℤ) :
    dist (hexPivot 3 + (r₁ : ℂ) * word x b) (hexPivot 4 + (r₂ : ℂ) * word y d) = 1 ↔
      normSq ((r₁ : ℂ) * gC * word x b - (r₂ : ℂ) * gC * word y d - ((1 : ℝ) : ℂ)) = 3 := by
  refine bridge_gen sqrt3_zeta6_ne normSq_sqrt3_zeta6 ?_
  have h := scale_adj (r₁ : ℂ) (r₂ : ℂ) (word x b) (word y d)
  push_cast at h ⊢
  linear_combination h

/-- The adjacent fusion bridge: coincidence iff the cleared expression has norm 0. -/
theorem fusion_adj (r₁ r₂ : ℝ) (x y : ZMod 6) (b d : ℤ) :
    hexPivot 3 + (r₁ : ℂ) * word x b = hexPivot 4 + (r₂ : ℂ) * word y d ↔
      normSq ((r₁ : ℂ) * gC * word x b - (r₂ : ℂ) * gC * word y d - ((1 : ℝ) : ℂ)) = 0 := by
  refine hex_fusion_gen sqrt3_zeta6_ne ?_
  have h := scale_adj (r₁ : ℂ) (r₂ : ℂ) (word x b) (word y d)
  push_cast at h ⊢
  linear_combination h

/-- The opposite chord bridge, at the `−1`-shifted addresses. -/
theorem bridge_opp (r₁ r₂ : ℝ) (x y : ZMod 6) (b d : ℤ) :
    dist (hexPivot 3 + (r₁ : ℂ) * word x b) (hexPivot 0 + (r₂ : ℂ) * word y d) = 1 ↔
      normSq ((r₁ : ℂ) * gC * word (x - 1) b - (r₂ : ℂ) * gC * word (y - 1) d
        - ((2 : ℝ) : ℂ)) = 3 := by
  refine bridge_gen sqrt3_ne normSq_sqrt3' ?_
  have h := scale_opp (r₁ : ℂ) (r₂ : ℂ) (word x b) (word y d)
  rw [show (r₁ : ℂ) * gB * word x b = (r₁ : ℂ) * (gB * word x b) by ring, gB_word,
    show (r₂ : ℂ) * gB * word y d = (r₂ : ℂ) * (gB * word y d) by ring, gB_word] at h
  push_cast at h ⊢
  linear_combination h

/-- The opposite fusion bridge. -/
theorem fusion_opp (r₁ r₂ : ℝ) (x y : ZMod 6) (b d : ℤ) :
    hexPivot 3 + (r₁ : ℂ) * word x b = hexPivot 0 + (r₂ : ℂ) * word y d ↔
      normSq ((r₁ : ℂ) * gC * word (x - 1) b - (r₂ : ℂ) * gC * word (y - 1) d
        - ((2 : ℝ) : ℂ)) = 0 := by
  refine hex_fusion_gen sqrt3_ne ?_
  have h := scale_opp (r₁ : ℂ) (r₂ : ℂ) (word x b) (word y d)
  rw [show (r₁ : ℂ) * gB * word x b = (r₁ : ℂ) * (gB * word x b) by ring, gB_word,
    show (r₂ : ℂ) * gB * word y d = (r₂ : ℂ) * (gB * word y d) by ring, gB_word] at h
  push_cast at h ⊢
  linear_combination h

/-! ### §E.4 The uniform cleared form

Every family's κ-equation is `C₁√3^{e₁}·gTr(X,b) + C₂√3^{e₂}·gTr(Y,d)
+ C₃√3^{e₃}·uTr(X−Y, b−d) = κ√3^{e₄}`; clearing by `√3^{|b|+|d|}` sends it to
three `hexTrace` objects at heights `|b|`, `|d|`, `|b−d|`. -/

local notation "s3" => ((Real.sqrt 3 : ℝ) : ℂ)

private theorem sqrt3_pow_two_mul' (k : ℕ) : s3 ^ (2 * k) = 3 ^ k := by
  rw [pow_mul, show s3 ^ 2 = 3 from by rw [pow_two]; exact sqrt3_cast_sq]

/-- The uniform clearing step. -/
theorem hex_cleared {X Y : ZMod 6} {b d : ℤ} {C₁ C₂ C₃ κ : ℤ} {e₁ e₂ e₃ e₄ t : ℕ}
    (ht : b.natAbs + d.natAbs = (b - d).natAbs + 2 * t)
    (h : (C₁ : ℂ) * s3 ^ e₁ * gTr X b + (C₂ : ℂ) * s3 ^ e₂ * gTr Y d
      + (C₃ : ℂ) * s3 ^ e₃ * uTr (X - Y) (b - d) = (κ : ℂ) * s3 ^ e₄) :
    (C₁ : ℂ) * s3 ^ (e₁ + d.natAbs)
        * hexTrace (gE (gAddr X b)) (gF (gAddr X b)) b.natAbs
      + (C₂ : ℂ) * s3 ^ (e₂ + b.natAbs)
        * hexTrace (gE (gAddr Y d)) (gF (gAddr Y d)) d.natAbs
      + (C₃ : ℂ) * s3 ^ e₃ * ((3 : ℂ) ^ t
        * hexTrace (hexE (uAddr (X - Y) (b - d)).val) (hexF (uAddr (X - Y) (b - d)).val)
          (b - d).natAbs)
      = (κ : ℂ) * s3 ^ (e₄ + b.natAbs + d.natAbs) := by
  have hA := gTrace_clear X b
  have hB := gTrace_clear Y d
  have hC := uTrace_clear (X - Y) (b - d)
  have hsum : s3 ^ (b.natAbs + d.natAbs)
      * ((C₁ : ℂ) * s3 ^ e₁ * gTr X b + (C₂ : ℂ) * s3 ^ e₂ * gTr Y d
        + (C₃ : ℂ) * s3 ^ e₃ * uTr (X - Y) (b - d))
      = s3 ^ (b.natAbs + d.natAbs) * ((κ : ℂ) * s3 ^ e₄) := by rw [h]
  have hpow2 : s3 ^ (2 * t) * s3 ^ (b - d).natAbs = s3 ^ (b.natAbs + d.natAbs) := by
    rw [← pow_add, show 2 * t + (b - d).natAbs = b.natAbs + d.natAbs by omega]
  rw [← hA, ← hB, ← hC, ← sqrt3_pow_two_mul' t]
  linear_combination (norm := (push_cast; ring_nf; try rfl)) hsum
    + (C₃ : ℂ) * s3 ^ e₃ * uTr (X - Y) (b - d) * hpow2

/-! ### §E.5 Linearity and the generic kills

`hexTrace` is linear in its coefficient pair, so an integer multiple of a trace is a
trace — which lets every family's cleared equation be pushed into the exact shape
M25's row extractor consumes, with the coefficient folded into the address tables.
The `+3` address shift is the sign: `gE (x+3) = −gE x`, `gF (x+3) = −gF x`. -/

/-- `hexTrace` is linear in its coefficients. -/
theorem hexTrace_intMul (c t₁ t₂ : ℤ) (h : ℕ) :
    (c : ℂ) * hexTrace t₁ t₂ h = hexTrace (c * t₁) (c * t₂) h := by
  rw [hexTrace, hexTrace]
  push_cast
  ring

/-- The negation shift on the `g`-tables: `gE (x+3) = −gE x` and `gF (x+3) = −gF x`. -/
theorem gE_shift_three : ∀ x : ZMod 6, gE (x + 3) = -gE x := by decide

theorem gF_shift_three : ∀ x : ZMod 6, gF (x + 3) = -gF x := by decide

/-- A nonzero-mod-3 multiple of a `g`-coefficient pair is still not both divisible. -/
theorem g_coeff_ne {c : ℤ} (hc : ¬ (3 : ℤ) ∣ c) (A : ZMod 6) :
    ¬ ((3 : ℤ) ∣ c * gE A ∧ (3 : ℤ) ∣ c * gF A) := fun ⟨h1, h2⟩ =>
  gE_gF_ne A ⟨(Int.prime_three.dvd_mul.mp h1).resolve_left hc,
    (Int.prime_three.dvd_mul.mp h2).resolve_left hc⟩

/-- …and `φ` still fails to vanish on a scaled unit coefficient pair. -/
theorem u_coeff_phi {c : ℤ} (hc : ¬ (3 : ℤ) ∣ c) (y : ZMod 6) :
    ¬ (3 : ℤ) ∣ (c * hexE y.val - c * hexF y.val) := fun h => by
  rw [show c * hexE y.val - c * hexF y.val = c * (hexE y.val - hexF y.val) by ring] at h
  exact hex_diff_ne y ((Int.prime_three.dvd_mul.mp h).resolve_left hc)

/-- `φ` vanishes on any scaled `g`-coefficient pair. -/
theorem g_coeff_phi (c : ℤ) (A : ZMod 6) (p : ℕ) :
    (3 : ℤ) ∣ ((c * gE A * (piCoeff p).1
      + (c * gE A + c * gF A) * ((piCoeff p).1 + (piCoeff p).2))
      + c * gF A * (piCoeff p).2) := by
  obtain ⟨w, hw⟩ := phi_g_dvd A p
  exact ⟨c * w, by rw [show c * gE A * (piCoeff p).1
    + (c * gE A + c * gF A) * ((piCoeff p).1 + (piCoeff p).2) + c * gF A * (piCoeff p).2
    = c * ((gE A * (piCoeff p).1 + (gE A + gF A) * ((piCoeff p).1 + (piCoeff p).2))
      + gF A * (piCoeff p).2) by ring, hw]; ring⟩

/-! ### §E.6 The bottom kills, on the integer rows

After separation every family's live equation is
`3^p·H₁ + 3^q·H₂ = κ·3^s + 3^r·H₃` with `H₁, H₂` `g`-traces and `H₃` a unit trace
(coefficients scaled by units).  Three kills cover every bottom pattern except the
two-`g`-trace tie, and they are family-independent. -/

private theorem row_pair {C₁ C₂ C₃ κ : ℤ} {X Y Z : ZMod 6} {m n k p q r s : ℕ}
    (heq : (3 : ℂ) ^ p * hexTrace (C₁ * gE X) (C₁ * gF X) m
        + (3 : ℂ) ^ q * hexTrace (C₂ * gE Y) (C₂ * gF Y) n
      = (κ : ℂ) * 3 ^ s
        + (3 : ℂ) ^ r * hexTrace (C₃ * hexE Z.val) (C₃ * hexF Z.val) k) :
    (3 ^ p * (C₁ * gE X * (piCoeff m).1
          + (C₁ * gE X + C₁ * gF X) * ((piCoeff m).1 + (piCoeff m).2))
        + 3 ^ q * (C₂ * gE Y * (piCoeff n).1
          + (C₂ * gE Y + C₂ * gF Y) * ((piCoeff n).1 + (piCoeff n).2))
        - κ * 3 ^ s
        - 3 ^ r * (C₃ * hexE Z.val * (piCoeff k).1
          + (C₃ * hexE Z.val + C₃ * hexF Z.val) * ((piCoeff k).1 + (piCoeff k).2)) = 0)
      ∧ (3 ^ p * (C₁ * gF X * (piCoeff m).2) + 3 ^ q * (C₂ * gF Y * (piCoeff n).2)
        - 3 ^ r * (C₃ * hexF Z.val * (piCoeff k).2) = 0) :=
  hexTrace_rows_const heq

/-- **Alone, first `g`-trace**: `H₁` strictly lowest is impossible. -/
private theorem kill_alone_one {C₁ C₂ C₃ κ : ℤ} {X Y Z : ZMod 6} {m n k p q r s : ℕ}
    (hC₁ : ¬ (3 : ℤ) ∣ C₁) (hm : 1 ≤ m) (hq : p < q) (hr : p < r) (hs : p < s)
    (heq : (3 : ℂ) ^ p * hexTrace (C₁ * gE X) (C₁ * gF X) m
        + (3 : ℂ) ^ q * hexTrace (C₂ * gE Y) (C₂ * gF Y) n
      = (κ : ℂ) * 3 ^ s
        + (3 : ℂ) ^ r * hexTrace (C₃ * hexE Z.val) (C₃ * hexF Z.val) k) : False := by
  obtain ⟨R1, R2⟩ := row_pair heq
  obtain ⟨q', rfl⟩ : ∃ q', q = p + 1 + q' := ⟨q - p - 1, by omega⟩
  obtain ⟨r', rfl⟩ : ∃ r', r = p + 1 + r' := ⟨r - p - 1, by omega⟩
  obtain ⟨s', rfl⟩ : ∃ s', s = p + 1 + s' := ⟨s - p - 1, by omega⟩
  have hp3 : ((3 : ℤ) ^ p) ≠ 0 := pow_ne_zero p (by norm_num)
  refine g_coeff_ne hC₁ X (alone_dvd hm (R₁ := κ * 3 ^ s'
      + 3 ^ r' * (C₃ * hexE Z.val * (piCoeff k).1
        + (C₃ * hexE Z.val + C₃ * hexF Z.val) * ((piCoeff k).1 + (piCoeff k).2))
      - 3 ^ q' * (C₂ * gE Y * (piCoeff n).1
        + (C₂ * gE Y + C₂ * gF Y) * ((piCoeff n).1 + (piCoeff n).2)))
    (R₂ := 3 ^ r' * (C₃ * hexF Z.val * (piCoeff k).2)
      - 3 ^ q' * (C₂ * gF Y * (piCoeff n).2)) ?_ ?_)
  · have hz : (3 : ℤ) ^ p * ((C₁ * gE X * (piCoeff m).1
        + (C₁ * gE X + C₁ * gF X) * ((piCoeff m).1 + (piCoeff m).2))
        - 3 * (κ * 3 ^ s'
          + 3 ^ r' * (C₃ * hexE Z.val * (piCoeff k).1
            + (C₃ * hexE Z.val + C₃ * hexF Z.val) * ((piCoeff k).1 + (piCoeff k).2))
          - 3 ^ q' * (C₂ * gE Y * (piCoeff n).1
            + (C₂ * gE Y + C₂ * gF Y) * ((piCoeff n).1 + (piCoeff n).2)))) = 0 := by
      linear_combination R1
    rcases mul_eq_zero.mp hz with h | h
    · exact absurd h hp3
    · linarith
  · have hz : (3 : ℤ) ^ p * ((C₁ * gF X * (piCoeff m).2)
        - 3 * (3 ^ r' * (C₃ * hexF Z.val * (piCoeff k).2)
          - 3 ^ q' * (C₂ * gF Y * (piCoeff n).2))) = 0 := by
      linear_combination R2
    rcases mul_eq_zero.mp hz with h | h
    · exact absurd h hp3
    · linarith

/-- **Alone, second `g`-trace**: `H₂` strictly lowest is impossible. -/
private theorem kill_alone_two {C₁ C₂ C₃ κ : ℤ} {X Y Z : ZMod 6} {m n k p q r s : ℕ}
    (hC₂ : ¬ (3 : ℤ) ∣ C₂) (hn : 1 ≤ n) (hp : q < p) (hr : q < r) (hs : q < s)
    (heq : (3 : ℂ) ^ p * hexTrace (C₁ * gE X) (C₁ * gF X) m
        + (3 : ℂ) ^ q * hexTrace (C₂ * gE Y) (C₂ * gF Y) n
      = (κ : ℂ) * 3 ^ s
        + (3 : ℂ) ^ r * hexTrace (C₃ * hexE Z.val) (C₃ * hexF Z.val) k) : False := by
  refine kill_alone_one (C₁ := C₂) (C₂ := C₁) (C₃ := C₃) (κ := κ) (X := Y) (Y := X)
    (Z := Z) (m := n) (n := m) (k := k) hC₂ hn hp hr hs ?_
  linear_combination heq

/-- **The `φ` kill**: the unit trace at (or below) the bottom is impossible. -/
private theorem kill_phi {C₁ C₂ C₃ κ : ℤ} {X Y Z : ZMod 6} {m n k p q r s : ℕ}
    (hC₃ : ¬ (3 : ℤ) ∣ C₃) (hk : 1 ≤ k) (hp : r ≤ p) (hq : r ≤ q) (hs : r < s)
    (heq : (3 : ℂ) ^ p * hexTrace (C₁ * gE X) (C₁ * gF X) m
        + (3 : ℂ) ^ q * hexTrace (C₂ * gE Y) (C₂ * gF Y) n
      = (κ : ℂ) * 3 ^ s
        + (3 : ℂ) ^ r * hexTrace (C₃ * hexE Z.val) (C₃ * hexF Z.val) k) : False := by
  obtain ⟨R1, R2⟩ := row_pair heq
  obtain ⟨p', rfl⟩ : ∃ p', p = r + p' := ⟨p - r, by omega⟩
  obtain ⟨q', rfl⟩ : ∃ q', q = r + q' := ⟨q - r, by omega⟩
  obtain ⟨s', rfl⟩ : ∃ s', s = r + 1 + s' := ⟨s - r - 1, by omega⟩
  obtain ⟨w₁, hw₁⟩ := g_coeff_phi C₁ X m
  obtain ⟨w₂, hw₂⟩ := g_coeff_phi C₂ Y n
  have hr3 : ((3 : ℤ) ^ r) ≠ 0 := pow_ne_zero r (by norm_num)
  refine u_coeff_phi hC₃ Z (phi_dvd hk (S := 3 ^ p' * w₁ + 3 ^ q' * w₂ - κ * 3 ^ s') ?_)
  have hz : (3 : ℤ) ^ r * ((C₃ * hexE Z.val * (piCoeff k).1
      + (C₃ * hexE Z.val + C₃ * hexF Z.val) * ((piCoeff k).1 + (piCoeff k).2)
      + C₃ * hexF Z.val * (piCoeff k).2)
      - 3 * (3 ^ p' * w₁ + 3 ^ q' * w₂ - κ * 3 ^ s')) = 0 := by
    linear_combination -R1 - R2 + (3 : ℤ) ^ (r + p') * hw₁ + (3 : ℤ) ^ (r + q') * hw₂
  rcases mul_eq_zero.mp hz with h | h
  · exact absurd h hr3
  · linarith

private theorem pow_dvd_of_not_dvd {C A : ℤ} {e : ℕ} (hC : ¬ (3 : ℤ) ∣ C)
    (h : (3 : ℤ) ^ e ∣ C * A) : (3 : ℤ) ^ e ∣ A :=
  ((Int.prime_three.coprime_iff_not_dvd.mpr hC).pow_left).dvd_of_dvd_mul_left h

/-- **The equal-heights collapse**: two `g`-traces at the SAME height tie at the bottom
with the unit trace at height zero, so linearity merges them into one trace equal to a
rational integer — and the pin reads off both coordinates. -/
private theorem kill_equal {C₁ C₂ C₃ κ : ℤ} {X Y Z : ZMod 6} {m p r' s' : ℕ} (hm : 1 ≤ m)
    (heq : (3 : ℂ) ^ p * hexTrace (C₁ * gE X) (C₁ * gF X) m
        + (3 : ℂ) ^ p * hexTrace (C₂ * gE Y) (C₂ * gF Y) m
      = (κ : ℂ) * 3 ^ (p + s')
        + (3 : ℂ) ^ (p + r') * hexTrace (C₃ * hexE Z.val) (C₃ * hexF Z.val) 0) :
    C₁ * gF X + C₂ * gF Y = 0
      ∧ (C₁ * gE X + C₂ * gE Y) * (2 * (piCoeff m).1 + (piCoeff m).2)
        = κ * 3 ^ s' + 3 ^ r' * (2 * (C₃ * hexE Z.val) + C₃ * hexF Z.val) := by
  have hadd := hexTrace_add (C₁ * gE X) (C₁ * gF X) (C₂ * gE Y) (C₂ * gF Y) m
  have h0 := hexTrace_zero_height (C₃ * hexE Z.val) (C₃ * hexF Z.val)
  refine hexTrace_pin hm (r := κ * 3 ^ s'
    + 3 ^ r' * (2 * (C₃ * hexE Z.val) + C₃ * hexF Z.val)) ?_
  refine mul_left_cancel₀ (pow_ne_zero p (by norm_num : (3 : ℂ) ≠ 0)) ?_
  rw [← hadd]
  rw [h0] at heq
  push_cast
  push_cast at heq
  linear_combination heq

/-- **The adjacent-heights kill**: two `g`-traces at heights `m`, `m+1` tie at the
bottom with two clear levels above — M25's mod-9 refutation, with the unit coefficient
stripped. -/
private theorem kill_adjacent {C C₃ κ : ℤ} {X Y Z : ZMod 6} {m k p r s : ℕ}
    (hC : ¬ (3 : ℤ) ∣ C) (hm : 3 ≤ m) (hr : p + 2 ≤ r) (hs : p + 2 ≤ s)
    (heq : (3 : ℂ) ^ p * hexTrace (C * gE X) (C * gF X) m
        + (3 : ℂ) ^ p * hexTrace (C * gE Y) (C * gF Y) (m + 1)
      = (κ : ℂ) * 3 ^ s
        + (3 : ℂ) ^ r * hexTrace (C₃ * hexE Z.val) (C₃ * hexF Z.val) k) : False := by
  obtain ⟨R1, R2⟩ := row_pair heq
  obtain ⟨r', rfl⟩ : ∃ r', r = p + 2 + r' := ⟨r - p - 2, by omega⟩
  obtain ⟨s', rfl⟩ : ∃ s', s = p + 2 + s' := ⟨s - p - 2, by omega⟩
  have hp3 : ((3 : ℤ) ^ p) ≠ 0 := pow_ne_zero p (by norm_num)
  -- both rows are 9-divisible after the common factor is cancelled
  have hd1 : (3 : ℤ) ^ 2 ∣ C * (gE X * (piCoeff m).1
      + (gE X + gF X) * ((piCoeff m).1 + (piCoeff m).2)
      + (gE Y * (piCoeff (m + 1)).1
        + (gE Y + gF Y) * ((piCoeff (m + 1)).1 + (piCoeff (m + 1)).2))) := by
    refine ⟨κ * 3 ^ s' + 3 ^ r' * (C₃ * hexE Z.val * (piCoeff k).1
      + (C₃ * hexE Z.val + C₃ * hexF Z.val) * ((piCoeff k).1 + (piCoeff k).2)), ?_⟩
    have hz : (3 : ℤ) ^ p * (C * (gE X * (piCoeff m).1
        + (gE X + gF X) * ((piCoeff m).1 + (piCoeff m).2)
        + (gE Y * (piCoeff (m + 1)).1
          + (gE Y + gF Y) * ((piCoeff (m + 1)).1 + (piCoeff (m + 1)).2)))
        - 3 ^ 2 * (κ * 3 ^ s' + 3 ^ r' * (C₃ * hexE Z.val * (piCoeff k).1
          + (C₃ * hexE Z.val + C₃ * hexF Z.val) * ((piCoeff k).1 + (piCoeff k).2)))) = 0 := by
      linear_combination R1
    rcases mul_eq_zero.mp hz with h | h
    · exact absurd h hp3
    · linarith
  have hd2 : (3 : ℤ) ^ 2 ∣ C * (gF X * (piCoeff m).2 + gF Y * (piCoeff (m + 1)).2) := by
    refine ⟨3 ^ r' * (C₃ * hexF Z.val * (piCoeff k).2), ?_⟩
    have hz : (3 : ℤ) ^ p * (C * (gF X * (piCoeff m).2 + gF Y * (piCoeff (m + 1)).2)
        - 3 ^ 2 * (3 ^ r' * (C₃ * hexF Z.val * (piCoeff k).2))) = 0 := by
      linear_combination R2
    rcases mul_eq_zero.mp hz with h | h
    · exact absurd h hp3
    · linarith
  obtain ⟨W₁, hW₁⟩ := pow_dvd_of_not_dvd hC hd1
  obtain ⟨W₂, hW₂⟩ := pow_dvd_of_not_dvd hC hd2
  exact adjacent_kill X Y hm (le_refl 2) hW₁ hW₂

/-! ## §A The adjacent master web — hexagon neighbours, separation `ḡ/3`

Master frame `(hexPivot 3, hexPivot 4) = (0, 2m−ζ₆)`; every web `(a, a+1)` is its
`rot6^(a−3)` image, so the tables read at the shift `a − 3`.  Census-exact:
oo is EMPTY, oi/io/ii carry four sporadics each, every fusion is EMPTY. -/

/-- oi sporadics, master frame: `outer(0) ↔ inner(2m−ζ₆)`. -/
def adjOITable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(2, -2, 4, -1), (2, 2, 4, 1), (3, -2, 1, -1), (3, 2, 1, 1)]

/-- io sporadics, master frame. -/
def adjIOTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(1, -1, 5, -2), (1, 1, 5, 2), (4, -1, 0, -2), (4, 1, 0, 2)]

/-- ii sporadics, master frame. -/
def adjIITable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(0, -1, 2, -1), (0, 1, 2, 1), (5, -1, 3, -1), (5, 1, 3, 1)]

/-- **Adjacent oo is empty**: no unit chord joins the outer circles of hexagon
neighbours' lattices. -/
theorem adj_oo_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) ≠ 1 := sorry

/-- **Adjacent oi completeness, all six webs**: exactly the four table chords. -/
theorem adj_oi_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ adjOITable := sorry

/-- **Adjacent io completeness, all six webs.** -/
theorem adj_io_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ adjIOTable := sorry

/-- **Adjacent ii completeness, all six webs.** -/
theorem adj_ii_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ adjIITable := sorry

/-- The adjacent oo fusion is empty. -/
theorem adj_fusion_oo (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := sorry

/-- The adjacent oi fusion is empty (mutual inner-circle membership is a fact about
the CENTRES, which are never lattice points of the partner's ladder). -/
theorem adj_fusion_oi (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := sorry

theorem adj_fusion_io (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := sorry

theorem adj_fusion_ii (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := sorry

/-! ## §O The opposite master web — the tangent pairs, separation `2g/3`

Master frame `(hexPivot 3, hexPivot 0) = (0, 2m)`.  The masters carry doubled
`g`-coefficients at REFLECTED addresses (`Tr(g·w̄)` — the §0 orientation
correction).  Census-exact: oo carries four sporadics, oi/io/ii are EMPTY, every
fusion is EMPTY — the triple tangency at `m` never touches the lattice. -/

/-- oo sporadics, master frame: `outer(0) ↔ outer(2m)`. -/
def oppOOTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(3, -2, 1, -2), (3, 2, 1, 2), (4, -2, 0, -2), (4, 2, 0, 2)]

/-- **Opposite oo completeness, all webs**: exactly the four table chords. -/
theorem opp_oo_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ oppOOTable := sorry

/-- **Opposite oi is empty.** -/
theorem opp_oi_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) ≠ 1 := sorry

/-- **Opposite io is empty** — the oi statement at `a + 3`, roles flipped. -/
theorem opp_io_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) ≠ 1 := sorry

/-- **Opposite ii is empty**: the tangent inner circles' lattices carry no unit
chord (and, by `opp_fusion_ii`, no coincidence — the tangency is invisible). -/
theorem opp_ii_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) ≠ 1 := sorry

/-- The opposite oo fusion is empty. -/
theorem opp_fusion_oo (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := sorry

/-- The opposite oi fusion is empty. -/
theorem opp_fusion_oi (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := sorry

/-- The opposite io fusion is empty — the oi statement at `a + 3`, flipped. -/
theorem opp_fusion_io (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := sorry

/-- The opposite ii fusion is empty: the tangency point `m` is never a lattice
word (M24's empty `Re = √3/2` fibre, at the κ = 6√3 spine). -/
theorem opp_fusion_ii (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := sorry

/-! ## §W The transported webs: pivot–meta at all six pivots, unit pairs

The pivot–meta statements extend M25's `Fin 3` quantifier to the full hexagon
(M25's shift `webShift j = 2j` is the restriction of `a − 3` to the odd
addresses); the unit-pair oo statement is M24's matching-∨-hub in hexagram
currency. -/

/-- **oo completeness at the metapivot axis, all SIX webs** (extends M25's
`meta_oo_complete`). -/
theorem hexMeta_oo_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt metaPivot metaAnchor y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ metaOOTable := sorry

/-- **oi completeness at the metapivot axis, all six webs**: the hub pencil
through the fused pivot plus the four sporadics. -/
theorem hexMeta_oi_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt metaPivot metaAnchor y d) = 1 ↔
      ((y = a ∧ d = 0) ∨ (x - (a - 3), b, y - (a - 3), d) ∈ metaOITable) := sorry

/-- **io completeness at the metapivot axis, all six webs.** -/
theorem hexMeta_io_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt metaPivot metaAnchor y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ metaIOTable := sorry

/-- **ii completeness at the metapivot axis, all six webs.** -/
theorem hexMeta_ii_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt metaPivot metaAnchor y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ metaIITable := sorry

/-- **The oi fusion at all six webs**: pivot `a`'s outer lattice meets the
meta-inner lattice at exactly the two second-neighbour pivots. -/
theorem hexMeta_fusion_oi (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b = innerPt metaPivot metaAnchor y d ↔
      ((x = a - 2 ∧ b = 0 ∧ y = a - 2 ∧ d = 0)
        ∨ (x = a - 3 ∧ b = 0 ∧ y = a + 2 ∧ d = 0)) := sorry

/-- The oo fusion at the metapivot axis is empty at every pivot. -/
theorem hexMeta_fusion_oo (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt metaPivot metaAnchor y d := sorry

/-- The io fusion at the metapivot axis is empty at every pivot. -/
theorem hexMeta_fusion_io (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt metaPivot metaAnchor y d := sorry

/-- The ii fusion at the metapivot axis is empty at every pivot. -/
theorem hexMeta_fusion_ii (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt metaPivot metaAnchor y d := sorry

/-- **Unit-pair oo, all six pairs, in hexagram currency**: the translation
matching or one of the two hub pencils (M24's `oo_complete` re-addressed —
`x = a−3, b = 0` is the point AT the far centre, `y = a, d = 0` the point at the
near one). -/
theorem unit_oo_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 2)) (hexPivot (a + 2) + 1) y d) = 1 ↔
      ((y = x ∧ d = b) ∨ (x = a - 3 ∧ b = 0) ∨ (y = a ∧ d = 0)) := sorry

/-! ## §C The colouring: χ(hexagram) = 4

The rot6-equivariant table measured by the §0 probe (54 fused collapsed classes,
no self-loop; `colour(rot6 z) = τ(colour z)` with `τ` the 3-cycle `0→1→2→0`
fixing colour 3).  Row index: the pivot's meta-inner address `a`; column: the hex
address `x`; `b` never enters. -/

/-- The equivariance permutation: the 3-cycle `0 → 1 → 2 → 0`, colour 3 fixed. -/
def tau : Fin 4 → Fin 4 := ![1, 2, 0, 3]

/-- The pivot-ladder colour table, `false` = outer, `true` = inner; row `a`
(the pivot's address), column `x` (the hex address). -/
def hexColTab (circ : Bool) : ZMod 6 → ZMod 6 → Fin 4 :=
  if circ then
    ![![1, 2, 3, 3, 0, 1], ![2, 2, 0, 3, 3, 1], ![2, 0, 0, 1, 3, 3],
      ![3, 0, 1, 1, 2, 3], ![3, 3, 1, 2, 2, 0], ![1, 3, 3, 2, 0, 0]]
  else
    ![![2, 3, 2, 0, 2, 0], ![1, 0, 3, 0, 1, 0], ![1, 2, 1, 3, 1, 2],
      ![0, 2, 0, 2, 3, 2], ![0, 1, 0, 1, 0, 3], ![3, 1, 2, 1, 2, 1]]

/-- The metapivot-ladder colour table — τ-periodic by construction. -/
def hexMetaColTab (circ : Bool) : ZMod 6 → Fin 4 :=
  if circ then ![1, 2, 0, 1, 2, 0] else ![0, 1, 2, 0, 1, 2]

/-- The table is rot6-equivariant: the transported entry is the τ-image.  The fact
that collapses properness to one web per orbit. -/
theorem hexColTab_equivariant (circ : Bool) (a x : ZMod 6) :
    hexColTab circ (a + 1) (x + 1) = tau (hexColTab circ a x) := sorry

theorem hexMetaColTab_equivariant (circ : Bool) (x : ZMod 6) :
    hexMetaColTab circ (x + 1) = tau (hexMetaColTab circ x) := sorry

open Classical in
/-- The hexagram colouring: decode any address in priority order (pivot outer,
pivot inner, meta outer, meta inner), read the table.  Well-defined on fused
points because the table equalizes every coincidence the fusion classifications
allow.  Junk value `0` off the object. -/
noncomputable def hexColor (z : ℂ) : Fin 4 :=
  if h : ∃ n : ZMod 6 × ZMod 6 × ℤ,
      outerPt (hexPivot n.1) (hexPivot n.1 + 1) n.2.1 n.2.2 = z then
    hexColTab false h.choose.1 h.choose.2.1
  else if h : ∃ n : ZMod 6 × ZMod 6 × ℤ,
      innerPt (hexPivot n.1) (hexPivot n.1 + 1) n.2.1 n.2.2 = z then
    hexColTab true h.choose.1 h.choose.2.1
  else if h : ∃ n : ZMod 6 × ℤ, outerPt metaPivot metaAnchor n.1 n.2 = z then
    hexMetaColTab false h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, innerPt metaPivot metaAnchor n.1 n.2 = z then
    hexMetaColTab true h.choose.1
  else 0

/-- **Properness**: the table separates every unit chord of the hexagram. -/
theorem hexColor_valid {z w : ℂ} (hz : z ∈ hexagram) (hw : w ∈ hexagram)
    (h : dist z w = 1) : hexColor z ≠ hexColor w := sorry

theorem colorable_four_hexagram :
    ((unitDistance ℂ).induce hexagram).Colorable 4 := sorry

/-- The lower bound: M25's four-ladder object (hence M24's nine-point witness)
sits inside the hexagram. -/
theorem not_colorable_three_hexagram :
    ¬ ((unitDistance ℂ).induce hexagram).Colorable 3 := sorry

/-- **The M26 headline**: the hexagram is exactly 4-chromatic. -/
theorem chromaticNumber_hexagram :
    ((unitDistance ℂ).induce hexagram).chromaticNumber = 4 := sorry

/-! ## Spec examples — the statement-level gate at skeleton time -/

example : hexColTab false 3 0 = 0 := rfl
example : hexColTab true 0 0 = 1 := rfl
example : hexMetaColTab false 4 = 1 := rfl
example : tau 2 = 0 := rfl
example : ((2 : ZMod 6), (-2 : ℤ), (4 : ZMod 6), (-1 : ℤ)) ∈ adjOITable := by decide
example : ((0 : ZMod 6), (0 : ℤ), (0 : ZMod 6), (0 : ℤ)) ∉ oppOOTable := by decide

end Hexagram
end HadwigerNelson
