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
theorem fourLadder_subset_hexagram : fourLadder ⊆ hexagram := by
  intro z hz
  simp only [fourLadder, Set.mem_iUnion, Set.mem_union, Set.mem_setOf_eq] at hz
  obtain ⟨k, hz⟩ := hz
  fin_cases k
  · rcases hz with ⟨u, v, rfl⟩ | ⟨u, v, rfl⟩
    · have he : outerPt (anchor 0).1 (anchor 0).2 u v
          = outerPt (hexPivot 3) (hexPivot 3 + 1) u v := by
        rw [anchor_zero, hexPivot_three]
        norm_num
      show outerPt (anchor 0).1 (anchor 0).2 u v ∈ hexagram
      rw [he]; exact outer_mem_hexagram 3 u v
    · have he : innerPt (anchor 0).1 (anchor 0).2 u v
          = innerPt (hexPivot 3) (hexPivot 3 + 1) u v := by
        rw [anchor_zero, hexPivot_three]
        norm_num
      show innerPt (anchor 0).1 (anchor 0).2 u v ∈ hexagram
      rw [he]; exact inner_mem_hexagram 3 u v
  · rcases hz with ⟨u, v, rfl⟩ | ⟨u, v, rfl⟩
    · have he : outerPt (anchor 1).1 (anchor 1).2 u v
          = outerPt (hexPivot 5) (hexPivot 5 + 1) u v := by
        rw [anchor_one, hexPivot_five]
        norm_num
      show outerPt (anchor 1).1 (anchor 1).2 u v ∈ hexagram
      rw [he]; exact outer_mem_hexagram 5 u v
    · have he : innerPt (anchor 1).1 (anchor 1).2 u v
          = innerPt (hexPivot 5) (hexPivot 5 + 1) u v := by
        rw [anchor_one, hexPivot_five]
        norm_num
      show innerPt (anchor 1).1 (anchor 1).2 u v ∈ hexagram
      rw [he]; exact inner_mem_hexagram 5 u v
  · rcases hz with ⟨u, v, rfl⟩ | ⟨u, v, rfl⟩
    · have he : outerPt (anchor 2).1 (anchor 2).2 u v
          = outerPt (hexPivot 1) (hexPivot 1 + 1) u v := by
        rw [anchor_two, hexPivot_one]
      show outerPt (anchor 2).1 (anchor 2).2 u v ∈ hexagram
      rw [he]; exact outer_mem_hexagram 1 u v
    · have he : innerPt (anchor 2).1 (anchor 2).2 u v
          = innerPt (hexPivot 1) (hexPivot 1 + 1) u v := by
        rw [anchor_two, hexPivot_one]
      show innerPt (anchor 2).1 (anchor 2).2 u v ∈ hexagram
      rw [he]; exact inner_mem_hexagram 1 u v
  · rcases hz with ⟨u, v, rfl⟩ | ⟨u, v, rfl⟩
    · have he : outerPt (anchor 3).1 (anchor 3).2 u v
          = outerPt metaPivot metaAnchor u v := by
        rw [anchor_three]
      show outerPt (anchor 3).1 (anchor 3).2 u v ∈ hexagram
      rw [he]; exact metaOuter_mem_hexagram u v
    · have he : innerPt (anchor 3).1 (anchor 3).2 u v
          = innerPt metaPivot metaAnchor u v := by
        rw [anchor_three]
      show innerPt (anchor 3).1 (anchor 3).2 u v ∈ hexagram
      rw [he]; exact metaInner_mem_hexagram u v

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

/-! ### §E.7 The parity separation

Each family's cleared equation has four `√3`-exponents; in three of the four parity
classes they split, isolating one trace against a rational constant, and in the fourth
they agree and the equation stays in the ring. -/

private theorem inRing_three_pow' (k : ℕ) : InRing ((3 : ℂ) ^ k) := by
  rw [show ((3 : ℂ) ^ k) = (((3 ^ k : ℤ)) : ℂ) by push_cast; ring]
  exact InRing.intCast _

