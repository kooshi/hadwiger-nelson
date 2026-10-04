import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Proofs.HadwigerNelson.Plane.SVMap
import Proofs.HadwigerNelson.Plane.LocalMapExamples

/-!
# The base's steps with unit arcs (FS-112's N3 round) and the bowtie fragment

Wave 4's skeleton (`plans/FS131-w4-kernel-plan.md` § 8). The vocabulary of row 134's base at a cubic trichromatic vertex `u`
(`plans/FS110-CB-verification.md` D1–D2, `plans/FS110-CE-verification.md` E6, `plans/FS112-N-proof.md` stage N3-3), point-set over
`ArcMap`:

* `pseudoColours u x` — CB's pseudo-colour `c′(x)` (S–V Def. 7): the colours at `x` not carried at `u`;
* `IsLeavingCentre u q` — `q ∈ ω(u)` carries on `ω(q)` an arc of `Γ` with constant sides ending at `u`; `leavingInner`, `leavingOuter`
  — the inner and outer colours of those arcs;
* `StripHolds u q` — CB's D2 strip at `q ∈ ω(u)`: on one side of `ω(u)` near `q` no interior point has a colour carried at `u`;
* `MIn u x` — CE5's M-in: a colour carried at `u` has `x` in the closure of its part strictly inside `ω(u)`.

Rows: **FS112-N3-PAIRS** (`pair_i`, `pair_ii`, `pair_P'`), **FS112-N3-FAIL** (`fail_leavingCentre`, `fail_colours`), **FS112-N3-ANTI**
(`anti`), **FS112-N3-END** (`n3_end`), **FS112-FLANK**'s last clause (`flank_incomplete_bowtie`), **FS112-BOWTIE** (`bowtie : ArcMap 6` and its properties — the wave's inhabitant of `IsHorn`,
`IsStuck`, `DoublyShadowed` and `TerminalOn`). FS112-N3-NOBOTH is in `Plane/ValidMap/UnitArc`; FS112-C-DOUBLE moved to wave 5 (inventory
item 69).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## The base's vocabulary -/

/-- CB's **pseudo-colour** `c′(x)` relative to `u` (S–V Def. 7, `c′(x) = c(x) ∩ {1, 2, 3}` when `c(u) = {4, 5, 6}`): the colours at `x`
not carried at `u`. -/
def pseudoColours (u x : ℂ) : Set (Fin k) := F.coloursAt x \ F.coloursAt u

/-- **A leaving centre** of `u`: a point `q ∈ ω(u)` such that an arc of `Γ` on `ω(q)` with constant sides ends at `u` (FS112-N3's "the
centre of a unit arc with endpoint `u`"). -/
def IsLeavingCentre (u q : ℂ) : Prop :=
  dist q u = 1 ∧ ∃ θ₁ θ₂ c c', F.IsRingArc q θ₁ θ₂ c c' ∧ (ringPt q θ₁ = u ∨ ringPt q θ₂ = u)

/-- The inner colours (toward `q`) of the arcs of `Γ` on `ω(q)` with constant sides ending at `u`. -/
def leavingInner (u q : ℂ) : Set (Fin k) :=
  {c | ∃ θ₁ θ₂ c', F.IsRingArc q θ₁ θ₂ c c' ∧ (ringPt q θ₁ = u ∨ ringPt q θ₂ = u)}

/-- The outer colours of the arcs of `Γ` on `ω(q)` with constant sides ending at `u`. -/
def leavingOuter (u q : ℂ) : Set (Fin k) :=
  {c' | ∃ θ₁ θ₂ c, F.IsRingArc q θ₁ θ₂ c c' ∧ (ringPt q θ₁ = u ∨ ringPt q θ₂ = u)}

/-- **CB's D2 strip holds at `q`**: on one side of `ω(u)` near `q` (inside or outside), no interior point has a colour carried at `u`. -/
def StripHolds (u q : ℂ) : Prop :=
  ∃ ε > 0, (∀ z ∈ F.interiorPts ∩ ball q ε ∩ ball u 1, F.col z ∉ F.coloursAt u) ∨
    ∀ z ∈ (F.interiorPts ∩ ball q ε) \ closedBall u 1, F.col z ∉ F.coloursAt u

/-- **M-in** (CE5): some colour carried at `u` has `x` in the closure of its part strictly inside `ω(u)`. -/
def MIn (u x : ℂ) : Prop := ∃ c ∈ F.coloursAt u, x ∈ closure (F.region c ∩ ball u 1)

end ArcMap

/-! ### Spec examples -/

section Spec

/-- On the one-colour plane every colour class is the plane, so the one colour is carried everywhere. -/
theorem const_univ_coloursAt (j : Fin 2) (x : ℂ) : (ArcMap.const univ isOpen_univ j).coloursAt x = {j} := by
  ext c
  simp only [ArcMap.coloursAt, mem_setOf_eq, mem_singleton_iff]
  constructor
  · intro h
    by_contra hne
    have hreg : (ArcMap.const univ isOpen_univ j).region c = ∅ := by
      ext z; simp [ArcMap.region, ArcMap.const, ArcMap.interiorPts, Ne.symm hne]
    rw [hreg, closure_empty] at h
    exact h
  · rintro rfl
    have hreg : (ArcMap.const univ isOpen_univ c).region c = univ := by
      ext z; simp [ArcMap.region, ArcMap.const, ArcMap.interiorPts]
    rw [hreg, closure_univ]; trivial

/-- The pseudo-colours on the one-colour plane are empty. -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).pseudoColours 0 1 = ∅ := by
  simp [ArcMap.pseudoColours, const_univ_coloursAt]

/-- On the one-colour plane every point of `ω(0)` is M-in. -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).MIn 0 1 := by
  refine ⟨j, by simp [const_univ_coloursAt], ?_⟩
  have hreg : (ArcMap.const univ isOpen_univ j).region j = univ := by
    ext z; simp [ArcMap.region, ArcMap.const, ArcMap.interiorPts]
  rw [hreg, univ_inter, closure_ball _ one_ne_zero, mem_closedBall, dist_zero_right]; simp

/-- **Adversary**: on the one-colour plane the strip holds nowhere (both sides carry the colour of the centre). -/
example (j : Fin 2) : ¬ (ArcMap.const univ isOpen_univ j).StripHolds 0 1 := by
  rintro ⟨ε, hε, h | h⟩
  · refine h ((1 - min (ε / 2) (1 / 2) : ℝ) : ℂ) ⟨⟨by simp [ArcMap.const, ArcMap.interiorPts], ?_⟩, ?_⟩ ?_
    · rw [mem_ball, dist_eq_norm, ← ofReal_one, ← ofReal_sub, norm_real, Real.norm_eq_abs]
      rw [abs_of_nonpos (by linarith [min_le_left (ε / 2) (1 / 2), lt_min (half_pos hε) (by norm_num : (0:ℝ) < 1 / 2)])]
      linarith [min_le_left (ε / 2) (1 / 2)]
    · rw [mem_ball, dist_zero_right, norm_real, Real.norm_eq_abs]
      have h0 := lt_min (half_pos hε) (by norm_num : (0:ℝ) < 1 / 2)
      rw [abs_of_pos (by linarith [min_le_right (ε / 2) (1 / 2)])]; linarith
    · show j ∈ (ArcMap.const univ isOpen_univ j).coloursAt 0
      rw [const_univ_coloursAt]; rfl
  · refine h ((1 + ε / 2 : ℝ) : ℂ) ⟨⟨by simp [ArcMap.const, ArcMap.interiorPts], ?_⟩, ?_⟩ ?_
    · rw [mem_ball, dist_eq_norm, ← ofReal_one, ← ofReal_sub, norm_real, Real.norm_eq_abs,
        abs_of_pos (by linarith)]; linarith
    · rw [mem_closedBall, dist_zero_right, norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]; linarith
    · show j ∈ (ArcMap.const univ isOpen_univ j).coloursAt 0
      rw [const_univ_coloursAt]; rfl

