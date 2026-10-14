import Proofs.HadwigerNelson.Plane.OneClass.Field
import Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw
import Proofs.HadwigerNelson.Plane.LebesgueNumber

/-!
# Labellings with forbidden label pairs at algebraic distances: the plane, the algebraic plane, and measurable ones (FS-133)

The derivation's entry C133-PAIR (`plans/FS133-E1-derivation.md`, stage 6). A *pattern* `N` says, for each distance
`r`, which ordered pairs of labels are forbidden at two points `r` apart (`N r a b`); it is the entry's family of
sets `N_r`, with `N r` empty off the countable set `R`. Symmetry of `N r` is not asked: `AdmissibleOn` reads both
orders of every pair of points.

* `AdmissibleOn N X ℓ` — no two points of `X` carry a forbidden pair;
* `AdmissibleAe N ℓ` — for each `r`, almost no `(x, u)` in `ℂ × S¹` has a forbidden pair at `x`, `x + r u`;
* `IsAlgPattern N` — countably many distances carry a forbidden pair, each positive and algebraic;
* `exists_measurable_admissibleAe` — forward: from the algebraic plane to a Borel labelling admissible almost
  everywhere (rests on the declared outside theorem `Spectral.residual_fourier`);
* `exists_admissibleOn_of_ae` — converse: from a Lebesgue-measurable labelling admissible almost everywhere to one
  admissible at every pair (density points and compactness; no outside theorem);
* `exists_admissibleOn_univ_iff_ae`, `exists_admissibleOn_univ_iff_algPlane` — **C133-PAIR**.

