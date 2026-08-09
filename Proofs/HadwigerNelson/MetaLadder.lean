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

/-! ### §W.12 The reverse master, the fusion bridges, and the κ extraction

The completeness statements are iffs and the colour decode classifies point
*equalities*, so the master expansion is needed in both directions and at norm 0: two
ladder points coincide iff the same cleared expression has norm **zero**, so the fusion
classification is the chord classification at a different constant κ — oo: 4 vs 7,
oi/io: 2 vs 5, ii: 0 vs 3√3.  One engine runs all eight; the fusion runs land the
colour decode's coincidence inventory for free. -/

/-- The master expansion as an equality: both directions of every bridge flow from it. -/
private theorem web_master_eq (A c : ZMod 6) (b d : ℤ) (y z : ℝ) :
    ((normSq (gC * word A b - (y : ℂ) - (z : ℂ) * word c d) : ℝ) : ℂ)
      = ((3 + y ^ 2 + z ^ 2 : ℝ) : ℂ) - (y : ℂ) * gTr A b - (z : ℂ) * gTr (A - c) (b - d)
        + ((y : ℂ) * (z : ℂ)) * uTr c d := by
  have hu := word_mul_inv A b
  have hv := word_mul_inv c d
  have hX1 := word_mul_neg A c b d
  have hX2 := word_mul_neg c A d b
  have hX := Complex.mul_conj (gC * word A b - (y : ℂ) - (z : ℂ) * word c d)
  rw [map_sub, map_sub, map_mul, map_mul, gC_conj, Complex.conj_ofReal,
    Complex.conj_ofReal, word_conj, word_conj] at hX
  rw [gTr, gTr, uTr, show (-(A - c) : ZMod 6) = c - A by ring, show -(b - d) = d - b by ring]
  push_cast
  linear_combination -hX + (word A b * word (-A) (-b)) * gC_mul_gB + 3 * hu
    + (z : ℂ) ^ 2 * hv - (z : ℂ) * gC * hX1 - (z : ℂ) * gB * hX2

/-- The reverse master: a trace identity certifies the norm equation. -/
private theorem web_master_rev {A c : ZMod 6} {b d : ℤ} {y z R : ℝ}
    (h : ((3 + y ^ 2 + z ^ 2 - R : ℝ) : ℂ) - (y : ℂ) * gTr A b
        - (z : ℂ) * gTr (A - c) (b - d) + ((y : ℂ) * (z : ℂ)) * uTr c d = 0) :
    normSq (gC * word A b - (y : ℂ) - (z : ℂ) * word c d) = R := by
  have he := web_master_eq A c b d y z
  have hc : ((normSq (gC * word A b - (y : ℂ) - (z : ℂ) * word c d) : ℝ) : ℂ)
      = ((R : ℝ) : ℂ) := by
    linear_combination (norm := (push_cast; ring)) he + h
  exact_mod_cast hc

private theorem zeta12_ne_zero : zeta12 ≠ 0 := fun h => by
  have hn := normSq_zeta12
  rw [h, map_zero] at hn
  norm_num at hn

/-- The fusion scaling step: two points coincide iff the cleared expression has norm 0. -/
private theorem fusion_gen {P Q k Z : ℂ} (hk : k ≠ 0)
    (h : k * (P - Q) = zeta12 * Z) : P = Q ↔ normSq Z = 0 := by
  constructor
  · intro he
    rw [he, sub_self, mul_zero] at h
    rcases mul_eq_zero.mp h.symm with h0 | h0
    · exact absurd h0 zeta12_ne_zero
    · rw [h0, map_zero]
  · intro h0
    obtain hz : Z = 0 := Complex.normSq_eq_zero.mp h0
    rw [hz, mul_zero] at h
    rcases mul_eq_zero.mp h with h1 | h1
    · exact absurd h1 hk
    · exact sub_eq_zero.mp h1

/-- oo fusion bridge: outer(pivot) and outer(meta) coincide iff the oo expression has
norm zero (the chord bridge asks for 3). -/
theorem fusion_bridge_oo (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    outerPt 0 1 a b = outerPt metaPivot metaAnchor c d ↔
      normSq (gC * word (a - 1) b - 1 - ((Real.sqrt 3 : ℝ) : ℂ) * word c d) = 0 := by
  refine fusion_gen sqrt3_ne ?_
  rw [outerPt, outerPt, metaAnchor_sub, word_succ a b]
  linear_combination scale_oo (word (a - 1) b) (word c d)

theorem fusion_bridge_oi (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    outerPt 0 1 a b = innerPt metaPivot metaAnchor c d ↔
      normSq (gC * word (a - 1) b - 1 - word c d) = 0 := by
  refine fusion_gen sqrt3_ne ?_
  rw [outerPt, innerPt, metaAnchor_sub, word_succ a b]
  linear_combination scale_oi (word (a - 1) b) (word c d)

theorem fusion_bridge_io (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    innerPt 0 1 a b = outerPt metaPivot metaAnchor c d ↔
      normSq (gC * word (a - 1) b - ((Real.sqrt 3 : ℝ) : ℂ) - 3 * word c d) = 0 := by
  refine fusion_gen (by norm_num : (3 : ℂ) ≠ 0) ?_
  rw [innerPt, outerPt, metaAnchor_sub, word_succ a b]
  linear_combination scale_io (word (a - 1) b) (word c d)

theorem fusion_bridge_ii (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    innerPt 0 1 a b = innerPt metaPivot metaAnchor c d ↔
      normSq (gC * word (a - 1) b - ((Real.sqrt 3 : ℝ) : ℂ)
        - ((Real.sqrt 3 : ℝ) : ℂ) * word c d) = 0 := by
  refine fusion_gen (by norm_num : (3 : ℂ) ≠ 0) ?_
  rw [innerPt, innerPt, metaAnchor_sub, word_succ a b]
  linear_combination scale_ii (word (a - 1) b) (word c d)

/-- The oo master, κ-form: `Tr(g·w₁) + √3·Tr(g·W) = κ + √3·Tr(V)` with `κ = 7 − R`. -/
private theorem oo_master {a c : ZMod 6} {b d : ℤ} {R : ℝ} {κ : ℤ}
    (hκ : R + (κ : ℝ) = 7)
    (h : normSq (gC * word (a - 1) b - 1 - ((Real.sqrt 3 : ℝ) : ℂ) * word c d) = R) :
    gTr (a - 1) b + ((Real.sqrt 3 : ℝ) : ℂ) * gTr (a - 1 - c) (b - d)
      = (κ : ℂ) + ((Real.sqrt 3 : ℝ) : ℂ) * uTr c d := by
  rw [show (1 : ℂ) = ((1 : ℝ) : ℂ) by norm_num] at h
  have hm := web_master h
  have hc : ((3 + (1 : ℝ) ^ 2 + Real.sqrt 3 ^ 2 - R : ℝ) : ℂ) = (κ : ℂ) := by
    have h3 : Real.sqrt 3 ^ 2 = 3 := by nlinarith [sq_sqrt3]
    rw [h3]
    have : (3 + (1 : ℝ) ^ 2 + 3 - R : ℝ) = (κ : ℝ) := by linarith
    rw [this]
    norm_cast
  rw [hc] at hm
  linear_combination (norm := (push_cast; ring)) -hm

/-- The oi master, κ-form: `Tr(g·w₁) + Tr(g·W) = κ + Tr(V)` with `κ = 5 − R`. -/
private theorem oi_master {a c : ZMod 6} {b d : ℤ} {R : ℝ} {κ : ℤ}
    (hκ : R + (κ : ℝ) = 5)
    (h : normSq (gC * word (a - 1) b - 1 - word c d) = R) :
    gTr (a - 1) b + gTr (a - 1 - c) (b - d) = (κ : ℂ) + uTr c d := by
  rw [show (1 : ℂ) = ((1 : ℝ) : ℂ) by norm_num,
    show word c d = ((1 : ℝ) : ℂ) * word c d by norm_num] at h
  have hm := web_master h
  have hc : ((3 + (1 : ℝ) ^ 2 + (1 : ℝ) ^ 2 - R : ℝ) : ℂ) = (κ : ℂ) := by
    have : (3 + (1 : ℝ) ^ 2 + (1 : ℝ) ^ 2 - R : ℝ) = (κ : ℝ) := by linarith
    rw [this]
    norm_cast
  rw [hc] at hm
  linear_combination (norm := (push_cast; ring)) -hm

/-- The io master, κ-form: `Tr(g·w₁) + √3·Tr(g·W) = κ·√3 + 3·Tr(V)` with `3κ = 15 − R`. -/
private theorem io_master {a c : ZMod 6} {b d : ℤ} {R : ℝ} {κ : ℤ}
    (hκ : R + 3 * (κ : ℝ) = 15)
    (h : normSq (gC * word (a - 1) b - ((Real.sqrt 3 : ℝ) : ℂ) - 3 * word c d) = R) :
    gTr (a - 1) b + ((Real.sqrt 3 : ℝ) : ℂ) * gTr (a - 1 - c) (b - d)
      = (κ : ℂ) * ((Real.sqrt 3 : ℝ) : ℂ) + 3 * uTr c d := by
  rw [show (3 : ℂ) * word c d = ((3 : ℝ) : ℂ) * word c d by norm_num] at h
  have hm := web_master h
  have hc : ((3 + Real.sqrt 3 ^ 2 + (3 : ℝ) ^ 2 - R : ℝ) : ℂ) = 3 * (κ : ℂ) := by
    have h3 : Real.sqrt 3 ^ 2 = 3 := by nlinarith [sq_sqrt3]
    rw [h3]
    have : (3 + (3 : ℝ) + (3 : ℝ) ^ 2 - R : ℝ) = 3 * (κ : ℝ) := by push_cast; linarith
    rw [this]
    norm_cast
  rw [hc] at hm
  refine mul_left_cancel₀ sqrt3_ne ?_
  linear_combination (norm := (push_cast; ring)) -hm
    + (gTr (a - 1 - c) (b - d) - (κ : ℂ)) * sqrt3_cast_sq

/-- The ii fusion master: coincidence of the two inner ladders would force
`Tr(g·w₁) + Tr(g·W) = 3√3 + √3·Tr(V)`. -/
private theorem ii_fusion_master {a c : ZMod 6} {b d : ℤ}
    (h : normSq (gC * word (a - 1) b - ((Real.sqrt 3 : ℝ) : ℂ)
      - ((Real.sqrt 3 : ℝ) : ℂ) * word c d) = 0) :
    gTr (a - 1) b + gTr (a - 1 - c) (b - d)
      = 3 * ((Real.sqrt 3 : ℝ) : ℂ) + ((Real.sqrt 3 : ℝ) : ℂ) * uTr c d := by
  have hm := web_master h
  have hc : ((3 + Real.sqrt 3 ^ 2 + Real.sqrt 3 ^ 2 - 0 : ℝ) : ℂ) = 9 := by
    have h3 : Real.sqrt 3 ^ 2 = 3 := by nlinarith [sq_sqrt3]
    rw [h3]
    norm_num
  rw [hc] at hm
  refine mul_left_cancel₀ sqrt3_ne ?_
  linear_combination (norm := (push_cast; ring)) -hm - 3 * sqrt3_cast_sq

/-! ### §W.13 The κ-augmented kill toolkit -/

/-- The two integer rows of a three-trace identity with a rational constant `κ·3^s`:
the constant hits row 1 only — the 4-term extractor the oo/oi/io families need. -/
private theorem hexTrace_rows_const {κ t₁ t₂ u₁ u₂ v₁ v₂ : ℤ} {p q r i j l s : ℕ}
    (heq : (3 : ℂ) ^ i * hexTrace t₁ t₂ p + (3 : ℂ) ^ j * hexTrace u₁ u₂ q
      = (κ : ℂ) * 3 ^ s + (3 : ℂ) ^ l * hexTrace v₁ v₂ r) :
    (3 ^ i * (t₁ * (piCoeff p).1 + (t₁ + t₂) * ((piCoeff p).1 + (piCoeff p).2))
        + 3 ^ j * (u₁ * (piCoeff q).1 + (u₁ + u₂) * ((piCoeff q).1 + (piCoeff q).2))
        - κ * 3 ^ s
        - 3 ^ l * (v₁ * (piCoeff r).1 + (v₁ + v₂) * ((piCoeff r).1 + (piCoeff r).2)) = 0)
      ∧ (3 ^ i * (t₂ * (piCoeff p).2) + 3 ^ j * (u₂ * (piCoeff q).2)
        - 3 ^ l * (v₂ * (piCoeff r).2) = 0) := by
  obtain ⟨k₁, k₂, -, -⟩ := inRing_coords_zero
    (n₁ := 3 ^ i * (t₁ * (piCoeff p).1 + (t₁ + t₂) * ((piCoeff p).1 + (piCoeff p).2))
        + 3 ^ j * (u₁ * (piCoeff q).1 + (u₁ + u₂) * ((piCoeff q).1 + (piCoeff q).2))
        - κ * 3 ^ s
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

private theorem gF_ne_zero : ∀ x : ZMod 6, gF x ≠ 0 := by decide

/-- A `g`-trace at positive height is never a rational integer: the pin forces its
`ζ₆`-coefficient to vanish and `gF` never does. -/
private theorem g_pin_kill {x : ZMod 6} {h : ℕ} {r : ℤ} (hh : 1 ≤ h)
    (heq : hexTrace (gE x) (gF x) h = (r : ℂ)) : False :=
  gF_ne_zero x (hexTrace_pin hh heq).1

private theorem hexF_zero_hexE : ∀ y : ZMod 6,
    hexF y.val = 0 → hexE y.val = 1 ∨ hexE y.val = -1 := by decide

/-- A unit trace at positive height never equals `3·(integer)`: pin + the mod-3 tables. -/
private theorem u_pin_kill_dvd {y : ZMod 6} {n : ℕ} {r : ℤ} (hn : 1 ≤ n)
    (heq : hexTrace (hexE y.val) (hexF y.val) n = ((3 * r : ℤ) : ℂ)) : False := by
  obtain ⟨hF, hval⟩ := hexTrace_pin hn heq
  have h3 : (3 : ℤ) ∣ hexE y.val * (2 * (piCoeff n).1 + (piCoeff n).2) := ⟨r, hval⟩
  have h3E := (Int.prime_three.dvd_mul.mp h3).resolve_right (not_three_dvd_pin n hn)
  exact hexE_hexF_not_both_dvd y.val (ZMod.val_lt y) ⟨h3E, hF ▸ dvd_zero 3⟩

/-- A unit trace at height 1 equals a rational integer only at `±1` (pin + tables). -/
private theorem u_pin_one {y : ZMod 6} {r : ℤ}
    (heq : hexTrace (hexE y.val) (hexF y.val) 1 = (r : ℂ)) : r = 1 ∨ r = -1 := by
  obtain ⟨hF, hval⟩ := hexTrace_pin le_rfl heq
  rw [show piCoeff 1 = (0, 1) from rfl] at hval
  rcases hexF_zero_hexE y hF with h1 | h1 <;> rw [h1] at hval <;> omega

private theorem cast_mod3_one {q : ℤ} (h : q % 3 = 1) :
    (q : ZMod 9) = 1 ∨ (q : ZMod 9) = 4 ∨ (q : ZMod 9) = 7 := by
  obtain ⟨k, hk⟩ : ∃ k, q = 3 * k + 1 := ⟨q / 3, by omega⟩
  subst hk
  push_cast
  exact (by decide : ∀ z : ZMod 9, 3 * z + 1 = 1 ∨ 3 * z + 1 = 4 ∨ 3 * z + 1 = 7) _

/-- The mod-9 refutation table behind the adjacent-heights kill: with the two deep
`piCoeff` residues confined to `{1, 4, 7}`, no `g`-address pair satisfies both rows. -/
private theorem adjacent_mod9 : ∀ (x₁ x₃ : ZMod 6) (r0 r1 : ZMod 9),
    (r0 = 1 ∨ r0 = 4 ∨ r0 = 7) → (r1 = 1 ∨ r1 = 4 ∨ r1 = 7) →
    ¬ (((gE x₁ : ZMod 9) * (-3 * r1)
          + ((gE x₁ : ZMod 9) + (gF x₁ : ZMod 9)) * (-3 * r1 + (-3 * r0 + r1))
          + ((gE x₃ : ZMod 9) * (-3 * (-3 * r0 + r1))
            + ((gE x₃ : ZMod 9) + (gF x₃ : ZMod 9))
              * (-3 * (-3 * r0 + r1) + (-3 * r1 + (-3 * r0 + r1)))) = 0)
        ∧ ((gF x₁ : ZMod 9) * (-3 * r0 + r1)
          + (gF x₃ : ZMod 9) * (-3 * r1 + (-3 * r0 + r1)) = 0)) := by
  decide

/-- **The adjacent-heights kill**: two `g`-traces at heights `h` and `h + 1` (`h ≥ 3`)
never sum, row by row, to `3^e`-multiples for `e ≥ 2` — mod 9 the `piCoeff` recurrence
leaves only the residues `{1, 4, 7}` for the two deep `Q`s, and no address pair
survives.  The kill that bounds the pivot height in the oo and io endgames. -/
private theorem adjacent_kill (x₁ x₃ : ZMod 6) {h e : ℕ} (hh : 3 ≤ h) (he : 2 ≤ e)
    {W₁ W₂ : ℤ}
    (hR1 : gE x₁ * (piCoeff h).1 + (gE x₁ + gF x₁) * ((piCoeff h).1 + (piCoeff h).2)
        + (gE x₃ * (piCoeff (h + 1)).1
          + (gE x₃ + gF x₃) * ((piCoeff (h + 1)).1 + (piCoeff (h + 1)).2)) = 3 ^ e * W₁)
    (hR2 : gF x₁ * (piCoeff h).2 + gF x₃ * (piCoeff (h + 1)).2 = 3 ^ e * W₂) : False := by
  obtain ⟨j, rfl⟩ : ∃ j, h = j + 3 := ⟨h - 3, by omega⟩
  obtain ⟨f, rfl⟩ : ∃ f, e = f + 2 := ⟨e - 2, by omega⟩
  have hp4 : (piCoeff (j + 3 + 1)).1 = -3 * (piCoeff (j + 3)).2 := rfl
  have hq4 : (piCoeff (j + 3 + 1)).2 = (piCoeff (j + 3)).1 + (piCoeff (j + 3)).2 := rfl
  have hp3 : (piCoeff (j + 3)).1 = -3 * (piCoeff (j + 2)).2 := rfl
  have hq3 : (piCoeff (j + 3)).2 = (piCoeff (j + 2)).1 + (piCoeff (j + 2)).2 := rfl
  have hp2 : (piCoeff (j + 2)).1 = -3 * (piCoeff (j + 1)).2 := rfl
  have hm1 : (piCoeff (j + 2)).2 % 3 = 1 := piCoeff_snd_emod (j + 1)
  have hm0 : (piCoeff (j + 1)).2 % 3 = 1 := piCoeff_snd_emod j
  rw [hp4, hq4, hp3, hq3, hp2,
    show (3 : ℤ) ^ (f + 2) = 9 * 3 ^ f by ring] at hR1
  rw [hq4, hp3, hq3, hp2,
    show (3 : ℤ) ^ (f + 2) = 9 * 3 ^ f by ring] at hR2
  have hc1 := congrArg (fun z : ℤ => (z : ZMod 9)) hR1
  have hc2 := congrArg (fun z : ℤ => (z : ZMod 9)) hR2
  push_cast at hc1 hc2
  have h9 : (9 : ZMod 9) = 0 := by decide
  refine adjacent_mod9 x₁ x₃ ((piCoeff (j + 1)).2 : ZMod 9) ((piCoeff (j + 2)).2 : ZMod 9)
    (cast_mod3_one hm0) (cast_mod3_one hm1) ⟨?_, ?_⟩
  · linear_combination hc1 + (3 : ZMod 9) ^ f * (W₁ : ZMod 9) * h9
  · linear_combination hc2 + (3 : ZMod 9) ^ f * (W₂ : ZMod 9) * h9

/-- Height-zero `g`-traces: the values `2·gE + gF` are `{3, 0, −3}` — never κ. -/
private theorem g_zero_val : ∀ x : ZMod 6,
    2 * gE x + gF x = 3 ∨ 2 * gE x + gF x = 0 ∨ 2 * gE x + gF x = -3 := by decide

private theorem g_zero_ne_kappa : ∀ x : ZMod 6, ∀ κ : ℤ,
    κ = 4 ∨ κ = 7 ∨ κ = 2 ∨ κ = 5 → 2 * gE x + gF x ≠ κ := by
  intro x κ hκ
  have h := g_zero_val x
  omega

/-- A `g`-trace at height zero is the rational integer `2·gE + gF`. -/
private theorem gTr_zero (A : ZMod 6) : gTr A 0 = ((2 * gE A + gF A : ℤ) : ℂ) := by
  have h := gTrace_clear_nonneg A 0
  rw [pow_zero, one_mul, Nat.cast_zero, neg_zero, hexTrace_zero_height] at h
  rw [gTr, show (-(0 : ℤ)) = (0 : ℤ) from neg_zero, h]

/-- A unit trace at height zero is the rational integer `2·hexE + hexF`. -/
private theorem uTr_zero (c : ZMod 6) : uTr c 0 = ((2 * hexE c.val + hexF c.val : ℤ) : ℂ) := by
  have h := uTrace_clear_nonneg c 0
  rw [pow_zero, one_mul, Nat.cast_zero, neg_zero, hexTrace_zero_height] at h
  rw [uTr, show (-(0 : ℤ)) = (0 : ℤ) from neg_zero, h]

/-! ### §W.14 The oo family: `outer(pivot) ↔ outer(meta)`, κ ∈ {4, 7} -/

/-- The oo cleared equation: uniform `√3^(m+n)` clearing, no shape split. -/
private theorem oo_cleared {A c : ZMod 6} {b d : ℤ} {t : ℕ} {κ : ℤ}
    (ht : b.natAbs + d.natAbs = (b - d).natAbs + 2 * t)
    (h : gTr A b + ((Real.sqrt 3 : ℝ) : ℂ) * gTr (A - c) (b - d)
      = (κ : ℂ) + ((Real.sqrt 3 : ℝ) : ℂ) * uTr c d) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ d.natAbs
        * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) b.natAbs
      + ((Real.sqrt 3 : ℝ) : ℂ) * ((3 : ℂ) ^ t
          * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
            (b - d).natAbs)
      = (κ : ℂ) * ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs)
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + 1)
          * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) d.natAbs := by
  have hA := gTrace_clear A b
  have hB := gTrace_clear (A - c) (b - d)
  have hC := uTrace_clear c d
  have hsum : ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs)
      * (gTr A b + ((Real.sqrt 3 : ℝ) : ℂ) * gTr (A - c) (b - d))
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs)
        * ((κ : ℂ) + ((Real.sqrt 3 : ℝ) : ℂ) * uTr c d) := by rw [h]
  have hpow2 : ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * t) * ((Real.sqrt 3 : ℝ) : ℂ) ^ (b - d).natAbs
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs) := by
    rw [← pow_add, show 2 * t + (b - d).natAbs = b.natAbs + d.natAbs by omega]
  rw [← hA, ← hB, ← hC, ← sqrt3_pow_two_mul t]
  linear_combination hsum + ((Real.sqrt 3 : ℝ) : ℂ) * gTr (A - c) (b - d) * hpow2

/-- The oo boundary decide, `d = 1` frame (`b = 0`): κ = 4 pins the two rows, κ = 7
refuses. -/
private theorem oo_end_pos : ∀ (A c : ZMod 6) (κ : ℤ), κ = 4 ∨ κ = 7 →
    2 * gE A + gF A + (gE (-(A - c) - 1) + gF (-(A - c) - 1))
        - κ - (hexE c.val + hexF c.val) = 0 →
    gF (-(A - c) - 1) - hexF c.val = 0 →
    κ = 4 ∧ ((A = 5 ∧ c = 5) ∨ (A = 0 ∧ c = 1)) := by
  intro A c κ hκ h1 h2
  rcases hκ with rfl | rfl
  · refine ⟨rfl, ?_⟩
    revert h1 h2
    revert A c
    decide
  · exfalso
    revert h1 h2
    revert A c
    decide

/-- The oo boundary decide, `d = −1` frame (`b = 0`). -/
private theorem oo_end_neg : ∀ (A c : ZMod 6) (κ : ℤ), κ = 4 ∨ κ = 7 →
    2 * gE A + gF A + (gE (A - c) + gF (A - c))
        - κ - (hexE (-c).val + hexF (-c).val) = 0 →
    gF (A - c) - hexF (-c).val = 0 →
    κ = 4 ∧ ((A = 5 ∧ c = 5) ∨ (A = 0 ∧ c = 1)) := by
  intro A c κ hκ h1 h2
  rcases hκ with rfl | rfl
  · refine ⟨rfl, ?_⟩
    revert h1 h2
    revert A c
    decide
  · exfalso
    revert h1 h2
    revert A c
    decide

/-- The oo `μ = 1` boundary, `(b, d) = (2, −1)` frame: heights (2, 3) against height 1,
both κ refused (the realizable address relation `x₃ = x₁ + y` is what kills it). -/
private theorem oo_end_mu1_pos : ∀ (A c : ZMod 6) (κ : ℤ), κ = 4 ∨ κ = 7 →
    ¬ (-5 * gE A - 2 * gF A + (-8 * gE (A - c) - 5 * gF (A - c))
          = 3 * (κ + (hexE (-c).val + hexF (-c).val))
        ∧ gF A + -2 * gF (A - c) = 3 * hexF (-c).val) := by
  intro A c κ hκ
  rcases hκ with rfl | rfl
  · revert A c; decide
  · revert A c; decide

/-- The oo `μ = 1` boundary, `(b, d) = (−2, 1)` frame. -/
private theorem oo_end_mu1_neg : ∀ (A c : ZMod 6) (κ : ℤ), κ = 4 ∨ κ = 7 →
    ¬ (-5 * gE (-A - 1) - 2 * gF (-A - 1)
          + (-8 * gE (-(A - c) - 1) - 5 * gF (-(A - c) - 1))
          = 3 * (κ + (hexE c.val + hexF c.val))
        ∧ gF (-A - 1) + -2 * gF (-(A - c) - 1) = 3 * hexF c.val) := by
  intro A c κ hκ
  rcases hκ with rfl | rfl
  · revert A c; decide
  · revert A c; decide