/-- `quadRing`'s ring arc `[0°, 90°]` of `ω(0)` ends at `1`, so `0` is a leaving centre of `1`. -/
example : quadRing.IsLeavingCentre 1 0 :=
  ⟨by simp, 0, π / 2, 0, 2, quadRing_isRingArc, Or.inl (by simp [ringPt, e])⟩

/-- **Adversary**: a map with no arcs has no leaving centre. -/
example (j : Fin 2) : ¬ (ArcMap.const univ isOpen_univ j).IsLeavingCentre 1 0 := by
  rintro ⟨-, θ₁, θ₂, c, c', ⟨hlt, hsub, -⟩, -⟩
  have := hsub ⟨θ₁, ⟨le_refl _, hlt.le⟩, rfl⟩
  simp [ArcMap.Γ, ArcMap.const] at this

/-! ### The brick corner: a cubic trichromatic vertex with an M-in point (FS131-QA2's QA2-2) -/

/-- **An M-in point at the brick corner**: the far corner `x = 4/5 + 3/5 i` of the upper right cell at the corner `0` of `sevenBrickMap`
is at distance exactly `1` (3–4–5) and lies in the closure of that cell's part inside `ω(0)` — colour `0`, carried at `0`. With
`sevenBrick_corner_isCubicTrichromatic` this exercises `anti`'s hypotheses `IsCubicTrichromatic u ∧ MIn u x` on a valid map of the plane
at `k = 7`; the second, antipodal M-in point is the clause `anti` refutes (the brick's two M-in points `±4/5 + 3/5 i` are `8/5` apart). -/
theorem sevenBrick_corner_mIn :
    dist (((4 / 5 : ℝ) : ℂ) + ((3 / 5 : ℝ) : ℂ) * I) 0 = 1 ∧ sevenBrickMap.MIn 0 (((4 / 5 : ℝ) : ℂ) + ((3 / 5 : ℝ) : ℂ) * I) := by
  set x : ℂ := ((4 / 5 : ℝ) : ℂ) + ((3 / 5 : ℝ) : ℂ) * I with hx
  have hxre : x.re = 4 / 5 := by simp [hx]
  have hxim : x.im = 3 / 5 := by simp [hx]
  have hnx : ‖x‖ = 1 := by
    rw [← Real.sqrt_sq (norm_nonneg x), ← Complex.normSq_eq_norm_sq, Complex.normSq_apply, hxre, hxim]
    norm_num
  refine ⟨by rw [dist_zero_right, hnx], 0, by rw [sevenBrick_corner_coloursAt]; simp, ?_⟩
  rw [Metric.mem_closure_iff]
  intro ε hε
  set t : ℝ := min (ε / 2) (1 / 4) with ht
  have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
  have ht1 : t ≤ 1 / 4 := min_le_right _ _
  set z : ℂ := ((1 - t : ℝ) : ℂ) * x with hz
  have hzre : z.re = 4 / 5 * (1 - t) := by rw [hz, Complex.re_ofReal_mul, hxre]; ring
  have hzim : z.im = 3 / 5 * (1 - t) := by rw [hz, Complex.im_ofReal_mul, hxim]; ring
  have hfl : ⌊z.im / (3 / 5)⌋ = 0 := by
    rw [Int.floor_eq_iff, hzim]; push_cast; rw [zero_add]
    constructor
    · apply div_nonneg <;> linarith
    · rw [div_lt_one (by norm_num)]; linarith
  have hnot : ∀ n : ℤ, 1 - t ≠ n := by
    intro n hn
    rcases lt_or_ge 0 n with hn0 | hn0
    · have : (1 : ℝ) ≤ n := by exact_mod_cast hn0
      linarith
    · have : (n : ℝ) ≤ 0 := by exact_mod_cast hn0
      linarith
  have hzint : z ∈ sevenBrickMap.interiorPts := by
    refine ⟨mem_univ z, not_mem_sevenBrickArcs (fun n hn => hnot n ?_) (fun n hn => hnot n ?_)⟩
    · rw [hzim] at hn; linarith
    · rw [hfl, hzre] at hn; push_cast at hn; linarith
  have hzcol : sevenBrickMap.col z = 0 := by
    rw [sevenBrick_color_eq (c := 0) (r := 0) hfl]
    · decide
    · rw [Int.floor_eq_iff, hzre]; push_cast; rw [zero_add]; simp only [mul_zero, sub_zero]
      constructor
      · apply div_nonneg <;> linarith
      · rw [div_lt_one (by norm_num)]; linarith
  have hnz : ‖z‖ = 1 - t := by
    rw [hz, norm_mul, hnx, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos (by linarith)]
  refine ⟨z, ⟨⟨hzint, hzcol⟩, by rw [mem_ball_zero_iff, hnz]; linarith⟩, ?_⟩
  have : x - z = ((t : ℝ) : ℂ) * x := by rw [hz]; push_cast; ring
  rw [dist_eq_norm, this, norm_mul, hnx, mul_one, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
  linarith [min_le_left (ε / 2) (1 / 4)]

end Spec

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS112-N3-PAIRS -/

/-- **FS112-N3-PAIRS** (i), N3-I (CB's (i) never fails): for cubic trichromatic `u₁`, `u₂` and a unit pair `x ∈ ω(u₁)`,
`y ∈ ω(u₂)`, the pseudo-colours `c′(x) = c′(y) = {a}` are impossible (no transversality hypothesis; `u₁ = u₂` allowed). Inhabitant of `IsCubicTrichromatic` on a valid map of the plane: `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`). -/
theorem pair_i (hF : F.Valid) {u₁ u₂ x y : ℂ} (h₁ : F.IsCubicTrichromatic u₁) (h₂ : F.IsCubicTrichromatic u₂)
    (hc₁ : F.Covers u₁ 1) (hc₂ : F.Covers u₂ 1) (hx : dist x u₁ = 1) (hy : dist y u₂ = 1) (hxy : dist x y = 1) {a : Fin k}
    (hax : F.pseudoColours u₁ x = {a}) (hay : F.pseudoColours u₂ y = {a}) : False := by
  sorry

/-- **FS112-N3-PAIRS** (ii), N3-II: for a unit pair `x ∈ ω(u₁)`, `y ∈ ω(u₂)` with `c′(x) = c′(y) = {a, b}` and `ω(y)` transversal
to `ω(u₁)` at `x` (`y ≠ u₁`, `|y − u₁| ≠ 2`), `x` carries at least four colours or `y` is the centre of a both-kind unit arc. Inhabitant of `IsCubicTrichromatic` on a valid map of the plane: `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`). -/
theorem pair_ii (hF : F.Valid) {u₁ u₂ x y : ℂ} (h₁ : F.IsCubicTrichromatic u₁) (h₂ : F.IsCubicTrichromatic u₂)
    (hc₁ : F.Covers u₁ 1) (hc₂ : F.Covers u₂ 1) (hx : dist x u₁ = 1) (hy : dist y u₂ = 1) (hxy : dist x y = 1)
    (htr : y ≠ u₁ ∧ dist y u₁ ≠ 2) {a b : Fin k} (hab : a ≠ b) (hax : F.pseudoColours u₁ x = {a, b})
    (hay : F.pseudoColours u₂ y = {a, b}) :
    4 ≤ (F.coloursAt x).ncard ∨ ∃ θ₁ θ₂, F.BothKind y θ₁ θ₂ := by
  sorry

/-- **FS112-N3-PAIRS**, N3-P′: two cubic trichromatic vertices with one multicolour are never at distance `1`. Inhabitant of `IsCubicTrichromatic` on a valid map of the plane: `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`). -/
theorem pair_P' (hF : F.Valid) {u u' : ℂ} (h : F.IsCubicTrichromatic u) (h' : F.IsCubicTrichromatic u') (hu : u ∈ F.dom)
    (hu' : u' ∈ F.dom) (hcol : F.coloursAt u = F.coloursAt u') : dist u u' ≠ 1 := by
  sorry

/-! ## FS112-N3-FAIL -/

/-- **FS112-N3-FAIL**, the place: at a cubic trichromatic `u`, the strip fails at `q ∈ ω(u)` only when `q` is a leaving centre of
`u`. Inhabitant of `IsCubicTrichromatic` on a valid map of the plane: `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`). -/
theorem fail_leavingCentre (hF : F.Valid) {u q : ℂ} (hu : F.IsCubicTrichromatic u) (hc : F.Covers u 1) (hq : dist q u = 1)
    (hs : ¬ F.StripHolds u q) : F.IsLeavingCentre u q := by
  sorry

