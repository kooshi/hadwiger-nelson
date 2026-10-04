import Proofs.HadwigerNelson.Plane.CPColouring
import Proofs.HadwigerNelson.Plane.Cover
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Periodic
import Mathlib.MeasureTheory.Integral.Indicator

/-!
# Forced translations of a CP colouring (FS-131 wave 2)

Row: **FS129-OA1-NOPERLAW**. Plan: `plans/FS131-w2-kernel-plan.md` § 4. The object is the foundation's `CPColouring`
(a stationary random colouring, continuous in probability, proper almost surely on every unit pair, as its law). The
inhabitant `sq9CP` is the CP colouring every theorem here is witnessed by.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology

variable {k : ℕ}

/-! ### The inhabitant's construction: `sq9` under a uniform random translation of the period torus -/

/-- `sq9Index` is periodic with period `3/2`. -/
theorem sq9Index_periodic : Function.Periodic sq9Index (3 / 2 : ℝ) := by
  intro t
  unfold sq9Index
  have : ⌊2 * (t + 3 / 2)⌋ = ⌊2 * t⌋ + 3 := by
    rw [show 2 * (t + 3 / 2) = 2 * t + (3 : ℤ) by push_cast; ring, Int.floor_add_intCast]
  rw [this]; push_cast
  have h3 : (3 : ZMod 3) = 0 := by decide
  rw [h3, add_zero]

local instance : Fact (0 < (3 / 2 : ℝ)) := ⟨by norm_num⟩

/-- The square index of a point of the circle `ℝ / (3/2)ℤ`. -/
noncomputable def cIdx (t : AddCircle (3 / 2 : ℝ)) : ZMod 3 := sq9Index (AddCircle.equivIoc (3 / 2 : ℝ) 0 t).1

/-- `cIdx` on the circle `ℝ/(3/2)ℤ` reads `sq9Index` at a representative. -/
theorem cIdx_coe (a : ℝ) : cIdx (a : AddCircle (3 / 2 : ℝ)) = sq9Index a := by
  unfold cIdx
  have h : (AddCircle.equivIoc (3 / 2 : ℝ) 0 (a : AddCircle (3 / 2 : ℝ))).1 = toIocMod (by norm_num : (0 : ℝ) < 3 / 2) 0 a := by
    have := QuotientAddGroup.equivIocMod_coe (by norm_num : (0 : ℝ) < 3 / 2) 0 a
    exact congrArg Subtype.val this
  rw [h]
  have h2 := self_sub_toIocMod (by norm_num : (0 : ℝ) < 3 / 2) 0 a
  have : toIocMod (by norm_num : (0 : ℝ) < 3 / 2) 0 a = a - toIocDiv (by norm_num : (0 : ℝ) < 3 / 2) 0 a • (3 / 2 : ℝ) := by linarith
  rw [this]
  exact sq9Index_periodic.sub_zsmul_eq _


/-- The period torus `(ℝ / (3/2)ℤ)²`. -/
abbrev Tor := AddCircle (3 / 2 : ℝ) × AddCircle (3 / 2 : ℝ)

/-- The point of the torus under `y`. -/
noncomputable def torPt (y : ℂ) : Tor := ((y.re : ℝ), (y.im : ℝ))

/-- `torPt` is additive. -/
theorem torPt_add (y z : ℂ) : torPt (y + z) = torPt y + torPt z := by
  simp [torPt]

/-- `sq9`'s colour as a function on the torus. -/
noncomputable def torCol (t : Tor) : Fin 9 := finProdFinEquiv (cIdx t.1, cIdx t.2)

/-- The torus colouring at the image of `(a, b)` is `sq9Col (a + b i)`. -/
theorem torCol_coe (a b : ℝ) : torCol (((a : ℝ) : AddCircle (3 / 2 : ℝ)), ((b : ℝ) : AddCircle (3 / 2 : ℝ))) =
    sq9Col ⟨a, b⟩ := by
  simp [torCol, sq9Col, cIdx_coe]