/-- **The oo classification**: the κ-master identity forces κ = 4, `b = 0`, `d = ±1`
and the two address pairs — for κ = 7 (the fusion constant) it refuses outright, so
the outer lattices of a pivot and the metapivot share no point. -/
private theorem oo_classify {A c : ZMod 6} {b d : ℤ} {κ : ℤ} (hκ : κ = 4 ∨ κ = 7)
    (h : gTr A b + ((Real.sqrt 3 : ℝ) : ℂ) * gTr (A - c) (b - d)
      = (κ : ℂ) + ((Real.sqrt 3 : ℝ) : ℂ) * uTr c d) :
    κ = 4 ∧ b = 0 ∧ (d = 1 ∨ d = -1) ∧ ((A = 5 ∧ c = 5) ∨ (A = 0 ∧ c = 1)) := by
  obtain ⟨t, ht⟩ : ∃ t, b.natAbs + d.natAbs = (b - d).natAbs + 2 * t :=
    ⟨(b.natAbs + d.natAbs - (b - d).natAbs) / 2, by omega⟩
  have hcl := oo_cleared ht h
  obtain ⟨ν, hν⟩ : ∃ ν, d.natAbs = 2 * ν ∨ d.natAbs = 2 * ν + 1 := ⟨d.natAbs / 2, by omega⟩
  obtain ⟨μ, hμ⟩ : ∃ μ, b.natAbs = 2 * μ ∨ b.natAbs = 2 * μ + 1 := ⟨b.natAbs / 2, by omega⟩
  rcases hμ with hμ | hμ
  · rcases hν with hν | hν
    · -- (even, even): the ring part reads `H₁ = κ·3^μ`, dead on the value table / pin
      exfalso
      rw [hν, hμ, show 2 * μ + 2 * ν = 2 * (μ + ν) by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace ν _ _ _).add
          ((InRing.intSmul κ (inRing_three_pow (μ + ν))).neg))
        ((inRing_pow_trace t _ _ _).add ((inRing_pow_trace μ _ _ _).neg))
        (show ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
              + -((κ : ℂ) * (3 : ℂ) ^ (μ + ν)))
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ t
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs
                + -((3 : ℂ) ^ μ
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν))) = 0 by
          linear_combination hcl)
      have hH1 : hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
          = ((κ * 3 ^ μ : ℤ) : ℂ) := by
        refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
        push_cast
        linear_combination hX
      rcases Nat.eq_zero_or_pos μ with hμ0 | hμp
      · subst hμ0
        rw [show 2 * 0 = 0 from rfl, hexTrace_zero_height,
          show (κ * 3 ^ 0 : ℤ) = κ by ring] at hH1
        exact g_zero_ne_kappa (gAddr A b) κ (by tauto) (by exact_mod_cast hH1)
      · exact g_pin_kill (by omega) hH1
    · -- (even, odd): THE LIVE CLASS
      rw [hν, hμ, show 2 * μ + (2 * ν + 1) = 2 * (μ + ν) + 1 by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      have hdiv : (3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
          + (3 : ℂ) ^ t
            * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
              (b - d).natAbs
          = (κ : ℂ) * 3 ^ (μ + ν)
            + (3 : ℂ) ^ μ
              * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1) := by
        refine mul_left_cancel₀ sqrt3_ne ?_
        linear_combination hcl
      rcases Nat.eq_zero_or_pos t with ht0 | htp
      · subst ht0
        rcases Nat.eq_zero_or_pos ν with hν0 | hνp
        · -- ν = 0: `d = ±1`, `k = 2μ+1` — the endgame family
          subst hν0
          rcases Nat.eq_zero_or_pos μ with hμ0 | hμp
          · -- μ = 0: the boundary — the four census chords, or the κ = 7 refusal
            subst hμ0
            obtain rfl : b = 0 := by omega
            obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv
            rcases (by omega : d = 1 ∨ d = -1) with rfl | rfl
            · rw [show ((0 : ℤ) - 1).natAbs = 1 from rfl,
                show gAddr A 0 = A from by rw [gAddr, if_pos le_rfl],
                show gAddr (A - c) ((0 : ℤ) - 1) = -(A - c) - 1 from by
                  rw [gAddr, if_neg (by norm_num)],
                show uAddr c 1 = c from by rw [uAddr, if_pos (by norm_num)],
                show (2 * 0 : ℕ) = 0 from rfl, show (2 * 0 + 1 : ℕ) = 1 from rfl,
                show (piCoeff 0).1 = 1 from rfl, show (piCoeff 0).2 = 0 from rfl,
                show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at R1
              rw [show ((0 : ℤ) - 1).natAbs = 1 from rfl,
                show gAddr (A - c) ((0 : ℤ) - 1) = -(A - c) - 1 from by
                  rw [gAddr, if_neg (by norm_num)],
                show uAddr c 1 = c from by rw [uAddr, if_pos (by norm_num)],
                show (2 * 0 : ℕ) = 0 from rfl, show (2 * 0 + 1 : ℕ) = 1 from rfl,
                show (piCoeff 0).2 = 0 from rfl,
                show (piCoeff 1).2 = 1 from rfl] at R2
              obtain ⟨hκ4, hAc⟩ := oo_end_pos A c κ hκ (by linear_combination R1)
                (by linear_combination R2)
              exact ⟨hκ4, rfl, Or.inl rfl, hAc⟩
            · rw [show ((0 : ℤ) - -1).natAbs = 1 from rfl,
                show gAddr A 0 = A from by rw [gAddr, if_pos le_rfl],
                show gAddr (A - c) ((0 : ℤ) - -1) = A - c from by
                  rw [gAddr, if_pos (by norm_num)],
                show uAddr c (-1) = -c from by rw [uAddr, if_neg (by norm_num)],
                show (2 * 0 : ℕ) = 0 from rfl, show (2 * 0 + 1 : ℕ) = 1 from rfl,
                show (piCoeff 0).1 = 1 from rfl, show (piCoeff 0).2 = 0 from rfl,
                show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at R1
              rw [show ((0 : ℤ) - -1).natAbs = 1 from rfl,
                show gAddr (A - c) ((0 : ℤ) - -1) = A - c from by
                  rw [gAddr, if_pos (by norm_num)],
                show uAddr c (-1) = -c from by rw [uAddr, if_neg (by norm_num)],
                show (2 * 0 : ℕ) = 0 from rfl, show (2 * 0 + 1 : ℕ) = 1 from rfl,
                show (piCoeff 0).2 = 0 from rfl,
                show (piCoeff 1).2 = 1 from rfl] at R2
              obtain ⟨hκ4, hAc⟩ := oo_end_neg A c κ hκ (by linear_combination R1)
                (by linear_combination R2)
              exact ⟨hκ4, rfl, Or.inr rfl, hAc⟩
          · exfalso
            obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv
            have hk1 : (b - d).natAbs = 2 * μ + 1 := by omega
            rw [hk1] at R1 R2
            rcases (by omega : μ = 1 ∨ 2 ≤ μ) with rfl | hμ2
            · -- μ = 1: heights (2, 3) — the finite check refuses both κ
              rw [show (2 * 1 : ℕ) = 2 from rfl, show (2 * 1 + 1 : ℕ) = 3 from rfl,
                show (2 * 0 + 1 : ℕ) = 1 from rfl,
                show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl,
                show (piCoeff 3).1 = -3 from rfl, show (piCoeff 3).2 = -2 from rfl,
                show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at R1
              rw [show (2 * 1 : ℕ) = 2 from rfl, show (2 * 1 + 1 : ℕ) = 3 from rfl,
                show (2 * 0 + 1 : ℕ) = 1 from rfl,
                show (piCoeff 2).2 = 1 from rfl, show (piCoeff 3).2 = -2 from rfl,
                show (piCoeff 1).2 = 1 from rfl] at R2
              rcases (by omega : (b = 2 ∧ d = -1) ∨ (b = -2 ∧ d = 1)) with ⟨rfl, rfl⟩ |
                ⟨rfl, rfl⟩
              · rw [show gAddr A 2 = A from by rw [gAddr, if_pos (by norm_num)],
                  show gAddr (A - c) ((2 : ℤ) - -1) = A - c from by
                    rw [gAddr, if_pos (by norm_num)],
                  show uAddr c (-1) = -c from by rw [uAddr, if_neg (by norm_num)]] at R1 R2
                exact oo_end_mu1_pos A c κ hκ ⟨by linear_combination R1,
                  by linear_combination R2⟩
              · rw [show gAddr A (-2) = -A - 1 from by rw [gAddr, if_neg (by norm_num)],
                  show gAddr (A - c) ((-2 : ℤ) - 1) = -(A - c) - 1 from by
                    rw [gAddr, if_neg (by norm_num)],
                  show uAddr c 1 = c from by rw [uAddr, if_pos (by norm_num)]] at R1 R2
                exact oo_end_mu1_neg A c κ hκ ⟨by linear_combination R1,
                  by linear_combination R2⟩
            · -- μ ≥ 2: the adjacent-heights kill
              refine adjacent_kill (gAddr A b) (gAddr (A - c) (b - d)) (h := 2 * μ)
                (e := μ) (by omega) (by omega)
                (W₁ := κ + (hexE (uAddr c d).val * (piCoeff (2 * 0 + 1)).1
                  + (hexE (uAddr c d).val + hexF (uAddr c d).val)
                    * ((piCoeff (2 * 0 + 1)).1 + (piCoeff (2 * 0 + 1)).2)))
                (W₂ := hexF (uAddr c d).val * (piCoeff (2 * 0 + 1)).2) ?_ ?_
              · linear_combination R1
              · linear_combination R2
        · -- ν ≥ 1 (so `|d| ≥ 3`): dead at the bottom level
          exfalso
          obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv
          rcases Nat.eq_zero_or_pos μ with hμ0 | hμp
          · -- b = 0: the φ kill on the minimal pair {H₃, H₂}
            subst hμ0
            obtain ⟨w₁, hw₁⟩ := phi_g_dvd (gAddr A b) (2 * 0)
            obtain ⟨w₃, hw₃⟩ := phi_g_dvd (gAddr (A - c) (b - d)) ((b - d).natAbs)
            obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
            refine hex_diff_ne (uAddr c d) (phi_dvd (r := 2 * (ν' + 1) + 1) (by omega)
              (S := 3 ^ (ν' + 1) * w₁ + w₃ - κ * 3 ^ ν') ?_)
            linear_combination -R1 - R2 + (3 : ℤ) ^ (ν' + 1) * hw₁ + hw₃
          · -- b ≠ 0: the cross trace stands alone at the bottom
            obtain ⟨μ', rfl⟩ : ∃ μ', μ = μ' + 1 := ⟨μ - 1, by omega⟩
            obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
            refine gE_gF_ne (gAddr (A - c) (b - d))
              (alone_dvd (p := (b - d).natAbs) (by omega)
                (R₁ := κ * 3 ^ (μ' + 1 + ν')
                    + 3 ^ μ' * (hexE (uAddr c d).val * (piCoeff (2 * (ν' + 1) + 1)).1
                      + (hexE (uAddr c d).val + hexF (uAddr c d).val)
                        * ((piCoeff (2 * (ν' + 1) + 1)).1
                          + (piCoeff (2 * (ν' + 1) + 1)).2))
                  - 3 ^ ν' * (gE (gAddr A b) * (piCoeff (2 * (μ' + 1))).1
                      + (gE (gAddr A b) + gF (gAddr A b))
                        * ((piCoeff (2 * (μ' + 1))).1 + (piCoeff (2 * (μ' + 1))).2)))
                (R₂ := 3 ^ μ' * (hexF (uAddr c d).val * (piCoeff (2 * (ν' + 1) + 1)).2)
                  - 3 ^ ν' * (gF (gAddr A b) * (piCoeff (2 * (μ' + 1))).2))
                ?_ ?_)
            · linear_combination R1
            · linear_combination R2
      · -- same seam signs: the pivot trace alone (n < m) or the φ kill (n > m)
        exfalso
        rcases (by omega : ν < μ ∨ μ ≤ ν) with hlt | hge
        · -- n < m: the pivot trace alone after dividing by `3^ν`
          obtain ⟨t', rfl⟩ : ∃ t', t = ν + 1 + t' := ⟨t - ν - 1, by omega⟩
          obtain ⟨μ', rfl⟩ : ∃ μ', μ = ν + 1 + μ' := ⟨μ - ν - 1, by omega⟩
          have hdiv' : (3 : ℂ) ^ 0
              * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * (ν + 1 + μ'))
              + (3 : ℂ) ^ (1 + t')
                * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                  (b - d).natAbs
              = (κ : ℂ) * 3 ^ (1 + μ' + ν)
                + (3 : ℂ) ^ (1 + μ')
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val)
                    (2 * ν + 1) := by
            refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
            linear_combination hdiv
          obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv'
          refine gE_gF_ne (gAddr A b) (alone_dvd (p := 2 * (ν + 1 + μ')) (by omega)
            (R₁ := κ * 3 ^ (μ' + ν)
                + 3 ^ μ' * (hexE (uAddr c d).val * (piCoeff (2 * ν + 1)).1
                  + (hexE (uAddr c d).val + hexF (uAddr c d).val)
                    * ((piCoeff (2 * ν + 1)).1 + (piCoeff (2 * ν + 1)).2))
              - 3 ^ t' * (gE (gAddr (A - c) (b - d)) * (piCoeff (b - d).natAbs).1
                  + (gE (gAddr (A - c) (b - d)) + gF (gAddr (A - c) (b - d)))
                    * ((piCoeff (b - d).natAbs).1 + (piCoeff (b - d).natAbs).2)))
            (R₂ := 3 ^ μ' * (hexF (uAddr c d).val * (piCoeff (2 * ν + 1)).2)
              - 3 ^ t' * (gF (gAddr (A - c) (b - d)) * (piCoeff (b - d).natAbs).2))
            ?_ ?_)
          · linear_combination R1
          · linear_combination R2
        · -- n > m: the φ kill after dividing by `3^μ` (`t = 2μ`, `μ ≥ 1`)
          obtain ⟨i', rfl⟩ : ∃ i', ν = μ + i' := ⟨ν - μ, by omega⟩
          have htv : t = 2 * μ := by omega
          subst htv
          have hdiv' : (3 : ℂ) ^ i'
              * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
              + (3 : ℂ) ^ μ
                * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                  (b - d).natAbs
              = (κ : ℂ) * 3 ^ (μ + i')
                + (3 : ℂ) ^ 0
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val)
                    (2 * (μ + i') + 1) := by
            refine mul_left_cancel₀ (pow_ne_zero μ (by norm_num : (3 : ℂ) ≠ 0)) ?_
            linear_combination hdiv
          obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv'
          obtain ⟨w₁, hw₁⟩ := phi_g_dvd (gAddr A b) (2 * μ)
          obtain ⟨w₃, hw₃⟩ := phi_g_dvd (gAddr (A - c) (b - d)) ((b - d).natAbs)
          obtain ⟨μ'', rfl⟩ : ∃ μ'', μ = μ'' + 1 := ⟨μ - 1, by omega⟩
          refine hex_diff_ne (uAddr c d)
            (phi_dvd (r := 2 * (μ'' + 1 + i') + 1) (by omega)
              (S := 3 ^ i' * w₁ + 3 ^ (μ'' + 1) * w₃ - κ * 3 ^ (μ'' + i')) ?_)
          linear_combination -R1 - R2 + (3 : ℤ) ^ i' * hw₁ + (3 : ℤ) ^ (μ'' + 1) * hw₃
  · rcases hν with hν | hν
    · -- (odd, even): the separated `√3` part reads `3^t·H₃ = κ·3^(μ+ν)`, dead on the pin
      exfalso
      rw [hν, hμ, show 2 * μ + 1 + 2 * ν = 2 * (μ + ν) + 1 by ring,
        show 2 * μ + 1 + 1 = 2 * (μ + 1) by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨-, hY⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace ν _ _ _).add ((inRing_pow_trace (μ + 1) _ _ _).neg))
        ((inRing_pow_trace t _ _ _).add
          ((InRing.intSmul κ (inRing_three_pow (μ + ν))).neg))
        (show ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
              + -((3 : ℂ) ^ (μ + 1)
                * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν)))
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ t
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs
                + -((κ : ℂ) * (3 : ℂ) ^ (μ + ν))) = 0 by
          linear_combination hcl)
      obtain ⟨e', he'⟩ : ∃ e', μ + ν = t + e' := ⟨μ + ν - t, by omega⟩
      have hH3 : hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
          (b - d).natAbs = ((κ * 3 ^ e' : ℤ) : ℂ) := by
        refine mul_left_cancel₀ (pow_ne_zero t (by norm_num : (3 : ℂ) ≠ 0)) ?_
        rw [he'] at hY
        push_cast
        linear_combination hY + (κ : ℂ) * (pow_add (3 : ℂ) t e').symm
      exact g_pin_kill (by omega) hH3
    · -- (odd, odd): the separated ring part reads `3^(μ+1)·H₂ = −κ·3^(μ+ν+1)`
      exfalso
      rw [hν, hμ, show 2 * μ + 1 + (2 * ν + 1) = 2 * (μ + ν + 1) by ring,
        show 2 * μ + 1 + 1 = 2 * (μ + 1) by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
        (((InRing.intSmul κ (inRing_three_pow (μ + ν + 1))).neg).add
          ((inRing_pow_trace (μ + 1) _ _ _).neg))
        ((inRing_pow_trace ν _ _ _).add (inRing_pow_trace t _ _ _))
        (show (-((κ : ℂ) * (3 : ℂ) ^ (μ + ν + 1))
              + -((3 : ℂ) ^ (μ + 1)
                * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1)))
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
                + (3 : ℂ) ^ t
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs) = 0 by
          linear_combination hcl)
      have hH2 : hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1)
          = ((-κ * 3 ^ ν : ℤ) : ℂ) := by
        refine mul_left_cancel₀ (pow_ne_zero (μ + 1) (by norm_num : (3 : ℂ) ≠ 0)) ?_
        push_cast
        linear_combination -hX - (κ : ℂ) * (pow_add (3 : ℂ) (μ + 1) ν).symm
      rcases Nat.eq_zero_or_pos ν with hν0 | hνp
      · subst hν0
        rw [show (2 * 0 + 1 : ℕ) = 1 from rfl,
          show (-κ * 3 ^ 0 : ℤ) = -κ by ring] at hH2
        have := u_pin_one hH2
        omega
      · obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
        rw [show (-κ * 3 ^ (ν' + 1) : ℤ) = 3 * (-κ * 3 ^ ν') by ring] at hH2
        exact u_pin_kill_dvd (by omega) hH2

/-- The 120° rotation about the metapivot is injective. -/
private theorem metaRot_inj {z w : ℂ}
    (h : metaPivot + zeta6 ^ 2 * (z - metaPivot)
      = metaPivot + zeta6 ^ 2 * (w - metaPivot)) : z = w := by
  have hd := dist_metaRot z w
  rw [h, dist_self] at hd
  exact dist_eq_zero.mp hd.symm

/-- The master web (j = 0) oo completeness, both directions. -/
private theorem meta_oo_zero (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (outerPt 0 1 a b) (outerPt metaPivot metaAnchor c d) = 1 ↔
      (a, b, c, d) ∈ metaOOTable := by
  constructor
  · intro h
    obtain ⟨-, rfl, hd, hAc⟩ := oo_classify (Or.inl rfl)
      (oo_master (R := 3) (κ := 4) (by norm_num) ((bridge_oo a b c d).mp h))
    have ha : (a = 0 ∧ c = 5) ∨ (a = 1 ∧ c = 1) := by
      rcases hAc with ⟨h1, rfl⟩ | ⟨h1, rfl⟩
      · exact Or.inl ⟨by rw [eq_add_of_sub_eq h1]; decide, rfl⟩
      · exact Or.inr ⟨by rw [eq_add_of_sub_eq h1]; decide, rfl⟩
    rcases ha with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> rcases hd with rfl | rfl <;> decide
  · intro hm
    fin_cases hm
    · -- (0, 0, 5, -1)
      rw [bridge_oo, show (1 : ℂ) = ((1 : ℝ) : ℂ) by norm_num]
      refine web_master_rev ?_
      have h0 := gTr_zero (0 - 1 : ZMod 6)
      rw [show (2 * gE (0 - 1 : ZMod 6) + gF (0 - 1 : ZMod 6) : ℤ) = 3 from by decide] at h0
      have h3 := gTrace_clear (0 - 1 - 5 : ZMod 6) ((0 : ℤ) - -1)
      rw [show ((0 : ℤ) - -1).natAbs = 1 from rfl, pow_one,
        show gAddr (0 - 1 - 5 : ZMod 6) ((0 : ℤ) - -1) = 0 from by decide,
        show gE (0 : ZMod 6) = 1 from by decide,
        show gF (0 : ZMod 6) = 1 from by decide] at h3
      have h2 := uTrace_clear (5 : ZMod 6) (-1 : ℤ)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show uAddr (5 : ZMod 6) (-1) = 1 from by decide,
        show hexE (1 : ZMod 6).val = 0 from by decide,
        show hexF (1 : ZMod 6).val = 1 from by decide] at h2
      have c3 := hexTrace_coords 1 1 1
      have c2 := hexTrace_coords 0 1 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c3 c2
      linear_combination (norm := (push_cast; ring)) -h0 - h3 + h2 - c3 + c2 + sqrt3_cast_sq
    · -- (0, 0, 5, 1)
      rw [bridge_oo, show (1 : ℂ) = ((1 : ℝ) : ℂ) by norm_num]
      refine web_master_rev ?_
      have h0 := gTr_zero (0 - 1 : ZMod 6)
      rw [show (2 * gE (0 - 1 : ZMod 6) + gF (0 - 1 : ZMod 6) : ℤ) = 3 from by decide] at h0
      have h3 := gTrace_clear (0 - 1 - 5 : ZMod 6) ((0 : ℤ) - 1)
      rw [show ((0 : ℤ) - 1).natAbs = 1 from rfl, pow_one,
        show gAddr (0 - 1 - 5 : ZMod 6) ((0 : ℤ) - 1) = 5 from by decide,
        show gE (5 : ZMod 6) = 2 from by decide,
        show gF (5 : ZMod 6) = -1 from by decide] at h3
      have h2 := uTrace_clear (5 : ZMod 6) (1 : ℤ)
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show uAddr (5 : ZMod 6) 1 = 5 from by decide,
        show hexE (5 : ZMod 6).val = 1 from by decide,
        show hexF (5 : ZMod 6).val = -1 from by decide] at h2
      have c3 := hexTrace_coords 2 (-1) 1
      have c2 := hexTrace_coords 1 (-1) 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c3 c2
      linear_combination (norm := (push_cast; ring)) -h0 - h3 + h2 - c3 + c2 + sqrt3_cast_sq
    · -- (1, 0, 1, -1)
      rw [bridge_oo, show (1 : ℂ) = ((1 : ℝ) : ℂ) by norm_num]
      refine web_master_rev ?_
      have h0 := gTr_zero (1 - 1 : ZMod 6)
      rw [show (2 * gE (1 - 1 : ZMod 6) + gF (1 - 1 : ZMod 6) : ℤ) = 3 from by decide] at h0
      have h3 := gTrace_clear (1 - 1 - 1 : ZMod 6) ((0 : ℤ) - -1)
      rw [show ((0 : ℤ) - -1).natAbs = 1 from rfl, pow_one,
        show gAddr (1 - 1 - 1 : ZMod 6) ((0 : ℤ) - -1) = 5 from by decide,
        show gE (5 : ZMod 6) = 2 from by decide,
        show gF (5 : ZMod 6) = -1 from by decide] at h3
      have h2 := uTrace_clear (1 : ZMod 6) (-1 : ℤ)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show uAddr (1 : ZMod 6) (-1) = 5 from by decide,
        show hexE (5 : ZMod 6).val = 1 from by decide,
        show hexF (5 : ZMod 6).val = -1 from by decide] at h2
      have c3 := hexTrace_coords 2 (-1) 1
      have c2 := hexTrace_coords 1 (-1) 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c3 c2
      linear_combination (norm := (push_cast; ring)) -h0 - h3 + h2 - c3 + c2 + sqrt3_cast_sq
    · -- (1, 0, 1, 1)
      rw [bridge_oo, show (1 : ℂ) = ((1 : ℝ) : ℂ) by norm_num]
      refine web_master_rev ?_
      have h0 := gTr_zero (1 - 1 : ZMod 6)
      rw [show (2 * gE (1 - 1 : ZMod 6) + gF (1 - 1 : ZMod 6) : ℤ) = 3 from by decide] at h0
      have h3 := gTrace_clear (1 - 1 - 1 : ZMod 6) ((0 : ℤ) - 1)
      rw [show ((0 : ℤ) - 1).natAbs = 1 from rfl, pow_one,
        show gAddr (1 - 1 - 1 : ZMod 6) ((0 : ℤ) - 1) = 0 from by decide,
        show gE (0 : ZMod 6) = 1 from by decide,
        show gF (0 : ZMod 6) = 1 from by decide] at h3
      have h2 := uTrace_clear (1 : ZMod 6) (1 : ℤ)
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show uAddr (1 : ZMod 6) 1 = 1 from by decide,
        show hexE (1 : ZMod 6).val = 0 from by decide,
        show hexF (1 : ZMod 6).val = 1 from by decide] at h2
      have c3 := hexTrace_coords 1 1 1
      have c2 := hexTrace_coords 0 1 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c3 c2
      linear_combination (norm := (push_cast; ring)) -h0 - h3 + h2 - c3 + c2 + sqrt3_cast_sq

/-- **oo completeness at the metaPivot axis, all three webs**: exactly the four table
chords per web — the θσ resistance leaves no infinite family. -/
theorem meta_oo_complete (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (outerPt (pivot j) (pivot j + 1) a b) (outerPt metaPivot metaAnchor c d) = 1 ↔
      (a - webShift j, b, c - webShift j, d) ∈ metaOOTable := by
  fin_cases j
  · show dist (outerPt (pivot 0) (pivot 0 + 1) a b) (outerPt metaPivot metaAnchor c d) = 1
      ↔ (a - webShift 0, b, c - webShift 0, d) ∈ metaOOTable
    rw [pivot_zero, zero_add, show webShift 0 = 0 from rfl, sub_zero, sub_zero]
    exact meta_oo_zero a b c d
  · show dist (outerPt (pivot 1) (pivot 1 + 1) a b) (outerPt metaPivot metaAnchor c d) = 1
      ↔ (a - webShift 1, b, c - webShift 1, d) ∈ metaOOTable
    have h1 : outerPt (pivot 1) (pivot 1 + 1) a b
        = metaPivot + zeta6 ^ 2 * (outerPt (pivot 0) (pivot 0 + 1) (a - 2) b - metaPivot) := by
      rw [web_transport_rot 0 (a - 2) b, sub_add_cancel,
        show (0 + 1 : Fin 3) = 1 from by decide]
    have h2 : outerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (outerPt metaPivot metaAnchor (c - 2) d - metaPivot) := by
      rw [web_transport_rot_meta (c - 2) d, sub_add_cancel]
    rw [h1, h2, dist_metaRot, pivot_zero, zero_add, show webShift 1 = 2 from rfl]
    exact meta_oo_zero (a - 2) b (c - 2) d
  · show dist (outerPt (pivot 2) (pivot 2 + 1) a b) (outerPt metaPivot metaAnchor c d) = 1
      ↔ (a - webShift 2, b, c - webShift 2, d) ∈ metaOOTable
    have h1 : outerPt (pivot 2) (pivot 2 + 1) a b
        = metaPivot + zeta6 ^ 2 * (outerPt (pivot 1) (pivot 1 + 1) (a - 2) b - metaPivot) := by
      rw [web_transport_rot 1 (a - 2) b, sub_add_cancel,
        show (1 + 1 : Fin 3) = 2 from by decide]
    have h2 : outerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (outerPt metaPivot metaAnchor (c - 2) d - metaPivot) := by
      rw [web_transport_rot_meta (c - 2) d, sub_add_cancel]
    have h1' : outerPt (pivot 1) (pivot 1 + 1) (a - 2) b
        = metaPivot + zeta6 ^ 2
          * (outerPt (pivot 0) (pivot 0 + 1) (a - 2 - 2) b - metaPivot) := by
      rw [web_transport_rot 0 (a - 2 - 2) b, sub_add_cancel,
        show (0 + 1 : Fin 3) = 1 from by decide]
    have h2' : outerPt metaPivot metaAnchor (c - 2) d
        = metaPivot + zeta6 ^ 2
          * (outerPt metaPivot metaAnchor (c - 2 - 2) d - metaPivot) := by
      rw [web_transport_rot_meta (c - 2 - 2) d, sub_add_cancel]
    rw [h1, h2, dist_metaRot, h1', h2', dist_metaRot, pivot_zero, zero_add,
      show (a - webShift 2 : ZMod 6) = a - 2 - 2 from by
        rw [show webShift 2 = 4 from rfl]; ring,
      show (c - webShift 2 : ZMod 6) = c - 2 - 2 from by
        rw [show webShift 2 = 4 from rfl]; ring]
    exact meta_oo_zero (a - 2 - 2) b (c - 2 - 2) d

/-- **The oo fusion is empty**: a pivot's outer lattice and the metapivot's outer
lattice share no point (the κ = 7 refusal). -/
theorem meta_fusion_oo (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    outerPt (pivot j) (pivot j + 1) a b ≠ outerPt metaPivot metaAnchor c d := by
  have hzero : ∀ (a' c' : ZMod 6) (b' d' : ℤ),
      outerPt 0 1 a' b' ≠ outerPt metaPivot metaAnchor c' d' := by
    intro a' c' b' d' he
    obtain ⟨h74, -⟩ := oo_classify (Or.inr rfl)
      (oo_master (R := 0) (κ := 7) (by norm_num) ((fusion_bridge_oo a' b' c' d').mp he))
    norm_num at h74
  fin_cases j
  · show outerPt (pivot 0) (pivot 0 + 1) a b ≠ outerPt metaPivot metaAnchor c d
    rw [pivot_zero, zero_add]
    exact hzero a c b d
  · show outerPt (pivot 1) (pivot 1 + 1) a b ≠ outerPt metaPivot metaAnchor c d
    intro he
    rw [show outerPt (pivot 1) (pivot 1 + 1) a b
        = metaPivot + zeta6 ^ 2 * (outerPt (pivot 0) (pivot 0 + 1) (a - 2) b - metaPivot)
        from by rw [web_transport_rot 0 (a - 2) b, sub_add_cancel,
          show (0 + 1 : Fin 3) = 1 from by decide],
      show outerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (outerPt metaPivot metaAnchor (c - 2) d - metaPivot)
        from by rw [web_transport_rot_meta (c - 2) d, sub_add_cancel]] at he
    exact hzero (a - 2) (c - 2) b d (by
      have := metaRot_inj he
      rwa [pivot_zero, zero_add] at this)
  · show outerPt (pivot 2) (pivot 2 + 1) a b ≠ outerPt metaPivot metaAnchor c d
    intro he
    rw [show outerPt (pivot 2) (pivot 2 + 1) a b
        = metaPivot + zeta6 ^ 2 * (outerPt (pivot 1) (pivot 1 + 1) (a - 2) b - metaPivot)
        from by rw [web_transport_rot 1 (a - 2) b, sub_add_cancel,
          show (1 + 1 : Fin 3) = 2 from by decide],
      show outerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (outerPt metaPivot metaAnchor (c - 2) d - metaPivot)
        from by rw [web_transport_rot_meta (c - 2) d, sub_add_cancel]] at he
    have he1 := metaRot_inj he
    rw [show outerPt (pivot 1) (pivot 1 + 1) (a - 2) b
        = metaPivot + zeta6 ^ 2
          * (outerPt (pivot 0) (pivot 0 + 1) (a - 2 - 2) b - metaPivot)
        from by rw [web_transport_rot 0 (a - 2 - 2) b, sub_add_cancel,
          show (0 + 1 : Fin 3) = 1 from by decide],
      show outerPt metaPivot metaAnchor (c - 2) d
        = metaPivot + zeta6 ^ 2
          * (outerPt metaPivot metaAnchor (c - 2 - 2) d - metaPivot)
        from by rw [web_transport_rot_meta (c - 2 - 2) d, sub_add_cancel]] at he1
    exact hzero (a - 2 - 2) (c - 2 - 2) b d (by
      have := metaRot_inj he1
      rwa [pivot_zero, zero_add] at this)

/-! ### §W.15 The io family: `inner(pivot) ↔ outer(meta)`, κ ∈ {2, 5} -/

/-- The io cleared equation. -/
private theorem io_cleared {A c : ZMod 6} {b d : ℤ} {t : ℕ} {κ : ℤ}
    (ht : b.natAbs + d.natAbs = (b - d).natAbs + 2 * t)
    (h : gTr A b + ((Real.sqrt 3 : ℝ) : ℂ) * gTr (A - c) (b - d)
      = (κ : ℂ) * ((Real.sqrt 3 : ℝ) : ℂ) + 3 * uTr c d) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ d.natAbs
        * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) b.natAbs
      + ((Real.sqrt 3 : ℝ) : ℂ) * ((3 : ℂ) ^ t
          * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
            (b - d).natAbs)
      = (κ : ℂ) * ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs + 1)
        + 3 * (((Real.sqrt 3 : ℝ) : ℂ) ^ b.natAbs
          * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) d.natAbs) := by
  have hA := gTrace_clear A b
  have hB := gTrace_clear (A - c) (b - d)
  have hC := uTrace_clear c d
  have hsum : ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs)
      * (gTr A b + ((Real.sqrt 3 : ℝ) : ℂ) * gTr (A - c) (b - d))
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs)
        * ((κ : ℂ) * ((Real.sqrt 3 : ℝ) : ℂ) + 3 * uTr c d) := by rw [h]
  have hpow2 : ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * t) * ((Real.sqrt 3 : ℝ) : ℂ) ^ (b - d).natAbs
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs) := by
    rw [← pow_add, show 2 * t + (b - d).natAbs = b.natAbs + d.natAbs by omega]
  rw [← hA, ← hB, ← hC, ← sqrt3_pow_two_mul t, pow_succ]
  linear_combination hsum + ((Real.sqrt 3 : ℝ) : ℂ) * gTr (A - c) (b - d) * hpow2

