import Proofs.HadwigerNelson.Plane.ValidMap.Limit

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **A surgery is a local step on its closed ball** (the moves' constructions — MERGE's and OPEN's `surgery`, MERGE-RAY's and
SHAVE's `Near.move` — are all of this form, their new arcs inside the closed ball: `mergeArcs_subset_closedBall`,
`openArcs_subset_closedBall`, `newArcs_subset_closedBall`): an arc of `F` missing the closed ball misses `v` and is kept whole by
`trimArcs`; a trimmed arc that is not an arc of `F` is an outer piece of an arc through `v`; a new arc lies in the closed ball. -/
theorem surgery_localStep {v : ℂ} {ρ : ℝ} {A : Set Arc} {col' : ℂ → Fin k} {hv : v ∈ F.dom} {hρ : 0 < ρ}
    {hA : ∀ a ∈ A, a.Nondegenerate} {hAf : A.Finite}
    {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ A, a.carrier → ∀ᶠ y in 𝓝 x, col' y = col' x}
    (hAin : ∀ a ∈ A, a.carrier ⊆ closedBall v ρ) (hcol : ∀ z ∉ closedBall v ρ, col' z = F.col z) :
    LocalStep F (F.surgery v ρ A col' hv hρ hA hAf hlc) (closedBall v ρ) where
  agreesOff := surgery_agreesOff hAin hcol
  keep := fun a ha hd => Or.inl (Or.inl ⟨ha, fun hva => Set.disjoint_left.mp hd hva (mem_closedBall_self hρ.le)⟩)
  new := by
    rintro b (hb | hb) hbF
    · rcases hb with ⟨hb, -⟩ | hb
      · exact absurd hb hbF
      · obtain ⟨a, ⟨ha, hva⟩, hba⟩ := mem_iUnion₂.mp hb
        obtain ⟨h1, -⟩ := Arc.outer_spec (F.nondegenerate a ha) hva hρ
        exact Or.inr ⟨a, ha, ⟨v, hva, mem_closedBall_self hρ.le⟩, (h1 b hba).2.1⟩
    · exact Or.inl (hAin b hb)

end ArcMap

end HadwigerNelson.Plane
