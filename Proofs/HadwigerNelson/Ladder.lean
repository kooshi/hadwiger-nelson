import Proofs.HadwigerNelson.Triangle
import Mathlib.NumberTheory.Real.Irrational

/-!
# M24 — The matched ladder pair: chord completeness and χ = 4 (skeleton)

The countable object at the heart of the two-pivot system: each pivot's **ladder** — the
`⟨ζ₆, σ⟩`-lattice on its two circles, anchored along the axis — and the matched pair of
both pivots' ladders. The M23 census measured this object through a window; M24 makes the
chord list *exact* by completeness theorems and lands the colouring unconditionally:

* **the master identities**: every distance between parametrized points of the pair is
  `‖q−p‖·‖1 − x − v‖` (cross) or `‖q−p‖·‖x − v‖` (intra) — one equation family carries
  every chord and every fusion of this milestone and its successors (M25–M27);
* **completeness**: the cross-chord families are exactly matching ∪ hub ∪ twelve sporadic
  ∪ finitely many glue-incident chords — the ii branch through the Möbius involution
  `μ(z) = (z−√3)/(√3z−1)` (norm form `(√3u−1)(√3v−1) = −2` ⟺ `v = μ(u)`), the oi branch
  through the finite solution set of `‖√3(1−x) − v‖² = 3`;
* **the colouring**: a single b-independent table (§0 experiment E6 — no splice, no
  defect window) colours the whole pair; with the nine-point witness the chromatic
  number is exactly 4.

The address group is `ZMod 6 × ℤ` — torsion times free is exactly the backbone theorem
(`σ` of infinite order, `ζ₆` of order six), so addresses are *canonical names*: the
completeness statements are equalities in `ZMod 6`, never divisibilities in `ℤ`.
Everything is anchored at the pair `(0, 1)` where the statements are consumed, and
stated for a general unit pair where generality is free. §0 ground truth:
`plans/M24-completeness.md`, `build/m24-derive.py`.
-/

namespace HadwigerNelson
namespace Ladder

open Complex TwoCircle Compulsion Coupled

/-! ## §0 Shared arithmetic -/

private theorem sq_sqrt3 : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt11 : Real.sqrt 11 * Real.sqrt 11 = 11 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt33 : Real.sqrt 33 * Real.sqrt 33 = 33 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sqrt3_pos : (0 : ℝ) < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)

/-- The single algebraic root of the hex layer (Triangle's engine, restated here: it is
`private` there, and every hex identity below is a `linear_combination` over it). -/
private theorem zeta6_minpoly : zeta6 ^ 2 - zeta6 + 1 = 0 := by
  apply Complex.ext <;>
    simp [zeta6, pow_two, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt3]

private theorem zeta6_cube : zeta6 ^ 3 = -1 := by
  linear_combination (zeta6 + 1) * zeta6_minpoly

private theorem zeta6_mul_conj : zeta6 * (starRingEnd ℂ) zeta6 = 1 := by
  rw [Complex.mul_conj, ← Complex.sq_norm, norm_zeta6]
  norm_num

private theorem seam_mul_conj : seam * (starRingEnd ℂ) seam = 1 := by
  rw [Complex.mul_conj, ← Complex.sq_norm, norm_seam]
  norm_num

/-- The fibre lemma: on the unit circle the real part determines the point up to
conjugation. Every intra-family and fusion classification is one instance of it. -/
private theorem unit_eq_of_re {w c : ℂ} (hw : normSq w = 1) (hc : normSq c = 1)
    (hre : w.re = c.re) : w = c ∨ w = (starRingEnd ℂ) c := by
  have him : w.im ^ 2 = c.im ^ 2 := by
    simp only [normSq_apply] at hw hc
    rw [hre] at hw
    linear_combination hw - hc
  rcases sq_eq_sq_iff_eq_or_eq_neg.mp him with h | h
  · exact Or.inl (Complex.ext hre h)
  · exact Or.inr (Complex.ext (by simpa using hre) (by simpa using h))

/-! ## §A The lattice words -/

/-- The ladder word `ζ₆^a · σ^b`: the direction of the lattice point at address `(a, b)`.
`σ = TwoCircle.seam` has infinite order (M19) and `ζ₆` order six, so `ZMod 6 × ℤ` is the
true address group and `word` is injective on it (`word_inj`). -/
noncomputable def word (a : ZMod 6) (b : ℤ) : ℂ := zeta6 ^ (a.val : ℤ) * seam ^ b

/-- The hex exponent is read modulo six: any integer representative gives the same word. -/
private theorem zeta6_zpow_val (m : ℤ) :
    zeta6 ^ (((m : ZMod 6).val : ℕ) : ℤ) = zeta6 ^ m := by
  have hdvd : (6 : ℤ) ∣ (((m : ZMod 6).val : ℕ) : ℤ) - m := by
    refine (ZMod.intCast_zmod_eq_zero_iff_dvd _ 6).mp ?_
    push_cast
    simp [ZMod.natCast_val]
  have h1 : zeta6 ^ ((((m : ZMod 6).val : ℕ) : ℤ) - m) = 1 := zeta6_zpow_eq_one_iff.mpr hdvd
  rw [zpow_sub₀ zeta6_ne_zero, div_eq_one_iff_eq (zpow_ne_zero _ zeta6_ne_zero)] at h1
  exact h1

private theorem word_intCast (a : ℤ) (b : ℤ) : word (a : ZMod 6) b = zeta6 ^ a * seam ^ b := by
  rw [word, zeta6_zpow_val]

theorem word_add (a c : ZMod 6) (b d : ℤ) :
    word (a + c) (b + d) = word a b * word c d := by
  have hc : (((a.val : ℤ) + (c.val : ℤ) : ℤ) : ZMod 6) = a + c := by
    push_cast
    simp [ZMod.natCast_val]
  calc word (a + c) (b + d)
      = word ((((a.val : ℤ) + (c.val : ℤ) : ℤ)) : ZMod 6) (b + d) := by rw [hc]
    _ = zeta6 ^ ((a.val : ℤ) + (c.val : ℤ)) * seam ^ (b + d) := word_intCast _ _
    _ = word a b * word c d := by
        rw [zpow_add₀ zeta6_ne_zero, zpow_add₀ seam_ne_zero, word, word]
        ring

theorem word_norm (a : ZMod 6) (b : ℤ) : ‖word a b‖ = 1 := by
  simp [word, norm_zpow, norm_zeta6, norm_seam]

theorem word_normSq (a : ZMod 6) (b : ℤ) : normSq (word a b) = 1 := by
  rw [← Complex.sq_norm, word_norm]
  norm_num

theorem word_ne_zero (a : ZMod 6) (b : ℤ) : word a b ≠ 0 := fun h => by
  have := word_norm a b
  rw [h, norm_zero] at this
  norm_num at this

theorem word_conj (a : ZMod 6) (b : ℤ) :
    (starRingEnd ℂ) (word a b) = word (-a) (-b) := by
  have hz : (starRingEnd ℂ) zeta6 = zeta6 ^ (-1 : ℤ) := by
    rw [zpow_neg, zpow_one]
    exact eq_inv_of_mul_eq_one_right zeta6_mul_conj
  have hs : (starRingEnd ℂ) seam = seam ^ (-1 : ℤ) := by
    rw [zpow_neg, zpow_one]
    exact eq_inv_of_mul_eq_one_right seam_mul_conj
  have hna : ((-(a.val : ℤ) : ℤ) : ZMod 6) = -a := by
    push_cast
    simp [ZMod.natCast_val]
  calc (starRingEnd ℂ) (word a b)
      = zeta6 ^ (-(a.val : ℤ)) * seam ^ (-b) := by
        simp only [word, map_mul, map_zpow₀, hz, hs, ← zpow_mul]
        ring_nf
    _ = word ((-(a.val : ℤ) : ℤ) : ZMod 6) (-b) := (word_intCast _ _).symm
    _ = word (-a) (-b) := by rw [hna]

