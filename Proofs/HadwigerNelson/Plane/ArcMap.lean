import Proofs.HadwigerNelson.Plane.Basic
import Mathlib.Analysis.Convex.PathConnected
import Mathlib.Analysis.Normed.Module.RCLike.Real
import Mathlib.Topology.Homeomorph.Lemmas

/-!
# Arc maps: valid maps and valid fragments, tiles, the colours at a point, Siamese pairs, simplicity

Lane M's foundation (`plans/FS131-kernel-plan.md` § 5), the definitions of `data/fs116/claims.md` § 0 made
formal. One structure carries both of the rows' objects:

* a **valid map** (FS-110, FS-112) is "a locally finite map of the plane bounded by segments and circular
  arcs, … carrying a six-colouring in which no two interior points of one colour are at distance
  exactly 1": an `ArcMap 6` with `IsPlaneMap` and `Valid`;
* a **valid `k`-coloured fragment on a disc `D`** (FS-114, FS-116) is "a map of an open set containing `D`,
  bounded by segments and circular arcs, `k`-coloured with no two interior points of one colour at
  distance exactly 1": an `ArcMap k` with `Covers p R` (`D = B̄(p, R)`) and `Valid`. "Valid fragment"
  alone means six-coloured.

The model is point-set, never combinatorial: `Γ` is the union of the arcs inside the domain, the **tiles**
are the connected components of the domain off `Γ` (`IsTile`), the colour is a function on the plane that
is locally constant off `Γ` (its values on `Γ` and off the domain are never read), and the colours at a
point `x` — the rows' `P_cl(x)`, "the colours of tiles whose closure contains `x`" — are the colours whose
region has `x` in its closure (`coloursAt`; equal to `P_cl` because the arcs are locally finite). So "a
vertex of at least four colours" is `4 ≤ (F.coloursAt p).ncard`, with no separate notion of vertex.

Classes are predicates on the one structure, never separate types (G86: the Siamese-allowed lemmas and the
class statements share their objects): `NonSiamese` (no two distinct tiles of one colour with every cross
distance below 1 — de Grey's "tiles that lie entirely within each other's annulus of exclusion"), `Simple`
("every tile an open disc whose closure meets each other tile's closure in a connected set or not at all,
and does not meet itself", read as: the closure of each tile is a closed disc with the tile as its
interior, and closures of distinct tiles meet in a preconnected set).

Wave 3's planner adds the ring vocabulary (germs, change points, arcs of `Γ` on `ω(p)`, their side colours,
(Q)); wave 4's the sectors, degrees, cones and the complexity class `𝓜_K`.

**Inhabitants.** `ArcMap.const` (no arcs, one colour) and `halfDisc` (two colours across a segment); the
spec examples below exhibit a valid one, an invalid one, a non-Siamese one, a Siamese pair, and a simple one.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- A boundary arc: a segment `[a, b]`, or the circular arc `{c + ρ e(θ) : θ ∈ [θ₀, θ₁]}`. -/
inductive Arc where
  /-- The segment from `a` to `b`. -/
  | seg (a b : ℂ)
  /-- The arc of the circle of centre `c` and radius `ρ` between the angles `θ₀` and `θ₁`. -/
  | circ (c : ℂ) (ρ θ₀ θ₁ : ℝ)

namespace Arc

/-- The points of an arc. -/
def carrier : Arc → Set ℂ
  | seg a b => segment ℝ a b
  | circ c ρ θ₀ θ₁ => (fun θ : ℝ => c + ρ * e θ) '' Icc θ₀ θ₁

/-- An arc of positive length that is not a whole circle. -/
def Nondegenerate : Arc → Prop
  | seg a b => a ≠ b
  | circ _ ρ θ₀ θ₁ => 0 < ρ ∧ θ₀ < θ₁ ∧ θ₁ ≤ θ₀ + 2 * π

/-- A **unit arc**: a boundary arc of radius `1`. -/
def IsUnitArc : Arc → Prop
  | seg _ _ => False
  | circ _ ρ _ _ => ρ = 1

end Arc

