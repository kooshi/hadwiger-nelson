import Proofs.HadwigerNelson.Ladder

/-!
# M25 — The four-ladder object: the pivot triangle's ladders plus the metapivot's own

The **four-ladder object**: the M24 ladders of the three pivots `0, 1, ζ₆` and of the
metapivot `m = (1+ζ₆)/3`, closed under all unit chords.  Every sub-ladder is an M24
`outerPt`/`innerPt` family at an anchor pair — `(0,1)`, `(1,2)`, `(ζ₆,ζ₆+1)` for the
pivots (anchor direction 1 serves all three, the word absorbing the hex rotations) and
`(m, m+ζ₁₂)` for the metapivot (its axis to the pivot 0 scaled to unit length) — so the
whole M24 intra theory applies verbatim, and the new content is exactly the
pivot–metapivot cross-webs at axis 1/√3.

Census (§0, exact, B = 60, commit-registered predictions): per web the oo, io and ii
families are FINITE — four sporadic chords each, all at seam height |b| ≤ 1 — and the
oi family is the hub pencil through the fused pivot (`metaInner (3,0) = 0`) plus four
hex-layer sporadics.  The three webs are `a ↦ a+2` shifts of one another.  The colour
probe: k = 3 UNSAT (control), k = 4 SAT, and a b-independent table exists.

**The engine.**  One identity moves the whole milestone: `√3·ζ₁₂ = 1 + ζ₆`
(`sqrt3_mul_zeta12`), i.e. `ζ₁₂ = (1+ζ₆)/√3` — the metapivot relation read one radius
out.  With `g := 1 + ζ₆` the twelfth root disappears from every web equation, which
becomes a `ℤ[√3]`-combination of M24 trace pairs over `ℤ[ζ₆, π]`: M24's separation
(`√3 ∉ ℚ(ζ₆,π)`), its `piCoeff` congruence rows and its hex tables carry M25 verbatim,
generalized once through `hexTrace` (§E).  The registered `ℤ[ζ₁₂,π]` eight-coordinate
layer is *not* where the equations live and is not built.
-/

namespace HadwigerNelson
namespace MetaLadder

open Complex TwoCircle Ladder

/-! ## §0 Shared arithmetic

M24 keeps its small algebraic helpers `private`, so the few this module needs are
re-derived here from the public surface — the same move `Ladder.lean` § 0 makes against
`Triangle.lean`.  All are one-liners over `sq_sqrt3` and the hex minimal polynomial. -/

private theorem sq_sqrt3 : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt11 : Real.sqrt 11 * Real.sqrt 11 = 11 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sqrt3_cast_sq : ((Real.sqrt 3 : ℝ) : ℂ) * ((Real.sqrt 3 : ℝ) : ℂ) = 3 := by
  rw [← Complex.ofReal_mul, sq_sqrt3]
  norm_num

private theorem zeta6_minpoly : zeta6 ^ 2 - zeta6 + 1 = 0 := by
  apply Complex.ext <;>
    simp [zeta6, pow_two, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3]

private theorem zeta6_cube : zeta6 ^ 3 = -1 := by
  linear_combination (zeta6 + 1) * zeta6_minpoly

private theorem norm_eq_one_iff {z : ℂ} : ‖z‖ = 1 ↔ normSq z = 1 := by
  rw [← Complex.sq_norm]
  constructor
  · intro h; rw [h]; norm_num
  · intro h; nlinarith [norm_nonneg z]

private theorem word_k0 (k : ZMod 6) : word k 0 = zeta6 ^ (k.val : ℤ) := by
  rw [word, zpow_zero, mul_one]

/-! ## §Z The twelfth root and the metapivot -/

/-- `ζ₁₂ = e^{iπ/6} = (√3 + i)/2` — the 30° anchor of the metapivot's axis. -/
noncomputable def zeta12 : ℂ := ⟨Real.sqrt 3 / 2, 1 / 2⟩

/-- The metapivot: the centroid of the pivot triangle. -/
noncomputable def metaPivot : ℂ := ⟨1 / 2, Real.sqrt 3 / 6⟩

theorem zeta12_sq : zeta12 ^ 2 = zeta6 := by
  apply Complex.ext <;>
    simp [zeta12, zeta6, pow_two, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3]

theorem normSq_zeta12 : normSq zeta12 = 1 := by
  simp only [normSq_apply, zeta12]
  nlinarith [sq_sqrt3]

theorem norm_zeta12 : ‖zeta12‖ = 1 := norm_eq_one_iff.mpr normSq_zeta12

theorem zeta12_pow_three : zeta12 ^ 3 = Complex.I := by
  rw [show zeta12 ^ 3 = zeta12 ^ 2 * zeta12 by ring, zeta12_sq]
  apply Complex.ext <;>
    simp [zeta12, zeta6, Complex.I, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3]

/-- The minimal polynomial: `ζ₁₂⁴ = ζ₁₂² − 1`. -/
theorem zeta12_minpoly : zeta12 ^ 4 - zeta12 ^ 2 + 1 = 0 := by
  rw [show zeta12 ^ 4 = (zeta12 ^ 2) ^ 2 by ring, zeta12_sq]
  exact zeta6_minpoly

/-- **The M25 engine identity**: `√3·ζ₁₂ = 1 + ζ₆`.  The twelfth root is the hex
element `g = 1 + ζ₆` divided by `√3`, so every meta-axis equation clears into
`ℤ[ζ₆, π]` and M24's machinery applies unchanged. -/
theorem sqrt3_mul_zeta12 : ((Real.sqrt 3 : ℝ) : ℂ) * zeta12 = 1 + zeta6 := by
  apply Complex.ext <;>
    simp [zeta12, zeta6, Complex.mul_re, Complex.mul_im, Complex.ofReal_re,
      Complex.ofReal_im] <;>
    nlinarith [sq_sqrt3]

/-- `√3` lives in the ζ₁₂-ring: the fact that kills the M24 separation *there* — and the
reason the equations are kept out of that ring (see the module docstring). -/
theorem sqrt3_eq_zeta12 : ((Real.sqrt 3 : ℝ) : ℂ) = 2 * zeta12 - zeta12 ^ 3 := by
  rw [zeta12_pow_three]
  apply Complex.ext
  · simp [zeta12, Complex.I, Complex.ofReal_re]
    ring
  · simp [zeta12, Complex.I, Complex.ofReal_im]

theorem meta_eq_centroid : metaPivot = (1 + zeta6) / 3 := by
  rw [eq_div_iff (by norm_num : (3 : ℂ) ≠ 0)]
  apply Complex.ext <;>
    simp [metaPivot, zeta6, Complex.mul_re, Complex.mul_im] <;>
    ring

/-- `m = ζ₁₂/√3`: the metapivot sits at one inner radius along the ζ₁₂ direction. -/
theorem meta_eq : metaPivot = ((Real.sqrt 3 / 3 : ℝ) : ℂ) * zeta12 := by
  apply Complex.ext <;>
    simp [metaPivot, zeta12, Complex.mul_re, Complex.mul_im, Complex.ofReal_re,
      Complex.ofReal_im] <;>
    nlinarith [sq_sqrt3]

/-- The metapivot's anchor partner: distance 1 along its own axis. -/
noncomputable def metaAnchor : ℂ := metaPivot + zeta12

theorem metaAnchor_sub : metaAnchor - metaPivot = zeta12 := by
  rw [metaAnchor]; ring

theorem dist_meta_metaAnchor : dist metaPivot metaAnchor = 1 := by
  rw [dist_eq_norm, show metaPivot - metaAnchor = -zeta12 by rw [metaAnchor]; ring,
    norm_neg, norm_zeta12]

private theorem zeta12_pow_five : zeta12 ^ 5 = zeta6 * Complex.I := by
  rw [show zeta12 ^ 5 = zeta12 ^ 2 * zeta12 ^ 3 by ring, zeta12_sq, zeta12_pow_three]

private theorem zeta12_pow_nine : zeta12 ^ 9 = -Complex.I := by
  rw [show zeta12 ^ 9 = (zeta12 ^ 3) ^ 3 by ring, zeta12_pow_three]
  apply Complex.ext <;> simp [Complex.I, pow_succ, Complex.mul_re, Complex.mul_im]

/-- The three pivot→metapivot unit directions are the odd coset `ζ₁₂·⟨ζ₆⟩`:
`√3·(m − 0) = ζ₁₂`, `√3·(m − 1) = ζ₁₂⁵`, `√3·(m − ζ₆) = ζ₁₂⁹`. -/
theorem meta_axis_dirs :
    ((Real.sqrt 3 : ℝ) : ℂ) * (metaPivot - 0) = zeta12 ^ (1 : ℕ)
      ∧ ((Real.sqrt 3 : ℝ) : ℂ) * (metaPivot - 1) = zeta12 ^ (5 : ℕ)
      ∧ ((Real.sqrt 3 : ℝ) : ℂ) * (metaPivot - zeta6) = zeta12 ^ (9 : ℕ) := by
  refine ⟨?_, ?_, ?_⟩
  · rw [pow_one, sub_zero, meta_eq]
    rw [show ((Real.sqrt 3 / 3 : ℝ) : ℂ) = ((Real.sqrt 3 : ℝ) : ℂ) / 3 by push_cast; ring]
    field_simp
    linear_combination zeta12 * sqrt3_cast_sq
  · rw [zeta12_pow_five]
    apply Complex.ext <;>
      simp [metaPivot, zeta6, Complex.I, Complex.mul_re, Complex.mul_im,
        Complex.ofReal_re, Complex.ofReal_im] <;>
      nlinarith [sq_sqrt3]
  · rw [zeta12_pow_nine]
    apply Complex.ext
    · simp [metaPivot, zeta6, Complex.I, Complex.mul_re, Complex.ofReal_re,
        Complex.ofReal_im]
    · simp [metaPivot, zeta6, Complex.I, Complex.mul_im, Complex.ofReal_re,
        Complex.ofReal_im]
      nlinarith [sq_sqrt3]

