import Proofs.HadwigerNelson.Plane.CoverExamples
import Proofs.HadwigerNelson.Plane.LocalStructure

/-!
# Saturated families: the two-colour open set, the singular set, the two types (FS-131 wave 6's foundation)

The vocabulary FS-111's route M and FS-121 read (`data/fs111/claims.md` § 0, `data/fs121/claims.md` § 0;
`plans/FS131-w6-kernel-plan.md` §§ 3, 9), over wave 2's `Saturated` (`Plane/Cover`).

**The class.** FS111-M-PINCH's argument reads an open set `N`, two sets `A`, `B` in it, and the supports at the
contacts — never a colouring, a third class, or the centre of `N`. So the pointwise notions are stated for **two sets on
an open set**, and the notions that read every class for **a family** `C : Fin k → Set ℂ` (a colouring's classes
`c.cls`, a cover's classes, the regions of a fragment); the `AeColouring` forms `c.essBdry`, `c.singularSet`,
`c.interfaceSet` are the family forms at `c.cls`.

**The words the derivations never fixed, as read here.**
* *Honest* (one colour per point) is, where an argument reads it, the pair `TwoColourOn.cover`, `TwoColourOn.disj`:
  in `N` the two sets cover almost everything and are almost disjoint. For a colouring both follow from (H1)
  (`AeColouring.twoColourNhd_of_h1`); for a cover with overlaps `disj` is a hypothesis that can fail.
* *In D-NF* is notation, never a hypothesis: every statement reads a set through `densitySet` (`S̃_j`), `essClosure`
  (`A*_j`), `essBoundary` (`∂_e S_j`) and `essSupport` (`supp S_j`), each unchanged by a null change of the set.
* *Saturated* is `Saturated C` (wave 2); `SaturatedOn C U` asks it at the essential boundary points of `U` only.
* *A neighbourhood `N`* of FS111-M-PINCH is any open set containing the point (FS131-E8 § 3.1 (2): the argument is
  applied at off-centre points of one ball). The singular set keeps the frozen words' *ball centred at the point*.

**Definitions.**
* `IsCuspAt A x` — `x ∈ supp A` with `d̄_A(x) = 0`; `cuspSet C` — the cusps of a family's classes.
* `H2On A N`, `TwoColourOn A B N` — (H2), and FS111-M-PINCH's hypotheses on the open set `N` for the two sets;
  `H1On C N a b`, `TwoColourNhd C N a b` — (H1), and the hypotheses for two classes of a family.
* `IsSplitAt A B N x y`, `HasTwoDiscsAt A B N x ν`, `IsTangentAt A B N x ν` — M-PINCH's two types at `x`, and the two
  tangent unit discs both types carry.
* `essBdry C`, `singularSet C` (`Σ`), `interfaceSet C` (`𝓘`, the essential boundary off `Σ`); `c.openPart j`.

**The frozen (H2) also asks `x ∈ cl P_a ∩ cl P_b`.** It is not a field: at an essential boundary point of a family
with a two-colour neighbourhood it follows from the rest (the point is an essential boundary point of both classes,
`TwoColourNhd.mem_essBoundary` in `Plane/Saturated/Pinch`, and `cl P = supp` inside `N`), so `singularSet` is the frozen
set; and FS111-M-PINCH's argument does not read it.

**Inhabitant.** `sq9` at the edge point `sqEdgePt = 1/2 + i/4`: `sq9_twoColourNhd` (two colours in `B(·, 1/8)`),
`sq9_hasTwoDiscsAt` (the two tangent unit discs, the normal `1` into the right-hand colour).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-! ## Two sets on an open set -/

/-- The set `A` has a **cusp** at `x`: `x ∈ supp A` and `A` has density `0` at `x`. -/
def IsCuspAt (A : Set ℂ) (x : ℂ) : Prop := x ∈ essSupport A ∧ x ∉ essClosure A

/-- **(H2)** for the set `A` in `N`: in `N`, `A` is almost everywhere a connected open set `P` of density points of
`A`. -/
def H2On (A N : Set ℂ) : Prop :=
  ∃ P : Set ℂ, IsOpen P ∧ IsConnected P ∧ P ⊆ densitySet A ∧ (A ∩ N : Set ℂ) =ᵐ[volume] P

/-- FS111-M-PINCH's hypotheses on the open set `N` for the two sets `A`, `B`: in `N` they cover almost everything, are
almost disjoint, and (H2) holds for each. -/
structure TwoColourOn (A B N : Set ℂ) : Prop where
  /-- `N` is open. -/
  isOpen : IsOpen N
  /-- In `N`, almost every point lies in `A` or in `B`. -/
  cover : (N : Set ℂ) ≤ᵐ[volume] (A ∪ B : Set ℂ)
  /-- In `N`, `A` and `B` are almost disjoint. -/
  disj : volume (A ∩ B ∩ N) = 0
  /-- (H2) for `A`. -/
  h2a : H2On A N
  /-- (H2) for `B`. -/
  h2b : H2On B N

/-- **Split type** at `x`, in `N`: `N` is cut by the unit circle about `y`, `|x − y| = 1`, with `A` inside and `B`
outside, up to null sets. (The reverse is `IsSplitAt B A N x y`.) -/
def IsSplitAt (A B N : Set ℂ) (x y : ℂ) : Prop :=
  dist x y = 1 ∧ (A ∩ N : Set ℂ) =ᵐ[volume] (ball y 1 ∩ N : Set ℂ) ∧
    (B ∩ N : Set ℂ) =ᵐ[volume] (N \ closedBall y 1 : Set ℂ)

/-- **Two tangent unit discs** at `x`, in `N`, with unit normal `ν` into `B`: the open unit disc about `x + ν` lies in
`B` and the one about `x − ν` in `A`, within `N`, up to null sets — two open unit discs tangent at `x` from opposite
sides (FS111-M-C11 (i): this holds at both types). -/
def HasTwoDiscsAt (A B N : Set ℂ) (x ν : ℂ) : Prop :=
  ‖ν‖ = 1 ∧ (ball (x + ν) 1 ∩ N : Set ℂ) ≤ᵐ[volume] B ∧ (ball (x - ν) 1 ∩ N : Set ℂ) ≤ᵐ[volume] A

/-- **Tangent type** at `x` with unit normal `ν` into `B`: the two tangent unit discs, each inside the set whose
contact is the other disc's centre — `x + ν ∈ supp A` across `B`'s side and `x − ν ∈ supp B` across `A`'s (the
parallel partners). -/
def IsTangentAt (A B N : Set ℂ) (x ν : ℂ) : Prop :=
  HasTwoDiscsAt A B N x ν ∧ x + ν ∈ essSupport A ∧ x - ν ∈ essSupport B

