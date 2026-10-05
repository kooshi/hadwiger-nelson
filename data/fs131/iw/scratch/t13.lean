import Proofs.HadwigerNelson.Plane.Woodall.Steps
namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric

theorem finRotate_ne_symm {n : ℕ} (hn : 3 ≤ n) (i : Fin n) : finRotate n i ≠ (finRotate n).symm i := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
  intro h
  have h2 : finRotate (m + 1) (finRotate (m + 1) i) = i := by
    conv_lhs => rw [h]
    exact (finRotate (m + 1)).apply_symm_apply i
  rw [finRotate_apply, finRotate_apply] at h2
  have h3 : (1 + 1 : Fin (m + 1)) = 0 := by
    have : i + (1 + 1) = i + 0 := by rw [add_zero, ← add_assoc]; exact h2
    exact add_left_cancel this
  have h4 := congrArg Fin.val h3
  rw [Fin.val_add] at h4
  simp at h4
  rw [Nat.mod_eq_of_lt (by omega)] at h4
  omega


namespace ArcMap
variable {k : ℕ} {F : ArcMap k}

open Fin.NatCast in
theorem aeMap6_merged' (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) (hM : F.WoodallMerged) : False := by
  have hN : F.WoodallNormal := by
    intro v n d c h hn3
    have hlast := h.2.2.1
    have hmono := h.2.1
    have hw0 : ∀ i : Fin n, 0 ≤ d i.succ - d i.castSucc := fun i => sub_nonneg.mpr (hmono (Fin.castSucc_le_succ i))
    -- a repeated colour sits on horns, and a horn dies: every sector has positive width
    have hpos : ∀ i : Fin n, 0 < d i.succ - d i.castSucc := by
      by_contra hcon
      push Not at hcon
      obtain ⟨i₀, hi₀⟩ := hcon
      have hz : ∀ i : Fin n, d i.succ - d i.castSucc = 0 → d (finRotate n i).succ - d (finRotate n i).castSucc = 0 ∨
          ∃ j : Fin n, d j.succ - d j.castSucc = 0 ∧ 0 < d (finRotate n j).succ - d (finRotate n j).castSucc := by
        intro i hi
        rcases (hw0 (finRotate n i)).eq_or_lt with h0 | h0
        · exact Or.inl h0.symm
        · exact Or.inr ⟨i, hi, h0⟩
      obtain ⟨j, hj0, hjp⟩ : ∃ j : Fin n, d j.succ - d j.castSucc = 0 ∧ 0 < d (finRotate n j).succ - d (finRotate n j).castSucc := by
        by_contra hno
        push Not at hno
        have hall : ∀ i : Fin n, d i.succ - d i.castSucc = 0 := by
          obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
          have hstep : ∀ i : Fin (m + 1), d i.succ - d i.castSucc = 0 → d (i + 1).succ - d (i + 1).castSucc = 0 := by
            intro i hi
            rw [← finRotate_apply]
            exact le_antisymm (hno i hi) (hw0 _)
          have hind : ∀ q : ℕ, d (i₀ + (q : Fin (m + 1))).succ - d (i₀ + (q : Fin (m + 1))).castSucc = 0 := by
            intro q
            induction q with
            | zero => simpa using le_antisymm hi₀ (hw0 i₀)
            | succ q ih =>
              have := hstep _ ih
              rwa [Nat.cast_succ, ← add_assoc]
          intro i
          have := hind (i - i₀).val
          rwa [Fin.cast_val_eq_self, add_sub_cancel] at this
        have hs := sum_width hlast
        rw [Finset.sum_eq_zero fun i _ => hall i] at hs
        linarith [Real.pi_pos]
      -- the next sector's colour is not repeated, so it differs from the previous sector's
      have hnr : ∀ l : Fin n, l ≠ finRotate n j → c l ≠ c (finRotate n j) := by
        intro l hl hcl
        have := (hM v n d c h l (finRotate n j) hl hcl).2
        linarith [this]
      refine step5_lt hk hF hP h hn3 j (by rw [hj0]; positivity) ?_
      exact fun heq => hnr _ (finRotate_ne_symm hn3 j).symm heq.symm
    have hinj : Function.Injective c := by
      intro i j hij
      by_contra hne
      have := (hM v n d c h i j hne hij).1
      linarith [hpos i]
    refine ⟨hinj, fun i => ?_⟩
    by_contra hlt
    push Not at hlt
    exact step5_lt hk hF hP h hn3 i hlt (fun heq => finRotate_ne_symm hn3 i (hinj heq))
  exact aeMap6_normal hk hF hP hN

end ArcMap

end HadwigerNelson.Plane
