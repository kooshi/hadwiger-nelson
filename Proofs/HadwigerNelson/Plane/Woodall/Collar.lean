import Proofs.HadwigerNelson.Plane.Woodall.Basic
import Proofs.HadwigerNelson.Plane.SVMap
import Proofs.HadwigerNelson.Plane.Chord

/-!
# Two colours about a unit circle: Woodall's step-4 lemma, Townsend's `π/3` lemma (FS106-WO, FS106-TW)

FS131-W's skeleton (`plans/FS131-W-kernel-plan.md` § 3). Region-only throughout: two open colour classes `A`, `B`, no two points of one class
at distance exactly `1`, and sets lying in `closure (A ∪ B)` — the two-coloured sets of lemma (L) (`lemmaL`, FS106-L). Every theorem here is one
move: a change point `b` (both colours arbitrarily near) inside a collar, whose unit circle crosses `ω(u)` at `θ_b ± arccos(|b − u|/2)` and meets
a collar there, against lemma (L).

* **FS106-WO, the step-4 lemma** (`woodall_step4`): a collar of positive thickness about every angle of an open arc of length `> 2π/3`, on one
  side of `ω(u)`, cannot be two-coloured. **Sharp**: `not_woodall_step4_two_thirds` is Townsend's counterexample at length `2π/3`
  (`[Townsend1979ms]` p. 2, `[Townsend1981]` p. 114).
* **FS106-TW, Townsend's `π/3` lemma** (`townsend_lemma`, `[Townsend1979ms]` Thm 1 in the form its proof reads): if every angle off a finite set
  of cut angles carries a one-sided collar, and one side carries collars over a closed arc of length `> π/3`, the two-colouring fails.
* **The excluded set** (`collarAt_shadow_outer`, `collarAt_shadow_inner`, `ArcMap.col_not_mem_of_mem_shadow`): the cone of a connected piece of
  a class at `u` decides on which side of `ω(u)`, about which angles, the unit circles meet the piece; region points whose circles meet every
  class of `T` carry no colour of `T`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Annular sectors and collars: geometry -/

/-- Rotation by `e θ` times its conjugate is `1`. -/
theorem e_mul_conj_e (θ : ℝ) : e θ * starRingEnd ℂ (e θ) = 1 := by
  rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, norm_e]; simp


/-- Polar form of `z` about `u`, measured from the direction `θ₀`. -/
theorem eq_add_norm_mul_e (u z : ℂ) (θ₀ : ℝ) :
    z = u + (‖z - u‖ : ℂ) * e (θ₀ + Complex.arg ((z - u) * starRingEnd ℂ (e θ₀))) := by
  set w := (z - u) * starRingEnd ℂ (e θ₀) with hw
  have h1 : ‖w‖ = ‖z - u‖ := by
    rw [hw, norm_mul, Complex.norm_conj, norm_e, mul_one]
  have h2 : (‖w‖ : ℂ) * e (Complex.arg w) = w := by
    have := Complex.norm_mul_exp_arg_mul_I w
    rw [e]; exact this
  have h3 : z - u = w * e θ₀ := by
    rw [hw, mul_assoc, mul_comm (starRingEnd ℂ (e θ₀)), e_mul_conj_e, mul_one]
  have h4 : (‖w‖ : ℂ) * (e θ₀ * e (Complex.arg w)) = w * e θ₀ := by
    calc (‖w‖ : ℂ) * (e θ₀ * e (Complex.arg w)) = ((‖w‖ : ℂ) * e (Complex.arg w)) * e θ₀ := by ring
      _ = w * e θ₀ := by rw [h2]
  rw [e_add, ← h1, h4, ← h3]; ring

/-- Near `u + ρ₀ e θ₀` (`ρ₀ > 0`), the angle of `z` from `θ₀` is small. -/
theorem eventually_abs_arg_lt (u : ℂ) (θ₀ : ℝ) {ρ₀ δ : ℝ} (hρ : 0 < ρ₀) (hδ : 0 < δ) :
    ∀ᶠ z in 𝓝 (u + (ρ₀ : ℂ) * e θ₀), |Complex.arg ((z - u) * starRingEnd ℂ (e θ₀))| < δ := by
  have hw : ((u + (ρ₀ : ℂ) * e θ₀) - u) * starRingEnd ℂ (e θ₀) = (ρ₀ : ℂ) := by
    rw [add_sub_cancel_left, mul_assoc, e_mul_conj_e, mul_one]
  have hcont : ContinuousAt (fun z : ℂ => Complex.arg ((z - u) * starRingEnd ℂ (e θ₀))) (u + (ρ₀ : ℂ) * e θ₀) := by
    refine ContinuousAt.comp (g := Complex.arg) ?_ (by fun_prop)
    rw [hw]
    exact Complex.continuousAt_arg (Or.inl (by exact_mod_cast hρ))
  have h0 : Complex.arg ((((u + (ρ₀ : ℂ) * e θ₀)) - u) * starRingEnd ℂ (e θ₀)) = 0 := by
    rw [hw]; exact Complex.arg_ofReal_of_nonneg hρ.le
  have habs : ContinuousAt (fun z : ℂ => |Complex.arg ((z - u) * starRingEnd ℂ (e θ₀))|) (u + (ρ₀ : ℂ) * e θ₀) :=
    continuous_abs.continuousAt.comp hcont
  have hlt : |Complex.arg ((((u + (ρ₀ : ℂ) * e θ₀)) - u) * starRingEnd ℂ (e θ₀))| < δ := by
    rw [h0]; simpa using hδ
  exact habs.eventually_lt continuousAt_const hlt


