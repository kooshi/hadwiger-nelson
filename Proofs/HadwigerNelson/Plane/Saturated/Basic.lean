import Proofs.HadwigerNelson.Plane.CoverExamples
import Proofs.HadwigerNelson.Plane.LocalStructure

/-!
# Saturated colourings: the two-colour neighbourhood, the singular set, the two types (FS-131 wave 6's foundation)

The vocabulary FS-111's route M and FS-121 read (`data/fs111/claims.md` § 0, `data/fs121/claims.md` § 0;
`plans/FS131-w6-kernel-plan.md` § 3), over wave 2's `Saturated` (`Plane/Cover`).

**The words the derivations never fixed, as read here.**
* *Honest* (one colour per point) is the type: an `AeColouring k` is a function, so its classes are disjoint and cover.
  A cover (`Fin k → Set ℂ`, overlaps allowed) is the other reading; the rows that say "honest" are stated over
  `c : AeColouring k` and `c.cls`.
* *In D-NF* is notation, never a hypothesis: every statement reads a class through `densitySet` (`S̃_j`), `essClosure`
  (`A*_j`), `essBoundary` (`∂_e S_j`) and `essSupport` (`supp S_j`), each unchanged by a null change of the class.
  No row of wave 6's thirty-five uses a pointwise normalisation of the colouring (`col x = j` on `S̃_j`); a later row
  that does is new, and needs that normalisation as a hypothesis of its own.
* *Saturated* is `Saturated c.cls` (wave 2): for a colouring, "every essential boundary point is at distance exactly `1`
  from the support of each colour of its essential multicolour".

**Definitions.**
* `c.openPart j` — the interior of `S̃_j`; its components are the colour's *regions* (FS121-D4-HOLE's word).
* `c.essBdry` — the essential boundary points of the classes; `c.IsCuspAt j x` — `x ∈ supp S_j` with `d̄_j(x) = 0`.
* `c.H1 x ρ a b`, `c.H2 x ρ a`, `c.TwoColourAt x ρ a b` — FS111-M-PINCH's hypotheses (H1), (H2) at `x` with
  `N = B(x, ρ)` (`plans/FS111-M-regularity.md` § 3).
* `c.singularSet` (`Σ`) and `c.interfaceSet` (`𝓘`, the essential boundary off `Σ`).
* `c.IsSplitAt x ρ a b y`, `c.HasTwoDiscsAt x ρ a b ν`, `c.IsTangentAt x ρ a b ν` — M-PINCH's two types at `x`, and the
  two tangent unit discs both types carry.

**Inhabitant.** `sq9` at the edge point `sqEdgePt = 1/2 + i/4`: `sq9_twoColourAt` (two colours in `B(·, 1/8)`),
`sq9_hasTwoDiscsAt` (the two tangent unit discs, the normal `1` into the right-hand colour).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-! ## Definitions -/

namespace AeColouring

variable (c : AeColouring k)

/-- The **open part** of colour `j`: the interior of the density set `S̃_j`. Its connected components are the colour's
*regions*. -/
def openPart (j : Fin k) : Set ℂ := interior (densitySet (c.cls j))

/-- The **essential boundary** of the colouring: the points of `∂_e S_j` for some colour `j`. -/
def essBdry : Set ℂ := ⋃ j, essBoundary (c.cls j)

/-- Colour `j` has a **cusp** at `x`: `x ∈ supp S_j` and `S_j` has density `0` at `x`. -/
def IsCuspAt (j : Fin k) (x : ℂ) : Prop := x ∈ essSupport (c.cls j) ∧ x ∉ essClosure (c.cls j)

/-- **(H1)** at `x` with `N = B(x, ρ)` and colours `a`, `b`: every other class is null in `N`. -/
def H1 (x : ℂ) (ρ : ℝ) (a b : Fin k) : Prop := ∀ j, j ≠ a → j ≠ b → volume (c.cls j ∩ ball x ρ) = 0

