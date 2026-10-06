-- FS131-IX1 iteration scratch for the one-closed generalization (pasted into `Plane/PlaneTopology.lean` with the leaf unprimed); it imports the
-- pre-splice olean and no longer elaborates against the post-splice one (duplicate names).
-- FS131-IX1 iteration scratch: the crossing lemma's children and proof (the leaf as `inter_nonempty_of_interleaved'`), spliced into
-- `Plane/PlaneTopology.lean` by `tools/fs131_ix_splice.py`. Against the post-splice olean it no longer elaborates (duplicate names).
import Proofs.HadwigerNelson.Plane.PlaneTopology
import Mathlib.Topology.MetricSpace.Thickening

namespace HadwigerNelson.Plane

open Complex Real Set Topology Metric

theorem e_mul_e_neg (θ : ℝ) : e θ * e (-θ) = 1 := by
  rw [← e_add, add_neg_cancel]; simp [e]

theorem arg_one_sub_e {x : ℝ} (h0 : 0 < x) (h1 : x < 2 * π) : arg (1 - e x) = (x - π) / 2 := by
  set θ := (x - π) / 2 with hθ
  have hx : x = 2 * θ + π := by rw [hθ]; ring
  have hc : 0 < Real.cos θ := Real.cos_pos_of_mem_Ioo ⟨by rw [hθ]; linarith, by rw [hθ]; linarith⟩
  have key : 1 - e x = ((2 * Real.cos θ : ℝ) : ℂ) * (Complex.cos θ + Complex.sin θ * I) := by
    rw [hx, e_eq, Real.cos_add_pi, Real.sin_add_pi, Real.cos_two_mul, Real.sin_two_mul]
    push_cast; ring
  rw [key, Complex.arg_mul_cos_add_sin_mul_I (by linarith)
    ⟨by rw [hθ]; linarith [Real.pi_pos], by rw [hθ]; linarith⟩]

theorem arg_one_sub_e_of_neg {x : ℝ} (h0 : -(2 * π) < x) (h1 : x < 0) : arg (1 - e x) = (x + π) / 2 := by
  rw [← e_add_two_pi, arg_one_sub_e (by linarith) (by linarith)]; ring

theorem re_pos_of_mem_closedBall {u z : ℂ} (hz : z ∈ closedBall u 1) {θ : ℝ} (hne : z ≠ ringPt u θ) :
    0 < ((ringPt u θ - z) * e (-θ)).re := by
  set w := (z - u) * e (-θ) with hw
  have hwn : ‖w‖ ≤ 1 := by
    rw [hw, norm_mul, norm_e, mul_one, ← dist_eq_norm]; exact hz
  have heq : (ringPt u θ - z) * e (-θ) = 1 - w := by
    rw [hw, ringPt, ← e_mul_e_neg θ]; ring
  rw [heq, sub_re, one_re, sub_pos]
  by_contra hge
  push Not at hge
  have hre : w.re = ‖w‖ := le_antisymm (re_le_norm w) (by linarith)
  have him : w.im = 0 := by
    by_contra h
    have := Complex.abs_re_lt_norm.mpr h
    rw [abs_of_nonneg (by linarith)] at this
    linarith
  have hw1 : w = 1 := Complex.ext (by simp; linarith [re_le_norm w]) (by simp [him])
  apply hne
  have : z - u = e θ := by
    have h2 : (z - u) * e (-θ) * e θ = e θ := by rw [← hw, hw1, one_mul]
    rwa [mul_assoc, mul_comm (e (-θ)), e_mul_e_neg, mul_one] at h2
  rw [ringPt, ← this]; ring

theorem ringPt_sub_ringPt_mul_e_neg (u : ℂ) (a b : ℝ) : (ringPt u a - ringPt u b) * e (-a) = 1 - e (b - a) := by
  rw [ringPt, ringPt, sub_eq_add_neg b a, e_add, ← e_mul_e_neg a]; ring

theorem im_sub_eq_arg_sub {f v : ℝ → ℂ} (hf : ContinuousOn f (Icc 0 1)) (hv : ContinuousOn v (Icc 0 1))
    (hpos : ∀ x ∈ Icc (0 : ℝ) 1, 0 < (v x).re) {κ : ℂ} (hexp : ∀ x ∈ Icc (0 : ℝ) 1, Complex.exp (f x) = κ * v x) :
    (f 1 - f 0).im = arg (v 1) - arg (v 0) := by
  have h0 : (0 : ℝ) ∈ Icc (0 : ℝ) 1 := ⟨le_rfl, zero_le_one⟩
  have h1 : (1 : ℝ) ∈ Icc (0 : ℝ) 1 := ⟨zero_le_one, le_rfl⟩
  have hκ : κ ≠ 0 := by
    rintro rfl
    exact Complex.exp_ne_zero (f 0) (by rw [hexp 0 h0, zero_mul])
  have hv0 : ∀ x ∈ Icc (0 : ℝ) 1, v x ≠ 0 := fun x hx h => by
    have := hpos x hx; rw [h, zero_re] at this; exact lt_irrefl 0 this
  have hslit : ∀ x ∈ Icc (0 : ℝ) 1, v x ∈ slitPlane := fun x hx => mem_slitPlane_iff.mpr (Or.inl (hpos x hx))
  set g : ℝ → ℝ := fun x => (f x - Complex.log (v x) - Complex.log κ).im / (2 * π) with hg
  have hgc : ContinuousOn g (Icc 0 1) := by
    refine ContinuousOn.div_const ?_ _
    exact (Complex.continuous_im.comp_continuousOn ((hf.sub (hv.clog hslit)).sub continuousOn_const))
  have hgint : ∀ x ∈ Icc (0 : ℝ) 1, ∃ n : ℤ, g x = n := by
    intro x hx
    have he : Complex.exp (f x) = Complex.exp (Complex.log κ + Complex.log (v x)) := by
      rw [hexp x hx, Complex.exp_add, Complex.exp_log hκ, Complex.exp_log (hv0 x hx)]
    obtain ⟨n, hn⟩ := Complex.exp_eq_exp_iff_exists_int.mp he
    refine ⟨n, ?_⟩
    simp only [hg, hn]
    have : (Complex.log κ + Complex.log (v x) + ↑n * (2 * ↑π * I) - Complex.log (v x) - Complex.log κ).im
        = n * (2 * π) := by simp; ring
    rw [this]; field_simp
  have := eq_of_intValued_of_isPreconnected isPreconnected_Icc hgc hgint h1 h0
  simp only [hg] at this
  have hπ : (2 * π) ≠ 0 := by positivity
  rw [div_left_inj' hπ] at this
  simp only [sub_im, Complex.log_im] at this
  rw [sub_im]
  linarith

theorem exists_eq_of_interleaved_paths {u : ℂ} {s s' t t' : ℝ} (h₁ : s < s') (h₂ : s' < t) (h₃ : t < t')
    (h₄ : t' < s + 2 * π) (γ : Path (ringPt u s) (ringPt u t)) (γ' : Path (ringPt u s') (ringPt u t'))
    (hγ : ∀ x, γ x ∈ closedBall u 1) (hγ' : ∀ y, γ' y ∈ closedBall u 1) : ∃ x y, γ x = γ' y := by
  by_contra hne
  push Not at hne
  have hext : ∀ r : ℝ, ∃ x, γ x = γ.extend r := fun r => by
    have h : γ.extend r ∈ range γ := γ.extend_range ▸ mem_range_self r
    exact h
  have hext' : ∀ r : ℝ, ∃ y, γ' y = γ'.extend r := fun r => by
    have h : γ'.extend r ∈ range γ' := γ'.extend_range ▸ mem_range_self r
    exact h
  have hD : ∀ r, γ.extend r ∈ closedBall u 1 := fun r => by obtain ⟨x, hx⟩ := hext r; rw [← hx]; exact hγ x
  have hD' : ∀ r, γ'.extend r ∈ closedBall u 1 := fun r => by
    obtain ⟨y, hy⟩ := hext' r; rw [← hy]; exact hγ' y
  have hne' : ∀ r r', γ.extend r ≠ γ'.extend r' := fun r r' => by
    obtain ⟨x, hx⟩ := hext r; obtain ⟨y, hy⟩ := hext' r'; rw [← hx, ← hy]; exact hne x y
  set Ψ : ℂ → ℂ := fun z => γ.extend z.re - γ'.extend z.im with hΨ
  have hΨc : Continuous Ψ :=
    (γ.extend.continuous.comp Complex.continuous_re).sub (γ'.extend.continuous.comp Complex.continuous_im)
  have hΨ0 : ∀ z, Ψ z ≠ 0 := fun z => sub_ne_zero.mpr (hne' _ _)
  let f : C(ℂ, {z : ℂ // z ≠ 0}) := ⟨fun z => ⟨Ψ z, hΨ0 z⟩, hΨc.subtype_mk _⟩
  obtain ⟨F, ⟨-, hF⟩, -⟩ := Complex.isCoveringMap_exp.existsUnique_continuousMap_lifts f 0 (Complex.log (Ψ 0))
    (by ext; simp [f, Complex.exp_log (hΨ0 0)])
  have hFexp : ∀ z, Complex.exp (F z) = Ψ z := by
    intro z
    have := congrArg Subtype.val (congrFun hF z)
    simpa [f] using this
  have hΨpt : ∀ x y : ℝ, Ψ (↑x + ↑y * I) = γ.extend x - γ'.extend y := fun x y => by simp [hΨ]
  -- edge 1: `y = 0`, `x` from `0` to `1`
  have e1 := im_sub_eq_arg_sub (f := fun x : ℝ => F (↑x + ↑(0 : ℝ) * I))
    (v := fun x => (ringPt u s' - γ.extend x) * e (-s')) (κ := -e s')
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ.extend.continuous).mul continuous_const).continuousOn
    (fun x _ => re_pos_of_mem_closedBall (hD x) (by rw [← γ'.extend_zero]; exact hne' x 0))
    (fun x _ => by
      rw [hFexp, hΨpt, γ'.extend_zero,
        show -e s' * ((ringPt u s' - γ.extend x) * e (-s')) = -(ringPt u s' - γ.extend x) * (e s' * e (-s')) by ring,
        e_mul_e_neg]; ring)
  -- edge 2: `x = 1`, `y` from `0` to `1`
  have e2 := im_sub_eq_arg_sub (f := fun y : ℝ => F (↑(1 : ℝ) + ↑y * I))
    (v := fun y => (ringPt u t - γ'.extend y) * e (-t)) (κ := e t)
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ'.extend.continuous).mul continuous_const).continuousOn
    (fun y _ => re_pos_of_mem_closedBall (hD' y) (by rw [← γ.extend_one]; exact (hne' 1 y).symm))
    (fun y _ => by
      rw [hFexp, hΨpt, γ.extend_one,
        show e t * ((ringPt u t - γ'.extend y) * e (-t)) = (ringPt u t - γ'.extend y) * (e t * e (-t)) by ring,
        e_mul_e_neg]; ring)
  -- edge 3: `y = 1`, `x` from `0` to `1`
  have e3 := im_sub_eq_arg_sub (f := fun x : ℝ => F (↑x + ↑(1 : ℝ) * I))
    (v := fun x => (ringPt u t' - γ.extend x) * e (-t')) (κ := -e t')
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ.extend.continuous).mul continuous_const).continuousOn
    (fun x _ => re_pos_of_mem_closedBall (hD x) (by rw [← γ'.extend_one]; exact hne' x 1))
    (fun x _ => by
      rw [hFexp, hΨpt, γ'.extend_one,
        show -e t' * ((ringPt u t' - γ.extend x) * e (-t')) = -(ringPt u t' - γ.extend x) * (e t' * e (-t')) by ring,
        e_mul_e_neg]; ring)
  -- edge 4: `x = 0`, `y` from `0` to `1`
  have e4 := im_sub_eq_arg_sub (f := fun y : ℝ => F (↑(0 : ℝ) + ↑y * I))
    (v := fun y => (ringPt u s - γ'.extend y) * e (-s)) (κ := e s)
    (F.continuous.comp (by fun_prop)).continuousOn
    ((continuous_const.sub γ'.extend.continuous).mul continuous_const).continuousOn
    (fun y _ => re_pos_of_mem_closedBall (hD' y) (by rw [← γ.extend_zero]; exact (hne' 0 y).symm))
    (fun y _ => by
      rw [hFexp, hΨpt, γ.extend_zero,
        show e s * ((ringPt u s - γ'.extend y) * e (-s)) = (ringPt u s - γ'.extend y) * (e s * e (-s)) by ring,
        e_mul_e_neg]; ring)
  simp only [γ.extend_zero, γ.extend_one, γ'.extend_zero, γ'.extend_one, ringPt_sub_ringPt_mul_e_neg] at e1 e2 e3 e4
  rw [arg_one_sub_e (by linarith) (by linarith), arg_one_sub_e_of_neg (by linarith) (by linarith)] at e1
  rw [arg_one_sub_e (by linarith) (by linarith), arg_one_sub_e_of_neg (by linarith) (by linarith)] at e2
  rw [arg_one_sub_e_of_neg (by linarith) (by linarith), arg_one_sub_e_of_neg (by linarith) (by linarith)] at e3
  rw [arg_one_sub_e (by linarith) (by linarith), arg_one_sub_e (by linarith) (by linarith)] at e4
  simp only [sub_im] at e1 e2 e3 e4
  linarith [Real.pi_pos]

noncomputable def discRetract (u z : ℂ) : ℂ := u + (((max 1 ‖z - u‖)⁻¹ : ℝ) : ℂ) * (z - u)

theorem continuous_discRetract (u : ℂ) : Continuous (discRetract u) := by
  have hm : ∀ z : ℂ, max 1 ‖z - u‖ ≠ 0 := fun z => (lt_of_lt_of_le one_pos (le_max_left _ _)).ne'
  exact continuous_const.add ((Complex.continuous_ofReal.comp
    ((continuous_const.max (continuous_norm.comp (continuous_id.sub continuous_const))).inv₀ hm)).mul
    (continuous_id.sub continuous_const))

theorem discRetract_mem (u z : ℂ) : discRetract u z ∈ closedBall u 1 := by
  have hm : 0 < max 1 ‖z - u‖ := lt_of_lt_of_le one_pos (le_max_left _ _)
  rw [mem_closedBall, dist_eq_norm, discRetract, add_sub_cancel_left, norm_mul, Complex.norm_real,
    Real.norm_of_nonneg (inv_nonneg.mpr hm.le), inv_mul_le_iff₀ hm, mul_one]
  exact le_max_right _ _

theorem discRetract_of_mem {u z : ℂ} (hz : z ∈ closedBall u 1) : discRetract u z = z := by
  rw [mem_closedBall, dist_eq_norm] at hz
  rw [discRetract, max_eq_left hz]; simp

theorem dist_discRetract_le {u k : ℂ} (hk : k ∈ closedBall u 1) (z : ℂ) :
    dist (discRetract u z) k ≤ 2 * dist z k := by
  by_cases h : ‖z - u‖ ≤ 1
  · rw [discRetract_of_mem (by rwa [mem_closedBall, dist_eq_norm])]
    linarith [dist_nonneg (x := z) (y := k)]
  · push Not at h
    set n := ‖z - u‖ with hn
    have hn0 : 0 < n := by linarith
    have hdz : dist (discRetract u z) z = n - 1 := by
      have : discRetract u z - z = (((n⁻¹ - 1 : ℝ)) : ℂ) * (z - u) := by
        rw [discRetract, max_eq_right h.le]; push_cast; ring
      rw [dist_eq_norm, this, norm_mul, Complex.norm_real, ← hn, Real.norm_eq_abs,
        abs_of_nonpos (by rw [sub_nonpos]; exact inv_le_one_of_one_le₀ h.le)]
      field_simp
      ring
    have hku : ‖k - u‖ ≤ 1 := by rwa [mem_closedBall, dist_eq_norm] at hk
    have htri : n ≤ dist z k + ‖k - u‖ := by
      rw [hn, dist_eq_norm]
      calc ‖z - u‖ = ‖(z - k) + (k - u)‖ := by ring_nf
        _ ≤ ‖z - k‖ + ‖k - u‖ := norm_add_le _ _
    calc dist (discRetract u z) k ≤ dist (discRetract u z) z + dist z k := dist_triangle _ _ _
      _ ≤ 2 * dist z k := by rw [hdz]; linarith

theorem isPreconnected_thickening {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] {K : Set E}
    (hK : IsPreconnected K) {δ : ℝ} (hδ : 0 < δ) : IsPreconnected (thickening δ K) := by
  rcases K.eq_empty_or_nonempty with rfl | ⟨x₀, hx₀⟩
  · rw [thickening_empty]; exact isPreconnected_empty
  refine isPreconnected_of_forall x₀ fun y hy => ?_
  obtain ⟨k, hk, hyk⟩ := mem_thickening_iff.mp hy
  refine ⟨K ∪ ball k δ, union_subset (self_subset_thickening hδ K) (ball_subset_thickening hk δ), Or.inl hx₀,
    Or.inr (mem_ball.mpr hyk), ?_⟩
  exact hK.union k hk (mem_ball_self hδ) (convex_ball k δ).isPreconnected

theorem inter_nonempty_of_interleaved' {u : ℂ} {K K' : Set ℂ} (hK : IsClosed K) (hK' : IsClosed K') (hKc : IsPreconnected K)
    (hK'c : IsPreconnected K') (hKd : K ⊆ closedBall u 1) (hK'd : K' ⊆ closedBall u 1) {s s' t t' : ℝ} (h₁ : s < s') (h₂ : s' < t)
    (h₃ : t < t') (h₄ : t' < s + 2 * π) (hs : ringPt u s ∈ K) (ht : ringPt u t ∈ K) (hs' : ringPt u s' ∈ K')
    (ht' : ringPt u t' ∈ K') : (K ∩ K').Nonempty := by
  by_contra hne
  have hdisj : Disjoint K K' := Set.disjoint_iff_inter_eq_empty.mpr (not_nonempty_iff_eq_empty.mp hne)
  have hKcpt : IsCompact K := isCompact_of_isClosed_isBounded hK (isBounded_closedBall.subset hKd)
  obtain ⟨δ, hδ, hδd⟩ := hdisj.exists_thickenings hKcpt hK'
  have path_of : ∀ {L : Set ℂ}, IsPreconnected L → L ⊆ closedBall u 1 → ∀ {a b : ℝ}, ringPt u a ∈ L →
      ringPt u b ∈ L → ∃ γ : Path (ringPt u a) (ringPt u b), ∀ x, γ x ∈ closedBall u 1 ∧ γ x ∈ thickening δ L := by
    intro L hL hLd a b ha hb
    have hδ2 : 0 < δ / 2 := by linarith
    have hU : IsPathConnected (thickening (δ / 2) L) :=
      (isOpen_thickening.isConnected_iff_isPathConnected).mp
        ⟨⟨_, self_subset_thickening hδ2 L ha⟩, isPreconnected_thickening hL hδ2⟩
    have hj := hU.joinedIn _ (self_subset_thickening hδ2 L ha) _ (self_subset_thickening hδ2 L hb)
    refine ⟨(hj.somePath.map (continuous_discRetract u)).cast (discRetract_of_mem (hLd ha)).symm
      (discRetract_of_mem (hLd hb)).symm, fun x => ⟨discRetract_mem u _, ?_⟩⟩
    obtain ⟨k, hk, hk'⟩ := mem_thickening_iff.mp (hj.somePath_mem x)
    exact mem_thickening_iff.mpr ⟨k, hk, lt_of_le_of_lt (dist_discRetract_le (hLd hk) _) (by linarith)⟩
  obtain ⟨γ, hγ⟩ := path_of hKc hKd hs ht
  obtain ⟨γ', hγ'⟩ := path_of hK'c hK'd hs' ht'
  obtain ⟨x, y, hxy⟩ := exists_eq_of_interleaved_paths h₁ h₂ h₃ h₄ γ γ' (fun x => (hγ x).1) (fun y => (hγ' y).1)
  exact Set.disjoint_left.mp hδd (hγ x).2 (hxy ▸ (hγ' y).2)


theorem inter_nonempty_of_interleaved_of_isClosed_left {u : ℂ} {K K' : Set ℂ} (hK : IsClosed K) (hKc : IsPreconnected K)
    (hK'c : IsPreconnected K') (hKd : K ⊆ closedBall u 1) (hK'd : K' ⊆ closedBall u 1) {s s' t t' : ℝ} (h₁ : s < s') (h₂ : s' < t)
    (h₃ : t < t') (h₄ : t' < s + 2 * π) (hs : ringPt u s ∈ K) (ht : ringPt u t ∈ K) (hs' : ringPt u s' ∈ K')
    (ht' : ringPt u t' ∈ K') : (K ∩ K').Nonempty := by
  by_contra hne
  have hK'K : ∀ w ∈ K', w ∉ K := fun w hw hwK => hne ⟨w, hwK, hw⟩
  set V := closedBall u 1 ∩ Kᶜ with hV
  have hKne : K.Nonempty := ⟨_, hs⟩
  -- a point of `V` is joined in `V` to every point of the disc near it
  have near : ∀ z ∈ V, ∀ w ∈ closedBall u 1, dist w z < infDist z K → JoinedIn V z w := by
    intro z hz w hw hwz
    have hsub : ball z (infDist z K) ∩ closedBall u 1 ⊆ V := fun y hy =>
      ⟨hy.2, fun hyK => (not_lt.mpr (infDist_le_dist_of_mem hyK)) (by rw [dist_comm]; exact hy.1)⟩
    have hz' : z ∈ ball z (infDist z K) ∩ closedBall u 1 :=
      ⟨mem_ball_self ((hK.notMem_iff_infDist_pos hKne).mp hz.2), hz.1⟩
    exact (((convex_ball z _).inter (convex_closedBall u 1)).isPathConnected ⟨z, hz'⟩).joinedIn z hz' w
      ⟨hwz, hw⟩ |>.mono hsub
  set P := {z | JoinedIn V (ringPt u s') z} with hP
  set U₁ := ⋃ z ∈ P, ball z (infDist z K) with hU₁
  set U₂ := ⋃ z ∈ V \ P, ball z (infDist z K) with hU₂
  have hV' : ∀ w ∈ K', w ∈ V := fun w hw => ⟨hK'd hw, hK'K w hw⟩
  have hpos : ∀ z ∈ V, 0 < infDist z K := fun z hz => (hK.notMem_iff_infDist_pos hKne).mp hz.2
  have hcov : K' ⊆ U₁ ∪ U₂ := by
    intro w hw
    by_cases hwP : w ∈ P
    · exact Or.inl (mem_iUnion₂.mpr ⟨w, hwP, mem_ball_self (hpos w (hV' w hw))⟩)
    · exact Or.inr (mem_iUnion₂.mpr ⟨w, ⟨hV' w hw, hwP⟩, mem_ball_self (hpos w (hV' w hw))⟩)
  have hinP : ∀ w ∈ K', w ∈ U₁ → w ∈ P := by
    intro w hw hwU
    obtain ⟨z, hzP, hwz⟩ := mem_iUnion₂.mp hwU
    exact JoinedIn.trans hzP (near z hzP.target_mem w (hK'd hw) hwz)
  have hU₂ : ∀ w ∈ K', w ∈ U₁ → w ∉ U₂ := by
    intro w hw hw1 hw2
    obtain ⟨z, ⟨hzV, hzP⟩, hwz⟩ := mem_iUnion₂.mp hw2
    exact hzP (JoinedIn.trans (hinP w hw hw1) (near z hzV w (hK'd hw) hwz).symm)
  have hsub : K' ⊆ U₁ := by
    have h := hK'c U₁ U₂ (isOpen_biUnion fun _ _ => isOpen_ball) (isOpen_biUnion fun _ _ => isOpen_ball) hcov
    by_contra hnot
    obtain ⟨w, hw, hwU⟩ := not_subset.mp hnot
    obtain ⟨y, hy, hy1, hy2⟩ := h ⟨_, hs', mem_iUnion₂.mpr ⟨_, JoinedIn.refl (hV' _ hs'), mem_ball_self (hpos _ (hV' _ hs'))⟩⟩
      ⟨w, hw, (hcov hw).resolve_left hwU⟩
    exact hU₂ y hy hy1 hy2
  have hj : JoinedIn V (ringPt u s') (ringPt u t') := hinP _ ht' (hsub ht')
  set γ' := hj.somePath
  obtain ⟨z, hzK, hzγ⟩ := inter_nonempty_of_interleaved' hK (isCompact_range γ'.continuous).isClosed hKc
    (isPreconnected_range γ'.continuous) hKd (by rintro _ ⟨x, rfl⟩; exact (hj.somePath_mem x).1) h₁ h₂ h₃ h₄ hs ht
    ⟨0, γ'.source⟩ ⟨1, γ'.target⟩
  obtain ⟨x, rfl⟩ := hzγ
  exact (hj.somePath_mem x).2 hzK

end HadwigerNelson.Plane
#print axioms HadwigerNelson.Plane.inter_nonempty_of_interleaved_of_isClosed_left
#check @HadwigerNelson.Plane.inter_nonempty_of_interleaved_of_isClosed_left
