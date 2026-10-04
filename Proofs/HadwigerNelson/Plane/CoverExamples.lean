import Proofs.HadwigerNelson.Plane.MaximalCover
import Proofs.HadwigerNelson.Plane.Slack
import Mathlib.Analysis.Convex.Hull
import Mathlib.Topology.MetricSpace.HausdorffDistance
import Mathlib.Data.Rat.Denumerable
import Mathlib.Data.Rat.Floor

/-!
# The example colourings, covers and classes (FS-131 wave 2)

Rows: **FS111-W-SQ9**, **FS111-M-R7**, **FS111-M2-DISC7**, **FS111-M3-BAND**, **FS111-M3-HC**, **FS111-M3-IRREG**,
**FS111-M3-FIXCONV**. Plan: `plans/FS131-w2-kernel-plan.md` §§ 4, 7. Every object is defined by formula, sorry-free; the rows'
content is in the theorems.

* **The triangular lattice** `tri m n = m + n ω`, `ω = e(π/3)`, carries all three periodic objects: R7's tiles sit on it, DISC7's
  centres are `(√3/2) · tri`, HC's face centres `L√3 e(π/6) · tri`.
* **R7** (`plans/FS111-M-regularity.md` § 2.4) is a colouring, given in lattice coordinates `z = a + b ω`: the rhombus cell
  `(⌊a⌋, ⌊b⌋)` splits into the up triangle `u + v ≤ 1` and the down triangle; a point is in the Reuleaux triangle `U(m, n)` iff
  it is within `1` of all three of its vertices, and inside the cell's down triangle only the far vertex can fail — so the colour is
  read from three quadratic tests `|w|² = a² + ab + b²` against the far vertices `λ`, `λ + 2`, `λ + 2ω`.
* **DISC7** (`plans/FS111-M2-regularity.md` § 1.6) is a cover with overlaps: a family of unions of closed discs.
* **HC** (`plans/FS111-M3-finiteness.md` § 1.6) is one class, parametrized by a gap function `g`: down triangles, up triangles
  cut by the graph `t = 2 + g(s)` in each of their three edge frames, the bands `{|s| < 1/2, 1 < t < ℓ(s)}` and the face discs.
  `G1Bounds Z g` is (G1) as the proofs read it; `hcGap Z` is § 1.6's formula; `fatZ` is a closed nowhere dense set of positive
  length containing `±1/2` (the complement of small intervals about an enumeration of `ℚ`), the fat set FS111-M3-IRREG needs.

FS111-W-SQ9's colouring is by **closed** squares; `sq9` (`Plane/Cover`) uses half-open squares, which differ from it on the
null grid only, and tightness and saturation read densities alone, so they are the same statements.
-/

namespace HadwigerNelson.Plane

open Complex Real Set MeasureTheory Filter Topology Metric

/-! ## FS111-W-SQ9 -/

/-- **FS111-W-SQ9**: the half-square nine-colouring is a.e.-proper (it is `sq9 : AeColouring 9`), tight, saturated, and
saturated with positive-density partners. -/
theorem sq9_tight_saturated : sq9.Tight ∧ Saturated sq9.cls ∧ SaturatedPos sq9.cls := by
  sorry

/-! ## The triangular lattice -/

/-- The point `m + n ω` of the unit triangular lattice `Λ = ℤ[ω]`, `ω = e(π/3)`. -/
noncomputable def tri (m n : ℤ) : ℂ := m + n * e (π / 3)

/-- Lattice coordinates: `z = a + b ω` with `(a, b) = triCoord z`. -/
noncomputable def triCoord (z : ℂ) : ℝ × ℝ := (z.re - z.im / √3, 2 * z.im / √3)

/-- The squared norm of `a + b ω`. -/
def triQ (a b : ℝ) : ℝ := a ^ 2 + a * b + b ^ 2

theorem e_pi_div_three : e (π / 3) = (1 / 2 : ℂ) + ((√3 / 2 : ℝ) : ℂ) * I := by
  rw [e_eq, Real.cos_pi_div_three, Real.sin_pi_div_three]; push_cast; ring

/-- `triCoord` inverts `(a, b) ↦ a + b ω`. -/
theorem triCoord_add_mul (a b : ℝ) : triCoord ((a : ℂ) + b * e (π / 3)) = (a, b) := by
  have h3 : (√3 : ℝ) ≠ 0 := by positivity
  rw [e_pi_div_three, triCoord]
  simp only [add_re, ofReal_re, mul_re, ofReal_im, I_re, I_im, add_im, mul_im, Prod.mk.injEq]
  norm_num
  constructor <;> field_simp
  ring

/-- `‖a + b ω‖² = a² + ab + b²`. -/
theorem normSq_add_mul (a b : ℝ) : normSq ((a : ℂ) + b * e (π / 3)) = triQ a b := by
  rw [e_pi_div_three, normSq_apply, triQ]
  simp only [add_re, ofReal_re, mul_re, ofReal_im, I_re, I_im, add_im, mul_im]
  have : (√3 : ℝ) ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  norm_num
  nlinarith [this]

/-! ## FS111-M-R7: the Reuleaux seven-colouring -/

/-- The up tile `U(m, n)`'s colour: the coset of `λ = m + nω` mod `2Λ`, `2(m mod 2) + (n mod 2)`. -/
def r7UpCol (m n : ℤ) : Fin 7 := ⟨2 * (m % 2).toNat + (n % 2).toNat, by omega⟩

/-- The down tile `D(m, n)`'s colour: `4 + ((m − n) mod 3)`, the coset of `λ` mod `M = {m ≡ n (mod 3)}`. -/
def r7DownCol (m n : ℤ) : Fin 7 := ⟨4 + ((m - n) % 3).toNat, by omega⟩

/-- R7 in lattice coordinates. In the cell `(m, n) = (⌊a⌋, ⌊b⌋)` with fractional part `(u, v)`: within `1` of `λ` is `U(m, n)`
(which holds on the whole up triangle `u + v ≤ 1`), within `1` of `λ + 2` is `U(m + 1, n)`'s bulge, within `1` of `λ + 2ω` is
`U(m, n + 1)`'s bulge, and the rest is the cusped down tile `D(m, n)`. -/
noncomputable def r7ColTri (a b : ℝ) : Fin 7 :=
  let m := ⌊a⌋
  let n := ⌊b⌋
  let u := a - m
  let v := b - n
  if triQ u v ≤ 1 then r7UpCol m n
  else if triQ (u - 2) v ≤ 1 then r7UpCol (m + 1) n
  else if triQ u (v - 2) ≤ 1 then r7UpCol m (n + 1)
  else r7DownCol m n

/-- **R7**, the colouring of the plane (`[Polymath16threads]` thread 4; `plans/FS111-M-regularity.md` § 2.4). -/
noncomputable def r7Col (z : ℂ) : Fin 7 := r7ColTri (triCoord z).1 (triCoord z).2

