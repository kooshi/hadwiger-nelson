import Proofs.HadwigerNelson.Plane.CPColouring
import Proofs.HadwigerNelson.Plane.Cover

/-!
# Forced translations of a CP colouring (FS-131 wave 2)

Row: **FS129-OA1-NOPERLAW**. Plan: `plans/FS131-w2-kernel-plan.md` § 4. The object is the foundation's `CPColouring`
(a stationary random colouring, continuous in probability, proper almost surely on every unit pair, as its law). The
inhabitant `sq9CP` is the CP colouring every theorem here is witnessed by.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology

variable {k : ℕ}

/-- **Inhabitant**: `sq9` under a uniformly random translation of its period torus `(3/2)ℤ²` — the law of
`y ↦ sq9.col (y + z)`, `z` uniform on `[0, 3/2)²`. -/
theorem nonempty_cpColouring_nine : Nonempty (CPColouring 9) := by
  sorry

/-- `Z`: the vectors `x` with `c(0) = c(x)` almost surely. -/
def CPColouring.forcedSet (c : CPColouring k) : Set ℂ := {x | c.law {f | f 0 = f x} = 1}

/-- Stationarity: `P(f(x) ≠ f(y))` depends only on `y - x`. -/
theorem CPColouring.law_shift (c : CPColouring k) (x : ℂ) {s : Set (ℂ → Fin k)} (hs : MeasurableSet s) :
    c.law (shiftCol x ⁻¹' s) = c.law s := by
  rw [← Measure.map_apply (measurable_shiftCol x) hs, c.map_shift]

theorem CPColouring.measurableSet_eq (x y : ℂ) : MeasurableSet {f : ℂ → Fin k | f x = f y} :=
  measurableSet_eq_fun (measurable_pi_apply x) (measurable_pi_apply y)

/-- Translating the pair: `P(f(a) = f(b)) = P(f(a + x) = f(b + x))`. -/
theorem CPColouring.law_eq_translate (c : CPColouring k) (a b x : ℂ) :
    c.law {f | f (a + x) = f (b + x)} = c.law {f | f a = f b} := by
  have : {f : ℂ → Fin k | f (a + x) = f (b + x)} = shiftCol x ⁻¹' {f | f a = f b} := rfl
  rw [this]; exact c.law_shift x (CPColouring.measurableSet_eq a b)

/-- `P(f(a) ≠ f(c)) ≤ P(f(a) ≠ f(b)) + P(f(b) ≠ f(c))`. -/
theorem CPColouring.law_ne_triangle (c : CPColouring k) (a b d : ℂ) :
    c.law {f | f a ≠ f d} ≤ c.law {f | f a ≠ f b} + c.law {f | f b ≠ f d} := by
  refine (measure_mono (fun f hf => ?_)).trans (measure_union_le _ _)
  by_contra hcon
  simp only [mem_union, mem_setOf_eq, not_or, not_not] at hcon hf
  exact hf (hcon.1.trans hcon.2)

theorem CPColouring.law_ne_eq (c : CPColouring k) (x y : ℂ) :
    c.law {f | f x ≠ f y} = 1 - c.law {f | f x = f y} := by
  have : {f : ℂ → Fin k | f x ≠ f y} = {f | f x = f y}ᶜ := rfl
  rw [this, prob_compl_eq_one_sub (CPColouring.measurableSet_eq x y)]

theorem CPColouring.isClosed_forcedSet (c : CPColouring k) : IsClosed c.forcedSet := by
  rw [← isOpen_compl_iff, isOpen_iff_mem_nhds]
  intro x hx
  have hp : 0 < c.law {f | f 0 ≠ f x} := by
    rw [CPColouring.law_ne_eq]
    have : c.law {f | f 0 = f x} ≠ 1 := hx
    have h1 : c.law {f | f 0 = f x} ≤ 1 := prob_le_one
    exact tsub_pos_of_lt (lt_of_le_of_ne h1 this)
  have hev := (c.tendsto_ne x).eventually (gt_mem_nhds hp)
  filter_upwards [hev] with y hy hyZ
  have hyZ' : c.law {f | f 0 = f y} = 1 := hyZ
  have h0 : c.law {f | f 0 ≠ f y} = 0 := by rw [CPColouring.law_ne_eq, hyZ']; simp
  have h1 := c.law_ne_triangle 0 y x
  have h2 : c.law {f | f y ≠ f x} = c.law {f | f x ≠ f y} := by
    congr 1; ext f; simp [ne_comm]
  rw [h0, zero_add, h2] at h1
  exact absurd (lt_of_le_of_lt h1 hy) (lt_irrefl _)

theorem CPColouring.law_eq_one_iff (c : CPColouring k) (a b : ℂ) :
    c.law {f | f a = f b} = 1 ↔ ∀ᵐ f ∂c.law, f a = f b := by
  rw [ae_iff]
  have : {f : ℂ → Fin k | ¬ f a = f b} = {f | f a = f b}ᶜ := rfl
  rw [this, prob_compl_eq_zero_iff (CPColouring.measurableSet_eq a b)]

/-- `Z` is an additive subgroup. -/
def CPColouring.forcedSubgroup (c : CPColouring k) : AddSubgroup ℂ where
  carrier := c.forcedSet
  zero_mem' := by
    show c.law {f | f 0 = f 0} = 1
    simp
  add_mem' := by
    intro x y hx hy
    have hx' : ∀ᵐ f ∂c.law, f 0 = f x := (c.law_eq_one_iff 0 x).1 hx
    have hy' : ∀ᵐ f ∂c.law, f 0 = f y := (c.law_eq_one_iff 0 y).1 hy
    show c.law {f | f 0 = f (x + y)} = 1
    rw [c.law_eq_one_iff]
    have hy2 : ∀ᵐ f ∂c.law, f x = f (x + y) := by
      rw [← c.law_eq_one_iff]
      have := c.law_eq_translate 0 y x
      rw [zero_add, add_comm y x] at this
      rw [this]; exact hy
    filter_upwards [hx', hy2] with f h1 h2 using h1.trans h2
  neg_mem' := by
    intro x hx
    show c.law {f | f 0 = f (-x)} = 1
    have := c.law_eq_translate (-x) 0 x
    rw [neg_add_cancel, zero_add] at this
    have h2 : c.law {f | f (-x) = f 0} = 1 := by rw [← this]; exact hx
    rw [c.law_eq_one_iff] at h2 ⊢
    filter_upwards [h2] with f h using h.symm

/-- A closed subgroup of `ℂ` meeting no unit vector has no small nonzero elements. -/
theorem exists_pos_forall_norm_lt_eq_zero {G : AddSubgroup ℂ} (hG : IsClosed (G : Set ℂ))
    (hunit : ∀ g ∈ G, ‖g‖ ≠ 1) : ∃ r > 0, ∀ g ∈ G, ‖g‖ < r → g = 0 := by
  by_contra hcon
  push Not at hcon
  have hn : ∀ n : ℕ, ∃ g ∈ G, ‖g‖ < 1 / ((n : ℝ) + 1) ∧ g ≠ 0 := fun n =>
    hcon (1 / ((n : ℝ) + 1)) (by positivity)
  choose g hgG hglt hg0 using hn
  -- multiples reaching the unit sphere
  set m : ℕ → ℕ := fun n => ⌊1 / ‖g n‖⌋₊ with hm
  have hgpos : ∀ n, 0 < ‖g n‖ := fun n => norm_pos_iff.2 (hg0 n)
  have hz : ∀ n, ((m n : ℕ) • g n) ∈ G := fun n => G.nsmul_mem (hgG n) _
  have hznorm : ∀ n, 1 - ‖g n‖ < ‖(m n : ℕ) • g n‖ ∧ ‖(m n : ℕ) • g n‖ ≤ 1 := by
    intro n
    rw [nsmul_eq_mul, norm_mul, Complex.norm_natCast]
    have h1 : (m n : ℝ) ≤ 1 / ‖g n‖ := Nat.floor_le (by positivity)
    have h2 : 1 / ‖g n‖ < m n + 1 := Nat.lt_floor_add_one _
    constructor
    · have := (div_lt_iff₀ (hgpos n)).1 h2
      linarith [this]
    · calc (m n : ℝ) * ‖g n‖ ≤ 1 / ‖g n‖ * ‖g n‖ := by gcongr
        _ = 1 := by field_simp [(hgpos n).ne']
  have hbdd : ∀ n, ((m n : ℕ) • g n) ∈ Metric.closedBall (0 : ℂ) 1 := fun n => by
    rw [mem_closedBall_zero_iff]; exact (hznorm n).2
  obtain ⟨z, hzB, φ, hφ, hlim⟩ := (isCompact_closedBall (0 : ℂ) 1).tendsto_subseq hbdd
  have hzG : z ∈ G := hG.mem_of_tendsto hlim (Eventually.of_forall fun n => hz (φ n))
  have hnorm_lim : Tendsto (fun n => ‖(m (φ n) : ℕ) • g (φ n)‖) atTop (𝓝 ‖z‖) := hlim.norm
  have hnorm_one : Tendsto (fun n => ‖(m (φ n) : ℕ) • g (φ n)‖) atTop (𝓝 1) := by
    have hgl : Tendsto (fun n => ‖g (φ n)‖) atTop (𝓝 0) := by
      refine squeeze_zero (fun n => (hgpos _).le) (fun n => (hglt (φ n)).le) ?_
      have : Tendsto (fun n : ℕ => 1 / ((φ n : ℝ) + 1)) atTop (𝓝 0) :=
        (tendsto_one_div_add_atTop_nhds_zero_nat).comp hφ.tendsto_atTop
      exact this
    refine tendsto_of_tendsto_of_tendsto_of_le_of_le (g := fun n => 1 - ‖g (φ n)‖) (h := fun _ => 1) ?_ tendsto_const_nhds
      (fun n => (hznorm (φ n)).1.le) (fun n => (hznorm (φ n)).2)
    simpa using (tendsto_const_nhds (x := (1 : ℝ))).sub hgl
  have : ‖z‖ = 1 := tendsto_nhds_unique hnorm_lim hnorm_one
  exact hunit z hzG this

/-- **FS129-OA1-NOPERLAW**, first clause: `Z` is a discrete subgroup of `ℝ²`. -/
theorem CPColouring.exists_discrete_forcedSet (c : CPColouring k) :
    ∃ G : AddSubgroup ℂ, (G : Set ℂ) = c.forcedSet ∧ DiscreteTopology G := by
  refine ⟨c.forcedSubgroup, rfl, ?_⟩
  have hunit : ∀ g ∈ c.forcedSubgroup, ‖g‖ ≠ 1 := by
    intro g hg hn
    have h0 := c.proper 0 g hn
    have h1 : c.law {f | f 0 = f g} = 1 := hg
    rw [zero_add] at h0
    rw [h0] at h1
    exact zero_ne_one h1
  obtain ⟨r, hr, hsmall⟩ := exists_pos_forall_norm_lt_eq_zero (c.isClosed_forcedSet) hunit
  refine discreteTopology_of_isOpen_singleton_zero ?_
  have : ({0} : Set c.forcedSubgroup) = Subtype.val ⁻¹' Metric.ball (0 : ℂ) r := by
    ext ⟨g, hg⟩
    simp only [mem_singleton_iff, mem_preimage, Metric.mem_ball, dist_zero_right]
    constructor
    · intro h
      have : g = 0 := congrArg Subtype.val h
      rw [this]; simpa using hr
    · intro h; exact Subtype.ext (hsmall g hg h)
  rw [this]
  exact Metric.isOpen_ball.preimage continuous_subtype_val

/-- **FS129-OA1-NOPERLAW**, second clause: if the law is rotation-invariant, `Z = {0}`. -/
theorem CPColouring.forcedSet_eq_zero (c : CPColouring k) (h : c.RotationInvariant) : c.forcedSet = {0} := by
  classical
  obtain ⟨G, hG, hdisc⟩ := c.exists_discrete_forcedSet
  have hrot : ∀ θ x, x ∈ c.forcedSet → e θ * x ∈ c.forcedSet := by
    intro θ x hx
    have hm : MeasurableSet {g : ℂ → Fin k | g 0 = g x} :=
      measurableSet_eq_fun (measurable_pi_apply 0) (measurable_pi_apply x)
    have h1 : {f : ℂ → Fin k | f 0 = f (e θ * x)} = rotCol θ ⁻¹' {g | g 0 = g x} := by
      ext f; simp [rotCol]
    show c.law {f | f 0 = f (e θ * x)} = 1
    rw [h1, ← Measure.map_apply (measurable_rotCol θ) hm, h θ]
    exact hx
  have h0 : (0 : ℂ) ∈ c.forcedSet := by
    show c.law {f | f 0 = f 0} = 1
    simp
  refine subset_antisymm (fun x hx => ?_) (by simpa using h0)
  by_contra hx0
  have hx0' : x ≠ 0 := by simpa using hx0
  -- discreteness: some open set about `0` meets `G` only in `0`
  have hopen : IsOpen ({0} : Set G) := isOpen_discrete _
  obtain ⟨O, hO, hOG⟩ := isOpen_induced_iff.1 hopen
  have h0O : (0 : ℂ) ∈ O := by
    have : (0 : G) ∈ (Subtype.val ⁻¹' O : Set G) := by rw [hOG]; rfl
    exact this
  -- small rotations of `x` stay in `O + x`
  have hcont : Tendsto (fun θ : ℝ => e θ * x - x) (𝓝 0) (𝓝 0) := by
    have : Continuous fun θ : ℝ => e θ * x - x := (continuous_e.mul continuous_const).sub continuous_const
    simpa [e] using this.tendsto 0
  have hev : ∀ᶠ θ in 𝓝[>] (0 : ℝ), e θ * x - x ∈ O ∧ 0 < θ ∧ θ < 2 * Real.pi :=
    (((hcont.mono_left nhdsWithin_le_nhds).eventually (hO.mem_nhds h0O)).and self_mem_nhdsWithin).and
      (Ioo_mem_nhdsGT (by positivity : (0 : ℝ) < 2 * Real.pi)) |>.mono fun θ h => ⟨h.1.1, h.1.2, h.2.2⟩
  obtain ⟨θ, hθO, hθ0, hθ2⟩ := hev.exists
  have hxG : x ∈ G := by rw [← SetLike.mem_coe, hG]; exact hx
  have hrG : e θ * x ∈ G := by rw [← SetLike.mem_coe, hG]; exact hrot θ x hx
  have hdG : e θ * x - x ∈ G := G.sub_mem hrG hxG
  have : (⟨e θ * x - x, hdG⟩ : G) ∈ ({0} : Set G) := by
    rw [← hOG]; exact hθO
  have hz : e θ * x - x = 0 := by simpa using congrArg Subtype.val this
  have he1 : e θ = 1 := by
    have : (e θ - 1) * x = 0 := by linear_combination hz
    rcases mul_eq_zero.1 this with h | h
    · linear_combination h
    · exact absurd h hx0'
  obtain ⟨n, hn⟩ := Complex.exp_eq_one_iff.1 (show Complex.exp (θ * I) = 1 from he1)
  have hθn : θ = n * (2 * Real.pi) := by
    have := congrArg Complex.im hn
    simpa using this
  have hn1 : (0 : ℝ) < n := by
    have : 0 < (n : ℝ) * (2 * Real.pi) := hθn ▸ hθ0
    exact pos_of_mul_pos_left this (by positivity) |> fun h => by linarith [Real.pi_pos]
  have hn2 : (n : ℝ) < 1 := by
    have : (n : ℝ) * (2 * Real.pi) < 2 * Real.pi := hθn ▸ hθ2
    nlinarith [Real.pi_pos]
  have : (0 : ℤ) < n := by exact_mod_cast hn1
  have : n < (1 : ℤ) := by exact_mod_cast hn2
  omega

end HadwigerNelson.Plane