/-- **(H2)** at `x` for the colour `a`, with `N = B(x, ρ)`: in `N` the class `S_a` is almost everywhere a connected open
set `P` of density points of `S_a`, with `x` in the closure of `P`. -/
def H2 (x : ℂ) (ρ : ℝ) (a : Fin k) : Prop :=
  ∃ P : Set ℂ, IsOpen P ∧ IsConnected P ∧ P ⊆ densitySet (c.cls a) ∧
    (c.cls a ∩ ball x ρ : Set ℂ) =ᵐ[volume] P ∧ x ∈ closure P

/-- FS111-M-PINCH's hypotheses at `x`: (H1) and (H2) hold in `N = B(x, ρ)` for two different colours `a`, `b`. -/
structure TwoColourAt (x : ℂ) (ρ : ℝ) (a b : Fin k) : Prop where
  /-- The radius of `N` is positive. -/
  pos : 0 < ρ
  /-- The two colours differ. -/
  ne : a ≠ b
  /-- (H1): no third colour has positive measure in `N`. -/
  h1 : c.H1 x ρ a b
  /-- (H2) for `a`. -/
  h2a : c.H2 x ρ a
  /-- (H2) for `b`. -/
  h2b : c.H2 x ρ b

/-- The **singular set** `Σ`: the essential boundary points at which (H1), (H2) fail for every ball and every pair of
colours, together with every cusp (`plans/FS111-M2-regularity.md` § 4.1). -/
def singularSet : Set ℂ :=
  {x | x ∈ c.essBdry ∧ ¬ ∃ ρ a b, c.TwoColourAt x ρ a b} ∪ {x | ∃ j, c.IsCuspAt j x}

/-- The **interface set** `𝓘`: the essential boundary off `Σ`. -/
def interfaceSet : Set ℂ := c.essBdry \ c.singularSet

/-- **Split type** at `x`, in `N = B(x, ρ)`: `N` is cut by the unit circle about `y`, `|x − y| = 1`, with `a` inside and
`b` outside, up to null sets. (The reverse is `IsSplitAt x ρ b a y`.) -/
def IsSplitAt (x : ℂ) (ρ : ℝ) (a b : Fin k) (y : ℂ) : Prop :=
  dist x y = 1 ∧ (c.cls a ∩ ball x ρ : Set ℂ) =ᵐ[volume] (ball y 1 ∩ ball x ρ : Set ℂ) ∧
    (c.cls b ∩ ball x ρ : Set ℂ) =ᵐ[volume] (ball x ρ \ closedBall y 1 : Set ℂ)

/-- **Two tangent unit discs** at `x`, in `N = B(x, ρ)`, with unit normal `ν` into `b`: the open unit disc about `x + ν`
lies in `S_b` and the one about `x − ν` in `S_a`, within `N`, up to null sets — two open unit discs tangent at `x` from
opposite sides (FS111-M-C11 (i): this holds at both types). -/
def HasTwoDiscsAt (x : ℂ) (ρ : ℝ) (a b : Fin k) (ν : ℂ) : Prop :=
  ‖ν‖ = 1 ∧ (ball (x + ν) 1 ∩ ball x ρ : Set ℂ) ≤ᵐ[volume] c.cls b ∧
    (ball (x - ν) 1 ∩ ball x ρ : Set ℂ) ≤ᵐ[volume] c.cls a

/-- **Tangent type** at `x` with unit normal `ν` into `b`: the two tangent unit discs, each inside the colour whose
contact is the other disc's centre — `x + ν ∈ supp S_a` across `b`'s side and `x − ν ∈ supp S_b` across `a`'s
(the parallel partners). -/
def IsTangentAt (x : ℂ) (ρ : ℝ) (a b : Fin k) (ν : ℂ) : Prop :=
  c.HasTwoDiscsAt x ρ a b ν ∧ x + ν ∈ essSupport (c.cls a) ∧ x - ν ∈ essSupport (c.cls b)

/-! ## First facts (each a spec example of its definition) -/

/-- The open part is open. -/
theorem isOpen_openPart (j : Fin k) : IsOpen (c.openPart j) := isOpen_interior

/-- The open part consists of density points. -/
theorem openPart_subset_densitySet (j : Fin k) : c.openPart j ⊆ densitySet (c.cls j) := interior_subset