/-- A `k`-coloured map of an open set `dom`, bounded by a locally finite family of segments and circular
arcs, its colour locally constant off them. -/
structure ArcMap (k : ℕ) where
  /-- The open set the map covers. -/
  dom : Set ℂ
  /-- The domain is open. -/
  isOpen_dom : IsOpen dom
  /-- The boundary arcs. -/
  arcs : Set Arc
  /-- Every arc has positive length. -/
  nondegenerate : ∀ a ∈ arcs, a.Nondegenerate
  /-- Each point of the domain has a neighbourhood meeting finitely many arcs. -/
  locallyFinite : ∀ x ∈ dom, ∃ t ∈ 𝓝 x, {a | a ∈ arcs ∧ (a.carrier ∩ t).Nonempty}.Finite
  /-- The colour of each point (read only at interior points of the domain). -/
  col : ℂ → Fin k
  /-- The colour is locally constant at interior points. -/
  locallyConstant : ∀ x ∈ dom, x ∉ ⋃ a ∈ arcs, a.carrier → ∀ᶠ y in 𝓝 x, col y = col x

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- `Γ`: the boundary arcs inside the domain. -/
def Γ : Set ℂ := F.dom ∩ ⋃ a ∈ F.arcs, a.carrier

/-- The interior points: the domain off the arcs (the union of the tiles). -/
def interiorPts : Set ℂ := F.dom \ ⋃ a ∈ F.arcs, a.carrier

/-- The interior points of colour `j`. -/
def region (j : Fin k) : Set ℂ := F.interiorPts ∩ F.col ⁻¹' {j}

/-- A **tile**: a connected component of the interior points. -/
def IsTile (T : Set ℂ) : Prop := ∃ x ∈ F.interiorPts, T = connectedComponentIn F.interiorPts x

/-- `P_cl(x)`: the colours whose region has `x` in its closure. -/
def coloursAt (x : ℂ) : Set (Fin k) := {j | x ∈ closure (F.region j)}

/-- **Valid**: no two interior points of one colour at distance exactly `1`. -/
def Valid : Prop := ∀ x ∈ F.interiorPts, ∀ y ∈ F.interiorPts, dist x y = 1 → F.col x ≠ F.col y

/-- The map is a fragment on the closed disc `B̄(p, R)`: its domain contains the disc. -/
def Covers (p : ℂ) (R : ℝ) : Prop := closedBall p R ⊆ F.dom

/-- The map is a map of the whole plane. -/
def IsPlaneMap : Prop := F.dom = univ