/-- R7's classes, as a family. -/
def r7Cls (j : Fin 7) : Set ℂ := r7Col ⁻¹' {j}

/-- R7 at a point given in lattice coordinates. -/
theorem r7Col_add_mul (a b : ℝ) : r7Col ((a : ℂ) + b * e (π / 3)) = r7ColTri a b := by
  rw [r7Col, triCoord_add_mul]

/-! ### Spec examples (each fails if a colour, a test or a centre drifts) -/

/-- The centroid of `U(0, 0)` has colour `0`. -/
example : r7ColTri (1 / 3) (1 / 3) = 0 := by
  norm_num [r7ColTri, triQ, r7UpCol]

/-- The centroid of `D(0, 0)` has colour `4`. -/
example : r7ColTri (2 / 3) (2 / 3) = 4 := by
  norm_num [r7ColTri, triQ, r7DownCol]; rfl

/-- A point of the down half of cell `(0, 0)` inside `U(0, 0)`'s bulge has `U(0, 0)`'s colour (the Reuleaux test). -/
example : r7ColTri (11 / 20) (11 / 20) = 0 := by
  norm_num [r7ColTri, triQ, r7UpCol]

/-- `U(1, 0)` has colour `2` and `D(1, 0)` colour `5`. -/
example : r7ColTri (4 / 3) (1 / 3) = 2 ∧ r7ColTri (5 / 3) (2 / 3) = 5 := by
  constructor <;> norm_num [r7ColTri, triQ, r7UpCol, r7DownCol] <;> rfl

/-- A point in the cusp of `D(0, 0)` at the vertex `1`, outside both bulges by a hair, has the down colour. -/
example : r7ColTri (99 / 100) (1 / 50) = 4 := by
  norm_num [r7ColTri, triQ, r7DownCol]; rfl

/-! ### The row -/

/-- **FS111-M-R7**, a.e.-properness: R7 is a measurable seven-colouring with null monochromatic unit pairs. -/
theorem r7_aeColouring : ∃ c : AeColouring 7, c.col = r7Col := by
  sorry

/-- **FS111-M-R7**, tightness: at every `ε > 0` some class has non-null pairs at distances in `[1 − ε, 1 + ε]` (the
within-contacts of every up tile, vertex to opposite arc). -/
theorem r7_not_bandNull {ε : ℝ} (hε : 0 < ε) : ∃ j, ¬ BandNull (r7Cls j) ε := by
  sorry

/-- **FS111-M-R7**, saturation: every essential boundary point of a class is a contact point of that class. -/
theorem r7Cls_saturated : Saturated r7Cls := by
  sorry

/-- **FS111-M-R7**, first three clauses: R7 is a.e.-proper, tight and saturated. -/
theorem exists_r7 : ∃ c : AeColouring 7, c.col = r7Col ∧ c.Tight ∧ Saturated c.cls := by
  obtain ⟨c, hc⟩ := r7_aeColouring
  have hcls : c.cls = r7Cls := by funext j; simp [AeColouring.cls, r7Cls, hc]
  refine ⟨c, hc, fun ε hε hs => ?_, hcls ▸ r7Cls_saturated⟩
  obtain ⟨j, hj⟩ := r7_not_bandNull hε
  exact hj (hcls ▸ hs j)

/-- **FS111-M-R7**, last clause: every boundary is a unit arc centred at a lattice point carrying both its side colours — a point
in the essential closure of two classes is at distance exactly `1` from a lattice point in the support of both. -/
theorem r7_boundary {x : ℂ} {a b : Fin 7} (hab : a ≠ b) (ha : x ∈ essClosure (r7Cls a))
    (hb : x ∈ essClosure (r7Cls b)) :
    ∃ m n : ℤ, dist x (tri m n) = 1 ∧ tri m n ∈ essSupport (r7Cls a) ∧ tri m n ∈ essSupport (r7Cls b) := by
  sorry

/-! ### R7 against FS111-M-COVER-SC's literal second clause (ruling: `plans/FS131-close-inventory.md` items 18–19) -/

/-- R7's classes are a maximal admissible cover (FS111-VMW-R7-MAX's last clause; not a backlog row, formalized here as the
counterexample's other half). -/
theorem r7Cls_isMaximalCover : IsMaximalCover r7Cls := by
  sorry

/-- Near the midpoint `e(π/6)` of the arc of `U(0, 0)` opposite `0`, the down class `4` lies below the lower unit arc
`t = 1 − √(1 − s²)` in the frame `(e(π/6), 2π/3)` (the disc about `0` above it). -/
theorem r7_lowerGraph : ∃ δ, IsLowerGraphOf (r7Cls 4) (e (π / 6)) (2 * π / 3) (Ioo (1 / 10) (1 / 5))
    (fun s => 1 - √(1 - s ^ 2)) δ := by
  sorry

/-- The lower unit arc is not semiconcave with constant `1` away from its bottom (its second derivative is `(1 − s²)^{−3/2} > 1`). -/
theorem not_semiconcaveWith_one_lowerArc :
    ¬ SemiconcaveWith 1 (fun s : ℝ => 1 - √(1 - s ^ 2)) (Ioo (1 / 10) (1 / 5)) := by
  intro h
  have h1 := h (3 / 20) (1 / 25) ⟨by norm_num, by norm_num⟩ ⟨by norm_num, by norm_num⟩ ⟨by norm_num, by norm_num⟩
  simp only at h1
  have hA : √(1 - (3 / 20 + 1 / 25 : ℝ) ^ 2) ≤ 9817841 / 10000000 :=
    Real.sqrt_le_iff.2 ⟨by norm_num, by norm_num⟩
  have hB : √(1 - (3 / 20 - 1 / 25 : ℝ) ^ 2) ≤ 2484829 / 2500000 :=
    Real.sqrt_le_iff.2 ⟨by norm_num, by norm_num⟩
  have hC : 9886859 / 10000000 ≤ √(1 - (3 / 20 : ℝ) ^ 2) :=
    Real.le_sqrt_of_sq_le (by norm_num)
  nlinarith [hA, hB, hC]

/-- **The literal second clause of FS111-M-COVER-SC is false** (the statement defect of inventory item 18), on R7: some maximal
cover has a class whose boundary is locally the graph of a continuous function, the class below it, that is not semiconcave
with constant `1`. -/
theorem not_forall_semiconcaveWith_one :
    ¬ ∀ (k : ℕ) (C : Fin k → Set ℂ), IsMaximalCover C → ∀ (a : Fin k) (z₀ : ℂ) (θ δ α β : ℝ) (u : ℝ → ℝ),
      ContinuousOn u (Ioo α β) → IsLowerGraphOf (C a) z₀ θ (Ioo α β) u δ → SemiconcaveWith 1 u (Ioo α β) := by
  intro h
  obtain ⟨δ, hδ⟩ := r7_lowerGraph
  refine not_semiconcaveWith_one_lowerArc (h 7 r7Cls r7Cls_isMaximalCover 4 _ _ δ _ _ _ ?_ hδ)
  exact (continuous_const.sub (continuous_const.sub (continuous_id.pow 2)).sqrt).continuousOn