/-- The two colours of a two-colour neighbourhood may be exchanged. -/
theorem TwoColourAt.symm {x : ℂ} {ρ : ℝ} {a b : Fin k} (h : c.TwoColourAt x ρ a b) : c.TwoColourAt x ρ b a :=
  ⟨h.pos, h.ne.symm, fun j hjb hja => h.h1 j hja hjb, h.h2b, h.h2a⟩

/-- Spec: no two-colour neighbourhood with one colour. -/
example (x : ℂ) (ρ : ℝ) (a : Fin k) : ¬ c.TwoColourAt x ρ a a := fun h => h.ne rfl

/-- The interface set lies in the essential boundary and misses `Σ`. -/
theorem interfaceSet_subset_essBdry : c.interfaceSet ⊆ c.essBdry := sdiff_subset

/-- `𝓘` and `Σ` are disjoint. -/
theorem disjoint_interfaceSet_singularSet : Disjoint c.interfaceSet c.singularSet := disjoint_sdiff_left

/-- At an interface point (H1) and (H2) hold for some ball and some pair of colours — the points FS111-M-PINCH reads. -/
theorem exists_twoColourAt_of_mem_interfaceSet {x : ℂ} (hx : x ∈ c.interfaceSet) :
    ∃ ρ a b, c.TwoColourAt x ρ a b := by
  by_contra h
  exact hx.2 (Or.inl ⟨hx.1, h⟩)

/-- No colour has a cusp at an interface point. -/
theorem not_isCuspAt_of_mem_interfaceSet {x : ℂ} (hx : x ∈ c.interfaceSet) (j : Fin k) : ¬ c.IsCuspAt j x :=
  fun h => hx.2 (Or.inr ⟨j, h⟩)

/-- A cusp is a point of `Σ`. -/
theorem IsCuspAt.mem_singularSet {j : Fin k} {x : ℂ} (h : c.IsCuspAt j x) : x ∈ c.singularSet := Or.inr ⟨j, h⟩

/-- Spec: the tangent type read from the other side has the opposite normal. -/
theorem hasTwoDiscsAt_comm {x : ℂ} {ρ : ℝ} {a b : Fin k} {ν : ℂ} :
    c.HasTwoDiscsAt x ρ a b ν ↔ c.HasTwoDiscsAt x ρ b a (-ν) := by
  unfold HasTwoDiscsAt
  rw [norm_neg, sub_neg_eq_add, ← sub_eq_add_neg]
  exact ⟨fun ⟨h1, h2, h3⟩ => ⟨h1, h3, h2⟩, fun ⟨h1, h2, h3⟩ => ⟨h1, h3, h2⟩⟩

/-- Spec: the tangent type read from the other side has the opposite normal. -/
theorem isTangentAt_comm {x : ℂ} {ρ : ℝ} {a b : Fin k} {ν : ℂ} :
    c.IsTangentAt x ρ a b ν ↔ c.IsTangentAt x ρ b a (-ν) := by
  unfold IsTangentAt
  rw [← c.hasTwoDiscsAt_comm, sub_neg_eq_add, ← sub_eq_add_neg]
  exact ⟨fun ⟨h1, h2, h3⟩ => ⟨h1, h3, h2⟩, fun ⟨h1, h2, h3⟩ => ⟨h1, h3, h2⟩⟩

end AeColouring

/-! ## The inhabitant: `sq9` at a point of a vertical edge -/

/-- The edge point `1/2 + i/4` of `sq9`, on the edge between the squares `[0, 1/2) × [0, 1/2)` and
`[1/2, 1) × [0, 1/2)`. -/
noncomputable def sqEdgePt : ℂ := ⟨1 / 2, 1 / 4⟩

/-- The colour of the square `[0, 1/2) × [0, 1/2)`. -/
def sqColA : Fin 9 := finProdFinEquiv ((0 : ZMod 3), (0 : ZMod 3))

/-- The colour of the square `[1/2, 1) × [0, 1/2)`. -/
def sqColB : Fin 9 := finProdFinEquiv ((1 : ZMod 3), (0 : ZMod 3))

theorem sqColA_ne_sqColB : sqColA ≠ sqColB := by decide