/-- Near a point `u + ρ e θ` (`ρ > 0`), the norm `‖z − u‖` is near `ρ`. -/
theorem eventually_norm_sub_mem (u : ℂ) (θ : ℝ) {ρ : ℝ} {S : Set ℝ} (hS : IsOpen S) (hρ0 : 0 ≤ ρ) (hρ : ρ ∈ S) :
    ∀ᶠ z in 𝓝 (u + (ρ : ℂ) * e θ), ‖z - u‖ ∈ S := by
  have hc : ContinuousAt (fun z : ℂ => ‖z - u‖) (u + (ρ : ℂ) * e θ) := by fun_prop
  refine hc.eventually (hS.mem_nhds ?_)
  show ‖u + (ρ : ℂ) * e θ - u‖ ∈ S
  rw [add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hρ0]
  exact hρ

/-- An annular sector of non-negative inner radius is open (polar coordinates are a local homeomorphism off the centre). -/
theorem isOpen_annSector (u : ℂ) {r₁ : ℝ} (hr : 0 ≤ r₁) (r₂ θ₁ θ₂ : ℝ) : IsOpen (annSector u r₁ r₂ θ₁ θ₂) := by
  rw [isOpen_iff_mem_nhds]
  rintro z ⟨⟨ρ, θ⟩, ⟨hρ, hθ⟩, rfl⟩
  simp only at hρ hθ ⊢
  have hρ0 : 0 < ρ := lt_of_le_of_lt hr hρ.1
  have hδ : 0 < min (θ - θ₁) (θ₂ - θ) := lt_min (by linarith [hθ.1]) (by linarith [hθ.2])
  filter_upwards [eventually_abs_arg_lt u θ hρ0 hδ, eventually_norm_sub_mem u θ isOpen_Ioo hρ0.le hρ] with z' ha hb
  have h1 := lt_of_lt_of_le ha (min_le_left _ _)
  have h2 := lt_of_lt_of_le ha (min_le_right _ _)
  rw [abs_lt] at h1 h2
  refine ⟨(‖z' - u‖, θ + Complex.arg ((z' - u) * starRingEnd ℂ (e θ))), ⟨hb, ?_, ?_⟩, (eq_add_norm_mul_e u z' θ).symm⟩
  · simp only; linarith [h1.1, h1.2, h2.1, h2.2]
  · simp only; linarith [h1.1, h1.2, h2.1, h2.2]

/-- An annular sector is preconnected: the image of a convex set under a continuous map. -/
theorem isPreconnected_annSector (u : ℂ) (r₁ r₂ θ₁ θ₂ : ℝ) : IsPreconnected (annSector u r₁ r₂ θ₁ θ₂) := by
  refine (isPreconnected_Ioo.prod isPreconnected_Ioo).image _ ?_
  exact (by have := continuous_e; fun_prop : Continuous fun q : ℝ × ℝ => u + (q.1 : ℂ) * e q.2).continuousOn

/-- A collar of thickness at most `1` is open. -/
theorem isOpen_collar (u : ℂ) (s : Rim) (θ₁ θ₂ : ℝ) {h : ℝ} (hh : h ≤ 1) : IsOpen (collar u s θ₁ θ₂ h) := by
  cases s
  · exact isOpen_annSector u (by linarith) _ _ _
  · exact isOpen_annSector u zero_le_one _ _ _

/-- Collars shrink with their angles and their thickness. -/
theorem collar_subset_collar (u : ℂ) (s : Rim) {θ₁ θ₂ θ₁' θ₂' h h' : ℝ} (h₁ : θ₁ ≤ θ₁') (h₂ : θ₂' ≤ θ₂) (hh : h' ≤ h) :
    collar u s θ₁' θ₂' h' ⊆ collar u s θ₁ θ₂ h := by
  have key : ∀ {r₁ r₂ r₁' r₂' : ℝ}, r₁ ≤ r₁' → r₂' ≤ r₂ →
      annSector u r₁' r₂' θ₁' θ₂' ⊆ annSector u r₁ r₂ θ₁ θ₂ := fun hr₁ hr₂ =>
    image_mono (prod_mono (Ioo_subset_Ioo hr₁ hr₂) (Ioo_subset_Ioo h₁ h₂))
  cases s
  · exact key (by linarith) le_rfl
  · exact key le_rfl (by linarith)

/-- The radii of a collar of thickness `h` on the side `s` of `ω(u)`. -/
def Rim.radii : Rim → ℝ → Set ℝ
  | .inner, h => Ioo (1 - h) 1
  | .outer, h => Ioo 1 (1 + h)

/-- Radii shrink with the thickness. -/
theorem Rim.radii_mono (s : Rim) {h h' : ℝ} (hh : h' ≤ h) : s.radii h' ⊆ s.radii h := by
  cases s
  · exact Ioo_subset_Ioo (by linarith) le_rfl
  · exact Ioo_subset_Ioo le_rfl (by linarith)

/-- A collar is the polar image of its radii and its angles. -/
theorem mem_collar_iff (u : ℂ) (s : Rim) (θ₁ θ₂ h : ℝ) (z : ℂ) :
    z ∈ collar u s θ₁ θ₂ h ↔ ∃ ρ ∈ s.radii h, ∃ θ ∈ Ioo θ₁ θ₂, z = u + (ρ : ℂ) * e θ := by
  cases s
  · constructor
    · rintro ⟨⟨ρ, θ⟩, ⟨hρ, hθ⟩, rfl⟩; exact ⟨ρ, hρ, θ, hθ, rfl⟩
    · rintro ⟨ρ, hρ, θ, hθ, rfl⟩; exact ⟨(ρ, θ), ⟨hρ, hθ⟩, rfl⟩
  · constructor
    · rintro ⟨⟨ρ, θ⟩, ⟨hρ, hθ⟩, rfl⟩; exact ⟨ρ, hρ, θ, hθ, rfl⟩
    · rintro ⟨ρ, hρ, θ, hθ, rfl⟩; exact ⟨(ρ, θ), ⟨hρ, hθ⟩, rfl⟩

/-- A positive lower bound for finitely many positive reals. -/
theorem exists_pos_le_finset {ι : Type*} (t : Finset ι) (f : ι → ℝ) (hf : ∀ i, 0 < f i) :
    ∃ h > 0, ∀ i ∈ t, h ≤ f i := by
  classical
  induction t using Finset.induction_on with
  | empty => exact ⟨1, one_pos, by simp⟩
  | insert a t ha ih =>
    obtain ⟨h, hh, hle⟩ := ih
    refine ⟨min h (f a), lt_min hh (hf a), ?_⟩
    intro i hi
    rcases Finset.mem_insert.mp hi with rfl | hi
    · exact min_le_right _ _
    · exact (min_le_left _ _).trans (hle i hi)

/-- **Collars about every angle of a compact arc give one collar over it**: if `S` carries a collar on the side `s` about every angle of
`[θ₁, θ₂]`, some collar of positive thickness over `(θ₁, θ₂)` lies in `S`. -/
theorem exists_collar_of_collarAt {S : Set ℂ} {u : ℂ} {s : Rim} {θ₁ θ₂ : ℝ} (hS : ∀ θ ∈ Icc θ₁ θ₂, CollarAt S u s θ) :
    ∃ h > 0, collar u s θ₁ θ₂ h ⊆ S := by
  choose hθ hθpos hθsub using fun θ : Icc θ₁ θ₂ => hS θ.1 θ.2
  obtain ⟨t, ht⟩ := isCompact_Icc.elim_finite_subcover (fun θ : Icc θ₁ θ₂ => Ioo (θ.1 - hθ θ) (θ.1 + hθ θ))
    (fun _ => isOpen_Ioo) (fun x hx => mem_iUnion.mpr ⟨⟨x, hx⟩, by
      simp only [mem_Ioo]; constructor <;> linarith [hθpos ⟨x, hx⟩]⟩)
  obtain ⟨h, hh, hle⟩ := exists_pos_le_finset t hθ hθpos
  refine ⟨h, hh, fun z hz => ?_⟩
  obtain ⟨ρ, hρ, θ, hθm, rfl⟩ := (mem_collar_iff u s _ _ _ _).mp hz
  obtain ⟨i, hi, hθi⟩ := mem_iUnion₂.mp (ht (Ioo_subset_Icc_self hθm))
  refine hθsub i ((mem_collar_iff u s _ _ _ _).mpr ⟨ρ, s.radii_mono (hle i hi) hρ, θ, hθi, rfl⟩)

/-- The chord of the circle of radius `ρ` about `u` between the angles `a` and `a + α` (`0 ≤ α ≤ 2π`) has length `2ρ sin (α/2)`. -/
theorem dist_polar_pair (u : ℂ) {ρ : ℝ} (a : ℝ) {α : ℝ} (hρ : 0 ≤ ρ) (hα : 0 ≤ α) (hα2 : α ≤ 2 * π) :
    dist (u + (ρ : ℂ) * e (a + α)) (u + (ρ : ℂ) * e a) = ρ * (2 * Real.sin (α / 2)) := by
  have h1 : u + (ρ : ℂ) * e (a + α) - (u + (ρ : ℂ) * e a) = ((ρ : ℂ) * e a) * (ringPt 0 α - ringPt 0 0) := by
    simp only [ringPt, zero_add, e_add]
    have : e 0 = 1 := by simp [e]
    rw [this]; ring
  rw [dist_eq_norm, h1, ringPt_sub_ringPt, norm_mul, norm_mul, norm_mul, norm_e, norm_e, Complex.norm_real,
    Complex.norm_real, Real.norm_eq_abs, Real.norm_eq_abs, abs_of_nonneg hρ, abs_of_nonneg]
  · simp
  · have := Real.sin_nonneg_of_nonneg_of_le_pi (x := (α - 0) / 2) (by linarith) (by linarith)
    linarith

/-- **A chord angle near `π/3`**: the radius `1 / (2 sin (α/2))` of the circle on which a chord of angle `α` is a unit chord tends to `1` as
`α → π/3`; so for every `h > 0` and bound `L > π/3` there is an angle just above `π/3`, and one just below, whose radius is within `h`
of `1`, on the correct side. -/
theorem exists_chord_angle (s : Rim) {h L : ℝ} (hh : 0 < h) (hL : π / 3 < L) :
    ∃ α : ℝ, 0 < α ∧ α < π ∧ (s = Rim.inner → π / 3 < α ∧ α < L) ∧ (s = Rim.outer → α < π / 3) ∧
      1 / (2 * Real.sin (α / 2)) ∈ s.radii h := by
  have hsin : Real.sin (π / 3 / 2) = 1 / 2 := by
    rw [show π / 3 / 2 = π / 6 by ring, Real.sin_pi_div_six]
  have hg : ContinuousAt (fun α : ℝ => 1 / (2 * Real.sin (α / 2))) (π / 3) := by
    refine ContinuousAt.div continuousAt_const (by fun_prop) ?_
    rw [hsin]; norm_num
  have hg1 : (fun α : ℝ => 1 / (2 * Real.sin (α / 2))) (π / 3) = 1 := by
    simp only [hsin]; norm_num
  have hnear : ∀ᶠ α in 𝓝 (π / 3), |1 / (2 * Real.sin (α / 2)) - 1| < h := by
    have := hg.eventually (Metric.ball_mem_nhds _ hh)
    filter_upwards [this] with α hα
    have h1 : 1 / (2 * Real.sin (π / 3 / 2)) = 1 := by rw [hsin]; norm_num
    rwa [Real.dist_eq, h1] at hα
  have hmono : ∀ α, π / 3 < α → α < π → Real.sin (π / 3 / 2) < Real.sin (α / 2) := by
    intro α h1 h2
    exact Real.sin_lt_sin_of_lt_of_le_pi_div_two (by linarith [Real.pi_pos]) (by linarith) (by linarith)
  have hmono' : ∀ α, 0 < α → α < π / 3 → Real.sin (α / 2) < Real.sin (π / 3 / 2) := by
    intro α h1 h2
    exact Real.sin_lt_sin_of_lt_of_le_pi_div_two (by linarith [Real.pi_pos]) (by linarith) (by linarith)
  cases s
  · have hI : Ioo (π / 3) (min L π) ∈ 𝓝[>] (π / 3) := Ioo_mem_nhdsGT (lt_min hL (by linarith [Real.pi_pos]))
    obtain ⟨α, hα, hαI⟩ := (Filter.Eventually.and (hnear.filter_mono nhdsWithin_le_nhds) hI).exists
    have hlt := hmono α hαI.1 (lt_of_lt_of_le hαI.2 (min_le_right _ _))
    rw [hsin] at hlt
    have hp : 0 < Real.sin (α / 2) := by linarith
    refine ⟨α, by linarith [hαI.1, Real.pi_pos], lt_of_lt_of_le hαI.2 (min_le_right _ _),
      fun _ => ⟨hαI.1, lt_of_lt_of_le hαI.2 (min_le_left _ _)⟩, fun h => absurd h (by simp), ?_⟩
    have habs := abs_lt.mp hα
    show 1 / (2 * Real.sin (α / 2)) ∈ Ioo (1 - h) 1
    refine ⟨by linarith [habs.1], ?_⟩
    rw [div_lt_one (by linarith)]; linarith
  · have hI : Ioo 0 (π / 3) ∈ 𝓝[<] (π / 3) := by
      have := Ioo_mem_nhdsLT (show (0 : ℝ) < π / 3 by linarith [Real.pi_pos]); exact this
    obtain ⟨α, hα, hαI⟩ := (Filter.Eventually.and (hnear.filter_mono nhdsWithin_le_nhds) hI).exists
    have hlt := hmono' α hαI.1 hαI.2
    rw [hsin] at hlt
    have hp : 0 < Real.sin (α / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith [hαI.1]) (by linarith [hαI.2, Real.pi_pos])
    refine ⟨α, hαI.1, by linarith [hαI.2, Real.pi_pos], fun h => absurd h (by simp), fun _ => hαI.2, ?_⟩
    have habs := abs_lt.mp hα
    show 1 / (2 * Real.sin (α / 2)) ∈ Ioo 1 (1 + h)
    refine ⟨?_, by linarith [habs.2]⟩
    rw [lt_div_iff₀ (by linarith)]; linarith

/-- **A unit pair in every thin collar over an arc longer than `π/3`**: on either side of `ω(u)`, a collar of any positive thickness over an
open arc of length `> π/3` holds two points at distance exactly `1` (a chord of `ω(u)`'s concentric circle near radius `1`). -/
theorem exists_unit_pair_collar (u : ℂ) (s : Rim) {θ₁ θ₂ h : ℝ} (hlen : π / 3 < θ₂ - θ₁) (hh : 0 < h) :
    ∃ x ∈ collar u s θ₁ θ₂ h, ∃ y ∈ collar u s θ₁ θ₂ h, dist x y = 1 := by
  obtain ⟨α, hα0, hαπ, hin, hout, hρ⟩ := exists_chord_angle s hh (L := θ₂ - θ₁) hlen
  have hαL : α < θ₂ - θ₁ := by
    cases s
    · exact (hin rfl).2
    · linarith [hout rfl]
  set ρ := 1 / (2 * Real.sin (α / 2)) with hρdef
  have hsinpos : 0 < Real.sin (α / 2) :=
    Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  have hρ0 : 0 ≤ ρ := by positivity
  set a := θ₁ + (θ₂ - θ₁ - α) / 2 with ha
  refine ⟨u + (ρ : ℂ) * e (a + α), (mem_collar_iff u s _ _ _ _).mpr ⟨ρ, hρ, a + α, ⟨by linarith, by linarith⟩, rfl⟩,
    u + (ρ : ℂ) * e a, (mem_collar_iff u s _ _ _ _).mpr ⟨ρ, hρ, a, ⟨by linarith, by linarith⟩, rfl⟩, ?_⟩
  rw [dist_polar_pair u a hρ0 hα0.le (by linarith [Real.pi_pos]), hρdef]
  field_simp

/-! ## Two colours: change points -/

/-- The shadow of an open set is open (translate the witness). -/
theorem isOpen_shadow {U : Set ℂ} (hU : IsOpen U) : IsOpen (shadow U) := by
  rw [isOpen_iff_mem_nhds]
  rintro z ⟨y, hy, hzy⟩
  obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp hU y hy
  refine Filter.mem_of_superset (Metric.ball_mem_nhds z hr) fun z' hz' => ⟨y + (z' - z), hball ?_, ?_⟩
  · rw [Metric.mem_ball, dist_eq_norm, add_sub_cancel_left, ← dist_eq_norm]
    exact hz'
  · rw [dist_eq_norm] at hzy ⊢
    rw [show z' - (y + (z' - z)) = z - y by ring]
    exact hzy

/-- **A dense open class with no unit pair cannot hold a unit pair of points of an open set**: if `W` is open, `W ⊆ closure A`, `A` open
with no unit pair, then no two points of `W` are at distance `1` (the shadow of a small piece of `A` near `x` is an open set near `y`). -/
theorem false_of_dense_unit_pair {A W : Set ℂ} (hA : IsOpen A) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1) (hW : IsOpen W)
    (hWA : W ⊆ closure A) {x y : ℂ} (hx : x ∈ W) (hy : y ∈ W) (hxy : dist x y = 1) : False := by
  obtain ⟨δx, hδx, hbx⟩ := Metric.isOpen_iff.mp hW x hx
  obtain ⟨δy, hδy, hby⟩ := Metric.isOpen_iff.mp hW y hy
  obtain ⟨a, ha, hax⟩ := Metric.mem_closure_iff.mp (hWA hx) δy hδy
  set p := y + (a - x) with hp
  have hpy : p ∈ ball y δy := by
    rw [Metric.mem_ball, hp, dist_eq_norm, add_sub_cancel_left, ← dist_eq_norm, dist_comm]
    exact hax
  have hpa : p ∈ shadow A := ⟨a, ha, by
    rw [dist_eq_norm, hp, show y + (a - x) - a = y - x by ring, ← dist_eq_norm, dist_comm]; exact hxy⟩
  have hN : IsOpen (shadow A ∩ ball y δy) := (isOpen_shadow hA).inter Metric.isOpen_ball
  obtain ⟨ε, hε, hεN⟩ := Metric.isOpen_iff.mp hN p ⟨hpa, hpy⟩
  obtain ⟨a', ha'A, hd⟩ := Metric.mem_closure_iff.mp (hWA (hby hpy)) ε hε
  have ha'N : a' ∈ shadow A ∩ ball y δy := hεN (by rw [Metric.mem_ball, dist_comm]; exact hd)
  obtain ⟨u, hu, hdu⟩ := ha'N.1
  exact hAu a' ha'A u hu hdu

