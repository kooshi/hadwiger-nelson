import Proofs.HadwigerNelson.Plane.SixRing.Confine

/-!
# The first night's exclusion (FS-132, C132-M-ORBIT): the objects its leaves are stated over

Definitions only, with one model or drift check each; every other module of the exclusion imports this one and none
edits it. For a colouring `c` of **the whole plane** and a centre `p` (the claim list's dated line: the instance `U = ℂ`).

* `hub p ψ n` — the ring point `y_n = p + e(ψ + nπ/3)` of the derivation (`plans/FS132-E3-derivation.md`, Stage 3,
  § Argument — the orbit form).
* `chart p α d` — the derivation's chart `Z(α, d) = p + e(α) + e(α − 2π/3 − d)` (step M2): the point at distance `1`
  from the two ring points at angles `α` and `α − 2π/3 − d`; inside the unit disc about `p` exactly when `d > 0`.
* `ringRadius d = 2 cos(π/3 + d/2)` — its distance from `p`; `shift d d'` — the derivation's `ε(d, d')` (step M7), by
  the planner's explicit formula: the points `chart p α d` and `chart p (α + ε + d' + π/3) d'` are at distance `1`.
* `ShiftBounds ε κ` — what steps M8 and M9 use of `ε` on `(0, κ)²`: positive, at most `min(d, d')/16`, and
  `1/32`-Lipschitz in each variable.
* `IsTip c p y i` — the derivation's `Tip` (step M3): `y` is in the closure of the part of the essential support of
  the label `i` inside the open unit disc about `p`.
* `OutsideOrbit c hc p X Y ψ δ` — the ring hypothesis of C132-M-ORBIT: clauses (i) and (ii).
* `HubColours`, `NoDoubleChange` — the two almost-everywhere statements the analytic core passes between its leaves:
  what the colouring does in the chart near a hub (M2's (⋆) with M5's restriction), and the derivation's (†) (M8).
-/

open MeasureTheory Filter Topology
open scoped RealInnerProductSpace

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-- The hub `y_n` of the orbit at base angle `ψ`: the point of the unit circle about `p` at angle `ψ + nπ/3`. -/
noncomputable def hub (p : ℂ) (ψ : ℝ) (n : ℤ) : ℂ := p + Plane.e (ψ + n * (Real.pi / 3))

/-- The chart `Z(α, d) = p + e(α) + e(α − 2π/3 − d)` of the derivation's step M2. -/
noncomputable def chart (p : ℂ) (α d : ℝ) : ℂ := p + Plane.e α + Plane.e (α - 2 * Real.pi / 3 - d)

/-- `r(d) = 2 cos(π/3 + d/2)`: the distance of `chart p α d` from `p` (for `d` near `0`). -/
noncomputable def ringRadius (d : ℝ) : ℝ := 2 * Real.cos (Real.pi / 3 + d / 2)

/-- The shift `ε(d, d')` of the derivation's step M7, by an explicit formula (`plans/FS132-kernel-plan.md` § 3.2):
`arccos((r² + r'² − 1)/(2 r r')) − π/3 − (d + d')/2` with `r = ringRadius d`, `r' = ringRadius d'`. For small
`d, d' ≥ 0` the points `chart p α d` and `chart p (α + ε + d' + π/3) d'` are at distance `1`
(`dist_chart_chart_shift`). -/
noncomputable def shift (d d' : ℝ) : ℝ :=
  Real.arccos ((ringRadius d ^ 2 + ringRadius d' ^ 2 - 1) / (2 * ringRadius d * ringRadius d'))
    - Real.pi / 3 - (d + d') / 2

/-- What the derivation's steps M8 and M9 use of the shift `ε` on the open square `(0, κ)²`: it is positive, at most
`d/16` and at most `d'/16`, and `1/32`-Lipschitz in each variable. Inhabited by `shiftBounds_model` (a product) and,
for the shift of the chart, by `exists_shiftBounds` (`Plane/SixRing/Shift`). -/
structure ShiftBounds (ε : ℝ → ℝ → ℝ) (κ : ℝ) : Prop where
  /-- The shift is positive. -/
  pos : ∀ d d' : ℝ, 0 < d → d < κ → 0 < d' → d' < κ → 0 < ε d d'
  /-- The shift is at most a sixteenth of its first argument. -/
  le_left : ∀ d d' : ℝ, 0 < d → d < κ → 0 < d' → d' < κ → ε d d' ≤ d / 16
  /-- The shift is at most a sixteenth of its second argument. -/
  le_right : ∀ d d' : ℝ, 0 < d → d < κ → 0 < d' → d' < κ → ε d d' ≤ d' / 16
  /-- The shift is `1/32`-Lipschitz in its first argument. -/
  lip_left : ∀ d₁ d₂ d' : ℝ, 0 < d₁ → d₁ < κ → 0 < d₂ → d₂ < κ → 0 < d' → d' < κ →
    |ε d₁ d' - ε d₂ d'| ≤ |d₁ - d₂| / 32
  /-- The shift is `1/32`-Lipschitz in its second argument. -/
  lip_right : ∀ d d'₁ d'₂ : ℝ, 0 < d → d < κ → 0 < d'₁ → d'₁ < κ → 0 < d'₂ → d'₂ < κ →
    |ε d d'₁ - ε d d'₂| ≤ |d'₁ - d'₂| / 32

/-- The bounds pass to a smaller square. -/
theorem ShiftBounds.mono {ε : ℝ → ℝ → ℝ} {κ κ' : ℝ} (h : ShiftBounds ε κ) (hκ : κ' ≤ κ) : ShiftBounds ε κ' where
  pos d d' h1 h2 h3 h4 := h.pos d d' h1 (h2.trans_le hκ) h3 (h4.trans_le hκ)
  le_left d d' h1 h2 h3 h4 := h.le_left d d' h1 (h2.trans_le hκ) h3 (h4.trans_le hκ)
  le_right d d' h1 h2 h3 h4 := h.le_right d d' h1 (h2.trans_le hκ) h3 (h4.trans_le hκ)
  lip_left d₁ d₂ d' h1 h2 h3 h4 h5 h6 :=
    h.lip_left d₁ d₂ d' h1 (h2.trans_le hκ) h3 (h4.trans_le hκ) h5 (h6.trans_le hκ)
  lip_right d d'₁ d'₂ h1 h2 h3 h4 h5 h6 :=
    h.lip_right d d'₁ d'₂ h1 (h2.trans_le hκ) h3 (h4.trans_le hκ) h5 (h6.trans_le hκ)

/-- **Model of `ShiftBounds`, every clause exercised**: the product `d d' / 16` on the square `(0, 1/2)²`. (The
chart's shift is `(2/√3) d d' + …`: the same shape.) -/
theorem shiftBounds_model : ShiftBounds (fun d d' => d * d' / 16) (1 / 2) where
  pos d d' h1 _ h3 _ := by positivity
  le_left d d' h1 _ _ h4 := by nlinarith
  le_right d d' _ h2 h3 _ := by nlinarith
  lip_left d₁ d₂ d' _ _ _ _ h5 h6 := by
    have h : d₁ * d' / 16 - d₂ * d' / 16 = (d₁ - d₂) * (d' / 16) := by ring
    rw [h, abs_mul, abs_of_pos (by positivity : 0 < d' / 16)]
    nlinarith [abs_nonneg (d₁ - d₂)]
  lip_right d d'₁ d'₂ h1 h2 _ _ _ _ := by
    have h : d * d'₁ / 16 - d * d'₂ / 16 = (d'₁ - d'₂) * (d / 16) := by ring
    rw [h, abs_mul, abs_of_pos (by positivity : 0 < d / 16)]
    nlinarith [abs_nonneg (d'₁ - d'₂)]

/-- The derivation's `Tip` (step M3), as a predicate on a point `y` and a label `i`: `y` lies in the closure of the
essential support of the class of `i` intersected with the open unit disc about `p`. For any number of labels. -/
def IsTip {k : ℕ} (c : ℂ → Fin k) (p y : ℂ) (i : Fin k) : Prop :=
  y ∈ closure (spatialSupport c i ∩ Metric.ball p 1)

/-- **The ring hypothesis of C132-M-ORBIT** at the centre `p`, base angle `ψ` and width `δ`, for two labels `X`, `Y`:
(i) for every integer `n` and almost every `θ` with `|θ − ψ − nπ/3| < δ` the palette at `p` in the direction `θ`
contains `X` or `Y`; (ii) for every `η > 0` the `θ` in `(ψ − η, ψ + η)` whose palette contains `X`, and those whose
palette contains `Y`, both have positive measure. Stated for any number of labels: steps M1–M3 and the analytic core
(M7–M9) spend no count.

Together with a weak six-colouring and a four-cycle of straddle exclusions these hypotheses are refuted
(`no_outside_orbit_points`); whether a weak colouring with `k ≥ 7` labels satisfies them at some centre is not known
to this library. Without weakness they are satisfied — not proved here — by the two-colouring of the plane by a
line through `p` (`X` on one side, `Y` on the other), at the line's direction. -/
structure OutsideOrbit {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c) (p : ℂ) (X Y : Fin k) (ψ δ : ℝ) : Prop where
  /-- The width is positive. -/
  pos : 0 < δ
  /-- Clause (i): an outside label in almost every palette near each of the six directions. -/
  outside : ∀ n : ℤ, ∀ᵐ θ : ℝ, |θ - ψ - n * (Real.pi / 3)| < δ →
    X ∈ palette c hc p (θ : Angles) ∨ Y ∈ palette c hc p (θ : Angles)
  /-- Clause (ii): both outside labels in positive measure in every neighbourhood of `ψ`. -/
  change : ∀ η : ℝ, 0 < η →
    0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ X ∈ palette c hc p (θ : Angles)} ∧
    0 < volume {θ : ℝ | θ ∈ Set.Ioo (ψ - η) (ψ + η) ∧ Y ∈ palette c hc p (θ : Angles)}

/-- **What the colouring does in the chart near a hub, inside the ring** (the derivation's (⋆) of step M2 together
with M5's "almost every point carries the tip, `X` or `Y`"): for almost every `(α, d)` with `|α − t| < κ` and
`0 < d < κ`, the colour at `chart p α d` is `b`, `X` or `Y`; it is not `X` when `α` or `α − d` lies in `S`, and not
`Y` when `α` or `α − d` lies outside `S`. Here `S` is the set of angles whose palette holds `X` (near the angle `t`,
the chart's centre), and `b` the hub's one tip. -/
def HubColours {k : ℕ} (c : ℂ → Fin k) (p : ℂ) (b X Y : Fin k) (S : Set ℝ) (t κ : ℝ) : Prop :=
  ∀ᵐ x : ℝ × ℝ, |x.1 - t| < κ → 0 < x.2 → x.2 < κ →
    (c (chart p x.1 x.2) = b ∨ c (chart p x.1 x.2) = X ∨ c (chart p x.1 x.2) = Y) ∧
    (x.1 ∈ S ∨ x.1 - x.2 ∈ S → c (chart p x.1 x.2) ≠ X) ∧
    (x.1 ∉ S ∨ x.1 - x.2 ∉ S → c (chart p x.1 x.2) ≠ Y)

/-- The statement holds on a smaller box. -/
theorem HubColours.mono {k : ℕ} {c : ℂ → Fin k} {p : ℂ} {b X Y : Fin k} {S : Set ℝ} {t κ κ' : ℝ}
    (h : HubColours c p b X Y S t κ) (hκ : κ' ≤ κ) : HubColours c p b X Y S t κ' :=
  Filter.Eventually.mono h fun _ hx h1 h2 h3 => hx (h1.trans_le hκ) h2 (h3.trans_le hκ)

/-- **The derivation's (†)** (step M8), for a set `S` of angles and a shift `ε`: for almost every `(α, d, d')` with
`|α − t| < κ` and `0 < d, d' < κ`, the pair `(α − d, α)` and the pair `(α + ε, α + ε + d')`, `ε = ε d d'`, are not
both split by `S`. -/
def NoDoubleChange (ε : ℝ → ℝ → ℝ) (S : Set ℝ) (t κ : ℝ) : Prop :=
  ∀ᵐ y : ℝ × ℝ × ℝ, |y.1 - t| < κ → 0 < y.2.1 → y.2.1 < κ → 0 < y.2.2 → y.2.2 < κ →
    ¬ ((y.1 - y.2.1 ∈ S ↔ y.1 ∉ S) ∧
      (y.1 + ε y.2.1 y.2.2 ∈ S ↔ y.1 + ε y.2.1 y.2.2 + y.2.2 ∉ S))

/-! ## Drift checks -/

/-- `hub`: the hub of index `0` at base angle `0` about the origin is `1`. -/
example : hub 0 0 0 = 1 := by simp [hub, Plane.e]

/-- `chart`: at `d = 0` and `α = π/3` (about the origin) the chart is the ring point at angle `0`, the sum of the unit
vectors at `±π/3`. -/
example : chart 0 (Real.pi / 3) 0 = Plane.e (Real.pi / 3) + Plane.e (-(Real.pi / 3)) := by
  simp only [chart, zero_add, sub_zero]
  congr 2
  ring

/-- `ringRadius`: the chart is on the unit circle at `d = 0`. -/
example : ringRadius 0 = 1 := by
  simp only [ringRadius, zero_div, add_zero, Real.cos_pi_div_three]
  norm_num

/-- `IsTip` is a statement about the open unit disc: a label used nowhere tips nothing, since its essential support
is empty. -/
example (p y : ℂ) : ¬ IsTip (fun _ : ℂ => (0 : Fin 2)) p y 1 := by
  have h : spatialSupport (fun _ : ℂ => (0 : Fin 2)) 1 = ∅ := by
    simp [spatialSupport]
  simp [IsTip, h]

end HadwigerNelson.SixRing
