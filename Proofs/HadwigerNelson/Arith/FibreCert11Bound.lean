import Proofs.HadwigerNelson.Arith.FibreCert11Psd
import Proofs.HadwigerNelson.Arith.FibreCertSound

/-!
# FS-66's certificate at `p = 11` accepted, and the class-ratio bound at `p = 11` (FS131-IKC3)

**Read aloud.** `cert11_ok`: FS-66's `p = 11` certificate passes the whole check, `certOK cert11 = true`, assembled from
the ten declarations of `Arith/FibreCert11Seg0` … `Seg7`, `Global` and `Psd` with no evaluation.

`sum_le_eleven`: every `φ : (ℤ/11)² → [0, 1]` with `q(φ) = 2·Σ_x φ_x (1 − φ_x) − Σ_x Σ_{s ∈ S} φ_x φ_{x+s} ≥ 0`
(`S = {a² + b² = 1}`) has `Σ φ ≤ U/L`, `U = 28204320001863099628721379861820`, `L = 10^30` (`U/L = 28.2043…`): FS-66's
L4 at `p = 11` (`data/fs66/b1/SOUNDNESS.md` § 0), from `FibreCertSound.sum_le_of_certOK`.

`card_le_eleven`: an independent set of `Cay((ℤ/11)², S)` has at most `U/L` points, from `card_le_of_certOK`. Against
`121/4 = 30.25` the ratio is `U/(121·L) = 0.2331…`; that comparison is the chain's leaf K5
(`plans/FS131-KC13-certificates.md` § 5.2), not this module's.

**Model.** `model_eleven`: the hypotheses of both bounds hold together — `φ = 0`, and the independent set `{0}`.
-/

namespace HadwigerNelson.FibreCert

/-- `cert11`'s modulus. -/
theorem cert11_p : cert11.p = 11 := rfl

/-- `cert11`'s numerator `U`. -/
theorem cert11_unum : cert11.unum = 28204320001863099628721379861820 := rfl

/-- `cert11`'s scale `L`. -/
theorem cert11_scale : cert11.scale = 1000000000000000000000000000000 := rfl

/-- `cert11`'s number of identity segments. -/
theorem cert11_nseg : cert11.nseg = 8 := rfl

/-- **The `p = 11` certificate passes**: the shape (`cert11_global`), the eight identity segments (`cert11_seg0` …
`cert11_seg7`) and positive definiteness (`cert11_psd`), each checked by the kernel in its own module. -/
theorem cert11_ok : certOK cert11 = true := by
  have hs : segAll cert11 = true := by
    change (List.range cert11.nseg).all (segCheck cert11) = true
    rw [cert11_nseg]
    refine List.all_eq_true.2 fun k hk => ?_
    rw [List.mem_range] at hk
    match k, hk with
    | 0, _ => exact cert11_seg0
    | 1, _ => exact cert11_seg1
    | 2, _ => exact cert11_seg2
    | 3, _ => exact cert11_seg3
    | 4, _ => exact cert11_seg4
    | 5, _ => exact cert11_seg5
    | 6, _ => exact cert11_seg6
    | 7, _ => exact cert11_seg7
    | n + 8, h => exact absurd h (by omega)
  change (globalOK cert11 && segAll cert11 && psdAll cert11) = true
  rw [cert11_global, hs, cert11_psd]
  rfl

end HadwigerNelson.FibreCert

namespace HadwigerNelson.FibreCertSound

open HadwigerNelson.FibreCert

/-- **The class-ratio bound at `p = 11`** (FS-66's L4): every `φ : (ℤ/11)² → [0, 1]` with `q(φ) ≥ 0` has
`Σ φ ≤ 28204320001863099628721379861820 / 10^30`. -/
theorem sum_le_eleven (φ : V 11 → ℝ) (h0 : ∀ x, 0 ≤ φ x) (h1 : ∀ x, φ x ≤ 1) (hq : 0 ≤ qform 11 φ) :
    ∑ x, φ x ≤ (28204320001863099628721379861820 : ℝ) / 1000000000000000000000000000000 := by
  haveI : NeZero cert11.p := ⟨by rw [cert11_p]; decide⟩
  have h := sum_le_of_certOK cert11 cert11_ok φ h0 h1 hq
  rw [cert11_unum, cert11_scale] at h
  exact_mod_cast h

/-- **Level one at `p = 11`**: an independent set of `Cay((ℤ/11)², S)` has at most
`28204320001863099628721379861820 / 10^30` points. -/
theorem card_le_eleven (I : Finset (V 11)) (hI : ∀ x ∈ I, ∀ y ∈ I, y - x ∉ unitCircle 11) :
    (I.card : ℝ) ≤ (28204320001863099628721379861820 : ℝ) / 1000000000000000000000000000000 := by
  haveI : NeZero cert11.p := ⟨by rw [cert11_p]; decide⟩
  have h := card_le_of_certOK cert11 cert11_ok I hI
  rw [cert11_unum, cert11_scale] at h
  exact_mod_cast h

/-- The hypotheses of `sum_le_eleven` and `card_le_eleven` hold together: `φ = 0`, and the independent set `{0}`. -/
theorem model_eleven : (∃ φ : V 11 → ℝ, (∀ x, 0 ≤ φ x) ∧ (∀ x, φ x ≤ 1) ∧ 0 ≤ qform 11 φ) ∧
    ∃ I : Finset (V 11), I.Nonempty ∧ ∀ x ∈ I, ∀ y ∈ I, y - x ∉ unitCircle 11 :=
  ⟨⟨fun _ => 0, fun _ => le_rfl, fun _ => zero_le_one, by simp [qform]⟩,
    ⟨{0}, Finset.singleton_nonempty _, fun x hx y hy => by
      rw [Finset.mem_singleton] at hx hy
      subst hx; subst hy
      simp only [sub_self, unitCircle, Finset.mem_filter, Finset.mem_univ, true_and]
      decide⟩⟩

end HadwigerNelson.FibreCertSound
