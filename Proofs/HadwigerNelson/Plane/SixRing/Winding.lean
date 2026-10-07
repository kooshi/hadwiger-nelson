import Proofs.HadwigerNelson.Outside.OAI158Palette
import Mathlib.Data.ZMod.Basic

/-!
# The winding of a ring around a triangle of labels (FS-132, C132-INDEX and C132-RING-WIND) — SKELETON

Three labels are the vertices of a triangle; its boundary `Θ` is a circle, parametrized by `triPoint : ℝ → (ZMod 3 → ℝ)`
with period `3` (position `n` is the vertex `n mod 3`, position `n + t`, `0 < t < 1`, the point of the edge from
`n` to `n + 1`). A loop in `Θ` is carried by a lift `f : ℝ → ℝ` with `f (θ + 2π) = f θ + 3 d`; `d` is its degree for
the orientation `0 → 1 → 2`. Both statements say `d ≡ 3 (mod 6)` when no label is present both at `θ` and at
`θ + π/3`, and both are instances of one lemma (`sixStep`): the step `f (θ + π/3) − f θ` lies in one interval
`[1 + 3m, 2 + 3m]`, so `3d ∈ [6 + 18m, 12 + 18m]`, and the two ends are excluded.

**Planner's finding (FS132-K1, blind):** C132-RING-WIND does not need C132-INDEX — no interpolation of the measurable
ring to a continuous loop. **Status: skeleton; every `sorry` is a leaf of `plans/FS132-kernel-plan.md`.**
-/

open MeasureTheory Filter Topology

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-- The point of the triangle's boundary at position `x`: weight `1 − fract x` at the vertex `⌊x⌋ mod 3` and
`fract x` at the next. Period `3` in `x`. -/
noncomputable def triPoint (x : ℝ) (i : ZMod 3) : ℝ :=
  if i = ((⌊x⌋ : ℤ) : ZMod 3) then 1 - Int.fract x
  else if i = ((⌊x⌋ : ℤ) : ZMod 3) + 1 then Int.fract x else 0

/-- The labels with a positive coordinate at position `x`: one at a vertex, two inside an edge. -/
noncomputable def triSupport (x : ℝ) : Finset (ZMod 3) := Finset.univ.filter fun i => 0 < triPoint x i

/-- At an integer position the support is that vertex. -/
theorem triSupport_intCast (n : ℤ) : triSupport (n : ℝ) = {(n : ZMod 3)} := by
  sorry

/-- Inside an edge the support is its two ends. -/
theorem triSupport_of_fract_ne_zero {x : ℝ} (h : Int.fract x ≠ 0) :
    triSupport x = {((⌊x⌋ : ℤ) : ZMod 3), ((⌊x⌋ : ℤ) : ZMod 3) + 1} := by
  sorry

/-- The parametrization has period `3`. -/
theorem triPoint_add_three (x : ℝ) : triPoint (x + 3) = triPoint x := by
  sorry

/-- **Disjoint supports put the step in `[1, 2] + 3ℤ`**: if no label is positive at both positions `x` and `y`, then
`y − x ∈ [1 + 3m, 2 + 3m]` for an integer `m`. -/
theorem step_mem_of_disjoint {x y : ℝ} (h : Disjoint (triSupport x) (triSupport y)) :
    ∃ m : ℤ, y - x ∈ Set.Icc (1 + 3 * (m : ℝ)) (2 + 3 * m) := by
  sorry

/-- **An extreme step starts at a vertex**: with disjoint supports, a step of exactly `1 + 3m` or `2 + 3m` has `x`
at a vertex. -/
theorem fract_eq_zero_of_step_end {x y : ℝ} (h : Disjoint (triSupport x) (triSupport y)) {m : ℤ}
    (hy : y - x = 1 + 3 * m ∨ y - x = 2 + 3 * m) : Int.fract x = 0 := by
  sorry

/-- **The six-step lemma.** A lift `f` of degree `d` whose step over `π/3` lies almost everywhere in one interval
`[1 + 3m, 2 + 3m]`, and is neither almost everywhere `1 + 3m` nor almost everywhere `2 + 3m`, has `d = 3 + 6m`.
(The sum of six consecutive steps is `3d`.) A model of the hypotheses is `indexModel` (`indexModel_spec`). -/
theorem sixStep {f : ℝ → ℝ} {d m : ℤ} (hper : ∀ θ, f (θ + 2 * Real.pi) = f θ + 3 * d)
    (hstep : ∀ᵐ θ : ℝ, f (θ + Real.pi / 3) - f θ ∈ Set.Icc (1 + 3 * (m : ℝ)) (2 + 3 * m))
    (hlo : ¬ ∀ᵐ θ : ℝ, f (θ + Real.pi / 3) - f θ = 1 + 3 * m)
    (hhi : ¬ ∀ᵐ θ : ℝ, f (θ + Real.pi / 3) - f θ = 2 + 3 * m) : d = 3 + 6 * m := by
  sorry

