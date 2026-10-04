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

/-- `threeCol` is locally constant off the cuts in the disc of radius `1/3`. -/
theorem threeCol_locallyConstant : ∀ x ∈ ball (0 : ℂ) (1 / 3), x ∉ ⋃ a ∈ threeCuts, a.carrier →
    ∀ᶠ y in 𝓝 x, threeCol y = threeCol x := by
  sorry

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

/-- The picture of `threeSectorDisc` at its centre: three sectors of angle `2π/3`, colours `0, 1, 2`. -/
theorem threeSectorDisc_sectorsAt :
    threeSectorDisc.SectorsAt 0 3 ![0, 2 * π / 3, 4 * π / 3, 2 * π] ![0, 1, 2] := by
  sorry

/-- **The phantom picture** (E3-PHANTOM): a `1`-horn then a `0`-horn inserted at the direction `2π/3` — every clause of `SectorsAt` still
holds (the cones are unchanged), and colour `0` now sits on a sector of positive angle and on a horn. -/
theorem threeSectorDisc_phantom :
    threeSectorDisc.SectorsAt 0 5 ![0, 2 * π / 3, 2 * π / 3, 2 * π / 3, 4 * π / 3, 2 * π] ![0, 1, 0, 1, 2] := by
  sorry

/-- Every point of `threeSectorDisc` other than the centre carries at most two colours. -/
theorem threeSectorDisc_ncard_coloursAt_le_two {w : ℂ} (hw : w ≠ 0) : (threeSectorDisc.coloursAt w).ncard ≤ 2 := by
  sorry

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
  sorry

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