/-- The backbone, re-addressed: the lattice is free over `ZMod 6 × ℤ`
(Triangle's `zeta6_zpow_mul_seam_zpow_eq_one_iff`). -/
theorem word_eq_one_iff (a : ZMod 6) (b : ℤ) : word a b = 1 ↔ (a = 0 ∧ b = 0) := by
  rw [word, Triangle.zeta6_zpow_mul_seam_zpow_eq_one_iff]
  constructor
  · rintro ⟨⟨k, hk⟩, rfl⟩
    refine ⟨?_, rfl⟩
    have hlt : a.val < 6 := ZMod.val_lt a
    have : a.val = 0 := by omega
    exact (ZMod.val_eq_zero a).mp this
  · rintro ⟨rfl, rfl⟩
    exact ⟨⟨0, by simp⟩, rfl⟩

theorem word_inj (a c : ZMod 6) (b d : ℤ) :
    word a b = word c d ↔ (a = c ∧ b = d) := by
  constructor
  · intro h
    have hmul : word (a - c) (b - d) * word c d = word a b := by
      rw [← word_add]
      simp
    rw [h] at hmul
    have h1 : word (a - c) (b - d) = 1 :=
      mul_right_cancel₀ (word_ne_zero c d) (by simpa using hmul)
    obtain ⟨h2, h3⟩ := (word_eq_one_iff _ _).mp h1
    exact ⟨sub_eq_zero.mp h2, sub_eq_zero.mp h3⟩
  · rintro ⟨rfl, rfl⟩
    rfl

/-- The matching branch in address form: `−1 = ζ₆³`. -/
theorem word_neg_iff (a c : ZMod 6) (b d : ℤ) :
    word c d = -word a b ↔ (c = a + 3 ∧ d = b) := by
  have h3 : word 3 0 = -1 := by
    rw [show ((3 : ZMod 6)) = ((3 : ℤ) : ZMod 6) by decide, word_intCast]
    rw [show ((3 : ℤ)) = ((3 : ℕ) : ℤ) by rfl, zpow_natCast, zpow_zero, mul_one]
    exact zeta6_cube
  have hrw : -word a b = word (3 + a) (0 + b) := by
    rw [word_add, h3]
    ring
  rw [hrw, word_inj]
  constructor
  · rintro ⟨h1, h2⟩
    exact ⟨by rw [h1]; ring, by omega⟩
  · rintro ⟨h1, h2⟩
    exact ⟨by rw [h1]; ring, by omega⟩

/-! ## §B The ladder points and the pair -/

/-- The outer-circle lattice point of the pivot `p` (partner `q`) at address `(a, b)`. -/
noncomputable def outerPt (p q : ℂ) (a : ZMod 6) (b : ℤ) : ℂ := p + word a b * (q - p)

/-- The inner-circle lattice point: same direction, radius `1/√3`. -/
noncomputable def innerPt (p q : ℂ) (a : ZMod 6) (b : ℤ) : ℂ :=
  p + ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word a b * (q - p)

/-- The matched ladder pair at the `(0, 1)` anchor: both pivots' outer and inner
lattices. The pivots are members automatically — each is the other side's
`outerPt _ _ 0 0` — so no vertex is special-cased. -/
noncomputable def ladderSet : Set ℂ :=
  (Set.range fun n : ZMod 6 × ℤ => outerPt 0 1 n.1 n.2) ∪
    (Set.range fun n : ZMod 6 × ℤ => innerPt 0 1 n.1 n.2) ∪
    ((Set.range fun n : ZMod 6 × ℤ => outerPt 1 0 n.1 n.2) ∪
      (Set.range fun n : ZMod 6 × ℤ => innerPt 1 0 n.1 n.2))

/-! ## §C The master identities (E1) -/

/-- **The cross identity**: the distance between parametrized points of the two systems.
Pure algebra — no torus hypothesis, no unit axis. Every cross family of M24–M27 is an
instance. -/
theorem cross_dist (p q x v : ℂ) :
    dist (p + x * (q - p)) (q + v * (p - q)) = ‖q - p‖ * ‖1 - x - v‖ := by
  rw [dist_eq_norm, ← norm_mul, ← norm_neg]
  congr 1
  ring

/-- **The intra identity**: the distance between parametrized points of one system. -/
theorem intra_dist (p q x v : ℂ) :
    dist (p + x * (q - p)) (p + v * (q - p)) = ‖q - p‖ * ‖x - v‖ := by
  rw [dist_eq_norm, ← norm_mul]
  congr 1
  ring

/-! ### Consequences of the identities, in the shape the families consume -/

private theorem norm_axis {p q : ℂ} (h : dist p q = 1) : ‖q - p‖ = 1 := by
  rw [← dist_eq_norm, dist_comm]
  exact h

private theorem norm_eq_one_iff {z : ℂ} : ‖z‖ = 1 ↔ normSq z = 1 := by
  rw [← Complex.sq_norm]
  constructor
  · intro h; rw [h]; norm_num
  · intro h; nlinarith [norm_nonneg z]

/-- The quantity every family is really about: on units, a scaled difference's squared
length is an affine function of one real part. -/
private theorem normSq_sub_smul {u v : ℂ} (hu : normSq u = 1) (hv : normSq v = 1) (t : ℝ) :
    normSq (u - (t : ℂ) * v) = 1 + t ^ 2 - 2 * t * (u * (starRingEnd ℂ) v).re := by
  simp only [normSq_apply, Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im,
    Complex.ofReal_re, Complex.ofReal_im, Complex.conj_re, Complex.conj_im] at *
  nlinarith [hu, hv]

private theorem word_mul_conj_word (a c : ZMod 6) (b d : ℤ) :
    word a b * (starRingEnd ℂ) (word c d) = word (a - c) (b - d) := by
  rw [word_conj, ← word_add, sub_eq_add_neg, sub_eq_add_neg]

/-- The fibre lemma at a word: a word with a known real part is that point or its
conjugate. -/
private theorem word_eq_of_re {A : ZMod 6} {B : ℤ} {c : ℂ} (hc : normSq c = 1)
    (hre : (word A B).re = c.re) : word A B = c ∨ word A B = (starRingEnd ℂ) c :=
  unit_eq_of_re (word_normSq A B) hc hre

/-! ## §D The cross-chord bridges (general unit pair) -/

private theorem word_mul_conj (a : ZMod 6) (b : ℤ) :
    word a b * (starRingEnd ℂ) (word a b) = 1 := by
  rw [Complex.mul_conj, word_normSq]
  norm_num

private theorem sqrt3_cast_sq : ((Real.sqrt 3 : ℝ) : ℂ) * ((Real.sqrt 3 : ℝ) : ℂ) = 3 := by
  rw [← Complex.ofReal_mul, sq_sqrt3]
  norm_num

private theorem inner_ratio_cast : ((Real.sqrt 3 / 3 : ℝ) : ℂ) = ((Real.sqrt 3 : ℝ) : ℂ) / 3 := by
  push_cast
  ring

/-- **The inner–inner chord key**: on units, the inner-circle chord condition factors as
the matching branch times the **norm branch** `u + v = √3(uv + 1)` — the symmetric,
division-free form of `(√3u−1)(√3v−1) = −2`. Sympy-derived cofactors. -/
private theorem ii_key {u v : ℂ} (hu : u * (starRingEnd ℂ) u = 1)
    (hv : v * (starRingEnd ℂ) v = 1) :
    normSq (1 - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * (u + v)) = 1 ↔
      (u + v) * ((u + v) - ((Real.sqrt 3 : ℝ) : ℂ) * (u * v + 1)) = 0 := by
  have hu0 : u ≠ 0 := fun hz => by simp [hz] at hu
  have hv0 : v ≠ 0 := fun hz => by simp [hz] at hv
  have hT := sqrt3_cast_sq
  have hconj : (starRingEnd ℂ) (1 - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * (u + v))
      = 1 - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * ((starRingEnd ℂ) u + (starRingEnd ℂ) v) := by
    rw [map_sub, map_one, map_mul, Complex.conj_ofReal, map_add]
  have hbridge : normSq (1 - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * (u + v)) = 1 ↔
      (1 - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * (u + v))
        * (1 - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * ((starRingEnd ℂ) u + (starRingEnd ℂ) v)) = 1 := by
    rw [← hconj, Complex.mul_conj]
    constructor
    · intro hz; rw [hz]; norm_num
    · intro hz; exact_mod_cast hz
  rw [hbridge, inner_ratio_cast]
  set T := ((Real.sqrt 3 : ℝ) : ℂ) with hTdef
  constructor
  · intro hK
    linear_combination (3 * (u * v)) * hK + (-T * v * (T * u + T * v - 3) / 3) * hu
      + (-T * u * (T * u + T * v - 3) / 3) * hv + (-(u + v) ^ 2 / 3) * hT
  · intro hfac
    have hmul : (3 * (u * v)) * ((1 - T / 3 * (u + v))
        * (1 - T / 3 * ((starRingEnd ℂ) u + (starRingEnd ℂ) v)) - 1) = 0 := by
      linear_combination hfac - (-T * v * (T * u + T * v - 3) / 3) * hu
        - (-T * u * (T * u + T * v - 3) / 3) * hv - (-(u + v) ^ 2 / 3) * hT
    rcases mul_eq_zero.mp hmul with hz | hz
    · exact absurd hz (by simpa using mul_ne_zero hu0 hv0)
    · exact sub_eq_zero.mp hz

/-- **Outer–outer completeness**: matching translate, or one endpoint is the other
pivot (the hub branches). The factorization `(x+v)(x−1)(v−1) = 0` in address form —
no sporadics exist on this family. -/
theorem oo_complete {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    dist (outerPt p q a b) (outerPt q p c d) = 1 ↔
      ((c = a + 3 ∧ d = b) ∨ (a = 0 ∧ b = 0) ∨ (c = 0 ∧ d = 0)) := by
  rw [outerPt, outerPt, cross_dist, norm_axis h, one_mul, norm_eq_one_iff,
    show (1 : ℂ) - word a b - word c d = -(word a b + word c d - 1) by ring, normSq_neg,
    Triangle.unit_chord_units (word_mul_conj a b) (word_mul_conj c d),
    mul_eq_zero, mul_eq_zero, sub_eq_zero, sub_eq_zero,
    show (word a b + word c d = 0) ↔ word c d = -word a b from
      ⟨fun hz => by linear_combination hz, fun hz => by rw [hz]; ring⟩,
    word_neg_iff, word_eq_one_iff, word_eq_one_iff]
  tauto

/-- **The inner–inner bridge**: the matching translate (in address form, like
`oo_complete`), or the **norm branch** `u + v = √3(uv + 1)` — whose complete lattice
solution set is `ii_norm_complete`. -/
theorem ii_chord_iff {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    dist (innerPt p q a b) (innerPt q p c d) = 1 ↔
      ((c = a + 3 ∧ d = b) ∨
        word a b + word c d = ((Real.sqrt 3 : ℝ) : ℂ) * (word a b * word c d + 1)) := by
  rw [innerPt, innerPt, cross_dist, norm_axis h, one_mul, norm_eq_one_iff,
    show (1 : ℂ) - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word a b
        - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word c d
      = 1 - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * (word a b + word c d) by ring,
    ii_key (word_mul_conj a b) (word_mul_conj c d), mul_eq_zero,
    show (word a b + word c d = 0) ↔ word c d = -word a b from
      ⟨fun hz => by linear_combination hz, fun hz => by rw [hz]; ring⟩,
    word_neg_iff, sub_eq_zero]

/-- **The outer–inner bridge**: the unfactorable branch, as the norm equation of
`A = √3(1−x) − v` (E1: identical to M23's three-term identity). The io family is this
bridge read at the swapped anchor — no separate theorem. -/
theorem oi_chord_iff {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    dist (outerPt p q a b) (innerPt q p c d) = 1 ↔
      normSq (((Real.sqrt 3 : ℝ) : ℂ) * (1 - word a b) - word c d) = 3 := by
  have hscale : ((Real.sqrt 3 : ℝ) : ℂ) * (1 - word a b) - word c d
      = ((Real.sqrt 3 : ℝ) : ℂ)
        * (1 - word a b - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word c d) := by
    rw [inner_ratio_cast]
    linear_combination (word c d / 3) * sqrt3_cast_sq
  have hns : normSq ((Real.sqrt 3 : ℝ) : ℂ) = 3 := by
    simp only [normSq_apply, Complex.ofReal_re, Complex.ofReal_im]
    nlinarith [sq_sqrt3]
  rw [outerPt, innerPt, cross_dist, norm_axis h, one_mul, norm_eq_one_iff, hscale, map_mul, hns]
  constructor
  · intro hz; rw [hz]; norm_num
  · intro hz; linarith

/-! ### The real-part fibres

Every intra family and every fusion is "which words have this real part" — five fibres,
each an instance of `word_eq_of_re` closed by `word_inj`. Stating them once is what makes
the eleven classification theorems below one line each. -/

private theorem word_10 : word 1 0 = zeta6 := by
  rw [word, show ((1 : ZMod 6).val : ℤ) = 1 from rfl]
  norm_num

private theorem word_01 : word 0 1 = seam := by
  rw [word, show ((0 : ZMod 6).val : ℤ) = 0 from rfl]
  norm_num

private theorem word_20 : word 2 0 = zeta6 ^ 2 := by
  rw [word, show ((2 : ZMod 6).val : ℤ) = ((2 : ℕ) : ℤ) from rfl, zpow_natCast, zpow_zero,
    mul_one]

private theorem word_32 : word 3 2 = -seam ^ 2 := by
  rw [word, show ((3 : ZMod 6).val : ℤ) = 3 from rfl,
    show ((3 : ℤ)) = ((3 : ℕ) : ℤ) from rfl, zpow_natCast, zeta6_cube,
    show ((2 : ℤ)) = ((2 : ℕ) : ℤ) from rfl, zpow_natCast]
  ring

private theorem word_30 : word 3 0 = -1 := by
  rw [show ((3 : ZMod 6)) = ((3 : ℤ) : ZMod 6) by decide, word_intCast,
    show ((3 : ℤ)) = ((3 : ℕ) : ℤ) from rfl, zpow_natCast, zpow_zero, mul_one]
  exact zeta6_cube

private theorem word_conj_10 : word 5 0 = (starRingEnd ℂ) zeta6 := by
  rw [← word_10, word_conj]
  rfl

private theorem word_conj_01 : word 0 (-1) = (starRingEnd ℂ) seam := by
  rw [← word_01, word_conj]
  rfl

private theorem word_conj_20 : word 4 0 = (starRingEnd ℂ) (zeta6 ^ 2) := by
  rw [← word_20, word_conj]
  rfl

private theorem word_conj_32 : word 3 (-2) = (starRingEnd ℂ) (-seam ^ 2) := by
  rw [← word_32, word_conj]
  rfl

/-- The io glue point with the conjugation pushed inside — the shape `ring` can use. -/
private theorem word_32' : word 3 (-2) = -((starRingEnd ℂ) seam) ^ 2 := by
  rw [word_conj_32, map_neg, map_pow]

private theorem re_zeta6 : zeta6.re = 1 / 2 := rfl

private theorem re_zeta6_sq : (zeta6 ^ 2).re = -(1 / 2) := by
  have := congrArg Complex.re zeta6_minpoly
  simp only [Complex.sub_re, Complex.add_re, Complex.one_re, Complex.zero_re, re_zeta6] at this
  linarith

private theorem re_seam : seam.re = Real.sqrt 3 / 6 := rfl

private theorem re_neg_seam_sq : (-seam ^ 2).re = 5 / 6 := by
  simp only [Complex.neg_re, pow_two, Complex.mul_re, seam]
  nlinarith [sq_sqrt3, sq_sqrt33]

/-- The `Re = 1/2` fibre: the hex neighbours. -/
private theorem re_eq_half_iff (A : ZMod 6) (B : ℤ) :
    (word A B).re = 1 / 2 ↔ ((A = 1 ∨ A = 5) ∧ B = 0) := by
  constructor
  · intro hre
    rcases word_eq_of_re (c := zeta6) (by rw [← Complex.sq_norm, norm_zeta6]; norm_num)
      (by rw [hre, re_zeta6]) with h | h
    · rw [← word_10, word_inj] at h
      exact ⟨Or.inl h.1, h.2⟩
    · rw [← word_conj_10, word_inj] at h
      exact ⟨Or.inr h.1, h.2⟩
  · rintro ⟨h | h, rfl⟩ <;> subst h
    · rw [word_10, re_zeta6]
    · rw [word_conj_10, Complex.conj_re, re_zeta6]

/-- The `Re = −1/2` fibre: the rot3 partners. -/
private theorem re_eq_neg_half_iff (A : ZMod 6) (B : ℤ) :
    (word A B).re = -(1 / 2) ↔ ((A = 2 ∨ A = 4) ∧ B = 0) := by
  constructor
  · intro hre
    rcases word_eq_of_re (c := zeta6 ^ 2)
      (by rw [← Complex.sq_norm, norm_pow, norm_zeta6]; norm_num)
      (by rw [hre, re_zeta6_sq]) with h | h
    · rw [← word_20, word_inj] at h
      exact ⟨Or.inl h.1, h.2⟩
    · rw [← word_conj_20, word_inj] at h
      exact ⟨Or.inr h.1, h.2⟩
  · rintro ⟨h | h, rfl⟩ <;> subst h
    · rw [word_20, re_zeta6_sq]
    · rw [word_conj_20, Complex.conj_re, re_zeta6_sq]

/-- The `Re = √3/6` fibre: the seam steps. -/
private theorem re_eq_seam_iff (A : ZMod 6) (B : ℤ) :
    (word A B).re = Real.sqrt 3 / 6 ↔ (A = 0 ∧ (B = 1 ∨ B = -1)) := by
  constructor
  · intro hre
    rcases word_eq_of_re (c := seam) (by rw [← Complex.sq_norm, norm_seam]; norm_num)
      (by rw [hre, re_seam]) with h | h
    · rw [← word_01, word_inj] at h
      exact ⟨h.1, Or.inl h.2⟩
    · rw [← word_conj_01, word_inj] at h
      exact ⟨h.1, Or.inr h.2⟩
  · rintro ⟨rfl, h | h⟩ <;> subst h
    · rw [word_01, re_seam]
    · rw [word_conj_01, Complex.conj_re, re_seam]

/-- The `Re = 5/6` fibre: the io glue points. -/
private theorem re_eq_five_sixths_iff (A : ZMod 6) (B : ℤ) :
    (word A B).re = 5 / 6 ↔ (A = 3 ∧ (B = 2 ∨ B = -2)) := by
  have hn : normSq (-seam ^ 2) = 1 := by
    rw [← Complex.sq_norm, norm_neg, norm_pow, norm_seam]
    norm_num
  constructor
  · intro hre
    rcases word_eq_of_re (c := -seam ^ 2) hn (by rw [hre, re_neg_seam_sq]) with h | h
    · rw [← word_32, word_inj] at h
      exact ⟨h.1, Or.inl h.2⟩
    · rw [← word_conj_32, word_inj] at h
      exact ⟨h.1, Or.inr h.2⟩
  · rintro ⟨rfl, h | h⟩ <;> subst h
    · rw [word_32, re_neg_seam_sq]
    · rw [word_conj_32, Complex.conj_re, re_neg_seam_sq]

/-- The `Re = √3/2` fibre is EMPTY: that real part names `ζ₁₂`, twelfth-order torsion,
and the lattice's torsion is exactly the hex sixth. This is the metapivot blind spot
(M23) as an arithmetic fact. -/
private theorem re_ne_sqrt3_half (A : ZMod 6) (B : ℤ) :
    (word A B).re ≠ Real.sqrt 3 / 2 := by
  intro hre
  have hz12 : normSq (⟨Real.sqrt 3 / 2, 1 / 2⟩ : ℂ) = 1 := by
    simp only [normSq_apply]
    nlinarith [sq_sqrt3]
  have hsq : (⟨Real.sqrt 3 / 2, 1 / 2⟩ : ℂ) ^ 2 = zeta6 := by
    apply Complex.ext <;>
      simp [pow_two, Complex.mul_re, Complex.mul_im, zeta6] <;>
      nlinarith [sq_sqrt3]
  have hsq' : ((starRingEnd ℂ) (⟨Real.sqrt 3 / 2, 1 / 2⟩ : ℂ)) ^ 2 = (starRingEnd ℂ) zeta6 := by
    rw [← map_pow, hsq]
  have hdouble : word (A + A) (B + B) = word A B * word A B := word_add A A B B
  have hbad : ∀ e : ZMod 6, 2 * e ≠ 1 ∧ 2 * e ≠ 5 := by decide
  rcases word_eq_of_re hz12 (by rw [hre]) with h | h
  · have h2 : word (A + A) (B + B) = zeta6 := by rw [hdouble, h, ← pow_two, hsq]
    rw [← word_10, word_inj] at h2
    exact absurd (by rw [← h2.1]; ring) (hbad A).1
  · have h2 : word (A + A) (B + B) = (starRingEnd ℂ) zeta6 := by rw [hdouble, h, ← pow_two, hsq']
    rw [← word_conj_10, word_inj] at h2
    exact absurd (by rw [← h2.1]; ring) (hbad A).2

/-! ## §E Intra completeness -/

/-- Solving `s·R = t` for `R` against a known solution — the last step of every fibre
computation, where the coefficient carries a `√3`. -/
private theorem eq_of_lin {s t R c : ℝ} (hs : s ≠ 0) (h : s * R = t) (hc : s * c = t) :
    R = c := by
  have hz : s * (R - c) = 0 := by linear_combination h - hc
  rcases mul_eq_zero.mp hz with h1 | h1
  · exact absurd h1 hs
  · linarith

/-- The address-difference real part, as the intra families see it. -/
private theorem intra_re (a c : ZMod 6) (b d : ℤ) (t : ℝ) :
    normSq (word a b - (t : ℂ) * word c d)
      = 1 + t ^ 2 - 2 * t * (word (a - c) (b - d)).re := by
  rw [← word_mul_conj_word]
  exact normSq_sub_smul (word_normSq a b) (word_normSq c d) t

/-- Reading a difference address as a position: `a − c = k ↔ c = a − k`. -/
private theorem addr_sub_iff {a c k : ZMod 6} : a - c = k ↔ c = a - k := by
  constructor
  · intro h; rw [← h]; ring
  · intro h; rw [h]; ring

private theorem neg_one_zmod : (5 : ZMod 6) = -1 := by decide
private theorem neg_two_zmod : (4 : ZMod 6) = -2 := by decide

/-- Outer–outer chords within one system are exactly the hex steps. -/
theorem intra_outer_complete {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ)
    (c : ZMod 6) (d : ℤ) :
    dist (outerPt p q a b) (outerPt p q c d) = 1 ↔
      ((c = a + 1 ∨ c = a - 1) ∧ d = b) := by
  rw [outerPt, outerPt, intra_dist, norm_axis h, one_mul, norm_eq_one_iff,
    show word a b - word c d = word a b - ((1 : ℝ) : ℂ) * word c d by norm_num,
    intra_re]
  rw [show (1 + (1 : ℝ) ^ 2 - 2 * 1 * (word (a - c) (b - d)).re = 1)
      ↔ (word (a - c) (b - d)).re = 1 / 2 from
    ⟨fun hEq => by linarith, fun hEq => by rw [hEq]; norm_num⟩, re_eq_half_iff]
  constructor
  · rintro ⟨h1 | h1, h2⟩
    · exact ⟨Or.inr (addr_sub_iff.mp h1), by omega⟩
    · exact ⟨Or.inl (by rw [addr_sub_iff.mp h1, neg_one_zmod]; ring), by omega⟩
  · rintro ⟨h1 | h1, rfl⟩ <;> subst h1
    · exact ⟨Or.inr (by rw [neg_one_zmod]; ring), by omega⟩
    · exact ⟨Or.inl (by ring), by omega⟩

/-- Inner–inner chords within one system are exactly the rot3 steps. -/
theorem intra_inner_complete {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ)
    (c : ZMod 6) (d : ℤ) :
    dist (innerPt p q a b) (innerPt p q c d) = 1 ↔
      ((c = a + 2 ∨ c = a - 2) ∧ d = b) := by
  have hfac : ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word a b - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word c d
      = ((Real.sqrt 3 / 3 : ℝ) : ℂ) * (word a b - ((1 : ℝ) : ℂ) * word c d) := by
    push_cast
    ring
  have hr : normSq ((Real.sqrt 3 / 3 : ℝ) : ℂ) = 1 / 3 := by
    simp only [normSq_apply, Complex.ofReal_re, Complex.ofReal_im]
    nlinarith [sq_sqrt3]
  rw [innerPt, innerPt, intra_dist, norm_axis h, one_mul, norm_eq_one_iff, hfac, map_mul, hr,
    intra_re]
  rw [show (1 / 3 * (1 + (1 : ℝ) ^ 2 - 2 * 1 * (word (a - c) (b - d)).re) = 1)
      ↔ (word (a - c) (b - d)).re = -(1 / 2) from
    ⟨fun hEq => by linarith, fun hEq => by rw [hEq]; norm_num⟩, re_eq_neg_half_iff]
  constructor
  · rintro ⟨h1 | h1, h2⟩
    · exact ⟨Or.inr (addr_sub_iff.mp h1), by omega⟩
    · exact ⟨Or.inl (by rw [addr_sub_iff.mp h1, neg_two_zmod]; ring), by omega⟩
  · rintro ⟨h1 | h1, rfl⟩ <;> subst h1
    · exact ⟨Or.inr (by rw [neg_two_zmod]; ring), by omega⟩
    · exact ⟨Or.inl (by ring), by omega⟩

/-- Outer–inner chords within one system are exactly the seam steps. -/
theorem intra_seam_complete {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ)
    (c : ZMod 6) (d : ℤ) :
    dist (outerPt p q a b) (innerPt p q c d) = 1 ↔
      (c = a ∧ (d = b + 1 ∨ d = b - 1)) := by
  have ht : (Real.sqrt 3 / 3 : ℝ) ^ 2 = 1 / 3 := by nlinarith [sq_sqrt3]
  rw [outerPt, innerPt, intra_dist, norm_axis h, one_mul, norm_eq_one_iff, intra_re]
  rw [show (1 + (Real.sqrt 3 / 3 : ℝ) ^ 2 - 2 * (Real.sqrt 3 / 3) * (word (a - c) (b - d)).re = 1)
      ↔ (word (a - c) (b - d)).re = Real.sqrt 3 / 6 from
    ⟨fun hEq => eq_of_lin (s := 2 * (Real.sqrt 3 / 3)) (t := 1 / 3) (by positivity)
        (by rw [ht] at hEq; linarith) (by nlinarith [sq_sqrt3]),
     fun hEq => by rw [hEq, ht]; nlinarith [sq_sqrt3]⟩, re_eq_seam_iff]
  constructor
  · rintro ⟨h1, h2 | h2⟩
    · exact ⟨(addr_sub_iff.mp h1).trans (by ring), Or.inr (by omega)⟩
    · exact ⟨(addr_sub_iff.mp h1).trans (by ring), Or.inl (by omega)⟩
  · rintro ⟨rfl, h2 | h2⟩ <;> subst h2
    · exact ⟨by ring, Or.inr (by omega)⟩
    · exact ⟨by ring, Or.inl (by omega)⟩

/-! ## §F Fusion completeness (which addresses name the same point) -/

private theorem axis_ne_zero {p q : ℂ} (h : dist p q = 1) : q - p ≠ 0 := by
  intro he
  rw [sub_eq_zero] at he
  rw [he, dist_self] at h
  norm_num at h

private theorem inner_ratio_ne_zero : ((Real.sqrt 3 / 3 : ℝ) : ℂ) ≠ 0 := by
  simp only [ne_eq, Complex.ofReal_eq_zero]
  positivity

theorem outerPt_inj {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    outerPt p q a b = outerPt p q c d ↔ (a = c ∧ b = d) := by
  rw [← word_inj]
  constructor
  · intro he
    rw [outerPt, outerPt] at he
    exact mul_right_cancel₀ (axis_ne_zero h) (by linear_combination he)
  · intro he
    rw [outerPt, outerPt, he]

theorem innerPt_inj {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    innerPt p q a b = innerPt p q c d ↔ (a = c ∧ b = d) := by
  rw [← word_inj]
  constructor
  · intro he
    rw [innerPt, innerPt] at he
    refine mul_left_cancel₀ inner_ratio_ne_zero
      (mul_right_cancel₀ (axis_ne_zero h) (?_ : ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word a b * (q - p)
        = ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word c d * (q - p)))
    linear_combination he
  · intro he
    rw [innerPt, innerPt, he]

theorem outer_ne_inner {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    outerPt p q a b ≠ innerPt p q c d := by
  intro he
  rw [outerPt, innerPt] at he
  have hw : word a b = ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word c d :=
    mul_right_cancel₀ (axis_ne_zero h) (by linear_combination he)
  have hn : (1 : ℝ) = Real.sqrt 3 / 3 := by
    have := congrArg Complex.normSq hw
    rw [word_normSq, map_mul, word_normSq, mul_one] at this
    have h3 : normSq ((Real.sqrt 3 / 3 : ℝ) : ℂ) = 1 / 3 := by
      simp only [normSq_apply, Complex.ofReal_re, Complex.ofReal_im]
      nlinarith [sq_sqrt3]
    rw [h3] at this
    norm_num at this
  nlinarith [sq_sqrt3, hn, sqrt3_pos]

private theorem normSq_one_sub {v : ℂ} (hv : normSq v = 1) (t : ℝ) :
    normSq (1 - (t : ℂ) * v) = 1 + t ^ 2 - 2 * t * v.re := by
  simpa using normSq_sub_smul (u := 1) (v := v) (by simp) hv t

private theorem sqrt3_mul_sqrt11 : Real.sqrt 3 * Real.sqrt 11 = Real.sqrt 33 := by
  rw [← Real.sqrt_mul (by norm_num)]
  norm_num

private theorem sqrt3_mul_sqrt33 : Real.sqrt 3 * Real.sqrt 33 = 3 * Real.sqrt 11 := by
  rw [show (33 : ℝ) = 3 * 11 by norm_num, Real.sqrt_mul (by norm_num), ← mul_assoc, sq_sqrt3]

private theorem normSq_inner_ratio : normSq ((Real.sqrt 3 / 3 : ℝ) : ℂ) = 1 / 3 := by
  simp only [normSq_apply, Complex.ofReal_re, Complex.ofReal_im]
  nlinarith [sq_sqrt3]

/-- The seam's defining relation in the shape the two glue fusions consume: scaling `σ`
into the inner circle is the same as stepping it by its own square. -/
private theorem seam_rel : ((Real.sqrt 3 / 3 : ℝ) : ℂ) * seam = 1 + seam ^ 2 := by
  apply Complex.ext <;>
    simp [seam, pow_two, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im] <;>
    nlinarith [sq_sqrt3, sq_sqrt33, sqrt3_mul_sqrt33]

private theorem seam_conj_rel :
    ((Real.sqrt 3 / 3 : ℝ) : ℂ) * (starRingEnd ℂ) seam = 1 + ((starRingEnd ℂ) seam) ^ 2 := by
  have h := congrArg (starRingEnd ℂ) seam_rel
  rw [map_mul, Complex.conj_ofReal, map_add, map_one, map_pow] at h
  exact h

/-- The two shared outer points: `word a b + word c d = 1` pins `{ζ₆, ζ₆⁻¹}`. -/
theorem fusion_oo {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    outerPt p q a b = outerPt q p c d ↔
      ((a = 1 ∧ b = 0 ∧ c = 5 ∧ d = 0) ∨ (a = 5 ∧ b = 0 ∧ c = 1 ∧ d = 0)) := by
  have hkey : outerPt p q a b = outerPt q p c d ↔ word a b = 1 - word c d := by
    rw [outerPt, outerPt]
    constructor
    · intro he
      exact mul_right_cancel₀ (axis_ne_zero h) (by linear_combination he)
    · intro he
      linear_combination (q - p) * he
  have hcc : (1 : ℂ) - (starRingEnd ℂ) zeta6 = zeta6 := by
    have := congrArg (starRingEnd ℂ) Triangle.one_sub_zeta6
    simpa using this
  rw [hkey]
  constructor
  · intro he
    have hre : (word c d).re = 1 / 2 := by
      have hn := word_normSq a b
      rw [he, show (1 : ℂ) - word c d = 1 - ((1 : ℝ) : ℂ) * word c d by norm_num,
        normSq_one_sub (word_normSq c d)] at hn
      linarith
    rcases (re_eq_half_iff c d).mp hre with ⟨hc | hc, rfl⟩ <;> subst hc
    · have hu : word a b = word 5 0 := by
        rw [he, word_10, word_conj_10]
        exact Triangle.one_sub_zeta6
      obtain ⟨rfl, rfl⟩ := (word_inj a 5 b 0).mp hu
      exact Or.inr ⟨rfl, rfl, rfl, rfl⟩
    · have hu : word a b = word 1 0 := by
        rw [he, word_conj_10, word_10]
        exact hcc
      obtain ⟨rfl, rfl⟩ := (word_inj a 1 b 0).mp hu
      exact Or.inl ⟨rfl, rfl, rfl, rfl⟩
  · rintro (⟨rfl, rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl, rfl⟩)
    · rw [word_10, word_conj_10]
      exact hcc.symm
    · rw [word_conj_10, word_10]
      exact Triangle.one_sub_zeta6.symm

/-- The oi glue points: `p`'s inner σ-points are `q`'s outer `word(3, ±2)`-points. -/
theorem fusion_oi {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    innerPt p q a b = outerPt q p c d ↔
      ((a = 0 ∧ b = 1 ∧ c = 3 ∧ d = 2) ∨ (a = 0 ∧ b = -1 ∧ c = 3 ∧ d = -2)) := by
  have hkey : innerPt p q a b = outerPt q p c d ↔
      ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word a b = 1 - word c d := by
    rw [innerPt, outerPt]
    constructor
    · intro he
      exact mul_right_cancel₀ (axis_ne_zero h) (by linear_combination he)
    · intro he
      linear_combination (q - p) * he
  rw [hkey]
  constructor
  · intro he
    have hre : (word c d).re = 5 / 6 := by
      have hn : normSq (((Real.sqrt 3 / 3 : ℝ) : ℂ) * word a b) = 1 / 3 := by
        rw [map_mul, word_normSq, mul_one, normSq_inner_ratio]
      rw [he, show (1 : ℂ) - word c d = 1 - ((1 : ℝ) : ℂ) * word c d by norm_num,
        normSq_one_sub (word_normSq c d)] at hn
      linarith
    rcases (re_eq_five_sixths_iff c d).mp hre with ⟨rfl, hd | hd⟩ <;> subst hd
    · have hu : ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word a b
          = ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word 0 1 := by
        rw [he, word_32, word_01, seam_rel]
        ring
      obtain ⟨rfl, rfl⟩ := (word_inj a 0 b 1).mp (mul_left_cancel₀ inner_ratio_ne_zero hu)
      exact Or.inl ⟨rfl, rfl, rfl, rfl⟩
    · have hu : ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word a b
          = ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word 0 (-1) := by
        rw [he, word_32', word_conj_01, seam_conj_rel]
        ring
      obtain ⟨rfl, rfl⟩ := (word_inj a 0 b (-1)).mp (mul_left_cancel₀ inner_ratio_ne_zero hu)
      exact Or.inr ⟨rfl, rfl, rfl, rfl⟩
  · rintro (⟨rfl, rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl, rfl⟩)
    · rw [word_01, word_32, seam_rel]
      ring
    · rw [word_conj_01, word_32', seam_conj_rel]
      ring

/-- The io glue points — `fusion_oi` mirrored. -/
theorem fusion_io {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    outerPt p q a b = innerPt q p c d ↔
      ((a = 3 ∧ b = 2 ∧ c = 0 ∧ d = 1) ∨ (a = 3 ∧ b = -2 ∧ c = 0 ∧ d = -1)) := by
  have hkey : outerPt p q a b = innerPt q p c d ↔
      word a b = 1 - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word c d := by
    rw [innerPt, outerPt]
    constructor
    · intro he
      exact mul_right_cancel₀ (axis_ne_zero h) (by linear_combination he)
    · intro he
      linear_combination (q - p) * he
  rw [hkey]
  have ht : (Real.sqrt 3 / 3 : ℝ) ^ 2 = 1 / 3 := by nlinarith [sq_sqrt3]
  constructor
  · intro he
    have hre : (word c d).re = Real.sqrt 3 / 6 := by
      have hn := word_normSq a b
      rw [he, normSq_one_sub (word_normSq c d), ht] at hn
      refine eq_of_lin (s := 2 * (Real.sqrt 3 / 3)) (t := 1 / 3) (by positivity)
        (by linarith) (by nlinarith [sq_sqrt3])
    rcases (re_eq_seam_iff c d).mp hre with ⟨rfl, hd | hd⟩ <;> subst hd
    · have hu : word a b = word 3 2 := by
        rw [he, word_01, word_32, seam_rel]
        ring
      obtain ⟨rfl, rfl⟩ := (word_inj a 3 b 2).mp hu
      exact Or.inl ⟨rfl, rfl, rfl, rfl⟩
    · have hu : word a b = word 3 (-2) := by
        rw [he, word_conj_01, word_32', seam_conj_rel]
        ring
      obtain ⟨rfl, rfl⟩ := (word_inj a 3 b (-2)).mp hu
      exact Or.inr ⟨rfl, rfl, rfl, rfl⟩
  · rintro (⟨rfl, rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl, rfl⟩)
    · rw [word_01, word_32, seam_rel]
      ring
    · rw [word_conj_01, word_32', seam_conj_rel]
      ring

/-- The ii gluing needs `u = ζ₁₂` — torsion of order 12, never a lattice word. The two
systems' inner lattices share no point (the metapivot blind spot, M23). -/
theorem fusion_ii {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    innerPt p q a b ≠ innerPt q p c d := by
  intro he
  rw [innerPt, innerPt] at he
  have hw : ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word a b
      = 1 - ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word c d :=
    mul_right_cancel₀ (axis_ne_zero h) (by linear_combination he)
  have ht : (Real.sqrt 3 / 3 : ℝ) ^ 2 = 1 / 3 := by nlinarith [sq_sqrt3]
  have hn : normSq (((Real.sqrt 3 / 3 : ℝ) : ℂ) * word a b) = 1 / 3 := by
    rw [map_mul, word_normSq, mul_one, normSq_inner_ratio]
  rw [hw, normSq_one_sub (word_normSq c d), ht] at hn
  exact re_ne_sqrt3_half c d
    (eq_of_lin (s := 2 * (Real.sqrt 3 / 3)) (t := 1) (by positivity) (by linarith)
      (by nlinarith [sq_sqrt3]))

/-! ## §G The completeness core (E2/E3/E5)

The core rests on one arithmetic fact — that `{1, √3, √11, √33}` is `ℚ`-independent — plus
the seam's infinite order. Together they split the cleared chord equation by the seam
heights' parities: mixed parities are impossible outright, both-even collapses through the
seam's infinite order, and both-odd becomes a single equation in `ℤ[ζ₆, π]`,
`π = √3·σ = (1+i√11)/2`, where a congruence modulo three closes it. -/

private theorem not_isSquare_of {n : ℕ} (hn : ∀ r : ℕ, r ≤ n → r * r ≠ n) : ¬ IsSquare n := by
  rintro ⟨r, hr⟩
  refine hn r ?_ hr.symm
  nlinarith [hr, Nat.zero_le r]

private theorem irr_sqrt3 : Irrational (Real.sqrt 3) := by
  rw [show (3 : ℝ) = ((3 : ℕ) : ℝ) by norm_num]
  exact irrational_sqrt_natCast_iff.mpr (not_isSquare_of (by decide))

private theorem irr_sqrt11 : Irrational (Real.sqrt 11) := by
  rw [show (11 : ℝ) = ((11 : ℕ) : ℝ) by norm_num]
  exact irrational_sqrt_natCast_iff.mpr (not_isSquare_of (by decide))

private theorem irr_sqrt33 : Irrational (Real.sqrt 33) := by
  rw [show (33 : ℝ) = ((33 : ℕ) : ℝ) by norm_num]
  exact irrational_sqrt_natCast_iff.mpr (not_isSquare_of (by decide))

/-- No rational squares to a non-square natural: the only arithmetic input the
independence proof needs. -/
private theorem no_rat_sq {n : ℕ} (hn : Irrational (Real.sqrt n)) (r : ℚ) :
    r ^ 2 ≠ (n : ℚ) := by
  intro he
  refine hn ⟨|r|, ?_⟩
  have hcast : ((r : ℝ)) ^ 2 = (n : ℝ) := by exact_mod_cast congrArg (fun x : ℚ => (x : ℝ)) he
  rw [← hcast, Real.sqrt_sq_eq_abs]
  push_cast
  rfl

/-- `1` and `√3` are `ℚ`-independent. -/
private theorem indep_sqrt3 {r s : ℚ} (h : (r : ℝ) + s * Real.sqrt 3 = 0) : r = 0 ∧ s = 0 := by
  by_cases hs : s = 0
  · subst hs
    refine ⟨?_, rfl⟩
    simpa using h
  · exfalso
    have hval : Real.sqrt 3 = ((-r / s : ℚ) : ℝ) := by
      push_cast
      field_simp at h ⊢
      linarith [h]
    have : ((-r / s : ℚ) : ℝ) ^ 2 = (3 : ℝ) := by
      rw [← hval]
      nlinarith [sq_sqrt3]
    refine no_rat_sq (n := 3) irr_sqrt3 (-r / s) ?_
    exact_mod_cast this

/-- **The independence of the radical basis.** Every cleared equation of this milestone is
read through it: matching coefficients over `{1, √3, √11, √33}` turns a complex identity
into integer identities. (M25–M27 reuse it verbatim; it is stated over `ℚ` so integer
coefficients arrive by `push_cast`.) -/
theorem sqrt_indep {e₁ e₃ e₁₁ e₃₃ : ℚ}
    (h : (e₁ : ℝ) + e₃ * Real.sqrt 3 + e₁₁ * Real.sqrt 11 + e₃₃ * Real.sqrt 33 = 0) :
    e₁ = 0 ∧ e₃ = 0 ∧ e₁₁ = 0 ∧ e₃₃ = 0 := by
  have h33 : Real.sqrt 33 = Real.sqrt 3 * Real.sqrt 11 := by
    rw [show (33 : ℝ) = 3 * 11 by norm_num, Real.sqrt_mul (by norm_num)]
  rw [h33] at h
  set N : ℚ := e₁₁ ^ 2 - 3 * e₃₃ ^ 2 with hN
  set P : ℚ := e₁ * e₁₁ - 3 * e₃ * e₃₃ with hP
  set Q : ℚ := e₃ * e₁₁ - e₁ * e₃₃ with hQ
  -- multiply by the `√3`-conjugate of the `√11`-part: the `√3·√11` terms cancel
  have hmul : (P : ℝ) + Q * Real.sqrt 3 + N * Real.sqrt 11 = 0 := by
    have hc := congrArg (fun x : ℝ => x * ((e₁₁ : ℝ) - (e₃₃ : ℝ) * Real.sqrt 3)) h
    simp only [zero_mul] at hc
    rw [hP, hQ, hN]
    push_cast
    linear_combination hc + ((e₃ : ℝ) * e₃₃ + (e₃₃ : ℝ) ^ 2 * Real.sqrt 11) * sq_sqrt3
  -- squaring removes the `√11`
  have hsq : ((P ^ 2 + 3 * Q ^ 2 - 11 * N ^ 2 : ℚ) : ℝ) + ((2 * P * Q : ℚ) : ℝ) * Real.sqrt 3
      = 0 := by
    have h2 : ((P : ℝ) + Q * Real.sqrt 3) ^ 2 = ((N : ℝ) * Real.sqrt 11) ^ 2 := by
      rw [show (P : ℝ) + Q * Real.sqrt 3 = -((N : ℝ) * Real.sqrt 11) by linarith]
      ring
    push_cast
    linear_combination h2 - (Q : ℝ) ^ 2 * sq_sqrt3 + (N : ℝ) ^ 2 * sq_sqrt11
  obtain ⟨hz1, hz2⟩ := indep_sqrt3 hsq
  have hPQ : P * Q = 0 := by linarith
  have hN0 : N = 0 := by
    by_contra hNz
    rcases mul_eq_zero.mp hPQ with hPz | hQz
    · refine no_rat_sq (n := 33) irr_sqrt33 (3 * Q / N) ?_
      have h3 : 3 * Q ^ 2 = 11 * N ^ 2 := by rw [hPz] at hz1; linarith
      field_simp
      linear_combination 3 * h3
    · refine no_rat_sq (n := 11) irr_sqrt11 (P / N) ?_
      have h3 : P ^ 2 = 11 * N ^ 2 := by rw [hQz] at hz1; linarith
      field_simp
      linear_combination h3
  have h33z : e₃₃ = 0 := by
    by_contra hz
    refine no_rat_sq (n := 3) irr_sqrt3 (e₁₁ / e₃₃) ?_
    have h3 : e₁₁ ^ 2 = 3 * e₃₃ ^ 2 := by rw [hN] at hN0; linarith
    field_simp
    linear_combination h3
  have h11z : e₁₁ = 0 := by
    rw [hN, h33z] at hN0
    have : e₁₁ ^ 2 = 0 := by linarith
    exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
  have hrest : (e₁ : ℝ) + (e₃ : ℝ) * Real.sqrt 3 = 0 := by
    rw [h11z, h33z] at h
    push_cast at h ⊢
    linarith
  obtain ⟨hx, hy⟩ := indep_sqrt3 hrest
  exact ⟨hx, hy, h11z, h33z⟩

/-! ### The algebraic integer behind the seam

`π = √3·σ` clears the seam's denominator: `√3^b · word a b = ζ₆^a · π^b`, and `π` is an
algebraic integer with `π² = π − 3` and `π·π̄ = 3`, so its powers have integer coordinates
in the basis `{1, π}`. Those integers carry the whole completeness argument. -/

/-- `π = √3·σ = (1 + i√11)/2`. -/
noncomputable def piC : ℂ := ⟨1 / 2, Real.sqrt 11 / 2⟩

theorem piC_eq_sqrt3_mul_seam : piC = ((Real.sqrt 3 : ℝ) : ℂ) * seam := by
  apply Complex.ext <;>
    simp [piC, seam, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im] <;>
    nlinarith [sq_sqrt3, sq_sqrt33, sqrt3_mul_sqrt33]

/-- The seam's minimal polynomial, cleared: `π² = π − 3`. -/
theorem piC_sq : piC ^ 2 = piC - 3 := by
  apply Complex.ext <;>
    simp [piC, pow_two, Complex.mul_re, Complex.mul_im] <;>
    nlinarith [sq_sqrt11]

/-- The integer coordinates of `π^n` in the basis `{1, π}`: `π^n = (piCoeff n).1 +
(piCoeff n).2·π`. -/
def piCoeff : ℕ → ℤ × ℤ
  | 0 => (1, 0)
  | n + 1 => (-3 * (piCoeff n).2, (piCoeff n).1 + (piCoeff n).2)

theorem piC_pow_coeff (n : ℕ) :
    piC ^ n = ((piCoeff n).1 : ℂ) + ((piCoeff n).2 : ℂ) * piC := by
  induction n with
  | zero => simp [piCoeff]
  | succ k ih =>
    rw [pow_succ, ih, piCoeff]
    push_cast
    linear_combination ((piCoeff k).2 : ℂ) * piC_sq

/-- The first coordinate is divisible by three from the first step on. -/
theorem three_dvd_piCoeff_fst (n : ℕ) : (3 : ℤ) ∣ (piCoeff (n + 1)).1 :=
  ⟨-(piCoeff n).2, by rw [piCoeff]; ring⟩

/-- The second coordinate is never divisible by three (from the first step on) — the fact
that every kill in the completeness argument turns on. -/
theorem piCoeff_snd_emod (n : ℕ) : (piCoeff (n + 1)).2 % 3 = 1 := by
  induction n with
  | zero => decide
  | succ k ih =>
    obtain ⟨m, hm⟩ := three_dvd_piCoeff_fst k
    rw [piCoeff, hm]
    omega

/-- The norm identity `|π^n|² = 3^n`, in coordinates. -/
theorem piCoeff_norm (n : ℕ) :
    (piCoeff n).1 ^ 2 + (piCoeff n).1 * (piCoeff n).2 + 3 * (piCoeff n).2 ^ 2 = 3 ^ n := by
  induction n with
  | zero => decide
  | succ k ih =>
    rw [piCoeff, pow_succ]
    ring_nf
    ring_nf at ih
    linarith [ih]

/-- **The clearing identity**: multiplying a ladder word by `√3^b` turns it into an
algebraic integer of `ℤ[ζ₆, π]`. -/
theorem sqrt3_pow_mul_word (a : ZMod 6) (b : ℕ) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ b * word a (b : ℤ) = zeta6 ^ (a.val : ℤ) * piC ^ b := by
  rw [word, zpow_natCast seam b, piC_eq_sqrt3_mul_seam, mul_pow]
  ring

/-! ### The ring the cleared equation lives in

`ℤ[ζ₆, π]` sits inside `ℚ(√−3, √−11)`, and `√3` does not: that is the whole content of
the parity split. `InRing` names membership by coordinates in the basis
`{1, ζ₆, π, ζ₆π}`, and `eq_zero_of_add_sqrt3_mul` is the separation. -/

/-- Membership in `ℤ[ζ₆, π]`, by integer coordinates in the basis `{1, ζ₆, π, ζ₆·π}`.
Integrality is what lets a congruence modulo three be read off a ring identity. -/
def InRing (z : ℂ) : Prop :=
  ∃ n₁ n₂ n₃ n₄ : ℤ, z = (n₁ : ℂ) + (n₂ : ℂ) * zeta6 + (n₃ : ℂ) * piC
    + (n₄ : ℂ) * (zeta6 * piC)

theorem InRing.add {z w : ℂ} (hz : InRing z) (hw : InRing w) : InRing (z + w) := by
  obtain ⟨a₁, a₂, a₃, a₄, rfl⟩ := hz
  obtain ⟨b₁, b₂, b₃, b₄, rfl⟩ := hw
  exact ⟨a₁ + b₁, a₂ + b₂, a₃ + b₃, a₄ + b₄, by push_cast; ring⟩

theorem InRing.neg {z : ℂ} (hz : InRing z) : InRing (-z) := by
  obtain ⟨a₁, a₂, a₃, a₄, rfl⟩ := hz
  exact ⟨-a₁, -a₂, -a₃, -a₄, by push_cast; ring⟩

theorem InRing.intCast (n : ℤ) : InRing (n : ℂ) := ⟨n, 0, 0, 0, by push_cast; ring⟩

theorem InRing.zeta6_mul {z : ℂ} (hz : InRing z) : InRing (zeta6 * z) := by
  obtain ⟨a₁, a₂, a₃, a₄, rfl⟩ := hz
  refine ⟨-a₂, a₁ + a₂, -a₄, a₃ + a₄, ?_⟩
  push_cast
  linear_combination ((a₂ : ℂ) + (a₄ : ℂ) * piC) * zeta6_minpoly

theorem InRing.piC_mul {z : ℂ} (hz : InRing z) : InRing (piC * z) := by
  obtain ⟨a₁, a₂, a₃, a₄, rfl⟩ := hz
  refine ⟨-3 * a₃, -3 * a₄, a₁ + a₃, a₂ + a₄, ?_⟩
  push_cast
  linear_combination ((a₃ : ℂ) + (a₄ : ℂ) * zeta6) * piC_sq

theorem InRing.zeta6_zpow (n : ℤ) : InRing (zeta6 ^ n) := by
  have hnat : ∀ m : ℕ, InRing (zeta6 ^ m) := by
    intro m
    induction m with
    | zero => simpa using InRing.intCast 1
    | succ k ih =>
      rw [pow_succ, mul_comm]
      exact ih.zeta6_mul
  have hz6 : zeta6 ^ (6 : ℕ) = 1 := zeta6_pow_six
  obtain ⟨m, hm⟩ : ∃ m : ℕ, zeta6 ^ n = zeta6 ^ m := by
    refine ⟨((n : ZMod 6)).val, ?_⟩
    rw [← zpow_natCast, zeta6_zpow_val]
  rw [hm]
  exact hnat m

theorem InRing.piC_pow (m : ℕ) : InRing (piC ^ m) := by
  induction m with
  | zero => simpa using InRing.intCast 1
  | succ k ih =>
    rw [pow_succ, mul_comm]
    exact ih.piC_mul

theorem InRing.intSmul (q : ℤ) {w : ℂ} (hw : InRing w) : InRing ((q : ℂ) * w) := by
  obtain ⟨b₁, b₂, b₃, b₄, rfl⟩ := hw
  exact ⟨q * b₁, q * b₂, q * b₃, q * b₄, by push_cast; ring⟩

theorem InRing.mul {z w : ℂ} (hz : InRing z) (hw : InRing w) : InRing (z * w) := by
  obtain ⟨a₁, a₂, a₃, a₄, rfl⟩ := hz
  have h1 : InRing ((a₁ : ℂ) * w) := InRing.intSmul a₁ hw
  have h2 : InRing ((a₂ : ℂ) * zeta6 * w) := by
    have := (InRing.intSmul a₂ hw).zeta6_mul
    rw [show zeta6 * ((a₂ : ℂ) * w) = (a₂ : ℂ) * zeta6 * w by ring] at this
    exact this
  have h3 : InRing ((a₃ : ℂ) * piC * w) := by
    have := (InRing.intSmul a₃ hw).piC_mul
    rw [show piC * ((a₃ : ℂ) * w) = (a₃ : ℂ) * piC * w by ring] at this
    exact this
  have h4 : InRing ((a₄ : ℂ) * (zeta6 * piC) * w) := by
    have := ((InRing.intSmul a₄ hw).piC_mul).zeta6_mul
    rw [show zeta6 * (piC * ((a₄ : ℂ) * w)) = (a₄ : ℂ) * (zeta6 * piC) * w by ring] at this
    exact this
  rw [show ((a₁ : ℂ) + (a₂ : ℂ) * zeta6 + (a₃ : ℂ) * piC + (a₄ : ℂ) * (zeta6 * piC)) * w
      = (a₁ : ℂ) * w + (a₂ : ℂ) * zeta6 * w + (a₃ : ℂ) * piC * w
        + (a₄ : ℂ) * (zeta6 * piC) * w by ring]
  exact ((h1.add h2).add h3).add h4

/-- The separation, in rational coordinates: the eight-dimensional independence that
`√3 ∉ ℚ(ζ₆, π)` amounts to. -/
private theorem sep_rat {a₁ a₂ a₃ a₄ b₁ b₂ b₃ b₄ : ℚ}
    (h : ((a₁ : ℂ) + (a₂ : ℂ) * zeta6 + (a₃ : ℂ) * piC + (a₄ : ℂ) * (zeta6 * piC))
      + ((Real.sqrt 3 : ℝ) : ℂ) * ((b₁ : ℂ) + (b₂ : ℂ) * zeta6 + (b₃ : ℂ) * piC
        + (b₄ : ℂ) * (zeta6 * piC)) = 0) :
    a₁ = 0 ∧ a₂ = 0 ∧ a₃ = 0 ∧ a₄ = 0 ∧ b₁ = 0 ∧ b₂ = 0 ∧ b₃ = 0 ∧ b₄ = 0 := by
  have hre : ((a₁ + a₂ / 2 + a₃ / 2 + a₄ / 4 : ℚ) : ℝ)
      + ((b₁ + b₂ / 2 + b₃ / 2 + b₄ / 4 : ℚ) : ℝ) * Real.sqrt 3
      + ((-3 * b₄ / 4 : ℚ) : ℝ) * Real.sqrt 11
      + ((-a₄ / 4 : ℚ) : ℝ) * Real.sqrt 33 = 0 := by
    have := congrArg Complex.re h
    simp only [Complex.add_re, Complex.mul_re, Complex.mul_im, Complex.ofReal_re,
      Complex.ofReal_im, Complex.ratCast_re, Complex.ratCast_im, Complex.zero_re,
      zeta6, piC, zero_mul, sub_zero] at this
    push_cast
    linear_combination this + ((a₄ : ℝ) / 4) * sqrt3_mul_sqrt11
      + ((b₄ : ℝ) * Real.sqrt 11 / 4) * sq_sqrt3
  have him : ((3 * b₂ / 2 + 3 * b₄ / 4 : ℚ) : ℝ)
      + ((a₂ / 2 + a₄ / 4 : ℚ) : ℝ) * Real.sqrt 3
      + ((a₃ / 2 + a₄ / 4 : ℚ) : ℝ) * Real.sqrt 11
      + ((b₃ / 2 + b₄ / 4 : ℚ) : ℝ) * Real.sqrt 33 = 0 := by
    have := congrArg Complex.im h
    simp only [Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re,
      Complex.ofReal_im, Complex.ratCast_re, Complex.ratCast_im, Complex.zero_im,
      zeta6, piC, zero_mul, add_zero, zero_add] at this
    push_cast
    linear_combination this - ((b₃ : ℝ) / 2 + (b₄ : ℝ) / 4) * sqrt3_mul_sqrt11
      - ((b₂ : ℝ) / 2 + (b₄ : ℝ) / 4) * sq_sqrt3
  obtain ⟨e1, e2, e3, e4⟩ := sqrt_indep hre
  obtain ⟨f1, f2, f3, f4⟩ := sqrt_indep him
  have hb4 : b₄ = 0 := by linarith
  have ha4 : a₄ = 0 := by linarith
  have hb2 : b₂ = 0 := by rw [hb4] at f1; linarith
  have ha2 : a₂ = 0 := by rw [ha4] at f2; linarith
  have ha3 : a₃ = 0 := by rw [ha4] at f3; linarith
  have hb3 : b₃ = 0 := by rw [hb4] at f4; linarith
  have ha1 : a₁ = 0 := by rw [ha2, ha3, ha4] at e1; linarith
  have hb1 : b₁ = 0 := by rw [hb2, hb3, hb4] at e2; linarith
  exact ⟨ha1, ha2, ha3, ha4, hb1, hb2, hb3, hb4⟩

/-- **The separation.** `√3` does not lie in `ℚ(ζ₆, π)`, so a sum of a ring element and
`√3` times a ring element vanishes only if both halves do. Every parity case of the
completeness argument is one application of this. -/
theorem eq_zero_of_add_sqrt3_mul {X Y : ℂ} (hX : InRing X) (hY : InRing Y)
    (h : X + ((Real.sqrt 3 : ℝ) : ℂ) * Y = 0) : X = 0 ∧ Y = 0 := by
  obtain ⟨a₁, a₂, a₃, a₄, rfl⟩ := hX
  obtain ⟨b₁, b₂, b₃, b₄, rfl⟩ := hY
  obtain ⟨e1, e2, e3, e4, f1, f2, f3, f4⟩ :=
    sep_rat (a₁ := (a₁ : ℚ)) (a₂ := (a₂ : ℚ)) (a₃ := (a₃ : ℚ)) (a₄ := (a₄ : ℚ))
      (b₁ := (b₁ : ℚ)) (b₂ := (b₂ : ℚ)) (b₃ := (b₃ : ℚ)) (b₄ := (b₄ : ℚ))
      (by push_cast at h ⊢; linear_combination h)
  constructor
  · have h1 : a₁ = 0 := by exact_mod_cast e1
    have h2 : a₂ = 0 := by exact_mod_cast e2
    have h3 : a₃ = 0 := by exact_mod_cast e3
    have h4 : a₄ = 0 := by exact_mod_cast e4
    rw [h1, h2, h3, h4]
    push_cast
    ring
  · have h1 : b₁ = 0 := by exact_mod_cast f1
    have h2 : b₂ = 0 := by exact_mod_cast f2
    have h3 : b₃ = 0 := by exact_mod_cast f3
    have h4 : b₄ = 0 := by exact_mod_cast f4
    rw [h1, h2, h3, h4]
    push_cast
    ring

/-- Integer coordinates in the basis `{1, ζ₆, π, ζ₆π}` are unique — what lets a
congruence modulo three be read off a ring identity. -/
theorem inRing_coords_zero {n₁ n₂ n₃ n₄ : ℤ}
    (h : (n₁ : ℂ) + (n₂ : ℂ) * zeta6 + (n₃ : ℂ) * piC + (n₄ : ℂ) * (zeta6 * piC) = 0) :
    n₁ = 0 ∧ n₂ = 0 ∧ n₃ = 0 ∧ n₄ = 0 := by
  obtain ⟨e1, e2, e3, e4, -, -, -, -⟩ :=
    sep_rat (a₁ := (n₁ : ℚ)) (a₂ := (n₂ : ℚ)) (a₃ := (n₃ : ℚ)) (a₄ := (n₄ : ℚ))
      (b₁ := 0) (b₂ := 0) (b₃ := 0) (b₄ := 0)
      (by push_cast at h ⊢; linear_combination h)
  exact ⟨by exact_mod_cast e1, by exact_mod_cast e2, by exact_mod_cast e3,
    by exact_mod_cast e4⟩

/-! ### The two symmetries of the norm branch

The equation is symmetric in its two words and stable under conjugation, so its solution
set is closed under `(a,b,c,d) ↦ (c,d,a,b)` and `(a,b,c,d) ↦ (−a,−b,−c,−d)`. Every
seam-height sign case reduces along these. -/

/-- The norm branch, named: the second disjunct of `ii_chord_iff`. -/
def NormBranch (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ) : Prop :=
  word a b + word c d = ((Real.sqrt 3 : ℝ) : ℂ) * (word a b * word c d + 1)

theorem normBranch_swap {a c : ZMod 6} {b d : ℤ} (h : NormBranch a b c d) :
    NormBranch c d a b := by
  rw [NormBranch] at h ⊢
  linear_combination h

theorem normBranch_conj {a c : ZMod 6} {b d : ℤ} (h : NormBranch a b c d) :
    NormBranch (-a) (-b) (-c) (-d) := by
  rw [NormBranch] at h ⊢
  have := congrArg (starRingEnd ℂ) h
  rw [map_add, map_mul, map_add, map_mul, map_one, Complex.conj_ofReal, word_conj,
    word_conj] at this
  exact this

/-! ### The parity split

Clearing the norm branch by `√3^(b+d)` and separating along `√3 ∉ ℚ(ζ₆,π)` decides the
case by the parities of the two seam heights: mixed parity is impossible, both-even
collapses through the seam's infinite order to the two matching-crossings, and both-odd
leaves the norm equation `(A − 3^β)(B − 3^δ) = −2·3^{β+δ}` in `ℤ[ζ₆, π]`. -/

private theorem sqrt3_cast_ne_zero : ((Real.sqrt 3 : ℝ) : ℂ) ≠ 0 := by
  simp only [ne_eq, Complex.ofReal_eq_zero]
  positivity

private theorem sqrt3_pow_two_mul (k : ℕ) : ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * k) = 3 ^ k := by
  rw [pow_mul, show ((Real.sqrt 3 : ℝ) : ℂ) ^ 2 = 3 from by
    rw [pow_two]; exact sqrt3_cast_sq]

private theorem normSq_piC : normSq piC = 3 := by
  simp only [normSq_apply, piC]
  nlinarith [sq_sqrt11]

private theorem normSq_ringElt (a : ZMod 6) (b : ℕ) :
    normSq (zeta6 ^ (a.val : ℤ) * piC ^ b) = 3 ^ b := by
  rw [map_mul, map_pow, normSq_piC]
  have : normSq (zeta6 ^ (a.val : ℤ)) = 1 := by
    rw [← Complex.sq_norm, norm_zpow, norm_zeta6, one_zpow]
    norm_num
  rw [this, one_mul]

/-- The norm branch, cleared of seam denominators. -/
theorem normBranch_cleared {a c : ZMod 6} {b d : ℕ} (h : NormBranch a b c d) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ d * (zeta6 ^ (a.val : ℤ) * piC ^ b)
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ b * (zeta6 ^ (c.val : ℤ) * piC ^ d)
      = ((Real.sqrt 3 : ℝ) : ℂ) * ((zeta6 ^ (a.val : ℤ) * piC ^ b)
          * (zeta6 ^ (c.val : ℤ) * piC ^ d))
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + d + 1) := by
  have hA := sqrt3_pow_mul_word a b
  have hB := sqrt3_pow_mul_word c d
  rw [NormBranch] at h
  have key : ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + d) * (word a (b : ℤ) + word c (d : ℤ))
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + d)
        * (((Real.sqrt 3 : ℝ) : ℂ) * (word a (b : ℤ) * word c (d : ℤ) + 1)) := by rw [h]
  rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + d) * (word a (b : ℤ) + word c (d : ℤ))
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ d * (((Real.sqrt 3 : ℝ) : ℂ) ^ b * word a (b : ℤ))
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ b * (((Real.sqrt 3 : ℝ) : ℂ) ^ d * word c (d : ℤ)) by
      rw [pow_add]; ring] at key
  rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + d)
        * (((Real.sqrt 3 : ℝ) : ℂ) * (word a (b : ℤ) * word c (d : ℤ) + 1))
      = ((Real.sqrt 3 : ℝ) : ℂ) * ((((Real.sqrt 3 : ℝ) : ℂ) ^ b * word a (b : ℤ))
          * ((((Real.sqrt 3 : ℝ) : ℂ) ^ d * word c (d : ℤ))))
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + d + 1) by
      rw [pow_add, pow_add, pow_one]; ring] at key
  rw [hA, hB] at key
  exact key

private theorem inRing_elt (a : ZMod 6) (b : ℕ) : InRing (zeta6 ^ (a.val : ℤ) * piC ^ b) :=
  (InRing.zeta6_zpow _).mul (InRing.piC_pow _)

private theorem inRing_three_pow (k : ℕ) : InRing ((3 : ℂ) ^ k) := by
  have : ((3 : ℂ) ^ k) = (((3 ^ k : ℤ)) : ℂ) := by push_cast; ring
  rw [this]
  exact InRing.intCast _

/-- **Mixed parity is impossible**: one seam height even and the other odd forces a word
to equal a power of three, which its modulus forbids. -/
theorem normBranch_parity {a c : ZMod 6} {b d : ℕ} (h : NormBranch a b c d) :
    b % 2 = d % 2 := by
  by_contra hpar
  wlog hb : b % 2 = 0 generalizing a b c d
  · exact this (normBranch_swap h) (by omega) (by omega)
  obtain ⟨β, rfl⟩ : ∃ β, b = 2 * β := ⟨b / 2, by omega⟩
  obtain ⟨δ, rfl⟩ : ∃ δ, d = 2 * δ + 1 := ⟨d / 2, by omega⟩
  have hc := normBranch_cleared h
  set A := zeta6 ^ (a.val : ℤ) * piC ^ (2 * β) with hAdef
  set B := zeta6 ^ (c.val : ℤ) * piC ^ (2 * δ + 1) with hBdef
  rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * δ + 1)
      = ((Real.sqrt 3 : ℝ) : ℂ) * 3 ^ δ by rw [pow_succ, sqrt3_pow_two_mul]; ring,
    sqrt3_pow_two_mul,
    show 2 * β + (2 * δ + 1) + 1 = 2 * (β + δ + 1) by ring, sqrt3_pow_two_mul] at hc
  obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
    ((((inRing_three_pow β).mul (inRing_elt c (2 * δ + 1)))).add
      (inRing_three_pow (β + δ + 1)).neg)
    (((inRing_three_pow δ).mul (inRing_elt a (2 * β))).add
      (((inRing_elt a (2 * β)).mul (inRing_elt c (2 * δ + 1))).neg))
    (show ((3 : ℂ) ^ β * B + -(3 : ℂ) ^ (β + δ + 1))
        + ((Real.sqrt 3 : ℝ) : ℂ) * ((3 : ℂ) ^ δ * A + -(A * B)) = 0 by
      linear_combination hc)
  -- `B = 3^{δ+1}` contradicts `|B|² = 3^{2δ+1}`
  have hB3 : B = (3 : ℂ) ^ (δ + 1) := by
    refine mul_left_cancel₀ (a := ((3 : ℂ) ^ β)) (pow_ne_zero _ (by norm_num)) ?_
    rw [show ((3 : ℂ) ^ β * (3 : ℂ) ^ (δ + 1)) = (3 : ℂ) ^ (β + δ + 1) by
      rw [← pow_add]; ring_nf]
    linear_combination hX
  have hnorm := normSq_ringElt c (2 * δ + 1)
  rw [← hBdef, hB3, map_pow, show normSq (3 : ℂ) = 9 by norm_num [normSq_apply]] at hnorm
  have hgrow : (9 : ℝ) ^ (δ + 1) = 3 * 3 ^ (2 * δ + 1) := by
    rw [show (9 : ℝ) = 3 ^ 2 by norm_num, ← pow_mul]
    ring
  nlinarith [hnorm, hgrow, pow_pos (show (0 : ℝ) < 3 by norm_num) (2 * δ + 1)]

/-- The hex unit in coordinates: `ζ₆^n = hexE n + hexF n·ζ₆` for `n < 6`. -/
def hexE : ℕ → ℤ
  | 0 => 1 | 1 => 0 | 2 => -1 | 3 => -1 | 4 => 0 | 5 => 1 | _ => 0

/-- The `ζ₆`-coordinate of the hex unit: `ζ₆^n = hexE n + hexF n·ζ₆` for `n < 6`. -/
def hexF : ℕ → ℤ
  | 0 => 0 | 1 => 1 | 2 => 1 | 3 => 0 | 4 => -1 | 5 => -1 | _ => 0

theorem zeta6_zpow_hex (a : ZMod 6) :
    zeta6 ^ (a.val : ℤ) = ((hexE a.val : ℤ) : ℂ) + ((hexF a.val : ℤ) : ℂ) * zeta6 := by
  have hz2 : zeta6 ^ (2 : ℤ) = zeta6 - 1 := by
    rw [show ((2 : ℤ)) = ((2 : ℕ) : ℤ) from rfl, zpow_natCast]
    linear_combination zeta6_minpoly
  have hz3 : zeta6 ^ (3 : ℤ) = -1 := by
    rw [show ((3 : ℤ)) = ((3 : ℕ) : ℤ) from rfl, zpow_natCast]
    exact zeta6_cube
  have hz4 : zeta6 ^ (4 : ℤ) = -zeta6 := by
    rw [show ((4 : ℤ)) = 3 + 1 by ring, zpow_add₀ zeta6_ne_zero, hz3, zpow_one]
    ring
  have hz5 : zeta6 ^ (5 : ℤ) = 1 - zeta6 := by
    rw [show ((5 : ℤ)) = 3 + 2 by ring, zpow_add₀ zeta6_ne_zero, hz3, hz2]
    ring
  obtain ⟨n, hn, hna⟩ : ∃ n, n < 6 ∧ a.val = n := ⟨a.val, ZMod.val_lt a, rfl⟩
  rw [hna]
  interval_cases n
  · norm_num [hexE, hexF]
  · norm_num [hexE, hexF]
  · rw [show ((2 : ℕ) : ℤ) = (2 : ℤ) from rfl, hz2]
    norm_num [hexE, hexF]
    ring
  · rw [show ((3 : ℕ) : ℤ) = (3 : ℤ) from rfl, hz3]
    norm_num [hexE, hexF]
  · rw [show ((4 : ℕ) : ℤ) = (4 : ℤ) from rfl, hz4]
    norm_num [hexE, hexF]
  · rw [show ((5 : ℕ) : ℤ) = (5 : ℤ) from rfl, hz5]
    norm_num [hexE, hexF]
    ring

/-- The hex coordinates are never both divisible by three — the unit stays a unit modulo
three, which is what every congruence kill turns on. -/
theorem hexE_hexF_not_both_dvd : ∀ n : ℕ, n < 6 → ¬ ((3 : ℤ) ∣ hexE n ∧ (3 : ℤ) ∣ hexF n) := by
  decide

private theorem zmod_pair_pin : ∀ a c : ZMod 6, a + c = 3 → c = a + 3 →
    (a = 0 ∧ c = 3) ∨ (a = 3 ∧ c = 0) := by decide

/-- **Both heights even**: the product of the two words is forced to `−1`, and the seam's
infinite order pins both heights to zero — the two matching-crossings, and nothing else. -/
theorem normBranch_even {a c : ZMod 6} {β δ : ℕ}
    (h : NormBranch a ((2 * β : ℕ) : ℤ) c ((2 * δ : ℕ) : ℤ)) :
    β = 0 ∧ δ = 0 ∧ ((a = 0 ∧ c = 3) ∨ (a = 3 ∧ c = 0)) := by
  have hc := normBranch_cleared h
  set A := zeta6 ^ (a.val : ℤ) * piC ^ (2 * β) with hAdef
  set B := zeta6 ^ (c.val : ℤ) * piC ^ (2 * δ) with hBdef
  rw [sqrt3_pow_two_mul, sqrt3_pow_two_mul,
    show 2 * β + 2 * δ + 1 = 2 * (β + δ) + 1 by ring, pow_succ, sqrt3_pow_two_mul] at hc
  obtain ⟨hX, hY⟩ := eq_zero_of_add_sqrt3_mul
    (((inRing_three_pow δ).mul (inRing_elt a (2 * β))).add
      ((inRing_three_pow β).mul (inRing_elt c (2 * δ))))
    ((((inRing_elt a (2 * β)).mul (inRing_elt c (2 * δ))).add
      (inRing_three_pow (β + δ))).neg)
    (show ((3 : ℂ) ^ δ * A + (3 : ℂ) ^ β * B)
        + ((Real.sqrt 3 : ℝ) : ℂ) * (-(A * B + (3 : ℂ) ^ (β + δ))) = 0 by
      linear_combination hc)
  -- the product of the two words is `−1`, so its address is `(3, 0)`
  have hAB : A * B = -(3 : ℂ) ^ (β + δ) := by linear_combination -hY
  have hz : zeta6 ^ (((a + c).val : ℕ) : ℤ) = zeta6 ^ (a.val : ℤ) * zeta6 ^ (c.val : ℤ) := by
    rw [← zpow_add₀ zeta6_ne_zero, ← zeta6_zpow_val ((a.val : ℤ) + (c.val : ℤ))]
    congr 2
  have hcl := sqrt3_pow_mul_word (a + c) (2 * β + 2 * δ)
  rw [hz, show (2 * β + 2 * δ) = 2 * (β + δ) by ring, sqrt3_pow_two_mul, pow_mul,
    show ((piC ^ 2) ^ (β + δ)) = piC ^ (2 * β) * piC ^ (2 * δ) by
      rw [← pow_mul, ← pow_add]; ring_nf] at hcl
  have hprod : word (a + c) ((2 * (β + δ) : ℕ) : ℤ) = -1 := by
    refine mul_left_cancel₀ (a := ((3 : ℂ) ^ (β + δ))) (pow_ne_zero _ (by norm_num)) ?_
    rw [hcl]
    have : zeta6 ^ (a.val : ℤ) * zeta6 ^ (c.val : ℤ) * (piC ^ (2 * β) * piC ^ (2 * δ))
        = A * B := by rw [hAdef, hBdef]; ring
    rw [this, hAB]
    ring
  obtain ⟨hac, hbd⟩ := (word_inj (a + c) 3 ((2 * (β + δ) : ℕ) : ℤ) 0).mp
    (by rw [hprod, word_30])
  have hβ : β = 0 := by omega
  have hδ : δ = 0 := by omega
  subst hβ
  subst hδ
  refine ⟨rfl, rfl, ?_⟩
  -- the surviving equation `A + B = 0` says the two hex words are opposite
  have hw : word c 0 = -word a 0 := by
    have hA0 : word a 0 = zeta6 ^ (a.val : ℤ) * piC ^ (2 * 0) := by rw [word]; norm_num
    have hB0 : word c 0 = zeta6 ^ (c.val : ℤ) * piC ^ (2 * 0) := by rw [word]; norm_num
    rw [hA0, hB0]
    linear_combination hX
  obtain ⟨hca, -⟩ := (word_neg_iff a c 0 0).mp hw
  exact zmod_pair_pin a c hac hca

/-- Three divides a product with two units modulo three only through the third factor. -/
private theorem dvd_of_dvd_mul_units {x y z : ℤ} (hx : x % 3 = 1) (hy : y % 3 = 1)
    (h : (3 : ℤ) ∣ x * y * z) : (3 : ℤ) ∣ z := by
  obtain ⟨k, hk⟩ : ∃ k, x = 3 * k + 1 := ⟨x / 3, by omega⟩
  obtain ⟨l, hl⟩ : ∃ l, y = 3 * l + 1 := ⟨y / 3, by omega⟩
  obtain ⟨m, hm⟩ := h
  refine ⟨m - (3 * k * l + k + l) * z, ?_⟩
  have : x * y = 3 * (3 * k * l + k + l) + 1 := by rw [hk, hl]; ring
  rw [this] at hm
  linarith [hm]

/-- **Both heights odd and both at least three**: impossible. Clearing leaves an identity
in `ℤ[ζ₆, π]` whose `π`-coordinates are divisible by three on one side and a unit times
a non-multiple of three on the other. -/
theorem normBranch_odd_large {a c : ZMod 6} {β δ : ℕ} (hβ : 1 ≤ β) (hδ : 1 ≤ δ)
    (h : NormBranch a ((2 * β + 1 : ℕ) : ℤ) c ((2 * δ + 1 : ℕ) : ℤ)) : False := by
  obtain ⟨β', rfl⟩ : ∃ β', β = β' + 1 := ⟨β - 1, by omega⟩
  obtain ⟨δ', rfl⟩ : ∃ δ', δ = δ' + 1 := ⟨δ - 1, by omega⟩
  set b := 2 * (β' + 1) + 1 with hbdef
  set d := 2 * (δ' + 1) + 1 with hddef
  have hc := normBranch_cleared h
  set eA := zeta6 ^ (a.val : ℤ) with heA
  set eC := zeta6 ^ (c.val : ℤ) with heC
  -- cancel the single `√3` common to both sides
  have hring : (3 : ℂ) ^ (δ' + 1) * (eA * piC ^ b) + (3 : ℂ) ^ (β' + 1) * (eC * piC ^ d)
      = (eA * piC ^ b) * (eC * piC ^ d) + (3 : ℂ) ^ (β' + δ' + 3) := by
    refine mul_left_cancel₀ sqrt3_cast_ne_zero ?_
    rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ d = 3 ^ (δ' + 1) * ((Real.sqrt 3 : ℝ) : ℂ) by
        rw [hddef, pow_succ, sqrt3_pow_two_mul],
      show ((Real.sqrt 3 : ℝ) : ℂ) ^ b = 3 ^ (β' + 1) * ((Real.sqrt 3 : ℝ) : ℂ) by
        rw [hbdef, pow_succ, sqrt3_pow_two_mul],
      show ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + d + 1)
          = 3 ^ (β' + δ' + 3) * ((Real.sqrt 3 : ℝ) : ℂ) by
        rw [hbdef, hddef, show 2 * (β' + 1) + 1 + (2 * (δ' + 1) + 1) + 1
            = 2 * (β' + δ' + 3) + 1 by ring, pow_succ, sqrt3_pow_two_mul]] at hc
    linear_combination hc
  -- the norm form, and the two coordinates modulo three
  obtain ⟨mA, hmA⟩ := three_dvd_piCoeff_fst (2 * (β' + 1))
  obtain ⟨mB, hmB⟩ := three_dvd_piCoeff_fst (2 * (δ' + 1))
  set ZA := (piCoeff b).2 with hZA
  set ZB := (piCoeff d).2 with hZB
  have hA : eA * piC ^ b = eA * (3 * (mA : ℂ)) + eA * (ZA : ℂ) * piC := by
    rw [piC_pow_coeff, hbdef]
    rw [show ((piCoeff (2 * (β' + 1) + 1)).1 : ℂ) = ((3 * mA : ℤ) : ℂ) by rw [← hmA]]
    push_cast
    ring
  have hB : eC * piC ^ d = eC * (3 * (mB : ℂ)) + eC * (ZB : ℂ) * piC := by
    rw [piC_pow_coeff, hddef]
    rw [show ((piCoeff (2 * (δ' + 1) + 1)).1 : ℂ) = ((3 * mB : ℤ) : ℂ) by rw [← hmB]]
    push_cast
    ring
  set P := eA * (mA : ℂ) - (3 : ℂ) ^ β' with hP
  set Q := eC * (mB : ℂ) - (3 : ℂ) ^ δ' with hQ
  -- the π-part survives the reduction; everything else carries a factor three
  set V : ℂ := -2 * (3 : ℂ) ^ (β' + δ' + 1) - 3 * (P * Q) - P * (eC * (ZB : ℂ)) * piC
      - Q * (eA * (ZA : ℂ)) * piC + eA * eC * (ZA : ℂ) * (ZB : ℂ) with hV
  have hkey : eA * eC * (ZA : ℂ) * (ZB : ℂ) * piC = 3 * V := by
    have hnorm : (eA * piC ^ b - (3 : ℂ) ^ (β' + 1)) * (eC * piC ^ d - (3 : ℂ) ^ (δ' + 1))
        = -2 * (3 : ℂ) ^ (β' + δ' + 2) := by
      linear_combination -hring
    have hfac1 : eA * piC ^ b - (3 : ℂ) ^ (β' + 1) = 3 * P + eA * (ZA : ℂ) * piC := by
      rw [hA, hP]; ring
    have hfac2 : eC * piC ^ d - (3 : ℂ) ^ (δ' + 1) = 3 * Q + eC * (ZB : ℂ) * piC := by
      rw [hB, hQ]; ring
    rw [hfac1, hfac2] at hnorm
    rw [hV]
    linear_combination hnorm - (eA * eC * (ZA : ℂ) * (ZB : ℂ)) * piC_sq
  -- read the coordinates
  have hVring : InRing V := by
    have hEA : InRing eA := InRing.zeta6_zpow _
    have hEC : InRing eC := InRing.zeta6_zpow _
    have hPr : InRing P := (hEA.mul (InRing.intCast mA)).add (inRing_three_pow β').neg
    have hQr : InRing Q := (hEC.mul (InRing.intCast mB)).add (inRing_three_pow δ').neg
    have hpi : InRing piC := ⟨0, 0, 1, 0, by push_cast; ring⟩
    have t1 : InRing ((-2 : ℂ) * (3 : ℂ) ^ (β' + δ' + 1)) := by
      rw [show ((-2 : ℂ) * (3 : ℂ) ^ (β' + δ' + 1))
        = (((-2 * 3 ^ (β' + δ' + 1) : ℤ)) : ℂ) by push_cast; ring]
      exact InRing.intCast _
    have t2 : InRing ((3 : ℂ) * (P * Q)) := by
      have := InRing.intSmul 3 (hPr.mul hQr)
      rw [show (((3 : ℤ)) : ℂ) = (3 : ℂ) by push_cast; ring] at this
      exact this
    have t3 : InRing (P * (eC * (ZB : ℂ)) * piC) :=
      (hPr.mul (hEC.mul (InRing.intCast ZB))).mul hpi
    have t4 : InRing (Q * (eA * (ZA : ℂ)) * piC) :=
      (hQr.mul (hEA.mul (InRing.intCast ZA))).mul hpi
    have t5 : InRing (eA * eC * (ZA : ℂ) * (ZB : ℂ)) :=
      ((hEA.mul hEC).mul (InRing.intCast ZA)).mul (InRing.intCast ZB)
    have := ((((t1.add t2.neg).add t3.neg).add t4.neg).add t5)
    rw [hV]
    convert this using 1
    ring
  obtain ⟨v₁, v₂, v₃, v₄, hVc⟩ := hVring
  have hz : eA * eC = ((hexE ((a + c).val) : ℤ) : ℂ) + ((hexF ((a + c).val) : ℤ) : ℂ) * zeta6 := by
    rw [heA, heC, ← zpow_add₀ zeta6_ne_zero, ← zeta6_zpow_val ((a.val : ℤ) + (c.val : ℤ)),
      ← zeta6_zpow_hex]
    congr 2
  rw [hz, hVc] at hkey
  obtain ⟨c₁, c₂, c₃, c₄⟩ := inRing_coords_zero
    (n₁ := -(3 * v₁)) (n₂ := -(3 * v₂))
    (n₃ := ZA * ZB * hexE ((a + c).val) - 3 * v₃)
    (n₄ := ZA * ZB * hexF ((a + c).val) - 3 * v₄)
    (by push_cast; linear_combination hkey)
  -- three divides both hex coordinates: impossible
  refine hexE_hexF_not_both_dvd ((a + c).val) (ZMod.val_lt _) ⟨?_, ?_⟩
  · exact dvd_of_dvd_mul_units (piCoeff_snd_emod (2 * (β' + 1))) (piCoeff_snd_emod (2 * (δ' + 1)))
      ⟨v₃, by linarith⟩
  · exact dvd_of_dvd_mul_units (piCoeff_snd_emod (2 * (β' + 1))) (piCoeff_snd_emod (2 * (δ' + 1)))
      ⟨v₄, by linarith⟩

/-- **Both heights one**: the finite case, where the four sporadic chords live. The
cleared identity's four integer coordinates decide the thirty-six hex pairs. -/
theorem normBranch_odd_one {a c : ZMod 6}
    (h : NormBranch a ((1 : ℕ) : ℤ) c ((1 : ℕ) : ℤ)) : (a = 1 ∧ c = 5) ∨ (a = 5 ∧ c = 1) := by
  have hc := normBranch_cleared (b := 1) (d := 1) h
  set eA := zeta6 ^ (a.val : ℤ) with heA
  set eC := zeta6 ^ (c.val : ℤ) with heC
  have hpi1 : piC ^ (1 : ℕ) = piC := pow_one _
  -- cancel the common `√3` and substitute `π² = π − 3`
  have hring : eA * piC + eC * piC = eA * piC * (eC * piC) + 3 := by
    refine mul_left_cancel₀ sqrt3_cast_ne_zero ?_
    have h3 : ((Real.sqrt 3 : ℝ) : ℂ) ^ (1 + 1 + 1) = 3 * ((Real.sqrt 3 : ℝ) : ℂ) := by
      rw [show (1 + 1 + 1) = 2 * 1 + 1 from rfl, pow_succ, sqrt3_pow_two_mul]
      norm_num
    rw [h3] at hc
    simp only [pow_one] at hc
    linear_combination hc
  have hprod : eA * eC = ((hexE ((a + c).val) : ℤ) : ℂ) + ((hexF ((a + c).val) : ℤ) : ℂ) * zeta6 := by
    rw [heA, heC, ← zpow_add₀ zeta6_ne_zero, ← zeta6_zpow_val ((a.val : ℤ) + (c.val : ℤ)),
      ← zeta6_zpow_hex]
    congr 2
  have hA := zeta6_zpow_hex a
  have hC := zeta6_zpow_hex c
  -- the identity's four integer coordinates
  obtain ⟨k₁, k₂, k₃, k₄⟩ := inRing_coords_zero
    (n₁ := 3 * (hexE ((a + c).val) - 1)) (n₂ := 3 * hexF ((a + c).val))
    (n₃ := hexE a.val + hexE c.val - hexE ((a + c).val))
    (n₄ := hexF a.val + hexF c.val - hexF ((a + c).val))
    (by
      rw [← heA] at hA
      rw [← heC] at hC
      push_cast
      linear_combination hring + (eA * eC) * piC_sq - piC * hA - piC * hC
        + (piC - 3) * hprod)
  -- and the finite check over the thirty-six hex pairs
  have hfin : ∀ x y : ZMod 6,
      3 * (hexE ((x + y).val) - 1) = 0 → 3 * hexF ((x + y).val) = 0 →
      hexE x.val + hexE y.val - hexE ((x + y).val) = 0 →
      hexF x.val + hexF y.val - hexF ((x + y).val) = 0 →
      (x = 1 ∧ y = 5) ∨ (x = 5 ∧ y = 1) := by decide
  exact hfin a c k₁ k₂ k₃ k₄

/-- **One height one, the other at least three**: the glue-incident solution, and only
it. The congruence pins the hex address to zero; the seam coefficient's indivisibility
by three then pins the height to three. -/
theorem normBranch_odd_mixed {a c : ZMod 6} {δ : ℕ} (hδ : 1 ≤ δ)
    (h : NormBranch a ((1 : ℕ) : ℤ) c ((2 * δ + 1 : ℕ) : ℤ)) :
    a = 0 ∧ c = 3 ∧ δ = 1 := by
  set d := 2 * δ + 1 with hddef
  have hc := normBranch_cleared (b := 1) (d := d) h
  set eA := zeta6 ^ (a.val : ℤ) with heA
  set eC := zeta6 ^ (c.val : ℤ) with heC
  obtain ⟨m, hm⟩ := three_dvd_piCoeff_fst (2 * δ)
  set Z := (piCoeff d).2 with hZ
  have hZ3 : Z % 3 = 1 := piCoeff_snd_emod (2 * δ)
  have hring : (3 : ℂ) ^ δ * (eA * piC) + eC * piC ^ d
      = eA * piC * (eC * piC ^ d) + 3 * (3 : ℂ) ^ δ := by
    refine mul_left_cancel₀ sqrt3_cast_ne_zero ?_
    rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ d = 3 ^ δ * ((Real.sqrt 3 : ℝ) : ℂ) by
        rw [hddef, pow_succ, sqrt3_pow_two_mul],
      show ((Real.sqrt 3 : ℝ) : ℂ) ^ (1 + d + 1) = 3 * (3 : ℂ) ^ δ * ((Real.sqrt 3 : ℝ) : ℂ) by
        rw [hddef, show 1 + (2 * δ + 1) + 1 = 2 * (δ + 1) + 1 by ring, pow_succ,
          sqrt3_pow_two_mul, pow_succ]
        ring,
      pow_one] at hc
    linear_combination hc
  have hpd : piC ^ d = 3 * (m : ℂ) + (Z : ℂ) * piC := by
    rw [piC_pow_coeff, hZ, hddef,
      show ((piCoeff (2 * δ + 1)).1 : ℂ) = ((3 * m : ℤ) : ℂ) by rw [← hm]]
    push_cast
    ring
  have hA := zeta6_zpow_hex a
  have hC := zeta6_zpow_hex c
  have hprod : eA * eC
      = ((hexE ((a + c).val) : ℤ) : ℂ) + ((hexF ((a + c).val) : ℤ) : ℂ) * zeta6 := by
    rw [heA, heC, ← zpow_add₀ zeta6_ne_zero, ← zeta6_zpow_val ((a.val : ℤ) + (c.val : ℤ)),
      ← zeta6_zpow_hex]
    congr 2
  rw [← heA] at hA
  rw [← heC] at hC
  obtain ⟨k₁, k₂, k₃, k₄⟩ := inRing_coords_zero
    (n₁ := 3 * m * hexE c.val + 3 * Z * hexE ((a + c).val) - 3 * 3 ^ δ)
    (n₂ := 3 * m * hexF c.val + 3 * Z * hexF ((a + c).val))
    (n₃ := 3 ^ δ * hexE a.val + Z * hexE c.val - 3 * m * hexE ((a + c).val)
      - Z * hexE ((a + c).val))
    (n₄ := 3 ^ δ * hexF a.val + Z * hexF c.val - 3 * m * hexF ((a + c).val)
      - Z * hexF ((a + c).val))
    (by
      push_cast
      linear_combination hring - (eC - eA * eC * piC) * hpd + (Z : ℂ) * (eA * eC) * piC_sq
        - (3 : ℂ) ^ δ * piC * hA - (3 * (m : ℂ) + (Z : ℂ) * piC) * hC
        + (3 * (m : ℂ) * piC + (Z : ℂ) * piC - 3 * (Z : ℂ)) * hprod)
  obtain ⟨δ', rfl⟩ : ∃ δ', δ = δ' + 1 := ⟨δ - 1, by omega⟩
  -- modulo three the product's hex address must equal `c`'s, which forces `a = 0`
  have ha0 : a = 0 := by
    obtain ⟨k, hk⟩ : ∃ k, Z = 3 * k + 1 := ⟨Z / 3, by omega⟩
    have hpow : (3 : ℤ) ^ (δ' + 1) = 3 * 3 ^ δ' := by ring
    rw [hpow, hk] at k₃ k₄
    have h1 : (3 : ℤ) ∣ hexE c.val - hexE ((a + c).val) :=
      ⟨m * hexE ((a + c).val) - 3 ^ δ' * hexE a.val
        - k * (hexE c.val - hexE ((a + c).val)), by linear_combination k₃⟩
    have h2 : (3 : ℤ) ∣ hexF c.val - hexF ((a + c).val) :=
      ⟨m * hexF ((a + c).val) - 3 ^ δ' * hexF a.val
        - k * (hexF c.val - hexF ((a + c).val)), by linear_combination k₄⟩
    have hfin : ∀ x y : ZMod 6, (3 : ℤ) ∣ hexE y.val - hexE ((x + y).val) →
        (3 : ℤ) ∣ hexF y.val - hexF ((x + y).val) → x = 0 := by decide
    exact hfin a c h1 h2
  subst ha0
  have hEA : hexE (0 : ZMod 6).val = 1 := by decide
  have hFA : hexF (0 : ZMod 6).val = 0 := by decide
  simp only [zero_add] at k₁ k₂ k₃ k₄
  rw [hEA] at k₃
  rw [hFA] at k₄
  -- the four integer equations now pin `c` and the height
  have hmEC : m * hexE c.val = 3 ^ δ' := by
    have hpow : (3 : ℤ) ^ (δ' + 1) = 3 * 3 ^ δ' := by ring
    rw [hpow] at k₃
    linarith
  have hmFC : m * hexF c.val = 0 := by
    have hpow : (3 : ℤ) ^ (δ' + 1) = 3 * 3 ^ δ' := by ring
    rw [hpow] at k₄
    linarith
  have hsum : (m + Z) * hexE c.val = 3 * 3 ^ δ' := by
    have hpow : (3 : ℤ) ^ (δ' + 1) = 3 * 3 ^ δ' := by ring
    rw [hpow] at k₁
    linarith
  have hpos : (0 : ℤ) < 3 ^ δ' := by positivity
  have hmne : m ≠ 0 := by
    intro h0
    rw [h0, zero_mul] at hmEC
    omega
  have hFC0 : hexF c.val = 0 := by
    rcases mul_eq_zero.mp hmFC with h0 | h0
    · exact absurd h0 hmne
    · exact h0
  have hECne : hexE c.val ≠ 0 := by
    intro h0
    rw [h0, mul_zero] at hmEC
    omega
  have hZ2m : Z = 2 * m := by
    have h2 : (Z - 2 * m) * hexE c.val = 0 := by
      have : (m + Z) * hexE c.val = 3 * (m * hexE c.val) := by rw [hsum, hmEC]
      linarith [this]
    rcases mul_eq_zero.mp h2 with h0 | h0
    · linarith
    · exact absurd h0 hECne
  -- `3 ∤ Z` forces `δ' = 0`, and then the concrete height-three data pins `c = 3`
  have hδ0 : δ' = 0 := by
    by_contra hne
    obtain ⟨e, rfl⟩ : ∃ e, δ' = e + 1 := ⟨δ' - 1, by omega⟩
    have hEC1 : hexE c.val = 1 ∨ hexE c.val = -1 := by
      have hfin : ∀ y : ZMod 6, hexF y.val = 0 → hexE y.val = 1 ∨ hexE y.val = -1 := by decide
      exact hfin c hFC0
    have h3m : (3 : ℤ) ∣ m := by
      have hpow : (3 : ℤ) ^ (e + 1) = 3 * 3 ^ e := by ring
      rw [hpow] at hmEC
      rcases hEC1 with h1 | h1 <;> rw [h1] at hmEC
      · exact ⟨3 ^ e, by linarith⟩
      · exact ⟨-(3 ^ e), by linarith⟩
    omega
  subst hδ0
  have hZval : Z = -2 := by
    rw [hZ, hddef]
    decide
  have hm1 : m = -1 := by omega
  have hEC1 : hexE c.val = -1 := by
    rw [hm1] at hmEC
    simp only [pow_zero, neg_mul, one_mul, neg_eq_iff_eq_neg] at hmEC
    linarith
  have hfin : ∀ y : ZMod 6, hexE y.val = -1 → hexF y.val = 0 → y = 3 := by decide
  exact ⟨rfl, hfin c hEC1 hFC0, rfl⟩

/-! ### The mixed-sign heights

A negative second height clears through the conjugate root `π̄ = 1 − π` — still inside
`ℤ[ζ₆, π]`, so the separation and the congruences carry over. What is genuinely new is
the collapse `π^b·π̄^e = 3^e·π^{b−e}` (from `π·π̄ = 3`): it concentrates the two cleared
words' product into a single `π`-power, and one coordinate row modulo three then kills
every mixed-sign case. -/

private theorem conj_piC : (starRingEnd ℂ) piC = 1 - piC := by
  apply Complex.ext <;>
    simp [piC, Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im]
  all_goals norm_num

/-- The two roots of `x² − x + 3` multiply to the constant term: `π·π̄ = 3`. -/
private theorem piC_mul_one_sub : piC * (1 - piC) = 3 := by
  linear_combination -piC_sq

/-- The conjugate root's powers in the same integer coordinates:
`π̄^n = (px + py) − py·π`. -/
private theorem one_sub_piC_pow_coeff (n : ℕ) :
    (1 - piC) ^ n
      = ((piCoeff n).1 : ℂ) + ((piCoeff n).2 : ℂ) - ((piCoeff n).2 : ℂ) * piC := by
  have h := congrArg (starRingEnd ℂ) (piC_pow_coeff n)
  rw [map_pow, conj_piC, map_add, map_mul, map_intCast, map_intCast, conj_piC] at h
  rw [h]
  ring

/-- The clearing identity at negative seam height: `√3^e · word c (−e) = ζ₆^c · π̄^e`. -/
private theorem sqrt3_pow_mul_word_neg (c : ZMod 6) (e : ℕ) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ e * word c (-(e : ℤ))
      = zeta6 ^ (c.val : ℤ) * (1 - piC) ^ e := by
  have hs : seam ^ (-(e : ℤ)) = ((starRingEnd ℂ) seam) ^ e := by
    rw [zpow_neg, zpow_natCast, ← inv_pow]
    congr 1
    exact (eq_inv_of_mul_eq_one_right seam_mul_conj).symm
  have hp : ((Real.sqrt 3 : ℝ) : ℂ) * (starRingEnd ℂ) seam = 1 - piC := by
    rw [← conj_piC, piC_eq_sqrt3_mul_seam, map_mul, Complex.conj_ofReal]
  calc ((Real.sqrt 3 : ℝ) : ℂ) ^ e * word c (-(e : ℤ))
      = zeta6 ^ (c.val : ℤ) * (((Real.sqrt 3 : ℝ) : ℂ) * (starRingEnd ℂ) seam) ^ e := by
        rw [word, hs, mul_pow]
        ring
    _ = zeta6 ^ (c.val : ℤ) * (1 - piC) ^ e := by rw [hp]

private theorem normSq_ringElt_neg (c : ZMod 6) (e : ℕ) :
    normSq (zeta6 ^ (c.val : ℤ) * (1 - piC) ^ e) = 3 ^ e := by
  rw [map_mul, map_pow, ← conj_piC, Complex.normSq_conj, normSq_piC]
  have : normSq (zeta6 ^ (c.val : ℤ)) = 1 := by
    rw [← Complex.sq_norm, norm_zpow, norm_zeta6, one_zpow]
    norm_num
  rw [this, one_mul]

private theorem inRing_elt_neg (c : ZMod 6) (e : ℕ) :
    InRing (zeta6 ^ (c.val : ℤ) * (1 - piC) ^ e) := by
  refine (InRing.zeta6_zpow _).mul ?_
  rw [one_sub_piC_pow_coeff]
  exact ⟨(piCoeff e).1 + (piCoeff e).2, 0, -(piCoeff e).2, 0, by push_cast; ring⟩

/-- The norm branch cleared at a negative second height — `normBranch_cleared`'s mirror,
with `π̄^e` carrying the second word. -/
theorem normBranch_cleared_neg {a c : ZMod 6} {b e : ℕ}
    (h : NormBranch a (b : ℤ) c (-(e : ℤ))) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ e * (zeta6 ^ (a.val : ℤ) * piC ^ b)
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ b * (zeta6 ^ (c.val : ℤ) * (1 - piC) ^ e)
      = ((Real.sqrt 3 : ℝ) : ℂ) * ((zeta6 ^ (a.val : ℤ) * piC ^ b)
          * (zeta6 ^ (c.val : ℤ) * (1 - piC) ^ e))
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + e + 1) := by
  have hA := sqrt3_pow_mul_word a b
  have hB := sqrt3_pow_mul_word_neg c e
  rw [NormBranch] at h
  have key : ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + e) * (word a (b : ℤ) + word c (-(e : ℤ)))
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + e)
        * (((Real.sqrt 3 : ℝ) : ℂ) * (word a (b : ℤ) * word c (-(e : ℤ)) + 1)) := by
    rw [h]
  rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + e) * (word a (b : ℤ) + word c (-(e : ℤ)))
      = ((Real.sqrt 3 : ℝ) : ℂ) ^ e * (((Real.sqrt 3 : ℝ) : ℂ) ^ b * word a (b : ℤ))
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ b
          * (((Real.sqrt 3 : ℝ) : ℂ) ^ e * word c (-(e : ℤ))) by
      rw [pow_add]; ring] at key
  rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + e)
        * (((Real.sqrt 3 : ℝ) : ℂ) * (word a (b : ℤ) * word c (-(e : ℤ)) + 1))
      = ((Real.sqrt 3 : ℝ) : ℂ) * ((((Real.sqrt 3 : ℝ) : ℂ) ^ b * word a (b : ℤ))
          * (((Real.sqrt 3 : ℝ) : ℂ) ^ e * word c (-(e : ℤ))))
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (b + e + 1) by
      rw [pow_add, pow_add, pow_one]; ring] at key
  rw [hA, hB] at key
  exact key

/-- **Mixed parity is impossible at mixed signs too**: the same modulus obstruction as
`normBranch_parity`, with the conjugate root carrying the negative height. -/
theorem normBranch_parity_neg {a c : ZMod 6} {b e : ℕ}
    (h : NormBranch a (b : ℤ) c (-(e : ℤ))) : b % 2 = e % 2 := by
  by_contra hpar
  have hcase : (b % 2 = 0 ∧ e % 2 = 1) ∨ (b % 2 = 1 ∧ e % 2 = 0) := by omega
  rcases hcase with ⟨hb2, he2⟩ | ⟨hb2, he2⟩
  · obtain ⟨β, rfl⟩ : ∃ β, b = 2 * β := ⟨b / 2, by omega⟩
    obtain ⟨ε, rfl⟩ : ∃ ε, e = 2 * ε + 1 := ⟨e / 2, by omega⟩
    have hc := normBranch_cleared_neg h
    set A := zeta6 ^ (a.val : ℤ) * piC ^ (2 * β) with hAdef
    set B := zeta6 ^ (c.val : ℤ) * (1 - piC) ^ (2 * ε + 1) with hBdef
    rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * ε + 1)
        = ((Real.sqrt 3 : ℝ) : ℂ) * 3 ^ ε by rw [pow_succ, sqrt3_pow_two_mul]; ring,
      sqrt3_pow_two_mul,
      show 2 * β + (2 * ε + 1) + 1 = 2 * (β + ε + 1) by ring, sqrt3_pow_two_mul] at hc
    obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
      (((inRing_three_pow β).mul (inRing_elt_neg c (2 * ε + 1))).add
        (inRing_three_pow (β + ε + 1)).neg)
      (((inRing_three_pow ε).mul (inRing_elt a (2 * β))).add
        (((inRing_elt a (2 * β)).mul (inRing_elt_neg c (2 * ε + 1))).neg))
      (show ((3 : ℂ) ^ β * B + -(3 : ℂ) ^ (β + ε + 1))
          + ((Real.sqrt 3 : ℝ) : ℂ) * ((3 : ℂ) ^ ε * A + -(A * B)) = 0 by
        linear_combination hc)
    have hB3 : B = (3 : ℂ) ^ (ε + 1) := by
      refine mul_left_cancel₀ (a := ((3 : ℂ) ^ β)) (pow_ne_zero _ (by norm_num)) ?_
      rw [show ((3 : ℂ) ^ β * (3 : ℂ) ^ (ε + 1)) = (3 : ℂ) ^ (β + ε + 1) by
        rw [← pow_add]; ring_nf]
      linear_combination hX
    have hnorm := normSq_ringElt_neg c (2 * ε + 1)
    rw [← hBdef, hB3, map_pow, show normSq (3 : ℂ) = 9 by norm_num [normSq_apply]] at hnorm
    have hgrow : (9 : ℝ) ^ (ε + 1) = 3 * 3 ^ (2 * ε + 1) := by
      rw [show (9 : ℝ) = 3 ^ 2 by norm_num, ← pow_mul]
      ring
    nlinarith [hnorm, hgrow, pow_pos (show (0 : ℝ) < 3 by norm_num) (2 * ε + 1)]
  · obtain ⟨β, rfl⟩ : ∃ β, b = 2 * β + 1 := ⟨b / 2, by omega⟩
    obtain ⟨ε, rfl⟩ : ∃ ε, e = 2 * ε := ⟨e / 2, by omega⟩
    have hc := normBranch_cleared_neg h
    set A := zeta6 ^ (a.val : ℤ) * piC ^ (2 * β + 1) with hAdef
    set B := zeta6 ^ (c.val : ℤ) * (1 - piC) ^ (2 * ε) with hBdef
    rw [sqrt3_pow_two_mul,
      show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + 1)
        = ((Real.sqrt 3 : ℝ) : ℂ) * 3 ^ β by rw [pow_succ, sqrt3_pow_two_mul]; ring,
      show 2 * β + 1 + 2 * ε + 1 = 2 * (β + ε + 1) by ring, sqrt3_pow_two_mul] at hc
    obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
      (((inRing_three_pow ε).mul (inRing_elt a (2 * β + 1))).add
        (inRing_three_pow (β + ε + 1)).neg)
      (((inRing_three_pow β).mul (inRing_elt_neg c (2 * ε))).add
        (((inRing_elt a (2 * β + 1)).mul (inRing_elt_neg c (2 * ε))).neg))
      (show ((3 : ℂ) ^ ε * A + -(3 : ℂ) ^ (β + ε + 1))
          + ((Real.sqrt 3 : ℝ) : ℂ) * ((3 : ℂ) ^ β * B + -(A * B)) = 0 by
        linear_combination hc)
    have hA3 : A = (3 : ℂ) ^ (β + 1) := by
      refine mul_left_cancel₀ (a := ((3 : ℂ) ^ ε)) (pow_ne_zero _ (by norm_num)) ?_
      rw [show ((3 : ℂ) ^ ε * (3 : ℂ) ^ (β + 1)) = (3 : ℂ) ^ (β + ε + 1) by
        rw [← pow_add]; ring_nf]
      linear_combination hX
    have hnorm := normSq_ringElt a (2 * β + 1)
    rw [← hAdef, hA3, map_pow, show normSq (3 : ℂ) = 9 by norm_num [normSq_apply]] at hnorm
    have hgrow : (9 : ℝ) ^ (β + 1) = 3 * 3 ^ (2 * β + 1) := by
      rw [show (9 : ℝ) = 3 ^ 2 by norm_num, ← pow_mul]
      ring
    nlinarith [hnorm, hgrow, pow_pos (show (0 : ℝ) < 3 by norm_num) (2 * β + 1)]

/-- **Both heights even at mixed signs**: impossible beyond height zero. The separation
forces the two words to be opposite AND multiply to `−1`, so one word squares to `1` —
a relation the backbone reserves for height zero. -/
theorem normBranch_even_neg {a c : ZMod 6} {β ε : ℕ} (hε : 1 ≤ ε)
    (h : NormBranch a ((2 * β : ℕ) : ℤ) c (-((2 * ε : ℕ) : ℤ))) : False := by
  have hc := normBranch_cleared_neg h
  set A := zeta6 ^ (a.val : ℤ) * piC ^ (2 * β) with hAdef
  set B := zeta6 ^ (c.val : ℤ) * (1 - piC) ^ (2 * ε) with hBdef
  rw [sqrt3_pow_two_mul, sqrt3_pow_two_mul,
    show 2 * β + 2 * ε + 1 = 2 * (β + ε) + 1 by ring, pow_succ, sqrt3_pow_two_mul] at hc
  obtain ⟨hX, hY⟩ := eq_zero_of_add_sqrt3_mul
    (((inRing_three_pow ε).mul (inRing_elt a (2 * β))).add
      ((inRing_three_pow β).mul (inRing_elt_neg c (2 * ε))))
    ((((inRing_elt a (2 * β)).mul (inRing_elt_neg c (2 * ε))).add
      (inRing_three_pow (β + ε))).neg)
    (show ((3 : ℂ) ^ ε * A + (3 : ℂ) ^ β * B)
        + ((Real.sqrt 3 : ℝ) : ℂ) * (-(A * B + (3 : ℂ) ^ (β + ε))) = 0 by
      linear_combination hc)
  have hAw : A = (3 : ℂ) ^ β * word a ((2 * β : ℕ) : ℤ) := by
    rw [hAdef, ← sqrt3_pow_mul_word, sqrt3_pow_two_mul]
  have hBw : B = (3 : ℂ) ^ ε * word c (-((2 * ε : ℕ) : ℤ)) := by
    rw [hBdef, ← sqrt3_pow_mul_word_neg, sqrt3_pow_two_mul]
  rw [← hAdef, ← hBdef, hAw, hBw] at hX hY
  have h3 : ((3 : ℂ) ^ (β + ε)) ≠ 0 := pow_ne_zero _ (by norm_num)
  have hsum : word a ((2 * β : ℕ) : ℤ) + word c (-((2 * ε : ℕ) : ℤ)) = 0 := by
    refine mul_left_cancel₀ h3 ?_
    rw [mul_zero]
    linear_combination hX
  have hprod : word a ((2 * β : ℕ) : ℤ) * word c (-((2 * ε : ℕ) : ℤ)) = -1 := by
    refine mul_left_cancel₀ h3 ?_
    linear_combination -hY
  have hw2 : word c (-((2 * ε : ℕ) : ℤ)) * word c (-((2 * ε : ℕ) : ℤ)) = 1 := by
    have hopp : word a ((2 * β : ℕ) : ℤ) = -word c (-((2 * ε : ℕ) : ℤ)) := by
      linear_combination hsum
    rw [hopp] at hprod
    linear_combination -hprod
  rw [← word_add] at hw2
  obtain ⟨-, hb0⟩ := (word_eq_one_iff _ _).mp hw2
  omega

/-- **Both heights odd at mixed signs, larger height on the `π` side**: impossible. The
product of the two cleared words collapses through `π·π̄ = 3` to a single `π`-power, and
one coordinate row of the resulting identity equates a unit times a non-multiple of
three with a multiple of three. -/
private theorem normBranch_odd_neg_aux {a c : ZMod 6} {β ε : ℕ} (hle : ε ≤ β)
    (h : NormBranch a ((2 * β + 1 : ℕ) : ℤ) c (-((2 * ε + 1 : ℕ) : ℤ))) : False := by
  obtain ⟨g, rfl⟩ : ∃ g, β = ε + g := ⟨β - ε, by omega⟩
  have hc := normBranch_cleared_neg h
  set eA := zeta6 ^ (a.val : ℤ) with heA
  set eC := zeta6 ^ (c.val : ℤ) with heC
  -- cancel the single √3 carried by every term
  have hring : (3 : ℂ) ^ ε * (eA * piC ^ (2 * (ε + g) + 1))
        + (3 : ℂ) ^ (ε + g) * (eC * (1 - piC) ^ (2 * ε + 1))
      = (eA * piC ^ (2 * (ε + g) + 1)) * (eC * (1 - piC) ^ (2 * ε + 1))
        + (3 : ℂ) ^ (2 * ε + g + 1) := by
    refine mul_left_cancel₀ sqrt3_cast_ne_zero ?_
    rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * ε + 1)
        = 3 ^ ε * ((Real.sqrt 3 : ℝ) : ℂ) by rw [pow_succ, sqrt3_pow_two_mul],
      show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * (ε + g) + 1)
        = 3 ^ (ε + g) * ((Real.sqrt 3 : ℝ) : ℂ) by rw [pow_succ, sqrt3_pow_two_mul],
      show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * (ε + g) + 1 + (2 * ε + 1) + 1)
          = 3 ^ (2 * ε + g + 1) * ((Real.sqrt 3 : ℝ) : ℂ) by
        rw [show 2 * (ε + g) + 1 + (2 * ε + 1) + 1 = 2 * (2 * ε + g + 1) + 1 by ring,
          pow_succ, sqrt3_pow_two_mul]] at hc
    linear_combination hc
  -- the collapse: π^b·π̄^e = 3^e·π^{b−e}
  have hcollapse : piC ^ (2 * (ε + g) + 1) * (1 - piC) ^ (2 * ε + 1)
      = (3 : ℂ) ^ (2 * ε + 1) * piC ^ (2 * g) := by
    rw [show 2 * (ε + g) + 1 = (2 * ε + 1) + 2 * g by ring, pow_add,
      show piC ^ (2 * ε + 1) * piC ^ (2 * g) * (1 - piC) ^ (2 * ε + 1)
        = (piC * (1 - piC)) ^ (2 * ε + 1) * piC ^ (2 * g) by rw [mul_pow]; ring,
      piC_mul_one_sub]
  -- divide by 3^ε
  have hM : eA * piC ^ (2 * (ε + g) + 1) + (3 : ℂ) ^ g * (eC * (1 - piC) ^ (2 * ε + 1))
      = (3 : ℂ) ^ (ε + 1) * ((eA * eC) * piC ^ (2 * g)) + (3 : ℂ) ^ (ε + g + 1) := by
    refine mul_left_cancel₀ (pow_ne_zero ε (show (3 : ℂ) ≠ 0 by norm_num)) ?_
    linear_combination hring + (eA * eC) * hcollapse
  -- read the four integer coordinates
  have hpb := piC_pow_coeff (2 * (ε + g) + 1)
  have hpe := one_sub_piC_pow_coeff (2 * ε + 1)
  have hpg := piC_pow_coeff (2 * g)
  have hA := zeta6_zpow_hex a
  have hC := zeta6_zpow_hex c
  have hprod : eA * eC
      = ((hexE ((a + c).val) : ℤ) : ℂ) + ((hexF ((a + c).val) : ℤ) : ℂ) * zeta6 := by
    rw [heA, heC, ← zpow_add₀ zeta6_ne_zero, ← zeta6_zpow_val ((a.val : ℤ) + (c.val : ℤ)),
      ← zeta6_zpow_hex]
    congr 2
  rw [← heA] at hA
  rw [← heC] at hC
  obtain ⟨k₁, k₂, k₃, k₄⟩ := inRing_coords_zero
    (n₁ := hexE a.val * (piCoeff (2 * (ε + g) + 1)).1
      + 3 ^ g * (hexE c.val * ((piCoeff (2 * ε + 1)).1 + (piCoeff (2 * ε + 1)).2))
      - 3 ^ (ε + 1) * (hexE ((a + c).val) * (piCoeff (2 * g)).1) - 3 ^ (ε + g + 1))
    (n₂ := hexF a.val * (piCoeff (2 * (ε + g) + 1)).1
      + 3 ^ g * (hexF c.val * ((piCoeff (2 * ε + 1)).1 + (piCoeff (2 * ε + 1)).2))
      - 3 ^ (ε + 1) * (hexF ((a + c).val) * (piCoeff (2 * g)).1))
    (n₃ := hexE a.val * (piCoeff (2 * (ε + g) + 1)).2
      - 3 ^ g * (hexE c.val * (piCoeff (2 * ε + 1)).2)
      - 3 ^ (ε + 1) * (hexE ((a + c).val) * (piCoeff (2 * g)).2))
    (n₄ := hexF a.val * (piCoeff (2 * (ε + g) + 1)).2
      - 3 ^ g * (hexF c.val * (piCoeff (2 * ε + 1)).2)
      - 3 ^ (ε + 1) * (hexF ((a + c).val) * (piCoeff (2 * g)).2))
    (by
      push_cast
      linear_combination hM - eA * hpb - ((3 : ℂ) ^ g * eC) * hpe
        + ((3 : ℂ) ^ (ε + 1) * (eA * eC)) * hpg
        - (((piCoeff (2 * (ε + g) + 1)).1 : ℂ)
            + ((piCoeff (2 * (ε + g) + 1)).2 : ℂ) * piC) * hA
        - ((3 : ℂ) ^ g * ((((piCoeff (2 * ε + 1)).1 : ℂ) + ((piCoeff (2 * ε + 1)).2 : ℂ))
            - ((piCoeff (2 * ε + 1)).2 : ℂ) * piC)) * hC
        + ((3 : ℂ) ^ (ε + 1) * (((piCoeff (2 * g)).1 : ℂ)
            + ((piCoeff (2 * g)).2 : ℂ) * piC)) * hprod)
  have hZb : (piCoeff (2 * (ε + g) + 1)).2 % 3 = 1 := piCoeff_snd_emod _
  have hSe : (piCoeff (2 * ε + 1)).2 % 3 = 1 := piCoeff_snd_emod _
  have hRe : (3 : ℤ) ∣ (piCoeff (2 * ε + 1)).1 := three_dvd_piCoeff_fst _
  have hPb : (3 : ℤ) ∣ (piCoeff (2 * (ε + g) + 1)).1 := three_dvd_piCoeff_fst _
  rcases Nat.eq_zero_or_pos g with hg0 | hgpos
  · -- equal heights: the constant rows read `eC` modulo three
    subst hg0
    obtain ⟨p, hp⟩ := hPb
    obtain ⟨r, hr⟩ := hRe
    have hRS : ((piCoeff (2 * ε + 1)).1 + (piCoeff (2 * ε + 1)).2) % 3 = 1 := by omega
    rw [hp] at k₁ k₂
    have hEC3 : (3 : ℤ) ∣ hexE c.val := by
      refine dvd_of_dvd_mul_units hRS (show (1 : ℤ) % 3 = 1 by decide) ?_
      exact ⟨3 ^ ε * (hexE ((a + c).val) * (piCoeff (2 * 0)).1) + 3 ^ ε
        - hexE a.val * p, by linear_combination k₁⟩
    have hFC3 : (3 : ℤ) ∣ hexF c.val := by
      refine dvd_of_dvd_mul_units hRS (show (1 : ℤ) % 3 = 1 by decide) ?_
      exact ⟨3 ^ ε * (hexF ((a + c).val) * (piCoeff (2 * 0)).1)
        - hexF a.val * p, by linear_combination k₂⟩
    exact hexE_hexF_not_both_dvd c.val (ZMod.val_lt c) ⟨hEC3, hFC3⟩
  · -- strictly larger height: the π rows read `eA` modulo three
    obtain ⟨g', rfl⟩ : ∃ g', g = g' + 1 := ⟨g - 1, by omega⟩
    have hEA3 : (3 : ℤ) ∣ hexE a.val := by
      refine dvd_of_dvd_mul_units hZb (show (1 : ℤ) % 3 = 1 by decide) ?_
      exact ⟨3 ^ g' * (hexE c.val * (piCoeff (2 * ε + 1)).2)
        + 3 ^ ε * (hexE ((a + c).val) * (piCoeff (2 * (g' + 1))).2),
        by linear_combination k₃⟩
    have hFA3 : (3 : ℤ) ∣ hexF a.val := by
      refine dvd_of_dvd_mul_units hZb (show (1 : ℤ) % 3 = 1 by decide) ?_
      exact ⟨3 ^ g' * (hexF c.val * (piCoeff (2 * ε + 1)).2)
        + 3 ^ ε * (hexF ((a + c).val) * (piCoeff (2 * (g' + 1))).2),
        by linear_combination k₄⟩
    exact hexE_hexF_not_both_dvd a.val (ZMod.val_lt a) ⟨hEA3, hFA3⟩

/-- **Odd heights of mixed sign never solve the norm branch**: the sporadics and both
glue families all live at same-sign heights. -/
theorem normBranch_odd_neg {a c : ZMod 6} {β ε : ℕ}
    (h : NormBranch a ((2 * β + 1 : ℕ) : ℤ) c (-((2 * ε + 1 : ℕ) : ℤ))) : False := by
  rcases le_total ε β with hle | hle
  · exact normBranch_odd_neg_aux hle h
  · have h' := normBranch_conj (normBranch_swap h)
    rw [neg_neg] at h'
    exact normBranch_odd_neg_aux hle h'

/-- The classification at non-negative heights: a crossing, a sporadic, or the glue
pair — the assembly of the five parity cases. -/
private theorem normBranch_nat_complete {a c : ZMod 6} {m n : ℕ}
    (h : NormBranch a (m : ℤ) c (n : ℤ)) :
    (a = 0 ∧ m = 0 ∧ c = 3 ∧ n = 0) ∨ (a = 3 ∧ m = 0 ∧ c = 0 ∧ n = 0) ∨
      (a = 1 ∧ m = 1 ∧ c = 5 ∧ n = 1) ∨ (a = 5 ∧ m = 1 ∧ c = 1 ∧ n = 1) ∨
      (a = 0 ∧ m = 1 ∧ c = 3 ∧ n = 3) ∨ (a = 3 ∧ m = 3 ∧ c = 0 ∧ n = 1) := by
  have hpar := normBranch_parity h
  rcases Nat.even_or_odd m with hme | hmo
  · obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β := by
      rcases hme with ⟨t, ht⟩
      exact ⟨t, by omega⟩
    obtain ⟨δ, rfl⟩ : ∃ δ, n = 2 * δ := ⟨n / 2, by omega⟩
    obtain ⟨hβ0, hδ0, hcr⟩ := normBranch_even h
    subst hβ0
    subst hδ0
    rcases hcr with ⟨ha, hc'⟩ | ⟨ha, hc'⟩
    · exact Or.inl ⟨ha, by norm_num, hc', by norm_num⟩
    · exact Or.inr (Or.inl ⟨ha, by norm_num, hc', by norm_num⟩)
  · obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β + 1 := by
      rcases hmo with ⟨t, ht⟩
      exact ⟨t, by omega⟩
    obtain ⟨δ, rfl⟩ : ∃ δ, n = 2 * δ + 1 := ⟨n / 2, by omega⟩
    rcases Nat.eq_zero_or_pos β with hβ0 | hβpos <;>
      rcases Nat.eq_zero_or_pos δ with hδ0 | hδpos
    · subst hβ0
      subst hδ0
      have h1 : NormBranch a ((1 : ℕ) : ℤ) c ((1 : ℕ) : ℤ) := by
        rw [show (2 * 0 + 1 : ℕ) = 1 by norm_num] at h
        exact h
      rcases normBranch_odd_one h1 with ⟨ha, hc'⟩ | ⟨ha, hc'⟩
      · exact Or.inr (Or.inr (Or.inl ⟨ha, by norm_num, hc', by norm_num⟩))
      · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨ha, by norm_num, hc', by norm_num⟩)))
    · subst hβ0
      have h1 : NormBranch a ((1 : ℕ) : ℤ) c ((2 * δ + 1 : ℕ) : ℤ) := by
        rw [show (2 * 0 + 1 : ℕ) = 1 by norm_num] at h
        exact h
      obtain ⟨ha, hc', hδ1⟩ := normBranch_odd_mixed hδpos h1
      subst hδ1
      exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl ⟨ha, by norm_num, hc', by norm_num⟩))))
    · subst hδ0
      have h1 : NormBranch c ((1 : ℕ) : ℤ) a ((2 * β + 1 : ℕ) : ℤ) := by
        have hs := normBranch_swap h
        rw [show (2 * 0 + 1 : ℕ) = 1 by norm_num] at hs
        exact hs
      obtain ⟨hc', ha, hβ1⟩ := normBranch_odd_mixed hβpos h1
      subst hβ1
      exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr ⟨ha, by norm_num, hc', by norm_num⟩))))
    · exact (normBranch_odd_large hβpos hδpos h).elim

/-- The complete solution set of the ii **norm-branch** equation on the lattice, as
address tuples: the two matching-crossing points, the four sporadics, and the four
glue-incident solutions `(σ, −σ³)` (conjugates and swaps included). The matching
branch — the infinite family `c = a + 3, d = b` — is deliberately NOT here: it is
`ii_chord_iff`'s first disjunct. -/
def iiNormTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(0, 0, 3, 0), (3, 0, 0, 0),
   (1, 1, 5, 1), (5, 1, 1, 1), (1, -1, 5, -1), (5, -1, 1, -1),
   (0, 1, 3, 3), (3, 3, 0, 1), (0, -1, 3, -3), (3, -3, 0, -1)]

/-- **ii completeness**: every lattice solution of the norm form is in the table. The
parity split (`normBranch_parity` / `normBranch_parity_neg`) reduces the signed heights
to the five proven non-negative cases plus the two mixed-sign kills
(`normBranch_even_neg`, `normBranch_odd_neg`), closed under swap and conjugation. -/
theorem ii_norm_complete (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ)
    (hm : word a b + word c d = ((Real.sqrt 3 : ℝ) : ℂ) * (word a b * word c d + 1)) :
    (a, b, c, d) ∈ iiNormTable := by
  have h : NormBranch a b c d := hm
  rcases (by omega : 0 ≤ b ∨ b < 0) with hb | hb <;>
    rcases (by omega : 0 ≤ d ∨ d < 0) with hd | hd
  · -- both heights non-negative: the classification, verbatim
    obtain ⟨m, rfl⟩ : ∃ m : ℕ, b = (m : ℤ) := ⟨b.toNat, by omega⟩
    obtain ⟨n, rfl⟩ : ∃ n : ℕ, d = (n : ℤ) := ⟨d.toNat, by omega⟩
    rcases normBranch_nat_complete h with ⟨ha, hm', hc', hn⟩ | ⟨ha, hm', hc', hn⟩ |
      ⟨ha, hm', hc', hn⟩ | ⟨ha, hm', hc', hn⟩ | ⟨ha, hm', hc', hn⟩ | ⟨ha, hm', hc', hn⟩ <;>
        subst ha <;> subst hm' <;> subst hc' <;> subst hn <;> decide
  · -- second height negative: impossible
    obtain ⟨m, rfl⟩ : ∃ m : ℕ, b = (m : ℤ) := ⟨b.toNat, by omega⟩
    obtain ⟨n, hn⟩ : ∃ n : ℕ, d = -(n : ℤ) := ⟨d.natAbs, by omega⟩
    subst hn
    have hn1 : 1 ≤ n := by omega
    have hpar := normBranch_parity_neg h
    rcases Nat.even_or_odd m with hme | hmo
    · obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β := by
        rcases hme with ⟨t, ht⟩
        exact ⟨t, by omega⟩
      obtain ⟨ε, rfl⟩ : ∃ ε, n = 2 * ε := ⟨n / 2, by omega⟩
      exact (normBranch_even_neg (by omega) h).elim
    · obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β + 1 := by
        rcases hmo with ⟨t, ht⟩
        exact ⟨t, by omega⟩
      obtain ⟨ε, rfl⟩ : ∃ ε, n = 2 * ε + 1 := ⟨n / 2, by omega⟩
      exact (normBranch_odd_neg h).elim
  · -- first height negative: the swap of the previous case
    have h' := normBranch_swap h
    obtain ⟨m, rfl⟩ : ∃ m : ℕ, d = (m : ℤ) := ⟨d.toNat, by omega⟩
    obtain ⟨n, hn⟩ : ∃ n : ℕ, b = -(n : ℤ) := ⟨b.natAbs, by omega⟩
    subst hn
    have hn1 : 1 ≤ n := by omega
    have hpar := normBranch_parity_neg h'
    rcases Nat.even_or_odd m with hme | hmo
    · obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β := by
        rcases hme with ⟨t, ht⟩
        exact ⟨t, by omega⟩
      obtain ⟨ε, rfl⟩ : ∃ ε, n = 2 * ε := ⟨n / 2, by omega⟩
      exact (normBranch_even_neg (by omega) h').elim
    · obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β + 1 := by
        rcases hmo with ⟨t, ht⟩
        exact ⟨t, by omega⟩
      obtain ⟨ε, rfl⟩ : ∃ ε, n = 2 * ε + 1 := ⟨n / 2, by omega⟩
      exact (normBranch_odd_neg h').elim
  · -- both heights negative: conjugate into the non-negative classification
    have h' := normBranch_conj h
    obtain ⟨m, hm'⟩ : ∃ m : ℕ, b = -(m : ℤ) := ⟨b.natAbs, by omega⟩
    obtain ⟨n, hn'⟩ : ∃ n : ℕ, d = -(n : ℤ) := ⟨d.natAbs, by omega⟩
    subst hm'
    subst hn'
    rw [neg_neg, neg_neg] at h'
    have hm1 : 1 ≤ m := by omega
    have hfixa : ∀ x y : ZMod 6, -x = y → x = -y := by decide
    rcases normBranch_nat_complete h' with ⟨ha, hmm, hc', hnn⟩ | ⟨ha, hmm, hc', hnn⟩ |
      ⟨ha, hmm, hc', hnn⟩ | ⟨ha, hmm, hc', hnn⟩ | ⟨ha, hmm, hc', hnn⟩ | ⟨ha, hmm, hc', hnn⟩
    · omega
    · omega
    · rw [hfixa a 1 ha, hfixa c 5 hc']
      subst hmm
      subst hnn
      decide
    · rw [hfixa a 5 ha, hfixa c 1 hc']
      subst hmm
      subst hnn
      decide
    · rw [hfixa a 0 ha, hfixa c 3 hc']
      subst hmm
      subst hnn
      decide
    · rw [hfixa a 3 ha, hfixa c 0 hc']
      subst hmm
      subst hnn
      decide

/-- **The ii bound**: away from the boundary rows, a norm-branch partner exists only at
seam height one — read off `ii_norm_complete`, where every table row with `|b| ≥ 2` has
`|d| = 1`. -/
theorem ii_norm_bound (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ)
    (hm : word a b + word c d = ((Real.sqrt 3 : ℝ) : ℂ) * (word a b * word c d + 1))
    (hb : 2 ≤ |b|) : |d| = 1 := by
  have hmem := ii_norm_complete a b c d hm
  simp only [iiNormTable, List.mem_cons, List.not_mem_nil, or_false,
    Prod.mk.injEq] at hmem
  rcases hmem with ⟨-, h1, -, h2⟩ | ⟨-, h1, -, h2⟩ | ⟨-, h1, -, h2⟩ | ⟨-, h1, -, h2⟩ |
      ⟨-, h1, -, h2⟩ | ⟨-, h1, -, h2⟩ | ⟨-, h1, -, h2⟩ | ⟨-, h1, -, h2⟩ |
      ⟨-, h1, -, h2⟩ | ⟨-, h1, -, h2⟩ <;>
    subst h1 <;> subst h2 <;> revert hb <;> decide

/-- The complete solution set of the oi chord equation: four sporadics and twelve
glue-incident chords — sixteen chords EVER, no infinite family (E3/E5: no growth from
window 8 to window 200; the theorem removes the window). -/
def oiTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(2, 2, 5, 1), (2, -2, 5, -1), (4, 2, 1, 1), (4, -2, 1, -1),
   (1, 0, 5, 1), (1, 0, 5, -1), (5, 0, 1, 1), (5, 0, 1, -1),
   (2, 2, 0, 1), (2, -2, 0, -1), (4, 2, 0, 1), (4, -2, 0, -1),
   (3, 2, 2, 1), (3, -2, 2, -1), (3, 2, 4, 1), (3, -2, 4, -1)]

/-! ### The trace-pair machinery

The oi equation is a sum of three conjugate pairs of words plus a constant. Each pair
clears by `√3^{|height|}` into a **trace pair** `T(x,h) = ζ₆^x·π^h + ζ₆^{−x}·π̄^h` — one
object regardless of the height's sign, whose four integer coordinates carry the whole
analysis: modulo three the π-rows pin the hex address onto the real axis, and the
`piCoeff` recurrence kills the surviving telescopes. -/

/-- `T(x,h) = ζ₆^x·π^h + ζ₆^{−x}·π̄^h`. -/
private noncomputable def tracePair (x : ZMod 6) (h : ℕ) : ℂ :=
  zeta6 ^ (x.val : ℤ) * piC ^ h + zeta6 ^ ((-x).val : ℤ) * (1 - piC) ^ h

private theorem tracePair_clear (x : ZMod 6) (h : ℕ) :
    ((Real.sqrt 3 : ℝ) : ℂ) ^ h * (word x (h : ℤ) + word (-x) (-(h : ℤ)))
      = tracePair x h := by
  rw [mul_add, sqrt3_pow_mul_word, sqrt3_pow_mul_word_neg, tracePair]

private theorem tracePair_coords (x : ZMod 6) (h : ℕ) :
    tracePair x h
      = ((hexE x.val : ℂ) * ((piCoeff h).1 : ℂ)
            + (hexE (-x).val : ℂ) * (((piCoeff h).1 : ℂ) + ((piCoeff h).2 : ℂ)))
        + ((hexF x.val : ℂ) * ((piCoeff h).1 : ℂ)
            + (hexF (-x).val : ℂ) * (((piCoeff h).1 : ℂ) + ((piCoeff h).2 : ℂ))) * zeta6
        + (((piCoeff h).2 : ℂ) * ((hexE x.val : ℂ) - (hexE (-x).val : ℂ))) * piC
        + (((piCoeff h).2 : ℂ) * ((hexF x.val : ℂ) - (hexF (-x).val : ℂ)))
          * (zeta6 * piC) := by
  rw [tracePair, piC_pow_coeff, one_sub_piC_pow_coeff, zeta6_zpow_hex x, zeta6_zpow_hex (-x)]
  ring

private theorem inRing_tracePair (x : ZMod 6) (h : ℕ) : InRing (tracePair x h) :=
  (inRing_elt x h).add (inRing_elt_neg (-x) h)

private theorem tracePair_zero (h : ℕ) :
    tracePair 0 h = ((2 * (piCoeff h).1 + (piCoeff h).2 : ℤ) : ℂ) := by
  have h0 : (((0 : ZMod 6)).val : ℤ) = 0 := rfl
  have hn0 : ((-(0 : ZMod 6)).val : ℤ) = 0 := rfl
  rw [tracePair, h0, hn0]
  simp only [zpow_zero, one_mul]
  rw [piC_pow_coeff, one_sub_piC_pow_coeff]
  push_cast
  ring

private theorem tracePair_zero_zero : tracePair 0 0 = 2 := by
  rw [tracePair_zero, show piCoeff 0 = (1, 0) from rfl]
  norm_num

private theorem tracePair_zero_one : tracePair 0 1 = 1 := by
  rw [tracePair_zero, show piCoeff 1 = (0, 1) from rfl]
  norm_num

/-- `ζ₆³ = −1` acts on trace pairs: shifting the address by three flips the sign. -/
private theorem tracePair_add_three (x : ZMod 6) (h : ℕ) :
    tracePair (x + 3) h = -tracePair x h := by
  have hEF : ∀ y : ZMod 6,
      hexE ((y + 3).val) = -hexE y.val ∧ hexF ((y + 3).val) = -hexF y.val := by decide
  have key : ∀ y : ZMod 6, zeta6 ^ (((y + 3) : ZMod 6).val : ℤ) = -zeta6 ^ (y.val : ℤ) := by
    intro y
    obtain ⟨hE, hF⟩ := hEF y
    rw [zeta6_zpow_hex (y + 3), zeta6_zpow_hex y, hE, hF]
    push_cast
    ring
  have hneg : -(x + 3) = (-x) + 3 := by
    rw [neg_add, show (-3 : ZMod 6) = 3 from by decide]
  rw [tracePair, tracePair, key x, hneg, key (-x)]
  ring

private theorem tracePair_three_one : tracePair 3 1 = -1 := by
  have h := tracePair_add_three 0 1
  rw [zero_add] at h
  rw [h, tracePair_zero_one]

/-- The six hex units are distinct modulo three: matching coordinate congruences pin
the address. -/
private theorem hex_mod_inj : ∀ y z : ZMod 6,
    (hexE y.val - hexE z.val) % 3 = 0 → (hexF y.val - hexF z.val) % 3 = 0 → y = z := by
  decide

/-- **The trace pin**: a trace pair equal to a rational integer forces the hex address
onto the real axis (`x ∈ {0, 3}`), and the value is then `±(2·px + py)`. -/
private theorem tracePair_pin {x : ZMod 6} {h : ℕ} {m : ℤ} (h1 : 1 ≤ h)
    (heq : tracePair x h = (m : ℂ)) :
    ((hexE x.val = 1 ∧ hexF x.val = 0) ∨ (hexE x.val = -1 ∧ hexF x.val = 0))
      ∧ hexE x.val * (2 * (piCoeff h).1 + (piCoeff h).2) = m := by
  have hco := tracePair_coords x h
  rw [heq] at hco
  obtain ⟨k₁, k₂, k₃, k₄⟩ := inRing_coords_zero
    (n₁ := hexE x.val * (piCoeff h).1
      + hexE (-x).val * ((piCoeff h).1 + (piCoeff h).2) - m)
    (n₂ := hexF x.val * (piCoeff h).1
      + hexF (-x).val * ((piCoeff h).1 + (piCoeff h).2))
    (n₃ := (piCoeff h).2 * (hexE x.val - hexE (-x).val))
    (n₄ := (piCoeff h).2 * (hexF x.val - hexF (-x).val))
    (by push_cast; linear_combination -hco)
  have hZ1 : (piCoeff h).2 % 3 = 1 := by
    obtain ⟨h', rfl⟩ : ∃ h', h = h' + 1 := ⟨h - 1, by omega⟩
    exact piCoeff_snd_emod h'
  have hZ0 : (piCoeff h).2 ≠ 0 := by omega
  have hE : hexE x.val = hexE (-x).val := by
    rcases mul_eq_zero.mp k₃ with h0 | h0
    · exact absurd h0 hZ0
    · omega
  have hF : hexF x.val = hexF (-x).val := by
    rcases mul_eq_zero.mp k₄ with h0 | h0
    · exact absurd h0 hZ0
    · omega
  have hpin : ∀ y : ZMod 6, hexE y.val = hexE (-y).val → hexF y.val = hexF (-y).val →
      (hexE y.val = 1 ∧ hexF y.val = 0) ∨ (hexE y.val = -1 ∧ hexF y.val = 0) := by decide
  refine ⟨hpin x hE hF, ?_⟩
  rw [← hE] at k₁
  linear_combination k₁

/-- **The telescope kill**: `T(x,h+1) − T(x,h)` is never `3^w` for `w ≥ 2` once `h ≥ 2` —
the `piCoeff` recurrence turns the difference into `±3·(py(h−1) − 2·py(h))`, a number
that is exactly one nonzero step away from divisibility by nine. -/
private theorem tracePair_succ_kill {x : ZMod 6} {h w : ℕ} (hh : 2 ≤ h) (hw : 2 ≤ w)
    (heq : tracePair x (h + 1) - tracePair x h = (3 : ℂ) ^ w) : False := by
  obtain ⟨j, rfl⟩ : ∃ j, h = j + 2 := ⟨h - 2, by omega⟩
  have hc1 := tracePair_coords x (j + 2 + 1)
  have hc2 := tracePair_coords x (j + 2)
  obtain ⟨k₁, k₂, k₃, k₄⟩ := inRing_coords_zero
    (n₁ := (hexE x.val * (piCoeff (j + 2 + 1)).1
        + hexE (-x).val * ((piCoeff (j + 2 + 1)).1 + (piCoeff (j + 2 + 1)).2))
      - (hexE x.val * (piCoeff (j + 2)).1
        + hexE (-x).val * ((piCoeff (j + 2)).1 + (piCoeff (j + 2)).2)) - 3 ^ w)
    (n₂ := (hexF x.val * (piCoeff (j + 2 + 1)).1
        + hexF (-x).val * ((piCoeff (j + 2 + 1)).1 + (piCoeff (j + 2 + 1)).2))
      - (hexF x.val * (piCoeff (j + 2)).1
        + hexF (-x).val * ((piCoeff (j + 2)).1 + (piCoeff (j + 2)).2)))
    (n₃ := (piCoeff (j + 2 + 1)).2 * (hexE x.val - hexE (-x).val)
      - (piCoeff (j + 2)).2 * (hexE x.val - hexE (-x).val))
    (n₄ := (piCoeff (j + 2 + 1)).2 * (hexF x.val - hexF (-x).val)
      - (piCoeff (j + 2)).2 * (hexF x.val - hexF (-x).val))
    (by push_cast; linear_combination heq - hc1 + hc2)
  have hZs : (piCoeff (j + 2 + 1)).2 = (piCoeff (j + 2)).1 + (piCoeff (j + 2)).2 := rfl
  have hPs1 : (piCoeff (j + 2 + 1)).1 = -3 * (piCoeff (j + 2)).2 := rfl
  have hPs : (piCoeff (j + 2)).1 = -3 * (piCoeff (j + 1)).2 := rfl
  have hZ2 : (piCoeff (j + 2)).2 % 3 = 1 := piCoeff_snd_emod (j + 1)
  have hZ1 : (piCoeff (j + 1)).2 % 3 = 1 := piCoeff_snd_emod j
  have hPne : (piCoeff (j + 2)).1 ≠ 0 := by
    rw [hPs]
    intro h0
    omega
  have hE : hexE x.val = hexE (-x).val := by
    have hfac : (piCoeff (j + 2)).1 * (hexE x.val - hexE (-x).val) = 0 := by
      linear_combination k₃ - (hexE x.val - hexE (-x).val) * hZs
    rcases mul_eq_zero.mp hfac with h0 | h0
    · exact absurd h0 hPne
    · omega
  have hF : hexF x.val = hexF (-x).val := by
    have hfac : (piCoeff (j + 2)).1 * (hexF x.val - hexF (-x).val) = 0 := by
      linear_combination k₄ - (hexF x.val - hexF (-x).val) * hZs
    rcases mul_eq_zero.mp hfac with h0 | h0
    · exact absurd h0 hPne
    · omega
  have hpin : ∀ y : ZMod 6, hexE y.val = hexE (-y).val → hexF y.val = hexF (-y).val →
      hexE y.val = 1 ∨ hexE y.val = -1 := by decide
  obtain ⟨v, hv⟩ : ∃ v : ℤ, (3 : ℤ) ^ w = 9 * v :=
    ⟨3 ^ (w - 2), by rw [show (9 : ℤ) = 3 ^ 2 by norm_num, ← pow_add,
      show 2 + (w - 2) = w by omega]⟩
  rw [← hE] at k₁
  rw [hZs, hPs1, hPs, hv] at k₁
  rcases hpin x hE hF with hE1 | hE1 <;> rw [hE1] at k₁ <;> omega

/-- The oi chord equation as a word identity: three conjugate pairs and a constant. -/
private theorem oi_master {a c : ZMod 6} {b d : ℤ}
    (h : normSq (((Real.sqrt 3 : ℝ) : ℂ) * (1 - word a b) - word c d) = 3) :
    (4 : ℂ) - 3 * (word a b + word (-a) (-b))
        - ((Real.sqrt 3 : ℝ) : ℂ) * (word c d + word (-c) (-d))
        + ((Real.sqrt 3 : ℝ) : ℂ) * (word (a - c) (b - d) + word (c - a) (d - b)) = 0 := by
  have hexp := Complex.mul_conj (((Real.sqrt 3 : ℝ) : ℂ) * (1 - word a b) - word c d)
  rw [h] at hexp
  rw [map_sub, map_mul, Complex.conj_ofReal, map_sub, map_one, word_conj, word_conj] at hexp
  push_cast at hexp
  have hu : word a b * word (-a) (-b) = 1 := by
    rw [← word_conj]
    exact word_mul_conj a b
  have hw : word c d * word (-c) (-d) = 1 := by
    rw [← word_conj]
    exact word_mul_conj c d
  have hX : word a b * word (-c) (-d) = word (a - c) (b - d) := by
    rw [← word_conj]
    exact word_mul_conj_word a c b d
  have hY : word c d * word (-a) (-b) = word (c - a) (d - b) := by
    rw [← word_conj]
    exact word_mul_conj_word c a d b
  linear_combination hexp - 3 * hu - hw - ((Real.sqrt 3 : ℝ) : ℂ) * hX
    - ((Real.sqrt 3 : ℝ) : ℂ) * hY
    - (1 - word a b - word (-a) (-b) + word a b * word (-a) (-b)) * sqrt3_cast_sq

/-! ### The clearing per shape, and the parity kills

Multiplying the master identity by `√3^(m+n+k)` — the three absolute heights — gives a
four-term trace-pair equation whose `√3`-exponent parities depend only on the heights'
parities. Three parity classes die on one separation component each; (outer even, inner
odd) is the live class. -/

private theorem oi_clear₁ {a c : ZMod 6} {m n k : ℕ} (hmk : (m : ℤ) - (n : ℤ) = (k : ℤ))
    (hM : (4 : ℂ) - 3 * (word a (m : ℤ) + word (-a) (-(m : ℤ)))
        - ((Real.sqrt 3 : ℝ) : ℂ) * (word c (n : ℤ) + word (-c) (-(n : ℤ)))
        + ((Real.sqrt 3 : ℝ) : ℂ)
          * (word (a - c) ((m : ℤ) - (n : ℤ)) + word (c - a) ((n : ℤ) - (m : ℤ))) = 0) :
    4 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + k)
        - 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (n + k) * tracePair a m
        - ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + k + 1) * tracePair c n
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + 1) * tracePair (a - c) k = 0 := by
  have hdb : (n : ℤ) - (m : ℤ) = -(k : ℤ) := by omega
  rw [hmk, hdb] at hM
  have h1 := tracePair_clear a m
  have h2 := tracePair_clear c n
  have h3 := tracePair_clear (a - c) k
  rw [neg_sub] at h3
  linear_combination ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + k) * hM
    + 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (n + k) * h1
    + ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + k + 1) * h2
    - ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + 1) * h3

private theorem oi_clear₂ {a c : ZMod 6} {m n k : ℕ} (hmk : (n : ℤ) - (m : ℤ) = (k : ℤ))
    (hM : (4 : ℂ) - 3 * (word a (m : ℤ) + word (-a) (-(m : ℤ)))
        - ((Real.sqrt 3 : ℝ) : ℂ) * (word c (n : ℤ) + word (-c) (-(n : ℤ)))
        + ((Real.sqrt 3 : ℝ) : ℂ)
          * (word (a - c) ((m : ℤ) - (n : ℤ)) + word (c - a) ((n : ℤ) - (m : ℤ))) = 0) :
    4 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + k)
        - 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (n + k) * tracePair a m
        - ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + k + 1) * tracePair c n
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + 1) * tracePair (c - a) k = 0 := by
  have hbd : (m : ℤ) - (n : ℤ) = -(k : ℤ) := by omega
  rw [hbd, hmk] at hM
  have h1 := tracePair_clear a m
  have h2 := tracePair_clear c n
  have h3 := tracePair_clear (c - a) k
  rw [neg_sub] at h3
  linear_combination ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + k) * hM
    + 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (n + k) * h1
    + ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + k + 1) * h2
    - ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + 1) * h3

private theorem oi_clear₃ {a c : ZMod 6} {m n k : ℕ} (hmk : (m : ℤ) + (n : ℤ) = (k : ℤ))
    (hM : (4 : ℂ) - 3 * (word a (m : ℤ) + word (-a) (-(m : ℤ)))
        - ((Real.sqrt 3 : ℝ) : ℂ) * (word c (-(n : ℤ)) + word (-c) (-(-(n : ℤ))))
        + ((Real.sqrt 3 : ℝ) : ℂ)
          * (word (a - c) ((m : ℤ) - -(n : ℤ))
            + word (c - a) (-(n : ℤ) - (m : ℤ))) = 0) :
    4 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + k)
        - 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (n + k) * tracePair a m
        - ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + k + 1) * tracePair (-c) n
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + 1) * tracePair (a - c) k = 0 := by
  rw [neg_neg, show (m : ℤ) - -(n : ℤ) = (k : ℤ) by omega,
    show -(n : ℤ) - (m : ℤ) = -(k : ℤ) by omega] at hM
  have h1 := tracePair_clear a m
  have h2 := tracePair_clear (-c) n
  rw [neg_neg] at h2
  have h3 := tracePair_clear (a - c) k
  rw [neg_sub] at h3
  linear_combination ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + k) * hM
    + 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (n + k) * h1
    + ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + k + 1) * h2
    - ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + 1) * h3

private theorem inRing_four_mul (t : ℕ) : InRing ((4 : ℂ) * 3 ^ t) := by
  rw [show ((4 : ℂ) * 3 ^ t) = (((4 * 3 ^ t : ℤ)) : ℂ) by push_cast; ring]
  exact InRing.intCast _

/-- The shared endgame: `±(2·px + py) = M` with `3 ∣ px`, `py ≡ 1` and `3 ∣ M` is
impossible. -/
private theorem trace_val_kill {E P Z M : ℤ} (hE : E = 1 ∨ E = -1) (hP : (3 : ℤ) ∣ P)
    (hZ : Z % 3 = 1) (hM : M % 3 = 0) (hval : E * (2 * P + Z) = M) : False := by
  obtain ⟨p, hp⟩ := hP
  subst hp
  rcases hE with h | h <;> subst h <;> omega

/-- Both heights even: the rational separation component forces `3·T(x,m) = 4·3^{m/2}`,
which the coordinates refuse modulo three (and exactly at `m = 2`). -/
private theorem oi_kill_ee {x y z : ZMod 6} {m n k : ℕ}
    (hm2 : m % 2 = 0) (hn2 : n % 2 = 0) (hk2 : k % 2 = 0)
    (hE : 4 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + k)
        - 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (n + k) * tracePair x m
        - ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + k + 1) * tracePair y n
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + 1) * tracePair z k = 0) : False := by
  obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β := ⟨m / 2, by omega⟩
  obtain ⟨ν, rfl⟩ : ∃ ν, n = 2 * ν := ⟨n / 2, by omega⟩
  obtain ⟨κ, rfl⟩ : ∃ κ, k = 2 * κ := ⟨k / 2, by omega⟩
  rw [show 2 * β + 2 * ν + 2 * κ = 2 * (β + ν + κ) by ring, sqrt3_pow_two_mul,
    show 2 * ν + 2 * κ = 2 * (ν + κ) by ring, sqrt3_pow_two_mul,
    show 2 * β + 2 * κ + 1 = 2 * (β + κ) + 1 by ring, pow_succ, sqrt3_pow_two_mul,
    show 2 * β + 2 * ν + 1 = 2 * (β + ν) + 1 by ring, pow_succ, sqrt3_pow_two_mul] at hE
  obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
    ((inRing_four_mul (β + ν + κ)).add
      (((inRing_three_pow (ν + κ + 1)).mul (inRing_tracePair x (2 * β))).neg))
    ((((inRing_three_pow (β + κ)).mul (inRing_tracePair y (2 * ν))).neg).add
      ((inRing_three_pow (β + ν)).mul (inRing_tracePair z (2 * κ))))
    (show ((4 : ℂ) * 3 ^ (β + ν + κ) + -((3 : ℂ) ^ (ν + κ + 1) * tracePair x (2 * β)))
        + ((Real.sqrt 3 : ℝ) : ℂ) * (-((3 : ℂ) ^ (β + κ) * tracePair y (2 * ν))
          + (3 : ℂ) ^ (β + ν) * tracePair z (2 * κ)) = 0 by linear_combination hE)
  rcases Nat.eq_zero_or_pos β with hβ0 | hβpos
  · subst hβ0
    have h3T : (3 : ℂ) * tracePair x (2 * 0) = 4 := by
      refine mul_left_cancel₀ (pow_ne_zero (ν + κ) (show (3 : ℂ) ≠ 0 by norm_num)) ?_
      linear_combination -hX
    have hco := tracePair_coords x (2 * 0)
    obtain ⟨k₁, -, -, -⟩ := inRing_coords_zero
      (n₁ := 3 * (hexE x.val * (piCoeff (2 * 0)).1
        + hexE (-x).val * ((piCoeff (2 * 0)).1 + (piCoeff (2 * 0)).2)) - 4)
      (n₂ := 3 * (hexF x.val * (piCoeff (2 * 0)).1
        + hexF (-x).val * ((piCoeff (2 * 0)).1 + (piCoeff (2 * 0)).2)))
      (n₃ := 3 * ((piCoeff (2 * 0)).2 * (hexE x.val - hexE (-x).val)))
      (n₄ := 3 * ((piCoeff (2 * 0)).2 * (hexF x.val - hexF (-x).val)))
      (by push_cast; linear_combination h3T - 3 * hco)
    omega
  · obtain ⟨β', rfl⟩ : ∃ β', β = β' + 1 := ⟨β - 1, by omega⟩
    have hT : tracePair x (2 * (β' + 1)) = ((4 * 3 ^ β' : ℤ) : ℂ) := by
      refine mul_left_cancel₀ (pow_ne_zero (ν + κ + 1) (show (3 : ℂ) ≠ 0 by norm_num)) ?_
      push_cast
      linear_combination -hX
    obtain ⟨hpin, hval⟩ := tracePair_pin (by omega) hT
    rcases Nat.eq_zero_or_pos β' with hβ'0 | hβ'pos
    · subst hβ'0
      rw [show (2 * (0 + 1) : ℕ) = 2 by norm_num, show piCoeff 2 = (-3, 1) from rfl] at hval
      simp only [pow_zero, mul_one] at hval
      rcases hpin with ⟨hE1, -⟩ | ⟨hE1, -⟩ <;> rw [hE1] at hval <;> omega
    · have hP3 : (3 : ℤ) ∣ (piCoeff (2 * (β' + 1))).1 := by
        rw [show 2 * (β' + 1) = 2 * β' + 1 + 1 by ring]
        exact three_dvd_piCoeff_fst _
      have hZ3 : (piCoeff (2 * (β' + 1))).2 % 3 = 1 := by
        rw [show 2 * (β' + 1) = 2 * β' + 1 + 1 by ring]
        exact piCoeff_snd_emod _
      have hM3 : (4 * 3 ^ β' : ℤ) % 3 = 0 := by
        obtain ⟨u, hu⟩ : ∃ u : ℤ, (3 : ℤ) ^ β' = 3 * u := ⟨3 ^ (β' - 1), by
          conv_lhs => rw [show β' = β' - 1 + 1 by omega]
          rw [pow_succ]
          ring⟩
        omega
      exact trace_val_kill (hpin.imp And.left And.left) hP3 hZ3 hM3 hval

/-- Both heights odd: the rational separation component forces `T(y,n) = 4·3^{(n−1)/2}`,
which the coordinates refuse. -/
private theorem oi_kill_oo {x y z : ZMod 6} {m n k : ℕ}
    (hm2 : m % 2 = 1) (hn2 : n % 2 = 1) (hk2 : k % 2 = 0)
    (hE : 4 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + k)
        - 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (n + k) * tracePair x m
        - ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + k + 1) * tracePair y n
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + 1) * tracePair z k = 0) : False := by
  obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β + 1 := ⟨m / 2, by omega⟩
  obtain ⟨ν, rfl⟩ : ∃ ν, n = 2 * ν + 1 := ⟨n / 2, by omega⟩
  obtain ⟨κ, rfl⟩ : ∃ κ, k = 2 * κ := ⟨k / 2, by omega⟩
  rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + 1 + (2 * ν + 1) + 2 * κ)
      = 3 ^ (β + ν + κ + 1) by
      rw [show 2 * β + 1 + (2 * ν + 1) + 2 * κ = 2 * (β + ν + κ + 1) by ring,
        sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * ν + 1 + 2 * κ)
      = 3 ^ (ν + κ) * ((Real.sqrt 3 : ℝ) : ℂ) by
      rw [show 2 * ν + 1 + 2 * κ = 2 * (ν + κ) + 1 by ring, pow_succ, sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + 1 + 2 * κ + 1) = 3 ^ (β + κ + 1) by
      rw [show 2 * β + 1 + 2 * κ + 1 = 2 * (β + κ + 1) by ring, sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + 1 + (2 * ν + 1) + 1)
      = 3 ^ (β + ν + 1) * ((Real.sqrt 3 : ℝ) : ℂ) by
      rw [show 2 * β + 1 + (2 * ν + 1) + 1 = 2 * (β + ν + 1) + 1 by ring, pow_succ,
        sqrt3_pow_two_mul]] at hE
  obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
    ((inRing_four_mul (β + ν + κ + 1)).add
      (((inRing_three_pow (β + κ + 1)).mul (inRing_tracePair y (2 * ν + 1))).neg))
    ((((inRing_three_pow (ν + κ + 1)).mul (inRing_tracePair x (2 * β + 1))).neg).add
      ((inRing_three_pow (β + ν + 1)).mul (inRing_tracePair z (2 * κ))))
    (show ((4 : ℂ) * 3 ^ (β + ν + κ + 1)
          + -((3 : ℂ) ^ (β + κ + 1) * tracePair y (2 * ν + 1)))
        + ((Real.sqrt 3 : ℝ) : ℂ) * (-((3 : ℂ) ^ (ν + κ + 1) * tracePair x (2 * β + 1))
          + (3 : ℂ) ^ (β + ν + 1) * tracePair z (2 * κ)) = 0 by linear_combination hE)
  have hT : tracePair y (2 * ν + 1) = ((4 * 3 ^ ν : ℤ) : ℂ) := by
    refine mul_left_cancel₀ (pow_ne_zero (β + κ + 1) (show (3 : ℂ) ≠ 0 by norm_num)) ?_
    push_cast
    linear_combination -hX
  obtain ⟨hpin, hval⟩ := tracePair_pin (by omega) hT
  rcases Nat.eq_zero_or_pos ν with hν0 | hνpos
  · subst hν0
    rw [show (2 * 0 + 1 : ℕ) = 1 by norm_num, show piCoeff 1 = (0, 1) from rfl] at hval
    simp only [pow_zero, mul_one] at hval
    rcases hpin with ⟨hE1, -⟩ | ⟨hE1, -⟩ <;> rw [hE1] at hval <;> omega
  · have hP3 : (3 : ℤ) ∣ (piCoeff (2 * ν + 1)).1 := three_dvd_piCoeff_fst _
    have hZ3 : (piCoeff (2 * ν + 1)).2 % 3 = 1 := piCoeff_snd_emod _
    have hM3 : (4 * 3 ^ ν : ℤ) % 3 = 0 := by
      obtain ⟨u, hu⟩ : ∃ u : ℤ, (3 : ℤ) ^ ν = 3 * u := ⟨3 ^ (ν - 1), by
        conv_lhs => rw [show ν = ν - 1 + 1 by omega]
        rw [pow_succ]
        ring⟩
      omega
    exact trace_val_kill (hpin.imp And.left And.left) hP3 hZ3 hM3 hval

/-- Outer odd, inner even: the rational separation component forces
`T(z,k) = −4·3^{(k−1)/2}`, which the coordinates refuse. -/
private theorem oi_kill_oe {x y z : ZMod 6} {m n k : ℕ}
    (hm2 : m % 2 = 1) (hn2 : n % 2 = 0) (hk2 : k % 2 = 1)
    (hE : 4 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + k)
        - 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (n + k) * tracePair x m
        - ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + k + 1) * tracePair y n
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (m + n + 1) * tracePair z k = 0) : False := by
  obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β + 1 := ⟨m / 2, by omega⟩
  obtain ⟨ν, rfl⟩ : ∃ ν, n = 2 * ν := ⟨n / 2, by omega⟩
  obtain ⟨κ, rfl⟩ : ∃ κ, k = 2 * κ + 1 := ⟨k / 2, by omega⟩
  rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + 1 + 2 * ν + (2 * κ + 1))
      = 3 ^ (β + ν + κ + 1) by
      rw [show 2 * β + 1 + 2 * ν + (2 * κ + 1) = 2 * (β + ν + κ + 1) by ring,
        sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * ν + (2 * κ + 1))
      = 3 ^ (ν + κ) * ((Real.sqrt 3 : ℝ) : ℂ) by
      rw [show 2 * ν + (2 * κ + 1) = 2 * (ν + κ) + 1 by ring, pow_succ, sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + 1 + (2 * κ + 1) + 1)
      = 3 ^ (β + κ + 1) * ((Real.sqrt 3 : ℝ) : ℂ) by
      rw [show 2 * β + 1 + (2 * κ + 1) + 1 = 2 * (β + κ + 1) + 1 by ring, pow_succ,
        sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + 1 + 2 * ν + 1) = 3 ^ (β + ν + 1) by
      rw [show 2 * β + 1 + 2 * ν + 1 = 2 * (β + ν + 1) by ring, sqrt3_pow_two_mul]] at hE
  obtain ⟨hX, -⟩ := eq_zero_of_add_sqrt3_mul
    ((inRing_four_mul (β + ν + κ + 1)).add
      ((inRing_three_pow (β + ν + 1)).mul (inRing_tracePair z (2 * κ + 1))))
    ((((inRing_three_pow (ν + κ + 1)).mul (inRing_tracePair x (2 * β + 1))).neg).add
      (((inRing_three_pow (β + κ + 1)).mul (inRing_tracePair y (2 * ν))).neg))
    (show ((4 : ℂ) * 3 ^ (β + ν + κ + 1)
          + (3 : ℂ) ^ (β + ν + 1) * tracePair z (2 * κ + 1))
        + ((Real.sqrt 3 : ℝ) : ℂ) * (-((3 : ℂ) ^ (ν + κ + 1) * tracePair x (2 * β + 1))
          + -((3 : ℂ) ^ (β + κ + 1) * tracePair y (2 * ν))) = 0 by linear_combination hE)
  have hT : tracePair z (2 * κ + 1) = ((-(4 * 3 ^ κ) : ℤ) : ℂ) := by
    refine mul_left_cancel₀ (pow_ne_zero (β + ν + 1) (show (3 : ℂ) ≠ 0 by norm_num)) ?_
    push_cast
    linear_combination hX
  obtain ⟨hpin, hval⟩ := tracePair_pin (by omega) hT
  rcases Nat.eq_zero_or_pos κ with hκ0 | hκpos
  · subst hκ0
    rw [show (2 * 0 + 1 : ℕ) = 1 by norm_num, show piCoeff 1 = (0, 1) from rfl] at hval
    simp only [pow_zero, mul_one] at hval
    rcases hpin with ⟨hE1, -⟩ | ⟨hE1, -⟩ <;> rw [hE1] at hval <;> omega
  · have hP3 : (3 : ℤ) ∣ (piCoeff (2 * κ + 1)).1 := three_dvd_piCoeff_fst _
    have hZ3 : (piCoeff (2 * κ + 1)).2 % 3 = 1 := piCoeff_snd_emod _
    have hM3 : (-(4 * 3 ^ κ) : ℤ) % 3 = 0 := by
      obtain ⟨u, hu⟩ : ∃ u : ℤ, (3 : ℤ) ^ κ = 3 * u := ⟨3 ^ (κ - 1), by
        conv_lhs => rw [show κ = κ - 1 + 1 by omega]
        rw [pow_succ]
        ring⟩
      omega
    exact trace_val_kill (hpin.imp And.left And.left) hP3 hZ3 hM3 hval

/-! ### The live parity, per shape

In the class (outer even, inner odd) every `√3`-exponent is even, so no separation is
available: the whole equation lands in the ring, and the analysis runs on its four
coordinate rows. Modulo three the rows pin the addresses; the `piCoeff` recurrence kills
the surviving telescopes; and the boundary points decide over the thirty-six hex pairs. -/

/-- Matching opposite signatures modulo three pin the second address to the first plus
three. -/
private theorem hex_pin_opp : ∀ u v : ZMod 6,
    (3 : ℤ) ∣ (hexE (-u).val + hexE (-v).val) →
    (3 : ℤ) ∣ (hexF (-u).val + hexF (-v).val) →
    (3 : ℤ) ∣ ((hexE u.val - hexE (-u).val) + (hexE v.val - hexE (-v).val)) →
    (3 : ℤ) ∣ ((hexF u.val - hexF (-u).val) + (hexF v.val - hexF (-v).val)) →
    v = u + 3 := by decide

private theorem zmod_sub_add_three : ∀ t : ZMod 6, t - (t + 3) = 3 := by decide

/-- Shape `b > d > 0` of the live parity: everything above the boundary dies, and at the
boundary `(b, d) = (2, 1)` the thirty-six hex pairs decide to exactly six. -/
private theorem oi_shape₁ {x y z : ZMod 6} {δ γ : ℕ} (hz : z = x - y)
    (hE : 4 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * (δ + γ + 1) + (2 * δ + 1) + (2 * γ + 1))
        - 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * δ + 1 + (2 * γ + 1))
          * tracePair x (2 * (δ + γ + 1))
        - ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * (δ + γ + 1) + (2 * γ + 1) + 1)
          * tracePair y (2 * δ + 1)
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * (δ + γ + 1) + (2 * δ + 1) + 1)
          * tracePair z (2 * γ + 1) = 0) :
    δ = 0 ∧ γ = 0 ∧ ((x = 2 ∧ y = 5) ∨ (x = 4 ∧ y = 1) ∨ (x = 2 ∧ y = 0) ∨
      (x = 4 ∧ y = 0) ∨ (x = 3 ∧ y = 2) ∨ (x = 3 ∧ y = 4)) := by
  subst hz
  rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * (δ + γ + 1) + (2 * δ + 1) + (2 * γ + 1))
      = 3 ^ (2 * δ + 2 * γ + 2) by
      rw [show 2 * (δ + γ + 1) + (2 * δ + 1) + (2 * γ + 1) = 2 * (2 * δ + 2 * γ + 2)
        by ring, sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * δ + 1 + (2 * γ + 1)) = 3 ^ (δ + γ + 1) by
      rw [show 2 * δ + 1 + (2 * γ + 1) = 2 * (δ + γ + 1) by ring, sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * (δ + γ + 1) + (2 * γ + 1) + 1)
      = 3 ^ (δ + 2 * γ + 2) by
      rw [show 2 * (δ + γ + 1) + (2 * γ + 1) + 1 = 2 * (δ + 2 * γ + 2) by ring,
        sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * (δ + γ + 1) + (2 * δ + 1) + 1)
      = 3 ^ (2 * δ + γ + 2) by
      rw [show 2 * (δ + γ + 1) + (2 * δ + 1) + 1 = 2 * (2 * δ + γ + 2) by ring,
        sqrt3_pow_two_mul]] at hE
  have hD : 4 * (3 : ℂ) ^ (δ + γ) - tracePair x (2 * (δ + γ + 1))
      - (3 : ℂ) ^ γ * tracePair y (2 * δ + 1)
      + (3 : ℂ) ^ δ * tracePair (x - y) (2 * γ + 1) = 0 := by
    refine mul_left_cancel₀ (pow_ne_zero (δ + γ + 2) (show (3 : ℂ) ≠ 0 by norm_num)) ?_
    rw [mul_zero]
    linear_combination hE
  have hcx := tracePair_coords x (2 * (δ + γ + 1))
  have hcy := tracePair_coords y (2 * δ + 1)
  have hcz := tracePair_coords (x - y) (2 * γ + 1)
  obtain ⟨k₁, k₂, k₃, k₄⟩ := inRing_coords_zero
    (n₁ := 4 * 3 ^ (δ + γ)
      - (hexE x.val * (piCoeff (2 * (δ + γ + 1))).1
        + hexE (-x).val * ((piCoeff (2 * (δ + γ + 1))).1 + (piCoeff (2 * (δ + γ + 1))).2))
      - 3 ^ γ * (hexE y.val * (piCoeff (2 * δ + 1)).1
        + hexE (-y).val * ((piCoeff (2 * δ + 1)).1 + (piCoeff (2 * δ + 1)).2))
      + 3 ^ δ * (hexE (x - y).val * (piCoeff (2 * γ + 1)).1
        + hexE (-(x - y)).val * ((piCoeff (2 * γ + 1)).1 + (piCoeff (2 * γ + 1)).2)))
    (n₂ := -(hexF x.val * (piCoeff (2 * (δ + γ + 1))).1
        + hexF (-x).val * ((piCoeff (2 * (δ + γ + 1))).1 + (piCoeff (2 * (δ + γ + 1))).2))
      - 3 ^ γ * (hexF y.val * (piCoeff (2 * δ + 1)).1
        + hexF (-y).val * ((piCoeff (2 * δ + 1)).1 + (piCoeff (2 * δ + 1)).2))
      + 3 ^ δ * (hexF (x - y).val * (piCoeff (2 * γ + 1)).1
        + hexF (-(x - y)).val * ((piCoeff (2 * γ + 1)).1 + (piCoeff (2 * γ + 1)).2)))
    (n₃ := -((piCoeff (2 * (δ + γ + 1))).2 * (hexE x.val - hexE (-x).val))
      - 3 ^ γ * ((piCoeff (2 * δ + 1)).2 * (hexE y.val - hexE (-y).val))
      + 3 ^ δ * ((piCoeff (2 * γ + 1)).2 * (hexE (x - y).val - hexE (-(x - y)).val)))
    (n₄ := -((piCoeff (2 * (δ + γ + 1))).2 * (hexF x.val - hexF (-x).val))
      - 3 ^ γ * ((piCoeff (2 * δ + 1)).2 * (hexF y.val - hexF (-y).val))
      + 3 ^ δ * ((piCoeff (2 * γ + 1)).2 * (hexF (x - y).val - hexF (-(x - y)).val)))
    (by push_cast
        linear_combination hD + hcx + (3 : ℂ) ^ γ * hcy - (3 : ℂ) ^ δ * hcz)
  obtain ⟨px, hpx⟩ : ∃ p, (piCoeff (2 * (δ + γ + 1))).1 = 3 * p := by
    have h := three_dvd_piCoeff_fst (2 * (δ + γ) + 1)
    rw [show 2 * (δ + γ) + 1 + 1 = 2 * (δ + γ + 1) by ring] at h
    exact h
  obtain ⟨wx, hwx⟩ : ∃ w, (piCoeff (2 * (δ + γ + 1))).2 = 3 * w + 1 := by
    have h := piCoeff_snd_emod (2 * (δ + γ) + 1)
    rw [show 2 * (δ + γ) + 1 + 1 = 2 * (δ + γ + 1) by ring] at h
    exact ⟨(piCoeff (2 * (δ + γ + 1))).2 / 3, by omega⟩
  obtain ⟨py, hpy⟩ := three_dvd_piCoeff_fst (2 * δ)
  obtain ⟨wy, hwy⟩ : ∃ w, (piCoeff (2 * δ + 1)).2 = 3 * w + 1 :=
    ⟨(piCoeff (2 * δ + 1)).2 / 3, by have := piCoeff_snd_emod (2 * δ); omega⟩
  obtain ⟨pz, hpz⟩ := three_dvd_piCoeff_fst (2 * γ)
  obtain ⟨wz, hwz⟩ : ∃ w, (piCoeff (2 * γ + 1)).2 = 3 * w + 1 :=
    ⟨(piCoeff (2 * γ + 1)).2 / 3, by have := piCoeff_snd_emod (2 * γ); omega⟩
  rw [hpx, hwx, hpy, hwy, hpz, hwz] at k₁ k₂
  rw [hwx, hwy, hwz] at k₃ k₄
  rcases Nat.eq_zero_or_pos δ with hδ0 | hδpos <;>
    rcases Nat.eq_zero_or_pos γ with hγ0 | hγpos
  · -- the boundary (b, d) = (2, 1): the finite check
    subst hδ0
    subst hγ0
    refine ⟨rfl, rfl, ?_⟩
    have hex1 : (piCoeff (2 * (0 + 0 + 1))).1 = -3 := rfl
    have hex2 : (piCoeff (2 * (0 + 0 + 1))).2 = 1 := rfl
    have hex3 : (piCoeff (2 * 0 + 1)).1 = 0 := rfl
    have hex4 : (piCoeff (2 * 0 + 1)).2 = 1 := rfl
    have hpx' : px = -1 := by omega
    have hwx' : wx = 0 := by omega
    have hpy' : py = 0 := by omega
    have hwy' : wy = 0 := by omega
    have hpz' : pz = 0 := by omega
    have hwz' : wz = 0 := by omega
    subst hpx'
    subst hwx'
    subst hpy'
    subst hwy'
    subst hpz'
    subst hwz'
    have e₁ : 4 + 3 * hexE x.val + 2 * hexE (-x).val - hexE (-y).val
        + hexE (-(x - y)).val = 0 := by linear_combination k₁
    have e₂ : 3 * hexF x.val + 2 * hexF (-x).val - hexF (-y).val
        + hexF (-(x - y)).val = 0 := by linear_combination k₂
    have e₃ : -(hexE x.val - hexE (-x).val) - (hexE y.val - hexE (-y).val)
        + (hexE (x - y).val - hexE (-(x - y)).val) = 0 := by linear_combination k₃
    have e₄ : -(hexF x.val - hexF (-x).val) - (hexF y.val - hexF (-y).val)
        + (hexF (x - y).val - hexF (-(x - y)).val) = 0 := by linear_combination k₄
    have hfin : ∀ u v : ZMod 6,
        4 + 3 * hexE u.val + 2 * hexE (-u).val - hexE (-v).val
          + hexE (-(u - v)).val = 0 →
        3 * hexF u.val + 2 * hexF (-u).val - hexF (-v).val + hexF (-(u - v)).val = 0 →
        -(hexE u.val - hexE (-u).val) - (hexE v.val - hexE (-v).val)
          + (hexE (u - v).val - hexE (-(u - v)).val) = 0 →
        -(hexF u.val - hexF (-u).val) - (hexF v.val - hexF (-v).val)
          + (hexF (u - v).val - hexF (-(u - v)).val) = 0 →
        (u = 2 ∧ v = 5) ∨ (u = 4 ∧ v = 1) ∨ (u = 2 ∧ v = 0) ∨ (u = 4 ∧ v = 0) ∨
          (u = 3 ∧ v = 2) ∨ (u = 3 ∧ v = 4) := by
      set_option synthInstance.maxSize 1024 in decide
    exact hfin x y e₁ e₂ e₃ e₄
  · -- δ = 0, γ ≥ 1: the pin `y = 0` and the telescope
    exfalso
    subst hδ0
    obtain ⟨γ', rfl⟩ : ∃ γ', γ = γ' + 1 := ⟨γ - 1, by omega⟩
    have d₁ : (3 : ℤ) ∣ (hexE (-(x - y)).val - hexE (-x).val) :=
      ⟨(hexE x.val * px + hexE (-x).val * (px + wx))
        - (hexE (x - y).val * pz + hexE (-(x - y)).val * (pz + wz))
        + 3 ^ γ' * (hexE y.val * (3 * py) + hexE (-y).val * (3 * py + (3 * wy + 1)))
        - 4 * 3 ^ γ', by linear_combination k₁⟩
    have d₂ : (3 : ℤ) ∣ (hexF (-(x - y)).val - hexF (-x).val) :=
      ⟨(hexF x.val * px + hexF (-x).val * (px + wx))
        - (hexF (x - y).val * pz + hexF (-(x - y)).val * (pz + wz))
        + 3 ^ γ' * (hexF y.val * (3 * py) + hexF (-y).val * (3 * py + (3 * wy + 1))),
        by linear_combination k₂⟩
    have hpin : -(x - y) = -x := hex_mod_inj (-(x - y)) (-x) (by omega) (by omega)
    have hy0 : y = 0 := by
      have hxy : x - y = x := neg_inj.mp hpin
      exact sub_eq_self.mp hxy
    subst hy0
    rw [show (2 * 0 + 1 : ℕ) = 1 by norm_num, sub_zero, tracePair_zero_one,
      show 2 * (0 + (γ' + 1) + 1) = 2 * (γ' + 1) + 1 + 1 by ring] at hD
    have heq : tracePair x (2 * (γ' + 1) + 1 + 1) - tracePair x (2 * (γ' + 1) + 1)
        = (3 : ℂ) ^ (γ' + 2) := by linear_combination -hD
    exact tracePair_succ_kill (by omega) (by omega) heq
  · -- δ ≥ 1, γ = 0: the pin `y = x + 3` and the telescope
    exfalso
    subst hγ0
    obtain ⟨δ', rfl⟩ : ∃ δ', δ = δ' + 1 := ⟨δ - 1, by omega⟩
    have d₁ : (3 : ℤ) ∣ (hexE (-x).val + hexE (-y).val) :=
      ⟨4 * 3 ^ δ' - (hexE x.val * px + hexE (-x).val * (px + wx))
        - (hexE y.val * py + hexE (-y).val * (py + wy))
        + 3 ^ δ' * (hexE (x - y).val * (3 * pz)
          + hexE (-(x - y)).val * (3 * pz + (3 * wz + 1))), by linear_combination -k₁⟩
    have d₂ : (3 : ℤ) ∣ (hexF (-x).val + hexF (-y).val) :=
      ⟨-(hexF x.val * px + hexF (-x).val * (px + wx))
        - (hexF y.val * py + hexF (-y).val * (py + wy))
        + 3 ^ δ' * (hexF (x - y).val * (3 * pz)
          + hexF (-(x - y)).val * (3 * pz + (3 * wz + 1))), by linear_combination -k₂⟩
    have d₃ : (3 : ℤ) ∣ ((hexE x.val - hexE (-x).val) + (hexE y.val - hexE (-y).val)) :=
      ⟨-(wx * (hexE x.val - hexE (-x).val)) - wy * (hexE y.val - hexE (-y).val)
        + 3 ^ δ' * ((3 * wz + 1) * (hexE (x - y).val - hexE (-(x - y)).val)),
        by linear_combination -k₃⟩
    have d₄ : (3 : ℤ) ∣ ((hexF x.val - hexF (-x).val) + (hexF y.val - hexF (-y).val)) :=
      ⟨-(wx * (hexF x.val - hexF (-x).val)) - wy * (hexF y.val - hexF (-y).val)
        + 3 ^ δ' * ((3 * wz + 1) * (hexF (x - y).val - hexF (-(x - y)).val)),
        by linear_combination -k₄⟩
    have hy3 : y = x + 3 := hex_pin_opp x y d₁ d₂ d₃ d₄
    subst hy3
    rw [zmod_sub_add_three x, show (2 * 0 + 1 : ℕ) = 1 by norm_num, tracePair_three_one,
      tracePair_add_three x (2 * (δ' + 1) + 1),
      show 2 * (δ' + 1 + 0 + 1) = 2 * (δ' + 1) + 1 + 1 by ring] at hD
    have heq : tracePair x (2 * (δ' + 1) + 1 + 1) - tracePair x (2 * (δ' + 1) + 1)
        = (3 : ℂ) ^ (δ' + 2) := by linear_combination -hD
    exact tracePair_succ_kill (by omega) (by omega) heq
  · -- δ ≥ 1, γ ≥ 1: dead on the outer pair's rows
    exfalso
    obtain ⟨δ', rfl⟩ : ∃ δ', δ = δ' + 1 := ⟨δ - 1, by omega⟩
    obtain ⟨γ', rfl⟩ : ∃ γ', γ = γ' + 1 := ⟨γ - 1, by omega⟩
    have d₁ : (3 : ℤ) ∣ hexE (-x).val :=
      ⟨4 * 3 ^ (δ' + γ' + 1) - (hexE x.val * px + hexE (-x).val * (px + wx))
        - 3 ^ γ' * (hexE y.val * (3 * py) + hexE (-y).val * (3 * py + (3 * wy + 1)))
        + 3 ^ δ' * (hexE (x - y).val * (3 * pz)
          + hexE (-(x - y)).val * (3 * pz + (3 * wz + 1))), by linear_combination -k₁⟩
    have d₂ : (3 : ℤ) ∣ hexF (-x).val :=
      ⟨-(hexF x.val * px + hexF (-x).val * (px + wx))
        - 3 ^ γ' * (hexF y.val * (3 * py) + hexF (-y).val * (3 * py + (3 * wy + 1)))
        + 3 ^ δ' * (hexF (x - y).val * (3 * pz)
          + hexF (-(x - y)).val * (3 * pz + (3 * wz + 1))), by linear_combination -k₂⟩
    exact hexE_hexF_not_both_dvd (-x).val (ZMod.val_lt _) ⟨d₁, d₂⟩

/-- Shape `d > b ≥ 0` of the live parity: only the boundary `(b, d) = (0, 1)` survives,
with two hex pairs. -/
private theorem oi_shape₂ {x y z : ZMod 6} {β γ : ℕ} (hz : z = y - x)
    (hE : 4 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * (β + γ) + 1) + (2 * γ + 1))
        - 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * (β + γ) + 1 + (2 * γ + 1))
          * tracePair x (2 * β)
        - ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * γ + 1) + 1)
          * tracePair y (2 * (β + γ) + 1)
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * (β + γ) + 1) + 1)
          * tracePair z (2 * γ + 1) = 0) :
    β = 0 ∧ γ = 0 ∧ ((x = 1 ∧ y = 5) ∨ (x = 5 ∧ y = 1)) := by
  subst hz
  rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * (β + γ) + 1) + (2 * γ + 1))
      = 3 ^ (2 * β + 2 * γ + 1) by
      rw [show 2 * β + (2 * (β + γ) + 1) + (2 * γ + 1) = 2 * (2 * β + 2 * γ + 1) by ring,
        sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * (β + γ) + 1 + (2 * γ + 1)) = 3 ^ (β + 2 * γ + 1) by
      rw [show 2 * (β + γ) + 1 + (2 * γ + 1) = 2 * (β + 2 * γ + 1) by ring,
        sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * γ + 1) + 1) = 3 ^ (β + γ + 1) by
      rw [show 2 * β + (2 * γ + 1) + 1 = 2 * (β + γ + 1) by ring, sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * (β + γ) + 1) + 1) = 3 ^ (2 * β + γ + 1) by
      rw [show 2 * β + (2 * (β + γ) + 1) + 1 = 2 * (2 * β + γ + 1) by ring,
        sqrt3_pow_two_mul]] at hE
  have hD : 4 * (3 : ℂ) ^ (β + γ) - (3 : ℂ) ^ (γ + 1) * tracePair x (2 * β)
      - tracePair y (2 * (β + γ) + 1)
      + (3 : ℂ) ^ β * tracePair (y - x) (2 * γ + 1) = 0 := by
    refine mul_left_cancel₀ (pow_ne_zero (β + γ + 1) (show (3 : ℂ) ≠ 0 by norm_num)) ?_
    rw [mul_zero]
    linear_combination hE
  have hcx := tracePair_coords x (2 * β)
  have hcy := tracePair_coords y (2 * (β + γ) + 1)
  have hcz := tracePair_coords (y - x) (2 * γ + 1)
  obtain ⟨k₁, k₂, k₃, k₄⟩ := inRing_coords_zero
    (n₁ := 4 * 3 ^ (β + γ)
      - 3 ^ (γ + 1) * (hexE x.val * (piCoeff (2 * β)).1
        + hexE (-x).val * ((piCoeff (2 * β)).1 + (piCoeff (2 * β)).2))
      - (hexE y.val * (piCoeff (2 * (β + γ) + 1)).1
        + hexE (-y).val * ((piCoeff (2 * (β + γ) + 1)).1 + (piCoeff (2 * (β + γ) + 1)).2))
      + 3 ^ β * (hexE (y - x).val * (piCoeff (2 * γ + 1)).1
        + hexE (-(y - x)).val * ((piCoeff (2 * γ + 1)).1 + (piCoeff (2 * γ + 1)).2)))
    (n₂ := -(3 ^ (γ + 1) * (hexF x.val * (piCoeff (2 * β)).1
        + hexF (-x).val * ((piCoeff (2 * β)).1 + (piCoeff (2 * β)).2)))
      - (hexF y.val * (piCoeff (2 * (β + γ) + 1)).1
        + hexF (-y).val * ((piCoeff (2 * (β + γ) + 1)).1 + (piCoeff (2 * (β + γ) + 1)).2))
      + 3 ^ β * (hexF (y - x).val * (piCoeff (2 * γ + 1)).1
        + hexF (-(y - x)).val * ((piCoeff (2 * γ + 1)).1 + (piCoeff (2 * γ + 1)).2)))
    (n₃ := -(3 ^ (γ + 1) * ((piCoeff (2 * β)).2 * (hexE x.val - hexE (-x).val)))
      - (piCoeff (2 * (β + γ) + 1)).2 * (hexE y.val - hexE (-y).val)
      + 3 ^ β * ((piCoeff (2 * γ + 1)).2 * (hexE (y - x).val - hexE (-(y - x)).val)))
    (n₄ := -(3 ^ (γ + 1) * ((piCoeff (2 * β)).2 * (hexF x.val - hexF (-x).val)))
      - (piCoeff (2 * (β + γ) + 1)).2 * (hexF y.val - hexF (-y).val)
      + 3 ^ β * ((piCoeff (2 * γ + 1)).2 * (hexF (y - x).val - hexF (-(y - x)).val)))
    (by push_cast
        linear_combination hD + (3 : ℂ) ^ (γ + 1) * hcx + hcy - (3 : ℂ) ^ β * hcz)
  obtain ⟨py, hpy⟩ := three_dvd_piCoeff_fst (2 * (β + γ))
  obtain ⟨wy, hwy⟩ : ∃ w, (piCoeff (2 * (β + γ) + 1)).2 = 3 * w + 1 :=
    ⟨(piCoeff (2 * (β + γ) + 1)).2 / 3, by have := piCoeff_snd_emod (2 * (β + γ)); omega⟩
  obtain ⟨pz, hpz⟩ := three_dvd_piCoeff_fst (2 * γ)
  obtain ⟨wz, hwz⟩ : ∃ w, (piCoeff (2 * γ + 1)).2 = 3 * w + 1 :=
    ⟨(piCoeff (2 * γ + 1)).2 / 3, by have := piCoeff_snd_emod (2 * γ); omega⟩
  rw [hpy, hwy, hpz, hwz] at k₁ k₂
  rw [hwy, hwz] at k₃ k₄
  rcases Nat.eq_zero_or_pos β with hβ0 | hβpos
  · subst hβ0
    rcases Nat.eq_zero_or_pos γ with hγ0 | hγpos
    · -- the boundary (b, d) = (0, 1)
      subst hγ0
      refine ⟨rfl, rfl, ?_⟩
      have hex1 : (piCoeff (2 * 0)).1 = 1 := rfl
      have hex2 : (piCoeff (2 * 0)).2 = 0 := rfl
      have hex3 : (piCoeff (2 * (0 + 0) + 1)).1 = 0 := rfl
      have hex4 : (piCoeff (2 * (0 + 0) + 1)).2 = 1 := rfl
      have hex5 : (piCoeff (2 * 0 + 1)).1 = 0 := rfl
      have hex6 : (piCoeff (2 * 0 + 1)).2 = 1 := rfl
      have hpy' : py = 0 := by omega
      have hwy' : wy = 0 := by omega
      have hpz' : pz = 0 := by omega
      have hwz' : wz = 0 := by omega
      subst hpy'
      subst hwy'
      subst hpz'
      subst hwz'
      rw [hex1, hex2] at k₁ k₂
      rw [hex2] at k₃ k₄
      have e₁ : 4 - 3 * (hexE x.val + hexE (-x).val) - hexE (-y).val
          + hexE (-(y - x)).val = 0 := by linear_combination k₁
      have e₂ : -(3 * (hexF x.val + hexF (-x).val)) - hexF (-y).val
          + hexF (-(y - x)).val = 0 := by linear_combination k₂
      have e₃ : -(hexE y.val - hexE (-y).val)
          + (hexE (y - x).val - hexE (-(y - x)).val) = 0 := by linear_combination k₃
      have e₄ : -(hexF y.val - hexF (-y).val)
          + (hexF (y - x).val - hexF (-(y - x)).val) = 0 := by linear_combination k₄
      have hfin : ∀ u v : ZMod 6,
          4 - 3 * (hexE u.val + hexE (-u).val) - hexE (-v).val
            + hexE (-(v - u)).val = 0 →
          -(3 * (hexF u.val + hexF (-u).val)) - hexF (-v).val + hexF (-(v - u)).val = 0 →
          -(hexE v.val - hexE (-v).val) + (hexE (v - u).val - hexE (-(v - u)).val) = 0 →
          -(hexF v.val - hexF (-v).val) + (hexF (v - u).val - hexF (-(v - u)).val) = 0 →
          (u = 1 ∧ v = 5) ∨ (u = 5 ∧ v = 1) := by decide
      exact hfin x y e₁ e₂ e₃ e₄
    · -- interior d ≥ 3: the pin `x = 0` and the collapse
      exfalso
      obtain ⟨γ', rfl⟩ : ∃ γ', γ = γ' + 1 := ⟨γ - 1, by omega⟩
      have d₁ : (3 : ℤ) ∣ (hexE (-(y - x)).val - hexE (-y).val) :=
        ⟨-(4 * 3 ^ γ') + 3 ^ (γ' + 1) * (hexE x.val * (piCoeff (2 * 0)).1
            + hexE (-x).val * ((piCoeff (2 * 0)).1 + (piCoeff (2 * 0)).2))
          + (hexE y.val * py + hexE (-y).val * (py + wy))
          - (hexE (y - x).val * pz + hexE (-(y - x)).val * (pz + wz)),
          by linear_combination k₁⟩
      have d₂ : (3 : ℤ) ∣ (hexF (-(y - x)).val - hexF (-y).val) :=
        ⟨3 ^ (γ' + 1) * (hexF x.val * (piCoeff (2 * 0)).1
            + hexF (-x).val * ((piCoeff (2 * 0)).1 + (piCoeff (2 * 0)).2))
          + (hexF y.val * py + hexF (-y).val * (py + wy))
          - (hexF (y - x).val * pz + hexF (-(y - x)).val * (pz + wz)),
          by linear_combination k₂⟩
      have hpin : -(y - x) = -y := hex_mod_inj (-(y - x)) (-y) (by omega) (by omega)
      have hx0 : x = 0 := sub_eq_self.mp (neg_inj.mp hpin)
      subst hx0
      rw [show (2 * 0 : ℕ) = 0 by norm_num, tracePair_zero_zero, sub_zero,
        show 2 * (0 + (γ' + 1)) + 1 = 2 * (γ' + 1) + 1 by ring] at hD
      have hcon : (2 : ℂ) * 3 ^ (γ' + 1) = 0 := by linear_combination -hD
      exact absurd hcon (mul_ne_zero two_ne_zero (pow_ne_zero _ (by norm_num)))
  · -- b > 0 with d > b: dead on the inner pair's rows
    exfalso
    obtain ⟨β', rfl⟩ : ∃ β', β = β' + 1 := ⟨β - 1, by omega⟩
    have d₁ : (3 : ℤ) ∣ hexE (-y).val :=
      ⟨4 * 3 ^ (β' + γ) - 3 ^ γ * (hexE x.val * (piCoeff (2 * (β' + 1))).1
          + hexE (-x).val * ((piCoeff (2 * (β' + 1))).1 + (piCoeff (2 * (β' + 1))).2))
        - (hexE y.val * py + hexE (-y).val * (py + wy))
        + 3 ^ β' * (hexE (y - x).val * (3 * pz)
          + hexE (-(y - x)).val * (3 * pz + (3 * wz + 1))),
        by linear_combination -k₁⟩
    have d₂ : (3 : ℤ) ∣ hexF (-y).val :=
      ⟨-(3 ^ γ * (hexF x.val * (piCoeff (2 * (β' + 1))).1
          + hexF (-x).val * ((piCoeff (2 * (β' + 1))).1 + (piCoeff (2 * (β' + 1))).2)))
        - (hexF y.val * py + hexF (-y).val * (py + wy))
        + 3 ^ β' * (hexF (y - x).val * (3 * pz)
          + hexF (-(y - x)).val * (3 * pz + (3 * wz + 1))),
        by linear_combination -k₂⟩
    exact hexE_hexF_not_both_dvd (-y).val (ZMod.val_lt _) ⟨d₁, d₂⟩

/-- Shape `b ≥ 0 > d` of the live parity: only the boundary `(b, d) = (0, −1)` survives,
with two hex pairs. -/
private theorem oi_shape₃ {x y z : ZMod 6} {β δ : ℕ} (hz : z = x + y)
    (hE : 4 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * δ + 1) + (2 * (β + δ) + 1))
        - 3 * ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * δ + 1 + (2 * (β + δ) + 1))
          * tracePair x (2 * β)
        - ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * (β + δ) + 1) + 1)
          * tracePair y (2 * δ + 1)
        + ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * δ + 1) + 1)
          * tracePair z (2 * (β + δ) + 1) = 0) :
    β = 0 ∧ δ = 0 ∧ ((x = 1 ∧ y = 1) ∨ (x = 5 ∧ y = 5)) := by
  subst hz
  rw [show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * δ + 1) + (2 * (β + δ) + 1))
      = 3 ^ (2 * β + 2 * δ + 1) by
      rw [show 2 * β + (2 * δ + 1) + (2 * (β + δ) + 1) = 2 * (2 * β + 2 * δ + 1) by ring,
        sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * δ + 1 + (2 * (β + δ) + 1)) = 3 ^ (β + 2 * δ + 1) by
      rw [show 2 * δ + 1 + (2 * (β + δ) + 1) = 2 * (β + 2 * δ + 1) by ring,
        sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * (β + δ) + 1) + 1) = 3 ^ (2 * β + δ + 1) by
      rw [show 2 * β + (2 * (β + δ) + 1) + 1 = 2 * (2 * β + δ + 1) by ring,
        sqrt3_pow_two_mul],
    show ((Real.sqrt 3 : ℝ) : ℂ) ^ (2 * β + (2 * δ + 1) + 1) = 3 ^ (β + δ + 1) by
      rw [show 2 * β + (2 * δ + 1) + 1 = 2 * (β + δ + 1) by ring, sqrt3_pow_two_mul]] at hE
  have hD : 4 * (3 : ℂ) ^ (β + δ) - (3 : ℂ) ^ (δ + 1) * tracePair x (2 * β)
      - (3 : ℂ) ^ β * tracePair y (2 * δ + 1)
      + tracePair (x + y) (2 * (β + δ) + 1) = 0 := by
    refine mul_left_cancel₀ (pow_ne_zero (β + δ + 1) (show (3 : ℂ) ≠ 0 by norm_num)) ?_
    rw [mul_zero]
    linear_combination hE
  have hcx := tracePair_coords x (2 * β)
  have hcy := tracePair_coords y (2 * δ + 1)
  have hcz := tracePair_coords (x + y) (2 * (β + δ) + 1)
  obtain ⟨k₁, k₂, k₃, k₄⟩ := inRing_coords_zero
    (n₁ := 4 * 3 ^ (β + δ)
      - 3 ^ (δ + 1) * (hexE x.val * (piCoeff (2 * β)).1
        + hexE (-x).val * ((piCoeff (2 * β)).1 + (piCoeff (2 * β)).2))
      - 3 ^ β * (hexE y.val * (piCoeff (2 * δ + 1)).1
        + hexE (-y).val * ((piCoeff (2 * δ + 1)).1 + (piCoeff (2 * δ + 1)).2))
      + (hexE (x + y).val * (piCoeff (2 * (β + δ) + 1)).1
        + hexE (-(x + y)).val * ((piCoeff (2 * (β + δ) + 1)).1
          + (piCoeff (2 * (β + δ) + 1)).2)))
    (n₂ := -(3 ^ (δ + 1) * (hexF x.val * (piCoeff (2 * β)).1
        + hexF (-x).val * ((piCoeff (2 * β)).1 + (piCoeff (2 * β)).2)))
      - 3 ^ β * (hexF y.val * (piCoeff (2 * δ + 1)).1
        + hexF (-y).val * ((piCoeff (2 * δ + 1)).1 + (piCoeff (2 * δ + 1)).2))
      + (hexF (x + y).val * (piCoeff (2 * (β + δ) + 1)).1
        + hexF (-(x + y)).val * ((piCoeff (2 * (β + δ) + 1)).1
          + (piCoeff (2 * (β + δ) + 1)).2)))
    (n₃ := -(3 ^ (δ + 1) * ((piCoeff (2 * β)).2 * (hexE x.val - hexE (-x).val)))
      - 3 ^ β * ((piCoeff (2 * δ + 1)).2 * (hexE y.val - hexE (-y).val))
      + (piCoeff (2 * (β + δ) + 1)).2 * (hexE (x + y).val - hexE (-(x + y)).val))
    (n₄ := -(3 ^ (δ + 1) * ((piCoeff (2 * β)).2 * (hexF x.val - hexF (-x).val)))
      - 3 ^ β * ((piCoeff (2 * δ + 1)).2 * (hexF y.val - hexF (-y).val))
      + (piCoeff (2 * (β + δ) + 1)).2 * (hexF (x + y).val - hexF (-(x + y)).val))
    (by push_cast
        linear_combination hD + (3 : ℂ) ^ (δ + 1) * hcx + (3 : ℂ) ^ β * hcy - hcz)
  obtain ⟨py, hpy⟩ := three_dvd_piCoeff_fst (2 * δ)
  obtain ⟨wy, hwy⟩ : ∃ w, (piCoeff (2 * δ + 1)).2 = 3 * w + 1 :=
    ⟨(piCoeff (2 * δ + 1)).2 / 3, by have := piCoeff_snd_emod (2 * δ); omega⟩
  obtain ⟨pz, hpz⟩ := three_dvd_piCoeff_fst (2 * (β + δ))
  obtain ⟨wz, hwz⟩ : ∃ w, (piCoeff (2 * (β + δ) + 1)).2 = 3 * w + 1 :=
    ⟨(piCoeff (2 * (β + δ) + 1)).2 / 3, by have := piCoeff_snd_emod (2 * (β + δ)); omega⟩
  rw [hpy, hwy, hpz, hwz] at k₁ k₂
  rw [hwy, hwz] at k₃ k₄
  rcases Nat.eq_zero_or_pos β with hβ0 | hβpos
  · subst hβ0
    rcases Nat.eq_zero_or_pos δ with hδ0 | hδpos
    · -- the boundary (b, d) = (0, −1)
      subst hδ0
      refine ⟨rfl, rfl, ?_⟩
      have hex1 : (piCoeff (2 * 0)).1 = 1 := rfl
      have hex2 : (piCoeff (2 * 0)).2 = 0 := rfl
      have hex3 : (piCoeff (2 * 0 + 1)).1 = 0 := rfl
      have hex4 : (piCoeff (2 * 0 + 1)).2 = 1 := rfl
      have hex5 : (piCoeff (2 * (0 + 0) + 1)).1 = 0 := rfl
      have hex6 : (piCoeff (2 * (0 + 0) + 1)).2 = 1 := rfl
      have hpy' : py = 0 := by omega
      have hwy' : wy = 0 := by omega
      have hpz' : pz = 0 := by omega
      have hwz' : wz = 0 := by omega
      subst hpy'
      subst hwy'
      subst hpz'
      subst hwz'
      rw [hex1, hex2] at k₁ k₂
      rw [hex2] at k₃ k₄
      have e₁ : 4 - 3 * (hexE x.val + hexE (-x).val) - hexE (-y).val
          + hexE (-(x + y)).val = 0 := by linear_combination k₁
      have e₂ : -(3 * (hexF x.val + hexF (-x).val)) - hexF (-y).val
          + hexF (-(x + y)).val = 0 := by linear_combination k₂
      have e₃ : -(hexE y.val - hexE (-y).val)
          + (hexE (x + y).val - hexE (-(x + y)).val) = 0 := by linear_combination k₃
      have e₄ : -(hexF y.val - hexF (-y).val)
          + (hexF (x + y).val - hexF (-(x + y)).val) = 0 := by linear_combination k₄
      have hfin : ∀ u v : ZMod 6,
          4 - 3 * (hexE u.val + hexE (-u).val) - hexE (-v).val
            + hexE (-(u + v)).val = 0 →
          -(3 * (hexF u.val + hexF (-u).val)) - hexF (-v).val + hexF (-(u + v)).val = 0 →
          -(hexE v.val - hexE (-v).val) + (hexE (u + v).val - hexE (-(u + v)).val) = 0 →
          -(hexF v.val - hexF (-v).val) + (hexF (u + v).val - hexF (-(u + v)).val) = 0 →
          (u = 1 ∧ v = 1) ∨ (u = 5 ∧ v = 5) := by decide
      exact hfin x y e₁ e₂ e₃ e₄
    · -- interior d ≤ −3: the pin `x = 0` and the collapse
      exfalso
      obtain ⟨δ', rfl⟩ : ∃ δ', δ = δ' + 1 := ⟨δ - 1, by omega⟩
      have d₁ : (3 : ℤ) ∣ (hexE (-(x + y)).val - hexE (-y).val) :=
        ⟨-(4 * 3 ^ δ') + 3 ^ (δ' + 1) * (hexE x.val * (piCoeff (2 * 0)).1
            + hexE (-x).val * ((piCoeff (2 * 0)).1 + (piCoeff (2 * 0)).2))
          + (hexE y.val * py + hexE (-y).val * (py + wy))
          - (hexE (x + y).val * pz + hexE (-(x + y)).val * (pz + wz)),
          by linear_combination k₁⟩
      have d₂ : (3 : ℤ) ∣ (hexF (-(x + y)).val - hexF (-y).val) :=
        ⟨3 ^ (δ' + 1) * (hexF x.val * (piCoeff (2 * 0)).1
            + hexF (-x).val * ((piCoeff (2 * 0)).1 + (piCoeff (2 * 0)).2))
          + (hexF y.val * py + hexF (-y).val * (py + wy))
          - (hexF (x + y).val * pz + hexF (-(x + y)).val * (pz + wz)),
          by linear_combination k₂⟩
      have hpin : -(x + y) = -y := hex_mod_inj (-(x + y)) (-y) (by omega) (by omega)
      have hx0 : x = 0 := by
        have hadd : ∀ u v : ZMod 6, u + v = v → u = 0 := by decide
        exact hadd x y (neg_inj.mp hpin)
      subst hx0
      rw [show (2 * 0 : ℕ) = 0 by norm_num, tracePair_zero_zero,
        show (0 : ZMod 6) + y = y from zero_add y,
        show 2 * (0 + (δ' + 1)) + 1 = 2 * (δ' + 1) + 1 by ring] at hD
      have hcon : (2 : ℂ) * 3 ^ (δ' + 1) = 0 := by linear_combination -hD
      exact absurd hcon (mul_ne_zero two_ne_zero (pow_ne_zero _ (by norm_num)))
  · -- b > 0 with d < 0: dead on the cross pair's rows
    exfalso
    obtain ⟨β', rfl⟩ : ∃ β', β = β' + 1 := ⟨β - 1, by omega⟩
    have d₁ : (3 : ℤ) ∣ hexE (-(x + y)).val :=
      ⟨-(4 * 3 ^ (β' + δ)) + 3 ^ δ * (hexE x.val * (piCoeff (2 * (β' + 1))).1
          + hexE (-x).val * ((piCoeff (2 * (β' + 1))).1 + (piCoeff (2 * (β' + 1))).2))
        + 3 ^ β' * (hexE y.val * (3 * py) + hexE (-y).val * (3 * py + (3 * wy + 1)))
        - (hexE (x + y).val * pz + hexE (-(x + y)).val * (pz + wz)),
        by linear_combination k₁⟩
    have d₂ : (3 : ℤ) ∣ hexF (-(x + y)).val :=
      ⟨3 ^ δ * (hexF x.val * (piCoeff (2 * (β' + 1))).1
          + hexF (-x).val * ((piCoeff (2 * (β' + 1))).1 + (piCoeff (2 * (β' + 1))).2))
        + 3 ^ β' * (hexF y.val * (3 * py) + hexF (-y).val * (3 * py + (3 * wy + 1)))
        - (hexF (x + y).val * pz + hexF (-(x + y)).val * (pz + wz)),
        by linear_combination k₂⟩
    exact hexE_hexF_not_both_dvd (-(x + y)).val (ZMod.val_lt _) ⟨d₁, d₂⟩

/-- The classification at non-negative outer height: the six sporadic-and-glue rows at
`(b, d) = (2, 1)` and the four hub-glue rows at `b = 0`. -/
private theorem oi_nonneg {a c : ZMod 6} {b d : ℤ} (hb : 0 ≤ b)
    (h : normSq (((Real.sqrt 3 : ℝ) : ℂ) * (1 - word a b) - word c d) = 3) :
    (a = 2 ∧ b = 2 ∧ c = 5 ∧ d = 1) ∨ (a = 4 ∧ b = 2 ∧ c = 1 ∧ d = 1) ∨
      (a = 2 ∧ b = 2 ∧ c = 0 ∧ d = 1) ∨ (a = 4 ∧ b = 2 ∧ c = 0 ∧ d = 1) ∨
      (a = 3 ∧ b = 2 ∧ c = 2 ∧ d = 1) ∨ (a = 3 ∧ b = 2 ∧ c = 4 ∧ d = 1) ∨
      (a = 1 ∧ b = 0 ∧ c = 5 ∧ d = 1) ∨ (a = 5 ∧ b = 0 ∧ c = 1 ∧ d = 1) ∨
      (a = 1 ∧ b = 0 ∧ c = 5 ∧ d = -1) ∨ (a = 5 ∧ b = 0 ∧ c = 1 ∧ d = -1) := by
  have hM := oi_master h
  obtain ⟨m, rfl⟩ : ∃ m : ℕ, b = (m : ℤ) := ⟨b.toNat, by omega⟩
  rcases (by omega : 0 ≤ d ∨ d < 0) with hd | hd
  · obtain ⟨n, rfl⟩ : ∃ n : ℕ, d = (n : ℤ) := ⟨d.toNat, by omega⟩
    rcases (by omega : n ≤ m ∨ m < n) with hnm | hnm
    · -- shape 1: the outer height dominates
      rcases (by omega : m % 2 = 0 ∨ m % 2 = 1) with hm2 | hm2 <;>
        rcases (by omega : n % 2 = 0 ∨ n % 2 = 1) with hn2 | hn2
      · exact ((oi_kill_ee hm2 hn2 (by omega : (m - n) % 2 = 0)
          (oi_clear₁ (k := m - n) (by omega) hM)).elim)
      · -- the live parity
        obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β := ⟨m / 2, by omega⟩
        obtain ⟨δ, rfl⟩ : ∃ δ, n = 2 * δ + 1 := ⟨n / 2, by omega⟩
        obtain ⟨γ, rfl⟩ : ∃ γ, β = δ + γ + 1 := ⟨β - δ - 1, by omega⟩
        have hE := oi_clear₁ (m := 2 * (δ + γ + 1)) (n := 2 * δ + 1) (k := 2 * γ + 1)
          (by push_cast; ring) hM
        obtain ⟨hδ0, hγ0, hsix⟩ := oi_shape₁ rfl hE
        subst hδ0
        subst hγ0
        rcases hsix with ⟨hx, hy⟩ | ⟨hx, hy⟩ | ⟨hx, hy⟩ | ⟨hx, hy⟩ | ⟨hx, hy⟩ | ⟨hx, hy⟩ <;>
          subst hx <;> subst hy
        · exact Or.inl ⟨rfl, by norm_num, rfl, by norm_num⟩
        · exact Or.inr (Or.inl ⟨rfl, by norm_num, rfl, by norm_num⟩)
        · exact Or.inr (Or.inr (Or.inl ⟨rfl, by norm_num, rfl, by norm_num⟩))
        · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨rfl, by norm_num, rfl, by norm_num⟩)))
        · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl
            ⟨rfl, by norm_num, rfl, by norm_num⟩))))
        · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl
            ⟨rfl, by norm_num, rfl, by norm_num⟩)))))
      · exact ((oi_kill_oe hm2 hn2 (by omega : (m - n) % 2 = 1)
          (oi_clear₁ (k := m - n) (by omega) hM)).elim)
      · exact ((oi_kill_oo hm2 hn2 (by omega : (m - n) % 2 = 0)
          (oi_clear₁ (k := m - n) (by omega) hM)).elim)
    · -- shape 2: the inner height dominates
      rcases (by omega : m % 2 = 0 ∨ m % 2 = 1) with hm2 | hm2 <;>
        rcases (by omega : n % 2 = 0 ∨ n % 2 = 1) with hn2 | hn2
      · exact ((oi_kill_ee hm2 hn2 (by omega : (n - m) % 2 = 0)
          (oi_clear₂ (k := n - m) (by omega) hM)).elim)
      · -- the live parity
        obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β := ⟨m / 2, by omega⟩
        obtain ⟨δ, rfl⟩ : ∃ δ, n = 2 * δ + 1 := ⟨n / 2, by omega⟩
        obtain ⟨γ, rfl⟩ : ∃ γ, δ = β + γ := ⟨δ - β, by omega⟩
        have hE := oi_clear₂ (m := 2 * β) (n := 2 * (β + γ) + 1) (k := 2 * γ + 1)
          (by push_cast; ring) hM
        obtain ⟨hβ0, hγ0, hpair⟩ := oi_shape₂ rfl hE
        subst hβ0
        subst hγ0
        rcases hpair with ⟨hx, hy⟩ | ⟨hx, hy⟩ <;> subst hx <;> subst hy
        · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl
            ⟨rfl, by norm_num, rfl, by norm_num⟩))))))
        · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl
            ⟨rfl, by norm_num, rfl, by norm_num⟩)))))))
      · exact ((oi_kill_oe hm2 hn2 (by omega : (n - m) % 2 = 1)
          (oi_clear₂ (k := n - m) (by omega) hM)).elim)
      · exact ((oi_kill_oo hm2 hn2 (by omega : (n - m) % 2 = 0)
          (oi_clear₂ (k := n - m) (by omega) hM)).elim)
  · -- shape 3: negative inner height
    obtain ⟨n, rfl⟩ : ∃ n : ℕ, d = -(n : ℤ) := ⟨d.natAbs, by omega⟩
    rcases (by omega : m % 2 = 0 ∨ m % 2 = 1) with hm2 | hm2 <;>
      rcases (by omega : n % 2 = 0 ∨ n % 2 = 1) with hn2 | hn2
    · exact ((oi_kill_ee hm2 hn2 (by omega : (m + n) % 2 = 0)
        (oi_clear₃ (k := m + n) (by push_cast; ring) hM)).elim)
    · -- the live parity
      obtain ⟨β, rfl⟩ : ∃ β, m = 2 * β := ⟨m / 2, by omega⟩
      obtain ⟨δ, rfl⟩ : ∃ δ, n = 2 * δ + 1 := ⟨n / 2, by omega⟩
      have hE := oi_clear₃ (m := 2 * β) (n := 2 * δ + 1) (k := 2 * (β + δ) + 1)
        (by push_cast; ring) hM
      obtain ⟨hβ0, hδ0, hpair⟩ := oi_shape₃ (sub_eq_add_neg a c) hE
      subst hβ0
      subst hδ0
      have hneg1 : ∀ u : ZMod 6, -u = 1 → u = 5 := by decide
      have hneg5 : ∀ u : ZMod 6, -u = 5 → u = 1 := by decide
      rcases hpair with ⟨hx, hy⟩ | ⟨hx, hy⟩
      · have hc' : c = 5 := hneg1 c hy
        subst hx
        subst hc'
        exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl
          ⟨rfl, by norm_num, rfl, by norm_num⟩))))))))
      · have hc' : c = 1 := hneg5 c hy
        subst hx
        subst hc'
        exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr
          ⟨rfl, by norm_num, rfl, by norm_num⟩))))))))
    · exact ((oi_kill_oe hm2 hn2 (by omega : (m + n) % 2 = 1)
        (oi_clear₃ (k := m + n) (by push_cast; ring) hM)).elim)
    · exact ((oi_kill_oo hm2 hn2 (by omega : (m + n) % 2 = 0)
        (oi_clear₃ (k := m + n) (by push_cast; ring) hM)).elim)

