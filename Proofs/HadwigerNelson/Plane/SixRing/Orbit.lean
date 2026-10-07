import Proofs.HadwigerNelson.Plane.SixRing.Confine

/-!
# The ring of a four-cycle of straddle exclusions at six labels (FS-132: C132-M-ORBIT, C132-M-EXCL, C132-DIAG-WIDE) — SKELETON

For a weak measurable six-colouring `c` of the plane (the release's `WeakColoring 6 c`, with `c` measurable) and a
centre `p`, the *ring* is the palette `palette c hc p t` (`[OAIMath2026]` Definition 5.1) as a function of the
direction `t`. Stated for the whole plane, the instance `U = ℂ` of each claim (the claim list's dated line,
2026-10-07): the release's statements they stand on are for the whole plane.

* `no_alternating_pairs` (C132-DIAG-WIDE): the ring is not two disjoint pairs alternating under the rotation by
  `π/3`. An instance of the release's `two_state_impossible` (`States.lean:243`, every `k`), which is
  `no_alternating_groups` here.
* `no_outside_orbit` (C132-M-ORBIT) and `not_ae_outside` (C132-M-EXCL): with four compact sets through `p` whose
  straddle regions exclude the consecutive pairs of a cycle of four labels, the two labels outside the cycle do not
  fill the ring near a rotation orbit at which they change, and so do not fill the ring.

**Status: skeleton.** The statements tagged OUTSIDE are the release's, verbatim over the copied definitions; here
each is a `sorry`, to be declared an outside theorem in the import's form or ported (`plans/FS132-kernel-plan.md`).
**The proof of `no_outside_orbit` is open in the planner's blind phase past its first-order steps** (the plan's
stage 2): no leaf below it is stated yet.
-/

open MeasureTheory Filter Topology

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-! ## The release's statements this module stands on (OUTSIDE; placeholders) -/