private theorem inRing_pow_trace' (e : ℕ) (t₁ t₂ : ℤ) (h : ℕ) :
    InRing ((3 : ℂ) ^ e * hexTrace t₁ t₂ h) :=
  (inRing_three_pow' e).mul (inRing_hexTrace t₁ t₂ h)

private theorem inRing_kappa (κ : ℤ) (k : ℕ) : InRing ((κ : ℂ) * 3 ^ k) := by
  rw [show ((κ : ℂ) * 3 ^ k) = (((κ * 3 ^ k : ℤ)) : ℂ) by push_cast; ring]
  exact InRing.intCast _

/-- A scaled `g`-trace equal to a rational integer forces height zero, and then reads
off its value.  (At positive height the pin kills it: `gF` never vanishes.) -/
private theorem g_rational {C : ℤ} (hC : C ≠ 0) {X : ZMod 6} {N : ℤ} {m : ℕ}
    (h : hexTrace (C * gE X) (C * gF X) m = ((N : ℤ) : ℂ)) :
    m = 0 ∧ C * (2 * gE X + gF X) = N := by
  rcases Nat.eq_zero_or_pos m with rfl | hm
  · refine ⟨rfl, ?_⟩
    rw [hexTrace_zero_height] at h
    have hv : 2 * (C * gE X) + C * gF X = N := by exact_mod_cast h
    linarith
  · exfalso
    have hz := (hexTrace_pin hm h).1
    have hgf : gF X = 0 := by
      rcases mul_eq_zero.mp hz with h1 | h1
      · exact absurd h1 hC
      · exact h1
    exact (by decide : ∀ z : ZMod 6, gF z ≠ 0) X hgf

/-- A scaled unit trace equal to a rational integer forces `hexF = 0` and reads off the
value; at height zero the value is `2·hexE + hexF`. -/
private theorem u_rational {C : ℤ} (hC : ¬ (3 : ℤ) ∣ C) {Z : ZMod 6} {N : ℤ} {k : ℕ}
    (h : hexTrace (C * hexE Z.val) (C * hexF Z.val) k = ((N : ℤ) : ℂ))
    (hN : (3 : ℤ) ∣ N) : k = 0 ∧ C * (2 * hexE Z.val + hexF Z.val) = N := by
  rcases Nat.eq_zero_or_pos k with rfl | hk
  · refine ⟨rfl, ?_⟩
    rw [hexTrace_zero_height] at h
    have hv : 2 * (C * hexE Z.val) + C * hexF Z.val = N := by exact_mod_cast h
    linarith
  · exfalso
    obtain ⟨hF, hval⟩ := hexTrace_pin hk h
    obtain ⟨N', rfl⟩ := hN
    have h3 : (3 : ℤ) ∣ C * hexE Z.val * (2 * (piCoeff k).1 + (piCoeff k).2) := ⟨N', hval⟩
    have h3E := (Int.prime_three.dvd_mul.mp h3).resolve_right (not_three_dvd_pin k hk)
    have hE : (3 : ℤ) ∣ hexE Z.val := (Int.prime_three.dvd_mul.mp h3E).resolve_left hC
    have hF3 : (3 : ℤ) ∣ hexF Z.val := by
      rcases mul_eq_zero.mp hF with h1 | h1
      · exact absurd ⟨0, by omega⟩ hC
      · exact h1 ▸ dvd_zero 3
    exact hexE_hexF_not_both_dvd Z.val (ZMod.val_lt Z) ⟨hE, hF3⟩

/-! ### §E.8 The height-two pin values and the boundary tables -/

private theorem piCoeff_two : piCoeff 2 = (-3, 1) := rfl

private theorem hexF_zero_hexE' : ∀ y : ZMod 6, hexF y.val = 0 → hexE y.val = 1 ∨ hexE y.val = -1 := by
  decide

/-- A unit trace at height two equal to a rational integer pins that integer to `∓5`. -/
private theorem u_pin_two {Z : ZMod 6} {N : ℤ}
    (h : hexTrace (1 * hexE Z.val) (1 * hexF Z.val) 2 = ((N : ℤ) : ℂ)) :
    N = -5 ∨ N = 5 := by
  obtain ⟨hF, hval⟩ := hexTrace_pin (by norm_num) h
  rw [piCoeff_two] at hval
  have hF0 : hexF Z.val = 0 := by linarith
  rcases hexF_zero_hexE' Z hF0 with h1 | h1 <;> rw [h1] at hval <;> omega

/-- `3^v ∣ (gE X − gE Y)` with `|gE X − gE Y| ≤ 4` forces equality once `v ≥ 2`. -/
private theorem gE_diff_small : ∀ X Y : ZMod 6, -4 ≤ gE X - gE Y ∧ gE X - gE Y ≤ 4 := by
  decide

private theorem gE_gF_inj : ∀ X Y : ZMod 6, gE X = gE Y → gF X = gF Y → X = Y := by decide

/-- **The live-class trichotomy**: with all three heights positive and both `g`-traces
below the constant, the only surviving bottom is the two-`g`-trace tie.  One lemma
replaces the alone/φ case bash in all eight families. -/
private theorem live_tie {C₁ C₂ C₃ κ : ℤ} {X Y Z : ZMod 6} {m n k p q r s : ℕ}
    (hC₁ : ¬ (3 : ℤ) ∣ C₁) (hC₂ : ¬ (3 : ℤ) ∣ C₂) (hC₃ : ¬ (3 : ℤ) ∣ C₃)
    (hm : 1 ≤ m) (hn : 1 ≤ n) (hk : 1 ≤ k) (hps : p < s) (hqs : q < s)
    (heq : (3 : ℂ) ^ p * hexTrace (C₁ * gE X) (C₁ * gF X) m
        + (3 : ℂ) ^ q * hexTrace (C₂ * gE Y) (C₂ * gF Y) n
      = (κ : ℂ) * 3 ^ s
        + (3 : ℂ) ^ r * hexTrace (C₃ * hexE Z.val) (C₃ * hexF Z.val) k) :
    p = q ∧ p < r := by
  rcases Nat.lt_or_ge p r with hrp | hrp
  · rcases lt_trichotomy p q with h1 | h1 | h1
    · exact absurd (kill_alone_one hC₁ hm h1 hrp hps heq) not_false
    · exact ⟨h1, hrp⟩
    · rcases Nat.lt_or_ge q r with hrq | hrq
      · exact absurd (kill_alone_two hC₂ hn h1 hrq hqs heq) not_false
      · exact absurd (kill_phi hC₃ hk (by omega) hrq (by omega) heq) not_false
  · rcases Nat.lt_or_ge q r with hrq | hrq
    · exact absurd (kill_alone_two hC₂ hn (by omega) hrq hqs heq) not_false
    · exact absurd (kill_phi hC₃ hk hrp hrq (by omega) heq) not_false

/-! ### §E.9 The oo-shape tree

`adj_oo` (C = 1) and `opp_oo` (C = 2) share one tree: live parity (even, even), the
tie at EQUAL heights, and a final `κ = 3·W` check the height-zero unit table refuses.
The lemma CLASSIFIES: the two surviving branches (heights zero; the `μ = 1` tie at
heights two) are returned as data, and the caller decides each against its table —
the shape that lets one lemma serve the empty families AND `opp_oo`'s four sporadics. -/

set_option maxHeartbeats 1000000 in
private theorem oo_shape {C : ℤ} (hC : ¬ (3 : ℤ) ∣ C) (hCv : C = 1 ∨ C = 2)
    {x y : ZMod 6} {b d : ℤ}
    {κ : ℤ} (hκ3 : ¬ (3 : ℤ) ∣ κ) (hκv : κ = 4 ∨ κ = 7 ∨ κ = 10)
    (h : (C : ℂ) * s3 ^ 0 * gTr x b + ((-C : ℤ) : ℂ) * s3 ^ 0 * gTr y d
      + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (x - y) (b - d) = (κ : ℂ) * s3 ^ 0) :
    (b = 0 ∧ d = 0
      ∧ C * (2 * gE x + gF x) + (-C) * (2 * gE y + gF y)
        + 3 * (2 * hexE (x - y).val + hexF (x - y).val) = κ)
    ∨ (b = d ∧ b.natAbs = 2
      ∧ C * gF (gAddr x b) + (-C) * gF (gAddr y d) = 0
      ∧ (C * gE (gAddr x b) + (-C) * gE (gAddr y d))
          * (2 * (piCoeff 2).1 + (piCoeff 2).2)
        = κ * 3 ^ 1 + 3 ^ 2 * (2 * ((-1) * hexE (uAddr (x - y) (b - d)).val)
          + (-1) * hexF (uAddr (x - y) (b - d)).val)) := by
  have hC0 : C ≠ 0 := by rcases hCv with rfl | rfl <;> norm_num
  have hnegC : ¬ (3 : ℤ) ∣ (-C) := fun hh => hC ((dvd_neg).mp hh)
  obtain ⟨t, ht⟩ : ∃ t, b.natAbs + d.natAbs = (b - d).natAbs + 2 * t :=
    ⟨(b.natAbs + d.natAbs - (b - d).natAbs) / 2, by omega⟩
  have hcl := hex_cleared ht h
  obtain ⟨μ, hμ⟩ : ∃ μ, b.natAbs = 2 * μ ∨ b.natAbs = 2 * μ + 1 := ⟨b.natAbs / 2, by omega⟩
  obtain ⟨ν, hν⟩ : ∃ ν, d.natAbs = 2 * ν ∨ d.natAbs = 2 * ν + 1 := ⟨d.natAbs / 2, by omega⟩
  simp only [zero_add] at hcl
  rcases hμ with hμ | hμ <;> rcases hν with hν | hν
  · -- LIVE: both heights even
    rw [hμ, hν, show 2 * μ + 2 * ν = 2 * (μ + ν) by ring] at hcl
    simp only [sqrt3_pow_two_mul', pow_zero] at hcl
    have hkill : (3 : ℂ) ^ ν * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ)
        + (3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν)
        = (κ : ℂ) * 3 ^ (μ + ν)
          + (3 : ℂ) ^ (t + 1)
            * hexTrace ((-1) * hexE (uAddr (x - y) (b - d)).val)
              ((-1) * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs := by
      rw [← hexTrace_intMul C, ← hexTrace_intMul (-C), ← hexTrace_intMul (-1)]
      push_cast
      push_cast at hcl
      linear_combination hcl
    rcases Nat.eq_zero_or_pos μ with rfl | hμ0
    · rcases Nat.eq_zero_or_pos ν with rfl | hν0
      · -- all heights zero
        have hb0 : b = 0 := by omega
        have hd0 : d = 0 := by omega
        subst hb0; subst hd0
        have ht0 : t = 0 := by omega
        subst ht0
        rw [show (2 * 0 : ℕ) = 0 from rfl, show ((0 : ℤ) - 0) = 0 by ring,
          show gAddr x 0 = x from by rw [gAddr, if_pos le_rfl],
          show gAddr y 0 = y from by rw [gAddr, if_pos le_rfl],
          show uAddr (x - y) 0 = x - y from by rw [uAddr, if_pos le_rfl],
          show (0 : ℤ).natAbs = 0 from rfl, hexTrace_zero_height, hexTrace_zero_height,
          hexTrace_zero_height] at hkill
        have hc : ((C * (2 * gE x + gF x) + (-C) * (2 * gE y + gF y)
            + 3 * (2 * hexE (x - y).val + hexF (x - y).val) : ℤ) : ℂ) = ((κ : ℤ) : ℂ) := by
          push_cast
          push_cast at hkill
          linear_combination hkill
        exact Or.inl ⟨rfl, rfl, by exact_mod_cast hc⟩
      · -- m = 0 < n: the second g-trace is alone
        exact (kill_alone_two (C₁ := C) (C₂ := -C) (C₃ := -1) (κ := κ)
          (X := gAddr x b) (Y := gAddr y d) (Z := uAddr (x - y) (b - d))
          (m := 2 * 0) (n := 2 * ν) (k := (b - d).natAbs) (p := ν) (q := 0)
          (r := t + 1) (s := 0 + ν) hnegC (by omega) (by omega) (by omega) (by omega)
          hkill).elim
    · rcases Nat.eq_zero_or_pos ν with rfl | hν0
      · exact (kill_alone_one (C₁ := C) (C₂ := -C) (C₃ := -1) (κ := κ)
          (X := gAddr x b) (Y := gAddr y d) (Z := uAddr (x - y) (b - d))
          (m := 2 * μ) (n := 2 * 0) (k := (b - d).natAbs) (p := 0) (q := μ)
          (r := t + 1) (s := μ + 0) hC (by omega) (by omega) (by omega) (by omega)
          hkill).elim
      · -- both heights positive
        rcases Nat.eq_zero_or_pos (b - d).natAbs with hk0 | hk0
        · -- k = 0: equal heights, the collapse
          have hmn : μ = ν := by omega
          subst hmn
          have hts : t = 2 * μ := by omega
          subst hts
          rw [hk0, show 2 * μ + 1 = μ + (μ + 1) by ring] at hkill
          obtain ⟨hF, hval⟩ := kill_equal (C₁ := C) (C₂ := -C) (C₃ := -1) (κ := κ)
            (X := gAddr x b) (Y := gAddr y d) (Z := uAddr (x - y) (b - d))
            (m := 2 * μ) (p := μ) (s' := μ) (r' := μ + 1) (by omega) hkill
          -- 3^μ divides the g-coefficient difference
          have hnd := not_three_dvd_pin (2 * μ) (by omega)
          have hdvd : (3 : ℤ) ^ μ ∣ (C * gE (gAddr x b) + (-C) * gE (gAddr y d)) := by
            refine pow_dvd_of_not_dvd (C := 2 * (piCoeff (2 * μ)).1 + (piCoeff (2 * μ)).2)
              (fun hh => hnd hh) ?_
            rw [mul_comm]
            exact ⟨κ * 3 ^ 0 + 3 ^ 1 * (2 * ((-1) * hexE (uAddr (x - y) (b - d)).val)
                + (-1) * hexF (uAddr (x - y) (b - d)).val), by
              rw [hval]; ring⟩
          rcases Nat.lt_or_ge μ 2 with hμ2 | hμ2
          · -- μ = 1: the boundary, returned as data
            have hμ1 : μ = 1 := by omega
            subst hμ1
            refine Or.inr ⟨by omega, by omega, hF, ?_⟩
            rw [show 2 * 1 = 2 from rfl] at hval
            exact hval
          · -- μ ≥ 2: the difference must vanish, and then 3 ∣ κ
            have hsmall := gE_diff_small (gAddr x b) (gAddr y d)
            have h9 : (9 : ℤ) ∣ (C * gE (gAddr x b) + (-C) * gE (gAddr y d)) := by
              refine dvd_trans ⟨3 ^ (μ - 2), ?_⟩ hdvd
              rw [show (9 : ℤ) = 3 ^ 2 from by norm_num, ← pow_add,
                show 2 + (μ - 2) = μ by omega]
            have hz0 : C * gE (gAddr x b) + (-C) * gE (gAddr y d) = 0 := by
              obtain ⟨w, hw⟩ := h9
              rcases hCv with rfl | rfl <;> omega
            rw [hz0, zero_mul] at hval
            refine absurd ⟨2 * hexE (uAddr (x - y) (b - d)).val
              + hexF (uAddr (x - y) (b - d)).val, ?_⟩ hκ3
            have h3p : (0 : ℤ) < 3 ^ μ := pow_pos (by norm_num) μ
            have he : (3 : ℤ) ^ (μ + 1) = 3 ^ μ * 3 := by ring
            rw [he] at hval
            have : (3 : ℤ) ^ μ * (κ - 3 * (2 * hexE (uAddr (x - y) (b - d)).val
                + hexF (uAddr (x - y) (b - d)).val)) = 0 := by linarith
            rcases mul_eq_zero.mp this with hh | hh
            · omega
            · linarith
        · -- k ≥ 1: the tie is impossible here
          exfalso
          obtain ⟨hpq, hpr⟩ := live_tie (C₁ := C) (C₂ := -C) (C₃ := -1) (κ := κ)
            (X := gAddr x b) (Y := gAddr y d) (Z := uAddr (x - y) (b - d))
            (m := 2 * μ) (n := 2 * ν) (k := (b - d).natAbs) (p := ν) (q := μ)
            (r := t + 1) (s := μ + ν) hC hnegC (by norm_num)
            (by omega) (by omega) hk0 (by omega) (by omega) hkill
          have hkr : (b - d).natAbs = 0 ∨ (b - d).natAbs = 2 * b.natAbs := by omega
          omega
  · -- (even, odd): the first g-trace is pinned against the constant
    exfalso
    rw [hμ, hν, show 2 * μ + (2 * ν + 1) = 2 * (μ + ν) + 1 by ring] at hcl
    simp only [pow_succ, sqrt3_pow_two_mul', pow_zero] at hcl
    have hsep : ((3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d))
          (2 * ν + 1)
        + (3 : ℂ) ^ t * 3 * hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
          (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs)
        + s3 * ((3 : ℂ) ^ ν * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ)
          + ((-(κ * 3 ^ (μ + ν)) : ℤ) : ℂ)) = 0 := by
      rw [← hexTrace_intMul, ← hexTrace_intMul, ← hexTrace_intMul]
      push_cast
      push_cast at hcl
      linear_combination hcl
    obtain ⟨-, hB⟩ := eq_zero_of_add_sqrt3_mul
      (((inRing_pow_trace' μ _ _ _)).add
        (((inRing_three_pow' t).mul (InRing.intCast 3)).mul (inRing_hexTrace _ _ _)))
      ((inRing_pow_trace' ν _ _ _).add (InRing.intCast _)) hsep
    have hpin : hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ)
        = ((κ * 3 ^ μ : ℤ) : ℂ) := by
      refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
      push_cast
      push_cast at hB
      linear_combination hB
    obtain ⟨hm0, hvv⟩ := g_rational hC0 hpin
    have hμ0 : μ = 0 := by omega
    subst hμ0
    have hg : ∀ z : ZMod 6, 2 * gE z + gF z = 3 ∨ 2 * gE z + gF z = 0
        ∨ 2 * gE z + gF z = -3 := by decide
    rw [pow_zero, mul_one] at hvv
    refine hκ3 ?_
    rcases hg (gAddr x b) with hv | hv | hv
    · rw [hv] at hvv; exact ⟨C, by omega⟩
    · rw [hv] at hvv; exact ⟨0, by omega⟩
    · rw [hv] at hvv; exact ⟨-C, by omega⟩
  · -- (odd, even): the second g-trace is pinned
    exfalso
    rw [hμ, hν, show 2 * μ + 1 + 2 * ν = 2 * (μ + ν) + 1 by ring] at hcl
    simp only [pow_succ, sqrt3_pow_two_mul', pow_zero] at hcl
    have hsep : ((3 : ℂ) ^ ν * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ + 1)
        + (3 : ℂ) ^ t * 3 * hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
          (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs)
        + s3 * ((3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν)
          + ((-(κ * 3 ^ (μ + ν)) : ℤ) : ℂ)) = 0 := by
      rw [← hexTrace_intMul, ← hexTrace_intMul, ← hexTrace_intMul]
      push_cast
      push_cast at hcl
      linear_combination hcl
    obtain ⟨-, hB⟩ := eq_zero_of_add_sqrt3_mul
      (((inRing_pow_trace' ν _ _ _)).add
        (((inRing_three_pow' t).mul (InRing.intCast 3)).mul (inRing_hexTrace _ _ _)))
      ((inRing_pow_trace' μ _ _ _).add (InRing.intCast _)) hsep
    have hpin : hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν)
        = ((κ * 3 ^ ν : ℤ) : ℂ) := by
      refine mul_left_cancel₀ (pow_ne_zero μ (by norm_num : (3 : ℂ) ≠ 0)) ?_
      push_cast
      push_cast at hB
      linear_combination hB
    obtain ⟨hn0, hvv⟩ := g_rational (neg_ne_zero.mpr hC0) hpin
    have hν0 : ν = 0 := by omega
    subst hν0
    have hg : ∀ z : ZMod 6, 2 * gE z + gF z = 3 ∨ 2 * gE z + gF z = 0
        ∨ 2 * gE z + gF z = -3 := by decide
    rw [pow_zero, mul_one] at hvv
    refine hκ3 ?_
    rcases hg (gAddr y d) with hv | hv | hv
    · rw [hv] at hvv; exact ⟨-C, by omega⟩
    · rw [hv] at hvv; exact ⟨0, by omega⟩
    · rw [hv] at hvv; exact ⟨C, by omega⟩
  · -- (odd, odd): the unit trace is pinned
    exfalso
    rw [hμ, hν, show 2 * μ + 1 + (2 * ν + 1) = 2 * (μ + ν + 1) by ring] at hcl
    simp only [pow_succ, sqrt3_pow_two_mul', pow_zero] at hcl
    have hsep : ((3 : ℂ) ^ t * 3 * hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
          (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs
        + ((-(κ * 3 ^ (μ + ν + 1)) : ℤ) : ℂ))
        + s3 * ((3 : ℂ) ^ ν * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ + 1)
          + (3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d))
            (2 * ν + 1)) = 0 := by
      rw [← hexTrace_intMul, ← hexTrace_intMul, ← hexTrace_intMul]
      push_cast
      push_cast at hcl
      linear_combination hcl
    obtain ⟨hA, -⟩ := eq_zero_of_add_sqrt3_mul
      ((((inRing_three_pow' t).mul (InRing.intCast 3)).mul (inRing_hexTrace _ _ _)).add
        (InRing.intCast _))
      ((inRing_pow_trace' ν _ _ _).add (inRing_pow_trace' μ _ _ _)) hsep
    simp only [one_mul] at hA
    obtain ⟨lam, hlam⟩ : ∃ l, (b - d).natAbs = 2 * l := ⟨(b - d).natAbs / 2, by omega⟩
    rcases Nat.eq_zero_or_pos lam with rfl | hl0
    · -- k = 0: the height-zero unit value against κ
      have ht0 : t = μ + ν + 1 := by omega
      subst ht0
      rw [hlam, show 2 * 0 = 0 from rfl, hexTrace_zero_height] at hA
      have hc : ((3 * (2 * hexE (uAddr (x - y) (b - d)).val
          + hexF (uAddr (x - y) (b - d)).val) - κ : ℤ) : ℂ) = 0 := by
        have h3p : ((3 : ℂ) ^ (μ + ν + 1)) ≠ 0 := pow_ne_zero _ (by norm_num)
        refine mul_left_cancel₀ h3p ?_
        push_cast
        push_cast at hA
        linear_combination hA
      have hz : 3 * (2 * hexE (uAddr (x - y) (b - d)).val
          + hexF (uAddr (x - y) (b - d)).val) - κ = 0 := by exact_mod_cast hc
      exact hκ3 ⟨2 * hexE (uAddr (x - y) (b - d)).val
        + hexF (uAddr (x - y) (b - d)).val, by omega⟩
    · -- k ≥ 2: the unit trace equals a rational multiple of a power of three
      have hpin : hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
          (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs
          = ((κ * 3 ^ (μ + ν + 1 - t - 1) : ℤ) : ℂ) := by
        rw [one_mul, one_mul]
        have hlt : t + 1 ≤ μ + ν + 1 := by omega
        refine mul_left_cancel₀ (pow_ne_zero (t + 1) (by norm_num : (3 : ℂ) ≠ 0)) ?_
        push_cast
        push_cast at hA
        rw [show ((3 : ℂ) ^ (t + 1)) * ((κ : ℂ) * 3 ^ (μ + ν + 1 - t - 1))
          = (κ : ℂ) * 3 ^ (μ + ν + 1) by
            rw [← mul_assoc, mul_comm ((3 : ℂ) ^ (t + 1)) (κ : ℂ), mul_assoc, ← pow_add,
              show t + 1 + (μ + ν + 1 - t - 1) = μ + ν + 1 by omega]]
        linear_combination hA
      rcases Nat.lt_or_ge (μ + ν + 1 - t - 1) 1 with hj | hj
      · -- the exponent is zero: height two forces ∓5
        have hj0 : μ + ν + 1 - t - 1 = 0 := by omega
        rw [hj0, pow_zero, mul_one] at hpin
        have hk2 : (b - d).natAbs = 2 := by omega
        rw [hk2] at hpin
        rcases u_pin_two hpin with h5 | h5 <;> omega
      · -- three divides the value: the pin forces height zero, contradiction
        have hdiv : (3 : ℤ) ∣ κ * 3 ^ (μ + ν + 1 - t - 1) := by
          obtain ⟨j, hj'⟩ : ∃ j, μ + ν + 1 - t - 1 = j + 1 := ⟨μ + ν + 1 - t - 1 - 1, by omega⟩
          rw [hj', pow_succ]
          exact ⟨κ * 3 ^ j, by ring⟩
        obtain ⟨hk0, -⟩ := u_rational (by norm_num) hpin hdiv
        omega

/-! ### §E.10 The ii-shape tree

`adj_ii` (C = 1, κ ∈ {0, 3}) and `opp_ii` (C = 2, κ ∈ {3, 6}) share one tree: live
parity (odd, odd), the tie at EQUAL heights, and every κ divisible by 3 — so the
dead-class pins and the `κ = W` endgame all fall to `3 ∤ 2·hexE + hexF`.  The only
survivor is the height-one tie, returned as data for the caller's decide. -/

private theorem piCoeff_one : piCoeff 1 = (0, 1) := rfl

private theorem hexW_not_dvd : ∀ z : ZMod 6, ¬ (3 : ℤ) ∣ (2 * hexE z.val + hexF z.val) := by
  decide

set_option maxHeartbeats 1000000 in
private theorem ii_shape {C : ℤ} (hC : ¬ (3 : ℤ) ∣ C) (hCv : C = 1 ∨ C = 2)
    {x y : ZMod 6} {b d : ℤ} {κ : ℤ} (hκ3 : (3 : ℤ) ∣ κ)
    (h : (C : ℂ) * s3 ^ 0 * gTr x b + ((-C : ℤ) : ℂ) * s3 ^ 0 * gTr y d
      + ((1 : ℤ) : ℂ) * s3 ^ 1 * uTr (x - y) (b - d) = (κ : ℂ) * s3 ^ 1) :
    b = d ∧ b.natAbs = 1
      ∧ C * gF (gAddr x b) + (-C) * gF (gAddr y d) = 0
      ∧ (C * gE (gAddr x b) + (-C) * gE (gAddr y d))
          * (2 * (piCoeff 1).1 + (piCoeff 1).2)
        = κ * 3 ^ 1 + 3 ^ 1 * (2 * ((-1) * hexE (uAddr (x - y) (b - d)).val)
          + (-1) * hexF (uAddr (x - y) (b - d)).val) := by
  have hC0 : C ≠ 0 := by rcases hCv with rfl | rfl <;> norm_num
  have hnegC : ¬ (3 : ℤ) ∣ (-C) := fun hh => hC ((dvd_neg).mp hh)
  obtain ⟨t, ht⟩ : ∃ t, b.natAbs + d.natAbs = (b - d).natAbs + 2 * t :=
    ⟨(b.natAbs + d.natAbs - (b - d).natAbs) / 2, by omega⟩
  have hcl := hex_cleared ht h
  obtain ⟨μ, hμ⟩ : ∃ μ, b.natAbs = 2 * μ ∨ b.natAbs = 2 * μ + 1 := ⟨b.natAbs / 2, by omega⟩
  obtain ⟨ν, hν⟩ : ∃ ν, d.natAbs = 2 * ν ∨ d.natAbs = 2 * ν + 1 := ⟨d.natAbs / 2, by omega⟩
  simp only [zero_add] at hcl
  rcases hμ with hμ | hμ <;> rcases hν with hν | hν
  · -- (even, even): the odd side pins the unit trace against κ; 3 ∣ κ kills it
    exfalso
    rw [hμ, hν, show 1 + 2 * μ + 2 * ν = 2 * (μ + ν) + 1 by ring] at hcl
    simp only [pow_succ, sqrt3_pow_two_mul', pow_zero] at hcl
    have hsep : ((3 : ℂ) ^ ν * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ)
        + (3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν))
        + s3 * ((3 : ℂ) ^ t * hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
            (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs
          + ((-(κ * 3 ^ (μ + ν)) : ℤ) : ℂ)) = 0 := by
      rw [← hexTrace_intMul, ← hexTrace_intMul, ← hexTrace_intMul]
      push_cast
      push_cast at hcl
      linear_combination hcl
    obtain ⟨-, hB⟩ := eq_zero_of_add_sqrt3_mul
      ((inRing_pow_trace' ν _ _ _).add (inRing_pow_trace' μ _ _ _))
      (((inRing_three_pow' t).mul (inRing_hexTrace _ _ _)).add (InRing.intCast _)) hsep
    have hpin : hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
        (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs
        = ((κ * 3 ^ (μ + ν - t) : ℤ) : ℂ) := by
      refine mul_left_cancel₀ (pow_ne_zero t (by norm_num : (3 : ℂ) ≠ 0)) ?_
      push_cast
      push_cast at hB
      rw [show ((3 : ℂ) ^ t) * ((κ : ℂ) * 3 ^ (μ + ν - t)) = (κ : ℂ) * 3 ^ (μ + ν) by
        rw [← mul_assoc, mul_comm ((3 : ℂ) ^ t) (κ : ℂ), mul_assoc, ← pow_add,
          show t + (μ + ν - t) = μ + ν by omega]]
      linear_combination hB
    obtain ⟨-, hval⟩ := u_rational (by norm_num) hpin (Dvd.dvd.mul_right hκ3 _)
    refine hexW_not_dvd (uAddr (x - y) (b - d)) ?_
    have h1 : 1 * (2 * hexE (uAddr (x - y) (b - d)).val
        + hexF (uAddr (x - y) (b - d)).val) = κ * 3 ^ (μ + ν - t) := hval
    rw [one_mul] at h1
    rw [h1]
    exact Dvd.dvd.mul_right hκ3 _
  · -- (even, odd): the second trace, at ODD height, is pinned against κ — dead
    exfalso
    rw [hμ, hν, show 1 + 2 * μ + (2 * ν + 1) = 2 * (μ + ν + 1) by ring] at hcl
    simp only [pow_succ, sqrt3_pow_two_mul', pow_zero] at hcl
    have hsep : ((3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d))
          (2 * ν + 1) + ((-(κ * 3 ^ (μ + ν + 1)) : ℤ) : ℂ))
        + s3 * ((3 : ℂ) ^ ν * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ)
          + (3 : ℂ) ^ t * hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
            (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs) = 0 := by
      rw [← hexTrace_intMul, ← hexTrace_intMul, ← hexTrace_intMul]
      push_cast
      push_cast at hcl
      linear_combination hcl
    obtain ⟨hA, -⟩ := eq_zero_of_add_sqrt3_mul
      ((inRing_pow_trace' μ _ _ _).add (InRing.intCast _))
      ((inRing_pow_trace' ν _ _ _).add
        ((inRing_three_pow' t).mul (inRing_hexTrace _ _ _))) hsep
    have hpin : hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν + 1)
        = ((κ * 3 ^ (ν + 1) : ℤ) : ℂ) := by
      refine mul_left_cancel₀ (pow_ne_zero μ (by norm_num : (3 : ℂ) ≠ 0)) ?_
      push_cast
      push_cast at hA
      rw [show ((3 : ℂ) ^ μ) * ((κ : ℂ) * 3 ^ (ν + 1)) = (κ : ℂ) * 3 ^ (μ + ν + 1) by
        rw [← mul_assoc, mul_comm ((3 : ℂ) ^ μ) (κ : ℂ), mul_assoc, ← pow_add,
          show μ + (ν + 1) = μ + ν + 1 by omega]]
      linear_combination hA
    obtain ⟨hm0, -⟩ := g_rational (neg_ne_zero.mpr hC0) hpin
    omega
  · -- (odd, even): the first trace, at ODD height, is pinned against κ — dead
    exfalso
    rw [hμ, hν, show 1 + (2 * μ + 1) + 2 * ν = 2 * (μ + ν + 1) by ring] at hcl
    simp only [pow_succ, sqrt3_pow_two_mul', pow_zero] at hcl
    have hsep : ((3 : ℂ) ^ ν * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b))
          (2 * μ + 1) + ((-(κ * 3 ^ (μ + ν + 1)) : ℤ) : ℂ))
        + s3 * ((3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν)
          + (3 : ℂ) ^ t * hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
            (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs) = 0 := by
      rw [← hexTrace_intMul, ← hexTrace_intMul, ← hexTrace_intMul]
      push_cast
      push_cast at hcl
      linear_combination hcl
    obtain ⟨hA, -⟩ := eq_zero_of_add_sqrt3_mul
      ((inRing_pow_trace' ν _ _ _).add (InRing.intCast _))
      ((inRing_pow_trace' μ _ _ _).add
        ((inRing_three_pow' t).mul (inRing_hexTrace _ _ _))) hsep
    have hpin : hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ + 1)
        = ((κ * 3 ^ (μ + 1) : ℤ) : ℂ) := by
      refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
      push_cast
      push_cast at hA
      rw [show ((3 : ℂ) ^ ν) * ((κ : ℂ) * 3 ^ (μ + 1)) = (κ : ℂ) * 3 ^ (μ + ν + 1) by
        rw [← mul_assoc, mul_comm ((3 : ℂ) ^ ν) (κ : ℂ), mul_assoc, ← pow_add,
          show ν + (μ + 1) = μ + ν + 1 by omega]]
      linear_combination hA
    obtain ⟨hm0, -⟩ := g_rational hC0 hpin
    omega
  · -- LIVE: both heights odd
    rw [hμ, hν, show 1 + (2 * μ + 1) + (2 * ν + 1) = 2 * (μ + ν + 1) + 1 by ring] at hcl
    simp only [pow_succ, sqrt3_pow_two_mul', pow_zero] at hcl
    have hkill : (3 : ℂ) ^ ν * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ + 1)
        + (3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν + 1)
        = (κ : ℂ) * 3 ^ (μ + ν + 1)
          + (3 : ℂ) ^ t * hexTrace ((-1) * hexE (uAddr (x - y) (b - d)).val)
            ((-1) * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs := by
      refine mul_right_cancel₀ sqrt3_ne ?_
      rw [← hexTrace_intMul, ← hexTrace_intMul, ← hexTrace_intMul]
      push_cast
      push_cast at hcl
      linear_combination hcl
    rcases Nat.eq_zero_or_pos (b - d).natAbs with hk0 | hk0
    · -- k = 0: equal heights, the collapse
      have hmn : μ = ν := by omega
      subst hmn
      have hts : t = 2 * μ + 1 := by omega
      subst hts
      rw [hk0, show (2 * μ + 1 : ℕ) = μ + (μ + 1) by ring] at hkill
      obtain ⟨hF, hval⟩ := kill_equal (C₁ := C) (C₂ := -C) (C₃ := -1) (κ := κ)
        (X := gAddr x b) (Y := gAddr y d) (Z := uAddr (x - y) (b - d))
        (m := μ + (μ + 1)) (p := μ) (s' := μ + 1) (r' := μ + 1) (by omega) hkill
      have hnd := not_three_dvd_pin (μ + (μ + 1)) (by omega)
      have hdvd : (3 : ℤ) ^ (μ + 1) ∣ (C * gE (gAddr x b) + (-C) * gE (gAddr y d)) := by
        refine pow_dvd_of_not_dvd
          (C := 2 * (piCoeff (μ + (μ + 1))).1 + (piCoeff (μ + (μ + 1))).2)
          (fun hh => hnd hh) ?_
        rw [mul_comm]
        exact ⟨κ + (2 * ((-1) * hexE (uAddr (x - y) (b - d)).val)
            + (-1) * hexF (uAddr (x - y) (b - d)).val), by rw [hval]; ring⟩
      rcases Nat.eq_zero_or_pos μ with hμ0 | hμ0
      · -- μ = 0: the boundary, returned as data
        subst hμ0
        exact ⟨by omega, by omega, hF, hval⟩
      · -- μ ≥ 1: 9 ∣ ΔE forces ΔE = 0, then κ = W refuses 3 ∣ κ
        exfalso
        have hsmall := gE_diff_small (gAddr x b) (gAddr y d)
        have h9 : (9 : ℤ) ∣ (C * gE (gAddr x b) + (-C) * gE (gAddr y d)) := by
          refine dvd_trans ⟨3 ^ (μ - 1), ?_⟩ hdvd
          rw [show (9 : ℤ) = 3 ^ 2 from by norm_num, ← pow_add,
            show 2 + (μ - 1) = μ + 1 by omega]
        have hz0 : C * gE (gAddr x b) + (-C) * gE (gAddr y d) = 0 := by
          obtain ⟨w, hw⟩ := h9
          rcases hCv with rfl | rfl <;> omega
        rw [hz0, zero_mul] at hval
        have hzz : (3 : ℤ) ^ (μ + 1) * (κ - (2 * hexE (uAddr (x - y) (b - d)).val
            + hexF (uAddr (x - y) (b - d)).val)) = 0 := by linear_combination -hval
        rcases mul_eq_zero.mp hzz with hh | hh
        · exact absurd hh (pow_ne_zero _ (by norm_num))
        · refine hexW_not_dvd (uAddr (x - y) (b - d)) ?_
          have hkW : κ = 2 * hexE (uAddr (x - y) (b - d)).val
              + hexF (uAddr (x - y) (b - d)).val := by omega
          exact hkW ▸ hκ3
    · -- k ≥ 1: the tie is impossible (equal |b| = |d| forces b = −d, then t = 0)
      exfalso
      obtain ⟨hpq, hpr⟩ := live_tie (C₁ := C) (C₂ := -C) (C₃ := -1) (κ := κ)
        (X := gAddr x b) (Y := gAddr y d) (Z := uAddr (x - y) (b - d))
        (m := 2 * μ + 1) (n := 2 * ν + 1) (k := (b - d).natAbs) (p := ν) (q := μ)
        (r := t) (s := μ + ν + 1) hC hnegC (by norm_num)
        (by omega) (by omega) hk0 (by omega) (by omega) hkill
      have hkr : (b - d).natAbs = 0 ∨ (b - d).natAbs = 2 * b.natAbs := by omega
      omega

/-! ### §E.11 The oi-shape tree

`adj_oi` (C = 1, κ ∈ {2, 5}) and `opp_oi` (C = 2, κ ∈ {5, 8}) — and, at negated `C`
with the roles swapped, the two io families.  Live parity (even, odd); the tie is at
ADJACENT heights, `kill_adjacent` closes every rung `μ ≥ 2`, and the `μ = 1`
boundary — heights (2, 1) — is returned as the two integer rows for the caller's
decide.  The io mirror: negate `C`, swap `(x,b) ↔ (y,d)` (`uTr_neg`). -/

private theorem uTr_neg (c : ZMod 6) (d : ℤ) : uTr (-c) (-d) = uTr c d := by
  rw [uTr, uTr, neg_neg, neg_neg, add_comm]

set_option maxHeartbeats 1000000 in
private theorem oi_shape {C : ℤ} (hC : ¬ (3 : ℤ) ∣ C) (hC0 : C ≠ 0)
    {x y : ZMod 6} {b d : ℤ}
    {κ : ℤ} (hκ3 : ¬ (3 : ℤ) ∣ κ) (hκv : κ = 2 ∨ κ = 5 ∨ κ = 8)
    (h : (C : ℂ) * s3 ^ 1 * gTr x b + ((-C : ℤ) : ℂ) * s3 ^ 0 * gTr y d
      + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (x - y) (b - d) = (κ : ℂ) * s3 ^ 1) :
    ((b = 2 ∧ d = 1) ∨ (b = -2 ∧ d = -1))
    ∧ C * gF (gAddr x b) + (-C) * gF (gAddr y d)
        + 3 * hexF (uAddr (x - y) (b - d)).val = 0
    ∧ -3 * (C * gE (gAddr x b)) - 2 * (C * gE (gAddr x b) + C * gF (gAddr x b))
        + ((-C) * gE (gAddr y d) + (-C) * gF (gAddr y d))
        + 3 * (hexE (uAddr (x - y) (b - d)).val + hexF (uAddr (x - y) (b - d)).val)
      = 3 * κ := by
  have hnegC : ¬ (3 : ℤ) ∣ (-C) := fun hh => hC ((dvd_neg).mp hh)
  obtain ⟨t, ht⟩ : ∃ t, b.natAbs + d.natAbs = (b - d).natAbs + 2 * t :=
    ⟨(b.natAbs + d.natAbs - (b - d).natAbs) / 2, by omega⟩
  have hcl := hex_cleared ht h
  obtain ⟨μ, hμ⟩ : ∃ μ, b.natAbs = 2 * μ ∨ b.natAbs = 2 * μ + 1 := ⟨b.natAbs / 2, by omega⟩
  obtain ⟨ν, hν⟩ : ∃ ν, d.natAbs = 2 * ν ∨ d.natAbs = 2 * ν + 1 := ⟨d.natAbs / 2, by omega⟩
  simp only [zero_add, pow_zero] at hcl
  rcases hμ with hμ | hμ <;> rcases hν with hν | hν
  · -- (even, even): the odd side pins the FIRST trace (even height) at value κ·3^μ,
    -- and every candidate value is divisible by 3 while κ is not — dead
    exfalso
    rw [hμ, hν, show 1 + 2 * μ + 2 * ν = 2 * (μ + ν) + 1 by ring,
      show (1 : ℕ) + 2 * ν = 2 * ν + 1 by ring] at hcl
    simp only [pow_succ, sqrt3_pow_two_mul'] at hcl
    have hsep : ((3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν)
        + (3 : ℂ) ^ t * 3 * hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
          (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs)
        + s3 * ((3 : ℂ) ^ ν * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ)
          + ((-(κ * 3 ^ (μ + ν)) : ℤ) : ℂ)) = 0 := by
      rw [← hexTrace_intMul, ← hexTrace_intMul, ← hexTrace_intMul]
      push_cast
      push_cast at hcl
      linear_combination hcl
    obtain ⟨-, hB⟩ := eq_zero_of_add_sqrt3_mul
      ((inRing_pow_trace' μ _ _ _).add
        (((inRing_three_pow' t).mul (InRing.intCast 3)).mul (inRing_hexTrace _ _ _)))
      ((inRing_pow_trace' ν _ _ _).add (InRing.intCast _)) hsep
    have hpin : hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ)
        = ((κ * 3 ^ μ : ℤ) : ℂ) := by
      refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
      push_cast
      push_cast at hB
      linear_combination hB
    obtain ⟨hm0, hvv⟩ := g_rational hC0 hpin
    have hμ0 : μ = 0 := by omega
    subst hμ0
    have hg : ∀ z : ZMod 6, 2 * gE z + gF z = 3 ∨ 2 * gE z + gF z = 0
        ∨ 2 * gE z + gF z = -3 := by decide
    rw [pow_zero, mul_one] at hvv
    refine hκ3 ?_
    rcases hg (gAddr x b) with hv | hv | hv
    · rw [hv] at hvv; exact ⟨C, by omega⟩
    · rw [hv] at hvv; exact ⟨0, by omega⟩
    · rw [hv] at hvv; exact ⟨-C, by omega⟩
  · -- LIVE: (even, odd)
    rw [hμ, hν, show 1 + 2 * μ + (2 * ν + 1) = 2 * (μ + ν + 1) by ring,
      show (1 : ℕ) + (2 * ν + 1) = 2 * (ν + 1) by ring] at hcl
    simp only [sqrt3_pow_two_mul'] at hcl
    have hkill : (3 : ℂ) ^ (ν + 1) * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ)
        + (3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν + 1)
        = (κ : ℂ) * 3 ^ (μ + ν + 1)
          + (3 : ℂ) ^ (t + 1) * hexTrace ((-1) * hexE (uAddr (x - y) (b - d)).val)
            ((-1) * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs := by
      rw [← hexTrace_intMul, ← hexTrace_intMul, ← hexTrace_intMul]
      push_cast
      push_cast at hcl
      linear_combination hcl
    rcases Nat.eq_zero_or_pos μ with hμ0 | hμ0
    · -- b = 0: the second trace is alone at the bottom — dead
      exfalso
      subst hμ0
      exact kill_alone_two (C₁ := C) (C₂ := -C) (C₃ := -1) (κ := κ)
        (X := gAddr x b) (Y := gAddr y d) (Z := uAddr (x - y) (b - d))
        (m := 2 * 0) (n := 2 * ν + 1) (k := (b - d).natAbs) (p := ν + 1) (q := 0)
        (r := t + 1) (s := 0 + ν + 1) hnegC (by omega) (by omega) (by omega) (by omega) hkill
    · -- μ ≥ 1: the tie at ADJACENT heights
      obtain ⟨hpq, hpr⟩ := live_tie (C₁ := C) (C₂ := -C) (C₃ := -1) (κ := κ)
        (X := gAddr x b) (Y := gAddr y d) (Z := uAddr (x - y) (b - d))
        (m := 2 * μ) (n := 2 * ν + 1) (k := (b - d).natAbs) (p := ν + 1) (q := μ)
        (r := t + 1) (s := μ + ν + 1) hC hnegC (by norm_num)
        (by omega) (by omega) (by omega) (by omega) (by omega) hkill
      -- ν + 1 = μ and t > ν: same sign, k = 1, t = 2ν + 1
      have hk1 : (b - d).natAbs = 1 := by omega
      have htv : t = 2 * ν + 1 := by omega
      subst htv
      have hμv : μ = ν + 1 := by omega
      subst hμv
      -- rewrite the y-trace through the +3 address shift so both coefficients are C
      have hshift : hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν + 1)
          = hexTrace (C * gE (gAddr y d + 3)) (C * gF (gAddr y d + 3)) (2 * ν + 1) := by
        rw [gE_shift_three, gF_shift_three]
        ring_nf
      rcases Nat.eq_zero_or_pos ν with hν0 | hν0
      · -- ν = 0: THE BOUNDARY, heights (2, 1) — extract the two rows
        subst hν0
        obtain ⟨R1, R2⟩ := row_pair (C₁ := C) (C₂ := -C) (C₃ := -1) (κ := κ)
          (X := gAddr x b) (Y := gAddr y d) (Z := uAddr (x - y) (b - d))
          (m := 2 * 1) (n := 2 * 0 + 1) (k := (b - d).natAbs)
          (p := 0 + 1) (q := 1) (r := 2 * 0 + 1 + 1) (s := 1 + 0 + 1) hkill
        rw [hk1] at R1 R2
        rw [show (2 * 1 : ℕ) = 2 from rfl, show (2 * 0 + 1 : ℕ) = 1 from rfl,
          piCoeff_two, piCoeff_one] at R1 R2
        refine ⟨by omega, ?_, ?_⟩
        · have h3F : 3 * (C * gF (gAddr x b) + (-C) * gF (gAddr y d)
              + 3 * hexF (uAddr (x - y) (b - d)).val) = 0 := by linear_combination R2
          linarith
        · have h3E : 3 * (-3 * (C * gE (gAddr x b))
              - 2 * (C * gE (gAddr x b) + C * gF (gAddr x b))
              + ((-C) * gE (gAddr y d) + (-C) * gF (gAddr y d))
              + 3 * (hexE (uAddr (x - y) (b - d)).val + hexF (uAddr (x - y) (b - d)).val)
              - 3 * κ) = 0 := by linear_combination R1
          linarith
      · -- ν ≥ 1: adjacent heights (2ν+1, 2ν+2) with two clear levels — dead
        exfalso
        rw [hshift] at hkill
        refine kill_adjacent (C := C) (C₃ := -1) (κ := κ)
          (X := gAddr y d + 3) (Y := gAddr x b) (Z := uAddr (x - y) (b - d))
          (m := 2 * ν + 1) (k := (b - d).natAbs)
          (p := ν + 1) (r := 2 * ν + 1 + 1) (s := ν + 1 + ν + 1)
          hC (by omega) (by omega) (by omega) ?_
        rw [show (2 * ν + 1 + 1 : ℕ) = 2 * (ν + 1) from by ring]
        linear_combination hkill
  · -- (odd, even): the even side pins the unit trace; k is odd, so k = 1 pins
    -- `hexE = κ` (refused by κ ∈ {2,5,8}) and k ≥ 3 forces height zero — dead
    exfalso
    rw [hμ, hν, show 1 + (2 * μ + 1) + 2 * ν = 2 * (μ + ν + 1) by ring,
      show (1 : ℕ) + 2 * ν = 2 * ν + 1 by ring] at hcl
    simp only [pow_succ, sqrt3_pow_two_mul'] at hcl
    have hsep : ((3 : ℂ) ^ t * 3 * hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
          (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs
        + ((-(κ * 3 ^ (μ + ν + 1)) : ℤ) : ℂ))
        + s3 * ((3 : ℂ) ^ ν * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b)) (2 * μ + 1)
          + (3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν))
        = 0 := by
      rw [← hexTrace_intMul, ← hexTrace_intMul, ← hexTrace_intMul]
      push_cast
      push_cast at hcl
      linear_combination hcl
    obtain ⟨hA, -⟩ := eq_zero_of_add_sqrt3_mul
      ((((inRing_three_pow' t).mul (InRing.intCast 3)).mul (inRing_hexTrace _ _ _)).add
        (InRing.intCast _))
      ((inRing_pow_trace' ν _ _ _).add (inRing_pow_trace' μ _ _ _)) hsep
    simp only [one_mul] at hA
    -- k = |b − d| is odd here; t + 1 ≤ μ + ν + 1
    have hko : (b - d).natAbs = 2 * (μ + ν - t) + 1 := by omega
    have hpin : hexTrace (hexE (uAddr (x - y) (b - d)).val)
        (hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs
        = ((κ * 3 ^ (μ + ν - t) : ℤ) : ℂ) := by
      refine mul_left_cancel₀ (pow_ne_zero (t + 1) (by norm_num : (3 : ℂ) ≠ 0)) ?_
      push_cast
      push_cast at hA
      rw [show ((3 : ℂ) ^ (t + 1)) * ((κ : ℂ) * 3 ^ (μ + ν - t)) = (κ : ℂ) * 3 ^ (μ + ν + 1) by
        rw [← mul_assoc, mul_comm ((3 : ℂ) ^ (t + 1)) (κ : ℂ), mul_assoc, ← pow_add,
          show t + 1 + (μ + ν - t) = μ + ν + 1 by omega]]
      linear_combination hA
    rcases Nat.eq_zero_or_pos (μ + ν - t) with hj0 | hj1
    · -- k = 1: the height-one pin reads hexE = κ
      rw [hj0, pow_zero, mul_one] at hpin
      rw [hko, hj0] at hpin
      obtain ⟨hF1, hval⟩ := hexTrace_pin (h := 2 * 0 + 1) (by norm_num) hpin
      rw [show (2 * 0 + 1 : ℕ) = 1 from rfl, piCoeff_one] at hval
      have hE : ∀ z : ZMod 6, hexE z.val = 0 ∨ hexE z.val = 1 ∨ hexE z.val = -1 := by decide
      rcases hE (uAddr (x - y) (b - d)) with hv | hv | hv <;> rw [hv] at hval <;> omega
    · -- k ≥ 3: three divides the value, the pin forces height zero — contradiction
      have hdiv : (3 : ℤ) ∣ κ * 3 ^ (μ + ν - t) := by
        obtain ⟨j, hj'⟩ : ∃ j, μ + ν - t = j + 1 := ⟨μ + ν - t - 1, by omega⟩
        rw [hj', pow_succ]
        exact ⟨κ * 3 ^ j, by ring⟩
      have hpin' : hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
          (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs
          = ((κ * 3 ^ (μ + ν - t) : ℤ) : ℂ) := by
        rw [one_mul, one_mul]
        exact hpin
      obtain ⟨hk0, -⟩ := u_rational (by norm_num) hpin' hdiv
      omega
  · -- (odd, odd): the second trace, at ODD height, is pinned — dead
    exfalso
    rw [hμ, hν, show 1 + (2 * μ + 1) + (2 * ν + 1) = 2 * (μ + ν + 1) + 1 by ring,
      show (1 : ℕ) + (2 * ν + 1) = 2 * (ν + 1) by ring] at hcl
    simp only [pow_succ, sqrt3_pow_two_mul'] at hcl
    have hsep : ((3 : ℂ) ^ (ν + 1) * hexTrace (C * gE (gAddr x b)) (C * gF (gAddr x b))
          (2 * μ + 1)
        + (3 : ℂ) ^ t * 3 * hexTrace (1 * hexE (uAddr (x - y) (b - d)).val)
            (1 * hexF (uAddr (x - y) (b - d)).val) (b - d).natAbs)
        + s3 * ((3 : ℂ) ^ μ * hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d))
            (2 * ν + 1)
          + ((-(κ * 3 ^ (μ + ν + 1)) : ℤ) : ℂ)) = 0 := by
      rw [← hexTrace_intMul, ← hexTrace_intMul, ← hexTrace_intMul]
      push_cast
      push_cast at hcl
      linear_combination hcl
    obtain ⟨-, hB⟩ := eq_zero_of_add_sqrt3_mul
      ((inRing_pow_trace' (ν + 1) _ _ _).add
        (((inRing_three_pow' t).mul (InRing.intCast 3)).mul (inRing_hexTrace _ _ _)))
      ((inRing_pow_trace' μ _ _ _).add (InRing.intCast _)) hsep
    have hpin : hexTrace ((-C) * gE (gAddr y d)) ((-C) * gF (gAddr y d)) (2 * ν + 1)
        = ((κ * 3 ^ (ν + 1) : ℤ) : ℂ) := by
      refine mul_left_cancel₀ (pow_ne_zero μ (by norm_num : (3 : ℂ) ≠ 0)) ?_
      push_cast
      push_cast at hB
      rw [show ((3 : ℂ) ^ μ) * ((κ : ℂ) * 3 ^ (ν + 1)) = (κ : ℂ) * 3 ^ (μ + ν + 1) by
        rw [← mul_assoc, mul_comm ((3 : ℂ) ^ μ) (κ : ℂ), mul_assoc, ← pow_add,
          show μ + (ν + 1) = μ + ν + 1 by omega]]
      linear_combination hB
    obtain ⟨hm0, -⟩ := g_rational (neg_ne_zero.mpr hC0) hpin
    omega

/-! ### §E.12 The family bridges in cleared currency

`hex_master` at `R := normSq E` is an unconditional identity, so each family's
`normSq = R ⟺ cleared κ-equation` is one lemma serving the chord (`R = 3`) and the
fusion (`R = 0`) at once — `κ` is `7−R, 5−R, 3−R` (adjacent oo/oi=io/ii) and
`10−R, 8−R, 6−R` (opposite), exactly the recipe table. -/

private theorem hex_master_eq (x y : ZMod 6) (b d : ℤ) (α β γ : ℝ) :
    ((normSq ((α : ℂ) * gC * word x b - (β : ℂ) * gC * word y d - (γ : ℂ)) : ℝ) : ℂ)
      = ((3 * α ^ 2 + 3 * β ^ 2 + γ ^ 2 : ℝ) : ℂ)
        - (α : ℂ) * (γ : ℂ) * gTr x b + (β : ℂ) * (γ : ℂ) * gTr y d
        - 3 * ((α : ℂ) * (β : ℂ)) * uTr (x - y) (b - d) := by
  have h := hex_master (x := x) (y := y) (b := b) (d := d) (α := α) (β := β) (γ := γ)
    (R := normSq ((α : ℂ) * gC * word x b - (β : ℂ) * gC * word y d - (γ : ℂ))) rfl
  push_cast at h ⊢
  linear_combination -h

private theorem normSq_castR {E : ℂ} {R : ℝ} :
    normSq E = R ↔ ((normSq E : ℝ) : ℂ) = ((R : ℝ) : ℂ) :=
  ⟨fun hh => by exact_mod_cast hh, fun hh => by exact_mod_cast hh⟩

private theorem outerPt_anchor' (p : ℂ) (x : ZMod 6) (b : ℤ) :
    outerPt p (p + 1) x b = p + ((1 : ℝ) : ℂ) * word x b := by
  rw [outerPt_anchor]; push_cast; ring

/-- The address evaluations at the boundary heights, all `rfl`. -/
private theorem gAddr_two (A : ZMod 6) : gAddr A 2 = A := rfl
private theorem gAddr_neg_two (A : ZMod 6) : gAddr A (-2) = -A - 1 := rfl
private theorem gAddr_one (A : ZMod 6) : gAddr A 1 = A := rfl
private theorem gAddr_neg_one (A : ZMod 6) : gAddr A (-1) = -A - 1 := rfl
private theorem uAddr_zero (c : ZMod 6) : uAddr c 0 = c := rfl
private theorem uAddr_one (c : ZMod 6) : uAddr c 1 = c := rfl
private theorem uAddr_neg_one (c : ZMod 6) : uAddr c (-1) = -c := rfl

private theorem adj_oo_clear (x y : ZMod 6) (b d : ℤ) {R : ℝ} {κ : ℤ}
    (hκ : (κ : ℝ) = 7 - R) :
    normSq (((1 : ℝ) : ℂ) * gC * word x b - ((1 : ℝ) : ℂ) * gC * word y d
      - ((1 : ℝ) : ℂ)) = R ↔
      ((1 : ℤ) : ℂ) * s3 ^ 0 * gTr x b + ((-1 : ℤ) : ℂ) * s3 ^ 0 * gTr y d
        + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (x - y) (b - d) = (κ : ℂ) * s3 ^ 0 := by
  have hκC : ((κ : ℤ) : ℂ) = 7 - ((R : ℝ) : ℂ) := by exact_mod_cast hκ
  rw [normSq_castR, hex_master_eq x y b d 1 1 1]
  push_cast
  constructor
  · intro h
    linear_combination -h - hκC
  · intro h
    linear_combination -h - hκC

private theorem adj_oi_clear (x y : ZMod 6) (b d : ℤ) {R : ℝ} {κ : ℤ}
    (hκ : (κ : ℝ) = 5 - R) :
    normSq (((1 : ℝ) : ℂ) * gC * word x b - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word y d
      - ((1 : ℝ) : ℂ)) = R ↔
      ((1 : ℤ) : ℂ) * s3 ^ 1 * gTr x b + ((-1 : ℤ) : ℂ) * s3 ^ 0 * gTr y d
        + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (x - y) (b - d) = (κ : ℂ) * s3 ^ 1 := by
  have hκC : ((κ : ℤ) : ℂ) = 5 - ((R : ℝ) : ℂ) := by exact_mod_cast hκ
  rw [normSq_castR, show ((normSq (((1 : ℝ) : ℂ) * gC * word x b
        - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word y d - ((1 : ℝ) : ℂ)) : ℝ) : ℂ)
      = 5 - gTr x b + (s3 / 3) * gTr y d - s3 * uTr (x - y) (b - d) from by
    have h0 := hex_master_eq x y b d 1 (Real.sqrt 3 / 3) 1
    push_cast at h0 ⊢
    linear_combination h0 + (1 / 3 : ℂ) * sqrt3_cast_sq]
  push_cast
  constructor
  · intro h
    linear_combination (-s3) * h - s3 * hκC
      + (gTr y d / 3 - uTr (x - y) (b - d)) * sqrt3_cast_sq
  · intro h
    linear_combination (-s3 / 3) * h - hκC + ((gTr x b - κ) / 3) * sqrt3_cast_sq

private theorem adj_io_clear (x y : ZMod 6) (b d : ℤ) {R : ℝ} {κ : ℤ}
    (hκ : (κ : ℝ) = 5 - R) :
    normSq (((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word x b - ((1 : ℝ) : ℂ) * gC * word y d
      - ((1 : ℝ) : ℂ)) = R ↔
      ((1 : ℤ) : ℂ) * s3 ^ 0 * gTr x b + ((-1 : ℤ) : ℂ) * s3 ^ 1 * gTr y d
        + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (x - y) (b - d) = (κ : ℂ) * s3 ^ 1 := by
  have hκC : ((κ : ℤ) : ℂ) = 5 - ((R : ℝ) : ℂ) := by exact_mod_cast hκ
  rw [normSq_castR, show ((normSq (((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word x b
        - ((1 : ℝ) : ℂ) * gC * word y d - ((1 : ℝ) : ℂ)) : ℝ) : ℂ)
      = 5 - (s3 / 3) * gTr x b + gTr y d - s3 * uTr (x - y) (b - d) from by
    have h0 := hex_master_eq x y b d (Real.sqrt 3 / 3) 1 1
    push_cast at h0 ⊢
    linear_combination h0 + (1 / 3 : ℂ) * sqrt3_cast_sq]
  push_cast
  constructor
  · intro h
    linear_combination (-s3) * h - s3 * hκC
      + (-(gTr x b) / 3 - uTr (x - y) (b - d)) * sqrt3_cast_sq
  · intro h
    linear_combination (-s3 / 3) * h - hκC - ((gTr y d + κ) / 3) * sqrt3_cast_sq

private theorem adj_ii_clear (x y : ZMod 6) (b d : ℤ) {R : ℝ} {κ : ℤ}
    (hκ : (κ : ℝ) = 3 - R) :
    normSq (((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word x b
      - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word y d - ((1 : ℝ) : ℂ)) = R ↔
      ((1 : ℤ) : ℂ) * s3 ^ 0 * gTr x b + ((-1 : ℤ) : ℂ) * s3 ^ 0 * gTr y d
        + ((1 : ℤ) : ℂ) * s3 ^ 1 * uTr (x - y) (b - d) = (κ : ℂ) * s3 ^ 1 := by
  have hκC : ((κ : ℤ) : ℂ) = 3 - ((R : ℝ) : ℂ) := by exact_mod_cast hκ
  rw [normSq_castR, show ((normSq (((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word x b
        - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word y d - ((1 : ℝ) : ℂ)) : ℝ) : ℂ)
      = 3 - (s3 / 3) * gTr x b + (s3 / 3) * gTr y d - uTr (x - y) (b - d) from by
    have h0 := hex_master_eq x y b d (Real.sqrt 3 / 3) (Real.sqrt 3 / 3) 1
    push_cast at h0 ⊢
    linear_combination h0 + ((2 - uTr (x - y) (b - d)) / 3) * sqrt3_cast_sq]
  push_cast
  constructor
  · intro h
    linear_combination (-s3) * h - s3 * hκC
      + ((gTr y d - gTr x b) / 3) * sqrt3_cast_sq
  · intro h
    linear_combination (-s3 / 3) * h - hκC
      + ((uTr (x - y) (b - d) - κ) / 3) * sqrt3_cast_sq

private theorem opp_oo_clear (x y : ZMod 6) (b d : ℤ) {R : ℝ} {κ : ℤ}
    (hκ : (κ : ℝ) = 10 - R) :
    normSq (((1 : ℝ) : ℂ) * gC * word (x - 1) b - ((1 : ℝ) : ℂ) * gC * word (y - 1) d
      - ((2 : ℝ) : ℂ)) = R ↔
      ((2 : ℤ) : ℂ) * s3 ^ 0 * gTr (x - 1) b + ((-2 : ℤ) : ℂ) * s3 ^ 0 * gTr (y - 1) d
        + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (x - 1 - (y - 1)) (b - d) = (κ : ℂ) * s3 ^ 0 := by
  have hκC : ((κ : ℤ) : ℂ) = 10 - ((R : ℝ) : ℂ) := by exact_mod_cast hκ
  rw [normSq_castR, hex_master_eq (x - 1) (y - 1) b d 1 1 2]
  push_cast
  constructor
  · intro h
    linear_combination -h - hκC
  · intro h
    linear_combination -h - hκC

private theorem opp_oi_clear (x y : ZMod 6) (b d : ℤ) {R : ℝ} {κ : ℤ}
    (hκ : (κ : ℝ) = 8 - R) :
    normSq (((1 : ℝ) : ℂ) * gC * word (x - 1) b
      - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word (y - 1) d - ((2 : ℝ) : ℂ)) = R ↔
      ((2 : ℤ) : ℂ) * s3 ^ 1 * gTr (x - 1) b + ((-2 : ℤ) : ℂ) * s3 ^ 0 * gTr (y - 1) d
        + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (x - 1 - (y - 1)) (b - d) = (κ : ℂ) * s3 ^ 1 := by
  have hκC : ((κ : ℤ) : ℂ) = 8 - ((R : ℝ) : ℂ) := by exact_mod_cast hκ
  rw [normSq_castR, show ((normSq (((1 : ℝ) : ℂ) * gC * word (x - 1) b
        - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word (y - 1) d - ((2 : ℝ) : ℂ)) : ℝ) : ℂ)
      = 8 - 2 * gTr (x - 1) b + (2 * s3 / 3) * gTr (y - 1) d
        - s3 * uTr (x - 1 - (y - 1)) (b - d) from by
    have h0 := hex_master_eq (x - 1) (y - 1) b d 1 (Real.sqrt 3 / 3) 2
    push_cast at h0 ⊢
    linear_combination h0 + (1 / 3 : ℂ) * sqrt3_cast_sq]
  push_cast
  constructor
  · intro h
    linear_combination (-s3) * h - s3 * hκC
      + (2 * gTr (y - 1) d / 3 - uTr (x - 1 - (y - 1)) (b - d)) * sqrt3_cast_sq
  · intro h
    linear_combination (-s3 / 3) * h - hκC + ((2 * gTr (x - 1) b - κ) / 3) * sqrt3_cast_sq

private theorem opp_io_clear (x y : ZMod 6) (b d : ℤ) {R : ℝ} {κ : ℤ}
    (hκ : (κ : ℝ) = 8 - R) :
    normSq (((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word (x - 1) b
      - ((1 : ℝ) : ℂ) * gC * word (y - 1) d - ((2 : ℝ) : ℂ)) = R ↔
      ((2 : ℤ) : ℂ) * s3 ^ 0 * gTr (x - 1) b + ((-2 : ℤ) : ℂ) * s3 ^ 1 * gTr (y - 1) d
        + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (x - 1 - (y - 1)) (b - d) = (κ : ℂ) * s3 ^ 1 := by
  have hκC : ((κ : ℤ) : ℂ) = 8 - ((R : ℝ) : ℂ) := by exact_mod_cast hκ
  rw [normSq_castR, show ((normSq (((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word (x - 1) b
        - ((1 : ℝ) : ℂ) * gC * word (y - 1) d - ((2 : ℝ) : ℂ)) : ℝ) : ℂ)
      = 8 - (2 * s3 / 3) * gTr (x - 1) b + 2 * gTr (y - 1) d
        - s3 * uTr (x - 1 - (y - 1)) (b - d) from by
    have h0 := hex_master_eq (x - 1) (y - 1) b d (Real.sqrt 3 / 3) 1 2
    push_cast at h0 ⊢
    linear_combination h0 + (1 / 3 : ℂ) * sqrt3_cast_sq]
  push_cast
  constructor
  · intro h
    linear_combination (-s3) * h - s3 * hκC
      + (-(2 * gTr (x - 1) b) / 3 - uTr (x - 1 - (y - 1)) (b - d)) * sqrt3_cast_sq
  · intro h
    linear_combination (-s3 / 3) * h - hκC - ((2 * gTr (y - 1) d + κ) / 3) * sqrt3_cast_sq

private theorem opp_ii_clear (x y : ZMod 6) (b d : ℤ) {R : ℝ} {κ : ℤ}
    (hκ : (κ : ℝ) = 6 - R) :
    normSq (((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word (x - 1) b
      - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word (y - 1) d - ((2 : ℝ) : ℂ)) = R ↔
      ((2 : ℤ) : ℂ) * s3 ^ 0 * gTr (x - 1) b + ((-2 : ℤ) : ℂ) * s3 ^ 0 * gTr (y - 1) d
        + ((1 : ℤ) : ℂ) * s3 ^ 1 * uTr (x - 1 - (y - 1)) (b - d) = (κ : ℂ) * s3 ^ 1 := by
  have hκC : ((κ : ℤ) : ℂ) = 6 - ((R : ℝ) : ℂ) := by exact_mod_cast hκ
  rw [normSq_castR, show ((normSq (((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word (x - 1) b
        - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * gC * word (y - 1) d - ((2 : ℝ) : ℂ)) : ℝ) : ℂ)
      = 6 - (2 * s3 / 3) * gTr (x - 1) b + (2 * s3 / 3) * gTr (y - 1) d
        - uTr (x - 1 - (y - 1)) (b - d) from by
    have h0 := hex_master_eq (x - 1) (y - 1) b d (Real.sqrt 3 / 3) (Real.sqrt 3 / 3) 2
    push_cast at h0 ⊢
    linear_combination h0 + ((2 - uTr (x - 1 - (y - 1)) (b - d)) / 3) * sqrt3_cast_sq]
  push_cast
  constructor
  · intro h
    linear_combination (-s3) * h - s3 * hκC
      + (2 * (gTr (y - 1) d - gTr (x - 1) b) / 3) * sqrt3_cast_sq
  · intro h
    linear_combination (-s3 / 3) * h - hκC
      + ((uTr (x - 1 - (y - 1)) (b - d) - κ) / 3) * sqrt3_cast_sq

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

/-- The value-of-a-`val`-cast fact behind every wrapper, decided once. -/
private theorem zmod_cast_val : ∀ z : ZMod 6, ((z.val : ℕ) : ZMod 6) = z := by decide

/-- The oo boundary refutation, shared by the four empty oo instances. -/
private theorem oo_bnd_empty {C κ : ℤ} (hCv : C = 1 ∨ C = 2) (hκv : κ = 4 ∨ κ = 7 ∨ κ = 10)
    (hno : ¬ (C = 2 ∧ κ = 7)) {x y : ZMod 6} {b d : ℤ} (hbd : b = d) (hb2 : b.natAbs = 2)
    (hF : C * gF (gAddr x b) + (-C) * gF (gAddr y d) = 0)
    (hE : (C * gE (gAddr x b) + (-C) * gE (gAddr y d))
        * (2 * (piCoeff 2).1 + (piCoeff 2).2)
      = κ * 3 ^ 1 + 3 ^ 2 * (2 * ((-1) * hexE (uAddr (x - y) (b - d)).val)
        + (-1) * hexF (uAddr (x - y) (b - d)).val)) : False := by
  subst hbd
  have hb : b = 2 ∨ b = -2 := by omega
  rcases hb with rfl | rfl
  · rw [gAddr_two, gAddr_two] at hF hE
    rw [show (2 : ℤ) - 2 = 0 from rfl, uAddr_zero] at hE
    revert hF hE
    rcases hCv with rfl | rfl <;> rcases hκv with rfl | rfl | rfl <;>
      first
        | (exact fun hF hE => hno ⟨rfl, rfl⟩)
        | (revert x y; decide)
  · rw [gAddr_neg_two, gAddr_neg_two] at hF hE
    rw [show (-2 : ℤ) - -2 = 0 from rfl, uAddr_zero] at hE
    revert hF hE
    rcases hCv with rfl | rfl <;> rcases hκv with rfl | rfl | rfl <;>
      first
        | (exact fun hF hE => hno ⟨rfl, rfl⟩)
        | (revert x y; decide)

/-- The oo zero-height refutation, shared by all four oo instances. -/
private theorem oo_zero_empty {C κ : ℤ} (hCv : C = 1 ∨ C = 2) (hκv : κ = 4 ∨ κ = 7 ∨ κ = 10)
    {x y : ZMod 6}
    (h : C * (2 * gE x + gF x) + (-C) * (2 * gE y + gF y)
      + 3 * (2 * hexE (x - y).val + hexF (x - y).val) = κ) : False := by
  revert h
  rcases hCv with rfl | rfl <;> rcases hκv with rfl | rfl | rfl <;> revert x y <;> decide

/-- **Adjacent oo is empty** at the master frame. -/
private theorem adj_oo_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (outerPt (hexPivot 4) (hexPivot 4 + 1) y d) ≠ 1 := by
  intro h
  rw [outerPt_anchor', outerPt_anchor', bridge_adj,
    adj_oo_clear x y b d (R := 3) (κ := 4) (by norm_num)] at h
  rcases oo_shape (C := 1) (by norm_num) (Or.inl rfl) (by norm_num) (Or.inl rfl) h with
    ⟨-, -, hzero⟩ | ⟨hbd, hb2, hF, hE⟩
  · exact oo_zero_empty (Or.inl rfl) (Or.inl rfl) hzero
  · exact oo_bnd_empty (Or.inl rfl) (Or.inl rfl) (by simp) hbd hb2 hF hE

/-- The adjacent oo fusion is empty at the master frame. -/
private theorem adj_fusion_oo_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot 3) (hexPivot 3 + 1) x b
      ≠ outerPt (hexPivot 4) (hexPivot 4 + 1) y d := by
  intro h
  rw [outerPt_anchor', outerPt_anchor', fusion_adj,
    adj_oo_clear x y b d (R := 0) (κ := 7) (by norm_num)] at h
  rcases oo_shape (C := 1) (by norm_num) (Or.inl rfl) (by norm_num)
      (Or.inr (Or.inl rfl)) h with
    ⟨-, -, hzero⟩ | ⟨hbd, hb2, hF, hE⟩
  · exact oo_zero_empty (Or.inl rfl) (Or.inr (Or.inl rfl)) hzero
  · exact oo_bnd_empty (Or.inl rfl) (Or.inr (Or.inl rfl)) (by simp) hbd hb2 hF hE

/-- **Adjacent oo is empty**: no unit chord joins the outer circles of hexagon
neighbours' lattices. -/
theorem adj_oo_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) ≠ 1 := by
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_outer (a - 3).val 4 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (4 : ZMod 6) + (a - 3) = a + 1 by ring,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter]
  exact adj_oo_zero (x - (a - 3)) b (y - (a - 3)) d

/-- **Adjacent oi at the master frame**: exactly the four table chords. -/
private theorem adj_oi_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (innerPt (hexPivot 4) (hexPivot 4 + 1) y d) = 1 ↔ (x, b, y, d) ∈ adjOITable := by
  rw [outerPt_anchor', innerPt_anchor, bridge_adj,
    adj_oi_clear x y b d (R := 3) (κ := 2) (by norm_num)]
  constructor
  · intro h
    obtain ⟨hsign, hF, hE⟩ := oi_shape (C := 1) (by norm_num) (by norm_num)
      (by norm_num) (Or.inl rfl) h
    rcases hsign with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · rw [gAddr_two, gAddr_one, show (2 : ℤ) - 1 = 1 from rfl, uAddr_one] at hF hE
      exact (by decide : ∀ X Y : ZMod 6,
        1 * gF X + (-1) * gF Y + 3 * hexF (X - Y).val = 0 →
        -3 * (1 * gE X) - 2 * (1 * gE X + 1 * gF X) + ((-1) * gE Y + (-1) * gF Y)
          + 3 * (hexE (X - Y).val + hexF (X - Y).val) = 3 * 2 →
        (X, (2 : ℤ), Y, (1 : ℤ)) ∈ adjOITable) x y hF hE
    · rw [gAddr_neg_two, gAddr_neg_one, show (-2 : ℤ) - -1 = -1 from rfl,
        uAddr_neg_one] at hF hE
      exact (by decide : ∀ X Y : ZMod 6,
        1 * gF (-X - 1) + (-1) * gF (-Y - 1) + 3 * hexF (-(X - Y)).val = 0 →
        -3 * (1 * gE (-X - 1)) - 2 * (1 * gE (-X - 1) + 1 * gF (-X - 1))
          + ((-1) * gE (-Y - 1) + (-1) * gF (-Y - 1))
          + 3 * (hexE (-(X - Y)).val + hexF (-(X - Y)).val) = 3 * 2 →
        (X, (-2 : ℤ), Y, (-1 : ℤ)) ∈ adjOITable) x y hF hE
  · intro hm
    fin_cases hm
    · -- (2, -2, 4, -1)
      have h1 := gTrace_clear 2 (-2)
      rw [show ((-2 : ℤ)).natAbs = 2 from rfl, gAddr_neg_two,
        show (-(2 : ZMod 6) - 1 : ZMod 6) = 3 by decide,
        show gE 3 = -1 by decide, show gF 3 = -1 by decide] at h1
      have h2 := gTrace_clear 4 (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, gAddr_neg_one,
        show (-(4 : ZMod 6) - 1 : ZMod 6) = 1 by decide,
        show gE 1 = -1 by decide, show gF 1 = 2 by decide] at h2
      rw [show ((-2 : ℤ) - -1) = -1 from rfl]
      have h3 := uTrace_clear (2 - 4) (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, uAddr_neg_one,
        show (-(2 - 4 : ZMod 6) : ZMod 6) = 2 by decide,
        show hexE (2 : ZMod 6).val = -1 by decide,
        show hexF (2 : ZMod 6).val = 1 by decide] at h3
      have c1 := hexTrace_coords (-1) (-1) 2
      have c2 := hexTrace_coords (-1) 2 1
      have c3 := hexTrace_coords (-1) 1 1
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c2 c3
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 h3 c1 c2 c3
      linear_combination h1 - h2 + 3 * h3 + c1 - c2 + 3 * c3 - 2 * sqrt3_cast_sq
    · -- (2, 2, 4, 1)
      have h1 := gTrace_clear 2 2
      rw [show ((2 : ℤ)).natAbs = 2 from rfl, gAddr_two,
        show gE 2 = -2 by decide, show gF 2 = 1 by decide] at h1
      have h2 := gTrace_clear 4 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, gAddr_one,
        show gE 4 = 1 by decide, show gF 4 = -2 by decide] at h2
      rw [show ((2 : ℤ) - 1) = 1 from rfl]
      have h3 := uTrace_clear (2 - 4) 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, uAddr_one,
        show hexE (2 - 4 : ZMod 6).val = 0 by decide,
        show hexF (2 - 4 : ZMod 6).val = -1 by decide] at h3
      have c1 := hexTrace_coords (-2) 1 2
      have c2 := hexTrace_coords 1 (-2) 1
      have c3 := hexTrace_coords 0 (-1) 1
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c2 c3
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 h3 c1 c2 c3
      linear_combination h1 - h2 + 3 * h3 + c1 - c2 + 3 * c3 - 2 * sqrt3_cast_sq
    · -- (3, -2, 1, -1)
      have h1 := gTrace_clear 3 (-2)
      rw [show ((-2 : ℤ)).natAbs = 2 from rfl, gAddr_neg_two,
        show (-(3 : ZMod 6) - 1 : ZMod 6) = 2 by decide,
        show gE 2 = -2 by decide, show gF 2 = 1 by decide] at h1
      have h2 := gTrace_clear 1 (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, gAddr_neg_one,
        show (-(1 : ZMod 6) - 1 : ZMod 6) = 4 by decide,
        show gE 4 = 1 by decide, show gF 4 = -2 by decide] at h2
      rw [show ((-2 : ℤ) - -1) = -1 from rfl]
      have h3 := uTrace_clear (3 - 1) (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, uAddr_neg_one,
        show (-(3 - 1 : ZMod 6) : ZMod 6) = 4 by decide,
        show hexE (4 : ZMod 6).val = 0 by decide,
        show hexF (4 : ZMod 6).val = -1 by decide] at h3
      have c1 := hexTrace_coords (-2) 1 2
      have c2 := hexTrace_coords 1 (-2) 1
      have c3 := hexTrace_coords 0 (-1) 1
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c2 c3
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 h3 c1 c2 c3
      linear_combination h1 - h2 + 3 * h3 + c1 - c2 + 3 * c3 - 2 * sqrt3_cast_sq
    · -- (3, 2, 1, 1)
      have h1 := gTrace_clear 3 2
      rw [show ((2 : ℤ)).natAbs = 2 from rfl, gAddr_two,
        show gE 3 = -1 by decide, show gF 3 = -1 by decide] at h1
      have h2 := gTrace_clear 1 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, gAddr_one,
        show gE 1 = -1 by decide, show gF 1 = 2 by decide] at h2
      rw [show ((2 : ℤ) - 1) = 1 from rfl]
      have h3 := uTrace_clear (3 - 1) 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, uAddr_one,
        show hexE (3 - 1 : ZMod 6).val = -1 by decide,
        show hexF (3 - 1 : ZMod 6).val = 1 by decide] at h3
      have c1 := hexTrace_coords (-1) (-1) 2
      have c2 := hexTrace_coords (-1) 2 1
      have c3 := hexTrace_coords (-1) 1 1
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c2 c3
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 h3 c1 c2 c3
      linear_combination h1 - h2 + 3 * h3 + c1 - c2 + 3 * c3 - 2 * sqrt3_cast_sq

/-- **Adjacent io at the master frame**: exactly the four table chords (the oi tree
at negated coefficient, roles swapped). -/
private theorem adj_io_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (outerPt (hexPivot 4) (hexPivot 4 + 1) y d) = 1 ↔ (x, b, y, d) ∈ adjIOTable := by
  rw [innerPt_anchor, outerPt_anchor', bridge_adj,
    adj_io_clear x y b d (R := 3) (κ := 2) (by norm_num)]
  constructor
  · intro h
    have h' : ((-1 : ℤ) : ℂ) * s3 ^ 1 * gTr y d + ((-(-1) : ℤ) : ℂ) * s3 ^ 0 * gTr x b
        + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (y - x) (d - b) = ((2 : ℤ) : ℂ) * s3 ^ 1 := by
      rw [show (y - x : ZMod 6) = -(x - y) by ring, show (d - b : ℤ) = -(b - d) by ring,
        uTr_neg]
      push_cast
      push_cast at h
      linear_combination h
    obtain ⟨hsign, hF, hE⟩ := oi_shape (C := -1) (by norm_num) (by norm_num)
      (by norm_num) (Or.inl rfl) h'
    rcases hsign with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
    · rw [gAddr_two, gAddr_one, show (2 : ℤ) - 1 = 1 from rfl, uAddr_one] at hF hE
      exact (by decide : ∀ X Y : ZMod 6,
        (-1) * gF Y + (-(-1)) * gF X + 3 * hexF (Y - X).val = 0 →
        -3 * ((-1) * gE Y) - 2 * ((-1) * gE Y + (-1) * gF Y)
          + ((-(-1)) * gE X + (-(-1)) * gF X)
          + 3 * (hexE (Y - X).val + hexF (Y - X).val) = 3 * 2 →
        (X, (1 : ℤ), Y, (2 : ℤ)) ∈ adjIOTable) x y hF hE
    · rw [gAddr_neg_two, gAddr_neg_one, show (-2 : ℤ) - -1 = -1 from rfl,
        uAddr_neg_one] at hF hE
      exact (by decide : ∀ X Y : ZMod 6,
        (-1) * gF (-Y - 1) + (-(-1)) * gF (-X - 1) + 3 * hexF (-(Y - X)).val = 0 →
        -3 * ((-1) * gE (-Y - 1)) - 2 * ((-1) * gE (-Y - 1) + (-1) * gF (-Y - 1))
          + ((-(-1)) * gE (-X - 1) + (-(-1)) * gF (-X - 1))
          + 3 * (hexE (-(Y - X)).val + hexF (-(Y - X)).val) = 3 * 2 →
        (X, (-1 : ℤ), Y, (-2 : ℤ)) ∈ adjIOTable) x y hF hE
  · intro hm
    fin_cases hm
    · -- (1, -1, 5, -2)
      have h1 := gTrace_clear 1 (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, gAddr_neg_one,
        show (-(1 : ZMod 6) - 1 : ZMod 6) = 4 by decide,
        show gE 4 = 1 by decide, show gF 4 = -2 by decide] at h1
      have h2 := gTrace_clear 5 (-2)
      rw [show ((-2 : ℤ)).natAbs = 2 from rfl, gAddr_neg_two,
        show (-(5 : ZMod 6) - 1 : ZMod 6) = 0 by decide,
        show gE 0 = 1 by decide, show gF 0 = 1 by decide] at h2
      rw [show ((-1 : ℤ) - -2) = 1 from rfl]
      have h3 := uTrace_clear (1 - 5) 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, uAddr_one,
        show hexE (1 - 5 : ZMod 6).val = -1 by decide,
        show hexF (1 - 5 : ZMod 6).val = 1 by decide] at h3
      have c1 := hexTrace_coords 1 (-2) 1
      have c2 := hexTrace_coords 1 1 2
      have c3 := hexTrace_coords (-1) 1 1
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c2
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c3
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 h3 c1 c2 c3
      linear_combination h1 - h2 + 3 * h3 + c1 - c2 + 3 * c3 - 2 * sqrt3_cast_sq
    · -- (1, 1, 5, 2)
      have h1 := gTrace_clear 1 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, gAddr_one,
        show gE 1 = -1 by decide, show gF 1 = 2 by decide] at h1
      have h2 := gTrace_clear 5 2
      rw [show ((2 : ℤ)).natAbs = 2 from rfl, gAddr_two,
        show gE 5 = 2 by decide, show gF 5 = -1 by decide] at h2
      rw [show ((1 : ℤ) - 2) = -1 from rfl]
      have h3 := uTrace_clear (1 - 5) (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, uAddr_neg_one,
        show (-(1 - 5 : ZMod 6) : ZMod 6) = 4 by decide,
        show hexE (4 : ZMod 6).val = 0 by decide,
        show hexF (4 : ZMod 6).val = -1 by decide] at h3
      have c1 := hexTrace_coords (-1) 2 1
      have c2 := hexTrace_coords 2 (-1) 2
      have c3 := hexTrace_coords 0 (-1) 1
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c2
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c3
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 h3 c1 c2 c3
      linear_combination h1 - h2 + 3 * h3 + c1 - c2 + 3 * c3 - 2 * sqrt3_cast_sq
    · -- (4, -1, 0, -2)
      have h1 := gTrace_clear 4 (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, gAddr_neg_one,
        show (-(4 : ZMod 6) - 1 : ZMod 6) = 1 by decide,
        show gE 1 = -1 by decide, show gF 1 = 2 by decide] at h1
      have h2 := gTrace_clear 0 (-2)
      rw [show ((-2 : ℤ)).natAbs = 2 from rfl, gAddr_neg_two,
        show (-(0 : ZMod 6) - 1 : ZMod 6) = 5 by decide,
        show gE 5 = 2 by decide, show gF 5 = -1 by decide] at h2
      rw [show ((-1 : ℤ) - -2) = 1 from rfl]
      have h3 := uTrace_clear (4 - 0) 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, uAddr_one,
        show hexE (4 - 0 : ZMod 6).val = 0 by decide,
        show hexF (4 - 0 : ZMod 6).val = -1 by decide] at h3
      have c1 := hexTrace_coords (-1) 2 1
      have c2 := hexTrace_coords 2 (-1) 2
      have c3 := hexTrace_coords 0 (-1) 1
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c2
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c3
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 h3 c1 c2 c3
      linear_combination h1 - h2 + 3 * h3 + c1 - c2 + 3 * c3 - 2 * sqrt3_cast_sq
    · -- (4, 1, 0, 2)
      have h1 := gTrace_clear 4 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, gAddr_one,
        show gE 4 = 1 by decide, show gF 4 = -2 by decide] at h1
      have h2 := gTrace_clear 0 2
      rw [show ((2 : ℤ)).natAbs = 2 from rfl, gAddr_two,
        show gE 0 = 1 by decide, show gF 0 = 1 by decide] at h2
      rw [show ((1 : ℤ) - 2) = -1 from rfl]
      have h3 := uTrace_clear (4 - 0) (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, uAddr_neg_one,
        show (-(4 - 0 : ZMod 6) : ZMod 6) = 2 by decide,
        show hexE (2 : ZMod 6).val = -1 by decide,
        show hexF (2 : ZMod 6).val = 1 by decide] at h3
      have c1 := hexTrace_coords 1 (-2) 1
      have c2 := hexTrace_coords 1 1 2
      have c3 := hexTrace_coords (-1) 1 1
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c2
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c3
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 h3 c1 c2 c3
      linear_combination h1 - h2 + 3 * h3 + c1 - c2 + 3 * c3 - 2 * sqrt3_cast_sq

/-- **Adjacent ii at the master frame**: exactly the four table chords. -/
private theorem adj_ii_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (innerPt (hexPivot 4) (hexPivot 4 + 1) y d) = 1 ↔ (x, b, y, d) ∈ adjIITable := by
  rw [innerPt_anchor, innerPt_anchor, bridge_adj,
    adj_ii_clear x y b d (R := 3) (κ := 0) (by norm_num)]
  constructor
  · intro h
    obtain ⟨hbd, hb1, hF, hE⟩ := ii_shape (C := 1) (by norm_num) (Or.inl rfl)
      ⟨0, rfl⟩ h
    subst hbd
    have hb : b = 1 ∨ b = -1 := by omega
    rcases hb with rfl | rfl
    · rw [gAddr_one, gAddr_one] at hF hE
      rw [show (1 : ℤ) - 1 = 0 from rfl, uAddr_zero] at hE
      exact (by decide : ∀ X Y : ZMod 6,
        1 * gF X + (-1) * gF Y = 0 →
        (1 * gE X + (-1) * gE Y) * (2 * (piCoeff 1).1 + (piCoeff 1).2)
          = 0 * 3 ^ 1 + 3 ^ 1 * (2 * ((-1) * hexE (X - Y).val)
            + (-1) * hexF (X - Y).val) →
        (X, (1 : ℤ), Y, (1 : ℤ)) ∈ adjIITable) x y hF hE
    · rw [gAddr_neg_one, gAddr_neg_one] at hF hE
      rw [show (-1 : ℤ) - -1 = 0 from rfl, uAddr_zero] at hE
      exact (by decide : ∀ X Y : ZMod 6,
        1 * gF (-X - 1) + (-1) * gF (-Y - 1) = 0 →
        (1 * gE (-X - 1) + (-1) * gE (-Y - 1)) * (2 * (piCoeff 1).1 + (piCoeff 1).2)
          = 0 * 3 ^ 1 + 3 ^ 1 * (2 * ((-1) * hexE (X - Y).val)
            + (-1) * hexF (X - Y).val) →
        (X, (-1 : ℤ), Y, (-1 : ℤ)) ∈ adjIITable) x y hF hE
  · intro hm
    fin_cases hm
    · -- (0, -1, 2, -1)
      have h1 := gTrace_clear 0 (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, gAddr_neg_one,
        show (-(0 : ZMod 6) - 1 : ZMod 6) = 5 by decide,
        show gE 5 = 2 by decide, show gF 5 = -1 by decide] at h1
      have h2 := gTrace_clear 2 (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, gAddr_neg_one,
        show (-(2 : ZMod 6) - 1 : ZMod 6) = 3 by decide,
        show gE 3 = -1 by decide, show gF 3 = -1 by decide] at h2
      rw [show ((-1 : ℤ) - -1) = 0 from rfl, uTr_zero,
        show (2 * hexE (0 - 2 : ZMod 6).val + hexF (0 - 2 : ZMod 6).val : ℤ) = -1
          by decide]
      have c1 := hexTrace_coords 2 (-1) 1
      have c2 := hexTrace_coords (-1) (-1) 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c2
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 c1 c2
      linear_combination h1 - h2 + c1 - c2 - sqrt3_cast_sq
    · -- (0, 1, 2, 1)
      have h1 := gTrace_clear 0 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, gAddr_one,
        show gE 0 = 1 by decide, show gF 0 = 1 by decide] at h1
      have h2 := gTrace_clear 2 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, gAddr_one,
        show gE 2 = -2 by decide, show gF 2 = 1 by decide] at h2
      rw [show ((1 : ℤ) - 1) = 0 from rfl, uTr_zero,
        show (2 * hexE (0 - 2 : ZMod 6).val + hexF (0 - 2 : ZMod 6).val : ℤ) = -1
          by decide]
      have c1 := hexTrace_coords 1 1 1
      have c2 := hexTrace_coords (-2) 1 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c2
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 c1 c2
      linear_combination h1 - h2 + c1 - c2 - sqrt3_cast_sq
    · -- (5, -1, 3, -1)
      have h1 := gTrace_clear 5 (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, gAddr_neg_one,
        show (-(5 : ZMod 6) - 1 : ZMod 6) = 0 by decide,
        show gE 0 = 1 by decide, show gF 0 = 1 by decide] at h1
      have h2 := gTrace_clear 3 (-1)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, gAddr_neg_one,
        show (-(3 : ZMod 6) - 1 : ZMod 6) = 2 by decide,
        show gE 2 = -2 by decide, show gF 2 = 1 by decide] at h2
      rw [show ((-1 : ℤ) - -1) = 0 from rfl, uTr_zero,
        show (2 * hexE (5 - 3 : ZMod 6).val + hexF (5 - 3 : ZMod 6).val : ℤ) = -1
          by decide]
      have c1 := hexTrace_coords 1 1 1
      have c2 := hexTrace_coords (-2) 1 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c2
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 c1 c2
      linear_combination h1 - h2 + c1 - c2 - sqrt3_cast_sq
    · -- (5, 1, 3, 1)
      have h1 := gTrace_clear 5 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, gAddr_one,
        show gE 5 = 2 by decide, show gF 5 = -1 by decide] at h1
      have h2 := gTrace_clear 3 1
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, gAddr_one,
        show gE 3 = -1 by decide, show gF 3 = -1 by decide] at h2
      rw [show ((1 : ℤ) - 1) = 0 from rfl, uTr_zero,
        show (2 * hexE (5 - 3 : ZMod 6).val + hexF (5 - 3 : ZMod 6).val : ℤ) = -1
          by decide]
      have c1 := hexTrace_coords 2 (-1) 1
      have c2 := hexTrace_coords (-1) (-1) 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c2
      refine mul_left_cancel₀ sqrt3_ne ?_
      push_cast
      push_cast at h1 h2 c1 c2
      linear_combination h1 - h2 + c1 - c2 - sqrt3_cast_sq

/-- The adjacent oi fusion is empty at the master frame (κ = 5 refuses). -/
private theorem adj_fusion_oi_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot 3) (hexPivot 3 + 1) x b
      ≠ innerPt (hexPivot 4) (hexPivot 4 + 1) y d := by
  intro h
  rw [outerPt_anchor', innerPt_anchor, fusion_adj,
    adj_oi_clear x y b d (R := 0) (κ := 5) (by norm_num)] at h
  obtain ⟨hsign, hF, hE⟩ := oi_shape (C := 1) (by norm_num) (by norm_num)
    (by norm_num) (Or.inr (Or.inl rfl)) h
  rcases hsign with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · rw [gAddr_two, gAddr_one, show (2 : ℤ) - 1 = 1 from rfl, uAddr_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (1 * gF X + (-1) * gF Y + 3 * hexF (X - Y).val = 0
        ∧ -3 * (1 * gE X) - 2 * (1 * gE X + 1 * gF X) + ((-1) * gE Y + (-1) * gF Y)
          + 3 * (hexE (X - Y).val + hexF (X - Y).val) = 3 * 5)) x y ⟨hF, hE⟩
  · rw [gAddr_neg_two, gAddr_neg_one, show (-2 : ℤ) - -1 = -1 from rfl,
      uAddr_neg_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (1 * gF (-X - 1) + (-1) * gF (-Y - 1) + 3 * hexF (-(X - Y)).val = 0
        ∧ -3 * (1 * gE (-X - 1)) - 2 * (1 * gE (-X - 1) + 1 * gF (-X - 1))
          + ((-1) * gE (-Y - 1) + (-1) * gF (-Y - 1))
          + 3 * (hexE (-(X - Y)).val + hexF (-(X - Y)).val) = 3 * 5)) x y ⟨hF, hE⟩

/-- The adjacent io fusion is empty at the master frame. -/
private theorem adj_fusion_io_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot 3) (hexPivot 3 + 1) x b
      ≠ outerPt (hexPivot 4) (hexPivot 4 + 1) y d := by
  intro h
  rw [innerPt_anchor, outerPt_anchor', fusion_adj,
    adj_io_clear x y b d (R := 0) (κ := 5) (by norm_num)] at h
  have h' : ((-1 : ℤ) : ℂ) * s3 ^ 1 * gTr y d + ((-(-1) : ℤ) : ℂ) * s3 ^ 0 * gTr x b
      + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (y - x) (d - b) = ((5 : ℤ) : ℂ) * s3 ^ 1 := by
    rw [show (y - x : ZMod 6) = -(x - y) by ring, show (d - b : ℤ) = -(b - d) by ring,
      uTr_neg]
    push_cast
    push_cast at h
    linear_combination h
  obtain ⟨hsign, hF, hE⟩ := oi_shape (C := -1) (by norm_num) (by norm_num)
    (by norm_num) (Or.inr (Or.inl rfl)) h'
  rcases hsign with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · rw [gAddr_two, gAddr_one, show (2 : ℤ) - 1 = 1 from rfl, uAddr_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ ((-1) * gF Y + (-(-1)) * gF X + 3 * hexF (Y - X).val = 0
        ∧ -3 * ((-1) * gE Y) - 2 * ((-1) * gE Y + (-1) * gF Y)
          + ((-(-1)) * gE X + (-(-1)) * gF X)
          + 3 * (hexE (Y - X).val + hexF (Y - X).val) = 3 * 5)) x y ⟨hF, hE⟩
  · rw [gAddr_neg_two, gAddr_neg_one, show (-2 : ℤ) - -1 = -1 from rfl,
      uAddr_neg_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ ((-1) * gF (-Y - 1) + (-(-1)) * gF (-X - 1) + 3 * hexF (-(Y - X)).val = 0
        ∧ -3 * ((-1) * gE (-Y - 1)) - 2 * ((-1) * gE (-Y - 1) + (-1) * gF (-Y - 1))
          + ((-(-1)) * gE (-X - 1) + (-(-1)) * gF (-X - 1))
          + 3 * (hexE (-(Y - X)).val + hexF (-(Y - X)).val) = 3 * 5)) x y ⟨hF, hE⟩

/-- The adjacent ii fusion is empty at the master frame (κ = 3 refuses). -/
private theorem adj_fusion_ii_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot 3) (hexPivot 3 + 1) x b
      ≠ innerPt (hexPivot 4) (hexPivot 4 + 1) y d := by
  intro h
  rw [innerPt_anchor, innerPt_anchor, fusion_adj,
    adj_ii_clear x y b d (R := 0) (κ := 3) (by norm_num)] at h
  obtain ⟨hbd, hb1, hF, hE⟩ := ii_shape (C := 1) (by norm_num) (Or.inl rfl) ⟨1, rfl⟩ h
  subst hbd
  have hb : b = 1 ∨ b = -1 := by omega
  rcases hb with rfl | rfl
  · rw [gAddr_one, gAddr_one] at hF hE
    rw [show (1 : ℤ) - 1 = 0 from rfl, uAddr_zero] at hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (1 * gF X + (-1) * gF Y = 0
        ∧ (1 * gE X + (-1) * gE Y) * (2 * (piCoeff 1).1 + (piCoeff 1).2)
          = 3 * 3 ^ 1 + 3 ^ 1 * (2 * ((-1) * hexE (X - Y).val)
            + (-1) * hexF (X - Y).val))) x y ⟨hF, hE⟩
  · rw [gAddr_neg_one, gAddr_neg_one] at hF hE
    rw [show (-1 : ℤ) - -1 = 0 from rfl, uAddr_zero] at hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (1 * gF (-X - 1) + (-1) * gF (-Y - 1) = 0
        ∧ (1 * gE (-X - 1) + (-1) * gE (-Y - 1)) * (2 * (piCoeff 1).1 + (piCoeff 1).2)
          = 3 * 3 ^ 1 + 3 ^ 1 * (2 * ((-1) * hexE (X - Y).val)
            + (-1) * hexF (X - Y).val))) x y ⟨hF, hE⟩

/-- **Adjacent oi completeness, all six webs**: exactly the four table chords. -/
theorem adj_oi_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ adjOITable := by
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_inner (a - 3).val 4 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (4 : ZMod 6) + (a - 3) = a + 1 by ring,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter]
  exact adj_oi_zero (x - (a - 3)) b (y - (a - 3)) d

/-- **Adjacent io completeness, all six webs.** -/
theorem adj_io_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ adjIOTable := by
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_outer (a - 3).val 4 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (4 : ZMod 6) + (a - 3) = a + 1 by ring,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter]
  exact adj_io_zero (x - (a - 3)) b (y - (a - 3)) d

/-- **Adjacent ii completeness, all six webs.** -/
theorem adj_ii_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ adjIITable := by
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_inner (a - 3).val 4 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (4 : ZMod 6) + (a - 3) = a + 1 by ring,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter]
  exact adj_ii_zero (x - (a - 3)) b (y - (a - 3)) d

/-- The adjacent oo fusion is empty. -/
theorem adj_fusion_oo (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := by
  intro he
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_outer (a - 3).val 4 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (4 : ZMod 6) + (a - 3) = a + 1 by ring,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2] at he
  exact adj_fusion_oo_zero _ _ _ _ (rot6_iter_inj he)

/-- The adjacent oi fusion is empty (mutual inner-circle membership is a fact about
the CENTRES, which are never lattice points of the partner's ladder). -/
theorem adj_fusion_oi (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := by
  intro he
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_inner (a - 3).val 4 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (4 : ZMod 6) + (a - 3) = a + 1 by ring,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2] at he
  exact adj_fusion_oi_zero _ _ _ _ (rot6_iter_inj he)

theorem adj_fusion_io (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := by
  intro he
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_outer (a - 3).val 4 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (4 : ZMod 6) + (a - 3) = a + 1 by ring,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2] at he
  exact adj_fusion_io_zero _ _ _ _ (rot6_iter_inj he)

theorem adj_fusion_ii (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := by
  intro he
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_inner (a - 3).val 4 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (4 : ZMod 6) + (a - 3) = a + 1 by ring,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2] at he
  exact adj_fusion_ii_zero _ _ _ _ (rot6_iter_inj he)

/-! ## §O The opposite master web — the tangent pairs, separation `2g/3`

Master frame `(hexPivot 3, hexPivot 0) = (0, 2m)`.  The masters carry doubled
`g`-coefficients at REFLECTED addresses (`Tr(g·w̄)` — the §0 orientation
correction).  Census-exact: oo carries four sporadics, oi/io/ii are EMPTY, every
fusion is EMPTY — the triple tangency at `m` never touches the lattice. -/

/-- oo sporadics, master frame: `outer(0) ↔ outer(2m)`. -/
def oppOOTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(3, -2, 1, -2), (3, 2, 1, 2), (4, -2, 0, -2), (4, 2, 0, 2)]

/-- The opposite wrapper's pivot congruence, decided once. -/
private theorem opp_shift : ∀ a : ZMod 6, (0 : ZMod 6) + (a - 3) = a + 3 := by decide

/-- **Opposite oo at the master frame**: exactly the four table chords. -/
private theorem opp_oo_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (outerPt (hexPivot 0) (hexPivot 0 + 1) y d) = 1 ↔ (x, b, y, d) ∈ oppOOTable := by
  rw [outerPt_anchor', outerPt_anchor', bridge_opp,
    opp_oo_clear x y b d (R := 3) (κ := 7) (by norm_num)]
  constructor
  · intro h
    rcases oo_shape (C := 2) (by norm_num) (Or.inr rfl) (by norm_num)
        (Or.inr (Or.inl rfl)) h with ⟨-, -, hzero⟩ | ⟨hbd, hb2, hF, hE⟩
    · exact (oo_zero_empty (Or.inr rfl) (Or.inr (Or.inl rfl)) hzero).elim
    · subst hbd
      have hb : b = 2 ∨ b = -2 := by omega
      rcases hb with rfl | rfl
      · rw [gAddr_two, gAddr_two] at hF hE
        rw [show (2 : ℤ) - 2 = 0 from rfl, uAddr_zero] at hE
        exact (by decide : ∀ X Y : ZMod 6,
          2 * gF (X - 1) + (-2) * gF (Y - 1) = 0 →
          (2 * gE (X - 1) + (-2) * gE (Y - 1)) * (2 * (piCoeff 2).1 + (piCoeff 2).2)
            = 7 * 3 ^ 1 + 3 ^ 2 * (2 * ((-1) * hexE (X - 1 - (Y - 1)).val)
              + (-1) * hexF (X - 1 - (Y - 1)).val) →
          (X, (2 : ℤ), Y, (2 : ℤ)) ∈ oppOOTable) x y hF hE
      · rw [gAddr_neg_two, gAddr_neg_two] at hF hE
        rw [show (-2 : ℤ) - -2 = 0 from rfl, uAddr_zero] at hE
        exact (by decide : ∀ X Y : ZMod 6,
          2 * gF (-(X - 1) - 1) + (-2) * gF (-(Y - 1) - 1) = 0 →
          (2 * gE (-(X - 1) - 1) + (-2) * gE (-(Y - 1) - 1))
              * (2 * (piCoeff 2).1 + (piCoeff 2).2)
            = 7 * 3 ^ 1 + 3 ^ 2 * (2 * ((-1) * hexE (X - 1 - (Y - 1)).val)
              + (-1) * hexF (X - 1 - (Y - 1)).val) →
          (X, (-2 : ℤ), Y, (-2 : ℤ)) ∈ oppOOTable) x y hF hE
  · intro hm
    fin_cases hm
    · -- (3, -2, 1, -2)
      have h1 := gTrace_clear (3 - 1) (-2)
      rw [show ((-2 : ℤ)).natAbs = 2 from rfl, gAddr_neg_two,
        show (-(3 - 1 : ZMod 6) - 1 : ZMod 6) = 3 by decide,
        show gE 3 = -1 by decide, show gF 3 = -1 by decide] at h1
      have h2 := gTrace_clear (1 - 1) (-2)
      rw [show ((-2 : ℤ)).natAbs = 2 from rfl, gAddr_neg_two,
        show (-(1 - 1 : ZMod 6) - 1 : ZMod 6) = 5 by decide,
        show gE 5 = 2 by decide, show gF 5 = -1 by decide] at h2
      rw [show ((-2 : ℤ) - -2) = 0 from rfl, uTr_zero,
        show (2 * hexE (3 - 1 - (1 - 1) : ZMod 6).val
          + hexF (3 - 1 - (1 - 1) : ZMod 6).val : ℤ) = -1 by decide]
      have c1 := hexTrace_coords (-1) (-1) 2
      have c2 := hexTrace_coords 2 (-1) 2
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c1 c2
      push_cast
      push_cast at h1 h2 c1 c2
      linear_combination (2 / 3 : ℂ) * h1 - (2 / 3 : ℂ) * h2 + (2 / 3 : ℂ) * c1
        - (2 / 3 : ℂ) * c2
        + ((2 / 3 : ℂ) * (gTr (1 - 1) (-2) - gTr (3 - 1) (-2))) * sqrt3_cast_sq
    · -- (3, 2, 1, 2)
      have h1 := gTrace_clear (3 - 1) 2
      rw [show ((2 : ℤ)).natAbs = 2 from rfl, gAddr_two,
        show gE (3 - 1 : ZMod 6) = -2 by decide,
        show gF (3 - 1 : ZMod 6) = 1 by decide] at h1
      have h2 := gTrace_clear (1 - 1) 2
      rw [show ((2 : ℤ)).natAbs = 2 from rfl, gAddr_two,
        show gE (1 - 1 : ZMod 6) = 1 by decide,
        show gF (1 - 1 : ZMod 6) = 1 by decide] at h2
      rw [show ((2 : ℤ) - 2) = 0 from rfl, uTr_zero,
        show (2 * hexE (3 - 1 - (1 - 1) : ZMod 6).val
          + hexF (3 - 1 - (1 - 1) : ZMod 6).val : ℤ) = -1 by decide]
      have c1 := hexTrace_coords (-2) 1 2
      have c2 := hexTrace_coords 1 1 2
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c1 c2
      push_cast
      push_cast at h1 h2 c1 c2
      linear_combination (2 / 3 : ℂ) * h1 - (2 / 3 : ℂ) * h2 + (2 / 3 : ℂ) * c1
        - (2 / 3 : ℂ) * c2
        + ((2 / 3 : ℂ) * (gTr (1 - 1) 2 - gTr (3 - 1) 2)) * sqrt3_cast_sq
    · -- (4, -2, 0, -2)
      have h1 := gTrace_clear (4 - 1) (-2)
      rw [show ((-2 : ℤ)).natAbs = 2 from rfl, gAddr_neg_two,
        show (-(4 - 1 : ZMod 6) - 1 : ZMod 6) = 2 by decide,
        show gE 2 = -2 by decide, show gF 2 = 1 by decide] at h1
      have h2 := gTrace_clear (0 - 1) (-2)
      rw [show ((-2 : ℤ)).natAbs = 2 from rfl, gAddr_neg_two,
        show (-(0 - 1 : ZMod 6) - 1 : ZMod 6) = 0 by decide,
        show gE 0 = 1 by decide, show gF 0 = 1 by decide] at h2
      rw [show ((-2 : ℤ) - -2) = 0 from rfl, uTr_zero,
        show (2 * hexE (4 - 1 - (0 - 1) : ZMod 6).val
          + hexF (4 - 1 - (0 - 1) : ZMod 6).val : ℤ) = -1 by decide]
      have c1 := hexTrace_coords (-2) 1 2
      have c2 := hexTrace_coords 1 1 2
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c1 c2
      push_cast
      push_cast at h1 h2 c1 c2
      linear_combination (2 / 3 : ℂ) * h1 - (2 / 3 : ℂ) * h2 + (2 / 3 : ℂ) * c1
        - (2 / 3 : ℂ) * c2
        + ((2 / 3 : ℂ) * (gTr (0 - 1) (-2) - gTr (4 - 1) (-2))) * sqrt3_cast_sq
    · -- (4, 2, 0, 2)
      have h1 := gTrace_clear (4 - 1) 2
      rw [show ((2 : ℤ)).natAbs = 2 from rfl, gAddr_two,
        show gE (4 - 1 : ZMod 6) = -1 by decide,
        show gF (4 - 1 : ZMod 6) = -1 by decide] at h1
      have h2 := gTrace_clear (0 - 1) 2
      rw [show ((2 : ℤ)).natAbs = 2 from rfl, gAddr_two,
        show gE (0 - 1 : ZMod 6) = 2 by decide,
        show gF (0 - 1 : ZMod 6) = -1 by decide] at h2
      rw [show ((2 : ℤ) - 2) = 0 from rfl, uTr_zero,
        show (2 * hexE (4 - 1 - (0 - 1) : ZMod 6).val
          + hexF (4 - 1 - (0 - 1) : ZMod 6).val : ℤ) = -1 by decide]
      have c1 := hexTrace_coords (-1) (-1) 2
      have c2 := hexTrace_coords 2 (-1) 2
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c1 c2
      push_cast
      push_cast at h1 h2 c1 c2
      linear_combination (2 / 3 : ℂ) * h1 - (2 / 3 : ℂ) * h2 + (2 / 3 : ℂ) * c1
        - (2 / 3 : ℂ) * c2
        + ((2 / 3 : ℂ) * (gTr (0 - 1) 2 - gTr (4 - 1) 2)) * sqrt3_cast_sq

/-- Opposite oi is empty at the master frame (κ = 5 refuses at C = 2). -/
private theorem opp_oi_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (innerPt (hexPivot 0) (hexPivot 0 + 1) y d) ≠ 1 := by
  intro h
  rw [outerPt_anchor', innerPt_anchor, bridge_opp,
    opp_oi_clear x y b d (R := 3) (κ := 5) (by norm_num)] at h
  obtain ⟨hsign, hF, hE⟩ := oi_shape (C := 2) (by norm_num) (by norm_num)
    (by norm_num) (Or.inr (Or.inl rfl)) h
  rcases hsign with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · rw [gAddr_two, gAddr_one, show (2 : ℤ) - 1 = 1 from rfl, uAddr_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (2 * gF (X - 1) + (-2) * gF (Y - 1) + 3 * hexF (X - 1 - (Y - 1)).val = 0
        ∧ -3 * (2 * gE (X - 1)) - 2 * (2 * gE (X - 1) + 2 * gF (X - 1))
          + ((-2) * gE (Y - 1) + (-2) * gF (Y - 1))
          + 3 * (hexE (X - 1 - (Y - 1)).val + hexF (X - 1 - (Y - 1)).val)
          = 3 * 5)) x y ⟨hF, hE⟩
  · rw [gAddr_neg_two, gAddr_neg_one, show (-2 : ℤ) - -1 = -1 from rfl,
      uAddr_neg_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (2 * gF (-(X - 1) - 1) + (-2) * gF (-(Y - 1) - 1)
          + 3 * hexF (-(X - 1 - (Y - 1))).val = 0
        ∧ -3 * (2 * gE (-(X - 1) - 1)) - 2 * (2 * gE (-(X - 1) - 1) + 2 * gF (-(X - 1) - 1))
          + ((-2) * gE (-(Y - 1) - 1) + (-2) * gF (-(Y - 1) - 1))
          + 3 * (hexE (-(X - 1 - (Y - 1))).val + hexF (-(X - 1 - (Y - 1))).val)
          = 3 * 5)) x y ⟨hF, hE⟩

/-- Opposite io is empty at the master frame — the oi tree at `C = −2`, swapped. -/
private theorem opp_io_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (outerPt (hexPivot 0) (hexPivot 0 + 1) y d) ≠ 1 := by
  intro h
  rw [innerPt_anchor, outerPt_anchor', bridge_opp,
    opp_io_clear x y b d (R := 3) (κ := 5) (by norm_num)] at h
  have h' : ((-2 : ℤ) : ℂ) * s3 ^ 1 * gTr (y - 1) d
      + ((-(-2) : ℤ) : ℂ) * s3 ^ 0 * gTr (x - 1) b
      + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (y - 1 - (x - 1)) (d - b) = ((5 : ℤ) : ℂ) * s3 ^ 1 := by
    rw [show (y - 1 - (x - 1) : ZMod 6) = -(x - 1 - (y - 1)) by ring,
      show (d - b : ℤ) = -(b - d) by ring, uTr_neg]
    push_cast
    push_cast at h
    linear_combination h
  obtain ⟨hsign, hF, hE⟩ := oi_shape (C := -2) (by norm_num) (by norm_num)
    (by norm_num) (Or.inr (Or.inl rfl)) h'
  rcases hsign with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · rw [gAddr_two, gAddr_one, show (2 : ℤ) - 1 = 1 from rfl, uAddr_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ ((-2) * gF (Y - 1) + (-(-2)) * gF (X - 1) + 3 * hexF (Y - 1 - (X - 1)).val = 0
        ∧ -3 * ((-2) * gE (Y - 1)) - 2 * ((-2) * gE (Y - 1) + (-2) * gF (Y - 1))
          + ((-(-2)) * gE (X - 1) + (-(-2)) * gF (X - 1))
          + 3 * (hexE (Y - 1 - (X - 1)).val + hexF (Y - 1 - (X - 1)).val)
          = 3 * 5)) x y ⟨hF, hE⟩
  · rw [gAddr_neg_two, gAddr_neg_one, show (-2 : ℤ) - -1 = -1 from rfl,
      uAddr_neg_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ ((-2) * gF (-(Y - 1) - 1) + (-(-2)) * gF (-(X - 1) - 1)
          + 3 * hexF (-(Y - 1 - (X - 1))).val = 0
        ∧ -3 * ((-2) * gE (-(Y - 1) - 1))
          - 2 * ((-2) * gE (-(Y - 1) - 1) + (-2) * gF (-(Y - 1) - 1))
          + ((-(-2)) * gE (-(X - 1) - 1) + (-(-2)) * gF (-(X - 1) - 1))
          + 3 * (hexE (-(Y - 1 - (X - 1))).val + hexF (-(Y - 1 - (X - 1))).val)
          = 3 * 5)) x y ⟨hF, hE⟩

/-- Opposite ii is empty at the master frame (κ = 3 at C = 2 refuses). -/
private theorem opp_ii_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (innerPt (hexPivot 0) (hexPivot 0 + 1) y d) ≠ 1 := by
  intro h
  rw [innerPt_anchor, innerPt_anchor, bridge_opp,
    opp_ii_clear x y b d (R := 3) (κ := 3) (by norm_num)] at h
  obtain ⟨hbd, hb1, hF, hE⟩ := ii_shape (C := 2) (by norm_num) (Or.inr rfl) ⟨1, rfl⟩ h
  subst hbd
  have hb : b = 1 ∨ b = -1 := by omega
  rcases hb with rfl | rfl
  · rw [gAddr_one, gAddr_one] at hF hE
    rw [show (1 : ℤ) - 1 = 0 from rfl, uAddr_zero] at hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (2 * gF (X - 1) + (-2) * gF (Y - 1) = 0
        ∧ (2 * gE (X - 1) + (-2) * gE (Y - 1)) * (2 * (piCoeff 1).1 + (piCoeff 1).2)
          = 3 * 3 ^ 1 + 3 ^ 1 * (2 * ((-1) * hexE (X - 1 - (Y - 1)).val)
            + (-1) * hexF (X - 1 - (Y - 1)).val))) x y ⟨hF, hE⟩
  · rw [gAddr_neg_one, gAddr_neg_one] at hF hE
    rw [show (-1 : ℤ) - -1 = 0 from rfl, uAddr_zero] at hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (2 * gF (-(X - 1) - 1) + (-2) * gF (-(Y - 1) - 1) = 0
        ∧ (2 * gE (-(X - 1) - 1) + (-2) * gE (-(Y - 1) - 1))
            * (2 * (piCoeff 1).1 + (piCoeff 1).2)
          = 3 * 3 ^ 1 + 3 ^ 1 * (2 * ((-1) * hexE (X - 1 - (Y - 1)).val)
            + (-1) * hexF (X - 1 - (Y - 1)).val))) x y ⟨hF, hE⟩

/-- The opposite oo fusion is empty at the master frame (κ = 10 refuses). -/
private theorem opp_fusion_oo_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot 3) (hexPivot 3 + 1) x b
      ≠ outerPt (hexPivot 0) (hexPivot 0 + 1) y d := by
  intro h
  rw [outerPt_anchor', outerPt_anchor', fusion_opp,
    opp_oo_clear x y b d (R := 0) (κ := 10) (by norm_num)] at h
  rcases oo_shape (C := 2) (by norm_num) (Or.inr rfl) (by norm_num)
      (Or.inr (Or.inr rfl)) h with ⟨-, -, hzero⟩ | ⟨hbd, hb2, hF, hE⟩
  · exact oo_zero_empty (Or.inr rfl) (Or.inr (Or.inr rfl)) hzero
  · exact oo_bnd_empty (Or.inr rfl) (Or.inr (Or.inr rfl)) (by norm_num) hbd hb2 hF hE

/-- The opposite oi fusion is empty at the master frame (κ = 8 refuses). -/
private theorem opp_fusion_oi_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot 3) (hexPivot 3 + 1) x b
      ≠ innerPt (hexPivot 0) (hexPivot 0 + 1) y d := by
  intro h
  rw [outerPt_anchor', innerPt_anchor, fusion_opp,
    opp_oi_clear x y b d (R := 0) (κ := 8) (by norm_num)] at h
  obtain ⟨hsign, hF, hE⟩ := oi_shape (C := 2) (by norm_num) (by norm_num)
    (by norm_num) (Or.inr (Or.inr rfl)) h
  rcases hsign with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · rw [gAddr_two, gAddr_one, show (2 : ℤ) - 1 = 1 from rfl, uAddr_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (2 * gF (X - 1) + (-2) * gF (Y - 1) + 3 * hexF (X - 1 - (Y - 1)).val = 0
        ∧ -3 * (2 * gE (X - 1)) - 2 * (2 * gE (X - 1) + 2 * gF (X - 1))
          + ((-2) * gE (Y - 1) + (-2) * gF (Y - 1))
          + 3 * (hexE (X - 1 - (Y - 1)).val + hexF (X - 1 - (Y - 1)).val)
          = 3 * 8)) x y ⟨hF, hE⟩
  · rw [gAddr_neg_two, gAddr_neg_one, show (-2 : ℤ) - -1 = -1 from rfl,
      uAddr_neg_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (2 * gF (-(X - 1) - 1) + (-2) * gF (-(Y - 1) - 1)
          + 3 * hexF (-(X - 1 - (Y - 1))).val = 0
        ∧ -3 * (2 * gE (-(X - 1) - 1)) - 2 * (2 * gE (-(X - 1) - 1) + 2 * gF (-(X - 1) - 1))
          + ((-2) * gE (-(Y - 1) - 1) + (-2) * gF (-(Y - 1) - 1))
          + 3 * (hexE (-(X - 1 - (Y - 1))).val + hexF (-(X - 1 - (Y - 1))).val)
          = 3 * 8)) x y ⟨hF, hE⟩

/-- The opposite io fusion is empty at the master frame. -/
private theorem opp_fusion_io_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot 3) (hexPivot 3 + 1) x b
      ≠ outerPt (hexPivot 0) (hexPivot 0 + 1) y d := by
  intro h
  rw [innerPt_anchor, outerPt_anchor', fusion_opp,
    opp_io_clear x y b d (R := 0) (κ := 8) (by norm_num)] at h
  have h' : ((-2 : ℤ) : ℂ) * s3 ^ 1 * gTr (y - 1) d
      + ((-(-2) : ℤ) : ℂ) * s3 ^ 0 * gTr (x - 1) b
      + ((3 : ℤ) : ℂ) * s3 ^ 0 * uTr (y - 1 - (x - 1)) (d - b) = ((8 : ℤ) : ℂ) * s3 ^ 1 := by
    rw [show (y - 1 - (x - 1) : ZMod 6) = -(x - 1 - (y - 1)) by ring,
      show (d - b : ℤ) = -(b - d) by ring, uTr_neg]
    push_cast
    push_cast at h
    linear_combination h
  obtain ⟨hsign, hF, hE⟩ := oi_shape (C := -2) (by norm_num) (by norm_num)
    (by norm_num) (Or.inr (Or.inr rfl)) h'
  rcases hsign with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · rw [gAddr_two, gAddr_one, show (2 : ℤ) - 1 = 1 from rfl, uAddr_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ ((-2) * gF (Y - 1) + (-(-2)) * gF (X - 1) + 3 * hexF (Y - 1 - (X - 1)).val = 0
        ∧ -3 * ((-2) * gE (Y - 1)) - 2 * ((-2) * gE (Y - 1) + (-2) * gF (Y - 1))
          + ((-(-2)) * gE (X - 1) + (-(-2)) * gF (X - 1))
          + 3 * (hexE (Y - 1 - (X - 1)).val + hexF (Y - 1 - (X - 1)).val)
          = 3 * 8)) x y ⟨hF, hE⟩
  · rw [gAddr_neg_two, gAddr_neg_one, show (-2 : ℤ) - -1 = -1 from rfl,
      uAddr_neg_one] at hF hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ ((-2) * gF (-(Y - 1) - 1) + (-(-2)) * gF (-(X - 1) - 1)
          + 3 * hexF (-(Y - 1 - (X - 1))).val = 0
        ∧ -3 * ((-2) * gE (-(Y - 1) - 1))
          - 2 * ((-2) * gE (-(Y - 1) - 1) + (-2) * gF (-(Y - 1) - 1))
          + ((-(-2)) * gE (-(X - 1) - 1) + (-(-2)) * gF (-(X - 1) - 1))
          + 3 * (hexE (-(Y - 1 - (X - 1))).val + hexF (-(Y - 1 - (X - 1))).val)
          = 3 * 8)) x y ⟨hF, hE⟩

/-- The opposite ii fusion is empty at the master frame (κ = 6 refuses). -/
private theorem opp_fusion_ii_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot 3) (hexPivot 3 + 1) x b
      ≠ innerPt (hexPivot 0) (hexPivot 0 + 1) y d := by
  intro h
  rw [innerPt_anchor, innerPt_anchor, fusion_opp,
    opp_ii_clear x y b d (R := 0) (κ := 6) (by norm_num)] at h
  obtain ⟨hbd, hb1, hF, hE⟩ := ii_shape (C := 2) (by norm_num) (Or.inr rfl) ⟨2, rfl⟩ h
  subst hbd
  have hb : b = 1 ∨ b = -1 := by omega
  rcases hb with rfl | rfl
  · rw [gAddr_one, gAddr_one] at hF hE
    rw [show (1 : ℤ) - 1 = 0 from rfl, uAddr_zero] at hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (2 * gF (X - 1) + (-2) * gF (Y - 1) = 0
        ∧ (2 * gE (X - 1) + (-2) * gE (Y - 1)) * (2 * (piCoeff 1).1 + (piCoeff 1).2)
          = 6 * 3 ^ 1 + 3 ^ 1 * (2 * ((-1) * hexE (X - 1 - (Y - 1)).val)
            + (-1) * hexF (X - 1 - (Y - 1)).val))) x y ⟨hF, hE⟩
  · rw [gAddr_neg_one, gAddr_neg_one] at hF hE
    rw [show (-1 : ℤ) - -1 = 0 from rfl, uAddr_zero] at hE
    exact (by decide : ∀ X Y : ZMod 6,
      ¬ (2 * gF (-(X - 1) - 1) + (-2) * gF (-(Y - 1) - 1) = 0
        ∧ (2 * gE (-(X - 1) - 1) + (-2) * gE (-(Y - 1) - 1))
            * (2 * (piCoeff 1).1 + (piCoeff 1).2)
          = 6 * 3 ^ 1 + 3 ^ 1 * (2 * ((-1) * hexE (X - 1 - (Y - 1)).val)
            + (-1) * hexF (X - 1 - (Y - 1)).val))) x y ⟨hF, hE⟩

/-- **Opposite oo completeness, all webs**: exactly the four table chords. -/
theorem opp_oo_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ oppOOTable := by
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_outer (a - 3).val 0 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, opp_shift,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter]
  exact opp_oo_zero (x - (a - 3)) b (y - (a - 3)) d

/-- **Opposite oi is empty.** -/
theorem opp_oi_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) ≠ 1 := by
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_inner (a - 3).val 0 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, opp_shift,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter]
  exact opp_oi_zero (x - (a - 3)) b (y - (a - 3)) d

/-- **Opposite io is empty** — the oi statement at `a + 3`, roles flipped. -/
theorem opp_io_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) ≠ 1 := by
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_outer (a - 3).val 0 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, opp_shift,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter]
  exact opp_io_zero (x - (a - 3)) b (y - (a - 3)) d

/-- **Opposite ii is empty**: the tangent inner circles' lattices carry no unit
chord (and, by `opp_fusion_ii`, no coincidence — the tangency is invisible). -/
theorem opp_ii_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) ≠ 1 := by
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_inner (a - 3).val 0 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, opp_shift,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter]
  exact opp_ii_zero (x - (a - 3)) b (y - (a - 3)) d

/-- The opposite oo fusion is empty. -/
theorem opp_fusion_oo (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := by
  intro he
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_outer (a - 3).val 0 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, opp_shift,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2] at he
  exact opp_fusion_oo_zero _ _ _ _ (rot6_iter_inj he)

/-- The opposite oi fusion is empty. -/
theorem opp_fusion_oi (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := by
  intro he
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_inner (a - 3).val 0 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, opp_shift,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2] at he
  exact opp_fusion_oi_zero _ _ _ _ (rot6_iter_inj he)

/-- The opposite io fusion is empty — the oi statement at `a + 3`, flipped. -/
theorem opp_fusion_io (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := by
  intro he
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_outer (a - 3).val 0 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, opp_shift,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2] at he
  exact opp_fusion_io_zero _ _ _ _ (rot6_iter_inj he)

/-- The opposite ii fusion is empty: the tangency point `m` is never a lattice
word (M24's empty `Re = √3/2` fibre, at the κ = 6√3 spine). -/
theorem opp_fusion_ii (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := by
  intro he
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_inner (a - 3).val 0 (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, opp_shift,
    show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2] at he
  exact opp_fusion_ii_zero _ _ _ _ (rot6_iter_inj he)

/-! ## §W The transported webs: pivot–meta at all six pivots, unit pairs

The pivot–meta statements extend M25's `Fin 3` quantifier to the full hexagon
(M25's shift `webShift j = 2j` is the restriction of `a − 3` to the odd
addresses); the unit-pair oo statement is M24's matching-∨-hub in hexagram
currency. -/

/-- The address-shift translations used by the fusion and hub readings. -/
private theorem shift_eq_one : ∀ A X : ZMod 6, X - (A - 3) = 1 ↔ X = A - 2 := by decide
private theorem shift_eq_zero : ∀ A X : ZMod 6, X - (A - 3) = 0 ↔ X = A - 3 := by decide
private theorem shift_eq_five : ∀ A X : ZMod 6, X - (A - 3) = 5 ↔ X = A + 2 := by decide
private theorem shift_eq_three : ∀ A X : ZMod 6, X - (A - 3) = 3 ↔ X = A := by decide

private theorem hexMeta_oo_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (outerPt metaPivot metaAnchor y d) = 1 ↔ (x, b, y, d) ∈ metaOOTable := by
  have h := meta_oo_complete 0 x b y d
  rw [show webShift 0 = 0 from rfl, sub_zero, sub_zero, pivot_zero] at h
  rw [hexPivot_three]
  exact h

private theorem hexMeta_oi_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (innerPt metaPivot metaAnchor y d) = 1 ↔
      ((y, d) = ((3 : ZMod 6), (0 : ℤ)) ∨ (x, b, y, d) ∈ metaOITable) := by
  have h := meta_oi_complete 0 x b y d
  rw [show webShift 0 = 0 from rfl, sub_zero, sub_zero, pivot_zero] at h
  rw [hexPivot_three]
  exact h

private theorem hexMeta_io_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (outerPt metaPivot metaAnchor y d) = 1 ↔ (x, b, y, d) ∈ metaIOTable := by
  have h := meta_io_complete 0 x b y d
  rw [show webShift 0 = 0 from rfl, sub_zero, sub_zero, pivot_zero] at h
  rw [hexPivot_three]
  exact h

private theorem hexMeta_ii_zero (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot 3) (hexPivot 3 + 1) x b)
      (innerPt metaPivot metaAnchor y d) = 1 ↔ (x, b, y, d) ∈ metaIITable := by
  have h := meta_ii_complete 0 x b y d
  rw [show webShift 0 = 0 from rfl, sub_zero, sub_zero, pivot_zero] at h
  rw [hexPivot_three]
  exact h

private theorem hexMeta_fusion_oi_zero' (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot 3) (hexPivot 3 + 1) x b = innerPt metaPivot metaAnchor y d ↔
      ((x = 1 ∧ b = 0 ∧ y = 1 ∧ d = 0) ∨ (x = 0 ∧ b = 0 ∧ y = 5 ∧ d = 0)) := by
  have h := meta_fusion_oi 0 x b y d
  rw [show webShift 0 = 0 from rfl, sub_zero, sub_zero, pivot_zero] at h
  rw [hexPivot_three]
  exact h

/-- **oo completeness at the metapivot axis, all SIX webs** (extends M25's
`meta_oo_complete`). -/
theorem hexMeta_oo_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt metaPivot metaAnchor y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ metaOOTable := by
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_metaOuter (a - 3).val (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter]
  exact hexMeta_oo_zero (x - (a - 3)) b (y - (a - 3)) d

/-- **oi completeness at the metapivot axis, all six webs**: the hub pencil
through the fused pivot plus the four sporadics. -/
theorem hexMeta_oi_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt metaPivot metaAnchor y d) = 1 ↔
      ((y = a ∧ d = 0) ∨ (x - (a - 3), b, y - (a - 3), d) ∈ metaOITable) := by
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_metaInner (a - 3).val (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter, hexMeta_oi_zero]
  constructor
  · rintro (hp | hm)
    · simp only [Prod.mk.injEq] at hp
      exact Or.inl ⟨(shift_eq_three a y).mp hp.1, hp.2⟩
    · exact Or.inr hm
  · rintro (⟨hy, hd⟩ | hm)
    · exact Or.inl (by
        simp only [Prod.mk.injEq]
        exact ⟨(shift_eq_three a y).mpr hy, hd⟩)
    · exact Or.inr hm

/-- **io completeness at the metapivot axis, all six webs.** -/
theorem hexMeta_io_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt metaPivot metaAnchor y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ metaIOTable := by
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_metaOuter (a - 3).val (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter]
  exact hexMeta_io_zero (x - (a - 3)) b (y - (a - 3)) d

/-- **ii completeness at the metapivot axis, all six webs.** -/
theorem hexMeta_ii_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt metaPivot metaAnchor y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ metaIITable := by
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_metaInner (a - 3).val (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2, dist_rot6_iter]
  exact hexMeta_ii_zero (x - (a - 3)) b (y - (a - 3)) d

/-- **The oi fusion at all six webs**: pivot `a`'s outer lattice meets the
meta-inner lattice at exactly the two second-neighbour pivots. -/
theorem hexMeta_fusion_oi (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b = innerPt metaPivot metaAnchor y d ↔
      ((x = a - 2 ∧ b = 0 ∧ y = a - 2 ∧ d = 0)
        ∨ (x = a - 3 ∧ b = 0 ∧ y = a + 2 ∧ d = 0)) := by
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_metaInner (a - 3).val (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2]
  constructor
  · intro he
    rcases (hexMeta_fusion_oi_zero' (x - (a - 3)) b (y - (a - 3)) d).mp
        (rot6_iter_inj he) with ⟨hx, hb, hy, hd⟩ | ⟨hx, hb, hy, hd⟩
    · exact Or.inl ⟨(shift_eq_one a x).mp hx, hb, (shift_eq_one a y).mp hy, hd⟩
    · exact Or.inr ⟨(shift_eq_zero a x).mp hx, hb, (shift_eq_five a y).mp hy, hd⟩
  · intro he
    refine congrArg (rot6^[(a - 3).val]) ?_
    refine (hexMeta_fusion_oi_zero' (x - (a - 3)) b (y - (a - 3)) d).mpr ?_
    rcases he with ⟨hx, hb, hy, hd⟩ | ⟨hx, hb, hy, hd⟩
    · exact Or.inl ⟨(shift_eq_one a x).mpr hx, hb, (shift_eq_one a y).mpr hy, hd⟩
    · exact Or.inr ⟨(shift_eq_zero a x).mpr hx, hb, (shift_eq_five a y).mpr hy, hd⟩

/-- The oo fusion at the metapivot axis is empty at every pivot. -/
theorem hexMeta_fusion_oo (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt metaPivot metaAnchor y d := by
  intro he
  have h1 := rot6_iter_outer (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_metaOuter (a - 3).val (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2] at he
  have hz := rot6_iter_inj he
  rw [show outerPt (hexPivot 3) (hexPivot 3 + 1) (x - (a - 3)) b
      = outerPt (pivot 0) (pivot 0 + 1) (x - (a - 3)) b from by
    rw [hexPivot_three, pivot_zero]] at hz
  exact meta_fusion_oo 0 (x - (a - 3)) b (y - (a - 3)) d hz

/-- The io fusion at the metapivot axis is empty at every pivot. -/
theorem hexMeta_fusion_io (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt metaPivot metaAnchor y d := by
  intro he
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_metaOuter (a - 3).val (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2] at he
  have hz := rot6_iter_inj he
  rw [show innerPt (hexPivot 3) (hexPivot 3 + 1) (x - (a - 3)) b
      = innerPt (pivot 0) (pivot 0 + 1) (x - (a - 3)) b from by
    rw [hexPivot_three, pivot_zero]] at hz
  exact meta_fusion_io 0 (x - (a - 3)) b (y - (a - 3)) d hz

/-- The ii fusion at the metapivot axis is empty at every pivot. -/
theorem hexMeta_fusion_ii (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt metaPivot metaAnchor y d := by
  intro he
  have h1 := rot6_iter_inner (a - 3).val 3 (x - (a - 3)) b
  have h2 := rot6_iter_metaInner (a - 3).val (y - (a - 3)) d
  rw [zmod_cast_val, show (3 : ZMod 6) + (a - 3) = a by ring,
    show (x - (a - 3) + (a - 3) : ZMod 6) = x by ring] at h1
  rw [zmod_cast_val, show (y - (a - 3) + (a - 3) : ZMod 6) = y by ring] at h2
  rw [← h1, ← h2] at he
  have hz := rot6_iter_inj he
  rw [show innerPt (hexPivot 3) (hexPivot 3 + 1) (x - (a - 3)) b
      = innerPt (pivot 0) (pivot 0 + 1) (x - (a - 3)) b from by
    rw [hexPivot_three, pivot_zero]] at hz
  exact meta_fusion_ii 0 (x - (a - 3)) b (y - (a - 3)) d hz

/-! ### §W.1 The unit pairs: M24's pair theorems, re-anchored -/

/-- Second-neighbour pivots differ by a hex root: the re-anchoring fact. -/
private theorem hexPivot_unit_diff (a : ZMod 6) :
    hexPivot (a + 2) - hexPivot a = word (a + 3) 0 := by
  rw [hexPivot_sub, show word (a + 3) 0 = word a 0 * word 3 0 from by
    rw [← word_add, add_zero],
    show word (3 : ZMod 6) 0 = zeta6 ^ 3 from by
      rw [show (3 : ZMod 6) = ((3 : ℕ) : ZMod 6) from rfl, word_pow 3 (by norm_num)],
    zeta6_cube', show word (2 : ZMod 6) 0 = zeta6 ^ 2 from by
      rw [show (2 : ZMod 6) = ((2 : ℕ) : ZMod 6) from rfl, word_pow 2 (by norm_num)]]
  have hm := three_metaPivot
  have h3 : (3 : ℂ) * (metaPivot * word a 0 * (zeta6 ^ 2 - 1))
      = 3 * (word a 0 * -1) := by
    linear_combination word a 0 * (zeta6 ^ 2 - 1) * hm
      + (word a 0 * (zeta6 + 2)) * zeta6_minpoly
  have := mul_left_cancel₀ (by norm_num : (3 : ℂ) ≠ 0) h3
  linear_combination this

/-- Pivot `a`'s ladder re-anchored onto the unit pair `(hexPivot a, hexPivot (a+2))`:
the address shifts by `3 − a`. -/
private theorem unit_reanchor_outer (a x : ZMod 6) (b : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      = outerPt (hexPivot a) (hexPivot (a + 2)) (x + (3 - a)) b := by
  refine outerPt_hexRot (hexPivot a) (hexPivot (a + 2)) (hexPivot a + 1) (3 - a) x b ?_
  rw [add_sub_cancel_left, show zeta6 ^ (((3 - a : ZMod 6)).val : ℤ) = word (3 - a) 0 from
    (word_k0 _).symm, hexPivot_unit_diff, ← word_add,
    (by decide : ∀ A : ZMod 6, (3 - A + (A + 3) : ZMod 6) = 0) a, add_zero]
  exact ((word_eq_one_iff 0 0).mpr ⟨rfl, rfl⟩).symm

private theorem unit_reanchor_inner (a x : ZMod 6) (b : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      = innerPt (hexPivot a) (hexPivot (a + 2)) (x + (3 - a)) b := by
  refine innerPt_hexRot (hexPivot a) (hexPivot (a + 2)) (hexPivot a + 1) (3 - a) x b ?_
  rw [add_sub_cancel_left, show zeta6 ^ (((3 - a : ZMod 6)).val : ℤ) = word (3 - a) 0 from
    (word_k0 _).symm, hexPivot_unit_diff, ← word_add,
    (by decide : ∀ A : ZMod 6, (3 - A + (A + 3) : ZMod 6) = 0) a, add_zero]
  exact ((word_eq_one_iff 0 0).mpr ⟨rfl, rfl⟩).symm

/-- The reverse diff: pivot `a` from pivot `a+2` is the hex root `ζ₆^a`. -/
private theorem hexPivot_unit_diff' (a : ZMod 6) :
    hexPivot a - hexPivot (a + 2) = word a 0 := by
  have h := hexPivot_sub (a + 2) 4
  rw [(by decide : ∀ A : ZMod 6, A + 2 + 4 = A) a,
    show word (4 : ZMod 6) 0 = zeta6 ^ 4 from by
      rw [show (4 : ZMod 6) = ((4 : ℕ) : ZMod 6) from rfl, word_pow 4 (by norm_num)]] at h
  rw [h]
  have hm := three_metaPivot
  have hw : word (a + 2) 0 = word a 0 * zeta6 ^ 2 := by
    rw [show word (a + 2) 0 = word a 0 * word 2 0 from by rw [← word_add, add_zero],
      show word (2 : ZMod 6) 0 = zeta6 ^ 2 from by
        rw [show (2 : ZMod 6) = ((2 : ℕ) : ZMod 6) from rfl, word_pow 2 (by norm_num)]]
  have h3 : (3 : ℂ) * (metaPivot * word (a + 2) 0 * (zeta6 ^ 4 - 1))
      = 3 * word a 0 := by
    rw [hw]
    linear_combination (word a 0 * zeta6 ^ 2 * (zeta6 ^ 4 - 1)) * hm
      + (word a 0 * (zeta6 ^ 5 + 2 * zeta6 ^ 4 + zeta6 ^ 3 - zeta6 ^ 2 - 3 * zeta6 - 3))
        * zeta6_minpoly
  exact mul_left_cancel₀ (by norm_num : (3 : ℂ) ≠ 0) h3

/-- Pivot `a+2`'s ladder re-anchored back onto pivot `a`: the shift is `−a`. -/
private theorem unit_reanchor_outer' (a y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot (a + 2)) (hexPivot (a + 2) + 1) y d
      = outerPt (hexPivot (a + 2)) (hexPivot a) (y + (-a)) d := by
  refine outerPt_hexRot (hexPivot (a + 2)) (hexPivot a) (hexPivot (a + 2) + 1) (-a) y d ?_
  rw [add_sub_cancel_left, show zeta6 ^ (((-a : ZMod 6)).val : ℤ) = word (-a) 0 from
    (word_k0 _).symm, hexPivot_unit_diff', ← word_add,
    show (-a + a : ZMod 6) = 0 by ring, add_zero]
  exact ((word_eq_one_iff 0 0).mpr ⟨rfl, rfl⟩).symm

private theorem unit_reanchor_inner' (a y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot (a + 2)) (hexPivot (a + 2) + 1) y d
      = innerPt (hexPivot (a + 2)) (hexPivot a) (y + (-a)) d := by
  refine innerPt_hexRot (hexPivot (a + 2)) (hexPivot a) (hexPivot (a + 2) + 1) (-a) y d ?_
  rw [add_sub_cancel_left, show zeta6 ^ (((-a : ZMod 6)).val : ℤ) = word (-a) 0 from
    (word_k0 _).symm, hexPivot_unit_diff', ← word_add,
    show (-a + a : ZMod 6) = 0 by ring, add_zero]
  exact ((word_eq_one_iff 0 0).mpr ⟨rfl, rfl⟩).symm

/-- The unit-pair axis fact in the orientation the pair theorems take. -/
private theorem dist_unit_pair (a : ZMod 6) : dist (hexPivot a) (hexPivot (a + 2)) = 1 := by
  rw [dist_comm]
  exact dist_hexPivot_unit a

/-- **Unit-pair oo, all six pairs, in hexagram currency**: the translation
matching or one of the two hub pencils (M24's `oo_complete` re-addressed —
`x = a−3, b = 0` is the point AT the far centre, `y = a, d = 0` the point at the
near one). -/
theorem unit_oo_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 2)) (hexPivot (a + 2) + 1) y d) = 1 ↔
      ((y = x ∧ d = b) ∨ (x = a - 3 ∧ b = 0) ∨ (y = a ∧ d = 0)) := by
  rw [unit_reanchor_outer, unit_reanchor_outer',
    oo_complete (dist_unit_pair a) (x + (3 - a)) b (y + (-a)) d]
  constructor
  · rintro (⟨h1, rfl⟩ | ⟨h1, rfl⟩ | ⟨h1, rfl⟩)
    · exact Or.inl ⟨(by decide : ∀ A X Y : ZMod 6,
        Y + -A = X + (3 - A) + 3 → Y = X) a x y h1, rfl⟩
    · exact Or.inr (Or.inl ⟨(by decide : ∀ A X : ZMod 6,
        X + (3 - A) = 0 → X = A - 3) a x h1, rfl⟩)
    · exact Or.inr (Or.inr ⟨(by decide : ∀ A Y : ZMod 6,
        Y + -A = 0 → Y = A) a y h1, rfl⟩)
  · rintro (⟨hy, hd⟩ | ⟨hx, hb⟩ | ⟨hy, hd⟩)
    · exact Or.inl ⟨by
        rw [hy]
        exact (by decide : ∀ A X : ZMod 6, X + -A = X + (3 - A) + 3) a x, hd⟩
    · exact Or.inr (Or.inl ⟨by
        rw [hx]
        exact (by decide : ∀ A : ZMod 6, A - 3 + (3 - A) = 0) a, hb⟩)
    · exact Or.inr (Or.inr ⟨by
        rw [hy]
        exact (by decide : ∀ A : ZMod 6, A + -A = 0) a, hd⟩)

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
