import Proofs.HadwigerNelson.UnitDistance
import Mathlib.Analysis.Complex.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.RingTheory.IntegralClosure.IntegrallyClosed
import Mathlib.Algebra.GCDMonoid.IntegrallyClosed

/-!
# The two-circle theorem (M19)

**Every unit-distance graph whose vertices lie on the two circles of radius `1` and `1/√3`
about a common point is 3-colourable.**

This is the local ceiling that explains M18's flat measurement: at a 120°-class pivot `p`,
the whole cover set `N(p) ∪ C` lives on these two circles, so no gadget placed inside the
cover set can ever force a fourth colour there — the rainbow floor (`minCov = 3`, measured
at all 4,615 + 1,558 pivots) is not an accident of our constructions but a theorem of the
geometry. The boundary of the barrier, sharpened at M20 (`Compulsion.lean`): a fourth
colour is *not* excluded, and the pivot itself already forces it — `{p} ∪` (both circles)
is **exactly 4-chromatic** (the centre pigeonholes the outer circle to two colours, and an
outer 120°-triple can never be monochromatic even though it is an independent set — the
seam-image unit triangle refuses). What stays impossible inside one pivot's system is a
*fifth* colour: coverage 4 at five colours requires structure spanning more than one
pivot. Multi-pivot coupling is the open question this pair of modules leaves.

## The shape of the proof

Work multiplicatively on the unit circle of ℂ. Unit chords on the radius-1 circle subtend
exactly 60°, so their endpoint ratio is `zeta6^{±1}`; unit chords on the radius-`1/√3`
circle subtend exactly 120° (`zeta6^{±2}` — the ℤ/3 triangles); cross chords have ratio
`seam^{±1}` where `seam = (√3 + i·√33)/6` — the √33 family's true geometric identity.
`seam` has **infinite order** (its trace `√3/3` squares to `1/3`, which is no integer, so
`seam` is no root of unity) — hence every point of a `⟨zeta6, seam⟩`-orbit carries a unique
label `(i, j) ∈ ℤ/6 × ℤ`, the only unit edges are four label steps, and the explicit
colouring `outerTable = [1,2,0,2,1,0]` / `innerTable = [0,0,1,1,2,2]` (`j`-independent)
is proper on all four. Verified numerically on a 324-point instance before formalizing
(`plans/M19-coverage-driven-construction.md` §0(e)).
-/

namespace HadwigerNelson
namespace TwoCircle

open Complex

/-- `e^{iπ/3}`: the ratio between endpoints of a unit chord of the unit circle. -/
noncomputable def zeta6 : ℂ := ⟨1 / 2, Real.sqrt 3 / 2⟩

/-- `(√3 + i·√33)/6`: the ratio (inner point over outer point, as unit-circle phases) across
a unit cross-chord between the circles of radius `1/√3` and `1`. Its real part `√3/6` is the
cross-chord's cosine; its imaginary part carries the `√33` that M17's resistance histogram
kept surfacing — the seam was geometry, not colour forcing. -/
noncomputable def seam : ℂ := ⟨Real.sqrt 3 / 6, Real.sqrt 33 / 6⟩

private theorem sq_sqrt3 : Real.sqrt 3 * Real.sqrt 3 = 3 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sq_sqrt33 : Real.sqrt 33 * Real.sqrt 33 = 33 :=
  Real.mul_self_sqrt (by norm_num)

private theorem sqrt3_pos : 0 < Real.sqrt 3 := Real.sqrt_pos.mpr (by norm_num)

private theorem normSq_zeta6 : normSq zeta6 = 1 := by
  simp only [normSq_apply, zeta6]
  nlinarith [sq_sqrt3]

private theorem normSq_seam : normSq seam = 1 := by
  simp only [normSq_apply, seam]
  nlinarith [sq_sqrt3, sq_sqrt33]

theorem norm_zeta6 : ‖zeta6‖ = 1 := by
  rw [Complex.norm_def, normSq_zeta6, Real.sqrt_one]

theorem norm_seam : ‖seam‖ = 1 := by
  rw [Complex.norm_def, normSq_seam, Real.sqrt_one]

theorem zeta6_ne_zero : zeta6 ≠ 0 := fun h => by
  have h1 := norm_zeta6
  rw [h, norm_zero] at h1
  norm_num at h1

theorem seam_ne_zero : seam ≠ 0 := fun h => by
  have h1 := norm_seam
  rw [h, norm_zero] at h1
  norm_num at h1

private theorem zeta6_pow_two : zeta6 ^ 2 = ⟨-(1 / 2), Real.sqrt 3 / 2⟩ := by
  refine Complex.ext ?_ ?_
  · simp only [pow_two, zeta6, mul_re]
    linear_combination (-(1 : ℝ) / 4) * sq_sqrt3
  · simp only [pow_two, zeta6, mul_im]
    ring

private theorem zeta6_pow_three : zeta6 ^ 3 = -1 := by
  rw [pow_succ, zeta6_pow_two]
  refine Complex.ext ?_ ?_
  · simp only [zeta6, mul_re, Complex.neg_re, Complex.one_re]
    linear_combination (-(1 : ℝ) / 4) * sq_sqrt3
  · simp only [zeta6, mul_im, Complex.neg_im, Complex.one_im]
    ring

theorem zeta6_pow_six : zeta6 ^ 6 = 1 := by
  rw [show (6 : ℕ) = 3 * 2 by rfl, pow_mul, zeta6_pow_three]
  norm_num

private theorem mk_ne_one_of_im {a b : ℝ} (hb : b ≠ 0) : (⟨a, b⟩ : ℂ) ≠ 1 :=
  fun he => hb ((Complex.ext_iff.mp he).2.trans Complex.one_im)