/-- Coordinates of a point of `B(sqEdgePt, 1/8)`. -/
theorem sqEdge_coords {z : ℂ} (hz : z ∈ ball sqEdgePt (1 / 8)) :
    |z.re - 1 / 2| < 1 / 8 ∧ |z.im - 1 / 4| < 1 / 8 := by
  rw [mem_ball, dist_eq_norm] at hz
  have h1 := abs_re_le_norm (z - sqEdgePt)
  have h2 := abs_im_le_norm (z - sqEdgePt)
  rw [Complex.sub_re] at h1
  rw [Complex.sub_im] at h2
  exact ⟨lt_of_le_of_lt h1 hz, lt_of_le_of_lt h2 hz⟩

/-- In `B(sqEdgePt, 1/8)` the colour of `sq9` is `sqColA` left of the edge and `sqColB` on it and to its right. -/
theorem sq9Col_near_edge {z : ℂ} (hz : z ∈ ball sqEdgePt (1 / 8)) :
    sq9Col z = if z.re < 1 / 2 then sqColA else sqColB := by
  obtain ⟨hre, him⟩ := sqEdge_coords hz
  obtain ⟨h1, h2⟩ := abs_lt.mp hre
  obtain ⟨h3, h4⟩ := abs_lt.mp him
  have fim : ⌊2 * z.im⌋ = 0 := Int.floor_eq_iff.mpr ⟨by push_cast; linarith, by push_cast; linarith⟩
  split_ifs with h
  · have fre : ⌊2 * z.re⌋ = 0 := Int.floor_eq_iff.mpr ⟨by push_cast; linarith, by push_cast; linarith⟩
    simp [sq9Col, sq9Index, fim, fre, sqColA]
  · have fre : ⌊2 * z.re⌋ = 1 := Int.floor_eq_iff.mpr ⟨by push_cast; linarith, by push_cast; linarith⟩
    simp [sq9Col, sq9Index, fim, fre, sqColB]

/-- The point `t + i/4` is within `|t − 1/2|` of `sqEdgePt`. -/
theorem dist_sqEdgePt (t : ℝ) : dist (⟨t, 1 / 4⟩ : ℂ) sqEdgePt = |t - 1 / 2| := by
  rw [Complex.dist_of_im_eq (by rfl), Real.dist_eq]
  rfl

/-- `sqEdgePt` is in the closure of each open half of `B(sqEdgePt, 1/8)`. -/
theorem sqEdgePt_mem_closure_half (s : ℝ) (hs : s = 1 ∨ s = -1) :
    sqEdgePt ∈ closure (ball sqEdgePt (1 / 8) ∩ {z : ℂ | 0 < s * (z.re - 1 / 2)}) := by
  rw [Metric.mem_closure_iff]
  intro ε hε
  set m : ℝ := min ε (1 / 8) / 2 with hm
  have hm0 : 0 < m := by rw [hm]; exact half_pos (lt_min hε (by norm_num))
  have hm1 : m < 1 / 8 := by
    rw [hm]; have := min_le_right ε (1 / 8); linarith
  have hm2 : m < ε := by
    rw [hm]; have := min_le_left ε (1 / 8); linarith
  have hd : dist (⟨1 / 2 + s * m, 1 / 4⟩ : ℂ) sqEdgePt = m := by
    rw [dist_sqEdgePt]
    rcases hs with rfl | rfl
    · rw [show (1 / 2 + 1 * m - 1 / 2 : ℝ) = m by ring, abs_of_pos hm0]
    · rw [show (1 / 2 + -1 * m - 1 / 2 : ℝ) = -m by ring, abs_neg, abs_of_pos hm0]
  refine ⟨⟨1 / 2 + s * m, 1 / 4⟩, ⟨?_, ?_⟩, ?_⟩
  · rw [mem_ball, hd]; exact hm1
  · show 0 < s * (1 / 2 + s * m - 1 / 2)
    rcases hs with rfl | rfl <;> nlinarith
  · rw [dist_comm, hd]; exact hm2