/-! ## §L The four ladders — all M24 `outerPt`/`innerPt` families -/

/-- The three pivots of the triangle. -/
noncomputable def pivot : Fin 3 → ℂ := ![0, 1, zeta6]

theorem pivot_zero : pivot 0 = 0 := rfl
theorem pivot_one : pivot 1 = 1 := rfl
theorem pivot_two : pivot 2 = zeta6 := rfl

/-- The four anchor pairs: each pivot with the direction-1 partner beside it, the
metapivot with its own ζ₁₂-directed partner. -/
noncomputable def anchor : Fin 4 → ℂ × ℂ
  | 0 => (pivot 0, pivot 0 + 1)
  | 1 => (pivot 1, pivot 1 + 1)
  | 2 => (pivot 2, pivot 2 + 1)
  | 3 => (metaPivot, metaAnchor)

theorem anchor_zero : anchor 0 = (0, 1) := by
  rw [show anchor 0 = (pivot 0, pivot 0 + 1) from rfl, pivot_zero, zero_add]

theorem anchor_one : anchor 1 = (1, 2) := by
  rw [show anchor 1 = (pivot 1, pivot 1 + 1) from rfl, pivot_one]
  norm_num

theorem anchor_two : anchor 2 = (zeta6, zeta6 + 1) := rfl

theorem anchor_three : anchor 3 = (metaPivot, metaAnchor) := rfl

theorem anchor_pivot (j : Fin 3) :
    anchor (j.castSucc) = (pivot j, pivot j + 1) := by fin_cases j <;> rfl

theorem anchor_dist (k : Fin 4) : dist (anchor k).1 (anchor k).2 = 1 := by
  fin_cases k
  · show dist (pivot 0) (pivot 0 + 1) = 1
    rw [dist_eq_norm]; simp
  · show dist (pivot 1) (pivot 1 + 1) = 1
    rw [dist_eq_norm]; simp
  · show dist (pivot 2) (pivot 2 + 1) = 1
    rw [dist_eq_norm]; simp
  · exact dist_meta_metaAnchor

/-- The pivot axis facts, in the shape every M24 citation needs. -/
theorem dist_pivot (j : Fin 3) : dist (pivot j) (pivot j + 1) = 1 := by
  rw [dist_eq_norm]; simp

/-- The four-ladder object: every outer and inner lattice point of the four anchors. -/
noncomputable def fourLadder : Set ℂ :=
  ⋃ k : Fin 4, ({z | ∃ a b, z = outerPt (anchor k).1 (anchor k).2 a b}
    ∪ {z | ∃ a b, z = innerPt (anchor k).1 (anchor k).2 a b})

/-- Membership intro: every outer lattice point of an anchor is in the object. -/
theorem outer_mem_fourLadder (k : Fin 4) (a : ZMod 6) (b : ℤ) :
    outerPt (anchor k).1 (anchor k).2 a b ∈ fourLadder :=
  Set.mem_iUnion.mpr ⟨k, Or.inl ⟨a, b, rfl⟩⟩

/-- Membership intro: every inner lattice point of an anchor is in the object. -/
theorem inner_mem_fourLadder (k : Fin 4) (a : ZMod 6) (b : ℤ) :
    innerPt (anchor k).1 (anchor k).2 a b ∈ fourLadder :=
  Set.mem_iUnion.mpr ⟨k, Or.inr ⟨a, b, rfl⟩⟩

/-! ## §T Transport: anchor-independence and the web rotation -/

/-- **Anchor-independence, the general fact**: rotating the anchor partner by a hex
power re-addresses the ladder — every pivot-pair re-addressing, the M24-subset
inclusion, and the web transports are instances. -/
theorem outerPt_hexRot (p q q' : ℂ) (k : ZMod 6) (a : ZMod 6) (b : ℤ)
    (h : q' - p = zeta6 ^ (k.val : ℤ) * (q - p)) :
    outerPt p q' a b = outerPt p q (a + k) b := by
  have hw : word (a + k) b = word a b * zeta6 ^ (k.val : ℤ) := by
    have := word_add a k b 0
    rw [add_zero, word_k0] at this
    exact this
  rw [outerPt, outerPt, h, hw]
  ring

theorem innerPt_hexRot (p q q' : ℂ) (k : ZMod 6) (a : ZMod 6) (b : ℤ)
    (h : q' - p = zeta6 ^ (k.val : ℤ) * (q - p)) :
    innerPt p q' a b = innerPt p q (a + k) b := by
  have hw : word (a + k) b = word a b * zeta6 ^ (k.val : ℤ) := by
    have := word_add a k b 0
    rw [add_zero, word_k0] at this
    exact this
  rw [innerPt, innerPt, h, hw]
  ring

/-- **Affine equivariance**: any map `z ↦ w + r·(z − w)` carries ladder points to
ladder points of the mapped anchors (no unit-modulus needed) — the web transports are
the `r = ζ₆²` instances. -/
theorem outerPt_affine (w r p q : ℂ) (a : ZMod 6) (b : ℤ) :
    w + r * (outerPt p q a b - w)
      = outerPt (w + r * (p - w)) (w + r * (q - w)) a b := by
  rw [outerPt, outerPt]; ring

theorem innerPt_affine (w r p q : ℂ) (a : ZMod 6) (b : ℤ) :
    w + r * (innerPt p q a b - w)
      = innerPt (w + r * (p - w)) (w + r * (q - w)) a b := by
  rw [innerPt, innerPt]; ring

/-- The 120° rotation about the metapivot is an isometry. -/
theorem dist_metaRot (z w : ℂ) :
    dist (metaPivot + zeta6 ^ 2 * (z - metaPivot)) (metaPivot + zeta6 ^ 2 * (w - metaPivot))
      = dist z w := by
  rw [dist_eq_norm, dist_eq_norm,
    show metaPivot + zeta6 ^ 2 * (z - metaPivot) - (metaPivot + zeta6 ^ 2 * (w - metaPivot))
      = zeta6 ^ 2 * (z - w) by ring, norm_mul, norm_pow, norm_zeta6, one_pow, one_mul]

/-- The 120° rotation about the metapivot permutes the pivots cyclically. -/
private theorem rot_pivot (j : Fin 3) :
    metaPivot + zeta6 ^ 2 * (pivot j - metaPivot) = pivot (j + 1) := by
  have hm := meta_eq_centroid
  fin_cases j
  · show metaPivot + zeta6 ^ 2 * (pivot 0 - metaPivot) = pivot 1
    rw [pivot_zero, pivot_one, hm]
    linear_combination ((-zeta6 - 2) / 3) * zeta6_minpoly
  · show metaPivot + zeta6 ^ 2 * (pivot 1 - metaPivot) = pivot 2
    rw [pivot_one, pivot_two, hm]
    linear_combination ((1 - zeta6) / 3) * zeta6_minpoly
  · show metaPivot + zeta6 ^ 2 * (pivot 2 - metaPivot) = pivot 0
    rw [pivot_two, pivot_zero, hm]
    linear_combination ((2 * zeta6 + 1) / 3) * zeta6_minpoly

private theorem zeta6_zpow_two : zeta6 ^ (((2 : ZMod 6)).val : ℤ) = zeta6 ^ 2 := by
  rw [show (((2 : ZMod 6)).val : ℤ) = ((2 : ℕ) : ℤ) from rfl, zpow_natCast]

/-- The rotated anchor partner is the hex-`+2` re-addressing of the standard one. -/
private theorem rot_anchor (j : Fin 3) :
    metaPivot + zeta6 ^ 2 * (pivot j + 1 - metaPivot) - pivot (j + 1)
      = zeta6 ^ (((2 : ZMod 6)).val : ℤ) * (pivot (j + 1) + 1 - pivot (j + 1)) := by
  rw [zeta6_zpow_two, ← rot_pivot j]
  ring

/-- The 120° rotation about the metapivot carries pivot `j`'s ladder to pivot `j+1`'s
with the `+2` shift — the geometry behind the `webShift` re-indexing. -/
theorem web_transport_rot (j : Fin 3) (a : ZMod 6) (b : ℤ) :
    metaPivot + zeta6 ^ 2 * (outerPt (pivot j) (pivot j + 1) a b - metaPivot)
      = outerPt (pivot (j + 1)) (pivot (j + 1) + 1) (a + 2) b := by
  rw [outerPt_affine, rot_pivot j]
  exact outerPt_hexRot _ _ _ 2 a b (rot_anchor j)

theorem web_transport_rot_inner (j : Fin 3) (a : ZMod 6) (b : ℤ) :
    metaPivot + zeta6 ^ 2 * (innerPt (pivot j) (pivot j + 1) a b - metaPivot)
      = innerPt (pivot (j + 1)) (pivot (j + 1) + 1) (a + 2) b := by
  rw [innerPt_affine, rot_pivot j]
  exact innerPt_hexRot _ _ _ 2 a b (rot_anchor j)

/-- The same rotation fixes the metapivot's ladder up to the `+2` shift. -/
theorem web_transport_rot_meta (a : ZMod 6) (b : ℤ) :
    metaPivot + zeta6 ^ 2 * (outerPt metaPivot metaAnchor a b - metaPivot)
      = outerPt metaPivot metaAnchor (a + 2) b := by
  rw [outerPt_affine, show metaPivot + zeta6 ^ 2 * (metaPivot - metaPivot) = metaPivot by ring]
  refine outerPt_hexRot _ _ _ 2 a b ?_
  rw [show (((2 : ZMod 6)).val : ℤ) = ((2 : ℕ) : ℤ) from rfl, zpow_natCast, metaAnchor]
  ring

theorem web_transport_rot_meta_inner (a : ZMod 6) (b : ℤ) :
    metaPivot + zeta6 ^ 2 * (innerPt metaPivot metaAnchor a b - metaPivot)
      = innerPt metaPivot metaAnchor (a + 2) b := by
  rw [innerPt_affine, show metaPivot + zeta6 ^ 2 * (metaPivot - metaPivot) = metaPivot by ring]
  refine innerPt_hexRot _ _ _ 2 a b ?_
  rw [show (((2 : ZMod 6)).val : ℤ) = ((2 : ℕ) : ℤ) from rfl, zpow_natCast, metaAnchor]
  ring

/-- M24's matched pair is the first two ladders: the lower bound transports. -/
theorem ladderSet_subset_fourLadder : ladderSet ⊆ fourLadder := by
  have hq : ∀ (a : ZMod 6) (b : ℤ), outerPt 1 0 a b = outerPt 1 2 (a + 3) b := by
    intro a b
    refine outerPt_hexRot _ _ _ 3 a b ?_
    rw [show (((3 : ZMod 6)).val : ℤ) = ((3 : ℕ) : ℤ) from rfl, zpow_natCast, zeta6_cube]
    ring
  have hqi : ∀ (a : ZMod 6) (b : ℤ), innerPt 1 0 a b = innerPt 1 2 (a + 3) b := by
    intro a b
    refine innerPt_hexRot _ _ _ 3 a b ?_
    rw [show (((3 : ZMod 6)).val : ℤ) = ((3 : ℕ) : ℤ) from rfl, zpow_natCast, zeta6_cube]
    ring
  rintro z ((⟨⟨a, b⟩, rfl⟩ | ⟨⟨a, b⟩, rfl⟩) | (⟨⟨a, b⟩, rfl⟩ | ⟨⟨a, b⟩, rfl⟩))
  · have := outer_mem_fourLadder 0 a b
    rwa [anchor_zero] at this
  · have := inner_mem_fourLadder 0 a b
    rwa [anchor_zero] at this
  · have := outer_mem_fourLadder 1 (a + 3) b
    rw [anchor_one] at this
    show outerPt 1 0 a b ∈ fourLadder
    rw [hq a b]
    exact this
  · have := inner_mem_fourLadder 1 (a + 3) b
    rw [anchor_one] at this
    show innerPt 1 0 a b ∈ fourLadder
    rw [hqi a b]
    exact this

/-! ## §W The pivot–metapivot webs

Shorthands, in the frame the census used: outer/inner of pivot `j` are
`outerPt (pivot j) (pivot j + 1)`/`innerPt …`; outer/inner of the metapivot are
`outerPt metaPivot metaAnchor`/`innerPt …`. -/

/-- The hub: the metapivot's inner point at address `(3,0)` IS the pivot `0`, so every
outer point of the pivot is a chord end — the only infinite family of the web. -/
theorem metaInner_hub : innerPt metaPivot metaAnchor 3 0 = 0 := by
  have h3 : word 3 0 = -1 := by
    rw [word_k0, show (((3 : ZMod 6)).val : ℤ) = ((3 : ℕ) : ℤ) from rfl, zpow_natCast]
    exact zeta6_cube
  rw [innerPt, h3, metaAnchor_sub,
    show ((Real.sqrt 3 / 3 : ℝ) : ℂ) * -1 * zeta12
      = -(((Real.sqrt 3 / 3 : ℝ) : ℂ) * zeta12) by ring, ← meta_eq]
  ring

/-- oo: the four sporadic chords `outer(0) ↔ outer(m)` (census-exact, |b| ≤ 1). -/
def metaOOTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(0, 0, 5, -1), (0, 0, 5, 1), (1, 0, 1, -1), (1, 0, 1, 1)]

/-- oi: the four sporadic chords `outer(0) ↔ inner(m)` beyond the hub pencil. -/
def metaOITable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(0, 0, 1, 0), (1, 0, 5, 0), (2, 0, 1, 0), (5, 0, 5, 0)]

/-- io: the four sporadic chords `inner(0) ↔ outer(m)`. -/
def metaIOTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(2, -1, 5, 1), (2, 1, 5, -1), (5, -1, 1, 1), (5, 1, 1, -1)]

/-- ii: the four sporadic chords `inner(0) ↔ inner(m)`. -/
def metaIITable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(0, -1, 5, 0), (0, 1, 5, 0), (1, -1, 1, 0), (1, 1, 1, 0)]

