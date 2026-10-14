import Proofs.HadwigerNelson.Plane.OneClass.Defs
import Proofs.HadwigerNelson.Outside.OAI158BorelTransfer

/-!
# The field theorem: rotation-fixed observables of a plane system have continuous parts on the real plane (FS-133)

One statement carries the forward half of both C133-ALG (steps F3–F9, one observable) and C133-PAIR (steps F2–F5,
one observable per label) of `plans/FS133-E1-derivation.md`: for a probability space on which the algebraic plane
and its rotations act, and finitely many `[0, 1]`-valued observables fixed by the rotations, there are jointly
measurable `[0, 1]`-valued fields over the real plane with the observables' means and linear relations, in which a
pair of observables uncorrelated at one non-zero algebraic displacement is uncorrelated on the whole circle of that
radius.

It rests on `[OAIMath2026]`'s ported theorem `Outside.OAI158.Spectral.residual_fourier` (through
`residual_fourier_cross`) and on the release's generic lemmas, ported (`plans/FS133-kernel-plan.md`, leaf P): the
field is the orbit extension of the projection of each observable on the continuous vectors.
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology

namespace HadwigerNelson.OneClass

open HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral

noncomputable section FieldAux

/-! ### The Hilbert-space layer (private): the Koopman representation of a plane system on `L²`, the observables'
vectors, their projections on the continuous vectors, and the orbit extension to the real plane. The release's label
model (`BorelTransfer.lean` ll. 9–96, 200–245, 337–368) rewritten for an arbitrary plane system and a finite family;
the generic lemmas are the port's (`Outside/OAI158Basic` … `OAI158BorelTransfer`). -/

open HadwigerNelson.Outside.OAI158.ContinuousVectors
open scoped InnerProductSpace

