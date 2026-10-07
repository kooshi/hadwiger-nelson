import Proofs.HadwigerNelson.Plane.ValidMap.MapTopology
import Mathlib.Topology.UnitInterval
import Mathlib.Data.Fin.Tuple.Sort

/-!
# Three arcs from a point of a disc to its rim: every two regions of the cut disc share an arc (FS-124; job FS124-K3)

The plane topology under the claim list's **sector point** (`data/fs124/claims-K2.md`: "three arcs J_0, J_1, J_2
(homeomorphic images of [0, 1]) from x to the circle ∂B(x, r), inside B(x, r) but for their far ends and disjoint but for
x, such that the three components of B(x, r) ∖ (J_0 ∪ J_1 ∪ J_2) are the pieces"). Pure topology of `ℂ`: no colouring,
no measure. Plan: `plans/FS124-kernel-plan-3.md`.

**What is proved, and what is not.** The classical θ-curve theorem has two halves: the cut disc has exactly three
components, and each arc borders exactly two of them. A sector point is *given* with its three pieces filling the cut
disc, so only the second half is needed, and only it is here: **given** three open preconnected pairwise disjoint sets
whose union is the disc less the arcs (`IsTriodCut`), each arc lies in the closures of exactly two of them and every two
of them share one arc (`IsTriodCut.exists_opposite`). That the cut disc has no fourth component is not proved and not
used. No Jordan curve theorem is read: the inputs are this library's unicoherence of the plane
(`isPreconnected_inter_of_union_eq_univ`) and its crossing lemma (`inter_nonempty_of_interleaved_radius`).

* `ballRetract u r` — the radial retraction of the plane onto `B̄(u, r)`; `isPreconnected_inter_of_union_eq_closedBall`
  — **the closed disc is unicoherent** (two closed preconnected sets covering it meet in a preconnected set): the
  plane's unicoherence pulled back along the retraction, whose fibres are points and closed rays.
* `IsTriod x r J` — three arcs from `x` to the rim of `B(x, r)`, in the claim list's five clauses.
  `IsTriod.range_subset_of_isPreconnected` — a preconnected subset of the three arcs that holds two far ends holds
  the whole arc to each. `RimOrder x r J a b c α β γ` — the far ends in their order round the rim, at angles
  `α < β < γ < α + 2π`; the order is cyclic (`RimOrder.rotate`), and it exists (`IsTriod.exists_rimOrder`).
  `IsTriod.not_mem_closure_both_sides` — **no preconnected set of the closed disc off two of the arcs reaches the rim on
  both sides of their far ends** (the crossing lemma).