/-- **oi completeness**: every lattice solution of the outer–inner chord equation is in
the table — sixteen chords ever, no infinite family. The proof separates the heights'
parities (`oi_kill_ee`/`_oo`/`_oe`), analyses the live parity per height-order shape
(`oi_shape₁`/`₂`/`₃`), and closes under conjugation. -/
theorem oi_complete (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ)
    (h : normSq (((Real.sqrt 3 : ℝ) : ℂ) * (1 - word a b) - word c d) = 3) :
    (a, b, c, d) ∈ oiTable := by
  have hswap : ∀ u v : ZMod 6, -u = v → u = -v := by decide
  rcases (by omega : 0 ≤ b ∨ b < 0) with hb | hb
  · rcases oi_nonneg hb h with ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ |
      ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ |
      ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ |
      ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ <;>
    subst ha <;> subst hb' <;> subst hc' <;> subst hd' <;> decide
  · have hexp : (starRingEnd ℂ) (((Real.sqrt 3 : ℝ) : ℂ) * (1 - word a b) - word c d)
        = ((Real.sqrt 3 : ℝ) : ℂ) * (1 - word (-a) (-b)) - word (-c) (-d) := by
      rw [map_sub, map_mul, Complex.conj_ofReal, map_sub, map_one, word_conj, word_conj]
    have h' : normSq (((Real.sqrt 3 : ℝ) : ℂ) * (1 - word (-a) (-b)) - word (-c) (-d))
        = 3 := by
      rw [← hexp, Complex.normSq_conj]
      exact h
    rcases oi_nonneg (by omega : (0 : ℤ) ≤ -b) h' with ⟨ha, hb', hc', hd'⟩ |
      ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ |
      ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ |
      ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ | ⟨ha, hb', hc', hd'⟩ <;>
    first
      | omega
      | (have ha' := hswap a _ ha
         have hc'' := hswap c _ hc'
         have hb'' : b = -2 := by omega
         have hd'' : d = -1 := by omega
         subst ha'
         subst hc''
         subst hb''
         subst hd''
         decide)