/-- **FS112-N3-FAIL**, the colours: where the strip fails at `q`, the colours of `c(u)` occurring inside `ω(u)` near `q` are among the
inner colours of the arcs of `ω(q)` leaving `u`, those occurring outside among their outer colours, and each side carries at least one
colour of `c(u)` (the row's "exactly", read as the proof's "only"; equality when one such arc leaves `u`). -/
theorem fail_colours (hF : F.Valid) {u q : ℂ} (hu : F.IsCubicTrichromatic u) (hc : F.Covers u 1) (hq : dist q u = 1)
    (hs : ¬ F.StripHolds u q) :
    (F.innerColours u q ∩ F.coloursAt u).Nonempty ∧ F.innerColours u q ∩ F.coloursAt u ⊆ F.leavingInner u q ∧
      (F.outerColours u q ∩ F.coloursAt u).Nonempty ∧ F.outerColours u q ∩ F.coloursAt u ⊆ F.leavingOuter u q := by
  sorry

/-! ## FS112-N3-ANTI -/

/-- **FS112-N3-ANTI** (CE5, the Antipodal Lemma, with unit arcs): at a cubic trichromatic `u`, no two points of `ω(u)` at distance `2`
are both M-in. Inhabitant of `IsCubicTrichromatic` on a valid map of the plane: `sevenBrick_corner_isCubicTrichromatic` (`Plane/SVMap`). With one M-in point: `sevenBrick_corner_mIn` (the antipodal second is the refuted clause). -/
theorem anti (hF : F.Valid) {u x y : ℂ} (hu : F.IsCubicTrichromatic u) (hc : F.Covers u 1) (hx : dist x u = 1)
    (hy : dist y u = 1) (hxy : dist x y = 2) (h1 : F.MIn u x) (h2 : F.MIn u y) : False := by
  sorry

/-! ## FS112-N3-END -/