/-- The io boundary decide, `(b, d) = (1, −1)` frame: κ = 2 pins the pairs, κ = 5
refuses. -/
private theorem io_end_pos : ∀ (A c : ZMod 6) (κ : ℤ), κ = 2 ∨ κ = 5 →
    gE A + gF A + (-5 * gE (A - c) - 2 * gF (A - c))
        - 3 * κ - 3 * (hexE (-c).val + hexF (-c).val) = 0 →
    gF A + gF (A - c) - 3 * hexF (-c).val = 0 →
    κ = 2 ∧ ((A = 1 ∧ c = 5) ∨ (A = 4 ∧ c = 1)) := by
  intro A c κ hκ h1 h2
  rcases hκ with rfl | rfl
  · refine ⟨rfl, ?_⟩
    revert h1 h2
    revert A c
    decide
  · exfalso
    revert h1 h2
    revert A c
    decide

/-- The io boundary decide, `(b, d) = (−1, 1)` frame. -/
private theorem io_end_neg : ∀ (A c : ZMod 6) (κ : ℤ), κ = 2 ∨ κ = 5 →
    gE (-A - 1) + gF (-A - 1) + (-5 * gE (-(A - c) - 1) - 2 * gF (-(A - c) - 1))
        - 3 * κ - 3 * (hexE c.val + hexF c.val) = 0 →
    gF (-A - 1) + gF (-(A - c) - 1) - 3 * hexF c.val = 0 →
    κ = 2 ∧ ((A = 1 ∧ c = 5) ∨ (A = 4 ∧ c = 1)) := by
  intro A c κ hκ h1 h2
  rcases hκ with rfl | rfl
  · refine ⟨rfl, ?_⟩
    revert h1 h2
    revert A c
    decide
  · exfalso
    revert h1 h2
    revert A c
    decide

