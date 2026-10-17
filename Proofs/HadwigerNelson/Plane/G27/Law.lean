import Proofs.HadwigerNelson.Plane.G27.Sound
import Proofs.HadwigerNelson.Plane.G27.Data
import Proofs.HadwigerNelson.Collapse.Density.Defs

/-!
# `G27`'s certificate bounds every invariant random independent set over `ℚ(√3, √11)` (FS-131, FS131-ISF1)

`[MatolcsiEtAl2025]` Thm 3 (`χ_gf(G27) ≥ 4`), consumed by an invariant law as their Theorem 1 consumes it, with no blow-up:
`density_le_of_cert` — if the congruence rows are isometries that fit and every independent set of the 27 points has
`Σ_{Y ⊆ S} y_Y ≤ 1` (the residual DFS's bound, `Plane/G27/Bound`), then every translation- and rotation-invariant random
independent set `μ` of `Cay(R, U)` over `ℚ(√3, √11)` has density at most `1/4`.

**The argument.** The 27 points `xᵢ` lie in `R = ℤ[U]` (a path of unit edges from the origin, `xpt_mem`). For a law `ν`
carried by the independent sets, `E_ν[Σ_Y y_Y 1{Y ⊆ I}] ≤ 1`, since the sum is at most `1` on every independent set
(`expect_le`). For `φ(Y) = P(Y ⊆ I) + P(Ȳ ⊆ I)`, invariant under translations by `R`, rotations by `U` and conjugation
(`phi_affine`, `phi_conj`), every congruence row adds `c (φ(J) − φ(I)) = 0` (`row_phi`) and the singletons add
`Σ yᵢ · φ({0}) = 4 · 2 P(0 ∈ I)`. Applied to `μ` and to its conjugate law, `8 P(0 ∈ I) ≤ 2`.

Record: `plans/FS131-ISF1-seam-fractional.md`.
-/

namespace HadwigerNelson.G27

open DensityBound DensityBound.X23Check MeasureTheory SpectralChain Collapse
open scoped ENNReal

noncomputable section

/-! ### The field `ℚ(√3, √11)` and its complex pairs -/

/-- `a + b√3 + c√11 + d√3√11`. -/
def ev (x : X23Check.Q4) : ℝ := x.a + x.b * √3 + x.c * √11 + x.d * (√3 * √11)

theorem ev_add (x y : X23Check.Q4) : ev (x.add y) = ev x + ev y := by
  simp only [ev, X23Check.Q4.add]; push_cast; ring

theorem ev_sub (x y : X23Check.Q4) : ev (x.sub y) = ev x - ev y := by
  simp only [ev, X23Check.Q4.sub]; push_cast; ring

theorem ev_neg (x : X23Check.Q4) : ev x.neg = -ev x := by
  simp only [ev, X23Check.Q4.neg]; push_cast; ring

theorem ev_smul (m : ℤ) (x : X23Check.Q4) : ev (x.smul m) = m * ev x := by
  simp only [ev, X23Check.Q4.smul]; push_cast; ring

theorem ev_ofInt (n : ℤ) : ev (X23Check.Q4.ofInt n) = n := by
  simp [ev, X23Check.Q4.ofInt]

theorem ev_mul (x y : X23Check.Q4) : ev (x.mul y) = ev x * ev y := by
  have h3 : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h11 : √11 ^ 2 = 11 := Real.sq_sqrt (by norm_num)
  obtain ⟨a, b, c, d⟩ := x
  obtain ⟨e, f, g, h⟩ := y
  simp only [ev, X23Check.Q4.mul]
  push_cast
  linear_combination (-((b : ℝ) * f + d * h * √11 ^ 2 + b * h * √11 + d * f * √11)) * h3 +
    (-((c : ℝ) * g + 3 * d * h + c * h * √3 + d * g * √3)) * h11

theorem q4_eq_of_beq {x y : X23Check.Q4} (h : x.beq y = true) : x = y := by
  obtain ⟨a, b, c, d⟩ := x
  obtain ⟨e, f, g, k⟩ := y
  simp only [X23Check.Q4.beq, Bool.and_eq_true, beq_iff_eq] at h
  obtain ⟨⟨⟨rfl, rfl⟩, rfl⟩, rfl⟩ := h
  rfl

theorem c4_eq_of_beq {x y : X23Check.C4} (h : x.beq y = true) : x = y := by
  obtain ⟨xr, xi⟩ := x
  obtain ⟨yr, yi⟩ := y
  simp only [X23Check.C4.beq, Bool.and_eq_true] at h
  rw [q4_eq_of_beq h.1, q4_eq_of_beq h.2]

/-- The complex number a `X23Check.C4` names. -/
def toC (p : X23Check.C4) : ℂ := ⟨ev p.re, ev p.im⟩

theorem toC_add (x y : X23Check.C4) : toC (x.add y) = toC x + toC y := by
  apply Complex.ext <;> simp [toC, X23Check.C4.add, ev_add]

theorem toC_sub (x y : X23Check.C4) : toC (x.sub y) = toC x - toC y := by
  apply Complex.ext <;> simp [toC, X23Check.C4.sub, ev_sub]

theorem toC_mul (x y : X23Check.C4) : toC (x.mul y) = toC x * toC y := by
  apply Complex.ext <;> simp [toC, X23Check.C4.mul, ev_sub, ev_add, ev_mul]

theorem toC_smul (m : ℤ) (x : X23Check.C4) : toC (x.smul m) = (m : ℂ) * toC x := by
  apply Complex.ext <;> simp [toC, X23Check.C4.smul, ev_smul]

theorem toC_cond (b : Bool) (x : X23Check.C4) :
    toC (x.cond b) = if b then (starRingEnd ℂ) (toC x) else toC x := by
  cases b
  · rfl
  · apply Complex.ext <;> simp [toC, X23Check.C4.cond, X23Check.C4.conj, ev_neg]

theorem normSq_toC (x : X23Check.C4) : Complex.normSq (toC x) = ev x.normSq := by
  simp [Complex.normSq_apply, toC, X23Check.C4.normSq, ev_add, ev_mul]

theorem ev_mem (x : X23Check.Q4) : ev x ∈ seamField := by
  rw [FieldWall4.mem_seamField_iff]
  refine ⟨x.a, x.b, x.c, x.d, ?_⟩
  have h33 : √33 = √3 * √11 := by
    rw [← Real.sqrt_mul (by norm_num)]; norm_num
  simp only [ev, h33, Rat.cast_intCast]

theorem toC_mem (p : X23Check.C4) : toC p ∈ planeOver seamField := ⟨ev_mem p.re, ev_mem p.im⟩

theorem div12_mem {z : ℂ} (hz : z ∈ planeOver seamField) : z / 12 ∈ planeOver seamField := by
  have h12 : (12 : ℝ) ∈ seamField := by simp
  constructor
  · rw [show (z / 12).re = z.re / 12 by simp]; exact seamField.div_mem hz.1 h12
  · rw [show (z / 12).im = z.im / 12 by simp]; exact seamField.div_mem hz.2 h12

/-! ### The points, in `R = ℤ[U]` -/

/-- The point `xᵢ = Pᵢ/12` of the certificate (0-based, in the DFS's order). -/
def xpt (i : ℕ) : ℂ := toC (pt ptsL i) / 12

theorem xpt_plane (i : ℕ) : xpt i ∈ planeOver seamField := div12_mem (toC_mem _)

/-- `|Pᵢ − Pⱼ|² = 144` makes `xⱼ − xᵢ` a unit vector of `K²`. -/
theorem unit_of_sqd {i j : ℕ} (h : (sqd (pt ptsL j) (pt ptsL i)).beq (X23Check.Q4.ofInt 144) = true) :
    xpt j - xpt i ∈ unitVectors seamField := by
  refine ⟨?_, ?_⟩
  · simp only [xpt, ← sub_div, ← toC_sub]; exact div12_mem (toC_mem _)
  · have hq := q4_eq_of_beq h
    rw [xpt, xpt, ← sub_div, norm_div, ← toC_sub, Complex.norm_def, normSq_toC]
    simp only [sqd] at hq
    rw [hq, ev_ofInt]
    have : √((144 : ℤ) : ℝ) = 12 := by
      rw [show ((144 : ℤ) : ℝ) = 12 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]
    rw [this]; norm_num

/-- `adjOk` read as propositions. -/
theorem adj_bit {v w : ℕ} (h : (adjL.getD v 0).testBit w = true) :
    v < 27 ∧ w < 27 ∧ (sqd (pt ptsL v) (pt ptsL w)).beq (X23Check.Q4.ofInt 144) = true := by
  have hok := adj_ok
  simp only [adjOk, Bool.and_eq_true, List.all_eq_true, List.mem_range, beq_iff_eq] at hok
  obtain ⟨hlen, hall⟩ := hok
  have hv : v < 27 := by
    by_contra hv
    rw [List.getD_eq_default _ _ (by omega), Nat.zero_testBit] at h
    exact Bool.false_ne_true h
  obtain ⟨hlt, hrow⟩ := hall v hv
  have hlt' : adjL.getD v 0 < M27 := by simpa [Nat.blt_eq] using hlt
  have hw : w < 27 := by
    by_contra hw
    rw [testBit_of_lt_M27 hlt' (show 27 ≤ w by omega)] at h
    exact Bool.false_ne_true h
  have := hrow w hw
  rw [h] at this
  exact ⟨hv, hw, by simpa using this⟩

theorem xpt_zero : xpt 0 = 0 := by
  rw [xpt, c4_eq_of_beq origin_ok]
  apply Complex.ext <;> simp [toC, ev, X23Check.Q4.ofInt]

theorem xpt_mem_of_path : ∀ (p : List ℕ) (v : ℕ), pathFrom adjL v p = true → xpt v ∈ unitRing seamField →
    xpt ((v :: p).getLast (List.cons_ne_nil _ _)) ∈ unitRing seamField
  | [], _, _, hv => hv
  | w :: p, v, h, hv => by
    simp only [pathFrom, Bool.and_eq_true] at h
    obtain ⟨hb, hp⟩ := h
    obtain ⟨-, -, hs⟩ := adj_bit hb
    have hu : xpt v - xpt w ∈ unitVectors seamField := unit_of_sqd hs
    have hw : xpt w ∈ unitRing seamField := by
      have := sub_mem hv (unitVectors_subset_unitRing seamField hu)
      rwa [sub_sub_cancel] at this
    rw [List.getLast_cons (List.cons_ne_nil _ _)]
    exact xpt_mem_of_path p w hp hw

/-- **Every point of the certificate lies in `R = ℤ[U]`.** -/
theorem xpt_mem {i : ℕ} (hi : i < 27) : xpt i ∈ unitRing seamField := by
  have hok := paths_ok
  simp only [pathsOk, Bool.and_eq_true, List.all_eq_true, List.mem_range, beq_iff_eq] at hok
  obtain ⟨hpath, hlast⟩ := hok.2 i hi
  have h0 : xpt 0 ∈ unitRing seamField := by rw [xpt_zero]; exact zero_mem _
  have := xpt_mem_of_path _ 0 hpath h0
  rw [List.getLast?_eq_some_getLast (List.cons_ne_nil _ _), Option.some.injEq] at hlast
  rwa [hlast] at this

/-- The certificate's point `i`, as an element of `R` (`0` past the 27 points). -/
def xR (i : ℕ) : unitRing seamField := if h : i < 27 then ⟨xpt i, xpt_mem h⟩ else 0

theorem coe_xR {i : ℕ} (hi : i < 27) : ((xR i : unitRing seamField) : ℂ) = xpt i := by
  simp [xR, hi]

/-! ### Conjugation on `R` -/

/-- Complex conjugation maps `R` into itself (a unit vector's conjugate is one). -/
theorem conj_mem_unitRing {z : ℂ} (hz : z ∈ unitRing seamField) : starRingEnd ℂ z ∈ unitRing seamField := by
  have h : unitRing seamField ≤ (unitRing seamField).comap (starRingEnd ℂ) := by
    show Subring.closure _ ≤ _
    rw [Subring.closure_le]
    intro w hw
    exact Subring.subset_closure ⟨UnitRing.conj_mem_planeOver hw.1, by rw [Complex.norm_conj]; exact hw.2⟩
  exact h hz

/-- Complex conjugation, on `R`. -/
def conjR : unitRing seamField →+* unitRing seamField :=
  (starRingEnd ℂ).restrict (unitRing seamField) (unitRing seamField) fun _ hz => conj_mem_unitRing hz

theorem coe_conjR (y : unitRing seamField) : ((conjR y : unitRing seamField) : ℂ) = starRingEnd ℂ (y : ℂ) := rfl

theorem conjR_conjR (y : unitRing seamField) : conjR (conjR y) = y :=
  Subtype.ext (by rw [coe_conjR, coe_conjR, Complex.conj_conj])

/-- The conjugate of a unit vector. -/
def uConj (u : unitVectors seamField) : unitVectors seamField :=
  ⟨starRingEnd ℂ u, UnitRing.conj_mem_planeOver u.2.1, by rw [Complex.norm_conj]; exact u.2.2⟩

theorem conjR_affine (u : unitVectors seamField) (v y : unitRing seamField) :
    conjR (uvRing u * y + v) = uvRing (uConj u) * conjR y + conjR v :=
  Subtype.ext (by simp [coe_conjR, uvRing, uConj])

/-! ### Events, and their invariance -/

variable (μ : IndepLaw seamField)

/-- The event that every point of a list lies in the random set. -/
def allIn (l : List (unitRing seamField)) : Set (unitRing seamField → Bool) := {c | ∀ y ∈ l, c y = true}

theorem measurableSet_allIn : ∀ l : List (unitRing seamField), MeasurableSet (allIn l)
  | [] => by simp [allIn]
  | y :: l => by
    have hset : allIn (y :: l) = (fun c : unitRing seamField → Bool => c y) ⁻¹' {true} ∩ allIn l := by
      ext c; simp [allIn]
    rw [hset]
    exact (show MeasurableSet ((fun c : unitRing seamField → Bool => c y) ⁻¹' {true}) from
      measurable_pi_apply y (measurableSet_singleton true)).inter (measurableSet_allIn l)

theorem allIn_congr {l l' : List (unitRing seamField)} (h : ∀ y, y ∈ l ↔ y ∈ l') : allIn l = allIn l' := by
  ext c; simp only [allIn, Set.mem_setOf_eq]
  exact ⟨fun hc y hy => hc y ((h y).2 hy), fun hc y hy => hc y ((h y).1 hy)⟩

/-- **Translations by `R` and rotations by `U` preserve the law of the random set.** -/
theorem measure_allIn_affine (u : unitVectors seamField) (v : unitRing seamField) (l : List (unitRing seamField)) :
    μ.μ (allIn (l.map fun y => uvRing u * y + v)) = μ.μ (allIn l) := by
  have hsh : Measurable (fun (c : unitRing seamField → Bool) (x : unitRing seamField) => c (x + v)) :=
    measurable_pi_lambda _ fun _ => measurable_pi_apply _
  have hrot : Measurable (fun (c : unitRing seamField → Bool) (x : unitRing seamField) => c (uvRing u * x)) :=
    measurable_pi_lambda _ fun _ => measurable_pi_apply _
  have hset : allIn (l.map fun y => uvRing u * y + v) =
      (fun (c : unitRing seamField → Bool) (x : unitRing seamField) => c (x + v)) ⁻¹'
        ((fun (c : unitRing seamField → Bool) (x : unitRing seamField) => c (uvRing u * x)) ⁻¹' allIn l) := by
    ext c
    simp only [allIn, Set.mem_setOf_eq, Set.mem_preimage, List.mem_map]
    constructor
    · intro h y hy; exact h _ ⟨y, hy, rfl⟩
    · rintro h _ ⟨y, hy, rfl⟩; exact h y hy
  rw [hset, ← Measure.map_apply hsh ((measurableSet_allIn l).preimage hrot), μ.shift_inv v,
    ← Measure.map_apply hrot (measurableSet_allIn l), μ.rot_inv u]

/-- `φ(Y) = P(Y ⊆ I) + P(Ȳ ⊆ I)`: invariant under translations, rotations and conjugation. -/
def phi (l : List (unitRing seamField)) : ℝ := (μ.μ (allIn l)).toReal + (μ.μ (allIn (l.map conjR))).toReal

theorem phi_congr {l l' : List (unitRing seamField)} (h : ∀ y, y ∈ l ↔ y ∈ l') : phi μ l = phi μ l' := by
  have h' : ∀ y, y ∈ l.map conjR ↔ y ∈ l'.map conjR := fun y => by
    simp only [List.mem_map]
    exact ⟨fun ⟨x, hx, e⟩ => ⟨x, (h x).1 hx, e⟩, fun ⟨x, hx, e⟩ => ⟨x, (h x).2 hx, e⟩⟩
  rw [phi, phi, allIn_congr h, allIn_congr h']

theorem phi_affine (u : unitVectors seamField) (v : unitRing seamField) (l : List (unitRing seamField)) :
    phi μ (l.map fun y => uvRing u * y + v) = phi μ l := by
  have hc : (l.map fun y => uvRing u * y + v).map conjR =
      (l.map conjR).map fun y => uvRing (uConj u) * y + conjR v := by
    rw [List.map_map, List.map_map]
    exact List.map_congr_left fun y _ => conjR_affine u v y
  rw [phi, phi, measure_allIn_affine, hc, measure_allIn_affine]

theorem phi_conj (l : List (unitRing seamField)) : phi μ (l.map conjR) = phi μ l := by
  have : (l.map conjR).map conjR = l := by
    rw [List.map_map]
    conv_rhs => rw [← List.map_id l]
    exact List.map_congr_left fun y _ => conjR_conjR y
  rw [phi, phi, this, add_comm]

theorem phi_zero : phi μ [0] = 2 * (μ.μ {c | c 0 = true}).toReal := by
  have h : allIn ([0] : List (unitRing seamField)) = {c | c 0 = true} := by ext c; simp [allIn]
  rw [phi, List.map_singleton, map_zero, h]; ring

/-- The point `1`, a unit vector. -/
def uOne : unitVectors seamField :=
  ⟨1, ⟨by simp [seamField.one_mem], by simp [seamField.zero_mem]⟩, by simp⟩

theorem phi_point (y : unitRing seamField) : phi μ [y] = phi μ [0] := by
  have : ([0] : List (unitRing seamField)).map (fun z => uvRing uOne * z + y) = [y] := by
    simp only [List.map_singleton, mul_zero, zero_add]
  rw [← this, phi_affine]

/-! ### The congruence rows are isometries of `R` -/

/-- A row accepted by `rowOk` is an isometry `z ↦ u·(b ? z̄ : z) + v` of the plane carrying its `I` onto its `J`, entry by
entry, with `u` a unit vector of `K²`. -/
theorem row_corr {r : ℕ} (h : rowOk ptsL r = true) :
    ∃ (u v : ℂ) (b : Bool), u ∈ unitVectors seamField ∧
      List.Forall₂ (fun i j => xpt j = u * (if b then starRingEnd ℂ (xpt i) else xpt i) + v) (rowI r) (rowJ r) := by
  simp only [rowOk, Bool.and_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨hm, hU⟩, hcorr⟩ := h
  set m := rowM r
  set U := rowU r
  set V := rowV r
  set b := rowB r
  have hm' : (0 : ℝ) < m := by exact_mod_cast hm
  have hUn : ‖toC U‖ = m := by
    rw [Complex.norm_def, normSq_toC, q4_eq_of_beq hU, ev_ofInt]
    push_cast
    rw [Real.sqrt_mul_self hm'.le]
  have hmF : (m : ℝ) ∈ seamField := natCast_mem seamField m
  refine ⟨toC U / m, toC V / (12 * m), b, ⟨?_, ?_⟩, ?_⟩
  · have hz := toC_mem U
    constructor
    · rw [show (toC U / (m : ℂ)).re = (toC U).re / m by simp]
      exact seamField.div_mem hz.1 hmF
    · rw [show (toC U / (m : ℂ)).im = (toC U).im / m by simp]
      exact seamField.div_mem hz.2 hmF
  · rw [norm_div, hUn, Complex.norm_natCast, div_self hm'.ne']
  have hpt : ∀ i j, (((U.mul ((pt ptsL i).cond b)).add V).beq ((pt ptsL j).smul (m : ℤ))) = true →
      xpt j = toC U / m * (if b then (starRingEnd ℂ) (xpt i) else xpt i) + toC V / (12 * m) := by
    intro i j hij
    have he := congrArg toC (c4_eq_of_beq hij)
    rw [toC_add, toC_mul, toC_cond, toC_smul] at he
    simp only [xpt]
    have hm0 : (m : ℂ) ≠ 0 := by exact_mod_cast hm'.ne'
    cases hb : b
    · simp only [hb, Bool.false_eq_true, if_false] at he ⊢
      field_simp
      push_cast at he
      linear_combination -he
    · simp only [hb, if_true] at he ⊢
      rw [map_div₀, Complex.conj_ofNat]
      field_simp
      push_cast at he
      linear_combination -he
  have hF : ∀ I J : List ℕ, corrOk ptsL b U V (m : ℤ) I J = true →
      List.Forall₂ (fun i j => xpt j = toC U / m * (if b then (starRingEnd ℂ) (xpt i) else xpt i) +
        toC V / (12 * m)) I J := by
    intro I
    induction I with
    | nil => intro J hJ; cases J <;> simp_all [corrOk]
    | cons i I ih =>
      intro J hJ
      cases J with
      | nil => simp [corrOk] at hJ
      | cons j J =>
        simp only [corrOk, Bool.and_eq_true] at hJ
        exact List.Forall₂.cons (hpt i j hJ.1) (ih J hJ.2)
  exact hF _ _ hcorr

/-- Point lists related entry by entry by a map of `R` are images. -/
theorem map_xR_of_forall₂ {Rl : ℕ → ℕ → Prop} (g : unitRing seamField → unitRing seamField) :
    ∀ {l₁ l₂ : List ℕ}, List.Forall₂ Rl l₁ l₂ → (∀ i ∈ l₁, ∀ j ∈ l₂, Rl i j → xR j = g (xR i)) →
      l₂.map xR = (l₁.map xR).map g
  | [], [], .nil, _ => rfl
  | i :: l₁, j :: l₂, .cons hij hrest, h => by
    simp only [List.map_cons, List.cons.injEq]
    exact ⟨h i (by simp) j (by simp) hij, map_xR_of_forall₂ g hrest fun i' hi j' hj => h i' (by simp [hi]) j' (by simp [hj])⟩

/-- **Every congruence row preserves `φ`**: its `J` is the image of its `I` under an isometry of `R`. -/
theorem row_phi {r : ℕ} (h : rowOk ptsL r = true) (hI : ∀ i ∈ rowI r, i < 27) (hJ : ∀ j ∈ rowJ r, j < 27) :
    phi μ ((rowJ r).map xR) = phi μ ((rowI r).map xR) := by
  obtain ⟨u, v, b, hu, hF⟩ := row_corr h
  generalize rowJ r = J at hF hJ ⊢
  cases hl : rowI r with
  | nil =>
    rw [hl] at hF
    rw [List.forall₂_nil_left_iff.1 hF]
  | cons i0 I' =>
    rw [hl] at hF hI
    obtain ⟨j0, hj0, hrel⟩ : ∃ j0 ∈ J, xpt j0 = u * (if b then starRingEnd ℂ (xpt i0) else xpt i0) + v := by
      cases hF with
      | cons hh _ => exact ⟨_, by simp, hh⟩
    have hi0 := hI i0 (by simp)
    have hv : v ∈ unitRing seamField := by
      have hx : (if b then starRingEnd ℂ (xpt i0) else xpt i0) ∈ unitRing seamField := by
        split
        · exact conj_mem_unitRing (xpt_mem hi0)
        · exact xpt_mem hi0
      have := sub_mem (xpt_mem (hJ j0 hj0)) (mul_mem (unitVectors_subset_unitRing seamField hu) hx)
      rwa [hrel, add_sub_cancel_left] at this
    set uU : unitVectors seamField := ⟨u, hu⟩
    set vR : unitRing seamField := ⟨v, hv⟩
    have hmap := map_xR_of_forall₂ (fun y => uvRing uU * (if b then conjR y else y) + vR) hF fun i hi j hj hij => by
      apply Subtype.ext
      rw [coe_xR (hJ j hj), hij]
      have hi' := hI i hi
      cases b <;> simp [uvRing, uU, vR, coe_xR hi', coe_conjR]
    rw [hmap]
    cases b
    · simp only [Bool.false_eq_true, if_false]
      exact phi_affine μ uU vR _
    · simp only [if_true]
      rw [show ((i0 :: I').map xR).map (fun y => uvRing uU * conjR y + vR) =
          (((i0 :: I').map xR).map conjR).map (fun y => uvRing uU * y + vR) by simp only [List.map_map]; rfl,
        phi_affine, phi_conj]

/-! ### The terms, read on the random set -/

theorem testBit_maskL (I : List ℕ) (k : ℕ) : (maskL I).testBit k = true ↔ k ∈ I := by
  induction I with
  | nil => simp [maskL]
  | cons i I ih =>
    simp only [maskL, Nat.testBit_or, Bool.or_eq_true, ih, Nat.testBit_two_pow, decide_eq_true_eq, List.mem_cons]
    tauto

theorem maskL_lt {I : List ℕ} (hI : ∀ i ∈ I, i < 27) : maskL I < M27 := by
  rw [M27_eq]
  apply Nat.lt_pow_two_of_testBit
  intro i hi
  by_contra h
  have := hI i ((testBit_maskL I i).1 (by simpa using h))
  omega

/-- The random set's points among the 27, as a mask. -/
def mk (c : unitRing seamField → Bool) : ℕ := maskL ((List.range 27).filter fun i => c (xR i))

theorem testBit_mk (c : unitRing seamField → Bool) (k : ℕ) : (mk c).testBit k = true ↔ k < 27 ∧ c (xR k) = true := by
  simp [mk, testBit_maskL]

theorem mk_lt (c : unitRing seamField → Bool) : mk c < 2 ^ 27 :=
  maskL_lt fun i hi => by simp at hi; exact hi.1

/-- The points of a term's key. -/
def ptsOf (t : ℕ) : List (unitRing seamField) := ((List.range 27).filter fun i => (key t).testBit i).map xR

theorem mem_ptsOf {t : ℕ} {y : unitRing seamField} : y ∈ ptsOf t ↔ ∃ i, (key t).testBit i = true ∧ xR i = y := by
  simp only [ptsOf, List.mem_map, List.mem_filter, List.mem_range]
  constructor
  · rintro ⟨i, ⟨-, hi⟩, rfl⟩; exact ⟨i, hi, rfl⟩
  · rintro ⟨i, hi, rfl⟩
    have : i < 27 := by
      rw [testBit_key] at hi
      simp only [Bool.and_eq_true, decide_eq_true_eq] at hi
      exact hi.1
    exact ⟨i, ⟨this, hi⟩, rfl⟩

theorem mem_allIn_ptsOf {c : unitRing seamField → Bool} {t : ℕ} :
    c ∈ allIn (ptsOf t) ↔ ∀ i, (key t).testBit i = true → c (xR i) = true := by
  simp only [allIn, Set.mem_setOf_eq, mem_ptsOf]
  exact ⟨fun h i hi => h _ ⟨i, hi, rfl⟩, fun h y ⟨i, hi, e⟩ => e ▸ h i hi⟩

/-- A term's value on the random set's mask: its coefficient when its points are all in the set. -/
theorem tv_mk (c : unitRing seamField → Bool) (t : ℕ) :
    (tv (mk c) t : ℝ) = (allIn (ptsOf t)).indicator (fun _ => (cf t : ℝ)) c := by
  have hiff : (key t &&& mk c = key t) ↔ c ∈ allIn (ptsOf t) := by
    rw [land_self_iff, mem_allIn_ptsOf]
    refine forall_congr' fun i => imp_congr_right fun hi => ?_
    rw [testBit_mk]
    have : i < 27 := by
      rw [testBit_key] at hi
      simp only [Bool.and_eq_true, decide_eq_true_eq] at hi
      exact hi.1
    simp [this]
  unfold tv
  by_cases h : c ∈ allIn (ptsOf t)
  · rw [Set.indicator_of_mem h, beq_iff_eq.2 (hiff.2 h)]; rfl
  · rw [Set.indicator_of_notMem h, beq_eq_false_iff_ne.2 (fun e => h (hiff.1 e))]; simp

theorem val_mk (c : unitRing seamField → Bool) (T : List ℕ) :
    (val (mk c) T : ℝ) = (T.map fun t => (allIn (ptsOf t)).indicator (fun _ => (cf t : ℝ)) c).sum := by
  induction T with
  | nil => simp [val_nil]
  | cons t T ih => rw [val_cons, Int.cast_add, ih, tv_mk, List.map_cons, List.sum_cons]

/-- The terms' expectation under the law: the sum of each coefficient times the probability of its event. -/
theorem integral_terms (P : ℕ → List (unitRing seamField)) : ∀ T : List ℕ,
    Integrable (fun c => (T.map fun t => (allIn (P t)).indicator (fun _ => (cf t : ℝ)) c).sum) μ.μ ∧
      ∫ c, (T.map fun t => (allIn (P t)).indicator (fun _ => (cf t : ℝ)) c).sum ∂μ.μ =
        (T.map fun t => (cf t : ℝ) * (μ.μ (allIn (P t))).toReal).sum
  | [] => by simp
  | t :: T => by
    haveI := μ.isProb
    obtain ⟨ih1, ih2⟩ := integral_terms P T
    have hi : Integrable (fun c => (allIn (P t)).indicator (fun _ => (cf t : ℝ)) c) μ.μ :=
      (integrable_const _).indicator (measurableSet_allIn _)
    simp only [List.map_cons, List.sum_cons]
    refine ⟨hi.add ih1, ?_⟩
    rw [integral_add hi ih1, ih2, integral_indicator_const _ (measurableSet_allIn _), smul_eq_mul, measureReal_def,
      mul_comm]

/-- **The expectation bound**: if the terms' sum is at most `B` almost surely, so is its expectation. -/
theorem expect_le (P : ℕ → List (unitRing seamField)) (T : List ℕ) (B : ℝ)
    (hB : ∀ᵐ c ∂μ.μ, (T.map fun t => (allIn (P t)).indicator (fun _ => (cf t : ℝ)) c).sum ≤ B) :
    (T.map fun t => (cf t : ℝ) * (μ.μ (allIn (P t))).toReal).sum ≤ B := by
  haveI := μ.isProb
  obtain ⟨hint, heq⟩ := integral_terms μ P T
  rw [← heq]
  calc ∫ c, (T.map fun t => (allIn (P t)).indicator (fun _ => (cf t : ℝ)) c).sum ∂μ.μ ≤ ∫ _, B ∂μ.μ :=
        integral_mono_ae hint (integrable_const B) hB
    _ = B := by simp

/-! ### The random set's mask is independent in the certificate's graph -/

theorem indepFrom_of_getD : ∀ (as : List ℕ) (k W : ℕ),
    (∀ j < as.length, W.testBit (k + j) = true → as.getD j 0 &&& W = 0) → IndepFrom as k W
  | [], _, _, _ => trivial
  | a :: as, k, W, h => by
    refine ⟨fun hk => by simpa using h 0 (by simp) (by simpa using hk), indepFrom_of_getD as (k + 1) W ?_⟩
    intro j hj hW
    have := h (j + 1) (by simp; omega) (by rwa [show k + (j + 1) = k + 1 + j by omega])
    simpa using this

theorem adjL_length : adjL.length = 27 := by
  have hok := adj_ok
  simp only [adjOk, Bool.and_eq_true, beq_iff_eq] at hok
  exact hok.1

/-- **An independent random set misses every listed edge.** -/
theorem indepFrom_mk {c : unitRing seamField → Bool} (hc : c ∈ IndepSets seamField) : IndepFrom adjL 0 (mk c) := by
  apply indepFrom_of_getD
  intro j hj hW
  rw [zero_add] at hW
  rw [land_eq_zero_iff]
  intro w hw
  by_contra hcw
  have hcw' : (mk c).testBit w = true := by simpa using hcw
  obtain ⟨-, hcw''⟩ := (testBit_mk c w).1 hcw'
  obtain ⟨hj27, hcj⟩ := (testBit_mk c j).1 hW
  obtain ⟨-, hw27, hs⟩ := adj_bit hw
  have hu := unit_of_sqd hs
  apply hc (xR w) (xR j) (by rw [coe_xR hj27, coe_xR hw27]; exact hu)
  exact ⟨hcw'', hcj⟩

theorem conj_indep {c : unitRing seamField → Bool} (hc : c ∈ IndepSets seamField) :
    (fun x => c (conjR x)) ∈ IndepSets seamField := by
  intro x y hxy hb
  apply hc (conjR x) (conjR y) _ hb
  rw [coe_conjR, coe_conjR, ← map_sub]
  exact ⟨UnitRing.conj_mem_planeOver hxy.1, by rw [Complex.norm_conj]; exact hxy.2⟩

/-! ### The certificate's identity: the rows cancel, the singletons give `4·Dn·φ({0})` -/

theorem cf_add_mul {k n : ℕ} (hk : k < M27) : cf (k + M27 * n) = (n : ℤ) - OFFC := by
  unfold cf; rw [div_add_mul hk]

-- The offset is a variable here: a closed offset of a thousand bits sends the kernel into deep recursion (`Sound`).
private theorem neg_aux (O c : ℕ) (h : c ≤ 2 * O) : (((2 * O - c : ℕ) : ℤ) - O) = -((c : ℤ) - O) := by omega

theorem singTerms_phi : ∀ (L : List ℕ) (i0 : ℕ), i0 + L.length ≤ 27 →
    ((singTerms i0 L).map fun t => (cf t : ℝ) * phi μ (ptsOf t)).sum =
      (L.map fun cpk : ℕ => (((cpk : ℤ) - OFFC : ℤ) : ℝ)).sum * phi μ [0]
  | [], _, _ => by simp [singTerms]
  | cpk :: L, i0, h => by
    simp only [List.length_cons] at h
    have hi : 2 ^ i0 < M27 := two_pow_lt_M27 (by omega)
    have hk : key (2 ^ i0 + M27 * cpk) = 2 ^ i0 := key_add_mul hi
    have hp : phi μ (ptsOf (2 ^ i0 + M27 * cpk)) = phi μ [0] := by
      rw [← phi_point μ (xR i0)]
      apply phi_congr
      intro y
      rw [mem_ptsOf, hk, List.mem_singleton]
      constructor
      · rintro ⟨i, hi, rfl⟩
        rw [Nat.testBit_two_pow] at hi
        simp only [decide_eq_true_eq] at hi
        rw [hi]
      · rintro rfl; exact ⟨i0, by simp, rfl⟩
    have ih := singTerms_phi L (i0 + 1) (by omega)
    change ((cf (2 ^ i0 + M27 * cpk) : ℝ) * phi μ (ptsOf (2 ^ i0 + M27 * cpk)) +
      ((singTerms (i0 + 1) L).map fun t => (cf t : ℝ) * phi μ (ptsOf t)).sum) = _
    rw [cf_add_mul hi, hp, ih, List.map_cons, List.sum_cons, add_mul]

theorem ptsOf_mask {I : List ℕ} (hI : ∀ i ∈ I, i < 27) (n : ℕ) :
    phi μ (ptsOf (maskL I + M27 * n)) = phi μ (I.map xR) := by
  apply phi_congr
  intro y
  rw [mem_ptsOf, key_add_mul (maskL_lt hI), List.mem_map]
  simp only [testBit_maskL]

theorem rowsTerms_phi : ∀ (rows coefs : List ℕ), rows.all (rowOk ptsL) = true → rowsFit rows coefs = true →
    ((rowsTerms rows coefs).map fun t => (cf t : ℝ) * phi μ (ptsOf t)).sum = 0
  | r :: rs, cpk :: cs, hr, hf => by
    simp only [List.all_cons, Bool.and_eq_true] at hr
    simp only [rowsFit, Bool.and_eq_true, List.all_eq_true, Nat.blt_eq] at hf
    obtain ⟨⟨⟨hI, hJ⟩, hc⟩, hrest⟩ := hf
    have hcpk : cpk ≤ 2 * OFFC := Nat.le_of_ble_eq_true hc
    have ih := rowsTerms_phi rs cs hr.2 hrest
    change (((rowTerms r cpk ++ rowsTerms rs cs).map fun t => (cf t : ℝ) * phi μ (ptsOf t)).sum) = 0
    rw [List.map_append, List.sum_append, ih, add_zero]
    simp only [rowTerms, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil, add_zero]
    rw [cf_add_mul (maskL_lt hI), cf_add_mul (maskL_lt hJ), neg_aux OFFC cpk hcpk, ptsOf_mask μ hI, ptsOf_mask μ hJ,
      row_phi μ hr.1 hI hJ]
    push_cast
    ring
  | [], _, _, _ => by simp [rowsTerms]
  | _ :: _, [], _, _ => by simp [rowsTerms]

theorem mem_allIn_map_conj {l : List (unitRing seamField)} {c : unitRing seamField → Bool} :
    c ∈ allIn (l.map conjR) ↔ (fun y => c (conjR y)) ∈ allIn l := by
  simp only [allIn, Set.mem_setOf_eq, List.mem_map]
  constructor
  · intro h y hy; exact h _ ⟨y, hy, rfl⟩
  · rintro h _ ⟨y, hy, rfl⟩; exact h y hy

theorem indicator_allIn_conj (l : List (unitRing seamField)) (c : unitRing seamField → Bool) (x : ℝ) :
    (allIn (l.map conjR)).indicator (fun _ => x) c = (allIn l).indicator (fun _ => x) (fun y => c (conjR y)) := by
  by_cases h : c ∈ allIn (l.map conjR)
  · rw [Set.indicator_of_mem h, Set.indicator_of_mem (mem_allIn_map_conj.1 h)]
  · rw [Set.indicator_of_notMem h, Set.indicator_of_notMem (fun h' => h (mem_allIn_map_conj.2 h'))]

/-- **`[MatolcsiEtAl2025]` Thm 3, read against an invariant law.** If the congruence rows are isometries that fit and the
certificate's terms weigh at most `Dn` on every independent set of the 27 points, every translation- and rotation-invariant
random independent set of `Cay(R, U)` over `ℚ(√3, √11)` has density at most `1/4`. -/
theorem density_le_of_cert {rows coefs : List ℕ} (hrows : rows.all (rowOk ptsL) = true)
    (hfit : rowsFit rows coefs = true)
    (hbound : ∀ U : ℕ, U < 2 ^ 27 → IndepFrom adjL 0 U → val U (expand singL rows coefs) ≤ Dn) :
    μ.density ≤ 4⁻¹ := by
  haveI := μ.isProb
  set T := expand singL rows coefs with hT
  have hae : ∀ᵐ c ∂μ.μ, c ∈ IndepSets seamField := by
    have h := measure_eq_zero_iff_ae_notMem.1 μ.carried
    filter_upwards [h] with c hc
    simpa using hc
  have hval : ∀ c ∈ IndepSets seamField, (val (mk c) T : ℝ) ≤ Dn := fun c hc => by
    exact_mod_cast hbound (mk c) (mk_lt c) (indepFrom_mk hc)
  have E1 := expect_le μ ptsOf T Dn (by
    filter_upwards [hae] with c hc
    rw [← val_mk]; exact hval c hc)
  have E2 := expect_le μ (fun t => (ptsOf t).map conjR) T Dn (by
    filter_upwards [hae] with c hc
    have h := hval _ (conj_indep hc)
    rw [val_mk] at h
    simpa only [indicator_allIn_conj] using h)
  have hsum : (T.map fun t => (cf t : ℝ) * phi μ (ptsOf t)).sum ≤ 2 * Dn := by
    have : (T.map fun t => (cf t : ℝ) * phi μ (ptsOf t)).sum =
        (T.map fun t => (cf t : ℝ) * (μ.μ (allIn (ptsOf t))).toReal).sum +
          (T.map fun t => (cf t : ℝ) * (μ.μ (allIn ((ptsOf t).map conjR))).toReal).sum := by
      rw [← List.sum_map_add]
      congr 1
      exact List.map_congr_left fun t _ => by rw [phi, mul_add]
    rw [this]; linarith
  have hsing := sing_ok
  simp only [singSumOk, Bool.and_eq_true, beq_iff_eq, List.all_eq_true, decide_eq_true_eq] at hsing
  obtain ⟨⟨hlen, -⟩, hsum4⟩ := hsing
  have hid : (T.map fun t => (cf t : ℝ) * phi μ (ptsOf t)).sum = 4 * Dn * phi μ [0] := by
    rw [hT, expand, List.map_append, List.sum_append, singTerms_phi μ singL 0 (by omega),
      rowsTerms_phi μ rows coefs hrows hfit, add_zero]
    have : (singL.map fun cpk : ℕ => (((cpk : ℤ) - OFFC : ℤ) : ℝ)).sum = ((4 * Dn : ℤ) : ℝ) := by
      rw [← hsum4, Int.cast_list_sum, List.map_map]; rfl
    rw [this]; push_cast; ring
  have hDn : (0 : ℝ) < Dn := by exact_mod_cast Dn_pos
  have hδ : (μ.density).toReal ≤ 4⁻¹ := by
    have h2 := phi_zero μ
    rw [hid, h2] at hsum
    have : (μ.μ {c | c 0 = true}).toReal * (8 * Dn) ≤ 2 * Dn := by linarith
    have h8 : (μ.μ {c | c 0 = true}).toReal ≤ 2 * Dn / (8 * Dn) := by
      rw [le_div_iff₀ (by positivity)]; exact this
    rw [show (2 : ℝ) * Dn / (8 * Dn) = 4⁻¹ by field_simp; norm_num] at h8
    exact h8
  have hfin : μ.density ≠ ⊤ := measure_ne_top _ _
  rw [← ENNReal.ofReal_toReal hfin]
  calc ENNReal.ofReal (μ.density).toReal ≤ ENNReal.ofReal 4⁻¹ := ENNReal.ofReal_le_ofReal hδ
    _ = 4⁻¹ := by rw [ENNReal.ofReal_inv_of_pos (by norm_num)]; norm_num

end

end HadwigerNelson.G27