/-- **FS112-N3-END** (NB3's corrected form): in a terminal valid map of the plane, let `v` be stuck with exactly three colours, its
two-sector colour `c` having a horn along `e α` whose lower arc has curvature `−1` (an arc of `ω(v − n)`). Then either `v − n` carries
at least four colours and a repeated colour and `v − 2n` is the centre of a both-kind unit arc, or the upper flank colour `g` is
in-type at `v + n` and both horns' upper arcs lie on `ω(v + n)` (`κ₂ = 1`; for the horn along `−a` its lower arc in its own frame).
The row's "and the chain is the single vertex" needs wave 5's stuck-chain vocabulary and is not stated here (§ 8 of the plan). -/
theorem n3_end (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {v : ℂ} {α κ₂ : ℝ} {c : Fin k} (hst : F.IsStuck v)
    (h3 : (F.coloursAt v).ncard = 3) (hc2 : F.HasSectors v c 2) (hH : F.IsHorn v α (-1) κ₂ c) :
    (4 ≤ (F.coloursAt (v - e (α + π / 2))).ncard ∧ F.HasRepeatedColour (v - e (α + π / 2)) ∧
        ∃ θ₁ θ₂, F.BothKind (v - 2 * e (α + π / 2)) θ₁ θ₂) ∨
      ∃ g, F.IsFlankAbove v α κ₂ g ∧ F.IsContact v g (v + e (α + π / 2)) ∧ F.InType v g (v + e (α + π / 2)) ∧ κ₂ = 1 ∧
        ∀ κ₃ κ₄, F.IsHorn v (α + π) κ₃ κ₄ c → κ₃ = -1 := by
  sorry

end ArcMap

/-! ## FS112-BOWTIE: the exact fragment (`plans/FS112-YB3-verification.md` § 2.2, `tools/fs112_yb3_frags.py bowtie`) -/

/-- The point `(x, y)`. -/
def pt (x y : ℝ) : ℂ := ⟨x, y⟩

/-- The tiles of the bowtie, by inequalities (`s = 5/13`, `c = 12/13`, `ρ = 2/5`; YB3's colours `1, …, 6` are `0, …, 5`): `G` (colour
`0`, the sector of radius 1 about `N = i` of half-angle `arcsin (5/13)` pointing down), `H` (colour `2`, its mirror about `S = −i`), the
horns `C±` (colour `1`, between `ω(N)` and `ω(S)` for `0 < ±x < 5/13`), `CN`, `CS` (colour `1`, triangles at `N`, `S`), `XR`, `YR` (colour
`3`), `XL`, `YL` (colour `4`), `ZR`, `ZL` (colour `5`, closing the unit arcs' ends). -/
def bowtieG : Set ℂ := {z | ‖z - I‖ < 1 ∧ z.im < 1 ∧ 12 * |z.re| < 5 * (1 - z.im)}
/-- The sector `H` (colour `2`), the mirror of `G` about the real axis. -/
def bowtieH : Set ℂ := {z | ‖z + I‖ < 1 ∧ -1 < z.im ∧ 12 * |z.re| < 5 * (1 + z.im)}
/-- The two horns `C±` (colour `1`), between `ω(N)` and `ω(S)` for `0 < |x| < 5/13`. -/
def bowtieC : Set ℂ := {z | z.re ≠ 0 ∧ |z.re| < 5 / 13 ∧ |z.im| < 1 / 13 ∧ 1 < ‖z - I‖ ∧ 1 < ‖z + I‖}
/-- The triangle `CN` at `N` (colour `1`), directions `[45°, 135°]`. -/
def bowtieCN : Set ℂ := {z | |z.re| < z.im - 1 ∧ z.im < 7 / 5}
/-- The triangle `CS` at `S` (colour `1`), directions `[225°, 315°]`. -/
def bowtieCS : Set ℂ := {z | |z.re| < -1 - z.im ∧ -7 / 5 < z.im}
/-- The quadrilateral `XR` (`σ = 1`, colour `3`) or `XL` (`σ = −1`, colour `4`) at `N`. -/
def bowtieX (σ : ℝ) : Set ℂ := {z | 0 < 12 * (σ * z.re) + 5 * (z.im - 1) ∧ z.im - 1 < σ * z.re ∧ σ * z.re < 2 / 5 ∧ 41 / 65 < z.im}
/-- The quadrilateral `YR` (`σ = 1`, colour `3`) or `YL` (`σ = −1`, colour `4`) at `S`. -/
def bowtieY (σ : ℝ) : Set ℂ := {z | 0 < 12 * (σ * z.re) - 5 * (z.im + 1) ∧ -z.im - 1 < σ * z.re ∧ σ * z.re < 2 / 5 ∧ z.im < -41 / 65}
/-- The hexagon `ZR` (`σ = 1`) or `ZL` (`σ = −1`), colour `5`, closing the unit arcs' ends. -/
def bowtieZ (σ : ℝ) : Set ℂ := {z | 9 / 26 < σ * z.re ∧ σ * z.re < 113 / 260 ∧ |z.im| < 11 / 65 ∧
  ¬ (σ * z.re ≤ 5 / 13 ∧ 12 * (σ * z.re) + 5 * (z.im - 1) ≤ 0 ∧ 12 * (σ * z.re) - 5 * (z.im + 1) ≤ 0)}

/-- The union of the bowtie's tiles. -/
def bowtieTiles : Set ℂ :=
  bowtieG ∪ bowtieH ∪ bowtieC ∪ bowtieCN ∪ bowtieCS ∪ bowtieX 1 ∪ bowtieX (-1) ∪ bowtieY 1 ∪ bowtieY (-1) ∪ bowtieZ 1 ∪ bowtieZ (-1)

/-- The bowtie's colour by tile (YB3's colours less one). -/
noncomputable def bowtieCol (z : ℂ) : Fin 6 := by
  classical
  exact if z ∈ bowtieG then 0 else if z ∈ bowtieC ∪ bowtieCN ∪ bowtieCS then 1 else if z ∈ bowtieH then 2
    else if z ∈ bowtieX 1 ∪ bowtieY 1 then 3 else if z ∈ bowtieX (-1) ∪ bowtieY (-1) then 4 else 5

/-- `arcsin (5/13)`, the half-angle of the sectors `G`, `H`. -/
noncomputable def bowtieAngle : ℝ := Real.arcsin (5 / 13)

/-- The bowtie's boundary pieces: the unit arcs of `ω(N)` and `ω(S)` (the sectors' arcs, through `E = 0`) and the segments of every
tile's polygonal edges (shared edges listed once or twice; the set is what counts). -/
noncomputable def bowtieArcs : Set Arc :=
  {a | a ∈ [Arc.circ I 1 (3 * π / 2 - bowtieAngle) (3 * π / 2 + bowtieAngle),
    Arc.circ (-I) 1 (π / 2 - bowtieAngle) (π / 2 + bowtieAngle),
    -- G, H, the horns' closing segments
    .seg I (pt (-5/13) (1/13)), .seg (pt (5/13) (1/13)) I, .seg (-I) (pt (5/13) (-1/13)), .seg (pt (-5/13) (-1/13)) (-I),
    .seg (pt (5/13) (1/13)) (pt (5/13) (-1/13)), .seg (pt (-5/13) (-1/13)) (pt (-5/13) (1/13)),
    -- CN, CS
    .seg I (pt (2/5) (7/5)), .seg (pt (2/5) (7/5)) (pt (-2/5) (7/5)), .seg (pt (-2/5) (7/5)) I,
    .seg (-I) (pt (-2/5) (-7/5)), .seg (pt (-2/5) (-7/5)) (pt (2/5) (-7/5)), .seg (pt (2/5) (-7/5)) (-I),
    -- XR, XL, YR, YL
    .seg (pt (2/13) (41/65)) (pt (2/5) (41/65)), .seg (pt (2/5) (41/65)) (pt (2/5) (7/5)),
    .seg (pt (-2/13) (41/65)) (pt (-2/5) (41/65)), .seg (pt (-2/5) (41/65)) (pt (-2/5) (7/5)),
    .seg (pt (2/13) (-41/65)) (pt (2/5) (-41/65)), .seg (pt (2/5) (-41/65)) (pt (2/5) (-7/5)),
    .seg (pt (-2/13) (-41/65)) (pt (-2/5) (-41/65)), .seg (pt (-2/5) (-41/65)) (pt (-2/5) (-7/5)),
    -- ZR, ZL
    .seg (pt (9/26) (11/65)) (pt (113/260) (11/65)), .seg (pt (113/260) (11/65)) (pt (113/260) (-11/65)),
    .seg (pt (113/260) (-11/65)) (pt (9/26) (-11/65)),
    .seg (pt (-9/26) (11/65)) (pt (-113/260) (11/65)), .seg (pt (-113/260) (11/65)) (pt (-113/260) (-11/65)),
    .seg (pt (-113/260) (-11/65)) (pt (-9/26) (-11/65))]}

/-- Every boundary piece of the bowtie has positive length. -/
theorem bowtieArcs_nondegenerate : ∀ a ∈ bowtieArcs, a.Nondegenerate := by
  have hang : 0 < bowtieAngle := Real.arcsin_pos.2 (by norm_num)
  have hang2 : bowtieAngle ≤ π / 2 := Real.arcsin_le_pi_div_two _
  intro a ha
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  have hne : ∀ x y x' y' : ℝ, (x ≠ x' ∨ y ≠ y') → pt x y ≠ pt x' y' := by
    intro x y x' y' h hxy
    have h1 := congrArg Complex.re hxy
    have h2 := congrArg Complex.im hxy
    simp only [pt] at h1 h2
    rcases h with h | h <;> contradiction
  have hI : ∀ x y : ℝ, (x ≠ 0 ∨ y ≠ 1) → pt x y ≠ I := by
    intro x y h hxy
    have h1 := congrArg Complex.re hxy
    have h2 := congrArg Complex.im hxy
    simp only [pt, Complex.I_re, Complex.I_im] at h1 h2
    rcases h with h | h <;> contradiction
  have hnI : ∀ x y : ℝ, (x ≠ 0 ∨ y ≠ -1) → pt x y ≠ -I := by
    intro x y h hxy
    have h1 := congrArg Complex.re hxy
    have h2 := congrArg Complex.im hxy
    simp only [pt, Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im] at h1 h2
    rcases h with h | h <;> [exact h (by linarith); exact h (by linarith)]
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · exact ⟨one_pos, by linarith, by linarith [Real.pi_pos]⟩
  · exact ⟨one_pos, by linarith, by linarith [Real.pi_pos]⟩
  all_goals first
    | exact (hI _ _ (by norm_num)).symm
    | exact hI _ _ (by norm_num)
    | exact (hnI _ _ (by norm_num)).symm
    | exact hnI _ _ (by norm_num)
    | exact hne _ _ _ _ (by norm_num)

/-- The bowtie has finitely many boundary pieces. -/
theorem bowtieArcs_locallyFinite : ∀ x ∈ interior (closure bowtieTiles), ∃ t ∈ 𝓝 x,
    {a | a ∈ bowtieArcs ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  intro x _
  refine ⟨univ, univ_mem, ?_⟩
  have hfin : bowtieArcs.Finite := by unfold bowtieArcs; exact List.finite_toSet _
  exact hfin.subset fun a ha => ha.1

/-- The bowtie's colour is locally constant off its boundary pieces, inside its domain. -/
theorem bowtieCol_locallyConstant : ∀ x ∈ interior (closure bowtieTiles), x ∉ ⋃ a ∈ bowtieArcs, a.carrier →
    ∀ᶠ y in 𝓝 x, bowtieCol y = bowtieCol x := by
  sorry

/-- **FS112-BOWTIE's fragment**: the map of the interior of the closure of its tiles. -/
noncomputable def bowtie : ArcMap 6 where
  dom := interior (closure bowtieTiles)
  isOpen_dom := isOpen_interior
  arcs := bowtieArcs
  nondegenerate := bowtieArcs_nondegenerate
  locallyFinite := bowtieArcs_locallyFinite
  col := bowtieCol
  locallyConstant := bowtieCol_locallyConstant

namespace ArcMap

/-! ### The bowtie near `E = 0`: the cusp fragment's partition (FS131-I4e)

Within `1/13` of `E = 0` the bowtie's arcs are its two unit arcs alone (each of its 28 segments lies in a half-plane `re ≥ 1/13`,
`re ≤ −1/13`, `im ≥ 1/13` or `im ≤ −1/13`), so its interior points there are the cusp fragment's (`Plane/ValidMap/Sectors`): the two
horns (colour `1`), the part of `G` (colour `0`) and the part of `H` (colour `2`). -/

/-- `e (π + π/2) = −i`: the normal of the frame along `e π`. -/
theorem e_pi_add_pi_div_two : e (π + π / 2) = -I := by
  rw [e_eq, Real.cos_add_pi_div_two, Real.sin_add_pi_div_two, Real.sin_pi, Real.cos_pi]; simp

/-- A segment with both ends in one of the half-planes `re ≥ 1/13`, `re ≤ −1/13`, `im ≥ 1/13`, `im ≤ −1/13` misses `B(0, 1/13)`. -/
theorem norm_ge_of_mem_segment_far {a b z : ℂ}
    (h : (1 / 13 ≤ a.re ∧ 1 / 13 ≤ b.re) ∨ (a.re ≤ -1 / 13 ∧ b.re ≤ -1 / 13) ∨ (1 / 13 ≤ a.im ∧ 1 / 13 ≤ b.im) ∨
      (a.im ≤ -1 / 13 ∧ b.im ≤ -1 / 13)) (hz : z ∈ segment ℝ a b) : 1 / 13 ≤ ‖z‖ := by
  have hre := Complex.abs_re_le_norm z
  have him := Complex.abs_im_le_norm z
  rcases h with ⟨ha, hb⟩ | ⟨ha, hb⟩ | ⟨ha, hb⟩ | ⟨ha, hb⟩
  · have : 1 / 13 ≤ z.re := (convex_halfSpace_re_ge (1 / 13)).segment_subset ha hb hz
    linarith [le_abs_self z.re]
  · have : z.re ≤ -1 / 13 := (convex_halfSpace_re_le (-1 / 13)).segment_subset ha hb hz
    linarith [neg_le_abs z.re]
  · have : 1 / 13 ≤ z.im := (convex_halfSpace_im_ge (1 / 13)).segment_subset ha hb hz
    linarith [le_abs_self z.im]
  · have : z.im ≤ -1 / 13 := (convex_halfSpace_im_le (-1 / 13)).segment_subset ha hb hz
    linarith [neg_le_abs z.im]

/-- A point of `ω(i)` within `1/13` of `0` lies on the bowtie's arc of `ω(i)`, at the angle `3π/2 + arcsin (re z)`. -/
theorem mem_bowtieArc_N {z : ℂ} (hz : ‖z‖ < 1 / 13) (h1 : ‖z - I‖ = 1) :
    z ∈ (Arc.circ I 1 (3 * π / 2 - bowtieAngle) (3 * π / 2 + bowtieAngle)).carrier := by
  have hre : |z.re| < 1 / 13 := (Complex.abs_re_le_norm z).trans_lt hz
  have him : |z.im| < 1 / 13 := (Complex.abs_im_le_norm z).trans_lt hz
  have hsq : z.re ^ 2 + (z.im - 1) ^ 2 = 1 := by
    have h2 : ‖z - I‖ ^ 2 = 1 := by rw [h1]; norm_num
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply] at h2
    simp only [Complex.sub_re, Complex.sub_im, Complex.I_re, Complex.I_im, sub_zero] at h2
    nlinarith
  have hx1 : -1 ≤ z.re := by linarith [(abs_lt.mp hre).1]
  have hx2 : z.re ≤ 1 := by linarith [(abs_lt.mp hre).2]
  have hsin : Real.sin (Real.arcsin z.re) = z.re := Real.sin_arcsin hx1 hx2
  have hcos : Real.cos (Real.arcsin z.re) = 1 - z.im := by
    rw [Real.cos_arcsin, show 1 - z.re ^ 2 = (1 - z.im) ^ 2 by nlinarith]
    exact Real.sqrt_sq (by linarith [(abs_lt.mp him).2])
  have hl : -bowtieAngle ≤ Real.arcsin z.re := by
    unfold bowtieAngle; rw [← Real.arcsin_neg]; exact Real.arcsin_le_arcsin (by linarith [(abs_lt.mp hre).1])
  have hu : Real.arcsin z.re ≤ bowtieAngle := Real.arcsin_le_arcsin (by linarith [(abs_lt.mp hre).2])
  refine ⟨3 * π / 2 + Real.arcsin z.re, ⟨by linarith, by linarith⟩, ?_⟩
  have h3 : 3 * π / 2 + Real.arcsin z.re = (Real.arcsin z.re - π / 2) + 2 * π := by ring
  apply Complex.ext
  · simp only [Complex.add_re, Complex.I_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, h3,
      Real.cos_add_two_pi, Real.sin_add_two_pi, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two, hsin]
    ring
  · simp only [Complex.add_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, h3,
      Real.cos_add_two_pi, Real.sin_add_two_pi, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two, hcos]
    ring