Not claimed (the entry's line): any constraint on three or more points; any distance that is not algebraic;
infinitely many labels; a measurable labelling admissible at every pair.
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology

namespace HadwigerNelson.OneClass

open HadwigerNelson.Plane HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral

variable {Λ : Type*}

/-- A labelling is admissible on `X` for the pattern `N`: no two points of `X` at a distance `r` carry a pair of
labels that `N r` forbids. -/
def AdmissibleOn (N : ℝ → Λ → Λ → Prop) (X : Set ℂ) (ℓ : ℂ → Λ) : Prop :=
  ∀ x ∈ X, ∀ y ∈ X, ¬ N (dist x y) (ℓ x) (ℓ y)

/-- A labelling is admissible almost everywhere: for each distance `r`, almost no `(x, θ)` has a forbidden pair at
`x` and `x + r e^{iθ}` (Lebesgue measure on the plane, arc length on the circle). -/
def AdmissibleAe (N : ℝ → Λ → Λ → Prop) (ℓ : ℂ → Λ) : Prop :=
  ∀ r : ℝ, ∀ᵐ p ∂(volume : Measure ℂ).prod arcLength, ¬ N r (ℓ p.1) (ℓ (p.1 + r * e p.2))

/-- The entry's hypotheses on a pattern: countably many distances carry a forbidden pair, and each of them is a
positive real algebraic number. -/
structure IsAlgPattern (N : ℝ → Λ → Λ → Prop) : Prop where
  /-- countably many constrained distances -/
  countable : {r | ∃ a b, N r a b}.Countable
  /-- each positive -/
  pos : ∀ r a b, N r a b → 0 < r
  /-- each algebraic -/
  alg : ∀ r a b, N r a b → IsAlgebraic ℚ r

/-- The pattern of proper colourings: equal labels are forbidden at distance one. -/
def colourPattern (Λ : Type*) : ℝ → Λ → Λ → Prop := fun r a b => r = 1 ∧ a = b

/-- Drift check: admissible for the colouring pattern is proper. -/
theorem admissibleOn_colourPattern_iff {X : Set ℂ} {ℓ : ℂ → Λ} :
    AdmissibleOn (colourPattern Λ) X ℓ ↔ ∀ x ∈ X, ∀ y ∈ X, dist x y = 1 → ℓ x ≠ ℓ y := by
  simp only [AdmissibleOn, colourPattern, not_and, ne_eq]

/-- A model of `IsAlgPattern`: the colouring pattern. -/
theorem isAlgPattern_colourPattern (Λ : Type*) : IsAlgPattern (colourPattern Λ) := by
  refine ⟨(Set.countable_singleton (1 : ℝ)).mono ?_, ?_, ?_⟩
  · rintro r ⟨a, b, hr, -⟩
    exact hr
  · rintro r a b ⟨rfl, -⟩
    exact one_pos
  · rintro r a b ⟨rfl, -⟩
    exact isAlgebraic_one

/-- A model of all three notions at once: the plane has a Borel seven-labelling admissible for the colouring
pattern at every pair, hence on the algebraic plane and almost everywhere. -/
theorem exists_admissible_colourPattern_seven :
    ∃ ℓ : ℂ → Fin 7, Measurable ℓ ∧ AdmissibleOn (colourPattern (Fin 7)) univ ℓ ∧
      AdmissibleAe (colourPattern (Fin 7)) ℓ := by
  -- the brick colouring (`Instances/Seven`): floors of affine functions of the coordinates, read through a table
  have hrow : Measurable sevenBrick.row :=
    Int.measurable_floor.comp (Complex.measurable_im.div_const _)
  have hcol : Measurable sevenBrick.col :=
    Int.measurable_floor.comp ((Complex.measurable_re.sub ((measurable_const.mul
      (measurable_from_top.comp hrow)))).div_const _)
  have hm : Measurable sevenBrick.color := by
    show Measurable ((fun p : ℤ × ℤ => sevenBrick.table (zmodIdx sevenBrick.m sevenBrick.m_pos p.1)
      (zmodIdx sevenBrick.n sevenBrick.n_pos p.2)) ∘ fun z => (sevenBrick.col z, sevenBrick.row z))
    exact (measurable_of_countable _).comp (hcol.prodMk hrow)
  have hprop : ∀ x y : ℂ, dist x y = 1 → sevenBrick.color x ≠ sevenBrick.color y := fun x y h =>
    sevenBrick.avoids (List.mem_singleton.mpr rfl) sevenBrick_check (by rw [h]; simp)
  refine ⟨sevenBrick.color, hm, admissibleOn_colourPattern_iff.2 fun x _ y _ => hprop x y, fun r => ?_⟩
  refine Eventually.of_forall fun p hp => ?_
  obtain ⟨hr, heq⟩ := hp
  subst hr
  refine hprop p.1 (p.1 + ((1 : ℝ) : ℂ) * e p.2) ?_ heq
  rw [dist_eq_norm]
  simp

/-- Admissibility passes to a subset. -/
theorem AdmissibleOn.mono {N : ℝ → Λ → Λ → Prop} {X Y : Set ℂ} {ℓ : ℂ → Λ} (h : AdmissibleOn N Y ℓ)
    (hXY : X ⊆ Y) : AdmissibleOn N X ℓ :=
  fun x hx y hy => h x (hXY hx) y (hXY hy)

/-! Private helpers for the forward direction: the labellings of the algebraic plane under translations and
algebraic rotations are a plane system for any invariant law (`IsInvariantLaw.isPlaneSystem` is the same for
`Bool`-valued labellings; its helpers are private to `Defs`). -/

private theorem kCoeff_one_pair : kCoeff 1 = 1 :=
  Subtype.ext (show (((1 : K) : Circle) : ℂ) = 1 from Circle.coe_one)

private theorem kCoeff_mul_pair (u v : K) : kCoeff (u * v) = kCoeff u * kCoeff v :=
  Subtype.ext (show (((u * v : K) : Circle) : ℂ) = ((u : Circle) : ℂ) * ((v : Circle) : ℂ) by
    rw [Subgroup.coe_mul, Circle.coe_mul])

/-- A law on the labellings of the algebraic plane invariant under `shiftLab` and `turnLab` is a plane system. -/
private theorem isPlaneSystem_lab [MeasurableSpace Λ] {P : Measure (E → Λ)} (hP : IsProbabilityMeasure P)
    (hs : ∀ z, P.map (shiftLab z) = P) (ht : ∀ u, P.map (turnLab u) = P) :
    IsPlaneSystem P shiftLab turnLab where
  prob := hP
  shift_mp z := ⟨measurable_pi_lambda _ fun _ => measurable_pi_apply _, hs z⟩
  turn_mp u := ⟨measurable_pi_lambda _ fun _ => measurable_pi_apply _, ht u⟩
  shift_zero ω := funext fun x => by simp only [shiftLab, add_zero]
  shift_add a b ω := funext fun x => by simp only [shiftLab, add_assoc]
  turn_one ω := funext fun x => by simp only [turnLab, kCoeff_one_pair, one_mul]
  turn_mul u v ω := funext fun x => by simp only [turnLab, kCoeff_mul_pair]; congr 1; ring
  cov u z ω := funext fun x => by simp only [shiftLab, turnLab, mul_add]

/-- The algebraic rotations preserve distances in the algebraic plane. -/
private theorem dist_kCoeff_mul (u : K) (x y : E) :
    dist ((kCoeff u * x : E) : ℂ) ((kCoeff u * y : E) : ℂ) = dist (x : ℂ) (y : ℂ) := by
  have h1 : ((kCoeff u * x : E) : ℂ) - ((kCoeff u * y : E) : ℂ) = ((kCoeff u * (x - y) : E) : ℂ) := by
    push_cast; ring
  have h2 : (x : ℂ) - (y : ℂ) = ((x - y : E) : ℂ) := by push_cast; ring
  rw [dist_eq_norm, dist_eq_norm, h1, h2, norm_kCoeff_mul]

/-- **C133-PAIR, forward** (steps F1–F6): a labelling admissible on the algebraic plane gives a labelling of the
plane with Borel fibres that is admissible almost everywhere. Rests on the declared outside theorem
`Spectral.residual_fourier`. -/
theorem exists_measurable_admissibleAe [Finite Λ] {N : ℝ → Λ → Λ → Prop} (hN : IsAlgPattern N) {ℓ : ℂ → Λ}
    (h : AdmissibleOn N (E : Set ℂ) ℓ) :
    ∃ ℓ' : ℂ → Λ, (∀ a, MeasurableSet (ℓ' ⁻¹' {a})) ∧ AdmissibleAe N ℓ' := by
  classical
  haveI := Fintype.ofFinite Λ
  letI : TopologicalSpace Λ := ⊥
  haveI : DiscreteTopology Λ := ⟨rfl⟩
  letI : MeasurableSpace Λ := ⊤
  haveI : MeasurableSingletonClass Λ := ⟨fun _ => MeasurableSpace.measurableSet_top⟩
  -- (F1) the admissible labellings of the algebraic plane: closed, nonempty, invariant; an invariant law on them
  set C : Set (E → Λ) := {m | ∀ x y : E, ¬ N (dist (x : ℂ) (y : ℂ)) (m x) (m y)} with hCdef
  have hCc : IsClosed C := by
    rw [hCdef, setOf_forall]
    refine isClosed_iInter fun x => ?_
    rw [setOf_forall]
    refine isClosed_iInter fun y => ?_
    have hS : IsClosed {p : Λ × Λ | ¬ N (dist (x : ℂ) (y : ℂ)) p.1 p.2} := isClosed_discrete _
    have hcont : Continuous (fun m : E → Λ => ((m x, m y) : Λ × Λ)) :=
      (continuous_apply x).prodMk (continuous_apply y)
    exact hS.preimage hcont
  have hCne : C.Nonempty := ⟨fun z => ℓ z, fun x y => h x x.2 y y.2⟩
  have hshift : ∀ z, MapsTo (shiftLab z) C C := by
    intro z m hm x y
    have hd : dist ((x + z : E) : ℂ) ((y + z : E) : ℂ) = dist (x : ℂ) (y : ℂ) := by
      push_cast
      exact dist_add_right _ _ _
    have := hm (x + z) (y + z)
    rwa [hd] at this
  have hturn : ∀ u, MapsTo (turnLab u) C C := by
    intro u m hm x y
    have := hm (kCoeff u * x) (kCoeff u * y)
    rwa [dist_kCoeff_mul] at this
  obtain ⟨P, hP, hPC, hPs, hPt⟩ := exists_invariant_of_closed hCc hCne hshift hturn
  have hsys := isPlaneSystem_lab hP hPs hPt
  have hCae : ∀ᵐ m ∂P, m ∈ C := measure_eq_zero_iff_ae_notMem.1 hPC |>.mono fun m hm => not_not.1 hm
  -- (F2) the indicators of the label at the origin, fixed by the rotations
  set f : Λ → (E → Λ) → ℝ := fun a m => if m 0 = a then 1 else 0 with hfdef
  have hfm : ∀ a, Measurable (f a) := fun a =>
    Measurable.ite (measurableSet_eq_fun (measurable_pi_apply (0 : E)) measurable_const) measurable_const
      measurable_const
  have hf01 : ∀ a m, 0 ≤ f a m ∧ f a m ≤ 1 := by
    intro a m
    simp only [hfdef]
    split_ifs <;> norm_num
  have hffix : ∀ a u m, f a (turnLab u m) = f a m := by
    intro a u m
    simp only [hfdef, turnLab, mul_zero]
  -- (F3)–(F5) the fields: their sum is one, and their products vanish on the circles of the forbidden distances
  obtain ⟨H, hHm, hH01, -, haff, hzero⟩ := exists_field hsys f hfm hf01 hffix
  have hsum : ∀ x, ∀ᵐ ω ∂P, ∑ a, (1 : ℝ) * H a (x, ω) = 1 :=
    haff (fun _ => 1) 1 (Eventually.of_forall fun m => by simp [hfdef])
  have hcirc : ∀ r a b, N r a b → ∀ x : ℂ, ∀ θ : ℝ, ∀ᵐ ω ∂P, H a (x, ω) * H b (x + r * e θ, ω) = 0 := by
    intro r a b hab x θ
    have hr := hN.pos r a b hab
    have hmem : (r : ℂ) ∈ (E : Set ℂ) :=
      mem_algebraicClosure_iff.2 ((hN.alg r a b hab).algebraMap (A := ℂ))
    set z : E := ⟨(r : ℂ), hmem⟩ with hzdef
    have hzc : (z : ℂ) = (r : ℂ) := rfl
    have hz0 : z ≠ 0 := fun h0 => by
      have := congrArg (fun w : E => (w : ℂ)) h0
      simp only [hzc, ZeroMemClass.coe_zero, Complex.ofReal_eq_zero] at this
      exact hr.ne' this
    have hd : dist ((0 : E) : ℂ) (z : ℂ) = r := by
      rw [hzc, ZeroMemClass.coe_zero, Complex.dist_eq, zero_sub, norm_neg, Complex.norm_real, Real.norm_eq_abs,
        abs_of_pos hr]
    have hprem : ∀ᵐ m ∂P, f a m * f b (shiftLab z m) = 0 := by
      filter_upwards [hCae] with m hm
      by_cases h0 : m 0 = a
      · by_cases h1 : m z = b
        · exfalso
          have := hm 0 z
          rw [hd, h0, h1] at this
          exact this hab
        · have h1' : ¬ shiftLab z m 0 = b := by
            show ¬ m (0 + z) = b
            rwa [zero_add]
          simp only [hfdef, h1', if_false, mul_zero]
      · simp only [hfdef, h0, if_false, zero_mul]
    have hw : ‖(r : ℂ) * e θ‖ = ‖(z : ℂ)‖ := by
      rw [norm_mul, norm_e, mul_one, hzc]
    exact hzero a b z hz0 hprem x _ hw
  -- (F6) Tonelli: one sample `ω` with null forbidden pairs at every forbidden distance, and null set of points where
  -- no field is positive
  have hpair1 : ∀ r a b, N r a b → ∀ᵐ ω ∂P, (volume.prod arcLength)
      {q : ℂ × ℝ | 0 < H a (q.1, ω) ∧ 0 < H b (q.1 + r * e q.2, ω)} = 0 := by
    intro r a b hab
    set B : Set ((E → Λ) × (ℂ × ℝ)) := {p | 0 < H a (p.2.1, p.1) ∧ 0 < H b (p.2.1 + r * e p.2.2, p.1)} with hB
    have hBm : MeasurableSet B := by
      refine (measurableSet_lt (f := fun _ : (E → Λ) × (ℂ × ℝ) => (0 : ℝ)) measurable_const ?_).inter
        (measurableSet_lt (f := fun _ : (E → Λ) × (ℂ × ℝ) => (0 : ℝ)) measurable_const ?_)
      · exact (hHm a).comp ((measurable_fst.comp measurable_snd).prodMk measurable_fst)
      · exact (hHm b).comp (((measurable_fst.comp measurable_snd).add
          (measurable_const.mul (continuous_e.measurable.comp (measurable_snd.comp measurable_snd)))).prodMk
          measurable_fst)
    have h0 : (P.prod ((volume : Measure ℂ).prod arcLength)) B = 0 := by
      rw [Measure.prod_apply_symm hBm]
      refine (lintegral_congr fun q => ?_).trans lintegral_zero
      refine measure_mono_null (fun ω hω => ?_) (ae_iff.1 (hcirc r a b hab q.1 q.2))
      exact (mul_pos hω.1 hω.2).ne'
    filter_upwards [Measure.measure_ae_null_of_prod_null h0] with ω hω
    exact hω
  have hbad1 : ∀ᵐ ω ∂P, volume {x : ℂ | ∀ a, H a (x, ω) ≤ 0} = 0 := by
    set G : Set ((E → Λ) × ℂ) := {p | ∀ a, H a (p.2, p.1) ≤ 0} with hG
    have hGm : MeasurableSet G := by
      rw [hG, setOf_forall]
      exact MeasurableSet.iInter fun a =>
        measurableSet_le ((hHm a).comp (measurable_snd.prodMk measurable_fst)) measurable_const
    have h0 : (P.prod (volume : Measure ℂ)) G = 0 := by
      rw [Measure.prod_apply_symm hGm]
      refine (lintegral_congr fun x => ?_).trans lintegral_zero
      refine measure_mono_null (fun ω hω => ?_) (ae_iff.1 (hsum x))
      have hz : ∑ a, (1 : ℝ) * H a (x, ω) = 0 :=
        Finset.sum_eq_zero fun a _ => by rw [one_mul]; exact le_antisymm (hω a) (hH01 a (x, ω)).1
      show ¬ ∑ a, (1 : ℝ) * H a (x, ω) = 1
      rw [hz]
      exact zero_ne_one
    filter_upwards [Measure.measure_ae_null_of_prod_null h0] with ω hω
    exact hω
  haveI := hN.countable.to_subtype
  have hpairs : ∀ᵐ ω ∂P, ∀ i : {r | ∃ a b, N r a b} × Λ × Λ, N i.1 i.2.1 i.2.2 → (volume.prod arcLength)
      {q : ℂ × ℝ | 0 < H i.2.1 (q.1, ω) ∧ 0 < H i.2.2 (q.1 + (i.1 : ℝ) * e q.2, ω)} = 0 :=
    ae_all_iff.2 fun i => by
      by_cases hi : N i.1 i.2.1 i.2.2
      · filter_upwards [hpair1 _ _ _ hi] with ω hω _ using hω
      · exact Eventually.of_forall fun ω h' => absurd h' hi
  obtain ⟨ω, hω1, hω2⟩ := (hpairs.and hbad1).exists
  -- the sample's labelling: a label whose field is positive at `x`, where there is one
  set Bad : Set ℂ := {x | ∀ a, H a (x, ω) ≤ 0} with hBad
  have hBadm : MeasurableSet Bad := by
    rw [hBad, setOf_forall]
    exact MeasurableSet.iInter fun a =>
      measurableSet_le ((hHm a).comp (measurable_id.prodMk measurable_const)) measurable_const
  let pos : ℂ → Λ → Bool := fun x a => decide (0 < H a (x, ω))
  let g : (Λ → Bool) → Λ := fun S => if hS : ∃ a, S a = true then hS.choose else ℓ 0
  have hpos : Measurable pos := measurable_pi_iff.2 fun a => measurable_to_bool (by
    have : (fun x => pos x a) ⁻¹' {true} = {x | 0 < H a (x, ω)} := by
      ext x
      simp [pos]
    rw [this]
    exact measurableSet_lt measurable_const ((hHm a).comp (measurable_id.prodMk measurable_const)))
  have hℓm : Measurable (fun x => g (pos x)) := (measurable_of_finite g).comp hpos
  have hℓpos : ∀ x, x ∉ Bad → 0 < H (g (pos x)) (x, ω) := by
    intro x hx
    have hS : ∃ a, pos x a = true := by
      by_contra hn
      refine hx fun a => not_lt.1 fun ha => hn ⟨a, ?_⟩
      simpa [pos] using ha
    have h1 : g (pos x) = hS.choose := dif_pos hS
    rw [h1]
    simpa [pos] using hS.choose_spec
  refine ⟨fun x => g (pos x), fun a => hℓm (measurableSet_singleton a), fun r => ?_⟩
  -- the pairs with an endpoint where no field is positive are null
  have hfst : ∀ᵐ q ∂(volume : Measure ℂ).prod arcLength, q.1 ∉ Bad :=
    Measure.quasiMeasurePreserving_fst.ae (measure_eq_zero_iff_ae_notMem.1 hω2)
  have hsnd : ∀ᵐ q ∂(volume : Measure ℂ).prod arcLength, q.1 + r * e q.2 ∉ Bad := by
    have hm2 : MeasurableSet ((fun q : ℂ × ℝ => q.1 + r * e q.2) ⁻¹' Bad) :=
      (measurable_fst.add (measurable_const.mul (continuous_e.measurable.comp measurable_snd))) hBadm
    refine (measure_eq_zero_iff_ae_notMem (s := (fun q : ℂ × ℝ => q.1 + r * e q.2) ⁻¹' Bad)).1 ?_
    rw [Measure.prod_apply_symm hm2]
    refine (lintegral_congr fun θ => ?_).trans lintegral_zero
    show volume ((fun x : ℂ => x + r * e θ) ⁻¹' Bad) = 0
    rw [measure_preimage_add_right]
    exact hω2
  have hpr : ∀ᵐ q ∂(volume : Measure ℂ).prod arcLength, ∀ a b : Λ, N r a b →
      ¬ (0 < H a (q.1, ω) ∧ 0 < H b (q.1 + r * e q.2, ω)) :=
    ae_all_iff.2 fun a => ae_all_iff.2 fun b => by
      by_cases hab : N r a b
      · filter_upwards [measure_eq_zero_iff_ae_notMem.1 (hω1 ⟨⟨r, a, b, hab⟩, a, b⟩ hab)] with q hq _ using hq
      · exact Eventually.of_forall fun q h' => absurd h' hab
  filter_upwards [hfst, hsnd, hpr] with q h1 h2 h3 hq
  exact h3 _ _ hq ⟨hℓpos _ h1, hℓpos _ h2⟩

/-- **C133-PAIR, converse** (step (B)): a labelling with Lebesgue-measurable fibres that is admissible almost
everywhere gives a labelling admissible at every pair of points of the plane. The distances need not be
algebraic. -/
theorem exists_admissibleOn_of_ae [Finite Λ] {N : ℝ → Λ → Λ → Prop} (hcount : {r | ∃ a b, N r a b}.Countable)
    (hpos : ∀ r a b, N r a b → 0 < r) {ℓ' : ℂ → Λ} (hm : ∀ a, NullMeasurableSet (ℓ' ⁻¹' {a}) volume)
    (h : AdmissibleAe N ℓ') : ∃ ℓ : ℂ → Λ, AdmissibleOn N univ ℓ := by
  sorry

/-- **C133-PAIR, first clause**: an admissible labelling of the plane exists if and only if a Lebesgue-measurable
labelling admissible almost everywhere exists. The direction from left to right rests on the declared outside
theorem `Spectral.residual_fourier`. -/
theorem exists_admissibleOn_univ_iff_ae [Finite Λ] {N : ℝ → Λ → Λ → Prop} (hN : IsAlgPattern N) :
    (∃ ℓ : ℂ → Λ, AdmissibleOn N univ ℓ) ↔
      ∃ ℓ : ℂ → Λ, (∀ a, NullMeasurableSet (ℓ ⁻¹' {a}) volume) ∧ AdmissibleAe N ℓ := by
  constructor
  · rintro ⟨ℓ, hℓ⟩
    obtain ⟨ℓ', hm, hae⟩ := exists_measurable_admissibleAe hN (hℓ.mono (subset_univ _))
    exact ⟨ℓ', fun a => (hm a).nullMeasurableSet, hae⟩
  · rintro ⟨ℓ, hm, hae⟩
    exact exists_admissibleOn_of_ae hN.countable hN.pos hm hae

/-- **C133-PAIR, second clause**: an admissible labelling of the plane exists if and only if one of the algebraic
plane exists. The direction from right to left rests on the declared outside theorem
`Spectral.residual_fourier`. -/
theorem exists_admissibleOn_univ_iff_algPlane [Finite Λ] {N : ℝ → Λ → Λ → Prop} (hN : IsAlgPattern N) :
    (∃ ℓ : ℂ → Λ, AdmissibleOn N univ ℓ) ↔ ∃ ℓ : ℂ → Λ, AdmissibleOn N (E : Set ℂ) ℓ := by
  constructor
  · rintro ⟨ℓ, hℓ⟩
    exact ⟨ℓ, hℓ.mono (subset_univ _)⟩
  · rintro ⟨ℓ, hℓ⟩
    obtain ⟨ℓ', hm, hae⟩ := exists_measurable_admissibleAe hN hℓ
    exact exists_admissibleOn_of_ae hN.countable hN.pos (fun a => (hm a).nullMeasurableSet) hae

end HadwigerNelson.OneClass