/-- **The io classification**: κ = 2 forces `b = ±1`, `d = ∓1` and the two address
pairs; κ = 5 (the fusion constant) is refused — the 120°-partner glue points are never
lattice words. -/
private theorem io_classify {A c : ZMod 6} {b d : ℤ} {κ : ℤ} (hκ : κ = 2 ∨ κ = 5)
    (h : gTr A b + ((Real.sqrt 3 : ℝ) : ℂ) * gTr (A - c) (b - d)
      = (κ : ℂ) * ((Real.sqrt 3 : ℝ) : ℂ) + 3 * uTr c d) :
    κ = 2 ∧ ((b = 1 ∧ d = -1) ∨ (b = -1 ∧ d = 1)) ∧ ((A = 1 ∧ c = 5) ∨ (A = 4 ∧ c = 1)) := by
  obtain ⟨t, ht⟩ : ∃ t, b.natAbs + d.natAbs = (b - d).natAbs + 2 * t :=
    ⟨(b.natAbs + d.natAbs - (b - d).natAbs) / 2, by omega⟩
  have hcl := io_cleared ht h
  obtain ⟨ν, hν⟩ : ∃ ν, d.natAbs = 2 * ν ∨ d.natAbs = 2 * ν + 1 := ⟨d.natAbs / 2, by omega⟩
  obtain ⟨μ, hμ⟩ : ∃ μ, b.natAbs = 2 * μ ∨ b.natAbs = 2 * μ + 1 := ⟨b.natAbs / 2, by omega⟩
  rcases hμ with hμ | hμ
  · rcases hν with hν | hν
    · -- (even, even): the √3 part reads `3^t·H₃ = κ·3^(μ+ν)`, dead on the pin / values
      exfalso
      rw [hν, hμ, show 2 * μ + 2 * ν + 1 = 2 * (μ + ν) + 1 by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨-, hY⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace ν _ _ _).add
          (((InRing.intCast 3).mul (inRing_pow_trace μ _ _ _)).neg))
        ((inRing_pow_trace t _ _ _).add
          ((InRing.intSmul κ (inRing_three_pow (μ + ν))).neg))
        (show ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
              + -(((3 : ℤ) : ℂ)
                * ((3 : ℂ) ^ μ
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν))))
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ t
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs
                + -((κ : ℂ) * (3 : ℂ) ^ (μ + ν))) = 0 by
          push_cast
          linear_combination hcl)
      rcases Nat.eq_zero_or_pos (b - d).natAbs with hk0 | hkp
      · -- b = d: the height-0 value refuses κ
        have htμν : t = μ + ν := by omega
        subst htμν
        rw [hk0, hexTrace_zero_height] at hY
        have hval : (2 * gE (gAddr (A - c) (b - d)) + gF (gAddr (A - c) (b - d)) : ℤ)
            = κ := by
          have hc : ((2 * gE (gAddr (A - c) (b - d)) + gF (gAddr (A - c) (b - d)) : ℤ) : ℂ)
              = (κ : ℂ) := by
            refine mul_left_cancel₀ (pow_ne_zero (μ + ν) (by norm_num : (3 : ℂ) ≠ 0)) ?_
            linear_combination hY
          exact_mod_cast hc
        exact g_zero_ne_kappa (gAddr (A - c) (b - d)) κ (by tauto) hval
      · -- b ≠ d: the pin refuses
        obtain ⟨e', he'⟩ : ∃ e', μ + ν = t + e' := ⟨μ + ν - t, by omega⟩
        have hH3 : hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
            (b - d).natAbs = ((κ * 3 ^ e' : ℤ) : ℂ) := by
          refine mul_left_cancel₀ (pow_ne_zero t (by norm_num : (3 : ℂ) ≠ 0)) ?_
          rw [he'] at hY
          push_cast
          linear_combination hY + (κ : ℂ) * (pow_add (3 : ℂ) t e').symm
        exact g_pin_kill hkp hH3
    · -- (even, odd): the ring part reads `3^(μ+1)·H₂ = −κ·3^(μ+ν+1)`, dead on the pin
      exfalso
      rw [hν, hμ, show 2 * μ + (2 * ν + 1) + 1 = 2 * (μ + ν + 1) by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
        (((InRing.intSmul κ (inRing_three_pow (μ + ν + 1))).neg).add
          (((InRing.intCast 3).mul (inRing_pow_trace μ _ _ _)).neg))
        ((inRing_pow_trace ν _ _ _).add (inRing_pow_trace t _ _ _))
        (show (-((κ : ℂ) * (3 : ℂ) ^ (μ + ν + 1))
              + -(((3 : ℤ) : ℂ)
                * ((3 : ℂ) ^ μ
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1))))
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
                + (3 : ℂ) ^ t
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs) = 0 by
          push_cast
          linear_combination hcl)
      have hH2 : hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1)
          = ((-κ * 3 ^ ν : ℤ) : ℂ) := by
        refine mul_left_cancel₀ (pow_ne_zero (μ + 1) (by norm_num : (3 : ℂ) ≠ 0)) ?_
        push_cast
        linear_combination -hX - (κ : ℂ) * (pow_add (3 : ℂ) (μ + 1) ν).symm
      rcases Nat.eq_zero_or_pos ν with hν0 | hνp
      · subst hν0
        rw [show (2 * 0 + 1 : ℕ) = 1 from rfl,
          show (-κ * 3 ^ 0 : ℤ) = -κ by ring] at hH2
        have := u_pin_one hH2
        omega
      · obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
        rw [show (-κ * 3 ^ (ν' + 1) : ℤ) = 3 * (-κ * 3 ^ ν') by ring] at hH2
        exact u_pin_kill_dvd (by omega) hH2
  · rcases hν with hν | hν
    · -- (odd, even): the ring part reads `H₁ = κ·3^(μ+1)`, dead on the pin
      exfalso
      rw [hν, hμ, show 2 * μ + 1 + 2 * ν + 1 = 2 * (μ + ν + 1) by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace ν _ _ _).add
          ((InRing.intSmul κ (inRing_three_pow (μ + ν + 1))).neg))
        ((inRing_pow_trace t _ _ _).add
          (((InRing.intCast 3).mul (inRing_pow_trace μ _ _ _)).neg))
        (show ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
              + -((κ : ℂ) * (3 : ℂ) ^ (μ + ν + 1)))
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ t
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs
                + -(((3 : ℤ) : ℂ)
                  * ((3 : ℂ) ^ μ
                    * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν))))
            = 0 by
          push_cast
          linear_combination hcl)
      have hH1 : hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
          = ((κ * 3 ^ (μ + 1) : ℤ) : ℂ) := by
        refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
        push_cast
        linear_combination hX + (κ : ℂ) * (pow_add (3 : ℂ) ν (μ + 1)).symm
      exact g_pin_kill (by omega) hH1
    · -- (odd, odd): THE LIVE CLASS
      rw [hν, hμ, show 2 * μ + 1 + (2 * ν + 1) + 1 = 2 * (μ + ν + 1) + 1 by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      have hdiv : (3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
          + (3 : ℂ) ^ t
            * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
              (b - d).natAbs
          = (κ : ℂ) * 3 ^ (μ + ν + 1)
            + (3 : ℂ) ^ (μ + 1)
              * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1) := by
        refine mul_left_cancel₀ sqrt3_ne ?_
        push_cast
        linear_combination hcl
      rcases Nat.eq_zero_or_pos t with ht0 | htp
      · subst ht0
        rcases Nat.eq_zero_or_pos ν with hν0 | hνp
        · -- ν = 0: `d = ±1`, `k = 2μ+2` — the endgame family
          subst hν0
          rcases Nat.eq_zero_or_pos μ with hμ0 | hμp
          · -- μ = 0: the boundary — the four census chords, or the κ = 5 refusal
            subst hμ0
            obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv
            rcases (by omega : (b = 1 ∧ d = -1) ∨ (b = -1 ∧ d = 1)) with ⟨rfl, rfl⟩ |
              ⟨rfl, rfl⟩
            · rw [show ((1 : ℤ) - -1).natAbs = 2 from rfl,
                show gAddr A 1 = A from by rw [gAddr, if_pos (by norm_num)],
                show gAddr (A - c) ((1 : ℤ) - -1) = A - c from by
                  rw [gAddr, if_pos (by norm_num)],
                show uAddr c (-1) = -c from by rw [uAddr, if_neg (by norm_num)],
                show (2 * 0 + 1 : ℕ) = 1 from rfl,
                show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl,
                show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at R1
              rw [show ((1 : ℤ) - -1).natAbs = 2 from rfl,
                show gAddr A 1 = A from by rw [gAddr, if_pos (by norm_num)],
                show gAddr (A - c) ((1 : ℤ) - -1) = A - c from by
                  rw [gAddr, if_pos (by norm_num)],
                show uAddr c (-1) = -c from by rw [uAddr, if_neg (by norm_num)],
                show (2 * 0 + 1 : ℕ) = 1 from rfl,
                show (piCoeff 1).2 = 1 from rfl, show (piCoeff 2).2 = 1 from rfl] at R2
              obtain ⟨hκ2, hAc⟩ := io_end_pos A c κ hκ (by linear_combination R1)
                (by linear_combination R2)
              exact ⟨hκ2, Or.inl ⟨rfl, rfl⟩, hAc⟩
            · rw [show ((-1 : ℤ) - 1).natAbs = 2 from rfl,
                show gAddr A (-1) = -A - 1 from by rw [gAddr, if_neg (by norm_num)],
                show gAddr (A - c) ((-1 : ℤ) - 1) = -(A - c) - 1 from by
                  rw [gAddr, if_neg (by norm_num)],
                show uAddr c 1 = c from by rw [uAddr, if_pos (by norm_num)],
                show (2 * 0 + 1 : ℕ) = 1 from rfl,
                show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl,
                show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at R1
              rw [show ((-1 : ℤ) - 1).natAbs = 2 from rfl,
                show gAddr A (-1) = -A - 1 from by rw [gAddr, if_neg (by norm_num)],
                show gAddr (A - c) ((-1 : ℤ) - 1) = -(A - c) - 1 from by
                  rw [gAddr, if_neg (by norm_num)],
                show uAddr c 1 = c from by rw [uAddr, if_pos (by norm_num)],
                show (2 * 0 + 1 : ℕ) = 1 from rfl,
                show (piCoeff 1).2 = 1 from rfl, show (piCoeff 2).2 = 1 from rfl] at R2
              obtain ⟨hκ2, hAc⟩ := io_end_neg A c κ hκ (by linear_combination R1)
                (by linear_combination R2)
              exact ⟨hκ2, Or.inr ⟨rfl, rfl⟩, hAc⟩
          · -- μ ≥ 1: the adjacent-heights kill
            exfalso
            obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv
            have hk1 : (b - d).natAbs = 2 * μ + 1 + 1 := by omega
            rw [hk1] at R1 R2
            refine adjacent_kill (gAddr A b) (gAddr (A - c) (b - d)) (h := 2 * μ + 1)
              (e := μ + 1) (by omega) (by omega)
              (W₁ := κ + (hexE (uAddr c d).val * (piCoeff (2 * 0 + 1)).1
                + (hexE (uAddr c d).val + hexF (uAddr c d).val)
                  * ((piCoeff (2 * 0 + 1)).1 + (piCoeff (2 * 0 + 1)).2)))
              (W₂ := hexF (uAddr c d).val * (piCoeff (2 * 0 + 1)).2) ?_ ?_
            · linear_combination R1
            · linear_combination R2
        · -- ν ≥ 1: the cross trace stands alone at the bottom
          exfalso
          obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv
          obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
          refine gE_gF_ne (gAddr (A - c) (b - d))
            (alone_dvd (p := (b - d).natAbs) (by omega)
              (R₁ := κ * 3 ^ (μ + ν' + 1)
                  + 3 ^ μ * (hexE (uAddr c d).val * (piCoeff (2 * (ν' + 1) + 1)).1
                    + (hexE (uAddr c d).val + hexF (uAddr c d).val)
                      * ((piCoeff (2 * (ν' + 1) + 1)).1 + (piCoeff (2 * (ν' + 1) + 1)).2))
                - 3 ^ ν' * (gE (gAddr A b) * (piCoeff (2 * μ + 1)).1
                    + (gE (gAddr A b) + gF (gAddr A b))
                      * ((piCoeff (2 * μ + 1)).1 + (piCoeff (2 * μ + 1)).2)))
              (R₂ := 3 ^ μ * (hexF (uAddr c d).val * (piCoeff (2 * (ν' + 1) + 1)).2)
                - 3 ^ ν' * (gF (gAddr A b) * (piCoeff (2 * μ + 1)).2))
              ?_ ?_)
          · linear_combination R1
          · linear_combination R2
      · -- same seam signs: the pivot trace alone (n ≤ m) or the φ kill (n > m)
        exfalso
        rcases (by omega : ν ≤ μ ∨ μ < ν) with hle | hgt
        · -- n ≤ m: the pivot trace alone after dividing by `3^ν`
          obtain ⟨t', rfl⟩ : ∃ t', t = ν + 1 + t' := ⟨t - ν - 1, by omega⟩
          obtain ⟨μ', hμ'⟩ : ∃ μ', μ + 1 = ν + 1 + μ' := ⟨μ - ν, by omega⟩
          rw [hμ', show μ + ν + 1 = ν + (μ + 1) by omega] at hdiv
          have hdiv' : (3 : ℂ) ^ 0
              * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
              + (3 : ℂ) ^ (1 + t')
                * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                  (b - d).natAbs
              = (κ : ℂ) * 3 ^ (μ + 1)
                + (3 : ℂ) ^ (1 + μ')
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val)
                    (2 * ν + 1) := by
            refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
            linear_combination hdiv
          obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv'
          refine gE_gF_ne (gAddr A b) (alone_dvd (p := 2 * μ + 1) (by omega)
            (R₁ := κ * 3 ^ μ
                + 3 ^ μ' * (hexE (uAddr c d).val * (piCoeff (2 * ν + 1)).1
                  + (hexE (uAddr c d).val + hexF (uAddr c d).val)
                    * ((piCoeff (2 * ν + 1)).1 + (piCoeff (2 * ν + 1)).2))
              - 3 ^ t' * (gE (gAddr (A - c) (b - d)) * (piCoeff (b - d).natAbs).1
                  + (gE (gAddr (A - c) (b - d)) + gF (gAddr (A - c) (b - d)))
                    * ((piCoeff (b - d).natAbs).1 + (piCoeff (b - d).natAbs).2)))
            (R₂ := 3 ^ μ' * (hexF (uAddr c d).val * (piCoeff (2 * ν + 1)).2)
              - 3 ^ t' * (gF (gAddr (A - c) (b - d)) * (piCoeff (b - d).natAbs).2))
            ?_ ?_)
          · linear_combination R1
          · linear_combination R2
        · -- n > m: the φ kill after dividing by `3^(μ+1)` (`t = 2μ+1`)
          obtain ⟨i', rfl⟩ : ∃ i', ν = μ + 1 + i' := ⟨ν - μ - 1, by omega⟩
          have htv : t = 2 * μ + 1 := by omega
          subst htv
          have hdiv' : (3 : ℂ) ^ i'
              * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
              + (3 : ℂ) ^ μ
                * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                  (b - d).natAbs
              = (κ : ℂ) * 3 ^ (μ + 1 + i')
                + (3 : ℂ) ^ 0
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val)
                    (2 * (μ + 1 + i') + 1) := by
            refine mul_left_cancel₀ (pow_ne_zero (μ + 1) (by norm_num : (3 : ℂ) ≠ 0)) ?_
            linear_combination hdiv
          obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv'
          obtain ⟨w₁, hw₁⟩ := phi_g_dvd (gAddr A b) (2 * μ + 1)
          obtain ⟨w₃, hw₃⟩ := phi_g_dvd (gAddr (A - c) (b - d)) ((b - d).natAbs)
          refine hex_diff_ne (uAddr c d)
            (phi_dvd (r := 2 * (μ + 1 + i') + 1) (by omega)
              (S := 3 ^ i' * w₁ + 3 ^ μ * w₃ - κ * 3 ^ (μ + i')) ?_)
          linear_combination -R1 - R2 + (3 : ℤ) ^ i' * hw₁ + (3 : ℤ) ^ μ * hw₃

/-- The master web (j = 0) io completeness, both directions. -/
private theorem meta_io_zero (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (innerPt 0 1 a b) (outerPt metaPivot metaAnchor c d) = 1 ↔
      (a, b, c, d) ∈ metaIOTable := by
  constructor
  · intro h
    obtain ⟨-, hbd, hAc⟩ := io_classify (Or.inl rfl)
      (io_master (R := 9) (κ := 2) (by norm_num) ((bridge_io a b c d).mp h))
    have ha : (a = 2 ∧ c = 5) ∨ (a = 5 ∧ c = 1) := by
      rcases hAc with ⟨h1, rfl⟩ | ⟨h1, rfl⟩
      · exact Or.inl ⟨by rw [eq_add_of_sub_eq h1]; decide, rfl⟩
      · exact Or.inr ⟨by rw [eq_add_of_sub_eq h1]; decide, rfl⟩
    rcases ha with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;> rcases hbd with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ <;>
      decide
  · intro hm
    fin_cases hm
    · -- (2, -1, 5, 1)
      rw [bridge_io, show (3 : ℂ) * word 5 1 = ((3 : ℝ) : ℂ) * word 5 1 by norm_num]
      refine web_master_rev ?_
      have h1 := gTrace_clear (2 - 1 : ZMod 6) (-1 : ℤ)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show gAddr (2 - 1 : ZMod 6) (-1 : ℤ) = 4 from by decide,
        show gE (4 : ZMod 6) = 1 from by decide,
        show gF (4 : ZMod 6) = -2 from by decide] at h1
      have h3 := gTrace_clear (2 - 1 - 5 : ZMod 6) ((-1 : ℤ) - 1)
      rw [show (((-1 : ℤ) - 1)).natAbs = 2 from rfl,
        show gAddr (2 - 1 - 5 : ZMod 6) ((-1 : ℤ) - 1) = 3 from by decide,
        show gE (3 : ZMod 6) = -1 from by decide,
        show gF (3 : ZMod 6) = -1 from by decide] at h3
      have h2 := uTrace_clear (5 : ZMod 6) (1 : ℤ)
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show uAddr (5 : ZMod 6) 1 = 5 from by decide,
        show hexE (5 : ZMod 6).val = 1 from by decide,
        show hexF (5 : ZMod 6).val = -1 from by decide] at h2
      have c1 := hexTrace_coords 1 (-2) 1
      have c3 := hexTrace_coords (-1) (-1) 2
      have c2 := hexTrace_coords 1 (-1) 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c2
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c3
      linear_combination (norm := (push_cast; ring)) -h1 - h3 + 3 * h2 - c1 - c3 + 3 * c2
        + (1 + gTr (2 - 1 - 5 : ZMod 6) ((-1 : ℤ) - 1)) * sqrt3_cast_sq
    · -- (2, 1, 5, -1)
      rw [bridge_io, show (3 : ℂ) * word 5 (-1) = ((3 : ℝ) : ℂ) * word 5 (-1) by norm_num]
      refine web_master_rev ?_
      have h1 := gTrace_clear (2 - 1 : ZMod 6) (1 : ℤ)
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show gAddr (2 - 1 : ZMod 6) (1 : ℤ) = 1 from by decide,
        show gE (1 : ZMod 6) = -1 from by decide,
        show gF (1 : ZMod 6) = 2 from by decide] at h1
      have h3 := gTrace_clear (2 - 1 - 5 : ZMod 6) ((1 : ℤ) - -1)
      rw [show (((1 : ℤ) - -1)).natAbs = 2 from rfl,
        show gAddr (2 - 1 - 5 : ZMod 6) ((1 : ℤ) - -1) = 2 from by decide,
        show gE (2 : ZMod 6) = -2 from by decide,
        show gF (2 : ZMod 6) = 1 from by decide] at h3
      have h2 := uTrace_clear (5 : ZMod 6) (-1 : ℤ)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show uAddr (5 : ZMod 6) (-1) = 1 from by decide,
        show hexE (1 : ZMod 6).val = 0 from by decide,
        show hexF (1 : ZMod 6).val = 1 from by decide] at h2
      have c1 := hexTrace_coords (-1) 2 1
      have c3 := hexTrace_coords (-2) 1 2
      have c2 := hexTrace_coords 0 1 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c2
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c3
      linear_combination (norm := (push_cast; ring)) -h1 - h3 + 3 * h2 - c1 - c3 + 3 * c2
        + (1 + gTr (2 - 1 - 5 : ZMod 6) ((1 : ℤ) - -1)) * sqrt3_cast_sq
    · -- (5, -1, 1, 1)
      rw [bridge_io, show (3 : ℂ) * word 1 1 = ((3 : ℝ) : ℂ) * word 1 1 by norm_num]
      refine web_master_rev ?_
      have h1 := gTrace_clear (5 - 1 : ZMod 6) (-1 : ℤ)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show gAddr (5 - 1 : ZMod 6) (-1 : ℤ) = 1 from by decide,
        show gE (1 : ZMod 6) = -1 from by decide,
        show gF (1 : ZMod 6) = 2 from by decide] at h1
      have h3 := gTrace_clear (5 - 1 - 1 : ZMod 6) ((-1 : ℤ) - 1)
      rw [show (((-1 : ℤ) - 1)).natAbs = 2 from rfl,
        show gAddr (5 - 1 - 1 : ZMod 6) ((-1 : ℤ) - 1) = 2 from by decide,
        show gE (2 : ZMod 6) = -2 from by decide,
        show gF (2 : ZMod 6) = 1 from by decide] at h3
      have h2 := uTrace_clear (1 : ZMod 6) (1 : ℤ)
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show uAddr (1 : ZMod 6) 1 = 1 from by decide,
        show hexE (1 : ZMod 6).val = 0 from by decide,
        show hexF (1 : ZMod 6).val = 1 from by decide] at h2
      have c1 := hexTrace_coords (-1) 2 1
      have c3 := hexTrace_coords (-2) 1 2
      have c2 := hexTrace_coords 0 1 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c2
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c3
      linear_combination (norm := (push_cast; ring)) -h1 - h3 + 3 * h2 - c1 - c3 + 3 * c2
        + (1 + gTr (5 - 1 - 1 : ZMod 6) ((-1 : ℤ) - 1)) * sqrt3_cast_sq
    · -- (5, 1, 1, -1)
      rw [bridge_io, show (3 : ℂ) * word 1 (-1) = ((3 : ℝ) : ℂ) * word 1 (-1) by norm_num]
      refine web_master_rev ?_
      have h1 := gTrace_clear (5 - 1 : ZMod 6) (1 : ℤ)
      rw [show ((1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show gAddr (5 - 1 : ZMod 6) (1 : ℤ) = 4 from by decide,
        show gE (4 : ZMod 6) = 1 from by decide,
        show gF (4 : ZMod 6) = -2 from by decide] at h1
      have h3 := gTrace_clear (5 - 1 - 1 : ZMod 6) ((1 : ℤ) - -1)
      rw [show (((1 : ℤ) - -1)).natAbs = 2 from rfl,
        show gAddr (5 - 1 - 1 : ZMod 6) ((1 : ℤ) - -1) = 3 from by decide,
        show gE (3 : ZMod 6) = -1 from by decide,
        show gF (3 : ZMod 6) = -1 from by decide] at h3
      have h2 := uTrace_clear (1 : ZMod 6) (-1 : ℤ)
      rw [show ((-1 : ℤ)).natAbs = 1 from rfl, pow_one,
        show uAddr (1 : ZMod 6) (-1) = 5 from by decide,
        show hexE (5 : ZMod 6).val = 1 from by decide,
        show hexF (5 : ZMod 6).val = -1 from by decide] at h2
      have c1 := hexTrace_coords 1 (-2) 1
      have c3 := hexTrace_coords (-1) (-1) 2
      have c2 := hexTrace_coords 1 (-1) 1
      rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c2
      rw [show (piCoeff 2).1 = -3 from rfl, show (piCoeff 2).2 = 1 from rfl] at c3
      linear_combination (norm := (push_cast; ring)) -h1 - h3 + 3 * h2 - c1 - c3 + 3 * c2
        + (1 + gTr (5 - 1 - 1 : ZMod 6) ((1 : ℤ) - -1)) * sqrt3_cast_sq

/-! ### §W.16 The oi family: `outer(pivot) ↔ inner(meta)`, κ ∈ {2, 5} — the hub family -/

/-- The oi cleared equation. -/
private theorem oi_cleared {A c : ZMod 6} {b d : ℤ} {t : ℕ} {κ : ℤ}
    (ht : b.natAbs + d.natAbs = (b - d).natAbs + 2 * t)
    (h : gTr A b + gTr (A - c) (b - d) = (κ : ℂ) + uTr c d) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ d.natAbs
        * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) b.natAbs
      + (3 : ℂ) ^ t
          * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
            (b - d).natAbs
      = (κ : ℂ) * ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs)
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ b.natAbs
          * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) d.natAbs := by
  have hA := gTrace_clear A b
  have hB := gTrace_clear (A - c) (b - d)
  have hC := uTrace_clear c d
  have hsum : ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs)
      * (gTr A b + gTr (A - c) (b - d))
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs) * ((κ : ℂ) + uTr c d) := by
    rw [h]
  have hpow2 : ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * t) * ((Real.sqrt 3 : ℝ) : ℂ) ^ (b - d).natAbs
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs) := by
    rw [← pow_add, show 2 * t + (b - d).natAbs = b.natAbs + d.natAbs by omega]
  rw [← hA, ← hB, ← hC, ← sqrt3_pow_two_mul t]
  linear_combination hsum + gTr (A - c) (b - d) * hpow2

/-- The hub pin: a height-zero unit value `−κ` forces κ = 2 and the address 3. -/
private theorem oi_hub_pin : ∀ (y : ZMod 6) (κ : ℤ), κ = 2 ∨ κ = 5 →
    2 * hexE y.val + hexF y.val + κ = 0 → κ = 2 ∧ y = 3 := by
  intro y κ hκ hv
  rcases hκ with rfl | rfl
  · refine ⟨rfl, ?_⟩
    revert hv
    revert y
    decide
  · exfalso
    revert hv
    revert y
    decide

/-- The oi boundary decide at heights zero: the hub column, the four census pairs
(κ = 2), or the two fusion pairs — the shared pivots — for κ = 5. -/
private theorem oi_end_zero : ∀ (A c : ZMod 6) (κ : ℤ), κ = 2 ∨ κ = 5 →
    2 * gE A + gF A + (2 * gE (A - c) + gF (A - c)) - κ
        - (2 * hexE c.val + hexF c.val) = 0 →
    (κ = 2 ∧ (c = 3 ∨ (A = 5 ∧ c = 1) ∨ (A = 0 ∧ c = 5) ∨ (A = 1 ∧ c = 1)
        ∨ (A = 4 ∧ c = 5)))
      ∨ (κ = 5 ∧ ((A = 0 ∧ c = 1) ∨ (A = 5 ∧ c = 5))) := by
  intro A c κ hκ h1
  rcases hκ with rfl | rfl
  · refine Or.inl ⟨rfl, ?_⟩
    revert h1
    revert A c
    decide
  · refine Or.inr ⟨rfl, ?_⟩
    revert h1
    revert A c
    decide

/-- The unit height-zero values. -/
private theorem u_zero_vals : ∀ y : ZMod 6,
    2 * hexE y.val + hexF y.val = 2 ∨ 2 * hexE y.val + hexF y.val = 1
      ∨ 2 * hexE y.val + hexF y.val = -1 ∨ 2 * hexE y.val + hexF y.val = -2 := by decide

/-- **The oi classification**: the hub column `(c, d) = (3, 0)` (κ = 2 only), or the
height-zero pairs — four for the chord constant, two (the shared pivots) for the
fusion constant. -/
private theorem oi_classify {A c : ZMod 6} {b d : ℤ} {κ : ℤ} (hκ : κ = 2 ∨ κ = 5)
    (h : gTr A b + gTr (A - c) (b - d) = (κ : ℂ) + uTr c d) :
    (κ = 2 ∧ c = 3 ∧ d = 0)
      ∨ (b = 0 ∧ d = 0
          ∧ ((κ = 2 ∧ ((A = 5 ∧ c = 1) ∨ (A = 0 ∧ c = 5) ∨ (A = 1 ∧ c = 1)
              ∨ (A = 4 ∧ c = 5)))
            ∨ (κ = 5 ∧ ((A = 0 ∧ c = 1) ∨ (A = 5 ∧ c = 5))))) := by
  obtain ⟨t, ht⟩ : ∃ t, b.natAbs + d.natAbs = (b - d).natAbs + 2 * t :=
    ⟨(b.natAbs + d.natAbs - (b - d).natAbs) / 2, by omega⟩
  have hcl := oi_cleared ht h
  obtain ⟨ν, hν⟩ : ∃ ν, d.natAbs = 2 * ν ∨ d.natAbs = 2 * ν + 1 := ⟨d.natAbs / 2, by omega⟩
  obtain ⟨μ, hμ⟩ : ∃ μ, b.natAbs = 2 * μ ∨ b.natAbs = 2 * μ + 1 := ⟨b.natAbs / 2, by omega⟩
  rcases hμ with hμ | hμ
  · rcases hν with hν | hν
    · -- (even, even): THE LIVE CLASS — the whole equation is already in the ring
      rw [hν, hμ, show 2 * μ + 2 * ν = 2 * (μ + ν) by ring] at hcl
      simp only [sqrt3_pow_two_mul] at hcl
      rcases Nat.eq_zero_or_pos ν with hν0 | hνp
      · -- d = 0: the endgame family
        subst hν0
        obtain rfl : d = 0 := by omega
        obtain rfl : t = 0 := by omega
        have hk : (b - 0).natAbs = 2 * μ := by omega
        rw [hk] at hcl
        rcases Nat.eq_zero_or_pos μ with hμ0 | hμp
        · -- b = 0: the boundary decide — hub, census pairs, or fusion pairs
          subst hμ0
          obtain rfl : b = 0 := by omega
          rw [show (2 * 0 : ℕ) = 0 from rfl, hexTrace_zero_height, hexTrace_zero_height,
            hexTrace_zero_height] at hcl
          have hvalC : ((2 * gE (gAddr A 0) + gF (gAddr A 0)
              + (2 * gE (gAddr (A - c) (0 - 0)) + gF (gAddr (A - c) (0 - 0))) - κ
              - (2 * hexE (uAddr c 0).val + hexF (uAddr c 0).val) : ℤ) : ℂ) = 0 := by
            linear_combination (norm := (push_cast; ring)) hcl
          have hval : (2 * gE (gAddr A 0) + gF (gAddr A 0)
              + (2 * gE (gAddr (A - c) (0 - 0)) + gF (gAddr (A - c) (0 - 0))) - κ
              - (2 * hexE (uAddr c 0).val + hexF (uAddr c 0).val) : ℤ) = 0 := by
            exact_mod_cast hvalC
          rw [show gAddr A 0 = A from by rw [gAddr, if_pos le_rfl],
            show gAddr (A - c) ((0 : ℤ) - 0) = A - c from by
              rw [gAddr, if_pos (by norm_num)],
            show uAddr c 0 = c from by rw [uAddr, if_pos le_rfl]] at hval
          rcases oi_end_zero A c κ hκ hval with ⟨hκ2, hc3 | hAc⟩ | ⟨hκ5, hAc⟩
          · exact Or.inl ⟨hκ2, hc3, rfl⟩
          · exact Or.inr ⟨rfl, rfl, Or.inl ⟨hκ2, hAc⟩⟩
          · exact Or.inr ⟨rfl, rfl, Or.inr ⟨hκ5, hAc⟩⟩
        · -- b ≠ 0: the pin bounds the height — the hub ray, or dead
          rw [show (2 * 0 : ℕ) = 0 from rfl, hexTrace_zero_height] at hcl
          simp only [pow_zero, one_mul] at hcl
          rw [hexTrace_add] at hcl
          have hcomb : hexTrace (gE (gAddr A b) + gE (gAddr (A - c) (b - 0)))
              (gF (gAddr A b) + gF (gAddr (A - c) (b - 0))) (2 * μ)
              = ((3 ^ (μ + 0) * (κ + (2 * hexE (uAddr c 0).val + hexF (uAddr c 0).val))
                  : ℤ) : ℂ) := by
            linear_combination (norm := (push_cast; ring)) hcl
          obtain ⟨hF, hval⟩ := hexTrace_pin (by omega) hcomb
          rcases eq_or_ne (gE (gAddr A b) + gE (gAddr (A - c) (b - 0))) 0 with h0 | hne
          · -- the hub ray
            rw [h0, zero_mul] at hval
            have hκy : κ + (2 * hexE (uAddr c 0).val + hexF (uAddr c 0).val) = 0 := by
              have h3 : (3 : ℤ) ^ (μ + 0) ≠ 0 := pow_ne_zero _ (by norm_num)
              rcases mul_eq_zero.mp hval.symm with hz | hz
              · exact absurd hz h3
              · exact hz
            obtain ⟨hκ2, hy3⟩ := oi_hub_pin (uAddr c 0) κ hκ (by omega)
            refine Or.inl ⟨hκ2, ?_, rfl⟩
            rwa [show uAddr c 0 = c from by rw [uAddr, if_pos le_rfl]] at hy3
          · -- dead: the divisibility bound pins μ = 1, where the values refuse
            exfalso
            have hdvd : (3 : ℤ) ^ (μ + 0)
                ∣ (gE (gAddr A b) + gE (gAddr (A - c) (b - 0))) :=
              Int.prime_three.pow_dvd_of_dvd_mul_right (μ + 0)
                (not_three_dvd_pin (2 * μ) (by omega)) ⟨_, hval⟩
            have hbnd := gE_abs_le (gAddr A b) (gAddr (A - c) (b - 0))
            have hle : (3 : ℤ) ^ (μ + 0) ≤ 4 := by
              rcases lt_or_gt_of_ne hne with hlt | hgt
              · have := Int.le_of_dvd (by omega) ((dvd_neg).mpr hdvd)
                omega
              · have := Int.le_of_dvd (by omega) hdvd
                omega
            have hμ1 : μ = 1 := by
              by_contra hcon
              obtain ⟨μ', rfl⟩ : ∃ μ', μ = μ' + 1 + 1 := ⟨μ - 2, by omega⟩
              have h9 : (9 : ℤ) ≤ 3 ^ (μ' + 1 + 1 + 0) :=
                calc (9 : ℤ) = 3 ^ 2 := by norm_num
                  _ ≤ 3 ^ (μ' + 1 + 1 + 0) := pow_le_pow_right₀ (by norm_num) (by omega)
              omega
            subst hμ1
            rw [show (2 * 1 : ℕ) = 2 from rfl, show (piCoeff 2).1 = -3 from rfl,
              show (piCoeff 2).2 = 1 from rfl] at hval
            have h31 : (3 : ℤ) ^ (1 + 0) = 3 := by norm_num
            rw [h31] at hdvd hval
            have hs : gE (gAddr A b) + gE (gAddr (A - c) (b - 0)) = 3
                ∨ gE (gAddr A b) + gE (gAddr (A - c) (b - 0)) = -3 := by omega
            have hvals := u_zero_vals (uAddr c 0)
            rcases hκ with rfl | rfl <;> rcases hs with hs | hs <;> rw [hs] at hval <;> omega
      · -- n ≥ 2: dead
        exfalso
        rcases Nat.eq_zero_or_pos t with ht0 | htp
        · subst ht0
          rcases Nat.eq_zero_or_pos μ with hμ0 | hμp
          · -- b = 0: the φ kill on the minimal pair {H₃, H₂}
            subst hμ0
            obtain ⟨R1, R2⟩ := hexTrace_rows_const hcl
            obtain ⟨w₁, hw₁⟩ := phi_g_dvd (gAddr A b) (2 * 0)
            obtain ⟨w₃, hw₃⟩ := phi_g_dvd (gAddr (A - c) (b - d)) ((b - d).natAbs)
            obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
            refine hex_diff_ne (uAddr c d) (phi_dvd (r := 2 * (ν' + 1)) (by omega)
              (S := 3 ^ (ν' + 1) * w₁ + w₃ - κ * 3 ^ ν') ?_)
            linear_combination -R1 - R2 + (3 : ℤ) ^ (ν' + 1) * hw₁ + hw₃
          · -- b ≠ 0: the cross trace alone at the bottom
            obtain ⟨R1, R2⟩ := hexTrace_rows_const hcl
            obtain ⟨μ', rfl⟩ : ∃ μ', μ = μ' + 1 := ⟨μ - 1, by omega⟩
            obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
            refine gE_gF_ne (gAddr (A - c) (b - d))
              (alone_dvd (p := (b - d).natAbs) (by omega)
                (R₁ := κ * 3 ^ (μ' + 1 + ν')
                    + 3 ^ μ' * (hexE (uAddr c d).val * (piCoeff (2 * (ν' + 1))).1
                      + (hexE (uAddr c d).val + hexF (uAddr c d).val)
                        * ((piCoeff (2 * (ν' + 1))).1 + (piCoeff (2 * (ν' + 1))).2))
                  - 3 ^ ν' * (gE (gAddr A b) * (piCoeff (2 * (μ' + 1))).1
                      + (gE (gAddr A b) + gF (gAddr A b))
                        * ((piCoeff (2 * (μ' + 1))).1 + (piCoeff (2 * (μ' + 1))).2)))
                (R₂ := 3 ^ μ' * (hexF (uAddr c d).val * (piCoeff (2 * (ν' + 1))).2)
                  - 3 ^ ν' * (gF (gAddr A b) * (piCoeff (2 * (μ' + 1))).2))
                ?_ ?_)
            · linear_combination R1
            · linear_combination R2
        · -- same seam signs
          rcases (by omega : ν < μ ∨ ν = μ ∨ μ < ν) with hlt | heq | hgt
          · -- n < m: the pivot trace alone after dividing by `3^ν`
            obtain ⟨t', rfl⟩ : ∃ t', t = ν + 1 + t' := ⟨t - ν - 1, by omega⟩
            obtain ⟨μ', rfl⟩ : ∃ μ', μ = ν + 1 + μ' := ⟨μ - ν - 1, by omega⟩
            have hdiv' : (3 : ℂ) ^ 0
                * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * (ν + 1 + μ'))
                + (3 : ℂ) ^ (1 + t')
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs
                = (κ : ℂ) * 3 ^ (1 + μ' + ν)
                  + (3 : ℂ) ^ (1 + μ')
                    * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val)
                      (2 * ν) := by
              refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
              linear_combination hcl
            obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv'
            refine gE_gF_ne (gAddr A b) (alone_dvd (p := 2 * (ν + 1 + μ')) (by omega)
              (R₁ := κ * 3 ^ (μ' + ν)
                  + 3 ^ μ' * (hexE (uAddr c d).val * (piCoeff (2 * ν)).1
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
          · -- n = m: the φ kill at the joint minimum {H₁, H₂}
            subst heq
            have htv : t = 2 * ν := by omega
            subst htv
            have hdiv' : (3 : ℂ) ^ 0
                * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * ν)
                + (3 : ℂ) ^ ν
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs
                = (κ : ℂ) * 3 ^ ν
                  + (3 : ℂ) ^ 0
                    * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val)
                      (2 * ν) := by
              refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
              linear_combination hcl
            obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv'
            obtain ⟨w₁, hw₁⟩ := phi_g_dvd (gAddr A b) (2 * ν)
            obtain ⟨w₃, hw₃⟩ := phi_g_dvd (gAddr (A - c) (b - d)) ((b - d).natAbs)
            obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
            refine hex_diff_ne (uAddr c d) (phi_dvd (r := 2 * (ν' + 1)) (by omega)
              (S := w₁ + 3 ^ (ν' + 1) * w₃ - κ * 3 ^ ν') ?_)
            linear_combination -R1 - R2 + hw₁ + (3 : ℤ) ^ (ν' + 1) * hw₃
          · -- n > m: the unit trace alone at the minimum
            obtain ⟨i', rfl⟩ : ∃ i', ν = μ + 1 + i' := ⟨ν - μ - 1, by omega⟩
            have htv : t = 2 * μ := by omega
            subst htv
            have hdiv' : (3 : ℂ) ^ (1 + i')
                * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
                + (3 : ℂ) ^ μ
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs
                = (κ : ℂ) * 3 ^ (μ + 1 + i')
                  + (3 : ℂ) ^ 0
                    * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val)
                      (2 * (μ + 1 + i')) := by
              refine mul_left_cancel₀ (pow_ne_zero μ (by norm_num : (3 : ℂ) ≠ 0)) ?_
              linear_combination hcl
            obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv'
            obtain ⟨μ'', rfl⟩ : ∃ μ'', μ = μ'' + 1 := ⟨μ - 1, by omega⟩
            refine hexE_hexF_not_both_dvd (uAddr c d).val (ZMod.val_lt _)
              (alone_dvd (p := 2 * (μ'' + 1 + 1 + i')) (by omega)
                (R₁ := 3 ^ i' * (gE (gAddr A b) * (piCoeff (2 * (μ'' + 1))).1
                    + (gE (gAddr A b) + gF (gAddr A b))
                      * ((piCoeff (2 * (μ'' + 1))).1 + (piCoeff (2 * (μ'' + 1))).2))
                  + 3 ^ μ''
                    * (gE (gAddr (A - c) (b - d)) * (piCoeff (b - d).natAbs).1
                      + (gE (gAddr (A - c) (b - d)) + gF (gAddr (A - c) (b - d)))
                        * ((piCoeff (b - d).natAbs).1 + (piCoeff (b - d).natAbs).2))
                  - κ * 3 ^ (μ'' + 1 + i'))
                (R₂ := 3 ^ i' * (gF (gAddr A b) * (piCoeff (2 * (μ'' + 1))).2)
                  + 3 ^ μ'' * (gF (gAddr (A - c) (b - d)) * (piCoeff (b - d).natAbs).2))
                ?_ ?_)
            · linear_combination -R1
            · linear_combination -R2
    · -- (even, odd): the odd side reads `3^ν·H₁ = κ·3^(μ+ν)`, dead on the value / pin
      exfalso
      rw [hν, hμ, show 2 * μ + (2 * ν + 1) = 2 * (μ + ν) + 1 by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨-, hY⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace t _ _ _).add ((inRing_pow_trace μ _ _ _).neg))
        ((inRing_pow_trace ν _ _ _).add
          ((InRing.intSmul κ (inRing_three_pow (μ + ν))).neg))
        (show ((3 : ℂ) ^ t
              * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                (b - d).natAbs
              + -((3 : ℂ) ^ μ
                * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1)))
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
                + -((κ : ℂ) * (3 : ℂ) ^ (μ + ν))) = 0 by
          linear_combination hcl)
      have hH1 : hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
          = ((κ * 3 ^ μ : ℤ) : ℂ) := by
        refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
        push_cast
        linear_combination hY + (κ : ℂ) * (pow_add (3 : ℂ) ν μ).symm
      rcases Nat.eq_zero_or_pos μ with hμ0 | hμp
      · subst hμ0
        rw [show 2 * 0 = 0 from rfl, hexTrace_zero_height,
          show (κ * 3 ^ 0 : ℤ) = κ by ring] at hH1
        exact g_zero_ne_kappa (gAddr A b) κ (by tauto) (by exact_mod_cast hH1)
      · exact g_pin_kill (by omega) hH1
  · rcases hν with hν | hν
    · -- (odd, even): the odd side pins `H₂(2ν) = −κ·3^ν` — the hub column, or dead
      rw [hν, hμ, show 2 * μ + 1 + 2 * ν = 2 * (μ + ν) + 1 by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨-, hY⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace ν _ _ _).add (inRing_pow_trace t _ _ _))
        (((InRing.intSmul κ (inRing_three_pow (μ + ν))).neg).add
          ((inRing_pow_trace μ _ _ _).neg))
        (show ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
              + (3 : ℂ) ^ t
                * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                  (b - d).natAbs)
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * (-((κ : ℂ) * (3 : ℂ) ^ (μ + ν))
                + -((3 : ℂ) ^ μ
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν)))
            = 0 by
          linear_combination hcl)
      have hH2 : hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν)
          = ((-κ * 3 ^ ν : ℤ) : ℂ) := by
        refine mul_left_cancel₀ (pow_ne_zero μ (by norm_num : (3 : ℂ) ≠ 0)) ?_
        push_cast
        linear_combination -hY - (κ : ℂ) * (pow_add (3 : ℂ) μ ν).symm
      rcases Nat.eq_zero_or_pos ν with hν0 | hνp
      · -- the hub column
        subst hν0
        obtain rfl : d = 0 := by omega
        rw [show (2 * 0 : ℕ) = 0 from rfl, hexTrace_zero_height,
          show (-κ * 3 ^ 0 : ℤ) = -κ by ring] at hH2
        have hv : 2 * hexE (uAddr c 0).val + hexF (uAddr c 0).val + κ = 0 := by
          have := Int.cast_injective (α := ℂ) hH2
          omega
        obtain ⟨hκ2, hy3⟩ := oi_hub_pin (uAddr c 0) κ hκ hv
        refine Or.inl ⟨hκ2, ?_, rfl⟩
        rwa [show uAddr c 0 = c from by rw [uAddr, if_pos le_rfl]] at hy3
      · exfalso
        obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
        rw [show (-κ * 3 ^ (ν' + 1) : ℤ) = 3 * (-κ * 3 ^ ν') by ring] at hH2
        exact u_pin_kill_dvd (by omega) hH2
    · -- (odd, odd): the ring part reads `3^t·H₃ = κ·3^(μ+ν+1)`, dead on the value / pin
      exfalso
      rw [hν, hμ, show 2 * μ + 1 + (2 * ν + 1) = 2 * (μ + ν + 1) by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace t _ _ _).add
          ((InRing.intSmul κ (inRing_three_pow (μ + ν + 1))).neg))
        ((inRing_pow_trace ν _ _ _).add ((inRing_pow_trace μ _ _ _).neg))
        (show ((3 : ℂ) ^ t
              * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                (b - d).natAbs
              + -((κ : ℂ) * (3 : ℂ) ^ (μ + ν + 1)))
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
                + -((3 : ℂ) ^ μ
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1)))
            = 0 by
          linear_combination hcl)
      rcases Nat.eq_zero_or_pos (b - d).natAbs with hk0 | hkp
      · have htμν : t = μ + ν + 1 := by omega
        subst htμν
        rw [hk0, hexTrace_zero_height] at hX
        have hval : (2 * gE (gAddr (A - c) (b - d)) + gF (gAddr (A - c) (b - d)) : ℤ)
            = κ := by
          have hc : ((2 * gE (gAddr (A - c) (b - d)) + gF (gAddr (A - c) (b - d)) : ℤ) : ℂ)
              = (κ : ℂ) := by
            refine mul_left_cancel₀ (pow_ne_zero (μ + ν + 1) (by norm_num : (3 : ℂ) ≠ 0)) ?_
            linear_combination (norm := (push_cast; ring)) hX
          exact_mod_cast hc
        exact g_zero_ne_kappa (gAddr (A - c) (b - d)) κ (by tauto) hval
      · obtain ⟨e', he'⟩ : ∃ e', μ + ν + 1 = t + e' := ⟨μ + ν + 1 - t, by omega⟩
        have hH3 : hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
            (b - d).natAbs = ((κ * 3 ^ e' : ℤ) : ℂ) := by
          refine mul_left_cancel₀ (pow_ne_zero t (by norm_num : (3 : ℂ) ≠ 0)) ?_
          rw [he'] at hX
          push_cast
          linear_combination hX + (κ : ℂ) * (pow_add (3 : ℂ) t e').symm
        exact g_pin_kill hkp hH3

/-- The master web (j = 0) oi completeness, both directions. -/
private theorem meta_oi_zero (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (outerPt 0 1 a b) (innerPt metaPivot metaAnchor c d) = 1 ↔
      ((c, d) = ((3 : ZMod 6), (0 : ℤ)) ∨ (a, b, c, d) ∈ metaOITable) := by
  constructor
  · intro h
    rcases oi_classify (Or.inl rfl)
        (oi_master (R := 3) (κ := 2) (by norm_num) ((bridge_oi a b c d).mp h)) with
      ⟨-, rfl, rfl⟩ | ⟨rfl, rfl, ⟨-, hAc⟩ | ⟨h25, -⟩⟩
    · exact Or.inl rfl
    · refine Or.inr ?_
      rcases hAc with ⟨h1, rfl⟩ | ⟨h1, rfl⟩ | ⟨h1, rfl⟩ | ⟨h1, rfl⟩
      · obtain rfl : a = 0 := by rw [eq_add_of_sub_eq h1]; decide
        decide
      · obtain rfl : a = 1 := by rw [eq_add_of_sub_eq h1]; decide
        decide
      · obtain rfl : a = 2 := by rw [eq_add_of_sub_eq h1]; decide
        decide
      · obtain rfl : a = 5 := by rw [eq_add_of_sub_eq h1]; decide
        decide
    · norm_num at h25
  · rintro (hc | hm)
    · rw [Prod.mk.injEq] at hc
      obtain ⟨rfl, rfl⟩ := hc
      rw [metaInner_hub, dist_eq_norm,
        show outerPt 0 1 a b - 0 = word a b from by rw [outerPt]; ring, word_norm]
    · fin_cases hm
      · -- (0, 0, 1, 0)
        rw [bridge_oi, show (1 : ℂ) = ((1 : ℝ) : ℂ) by norm_num,
          show word (1 : ZMod 6) 0 = ((1 : ℝ) : ℂ) * word 1 0 from by norm_num]
        refine web_master_rev ?_
        rw [show ((0 : ℤ) - 0) = (0 : ℤ) from by norm_num]
        have h1 := gTr_zero (0 - 1 : ZMod 6)
        rw [show (2 * gE (0 - 1 : ZMod 6) + gF (0 - 1 : ZMod 6) : ℤ) = 3 from by decide]
          at h1
        have h3 := gTr_zero (0 - 1 - 1 : ZMod 6)
        rw [show (2 * gE (0 - 1 - 1 : ZMod 6) + gF (0 - 1 - 1 : ZMod 6) : ℤ) = 0 from
          by decide] at h3
        have h2 := uTr_zero (1 : ZMod 6)
        rw [show (2 * hexE (1 : ZMod 6).val + hexF (1 : ZMod 6).val : ℤ) = 1 from
          by decide] at h2
        linear_combination (norm := (push_cast; ring)) -h1 - h3 + h2
      · -- (1, 0, 5, 0)
        rw [bridge_oi, show (1 : ℂ) = ((1 : ℝ) : ℂ) by norm_num,
          show word (5 : ZMod 6) 0 = ((1 : ℝ) : ℂ) * word 5 0 from by norm_num]
        refine web_master_rev ?_
        rw [show ((0 : ℤ) - 0) = (0 : ℤ) from by norm_num]
        have h1 := gTr_zero (1 - 1 : ZMod 6)
        rw [show (2 * gE (1 - 1 : ZMod 6) + gF (1 - 1 : ZMod 6) : ℤ) = 3 from by decide]
          at h1
        have h3 := gTr_zero (1 - 1 - 5 : ZMod 6)
        rw [show (2 * gE (1 - 1 - 5 : ZMod 6) + gF (1 - 1 - 5 : ZMod 6) : ℤ) = 0 from
          by decide] at h3
        have h2 := uTr_zero (5 : ZMod 6)
        rw [show (2 * hexE (5 : ZMod 6).val + hexF (5 : ZMod 6).val : ℤ) = 1 from
          by decide] at h2
        linear_combination (norm := (push_cast; ring)) -h1 - h3 + h2
      · -- (2, 0, 1, 0)
        rw [bridge_oi, show (1 : ℂ) = ((1 : ℝ) : ℂ) by norm_num,
          show word (1 : ZMod 6) 0 = ((1 : ℝ) : ℂ) * word 1 0 from by norm_num]
        refine web_master_rev ?_
        rw [show ((0 : ℤ) - 0) = (0 : ℤ) from by norm_num]
        have h1 := gTr_zero (2 - 1 : ZMod 6)
        rw [show (2 * gE (2 - 1 : ZMod 6) + gF (2 - 1 : ZMod 6) : ℤ) = 0 from by decide]
          at h1
        have h3 := gTr_zero (2 - 1 - 1 : ZMod 6)
        rw [show (2 * gE (2 - 1 - 1 : ZMod 6) + gF (2 - 1 - 1 : ZMod 6) : ℤ) = 3 from
          by decide] at h3
        have h2 := uTr_zero (1 : ZMod 6)
        rw [show (2 * hexE (1 : ZMod 6).val + hexF (1 : ZMod 6).val : ℤ) = 1 from
          by decide] at h2
        linear_combination (norm := (push_cast; ring)) -h1 - h3 + h2
      · -- (5, 0, 5, 0)
        rw [bridge_oi, show (1 : ℂ) = ((1 : ℝ) : ℂ) by norm_num,
          show word (5 : ZMod 6) 0 = ((1 : ℝ) : ℂ) * word 5 0 from by norm_num]
        refine web_master_rev ?_
        rw [show ((0 : ℤ) - 0) = (0 : ℤ) from by norm_num]
        have h1 := gTr_zero (5 - 1 : ZMod 6)
        rw [show (2 * gE (5 - 1 : ZMod 6) + gF (5 - 1 : ZMod 6) : ℤ) = 0 from by decide]
          at h1
        have h3 := gTr_zero (5 - 1 - 5 : ZMod 6)
        rw [show (2 * gE (5 - 1 - 5 : ZMod 6) + gF (5 - 1 - 5 : ZMod 6) : ℤ) = 3 from
          by decide] at h3
        have h2 := uTr_zero (5 : ZMod 6)
        rw [show (2 * hexE (5 : ZMod 6).val + hexF (5 : ZMod 6).val : ℤ) = 1 from
          by decide] at h2
        linear_combination (norm := (push_cast; ring)) -h1 - h3 + h2

/-- **oi completeness, all three webs**: the hub pencil — the meta-inner point AT pivot
`j` — or the four hex-layer table chords. -/
theorem meta_oi_complete (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (outerPt (pivot j) (pivot j + 1) a b) (innerPt metaPivot metaAnchor c d) = 1 ↔
      ((c - webShift j, d) = (3, 0)
        ∨ (a - webShift j, b, c - webShift j, d) ∈ metaOITable) := by
  fin_cases j
  · show dist (outerPt (pivot 0) (pivot 0 + 1) a b) (innerPt metaPivot metaAnchor c d) = 1
      ↔ ((c - webShift 0, d) = (3, 0) ∨ (a - webShift 0, b, c - webShift 0, d) ∈ metaOITable)
    rw [pivot_zero, zero_add, show webShift 0 = 0 from rfl, sub_zero, sub_zero]
    exact meta_oi_zero a b c d
  · show dist (outerPt (pivot 1) (pivot 1 + 1) a b) (innerPt metaPivot metaAnchor c d) = 1
      ↔ ((c - webShift 1, d) = (3, 0) ∨ (a - webShift 1, b, c - webShift 1, d) ∈ metaOITable)
    have h1 : outerPt (pivot 1) (pivot 1 + 1) a b
        = metaPivot + zeta6 ^ 2 * (outerPt (pivot 0) (pivot 0 + 1) (a - 2) b - metaPivot) := by
      rw [web_transport_rot 0 (a - 2) b, sub_add_cancel,
        show (0 + 1 : Fin 3) = 1 from by decide]
    have h2 : innerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (innerPt metaPivot metaAnchor (c - 2) d - metaPivot) := by
      rw [web_transport_rot_meta_inner (c - 2) d, sub_add_cancel]
    rw [h1, h2, dist_metaRot, pivot_zero, zero_add, show webShift 1 = 2 from rfl]
    exact meta_oi_zero (a - 2) b (c - 2) d
  · show dist (outerPt (pivot 2) (pivot 2 + 1) a b) (innerPt metaPivot metaAnchor c d) = 1
      ↔ ((c - webShift 2, d) = (3, 0) ∨ (a - webShift 2, b, c - webShift 2, d) ∈ metaOITable)
    have h1 : outerPt (pivot 2) (pivot 2 + 1) a b
        = metaPivot + zeta6 ^ 2 * (outerPt (pivot 1) (pivot 1 + 1) (a - 2) b - metaPivot) := by
      rw [web_transport_rot 1 (a - 2) b, sub_add_cancel,
        show (1 + 1 : Fin 3) = 2 from by decide]
    have h2 : innerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (innerPt metaPivot metaAnchor (c - 2) d - metaPivot) := by
      rw [web_transport_rot_meta_inner (c - 2) d, sub_add_cancel]
    have h1' : outerPt (pivot 1) (pivot 1 + 1) (a - 2) b
        = metaPivot + zeta6 ^ 2
          * (outerPt (pivot 0) (pivot 0 + 1) (a - 2 - 2) b - metaPivot) := by
      rw [web_transport_rot 0 (a - 2 - 2) b, sub_add_cancel,
        show (0 + 1 : Fin 3) = 1 from by decide]
    have h2' : innerPt metaPivot metaAnchor (c - 2) d
        = metaPivot + zeta6 ^ 2
          * (innerPt metaPivot metaAnchor (c - 2 - 2) d - metaPivot) := by
      rw [web_transport_rot_meta_inner (c - 2 - 2) d, sub_add_cancel]
    rw [h1, h2, dist_metaRot, h1', h2', dist_metaRot, pivot_zero, zero_add,
      show (a - webShift 2 : ZMod 6) = a - 2 - 2 from by
        rw [show webShift 2 = 4 from rfl]; ring,
      show (c - webShift 2 : ZMod 6) = c - 2 - 2 from by
        rw [show webShift 2 = 4 from rfl]; ring]
    exact meta_oi_zero (a - 2 - 2) b (c - 2 - 2) d

/-- The master web oi fusion: outer(pivot 0) meets inner(meta) at exactly the other two
pivots — the κ = 5 run of the same engine. -/
private theorem meta_fusion_oi_zero (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    outerPt 0 1 a b = innerPt metaPivot metaAnchor c d ↔
      ((a = 1 ∧ b = 0 ∧ c = 1 ∧ d = 0) ∨ (a = 0 ∧ b = 0 ∧ c = 5 ∧ d = 0)) := by
  constructor
  · intro he
    rcases oi_classify (Or.inr rfl)
        (oi_master (R := 0) (κ := 5) (by norm_num) ((fusion_bridge_oi a b c d).mp he)) with
      ⟨h52, -⟩ | ⟨rfl, rfl, ⟨h25, -⟩ | ⟨-, hAc⟩⟩
    · norm_num at h52
    · norm_num at h25
    · rcases hAc with ⟨h1, rfl⟩ | ⟨h1, rfl⟩
      · refine Or.inl ⟨?_, rfl, rfl, rfl⟩
        rw [eq_add_of_sub_eq h1]
        decide
      · refine Or.inr ⟨?_, rfl, rfl, rfl⟩
        rw [eq_add_of_sub_eq h1]
        decide
  · rintro (⟨rfl, rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl, rfl⟩)
    · rw [fusion_bridge_oi]
      have h00 : word (1 - 1 : ZMod 6) 0 = 1 := by
        rw [show (1 - 1 : ZMod 6) = 0 from by decide, word_k0,
          show (((0 : ZMod 6)).val : ℤ) = 0 from rfl, zpow_zero]
      have h10 : word (1 : ZMod 6) 0 = zeta6 := by
        rw [word_k0, show (((1 : ZMod 6)).val : ℤ) = 1 from rfl, zpow_one]
      rw [show gC * word (1 - 1 : ZMod 6) 0 - 1 - word 1 0 = 0 from by
        rw [h00, h10, gC]; ring, map_zero]
    · rw [fusion_bridge_oi]
      have hw : word (5 : ZMod 6) 0 * word 1 0 = 1 := by
        rw [← word_add, show (5 + 1 : ZMod 6) = 0 from by decide,
          show ((0 : ℤ) + 0) = (0 : ℤ) from rfl, word_k0,
          show (((0 : ZMod 6)).val : ℤ) = 0 from rfl, zpow_zero]
      have h10 : word (1 : ZMod 6) 0 = zeta6 := by
        rw [word_k0, show (((1 : ZMod 6)).val : ℤ) = 1 from rfl, zpow_one]
      rw [show gC * word (0 - 1 : ZMod 6) 0 - 1 - word 5 0 = 0 from by
        rw [show (0 - 1 : ZMod 6) = 5 from by decide, gC]
        linear_combination hw + word (5 : ZMod 6) 0 * h10.symm, map_zero]

/-- **The oi fusion, all three webs**: outer(pivot j) meets inner(meta) exactly at the
other two pivots (the shifted rows). -/
theorem meta_fusion_oi (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    outerPt (pivot j) (pivot j + 1) a b = innerPt metaPivot metaAnchor c d ↔
      ((a - webShift j = 1 ∧ b = 0 ∧ c - webShift j = 1 ∧ d = 0)
        ∨ (a - webShift j = 0 ∧ b = 0 ∧ c - webShift j = 5 ∧ d = 0)) := by
  fin_cases j
  · show outerPt (pivot 0) (pivot 0 + 1) a b = innerPt metaPivot metaAnchor c d ↔
      ((a - webShift 0 = 1 ∧ b = 0 ∧ c - webShift 0 = 1 ∧ d = 0)
        ∨ (a - webShift 0 = 0 ∧ b = 0 ∧ c - webShift 0 = 5 ∧ d = 0))
    rw [pivot_zero, zero_add, show webShift 0 = 0 from rfl, sub_zero, sub_zero]
    exact meta_fusion_oi_zero a b c d
  · show outerPt (pivot 1) (pivot 1 + 1) a b = innerPt metaPivot metaAnchor c d ↔
      ((a - webShift 1 = 1 ∧ b = 0 ∧ c - webShift 1 = 1 ∧ d = 0)
        ∨ (a - webShift 1 = 0 ∧ b = 0 ∧ c - webShift 1 = 5 ∧ d = 0))
    have h1 : outerPt (pivot 1) (pivot 1 + 1) a b
        = metaPivot + zeta6 ^ 2 * (outerPt (pivot 0) (pivot 0 + 1) (a - 2) b - metaPivot) := by
      rw [web_transport_rot 0 (a - 2) b, sub_add_cancel,
        show (0 + 1 : Fin 3) = 1 from by decide]
    have h2 : innerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (innerPt metaPivot metaAnchor (c - 2) d - metaPivot) := by
      rw [web_transport_rot_meta_inner (c - 2) d, sub_add_cancel]
    rw [h1, h2, show webShift 1 = 2 from rfl]
    constructor
    · intro he
      have := metaRot_inj he
      rw [pivot_zero, zero_add] at this
      exact (meta_fusion_oi_zero (a - 2) b (c - 2) d).mp this
    · intro hrows
      have := (meta_fusion_oi_zero (a - 2) b (c - 2) d).mpr hrows
      rw [pivot_zero, zero_add]
      rw [this]
  · show outerPt (pivot 2) (pivot 2 + 1) a b = innerPt metaPivot metaAnchor c d ↔
      ((a - webShift 2 = 1 ∧ b = 0 ∧ c - webShift 2 = 1 ∧ d = 0)
        ∨ (a - webShift 2 = 0 ∧ b = 0 ∧ c - webShift 2 = 5 ∧ d = 0))
    have h1 : outerPt (pivot 2) (pivot 2 + 1) a b
        = metaPivot + zeta6 ^ 2 * (outerPt (pivot 1) (pivot 1 + 1) (a - 2) b - metaPivot) := by
      rw [web_transport_rot 1 (a - 2) b, sub_add_cancel,
        show (1 + 1 : Fin 3) = 2 from by decide]
    have h2 : innerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (innerPt metaPivot metaAnchor (c - 2) d - metaPivot) := by
      rw [web_transport_rot_meta_inner (c - 2) d, sub_add_cancel]
    have h1' : outerPt (pivot 1) (pivot 1 + 1) (a - 2) b
        = metaPivot + zeta6 ^ 2
          * (outerPt (pivot 0) (pivot 0 + 1) (a - 2 - 2) b - metaPivot) := by
      rw [web_transport_rot 0 (a - 2 - 2) b, sub_add_cancel,
        show (0 + 1 : Fin 3) = 1 from by decide]
    have h2' : innerPt metaPivot metaAnchor (c - 2) d
        = metaPivot + zeta6 ^ 2
          * (innerPt metaPivot metaAnchor (c - 2 - 2) d - metaPivot) := by
      rw [web_transport_rot_meta_inner (c - 2 - 2) d, sub_add_cancel]
    rw [h1, h2,
      show (a - webShift 2 : ZMod 6) = a - 2 - 2 from by
        rw [show webShift 2 = 4 from rfl]; ring,
      show (c - webShift 2 : ZMod 6) = c - 2 - 2 from by
        rw [show webShift 2 = 4 from rfl]; ring]
    constructor
    · intro he
      have he1 := metaRot_inj he
      rw [h1', h2'] at he1
      have he2 := metaRot_inj he1
      rw [pivot_zero, zero_add] at he2
      exact (meta_fusion_oi_zero (a - 2 - 2) b (c - 2 - 2) d).mp he2
    · intro hrows
      have := (meta_fusion_oi_zero (a - 2 - 2) b (c - 2 - 2) d).mpr hrows
      rw [h1', h2', pivot_zero, zero_add]
      rw [this]

/-! ### §W.17 The ii completeness wrapper and the empty ii fusion -/

/-- **ii completeness, all three webs**: exactly the four table chords per web. -/
theorem meta_ii_complete (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (innerPt (pivot j) (pivot j + 1) a b) (innerPt metaPivot metaAnchor c d) = 1 ↔
      (a - webShift j, b, c - webShift j, d) ∈ metaIITable := by
  have hzero : ∀ (a' : ZMod 6) (b' : ℤ) (c' : ZMod 6) (d' : ℤ),
      dist (innerPt 0 1 a' b') (innerPt metaPivot metaAnchor c' d') = 1 ↔
        (a', b', c', d') ∈ metaIITable := by
    intro a' b' c' d'
    constructor
    · intro h
      obtain ⟨hAc, hb, rfl⟩ := ii_classify (ii_web h)
      rcases hAc with ⟨h1, rfl⟩ | ⟨h1, rfl⟩
      · obtain rfl : a' = 1 := by rw [eq_add_of_sub_eq h1]; decide
        rcases hb with rfl | rfl <;> decide
      · obtain rfl : a' = 0 := by rw [eq_add_of_sub_eq h1]; decide
        rcases hb with rfl | rfl <;> decide
    · intro hm
      fin_cases hm
      · -- (0, -1, 5, 0)
        rw [bridge_ii]
        refine web_master_rev ?_
        rw [show ((-1 : ℤ) - 0) = (-1 : ℤ) from by norm_num]
        have h1 := gTrace_clear (0 - 1 : ZMod 6) (-1 : ℤ)
        rw [show ((-1 : ℤ)).natAbs = 1 from rfl, pow_one,
          show gAddr (0 - 1 : ZMod 6) (-1 : ℤ) = 0 from by decide,
          show gE (0 : ZMod 6) = 1 from by decide,
          show gF (0 : ZMod 6) = 1 from by decide] at h1
        have h3 := gTrace_clear (0 - 1 - 5 : ZMod 6) (-1 : ℤ)
        rw [show ((-1 : ℤ)).natAbs = 1 from rfl, pow_one,
          show gAddr (0 - 1 - 5 : ZMod 6) (-1 : ℤ) = 5 from by decide,
          show gE (5 : ZMod 6) = 2 from by decide,
          show gF (5 : ZMod 6) = -1 from by decide] at h3
        have h2 := uTr_zero (5 : ZMod 6)
        rw [show (2 * hexE (5 : ZMod 6).val + hexF (5 : ZMod 6).val : ℤ) = 1 from
          by decide] at h2
        have c1 := hexTrace_coords 1 1 1
        have c3 := hexTrace_coords 2 (-1) 1
        rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c3
        rw [h2]
        linear_combination (norm := (push_cast; ring)) -h1 - h3 - c1 - c3
          + 3 * sqrt3_cast_sq
      · -- (0, 1, 5, 0)
        rw [bridge_ii]
        refine web_master_rev ?_
        rw [show ((1 : ℤ) - 0) = (1 : ℤ) from by norm_num]
        have h1 := gTrace_clear (0 - 1 : ZMod 6) (1 : ℤ)
        rw [show ((1 : ℤ)).natAbs = 1 from rfl, pow_one,
          show gAddr (0 - 1 : ZMod 6) (1 : ℤ) = 5 from by decide,
          show gE (5 : ZMod 6) = 2 from by decide,
          show gF (5 : ZMod 6) = -1 from by decide] at h1
        have h3 := gTrace_clear (0 - 1 - 5 : ZMod 6) (1 : ℤ)
        rw [show ((1 : ℤ)).natAbs = 1 from rfl, pow_one,
          show gAddr (0 - 1 - 5 : ZMod 6) (1 : ℤ) = 0 from by decide,
          show gE (0 : ZMod 6) = 1 from by decide,
          show gF (0 : ZMod 6) = 1 from by decide] at h3
        have h2 := uTr_zero (5 : ZMod 6)
        rw [show (2 * hexE (5 : ZMod 6).val + hexF (5 : ZMod 6).val : ℤ) = 1 from
          by decide] at h2
        have c1 := hexTrace_coords 2 (-1) 1
        have c3 := hexTrace_coords 1 1 1
        rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c3
        rw [h2]
        linear_combination (norm := (push_cast; ring)) -h1 - h3 - c1 - c3
          + 3 * sqrt3_cast_sq
      · -- (1, -1, 1, 0)
        rw [bridge_ii]
        refine web_master_rev ?_
        rw [show ((-1 : ℤ) - 0) = (-1 : ℤ) from by norm_num]
        have h1 := gTrace_clear (1 - 1 : ZMod 6) (-1 : ℤ)
        rw [show ((-1 : ℤ)).natAbs = 1 from rfl, pow_one,
          show gAddr (1 - 1 : ZMod 6) (-1 : ℤ) = 5 from by decide,
          show gE (5 : ZMod 6) = 2 from by decide,
          show gF (5 : ZMod 6) = -1 from by decide] at h1
        have h3 := gTrace_clear (1 - 1 - 1 : ZMod 6) (-1 : ℤ)
        rw [show ((-1 : ℤ)).natAbs = 1 from rfl, pow_one,
          show gAddr (1 - 1 - 1 : ZMod 6) (-1 : ℤ) = 0 from by decide,
          show gE (0 : ZMod 6) = 1 from by decide,
          show gF (0 : ZMod 6) = 1 from by decide] at h3
        have h2 := uTr_zero (1 : ZMod 6)
        rw [show (2 * hexE (1 : ZMod 6).val + hexF (1 : ZMod 6).val : ℤ) = 1 from
          by decide] at h2
        have c1 := hexTrace_coords 2 (-1) 1
        have c3 := hexTrace_coords 1 1 1
        rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c3
        rw [h2]
        linear_combination (norm := (push_cast; ring)) -h1 - h3 - c1 - c3
          + 3 * sqrt3_cast_sq
      · -- (1, 1, 1, 0)
        rw [bridge_ii]
        refine web_master_rev ?_
        rw [show ((1 : ℤ) - 0) = (1 : ℤ) from by norm_num]
        have h1 := gTrace_clear (1 - 1 : ZMod 6) (1 : ℤ)
        rw [show ((1 : ℤ)).natAbs = 1 from rfl, pow_one,
          show gAddr (1 - 1 : ZMod 6) (1 : ℤ) = 0 from by decide,
          show gE (0 : ZMod 6) = 1 from by decide,
          show gF (0 : ZMod 6) = 1 from by decide] at h1
        have h3 := gTrace_clear (1 - 1 - 1 : ZMod 6) (1 : ℤ)
        rw [show ((1 : ℤ)).natAbs = 1 from rfl, pow_one,
          show gAddr (1 - 1 - 1 : ZMod 6) (1 : ℤ) = 5 from by decide,
          show gE (5 : ZMod 6) = 2 from by decide,
          show gF (5 : ZMod 6) = -1 from by decide] at h3
        have h2 := uTr_zero (1 : ZMod 6)
        rw [show (2 * hexE (1 : ZMod 6).val + hexF (1 : ZMod 6).val : ℤ) = 1 from
          by decide] at h2
        have c1 := hexTrace_coords 1 1 1
        have c3 := hexTrace_coords 2 (-1) 1
        rw [show (piCoeff 1).1 = 0 from rfl, show (piCoeff 1).2 = 1 from rfl] at c1 c3
        rw [h2]
        linear_combination (norm := (push_cast; ring)) -h1 - h3 - c1 - c3
          + 3 * sqrt3_cast_sq
  fin_cases j
  · show dist (innerPt (pivot 0) (pivot 0 + 1) a b) (innerPt metaPivot metaAnchor c d) = 1
      ↔ (a - webShift 0, b, c - webShift 0, d) ∈ metaIITable
    rw [pivot_zero, zero_add, show webShift 0 = 0 from rfl, sub_zero, sub_zero]
    exact hzero a b c d
  · show dist (innerPt (pivot 1) (pivot 1 + 1) a b) (innerPt metaPivot metaAnchor c d) = 1
      ↔ (a - webShift 1, b, c - webShift 1, d) ∈ metaIITable
    have h1 : innerPt (pivot 1) (pivot 1 + 1) a b
        = metaPivot + zeta6 ^ 2 * (innerPt (pivot 0) (pivot 0 + 1) (a - 2) b - metaPivot) := by
      rw [web_transport_rot_inner 0 (a - 2) b, sub_add_cancel,
        show (0 + 1 : Fin 3) = 1 from by decide]
    have h2 : innerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (innerPt metaPivot metaAnchor (c - 2) d - metaPivot) := by
      rw [web_transport_rot_meta_inner (c - 2) d, sub_add_cancel]
    rw [h1, h2, dist_metaRot, pivot_zero, zero_add, show webShift 1 = 2 from rfl]
    exact hzero (a - 2) b (c - 2) d
  · show dist (innerPt (pivot 2) (pivot 2 + 1) a b) (innerPt metaPivot metaAnchor c d) = 1
      ↔ (a - webShift 2, b, c - webShift 2, d) ∈ metaIITable
    have h1 : innerPt (pivot 2) (pivot 2 + 1) a b
        = metaPivot + zeta6 ^ 2 * (innerPt (pivot 1) (pivot 1 + 1) (a - 2) b - metaPivot) := by
      rw [web_transport_rot_inner 1 (a - 2) b, sub_add_cancel,
        show (1 + 1 : Fin 3) = 2 from by decide]
    have h2 : innerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (innerPt metaPivot metaAnchor (c - 2) d - metaPivot) := by
      rw [web_transport_rot_meta_inner (c - 2) d, sub_add_cancel]
    have h1' : innerPt (pivot 1) (pivot 1 + 1) (a - 2) b
        = metaPivot + zeta6 ^ 2
          * (innerPt (pivot 0) (pivot 0 + 1) (a - 2 - 2) b - metaPivot) := by
      rw [web_transport_rot_inner 0 (a - 2 - 2) b, sub_add_cancel,
        show (0 + 1 : Fin 3) = 1 from by decide]
    have h2' : innerPt metaPivot metaAnchor (c - 2) d
        = metaPivot + zeta6 ^ 2
          * (innerPt metaPivot metaAnchor (c - 2 - 2) d - metaPivot) := by
      rw [web_transport_rot_meta_inner (c - 2 - 2) d, sub_add_cancel]
    rw [h1, h2, dist_metaRot, h1', h2', dist_metaRot, pivot_zero, zero_add,
      show (a - webShift 2 : ZMod 6) = a - 2 - 2 from by
        rw [show webShift 2 = 4 from rfl]; ring,
      show (c - webShift 2 : ZMod 6) = c - 2 - 2 from by
        rw [show webShift 2 = 4 from rfl]; ring]
    exact hzero (a - 2 - 2) b (c - 2 - 2) d

/-- The ii fusion cleared equation (the constant is `3√3`). -/
private theorem ii_fusion_cleared {A c : ZMod 6} {b d : ℤ} {t : ℕ}
    (ht : b.natAbs + d.natAbs = (b - d).natAbs + 2 * t)
    (h : gTr A b + gTr (A - c) (b - d)
      = 3 * ((Real.sqrt 3 : ℝ) : ℂ) + ((Real.sqrt 3 : ℝ) : ℂ) * uTr c d) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ d.natAbs
        * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) b.natAbs
      + (3 : ℂ) ^ t
          * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
            (b - d).natAbs
      = ((3 : ℤ) : ℂ) * ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs + 1)
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + 1)
          * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) d.natAbs := by
  have hA := gTrace_clear A b
  have hB := gTrace_clear (A - c) (b - d)
  have hC := uTrace_clear c d
  have hsum : ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs)
      * (gTr A b + gTr (A - c) (b - d))
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs)
        * (3 * ((Real.sqrt 3 : ℝ) : ℂ) + ((Real.sqrt 3 : ℝ) : ℂ) * uTr c d) := by
    rw [h]
  have hpow2 : ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * t) * ((Real.sqrt 3 : ℝ) : ℂ) ^ (b - d).natAbs
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b.natAbs + d.natAbs) := by
    rw [← pow_add, show 2 * t + (b - d).natAbs = b.natAbs + d.natAbs by omega]
  rw [← hA, ← hB, ← hC, ← sqrt3_pow_two_mul t, pow_succ, pow_succ]
  push_cast
  linear_combination hsum + gTr (A - c) (b - d) * hpow2

/-- The ii fusion μ = 0 boundary, `b = 1` frame: no address pair survives. -/
private theorem ii_fusion_end_pos : ∀ A c : ZMod 6,
    ¬ (gF A + gF (A - c) = 0
      ∧ gE A + gE (A - c) = 3 * (2 * hexE c.val + hexF c.val + 3)) := by decide

/-- The ii fusion μ = 0 boundary, `b = −1` frame. -/
private theorem ii_fusion_end_neg : ∀ A c : ZMod 6,
    ¬ (gF (-A - 1) + gF (-(A - c) - 1) = 0
      ∧ gE (-A - 1) + gE (-(A - c) - 1) = 3 * (2 * hexE c.val + hexF c.val + 3)) := by
  decide

/-- **The ii fusion is empty**: the inner lattices of a pivot and the metapivot share
no point — the mirror centroids are never lattice words. -/
private theorem ii_fusion_classify {A c : ZMod 6} {b d : ℤ}
    (h : gTr A b + gTr (A - c) (b - d)
      = 3 * ((Real.sqrt 3 : ℝ) : ℂ) + ((Real.sqrt 3 : ℝ) : ℂ) * uTr c d) : False := by
  obtain ⟨t, ht⟩ : ∃ t, b.natAbs + d.natAbs = (b - d).natAbs + 2 * t :=
    ⟨(b.natAbs + d.natAbs - (b - d).natAbs) / 2, by omega⟩
  have hcl := ii_fusion_cleared ht h
  obtain ⟨ν, hν⟩ : ∃ ν, d.natAbs = 2 * ν ∨ d.natAbs = 2 * ν + 1 := ⟨d.natAbs / 2, by omega⟩
  obtain ⟨μ, hμ⟩ : ∃ μ, b.natAbs = 2 * μ ∨ b.natAbs = 2 * μ + 1 := ⟨b.natAbs / 2, by omega⟩
  rcases hμ with hμ | hμ
  · rcases hν with hν | hν
    · -- (even, even): the odd side reads `3^μ·H₂ = −3^(μ+ν+1)`, dead on values / pin
      rw [hν, hμ, show 2 * μ + 2 * ν + 1 = 2 * (μ + ν) + 1 by ring,
        show 2 * μ + 1 = 2 * μ + 1 from rfl] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨-, hY⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace ν _ _ _).add (inRing_pow_trace t _ _ _))
        ((((InRing.intCast 3).mul (inRing_three_pow (μ + ν))).neg).add
          ((inRing_pow_trace μ _ _ _).neg))
        (show ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
              + (3 : ℂ) ^ t
                * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                  (b - d).natAbs)
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * (-(((3 : ℤ) : ℂ) * (3 : ℂ) ^ (μ + ν))
                + -((3 : ℂ) ^ μ
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν)))
            = 0 by
          push_cast
          linear_combination hcl)
      have hH2 : hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν)
          = ((-3 * 3 ^ ν : ℤ) : ℂ) := by
        refine mul_left_cancel₀ (pow_ne_zero μ (by norm_num : (3 : ℂ) ≠ 0)) ?_
        linear_combination (norm := (push_cast; ring)) -hY
      rcases Nat.eq_zero_or_pos ν with hν0 | hνp
      · subst hν0
        rw [show (2 * 0 : ℕ) = 0 from rfl, hexTrace_zero_height,
          show (-3 * 3 ^ 0 : ℤ) = -3 by ring] at hH2
        have hv := Int.cast_injective (α := ℂ) hH2
        have hvals := u_zero_vals (uAddr c 0)
        omega
      · obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
        rw [show (-3 * 3 ^ (ν' + 1) : ℤ) = 3 * (-3 * 3 ^ ν') by ring] at hH2
        exact u_pin_kill_dvd (by omega) hH2
    · -- (even, odd): the even side reads `3^t·H₃ = 3^(μ+ν+2)`, dead on the pin
      rw [hν, hμ, show 2 * μ + (2 * ν + 1) + 1 = 2 * (μ + ν + 1) by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace t _ _ _).add
          (((InRing.intCast 3).mul (inRing_three_pow (μ + ν + 1))).neg))
        ((inRing_pow_trace ν _ _ _).add ((inRing_pow_trace μ _ _ _).neg))
        (show ((3 : ℂ) ^ t
              * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                (b - d).natAbs
              + -(((3 : ℤ) : ℂ) * (3 : ℂ) ^ (μ + ν + 1)))
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ)
                + -((3 : ℂ) ^ μ
                  * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1)))
            = 0 by
          push_cast
          linear_combination hcl)
      obtain ⟨e', he'⟩ : ∃ e', μ + ν + 1 = t + e' := ⟨μ + ν + 1 - t, by omega⟩
      have hH3 : hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
          (b - d).natAbs = ((3 ^ (e' + 1) : ℤ) : ℂ) := by
        refine mul_left_cancel₀ (pow_ne_zero t (by norm_num : (3 : ℂ) ≠ 0)) ?_
        rw [he'] at hX
        linear_combination (norm := (push_cast; ring)) hX
      exact g_pin_kill (by omega) hH3
  · rcases hν with hν | hν
    · -- (odd, even): the live-parity class of the chord family, refused by the shift
      rw [hν, hμ, show 2 * μ + 1 + 2 * ν + 1 = 2 * (μ + ν + 1) by ring,
        show 2 * μ + 1 + 1 = 2 * (μ + 1) by ring] at hcl
      simp only [sqrt3_pow_two_mul] at hcl
      rcases Nat.eq_zero_or_pos ν with hν0 | hνp
      · -- d = 0: the pin, the bound, and the two sign decides
        subst hν0
        obtain rfl : d = 0 := by omega
        obtain rfl : t = 0 := by omega
        have hk : (b - 0).natAbs = 2 * μ + 1 := by omega
        rw [hk, show (2 * 0 : ℕ) = 0 from rfl, hexTrace_zero_height] at hcl
        simp only [pow_zero, one_mul] at hcl
        rw [hexTrace_add] at hcl
        have hcomb : hexTrace (gE (gAddr A b) + gE (gAddr (A - c) (b - 0)))
            (gF (gAddr A b) + gF (gAddr (A - c) (b - 0))) (2 * μ + 1)
            = ((3 ^ (μ + 0 + 1)
                * ((2 * hexE (uAddr c 0).val + hexF (uAddr c 0).val) + 3) : ℤ) : ℂ) := by
          linear_combination (norm := (push_cast; ring)) hcl
        obtain ⟨hF, hval⟩ := hexTrace_pin (by omega) hcomb
        rcases eq_or_ne (gE (gAddr A b) + gE (gAddr (A - c) (b - 0))) 0 with h0 | hne
        · rw [h0, zero_mul] at hval
          have hzero : (2 * hexE (uAddr c 0).val + hexF (uAddr c 0).val) + 3 = 0 := by
            have h3 : (3 : ℤ) ^ (μ + 0 + 1) ≠ 0 := pow_ne_zero _ (by norm_num)
            rcases mul_eq_zero.mp hval.symm with hz | hz
            · exact absurd hz h3
            · exact hz
          have hvals := u_zero_vals (uAddr c 0)
          omega
        · have hdvd : (3 : ℤ) ^ (μ + 0 + 1)
              ∣ (gE (gAddr A b) + gE (gAddr (A - c) (b - 0))) :=
            Int.prime_three.pow_dvd_of_dvd_mul_right (μ + 0 + 1)
              (not_three_dvd_pin (2 * μ + 1) (by omega)) ⟨_, hval⟩
          have hbnd := gE_abs_le (gAddr A b) (gAddr (A - c) (b - 0))
          have hle : (3 : ℤ) ^ (μ + 0 + 1) ≤ 4 := by
            rcases lt_or_gt_of_ne hne with hlt | hgt
            · have := Int.le_of_dvd (by omega) ((dvd_neg).mpr hdvd)
              omega
            · have := Int.le_of_dvd (by omega) hdvd
              omega
          have hμ0 : μ = 0 := by
            by_contra hcon
            obtain ⟨μ', rfl⟩ : ∃ μ', μ = μ' + 1 := ⟨μ - 1, by omega⟩
            have h9 : (9 : ℤ) ≤ 3 ^ (μ' + 1 + 0 + 1) :=
              calc (9 : ℤ) = 3 ^ 2 := by norm_num
                _ ≤ 3 ^ (μ' + 1 + 0 + 1) := pow_le_pow_right₀ (by norm_num) (by omega)
            omega
          subst hμ0
          rw [show (2 * 0 + 1 : ℕ) = 1 from rfl, show (piCoeff 1).1 = 0 from rfl,
            show (piCoeff 1).2 = 1 from rfl] at hval
          have hval' : gE (gAddr A b) + gE (gAddr (A - c) (b - 0))
              = 3 * (2 * hexE (uAddr c 0).val + hexF (uAddr c 0).val + 3) := by
            have h31 : (3 : ℤ) ^ (0 + 0 + 1) = 3 := by norm_num
            rw [h31] at hval
            omega
          rcases (by omega : b = 1 ∨ b = -1) with rfl | rfl
          · rw [show gAddr A 1 = A from by rw [gAddr, if_pos (by norm_num)],
              show gAddr (A - c) ((1 : ℤ) - 0) = A - c from by
                rw [gAddr, if_pos (by norm_num)]] at hF hval'
            rw [show uAddr c 0 = c from by rw [uAddr, if_pos le_rfl]] at hval'
            exact ii_fusion_end_pos A c ⟨hF, hval'⟩
          · rw [show gAddr A (-1) = -A - 1 from by rw [gAddr, if_neg (by norm_num)],
              show gAddr (A - c) ((-1 : ℤ) - 0) = -(A - c) - 1 from by
                rw [gAddr, if_neg (by norm_num)]] at hF hval'
            rw [show uAddr c 0 = c from by rw [uAddr, if_pos le_rfl]] at hval'
            exact ii_fusion_end_neg A c ⟨hF, hval'⟩
      · -- d ≠ 0: dead exactly as the chord family's off-diagonal arms
        rcases Nat.eq_zero_or_pos t with ht0 | htp
        · subst ht0
          obtain ⟨R1, R2⟩ := hexTrace_rows_const hcl
          obtain ⟨ν', rfl⟩ : ∃ ν', ν = ν' + 1 := ⟨ν - 1, by omega⟩
          refine gE_gF_ne (gAddr (A - c) (b - d))
            (alone_dvd (p := (b - d).natAbs) (by omega)
              (R₁ := 3 ^ (μ + ν' + 2)
                  + 3 ^ μ * (hexE (uAddr c d).val * (piCoeff (2 * (ν' + 1))).1
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
        · rcases (by omega : ν ≤ μ ∨ μ < ν) with hle | hgt
          · -- n ≤ m: the pivot trace alone after dividing by `3^ν`
            obtain ⟨t', rfl⟩ : ∃ t', t = ν + 1 + t' := ⟨t - ν - 1, by omega⟩
            obtain ⟨μ', hμ'⟩ : ∃ μ', μ + 1 = ν + 1 + μ' := ⟨μ - ν, by omega⟩
            rw [hμ', show μ + (ν + 1) = ν + (μ + 1) by omega] at hcl
            have hdiv' : (3 : ℂ) ^ 0
                * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
                + (3 : ℂ) ^ (1 + t')
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs
                = ((3 : ℤ) : ℂ) * 3 ^ (μ + 1)
                  + (3 : ℂ) ^ (1 + μ')
                    * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val)
                      (2 * ν) := by
              refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
              push_cast
              linear_combination hcl
            obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv'
            refine gE_gF_ne (gAddr A b) (alone_dvd (p := 2 * μ + 1) (by omega)
              (R₁ := 3 ^ (μ + 1)
                  + 3 ^ μ' * (hexE (uAddr c d).val * (piCoeff (2 * ν)).1
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
          · -- n > m: the φ kill after dividing by `3^(μ+1)`
            obtain ⟨i', rfl⟩ : ∃ i', ν = μ + 1 + i' := ⟨ν - μ - 1, by omega⟩
            have htv : t = 2 * μ + 1 := by omega
            subst htv
            have hdiv' : (3 : ℂ) ^ i'
                * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
                + (3 : ℂ) ^ μ
                  * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                    (b - d).natAbs
                = ((3 : ℤ) : ℂ) * 3 ^ (μ + 1 + i')
                  + (3 : ℂ) ^ 0
                    * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val)
                      (2 * (μ + 1 + i')) := by
              refine mul_left_cancel₀ (pow_ne_zero (μ + 1) (by norm_num : (3 : ℂ) ≠ 0)) ?_
              linear_combination (norm := (push_cast; ring)) hcl
            obtain ⟨R1, R2⟩ := hexTrace_rows_const hdiv'
            obtain ⟨w₁, hw₁⟩ := phi_g_dvd (gAddr A b) (2 * μ + 1)
            obtain ⟨w₃, hw₃⟩ := phi_g_dvd (gAddr (A - c) (b - d)) ((b - d).natAbs)
            refine hex_diff_ne (uAddr c d)
              (phi_dvd (r := 2 * (μ + 1 + i')) (by omega)
                (S := 3 ^ i' * w₁ + 3 ^ μ * w₃ - 3 ^ (μ + 1 + i')) ?_)
            linear_combination -R1 - R2 + (3 : ℤ) ^ i' * hw₁ + (3 : ℤ) ^ μ * hw₃
    · -- (odd, odd): the odd side reads `3^ν·H₁ = 3^(μ+ν+2)`, dead on the pin
      rw [hν, hμ, show 2 * μ + 1 + (2 * ν + 1) + 1 = 2 * (μ + ν + 1) + 1 by ring,
        show 2 * μ + 1 + 1 = 2 * (μ + 1) by ring] at hcl
      simp only [sqrt3_pow_two_mul, pow_succ] at hcl
      obtain ⟨-, hY⟩ := eq_zero_of_add_sqrt3_mul
        ((inRing_pow_trace t _ _ _).add ((inRing_pow_trace (μ + 1) _ _ _).neg))
        ((inRing_pow_trace ν _ _ _).add
          (((InRing.intCast 3).mul (inRing_three_pow (μ + ν + 1))).neg))
        (show ((3 : ℂ) ^ t
              * hexTrace (gE (gAddr (A - c) (b - d))) (gF (gAddr (A - c) (b - d)))
                (b - d).natAbs
              + -((3 : ℂ) ^ (μ + 1)
                * hexTrace (hexE (uAddr c d).val) (hexF (uAddr c d).val) (2 * ν + 1)))
            + ((Real.sqrt 3 : ℝ) : ℂ)
              * ((3 : ℂ) ^ ν * hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
                + -(((3 : ℤ) : ℂ) * (3 : ℂ) ^ (μ + ν + 1))) = 0 by
          push_cast
          linear_combination hcl)
      have hH1 : hexTrace (gE (gAddr A b)) (gF (gAddr A b)) (2 * μ + 1)
          = ((3 ^ (μ + 2) : ℤ) : ℂ) := by
        refine mul_left_cancel₀ (pow_ne_zero ν (by norm_num : (3 : ℂ) ≠ 0)) ?_
        linear_combination (norm := (push_cast; ring)) hY
      exact g_pin_kill (by omega) hH1

/-- **The ii fusion, all three webs, is empty.** -/
theorem meta_fusion_ii (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    innerPt (pivot j) (pivot j + 1) a b ≠ innerPt metaPivot metaAnchor c d := by
  have hzero : ∀ (a' c' : ZMod 6) (b' d' : ℤ),
      innerPt 0 1 a' b' ≠ innerPt metaPivot metaAnchor c' d' := by
    intro a' c' b' d' he
    exact ii_fusion_classify
      (ii_fusion_master ((fusion_bridge_ii a' b' c' d').mp he))
  fin_cases j
  · show innerPt (pivot 0) (pivot 0 + 1) a b ≠ innerPt metaPivot metaAnchor c d
    rw [pivot_zero, zero_add]
    exact hzero a c b d
  · show innerPt (pivot 1) (pivot 1 + 1) a b ≠ innerPt metaPivot metaAnchor c d
    intro he
    rw [show innerPt (pivot 1) (pivot 1 + 1) a b
        = metaPivot + zeta6 ^ 2 * (innerPt (pivot 0) (pivot 0 + 1) (a - 2) b - metaPivot)
        from by rw [web_transport_rot_inner 0 (a - 2) b, sub_add_cancel,
          show (0 + 1 : Fin 3) = 1 from by decide],
      show innerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (innerPt metaPivot metaAnchor (c - 2) d - metaPivot)
        from by rw [web_transport_rot_meta_inner (c - 2) d, sub_add_cancel]] at he
    exact hzero (a - 2) (c - 2) b d (by
      have := metaRot_inj he
      rwa [pivot_zero, zero_add] at this)
  · show innerPt (pivot 2) (pivot 2 + 1) a b ≠ innerPt metaPivot metaAnchor c d
    intro he
    rw [show innerPt (pivot 2) (pivot 2 + 1) a b
        = metaPivot + zeta6 ^ 2 * (innerPt (pivot 1) (pivot 1 + 1) (a - 2) b - metaPivot)
        from by rw [web_transport_rot_inner 1 (a - 2) b, sub_add_cancel,
          show (1 + 1 : Fin 3) = 2 from by decide],
      show innerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (innerPt metaPivot metaAnchor (c - 2) d - metaPivot)
        from by rw [web_transport_rot_meta_inner (c - 2) d, sub_add_cancel]] at he
    have he1 := metaRot_inj he
    rw [show innerPt (pivot 1) (pivot 1 + 1) (a - 2) b
        = metaPivot + zeta6 ^ 2
          * (innerPt (pivot 0) (pivot 0 + 1) (a - 2 - 2) b - metaPivot)
        from by rw [web_transport_rot_inner 0 (a - 2 - 2) b, sub_add_cancel,
          show (0 + 1 : Fin 3) = 1 from by decide],
      show innerPt metaPivot metaAnchor (c - 2) d
        = metaPivot + zeta6 ^ 2
          * (innerPt metaPivot metaAnchor (c - 2 - 2) d - metaPivot)
        from by rw [web_transport_rot_meta_inner (c - 2 - 2) d, sub_add_cancel]] at he1
    exact hzero (a - 2 - 2) (c - 2 - 2) b d (by
      have := metaRot_inj he1
      rwa [pivot_zero, zero_add] at this)

/-- **io completeness, all three webs**: exactly the four table chords per web (the io
hub direction is `ζ₁₂/√3` — never a lattice word, M24's empty fibre). -/
theorem meta_io_complete (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    dist (innerPt (pivot j) (pivot j + 1) a b) (outerPt metaPivot metaAnchor c d) = 1 ↔
      (a - webShift j, b, c - webShift j, d) ∈ metaIOTable := by
  fin_cases j
  · show dist (innerPt (pivot 0) (pivot 0 + 1) a b) (outerPt metaPivot metaAnchor c d) = 1
      ↔ (a - webShift 0, b, c - webShift 0, d) ∈ metaIOTable
    rw [pivot_zero, zero_add, show webShift 0 = 0 from rfl, sub_zero, sub_zero]
    exact meta_io_zero a b c d
  · show dist (innerPt (pivot 1) (pivot 1 + 1) a b) (outerPt metaPivot metaAnchor c d) = 1
      ↔ (a - webShift 1, b, c - webShift 1, d) ∈ metaIOTable
    have h1 : innerPt (pivot 1) (pivot 1 + 1) a b
        = metaPivot + zeta6 ^ 2 * (innerPt (pivot 0) (pivot 0 + 1) (a - 2) b - metaPivot) := by
      rw [web_transport_rot_inner 0 (a - 2) b, sub_add_cancel,
        show (0 + 1 : Fin 3) = 1 from by decide]
    have h2 : outerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (outerPt metaPivot metaAnchor (c - 2) d - metaPivot) := by
      rw [web_transport_rot_meta (c - 2) d, sub_add_cancel]
    rw [h1, h2, dist_metaRot, pivot_zero, zero_add, show webShift 1 = 2 from rfl]
    exact meta_io_zero (a - 2) b (c - 2) d
  · show dist (innerPt (pivot 2) (pivot 2 + 1) a b) (outerPt metaPivot metaAnchor c d) = 1
      ↔ (a - webShift 2, b, c - webShift 2, d) ∈ metaIOTable
    have h1 : innerPt (pivot 2) (pivot 2 + 1) a b
        = metaPivot + zeta6 ^ 2 * (innerPt (pivot 1) (pivot 1 + 1) (a - 2) b - metaPivot) := by
      rw [web_transport_rot_inner 1 (a - 2) b, sub_add_cancel,
        show (1 + 1 : Fin 3) = 2 from by decide]
    have h2 : outerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (outerPt metaPivot metaAnchor (c - 2) d - metaPivot) := by
      rw [web_transport_rot_meta (c - 2) d, sub_add_cancel]
    have h1' : innerPt (pivot 1) (pivot 1 + 1) (a - 2) b
        = metaPivot + zeta6 ^ 2
          * (innerPt (pivot 0) (pivot 0 + 1) (a - 2 - 2) b - metaPivot) := by
      rw [web_transport_rot_inner 0 (a - 2 - 2) b, sub_add_cancel,
        show (0 + 1 : Fin 3) = 1 from by decide]
    have h2' : outerPt metaPivot metaAnchor (c - 2) d
        = metaPivot + zeta6 ^ 2
          * (outerPt metaPivot metaAnchor (c - 2 - 2) d - metaPivot) := by
      rw [web_transport_rot_meta (c - 2 - 2) d, sub_add_cancel]
    rw [h1, h2, dist_metaRot, h1', h2', dist_metaRot, pivot_zero, zero_add,
      show (a - webShift 2 : ZMod 6) = a - 2 - 2 from by
        rw [show webShift 2 = 4 from rfl]; ring,
      show (c - webShift 2 : ZMod 6) = c - 2 - 2 from by
        rw [show webShift 2 = 4 from rfl]; ring]
    exact meta_io_zero (a - 2 - 2) b (c - 2 - 2) d

/-- **The io fusion is empty**: a pivot's inner lattice and the metapivot's outer
lattice share no point (the 120°-partner glue points are off-lattice). -/
theorem meta_fusion_io (j : Fin 3) (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) :
    innerPt (pivot j) (pivot j + 1) a b ≠ outerPt metaPivot metaAnchor c d := by
  have hzero : ∀ (a' c' : ZMod 6) (b' d' : ℤ),
      innerPt 0 1 a' b' ≠ outerPt metaPivot metaAnchor c' d' := by
    intro a' c' b' d' he
    obtain ⟨h52, -⟩ := io_classify (Or.inr rfl)
      (io_master (R := 0) (κ := 5) (by norm_num) ((fusion_bridge_io a' b' c' d').mp he))
    norm_num at h52
  fin_cases j
  · show innerPt (pivot 0) (pivot 0 + 1) a b ≠ outerPt metaPivot metaAnchor c d
    rw [pivot_zero, zero_add]
    exact hzero a c b d
  · show innerPt (pivot 1) (pivot 1 + 1) a b ≠ outerPt metaPivot metaAnchor c d
    intro he
    rw [show innerPt (pivot 1) (pivot 1 + 1) a b
        = metaPivot + zeta6 ^ 2 * (innerPt (pivot 0) (pivot 0 + 1) (a - 2) b - metaPivot)
        from by rw [web_transport_rot_inner 0 (a - 2) b, sub_add_cancel,
          show (0 + 1 : Fin 3) = 1 from by decide],
      show outerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (outerPt metaPivot metaAnchor (c - 2) d - metaPivot)
        from by rw [web_transport_rot_meta (c - 2) d, sub_add_cancel]] at he
    exact hzero (a - 2) (c - 2) b d (by
      have := metaRot_inj he
      rwa [pivot_zero, zero_add] at this)
  · show innerPt (pivot 2) (pivot 2 + 1) a b ≠ outerPt metaPivot metaAnchor c d
    intro he
    rw [show innerPt (pivot 2) (pivot 2 + 1) a b
        = metaPivot + zeta6 ^ 2 * (innerPt (pivot 1) (pivot 1 + 1) (a - 2) b - metaPivot)
        from by rw [web_transport_rot_inner 1 (a - 2) b, sub_add_cancel,
          show (1 + 1 : Fin 3) = 2 from by decide],
      show outerPt metaPivot metaAnchor c d
        = metaPivot + zeta6 ^ 2 * (outerPt metaPivot metaAnchor (c - 2) d - metaPivot)
        from by rw [web_transport_rot_meta (c - 2) d, sub_add_cancel]] at he
    have he1 := metaRot_inj he
    rw [show innerPt (pivot 1) (pivot 1 + 1) (a - 2) b
        = metaPivot + zeta6 ^ 2
          * (innerPt (pivot 0) (pivot 0 + 1) (a - 2 - 2) b - metaPivot)
        from by rw [web_transport_rot_inner 0 (a - 2 - 2) b, sub_add_cancel,
          show (0 + 1 : Fin 3) = 1 from by decide],
      show outerPt metaPivot metaAnchor (c - 2) d
        = metaPivot + zeta6 ^ 2
          * (outerPt metaPivot metaAnchor (c - 2 - 2) d - metaPivot)
        from by rw [web_transport_rot_meta (c - 2 - 2) d, sub_add_cancel]] at he1
    exact hzero (a - 2 - 2) (c - 2 - 2) b d (by
      have := metaRot_inj he1
      rwa [pivot_zero, zero_add] at this)

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

/-! ### §C.1 The anchor geometry and the cross-anchor re-addressings -/

private theorem dist_01 : dist (0 : ℂ) 1 = 1 := Triangle.dist_pivot_01

private theorem dist_12 : dist (1 : ℂ) 2 = 1 := by
  rw [dist_eq_norm]
  norm_num

private theorem dist_2A : dist zeta6 (zeta6 + 1) = 1 := by
  rw [dist_eq_norm, show zeta6 - (zeta6 + 1) = -1 by ring, norm_neg, norm_one]

private theorem zeta6_pow4 : zeta6 ^ 4 = -zeta6 := by
  rw [show zeta6 ^ 4 = zeta6 ^ 3 * zeta6 by ring, zeta6_cube]
  ring

private theorem zeta6_pow5 : zeta6 ^ 5 = 1 - zeta6 := by
  rw [show zeta6 ^ 5 = zeta6 ^ 3 * zeta6 ^ 2 by ring, zeta6_cube]
  linear_combination -zeta6_minpoly

private theorem zeta6_pow6 : zeta6 ^ 6 = 1 := by
  rw [show zeta6 ^ 6 = zeta6 ^ 3 * zeta6 ^ 3 by ring, zeta6_cube]
  ring

/-- Anchor 1's ladder, re-addressed onto the matched pair `(1, 0)`. -/
private theorem outer1_swap (c : ZMod 6) (d : ℤ) :
    outerPt 1 2 c d = outerPt 1 0 (c + 3) d := by
  refine outerPt_hexRot 1 0 2 3 c d ?_
  rw [show (((3 : ZMod 6)).val : ℤ) = ((3 : ℕ) : ℤ) from rfl, zpow_natCast, zeta6_cube]
  ring

private theorem inner1_swap (c : ZMod 6) (d : ℤ) :
    innerPt 1 2 c d = innerPt 1 0 (c + 3) d := by
  refine innerPt_hexRot 1 0 2 3 c d ?_
  rw [show (((3 : ZMod 6)).val : ℤ) = ((3 : ℕ) : ℤ) from rfl, zpow_natCast, zeta6_cube]
  ring

/-- Anchor 0's ladder, re-addressed onto the pair `(0, ζ₆)`. -/
private theorem outer0_to02 (a : ZMod 6) (b : ℤ) :
    outerPt 0 1 a b = outerPt 0 zeta6 (a + 5) b := by
  refine outerPt_hexRot 0 zeta6 1 5 a b ?_
  rw [show (((5 : ZMod 6)).val : ℤ) = ((5 : ℕ) : ℤ) from rfl, zpow_natCast, zeta6_pow5]
  ring_nf
  linear_combination zeta6_minpoly

private theorem inner0_to02 (a : ZMod 6) (b : ℤ) :
    innerPt 0 1 a b = innerPt 0 zeta6 (a + 5) b := by
  refine innerPt_hexRot 0 zeta6 1 5 a b ?_
  rw [show (((5 : ZMod 6)).val : ℤ) = ((5 : ℕ) : ℤ) from rfl, zpow_natCast, zeta6_pow5]
  ring_nf
  linear_combination zeta6_minpoly

/-- Anchor 2's ladder, re-addressed onto the pair `(ζ₆, 0)`. -/
private theorem outer2_swap0 (c : ZMod 6) (d : ℤ) :
    outerPt zeta6 (zeta6 + 1) c d = outerPt zeta6 0 (c + 2) d := by
  refine outerPt_hexRot zeta6 0 (zeta6 + 1) 2 c d ?_
  rw [show (((2 : ZMod 6)).val : ℤ) = ((2 : ℕ) : ℤ) from rfl, zpow_natCast]
  linear_combination -zeta6_cube

private theorem inner2_swap0 (c : ZMod 6) (d : ℤ) :
    innerPt zeta6 (zeta6 + 1) c d = innerPt zeta6 0 (c + 2) d := by
  refine innerPt_hexRot zeta6 0 (zeta6 + 1) 2 c d ?_
  rw [show (((2 : ZMod 6)).val : ℤ) = ((2 : ℕ) : ℤ) from rfl, zpow_natCast]
  linear_combination -zeta6_cube

/-- Anchor 1's ladder, re-addressed onto the pair `(1, ζ₆)`. -/
private theorem outer1_to12 (a : ZMod 6) (b : ℤ) :
    outerPt 1 2 a b = outerPt 1 zeta6 (a + 4) b := by
  refine outerPt_hexRot 1 zeta6 2 4 a b ?_
  rw [show (((4 : ZMod 6)).val : ℤ) = ((4 : ℕ) : ℤ) from rfl, zpow_natCast, zeta6_pow4]
  linear_combination zeta6_minpoly

private theorem inner1_to12 (a : ZMod 6) (b : ℤ) :
    innerPt 1 2 a b = innerPt 1 zeta6 (a + 4) b := by
  refine innerPt_hexRot 1 zeta6 2 4 a b ?_
  rw [show (((4 : ZMod 6)).val : ℤ) = ((4 : ℕ) : ℤ) from rfl, zpow_natCast, zeta6_pow4]
  linear_combination zeta6_minpoly

/-- Anchor 2's ladder, re-addressed onto the pair `(ζ₆, 1)`. -/
private theorem outer2_swap1 (c : ZMod 6) (d : ℤ) :
    outerPt zeta6 (zeta6 + 1) c d = outerPt zeta6 1 (c + 1) d := by
  refine outerPt_hexRot zeta6 1 (zeta6 + 1) 1 c d ?_
  rw [show (((1 : ZMod 6)).val : ℤ) = ((1 : ℕ) : ℤ) from rfl, zpow_natCast, pow_one]
  linear_combination zeta6_minpoly

private theorem inner2_swap1 (c : ZMod 6) (d : ℤ) :
    innerPt zeta6 (zeta6 + 1) c d = innerPt zeta6 1 (c + 1) d := by
  refine innerPt_hexRot zeta6 1 (zeta6 + 1) 1 c d ?_
  rw [show (((1 : ZMod 6)).val : ℤ) = ((1 : ℕ) : ℤ) from rfl, zpow_natCast, pow_one]
  linear_combination zeta6_minpoly

/-- The pivot-form point of anchor 1, in decode currency. -/
private theorem pivot1_form (a : ZMod 6) (b : ℤ) :
    outerPt (pivot 1) (pivot 1 + 1) a b = outerPt 1 2 a b := by
  rw [pivot_one, show (1 : ℂ) + 1 = 2 by norm_num]

private theorem pivot1_form_inner (a : ZMod 6) (b : ℤ) :
    innerPt (pivot 1) (pivot 1 + 1) a b = innerPt 1 2 a b := by
  rw [pivot_one, show (1 : ℂ) + 1 = 2 by norm_num]

private theorem pivot2_form (a : ZMod 6) (b : ℤ) :
    outerPt (pivot 2) (pivot 2 + 1) a b = outerPt zeta6 (zeta6 + 1) a b := by
  rw [pivot_two]

private theorem pivot2_form_inner (a : ZMod 6) (b : ℤ) :
    innerPt (pivot 2) (pivot 2 + 1) a b = innerPt zeta6 (zeta6 + 1) a b := by
  rw [pivot_two]

/-! ### §C.2 The decode -/

open Classical in
/-- The colouring of the plane restricted to the four-ladder object: decode any address
in a fixed priority order, read `metaColTab` (`b` never enters — the colouring is
b-independent).  Well-defined on fused points because the table equalizes every
coincidence the fusion classifications allow.  Junk value `0` off the object. -/
noncomputable def metaColor (z : ℂ) : Fin 4 :=
  if h : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = z then metaColTab 0 false h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = z then metaColTab 0 true h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, outerPt 1 2 n.1 n.2 = z then metaColTab 1 false h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, innerPt 1 2 n.1 n.2 = z then metaColTab 1 true h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, outerPt zeta6 (zeta6 + 1) n.1 n.2 = z then
    metaColTab 2 false h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, innerPt zeta6 (zeta6 + 1) n.1 n.2 = z then
    metaColTab 2 true h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, outerPt metaPivot metaAnchor n.1 n.2 = z then
    metaColTab 3 false h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, innerPt metaPivot metaAnchor n.1 n.2 = z then
    metaColTab 3 true h.choose.1
  else 0

/-! ### §C.3 The read lemmas: the decode returns the table on every family, because
every earlier-priority coincidence lands on a table agreement -/

private theorem metaColor_o0 (a : ZMod 6) (b : ℤ) :
    metaColor (outerPt 0 1 a b) = metaColTab 0 false a := by
  have hex : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = outerPt 0 1 a b := ⟨(a, b), rfl⟩
  rw [metaColor, dif_pos hex]
  congr 1
  exact ((outerPt_inj dist_01 _ _ _ _).mp hex.choose_spec).1

private theorem metaColor_i0 (a : ZMod 6) (b : ℤ) :
    metaColor (innerPt 0 1 a b) = metaColTab 0 true a := by
  have hno : ¬ ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = innerPt 0 1 a b := by
    rintro ⟨n, hn⟩
    exact outer_ne_inner dist_01 n.1 n.2 a b hn
  have hex : ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = innerPt 0 1 a b := ⟨(a, b), rfl⟩
  rw [metaColor, dif_neg hno, dif_pos hex]
  congr 1
  exact ((innerPt_inj dist_01 _ _ _ _).mp hex.choose_spec).1

private theorem metaColor_o1 (a : ZMod 6) (b : ℤ) :
    metaColor (outerPt 1 2 a b) = metaColTab 1 false a := by
  by_cases hP : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = outerPt 1 2 a b
  · obtain ⟨n, hn⟩ := hP
    rw [metaColor, dif_pos ⟨n, hn⟩]
    have hspec := Exists.choose_spec
      (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, outerPt 0 1 m.1 m.2 = outerPt 1 2 a b)
    rw [outer1_swap] at hspec
    rcases (fusion_oo dist_01 _ _ (a + 3) b).mp hspec with ⟨h1, -, h3, -⟩ | ⟨h1, -, h3, -⟩
    · rw [h1, show a = 2 from by rw [eq_sub_of_add_eq h3]; decide]
      rfl
    · rw [h1, show a = 4 from by rw [eq_sub_of_add_eq h3]; decide]
      rfl
  · by_cases hPi : ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = outerPt 1 2 a b
    · obtain ⟨n, hn⟩ := hPi
      rw [metaColor, dif_neg hP, dif_pos ⟨n, hn⟩]
      have hspec := Exists.choose_spec
        (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, innerPt 0 1 m.1 m.2 = outerPt 1 2 a b)
      rw [outer1_swap] at hspec
      rcases (fusion_oi dist_01 _ _ (a + 3) b).mp hspec with ⟨h1, -, h3, -⟩ |
        ⟨h1, -, h3, -⟩
      · rw [h1, show a = 0 from by rw [eq_sub_of_add_eq h3]; decide]
        rfl
      · rw [h1, show a = 0 from by rw [eq_sub_of_add_eq h3]; decide]
        rfl
    · have hex : ∃ n : ZMod 6 × ℤ, outerPt 1 2 n.1 n.2 = outerPt 1 2 a b := ⟨(a, b), rfl⟩
      rw [metaColor, dif_neg hP, dif_neg hPi, dif_pos hex]
      congr 1
      exact ((outerPt_inj dist_12 _ _ _ _).mp hex.choose_spec).1

private theorem metaColor_i1 (a : ZMod 6) (b : ℤ) :
    metaColor (innerPt 1 2 a b) = metaColTab 1 true a := by
  by_cases hP : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = innerPt 1 2 a b
  · obtain ⟨n, hn⟩ := hP
    rw [metaColor, dif_pos ⟨n, hn⟩]
    have hspec := Exists.choose_spec
      (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, outerPt 0 1 m.1 m.2 = innerPt 1 2 a b)
    rw [inner1_swap] at hspec
    rcases (fusion_io dist_01 _ _ (a + 3) b).mp hspec with ⟨h1, -, h3, -⟩ | ⟨h1, -, h3, -⟩
    · rw [h1, show a = 3 from by rw [eq_sub_of_add_eq h3]; decide]
      rfl
    · rw [h1, show a = 3 from by rw [eq_sub_of_add_eq h3]; decide]
      rfl
  · have hPi : ¬ ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = innerPt 1 2 a b := by
      rintro ⟨n, hn⟩
      rw [inner1_swap] at hn
      exact fusion_ii dist_01 n.1 n.2 (a + 3) b hn
    have hQo : ¬ ∃ n : ZMod 6 × ℤ, outerPt 1 2 n.1 n.2 = innerPt 1 2 a b := by
      rintro ⟨n, hn⟩
      exact outer_ne_inner dist_12 n.1 n.2 a b hn
    have hex : ∃ n : ZMod 6 × ℤ, innerPt 1 2 n.1 n.2 = innerPt 1 2 a b := ⟨(a, b), rfl⟩
    rw [metaColor, dif_neg hP, dif_neg hPi, dif_neg hQo, dif_pos hex]
    congr 1
    exact ((innerPt_inj dist_12 _ _ _ _).mp hex.choose_spec).1

private theorem metaColor_o2 (a : ZMod 6) (b : ℤ) :
    metaColor (outerPt zeta6 (zeta6 + 1) a b) = metaColTab 2 false a := by
  by_cases h1 : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = outerPt zeta6 (zeta6 + 1) a b
  · obtain ⟨n, hn⟩ := h1
    rw [metaColor, dif_pos ⟨n, hn⟩]
    have hspec := Exists.choose_spec
      (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, outerPt 0 1 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)
    rw [outer0_to02, outer2_swap0] at hspec
    rcases (fusion_oo Triangle.dist_pivot_02 _ _ (a + 2) b).mp hspec with
      ⟨hx, -, hy, -⟩ | ⟨hx, -, hy, -⟩
    · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
          outerPt 0 1 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)).1 = 2 from by
            rw [eq_sub_of_add_eq hx]; decide,
        show a = 3 from by rw [eq_sub_of_add_eq hy]; decide]
      rfl
    · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
          outerPt 0 1 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)).1 = 0 from by
            rw [eq_sub_of_add_eq hx]; decide,
        show a = 5 from by rw [eq_sub_of_add_eq hy]; decide]
      rfl
  · by_cases h2 : ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = outerPt zeta6 (zeta6 + 1) a b
    · obtain ⟨n, hn⟩ := h2
      rw [metaColor, dif_neg h1, dif_pos ⟨n, hn⟩]
      have hspec := Exists.choose_spec
        (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, innerPt 0 1 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)
      rw [inner0_to02, outer2_swap0] at hspec
      rcases (fusion_oi Triangle.dist_pivot_02 _ _ (a + 2) b).mp hspec with
        ⟨hx, -, hy, -⟩ | ⟨hx, -, hy, -⟩
      · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
            innerPt 0 1 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)).1 = 1 from by
              rw [eq_sub_of_add_eq hx]; decide,
          show a = 1 from by rw [eq_sub_of_add_eq hy]; decide]
        rfl
      · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
            innerPt 0 1 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)).1 = 1 from by
              rw [eq_sub_of_add_eq hx]; decide,
          show a = 1 from by rw [eq_sub_of_add_eq hy]; decide]
        rfl
    · by_cases h3 : ∃ n : ZMod 6 × ℤ, outerPt 1 2 n.1 n.2 = outerPt zeta6 (zeta6 + 1) a b
      · obtain ⟨n, hn⟩ := h3
        rw [metaColor, dif_neg h1, dif_neg h2, dif_pos ⟨n, hn⟩]
        have hspec := Exists.choose_spec
          (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, outerPt 1 2 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)
        rw [outer1_to12, outer2_swap1] at hspec
        rcases (fusion_oo Triangle.dist_pivot_12 _ _ (a + 1) b).mp hspec with
          ⟨hx, -, hy, -⟩ | ⟨hx, -, hy, -⟩
        · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
              outerPt 1 2 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)).1 = 3 from by
                rw [eq_sub_of_add_eq hx]; decide,
            show a = 4 from by rw [eq_sub_of_add_eq hy]; decide]
          rfl
        · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
              outerPt 1 2 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)).1 = 1 from by
                rw [eq_sub_of_add_eq hx]; decide,
            show a = 0 from by rw [eq_sub_of_add_eq hy]; decide]
          rfl
      · by_cases h4 : ∃ n : ZMod 6 × ℤ, innerPt 1 2 n.1 n.2 = outerPt zeta6 (zeta6 + 1) a b
        · obtain ⟨n, hn⟩ := h4
          rw [metaColor, dif_neg h1, dif_neg h2, dif_neg h3, dif_pos ⟨n, hn⟩]
          have hspec := Exists.choose_spec
            (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
              innerPt 1 2 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)
          rw [inner1_to12, outer2_swap1] at hspec
          rcases (fusion_oi Triangle.dist_pivot_12 _ _ (a + 1) b).mp hspec with
            ⟨hx, -, hy, -⟩ | ⟨hx, -, hy, -⟩
          · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
                innerPt 1 2 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)).1 = 2 from by
                  rw [eq_sub_of_add_eq hx]; decide,
              show a = 2 from by rw [eq_sub_of_add_eq hy]; decide]
            rfl
          · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
                innerPt 1 2 m.1 m.2 = outerPt zeta6 (zeta6 + 1) a b)).1 = 2 from by
                  rw [eq_sub_of_add_eq hx]; decide,
              show a = 2 from by rw [eq_sub_of_add_eq hy]; decide]
            rfl
        · have hex : ∃ n : ZMod 6 × ℤ,
              outerPt zeta6 (zeta6 + 1) n.1 n.2 = outerPt zeta6 (zeta6 + 1) a b :=
            ⟨(a, b), rfl⟩
          rw [metaColor, dif_neg h1, dif_neg h2, dif_neg h3, dif_neg h4, dif_pos hex]
          congr 1
          exact ((outerPt_inj dist_2A _ _ _ _).mp hex.choose_spec).1