/-- **C132-INDEX, in lift form.** A continuous lift `f` of degree `d` of a loop in the triangle's boundary, with no
label positive both at `θ` and at `θ + π/3`, has `d ≡ 3 (mod 6)`. The claim's "continuous map `φ` from the unit
circle to `Θ`" is `θ ↦ triPoint (f θ)`: every such `φ` has a lift (`exists_triLift`), and `d` is its degree for the
orientation `0 → 1 → 2`. Inhabitant of the hypotheses: `indexModel`, of degree `3` (`indexModel_spec`). -/
theorem index_degree {f : ℝ → ℝ} (hf : Continuous f) {d : ℤ}
    (hper : ∀ θ, f (θ + 2 * Real.pi) = f θ + 3 * d)
    (hdisj : ∀ θ, Disjoint (triSupport (f θ)) (triSupport (f (θ + Real.pi / 3)))) : d ≡ 3 [ZMOD 6] := by
  sorry

/-- **Every continuous loop in the triangle's boundary has a lift** (the covering `triPoint : ℝ → Θ`), with a degree. -/
theorem exists_triLift (φ : C(Angles, ZMod 3 → ℝ)) (hφ : ∀ t, φ t ∈ Set.range triPoint) :
    ∃ f : ℝ → ℝ, Continuous f ∧ ∃ d : ℤ, (∀ θ, f (θ + 2 * Real.pi) = f θ + 3 * d) ∧
      ∀ θ : ℝ, triPoint (f θ) = φ (θ : Angles) := by
  sorry

/-- The degree does not depend on the lift. -/
theorem triLift_degree_unique {f g : ℝ → ℝ} (hf : Continuous f) (hg : Continuous g) {d e : ℤ}
    (hfp : ∀ θ, f (θ + 2 * Real.pi) = f θ + 3 * d) (hgp : ∀ θ, g (θ + 2 * Real.pi) = g θ + 3 * e)
    (h : ∀ θ, triPoint (f θ) = triPoint (g θ)) : d = e := by
  sorry

/-- **C132-INDEX, in the claim's form**: a continuous `φ` from the circle to the triangle's boundary such that no
label has a positive coordinate both at `φ(e)` and at `φ(Re)` has degree `≡ 3 (mod 6)` — for every lift. -/
theorem index (φ : C(Angles, ZMod 3 → ℝ)) (hφ : ∀ t, φ t ∈ Set.range triPoint)
    (hR : ∀ t i, ¬ (0 < φ t i ∧ 0 < φ (t + (sixty : Angles)) i))
    {f : ℝ → ℝ} (hf : Continuous f) {d : ℤ} (hper : ∀ θ, f (θ + 2 * Real.pi) = f θ + 3 * d)
    (hlift : ∀ θ : ℝ, triPoint (f θ) = φ (θ : Angles)) : d ≡ 3 [ZMOD 6] := by
  sorry

/-- A loop of degree `3` satisfying C132-INDEX's hypothesis: along each edge in `π/9`, then at rest for `π/9`.
(The loop of uniform speed and degree `3` does **not** satisfy it: a point inside an edge needs the opposite vertex
exactly at `π/3` on.) -/
noncomputable def indexModel (θ : ℝ) : ℝ :=
  (⌊9 * θ / (2 * Real.pi)⌋ : ℝ) + min 1 (2 * Int.fract (9 * θ / (2 * Real.pi)))

/-- `indexModel` is a model of `index_degree`'s hypotheses, with `d = 3`. -/
theorem indexModel_spec : Continuous indexModel ∧ (∀ θ, indexModel (θ + 2 * Real.pi) = indexModel θ + 3 * (3 : ℤ)) ∧
    ∀ θ, Disjoint (triSupport (indexModel θ)) (triSupport (indexModel (θ + Real.pi / 3))) := by
  sorry

/-! ## The measurable ring (C132-RING-WIND) -/

/-- The directions with no arc about them on which the ring `P` is almost everywhere one set: the claim's `J`. -/
def ringBoundary (P : Angles → Finset (ZMod 3)) : Set Angles :=
  {t | ¬ ∃ U : Set Angles, IsOpen U ∧ t ∈ U ∧ ∃ Q : Finset (ZMod 3), ∀ᵐ u ∂angularMeasure, u ∈ U → P u = Q}

