import Proofs.HadwigerNelson.Plane.Saturated.FanBridge

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

--BEGIN-ROOT
/-! ### One sector per colour: Lemma H and the angular lemma (FS131-I6E; FS121-V2 §§ 2.1–2.3) -/

/-- FS121-V2's Lemma H, the excluded case: two preconnected pieces of the density set of `A`, each with `z` in its
closure, cannot hold one a point strictly inside and the other a point strictly outside the unit circle about a point
`y` of the support of `A` (Lemma C, `hullset`, at a density point `q` near `y` off the unit circle about `z`). -/
theorem false_of_inside_of_outside {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {y z : ℂ}
    (hy : y ∈ essSupport A) {P P' : Set ℂ} (hP : IsPreconnected P) (hPA : P ⊆ densitySet A) (hzP : z ∈ closure P)
    (hP' : IsPreconnected P') (hP'A : P' ⊆ densitySet A) (hzP' : z ∈ closure P') {p p' : ℂ} (hp : p ∈ P)
    (hpy : dist p y < 1) (hp' : p' ∈ P') (hp'y : 1 < dist p' y) : False := by
  have hε : 0 < min (1 - dist p y) (dist p' y - 1) := lt_min (by linarith) (by linarith)
  obtain ⟨q, hqd, hqy, hqz⟩ :
      ∃ q ∈ densitySet A, dist q y < min (1 - dist p y) (dist p' y - 1) ∧ dist q z ≠ 1 := by
    by_contra hcon
    push Not at hcon
    have hsub : A ∩ ball y (min (1 - dist p y) (dist p' y - 1)) ⊆ (A \ densitySet A) ∪ sphere z 1 := by
      rintro q ⟨hqA, hqb⟩
      by_cases hqd : q ∈ densitySet A
      · exact Or.inr (mem_sphere.2 (hcon q hqd (mem_ball.1 hqb)))
      · exact Or.inl ⟨hqA, hqd⟩
    exact (hy _ hε).ne' (measure_mono_null hsub
      (measure_union_null (volume_diff_densitySet hA) (Measure.addHaar_sphere volume z 1)))
  have hq : 0 < upperDensityAt A q := upperDensityAt_pos_of_mem_densitySet hqd
  have h1 : dist q p < 1 := by
    have t1 := dist_triangle q y p
    have t2 := min_le_left (1 - dist p y) (dist p' y - 1)
    rw [dist_comm y p] at t1
    linarith
  have h2 : 1 < dist q p' := by
    have t1 := dist_triangle p' q y
    have t2 := min_le_right (1 - dist p y) (dist p' y - 1)
    rw [dist_comm p' q] at t1
    linarith
  have hin : ∀ w ∈ P, dist q w < 1 :=
    (hullset hA hnull hP hPA hq).resolve_right fun h => by have := h p hp; linarith
  have hout : ∀ w ∈ P', 1 < dist q w :=
    (hullset hA hnull hP' hP'A hq).resolve_left fun h => by have := h p' hp'; linarith
  have hz1 : dist q z ≤ 1 :=
    closure_minimal (t := {w | dist q w ≤ 1}) (fun w hw => (hin w hw).le)
      (isClosed_le (continuous_const.dist continuous_id) continuous_const) hzP
  have hz2 : 1 ≤ dist q z :=
    closure_minimal (t := {w | 1 ≤ dist q w}) (fun w hw => (hout w hw).le)
      (isClosed_le continuous_const (continuous_const.dist continuous_id)) hzP'
  exact hqz (le_antisymm hz1 hz2)

/-- **FS121-V2's Lemma H** (both in or both out): two preconnected pieces of the density set of a measurable set `A`
with null unit pairs, each with `z` in its closure, lie both in the closed unit disc about a point `y` of the support
of `A`, or both outside the open one. -/
theorem in_in_or_out_out {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {y z : ℂ}
    (hy : y ∈ essSupport A) {P P' : Set ℂ} (hP : IsPreconnected P) (hPA : P ⊆ densitySet A) (hzP : z ∈ closure P)
    (hP' : IsPreconnected P') (hP'A : P' ⊆ densitySet A) (hzP' : z ∈ closure P') :
    (P ⊆ closedBall y 1 ∧ P' ⊆ closedBall y 1) ∨ (Disjoint P (ball y 1) ∧ Disjoint P' (ball y 1)) := by
  have hy' : y ∈ closure (densitySet A) := by rw [← essSupport_eq_closure_densitySet]; exact hy
  rcases half_dichotomy hA hnull hy' hP hPA with h1 | h1 <;>
    rcases half_dichotomy hA hnull hy' hP' hP'A with h2 | h2
  · exact Or.inl ⟨h1, h2⟩
  · by_cases hp : ∃ p ∈ P, dist p y < 1
    · by_cases hp' : ∃ p' ∈ P', 1 < dist p' y
      · obtain ⟨p, hpP, hpy⟩ := hp
        obtain ⟨p', hp'P, hp'y⟩ := hp'
        exact (false_of_inside_of_outside hA hnull hy hP hPA hzP hP' hP'A hzP' hpP hpy hp'P hp'y).elim
      · push Not at hp'
        exact Or.inl ⟨h1, fun w hw => mem_closedBall.2 (hp' w hw)⟩
    · push Not at hp
      exact Or.inr ⟨Set.disjoint_left.2 fun w hw hb => absurd (mem_ball.1 hb) (not_lt.2 (hp w hw)), h2⟩
  · by_cases hp' : ∃ p' ∈ P', dist p' y < 1
    · by_cases hp : ∃ p ∈ P, 1 < dist p y
      · obtain ⟨p, hpP, hpy⟩ := hp
        obtain ⟨p', hp'P, hp'y⟩ := hp'
        exact (false_of_inside_of_outside hA hnull hy hP' hP'A hzP' hP hPA hzP hp'P hp'y hpP hpy).elim
      · push Not at hp
        exact Or.inl ⟨fun w hw => mem_closedBall.2 (hp w hw), h2⟩
    · push Not at hp'
      exact Or.inr ⟨h1, Set.disjoint_left.2 fun w hw hb => absurd (mem_ball.1 hb) (not_lt.2 (hp' w hw))⟩
  · exact Or.inr ⟨h1, h2⟩

/-- `z + 1 · w = z + w`, for a sign carried as a real number. -/
theorem add_ofReal_one_mul (z w : ℂ) : z + ((1 : ℝ) : ℂ) * w = z + w := by rw [Complex.ofReal_one, one_mul]

/-- `z + (−1) · w = z − w`, for a sign carried as a real number. -/
theorem add_ofReal_neg_one_mul (z w : ℂ) : z + ((-1 : ℝ) : ℂ) * w = z - w := by
  rw [Complex.ofReal_neg, Complex.ofReal_one, neg_one_mul, sub_eq_add_neg]

/-- The squared distance from the polar point `z + t e(θ)` to the centre `z + σ i e(δ)`, `σ = ±1`. -/
theorem dist_sq_polarPt_add_sign (z : ℂ) (t θ δ : ℝ) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) :
    dist (polarPt z t θ) (z + (σ : ℂ) * (I * e δ)) ^ 2 = 1 + t ^ 2 - 2 * t * σ * Real.sin (θ - δ) := by
  rcases hσ with rfl | rfl
  · rw [add_ofReal_one_mul, dist_sq_polarPt_add_I]; ring
  · rw [add_ofReal_neg_one_mul, dist_sq_polarPt_sub_I]; ring

/-- A polar point outside the open unit disc about `z + σ i e(δ)`. -/
theorem two_mul_sin_le_of_one_le_dist {z : ℂ} {t θ δ σ : ℝ} (ht : 0 < t) (hσ : σ = 1 ∨ σ = -1)
    (h : 1 ≤ dist (polarPt z t θ) (z + (σ : ℂ) * (I * e δ))) : 2 * σ * Real.sin (θ - δ) ≤ t := by
  have h1 := dist_sq_polarPt_add_sign z t θ δ hσ
  have h2 : 1 ≤ dist (polarPt z t θ) (z + (σ : ℂ) * (I * e δ)) ^ 2 := by nlinarith
  rw [h1] at h2
  by_contra hlt
  rw [not_le] at hlt
  nlinarith [mul_pos ht (sub_pos.2 hlt)]

/-- A polar point in the closed unit disc about `z + σ i e(δ)`. -/
theorem le_two_mul_sin_of_dist_le_one {z : ℂ} {t θ δ σ : ℝ} (ht : 0 < t) (hσ : σ = 1 ∨ σ = -1)
    (h : dist (polarPt z t θ) (z + (σ : ℂ) * (I * e δ)) ≤ 1) : t ≤ 2 * σ * Real.sin (θ - δ) := by
  have h1 := dist_sq_polarPt_add_sign z t θ δ hσ
  have h2 : dist (polarPt z t θ) (z + (σ : ℂ) * (I * e δ)) ^ 2 ≤ 1 := by
    nlinarith [dist_nonneg (x := polarPt z t θ) (y := z + (σ : ℂ) * (I * e δ))]
  rw [h1] at h2
  by_contra hlt
  rw [not_le] at hlt
  nlinarith [mul_pos ht (sub_pos.2 hlt)]

/-- Where `cos x > 0`, a small step `s η`, `s = ±1`, moves `sin` in the direction of `s`. -/
theorem eventually_sin_add_mul_gt {x : ℝ} (hx : 0 < Real.cos x) {s : ℝ} (hs : s = 1 ∨ s = -1) :
    ∀ᶠ η in 𝓝[>] (0 : ℝ), 0 < s * (Real.sin (x + s * η) - Real.sin x) := by
  have hc : ContinuousAt (fun η : ℝ => Real.cos (x + s * η / 2)) 0 := by fun_prop
  have h0 : 0 < (fun η : ℝ => Real.cos (x + s * η / 2)) 0 := by simpa using hx
  have e1 : ∀ᶠ η in 𝓝[>] (0 : ℝ), 0 < Real.cos (x + s * η / 2) :=
    nhdsWithin_le_nhds (hc.eventually (lt_mem_nhds h0))
  filter_upwards [e1, Ioo_mem_nhdsGT Real.pi_pos] with η h1 hη
  have hsin : 0 < Real.sin (η / 2) :=
    Real.sin_pos_of_pos_of_lt_pi (by linarith [hη.1]) (by linarith [hη.2, Real.pi_pos])
  have hss : Real.sin (x + s * η) - Real.sin x = 2 * Real.sin (s * η / 2) * Real.cos (x + s * η / 2) := by
    rw [Real.sin_sub_sin]; ring_nf
  rw [hss]
  rcases hs with rfl | rfl
  · rw [one_mul] at h1 ⊢
    rw [one_mul]
    positivity
  · have h2 : Real.sin (-1 * η / 2) = -Real.sin (η / 2) := by
      rw [show -1 * η / 2 = -(η / 2) by ring, Real.sin_neg]
    rw [h2]
    nlinarith [mul_pos hsin h1]

/-- **The angular lemma** (FS121-V2 §§ 2.2–2.3 (i)): a region with limit directions `a' ≤ b'`, beyond the sector
`(α, β)` in the cyclic order, whose mid-direction `m` has `sin (m − β) ≤ 0` and `sin (m − α) ≥ 0`, has zero angle and
is tangent to one of the sector's two edges. -/
theorem horn_of_sin_constraints {α β a' b' : ℝ} (hαβ : α < β) (hab : a' ≤ b')
    (hF1 : Real.sin ((a' + b') / 2 - β) ≤ 0) (hF2 : 0 ≤ Real.sin ((a' + b') / 2 - α))
    (hrange : (β ≤ a' ∧ b' ≤ α + 2 * Real.pi) ∨ (b' ≤ α ∧ β ≤ a' + 2 * Real.pi)) :
    a' = b' ∧ (a' = β ∨ a' = β - 2 * Real.pi ∨ a' = α ∨ a' = α + 2 * Real.pi) := by
  have hpi := Real.pi_pos
  rcases hrange with ⟨h1, h2⟩ | ⟨h1, h2⟩
  · by_cases h3 : (a' + b') / 2 - β ≤ 0
    · exact ⟨by linarith, Or.inl (by linarith)⟩
    · rw [not_le] at h3
      have h4 : Real.pi ≤ (a' + b') / 2 - β := by
        by_contra h
        rw [not_le] at h
        linarith [Real.sin_pos_of_pos_of_lt_pi h3 h]
      have h5 : 2 * Real.pi ≤ (a' + b') / 2 - α := by
        by_contra h
        rw [not_le] at h
        have h6 := Real.sin_neg_of_neg_of_neg_pi_lt (x := (a' + b') / 2 - α - 2 * Real.pi) (by linarith)
          (by linarith)
        rw [Real.sin_sub_two_pi] at h6
        linarith
      exact ⟨by linarith, Or.inr (Or.inr (Or.inr (by linarith)))⟩
  · by_cases h3 : 0 ≤ (a' + b') / 2 - α
    · exact ⟨by linarith, Or.inr (Or.inr (Or.inl (by linarith)))⟩
    · rw [not_le] at h3
      have h4 : (a' + b') / 2 - α ≤ -Real.pi := by
        by_contra h
        rw [not_le] at h
        linarith [Real.sin_neg_of_neg_of_neg_pi_lt h3 h]
      have h5 : (a' + b') / 2 - β ≤ -(2 * Real.pi) := by
        by_contra h
        rw [not_le] at h
        have h6 := Real.sin_pos_of_pos_of_lt_pi (x := (a' + b') / 2 - β + 2 * Real.pi) (by linarith) (by linarith)
        rw [Real.sin_add_two_pi] at h6
        linarith
      exact ⟨by linarith, Or.inr (Or.inl (by linarith))⟩
--END-ROOT

namespace AeColouring

variable {c : AeColouring k} {z : ℂ}

namespace Fan

variable (F : c.Fan z)

--BEGIN-FAN
/-! ### One sector per colour (FS131-I6E; FS121-V2 §§ 2.2–2.3) -/

/-- The limit directions are in counter-clockwise order, weakly. -/
theorem dir_le_dir {a b : Fin F.n} (h : a ≤ b) : F.dir a ≤ F.dir b := by
  refine le_of_tendsto_of_tendsto (F.tendsto a) (F.tendsto b) ?_
  filter_upwards [Ioo_mem_nhdsGT F.r_pos] with t ht
  exact (F.mono t ht).monotone h

/-- The limit directions lie within one turn, weakly. -/
theorem dir_le_dir_add_two_pi (a b : Fin F.n) : F.dir a ≤ F.dir b + 2 * Real.pi := by
  refine le_of_tendsto_of_tendsto (F.tendsto a) ((F.tendsto b).add_const _) ?_
  filter_upwards [Ioo_mem_nhdsGT F.r_pos] with t ht
  exact (F.wrap t ht a b).le

/-- A region ends before any later branch starts. -/
theorem nextDir_le_dir {a b : Fin F.n} (h : a < b) : F.nextDir a ≤ F.dir b := by
  have hlt : (a : ℕ) + 1 < F.n := lt_of_le_of_lt (Nat.succ_le_of_lt (Fin.lt_def.1 h)) b.2
  rw [nextDir, cyclicNext_of_lt _ hlt]
  exact F.dir_le_dir (Fin.le_def.2 (Nat.succ_le_of_lt (Fin.lt_def.1 h)))

/-- A region ends within one turn of any branch. -/
theorem nextDir_le_dir_add_two_pi (a b : Fin F.n) : F.nextDir a ≤ F.dir b + 2 * Real.pi := by
  by_cases hlt : (a : ℕ) + 1 < F.n
  · rw [nextDir, cyclicNext_of_lt _ hlt]
    exact F.dir_le_dir_add_two_pi _ b
  · rw [nextDir, cyclicNext_of_not_lt _ hlt]
    show F.dir ⟨0, a.pos⟩ + 2 * Real.pi ≤ F.dir b + 2 * Real.pi
    have := F.dir_le_dir (a := ⟨0, a.pos⟩) (b := b) (Fin.le_def.2 (Nat.zero_le _))
    linarith

/-- The branch before `i`, clockwise: the index `branch_contacts` and `col_ne` read beside `i`. -/
theorem exists_pred (i : Fin F.n) : ∃ j : Fin F.n, (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n) := by
  by_cases h : (i : ℕ) = 0
  · exact ⟨⟨F.n - 1, Nat.sub_lt i.pos one_pos⟩, Or.inr ⟨h, Nat.sub_add_cancel i.pos⟩⟩
  · exact ⟨⟨(i : ℕ) - 1, lt_of_le_of_lt (Nat.sub_le _ _) i.2⟩,
      Or.inl (Nat.sub_add_cancel (Nat.pos_of_ne_zero h))⟩

/-- The branch after `i`, counter-clockwise, whose limit direction is `nextDir i` up to a turn. -/
theorem exists_succ (i : Fin F.n) :
    ∃ b : Fin F.n, ((i : ℕ) + 1 = b ∨ ((b : ℕ) = 0 ∧ (i : ℕ) + 1 = F.n)) ∧
      (F.nextDir i = F.dir b ∨ F.nextDir i = F.dir b + 2 * Real.pi) := by
  by_cases h : (i : ℕ) + 1 < F.n
  · exact ⟨⟨i + 1, h⟩, Or.inl rfl, Or.inl (by rw [nextDir, cyclicNext_of_lt _ h])⟩
  · exact ⟨⟨0, i.pos⟩, Or.inr ⟨rfl, by have := i.2; omega⟩, Or.inr (by rw [nextDir, cyclicNext_of_not_lt _ h])⟩

/-- **A contact of a region's colour on the normal of its counter-clockwise edge** at `z` (FS121-V2's Lemma T (ii),
from `branch_contacts` at the branch after `i`). -/
theorem exists_contact_nextDir (hsat : SaturatedOn c.cls (ball z F.r \ {z})) (i : Fin F.n) :
    ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ z + (σ : ℂ) * (I * e (F.nextDir i)) ∈ essSupport (c.cls (F.col i)) := by
  obtain ⟨b, hb, hdir⟩ := F.exists_succ i
  have he : e (F.nextDir i) = e (F.dir b) := by
    rcases hdir with h | h
    · rw [h]
    · rw [h, e_add_two_pi]
  rcases F.branch_contacts hsat hb with ⟨y, hy | hy, hyj, -, -⟩ | ⟨h1, -⟩
  · exact ⟨1, Or.inl rfl, by rw [add_ofReal_one_mul, he, ← hy]; exact hyj⟩
  · exact ⟨-1, Or.inr rfl, by rw [add_ofReal_neg_one_mul, he, ← hy]; exact hyj⟩
  · exact ⟨1, Or.inl rfl, by rw [add_ofReal_one_mul, he]; exact h1⟩

/-- **A contact of a region's colour on the normal of its clockwise edge** at `z` (FS121-V2's Lemma T (ii), from
`branch_contacts` at branch `i`). -/
theorem exists_contact_dir (hsat : SaturatedOn c.cls (ball z F.r \ {z})) (i : Fin F.n) :
    ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ z + (σ : ℂ) * (I * e (F.dir i)) ∈ essSupport (c.cls (F.col i)) := by
  obtain ⟨j, hj⟩ := F.exists_pred i
  rcases F.branch_contacts hsat hj with ⟨y, hy | hy, -, hyi, -⟩ | ⟨-, h2⟩
  · exact ⟨1, Or.inl rfl, by rw [add_ofReal_one_mul, ← hy]; exact hyi⟩
  · exact ⟨-1, Or.inr rfl, by rw [add_ofReal_neg_one_mul, ← hy]; exact hyi⟩
  · exact ⟨-1, Or.inr rfl, by rw [add_ofReal_neg_one_mul]; exact h2⟩

/-- **The side of a sector** (FS121-V2's Lemma H, read at a region of positive angle): let region `i` hold the
initial part of the ray `θ₀`, on the side `τ = ±1` of the direction `δ` (`τ sin (θ₀ − δ) > 0`), and let
`y = z + σ i e(δ)`, `σ = ±1`, be in the support of the region's colour. Then every preconnected piece of that colour's
density set with `z` in its closure lies in the closed unit disc about `y` if `σ = τ`, and misses the open one if
`σ = −τ`. -/
theorem sector_side {i : Fin F.n} {θ₀ δ τ σ : ℝ} (h1 : F.dir i < θ₀) (h2 : θ₀ < F.nextDir i)
    (hτ : τ = 1 ∨ τ = -1) (hpos : 0 < τ * Real.sin (θ₀ - δ)) (hσ : σ = 1 ∨ σ = -1)
    (hy : z + (σ : ℂ) * (I * e δ) ∈ essSupport (c.cls (F.col i))) {P' : Set ℂ} (hP' : IsPreconnected P')
    (hP'A : P' ⊆ densitySet (c.cls (F.col i))) (hzP' : z ∈ closure P') :
    (σ = τ → P' ⊆ closedBall (z + (σ : ℂ) * (I * e δ)) 1) ∧
      (σ = -τ → Disjoint P' (ball (z + (σ : ℂ) * (I * e δ)) 1)) := by
  obtain ⟨ε, hε, hray⟩ := F.exists_ray_subset_cell i h1 h2
  rcases in_in_or_out_out (c.measurableSet_cls _) (c.unitPairsNull _) hy (F.isPreconnected_cell i)
    (F.cell_subset_densitySet i) (F.mem_closure_polarRegion_of_le i F.r_pos le_rfl) hP' hP'A hzP' with
    ⟨hin, hin'⟩ | ⟨hout, hout'⟩
  · have ht : ε / 2 ∈ Ioo 0 ε := ⟨half_pos hε, half_lt_self hε⟩
    have h3 := le_two_mul_sin_of_dist_le_one ht.1 hσ (mem_closedBall.1 (hin (hray _ ht)))
    have h4 : 0 < σ * Real.sin (θ₀ - δ) := by nlinarith [ht.1]
    refine ⟨fun _ => hin', fun hστ => ?_⟩
    rw [hστ] at h4
    linarith
  · refine ⟨fun hστ => ?_, fun _ => hout'⟩
    exfalso
    rw [hστ] at hout
    have hpos2 : 0 < 2 * τ * Real.sin (θ₀ - δ) := by linarith
    have hm : 0 < min ε (2 * τ * Real.sin (θ₀ - δ)) := lt_min hε hpos2
    have htI : min ε (2 * τ * Real.sin (θ₀ - δ)) / 2 ∈ Ioo 0 ε :=
      ⟨half_pos hm, by have := min_le_left ε (2 * τ * Real.sin (θ₀ - δ)); linarith⟩
    have hnb : polarPt z (min ε (2 * τ * Real.sin (θ₀ - δ)) / 2) θ₀ ∉ ball (z + (τ : ℂ) * (I * e δ)) 1 :=
      Set.disjoint_left.1 hout (hray _ htI)
    rw [mem_ball, not_lt] at hnb
    have h3 := two_mul_sin_le_of_one_le_dist htI.1 hτ hnb
    have h4 := min_le_right ε (2 * τ * Real.sin (θ₀ - δ))
    linarith

/-- The side of a sector, at its counter-clockwise edge: with a contact `z + σ i e(nextDir i)` of the sector's colour,
every piece of that colour at `z` lies in the closed unit disc about it if `σ = −1` and misses the open one if
`σ = 1`. -/
theorem sector_side_next {i : Fin F.n} (hi : F.dir i < F.nextDir i) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1)
    (hy : z + (σ : ℂ) * (I * e (F.nextDir i)) ∈ essSupport (c.cls (F.col i))) {P' : Set ℂ}
    (hP' : IsPreconnected P') (hP'A : P' ⊆ densitySet (c.cls (F.col i))) (hzP' : z ∈ closure P') :
    (σ = -1 → P' ⊆ closedBall (z + (σ : ℂ) * (I * e (F.nextDir i))) 1) ∧
      (σ = 1 → Disjoint P' (ball (z + (σ : ℂ) * (I * e (F.nextDir i))) 1)) := by
  have hpi := Real.pi_pos
  have hm : 0 < min (F.nextDir i - F.dir i) Real.pi := lt_min (sub_pos.2 hi) hpi
  have hη1 := min_le_left (F.nextDir i - F.dir i) Real.pi
  have hη2 := min_le_right (F.nextDir i - F.dir i) Real.pi
  have hsin : 0 < (-1 : ℝ) * Real.sin (F.nextDir i - min (F.nextDir i - F.dir i) Real.pi / 2 - F.nextDir i) := by
    rw [show F.nextDir i - min (F.nextDir i - F.dir i) Real.pi / 2 - F.nextDir i =
      -(min (F.nextDir i - F.dir i) Real.pi / 2) by ring, Real.sin_neg]
    have := Real.sin_pos_of_pos_of_lt_pi (half_pos hm) (by linarith)
    linarith
  have h := F.sector_side (θ₀ := F.nextDir i - min (F.nextDir i - F.dir i) Real.pi / 2) (δ := F.nextDir i)
    (τ := -1) (by linarith) (by linarith) (Or.inr rfl) hsin hσ hy hP' hP'A hzP'
  exact ⟨h.1, fun h1 => h.2 (by rw [h1]; norm_num)⟩

/-- The side of a sector, at its clockwise edge: with a contact `z + σ i e(dir i)` of the sector's colour, every
piece of that colour at `z` lies in the closed unit disc about it if `σ = 1` and misses the open one if `σ = −1`. -/
theorem sector_side_dir {i : Fin F.n} (hi : F.dir i < F.nextDir i) {σ : ℝ} (hσ : σ = 1 ∨ σ = -1)
    (hy : z + (σ : ℂ) * (I * e (F.dir i)) ∈ essSupport (c.cls (F.col i))) {P' : Set ℂ}
    (hP' : IsPreconnected P') (hP'A : P' ⊆ densitySet (c.cls (F.col i))) (hzP' : z ∈ closure P') :
    (σ = 1 → P' ⊆ closedBall (z + (σ : ℂ) * (I * e (F.dir i))) 1) ∧
      (σ = -1 → Disjoint P' (ball (z + (σ : ℂ) * (I * e (F.dir i))) 1)) := by
  have hpi := Real.pi_pos
  have hm : 0 < min (F.nextDir i - F.dir i) Real.pi := lt_min (sub_pos.2 hi) hpi
  have hη1 := min_le_left (F.nextDir i - F.dir i) Real.pi
  have hη2 := min_le_right (F.nextDir i - F.dir i) Real.pi
  have hsin : 0 < (1 : ℝ) * Real.sin (F.dir i + min (F.nextDir i - F.dir i) Real.pi / 2 - F.dir i) := by
    rw [show F.dir i + min (F.nextDir i - F.dir i) Real.pi / 2 - F.dir i =
      min (F.nextDir i - F.dir i) Real.pi / 2 by ring, one_mul]
    exact Real.sin_pos_of_pos_of_lt_pi (half_pos hm) (by linarith)
  exact F.sector_side (θ₀ := F.dir i + min (F.nextDir i - F.dir i) Real.pi / 2) (δ := F.dir i)
    (τ := 1) (by linarith) (by linarith) (Or.inl rfl) hsin hσ hy hP' hP'A hzP'

/-- **Where a second piece of a sector's colour can lie** (FS121-V2 § 2.2, both edges): under saturation, every
preconnected piece of the density set of the colour of a region `i` of positive angle, with `z` in its closure, misses
the open unit disc tangent at `z` beyond the region's counter-clockwise edge (about `z + i e(nextDir i)`) and the one
beyond its clockwise edge (about `z − i e(dir i)`); in polar form. -/
theorem sector_constraints (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i : Fin F.n}
    (hi : F.dir i < F.nextDir i) {P' : Set ℂ} (hP' : IsPreconnected P')
    (hP'A : P' ⊆ densitySet (c.cls (F.col i))) (hzP' : z ∈ closure P') :
    (∀ t θ, 0 < t → polarPt z t θ ∈ P' → 2 * Real.sin (θ - F.nextDir i) ≤ t) ∧
      (∀ t θ, 0 < t → polarPt z t θ ∈ P' → -t ≤ 2 * Real.sin (θ - F.dir i)) := by
  obtain ⟨σ, hσ, hy⟩ := F.exists_contact_nextDir hsat i
  obtain ⟨σ', hσ', hy'⟩ := F.exists_contact_dir hsat i
  have h1 := F.sector_side_next hi hσ hy hP' hP'A hzP'
  have h2 := F.sector_side_dir hi hσ' hy' hP' hP'A hzP'
  refine ⟨fun t θ ht hw => ?_, fun t θ ht hw => ?_⟩
  · rcases hσ with rfl | rfl
    · have h3 : polarPt z t θ ∉ ball (z + ((1 : ℝ) : ℂ) * (I * e (F.nextDir i))) 1 :=
        Set.disjoint_left.1 (h1.2 rfl) hw
      rw [mem_ball, not_lt] at h3
      have := two_mul_sin_le_of_one_le_dist ht (Or.inl rfl) h3
      linarith
    · have := le_two_mul_sin_of_dist_le_one ht (Or.inr rfl) (mem_closedBall.1 (h1.1 rfl hw))
      linarith
  · rcases hσ' with rfl | rfl
    · have := le_two_mul_sin_of_dist_le_one ht (Or.inl rfl) (mem_closedBall.1 (h2.1 rfl hw))
      linarith
    · have h3 : polarPt z t θ ∉ ball (z + ((-1 : ℝ) : ℂ) * (I * e (F.dir i))) 1 :=
        Set.disjoint_left.1 (h2.2 rfl) hw
      rw [mem_ball, not_lt] at h3
      have := two_mul_sin_le_of_one_le_dist ht (Or.inr rfl) h3
      linarith

/-- **A cell beside a branch is on neither wrong side of the branch's two tangent unit discs** (FS121-V2 § 2.3 (ii),
the comparison): let the points `z + t e(φ b t + s η)`, small `t, η > 0`, of the side `s = ±1` of branch `b` lie in
`W`. Then `W` is not inside the closed unit disc about `z − s i e(dir b)` (the branch stays outside the open one:
`branch_outside_discs`); and if the branch is an arc of the unit circle about `z + s i e(dir b)`, `W` does not miss
that open disc. -/
theorem horn_false (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {b : Fin F.n} {s ς : ℝ} (hs : s = 1 ∨ s = -1)
    (hς : ς = 1 ∨ ς = -1) {W : Set ℂ}
    (hW : ∀ᶠ t in 𝓝[>] (0 : ℝ), ∀ᶠ η in 𝓝[>] (0 : ℝ), polarPt z t (F.φ b t + s * η) ∈ W)
    (hin : ς = -s → W ⊆ closedBall (z + (ς : ℂ) * (I * e (F.dir b))) 1)
    (hout : ς = s → Disjoint W (ball (z + (ς : ℂ) * (I * e (F.dir b))) 1) ∧
      ∀ t ∈ Ioo 0 (min F.r (1 / 2)), dist (polarPt z t (F.φ b t)) (z + (ς : ℂ) * (I * e (F.dir b))) = 1) :
    False := by
  have hR0 : 0 < min F.r (1 / 2) := lt_min F.r_pos (by norm_num)
  have hcos : ∀ᶠ t in 𝓝[>] (0 : ℝ), 0 < Real.cos (F.φ b t - F.dir b) := by
    have h1 : Tendsto (fun t => Real.cos (F.φ b t - F.dir b)) (𝓝[>] 0) (𝓝 (Real.cos (F.dir b - F.dir b))) :=
      (Real.continuous_cos.tendsto _).comp ((F.tendsto b).sub_const (F.dir b))
    exact h1.eventually (lt_mem_nhds (by rw [sub_self, Real.cos_zero]; exact one_pos))
  obtain ⟨t, ⟨htW, htcos⟩, htR⟩ := ((hW.and hcos).and (Ioo_mem_nhdsGT hR0)).exists
  obtain ⟨η, hη1, hη2⟩ := (htW.and (eventually_sin_add_mul_gt htcos hs)).exists
  have hbr := F.branch_outside_discs hsat b htR
  have hbrς : 1 ≤ dist (polarPt z t (F.φ b t)) (z + (ς : ℂ) * (I * e (F.dir b))) := by
    rcases hς with rfl | rfl
    · rw [add_ofReal_one_mul]; exact hbr.1
    · rw [add_ofReal_neg_one_mul]; exact hbr.2
  have hb1 := two_mul_sin_le_of_one_le_dist htR.1 hς hbrς
  have hθ : F.φ b t + s * η - F.dir b = F.φ b t - F.dir b + s * η := by ring
  by_cases hςs : ς = s
  · obtain ⟨hdisj, hsph⟩ := hout hςs
    have hle := le_two_mul_sin_of_dist_le_one htR.1 hς (hsph t htR).le
    have hnb : polarPt z t (F.φ b t + s * η) ∉ ball (z + (ς : ℂ) * (I * e (F.dir b))) 1 :=
      Set.disjoint_left.1 hdisj hη1
    rw [mem_ball, not_lt] at hnb
    have h3 := two_mul_sin_le_of_one_le_dist htR.1 hς hnb
    rw [hθ] at h3
    rw [hςs] at h3 hle
    nlinarith
  · have hςs' : ς = -s := by
      rcases hς with rfl | rfl <;> rcases hs with rfl | rfl
      · exact absurd rfl hςs
      · norm_num
      · rfl
      · exact absurd rfl hςs
    have h3 := le_two_mul_sin_of_dist_le_one htR.1 hς (mem_closedBall.1 (hin hςs' hη1))
    rw [hθ] at h3
    rw [hςs'] at h3 hb1
    nlinarith

/-- **No zero-angle region of a sector's colour is tangent to the sector's counter-clockwise edge** (FS121-V2 § 2.3
(ii)): the region's clockwise branch gives a contact of the colour on the normal at `z`, on which the sector and the
region are on opposite sides. -/
theorem false_of_horn_next (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i i' : Fin F.n}
    (hi : F.dir i < F.nextDir i) (hcol : F.col i = F.col i') (he : e (F.dir i') = e (F.nextDir i)) : False := by
  obtain ⟨j', hj'⟩ := F.exists_pred i'
  have hW₂A : F.cell i' ⊆ densitySet (c.cls (F.col i)) := by rw [hcol]; exact F.cell_subset_densitySet i'
  have hzW₂ : z ∈ closure (F.cell i') := F.mem_closure_polarRegion_of_le i' F.r_pos le_rfl
  have hW : ∀ᶠ t in 𝓝[>] (0 : ℝ), ∀ᶠ η in 𝓝[>] (0 : ℝ), polarPt z t (F.φ i' t + (1 : ℝ) * η) ∈ F.cell i' := by
    filter_upwards [Ioo_mem_nhdsGT F.r_pos] with t ht
    filter_upwards [Ioo_mem_nhdsGT (sub_pos.2 (F.φ_lt_cyclicNext i' ht))] with η hη
    exact ⟨t, ht, _, ⟨by linarith [hη.1], by linarith [hη.2]⟩, rfl⟩
  have hneg : z - I * e (F.dir i') ∈ essSupport (c.cls (F.col i')) → False := by
    intro hy
    have hy' : z + ((-1 : ℝ) : ℂ) * (I * e (F.nextDir i)) ∈ essSupport (c.cls (F.col i)) := by
      rw [add_ofReal_neg_one_mul, ← he, hcol]; exact hy
    have h := (F.sector_side_next hi (Or.inr rfl) hy' (F.isPreconnected_cell i') hW₂A hzW₂).1 rfl
    rw [← he] at h
    exact F.horn_false hsat (b := i') (Or.inl rfl) (Or.inr rfl) hW (fun _ => h) fun h1 => absurd h1 (by norm_num)
  rcases F.branch_contacts hsat hj' with ⟨y, hy | hy, -, hyi, hall⟩ | ⟨-, h2⟩
  · have hy' : z + ((1 : ℝ) : ℂ) * (I * e (F.nextDir i)) ∈ essSupport (c.cls (F.col i)) := by
      rw [add_ofReal_one_mul, ← he, hcol, ← hy]; exact hyi
    have h := (F.sector_side_next hi (Or.inl rfl) hy' (F.isPreconnected_cell i') hW₂A hzW₂).2 rfl
    rw [← he] at h
    refine F.horn_false hsat (b := i') (Or.inl rfl) (Or.inl rfl) hW (fun h1 => absurd h1 (by norm_num))
      fun _ => ⟨h, fun t ht => ?_⟩
    rw [add_ofReal_one_mul, ← hy]; exact hall t ht
  · exact hneg (hy ▸ hyi)
  · exact hneg h2

/-- **No zero-angle region of a sector's colour is tangent to the sector's clockwise edge** (FS121-V2 § 2.3 (ii)):
the region's counter-clockwise branch gives a contact of the colour on the normal at `z`, on which the sector and the
region are on opposite sides. -/
theorem false_of_horn_dir (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i i' : Fin F.n}
    (hi : F.dir i < F.nextDir i) (hcol : F.col i = F.col i') (he : e (F.nextDir i') = e (F.dir i)) : False := by
  obtain ⟨b, hb, hdir⟩ := F.exists_succ i'
  have heb : e (F.dir b) = e (F.dir i) := by
    rcases hdir with h | h
    · rw [← h, he]
    · rw [← he, h, e_add_two_pi]
  obtain ⟨lo, -, hlt, hreg⟩ := F.exists_lower_of_pred hb
  have hW₂A : F.cell i' ⊆ densitySet (c.cls (F.col i)) := by rw [hcol]; exact F.cell_subset_densitySet i'
  have hzW₂ : z ∈ closure (F.cell i') := F.mem_closure_polarRegion_of_le i' F.r_pos le_rfl
  have hW : ∀ᶠ t in 𝓝[>] (0 : ℝ), ∀ᶠ η in 𝓝[>] (0 : ℝ), polarPt z t (F.φ b t + (-1 : ℝ) * η) ∈ F.cell i' := by
    filter_upwards [Ioo_mem_nhdsGT F.r_pos] with t ht
    filter_upwards [Ioo_mem_nhdsGT (sub_pos.2 (hlt t ht))] with η hη
    rw [cell, ← hreg F.r]
    exact ⟨t, ht, _, ⟨by linarith [hη.2], by linarith [hη.1]⟩, rfl⟩
  have hpos : z + I * e (F.dir b) ∈ essSupport (c.cls (F.col i')) → False := by
    intro hy
    have hy' : z + ((1 : ℝ) : ℂ) * (I * e (F.dir i)) ∈ essSupport (c.cls (F.col i)) := by
      rw [add_ofReal_one_mul, ← heb, hcol]; exact hy
    have h := (F.sector_side_dir hi (Or.inl rfl) hy' (F.isPreconnected_cell i') hW₂A hzW₂).1 rfl
    rw [← heb] at h
    exact F.horn_false hsat (b := b) (Or.inr rfl) (Or.inl rfl) hW (fun _ => h) fun h1 => absurd h1 (by norm_num)
  rcases F.branch_contacts hsat hb with ⟨y, hy | hy, hyj, -, hall⟩ | ⟨h1, -⟩
  · exact hpos (hy ▸ hyj)
  · have hy' : z + ((-1 : ℝ) : ℂ) * (I * e (F.dir i)) ∈ essSupport (c.cls (F.col i)) := by
      rw [add_ofReal_neg_one_mul, ← heb, hcol, ← hy]; exact hyj
    have h := (F.sector_side_dir hi (Or.inr rfl) hy' (F.isPreconnected_cell i') hW₂A hzW₂).2 rfl
    rw [← heb] at h
    refine F.horn_false hsat (b := b) (Or.inr rfl) (Or.inr rfl) hW (fun h1 => absurd h1 (by norm_num))
      fun _ => ⟨h, fun t ht => ?_⟩
    rw [add_ofReal_neg_one_mul, ← hy]; exact hall t ht
  · exact hpos h1
--END-FAN

theorem sector_alone' (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i i' : Fin F.n} (hi : F.dir i < F.nextDir i)
    (hcol : F.col i = F.col i') : i = i' := by
--BEGIN-SECTOR
  by_contra hne
  have hW₂A : F.cell i' ⊆ densitySet (c.cls (F.col i)) := by rw [hcol]; exact F.cell_subset_densitySet i'
  obtain ⟨hCβ, hCα⟩ := F.sector_constraints hsat hi (F.isPreconnected_cell i') hW₂A
    (F.mem_closure_polarRegion_of_le i' F.r_pos le_rfl)
  -- the mid-direction of region `i'`
  have hmid : Tendsto (fun t => (F.φ i' t + cyclicNext F.φ i' t) / 2) (𝓝[>] 0)
      (𝓝 ((F.dir i' + F.nextDir i') / 2)) := ((F.tendsto i').add (F.tendsto_cyclicNext i')).div_const 2
  have hmem : ∀ t ∈ Ioo 0 F.r, polarPt z t ((F.φ i' t + cyclicNext F.φ i' t) / 2) ∈ F.cell i' := fun t ht =>
    ⟨t, ht, _, ⟨by linarith [F.φ_lt_cyclicNext i' ht], by linarith [F.φ_lt_cyclicNext i' ht]⟩, rfl⟩
  have hid : Tendsto (fun t : ℝ => t) (𝓝[>] 0) (𝓝 0) := tendsto_nhdsWithin_of_tendsto_nhds tendsto_id
  have hF1 : Real.sin ((F.dir i' + F.nextDir i') / 2 - F.nextDir i) ≤ 0 := by
    have h1 : Tendsto (fun t => 2 * Real.sin ((F.φ i' t + cyclicNext F.φ i' t) / 2 - F.nextDir i)) (𝓝[>] 0)
        (𝓝 (2 * Real.sin ((F.dir i' + F.nextDir i') / 2 - F.nextDir i))) :=
      ((Real.continuous_sin.tendsto _).comp (hmid.sub_const _)).const_mul 2
    have h3 := le_of_tendsto_of_tendsto h1 hid
      (by filter_upwards [Ioo_mem_nhdsGT F.r_pos] with t ht using hCβ t _ ht.1 (hmem t ht))
    linarith
  have hF2 : 0 ≤ Real.sin ((F.dir i' + F.nextDir i') / 2 - F.dir i) := by
    have h1 : Tendsto (fun t => 2 * Real.sin ((F.φ i' t + cyclicNext F.φ i' t) / 2 - F.dir i)) (𝓝[>] 0)
        (𝓝 (2 * Real.sin ((F.dir i' + F.nextDir i') / 2 - F.dir i))) :=
      ((Real.continuous_sin.tendsto _).comp (hmid.sub_const _)).const_mul 2
    have h3 := le_of_tendsto_of_tendsto hid.neg h1
      (by filter_upwards [Ioo_mem_nhdsGT F.r_pos] with t ht using hCα t _ ht.1 (hmem t ht))
    linarith
  -- region `i'` lies beyond the sector in the cyclic order
  have hrange : (F.nextDir i ≤ F.dir i' ∧ F.nextDir i' ≤ F.dir i + 2 * Real.pi) ∨
      (F.nextDir i' ≤ F.dir i ∧ F.nextDir i ≤ F.dir i' + 2 * Real.pi) := by
    rcases lt_or_gt_of_ne hne with hlt | hgt
    · exact Or.inl ⟨F.nextDir_le_dir hlt, F.nextDir_le_dir_add_two_pi i' i⟩
    · exact Or.inr ⟨F.nextDir_le_dir hgt, F.nextDir_le_dir_add_two_pi i i'⟩
  -- so it is a zero-angle region tangent to one of the sector's edges
  obtain ⟨heq, h | h | h | h⟩ := horn_of_sin_constraints hi (F.dir_le_nextDir i') hF1 hF2 hrange
  · exact F.false_of_horn_next hsat hi hcol (by rw [h])
  · exact F.false_of_horn_next hsat hi hcol
      (by rw [h, ← e_add_two_pi (F.nextDir i - 2 * Real.pi), sub_add_cancel])
  · exact F.false_of_horn_dir hsat hi hcol (by rw [← heq, h])
  · exact F.false_of_horn_dir hsat hi hcol (by rw [← heq, h, e_add_two_pi])
--END-SECTOR

end Fan

end AeColouring

end HadwigerNelson.Plane