private theorem metaColor_i2 (a : ZMod 6) (b : ℤ) :
    metaColor (innerPt zeta6 (zeta6 + 1) a b) = metaColTab 2 true a := by
  by_cases h1 : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = innerPt zeta6 (zeta6 + 1) a b
  · obtain ⟨n, hn⟩ := h1
    rw [metaColor, dif_pos ⟨n, hn⟩]
    have hspec := Exists.choose_spec
      (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, outerPt 0 1 m.1 m.2 = innerPt zeta6 (zeta6 + 1) a b)
    rw [outer0_to02, inner2_swap0] at hspec
    rcases (fusion_io Triangle.dist_pivot_02 _ _ (a + 2) b).mp hspec with
      ⟨hx, -, hy, -⟩ | ⟨hx, -, hy, -⟩
    · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
          outerPt 0 1 m.1 m.2 = innerPt zeta6 (zeta6 + 1) a b)).1 = 4 from by
            rw [eq_sub_of_add_eq hx]; decide,
        show a = 4 from by rw [eq_sub_of_add_eq hy]; decide]
      rfl
    · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
          outerPt 0 1 m.1 m.2 = innerPt zeta6 (zeta6 + 1) a b)).1 = 4 from by
            rw [eq_sub_of_add_eq hx]; decide,
        show a = 4 from by rw [eq_sub_of_add_eq hy]; decide]
      rfl
  · have h2 : ¬ ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = innerPt zeta6 (zeta6 + 1) a b := by
      rintro ⟨n, hn⟩
      rw [inner0_to02, inner2_swap0] at hn
      exact fusion_ii Triangle.dist_pivot_02 _ _ (a + 2) b hn
    by_cases h3 : ∃ n : ZMod 6 × ℤ, outerPt 1 2 n.1 n.2 = innerPt zeta6 (zeta6 + 1) a b
    · obtain ⟨n, hn⟩ := h3
      rw [metaColor, dif_neg h1, dif_neg h2, dif_pos ⟨n, hn⟩]
      have hspec := Exists.choose_spec
        (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, outerPt 1 2 m.1 m.2 = innerPt zeta6 (zeta6 + 1) a b)
      rw [outer1_to12, inner2_swap1] at hspec
      rcases (fusion_io Triangle.dist_pivot_12 _ _ (a + 1) b).mp hspec with
        ⟨hx, -, hy, -⟩ | ⟨hx, -, hy, -⟩
      · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
            outerPt 1 2 m.1 m.2 = innerPt zeta6 (zeta6 + 1) a b)).1 = 5 from by
              rw [eq_sub_of_add_eq hx]; decide,
          show a = 5 from by rw [eq_sub_of_add_eq hy]; decide]
        rfl
      · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
            outerPt 1 2 m.1 m.2 = innerPt zeta6 (zeta6 + 1) a b)).1 = 5 from by
              rw [eq_sub_of_add_eq hx]; decide,
          show a = 5 from by rw [eq_sub_of_add_eq hy]; decide]
        rfl
    · have h4 : ¬ ∃ n : ZMod 6 × ℤ, innerPt 1 2 n.1 n.2 = innerPt zeta6 (zeta6 + 1) a b := by
        rintro ⟨n, hn⟩
        rw [inner1_to12, inner2_swap1] at hn
        exact fusion_ii Triangle.dist_pivot_12 _ _ (a + 1) b hn
      have h5 : ¬ ∃ n : ZMod 6 × ℤ,
          outerPt zeta6 (zeta6 + 1) n.1 n.2 = innerPt zeta6 (zeta6 + 1) a b := by
        rintro ⟨n, hn⟩
        exact outer_ne_inner dist_2A n.1 n.2 a b hn
      have hex : ∃ n : ZMod 6 × ℤ,
          innerPt zeta6 (zeta6 + 1) n.1 n.2 = innerPt zeta6 (zeta6 + 1) a b := ⟨(a, b), rfl⟩
      rw [metaColor, dif_neg h1, dif_neg h2, dif_neg h3, dif_neg h4, dif_pos hex]
      congr 1
      exact ((innerPt_inj dist_2A _ _ _ _).mp hex.choose_spec).1

