import Proofs.HadwigerNelson.Plane.WeakColouringOn
import Proofs.HadwigerNelson.Plane.CoverExamples
import Proofs.HadwigerNelson.UnitDistance
import Mathlib.Combinatorics.SimpleGraph.Finsubgraph

/-!
# The radius clause, without an import: a weak colouring of an open set colours the finite graphs inside it (FS-124)

Claims **C124-RADIUS-GRAPH**, **C124-RADIUS-COUNTABLE** and **C124-RADIUS-UP** of `data/fs124/claims-K1.md`
(plan: `plans/FS124-kernel-plan.md`). Nothing here rests on a declared outside theorem.

The definition says: almost every rigid motion that carries the reference edge `(0, 1)` into `U` separates its ends
(`aeProperOn_iff_ae_rigidMotion`). The clause says the same of every countable set in place of the edge.

* `AeProperOn.ae_rigidMotion` — the core: for a colouring proper at almost every unit pair of `U` and a **countable**
  `V`, almost every rigid motion `g` gives different labels to `g v`, `g w` for every two points of `V` at distance
  `1` that it carries into `U`. No measurability of the colouring, no openness of `U`, no position of `V`. One unit
  pair of `V` is the image of the reference edge under a motion `h`, and the motions bad for it are the right
  translate by `h` of the monochromatic pairs (`AeProperOn.ae_rigidMotion_edge`).
* `isOpen_setOf_mapsTo_rigidMotion` — the motions carrying a compact set into an open set form an open set.
* `AeProperOn.exists_rigidMotion` — the two together: one motion, when `V` has compact closure that some motion
  carries into `U`.
* `radius_graph`, `radius_countable`, `radius_up` — the three claims, each in its words.
* `colorable_plane_of_forall_aeProperOn_ball` — the form of UP the proof gives: discs at any centres, and any
  colourings proper at almost every unit pair of them, measurable or not (so it contains the classical statement that
  the plane is `k`-colourable if every disc is: `aeProperOn_of_proper`); `exists_radius_of_not_colorable` is its
  contrapositive, the form C124-RADIUS-FIVE is read from.

