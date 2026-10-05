import Proofs.HadwigerNelson.Plane.ValidMap.Basic

/-!
# Woodall's chain: collars about a unit circle, and the picture at a point (FS131-W's foundation)

The vocabulary of FS106-WO, FS106-TW and FS106-AE-MAP6 (`plans/FS131-W-kernel-plan.md` § 2), extrinsic throughout: predicates on sets and
on one arc map, one two-constructor type.

* **Annular sectors and collars.** `annSector u r₁ r₂ θ₁ θ₂` is the open annular sector `{u + ρ e(θ) : r₁ < ρ < r₂, θ₁ < θ < θ₂}`.
  A **collar** on the side `s` of the unit circle `ω(u)` (`Rim.inner`: radii in `(1 − h, 1)`; `Rim.outer`: radii in `(1, 1 + h)`) is
  `[Woodall1973]`'s "interior, respectively exterior, unit arc of positive thickness" with constant thickness `h` (p. 198); Woodall's variable
  thickness `f(θ)` enters as "a collar about each angle" (`plans/FS131-W-kernel-plan.md` § 3.2's read-back).
* **The picture at a point** (`ArcMap.SectorsAt`, region-only): `n` sectors in counter-clockwise order between directions `d i ≤ d (i + 1)`
  (zero-angle sectors, horns, allowed), adjacent sectors of different colours, the point in the domain, and the cone of each colour class at the
  point equal to the union of its closed sectors (inventory item 155: no clause asks a sector to avoid the arcs, so a sector may be merged across
  an arc between two sides of one colour). It is Woodall's "regions at a vertex
  `P`" after his steps 1–2: adjacent regions of one colour are one sector (step 1), and every edge has a direction (step 2; automatic for arcs).
* **Woodall's normal forms, ∃-forms on a set** (FS131-E3, inventory items 158, 161). `ArcMap.NiceAt v`: some picture at `v` gives
  its positive-angle sectors distinct colours and puts every horn between distinct colours; `ArcMap.WoodallMerged K`: every point of `K`
  of three or more colours is `NiceAt` (his step 3, in the form the chain reads); `ArcMap.WoodallNormal K`: every such point has a picture
  with distinct colours and every angle at least `π/3` (steps 3 and 5, strict step 5 only — FS131-E1's (N1)–(N2)). The ∀-over-pictures
  forms they replace were unsatisfiable on every valid plane map: `SectorsAt` admits phantom horns (E3-PHANTOM).

Spec examples and inhabitants below. The inhabitants of the ∃-forms exercise every clause: `halfDisc.NiceAt 0` (two colours) and
`threeSectorDisc`, a disc cut into three sectors of angle `2π/3`, valid, in both forms on the whole plane (its centre is its one point of
three colours); the adversaries show the old ∀-forms fail there, on a phantom picture.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Annular sectors and collars -/

/-- The open annular sector about `u` between the radii `r₁ < r₂` over the open angles `(θ₁, θ₂)`. -/
noncomputable def annSector (u : ℂ) (r₁ r₂ θ₁ θ₂ : ℝ) : Set ℂ :=
  (fun q : ℝ × ℝ => u + (q.1 : ℂ) * e q.2) '' (Ioo r₁ r₂ ×ˢ Ioo θ₁ θ₂)

/-- The side of the unit circle `ω(u)` a collar lies on. -/
inductive Rim where
  /-- Inside `ω(u)`: radii in `(1 − h, 1)` (Woodall's "interior unit arc"). -/
  | inner
  /-- Outside `ω(u)`: radii in `(1, 1 + h)` (Woodall's "exterior unit arc"). -/
  | outer
  deriving DecidableEq

/-- **A collar** of thickness `h` on the side `s` of `ω(u)` over the open angles `(θ₁, θ₂)`: `[Woodall1973]`'s unit arc of positive thickness
with centre `u`, with constant thickness. -/
noncomputable def collar (u : ℂ) : Rim → ℝ → ℝ → ℝ → Set ℂ
  | .inner, θ₁, θ₂, h => annSector u (1 - h) 1 θ₁ θ₂
  | .outer, θ₁, θ₂, h => annSector u 1 (1 + h) θ₁ θ₂

/-- `S` carries **a collar about the angle `θ`** on the side `s` of `ω(u)`: a collar of some positive thickness and angular half-width
around `θ` lies in `S`. -/
def CollarAt (S : Set ℂ) (u : ℂ) (s : Rim) (θ : ℝ) : Prop := ∃ h > 0, collar u s (θ - h) (θ + h) h ⊆ S

/-! ## The picture at a point of an arc map -/

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- **Woodall's picture at `v`** (region-only): `n ≥ 1` sectors in counter-clockwise order, sector `i` between the directions `d i.castSucc`
and `d i.succ`, `d` monotone with `d (last n) = d 0 + 2π` (so zero-angle sectors, horns, are allowed), of colour `c i`; adjacent sectors carry
different colours (when `n ≥ 2`); `v` is a point of the domain; and the cone of each colour class at `v` is the union of the closed sectors of
that colour. The fifth clause was "for every `δ > 0` a truncated open sector strictly inside each sector lies in its colour class" until inventory
item 155 (FS131-IWb): a sector merged across an arc between two sides of one colour holds points of that arc, so no picture existed at such a point;
its readers go through the cone clause and the domain point instead (`ArcMap.exists_preconnected_of_mem_coneAt`). -/
def SectorsAt (v : ℂ) (n : ℕ) (d : Fin (n + 1) → ℝ) (c : Fin n → Fin k) : Prop :=
  0 < n ∧ Monotone d ∧ d (Fin.last n) = d 0 + 2 * π ∧
    (2 ≤ n → ∀ i : Fin n, c i ≠ c (finRotate n i)) ∧
    v ∈ F.dom ∧
    ∀ j : Fin k, coneAt (F.region j) v = ⋃ i ∈ {i : Fin n | c i = j}, angleIcc (d i.castSucc) (d i.succ)

/-- **Woodall's step 3, in the form the chain reads** (FS131-E3, `plans/FS131-E3-derivation.md` § 4.1): some picture at `v` gives its
positive-angle sectors distinct colours and puts every zero-angle sector (horn) between sectors of distinct colours. An ∃-form: `SectorsAt`
reads only cones, so it admits **phantom horns** (at a boundary direction between `A` and `B`, insert a `B`-horn then an `A`-horn), and a
∀-over-pictures form fails at every point of two or more colours (E3-PHANTOM, inventory item 158; the adversaries
`threeSectorDisc_not_forall_merged`, `threeSectorDisc_not_forall_normal`). -/
def NiceAt (v : ℂ) : Prop :=
  ∃ n d c, F.SectorsAt v n d c ∧
    (∀ i j : Fin n, i ≠ j → c i = c j → d i.castSucc = d i.succ ∨ d j.castSucc = d j.succ) ∧
    ∀ i : Fin n, d i.castSucc = d i.succ → c ((finRotate n).symm i) ≠ c (finRotate n i)

/-- **Woodall's step 3, its conclusion on a set** (∃-form, FS131-E3): every point of `K` carrying three or more colours is `NiceAt`.
Woodall's own conclusion ("if two of the regions are in the same set, then each of them subtends angle 0 at P", `[Woodall1973]` p. 197) is
the stronger horn-only form, not needed by the chain (inventory item 161 (b)). -/
def WoodallMerged (K : Set ℂ) : Prop := ∀ v ∈ K, 3 ≤ (F.coloursAt v).ncard → F.NiceAt v

/-- **Woodall's normal form on a set** (∃-form, FS131-E3; step 3, and step 5 in its strict form): every point of `K` carrying three or
more colours has a picture with distinct colours and every angle at least `π/3` — FS131-E1's (N1) on colours and (N2)
(`plans/FS131-E1-derivation.md` § 3.0). Strict step 5 (`step5_lt`) excludes angles below `π/3` only; the restored chain never reads the
angle `π/3` itself. -/
def WoodallNormal (K : Set ℂ) : Prop :=
  ∀ v ∈ K, 3 ≤ (F.coloursAt v).ncard →
    ∃ n d c, F.SectorsAt v n d c ∧ Function.Injective c ∧ ∀ i : Fin n, π / 3 ≤ d i.succ - d i.castSucc

end ArcMap

/-! ## Spec examples (each fails if its definition drifts) -/

/-- `annSector` holds the point at radius `1/2` on the angle `0`. -/
example : (1 / 2 : ℂ) ∈ annSector 0 0 1 (-1) 1 :=
  ⟨(1 / 2, 0), ⟨⟨by norm_num, by norm_num⟩, ⟨by norm_num, by norm_num⟩⟩, by simp [e]⟩

/-- **Adversary**: the centre is in no annular sector of positive inner radius `0` — its points have `‖z − u‖ = ρ > 0`. -/
example (θ₁ θ₂ : ℝ) : (0 : ℂ) ∉ annSector 0 0 1 θ₁ θ₂ := by
  rintro ⟨⟨ρ, θ⟩, ⟨hρ, -⟩, h⟩
  simp only at h hρ
  have : ‖(0 : ℂ) + (ρ : ℂ) * e θ‖ = ρ := by
    rw [zero_add, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hρ.1]
  rw [h, norm_zero] at this
  exact hρ.1.ne' this.symm

/-- The inner collar of thickness `1/2` about `ω(0)` over `(−1, 1)` holds `3/4`; the outer one holds `5/4`. -/
example : (3 / 4 : ℂ) ∈ collar 0 .inner (-1) 1 (1 / 2) ∧ (5 / 4 : ℂ) ∈ collar 0 .outer (-1) 1 (1 / 2) :=
  ⟨⟨(3 / 4, 0), ⟨⟨by norm_num, by norm_num⟩, ⟨by norm_num, by norm_num⟩⟩, by simp [e]⟩,
    ⟨(5 / 4, 0), ⟨⟨by norm_num, by norm_num⟩, ⟨by norm_num, by norm_num⟩⟩, by simp [e]⟩⟩

/-- **Adversary**: a collar of thickness at most `1` never meets its own unit circle — `1 = e 0` is in neither collar of `ω(0)`. -/
example (s : Rim) {h : ℝ} (hh : h ≤ 1) : (1 : ℂ) ∉ collar 0 s (-1) 1 h := by
  have key : ∀ r₁ r₂ : ℝ, 0 ≤ r₁ → (r₂ ≤ 1 ∨ 1 ≤ r₁) → (1 : ℂ) ∉ annSector 0 r₁ r₂ (-1) 1 := by
    rintro r₁ r₂ h0 hr ⟨⟨ρ, θ⟩, ⟨hρ, -⟩, hz⟩
    simp only at hz hρ
    have h1 : ‖(0 : ℂ) + (ρ : ℂ) * e θ‖ = |ρ| := by
      rw [zero_add, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs]
    rw [hz, norm_one, abs_of_pos (by linarith [hρ.1])] at h1
    rcases hr with hr | hr
    · linarith [hρ.2]
    · linarith [hρ.1]
  cases s
  · exact key _ _ (by linarith) (Or.inl le_rfl)
  · exact key _ _ zero_le_one (Or.inr le_rfl)

/-- Every angle lies in some `2π`-translate of `[0, 2π]`. -/
theorem angleIcc_zero_two_pi : angleIcc 0 (2 * π) = univ := by
  refine eq_univ_of_forall fun x => mem_iUnion.mpr ⟨⌊x / (2 * π)⌋, ?_, ?_⟩
  · have h := Int.floor_le (x / (2 * π))
    have := (le_div_iff₀ (by positivity : (0 : ℝ) < 2 * π)).mp h
    linarith
  · have h := Int.lt_floor_add_one (x / (2 * π))
    have := (div_lt_iff₀ (by positivity : (0 : ℝ) < 2 * π)).mp h
    linarith

/-- The whole plane approaches every point along every direction. -/
theorem coneAt_univ (v : ℂ) : coneAt univ v = univ := by
  refine eq_univ_of_forall fun β ε hε => ⟨v + ((ε / 2 : ℝ) : ℂ) * e β, mem_univ _, ?_, ?_, ?_⟩
  · intro h
    have := congrArg (fun z => ‖z - v‖) h
    simp only [add_sub_cancel_left, sub_self, norm_zero, norm_mul, norm_e, mul_one, Complex.norm_real,
      Real.norm_eq_abs] at this
    rw [abs_of_pos (by positivity)] at this
    linarith
  · rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by positivity)]
    linarith
  · have hn : ‖v + ((ε / 2 : ℝ) : ℂ) * e β - v‖ = ε / 2 := by
      rw [add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
        abs_of_pos (by positivity)]
    rw [hn, add_sub_cancel_left]
    have h2 : ((ε / 2 : ℝ) : ℂ) ≠ 0 := by exact_mod_cast (by positivity : ε / 2 ≠ 0)
    rw [mul_div_cancel_left₀ _ h2, sub_self, norm_zero]
    exact hε

/-! ## Polar coordinates, and the cone of an open sector at its apex (children of the inhabitants' leaves; FS131-IWc) -/

/-- A point at radius `s ≥ 0` along a direction lies at distance `s`. -/
theorem norm_real_mul_e {s : ℝ} (hs : 0 ≤ s) (θ : ℝ) : ‖(s : ℂ) * e θ‖ = s := by
  rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg hs]

/-- Polar coordinates about `v` are injective in the radius, and in the direction up to `2π`. -/
theorem polar_inj {v : ℂ} {s s' θ θ' : ℝ} (hs : 0 < s) (hs' : 0 ≤ s') (h : v + (s : ℂ) * e θ = v + (s' : ℂ) * e θ') :
    s = s' ∧ e θ = e θ' := by
  have h1 : (s : ℂ) * e θ = (s' : ℂ) * e θ' := by linear_combination h
  have hss : s = s' := by
    have := congrArg norm h1
    rwa [norm_real_mul_e hs.le, norm_real_mul_e hs'] at this
  refine ⟨hss, ?_⟩
  rw [← hss] at h1
  exact mul_left_cancel₀ (by exact_mod_cast hs.ne') h1

/-- Two directions less than `2π` apart are different. -/
theorem e_ne_e_of_lt {θ θ' : ℝ} (h1 : θ < θ') (h2 : θ' < θ + 2 * π) : e θ ≠ e θ' := by
  intro he
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp he.symm
  have hπ := Real.pi_pos
  have h0 : (0 : ℝ) * (2 * π) < n * (2 * π) := by linarith
  have h1' : (n : ℝ) * (2 * π) < 1 * (2 * π) := by linarith
  have hn1 : (0 : ℝ) < n := lt_of_mul_lt_mul_right h0 (by positivity)
  have hn2 : (n : ℝ) < 1 := lt_of_mul_lt_mul_right h1' (by positivity)
  have : (0 : ℤ) < n := by exact_mod_cast hn1
  have : n < 1 := by exact_mod_cast hn2
  omega

/-- Two angles in `(0, 2π]` with one direction are equal. -/
theorem eq_of_e_eq_of_mem_Ioc {θ θ' : ℝ} (h : θ ∈ Ioc 0 (2 * π)) (h' : θ' ∈ Ioc 0 (2 * π)) (he : e θ = e θ') : θ = θ' := by
  rcases lt_trichotomy θ θ' with hl | hl | hl
  · exact absurd he (e_ne_e_of_lt hl (by linarith [h.1, h'.2]))
  · exact hl
  · exact absurd he.symm (e_ne_e_of_lt hl (by linarith [h'.1, h.2]))

/-- The closure of an annular sector lies in the image of its closed radii and closed angles (a compact set). -/
theorem closure_annSector_subset (u : ℂ) {r₁ r₂ θ₁ θ₂ : ℝ} (hr : r₁ ≤ r₂) (hθ : θ₁ ≤ θ₂) :
    closure (annSector u r₁ r₂ θ₁ θ₂) ⊆ (fun q : ℝ × ℝ => u + (q.1 : ℂ) * e q.2) '' (Icc r₁ r₂ ×ˢ Icc θ₁ θ₂) := by
  have _ := hr
  have _ := hθ
  have hf : Continuous fun q : ℝ × ℝ => u + (q.1 : ℂ) * e q.2 := by have := continuous_e; fun_prop
  refine closure_minimal ?_ ((isCompact_Icc.prod isCompact_Icc).image hf).isClosed
  rintro _ ⟨q, ⟨h1, h2⟩, rfl⟩
  exact ⟨q, ⟨Ioo_subset_Icc_self h1, Ioo_subset_Icc_self h2⟩, rfl⟩

/-- An open annular sector at `v` approaches `v` along each of its open directions. -/
theorem mem_coneAt_annSector (v : ℂ) {r a b γ : ℝ} (hr : 0 < r) (hγ : γ ∈ Ioo a b) : γ ∈ coneAt (annSector v 0 r a b) v := by
  intro ε hε
  set t := min r ε / 2 with ht
  have ht0 : 0 < t := by positivity
  have htr : t < r := by have := min_le_left r ε; linarith
  have htε : t < ε := by have := min_le_right r ε; linarith
  have hz : v + (t : ℂ) * e γ - v = (t : ℂ) * e γ := by ring
  have hn : ‖(t : ℂ) * e γ‖ = t := by
    rw [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
  refine ⟨v + (t : ℂ) * e γ, ⟨(t, γ), ⟨⟨ht0, htr⟩, hγ⟩, rfl⟩, ?_, ?_, ?_⟩
  · intro hzv
    have := congrArg (fun w => ‖w - v‖) hzv
    simp only [hz, hn, sub_self, norm_zero] at this
    linarith
  · rw [dist_eq_norm, hz, hn]; exact htε
  · rw [hz, hn, mul_div_cancel_left₀ _ (by exact_mod_cast ht0.ne' : (t : ℂ) ≠ 0), sub_self, norm_zero]
    exact hε

/-- **The cone of an open sector at its apex is its closed angular interval.** -/
theorem coneAt_annSector_eq (v : ℂ) {r a b : ℝ} (hr : 0 < r) (hab : a < b) :
    coneAt (annSector v 0 r a b) v = angleIcc a b := by
  apply Subset.antisymm
  · intro β hβ
    have hcl : e β ∈ closure (e '' Ioo a b) := by
      rw [Metric.mem_closure_iff]
      intro ε hε
      obtain ⟨_, ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩, -, -, hdir⟩ := hβ ε hε
      refine ⟨e θ, ⟨θ, hθ, rfl⟩, ?_⟩
      simp only at hs hθ hdir
      have h1 : (v + (s : ℂ) * e θ - v) / (‖v + (s : ℂ) * e θ - v‖ : ℂ) = e θ := by
        rw [add_sub_cancel_left, norm_real_mul_e hs.1.le, mul_div_cancel_left₀ _ (by exact_mod_cast hs.1.ne' : (s : ℂ) ≠ 0)]
      rw [h1] at hdir
      rw [dist_comm, dist_eq_norm]; exact hdir
    obtain ⟨θ, hθ, he⟩ := closure_minimal (image_mono Ioo_subset_Icc_self) (isCompact_Icc.image continuous_e).isClosed hcl
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp he.symm
    exact mem_iUnion.mpr ⟨n, by rw [hn]; constructor <;> linarith [hθ.1, hθ.2]⟩
  · intro β hβ
    obtain ⟨m, hm⟩ := mem_iUnion.mp hβ
    have hIcc : Icc a b ⊆ coneAt (annSector v 0 r a b) v := by
      rw [← closure_Ioo hab.ne]
      exact closure_minimal (fun γ hγ => mem_coneAt_annSector v hr hγ) (isClosed_coneAt _ _)
    rw [show β = (β - 2 * π * m) + 2 * π * m by ring, periodic_int (fun γ => mem_coneAt_add_two_pi)]
    exact hIcc ⟨by linarith [hm.1], by linarith [hm.2]⟩

/-- Polar form about `0` with the angle in `(0, 2π]`: `z = ‖z‖ e(π + arg(−z))`. -/
theorem eq_norm_mul_e_pi_add_arg (z : ℂ) : z = (‖z‖ : ℂ) * e (π + Complex.arg (-z)) := by
  have h := Complex.norm_mul_exp_arg_mul_I (-z)
  rw [norm_neg] at h
  have hepi : e (π + Complex.arg (-z)) = -e (Complex.arg (-z)) := by
    rw [e_add]; simp [e, Complex.exp_pi_mul_I]
  rw [hepi]
  have h' : (‖z‖ : ℂ) * e (Complex.arg (-z)) = -z := h
  linear_combination h'

/-- The angle `π + arg(−z)` lies in `(0, 2π]`. -/
theorem pi_add_arg_neg_mem (z : ℂ) : π + Complex.arg (-z) ∈ Ioc 0 (2 * π) :=
  ⟨by linarith [Complex.neg_pi_lt_arg (-z)], by linarith [Complex.arg_le_pi (-z)]⟩

/-- A direction `e α` of a point `z ≠ 0` fixes its angle `π + arg(−z)` in `(0, 2π]`. -/
theorem pi_add_arg_neg_eq {z : ℂ} {s α : ℝ} (hs : 0 < s) (hz : z = (s : ℂ) * e α) (hα : α ∈ Ioc 0 (2 * π)) :
    π + Complex.arg (-z) = α := by
  refine eq_of_e_eq_of_mem_Ioc (pi_add_arg_neg_mem z) hα ?_
  have h1 := eq_norm_mul_e_pi_add_arg z
  have hn : ‖z‖ = s := by rw [hz, norm_real_mul_e hs.le]
  rw [hn] at h1
  exact (polar_inj (v := 0) hs hs.le (by rw [zero_add, zero_add, ← h1, hz])).2.symm

/-- Membership in an open sector at `0` inside `(0, 2π]`, read through the angle `π + arg(−z)`. -/
theorem mem_annSector_zero_iff {r a b : ℝ} (ha : 0 ≤ a) (hb : b ≤ 2 * π) (z : ℂ) :
    z ∈ annSector 0 0 r a b ↔ z ≠ 0 ∧ ‖z‖ < r ∧ π + Complex.arg (-z) ∈ Ioo a b := by
  constructor
  · rintro ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
    simp only at hs hθ ⊢
    rw [zero_add]
    refine ⟨mul_ne_zero (by exact_mod_cast hs.1.ne') (e_ne_zero θ), (norm_real_mul_e hs.1.le θ).symm ▸ hs.2, ?_⟩
    rw [pi_add_arg_neg_eq hs.1 rfl ⟨by linarith [hθ.1], by linarith [hθ.2]⟩]
    exact hθ
  · rintro ⟨hz, hr, hθ⟩
    refine ⟨(‖z‖, π + Complex.arg (-z)), ⟨⟨norm_pos_iff.mpr hz, hr⟩, hθ⟩, ?_⟩
    show 0 + ((‖z‖ : ℝ) : ℂ) * e (π + Complex.arg (-z)) = z
    rw [zero_add]; exact (eq_norm_mul_e_pi_add_arg z).symm

/-- A point of the disc of radius `1/2` lies on the segment from `0` to `e(α)/2` exactly when it is `0` or has direction `e(α)`. -/
theorem mem_segment_half_iff {z : ℂ} (hz : ‖z‖ < 1 / 2) (α : ℝ) :
    z ∈ segment ℝ 0 (e α / 2) ↔ z = 0 ∨ z = (‖z‖ : ℂ) * e α := by
  constructor
  · rintro ⟨a', b', ha', hb', hab, rfl⟩
    have h1 : a' • (0 : ℂ) + b' • (e α / 2) = ((b' / 2 : ℝ) : ℂ) * e α := by
      simp only [smul_zero, zero_add, Complex.real_smul]; push_cast; ring
    rw [h1, norm_real_mul_e (by positivity)]
    exact Or.inr rfl
  · rintro (rfl | h)
    · exact left_mem_segment ℝ _ _
    · refine ⟨1 - 2 * ‖z‖, 2 * ‖z‖, by linarith, by positivity, by ring, ?_⟩
      rw [h]; simp only [smul_zero, zero_add, Complex.real_smul, norm_real_mul_e (norm_nonneg z)]
      push_cast; ring

namespace ArcMap

/-- With one colour, no picture has two sectors (adjacent sectors carry different colours). -/
theorem sectorsAt_one_colour {F : ArcMap 1} {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin 1}
    (h : F.SectorsAt v n d c) : n < 2 := by
  by_contra hn
  push Not at hn
  exact h.2.2.2.1 hn ⟨0, by omega⟩ (Subsingleton.elim _ _)

/-- **The inhabitant of `SectorsAt`**: at every point of the one-colour plane, the picture with one sector `[0, 2π]`. -/
theorem const_sectorsAt (v : ℂ) :
    (ArcMap.const univ isOpen_univ (0 : Fin 1)).SectorsAt v 1 ![0, 2 * π] ![0] := by
  have hreg : ∀ j, (ArcMap.const univ isOpen_univ (0 : Fin 1)).region j = univ := by
    intro j; obtain rfl : j = 0 := Subsingleton.elim _ _
    ext z; simp [ArcMap.region, ArcMap.const, ArcMap.interiorPts]
  refine ⟨one_pos, ?_, by simp, fun h => absurd h (by norm_num), ?_, ?_⟩
  · intro i j hij
    fin_cases i <;> fin_cases j <;> (simp_all; try positivity)
  · exact mem_univ v
  · intro j
    rw [hreg, coneAt_univ]
    refine (eq_univ_of_forall fun x => mem_iUnion₂.mpr ⟨(0 : Fin 1), (Subsingleton.elim _ _ : (![0] : Fin 1 → Fin 1) 0 = j), ?_⟩).symm
    have h0 : (![0, 2 * π] : Fin 2 → ℝ) (Fin.castSucc (0 : Fin 1)) = 0 := rfl
    have h1 : (![0, 2 * π] : Fin 2 → ℝ) (Fin.succ (0 : Fin 1)) = 2 * π := rfl
    rw [h0, h1, angleIcc_zero_two_pi]; trivial

/-! ## Inhabitants of the ∃-forms at points of two and three colours, and the phantom adversary (FS131-E3 § 4.1) -/

/-- The colour of `threeSectorDisc`: colour `j` on the directions `(2πj/3, 2π(j+1)/3)`, read through the angle `π + arg(−z) ∈ (0, 2π]`,
which is continuous off the closed positive real axis (one of the three cuts). -/
noncomputable def threeCol (z : ℂ) : Fin 3 :=
  if π + Complex.arg (-z) < 2 * π / 3 then 0 else if π + Complex.arg (-z) < 4 * π / 3 then 1 else 2

/-- The cuts of `threeSectorDisc`: the segments from `0` to `e(2πj/3)/2`, `j = 0, 1, 2`. -/
noncomputable def threeCuts : Set Arc :=
  {Arc.seg 0 (e 0 / 2), Arc.seg 0 (e (2 * π / 3) / 2), Arc.seg 0 (e (4 * π / 3) / 2)}

/-- The cuts of `threeSectorDisc`, in its disc: the centre and the points of angle `2π/3`, `4π/3`, `2π` (the angle `π + arg(−z)`). -/
theorem mem_threeCuts_iff {z : ℂ} (hz : ‖z‖ < 1 / 3) :
    z ∈ ⋃ a ∈ threeCuts, a.carrier ↔ z = 0 ∨ π + Complex.arg (-z) = 2 * π / 3 ∨ π + Complex.arg (-z) = 4 * π / 3 ∨
      π + Complex.arg (-z) = 2 * π := by
  have hz2 : ‖z‖ < 1 / 2 := by linarith
  have hπ := Real.pi_pos
  have key : ∀ α ∈ Ioc 0 (2 * π), z ≠ 0 → (z = (‖z‖ : ℂ) * e α ↔ π + Complex.arg (-z) = α) := by
    intro α hα hz0
    refine ⟨fun h => pi_add_arg_neg_eq (norm_pos_iff.mpr hz0) h hα, fun h => ?_⟩
    rw [← h]; exact eq_norm_mul_e_pi_add_arg z
  have he0 : e 0 = e (2 * π) := by rw [show (2 * π) = 0 + 2 * π by ring, e_add_two_pi]
  simp only [threeCuts, Set.biUnion_insert, Set.biUnion_singleton, Set.mem_union, Arc.carrier,
    mem_segment_half_iff hz2]
  by_cases hz0 : z = 0
  · simp [hz0]
  · rw [he0, key _ ⟨by positivity, le_rfl⟩ hz0, key _ ⟨by positivity, by linarith⟩ hz0,
      key _ ⟨by positivity, by linarith⟩ hz0]
    tauto

/-- The colour of `threeSectorDisc` read through the angle `π + arg(−z) ∈ (0, 2π]`. -/
theorem threeCol_eq_iff (z : ℂ) (j : Fin 3) : threeCol z = j ↔
    (j = 0 ∧ π + Complex.arg (-z) < 2 * π / 3) ∨ (j = 1 ∧ 2 * π / 3 ≤ π + Complex.arg (-z) ∧ π + Complex.arg (-z) < 4 * π / 3) ∨
      (j = 2 ∧ 4 * π / 3 ≤ π + Complex.arg (-z)) := by
  have hπ := Real.pi_pos
  unfold threeCol
  split_ifs with h1 h2 <;> fin_cases j <;> simp_all
  linarith

/-- `threeCol` is locally constant off the cuts in the disc of radius `1/3`. -/
theorem threeCol_locallyConstant : ∀ x ∈ ball (0 : ℂ) (1 / 3), x ∉ ⋃ a ∈ threeCuts, a.carrier →
    ∀ᶠ y in 𝓝 x, threeCol y = threeCol x := by
  intro x hx hcut
  have hπ := Real.pi_pos
  rw [mem_ball, dist_zero_right] at hx
  rw [mem_threeCuts_iff hx] at hcut
  push Not at hcut
  obtain ⟨hx0, h1, h2, h3⟩ := hcut
  have hslit : -x ∈ Complex.slitPlane := by
    rw [Complex.mem_slitPlane_iff_arg]
    exact ⟨fun h => h3 (by rw [h]; ring), neg_ne_zero.mpr hx0⟩
  have hcont : ContinuousAt (fun y : ℂ => π + Complex.arg (-y)) x :=
    continuousAt_const.add ((Complex.continuousAt_arg hslit).comp continuous_neg.continuousAt)
  have hlt : ∀ {c : ℝ}, π + Complex.arg (-x) < c → ∀ᶠ y in 𝓝 x, π + Complex.arg (-y) < c := fun h =>
    hcont.eventually (gt_mem_nhds h)
  have hgt : ∀ {c : ℝ}, c < π + Complex.arg (-x) → ∀ᶠ y in 𝓝 x, c < π + Complex.arg (-y) := fun h =>
    hcont.eventually (lt_mem_nhds h)
  rcases lt_or_gt_of_ne h1 with ha | ha
  · filter_upwards [hlt ha] with y hy
    unfold threeCol; rw [if_pos hy, if_pos ha]
  · rcases lt_or_gt_of_ne h2 with hb | hb
    · filter_upwards [hgt ha, hlt hb] with y hy1 hy2
      unfold threeCol
      rw [if_neg (not_lt.mpr hy1.le), if_pos hy2, if_neg (not_lt.mpr ha.le), if_pos hb]
    · filter_upwards [hgt hb] with y hy
      unfold threeCol
      rw [if_neg (by linarith), if_neg (not_lt.mpr hy.le), if_neg (by linarith), if_neg (not_lt.mpr hb.le)]

/-- **A disc cut into three sectors** (FS131-E3's inhabitant): the disc of radius `1/3` cut by the three segments from `0` in the directions
`2πj/3`, colour `j` on the open sector of directions `(2πj/3, 2π(j+1)/3)`. Its centre carries three colours, every other point at most two. -/
noncomputable def threeSectorDisc : ArcMap 3 where
  dom := ball 0 (1 / 3)
  isOpen_dom := isOpen_ball
  arcs := threeCuts
  nondegenerate := by
    have h : ∀ θ : ℝ, (0 : ℂ) ≠ e θ / 2 := fun θ h => by
      have := congrArg norm h
      rw [norm_zero, norm_div, norm_e] at this
      norm_num at this
    intro a ha
    simp only [threeCuts, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl <;> exact h _
  locallyFinite := fun _ _ => ⟨univ, univ_mem, ((((finite_singleton _).insert _).insert _).subset fun _ ha => ha.1)⟩
  col := threeCol
  locallyConstant := threeCol_locallyConstant

/-- `threeSectorDisc` is valid: its domain has diameter `2/3 < 1`. -/
theorem threeSectorDisc_valid : threeSectorDisc.Valid := by
  intro x hx y hy hd
  have hx' : ‖x‖ < 1 / 3 := by
    have h : x ∈ ball (0 : ℂ) (1 / 3) := hx.1
    simpa using h
  have hy' : ‖y‖ < 1 / 3 := by
    have h : y ∈ ball (0 : ℂ) (1 / 3) := hy.1
    simpa using h
  have : dist x y < 1 := by rw [dist_eq_norm]; linarith [norm_sub_le x y]
  exact absurd hd this.ne

/-- The region of colour `j` of `threeSectorDisc` is the open sector of angles `(2πj/3, 2π(j+1)/3)`. -/
theorem threeSectorDisc_region (j : Fin 3) :
    threeSectorDisc.region j = annSector 0 0 (1 / 3) (2 * π * (j : ℕ) / 3) (2 * π * ((j : ℕ) + 1) / 3) := by
  have hπ := Real.pi_pos
  ext z
  have hj : (0 : ℝ) ≤ 2 * π * (j : ℕ) / 3 := by positivity
  have hj2 : 2 * π * ((j : ℕ) + 1) / 3 ≤ 2 * π := by
    have : ((j : ℕ) : ℝ) ≤ 2 := by exact_mod_cast Nat.lt_succ_iff.mp j.isLt
    nlinarith
  rw [mem_annSector_zero_iff hj hj2]
  have hm := pi_add_arg_neg_mem z
  change (z ∈ ball (0 : ℂ) (1 / 3) ∧ z ∉ ⋃ a ∈ threeCuts, a.carrier) ∧ threeCol z = j ↔ _
  rw [mem_ball, dist_zero_right, threeCol_eq_iff]
  constructor
  · rintro ⟨⟨hz, hcut⟩, hcol⟩
    rw [mem_threeCuts_iff hz] at hcut
    push Not at hcut
    refine ⟨hcut.1, hz, ?_⟩
    rcases hcol with ⟨rfl, h⟩ | ⟨rfl, h⟩ | ⟨rfl, h⟩
    · simp only [Fin.val_zero, CharP.cast_eq_zero, mul_zero, zero_div, zero_add, mul_one]
      exact ⟨hm.1, h⟩
    · simp only [Fin.val_one, Nat.cast_one, mul_one]
      exact ⟨lt_of_le_of_ne h.1 (Ne.symm hcut.2.1), by linarith [h.2]⟩
    · simp only [show ((2 : Fin 3) : ℕ) = 2 from rfl, Nat.cast_ofNat]
      exact ⟨lt_of_le_of_ne (by linarith [h]) (fun h' => hcut.2.2.1 (by linarith)), by
        linarith [lt_of_le_of_ne hm.2 hcut.2.2.2]⟩
  · rintro ⟨hz0, hz, hθ⟩
    refine ⟨⟨hz, fun hcut => ?_⟩, ?_⟩
    · rw [mem_threeCuts_iff hz] at hcut
      fin_cases j <;> simp at hθ <;> rcases hcut with h | h | h | h <;> first | exact hz0 h | (rw [h] at hθ; linarith [hθ.1, hθ.2])
    · fin_cases j <;> simp at hθ ⊢ <;> first | linarith [hθ.1, hθ.2] | (constructor <;> linarith [hθ.1, hθ.2])

/-- The three regions of `threeSectorDisc`, by name. -/
theorem threeSectorDisc_region_zero : threeSectorDisc.region 0 = annSector 0 0 (1 / 3) 0 (2 * π / 3) := by
  rw [threeSectorDisc_region]; norm_num

theorem threeSectorDisc_region_one : threeSectorDisc.region 1 = annSector 0 0 (1 / 3) (2 * π / 3) (4 * π / 3) := by
  rw [threeSectorDisc_region]; norm_num; ring_nf

theorem threeSectorDisc_region_two : threeSectorDisc.region 2 = annSector 0 0 (1 / 3) (4 * π / 3) (2 * π) := by
  rw [threeSectorDisc_region]
  congr 1 <;> simp <;> ring

/-- Angular intervals grow with their ends. -/
theorem angleIcc_subset_angleIcc {a b a' b' : ℝ} (ha : a' ≤ a) (hb : b ≤ b') : angleIcc a b ⊆ angleIcc a' b' := by
  intro β hβ
  obtain ⟨m, hm⟩ := mem_iUnion.mp hβ
  exact mem_iUnion.mpr ⟨m, by constructor <;> linarith [hm.1, hm.2]⟩

/-- The picture of `threeSectorDisc` at its centre: three sectors of angle `2π/3`, colours `0, 1, 2`. -/
theorem threeSectorDisc_sectorsAt :
    threeSectorDisc.SectorsAt 0 3 ![0, 2 * π / 3, 4 * π / 3, 2 * π] ![0, 1, 2] := by
  have hπ := Real.pi_pos
  refine ⟨by norm_num, ?_, by simp, fun _ => by decide, by simp [threeSectorDisc], fun j => ?_⟩
  · rw [Fin.monotone_iff_le_succ]; intro i; fin_cases i <;> simp <;> linarith
  · ext β
    simp only [mem_iUnion, mem_setOf_eq, exists_prop]
    fin_cases j <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk]
    · rw [threeSectorDisc_region_zero, coneAt_annSector_eq 0 (by norm_num) (by positivity)]
      constructor
      · intro h; exact ⟨0, rfl, by simpa using h⟩
      · rintro ⟨i, hi, h⟩; fin_cases i <;> simp_all
    · rw [threeSectorDisc_region_one, coneAt_annSector_eq 0 (by norm_num) (by linarith)]
      constructor
      · intro h; exact ⟨1, rfl, by simpa using h⟩
      · rintro ⟨i, hi, h⟩; fin_cases i <;> simp_all
    · rw [threeSectorDisc_region_two, coneAt_annSector_eq 0 (by norm_num) (by linarith)]
      constructor
      · intro h; exact ⟨2, rfl, by simpa using h⟩
      · rintro ⟨i, hi, h⟩; fin_cases i <;> simp_all

/-- **The phantom picture** (E3-PHANTOM): a `1`-horn then a `0`-horn inserted at the direction `2π/3` — every clause of `SectorsAt` still
holds (the cones are unchanged), and colour `0` now sits on a sector of positive angle and on a horn. -/
theorem threeSectorDisc_phantom :
    threeSectorDisc.SectorsAt 0 5 ![0, 2 * π / 3, 2 * π / 3, 2 * π / 3, 4 * π / 3, 2 * π] ![0, 1, 0, 1, 2] := by
  have hπ := Real.pi_pos
  refine ⟨by norm_num, ?_, by simp, fun _ => by decide, by simp [threeSectorDisc], fun j => ?_⟩
  · rw [Fin.monotone_iff_le_succ]; intro i; fin_cases i <;> simp <;> linarith
  · ext β
    simp only [mem_iUnion, mem_setOf_eq, exists_prop]
    fin_cases j <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk]
    · rw [threeSectorDisc_region_zero, coneAt_annSector_eq 0 (by norm_num) (by positivity)]
      constructor
      · intro h; exact ⟨0, rfl, by simpa using h⟩
      · rintro ⟨i, hi, h⟩
        fin_cases i <;> simp_all
        exact angleIcc_subset_angleIcc (by positivity) le_rfl h
    · rw [threeSectorDisc_region_one, coneAt_annSector_eq 0 (by norm_num) (by linarith)]
      constructor
      · intro h; exact ⟨3, rfl, by simpa using h⟩
      · rintro ⟨i, hi, h⟩
        fin_cases i <;> simp_all
        exact angleIcc_subset_angleIcc le_rfl (by linarith) h
    · rw [threeSectorDisc_region_two, coneAt_annSector_eq 0 (by norm_num) (by linarith)]
      constructor
      · intro h; exact ⟨4, rfl, by simpa using h⟩
      · rintro ⟨i, hi, h⟩; fin_cases i <;> simp_all

/-- Every point of `threeSectorDisc` other than the centre carries at most two colours. -/
theorem threeSectorDisc_ncard_coloursAt_le_two {w : ℂ} (hw : w ≠ 0) : (threeSectorDisc.coloursAt w).ncard ≤ 2 := by
  have hπ := Real.pi_pos
  have hw0 : 0 < ‖w‖ := norm_pos_iff.mpr hw
  have hsub : ∀ {a b : ℝ}, a ≤ b → w ∈ closure (annSector 0 0 (1 / 3) a b) → ∃ θ ∈ Icc a b, w = (‖w‖ : ℂ) * e θ := by
    intro a b hab hcl
    obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, hst⟩ := closure_annSector_subset 0 (by norm_num) hab hcl
    simp only [zero_add] at hst
    have hn : ‖w‖ = s := by rw [← hst, norm_real_mul_e hs.1]
    exact ⟨θ, hθ, by rw [hn, hst]⟩
  have hne : threeSectorDisc.coloursAt w ≠ univ := by
    intro huniv
    have h0 : w ∈ closure (threeSectorDisc.region 0) := show (0 : Fin 3) ∈ threeSectorDisc.coloursAt w from huniv ▸ mem_univ _
    have h1 : w ∈ closure (threeSectorDisc.region 1) := show (1 : Fin 3) ∈ threeSectorDisc.coloursAt w from huniv ▸ mem_univ _
    have h2 : w ∈ closure (threeSectorDisc.region 2) := show (2 : Fin 3) ∈ threeSectorDisc.coloursAt w from huniv ▸ mem_univ _
    rw [threeSectorDisc_region_zero] at h0
    rw [threeSectorDisc_region_one] at h1
    rw [threeSectorDisc_region_two] at h2
    obtain ⟨θ₀, hθ₀, e0⟩ := hsub (by positivity) h0
    obtain ⟨θ₁, hθ₁, e1⟩ := hsub (by linarith) h1
    obtain ⟨θ₂, hθ₂, e2⟩ := hsub (by linarith) h2
    have e01 : e θ₀ = e θ₁ := (polar_inj (v := 0) hw0 hw0.le (by rw [zero_add, zero_add, ← e0, ← e1])).2
    have e12 : e θ₁ = e θ₂ := (polar_inj (v := 0) hw0 hw0.le (by rw [zero_add, zero_add, ← e1, ← e2])).2
    have h01 : θ₀ = θ₁ := by
      by_contra hne
      exact e_ne_e_of_lt (lt_of_le_of_ne (by linarith [hθ₀.2, hθ₁.1]) hne) (by linarith [hθ₀.1, hθ₁.2]) e01
    have h12 : θ₁ = θ₂ := by
      by_contra hne
      exact e_ne_e_of_lt (lt_of_le_of_ne (by linarith [hθ₁.2, hθ₂.1]) hne) (by linarith [hθ₁.1, hθ₂.2]) e12
    linarith [hθ₀.2, hθ₂.1]
  have hlt := Set.ncard_lt_ncard (Set.ssubset_univ_iff.mpr hne) (Set.toFinite _)
  rw [Set.ncard_univ, Nat.card_eq_fintype_card, Fintype.card_fin] at hlt
  omega

/-- The centre of `threeSectorDisc` is `NiceAt` (no horn; distinct colours). -/
theorem threeSectorDisc_niceAt : threeSectorDisc.NiceAt 0 := by
  refine ⟨3, _, _, threeSectorDisc_sectorsAt, ?_, ?_⟩
  · intro i j hij hc
    exfalso
    fin_cases i <;> fin_cases j <;> simp_all
  · intro i hi
    exfalso
    have hπ := Real.pi_pos
    fin_cases i <;> simp at hi <;> linarith

/-- **Inhabitant of `WoodallMerged`** at a point of three colours: `threeSectorDisc` is merged on the whole plane. -/
theorem threeSectorDisc_woodallMerged : threeSectorDisc.WoodallMerged univ := by
  intro v _ hv
  by_cases h0 : v = 0
  · subst h0; exact threeSectorDisc_niceAt
  · have := threeSectorDisc_ncard_coloursAt_le_two h0; omega

/-- **Inhabitant of `WoodallNormal`** at a point of three colours: `threeSectorDisc` is in normal form on the whole plane (angles `2π/3`). -/
theorem threeSectorDisc_woodallNormal : threeSectorDisc.WoodallNormal univ := by
  intro v _ hv
  by_cases h0 : v = 0
  · subst h0
    refine ⟨3, _, _, threeSectorDisc_sectorsAt, ?_, ?_⟩
    · intro i j hij
      fin_cases i <;> fin_cases j <;> simp_all
    · have hπ := Real.pi_pos
      intro i
      fin_cases i <;> simp <;> linarith
  · have := threeSectorDisc_ncard_coloursAt_le_two h0; omega

/-- **Adversary — the old ∀-form of `WoodallMerged` fails on a valid map** (FS131-E3, inventory item 158): "at every point, a colour carried by
two sectors is carried by horns only", quantified over every picture, is refuted by the phantom picture at the centre of `threeSectorDisc`. -/
theorem threeSectorDisc_not_forall_merged :
    ¬ ∀ v n d c, threeSectorDisc.SectorsAt v n d c → ∀ i j : Fin n, i ≠ j → c i = c j →
      d i.castSucc = d i.succ ∧ d j.castSucc = d j.succ := by
  intro h
  have h1 := (h 0 5 _ _ threeSectorDisc_phantom 0 2 (by decide) rfl).1
  have h2 : (0 : ℝ) = 2 * π / 3 := h1
  linarith [Real.pi_pos]

/-- **Adversary — the old ∀-form of `WoodallNormal` fails on a valid map**: "every picture of three or more sectors has distinct colours" is
refuted by the same phantom picture. -/
theorem threeSectorDisc_not_forall_normal :
    ¬ ∀ v n d c, threeSectorDisc.SectorsAt v n d c → 3 ≤ n → Function.Injective c := by
  intro h
  have := h 0 5 _ _ threeSectorDisc_phantom (by norm_num)
    (show (![0, 1, 0, 1, 2] : Fin 5 → Fin 3) 0 = ![0, 1, 0, 1, 2] 2 from rfl)
  exact absurd this (by decide)

end ArcMap

/-- The picture of `halfDisc` at its centre: the upper half (colour `1`) over `[0, π]`, the lower (colour `0`) over `[π, 2π]`. -/
theorem halfDisc_sectorsAt : halfDisc.SectorsAt 0 2 ![0, π, 2 * π] ![1, 0] := by
  have hπ := Real.pi_pos
  have hreg1 : halfDisc.region 1 = annSector 0 0 (1 / 3) 0 π := by
    ext z
    rw [mem_annSector_zero_iff le_rfl (by linarith)]
    change z ∈ halfDisc.interiorPts ∧ (if 0 < z.im then (1 : Fin 2) else 0) = 1 ↔ _
    rw [halfDisc_mem_interiorPts]
    have hm := pi_add_arg_neg_mem z
    have key : π + Complex.arg (-z) < π ↔ 0 < z.im := by
      rw [show π + Complex.arg (-z) < π ↔ Complex.arg (-z) < 0 by constructor <;> intro h <;> linarith,
        Complex.arg_neg_iff, Complex.neg_im, neg_lt_zero]
    constructor
    · rintro ⟨⟨hz, -⟩, hc⟩
      have him : 0 < z.im := by by_contra h; rw [if_neg h] at hc; exact absurd hc (by decide)
      exact ⟨fun h => by simp [h] at him, hz, hm.1, key.mpr him⟩
    · rintro ⟨-, hz, -, hθ⟩
      have him := key.mp hθ
      exact ⟨⟨hz, him.ne'⟩, if_pos him⟩
  have hreg0 : halfDisc.region 0 = annSector 0 0 (1 / 3) π (2 * π) := by
    ext z
    rw [mem_annSector_zero_iff hπ.le le_rfl]
    change z ∈ halfDisc.interiorPts ∧ (if 0 < z.im then (1 : Fin 2) else 0) = 0 ↔ _
    rw [halfDisc_mem_interiorPts]
    have hm := pi_add_arg_neg_mem z
    have key : π < π + Complex.arg (-z) ∧ π + Complex.arg (-z) < 2 * π ↔ z.im < 0 := by
      constructor
      · rintro ⟨h1, h2⟩
        have ha : 0 < Complex.arg (-z) := by linarith
        have hb : Complex.arg (-z) < π := by linarith
        have hnn : 0 ≤ (-z).im := Complex.arg_nonneg_iff.mp ha.le
        rcases lt_or_eq_of_le hnn with h | h
        · simp only [Complex.neg_im, neg_pos] at h; exact h
        · exfalso
          rcases le_or_gt 0 (-z).re with hr | hr
          · exact ha.ne' (Complex.arg_eq_zero_iff.mpr ⟨hr, h.symm⟩)
          · exact hb.ne (Complex.arg_eq_pi_iff.mpr ⟨hr, h.symm⟩)
      · intro him
        have h1 : 0 < (-z).im := by simp only [Complex.neg_im, neg_pos]; exact him
        have ha : 0 ≤ Complex.arg (-z) := Complex.arg_nonneg_iff.mpr h1.le
        have ha' : Complex.arg (-z) ≠ 0 := fun h => h1.ne' (Complex.arg_eq_zero_iff.mp h).2
        have hb : Complex.arg (-z) < π := Complex.arg_lt_pi_iff.mpr (Or.inr h1.ne')
        constructor <;> [linarith [lt_of_le_of_ne ha (Ne.symm ha')]; linarith]
    constructor
    · rintro ⟨⟨hz, hne⟩, hc⟩
      have him : z.im < 0 := by
        rcases lt_or_gt_of_ne hne with h | h
        · exact h
        · rw [if_pos h] at hc; exact absurd hc (by decide)
      exact ⟨fun h => by simp [h] at him, hz, key.mpr him⟩
    · rintro ⟨-, hz, hθ⟩
      have him := key.mp hθ
      exact ⟨⟨hz, him.ne⟩, if_neg (not_lt.mpr him.le)⟩
  refine ⟨by norm_num, ?_, by simp, fun _ => by decide, by simp [halfDisc], fun j => ?_⟩
  · rw [Fin.monotone_iff_le_succ]; intro i; fin_cases i <;> simp <;> linarith
  · ext β
    simp only [mem_iUnion, mem_setOf_eq, exists_prop]
    fin_cases j <;> simp only [Fin.zero_eta, Fin.mk_one]
    · rw [hreg0, coneAt_annSector_eq 0 (by norm_num) (by linarith)]
      constructor
      · intro h; exact ⟨1, rfl, by simpa using h⟩
      · rintro ⟨i, hi, h⟩; fin_cases i <;> simp_all
    · rw [hreg1, coneAt_annSector_eq 0 (by norm_num) hπ]
      constructor
      · intro h; exact ⟨0, rfl, by simpa using h⟩
      · rintro ⟨i, hi, h⟩; fin_cases i <;> simp_all

/-- **Inhabitant of `NiceAt`** at a point of two colours: the centre of `halfDisc`. -/
theorem halfDisc_niceAt : halfDisc.NiceAt 0 := by
  refine ⟨2, _, _, halfDisc_sectorsAt, ?_, ?_⟩
  · intro i j hij hc
    exfalso
    fin_cases i <;> fin_cases j <;> simp_all
  · intro i hi
    exfalso
    have hπ := Real.pi_pos
    fin_cases i <;> simp at hi
    linarith

end HadwigerNelson.Plane
