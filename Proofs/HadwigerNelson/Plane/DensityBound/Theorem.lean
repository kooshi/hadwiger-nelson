import Proofs.HadwigerNelson.Plane.DensityBound.X23Dist
import Proofs.HadwigerNelson.Plane.DensityBound.Window

/-!
# `m₁(ℝ²) ≤ 0.2470`: `[AmbrusEtAl2023]` Theorem 1, proved (FS-131, FS131-IDB3)

The certificate `X23` is valid (`X23_valid`); its `ϕ(t) = w₀J₀(t) + Σw₁ + Σw₂J₀(t|xᵢ − xⱼ|)` (eq. (22)) is at least
`1 − µ`, `µ = 6·10⁻⁵`, for every `t ≥ 0` (`X23_phi`: the covering `phiApprox_ge` at the certificate's own distances,
`X23_close`); and `(w_T + ν)/(1 − µ) ≤ 0.2470` (`X23_ratio`). `DualCert.oneAvoidingDensityBound_of` composes them.
-/

namespace HadwigerNelson.DensityBound

open X23Check BesselCert BesselCert.Cells

private theorem jsum_w2 (t : ℝ) : ∀ (Ws : List ℤ) (w2 : List (ℕ × ℕ × ℤ)) (g : ℕ × ℕ × ℤ → ℝ),
    w2.map (fun e => e.2.2) = Ws.map (· * 10) →
      jsum Ws (w2.map g) t / 10 ^ 20 = (w2.map fun e => (e.2.2 : ℝ) / 10 ^ 21 * J0 (t * g e)).sum
  | [], [], _, _ => by simp [jsum]
  | [], _ :: _, _, h => by simp at h
  | _ :: _, [], _, h => by simp at h
  | W :: Ws, e :: w2, g, h => by
    simp only [List.map_cons, List.cons.injEq] at h
    simp only [List.map_cons, jsum, List.sum_cons]
    rw [← jsum_w2 t Ws w2 g h.2, h.1]
    push_cast
    ring

/-- **`ϕ ≥ 1 − µ` on `[0, ∞)`** for `[AmbrusEtAl2023]`'s certificate, `µ = 6·10⁻⁵` (its eq. (22) and p. 18). -/
theorem X23_phi : ∀ t : ℝ, 0 ≤ t → 1 - 6 / 10 ^ 5 ≤ X23.phi X23w0 t := by
  intro t ht
  have h := phiApprox_ge X23dists X23_close t ht
  have hTN : (P23.TN : ℝ) / P23.TD = 1 - 6 / 10 ^ 5 := by
    rw [show P23.TN = 99994 from rfl, show P23.TD = 100000 from rfl]; norm_num
  have hWS : (P23.WS : ℝ) = 10 ^ 20 := by rw [show P23.WS = 100000000000000000000 from rfl]; norm_num
  have hw1 : (P23.w1N : ℝ) / P23.WS = (w1N : ℝ) / 10 ^ 21 := by
    rw [hWS, show P23.w1N = 105938364999802200000 from rfl, show w1N = 1059383649998022000000 from rfl]
    norm_num
  have hWs : P23.Ws = 37858331292167700000 :: P23.Ws.tail := rfl
  have h10 : w2T.map (fun e => e.2.2) = P23.Ws.tail.map (· * 10) := by decide +kernel
  have hjs : jsum P23.Ws X23dists t / P23.WS = X23w0 * J0 t +
      (w2T.map fun e => (e.2.2 : ℝ) / 10 ^ 21 * J0 (t * ‖X23pt (Fin.ofNat 23 e.1) - X23pt (Fin.ofNat 23 e.2.1)‖)).sum := by
    have hd : X23dists = 1 :: w2T.map fun e => ‖X23pt (Fin.ofNat 23 e.1) - X23pt (Fin.ofNat 23 e.2.1)‖ := by
      simp only [X23dists, X23, List.map_map, Function.comp_def]
    rw [hd, hWs, hWS]
    simp only [jsum]
    rw [add_div, jsum_w2 t _ _ _ h10, mul_one]
    simp only [X23w0]
    ring
  rw [hTN, hw1, hjs] at h
  have hphi : X23.phi X23w0 t = X23w0 * J0 t + (w1N : ℝ) / 10 ^ 21 +
      (w2T.map fun e => (e.2.2 : ℝ) / 10 ^ 21 * J0 (t * ‖X23pt (Fin.ofNat 23 e.1) - X23pt (Fin.ofNat 23 e.2.1)‖)).sum := by
    simp only [DualCert.phi, X23, List.map_map, Function.comp_def, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  rw [hphi]
  linarith

/-- **`(w_T + ν)/(1 − µ) ≤ 0.2470`** (`[AmbrusEtAl2023]` p. 19: `0.24699 … < 0.2470`). -/
theorem X23_ratio : X23.bound / (1 - 6 / 10 ^ 5) ≤ 0.2470 := by
  show (boundN : ℝ) / 10 ^ 21 / (1 - 6 / 10 ^ 5) ≤ 0.2470
  rw [show boundN = 246982629459983080000 from rfl]
  norm_num

end HadwigerNelson.DensityBound

namespace HadwigerNelson

/-- **`[AmbrusEtAl2023]` Theorem 1**: every Lebesgue-measurable 1-avoiding planar set has upper density at most `0.2470`,
at every centre — proved here from the paper's certificate, with no periodic reduction and no Bessel citation. -/
theorem Plane.oneAvoidingDensityBound : Plane.OneAvoidingDensityBound :=
  DensityBound.DualCert.oneAvoidingDensityBound_of DensityBound.X23 DensityBound.X23_valid (mu := 6 / 10 ^ 5)
    (by norm_num) DensityBound.X23_phi DensityBound.X23_ratio

end HadwigerNelson
