import Proofs.HadwigerNelson.Plane.RingCalculus.SemiHubPlaces
/-! FS131-I8D, a kernel remark behind the message on the four leaves' count of colours: the conclusion of
`crossed_four` holds only at `k = 6`. (Iteration file, elaborated by `lake env lean`; not part of the library.) -/
open HadwigerNelson.Plane HadwigerNelson.Plane.ArcMap Set
example {k : ℕ} {F : ArcMap k} (hF : F.Valid) {p : ℂ} (hp : F.Covers p 1)
    (h4 : 4 ≤ (F.coloursAt p).ncard) (hk : k ≤ (F.coloursAt p).ncard + 2) {ψ : ℝ} {X X' : Fin k}
    (hy : F.IsChangePoint p ψ X X') {a b : Fin k} (hy4 : (F.coloursAt (ringPt p ψ)).ncard = 4)
    (hconcl : (F.coloursAt (ringPt p ψ))ᶜ = {a, b}) : k = 6 := by
  have h1 := (germS_absent hF hp h4 hk hy).1
  have h2 := Set.ncard_add_ncard_compl (F.coloursAt (ringPt p ψ))
  rw [Nat.card_eq_fintype_card, Fintype.card_fin, hconcl, hy4] at h2
  have h3 : ({a, b} : Set (Fin k)).ncard ≤ 2 := by
    have := Set.ncard_insert_le a ({b} : Set (Fin k))
    rw [Set.ncard_singleton] at this
    exact this
  omega
