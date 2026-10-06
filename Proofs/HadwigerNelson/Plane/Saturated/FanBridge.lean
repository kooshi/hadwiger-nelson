import Proofs.HadwigerNelson.Plane.Saturated.LocalGraph
import Proofs.HadwigerNelson.Plane.Saturated.FanExamples

/-!
# The bridge: an isolated singular point of a saturated colouring has a fan (FS-131 wave 6: FS131-E8)

`plans/FS131-E8-derivation.md` §§ 3.2–3.7, each entry **[hand], one mind, kernel pending** until this module lands
(`plans/FS131-w6-kernel-plan.md` § 11):

* `c.IsolatedAt z R` — the setting: `0 < R ≤ 1/2`, `z` the only possible singular point of `B(z, R)`, the colouring
  saturated at the essential boundary points of the punctured disc (never at `z`). Inhabitant: `sq9_isolatedAt`.
* **FS131-E8-GAMMA** — `gamma`: a component of the essential boundary in the punctured disc is an injective
  unit-speed curve of curvature at most `1`, of length at most `π/2`, each end at `z` or on the circle.
* **FS131-E8-BETA** — `IsUnitCurve.exists_polarGraph` (no colouring: a curve of length at most `π/2` is a polar graph
  about its start, with limit direction its initial tangent) and `beta` (a component with `z` in its closure is a
  polar graph over `(0, R)`).
* **FS131-E8-ALPHA** — `alpha`: finitely many components meet the half disc, and in a smaller disc every essential
  boundary point lies on a component that ends at `z`.