/-- The torus colouring moved by `torPt z` is `sq9Col` moved by `z`. -/
theorem torCol_pt_add (a b : ℝ) (z : ℂ) :
    torCol ((((a : ℝ) : AddCircle (3 / 2 : ℝ)), ((b : ℝ) : AddCircle (3 / 2 : ℝ))) + torPt z) = sq9Col (⟨a, b⟩ + z) := by
  have : ((((a : ℝ) : AddCircle (3 / 2 : ℝ)), ((b : ℝ) : AddCircle (3 / 2 : ℝ))) + torPt z : Tor) =
      (((a + z.re : ℝ) : AddCircle (3 / 2 : ℝ)), ((b + z.im : ℝ) : AddCircle (3 / 2 : ℝ))) := by
    simp [torPt]
  rw [this, torCol_coe]; rfl

/-- Every point of the torus is the image of a pair of reals. -/
theorem exists_coe_eq (t : Tor) : ∃ a b : ℝ, t = (((a : ℝ) : AddCircle (3 / 2 : ℝ)), ((b : ℝ) : AddCircle (3 / 2 : ℝ))) := by
  obtain ⟨a, ha⟩ := QuotientAddGroup.mk_surjective t.1
  obtain ⟨b, hb⟩ := QuotientAddGroup.mk_surjective t.2
  exact ⟨a, b, Prod.ext ha.symm hb.symm⟩

/-- `cIdx` is measurable. -/
theorem measurable_cIdx : Measurable cIdx := by
  have hs : Measurable sq9Index := by
    unfold sq9Index
    exact (measurable_of_countable (fun n : ℤ => (n : ZMod 3))).comp (Int.measurable_floor.comp (measurable_const.mul measurable_id))
  exact hs.comp (measurable_subtype_coe.comp (AddCircle.measurableEquivIoc (3 / 2 : ℝ) 0).measurable)

/-- The torus colouring is measurable. -/
theorem measurable_torCol : Measurable torCol := by
  have h1 : Measurable fun t : Tor => (cIdx t.1, cIdx t.2) :=
    (measurable_cIdx.comp measurable_fst).prodMk (measurable_cIdx.comp measurable_snd)
  have h2 : Measurable (fun p : ZMod 3 × ZMod 3 => (finProdFinEquiv p : Fin 9)) := by
    haveI : MeasurableSingletonClass (ZMod 3 × ZMod 3) := inferInstance
    exact measurable_of_finite _
  exact h2.comp h1


/-- The random colouring at the torus point `t`: `y ↦ sq9 (y + t)`. -/
noncomputable def torField (t : Tor) : ℂ → Fin 9 := fun y => torCol (t + torPt y)

/-- The family of plane colourings indexed by the torus is measurable. -/
theorem measurable_torField : Measurable torField :=
  measurable_pi_lambda _ fun _ => measurable_torCol.comp (measurable_id.add_const _)

/-- Shifting the colouring at `t` by `x` gives the colouring at `t + torPt x`. -/
theorem torField_shift (x : ℂ) (t : Tor) : shiftCol x (torField t) = torField (t + torPt x) := by
  funext y
  simp only [shiftCol, torField, torPt_add, add_assoc, add_comm (torPt x)]

/-- The torus `(ℝ/(3/2)ℤ)²` has area `(3/2)²`. -/
theorem volume_tor_univ : (volume : Measure Tor) univ = ENNReal.ofReal (3 / 2) * ENNReal.ofReal (3 / 2) := by
  rw [Measure.volume_eq_prod, ← univ_prod_univ, Measure.prod_prod, AddCircle.measure_univ]

/-- The law of the torus-random colouring. -/
noncomputable def cpLaw : Measure (ℂ → Fin 9) :=
  (ENNReal.ofReal (3 / 2) * ENNReal.ofReal (3 / 2))⁻¹ • (volume : Measure Tor).map torField

