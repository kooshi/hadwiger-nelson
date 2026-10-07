import Proofs.HadwigerNelson.Outside.OAI158Palette

/-!
# Confinement by a straddle exclusion (FS-132, C132-CONFINE)

A set `H` that misses the straddle region `Δ(K)` of a set `K` sees `K`, from each of its points `z`, on one side of the
unit circle about `z`: `K` lies in the closed unit disc about `z`, or misses the open one. No colouring enters.

**The statement is wider than the claim's.** C132-CONFINE asks `K` compact and connected; with `Δ(K)` in the release's
witness form (`Outside.OAI158.Straddle`: some point of `K` nearer than `1` and some point farther) the dichotomy is the
negation of `z ∈ Δ(K)` for every set `K` (`confine`), and for a non-empty compact `K` the witness form is the claim's
`min < 1 < max` (`mem_straddle_iff_min_max`). The two direction clauses use neither `H` nor `x ∈ K`
(`inner_nonneg_of_subset_closedBall`, `inner_nonpos_of_disjoint_ball`).
-/

open Filter Topology
open scoped RealInnerProductSpace

namespace HadwigerNelson.SixRing

open Outside.OAI158

/-- **C132-CONFINE, the dichotomy, for every set `K`**: a point outside the straddle region of `K` has `K` inside its
closed unit disc or outside its open one. -/
theorem confine {K : Set ℂ} {z : ℂ} (hz : z ∉ Straddle K) :
    K ⊆ Metric.closedBall z 1 ∨ Disjoint K (Metric.ball z 1) := by
  by_contra h
  rw [not_or] at h
  obtain ⟨q, hqK, hq⟩ := Set.not_subset.mp h.1
  obtain ⟨p, hpK, hp⟩ := Set.not_disjoint_iff.mp h.2
  rw [Metric.mem_closedBall, not_le, dist_comm] at hq
  rw [Metric.mem_ball, dist_comm] at hp
  exact hz ⟨p, hpK, q, hqK, hp, hq⟩

/-- C132-CONFINE in the claim's form: `H ∩ Δ(K) = ∅` and `z ∈ H`. -/
theorem confine_of_disjoint {K H : Set ℂ} (hH : Disjoint H (Straddle K)) {z : ℂ} (hz : z ∈ H) :
    K ⊆ Metric.closedBall z 1 ∨ Disjoint K (Metric.ball z 1) :=
  confine (Set.disjoint_left.mp hH hz)

/-- C132-CONFINE, "in particular", first clause: a point of `K` nearer than `1` to `z` puts all of `K` in the closed
unit disc about `z`. -/
theorem subset_closedBall_of_dist_lt {K H : Set ℂ} (hH : Disjoint H (Straddle K)) {z x : ℂ} (hz : z ∈ H)
    (hx : x ∈ K) (hzx : dist z x < 1) : K ⊆ Metric.closedBall z 1 :=
  (confine_of_disjoint hH hz).resolve_right fun h =>
    Set.disjoint_left.mp h hx (by rwa [Metric.mem_ball, dist_comm])

/-- The claim's `Δ(K)` — the least distance from `z` to `K` below `1` and the greatest above — is the release's
`Straddle K`, for a non-empty compact `K` (where both are attained). -/
theorem mem_straddle_iff_min_max {K : Set ℂ} (hK : IsCompact K) (hne : K.Nonempty) {z : ℂ} :
    z ∈ Straddle K ↔
      (∃ p ∈ K, IsMinOn (dist z) K p ∧ dist z p < 1) ∧ ∃ q ∈ K, IsMaxOn (dist z) K q ∧ 1 < dist z q := by
  have hcont : ContinuousOn (dist z) K := (continuous_const.dist continuous_id).continuousOn
  constructor
  · rintro ⟨p, hp, q, hq, hp1, hq1⟩
    obtain ⟨p', hp', hmin⟩ := hK.exists_isMinOn hne hcont
    obtain ⟨q', hq', hmax⟩ := hK.exists_isMaxOn hne hcont
    exact ⟨⟨p', hp', hmin, (hmin hp).trans_lt hp1⟩, q', hq', hmax, hq1.trans_le (hmax hq)⟩
  · rintro ⟨⟨p, hp, -, hp1⟩, q, hq, -, hq1⟩
    exact ⟨p, hp, q, hq, hp1, hq1⟩

/-- C132-CONFINE, the direction clause for `K ⊆ B̄(z, 1)`: a limiting direction `v` at `x` of points of `K`, with
`|z − x| = 1`, has `v · (z − x) ≥ 0`. Neither `H` nor `x ∈ K` is used. -/
theorem inner_nonneg_of_subset_closedBall {K : Set ℂ} {x z v : ℂ} (hzx : dist z x = 1) {q : ℕ → ℂ}
    (hq : ∀ m, q m ∈ K) (hne : ∀ m, q m ≠ x)
    (hdir : Tendsto (fun m => (‖q m - x‖⁻¹ : ℝ) • (q m - x)) atTop (𝓝 v))
    (hK : K ⊆ Metric.closedBall z 1) : 0 ≤ ⟪v, z - x⟫ := by
  refine ge_of_tendsto' ((continuous_id.inner continuous_const).continuousAt.tendsto.comp hdir) fun m => ?_
  have hpos : 0 < ‖q m - x‖ := norm_pos_iff.mpr (sub_ne_zero.mpr (hne m))
  have h1 : ‖q m - z‖ ≤ 1 := by simpa [dist_eq_norm] using hK (hq m)
  have h2 : ‖z - x‖ = 1 := by rw [← dist_eq_norm]; exact hzx
  have h3 : ‖q m - z‖ ^ 2 = ‖q m - x‖ ^ 2 - 2 * ⟪q m - x, z - x⟫ + ‖z - x‖ ^ 2 := by
    rw [← norm_sub_sq_real]; congr 2; abel
  have h4 : 0 ≤ ⟪q m - x, z - x⟫ := by nlinarith [norm_nonneg (q m - z), sq_nonneg ‖q m - x‖]
  simp only [Function.comp_apply, id_eq, inner_smul_left, conj_trivial]
  exact mul_nonneg (inv_nonneg.mpr hpos.le) h4

