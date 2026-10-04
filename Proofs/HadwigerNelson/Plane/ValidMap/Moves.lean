import Proofs.HadwigerNelson.Plane.ValidMap.Surgery

/-!
# The local moves at a point: SHAVE, MERGE-RAY and MERGE (FS110-N4-SHAVE, N4-RAY, W-MERGE)

Wave 4's three simplifying moves (`plans/FS131-w4-kernel-plan.md` §§ 3.2, 13; inventory item 236), proved under `Contact`'s exact
statements as `exists_shave_aux`, `exists_rayMerge_aux`, `exists_merge_aux`, which `Contact`'s leaves cite. Each move is a local
surgery at `v`: the same domain, the arcs cut inside a small disc about `v` and new arcs added there, the colouring changed only on the
recoloured region; validity is engine 1 (`Valid.of_agreesOff`) over the move's clearness, "no unit arc created" is engine 2
(`ringArcsWithin_of_Γ_subset`), and the sector count at `v` is a partition of the new map's interior points near `v`.

The machinery — the chart near its point, an arc's pieces outside a ball, the surgery and the generic move `Near.move`, and the cut
`Near.exists_cut` — is `Plane/ValidMap/Surgery` (inventory item 279).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **FS110-N4-SHAVE**, the move (`exists_shave`'s statement, copied by `tools/fs131_im_statements.py`): where SHAVE is available at
`v` for a colour `c` with `n + 1` sectors, recolouring the horn's tip by its flanks gives a valid map agreeing with `F` off a small
disc about `v`, creating no unit arc, in which `c` has `n` sectors at `v`. `Contact`'s `exists_shave` cites it. -/
theorem exists_shave_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ σ : ℝ} {c g h : Fin k}
    {n : ℕ} (hn : F.HasSectors v c (n + 1)) (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1)
    (hg : F.IsFlankAbove v α κ₂ g) (hh : F.IsFlankBelow v α κ₁ h) (hσ₁ : κ₁ ≤ σ) (hσ₂ : σ ≤ κ₂)
    (hclear : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (TanAbove v α σ z → F.IsClear g z) ∧ (¬ TanAbove v α σ z → F.IsClear h z)) :
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 := by
  sorry

/-- **FS110-N4-SHAVE**, N4-RAY (`exists_rayMerge`'s statement, copied by `tools/fs131_im_statements.py`): two `c`-horns along one
ray merge. `Contact`'s `exists_rayMerge` cites it. -/
theorem exists_rayMerge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c : Fin k}
    {n : ℕ} (hn : F.HasSectors v c (n + 1)) (h23 : κ₂ < κ₃) (hH : F.IsHorn v α κ₁ κ₂ c) (hH' : F.IsHorn v α κ₃ κ₄ c)
    (h1 : -1 ≤ κ₁) (h4 : κ₄ ≤ 1) :
    (∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₂ κ₃ r, F.IsClear c z) ∧
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 := by
  sorry

/-- **FS110-W-MERGE** (`exists_merge`'s statement, copied by `tools/fs131_im_statements.py`): if `int D_c(v)` is non-empty and `c`
has `n + 1 ≥ 2` sectors at `v`, recolouring a gap inside `D_c(v)` near `v` merges two of them. `Contact`'s `exists_merge` cites it. -/
theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
    (hn : F.HasSectors v c (n + 1)) (hD : (interior (F.allowedCone v c)).Nonempty) :
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧ F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧
      (∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 ∧ ¬ F'.HasRepeatedColour x) ∧
      ∀ v' ∉ closedBall v ρ, F'.allowedCone v' c = F.allowedCone v' c := by
  sorry

end ArcMap

end HadwigerNelson.Plane
