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

-- `e_mul_conj_e` is `Plane/Chord`'s (landed with wave 3; this branch's identical copy deleted at the merge, inventory item 142).


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

/-! ## Dot products and the cone bound (the geometry of the shadow lemmas and of Townsend's example) -/

/-- `dot` in coordinates. -/
theorem dot_eq (a b : ℂ) : dot a b = a.re * b.re + a.im * b.im := by
  simp [dot, Complex.mul_re]

theorem abs_dot_le (a b : ℂ) : |dot a b| ≤ ‖a‖ * ‖b‖ := by
  have : dot a b = (a * starRingEnd ℂ b).re := rfl
  rw [this, ← norm_conj b, ← norm_mul]
  exact Complex.abs_re_le_norm _

theorem dot_add_left (a b c : ℂ) : dot (a + b) c = dot a c + dot b c := by
  simp [dot_eq]; ring

theorem dot_sub_left (a b c : ℂ) : dot (a - b) c = dot a c - dot b c := by
  simp [dot_eq]; ring

theorem dot_sub_right (a b c : ℂ) : dot a (b - c) = dot a b - dot a c := by
  simp [dot_eq]; ring

theorem dot_real_mul_left (r : ℝ) (a b : ℂ) : dot ((r : ℂ) * a) b = r * dot a b := by
  simp [dot_eq]; ring

theorem dot_e_e (a b : ℝ) : dot (e a) (e b) = Real.cos (a - b) := by
  rw [dot_eq, e_eq, e_eq, Real.cos_sub]; simp [-Complex.ofReal_cos, -Complex.ofReal_sin]