private theorem zeta6_pow_ne_one : ∀ m < 6, 0 < m → zeta6 ^ m ≠ 1
  | 1, _, _ => by
    rw [pow_one]
    exact mk_ne_one_of_im (by positivity)
  | 2, _, _ => by
    rw [zeta6_pow_two]
    exact mk_ne_one_of_im (by positivity)
  | 3, _, _ => by
    rw [zeta6_pow_three]
    intro h
    have h5 := congrArg Complex.re h
    simp only [Complex.neg_re, Complex.one_re] at h5
    norm_num at h5
  | 4, _, _ => by
    rw [show (4 : ℕ) = 3 + 1 by rfl, pow_succ, zeta6_pow_three, neg_one_mul]
    exact mk_ne_one_of_im (b := -(Real.sqrt 3 / 2)) (neg_ne_zero.mpr (by positivity))
  | 5, _, _ => by
    rw [show (5 : ℕ) = 3 + 2 by rfl, pow_add, zeta6_pow_three, neg_one_mul, zeta6_pow_two]
    exact mk_ne_one_of_im (b := -(Real.sqrt 3 / 2)) (neg_ne_zero.mpr (by positivity))

private theorem zeta6_zpow_six_mul (q : ℤ) : zeta6 ^ (6 * q) = 1 := by
  induction q using Int.induction_on with
  | zero => simp
  | succ n ih =>
    rw [mul_add, mul_one, zpow_add₀ zeta6_ne_zero, ih, one_mul,
      show ((6 : ℤ)) = ((6 : ℕ) : ℤ) by rfl, zpow_natCast, zeta6_pow_six]
  | pred n ih =>
    rw [mul_sub, mul_one, zpow_sub₀ zeta6_ne_zero, ih,
      show ((6 : ℤ)) = ((6 : ℕ) : ℤ) by rfl, zpow_natCast, zeta6_pow_six, div_one]

/-- The order of `zeta6` is exactly 6: `zeta6^i = 1` iff `6 ∣ i`. -/
theorem zeta6_zpow_eq_one_iff {i : ℤ} : zeta6 ^ i = 1 ↔ (6 : ℤ) ∣ i := by
  constructor
  · intro h
    have hr0 : 0 ≤ i % 6 := by omega
    have hr6 : i % 6 < 6 := by omega
    have hsplit : i = 6 * (i / 6) + i % 6 := by omega
    have hrem : zeta6 ^ (i % 6) = 1 := by
      have := h
      rw [hsplit, zpow_add₀ zeta6_ne_zero, zeta6_zpow_six_mul, one_mul] at this
      exact this
    have hnat : zeta6 ^ (i % 6).toNat = 1 := by
      rw [← zpow_natCast, Int.toNat_of_nonneg hr0]
      exact hrem
    have htoNat6 : (i % 6).toNat < 6 := by omega
    have hzero : (i % 6).toNat = 0 := by
      by_contra hne
      exact zeta6_pow_ne_one _ htoNat6 (Nat.pos_of_ne_zero hne) hnat
    have : i % 6 = 0 := by omega
    omega
  · rintro ⟨q, rfl⟩
    exact zeta6_zpow_six_mul q