variable {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {τ : E → Ω → Ω} {ρ : K → Ω → Ω}

/-- The translation by `z`, as a measurable equivalence (inverse: the translation by `-z`). -/
private def shiftEquiv (h : IsPlaneSystem P τ ρ) (z : E) : Ω ≃ᵐ Ω where
  toFun := τ z
  invFun := τ (-z)
  left_inv ω := by rw [← h.shift_add, neg_add_cancel, h.shift_zero]
  right_inv ω := by rw [← h.shift_add, add_neg_cancel, h.shift_zero]
  measurable_toFun := (h.shift_mp z).measurable
  measurable_invFun := (h.shift_mp (-z)).measurable

/-- The rotation by `u`, as a measurable equivalence (inverse: the rotation by `u⁻¹`). -/
private def turnEquiv (h : IsPlaneSystem P τ ρ) (u : K) : Ω ≃ᵐ Ω where
  toFun := ρ u
  invFun := ρ u⁻¹
  left_inv ω := by rw [← h.turn_mul, inv_mul_cancel, h.turn_one]
  right_inv ω := by rw [← h.turn_mul, mul_inv_cancel, h.turn_one]
  measurable_toFun := (h.turn_mp u).measurable
  measurable_invFun := (h.turn_mp u⁻¹).measurable

/-- The Koopman representation of the translations on `L²`: `(U z g) ω = g (τ z ω)`. -/
private def planeRep (h : IsPlaneSystem P τ ρ) : DiscreteE →* unitary (Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) where
  toFun a := Koopman.unitary P (shiftEquiv h (Multiplicative.toAdd a)) (h.shift_mp _)
  map_one' := by
    apply Subtype.ext
    apply ContinuousLinearMap.ext
    intro v
    change Lp.compMeasurePreserving (τ 0) (h.shift_mp 0) v = v
    have he : τ 0 = id := funext h.shift_zero
    simp only [he, Lp.compMeasurePreserving_id_apply]
  map_mul' a b := by
    apply Subtype.ext
    apply ContinuousLinearMap.ext
    intro v
    change Lp.compMeasurePreserving (τ (Multiplicative.toAdd a + Multiplicative.toAdd b)) (h.shift_mp _) v =
      Lp.compMeasurePreserving (τ (Multiplicative.toAdd a)) (h.shift_mp _)
        (Lp.compMeasurePreserving (τ (Multiplicative.toAdd b)) (h.shift_mp _) v)
    rw [← Lp.compMeasurePreserving_comp_apply]
    congr 2
    funext x
    exact (congrArg (fun c => τ c x) (add_comm _ _)).trans (h.shift_add _ _ x)

private theorem op_planeRep (h : IsPlaneSystem P τ ρ) (a : E) (v : Lp ℂ 2 P) :
    op (planeRep h) a v = Lp.compMeasurePreserving (τ a) (h.shift_mp a) v := rfl

/-- The Koopman unitary of a rotation: `(W u g) ω = g (ρ u ω)`. -/
private def planeTurn (h : IsPlaneSystem P τ ρ) (u : K) : unitary (Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) :=
  Koopman.unitary P (turnEquiv h u) (h.turn_mp u)

private theorem planeTurn_apply (h : IsPlaneSystem P τ ρ) (u : K) (v : Lp ℂ 2 P) :
    (planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) v = Lp.compMeasurePreserving (ρ u) (h.turn_mp u) v := rfl

private theorem turn_covariance (h : IsPlaneSystem P τ ρ) (u : K) (a : E) (v : Lp ℂ 2 P) :
    (planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) (op (planeRep h) a v) =
      op (planeRep h) (kCoeff u * a) ((planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) v) := by
  simp only [planeTurn_apply, op_planeRep, ← Lp.compMeasurePreserving_comp_apply]
  congr 2
  funext x
  exact h.cov u a x

/-- The continuous vectors of the representation. -/
private abbrev contSpace (h : IsPlaneSystem P τ ρ) : Submodule ℂ (Lp ℂ 2 P) := space (A := E) (planeRep h)

private theorem proj_turn_fixed (h : IsPlaneSystem P τ ρ) (u : K) (v : Lp ℂ 2 P)
    (hv : (planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) v = v) :
    (planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) ((contSpace h).starProjection v) =
      (contSpace h).starProjection v :=
  projection_covariance_fixed (planeRep h) (planeTurn h u) (Homeomorph.mulLeft₀ (kCoeff u) (kCoeff_ne_zero u))
    (mul_zero _) (turn_covariance h u) v hv

private theorem proj_range (h : IsPlaneSystem P τ ρ) (v : Lp ℂ 2 P)
    (hv : ∀ᵐ ω ∂P, (v ω).im = 0 ∧ 0 ≤ (v ω).re ∧ (v ω).re ≤ 1) :
    ∀ᵐ ω ∂P, ((contSpace h).starProjection v ω).im = 0 ∧ 0 ≤ ((contSpace h).starProjection v ω).re ∧
      ((contSpace h).starProjection v ω).re ≤ 1 :=
  projection_range P (planeRep h) τ h.shift_mp (op_planeRep h) v hv

/-- **The one use of the outside theorem** (through its two-vector form): at a non-zero translate, the projections
on the continuous vectors of two rotation-fixed vectors have the correlation of the vectors themselves. -/
private theorem inner_proj_shift (h : IsPlaneSystem P τ ρ) (v w : Lp ℂ 2 P)
    (hv : ∀ u, (planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) v = v)
    (hw : ∀ u, (planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) w = w) (z : E) (hz : z ≠ 0) :
    ⟪(contSpace h).starProjection v, op (planeRep h) z ((contSpace h).starProjection w)⟫_ℂ =
      ⟪v, op (planeRep h) z w⟫_ℂ := by
  have hpv : (contSpace h).starProjection v ∈ contSpace h := (contSpace h).starProjection_apply_mem v
  have hpw : (contSpace h).starProjection w ∈ contSpace h := (contSpace h).starProjection_apply_mem w
  have hbv : v - (contSpace h).starProjection v ∈ (contSpace h)ᗮ :=
    (contSpace h).sub_starProjection_mem_orthogonal v
  have hbw : w - (contSpace h).starProjection w ∈ (contSpace h)ᗮ :=
    (contSpace h).sub_starProjection_mem_orthogonal w
  have hbb : ⟪v - (contSpace h).starProjection v,
      op (planeRep h) z (w - (contSpace h).starProjection w)⟫_ℂ = 0 :=
    residual_fourier_cross (planeRep h) (planeTurn h) (turn_covariance h) _ _ hbv hbw
      (fun u => by rw [map_sub, hv u, proj_turn_fixed h u v (hv u)])
      (fun u => by rw [map_sub, hw u, proj_turn_fixed h u w (hw u)]) z hz
  have h1 : ⟪v - (contSpace h).starProjection v, op (planeRep h) z ((contSpace h).starProjection w)⟫_ℂ = 0 :=
    Submodule.inner_left_of_mem_orthogonal (op_mem (planeRep h) z hpw) hbv
  have h2 : ⟪(contSpace h).starProjection v, op (planeRep h) z (w - (contSpace h).starProjection w)⟫_ℂ = 0 :=
    Submodule.inner_right_of_mem_orthogonal hpv (op_orthogonal (planeRep h) z hbw)
  have key : ⟪(contSpace h).starProjection v + (v - (contSpace h).starProjection v),
      op (planeRep h) z ((contSpace h).starProjection w + (w - (contSpace h).starProjection w))⟫_ℂ =
      ⟪(contSpace h).starProjection v, op (planeRep h) z ((contSpace h).starProjection w)⟫_ℂ := by
    rw [map_add, inner_add_left, inner_add_right, inner_add_right, h1, h2, hbb]
    simp
  rw [add_sub_cancel, add_sub_cancel] at key
  exact key.symm

/-- The orbit extension of a `[0, 1]`-valued continuous vector is `[0, 1]`-valued at every point of the plane. -/
private theorem orbit_range (h : IsPlaneSystem P τ ρ) {p : Lp ℂ 2 P} (hp : p ∈ contSpace h)
    (hr : ∀ᵐ ω ∂P, (p ω).im = 0 ∧ 0 ≤ (p ω).re ∧ (p ω).re ≤ 1) (x : ℂ) :
    ∀ᵐ ω ∂P, (orbitExtension (planeRep h) p x ω).im = 0 ∧ 0 ≤ (orbitExtension (planeRep h) p x ω).re ∧
      (orbitExtension (planeRep h) p x ω).re ≤ 1 := by
  have hc := orbitExtension_continuous (planeRep h) hp
  have he : clamp_lipschitz.compLp clamp_zero (orbitExtension (planeRep h) p x) =
      orbitExtension (planeRep h) p x := by
    refine dense_E.denseRange_val.induction_on x (isClosed_eq
      ((clamp_lipschitz.continuous_compLp clamp_zero).comp hc) hc) ?_
    intro a
    rw [orbitExtension_eq (planeRep h) hp, op_planeRep]
    apply Lp.ext
    filter_upwards [clamp_lipschitz.coeFn_compLp clamp_zero (Lp.compMeasurePreserving (τ a) (h.shift_mp a) p),
      Lp.coeFn_compMeasurePreserving p (h.shift_mp a),
      (h.shift_mp a).quasiMeasurePreserving.ae hr] with ω h1 h2 h3
    simp only [Function.comp_apply] at h1 h2
    rw [h1, h2]
    exact clamp_eq h3
  have ha := clamp_lipschitz.coeFn_compLp clamp_zero (orbitExtension (planeRep h) p x)
  rw [he] at ha
  filter_upwards [ha] with ω hω
  exact hω.symm ▸ clamp_range _

/-- Zero correlation at one non-zero algebraic displacement is zero correlation on the whole circle of its radius:
the rotations carry the displacement round the algebraic points of the circle, which are dense in it. -/
private theorem inner_orbit_circle (h : IsPlaneSystem P τ ρ) {p q : Lp ℂ 2 P} (hp : p ∈ contSpace h)
    (hq : q ∈ contSpace h) (hpf : ∀ u, (planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) p = p)
    (hqf : ∀ u, (planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) q = q) (z : E) (hz : z ≠ 0)
    (h0 : ⟪p, op (planeRep h) z q⟫_ℂ = 0) (x w : ℂ) (hw : ‖w‖ = ‖(z : ℂ)‖) :
    ⟪orbitExtension (planeRep h) p x, orbitExtension (planeRep h) q (x + w)⟫_ℂ = 0 := by
  rw [orbitExtension_inner (planeRep h) hp hq x w]
  have hzc : (z : ℂ) ≠ 0 := fun hc => hz (Subtype.ext hc)
  have hcl : IsClosed {c : ℂ | ⟪p, orbitExtension (planeRep h) q (c * (z : ℂ))⟫_ℂ = 0} :=
    isClosed_eq (continuous_const.inner
      ((orbitExtension_continuous (planeRep h) hq).comp (continuous_mul_const _))) continuous_const
  have halg : ∀ b : K, ⟪p, orbitExtension (planeRep h) q ((b.val : ℂ) * (z : ℂ))⟫_ℂ = 0 := by
    intro b
    have hb : ((b.val : ℂ) * (z : ℂ)) = ((kCoeff b * z : E) : ℂ) := rfl
    rw [hb, orbitExtension_eq (planeRep h) hq]
    have hu := Unitary.inner_map_map (planeTurn h b) p (op (planeRep h) z q)
    rw [turn_covariance, hpf b, hqf b] at hu
    rw [hu, h0]
  have hn : ‖w / (z : ℂ)‖ = 1 := by rw [norm_div, hw, div_self (norm_ne_zero_iff.mpr hzc)]
  have hcirc : ⟪p, orbitExtension (planeRep h) q (w / (z : ℂ) * (z : ℂ))⟫_ℂ = 0 :=
    circle_closed_induction (p := fun c => ⟪p, orbitExtension (planeRep h) q (c * (z : ℂ))⟫_ℂ = 0) hcl halg
      (⟨w / (z : ℂ), mem_sphere_zero_iff_norm.mpr hn⟩ : Circle)
  rwa [div_mul_cancel₀ _ hzc] at hcirc

variable [IsProbabilityMeasure P]

private theorem obs_memLp {g : Ω → ℝ} (hg : Measurable g) (h01 : ∀ ω, 0 ≤ g ω ∧ g ω ≤ 1) :
    MemLp (fun ω => (g ω : ℂ)) 2 P :=
  MemLp.of_bound (Complex.measurable_ofReal.comp hg).aestronglyMeasurable 1
    (Eventually.of_forall fun ω => by
      rw [Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (h01 ω).1]
      exact (h01 ω).2)

/-- The vector of a `[0, 1]`-valued observable. -/
private def obsVec {g : Ω → ℝ} (hg : Measurable g) (h01 : ∀ ω, 0 ≤ g ω ∧ g ω ≤ 1) : Lp ℂ 2 P :=
  (obs_memLp hg h01).toLp _

private theorem obsVec_ae {g : Ω → ℝ} (hg : Measurable g) (h01 : ∀ ω, 0 ≤ g ω ∧ g ω ≤ 1) :
    (obsVec hg h01 : Lp ℂ 2 P) =ᵐ[P] fun ω => (g ω : ℂ) := (obs_memLp hg h01).coeFn_toLp

private theorem obsVec_turn_fixed (h : IsPlaneSystem P τ ρ) {g : Ω → ℝ} (hg : Measurable g)
    (h01 : ∀ ω, 0 ≤ g ω ∧ g ω ≤ 1) (hfix : ∀ u ω, g (ρ u ω) = g ω) (u : K) :
    (planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) (obsVec hg h01) = obsVec hg h01 := by
  rw [planeTurn_apply]
  apply Lp.ext
  filter_upwards [Lp.coeFn_compMeasurePreserving (obsVec hg h01) (h.turn_mp u),
    (h.turn_mp u).quasiMeasurePreserving.ae (obsVec_ae hg h01), obsVec_ae hg h01] with ω h1 h2 h3
  simp only [h1, Function.comp_apply, h2, h3, hfix]

private theorem inner_obsVec_zero (h : IsPlaneSystem P τ ρ) {g₁ g₂ : Ω → ℝ} (hg₁ : Measurable g₁)
    (h01₁ : ∀ ω, 0 ≤ g₁ ω ∧ g₁ ω ≤ 1) (hg₂ : Measurable g₂) (h01₂ : ∀ ω, 0 ≤ g₂ ω ∧ g₂ ω ≤ 1) (z : E)
    (hz0 : ∀ᵐ ω ∂P, g₁ ω * g₂ (τ z ω) = 0) :
    ⟪(obsVec hg₁ h01₁ : Lp ℂ 2 P), op (planeRep h) z (obsVec hg₂ h01₂)⟫_ℂ = 0 := by
  rw [op_planeRep, L2.inner_def]
  apply integral_eq_zero_of_ae
  filter_upwards [obsVec_ae hg₁ h01₁, Lp.coeFn_compMeasurePreserving (obsVec hg₂ h01₂) (h.shift_mp z),
    (h.shift_mp z).quasiMeasurePreserving.ae (obsVec_ae hg₂ h01₂), hz0] with ω h1 h2 h3 h4
  simp only [h1, h2, Function.comp_apply, h3, Pi.zero_apply]
  rw [RCLike.inner_apply, Complex.conj_ofReal, ← Complex.ofReal_mul, mul_comm, h4, Complex.ofReal_zero]

/-- The constant `1`, as a vector. -/
private def oneVec (P : Measure Ω) [IsProbabilityMeasure P] : Lp ℂ 2 P :=
  (memLp_const (1 : ℂ)).toLp (fun _ : Ω => (1 : ℂ))

private theorem oneVec_ae : oneVec P =ᵐ[P] fun _ => (1 : ℂ) := MemLp.coeFn_toLp _

private theorem one_fixed (h : IsPlaneSystem P τ ρ) (a : E) : op (planeRep h) a (oneVec P) = oneVec P := by
  rw [op_planeRep]
  apply Lp.ext
  filter_upwards [Lp.coeFn_compMeasurePreserving (oneVec P) (h.shift_mp a),
    (h.shift_mp a).quasiMeasurePreserving.ae (oneVec_ae (P := P)), oneVec_ae (P := P)] with ω h1 h2 h3
  exact h1.trans (h2.trans h3.symm)

private theorem one_mem (h : IsPlaneSystem P τ ρ) : oneVec P ∈ contSpace h := by
  change Tendsto (fun a : E => op (planeRep h) a (oneVec P)) (𝓝 0) (𝓝 (oneVec P))
  simpa only [one_fixed h] using (tendsto_const_nhds : Tendsto (fun _ : E => oneVec P) (𝓝 0) (𝓝 (oneVec P)))

private theorem inner_one (g : Lp ℂ 2 P) : ⟪oneVec P, g⟫_ℂ = ∫ ω, g ω ∂P := by
  rw [L2.inner_def]
  apply integral_congr_ae
  filter_upwards [oneVec_ae (P := P)] with ω hω
  rw [hω, RCLike.inner_apply, map_one, mul_one]

private theorem inner_one_orbit (h : IsPlaneSystem P τ ρ) (v : Lp ℂ 2 P) (x : ℂ) :
    ⟪oneVec P, orbitExtension (planeRep h) ((contSpace h).starProjection v) x⟫_ℂ = ⟪oneVec P, v⟫_ℂ := by
  have hp : (contSpace h).starProjection v ∈ contSpace h := (contSpace h).starProjection_apply_mem v
  refine dense_E.denseRange_val.induction_on x (isClosed_eq
    (continuous_const.inner (orbitExtension_continuous (planeRep h) hp)) continuous_const) ?_
  intro a
  rw [orbitExtension_eq (planeRep h) hp]
  have hu := Unitary.inner_map_map ((planeRep h) (Multiplicative.ofAdd a)) (oneVec P)
    ((contSpace h).starProjection v)
  change ⟪op (planeRep h) a (oneVec P), op (planeRep h) a ((contSpace h).starProjection v)⟫_ℂ = _ at hu
  rw [one_fixed h] at hu
  rw [hu]
  have hb := Submodule.inner_right_of_mem_orthogonal (one_mem h)
    ((contSpace h).sub_starProjection_mem_orthogonal v)
  rw [inner_sub_right, sub_eq_zero] at hb
  exact hb.symm

private theorem sum_orbit (h : IsPlaneSystem P τ ρ) {ι : Type*} [Fintype ι] (v : ι → Lp ℂ 2 P) (c : ι → ℂ)
    (d : ℂ) (hs : ∑ i, c i • v i = d • oneVec P) (x : ℂ) :
    ∑ i, c i • orbitExtension (planeRep h) ((contSpace h).starProjection (v i)) x = d • oneVec P := by
  have hp : ∀ i, (contSpace h).starProjection (v i) ∈ contSpace h :=
    fun i => (contSpace h).starProjection_apply_mem (v i)
  refine dense_E.denseRange_val.induction_on x (isClosed_eq
    (continuous_finsetSum _ fun i _ => (orbitExtension_continuous (planeRep h) (hp i)).const_smul (c i))
    continuous_const) ?_
  intro a
  have he : ∀ i, orbitExtension (planeRep h) ((contSpace h).starProjection (v i)) (a : ℂ) =
      op (planeRep h) a ((contSpace h).starProjection (v i)) := fun i => orbitExtension_eq (planeRep h) (hp i) a
  simp only [he]
  rw [show (∑ i, c i • op (planeRep h) a ((contSpace h).starProjection (v i))) =
      op (planeRep h) a ((contSpace h).starProjection (∑ i, c i • v i)) by simp only [map_sum, map_smul]]
  rw [hs, map_smul, Submodule.starProjection_eq_self_iff.mpr (one_mem h), map_smul, one_fixed h]

end FieldAux

open HadwigerNelson.Outside.OAI158.ContinuousVectors in
open scoped InnerProductSpace in
/-- **The field theorem.** Let `P`, `τ`, `ρ` be a plane system and `f i`, `i` in a finite type, measurable
`[0, 1]`-valued observables each fixed by every rotation. Then there are jointly measurable `H i : ℂ × Ω → ℝ` with
values in `[0, 1]` such that
* the mean of `H i (x, ·)` is the mean of `f i`, at every `x`;
* every affine relation that holds among the `f i` almost surely holds among the `H i (x, ·)`, at every `x`;
* if `f i` and `f j ∘ τ z` have almost surely zero product at some `z ≠ 0` of the algebraic plane, then
  `H i (x, ·)` and `H j (x + w, ·)` have almost surely zero product at every `x` and every `w` of the real plane
  with `‖w‖ = ‖z‖`.
Rests on `[OAIMath2026]`'s ported theorem `Spectral.residual_fourier`. The hypotheses are inhabited at an invariant
random independent set with its indicator at the origin (`IsInvariantLaw.isPlaneSystem`); the consumer there is
`IsInvariantLaw.measure_origin_le_mOne`. -/
theorem exists_field {Ω : Type*} [MeasurableSpace Ω] {P : Measure Ω} {τ : E → Ω → Ω} {ρ : K → Ω → Ω}
    (h : IsPlaneSystem P τ ρ) {ι : Type*} [Fintype ι] (f : ι → Ω → ℝ) (hf : ∀ i, Measurable (f i))
    (h01 : ∀ i ω, 0 ≤ f i ω ∧ f i ω ≤ 1) (hfix : ∀ i u ω, f i (ρ u ω) = f i ω) :
    ∃ H : ι → ℂ × Ω → ℝ, (∀ i, Measurable (H i)) ∧ (∀ i p, 0 ≤ H i p ∧ H i p ≤ 1) ∧
      (∀ i x, ∫ ω, H i (x, ω) ∂P = ∫ ω, f i ω ∂P) ∧
      (∀ (c : ι → ℝ) (d : ℝ), (∀ᵐ ω ∂P, ∑ i, c i * f i ω = d) → ∀ x, ∀ᵐ ω ∂P, ∑ i, c i * H i (x, ω) = d) ∧
      ∀ i j, ∀ z : E, z ≠ 0 → (∀ᵐ ω ∂P, f i ω * f j (τ z ω) = 0) →
        ∀ x w : ℂ, ‖w‖ = ‖(z : ℂ)‖ → ∀ᵐ ω ∂P, H i (x, ω) * H j (x + w, ω) = 0 := by
  haveI := h.prob
  classical
  -- the observables' vectors, their projections on the continuous vectors, and the fields
  have hvae : ∀ i, (obsVec (hf i) (h01 i) : Lp ℂ 2 P) =ᵐ[P] fun ω => (f i ω : ℂ) := fun i => obsVec_ae _ _
  have hvfix : ∀ i u, (planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P) (obsVec (hf i) (h01 i)) = obsVec (hf i) (h01 i) :=
    fun i u => obsVec_turn_fixed h (hf i) (h01 i) (hfix i) u
  have hpmem : ∀ i, (contSpace h).starProjection (obsVec (hf i) (h01 i)) ∈ contSpace h :=
    fun i => (contSpace h).starProjection_apply_mem _
  have hpfix : ∀ i u, (planeTurn h u : Lp ℂ 2 P →L[ℂ] Lp ℂ 2 P)
      ((contSpace h).starProjection (obsVec (hf i) (h01 i))) =
      (contSpace h).starProjection (obsVec (hf i) (h01 i)) :=
    fun i u => proj_turn_fixed h u _ (hvfix i u)
  have hprange : ∀ i, ∀ᵐ ω ∂P, ((contSpace h).starProjection (obsVec (hf i) (h01 i)) ω).im = 0 ∧
      0 ≤ ((contSpace h).starProjection (obsVec (hf i) (h01 i)) ω).re ∧
      ((contSpace h).starProjection (obsVec (hf i) (h01 i)) ω).re ≤ 1 := fun i =>
    proj_range h _ (by
      filter_upwards [hvae i] with ω hω
      rw [hω]
      exact ⟨Complex.ofReal_im _, by simpa using (h01 i ω).1, by simpa using (h01 i ω).2⟩)
  let Fld : ι → ℂ → Lp ℂ 2 P := fun i =>
    orbitExtension (planeRep h) ((contSpace h).starProjection (obsVec (hf i) (h01 i)))
  have hFc : ∀ i, Continuous (Fld i) := fun i => orbitExtension_continuous (planeRep h) (hpmem i)
  have hFr : ∀ i x, ∀ᵐ ω ∂P, (Fld i x ω).im = 0 ∧ 0 ≤ (Fld i x ω).re ∧ (Fld i x ω).re ≤ 1 :=
    fun i x => orbit_range h (hpmem i) (hprange i) x
  -- a jointly measurable version of each field, clamped to `[0, 1]`
  choose G hGm hGae using fun i => exists_measurable_field P (Fld i) (hFc i)
  have hH : ∀ i x, ∀ᵐ ω ∂P, max 0 (min 1 (G i (x, ω)).re) = (Fld i x ω).re := by
    intro i x
    filter_upwards [hGae i x, hFr i x] with ω h1 h2
    rw [h1, min_eq_right h2.2.2, max_eq_right h2.2.1]
  refine ⟨fun i q => max 0 (min 1 (G i q).re), ?_, ?_, ?_, ?_, ?_⟩
  · intro i
    exact measurable_const.max (measurable_const.min (Complex.measurable_re.comp (hGm i)))
  · intro i q
    exact ⟨le_max_left _ _, max_le zero_le_one (min_le_left _ _)⟩
  · -- the means
    intro i x
    rw [integral_congr_ae (hH i x)]
    have hint : Integrable (fun ω => Fld i x ω) P := (Lp.memLp (Fld i x)).integrable one_le_two
    have h1 : ∫ ω, (Fld i x ω).re ∂P = (∫ ω, Fld i x ω ∂P).re := integral_re hint
    rw [h1, ← inner_one, inner_one_orbit h _ x, inner_one, integral_congr_ae (hvae i), integral_complex_ofReal,
      Complex.ofReal_re]
  · -- the affine relations
    intro c d hcd x
    have hs : ∑ i, (c i : ℂ) • (obsVec (hf i) (h01 i) : Lp ℂ 2 P) = (d : ℂ) • oneVec P := by
      apply Lp.ext
      filter_upwards [Lp.coeFn_fun_finsetSum Finset.univ (fun i => (c i : ℂ) • (obsVec (hf i) (h01 i) : Lp ℂ 2 P)),
        ae_all_iff.mpr (fun i => Lp.coeFn_smul (c i : ℂ) (obsVec (hf i) (h01 i) : Lp ℂ 2 P)), ae_all_iff.mpr hvae,
        Lp.coeFn_smul (d : ℂ) (oneVec P), oneVec_ae (P := P), hcd] with ω h1 h2 h3 h4 h5 h6
      rw [h1, h4, Pi.smul_apply, h5]
      simp only [h2, Pi.smul_apply, h3, smul_eq_mul, mul_one]
      rw [← h6]
      push_cast
      rfl
    have hF := sum_orbit h (fun i => (obsVec (hf i) (h01 i) : Lp ℂ 2 P)) (fun i => (c i : ℂ)) (d : ℂ) hs x
    filter_upwards [Lp.coeFn_fun_finsetSum Finset.univ (fun i => (c i : ℂ) • Fld i x),
      ae_all_iff.mpr (fun i => Lp.coeFn_smul (c i : ℂ) (Fld i x)), ae_all_iff.mpr (fun i => hH i x),
      Lp.coeFn_smul (d : ℂ) (oneVec P), oneVec_ae (P := P)] with ω h1 h2 h3 h4 h5
    have h7 : (∑ i, (c i : ℂ) * (Fld i x ω)) = (d : ℂ) := by
      have h8 : (∑ i, (c i : ℂ) • Fld i x : Lp ℂ 2 P) ω = ((d : ℂ) • oneVec P : Lp ℂ 2 P) ω := by rw [hF]
      rw [h1, h4, Pi.smul_apply, h5] at h8
      simpa only [h2, Pi.smul_apply, smul_eq_mul, mul_one] using h8
    have h9 := congrArg Complex.re h7
    simp only [Complex.re_sum, Complex.re_ofReal_mul, Complex.ofReal_re] at h9
    simp only [h3]
    exact h9
  · -- zero products on the whole circle
    intro i j z hz hzero x w hw
    have h0 : ⟪(obsVec (hf i) (h01 i) : Lp ℂ 2 P), op (planeRep h) z (obsVec (hf j) (h01 j))⟫_ℂ = 0 :=
      inner_obsVec_zero h (hf i) (h01 i) (hf j) (h01 j) z hzero
    have h1 := (inner_proj_shift h _ _ (hvfix i) (hvfix j) z hz).trans h0
    have h2 := inner_orbit_circle h (hpmem i) (hpmem j) (hpfix i) (hpfix j) z hz h1 x w hw
    have h3 := positive_orthogonal P (Fld i x) (Fld j (x + w))
      ((hFr i x).mono fun _ hh => ⟨hh.1, hh.2.1⟩) ((hFr j (x + w)).mono fun _ hh => ⟨hh.1, hh.2.1⟩) h2
    filter_upwards [hH i x, hH j (x + w), h3] with ω e1 e2 e3
    rw [e1, e2]
    exact e3

end HadwigerNelson.OneClass
