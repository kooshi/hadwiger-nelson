import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.LocalStructure

/-!
# The collar bend (FS131-KB2)

`bend_toward_collar`, the strengthened toward bend `exists_preBend` iterates (FS131-E4's E4-BEND-UN with R1–R3 and no new inert arc;
FS131-I5o's statement, moved verbatim from `data/fs131/i5o/BendCollar.lean`, rulings 360, 366, 370 (d)). Its construction: a lens
bounded by circles internally tangent to the arc at its two ends (so a horn-shaped tip fits a horn), the push of the arc across a collar
along the rays from its centre, and the bent map as the image of the old one under that homeomorphism (`plans/FS131-I5-implementation.md`
§ 44).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The collar bend** (E4-BEND-UN with R1–R3; FS131-I5o's form): a whole maximal arc `α = r([θ₁, θ₂])` of `Γ` on `ω(P)` with constant
sides `c` (inner), `c'` (outer), `c'` not carried at `P`, shorter than the circle, whose open arc meets no other arc of `Γ` (`hfree`: near
each interior point `Γ` is `ω(P)`), bends toward `P` inside a collar of `α` in its inner tile. The bent map `M` is the image of `F` under a
homeomorphism `h` of the plane supported in `thickening ε α`, fixing every point of `Γ` off `α°` (so the ends `A`, `B` and every vertex),
carrying interior points to interior points of the same colour; so colours, degrees and repeated colours are carried point by point.
Metrically: `M` is valid, on `F`'s domain; its constant-sided unit arcs are `F`'s with the same sides (R1); `F`'s whose open arc misses `α°`
survive in `M` (R2); no point of `α°` is on a unit arc of `M` centred at `P` (R3); and no inert arc is created (validity forbids a unit
arc centred on `α°` or in the lens to carry `c` on a side, so the colours lost there make nothing inert). -/
theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hout : c' ∉ F.coloursAt P) (hlen : θ₂ - θ₁ < 2 * π)
    (hmax : ∀ θ₁' θ₂', ringArc P θ₁ θ₂ ⊆ ringArc P θ₁' θ₂' → F.IsRingArc P θ₁' θ₂' c c' →
      ringArc P θ₁' θ₂' = ringArc P θ₁ θ₂)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) {ε : ℝ} (hε : 0 < ε) :
    ∃ (M : ArcMap k) (h : ℂ ≃ₜ ℂ), M.Valid ∧ M.dom = F.dom ∧
      (∀ z ∉ thickening ε (ringArc P θ₁ θ₂), h z = z) ∧
      (∀ z ∈ F.Γ, z ∉ ringPt P '' Ioo θ₁ θ₂ → h z = z) ∧
      (∀ z, (h z ∈ M.interiorPts ↔ z ∈ F.interiorPts) ∧ (z ∈ F.interiorPts → M.col (h z) = F.col z)) ∧
      (∀ z, M.coloursAt (h z) = F.coloursAt z) ∧
      (∀ z n, M.HasDegree (h z) n ↔ F.HasDegree z n) ∧
      (∀ z, M.HasRepeatedColour (h z) ↔ F.HasRepeatedColour z) ∧
      (∀ Q a b d d', M.IsRingArc Q a b d d' → F.IsRingArc Q a b d d') ∧
      (∀ Q a b d d', F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
        M.IsRingArc Q a b d d') ∧
      (∀ θ ∈ Ioo θ₁ θ₂, ¬ M.OnRingArc P (ringPt P θ)) ∧
      (∀ Q a b, M.Inert Q a b → F.Inert Q a b) := by
  sorry

end ArcMap

end HadwigerNelson.Plane