private theorem metaColor_o3 (a : ZMod 6) (b : ℤ) :
    metaColor (outerPt metaPivot metaAnchor a b) = metaColTab 3 false a := by
  have h1 : ¬ ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = outerPt metaPivot metaAnchor a b := by
    rintro ⟨n, hn⟩
    have := meta_fusion_oo 0 n.1 n.2 a b
    rw [pivot_zero, zero_add] at this
    exact this hn
  have h2 : ¬ ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = outerPt metaPivot metaAnchor a b := by
    rintro ⟨n, hn⟩
    have := meta_fusion_io 0 n.1 n.2 a b
    rw [pivot_zero, zero_add] at this
    exact this hn
  have h3 : ¬ ∃ n : ZMod 6 × ℤ, outerPt 1 2 n.1 n.2 = outerPt metaPivot metaAnchor a b := by
    rintro ⟨n, hn⟩
    have := meta_fusion_oo 1 n.1 n.2 a b
    rw [pivot1_form] at this
    exact this hn
  have h4 : ¬ ∃ n : ZMod 6 × ℤ, innerPt 1 2 n.1 n.2 = outerPt metaPivot metaAnchor a b := by
    rintro ⟨n, hn⟩
    have := meta_fusion_io 1 n.1 n.2 a b
    rw [pivot1_form_inner] at this
    exact this hn
  have h5 : ¬ ∃ n : ZMod 6 × ℤ,
      outerPt zeta6 (zeta6 + 1) n.1 n.2 = outerPt metaPivot metaAnchor a b := by
    rintro ⟨n, hn⟩
    have := meta_fusion_oo 2 n.1 n.2 a b
    rw [pivot2_form] at this
    exact this hn
  have h6 : ¬ ∃ n : ZMod 6 × ℤ,
      innerPt zeta6 (zeta6 + 1) n.1 n.2 = outerPt metaPivot metaAnchor a b := by
    rintro ⟨n, hn⟩
    have := meta_fusion_io 2 n.1 n.2 a b
    rw [pivot2_form_inner] at this
    exact this hn
  have hex : ∃ n : ZMod 6 × ℤ,
      outerPt metaPivot metaAnchor n.1 n.2 = outerPt metaPivot metaAnchor a b :=
    ⟨(a, b), rfl⟩
  rw [metaColor, dif_neg h1, dif_neg h2, dif_neg h3, dif_neg h4, dif_neg h5, dif_neg h6,
    dif_pos hex]
  congr 1
  exact ((outerPt_inj dist_meta_metaAnchor _ _ _ _).mp hex.choose_spec).1

