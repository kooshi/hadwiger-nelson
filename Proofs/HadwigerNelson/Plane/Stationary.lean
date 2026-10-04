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

/-- **FS129-OA1-NOPERLAW**, first clause: `Z` is a discrete subgroup of `ℝ²`. -/
theorem CPColouring.exists_discrete_forcedSet (c : CPColouring k) :
    ∃ G : AddSubgroup ℂ, (G : Set ℂ) = c.forcedSet ∧ DiscreteTopology G := by
  sorry

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