/-! ## A family -/

/-- The **essential boundary** of a family: the points of `∂_e (C j)` for some class `j`. -/
def essBdry (C : Fin k → Set ℂ) : Set ℂ := ⋃ j, essBoundary (C j)

/-- The **cusps** of a family: the points at which some class has a cusp. -/
def cuspSet (C : Fin k → Set ℂ) : Set ℂ := {x | ∃ j, IsCuspAt (C j) x}

/-- **(H1)** on `N` for the classes `a`, `b`: every other class is null in `N`. -/
def H1On (C : Fin k → Set ℂ) (N : Set ℂ) (a b : Fin k) : Prop := ∀ j, j ≠ a → j ≠ b → volume (C j ∩ N) = 0

/-- `N` is a **two-colour neighbourhood** of the family, with the classes `a`, `b`: (H1), and FS111-M-PINCH's
hypotheses for `C a`, `C b` on `N`. -/
structure TwoColourNhd (C : Fin k → Set ℂ) (N : Set ℂ) (a b : Fin k) : Prop where
  /-- (H1): no third class has positive measure in `N`. -/
  h1 : H1On C N a b
  /-- The two classes on `N`. -/
  two : TwoColourOn (C a) (C b) N

/-- The **singular set** `Σ` of a family: the essential boundary points with no two-colour ball centred at them,
together with every cusp (`plans/FS111-M2-regularity.md` § 4.1). -/
def singularSet (C : Fin k → Set ℂ) : Set ℂ :=
  {x | x ∈ essBdry C ∧ ¬ ∃ ρ a b, TwoColourNhd C (ball x ρ) a b} ∪ cuspSet C