**Inhabitant** of every hypothesis here at once: `exists_isWeakColouringOn_seven` (R7, seven colours, every set). At
six colours the hypothesis of `radius_up` is the Hadwiger–Nelson problem itself (`Plane/RadiusOutside`:
`colorable_iff_forall_ball`), an open question; at five it fails (`radius_five`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric HadwigerNelson

variable {α : Type*} {k : ℕ}

/-! ## The model -/

/-- **Inhabitant**: R7 (`r7_aeColouring`) is a weak seven-colouring of every set of the plane. -/
theorem exists_isWeakColouringOn_seven : ∃ c : ℂ → Fin 7, ∀ U : Set ℂ, IsWeakColouringOn U c := by
  obtain ⟨a, -⟩ := r7_aeColouring
  exact ⟨a.col, a.isWeakColouringOn⟩

/-! ## The core: almost every rigid motion -/

/-- **One unit pair**, as the image `(h 0, h 1)` of the reference edge under a motion `h`: almost every rigid motion
`q` that carries both of its points into `U` gives them different labels. The motions that do not are the preimage
of the monochromatic pairs under `q ↦ motionMul q h`. -/
theorem AeProperOn.ae_rigidMotion_edge {U : Set ℂ} {c : ℂ → α} (hc : AeProperOn U c) (h : ℂ × ℝ) :
    ∀ᵐ q : ℂ × ℝ, rigidMotion q (rigidMotion h 0) ∈ U → rigidMotion q (rigidMotion h 1) ∈ U →
      c (rigidMotion q (rigidMotion h 0)) ≠ c (rigidMotion q (rigidMotion h 1)) := by
  have hnull := (measurePreserving_motionMul_right h).quasiMeasurePreserving.preimage_null
    (aeProperOn_iff_volume.mp hc)
  rw [ae_iff]
  refine measure_mono_null (fun q hq => ?_) hnull
  simp only [mem_setOf_eq, Classical.not_imp, not_not] at hq
  show motionMul q h ∈ monoPairSet U c
  rw [mem_monoPairSet_iff_rigidMotion, rigidMotion_motionMul, rigidMotion_motionMul]
  exact hq

/-- **Almost every rigid motion is good for a countable set** (the core of C124-RADIUS-GRAPH): if `c` is proper at
almost every unit pair of `U` and `V` is countable, then for almost every parameter `q ∈ ℂ × ℝ` (Lebesgue measure,
all real angles), any two points of `V` at distance `1` that `q` carries into `U` get different labels. -/
theorem AeProperOn.ae_rigidMotion {U : Set ℂ} {c : ℂ → α} (hc : AeProperOn U c) {V : Set ℂ} (hV : V.Countable) :
    ∀ᵐ q : ℂ × ℝ, ∀ v ∈ V, ∀ w ∈ V, dist v w = 1 → rigidMotion q v ∈ U → rigidMotion q w ∈ U →
      c (rigidMotion q v) ≠ c (rigidMotion q w) := by
  refine (ae_ball_iff hV).mpr fun v _ => (ae_ball_iff hV).mpr fun w _ => ?_
  by_cases hd : dist v w = 1
  · -- the pair is the image of the reference edge under a motion `h`: the one-edge lemma
    obtain ⟨h, rfl, rfl⟩ := exists_rigidMotion_edge hd
    filter_upwards [hc.ae_rigidMotion_edge h] with q hq _ using hq
  · exact Filter.Eventually.of_forall fun q hd' => absurd hd' hd

/-- The same with each motion counted once: for `volume ⊗ arcLength`, the measure of the definition. -/
theorem AeProperOn.ae_rigidMotion_arcLength {U : Set ℂ} {c : ℂ → α} (hc : AeProperOn U c) {V : Set ℂ}
    (hV : V.Countable) :
    ∀ᵐ q ∂(volume : Measure ℂ).prod arcLength, ∀ v ∈ V, ∀ w ∈ V, dist v w = 1 →
      rigidMotion q v ∈ U → rigidMotion q w ∈ U → c (rigidMotion q v) ≠ c (rigidMotion q w) := by
  rw [prod_arcLength_eq_restrict]
  exact ae_restrict_of_ae (hc.ae_rigidMotion hV)

/-- **The definition is the clause at the reference edge**: `c` is proper at almost every unit pair of `U` exactly
when almost every rigid motion carrying `0` and `1` into `U` gives them different labels. -/
theorem aeProperOn_iff_ae_rigidMotion {U : Set ℂ} {c : ℂ → α} :
    AeProperOn U c ↔ ∀ᵐ q ∂(volume : Measure ℂ).prod arcLength,
      rigidMotion q 0 ∈ U → rigidMotion q 1 ∈ U → c (rigidMotion q 0) ≠ c (rigidMotion q 1) := by
  simp only [rigidMotion_apply_zero, rigidMotion_apply_one]
  exact aeProperOn_iff_ae

/-- **The motions carrying a compact set into an open set form an open set** of parameters. -/
theorem isOpen_setOf_mapsTo_rigidMotion {K U : Set ℂ} (hK : IsCompact K) (hU : IsOpen U) :
    IsOpen {q : ℂ × ℝ | MapsTo (rigidMotion q) K U} := by
  rw [isOpen_iff_eventually]
  intro q₀ hq₀
  refine hK.eventually_forall_of_forall_eventually fun y hy => ?_
  exact continuous_rigidMotion.continuousAt.eventually (hU.mem_nhds (hq₀ hy))

/-- **One good motion**: `U` open, `c` proper at almost every unit pair of `U`, `V` countable with compact closure,
and some motion `g₀` carrying that closure into `U`. Then some motion carries `V` into `U` and gives different labels
to every two of its points at distance `1`. -/
theorem AeProperOn.exists_rigidMotion {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {V : Set ℂ}
    (hV : V.Countable) (hK : IsCompact (closure V)) {g₀ : ℂ × ℝ} (hg₀ : MapsTo (rigidMotion g₀) (closure V) U) :
    ∃ q : ℂ × ℝ, MapsTo (rigidMotion q) V U ∧
      ∀ v ∈ V, ∀ w ∈ V, dist v w = 1 → c (rigidMotion q v) ≠ c (rigidMotion q w) := by
  -- the motions carrying `closure V` into `U` are open and hold `g₀`: a set of positive measure,
  -- which meets the conull set of good motions
  have hGo : IsOpen {q : ℂ × ℝ | MapsTo (rigidMotion q) (closure V) U} := isOpen_setOf_mapsTo_rigidMotion hK hU
  have hGpos : (volume : Measure (ℂ × ℝ)) {q : ℂ × ℝ | MapsTo (rigidMotion q) (closure V) U} ≠ 0 :=
    (hGo.measure_pos volume ⟨g₀, hg₀⟩).ne'
  obtain ⟨q, hqG, hq⟩ :=
    Measure.exists_mem_of_measure_ne_zero_of_ae hGpos (ae_restrict_of_ae (hc.ae_rigidMotion hV))
  have hqV : MapsTo (rigidMotion q) V U := fun v hv => hqG (subset_closure hv)
  exact ⟨q, hqV, fun v hv w hw hd => hq v hv w hw hd (hqV hv) (hqV hw)⟩

/-- A labelling that separates every two points of `V` at distance `1` is a proper colouring of the unit-distance
graph on `V`. -/
theorem colorable_induce_of_forall_ne {V : Set ℂ} {f : ℂ → Fin k}
    (h : ∀ v ∈ V, ∀ w ∈ V, dist v w = 1 → f v ≠ f w) : ((unitDistance ℂ).induce V).Colorable k := by
  exact ⟨SimpleGraph.Coloring.mk (fun v => f v) fun {a b} hab => h a a.2 b b.2 (unitDistance_adj.mp hab)⟩

/-- **The consumer's form of C124-RADIUS-GRAPH**: if `c : ℂ → Fin k` is proper at almost every unit pair of an open
`U`, the unit-distance graph on every finite set of points of `U` is `k`-colourable. Read backwards: a finite
unit-distance graph inside `U` with no `k`-colouring refutes every such colouring of `U`. -/
theorem AeProperOn.colorable_induce {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : AeProperOn U c) {V : Set ℂ}
    (hV : V.Finite) (hVU : V ⊆ U) : ((unitDistance ℂ).induce V).Colorable k := by
  have hcl : closure V = V := hV.isClosed.closure_eq
  have hg₀ : MapsTo (rigidMotion 0) (closure V) U := fun v hv => by
    rw [rigidMotion_zero]
    exact hVU (hcl ▸ hv)
  obtain ⟨q, -, hq⟩ := hc.exists_rigidMotion hU hV.countable (hcl.symm ▸ hV.isCompact) hg₀
  exact colorable_induce_of_forall_ne (f := fun v => c (rigidMotion q v)) hq

/-! ## C124-RADIUS-GRAPH -/

/-- **C124-RADIUS-GRAPH** (`data/fs124/claims-K1.md`): "Let k ≥ 1, U an open set of the plane, c a weak k-colouring
of U, and V a finite subset of U. Then the rigid motions g with g(V) ⊂ U form a non-empty open set, and for almost
every one of them the points g(v), g(v′) have different labels for every two points v, v′ of V at distance 1; so the
unit-distance graph on V has a proper k-colouring."

Clause by clause: the set of parameters `{q | MapsTo (rigidMotion q) V U}` is open and non-empty; for almost every
rigid motion `q` — `volume ⊗ arcLength`, each motion counted once, the measure of the definition — if `q` carries `V`
into `U` then it separates every unit pair of `V`; and `(unitDistance ℂ).induce V` is `k`-colourable. `k ≥ 1` is not
a hypothesis: a `c : ℂ → Fin k` exists only then. The second clause for every real angle, for countable `V` and with
no hypothesis on where `V` lies is `AeProperOn.ae_rigidMotion`. Inhabitant of the hypotheses:
`exists_isWeakColouringOn_seven` with `U = univ`, `V = {0, 1}`. -/
theorem radius_graph {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {V : Set ℂ}
    (hV : V.Finite) (hVU : V ⊆ U) :
    (IsOpen {q : ℂ × ℝ | MapsTo (rigidMotion q) V U} ∧ {q : ℂ × ℝ | MapsTo (rigidMotion q) V U}.Nonempty) ∧
      (∀ᵐ q ∂(volume : Measure ℂ).prod arcLength, MapsTo (rigidMotion q) V U →
        ∀ v ∈ V, ∀ w ∈ V, dist v w = 1 → c (rigidMotion q v) ≠ c (rigidMotion q w)) ∧
      ((unitDistance ℂ).induce V).Colorable k := by
  refine ⟨⟨isOpen_setOf_mapsTo_rigidMotion hV.isCompact hU, 0, fun v hv => ?_⟩, ?_,
    hc.aeProperOn.colorable_induce hU hV hVU⟩
  · rw [rigidMotion_zero]
    exact hVU hv
  · filter_upwards [hc.aeProperOn.ae_rigidMotion_arcLength hV.countable] with q hq hmaps v hv w hw hd
    exact hq v hv w hw hd (hmaps hv) (hmaps hw)

/-! ## C124-RADIUS-COUNTABLE -/

/-- **C124-RADIUS-COUNTABLE** (`data/fs124/claims-K1.md`): "Let k ≥ 1, U an open set of the plane, c a weak
k-colouring of U, and V a countable subset of U whose closure is a compact subset of U. Then the unit-distance graph
on V has a proper k-colouring of the form v ↦ c(g(v)) for a rigid motion g with g(V) ⊂ U."

The colouring of the conclusion is `v ↦ c (rigidMotion q v)`; that it is proper is its last clause, and
`colorable_induce_of_forall_ne` makes it a colouring of `(unitDistance ℂ).induce V`. Inhabitant of the hypotheses:
`exists_isWeakColouringOn_seven` with `U = univ` and `V = {0, 1}`. -/
theorem radius_countable {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {V : Set ℂ}
    (hV : V.Countable) (hK : IsCompact (closure V)) (hVU : closure V ⊆ U) :
    ∃ q : ℂ × ℝ, MapsTo (rigidMotion q) V U ∧
      ∀ v ∈ V, ∀ w ∈ V, dist v w = 1 → c (rigidMotion q v) ≠ c (rigidMotion q w) := by
  refine hc.aeProperOn.exists_rigidMotion hU hV hK (g₀ := 0) fun v hv => ?_
  rw [rigidMotion_zero]
  exact hVU hv

/-! ## C124-RADIUS-UP -/

/-- De Bruijn–Erdős for the plane (`SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom`): if the unit-distance
graph on every finite set of points is `k`-colourable, so is the plane's. -/
theorem colorable_plane_of_forall_finite
    (h : ∀ V : Set ℂ, V.Finite → ((unitDistance ℂ).induce V).Colorable k) : (unitDistance ℂ).Colorable k := by
  refine SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom fun G' hfin =>
    Nonempty.some (α := G'.coe.Coloring (Fin k)) ?_
  obtain ⟨C⟩ := h G'.verts hfin
  exact ⟨SimpleGraph.Coloring.mk (fun z => C z) fun {a b} hab => C.valid (G'.adj_sub hab)⟩

/-- **Discs at any centres, colourings of any regularity**: if for every `R > 0` some disc of radius `R` has a
`k`-colouring proper at almost every unit pair of it, the unit-distance graph on every finite set is `k`-colourable.
Inhabitant of the hypothesis: `k = 7` (`exists_isWeakColouringOn_seven`). -/
theorem colorable_induce_of_forall_aeProperOn_ball
    (h : ∀ R > (0 : ℝ), ∃ (p : ℂ) (c : ℂ → Fin k), AeProperOn (ball p R) c) {V : Set ℂ} (hV : V.Finite) :
    ((unitDistance ℂ).induce V).Colorable k := by
  -- `V` lies in a disc of some radius `R` about `0`; translate it into the disc of radius `R` the hypothesis colours
  obtain ⟨R, hR0, hVR⟩ := hV.isBounded.subset_ball_lt 0 0
  obtain ⟨p, c, hc⟩ := h R hR0
  have hcl : closure V = V := hV.isClosed.closure_eq
  have hg₀ : MapsTo (rigidMotion (p, 0)) (closure V) (ball p R) := fun v hv => by
    have hv0 : v ∈ ball (0 : ℂ) R := hVR (hcl ▸ hv)
    rw [mem_ball, dist_zero_right] at hv0
    rw [rigidMotion_translation, mem_ball, dist_eq_norm, add_sub_cancel_left]
    exact hv0
  obtain ⟨q, -, hq⟩ := hc.exists_rigidMotion isOpen_ball hV.countable (hcl.symm ▸ hV.isCompact) hg₀
  exact colorable_induce_of_forall_ne (f := fun v => c (rigidMotion q v)) hq

/-- The same hypothesis gives a proper `k`-colouring of the plane. Inhabitant of the hypothesis: `k = 7`. -/
theorem colorable_plane_of_forall_aeProperOn_ball
    (h : ∀ R > (0 : ℝ), ∃ (p : ℂ) (c : ℂ → Fin k), AeProperOn (ball p R) c) : (unitDistance ℂ).Colorable k := by
  exact colorable_plane_of_forall_finite fun _ hV => colorable_induce_of_forall_aeProperOn_ball h hV

/-- **The contrapositive**: if the plane has no proper `k`-colouring, then at some radius no disc, at any centre, has
a `k`-colouring proper at almost every unit pair of it — measurable or not. Inhabitant of the hypothesis: `k = 4`
(`isEmpty_coloring_plane_four`, rung B). -/
theorem exists_radius_of_not_colorable (h : ¬ (unitDistance ℂ).Colorable k) :
    ∃ R > (0 : ℝ), ∀ (p : ℂ) (c : ℂ → Fin k), ¬ AeProperOn (ball p R) c := by
  by_contra hcon
  push Not at hcon
  exact h (colorable_plane_of_forall_aeProperOn_ball hcon)

/-- **C124-RADIUS-UP** (`data/fs124/claims-K1.md`): "For every integer k ≥ 1: if for every R > 0 the open disc of
radius R about the origin has a weak measurable k-colouring, then every finite unit-distance graph in the plane has a
proper k-colouring, and χ(ℝ²) ≤ k."

A finite unit-distance graph in the plane is read as the unit-distance graph on a finite set of points (every graph
drawn on those points with unit edges is a subgraph of it); `χ(ℝ²)` is `(unitDistance ℂ).chromaticNumber`, the number
of `chromaticNumber_plane_eq_complex`. Inhabitant of the hypothesis: `k = 7`, by `exists_isWeakColouringOn_seven`. At
`k = 6` whether the hypothesis holds is the Hadwiger–Nelson problem (an open question); at `k = 5` it fails
(`Plane/RadiusOutside`: `radius_five`, given a declared outside theorem). -/
theorem radius_up (h : ∀ R > (0 : ℝ), ∃ c : ℂ → Fin k, IsWeakColouringOn (ball (0 : ℂ) R) c) :
    (∀ V : Set ℂ, V.Finite → ((unitDistance ℂ).induce V).Colorable k) ∧
      (unitDistance ℂ).chromaticNumber ≤ k := by
  have h' : ∀ R > (0 : ℝ), ∃ (p : ℂ) (c : ℂ → Fin k), AeProperOn (ball p R) c := fun R hR =>
    (h R hR).elim fun c hc => ⟨0, c, hc.aeProperOn⟩
  exact ⟨fun _ hV => colorable_induce_of_forall_aeProperOn_ball h' hV,
    SimpleGraph.chromaticNumber_le_iff_colorable.mpr (colorable_plane_of_forall_aeProperOn_ball h')⟩

/-! ## Spec examples -/

/-- The model, read through C124-RADIUS-GRAPH: the edge `{0, 1}` is seven-colourable (it is two-colourable; the
example runs the theorem on an inhabitant of its hypotheses). -/
example : ((unitDistance ℂ).induce ({0, 1} : Set ℂ)).Colorable 7 := by
  obtain ⟨c, hc⟩ := exists_isWeakColouringOn_seven
  exact (radius_graph isOpen_univ (hc univ) (by simp) (subset_univ _)).2.2

/-- The model, read through C124-RADIUS-COUNTABLE on the same edge. -/
example : ∃ (c : ℂ → Fin 7) (q : ℂ × ℝ), c (rigidMotion q 0) ≠ c (rigidMotion q 1) := by
  obtain ⟨c, hc⟩ := exists_isWeakColouringOn_seven
  obtain ⟨q, -, hq⟩ := radius_countable (V := {0, 1}) isOpen_univ (hc univ) (by simp)
    (by simp) (subset_univ _)
  exact ⟨c, q, hq 0 (by simp) 1 (by simp) (by simp)⟩

/-- **The path of an exclusion on a disc**, through the public lemmas alone: a finite set of points of a disc whose
unit-distance graph has no `k`-colouring leaves the disc no weak `k`-colouring. -/
example {R : ℝ} {V : Set ℂ} (hV : V.Finite) (hVR : V ⊆ ball (0 : ℂ) R)
    (hnot : ¬ ((unitDistance ℂ).induce V).Colorable k) :
    ¬ ∃ c : ℂ → Fin k, IsWeakColouringOn (ball (0 : ℂ) R) c :=
  fun ⟨_, hc⟩ => hnot (hc.aeProperOn.colorable_induce isOpen_ball hV hVR)

/-- The model, read through C124-RADIUS-UP: `χ(ℝ²) ≤ 7`. -/
example : (unitDistance ℂ).chromaticNumber ≤ 7 := by
  obtain ⟨c, hc⟩ := exists_isWeakColouringOn_seven
  exact_mod_cast (radius_up fun R _ => ⟨c, hc (ball 0 R)⟩).2

end HadwigerNelson.Plane
