import Proofs.HadwigerNelson.Plane.SixRing.State
import Proofs.HadwigerNelson.Plane.SixRing.Tips
import Proofs.HadwigerNelson.Plane.SixRing.Kill
import Proofs.HadwigerNelson.Plane.SixRing.Excl

/-!
# The ring of a four-cycle of straddle exclusions at six labels (FS-132: C132-M-ORBIT, C132-M-EXCL) — the assembly

For a weak measurable six-colouring `c` of **the whole plane** (the release's `WeakColoring 6 c`, with `c`
measurable) and a centre `p`, the *ring* is the palette `palette c hc p t` (`[OAIMath2026]` Definition 5.1) as a
function of the direction `t`. Stated for the whole plane, the instance `U = ℂ` of each claim (the claim list's
dated line, 2026-10-07); the form for an open set containing the closed unit disc is a later statement.

* `no_outside_orbit_points` (C132-M-ORBIT over four points — the derivers' C132-WIT-ORBIT) and `no_outside_orbit`
  (C132-M-ORBIT): with four points, or four compact sets, through `p` whose straddle regions exclude the
  consecutive pairs of a cycle of four labels, the two labels outside the cycle do not fill the ring near a rotation
  orbit at which they change.
* `not_ae_outside` (C132-M-EXCL): so they do not fill the ring.

**This module has no `sorry` of its own.** Every theorem here is proved from the leaves of the modules it imports —
`State` (steps M1–M3), `Tips` (M4–M6), `Kill` (M7–M9, through `Shift`, `StepLemma`, `ChartMeasure`), `Excl` — which
are `sorry` until implemented; the plan per leaf is `plans/FS132-kernel-plan.md` stage 5.
-/

open MeasureTheory Filter Topology

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-- **No label is the only tip at two adjacent hubs** (the derivation's V6-HUG restated: steps M7–M9, with M2 and
M5's last sentence for the two hubs): under the ring hypothesis, there are no index `n` and label `b` such that
every label other than `b`, `X`, `Y` fails to tip both `y_n` and `y_{n+1}`. For any number of labels: the count is
spent by the caller, who must show that the other labels do not tip.

A refutation; the remarks on models at `OutsideOrbit` and `chart_step_false` apply. -/
theorem adjacent_tip_false {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c) {p : ℂ}
    {X Y : Fin k} {ψ δ : ℝ} (h : OutsideOrbit c hc p X Y ψ δ) (n : ℤ) {b : Fin k}
    (h0 : ∀ i, i ≠ b → i ≠ X → i ≠ Y → ¬ IsTip c p (hub p ψ n) i)
    (h1 : ∀ i, i ≠ b → i ≠ X → i ≠ Y → ¬ IsTip c p (hub p ψ (n + 1)) i) : False := by
  obtain ⟨κ₀, hκ₀, hc0⟩ := h.hubColours hw n h0
  obtain ⟨κ₁, hκ₁, hc1⟩ := h.hubColours_flip hw n h1
  exact chart_step_false hc hw p (measurableSet_liftPalette c hc p X) (lt_min hκ₀ hκ₁)
    (h.change_at hw (n + 1)) (hc0.mono (min_le_left _ _)) (hc1.mono (min_le_right _ _))

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

/-- The straddle region grows with the set. -/
theorem straddle_mono {K L : Set ℂ} (h : K ⊆ L) : Straddle K ⊆ Straddle L :=
  fun _ ⟨p, hp, q, hq, h1, h2⟩ => ⟨p, h hp, q, h hq, h1, h2⟩

/-- **C132-M-ORBIT over four points** (the derivers' C132-WIT-ORBIT, `plans/FS132-derivation.md` § 1; the instance
`U = ℂ`, **the whole plane**): let `c` be a weak measurable six-colouring of the plane, `a 0, …, a 3` four of the
labels and `X`, `Y` the other two, and for each `j` modulo `4` let `q j` be a point other than `p` such that the
straddle region of `{p, q j}` misses the closed essential supports of `a j` and of `a (j + 1)`. Then there are no
angle `ψ` and number `δ > 0` such that (i) for every integer `k` and almost every `θ` with `|θ − ψ − kπ/3| < δ` the
palette at `p` in the direction `θ` contains `X` or `Y`, and (ii) for every `η > 0` the `θ` in `(ψ − η, ψ + η)`
whose palette contains `X`, and those whose palette contains `Y`, both have positive measure.

The assembly of the derivation's steps (`plans/FS132-E3-derivation.md`, Stage 3): every hub has a tip among the four
labels (M1–M3, `exists_tip`; six is spent in `exists_cycle_label`); the tip at a hub is one label (M4–M5,
`tip_unique`); two adjacent hubs have the same tip (M6, `exists_adjacent_tips`); and no label is the only tip at
two adjacent hubs (M7–M9, `adjacent_tip_false`).

A refutation. Whether its first hypothesis can hold is the open question (`χ(ℝ²) = 6` or `7`: a weak six-colouring
of the plane exists exactly when the plane is six-colourable, `Outside.OAI158.colorable_iff_nonempty_aeColouring`);
the hexagonal seven-colouring satisfies the analogous local hypotheses on the points `q j` at a point near which
three tiles meet, and fails "six". -/
theorem no_outside_orbit_points {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) {p : ℂ}
    {a : Fin 4 → Fin 6} (ha : Function.Injective a) {X Y : Fin 6} (hXY : X ≠ Y)
    (hX : ∀ j, a j ≠ X) (hY : ∀ j, a j ≠ Y) {q : Fin 4 → ℂ} (hq : ∀ j, q j ≠ p)
    (hl : ∀ j, Disjoint (spatialSupport c (a j)) (Straddle {p, q j}))
    (hr : ∀ j, Disjoint (spatialSupport c (a (j + 1))) (Straddle {p, q j}))
    (ψ δ : ℝ) (hδ : 0 < δ)
    (hi : ∀ k : ℤ, ∀ᵐ θ : ℝ, |θ - ψ - k * (Real.pi / 3)| < δ →
      X ∈ palette c hc p (θ : Angles) ∨ Y ∈ palette c hc p (θ : Angles))
    (hii : ∀ η : ℝ, 0 < η →
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ X ∈ palette c hc p (θ : Angles)} ∧
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ Y ∈ palette c hc p (θ : Angles)}) : False := by
  have hO : OutsideOrbit c hc p X Y ψ δ := ⟨hδ, hi, hii⟩
  have htip : ∀ n : ℤ, ∃ j : Fin 4, IsTip c p (hub p ψ n) (a j) := fun n => by
    obtain ⟨i, hiX, hiY, hit⟩ := exists_tip hO hw n
    obtain ⟨j, rfl⟩ := exists_cycle_label ha hXY hX hY hiX hiY
    exact ⟨j, hit⟩
  choose τ hτ using htip
  obtain ⟨n, hn⟩ := exists_adjacent_tips hq hl hr ψ τ hτ
  refine adjacent_tip_false hc hw hO n (b := a (τ n)) (fun i hib hiX hiY ht => ?_)
    (fun i hib hiX hiY ht => ?_)
  · obtain ⟨j, rfl⟩ := exists_cycle_label ha hXY hX hY hiX hiY
    exact hib (congrArg a (tip_unique hq hl hr ψ τ hτ ht))
  · obtain ⟨j, rfl⟩ := exists_cycle_label ha hXY hX hY hiX hiY
    exact hib (congrArg a ((tip_unique hq hl hr ψ τ hτ ht).trans hn.symm))