private theorem metaColor_i3 (a : ZMod 6) (b : ℤ) :
    metaColor (innerPt metaPivot metaAnchor a b) = metaColTab 3 true a := by
  by_cases h1 : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = innerPt metaPivot metaAnchor a b
  · obtain ⟨n, hn⟩ := h1
    rw [metaColor, dif_pos ⟨n, hn⟩]
    have hspec := Exists.choose_spec
      (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, outerPt 0 1 m.1 m.2 = innerPt metaPivot metaAnchor a b)
    rcases (meta_fusion_oi_zero _ _ a b).mp hspec with ⟨hx, -, hy, -⟩ | ⟨hx, -, hy, -⟩
    · rw [hx, hy]
      rfl
    · rw [hx, hy]
      rfl
  · by_cases h3 : ∃ n : ZMod 6 × ℤ, outerPt 1 2 n.1 n.2 = innerPt metaPivot metaAnchor a b
    · obtain ⟨n, hn⟩ := h3
      have h2 : ¬ ∃ n : ZMod 6 × ℤ,
          innerPt 0 1 n.1 n.2 = innerPt metaPivot metaAnchor a b := by
        rintro ⟨m, hm⟩
        have := meta_fusion_ii 0 m.1 m.2 a b
        rw [pivot_zero, zero_add] at this
        exact this hm
      rw [metaColor, dif_neg h1, dif_neg h2, dif_pos ⟨n, hn⟩]
      have hspec := Exists.choose_spec
        (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, outerPt 1 2 m.1 m.2 = innerPt metaPivot metaAnchor a b)
      have hiff := meta_fusion_oi 1
        (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
          outerPt 1 2 m.1 m.2 = innerPt metaPivot metaAnchor a b)).1
        (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
          outerPt 1 2 m.1 m.2 = innerPt metaPivot metaAnchor a b)).2 a b
      rw [pivot1_form, show webShift 1 = 2 from rfl] at hiff
      rcases hiff.mp hspec with ⟨hx, -, hy, -⟩ | ⟨hx, -, hy, -⟩
      · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
            outerPt 1 2 m.1 m.2 = innerPt metaPivot metaAnchor a b)).1 = 3 from by
              rw [eq_add_of_sub_eq hx]; decide,
          show a = 3 from by rw [eq_add_of_sub_eq hy]; decide]
        rfl
      · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
            outerPt 1 2 m.1 m.2 = innerPt metaPivot metaAnchor a b)).1 = 2 from by
              rw [eq_add_of_sub_eq hx]; decide,
          show a = 1 from by rw [eq_add_of_sub_eq hy]; decide]
        rfl
    · by_cases h5 : ∃ n : ZMod 6 × ℤ,
          outerPt zeta6 (zeta6 + 1) n.1 n.2 = innerPt metaPivot metaAnchor a b
      · obtain ⟨n, hn⟩ := h5
        have h2 : ¬ ∃ n : ZMod 6 × ℤ,
            innerPt 0 1 n.1 n.2 = innerPt metaPivot metaAnchor a b := by
          rintro ⟨m, hm⟩
          have := meta_fusion_ii 0 m.1 m.2 a b
          rw [pivot_zero, zero_add] at this
          exact this hm
        have h4 : ¬ ∃ n : ZMod 6 × ℤ,
            innerPt 1 2 n.1 n.2 = innerPt metaPivot metaAnchor a b := by
          rintro ⟨m, hm⟩
          have := meta_fusion_ii 1 m.1 m.2 a b
          rw [pivot1_form_inner] at this
          exact this hm
        rw [metaColor, dif_neg h1, dif_neg h2, dif_neg h3, dif_neg h4, dif_pos ⟨n, hn⟩]
        have hspec := Exists.choose_spec
          (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
            outerPt zeta6 (zeta6 + 1) m.1 m.2 = innerPt metaPivot metaAnchor a b)
        have hiff := meta_fusion_oi 2
          (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
            outerPt zeta6 (zeta6 + 1) m.1 m.2 = innerPt metaPivot metaAnchor a b)).1
          (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
            outerPt zeta6 (zeta6 + 1) m.1 m.2 = innerPt metaPivot metaAnchor a b)).2 a b
        rw [pivot2_form, show webShift 2 = 4 from rfl] at hiff
        rcases hiff.mp hspec with ⟨hx, -, hy, -⟩ | ⟨hx, -, hy, -⟩
        · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
              outerPt zeta6 (zeta6 + 1) m.1 m.2 = innerPt metaPivot metaAnchor a b)).1 = 5
              from by rw [eq_add_of_sub_eq hx]; decide,
            show a = 5 from by rw [eq_add_of_sub_eq hy]; decide]
          rfl
        · rw [show (Exists.choose (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ,
              outerPt zeta6 (zeta6 + 1) m.1 m.2 = innerPt metaPivot metaAnchor a b)).1 = 4
              from by rw [eq_add_of_sub_eq hx]; decide,
            show a = 3 from by rw [eq_add_of_sub_eq hy]; decide]
          rfl
      · have h2 : ¬ ∃ n : ZMod 6 × ℤ,
            innerPt 0 1 n.1 n.2 = innerPt metaPivot metaAnchor a b := by
          rintro ⟨m, hm⟩
          have := meta_fusion_ii 0 m.1 m.2 a b
          rw [pivot_zero, zero_add] at this
          exact this hm
        have h4 : ¬ ∃ n : ZMod 6 × ℤ,
            innerPt 1 2 n.1 n.2 = innerPt metaPivot metaAnchor a b := by
          rintro ⟨m, hm⟩
          have := meta_fusion_ii 1 m.1 m.2 a b
          rw [pivot1_form_inner] at this
          exact this hm
        have h6 : ¬ ∃ n : ZMod 6 × ℤ,
            innerPt zeta6 (zeta6 + 1) n.1 n.2 = innerPt metaPivot metaAnchor a b := by
          rintro ⟨m, hm⟩
          have := meta_fusion_ii 2 m.1 m.2 a b
          rw [pivot2_form_inner] at this
          exact this hm
        have h7 : ¬ ∃ n : ZMod 6 × ℤ,
            outerPt metaPivot metaAnchor n.1 n.2 = innerPt metaPivot metaAnchor a b := by
          rintro ⟨m, hm⟩
          exact outer_ne_inner dist_meta_metaAnchor m.1 m.2 a b hm
        have hex : ∃ n : ZMod 6 × ℤ,
            innerPt metaPivot metaAnchor n.1 n.2 = innerPt metaPivot metaAnchor a b :=
          ⟨(a, b), rfl⟩
        rw [metaColor, dif_neg h1, dif_neg h2, dif_neg h3, dif_neg h4, dif_neg h5,
          dif_neg h6, dif_neg h7, dif_pos hex]
        congr 1
        exact ((innerPt_inj dist_meta_metaAnchor _ _ _ _).mp hex.choose_spec).1

/-! ### §C.4 The table separations, decided once each -/

private theorem tabm_hex : ∀ (k : Fin 4) (a : ZMod 6),
    metaColTab k false a ≠ metaColTab k false (a + 1) := by decide

private theorem tabm_hex' : ∀ (k : Fin 4) (a : ZMod 6),
    metaColTab k false a ≠ metaColTab k false (a - 1) := by decide

private theorem tabm_rot3 : ∀ (k : Fin 4) (a : ZMod 6),
    metaColTab k true a ≠ metaColTab k true (a + 2) := by decide

private theorem tabm_rot3' : ∀ (k : Fin 4) (a : ZMod 6),
    metaColTab k true a ≠ metaColTab k true (a - 2) := by decide

private theorem tabm_seam : ∀ (k : Fin 4) (a : ZMod 6),
    metaColTab k false a ≠ metaColTab k true a := by decide

private theorem tab01_oi {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ oiTable) :
    metaColTab 0 false x ≠ metaColTab 1 true (z - 3) := by
  fin_cases hm <;> decide

private theorem tab01_io {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ oiTable) :
    metaColTab 0 true z ≠ metaColTab 1 false (x - 3) := by
  fin_cases hm <;> decide

private theorem tab01_ii {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ iiNormTable) :
    metaColTab 0 true x ≠ metaColTab 1 true (z - 3) := by
  fin_cases hm <;> decide

private theorem tab02_oi {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ oiTable) :
    metaColTab 0 false (x - 5) ≠ metaColTab 2 true (z - 2) := by
  fin_cases hm <;> decide

private theorem tab02_io {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ oiTable) :
    metaColTab 0 true (z - 5) ≠ metaColTab 2 false (x - 2) := by
  fin_cases hm <;> decide

private theorem tab02_ii {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ iiNormTable) :
    metaColTab 0 true (x - 5) ≠ metaColTab 2 true (z - 2) := by
  fin_cases hm <;> decide