/-! ## §H The colouring (E6: one b-independent table, no splice) -/

/-- The colour tables, by (side, circle): side `false` = the pivot at 0, side `true` =
the pivot at 1; circle `false` = outer, `true` = inner. Found by the E6 SAT probe with
every family imposed; the pivot colours are the opposite side's `outer 0` entries by
the fusion equalities, so no pivot casing exists. -/
def colTab : Bool → Bool → ZMod 6 → Fin 4
  | false, false => ![0, 1, 0, 1, 0, 1]
  | false, true => ![1, 0, 2, 2, 3, 3]
  | true, false => ![2, 1, 2, 1, 2, 1]
  | true, true => ![1, 2, 0, 0, 3, 3]

open Classical in
/-- The colouring of the plane restricted to the ladder pair: decode any address, read
the table (`b` never enters — the colouring is b-independent). Well-defined on fused
points because the table equalizes every fusion (`ladderColor_outerP` and siblings).
Junk value `0` off the ladder. -/
noncomputable def ladderColor (z : ℂ) : Fin 4 :=
  if h : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = z then colTab false false h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = z then colTab false true h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, outerPt 1 0 n.1 n.2 = z then colTab true false h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, innerPt 1 0 n.1 n.2 = z then colTab true true h.choose.1
  else 0