/-- A point of `ω(−i)` within `1/13` of `0` lies on the bowtie's arc of `ω(−i)`, at the angle `π/2 − arcsin (re z)`. -/
theorem mem_bowtieArc_S {z : ℂ} (hz : ‖z‖ < 1 / 13) (h1 : ‖z + I‖ = 1) :
    z ∈ (Arc.circ (-I) 1 (π / 2 - bowtieAngle) (π / 2 + bowtieAngle)).carrier := by
  have hre : |z.re| < 1 / 13 := (Complex.abs_re_le_norm z).trans_lt hz
  have him : |z.im| < 1 / 13 := (Complex.abs_im_le_norm z).trans_lt hz
  have hsq : z.re ^ 2 + (z.im + 1) ^ 2 = 1 := by
    have h2 : ‖z + I‖ ^ 2 = 1 := by rw [h1]; norm_num
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply] at h2
    simp only [Complex.add_re, Complex.add_im, Complex.I_re, Complex.I_im, add_zero] at h2
    nlinarith
  have hx1 : -1 ≤ z.re := by linarith [(abs_lt.mp hre).1]
  have hx2 : z.re ≤ 1 := by linarith [(abs_lt.mp hre).2]
  have hsin : Real.sin (Real.arcsin z.re) = z.re := Real.sin_arcsin hx1 hx2
  have hcos : Real.cos (Real.arcsin z.re) = 1 + z.im := by
    rw [Real.cos_arcsin, show 1 - z.re ^ 2 = (1 + z.im) ^ 2 by nlinarith]
    exact Real.sqrt_sq (by linarith [(abs_lt.mp him).1])
  have hl : -bowtieAngle ≤ Real.arcsin z.re := by
    unfold bowtieAngle; rw [← Real.arcsin_neg]; exact Real.arcsin_le_arcsin (by linarith [(abs_lt.mp hre).1])
  have hu : Real.arcsin z.re ≤ bowtieAngle := Real.arcsin_le_arcsin (by linarith [(abs_lt.mp hre).2])
  refine ⟨π / 2 - Real.arcsin z.re, ⟨by linarith, by linarith⟩, ?_⟩
  apply Complex.ext
  · simp only [Complex.add_re, Complex.neg_re, Complex.I_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, re_e,
      im_e, Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, hsin]
    ring
  · simp only [Complex.add_im, Complex.neg_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e,
      im_e, Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, hcos]
    ring

/-- Within `1/13` of `0` a point lies on a boundary piece of the bowtie exactly when it lies on `ω(i)` or `ω(−i)`. -/
theorem mem_bowtieArcs_iff_of_norm_lt {z : ℂ} (hz : ‖z‖ < 1 / 13) :
    z ∈ ⋃ a ∈ bowtieArcs, a.carrier ↔ ‖z - I‖ = 1 ∨ ‖z + I‖ = 1 := by
  constructor
  · intro h
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
    simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
    rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
      rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
    · left; obtain ⟨θ, -, rfl⟩ := hza; simp
    · right; obtain ⟨θ, -, rfl⟩ := hza; simp
    all_goals exact absurd (norm_ge_of_mem_segment_far (by norm_num [pt]) hza) (not_le.mpr hz)
  · rintro (h | h)
    · exact mem_iUnion₂.mpr ⟨_, by simp [bowtieArcs], mem_bowtieArc_N hz h⟩
    · exact mem_iUnion₂.mpr ⟨_, by simp [bowtieArcs], mem_bowtieArc_S hz h⟩