/-- **C132-M-ORBIT** (the instance `U = ℂ`, **the whole plane**). Let `c` be a weak measurable six-colouring of the
plane, `a 0, …, a 3` four of the labels and `X`, `Y` the other two, and `K` four sets as in `FourCycleStraddle`. Then
there are no angle `ψ` and number `δ > 0` such that (i) for every integer `k` and almost every `θ` with
`|θ − ψ − kπ/3| < δ` the palette at `p` in the direction `θ` contains `X` or `Y`, and (ii) for every `η > 0` the `θ`
in `(ψ − η, ψ + η)` whose palette contains `X`, and those whose palette contains `Y`, both have positive measure.
From `no_outside_orbit_points` at one point of each set besides `p`.

A refutation; the remark on models at `no_outside_orbit_points` applies. -/
theorem no_outside_orbit {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) {p : ℂ}
    {a : Fin 4 → Fin 6} (ha : Function.Injective a) {X Y : Fin 6} (hXY : X ≠ Y)
    (hX : ∀ j, a j ≠ X) (hY : ∀ j, a j ≠ Y) {K : Fin 4 → Set ℂ} (hK : FourCycleStraddle c p a K)
    (ψ δ : ℝ) (hδ : 0 < δ)
    (hi : ∀ k : ℤ, ∀ᵐ θ : ℝ, |θ - ψ - k * (Real.pi / 3)| < δ →
      X ∈ palette c hc p (θ : Angles) ∨ Y ∈ palette c hc p (θ : Angles))
    (hii : ∀ η : ℝ, 0 < η →
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ X ∈ palette c hc p (θ : Angles)} ∧
      0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ Y ∈ palette c hc p (θ : Angles)}) : False := by
  choose q hqK hqp using hK.other
  have hsub : ∀ j, ({p, q j} : Set ℂ) ⊆ K j := fun j => by
    rintro z (rfl | rfl)
    · exact hK.centre_mem j
    · exact hqK j
  exact no_outside_orbit_points hc hw ha hXY hX hY hqp
    (fun j => (hK.left j).mono_right (straddle_mono (hsub j)))
    (fun j => (hK.right j).mono_right (straddle_mono (hsub j))) ψ δ hδ hi hii

/-- **C132-M-EXCL** (the instance `U = ℂ`, **the whole plane**): with the colouring, the labels and the four sets of
C132-M-ORBIT, it is not the case that for almost every direction the palette at `p` contains `X` or `Y`. From
`no_outside_orbit` at the angle `exists_change_of_ae_outside` gives. The remark on models at
`no_outside_orbit_points` applies. -/
theorem not_ae_outside {c : ℂ → Fin 6} (hc : Measurable c) (hw : WeakColoring 6 c) {p : ℂ}
    {a : Fin 4 → Fin 6} (ha : Function.Injective a) {X Y : Fin 6} (hXY : X ≠ Y)
    (hX : ∀ j, a j ≠ X) (hY : ∀ j, a j ≠ Y) {K : Fin 4 → Set ℂ} (hK : FourCycleStraddle c p a K) :
    ¬ ∀ᵐ t ∂angularMeasure, X ∈ palette c hc p t ∨ Y ∈ palette c hc p t := by
  intro h
  obtain ⟨ψ, hψ⟩ := exists_change_of_ae_outside hc hw p hXY h
  exact no_outside_orbit hc hw ha hXY hX hY hK ψ 1 one_pos
    (fun _ => (ae_real_of_ae_angles h).mono fun _ hθ _ => hθ) hψ

end HadwigerNelson.SixRing