/-- The vertical line through `sqEdgePt` is null in `B(sqEdgePt, 1/8)`. -/
theorem volume_sqEdge_line : volume (ball sqEdgePt (1 / 8) ∩ {z : ℂ | z.re = 1 / 2}) = 0 := by
  refine measure_mono_null ?_ (volume_segment_eq_zero (⟨1 / 2, 0⟩ : ℂ) ⟨1 / 2, 1 / 2⟩)
  rintro z ⟨hz, hre⟩
  obtain ⟨-, him⟩ := sqEdge_coords hz
  obtain ⟨h3, h4⟩ := abs_lt.mp him
  refine ⟨1 - 2 * z.im, 2 * z.im, by linarith, by linarith, by ring, ?_⟩
  apply Complex.ext
  · simp only [Complex.add_re, Complex.real_smul, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im]
    rw [show z.re = 1 / 2 from hre]; ring
  · simp only [Complex.add_im, Complex.real_smul, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im]
    ring

/-- (H2) for `sq9` at `sqEdgePt`, on the side `s (re z − 1/2) > 0` whose colour is `col`. -/
theorem sq9_h2_of_side (s : ℝ) (hs : s = 1 ∨ s = -1) (col : Fin 9)
    (hcol : ∀ z ∈ ball sqEdgePt (1 / 8), 0 < s * (z.re - 1 / 2) → sq9Col z = col)
    (hother : ∀ z ∈ ball sqEdgePt (1 / 8), s * (z.re - 1 / 2) < 0 → sq9Col z ≠ col) :
    sq9.H2 sqEdgePt (1 / 8) col := by
  have hcont : Continuous fun z : ℂ => s * (z.re - 1 / 2) :=
    continuous_const.mul (Complex.continuous_re.sub continuous_const)
  have hopen : IsOpen (ball sqEdgePt (1 / 8) ∩ {z : ℂ | 0 < s * (z.re - 1 / 2)}) :=
    isOpen_ball.inter (isOpen_lt continuous_const hcont)
  have hconv : Convex ℝ (ball sqEdgePt (1 / 8) ∩ {z : ℂ | 0 < s * (z.re - 1 / 2)}) := by
    refine (convex_ball _ _).inter ?_
    rcases hs with rfl | rfl
    · have h : {z : ℂ | 0 < (1 : ℝ) * (z.re - 1 / 2)} = {c : ℂ | 1 / 2 < c.re} := by
        ext z; simp only [mem_setOf_eq]; constructor <;> intro h <;> linarith
      rw [h]; exact convex_halfSpace_re_gt (1 / 2)
    · have h : {z : ℂ | 0 < (-1 : ℝ) * (z.re - 1 / 2)} = {c : ℂ | c.re < 1 / 2} := by
        ext z; simp only [mem_setOf_eq]; constructor <;> intro h <;> linarith
      rw [h]; exact convex_halfSpace_re_lt (1 / 2)
  have hmem := sqEdgePt_mem_closure_half s hs
  have hne : (ball sqEdgePt (1 / 8) ∩ {z : ℂ | 0 < s * (z.re - 1 / 2)}).Nonempty := by
    by_contra h
    rw [Set.not_nonempty_iff_eq_empty] at h
    rw [h, closure_empty] at hmem
    exact hmem
  have hsub : ball sqEdgePt (1 / 8) ∩ {z : ℂ | 0 < s * (z.re - 1 / 2)} ⊆ sq9.cls col :=
    fun z hz => hcol z hz.1 hz.2
  refine ⟨_, hopen, ⟨hne, hconv.isPreconnected⟩,
    subset_densitySet_of_isOpen_ae_subset hopen (Eventually.of_forall hsub), ?_, hmem⟩
  rw [ae_eq_set]
  constructor
  · refine measure_mono_null ?_ volume_sqEdge_line
    rintro z ⟨⟨hzc, hzb⟩, hzn⟩
    refine ⟨hzb, ?_⟩
    show z.re = 1 / 2
    have h1 : ¬ 0 < s * (z.re - 1 / 2) := fun h => hzn ⟨hzb, h⟩
    have h2 : ¬ s * (z.re - 1 / 2) < 0 := fun h => hother z hzb h hzc
    have h3 : s * (z.re - 1 / 2) = 0 := le_antisymm (not_lt.mp h1) (not_lt.mp h2)
    rcases hs with rfl | rfl <;> linarith
  · have : (ball sqEdgePt (1 / 8) ∩ {z : ℂ | 0 < s * (z.re - 1 / 2)}) \ (sq9.cls col ∩ ball sqEdgePt (1 / 8)) = ∅ := by
      ext z
      constructor
      · rintro ⟨hz, hzn⟩
        exact hzn ⟨hsub hz, hz.1⟩
      · intro h; exact h.elim
    rw [this, measure_empty]

