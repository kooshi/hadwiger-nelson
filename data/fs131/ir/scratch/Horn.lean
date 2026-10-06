import Proofs.HadwigerNelson.Plane.ValidMap.FlankUA

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **FS131-E6-CONE**: a horn of a colour whose allowed cone has empty interior has bounds in `[−1, 1]` (`woodallCone`: every sector of
the colour is then a horn set along one axis with such bounds, and a horn's bounds are determined by its set, `hornSet_curv_eq`). So a
horn with a bound outside `[−1, 1]` — every horn shaveable only along a unit circle strictly inside it — has `int D_c(v) ≠ ∅`.
`horn_bounds_of_noMerge` is the case where the empty interior comes from two sectors and no MERGE. Inhabitant of the hypotheses:
`bowtie` at `0` (`bowtie_isHorn`, with `bowtie_not_merge_zero` giving the empty interior for its two-sector colour). -/
theorem horn_bounds_of_interior_empty (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {α κ₁ κ₂ : ℝ}
    (hH : F.IsHorn v α κ₁ κ₂ c) (hD : interior (F.allowedCone v c) = ∅) : -1 ≤ κ₁ ∧ κ₂ ≤ 1 := by
  have hcv : c ∈ F.coloursAt v := mem_closure_of_mem_coneAt hH.mem_coneAt_region
  obtain ⟨α', -, -, hev⟩ := woodallCone hF hv hcv hD
  obtain ⟨r, ⟨hr1, hr2⟩, hr0⟩ := ((hev.and hH.2).and self_mem_nhdsWithin).exists
  obtain ⟨β, -, κ, κ', hκ1, hκ12, hκ2, hSeq⟩ := hr1 _ hr2
  have hr0' : (0 : ℝ) < r := hr0
  have heq : e α = e β := by
    have := mem_coneAt_hornSet v α hH.1 hr0'
    rw [hSeq] at this
    exact e_eq_of_mem_coneAt_hornSet this
  rw [hornSet_congr heq.symm κ κ' r] at hSeq
  obtain ⟨h1, h2⟩ := hornSet_curv_eq hH.1 hκ12 hr0' hSeq
  exact ⟨h1 ▸ hκ1, h2 ▸ hκ2⟩

/-- `horn_bounds_of_noMerge`, read off E6-CONE (a check that the new lemma carries the old one). -/
example (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) (hM : ¬ F.MergeAvailable v) {c : Fin k} {m : ℕ}
    (hm : 2 ≤ m) (hc : F.HasSectors v c m) {α κ₁ κ₂ : ℝ} (hH : F.IsHorn v α κ₁ κ₂ c) : -1 ≤ κ₁ ∧ κ₂ ≤ 1 :=
  horn_bounds_of_interior_empty hF hv hH (by
    by_contra hne
    exact hM ⟨c, m, hm, hc, nonempty_iff_ne_empty.mpr hne⟩)

end ArcMap

end HadwigerNelson.Plane
