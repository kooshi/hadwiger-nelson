import Proofs.HadwigerNelson.Plane.SixRing.ChartMeasure
import Proofs.HadwigerNelson.Plane.SixRing.StepLemma
import Proofs.HadwigerNelson.Outside.OAI158PaletteTransport

/-!
# The state of an orbit and what it forces near a hub (FS-132, C132-M-ORBIT steps M1, M2, M3)

The palette side of the exclusion. For a weak colouring `c` of **the whole plane** with any number of labels, a
centre `p`, and two labels `X`, `Y` satisfying the ring hypothesis `OutsideOrbit c hc p X Y ψ δ`, the *state* is the
set `liftPalette c hc p X` of real angles whose palette holds `X`. Near the six directions it is the complement of
the set for `Y` (M1), it flips under the rotation by `π/3` (M1), it changes at every direction of the orbit (M1),
and the colour at a chart point avoids the labels its two ring points name (M2, the derivation's (⋆)). Hence every
hub has a tip other than `X`, `Y` (M3), and where the other labels do not tip, the colouring is as `HubColours`
says.

Stands on the release's `palette_sixty_disjoint` (in its real-line form `palette_sixty_real`) and
`palette_transfer_pair`, ported in `Outside/OAI158PaletteTransport` and `Outside/OAI158PaletteDensity` (FS132-I2).
`plans/FS132-kernel-plan.md` stage 5 has the plan per leaf.

**Every statement here is proved from the statements it cites** (job FS132-I4); this module has no `sorry` of its
own. Beside the two ported lemmas it cites `chart_eq_angularSum` (`Chart`), `chartAngles_quasiMeasurePreserving` and
`ae_ne_of_not_isTip` (`ChartMeasure`), `volume_change_pairs_pos` (`StepLemma`) and `change_of_ae_flip`
(`NullSets`).
-/

open MeasureTheory Set

namespace HadwigerNelson.SixRing

open Outside.OAI158 Real

variable {k : ℕ} {c : ℂ → Fin k} {hc : Measurable c} {p : ℂ} {X Y : Fin k} {ψ δ : ℝ}

/-- An angle is in the lifted palette set of a label exactly when its palette holds the label. -/
theorem mem_liftPalette (c : ℂ → Fin k) (hc : Measurable c) (p : ℂ) (i : Fin k) (θ : ℝ) :
    θ ∈ liftPalette c hc p i ↔ i ∈ palette c hc p (θ : Angles) :=
  (mem_palette c hc p (θ : Angles) i).symm

/-- The state is a measurable set of real angles ("`s` is taken Borel (it is: `paletteSet` is measurable)",
`plans/FS132-kernel-plan.md` § 3.2). -/
theorem measurableSet_liftPalette (c : ℂ → Fin k) (hc : Measurable c) (p : ℂ) (i : Fin k) :
    MeasurableSet (liftPalette c hc p i) :=
  liftPalette_measurable c hc p i

/-- Clause (i) with the state as a set: near each direction of the orbit, almost every angle is in the lifted
palette set of `X` or of `Y`. -/
theorem OutsideOrbit.ae_mem_or (h : OutsideOrbit c hc p X Y ψ δ) (n : ℤ) :
    ∀ᵐ θ : ℝ, |θ - ψ - n * (π / 3)| < δ → θ ∈ liftPalette c hc p X ∨ θ ∈ liftPalette c hc p Y := by
  filter_upwards [h.outside n] with θ hθ hlt
  simpa only [mem_liftPalette] using hθ hlt

/-- Clause (i) at the next direction, read at `θ + π/3`: near the direction `ψ + nπ/3`, almost every angle `θ` has
`θ + π/3` in the lifted palette set of `X` or of `Y`. -/
theorem OutsideOrbit.ae_add_mem_or (h : OutsideOrbit c hc p X Y ψ δ) (n : ℤ) :
    ∀ᵐ θ : ℝ, |θ - ψ - n * (π / 3)| < δ →
      θ + π / 3 ∈ liftPalette c hc p X ∨ θ + π / 3 ∈ liftPalette c hc p Y := by
  have h1 := (measurePreserving_add_right volume (π / 3)).quasiMeasurePreserving.ae (h.ae_mem_or (n + 1))
  filter_upwards [h1] with θ hθ hlt
  refine hθ ?_
  have e : θ + π / 3 - ψ - ((n + 1 : ℤ) : ℝ) * (π / 3) = θ - ψ - n * (π / 3) := by
    push_cast
    ring
  rw [e]
  exact hlt

/-- **M1, "each holds exactly one"**: near each direction of the orbit, for almost every angle, the palette holds
`Y` exactly when it does not hold `X`. From clause (i) at two consecutive directions and `palette_sixty_disjoint`. -/
theorem OutsideOrbit.ae_iff_not (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
    ∀ᵐ θ : ℝ, |θ - ψ - n * (π / 3)| < δ → (θ ∈ liftPalette c hc p Y ↔ θ ∉ liftPalette c hc p X) := by
  filter_upwards [h.ae_mem_or n, h.ae_add_mem_or n, palette_sixty_real c hc hw p X,
    palette_sixty_real c hc hw p Y] with θ h0 h1 hX hY hlt
  refine ⟨fun hθY hθX => ?_, fun hθX => (h0 hlt).resolve_left hθX⟩
  rcases h1 hlt with h60 | h60
  · exact hX hθX h60
  · exact hY hθY h60

/-- **M1, "`s(θ + π/3) ≠ s(θ)`"**: near each direction of the orbit, for almost every angle `θ`, the palette at
`θ + π/3` holds `X` exactly when the palette at `θ` does not. -/
theorem OutsideOrbit.ae_flip (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
    ∀ᵐ θ : ℝ, |θ - ψ - n * (π / 3)| < δ →
      (θ + π / 3 ∈ liftPalette c hc p X ↔ θ ∉ liftPalette c hc p X) := by
  filter_upwards [h.ae_mem_or n, h.ae_add_mem_or n, palette_sixty_real c hc hw p X,
    palette_sixty_real c hc hw p Y] with θ h0 h1 hX hY hlt
  refine ⟨fun h60 hθX => hX hθX h60, fun hθX => ?_⟩
  exact (h1 hlt).resolve_right (hY ((h0 hlt).resolve_left hθX))

/-- **M1, "each `ψ_k` is an essential change point"**: every neighbourhood of every direction `ψ + mπ/3` of the
orbit meets the state and its complement in positive measure. From clause (ii) at `ψ` and the flip. -/
theorem OutsideOrbit.change_at (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (m : ℤ) :
    ∀ η : ℝ, 0 < η →
      0 < volume (liftPalette c hc p X ∩ Ioo (ψ + (m : ℝ) * (π / 3) - η) (ψ + (m : ℝ) * (π / 3) + η)) ∧
      0 < volume ((liftPalette c hc p X)ᶜ ∩ Ioo (ψ + (m : ℝ) * (π / 3) - η) (ψ + (m : ℝ) * (π / 3) + η)) := by
  -- one step up: from the direction `m` to the direction `m + 1`, by the flip at `m`
  have up : ∀ m : ℤ,
      (∀ η : ℝ, 0 < η →
        0 < volume (liftPalette c hc p X ∩ Ioo (ψ + (m : ℝ) * (π / 3) - η) (ψ + (m : ℝ) * (π / 3) + η)) ∧
        0 < volume ((liftPalette c hc p X)ᶜ ∩ Ioo (ψ + (m : ℝ) * (π / 3) - η) (ψ + (m : ℝ) * (π / 3) + η))) →
      ∀ η : ℝ, 0 < η →
        0 < volume (liftPalette c hc p X ∩
          Ioo (ψ + ((m + 1 : ℤ) : ℝ) * (π / 3) - η) (ψ + ((m + 1 : ℤ) : ℝ) * (π / 3) + η)) ∧
        0 < volume ((liftPalette c hc p X)ᶜ ∩
          Ioo (ψ + ((m + 1 : ℤ) : ℝ) * (π / 3) - η) (ψ + ((m + 1 : ℤ) : ℝ) * (π / 3) + η)) := by
    intro m hm
    have hflip : ∀ᵐ θ : ℝ, |θ - (ψ + (m : ℝ) * (π / 3))| < δ →
        (θ + π / 3 ∈ liftPalette c hc p X ↔ θ ∉ liftPalette c hc p X) := by
      filter_upwards [h.ae_flip hw m] with θ hθ hlt
      exact hθ (by rwa [sub_sub])
    have e : ψ + ((m + 1 : ℤ) : ℝ) * (π / 3) = ψ + (m : ℝ) * (π / 3) + π / 3 := by
      push_cast
      ring
    rw [e]
    exact change_of_ae_flip h.pos hflip hm
  -- one step down: from the direction `m` to the direction `m − 1`, by the flip at `m − 1`
  have down : ∀ m : ℤ,
      (∀ η : ℝ, 0 < η →
        0 < volume (liftPalette c hc p X ∩ Ioo (ψ + (m : ℝ) * (π / 3) - η) (ψ + (m : ℝ) * (π / 3) + η)) ∧
        0 < volume ((liftPalette c hc p X)ᶜ ∩ Ioo (ψ + (m : ℝ) * (π / 3) - η) (ψ + (m : ℝ) * (π / 3) + η))) →
      ∀ η : ℝ, 0 < η →
        0 < volume (liftPalette c hc p X ∩
          Ioo (ψ + ((m - 1 : ℤ) : ℝ) * (π / 3) - η) (ψ + ((m - 1 : ℤ) : ℝ) * (π / 3) + η)) ∧
        0 < volume ((liftPalette c hc p X)ᶜ ∩
          Ioo (ψ + ((m - 1 : ℤ) : ℝ) * (π / 3) - η) (ψ + ((m - 1 : ℤ) : ℝ) * (π / 3) + η)) := by
    intro m hm
    have h1 := (measurePreserving_add_right volume (-(π / 3))).quasiMeasurePreserving.ae (h.ae_flip hw (m - 1))
    have hflip : ∀ᵐ θ : ℝ, |θ - (ψ + (m : ℝ) * (π / 3))| < δ →
        (θ + -(π / 3) ∈ liftPalette c hc p X ↔ θ ∉ liftPalette c hc p X) := by
      filter_upwards [h1] with θ hθ hlt
      have e1 : θ + -(π / 3) - ψ - ((m - 1 : ℤ) : ℝ) * (π / 3) = θ - (ψ + (m : ℝ) * (π / 3)) := by
        push_cast
        ring
      have h2 := hθ (by rw [e1]; exact hlt)
      rw [neg_add_cancel_right] at h2
      exact ⟨fun h3 h4 => h2.mp h4 h3, fun h3 => by_contra fun h4 => h3 (h2.mpr h4)⟩
    have e : ψ + ((m - 1 : ℤ) : ℝ) * (π / 3) = ψ + (m : ℝ) * (π / 3) + -(π / 3) := by
      push_cast
      ring
    rw [e]
    exact change_of_ae_flip h.pos hflip hm
  -- the direction `0`: clause (ii), with `Y` read as "not `X`" near `ψ`
  have zero : ∀ η : ℝ, 0 < η →
      0 < volume (liftPalette c hc p X ∩ Ioo (ψ + ((0 : ℤ) : ℝ) * (π / 3) - η) (ψ + ((0 : ℤ) : ℝ) * (π / 3) + η)) ∧
      0 < volume ((liftPalette c hc p X)ᶜ ∩
        Ioo (ψ + ((0 : ℤ) : ℝ) * (π / 3) - η) (ψ + ((0 : ℤ) : ℝ) * (π / 3) + η)) := by
    intro η hη
    rw [Int.cast_zero, zero_mul, add_zero]
    constructor
    · refine (h.change η hη).1.trans_le (measure_mono fun θ hθ => ?_)
      exact ⟨(mem_liftPalette c hc p X θ).mpr hθ.2, hθ.1⟩
    · refine (h.change (min η δ) (lt_min hη h.pos)).2.trans_le (measure_mono_ae ?_)
      filter_upwards [h.ae_iff_not hw 0] with θ hθ hmem
      obtain ⟨hI, hY⟩ := hmem
      have hlt : |θ - ψ - ((0 : ℤ) : ℝ) * (π / 3)| < δ := by
        rw [Int.cast_zero, zero_mul, sub_zero, abs_lt]
        constructor <;> linarith [hI.1, hI.2, min_le_right η δ]
      exact ⟨(hθ hlt).mp ((mem_liftPalette c hc p Y θ).mpr hY),
        by linarith [hI.1, min_le_left η δ], by linarith [hI.2, min_le_left η δ]⟩
  induction m using Int.induction_on with
  | zero => exact zero
  | succ i ih => exact up i ih
  | pred i ih => exact down (-i) ih

/-- **M2, (⋆)** ("for almost every `(α, d)` with `Z(α, d) ∈ N_k(κ)`: `c(Z(α, d)) ∉ {s(α), s(α − d)}`", for
`κ ≤ δ/2`), with the state as a set: for almost every `(α, d)` with `|α − ψ_{n+1}| < δ/2` and `|d| < δ/2`, the colour
at `chart p α d` is not `X` if `α` or `α − d` is in the state, and not `Y` if `α` or `α − d` is outside it. From
`palette_transfer_pair` at the pair of directions `(α, α − 2π/3 − d)` and M1 (the state at `α − 2π/3 − d` is the
state at `α − d`). -/
theorem OutsideOrbit.chart_avoids (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
    ∀ᵐ x : ℝ × ℝ, |x.1 - (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3))| < δ / 2 → |x.2| < δ / 2 →
      (x.1 ∈ liftPalette c hc p X ∨ x.1 - x.2 ∈ liftPalette c hc p X → c (chart p x.1 x.2) ≠ X) ∧
      (x.1 ∉ liftPalette c hc p X ∨ x.1 - x.2 ∉ liftPalette c hc p X → c (chart p x.1 x.2) ≠ Y) := by
  -- the transfer of palettes for a pair, in the chart: the colour avoids both palettes
  have hT : ∀ᵐ x : ℝ × ℝ, ∀ i : Fin k,
      (x.1 ∈ liftPalette c hc p i → c (chart p x.1 x.2) ≠ i) ∧
      (x.1 - 2 * π / 3 - x.2 ∈ liftPalette c hc p i → c (chart p x.1 x.2) ≠ i) := by
    filter_upwards [chartAngles_quasiMeasurePreserving.ae (palette_transfer_pair c hc hw p)] with x hx i
    rw [← chart_eq_angularSum, Finset.mem_union, not_or] at hx
    exact ⟨fun hi hci => hx.1 (hci ▸ (mem_liftPalette c hc p i x.1).mp hi),
      fun hi hci => hx.2 (hci ▸ (mem_liftPalette c hc p i _).mp hi)⟩
  -- two flips: near the direction `n − 1` the state at `θ + 2π/3` is the state at `θ`
  have hF : ∀ᵐ θ : ℝ, |θ - ψ - ((n - 1 : ℤ) : ℝ) * (π / 3)| < δ →
      (θ + π / 3 + π / 3 ∈ liftPalette c hc p X ↔ θ ∈ liftPalette c hc p X) := by
    have h2 := (measurePreserving_add_right volume (π / 3)).quasiMeasurePreserving.ae (h.ae_flip hw n)
    filter_upwards [h.ae_flip hw (n - 1), h2] with θ h1 h2 hlt
    have e : θ + π / 3 - ψ - (n : ℝ) * (π / 3) = θ - ψ - ((n - 1 : ℤ) : ℝ) * (π / 3) := by
      push_cast
      ring
    rw [h2 (by rw [e]; exact hlt), h1 hlt, not_not]
  -- the three almost-everywhere statements about angles, pulled back to the parameter plane
  have hpair : Measure.QuasiMeasurePreserving (fun x : ℝ × ℝ => x.1 - 2 * π / 3 - x.2) volume volume :=
    QuasiMeasurePreserving.prod_of_right ((measurable_fst.sub measurable_const).sub measurable_snd)
      (ae_of_all _ fun a => (Measure.measurePreserving_sub_left volume (a - 2 * π / 3)).quasiMeasurePreserving)
  have hF' := hpair.ae hF
  have hO1 := hpair.ae (h.ae_mem_or (n - 1))
  have hO2 := (Measure.quasiMeasurePreserving_fst (μ := (volume : Measure ℝ)) (ν := (volume : Measure ℝ))).ae
    (h.ae_mem_or (n + 1))
  filter_upwards [hT, hF', hO1, hO2] with x hT hF hO1 hO2 hx1 hx2
  rw [abs_lt] at hx1 hx2
  -- the second ring direction is within `δ` of the direction `n − 1`
  have hlt : |x.1 - 2 * π / 3 - x.2 - ψ - ((n - 1 : ℤ) : ℝ) * (π / 3)| < δ := by
    have e : x.1 - 2 * π / 3 - x.2 - ψ - ((n - 1 : ℤ) : ℝ) * (π / 3) =
        x.1 - (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3)) - x.2 := by
      push_cast
      ring
    rw [e, abs_lt]
    constructor <;> linarith [hx1.1, hx1.2, hx2.1, hx2.2]
  have hlt' : |x.1 - ψ - ((n + 1 : ℤ) : ℝ) * (π / 3)| < δ := by
    rw [sub_sub, abs_lt]
    constructor <;> linarith [hx1.1, hx1.2, h.pos]
  have hsame : x.1 - x.2 ∈ liftPalette c hc p X ↔ x.1 - 2 * π / 3 - x.2 ∈ liftPalette c hc p X := by
    have e : x.1 - 2 * π / 3 - x.2 + π / 3 + π / 3 = x.1 - x.2 := by ring
    have h3 := hF hlt
    rwa [e] at h3
  constructor
  · rintro (hα | hαd)
    · exact (hT X).1 hα
    · exact (hT X).2 (hsame.mp hαd)
  · rintro (hα | hαd)
    · exact (hT Y).1 ((hO2 hlt').resolve_left hα)
    · exact (hT Y).2 ((hO1 hlt).resolve_left fun h4 => hαd (hsame.mpr h4))

/-- **M5, "almost every point of `B(0, 1) ∩ N_k(κ_*)` carries `a_{τ(k)}`, `X` or `Y`"**, for any set `T` of labels:
if no label outside `T` tips the hub `y_n`, then on some box about `(ψ_{n+1}, 0)`, inside the ring, almost every chart
point has its colour in `T`. From `ae_ne_of_not_isTip` for each label outside `T`; the labels are finitely many. -/
theorem ae_chart_colour_mem {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) {p : ℂ} {ψ : ℝ} {n : ℤ} {T : Set (Fin k)}
    (h : ∀ i, i ∉ T → ¬ IsTip c p (hub p ψ n) i) :
    ∃ κ : ℝ, 0 < κ ∧ ∀ᵐ x : ℝ × ℝ, |x.1 - (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3))| < κ → 0 < x.2 → x.2 < κ →
      c (chart p x.1 x.2) ∈ T := by
  have hex : ∀ i : Fin k, ∃ κ : ℝ, 0 < κ ∧ ∀ᵐ x : ℝ × ℝ,
      |x.1 - (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3))| < κ → 0 < x.2 → x.2 < κ → i ∉ T → c (chart p x.1 x.2) ≠ i := by
    intro i
    by_cases hi : i ∈ T
    · exact ⟨1, one_pos, Filter.Eventually.of_forall fun _ _ _ _ hn => (hn hi).elim⟩
    · obtain ⟨κ, hκ, hae⟩ := ae_ne_of_not_isTip hc (h i hi)
      exact ⟨κ, hκ, hae.mono fun _ hx h1 h2 h3 _ => hx h1 h2 h3⟩
  choose κ hκ hae using hex
  obtain ⟨κ₀, hκ₀, hle⟩ := exists_pos_forall_le hκ
  refine ⟨κ₀, hκ₀, ?_⟩
  filter_upwards [ae_all_iff.mpr hae] with x hx h1 h2 h3
  by_contra hT
  exact hx (c (chart p x.1 x.2)) (h1.trans_le (hle _)) h2 (h3.trans_le (hle _)) hT rfl

/-- **M3, every hub has a tip** ("So some inner label has positive measure in `W_k(κ)` for every `κ`. … `Tip(k)` …
is non-empty"): under the ring hypothesis, at every hub some label other than `X` and `Y` tips. For any number of
labels: that the tip is one of the cycle's four is where six is spent (`exists_cycle_label`).

A step inside a proof by contradiction at six labels (`no_outside_orbit_points` refutes the hypotheses given a
four-cycle of exclusions); the remark on models at `OutsideOrbit` applies. -/
theorem exists_tip (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) :
    ∃ i, i ≠ X ∧ i ≠ Y ∧ IsTip c p (hub p ψ n) i := by
  by_contra hno
  have hno' : ∀ i, i ∉ ({X, Y} : Set (Fin k)) → ¬ IsTip c p (hub p ψ n) i := fun i hi ht =>
    hno ⟨i, fun hX => hi (Or.inl hX), fun hY => hi (Or.inr hY), ht⟩
  obtain ⟨κ, hκ, hae⟩ := ae_chart_colour_mem hc hno'
  have hpos := volume_change_pairs_pos (h.change_at hw (n + 1)) (lt_min hκ (half_pos h.pos))
  refine hpos.ne' (measure_eq_zero_iff_ae_notMem.mpr ?_)
  filter_upwards [hae, h.chart_avoids hw n] with x h1 h2 hx
  obtain ⟨hx1, hx2, hx3, hx4⟩ := hx
  have hcol := h1 (hx1.trans_le (min_le_left _ _)) hx2 (hx3.trans_le (min_le_left _ _))
  obtain ⟨hnX, hnY⟩ := h2 (hx1.trans_le (min_le_right _ _))
    (by rw [abs_of_pos hx2]; exact hx3.trans_le (min_le_right _ _))
  by_cases hα : x.1 ∈ liftPalette c hc p X
  · rcases hcol with hc' | hc'
    · exact hnX (Or.inl hα) hc'
    · exact hnY (Or.inr (hx4.mp hα)) hc'
  · rcases hcol with hc' | hc'
    · exact hnX (Or.inr (by_contra fun h3 => hα (hx4.mpr h3))) hc'
    · exact hnY (Or.inl hα) hc'

/-- **M5's last sentence with (⋆), at the hub `y_n`** ("almost every point of `B(0, 1) ∩ N_k(κ_*)` carries
`a_{τ(k)}`, `X` or `Y`"): if no label other than `b`, `X`, `Y` tips the hub `y_n`, then on some box about
`(ψ_{n+1}, 0)` the colouring is as `HubColours` says, for the state. From `chart_avoids` and
`ae_ne_of_not_isTip`. -/
theorem OutsideOrbit.hubColours (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ) {b : Fin k}
    (hnt : ∀ i, i ≠ b → i ≠ X → i ≠ Y → ¬ IsTip c p (hub p ψ n) i) :
    ∃ κ : ℝ, 0 < κ ∧
      HubColours c p b X Y (liftPalette c hc p X) (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3)) κ := by
  have hnt' : ∀ i, i ∉ ({b, X, Y} : Set (Fin k)) → ¬ IsTip c p (hub p ψ n) i := fun i hi =>
    hnt i (fun hb => hi (Or.inl hb)) (fun hX => hi (Or.inr (Or.inl hX))) (fun hY => hi (Or.inr (Or.inr hY)))
  obtain ⟨κ, hκ, hae⟩ := ae_chart_colour_mem hc hnt'
  refine ⟨min κ (δ / 2), lt_min hκ (half_pos h.pos), ?_⟩
  filter_upwards [hae, h.chart_avoids hw n] with x h1 h2 hx1 hx2 hx3
  exact ⟨h1 (hx1.trans_le (min_le_left _ _)) hx2 (hx3.trans_le (min_le_left _ _)),
    h2 (hx1.trans_le (min_le_right _ _)) (by rw [abs_of_pos hx2]; exact hx3.trans_le (min_le_right _ _))⟩

/-- **The same at the next hub `y_{n+1}`, read through the flip** (M7's "the second line shifts both arguments by
`−π/3`, which flips both values"): the chart is centred at `ψ_{n+1} + π/3`, and an angle `θ` there is in the state
exactly when `θ − π/3` is not. -/
theorem OutsideOrbit.hubColours_flip (h : OutsideOrbit c hc p X Y ψ δ) (hw : WeakColoring k c) (n : ℤ)
    {b : Fin k} (hnt : ∀ i, i ≠ b → i ≠ X → i ≠ Y → ¬ IsTip c p (hub p ψ (n + 1)) i) :
    ∃ κ : ℝ, 0 < κ ∧
      HubColours c p b X Y {θ : ℝ | θ - π / 3 ∉ liftPalette c hc p X}
        (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3) + π / 3) κ := by
  obtain ⟨κ, hκ, hH⟩ := h.hubColours hw (n + 1) hnt
  have ecentre : ψ + ((n + 1 + 1 : ℤ) : ℝ) * (π / 3) = ψ + ((n + 1 : ℤ) : ℝ) * (π / 3) + π / 3 := by
    push_cast
    ring
  rw [ecentre] at hH
  -- near the centre of this chart, an angle is in the flipped set exactly when it is in the state
  have hflip : ∀ᵐ θ : ℝ, |θ - (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3) + π / 3)| < δ →
      (θ ∈ {θ : ℝ | θ - π / 3 ∉ liftPalette c hc p X} ↔ θ ∈ liftPalette c hc p X) := by
    have h1 := (measurePreserving_add_right volume (-(π / 3))).quasiMeasurePreserving.ae (h.ae_flip hw (n + 1))
    filter_upwards [h1] with θ hθ hlt
    have e1 : θ + -(π / 3) - ψ - ((n + 1 : ℤ) : ℝ) * (π / 3) =
        θ - (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3) + π / 3) := by ring
    have h2 := hθ (by rw [e1]; exact hlt)
    rw [neg_add_cancel_right, ← sub_eq_add_neg] at h2
    exact h2.symm
  have hf1 := (Measure.quasiMeasurePreserving_fst (μ := (volume : Measure ℝ)) (ν := (volume : Measure ℝ))).ae hflip
  have hsub : Measure.QuasiMeasurePreserving (fun x : ℝ × ℝ => x.1 - x.2) volume volume :=
    QuasiMeasurePreserving.prod_of_right (measurable_fst.sub measurable_snd)
      (ae_of_all _ fun a => (Measure.measurePreserving_sub_left volume a).quasiMeasurePreserving)
  have hf2 := hsub.ae hflip
  refine ⟨min κ (δ / 2), lt_min hκ (half_pos h.pos), ?_⟩
  filter_upwards [hH, hf1, hf2] with x hx hf1 hf2 hx1 hx2 hx3
  have hκ1 : |x.1 - (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3) + π / 3)| < κ := hx1.trans_le (min_le_left _ _)
  have hδ1 : |x.1 - (ψ + ((n + 1 : ℤ) : ℝ) * (π / 3) + π / 3)| < δ / 2 := hx1.trans_le (min_le_right _ _)
  have hδ2 : x.2 < δ / 2 := hx3.trans_le (min_le_right _ _)
  obtain ⟨hcol, hnX, hnY⟩ := hx hκ1 hx2 (hx3.trans_le (min_le_left _ _))
  rw [abs_lt] at hδ1
  have e1 := hf1 (by rw [abs_lt]; constructor <;> linarith [hδ1.1, hδ1.2, h.pos])
  have e2 := hf2 (by rw [abs_lt]; constructor <;> linarith [hδ1.1, hδ1.2, h.pos])
  refine ⟨hcol, fun hS => hnX (hS.imp e1.mp e2.mp), fun hS => hnY (hS.imp ?_ ?_)⟩
  · exact fun h3 h4 => h3 (e1.mpr h4)
  · exact fun h3 h4 => h3 (e2.mpr h4)

end HadwigerNelson.SixRing
