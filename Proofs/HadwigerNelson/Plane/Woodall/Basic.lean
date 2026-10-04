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
  (zero-angle sectors, horns, allowed), adjacent sectors of different colours, a truncated open sector strictly inside each sector lying in its
  colour class, and the cone of each colour class at the point equal to the union of its closed sectors. It is Woodall's "regions at a vertex
  `P`" after his steps 1–2: adjacent regions of one colour are one sector (step 1), and every edge has a direction (step 2; automatic for arcs).
* **Woodall's normal forms.** `ArcMap.WoodallMerged`: a colour repeated at a point sits on zero-angle sectors only (the conclusion of his step 3:
  "if two of the regions are in the same set, then each of them subtends angle 0 at P"); `ArcMap.WoodallNormal`: at every point of three or more
  sectors the colours are distinct and every angle exceeds `π/3` (his steps 3 and 5).

Spec examples and inhabitants below; the one-colour plane is the inhabitant of both normal forms and of `SectorsAt` (at every point, `n = 1`).
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
different colours (when `n ≥ 2`); for every `δ > 0` a truncated open sector strictly inside each sector lies in its colour class; and the cone
of each colour class at `v` is the union of the closed sectors of that colour. -/
def SectorsAt (v : ℂ) (n : ℕ) (d : Fin (n + 1) → ℝ) (c : Fin n → Fin k) : Prop :=
  0 < n ∧ Monotone d ∧ d (Fin.last n) = d 0 + 2 * π ∧
    (2 ≤ n → ∀ i : Fin n, c i ≠ c (finRotate n i)) ∧
    (∀ i : Fin n, ∀ δ > 0, ∃ r > 0, annSector v 0 r (d i.castSucc + δ) (d i.succ - δ) ⊆ F.region (c i)) ∧
    ∀ j : Fin k, coneAt (F.region j) v = ⋃ i ∈ {i : Fin n | c i = j}, angleIcc (d i.castSucc) (d i.succ)

/-- **Woodall's step 3, its conclusion**: at every point, a colour carried by two sectors is carried by zero-angle sectors only ("if two of
the regions are in the same set, then each of them subtends angle 0 at P", `[Woodall1973]` p. 197). -/
def WoodallMerged : Prop :=
  ∀ v n d c, F.SectorsAt v n d c → ∀ i j : Fin n, i ≠ j → c i = c j →
    d i.castSucc = d i.succ ∧ d j.castSucc = d j.succ

/-- **Woodall's normal form** (steps 3 and 5): at every point of three or more sectors the colours are distinct and every sector subtends an
angle above `π/3`. -/
def WoodallNormal : Prop :=
  ∀ v n d c, F.SectorsAt v n d c → 3 ≤ n → Function.Injective c ∧ ∀ i : Fin n, π / 3 < d i.succ - d i.castSucc

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
  · intro i δ _
    exact ⟨1, one_pos, by rw [hreg]; exact subset_univ _⟩
  · intro j
    rw [hreg, coneAt_univ]
    refine (eq_univ_of_forall fun x => mem_iUnion₂.mpr ⟨(0 : Fin 1), (Subsingleton.elim _ _ : (![0] : Fin 1 → Fin 1) 0 = j), ?_⟩).symm
    have h0 : (![0, 2 * π] : Fin 2 → ℝ) (Fin.castSucc (0 : Fin 1)) = 0 := rfl
    have h1 : (![0, 2 * π] : Fin 2 → ℝ) (Fin.succ (0 : Fin 1)) = 2 * π := rfl
    rw [h0, h1, angleIcc_zero_two_pi]; trivial

/-- The one-colour plane is in Woodall's normal form (vacuously: no point has three sectors). -/
theorem const_woodallNormal : (ArcMap.const univ isOpen_univ (0 : Fin 1)).WoodallNormal := by
  intro v n d c h hn
  have := sectorsAt_one_colour h
  omega

/-- The one-colour plane satisfies Woodall's step-3 conclusion (vacuously: no colour is carried twice). -/
theorem const_woodallMerged : (ArcMap.const univ isOpen_univ (0 : Fin 1)).WoodallMerged := by
  intro v n d c h i j hij _
  have := sectorsAt_one_colour h
  exact absurd (Fin.ext (by omega : (i : ℕ) = j)) hij

/-- **Adversary for `WoodallNormal`**: a picture of three sectors with a repeated colour is excluded by it — so `WoodallNormal` fails for any
map carrying such a picture. -/
theorem not_woodallNormal_of_repeat {k : ℕ} {F : ArcMap k} {v : ℂ} {d : Fin 4 → ℝ} {c : Fin 3 → Fin k}
    (h : F.SectorsAt v 3 d c) (hrep : c 0 = c 2) : ¬ F.WoodallNormal := by
  intro hN
  have := (hN v 3 d c h le_rfl).1 hrep
  exact absurd this (by decide)

end ArcMap

end HadwigerNelson.Plane