/-- C132-CONFINE, the direction clause for `K ∩ B(z, 1) = ∅`: then `v · (z − x) ≤ 0`. -/
theorem inner_nonpos_of_disjoint_ball {K : Set ℂ} {x z v : ℂ} (hzx : dist z x = 1) {q : ℕ → ℂ}
    (hq : ∀ m, q m ∈ K) (hne : ∀ m, q m ≠ x) (hlim : Tendsto q atTop (𝓝 x))
    (hdir : Tendsto (fun m => (‖q m - x‖⁻¹ : ℝ) • (q m - x)) atTop (𝓝 v))
    (hK : Disjoint K (Metric.ball z 1)) : ⟪v, z - x⟫ ≤ 0 := by
  have hnorm : Tendsto (fun m => ‖q m - x‖ / 2) atTop (𝓝 0) := by
    have h := (tendsto_iff_norm_sub_tendsto_zero.mp hlim).div_const 2
    simpa using h
  have hcomp : Tendsto (fun m => ⟪(‖q m - x‖⁻¹ : ℝ) • (q m - x), z - x⟫) atTop (𝓝 ⟪v, z - x⟫) :=
    (continuous_id.inner (continuous_const (y := z - x))).continuousAt.tendsto.comp hdir
  have hinner := hcomp.sub hnorm
  rw [sub_zero] at hinner
  refine le_of_tendsto' hinner fun m => ?_
  have hpos : 0 < ‖q m - x‖ := norm_pos_iff.mpr (sub_ne_zero.mpr (hne m))
  have h1 : 1 ≤ ‖q m - z‖ := by
    have h := Set.disjoint_left.mp hK (hq m)
    rwa [Metric.mem_ball, not_lt, dist_eq_norm] at h
  have h2 : ‖z - x‖ = 1 := by rw [← dist_eq_norm]; exact hzx
  have h3 : ‖q m - z‖ ^ 2 = ‖q m - x‖ ^ 2 - 2 * ⟪q m - x, z - x⟫ + ‖z - x‖ ^ 2 := by
    rw [← norm_sub_sq_real]; congr 2; abel
  have h4 : ⟪q m - x, z - x⟫ ≤ ‖q m - x‖ ^ 2 / 2 := by nlinarith [norm_nonneg (q m - z)]
  rw [sub_nonpos, real_inner_smul_left]
  calc ‖q m - x‖⁻¹ * ⟪q m - x, z - x⟫ ≤ ‖q m - x‖⁻¹ * (‖q m - x‖ ^ 2 / 2) :=
        mul_le_mul_of_nonneg_left h4 (inv_nonneg.mpr hpos.le)
    _ = ‖q m - x‖ / 2 := by field_simp

/-- **Model of the hypotheses, both cases at once** (the claim's not-claimed line: `K = {x}` satisfies both): for
`K = {0}`, `H = {1}`, the set `H` misses `Δ(K)`, and `K` is inside the closed unit disc about `1` and misses the
open one. -/
example : Disjoint ({1} : Set ℂ) (Straddle {0}) ∧ ({0} : Set ℂ) ⊆ Metric.closedBall 1 1 ∧
    Disjoint ({0} : Set ℂ) (Metric.ball 1 1) := by
  refine ⟨?_, by simp, by simp⟩
  rw [Set.disjoint_singleton_left]
  rintro ⟨p, hp, q, hq, hp1, hq1⟩
  rw [Set.mem_singleton_iff] at hp hq
  subst hp hq
  exact absurd hp1 (not_lt.mpr hq1.le)

/-- `Straddle` does not drift: the point `1/2` is not in the straddle region of `{0}`, and it is in that of
`{0, 2}`. -/
example : (1 / 2 : ℂ) ∉ Straddle {0} ∧ (1 / 2 : ℂ) ∈ Straddle {0, 2} := by
  constructor
  · rintro ⟨p, hp, q, hq, hp1, hq1⟩
    rw [Set.mem_singleton_iff] at hp hq
    subst hp hq
    exact absurd hp1 (not_lt.mpr hq1.le)
  · refine ⟨0, by simp, 2, by simp, ?_, ?_⟩
    · rw [dist_zero_right]; norm_num
    · rw [dist_eq_norm, show (1 / 2 : ℂ) - 2 = ((-(3 / 2) : ℝ) : ℂ) by push_cast; ring, Complex.norm_real]
      norm_num

end HadwigerNelson.SixRing
