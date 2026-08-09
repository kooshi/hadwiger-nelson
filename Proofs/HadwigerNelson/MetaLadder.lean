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
