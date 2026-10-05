import Proofs.HadwigerNelson.Plane.ValidMap.BaseWalk

open HadwigerNelson.Plane Complex Real Set

namespace HadwigerNelson.Plane.ArcMap

/-- QA3 check 1: `exists_endpoint`'s second disjunct of `hc` is dead — a germ cannot be pseudo-coloured `{a}` and `{c}` with `a ≠ c`. -/
example {k : ℕ} (F : ArcMap k) (u : ℂ) (θ : ℝ) (a c : Fin k) (hac : a ≠ c)
    (ha : F.GermPseudo u θ .cw a) (hc : F.GermPseudo u θ .cw c) : False := by
  have h := GermIn.inter ha hc
  obtain ⟨δ, hδ, hsub⟩ := h
  have hz := hsub ⟨δ / 2, ⟨by linarith, by linarith⟩, rfl⟩
  obtain ⟨h1, h2⟩ := hz
  have : ({a} : Set (Fin k)) = {c} := by
    simp only [mem_setOf_eq] at h1 h2; rw [← h1, h2]
  exact hac (Set.singleton_eq_singleton_iff.mp this)

/-- QA3 check 2: `HornBoundsQR`'s upper arc starts at `w`: `r_{w + n}(β − π/2) = w`. -/
example (w : ℂ) (β : ℝ) : ringPt (w + e (β + π / 2)) (β - π / 2) = w := by
  unfold ringPt
  have : e (β - π / 2) = - e (β + π / 2) := by
    rw [show β + π / 2 = (β - π / 2) + π by ring, e_add_pi]; ring
  rw [this]; ring

/-- QA3 check 3: the lower arc ends at `w`: `r_{w − n}(β + π/2) = w`. -/
example (w : ℂ) (β : ℝ) : ringPt (w - e (β + π / 2)) (β + π / 2) = w := by
  unfold ringPt; ring

end HadwigerNelson.Plane.ArcMap
