import Proofs.HadwigerNelson.Plane.Suprema
import Proofs.HadwigerNelson.Plane.CPColouring
import Mathlib.MeasureTheory.Measure.Lebesgue.VolumeOfBalls

/-!
# Rescaling, the suprema's limits, the equivalence, kept points, the face lemma (FS-131 wave 2)

Rows: **FS111-V0-RESCALE**, **FS129-SR2-SUPK** (carrying FS106-SUP), **FS106-EQ**, **FS106-COMP** (second clause),
**FS106-REM**, **FS121-D4-FACE** (with FS121-V5-FACE-SHARP's hypothesis), **FS121-V5-FACE-SHARP**.
Plan: `plans/FS131-w2-kernel-plan.md` § 4.

**Named hypothesis from outside the backlog** (`plans/FS131-kernel-plan.md` § 7.4): `Row130M1`, FS-103's M1 in its
hard direction (`χ_m⁰(ℝ²) ≤ k ⟹ χ_CP(ℝ²) ≤ k`, row 130's last equality; [hand, two minds]) — a stationary limit of
translates (Krylov–Bogolyubov) with the Rajchman step. It enters only FS106-EQ's `χ_CP` clause; its own path to the kernel is
a separate planner-and-implementer job (FS-103's M1 module). The easy direction is formalized here unconditionally.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-- `x` is **kept** at scale `ε` for the class `A` with threshold `η`: the balls of radii `ε/2` and `2ε` about `x` are at
least `1 − η` full of `Ã` (FS106-TQ § 2.2). -/
def KeptAt (A : Set ℂ) (η ε : ℝ) (x : ℂ) : Prop :=
  ∀ ρ ∈ ({ε / 2, 2 * ε} : Set ℝ), ENNReal.ofReal (1 - η) * volume (ball x ρ) ≤ volume (ball x ρ ∩ densitySet A)

/-- The open half-box `{x − s e + t e⊥ : 0 < s < ε, |t| < ε}`, `e = e θ`, `e⊥ = i e θ`. -/
def halfBox (x : ℂ) (θ ε : ℝ) : Set ℂ :=
  {z | ∃ s t : ℝ, 0 < s ∧ s < ε ∧ |t| < ε ∧ z = x + e θ * (-s + t * I)}

/-- The open far box `{x + s e + t e⊥ : g < s < g + ε′, |t| < ρ}`. -/
def farBox (x : ℂ) (θ g ε' ρ : ℝ) : Set ℂ :=
  {z | ∃ s t : ℝ, g < s ∧ s < g + ε' ∧ |t| < ρ ∧ z = x + e θ * (s + t * I)}

/-! ## FS131-K2c: children of the remaining leaves

Each child is `sorry`ed and priced in `plans/FS131-w2-kernel-plan.md` § 12 (route, Mathlib names confirmed with `#check`, order).
A leaf whose proof is still `sorry` is closed from its children by the assembly the plan describes. -/

/-! ### Radius bands and the pair mass at one radius (`exists_tight`, SUPK's upper bound) -/

/-- The pairs of `A` at a distance in `[a, b]` are `Leb ⊗ Leb`-null (the radius form of `BandNull`). -/
def IccPairNull (A : Set ℂ) (a b : ℝ) : Prop :=
  (volume.prod volume) {q : ℂ × ℂ | q.1 ∈ A ∧ q.2 ∈ A ∧ a ≤ dist q.1 q.2 ∧ dist q.1 q.2 ≤ b} = 0

theorem bandNull_iff_iccPairNull (A : Set ℂ) (ε : ℝ) : BandNull A ε ↔ IccPairNull A (1 - ε) (1 + ε) := Iff.rfl

/-- The mass of the pairs `(x, θ)`, `x ∈ A ∩ B(0, R)`, `x + r e θ ∈ A` (`Leb ⊗ σ`): the unit-pair mass at radius `r`. -/
noncomputable def pairMass (A : Set ℂ) (R r : ℝ) : ENNReal :=
  (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ A ∩ ball 0 R ∧ q.1 + (r : ℂ) * e q.2 ∈ A}

theorem IccPairNull.mono {A : Set ℂ} {a b a' b' : ℝ} (h : IccPairNull A a b) (ha : a ≤ a') (hb : b' ≤ b) :
    IccPairNull A a' b' := by
  sorry

theorem IccPairNull.union {A : Set ℂ} {a b c : ℝ} (h1 : IccPairNull A a b) (h2 : IccPairNull A b c) :
    IccPairNull A a c := by
  sorry

/-- The pairs at one exact distance are `Leb ⊗ Leb`-null (a circle is null in each slice). -/
theorem volume_prod_dist_eq_null (r : ℝ) : (volume.prod volume) {q : ℂ × ℂ | dist q.1 q.2 = r} = 0 := by
  sorry

/-- Null on `[a', b]` for every `a' > a` gives null on `[a, b]` (a countable union and one null sphere). -/
theorem iccPairNull_of_forall_lt {A : Set ℂ} {a b : ℝ} (h : ∀ a', a < a' → a' ≤ b → IccPairNull A a' b) :
    IccPairNull A a b := by
  sorry

theorem unitPairsNull_iff_pairMass {A : Set ℂ} : UnitPairsNull A ↔ ∀ R : ℝ, pairMass A R 1 = 0 := by
  sorry

/-- **Continuity of the pair mass in the radius** (I2c's finding): `L¹` continuity of translation
(`MeasureTheory.Lp.instContinuousVAddDomAddAct`, or `MemLp.exists_hasCompactSupport_eLpNorm_sub_le` and uniform
continuity), integrated over the angle. -/
theorem continuous_pairMass {A : Set ℂ} (hA : MeasurableSet A) (R : ℝ) : Continuous (pairMass A R) := by
  sorry

/-- **Polar coordinates for pairs** (`Complex.lintegral_comp_polarCoord_symm` and Tonelli): a radius band null in
`Leb ⊗ Leb` has null pair mass at almost every radius inside it. -/
theorem ae_pairMass_eq_zero {A : Set ℂ} (hA : MeasurableSet A) {a b : ℝ} (ha : 0 < a) (h : IccPairNull A a b) (R : ℝ) :
    ∀ᵐ r ∂volume, r ∈ Ioo a b → pairMass A R r = 0 := by
  sorry

/-- From `ae_pairMass_eq_zero` and `continuous_pairMass`: null at every radius of the closed band. -/
theorem pairMass_eq_zero_of_iccPairNull {A : Set ℂ} (hA : MeasurableSet A) {a b : ℝ} (ha : 0 < a) (hab : a < b)
    (h : IccPairNull A a b) (R : ℝ) : ∀ r ∈ Icc a b, pairMass A R r = 0 := by
  sorry

/-- Rescaling by `s`: radius bands of `x ↦ A (s x)` are radius bands of `A` scaled by `s` (volume scales by `s⁴`). -/
theorem iccPairNull_preimage_mul {A : Set ℂ} {s a b : ℝ} (hs : 0 < s) :
    IccPairNull ((fun x : ℂ => (s : ℂ) * x) ⁻¹' A) a b ↔ IccPairNull A (s * a) (s * b) := by
  sorry

/-- The rescaled colouring `x ↦ c (s x)` is an `AeColouring` when `c`'s pair mass at radius `s` vanishes. -/
theorem AeColouring.exists_rescale (c : AeColouring k) {s : ℝ} (hs : 0 < s)
    (h : ∀ j R, pairMass (c.cls j) R s = 0) : ∃ c' : AeColouring k, ∀ x, c'.col x = c.col ((s : ℂ) * x) := by
  sorry

/-- A class of positive measure has non-null pairs at distances in `[a, 1]` for some `a > 0` (a density point `x` and
`r ≤ 1/2` with density `≥ 9/10` in `B(x, r)` give positive mass to pairs at distance in `[r/2, 2r]`). -/
theorem AeColouring.exists_pos_not_iccPairNull (c : AeColouring k) : ∃ a > 0, ∃ j, ¬ IccPairNull (c.cls j) a 1 := by
  sorry

/-! ### SUPK: the upper bounds, windows, kept points, periodization -/

/-- A band-null measurable class (`0 < ε < 1`) has null unit pairs (`pairMass_eq_zero_of_iccPairNull` at `r = 1`). -/
theorem bandNull_unitPairsNull {A : Set ℂ} (hA : MeasurableSet A) {ε : ℝ} (hε0 : 0 < ε) (hε1 : ε < 1)
    (h : BandNull A ε) : UnitPairsNull A := by
  sorry

theorem mu_le_muZero (k : ℕ) {ε : ℝ} (hε0 : 0 < ε) (hε1 : ε < 1) : mu k ε ≤ muZero k := by
  sorry

theorem muTile_le_mu (k : ℕ) (ε : ℝ) : muTile k ε ≤ mu k ε := by
  sorry

theorem muPer_le_muTile (k : ℕ) (ε : ℝ) : muPer k ε ≤ muTile k ε := by
  sorry

/-- The half-open square window `[z, z + ℓ)²`. -/
def squareWin (z : ℂ) (ℓ : ℝ) : Set ℂ := {w | z.re ≤ w.re ∧ w.re < z.re + ℓ ∧ z.im ≤ w.im ∧ w.im < z.im + ℓ}

/-- **The window lemma**: a set of upper density above `d` fills some `ℓ`-grid square of side `ℓ` to at least `d`, for
every integer side `ℓ` (average over the grid squares meeting a large ball `B(0, R)`; `ℓ/R → 0`). -/
theorem exists_squareWin_dense {S : Set ℂ} (hS : MeasurableSet S) {d : ℝ} (hd : ENNReal.ofReal d < upperDensity S)
    (ℓ : ℕ) (hℓ : 0 < ℓ) :
    ∃ p q : ℤ, ENNReal.ofReal (d * (ℓ : ℝ) ^ 2) ≤ volume (S ∩ squareWin ((ℓ * p : ℝ) + (ℓ * q : ℝ) * I) ℓ) := by
  sorry

/-- Almost every point of a measurable set is kept at every small scale (Lebesgue density: `ae_restrict_mem_densitySet`,
with `volume_densitySet_diff` and `volume_diff_densitySet`). -/
theorem ae_eventually_keptAt {A : Set ℂ} (hA : MeasurableSet A) {η : ℝ} (hη : 0 < η) :
    ∀ᵐ x ∂(volume.restrict A), ∀ᶠ ε in 𝓝[>] (0 : ℝ), KeptAt A η ε x := by
  sorry

/-- Keeping is robust: kept at threshold `η/2` gives kept at `η` within `ηε/12` (`ball x ρ ⊆ ball x' (ρ + d)`, so the
lost area is at most `π(2ρd + d²) ≤ 3πρd`). -/
theorem keptAt_of_dist_le {A : Set ℂ} {η ε : ℝ} (hε : 0 < ε) (hη : 0 ≤ η) (hη1 : η ≤ 1) {x x' : ℂ}
    (hx : KeptAt A (η / 2) ε x) (hd : dist x x' ≤ η * ε / 12) : KeptAt A η ε x' := by
  sorry

/-- The periodization of `T` with period `L` in both coordinates. -/
def periodize (T : Set ℂ) (L : ℝ) : Set ℂ := {x | ∃ m n : ℤ, x - ((m * L : ℝ) + (n * L : ℝ) * I) ∈ T}

theorem isPeriodicSet_periodize (T : Set ℂ) (L : ℝ) : IsPeriodicSet L (periodize T L) := by
  sorry

theorem measurableSet_periodize {T : Set ℂ} (hT : MeasurableSet T) (L : ℝ) : MeasurableSet (periodize T L) := by
  sorry

theorem isGridUnion_periodize {T : Set ℂ} {h : ℝ} (hh : 0 < h) {N : ℕ} (hT : IsGridUnion h T) :
    IsGridUnion h (periodize T (N * h)) := by
  sorry

/-- Copies of a window of side `ℓ` at period `ℓ + 2` are `2` apart, beyond every band distance when `ε < 1`. -/
theorem bandFree_periodize {T : Set ℂ} {z : ℂ} {ℓ ε : ℝ} (hT : T ⊆ squareWin z ℓ) (hε : ε < 1) (h : BandFree T ε) :
    BandFree (periodize T (ℓ + 2)) ε := by
  sorry

theorem disjoint_periodize {T T' : Set ℂ} {z : ℂ} {ℓ : ℝ} (hT : T ⊆ squareWin z ℓ) (hT' : T' ⊆ squareWin z ℓ)
    (h : Disjoint T T') : Disjoint (periodize T (ℓ + 2)) (periodize T' (ℓ + 2)) := by
  sorry

theorem iUnion_periodize {T : Fin k → Set ℂ} (L : ℝ) : ⋃ j, periodize (T j) L = periodize (⋃ j, T j) L := by
  sorry

/-- **The density of a lattice-periodic set** (stage 9.2's `upperDensity_of_periodic`): for an `ℝ`-basis `v₁, v₂` and a
measurable `S` invariant under `ℤv₁ + ℤv₂`, `d̄(S) = |S ∩ D| / |D|` with `D = {s v₁ + t v₂ : s, t ∈ [0, 1)}` (count the
translates of `D` inside and meeting `B(0, R)`; `ZLattice.covolume.tendsto_card_div_pow`). Carries DISC7's density and
`upperDensity_periodize`. -/
theorem upperDensity_of_periodic {v₁ v₂ : ℂ} (hv : LinearIndependent ℝ ![v₁, v₂]) {S : Set ℂ} (hS : MeasurableSet S)
    (hper : ∀ x, (x + v₁ ∈ S ↔ x ∈ S) ∧ (x + v₂ ∈ S ↔ x ∈ S)) :
    upperDensity S = volume (S ∩ {x | ∃ s t : ℝ, s ∈ Ico (0 : ℝ) 1 ∧ t ∈ Ico (0 : ℝ) 1 ∧ x = s * v₁ + t * v₂}) /
      volume {x : ℂ | ∃ s t : ℝ, s ∈ Ico (0 : ℝ) 1 ∧ t ∈ Ico (0 : ℝ) 1 ∧ x = s * v₁ + t * v₂} := by
  sorry

theorem upperDensity_periodize {T : Set ℂ} (hT : MeasurableSet T) {z : ℂ} {ℓ : ℝ} (hℓ : 0 < ℓ)
    (hTw : T ⊆ squareWin z ℓ) : upperDensity (periodize T (ℓ + 2)) = volume T / ENNReal.ofReal ((ℓ + 2) ^ 2) := by
  sorry

/-- **Inner pixelation of the kept sets**: in a window of `N × N` cells of side `h` (`h√2 ≤ ηε/12`), the cells meeting the
`η/2`-kept set of some class, each given its least such class, are a tiled partial colouring inside the window whose
classes lie in the `η`-kept sets (`keptAt_of_dist_le`) and which covers the window's `η/2`-kept points. -/
theorem exists_tiled_kept {C : Fin k → Set ℂ} {η ε h : ℝ} (hh : 0 < h) (hhε : h * √2 ≤ η * ε / 12) (hη : 0 ≤ η)
    (hη1 : η ≤ 1) (hε : 0 < ε) (p q : ℤ) (N : ℕ) :
    ∃ T : Fin k → Set ℂ, IsPartialColouring T ∧ (∀ j, IsGridUnion h (T j)) ∧
      (∀ j, T j ⊆ squareWin ((p * h : ℝ) + (q * h : ℝ) * I) (N * h)) ∧ (∀ j, T j ⊆ {x | KeptAt (C j) η ε x}) ∧
      squareWin ((p * h : ℝ) + (q * h : ℝ) * I) (N * h) ∩ ⋃ j, {x | KeptAt (C j) (η / 2) ε x} ⊆ ⋃ j, T j := by
  sorry

/-- **SUPK's lower bound** (FS106-TQ § 3.2, by windows instead of Lemma T): every value below `µ_k⁰` is eventually below
`µ_k^per(ε)`. Assembly: a family with null unit pairs of density `> d`; `exists_squareWin_dense` at an integer side `ℓ`;
`ae_eventually_keptAt` and dominated convergence on the window at `η = 1/20`; `exists_tiled_kept` at `h = 1/N`;
`keptAt_band` (band-free); `periodize` at period `ℓ + 2` (`bandFree_periodize`, `isGridUnion_periodize`,
`upperDensity_periodize`); `ℓ²/(ℓ + 2)² → 1`. -/
theorem eventually_le_muPer (k : ℕ) {d : ENNReal} (hd : d < muZero k) : ∀ᶠ ε in 𝓝[>] (0 : ℝ), d ≤ muPer k ε := by
  sorry

/-! ### `keptAt_band`: the two cases -/

/-- The area of a disc, in `ofReal` form. -/
theorem volume_ball_ofReal (z : ℂ) {ρ : ℝ} (hρ : 0 ≤ ρ) : volume (ball z ρ) = ENNReal.ofReal (ρ ^ 2 * Real.pi) := by
  rw [Complex.volume_ball, ENNReal.ofReal_mul (sq_nonneg ρ), ENNReal.ofReal_pow hρ, ← NNReal.coe_real_pi,
    ENNReal.ofReal_coe_nnreal]

/-- A measurable set equals its density set up to a null set. -/
theorem ae_eq_densitySet {A : Set ℂ} (hA : MeasurableSet A) : A =ᵐ[volume] densitySet A :=
  ae_eq_set.2 ⟨volume_diff_densitySet hA, volume_densitySet_diff hA⟩

/-- The kept-ball inequality read for `A` itself, and the hole bound it gives. -/
theorem keptBall_of_le {A : Set ℂ} (hA : MeasurableSet A) {x : ℂ} {ρ η : ℝ} (hη0 : 0 ≤ η) (hη1 : η ≤ 1)
    (h : ENNReal.ofReal (1 - η) * volume (ball x ρ) ≤ volume (ball x ρ ∩ densitySet A)) :
    ENNReal.ofReal (1 - η) * volume (ball x ρ) ≤ volume (ball x ρ ∩ A) ∧
      volume (ball x ρ \ A) ≤ ENNReal.ofReal η * volume (ball x ρ) := by
  have h1 : volume (ball x ρ ∩ A) = volume (ball x ρ ∩ densitySet A) :=
    measure_congr (ae_eq_set_inter (ae_eq_refl _) (ae_eq_densitySet hA))
  rw [← h1] at h
  refine ⟨h, ?_⟩
  have hsplit := measure_inter_add_sdiff (μ := volume) (ball x ρ) hA
  have hfin : volume (ball x ρ) ≠ ⊤ := measure_ball_lt_top.ne
  have hsum : ENNReal.ofReal (1 - η) * volume (ball x ρ) + ENNReal.ofReal η * volume (ball x ρ) = volume (ball x ρ) := by
    rw [← add_mul, ← ENNReal.ofReal_add (by linarith) hη0]; simp
  have hc : ENNReal.ofReal (1 - η) * volume (ball x ρ) ≠ ⊤ := ENNReal.mul_ne_top ENNReal.ofReal_ne_top hfin
  rw [← ENNReal.add_le_add_iff_left hc, hsum]
  calc _ ≤ volume (ball x ρ ∩ A) + volume (ball x ρ \ A) := by gcongr
    _ = _ := hsplit

/-- `keptAt_band` at `ε ≤ 1/2` (FS106-TQ § 2.2): `twoBall_pairs_ge` at `r = ε` on `Ã` (null unit pairs by
`UnitPairsNull.congr_ae`) gives unit-pair mass `≥ ε³(π(1 − η)/2 − 2π²η) > 0`, since `η < 1/(1 + 4π)`. -/
theorem keptAt_band_le_half {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {η : ℝ} (hη0 : 0 ≤ η)
    (hη : η < 1 / (1 + 4 * Real.pi)) {ε : ℝ} (hε : 0 < ε) (hε2 : ε ≤ 1 / 2) {x y : ℂ} (hx : KeptAt A η ε x)
    (hy : KeptAt A η ε y) : dist x y < 1 - ε ∨ 1 + ε < dist x y := by
  by_contra hcon
  push Not at hcon
  have habs : |dist x y - 1| ≤ ε := abs_le.2 ⟨by linarith [hcon.1], by linarith [hcon.2]⟩
  have hp := twoBall_pairs_ge hA hε hε2 habs
  have hpi := Real.pi_pos
  have hη1 : η ≤ 1 := by
    have : 1 / (1 + 4 * Real.pi) ≤ 1 := by rw [div_le_one (by positivity)]; linarith
    linarith
  have hz : (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ A ∩ ball x (ε / 2) ∧ q.1 + e q.2 ∈ A ∩ ball y (2 * ε)} = 0 :=
    measure_mono_null (fun q hq => (⟨hq.1.1, hq.2.1⟩ : q ∈ unitPairSet A)) hnull
  rw [hz, zero_add] at hp
  obtain ⟨hx1, -⟩ := keptBall_of_le hA hη0 hη1 (hx (ε / 2) (by simp))
  obtain ⟨-, hy2⟩ := keptBall_of_le hA hη0 hη1 (hy (2 * ε) (by simp))
  have hv1 := fun (z : ℂ) (ρ : ℝ) (h : 0 ≤ ρ) => volume_ball_ofReal z h
  have hmain : ENNReal.ofReal (2 * ε) * (ENNReal.ofReal (1 - η) * ENNReal.ofReal ((ε / 2) ^ 2 * Real.pi)) ≤
      ENNReal.ofReal (Real.pi * ε / 2) * (ENNReal.ofReal η * ENNReal.ofReal ((2 * ε) ^ 2 * Real.pi)) := by
    rw [hv1 x _ (by positivity)] at hx1
    rw [hv1 y _ (by positivity)] at hy2
    calc _ ≤ ENNReal.ofReal (2 * ε) * volume (A ∩ ball x (ε / 2)) := by
          rw [inter_comm]; gcongr
      _ ≤ _ := hp
      _ ≤ _ := by gcongr
  rw [← ENNReal.ofReal_mul (by positivity), ← ENNReal.ofReal_mul (by positivity),
    ← ENNReal.ofReal_mul (by positivity), ← ENNReal.ofReal_mul (by positivity),
    ENNReal.ofReal_le_ofReal_iff (by positivity)] at hmain
  have hε3 : 0 < ε ^ 3 := by positivity
  have : η * (1 + 4 * Real.pi) < 1 := by
    rwa [lt_div_iff₀ (by positivity)] at hη
  nlinarith [mul_pos hε3 hpi, mul_pos (mul_pos hε3 hpi) hpi]

/-- At `ε > 1/2` no point is kept: `B(x, 2ε)` has radius `> 1`, `arcLength_bigBall_ge` gives its pairs mass `≥ (2π/3)|B|`,
and filling `1 − η` of it with `Ã` leaves unit-pair mass `≥ ((2π/3)(1 − η) − 2πη)|B| > 0` for `η < 1/4`. -/
theorem not_keptAt_of_half_lt {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {η : ℝ} (hη0 : 0 ≤ η)
    (hη : η < 1 / 4) {ε : ℝ} (hε : 1 / 2 < ε) (x : ℂ) : ¬ KeptAt A η ε x := by
  intro hk
  have hpi := Real.pi_pos
  have hη1 : η ≤ 1 := by linarith
  obtain ⟨hx1, hx2⟩ := keptBall_of_le hA hη0 hη1 (hk (2 * ε) (by simp))
  set B := ball x (2 * ε) with hB
  set U := A ∩ B with hU
  have hUm : MeasurableSet U := hA.inter measurableSet_ball
  have hBm : MeasurableSet B := measurableSet_ball
  have hN : MeasurableSet (B \ A) := hBm.diff hA
  have hlow : ENNReal.ofReal (2 * Real.pi / 3) * volume U ≤
      (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ B} := by
    rw [pairs_eq_lintegral hUm hBm]
    calc _ = ∫⁻ u in U, ENNReal.ofReal (2 * Real.pi / 3) := by
          rw [lintegral_const, Measure.restrict_apply_univ, mul_comm]
      _ ≤ _ := setLIntegral_mono' hUm fun u hu =>
          arcLength_bigBall_ge (by linarith) hu.2
  have hup : (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ B} ≤
      ENNReal.ofReal (2 * Real.pi) * volume (B \ A) := by
    have hsub : {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ B} ⊆
        {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ A} ∪ {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ B \ A} := by
      intro q hq
      by_cases h : q.1 + e q.2 ∈ A
      · exact Or.inl ⟨hq.1, h⟩
      · exact Or.inr ⟨hq.1, hq.2, h⟩
    have h0 : (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ A} = 0 :=
      measure_mono_null (fun q hq => (⟨hq.1.1, hq.2⟩ : q ∈ unitPairSet A)) hnull
    have h1 : (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ B \ A} ≤
        ENNReal.ofReal (2 * Real.pi) * volume (B \ A) :=
      pairs_le_of_arc hUm hN fun v => by
        calc arcLength {θ | v - e θ ∈ U} ≤ arcLength univ := measure_mono (subset_univ _)
          _ = _ := by simp [arcLength, Real.volume_Ico]
    calc _ ≤ _ := measure_mono hsub
      _ ≤ _ := measure_union_le _ _
      _ ≤ 0 + _ := by rw [h0]; gcongr
      _ = _ := zero_add _
  have hv1 : volume B = ENNReal.ofReal ((2 * ε) ^ 2 * Real.pi) := volume_ball_ofReal x (by positivity)
  have hmain : ENNReal.ofReal (2 * Real.pi / 3) * (ENNReal.ofReal (1 - η) * volume B) ≤
      ENNReal.ofReal (2 * Real.pi) * (ENNReal.ofReal η * volume B) := by
    calc _ ≤ ENNReal.ofReal (2 * Real.pi / 3) * volume U := by
          rw [hU, inter_comm]; gcongr
      _ ≤ _ := hlow.trans hup
      _ ≤ _ := by gcongr
  rw [hv1, ← ENNReal.ofReal_mul (by positivity), ← ENNReal.ofReal_mul (by positivity),
    ← ENNReal.ofReal_mul (by positivity), ← ENNReal.ofReal_mul (by positivity),
    ENNReal.ofReal_le_ofReal_iff (by positivity)] at hmain
  have hq : 0 < (2 * ε) ^ 2 * Real.pi := by positivity
  nlinarith [mul_pos hq hpi]

/-! ### CP colourings: a jointly measurable modification (`chiM0_le_chiCP`, `CPColouring.tendsto_not_kept`) -/

/-- Stationarity moves a pair to the origin. -/
theorem CPColouring.law_ne_shift (c : CPColouring k) (x y : ℂ) :
    c.law {f | f x ≠ f y} = c.law {f | f 0 ≠ f (y - x)} := by
  sorry

/-- **Uniform continuity in probability** (stationarity and `tendsto_ne` at `0`). -/
theorem CPColouring.exists_unif (c : CPColouring k) {δ : ENNReal} (hδ : 0 < δ) :
    ∃ r > (0 : ℝ), ∀ x y : ℂ, dist x y < r → c.law {f | f x ≠ f y} < δ := by
  sorry

/-- The lower-left corner of the grid cell of side `h` containing `x`. -/
noncomputable def gridPoint (h : ℝ) (x : ℂ) : ℂ := ((h * ⌊x.re / h⌋ : ℝ) : ℂ) + ((h * ⌊x.im / h⌋ : ℝ) : ℂ) * I

theorem dist_gridPoint_lt {h : ℝ} (hh : 0 < h) (x : ℂ) : dist (gridPoint h x) x < 2 * h := by
  sorry

/-- `(f, x) ↦ f (gridPoint h x)` is jointly measurable (`gridPoint h` takes countably many values on measurable cells). -/
theorem measurable_eval_gridPoint {h : ℝ} (hh : 0 < h) :
    Measurable fun p : (ℂ → Fin k) × ℂ => p.1 (gridPoint h p.2) := by
  sorry

/-- **The modification** (FS106-TQ § 2.3 step 1): scales `h_m` with `P(f x ≠ f (gridPoint h_m x)) ≤ 2^{−m}`
(`CPColouring.exists_unif`), Borel–Cantelli (`MeasureTheory.measure_limsup_atTop_eq_zero`) at each `x`, and `ct f x` the
eventual value of `f (gridPoint h_m x)` (measurable fibres: `measurable_to_countable'`). -/
theorem CPColouring.exists_modification (c : CPColouring k) :
    ∃ ct : (ℂ → Fin k) → ℂ → Fin k, Measurable (Function.uncurry ct) ∧ ∀ x, c.law {f | ct f x ≠ f x} = 0 := by
  sorry

/-- **Realisations are a.e.-proper** (TQ § 2.3 step 3): Tonelli on `law ⊗ volume ⊗ arcLength` and `c.proper`. -/
theorem CPColouring.ae_unitPairsNull_of_modification (c : CPColouring k) {ct : (ℂ → Fin k) → ℂ → Fin k}
    (hct : Measurable (Function.uncurry ct)) (hmod : ∀ x, c.law {f | ct f x ≠ f x} = 0) :
    ∀ᵐ f ∂c.law, ∀ j, UnitPairsNull (ct f ⁻¹' {j}) := by
  sorry

/-- The expected disagreement with the origin over a ball (Tonelli and the modification); with Markov
(`MeasureTheory.meas_ge_le_lintegral_div`) and `CPColouring.exists_unif` it gives `CPColouring.tendsto_not_kept`. -/
theorem CPColouring.lintegral_ball_ne (c : CPColouring k) {ct : (ℂ → Fin k) → ℂ → Fin k}
    (hct : Measurable (Function.uncurry ct)) (hmod : ∀ x, c.law {f | ct f x ≠ f x} = 0) (ρ : ℝ) :
    ∫⁻ f, volume (ball (0 : ℂ) ρ ∩ {y | ct f y ≠ ct f 0}) ∂c.law = ∫⁻ y in ball (0 : ℂ) ρ, c.law {f | f y ≠ f 0} := by
  sorry

/-! ### The compactness argument (`exists_bandNull_aeCover_of_mu_eq_one`, `chiM0_le_iff_muZero_eq_one`) -/

/-- Weak-* convergence in `L^∞` against integrable test functions. -/
def WeakStarTendsto (g : ℕ → ℂ → ℝ) (F : ℂ → ℝ) : Prop :=
  ∀ φ : ℂ → ℝ, Integrable φ → Tendsto (fun m => ∫ x, g m x * φ x) atTop (𝓝 (∫ x, F x * φ x))

/-- **Weak-* sequential compactness** of `[0, 1]`-valued families (Hilbert weak compactness in `L²(B(0, n))`,
`WeakDual.isSeqCompact_closedBall` through `InnerProductSpace.toDual`, then a diagonal over `n` and density of `L² ∩ L¹`
in `L¹`). -/
theorem exists_weakStar_subseq (g : ℕ → Fin k → ℂ → ℝ) (hg : ∀ m j, Measurable (g m j))
    (h01 : ∀ m j x, 0 ≤ g m j x ∧ g m j x ≤ 1) :
    ∃ (σ : ℕ → ℕ) (F : Fin k → ℂ → ℝ), StrictMono σ ∧ (∀ j, Measurable (F j)) ∧
      (∀ j, ∀ᵐ x ∂volume, 0 ≤ F j x ∧ F j x ≤ 1) ∧ ∀ j, WeakStarTendsto (fun m => g (σ m) j) (F j) := by
  sorry

/-- **Convolution forms with an integrable kernel are weak-* continuous on bounded families** (no decay needed — QB § 2.3:
`g_m ∗ κ → F ∗ κ` pointwise and boundedly, then dominated convergence on the ball). -/
theorem convForm_tendsto {g : ℕ → ℂ → ℝ} {F : ℂ → ℝ} (hg : ∀ m, Measurable (g m)) (hb : ∀ m x, |g m x| ≤ 1)
    (hFm : Measurable F) (hF : ∀ᵐ x ∂volume, |F x| ≤ 1) (hw : WeakStarTendsto g F) {κ : ℂ → ℝ} (hκ : Integrable κ)
    (R : ℝ) :
    Tendsto (fun m => ∫ x in ball (0 : ℂ) R, g m x * ∫ w, g m (x + w) * κ w) atTop
      (𝓝 (∫ x in ball (0 : ℂ) R, F x * ∫ w, F (x + w) * κ w)) := by
  sorry

/-- The law of `e φ − e θ` under `arcLength ⊗ arcLength` is absolutely continuous (`twoCircle_preimage_null` at
`r₁ = r₂ = 1`, `e φ − e θ = e φ + e (θ + π)`). Stated with its density, for `integral_circleAvg_sq`. -/
theorem exists_twoCircle_density : ∃ ρ : ℂ → ℝ, Integrable ρ ∧ (∀ w, 0 ≤ ρ w) ∧
    ∀ N : Set ℂ, MeasurableSet N →
      (arcLength.prod arcLength) {p : ℝ × ℝ | e p.2 - e p.1 ∈ N} = ENNReal.ofReal (∫ w in N, ρ w) := by
  sorry

/-- **`T*T` has an integrable kernel** (Fubini): for bounded measurable `h` supported in a ball,
`∫ |∫_θ h(x + e θ)|² dx = ∫ h(y) ∫ h(y + w) ρ(w) dw dy` with `ρ` the two-circle density. -/
theorem integral_circleAvg_sq {ρ : ℂ → ℝ} (hρ : Integrable ρ)
    (hρN : ∀ N : Set ℂ, MeasurableSet N →
      (arcLength.prod arcLength) {p : ℝ × ℝ | e p.2 - e p.1 ∈ N} = ENNReal.ofReal (∫ w in N, ρ w))
    {h : ℂ → ℝ} (hh : Measurable h) (hb : ∀ x, |h x| ≤ 2) {R : ℝ} (hs : ∀ x, R < ‖x‖ → h x = 0) :
    ∫ x, (∫ θ in Ico 0 (2 * Real.pi), h (x + e θ)) ^ 2 = ∫ y, h y * ∫ w, h (y + w) * ρ w := by
  sorry

/-- **The Rajchman step, Fourier-free**: the unit form is weak-* continuous on `[0, 1]`-valued families supported in a fixed
ball (`integral_circleAvg_sq` and `convForm_tendsto` at `κ = ρ` make `T g_m → T F` in `L²`). -/
theorem unitForm_tendsto {g : ℕ → ℂ → ℝ} {F : ℂ → ℝ} (hg : ∀ m, Measurable (g m)) (h01 : ∀ m x, 0 ≤ g m x ∧ g m x ≤ 1)
    (hFm : Measurable F) (hF : ∀ᵐ x ∂volume, 0 ≤ F x ∧ F x ≤ 1) (hw : WeakStarTendsto g F) (R : ℝ) :
    Tendsto (fun m => ∫ x in ball (0 : ℂ) R, g m x * ∫ θ in Ico 0 (2 * Real.pi), g m (x + e θ)) atTop
      (𝓝 (∫ x in ball (0 : ℂ) R, F x * ∫ θ in Ico 0 (2 * Real.pi), F (x + e θ))) := by
  sorry

/-- **Translates with vanishing holes**: if partial colourings with a translation-invariant class property reach upper
density `1`, translates of them leave holes tending to `0` in every ball (`upperDensity` at origin-centred balls, an
averaging over centres in `B(0, R − r)`). -/
theorem exists_translates_small_hole {P : (Fin k → Set ℂ) → Prop}
    (hP : ∀ C (v : ℂ), P C → P fun j => (· + v) ⁻¹' C j)
    (h : (⨆ (C : Fin k → Set ℂ) (_ : IsPartialColouring C ∧ P C), upperDensity (⋃ j, C j)) = 1) :
    ∃ C : ℕ → Fin k → Set ℂ, (∀ m, IsPartialColouring (C m) ∧ P (C m)) ∧
      ∀ R : ℝ, Tendsto (fun m => volume (ball (0 : ℂ) R \ ⋃ j, C m j)) atTop (𝓝 0) := by
  sorry

/-- The weak-* limit of the indicator families of `exists_translates_small_hole` sums to `1` almost everywhere. -/
theorem ae_sum_eq_one_of_weakStar {C : ℕ → Fin k → Set ℂ} (hC : ∀ m, IsPartialColouring (C m))
    (hhole : ∀ R : ℝ, Tendsto (fun m => volume (ball (0 : ℂ) R \ ⋃ j, C m j)) atTop (𝓝 0)) {F : Fin k → ℂ → ℝ}
    (hFm : ∀ j, Measurable (F j)) (hw : ∀ j, WeakStarTendsto (fun m => (C m j).indicator 1) (F j)) :
    ∀ᵐ x ∂volume, ∑ j, F j x = 1 := by
  sorry

/-- **Selection**: from weights summing to `1`, a measurable colour of positive weight (argmax over `Fin k`). -/
theorem exists_selection {F : Fin k → ℂ → ℝ} (hF : ∀ j, Measurable (F j)) (hsum : ∀ᵐ x ∂volume, ∑ j, F j x = 1)
    (hpos : ∀ j, ∀ᵐ x ∂volume, 0 ≤ F j x) : ∃ c : ℂ → Fin k, Measurable c ∧ ∀ᵐ x ∂volume, 0 < F (c x) x := by
  sorry

theorem bandNull_preimage_add {A : Set ℂ} {ε : ℝ} (h : BandNull A ε) (v : ℂ) : BandNull ((· + v) ⁻¹' A) ε := by
  sorry

theorem unitPairsNull_preimage_add {A : Set ℂ} (h : UnitPairsNull A) (v : ℂ) : UnitPairsNull ((· + v) ⁻¹' A) := by
  sorry

/-! ### `exists_face_fails` (ruling, inventory item 86): the explicit class -/

/-- FACE-SHARP's failure class: the half-box, the far box and a box `Q` just beyond `x + e θ`. -/
def faceFailClass (x : ℂ) (θ ε g ε' ρ δ : ℝ) : Set ℂ :=
  halfBox x θ ε ∪ farBox x θ g ε' ρ ∪ {z | ∃ s t : ℝ, 1 < s ∧ s < 1 + δ ∧ |t| < δ ∧ z = x + e θ * (s + t * I)}

/-- **No unit pair at all** in the failure class, for small `ε, ε', δ`: each piece has diameter `< 1` (`2ρ < 1`);
half-box to far box `< 1` (`g² + ρ² < 1`); far box to `Q` `< 1` (`(1 − g)² + ρ² < 1`, i.e. `ρ² < 2g − g²`); half-box to
`Q` `> 1`. -/
theorem exists_faceFailClass_noUnitPairs {g ρ : ℝ} (hg : 0 < g) (hρ : 0 < ρ) (hlt : ρ ^ 2 < 2 * g - g ^ 2)
    (hρ2 : 2 * ρ < 1) (hgρ : g ^ 2 + ρ ^ 2 < 1) (x : ℂ) (θ : ℝ) :
    ∃ ε ε' δ : ℝ, 0 < ε ∧ 0 < ε' ∧ 0 < δ ∧
      ∀ z ∈ faceFailClass x θ ε g ε' ρ δ, ∀ w ∈ faceFailClass x θ ε g ε' ρ δ, dist z w ≠ 1 := by
  sorry

/-- A measurable set with no unit pair is one class of an `AeColouring 10` (the rest coloured by `sq9`). -/
theorem exists_aeColouring_of_noUnitPairs {D : Set ℂ} (hD : MeasurableSet D) (h : ∀ z ∈ D, ∀ w ∈ D, dist z w ≠ 1) :
    ∃ c : AeColouring 10, c.cls 9 = D := by
  sorry

theorem measurableSet_faceFailClass (x : ℂ) (θ ε g ε' ρ δ : ℝ) : MeasurableSet (faceFailClass x θ ε g ε' ρ δ) := by
  sorry

/-- `x + e θ` is in the support of the failure class (every ball about it meets `Q` in an open set). -/
theorem add_e_mem_essSupport_faceFailClass (x : ℂ) (θ ε g ε' ρ : ℝ) {δ : ℝ} (hδ : 0 < δ) :
    x + e θ ∈ essSupport (faceFailClass x θ ε g ε' ρ δ) := by
  sorry

/-! ### `face`: circles about the points near `y` meet the boxes -/

/-- An open set met by the unit circle about `u` is met in a set of directions of positive measure. -/
theorem arcLength_pos_of_isOpen {U : Set ℂ} (hU : IsOpen U) {u : ℂ} (h : ∃ φ : ℝ, u + e φ ∈ U) :
    0 < arcLength {θ : ℝ | u + e θ ∈ U} := by
  obtain ⟨φ, hφ⟩ := h
  have hme : Continuous (fun θ : ℝ => u + e θ) := by unfold e; fun_prop
  have hV : IsOpen {θ : ℝ | u + e θ ∈ U} := hU.preimage hme
  have hper : ∀ θ, θ + 2 * Real.pi ∈ {θ : ℝ | u + e θ ∈ U} ↔ θ ∈ {θ : ℝ | u + e θ ∈ U} := by
    intro θ; simp only [mem_setOf_eq, e_add_two_pi]
  rw [arcLength_eq_window hV.measurableSet hper (φ - Real.pi)]
  obtain ⟨δ, hδ, hball⟩ := Metric.isOpen_iff.1 hV φ hφ
  set δ' := min δ Real.pi with hδ'
  have hδ'0 : 0 < δ' := lt_min hδ Real.pi_pos
  have hsub : Ioo (φ - δ') (φ + δ') ⊆ {θ : ℝ | u + e θ ∈ U} ∩ Ioc (φ - Real.pi) (φ - Real.pi + 2 * Real.pi) := by
    intro θ hθ
    have hd : dist θ φ < δ' := by rw [Real.dist_eq, abs_lt]; constructor <;> linarith [hθ.1, hθ.2]
    refine ⟨hball (lt_of_lt_of_le hd (min_le_left _ _)), ?_, ?_⟩
    · linarith [hθ.1, min_le_right δ Real.pi]
    · linarith [hθ.2, min_le_right δ Real.pi]
  refine lt_of_lt_of_le ?_ (measure_mono hsub)
  rw [Real.volume_Ioo]; simp [hδ'0]

theorem e_mul_e_neg (θ : ℝ) : e θ * e (-θ) = 1 := by
  rw [← e_add, add_neg_cancel]; simp [e]

/-- The image of an open set under the rigid motion `w ↦ x + e θ w` is open. -/
theorem isOpen_rotImage (x : ℂ) (θ : ℝ) {W : Set ℂ} (hW : IsOpen W) : IsOpen {z : ℂ | ∃ w ∈ W, z = x + e θ * w} := by
  have hc : Continuous (fun z : ℂ => (z - x) * e (-θ)) := by fun_prop
  have : {z : ℂ | ∃ w ∈ W, z = x + e θ * w} = (fun z : ℂ => (z - x) * e (-θ)) ⁻¹' W := by
    ext z
    constructor
    · rintro ⟨w, hw, rfl⟩
      show (x + e θ * w - x) * e (-θ) ∈ W
      have : (x + e θ * w - x) * e (-θ) = w := by
        calc (x + e θ * w - x) * e (-θ) = (e θ * e (-θ)) * w := by ring
          _ = w := by rw [e_mul_e_neg, one_mul]
      rwa [this]
    · intro h
      refine ⟨(z - x) * e (-θ), h, ?_⟩
      calc z = x + (z - x) * (e θ * e (-θ)) := by rw [e_mul_e_neg]; ring
        _ = _ := by ring
  rw [this]; exact hW.preimage hc

/-- The point `x + e θ (−s + t i)` of the half-box frame. -/
noncomputable def framePt (x : ℂ) (θ s t : ℝ) : ℂ := x + e θ * (-s + t * I)

theorem convex_combo_mem {l a b lo hi : ℝ} (hl : l ∈ Icc (0 : ℝ) 1) (ha : lo ≤ a) (ha' : a ≤ hi) (hb : lo ≤ b)
    (hb' : b ≤ hi) : lo ≤ (1 - l) * a + l * b ∧ (1 - l) * a + l * b ≤ hi := by
  obtain ⟨h0, h1⟩ := hl
  constructor <;> nlinarith [mul_nonneg (sub_nonneg.2 h1) (sub_nonneg.2 ha), mul_nonneg h0 (sub_nonneg.2 hb),
    mul_nonneg (sub_nonneg.2 h1) (sub_nonneg.2 ha'), mul_nonneg h0 (sub_nonneg.2 hb')]

/-- If a point of the open half-box is strictly inside and another strictly outside the unit circle about `y'`, the circle
meets the half-box (intermediate value theorem along the segment). -/
theorem exists_circle_point_halfBox {x : ℂ} {θ ε : ℝ} {y' : ℂ} {s₁ t₁ s₂ t₂ : ℝ}
    (hs₁ : 0 < s₁) (hs₁' : s₁ < ε) (ht₁ : |t₁| < ε) (hs₂ : 0 < s₂) (hs₂' : s₂ < ε) (ht₂ : |t₂| < ε)
    (hlt : dist (framePt x θ s₁ t₁) y' < 1) (hgt : 1 < dist (framePt x θ s₂ t₂) y') :
    ∃ φ : ℝ, y' + e φ ∈ halfBox x θ ε := by
  have hcont : ContinuousOn (fun l : ℝ => dist (framePt x θ ((1 - l) * s₁ + l * s₂) ((1 - l) * t₁ + l * t₂)) y')
      (Icc 0 1) := by
    refine Continuous.continuousOn ?_
    unfold framePt; fun_prop
  obtain ⟨l, hl, hl1⟩ := intermediate_value_Icc (zero_le_one' ℝ) hcont
    (show (1 : ℝ) ∈ Icc _ _ from ⟨by simpa using hlt.le, by simpa using hgt.le⟩)
  set s := (1 - l) * s₁ + l * s₂ with hs
  set t := (1 - l) * t₁ + l * t₂ with ht
  have hl1' : dist (framePt x θ s t) y' = 1 := hl1
  have hz : framePt x θ s t - y' = e ((framePt x θ s t - y').arg) := by
    have := eq_norm_mul_e_arg (framePt x θ s t - y')
    rw [← dist_eq_norm, hl1'] at this
    simpa using this
  refine ⟨(framePt x θ s t - y').arg, ?_⟩
  have : y' + e ((framePt x θ s t - y').arg) = framePt x θ s t := by rw [← hz]; ring
  rw [this]
  have hsb := convex_combo_mem (a := s₁) (b := s₂) (lo := min s₁ s₂) (hi := max s₁ s₂) hl (min_le_left _ _)
    (le_max_left _ _) (min_le_right _ _) (le_max_right _ _)
  have htb := convex_combo_mem (a := t₁) (b := t₂) (lo := -max |t₁| |t₂|) (hi := max |t₁| |t₂|) hl
    (neg_le_of_abs_le (le_max_left _ _)) (le_of_abs_le (le_max_left _ _)) (neg_le_of_abs_le (le_max_right _ _))
    (le_of_abs_le (le_max_right _ _))
  refine ⟨s, t, ?_, ?_, ?_, rfl⟩
  · exact lt_of_lt_of_le (lt_min hs₁ hs₂) hsb.1
  · exact lt_of_le_of_lt hsb.2 (max_lt hs₁' hs₂')
  · exact abs_le.2 ⟨htb.1, htb.2⟩ |>.trans_lt (max_lt ht₁ ht₂)

theorem exists_frame_sides {a b ε : ℝ} (hε : 0 < ε) (hab : a ^ 2 + b ^ 2 = 1) (hne : ¬(a = 1 ∧ b = 0)) :
    ∃ s₁ t₁ s₂ t₂ : ℝ, 0 < s₁ ∧ s₁ < ε ∧ |t₁| < ε ∧ 0 < s₂ ∧ s₂ < ε ∧ |t₂| < ε ∧
      (s₁ + a) ^ 2 + (t₁ - b) ^ 2 < 1 ∧ 1 < (s₂ + a) ^ 2 + (t₂ - b) ^ 2 := by
  by_cases hb : b = 0
  · have ha : a = -1 := by
      have h1 : (a - 1) * (a + 1) = 0 := by rw [hb] at hab; nlinarith
      rcases mul_eq_zero.1 h1 with h | h
      · exact absurd ⟨by linarith, hb⟩ hne
      · linarith
    set τ := min 1 (ε / 2) with hτ
    have hτ0 : 0 < τ := lt_min one_pos (by positivity)
    have hτ1 : τ ≤ 1 := min_le_left _ _
    have hτε : τ ≤ ε / 2 := min_le_right _ _
    refine ⟨τ, 0, τ ^ 2 / 2, τ, hτ0, by linarith, by simp [hε], by positivity, by nlinarith, ?_, ?_, ?_⟩
    · rw [abs_of_pos hτ0]; linarith
    · rw [ha, hb]; nlinarith
    · rw [ha, hb]; nlinarith [pow_pos hτ0 4]
  · have hβ : 0 < |b| := abs_pos.2 hb
    set β := |b| with hβd
    set σ := b / β with hσ
    have hσ2 : σ ^ 2 = 1 := by
      rw [hσ, div_pow, hβd, sq_abs]; field_simp
    have hσb : σ * b = β := by
      rw [hσ, hβd]; rcases lt_or_gt_of_ne hb with h | h
      · rw [abs_of_neg h]; field_simp
      · rw [abs_of_pos h]; field_simp
    have hσabs : |σ| = 1 := by
      have : |σ| ^ 2 = 1 := by rw [sq_abs]; exact hσ2
      nlinarith [abs_nonneg σ]
    set τ := min (min 1 (β / 4)) (ε / 2) with hτ
    have hτ0 : 0 < τ := lt_min (lt_min one_pos (by positivity)) (by positivity)
    have hτ1 : τ ≤ 1 := (min_le_left _ _).trans (min_le_left _ _)
    have hτβ : τ ≤ β / 4 := (min_le_left _ _).trans (min_le_right _ _)
    have hτε : τ ≤ ε / 2 := min_le_right _ _
    have ha1 : a ^ 2 ≤ 1 := by nlinarith [sq_nonneg b]
    have ha2 : -1 ≤ a ∧ a ≤ 1 := by constructor <;> nlinarith [sq_nonneg b]
    refine ⟨τ ^ 2, σ * τ, τ ^ 2, -(σ * τ), by positivity, by nlinarith, ?_, by positivity, by nlinarith, ?_, ?_, ?_⟩
    · rw [abs_mul, hσabs, abs_of_pos hτ0]; linarith
    · rw [abs_neg, abs_mul, hσabs, abs_of_pos hτ0]; linarith
    · have : (τ ^ 2 + a) ^ 2 + (σ * τ - b) ^ 2 = τ ^ 4 + 2 * τ ^ 2 * a + a ^ 2 + τ ^ 2 * σ ^ 2 - 2 * τ * (σ * b) + b ^ 2 := by ring
      rw [this, hσ2, hσb]
      have hτ2 : τ ^ 2 ≤ 1 := by nlinarith
      have h4 : τ ^ 4 ≤ τ ^ 2 := by nlinarith [pow_pos hτ0 2]
      nlinarith [mul_pos hτ0 hβ, mul_le_mul_of_nonneg_left hτβ hτ0.le]
    · have : (τ ^ 2 + a) ^ 2 + (-(σ * τ) - b) ^ 2 = τ ^ 4 + 2 * τ ^ 2 * a + a ^ 2 + τ ^ 2 * σ ^ 2 + 2 * τ * (σ * b) + b ^ 2 := by ring
      rw [this, hσ2, hσb]
      nlinarith [mul_pos hτ0 hβ, mul_le_mul_of_nonneg_left hτβ hτ0.le, pow_pos hτ0 4]

/-- A point `y` at distance `1` from `x`, read in the frame at `x`: `y = x + e θ (a + b i)`, `a² + b² = 1`. -/
theorem frame_coords {x y : ℂ} (θ : ℝ) (hxy : dist x y = 1) :
    ∃ a b : ℝ, y = x + e θ * (a + b * I) ∧ a ^ 2 + b ^ 2 = 1 := by
  set w : ℂ := (y - x) * e (-θ) with hw
  refine ⟨w.re, w.im, ?_, ?_⟩
  · rw [Complex.re_add_im, hw]
    calc y = x + (y - x) * (e θ * e (-θ)) := by rw [e_mul_e_neg]; ring
      _ = _ := by ring
  · have h1 : ‖w‖ = 1 := by
      rw [hw, norm_mul, norm_e, mul_one, ← dist_eq_norm, dist_comm]; exact hxy
    have := Complex.sq_norm w
    rw [h1, Complex.normSq_apply] at this
    nlinarith

theorem exists_far_point {g ε' ρ u v : ℝ} (hg : 0 < g) (hg1 : g < 1) (hε' : 0 < ε') (hρ : 0 < ρ)
    (hsharp : 2 * g - g ^ 2 ≤ ρ ^ 2) (hu0 : 0 ≤ u) (hug : u < g) (hvρ : |v| < ρ) (hne : ¬(u = 0 ∧ v = 0)) :
    ∃ σ τ : ℝ, g < σ ∧ σ < g + ε' ∧ |τ| < ρ ∧ (σ - (1 + u)) ^ 2 + (τ - v) ^ 2 = 1 := by
  set q : ℝ := ρ * |v| / (1 - g) with hq
  have h1g : 0 < 1 - g := by linarith
  have hq0 : 0 ≤ q := by positivity
  have huq : 0 < u + q := by
    rcases hu0.lt_or_eq with h | h
    · linarith
    · have hv : v ≠ 0 := fun hv => hne ⟨h.symm, hv⟩
      have : 0 < |v| := abs_pos.2 hv
      have : 0 < q := by positivity
      linarith
  set δ : ℝ := min (min (ε' / 2) ((1 - g) / 2)) ((u + q) / 2) with hδ
  have hδ0 : 0 < δ := lt_min (lt_min (by positivity) (by linarith)) (by linarith)
  have hδ1 : δ ≤ ε' / 2 := (min_le_left _ _).trans (min_le_left _ _)
  have hδ2 : δ ≤ (1 - g) / 2 := (min_le_left _ _).trans (min_le_right _ _)
  have hδ3 : δ ≤ (u + q) / 2 := min_le_right _ _
  set h : ℝ := g + δ - u with hh
  have hh0 : 0 < h := by linarith
  have hh1 : h < 1 := by linarith
  set κ : ℝ := Real.sqrt (2 * h - h ^ 2) with hκ
  have hψ : 0 ≤ 2 * h - h ^ 2 := by nlinarith
  have hκ2 : κ ^ 2 = 2 * h - h ^ 2 := Real.sq_sqrt hψ
  have hκ0 : 0 ≤ κ := Real.sqrt_nonneg _
  -- the key inequality `κ < ρ + |v|`
  have hkey : 2 * h - h ^ 2 < (ρ + |v|) ^ 2 := by
    have hw : 2 * h - h ^ 2 - (2 * g - g ^ 2) = (δ - u) * (2 - h - g) := by rw [hh]; ring
    have h2hg : 0 < 2 - h - g := by linarith
    by_cases hv : v = 0
    · have hq' : q = 0 := by rw [hq, hv]; simp
      have hu : 0 < u := lt_of_le_of_ne hu0 (fun h0 => hne ⟨h0.symm, hv⟩)
      have : δ - u < 0 := by linarith
      have : (δ - u) * (2 - h - g) < 0 := mul_neg_of_neg_of_pos this h2hg
      rw [hv]; simp; nlinarith
    · have hvpos : 0 < |v| := abs_pos.2 hv
      by_cases hw0 : δ - u ≤ 0
      · have : (δ - u) * (2 - h - g) ≤ 0 := mul_nonpos_of_nonpos_of_nonneg hw0 h2hg.le
        nlinarith [sq_nonneg |v|, mul_pos hρ hvpos]
      · push Not at hw0
        have hwq : δ - u ≤ q / 2 := by linarith
        have h2 : 2 - h - g ≤ 2 * (1 - g) := by linarith
        have : (δ - u) * (2 - h - g) ≤ (q / 2) * (2 * (1 - g)) :=
          mul_le_mul hwq h2 h2hg.le (by linarith)
        have hq2 : q * (1 - g) = ρ * |v| := by rw [hq]; field_simp
        nlinarith [sq_nonneg |v|, mul_pos hρ hvpos]
  have hκlt : κ < ρ + |v| := by
    by_contra hcon; push Not at hcon
    nlinarith [mul_self_le_mul_self (by positivity) hcon]
  have hvabs := abs_lt.1 hvρ
  by_cases hv0 : 0 ≤ v
  · refine ⟨g + δ, v - κ, by linarith, by linarith, ?_, ?_⟩
    · rw [abs_lt]; rw [abs_of_nonneg hv0] at hκlt; constructor <;> linarith
    · have : (g + δ - (1 + u)) ^ 2 = (h - 1) ^ 2 := by rw [hh]; ring
      rw [this, show (v - κ - v) ^ 2 = κ ^ 2 by ring, hκ2]; ring
  · push Not at hv0
    refine ⟨g + δ, v + κ, by linarith, by linarith, ?_, ?_⟩
    · rw [abs_lt]; rw [abs_of_neg hv0] at hκlt; constructor <;> linarith
    · have : (g + δ - (1 + u)) ^ 2 = (h - 1) ^ 2 := by rw [hh]; ring
      rw [this, show (v + κ - v) ^ 2 = κ ^ 2 by ring, hκ2]; ring

theorem exists_phi_of_dist_eq_one {z y' : ℂ} (h : dist z y' = 1) : ∃ φ : ℝ, y' + e φ = z := by
  have := eq_norm_mul_e_arg (z - y')
  rw [← dist_eq_norm, h] at this
  exact ⟨(z - y').arg, by rw [← one_mul (e _)]; simp at this; rw [← this]; ring⟩

theorem norm_sq_re_im (a b : ℝ) : ‖(a : ℂ) + (b : ℂ) * I‖ ^ 2 = a ^ 2 + b ^ 2 := by
  rw [Complex.sq_norm, Complex.normSq_apply]; simp; ring

theorem dist_framePt_sq (x : ℂ) (θ s t a b : ℝ) :
    dist (framePt x θ s t) (x + e θ * (a + b * I)) ^ 2 = (s + a) ^ 2 + (t - b) ^ 2 := by
  have h : framePt x θ s t - (x + e θ * (a + b * I)) = e θ * ((((-(s + a)) : ℝ) : ℂ) + ((t - b : ℝ) : ℂ) * I) := by
    unfold framePt; push_cast; ring
  rw [dist_eq_norm, h, norm_mul, norm_e, one_mul, Complex.sq_norm, Complex.normSq_apply]
  simp
  ring

/-- **The face key lemma** (I2b): an open `U` lying a.e. in a measurable `A`, a support point `y` of `A`, and every unit
circle about the points of a ball about `y` (off a null set) meeting `U`, contradict null unit pairs (Tonelli: the pairs
from `A ∩ B(y, r)` into `U ∩ A` have positive mass, each circle meeting the open `U` in a positive arc). -/
theorem not_unitPairsNull_of_circles_meet {A U N : Set ℂ} (hA : MeasurableSet A) (hU : IsOpen U)
    (hUA : volume (U \ A) = 0) {y : ℂ} (hy : y ∈ essSupport A) {r : ℝ} (hr : 0 < r) (hN : volume N = 0)
    (hmeet : ∀ y' ∈ ball y r, y' ∉ N → ∃ φ : ℝ, y' + e φ ∈ U) : ¬ UnitPairsNull A := by
  intro hnull
  set S := A ∩ ball y r with hS
  have hSm : MeasurableSet S := hA.inter measurableSet_ball
  have hpos : 0 < volume S := hy r hr
  have hz : (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ S ∧ q.1 + e q.2 ∈ A} = 0 :=
    measure_mono_null (fun q hq => (⟨hq.1.1, hq.2⟩ : q ∈ unitPairSet A)) hnull
  rw [pairs_eq_lintegral hSm hA] at hz
  have hme : Measurable (fun θ : ℝ => e θ) := by unfold e; fun_prop
  have hUA' : MeasurableSet (U \ A) := hU.measurableSet.diff hA
  have hnullS : (volume.prod arcLength) {q : ℂ × ℝ | q.1 + e q.2 ∈ U \ A} = 0 := volume_prod_shift_null hUA
  have hmS : MeasurableSet {q : ℂ × ℝ | q.1 + e q.2 ∈ U \ A} :=
    (measurable_fst.add (hme.comp measurable_snd)) hUA'
  have hae1 : ∀ᵐ u ∂volume, arcLength {θ : ℝ | u + e θ ∈ U \ A} = 0 := by
    have := (Measure.measure_prod_null hmS).1 hnullS
    exact this
  have hae2 : ∀ᵐ u ∂volume, u ∉ N := measure_eq_zero_iff_ae_notMem.1 hN
  have hpos' : ∀ᵐ u ∂(volume.restrict S), 0 < phi A u := by
    filter_upwards [ae_restrict_of_ae hae1, ae_restrict_of_ae hae2, ae_restrict_mem hSm] with u h1 h2 hu
    obtain ⟨φ, hφ⟩ := hmeet u hu.2 h2
    have h0 := arcLength_pos_of_isOpen hU ⟨φ, hφ⟩
    refine lt_of_lt_of_le h0 ?_
    calc arcLength {θ : ℝ | u + e θ ∈ U}
        ≤ arcLength ({θ : ℝ | u + e θ ∈ A} ∪ {θ : ℝ | u + e θ ∈ U \ A}) := by
          refine measure_mono fun θ hθ => ?_
          by_cases h : u + e θ ∈ A
          · exact Or.inl h
          · exact Or.inr ⟨hθ, h⟩
      _ ≤ arcLength {θ : ℝ | u + e θ ∈ A} + arcLength {θ : ℝ | u + e θ ∈ U \ A} := measure_union_le _ _
      _ = phi A u := by rw [h1, add_zero]; rfl
  have hne : volume.restrict S ≠ 0 := by
    intro h
    have := congrArg (fun μ => μ univ) h
    simp only [Measure.restrict_apply_univ, Measure.coe_zero, Pi.zero_apply] at this
    exact hpos.ne' this
  haveI := ae_neBot.2 hne
  have h0 := (lintegral_eq_zero_iff (measurable_phi hA)).1 hz
  obtain ⟨u, hu1, hu2⟩ := (hpos'.and h0).exists
  simp at hu2
  exact hu1.ne' hu2

theorem isOpen_halfBox (x : ℂ) (θ ε : ℝ) : IsOpen (halfBox x θ ε) := by
  have hW : IsOpen {w : ℂ | 0 < -w.re ∧ -w.re < ε ∧ |w.im| < ε} := by
    have h1 : IsOpen {w : ℂ | 0 < -w.re} := isOpen_lt continuous_const Complex.continuous_re.neg
    have h2 : IsOpen {w : ℂ | -w.re < ε} := isOpen_lt Complex.continuous_re.neg continuous_const
    have h3 : IsOpen {w : ℂ | |w.im| < ε} := isOpen_lt (continuous_abs.comp Complex.continuous_im) continuous_const
    exact h1.inter (h2.inter h3)
  have : halfBox x θ ε = {z : ℂ | ∃ w ∈ {w : ℂ | 0 < -w.re ∧ -w.re < ε ∧ |w.im| < ε}, z = x + e θ * w} := by
    ext z
    constructor
    · rintro ⟨s, t, hs, hse, ht, rfl⟩
      refine ⟨-s + t * I, ?_, rfl⟩
      simp [hs, hse, ht]
    · rintro ⟨w, ⟨h1, h2, h3⟩, rfl⟩
      refine ⟨-w.re, w.im, h1, h2, h3, ?_⟩
      congr 2
      apply Complex.ext <;> simp
  rw [this]; exact isOpen_rotImage x θ hW

theorem isOpen_farBox (x : ℂ) (θ g ε' ρ : ℝ) : IsOpen (farBox x θ g ε' ρ) := by
  have hW : IsOpen {w : ℂ | g < w.re ∧ w.re < g + ε' ∧ |w.im| < ρ} := by
    have h1 : IsOpen {w : ℂ | g < w.re} := isOpen_lt continuous_const Complex.continuous_re
    have h2 : IsOpen {w : ℂ | w.re < g + ε'} := isOpen_lt Complex.continuous_re continuous_const
    have h3 : IsOpen {w : ℂ | |w.im| < ρ} := isOpen_lt (continuous_abs.comp Complex.continuous_im) continuous_const
    exact h1.inter (h2.inter h3)
  have : farBox x θ g ε' ρ = {z : ℂ | ∃ w ∈ {w : ℂ | g < w.re ∧ w.re < g + ε' ∧ |w.im| < ρ}, z = x + e θ * w} := by
    ext z
    constructor
    · rintro ⟨s, t, hs, hse, ht, rfl⟩
      refine ⟨s + t * I, ?_, rfl⟩
      simp [hs, hse, ht]
    · rintro ⟨w, ⟨h1, h2, h3⟩, rfl⟩
      refine ⟨w.re, w.im, h1, h2, h3, ?_⟩
      congr 2
      apply Complex.ext <;> simp
  rw [this]; exact isOpen_rotImage x θ hW

/-- **The face geometry**, away from the normal: for `dist x y = 1`, `y ≠ x + e θ`, the unit circles about the points near
`y` cross the face of the half-box into it (the circle about `y` passes through `x` with a tangent not along the face, or
with its curvature towards the half-box when `y = x − e θ`). -/
theorem circles_meet_halfBox {x y : ℂ} {θ ε : ℝ} (hε : 0 < ε) (hxy : dist x y = 1) (hy : y ≠ x + e θ) :
    ∃ r > (0 : ℝ), ∀ y' ∈ ball y r, ∃ φ : ℝ, y' + e φ ∈ halfBox x θ ε := by
  obtain ⟨a, b, hyd, hab⟩ := frame_coords θ hxy
  have hne : ¬(a = 1 ∧ b = 0) := by
    rintro ⟨rfl, rfl⟩
    apply hy; rw [hyd]; simp
  obtain ⟨s₁, t₁, s₂, t₂, hs₁, hs₁', ht₁, hs₂, hs₂', ht₂, h1, h2⟩ := exists_frame_sides hε hab hne
  have hd1 : dist (framePt x θ s₁ t₁) y < 1 := by
    rw [hyd]
    have := dist_framePt_sq x θ s₁ t₁ a b
    by_contra hcon; push Not at hcon
    nlinarith [dist_nonneg (x := framePt x θ s₁ t₁) (y := x + e θ * (a + b * I))]
  have hd2 : 1 < dist (framePt x θ s₂ t₂) y := by
    rw [hyd]
    have := dist_framePt_sq x θ s₂ t₂ a b
    by_contra hcon; push Not at hcon
    nlinarith [dist_nonneg (x := framePt x θ s₂ t₂) (y := x + e θ * (a + b * I))]
  refine ⟨min (1 - dist (framePt x θ s₁ t₁) y) (dist (framePt x θ s₂ t₂) y - 1), lt_min (by linarith) (by linarith), ?_⟩
  intro y' hy'
  rw [mem_ball] at hy'
  have hr1 := lt_of_lt_of_le hy' (min_le_left _ _)
  have hr2 := lt_of_lt_of_le hy' (min_le_right _ _)
  refine exists_circle_point_halfBox hs₁ hs₁' ht₁ hs₂ hs₂' ht₂ ?_ ?_
  · linarith [dist_triangle (framePt x θ s₁ t₁) y y', dist_comm y y']
  · linarith [dist_triangle (framePt x θ s₂ t₂) y' y]

/-- **The face geometry at the normal** (I2b's case split, item 37's regime): for `y = x + e θ`, circles about `y'` nearer
than `1` along `e θ` meet the half-box, farther ones (and those at the same height off the normal) meet the far box by the
corner condition `(1 − g)² + ρ² ≥ 1`; the exceptional set is the one point `y`. -/
theorem circles_meet_boxes_at_normal {x : ℂ} {θ ε ε' g ρ : ℝ} (hε : 0 < ε) (hε' : 0 < ε') (hg : 0 < g) (hg1 : g < 1)
    (hρ : 0 < ρ) (hsharp : 2 * g - g ^ 2 ≤ ρ ^ 2) :
    ∃ r > (0 : ℝ), ∀ y' ∈ ball (x + e θ) r, y' ≠ x + e θ →
      ∃ φ : ℝ, y' + e φ ∈ halfBox x θ ε ∪ farBox x θ g ε' ρ := by
  refine ⟨min (min ε g) ρ, lt_min (lt_min hε hg) hρ, ?_⟩
  intro y' hy' hne
  rw [mem_ball] at hy'
  set w : ℂ := (y' - x) * e (-θ) with hw
  have hyw : y' = x + e θ * w := by
    calc y' = x + (y' - x) * (e θ * e (-θ)) := by rw [e_mul_e_neg]; ring
      _ = _ := by rw [hw]; ring
  set u : ℝ := w.re - 1 with hu
  set v : ℝ := w.im with hv
  have hwd : w = ((1 + u : ℝ) : ℂ) + (v : ℂ) * I := by
    apply Complex.ext <;> simp [hu, hv]
  have hdist : dist y' (x + e θ) = ‖w - 1‖ := by
    rw [dist_eq_norm, hyw]
    have : x + e θ * w - (x + e θ) = e θ * (w - 1) := by ring
    rw [this, norm_mul, norm_e, one_mul]
  have hu' : |u| ≤ ‖w - 1‖ := by
    have := Complex.abs_re_le_norm (w - 1); simpa [hu] using this
  have hv' : |v| ≤ ‖w - 1‖ := by
    have := Complex.abs_im_le_norm (w - 1); simpa [hv] using this
  have hr : ‖w - 1‖ < min (min ε g) ρ := by rw [← hdist]; exact hy'
  have hrε := lt_of_lt_of_le hr ((min_le_left _ _).trans (min_le_left _ _))
  have hrg := lt_of_lt_of_le hr ((min_le_left _ _).trans (min_le_right _ _))
  have hrρ := lt_of_lt_of_le hr (min_le_right _ _)
  rcases lt_or_ge u 0 with hu0 | hu0
  · refine ⟨θ + Real.pi, Or.inl ⟨-u, v, by linarith [(abs_lt.1 (lt_of_le_of_lt hu' hrε)).1], by linarith [(abs_lt.1 (lt_of_le_of_lt hu' hrε)).1], ?_, ?_⟩⟩
    · exact lt_of_le_of_lt hv' hrε
    · rw [e_add_pi, hyw, hwd]; push_cast; ring
  · have hnz : ¬(u = 0 ∧ v = 0) := by
      rintro ⟨h1, h2⟩
      apply hne
      rw [hyw, hwd, h1, h2]; simp
    obtain ⟨σ, τ, h1, h2, h3, h4⟩ := exists_far_point hg hg1 hε' hρ hsharp hu0
      (lt_of_le_of_lt (le_abs_self u) (lt_of_le_of_lt hu' hrg)) (lt_of_le_of_lt hv' hrρ) hnz
    set z : ℂ := x + e θ * ((σ : ℂ) + (τ : ℂ) * I) with hz
    have hzd : dist z y' = 1 := by
      rw [dist_eq_norm, hz, hyw, hwd]
      have : x + e θ * ((σ : ℂ) + (τ : ℂ) * I) - (x + e θ * (((1 + u : ℝ) : ℂ) + (v : ℂ) * I)) =
          e θ * ((((σ - (1 + u)) : ℝ) : ℂ) + ((τ - v : ℝ) : ℂ) * I) := by push_cast; ring
      rw [this, norm_mul, norm_e, one_mul]
      have hs := norm_sq_re_im (σ - (1 + u)) (τ - v)
      rw [h4] at hs
      exact (pow_eq_one_iff_of_nonneg (norm_nonneg _) two_ne_zero).1 (by simpa using hs)
    obtain ⟨φ, hφ⟩ := exists_phi_of_dist_eq_one hzd
    exact ⟨φ, Or.inr ⟨σ, τ, h1, h2, h3, by rw [hφ]⟩⟩


/-- **FS111-V0-RESCALE**: if an a.e.-proper measurable `k`-colouring exists, a tight one exists. -/
theorem AeColouring.exists_tight (c : AeColouring k) : ∃ c' : AeColouring k, c'.Tight := by
  sorry

/-- **FS111-V0-RESCALE**, second clause: a tight a.e.-proper `k`-colouring exists iff `χ_m⁰(ℝ²) ≤ k`. -/
theorem exists_tight_iff_chiM0_le : (∃ c : AeColouring k, c.Tight) ↔ chiM0 ≤ k := by
  constructor
  · rintro ⟨c, -⟩; exact chiM0_le c
  · intro h
    have hm : ∃ m ≤ k, Nonempty (AeColouring m) := by
      by_contra hcon
      push Not at hcon
      have : ((k + 1 : ℕ) : ℕ∞) ≤ chiM0 := by
        refine le_iInf₂ fun m ⟨c⟩ => ?_
        have : k < m := by
          by_contra hmk
          exact (hcon m (not_lt.1 hmk)).false c
        exact_mod_cast this
      have h2 := this.trans h
      have : k + 1 ≤ k := by exact_mod_cast h2
      omega
    obtain ⟨m, hmk, ⟨c⟩⟩ := hm
    obtain ⟨c', -⟩ : ∃ c' : AeColouring k, True := by
      refine ⟨⟨fun z => Fin.castLE hmk (c.col z), ?_, fun j => ?_⟩, trivial⟩
      · exact (measurable_of_finite (Fin.castLE hmk)).comp c.measurable
      · by_cases hj : ∃ j', Fin.castLE hmk j' = j
        · obtain ⟨j', rfl⟩ := hj
          have : (fun z => Fin.castLE hmk (c.col z)) ⁻¹' {Fin.castLE hmk j'} = c.col ⁻¹' {j'} := by
            ext z; simp [(Fin.castLE_injective hmk).eq_iff]
          rw [this]; exact c.unitPairsNull j'
        · have : (fun z => Fin.castLE hmk (c.col z)) ⁻¹' {j} = ∅ := by
            ext z; simp only [mem_preimage, mem_singleton_iff, mem_empty_iff_false, iff_false]
            exact fun h => hj ⟨_, h⟩
          rw [this]
          have : UnitPairsNull (∅ : Set ℂ) := by
            rw [UnitPairsNull, show unitPairSet (∅ : Set ℂ) = ∅ by ext q; simp [unitPairSet], measure_empty]
          exact this
    exact AeColouring.exists_tight c'

/-- **FS129-SR2-SUPK** (carrying FS106-SUP's first clause, at every `k`): `µ_k⁰ = lim_{ε→0} µ_k(ε)`. -/
theorem tendsto_mu (k : ℕ) : Tendsto (mu k) (𝓝[>] 0) (𝓝 (muZero k)) := by
  sorry

/-- **FS129-SR2-SUPK**: `µ_k⁰ = lim_{ε→0} µ_k^tile(ε)`. -/
theorem tendsto_muTile (k : ℕ) : Tendsto (muTile k) (𝓝[>] 0) (𝓝 (muZero k)) := by
  sorry

/-- **FS129-SR2-SUPK**: `µ_k⁰ = lim_{ε→0} µ_k^per(ε)`. -/
theorem tendsto_muPer (k : ℕ) : Tendsto (muPer k) (𝓝[>] 0) (𝓝 (muZero k)) := by
  sorry

/-- FS-103's M1, hard direction, as the named hypothesis FS106-EQ's `χ_CP` clause reads (outside the backlog). -/
def Row130M1 : Prop := ∀ k : ℕ, chiM0 ≤ k → chiCP ≤ k

/-- FS-103's M1, easy direction (TQ § 2.3, steps 1 and 3): a CP `k`-colouring has a jointly measurable modification whose
realisations are a.e.-proper, so `χ_m⁰(ℝ²) ≤ χ_CP(ℝ²)`. Formalized here; no hypothesis. -/
theorem chiM0_le_chiCP : chiM0 ≤ chiCP := by
  sorry

/-- **FS106-EQ**, (a) ⟺ (c), and FS106-COMP's first clause as (c) ⟹ (a) at every `k` (SR2 item 11):
`χ_m⁰(ℝ²) ≤ k ⟺ µ_k⁰ = 1`. -/
theorem chiM0_le_iff_muZero_eq_one (k : ℕ) : chiM0 ≤ k ↔ muZero k = 1 := by
  sorry

/-- **FS106-EQ**, (a) ⟺ (b), given FS-103's M1 (`Row130M1`, named): `χ_m⁰(ℝ²) ≤ k ⟺ χ_CP(ℝ²) ≤ k`. -/
theorem chiM0_le_iff_chiCP_le (hM1 : Row130M1) (k : ℕ) : chiM0 ≤ k ↔ chiCP ≤ k :=
  ⟨hM1 k, fun h => chiM0_le_chiCP.trans h⟩

/-- **FS106-EQ**, (c) ⟺ (d) (SUPK at the value `1`): `µ_k⁰ = 1 ⟺ lim_{ε→0} µ_k(ε) = 1`. -/
theorem muZero_eq_one_iff_tendsto (k : ℕ) : muZero k = 1 ↔ Tendsto (mu k) (𝓝[>] 0) (𝓝 1) := by
  constructor
  · intro h; rw [← h]; exact tendsto_mu k
  · intro h; exact tendsto_nhds_unique (tendsto_mu k) h |>.symm ▸ rfl

/-- A band-free class (no pair at a distance in `[1 − ε, 1 + ε]`, `ε ≥ 0`) has null unit pairs. -/
theorem unitPairsNull_of_bandFree {A : Set ℂ} {ε : ℝ} (hε : 0 ≤ ε) (h : BandFree A ε) : UnitPairsNull A := by
  rw [UnitPairsNull]
  have : unitPairSet A = ∅ := by
    ext q
    simp only [unitPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro hx hy
    have hd : dist q.1 (q.1 + e q.2) = 1 := by rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]
    rcases h _ hx _ hy with h1 | h1 <;> linarith
  rw [this, measure_empty]

/-- **FS106-EQ**, (a) ⟺ (e): `χ_m⁰(ℝ²) ≤ k` iff for every `δ > 0` there are `ε > 0` and a periodic partial `k`-colouring by
half-open grid squares with no monochromatic pair at any distance in `[1 − ε, 1 + ε]`, covering upper density at least
`1 − δ`. -/
theorem chiM0_le_iff_periodic (k : ℕ) :
    chiM0 ≤ k ↔ ∀ δ > 0, ∃ ε > 0, ∃ C : Fin k → Set ℂ, IsPartialColouring C ∧ IsTiled C ∧ IsPeriodic C ∧
      (∀ j, BandFree (C j) ε) ∧ 1 - ENNReal.ofReal δ ≤ upperDensity (⋃ j, C j) := by
  constructor
  · intro h δ hδ
    have hz : muZero k = 1 := (chiM0_le_iff_muZero_eq_one k).1 h
    have hlim := tendsto_muPer k
    rw [hz] at hlim
    have hlt : 1 - ENNReal.ofReal δ < 1 := ENNReal.sub_lt_self (by simp) one_ne_zero (by simpa using hδ)
    have hev := hlim.eventually (lt_mem_nhds hlt)
    obtain ⟨ε, hε, hεpos⟩ := (hev.and self_mem_nhdsWithin).exists
    obtain ⟨C, hC⟩ := lt_iSup_iff.1 hε
    obtain ⟨hCp, hdens⟩ := lt_iSup_iff.1 hC
    exact ⟨ε, hεpos, C, hCp.1, hCp.2.1, hCp.2.2.1, hCp.2.2.2, hdens.le⟩
  · intro h
    refine (chiM0_le_iff_muZero_eq_one k).2 (le_antisymm (muZero_le_one k) ?_)
    refine ENNReal.le_of_forall_pos_le_add fun r hr _ => ?_
    obtain ⟨ε, hε, C, hCp, hCt, hCper, hCb, hd⟩ := h (r : ℝ) (by exact_mod_cast hr)
    have hle : upperDensity (⋃ j, C j) ≤ muZero k :=
      le_iSup₂ (f := fun C (_ : IsPartialColouring C ∧ ∀ j, UnitPairsNull (C j)) => upperDensity (⋃ j, C j)) C
        ⟨hCp, fun j => unitPairsNull_of_bandFree hε.le (hCb j)⟩
    have h3 : 1 - ENNReal.ofReal (r : ℝ) ≤ muZero k := hd.trans hle
    rw [tsub_le_iff_right, ENNReal.ofReal_coe_nnreal] at h3
    exact h3

/-- **FS106-EQ**, at `k = 6`: `χ_m⁰(ℝ²) ≥ 7 ⟺ lim_{ε→0} µ₆(ε) < 1` (the limit is the supremum over `ε > 0`, `µ₆` being
antitone). -/
theorem seven_le_chiM0_iff : 7 ≤ chiM0 ↔ (⨆ ε > (0 : ℝ), mu 6 ε) < 1 := by
  have hlim : muZero 6 = ⨆ ε > (0 : ℝ), mu 6 ε := by
    have h1 := (antitone_mu 6).tendsto_nhdsGT 0
    rw [sSup_image] at h1
    exact tendsto_nhds_unique (tendsto_mu 6) h1
  have hle : (⨆ ε > (0 : ℝ), mu 6 ε) ≤ 1 := iSup₂_le fun ε _ => mu_le_one 6 ε
  have h7 : (7 : ℕ∞) ≤ chiM0 ↔ ¬ chiM0 ≤ 6 := by
    rw [not_le]
    have := ENat.add_one_le_iff (m := 6) (n := chiM0) (by decide)
    rwa [show (6 : ℕ∞) + 1 = 7 by norm_num] at this
  have h6 : chiM0 ≤ 6 ↔ muZero 6 = 1 := by exact_mod_cast chiM0_le_iff_muZero_eq_one 6
  rw [h7, h6, hlim]
  constructor
  · intro h; exact lt_of_le_of_ne hle h
  · intro h h1; exact h.ne h1

/-- `[Voronov2023]` Thm 1.1 (Euclidean norm, six colours), as a statement: for every `ε > 0` no six-colouring of the plane
is proper for the forbidden interval `[1 − ε, 1 + ε]` (D-VPROP). Named here, not imported (FS106-COMP's clause is an
equivalence, not a use). -/
def Voronov11 : Prop :=
  ∀ ε > 0, ¬ ∃ f : ℂ → Fin 6, ∀ x y, 1 - ε ≤ dist x y → dist x y ≤ 1 + ε → f x ≠ f y

/-- **FS106-SUP's attainment clause, at the value FS106-COMP reads** (carried content of FS129-SR2-SUPK's merged row, inventory
item 23): if `µ_k(ε) = 1`, some partial `k`-colouring whose classes are band-null at `ε` covers almost every point. QB § 2.7
reaches it through SUP's stationary attaining family (mean coverage `1`); FS106-QB § 2.4's compactness argument for (c) ⟹ (a)
gives it directly at every `k` — translates to windows of small hole measure, a weak-* limit, the band form continuous because
its kernel `1_{annulus}` is `L¹` (no Rajchman step, no Krylov–Bogolyubov), and support selection. -/
theorem exists_bandNull_aeCover_of_mu_eq_one {k : ℕ} {ε : ℝ} (hε : 0 < ε) (h : mu k ε = 1) :
    ∃ C : Fin k → Set ℂ, IsPartialColouring C ∧ (∀ j, BandNull (C j) ε) ∧ ∀ᵐ x ∂volume, ∃ j, x ∈ C j := by
  sorry

/-- A band-free class is band-null. -/
theorem bandNull_of_bandFree {A : Set ℂ} {ε : ℝ} (h : BandFree A ε) : BandNull A ε := by
  have : bandPairSet A ε = ∅ := by
    ext q
    simp only [bandPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro hx hy h1 h2
    rcases h _ hx _ hy with h3 | h3 <;> linarith
  rw [BandNull, this, measure_empty]

open Classical in
/-- COMP, `⟹`: if `µ₆(ε) < 1` for every `ε > 0`, no six-colouring is proper on a band (the closures of the colour
classes, made disjoint, are a band-free partial colouring covering everything, so `µ₆(ε/2) = 1`). -/
theorem voronov11_of_forall_mu_lt (H : ∀ ε > (0 : ℝ), mu 6 ε < 1) : Voronov11 := by
  intro ε hε ⟨f, hf⟩
  set cl : Fin 6 → Set ℂ := fun j => closure (f ⁻¹' {j}) with hcl
  have h1 : ∀ j, ∀ x ∈ cl j, ∀ y ∈ cl j, dist x y ≤ 1 - ε ∨ 1 + ε ≤ dist x y := by
    intro j x hx y hy
    by_contra hcon
    push Not at hcon
    have hxy : (x, y) ∈ closure ((f ⁻¹' {j}) ×ˢ (f ⁻¹' {j})) := by
      rw [closure_prod_eq]; exact ⟨hx, hy⟩
    have hopen : IsOpen {q : ℂ × ℂ | 1 - ε < dist q.1 q.2 ∧ dist q.1 q.2 < 1 + ε} :=
      (isOpen_lt continuous_const (continuous_fst.dist continuous_snd)).inter
        (isOpen_lt (continuous_fst.dist continuous_snd) continuous_const)
    have hmem : (x, y) ∈ {q : ℂ × ℂ | 1 - ε < dist q.1 q.2 ∧ dist q.1 q.2 < 1 + ε} := ⟨hcon.1, hcon.2⟩
    obtain ⟨q, hq1, hq2⟩ := mem_closure_iff.1 hxy _ hopen hmem
    exact hf q.1 q.2 hq1.1.le hq1.2.le (by rw [mem_prod] at hq2; exact (hq2.1.trans hq2.2.symm))
  set C : Fin 6 → Set ℂ := fun j => cl j \ ⋃ i < j, cl i with hC
  have hCm : ∀ j, MeasurableSet (C j) := fun j =>
    isClosed_closure.measurableSet.diff (MeasurableSet.biUnion (countable_univ.mono (subset_univ _))
      fun i _ => isClosed_closure.measurableSet)
  have hcov : ⋃ j, C j = univ := by
    refine eq_univ_of_forall fun x => ?_
    have hne : (Finset.univ.filter fun j => x ∈ cl j).Nonempty := ⟨f x, by simp [hcl]; exact subset_closure rfl⟩
    set j0 := (Finset.univ.filter fun j => x ∈ cl j).min' hne
    have hj0 : x ∈ cl j0 := by
      have := Finset.min'_mem _ hne; simpa using this
    refine mem_iUnion.2 ⟨j0, hj0, ?_⟩
    simp only [mem_iUnion, not_exists]
    intro i hi hxi
    have : j0 ≤ i := Finset.min'_le _ i (by simpa using hxi)
    exact absurd hi (not_lt.2 this)
  have hdis : Pairwise (Function.onFun Disjoint C) := by
    intro i j hij
    wlog h : i < j generalizing i j
    · exact (this hij.symm (lt_of_le_of_ne (not_lt.1 h) hij.symm)).symm
    refine disjoint_left.2 fun x hxi hxj => hxj.2 (mem_iUnion₂.2 ⟨i, h, hxi.1⟩)
  have hfree : ∀ j, BandFree (C j) (ε / 2) := by
    intro j x hx y hy
    rcases h1 j x hx.1 y hy.1 with h | h
    · left; linarith
    · right; linarith
  have hle : (1 : ENNReal) ≤ mu 6 (ε / 2) := by
    calc (1 : ENNReal) = upperDensity (⋃ j, C j) := by rw [hcov, upperDensity_univ]
      _ ≤ mu 6 (ε / 2) := le_iSup₂ (f := fun C (_ : IsPartialColouring C ∧ ∀ j, BandNull (C j) (ε / 2)) =>
          upperDensity (⋃ j, C j)) C ⟨⟨hCm, hdis⟩, fun j => bandNull_of_bandFree (hfree j)⟩
  exact absurd (H (ε / 2) (by linarith)) (not_lt.2 hle)


open Classical in
/-- COMP, `⟸`, through the attainment lemma: the supports of the classes of an a.e.-covering band-null partial colouring
cover the plane, and the least index of a support containing `x` is a six-colouring proper on `[1 − ε/2, 1 + ε/2]`. -/
theorem mu_lt_of_voronov11 (hV : Voronov11) {ε : ℝ} (hε : 0 < ε) : mu 6 ε < 1 := by
  by_contra hcon
  have h1 : mu 6 ε = 1 := le_antisymm (mu_le_one 6 ε) (not_lt.1 hcon)
  obtain ⟨C, hCp, hband, hae⟩ := exists_bandNull_aeCover_of_mu_eq_one hε h1
  -- the supports cover the plane
  have hcl : IsClosed (⋃ j, essSupport (C j)) := isClosed_iUnion_of_finite fun j => isClosed_essSupport _
  have hfull : ⋃ j, essSupport (C j) = univ := by
    by_contra hne
    have hopen : IsOpen (⋃ j, essSupport (C j))ᶜ := hcl.isOpen_compl
    have hnonempty : (⋃ j, essSupport (C j))ᶜ.Nonempty := by
      rwa [nonempty_iff_ne_empty, Ne, compl_empty_iff]
    have hpos := hopen.measure_pos volume hnonempty
    refine hpos.ne' (measure_mono_null (t := {x | ¬ ∃ j, x ∈ C j} ∪ ⋃ j, C j \ essSupport (C j)) ?_ ?_)
    · intro x hx
      by_cases hx' : ∃ j, x ∈ C j
      · obtain ⟨j, hj⟩ := hx'
        right
        refine mem_iUnion.2 ⟨j, hj, fun hs => hx (mem_iUnion.2 ⟨j, hs⟩)⟩
      · exact Or.inl hx'
    · exact measure_union_null (by simpa [ae_iff] using hae)
        (measure_iUnion_null fun j => volume_diff_essSupport (C j))
  set f : ℂ → Fin 6 := fun x => if h : ∃ j, x ∈ essSupport (C j) then Classical.choose h else 0 with hf
  have hfs : ∀ x, x ∈ essSupport (C (f x)) := by
    intro x
    have h : ∃ j, x ∈ essSupport (C j) := by
      have : x ∈ ⋃ j, essSupport (C j) := by rw [hfull]; trivial
      simpa using this
    simp only [hf, dif_pos h]
    exact Classical.choose_spec h
  refine hV (ε / 2) (by linarith) ⟨f, fun x y h1 h2 hxy => ?_⟩
  set j := f x
  have hy : y ∈ essSupport (C j) := by rw [hxy]; exact hfs y
  have hx : x ∈ essSupport (C j) := hfs x
  refine absurd (hband j) ?_
  unfold BandNull
  set r : ℝ := ε / 4 with hr4
  have hr : 0 < r := by positivity
  have hsub : (C j ∩ ball x r) ×ˢ (C j ∩ ball y r) ⊆ bandPairSet (C j) ε := by
    rintro ⟨a, b⟩ ⟨⟨ha, hax⟩, hb, hby⟩
    rw [mem_ball] at hax hby
    refine ⟨ha, hb, ?_, ?_⟩
    · show 1 - ε ≤ dist a b
      have t1 := dist_triangle4 x a b y
      rw [dist_comm x a] at t1
      simp only at hax hby
      linarith [hr4]
    · show dist a b ≤ 1 + ε
      have t1 := dist_triangle4 a x y b
      rw [dist_comm y b] at t1
      simp only at hax hby
      linarith [hr4]
  have hpos : 0 < (volume.prod volume) ((C j ∩ ball x r) ×ˢ (C j ∩ ball y r)) := by
    rw [Measure.prod_prod]
    exact ENNReal.mul_pos (hx r hr).ne' (hy r hr).ne'
  exact fun h0 => hpos.ne' (measure_mono_null hsub h0)

/-- **FS106-COMP**, second clause: "`µ₆(ε) < 1` for every `ε > 0`" is equivalent to `[Voronov2023]` Thm 1.1. -/
theorem forall_mu_six_lt_one_iff : (∀ ε > (0 : ℝ), mu 6 ε < 1) ↔ Voronov11 := by
  exact ⟨voronov11_of_forall_mu_lt, fun hV ε hε => mu_lt_of_voronov11 hV hε⟩

/-- **FS106-REM**, first clause (one class, G92): for a measurable `A` with null unit pairs, any `η < 1/(1 + 4π)` and every
`ε > 0`, two points kept at scale `ε` are never at a distance in `[1 − ε, 1 + ε]`. (The row reads kept points of one
colour of a partial colouring; membership of the points in `A` is not used — a generalization.) -/
theorem keptAt_band {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {η : ℝ} (hη0 : 0 ≤ η)
    (hη : η < 1 / (1 + 4 * Real.pi)) {ε : ℝ} (hε : 0 < ε) {x y : ℂ} (hx : KeptAt A η ε x) (hy : KeptAt A η ε y) :
    dist x y < 1 - ε ∨ 1 + ε < dist x y := by
  rcases le_or_gt ε (1 / 2) with h | h
  · exact keptAt_band_le_half hA hnull hη0 hη hε h hx hy
  · exfalso
    have h4 : η < 1 / 4 := lt_of_lt_of_le hη (by
      apply one_div_le_one_div_of_le (by norm_num); linarith [Real.pi_gt_three])
    exact not_keptAt_of_half_lt hA hnull hη0 h4 h x hx

/-- **FS106-REM**, second clause: for a CP colouring, `P(0 is not kept at scale ε) → 0`, "kept" read in a jointly
measurable modification `c̃` of the realisations. -/
theorem CPColouring.tendsto_not_kept (c : CPColouring k) {η : ℝ} (hη0 : 0 < η) :
    ∃ ct : (ℂ → Fin k) → ℂ → Fin k, Measurable (Function.uncurry ct) ∧ (∀ x, c.law {f | ct f x ≠ f x} = 0) ∧
      Tendsto (fun ε => c.law {f | ¬ KeptAt (ct f ⁻¹' {ct f 0}) η ε 0}) (𝓝[>] 0) (𝓝 0) := by
  sorry

/-- **FS106-REM**, third clause (ruling `plans/FS131-close-inventory.md` item 63: `η < 1` added, since at `η ≥ 1` every point
is kept): the uniform form is FALSE — some measurable colouring proper at every unit pair (the
zigzag colouring, FS106-TQ's control C2) has, at every `ε`, translates of the unit square holding non-kept points of
measure bounded below. -/
theorem exists_not_uniform_kept {η : ℝ} (hη0 : 0 < η) (hη : η < 1) :
    ∃ (k : ℕ) (f : ℂ → Fin k), Measurable f ∧ (∀ x y, dist x y = 1 → f x ≠ f y) ∧ ∃ m > (0 : ENNReal),
      ∀ ε > (0 : ℝ), ∃ z : ℂ, m ≤ volume {x | x - z ∈ {w : ℂ | 0 ≤ w.re ∧ w.re ≤ 1 ∧ 0 ≤ w.im ∧ w.im ≤ 1} ∧
        ¬ KeptAt (f ⁻¹' {f x}) η ε x} := by
  sorry

/-- **FS121-D4-FACE** with **FS121-V5-FACE-SHARP**'s hypothesis `ρ² ≥ 2g − g²` (SR1 item 6), one class (G92: the argument
reads only `A`'s own unit pairs): if the half-box and the far box lie almost everywhere in `A`, no point of `supp A` is at
distance exactly `1` from `x`. The far box lies between `x` and `x + e` (`g < 1`; ruling, `plans/FS131-close-inventory.md` item
37: for `g > 2` the sharp hypothesis holds for every `ρ` and the clause is false — a far box beyond `x + 2e` meets no unit circle
about the points near `x + e`). -/
theorem face {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {x : ℂ} {θ ε ε' g ρ : ℝ} (hε : 0 < ε)
    (hε' : 0 < ε') (hg : 0 < g) (hg1 : g < 1) (hρ : 0 < ρ) (hsharp : 2 * g - g ^ 2 ≤ ρ ^ 2)
    (hhalf : volume (halfBox x θ ε \ A) = 0) (hfar : volume (farBox x θ g ε' ρ \ A) = 0) :
    ∀ y ∈ essSupport A, dist x y ≠ 1 := by
  intro y hy hxy
  by_cases hyn : y = x + e θ
  · obtain ⟨r, hr, hm⟩ := circles_meet_boxes_at_normal hε hε' hg hg1 hρ hsharp
    refine not_unitPairsNull_of_circles_meet hA ((isOpen_halfBox x θ ε).union (isOpen_farBox x θ g ε' ρ)) ?_ hy hr
      (N := {y}) (measure_singleton y) ?_ hnull
    · rw [union_sdiff_distrib]; exact measure_union_null hhalf hfar
    · intro y' hy' hy'N
      exact hm y' (hyn ▸ hy') (fun h => hy'N (by rw [hyn]; exact h))
  · obtain ⟨r, hr, hm⟩ := circles_meet_halfBox hε hxy hyn
    exact not_unitPairsNull_of_circles_meet hA (isOpen_halfBox x θ ε) hhalf hy hr (N := ∅) (by simp)
      (fun y' hy' _ => hm y' hy') hnull

/-- A set filling a half-box behind `x` almost everywhere has positive upper density at `x`. -/
theorem upperDensityAt_pos_of_halfBox {A : Set ℂ} {x : ℂ} {θ ε : ℝ} (hε : 0 < ε)
    (hhalf : volume (halfBox x θ ε \ A) = 0) : 0 < upperDensityAt A x := by
  have hev : ∀ᶠ r in 𝓝[>] (0 : ℝ), (1 / 16 : ENNReal) ≤ densityRatio A x r := by
    have : Ioo (0 : ℝ) ε ∈ 𝓝[>] (0 : ℝ) := Ioo_mem_nhdsGT hε
    filter_upwards [this] with r hr
    have hr0 : 0 < r := hr.1
    have hεr : r < ε := hr.2
    set c : ℂ := x - ((r / 2 : ℝ) : ℂ) * e θ with hc
    have hne : e θ ≠ 0 := by
      intro h; have := norm_e θ; rw [h, norm_zero] at this; exact zero_ne_one this
    have hsub : ball c (r / 4) ⊆ halfBox x θ ε := by
      intro w hw
      rw [mem_ball, dist_eq_norm] at hw
      set q : ℂ := (w - x) / e θ with hq
      have hqn : ‖q + ((r / 2 : ℝ) : ℂ)‖ < r / 4 := by
        have : q + ((r / 2 : ℝ) : ℂ) = (w - c) / e θ := by
          rw [hc, hq]; field_simp; ring
        rw [this, norm_div, norm_e, div_one]; exact hw
      have h1 : |q.re + r / 2| < r / 4 := by
        have := Complex.abs_re_le_norm (q + ((r / 2 : ℝ) : ℂ)); rw [Complex.add_re, Complex.ofReal_re] at this; linarith
      have h2 : |q.im| < r / 4 := by
        have := Complex.abs_im_le_norm (q + ((r / 2 : ℝ) : ℂ)); rw [Complex.add_im, Complex.ofReal_im, add_zero] at this; linarith
      rw [abs_lt] at h1 h2
      refine ⟨-q.re, q.im, by linarith [h1.1, h1.2], by linarith [h1.1, h1.2], ?_, ?_⟩
      · rw [abs_lt]; constructor <;> linarith [h2.1, h2.2]
      · have : (-((-q.re : ℝ) : ℂ) + (q.im : ℂ) * I) = q := by
          apply Complex.ext <;> simp
        rw [this, hq]; field_simp; ring
    have hcl : ball c (r / 4) ⊆ closedBall x r := by
      intro w hw
      rw [mem_ball] at hw
      rw [mem_closedBall]
      have h3 : dist c x = r / 2 := by
        rw [hc, dist_eq_norm, sub_sub_cancel_left, norm_neg, norm_mul, norm_e, mul_one, Complex.norm_real,
          Real.norm_eq_abs, abs_of_pos (by linarith)]
      linarith [dist_triangle w c x]
    have hmeas : volume (ball c (r / 4)) ≤ volume (A ∩ closedBall x r) := by
      have h4 : volume (ball c (r / 4) \ A) = 0 :=
        measure_mono_null (t := halfBox x θ ε \ A) (fun w hw => ⟨hsub hw.1, hw.2⟩) hhalf
      calc volume (ball c (r / 4)) ≤ volume (ball c (r / 4) ∩ A) + volume (ball c (r / 4) \ A) :=
            measure_le_inter_add_sdiff _ _ _
        _ = volume (ball c (r / 4) ∩ A) := by rw [h4, add_zero]
        _ ≤ volume (A ∩ closedBall x r) := measure_mono fun w hw => ⟨hw.2, hcl hw.1⟩
    unfold densityRatio
    refine (ENNReal.le_div_iff_mul_le (Or.inl (measure_closedBall_pos volume x hr0).ne') (Or.inl measure_closedBall_lt_top.ne)).2 ?_
    refine le_trans ?_ hmeas
    rw [Complex.volume_ball, Complex.volume_closedBall]
    have h4 : ENNReal.ofReal (r / 4) = ENNReal.ofReal r / 4 := by
      rw [ENNReal.ofReal_div_of_pos (by norm_num)]; simp
    rw [h4, div_eq_mul_inv (ENNReal.ofReal r), mul_pow, ← ENNReal.inv_pow]
    have h16 : (4 : ENNReal) ^ 2 = 16 := by norm_num
    rw [h16, one_div]
    refine le_of_eq ?_
    ring
  exact lt_of_lt_of_le (by norm_num) (le_limsup_of_frequently_le hev.frequently)

/-- **FS121-D4-FACE**, last clause: so in a saturated colouring the colour has density `1` at `x` (`g < 1`, ruling item 37). -/
theorem face_densitySet {C : Fin k → Set ℂ} (hadm : IsAdmissible C) (hsat : Saturated C) {j : Fin k} {x : ℂ}
    {θ ε ε' g ρ : ℝ} (hε : 0 < ε) (hε' : 0 < ε') (hg : 0 < g) (hg1 : g < 1) (hρ : 0 < ρ)
    (hsharp : 2 * g - g ^ 2 ≤ ρ ^ 2)
    (hhalf : volume (halfBox x θ ε \ C j) = 0) (hfar : volume (farBox x θ g ε' ρ \ C j) = 0) :
    x ∈ densitySet (C j) := by
  have hA := hadm j
  have hpos := upperDensityAt_pos_of_halfBox hε hhalf
  by_contra hx
  obtain ⟨y, hy, hxy⟩ := hsat j x ⟨hpos, hx⟩
  rw [← essSupport_eq_closure_densitySet] at hy
  exact face hA.1 hA.2 hε hε' hg hg1 hρ hsharp hhalf hfar y hy hxy

/-- **FS121-V5-FACE-SHARP**, its failure half: whenever `ρ² < 2g − g²` the first clause fails for some a.e.-proper colouring
(V5 § 2.2's explicit colouring at `g = 1/10`, `ρ = 2/5`, generalized). Ruling, `plans/FS131-close-inventory.md` item 86:
`2ρ < 1` and `g² + ρ² < 1` added — outside them the far box holds unit pairs, or the half-box and far box together do, so no
class of an a.e.-proper colouring holds both (counterexamples `g = 1, ρ = 9/10` and `g = 19/20, ρ = 9/20`). -/
theorem exists_face_fails {g ρ : ℝ} (hg : 0 < g) (hρ : 0 < ρ) (hlt : ρ ^ 2 < 2 * g - g ^ 2) (hρ2 : 2 * ρ < 1)
    (hgρ : g ^ 2 + ρ ^ 2 < 1) :
    ∃ (k : ℕ) (c : AeColouring k) (j : Fin k) (x : ℂ) (θ ε ε' : ℝ), 0 < ε ∧ 0 < ε' ∧
      volume (halfBox x θ ε \ c.cls j) = 0 ∧ volume (farBox x θ g ε' ρ \ c.cls j) = 0 ∧
      ∃ y ∈ essSupport (c.cls j), dist x y = 1 := by
  sorry

end HadwigerNelson.Plane