theorem norm_sub_real_mul_e_sq (q : ℂ) (ρ ψ : ℝ) : ‖q - (ρ : ℂ) * e ψ‖ ^ 2 = ‖q‖ ^ 2 + ρ ^ 2 - 2 * ρ * dot q (e ψ) := by
  rw [dot_eq, e_eq]
  simp only [Complex.sq_norm, Complex.normSq_apply, Complex.sub_re, Complex.sub_im, Complex.mul_re, Complex.mul_im,
    Complex.add_re, Complex.add_im, Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
  simp
  nlinarith [Real.sin_sq_add_cos_sq ψ]

/-- A preconnected set with a point inside and a point outside the unit circle about `z` meets it. -/
theorem mem_shadow_of_preconnected {R : Set ℂ} (hR : IsPreconnected R) {z a b : ℂ} (ha : a ∈ R) (hb : b ∈ R)
    (hza : dist z a < 1) (hzb : 1 < dist z b) : z ∈ shadow R := by
  have himg : IsPreconnected ((fun y => dist z y) '' R) := hR.image _ (continuous_const.dist continuous_id).continuousOn
  obtain ⟨y, hy, hy1⟩ := himg.Icc_subset ⟨a, ha, rfl⟩ ⟨b, hb, rfl⟩ ⟨hza.le, hzb.le⟩
  exact ⟨y, hy, hy1⟩


/-- **The cone bound**: if `q` is a vector, `r₀ > 0` and `q / r₀` is within `ε` of `e β`, then `dot q (e ψ') / r₀` is within `ε + |ψ' − ψ|` of
`cos (β − ψ)`. -/
theorem dot_cone_bound {q : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀) {β ψ ψ' ε : ℝ}
    (hd : ‖q / (r₀ : ℂ) - e β‖ < ε) :
    |dot q (e ψ') / r₀ - Real.cos (β - ψ)| ≤ ε + |ψ' - ψ| := by
  set d := q / (r₀ : ℂ) with hdd
  have hqd : q = (r₀ : ℂ) * d := by rw [hdd, mul_div_cancel₀]; exact_mod_cast hr₀.ne'
  have h1 : dot q (e ψ') / r₀ = dot d (e ψ') := by
    rw [hqd, dot_real_mul_left]; field_simp
  have h2 : dot d (e ψ') = dot (d - e β) (e ψ') + (Real.cos (β - ψ) + dot (e β) (e ψ' - e ψ)) := by
    rw [dot_sub_left, dot_sub_right, dot_e_e, dot_e_e]; ring
  have h3 : |dot (d - e β) (e ψ')| ≤ ε := by
    refine (abs_dot_le _ _).trans ?_
    rw [norm_e, mul_one]; exact hd.le
  have h4 : |dot (e β) (e ψ' - e ψ)| ≤ |ψ' - ψ| := by
    refine (abs_dot_le _ _).trans ?_
    rw [norm_e, one_mul]; exact norm_e_sub_e_le _ _
  rw [h1, h2]
  calc |dot (d - e β) (e ψ') + (Real.cos (β - ψ) + dot (e β) (e ψ' - e ψ)) - Real.cos (β - ψ)|
      = |dot (d - e β) (e ψ') + dot (e β) (e ψ' - e ψ)| := by ring_nf
    _ ≤ |dot (d - e β) (e ψ')| + |dot (e β) (e ψ' - e ψ)| := abs_add_le _ _
    _ ≤ ε + |ψ' - ψ| := add_le_add h3 h4



/-! ## The engines: Engine A (the contradiction), Engine B (change points in every band), Engine C (the closed-arc form) -/

/-- A collar of thickness at most `1` is preconnected. -/
theorem isPreconnected_collar (u : ℂ) (s : Rim) (θ₁ θ₂ h : ℝ) : IsPreconnected (collar u s θ₁ θ₂ h) := by
  cases s <;> exact isPreconnected_annSector u _ _ _ _

/-- Carrying a collar about an angle is an open condition on the angle. -/
theorem eventually_collarAt {S : Set ℂ} {u : ℂ} {s : Rim} {y : ℝ} (hy : CollarAt S u s y) :
    ∀ᶠ y' in 𝓝 y, CollarAt S u s y' := by
  obtain ⟨h, hh, hsub⟩ := hy
  filter_upwards [Ioo_mem_nhds (show y - h / 2 < y by linarith) (show y < y + h / 2 by linarith)] with y' hy'
  exact ⟨h / 2, by linarith, (collar_subset_collar u s (by linarith [hy'.1]) (by linarith [hy'.2]) (by linarith)).trans hsub⟩

/-- A set carrying a collar about an angle carries it in its interior. -/
theorem CollarAt.interior {S : Set ℂ} {u : ℂ} {s : Rim} {y : ℝ} (hy : CollarAt S u s y) : CollarAt (interior S) u s y := by
  obtain ⟨h, hh, hsub⟩ := hy
  refine ⟨min h 1, lt_min hh one_pos, interior_maximal ?_ (isOpen_collar u s _ _ (min_le_right _ _))⟩
  exact (collar_subset_collar u s (by linarith [min_le_left h 1]) (by linarith [min_le_left h 1]) (min_le_left _ _)).trans hsub

/-- **Engine A, the contradiction**: a change point `b` of a two-coloured open set `W`, whose unit circle lands (at an angle
`θ ± arccos (ρ/2)` of `ω(u)`) on a collar inside `W`, is impossible — lemma (L) keeps the unit circle about `b` out of `W`. -/
theorem false_of_changePt_landing {A B W : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
    (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) (hW : IsOpen W) (hWAB : W ⊆ closure (A ∪ B)) {u : ℂ} {ρ θ σ : ℝ} (hρ : 0 < ρ)
    (hρ2 : ρ < 2) (hσ : σ = 1 ∨ σ = -1) (hbW : u + (ρ : ℂ) * e θ ∈ W) (hbA : u + (ρ : ℂ) * e θ ∈ closure A)
    (hbB : u + (ρ : ℂ) * e θ ∈ closure B) {s : Rim} (hland : CollarAt W u s (θ + σ * Real.arccos (ρ / 2))) : False := by
  obtain ⟨z, hz1, hz2⟩ := sphere_meets_of_collarAt hρ hρ2 hσ hland
  exact (lemmaL hA hB hW hWAB hAu hBu hbW hbA hbB).le_bot ⟨hz1, hz2⟩

/-- **Engine B, change points in every band**: a thin collar over an open arc longer than `π/3`, inside `closure (A ∪ B)`, holds a change
point (both classes in its closure) — a unit pair (`exists_unit_pair_collar`) in a connected open two-coloured set. -/
theorem exists_changePt_band {A B : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
    (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) {u : ℂ} {s : Rim} {θ₁ θ₂ h : ℝ} (hlen : π / 3 < θ₂ - θ₁) (hh : 0 < h) (hh1 : h ≤ 1)
    (hC : collar u s θ₁ θ₂ h ⊆ closure (A ∪ B)) :
    ∃ ρ θ : ℝ, θ ∈ Ioo θ₁ θ₂ ∧ ρ ∈ s.radii h ∧ u + (ρ : ℂ) * e θ ∈ closure A ∧ u + (ρ : ℂ) * e θ ∈ closure B := by
  obtain ⟨x, hx, y, hy, hxy⟩ := exists_unit_pair_collar u s hlen hh
  obtain ⟨b, hb, hbA, hbB⟩ := exists_changePt hA hB hAu hBu (isOpen_collar u s θ₁ θ₂ hh1) (isPreconnected_collar u s _ _ _) hC hx hy hxy
  obtain ⟨ρ, hρ, θ, hθ, rfl⟩ := (mem_collar_iff u s _ _ _ _).mp hb
  exact ⟨ρ, θ, hθ, hρ, hbA, hbB⟩

/-- **Engine C, the closed-arc form** (strengthening of `woodall_step4`): collars on some side about every angle of a closed arc of length
`≥ 2π/3`, and one side carrying them over a closed sub-arc longer than `π/3`, cannot be two-coloured. A change point in a thin band of
the seed's collar has landings `θ ± arccos (ρ/2)` within a small `η` of `π/3` from `θ`, and one of them lands within `η` of the arc. -/
theorem false_of_collars_closed {A B : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
    (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) {u : ℂ} {θ₁ θ₂ : ℝ} (hlen : 2 * π / 3 ≤ θ₂ - θ₁)
    (hcov : ∀ θ ∈ Icc θ₁ θ₂, ∃ s, CollarAt (closure (A ∪ B)) u s θ)
    (hseed : ∃ (s : Rim) (φ₁ φ₂ : ℝ), θ₁ ≤ φ₁ ∧ φ₂ ≤ θ₂ ∧ π / 3 < φ₂ - φ₁ ∧ ∀ φ ∈ Icc φ₁ φ₂, CollarAt (closure (A ∪ B)) u s φ) :
    False := by
  obtain ⟨s, φ₁, φ₂, h1, h2, hφ, hseedc⟩ := hseed
  -- the angles carrying a collar form an open set holding `[θ₁, θ₂]`: a thickening of it
  have hGopen : IsOpen {y : ℝ | ∃ s, CollarAt (closure (A ∪ B)) u s y} := by
    rw [isOpen_iff_mem_nhds]
    rintro y ⟨s', hy⟩
    exact (eventually_collarAt hy).mono fun y' hy' => ⟨s', hy'⟩
  obtain ⟨η, hη, hthick⟩ := isCompact_Icc.exists_thickening_subset_open hGopen (fun θ hθ => hcov θ hθ)
  -- a band of radii near `1` whose landing angle is within `η` of `π/3`
  have hcont : ContinuousAt (fun ρ : ℝ => Real.arccos (ρ / 2)) 1 := (Real.continuous_arccos.comp (by fun_prop)).continuousAt
  have hacos : Real.arccos ((1 : ℝ) / 2) = π / 3 := by
    rw [← Real.cos_pi_div_three, Real.arccos_cos (by linarith [Real.pi_pos]) (by linarith [Real.pi_pos])]
  obtain ⟨t₀, ht₀, hband⟩ : ∃ t₀ > 0, ∀ ρ : ℝ, |ρ - 1| < t₀ → |Real.arccos (ρ / 2) - π / 3| < η := by
    have := Metric.continuousAt_iff.mp hcont η hη
    obtain ⟨δ, hδ, hd⟩ := this
    exact ⟨δ, hδ, fun ρ hρ => by
      have := hd (x := ρ) (by rw [Real.dist_eq]; exact hρ)
      rwa [Real.dist_eq, hacos] at this⟩
  obtain ⟨h₀, hh₀, hsub₀⟩ := exists_collar_of_collarAt (hseedc)
  set t := min (min t₀ h₀) (1 / 2) with ht
  have ht0 : 0 < t := lt_min (lt_min ht₀ hh₀) (by norm_num)
  have ht1 : t ≤ 1 / 2 := min_le_right _ _
  have htt₀ : t ≤ t₀ := (min_le_left _ _).trans (min_le_left _ _)
  have hth₀ : t ≤ h₀ := (min_le_left _ _).trans (min_le_right _ _)
  obtain ⟨ρ, θ, hθ, hρ, hbA, hbB⟩ := exists_changePt_band hA hB hAu hBu (u := u) (s := s) hφ ht0 (by linarith)
    ((collar_subset_collar u s le_rfl le_rfl hth₀).trans hsub₀)
  have hρ1 : |ρ - 1| < t := by
    cases s
    · have : ρ ∈ Ioo (1 - t) 1 := hρ
      rw [abs_lt]; constructor <;> linarith [this.1, this.2]
    · have : ρ ∈ Ioo 1 (1 + t) := hρ
      rw [abs_lt]; constructor <;> linarith [this.1, this.2]
  have hρpos : 0 < ρ := by have := abs_lt.mp hρ1; linarith [this.1]
  have hρ2 : ρ < 2 := by have := abs_lt.mp hρ1; linarith [this.2]
  set α := Real.arccos (ρ / 2) with hα
  have hαη : -η < α - π / 3 ∧ α - π / 3 < η := abs_lt.mp (hband ρ (lt_of_lt_of_le hρ1 htt₀))
  have hα0 : 0 < α := Real.arccos_pos.mpr (by linarith)
  -- the interior of the closure is the open two-coloured set
  have hbmem : u + (ρ : ℂ) * e θ ∈ interior (closure (A ∪ B)) := by
    have hcol : u + (ρ : ℂ) * e θ ∈ collar u s φ₁ φ₂ t := (mem_collar_iff u s _ _ _ _).mpr ⟨ρ, hρ, θ, hθ, rfl⟩
    exact interior_maximal ((collar_subset_collar u s le_rfl le_rfl hth₀).trans hsub₀) (isOpen_collar u s _ _ (by linarith)) hcol
  have hθm : θ₁ < θ ∧ θ < θ₂ := ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
  by_cases hcase : θ ≤ θ₂ - π / 3
  · have hy : θ + 1 * α ∈ thickening η (Icc θ₁ θ₂) := by
      rw [Metric.mem_thickening_iff]
      by_cases hin : θ + 1 * α ≤ θ₂
      · exact ⟨θ + 1 * α, ⟨by linarith, hin⟩, by simpa using hη⟩
      · refine ⟨θ₂, ⟨by linarith, le_rfl⟩, ?_⟩
        rw [Real.dist_eq, abs_lt]; constructor <;> linarith
    obtain ⟨s', hs'⟩ := hthick hy
    exact false_of_changePt_landing hA hB hAu hBu isOpen_interior interior_subset hρpos hρ2 (Or.inl rfl) hbmem
      (by simpa using hbA) (by simpa using hbB) (hs'.interior)
  · have hy : θ + (-1) * α ∈ thickening η (Icc θ₁ θ₂) := by
      rw [Metric.mem_thickening_iff]
      by_cases hin : θ₁ ≤ θ + (-1) * α
      · exact ⟨θ + (-1) * α, ⟨hin, by linarith⟩, by simpa using hη⟩
      · refine ⟨θ₁, ⟨le_rfl, by linarith⟩, ?_⟩
        rw [Real.dist_eq, abs_lt]; constructor <;> linarith
    obtain ⟨s', hs'⟩ := hthick hy
    exact false_of_changePt_landing hA hB hAu hBu isOpen_interior interior_subset hρpos hρ2 (Or.inr rfl) hbmem
      (by simpa using hbA) (by simpa using hbB) (hs'.interior)

/-! ## FS106-WO: Woodall's step-4 lemma, strict, and its sharpness -/

/-- **Engine D, the bad radii are finite**: the radii `ρ ∈ (0, 2)` for which twice the landing angle `arccos (ρ/2)` is a difference of two cut
angles mod `2π` are finitely many (`2 arccos (ρ/2) ∈ (0, 2π)` meets each class mod `2π` once, and `arccos` is injective). -/
theorem finite_bad_radii {K : Set ℝ} (hK : K.Finite) :
    {ρ : ℝ | 0 < ρ ∧ ρ < 2 ∧ ∃ κ ∈ K, ∃ κ' ∈ K, ∃ m : ℤ, 2 * Real.arccos (ρ / 2) = κ - κ' + 2 * π * m}.Finite := by
  have hV : {v : ℝ | 0 < v ∧ v < 2 * π ∧ ∃ κ ∈ K, ∃ κ' ∈ K, ∃ m : ℤ, v = κ - κ' + 2 * π * m}.Finite := by
    have hsub : {v : ℝ | 0 < v ∧ v < 2 * π ∧ ∃ κ ∈ K, ∃ κ' ∈ K, ∃ m : ℤ, v = κ - κ' + 2 * π * m} ⊆
        ⋃ p ∈ K ×ˢ K, {v : ℝ | 0 < v ∧ v < 2 * π ∧ ∃ m : ℤ, v = p.1 - p.2 + 2 * π * m} := by
      rintro v ⟨h0, h1, κ, hκ, κ', hκ', m, hm⟩
      exact mem_iUnion₂.mpr ⟨(κ, κ'), ⟨hκ, hκ'⟩, h0, h1, m, hm⟩
    refine ((hK.prod hK).biUnion fun p _ => ?_).subset hsub
    refine Set.Subsingleton.finite ?_
    rintro v ⟨hv0, hv1, m, hm⟩ v' ⟨hv0', hv1', m', hm'⟩
    have hd : (m : ℝ) - m' < 1 ∧ -1 < (m : ℝ) - m' := by
      have hp := Real.pi_pos
      constructor <;> nlinarith
    have h1 : m - m' < 1 := by exact_mod_cast hd.1
    have h2 : -1 < m - m' := by exact_mod_cast hd.2
    have : m = m' := by omega
    rw [hm, hm', this]
  refine Set.Finite.of_finite_image (f := fun ρ : ℝ => 2 * Real.arccos (ρ / 2)) (hV.subset ?_) ?_
  · rintro _ ⟨ρ, ⟨h0, h2, κ, hκ, κ', hκ', m, hm⟩, rfl⟩
    refine ⟨?_, ?_, κ, hκ, κ', hκ', m, hm⟩
    · have := Real.arccos_pos.mpr (show ρ / 2 < 1 by linarith); linarith
    · have := Real.arccos_lt_pi.mpr (show -1 < ρ / 2 by linarith); linarith
  · intro ρ hρ ρ' hρ' h
    have h2 : Real.arccos (ρ / 2) = Real.arccos (ρ' / 2) := by simpa using h
    have := Real.arccos_injOn ⟨by linarith [hρ.1], by linarith [hρ.2.1]⟩ ⟨by linarith [hρ'.1], by linarith [hρ'.2.1]⟩ h2
    linarith

/-- **FS106-WO, the step-4 lemma** (`[Woodall1973]` p. 198, as repaired: length **strictly** above `2π/3`): if, on one side `s` of `ω(u)`,
every angle of an open arc of length `> 2π/3` carries a collar inside `closure (A ∪ B)` — `A`, `B` open with no unit pair in either — then
`False`. (A collar about each angle is Woodall's "unit arc of positive thickness" with its thickness `f(θ)` locally bounded away from the
circle.) -/
theorem woodall_step4 {A B : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
    (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) {u : ℂ} (s : Rim) {θ₁ θ₂ : ℝ} (hlen : 2 * π / 3 < θ₂ - θ₁)
    (hW : ∀ θ ∈ Ioo θ₁ θ₂, CollarAt (closure (A ∪ B)) u s θ) : False := by
  set ε := (θ₂ - θ₁ - 2 * π / 3) / 2 with hε
  have hε0 : 0 < ε := by rw [hε]; linarith
  have hsub : Icc (θ₁ + ε) (θ₂ - ε) ⊆ Ioo θ₁ θ₂ := fun x hx => ⟨by linarith [hx.1], by linarith [hx.2]⟩
  refine false_of_collars_closed hA hB hAu hBu (θ₁ := θ₁ + ε) (θ₂ := θ₂ - ε) (by rw [hε]; linarith)
    (fun θ hθ => ⟨s, hW θ (hsub hθ)⟩) ⟨s, θ₁ + ε, θ₂ - ε, le_rfl, le_rfl, by rw [hε]; linarith [Real.pi_pos],
      fun φ hφ => hW φ (hsub hφ)⟩

/-- Squared distance from `ρ e θ` to `1`. -/
theorem dist_sq_polar_one (ρ θ : ℝ) : dist ((ρ : ℂ) * e θ) 1 ^ 2 = 1 + ρ ^ 2 - 2 * ρ * Real.cos θ := by
  have h := norm_sub_real_mul_e_sq 1 ρ θ
  have h1 : dot 1 (e θ) = Real.cos θ := by
    have : (1 : ℂ) = e 0 := by simp [e]
    rw [this, dot_e_e, zero_sub, Real.cos_neg]
  rw [h1, norm_one] at h
  rw [dist_eq_norm, ← norm_neg, neg_sub, h]; ring

/-- Squared distance between two points of `0`-centred polar form. -/
theorem dist_sq_polar_polar (ρ₁ θ₁ ρ₂ θ₂ : ℝ) :
    dist ((ρ₁ : ℂ) * e θ₁) ((ρ₂ : ℂ) * e θ₂) ^ 2 = ρ₁ ^ 2 + ρ₂ ^ 2 - 2 * ρ₁ * ρ₂ * Real.cos (θ₁ - θ₂) := by
  have h := norm_sub_real_mul_e_sq ((ρ₁ : ℂ) * e θ₁) ρ₂ θ₂
  rw [dot_real_mul_left, dot_e_e, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, sq_abs] at h
  rw [dist_eq_norm, h]; ring

/-- **The step-4 lemma is false at length `2π/3`** — Townsend's counterexample (`[Townsend1979ms]` p. 2; `[Townsend1981]` p. 114): the inner
collar of `ω(0)` over `(0, 2π/3)`, cut by the arc of `ω(1)` through `e(π/3)` into `A` (inside `B(1, 1)`) and `B` (outside `B̄(1, 1)`), has no unit
pair in either part. The strictness in `woodall_step4` cannot be dropped; this is the assertion `[Woodall1973]` step 4 ("The lower bound `⅔π` is
critical here") made and Townsend refuted. -/
theorem not_woodall_step4_two_thirds :
    ¬ ∀ (A B : Set ℂ) (u : ℂ) (s : Rim) (θ₁ θ₂ : ℝ), IsOpen A → IsOpen B → (∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1) →
      (∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) → 2 * π / 3 ≤ θ₂ - θ₁ →
      (∀ θ ∈ Ioo θ₁ θ₂, CollarAt (closure (A ∪ B)) u s θ) → False := by
  intro H
  have hpi := Real.pi_pos
  set R₀ : Set ℂ := collar 0 Rim.inner 0 (2 * π / 3) (1 / 100) with hR₀
  have hR₀o : IsOpen R₀ := isOpen_collar 0 _ _ _ (by norm_num)
  have hmemR : ∀ z, z ∈ R₀ ↔ ∃ ρ ∈ Ioo (99 / 100 : ℝ) 1, ∃ θ ∈ Ioo (0 : ℝ) (2 * π / 3), z = (ρ : ℂ) * e θ := by
    intro z
    rw [hR₀, mem_collar_iff]
    constructor
    · rintro ⟨ρ, hρ, θ, hθ, rfl⟩
      exact ⟨ρ, ⟨by have : ρ ∈ Ioo (1 - 1 / 100) 1 := hρ; linarith [this.1], by have : ρ ∈ Ioo (1 - 1 / 100) 1 := hρ; exact this.2⟩, θ, hθ, by simp⟩
    · rintro ⟨ρ, hρ, θ, hθ, rfl⟩
      exact ⟨ρ, ⟨by linarith [hρ.1], hρ.2⟩, θ, hθ, by simp⟩
  set A : Set ℂ := R₀ ∩ ball 1 1 with hA
  set B : Set ℂ := R₀ \ closedBall 1 1 with hB
  have hAo : IsOpen A := hR₀o.inter isOpen_ball
  have hBo : IsOpen B := hR₀o.inter isClosed_closedBall.isOpen_compl
  -- the polar description of the two classes
  have hAd : ∀ ρ θ : ℝ, ρ ∈ Ioo (99 / 100 : ℝ) 1 → θ ∈ Ioo (0 : ℝ) (2 * π / 3) → ((ρ : ℂ) * e θ ∈ A ↔ ρ < 2 * Real.cos θ) := by
    intro ρ θ hρ hθ
    have hmem : (ρ : ℂ) * e θ ∈ R₀ := (hmemR _).mpr ⟨ρ, hρ, θ, hθ, rfl⟩
    have hsq := dist_sq_polar_one ρ θ
    rw [hA, mem_inter_iff, mem_ball]
    constructor
    · rintro ⟨-, h⟩
      have : dist ((ρ : ℂ) * e θ) 1 ^ 2 < 1 := by nlinarith [dist_nonneg (x := (ρ : ℂ) * e θ) (y := 1)]
      nlinarith [hρ.1]
    · intro h
      refine ⟨hmem, ?_⟩
      have : dist ((ρ : ℂ) * e θ) 1 ^ 2 < 1 := by nlinarith [hρ.1]
      nlinarith [dist_nonneg (x := (ρ : ℂ) * e θ) (y := 1)]
  have hBd : ∀ ρ θ : ℝ, ρ ∈ Ioo (99 / 100 : ℝ) 1 → θ ∈ Ioo (0 : ℝ) (2 * π / 3) → ((ρ : ℂ) * e θ ∈ B ↔ 2 * Real.cos θ < ρ) := by
    intro ρ θ hρ hθ
    have hmem : (ρ : ℂ) * e θ ∈ R₀ := (hmemR _).mpr ⟨ρ, hρ, θ, hθ, rfl⟩
    have hsq := dist_sq_polar_one ρ θ
    rw [hB, Set.mem_sdiff, mem_closedBall, not_le]
    constructor
    · rintro ⟨-, h⟩
      have : 1 < dist ((ρ : ℂ) * e θ) 1 ^ 2 := by nlinarith [dist_nonneg (x := (ρ : ℂ) * e θ) (y := 1)]
      nlinarith [hρ.1]
    · intro h
      refine ⟨hmem, ?_⟩
      have : 1 < dist ((ρ : ℂ) * e θ) 1 ^ 2 := by nlinarith [hρ.1]
      nlinarith [dist_nonneg (x := (ρ : ℂ) * e θ) (y := 1)]
  -- no unit pair in `B`
  have hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1 := by
    intro x hx y hy hxy
    obtain ⟨ρ₁, hρ₁, θ₁, hθ₁, rfl⟩ := (hmemR _).mp hx.1
    obtain ⟨ρ₂, hρ₂, θ₂, hθ₂, rfl⟩ := (hmemR _).mp hy.1
    have h1 := (hBd _ _ hρ₁ hθ₁).mp hx
    have h2 := (hBd _ _ hρ₂ hθ₂).mp hy
    -- `cos θ < 1/2`, so `θ > π/3`
    have hθ1 : π / 3 < θ₁ := by
      by_contra hle; push Not at hle
      have := Real.cos_le_cos_of_nonneg_of_le_pi hθ₁.1.le (by linarith) hle
      rw [Real.cos_pi_div_three] at this; linarith [hρ₁.2]
    have hθ2 : π / 3 < θ₂ := by
      by_contra hle; push Not at hle
      have := Real.cos_le_cos_of_nonneg_of_le_pi hθ₂.1.le (by linarith) hle
      rw [Real.cos_pi_div_three] at this; linarith [hρ₂.2]
    have hsq := dist_sq_polar_polar ρ₁ θ₁ ρ₂ θ₂
    have hcos : 1 / 2 < Real.cos (θ₁ - θ₂) := by
      rw [← Real.cos_pi_div_three]
      rw [← Real.cos_abs (θ₁ - θ₂)]
      refine Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) ?_
      rw [abs_lt]; constructor <;> linarith [hθ₁.2, hθ₂.2]
    rw [hxy] at hsq
    nlinarith [hρ₁.1, hρ₁.2, hρ₂.1, hρ₂.2, mul_pos (show (0 : ℝ) < ρ₁ by linarith [hρ₁.1]) (show (0 : ℝ) < ρ₂ by linarith [hρ₂.1])]
  -- no unit pair in `A`
  have hAkey : ∀ ρ₁ θ₁ ρ₂ θ₂ : ℝ, ρ₁ ∈ Ioo (99 / 100 : ℝ) 1 → ρ₂ ∈ Ioo (99 / 100 : ℝ) 1 → θ₁ ∈ Ioo (0 : ℝ) (2 * π / 3) →
      θ₂ ∈ Ioo (0 : ℝ) (2 * π / 3) → θ₁ ≤ θ₂ → ρ₂ < 2 * Real.cos θ₂ →
      dist ((ρ₁ : ℂ) * e θ₁) ((ρ₂ : ℂ) * e θ₂) ≠ 1 := by
    intro ρ₁ θ₁ ρ₂ θ₂ hρ₁ hρ₂ hθ₁ hθ₂ hle hρ hxy
    have hsq := dist_sq_polar_polar ρ₁ θ₁ ρ₂ θ₂
    rw [hxy] at hsq
    have hcos : Real.cos θ₂ ≤ Real.cos (θ₁ - θ₂) := by
      rw [← Real.cos_abs (θ₁ - θ₂), abs_of_nonpos (by linarith)]
      exact Real.cos_le_cos_of_nonneg_of_le_pi (by linarith) (by linarith [hθ₂.2]) (by linarith [hθ₁.1])
    have h0 : 0 < ρ₁ * ρ₂ := mul_pos (by linarith [hρ₁.1]) (by linarith [hρ₂.1])
    have e1 : ρ₁ * ρ₂ * ρ₂ < ρ₁ * ρ₂ * (2 * Real.cos θ₂) := mul_lt_mul_of_pos_left hρ h0
    have e2 : ρ₁ * ρ₂ * Real.cos θ₂ ≤ ρ₁ * ρ₂ * Real.cos (θ₁ - θ₂) := mul_le_mul_of_nonneg_left hcos h0.le
    have e3 : ρ₂ ^ 2 * (1 - ρ₁) < 1 - ρ₁ := by
      have : ρ₂ ^ 2 < 1 := by nlinarith [hρ₂.1, hρ₂.2]
      nlinarith [hρ₁.2]
    have e4 : ρ₁ ^ 2 ≤ ρ₁ := by nlinarith [hρ₁.1, hρ₁.2]
    nlinarith
  have hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1 := by
    intro x hx y hy
    obtain ⟨ρ₁, hρ₁, θ₁, hθ₁, rfl⟩ := (hmemR _).mp hx.1
    obtain ⟨ρ₂, hρ₂, θ₂, hθ₂, rfl⟩ := (hmemR _).mp hy.1
    have h1 := (hAd _ _ hρ₁ hθ₁).mp hx
    have h2 := (hAd _ _ hρ₂ hθ₂).mp hy
    rcases le_total θ₁ θ₂ with h | h
    · exact hAkey _ _ _ _ hρ₁ hρ₂ hθ₁ hθ₂ h h2
    · rw [dist_comm]; exact hAkey _ _ _ _ hρ₂ hρ₁ hθ₂ hθ₁ h h1
  -- `R₀ ⊆ closure (A ∪ B)`
  have hcl : R₀ ⊆ closure (A ∪ B) := by
    intro z hz
    rcases lt_trichotomy (dist z 1) 1 with h | h | h
    · exact subset_closure (Or.inl ⟨hz, h⟩)
    · -- on `ω(1)`: a limit of points of `A`
      rw [Metric.mem_closure_iff]
      intro ε hε
      obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp hR₀o z hz
      set t := min (min (r / (‖1 - z‖ + 1)) (ε / (‖1 - z‖ + 1))) (1 / 2) with ht
      have hn : 0 ≤ ‖1 - z‖ := norm_nonneg _
      have ht0 : 0 < t := lt_min (lt_min (by positivity) (by positivity)) (by norm_num)
      have hdz : dist (z + (t : ℂ) * (1 - z)) z = t * ‖1 - z‖ := by
        rw [dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
      have htr : t * ‖1 - z‖ < min r ε := by
        have h1 : t ≤ min (r / (‖1 - z‖ + 1)) (ε / (‖1 - z‖ + 1)) := min_le_left _ _
        have h2 : t * (‖1 - z‖ + 1) ≤ min r ε := by
          have a1 : t ≤ r / (‖1 - z‖ + 1) := h1.trans (min_le_left _ _)
          have a2 : t ≤ ε / (‖1 - z‖ + 1) := h1.trans (min_le_right _ _)
          rw [le_div_iff₀ (by positivity)] at a1 a2
          exact le_min a1 a2
        nlinarith
      have hzt : z + (t : ℂ) * (1 - z) ∈ A := by
        refine ⟨hball (by rw [Metric.mem_ball, hdz]; exact lt_of_lt_of_le htr (min_le_left _ _)), ?_⟩
        rw [mem_ball, dist_eq_norm]
        have hz1 : ‖z - 1‖ = 1 := by rw [← dist_eq_norm]; exact h
        have : z + (t : ℂ) * (1 - z) - 1 = (1 - (t : ℂ)) * (z - 1) := by ring
        rw [this, norm_mul, hz1, mul_one]
        have : ‖(1 : ℂ) - (t : ℂ)‖ = 1 - t := by
          rw [← Complex.ofReal_one, ← Complex.ofReal_sub, Complex.norm_real, Real.norm_eq_abs,
            abs_of_pos (by linarith [min_le_right (min (r / (‖1 - z‖ + 1)) (ε / (‖1 - z‖ + 1))) (1 / 2 : ℝ)])]
        rw [this]; linarith
      exact ⟨_, Or.inl hzt, by rw [dist_comm, hdz]; exact lt_of_lt_of_le htr (min_le_right _ _)⟩
    · exact subset_closure (Or.inr ⟨hz, fun hh => absurd (mem_closedBall.mp hh) (not_le.mpr h)⟩)
  refine H A B 0 Rim.inner 0 (2 * π / 3) hAo hBo hAu hBu (by linarith) (fun θ hθ => ?_)
  refine ⟨min (min (1 / 100) θ) (2 * π / 3 - θ), lt_min (lt_min (by norm_num) hθ.1) (by linarith [hθ.2]), ?_⟩
  refine Subset.trans ?_ hcl
  exact collar_subset_collar 0 Rim.inner (by linarith [min_le_left (min (1 / 100) θ) (2 * π / 3 - θ), min_le_right (min (1 / 100) θ) (2 * π / 3 - θ), min_le_right (1 / 100 : ℝ) θ])
    (by linarith [min_le_right (min (1 / 100) θ) (2 * π / 3 - θ)]) ((min_le_left _ _).trans (min_le_left _ _))

/-! ## FS106-TW: Townsend's `π/3` lemma -/

/-- **FS106-TW, Townsend's `π/3` lemma** (`[Townsend1979ms]` Thm 1, = `[Townsend1981]`'s lemma, in the form its proof reads): `A`, `B` open with
no unit pair in either; every angle off a finite set `K` of cut angles (and their `2π`-translates) carries a collar, on one side or the other of
`ω(u)`, inside `closure (A ∪ B)`; and one side carries collars about every angle of a closed arc of length `> π/3` (the seed: Townsend's "segment
of length greater than ⅓π containing no cut points"). Then `False`. -/
theorem townsend_lemma {A B : Set ℂ} (hA : IsOpen A) (hB : IsOpen B) (hAu : ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1)
    (hBu : ∀ x ∈ B, ∀ y ∈ B, dist x y ≠ 1) {u : ℂ} {K : Set ℝ} (hK : K.Finite)
    (hcollar : ∀ θ : ℝ, (∀ κ ∈ K, ∀ m : ℤ, θ ≠ κ + 2 * π * m) → ∃ s, CollarAt (closure (A ∪ B)) u s θ)
    (hseed : ∃ (s : Rim) (θ₁ θ₂ : ℝ), π / 3 < θ₂ - θ₁ ∧ ∀ θ ∈ Icc θ₁ θ₂, CollarAt (closure (A ∪ B)) u s θ) : False := by
  obtain ⟨s, θ₁, θ₂, hlen, hseedc⟩ := hseed
  obtain ⟨h₀, hh₀, hsub₀⟩ := exists_collar_of_collarAt hseedc
  have hBfin := finite_bad_radii hK
  obtain ⟨t₀, ht₀, hbad⟩ : ∃ t₀ > 0, ∀ ρ ∈ {ρ : ℝ | 0 < ρ ∧ ρ < 2 ∧ ∃ κ ∈ K, ∃ κ' ∈ K, ∃ m : ℤ,
      2 * Real.arccos (ρ / 2) = κ - κ' + 2 * π * m}, ρ ≠ 1 → t₀ ≤ |ρ - 1| := by
    obtain ⟨t₀, ht₀, hle⟩ := exists_pos_le_finset hBfin.toFinset (fun ρ : ℝ => if ρ = 1 then 1 else |ρ - 1|)
      (fun ρ => by by_cases h : ρ = 1 <;> simp [h, abs_pos, sub_ne_zero])
    exact ⟨t₀, ht₀, fun ρ hρ hne => by simpa [hne] using hle ρ (hBfin.mem_toFinset.mpr hρ)⟩
  set t := min (min t₀ h₀) (1 / 2) with ht
  have ht0 : 0 < t := lt_min (lt_min ht₀ hh₀) (by norm_num)
  have htt₀ : t ≤ t₀ := (min_le_left _ _).trans (min_le_left _ _)
  have hth₀ : t ≤ h₀ := (min_le_left _ _).trans (min_le_right _ _)
  have ht1 : t ≤ 1 / 2 := min_le_right _ _
  obtain ⟨ρ, θ, hθ, hρ, hbA, hbB⟩ := exists_changePt_band hA hB hAu hBu (u := u) (s := s) hlen ht0 (by linarith)
    ((collar_subset_collar u s le_rfl le_rfl hth₀).trans hsub₀)
  have hρ1 : |ρ - 1| < t := by
    cases s
    · have : ρ ∈ Ioo (1 - t) 1 := hρ
      rw [abs_lt]; constructor <;> linarith [this.1, this.2]
    · have : ρ ∈ Ioo 1 (1 + t) := hρ
      rw [abs_lt]; constructor <;> linarith [this.1, this.2]
  have hρne : ρ ≠ 1 := by
    intro h
    cases s
    · have : ρ ∈ Ioo (1 - t) 1 := hρ
      linarith [this.2]
    · have : ρ ∈ Ioo 1 (1 + t) := hρ
      linarith [this.1]
  have hρpos : 0 < ρ := by have := abs_lt.mp hρ1; linarith [this.1]
  have hρ2 : ρ < 2 := by have := abs_lt.mp hρ1; linarith [this.2]
  have hρgood : ¬ ∃ κ ∈ K, ∃ κ' ∈ K, ∃ m : ℤ, 2 * Real.arccos (ρ / 2) = κ - κ' + 2 * π * m := by
    intro hbadρ
    have := hbad ρ ⟨hρpos, hρ2, hbadρ⟩ hρne
    linarith
  set α := Real.arccos (ρ / 2) with hα
  have hbmem : u + (ρ : ℂ) * e θ ∈ interior (closure (A ∪ B)) := by
    have hcol : u + (ρ : ℂ) * e θ ∈ collar u s θ₁ θ₂ t := (mem_collar_iff u s _ _ _ _).mpr ⟨ρ, hρ, θ, hθ, rfl⟩
    exact interior_maximal ((collar_subset_collar u s le_rfl le_rfl hth₀).trans hsub₀) (isOpen_collar u s _ _ (by linarith)) hcol
  -- one of the two landings is not a cut angle
  have hland : ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ ∀ κ ∈ K, ∀ m : ℤ, θ + σ * α ≠ κ + 2 * π * m := by
    by_contra hcon
    push Not at hcon
    obtain ⟨κ, hκ, m, hm⟩ := hcon 1 (Or.inl rfl)
    obtain ⟨κ', hκ', m', hm'⟩ := hcon (-1) (Or.inr rfl)
    exact hρgood ⟨κ, hκ, κ', hκ', m - m', by push_cast; linarith⟩
  obtain ⟨σ, hσ, hK'⟩ := hland
  obtain ⟨s', hs'⟩ := hcollar (θ + σ * α) hK'
  exact false_of_changePt_landing hA hB hAu hBu isOpen_interior interior_subset hρpos hρ2 hσ hbmem
    (by simpa using hbA) (by simpa using hbB) hs'.interior

/-! ## The excluded set: cones decide the collars -/

/-- **Outer collars from a cone direction**: a preconnected `R` with `u ∈ closure R` approaching `u` along `β` meets the unit circle about
every point of some outer collar about `ψ` whenever `cos (β − ψ) > 0` (such a point `z` has `u` outside `B̄(z, 1)` and points of `R` inside). -/
theorem collarAt_shadow_outer {R : Set ℂ} (hRc : IsPreconnected R) {u : ℂ} {β ψ : ℝ} (hβ : β ∈ coneAt R u)
    (hcos : 0 < Real.cos (β - ψ)) : CollarAt (shadow R) u .outer ψ := by
  set c₀ := Real.cos (β - ψ) with hc₀
  obtain ⟨w, hwR, hwu, hwd, hwdir⟩ := hβ (c₀ / 4) (by linarith)
  set q := w - u with hq
  set r₀ := ‖q‖ with hr₀def
  have hr₀ : 0 < r₀ := norm_pos_iff.mpr (sub_ne_zero.mpr hwu)
  have hr₀lt : r₀ < c₀ / 4 := by rw [dist_eq_norm] at hwd; exact hwd
  have hmain : 0 < r₀ * c₀ := mul_pos hr₀ hcos
  set h := min (min (c₀ / 4) 1) (r₀ * c₀ / 4) with hh
  have hh0 : 0 < h := lt_min (lt_min (by linarith) one_pos) (by linarith)
  have hh1 : h ≤ c₀ / 4 := (min_le_left _ _).trans (min_le_left _ _)
  have hh2 : h ≤ 1 := (min_le_left _ _).trans (min_le_right _ _)
  have hh3 : h ≤ r₀ * c₀ / 4 := min_le_right _ _
  refine ⟨h, hh0, fun z hz => ?_⟩
  obtain ⟨ρ', hρ', ψ', hψ', rfl⟩ := (mem_collar_iff _ _ _ _ _ _).mp hz
  have hρ'' : 1 < ρ' ∧ ρ' < 1 + h := hρ'
  have hψ'h : |ψ' - ψ| < h := by rw [abs_lt]; constructor <;> linarith [hψ'.1, hψ'.2]
  have hdot := dot_cone_bound (ψ' := ψ') hr₀ (β := β) (ψ := ψ) (ε := c₀ / 4) hwdir
  have hD : r₀ * c₀ / 2 ≤ dot q (e ψ') := by
    have h1 := (abs_le.mp hdot).1
    have : c₀ / 2 ≤ dot q (e ψ') / r₀ := by linarith
    rw [le_div_iff₀ hr₀] at this; linarith
  have ha : dist (u + (ρ' : ℂ) * e ψ') w < 1 := by
    have hsq : ‖q - (ρ' : ℂ) * e ψ'‖ ^ 2 < 1 := by
      rw [norm_sub_real_mul_e_sq]
      have hr2 : r₀ ^ 2 < r₀ * (c₀ / 4) := by nlinarith
      have hρ2 : ρ' ^ 2 < 1 + 3 * h := by nlinarith
      have hρD : ρ' * (r₀ * c₀) ≥ r₀ * c₀ := by nlinarith
      nlinarith
    have : dist (u + (ρ' : ℂ) * e ψ') w = ‖q - (ρ' : ℂ) * e ψ'‖ := by
      rw [dist_eq_norm, ← norm_neg]; congr 1; simp only [hq]; ring
    rw [this]
    nlinarith [norm_nonneg (q - (ρ' : ℂ) * e ψ')]
  have hzu : dist (u + (ρ' : ℂ) * e ψ') u = ρ' := by
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by linarith)]
  obtain ⟨b, hbR, -, hbd, -⟩ := hβ (ρ' - 1) (by linarith)
  refine mem_shadow_of_preconnected hRc hwR hbR ha ?_
  have := dist_triangle (u + (ρ' : ℂ) * e ψ') b u
  rw [hzu] at this
  linarith

/-- **Inner collars from a cone direction**: the same for inner collars when `cos (β − ψ) < 0` (such a point `z` has `u` inside `B(z, 1)` and
points of `R` outside). -/
theorem collarAt_shadow_inner {R : Set ℂ} (hRc : IsPreconnected R) {u : ℂ} {β ψ : ℝ} (hβ : β ∈ coneAt R u)
    (hcos : Real.cos (β - ψ) < 0) : CollarAt (shadow R) u .inner ψ := by
  set m := -Real.cos (β - ψ) with hm
  have hm0 : 0 < m := by rw [hm]; linarith
  obtain ⟨w, hwR, hwu, hwd, hwdir⟩ := hβ (m / 4) (by linarith)
  set q := w - u with hq
  set r₀ := ‖q‖ with hr₀def
  have hr₀ : 0 < r₀ := norm_pos_iff.mpr (sub_ne_zero.mpr hwu)
  have hr₀lt : r₀ < m / 4 := by rw [dist_eq_norm] at hwd; exact hwd
  have hmain : 0 < r₀ * m := mul_pos hr₀ hm0
  set h := min (min (m / 4) (1 / 2)) (r₀ * m / 8) with hh
  have hh0 : 0 < h := lt_min (lt_min (by linarith) (by norm_num)) (by linarith)
  have hh1 : h ≤ m / 4 := (min_le_left _ _).trans (min_le_left _ _)
  have hh2 : h ≤ 1 / 2 := (min_le_left _ _).trans (min_le_right _ _)
  have hh3 : h ≤ r₀ * m / 8 := min_le_right _ _
  refine ⟨h, hh0, fun z hz => ?_⟩
  obtain ⟨ρ', hρ', ψ', hψ', rfl⟩ := (mem_collar_iff _ _ _ _ _ _).mp hz
  have hρ'' : 1 - h < ρ' ∧ ρ' < 1 := hρ'
  have hψ'h : |ψ' - ψ| < h := by rw [abs_lt]; constructor <;> linarith [hψ'.1, hψ'.2]
  have hdot := dot_cone_bound (ψ' := ψ') hr₀ (β := β) (ψ := ψ) (ε := m / 4) hwdir
  have hD : dot q (e ψ') ≤ -(r₀ * m / 2) := by
    have h1 := (abs_le.mp hdot).2
    have : dot q (e ψ') / r₀ ≤ -(m / 2) := by linarith
    rw [div_le_iff₀ hr₀] at this; linarith
  have hw : 1 < dist (u + (ρ' : ℂ) * e ψ') w := by
    have hsq : 1 < ‖q - (ρ' : ℂ) * e ψ'‖ ^ 2 := by
      rw [norm_sub_real_mul_e_sq]
      have hρ2 : 1 - 2 * h < ρ' ^ 2 := by nlinarith
      have hρD : ρ' * (r₀ * m) ≥ r₀ * m / 2 := by nlinarith
      nlinarith [sq_nonneg r₀]
    have : dist (u + (ρ' : ℂ) * e ψ') w = ‖q - (ρ' : ℂ) * e ψ'‖ := by
      rw [dist_eq_norm, ← norm_neg]; congr 1; simp only [hq]; ring
    rw [this]
    nlinarith [norm_nonneg (q - (ρ' : ℂ) * e ψ')]
  have hzu : dist (u + (ρ' : ℂ) * e ψ') u = ρ' := by
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by linarith)]
  obtain ⟨a, haR, -, had, -⟩ := hβ (1 - ρ') (by linarith)
  refine mem_shadow_of_preconnected hRc haR hwR ?_ hw
  have := dist_triangle (u + (ρ' : ℂ) * e ψ') u a
  rw [hzu, dist_comm u a] at this
  linarith

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- **The excluded set carries no colour of `T`**: an interior point of a valid map whose unit circle meets the class of every colour of `T`
does not carry a colour of `T`. -/
theorem col_not_mem_of_mem_shadow (hF : F.Valid) {T : Finset (Fin k)} {z : ℂ} (hz : z ∈ F.interiorPts)
    (hzT : ∀ c ∈ T, z ∈ shadow (F.region c)) : F.col z ∉ T := by
  intro hc
  obtain ⟨y, hy, hzy⟩ := hzT _ hc
  exact hF z hz y hy.1 hzy (hy.2.symm)

/-- **An open subset of the excluded set is coloured by the other colours**: in a valid map of the plane, an open set whose points' unit
circles meet every class of `T` lies in the closure of the union of the classes of the colours outside `T`. -/
theorem subset_closure_of_subset_shadow (hF : F.Valid) (hP : F.IsPlaneMap) {T : Finset (Fin k)} {W : Set ℂ} (hW : IsOpen W)
    (hWT : ∀ c ∈ T, W ⊆ shadow (F.region c)) : W ⊆ closure (⋃ c ∈ (Tᶜ : Finset (Fin k)), F.region c) := by
  intro x hx
  rw [Metric.mem_closure_iff]
  intro ε hε
  obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp hW x hx
  have hxdom : x ∈ closure F.interiorPts := F.dense_interiorPts (by rw [hP]; trivial)
  obtain ⟨z, hz, hxz⟩ := Metric.mem_closure_iff.mp hxdom (min ε r) (lt_min hε hr)
  have hzW : z ∈ W := hball (by rw [Metric.mem_ball]; exact lt_of_lt_of_le (by rw [dist_comm]; exact hxz) (min_le_right _ _))
  have hcol : F.col z ∉ T := col_not_mem_of_mem_shadow hF hz fun c hc => hWT c hc hzW
  refine ⟨z, mem_iUnion₂.mpr ⟨F.col z, by simpa using hcol, hz, rfl⟩, ?_⟩
  exact lt_of_lt_of_le hxz (min_le_left _ _)

end ArcMap

end HadwigerNelson.Plane