/-- The cusp's pieces at radius `r ≤ 1/13` lie in the bowtie's tiles: the horns in `C`, the upper disc's part in `G`, the lower's in `H`. -/
theorem cuspPiece_subset_bowtie {r : ℝ} (hr : r ≤ 1 / 13) :
    cuspPiece r 0 ⊆ bowtieC ∧ cuspPiece r 1 ⊆ bowtieC ∧ cuspPiece r 2 ⊆ bowtieG ∧ cuspPiece r 3 ⊆ bowtieH := by
  have hb : ∀ z : ℂ, ‖z‖ < r → |z.re| < 1 / 13 ∧ |z.im| < 1 / 13 := fun z hz =>
    ⟨(Complex.abs_re_le_norm z).trans_lt (hz.trans_le hr), (Complex.abs_im_le_norm z).trans_lt (hz.trans_le hr)⟩
  refine ⟨fun z hz => ?_, fun z hz => ?_, fun z hz => ?_, fun z hz => ?_⟩
  · obtain ⟨h0, h1, h2, h3⟩ := (hornSet_cusp_iff r z).mp hz
    obtain ⟨hre, him⟩ := hb z h0
    exact ⟨h1.ne', by linarith, him, h3, h2⟩
  · obtain ⟨h0, h1, h2, h3⟩ := mem_cuspPiece_one.mp hz
    obtain ⟨hre, him⟩ := hb z h0
    exact ⟨h1.ne, by linarith, him, h3, h2⟩
  · obtain ⟨h0, h1⟩ := hz
    rw [mem_ball_zero_iff] at h0; rw [mem_ball, dist_eq_norm] at h1
    obtain ⟨hre, him⟩ := hb z h0
    exact ⟨h1, by linarith [(abs_lt.mp him).2], by linarith [(abs_lt.mp him).2]⟩
  · obtain ⟨h0, h1⟩ := hz
    rw [mem_ball_zero_iff] at h0; rw [mem_ball, dist_eq_norm, sub_neg_eq_add] at h1
    obtain ⟨hre, him⟩ := hb z h0
    exact ⟨h1, by linarith [(abs_lt.mp him).1], by linarith [(abs_lt.mp him).1]⟩

/-- The bowtie's colour on `G` is `0`. -/
theorem bowtieCol_of_mem_G {z : ℂ} (hz : z ∈ bowtieG) : bowtieCol z = 0 := by
  unfold bowtieCol; rw [if_pos hz]

/-- The bowtie's colour on `C` is `1` (`C` lies outside the unit disc about `i`, so off `G`). -/
theorem bowtieCol_of_mem_C {z : ℂ} (hz : z ∈ bowtieC) : bowtieCol z = 1 := by
  have hG : z ∉ bowtieG := fun h => by linarith [h.1, hz.2.2.2.1]
  unfold bowtieCol; rw [if_neg hG, if_pos (show z ∈ bowtieC ∪ bowtieCN ∪ bowtieCS from Or.inl (Or.inl hz))]

/-- The bowtie's colour on `H` is `2` (`H` misses `G`, `C`, `CN`, `CS`). -/
theorem bowtieCol_of_mem_H {z : ℂ} (hz : z ∈ bowtieH) : bowtieCol z = 2 := by
  obtain ⟨h1, h2, h3⟩ := hz
  have hsum := norm_sub_I_sq_add z
  have hG : z ∉ bowtieG := fun h => by nlinarith [h.1, norm_nonneg z, norm_nonneg (z - I), norm_nonneg (z + I)]
  have him : z.im < 0 := by
    have : |(z + I).im| < 1 := (Complex.abs_im_le_norm _).trans_lt h1
    simp only [Complex.add_im, Complex.I_im] at this
    linarith [(abs_lt.mp this).2]
  have hC : z ∉ bowtieC ∪ bowtieCN ∪ bowtieCS := by
    rintro ((h | h) | h)
    · linarith [h.2.2.2.2]
    · linarith [h.1, abs_nonneg z.re]
    · linarith [h.1, abs_nonneg z.re]
  unfold bowtieCol; rw [if_neg hG, if_neg hC, if_pos (show z ∈ bowtieH from ⟨h1, h2, h3⟩)]

/-- The bowtie's colours on the cusp's pieces at `r ≤ 1/13`: `1` on the horns, `0` on the upper disc's part, `2` on the lower's. -/
theorem bowtieCol_cuspPiece {r : ℝ} (hr : r ≤ 1 / 13) {z : ℂ} :
    (z ∈ cuspPiece r 0 → bowtieCol z = 1) ∧ (z ∈ cuspPiece r 1 → bowtieCol z = 1) ∧ (z ∈ cuspPiece r 2 → bowtieCol z = 0) ∧
      (z ∈ cuspPiece r 3 → bowtieCol z = 2) := by
  obtain ⟨h0, h1, h2, h3⟩ := cuspPiece_subset_bowtie hr
  exact ⟨fun h => bowtieCol_of_mem_C (h0 h), fun h => bowtieCol_of_mem_C (h1 h), fun h => bowtieCol_of_mem_G (h2 h),
    fun h => bowtieCol_of_mem_H (h3 h)⟩

/-- `B(0, 1/13)` lies in the bowtie's domain: off the two unit circles (a closed set with empty interior) its points lie in the cusp's
pieces, hence in the tiles. -/
theorem ball_subset_bowtie_dom : ball (0 : ℂ) (1 / 13) ⊆ bowtie.dom := by
  refine interior_maximal ?_ isOpen_ball
  have hint : interior (sphere I 1 ∪ sphere (-I) 1) = ∅ := by
    rw [interior_union_isClosed_of_interior_empty isClosed_sphere (interior_sphere _ one_ne_zero), interior_sphere _ one_ne_zero]
  have hd : Dense (sphere I 1 ∪ sphere (-I) 1)ᶜ := interior_eq_empty_iff_dense_compl.mp hint
  refine (hd.open_subset_closure_inter isOpen_ball).trans (closure_mono ?_)
  rintro z ⟨hz, hS⟩
  rw [mem_ball_zero_iff] at hz
  simp only [mem_compl_iff, mem_union, mem_sphere_iff_norm, sub_neg_eq_add, not_or] at hS
  have hI : z ∈ cuspFrag.interiorPts ∩ ball 0 (1 / 13) :=
    ⟨cuspFrag_mem_interiorPts.mpr ⟨by linarith, hS.1, hS.2⟩, mem_ball_zero_iff.mpr hz⟩
  rw [cuspFrag_partition (by norm_num), mem_iUnion] at hI
  obtain ⟨i, hi⟩ := hI
  obtain ⟨h0, h1, h2, h3⟩ := cuspPiece_subset_bowtie (r := 1 / 13) le_rfl
  simp only [bowtieTiles, mem_union]
  fin_cases i
  · exact Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inr (h0 hi)))))))))
  · exact Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inr (h1 hi)))))))))
  · exact Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (h2 hi))))))))))
  · exact Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inl (Or.inr (h3 hi))))))))))

/-- **The bowtie at `E`**: for `0 < r ≤ 1/13` its interior points in `B(0, r)` are the cusp's four pieces. -/
theorem bowtie_partition {r : ℝ} (hr : r ≤ 1 / 13) : bowtie.interiorPts ∩ ball 0 r = ⋃ i, cuspPiece r i := by
  rw [← cuspFrag_partition (by linarith : r ≤ 1 / 2)]
  ext z
  simp only [mem_inter_iff, mem_ball_zero_iff]
  constructor
  · rintro ⟨⟨-, hΓ⟩, hz⟩
    refine ⟨cuspFrag_mem_interiorPts.mpr ⟨by linarith, fun h => ?_, fun h => ?_⟩, hz⟩
    · exact hΓ ((mem_bowtieArcs_iff_of_norm_lt (by linarith)).mpr (Or.inl h))
    · exact hΓ ((mem_bowtieArcs_iff_of_norm_lt (by linarith)).mpr (Or.inr h))
  · rintro ⟨hI, hz⟩
    obtain ⟨-, h1, h2⟩ := cuspFrag_mem_interiorPts.mp hI
    refine ⟨⟨ball_subset_bowtie_dom (mem_ball_zero_iff.mpr (by linarith)), fun h => ?_⟩, hz⟩
    rcases (mem_bowtieArcs_iff_of_norm_lt (by linarith)).mp h with h | h
    exacts [h1 h, h2 h]