/-- **Inhabitant of `TwoColourAt`**: `sq9` at the edge point `1/2 + i/4`, in the ball of radius `1/8`, with the colours
of the two squares the edge separates. -/
theorem sq9_twoColourAt : sq9.TwoColourAt sqEdgePt (1 / 8) sqColA sqColB := by
  refine ⟨by norm_num, sqColA_ne_sqColB, ?_, ?_, ?_⟩
  · intro j hja hjb
    have : sq9.cls j ∩ ball sqEdgePt (1 / 8) = ∅ := by
      ext z
      simp only [mem_inter_iff, mem_empty_iff_false, iff_false, not_and]
      intro hzj hz
      have hzj' : sq9Col z = j := hzj
      rw [sq9Col_near_edge hz] at hzj'
      split_ifs at hzj' with h
      · exact hja hzj'.symm
      · exact hjb hzj'.symm
    rw [this, measure_empty]
  · refine sq9_h2_of_side (-1) (Or.inr rfl) sqColA (fun z hz h => ?_) (fun z hz h => ?_)
    · rw [sq9Col_near_edge hz, if_pos (by linarith)]
    · rw [sq9Col_near_edge hz, if_neg (by linarith)]
      exact sqColA_ne_sqColB.symm
  · refine sq9_h2_of_side 1 (Or.inl rfl) sqColB (fun z hz h => ?_) (fun z hz h => ?_)
    · rw [sq9Col_near_edge hz, if_neg (by linarith)]
    · rw [sq9Col_near_edge hz, if_pos (by linarith)]
      exact sqColA_ne_sqColB

/-- In `B(sqEdgePt, 1/8)`, a point of the open unit disc about `sqEdgePt + s`, `s = ±1`, lies strictly on the side of
`s`. -/
theorem sqEdge_side_of_disc (s : ℝ) (hs : s = 1 ∨ s = -1) {z : ℂ} (hz : z ∈ ball (sqEdgePt + (s : ℂ)) 1) :
    0 < s * (z.re - 1 / 2) := by
  rw [mem_ball, dist_eq_norm] at hz
  have h1 : ‖z - (sqEdgePt + (s : ℂ))‖ ^ 2 < 1 := by
    have := norm_nonneg (z - (sqEdgePt + (s : ℂ))); nlinarith
  rw [sq_norm_eq] at h1
  have hre : (z - (sqEdgePt + (s : ℂ))).re = z.re - 1 / 2 - s := by
    simp only [Complex.sub_re, Complex.add_re, Complex.ofReal_re]
    show z.re - (1 / 2 + s) = z.re - 1 / 2 - s
    ring
  rw [hre] at h1
  have him := sq_nonneg (z - (sqEdgePt + (s : ℂ))).im
  rcases hs with rfl | rfl <;> nlinarith

/-- **Inhabitant of `HasTwoDiscsAt`**: `sq9` at the edge point, with normal `1` into the right-hand colour: the unit
discs about `sqEdgePt ± 1` lie, near the point, in the two squares' classes. (The contacts that make it of tangent type
are `Plane/Saturated/Pinch`'s `sq9_isTangentAt`.) -/
theorem sq9_hasTwoDiscsAt : sq9.HasTwoDiscsAt sqEdgePt (1 / 8) sqColA sqColB 1 := by
  refine ⟨norm_one, Eventually.of_forall ?_, Eventually.of_forall ?_⟩
  · rintro z ⟨hz1, hz2⟩
    have h := sqEdge_side_of_disc 1 (Or.inl rfl) (by simpa using hz1)
    show sq9Col z = sqColB
    rw [sq9Col_near_edge hz2, if_neg (by linarith)]
  · rintro z ⟨hz1, hz2⟩
    have h := sqEdge_side_of_disc (-1) (Or.inr rfl) (by simpa [sub_eq_add_neg] using hz1)
    show sq9Col z = sqColA
    rw [sq9Col_near_edge hz2, if_pos (by linarith)]

end HadwigerNelson.Plane
