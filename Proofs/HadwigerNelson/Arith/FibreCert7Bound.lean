import Proofs.HadwigerNelson.Arith.FibreCert7Check
import Proofs.HadwigerNelson.Arith.FibreCertSound

/-!
# FS-66's certificate at `p = 7` accepted, and the class-ratio bound at `p = 7` (FS131-IQP1)

**Read aloud.** `cert7_ok`: FS-66's `p = 7` certificate passes the whole check, `certOK cert7 = true`, assembled from
the three declarations of `Arith/FibreCert7Check` with no evaluation.

`sum_le_seven`: every `φ : (ℤ/7)² → [0, 1]` with `q(φ) = 2·Σ_x φ_x (1 − φ_x) − Σ_x Σ_{s ∈ S} φ_x φ_{x+s} ≥ 0`
(`S = {a² + b² = 1}`) has `Σ φ ≤ U/L`, `U = 14015224526962403621588626098460`, `L = 10^30` (`U/L = 14.0152…`): FS-66's
L4 at `p = 7` (`data/fs66/b1/SOUNDNESS.md` § 0), from `FibreCertSound.sum_le_of_certOK`. Against `49/3 = 16.33…` the
ratio `U/(49·L) = 0.2860…` is below `1/3`: the comparison is `PadicPlane/Values`'s, not this module's.

**Model.** `model_seven`: the hypothesis of the bound holds — `φ = 0`.
-/

namespace HadwigerNelson.FibreCert

/-- `cert7`'s modulus. -/
theorem cert7_p : cert7.p = 7 := rfl

/-- `cert7`'s numerator `U`. -/
theorem cert7_unum : cert7.unum = 14015224526962403621588626098460 := rfl

/-- `cert7`'s scale `L`. -/
theorem cert7_scale : cert7.scale = 1000000000000000000000000000000 := rfl

/-- `cert7`'s number of identity segments. -/
theorem cert7_nseg : cert7.nseg = 1 := rfl

/-- **The `p = 7` certificate passes**: the shape (`cert7_global`), the one identity segment (`cert7_seg0`) and positive
definiteness (`cert7_psd`), each checked by the kernel in `Arith/FibreCert7Check`. -/
theorem cert7_ok : certOK cert7 = true := by
  have hs : segAll cert7 = true := by
    change (List.range cert7.nseg).all (segCheck cert7) = true
    rw [cert7_nseg]
    refine List.all_eq_true.2 fun k hk => ?_
    rw [List.mem_range] at hk
    match k, hk with
    | 0, _ => exact cert7_seg0
    | n + 1, h => exact absurd h (by omega)
  change (globalOK cert7 && segAll cert7 && psdAll cert7) = true
  rw [cert7_global, hs, cert7_psd]
  rfl

end HadwigerNelson.FibreCert

namespace HadwigerNelson.FibreCertSound

open HadwigerNelson.FibreCert

/-- **The class-ratio bound at `p = 7`** (FS-66's L4): every `φ : (ℤ/7)² → [0, 1]` with `q(φ) ≥ 0` has
`Σ φ ≤ 14015224526962403621588626098460 / 10^30`. -/
theorem sum_le_seven (φ : V 7 → ℝ) (h0 : ∀ x, 0 ≤ φ x) (h1 : ∀ x, φ x ≤ 1) (hq : 0 ≤ qform 7 φ) :
    ∑ x, φ x ≤ (14015224526962403621588626098460 : ℝ) / 1000000000000000000000000000000 := by
  haveI : NeZero cert7.p := ⟨by rw [cert7_p]; decide⟩
  have h := sum_le_of_certOK cert7 cert7_ok φ h0 h1 hq
  rw [cert7_unum, cert7_scale] at h
  exact_mod_cast h

/-- The hypothesis of `sum_le_seven` holds: `φ = 0`. -/
theorem model_seven : ∃ φ : V 7 → ℝ, (∀ x, 0 ≤ φ x) ∧ (∀ x, φ x ≤ 1) ∧ 0 ≤ qform 7 φ :=
  ⟨fun _ => 0, fun _ => le_rfl, fun _ => zero_le_one, by simp [qform]⟩

end HadwigerNelson.FibreCertSound