/-- The web shift: pivot `j`'s web is the master web re-addressed by `2j` on both
sides (the census-verified isomorphy under the 120° rotation about the metapivot). -/
def webShift (j : Fin 3) : ZMod 6 := ((2 * j.val : ℕ) : ZMod 6)

/-! ### §W.1 The bridges: every meta-axis chord is a `ℤ[ζ₆,π]` norm equation

`g := 1 + ζ₆ = √3·ζ₁₂` is the whole engine: multiplying a meta-axis difference by `√3`
(oo, oi) or by `3` (io, ii) turns it into `ζ₁₂` times an expression in which the twelfth
root has disappeared.  Since `‖ζ₁₂‖ = 1` the norm equation transfers exactly. -/

/-- `g = 1 + ζ₆`, the hex element of norm 3 that replaces `√3·ζ₁₂`. -/
noncomputable def gC : ℂ := 1 + zeta6

/-- Its conjugate `ḡ = 2 − ζ₆ = ζ₆⁻¹g`. -/
noncomputable def gB : ℂ := 2 - zeta6

theorem gC_conj : (starRingEnd ℂ) gC = gB := by
  rw [gC, gB, map_add, map_one, ← Triangle.one_sub_zeta6]
  ring

theorem gC_mul_gB : gC * gB = 3 := by
  rw [gC, gB]
  linear_combination -zeta6_minpoly

theorem sqrt3_mul_zeta12' : gC = ((Real.sqrt 3 : ℝ) : ℂ) * zeta12 := sqrt3_mul_zeta12.symm

private theorem word_succ (a : ZMod 6) (b : ℤ) : word a b = zeta6 * word (a - 1) b := by
  have h := word_add (a - 1) 1 b 0
  rw [add_zero, word_k0, show (((1 : ZMod 6)).val : ℤ) = ((1 : ℕ) : ℤ) from rfl,
    zpow_natCast, pow_one, sub_add_cancel] at h
  rw [h]
  ring

private theorem inner_cast : ((Real.sqrt 3 / 3 : ℝ) : ℂ) = ((Real.sqrt 3 : ℝ) : ℂ) / 3 := by
  push_cast; ring

private theorem sqrt3_ne : ((Real.sqrt 3 : ℝ) : ℂ) ≠ 0 := by
  simp only [ne_eq, Complex.ofReal_eq_zero]
  positivity

/-- The scaling step behind all four bridges: a nonzero real multiple of the difference
equals `ζ₁₂` times the cleared expression, and `‖ζ₁₂‖ = 1` transfers the norm equation
exactly. -/
private theorem bridge_gen {P Q k Z : ℂ} {R : ℝ} (hk : k ≠ 0) (hR : normSq k = R)
    (h : k * (P - Q) = zeta12 * Z) : dist P Q = 1 ↔ normSq Z = R := by
  have hn := congrArg normSq h
  rw [map_mul, map_mul, normSq_zeta12, one_mul] at hn
  have hk0 : normSq k ≠ 0 := fun h0 => hk (by simpa [Complex.normSq_eq_zero] using h0)
  subst hR
  rw [dist_eq_norm, norm_eq_one_iff]
  constructor
  · intro hP
    rw [← hn, hP, mul_one]
  · intro hZ
    exact mul_left_cancel₀ hk0 (hn.trans (hZ.trans (mul_one _).symm))

private theorem normSq_sqrt3 : normSq ((Real.sqrt 3 : ℝ) : ℂ) = 3 := by
  simp only [normSq_apply, Complex.ofReal_re, Complex.ofReal_im]
  nlinarith [sq_sqrt3]

private theorem normSq_three : normSq (3 : ℂ) = 9 := by
  simp only [normSq_apply]
  norm_num

/-- `√3·ζ₁₂ = 1 + ζ₁₂²`: the engine identity with the hex root eliminated, the form the
scaling certificates cite. -/
private theorem sqrt3_zeta12_id : ((Real.sqrt 3 : ℝ) : ℂ) * zeta12 = 1 + zeta12 ^ 2 := by
  rw [zeta12_sq]; exact sqrt3_mul_zeta12

private theorem scale_oo (u v : ℂ) :
    ((Real.sqrt 3 : ℝ) : ℂ) * (zeta6 * u - (metaPivot + v * zeta12))
      = zeta12 * (gC * u - 1 - ((Real.sqrt 3 : ℝ) : ℂ) * v) := by
  simp only [gC, meta_eq, inner_cast, ← zeta12_sq]
  linear_combination (u * zeta12) * sqrt3_zeta12_id - (zeta12 / 3) * sqrt3_cast_sq

private theorem scale_oi (u v : ℂ) :
    ((Real.sqrt 3 : ℝ) : ℂ)
        * (zeta6 * u - (metaPivot + ((Real.sqrt 3 / 3 : ℝ) : ℂ) * v * zeta12))
      = zeta12 * (gC * u - 1 - v) := by
  simp only [gC, meta_eq, inner_cast, ← zeta12_sq]
  linear_combination (u * zeta12) * sqrt3_zeta12_id
    - (zeta12 * (1 + v) / 3) * sqrt3_cast_sq

private theorem scale_io (u v : ℂ) :
    (3 : ℂ) * (((Real.sqrt 3 / 3 : ℝ) : ℂ) * (zeta6 * u) - (metaPivot + v * zeta12))
      = zeta12 * (gC * u - ((Real.sqrt 3 : ℝ) : ℂ) - 3 * v) := by
  simp only [gC, meta_eq, inner_cast, ← zeta12_sq]
  linear_combination (u * zeta12) * sqrt3_zeta12_id

private theorem scale_ii (u v : ℂ) :
    (3 : ℂ) * (((Real.sqrt 3 / 3 : ℝ) : ℂ) * (zeta6 * u)
        - (metaPivot + ((Real.sqrt 3 / 3 : ℝ) : ℂ) * v * zeta12))
      = zeta12 * (gC * u - ((Real.sqrt 3 : ℝ) : ℂ) - ((Real.sqrt 3 : ℝ) : ℂ) * v) := by
  simp only [gC, meta_eq, inner_cast, ← zeta12_sq]
  linear_combination (u * zeta12) * sqrt3_zeta12_id