/-- **The infinite-order lemma.** `seam` is no root of unity: were `seam^n = 1`, `seam` and
its conjugate `seam⁻¹` would be algebraic integers, hence so would their sum `√3/3`, hence
so would its square `1/3` — a rational algebraic integer that is not an integer. This is
the fact that makes the `(i, j)` labels unique, and it is the exact reason the two-circle
graph is a strip `ℤ/6 × ℤ` and not a torus. -/
theorem seam_pow_ne_one (n : ℕ) (hn : n ≠ 0) : seam ^ n ≠ 1 := by
  intro h
  have hseam : IsIntegral ℤ seam :=
    IsIntegral.of_pow (Nat.pos_of_ne_zero hn) (h ▸ isIntegral_one)
  have hmul : seam ^ (n - 1) * seam = 1 := by
    rw [← pow_succ, Nat.sub_add_cancel (Nat.one_le_iff_ne_zero.mpr hn)]
    exact h
  have hinv : seam⁻¹ = seam ^ (n - 1) := (eq_inv_of_mul_eq_one_left hmul).symm
  have hsum_int : IsIntegral ℤ (seam + seam⁻¹) := hseam.add (hinv ▸ hseam.pow _)
  have hsum : seam + seam⁻¹ = ((Real.sqrt 3 / 3 : ℝ) : ℂ) := by
    rw [Complex.inv_eq_conj norm_seam]
    refine Complex.ext ?_ ?_ <;>
      simp [seam, Complex.add_re, Complex.add_im, Complex.conj_re, Complex.conj_im,
        Complex.ofReal_re, Complex.ofReal_im]
    ring
  have hsq : ((Real.sqrt 3 / 3 : ℝ) : ℂ) ^ 2 = ((1 / 3 : ℚ) : ℂ) := by
    rw [← Complex.ofReal_pow]
    norm_cast
    rw [pow_two]
    linear_combination (1 / 9 : ℝ) * sq_sqrt3
  have hint : IsIntegral ℤ (((1 / 3 : ℚ) : ℂ)) := by
    rw [← hsq, ← hsum]
    exact hsum_int.pow 2
  have h13 : IsIntegral ℤ (1 / 3 : ℚ) := by
    rw [show (((1 / 3 : ℚ)) : ℂ) = algebraMap ℚ ℂ (1 / 3 : ℚ) from (eq_ratCast _ _).symm]
      at hint
    exact (isIntegral_algebraMap_iff (algebraMap ℚ ℂ).injective).mp hint
  obtain ⟨z, hz⟩ := IsIntegrallyClosed.isIntegral_iff.mp h13
  have hz' : (z : ℚ) = 1 / 3 := by exact_mod_cast hz
  have h3z : (3 * z : ℚ) = 1 := by push_cast [hz']; ring
  have : (3 * z : ℤ) = 1 := by exact_mod_cast h3z
  omega

theorem seam_zpow_eq_one_iff {j : ℤ} : seam ^ j = 1 ↔ j = 0 := by
  constructor
  · intro h
    rcases j with n | n
    · rcases Nat.eq_zero_or_pos n with rfl | hpos
      · rfl
      · rw [Int.ofNat_eq_natCast, zpow_natCast] at h
        exact absurd h (seam_pow_ne_one n hpos.ne')
    · rw [zpow_negSucc, inv_eq_one] at h
      exact absurd h (seam_pow_ne_one (n + 1) n.succ_ne_zero)
  · rintro rfl
    rfl

/-! ### The three chord classifications

Everything is componentwise algebra on `re`/`im` — no angles, no `arccos`, in the style of
M18's `ClassGeometry` engine. Each says: the metric hypothesis pins the ratio to one of two
named constants. -/

/-- The ratio move shared by all three classifications: two norm-1 phases and a chord
length become a norm-1 ratio `u` at a known distance from the scaled centre. -/
private theorem chord_ratio {w v : ℂ} (hw : ‖w‖ = 1) (hv : ‖v‖ = 1) {s c : ℝ}
    (h : ‖(s : ℂ) * v - w‖ = c) :
    ∃ u : ℂ, ‖u‖ = 1 ∧ ‖(s : ℂ) * u - 1‖ = c ∧ v = u * w := by
  have hw0 : w ≠ 0 := by
    intro h0
    rw [h0, norm_zero] at hw
    norm_num at hw
  refine ⟨v * w⁻¹, ?_, ?_, ?_⟩
  · rw [norm_mul, norm_inv, hv, hw]
    norm_num
  · have key : ((s : ℂ) * (v * w⁻¹) - 1) * w = (s : ℂ) * v - w := by
      field_simp
    calc ‖(s : ℂ) * (v * w⁻¹) - 1‖
        = ‖(s : ℂ) * (v * w⁻¹) - 1‖ * ‖w‖ := by rw [hw, mul_one]
      _ = ‖((s : ℂ) * (v * w⁻¹) - 1) * w‖ := (norm_mul _ _).symm
      _ = c := by rw [key, h]
  · field_simp

/-- A norm-1 phase with a pinned real part is one of the two points the circle admits
there. -/
private theorem unit_of_re {u : ℂ} (hu : ‖u‖ = 1) {a b : ℝ} (hre : u.re = a)
    (hab : a ^ 2 + b ^ 2 = 1) : u = ⟨a, b⟩ ∨ u = ⟨a, -b⟩ := by
  have hnsq : normSq u = 1 := by
    rw [← Complex.sq_norm, hu]
    norm_num
  have him : u.im * u.im = b * b := by
    simp only [normSq_apply, hre] at hnsq
    nlinarith
  rcases mul_self_eq_mul_self_iff.mp him with h1 | h1
  · exact Or.inl (Complex.ext hre h1)
  · exact Or.inr (Complex.ext hre h1)

private theorem conj_zeta6 : (starRingEnd ℂ) zeta6 = (⟨1 / 2, -(Real.sqrt 3 / 2)⟩ : ℂ) := by
  refine Complex.ext ?_ ?_ <;> simp [zeta6]

private theorem conj_zeta6_sq :
    (starRingEnd ℂ) (zeta6 ^ 2) = (⟨-(1 / 2), -(Real.sqrt 3 / 2)⟩ : ℂ) := by
  rw [zeta6_pow_two]
  refine Complex.ext ?_ ?_ <;> simp

private theorem conj_seam :
    (starRingEnd ℂ) seam = (⟨Real.sqrt 3 / 6, -(Real.sqrt 33 / 6)⟩ : ℂ) := by
  refine Complex.ext ?_ ?_ <;> simp [seam]

/-- A unit chord of the unit circle: the endpoint ratio is `zeta6` or its inverse. -/
theorem ratio_of_unit_chord {w w' : ℂ} (hw : ‖w‖ = 1) (hw' : ‖w'‖ = 1)
    (h : ‖w' - w‖ = 1) : w' = zeta6 * w ∨ w' = zeta6⁻¹ * w := by
  obtain ⟨u, hu1, hud, huw⟩ := chord_ratio hw hw' (s := 1) (c := 1)
    (by rwa [Complex.ofReal_one, one_mul])
  rw [Complex.ofReal_one, one_mul] at hud
  have hnsq : normSq u = 1 := by rw [← Complex.sq_norm, hu1]; norm_num
  have hnd : normSq (u - 1) = 1 := by rw [← Complex.sq_norm, hud]; norm_num
  have hre : u.re = 1 / 2 := by
    simp only [normSq_apply, sub_re, sub_im, Complex.one_re, Complex.one_im] at hnd
    simp only [normSq_apply] at hnsq
    nlinarith
  rcases unit_of_re hu1 hre (b := Real.sqrt 3 / 2) (by nlinarith [sq_sqrt3]) with h1 | h1
  · exact Or.inl (by rw [huw, h1]; rfl)
  · refine Or.inr ?_
    rw [huw, h1, Complex.inv_eq_conj norm_zeta6, conj_zeta6]

/-- A chord of length `√3` of the unit circle (the inner circle's unit chords, rescaled):
the ratio is `zeta6^2` or its inverse — the 120° step of the ℤ/3 triangles. -/
theorem ratio_of_sqrt3_chord {v v' : ℂ} (hv : ‖v‖ = 1) (hv' : ‖v'‖ = 1)
    (h : ‖v' - v‖ = Real.sqrt 3) : v' = zeta6 ^ 2 * v ∨ v' = (zeta6 ^ 2)⁻¹ * v := by
  obtain ⟨u, hu1, hud, huw⟩ := chord_ratio hv hv' (s := 1) (c := Real.sqrt 3)
    (by rwa [Complex.ofReal_one, one_mul])
  rw [Complex.ofReal_one, one_mul] at hud
  have hnsq : normSq u = 1 := by rw [← Complex.sq_norm, hu1]; norm_num
  have hnd : normSq (u - 1) = 3 := by
    rw [← Complex.sq_norm, hud, pow_two, sq_sqrt3]
  have hre : u.re = -(1 / 2) := by
    simp only [normSq_apply, sub_re, sub_im, Complex.one_re, Complex.one_im] at hnd
    simp only [normSq_apply] at hnsq
    nlinarith
  rcases unit_of_re hu1 hre (b := Real.sqrt 3 / 2) (by nlinarith [sq_sqrt3]) with h1 | h1
  · exact Or.inl (by rw [huw, h1, zeta6_pow_two])
  · refine Or.inr ?_
    have hnz2 : ‖zeta6 ^ 2‖ = 1 := by rw [norm_pow, norm_zeta6]; norm_num
    rw [huw, h1, Complex.inv_eq_conj hnz2, conj_zeta6_sq]

/-- A unit cross-chord between the circles: `w` on the unit circle, `v/√3` on the inner
circle, at distance 1 — the phase ratio is `seam` or its inverse. -/
theorem ratio_of_cross_chord {w v : ℂ} (hw : ‖w‖ = 1) (hv : ‖v‖ = 1)
    (h : ‖(Real.sqrt 3 : ℂ)⁻¹ * v - w‖ = 1) : v = seam * w ∨ v = seam⁻¹ * w := by
  have h' : ‖((((Real.sqrt 3)⁻¹ : ℝ)) : ℂ) * v - w‖ = 1 := by
    rw [Complex.ofReal_inv]
    exact h
  obtain ⟨u, hu1, hud, huw⟩ := chord_ratio hw hv (s := (Real.sqrt 3)⁻¹) (c := 1) h'
  rw [Complex.ofReal_inv] at hud
  have hnsq : normSq u = 1 := by rw [← Complex.sq_norm, hu1]; norm_num
  have hs3 : (Real.sqrt 3 : ℝ) ≠ 0 := ne_of_gt sqrt3_pos
  have hnd : normSq ((Real.sqrt 3 : ℂ)⁻¹ * u - 1) = 1 := by
    rw [← Complex.sq_norm, hud]
    norm_num
  have hre : u.re = Real.sqrt 3 / 6 := by
    have hinv_re : ((Real.sqrt 3 : ℂ)⁻¹).re = (Real.sqrt 3)⁻¹ := by
      rw [← Complex.ofReal_inv]
      exact Complex.ofReal_re _
    have hinv_im : ((Real.sqrt 3 : ℂ)⁻¹).im = 0 := by
      rw [← Complex.ofReal_inv]
      exact Complex.ofReal_im _
    simp only [normSq_apply, sub_re, sub_im, Complex.mul_re, Complex.mul_im,
      hinv_re, hinv_im, Complex.one_re, Complex.one_im] at hnd
    simp only [normSq_apply] at hnsq
    have hinv3 : (Real.sqrt 3)⁻¹ * Real.sqrt 3 = 1 := inv_mul_cancel₀ hs3
    have hinv_sq : (Real.sqrt 3)⁻¹ * (Real.sqrt 3)⁻¹ = 1 / 3 := by
      rw [← mul_inv, sq_sqrt3]
      norm_num
    have ht : (Real.sqrt 3)⁻¹ * u.re = 1 / 6 := by
      linear_combination (-(1 : ℝ) / 2) * hnd
        + ((Real.sqrt 3)⁻¹ * (Real.sqrt 3)⁻¹ / 2) * hnsq + (1 / 2 : ℝ) * hinv_sq
    linear_combination Real.sqrt 3 * ht - u.re * hinv3
  rcases unit_of_re hu1 hre (b := Real.sqrt 33 / 6) (by nlinarith [sq_sqrt3, sq_sqrt33])
    with h1 | h1
  · exact Or.inl (by rw [huw, h1]; rfl)
  · refine Or.inr ?_
    rw [huw, h1, Complex.inv_eq_conj norm_seam, conj_seam]

/-! ### Labels -/

/-- Two phases in one `⟨zeta6, seam⟩`-orbit. The group is abelian, so membership is exactly
a two-exponent normal form — no word problem. -/
def SameOrbit (x y : ℂ) : Prop := ∃ i j : ℤ, y = zeta6 ^ i * seam ^ j * x

theorem SameOrbit.refl (x : ℂ) : SameOrbit x x := ⟨0, 0, by simp⟩

theorem SameOrbit.symm {x y : ℂ} : SameOrbit x y → SameOrbit y x := by
  rintro ⟨i, j, rfl⟩
  refine ⟨-i, -j, ?_⟩
  have hz : zeta6 ^ i ≠ 0 := zpow_ne_zero i zeta6_ne_zero
  have hs : seam ^ j ≠ 0 := zpow_ne_zero j seam_ne_zero
  rw [zpow_neg, zpow_neg]
  field_simp

theorem SameOrbit.trans {x y z : ℂ} : SameOrbit x y → SameOrbit y z → SameOrbit x z := by
  rintro ⟨i, j, rfl⟩ ⟨i', j', rfl⟩
  exact ⟨i' + i, j' + j, by
    rw [zpow_add₀ zeta6_ne_zero, zpow_add₀ seam_ne_zero]; ring⟩

/-- `SameOrbit` as a setoid — a `def`, deliberately not an `instance`: the equivalence is
this module's construction tool, not a global fact about ℂ. -/
def orbitSetoid : Setoid ℂ := ⟨SameOrbit, fun x => SameOrbit.refl x, SameOrbit.symm,
  SameOrbit.trans⟩

/-- The chosen base point of a phase's orbit — `Quotient.out` doing the per-orbit choice the
strip colouring needs, packaged so that orbit-mates get the *same* base by construction. -/
noncomputable def orbitRep (z : ℂ) : ℂ := (Quotient.mk orbitSetoid z).out

/-- Every phase sits in its own base's orbit — the label-existence half. -/
theorem sameOrbit_orbitRep (z : ℂ) : SameOrbit (orbitRep z) z :=
  Quotient.exact (Quotient.out_eq (Quotient.mk orbitSetoid z))

/-- Orbit-mates share their base — the colouring's well-definedness half. -/
theorem orbitRep_eq_of_sameOrbit {x y : ℂ} (h : SameOrbit x y) : orbitRep x = orbitRep y :=
  congrArg Quotient.out (Quotient.sound h)

/-- A nonzero phase has a nonzero base — the labels' cancellation licence. -/
theorem orbitRep_ne_zero {w : ℂ} (hw : w ≠ 0) : orbitRep w ≠ 0 := by
  intro h0
  obtain ⟨i, j, hij⟩ := sameOrbit_orbitRep w
  rw [h0, mul_zero] at hij
  exact hw hij

/-- **Label uniqueness**: the exponent pair of an orbit element is unique up to the order of
`zeta6` — `j` on the nose, `i` mod 6. Rides entirely on `seam_pow_ne_one`. -/
theorem label_unique {i i' j j' : ℤ}
    (h : zeta6 ^ i * seam ^ j = zeta6 ^ i' * seam ^ j') :
    j = j' ∧ (i : ZMod 6) = (i' : ZMod 6) := by
  have key : seam ^ (j - j') = zeta6 ^ (i' - i) := by
    rw [zpow_sub₀ seam_ne_zero, zpow_sub₀ zeta6_ne_zero,
      div_eq_div_iff (zpow_ne_zero _ seam_ne_zero) (zpow_ne_zero _ zeta6_ne_zero)]
    linear_combination h
  have key6 : seam ^ ((j - j') * 6) = 1 := by
    rw [zpow_mul, key, ← zpow_mul, mul_comm, zeta6_zpow_six_mul]
  have hjj : j - j' = 0 := by
    have h6 := seam_zpow_eq_one_iff.mp key6
    omega
  have hzz : zeta6 ^ (i' - i) = 1 := by
    rw [← key, hjj, zpow_zero]
  have hdvd : (6 : ℤ) ∣ (i' - i) := zeta6_zpow_eq_one_iff.mp hzz
  have hcast : ((i' - i : ℤ) : ZMod 6) = 0 :=
    (ZMod.intCast_zmod_eq_zero_iff_dvd _ 6).mpr hdvd
  push_cast at hcast
  exact ⟨by omega, (sub_eq_zero.mp hcast).symm⟩

/-- The chosen exponents of a phase over its orbit base. Classical, per-phase; uniqueness
mod the `zeta6` order is `label_unique`. -/
noncomputable def label (w : ℂ) : ℤ × ℤ :=
  ⟨(sameOrbit_orbitRep w).choose, (sameOrbit_orbitRep w).choose_spec.choose⟩

theorem label_spec (w : ℂ) :
    w = zeta6 ^ (label w).1 * seam ^ (label w).2 * orbitRep w :=
  (sameOrbit_orbitRep w).choose_spec.choose_spec

/-- The step arithmetic every edge case reduces to: if `y` is `x` moved by `(a, c)` and both
carry labels over one nonzero base, the labels differ by exactly `(a mod 6, c)`. -/
private theorem label_step {x y b : ℂ} (hb : b ≠ 0) {a c i j i' j' : ℤ}
    (h : y = zeta6 ^ a * seam ^ c * x)
    (hx : x = zeta6 ^ i * seam ^ j * b) (hy : y = zeta6 ^ i' * seam ^ j' * b) :
    j' = j + c ∧ (i' : ZMod 6) = (i : ZMod 6) + (a : ZMod 6) := by
  have hcombined : zeta6 ^ i' * seam ^ j' = zeta6 ^ (a + i) * seam ^ (c + j) := by
    have h2 : zeta6 ^ i' * seam ^ j' * b =
        zeta6 ^ (a + i) * seam ^ (c + j) * b := by
      rw [← hy, h, hx, zpow_add₀ zeta6_ne_zero, zpow_add₀ seam_ne_zero]
      ring
    exact mul_right_cancel₀ hb h2
  obtain ⟨hj, hi⟩ := label_unique hcombined
  refine ⟨by omega, ?_⟩
  rw [hi]
  push_cast
  ring

/-! ### The strip colouring -/

/-- Colour table for the outer (radius-1) circle. `j`-independent by design: any wrap in `j`
that irrationality cannot forbid still respects it. -/
def outerTable : ZMod 6 → Fin 3 := ![1, 2, 0, 2, 1, 0]

/-- Colour table for the inner (radius-`1/√3`) circle. -/
def innerTable : ZMod 6 → Fin 3 := ![0, 0, 1, 1, 2, 2]

/-- The outer table breaks every 60° step. -/
theorem outerTable_step (i : ZMod 6) : outerTable (i + 1) ≠ outerTable i := by decide +revert

/-- The inner table breaks every 120° step — it is exactly a proper 3-colouring of the two
ℤ/3 triangles. -/
theorem innerTable_step (i : ZMod 6) : innerTable (i + 2) ≠ innerTable i := by decide +revert

/-- The tables disagree at equal label — which is precisely where cross chords land. -/
theorem outerTable_ne_innerTable (i : ZMod 6) : outerTable i ≠ innerTable i := by decide +revert

/-! ### The assembly -/

private theorem sqrt3_complex_ne_zero : (Real.sqrt 3 : ℂ) ≠ 0 :=
  Complex.ofReal_ne_zero.mpr (ne_of_gt sqrt3_pos)

private theorem norm_outer_phase {p z : ℂ} (h : dist z p = 1) : ‖z - p‖ = 1 := by
  rw [← Complex.dist_eq]
  exact h

private theorem norm_inner_phase {p z : ℂ} (h : dist z p = Real.sqrt 3 / 3) :
    ‖(Real.sqrt 3 : ℂ) * (z - p)‖ = 1 := by
  rw [norm_mul, Complex.norm_real, Real.norm_of_nonneg (Real.sqrt_nonneg 3),
    ← Complex.dist_eq, h]
  linear_combination (1 / 3 : ℝ) * sq_sqrt3

open Classical in
/-- The strip colouring, on raw points: outer points read `outerTable` at their label's
`zeta6`-exponent, inner points `innerTable` at theirs. -/
private noncomputable def rawColour (p z : ℂ) : Fin 3 :=
  if dist z p = 1 then outerTable ((label (z - p)).1 : ZMod 6)
  else innerTable ((label ((Real.sqrt 3 : ℂ) * (z - p))).1 : ZMod 6)

/-- The whole theorem, concentrated: two points of the two-circle set a unit apart never
share a `rawColour`. Four cases, each: chord classification → `label_step` → table fact. -/
private theorem rawColour_ne_of_edge {p z z' : ℂ}
    (hz : dist z p = 1 ∨ dist z p = Real.sqrt 3 / 3)
    (hz' : dist z' p = 1 ∨ dist z' p = Real.sqrt 3 / 3)
    (hd : dist z z' = 1) : rawColour p z ≠ rawColour p z' := by
  by_cases h1 : dist z p = 1 <;> by_cases h2 : dist z' p = 1
  · -- outer–outer: a 60° step
    have hw : ‖z - p‖ = 1 := norm_outer_phase h1
    have hw' : ‖z' - p‖ = 1 := norm_outer_phase h2
    have hchord : ‖(z' - p) - (z - p)‖ = 1 := by
      rw [show (z' - p) - (z - p) = z' - z by ring, norm_sub_rev, ← Complex.dist_eq]
      exact hd
    have hw0 : z - p ≠ 0 := fun h0 => by rw [h0, norm_zero] at hw; norm_num at hw
    have hb : orbitRep (z - p) ≠ 0 := orbitRep_ne_zero hw0
    rcases ratio_of_unit_chord hw hw' hchord with hcase | hcase
    · have hso : SameOrbit (z - p) (z' - p) :=
        ⟨1, 0, by rw [zpow_one, zpow_zero, mul_one]; exact hcase⟩
      have hrep : orbitRep (z' - p) = orbitRep (z - p) :=
        orbitRep_eq_of_sameOrbit hso.symm
      have hstep := label_step hb
        (show z' - p = zeta6 ^ (1 : ℤ) * seam ^ (0 : ℤ) * (z - p) by
          rw [zpow_one, zpow_zero, mul_one]; exact hcase)
        (label_spec (z - p)) (hrep ▸ label_spec (z' - p))
      simp only [rawColour, if_pos h1, if_pos h2]
      rw [hstep.2]
      push_cast
      exact (outerTable_step _).symm
    · have hso : SameOrbit (z - p) (z' - p) :=
        ⟨-1, 0, by rw [zpow_neg, zpow_one, zpow_zero, mul_one]; exact hcase⟩
      have hrep : orbitRep (z' - p) = orbitRep (z - p) :=
        orbitRep_eq_of_sameOrbit hso.symm
      have hstep := label_step hb
        (show z' - p = zeta6 ^ (-1 : ℤ) * seam ^ (0 : ℤ) * (z - p) by
          rw [zpow_neg, zpow_one, zpow_zero, mul_one]; exact hcase)
        (label_spec (z - p)) (hrep ▸ label_spec (z' - p))
      simp only [rawColour, if_pos h1, if_pos h2]
      rw [hstep.2]
      push_cast
      have hstepped := outerTable_step (((label (z - p)).1 : ZMod 6) - 1)
      rw [sub_add_cancel] at hstepped
      rw [← sub_eq_add_neg]
      exact hstepped
  · -- outer–inner: the seam step
    have hzin : dist z' p = Real.sqrt 3 / 3 := hz'.resolve_left h2
    have hw : ‖z - p‖ = 1 := norm_outer_phase h1
    have hv' : ‖(Real.sqrt 3 : ℂ) * (z' - p)‖ = 1 := norm_inner_phase hzin
    have hcross : ‖(Real.sqrt 3 : ℂ)⁻¹ * ((Real.sqrt 3 : ℂ) * (z' - p)) - (z - p)‖ = 1 := by
      rw [inv_mul_cancel_left₀ sqrt3_complex_ne_zero,
        show (z' - p) - (z - p) = z' - z by ring, norm_sub_rev, ← Complex.dist_eq]
      exact hd
    have hw0 : z - p ≠ 0 := fun h0 => by rw [h0, norm_zero] at hw; norm_num at hw
    have hb : orbitRep (z - p) ≠ 0 := orbitRep_ne_zero hw0
    rcases ratio_of_cross_chord hw hv' hcross with hcase | hcase
    · have hso : SameOrbit (z - p) ((Real.sqrt 3 : ℂ) * (z' - p)) :=
        ⟨0, 1, by rw [zpow_zero, zpow_one, one_mul]; exact hcase⟩
      have hrep := orbitRep_eq_of_sameOrbit hso.symm
      have hstep := label_step hb
        (show (Real.sqrt 3 : ℂ) * (z' - p) = zeta6 ^ (0 : ℤ) * seam ^ (1 : ℤ) * (z - p) by
          rw [zpow_zero, zpow_one, one_mul]; exact hcase)
        (label_spec (z - p)) (hrep ▸ label_spec _)
      simp only [rawColour, if_pos h1, if_neg h2]
      rw [hstep.2]
      push_cast
      rw [add_zero]
      exact outerTable_ne_innerTable _
    · have hso : SameOrbit (z - p) ((Real.sqrt 3 : ℂ) * (z' - p)) :=
        ⟨0, -1, by rw [zpow_zero, zpow_neg, zpow_one, one_mul]; exact hcase⟩
      have hrep := orbitRep_eq_of_sameOrbit hso.symm
      have hstep := label_step hb
        (show (Real.sqrt 3 : ℂ) * (z' - p) = zeta6 ^ (0 : ℤ) * seam ^ (-1 : ℤ) * (z - p) by
          rw [zpow_zero, zpow_neg, zpow_one, one_mul]; exact hcase)
        (label_spec (z - p)) (hrep ▸ label_spec _)
      simp only [rawColour, if_pos h1, if_neg h2]
      rw [hstep.2]
      push_cast
      rw [add_zero]
      exact outerTable_ne_innerTable _
  · -- inner–outer: the seam step, read from the other side
    have hzin : dist z p = Real.sqrt 3 / 3 := hz.resolve_left h1
    have hv : ‖(Real.sqrt 3 : ℂ) * (z - p)‖ = 1 := norm_inner_phase hzin
    have hw' : ‖z' - p‖ = 1 := norm_outer_phase h2
    have hcross : ‖(Real.sqrt 3 : ℂ)⁻¹ * ((Real.sqrt 3 : ℂ) * (z - p)) - (z' - p)‖ = 1 := by
      rw [inv_mul_cancel_left₀ sqrt3_complex_ne_zero,
        show (z - p) - (z' - p) = z - z' by ring, ← Complex.dist_eq]
      exact hd
    have hw0 : z' - p ≠ 0 := fun h0 => by rw [h0, norm_zero] at hw'; norm_num at hw'
    have hb : orbitRep (z' - p) ≠ 0 := orbitRep_ne_zero hw0
    rcases ratio_of_cross_chord hw' hv hcross with hcase | hcase
    · have hso : SameOrbit (z' - p) ((Real.sqrt 3 : ℂ) * (z - p)) :=
        ⟨0, 1, by rw [zpow_zero, zpow_one, one_mul]; exact hcase⟩
      have hrep := orbitRep_eq_of_sameOrbit hso.symm
      have hstep := label_step hb
        (show (Real.sqrt 3 : ℂ) * (z - p) = zeta6 ^ (0 : ℤ) * seam ^ (1 : ℤ) * (z' - p) by
          rw [zpow_zero, zpow_one, one_mul]; exact hcase)
        (label_spec (z' - p)) (hrep ▸ label_spec _)
      simp only [rawColour, if_neg h1, if_pos h2]
      rw [hstep.2]
      push_cast
      rw [add_zero]
      exact (outerTable_ne_innerTable _).symm
    · have hso : SameOrbit (z' - p) ((Real.sqrt 3 : ℂ) * (z - p)) :=
        ⟨0, -1, by rw [zpow_zero, zpow_neg, zpow_one, one_mul]; exact hcase⟩
      have hrep := orbitRep_eq_of_sameOrbit hso.symm
      have hstep := label_step hb
        (show (Real.sqrt 3 : ℂ) * (z - p) = zeta6 ^ (0 : ℤ) * seam ^ (-1 : ℤ) * (z' - p) by
          rw [zpow_zero, zpow_neg, zpow_one, one_mul]; exact hcase)
        (label_spec (z' - p)) (hrep ▸ label_spec _)
      simp only [rawColour, if_neg h1, if_pos h2]
      rw [hstep.2]
      push_cast
      rw [add_zero]
      exact (outerTable_ne_innerTable _).symm
  · -- inner–inner: a 120° step
    have hzin : dist z p = Real.sqrt 3 / 3 := hz.resolve_left h1
    have hzin' : dist z' p = Real.sqrt 3 / 3 := hz'.resolve_left h2
    have hv : ‖(Real.sqrt 3 : ℂ) * (z - p)‖ = 1 := norm_inner_phase hzin
    have hv' : ‖(Real.sqrt 3 : ℂ) * (z' - p)‖ = 1 := norm_inner_phase hzin'
    have hchord : ‖(Real.sqrt 3 : ℂ) * (z' - p) - (Real.sqrt 3 : ℂ) * (z - p)‖
        = Real.sqrt 3 := by
      rw [show (Real.sqrt 3 : ℂ) * (z' - p) - (Real.sqrt 3 : ℂ) * (z - p)
          = (Real.sqrt 3 : ℂ) * (z' - z) by ring, norm_mul, Complex.norm_real,
        Real.norm_of_nonneg (Real.sqrt_nonneg 3), norm_sub_rev, ← Complex.dist_eq, hd,
        mul_one]
    have hv0 : (Real.sqrt 3 : ℂ) * (z - p) ≠ 0 := fun h0 => by
      rw [h0, norm_zero] at hv
      norm_num at hv
    have hb : orbitRep ((Real.sqrt 3 : ℂ) * (z - p)) ≠ 0 := orbitRep_ne_zero hv0
    rcases ratio_of_sqrt3_chord hv hv' hchord with hcase | hcase
    · have hso : SameOrbit ((Real.sqrt 3 : ℂ) * (z - p)) ((Real.sqrt 3 : ℂ) * (z' - p)) :=
        ⟨2, 0, by
          rw [zpow_zero, mul_one, show (2 : ℤ) = ((2 : ℕ) : ℤ) by rfl, zpow_natCast]
          exact hcase⟩
      have hrep := orbitRep_eq_of_sameOrbit hso.symm
      have hstep := label_step hb
        (show (Real.sqrt 3 : ℂ) * (z' - p)
            = zeta6 ^ (2 : ℤ) * seam ^ (0 : ℤ) * ((Real.sqrt 3 : ℂ) * (z - p)) by
          rw [zpow_zero, mul_one, show (2 : ℤ) = ((2 : ℕ) : ℤ) by rfl, zpow_natCast]
          exact hcase)
        (label_spec _) (hrep ▸ label_spec _)
      simp only [rawColour, if_neg h1, if_neg h2]
      rw [hstep.2]
      push_cast
      exact (innerTable_step _).symm
    · have hso : SameOrbit ((Real.sqrt 3 : ℂ) * (z - p)) ((Real.sqrt 3 : ℂ) * (z' - p)) :=
        ⟨-2, 0, by
          rw [zpow_zero, mul_one, zpow_neg, show (2 : ℤ) = ((2 : ℕ) : ℤ) by rfl,
            zpow_natCast]
          exact hcase⟩
      have hrep := orbitRep_eq_of_sameOrbit hso.symm
      have hstep := label_step hb
        (show (Real.sqrt 3 : ℂ) * (z' - p)
            = zeta6 ^ (-2 : ℤ) * seam ^ (0 : ℤ) * ((Real.sqrt 3 : ℂ) * (z - p)) by
          rw [zpow_zero, mul_one, zpow_neg, show (2 : ℤ) = ((2 : ℕ) : ℤ) by rfl,
            zpow_natCast]
          exact hcase)
        (label_spec _) (hrep ▸ label_spec _)
      simp only [rawColour, if_neg h1, if_neg h2]
      rw [hstep.2]
      push_cast
      have hstepped := innerTable_step (((label ((Real.sqrt 3 : ℂ) * (z - p))).1 : ZMod 6) - 2)
      rw [sub_add_cancel] at hstepped
      rw [show ((label ((Real.sqrt 3 : ℂ) * (z - p))).1 : ZMod 6) + (-2)
          = ((label ((Real.sqrt 3 : ℂ) * (z - p))).1 : ZMod 6) - 2 by ring]
      exact hstepped

/-! ### The theorem -/

/-- **The two-circle theorem, induced form.** The unit-distance graph on the *entire* union
of the two spheres about `p` — all of both circles, uncountably many points — is
3-colourable. -/
theorem colorable_three_induce (p : ℂ) :
    ((unitDistance ℂ).induce
      (Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3))).Colorable 3 := by
  refine ⟨SimpleGraph.Coloring.mk (fun z => rawColour p (z : ℂ)) ?_⟩
  intro a b hab
  exact rawColour_ne_of_edge a.2 b.2 (unitDistance_adj.mp hab)

/-- **The two-circle theorem, mapped form** — the shape a cover-set application consumes:
any family of points on the two circles about `p`, however indexed, spans a 3-colourable
unit-distance graph. Derived from the induced form by factoring `f` through the union. -/
theorem colorable_three_comap {ι : Type*} (f : ι → ℂ) (p : ℂ)
    (hf : ∀ v, f v ∈ Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3)) :
    ((unitDistance ℂ).comap f).Colorable 3 := by
  refine ⟨SimpleGraph.Coloring.mk (fun v => rawColour p (f v)) ?_⟩
  intro a b hab
  exact rawColour_ne_of_edge (hf a) (hf b) (unitDistance_adj.mp hab)

/-! ## Specification

Non-vacuity of the chord hypotheses, and the barrier's teeth: the theorem refutes any
four-point pairwise-unit configuration on the two circles. -/

/-- The unit chord is realized: `zeta6` itself sits one unit from `1` on the unit circle —
the hypothesis of `ratio_of_unit_chord` is inhabited. -/
example : ‖zeta6 - 1‖ = 1 := by
  have h : normSq (zeta6 - 1) = 1 := by
    simp only [normSq_apply, zeta6, sub_re, sub_im, Complex.one_re, Complex.one_im]
    nlinarith [sq_sqrt3]
  rw [Complex.norm_def, h, Real.sqrt_one]

/-- **The barrier's teeth**: no four points of the two circles about `p` are pairwise a unit
apart — a `K₄` would need four colours, and the mapped two-circle theorem grants three. -/
example (p : ℂ) : ¬ ∃ f : Fin 4 → ℂ,
    (∀ v, f v ∈ Metric.sphere p 1 ∪ Metric.sphere p (Real.sqrt 3 / 3)) ∧
    ∀ v w, v ≠ w → dist (f v) (f w) = 1 := by
  rintro ⟨f, hf, hunit⟩
  obtain ⟨C⟩ := colorable_three_comap f p hf
  have hpair : ∃ v w : Fin 4, v ≠ w ∧ C v = C w := by
    by_contra hno
    push Not at hno
    have hinj : Function.Injective C := fun v w hEq => by
      by_contra hne
      exact hno v w hne hEq
    have hcard := Fintype.card_le_of_injective C hinj
    simp at hcard
  obtain ⟨v, w, hvw, hCvw⟩ := hpair
  exact C.valid (hunit v w hvw) hCvw

-- Negative control (make the gate fail): one entry of the inner table perturbed, and the
-- 120° step breaks — `decide` names the refutation. The tables are discriminating data.
/--
error: Tactic `decide` proved that the proposition
  ∀ (i : ZMod 6), innerTable (i + 2) ≠ ![0, 1, 1, 1, 2, 2] i
is false
-/
#guard_msgs in
example : ∀ i : ZMod 6, innerTable (i + 2) ≠ ![0, 1, 1, 1, 2, 2] i := by decide +revert

-- Companion control (M20, suggested by a reviewer instance): the outer table is rainbow,
-- not alternating, because three outer colours are *forced* — a 2-coloured outer table
-- dies at the seam. The alternating candidate satisfies the 60° steps yet clashes with
-- the inner table at equal label, exactly where cross chords land.
private def altTable : ZMod 6 → Fin 3 := ![0, 1, 0, 1, 0, 1]

example : ∀ i : ZMod 6, altTable (i + 1) ≠ altTable i := by decide +revert
example : ¬ ∀ i : ZMod 6, altTable i ≠ innerTable i := by decide

end TwoCircle
end HadwigerNelson