/-- The anchor's axis fact, in the form every classification citation needs. -/
private theorem dist_01 : dist (0 : ℂ) 1 = 1 := Triangle.dist_pivot_01

private theorem dist_10 : dist (1 : ℂ) 0 = 1 := by
  rw [dist_comm]
  exact dist_01

theorem ladderColor_outerP (a : ZMod 6) (b : ℤ) :
    ladderColor (outerPt 0 1 a b) = colTab false false a := by
  have hex : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = outerPt 0 1 a b := ⟨(a, b), rfl⟩
  rw [ladderColor, dif_pos hex]
  congr 1
  exact ((outerPt_inj dist_01 _ _ _ _).mp hex.choose_spec).1

theorem ladderColor_innerP (a : ZMod 6) (b : ℤ) :
    ladderColor (innerPt 0 1 a b) = colTab false true a := by
  have hno : ¬ ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = innerPt 0 1 a b := by
    rintro ⟨n, hn⟩
    exact outer_ne_inner dist_01 n.1 n.2 a b hn
  have hex : ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = innerPt 0 1 a b := ⟨(a, b), rfl⟩
  rw [ladderColor, dif_neg hno, dif_pos hex]
  congr 1
  exact ((innerPt_inj dist_01 _ _ _ _).mp hex.choose_spec).1