theorem bridge_oo (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (outerPt 0 1 a b) (outerPt metaPivot metaAnchor c d) = 1 ↔
      normSq (gC * word (a - 1) b - 1 - ((Real.sqrt 3 : ℝ) : ℂ) * word c d) = 3 := by
  refine bridge_gen sqrt3_ne normSq_sqrt3 ?_
  rw [outerPt, outerPt, metaAnchor_sub, word_succ a b]
  linear_combination scale_oo (word (a - 1) b) (word c d)

theorem bridge_oi (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (outerPt 0 1 a b) (innerPt metaPivot metaAnchor c d) = 1 ↔
      normSq (gC * word (a - 1) b - 1 - word c d) = 3 := by
  refine bridge_gen sqrt3_ne normSq_sqrt3 ?_
  rw [outerPt, innerPt, metaAnchor_sub, word_succ a b]
  linear_combination scale_oi (word (a - 1) b) (word c d)

theorem bridge_io (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (innerPt 0 1 a b) (outerPt metaPivot metaAnchor c d) = 1 ↔
      normSq (gC * word (a - 1) b - ((Real.sqrt 3 : ℝ) : ℂ) - 3 * word c d) = 9 := by
  refine bridge_gen (by norm_num : (3 : ℂ) ≠ 0) normSq_three ?_
  rw [innerPt, outerPt, metaAnchor_sub, word_succ a b]
  linear_combination scale_io (word (a - 1) b) (word c d)

theorem bridge_ii (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (innerPt 0 1 a b) (innerPt metaPivot metaAnchor c d) = 1 ↔
      normSq (gC * word (a - 1) b - ((Real.sqrt 3 : ℝ) : ℂ)
        - ((Real.sqrt 3 : ℝ) : ℂ) * word c d) = 9 := by
  refine bridge_gen (by norm_num : (3 : ℂ) ≠ 0) normSq_three ?_
  rw [innerPt, innerPt, metaAnchor_sub, word_succ a b]
  linear_combination scale_ii (word (a - 1) b) (word c d)

/-! ### §W.2 The `ℤ[ζ₆,π]` engine, generalized once

M24 clears a conjugate word pair `ζ₆^x σ^h + ζ₆^{−x}σ^{−h}` by `√3^h` into its trace
pair.  M25 needs the same with an arbitrary `ℤ[ζ₆]` coefficient in front — `g·ζ₆^A` on
the two `g`-traces — so the object is `hexTrace t₁ t₂ h = θ·π^h + θ̄·π̄^h` for
`θ = t₁ + t₂ζ₆`, and its four coordinates are linear in `(t₁, t₂)` and the `piCoeff`
row.  M24's trace pair is the `θ = ζ₆^x` instance. -/

private theorem conj_zeta6 : (starRingEnd ℂ) zeta6 = 1 - zeta6 := Triangle.one_sub_zeta6.symm

private theorem conj_piC : (starRingEnd ℂ) piC = 1 - piC := by
  apply Complex.ext
  · simp [piC]
    norm_num
  · simp [piC]

/-- The `ℤ[ζ₆]`-coordinates of `g·ζ₆^A = ζ₆^A + ζ₆^{A+1}`. -/
def gE (A : ZMod 6) : ℤ := hexE A.val + hexE (A + 1).val

/-- The `ζ₆`-coordinate of `g·ζ₆^A`. -/
def gF (A : ZMod 6) : ℤ := hexF A.val + hexF (A + 1).val

private theorem zeta6_succ (A : ZMod 6) :
    zeta6 ^ ((A + 1).val : ℤ) = zeta6 * zeta6 ^ (A.val : ℤ) := by
  have h := word_succ (A + 1) 0
  rw [word_k0, add_sub_cancel_right, word_k0] at h
  exact h

private theorem gC_zeta6_pow (A : ZMod 6) :
    gC * zeta6 ^ (A.val : ℤ) = ((gE A : ℤ) : ℂ) + ((gF A : ℤ) : ℂ) * zeta6 := by
  rw [gC, gE, gF]
  push_cast
  linear_combination zeta6_zpow_hex A + zeta6_zpow_hex (A + 1) - zeta6_succ A

/-- `θ·π^h + θ̄·π̄^h` for `θ = t₁ + t₂·ζ₆` — the M25 trace object. -/
noncomputable def hexTrace (t₁ t₂ : ℤ) (h : ℕ) : ℂ :=
  ((t₁ : ℂ) + (t₂ : ℂ) * zeta6) * piC ^ h
    + ((t₁ : ℂ) + (t₂ : ℂ) * (1 - zeta6)) * (1 - piC) ^ h

private theorem one_sub_piC_pow_coeff (n : ℕ) :
    (1 - piC) ^ n = ((piCoeff n).1 : ℂ) + ((piCoeff n).2 : ℂ) - ((piCoeff n).2 : ℂ) * piC := by
  induction n with
  | zero => simp [piCoeff]
  | succ k ih =>
    rw [pow_succ, ih, piCoeff]
    push_cast
    linear_combination ((piCoeff k).2 : ℂ) * piC_sq

/-- **The coordinate row of the trace object**, in `{1, ζ₆, π, ζ₆π}`: the whole M25 case
analysis is read off these four integers. -/
theorem hexTrace_coords (t₁ t₂ : ℤ) (h : ℕ) :
    hexTrace t₁ t₂ h
      = ((t₁ * (piCoeff h).1 + (t₁ + t₂) * ((piCoeff h).1 + (piCoeff h).2) : ℤ) : ℂ)
        + ((-(t₂ * (piCoeff h).2) : ℤ) : ℂ) * zeta6
        + ((-(t₂ * (piCoeff h).2) : ℤ) : ℂ) * piC
        + ((2 * (t₂ * (piCoeff h).2) : ℤ) : ℂ) * (zeta6 * piC) := by
  rw [hexTrace, piC_pow_coeff, one_sub_piC_pow_coeff]
  push_cast
  ring

theorem inRing_hexTrace (t₁ t₂ : ℤ) (h : ℕ) : InRing (hexTrace t₁ t₂ h) :=
  ⟨_, _, _, _, hexTrace_coords t₁ t₂ h⟩

/-! ### §W.3 The clearing lemmas -/

private theorem conj_zeta6_pow (c : ZMod 6) :
    (starRingEnd ℂ) (zeta6 ^ (c.val : ℤ)) = zeta6 ^ ((-c).val : ℤ) := by
  have h := word_conj c 0
  rw [word_k0, neg_zero, word_k0] at h
  exact h

private theorem sqrt3_pow_mul_word_neg (c : ZMod 6) (e : ℕ) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ e * word (-c) (-(e : ℤ))
      = zeta6 ^ ((-c).val : ℤ) * (1 - piC) ^ e := by
  have h := congrArg (starRingEnd ℂ) (sqrt3_pow_mul_word c e)
  rw [map_mul, map_pow, Complex.conj_ofReal, word_conj, map_mul, map_pow, conj_piC,
    conj_zeta6_pow] at h
  exact h

/-- The `g`-trace at a non-negative height clears to `hexTrace` at the address `A`. -/
theorem gTrace_clear_nonneg (A : ZMod 6) (h : ℕ) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ h * (gC * word A (h : ℤ) + gB * word (-A) (-(h : ℤ)))
      = hexTrace (gE A) (gF A) h := by
  have h1 := sqrt3_pow_mul_word A h
  have h2 := sqrt3_pow_mul_word_neg A h
  have hg := gC_zeta6_pow A
  have hgb : gB * zeta6 ^ ((-A).val : ℤ) = ((gE A : ℤ) : ℂ) + ((gF A : ℤ) : ℂ) * (1 - zeta6) := by
    have h := congrArg (starRingEnd ℂ) hg
    rw [map_mul, gC_conj, conj_zeta6_pow, map_add, map_mul, map_intCast, map_intCast,
      conj_zeta6] at h
    exact h
  rw [hexTrace, mul_add, ← mul_assoc, ← mul_assoc]
  rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ h * gC * word A (h : ℤ)
      = gC * (((Real.sqrt 3 : ℝ) : ℂ) ^ h * word A (h : ℤ)) by ring, h1,
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ h * gB * word (-A) (-(h : ℤ))
      = gB * (((Real.sqrt 3 : ℝ) : ℂ) ^ h * word (-A) (-(h : ℤ))) by ring, h2,
    ← mul_assoc, ← mul_assoc, hg, hgb]

private theorem gC_eq_zeta6_gB : gC = zeta6 * gB := by
  rw [gC, gB]
  linear_combination zeta6_minpoly

/-- Shifting the hex address by one trades `g` for `ḡ`: `g·ζ₆^{A−1} = ḡ·ζ₆^A`. -/
private theorem g_shift (A : ZMod 6) (b : ℤ) : gC * word (A - 1) b = gB * word A b := by
  rw [gC_eq_zeta6_gB, word_succ A b]
  ring

/-- The `g`-trace at a negative height clears at the reflected address `−A−1`. -/
theorem gTrace_clear_neg (A : ZMod 6) (h : ℕ) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ h * (gC * word A (-(h : ℤ)) + gB * word (-A) (h : ℤ))
      = hexTrace (gE (-A - 1)) (gF (-A - 1)) h := by
  have e1 : gC * word (-A - 1) (h : ℤ) = gB * word (-A) (h : ℤ) := g_shift (-A) (h : ℤ)
  have e2 : gC * word A (-(h : ℤ)) = gB * word (A + 1) (-(h : ℤ)) := by
    have h2 := g_shift (A + 1) (-(h : ℤ))
    rwa [add_sub_cancel_right] at h2
  rw [← gTrace_clear_nonneg (-A - 1) h, show (-(-A - 1) : ZMod 6) = A + 1 by ring, e1, e2]
  ring

/-- The unit trace at a non-negative height. -/
theorem uTrace_clear_nonneg (c : ZMod 6) (h : ℕ) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ h * (word c (h : ℤ) + word (-c) (-(h : ℤ)))
      = hexTrace (hexE c.val) (hexF c.val) h := by
  have h1 := sqrt3_pow_mul_word c h
  have h2 := sqrt3_pow_mul_word_neg c h
  have hg := zeta6_zpow_hex c
  have hgb : zeta6 ^ ((-c).val : ℤ)
      = ((hexE c.val : ℤ) : ℂ) + ((hexF c.val : ℤ) : ℂ) * (1 - zeta6) := by
    have h := congrArg (starRingEnd ℂ) hg
    rw [conj_zeta6_pow, map_add, map_mul, map_intCast, map_intCast, conj_zeta6] at h
    exact h
  rw [hexTrace, mul_add, h1, h2, hg, hgb]

/-- The unit trace at a negative height, at the reflected address. -/
theorem uTrace_clear_neg (c : ZMod 6) (h : ℕ) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ h * (word c (-(h : ℤ)) + word (-c) (h : ℤ))
      = hexTrace (hexE (-c).val) (hexF (-c).val) h := by
  have := uTrace_clear_nonneg (-c) h
  rw [neg_neg] at this
  rw [← this]
  ring

/-! ### §W.4 The two finite facts that do the killing -/

/-- A trace object at positive height vanishes only when its coefficient does — the
`piCoeff` rows (`3 ∣ P`, `Q ≡ 1 mod 3`) forbid everything else. -/
theorem hexTrace_eq_zero {t₁ t₂ : ℤ} {h : ℕ} (hh : 1 ≤ h) (h0 : hexTrace t₁ t₂ h = 0) :
    t₁ = 0 ∧ t₂ = 0 := by
  obtain ⟨h', rfl⟩ : ∃ h', h = h' + 1 := ⟨h - 1, by omega⟩
  obtain ⟨k₁, k₂, -, -⟩ := inRing_coords_zero
    (n₁ := t₁ * (piCoeff (h' + 1)).1 + (t₁ + t₂) * ((piCoeff (h' + 1)).1 + (piCoeff (h' + 1)).2))
    (n₂ := -(t₂ * (piCoeff (h' + 1)).2))
    (n₃ := -(t₂ * (piCoeff (h' + 1)).2))
    (n₄ := 2 * (t₂ * (piCoeff (h' + 1)).2))
    ((hexTrace_coords t₁ t₂ (h' + 1)).symm.trans h0)
  have hQ : (piCoeff (h' + 1)).2 % 3 = 1 := piCoeff_snd_emod h'
  obtain ⟨p, hp⟩ := three_dvd_piCoeff_fst h'
  have hQ0 : (piCoeff (h' + 1)).2 ≠ 0 := by omega
  have ht2 : t₂ = 0 := by
    have hz : t₂ * (piCoeff (h' + 1)).2 = 0 := by omega
    rcases mul_eq_zero.mp hz with h | h
    · exact h
    · exact absurd h hQ0
  refine ⟨?_, ht2⟩
  have hval : t₁ * (2 * (piCoeff (h' + 1)).1 + (piCoeff (h' + 1)).2) = 0 := by
    rw [ht2] at k₁
    linear_combination k₁
  rcases mul_eq_zero.mp hval with h | h
  · exact h
  · omega

/-- The `g`-coefficients are never both zero, and never both `≡ 0 mod 3`: the
`g`-traces cannot vanish or be divisible by three at positive height. -/
theorem gE_gF_ne : ∀ A : ZMod 6, ¬ ((3 : ℤ) ∣ gE A ∧ (3 : ℤ) ∣ gF A) := by decide

/-- The unit coefficients are never both `≡ 0 mod 3` (M24's `hexE_hexF_not_both_dvd`),
and their difference is never `≡ 0 mod 3` — the second is the `𝔭`-adic functional
`φ(z) = n₁ − n₂` that separates a unit trace from a `g`-trace. -/
theorem hex_diff_ne : ∀ c : ZMod 6, ¬ ((3 : ℤ) ∣ (hexE c.val - hexF c.val)) := by decide

/-- …while every `g`-trace has `φ ≡ 0`: `φ(g) = 1 + (−1) = 0`. -/
theorem gE_sub_gF_dvd : ∀ A : ZMod 6, (3 : ℤ) ∣ (gE A - gF A) := by decide

/-! ### §W.5 The master trace equation

Expanding `normSq (g·u − y − z·v) = R` on units gives a constant plus three conjugate
pairs: the `g`-trace of `u`, the `g`-trace of `u·v̄`, and the plain trace of `v`.  One
lemma covers all four families; the family only fixes `(y, z, R)`. -/

/-- The `g`-trace of a lattice word: `g·w + ḡ·w̄`. -/
noncomputable def gTr (A : ZMod 6) (b : ℤ) : ℂ := gC * word A b + gB * word (-A) (-b)

/-- The plain trace of a lattice word. -/
noncomputable def uTr (c : ZMod 6) (d : ℤ) : ℂ := word c d + word (-c) (-d)

private theorem word_mul_inv (a : ZMod 6) (b : ℤ) : word a b * word (-a) (-b) = 1 := by
  rw [← word_add, add_neg_cancel, add_neg_cancel, word]
  simp

private theorem word_mul_neg (a c : ZMod 6) (b d : ℤ) :
    word a b * word (-c) (-d) = word (a - c) (b - d) := by
  rw [← word_add, sub_eq_add_neg, sub_eq_add_neg]

/-- **The master identity**: the norm equation of the meta axis, expanded. -/
theorem web_master {A c : ZMod 6} {b d : ℤ} {y z R : ℝ}
    (h : normSq (gC * word A b - (y : ℂ) - (z : ℂ) * word c d) = R) :
    ((3 + y ^ 2 + z ^ 2 - R : ℝ) : ℂ) - (y : ℂ) * gTr A b - (z : ℂ) * gTr (A - c) (b - d)
      + ((y : ℂ) * (z : ℂ)) * uTr c d = 0 := by
  have hu := word_mul_inv A b
  have hv := word_mul_inv c d
  have hX1 := word_mul_neg A c b d
  have hX2 := word_mul_neg c A d b
  have hX := Complex.mul_conj (gC * word A b - (y : ℂ) - (z : ℂ) * word c d)
  rw [h, map_sub, map_sub, map_mul, map_mul, gC_conj, Complex.conj_ofReal,
    Complex.conj_ofReal, word_conj, word_conj] at hX
  rw [gTr, gTr, uTr, show (-(A - c) : ZMod 6) = c - A by ring, show -(b - d) = d - b by ring]
  push_cast
  linear_combination hX - (word A b * word (-A) (-b)) * gC_mul_gB - 3 * hu
    - (z : ℂ) ^ 2 * hv + (z : ℂ) * gC * hX1 + (z : ℂ) * gB * hX2

/-! ### §W.6 Clearing at an arbitrary integer height -/

/-- The cleared address of a `g`-trace: reflected when the seam height is negative. -/
def gAddr (A : ZMod 6) (b : ℤ) : ZMod 6 := if 0 ≤ b then A else -A - 1

/-- The cleared address of a plain trace. -/
def uAddr (c : ZMod 6) (d : ℤ) : ZMod 6 := if 0 ≤ d then c else -c

theorem gTrace_clear (A : ZMod 6) (b : ℤ) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ b.natAbs * gTr A b
      = hexTrace (gE (gAddr A b)) (gF (gAddr A b)) b.natAbs := by
  rcases le_or_gt 0 b with hb | hb
  · obtain ⟨n, rfl⟩ : ∃ n : ℕ, b = (n : ℤ) := ⟨b.natAbs, by omega⟩
    rw [gAddr, if_pos hb, gTr, show ((n : ℤ)).natAbs = n by simp]
    exact gTrace_clear_nonneg A n
  · obtain ⟨n, rfl⟩ : ∃ n : ℕ, b = -(n : ℤ) := ⟨b.natAbs, by omega⟩
    rw [gAddr, if_neg (by omega), gTr, neg_neg, show (-(n : ℤ)).natAbs = n by simp]
    exact gTrace_clear_neg A n

theorem uTrace_clear (c : ZMod 6) (d : ℤ) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ d.natAbs * uTr c d
      = hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) d.natAbs := by
  rcases le_or_gt 0 d with hd | hd
  · obtain ⟨n, rfl⟩ : ∃ n : ℕ, d = (n : ℤ) := ⟨d.natAbs, by omega⟩
    rw [uAddr, if_pos hd, uTr, show ((n : ℤ)).natAbs = n by simp]
    exact uTrace_clear_nonneg c n
  · obtain ⟨n, rfl⟩ : ∃ n : ℕ, d = -(n : ℤ) := ⟨d.natAbs, by omega⟩
    rw [uAddr, if_neg (by omega), uTr, neg_neg, show (-(n : ℤ)).natAbs = n by simp]
    exact uTrace_clear_neg c n

/-! ### §W.7 The two coordinate rows

Only two of the four coordinates are independent: `n₃ = n₂` and `n₄ = −2n₂`.  Every kill
below reads these two rows, mostly modulo three. -/

/-- The two independent integer rows of a three-term trace identity. -/
theorem hexTrace_rows {t₁ t₂ u₁ u₂ v₁ v₂ : ℤ} {p q r i j l : ℕ}
    (heq : (3 : ℂ) ^ i * hexTrace t₁ t₂ p + (3 : ℂ) ^ j * hexTrace u₁ u₂ q
      = (3 : ℂ) ^ l * hexTrace v₁ v₂ r) :
    (3 ^ i * (t₁ * (piCoeff p).1 + (t₁ + t₂) * ((piCoeff p).1 + (piCoeff p).2))
        + 3 ^ j * (u₁ * (piCoeff q).1 + (u₁ + u₂) * ((piCoeff q).1 + (piCoeff q).2))
        - 3 ^ l * (v₁ * (piCoeff r).1 + (v₁ + v₂) * ((piCoeff r).1 + (piCoeff r).2)) = 0)
      ∧ (3 ^ i * (t₂ * (piCoeff p).2) + 3 ^ j * (u₂ * (piCoeff q).2)
        - 3 ^ l * (v₂ * (piCoeff r).2) = 0) := by
  obtain ⟨k₁, k₂, -, -⟩ := inRing_coords_zero
    (n₁ := 3 ^ i * (t₁ * (piCoeff p).1 + (t₁ + t₂) * ((piCoeff p).1 + (piCoeff p).2))
        + 3 ^ j * (u₁ * (piCoeff q).1 + (u₁ + u₂) * ((piCoeff q).1 + (piCoeff q).2))
        - 3 ^ l * (v₁ * (piCoeff r).1 + (v₁ + v₂) * ((piCoeff r).1 + (piCoeff r).2)))
    (n₂ := -(3 ^ i * (t₂ * (piCoeff p).2) + 3 ^ j * (u₂ * (piCoeff q).2)
        - 3 ^ l * (v₂ * (piCoeff r).2)))
    (n₃ := -(3 ^ i * (t₂ * (piCoeff p).2) + 3 ^ j * (u₂ * (piCoeff q).2)
        - 3 ^ l * (v₂ * (piCoeff r).2)))
    (n₄ := 2 * (3 ^ i * (t₂ * (piCoeff p).2) + 3 ^ j * (u₂ * (piCoeff q).2)
        - 3 ^ l * (v₂ * (piCoeff r).2)))
    (by linear_combination (norm := (push_cast; ring)) heq
          - (3 : ℂ) ^ i * hexTrace_coords t₁ t₂ p
          - (3 : ℂ) ^ j * hexTrace_coords u₁ u₂ q + (3 : ℂ) ^ l * hexTrace_coords v₁ v₂ r)
  exact ⟨k₁, by omega⟩

/-! ### §W.8 The kill toolkit -/

private theorem sqrt3_pow_two_mul (k : ℕ) : ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * k) = 3 ^ k := by
  rw [pow_mul, show ((Real.sqrt 3 : ℝ) : ℂ) ^ 2 = 3 from by rw [pow_two]; exact sqrt3_cast_sq]

private theorem inRing_three_pow (k : ℕ) : InRing ((3 : ℂ) ^ k) := by
  rw [show ((3 : ℂ) ^ k) = (((3 ^ k : ℤ)) : ℂ) by push_cast; ring]
  exact InRing.intCast _

private theorem inRing_pow_trace (e : ℕ) (t₁ t₂ : ℤ) (h : ℕ) :
    InRing ((3 : ℂ) ^ e * hexTrace t₁ t₂ h) :=
  (inRing_three_pow e).mul (inRing_hexTrace t₁ t₂ h)

theorem hexTrace_add (t₁ t₂ u₁ u₂ : ℤ) (h : ℕ) :
    hexTrace t₁ t₂ h + hexTrace u₁ u₂ h = hexTrace (t₁ + u₁) (t₂ + u₂) h := by
  rw [hexTrace, hexTrace, hexTrace]
  push_cast
  ring

theorem hexTrace_zero_height (t₁ t₂ : ℤ) : hexTrace t₁ t₂ 0 = ((2 * t₁ + t₂ : ℤ) : ℂ) := by
  rw [hexTrace]
  push_cast
  ring

/-- **The pin**: a trace object equal to a rational integer has no `ζ₆`-part, and its
value is `t₁·(2P+Q)` — a number never divisible by three unless `t₁` is. -/
theorem hexTrace_pin {t₁ t₂ r : ℤ} {h : ℕ} (hh : 1 ≤ h) (heq : hexTrace t₁ t₂ h = (r : ℂ)) :
    t₂ = 0 ∧ t₁ * (2 * (piCoeff h).1 + (piCoeff h).2) = r := by
  obtain ⟨h', rfl⟩ : ∃ h', h = h' + 1 := ⟨h - 1, by omega⟩
  obtain ⟨k₁, k₂, -, -⟩ := inRing_coords_zero
    (n₁ := t₁ * (piCoeff (h' + 1)).1
        + (t₁ + t₂) * ((piCoeff (h' + 1)).1 + (piCoeff (h' + 1)).2) - r)
    (n₂ := -(t₂ * (piCoeff (h' + 1)).2))
    (n₃ := -(t₂ * (piCoeff (h' + 1)).2))
    (n₄ := 2 * (t₂ * (piCoeff (h' + 1)).2))
    (by linear_combination (norm := (push_cast; ring)) heq - hexTrace_coords t₁ t₂ (h' + 1))
  have hQ : (piCoeff (h' + 1)).2 % 3 = 1 := piCoeff_snd_emod h'
  have hQ0 : (piCoeff (h' + 1)).2 ≠ 0 := by omega
  have ht2 : t₂ = 0 := by
    have hz : t₂ * (piCoeff (h' + 1)).2 = 0 := by omega
    rcases mul_eq_zero.mp hz with h | h
    · exact h
    · exact absurd h hQ0
  refine ⟨ht2, ?_⟩
  rw [ht2] at k₁
  linear_combination k₁

/-- `2P+Q` is never divisible by three — the fact every value kill turns on. -/
theorem not_three_dvd_pin (h : ℕ) (hh : 1 ≤ h) :
    ¬ ((3 : ℤ) ∣ (2 * (piCoeff h).1 + (piCoeff h).2)) := by
  obtain ⟨h', rfl⟩ : ∃ h', h = h' + 1 := ⟨h - 1, by omega⟩
  obtain ⟨p, hp⟩ := three_dvd_piCoeff_fst h'
  have hQ : (piCoeff (h' + 1)).2 % 3 = 1 := piCoeff_snd_emod h'
  rintro ⟨v, hv⟩
  omega

/-- The unit coefficients never both vanish. -/
theorem hexE_hexF_ne (c : ZMod 6) : ¬ (hexE c.val = 0 ∧ hexF c.val = 0) := by
  intro h
  exact hexE_hexF_not_both_dvd c.val (ZMod.val_lt c) ⟨h.1 ▸ dvd_zero 3, h.2 ▸ dvd_zero 3⟩

/-- …nor does the height-zero value `2·hexE + hexF`. -/
theorem hex_zero_height_ne : ∀ c : ZMod 6, 2 * hexE c.val + hexF c.val ≠ 0 := by decide

/-- The `g`-coefficients never both vanish. -/
theorem gE_gF_zero_ne (A : ZMod 6) : ¬ (gE A = 0 ∧ gF A = 0) := fun h =>
  gE_gF_ne A ⟨h.1 ▸ dvd_zero 3, h.2 ▸ dvd_zero 3⟩

/-! ### §W.9 The ii family: `inner(pivot) ↔ inner(meta)` -/

/-- The ii master equation: `Tr(g·w₁) + Tr(g·W) = √3·Tr(V)`. -/
theorem ii_web {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 0 1 a b) (innerPt metaPivot metaAnchor c d) = 1) :
    gTr (a - 1) b + gTr (a - 1 - c) (b - d) = ((Real.sqrt 3 : ℝ) : ℂ) * uTr c d := by
  have hm := web_master ((bridge_ii a b c d).mp h)
  have hc : ((3 + Real.sqrt 3 ^ 2 + Real.sqrt 3 ^ 2 - 9 : ℝ) : ℂ) = 0 := by
    norm_cast
    nlinarith [sq_sqrt3]
  rw [hc] at hm
  refine mul_left_cancel₀ sqrt3_ne ?_
  linear_combination -hm

/-- The cleared form of the ii equation: three trace objects with `√3`-powers whose
parities decide the case. -/
theorem ii_cleared {A c : ZMod 6} {b d : ℤ} {t : ℕ}
    (ht : b.natAbs + d.natAbs = (b - d).natAbs + 2 * t)
    (h : gTr A b + gTr (A - c) (b - d) = ((Real.sqrt 3 : ℝ) : ℂ) * uTr c d) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ d.natAbs * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) b.natAbs
        + (3 : ℂ) ^ t
          * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d))) (b - d).natAbs
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + 1)
        * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) d.natAbs := by
  have hA := gTrace_clear A b
  have hB := gTrace_clear (A - c) (b - d)
  have hC := uTrace_clear c d
  have hsum : ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs)
      * (gTr A b + gTr (A - c) (b - d))
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs)
        * (((Real.sqrt 3 : ℝ) : ℂ) * uTr c d) := by rw [h]
  have hpow2 : ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * t) * ((Real.sqrt 3 : ℝ) : ℂ) ^ (b - d).natAbs
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs) := by
    rw [← pow_add, show 2 * t + (b - d).natAbs = b.natAbs + d.natAbs by omega]
  rw [← hA, ← hB, ← hC, ← sqrt3_pow_two_mul t]
  linear_combination hsum + gTr (A - c) (b - d) * hpow2

/-! ### §W.10 The two generic kills

Every branch of every family ends in one of two ways.  **Alone**: one trace object sits
strictly below the others 3-adically, so its coefficient pair is divisible by three —
which neither table allows.  **`φ`**: the unit trace sits at the minimum together with
`g`-traces, and the functional `φ(z) = n₁ − n₂ mod 3` (reduction at the prime over 3)
vanishes on every `g`-trace but never on a unit trace. -/

/-- **The alone kill**, in coordinates: `3 ∣ P` and `Q ≡ 1 (mod 3)` turn the two rows
into `t₂ ≡ 0` and `t₁ + t₂ ≡ 0`. -/
theorem alone_dvd {t₁ t₂ : ℤ} {p : ℕ} (hp : 1 ≤ p) {R₁ R₂ : ℤ}
    (h₁ : t₁ * (piCoeff p).1 + (t₁ + t₂) * ((piCoeff p).1 + (piCoeff p).2) = 3 * R₁)
    (h₂ : t₂ * (piCoeff p).2 = 3 * R₂) :
    (3 : ℤ) ∣ t₁ ∧ (3 : ℤ) ∣ t₂ := by
  obtain ⟨p', rfl⟩ : ∃ p', p = p' + 1 := ⟨p - 1, by omega⟩
  obtain ⟨P, hP⟩ := three_dvd_piCoeff_fst p'
  obtain ⟨Q, hQ⟩ : ∃ Q, (piCoeff (p' + 1)).2 = 3 * Q + 1 :=
    ⟨(piCoeff (p' + 1)).2 / 3, by have := piCoeff_snd_emod p'; omega⟩
  rw [hP, hQ] at h₁
  rw [hQ] at h₂
  refine ⟨⟨(R₁ - t₁ * P - (t₁ + t₂) * P - (t₁ + t₂) * Q) - (R₂ - t₂ * Q), by linarith⟩,
    ⟨R₂ - t₂ * Q, by linarith⟩⟩

/-- **The `φ` kill**, in coordinates: a unit trace at the minimum forces `3 ∣ v₁ − v₂`. -/
theorem phi_dvd {v₁ v₂ : ℤ} {r : ℕ} (hr : 1 ≤ r) {S : ℤ}
    (h : (v₁ * (piCoeff r).1 + (v₁ + v₂) * ((piCoeff r).1 + (piCoeff r).2))
        + v₂ * (piCoeff r).2 = 3 * S) :
    (3 : ℤ) ∣ (v₁ - v₂) := by
  obtain ⟨r', rfl⟩ : ∃ r', r = r' + 1 := ⟨r - 1, by omega⟩
  obtain ⟨P, hP⟩ := three_dvd_piCoeff_fst r'
  obtain ⟨Q, hQ⟩ : ∃ Q, (piCoeff (r' + 1)).2 = 3 * Q + 1 :=
    ⟨(piCoeff (r' + 1)).2 / 3, by have := piCoeff_snd_emod r'; omega⟩
  rw [hP, hQ] at h
  exact ⟨S - v₁ * P - (v₁ + v₂) * P - (v₁ + v₂) * Q - v₂ * Q - v₂, by linarith⟩

/-- `φ` vanishes on every `g`-trace: `φ(g) = 1 + (−1) = 0`. -/
theorem phi_g_dvd (A : ZMod 6) (p : ℕ) :
    (3 : ℤ) ∣ ((gE A * (piCoeff p).1 + (gE A + gF A) * ((piCoeff p).1 + (piCoeff p).2))
      + gF A * (piCoeff p).2) := by
  obtain ⟨w, hw⟩ := gE_sub_gF_dvd A
  refine ⟨2 * w * (piCoeff p).1 + w * (piCoeff p).2 + gF A * (piCoeff p).1
    + gF A * (piCoeff p).2, ?_⟩
  have hgE : gE A = 3 * w + gF A := by omega
  rw [hgE]
  ring

/-! ### §W.11 The ii family: the classification -/

private theorem ii_endgame_pos : ∀ A c : ZMod 6,
    gF A + gF (A - c) = 0 → gE A + gE (A - c) = 3 * (2 * hexE c.val + hexF c.val) →
    (A = 0 ∧ c = 1) ∨ (A = 5 ∧ c = 5) := by decide

private theorem ii_endgame_neg : ∀ A c : ZMod 6,
    gF (-A - 1) + gF (-(A - c) - 1) = 0 →
    gE (-A - 1) + gE (-(A - c) - 1) = 3 * (2 * hexE c.val + hexF c.val) →
    (A = 0 ∧ c = 1) ∨ (A = 5 ∧ c = 5) := by decide

private theorem gE_abs_le : ∀ A B : ZMod 6, gE A + gE B ≤ 4 ∧ -4 ≤ gE A + gE B := by decide

/-- **ii completeness at the master web**: the cleared equation admits exactly the four
census chords. -/
theorem ii_classify {A c : ZMod 6} {b d : ℤ}
    (h : gTr A b + gTr (A - c) (b - d) = ((Real.sqrt 3 : ℝ) : ℂ) * uTr c d) :
    ((A = 0 ∧ c = 1) ∨ (A = 5 ∧ c = 5)) ∧ (b = 1 ∨ b = -1) ∧ d = 0 := by
  obtain ⟨t, ht⟩ : ∃ t, b.natAbs + d.natAbs = (b - d).natAbs + 2 * t :=
    ⟨(b.natAbs + d.natAbs - (b - d).natAbs) / 2, by omega⟩
  have hcl := ii_cleared ht h
  obtain ⟨ν, hν⟩ : ∃ ν, d.natAbs = 2 * ν ∨ d.natAbs = 2 * ν + 1 := ⟨d.natAbs / 2, by omega⟩
  obtain ⟨μ, hμ⟩ : ∃ μ, b.natAbs = 2 * μ ∨ b.natAbs = 2 * μ + 1 := ⟨b.natAbs / 2, by omega⟩
  rcases hμ with hμ | hμ
  · -- pivot height even: one term stands alone across the `√3`-separation
    exfalso
    rcases hν with hν | hν
    · -- both even: the unit trace alone
      rw [hν, hμ] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨-, hY⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace ν _ _ _).add (inRing_pow_trace t _ _ _))
        ((inRing_pow_trace μ _ _ _).neg)
        (show ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
              + (3 : ℂ) ^ t * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                  (b - d).natAbs)
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * (-((3 : ℂ) ^ μ
                * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν))) = 0 by
          linear_combination hcl)
      have hH2 : hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν) = 0 := by
        have h3 : ((3 : ℂ) ^ μ) ≠ 0 := pow_ne_zero _ (by norm_num)
        exact (mul_eq_zero.mp (neg_eq_zero.mp hY)).resolve_left h3
      rcases Nat.eq_zero_or_pos ν with hν0 | hνp
      · subst hν0
        rw [show 2 * 0 = 0 from rfl, hexTrace_zero_height] at hH2
        exact hex_zero_height_ne (uAddr c d) (by exact_mod_cast hH2)
      · exact hexE_hexF_ne (uAddr c d) (hexTrace_eq_zero (by omega) hH2)
    · -- pivot even, meta odd: the cross trace alone
      rw [hν, hμ] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
        (inRing_pow_trace t _ _ _)
        (((inRing_pow_trace ν _ _ _)).add ((inRing_pow_trace μ _ _ _).neg))
        (show ((3 : ℂ) ^ t
              * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                (b - d).natAbs)
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
                + -((3 : ℂ) ^ μ
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1))) = 0 by
          linear_combination hcl)
      have hH3 : hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
          (b - d).natAbs = 0 := by
        have h3 : ((3 : ℂ) ^ t) ≠ 0 := pow_ne_zero _ (by norm_num)
        exact (mul_eq_zero.mp hX).resolve_left h3
      exact gE_gF_zero_ne _ (hexTrace_eq_zero (by omega) hH3)
  · rcases hν with hν | hν
    · -- **the live class**: pivot height odd, meta height even — no separation, the
      -- 3-adic minimum decides
      rw [hν, hμ, show 2 * μ + 1 + 1 = 2 * (μ + 1) by ring] at hcl
      simp only [sqrt3_pow_two_mul] at hcl
      rcases eq_or_ne d 0 with hd0 | hd0
      · -- the endgame: `d = 0` pins the height to one and the address pair to two rows
        subst hd0
        have hn0 : ν = 0 := by omega
        have ht0 : t = 0 := by omega
        subst hn0
        subst ht0
        rw [uAddr, if_pos le_rfl, sub_zero, pow_zero, one_mul, one_mul, hμ,
          show 2 * 0 = 0 from rfl, hexTrace_add, hexTrace_zero_height] at hcl
        have hcl2 : hexTrace (gE (gAddr A b) + gE (gAddr (A - c) b))
            (gF (gAddr A b) + gF (gAddr (A - c) b)) (2 * μ + 1)
            = ((3 ^ (μ + 1) * (2 * hexE c.val + hexF c.val) : ℤ) : ℂ) := by
          linear_combination (norm := (push_cast; ring)) hcl
        obtain ⟨hF, hval⟩ := hexTrace_pin (by omega) hcl2
        have hne : gE (gAddr A b) + gE (gAddr (A - c) b) ≠ 0 := by
          intro h0
          rw [h0, zero_mul] at hval
          have hτ := hex_zero_height_ne c
          have h3 : (3 : ℤ) ^ (μ + 1) ≠ 0 := pow_ne_zero _ (by norm_num)
          rcases mul_eq_zero.mp hval.symm with h | h
          · exact h3 h
          · exact hτ h
        have hdvd : (3 : ℤ) ^ (μ + 1) ∣ (gE (gAddr A b) + gE (gAddr (A - c) b)) :=
          Int.prime_three.pow_dvd_of_dvd_mul_right (μ + 1)
            (not_three_dvd_pin (2 * μ + 1) (by omega)) ⟨_, hval⟩
        have hbnd := gE_abs_le (gAddr A b) (gAddr (A - c) b)
        have hle : (3 : ℤ) ^ (μ + 1) ≤ 4 := by
          rcases lt_or_gt_of_ne hne with hlt | hgt
          · have := Int.le_of_dvd (by omega) ((dvd_neg).mpr hdvd)
            omega
          · have := Int.le_of_dvd (by omega) hdvd
            omega
        have hμ0 : μ = 0 := by
          by_contra hc
          obtain ⟨μ', rfl⟩ : ∃ μ', μ = μ' + 1 := ⟨μ - 1, by omega⟩
          have h9 : (3 : ℤ) ^ 2 ≤ 3 ^ (μ' + 1 + 1) := pow_le_pow_right₀ (by norm_num) (by omega)
          norm_num at h9
          omega
        subst hμ0
        have hb1 : b = 1 ∨ b = -1 := by omega
        have hpin : (2 * (piCoeff (2 * 0 + 1)).1 + (piCoeff (2 * 0 + 1)).2) = 1 := by
          rw [show (2 * 0 + 1 : ℕ) = 1 from rfl, show piCoeff 1 = (0, 1) from rfl]
          norm_num
        rw [hpin, mul_one, pow_one] at hval
        refine ⟨?_, hb1, rfl⟩
        rcases hb1 with rfl | rfl
        · rw [gAddr, if_pos (by norm_num), gAddr, if_pos (by norm_num)] at hF hval
          exact ii_endgame_pos A c hF hval
        · rw [gAddr, if_neg (by norm_num), gAddr, if_neg (by norm_num)] at hF hval
          exact ii_endgame_neg A c hF hval
      · -- `d ≠ 0`: every configuration dies
        exfalso
        have hνp : 1 ≤ ν := by omega
        rcases Nat.eq_zero_or_pos t with ht0 | htp
        · -- opposite seam signs: the cross trace stands alone at the bottom
          subst ht0
          obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
          obtain ⟨R1, R2⟩ := hexTrace_rows
            (show (3 : ℂ) ^ 0 * hexTrace (gE (gAddr (A - c) (b - d)))
                  (gF (gAddr (A - c) (b - d))) (b - d).natAbs
                + (3 : ℂ) ^ (1 + ν')
                  * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
                = (3 : ℂ) ^ (μ + 1)
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * (ν' + 1)) by
              rw [pow_zero, one_mul]
              linear_combination hcl)
          refine gE_gF_ne (gAddr (A - c) (b - d)) (alone_dvd (p := (b - d).natAbs) (by omega)
            (R₁ := 3 ^ μ * (hexE (uAddr c d).val * (piCoeff (2 * (ν' + 1))).1
                + (hexE (uAddr c d).val + hexF (uAddr c d).val)
                  * ((piCoeff (2 * (ν' + 1))).1 + (piCoeff (2 * (ν' + 1))).2))
              - 3 ^ ν' * (gE (gAddr A b) * (piCoeff (2 * μ + 1)).1
                + (gE (gAddr A b) + gF (gAddr A b))
                  * ((piCoeff (2 * μ + 1)).1 + (piCoeff (2 * μ + 1)).2)))
            (R₂ := 3 ^ μ * (hexF (uAddr c d).val * (piCoeff (2 * (ν' + 1))).2)
              - 3 ^ ν' * (gF (gAddr A b) * (piCoeff (2 * μ + 1)).2))
            ?_ ?_)
          · linear_combination R1
          · linear_combination R2
        · rcases lt_trichotomy d.natAbs b.natAbs with hlt | heq | hgt
          · -- the pivot trace stands alone
            obtain ⟨t', ht'⟩ : ∃ t', t = ν + 1 + t' := ⟨t - ν - 1, by omega⟩
            obtain ⟨μ', hμ'⟩ : ∃ μ', μ + 1 = ν + 1 + μ' := ⟨μ - ν, by omega⟩
            rw [ht', hμ'] at hcl
            have hcl' : (3 : ℂ) ^ 0 * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
                + (3 : ℂ) ^ (1 + t')
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs
                = (3 : ℂ) ^ (1 + μ')
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν) :=
              mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0))
                (by rw [pow_zero]; linear_combination hcl)
            obtain ⟨R1, R2⟩ := hexTrace_rows hcl'
            refine gE_gF_ne (gAddr A b) (alone_dvd (p := 2 * μ + 1) (by omega)
              (R₁ := 3 ^ μ' * (hexE (uAddr c d).val * (piCoeff (2 * ν)).1
                  + (hexE (uAddr c d).val + hexF (uAddr c d).val)
                    * ((piCoeff (2 * ν)).1 + (piCoeff (2 * ν)).2))
                - 3 ^ t' * (gE (gAddr (A - c) (b - d)) * (piCoeff (b - d).natAbs).1
                  + (gE (gAddr (A - c) (b - d)) + gF (gAddr (A - c) (b - d)))
                    * ((piCoeff (b - d).natAbs).1 + (piCoeff (b - d).natAbs).2)))
              (R₂ := 3 ^ μ' * (hexF (uAddr c d).val * (piCoeff (2 * ν)).2)
                - 3 ^ t' * (gF (gAddr (A - c) (b - d)) * (piCoeff (b - d).natAbs).2))
              ?_ ?_)
            · linear_combination R1
            · linear_combination R2
          · omega
          · -- the unit trace sits at the minimum: the `φ` functional kills
            obtain ⟨i, hi⟩ : ∃ i, ν = μ + 1 + i := ⟨ν - μ - 1, by omega⟩
            obtain ⟨j, hj⟩ : ∃ j, t = μ + 1 + j := ⟨t - μ - 1, by omega⟩
            rw [hi, hj] at hcl
            have hcl' : (3 : ℂ) ^ i * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
                + (3 : ℂ) ^ j
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs
                = (3 : ℂ) ^ 0
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val)
                    (2 * (μ + 1 + i)) :=
              mul_left_cancel₀ (pow_ne_zero (μ + 1) (by norm_num : (3 : ℂ) ≠ 0))
                (by rw [pow_zero]; linear_combination hcl)
            obtain ⟨R1, R2⟩ := hexTrace_rows hcl'
            obtain ⟨w₁, hw₁⟩ := phi_g_dvd (gAddr A b) (2 * μ + 1)
            obtain ⟨w₃, hw₃⟩ := phi_g_dvd (gAddr (A - c) (b - d)) (b - d).natAbs
            refine hex_diff_ne (uAddr c d) (phi_dvd (r := 2 * (μ + 1 + i)) (by omega)
              (S := 3 ^ i * w₁ + 3 ^ j * w₃) ?_)
            rw [pow_zero, one_mul] at R1 R2
            linear_combination -R1 - R2 + (3 : ℤ) ^ i * hw₁ + (3 : ℤ) ^ j * hw₃
    · -- pivot odd, meta odd: the pivot trace alone
      exfalso
      rw [hν, hμ] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨-, hY⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace t _ _ _).add ((inRing_pow_trace (μ + 1) _ _ _).neg))
        (inRing_pow_trace ν _ _ _)
        (show ((3 : ℂ) ^ t
              * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                (b - d).natAbs
              + -((3 : ℂ) ^ (μ + 1)
                * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1)))
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)) = 0 by
          linear_combination hcl
            + (3 : ℂ) ^ μ
              * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1)
              * sqrt3_cast_sq)
      have hH1 : hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1) = 0 := by
        have h3 : ((3 : ℂ) ^ ν) ≠ 0 := pow_ne_zero _ (by norm_num)
        exact (mul_eq_zero.mp hY).resolve_left h3
      exact gE_gF_zero_ne _ (hexTrace_eq_zero (by omega) hH1)

/-! ### §W.5 The completeness theorems -/

/-- **oo completeness at the metaPivot axis, all three webs**: exactly the four table
chords per web — the θσ resistance leaves no infinite family. -/
theorem meta_oo_complete (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (outerPt (pivot j) (pivot j + 1) a b) (outerPt metaPivot metaAnchor c d) = 1 ↔
      (a - webShift j, b, c - webShift j, d) ∈ metaOOTable := by sorry

/-- **oi completeness, all three webs**: the hub pencil — the meta-inner point AT pivot
`j` — or the four hex-layer table chords. -/
theorem meta_oi_complete (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (outerPt (pivot j) (pivot j + 1) a b) (innerPt metaPivot metaAnchor c d) = 1 ↔
      ((c - webShift j, d) = (3, 0)
        ∨ (a - webShift j, b, c - webShift j, d) ∈ metaOITable) := by sorry

/-- **io completeness, all three webs**: exactly the four table chords per web (the io
hub direction is `ζ₁₂/√3` — never a lattice word, M24's empty fibre). -/
theorem meta_io_complete (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (innerPt (pivot j) (pivot j + 1) a b) (outerPt metaPivot metaAnchor c d) = 1 ↔
      (a - webShift j, b, c - webShift j, d) ∈ metaIOTable := by sorry

/-- **ii completeness, all three webs**: exactly the four table chords per web. -/
theorem meta_ii_complete (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (innerPt (pivot j) (pivot j + 1) a b) (innerPt metaPivot metaAnchor c d) = 1 ↔
      (a - webShift j, b, c - webShift j, d) ∈ metaIITable := by sorry

/-! ## §C The colouring: χ(four-ladder object) = 4

The b-independent table measured by the E4 probe (33 collapsed classes, no self-loop):
outer/inner × 6 addresses per anchor, fused points consistent by construction. -/

/-- The colour table per (anchor, circle, hex address); circle `false` = outer,
`true` = inner (the M24 `colTab` convention). The E4 probe's measured table, consistent
on every fused point by construction. -/
def metaColTab : Fin 4 → Bool → ZMod 6 → Fin 4
  | 0, false => ![1, 0, 3, 1, 0, 3]
  | 0, true => ![2, 2, 0, 0, 1, 1]
  | 1, false => ![2, 3, 0, 2, 3, 0]
  | 1, true => ![0, 0, 1, 1, 2, 2]
  | 2, false => ![3, 2, 1, 3, 2, 1]
  | 2, true => ![1, 1, 2, 2, 0, 0]
  | 3, false => ![1, 3, 0, 3, 0, 3]
  | 3, true => ![0, 0, 1, 2, 2, 1]

theorem colorable_four_fourLadder :
    ((unitDistance ℂ).induce fourLadder).Colorable 4 := by sorry

/-- The lower bound is M24's nine-point witness, transported: the matched ladder pair
sits inside the four-ladder object as its first two ladders. -/
theorem not_colorable_three_fourLadder :
    ¬ ((unitDistance ℂ).induce fourLadder).Colorable 3 := fun hc =>
  not_colorable_three_ladder
    (hc.of_hom { toFun := fun v => ⟨(v : ℂ), ladderSet_subset_fourLadder v.2⟩
                 map_rel' := fun {_ _} h => h })

/-- **The M25 headline**: the four-ladder object is exactly 4-chromatic. -/
theorem chromaticNumber_fourLadder :
    ((unitDistance ℂ).induce fourLadder).chromaticNumber = 4 := by
  refine le_antisymm colorable_four_fourLadder.chromaticNumber_le ?_
  exact_mod_cast
    add_one_le_chromaticNumber_iff_not_colorable.mpr not_colorable_three_fourLadder

end MetaLadder
end HadwigerNelson
