import Proofs.HadwigerNelson.Triangle

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

/-- **Outer–outer completeness**: matching translate, or one endpoint is the other
pivot (the hub branches). The factorization `(x+v)(x−1)(v−1) = 0` in address form —
no sporadics exist on this family. -/
theorem oo_complete {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    dist (outerPt p q a b) (outerPt q p c d) = 1 ↔
      ((c = a + 3 ∧ d = b) ∨ (a = 0 ∧ b = 0) ∨ (c = 0 ∧ d = 0)) := by
  sorry

/-- **The inner–inner bridge**: the matching translate (in address form, like
`oo_complete`), or the Möbius norm form `v·(√3u − 1) = u − √3` (division-free form of
`(√3u−1)(√3v−1) = −2`, i.e. `v = μ(u)`) — whose complete lattice solution set is
`ii_norm_complete`. -/
theorem ii_chord_iff {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    dist (innerPt p q a b) (innerPt q p c d) = 1 ↔
      ((c = a + 3 ∧ d = b) ∨
        word c d * ((Real.sqrt 3 : ℂ) * word a b - 1) = word a b - (Real.sqrt 3 : ℂ)) := by
  sorry

/-- **The outer–inner bridge**: the unfactorable branch, as the norm equation of
`A = √3(1−x) − v` (E1: identical to M23's three-term identity). The io family is this
bridge read at the swapped anchor — no separate theorem. -/
theorem oi_chord_iff {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    dist (outerPt p q a b) (innerPt q p c d) = 1 ↔
      normSq ((Real.sqrt 3 : ℂ) * (1 - word a b) - word c d) = 3 := by
  sorry

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

/-! ## §G The completeness core (E2/E3/E5) -/

/-- The complete solution set of the ii **norm-branch** equation on the lattice, as
address tuples: the two matching-crossing points, the four sporadics, and the four
glue-incident solutions `(σ, −σ³)` (conjugates and swaps included). The matching
branch — the infinite family `c = a + 3, d = b` — is deliberately NOT here: it is
`ii_chord_iff`'s first disjunct. -/
def iiNormTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(0, 0, 3, 0), (3, 0, 0, 0),
   (1, 1, 5, 1), (5, 1, 1, 1), (1, -1, 5, -1), (5, -1, 1, -1),
   (0, 1, 3, 3), (3, 3, 0, 1), (0, -1, 3, -3), (3, -3, 0, -1)]

/-- **The ii bound** (the valuation core): away from the boundary rows, the Möbius
image of a lattice word can only be lattice at seam height one. Two-prime π/π̄
bookkeeping in `ℤ[ζ₆, π]`, `π = √3σ = (1+i√11)/2`, `π² = π − 3`. -/
theorem ii_norm_bound (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ)
    (hm : word c d * ((Real.sqrt 3 : ℂ) * word a b - 1) = word a b - (Real.sqrt 3 : ℂ))
    (hb : 2 ≤ |b|) : |d| = 1 := by
  sorry

/-- **ii completeness**: every lattice solution of the norm form is in the table. -/
theorem ii_norm_complete (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ)
    (hm : word c d * ((Real.sqrt 3 : ℂ) * word a b - 1) = word a b - (Real.sqrt 3 : ℂ)) :
    (a, b, c, d) ∈ iiNormTable := by
  sorry

/-- The complete solution set of the oi chord equation: four sporadics and twelve
glue-incident chords — sixteen chords EVER, no infinite family (E3/E5: no growth from
window 8 to window 200; the theorem removes the window). -/
def oiTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(2, 2, 5, 1), (2, -2, 5, -1), (4, 2, 1, 1), (4, -2, 1, -1),
   (1, 0, 5, 1), (1, 0, 5, -1), (5, 0, 1, 1), (5, 0, 1, -1),
   (2, 2, 0, 1), (2, -2, 0, -1), (4, 2, 0, 1), (4, -2, 0, -1),
   (3, 2, 2, 1), (3, -2, 2, -1), (3, 2, 4, 1), (3, -2, 4, -1)]

/-- **oi completeness**: every lattice solution of the outer–inner chord equation is in
the table. -/
theorem oi_complete (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ)
    (h : normSq ((Real.sqrt 3 : ℂ) * (1 - word a b) - word c d) = 3) :
    (a, b, c, d) ∈ oiTable := by
  sorry

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

theorem ladderColor_outerP (a : ZMod 6) (b : ℤ) :
    ladderColor (outerPt 0 1 a b) = colTab false false a := by
  sorry

theorem ladderColor_innerP (a : ZMod 6) (b : ℤ) :
    ladderColor (innerPt 0 1 a b) = colTab false true a := by
  sorry

theorem ladderColor_outerQ (a : ZMod 6) (b : ℤ) :
    ladderColor (outerPt 1 0 a b) = colTab true false a := by
  sorry

theorem ladderColor_innerQ (a : ZMod 6) (b : ℤ) :
    ladderColor (innerPt 1 0 a b) = colTab true true a := by
  sorry

/-- **Properness**: the table separates every chord family the completeness theorems
allow. -/
theorem ladderColor_valid {z w : ℂ} (hz : z ∈ ladderSet) (hw : w ∈ ladderSet)
    (h : dist z w = 1) : ladderColor z ≠ ladderColor w := by
  sorry

theorem colorable_four_ladder : ((unitDistance ℂ).induce ladderSet).Colorable 4 := by
  sorry

/-- The nine-point witness (pivot, five consecutive outer hex points, the seam-image
rot3 triangle — all ladder addresses) refuses three colours. -/
theorem not_colorable_three_ladder :
    ¬ ((unitDistance ℂ).induce ladderSet).Colorable 3 := by
  sorry

/-- **The headline: the matched ladder pair is exactly 4-chromatic.** The object is the
countable two-pivot ladder pair — all four circle-lattices, both parity tubes, the
pivots as lattice members — with every chord family made exact by the completeness
theorems: no census window, no conditional clause. (NOT the uncountable
`Coupled.pairSystem`: that object's χ is the M21 fork, parked as M29's question.) -/
theorem chromaticNumber_ladderPair :
    ((unitDistance ℂ).induce ladderSet).chromaticNumber = 4 := by
  sorry

/-! ## §I Specification -/

-- the tables are the E6 artifact, verbatim
example : iiNormTable.length = 10 := rfl
example : oiTable.length = 16 := rfl
example : colTab false false 0 = 0 ∧ colTab true false 0 = 2 := ⟨rfl, rfl⟩

-- the pivots are lattice members with no special casing
example : (0 : ℂ) ∈ ladderSet := by
  sorry

example : (1 : ℂ) ∈ ladderSet := by
  sorry

-- a sporadic chord, concretely: the ii sporadic (1,1) → (5,1)
example : dist (innerPt 0 1 1 1) (innerPt 1 0 5 1) = 1 := by
  sorry

-- the adversarial member: the neighbouring ii pair is NOT a chord (the table's
-- discriminating example — colour equality here must not matter)
example : dist (innerPt 0 1 2 1) (innerPt 1 0 4 1) ≠ 1 := by
  sorry

-- the matching translate at inner height 1 is a chord
example : dist (innerPt 0 1 0 1) (innerPt 1 0 3 1) = 1 := by
  sorry

-- the glue-incident norm-branch chord (σ, −σ³): audit partner for iiNormTable entry
-- (0,1,3,3) — deleting that entry must break this example's route through
-- ii_norm_complete's assembly
example : dist (innerPt 0 1 0 1) (innerPt 1 0 3 3) = 1 := by
  sorry

-- an oi glue-incident chord: audit partner for oiTable entry (1,0,5,1)
example : dist (outerPt 0 1 1 0) (innerPt 1 0 5 1) = 1 := by
  sorry

end Ladder
end HadwigerNelson