/-- The stationary law of `sq9` is the normalized torus measure pulled back through `torField`. -/
theorem cpLaw_apply {S : Set (ℂ → Fin 9)} (hS : MeasurableSet S) :
    cpLaw S = (ENNReal.ofReal (3 / 2) * ENNReal.ofReal (3 / 2))⁻¹ * volume (torField ⁻¹' S) := by
  rw [cpLaw, Measure.smul_apply, Measure.map_apply measurable_torField hS, smul_eq_mul]

instance : (volume : Measure Tor).IsAddLeftInvariant := by
  rw [Measure.volume_eq_prod]; infer_instance

/-- The stationary law of `sq9` is invariant under every translation. -/
theorem cpLaw_map_shift (x : ℂ) : cpLaw.map (shiftCol x) = cpLaw := by
  rw [cpLaw, Measure.map_smul, Measure.map_map (measurable_shiftCol x) measurable_torField]
  congr 1
  have : (shiftCol x ∘ torField) = torField ∘ (· + torPt x) := by
    funext t; exact torField_shift x t
  have hm : Measurable (fun t : Tor => t + torPt x) := measurable_add_const _
  have hmp : Measure.map (fun t : Tor => t + torPt x) (volume : Measure Tor) = volume :=
    by simpa only [add_comm _ (torPt x)] using (measurePreserving_add_left (volume : Measure Tor) (torPt x)).map_eq
  rw [this, ← Measure.map_map measurable_torField hm, hmp]


/-- Area on the torus is invariant under translation. -/
theorem vol_tor_shift (v : Tor) {S : Set Tor} (hS : MeasurableSet S) : volume {t : Tor | t + v ∈ S} = volume S := by
  have := (measurePreserving_add_left (volume : Measure Tor) v).measure_preimage hS.nullMeasurableSet
  have e : {t : Tor | t + v ∈ S} = (fun x => v + x) ⁻¹' S := by ext t; simp [add_comm]
  rw [e]; exact this

/-- The half-integer points of the circle. -/
def halfPts : Set (AddCircle (3 / 2 : ℝ)) := range fun n : ℤ => (((n : ℝ) / 2 : ℝ) : AddCircle (3 / 2 : ℝ))

/-- The countable set `halfPts` of the circle `ℝ/(3/2)ℤ` is null. -/
theorem volume_halfPts : volume halfPts = 0 := by
  have hc : halfPts.Countable := countable_range _
  rw [AddCircle.add_projection_respects_measure (3 / 2 : ℝ) 0 hc.measurableSet]
  refine measure_mono_null (t := range fun k : ℤ => (k : ℝ) / 2) ?_ ((countable_range _).measure_zero volume)
  rintro a ⟨⟨n, hn⟩, -⟩
  have h : (((a - (n : ℝ) / 2 : ℝ)) : AddCircle (3 / 2 : ℝ)) = 0 := by
    rw [AddCircle.coe_sub, sub_eq_zero]; exact hn.symm
  obtain ⟨m, hm⟩ := (AddCircle.coe_eq_zero_iff (3 / 2 : ℝ)).1 h
  refine ⟨n + 3 * m, ?_⟩
  push_cast
  simp only [zsmul_eq_mul] at hm
  linarith

/-- Off the half-integers, `sq9Index` is locally constant. -/
theorem sq9Index_eventually {a : ℝ} (ha : ∀ n : ℤ, 2 * a ≠ n) : ∀ᶠ s in 𝓝 (0 : ℝ), sq9Index (a + s) = sq9Index a := by
  have h1 : (⌊2 * a⌋ : ℝ) < 2 * a := lt_of_le_of_ne (Int.floor_le _) (ha _).symm
  have h2 : 2 * a < ⌊2 * a⌋ + 1 := Int.lt_floor_add_one _
  have hopen : IsOpen {s : ℝ | (⌊2 * a⌋ : ℝ) < 2 * (a + s) ∧ 2 * (a + s) < ⌊2 * a⌋ + 1} :=
    (isOpen_lt (continuous_const : Continuous fun _ : ℝ => (⌊2 * a⌋ : ℝ)) (by fun_prop : Continuous fun s : ℝ => 2 * (a + s))).inter
      (isOpen_lt (by fun_prop : Continuous fun s : ℝ => 2 * (a + s)) (continuous_const : Continuous fun _ : ℝ => (⌊2 * a⌋ : ℝ) + 1))
  filter_upwards [hopen.mem_nhds (by simp only [mem_setOf_eq, add_zero]; exact ⟨h1, h2⟩)] with s hs
  have : ⌊2 * (a + s)⌋ = ⌊2 * a⌋ := by
    rw [Int.floor_eq_iff]; exact ⟨by linarith [hs.1], by linarith [hs.2]⟩
  unfold sq9Index; rw [this]


/-- The stationary law of `sq9` is a probability measure. -/
theorem isProbabilityMeasure_cpLaw : IsProbabilityMeasure cpLaw := by
  refine ⟨?_⟩
  rw [cpLaw_apply MeasurableSet.univ, preimage_univ, volume_tor_univ]
  exact ENNReal.inv_mul_cancel (by simp) (ENNReal.mul_ne_top ENNReal.ofReal_ne_top ENNReal.ofReal_ne_top)

/-- The colouring at the image of `(a, b)` is `sq9Col` moved by `a + b i`. -/
theorem torField_eq (a b : ℝ) (z : ℂ) :
    torField (((a : ℝ) : AddCircle (3 / 2 : ℝ)), ((b : ℝ) : AddCircle (3 / 2 : ℝ))) z = sq9Col (⟨a, b⟩ + z) :=
  torCol_pt_add a b z

/-- The stationary law of `sq9` is proper at every unit pair. -/
theorem cpLaw_proper (x w : ℂ) (hw : ‖w‖ = 1) : cpLaw {f | f x = f (x + w)} = 0 := by
  have hm : MeasurableSet {f : ℂ → Fin 9 | f x = f (x + w)} :=
    measurableSet_eq_fun (measurable_pi_apply x) (measurable_pi_apply _)
  rw [cpLaw_apply hm]
  have : torField ⁻¹' {f : ℂ → Fin 9 | f x = f (x + w)} = ∅ := by
    refine eq_empty_of_forall_notMem fun t ht => ?_
    obtain ⟨a, b, rfl⟩ := exists_coe_eq t
    simp only [mem_preimage, mem_setOf_eq, torField_eq] at ht
    refine sq9Col_ne_of_dist_eq_one (x := (⟨a, b⟩ : ℂ) + x) (y := (⟨a, b⟩ : ℂ) + (x + w)) ?_ ht
    rw [dist_eq_norm, show (⟨a, b⟩ : ℂ) + x - ((⟨a, b⟩ : ℂ) + (x + w)) = -w by ring, norm_neg, hw]
  rw [this, measure_empty, mul_zero]


/-- The torus points where the colour changes under a translation by `d`. -/
def torChange (d : ℂ) : Set Tor := {t | torCol t ≠ torCol (t + torPt d)}

/-- The torus points whose colour changes under a shift by `d` form a measurable set. -/
theorem measurableSet_torChange (d : ℂ) : MeasurableSet (torChange d) :=
  (measurableSet_eq_fun measurable_torCol (measurable_torCol.comp (measurable_add_const _))).compl

/-- The area of the torus points whose colour changes under a shift by `d` tends to `0` with `d`. -/
theorem tendsto_volume_torChange : Tendsto (fun d : ℂ => volume (torChange d)) (𝓝 0) (𝓝 0) := by
  have hnull : (volume : Measure Tor) (halfPts ×ˢ univ ∪ univ ×ˢ halfPts) = 0 := by
    refine measure_union_null ?_ ?_ <;> rw [Measure.volume_eq_prod, Measure.prod_prod]
    · rw [volume_halfPts, zero_mul]
    · rw [volume_halfPts, mul_zero]
  have key := tendsto_measure_of_ae_tendsto_indicator_of_isFiniteMeasure (μ := (volume : Measure Tor))
    (𝓝 (0 : ℂ)) (A := (∅ : Set Tor)) MeasurableSet.empty measurableSet_torChange (As := torChange) ?_
  · simpa using key
  · filter_upwards [measure_eq_zero_iff_ae_notMem.1 hnull] with t ht
    have h1 : t.1 ∉ halfPts := fun h => ht (Or.inl ⟨h, mem_univ _⟩)
    have h2 : t.2 ∉ halfPts := fun h => ht (Or.inr ⟨mem_univ _, h⟩)
    obtain ⟨a, b, rfl⟩ := exists_coe_eq t
    have ha : ∀ n : ℤ, 2 * a ≠ n := fun n hn => h1 ⟨n, by
      show (((n : ℝ) / 2 : ℝ) : AddCircle (3 / 2 : ℝ)) = _
      rw [show (n : ℝ) / 2 = a by linarith]⟩
    have hb : ∀ n : ℤ, 2 * b ≠ n := fun n hn => h2 ⟨n, by
      show (((n : ℝ) / 2 : ℝ) : AddCircle (3 / 2 : ℝ)) = _
      rw [show (n : ℝ) / 2 = b by linarith]⟩
    have hre : Tendsto (fun d : ℂ => d.re) (𝓝 0) (𝓝 0) := by simpa using Complex.continuous_re.tendsto 0
    have him : Tendsto (fun d : ℂ => d.im) (𝓝 0) (𝓝 0) := by simpa using Complex.continuous_im.tendsto 0
    filter_upwards [hre.eventually (sq9Index_eventually ha), him.eventually (sq9Index_eventually hb)] with d h1 h2
    simp only [torChange, mem_setOf_eq, mem_empty_iff_false, iff_false, not_not]
    have e1 : (((a : ℝ) : AddCircle (3 / 2 : ℝ)), ((b : ℝ) : AddCircle (3 / 2 : ℝ))) + torPt d =
        (((a + d.re : ℝ) : AddCircle (3 / 2 : ℝ)), ((b + d.im : ℝ) : AddCircle (3 / 2 : ℝ))) := by
      simp [torPt]
    rw [e1, torCol_coe, torCol_coe]
    simp only [sq9Col]
    rw [h1, h2]

/-- The stationary law of `sq9` is continuous in probability. -/
theorem cpLaw_tendsto (x : ℂ) : Tendsto (fun y => cpLaw {f | f x ≠ f y}) (𝓝 x) (𝓝 0) := by
  have hmeas : ∀ y, MeasurableSet {f : ℂ → Fin 9 | f x ≠ f y} := fun y =>
    (measurableSet_eq_fun (measurable_pi_apply x) (measurable_pi_apply y)).compl
  have hform : ∀ y, cpLaw {f | f x ≠ f y} =
      (ENNReal.ofReal (3 / 2) * ENNReal.ofReal (3 / 2))⁻¹ * volume (torChange (y - x)) := by
    intro y
    rw [cpLaw_apply (hmeas y), ← vol_tor_shift (torPt x) (measurableSet_torChange (y - x))]
    congr 2
    ext t
    simp only [mem_preimage, mem_setOf_eq, torChange, torField]
    rw [add_assoc, ← torPt_add, add_sub_cancel]
  simp_rw [hform]
  have h0 : Tendsto (fun y : ℂ => y - x) (𝓝 x) (𝓝 0) := tendsto_sub_nhds_zero_iff.2 tendsto_id
  have hc : (ENNReal.ofReal (3 / 2) * ENNReal.ofReal (3 / 2))⁻¹ ≠ ⊤ :=
    ENNReal.inv_ne_top.2 (mul_ne_zero (ENNReal.ofReal_pos.2 (by norm_num)).ne' (ENNReal.ofReal_pos.2 (by norm_num)).ne')
  have := ENNReal.Tendsto.const_mul (tendsto_volume_torChange.comp h0) (Or.inr hc)
  rwa [mul_zero] at this

/-- **Inhabitant**: `sq9` under a uniformly random translation of its period torus `(3/2)ℤ²` — the law of
`y ↦ sq9.col (y + z)`, `z` uniform on `[0, 3/2)²`. -/
theorem nonempty_cpColouring_nine : Nonempty (CPColouring 9) := by
  exact ⟨{ law := cpLaw
           isProbabilityMeasure := isProbabilityMeasure_cpLaw
           map_shift := cpLaw_map_shift
           tendsto_ne := cpLaw_tendsto
           proper := cpLaw_proper }⟩

/-- `Z`: the vectors `x` with `c(0) = c(x)` almost surely. -/
def CPColouring.forcedSet (c : CPColouring k) : Set ℂ := {x | c.law {f | f 0 = f x} = 1}

/-- Stationarity: `P(f(x) ≠ f(y))` depends only on `y - x`. -/
theorem CPColouring.law_shift (c : CPColouring k) (x : ℂ) {s : Set (ℂ → Fin k)} (hs : MeasurableSet s) :
    c.law (shiftCol x ⁻¹' s) = c.law s := by
  rw [← Measure.map_apply (measurable_shiftCol x) hs, c.map_shift]

/-- `{f | f x = f y}` is measurable. -/
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

/-- `P(f x ≠ f y) = 1 − P(f x = f y)`. -/
theorem CPColouring.law_ne_eq (c : CPColouring k) (x y : ℂ) :
    c.law {f | f x ≠ f y} = 1 - c.law {f | f x = f y} := by
  have : {f : ℂ → Fin k | f x ≠ f y} = {f | f x = f y}ᶜ := rfl
  rw [this, prob_compl_eq_one_sub (CPColouring.measurableSet_eq x y)]

/-- The forced set of a CP colouring is closed. -/
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

/-- `P(f a = f b) = 1` exactly when `f a = f b` almost surely. -/
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