/-- The **interface set** `𝓘` of a family: the essential boundary off `Σ`. -/
def interfaceSet (C : Fin k → Set ℂ) : Set ℂ := essBdry C \ singularSet C

/-- The family is **saturated on `U`**: every essential boundary point of a class in `U` is a contact point of that
class. (`Saturated C` is this on the whole plane.) -/
def SaturatedOn (C : Fin k → Set ℂ) (U : Set ℂ) : Prop :=
  ∀ j, ∀ x ∈ essBoundary (C j) ∩ U, IsContactFor (C j) x

/-! ## The forms for a colouring -/

/-- The **open part** of colour `j`: the interior of the density set `S̃_j`. Its connected components are the colour's
*regions*. -/
def AeColouring.openPart (c : AeColouring k) (j : Fin k) : Set ℂ := interior (densitySet (c.cls j))

/-- The essential boundary of a colouring: that of its classes. -/
abbrev AeColouring.essBdry (c : AeColouring k) : Set ℂ := Plane.essBdry c.cls

/-- The singular set `Σ` of a colouring: that of its classes. -/
abbrev AeColouring.singularSet (c : AeColouring k) : Set ℂ := Plane.singularSet c.cls

/-- The interface set `𝓘` of a colouring: that of its classes. -/
abbrev AeColouring.interfaceSet (c : AeColouring k) : Set ℂ := Plane.interfaceSet c.cls

/-! ## First facts (each a spec example of its definition) -/

/-- The open part is open. -/
theorem AeColouring.isOpen_openPart (c : AeColouring k) (j : Fin k) : IsOpen (c.openPart j) := isOpen_interior

/-- The open part consists of density points. -/
theorem AeColouring.openPart_subset_densitySet (c : AeColouring k) (j : Fin k) :
    c.openPart j ⊆ densitySet (c.cls j) := interior_subset

/-- Under (H2) the set has positive measure in `N`. -/
theorem H2On.volume_pos {A N : Set ℂ} (h : H2On A N) : 0 < volume (A ∩ N) := by
  obtain ⟨P, hPo, hPc, -, hAP⟩ := h
  rw [measure_congr hAP]
  exact hPo.measure_pos volume hPc.nonempty

/-- A two-colour open set is not empty. -/
theorem TwoColourOn.nonempty {A B N : Set ℂ} (h : TwoColourOn A B N) : N.Nonempty := by
  by_contra hN
  rw [not_nonempty_iff_eq_empty] at hN
  have h1 := h.h2a.volume_pos
  rw [hN, inter_empty, measure_empty] at h1
  exact lt_irrefl _ h1

/-- The two sets of a two-colour open set may be exchanged. -/
theorem TwoColourOn.symm {A B N : Set ℂ} (h : TwoColourOn A B N) : TwoColourOn B A N :=
  ⟨h.isOpen, by rw [union_comm]; exact h.cover, by rw [inter_comm B A]; exact h.disj, h.h2b, h.h2a⟩

/-- Spec: no two-colour open set with one set — almost disjoint, and each of positive measure. -/
example (A N : Set ℂ) : ¬ TwoColourOn A A N := fun h => by
  have h2 := h.disj
  rw [inter_self] at h2
  exact h.h2a.volume_pos.ne' h2

