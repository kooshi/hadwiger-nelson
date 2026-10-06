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
  intro x hx hxA
  have hxd : h.symm x ∈ F.dom := by
    rw [← hdom] at hx
    obtain ⟨z, hz, rfl⟩ := hx
    rwa [h.symm_apply_apply]
  have hxΓ : h.symm x ∉ ⋃ a ∈ F.arcs, a.carrier := by
    intro hm
    have : x ∈ h '' F.Γ := ⟨h.symm x, ⟨hxd, hm⟩, h.apply_symm_apply x⟩
    rw [← hΓ] at this
    exact hxA this.2
  exact (h.symm.continuous.tendsto x).eventually (F.locallyConstant _ hxd hxΓ)

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
  have h1 : (F.pushforward h hdom A' hnd hlf hΓ).interiorPts = F.dom \ (F.dom ∩ ⋃ a ∈ A', a.carrier) := by
    show F.dom \ ⋃ a ∈ A', a.carrier = _
    rw [sdiff_self_inter]
  have h2 : F.interiorPts = F.dom \ F.Γ := by
    show F.dom \ ⋃ a ∈ F.arcs, a.carrier = F.dom \ (F.dom ∩ ⋃ a ∈ F.arcs, a.carrier)
    rw [sdiff_self_inter]
  rw [h1, h2, image_sdiff h.injective, hdom, hΓ]

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
  show (F.pushforward h hdom A' hnd hlf hΓ).interiorPts ∩ (F.col ∘ h.symm) ⁻¹' {j} = h '' (F.interiorPts ∩ F.col ⁻¹' {j})
  have hpre : h '' (F.col ⁻¹' {j}) = (F.col ∘ h.symm) ⁻¹' {j} := by
    ext y
    constructor
    · rintro ⟨x, hx, rfl⟩
      simpa using hx
    · intro hy
      exact ⟨h.symm y, hy, h.apply_symm_apply y⟩
  rw [pushforward_interiorPts, image_inter h.injective, hpre]

/-- **The colours at a point are carried**: `P_cl` of the image at `h z` is `F`'s at `z` (a homeomorphism carries closures). -/
theorem pushforward_coloursAt (z : ℂ) : (F.pushforward h hdom A' hnd hlf hΓ).coloursAt (h z) = F.coloursAt z := by
  ext j
  show h z ∈ closure ((F.pushforward h hdom A' hnd hlf hΓ).region j) ↔ z ∈ closure (F.region j)
  rw [pushforward_region, ← h.image_closure, h.injective.mem_set_image]

end Pushforward

/-! ## Sector counts where they can be computed -/

variable {F}

-- `HasDegree.unique` is `Plane/ValidMap/Basic`'s, beside the definition (moved there by FS131-RP1, inventory ruling 459 (c)).

/-- With one degree known, a degree is that one. -/
theorem HasDegree.iff_eq {v : ℂ} {m : ℕ} (h : F.HasDegree v m) (n : ℕ) : F.HasDegree v n ↔ n = m :=
  ⟨fun h' => h'.unique h, fun e => e ▸ h⟩

/-- **A chart with no germ gives no repeated colour**: the one sector is the ball. -/
theorem IsSectorChart.not_hasRepeatedColour_of_zero {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ}
    (hC : F.IsSectorChart G v r₀) (hn : n = 0) : ¬ F.HasRepeatedColour v := by
  rintro ⟨c, hc⟩
  obtain ⟨r, h2, hr⟩ := (hc.and (Ioc_mem_nhdsGT hC.pos)).exists
  have hsub : F.sectorsOf v r c ⊆ {ball v r} := fun S hS => (hC.isSector_iff_of_zero hn hr).mp hS.1
  have h1 := (Set.encard_le_encard hsub).trans_eq (encard_singleton _)
  have : (2 : ℕ∞) ≤ 1 := h2.trans h1
  exact absurd this (by norm_num)

/-- **A chart's repeated colour is read off its colour word**: with at least one germ and the sectors coloured by `col`, the point
carries a repeated colour exactly when some colour labels at least two sectors (`IsSectorChart.encard_sectorsOf`). -/
theorem IsSectorChart.hasRepeatedColour_iff {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀)
    (hn : 0 < n) {col : Fin n → Fin k} (hcol : ∀ i, ∀ r ∈ Ioc 0 r₀, G.sector v r i ⊆ F.region (col i)) :
    F.HasRepeatedColour v ↔ ∃ c, 2 ≤ {i | col i = c}.encard := by
  have hcount : ∀ c, ∀ᶠ r in 𝓝[>] (0 : ℝ), (F.sectorsOf v r c).encard = {i | col i = c}.encard :=
    fun c => Filter.eventually_of_mem (Ioc_mem_nhdsGT hC.pos) fun r hr => hC.encard_sectorsOf hn hr (fun i => hcol i r hr) c
  refine exists_congr fun c => ⟨fun h => ?_, fun h => (hcount c).mono fun r hr => by rw [hr]; exact h⟩
  obtain ⟨r, h1, h2⟩ := (h.and (hcount c)).exists
  rw [h2] at h1
  exact h1

/-- **Two maps agreeing near a point have the same sectors there**: if on a ball about `v` the two maps have the same interior points and
the same colours on them, then for every smaller radius their sectors coincide, so their degrees and repeated colours at `v` agree.
Route: `IsSector v r S` reads only `interiorPts ∩ ball v r` and the colour on it. -/
theorem hasDegree_iff_of_agree {F' : ArcMap k} {v : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀)
    (hI : ∀ x ∈ ball v r₀, x ∈ F'.interiorPts ↔ x ∈ F.interiorPts)
    (hc : ∀ x ∈ ball v r₀, x ∈ F.interiorPts → F'.col x = F.col x) :
    (∀ n, F'.HasDegree v n ↔ F.HasDegree v n) ∧ (F'.HasRepeatedColour v ↔ F.HasRepeatedColour v) := by
  have hU : ∀ r ∈ Ioc 0 r₀, F'.interiorPts ∩ ball v r = F.interiorPts ∩ ball v r := by
    intro r hr
    ext x
    exact ⟨fun ⟨h1, h2⟩ => ⟨(hI x (ball_subset_ball hr.2 h2)).mp h1, h2⟩,
      fun ⟨h1, h2⟩ => ⟨(hI x (ball_subset_ball hr.2 h2)).mpr h1, h2⟩⟩
  have hS : ∀ r ∈ Ioc 0 r₀, ∀ S, F'.IsSector v r S ↔ F.IsSector v r S := by
    intro r hr S
    simp only [IsSector, hU r hr]
  have hSc : ∀ r ∈ Ioc 0 r₀, ∀ c, F'.sectorsOf v r c = F.sectorsOf v r c := by
    intro r hr c
    ext S
    simp only [sectorsOf, mem_setOf_eq, hS r hr S]
    refine and_congr_right fun hSF => ?_
    obtain ⟨x, -, rfl, -⟩ := hSF
    have hsub : connectedComponentIn (F.interiorPts ∩ ball v r) x ⊆ F.interiorPts ∩ ball v r :=
      connectedComponentIn_subset _ _
    have hcol : ∀ y ∈ connectedComponentIn (F.interiorPts ∩ ball v r) x, F'.col y = F.col y :=
      fun y hy => hc y (ball_subset_ball hr.2 (hsub hy).2) (hsub hy).1
    constructor
    · intro h y hy
      have := h hy
      simp only [mem_preimage, mem_singleton_iff] at this ⊢
      rw [← hcol y hy]; exact this
    · intro h y hy
      have := h hy
      simp only [mem_preimage, mem_singleton_iff] at this ⊢
      rw [hcol y hy]; exact this
  have hev : ∀ᶠ r in 𝓝[>] (0 : ℝ), r ∈ Ioc 0 r₀ := Ioc_mem_nhdsGT hr₀
  refine ⟨fun n => Filter.eventually_congr (hev.mono fun r hr => ?_), exists_congr fun c =>
    Filter.eventually_congr (hev.mono fun r hr => ?_)⟩
  · rw [show {S | F'.IsSector v r S} = {S | F.IsSector v r S} from Set.ext (hS r hr)]
  · rw [hSc r hr c]

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
  refine ⟨fun m => by rw [hC'.hasDegree.iff_eq, hC.hasDegree.iff_eq], ?_⟩
  rcases Nat.eq_zero_or_pos n with hn | hn
  · exact iff_of_false (hC'.not_hasRepeatedColour_of_zero hn) (hC.not_hasRepeatedColour_of_zero hn)
  · rw [hC'.hasRepeatedColour_iff hn hcol', hC.hasRepeatedColour_iff hn hcol]

/-- **At an interior point the degree is `1`** (the chart of `localSectors` has no germ: `IsSectorChart.hasDegree`, `max 0 1 = 1`; and
a degree is unique, the counts agreeing for all small radii). -/
theorem hasDegree_iff_of_mem_interiorPts {v : ℂ} (hv : v ∈ F.interiorPts) (n : ℕ) : F.HasDegree v n ↔ n = 1 := by
  obtain ⟨r₀, m, G, hC⟩ := localSectors F hv.1
  have hm : m = 0 := by
    by_contra hm
    exact hv.2 (hC.mem_Γ.mpr (Nat.pos_of_ne_zero hm)).2
  have hd := hC.hasDegree
  rw [hm] at hd
  exact hd.iff_eq n

/-! ## The two-germ chart at a point of one circle -/

/-- **The circle's curve**: the curve through `v` with data `(1, q − v)` is the circle about `q` through `v`. -/
theorem curveAt_one_sub_eq_sphere (v q : ℂ) : curveAt v 1 (q - v) = sphere q ‖q - v‖ := by
  ext y
  have h : Complex.normSq (y - q) =
      Complex.normSq (y - v) + Complex.normSq (q - v) - 2 * ((y - v) * (starRingEnd ℂ) (q - v)).re := by
    rw [show y - q = (y - v) - (q - v) by ring, Complex.normSq_sub]
  simp only [curveAt, mem_setOf_eq, one_mul, mem_sphere_iff_norm]
  rw [← sq_eq_sq₀ (norm_nonneg _) (norm_nonneg _), ← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq, h]
  constructor <;> intro h' <;> linarith

/-- A branch point reads its direction modulo `2π`. -/
theorem branchPt_congr {v : ℂ} {β β' κ : ℝ} (h : e β = e β') (s : ℝ) : branchPt v β κ s = branchPt v β' κ s := by
  rw [branchPt, branchPt, e_add, e_add, h]

/-- **The two germs of a circle** of radius `ρ` at its point `q + ρ e(φ)`: clockwise `(φ − π/2, −1/ρ)`, then counter-clockwise
`(φ + π/2, 1/ρ)`. Sector `0` (between them, through the direction `φ`) is outside the circle, sector `1` (through `φ + π`) inside. -/
noncomputable def circleGerms (φ ρ : ℝ) : BranchGerms 2 := ⟨![φ - π / 2, φ + π / 2], ![-(1 / ρ), 1 / ρ]⟩

/-- Spec: the counter-clockwise germ. -/
example (φ ρ : ℝ) : (circleGerms φ ρ).β 1 = φ + π / 2 ∧ (circleGerms φ ρ).κ 1 = 1 / ρ := ⟨rfl, rfl⟩

theorem circleGerms_nextβ_zero (φ ρ : ℝ) : (circleGerms φ ρ).nextβ 0 = φ + π / 2 := by
  simp [BranchGerms.nextβ, circleGerms]

theorem circleGerms_nextβ_one (φ ρ : ℝ) : (circleGerms φ ρ).nextβ 1 = φ - π / 2 + 2 * π := by
  simp [BranchGerms.nextβ, circleGerms]

theorem circleGerms_nextκ_zero (φ ρ : ℝ) : (circleGerms φ ρ).nextκ 0 = 1 / ρ := by
  simp [BranchGerms.nextκ, circleGerms]

theorem circleGerms_nextκ_one (φ ρ : ℝ) : (circleGerms φ ρ).nextκ 1 = -(1 / ρ) := by
  simp [BranchGerms.nextκ, circleGerms]

/-- The outward ray lies in sector `0`. -/
theorem circleGerms_mem_sector_zero (v : ℂ) {φ ρ r s : ℝ} (hρ : 0 < ρ) (hs : s ∈ Ioo 0 r) (hs2 : s < 2 * ρ) :
    v + (s : ℂ) * e φ ∈ (circleGerms φ ρ).sector v r 0 := by
  have hx0 : 0 ≤ 1 / ρ * s / 2 := by have := hs.1; positivity
  have hx1 : 1 / ρ * s / 2 < 1 := by rw [div_mul_eq_mul_div, one_mul, div_div, div_lt_one (by positivity)]; linarith
  refine ⟨s, hs, φ, ⟨?_, ?_⟩, rfl⟩
  · show φ - π / 2 + Real.arcsin (-(1 / ρ) * s / 2) < φ
    have := Real.arcsin_lt_pi_div_two.mpr (show -(1 / ρ) * s / 2 < 1 by linarith)
    linarith
  · rw [circleGerms_nextβ_zero, circleGerms_nextκ_zero]
    have := Real.neg_pi_div_two_lt_arcsin.mpr (show -1 < 1 / ρ * s / 2 by linarith)
    linarith

/-- The inward ray lies in sector `1`. -/
theorem circleGerms_mem_sector_one (v : ℂ) {φ ρ r s : ℝ} (hρ : 0 < ρ) (hs : s ∈ Ioo 0 r) (hs2 : s < 2 * ρ) :
    v + (s : ℂ) * e (φ + π) ∈ (circleGerms φ ρ).sector v r 1 := by
  have hx0 : 0 ≤ 1 / ρ * s / 2 := by have := hs.1; positivity
  have hx1 : 1 / ρ * s / 2 < 1 := by rw [div_mul_eq_mul_div, one_mul, div_div, div_lt_one (by positivity)]; linarith
  refine ⟨s, hs, φ + π, ⟨?_, ?_⟩, rfl⟩
  · show φ + π / 2 + Real.arcsin (1 / ρ * s / 2) < φ + π
    have := Real.arcsin_lt_pi_div_two.mpr hx1
    linarith
  · rw [circleGerms_nextβ_one, circleGerms_nextκ_one]
    have := Real.neg_pi_div_two_lt_arcsin.mpr (show -1 < -(1 / ρ) * s / 2 by linarith)
    linarith

/-- **The two-germ chart at a point of one circle**: if near `v = q + ρ e(φ)` the arcs of `F` are the circle about `q` of radius `ρ`,
then `circleGerms φ ρ` is a sector chart of `F` at `v` (out to any radius below `2ρ` inside the domain). -/
theorem isSectorChart_circle {v q : ℂ} {ρ φ r₀ : ℝ} (hρ : 0 < ρ) (hv : v = q + (ρ : ℂ) * e φ) (hr₀ : 0 < r₀)
    (hr₀ρ : r₀ < 2 * ρ) (hdom : ball v r₀ ⊆ F.dom) (hΓ : F.Γ ∩ ball v r₀ = sphere q ρ ∩ ball v r₀) :
    F.IsSectorChart (circleGerms φ ρ) v r₀ := by
  have hπ := Real.pi_pos
  have hqv : ‖q - v‖ = ρ := by rw [hv, show q - (q + (ρ : ℂ) * e φ) = -((ρ : ℂ) * e φ) by ring, norm_neg, norm_mul_e hρ.le]
  have hb : q - v ≠ 0 := by rw [← norm_ne_zero_iff, hqv]; exact hρ.ne'
  have hvs : v ∈ sphere q ρ := by rw [mem_sphere_iff_norm, hv, add_sub_cancel_left, norm_mul_e hρ.le]
  have hvΓ : v ∈ F.Γ := by
    have : v ∈ sphere q ρ ∩ ball v r₀ := ⟨hvs, mem_ball_self hr₀⟩
    rw [← hΓ] at this
    exact this.1
  -- the direction from `v` to the centre
  have harg : e (arg (q - v)) = e (φ + π) := by
    have h1 := eq_polar_arg (q - v)
    rw [hqv] at h1
    have h2 : q - v = (ρ : ℂ) * e (φ + π) := by rw [hv, e_add_pi']; ring
    have hρ0 : (ρ : ℂ) ≠ 0 := by exact_mod_cast hρ.ne'
    exact mul_left_cancel₀ hρ0 (h1.symm.trans h2)
  have hcg1 : ∀ s, branchPt v (curveGerm 1 (q - v) 1).1 (curveGerm 1 (q - v) 1).2 s =
      branchPt v (φ + π / 2) (1 / ρ) s := by
    intro s
    have hκ : (curveGerm 1 (q - v) 1).2 = 1 / ρ := by
      show 1 * 1 / ‖q - v‖ = 1 / ρ
      rw [hqv]; ring
    rw [hκ]
    refine branchPt_congr ?_ s
    simp only [curveGerm]
    rw [← add_zero (toIcoMod _ _ _), e_toIcoMod_add, add_zero, show arg (q - v) - 1 * (π / 2) = arg (q - v) + -(π / 2) by ring,
      e_add, harg, ← e_add]
    congr 1; ring
  have hcg0 : ∀ s, branchPt v (curveGerm 1 (q - v) (-1)).1 (curveGerm 1 (q - v) (-1)).2 s =
      branchPt v (φ - π / 2) (-(1 / ρ)) s := by
    intro s
    have hκ : (curveGerm 1 (q - v) (-1)).2 = -(1 / ρ) := by
      show -1 * 1 / ‖q - v‖ = -(1 / ρ)
      rw [hqv]; ring
    rw [hκ]
    refine branchPt_congr ?_ s
    simp only [curveGerm]
    rw [← add_zero (toIcoMod _ _ _), e_toIcoMod_add, add_zero, show arg (q - v) - -1 * (π / 2) = arg (q - v) + π / 2 by ring,
      e_add, harg, ← e_add, show φ + π + π / 2 = φ - π / 2 + 2 * π by ring, e_add_two_pi]
  have hcurv : ∀ s, 0 ≤ s → s < 2 * ρ → (1 : ℝ) * s ≤ 2 * ‖q - v‖ := fun s _ hs => by rw [hqv]; linarith
  refine F.isSectorChart_of _ hr₀ hdom ?_ ?_ ⟨fun _ => two_pos, fun _ => hvΓ⟩ ?_ ?_
  · -- sorted
    refine ⟨?_, Fin.forall_fin_two.mpr ⟨Or.inl ?_, Or.inl ?_⟩⟩
    · intro i j hij
      have hij' : i.val < j.val := hij
      have hi : i = 0 := Fin.ext (by have := j.isLt; show i.val = 0; omega)
      have hj : j = 1 := Fin.ext (by have := j.isLt; show j.val = 1; omega)
      subst hi hj
      left; show φ - π / 2 < φ + π / 2; linarith
    · rw [circleGerms_nextβ_zero]; show φ - π / 2 < φ + π / 2; linarith
    · rw [circleGerms_nextβ_one]; show φ + π / 2 < φ - π / 2 + 2 * π; linarith
  · -- each branch a graph over the radius
    have h1 : |1 / ρ| * r₀ < 2 := by
      rw [abs_of_pos (by positivity), div_mul_eq_mul_div, one_mul, div_lt_iff₀ hρ]; linarith
    refine Fin.forall_fin_two.mpr ⟨?_, h1⟩
    show |-(1 / ρ)| * r₀ < 2
    rwa [abs_neg]
  · -- the branches
    rw [hΓ]
    ext z
    simp only [Set.mem_sdiff, mem_inter_iff, mem_singleton_iff, mem_iUnion, mem_image]
    constructor
    · rintro ⟨⟨hzs, hzb⟩, hzv⟩
      have hzc : z ∈ curveAt v 1 (q - v) := by rw [curveAt_one_sub_eq_sphere, hqv]; exact hzs
      have hzr : ‖z - v‖ < r₀ := by rwa [mem_ball, dist_eq_norm] at hzb
      have hzpos : 0 < ‖z - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzv)
      obtain ⟨σ, hσ, hz⟩ := exists_eq_branchPt_curveGerm zero_le_one hb hzc hzv (by rw [one_mul, hqv]; linarith)
      rcases hσ with rfl | rfl
      · refine ⟨1, ‖z - v‖, ⟨hzpos, hzr⟩, ?_⟩
        show branchPt v (φ + π / 2) (1 / ρ) ‖z - v‖ = z
        rw [← hcg1]; exact hz.symm
      · refine ⟨0, ‖z - v‖, ⟨hzpos, hzr⟩, ?_⟩
        show branchPt v (φ - π / 2) (-(1 / ρ)) ‖z - v‖ = z
        rw [← hcg0]; exact hz.symm
    · rintro ⟨i, s, hs, rfl⟩
      have hs2 : s < 2 * ρ := hs.2.trans hr₀ρ
      have hn := norm_branchPt_sub v ((circleGerms φ ρ).β i) ((circleGerms φ ρ).κ i) hs.1.le
      refine ⟨⟨?_, by rw [mem_ball, dist_eq_norm, hn]; exact hs.2⟩, fun h => by rw [h, sub_self, norm_zero] at hn; linarith [hs.1]⟩
      have hmem : branchPt v ((circleGerms φ ρ).β i) ((circleGerms φ ρ).κ i) s ∈ curveAt v 1 (q - v) := by
        fin_cases i
        · have := branchPt_curveGerm_mem (v := v) zero_le_one hb (Or.inr rfl) hs.1.le (hcurv s hs.1.le hs2)
          rw [hcg0] at this; exact this
        · have := branchPt_curveGerm_mem (v := v) zero_le_one hb (Or.inl rfl) hs.1.le (hcurv s hs.1.le hs2)
          rw [hcg1] at this; exact this
      rw [curveAt_one_sub_eq_sphere, hqv] at hmem
      exact hmem
  · -- the two germs never meet
    have hdir : ∀ s ∈ Ioo 0 r₀, e ((circleGerms φ ρ).dir 0 s) ≠ e ((circleGerms φ ρ).dir 1 s) := by
      intro s hs heq
      have hx0 : 0 < 1 / ρ * s / 2 := by have := hs.1; positivity
      have hx1 : 1 / ρ * s / 2 < 1 := by
        rw [div_mul_eq_mul_div, one_mul, div_div, div_lt_one (by positivity)]; linarith [hs.2]
      have ha0 := Real.arcsin_pos.mpr hx0
      have ha1 := Real.arcsin_lt_pi_div_two.mpr hx1
      obtain ⟨m, hm⟩ := e_eq_e_iff.mp heq
      simp only [BranchGerms.dir, germDir, circleGerms, Matrix.cons_val_zero, Matrix.cons_val_one] at hm
      rw [show -(1 / ρ) * s / 2 = -(1 / ρ * s / 2) by ring, Real.arcsin_neg] at hm
      have hlo : (m : ℝ) * (2 * π) < 0 := by nlinarith
      have hhi : -(2 * π) < (m : ℝ) * (2 * π) := by nlinarith
      have hm1 : (m : ℝ) < 0 := by nlinarith
      have hm2 : (-1 : ℝ) < m := by nlinarith
      have : m < 0 := by exact_mod_cast hm1
      have : -1 < m := by exact_mod_cast hm2
      omega
    intro i j hij s hs
    fin_cases i <;> fin_cases j
    · exact absurd rfl hij
    · exact hdir s hs
    · exact fun h => hdir s hs h.symm
    · exact absurd rfl hij

/-- **A colour count on two letters**: some colour labels both sectors of a two-letter word exactly when the two letters agree. -/
theorem exists_two_le_encard_fin_two_iff {α : Type*} (col : Fin 2 → α) :
    (∃ c, 2 ≤ {i | col i = c}.encard) ↔ col 0 = col 1 := by
  constructor
  · rintro ⟨c, hc⟩
    by_contra hne
    have h1 : {i | col i = c}.encard ≤ 1 := by
      rw [Set.encard_le_one_iff]
      intro a b ha hb
      simp only [mem_setOf_eq] at ha hb
      fin_cases a <;> fin_cases b <;> simp_all
    have : (2 : ℕ∞) ≤ 1 := hc.trans h1
    exact absurd this (by norm_num)
  · intro h
    refine ⟨col 0, ?_⟩
    have : {i | col i = col 0} = univ := by
      ext i; fin_cases i <;> simp [h]
    rw [this, encard_univ]
    simp

/-- **The degree at a point of one circle** is `2`, and a colour repeats there exactly when the colour inside the circle is the
colour outside: the two-germ chart (`isSectorChart_circle`), its inner sector coloured by the colour whose class reaches `v` from inside,
its outer sector by the one from outside. -/
theorem degree_of_circle {v q : ℂ} {ρ φ r₀ : ℝ} (hρ : 0 < ρ) (hv : v = q + (ρ : ℂ) * e φ) (hr₀ : 0 < r₀)
    (hr₀ρ : r₀ < 2 * ρ) (hdom : ball v r₀ ⊆ F.dom) (hΓ : F.Γ ∩ ball v r₀ = sphere q ρ ∩ ball v r₀) {cin cout : Fin k}
    (hin : ∀ d, v ∈ closure (F.region d ∩ ball q ρ) → d = cin)
    (hout : ∀ d, v ∈ closure (F.region d \ closedBall q ρ) → d = cout) :
    (∀ n, F.HasDegree v n ↔ n = 2) ∧ (F.HasRepeatedColour v ↔ cin = cout) := by
  have hC := isSectorChart_circle hρ hv hr₀ hr₀ρ hdom hΓ
  have hr₀' : r₀ ∈ Ioc 0 r₀ := ⟨hr₀, le_rfl⟩
  choose col hcol using hC.exists_col
  -- points of a ray from `v` at small distances
  have hnear : ∀ (ψ : ℝ) (S : Set ℂ), (∀ s ∈ Ioo 0 r₀, v + (s : ℂ) * e ψ ∈ S) → v ∈ closure S := by
    intro ψ S hS
    rw [Metric.mem_closure_iff]
    intro ε hε
    set m : ℝ := min (ε / 2) (r₀ / 2) with hmdef
    have hm : m ∈ Ioo 0 r₀ := ⟨lt_min (by linarith) (by linarith), by
      have := min_le_right (ε / 2) (r₀ / 2); linarith⟩
    refine ⟨_, hS m hm, ?_⟩
    rw [dist_eq_norm, show v - (v + (m : ℂ) * e ψ) = -((m : ℂ) * e ψ) by ring, norm_neg, norm_mul_e hm.1.le]
    have := min_le_left (ε / 2) (r₀ / 2); linarith
  have hc1 : col 1 = cin := by
    refine hin _ (hnear (φ + π) _ fun s hs => ⟨hcol 1 r₀ hr₀' (circleGerms_mem_sector_one v hρ hs (hs.2.trans hr₀ρ)), ?_⟩)
    rw [mem_ball, dist_eq_norm, hv, show q + (ρ : ℂ) * e φ + (s : ℂ) * e (φ + π) - q = ((ρ - s : ℝ) : ℂ) * e φ by
      rw [e_add_pi']; push_cast; ring, norm_mul, Complex.norm_real, norm_e, mul_one, Real.norm_eq_abs, abs_lt]
    constructor <;> linarith [hs.1, hs.2, hr₀ρ]
  have hc0 : col 0 = cout := by
    refine hout _ (hnear φ _ fun s hs => ⟨hcol 0 r₀ hr₀' (circleGerms_mem_sector_zero v hρ hs (hs.2.trans hr₀ρ)), ?_⟩)
    rw [mem_closedBall, dist_eq_norm, hv, show q + (ρ : ℂ) * e φ + (s : ℂ) * e φ - q = ((ρ + s : ℝ) : ℂ) * e φ by
      push_cast; ring, norm_mul, Complex.norm_real, norm_e, mul_one, Real.norm_eq_abs, abs_of_pos (by linarith [hs.1])]
    linarith [hs.1]
  refine ⟨fun n => hC.hasDegree.iff_eq n, ?_⟩
  rw [hC.hasRepeatedColour_iff two_pos hcol, exists_two_le_encard_fin_two_iff, hc0, hc1, eq_comm]

/-- **Points of a unit circle near an interior point of an arc of it lie on the open arc** (the local angle about the centre is
continuous at the point: `eq_polar_local`, `continuousAt_arg_div`). -/
theorem exists_sphere_inter_ball_subset_openArc {p : ℂ} {θ₁ θ₂ θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    ∃ δ > 0, sphere p 1 ∩ ball (ringPt p θ) δ ⊆ ringPt p '' Ioo θ₁ θ₂ := by
  set m := min (θ - θ₁) (θ₂ - θ) with hm
  have hm0 : 0 < m := lt_min (by linarith [hθ.1]) (by linarith [hθ.2])
  have hne : ringPt p θ ≠ p := by
    intro h
    have := dist_ringPt p θ
    rw [h, dist_self] at this
    norm_num at this
  have hc := continuousAt_arg_div (v := p) hne
  rw [Metric.continuousAt_iff] at hc
  obtain ⟨δ, hδ, hball⟩ := hc m hm0
  refine ⟨δ, hδ, fun z ⟨hz, hzd⟩ => ?_⟩
  have h1 := hball hzd
  rw [arg_div_self hne, Real.dist_eq, sub_zero] at h1
  have hpol := eq_polar_local (v := p) (z₀ := ringPt p θ) (s₀ := 1) (φ₀ := θ) one_pos (by simp [ringPt]) z
  have hz1 : ‖z - p‖ = 1 := by rwa [mem_sphere_iff_norm] at hz
  rw [hz1, Complex.ofReal_one, one_mul] at hpol
  refine ⟨θ + arg ((z - p) / (ringPt p θ - p)), ⟨?_, ?_⟩, ?_⟩
  · linarith [(abs_lt.mp h1).1, min_le_left (θ - θ₁) (θ₂ - θ)]
  · linarith [(abs_lt.mp h1).2, min_le_right (θ - θ₁) (θ₂ - θ)]
  · conv_rhs => rw [hpol]
    rfl

/-! ## Germ counts are carried by a homeomorphism -/

/-- A preconnected set inside a union of pairwise disjoint open sets lies in one of them. -/
theorem exists_subset_of_isPreconnected_iUnion {ι : Type*} {S : Set ℂ} {T : ι → Set ℂ} (hS : IsPreconnected S)
    (hne : S.Nonempty) (hT : ∀ j, IsOpen (T j)) (hd : ∀ i j, i ≠ j → Disjoint (T i) (T j)) (hsub : S ⊆ ⋃ j, T j) :
    ∃ j, S ⊆ T j := by
  obtain ⟨x, hx⟩ := hne
  obtain ⟨j, hj⟩ := mem_iUnion.mp (hsub hx)
  refine ⟨j, hS.subset_left_of_subset_union (hT j) (isOpen_iUnion fun i => isOpen_iUnion fun _ : i ≠ j => hT i) ?_ ?_ ⟨x, hx, hj⟩⟩
  · rw [disjoint_iUnion_right]
    intro i
    rw [disjoint_iUnion_right]
    intro hij
    exact hd j i (Ne.symm hij)
  · intro y hy
    obtain ⟨i, hi⟩ := mem_iUnion.mp (hsub hy)
    by_cases hij : i = j
    · exact Or.inl (hij ▸ hi)
    · exact Or.inr (mem_iUnion.mpr ⟨i, mem_iUnion.mpr ⟨hij, hi⟩⟩)

/-- **A homeomorphism carrying interior points to interior points sends the sectors of one chart into the sectors of the other,
injectively**: each small sector at `v` goes into one sector at `h v` (a connected set among disjoint open ones), each smaller sector
at `h v` comes back into one sector at `v`, and the second assignment undoes the first, a sector reaching its base point. -/
theorem IsSectorChart.exists_injective_of_homeo {F' : ArcMap k} {n n' : ℕ} {G : BranchGerms n} {G' : BranchGerms n'}
    {v w : ℂ} {r₀ r₀' : ℝ} (hC : F.IsSectorChart G v r₀) (hC' : F'.IsSectorChart G' w r₀') (hn : 0 < n) (hn' : 0 < n')
    (h : ℂ ≃ₜ ℂ) (hw : h v = w) (hI : ∀ z, h z ∈ F'.interiorPts ↔ z ∈ F.interiorPts) :
    ∃ φ : Fin n → Fin n', Function.Injective φ ∧ ∃ r ∈ Ioc 0 r₀, ∀ i, h '' G.sector v r i ⊆ G'.sector w r₀' (φ i) := by
  have hr₀' : r₀' ∈ Ioc 0 r₀' := ⟨hC'.pos, le_rfl⟩
  -- a radius at `v` whose ball goes into the chart's ball at `w`
  obtain ⟨δ, hδ, hδb⟩ := Metric.continuousAt_iff.mp h.continuous.continuousAt r₀' hC'.pos
  set r := min δ r₀ with hrdef
  have hr : r ∈ Ioc 0 r₀ := ⟨lt_min hδ hC.pos, min_le_right _ _⟩
  -- a radius at `w` whose ball comes back into the ball at `v`
  obtain ⟨δ', hδ', hδb'⟩ := Metric.continuousAt_iff.mp h.symm.continuous.continuousAt r hr.1
  set r' := min δ' r₀' with hr'def
  have hr' : r' ∈ Ioc 0 r₀' := ⟨lt_min hδ' hC'.pos, min_le_right _ _⟩
  have hsv : h.symm w = v := by rw [← hw, h.symm_apply_apply]
  have hfwd : ∀ i, ∃ j, h '' G.sector v r i ⊆ G'.sector w r₀' j := by
    intro i
    refine exists_subset_of_isPreconnected_iUnion ((hC.isPreconnected r hr i).image _ h.continuous.continuousOn)
      ((hC.sector_nonempty hr i).image _) (hC'.isOpen r₀' hr₀') (hC'.disjoint r₀' hr₀') ?_
    rintro _ ⟨x, hx, rfl⟩
    rw [← hC'.cover r₀' hr₀' hn']
    refine ⟨?_, (hI x).mpr (hC.sector_subset_interiorPts hn hr i hx)⟩
    rw [mem_ball, ← hw]
    exact hδb (lt_of_lt_of_le (mem_ball.mp (BranchGerms.sector_subset_ball i hx)) (min_le_left _ _))
  have hbwd : ∀ j, ∃ i, h.symm '' G'.sector w r' j ⊆ G.sector v r i := by
    intro j
    refine exists_subset_of_isPreconnected_iUnion ((hC'.isPreconnected r' hr' j).image _ h.symm.continuous.continuousOn)
      ((hC'.sector_nonempty hr' j).image _) (hC.isOpen r hr) (hC.disjoint r hr) ?_
    rintro _ ⟨y, hy, rfl⟩
    rw [← hC.cover r hr hn]
    refine ⟨?_, ?_⟩
    · rw [mem_ball, ← hsv]
      exact hδb' (lt_of_lt_of_le (mem_ball.mp (BranchGerms.sector_subset_ball j hy)) (min_le_left _ _))
    · have := hI (h.symm y)
      rw [h.apply_symm_apply] at this
      exact this.mp (hC'.sector_subset_interiorPts hn' hr' j hy)
  choose φ hφ using hfwd
  choose ψ hψ using hbwd
  have hleft : ∀ i, ψ (φ i) = i := by
    intro i
    -- a point of `h(S_i)` in the small ball at `w`
    have hcl : w ∈ closure (h '' G.sector v r i) := by
      rw [← h.image_closure, ← hw]
      exact mem_image_of_mem _ (hC.mem_closure_sector hr i)
    obtain ⟨y, hyS, hyb⟩ := Metric.mem_closure_iff.mp hcl r' hr'.1
    obtain ⟨x, hx, rfl⟩ := hyS
    have hyI : h x ∈ F'.interiorPts := (hI x).mpr (hC.sector_subset_interiorPts hn hr i hx)
    have hycov : h x ∈ ball w r' ∩ F'.interiorPts := ⟨by rw [mem_ball, dist_comm]; exact hyb, hyI⟩
    rw [hC'.cover r' hr' hn'] at hycov
    obtain ⟨j, hj⟩ := mem_iUnion.mp hycov
    have hjφ : j = φ i := by
      by_contra hne
      exact disjoint_left.mp (hC'.disjoint r₀' hr₀' j (φ i) hne) (BranchGerms.sector_mono hr'.2 j hj)
        (hφ i (mem_image_of_mem _ hx))
    subst hjφ
    have hx' : x ∈ G.sector v r (ψ (φ i)) := by
      have := hψ (φ i) (mem_image_of_mem _ hj)
      rwa [h.symm_apply_apply] at this
    by_contra hne
    exact disjoint_left.mp (hC.disjoint r hr _ _ hne) hx' hx
  exact ⟨φ, Function.LeftInverse.injective hleft, r, hr, hφ⟩

/-- **Degrees and repeated colours are carried by a homeomorphism** that carries interior points to interior points with their
colours: at a point of the domain the two maps have sector charts (`localSectors`), whose sectors correspond one to one
(`IsSectorChart.exists_injective_of_homeo`, both ways), colour by colour. Sector counts read balls, which a homeomorphism does not
carry; the number of germs it does. -/
theorem hasDegree_iff_of_homeo {F' : ArcMap k} (h : ℂ ≃ₜ ℂ) {v : ℂ} (hv : v ∈ F.dom) (hv' : h v ∈ F'.dom)
    (hI : ∀ z, h z ∈ F'.interiorPts ↔ z ∈ F.interiorPts) (hc : ∀ z ∈ F.interiorPts, F'.col (h z) = F.col z) :
    (∀ m, F'.HasDegree (h v) m ↔ F.HasDegree v m) ∧ (F'.HasRepeatedColour (h v) ↔ F.HasRepeatedColour v) := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hv
  obtain ⟨r₀', n', G', hC'⟩ := localSectors F' hv'
  have hΓ : ∀ {E : ArcMap k} {x : ℂ}, x ∈ E.dom → (x ∈ E.Γ ↔ x ∉ E.interiorPts) := fun {E x} hx =>
    ⟨fun hΓ hi => hi.2 hΓ.2, fun hi => ⟨hx, by_contra fun hU => hi ⟨hx, hU⟩⟩⟩
  have hnn : 0 < n ↔ 0 < n' := by
    rw [← hC.mem_Γ, ← hC'.mem_Γ, hΓ hv, hΓ hv', hI]
  rcases Nat.eq_zero_or_pos n with hn | hn
  · have hn' : n' = 0 := by
      by_contra h0
      exact absurd (hnn.mpr (Nat.pos_of_ne_zero h0)) (by omega)
    refine ⟨fun m => ?_, iff_of_false (hC'.not_hasRepeatedColour_of_zero hn') (hC.not_hasRepeatedColour_of_zero hn)⟩
    rw [hC'.hasDegree.iff_eq, hC.hasDegree.iff_eq, hn, hn']
  · have hn' : 0 < n' := hnn.mp hn
    obtain ⟨φ, hφ, r, hr, hsub⟩ := hC.exists_injective_of_homeo hC' hn hn' h rfl hI
    obtain ⟨φ', hφ', -⟩ := hC'.exists_injective_of_homeo hC hn' hn h.symm (h.symm_apply_apply v) (fun z => by
      have := hI (h.symm z)
      rw [h.apply_symm_apply] at this
      exact this.symm)
    have h1 : n ≤ n' := by simpa using Fintype.card_le_of_injective φ hφ
    have h2 : n' ≤ n := by simpa using Fintype.card_le_of_injective φ' hφ'
    obtain rfl : n = n' := le_antisymm h1 h2
    have hbij : Function.Bijective φ := Finite.injective_iff_bijective.mp hφ
    choose col hcol using hC.exists_col
    choose col' hcol' using hC'.exists_col
    have hcolφ : ∀ i, col' (φ i) = col i := by
      intro i
      obtain ⟨x, hx⟩ := hC.sector_nonempty hr i
      have h1 : F.col x = col i := (hcol i r hr hx).2
      have h2 : F'.col (h x) = col' (φ i) := (hcol' (φ i) r₀' ⟨hC'.pos, le_rfl⟩ (hsub i (mem_image_of_mem _ hx))).2
      rw [← h2, hc x (hC.sector_subset_interiorPts hn hr i hx), h1]
    refine ⟨fun m => by rw [hC'.hasDegree.iff_eq, hC.hasDegree.iff_eq], ?_⟩
    rw [hC'.hasRepeatedColour_iff hn' hcol', hC.hasRepeatedColour_iff hn hcol]
    refine exists_congr fun d => ?_
    have : {i | col i = d} = φ ⁻¹' {j | col' j = d} := by
      ext i
      simp only [mem_setOf_eq, mem_preimage, hcolφ]
    rw [this, Set.encard_preimage_of_bijective hbij]

/-- **A pushforward carries degrees and repeated colours** at every point of the domain (`hasDegree_iff_of_homeo` with
`pushforward_mem_interiorPts_iff`, `pushforward_col_apply`). -/
theorem pushforward_hasDegree {h : ℂ ≃ₜ ℂ} {hdom : h '' F.dom = F.dom} {A' : Set Arc} {hnd : ∀ a ∈ A', a.Nondegenerate}
    {hlf : ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {a | a ∈ A' ∧ (a.carrier ∩ t).Nonempty}.Finite}
    {hΓ : F.dom ∩ ⋃ a ∈ A', a.carrier = h '' F.Γ} {z : ℂ} (hz : z ∈ F.dom) :
    (∀ m, (F.pushforward h hdom A' hnd hlf hΓ).HasDegree (h z) m ↔ F.HasDegree z m) ∧
      ((F.pushforward h hdom A' hnd hlf hΓ).HasRepeatedColour (h z) ↔ F.HasRepeatedColour z) := by
  have hz' : h z ∈ (F.pushforward h hdom A' hnd hlf hΓ).dom := by
    show h z ∈ F.dom
    rw [← hdom]
    exact mem_image_of_mem h hz
  exact hasDegree_iff_of_homeo h hz hz' (fun x => pushforward_mem_interiorPts_iff x) (fun x _ => pushforward_col_apply x)

end ArcMap

end HadwigerNelson.Plane
