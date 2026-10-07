import Proofs.HadwigerNelson.Plane.SixRing.NullSets
import Proofs.HadwigerNelson.Outside.OAI158PaletteTransport

/-!
# A ring filled by two labels changes somewhere (FS-132, C132-M-EXCL's reduction)

The derivation's "Argument — the ring form": if almost every palette at `p` holds `X` or `Y`, some angle has both in
positive measure in each of its neighbourhoods. With `ae_real_of_ae_angles` (a statement almost everywhere on the
circle of angles holds for almost every real angle) this turns the hypothesis of C132-M-EXCL into that of
C132-M-ORBIT. For a colouring of the whole plane; any number of labels.

Both leaves are proved (job FS132-I4): `ae_real_of_ae_angles` is the release's `angleMk_quasiMeasurePreserving`;
`exists_change_of_ae_outside` stands on the release's `palette_sixty_real` (the rotation by `π/3` moves a label out of
the palette, on the line) and on `exists_inter_pos_of_ae_union` (`Plane/SixRing/NullSets`: connectedness of the line).
-/

open MeasureTheory

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-- A statement almost everywhere on the circle of angles holds for almost every real angle. -/
theorem ae_real_of_ae_angles {P : Angles → Prop} (h : ∀ᵐ t ∂angularMeasure, P t) : ∀ᵐ θ : ℝ, P (θ : Angles) :=
  angleMk_quasiMeasurePreserving.ae h

/-- For a weak colouring, a label whose palette set, with that of a second label, covers almost every angle is in
the palette on a set of angles of positive measure: were it null, the second label would be in almost every palette,
against the rotation by `π/3` (`palette_sixty_real`). A step inside a proof by contradiction: whether a weak colouring
has two labels satisfying `h` is not known to this library at any `k` (at six labels, with a four-cycle of
exclusions, `not_ae_outside` refutes it); `WeakColoring` is inhabited at `k = 7` (`proper_to_borel_weak_model`). -/
theorem volume_liftPalette_ne_zero {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ)
    {i j : Fin k} (h : ∀ᵐ θ : ℝ, θ ∈ liftPalette c hc p i ∨ θ ∈ liftPalette c hc p j) :
    volume (liftPalette c hc p i) ≠ 0 := by
  intro h0
  have hnot : ∀ᵐ θ : ℝ, θ ∉ liftPalette c hc p i := measure_eq_zero_iff_ae_notMem.mp h0
  have hj : ∀ᵐ θ : ℝ, θ ∈ liftPalette c hc p j := by
    filter_upwards [h, hnot] with θ h1 h2 using h1.resolve_left h2
  have hj' : ∀ᵐ θ : ℝ, θ + sixty ∈ liftPalette c hc p j :=
    (measurePreserving_add_right volume (sixty : ℝ)).quasiMeasurePreserving.ae hj
  have hfalse : ∀ᵐ _ : ℝ, False := by
    filter_upwards [hj, hj', palette_sixty_real c hc hw p j] with θ h1 h2 h3 using h3 h1 h2
  exact hfalse.exists.elim fun _ hf => hf

/-- **A ring filled by two labels has an orbit of the kind C132-M-ORBIT refutes** (no four-cycle enters): if almost
every palette at `p` contains `X` or `Y`, there is an angle `ψ` every neighbourhood of which holds both, in positive
measure. ("The set of `θ` near which `s` is almost everywhere constant is open; were it the whole circle, `s` would
be almost everywhere constant by connectedness", against the flip under `π/3`.) The two labels need not be
different: with `X = Y` the hypothesis is already contradictory (`volume_liftPalette_ne_zero`). -/
theorem exists_change_of_ae_outside {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ)
    {X Y : Fin k}
    (h : ∀ᵐ t ∂angularMeasure, X ∈ palette c hc p t ∨ Y ∈ palette c hc p t) :
    ∃ ψ : ℝ, ∀ η : ℝ, 0 < η →
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ X ∈ palette c hc p (θ : Angles)} ∧
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ Y ∈ palette c hc p (θ : Angles)} := by
  have hAB : ∀ᵐ θ : ℝ, θ ∈ liftPalette c hc p X ∨ θ ∈ liftPalette c hc p Y := by
    filter_upwards [ae_real_of_ae_angles h] with θ hθ
    simpa only [liftPalette, Set.mem_preimage, mem_palette] using hθ
  obtain ⟨ψ, hψ⟩ := exists_inter_pos_of_ae_union hAB (volume_liftPalette_ne_zero hc hw p hAB)
    (volume_liftPalette_ne_zero hc hw p (hAB.mono fun _ h => h.symm))
  refine ⟨ψ, fun η hη => ?_⟩
  have e : ∀ i : Fin k, {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ i ∈ palette c hc p (θ : Angles)} =
      liftPalette c hc p i ∩ Set.Ioo (ψ - η) (ψ + η) := by
    intro i
    ext θ
    simp only [Set.mem_setOf_eq, Set.mem_inter_iff, liftPalette, Set.mem_preimage, mem_palette]
    exact and_comm
  rw [e X, e Y]
  exact hψ η hη

end HadwigerNelson.SixRing
