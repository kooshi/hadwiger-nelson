import Proofs.HadwigerNelson.Plane.SixRing.Basic

/-!
# The step lemma (FS-132, C132-M-ORBIT step M8, Lemma S) and two facts about change points — SKELETON

Real analysis on the line: no colouring, no chart, no palette. A measurable set `S ⊆ ℝ` (the angles whose palette
holds one of the two outside labels) and a shift `ε` with `ShiftBounds ε κ`.

* `step_lemma` — the derivation's **Lemma S**: if for almost every `(α, d, d')` the pairs `(α − d, α)` and
  `(α + ε, α + ε + d')` are not both split by `S` (`NoDoubleChange`), then on the interval of radius `κ/4` the set
  `S` is, up to a null set, a half-line: "a function with at most one jump".
* its five children, in the order of the proof — `exists_step_or_density_triple`, `exists_window`,
  `exists_shiftMap`, `exists_density_pair`, `volume_pattern_pos`. **The children are the planner's decomposition;
  `step_lemma`'s statement is the interface.** An implementer who needs a child in another form restates the child
  and says so in its report; `step_lemma` itself is not restated without the planner.
* `step_at_of_change` — the jump is at a point every neighbourhood of which meets both `S` and its complement in
  positive measure; `volume_change_pairs_pos` — at such a point the pairs split by `S` have positive measure at
  every scale (the derivation's step M3, first sentence).

**Route note.** The derivation proves Lemma S by fixing the outer pair `(u, w)` in a neighbourhood and integrating
(Fubini over `(u, w)`). Here the outer pair is fixed at two density points *exactly*, a middle point `v₀` is chosen
with `v₀` and `g(v₀)` both density points (`exists_density_pair`), and positivity of the forbidden pattern near
that base point is a translation-and-Lipschitz estimate (`volume_pattern_pos`): no change of variables in three
dimensions, and the implicit map `g` is needed at one pair only. The window is found on a dyadic scale
(`exists_window`), which needs no continuity of the proportion in the radius. `plans/FS132-kernel-plan.md` stage 5.
-/

open MeasureTheory Filter Topology Set

namespace HadwigerNelson.SixRing

/-- A (two-sided, Lebesgue) density point of a set `E ⊆ ℝ`: the proportion of `E` in `[x − r, x + r]` tends to `1`
as `r → 0⁺`. The form of `Besicovitch.ae_tendsto_measure_inter_div_of_measurableSet`. -/
def IsDensityPt (E : Set ℝ) (x : ℝ) : Prop :=
  Tendsto (fun r => volume (E ∩ Metric.closedBall x r) / volume (Metric.closedBall x r)) (𝓝[>] 0) (𝓝 1)

/-- Every point is a density point of the whole line (drift check and model of `IsDensityPt`). -/
example (x : ℝ) : IsDensityPt Set.univ x := by
  refine tendsto_const_nhds.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with r hr
  rw [Set.univ_inter, ENNReal.div_self]
  · rw [Real.volume_closedBall]; simpa using hr
  · rw [Real.volume_closedBall]; exact ENNReal.ofReal_ne_top

/-- **Lemma S, first step** ("Suppose the conclusion fails. Then there are Lebesgue density points `a_* < b < c_*` …
of the level sets of `s` with `s(a_*) = s(c_*) ≠ s(b)`"): on an open interval a measurable set is, up to a null
set, an initial or a final segment, or there are three density points in the interval, the outer two of one of `S`,
`Sᶜ` and the middle one of the other. -/
theorem exists_step_or_density_triple {S : Set ℝ} (hS : MeasurableSet S) (l r : ℝ) :
    (∃ t' : ℝ, (∀ᵐ θ : ℝ, θ ∈ Ioo l r → (θ ∈ S ↔ θ < t')) ∨ (∀ᵐ θ : ℝ, θ ∈ Ioo l r → (θ ∈ S ↔ t' < θ))) ∨
    ∃ a b c : ℝ, l < a ∧ a < b ∧ b < c ∧ c < r ∧
      ((IsDensityPt S a ∧ IsDensityPt Sᶜ b ∧ IsDensityPt S c) ∨
        (IsDensityPt Sᶜ a ∧ IsDensityPt S b ∧ IsDensityPt Sᶜ c)) := by
  sorry

/-- **Lemma S, the window** ("In every case `u_0 < w_0` are density points of `{s = X}`, `I = (b − ρ, b + ρ) ⊂
(u_0, w_0)`, `{s = Y}` fills at least `3/4` of `I`, and one of `u_0`, `w_0` is within `3ρ` of every point of `I`"),
with `E` the middle value's set and `7/8` in place of `3/4`: between density points `a < c` of `Eᶜ` and about a
density point `b` of `E` there are a radius `ρ`, and density points `u ≤ b − ρ` and `b + ρ ≤ w` of `Eᶜ`, one of
them within `2ρ` of `b`, with `E` filling at least `7/8` of `(b − ρ, b + ρ)`. -/
theorem exists_window {E : Set ℝ} (hE : MeasurableSet E) {a b c : ℝ} (hab : a < b) (hbc : b < c)
    (ha : IsDensityPt Eᶜ a) (hb : IsDensityPt E b) (hc : IsDensityPt Eᶜ c) :
    ∃ u w ρ : ℝ, 0 < ρ ∧ a ≤ u ∧ u ≤ b - ρ ∧ b + ρ ≤ w ∧ w ≤ c ∧ IsDensityPt Eᶜ u ∧ IsDensityPt Eᶜ w ∧
      (b - u ≤ 2 * ρ ∨ w - b ≤ 2 * ρ) ∧ ENNReal.ofReal (7 / 4 * ρ) ≤ volume (E ∩ Ioo (b - ρ) (b + ρ)) := by
  sorry

/-- **Lemma S, the map `g_{u,w}`** ("`g_{u,w}(v) = v + ε`, an increasing … map with `g′ ≥ 7/8` … and
`0 < g(v) − v ≤ min(v − u, w − v)/16`"), at one pair `u < w` with `w − u < κ`: there is `g` on `(u, w)` with
`v < g v < w` and `g v = v + ε (v − u) (w − g v)` — so that `(u, v, g v, w)` are the four angles of a unit pair with
`d = v − u` and `d' = w − g v` — and with slopes between `7/8` and `9/8`. (The bounds `g v − v ≤ (v − u)/16` and
`g v − v ≤ (w − g v)/16` are then `ShiftBounds.le_left`, `.le_right`.) -/
theorem exists_shiftMap {ε : ℝ → ℝ → ℝ} {κ : ℝ} (hε : ShiftBounds ε κ) {u w : ℝ} (huw : u < w) (hκ : w - u < κ) :
    ∃ g : ℝ → ℝ, (∀ v ∈ Ioo u w, v < g v ∧ g v < w ∧ g v = v + ε (v - u) (w - g v)) ∧
      ∀ v₁ ∈ Ioo u w, ∀ v₂ ∈ Ioo u w, v₁ ≤ v₂ →
        7 / 8 * (v₂ - v₁) ≤ g v₂ - g v₁ ∧ g v₂ - g v₁ ≤ 9 / 8 * (v₂ - v₁) := by
  sorry

/-- **Lemma S, the overlap** ("`{s = Y} ∩ I` has measure at least `(3/2)ρ`, its image under `g` at least
`(21/16)ρ`, and both lie in an interval of length `(9/4)ρ`; so they overlap"), with the constants of `exists_window`
(`7/4`, `49/32`, `35/16`), and the base point it yields: a set `F` filling `7/8` of an interval of radius `ρ`, moved
by a map `g` with slopes in `[7/8, 9/8]` and `0 < g − id ≤ 3ρ/16`, contains a point `v` with `g v ∈ F` such that
`v` and `g v` are both density points of `F`. -/
theorem exists_density_pair {F : Set ℝ} (hF : MeasurableSet F) {b ρ : ℝ} (hρ : 0 < ρ)
    (hFI : F ⊆ Ioo (b - ρ) (b + ρ)) (hFm : ENNReal.ofReal (7 / 4 * ρ) ≤ volume F) {g : ℝ → ℝ}
    (hg : ∀ v ∈ F, v < g v ∧ g v ≤ v + 3 / 16 * ρ)
    (hlip : ∀ v₁ ∈ F, ∀ v₂ ∈ F, v₁ ≤ v₂ →
      7 / 8 * (v₂ - v₁) ≤ g v₂ - g v₁ ∧ g v₂ - g v₁ ≤ 9 / 8 * (v₂ - v₁)) :
    ∃ v ∈ F, g v ∈ F ∧ IsDensityPt F v ∧ IsDensityPt F (g v) := by
  sorry

/-- **Lemma S, positivity** (in place of "The pairs `(u, w) ∈ 𝒩` with `s(u) = s(w) = X` have positive measure …
On the resulting set of triples, of positive measure"): if at `(α, d, d')` the four angles `α − d`, `α`, `α + ε`,
`α + ε + d'` (`ε = ε d d'`) are density points of `E₁`, `E₂`, `E₂`, `E₁`, then in every cube about `(α, d, d')` the
triples whose four angles lie in `E₁`, `E₂`, `E₂`, `E₁` have positive measure. -/
theorem volume_pattern_pos {ε : ℝ → ℝ → ℝ} {κ : ℝ} (hε : ShiftBounds ε κ) {E₁ E₂ : Set ℝ}
    (h₁ : MeasurableSet E₁) (h₂ : MeasurableSet E₂) {α d d' : ℝ} (hd : 0 < d) (hdκ : d < κ) (hd' : 0 < d')
    (hd'κ : d' < κ) (hp₁ : IsDensityPt E₁ (α - d)) (hp₂ : IsDensityPt E₂ α)
    (hp₃ : IsDensityPt E₂ (α + ε d d')) (hp₄ : IsDensityPt E₁ (α + ε d d' + d')) {η : ℝ} (hη : 0 < η) :
    0 < volume {y : ℝ × ℝ × ℝ | |y.1 - α| < η ∧ |y.2.1 - d| < η ∧ |y.2.2 - d'| < η ∧
      y.1 - y.2.1 ∈ E₁ ∧ y.1 ∈ E₂ ∧ y.1 + ε y.2.1 y.2.2 ∈ E₂ ∧ y.1 + ε y.2.1 y.2.2 + y.2.2 ∈ E₁} := by
  sorry

/-- **Lemma S** (`plans/FS132-E3-derivation.md`, Stage 3, step M8): "*If (†) holds almost everywhere, `s` is almost
everywhere equal, on `J = (ψ_1 − κ_1/4, ψ_1 + κ_1/4)`, to a function with at most one jump.*" Here `S` is one level
set of `s`, (†) is `NoDoubleChange ε S t κ`, and "at most one jump" is: for some `t'`, almost every `θ` within `κ/4`
of `t` lies in `S` exactly when `θ < t'`, or exactly when `t' < θ` (`t'` outside the interval gives the two constant
cases). No colouring; any shift with `ShiftBounds ε κ` (a model: `shiftBounds_model`); a set satisfying the
hypothesis: a half-line (the `example` below). -/
theorem step_lemma {ε : ℝ → ℝ → ℝ} {κ : ℝ} (hκ : 0 < κ) (hε : ShiftBounds ε κ) {S : Set ℝ} (hS : MeasurableSet S)
    {t : ℝ} (h : NoDoubleChange ε S t κ) :
    ∃ t' : ℝ, (∀ᵐ θ : ℝ, |θ - t| < κ / 4 → (θ ∈ S ↔ θ < t')) ∨
      (∀ᵐ θ : ℝ, |θ - t| < κ / 4 → (θ ∈ S ↔ t' < θ)) := by
  sorry

/-- **Model of the hypothesis of `step_lemma`**: a half-line is split by no two such pairs — a split pair
`(α − d, α)` has `α` at or past the end, and then `α + ε` and `α + ε + d'` are both past it. -/
example {ε : ℝ → ℝ → ℝ} {κ : ℝ} (hε : ShiftBounds ε κ) (t t' : ℝ) : NoDoubleChange ε (Set.Iio t') t κ :=
  Eventually.of_forall fun y _ h1 h2 h3 h4 ⟨ha, hb⟩ => by
    have hpos := hε.pos y.2.1 y.2.2 h1 h2 h3 h4
    simp only [Set.mem_Iio, not_lt] at ha hb
    by_cases h : y.1 - y.2.1 < t'
    · have h5 := ha.mp h
      have h7 := hb.mpr (by linarith)
      linarith
    · exact h (ha.mpr (by linarith [not_lt.mp h]))

/-- **M8, last line** ("By M1, `s` is not almost everywhere constant near `ψ_1`, so `s` is a step at `ψ_1`"): if
every neighbourhood of `t` meets `S` and `Sᶜ` in positive measure and `S` is a half-line with end `t'` near `t`,
up to a null set, then `t' = t`. -/
theorem step_at_of_change {S : Set ℝ} {t r : ℝ} (hr : 0 < r)
    (hchange : ∀ η : ℝ, 0 < η → 0 < volume (S ∩ Ioo (t - η) (t + η)) ∧ 0 < volume (Sᶜ ∩ Ioo (t - η) (t + η)))
    {t' : ℝ} (h : (∀ᵐ θ : ℝ, |θ - t| < r → (θ ∈ S ↔ θ < t')) ∨ (∀ᵐ θ : ℝ, |θ - t| < r → (θ ∈ S ↔ t' < θ))) :
    t' = t := by
  sorry

/-- **M3, first sentence** ("`W_k(κ)` has positive measure for every `κ > 0`: otherwise `s(α) = s(α − d)` for almost
every `α` within `κ` of `ψ_{k+1}` and `0 < d < κ`, so … `s` is almost everywhere constant there"): at a point `t`
every neighbourhood of which meets `S` and `Sᶜ` in positive measure, the pairs `(α, d)` with `|α − t| < κ`,
`0 < d < κ` and exactly one of `α`, `α − d` in `S` have positive measure, for every `κ > 0`. -/
theorem volume_change_pairs_pos {S : Set ℝ} (hS : MeasurableSet S) {t : ℝ}
    (hchange : ∀ η : ℝ, 0 < η → 0 < volume (S ∩ Ioo (t - η) (t + η)) ∧ 0 < volume (Sᶜ ∩ Ioo (t - η) (t + η)))
    {κ : ℝ} (hκ : 0 < κ) :
    0 < volume {x : ℝ × ℝ | |x.1 - t| < κ ∧ 0 < x.2 ∧ x.2 < κ ∧ (x.1 ∈ S ↔ x.1 - x.2 ∉ S)} := by
  sorry

end HadwigerNelson.SixRing