* `IsTriodCut x r J P` — the triod with three pieces `P 0`, `P 1`, `P 2` filling the cut disc.
  `IsTriodCut.exists_unique_mem_closure` — a rim point off the far ends is in the closure of exactly one piece;
  `IsTriodCut.exists_forall_rimArc` — and of the same piece all along an arc of the rim between far ends;
  `IsTriodCut.closure_inter_closure_subset` — two pieces' closures meet on the arcs only;
  `IsTriodCut.ne_of_rimOrder` — the pieces at consecutive arcs of the rim are different;
  `IsTriodCut.isPreconnected_closure_inter` — **the part of the three arcs in the closure of one piece is
  preconnected** (unicoherence of the disc: the piece's closure against the arcs and the other two closures);
  `IsTriodCut.exists_rimPieces` — the pieces at the three arcs of the rim are three; `IsTriodCut.rimPiece_spec` —
  the piece at an arc of the rim has the two arcs to its ends in its closure, whole, and of the third arc the point
  `x` only.
* `IsTriodCut.exists_opposite` — **the θ-lemma**: a bijection from arcs to pieces, the piece *opposite* an arc; the arc
  lies in the closure of each of the two other pieces and meets the closure of its opposite piece at `x` only.
  Corollaries: `exists_range_subset` (every two pieces share a whole arc), `closure_inter_closure_inter_ball` (inside
  the disc the common boundary of two pieces **is** that arc), `mem_closure`, and `exists_arc` — the form
  `ThreePiece.IsSector.hasArcEdges` (`Plane/SectorPoint`) reads: every two pieces share an arc from `x` inside any
  given neighbourhood of `x`.

**Inhabitant of `IsTriodCut`**: the ordinary three-sector point — the radii along `1`, `i`, `−1 − i` of the disc of
radius `1/4` about `0` and its three sectors: `sectorPoint_isSector` (`Plane/SectorPoint`), whose data is an
`IsTriodCut` field for field. `ballRetract`'s spec: at radius `1` it is `discRetract` (`ballRetract_one`).
-/

namespace HadwigerNelson.Plane

open Complex Set Topology Metric

/-! ## The closed disc is unicoherent -/

/-- The radial retraction of the plane onto the closed disc `B̄(u, r)`: the identity on the disc, and outside it the
point of the rim on the same ray from `u`. (For `r > 0`; at `r = 1` it is `discRetract u`.) -/
noncomputable def ballRetract (u : ℂ) (r : ℝ) (z : ℂ) : ℂ := u + ((r / max r ‖z - u‖ : ℝ) : ℂ) * (z - u)

/-- Spec: at radius `1` the retraction is `discRetract`. -/
theorem ballRetract_one (u : ℂ) : ballRetract u 1 = discRetract u := by
  funext z
  simp only [ballRetract, discRetract, one_div]

/-- The radial retraction is continuous. -/
theorem continuous_ballRetract (u : ℂ) {r : ℝ} (hr : 0 < r) : Continuous (ballRetract u r) := by
  have hm : ∀ z : ℂ, max r ‖z - u‖ ≠ 0 := fun z => (lt_of_lt_of_le hr (le_max_left _ _)).ne'
  exact continuous_const.add ((Complex.continuous_ofReal.comp
    (continuous_const.div (continuous_const.max (continuous_norm.comp (continuous_id.sub continuous_const))) hm)).mul
    (continuous_id.sub continuous_const))

/-- The radial retraction lands in `B̄(u, r)`. -/
theorem ballRetract_mem (u : ℂ) {r : ℝ} (hr : 0 < r) (z : ℂ) : ballRetract u r z ∈ closedBall u r := by
  have hm : 0 < max r ‖z - u‖ := lt_of_lt_of_le hr (le_max_left _ _)
  rw [mem_closedBall, dist_eq_norm, ballRetract, add_sub_cancel_left, norm_mul, Complex.norm_real,
    Real.norm_of_nonneg (div_nonneg hr.le hm.le), div_mul_eq_mul_div, div_le_iff₀ hm]
  exact mul_le_mul_of_nonneg_left (le_max_right _ _) hr.le

/-- The radial retraction fixes `B̄(u, r)`. -/
theorem ballRetract_of_mem {u : ℂ} {r : ℝ} (hr : 0 < r) {z : ℂ} (hz : z ∈ closedBall u r) :
    ballRetract u r z = z := by
  rw [mem_closedBall, dist_eq_norm] at hz
  rw [ballRetract, max_eq_left hz, div_self hr.ne']
  simp

/-- The radial retraction is constant on the segment from a point's image to the point: its fibres are points and
closed rays. -/
theorem ballRetract_of_mem_segment {u : ℂ} {r : ℝ} (hr : 0 < r) (z : ℂ) {w : ℂ}
    (hw : w ∈ segment ℝ (ballRetract u r z) z) : ballRetract u r w = ballRetract u r z := by
  obtain ⟨a, b, ha, hb, hab, rfl⟩ := hw
  rcases le_or_gt ‖z - u‖ r with hd | hd
  · have hz : ballRetract u r z = z := ballRetract_of_mem hr (by rwa [mem_closedBall, dist_eq_norm])
    rw [hz, ← add_smul, hab, one_smul, hz]
  · have hd0 : 0 < ‖z - u‖ := hr.trans hd
    have hz : ballRetract u r z = u + ((r / ‖z - u‖ : ℝ) : ℂ) * (z - u) := by
      rw [ballRetract, max_eq_right hd.le]
    obtain ⟨lam, hlam⟩ : ∃ lam : ℝ, lam = a * (r / ‖z - u‖) + b := ⟨_, rfl⟩
    have habc : (a : ℂ) + b = 1 := by exact_mod_cast hab
    have hw : a • ballRetract u r z + b • z - u = (lam : ℂ) * (z - u) := by
      rw [hz, hlam, Complex.real_smul, Complex.real_smul]
      push_cast
      linear_combination u * habc
    have hmul : lam * ‖z - u‖ = a * r + b * ‖z - u‖ := by
      rw [hlam]
      field_simp
    have har : a * r + b * r = r := by rw [← add_mul, hab, one_mul]
    have hge : r ≤ lam * ‖z - u‖ := by
      rw [hmul]
      nlinarith [mul_le_mul_of_nonneg_left hd.le hb]
    have hlam0 : 0 < lam := (mul_pos_iff_of_pos_right hd0).mp (hr.trans_le hge)
    have hnorm : ‖(lam : ℂ) * (z - u)‖ = lam * ‖z - u‖ := by
      rw [norm_mul, Complex.norm_real, Real.norm_of_nonneg hlam0.le]
    have h1 : (lam : ℂ) ≠ 0 := by exact_mod_cast hlam0.ne'
    have h2 : ((‖z - u‖ : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hd0.ne'
    rw [ballRetract, hw, hnorm, max_eq_right hge, hz]
    congr 1
    push_cast
    field_simp

/-- The preimage under the radial retraction of a preconnected subset of the disc is preconnected: it is the set
together with a segment to each further point of the preimage. -/
theorem isPreconnected_preimage_ballRetract {u : ℂ} {r : ℝ} (hr : 0 < r) {A : Set ℂ} (hA : IsPreconnected A)
    (hAd : A ⊆ closedBall u r) : IsPreconnected (ballRetract u r ⁻¹' A) := by
  rcases A.eq_empty_or_nonempty with rfl | ⟨a₀, ha₀⟩
  · rw [preimage_empty]
    exact isPreconnected_empty
  have hfix : ∀ a ∈ A, ballRetract u r a = a := fun a ha => ballRetract_of_mem hr (hAd ha)
  have heq : ballRetract u r ⁻¹' A =
      ⋃ z : {z // z ∈ ballRetract u r ⁻¹' A}, (A ∪ segment ℝ (ballRetract u r z) z) := by
    ext w
    constructor
    · intro hw
      exact mem_iUnion.mpr ⟨⟨w, hw⟩, Or.inr (right_mem_segment ℝ _ _)⟩
    · intro hw
      obtain ⟨⟨z, hz⟩, hw | hw⟩ := mem_iUnion.mp hw
      · show ballRetract u r w ∈ A
        rw [hfix w hw]
        exact hw
      · show ballRetract u r w ∈ A
        rw [ballRetract_of_mem_segment hr z hw]
        exact hz
  rw [heq]
  refine isPreconnected_iUnion ⟨a₀, mem_iInter.mpr fun _ => Or.inl ha₀⟩ fun ⟨z, hz⟩ => ?_
  exact IsPreconnected.union (ballRetract u r z) hz (left_mem_segment ℝ _ _) hA (convex_segment _ _).isPreconnected

/-- **The closed disc is unicoherent**: two closed preconnected sets whose union is `B̄(u, r)` meet in a preconnected
set. (The plane's unicoherence, `isPreconnected_inter_of_union_eq_univ`, for the two preimages under the radial
retraction; the retraction maps their intersection onto `A ∩ B`.) Inhabitant of the hypotheses: the two closed halves
of a disc — `isPreconnected_inter_halves`. -/
theorem isPreconnected_inter_of_union_eq_closedBall {u : ℂ} {r : ℝ} (hr : 0 < r) {A B : Set ℂ} (hA : IsClosed A)
    (hB : IsClosed B) (hA' : IsPreconnected A) (hB' : IsPreconnected B) (hAB : A ∪ B = closedBall u r) :
    IsPreconnected (A ∩ B) := by
  have hρc : Continuous (ballRetract u r) := continuous_ballRetract u hr
  have hAd : A ⊆ closedBall u r := hAB ▸ subset_union_left
  have hBd : B ⊆ closedBall u r := hAB ▸ subset_union_right
  have huniv : ballRetract u r ⁻¹' A ∪ ballRetract u r ⁻¹' B = univ := by
    rw [← preimage_union, hAB]
    exact eq_univ_of_forall fun z => ballRetract_mem u hr z
  have key := isPreconnected_inter_of_union_eq_univ (hA.preimage hρc) (hB.preimage hρc)
    (isPreconnected_preimage_ballRetract hr hA' hAd) (isPreconnected_preimage_ballRetract hr hB' hBd) huniv
  have himg : ballRetract u r '' (ballRetract u r ⁻¹' A ∩ ballRetract u r ⁻¹' B) = A ∩ B := by
    rw [← preimage_inter]
    refine Subset.antisymm (image_preimage_subset _ _) fun z hz => ⟨z, ?_, ballRetract_of_mem hr (hAd hz.1)⟩
    show ballRetract u r z ∈ A ∩ B
    rw [ballRetract_of_mem hr (hAd hz.1)]
    exact hz
  rw [← himg]
  exact key.image _ hρc.continuousOn

/-- **Inhabitant of the hypotheses of `isPreconnected_inter_of_union_eq_closedBall`**: the left and the right closed
half of the unit disc; the theorem says their common part (a diameter) is preconnected. -/
theorem isPreconnected_inter_halves :
    IsPreconnected ((closedBall (0 : ℂ) 1 ∩ {z | z.re ≤ 0}) ∩ (closedBall (0 : ℂ) 1 ∩ {z | 0 ≤ z.re})) := by
  refine isPreconnected_inter_of_union_eq_closedBall (u := 0) one_pos
    (isClosed_closedBall.inter (isClosed_le Complex.continuous_re continuous_const))
    (isClosed_closedBall.inter (isClosed_le continuous_const Complex.continuous_re))
    ((convex_closedBall _ _).inter (convex_halfSpace_re_le 0)).isPreconnected
    ((convex_closedBall _ _).inter (convex_halfSpace_re_ge 0)).isPreconnected ?_
  rw [← inter_union_distrib_left]
  refine inter_eq_left.mpr fun z _ => ?_
  exact le_total z.re 0

/-! ## Three arcs from a point to the rim -/

/-- **Three arcs from `x` to the rim of the disc of radius `r` about `x`** (`data/fs124/claims-K2.md`, the sector
point's arcs): "three arcs J_0, J_1, J_2 (homeomorphic images of [0, 1]) from x to the circle ∂B(x, r), inside B(x, r)
but for their far ends and disjoint but for x". An arc is an injective continuous map of `[0, 1]`. -/
structure IsTriod (x : ℂ) (r : ℝ) (J : Fin 3 → C(unitInterval, ℂ)) : Prop where
  /-- The radius is positive. -/
  pos : 0 < r
  /-- Each arc is injective. -/
  injective : ∀ m, Function.Injective (J m)
  /-- Each arc starts at `x`. -/
  apply_zero : ∀ m, J m 0 = x
  /-- Each arc ends on the rim. -/
  dist_apply_one : ∀ m, dist (J m 1) x = r
  /-- Each arc is inside the open disc but for its far end. -/
  dist_lt : ∀ m t, t ≠ 1 → dist (J m t) x < r
  /-- Two of the arcs meet at `x` only. -/
  eq_center_of_ne : ∀ m m' s t, m ≠ m' → J m s = J m' t → J m s = x

/-- **The cut disc in three pieces**: three arcs from `x` to the rim of `B(x, r)`, and three open preconnected pairwise
disjoint sets whose union is the disc less the arcs. (Three such sets are the components of the cut disc; that it has
three components is the hypothesis, not a conclusion.) -/
structure IsTriodCut (x : ℂ) (r : ℝ) (J : Fin 3 → C(unitInterval, ℂ)) (P : Fin 3 → Set ℂ) : Prop
    extends IsTriod x r J where
  /-- The pieces are open. -/
  isOpen : ∀ i, IsOpen (P i)
  /-- The pieces are preconnected. -/
  isPreconnected : ∀ i, IsPreconnected (P i)
  /-- The pieces are pairwise disjoint. -/
  disjoint : ∀ i j, i ≠ j → Disjoint (P i) (P j)
  /-- The pieces fill the disc less the arcs. -/
  iUnion_eq : ⋃ i, P i = ball x r \ ⋃ m, range (J m)

/-- **The far ends in their order round the rim**: `a`, `b`, `c` are the three arcs, and their far ends are the points of
the rim at angles `α < β < γ < α + 2π`. The order is cyclic, not linear: `RimOrder.rotate` turns it by one arc, and
every statement about "the arc of the rim from the far end of `J a` to that of `J b`" is proved once and read at the
three rotations. -/
structure RimOrder (x : ℂ) (r : ℝ) (J : Fin 3 → C(unitInterval, ℂ)) (a b c : Fin 3) (α β γ : ℝ) : Prop where
  /-- The first two arcs are different. -/
  ne_ab : a ≠ b
  /-- The last two arcs are different. -/
  ne_bc : b ≠ c
  /-- The last and the first arc are different. -/
  ne_ca : c ≠ a
  /-- The far end of the first arc. -/
  apply_a : J a 1 = polarPt x r α
  /-- The far end of the second arc. -/
  apply_b : J b 1 = polarPt x r β
  /-- The far end of the third arc. -/
  apply_c : J c 1 = polarPt x r γ
  /-- The first angle is below the second. -/
  lt_ab : α < β
  /-- The second angle is below the third. -/
  lt_bc : β < γ
  /-- The third angle is less than a turn above the first. -/
  lt_ca : γ < α + 2 * Real.pi

/-- **The order round the rim is cyclic**: turned by one arc it is an order round the rim. -/
theorem RimOrder.rotate {x : ℂ} {r : ℝ} {J : Fin 3 → C(unitInterval, ℂ)} {a b c : Fin 3} {α β γ : ℝ}
    (ho : RimOrder x r J a b c α β γ) : RimOrder x r J b c a β γ (α + 2 * Real.pi) := by
  refine ⟨ho.ne_bc, ho.ne_ca, ho.ne_ab, ho.apply_b, ho.apply_c, ?_, ho.lt_bc, ho.lt_ca, by linarith [ho.lt_ab]⟩
  rw [ho.apply_a, polarPt, polarPt, e_add_two_pi]

/-- The three arcs of an order round the rim are all the arcs. -/
theorem RimOrder.eq_or {x : ℂ} {r : ℝ} {J : Fin 3 → C(unitInterval, ℂ)} {a b c : Fin 3} {α β γ : ℝ}
    (ho : RimOrder x r J a b c α β γ) (m : Fin 3) : m = a ∨ m = b ∨ m = c := by
  have h1 := ho.ne_ab
  have h2 := ho.ne_bc
  have h3 := ho.ne_ca
  clear ho
  revert a b c m
  decide

/-- The union of three arcs is closed. -/
theorem isClosed_iUnion_range_arc (J : Fin 3 → C(unitInterval, ℂ)) : IsClosed (⋃ m, range (J m)) := by
  exact isClosed_iUnion_of_finite fun m => (isCompact_range (J m).continuous).isClosed

/-- **An arc from a point has an initial part inside any neighbourhood of the point**: an arc with the same start whose
range lies in the given arc and in the neighbourhood. -/
theorem exists_arc_range_subset_inter {X : Type*} [TopologicalSpace X] {γ : C(unitInterval, X)}
    (hγ : Function.Injective γ) {N : Set X} (hN : N ∈ 𝓝 (γ 0)) :
    ∃ γ' : C(unitInterval, X), Function.Injective γ' ∧ γ' 0 = γ 0 ∧ range γ' ⊆ range γ ∩ N := by
  obtain ⟨δ, hδ, hball⟩ := Metric.mem_nhds_iff.mp (γ.continuous.continuousAt.preimage_mem_nhds hN)
  obtain ⟨d, hd⟩ : ∃ d : ℝ, d = min (δ / 2) 1 := ⟨_, rfl⟩
  have hd0 : 0 < d := hd ▸ lt_min (half_pos hδ) one_pos
  have hd1 : d ≤ 1 := hd ▸ min_le_right _ _
  have hdδ : d < δ := hd ▸ (min_le_left _ _).trans_lt (half_lt_self hδ)
  have hmem : ∀ t : unitInterval, d * (t : ℝ) ∈ Icc (0 : ℝ) 1 := fun t =>
    ⟨mul_nonneg hd0.le t.2.1, mul_le_one₀ hd1 t.2.1 t.2.2⟩
  have hf : Continuous fun t : unitInterval => (⟨d * (t : ℝ), hmem t⟩ : unitInterval) :=
    (continuous_const.mul continuous_subtype_val).subtype_mk _
  refine ⟨⟨fun t => γ ⟨d * (t : ℝ), hmem t⟩, γ.continuous.comp hf⟩, fun s t hst => ?_, ?_, ?_⟩
  · exact Subtype.ext (mul_left_cancel₀ hd0.ne' (congrArg Subtype.val (hγ hst)))
  · show γ ⟨d * ((0 : unitInterval) : ℝ), hmem 0⟩ = γ 0
    congr 1
    exact Subtype.ext (by simp)
  · rintro _ ⟨t, rfl⟩
    refine ⟨⟨_, rfl⟩, hball ?_⟩
    rw [mem_ball, Subtype.dist_eq, Real.dist_eq]
    show |d * (t : ℝ) - ((0 : unitInterval) : ℝ)| < δ
    rw [Set.Icc.coe_zero, sub_zero, abs_of_nonneg (mul_nonneg hd0.le t.2.1)]
    exact (mul_le_of_le_one_right hd0.le t.2.2).trans_lt hdδ

namespace IsTriod

variable {x : ℂ} {r : ℝ} {J : Fin 3 → C(unitInterval, ℂ)}

/-- The arcs lie in the closed disc. -/
theorem apply_mem_closedBall (h : IsTriod x r J) (m : Fin 3) (t : unitInterval) : J m t ∈ closedBall x r := by
  rw [mem_closedBall]
  by_cases ht : t = 1
  · rw [ht, h.dist_apply_one m]
  · exact (h.dist_lt m t ht).le

/-- An arc is in the open disc before its far end. -/
theorem apply_mem_ball (h : IsTriod x r J) (m : Fin 3) {t : unitInterval} (ht : t ≠ 1) : J m t ∈ ball x r := by
  exact mem_ball.mpr (h.dist_lt m t ht)

/-- A far end is on the rim. -/
theorem apply_one_mem_sphere (h : IsTriod x r J) (m : Fin 3) : J m 1 ∈ sphere x r := by
  exact mem_sphere.mpr (h.dist_apply_one m)

/-- An arc meets the rim at its far end only. -/
theorem eq_one_of_mem_sphere (h : IsTriod x r J) {m : Fin 3} {t : unitInterval} (ht : J m t ∈ sphere x r) :
    t = 1 := by
  by_contra hne
  exact (h.dist_lt m t hne).ne (mem_sphere.mp ht)

/-- The three far ends are distinct. -/
theorem apply_one_ne (h : IsTriod x r J) {m m' : Fin 3} (hmm : m ≠ m') : J m 1 ≠ J m' 1 := by
  intro he
  have hx := h.eq_center_of_ne m m' 1 1 hmm he
  have hd := h.dist_apply_one m
  rw [hx, dist_self] at hd
  exact h.pos.ne hd

/-- The union of two of the arcs is preconnected: they share `x`. -/
theorem isPreconnected_range_union_range (h : IsTriod x r J) (a b : Fin 3) :
    IsPreconnected (range (J a) ∪ range (J b)) := by
  exact IsPreconnected.union x ⟨0, h.apply_zero a⟩ ⟨0, h.apply_zero b⟩ (isPreconnected_range (J a).continuous)
    (isPreconnected_range (J b).continuous)

/-- The union of the three arcs is preconnected: they share `x`. -/
theorem isPreconnected_iUnion_range (h : IsTriod x r J) : IsPreconnected (⋃ m, range (J m)) := by
  exact isPreconnected_iUnion ⟨x, mem_iInter.mpr fun m => ⟨0, h.apply_zero m⟩⟩ fun m =>
    isPreconnected_range (J m).continuous

/-- A point at radius `r` about `x` is on the rim. -/
theorem polarPt_mem_sphere (h : IsTriod x r J) (ξ : ℝ) : polarPt x r ξ ∈ sphere x r := by
  rw [mem_sphere, dist_eq_norm, norm_polarPt_sub, abs_of_pos h.pos]

/-- **A preconnected subset of the three arcs that holds two far ends holds the whole arc to each**: were a point
`J m s₀` missing, the part of `J m` beyond it and the rest of the three arcs would be two closed sets covering the
subset, each meeting it, with only that point in common. -/
theorem range_subset_of_isPreconnected (h : IsTriod x r J) {Z : Set ℂ} (hZ : IsPreconnected Z)
    (hZT : Z ⊆ ⋃ m, range (J m)) {m m' : Fin 3} (hmm : m ≠ m') (hm : J m 1 ∈ Z) (hm' : J m' 1 ∈ Z) :
    range (J m) ⊆ Z := by
  rintro _ ⟨s₀, rfl⟩
  by_contra hs₀
  have hC₁ : IsClosed (J m '' Icc s₀ 1) := (isCompact_Icc.image (J m).continuous).isClosed
  have hC₂ : IsClosed (J m '' Icc 0 s₀ ∪ ⋃ k : {k : Fin 3 // k ≠ m}, range (J k)) :=
    (isCompact_Icc.image (J m).continuous).isClosed.union
      (isClosed_iUnion_of_finite fun k => (isCompact_range (J k.1).continuous).isClosed)
  have hcov : Z ⊆ J m '' Icc s₀ 1 ∪ (J m '' Icc 0 s₀ ∪ ⋃ k : {k : Fin 3 // k ≠ m}, range (J k)) := by
    intro z hz
    obtain ⟨k, t, rfl⟩ := mem_iUnion.mp (hZT hz)
    by_cases hk : k = m
    · subst hk
      rcases le_total s₀ t with ht | ht
      · exact Or.inl ⟨t, ⟨ht, unitInterval.le_one'⟩, rfl⟩
      · exact Or.inr (Or.inl ⟨t, ⟨unitInterval.nonneg', ht⟩, rfl⟩)
    · exact Or.inr (Or.inr (mem_iUnion.mpr ⟨⟨k, hk⟩, t, rfl⟩))
  obtain ⟨z, hzZ, ⟨s, hs, rfl⟩, hz₂⟩ := isPreconnected_closed_iff.mp hZ _ _ hC₁ hC₂ hcov
    ⟨J m 1, hm, 1, ⟨unitInterval.le_one', le_rfl⟩, rfl⟩
    ⟨J m' 1, hm', Or.inr (mem_iUnion.mpr ⟨⟨m', hmm.symm⟩, 1, rfl⟩)⟩
  have hss : s = s₀ := by
    rcases hz₂ with ⟨s', hs', he⟩ | hz₂
    · obtain rfl : s' = s := h.injective m he
      exact le_antisymm hs'.2 hs.1
    · obtain ⟨⟨k, hk⟩, t, he⟩ := mem_iUnion.mp hz₂
      have hx : J m s = x := h.eq_center_of_ne m k s t (Ne.symm hk) he.symm
      obtain rfl : s = 0 := h.injective m (hx.trans (h.apply_zero m).symm)
      exact le_antisymm unitInterval.nonneg' hs.1
  exact hs₀ (hss ▸ hzZ)

/-- A far end is the point of the rim at its own argument about `x`. -/
theorem apply_one_eq_polarPt (h : IsTriod x r J) (m : Fin 3) :
    J m 1 = polarPt x r (Complex.arg (J m 1 - x)) := by
  have hn : ‖J m 1 - x‖ = r := by rw [← dist_eq_norm, h.dist_apply_one m]
  have hz := Complex.norm_mul_exp_arg_mul_I (J m 1 - x)
  rw [hn] at hz
  rw [polarPt, e, hz, add_sub_cancel]

/-- A closed stretch of an arc is preconnected. -/
theorem isPreconnected_image_Icc (J : Fin 3 → C(unitInterval, ℂ)) (m : Fin 3) (s t : unitInterval) :
    IsPreconnected (J m '' Icc s t) := by
  exact isPreconnected_Icc.image _ (J m).continuous.continuousOn

/-- **The far ends have an order round the rim**: the arguments of the three far ends, sorted. -/
theorem exists_rimOrder (h : IsTriod x r J) : ∃ a b c α β γ, RimOrder x r J a b c α β γ := by
  obtain ⟨θ, hθ⟩ : ∃ θ : Fin 3 → ℝ, θ = fun m => Complex.arg (J m 1 - x) := ⟨_, rfl⟩
  have hpt : ∀ m, J m 1 = polarPt x r (θ m) := fun m => by rw [hθ]; exact h.apply_one_eq_polarPt m
  have hinj : Function.Injective θ := fun m m' he => by
    by_contra hmm
    exact h.apply_one_ne hmm ((hpt m).trans ((congrArg (polarPt x r) he).trans (hpt m').symm))
  have hmono := Tuple.monotone_sort θ
  have hlt : ∀ i j : Fin 3, i < j → θ (Tuple.sort θ i) < θ (Tuple.sort θ j) := fun i j hij =>
    lt_of_le_of_ne (hmono hij.le) fun he => hij.ne ((Tuple.sort θ).injective (hinj he))
  refine ⟨Tuple.sort θ 0, Tuple.sort θ 1, Tuple.sort θ 2, θ (Tuple.sort θ 0), θ (Tuple.sort θ 1),
    θ (Tuple.sort θ 2), (Tuple.sort θ).injective.ne (by decide), (Tuple.sort θ).injective.ne (by decide),
    (Tuple.sort θ).injective.ne (by decide), hpt _, hpt _, hpt _, hlt 0 1 (by decide), hlt 1 2 (by decide), ?_⟩
  have hle : θ (Tuple.sort θ 2) ≤ Real.pi := by rw [hθ]; exact Complex.arg_le_pi _
  have hgt : -Real.pi < θ (Tuple.sort θ 0) := by rw [hθ]; exact Complex.neg_pi_lt_arg _
  linarith

/-- A point of the rim on an arc is the arc's far end. -/
theorem eq_apply_one_of_mem_sphere (h : IsTriod x r J) {m : Fin 3} {p : ℂ} (hp : p ∈ sphere x r)
    (hpm : p ∈ range (J m)) : p = J m 1 := by
  obtain ⟨t, rfl⟩ := hpm
  rw [h.eq_one_of_mem_sphere hp]

/-- **No far end lies strictly between consecutive far ends**: a point of the rim at an angle strictly between `α` and
`β` is on none of the three arcs. -/
theorem notMem_iUnion_range_of_mem_Ioo (h : IsTriod x r J) {a b c : Fin 3} {α β γ φ : ℝ}
    (ho : RimOrder x r J a b c α β γ) (hφ : φ ∈ Ioo α β) : polarPt x r φ ∉ ⋃ m, range (J m) := by
  intro hmem
  obtain ⟨m, hm⟩ := mem_iUnion.mp hmem
  have he := h.eq_apply_one_of_mem_sphere (h.polarPt_mem_sphere φ) hm
  rcases ho.eq_or m with rfl | rfl | rfl
  · rw [ho.apply_a] at he
    exact polarPt_ne_of_sub h.pos h.pos (sub_pos.mpr hφ.1) (by linarith [hφ.2, ho.lt_bc, ho.lt_ca]) he
  · rw [ho.apply_b] at he
    exact polarPt_ne_of_sub h.pos h.pos (sub_pos.mpr hφ.2) (by linarith [hφ.1, ho.lt_bc, ho.lt_ca]) he.symm
  · rw [ho.apply_c] at he
    exact polarPt_ne_of_sub h.pos h.pos (sub_pos.mpr (hφ.2.trans ho.lt_bc)) (by linarith [hφ.1, ho.lt_ca]) he.symm

/-- **No preconnected set of the closed disc off two of the arcs reaches the rim on both sides of their far ends**:
the two arcs together are a continuum of the closed disc joining their far ends, the set with two rim points of its
closure is preconnected, the four points interleave, and the crossing lemma
(`inter_nonempty_of_interleaved_radius`) makes them meet. -/
theorem not_mem_closure_both_sides (h : IsTriod x r J) {a b : Fin 3} {α β φ ψ : ℝ}
    (ha : J a 1 = polarPt x r α) (hb : J b 1 = polarPt x r β) (hφ : φ ∈ Ioo α β) (hψ : ψ ∈ Ioo β (α + 2 * Real.pi))
    {Q : Set ℂ} (hQ : IsPreconnected Q) (hQB : Q ⊆ closedBall x r) (hQT : Disjoint Q (range (J a) ∪ range (J b)))
    (hφQ : polarPt x r φ ∈ closure Q) (hψQ : polarPt x r ψ ∈ closure Q) : False := by
  have hKc : IsClosed (range (J a) ∪ range (J b)) :=
    (isCompact_range (J a).continuous).isClosed.union (isCompact_range (J b).continuous).isClosed
  have hKd : range (J a) ∪ range (J b) ⊆ closedBall x r := by
    rintro _ (⟨t, rfl⟩ | ⟨t, rfl⟩) <;> exact h.apply_mem_closedBall _ t
  have hrimd : ∀ ξ : ℝ, polarPt x r ξ ∈ closedBall x r := fun ξ => by
    rw [mem_closedBall, dist_eq_norm, norm_polarPt_sub, abs_of_pos h.pos]
  have hrims : ∀ ξ : ℝ, polarPt x r ξ ∈ sphere x r := fun ξ => by
    rw [mem_sphere, dist_eq_norm, norm_polarPt_sub, abs_of_pos h.pos]
  -- the set with its two rim points is preconnected, in the closed disc
  have hK'p : IsPreconnected (Q ∪ {polarPt x r φ, polarPt x r ψ}) := by
    refine hQ.subset_closure subset_union_left ?_
    rintro z (hz | hz | hz)
    · exact subset_closure hz
    · rw [hz]
      exact hφQ
    · rw [mem_singleton_iff.mp hz]
      exact hψQ
  have hK'd : Q ∪ {polarPt x r φ, polarPt x r ψ} ⊆ closedBall x r := by
    rintro z (hz | hz | hz)
    · exact hQB hz
    · rw [hz]
      exact hrimd φ
    · rw [mem_singleton_iff.mp hz]
      exact hrimd ψ
  -- a rim point on the two arcs is one of their far ends
  have hrim : ∀ ξ : ℝ, polarPt x r ξ ∈ range (J a) ∪ range (J b) →
      polarPt x r ξ = polarPt x r α ∨ polarPt x r ξ = polarPt x r β := by
    rintro ξ (⟨t, ht⟩ | ⟨t, ht⟩)
    · left
      have h1 : t = 1 := h.eq_one_of_mem_sphere (m := a) (by rw [ht]; exact hrims ξ)
      rw [← ht, h1, ha]
    · right
      have h1 : t = 1 := h.eq_one_of_mem_sphere (m := b) (by rw [ht]; exact hrims ξ)
      rw [← ht, h1, hb]
  obtain ⟨w, hwK, hwK'⟩ := inter_nonempty_of_interleaved_radius h.pos hKc (h.isPreconnected_range_union_range a b)
    hK'p hKd hK'd hφ.1 hφ.2 hψ.1 hψ.2 (Or.inl ⟨1, ha⟩) (Or.inr ⟨1, hb⟩) (Or.inr (Or.inl rfl)) (Or.inr (Or.inr rfl))
  rcases hwK' with hw | hw | hw
  · exact Set.disjoint_left.mp hQT hw hwK
  · rw [hw] at hwK
    rcases hrim φ hwK with he | he
    · exact polarPt_ne_of_sub h.pos h.pos (sub_pos.mpr hφ.1) (by linarith [hφ.2, hψ.1, hψ.2]) he
    · exact polarPt_ne_of_sub h.pos h.pos (sub_pos.mpr hφ.2) (by linarith [hφ.1, hψ.1, hψ.2]) he.symm
  · rw [mem_singleton_iff.mp hw] at hwK
    rcases hrim ψ hwK with he | he
    · exact polarPt_ne_of_sub h.pos h.pos (sub_pos.mpr (hφ.1.trans (hφ.2.trans hψ.1))) (by linarith [hψ.2]) he
    · exact polarPt_ne_of_sub h.pos h.pos (sub_pos.mpr hψ.1) (by linarith [hφ.1, hφ.2, hψ.2]) he

end IsTriod

namespace IsTriodCut

variable {x : ℂ} {r : ℝ} {J : Fin 3 → C(unitInterval, ℂ)} {P : Fin 3 → Set ℂ}

/-- A piece lies in the open disc. -/
theorem piece_subset_ball (h : IsTriodCut x r J P) (i : Fin 3) : P i ⊆ ball x r := by
  sorry

/-- A piece misses the three arcs. -/
theorem disjoint_iUnion_range (h : IsTriodCut x r J P) (i : Fin 3) : Disjoint (P i) (⋃ m, range (J m)) := by
  sorry

/-- **A rim point off the far ends is in the closure of exactly one piece**: a small disc about it misses the arcs, its
part in the open disc is convex, so inside one piece. -/
theorem exists_unique_mem_closure (h : IsTriodCut x r J P) {p : ℂ} (hp : p ∈ sphere x r)
    (hpT : p ∉ ⋃ m, range (J m)) : ∃ i, p ∈ closure (P i) ∧ ∀ j, p ∈ closure (P j) → j = i := by
  sorry

/-- **Two pieces' closures meet on the arcs only**: a point of the open disc off the arcs is in a piece, an open set
that meets no other piece; a rim point off the far ends is in one closure (`exists_unique_mem_closure`). -/
theorem closure_inter_closure_subset (h : IsTriodCut x r J P) {i j : Fin 3} (hij : i ≠ j) :
    closure (P i) ∩ closure (P j) ⊆ ⋃ m, range (J m) := by
  sorry

/-- **One piece all along an arc of the rim between far ends**: if no point of the rim at an angle strictly between `α`
and `β` is on the arcs, one piece has that closed arc of the rim in its closure, and no other piece's closure meets
the open arc. (The open arc is preconnected and covered by the three closures, no two of which share a point of it:
`exists_inter_of_finite_closed_cover`.) -/
theorem exists_forall_rimArc (h : IsTriodCut x r J P) {α β : ℝ} (hαβ : α < β)
    (hT : ∀ φ ∈ Ioo α β, polarPt x r φ ∉ ⋃ m, range (J m)) :
    ∃ i, polarPt x r '' Icc α β ⊆ closure (P i) ∧
      ∀ j, ∀ φ ∈ Ioo α β, polarPt x r φ ∈ closure (P j) → j = i := by
  sorry

/-- **The pieces at consecutive arcs of the rim are different** (the crossing lemma,
`IsTriod.not_mem_closure_both_sides`, for the arcs `J b` and `J c`): a piece whose closure holds a rim point strictly
between the far ends of `J a` and `J b` is not a piece whose closure holds one strictly between those of `J b` and
`J c`. -/
theorem ne_of_rimOrder (h : IsTriodCut x r J P) {a b c : Fin 3} {α β γ φ ψ : ℝ} (ho : RimOrder x r J a b c α β γ)
    {i i' : Fin 3} (hφ : φ ∈ Ioo α β) (hψ : ψ ∈ Ioo β γ) (hi : polarPt x r φ ∈ closure (P i))
    (hi' : polarPt x r ψ ∈ closure (P i')) : i ≠ i' := by
  sorry

/-- **The three pieces at the three arcs of the rim**: for the far ends in the order `a`, `b`, `c`, each of the three
closed arcs of the rim between consecutive far ends lies in the closure of one piece, and the three pieces are
different — so they are all the pieces. (`exists_forall_rimArc` and `ne_of_rimOrder`, each at the three rotations.) -/
theorem exists_rimPieces (h : IsTriodCut x r J P) {a b c : Fin 3} {α β γ : ℝ} (ho : RimOrder x r J a b c α β γ) :
    ∃ i₁ i₂ i₃ : Fin 3, i₁ ≠ i₂ ∧ i₂ ≠ i₃ ∧ i₃ ≠ i₁ ∧ polarPt x r '' Icc α β ⊆ closure (P i₁) ∧
      polarPt x r '' Icc β γ ⊆ closure (P i₂) ∧ polarPt x r '' Icc γ (α + 2 * Real.pi) ⊆ closure (P i₃) := by
  sorry

/-- **Every piece's closure meets the arcs**: every piece is the piece at an arc of the rim (`exists_rimPieces`), and
its closure holds the two far ends of that arc. (So the hypotheses leave no piece empty.) -/
theorem closure_inter_nonempty (h : IsTriodCut x r J P) (j : Fin 3) :
    (closure (P j) ∩ ⋃ m, range (J m)).Nonempty := by
  sorry

/-- **The part of the three arcs in the closure of one piece is preconnected**: the closed disc is the union of the
closure of the piece and of the arcs with the two other closures, two closed preconnected sets
(`closure_inter_nonempty`), and they meet in that part (`isPreconnected_inter_of_union_eq_closedBall`,
`closure_inter_closure_subset`). -/
theorem isPreconnected_closure_inter (h : IsTriodCut x r J P) (i : Fin 3) :
    IsPreconnected (closure (P i) ∩ ⋃ m, range (J m)) := by
  sorry

/-- **What the piece at an arc of the rim borders**: for the far ends in the order `a`, `b`, `c` round the rim, a piece
whose closure holds a point of the rim strictly between the far ends of `J a` and `J b` has both those arcs whole in
its closure, and of the third arc `J c` the point `x` only. (Its closure holds the two far ends
(`exists_forall_rimArc`); the part of the three arcs in it is preconnected (`isPreconnected_closure_inter`), so holds
both arcs (`IsTriod.range_subset_of_isPreconnected`). A point `J c s ≠ x` in its closure would make the piece with
the stretch of `J c` from `s` on a preconnected set of the closed disc off `J a ∪ J b` reaching the rim on both sides:
`IsTriod.not_mem_closure_both_sides`.) -/
theorem rimPiece_spec (h : IsTriodCut x r J P) {a b c : Fin 3} {α β γ φ : ℝ} (ho : RimOrder x r J a b c α β γ)
    {i : Fin 3} (hφ : φ ∈ Ioo α β) (hi : polarPt x r φ ∈ closure (P i)) :
    range (J a) ⊆ closure (P i) ∧ range (J b) ⊆ closure (P i) ∧ closure (P i) ∩ range (J c) = {x} := by
  sorry

/-- **The θ-lemma**: for three arcs from `x` to the rim of a disc and three open preconnected pairwise disjoint sets
filling the disc less the arcs, there is a bijection from arcs to pieces — the piece **opposite** an arc — such that
each arc lies in the closure of each of the two other pieces and meets the closure of its opposite piece at `x` only.
("Each of the three arcs lies in the closure of exactly two of the three components and every two components share one
arc.") Inhabitant of the hypothesis: the three-sector point, `sectorPoint_isSector` (`Plane/SectorPoint`). -/
theorem exists_opposite (h : IsTriodCut x r J P) :
    ∃ opp : Equiv.Perm (Fin 3), (∀ m i, i ≠ opp m → range (J m) ⊆ closure (P i)) ∧
      ∀ m, closure (P (opp m)) ∩ range (J m) = {x} := by
  sorry

/-- **Every two pieces share a whole arc.** -/
theorem exists_range_subset (h : IsTriodCut x r J P) {i j : Fin 3} (hij : i ≠ j) :
    ∃ m, range (J m) ⊆ closure (P i) ∩ closure (P j) := by
  sorry

/-- **Inside the disc the common boundary of two pieces is one of the arcs**, the one opposite the third piece. -/
theorem closure_inter_closure_inter_ball (h : IsTriodCut x r J P) {i j : Fin 3} (hij : i ≠ j) :
    ∃ m, closure (P i) ∩ closure (P j) ∩ ball x r = range (J m) ∩ ball x r := by
  sorry

/-- The point is in the closure of every piece. -/
theorem mem_closure (h : IsTriodCut x r J P) (i : Fin 3) : x ∈ closure (P i) := by
  sorry

/-- **Every two pieces share an arc from `x` inside any neighbourhood of `x`** — what
`ThreePiece.IsSector.hasArcEdges` (`Plane/SectorPoint`) reads: an initial part of the arc the two pieces share. -/
theorem exists_arc (h : IsTriodCut x r J P) {N : Set ℂ} (hN : N ∈ 𝓝 x) {i j : Fin 3} (hij : i ≠ j) :
    ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = x ∧ range γ ⊆ closure (P i) ∩ closure (P j) ∩ N := by
  sorry

end IsTriodCut

end HadwigerNelson.Plane
