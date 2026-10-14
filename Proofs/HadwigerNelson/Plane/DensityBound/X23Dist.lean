import Proofs.HadwigerNelson.Plane.DensityBound.X23
import Proofs.HadwigerNelson.Plane.DensityBound.Cells.Covering

/-!
# The certificate's distances against the covering's (FS-131, FS131-IDB3)

The covering `BesselCert.Cells.phiApprox_ge` holds for every list of distances within `2⁻⁶⁴` of `P23.Ds/2⁶⁴`. Here the
certificate's own distances — `1` for `w₀`, then `|xᵢ − xⱼ|` for the 26 `w₂` rows in `g23.csv`'s order — are shown to be
such a list: each squared distance is exact in `ℚ(√3, √11)`, and `√3`, `√11`, `√33` are enclosed at `2⁻¹²⁸` (`distOk`).
-/

namespace HadwigerNelson.DensityBound

open X23Check BesselCert BesselCert.Cells

/-- The distances `ϕ` reads: `1` (the `w₀` term), then `|xᵢ − xⱼ|` for each `w₂` row. -/
noncomputable def X23dists : List ℝ := 1 :: X23.w2.map fun e => ‖X23.X e.1 - X23.X e.2.1‖

/-- Each `w₂` row's distance against `P23`'s, by `decide +kernel`. -/
theorem dists_ok : distsOk ptsL enclL P23.Ds.tail w2T = true := by decide +kernel

namespace X23Check

/-- An accepted distance list is `Close` to the listed one. -/
theorem forall₂_of_distsOk {e : Encl} (he : e.ok = true) :
    ∀ (Ds : List ℤ) (w2 : List (ℕ × ℕ × ℤ)), distsOk ptsL e Ds w2 = true → (∀ x ∈ w2, x.1 < 23 ∧ x.2.1 < 23) →
      List.Forall₂ (fun (D : ℤ) (x : ℝ) => |x - (D : ℝ) / S| ≤ 1 / (S : ℝ) ∧ 0 ≤ x) Ds
        (w2.map fun x => ‖X23pt (Fin.ofNat 23 x.1) - X23pt (Fin.ofNat 23 x.2.1)‖)
  | [], [], _, _ => List.Forall₂.nil
  | [], _ :: _, h, _ => by simp [distsOk] at h
  | _ :: _, [], h, _ => by simp [distsOk] at h
  | D :: Ds, (i, j, c) :: w2, h, hb => by
    simp only [distsOk, Bool.and_eq_true] at h
    have hij := hb (i, j, c) (by simp)
    have hSS : (S : ℝ) = (S64 : ℝ) := by norm_num [S, S64]
    refine List.Forall₂.cons ?_ (forall₂_of_distsOk he Ds w2 h.2 (fun x hx => hb x (by simp [hx])))
    have hi : X23pt (Fin.ofNat 23 i) = toC (pt ptsL i) / 12 := by
      simp only [X23pt, Fin.val_ofNat, Nat.mod_eq_of_lt hij.1]
    have hj : X23pt (Fin.ofNat 23 j) = toC (pt ptsL j) / 12 := by
      simp only [X23pt, Fin.val_ofNat, Nat.mod_eq_of_lt hij.2]
    beta_reduce
    rw [hi, hj, hSS]
    exact distOk_sound he h.1

end X23Check

/-- **The certificate's distances are within `2⁻⁶⁴` of the covering's.** -/
theorem X23_close : Close P23.Ds X23dists := by
  have hD : P23.Ds = 18446744073709551616 :: P23.Ds.tail := rfl
  rw [hD]
  refine List.Forall₂.cons ⟨?_, zero_le_one⟩ ?_
  · norm_num [S]
  · have hmap : X23.w2.map (fun e => ‖X23.X e.1 - X23.X e.2.1‖) =
        w2T.map fun x => ‖X23pt (Fin.ofNat 23 x.1) - X23pt (Fin.ofNat 23 x.2.1)‖ := by
      simp only [X23, List.map_map, Function.comp_def]
    rw [hmap]
    exact X23Check.forall₂_of_distsOk encl_ok _ _ dists_ok
      (fun x hx => ⟨(X23Check.terms_ok'.2.1 x hx).1, (X23Check.terms_ok'.2.1 x hx).2.1⟩)

end HadwigerNelson.DensityBound