/-- **A two-coloured connected open set holding a unit pair has a change point**: neither class can be dense in it alone (a dense open class
would hold a unit pair, by sweeping unit circles), so by connectedness the closures of the two classes meet inside it. -/
theorem exists_changePt {A B W : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
    (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) (hW : IsOpen W) (hWc : IsPreconnected W) (hWAB : W ⊆ closure (A ∪ B))
    {x y : ℂ} (hx : x ∈ W) (hy : y ∈ W) (hxy : dist x y = 1) : ∃ b ∈ W, b ∈ closure A ∧ b ∈ closure B := by
  have hWc' := isPreconnected_closed_iff.mp hWc (closure A) (closure B) isClosed_closure isClosed_closure
    (by rw [← closure_union]; exact hWAB)
  have hA' : (W ∩ closure A).Nonempty := by
    by_contra hemp
    rw [not_nonempty_iff_eq_empty, ← disjoint_iff_inter_eq_empty] at hemp
    refine false_of_dense_unit_pair hB hBu hW (fun z hz => ?_) hx hy hxy
    rcases (closure_union (s := A) (t := B) ▸ hWAB hz : z ∈ closure A ∪ closure B) with h | h
    · exact absurd h (disjoint_left.mp hemp hz)
    · exact h
  have hB' : (W ∩ closure B).Nonempty := by
    by_contra hemp
    rw [not_nonempty_iff_eq_empty, ← disjoint_iff_inter_eq_empty] at hemp
    refine false_of_dense_unit_pair hA hAu hW (fun z hz => ?_) hx hy hxy
    rcases (closure_union (s := A) (t := B) ▸ hWAB hz : z ∈ closure A ∪ closure B) with h | h
    · exact h
    · exact absurd h (disjoint_left.mp hemp hz)
  obtain ⟨b, hbW, hbA, hbB⟩ := hWc' hA' hB'
  exact ⟨b, hbW, hbA, hbB⟩

/-! ## The landing: the unit circle about a point near `ω(u)` -/

/-- `‖ρ e θ + e (θ + x)‖² = ρ² + 2ρ cos x + 1`. -/
theorem norm_sq_mul_e_add_e (ρ θ x : ℝ) :
    ‖(ρ : ℂ) * e θ + e (θ + x)‖ ^ 2 = ρ ^ 2 + 2 * ρ * Real.cos x + 1 := by
  have h : (ρ : ℂ) * e θ + e (θ + x) = e θ * ((ρ : ℂ) + e x) := by rw [e_add]; ring
  rw [h, norm_mul, norm_e, one_mul, Complex.sq_norm, Complex.normSq_apply, e_eq]
  simp [-Complex.ofReal_cos, -Complex.ofReal_sin]
  nlinarith [Real.sin_sq_add_cos_sq x]

/-- **The landing.** The unit circle about `b = u + ρ e(θ)`, `0 < ρ < 2`, crosses `ω(u)` transversally at the angles `θ ± arccos(ρ/2)`; if a
set carries a collar (either side) about one of them, the circle meets it. -/
theorem sphere_meets_of_collarAt {W : Set ℂ} {u : ℂ} {ρ θ σ : ℝ} (hρ : 0 < ρ) (hρ2 : ρ < 2) (hσ : σ = 1 ∨ σ = -1) {s : Rim}
    (hW : CollarAt W u s (θ + σ * Real.arccos (ρ / 2))) : (sphere (u + (ρ : ℂ) * e θ) 1 ∩ W).Nonempty := by
  obtain ⟨h, hh, hsub⟩ := hW
  set α := Real.arccos (ρ / 2) with hα
  set ψ := θ + σ * α with hψ
  set b := u + (ρ : ℂ) * e θ with hb
  have hcosα : Real.cos α = ρ / 2 := Real.cos_arccos (by linarith) (by linarith)
  have hα0 : 0 < α := Real.arccos_pos.mpr (by linarith)
  have hα2 : α ≤ π / 2 := Real.arccos_le_pi_div_two.mpr (by linarith)
  have hpi := Real.pi_pos
  -- the circle `ω(b)`, parametrized from the point `u + e ψ` by `s`
  let z : ℝ → ℂ := fun t => b + e (θ + σ * (π - α + t))
  have hzc : Continuous z := by have := continuous_e; fun_prop
  have hz0 : z 0 = u + ((1 : ℝ) : ℂ) * e ψ := by
    have hs : (ρ : ℂ) + e (σ * (π - α)) = e (σ * α) := by
      rcases hσ with rfl | rfl
      · rw [one_mul, one_mul, e_eq, e_eq, Real.cos_pi_sub, Real.sin_pi_sub, hcosα]
        push_cast; ring
      · rw [neg_one_mul, neg_one_mul, e_eq, e_eq, Real.cos_neg, Real.sin_neg, Real.cos_neg, Real.sin_neg,
          Real.cos_pi_sub, Real.sin_pi_sub, hcosα]
        push_cast; ring
    have : z 0 = u + e θ * ((ρ : ℂ) + e (σ * (π - α))) := by
      simp only [z, hb, add_zero, e_add]; ring
    rw [this, hs, ← e_add]; simp [hψ]
  have hnorm : ∀ t : ℝ, ‖z t - u‖ ^ 2 = 1 + 2 * ρ * (Real.cos (π - α + t) - Real.cos (π - α)) := by
    intro t
    have : z t - u = (ρ : ℂ) * e θ + e (θ + σ * (π - α + t)) := by simp only [z, hb]; ring
    rw [this, norm_sq_mul_e_add_e]
    have hcs : Real.cos (σ * (π - α + t)) = Real.cos (π - α + t) := by
      rcases hσ with rfl | rfl
      · rw [one_mul]
      · rw [neg_one_mul, Real.cos_neg]
    rw [hcs, Real.cos_pi_sub, hcosα]; ring
  have hsph : ∀ t, z t ∈ sphere b 1 := by
    intro t
    rw [mem_sphere_iff_norm]
    simp [z]
  -- the neighbourhood of `u + e ψ` on which a point lies in the polar window of the collar
  have hN : ∀ᶠ t in 𝓝 (0 : ℝ), |Complex.arg ((z t - u) * starRingEnd ℂ (e ψ))| < h ∧ ‖z t - u‖ ∈ Ioo (1 - h) (1 + h) := by
    have h1 := eventually_abs_arg_lt u ψ one_pos hh
    have h2 := eventually_norm_sub_mem u ψ (isOpen_Ioo (a := 1 - h) (b := 1 + h)) zero_le_one
      (show (1 : ℝ) ∈ Ioo (1 - h) (1 + h) from ⟨by linarith, by linarith⟩)
    have h3 := (hzc.tendsto 0)
    rw [hz0] at h3
    exact (h3.eventually (h1.and h2))
  have hcol : ∀ t, |Complex.arg ((z t - u) * starRingEnd ℂ (e ψ))| < h → ‖z t - u‖ ∈ s.radii h →
      z t ∈ collar u s (ψ - h) (ψ + h) h := by
    intro t ha hr
    rw [abs_lt] at ha
    exact (mem_collar_iff _ _ _ _ _ _).mpr ⟨‖z t - u‖, hr, ψ + Complex.arg ((z t - u) * starRingEnd ℂ (e ψ)),
      ⟨by linarith [ha.1], by linarith [ha.2]⟩, eq_add_norm_mul_e u (z t) ψ⟩
  cases s
  · -- inner: `t ∈ (0, α)` puts `z t` strictly inside `ω(u)`
    have hI : Ioo 0 α ∈ 𝓝[>] (0 : ℝ) := Ioo_mem_nhdsGT hα0
    obtain ⟨t, ⟨hta, htr⟩, ht0, htα⟩ := (Filter.Eventually.and (hN.filter_mono nhdsWithin_le_nhds) hI).exists
    have hcos : Real.cos (π - α + t) < Real.cos (π - α) :=
      Real.strictAntiOn_cos ⟨by linarith, by linarith⟩ ⟨by linarith, by linarith⟩ (by linarith)
    have hlt : ‖z t - u‖ < 1 := by
      have : ‖z t - u‖ ^ 2 < 1 := by rw [hnorm]; nlinarith
      nlinarith [norm_nonneg (z t - u)]
    exact ⟨z t, hsph t, hsub (hcol t hta ⟨htr.1, hlt⟩)⟩
  · have hI : Ioo (-(π - α)) 0 ∈ 𝓝[<] (0 : ℝ) := Ioo_mem_nhdsLT (by linarith)
    obtain ⟨t, ⟨hta, htr⟩, ht0, htα⟩ := (Filter.Eventually.and (hN.filter_mono nhdsWithin_le_nhds) hI).exists
    have hcos : Real.cos (π - α) < Real.cos (π - α + t) :=
      Real.strictAntiOn_cos ⟨by linarith, by linarith⟩ ⟨by linarith, by linarith⟩ (by linarith)
    have hgt : 1 < ‖z t - u‖ := by
      have : 1 < ‖z t - u‖ ^ 2 := by rw [hnorm]; nlinarith
      nlinarith [norm_nonneg (z t - u)]
    exact ⟨z t, hsph t, hsub (hcol t hta ⟨hgt, htr.2⟩)⟩

/-! ## FS106-WO: Woodall's step-4 lemma, strict, and its sharpness -/

/-- **FS106-WO, the step-4 lemma** (`[Woodall1973]` p. 198, as repaired: length **strictly** above `2π/3`): if, on one side `s` of `ω(u)`,
every angle of an open arc of length `> 2π/3` carries a collar inside `closure (A ∪ B)` — `A`, `B` open with no unit pair in either — then
`False`. (A collar about each angle is Woodall's "unit arc of positive thickness" with its thickness `f(θ)` locally bounded away from the
circle.) -/
theorem woodall_step4 {A B : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
    (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) {u : ℂ} (s : Rim) {θ₁ θ₂ : ℝ} (hlen : 2 * π / 3 < θ₂ - θ₁)
    (hW : ∀ θ ∈ Ioo θ₁ θ₂, CollarAt (closure (A ∪ B)) u s θ) : False := by
  sorry

/-- **The step-4 lemma is false at length `2π/3`** — Townsend's counterexample (`[Townsend1979ms]` p. 2; `[Townsend1981]` p. 114): the inner
collar of `ω(0)` over `(0, 2π/3)`, cut by the arc of `ω(1)` through `e(π/3)` into `A` (inside `B(1, 1)`) and `B` (outside `B̄(1, 1)`), has no unit
pair in either part. The strictness in `woodall_step4` cannot be dropped; this is the assertion `[Woodall1973]` step 4 ("The lower bound `⅔π` is
critical here") made and Townsend refuted. -/
theorem not_woodall_step4_two_thirds :
    ¬ ∀ (A B : Set ℂ) (u : ℂ) (s : Rim) (θ₁ θ₂ : ℝ), IsOpen A → IsOpen B → (∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1) →
      (∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) → 2 * π / 3 ≤ θ₂ - θ₁ →
      (∀ θ ∈ Ioo θ₁ θ₂, CollarAt (closure (A ∪ B)) u s θ) → False := by
  sorry

/-! ## FS106-TW: Townsend's `π/3` lemma -/

/-- **FS106-TW, Townsend's `π/3` lemma** (`[Townsend1979ms]` Thm 1, = `[Townsend1981]`'s lemma, in the form its proof reads): `A`, `B` open with
no unit pair in either; every angle off a finite set `K` of cut angles (and their `2π`-translates) carries a collar, on one side or the other of
`ω(u)`, inside `closure (A ∪ B)`; and one side carries collars about every angle of a closed arc of length `> π/3` (the seed: Townsend's "segment
of length greater than ⅓π containing no cut points"). Then `False`. -/
theorem townsend_lemma {A B : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
    (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) {u : ℂ} {K : Set ℝ} (hK : K.Finite)
    (hcollar : ∀ θ : ℝ, (∀ κ ∈ K, ∀ m : ℤ, θ ≠ κ + 2 * π * m) → ∃ s, CollarAt (closure (A ∪ B)) u s θ)
    (hseed : ∃ (s : Rim) (θ₁ θ₂ : ℝ), π / 3 < θ₂ - θ₁ ∧ ∀ θ ∈ Icc θ₁ θ₂, CollarAt (closure (A ∪ B)) u s θ) : False := by
  sorry

/-! ## The excluded set: cones decide the collars -/

/-- **Outer collars from a cone direction**: a preconnected `R` with `u ∈ closure R` approaching `u` along `β` meets the unit circle about
every point of some outer collar about `ψ` whenever `cos (β − ψ) > 0` (such a point `z` has `u` outside `B̄(z, 1)` and points of `R` inside). -/
theorem collarAt_shadow_outer {R : Set ℂ} (hRc : IsPreconnected R) {u : ℂ} {β ψ : ℝ} (hβ : β ∈ coneAt R u)
    (hcos : 0 < Real.cos (β - ψ)) : CollarAt (shadow R) u .outer ψ := by
  sorry

/-- **Inner collars from a cone direction**: the same for inner collars when `cos (β − ψ) < 0` (such a point `z` has `u` inside `B(z, 1)` and
points of `R` outside). -/
theorem collarAt_shadow_inner {R : Set ℂ} (hRc : IsPreconnected R) {u : ℂ} {β ψ : ℝ} (hβ : β ∈ coneAt R u)
    (hcos : Real.cos (β - ψ) < 0) : CollarAt (shadow R) u .inner ψ := by
  sorry

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The excluded set carries no colour of `T`**: an interior point of a valid map whose unit circle meets the class of every colour of `T`
does not carry a colour of `T`. -/
theorem col_not_mem_of_mem_shadow (hF : F.Valid) {T : Finset (Fin k)} {z : ℂ} (hz : z ∈ F.interiorPts)
    (hzT : ∀ c ∈ T, z ∈ shadow (F.region c)) : F.col z ∉ T := by
  sorry

/-- **An open subset of the excluded set is coloured by the other colours**: in a valid map of the plane, an open set whose points' unit
circles meet every class of `T` lies in the closure of the union of the classes of the colours outside `T`. -/
theorem subset_closure_of_subset_shadow (hF : F.Valid) (hP : F.IsPlaneMap) {T : Finset (Fin k)} {W : Set ℂ} (hW : IsOpen W)
    (hWT : ∀ c ∈ T, W ⊆ shadow (F.region c)) : W ⊆ closure (⋃ c ∈ (Tᶜ : Finset (Fin k)), F.region c) := by
  sorry

end ArcMap

end HadwigerNelson.Plane