theorem ladderColor_outerQ (a : ZMod 6) (b : ℤ) :
    ladderColor (outerPt 1 0 a b) = colTab true false a := by
  by_cases hP : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = outerPt 1 0 a b
  · -- fused with a P-outer point: the two hex glue addresses, where the tables agree
    obtain ⟨n, hn⟩ := hP
    rw [ladderColor, dif_pos ⟨n, hn⟩]
    have hfuse := (fusion_oo dist_01 n.1 n.2 a b).mp hn
    have hchoice := (fusion_oo dist_01 _ _ a b).mp
      (Exists.choose_spec (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, outerPt 0 1 m.1 m.2 = outerPt 1 0 a b))
    rcases hchoice with ⟨h1, _, h3, _⟩ | ⟨h1, _, h3, _⟩ <;> rw [h1, h3] <;> rfl
  · by_cases hPi : ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = outerPt 1 0 a b
    · obtain ⟨n, hn⟩ := hPi
      rw [ladderColor, dif_neg hP, dif_pos ⟨n, hn⟩]
      have hchoice := (fusion_oi dist_01 _ _ a b).mp
        (Exists.choose_spec (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, innerPt 0 1 m.1 m.2 = outerPt 1 0 a b))
      rcases hchoice with ⟨h1, _, h3, _⟩ | ⟨h1, _, h3, _⟩ <;> rw [h1, h3] <;> rfl
    · have hex : ∃ n : ZMod 6 × ℤ, outerPt 1 0 n.1 n.2 = outerPt 1 0 a b := ⟨(a, b), rfl⟩
      rw [ladderColor, dif_neg hP, dif_neg hPi, dif_pos hex]
      congr 1
      exact ((outerPt_inj dist_10 _ _ _ _).mp hex.choose_spec).1