/-- The horn along `e π` at `0` with bounding curvatures `−1`, `1` is the cusp's left horn. -/
theorem hornSet_cusp_pi_eq (r : ℝ) : hornSet 0 π (-1) 1 r = cuspPiece r 1 := by
  ext z
  show _ ↔ z ∈ (fun z => -(starRingEnd ℂ z)) '' hornSet 0 0 (-1) 1 r
  rw [mem_cuspPiece_one]
  have hfx : frameX 0 π z = -z.re := by
    simp [frameX, e_eq, Real.cos_pi, Real.sin_pi]
  simp only [hornSet, tanAbove_neg_one_iff, tanBelow_one_iff, mem_setOf_eq, hfx, e_pi_add_pi_div_two, dist_eq_norm,
    sub_zero, zero_add, sub_neg_eq_add]
  constructor
  · rintro ⟨h1, h2, h3, h4⟩; exact ⟨h1, by linarith, h4, h3⟩
  · rintro ⟨h1, h2, h3, h4⟩; exact ⟨h1, by linarith, h4, h3⟩

/-- For `0 < r ≤ 1/13`, each of the cusp's pieces is a sector of the bowtie at `0`. -/
theorem bowtie_isSector_cuspPiece {r : ℝ} (hr0 : 0 < r) (hr : r ≤ 1 / 13) (i : Fin 4) :
    bowtie.IsSector 0 r (cuspPiece r i) := by
  obtain ⟨ho, hp, hd, hn, hc⟩ := cuspPiece_data hr0 (by linarith)
  exact (isSector_iff_of_partition (bowtie_partition hr) ho hp hd hn hc).mpr ⟨i, rfl⟩

/-- For `r ≤ 1/13`, the cusp's disc parts are inside the bowtie's classes `0` (upper) and `2` (lower). -/
theorem cuspPiece_subset_bowtie_region {r : ℝ} (hr : r ≤ 1 / 13) :
    cuspPiece r 2 ⊆ bowtie.region 0 ∧ cuspPiece r 3 ⊆ bowtie.region 2 := by
  have hU := bowtie_partition hr
  have hint : ∀ i, ∀ z ∈ cuspPiece r i, z ∈ bowtie.interiorPts := fun i z hz => by
    have : z ∈ bowtie.interiorPts ∩ ball 0 r := by rw [hU]; exact mem_iUnion.mpr ⟨i, hz⟩
    exact this.1
  exact ⟨fun z hz => ⟨hint 2 z hz, (bowtieCol_cuspPiece hr).2.2.1 hz⟩,
    fun z hz => ⟨hint 3 z hz, (bowtieCol_cuspPiece hr).2.2.2 hz⟩⟩

/-- **FS112-BOWTIE**: the fragment is valid (YB3: 21 of 21 same-colour tile pairs, exact). -/
theorem bowtie_valid : bowtie.Valid := by
  sorry

/-- `E = 0`, `N = i`, `S = −i` lie in the fragment's domain. -/
theorem bowtie_mem_dom : (0 : ℂ) ∈ bowtie.dom ∧ I ∈ bowtie.dom ∧ -I ∈ bowtie.dom := by
  sorry