/-- **OUTSIDE** — `[OAIMath2026]` `PaletteDensity.lean:143`, `palette_transfer_pair` (the manuscript's Lemma 5.2 (1)):
at a fixed centre, for almost every pair of directions, the colour at the sum avoids both palettes. -/
theorem palette_transfer_pair {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c) (hw : WeakColoring k c) (x : ℂ) :
    ∀ᵐ p ∂angularMeasure.prod angularMeasure,
      c (angularSum x 1 p) ∉ palette c hc x p.1 ∪ palette c hc x p.2 := by
  sorry

/-- **OUTSIDE** — `[OAIMath2026]` `PaletteTransport.lean:450`, `palette_sixty_disjoint` (Corollary 5.3): the palettes
at `f` and at `f` rotated by `π/3` are disjoint, for almost every `f`. -/
theorem palette_sixty_disjoint {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c) (hw : WeakColoring k c) (x : ℂ) :
    ∀ᵐ f ∂angularMeasure, Disjoint (palette c hc x f) (palette c hc x (f + (sixty : Angles))) := by
  sorry

/-- **OUTSIDE** — `[OAIMath2026]` `BoundaryTrace.lean:182`, `outer_strip_trace` (inside Lemma 8.1): if an open set
carrying only the labels of `J` contains a strip just outside the unit circle about `x` near the direction `t`, the
palettes near `t` meet `J`. -/
theorem outer_strip_trace {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c) {x : ℂ} {t : Angles} {δ : ℝ} (hδ : 0 < δ)
    {W : Set ℂ} (ho : IsOpen W) {J : Finset (Fin k)} (hW : ∀ᵐ z : ℂ ∂volume, z ∈ W → c z ∈ J)
    (hstrip : ∀ u : Angles, dist (direction u) (direction t) < δ → ∀ r : ℝ,
      1 < r → r < 1 + δ → x + (r : ℂ) * direction u ∈ W) :
    ∃ U : Set Angles, IsOpen U ∧ t ∈ U ∧ ∀ᵐ u ∂angularMeasure, u ∈ U → (palette c hc x u ∩ J).Nonempty := by
  sorry

/-- **OUTSIDE** — `[OAIMath2026]` `BoundaryTrace.lean:210`, `inner_strip_trace`: the same just inside the unit
circle. -/
theorem inner_strip_trace {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c) {x : ℂ} {t : Angles} {δ : ℝ} (hδ : 0 < δ)
    {W : Set ℂ} (ho : IsOpen W) {J : Finset (Fin k)} (hW : ∀ᵐ z : ℂ ∂volume, z ∈ W → c z ∈ J)
    (hstrip : ∀ u : Angles, dist (direction u) (direction t) < δ → ∀ r : ℝ,
      0 < r → 1 - δ < r → r < 1 → x + (r : ℂ) * direction u ∈ W) :
    ∃ U : Set Angles, IsOpen U ∧ t ∈ U ∧ ∀ᵐ u ∂angularMeasure, u ∈ U → (palette c hc x u ∩ J).Nonempty := by
  sorry

/-- **OUTSIDE** — `[OAIMath2026]` `States.lean:243`, `two_state_impossible` (the manuscript's Lemma 6.4, there at five
labels for a singleton and a pair; in the release's Lean for every `k` and any two label sets whose complement has
at most two labels): no measurable two-valued state, representing `J` and `K` inside the palette, flips under the
rotation by `π/3`. -/
theorem two_state_impossible {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c)
    (x : ℂ) (J K : Finset (Fin k)) (hcard : (Finset.univ \ (J ∪ K)).card ≤ 2)
    (s : Angles → Bool) (hs : Measurable s)
    (hJ : RealState hc x {t : ℝ | s (t : Angles) = false} J)
    (hK : RealState hc x {t : ℝ | s (t : Angles) = true} K)
    (hflip : ∀ᵐ t ∂angularMeasure, s (t + (Real.pi / 3 : ℝ)) = !(s t)) : False := by
  sorry

/-! ## C132-DIAG-WIDE -/

/-- **C132-DIAG-WIDE at its class**: for every number of labels `k` and any two label sets `J`, `K` whose complement
has at most two labels, no measurable `w` from the circle to `{J, K}` has `w(e)` inside the palette and
`w(Re) ≠ w(e)` almost everywhere. The release's `two_state_impossible` in palette form. Where the hypotheses can
hold: nowhere, by this theorem, when `WeakColoring k c` does (`k = 7`: `proper_to_borel_weak_model`); with three or
more labels outside `J ∪ K` the statement is not claimed. -/
theorem no_alternating_groups {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ)
    {J K : Finset (Fin k)} (hcard : (Finset.univ \ (J ∪ K)).card ≤ 2)
    (w : Angles → Bool) (hwm : Measurable w)
    (hsub : ∀ᵐ t ∂angularMeasure, (if w t then K else J) ⊆ palette c hc p t)
    (halt : ∀ᵐ t ∂angularMeasure, w (t + (sixty : Angles)) ≠ w t) : False := by
  sorry

/-- **C132-DIAG-WIDE** (the instance `U = ℂ`): for a weak measurable six-colouring of the plane, a centre `p` and two
disjoint pairs of labels `D`, `D'`, there is no measurable map `w` from the circle to `{D, D'}` (`false ↦ D`,
`true ↦ D'`) with `w(e) ⊆ P_p(e)` and `w(Re) ≠ w(e)` for almost every direction. Whether a weak six-colouring of the
plane exists is the open question (`χ(ℝ²) = 6` or `7`); at `k = 7` (`proper_to_borel_weak_model`) two disjoint
pairs leave three labels outside and the statement is not claimed. -/
theorem no_alternating_pairs {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) (p : ℂ)
    {D D' : Finset (Fin 6)} (hD : D.card = 2) (hD' : D'.card = 2) (hdisj : Disjoint D D')
    (w : Angles → Bool) (hwm : Measurable w)
    (hsub : ∀ᵐ t ∂angularMeasure, (if w t then D' else D) ⊆ palette c hc p t)
    (halt : ∀ᵐ t ∂angularMeasure, w (t + (sixty : Angles)) ≠ w t) : False := by
  sorry

/-! ## C132-M-ORBIT and C132-M-EXCL -/

/-- The hypothesis of C132-M-ORBIT on the four sets: for each `j` modulo `4`, `K j` is compact, contains `p` and a
point other than `p`, and its straddle region misses the closed essential supports of the labels `a j` and
`a (j + 1)`. **As typed in the claim, `K j` need not be connected and need not approach `p`** (`{p, q}` qualifies).
An object satisfying it (with a colouring that is not a weak six-colouring): `c` constant `X`, any `K`. -/
structure FourCycleStraddle (c : ℂ → Fin 6) (p : ℂ) (a : Fin 4 → Fin 6) (K : Fin 4 → Set ℂ) : Prop where
  /-- Each set is compact. -/
  compact : ∀ j, IsCompact (K j)
  /-- Each set contains the centre. -/
  centre_mem : ∀ j, p ∈ K j
  /-- Each set contains a point other than the centre. -/
  other : ∀ j, ∃ q ∈ K j, q ≠ p
  /-- The straddle region of `K j` misses the essential support of the label `a j`. -/
  left : ∀ j, Disjoint (spatialSupport c (a j)) (Straddle (K j))
  /-- The straddle region of `K j` misses the essential support of the label `a (j + 1)`. -/
  right : ∀ j, Disjoint (spatialSupport c (a (j + 1))) (Straddle (K j))

/-- **C132-M-ORBIT** (the instance `U = ℂ`). Let `c` be a weak measurable six-colouring of the plane, `a 0, …, a 3`
four of the labels and `X`, `Y` the other two, and `K` four sets as in `FourCycleStraddle`. Then there are no angle
`ψ` and number `δ > 0` such that (i) for every integer `k` and almost every `θ` with `|θ − ψ − kπ/3| < δ` the palette
at `p` in the direction `θ` contains `X` or `Y`, and (ii) for every `η > 0` the `θ` in `(ψ − η, ψ + η)` whose palette
contains `X`, and those whose palette contains `Y`, both have positive measure.

A refutation. Whether its first hypothesis can hold is the open question (`χ(ℝ²) = 6` or `7`: a weak six-colouring
of the plane exists exactly when the plane is six-colourable, `Outside.OAI158.colorable_iff_nonempty_aeColouring`);
the hexagonal seven-colouring satisfies the analogous local hypotheses at a point where three tiles meet and fails
"six". **Open in the planner's blind phase** (`plans/FS132-kernel-plan.md` stage 2). -/
theorem no_outside_orbit {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) {p : ℂ}
    {a : Fin 4 → Fin 6} (ha : Function.Injective a) {X Y : Fin 6} (hXY : X ≠ Y)
    (hX : ∀ j, a j ≠ X) (hY : ∀ j, a j ≠ Y) {K : Fin 4 → Set ℂ} (hK : FourCycleStraddle c p a K)
    (ψ δ : ℝ) (hδ : 0 < δ)
    (hi : ∀ k : ℤ, ∀ᵐ θ : ℝ, |θ - ψ - k * (Real.pi / 3)| < δ →
      X ∈ palette c hc p (θ : Angles) ∨ Y ∈ palette c hc p (θ : Angles))
    (hii : ∀ η : ℝ, 0 < η →
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ X ∈ palette c hc p (θ : Angles)} ∧
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ Y ∈ palette c hc p (θ : Angles)}) : False := by
  sorry

/-- **A ring filled by two labels has an orbit of the kind C132-M-ORBIT refutes** (no four-cycle enters): if almost
every palette at `p` contains `X` or `Y`, there is an angle `ψ` every neighbourhood of which holds both, in positive
measure. The planner's reduction of C132-M-EXCL to C132-M-ORBIT. -/
theorem exists_change_of_ae_outside {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c) (p : ℂ)
    {X Y : Fin k} (hXY : X ≠ Y)
    (h : ∀ᵐ t ∂angularMeasure, X ∈ palette c hc p t ∨ Y ∈ palette c hc p t) :
    ∃ ψ : ℝ, ∀ η : ℝ, 0 < η →
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ X ∈ palette c hc p (θ : Angles)} ∧
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ Y ∈ palette c hc p (θ : Angles)} := by
  sorry