theorem ladderColor_innerQ (a : ZMod 6) (b : ℤ) :
    ladderColor (innerPt 1 0 a b) = colTab true true a := by
  by_cases hP : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = innerPt 1 0 a b
  · obtain ⟨n, hn⟩ := hP
    rw [ladderColor, dif_pos ⟨n, hn⟩]
    have hchoice := (fusion_io dist_01 _ _ a b).mp
      (Exists.choose_spec (⟨n, hn⟩ : ∃ m : ZMod 6 × ℤ, outerPt 0 1 m.1 m.2 = innerPt 1 0 a b))
    rcases hchoice with ⟨h1, _, h3, _⟩ | ⟨h1, _, h3, _⟩ <;> rw [h1, h3] <;> rfl
  · have hPi : ¬ ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = innerPt 1 0 a b := by
      rintro ⟨n, hn⟩
      exact fusion_ii dist_01 n.1 n.2 a b hn
    have hQo : ¬ ∃ n : ZMod 6 × ℤ, outerPt 1 0 n.1 n.2 = innerPt 1 0 a b := by
      rintro ⟨n, hn⟩
      exact outer_ne_inner dist_10 n.1 n.2 a b hn
    have hex : ∃ n : ZMod 6 × ℤ, innerPt 1 0 n.1 n.2 = innerPt 1 0 a b := ⟨(a, b), rfl⟩
    rw [ladderColor, dif_neg hP, dif_neg hPi, dif_neg hQo, dif_pos hex]
    congr 1
    exact ((innerPt_inj dist_10 _ _ _ _).mp hex.choose_spec).1

