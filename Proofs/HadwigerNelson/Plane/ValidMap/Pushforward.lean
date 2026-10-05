import Proofs.HadwigerNelson.Plane.ValidMap.Surgery

/-!
# The image of an arc map under a homeomorphism (FS131-KP2's skeleton for `bend_toward_collar`)

Generic, no collar: an arc map `F`, a homeomorphism `h` of the plane carrying `F`'s domain onto itself, and a locally finite set of arcs
`A'` whose union inside the domain is `h(Γ)`, give the arc map `F.pushforward h …` with the same domain, the arcs `A'` and the colour
`F.col ∘ h⁻¹` (`plans/FS131-collar-kernel-plan.md` § 3). Its interior points, classes and colours at a point are `F`'s carried by `h`
(topology alone). Sector counts are metric (balls), so they are carried only where they can be computed: where two maps agree near a
point (`hasDegree_iff_of_agree`), and at interior points (degree `1`, `hasDegree_iff_of_mem_interiorPts`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- **The colour carried by `h` is locally constant off the new arcs.** Route: a point `y` of the domain off `A'` is `h x` with
`x = h⁻¹ y ∈ F.dom` (`hdom`) off `Γ` (`hΓ`), so `x` is interior; `F.col` is locally constant at `x` and `h⁻¹` is continuous. -/
theorem pushforward_locallyConstant (h : ℂ ≃ₜ ℂ) (hdom : h '' F.dom = F.dom) {A' : Set Arc}
    (hΓ : F.dom ∩ ⋃ a ∈ A', a.carrier = h '' F.Γ) :
    ∀ x ∈ F.dom, x ∉ ⋃ a ∈ A', a.carrier → ∀ᶠ y in 𝓝 x, (F.col ∘ h.symm) y = (F.col ∘ h.symm) x := by
  sorry

/-- **The image of `F` under `h`**: `F`'s domain, the arcs `A'` (whose union inside the domain is `h(Γ)`), the colour `F.col ∘ h⁻¹`. -/
noncomputable def pushforward (h : ℂ ≃ₜ ℂ) (hdom : h '' F.dom = F.dom) (A' : Set Arc) (hnd : ∀ a ∈ A', a.Nondegenerate)
    (hlf : ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {a | a ∈ A' ∧ (a.carrier ∩ t).Nonempty}.Finite)
    (hΓ : F.dom ∩ ⋃ a ∈ A', a.carrier = h '' F.Γ) : ArcMap k where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := A'
  nondegenerate := hnd
  locallyFinite := hlf
  col := F.col ∘ h.symm
  locallyConstant := F.pushforward_locallyConstant h hdom hΓ

section Pushforward

variable {F} {h : ℂ ≃ₜ ℂ} {hdom : h '' F.dom = F.dom} {A' : Set Arc} {hnd : ∀ a ∈ A', a.Nondegenerate}
  {hlf : ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {a | a ∈ A' ∧ (a.carrier ∩ t).Nonempty}.Finite}
  {hΓ : F.dom ∩ ⋃ a ∈ A', a.carrier = h '' F.Γ}

/-- The image's `Γ` is `h(Γ)`. -/
theorem pushforward_Γ : (F.pushforward h hdom A' hnd hlf hΓ).Γ = h '' F.Γ := hΓ

/-- **The image's interior points are `h`'s image of `F`'s** (the domain is kept, `Γ` is carried). -/
theorem pushforward_interiorPts : (F.pushforward h hdom A' hnd hlf hΓ).interiorPts = h '' F.interiorPts := by
  sorry

/-- A point is interior in the image exactly when its preimage is interior in `F`. -/
theorem pushforward_mem_interiorPts_iff (z : ℂ) :
    h z ∈ (F.pushforward h hdom A' hnd hlf hΓ).interiorPts ↔ z ∈ F.interiorPts := by
  rw [pushforward_interiorPts]
  exact h.injective.mem_set_image

/-- The image's colour at `h z` is `F`'s at `z`. -/
theorem pushforward_col_apply (z : ℂ) : (F.pushforward h hdom A' hnd hlf hΓ).col (h z) = F.col z := by
  show F.col (h.symm (h z)) = F.col z
  rw [h.symm_apply_apply]

/-- **The image's classes are `h`'s images of `F`'s.** -/
theorem pushforward_region (j : Fin k) : (F.pushforward h hdom A' hnd hlf hΓ).region j = h '' F.region j := by
  sorry

/-- **The colours at a point are carried**: `P_cl` of the image at `h z` is `F`'s at `z` (a homeomorphism carries closures). -/
theorem pushforward_coloursAt (z : ℂ) : (F.pushforward h hdom A' hnd hlf hΓ).coloursAt (h z) = F.coloursAt z := by
  sorry

end Pushforward

/-! ## Sector counts where they can be computed -/

variable {F}

/-- **Two maps agreeing near a point have the same sectors there**: if on a ball about `v` the two maps have the same interior points and
the same colours on them, then for every smaller radius their sectors coincide, so their degrees and repeated colours at `v` agree.
Route: `IsSector v r S` reads only `interiorPts ∩ ball v r` and the colour on it. -/
theorem hasDegree_iff_of_agree {F' : ArcMap k} {v : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀)
    (hI : ∀ x ∈ ball v r₀, x ∈ F'.interiorPts ↔ x ∈ F.interiorPts)
    (hc : ∀ x ∈ ball v r₀, x ∈ F.interiorPts → F'.col x = F.col x) :
    (∀ n, F'.HasDegree v n ↔ F.HasDegree v n) ∧ (F'.HasRepeatedColour v ↔ F.HasRepeatedColour v) := by
  sorry

/-- **Charts with one colour word give one degree and one repeated-colour answer** — the statement the collar's degree clauses derive
from (`plans/FS131-collar-kernel-plan.md` § 5): sector counts are never carried by a homeomorphism (they read balls); they are read off a
chart, and two charts (at any two points, of any two maps) with the same number of germs and the same sector colours give the same
degree (`IsSectorChart.hasDegree`) and the same counts per colour (`IsSectorChart.encard_sectorsOf`). With no germ both points are
interior: degree `1`, no repeated colour. -/
theorem hasDegree_iff_of_charts {F' : ArcMap k} {n : ℕ} {G G' : BranchGerms n} {v w : ℂ} {r₀ r₀' : ℝ}
    (hC : F.IsSectorChart G v r₀) (hC' : F'.IsSectorChart G' w r₀') {col : Fin n → Fin k}
    (hcol : ∀ i, ∀ r ∈ Ioc 0 r₀, G.sector v r i ⊆ F.region (col i))
    (hcol' : ∀ i, ∀ r ∈ Ioc 0 r₀', G'.sector w r i ⊆ F'.region (col i)) :
    (∀ m, F'.HasDegree w m ↔ F.HasDegree v m) ∧ (F'.HasRepeatedColour w ↔ F.HasRepeatedColour v) := by
  sorry

/-- **At an interior point the degree is `1`** (the chart of `localSectors` has no germ: `IsSectorChart.hasDegree`, `max 0 1 = 1`; and
a degree is unique, the counts agreeing for all small radii). -/
theorem hasDegree_iff_of_mem_interiorPts {v : ℂ} (hv : v ∈ F.interiorPts) (n : ℕ) : F.HasDegree v n ↔ n = 1 := by
  sorry

end ArcMap

end HadwigerNelson.Plane