* **FS131-E8-FAN** — `fan_of_isolated`: a fan at `z` (for every `z` with `Σ ∩ B(z, R) ⊆ {z}`, singular or not);
  `Fan.two_le_n`, `Fan.col_ne` (at least two branches at a singular point; neighbouring regions differ — from the
  fan's fields alone).
* **FS131-E8-BRIDGE** — `regJFan_of_saturated` (**proved** from `fan_of_isolated`), `regJFan_iff_singLocallyFinite`:
  under saturation the fan form of REG-J′ is equivalent to `Σ` being locally finite.
* **FS131-E8-CLAUSE2** — `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`.
* The two facts FS-121's rows read at a branch, for **any** fan under saturation in its punctured disc:
  `Fan.branch_outside_discs` (the lens) and `Fan.branch_contacts` (FS121-V2's Lemma T (ii)).
* **FS121-V2-SECTOR** — `Fan.sector_alone`; **FS121-DB1-L3** (with FS111-W-NOREP) — `Fan.sector_unique`, its case
  (proved from it).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

namespace AeColouring

/-- **The setting of FS131-E8 §§ 3.2–3.4**: `z` is the only possible singular point of `B(z, R)`, `R ≤ 1/2`, and the
colouring is saturated at the essential boundary points of the punctured disc. -/
structure IsolatedAt (c : AeColouring k) (z : ℂ) (R : ℝ) : Prop where
  /-- The radius is positive. -/
  pos : 0 < R
  /-- The radius is at most `1/2` (a unit circle of interface fits in no such disc). -/
  le : R ≤ 1 / 2
  /-- `z` is the only possible singular point of the disc. -/
  sing : c.singularSet ∩ ball z R ⊆ {z}
  /-- Saturated at the essential boundary points of the punctured disc. -/
  sat : SaturatedOn c.cls (ball z R \ {z})

end AeColouring

/-- **Inhabitant of `IsolatedAt`**: `sq9` at the grid vertex, `R = 1/4`. -/
theorem sq9_isolatedAt : sq9.IsolatedAt sqVertex (1 / 4) :=
  ⟨by norm_num, by norm_num, sq9_singular_near_vertex, sq9_tight_saturated.2.1.saturatedOn _⟩

namespace AeColouring

variable {c : AeColouring k} {z : ℂ} {R : ℝ}

/-! ## FS131-E8-GAMMA, -BETA, -ALPHA -/

/-- **FS131-E8-GAMMA.** In the setting `IsolatedAt`, the connected component of the essential boundary in the
punctured disc through `y` is the image of `(0, L)` under an injective unit-speed curve of curvature at most `1` on
`[0, L]`, `0 < L ≤ π/2`; each of its two ends is `z` or a point of the circle `∂B(z, R)`. (The tangent has a limit at
each end: `IsUnitCurve` on the closed interval. Not closed: `γ` is injective on `[0, L]`.) -/
theorem gamma (h : c.IsolatedAt z R) {y : ℂ} (hy : y ∈ c.essBdry ∩ (ball z R \ {z})) :
    ∃ (L : ℝ) (γ : ℝ → ℂ) (ψ : ℝ → ℝ), 0 < L ∧ L ≤ Real.pi / 2 ∧ IsUnitCurve γ ψ (Icc 0 L) ∧ InjOn γ (Icc 0 L) ∧
      connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y = γ '' Ioo 0 L ∧
      (γ 0 = z ∨ γ 0 ∈ sphere z R) ∧ (γ L = z ∨ γ L ∈ sphere z R) := by
  sorry

end AeColouring

/-- **FS131-E8-BETA**, the curve's part (no colouring): a unit-speed curve of curvature at most `1` and length
`L ≤ π/2` is, off its start, a polar graph about its start out to the distance of its far end, with a continuous
angle that tends to the initial tangent angle. -/
theorem IsUnitCurve.exists_polarGraph {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {L : ℝ} (h : IsUnitCurve γ ψ (Icc 0 L)) (hL : 0 < L)
    (hLπ : L ≤ Real.pi / 2) :
    ∃ φ : ℝ → ℝ, ContinuousOn φ (Ioo 0 (dist (γ L) (γ 0))) ∧ Tendsto φ (𝓝[>] 0) (𝓝 (ψ 0)) ∧
      γ '' Ioo 0 L = polarGraph (γ 0) (dist (γ L) (γ 0)) φ := by
  sorry

namespace AeColouring

variable {c : AeColouring k} {z : ℂ} {R : ℝ}

/-- **FS131-E8-BETA.** In the setting `IsolatedAt`, a component of the essential boundary in the punctured disc with
`z` in its closure is a polar graph over `(0, R)` with a continuous angle that has a limit at `0` (its other end is
on the circle; no component has both ends at `z`). -/
theorem beta (h : c.IsolatedAt z R) {y : ℂ} (hy : y ∈ c.essBdry ∩ (ball z R \ {z}))
    (hz : z ∈ closure (connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y)) :
    ∃ (φ : ℝ → ℝ) (d : ℝ), ContinuousOn φ (Ioo 0 R) ∧ Tendsto φ (𝓝[>] 0) (𝓝 d) ∧
      connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y = polarGraph z R φ := by
  sorry

/-- **FS131-E8-ALPHA.** In the setting `IsolatedAt`, finitely many components of the essential boundary in the
punctured disc meet the closed disc of radius `R/2`, and there is `r ∈ (0, R/2]` such that every essential boundary
point of `B(z, r)` other than `z` lies on a component with `z` in its closure. -/
theorem alpha (h : c.IsolatedAt z R) :
    {K : Set ℂ | ∃ y ∈ c.essBdry ∩ (ball z R \ {z}),
        K = connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y ∧ (K ∩ closedBall z (R / 2)).Nonempty}.Finite ∧
      ∃ r, 0 < r ∧ r ≤ R / 2 ∧ ∀ w ∈ c.essBdry ∩ (ball z r \ {z}),
        z ∈ closure (connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) w) := by
  sorry

/-! ## FS131-E8-FAN, -BRIDGE, -CLAUSE2 -/

/-- **FS131-E8-FAN.** If `z` is the only possible singular point of `B(z, R)` and the colouring is saturated at the
essential boundary points of the punctured disc, then `z` has a fan. Not read: saturation at `z` or outside the
punctured disc; any clause about arcs meeting `z`; that `z` is singular; the number of colours. -/
theorem fan_of_isolated (c : AeColouring k) {z : ℂ} {R : ℝ} (hR : 0 < R) (hS : c.singularSet ∩ ball z R ⊆ {z})
    (hsat : SaturatedOn c.cls (ball z R \ {z})) : Nonempty (c.Fan z) := by
  sorry

/-- **FS131-E8-BRIDGE.** A saturated colouring whose singular set is locally finite satisfies REG-J′ in its fan form:
every singular point has a fan with end tangents. The frozen words' second clause is not read. -/
theorem regJFan_of_saturated (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) : c.RegJFan :=
  ⟨hS, fun z _ => by
    obtain ⟨R, hR, hsub⟩ := hS.exists_ball_subset z
    exact fan_of_isolated c hR hsub (hsat.saturatedOn _)⟩

/-- **Under saturation the fan form of REG-J′ is `Σ` locally finite** (FS131-E8-BRIDGE). -/
theorem regJFan_iff_singLocallyFinite (c : AeColouring k) (hsat : Saturated c.cls) :
    c.RegJFan ↔ c.SingLocallyFinite :=
  ⟨fun h => h.1, regJFan_of_saturated c hsat⟩

/-- **FS131-E8-CLAUSE2**, first clause: under saturation the frozen words of REG-J′ follow from their first clause —
every singular point lies in the closure of finitely many components of the interface set. -/
theorem regJLiteral_of_saturated (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) :
    c.RegJLiteral := by
  sorry

/-- **FS131-E8-CLAUSE2**, second clause: in a saturated colouring with locally finite singular set, a bounded set
meets finitely many components of the interface set. -/
theorem finite_arcs_of_isBounded (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
    {K : Set ℂ} (hK : Bornology.IsBounded K) :
    {A : Set ℂ | (∃ y ∈ c.interfaceSet, A = connectedComponentIn c.interfaceSet y) ∧ (A ∩ K).Nonempty}.Finite := by
  sorry

/-! ## What every fan carries under saturation -/

end AeColouring

/-! ### Polar coordinates about a point; the essential boundary is null (FS131-I6E) -/

/-- The polar angle of `w` about `z`, in the lift near `θ₀`. -/
noncomputable def fanAngle (z : ℂ) (θ₀ : ℝ) (w : ℂ) : ℝ := θ₀ + Complex.arg ((w - z) * (starRingEnd ℂ) (e θ₀))

/-- A point other than `z` is its own polar point. -/
theorem polarPt_dist_fanAngle (z : ℂ) (θ₀ : ℝ) (w : ℂ) : polarPt z (dist w z) (fanAngle z θ₀ w) = w := by
  set u : ℂ := (w - z) * (starRingEnd ℂ) (e θ₀) with hu
  have hnu : ‖u‖ = dist w z := by rw [hu, norm_mul, RingHomIsometric.norm_map, norm_e, mul_one, dist_eq_norm]
  have h1 : ((dist w z : ℝ) : ℂ) * e (Complex.arg u) = u := by
    rw [← hnu, e]; exact Complex.norm_mul_exp_arg_mul_I u
  have h2 : e θ₀ * u = w - z := by rw [hu, mul_comm (w - z), ← mul_assoc, e_mul_conj_e, one_mul]
  rw [polarPt, fanAngle, e_add, mul_left_comm, h1, h2]; ring

/-- The polar angle of a polar point in the lift near its own angle. -/
theorem fanAngle_polarPt (z : ℂ) {t : ℝ} (ht : 0 < t) (θ : ℝ) : fanAngle z θ (polarPt z t θ) = θ := by
  have : (polarPt z t θ - z) * (starRingEnd ℂ) (e θ) = (t : ℂ) := by
    rw [polarPt, add_sub_cancel_left, mul_assoc, e_mul_conj_e, mul_one]
  rw [fanAngle, this, Complex.arg_ofReal_of_nonneg ht.le, add_zero]

/-- The polar angle is continuous at a polar point in the lift near its own angle. -/
theorem continuousAt_fanAngle (z : ℂ) {t : ℝ} (ht : 0 < t) (θ : ℝ) :
    ContinuousAt (fanAngle z θ) (polarPt z t θ) := by
  have h1 : (polarPt z t θ - z) * (starRingEnd ℂ) (e θ) = (t : ℂ) := by
    rw [polarPt, add_sub_cancel_left, mul_assoc, e_mul_conj_e, mul_one]
  have h2 : ContinuousAt Complex.arg ((polarPt z t θ - z) * (starRingEnd ℂ) (e θ)) := by
    rw [h1]; exact Complex.continuousAt_arg (Complex.ofReal_mem_slitPlane.2 ht)
  have h3 : ContinuousAt (fun w : ℂ => (w - z) * (starRingEnd ℂ) (e θ)) (polarPt z t θ) := by fun_prop
  exact continuousAt_const.add (ContinuousAt.comp (f := fun w : ℂ => (w - z) * (starRingEnd ℂ) (e θ)) h2 h3)

/-- **The polar map is open off the centre**: the image of a neighbourhood of `(t, θ)`, `t > 0`, is a neighbourhood
of `z + t e(θ)`. -/
theorem image_polarPt_mem_nhds (z : ℂ) {V : Set (ℝ × ℝ)} {t θ : ℝ} (ht : 0 < t) (hV : V ∈ 𝓝 (t, θ)) :
    (fun q : ℝ × ℝ => polarPt z q.1 q.2) '' V ∈ 𝓝 (polarPt z t θ) := by
  have hc : ContinuousAt (fun w : ℂ => (dist w z, fanAngle z θ w)) (polarPt z t θ) :=
    (continuous_id.dist continuous_const).continuousAt.prodMk (continuousAt_fanAngle z ht θ)
  have h0 : (dist (polarPt z t θ) z, fanAngle z θ (polarPt z t θ)) = (t, θ) := by
    rw [dist_polarPt z ht.le, fanAngle_polarPt z ht]
  have hV' : V ∈ 𝓝 ((fun w : ℂ => (dist w z, fanAngle z θ w)) (polarPt z t θ)) := by
    show V ∈ 𝓝 (dist (polarPt z t θ) z, fanAngle z θ (polarPt z t θ))
    rw [h0]; exact hV
  have h1 : ∀ᶠ w in 𝓝 (polarPt z t θ), (dist w z, fanAngle z θ w) ∈ V := hc hV'
  filter_upwards [h1] with w hw
  exact ⟨_, hw, polarPt_dist_fanAngle z θ w⟩

/-- The open set of polar coordinates `(t, θ)` with `0 < t < r` and `φ t < θ < ψ t`. -/
theorem isOpen_setOf_polar_lt {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r)) (hψ : ContinuousOn ψ (Ioo 0 r)) :
    IsOpen {q : ℝ × ℝ | q.1 ∈ Ioo 0 r ∧ φ q.1 < q.2 ∧ q.2 < ψ q.1} := by
  have hS : IsOpen {q : ℝ × ℝ | q.1 ∈ Ioo 0 r} := isOpen_Ioo.preimage continuous_fst
  have hm : MapsTo (Prod.fst : ℝ × ℝ → ℝ) {q : ℝ × ℝ | q.1 ∈ Ioo 0 r} (Ioo 0 r) := fun q hq => hq
  have h1 : ContinuousOn (fun q : ℝ × ℝ => q.2 - φ q.1) {q : ℝ × ℝ | q.1 ∈ Ioo 0 r} :=
    continuous_snd.continuousOn.sub (hφ.comp continuous_fst.continuousOn hm)
  have h2 : ContinuousOn (fun q : ℝ × ℝ => ψ q.1 - q.2) {q : ℝ × ℝ | q.1 ∈ Ioo 0 r} :=
    (hψ.comp continuous_fst.continuousOn hm).sub continuous_snd.continuousOn
  have h3 := (h1.isOpen_inter_preimage hS isOpen_Ioi (t := Ioi 0)).inter
    (h2.isOpen_inter_preimage hS isOpen_Ioi (t := Ioi 0))
  convert h3 using 1
  ext q
  simp only [mem_setOf_eq, mem_inter_iff, mem_preimage, mem_Ioi, sub_pos]
  tauto

/-- A polar region is the image of its set of polar coordinates. -/
theorem polarRegion_eq_image (z : ℂ) (r : ℝ) (φ ψ : ℝ → ℝ) :
    polarRegion z r φ ψ =
      (fun q : ℝ × ℝ => polarPt z q.1 q.2) '' {q : ℝ × ℝ | q.1 ∈ Ioo 0 r ∧ φ q.1 < q.2 ∧ q.2 < ψ q.1} := by
  ext w
  constructor
  · rintro ⟨t, ht, θ, hθ, rfl⟩
    exact ⟨(t, θ), ⟨ht, hθ.1, hθ.2⟩, rfl⟩
  · rintro ⟨⟨t, θ⟩, ⟨ht, h1, h2⟩, rfl⟩
    exact ⟨t, ht, θ, ⟨h1, h2⟩, rfl⟩

/-- **A polar region between two continuous graphs is open.** -/
theorem polarRegion_isOpen (z : ℂ) {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r))
    (hψ : ContinuousOn ψ (Ioo 0 r)) : IsOpen (polarRegion z r φ ψ) := by
  rw [polarRegion_eq_image, isOpen_iff_mem_nhds]
  rintro _ ⟨⟨t, θ⟩, hq, rfl⟩
  exact image_polarPt_mem_nhds z hq.1.1 ((isOpen_setOf_polar_lt hφ hψ).mem_nhds hq)

/-- **A polar region between two continuous graphs, one below the other, is preconnected.** -/
theorem polarRegion_isPreconnected (z : ℂ) {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r))
    (hψ : ContinuousOn ψ (Ioo 0 r)) (hlt : ∀ t ∈ Ioo 0 r, φ t < ψ t) : IsPreconnected (polarRegion z r φ ψ) := by
  have him : polarRegion z r φ ψ =
      (fun q : ℝ × ℝ => polarPt z q.1 (φ q.1 + q.2 * (ψ q.1 - φ q.1))) '' (Ioo 0 r ×ˢ Ioo 0 1) := by
    ext w
    constructor
    · rintro ⟨t, ht, θ, hθ, rfl⟩
      have hpos : 0 < ψ t - φ t := sub_pos.2 (hlt t ht)
      refine ⟨(t, (θ - φ t) / (ψ t - φ t)), ⟨ht, div_pos (sub_pos.2 hθ.1) hpos, ?_⟩, ?_⟩
      · rw [div_lt_one hpos]; linarith [hθ.2]
      · simp only
        rw [div_mul_cancel₀ _ hpos.ne']; ring_nf
    · rintro ⟨⟨t, s⟩, ⟨ht, hs⟩, rfl⟩
      have hpos : 0 < ψ t - φ t := sub_pos.2 (hlt t ht)
      refine ⟨t, ht, φ t + s * (ψ t - φ t), ⟨?_, ?_⟩, rfl⟩
      · have := mul_pos hs.1 hpos; linarith
      · have := mul_lt_mul_of_pos_right hs.2 hpos; linarith
  rw [him]
  refine (isPreconnected_Ioo.prod isPreconnected_Ioo).image _ ?_
  have hm : MapsTo (Prod.fst : ℝ × ℝ → ℝ) (Ioo 0 r ×ˢ Ioo (0 : ℝ) 1) (Ioo 0 r) := fun q hq => hq.1
  have h1 : ContinuousOn (fun q : ℝ × ℝ => (q.1, φ q.1 + q.2 * (ψ q.1 - φ q.1))) (Ioo 0 r ×ˢ Ioo (0 : ℝ) 1) :=
    continuous_fst.continuousOn.prodMk ((hφ.comp continuous_fst.continuousOn hm).add
      (continuous_snd.continuousOn.mul ((hψ.comp continuous_fst.continuousOn hm).sub
        (hφ.comp continuous_fst.continuousOn hm))))
  exact (continuous_polarPt z).comp_continuousOn h1

/-- A polar point a full turn on is the same point. -/
theorem polarPt_add_two_pi (z : ℂ) (t θ : ℝ) : polarPt z t (θ + 2 * Real.pi) = polarPt z t θ := by
  rw [polarPt, polarPt, e_add_two_pi]

/-- A polar region out to a smaller radius is a subset. -/
theorem polarRegion_mono (z : ℂ) {ρ r : ℝ} (h : ρ ≤ r) (φ ψ : ℝ → ℝ) : polarRegion z ρ φ ψ ⊆ polarRegion z r φ ψ := by
  rintro w ⟨t, ht, θ, hθ, rfl⟩
  exact ⟨t, ⟨ht.1, lt_of_lt_of_le ht.2 h⟩, θ, hθ, rfl⟩

/-- The centre is in the closure of a polar region out to a positive radius whose lower graph is below its upper. -/
theorem mem_closure_polarRegion (z : ℂ) {r : ℝ} (hr : 0 < r) {φ ψ : ℝ → ℝ} (hlt : ∀ t ∈ Ioo 0 r, φ t < ψ t) :
    z ∈ closure (polarRegion z r φ ψ) := by
  rw [Metric.mem_closure_iff]
  intro ε hε
  have ht : min ε r / 2 ∈ Ioo 0 r :=
    ⟨half_pos (lt_min hε hr), by have := min_le_right ε r; linarith [lt_min hε hr]⟩
  refine ⟨polarPt z (min ε r / 2) ((φ (min ε r / 2) + ψ (min ε r / 2)) / 2), ⟨_, ht, _, ⟨?_, ?_⟩, rfl⟩, ?_⟩
  · linarith [hlt _ ht]
  · linarith [hlt _ ht]
  · rw [dist_comm, dist_polarPt z ht.1.le]
    have := min_le_left ε r; linarith [lt_min hε hr]

/-- **The essential boundary of a measurable set is null** (Lebesgue's density theorem, for the set and for its
complement). -/
theorem volume_essBoundary {A : Set ℂ} (hA : MeasurableSet A) : volume (essBoundary A) = 0 := by
  refine measure_mono_null (t := (A \ densitySet A) ∪ (Aᶜ \ densitySet Aᶜ)) ?_
    (measure_union_null (volume_diff_densitySet hA) (volume_diff_densitySet hA.compl))
  rintro x ⟨hx1, hx2⟩
  by_cases hxA : x ∈ A
  · exact Or.inl ⟨hxA, hx2⟩
  · exact Or.inr ⟨hxA, fun h => notMem_essClosure_of_mem_densitySet hA.compl disjoint_compl_left h hx1⟩

/-- The essential boundary of a colouring is null. -/
theorem AeColouring.volume_essBdry (c : AeColouring k) : volume c.essBdry = 0 :=
  measure_iUnion_null fun j => volume_essBoundary (c.measurableSet_cls j)

/-- The punctured disc is connected. -/
theorem isConnected_ball_diff_singleton (z : ℂ) {r : ℝ} (hr : 0 < r) :
    IsConnected (ball z r \ {z}) := by
  have him : ball z r \ {z} = (fun q : ℝ × ℝ => polarPt z q.1 q.2) '' (Ioo 0 r ×ˢ univ) := by
    ext w
    constructor
    · rintro ⟨hw, hwz⟩
      have hpos : 0 < dist w z := dist_pos.2 hwz
      exact ⟨(dist w z, fanAngle z 0 w), ⟨⟨hpos, hw⟩, mem_univ _⟩, polarPt_dist_fanAngle z 0 w⟩
    · rintro ⟨⟨t, θ⟩, ⟨ht, -⟩, rfl⟩
      have ht' : t ∈ Ioo 0 r := ht
      show polarPt z t θ ∈ ball z r \ {z}
      refine ⟨by rw [mem_ball, dist_polarPt z ht'.1.le]; exact ht'.2, fun h => ?_⟩
      have h1 := dist_polarPt z ht'.1.le θ
      rw [mem_singleton_iff.1 h, dist_self] at h1
      exact ht'.1.ne h1
  rw [him]
  exact (((nonempty_Ioo.2 hr).prod univ_nonempty).image _).elim fun w hw =>
    ⟨⟨w, hw⟩, (isPreconnected_Ioo.prod isPreconnected_univ).image _ (continuous_polarPt z).continuousOn⟩

/-! ### The branch as a unit-speed curve from `z` (FS131-I6E; over `gamma` and `IsUnitCurve.exists_polarGraph`) -/

/-- A unit-speed curve run backwards is a unit-speed curve: the tangent angle turns by `π`. -/
theorem IsUnitCurve.reverse {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {L : ℝ} (h : IsUnitCurve γ ψ (Icc 0 L)) :
    IsUnitCurve (fun s => γ (L - s)) (fun s => ψ (L - s) + Real.pi) (Icc 0 L) := by
  have hm : MapsTo (fun s : ℝ => L - s) (Icc 0 L) (Icc 0 L) :=
    fun s hs => ⟨by linarith [hs.2], by linarith [hs.1]⟩
  refine ⟨fun s hs => ?_, ?_⟩
  · have h1 : HasDerivWithinAt (fun s : ℝ => L - s) (-1) (Icc 0 L) s := by
      simpa using ((hasDerivAt_id s).const_sub L).hasDerivWithinAt
    have h2 : HasDerivWithinAt (fun s => γ (L - s)) ((-1 : ℝ) • e (ψ (L - s))) (Icc 0 L) s :=
      (h.hasDeriv (L - s) (hm hs)).scomp s h1 hm
    rw [e_add_pi, ← neg_one_smul ℝ (e (ψ (L - s)))]
    exact h2
  · refine LipschitzOnWith.of_dist_le_mul fun s hs u hu => ?_
    have := h.abs_sub_le (hm hs) (hm hu)
    rw [Real.dist_eq, Real.dist_eq, NNReal.coe_one, one_mul]
    calc |ψ (L - s) + Real.pi - (ψ (L - u) + Real.pi)| = |ψ (L - s) - ψ (L - u)| := by ring_nf
      _ ≤ |L - s - (L - u)| := this
      _ = |s - u| := by rw [show L - s - (L - u) = -(s - u) by ring, abs_neg]

/-- The squared distance from a polar point about `z` to `z + u`. -/
theorem dist_sq_polarPt_add (z : ℂ) (t θ : ℝ) (u : ℂ) :
    dist (polarPt z t θ) (z + u) ^ 2 = t ^ 2 + ‖u‖ ^ 2 - 2 * t * (e θ * (starRingEnd ℂ) u).re := by
  have h1 : ((t : ℂ) * e θ * (starRingEnd ℂ) u).re = t * (e θ * (starRingEnd ℂ) u).re := by
    rw [mul_assoc, Complex.re_ofReal_mul]
  rw [dist_eq_norm, polarPt, add_sub_add_left_eq_sub, ← Complex.normSq_eq_norm_sq, Complex.normSq_sub,
    Complex.normSq_mul, Complex.normSq_ofReal, Complex.normSq_eq_norm_sq (e θ), norm_e, Complex.normSq_eq_norm_sq u, h1]
  ring

/-- The component of `e θ` along `i e(δ)` is `sin (θ − δ)`. -/
theorem re_e_mul_conj_I_mul_e (θ δ : ℝ) : (e θ * (starRingEnd ℂ) (I * e δ)).re = Real.sin (θ - δ) := by
  simp only [map_mul, Complex.conj_I, Complex.mul_re, Complex.mul_im, Complex.neg_re, Complex.I_re, Complex.neg_im,
    Complex.I_im, Complex.conj_re, Complex.conj_im, re_e, im_e, Real.sin_sub]
  ring

/-- The component of `e a` along `e b` is `cos (a − b)`. -/
theorem re_e_mul_conj_e_eq_cos (a b : ℝ) : (e a * (starRingEnd ℂ) (e b)).re = Real.cos (a - b) := by
  simp only [Complex.mul_re, Complex.conj_re, Complex.conj_im, re_e, im_e, Real.cos_sub]
  ring

/-- The squared distance from the polar point `z + t e(θ)` to the centre `z + i e(δ)`. -/
theorem dist_sq_polarPt_add_I (z : ℂ) (t θ δ : ℝ) :
    dist (polarPt z t θ) (z + I * e δ) ^ 2 = 1 + t ^ 2 - 2 * t * Real.sin (θ - δ) := by
  rw [dist_sq_polarPt_add, re_e_mul_conj_I_mul_e, norm_mul, Complex.norm_I, norm_e]; ring

/-- The squared distance from the polar point `z + t e(θ)` to the centre `z − i e(δ)`. -/
theorem dist_sq_polarPt_sub_I (z : ℂ) (t θ δ : ℝ) :
    dist (polarPt z t θ) (z - I * e δ) ^ 2 = 1 + t ^ 2 + 2 * t * Real.sin (θ - δ) := by
  rw [sub_eq_add_neg, dist_sq_polarPt_add, map_neg, mul_neg, Complex.neg_re, re_e_mul_conj_I_mul_e, norm_neg, norm_mul,
    Complex.norm_I, norm_e]; ring
/-- Two unit vectors with `ν ⊥ T`: `ν = ± i T`. -/
theorem eq_I_mul_or_eq_neg_of_re_eq_zero {ν T : ℂ} (hν : ‖ν‖ = 1) (hT : ‖T‖ = 1)
    (h : (ν * (starRingEnd ℂ) T).re = 0) : ν = I * T ∨ ν = -(I * T) := by
  set v : ℂ := ν * (starRingEnd ℂ) T with hv
  have hTT : (starRingEnd ℂ) T * T = 1 := by
    rw [mul_comm, Complex.mul_conj, Complex.normSq_eq_norm_sq, hT]; norm_num
  have hνv : ν = v * T := by rw [hv, mul_assoc, hTT, mul_one]
  have hn : ‖v‖ = 1 := by rw [hv, norm_mul, RingHomIsometric.norm_map, hν, hT, mul_one]
  have him : v.im * v.im = 1 := by
    have h1 : Complex.normSq v = 1 := by rw [Complex.normSq_eq_norm_sq, hn]; norm_num
    rw [Complex.normSq_apply, h] at h1
    linarith
  rcases mul_self_eq_one_iff.1 him with h1 | h1
  · left; rw [hνv]; congr 1; exact Complex.ext (by simp [h]) (by simp [h1])
  · right; rw [hνv, ← neg_mul]; congr 1; exact Complex.ext (by simp [h]) (by simp [h1])

/-- The squared distance from `z + t e(φ₀ + η)` to the centre of the unit disc touching at `z + t e(φ₀)` with normal
`i e(ψ)`. -/
theorem dist_sq_polarPt_polarPt_add_I (z : ℂ) (t φ₀ η ψ : ℝ) :
    dist (polarPt z t (φ₀ + η)) (polarPt z t φ₀ + I * e ψ) ^ 2 =
      1 + 2 * t ^ 2 * (1 - Real.cos η) - 2 * t * (Real.sin (φ₀ - ψ + η) - Real.sin (φ₀ - ψ)) := by
  have h0 : polarPt z t φ₀ + I * e ψ = z + ((t : ℂ) * e φ₀ + I * e ψ) := by rw [polarPt]; ring
  have h1 : ‖(t : ℂ) * e φ₀ + I * e ψ‖ ^ 2 = 1 + t ^ 2 + 2 * t * Real.sin (φ₀ - ψ) := by
    have := dist_sq_polarPt_sub_I 0 t φ₀ ψ
    rw [dist_eq_norm, polarPt, zero_add, zero_sub, sub_neg_eq_add] at this
    exact this
  have h2 : (e (φ₀ + η) * (starRingEnd ℂ) ((t : ℂ) * e φ₀ + I * e ψ)).re =
      t * Real.cos η + Real.sin (φ₀ + η - ψ) := by
    rw [map_add, mul_add, Complex.add_re, re_e_mul_conj_I_mul_e, map_mul, Complex.conj_ofReal, mul_left_comm,
      Complex.re_ofReal_mul, re_e_mul_conj_e_eq_cos, add_sub_cancel_left]
  rw [h0, dist_sq_polarPt_add, h1, h2, show φ₀ - ψ + η = φ₀ + η - ψ by ring]
  ring

/-- If the direction `e(φ₀)` has a positive component along `e(ψ)`, a small turn counter-clockwise from
`z + t e(φ₀)` about `z` enters the open unit disc touching there with normal `i e(ψ)`. -/
theorem eventually_dist_polarPt_lt_one (z : ℂ) {t : ℝ} (ht : 0 < t) {φ₀ ψ : ℝ} (hcos : 0 < Real.cos (φ₀ - ψ)) :
    ∀ᶠ η in 𝓝[>] (0 : ℝ), dist (polarPt z t (φ₀ + η)) (polarPt z t φ₀ + I * e ψ) < 1 := by
  have hc : ContinuousAt (fun η : ℝ => Real.cos (φ₀ - ψ + η / 2) - t * Real.sin (η / 2)) 0 := by fun_prop
  have h0 : 0 < (fun η : ℝ => Real.cos (φ₀ - ψ + η / 2) - t * Real.sin (η / 2)) 0 := by simpa using hcos
  have e1 : ∀ᶠ η in 𝓝[>] (0 : ℝ), 0 < Real.cos (φ₀ - ψ + η / 2) - t * Real.sin (η / 2) :=
    nhdsWithin_le_nhds (hc.eventually (lt_mem_nhds h0))
  filter_upwards [e1, Ioo_mem_nhdsGT Real.pi_pos] with η h1 hη
  have hs : 0 < Real.sin (η / 2) :=
    Real.sin_pos_of_pos_of_lt_pi (by linarith [hη.1]) (by linarith [hη.2, Real.pi_pos])
  have hsq := dist_sq_polarPt_polarPt_add_I z t φ₀ η ψ
  have hss : Real.sin (φ₀ - ψ + η) - Real.sin (φ₀ - ψ) = 2 * Real.sin (η / 2) * Real.cos (φ₀ - ψ + η / 2) := by
    rw [Real.sin_sub_sin]; ring_nf
  have hcc : 1 - Real.cos η = 2 * Real.sin (η / 2) ^ 2 := by
    have := Real.cos_two_mul_eq_one_sub (η / 2)
    rw [show 2 * (η / 2) = η by ring] at this; linarith
  rw [hss, hcc] at hsq
  by_contra hge
  rw [not_lt] at hge
  nlinarith [mul_pos ht hs, mul_pos (mul_pos ht hs) h1]

/-- A class with positive upper density at a point of an open set that is almost everywhere of two classes is one of
the two. -/
theorem AeColouring.eq_or_eq_of_mem_essClosure (c : AeColouring k) {O : Set ℂ} (hO : IsOpen O) {a b a' : Fin k}
    (hae : (O : Set ℂ) ≤ᵐ[volume] (c.cls a ∪ c.cls b : Set ℂ)) {x : ℂ} (hx : x ∈ O)
    (hx' : x ∈ essClosure (c.cls a')) : a' = a ∨ a' = b := by
  by_contra hne
  rw [not_or] at hne
  obtain ⟨r, hr, hsub⟩ := Metric.isOpen_iff.1 hO x hx
  have h0 : ∀ s, 0 < s → s ≤ r / 2 → volume (c.cls a' ∩ closedBall x s) = 0 := fun s _ hs => by
    rw [ae_le_set] at hae
    refine measure_mono_null ?_ hae
    rintro w ⟨hwa', hw⟩
    refine ⟨hsub (closedBall_subset_ball (by linarith) hw), ?_⟩
    rintro (hwa | hwb)
    · exact hne.1 ((show c.col w = a' from hwa').symm.trans hwa)
    · exact hne.2 ((show c.col w = a' from hwa').symm.trans hwb)
  exact (ne_of_gt hx') (upperDensityAt_eq_zero_of_null (half_pos hr) h0)

namespace AeColouring

variable {c : AeColouring k} {z : ℂ}

namespace Fan

variable (F : c.Fan z)

/-! ### The cells of a fan, and the two cells beside a branch (FS131-I6E; no saturation) -/

/-- The angle of the next branch is continuous. -/
theorem continuousOn_cyclicNext (i : Fin F.n) : ContinuousOn (cyclicNext F.φ i) (Ioo 0 F.r) := by
  by_cases h : (i : ℕ) + 1 < F.n
  · have h1 : cyclicNext F.φ i = F.φ ⟨i + 1, h⟩ := funext fun t => cyclicNext_of_lt _ h t
    rw [h1]; exact F.cont _
  · have h1 : cyclicNext F.φ i = fun t => F.φ ⟨0, i.pos⟩ t + 2 * Real.pi :=
      funext fun t => cyclicNext_of_not_lt _ h t
    rw [h1]; exact (F.cont _).add continuousOn_const

/-- A cell of a fan is open. -/
theorem isOpen_cell (i : Fin F.n) : IsOpen (F.cell i) :=
  polarRegion_isOpen z (F.cont i) (F.continuousOn_cyclicNext i)

/-- **A cell of a fan is preconnected** — out to any radius `ρ ≤ F.r` (the first of the three cell lemmas). -/
theorem isPreconnected_polarRegion_of_le (i : Fin F.n) {ρ : ℝ} (hρ : ρ ≤ F.r) :
    IsPreconnected (polarRegion z ρ (F.φ i) (cyclicNext F.φ i)) :=
  polarRegion_isPreconnected z ((F.cont i).mono (Ioo_subset_Ioo_right hρ))
    ((F.continuousOn_cyclicNext i).mono (Ioo_subset_Ioo_right hρ))
    fun _ ht => F.φ_lt_cyclicNext i (Ioo_subset_Ioo_right hρ ht)

/-- **A cell of a fan is preconnected** (the first of the three cell lemmas). -/
theorem isPreconnected_cell (i : Fin F.n) : IsPreconnected (F.cell i) :=
  F.isPreconnected_polarRegion_of_le i le_rfl

/-- **A cell of a fan lies in the density set of its colour** (the second of the three cell lemmas). -/
theorem cell_subset_densitySet (i : Fin F.n) : F.cell i ⊆ densitySet (c.cls (F.col i)) :=
  subset_densitySet_of_isOpen_ae_subset (F.isOpen_cell i) (F.region i)

/-- **A cell of a fan holds the initial part of each ray strictly between its two limit directions** (the third of
the three cell lemmas). -/
theorem exists_ray_subset_cell (i : Fin F.n) {θ : ℝ} (h1 : F.dir i < θ) (h2 : θ < F.nextDir i) :
    ∃ ε > 0, ∀ t ∈ Ioo 0 ε, polarPt z t θ ∈ F.cell i := by
  have e1 : ∀ᶠ t in 𝓝[>] (0 : ℝ), F.φ i t < θ := (F.tendsto i).eventually (eventually_lt_nhds h1)
  have e2 : ∀ᶠ t in 𝓝[>] (0 : ℝ), θ < cyclicNext F.φ i t := (F.tendsto_cyclicNext i).eventually (eventually_gt_nhds h2)
  obtain ⟨ε, hε, hsub⟩ := (mem_nhdsGT_iff_exists_Ioo_subset).1 ((e1.and e2).and (Ioo_mem_nhdsGT F.r_pos))
  exact ⟨ε, hε, fun t ht => ⟨t, (hsub ht).2, θ, ⟨(hsub ht).1.1, (hsub ht).1.2⟩, rfl⟩⟩

/-- The centre of a fan is in the closure of each cell, out to any positive radius. -/
theorem mem_closure_polarRegion_of_le (i : Fin F.n) {ρ : ℝ} (hρ0 : 0 < ρ) (hρ : ρ ≤ F.r) :
    z ∈ closure (polarRegion z ρ (F.φ i) (cyclicNext F.φ i)) :=
  mem_closure_polarRegion z hρ0 fun _ ht => F.φ_lt_cyclicNext i (Ioo_subset_Ioo_right hρ ht)

/-- The cell clockwise of branch `i` is the polar region between a continuous graph below branch `i` and branch `i`
(the branch before, or the last branch a turn back). -/
theorem exists_lower_of_pred {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) :
    ∃ lo : ℝ → ℝ, ContinuousOn lo (Ioo 0 F.r) ∧ (∀ t ∈ Ioo 0 F.r, lo t < F.φ i t) ∧
      (∀ ρ, polarRegion z ρ lo (F.φ i) = polarRegion z ρ (F.φ j) (cyclicNext F.φ j)) := by
  rcases hij with hij | ⟨hi0, hjn⟩
  · have hlt : (j : ℕ) + 1 < F.n := by rw [hij]; exact i.2
    have hi : (⟨j + 1, hlt⟩ : Fin F.n) = i := Fin.ext hij
    have h1 : cyclicNext F.φ j = F.φ i := funext fun t => by rw [cyclicNext_of_lt _ hlt, hi]
    refine ⟨F.φ j, F.cont j, fun t ht => F.mono t ht (Fin.lt_def.2 (by omega)), fun ρ => by rw [h1]⟩
  · have hnlt : ¬ (j : ℕ) + 1 < F.n := by omega
    have hi : (⟨0, j.pos⟩ : Fin F.n) = i := Fin.ext hi0.symm
    have h1 : cyclicNext F.φ j = fun t => F.φ i t + 2 * Real.pi :=
      funext fun t => by rw [cyclicNext_of_not_lt _ hnlt, hi]
    refine ⟨fun t => F.φ j t - 2 * Real.pi, (F.cont j).sub continuousOn_const,
      fun t ht => by linarith [F.wrap t ht j i], fun ρ => ?_⟩
    rw [h1]
    ext w
    constructor
    · rintro ⟨t, ht, θ, hθ, rfl⟩
      exact ⟨t, ht, θ + 2 * Real.pi, ⟨by linarith [hθ.1], by linarith [hθ.2]⟩, (polarPt_add_two_pi z t θ).symm⟩
    · rintro ⟨t, ht, θ, hθ, rfl⟩
      refine ⟨t, ht, θ - 2 * Real.pi, ⟨by linarith [hθ.1], by linarith [hθ.2]⟩, ?_⟩
      rw [← polarPt_add_two_pi z t (θ - 2 * Real.pi), sub_add_cancel]

/-- **Near a point of branch `i` every point is on the branch or in one of the two cells beside it** (FS131-E8 § 6.2
(2)): an open set about the point inside the union of the cell clockwise of the branch, the branch and the cell
counter-clockwise of it. -/
theorem exists_isOpen_subset_cells {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n))
    {t : ℝ} (ht : t ∈ Ioo 0 F.r) :
    ∃ O : Set ℂ, IsOpen O ∧ polarPt z t (F.φ i t) ∈ O ∧ O ⊆ F.cell j ∪ F.branch i ∪ F.cell i := by
  obtain ⟨lo, hlo, hlt, heq⟩ := F.exists_lower_of_pred hij
  refine ⟨polarRegion z F.r lo (cyclicNext F.φ i), polarRegion_isOpen z hlo (F.continuousOn_cyclicNext i),
    ⟨t, ht, F.φ i t, ⟨hlt t ht, F.φ_lt_cyclicNext i ht⟩, rfl⟩, ?_⟩
  rintro w ⟨s, hs, θ, hθ, rfl⟩
  rcases lt_trichotomy θ (F.φ i s) with h | h | h
  · refine Or.inl (Or.inl ?_)
    rw [cell, ← heq]
    exact ⟨s, hs, θ, ⟨hθ.1, h⟩, rfl⟩
  · exact Or.inl (Or.inr ⟨s, hs, by rw [h]⟩)
  · exact Or.inr ⟨s, hs, θ, ⟨h, hθ.2⟩, rfl⟩

/-- Near a point of branch `i` almost every point has the colour of one of the two cells beside the branch. -/
theorem exists_isOpen_ae_two_colours {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n))
    {t : ℝ} (ht : t ∈ Ioo 0 F.r) :
    ∃ O : Set ℂ, IsOpen O ∧ polarPt z t (F.φ i t) ∈ O ∧ (O : Set ℂ) ≤ᵐ[volume] (c.cls (F.col j) ∪ c.cls (F.col i) : Set ℂ) := by
  obtain ⟨O, hO, hx, hsub⟩ := F.exists_isOpen_subset_cells hij ht
  refine ⟨O, hO, hx, ?_⟩
  have h1 : (F.cell j ∪ F.branch i ∪ F.cell i : Set ℂ) ≤ᵐ[volume] (c.cls (F.col j) ∪ c.cls (F.col i) : Set ℂ) := by
    have hb : (F.branch i : Set ℂ) ≤ᵐ[volume] (∅ : Set ℂ) := by
      rw [ae_le_set, sdiff_empty]
      exact measure_mono_null (fun w hw => (F.branch_subset i hw).1) c.volume_essBdry
    have h2 := ((F.region j).union hb).union (F.region i)
    rwa [union_empty] at h2
  exact Filter.EventuallyLE.trans (Eventually.of_forall hsub) h1

/-- The regions on the two sides of a branch have different colours: `col_ne`, stated before `two_le_n`, which reads
it at a fan with one branch. -/
theorem col_ne_aux {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) : F.col j ≠ F.col i := by
  intro heq
  obtain ⟨O, hO, hx, hae⟩ := F.exists_isOpen_ae_two_colours hij (t := F.r / 2) ⟨half_pos F.r_pos, half_lt_self F.r_pos⟩
  rw [heq, union_self] at hae
  have hd := subset_densitySet_of_isOpen_ae_subset hO hae hx
  exact c.notMem_essBdry_of_mem_densitySet hd
    (F.branch_subset i ⟨F.r / 2, ⟨half_pos F.r_pos, half_lt_self F.r_pos⟩, rfl⟩).1

/-- **A branch of a fan, under saturation in the punctured disc, is a unit-speed curve of curvature at most `1` from
`z`** (FS131-E8-GAMMA and -BETA for the branch; the deriver's § 6.5: through `gamma` and
`IsUnitCurve.exists_polarGraph`, not `beta`, which drops the tangent): within distance `min F.r (1/2)` of `z` branch
`i` is `γ '' (0, L)` for a curve `γ` of length `L ≤ π/2` with `γ 0 = z`, whose initial tangent is the branch's limit
direction. -/
theorem exists_unitCurve_branch (hsat : SaturatedOn c.cls (ball z F.r \ {z})) (i : Fin F.n) :
    ∃ (L : ℝ) (γ : ℝ → ℂ) (ψ : ℝ → ℝ), 0 < L ∧ L ≤ Real.pi / 2 ∧ IsUnitCurve γ ψ (Icc 0 L) ∧ γ 0 = z ∧
      e (ψ 0) = e (F.dir i) ∧ γ '' Ioo 0 L = polarGraph z (min F.r (1 / 2)) (F.φ i) := by
  set R : ℝ := min F.r (1 / 2) with hRdef
  have hR0 : 0 < R := lt_min F.r_pos (by norm_num)
  have hRr : R ≤ F.r := min_le_left _ _
  have hiso : c.IsolatedAt z R :=
    ⟨hR0, min_le_right _ _, fun w hw => F.singular ⟨hw.1, ball_subset_ball hRr hw.2⟩,
      hsat.mono (sdiff_subset_sdiff_left (ball_subset_ball hRr))⟩
  set B : Set ℂ := polarGraph z R (F.φ i) with hB
  have hBsub : B ⊆ c.essBdry ∩ (ball z R \ {z}) := by
    intro w hw
    refine ⟨?_, polarGraph_subset z R _ hw⟩
    obtain ⟨t, ht, rfl⟩ := hw
    exact (F.branch_subset i ⟨t, ⟨ht.1, lt_of_lt_of_le ht.2 hRr⟩, rfl⟩).1
  have hBpre : IsPreconnected B := by
    have him : B = (fun t => polarPt z t (F.φ i t)) '' Ioo 0 R := by
      ext w; constructor
      · rintro ⟨t, ht, rfl⟩; exact ⟨t, ht, rfl⟩
      · rintro ⟨t, ht, rfl⟩; exact ⟨t, ht, rfl⟩
    rw [him]
    refine isPreconnected_Ioo.image _ ?_
    have h1 : ContinuousOn (fun t : ℝ => (t, F.φ i t)) (Ioo 0 R) :=
      continuousOn_id.prodMk ((F.cont i).mono (Ioo_subset_Ioo_right hRr))
    exact (continuous_polarPt z).comp_continuousOn h1
  have hy0 : polarPt z (R / 2) (F.φ i (R / 2)) ∈ B := ⟨R / 2, ⟨half_pos hR0, half_lt_self hR0⟩, rfl⟩
  obtain ⟨L, γ, ψ, hL0, hLπ, hcurve, -, hK, -, -⟩ := gamma hiso (hBsub hy0)
  have hBK : B ⊆ γ '' Ioo 0 L := by
    rw [← hK]; exact hBpre.subset_connectedComponentIn hy0 hBsub
  have hKsub : γ '' Ioo 0 L ⊆ c.essBdry ∩ (ball z R \ {z}) := by
    rw [← hK]; exact connectedComponentIn_subset _ _
  -- `z` is an end of the curve
  have hzB : z ∈ closure B := by
    rw [Metric.mem_closure_iff]
    intro ε hε
    have ht : min ε R / 2 ∈ Ioo 0 R :=
      ⟨half_pos (lt_min hε hR0), by have := min_le_right ε R; linarith [lt_min hε hR0]⟩
    refine ⟨_, ⟨_, ht, rfl⟩, ?_⟩
    rw [dist_comm, dist_polarPt z ht.1.le]
    have := min_le_left ε R; linarith [lt_min hε hR0]
  have hzI : z ∈ γ '' Icc 0 L :=
    closure_minimal (hBK.trans (image_mono Ioo_subset_Icc_self))
      (isCompact_Icc.image_of_continuousOn fun s hs => (hcurve.hasDeriv s hs).continuousWithinAt).isClosed hzB
  obtain ⟨s₀, hs₀, hs₀z⟩ := hzI
  have hends : s₀ = 0 ∨ s₀ = L := by
    by_contra hne
    rw [not_or] at hne
    have hmem : s₀ ∈ Ioo 0 L := ⟨lt_of_le_of_ne hs₀.1 (Ne.symm hne.1), lt_of_le_of_ne hs₀.2 hne.2⟩
    exact (hKsub ⟨s₀, hmem, hs₀z⟩).2.2 rfl
  -- run the curve from `z`
  obtain ⟨γ', ψ', hcurve', hγ'0, hK'⟩ : ∃ (γ' : ℝ → ℂ) (ψ' : ℝ → ℝ),
      IsUnitCurve γ' ψ' (Icc 0 L) ∧ γ' 0 = z ∧ γ' '' Ioo 0 L = γ '' Ioo 0 L := by
    rcases hends with h0 | hL
    · exact ⟨γ, ψ, hcurve, by rw [← h0, hs₀z], rfl⟩
    · refine ⟨fun s => γ (L - s), fun s => ψ (L - s) + Real.pi, hcurve.reverse, ?_, ?_⟩
      · simp only [sub_zero]; rw [← hL, hs₀z]
      · ext w; constructor
        · rintro ⟨s, hs, rfl⟩; exact ⟨L - s, ⟨by linarith [hs.2], by linarith [hs.1]⟩, rfl⟩
        · rintro ⟨s, hs, rfl⟩; exact ⟨L - s, ⟨by linarith [hs.2], by linarith [hs.1]⟩, by simp⟩
  obtain ⟨φ', -, hφ't, hpg⟩ := hcurve'.exists_polarGraph hL0 hLπ
  rw [hγ'0, hK'] at hpg
  -- on `(0, R)` the two polar angles give the same direction
  have hsame : ∀ t ∈ Ioo 0 R, e (F.φ i t) = e (φ' t) := by
    intro t ht
    have hmem : polarPt z t (F.φ i t) ∈ γ '' Ioo 0 L := hBK ⟨t, ht, rfl⟩
    rw [hpg] at hmem
    obtain ⟨t', ht', heq⟩ := hmem
    have hd : t = t' := by
      have := congrArg (fun w => dist w z) heq
      simpa only [dist_polarPt z ht.1.le, dist_polarPt z ht'.1.le] using this
    subst hd
    rw [polarPt, polarPt, add_right_inj] at heq
    exact mul_left_cancel₀ (Complex.ofReal_ne_zero.2 ht.1.ne') heq
  refine ⟨L, γ', ψ', hL0, hLπ, hcurve', hγ'0, ?_, ?_⟩
  · have h1 : Tendsto (fun t => e (F.φ i t)) (𝓝[>] 0) (𝓝 (e (F.dir i))) :=
      (continuous_e.tendsto _).comp (F.tendsto i)
    have h2 : Tendsto (fun t => e (φ' t)) (𝓝[>] 0) (𝓝 (e (ψ' 0))) := (continuous_e.tendsto _).comp hφ't
    have h3 : (fun t => e (F.φ i t)) =ᶠ[𝓝[>] 0] fun t => e (φ' t) := by
      filter_upwards [Ioo_mem_nhdsGT hR0] with t ht using hsame t ht
    exact (tendsto_nhds_unique (h1.congr' h3) h2).symm
  · rw [hK']
    refine Subset.antisymm ?_ hBK
    intro w hw
    have hball := (hKsub hw).2.1
    rw [hpg] at hw
    obtain ⟨t', ht', rfl⟩ := hw
    rw [mem_ball, dist_polarPt z ht'.1.le] at hball
    have ht : t' ∈ Ioo 0 R := ⟨ht'.1, hball⟩
    refine ⟨t', ht, ?_⟩
    rw [polarPt, polarPt, hsame t' ht]
/-! ### The contacts at a branch (FS131-I6E; FS131-E8 § 6.1) -/

/-- At a point of branch `i` some ball centred there is a two-colour neighbourhood with the colours of the two cells
beside the branch (FS131-E8 § 6.1: "its two-colour ball has the colours `a`, `b`"). No saturation. -/
theorem exists_twoColourNhd_branch {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n))
    {t : ℝ} (ht : t ∈ Ioo 0 F.r) :
    ∃ ρ, TwoColourNhd c.cls (ball (polarPt z t (F.φ i t)) ρ) (F.col j) (F.col i) := by
  have hxb : polarPt z t (F.φ i t) ∈ F.branch i := ⟨t, ht, rfl⟩
  obtain ⟨ρ, a', b', h⟩ := exists_twoColourNhd_of_mem_interfaceSet (F.branch_subset_interfaceSet i hxb)
  have hxN : polarPt z t (F.φ i t) ∈ ball (polarPt z t (F.φ i t)) ρ := mem_ball_self h.radius_pos
  obtain ⟨hxa, hxb'⟩ := h.mem_essBoundary c.measurableSet_cls hxN (F.branch_subset i hxb).1
  obtain ⟨O, hO, hxO, hae⟩ := F.exists_isOpen_ae_two_colours hij ht
  have ha := c.eq_or_eq_of_mem_essClosure hO hae hxO hxa.1
  have hb := c.eq_or_eq_of_mem_essClosure hO hae hxO hxb'.1
  have hne := h.ne
  rcases ha with rfl | rfl <;> rcases hb with rfl | rfl
  · exact absurd rfl hne
  · exact ⟨ρ, h⟩
  · exact ⟨ρ, h.symm⟩
  · exact absurd rfl hne

/-- **A common contact propagates along a branch** (FS131-E8 § 6.1, Case A): if one point of branch `i` is at
distance `1` from a point `y` in the supports of both colours beside the branch, every point of the branch is —
FS111-M-PINCH's split type at each such point (a common contact excludes the tangent type), FS111-M-C11 (iii) in its
two-colour ball, and the connectedness of `(0, F.r)`. No saturation and no bound `1/2` is read. -/
theorem dist_eq_one_of_common_contact {i j : Fin F.n}
    (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) {y : ℂ}
    (hya : y ∈ essSupport (c.cls (F.col j))) (hyb : y ∈ essSupport (c.cls (F.col i))) {t₀ : ℝ}
    (ht₀ : t₀ ∈ Ioo 0 F.r) (h0 : dist (polarPt z t₀ (F.φ i t₀)) y = 1) :
    ∀ t ∈ Ioo 0 F.r, dist (polarPt z t (F.φ i t)) y = 1 := by
  have hpc : ContinuousOn (fun t => polarPt z t (F.φ i t)) (Ioo 0 F.r) :=
    (continuous_polarPt z).comp_continuousOn (continuousOn_id.prodMk (F.cont i))
  have hf : ContinuousOn (fun t => dist (polarPt z t (F.φ i t)) y) (Ioo 0 F.r) :=
    fun t ht => (hpc t ht).dist continuousWithinAt_const
  have hopen : ∀ t₁ ∈ Ioo 0 F.r, dist (polarPt z t₁ (F.φ i t₁)) y = 1 →
      ∀ᶠ t in 𝓝 t₁, dist (polarPt z t (F.φ i t)) y = 1 := by
    intro t₁ ht₁ h1
    obtain ⟨ρ, h⟩ := F.exists_twoColourNhd_branch hij ht₁
    have hxN : polarPt z t₁ (F.φ i t₁) ∈ ball (polarPt z t₁ (F.φ i t₁)) ρ := mem_ball_self h.radius_pos
    have hsph : essBoundary (c.cls (F.col j)) ∩ ball (polarPt z t₁ (F.φ i t₁)) ρ =
        sphere y 1 ∩ ball (polarPt z t₁ (F.φ i t₁)) ρ := by
      rcases pinch (c.measurableSet_cls _) (c.unitPairsNull _) (c.measurableSet_cls _) (c.unitPairsNull _) h.two
        hxN hya h1 hyb h1 with ⟨-, hs | hs⟩ | ⟨hanti, -⟩
      · exact (c11_split isOpen_ball hs).1
      · exact (c11_split isOpen_ball hs).2
      · exfalso
        have h2 : y - polarPt z t₁ (F.φ i t₁) = 0 := by linear_combination (1 / 2 : ℂ) * hanti
        rw [sub_eq_zero] at h2
        rw [h2, dist_self] at h1
        exact zero_ne_one h1
    have hI : Ioo 0 F.r ∈ 𝓝 t₁ := Ioo_mem_nhds ht₁.1 ht₁.2
    filter_upwards [(hpc.continuousAt hI) (isOpen_ball.mem_nhds hxN), hI] with t htN ht
    have hb := (F.branch_subset i ⟨t, ht, rfl⟩).1
    have h2 : polarPt z t (F.φ i t) ∈ sphere y 1 ∩ ball (polarPt z t₁ (F.φ i t₁)) ρ :=
      hsph ▸ ⟨(h.mem_essBoundary c.measurableSet_cls htN hb).1, htN⟩
    exact mem_sphere.1 h2.1
  have hsub : Ioo 0 F.r ⊆ Ioo 0 F.r ∩ {t | ∀ᶠ t' in 𝓝 t, dist (polarPt z t' (F.φ i t')) y = 1} := by
    refine isPreconnected_Ioo.subset_left_of_subset_union
      (v := Ioo 0 F.r ∩ (fun t => dist (polarPt z t (F.φ i t)) y) ⁻¹' {1}ᶜ)
      (isOpen_Ioo.inter isOpen_setOf_eventually_nhds) (hf.isOpen_inter_preimage isOpen_Ioo isOpen_compl_singleton)
      ?_ ?_ ⟨t₀, ht₀, ht₀, hopen t₀ ht₀ h0⟩
    · rw [Set.disjoint_left]
      rintro t ⟨-, hev⟩ ⟨-, hne⟩
      exact hne (show ∀ᶠ t' in 𝓝 t, dist (polarPt z t' (F.φ i t')) y = 1 from hev).self_of_nhds
    · intro t ht
      by_cases h1 : dist (polarPt z t (F.φ i t)) y = 1
      · exact Or.inl ⟨ht, hopen t ht h1⟩
      · exact Or.inr ⟨ht, h1⟩
  exact fun t ht => (show ∀ᶠ t' in 𝓝 t, dist (polarPt z t' (F.φ i t')) y = 1 from (hsub ht).2).self_of_nhds

/-- **A branch on a unit circle has its centre on the normal at `z`**: if the points of branch `i` near `z` are at
distance `1` from `y`, then `y = z ± i e(dir i)` (FS131-E8 § 6.1: "the branch's limit direction is the circle's
tangent at `z`"). -/
theorem eq_add_or_eq_sub_of_dist_eq_one (i : Fin F.n) {y : ℂ} {ρ : ℝ} (hρ : 0 < ρ)
    (h : ∀ t ∈ Ioo 0 ρ, dist (polarPt z t (F.φ i t)) y = 1) :
    y = z + I * e (F.dir i) ∨ y = z - I * e (F.dir i) := by
  have hlim : Tendsto (fun t => polarPt z t (F.φ i t)) (𝓝[>] 0) (𝓝 z) := by
    rw [tendsto_iff_dist_tendsto_zero]
    have h1 : Tendsto (fun t : ℝ => t) (𝓝[>] 0) (𝓝 0) := tendsto_nhdsWithin_of_tendsto_nhds tendsto_id
    refine h1.congr' ?_
    filter_upwards [self_mem_nhdsWithin] with t ht
    exact (dist_polarPt z (le_of_lt ht) _).symm
  have hzy : dist z y = 1 := by
    refine tendsto_nhds_unique (hlim.dist tendsto_const_nhds) (tendsto_const_nhds.congr' ?_)
    filter_upwards [Ioo_mem_nhdsGT hρ] with t ht using (h t ht).symm
  set u : ℂ := y - z with hu
  have hun : ‖u‖ = 1 := by rw [hu, ← dist_eq_norm, dist_comm]; exact hzy
  have hy : y = z + u := by rw [hu]; ring
  have key : ∀ t ∈ Ioo 0 ρ, (e (F.φ i t) * (starRingEnd ℂ) u).re = t / 2 := by
    intro t ht
    have h1 := dist_sq_polarPt_add z t (F.φ i t) u
    rw [← hy, h t ht, hun] at h1
    have h2 : t * (2 * (e (F.φ i t) * (starRingEnd ℂ) u).re - t) = 0 := by linear_combination h1
    rcases mul_eq_zero.1 h2 with h3 | h3
    · exact absurd h3 ht.1.ne'
    · linarith
  have hre : (e (F.dir i) * (starRingEnd ℂ) u).re = 0 := by
    have h1 : Tendsto (fun t => (e (F.φ i t) * (starRingEnd ℂ) u).re) (𝓝[>] 0)
        (𝓝 ((e (F.dir i) * (starRingEnd ℂ) u).re)) :=
      (Complex.continuous_re.tendsto _).comp (((continuous_e.tendsto _).comp (F.tendsto i)).mul_const _)
    have h2 : Tendsto (fun t : ℝ => t / 2) (𝓝[>] 0) (𝓝 0) := by
      have h3 : Tendsto (fun t : ℝ => t / 2) (𝓝 0) (𝓝 (0 / 2)) := tendsto_id.div_const 2
      rw [zero_div] at h3
      exact tendsto_nhdsWithin_of_tendsto_nhds h3
    refine tendsto_nhds_unique h1 (h2.congr' ?_)
    filter_upwards [Ioo_mem_nhdsGT hρ] with t ht using (key t ht).symm
  have hre' : (u * (starRingEnd ℂ) (e (F.dir i))).re = 0 := by
    rw [← Complex.conj_re, map_mul, Complex.conj_conj, mul_comm]; exact hre
  rcases eq_I_mul_or_eq_neg_of_re_eq_zero hun (norm_e _) hre' with h1 | h1
  · left; rw [hy, h1]
  · right; rw [hy, h1, sub_eq_add_neg]

/-- **The contacts at a point of a branch with no common contact** (FS131-E8 § 6.1, Case B, at one point): on the
branch's curve `γ` from `z`, if no branch point has a common contact of the two colours, the point `γ s` is of
tangent type with normal `i e(ψ s)` into the counter-clockwise cell — `γ s + i e(ψ s)` is in the support of the
clockwise colour and `γ s − i e(ψ s)` in that of the counter-clockwise one. The normal is perpendicular to the tangent
because the curve stays outside the open unit disc about the contact (Fermat); its sign because the tangent has a
positive radial component (`IsUnitCurve.sin_le_inner`), so a small turn counter-clockwise about `z` enters the disc
about `γ s + i e(ψ s)`, and that point is in the counter-clockwise cell. -/
theorem contacts_of_no_common (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i j : Fin F.n}
    (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) {L : ℝ} {γ : ℝ → ℂ} {ψ : ℝ → ℝ}
    (hLπ : L ≤ Real.pi / 2) (hcurve : IsUnitCurve γ ψ (Icc 0 L)) (hγ0 : γ 0 = z)
    (hK : γ '' Ioo 0 L = polarGraph z (min F.r (1 / 2)) (F.φ i))
    (hno : ∀ t ∈ Ioo 0 (min F.r (1 / 2)), ∀ y ∈ essSupport (c.cls (F.col j)),
      y ∈ essSupport (c.cls (F.col i)) → dist (polarPt z t (F.φ i t)) y ≠ 1) {s : ℝ} (hs : s ∈ Ioo 0 L) :
    γ s + I * e (ψ s) ∈ essSupport (c.cls (F.col j)) ∧ γ s - I * e (ψ s) ∈ essSupport (c.cls (F.col i)) := by
  have hRr : min F.r (1 / 2) ≤ F.r := min_le_left _ _
  obtain ⟨t, ht, hxt⟩ : ∃ t ∈ Ioo 0 (min F.r (1 / 2)), γ s = polarPt z t (F.φ i t) := by
    have h1 : γ s ∈ polarGraph z (min F.r (1 / 2)) (F.φ i) := by rw [← hK]; exact mem_image_of_mem γ hs
    exact h1
  have htr : t ∈ Ioo 0 F.r := ⟨ht.1, lt_of_lt_of_le ht.2 hRr⟩
  obtain ⟨ρ, h⟩ := F.exists_twoColourNhd_branch hij htr
  rw [← hxt] at h
  have hxbr : γ s ∈ F.branch i := by rw [hxt]; exact ⟨t, htr, rfl⟩
  have hxN : γ s ∈ ball (γ s) ρ := mem_ball_self h.radius_pos
  obtain ⟨hxa, hxb⟩ := h.mem_essBoundary c.measurableSet_cls hxN (F.branch_subset i hxbr).1
  have hxU := (F.branch_subset i hxbr).2
  obtain ⟨ya, hya, hda⟩ := hsat (F.col j) (γ s) ⟨hxa, hxU⟩
  obtain ⟨yb, hyb, hdb⟩ := hsat (F.col i) (γ s) ⟨hxb, hxU⟩
  rw [← essSupport_eq_closure_densitySet] at hya hyb
  rcases pinch (c.measurableSet_cls _) (c.unitPairsNull _) (c.measurableSet_cls _) (c.unitPairsNull _) h.two hxN
    hya hda hyb hdb with ⟨heq, -⟩ | ⟨-, ⟨hν, hdB, hdA⟩, hsa, hsb⟩
  · rw [← heq] at hyb
    rw [hxt] at hda
    exact absurd hda (hno t ht ya hya hyb)
  · set ν : ℂ := ya - γ s with hνdef
    have hperp : (ν * (starRingEnd ℂ) (e (ψ s))).re = 0 := by
      have hsI : Icc 0 L ∈ 𝓝 s := Icc_mem_nhds hs.1 hs.2
      have hd := (hcurve.hasDerivWithinAt_norm_sq (γ s + ν) (Ioo_subset_Icc_self hs)).hasDerivAt hsI
      have hcont : ContinuousAt γ s := (hcurve.hasDeriv s (Ioo_subset_Icc_self hs)).continuousWithinAt.continuousAt hsI
      have hl : ‖γ s - (γ s + ν)‖ = 1 := by rw [sub_add_cancel_left, norm_neg, hν]
      have hmin : IsLocalMin (fun u => ‖γ u - (γ s + ν)‖ ^ 2) s := by
        show ∀ᶠ u in 𝓝 s, ‖γ s - (γ s + ν)‖ ^ 2 ≤ ‖γ u - (γ s + ν)‖ ^ 2
        filter_upwards [hcont (isOpen_ball.mem_nhds hxN), Ioo_mem_nhds hs.1 hs.2] with u huN hu
        have hub : γ u ∈ c.essBdry := by
          have h1 : γ u ∈ polarGraph z (min F.r (1 / 2)) (F.φ i) := by rw [← hK]; exact mem_image_of_mem γ hu
          obtain ⟨t', ht', hut⟩ := h1
          rw [hut]
          exact (F.branch_subset i ⟨t', ⟨ht'.1, lt_of_lt_of_le ht'.2 hRr⟩, rfl⟩).1
        have hout : γ u ∉ ball (γ s + ν) 1 := fun hin =>
          c.notMem_essBdry_of_mem_densitySet
            (subset_densitySet_of_isOpen_ae_subset (isOpen_ball.inter isOpen_ball) hdB ⟨hin, huN⟩) hub
        rw [mem_ball, not_lt, dist_eq_norm] at hout
        rw [hl]
        nlinarith [norm_nonneg (γ u - (γ s + ν))]
      have h0 := hmin.hasDerivAt_eq_zero hd
      rw [sub_add_cancel_left, neg_mul, Complex.neg_re] at h0
      linarith
    rcases eq_I_mul_or_eq_neg_of_re_eq_zero hν (norm_e _) hperp with hpos | hneg
    · rw [← hpos]
      exact ⟨hsa, hsb⟩
    · exfalso
      have hcos : 0 < Real.cos (F.φ i t - ψ s) := by
        have h1 := hcurve.sin_le_inner hLπ (Ioo_subset_Icc_self hs)
        rw [hγ0, hxt, polarPt, add_sub_cancel_left, mul_assoc, Complex.re_ofReal_mul, re_e_mul_conj_e_eq_cos] at h1
        have h2 : 0 < Real.sin s := Real.sin_pos_of_pos_of_lt_pi hs.1 (by linarith [hs.2, Real.pi_pos])
        by_contra hle
        rw [not_lt] at hle
        nlinarith [mul_nonneg ht.1.le (neg_nonneg.2 hle)]
      have e1 := eventually_dist_polarPt_lt_one z ht.1 hcos
      have hc : Continuous (fun η : ℝ => polarPt z t (F.φ i t + η)) :=
        (continuous_polarPt z).comp (continuous_const.prodMk (continuous_const.add continuous_id))
      have e2 : ∀ᶠ η in 𝓝[>] (0 : ℝ), polarPt z t (F.φ i t + η) ∈ ball (γ s) ρ := by
        refine nhdsWithin_le_nhds (hc.continuousAt (isOpen_ball.mem_nhds ?_))
        show polarPt z t (F.φ i t + 0) ∈ ball (γ s) ρ
        rw [add_zero, ← hxt]; exact hxN
      have e3 : ∀ᶠ η in 𝓝[>] (0 : ℝ), η ∈ Ioo 0 (cyclicNext F.φ i t - F.φ i t) :=
        Ioo_mem_nhdsGT (sub_pos.2 (F.φ_lt_cyclicNext i htr))
      obtain ⟨η, ⟨h1, h2⟩, h3⟩ := ((e1.and e2).and e3).exists
      have hcell : polarPt z t (F.φ i t + η) ∈ F.cell i :=
        ⟨t, htr, _, ⟨by linarith [h3.1], by linarith [h3.2]⟩, rfl⟩
      have hdisc : polarPt z t (F.φ i t + η) ∈ ball (γ s - ν) 1 := by
        rw [mem_ball, hneg, sub_neg_eq_add, hxt]; exact h1
      exact h.two.false_of_mem_inter isOpen_ball (F.isOpen_cell i) hdA
        (Filter.EventuallyLE.trans (Eventually.of_forall inter_subset_left) (F.region i)) h2 hdisc hcell

end Fan

namespace Fan

variable (F : c.Fan z)

/-- **At a singular point a fan has at least two branches** (FS131-E8-FAN). Saturation is not read: with no branch
the punctured disc is of one colour and `z` is a density point; with one, its points are density points. -/
theorem two_le_n (hz : z ∈ c.singularSet) : 2 ≤ F.n := by
  by_contra hlt
  rw [not_le] at hlt
  rcases Nat.lt_succ_iff.1 hlt |>.eq_or_lt with h1 | h0
  · -- one branch: the regions on its two sides are one region
    have hpos : 0 < F.n := by omega
    exact F.col_ne_aux (i := ⟨0, hpos⟩) (j := ⟨0, hpos⟩) (Or.inr ⟨rfl, by simp [h1]⟩) rfl
  · -- no branch: the punctured disc is of one colour, and `z` is a density point of it
    have hn : F.n = 0 := by omega
    have hempty : IsEmpty (Fin F.n) := ⟨fun i => by have := i.2; omega⟩
    have hb : Disjoint (ball z F.r \ {z}) c.essBdry := by
      rw [disjoint_iff_inter_eq_empty, inter_comm, F.bdry, iUnion_of_empty]
    have hcusp : Disjoint (ball z F.r \ {z}) (cuspSet c.cls) := by
      rw [Set.disjoint_left]
      rintro w ⟨hw, hwz⟩ hwc
      exact hwz (F.singular ⟨cuspSet_subset_singularSet _ hwc, hw⟩)
    obtain ⟨j, hj⟩ := c.ae_one_colour_of_isConnected (isOpen_ball.sdiff isClosed_singleton)
      (isConnected_ball_diff_singleton z F.r_pos) hb hcusp
    have hball : (ball z F.r : Set ℂ) ≤ᵐ[volume] c.cls j := by
      rw [ae_le_set] at hj ⊢
      refine measure_mono_null (t := ((ball z F.r \ {z}) \ c.cls j) ∪ {z}) ?_
        (measure_union_null hj (measure_singleton z))
      rintro w ⟨hw, hwj⟩
      by_cases hwz : w = z
      · exact Or.inr hwz
      · exact Or.inl ⟨⟨hw, hwz⟩, hwj⟩
    have hzd : z ∈ densitySet (c.cls j) :=
      subset_densitySet_of_isOpen_ae_subset isOpen_ball hball (mem_ball_self F.r_pos)
    rcases hz with ⟨hzb, -⟩ | ⟨j', hj'1, hj'2⟩
    · exact c.notMem_essBdry_of_mem_densitySet hzd hzb
    · by_cases hjj : j' = j
      · subst hjj
        exact hj'2 (upperDensityAt_pos_of_mem_densitySet hzd)
      · have h0 : volume (c.cls j' ∩ ball z F.r) = 0 := by
          rw [ae_le_set] at hball
          refine measure_mono_null ?_ hball
          rintro w ⟨hwj', hw⟩
          exact ⟨hw, fun hwj => hjj ((show c.col w = j' from hwj').symm.trans hwj)⟩
        exact (hj'1 F.r F.r_pos).ne' h0

/-- **The regions on the two sides of a branch have different colours** (FS131-E8-FAN): `j` is the region clockwise
of branch `i`. Saturation is not read. -/
theorem col_ne {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) : F.col j ≠ F.col i := by
  exact F.col_ne_aux hij

/-- **The lens**: under saturation in the punctured disc, within distance `1/2` of `z` each branch stays outside the
two open unit discs tangent to its limit direction at `z` — the comparison FS121-V2-SECTOR and FS121-V3's (F-c)
make (`IsUnitCurve.one_le_dist` on the branch's arclength parametrization). -/
theorem branch_outside_discs (hsat : SaturatedOn c.cls (ball z F.r \ {z})) (i : Fin F.n) {t : ℝ}
    (ht : t ∈ Ioo 0 (min F.r (1 / 2))) :
    1 ≤ dist (polarPt z t (F.φ i t)) (z + I * e (F.dir i)) ∧
      1 ≤ dist (polarPt z t (F.φ i t)) (z - I * e (F.dir i)) := by
  obtain ⟨L, γ, ψ, -, hLπ, hcurve, hγ0, hdir, hK⟩ := F.exists_unitCurve_branch hsat i
  have hmem : polarPt z t (F.φ i t) ∈ γ '' Ioo 0 L := by rw [hK]; exact ⟨t, ht, rfl⟩
  obtain ⟨s, hs, hsx⟩ := hmem
  have h := hcurve.one_le_dist hLπ (Ioo_subset_Icc_self hs)
  rwa [hsx, hγ0, hdir] at h

/-- **The contacts at a branch** (FS121-V2-verification § 2.1, Lemma T (ii), with FS111-M-C11 (iii) along the branch):
under saturation in the punctured disc, branch `i` — with the region `j` clockwise of it and the region `i`
counter-clockwise — is either an arc of the unit circle about a point `y = z ± i e(dir i)` in the supports of both
colours (split type, a unit arc of kind both), or of tangent type: `z + i e(dir i)`, across the counter-clockwise
side, is in the support of the clockwise colour, and `z − i e(dir i)` in the support of the counter-clockwise one.
**The alternative is inclusive** (FS131-E8 § 6.1): a unit arc about `y` whose colour has a further contact at the
antipode `2x − y` of its points `x` is of both types, so no consumer may read the second alternative as excluding a
unit arc. -/
theorem branch_contacts (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i j : Fin F.n}
    (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) :
    (∃ y, (y = z + I * e (F.dir i) ∨ y = z - I * e (F.dir i)) ∧ y ∈ essSupport (c.cls (F.col j)) ∧
        y ∈ essSupport (c.cls (F.col i)) ∧ ∀ t ∈ Ioo 0 (min F.r (1 / 2)), dist (polarPt z t (F.φ i t)) y = 1) ∨
      (z + I * e (F.dir i) ∈ essSupport (c.cls (F.col j)) ∧ z - I * e (F.dir i) ∈ essSupport (c.cls (F.col i))) := by
  have hR0 : 0 < min F.r (1 / 2) := lt_min F.r_pos (by norm_num)
  have hRr : min F.r (1 / 2) ≤ F.r := min_le_left _ _
  by_cases hcommon : ∃ t ∈ Ioo 0 (min F.r (1 / 2)), ∃ y ∈ essSupport (c.cls (F.col j)),
      y ∈ essSupport (c.cls (F.col i)) ∧ dist (polarPt z t (F.φ i t)) y = 1
  · -- a common contact: the branch is an arc of the unit circle about it
    obtain ⟨t₀, ht₀, y, hya, hyb, hd⟩ := hcommon
    have hall := F.dist_eq_one_of_common_contact hij hya hyb ⟨ht₀.1, lt_of_lt_of_le ht₀.2 hRr⟩ hd
    have hall' : ∀ t ∈ Ioo 0 (min F.r (1 / 2)), dist (polarPt z t (F.φ i t)) y = 1 :=
      fun t ht => hall t ⟨ht.1, lt_of_lt_of_le ht.2 hRr⟩
    exact Or.inl ⟨y, F.eq_add_or_eq_sub_of_dist_eq_one i hR0 hall', hya, hyb, hall'⟩
  · -- none: every point of the branch's curve is of tangent type, and the contacts converge
    right
    have hno : ∀ t ∈ Ioo 0 (min F.r (1 / 2)), ∀ y ∈ essSupport (c.cls (F.col j)),
        y ∈ essSupport (c.cls (F.col i)) → dist (polarPt z t (F.φ i t)) y ≠ 1 :=
      fun t ht y hya hyb hd => hcommon ⟨t, ht, y, hya, hyb, hd⟩
    obtain ⟨L, γ, ψ, hL0, hLπ, hcurve, hγ0, hdir, hK⟩ := F.exists_unitCurve_branch hsat i
    have hpt := fun s hs => F.contacts_of_no_common hsat hij hLπ hcurve hγ0 hK hno (s := s) hs
    haveI hne : (𝓝[Ioo 0 L] (0 : ℝ)).NeBot := by
      rw [← mem_closure_iff_nhdsWithin_neBot, closure_Ioo hL0.ne]; exact left_mem_Icc.2 hL0.le
    have hsub : 𝓝[Ioo 0 L] (0 : ℝ) ≤ 𝓝[Icc 0 L] 0 := nhdsWithin_mono _ Ioo_subset_Icc_self
    have h0 : (0 : ℝ) ∈ Icc 0 L := left_mem_Icc.2 hL0.le
    have hγt : Tendsto γ (𝓝[Ioo 0 L] 0) (𝓝 z) := by
      have h1 := (hcurve.hasDeriv 0 h0).continuousWithinAt.tendsto.mono_left hsub
      rwa [hγ0] at h1
    have hψt : Tendsto (fun s => e (ψ s)) (𝓝[Ioo 0 L] 0) (𝓝 (e (F.dir i))) := by
      have h1 := ((continuous_e.tendsto _).comp (hcurve.lip.continuousOn 0 h0).tendsto).mono_left hsub
      rw [← hdir]; exact h1
    have hmem : ∀ᶠ s in 𝓝[Ioo 0 L] (0 : ℝ), s ∈ Ioo 0 L := self_mem_nhdsWithin
    exact ⟨(isClosed_essSupport _).mem_of_tendsto (hγt.add (hψt.const_mul I)) (hmem.mono fun s hs => (hpt s hs).1),
      (isClosed_essSupport _).mem_of_tendsto (hγt.sub (hψt.const_mul I)) (hmem.mono fun s hs => (hpt s hs).2)⟩

/-- **FS121-V2-SECTOR.** Under saturation in the fan's punctured disc, a colour that occupies a sector of positive
angle at `z` occupies no other region there, of positive or of zero angle
(`plans/FS121-V2-verification.md` §§ 2.1–2.3: Lemmas C, H, T — `half_dichotomy`, `branch_contacts`,
`branch_outside_discs`). Read: the fan at `z` and saturation at the branch points; not read: saturation at `z`, local
finiteness of `Σ`, the number of colours. Under saturation the hypothesis "a fan at `z`" is equivalent to `Σ` being
locally finite near `z`, by FS131-E8-BRIDGE ([hand], one mind, until `fan_of_isolated` is proved). Inhabitant:
`sq9Fan` with `sq9_tight_saturated` (four regions of four colours). -/
theorem sector_alone (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i i' : Fin F.n} (hi : F.dir i < F.nextDir i)
    (hcol : F.col i = F.col i') : i = i' := by
  sorry

/-- **FS121-DB1-L3** (carrying FS111-W-NOREP): under saturation in the fan's punctured disc no colour occupies two
sectors of positive angle at `z`, whatever zero-angle regions are present. A case of `sector_alone`. -/
theorem sector_unique (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i i' : Fin F.n} (hi : F.dir i < F.nextDir i)
    (_hi' : F.dir i' < F.nextDir i') (hcol : F.col i = F.col i') : i = i' :=
  F.sector_alone hsat hi hcol

end Fan

end AeColouring

end HadwigerNelson.Plane
