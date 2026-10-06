import Proofs.HadwigerNelson.Plane.ValidMap.OpenMove
import Proofs.HadwigerNelson.Plane.ValidMap.Pushforward

/-!
# Horn counts where a collar bend needs them (FS131-KA1's skeleton; both collar bends)

The horn count is metric (`HasHornCount` counts the sectors that are `hornSet`s), so a homeomorphism does not carry it; a collar bend's
horn clause (`CollarFit.map_hornCount_le`, and the away bend's, `plans/FS131-bendaway-kernel-plan.md` § 3, lane H) is read by the place
of the point:

* where two maps agree near the point, the counts agree (`hasHornCount_iff_of_agree`, the ball form of `Procedure`'s
  `hasHornCount_iff_of_agreesOff`, which sits downstream);
* at an interior point the count is `0` (`hasHornCount_zero_of_mem_interiorPts`);
* at a point near which `Γ` lies on two circles that are not tangent there — a point of the lens curve, its corner included — the count
  is `0` (`hasHornCount_zero_of_two_spheres`);
* at an end of the bent arc, the bent map's germs are `F`'s with one germ's curvature moved inside a cusp `F.Γ` misses, so the count is
  kept (`hasHornCount_iff_of_germ_swap`).

`IsSectorChart.hasHornCount` reads the count off any sector chart (through `Near.hasHornCount_chart`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The horn count at any sector chart with a germ** is its number of cusps: the chart extends to near data (`exists_near`'s
construction at the given chart), and `Near.hasHornCount_chart` reads the count. -/
theorem IsSectorChart.hasHornCount {n : ℕ} {G : BranchGerms n} {v : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G v r₀) (hn : 0 < n) :
    F.HasHornCount v {i : Fin n | G.β i = G.nextβ i}.ncard := by
  obtain ⟨s₀, hs₀, hs₀r₀, hdisj, hord⟩ := hC.eventually_ord
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt (hC.subdom (mem_ball_self hC.pos))
  choose col hcol using hC.exists_col
  exact Near.hasHornCount_chart (X := (⟨n, G, r₀, s₀, ρ₀, col, hC, ⟨hs₀, hs₀r₀⟩, hdisj, hord, hG, hcol⟩ : F.Near v)) hn

/-- **Horn counts agree where two maps have the same interior points near the point** (sectors are read off the interior points of
small balls; mirror of `hasDegree_iff_of_agree`). **Open — `sorry`** (plan § 3, child H1; short). Inhabitant of the hypotheses: `F' = F`. -/
theorem hasHornCount_iff_of_agree {F' : ArcMap k} {v : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀)
    (hI : ∀ x ∈ ball v r₀, x ∈ F'.interiorPts ↔ x ∈ F.interiorPts) (j : ℕ) : F'.HasHornCount v j ↔ F.HasHornCount v j := by
  sorry

/-- **An interior point has no horn** (its only sector is the ball, which holds the point; `exists_hasHornCount`'s first case).
**Open — `sorry`** (child H2; short). -/
theorem hasHornCount_zero_of_mem_interiorPts {v : ℂ} (hv : v ∈ F.interiorPts) : F.HasHornCount v 0 := by
  sorry

/-- **No horn where `Γ` lies on two circles that are not tangent at the point** (the same circle twice is allowed): a horn is a sector
between two consecutive germs of one direction (`Near.sector_eq_hornSet_iff`); a germ's branch lies in `Γ`, so on one of the circles
near the point, and is tangent to it there; two germs of one direction on one circle are one germ (`Near.hdisj`), and on two circles
they make the circles tangent. **Open — `sorry`** (child H3). Inhabitant of the hypotheses: a point of a ring arc's interior with
`Γ` free near it (`q = q' = P`, `ρ = ρ' = 1`; `l60Frag`). -/
theorem hasHornCount_zero_of_two_spheres {x q q' : ℂ} {ρ ρ' r : ℝ} (hx : x ∈ F.dom) (hr : 0 < r) (hρ : 0 < ρ) (hρ' : 0 < ρ')
    (hΓ : F.Γ ∩ ball x r ⊆ sphere q ρ ∪ sphere q' ρ')
    (hnt : x ∈ sphere q ρ → x ∈ sphere q' ρ' → (q = q' ∧ ρ = ρ') ∨ ((x - q) * starRingEnd ℂ (x - q')).im ≠ 0) :
    F.HasHornCount x 0 := by
  sorry

/-- **The horn count is kept when one germ's curvature moves inside a cusp `Γ` misses**: near `x`, `Γ_M` is `Γ_F` with the branch of
direction `β₀` and curvature `κ₀` replaced by the branch of the same direction and curvature `κ₀'`, and `Γ_F` has no point on a branch
of that direction with curvature between the two (other than `κ₀`'s own). Route: `F`'s chart at `x` (`localSectors`) has a germ
`(β₀, κ₀)` (its branch lies in `Γ`); the germs with `κ₀'` in its place are sorted (`hbetween`) and are `M`'s chart (`isSectorChart_of`,
`hM`); directions are unchanged, so the cusps `{i | β i = nextβ i}` are the same (`IsSectorChart.hasHornCount`). **Open — `sorry`**
(child H4, the hardest of lane H). Inhabitant of the hypotheses: the toward collar bend at an end of its arc (`collarModel`), with
`β₀ = θ₁ + π/2`, `κ₀ = 1`, `κ₀' = 1/R`. -/
theorem hasHornCount_iff_of_germ_swap {M : ArcMap k} {x : ℂ} {β₀ κ₀ κ₀' r : ℝ} (hx : x ∈ F.dom) (hdom : M.dom = F.dom)
    (hr : 0 < r) (hκ : |κ₀| * r < 2) (hκ' : |κ₀'| * r < 2) (hF : branchPt x β₀ κ₀ '' Ioo 0 r ⊆ F.Γ)
    (hM : (M.Γ ∩ ball x r) \ {x} =
      ((F.Γ ∩ ball x r) \ {x}) \ (branchPt x β₀ κ₀ '' Ioo 0 r) ∪ branchPt x β₀ κ₀' '' Ioo 0 r)
    (hbetween : ∀ κ, min κ₀ κ₀' ≤ κ → κ ≤ max κ₀ κ₀' → κ ≠ κ₀ → ∀ s ∈ Ioo 0 r, branchPt x β₀ κ s ∉ F.Γ) (j : ℕ) :
    M.HasHornCount x j ↔ F.HasHornCount x j := by
  sorry

end ArcMap

end HadwigerNelson.Plane