/-- A statement almost everywhere on the circle of angles holds for almost every real angle. -/
theorem ae_real_of_ae_angles {P : Angles → Prop} (h : ∀ᵐ t ∂angularMeasure, P t) : ∀ᵐ θ : ℝ, P (θ : Angles) := by
  sorry

/-- **C132-M-EXCL** (the instance `U = ℂ`): with the colouring, the labels and the four sets of C132-M-ORBIT, it is
not the case that for almost every direction the palette at `p` contains `X` or `Y`. From `no_outside_orbit` at the
angle `exists_change_of_ae_outside` gives. The remark on models at `no_outside_orbit` applies. -/
theorem not_ae_outside {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) {p : ℂ}
    {a : Fin 4 → Fin 6} (ha : Function.Injective a) {X Y : Fin 6} (hXY : X ≠ Y)
    (hX : ∀ j, a j ≠ X) (hY : ∀ j, a j ≠ Y) {K : Fin 4 → Set ℂ} (hK : FourCycleStraddle c p a K) :
    ¬ ∀ᵐ t ∂angularMeasure, X ∈ palette c hc p t ∨ Y ∈ palette c hc p t := by
  intro h
  obtain ⟨ψ, hψ⟩ := exists_change_of_ae_outside hc hw p hXY h
  exact no_outside_orbit hc hw ha hXY hX hY hK ψ 1 one_pos
    (fun _ => (ae_real_of_ae_angles h).mono fun _ hθ _ => hθ) hψ

end HadwigerNelson.SixRing