/-! ### Properness, family by family

Each cross-family lemma reads the chord's addresses off the completeness theorem and
closes on the table — a six-element decision for the parametric families, a
list-membership decision for the two finite ones. -/

/-- The table's separations, decided once each: the six-element checks the parametric
families reduce to. -/
private theorem tab_hex : ∀ (s : Bool) (a : ZMod 6), colTab s false a ≠ colTab s false (a + 1) := by decide

private theorem tab_hex' : ∀ (s : Bool) (a : ZMod 6), colTab s false a ≠ colTab s false (a - 1) := by decide

private theorem tab_rot3 : ∀ (s : Bool) (a : ZMod 6), colTab s true a ≠ colTab s true (a + 2) := by decide

private theorem tab_rot3' : ∀ (s : Bool) (a : ZMod 6), colTab s true a ≠ colTab s true (a - 2) := by decide

private theorem tab_seam : ∀ (s : Bool) (a : ZMod 6), colTab s false a ≠ colTab s true a := by decide

private theorem tab_match_oo : ∀ a : ZMod 6, colTab false false a ≠ colTab true false (a + 3) := by
  decide

private theorem tab_match_ii : ∀ a : ZMod 6, colTab false true a ≠ colTab true true (a + 3) := by
  decide

private theorem tab_hub_q : ∀ c : ZMod 6, colTab false false 0 ≠ colTab true false c := by decide

private theorem tab_hub_p : ∀ a : ZMod 6, colTab false false a ≠ colTab true false 0 := by decide

private theorem colors_ne_of_mem_iiTable {a c : ZMod 6} {b d : ℤ}
    (hm : (a, b, c, d) ∈ iiNormTable) : colTab false true a ≠ colTab true true c := by
  fin_cases hm <;> decide

private theorem colors_ne_of_mem_oiTable {a c : ZMod 6} {b d : ℤ}
    (hm : (a, b, c, d) ∈ oiTable) : colTab false false a ≠ colTab true true c := by
  fin_cases hm <;> decide

private theorem colors_ne_of_mem_oiTable' {a c : ZMod 6} {b d : ℤ}
    (hm : (a, b, c, d) ∈ oiTable) : colTab true false a ≠ colTab false true c := by
  fin_cases hm <;> decide

private theorem valid_PoQo {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 0 1 a b) (outerPt 1 0 c d) = 1) :
    colTab false false a ≠ colTab true false c := by
  rcases (oo_complete dist_01 a b c d).mp h with ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩ | ⟨rfl, rfl⟩
  · exact tab_match_oo a
  · exact tab_hub_q c
  · exact tab_hub_p a

private theorem valid_PoQi {a c : ZMod 6} {b d : ℤ}
    (h : dist (outerPt 0 1 a b) (innerPt 1 0 c d) = 1) :
    colTab false false a ≠ colTab true true c :=
  colors_ne_of_mem_oiTable (oi_complete a b c d ((oi_chord_iff dist_01 a b c d).mp h))

private theorem valid_PiQo {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 0 1 a b) (outerPt 1 0 c d) = 1) :
    colTab false true a ≠ colTab true false c :=
  (colors_ne_of_mem_oiTable' (oi_complete c d a b
    ((oi_chord_iff dist_10 c d a b).mp (by rwa [dist_comm] at h)))).symm

private theorem valid_PiQi {a c : ZMod 6} {b d : ℤ}
    (h : dist (innerPt 0 1 a b) (innerPt 1 0 c d) = 1) :
    colTab false true a ≠ colTab true true c := by
  rcases (ii_chord_iff dist_01 a b c d).mp h with ⟨rfl, rfl⟩ | hnorm
  · exact tab_match_ii a
  · exact colors_ne_of_mem_iiTable (ii_norm_complete a b c d hnorm)

/-- **Properness**: the table separates every chord family the completeness theorems
allow. -/
theorem ladderColor_valid {z w : ℂ} (hz : z ∈ ladderSet) (hw : w ∈ ladderSet)
    (h : dist z w = 1) : ladderColor z ≠ ladderColor w := by
  simp only [ladderSet, Set.mem_union, Set.mem_range] at hz hw
  obtain (⟨⟨a, b⟩, rfl⟩ | ⟨⟨a, b⟩, rfl⟩) | (⟨⟨a, b⟩, rfl⟩ | ⟨⟨a, b⟩, rfl⟩) := hz <;>
    obtain (⟨⟨c, d⟩, rfl⟩ | ⟨⟨c, d⟩, rfl⟩) | (⟨⟨c, d⟩, rfl⟩ | ⟨⟨c, d⟩, rfl⟩) := hw
  -- P-outer against each of the four
  · rw [ladderColor_outerP, ladderColor_outerP]
    obtain ⟨hc | hc, -⟩ := (intra_outer_complete dist_01 a b c d).mp h <;> subst hc
    · exact tab_hex false a
    · exact tab_hex' false a
  · rw [ladderColor_outerP, ladderColor_innerP]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_01 a b c d).mp h
    exact tab_seam false _
  · rw [ladderColor_outerP, ladderColor_outerQ]
    exact valid_PoQo h
  · rw [ladderColor_outerP, ladderColor_innerQ]
    exact valid_PoQi h
  -- P-inner
  · rw [ladderColor_innerP, ladderColor_outerP]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_01 c d a b).mp (by rwa [dist_comm] at h)
    exact (tab_seam false _).symm
  · rw [ladderColor_innerP, ladderColor_innerP]
    obtain ⟨hc | hc, -⟩ := (intra_inner_complete dist_01 a b c d).mp h <;> subst hc
    · exact tab_rot3 false a
    · exact tab_rot3' false a
  · rw [ladderColor_innerP, ladderColor_outerQ]
    exact valid_PiQo h
  · rw [ladderColor_innerP, ladderColor_innerQ]
    exact valid_PiQi h
  -- Q-outer
  · rw [ladderColor_outerQ, ladderColor_outerP]
    exact (valid_PoQo (by rwa [dist_comm] at h)).symm
  · rw [ladderColor_outerQ, ladderColor_innerP]
    exact (valid_PiQo (by rwa [dist_comm] at h)).symm
  · rw [ladderColor_outerQ, ladderColor_outerQ]
    obtain ⟨hc | hc, -⟩ := (intra_outer_complete dist_10 a b c d).mp h <;> subst hc
    · exact tab_hex true a
    · exact tab_hex' true a
  · rw [ladderColor_outerQ, ladderColor_innerQ]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_10 a b c d).mp h
    exact tab_seam true _
  -- Q-inner
  · rw [ladderColor_innerQ, ladderColor_outerP]
    exact (valid_PoQi (by rwa [dist_comm] at h)).symm
  · rw [ladderColor_innerQ, ladderColor_innerP]
    exact (valid_PiQi (by rwa [dist_comm] at h)).symm
  · rw [ladderColor_innerQ, ladderColor_outerQ]
    obtain ⟨rfl, -⟩ := (intra_seam_complete dist_10 c d a b).mp (by rwa [dist_comm] at h)
    exact (tab_seam true _).symm
  · rw [ladderColor_innerQ, ladderColor_innerQ]
    obtain ⟨hc | hc, -⟩ := (intra_inner_complete dist_10 a b c d).mp h <;> subst hc
    · exact tab_rot3 true a
    · exact tab_rot3' true a

theorem colorable_four_ladder : ((unitDistance ℂ).induce ladderSet).Colorable 4 :=
  ⟨SimpleGraph.Coloring.mk (fun v => ladderColor (v : ℂ))
    (fun {v w} hvw => ladderColor_valid v.2 w.2 (unitDistance_adj.mp hvw))⟩

/-! ### The lower bound: the nine-point witness, at explicit ladder addresses -/

/-- The witness's vertices: the pivot `0` (which is the partner system's `outer 0 0`), five
consecutive outer hex points of the pivot at `0`, and the rot3 triangle one seam step in. -/
noncomputable def witnessPt : Fin 9 → ℂ
  | 0 => outerPt 1 0 0 0
  | 1 => outerPt 0 1 0 0
  | 2 => outerPt 0 1 1 0
  | 3 => outerPt 0 1 2 0
  | 4 => outerPt 0 1 3 0
  | 5 => outerPt 0 1 4 0
  | 6 => innerPt 0 1 0 1
  | 7 => innerPt 0 1 2 1
  | 8 => innerPt 0 1 4 1

/-- The witness's fifteen unit chords: five hub spokes, four hex steps, three seam steps and
the rot3 triangle. -/
def witnessEdges : List (Fin 9 × Fin 9) :=
  [(0, 1), (0, 2), (0, 3), (0, 4), (0, 5),
   (1, 2), (2, 3), (3, 4), (4, 5),
   (1, 6), (3, 7), (5, 8),
   (6, 7), (6, 8), (7, 8)]

theorem witnessPt_mem (i : Fin 9) : witnessPt i ∈ ladderSet := by
  fin_cases i <;>
    simp only [witnessPt, ladderSet, Set.mem_union, Set.mem_range]
  · exact Or.inr (Or.inl ⟨(0, 0), rfl⟩)
  · exact Or.inl (Or.inl ⟨(0, 0), rfl⟩)
  · exact Or.inl (Or.inl ⟨(1, 0), rfl⟩)
  · exact Or.inl (Or.inl ⟨(2, 0), rfl⟩)
  · exact Or.inl (Or.inl ⟨(3, 0), rfl⟩)
  · exact Or.inl (Or.inl ⟨(4, 0), rfl⟩)
  · exact Or.inl (Or.inr ⟨(0, 1), rfl⟩)
  · exact Or.inl (Or.inr ⟨(2, 1), rfl⟩)
  · exact Or.inl (Or.inr ⟨(4, 1), rfl⟩)

/-- Every listed pair really is a unit chord — each one read off a completeness theorem's
constructive direction, so the witness needs no new geometry. -/
theorem witnessPt_dist {e : Fin 9 × Fin 9} (he : e ∈ witnessEdges) :
    dist (witnessPt e.1) (witnessPt e.2) = 1 := by
  have hub : ∀ a : ZMod 6, dist (outerPt 1 0 0 0) (outerPt 0 1 a 0) = 1 := fun a =>
    (oo_complete dist_10 0 0 a 0).mpr (Or.inr (Or.inl ⟨rfl, rfl⟩))
  have hex : ∀ a : ZMod 6, dist (outerPt 0 1 a 0) (outerPt 0 1 (a + 1) 0) = 1 := fun a =>
    (intra_outer_complete dist_01 a 0 (a + 1) 0).mpr ⟨Or.inl rfl, rfl⟩
  have seam : ∀ a : ZMod 6, dist (outerPt 0 1 a 0) (innerPt 0 1 a 1) = 1 := fun a =>
    (intra_seam_complete dist_01 a 0 a 1).mpr ⟨rfl, Or.inl rfl⟩
  have rot : ∀ a : ZMod 6, dist (innerPt 0 1 a 1) (innerPt 0 1 (a + 2) 1) = 1 := fun a =>
    (intra_inner_complete dist_01 a 1 (a + 2) 1).mpr ⟨Or.inl rfl, rfl⟩
  fin_cases he <;> simp only [witnessPt]
  · exact hub 0
  · exact hub 1
  · exact hub 2
  · exact hub 3
  · exact hub 4
  · exact hex 0
  · exact hex 1
  · exact hex 2
  · exact hex 3
  · exact seam 0
  · exact seam 2
  · exact seam 4
  · exact rot 0
  · exact (intra_inner_complete dist_01 0 1 4 1).mpr ⟨Or.inr (by decide), rfl⟩
  · exact rot 2

/-- The abstract nine-vertex graph is not 3-colourable — `decide` against the literal edge
list (3⁹ colourings, fifteen edges). -/
theorem witness_not_colorable_three : ¬ (edgeGraph 9 witnessEdges).Colorable 3 := by
  rw [not_colorable_edgeGraph_iff]
  decide +kernel

/-- The negative control the `decide` above needs: the same nine points DO admit four
colours, so non-3-colourability is a fact about three, not an artifact of the encoding. -/
example : (edgeGraph 9 witnessEdges).Colorable 4 :=
  colorable_iff_exists.mpr ⟨![3, 0, 1, 0, 1, 0, 1, 2, 3], by
    simp only [edgeGraph_adj]
    decide⟩

/-- The witness, drawn in the ladder pair. -/
noncomputable def witnessHom :
    edgeGraph 9 witnessEdges →g (unitDistance ℂ).induce ladderSet where
  toFun i := ⟨witnessPt i, witnessPt_mem i⟩
  map_rel' {i j} hij := by
    have hne : i ≠ j := hij.1
    rcases hij.2 with hm | hm
    · exact unitDistance_adj.mpr (witnessPt_dist (e := (i, j)) hm)
    · exact unitDistance_adj.mpr (by rw [dist_comm]; exact witnessPt_dist (e := (j, i)) hm)

/-- The nine-point witness (pivot, five consecutive outer hex points, the seam-image
rot3 triangle — all ladder addresses) refuses three colours. -/
theorem not_colorable_three_ladder :
    ¬ ((unitDistance ℂ).induce ladderSet).Colorable 3 := fun hc =>
  witness_not_colorable_three (SimpleGraph.Colorable.of_hom witnessHom hc)

/-- **The headline: the matched ladder pair is exactly 4-chromatic.** The object is the
countable two-pivot ladder pair — all four circle-lattices, both parity tubes, the
pivots as lattice members — with every chord family made exact by the completeness
theorems: no census window, no conditional clause. (NOT the uncountable
`Coupled.pairSystem`: that object's χ is the M21 fork, parked as M29's question.) -/
theorem chromaticNumber_ladderPair :
    ((unitDistance ℂ).induce ladderSet).chromaticNumber = 4 := by
  refine le_antisymm colorable_four_ladder.chromaticNumber_le ?_
  exact_mod_cast add_one_le_chromaticNumber_iff_not_colorable.mpr not_colorable_three_ladder

/-! ## §I Specification -/

-- the tables are the E6 artifact, verbatim
example : iiNormTable.length = 10 := rfl
example : oiTable.length = 16 := rfl
example : colTab false false 0 = 0 ∧ colTab true false 0 = 2 := ⟨rfl, rfl⟩

/-- Splitting a word into its hex and seam halves — the shape the concrete checks use. -/
private theorem word_split (a : ZMod 6) (b : ℤ) : word a b = word a 0 * word 0 b := by
  rw [← word_add]
  norm_num

private theorem word_seam_zpow (b : ℤ) : word 0 b = seam ^ b := by
  rw [word, show (((0 : ZMod 6)).val : ℤ) = 0 from rfl, zpow_zero, one_mul]

private theorem zeta6_add_conj : zeta6 + (starRingEnd ℂ) zeta6 = 1 := by
  rw [← Triangle.one_sub_zeta6]
  ring

private theorem sqrt3_mul_one_add_seam_sq :
    ((Real.sqrt 3 : ℝ) : ℂ) * (1 + seam ^ 2) = seam := by
  rw [← seam_rel, inner_ratio_cast]
  field_simp
  linear_combination seam * sqrt3_cast_sq

private theorem word_00 : word 0 0 = 1 := by simp [word]

private theorem outerPt_zero (p q : ℂ) : outerPt p q 0 0 = q := by
  show p + word 0 0 * (q - p) = q
  rw [word_00]
  ring

-- the pivots are lattice members with no special casing
example : (0 : ℂ) ∈ ladderSet := Or.inr (Or.inl ⟨(0, 0), outerPt_zero 1 0⟩)

example : (1 : ℂ) ∈ ladderSet := Or.inl (Or.inl ⟨(0, 0), outerPt_zero 0 1⟩)

-- a sporadic chord, concretely: the ii sporadic (1,1) → (5,1)
example : dist (innerPt 0 1 1 1) (innerPt 1 0 5 1) = 1 := by
  refine (ii_chord_iff dist_01 1 1 5 1).mpr (Or.inr ?_)
  rw [word_split 1 1, word_split 5 1, word_10, word_conj_10, word_seam_zpow,
    show ((1 : ℤ)) = ((1 : ℕ) : ℤ) from rfl, zpow_natCast, pow_one]
  have hz := zeta6_add_conj
  have hs := sqrt3_mul_one_add_seam_sq
  linear_combination seam * hz - ((Real.sqrt 3 : ℝ) : ℂ) * seam ^ 2 * zeta6_mul_conj - hs

-- the adversarial member: the neighbouring ii pair is NOT a chord (the table's
-- discriminating example — colour equality here must not matter)
example : dist (innerPt 0 1 2 1) (innerPt 1 0 4 1) ≠ 1 := by
  intro hd
  rcases (ii_chord_iff dist_01 2 1 4 1).mp hd with ⟨hc, -⟩ | hnorm
  · exact absurd hc (by decide)
  · -- the norm branch would force `−σ = σ`
    rw [word_split 2 1, word_split 4 1, word_20, word_conj_20, word_seam_zpow,
      show ((1 : ℤ)) = ((1 : ℕ) : ℤ) from rfl, zpow_natCast, pow_one] at hnorm
    have hz : zeta6 ^ 2 + (starRingEnd ℂ) (zeta6 ^ 2) = -1 := by
      rw [map_pow, ← Triangle.one_sub_zeta6]
      linear_combination (2 : ℂ) * zeta6_minpoly
    have hzz : zeta6 ^ 2 * (starRingEnd ℂ) (zeta6 ^ 2) = 1 := by
      rw [map_pow, ← mul_pow, zeta6_mul_conj, one_pow]
    have hs := sqrt3_mul_one_add_seam_sq
    have hzero : (2 : ℂ) * seam = 0 := by
      linear_combination -hnorm + seam * hz - ((Real.sqrt 3 : ℝ) : ℂ) * seam ^ 2 * hzz - hs
    rcases mul_eq_zero.mp hzero with h2 | h2
    · norm_num at h2
    · exact seam_ne_zero h2

-- the matching translate at inner height 1 is a chord
example : dist (innerPt 0 1 0 1) (innerPt 1 0 3 1) = 1 :=
  (ii_chord_iff dist_01 0 1 3 1).mpr (Or.inl ⟨by decide, rfl⟩)

-- the glue-incident norm-branch chord (σ, −σ³): audit partner for iiNormTable entry
-- (0,1,3,3) — deleting that entry must break this example's route through
-- ii_norm_complete's assembly
example : dist (innerPt 0 1 0 1) (innerPt 1 0 3 3) = 1 := by
  refine (ii_chord_iff dist_01 0 1 3 3).mpr (Or.inr ?_)
  have h30 : word 3 0 = -1 := by
    rw [word, show (((3 : ZMod 6)).val : ℤ) = ((3 : ℕ) : ℤ) from rfl, zpow_natCast, zpow_zero,
      mul_one]
    exact zeta6_cube
  rw [word_split 3 3, h30, word_seam_zpow, word_seam_zpow,
    show ((1 : ℤ)) = ((1 : ℕ) : ℤ) from rfl, show ((3 : ℤ)) = ((3 : ℕ) : ℤ) from rfl,
    zpow_natCast, zpow_natCast, pow_one]
  have hs := sqrt3_mul_one_add_seam_sq
  linear_combination (seam ^ 2 - 1) * hs

-- an oi glue-incident chord: audit partner for oiTable entry (1,0,5,1)
example : dist (outerPt 0 1 1 0) (innerPt 1 0 5 1) = 1 := by
  refine (oi_chord_iff dist_01 1 0 5 1).mpr ?_
  rw [word_10, word_split 5 1, word_conj_10, word_seam_zpow,
    show ((1 : ℤ)) = ((1 : ℕ) : ℤ) from rfl, zpow_natCast, pow_one,
    show ((Real.sqrt 3 : ℝ) : ℂ) * (1 - zeta6) - (starRingEnd ℂ) zeta6 * seam
      = (starRingEnd ℂ) zeta6 * (((Real.sqrt 3 : ℝ) : ℂ) - seam) by
        rw [Triangle.one_sub_zeta6]; ring,
    map_mul]
  have hc : normSq ((starRingEnd ℂ) zeta6) = 1 := by
    rw [Complex.normSq_conj, ← Complex.sq_norm, norm_zeta6]
    norm_num
  rw [hc, one_mul]
  simp only [normSq_apply, Complex.sub_re, Complex.sub_im, Complex.ofReal_re, Complex.ofReal_im,
    seam]
  nlinarith [sq_sqrt3, sq_sqrt33, sqrt3_mul_sqrt33]

end Ladder
end HadwigerNelson