/-- A **Siamese pair**: two distinct tiles of one colour with every cross distance below `1`. -/
def Siamese (T T' : Set ℂ) : Prop :=
  F.IsTile T ∧ F.IsTile T' ∧ T ≠ T' ∧ (∀ x ∈ T, ∀ y ∈ T', F.col x = F.col y) ∧
    ∀ x ∈ T, ∀ y ∈ T', dist x y < 1

/-- The map has no Siamese pair. -/
def NonSiamese : Prop := ∀ T T', ¬ F.Siamese T T'

/-- `T` is a Jordan domain: its closure is a closed disc with `T` as the disc's interior. -/
def IsJordanDomain (T : Set ℂ) : Prop :=
  ∃ h : closedBall (0 : ℂ) 1 ≃ₜ closure T, ∀ z, ((h z : ℂ) ∈ T ↔ (z : ℂ) ∈ ball (0 : ℂ) 1)

/-- **Simple**: every tile a Jordan domain, distinct tiles' closures meeting in a preconnected set. -/
def Simple : Prop :=
  (∀ T, F.IsTile T → IsJordanDomain T) ∧
    ∀ T T', F.IsTile T → F.IsTile T' → T ≠ T' → IsPreconnected (closure T ∩ closure T')

/-- With no arcs, the interior points are the domain. -/
theorem interiorPts_of_arcs_empty (h : F.arcs = ∅) : F.interiorPts = F.dom := by
  simp [interiorPts, h]

/-- The map of an open set with no arcs and one colour `j`. -/
def const (U : Set ℂ) (hU : IsOpen U) (j : Fin k) : ArcMap k where
  dom := U
  isOpen_dom := hU
  arcs := ∅
  nondegenerate := by simp
  locallyFinite := fun x _ => ⟨univ, univ_mem, by simp⟩
  col := fun _ => j
  locallyConstant := fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl

@[simp] theorem const_interiorPts (U : Set ℂ) (hU : IsOpen U) (j : Fin k) :
    (const U hU j).interiorPts = U := by
  simp [interiorPts, const]

end ArcMap

/-! ## The two-colour example: a small disc split by a segment -/

/-- A point of the closed segment `[-1/2, 1/2]` is real. -/
theorem im_eq_zero_of_mem_segment {z : ℂ} (hz : z ∈ segment ℝ (-1 / 2 : ℂ) (1 / 2)) : z.im = 0 := by
  obtain ⟨a, b, -, -, -, rfl⟩ := hz
  simp

/-- A real point of the disc of radius `1/3` lies on the segment `[-1/2, 1/2]`. -/
theorem mem_segment_of_im_eq_zero {z : ℂ} (hz : ‖z‖ < 1 / 3) (him : z.im = 0) :
    z ∈ segment ℝ (-1 / 2 : ℂ) (1 / 2) := by
  have hre : |z.re| < 1 / 3 := lt_of_le_of_lt (Complex.abs_re_le_norm z) hz
  rw [abs_lt] at hre
  refine ⟨1 / 2 - z.re, 1 / 2 + z.re, by linarith, by linarith, by ring, ?_⟩
  apply Complex.ext
  · simp; ring
  · simp [him]

/-- The disc of radius `1/3` split along the real axis: colour `1` above, `0` below. -/
noncomputable def halfDisc : ArcMap 2 where
  dom := ball 0 (1 / 3)
  isOpen_dom := isOpen_ball
  arcs := {Arc.seg (-1 / 2) (1 / 2)}
  nondegenerate := by
    intro a ha
    rw [mem_singleton_iff] at ha
    subst ha
    show (-1 / 2 : ℂ) ≠ 1 / 2
    intro h
    have := congrArg Complex.re h
    norm_num at this
  locallyFinite := fun x _ => ⟨univ, univ_mem, (finite_singleton _).subset fun a ha => ha.1⟩
  col := fun z => if 0 < z.im then 1 else 0
  locallyConstant := by
    intro x hx hΓ
    simp only [mem_iUnion, mem_singleton_iff, exists_prop, exists_eq_left, Arc.carrier] at hΓ
    have hx' : ‖x‖ < 1 / 3 := by simpa using hx
    have him : x.im ≠ 0 := fun h => hΓ (mem_segment_of_im_eq_zero hx' h)
    rcases lt_or_gt_of_ne him with h | h
    · filter_upwards [(isOpen_lt Complex.continuous_im continuous_const).mem_nhds h] with y hy
      simp [not_lt.mpr hy.le, not_lt.mpr h.le]
    · filter_upwards [(isOpen_lt continuous_const Complex.continuous_im).mem_nhds h] with y hy
      simp [hy, h]

/-- The arcs of `halfDisc` cover exactly the segment `[-1/2, 1/2]`. -/
theorem halfDisc_arcs_union : ⋃ a ∈ halfDisc.arcs, a.carrier = segment ℝ (-1 / 2 : ℂ) (1 / 2) := by
  show ⋃ a ∈ ({Arc.seg (-1 / 2) (1 / 2)} : Set Arc), a.carrier = _
  rw [Set.biUnion_singleton]
  rfl

/-- The interior points of `halfDisc` are the points of the disc off the real axis. -/
theorem halfDisc_mem_interiorPts {z : ℂ} : z ∈ halfDisc.interiorPts ↔ ‖z‖ < 1 / 3 ∧ z.im ≠ 0 := by
  rw [ArcMap.interiorPts, halfDisc_arcs_union, Set.mem_sdiff]
  show z ∈ ball 0 (1 / 3) ∧ _ ↔ _
  rw [mem_ball_zero_iff]
  constructor
  · rintro ⟨h, hs⟩
    exact ⟨h, fun him => hs (mem_segment_of_im_eq_zero h him)⟩
  · rintro ⟨h, him⟩
    exact ⟨h, fun hs => him (im_eq_zero_of_mem_segment hs)⟩

/-- `i t` is an interior point of `halfDisc` for `0 < |t| < 1/3`. -/
theorem halfDisc_I_mul_mem {t : ℝ} (h0 : t ≠ 0) (h1 : |t| < 1 / 3) :
    (t : ℂ) * I ∈ halfDisc.interiorPts := by
  rw [halfDisc_mem_interiorPts]
  refine ⟨?_, by simpa using h0⟩
  simpa [Complex.norm_mul, Complex.norm_I, Complex.norm_real] using h1

/-! ## Spec examples -/

/-- A one-colour fragment on a disc of radius `1/3` is valid: no two of its points are `1` apart. -/
example : (ArcMap.const (ball (0 : ℂ) (1 / 3)) isOpen_ball (0 : Fin 1)).Valid := by
  intro x hx y hy hxy
  simp only [ArcMap.const_interiorPts, mem_ball] at hx hy
  have := dist_triangle x 0 y
  rw [dist_comm 0 y] at this
  linarith

/-- **Adversary**: a one-colour fragment on the unit disc is not valid (`±1/2` are `1` apart). -/
example : ¬ (ArcMap.const (ball (0 : ℂ) 1) isOpen_ball (0 : Fin 1)).Valid := by
  intro h
  refine h (-1 / 2) ?_ (1 / 2) ?_ ?_ rfl
  · simp only [ArcMap.const_interiorPts, mem_ball, dist_zero_right]; norm_num
  · simp only [ArcMap.const_interiorPts, mem_ball, dist_zero_right]; norm_num
  · rw [dist_eq_norm]; norm_num

/-- Both colours are at the origin of `halfDisc`: `P_cl(0) = {0, 1}`. -/
example : halfDisc.coloursAt 0 = univ := by
  have key : ∀ s : ℝ, (s = 1 ∨ s = -1) → ∀ ε > 0, ∃ t : ℝ, t ≠ 0 ∧ |t| < 1 / 3 ∧ |t| < ε ∧
      (0 < s * t) := by
    intro s hs ε hε
    refine ⟨s * min (ε / 2) (1 / 6), ?_, ?_, ?_, ?_⟩
    · rcases hs with rfl | rfl <;> positivity
    · rcases hs with rfl | rfl <;>
      · simp only [one_mul, neg_one_mul, abs_neg]
        rw [abs_of_pos (by positivity)]
        exact lt_of_le_of_lt (min_le_right _ _) (by norm_num)
    · rcases hs with rfl | rfl <;>
      · simp only [one_mul, neg_one_mul, abs_neg]
        rw [abs_of_pos (by positivity)]
        exact lt_of_le_of_lt (min_le_left _ _) (by linarith)
    · rcases hs with rfl | rfl <;> nlinarith [lt_min (half_pos hε) (by norm_num : (0 : ℝ) < 1 / 6)]
  ext j
  simp only [ArcMap.coloursAt, mem_setOf_eq, mem_univ, iff_true, Metric.mem_closure_iff]
  intro ε hε
  have hs : ((if j = 1 then 1 else -1 : ℝ) = 1 ∨ (if j = 1 then 1 else -1 : ℝ) = -1) := by
    split_ifs <;> simp
  obtain ⟨t, ht0, ht1, htε, hst⟩ := key _ hs ε hε
  refine ⟨(t : ℂ) * I, ⟨halfDisc_I_mul_mem ht0 ht1, ?_⟩, ?_⟩
  · simp only [mem_preimage, mem_singleton_iff, halfDisc, mul_im, ofReal_re, I_im, mul_one,
      ofReal_im, I_re, mul_zero, add_zero]
    fin_cases j
    · simp at hst; simp [not_lt.mpr (by linarith : t ≤ 0)]
    · simp at hst; simp [hst]
  · simpa [Complex.norm_mul, Complex.norm_I, Complex.norm_real] using htε

/-- `halfDisc` recoloured with one colour: the same two tiles, now a Siamese pair. -/
noncomputable def halfDiscMono : ArcMap 2 :=
  { halfDisc with
    col := fun _ => 0
    locallyConstant := fun _ _ _ => Filter.Eventually.of_forall fun _ => rfl }

/-- The tile of `halfDisc` through an upper interior point is the upper half-disc. -/
theorem halfDisc_component_upper {x : ℂ} (hx : x ∈ halfDisc.interiorPts) (h : 0 < x.im) :
    connectedComponentIn halfDisc.interiorPts x = {z | ‖z‖ < 1 / 3 ∧ 0 < z.im} := by
  have hH : {z : ℂ | ‖z‖ < 1 / 3 ∧ 0 < z.im} ⊆ halfDisc.interiorPts := fun z hz =>
    halfDisc_mem_interiorPts.mpr ⟨hz.1, hz.2.ne'⟩
  have hconv : Convex ℝ {z : ℂ | ‖z‖ < 1 / 3 ∧ 0 < z.im} := by
    have : {z : ℂ | ‖z‖ < 1 / 3 ∧ 0 < z.im} = ball 0 (1 / 3) ∩ {z | 0 < z.im} := by
      ext z; simp
    rw [this]
    exact (convex_ball 0 _).inter (convex_halfSpace_gt (f := Complex.imLm) Complex.imLm.isLinear 0)
  refine Subset.antisymm ?_ (hconv.isPreconnected.subset_connectedComponentIn
    ⟨(halfDisc_mem_interiorPts.mp hx).1, h⟩ hH)
  have hsplit : connectedComponentIn halfDisc.interiorPts x ⊆ {z | 0 < z.im} ∪ {z | z.im < 0} := by
    intro z hz
    have := (halfDisc_mem_interiorPts.mp (connectedComponentIn_subset _ _ hz)).2
    rcases lt_or_gt_of_ne this with h' | h'
    · exact Or.inr h'
    · exact Or.inl h'
  rcases isPreconnected_connectedComponentIn.subset_or_subset
      (isOpen_lt continuous_const Complex.continuous_im)
      (isOpen_lt Complex.continuous_im continuous_const)
      (Set.disjoint_left.mpr fun z (h1 : 0 < z.im) (h2 : z.im < 0) => lt_asymm h1 h2) hsplit with h1 | h1
  · intro z hz
    exact ⟨(halfDisc_mem_interiorPts.mp (connectedComponentIn_subset _ _ hz)).1, h1 hz⟩
  · exact absurd (h1 (mem_connectedComponentIn hx)) (not_lt.mpr h.le)

/-- The tile of `halfDisc` through a lower interior point is the lower half-disc. -/
theorem halfDisc_component_lower {x : ℂ} (hx : x ∈ halfDisc.interiorPts) (h : x.im < 0) :
    connectedComponentIn halfDisc.interiorPts x = {z | ‖z‖ < 1 / 3 ∧ z.im < 0} := by
  have hH : {z : ℂ | ‖z‖ < 1 / 3 ∧ z.im < 0} ⊆ halfDisc.interiorPts := fun z hz =>
    halfDisc_mem_interiorPts.mpr ⟨hz.1, hz.2.ne⟩
  have hconv : Convex ℝ {z : ℂ | ‖z‖ < 1 / 3 ∧ z.im < 0} := by
    have : {z : ℂ | ‖z‖ < 1 / 3 ∧ z.im < 0} = ball 0 (1 / 3) ∩ {z | z.im < 0} := by
      ext z; simp
    rw [this]
    exact (convex_ball 0 _).inter (convex_halfSpace_lt (f := Complex.imLm) Complex.imLm.isLinear 0)
  refine Subset.antisymm ?_ (hconv.isPreconnected.subset_connectedComponentIn
    ⟨(halfDisc_mem_interiorPts.mp hx).1, h⟩ hH)
  have hsplit : connectedComponentIn halfDisc.interiorPts x ⊆ {z | 0 < z.im} ∪ {z | z.im < 0} := by
    intro z hz
    have := (halfDisc_mem_interiorPts.mp (connectedComponentIn_subset _ _ hz)).2
    rcases lt_or_gt_of_ne this with h' | h'
    · exact Or.inr h'
    · exact Or.inl h'
  rcases isPreconnected_connectedComponentIn.subset_or_subset
      (isOpen_lt continuous_const Complex.continuous_im)
      (isOpen_lt Complex.continuous_im continuous_const)
      (Set.disjoint_left.mpr fun z (h1 : 0 < z.im) (h2 : z.im < 0) => lt_asymm h1 h2) hsplit with h1 | h1
  · exact absurd (h1 (mem_connectedComponentIn hx)) (not_lt.mpr h.le)
  · intro z hz
    exact ⟨(halfDisc_mem_interiorPts.mp (connectedComponentIn_subset _ _ hz)).1, h1 hz⟩

/-- `halfDisc` has no Siamese pair: its two tiles have different colours. -/
example : halfDisc.NonSiamese := by
  rintro T T' ⟨⟨x, hx, rfl⟩, ⟨y, hy, rfl⟩, hne, hcol, -⟩
  have hxy := hcol x (mem_connectedComponentIn hx) y (mem_connectedComponentIn hy)
  have hx0 := (halfDisc_mem_interiorPts.mp hx).2
  have hy0 := (halfDisc_mem_interiorPts.mp hy).2
  simp only [halfDisc] at hxy
  rcases lt_or_gt_of_ne hx0 with hxn | hxp <;> rcases lt_or_gt_of_ne hy0 with hyn | hyp
  · exact hne (by rw [halfDisc_component_lower hx hxn, halfDisc_component_lower hy hyn])
  · simp [not_lt.mpr hxn.le, hyp] at hxy
  · simp [hxp, not_lt.mpr hyn.le] at hxy
  · exact hne (by rw [halfDisc_component_upper hx hxp, halfDisc_component_upper hy hyp])

/-- **Adversary**: recoloured with one colour, the two tiles of `halfDisc` are a Siamese pair. -/
example : ¬ halfDiscMono.NonSiamese := by
  have hu : ((1 / 6 : ℝ) : ℂ) * I ∈ halfDisc.interiorPts :=
    halfDisc_I_mul_mem (by norm_num) (by rw [abs_of_pos (by norm_num)]; norm_num)
  have hl : ((-1 / 6 : ℝ) : ℂ) * I ∈ halfDisc.interiorPts :=
    halfDisc_I_mul_mem (by norm_num) (by rw [abs_of_neg (by norm_num)]; norm_num)
  have hU := halfDisc_component_upper hu (by simp)
  have hL := halfDisc_component_lower hl (by norm_num)
  intro h
  refine h (connectedComponentIn halfDisc.interiorPts (((1 / 6 : ℝ) : ℂ) * I))
    (connectedComponentIn halfDisc.interiorPts (((-1 / 6 : ℝ) : ℂ) * I))
    ⟨⟨_, hu, rfl⟩, ⟨_, hl, rfl⟩, ?_, fun _ _ _ _ => rfl, ?_⟩
  · rw [hU, hL]
    intro heq
    have : ((1 / 6 : ℝ) : ℂ) * I ∈ {z : ℂ | ‖z‖ < 1 / 3 ∧ z.im < 0} := by
      rw [← heq]; exact ⟨by simpa [Complex.norm_mul, Complex.norm_I, Complex.norm_real] using
        (by rw [abs_of_pos (by norm_num)]; norm_num : |(1 / 6 : ℝ)| < 1 / 3), by simp⟩
    have h2 := this.2
    simp at h2
    linarith
  · rw [hU, hL]
    rintro a ⟨ha, -⟩ b ⟨hb, -⟩
    have := dist_triangle a 0 b
    rw [dist_comm 0 b, dist_zero_right, dist_zero_right] at this
    linarith

/-- A one-colour map of the open unit disc with no arcs is simple: its one tile is the disc. -/
example (j : Fin 2) : (ArcMap.const (ball (0 : ℂ) 1) isOpen_ball j).Simple := by
  have htile : ∀ T, (ArcMap.const (ball (0 : ℂ) 1) isOpen_ball j).IsTile T → T = ball 0 1 := by
    rintro T ⟨x, hx, rfl⟩
    rw [ArcMap.const_interiorPts] at hx ⊢
    exact (convex_ball (0 : ℂ) 1).isPreconnected.connectedComponentIn hx
  refine ⟨fun T hT => ?_, fun T T' hT hT' hne => absurd ((htile T hT).trans (htile T' hT').symm) hne⟩
  rw [htile T hT]
  exact ⟨Homeomorph.setCongr (closure_ball (0 : ℂ) one_ne_zero).symm, fun z => Iff.rfl⟩

end HadwigerNelson.Plane