/-- `E` carries three colours: `0` (`G`), `1` (the horns), `2` (`H`); the horn colour has two sectors. -/
theorem bowtie_coloursAt_zero : bowtie.coloursAt 0 = {0, 1, 2} ∧ bowtie.HasSectors 0 1 2 := by
  have h13 : (0 : ℝ) < 1 / 13 := by norm_num
  refine ⟨?_, ?_⟩
  · obtain ⟨-, -, -, -, hc⟩ := cuspPiece_data h13 (by norm_num)
    have hU := bowtie_partition (r := 1 / 13) le_rfl
    have hcol0 : ∀ z, z ∈ cuspPiece (1 / 13) 0 → bowtieCol z = 1 := fun z => (bowtieCol_cuspPiece (r := 1 / 13) le_rfl (z := z)).1
    have hcol1 : ∀ z, z ∈ cuspPiece (1 / 13) 1 → bowtieCol z = 1 := fun z => (bowtieCol_cuspPiece (r := 1 / 13) le_rfl (z := z)).2.1
    have hcol2 : ∀ z, z ∈ cuspPiece (1 / 13) 2 → bowtieCol z = 0 := fun z => (bowtieCol_cuspPiece (r := 1 / 13) le_rfl (z := z)).2.2.1
    have hcol3 : ∀ z, z ∈ cuspPiece (1 / 13) 3 → bowtieCol z = 2 := fun z => (bowtieCol_cuspPiece (r := 1 / 13) le_rfl (z := z)).2.2.2
    have hint : ∀ i, ∀ z ∈ cuspPiece (1 / 13) i, z ∈ bowtie.interiorPts := fun i z hz => by
      have : z ∈ bowtie.interiorPts ∩ ball 0 (1 / 13) := by rw [hU]; exact mem_iUnion.mpr ⟨i, hz⟩
      exact this.1
    ext j
    simp only [mem_insert_iff, mem_singleton_iff]
    constructor
    · intro hj
      obtain ⟨z, ⟨hzI, hzc⟩, hz⟩ := Metric.mem_closure_iff.mp hj (1 / 13) h13
      have hzc' : bowtieCol z = j := hzc
      have hzU : z ∈ bowtie.interiorPts ∩ ball 0 (1 / 13) := ⟨hzI, by rw [mem_ball, dist_comm]; exact hz⟩
      rw [hU, mem_iUnion] at hzU
      obtain ⟨i, hi⟩ := hzU
      fin_cases i
      · exact Or.inr (Or.inl (hzc'.symm.trans (hcol0 z hi)))
      · exact Or.inr (Or.inl (hzc'.symm.trans (hcol1 z hi)))
      · exact Or.inl (hzc'.symm.trans (hcol2 z hi))
      · exact Or.inr (Or.inr (hzc'.symm.trans (hcol3 z hi)))
    · rintro (rfl | rfl | rfl)
      · show (0 : ℂ) ∈ closure (bowtie.region 0)
        exact closure_mono (cuspPiece_subset_bowtie_region (r := 1 / 13) le_rfl).1 (hc 2)
      · show (0 : ℂ) ∈ closure (bowtie.region 1)
        exact closure_mono (show cuspPiece (1 / 13) 0 ⊆ bowtie.region 1 from fun z hz => ⟨hint 0 z hz, hcol0 z hz⟩) (hc 0)
      · show (0 : ℂ) ∈ closure (bowtie.region 2)
        exact closure_mono (cuspPiece_subset_bowtie_region (r := 1 / 13) le_rfl).2 (hc 3)
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    obtain ⟨ho, hp, hd, hn, hc⟩ := cuspPiece_data hr.1 (by linarith [hr.2])
    have hU := bowtie_partition hr.2
    have hcol0 : ∀ z, z ∈ cuspPiece r 0 → bowtieCol z = 1 := fun z => (bowtieCol_cuspPiece hr.2 (z := z)).1
    have hcol1 : ∀ z, z ∈ cuspPiece r 1 → bowtieCol z = 1 := fun z => (bowtieCol_cuspPiece hr.2 (z := z)).2.1
    have hcol2 : ∀ z, z ∈ cuspPiece r 2 → bowtieCol z = 0 := fun z => (bowtieCol_cuspPiece hr.2 (z := z)).2.2.1
    have hcol3 : ∀ z, z ∈ cuspPiece r 3 → bowtieCol z = 2 := fun z => (bowtieCol_cuspPiece hr.2 (z := z)).2.2.2
    have hsec : bowtie.sectorsOf 0 r 1 = {cuspPiece r 0, cuspPiece r 1} := by
      ext S
      simp only [ArcMap.sectorsOf, mem_setOf_eq, mem_insert_iff, mem_singleton_iff]
      rw [isSector_iff_of_partition hU ho hp hd hn hc]
      constructor
      · rintro ⟨⟨i, rfl⟩, hS⟩
        fin_cases i
        · exact Or.inl rfl
        · exact Or.inr rfl
        · exfalso
          obtain ⟨z, hz⟩ := hn 2
          have h1 : bowtieCol z = 1 := hS hz
          rw [hcol2 z hz] at h1
          exact absurd h1 (by decide)
        · exfalso
          obtain ⟨z, hz⟩ := hn 3
          have h1 : bowtieCol z = 1 := hS hz
          rw [hcol3 z hz] at h1
          exact absurd h1 (by decide)
      · rintro (rfl | rfl)
        · exact ⟨⟨0, rfl⟩, fun z hz => hcol0 z hz⟩
        · exact ⟨⟨1, rfl⟩, fun z hz => hcol1 z hz⟩
    rw [hsec, Set.encard_pair]
    · rfl
    · intro h
      obtain ⟨z, hz⟩ := hn 0
      exact Set.disjoint_left.mp (hd 0 1 (by decide)) hz (h ▸ hz)

/-- **The horns**: colour `1` along `±a` (`a = e 0`), each between `ω(S)` (curvature `−1` in its frame) and `ω(N)` (curvature `1`) —
bounded by unit arcs on both sides. -/
theorem bowtie_isHorn : bowtie.IsHorn 0 0 (-1) 1 1 ∧ bowtie.IsHorn 0 π (-1) 1 1 := by
  have h13 : (0 : ℝ) < 1 / 13 := by norm_num
  refine ⟨⟨by norm_num, ?_⟩, ⟨by norm_num, ?_⟩⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    exact ⟨bowtie_isSector_cuspPiece hr.1 hr.2 0, fun z hz => (bowtieCol_cuspPiece hr.2).1 hz⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    rw [hornSet_cusp_pi_eq]
    exact ⟨bowtie_isSector_cuspPiece hr.1 hr.2 1, fun z hz => (bowtieCol_cuspPiece hr.2).2.1 hz⟩

/-- The horns' flanks: `G` (colour `0`) above and `H` (colour `2`) below (in the frame along `π`, `H` above and `G` below). -/
theorem bowtie_flanks : bowtie.IsFlankAbove 0 0 1 0 ∧ bowtie.IsFlankBelow 0 0 (-1) 2 ∧
    bowtie.IsFlankAbove 0 π 1 2 ∧ bowtie.IsFlankBelow 0 π (-1) 0 := by
  have h13 : (0 : ℝ) < 1 / 13 := by norm_num
  have hN : e (0 + π / 2) = I := by rw [zero_add, e_pi_div_two]
  refine ⟨⟨2, by norm_num, ?_⟩, ⟨-2, by norm_num, ?_⟩, ⟨2, by norm_num, ?_⟩, ⟨-2, by norm_num, ?_⟩⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    rintro z ⟨h1, -, h3, -⟩
    rw [tanAbove_one_iff, hN, zero_add] at h3
    exact (cuspPiece_subset_bowtie_region hr.2).1 ⟨mem_ball.mpr h1, mem_ball.mpr h3⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    rintro z ⟨h1, -, -, h4⟩
    rw [tanBelow_neg_one_iff, hN, zero_sub] at h4
    exact (cuspPiece_subset_bowtie_region hr.2).2 ⟨mem_ball.mpr h1, mem_ball.mpr h4⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    rintro z ⟨h1, -, h3, -⟩
    rw [tanAbove_one_iff, e_pi_add_pi_div_two, zero_add] at h3
    exact (cuspPiece_subset_bowtie_region hr.2).2 ⟨mem_ball.mpr h1, mem_ball.mpr h3⟩
  · filter_upwards [Ioc_mem_nhdsGT h13] with r hr
    rintro z ⟨h1, -, -, h4⟩
    rw [tanBelow_neg_one_iff, e_pi_add_pi_div_two, zero_sub, neg_neg] at h4
    exact (cuspPiece_subset_bowtie_region hr.2).1 ⟨mem_ball.mpr h1, mem_ball.mpr h4⟩

/-- **Shadowed** by its flanks: each horn lies, near `E`, in the shadow of both flank colours. -/
theorem bowtie_doublyShadowed : bowtie.DoublyShadowed 0 0 (-1) 1 0 2 ∧ bowtie.DoublyShadowed 0 π (-1) 1 2 0 := by
  sorry

/-- The flank sectors are **in-type** radius-1 sectors at `N` and `S`: contacts of colours `0` at `N` and `2` at `S`, in-type. -/
theorem bowtie_inType : (bowtie.IsContact 0 0 I ∧ bowtie.InType 0 0 I) ∧ (bowtie.IsContact 0 2 (-I) ∧ bowtie.InType 0 2 (-I)) := by
  sorry

/-- **Both neighbours four-coloured, one sector per colour**: `P_cl(N) = {0, 1, 3, 4}`, `P_cl(S) = {2, 1, 3, 4}`. -/
theorem bowtie_neighbours : bowtie.coloursAt I = {0, 1, 3, 4} ∧ bowtie.coloursAt (-I) = {2, 1, 3, 4} ∧
    (∀ c ∈ bowtie.coloursAt I, bowtie.HasSectors I c 1) ∧ ∀ c ∈ bowtie.coloursAt (-I), bowtie.HasSectors (-I) c 1 := by
  sorry

/-- **A one-vertex stuck chain**: `E` is stuck, neither neighbour is. -/
theorem bowtie_isStuck : bowtie.IsStuck 0 ∧ ¬ bowtie.IsStuck I ∧ ¬ bowtie.IsStuck (-I) := by
  sorry

/-- **No MERGE, MERGE-RAY or SHAVE applies at `E`, `E ± n`.** -/
theorem bowtie_terminalOn : bowtie.TerminalOn {0, I, -I} := by
  sorry

/-- **Every unit arc's end is interior** to the fragment (the arcs' ends `(±5/13, ±1/13)` lie in its domain, with their
neighbourhoods coloured). -/
theorem bowtie_unitArcEnds : ∀ a ∈ bowtie.arcs, ∀ p θ₀ θ₁, a = .circ p 1 θ₀ θ₁ →
    p + e θ₀ ∈ bowtie.dom ∧ p + e θ₁ ∈ bowtie.dom := by
  sorry

/-- **FS112-FLANK**, its last clause, "SHAVE's criterion is incomplete there", witnessed by the bowtie: at `E = 0` neither flank colour
(`0` above the horns, `2` below) has an out-type contact at `N = i` or `S′ = −i` — so N4-FLANK's list of shadows (out-type flank tiles at
`S′` and `N` only) is empty and the criterion read from it would shave — and yet no SHAVE is available at `E`: the in-type sectors at
`N`, `S′` doubly shadow both horns (`bowtie_doublyShadowed`), whose bounds are `±1`. -/
theorem flank_incomplete_bowtie :
    (∀ j ∈ ({0, 2} : Set (Fin 6)), ∀ w ∈ ({I, -I} : Set ℂ), ¬ (bowtie.IsContact 0 j w ∧ bowtie.OutType 0 j w)) ∧
      ¬ bowtie.ShaveAvailable 0 := by
  sorry

end ArcMap

end HadwigerNelson.Plane