/-- A lift of a ring `P` to positions on the triangle's boundary: `F` takes vertex and edge-midpoint positions
(`n`, `n + 1/2`), the ring is almost everywhere the support of `F`, near every angle `F` stays in one closed edge
`[n, n + 1]` (so it is locally constant off the ring's boundary, and a change runs inside one edge), and `F` has
degree `d`. This is the claim's "closed walk the arcs make around the triangle on `N`", with `d` its winding
number. -/
structure RingLift (P : Angles → Finset (ZMod 3)) (F : ℝ → ℝ) (d : ℤ) : Prop where
  /-- The ring is the support of the lift, almost everywhere. -/
  ae_eq : ∀ᵐ θ : ℝ, P (θ : Angles) = triSupport (F θ)
  /-- The lift is at a vertex or at the middle of an edge. -/
  half : ∀ θ, ∃ n : ℤ, F θ = n ∨ F θ = n + 1 / 2
  /-- Near every angle the lift stays in one closed edge. -/
  edge : ∀ θ, ∃ n : ℤ, ∀ᶠ u in 𝓝 θ, F u ∈ Set.Icc (n : ℝ) (n + 1)
  /-- The lift has degree `d`. -/
  period : ∀ θ, F (θ + 2 * Real.pi) = F θ + 3 * d

/-- **C132-RING-WIND, first conclusion**: off the boundary, the ring is almost everywhere one singleton or one pair
on each arc. -/
theorem ring_arc {P : Angles → Finset (ZMod 3)} (hPm : ∀ Q, MeasurableSet {t | P t = Q})
    (hne : ∀ t, (P t).Nonempty)
    (hdisj : ∀ᵐ t ∂angularMeasure, Disjoint (P t) (P (t + (sixty : Angles))))
    {t : Angles} (ht : t ∉ ringBoundary P) :
    ∃ Q : Finset (ZMod 3), (Q.card = 1 ∨ Q.card = 2) ∧
      ∀ᵐ u ∂angularMeasure, u ∈ connectedComponentIn (ringBoundary P)ᶜ t → P u = Q := by
  sorry

/-- **C132-RING-WIND, second conclusion**: at a boundary point no boundary point lies `π/3` on from, the two
arcs carry subsets of one pair. -/
theorem ring_consecutive {P : Angles → Finset (ZMod 3)} (hPm : ∀ Q, MeasurableSet {t | P t = Q})
    (hne : ∀ t, (P t).Nonempty)
    (hdisj : ∀ᵐ t ∂angularMeasure, Disjoint (P t) (P (t + (sixty : Angles))))
    (hJ : ∀ t ∈ ringBoundary P, t + (sixty : Angles) ∉ ringBoundary P)
    {t : Angles} (ht : t ∈ ringBoundary P) :
    ∃ D : Finset (ZMod 3), D.card = 2 ∧ ∃ V : Set Angles, IsOpen V ∧ t ∈ V ∧
      ∀ᵐ u ∂angularMeasure, u ∈ V → P u ⊆ D := by
  sorry

/-- **C132-RING-WIND, third conclusion**: a ring with finite boundary, no two boundary points `π/3` apart, has a
lift, and its winding number is `≡ 3 (mod 6)`. Inhabitant of the hypotheses: `ringModel` (`ringModel_spec`). -/
theorem ring_winding {P : Angles → Finset (ZMod 3)} (hPm : ∀ Q, MeasurableSet {t | P t = Q})
    (hne : ∀ t, (P t).Nonempty)
    (hdisj : ∀ᵐ t ∂angularMeasure, Disjoint (P t) (P (t + (sixty : Angles))))
    (hfin : (ringBoundary P).Finite)
    (hJ : ∀ t ∈ ringBoundary P, t + (sixty : Angles) ∉ ringBoundary P) :
    ∃ F : ℝ → ℝ, ∃ d : ℤ, RingLift P F d ∧ d ≡ 3 [ZMOD 6] := by
  sorry

/-- The winding number is the ring's: two lifts have one degree. -/
theorem ringLift_degree_unique {P : Angles → Finset (ZMod 3)} {F G : ℝ → ℝ} {d e : ℤ}
    (hF : RingLift P F d) (hG : RingLift P G e) : d = e := by
  sorry

/-- Nine sectors of `2π/9`, labelled `0, 1, 2, 0, 1, 2, 0, 1, 2`: a ring with finite boundary (the nine multiples
of `2π/9`), no two boundary points `π/3` apart (`π/3` is one and a half sectors), disjoint from its `π/3`-rotate
(which lies one or two sectors on), and of winding number `3`. The ring of `indexModel` is **not** a model here: its
changes at `θ` and at `θ + π/3` coincide. -/
noncomputable def ringModel (t : Angles) : Finset (ZMod 3) :=
  {((⌊9 * t.liftIoc (2 * Real.pi) 0 id / (2 * Real.pi)⌋ : ℤ) : ZMod 3)}

/-- `ringModel` satisfies every hypothesis of `ring_winding`. -/
theorem ringModel_spec : (∀ Q, MeasurableSet {t | ringModel t = Q}) ∧ (∀ t, (ringModel t).Nonempty) ∧
    (∀ᵐ t ∂angularMeasure, Disjoint (ringModel t) (ringModel (t + (sixty : Angles)))) ∧
    (ringBoundary ringModel).Finite ∧
    ∀ t ∈ ringBoundary ringModel, t + (sixty : Angles) ∉ ringBoundary ringModel := by
  sorry

end HadwigerNelson.SixRing