/-- The two classes of a two-colour neighbourhood differ. -/
theorem TwoColourNhd.ne {C : Fin k → Set ℂ} {N : Set ℂ} {a b : Fin k} (h : TwoColourNhd C N a b) : a ≠ b := by
  rintro rfl
  have h2 := h.two.disj
  rw [inter_self] at h2
  exact h.two.h2a.volume_pos.ne' h2

/-- The two classes of a two-colour neighbourhood may be exchanged. -/
theorem TwoColourNhd.symm {C : Fin k → Set ℂ} {N : Set ℂ} {a b : Fin k} (h : TwoColourNhd C N a b) :
    TwoColourNhd C N b a :=
  ⟨fun j hjb hja => h.h1 j hja hjb, h.two.symm⟩

/-- **For a colouring (H1) and (H2) are FS111-M-PINCH's hypotheses**: the classes partition the plane, so two classes
with every other null in `N` cover `N` almost everywhere, and two different classes are disjoint. -/
theorem AeColouring.twoColourNhd_of_h1 (c : AeColouring k) {N : Set ℂ} (hN : IsOpen N) {a b : Fin k} (hab : a ≠ b)
    (h1 : H1On c.cls N a b) (h2a : H2On (c.cls a) N) (h2b : H2On (c.cls b) N) : TwoColourNhd c.cls N a b := by
  refine ⟨h1, hN, ?_, ?_, h2a, h2b⟩
  · rw [ae_le_set]
    refine measure_mono_null (t := ⋃ j : {j : Fin k // j ≠ a ∧ j ≠ b}, c.cls j ∩ N) ?_
      (measure_iUnion_null fun j => h1 j j.2.1 j.2.2)
    rintro z ⟨hzN, hz⟩
    exact mem_iUnion.2 ⟨⟨c.col z, fun h => hz (Or.inl h), fun h => hz (Or.inr h)⟩, rfl, hzN⟩
  · have h : c.cls a ∩ c.cls b ∩ N = ∅ := by
      ext z
      simp only [mem_inter_iff, mem_empty_iff_false, iff_false]
      rintro ⟨⟨hza, hzb⟩, -⟩
      exact hab ((show c.col z = a from hza).symm.trans hzb)
    rw [h, measure_empty]

/-- The interface set lies in the essential boundary and misses `Σ`. -/
theorem interfaceSet_subset_essBdry (C : Fin k → Set ℂ) : interfaceSet C ⊆ essBdry C := sdiff_subset

/-- `𝓘` and `Σ` are disjoint. -/
theorem disjoint_interfaceSet_singularSet (C : Fin k → Set ℂ) : Disjoint (interfaceSet C) (singularSet C) :=
  disjoint_sdiff_left

/-- At an interface point some ball centred there is a two-colour neighbourhood — the points FS111-M-PINCH reads. -/
theorem exists_twoColourNhd_of_mem_interfaceSet {C : Fin k → Set ℂ} {x : ℂ} (hx : x ∈ interfaceSet C) :
    ∃ ρ a b, TwoColourNhd C (ball x ρ) a b := by
  by_contra h
  exact hx.2 (Or.inl ⟨hx.1, h⟩)

/-- The radius of a two-colour ball is positive. -/
theorem TwoColourNhd.radius_pos {C : Fin k → Set ℂ} {x : ℂ} {ρ : ℝ} {a b : Fin k}
    (h : TwoColourNhd C (ball x ρ) a b) : 0 < ρ :=
  Metric.nonempty_ball.1 h.two.nonempty

/-- No class has a cusp at an interface point. -/
theorem not_isCuspAt_of_mem_interfaceSet {C : Fin k → Set ℂ} {x : ℂ} (hx : x ∈ interfaceSet C) (j : Fin k) :
    ¬ IsCuspAt (C j) x :=
  fun h => hx.2 (Or.inr ⟨j, h⟩)

/-- A cusp is a point of `Σ`. -/
theorem cuspSet_subset_singularSet (C : Fin k → Set ℂ) : cuspSet C ⊆ singularSet C := subset_union_right

/-- A family saturated on the plane is saturated on every set. -/
theorem Saturated.saturatedOn {C : Fin k → Set ℂ} (h : Saturated C) (U : Set ℂ) : SaturatedOn C U :=
  fun j x hx => h j x hx.1

/-- Spec: saturated on the plane is saturated. -/
theorem saturatedOn_univ {C : Fin k → Set ℂ} : SaturatedOn C univ ↔ Saturated C :=
  ⟨fun h j x hx => h j x ⟨hx, mem_univ x⟩, fun h => h.saturatedOn univ⟩

/-- Saturation on a set passes to its subsets. -/
theorem SaturatedOn.mono {C : Fin k → Set ℂ} {U V : Set ℂ} (h : SaturatedOn C V) (hUV : U ⊆ V) : SaturatedOn C U :=
  fun j x hx => h j x ⟨hx.1, hUV hx.2⟩

/-- Spec: the two discs read from the other side have the opposite normal. -/
theorem hasTwoDiscsAt_comm {A B N : Set ℂ} {x ν : ℂ} : HasTwoDiscsAt A B N x ν ↔ HasTwoDiscsAt B A N x (-ν) := by
  unfold HasTwoDiscsAt
  rw [norm_neg, sub_neg_eq_add, ← sub_eq_add_neg]
  exact ⟨fun ⟨h1, h2, h3⟩ => ⟨h1, h3, h2⟩, fun ⟨h1, h2, h3⟩ => ⟨h1, h3, h2⟩⟩

/-- Spec: the tangent type read from the other side has the opposite normal. -/
theorem isTangentAt_comm {A B N : Set ℂ} {x ν : ℂ} : IsTangentAt A B N x ν ↔ IsTangentAt B A N x (-ν) := by
  unfold IsTangentAt
  rw [← hasTwoDiscsAt_comm, sub_neg_eq_add, ← sub_eq_add_neg]
  exact ⟨fun ⟨h1, h2, h3⟩ => ⟨h1, h3, h2⟩, fun ⟨h1, h2, h3⟩ => ⟨h1, h3, h2⟩⟩

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

/-- (H2) for `sq9` in `B(sqEdgePt, 1/8)`, on the side `s (re z − 1/2) > 0` whose colour is `col`. -/
theorem sq9_h2_of_side (s : ℝ) (hs : s = 1 ∨ s = -1) (col : Fin 9)
    (hcol : ∀ z ∈ ball sqEdgePt (1 / 8), 0 < s * (z.re - 1 / 2) → sq9Col z = col)
    (hother : ∀ z ∈ ball sqEdgePt (1 / 8), s * (z.re - 1 / 2) < 0 → sq9Col z ≠ col) :
    H2On (sq9.cls col) (ball sqEdgePt (1 / 8)) := by
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
    subset_densitySet_of_isOpen_ae_subset hopen (Eventually.of_forall hsub), ?_⟩
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

/-- **Inhabitant of `TwoColourNhd`** (and of `TwoColourOn`, its field `two`): `sq9` at the edge point `1/2 + i/4`, in
the ball of radius `1/8`, with the colours of the two squares the edge separates. -/
theorem sq9_twoColourNhd : TwoColourNhd sq9.cls (ball sqEdgePt (1 / 8)) sqColA sqColB := by
  refine sq9.twoColourNhd_of_h1 isOpen_ball sqColA_ne_sqColB ?_ ?_ ?_
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

/-- The edge point is an interior point of the inhabitant's ball. -/
theorem sqEdgePt_mem_ball : sqEdgePt ∈ ball sqEdgePt (1 / 8) := mem_ball_self (by norm_num)

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
theorem sq9_hasTwoDiscsAt :
    HasTwoDiscsAt (sq9.cls sqColA) (sq9.cls sqColB) (ball sqEdgePt (1 / 8)) sqEdgePt 1 := by
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