private theorem tab12_oi {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ oiTable) :
    metaColTab 1 false (x - 4) ≠ metaColTab 2 true (z - 1) := by
  fin_cases hm <;> decide

private theorem tab12_io {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ oiTable) :
    metaColTab 1 true (z - 4) ≠ metaColTab 2 false (x - 1) := by
  fin_cases hm <;> decide

private theorem tab12_ii {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ iiNormTable) :
    metaColTab 1 true (x - 4) ≠ metaColTab 2 true (z - 1) := by
  fin_cases hm <;> decide

private theorem tab0m_oo {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaOOTable) :
    metaColTab 0 false x ≠ metaColTab 3 false z := by
  fin_cases hm <;> decide

private theorem tab1m_oo {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaOOTable) :
    metaColTab 1 false (x + 2) ≠ metaColTab 3 false (z + 2) := by
  fin_cases hm <;> decide

private theorem tab2m_oo {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaOOTable) :
    metaColTab 2 false (x + 4) ≠ metaColTab 3 false (z + 4) := by
  fin_cases hm <;> decide

private theorem tab0m_oi {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaOITable) :
    metaColTab 0 false x ≠ metaColTab 3 true z := by
  fin_cases hm <;> decide

private theorem tab1m_oi {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaOITable) :
    metaColTab 1 false (x + 2) ≠ metaColTab 3 true (z + 2) := by
  fin_cases hm <;> decide

private theorem tab2m_oi {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaOITable) :
    metaColTab 2 false (x + 4) ≠ metaColTab 3 true (z + 4) := by
  fin_cases hm <;> decide

private theorem tab0m_io {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaIOTable) :
    metaColTab 0 true x ≠ metaColTab 3 false z := by
  fin_cases hm <;> decide

private theorem tab1m_io {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaIOTable) :
    metaColTab 1 true (x + 2) ≠ metaColTab 3 false (z + 2) := by
  fin_cases hm <;> decide

private theorem tab2m_io {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaIOTable) :
    metaColTab 2 true (x + 4) ≠ metaColTab 3 false (z + 4) := by
  fin_cases hm <;> decide

private theorem tab0m_ii {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaIITable) :
    metaColTab 0 true x ≠ metaColTab 3 true z := by
  fin_cases hm <;> decide

private theorem tab1m_ii {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaIITable) :
    metaColTab 1 true (x + 2) ≠ metaColTab 3 true (z + 2) := by
  fin_cases hm <;> decide

private theorem tab2m_ii {x z : ZMod 6} {y w : ℤ} (hm : (x, y, z, w) ∈ metaIITable) :
    metaColTab 2 true (x + 4) ≠ metaColTab 3 true (z + 4) := by
  fin_cases hm <;> decide

/-! ### §C.5 Properness per family pair -/

private theorem dist_10 : dist (1 : ℂ) 0 = 1 := by
  rw [dist_comm]
  exact dist_01

private theorem dist_20 : dist zeta6 0 = 1 := by
  rw [dist_comm]
  exact Triangle.dist_pivot_02

private theorem dist_21 : dist zeta6 1 = 1 := by
  rw [dist_comm]
  exact Triangle.dist_pivot_12

private theorem valid_o0_o1 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 0 1 a b) (outerPt 1 2 c d) = 1) :
    metaColTab 0 false a ≠ metaColTab 1 false c := by
  rw [outer1_swap] at h
  rcases (oo_complete dist_01 a b (c + 3) d).mp h with ⟨h1, -⟩ | ⟨rfl, -⟩ | ⟨h1, -⟩
  · rw [add_right_cancel h1]
    exact (by decide : ∀ x : ZMod 6, metaColTab 0 false x ≠ metaColTab 1 false x) a
  · exact (by decide : ∀ x : ZMod 6, metaColTab 0 false 0 ≠ metaColTab 1 false x) c
  · rw [eq_sub_of_add_eq h1]
    exact (by decide : ∀ x : ZMod 6, metaColTab 0 false x ≠ metaColTab 1 false (0 - 3)) a

private theorem valid_o0_i1 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 0 1 a b) (innerPt 1 2 c d) = 1) :
    metaColTab 0 false a ≠ metaColTab 1 true c := by
  rw [inner1_swap] at h
  have hm := oi_complete a b (c + 3) d ((oi_chord_iff dist_01 a b (c + 3) d).mp h)
  have := tab01_oi hm
  rwa [show (c + 3 - 3 : ZMod 6) = c by ring] at this

private theorem valid_i0_o1 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 0 1 a b) (outerPt 1 2 c d) = 1) :
    metaColTab 0 true a ≠ metaColTab 1 false c := by
  rw [outer1_swap] at h
  have hm := oi_complete (c + 3) d a b
    ((oi_chord_iff dist_10 (c + 3) d a b).mp (by rwa [dist_comm] at h))
  have := tab01_io hm
  rwa [show (c + 3 - 3 : ZMod 6) = c by ring] at this

private theorem valid_i0_i1 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 0 1 a b) (innerPt 1 2 c d) = 1) :
    metaColTab 0 true a ≠ metaColTab 1 true c := by
  rw [inner1_swap] at h
  rcases (ii_chord_iff dist_01 a b (c + 3) d).mp h with ⟨h1, -⟩ | hnorm
  · rw [add_right_cancel h1]
    exact (by decide : ∀ x : ZMod 6, metaColTab 0 true x ≠ metaColTab 1 true x) a
  · have := tab01_ii (ii_norm_complete a b (c + 3) d hnorm)
    rwa [show (c + 3 - 3 : ZMod 6) = c by ring] at this

private theorem valid_o0_o2 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 0 1 a b) (outerPt zeta6 (zeta6 + 1) c d) = 1) :
    metaColTab 0 false a ≠ metaColTab 2 false c := by
  rw [outer0_to02, outer2_swap0] at h
  rcases (oo_complete Triangle.dist_pivot_02 (a + 5) b (c + 2) d).mp h with
    ⟨h1, -⟩ | ⟨h1, -⟩ | ⟨h1, -⟩
  · rw [show c = a + 5 + 3 - 2 from by rw [eq_sub_of_add_eq h1]]
    exact (by decide : ∀ x : ZMod 6,
      metaColTab 0 false x ≠ metaColTab 2 false (x + 5 + 3 - 2)) a
  · rw [show a = 0 - 5 from by rw [eq_sub_of_add_eq h1]]
    exact (by decide : ∀ x : ZMod 6, metaColTab 0 false (0 - 5) ≠ metaColTab 2 false x) c
  · rw [show c = 0 - 2 from by rw [eq_sub_of_add_eq h1]]
    exact (by decide : ∀ x : ZMod 6, metaColTab 0 false x ≠ metaColTab 2 false (0 - 2)) a

private theorem valid_o0_i2 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 0 1 a b) (innerPt zeta6 (zeta6 + 1) c d) = 1) :
    metaColTab 0 false a ≠ metaColTab 2 true c := by
  rw [outer0_to02, inner2_swap0] at h
  have hm := oi_complete (a + 5) b (c + 2) d
    ((oi_chord_iff Triangle.dist_pivot_02 (a + 5) b (c + 2) d).mp h)
  have := tab02_oi hm
  rwa [show (a + 5 - 5 : ZMod 6) = a by ring, show (c + 2 - 2 : ZMod 6) = c by ring] at this

private theorem valid_i0_o2 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 0 1 a b) (outerPt zeta6 (zeta6 + 1) c d) = 1) :
    metaColTab 0 true a ≠ metaColTab 2 false c := by
  rw [inner0_to02, outer2_swap0] at h
  have hm := oi_complete (c + 2) d (a + 5) b
    ((oi_chord_iff dist_20 (c + 2) d (a + 5) b).mp (by rwa [dist_comm] at h))
  have := tab02_io hm
  rwa [show (a + 5 - 5 : ZMod 6) = a by ring, show (c + 2 - 2 : ZMod 6) = c by ring] at this

private theorem valid_i0_i2 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 0 1 a b) (innerPt zeta6 (zeta6 + 1) c d) = 1) :
    metaColTab 0 true a ≠ metaColTab 2 true c := by
  rw [inner0_to02, inner2_swap0] at h
  rcases (ii_chord_iff Triangle.dist_pivot_02 (a + 5) b (c + 2) d).mp h with ⟨h1, -⟩ | hnorm
  · rw [show c = a + 5 + 3 - 2 from by rw [eq_sub_of_add_eq h1]]
    exact (by decide : ∀ x : ZMod 6,
      metaColTab 0 true x ≠ metaColTab 2 true (x + 5 + 3 - 2)) a
  · have := tab02_ii (ii_norm_complete (a + 5) b (c + 2) d hnorm)
    rwa [show (a + 5 - 5 : ZMod 6) = a by ring, show (c + 2 - 2 : ZMod 6) = c by ring] at this

private theorem valid_o1_o2 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 1 2 a b) (outerPt zeta6 (zeta6 + 1) c d) = 1) :
    metaColTab 1 false a ≠ metaColTab 2 false c := by
  rw [outer1_to12, outer2_swap1] at h
  rcases (oo_complete Triangle.dist_pivot_12 (a + 4) b (c + 1) d).mp h with
    ⟨h1, -⟩ | ⟨h1, -⟩ | ⟨h1, -⟩
  · rw [show c = a + 4 + 3 - 1 from by rw [eq_sub_of_add_eq h1]]
    exact (by decide : ∀ x : ZMod 6,
      metaColTab 1 false x ≠ metaColTab 2 false (x + 4 + 3 - 1)) a
  · rw [show a = 0 - 4 from by rw [eq_sub_of_add_eq h1]]
    exact (by decide : ∀ x : ZMod 6, metaColTab 1 false (0 - 4) ≠ metaColTab 2 false x) c
  · rw [show c = 0 - 1 from by rw [eq_sub_of_add_eq h1]]
    exact (by decide : ∀ x : ZMod 6, metaColTab 1 false x ≠ metaColTab 2 false (0 - 1)) a

private theorem valid_o1_i2 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 1 2 a b) (innerPt zeta6 (zeta6 + 1) c d) = 1) :
    metaColTab 1 false a ≠ metaColTab 2 true c := by
  rw [outer1_to12, inner2_swap1] at h
  have hm := oi_complete (a + 4) b (c + 1) d
    ((oi_chord_iff Triangle.dist_pivot_12 (a + 4) b (c + 1) d).mp h)
  have := tab12_oi hm
  rwa [show (a + 4 - 4 : ZMod 6) = a by ring, show (c + 1 - 1 : ZMod 6) = c by ring] at this

private theorem valid_i1_o2 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 1 2 a b) (outerPt zeta6 (zeta6 + 1) c d) = 1) :
    metaColTab 1 true a ≠ metaColTab 2 false c := by
  rw [inner1_to12, outer2_swap1] at h
  have hm := oi_complete (c + 1) d (a + 4) b
    ((oi_chord_iff dist_21 (c + 1) d (a + 4) b).mp (by rwa [dist_comm] at h))
  have := tab12_io hm
  rwa [show (a + 4 - 4 : ZMod 6) = a by ring, show (c + 1 - 1 : ZMod 6) = c by ring] at this

private theorem valid_i1_i2 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 1 2 a b) (innerPt zeta6 (zeta6 + 1) c d) = 1) :
    metaColTab 1 true a ≠ metaColTab 2 true c := by
  rw [inner1_to12, inner2_swap1] at h
  rcases (ii_chord_iff Triangle.dist_pivot_12 (a + 4) b (c + 1) d).mp h with ⟨h1, -⟩ | hnorm
  · rw [show c = a + 4 + 3 - 1 from by rw [eq_sub_of_add_eq h1]]
    exact (by decide : ∀ x : ZMod 6,
      metaColTab 1 true x ≠ metaColTab 2 true (x + 4 + 3 - 1)) a
  · have := tab12_ii (ii_norm_complete (a + 4) b (c + 1) d hnorm)
    rwa [show (a + 4 - 4 : ZMod 6) = a by ring, show (c + 1 - 1 : ZMod 6) = c by ring] at this

private theorem valid_o0_o3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 0 1 a b) (outerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 0 false a ≠ metaColTab 3 false c :=
  tab0m_oo ((meta_oo_zero a b c d).mp h)

private theorem valid_o0_i3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 0 1 a b) (innerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 0 false a ≠ metaColTab 3 true c := by
  rcases (meta_oi_zero a b c d).mp h with hc | hm
  · rw [Prod.mk.injEq] at hc
    obtain ⟨rfl, -⟩ := hc
    exact (by decide : ∀ x : ZMod 6, metaColTab 0 false x ≠ metaColTab 3 true 3) a
  · exact tab0m_oi hm

private theorem valid_i0_o3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 0 1 a b) (outerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 0 true a ≠ metaColTab 3 false c :=
  tab0m_io ((meta_io_zero a b c d).mp h)

private theorem valid_i0_i3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 0 1 a b) (innerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 0 true a ≠ metaColTab 3 true c := by
  rw [show innerPt 0 1 a b = innerPt (pivot 0) (pivot 0 + 1) a b from by
    rw [pivot_zero, zero_add]] at h
  have hm := (meta_ii_complete 0 a b c d).mp h
  rw [show webShift 0 = 0 from rfl, sub_zero, sub_zero] at hm
  exact tab0m_ii hm

private theorem valid_o1_o3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 1 2 a b) (outerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 1 false a ≠ metaColTab 3 false c := by
  rw [← pivot1_form] at h
  have hm := (meta_oo_complete 1 a b c d).mp h
  rw [show webShift 1 = 2 from rfl] at hm
  have := tab1m_oo hm
  rwa [sub_add_cancel, sub_add_cancel] at this

private theorem valid_o1_i3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 1 2 a b) (innerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 1 false a ≠ metaColTab 3 true c := by
  rw [← pivot1_form] at h
  rcases (meta_oi_complete 1 a b c d).mp h with hc | hm
  · rw [show webShift 1 = 2 from rfl, Prod.mk.injEq] at hc
    obtain ⟨hc3, -⟩ := hc
    rw [show c = 3 + 2 from by rw [eq_add_of_sub_eq hc3]]
    exact (by decide : ∀ x : ZMod 6, metaColTab 1 false x ≠ metaColTab 3 true (3 + 2)) a
  · rw [show webShift 1 = 2 from rfl] at hm
    have := tab1m_oi hm
    rwa [sub_add_cancel, sub_add_cancel] at this

private theorem valid_i1_o3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 1 2 a b) (outerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 1 true a ≠ metaColTab 3 false c := by
  rw [← pivot1_form_inner] at h
  have hm := (meta_io_complete 1 a b c d).mp h
  rw [show webShift 1 = 2 from rfl] at hm
  have := tab1m_io hm
  rwa [sub_add_cancel, sub_add_cancel] at this

private theorem valid_i1_i3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 1 2 a b) (innerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 1 true a ≠ metaColTab 3 true c := by
  rw [← pivot1_form_inner] at h
  have hm := (meta_ii_complete 1 a b c d).mp h
  rw [show webShift 1 = 2 from rfl] at hm
  have := tab1m_ii hm
  rwa [sub_add_cancel, sub_add_cancel] at this

private theorem valid_o2_o3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt zeta6 (zeta6 + 1) a b) (outerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 2 false a ≠ metaColTab 3 false c := by
  rw [← pivot2_form] at h
  have hm := (meta_oo_complete 2 a b c d).mp h
  rw [show webShift 2 = 4 from rfl] at hm
  have := tab2m_oo hm
  rwa [sub_add_cancel, sub_add_cancel] at this

private theorem valid_o2_i3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt zeta6 (zeta6 + 1) a b) (innerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 2 false a ≠ metaColTab 3 true c := by
  rw [← pivot2_form] at h
  rcases (meta_oi_complete 2 a b c d).mp h with hc | hm
  · rw [show webShift 2 = 4 from rfl, Prod.mk.injEq] at hc
    obtain ⟨hc3, -⟩ := hc
    rw [show c = 3 + 4 from by rw [eq_add_of_sub_eq hc3]]
    exact (by decide : ∀ x : ZMod 6, metaColTab 2 false x ≠ metaColTab 3 true (3 + 4)) a
  · rw [show webShift 2 = 4 from rfl] at hm
    have := tab2m_oi hm
    rwa [sub_add_cancel, sub_add_cancel] at this

private theorem valid_i2_o3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt zeta6 (zeta6 + 1) a b) (outerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 2 true a ≠ metaColTab 3 false c := by
  rw [← pivot2_form_inner] at h
  have hm := (meta_io_complete 2 a b c d).mp h
  rw [show webShift 2 = 4 from rfl] at hm
  have := tab2m_io hm
  rwa [sub_add_cancel, sub_add_cancel] at this

private theorem valid_i2_i3 {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt zeta6 (zeta6 + 1) a b) (innerPt metaPivot metaAnchor c d) = 1) :
    metaColTab 2 true a ≠ metaColTab 3 true c := by
  rw [← pivot2_form_inner] at h
  have hm := (meta_ii_complete 2 a b c d).mp h
  rw [show webShift 2 = 4 from rfl] at hm
  have := tab2m_ii hm
  rwa [sub_add_cancel, sub_add_cancel] at this

/-! ### §C.6 The membership classification and the properness theorem -/

/-- Every point of the object is a labelled point of one of the eight families, in the
decode's own currency. -/
private theorem mem_fourLadder_cases {z : ℂ} (hz : z ∈ fourLadder) :
    (∃ a b, z = outerPt 0 1 a b) ∨ (∃ a b, z = innerPt 0 1 a b)
    ∨ (∃ a b, z = outerPt 1 2 a b) ∨ (∃ a b, z = innerPt 1 2 a b)
    ∨ (∃ a b, z = outerPt zeta6 (zeta6 + 1) a b)
    ∨ (∃ a b, z = innerPt zeta6 (zeta6 + 1) a b)
    ∨ (∃ a b, z = outerPt metaPivot metaAnchor a b)
    ∨ (∃ a b, z = innerPt metaPivot metaAnchor a b) := by
  simp only [fourLadder, Set.mem_iUnion, Set.mem_union, Set.mem_setOf_eq] at hz
  obtain ⟨k, hz⟩ := hz
  fin_cases k
  · rcases hz with ⟨a, b, hab⟩ | ⟨a, b, hab⟩
    · refine Or.inl ⟨a, b, ?_⟩
      rw [hab]
      show outerPt (anchor 0).1 (anchor 0).2 a b = outerPt 0 1 a b
      rw [anchor_zero]
    · refine Or.inr (Or.inl ⟨a, b, ?_⟩)
      rw [hab]
      show innerPt (anchor 0).1 (anchor 0).2 a b = innerPt 0 1 a b
      rw [anchor_zero]
  · rcases hz with ⟨a, b, hab⟩ | ⟨a, b, hab⟩
    · refine Or.inr (Or.inr (Or.inl ⟨a, b, ?_⟩))
      rw [hab]
      show outerPt (anchor 1).1 (anchor 1).2 a b = outerPt 1 2 a b
      rw [anchor_one]
    · refine Or.inr (Or.inr (Or.inr (Or.inl ⟨a, b, ?_⟩)))
      rw [hab]
      show innerPt (anchor 1).1 (anchor 1).2 a b = innerPt 1 2 a b
      rw [anchor_one]
  · rcases hz with ⟨a, b, hab⟩ | ⟨a, b, hab⟩
    · refine Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨a, b, ?_⟩))))
      rw [hab]
      show outerPt (anchor 2).1 (anchor 2).2 a b = outerPt zeta6 (zeta6 + 1) a b
      rw [anchor_two]
    · refine Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨a, b, ?_⟩)))))
      rw [hab]
      show innerPt (anchor 2).1 (anchor 2).2 a b = innerPt zeta6 (zeta6 + 1) a b
      rw [anchor_two]
  · rcases hz with ⟨a, b, hab⟩ | ⟨a, b, hab⟩
    · refine Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨a, b, ?_⟩))))))
      rw [hab]
      show outerPt (anchor 3).1 (anchor 3).2 a b = outerPt metaPivot metaAnchor a b
      rw [anchor_three]
    · refine Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr ⟨a, b, ?_⟩))))))
      rw [hab]
      show innerPt (anchor 3).1 (anchor 3).2 a b = innerPt metaPivot metaAnchor a b
      rw [anchor_three]

/-- **Properness**: the table separates every chord the completeness theorems allow. -/
theorem metaColor_valid {z w : ℂ} (hz : z ∈ fourLadder) (hw : w ∈ fourLadder)
    (h : dist z w = 1) : metaColor z ≠ metaColor w := by
  rcases mem_fourLadder_cases hz with ⟨a, b, rfl⟩ | ⟨a, b, rfl⟩ | ⟨a, b, rfl⟩ |
    ⟨a, b, rfl⟩ | ⟨a, b, rfl⟩ | ⟨a, b, rfl⟩ | ⟨a, b, rfl⟩ | ⟨a, b, rfl⟩ <;>
    rcases mem_fourLadder_cases hw with ⟨c, d, rfl⟩ | ⟨c, d, rfl⟩ | ⟨c, d, rfl⟩ |
      ⟨c, d, rfl⟩ | ⟨c, d, rfl⟩ | ⟨c, d, rfl⟩ | ⟨c, d, rfl⟩ | ⟨c, d, rfl⟩
  -- row o0
  · rw [metaColor_o0, metaColor_o0]
    rcases (intra_outer_complete dist_01 a b c d).mp h with ⟨hc | hc, -⟩
    · subst hc; exact tabm_hex 0 a
    · subst hc; exact tabm_hex' 0 a
  · rw [metaColor_o0, metaColor_i0]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_01 a b c d).mp h
    exact tabm_seam 0 _
  · rw [metaColor_o0, metaColor_o1]; exact valid_o0_o1 h
  · rw [metaColor_o0, metaColor_i1]; exact valid_o0_i1 h
  · rw [metaColor_o0, metaColor_o2]; exact valid_o0_o2 h
  · rw [metaColor_o0, metaColor_i2]; exact valid_o0_i2 h
  · rw [metaColor_o0, metaColor_o3]; exact valid_o0_o3 h
  · rw [metaColor_o0, metaColor_i3]; exact valid_o0_i3 h
  -- row i0
  · rw [metaColor_i0, metaColor_o0]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_01 c d a b).mp (by rwa [dist_comm] at h)
    exact (tabm_seam 0 _).symm
  · rw [metaColor_i0, metaColor_i0]
    rcases (intra_inner_complete dist_01 a b c d).mp h with ⟨hc | hc, -⟩
    · subst hc; exact tabm_rot3 0 a
    · subst hc; exact tabm_rot3' 0 a
  · rw [metaColor_i0, metaColor_o1]; exact valid_i0_o1 h
  · rw [metaColor_i0, metaColor_i1]; exact valid_i0_i1 h
  · rw [metaColor_i0, metaColor_o2]; exact valid_i0_o2 h
  · rw [metaColor_i0, metaColor_i2]; exact valid_i0_i2 h
  · rw [metaColor_i0, metaColor_o3]; exact valid_i0_o3 h
  · rw [metaColor_i0, metaColor_i3]; exact valid_i0_i3 h
  -- row o1
  · rw [metaColor_o1, metaColor_o0]
    exact (valid_o0_o1 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o1, metaColor_i0]
    exact (valid_i0_o1 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o1, metaColor_o1]
    rcases (intra_outer_complete dist_12 a b c d).mp h with ⟨hc | hc, -⟩
    · subst hc; exact tabm_hex 1 a
    · subst hc; exact tabm_hex' 1 a
  · rw [metaColor_o1, metaColor_i1]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_12 a b c d).mp h
    exact tabm_seam 1 _
  · rw [metaColor_o1, metaColor_o2]; exact valid_o1_o2 h
  · rw [metaColor_o1, metaColor_i2]; exact valid_o1_i2 h
  · rw [metaColor_o1, metaColor_o3]; exact valid_o1_o3 h
  · rw [metaColor_o1, metaColor_i3]; exact valid_o1_i3 h
  -- row i1
  · rw [metaColor_i1, metaColor_o0]
    exact (valid_o0_i1 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i1, metaColor_i0]
    exact (valid_i0_i1 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i1, metaColor_o1]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_12 c d a b).mp (by rwa [dist_comm] at h)
    exact (tabm_seam 1 _).symm
  · rw [metaColor_i1, metaColor_i1]
    rcases (intra_inner_complete dist_12 a b c d).mp h with ⟨hc | hc, -⟩
    · subst hc; exact tabm_rot3 1 a
    · subst hc; exact tabm_rot3' 1 a
  · rw [metaColor_i1, metaColor_o2]; exact valid_i1_o2 h
  · rw [metaColor_i1, metaColor_i2]; exact valid_i1_i2 h
  · rw [metaColor_i1, metaColor_o3]; exact valid_i1_o3 h
  · rw [metaColor_i1, metaColor_i3]; exact valid_i1_i3 h
  -- row o2
  · rw [metaColor_o2, metaColor_o0]
    exact (valid_o0_o2 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o2, metaColor_i0]
    exact (valid_i0_o2 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o2, metaColor_o1]
    exact (valid_o1_o2 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o2, metaColor_i1]
    exact (valid_i1_o2 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o2, metaColor_o2]
    rcases (intra_outer_complete dist_2A a b c d).mp h with ⟨hc | hc, -⟩
    · subst hc; exact tabm_hex 2 a
    · subst hc; exact tabm_hex' 2 a
  · rw [metaColor_o2, metaColor_i2]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_2A a b c d).mp h
    exact tabm_seam 2 _
  · rw [metaColor_o2, metaColor_o3]; exact valid_o2_o3 h
  · rw [metaColor_o2, metaColor_i3]; exact valid_o2_i3 h
  -- row i2
  · rw [metaColor_i2, metaColor_o0]
    exact (valid_o0_i2 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i2, metaColor_i0]
    exact (valid_i0_i2 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i2, metaColor_o1]
    exact (valid_o1_i2 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i2, metaColor_i1]
    exact (valid_i1_i2 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i2, metaColor_o2]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_2A c d a b).mp (by rwa [dist_comm] at h)
    exact (tabm_seam 2 _).symm
  · rw [metaColor_i2, metaColor_i2]
    rcases (intra_inner_complete dist_2A a b c d).mp h with ⟨hc | hc, -⟩
    · subst hc; exact tabm_rot3 2 a
    · subst hc; exact tabm_rot3' 2 a
  · rw [metaColor_i2, metaColor_o3]; exact valid_i2_o3 h
  · rw [metaColor_i2, metaColor_i3]; exact valid_i2_i3 h
  -- row o3
  · rw [metaColor_o3, metaColor_o0]
    exact (valid_o0_o3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o3, metaColor_i0]
    exact (valid_i0_o3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o3, metaColor_o1]
    exact (valid_o1_o3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o3, metaColor_i1]
    exact (valid_i1_o3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o3, metaColor_o2]
    exact (valid_o2_o3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o3, metaColor_i2]
    exact (valid_i2_o3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_o3, metaColor_o3]
    rcases (intra_outer_complete dist_meta_metaAnchor a b c d).mp h with ⟨hc | hc, -⟩
    · subst hc; exact tabm_hex 3 a
    · subst hc; exact tabm_hex' 3 a
  · rw [metaColor_o3, metaColor_i3]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_meta_metaAnchor a b c d).mp h
    exact tabm_seam 3 _
  -- row i3
  · rw [metaColor_i3, metaColor_o0]
    exact (valid_o0_i3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i3, metaColor_i0]
    exact (valid_i0_i3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i3, metaColor_o1]
    exact (valid_o1_i3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i3, metaColor_i1]
    exact (valid_i1_i3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i3, metaColor_o2]
    exact (valid_o2_i3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i3, metaColor_i2]
    exact (valid_i2_i3 (by rwa [dist_comm] at h)).symm
  · rw [metaColor_i3, metaColor_o3]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_meta_metaAnchor c d a b).mp
      (by rwa [dist_comm] at h)
    exact (tabm_seam 3 _).symm
  · rw [metaColor_i3, metaColor_i3]
    rcases (intra_inner_complete dist_meta_metaAnchor a b c d).mp h with ⟨hc | hc, -⟩
    · subst hc; exact tabm_rot3 3 a
    · subst hc; exact tabm_rot3' 3 a

theorem colorable_four_fourLadder :
    ((unitDistance ℂ).induce fourLadder).Colorable 4 :=
  ⟨SimpleGraph.Coloring.mk (fun v => metaColor (v : ℂ))
    (fun {v w} hvw => metaColor_valid v.2 w.2 (unitDistance_adj.mp hvw))⟩

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