/-! ## FS111-M2-DISC7: the disc seven-cover -/

/-- DISC7's centres, the hexagon centres `c(m, n) = m(√3/2, 0) + n(√3/4, 3/4) = (√3/2)(m + nω)`. -/
noncomputable def disc7Centre (m n : ℤ) : ℂ := ((√3 / 2 : ℝ) : ℂ) * tri m n

/-- The hexagonal seven-colouring's colour of the hexagon at `c(m, n)`: `(m + 3n) mod 7`. -/
def disc7Col (m n : ℤ) : Fin 7 := ⟨((m + 3 * n) % 7).toNat, by omega⟩

/-- **DISC7**: class `a` is the union of the closed discs of radius `1/2` about the centres of colour `a`. -/
def disc7 (a : Fin 7) : Set ℂ := ⋃ (m : ℤ) (n : ℤ) (_ : disc7Col m n = a), closedBall (disc7Centre m n) (1 / 2)

/-! ### Spec examples -/

/-- The colour lattice: `c(1, 2)` has colour `0`, like the origin, at distance `√21/2` (DISC7's same-colour minimum). -/
example : disc7Col 1 2 = disc7Col 0 0 ∧ dist (disc7Centre 1 2) (disc7Centre 0 0) = √21 / 2 := by
  refine ⟨rfl, ?_⟩
  have h : disc7Centre 1 2 - disc7Centre 0 0 =
      ((√3 / 2 : ℝ) : ℂ) * (((1 : ℝ) : ℂ) + ((2 : ℝ) : ℂ) * e (π / 3)) := by
    simp only [disc7Centre, tri]; push_cast; ring
  rw [dist_eq_norm, h, norm_mul, norm_real, Real.norm_eq_abs, abs_of_pos (by positivity), Complex.norm_def,
    normSq_add_mul, triQ, show (1 : ℝ) ^ 2 + 1 * 2 + 2 ^ 2 = 7 by norm_num, show (21 : ℝ) = 3 * 7 by norm_num,
    Real.sqrt_mul (by norm_num)]
  ring

/-- **Adversary**: neighbouring hexagons get different colours. -/
example : disc7Col 1 0 ≠ disc7Col 0 0 ∧ disc7Col 0 1 ≠ disc7Col 0 0 ∧ disc7Col 1 (-1) ≠ disc7Col 0 0 := by decide

/-- The origin lies in class `0`. -/
example : (0 : ℂ) ∈ disc7 0 :=
  mem_iUnion.2 ⟨0, mem_iUnion.2 ⟨0, mem_iUnion.2 ⟨rfl, by simp [disc7Centre, tri]⟩⟩⟩

/-! ### The row -/

/-- **FS111-M2-DISC7**, first clause: the discs form a maximal admissible seven-cover. -/
theorem disc7_isMaximalCover : IsMaximalCover disc7 := by
  sorry

/-- **FS111-M2-DISC7**: its classes are regular. -/
theorem disc7_isRegularMUA (a : Fin 7) : IsRegularMUA (disc7 a) := by
  sorry

/-- **FS111-M2-DISC7**: the overlaps (lenses) have positive measure — every two classes meet in positive measure (each disc meets
one disc of every other colour: the six neighbouring colour differences are `±1, ±2, ±3`). -/
theorem disc7_lens {a b : Fin 7} (hab : a ≠ b) : 0 < volume (disc7 a ∩ disc7 b) := by
  sorry

/-- **FS111-M2-DISC7**: each class has density `2π/(21√3)`. -/
theorem disc7_upperDensity (a : Fin 7) : upperDensity (disc7 a) = ENNReal.ofReal (2 * π / (21 * √3)) := by
  sorry

/-- **FS111-M2-DISC7**: the seven densities sum to Kershner's thinnest-covering density `2π/(3√3)` (the value; that it is the
thinnest covering density by equal discs is `[Kershner1939]`'s theorem and is not stated). -/
theorem disc7_sum_upperDensity : ∑ a, upperDensity (disc7 a) = ENNReal.ofReal (2 * π / (3 * √3)) := by
  simp only [disc7_upperDensity, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  rw [show ((7 : ℕ) : ENNReal) = ENNReal.ofReal 7 by simp, ← ENNReal.ofReal_mul (by norm_num)]
  congr 1
  field_simp
  ring

/-! ## FS111-M3-BAND: what a flat side needs -/

/-- **FS111-M3-BAND**, first clause, at the class its argument reads (wider; `plans/FS131-w2-kernel-plan.md` § 7): at a point `m`
of the boundary of a MUA set's support where the set fills the half-box behind `m` (in direction `−e θ`) and the support misses
the normal ray just beyond, the point `m + e θ` at distance exactly `1` along the outer normal is in the support. Applied at
every point of a flat side, it puts the class's material at distance `1` over the whole side, its middle half included; no
block, diameter bound or regularity is read. -/
theorem IsMUA.add_normal_mem_essSupport {A : Set ℂ} (hA : IsMUA A) {m : ℂ} {θ ε δ : ℝ} (hε : 0 < ε) (hδ : 0 < δ)
    (hin : volume (halfBox m θ ε \ A) = 0) (hout : ∀ τ : ℝ, 0 < τ → τ < δ → m + τ * e θ ∉ essSupport A) :
    m + e θ ∈ essSupport A := by
  sorry

/-- **FS111-M3-BAND**, second clause, its horn half: a band of length `ℓ` (its base segment `[p, p + ℓd]`) excludes the point at
offset `(x, w)` in its frame (`x` along the band past `p`, `w` across) iff the circle about it meets the segment, which past the
band's end (`x > ℓ`) is iff `x − √(1 − w²)` lies in `[0, ℓ]` — a window of horn offsets `x − ℓ` of length exactly `ℓ`. -/
theorem band_excludes_horn {p d : ℂ} (hd : ‖d‖ = 1) {ℓ x w : ℝ} (hℓ : 0 ≤ ℓ) (hx : ℓ < x) (hw : |w| ≤ 1) :
    (∃ y ∈ segment ℝ p (p + ℓ * d), dist (p + (x + w * I) * d) y = 1) ↔
      0 ≤ x - √(1 - w ^ 2) ∧ x - √(1 - w ^ 2) ≤ ℓ := by
  have key : ∀ s : ℝ, dist (p + (x + w * I) * d) (p + s * d) = √((x - s) ^ 2 + w ^ 2) := by
    intro s
    have : p + (x + w * I) * d - (p + s * d) = (((x - s : ℝ) : ℂ) + w * I) * d := by push_cast; ring
    rw [dist_eq_norm, this, norm_mul, hd, mul_one, Complex.norm_add_mul_I]
  have hseg : ∀ y, y ∈ segment ℝ p (p + ℓ * d) ↔ ∃ s ∈ Icc 0 ℓ, y = p + s * d := by
    intro y
    rw [segment_eq_image']
    constructor
    · rintro ⟨θ, ⟨h0, h1⟩, rfl⟩
      refine ⟨θ * ℓ, ⟨mul_nonneg h0 hℓ, by nlinarith⟩, ?_⟩
      simp only [add_sub_cancel_left, real_smul]; push_cast; ring
    · rintro ⟨s, ⟨h0, h1⟩, rfl⟩
      rcases hℓ.eq_or_lt with h | h
      · refine ⟨0, ⟨le_rfl, zero_le_one⟩, ?_⟩
        have : s = 0 := by linarith
        subst this; simp
      · refine ⟨s / ℓ, ⟨div_nonneg h0 hℓ, (div_le_one h).2 h1⟩, ?_⟩
        have hl : (ℓ : ℂ) ≠ 0 := by exact_mod_cast h.ne'
        simp only [add_sub_cancel_left, real_smul]; push_cast; field_simp
  have hw2 : 0 ≤ 1 - w ^ 2 := by nlinarith [abs_le.1 hw, sq_abs w]
  constructor
  · rintro ⟨y, hy, hd1⟩
    obtain ⟨s, ⟨h0, h1⟩, rfl⟩ := (hseg y).1 hy
    rw [key] at hd1
    have h2 : (x - s) ^ 2 + w ^ 2 = 1 := by
      have := Real.sqrt_eq_iff_mul_self_eq (by positivity) (by norm_num : (0 : ℝ) ≤ 1) |>.1 hd1
      nlinarith
    have h3 : x - s = √(1 - w ^ 2) := by
      have hpos : 0 < x - s := by linarith
      rw [eq_comm, Real.sqrt_eq_iff_mul_self_eq hw2 hpos.le]
      nlinarith
    constructor <;> linarith
  · rintro ⟨h0, h1⟩
    refine ⟨p + (x - √(1 - w ^ 2) : ℝ) * d, (hseg _).2 ⟨_, ⟨h0, h1⟩, rfl⟩, ?_⟩
    rw [key]
    have : x - (x - √(1 - w ^ 2)) = √(1 - w ^ 2) := by ring
    rw [this, Real.sq_sqrt hw2]; simp

/-- **FS111-M3-BAND**, second clause, its length half: a band of length `ℓ` whose points are pairwise at distances other than
`1` has `ℓ ≤ 1`. -/
theorem le_one_of_band_unitFree {p d : ℂ} (hd : ‖d‖ = 1) {ℓ : ℝ} {S : Set ℂ} (hS : ∀ s ∈ Ioo 0 ℓ, p + s * d ∈ S)
    (hfree : ∀ x ∈ S, ∀ y ∈ S, dist x y ≠ 1) : ℓ ≤ 1 := by
  by_contra hℓ
  push Not at hℓ
  have h1 := hS ((ℓ - 1) / 2) ⟨by linarith, by linarith⟩
  have h2 := hS ((ℓ + 1) / 2) ⟨by linarith, by linarith⟩
  refine hfree _ h1 _ h2 ?_
  rw [dist_eq_norm, show p + (((ℓ - 1) / 2 : ℝ) : ℂ) * d - (p + (((ℓ + 1) / 2 : ℝ) : ℂ) * d) = -d by push_cast; ring,
    norm_neg, hd]

/-- **FS111-M3-BAND**, third clause, its tight half (the frame of `plans/FS111-M3-finiteness.md` § 1.6: the side
`[−1/2, 1/2] × {0}`, the band's ends `(±1/2, 1)`): the apex at depth `√3/2` excludes the lower half of the band's vesica
(`|z − apex| ≥ 1`), with equality at exactly one point, `(0, 1 − √3/2)`. -/
theorem vesica_apex :
    (∀ z : ℂ, dist z (-1 / 2 + I) ≤ 1 → dist z (1 / 2 + I) ≤ 1 → z.im ≤ 1 → 1 ≤ dist z (-(√3 / 2 : ℝ) * I)) ∧
      {z : ℂ | dist z (-1 / 2 + I) ≤ 1 ∧ dist z (1 / 2 + I) ≤ 1 ∧ z.im ≤ 1 ∧ dist z (-(√3 / 2 : ℝ) * I) = 1} =
        {((1 - √3 / 2 : ℝ) : ℂ) * I} := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h3p : 0 < √3 := by positivity
  have hd1 : ∀ z : ℂ, dist z (-1 / 2 + I) = √((z.re + 1 / 2) ^ 2 + (z.im - 1) ^ 2) := fun z => by
    rw [Complex.dist_eq_re_im]; congr 1; simp; ring
  have hd2 : ∀ z : ℂ, dist z (1 / 2 + I) = √((z.re - 1 / 2) ^ 2 + (z.im - 1) ^ 2) := fun z => by
    rw [Complex.dist_eq_re_im]; congr 1; simp
  have hd3 : ∀ z : ℂ, dist z (-(√3 / 2 : ℝ) * I) = √(z.re ^ 2 + (z.im + √3 / 2) ^ 2) := fun z => by
    rw [Complex.dist_eq_re_im]; congr 1; simp
  -- the two constraints force `t = 1 - im ≤ √3/2`
  have key : ∀ z : ℂ, dist z (-1 / 2 + I) ≤ 1 → dist z (1 / 2 + I) ≤ 1 → z.im ≤ 1 →
      1 - z.im ≤ √3 / 2 ∧ 1 ≤ z.re ^ 2 + (z.im + √3 / 2) ^ 2 ∧
        (z.re ^ 2 + (z.im + √3 / 2) ^ 2 = 1 → z.re = 0 ∧ z.im = 1 - √3 / 2) := by
    intro z a b c
    rw [hd1, Real.sqrt_le_iff] at a
    rw [hd2, Real.sqrt_le_iff] at b
    obtain ⟨-, a⟩ := a
    obtain ⟨-, b⟩ := b
    have hsum : z.re ^ 2 + (z.im - 1) ^ 2 ≤ 3 / 4 := by nlinarith
    have ht : 1 - z.im ≤ √3 / 2 := by
      by_contra hcon
      push Not at hcon
      nlinarith [sq_nonneg z.re]
    refine ⟨ht, ?_, fun heq => ?_⟩
    · nlinarith [sq_nonneg z.re]
    · have hre : z.re = 0 := by nlinarith [sq_nonneg z.re, sq_nonneg (1 - z.im - √3 / 2)]
      refine ⟨hre, ?_⟩
      nlinarith [sq_nonneg z.re, sq_nonneg (1 - z.im - √3 / 2)]
  refine ⟨fun z a b c => ?_, ?_⟩
  · obtain ⟨-, h1, -⟩ := key z a b c
    rw [hd3]; exact Real.le_sqrt_of_sq_le (by nlinarith)
  · ext z
    simp only [mem_setOf_eq, mem_singleton_iff]
    constructor
    · rintro ⟨a, b, c, d⟩
      rw [hd3] at d
      have d' : z.re ^ 2 + (z.im + √3 / 2) ^ 2 = 1 := by
        have := Real.sqrt_eq_iff_mul_self_eq (by positivity) (by norm_num : (0 : ℝ) ≤ 1) |>.1 d
        nlinarith
      obtain ⟨-, -, h3'⟩ := key z a b c
      obtain ⟨hre, him⟩ := h3' d'
      apply Complex.ext <;> simp [hre, him]
    · rintro rfl
      refine ⟨?_, ?_, ?_, ?_⟩
      · rw [hd1, Real.sqrt_le_iff]; refine ⟨by norm_num, ?_⟩; simp; nlinarith
      · rw [hd2, Real.sqrt_le_iff]; refine ⟨by norm_num, ?_⟩; simp; nlinarith
      · simp; linarith
      · rw [hd3, Real.sqrt_eq_iff_mul_self_eq (by positivity) (by norm_num : (0 : ℝ) ≤ 1)]
        simp

/-- **FS111-M3-BAND**, third clause, its exact half: an apex at any smaller depth `0 ≤ h < √3/2` fails to exclude some point of the
open vesica below the band. -/
theorem vesica_apex_exact {h : ℝ} (h0 : 0 ≤ h) (hh : h < √3 / 2) :
    ∃ z : ℂ, dist z (-1 / 2 + I) < 1 ∧ dist z (1 / 2 + I) < 1 ∧ z.im < 1 ∧ dist z (-(h : ℂ) * I) < 1 := by
  have h3 : √3 * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  have h3p : 0 < √3 := by positivity
  set η : ℝ := (√3 / 2 - h) / 2 with hη
  have hη0 : 0 < η := by rw [hη]; linarith
  have hη1 : η ≤ √3 / 4 := by rw [hη]; linarith
  refine ⟨((1 - √3 / 2 + η : ℝ) : ℂ) * I, ?_, ?_, ?_, ?_⟩
  · rw [Complex.dist_eq_re_im, Real.sqrt_lt' one_pos]; simp; nlinarith
  · rw [Complex.dist_eq_re_im, Real.sqrt_lt' one_pos]; simp; nlinarith
  · simp; linarith
  · rw [Complex.dist_eq_re_im, Real.sqrt_lt' one_pos]; simp
    rw [abs_lt]; constructor <;> nlinarith

/-! ## FS111-M3-HC: the honeycomb class -/

/-- `L = 2 + √3/3`, the honeycomb's edge (twice the inradius `√3/6`, plus `2`). -/
noncomputable def hcL : ℝ := 2 + √3 / 3

/-- The face centres: the triangular lattice spanned by `L(3/2, √3/2) = L√3 e(π/6)` and `L(0, √3) = L√3 e(π/6) ω`. -/
noncomputable def hcFace (m n : ℤ) : ℂ := ((hcL * √3 : ℝ) : ℂ) * e (π / 6) * tri m n

/-- The up centroids `O + L` (one coset of the face lattice); their triangles' vertices point along `e(π/3), e(π), e(5π/3)`. -/
noncomputable def hcUpC (m n : ℤ) : ℂ := hcFace m n + hcL

/-- The down centroids `O + L e(π/3)`; their triangles' vertices point along `e(0), e(2π/3), e(4π/3)`. -/
noncomputable def hcDownC (m n : ℤ) : ℂ := hcFace m n + hcL * e (π / 3)

/-- The up triangle of side `1` (circumradius `1/√3`) at `hcUpC m n`, its vertices pointing at its three face centres. -/
noncomputable def hcUpTri (m n : ℤ) : Set ℂ :=
  convexHull ℝ {hcUpC m n + e (π / 3) / √3, hcUpC m n + e π / √3, hcUpC m n + e (5 * π / 3) / √3}

/-- The down triangle of side `1` at `hcDownC m n`. -/
noncomputable def hcDownTri (m n : ℤ) : Set ℂ :=
  convexHull ℝ {hcDownC m n + e 0 / √3, hcDownC m n + e (2 * π / 3) / √3, hcDownC m n + e (4 * π / 3) / √3}

/-- The frame of the edge from the up centroid `C = hcUpC m n` in direction `w = e(2πj/3)` to its down neighbour `C + Lw`:
`(s, t) ↦ C + ((L − √3/6 − t) − s i) w`. The down triangle's facing side is `t = 0`, the segment `σ_e` is `t = 1`, the up
triangle's facing side is `t = 2`, all for `|s| ≤ 1/2`. -/
noncomputable def hcFrame (m n : ℤ) (j : Fin 3) (s t : ℝ) : ℂ :=
  hcUpC m n + (((hcL - √3 / 6 - t : ℝ) : ℂ) - s * I) * e (2 * π * (j : ℕ) / 3)

/-- The frame coordinate `s` of a point. -/
noncomputable def hcFrameS (m n : ℤ) (j : Fin 3) (z : ℂ) : ℝ := -((z - hcUpC m n) / e (2 * π * (j : ℕ) / 3)).im

/-- The frame coordinate `t` of a point. -/
noncomputable def hcFrameT (m n : ℤ) (j : Fin 3) (z : ℂ) : ℝ :=
  hcL - √3 / 6 - ((z - hcUpC m n) / e (2 * π * (j : ℕ) / 3)).re

/-- The up triangle cut by the gap function: `U = {z ∈ T_up : t ≥ 2 + g(s)` in each of its three edge frames`}`. -/
def hcUp (g : ℝ → ℝ) (m n : ℤ) : Set ℂ :=
  {z | z ∈ hcUpTri m n ∧ ∀ j : Fin 3, 2 + g (hcFrameS m n j z) ≤ hcFrameT m n j z}

/-- `ℓ(s) = inf {t : d_U(s, t) ≤ 1}`, the lower unit parallel of `U` in the edge's frame. -/
noncomputable def hcBandTop (g : ℝ → ℝ) (m n : ℤ) (j : Fin 3) (s : ℝ) : ℝ :=
  sInf {t | infDist (hcFrame m n j s t) (hcUp g m n) ≤ 1}

/-- The band `Λ_e = {(s, t) : |s| < 1/2, 1 < t < ℓ(s)}`. -/
def hcBand (g : ℝ → ℝ) (m n : ℤ) (j : Fin 3) : Set ℂ :=
  {z | ∃ s t : ℝ, |s| < 1 / 2 ∧ 1 < t ∧ t < hcBandTop g m n j s ∧ z = hcFrame m n j s t}

/-- **HC**: the down triangles, the cut up triangles, the closed bands and the face discs of radius `1/2`. -/
def hcSet (g : ℝ → ℝ) : Set ℂ :=
  (⋃ (m : ℤ) (n : ℤ), hcDownTri m n) ∪ (⋃ (m : ℤ) (n : ℤ), hcUp g m n) ∪
    (⋃ (m : ℤ) (n : ℤ) (j : Fin 3), closure (hcBand g m n j)) ∪ ⋃ (m : ℤ) (n : ℤ), closedBall (hcFace m n) (1 / 2)

/-- **(G1)**, as the proofs of FS111-M3-HC and FS111-M3-IRREG read it (`plans/FS111-M3-finiteness.md` § 2.2): on `[−1/2, 1/2]`,
`0 ≤ g ≤ dist(·, Z)²/4`, `|g′| ≤ dist(·, Z)/2`, `g ≤ 1/64`, `|g′| ≤ 1/8`, `g > 0` off `Z`, and the lower-parabola bound
`g(s) ≥ g(σ) + g′(σ)(s − σ) − (s − σ)²/4` — the only use of the derivation's `|g″| ≤ 1/2`, stated in its place (wider). -/
def G1Bounds (Z : Set ℝ) (g : ℝ → ℝ) : Prop :=
  Differentiable ℝ g ∧
    (∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), 0 ≤ g s ∧ g s ≤ infDist s Z ^ 2 / 4 ∧ |deriv g s| ≤ infDist s Z / 2 ∧
      g s ≤ 1 / 64 ∧ |deriv g s| ≤ 1 / 8) ∧
    (∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), s ∉ Z → 0 < g s) ∧
    ∀ s ∈ Icc (-1 / 2 : ℝ) (1 / 2), ∀ σ ∈ Icc (-1 / 2 : ℝ) (1 / 2), g σ + deriv g σ * (s - σ) - (s - σ) ^ 2 / 4 ≤ g s

open scoped Classical in
/-- § 1.6's gap function: `(s − a)²(b − s)²/4` on each gap `(a, b)` of `Z` in `[−1/2, 1/2]`, and `0` elsewhere. -/
noncomputable def hcGap (Z : Set ℝ) (s : ℝ) : ℝ :=
  if s ∈ Icc (-1 / 2 : ℝ) (1 / 2) ∧ s ∉ Z then (s - sSup (Z ∩ Iic s)) ^ 2 * (sInf (Z ∩ Ici s) - s) ^ 2 / 4 else 0

/-! ### Spec examples -/

/-- The face lattice's spacing is `L√3 = 2√3 + 1`. -/
example : dist (hcFace 1 0) (hcFace 0 0) = 2 * √3 + 1 := by
  have h3 : (√3 : ℝ) * √3 = 3 := Real.mul_self_sqrt (by norm_num)
  rw [dist_eq_norm, hcFace, hcFace, tri, tri]
  simp only [Int.cast_one, Int.cast_zero, zero_mul, add_zero, mul_zero, sub_zero, mul_one, norm_mul, norm_e,
    norm_real, Real.norm_eq_abs]
  rw [abs_of_pos (by unfold hcL; positivity), abs_of_pos (by positivity)]
  unfold hcL; nlinarith [h3]

/-- The up triangle's vertex toward its face centre `O` is at distance `L − 1/√3 = 2` from `O`. -/
example (m n : ℤ) : dist (hcUpC m n + e π / √3) (hcFace m n) = 2 := by
  have he : e π = -1 := by simp [e, Complex.exp_pi_mul_I]
  have h3 : (√3 : ℝ) ≠ 0 := by positivity
  rw [hcUpC, he, dist_eq_norm, show hcFace m n + (hcL : ℂ) + -1 / (√3 : ℂ) - hcFace m n = ((hcL - 1 / √3 : ℝ) : ℂ) by
    push_cast; ring, norm_real, Real.norm_eq_abs]
  unfold hcL
  rw [show (2 : ℝ) + √3 / 3 - 1 / √3 = 2 by field_simp; ring_nf; rw [Real.sq_sqrt (by norm_num)]; ring]
  norm_num

/-- The two facing sides of an edge are `2` apart along the frame's `t` axis. -/
example (m n : ℤ) (j : Fin 3) : dist (hcFrame m n j 0 2) (hcFrame m n j 0 0) = 2 := by
  rw [dist_eq_norm, hcFrame, hcFrame, add_sub_add_left_eq_sub, ← sub_mul, norm_mul, norm_e]
  push_cast
  ring_nf
  simp

/-- The face disc at the origin is in HC, for every gap function. -/
example (g : ℝ → ℝ) : (0 : ℂ) ∈ hcSet g :=
  Or.inr (mem_iUnion.2 ⟨0, mem_iUnion.2 ⟨0, by simp [hcFace, tri]⟩⟩)

/-! ### The row -/

/-- `(G1)` holds for § 1.6's formula on every closed `Z ⊆ [−1/2, 1/2]` holding `±1/2` (the gaps have width at most `1`). -/
theorem g1Bounds_hcGap {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hl : (-1 / 2 : ℝ) ∈ Z)
    (hr : (1 / 2 : ℝ) ∈ Z) : G1Bounds Z (hcGap Z) := by
  sorry

/-- HC₀'s zero set `Z = {−1/2, 1/2}` (every band one lens). -/
def hcZ0 : Set ℝ := {-1 / 2, 1 / 2}

/-- **A model of FS111-M3-HC's hypotheses**: HC₀ — `Z = {±1/2}` with § 1.6's gap function. -/
theorem hcZ0_spec : IsClosed hcZ0 ∧ hcZ0 ⊆ Icc (-1 / 2) (1 / 2) ∧ volume hcZ0 = 0 ∧ (-1 / 2 : ℝ) ∈ hcZ0 ∧
    (1 / 2 : ℝ) ∈ hcZ0 ∧ G1Bounds hcZ0 (hcGap hcZ0) := by
  have hf : hcZ0.Finite := (Set.finite_singleton _).insert _
  have hc : IsClosed hcZ0 := hf.isClosed
  have hs : hcZ0 ⊆ Icc (-1 / 2) (1 / 2) := by
    rintro x (rfl | rfl) <;> norm_num
  have hl : (-1 / 2 : ℝ) ∈ hcZ0 := Or.inl rfl
  have hr : (1 / 2 : ℝ) ∈ hcZ0 := Or.inr rfl
  exact ⟨hc, hs, hf.measure_zero _, hl, hr, g1Bounds_hcGap hc hs hl hr⟩

/-- **FS111-M3-HC**, first clause: for every closed null `Z ⊆ [−1/2, 1/2]` holding `±1/2` and every gap function with (G1)'s
bounds, `int HC` is a regular MUA set with support `HC`, and HC satisfies FS111-M2-FIX: `int HC = ℝ² ∖ (HC + S¹)`. -/
theorem hc_isRegularMUA {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZ0 : volume Z = 0)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) :
    IsRegularMUA (interior (hcSet g)) ∧ essSupport (interior (hcSet g)) = hcSet g ∧
      interior (hcSet g) = (unitShadow (hcSet g))ᶜ := by
  sorry

/-- **FS111-M3-HC**, second clause, at every `Z` (wider: the row says "with `Z` a Cantor set"; the argument reads only that `g`
vanishes exactly on `Z`): each band has one component per gap — two of its points lie in one component iff no point of `Z` lies
between their `s` coordinates. With `Z` the Cantor set (HC_K), infinitely many. -/
theorem hc_band_components {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZ0 : volume Z = 0)
    (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) (m n : ℤ) (j : Fin 3)
    {s₁ t₁ s₂ t₂ : ℝ} (hs₁ : |s₁| < 1 / 2) (ht₁ : 1 < t₁) (ht₁' : t₁ < hcBandTop g m n j s₁) (hs₂ : |s₂| < 1 / 2)
    (ht₂ : 1 < t₂) (ht₂' : t₂ < hcBandTop g m n j s₂) :
    connectedComponentIn (hcBand g m n j) (hcFrame m n j s₁ t₁) =
        connectedComponentIn (hcBand g m n j) (hcFrame m n j s₂ t₂) ↔ Disjoint (uIcc s₁ s₂) Z := by
  sorry

/-! ## FS111-M3-IRREG and FS111-M3-FIXCONV: a fat pinch -/

/-- The radius removed about the `n`-th rational `q`: `min (4^{−(n+2)}) (dist(q, {±1/2})/2)`, so `±1/2` survive. -/
noncomputable def fatR (n : ℕ) : ℝ :=
  let q : ℝ := (Denumerable.ofNat ℚ n : ℚ)
  min ((1 / 4) ^ (n + 2)) (min |q - 1 / 2| |q + 1 / 2| / 2)

/-- **A fat nowhere dense set**: `[−1/2, 1/2]` minus the open intervals of radius `fatR n` about the rationals — closed, with
empty interior (the rationals are dense), of length at least `5/6`, holding `±1/2`. -/
noncomputable def fatZ : Set ℝ :=
  Icc (-1 / 2) (1 / 2) \ ⋃ n : ℕ, ball ((Denumerable.ofNat ℚ n : ℚ) : ℝ) (fatR n)

/-- `fatZ` is what FS111-M3-IRREG needs. -/
theorem fatZ_spec : IsClosed fatZ ∧ fatZ ⊆ Icc (-1 / 2) (1 / 2) ∧ interior fatZ = ∅ ∧ 0 < volume fatZ ∧
    (-1 / 2 : ℝ) ∈ fatZ ∧ (1 / 2 : ℝ) ∈ fatZ := by
  have hR0 : ∀ n, 0 ≤ fatR n := fun n => by
    unfold fatR
    refine le_min (by positivity) (by positivity)
  have hRle : ∀ n, fatR n ≤ (1 / 4) ^ (n + 2) := fun n => min_le_left _ _
  have hRq1 : ∀ n, fatR n ≤ |((Denumerable.ofNat ℚ n : ℚ) : ℝ) - 1 / 2| := fun n => by
    unfold fatR
    refine (min_le_right _ _).trans ?_
    have := min_le_left |((Denumerable.ofNat ℚ n : ℚ) : ℝ) - 1 / 2| |((Denumerable.ofNat ℚ n : ℚ) : ℝ) + 1 / 2|
    have := abs_nonneg (((Denumerable.ofNat ℚ n : ℚ) : ℝ) - 1 / 2)
    linarith
  have hRq2 : ∀ n, fatR n ≤ |((Denumerable.ofNat ℚ n : ℚ) : ℝ) + 1 / 2| := fun n => by
    unfold fatR
    refine (min_le_right _ _).trans ?_
    have := min_le_right |((Denumerable.ofNat ℚ n : ℚ) : ℝ) - 1 / 2| |((Denumerable.ofNat ℚ n : ℚ) : ℝ) + 1 / 2|
    have := abs_nonneg (((Denumerable.ofNat ℚ n : ℚ) : ℝ) + 1 / 2)
    linarith
  have hends : ∀ a : ℝ, (a = 1 / 2 ∨ a = -1 / 2) → a ∈ fatZ := by
    intro a ha
    refine ⟨by rcases ha with rfl | rfl <;> norm_num, ?_⟩
    simp only [mem_iUnion, mem_ball, not_exists, not_lt]
    intro n
    rcases ha with rfl | rfl
    · rw [Real.dist_eq, abs_sub_comm]; exact hRq1 n
    · rw [Real.dist_eq, abs_sub_comm]
      have := hRq2 n
      rwa [show ((Denumerable.ofNat ℚ n : ℚ) : ℝ) - -1 / 2 = ((Denumerable.ofNat ℚ n : ℚ) : ℝ) + 1 / 2 by ring]
  refine ⟨isClosed_Icc.sdiff (isOpen_iUnion fun _ => isOpen_ball), sdiff_subset, ?_, ?_,
    hends _ (Or.inr rfl), hends _ (Or.inl rfl)⟩
  · refine eq_empty_of_forall_notMem fun x hx => ?_
    obtain ⟨ε, hε, hball⟩ := Metric.mem_nhds_iff.1 (mem_interior_iff_mem_nhds.1 hx)
    have hV : IsOpen (ball x ε \ {1 / 2, -1 / 2}) :=
      isOpen_ball.sdiff (Set.toFinite _).isClosed
    have hne : (ball x ε \ {1 / 2, -1 / 2}).Nonempty := by
      have hinf : (Ioo (x - ε) (x + ε)).Infinite := Set.Ioo_infinite (by linarith)
      obtain ⟨y, hy1, hy2⟩ := (hinf.sdiff (Set.toFinite ({1 / 2, -1 / 2} : Set ℝ))).nonempty
      exact ⟨y, by rw [mem_ball, Real.dist_eq, abs_lt]; constructor <;> linarith [hy1.1, hy1.2], hy2⟩
    obtain ⟨q, hq⟩ := Rat.denseRange_cast.exists_mem_open hV hne
    obtain ⟨n, hn⟩ : ∃ n : ℕ, (Denumerable.ofNat ℚ n : ℚ) = q := ⟨Denumerable.eqv ℚ q, (Denumerable.eqv ℚ).symm_apply_apply q⟩
    have hq1 : (q : ℝ) ≠ 1 / 2 := fun h => hq.2 (Or.inl h)
    have hq2 : (q : ℝ) ≠ -1 / 2 := fun h => hq.2 (Or.inr h)
    have hR : 0 < fatR n := by
      unfold fatR
      simp only [hn]
      have a1 : 0 < |(q : ℝ) - 1 / 2| := abs_pos.2 (sub_ne_zero.2 hq1)
      have a2 : 0 < |(q : ℝ) + 1 / 2| := abs_pos.2 fun h => hq2 (by linarith)
      exact lt_min (by positivity) (div_pos (lt_min a1 a2) two_pos)
    have hqF : (q : ℝ) ∈ fatZ := hball hq.1
    exact hqF.2 (mem_iUnion.2 ⟨n, by rw [hn]; exact mem_ball_self hR⟩)
  · have hU : volume (⋃ n : ℕ, ball ((Denumerable.ofNat ℚ n : ℚ) : ℝ) (fatR n)) ≤ ENNReal.ofReal (1 / 6) := by
      refine (measure_iUnion_le _).trans ?_
      have hg : HasSum (fun n : ℕ => 2 * (1 / 4 : ℝ) ^ (n + 2)) (1 / 6) := by
        have := (hasSum_geometric_of_lt_one (r := (1 / 4 : ℝ)) (by norm_num) (by norm_num)).mul_left (2 * (1 / 4) ^ 2)
        have e : (fun n : ℕ => 2 * (1 / 4 : ℝ) ^ (n + 2)) = fun n : ℕ => 2 * (1 / 4) ^ 2 * (1 / 4) ^ n := by
          funext n; ring
        have e2 : (2 * (1 / 4 : ℝ) ^ 2 * (1 - 1 / 4)⁻¹) = 1 / 6 := by norm_num
        rw [e, ← e2]; exact this
      calc ∑' n : ℕ, volume (ball ((Denumerable.ofNat ℚ n : ℚ) : ℝ) (fatR n))
          ≤ ∑' n : ℕ, ENNReal.ofReal (2 * (1 / 4 : ℝ) ^ (n + 2)) := by
            refine ENNReal.tsum_le_tsum fun n => ?_
            rw [Real.volume_ball]
            exact ENNReal.ofReal_le_ofReal (by linarith [hRle n])
        _ = ENNReal.ofReal (1 / 6) := by
            rw [← ENNReal.ofReal_tsum_of_nonneg (fun n => by positivity) hg.summable, hg.tsum_eq]
    have hI : volume (Icc (-1 / 2 : ℝ) (1 / 2)) = 1 := by
      rw [Real.volume_Icc]; norm_num
    have h1 : volume (Icc (-1 / 2 : ℝ) (1 / 2)) - volume (⋃ n : ℕ, ball ((Denumerable.ofNat ℚ n : ℚ) : ℝ) (fatR n))
        ≤ volume fatZ := le_measure_sdiff
    have h2 : 0 < (1 : ENNReal) - ENNReal.ofReal (1 / 6) := by
      rw [tsub_pos_iff_lt]
      exact (ENNReal.ofReal_lt_one.2 (by norm_num))
    refine lt_of_lt_of_le ?_ h1
    rw [hI]
    exact lt_of_lt_of_le h2 (tsub_le_tsub le_rfl hU)

/-- `fatZ` is closed (spec, sorry-free). -/
example : IsClosed fatZ := isClosed_Icc.sdiff (isOpen_iUnion fun _ => isOpen_ball)

/-- **FS111-M3-IRREG**, at the class its argument reads (wider: any closed `Z ⊆ [−1/2, 1/2]` with empty interior and positive
length holding `±1/2`, any `g` with (G1)'s bounds; the row's Smith–Volterra–Cantor `Z_f` is one): `A = int HC(g)` is
unit-avoiding (no two points at distance `1`), regular (`cl A = HC`, `|HC ∖ A| = 0`, `|∂HC| = 0`) and satisfies the shadow
identity, but is not a MUA set, and every MUA set containing it up to null sets has a boundary of its support of positive
measure. -/
theorem hc_irreg {Z : Set ℝ} (hZc : IsClosed Z) (hZs : Z ⊆ Icc (-1 / 2) (1 / 2)) (hZi : interior Z = ∅)
    (hZpos : 0 < volume Z) (hl : (-1 / 2 : ℝ) ∈ Z) (hr : (1 / 2 : ℝ) ∈ Z) {g : ℝ → ℝ} (hg : G1Bounds Z g) :
    (∀ x ∈ interior (hcSet g), ∀ y ∈ interior (hcSet g), dist x y ≠ 1) ∧ closure (interior (hcSet g)) = hcSet g ∧
      volume (hcSet g \ interior (hcSet g)) = 0 ∧ volume (frontier (hcSet g)) = 0 ∧
      interior (hcSet g) = (unitShadow (hcSet g))ᶜ ∧ ¬ IsMUA (interior (hcSet g)) ∧
      ∀ A' : Set ℂ, IsMUA A' → interior (hcSet g) ≤ᵐ[volume] A' → 0 < volume (frontier (essSupport A')) := by
  sorry

/-- **FS111-M3-IRREG**, its conclusion: "every MUA set is regular" (MUA-REG-U) is false. -/
theorem not_forall_isRegularMUA : ¬ ∀ A : Set ℂ, IsMUA A → IsRegularMUA A := by
  intro h
  obtain ⟨hc, hs, hi, hpos, hl, hr⟩ := fatZ_spec
  obtain ⟨h1, -, -, -, -, -, h7⟩ := hc_irreg hc hs hi hpos hl hr (g1Bounds_hcGap hc hs hl hr)
  have hmeas : MeasurableSet (interior (hcSet (hcGap fatZ))) := isOpen_interior.measurableSet
  have hnull : UnitPairsNull (interior (hcSet (hcGap fatZ))) := by
    have : unitPairSet (interior (hcSet (hcGap fatZ))) = ∅ := by
      ext ⟨x, θ⟩
      simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
      intro hx hy
      exact h1 _ hy _ hx (by rw [dist_eq_norm, add_sub_cancel_left, norm_e])
    rw [UnitPairsNull, this, measure_empty]
  obtain ⟨A', hA', hle⟩ := exists_isMUA_ae_le hmeas hnull
  exact (h7 A' hA' hle).ne' (h A' hA').2.2

/-- **FS111-M3-FIXCONV**: the converse of FS111-M2-FIX fails — a closed regular set (`cl int F = F`, `|∂F| = 0`) whose interior
has null unit pairs and satisfies `int F = ℝ² ∖ (F + S¹)` need not have a maximal interior (`F = HC(g)` over `fatZ`). -/
theorem not_forall_fix_converse :
    ¬ ∀ F : Set ℂ, IsClosed F → closure (interior F) = F → volume (frontier F) = 0 → UnitPairsNull (interior F) →
      interior F = (unitShadow F)ᶜ → IsMUA (interior F) := by
  intro h
  obtain ⟨hc, hs, hi, hpos, hl, hr⟩ := fatZ_spec
  obtain ⟨h1, h2, -, h4, h5, h6, -⟩ := hc_irreg hc hs hi hpos hl hr (g1Bounds_hcGap hc hs hl hr)
  refine h6 (h _ ?_ h2 h4 ?_ h5)
  · rw [← h2]; exact isClosed_closure
  · have : unitPairSet (interior (hcSet (hcGap fatZ))) = ∅ := by
      ext ⟨x, θ⟩
      simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
      intro hx hy
      exact h1 _ hy _ hx (by rw [dist_eq_norm, add_sub_cancel_left, norm_e])
    rw [UnitPairsNull, this, measure_empty]

end HadwigerNelson.Plane
