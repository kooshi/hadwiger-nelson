import Proofs.HadwigerNelson.Plane.ValidMap.Basic
import Proofs.HadwigerNelson.Plane.SVMap
import Proofs.HadwigerNelson.Plane.LocalMapExamples
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc

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

/-! ### The bowtie's colour is locally constant (FS131-I4f): each tile's closure adds only boundary pieces -/

/-- A point `p + t (q − p)`, `t ∈ [0, 1]`, given by its coordinates, lies on the segment `[p, q]`. -/
theorem mem_segment_of_coords {p q z : ℂ} (t : ℝ) (ht0 : 0 ≤ t) (ht1 : t ≤ 1) (hre : z.re = p.re + t * (q.re - p.re))
    (him : z.im = p.im + t * (q.im - p.im)) : z ∈ segment ℝ p q := by
  refine ⟨1 - t, t, by linarith, ht0, by ring, ?_⟩
  apply Complex.ext
  · simp only [Complex.add_re, Complex.smul_re, smul_eq_mul, hre]; ring
  · simp only [Complex.add_im, Complex.smul_im, smul_eq_mul, him]; ring

/-- A segment of the bowtie's list carries the points `p + t (q − p)`, `t ∈ [0, 1]`. -/
theorem mem_bowtieArcs_seg {p q z : ℂ} (ha : Arc.seg p q ∈ bowtieArcs) (t : ℝ) (ht0 : 0 ≤ t) (ht1 : t ≤ 1)
    (hre : z.re = p.re + t * (q.re - p.re)) (him : z.im = p.im + t * (q.im - p.im)) :
    z ∈ ⋃ a ∈ bowtieArcs, a.carrier :=
  mem_iUnion₂.mpr ⟨_, ha, mem_segment_of_coords t ht0 ht1 hre him⟩

/-- A point of `ω(i)` below `i` with `|re z| ≤ 5/13` lies on the bowtie's arc of `ω(i)`. -/
theorem mem_bowtieArcN_of {z : ℂ} (h1 : ‖z - I‖ = 1) (hre : |z.re| ≤ 5 / 13) (him : z.im ≤ 1) :
    z ∈ ⋃ a ∈ bowtieArcs, a.carrier := by
  refine mem_iUnion₂.mpr ⟨Arc.circ I 1 (3 * π / 2 - bowtieAngle) (3 * π / 2 + bowtieAngle), by simp [bowtieArcs], ?_⟩
  have hsq : z.re ^ 2 + (z.im - 1) ^ 2 = 1 := by
    have h2 : ‖z - I‖ ^ 2 = 1 := by rw [h1]; norm_num
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply] at h2
    simp only [Complex.sub_re, Complex.sub_im, Complex.I_re, Complex.I_im, sub_zero] at h2
    nlinarith
  have hx1 : -1 ≤ z.re := by linarith [(abs_le.mp hre).1]
  have hx2 : z.re ≤ 1 := by linarith [(abs_le.mp hre).2]
  have hsin : Real.sin (Real.arcsin z.re) = z.re := Real.sin_arcsin hx1 hx2
  have hcos : Real.cos (Real.arcsin z.re) = 1 - z.im := by
    rw [Real.cos_arcsin, show 1 - z.re ^ 2 = (1 - z.im) ^ 2 by nlinarith]
    exact Real.sqrt_sq (by linarith)
  have hl : -bowtieAngle ≤ Real.arcsin z.re := by
    unfold bowtieAngle; rw [← Real.arcsin_neg]; exact Real.arcsin_le_arcsin (by linarith [(abs_le.mp hre).1])
  have hu : Real.arcsin z.re ≤ bowtieAngle := Real.arcsin_le_arcsin (by linarith [(abs_le.mp hre).2])
  refine ⟨3 * π / 2 + Real.arcsin z.re, ⟨by linarith, by linarith⟩, ?_⟩
  have h3 : 3 * π / 2 + Real.arcsin z.re = (Real.arcsin z.re - π / 2) + 2 * π := by ring
  apply Complex.ext
  · simp only [Complex.add_re, Complex.I_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, h3,
      Real.cos_add_two_pi, Real.sin_add_two_pi, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two, hsin]
    ring
  · simp only [Complex.add_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, h3,
      Real.cos_add_two_pi, Real.sin_add_two_pi, Real.cos_sub_pi_div_two, Real.sin_sub_pi_div_two, hcos]
    ring

/-- A point of `ω(−i)` above `−i` with `|re z| ≤ 5/13` lies on the bowtie's arc of `ω(−i)`. -/
theorem mem_bowtieArcS_of {z : ℂ} (h1 : ‖z + I‖ = 1) (hre : |z.re| ≤ 5 / 13) (him : -1 ≤ z.im) :
    z ∈ ⋃ a ∈ bowtieArcs, a.carrier := by
  refine mem_iUnion₂.mpr ⟨Arc.circ (-I) 1 (π / 2 - bowtieAngle) (π / 2 + bowtieAngle), by simp [bowtieArcs], ?_⟩
  have hsq : z.re ^ 2 + (z.im + 1) ^ 2 = 1 := by
    have h2 : ‖z + I‖ ^ 2 = 1 := by rw [h1]; norm_num
    rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply] at h2
    simp only [Complex.add_re, Complex.add_im, Complex.I_re, Complex.I_im, add_zero] at h2
    nlinarith
  have hx1 : -1 ≤ z.re := by linarith [(abs_le.mp hre).1]
  have hx2 : z.re ≤ 1 := by linarith [(abs_le.mp hre).2]
  have hsin : Real.sin (Real.arcsin z.re) = z.re := Real.sin_arcsin hx1 hx2
  have hcos : Real.cos (Real.arcsin z.re) = 1 + z.im := by
    rw [Real.cos_arcsin, show 1 - z.re ^ 2 = (1 + z.im) ^ 2 by nlinarith]
    exact Real.sqrt_sq (by linarith)
  have hl : -bowtieAngle ≤ Real.arcsin z.re := by
    unfold bowtieAngle; rw [← Real.arcsin_neg]; exact Real.arcsin_le_arcsin (by linarith [(abs_le.mp hre).1])
  have hu : Real.arcsin z.re ≤ bowtieAngle := Real.arcsin_le_arcsin (by linarith [(abs_le.mp hre).2])
  refine ⟨π / 2 - Real.arcsin z.re, ⟨by linarith, by linarith⟩, ?_⟩
  apply Complex.ext
  · simp only [Complex.add_re, Complex.neg_re, Complex.I_re, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, re_e,
      im_e, Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, hsin]
    ring
  · simp only [Complex.add_im, Complex.neg_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e,
      im_e, Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, hcos]
    ring

/-- `‖z − i‖² = re² + (im − 1)²`. -/
theorem norm_sub_I_sq (z : ℂ) : ‖z - I‖ ^ 2 = z.re ^ 2 + (z.im - 1) ^ 2 := by
  rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; simp; ring

/-- `‖z + i‖² = re² + (im + 1)²`. -/
theorem norm_add_I_sq (z : ℂ) : ‖z + I‖ ^ 2 = z.re ^ 2 + (z.im + 1) ^ 2 := by
  rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; simp; ring

/-- The closure of `G` adds only boundary pieces: its arc of `ω(i)` and its two edges through `i`. -/
theorem closure_bowtieG_subset : closure bowtieG ⊆ bowtieG ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hcl : closure bowtieG ⊆ {z : ℂ | ‖z - I‖ ≤ 1} ∩ {z | 12 * |z.re| ≤ 5 * (1 - z.im)} :=
    closure_minimal (fun z hz => ⟨hz.1.le, hz.2.2.le⟩)
      ((isClosed_le (by fun_prop) continuous_const).inter (isClosed_le (by fun_prop) (by fun_prop)))
  intro z hz
  obtain ⟨h1, h2⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2
  by_cases hG : z ∈ bowtieG
  · exact Or.inl hG
  right
  have hsq := norm_sub_I_sq z
  have hn := norm_nonneg (z - I)
  have ha := abs_nonneg z.re
  have hsa := sq_abs z.re
  have him : z.im ≤ 1 := by linarith
  have hre : |z.re| ≤ 5 / 13 := by nlinarith
  rcases h1.lt_or_eq with h1 | h1
  · have h2' : 12 * |z.re| = 5 * (1 - z.im) := by
      by_contra hne
      have h2s := lt_of_le_of_ne h2 hne
      exact hG ⟨h1, by linarith, h2s⟩
    rcases le_or_gt 0 z.re with hr | hr
    · rw [abs_of_nonneg hr] at h2' hre
      exact mem_bowtieArcs_seg (p := pt (5/13) (1/13)) (q := I) (by simp [bowtieArcs]) (1 - 13 * z.re / 5)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
    · rw [abs_of_neg hr] at h2' hre
      exact mem_bowtieArcs_seg (p := I) (q := pt (-5/13) (1/13)) (by simp [bowtieArcs]) (-13 * z.re / 5)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcN_of h1 hre him

/-- The closure of `H` adds only boundary pieces (the mirror of `G`). -/
theorem closure_bowtieH_subset : closure bowtieH ⊆ bowtieH ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hcl : closure bowtieH ⊆ {z : ℂ | ‖z + I‖ ≤ 1} ∩ {z | 12 * |z.re| ≤ 5 * (1 + z.im)} :=
    closure_minimal (fun z hz => ⟨hz.1.le, hz.2.2.le⟩)
      ((isClosed_le (by fun_prop) continuous_const).inter (isClosed_le (by fun_prop) (by fun_prop)))
  intro z hz
  obtain ⟨h1, h2⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2
  by_cases hH : z ∈ bowtieH
  · exact Or.inl hH
  right
  have hsq := norm_add_I_sq z
  have hn := norm_nonneg (z + I)
  have ha := abs_nonneg z.re
  have hsa := sq_abs z.re
  have him : -1 ≤ z.im := by linarith
  have hre : |z.re| ≤ 5 / 13 := by nlinarith
  rcases h1.lt_or_eq with h1 | h1
  · have h2' : 12 * |z.re| = 5 * (1 + z.im) := by
      by_contra hne
      have h2s := lt_of_le_of_ne h2 hne
      exact hH ⟨h1, by linarith, h2s⟩
    rcases le_or_gt 0 z.re with hr | hr
    · rw [abs_of_nonneg hr] at h2' hre
      exact mem_bowtieArcs_seg (p := -I) (q := pt (5/13) (-1/13)) (by simp [bowtieArcs]) (13 * z.re / 5)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
    · rw [abs_of_neg hr] at h2' hre
      exact mem_bowtieArcs_seg (p := pt (-5/13) (-1/13)) (q := -I) (by simp [bowtieArcs]) (1 + 13 * z.re / 5)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcS_of h1 hre him


/-- The closure of `C` adds only boundary pieces: the arcs of `ω(±i)` and the closing segments at `re = ±5/13`. -/
theorem closure_bowtieC_subset : closure bowtieC ⊆ bowtieC ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hcl : closure bowtieC ⊆ {z : ℂ | |z.re| ≤ 5 / 13} ∩ {z | |z.im| ≤ 1 / 13} ∩ {z | 1 ≤ ‖z - I‖} ∩ {z | 1 ≤ ‖z + I‖} :=
    closure_minimal (fun z hz => ⟨⟨⟨hz.2.1.le, hz.2.2.1.le⟩, hz.2.2.2.1.le⟩, hz.2.2.2.2.le⟩)
      ((((isClosed_le (by fun_prop) continuous_const).inter (isClosed_le (by fun_prop) continuous_const)).inter
        (isClosed_le continuous_const (by fun_prop))).inter (isClosed_le continuous_const (by fun_prop)))
  intro z hz
  obtain ⟨⟨⟨h1, h2⟩, h3⟩, h4⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2 h3 h4
  by_cases hC : z ∈ bowtieC
  · exact Or.inl hC
  right
  have h2' := abs_le.mp h2
  rcases h3.lt_or_eq with h3 | h3
  swap
  · exact mem_bowtieArcN_of h3.symm h1 (by linarith)
  rcases h4.lt_or_eq with h4 | h4
  swap
  · exact mem_bowtieArcS_of h4.symm h1 (by linarith)
  have hsN := norm_sub_I_sq z
  have hsS := norm_add_I_sq z
  have hsa := sq_abs z.re
  rcases h1.lt_or_eq with h1 | h1
  · exfalso
    have him : |z.im| < 1 / 13 := by
      rcases h2.lt_or_eq with h | h
      · exact h
      · exfalso
        rcases abs_eq (by norm_num : (0:ℝ) ≤ 1 / 13) |>.mp h with h' | h'
        · rw [h'] at hsN; nlinarith [abs_nonneg z.re]
        · rw [h'] at hsS; nlinarith [abs_nonneg z.re]
    have hre : z.re ≠ 0 := by
      intro h0
      rw [h0] at hsN hsS
      have him' := abs_lt.mp him
      have e3 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h3
      have e4 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h4
      nlinarith
    exact hC ⟨hre, h1, him, h3, h4⟩
  · rcases abs_eq (by norm_num : (0:ℝ) ≤ 5 / 13) |>.mp h1 with h' | h'
    · exact mem_bowtieArcs_seg (p := pt (5/13) (1/13)) (q := pt (5/13) (-1/13)) (by simp [bowtieArcs])
        ((1 / 13 - z.im) * 13 / 2) (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)
    · exact mem_bowtieArcs_seg (p := pt (-5/13) (-1/13)) (q := pt (-5/13) (1/13)) (by simp [bowtieArcs])
        ((z.im + 1 / 13) * 13 / 2) (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)

/-- The closure of `CN` adds only its three edges. -/
theorem closure_bowtieCN_subset : closure bowtieCN ⊆ bowtieCN ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hcl : closure bowtieCN ⊆ {z : ℂ | |z.re| ≤ z.im - 1} ∩ {z | z.im ≤ 7 / 5} :=
    closure_minimal (fun z hz => ⟨hz.1.le, hz.2.le⟩)
      ((isClosed_le (by fun_prop) (by fun_prop)).inter (isClosed_le (by fun_prop) continuous_const))
  intro z hz
  obtain ⟨h1, h2⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2
  by_cases hC : z ∈ bowtieCN
  · exact Or.inl hC
  right
  have ha := abs_nonneg z.re
  rcases h2.lt_or_eq with h2 | h2
  · have h1' : |z.re| = z.im - 1 := by
      by_contra hne; exact hC ⟨lt_of_le_of_ne h1 hne, h2⟩
    rcases le_or_gt 0 z.re with hr | hr
    · rw [abs_of_nonneg hr] at h1'
      exact mem_bowtieArcs_seg (p := I) (q := pt (2/5) (7/5)) (by simp [bowtieArcs]) (5 / 2 * z.re)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
    · rw [abs_of_neg hr] at h1'
      exact mem_bowtieArcs_seg (p := pt (-2/5) (7/5)) (q := I) (by simp [bowtieArcs]) (1 + 5 / 2 * z.re)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · have h1' := abs_le.mp (show |z.re| ≤ 2 / 5 by linarith)
    exact mem_bowtieArcs_seg (p := pt (2/5) (7/5)) (q := pt (-2/5) (7/5)) (by simp [bowtieArcs]) ((2 / 5 - z.re) * 5 / 4)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)

/-- The closure of `CS` adds only its three edges. -/
theorem closure_bowtieCS_subset : closure bowtieCS ⊆ bowtieCS ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hcl : closure bowtieCS ⊆ {z : ℂ | |z.re| ≤ -1 - z.im} ∩ {z | -7 / 5 ≤ z.im} :=
    closure_minimal (fun z hz => ⟨hz.1.le, hz.2.le⟩)
      ((isClosed_le (by fun_prop) (by fun_prop)).inter (isClosed_le continuous_const (by fun_prop)))
  intro z hz
  obtain ⟨h1, h2⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2
  by_cases hC : z ∈ bowtieCS
  · exact Or.inl hC
  right
  have ha := abs_nonneg z.re
  rcases h2.lt_or_eq with h2 | h2
  · have h1' : |z.re| = -1 - z.im := by
      by_contra hne; exact hC ⟨lt_of_le_of_ne h1 hne, h2⟩
    rcases le_or_gt 0 z.re with hr | hr
    · rw [abs_of_nonneg hr] at h1'
      exact mem_bowtieArcs_seg (p := pt (2/5) (-7/5)) (q := -I) (by simp [bowtieArcs]) (1 - 5 / 2 * z.re)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
    · rw [abs_of_neg hr] at h1'
      exact mem_bowtieArcs_seg (p := -I) (q := pt (-2/5) (-7/5)) (by simp [bowtieArcs]) (-5 / 2 * z.re)
        (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · have h1' := abs_le.mp (show |z.re| ≤ 2 / 5 by linarith)
    exact mem_bowtieArcs_seg (p := pt (-2/5) (-7/5)) (q := pt (2/5) (-7/5)) (by simp [bowtieArcs]) ((z.re + 2 / 5) * 5 / 4)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)


/-- A point of the closure of `X σ` outside it lies on one of the four edges, in the coordinate `u = σ re`. -/
theorem bowtieX_closure_cases (σ : ℝ) {z : ℂ} (hz : z ∈ closure (bowtieX σ)) (hX : z ∉ bowtieX σ) :
    (12 * (σ * z.re) + 5 * (z.im - 1) = 0 ∧ 0 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 13) ∨
      (z.im - 1 = σ * z.re ∧ 0 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 5) ∨ (σ * z.re = 2 / 5 ∧ 41 / 65 ≤ z.im ∧ z.im ≤ 7 / 5) ∨
      (z.im = 41 / 65 ∧ 2 / 13 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 5) := by
  have hcl : closure (bowtieX σ) ⊆ {z : ℂ | 0 ≤ 12 * (σ * z.re) + 5 * (z.im - 1)} ∩ {z | z.im - 1 ≤ σ * z.re} ∩
      {z | σ * z.re ≤ 2 / 5} ∩ {z | 41 / 65 ≤ z.im} :=
    closure_minimal (fun z hz => ⟨⟨⟨hz.1.le, hz.2.1.le⟩, hz.2.2.1.le⟩, hz.2.2.2.le⟩)
      ((((isClosed_le continuous_const (by fun_prop)).inter (isClosed_le (by fun_prop) (by fun_prop))).inter
        (isClosed_le (by fun_prop) continuous_const)).inter (isClosed_le continuous_const (by fun_prop)))
  obtain ⟨⟨⟨h1, h2⟩, h3⟩, h4⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2 h3 h4
  rcases h1.lt_or_eq with h1 | h1
  · rcases h2.lt_or_eq with h2 | h2
    · rcases h3.lt_or_eq with h3 | h3
      · rcases h4.lt_or_eq with h4 | h4
        · exact absurd ⟨h1, h2, h3, h4⟩ hX
        · right; right; right; exact ⟨h4.symm, by linarith, h3.le⟩
      · right; right; left; exact ⟨h3, h4, by linarith⟩
    · right; left; exact ⟨h2, by linarith, h3⟩
  · left; exact ⟨h1.symm, by linarith, by linarith⟩

/-- A point of the closure of `Y σ` outside it lies on one of the four edges, in the coordinate `u = σ re`. -/
theorem bowtieY_closure_cases (σ : ℝ) {z : ℂ} (hz : z ∈ closure (bowtieY σ)) (hY : z ∉ bowtieY σ) :
    (12 * (σ * z.re) - 5 * (z.im + 1) = 0 ∧ 0 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 13) ∨
      (-z.im - 1 = σ * z.re ∧ 0 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 5) ∨ (σ * z.re = 2 / 5 ∧ -7 / 5 ≤ z.im ∧ z.im ≤ -41 / 65) ∨
      (z.im = -41 / 65 ∧ 2 / 13 ≤ σ * z.re ∧ σ * z.re ≤ 2 / 5) := by
  have hcl : closure (bowtieY σ) ⊆ {z : ℂ | 0 ≤ 12 * (σ * z.re) - 5 * (z.im + 1)} ∩ {z | -z.im - 1 ≤ σ * z.re} ∩
      {z | σ * z.re ≤ 2 / 5} ∩ {z | z.im ≤ -41 / 65} :=
    closure_minimal (fun z hz => ⟨⟨⟨hz.1.le, hz.2.1.le⟩, hz.2.2.1.le⟩, hz.2.2.2.le⟩)
      ((((isClosed_le continuous_const (by fun_prop)).inter (isClosed_le (by fun_prop) (by fun_prop))).inter
        (isClosed_le (by fun_prop) continuous_const)).inter (isClosed_le (by fun_prop) continuous_const))
  obtain ⟨⟨⟨h1, h2⟩, h3⟩, h4⟩ := hcl hz
  simp only [mem_setOf_eq] at h1 h2 h3 h4
  rcases h1.lt_or_eq with h1 | h1
  · rcases h2.lt_or_eq with h2 | h2
    · rcases h3.lt_or_eq with h3 | h3
      · rcases h4.lt_or_eq with h4 | h4
        · exact absurd ⟨h1, h2, h3, h4⟩ hY
        · right; right; right; exact ⟨h4, by linarith, h3.le⟩
      · right; right; left; exact ⟨h3, by linarith, h4⟩
    · right; left; exact ⟨h2, by linarith, h3⟩
  · left; exact ⟨h1.symm, by linarith, by linarith⟩

/-- The closure of `XR` adds only its four edges. -/
theorem closure_bowtieX_one_subset : closure (bowtieX 1) ⊆ bowtieX 1 ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  intro z hz
  by_cases hX : z ∈ bowtieX 1
  · exact Or.inl hX
  right
  rcases bowtieX_closure_cases 1 hz hX with ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ <;>
    simp only [one_mul] at h1 h2 h3
  · exact mem_bowtieArcs_seg (p := pt (5/13) (1/13)) (q := I) (by simp [bowtieArcs]) (1 - 13 * z.re / 5)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := I) (q := pt (2/5) (7/5)) (by simp [bowtieArcs]) (5 / 2 * z.re)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (2/5) (41/65)) (q := pt (2/5) (7/5)) (by simp [bowtieArcs]) ((z.im - 41 / 65) * 65 / 50)
      (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)
  · exact mem_bowtieArcs_seg (p := pt (2/13) (41/65)) (q := pt (2/5) (41/65)) (by simp [bowtieArcs]) ((z.re - 2 / 13) * 65 / 16)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)

/-- The closure of `XL` adds only its four edges. -/
theorem closure_bowtieX_neg_one_subset : closure (bowtieX (-1)) ⊆ bowtieX (-1) ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  intro z hz
  by_cases hX : z ∈ bowtieX (-1)
  · exact Or.inl hX
  right
  rcases bowtieX_closure_cases (-1) hz hX with ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ <;>
    simp only [neg_one_mul] at h1 h2 h3
  · exact mem_bowtieArcs_seg (p := I) (q := pt (-5/13) (1/13)) (by simp [bowtieArcs]) (-13 * z.re / 5)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (-2/5) (7/5)) (q := I) (by simp [bowtieArcs]) (1 + 5 / 2 * z.re)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (-2/5) (41/65)) (q := pt (-2/5) (7/5)) (by simp [bowtieArcs]) ((z.im - 41 / 65) * 65 / 50)
      (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)
  · exact mem_bowtieArcs_seg (p := pt (-2/13) (41/65)) (q := pt (-2/5) (41/65)) (by simp [bowtieArcs]) ((-z.re - 2 / 13) * 65 / 16)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)

/-- The closure of `YR` adds only its four edges. -/
theorem closure_bowtieY_one_subset : closure (bowtieY 1) ⊆ bowtieY 1 ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  intro z hz
  by_cases hY : z ∈ bowtieY 1
  · exact Or.inl hY
  right
  rcases bowtieY_closure_cases 1 hz hY with ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ <;>
    simp only [one_mul] at h1 h2 h3
  · exact mem_bowtieArcs_seg (p := -I) (q := pt (5/13) (-1/13)) (by simp [bowtieArcs]) (13 * z.re / 5)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (2/5) (-7/5)) (q := -I) (by simp [bowtieArcs]) (1 - 5 / 2 * z.re)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (2/5) (-41/65)) (q := pt (2/5) (-7/5)) (by simp [bowtieArcs]) ((-41 / 65 - z.im) * 65 / 50)
      (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)
  · exact mem_bowtieArcs_seg (p := pt (2/13) (-41/65)) (q := pt (2/5) (-41/65)) (by simp [bowtieArcs]) ((z.re - 2 / 13) * 65 / 16)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)

/-- The closure of `YL` adds only its four edges. -/
theorem closure_bowtieY_neg_one_subset : closure (bowtieY (-1)) ⊆ bowtieY (-1) ∪ ⋃ a ∈ bowtieArcs, a.carrier := by
  intro z hz
  by_cases hY : z ∈ bowtieY (-1)
  · exact Or.inl hY
  right
  rcases bowtieY_closure_cases (-1) hz hY with ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ | ⟨h1, h2, h3⟩ <;>
    simp only [neg_one_mul] at h1 h2 h3
  · exact mem_bowtieArcs_seg (p := pt (-5/13) (-1/13)) (q := -I) (by simp [bowtieArcs]) (1 + 13 * z.re / 5)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := -I) (q := pt (-2/5) (-7/5)) (by simp [bowtieArcs]) (-5 / 2 * z.re)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)
  · exact mem_bowtieArcs_seg (p := pt (-2/5) (-41/65)) (q := pt (-2/5) (-7/5)) (by simp [bowtieArcs]) ((-41 / 65 - z.im) * 65 / 50)
      (by linarith) (by linarith) (by simp [pt]; linarith) (by simp [pt]; ring)
  · exact mem_bowtieArcs_seg (p := pt (-2/13) (-41/65)) (q := pt (-2/5) (-41/65)) (by simp [bowtieArcs]) ((-z.re - 2 / 13) * 65 / 16)
      (by linarith) (by linarith) (by simp [pt]; ring) (by simp [pt]; linarith)

/-- Membership in an open set is eventually constant near a point off `A`, when the set's closure adds only points of `A`. -/
theorem eventually_mem_iff_of_closure_subset {U A : Set ℂ} (hU : IsOpen U) (h : closure U ⊆ U ∪ A) {x : ℂ} (hx : x ∉ A) :
    ∀ᶠ y in 𝓝 x, (y ∈ U ↔ x ∈ U) := by
  by_cases hxU : x ∈ U
  · filter_upwards [hU.mem_nhds hxU] with y hy
    exact iff_of_true hy hxU
  · have hc : x ∉ closure U := fun hc => (h hc).elim hxU hx
    filter_upwards [isClosed_closure.isOpen_compl.mem_nhds hc] with y hy
    exact iff_of_false (fun h' => hy (subset_closure h')) hxU

/-- The bowtie's colour depends only on membership in its nine tiles `G`, `C`, `CN`, `CS`, `H`, `X±`, `Y±`. -/
theorem bowtieCol_eq_of_iff {x y : ℂ} (hG : y ∈ bowtieG ↔ x ∈ bowtieG) (hC : y ∈ bowtieC ↔ x ∈ bowtieC)
    (hCN : y ∈ bowtieCN ↔ x ∈ bowtieCN) (hCS : y ∈ bowtieCS ↔ x ∈ bowtieCS) (hH : y ∈ bowtieH ↔ x ∈ bowtieH)
    (hX1 : y ∈ bowtieX 1 ↔ x ∈ bowtieX 1) (hY1 : y ∈ bowtieY 1 ↔ x ∈ bowtieY 1)
    (hX2 : y ∈ bowtieX (-1) ↔ x ∈ bowtieX (-1)) (hY2 : y ∈ bowtieY (-1) ↔ x ∈ bowtieY (-1)) :
    bowtieCol y = bowtieCol x := by
  classical
  unfold bowtieCol
  simp only [mem_union, hG, hC, hCN, hCS, hH, hX1, hY1, hX2, hY2]

/-- `G` is open. -/
theorem isOpen_bowtieG : IsOpen bowtieG := by
  unfold bowtieG
  refine (isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_)) <;> fun_prop

/-- `H` is open. -/
theorem isOpen_bowtieH : IsOpen bowtieH := by
  unfold bowtieH
  refine (isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_)) <;> fun_prop

/-- `C` is open. -/
theorem isOpen_bowtieC : IsOpen bowtieC := by
  unfold bowtieC
  refine (isOpen_ne_fun ?_ ?_).and ((isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and
    (isOpen_lt ?_ ?_)))) <;> fun_prop

/-- `CN` is open. -/
theorem isOpen_bowtieCN : IsOpen bowtieCN := by
  unfold bowtieCN
  refine (isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_) <;> fun_prop

/-- `CS` is open. -/
theorem isOpen_bowtieCS : IsOpen bowtieCS := by
  unfold bowtieCS
  refine (isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_) <;> fun_prop

/-- `X σ` is open. -/
theorem isOpen_bowtieX (σ : ℝ) : IsOpen (bowtieX σ) := by
  unfold bowtieX
  refine (isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_))) <;> fun_prop

/-- `Y σ` is open. -/
theorem isOpen_bowtieY (σ : ℝ) : IsOpen (bowtieY σ) := by
  unfold bowtieY
  refine (isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and ((isOpen_lt ?_ ?_).and (isOpen_lt ?_ ?_))) <;> fun_prop

/-- The bowtie's colour is locally constant off its boundary pieces, inside its domain. -/
theorem bowtieCol_locallyConstant : ∀ x ∈ interior (closure bowtieTiles), x ∉ ⋃ a ∈ bowtieArcs, a.carrier →
    ∀ᶠ y in 𝓝 x, bowtieCol y = bowtieCol x := by
  intro x _ hx
  filter_upwards [eventually_mem_iff_of_closure_subset isOpen_bowtieG closure_bowtieG_subset hx,
    eventually_mem_iff_of_closure_subset isOpen_bowtieC closure_bowtieC_subset hx,
    eventually_mem_iff_of_closure_subset isOpen_bowtieCN closure_bowtieCN_subset hx,
    eventually_mem_iff_of_closure_subset isOpen_bowtieCS closure_bowtieCS_subset hx,
    eventually_mem_iff_of_closure_subset isOpen_bowtieH closure_bowtieH_subset hx,
    eventually_mem_iff_of_closure_subset (isOpen_bowtieX 1) closure_bowtieX_one_subset hx,
    eventually_mem_iff_of_closure_subset (isOpen_bowtieY 1) closure_bowtieY_one_subset hx,
    eventually_mem_iff_of_closure_subset (isOpen_bowtieX (-1)) closure_bowtieX_neg_one_subset hx,
    eventually_mem_iff_of_closure_subset (isOpen_bowtieY (-1)) closure_bowtieY_neg_one_subset hx]
    with y h1 h2 h3 h4 h5 h6 h7 h8 h9
  exact bowtieCol_eq_of_iff h1 h2 h3 h4 h5 h6 h7 h8 h9

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

/-- A line `a·re + b·im = c` (`(a, b) ≠ 0`) has empty interior: moving off it along `(a, b)` changes the left side. -/
theorem interior_line_eq_empty {a b c : ℝ} (h : a ≠ 0 ∨ b ≠ 0) : interior {z : ℂ | a * z.re + b * z.im = c} = ∅ := by
  rw [Set.eq_empty_iff_forall_notMem]
  intro z hz
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp isOpen_interior z hz
  have hab : 0 < a ^ 2 + b ^ 2 := by rcases h with h | h <;> positivity
  set t : ℝ := ε / (2 * (|a| + |b| + 1)) with ht
  have hd : 0 < 2 * (|a| + |b| + 1) := by positivity
  have ht0 : 0 < t := div_pos hε hd
  set w : ℂ := z + (t : ℂ) * ((a : ℂ) + (b : ℂ) * I) with hw
  have hwb : w ∈ ball z ε := by
    rw [mem_ball, dist_eq_norm, hw, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
    have h1 : ‖(a : ℂ) + (b : ℂ) * I‖ ≤ |a| + |b| := by
      refine (norm_add_le _ _).trans ?_
      rw [norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs, Real.norm_eq_abs]
    have h2 : t * (|a| + |b|) < ε := by
      rw [ht, div_mul_eq_mul_div, div_lt_iff₀ hd]; nlinarith [abs_nonneg a, abs_nonneg b]
    calc t * ‖(a : ℂ) + (b : ℂ) * I‖ ≤ t * (|a| + |b|) := mul_le_mul_of_nonneg_left h1 ht0.le
      _ < ε := h2
  have h1 : a * w.re + b * w.im = c := (interior_subset (hball hwb) : w ∈ {z : ℂ | a * z.re + b * z.im = c})
  have h0 : a * z.re + b * z.im = c := (interior_subset hz : z ∈ {z : ℂ | a * z.re + b * z.im = c})
  have hre : w.re = z.re + t * a := by simp [hw]
  have him : w.im = z.im + t * b := by simp [hw]
  rw [hre, him] at h1
  nlinarith [mul_pos ht0 hab]

/-- A line `a·re + b·im = c` is closed. -/
theorem isClosed_line (a b c : ℝ) : IsClosed {z : ℂ | a * z.re + b * z.im = c} :=
  isClosed_eq (by fun_prop) continuous_const

/-- Four lines (each `(aᵢ, bᵢ) ≠ 0`) have a union with empty interior, so its complement is dense. -/
theorem dense_compl_four_lines {a₁ b₁ c₁ a₂ b₂ c₂ a₃ b₃ c₃ a₄ b₄ c₄ : ℝ} (h₁ : a₁ ≠ 0 ∨ b₁ ≠ 0) (h₂ : a₂ ≠ 0 ∨ b₂ ≠ 0)
    (h₃ : a₃ ≠ 0 ∨ b₃ ≠ 0) (h₄ : a₄ ≠ 0 ∨ b₄ ≠ 0) :
    Dense ({z : ℂ | a₁ * z.re + b₁ * z.im = c₁} ∪ {z | a₂ * z.re + b₂ * z.im = c₂} ∪ {z | a₃ * z.re + b₃ * z.im = c₃} ∪
      {z | a₄ * z.re + b₄ * z.im = c₄})ᶜ := by
  rw [← interior_eq_empty_iff_dense_compl,
    interior_union_isClosed_of_interior_empty (((isClosed_line _ _ _).union (isClosed_line _ _ _)).union (isClosed_line _ _ _))
      (interior_line_eq_empty h₄),
    interior_union_isClosed_of_interior_empty ((isClosed_line _ _ _).union (isClosed_line _ _ _)) (interior_line_eq_empty h₃),
    interior_union_isClosed_of_interior_empty (isClosed_line _ _ _) (interior_line_eq_empty h₂), interior_line_eq_empty h₁]

/-- Each tile of the bowtie lies in the union of its tiles. -/
theorem subset_bowtieTiles :
    bowtieG ⊆ bowtieTiles ∧ bowtieH ⊆ bowtieTiles ∧ bowtieCN ⊆ bowtieTiles ∧ bowtieCS ⊆ bowtieTiles ∧ bowtieX 1 ⊆ bowtieTiles ∧
      bowtieX (-1) ⊆ bowtieTiles ∧ bowtieY 1 ⊆ bowtieTiles ∧ bowtieY (-1) ⊆ bowtieTiles := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩ <;> intro z hz <;> simp only [bowtieTiles, mem_union] <;> tauto

/-- Near `N = i`, off the four edge lines through `i` (`12x ± 5(y − 1) = 0`... as `±12x + 5y = 5`, and `y − 1 = ±x`), the bowtie's tiles
`G`, `CN`, `XR`, `XL` cover `B(i, 1/10)`. -/
theorem ball_I_subset_closure_bowtieTiles : ball I (1 / 10) ⊆ closure bowtieTiles := by
  have hd := dense_compl_four_lines (a₁ := 12) (b₁ := 5) (c₁ := 5) (a₂ := -12) (b₂ := 5) (c₂ := 5) (a₃ := 1) (b₃ := -1) (c₃ := -1)
    (a₄ := 1) (b₄ := 1) (c₄ := 1) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
  refine (hd.open_subset_closure_inter isOpen_ball).trans (closure_mono ?_)
  rintro z ⟨hz, hL⟩
  simp only [mem_compl_iff, mem_union, mem_setOf_eq, not_or] at hL
  obtain ⟨⟨⟨l1, l2⟩, l3⟩, l4⟩ := hL
  rw [mem_ball, dist_eq_norm] at hz
  have hx : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z - I); simp only [Complex.sub_re, Complex.I_re, sub_zero] at this; linarith
  have hy : |z.im - 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z - I); simp only [Complex.sub_im, Complex.I_im] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  obtain ⟨tG, -, tCN, -, tXR, tXL, -, -⟩ := subset_bowtieTiles
  by_cases hG : 12 * |z.re| < 5 * (1 - z.im)
  · exact tG ⟨by linarith, by linarith [abs_nonneg z.re], hG⟩
  by_cases hC : |z.re| < z.im - 1
  · exact tCN ⟨hC, by linarith⟩
  push Not at hG hC
  have l1' : 12 * z.re + 5 * z.im ≠ 5 := l1
  have l2' : -12 * z.re + 5 * z.im ≠ 5 := l2
  have l3' : 1 * z.re + -1 * z.im ≠ -1 := l3
  have l4' : 1 * z.re + 1 * z.im ≠ 1 := l4
  rcases lt_trichotomy z.re 0 with h | h | h
  · rw [abs_of_neg h] at hG hC
    refine tXL ⟨?_, ?_, by linarith, by linarith⟩
    · rcases lt_or_gt_of_ne l2' with h' | h'
      · exfalso; linarith
      · linarith
    · rcases lt_or_gt_of_ne l4' with h' | h'
      · linarith
      · exfalso; linarith
  · exfalso
    rw [h, abs_zero] at hG hC
    apply l1'; rw [h]; linarith
  · rw [abs_of_pos h] at hG hC
    refine tXR ⟨?_, ?_, by linarith, by linarith⟩
    · rcases lt_or_gt_of_ne l1' with h' | h'
      · exfalso; linarith
      · linarith
    · rcases lt_or_gt_of_ne l3' with h' | h'
      · exfalso; linarith
      · linarith

/-- Near `S′ = −i`, the mirror: `H`, `CS`, `YR`, `YL` cover `B(−i, 1/10)` off the four edge lines through `−i`. -/
theorem ball_negI_subset_closure_bowtieTiles : ball (-I) (1 / 10) ⊆ closure bowtieTiles := by
  have hd := dense_compl_four_lines (a₁ := 12) (b₁ := -5) (c₁ := 5) (a₂ := 12) (b₂ := 5) (c₂ := -5) (a₃ := 1) (b₃ := 1) (c₃ := -1)
    (a₄ := 1) (b₄ := -1) (c₄ := 1) (by norm_num) (by norm_num) (by norm_num) (by norm_num)
  refine (hd.open_subset_closure_inter isOpen_ball).trans (closure_mono ?_)
  rintro z ⟨hz, hL⟩
  simp only [mem_compl_iff, mem_union, mem_setOf_eq, not_or] at hL
  obtain ⟨⟨⟨l1, l2⟩, l3⟩, l4⟩ := hL
  rw [mem_ball, dist_eq_norm, sub_neg_eq_add] at hz
  have hx : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z + I); simp only [Complex.add_re, Complex.I_re, add_zero] at this; linarith
  have hy : |z.im + 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z + I); simp only [Complex.add_im, Complex.I_im] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  have hzI : ‖z + I‖ < 1 := by linarith
  obtain ⟨-, tH, -, tCS, -, -, tYR, tYL⟩ := subset_bowtieTiles
  by_cases hH : 12 * |z.re| < 5 * (1 + z.im)
  · exact tH ⟨hzI, by linarith [abs_nonneg z.re], hH⟩
  by_cases hC : |z.re| < -1 - z.im
  · exact tCS ⟨hC, by linarith⟩
  push Not at hH hC
  have l1' : 12 * z.re + -5 * z.im ≠ 5 := l1
  have l2' : 12 * z.re + 5 * z.im ≠ -5 := l2
  have l3' : 1 * z.re + 1 * z.im ≠ -1 := l3
  have l4' : 1 * z.re + -1 * z.im ≠ 1 := l4
  rcases lt_trichotomy z.re 0 with h | h | h
  · rw [abs_of_neg h] at hH hC
    refine tYL ⟨?_, ?_, by linarith, by linarith⟩
    · rcases lt_or_gt_of_ne l2' with h' | h'
      · linarith
      · exfalso; linarith
    · rcases lt_or_gt_of_ne l4' with h' | h'
      · linarith
      · exfalso; linarith
  · exfalso
    rw [h, abs_zero] at hH hC
    apply l1'; rw [h]; linarith
  · rw [abs_of_pos h] at hH hC
    refine tYR ⟨?_, ?_, by linarith, by linarith⟩
    · rcases lt_or_gt_of_ne l1' with h' | h'
      · exfalso; linarith
      · linarith
    · rcases lt_or_gt_of_ne l3' with h' | h'
      · exfalso; linarith
      · linarith

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

/-! ### The bowtie is valid (FS131-I4f): YB3's same-colour pairs, by colour class -/

/-- `dist x y = 1` in coordinates. -/
theorem sq_coords_of_dist_eq_one {x y : ℂ} (h : dist x y = 1) : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 = 1 := by
  rw [Complex.dist_eq_re_im] at h
  have h0 : 0 ≤ (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by positivity
  have := Real.sq_sqrt h0
  rw [h] at this; linarith

/-- Two points of the sector `G` are less than `1` apart: its half-angle `arcsin (5/13)` is below `30°`. -/
theorem dist_lt_one_of_mem_bowtieG {x y : ℂ} (hx : x ∈ bowtieG) (hy : y ∈ bowtieG) : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 := by
  obtain ⟨hx1, -, hx3⟩ := hx
  obtain ⟨hy1, -, hy3⟩ := hy
  have nx := norm_sub_I_sq x
  have ny := norm_sub_I_sq y
  have ex : ‖x - I‖ ^ 2 < 1 := by nlinarith [norm_nonneg (x - I)]
  have ey : ‖y - I‖ ^ 2 < 1 := by nlinarith [norm_nonneg (y - I)]
  set p := 1 - x.im with hp
  set q := 1 - y.im with hq
  have hp0 : 0 < p := by linarith [abs_nonneg x.re]
  have hq0 : 0 < q := by linarith [abs_nonneg y.re]
  have hax : x.re ^ 2 * 144 < 25 * p ^ 2 := by
    have : (12 * |x.re|) ^ 2 < (5 * p) ^ 2 := by
      apply pow_lt_pow_left₀ hx3 (by positivity) (by norm_num)
    nlinarith [sq_abs x.re]
  have hay : y.re ^ 2 * 144 < 25 * q ^ 2 := by
    have : (12 * |y.re|) ^ 2 < (5 * q) ^ 2 := by
      apply pow_lt_pow_left₀ hy3 (by positivity) (by norm_num)
    nlinarith [sq_abs y.re]
  set ra := x.re ^ 2 + p ^ 2 with hra
  set rb := y.re ^ 2 + q ^ 2 with hrb
  have hra1 : ra < 1 := by rw [hra, hp]; nlinarith
  have hrb1 : rb < 1 := by rw [hrb, hq]; nlinarith
  have hpa : 144 * ra ≤ 169 * p ^ 2 := by nlinarith
  have hqb : 144 * rb ≤ 169 * q ^ 2 := by nlinarith
  have hxy : -(2 * (x.re * y.re)) ≤ 50 / 144 * (p * q) := by
    have h1 : |x.re| * 12 ≤ 5 * p := by linarith
    have h2 : |y.re| * 12 ≤ 5 * q := by linarith
    have h3 : |x.re| * |y.re| * 144 ≤ 25 * (p * q) := by
      nlinarith [abs_nonneg x.re, abs_nonneg y.re]
    have h4 : -(x.re * y.re) ≤ |x.re| * |y.re| := by rw [← abs_mul]; exact neg_le_abs _
    linarith
  have hD : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 = ra + rb - 2 * (x.re * y.re) - 2 * (p * q) := by
    rw [hra, hrb, hp, hq]; ring
  rw [hD]
  have hra0 : 0 ≤ ra := by positivity
  have hrb0 : 0 ≤ rb := by positivity
  rcases le_total ra rb with h | h
  · have hm : 144 * ra ≤ 169 * (p * q) := by
      have hpp : 144 * ra ≤ 169 * p ^ 2 := hpa
      have hqq : 144 * ra ≤ 169 * q ^ 2 := by linarith
      by_contra hc
      push Not at hc
      have hpq0 : 0 ≤ p * q := by positivity
      have : (169 * (p * q)) ^ 2 < (144 * ra) ^ 2 := by
        apply pow_lt_pow_left₀ hc (by positivity) (by norm_num)
      nlinarith [mul_le_mul hpp hqq (by positivity) (by positivity)]
    linarith
  · have hm : 144 * rb ≤ 169 * (p * q) := by
      have hqq : 144 * rb ≤ 169 * q ^ 2 := hqb
      have hpp : 144 * rb ≤ 169 * p ^ 2 := by linarith
      by_contra hc
      push Not at hc
      have hpq0 : 0 ≤ p * q := by positivity
      have : (169 * (p * q)) ^ 2 < (144 * rb) ^ 2 := by
        apply pow_lt_pow_left₀ hc (by positivity) (by norm_num)
      nlinarith [mul_le_mul hpp hqq (by positivity) (by positivity)]
    linarith

/-- `H` is the mirror of `G` under conjugation. -/
theorem conj_mem_bowtieG_of_mem_bowtieH {z : ℂ} (hz : z ∈ bowtieH) : (starRingEnd ℂ) z ∈ bowtieG := by
  obtain ⟨h1, h2, h3⟩ := hz
  have hn : ‖(starRingEnd ℂ) z - I‖ = ‖z + I‖ := by
    rw [← Complex.norm_conj, map_sub, Complex.conj_conj, Complex.conj_I, sub_neg_eq_add]
  refine ⟨by rw [hn]; exact h1, ?_, ?_⟩
  · simp only [Complex.conj_im]; linarith
  · simp only [Complex.conj_re, Complex.conj_im]; linarith

/-- Two points of `H` are less than `1` apart. -/
theorem dist_lt_one_of_mem_bowtieH {x y : ℂ} (hx : x ∈ bowtieH) (hy : y ∈ bowtieH) : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 := by
  have := dist_lt_one_of_mem_bowtieG (conj_mem_bowtieG_of_mem_bowtieH hx) (conj_mem_bowtieG_of_mem_bowtieH hy)
  simp only [Complex.conj_re, Complex.conj_im] at this
  nlinarith


/-- `C` is its own mirror under conjugation (the two circle conditions swap). -/
theorem conj_mem_bowtieC {z : ℂ} (hz : z ∈ bowtieC) : (starRingEnd ℂ) z ∈ bowtieC := by
  obtain ⟨h1, h2, h3, h4, h5⟩ := hz
  have hn1 : ‖(starRingEnd ℂ) z - I‖ = ‖z + I‖ := by
    rw [← Complex.norm_conj, map_sub, Complex.conj_conj, Complex.conj_I, sub_neg_eq_add]
  have hn2 : ‖(starRingEnd ℂ) z + I‖ = ‖z - I‖ := by
    rw [← Complex.norm_conj, map_add, Complex.conj_conj, Complex.conj_I, ← sub_eq_add_neg]
  refine ⟨by simpa using h1, by simpa using h2, by simpa using h3, by rw [hn1]; exact h5, by rw [hn2]; exact h4⟩

/-- `CS` is the mirror of `CN` under conjugation. -/
theorem conj_mem_bowtieCN_of_mem_bowtieCS {z : ℂ} (hz : z ∈ bowtieCS) : (starRingEnd ℂ) z ∈ bowtieCN := by
  obtain ⟨h1, h2⟩ := hz
  exact ⟨by simp only [Complex.conj_re, Complex.conj_im]; linarith, by simp only [Complex.conj_im]; linarith⟩

/-- A point of `C` and a point of `CN` are more than `1` apart: `CN` lies in the upward cone at `i`, `C` below `i` outside `ω(i)`. -/
theorem one_lt_of_mem_bowtieC_CN {x y : ℂ} (hx : x ∈ bowtieC) (hy : y ∈ bowtieCN) : 1 < (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
  obtain ⟨-, hx2, hx3, hx4, -⟩ := hx
  obtain ⟨hy1, -⟩ := hy
  have nx := norm_sub_I_sq x
  have e4 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr hx4
  have hb : x.im - 1 < -12 / 13 := by linarith [(abs_lt.mp hx3).2]
  have hd : 0 < y.im - 1 := by linarith [abs_nonneg y.re]
  have h1 : x.re * y.re ≤ |x.re| * |y.re| := by rw [← abs_mul]; exact le_abs_self _
  have h2 : |x.re| * |y.re| ≤ 5 / 13 * |y.re| := mul_le_mul_of_nonneg_right hx2.le (abs_nonneg _)
  have h3 : (x.im - 1) * (y.im - 1) < -12 / 13 * (y.im - 1) := mul_lt_mul_of_pos_right hb hd
  have h5 : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 =
      (x.re ^ 2 + (x.im - 1) ^ 2) - 2 * (x.re * y.re + (x.im - 1) * (y.im - 1)) + (y.re ^ 2 + (y.im - 1) ^ 2) := by ring
  nlinarith [sq_nonneg y.re, sq_nonneg (y.im - 1)]

/-- Two points of colour `1` are never at distance `1`. -/
theorem sq_ne_one_of_bowtie_one {x y : ℂ} (hx : x ∈ bowtieC ∪ bowtieCN ∪ bowtieCS) (hy : y ∈ bowtieC ∪ bowtieCN ∪ bowtieCS) :
    (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 ≠ 1 := by
  have hCC : ∀ {x y : ℂ}, x ∈ bowtieC → y ∈ bowtieC → (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 := by
    intro x y hx hy
    obtain ⟨-, a2, a3, -, -⟩ := hx
    obtain ⟨-, b2, b3, -, -⟩ := hy
    have := abs_lt.mp a2; have := abs_lt.mp a3; have := abs_lt.mp b2; have := abs_lt.mp b3
    nlinarith
  have hNN : ∀ {x y : ℂ}, x ∈ bowtieCN → y ∈ bowtieCN → (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 := by
    intro x y hx hy
    obtain ⟨a1, a2⟩ := hx
    obtain ⟨b1, b2⟩ := hy
    have := abs_lt.mp a1; have := abs_lt.mp b1
    nlinarith [abs_nonneg x.re, abs_nonneg y.re]
  have hCS : ∀ {x y : ℂ}, x ∈ bowtieC → y ∈ bowtieCS → 1 < (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
    intro x y hx hy
    have := one_lt_of_mem_bowtieC_CN (conj_mem_bowtieC hx) (conj_mem_bowtieCN_of_mem_bowtieCS hy)
    simp only [Complex.conj_re, Complex.conj_im] at this
    nlinarith
  have hSS : ∀ {x y : ℂ}, x ∈ bowtieCS → y ∈ bowtieCS → (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 < 1 := by
    intro x y hx hy
    have := hNN (conj_mem_bowtieCN_of_mem_bowtieCS hx) (conj_mem_bowtieCN_of_mem_bowtieCS hy)
    simp only [Complex.conj_re, Complex.conj_im] at this
    nlinarith
  have hNS : ∀ {x y : ℂ}, x ∈ bowtieCN → y ∈ bowtieCS → 1 < (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
    intro x y hx hy
    obtain ⟨a1, -⟩ := hx
    obtain ⟨b1, -⟩ := hy
    nlinarith [abs_nonneg x.re, abs_nonneg y.re, sq_nonneg (x.re - y.re)]
  rcases hx with (hx | hx) | hx <;> rcases hy with (hy | hy) | hy
  · exact (hCC hx hy).ne
  · exact (one_lt_of_mem_bowtieC_CN hx hy).ne'
  · exact (hCS hx hy).ne'
  · have := one_lt_of_mem_bowtieC_CN hy hx; intro h; nlinarith
  · exact (hNN hx hy).ne
  · exact (hNS hx hy).ne'
  · have := hCS hy hx; intro h; nlinarith
  · have := hNS hy hx; intro h; nlinarith
  · exact (hSS hx hy).ne

/-- Two points of colour `3` (`σ = 1`) or `4` (`σ = −1`) are never at distance `1`. -/
theorem sq_ne_one_of_bowtie_XY {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) {x y : ℂ} (hx : x ∈ bowtieX σ ∪ bowtieY σ)
    (hy : y ∈ bowtieX σ ∪ bowtieY σ) : (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 ≠ 1 := by
  have hs : (x.re - y.re) ^ 2 = (σ * x.re - σ * y.re) ^ 2 := by rcases hσ with rfl | rfl <;> ring
  rw [hs]
  rcases hx with ⟨a1, a2, a3, a4⟩ | ⟨a1, a2, a3, a4⟩ <;> rcases hy with ⟨b1, b2, b3, b4⟩ | ⟨b1, b2, b3, b4⟩
  · have : 0 < σ * x.re := by linarith
    have : 0 < σ * y.re := by linarith
    nlinarith
  · nlinarith [sq_nonneg (σ * x.re - σ * y.re)]
  · nlinarith [sq_nonneg (σ * x.re - σ * y.re)]
  · have : 0 < σ * x.re := by linarith
    have : 0 < σ * y.re := by linarith
    nlinarith

/-- `Z±` lie in the box `|re| < 113/260`, `|im| < 11/65`, and so do their closures. -/
theorem closure_bowtieZ_subset {σ : ℝ} (hσ : σ = 1 ∨ σ = -1) :
    closure (bowtieZ σ) ⊆ {z : ℂ | |z.re| ≤ 113 / 260} ∩ {z | |z.im| ≤ 11 / 65} := by
  refine closure_minimal (fun z hz => ⟨?_, hz.2.2.1.le⟩)
    ((isClosed_le (by fun_prop) continuous_const).inter (isClosed_le (by fun_prop) continuous_const))
  obtain ⟨h1, h2, -, -⟩ := hz
  show |z.re| ≤ 113 / 260
  rcases hσ with rfl | rfl
  · rw [abs_le]; constructor <;> linarith
  · rw [abs_le]; constructor <;> linarith

/-- An interior point of the bowtie lies in one of its nine open tiles `G`, `C`, `CN`, `CS`, `H`, `X±`, `Y±`, or in the closure of `Z±`
(each of the nine tiles' closures adds only boundary pieces). -/
theorem bowtie_interiorPts_cases {x : ℂ} (hx : x ∈ bowtie.interiorPts) :
    x ∈ bowtieG ∨ x ∈ bowtieC ∨ x ∈ bowtieCN ∨ x ∈ bowtieCS ∨ x ∈ bowtieH ∨ x ∈ bowtieX 1 ∨ x ∈ bowtieY 1 ∨
      x ∈ bowtieX (-1) ∨ x ∈ bowtieY (-1) ∨ x ∈ closure (bowtieZ 1) ∨ x ∈ closure (bowtieZ (-1)) := by
  obtain ⟨hd, hA⟩ := hx
  have hA' : x ∉ ⋃ a ∈ bowtieArcs, a.carrier := hA
  have hcl : x ∈ closure bowtieTiles := interior_subset hd
  simp only [bowtieTiles, closure_union, mem_union] at hcl
  have k : ∀ {U : Set ℂ}, closure U ⊆ U ∪ ⋃ a ∈ bowtieArcs, a.carrier → x ∈ closure U → x ∈ U :=
    fun h hU => (h hU).resolve_right hA'
  rcases hcl with ((((((((((h | h) | h) | h) | h) | h) | h) | h) | h) | h) | h)
  · exact Or.inl (k closure_bowtieG_subset h)
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieH_subset h)))))
  · exact Or.inr (Or.inl (k closure_bowtieC_subset h))
  · exact Or.inr (Or.inr (Or.inl (k closure_bowtieCN_subset h)))
  · exact Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieCS_subset h))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieX_one_subset h))))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieX_neg_one_subset h))))))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieY_one_subset h)))))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (k closure_bowtieY_neg_one_subset h)))))))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl h)))))))))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr h)))))))))

/-- The tiles each colour of the bowtie comes from (read off `bowtieCol`'s if-chain). -/
theorem bowtieCol_cases (x : ℂ) :
    (bowtieCol x = 0 → x ∈ bowtieG) ∧ (bowtieCol x = 1 → x ∈ bowtieC ∪ bowtieCN ∪ bowtieCS) ∧
      (bowtieCol x = 2 → x ∈ bowtieH) ∧ (bowtieCol x = 3 → x ∈ bowtieX 1 ∪ bowtieY 1) ∧
      (bowtieCol x = 4 → x ∈ bowtieX (-1) ∪ bowtieY (-1)) ∧
      (bowtieCol x = 5 → x ∉ bowtieG ∧ x ∉ bowtieC ∪ bowtieCN ∪ bowtieCS ∧ x ∉ bowtieH ∧ x ∉ bowtieX 1 ∪ bowtieY 1 ∧
        x ∉ bowtieX (-1) ∪ bowtieY (-1)) := by
  classical
  unfold bowtieCol
  split_ifs <;> simp_all

/-- **FS112-BOWTIE**: the fragment is valid (YB3: 21 of 21 same-colour tile pairs, exact). -/
theorem bowtie_valid : bowtie.Valid := by
  intro x hx y hy hxy hcol
  have hd := sq_coords_of_dist_eq_one hxy
  have hc : bowtieCol x = bowtieCol y := hcol
  obtain ⟨c0, c1, c2, c3, c4, -⟩ := bowtieCol_cases x
  obtain ⟨d0, d1, d2, d3, d4, -⟩ := bowtieCol_cases y
  have hbox : ∀ {z : ℂ}, z ∈ bowtie.interiorPts → bowtieCol z = 5 → |z.re| ≤ 113 / 260 ∧ |z.im| ≤ 11 / 65 := by
    intro z hz h5
    obtain ⟨n0, n1, n2, n3, n4⟩ := (bowtieCol_cases z).2.2.2.2.2 h5
    simp only [mem_union, not_or] at n1 n3 n4
    rcases bowtie_interiorPts_cases hz with h | h | h | h | h | h | h | h | h | h | h
    · exact absurd h n0
    · exact absurd h n1.1.1
    · exact absurd h n1.1.2
    · exact absurd h n1.2
    · exact absurd h n2
    · exact absurd h n3.1
    · exact absurd h n3.2
    · exact absurd h n4.1
    · exact absurd h n4.2
    · exact closure_bowtieZ_subset (Or.inl rfl) h
    · exact closure_bowtieZ_subset (Or.inr rfl) h
  generalize hj : bowtieCol y = j at hc
  fin_cases j
  · exact (dist_lt_one_of_mem_bowtieG (c0 hc) (d0 hj)).ne hd
  · exact sq_ne_one_of_bowtie_one (c1 hc) (d1 hj) hd
  · exact (dist_lt_one_of_mem_bowtieH (c2 hc) (d2 hj)).ne hd
  · exact sq_ne_one_of_bowtie_XY (Or.inl rfl) (c3 hc) (d3 hj) hd
  · exact sq_ne_one_of_bowtie_XY (Or.inr rfl) (c4 hc) (d4 hj) hd
  · obtain ⟨a1, a2⟩ := hbox hx hc
    obtain ⟨b1, b2⟩ := hbox hy hj
    have := abs_le.mp a1; have := abs_le.mp a2; have := abs_le.mp b1; have := abs_le.mp b2
    nlinarith


/-- `E = 0`, `N = i`, `S = −i` lie in the fragment's domain. -/
theorem bowtie_mem_dom : (0 : ℂ) ∈ bowtie.dom ∧ I ∈ bowtie.dom ∧ -I ∈ bowtie.dom :=
  ⟨ball_subset_bowtie_dom (mem_ball_self (by norm_num)),
    interior_maximal ball_I_subset_closure_bowtieTiles isOpen_ball (mem_ball_self (by norm_num)),
    interior_maximal ball_negI_subset_closure_bowtieTiles isOpen_ball (mem_ball_self (by norm_num))⟩

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

/-! ### The bowtie near `N = i` and `S′ = −i`: classes `0` and `2` there, and the shadows of the horns (FS131-I4f) -/

/-- A point of a segment `[a, b]` is `a + t (b − a)` for some `t ∈ [0, 1]`, in coordinates. -/
theorem coords_of_mem_segment {a b z : ℂ} (hz : z ∈ segment ℝ a b) :
    ∃ t : ℝ, 0 ≤ t ∧ t ≤ 1 ∧ z.re = a.re + t * (b.re - a.re) ∧ z.im = a.im + t * (b.im - a.im) := by
  obtain ⟨s, t, hs, ht, hst, rfl⟩ := hz
  have hs' : s = 1 - t := by linarith
  subst hs'
  refine ⟨t, ht, by linarith, ?_, ?_⟩
  · simp only [Complex.add_re, Complex.smul_re, smul_eq_mul]; ring
  · simp only [Complex.add_im, Complex.smul_im, smul_eq_mul]; ring

/-- Within `1/10` of `N = i`, strictly inside `G`'s cone, a point lies on no boundary piece of the bowtie (the pieces near `i` are
`G`'s two edges and `CN`'s two edges through `i`). -/
theorem not_mem_bowtieArcs_near_I {z : ℂ} (hz : ‖z - I‖ < 1 / 10) (h1 : 12 * |z.re| < 5 * (1 - z.im)) :
    z ∉ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hre : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z - I); simp only [Complex.sub_re, Complex.I_re, sub_zero] at this; linarith
  have him : |z.im - 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z - I); simp only [Complex.sub_im, Complex.I_im] at this; linarith
  have hr1 := abs_lt.mp hre
  have hi1 := abs_lt.mp him
  have ha1 := le_abs_self z.re
  have ha2 := neg_le_abs z.re
  intro h
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · obtain ⟨θ, -, rfl⟩ := hza; simp at hz; norm_num at hz
  · obtain ⟨θ, -, rfl⟩ := hza
    simp only [Complex.add_im, Complex.neg_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e,
      one_mul, zero_mul, add_zero] at hi1
    linarith [Real.sin_le_one θ]
  all_goals obtain ⟨t, ht0, ht1, hre', him'⟩ := coords_of_mem_segment hza
  all_goals simp only [pt, Complex.I_re, Complex.I_im, Complex.neg_re, Complex.neg_im] at hre' him'
  all_goals linarith

/-- Within `1/10` of `S′ = −i`, strictly inside `H`'s cone, a point lies on no boundary piece of the bowtie. -/
theorem not_mem_bowtieArcs_near_negI {z : ℂ} (hz : ‖z + I‖ < 1 / 10) (h1 : 12 * |z.re| < 5 * (1 + z.im)) :
    z ∉ ⋃ a ∈ bowtieArcs, a.carrier := by
  have hre : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z + I); simp only [Complex.add_re, Complex.I_re, add_zero] at this; linarith
  have him : |z.im + 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z + I); simp only [Complex.add_im, Complex.I_im] at this; linarith
  have hr1 := abs_lt.mp hre
  have hi1 := abs_lt.mp him
  have ha1 := le_abs_self z.re
  have ha2 := neg_le_abs z.re
  intro h
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · obtain ⟨θ, -, rfl⟩ := hza
    simp only [Complex.add_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e,
      one_mul, zero_mul, add_zero] at hi1
    linarith [Real.neg_one_le_sin θ]
  · obtain ⟨θ, -, rfl⟩ := hza; simp at hz; norm_num at hz
  all_goals obtain ⟨t, ht0, ht1, hre', him'⟩ := coords_of_mem_segment hza
  all_goals simp only [pt, Complex.I_re, Complex.I_im, Complex.neg_re, Complex.neg_im] at hre' him'
  all_goals linarith

/-- Each open tile of the bowtie lies in its domain. -/
theorem subset_bowtie_dom {U : Set ℂ} (hU : IsOpen U) (h : U ⊆ bowtieTiles) : U ⊆ bowtie.dom :=
  interior_maximal (h.trans subset_closure) hU

/-- `G` lies in the open unit disc about `E = 0`. -/
theorem bowtieG_subset_ball : bowtieG ⊆ ball 0 1 := by
  intro z ⟨h1, h2, h3⟩
  rw [mem_ball_zero_iff]
  have hs := norm_sub_I_sq z
  have e1 : ‖z - I‖ ^ 2 < 1 := by nlinarith [norm_nonneg (z - I)]
  have him : 0 < z.im := by nlinarith
  have hax : z.re ^ 2 * 144 < 25 * (1 - z.im) ^ 2 := by
    have : (12 * |z.re|) ^ 2 < (5 * (1 - z.im)) ^ 2 := pow_lt_pow_left₀ h3 (by positivity) (by norm_num)
    nlinarith [sq_abs z.re]
  have hn : ‖z‖ ^ 2 = z.re ^ 2 + z.im ^ 2 := by rw [← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; ring
  have : ‖z‖ ^ 2 < 1 := by nlinarith
  nlinarith [norm_nonneg z]

/-- `H` lies in the open unit disc about `E = 0`. -/
theorem bowtieH_subset_ball : bowtieH ⊆ ball 0 1 := by
  intro z hz
  have := bowtieG_subset_ball (conj_mem_bowtieG_of_mem_bowtieH hz)
  rwa [mem_ball_zero_iff, Complex.norm_conj, ← mem_ball_zero_iff] at this

/-- A point of `G` within `1/10` of `i` is a point of the bowtie's class `0`. -/
theorem mem_bowtie_region_zero {z : ℂ} (hz : z ∈ bowtieG) (hI : ‖z - I‖ < 1 / 10) : z ∈ bowtie.region 0 :=
  ⟨⟨subset_bowtie_dom isOpen_bowtieG subset_bowtieTiles.1 hz, not_mem_bowtieArcs_near_I hI hz.2.2⟩, bowtieCol_of_mem_G hz⟩

/-- A point of `H` within `1/10` of `−i` is a point of the bowtie's class `2`. -/
theorem mem_bowtie_region_two {z : ℂ} (hz : z ∈ bowtieH) (hI : ‖z + I‖ < 1 / 10) : z ∈ bowtie.region 2 :=
  ⟨⟨subset_bowtie_dom isOpen_bowtieH subset_bowtieTiles.2.1 hz, not_mem_bowtieArcs_near_negI hI hz.2.2⟩, bowtieCol_of_mem_H hz⟩

/-- `i` is in the closure of the class `0` (the points `i − t i` of `G`), `−i` in the closure of the class `2`. -/
theorem I_mem_closure_bowtie_region : I ∈ closure (bowtie.region 0) ∧ -I ∈ closure (bowtie.region 2) := by
  constructor
  · rw [Metric.mem_closure_iff]
    intro ε hε
    set t : ℝ := min (ε / 2) (1 / 20) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
    have ht1 : t ≤ 1 / 20 := min_le_right _ _
    have ht2 : t ≤ ε / 2 := min_le_left _ _
    have hn : ‖((1 - t : ℝ) : ℂ) * I - I‖ = t := by
      rw [show ((1 - t : ℝ) : ℂ) * I - I = ((-t : ℝ) : ℂ) * I by push_cast; ring, norm_mul, Complex.norm_I, mul_one,
        Complex.norm_real, Real.norm_eq_abs, abs_neg, abs_of_pos ht0]
    have hG : ((1 - t : ℝ) : ℂ) * I ∈ bowtieG := by
      refine ⟨by rw [hn]; linarith, ?_, ?_⟩ <;> simp <;> linarith
    refine ⟨_, mem_bowtie_region_zero hG (by rw [hn]; linarith), ?_⟩
    rw [dist_comm, dist_eq_norm, hn]; linarith
  · rw [Metric.mem_closure_iff]
    intro ε hε
    set t : ℝ := min (ε / 2) (1 / 20) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by norm_num)
    have ht1 : t ≤ 1 / 20 := min_le_right _ _
    have ht2 : t ≤ ε / 2 := min_le_left _ _
    have hn : ‖((t - 1 : ℝ) : ℂ) * I + I‖ = t := by
      rw [show ((t - 1 : ℝ) : ℂ) * I + I = ((t : ℝ) : ℂ) * I by push_cast; ring, norm_mul, Complex.norm_I, mul_one,
        Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
    have hH : ((t - 1 : ℝ) : ℂ) * I ∈ bowtieH := by
      refine ⟨by rw [hn]; linarith, ?_, ?_⟩ <;> simp <;> linarith
    refine ⟨_, mem_bowtie_region_two hH (by rw [hn]; linarith), ?_⟩
    rw [dist_comm, dist_eq_norm, sub_neg_eq_add, hn]; linarith

/-- Near `E = 0`, a point outside `ω(i)` sees a point of the class `0` at distance exactly `1`: the point of `G` toward `i`. -/
theorem mem_shadow_bowtie_region_zero {z : ℂ} (hz : ‖z‖ < 1 / 20) (h1 : 1 < ‖z - I‖) : z ∈ shadow (bowtie.region 0) := by
  set d := ‖z - I‖ with hd
  have hd0 : 0 < d := by linarith
  set y : ℂ := z + ((1 / d : ℝ) : ℂ) * (I - z) with hy
  have hf0 : 0 < 1 - 1 / d := by rw [sub_pos, div_lt_one hd0]; exact h1
  have hdz : d < 1 + 1 / 20 := by
    have := norm_sub_le z I; rw [Complex.norm_I] at this; linarith
  have hdist : dist z y = 1 := by
    rw [dist_eq_norm, hy, sub_add_cancel_left, norm_neg, norm_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by positivity), norm_sub_rev, ← hd]
    field_simp
  have hyI : y - I = ((1 - 1 / d : ℝ) : ℂ) * (z - I) := by rw [hy]; push_cast; ring
  have hnyI : ‖y - I‖ = d - 1 := by
    rw [hyI, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hf0, ← hd]; field_simp
  have hre : |z.re| < 1 / 20 := (Complex.abs_re_le_norm z).trans_lt hz
  have him : |z.im| < 1 / 20 := (Complex.abs_im_le_norm z).trans_lt hz
  have hyre : y.re = (1 - 1 / d) * z.re := by rw [hy]; simp; ring
  have hyim : 1 - y.im = (1 - 1 / d) * (1 - z.im) := by rw [hy]; simp; ring
  have hz1 : 0 < 1 - z.im := by linarith [(abs_lt.mp him).2]
  have hcone : 12 * |y.re| < 5 * (1 - y.im) := by
    rw [hyre, hyim, abs_mul, abs_of_pos hf0]
    have : 12 * |z.re| < 5 * (1 - z.im) := by linarith [(abs_lt.mp him).2]
    nlinarith
  have hy1 : y.im < 1 := by nlinarith
  exact ⟨y, mem_bowtie_region_zero ⟨by rw [hnyI]; linarith, hy1, hcone⟩ (by rw [hnyI]; linarith), hdist⟩

/-- Near `E = 0`, a point outside `ω(−i)` sees a point of the class `2` at distance exactly `1`: the point of `H` toward `−i`. -/
theorem mem_shadow_bowtie_region_two {z : ℂ} (hz : ‖z‖ < 1 / 20) (h1 : 1 < ‖z + I‖) : z ∈ shadow (bowtie.region 2) := by
  set d := ‖z + I‖ with hd
  have hd0 : 0 < d := by linarith
  set y : ℂ := z + ((1 / d : ℝ) : ℂ) * (-I - z) with hy
  have hf0 : 0 < 1 - 1 / d := by rw [sub_pos, div_lt_one hd0]; exact h1
  have hdz : d < 1 + 1 / 20 := by
    have := norm_add_le z I; rw [Complex.norm_I] at this; linarith
  have hdist : dist z y = 1 := by
    rw [dist_eq_norm, hy, sub_add_cancel_left, norm_neg, norm_mul, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by positivity), show -I - z = -(z + I) by ring, norm_neg, ← hd]
    field_simp
  have hyI : y + I = ((1 - 1 / d : ℝ) : ℂ) * (z + I) := by rw [hy]; push_cast; ring
  have hnyI : ‖y + I‖ = d - 1 := by
    rw [hyI, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hf0, ← hd]; field_simp
  have hre : |z.re| < 1 / 20 := (Complex.abs_re_le_norm z).trans_lt hz
  have him : |z.im| < 1 / 20 := (Complex.abs_im_le_norm z).trans_lt hz
  have hyre : y.re = (1 - 1 / d) * z.re := by rw [hy]; simp; ring
  have hyim : 1 + y.im = (1 - 1 / d) * (1 + z.im) := by rw [hy]; simp; ring
  have hz1 : 0 < 1 + z.im := by linarith [(abs_lt.mp him).1]
  have hcone : 12 * |y.re| < 5 * (1 + y.im) := by
    rw [hyre, hyim, abs_mul, abs_of_pos hf0]
    have : 12 * |z.re| < 5 * (1 + z.im) := by linarith [(abs_lt.mp him).1]
    nlinarith
  have hy1 : -1 < y.im := by nlinarith
  exact ⟨y, mem_bowtie_region_two ⟨by rw [hnyI]; linarith, hy1, hcone⟩ (by rw [hnyI]; linarith), hdist⟩

/-- **Shadowed** by its flanks: each horn lies, near `E`, in the shadow of both flank colours. -/
theorem bowtie_doublyShadowed : bowtie.DoublyShadowed 0 0 (-1) 1 0 2 ∧ bowtie.DoublyShadowed 0 π (-1) 1 2 0 := by
  have h20 : (0 : ℝ) < 1 / 20 := by norm_num
  have hN : e (0 + π / 2) = I := by rw [zero_add, e_pi_div_two]
  refine ⟨⟨-1, 1, le_rfl, by norm_num, le_rfl, ?_⟩, ⟨-1, 1, le_rfl, by norm_num, le_rfl, ?_⟩⟩
  · filter_upwards [Ioc_mem_nhdsGT h20] with r hr
    rintro z ⟨h0, -, h3, h4⟩
    rw [tanAbove_neg_one_iff, hN, zero_sub, dist_eq_norm, sub_neg_eq_add] at h3
    rw [tanBelow_one_iff, hN, zero_add, dist_eq_norm] at h4
    rw [dist_zero_right] at h0
    exact ⟨mem_shadow_bowtie_region_zero (by linarith [hr.2]) h4, mem_shadow_bowtie_region_two (by linarith [hr.2]) h3⟩
  · filter_upwards [Ioc_mem_nhdsGT h20] with r hr
    rintro z ⟨h0, -, h3, h4⟩
    rw [tanAbove_neg_one_iff, e_pi_add_pi_div_two, zero_sub, neg_neg, dist_eq_norm] at h3
    rw [tanBelow_one_iff, e_pi_add_pi_div_two, zero_add, dist_eq_norm, sub_neg_eq_add] at h4
    rw [dist_zero_right] at h0
    exact ⟨mem_shadow_bowtie_region_two (by linarith [hr.2]) h4, mem_shadow_bowtie_region_zero (by linarith [hr.2]) h3⟩

/-- The flank sectors are **in-type** radius-1 sectors at `N` and `S`: contacts of colours `0` at `N` and `2` at `S`, in-type. -/
theorem bowtie_inType : (bowtie.IsContact 0 0 I ∧ bowtie.InType 0 0 I) ∧ (bowtie.IsContact 0 2 (-I) ∧ bowtie.InType 0 2 (-I)) := by
  have hc := bowtie_coloursAt_zero.1
  refine ⟨⟨⟨by rw [hc]; simp, by simp, I_mem_closure_bowtie_region.1⟩, ?_⟩, ⟨⟨by rw [hc]; simp, by simp, I_mem_closure_bowtie_region.2⟩, ?_⟩⟩
  · rintro T ⟨⟨x, hx, rfl⟩, hcol⟩ - z hz
    exact bowtieG_subset_ball ((bowtieCol_cases z).1 (hcol hz))
  · rintro T ⟨⟨x, hx, rfl⟩, hcol⟩ - z hz
    exact bowtieH_subset_ball ((bowtieCol_cases z).2.2.1 (hcol hz))

/-! ### The bowtie at `N = i` and `S′ = −i`: four sectors each (FS131-I4f) -/

/-- **Colours and sectors from a tile partition**: if near `v` the interior points are cut by `n` disjoint convex open sets `T i`, each
holding `v` in its closure and of one colour `c i` (`c` injective), then `P_cl(v)` is the range of `c` and each colour has one sector. -/
theorem coloursAt_hasSectors_of_tiles {k n : ℕ} {F : ArcMap k} {v : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀) {T : Fin n → Set ℂ}
    {c : Fin n → Fin k} (hU : ∀ r, 0 < r → r ≤ r₀ → F.interiorPts ∩ ball v r = ⋃ i, T i ∩ ball v r)
    (ho : ∀ i, IsOpen (T i)) (hcv : ∀ i, Convex ℝ (T i)) (hd : ∀ i j, i ≠ j → Disjoint (T i) (T j))
    (hcl : ∀ i, v ∈ closure (T i)) (hcol : ∀ i, ∀ z ∈ T i, F.col z = c i) (hc : Function.Injective c) :
    F.coloursAt v = range c ∧ ∀ i, F.HasSectors v (c i) 1 := by
  have hcl' : ∀ i, ∀ r, 0 < r → v ∈ closure (T i ∩ ball v r) := by
    intro i r hr
    rw [Metric.mem_closure_iff]
    intro ε hε
    obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp (hcl i) (min ε r) (lt_min hε hr)
    exact ⟨z, ⟨hz, by rw [mem_ball, dist_comm]; exact hzd.trans_le (min_le_right _ _)⟩, hzd.trans_le (min_le_left _ _)⟩
  have hreg : ∀ i, T i ∩ ball v r₀ ⊆ F.region (c i) := by
    intro i z hz
    have : z ∈ F.interiorPts ∩ ball v r₀ := by rw [hU r₀ hr₀ le_rfl]; exact mem_iUnion.mpr ⟨i, hz⟩
    exact ⟨this.1, hcol i z hz.1⟩
  refine ⟨?_, fun i => ?_⟩
  · ext j
    constructor
    · intro hj
      obtain ⟨z, ⟨hzI, hzc⟩, hzd⟩ := Metric.mem_closure_iff.mp hj r₀ hr₀
      have hz : z ∈ F.interiorPts ∩ ball v r₀ := ⟨hzI, by rw [mem_ball, dist_comm]; exact hzd⟩
      rw [hU r₀ hr₀ le_rfl, mem_iUnion] at hz
      obtain ⟨i, hi⟩ := hz
      exact ⟨i, (hcol i z hi.1).symm.trans hzc⟩
    · rintro ⟨i, rfl⟩
      exact closure_mono (hreg i) (hcl' i r₀ hr₀)
  · filter_upwards [Ioc_mem_nhdsGT hr₀] with r ⟨hr0, hr⟩
    have hp := hU r hr0 hr
    have ho' : ∀ j, IsOpen (T j ∩ ball v r) := fun j => (ho j).inter isOpen_ball
    have hpre : ∀ j, IsPreconnected (T j ∩ ball v r) := fun j => ((hcv j).inter (convex_ball v r)).isPreconnected
    have hd' : ∀ j l, j ≠ l → Disjoint (T j ∩ ball v r) (T l ∩ ball v r) :=
      fun j l h => (hd j l h).mono inter_subset_left inter_subset_left
    have hne : ∀ j, (T j ∩ ball v r).Nonempty := fun j => (mem_closure_iff_nhds.mp (hcl' j r hr0)) univ univ_mem |>.mono
      fun z hz => hz.2
    have hs : F.sectorsOf v r (c i) = {T i ∩ ball v r} := by
      ext S
      simp only [ArcMap.sectorsOf, mem_setOf_eq, mem_singleton_iff]
      rw [isSector_iff_of_partition hp ho' hpre hd' hne (fun j => hcl' j r hr0)]
      constructor
      · rintro ⟨⟨j, rfl⟩, hS⟩
        obtain ⟨z, hz⟩ := hne j
        have : c j = c i := (hcol j z hz.1).symm.trans (hS hz)
        rw [hc this]
      · rintro rfl
        refine ⟨⟨i, rfl⟩, fun z hz => hcol i z hz.1⟩
    rw [hs, encard_singleton]; rfl

/-- An open half-plane `a·re + b·im < c` is convex. -/
theorem convex_halfPlane (a b c : ℝ) : Convex ℝ {z : ℂ | a * z.re + b * z.im < c} := by
  refine convex_halfSpace_lt ⟨fun x y => ?_, fun s x => ?_⟩ c
  · simp only [Complex.add_re, Complex.add_im]; ring
  · simp only [Complex.smul_re, Complex.smul_im, smul_eq_mul]; ring

/-- Within `1/10` of `i`, a point of a boundary piece lies on one of the four edges through `i`. -/
theorem mem_bowtieArcs_near_I {z : ℂ} (hz : ‖z - I‖ < 1 / 10) (h : z ∈ ⋃ a ∈ bowtieArcs, a.carrier) :
    (12 * z.re + 5 * z.im = 5 ∧ 0 ≤ z.re ∧ z.im ≤ 1) ∨ (-12 * z.re + 5 * z.im = 5 ∧ z.re ≤ 0 ∧ z.im ≤ 1) ∨
      (z.im - 1 = z.re ∧ 0 ≤ z.re) ∨ (z.im - 1 = -z.re ∧ z.re ≤ 0) := by
  have hr1 : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z - I); simp only [Complex.sub_re, Complex.I_re, sub_zero] at this; linarith
  have hi1 : |z.im - 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z - I); simp only [Complex.sub_im, Complex.I_im] at this; linarith
  have hr1' := abs_lt.mp hr1
  have hi1' := abs_lt.mp hi1
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · obtain ⟨θ, -, rfl⟩ := hza; simp at hz; norm_num at hz
  · obtain ⟨θ, -, rfl⟩ := hza
    simp only [Complex.add_im, Complex.neg_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e,
      one_mul, zero_mul, add_zero] at hi1'
    linarith [Real.sin_le_one θ]
  all_goals obtain ⟨t, ht0, ht1, hre', him'⟩ := coords_of_mem_segment hza
  all_goals simp only [pt, Complex.I_re, Complex.I_im, Complex.neg_re, Complex.neg_im] at hre' him'
  all_goals first
    | (exfalso; linarith)
    | (left; exact ⟨by linarith, by linarith, by linarith⟩)
    | (right; left; exact ⟨by linarith, by linarith, by linarith⟩)
    | (right; right; left; exact ⟨by linarith, by linarith⟩)
    | (right; right; right; exact ⟨by linarith, by linarith⟩)

/-- Within `1/10` of `−i`, a point of a boundary piece lies on one of the four edges through `−i`. -/
theorem mem_bowtieArcs_near_negI {z : ℂ} (hz : ‖z + I‖ < 1 / 10) (h : z ∈ ⋃ a ∈ bowtieArcs, a.carrier) :
    (12 * z.re - 5 * z.im = 5 ∧ 0 ≤ z.re ∧ -1 ≤ z.im) ∨ (-12 * z.re - 5 * z.im = 5 ∧ z.re ≤ 0 ∧ -1 ≤ z.im) ∨
      (-z.im - 1 = z.re ∧ 0 ≤ z.re) ∨ (-z.im - 1 = -z.re ∧ z.re ≤ 0) := by
  have hr1 : |z.re| < 1 / 10 := by
    have := Complex.abs_re_le_norm (z + I); simp only [Complex.add_re, Complex.I_re, add_zero] at this; linarith
  have hi1 : |z.im + 1| < 1 / 10 := by
    have := Complex.abs_im_le_norm (z + I); simp only [Complex.add_im, Complex.I_im] at this; linarith
  have hr1' := abs_lt.mp hr1
  have hi1' := abs_lt.mp hi1
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · obtain ⟨θ, -, rfl⟩ := hza
    simp only [Complex.add_im, Complex.I_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e,
      one_mul, zero_mul, add_zero] at hi1'
    linarith [Real.neg_one_le_sin θ]
  · obtain ⟨θ, -, rfl⟩ := hza; simp at hz; norm_num at hz
  all_goals obtain ⟨t, ht0, ht1, hre', him'⟩ := coords_of_mem_segment hza
  all_goals simp only [pt, Complex.I_re, Complex.I_im, Complex.neg_re, Complex.neg_im] at hre' him'
  all_goals first
    | (exfalso; linarith)
    | (left; exact ⟨by linarith, by linarith, by linarith⟩)
    | (right; left; exact ⟨by linarith, by linarith, by linarith⟩)
    | (right; right; left; exact ⟨by linarith, by linarith⟩)
    | (right; right; right; exact ⟨by linarith, by linarith⟩)

/-- The bowtie's colour on `CN` and `CS` is `1`. -/
theorem bowtieCol_of_mem_CN_CS {z : ℂ} (hz : z ∈ bowtieCN ∪ bowtieCS) : bowtieCol z = 1 := by
  have hG : z ∉ bowtieG := by
    intro h
    have hs := norm_sub_I_sq z
    have : ‖z - I‖ ^ 2 < 1 := by nlinarith [h.1, norm_nonneg (z - I)]
    rcases hz with hz | hz
    · linarith [h.2.1, hz.1, abs_nonneg z.re]
    · nlinarith [hz.1, abs_nonneg z.re, sq_nonneg z.re]
  unfold bowtieCol
  rw [if_neg hG, if_pos (by rcases hz with hz | hz; exacts [Or.inl (Or.inr hz), Or.inr hz])]

/-- The bowtie's colour on `X σ ∪ Y σ` is `3` for `σ = 1` and `4` for `σ = −1`. -/
theorem bowtieCol_of_mem_XY {z : ℂ} : (z ∈ bowtieX 1 ∪ bowtieY 1 → bowtieCol z = 3) ∧
    (z ∈ bowtieX (-1) ∪ bowtieY (-1) → bowtieCol z = 4) := by
  have hs := norm_sub_I_sq z
  have hs' := norm_add_I_sq z
  have ha1 := le_abs_self z.re
  have ha2 := neg_le_abs z.re
  have nG : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → z ∈ bowtieX σ ∪ bowtieY σ → z ∉ bowtieG := by
    rintro σ hσ (⟨h1, h2, h3, h4⟩ | ⟨h1, h2, h3, h4⟩) ⟨g1, g2, g3⟩ <;> rcases hσ with rfl | rfl
    all_goals first | linarith | nlinarith [g1, norm_nonneg (z - I)]
  have nC : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → z ∈ bowtieX σ ∪ bowtieY σ → z ∉ bowtieC ∪ bowtieCN ∪ bowtieCS := by
    rintro σ hσ (⟨h1, h2, h3, h4⟩ | ⟨h1, h2, h3, h4⟩) ((⟨c1, c2, c3, c4, c5⟩ | ⟨c1, c2⟩) | ⟨c1, c2⟩) <;> rcases hσ with rfl | rfl
    all_goals first | linarith [(abs_lt.mp c3).1, (abs_lt.mp c3).2] | linarith
  have nH : ∀ σ : ℝ, (σ = 1 ∨ σ = -1) → z ∈ bowtieX σ ∪ bowtieY σ → z ∉ bowtieH := by
    rintro σ hσ (⟨h1, h2, h3, h4⟩ | ⟨h1, h2, h3, h4⟩) ⟨g1, g2, g3⟩ <;> rcases hσ with rfl | rfl
    all_goals first | linarith | nlinarith [g1, norm_nonneg (z + I)]
  refine ⟨fun hz => ?_, fun hz => ?_⟩
  · unfold bowtieCol
    rw [if_neg (nG 1 (Or.inl rfl) hz), if_neg (nC 1 (Or.inl rfl) hz), if_neg (nH 1 (Or.inl rfl) hz), if_pos hz]
  · have nX : z ∉ bowtieX 1 ∪ bowtieY 1 := by
      rcases hz with ⟨h1, h2, h3, h4⟩ | ⟨h1, h2, h3, h4⟩ <;> rintro (⟨k1, k2, k3, k4⟩ | ⟨k1, k2, k3, k4⟩) <;> linarith
    unfold bowtieCol
    rw [if_neg (nG (-1) (Or.inr rfl) hz), if_neg (nC (-1) (Or.inr rfl) hz), if_neg (nH (-1) (Or.inr rfl) hz), if_neg nX,
      if_pos hz]

/-- `coloursAt_hasSectors_of_tiles` for four named tiles. -/
theorem coloursAt_hasSectors_of_four_tiles {k : ℕ} {F : ArcMap k} {v : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀) {T₀ T₁ T₂ T₃ : Set ℂ}
    {c₀ c₁ c₂ c₃ : Fin k}
    (hU : ∀ r, 0 < r → r ≤ r₀ → F.interiorPts ∩ ball v r = T₀ ∩ ball v r ∪ T₁ ∩ ball v r ∪ T₂ ∩ ball v r ∪ T₃ ∩ ball v r)
    (ho₀ : IsOpen T₀) (ho₁ : IsOpen T₁) (ho₂ : IsOpen T₂) (ho₃ : IsOpen T₃)
    (hv₀ : Convex ℝ T₀) (hv₁ : Convex ℝ T₁) (hv₂ : Convex ℝ T₂) (hv₃ : Convex ℝ T₃)
    (hd₀₁ : Disjoint T₀ T₁) (hd₀₂ : Disjoint T₀ T₂) (hd₀₃ : Disjoint T₀ T₃) (hd₁₂ : Disjoint T₁ T₂) (hd₁₃ : Disjoint T₁ T₃)
    (hd₂₃ : Disjoint T₂ T₃) (hl₀ : v ∈ closure T₀) (hl₁ : v ∈ closure T₁) (hl₂ : v ∈ closure T₂) (hl₃ : v ∈ closure T₃)
    (hc₀ : ∀ z ∈ T₀, F.col z = c₀) (hc₁ : ∀ z ∈ T₁, F.col z = c₁) (hc₂ : ∀ z ∈ T₂, F.col z = c₂) (hc₃ : ∀ z ∈ T₃, F.col z = c₃)
    (h01 : c₀ ≠ c₁) (h02 : c₀ ≠ c₂) (h03 : c₀ ≠ c₃) (h12 : c₁ ≠ c₂) (h13 : c₁ ≠ c₃) (h23 : c₂ ≠ c₃) :
    F.coloursAt v = {c₀, c₁, c₂, c₃} ∧ ∀ c ∈ F.coloursAt v, F.HasSectors v c 1 := by
  obtain ⟨h1, h2⟩ := coloursAt_hasSectors_of_tiles (F := F) (T := ![T₀, T₁, T₂, T₃]) (c := ![c₀, c₁, c₂, c₃]) hr₀
    (fun r hr0 hr => by
      rw [hU r hr0 hr]; ext z
      simp only [mem_iUnion, mem_union, Fin.exists_fin_succ, IsEmpty.exists_iff, or_false, Matrix.cons_val_zero,
        Matrix.cons_val_succ]
      tauto)
    (fun i => by fin_cases i <;> assumption) (fun i => by fin_cases i <;> assumption)
    (fun i j hij => by
      fin_cases i <;> fin_cases j <;> first | exact absurd rfl hij | assumption | exact Disjoint.symm (by assumption))
    (fun i => by fin_cases i <;> assumption) (fun i => by fin_cases i <;> assumption)
    (fun i j h => by fin_cases i <;> fin_cases j <;> simp_all [eq_comm])
  have hr : range ![c₀, c₁, c₂, c₃] = {c₀, c₁, c₂, c₃} := by
    ext j
    simp only [mem_range, Fin.exists_fin_succ, IsEmpty.exists_iff, or_false, Matrix.cons_val_zero, Matrix.cons_val_succ,
      mem_insert_iff, mem_singleton_iff]
    constructor <;> rintro (h | h | h | h) <;> subst h <;> simp
  refine ⟨h1.trans hr, ?_⟩
  rw [h1]
  rintro _ ⟨i, rfl⟩
  exact h2 i

/-- A point is in the closure of a set holding `v + t d` for all small `t > 0`. -/
theorem mem_closure_of_ray {T : Set ℂ} {v d : ℂ} {δ : ℝ} (hδ : 0 < δ) (h : ∀ t : ℝ, 0 < t → t < δ → v + t * d ∈ T) :
    v ∈ closure T := by
  rw [Metric.mem_closure_iff]
  intro ε hε
  have hd : 0 < 2 * (‖d‖ + 1) := by positivity
  set t := min (δ / 2) (ε / (2 * (‖d‖ + 1))) with ht
  have ht0 : 0 < t := lt_min (by linarith) (div_pos hε hd)
  refine ⟨v + t * d, h t ht0 (lt_of_le_of_lt (min_le_left _ _) (by linarith)), ?_⟩
  rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]
  have h1 : t ≤ ε / (2 * (‖d‖ + 1)) := min_le_right _ _
  have h2 : t * ‖d‖ ≤ ε / (2 * (‖d‖ + 1)) * ‖d‖ := mul_le_mul_of_nonneg_right h1 (norm_nonneg _)
  have h3 : ε / (2 * (‖d‖ + 1)) * ‖d‖ < ε := by
    rw [div_mul_eq_mul_div, div_lt_iff₀ hd]; nlinarith [norm_nonneg d]
  linarith

/-- The tiles at `i` and `−i` are convex: each is cut out by a disc and half-planes, or by half-planes. -/
theorem convex_bowtie_tiles : Convex ℝ bowtieG ∧ Convex ℝ bowtieH ∧ Convex ℝ bowtieCN ∧ Convex ℝ bowtieCS ∧
    ∀ σ, Convex ℝ (bowtieX σ) ∧ Convex ℝ (bowtieY σ) := by
  have ha1 : ∀ z : ℂ, z.re ≤ |z.re| := fun z => le_abs_self _
  have ha2 : ∀ z : ℂ, -z.re ≤ |z.re| := fun z => neg_le_abs _
  have hab : ∀ z : ℂ, ∀ X : ℝ, 12 * z.re < X → -12 * z.re < X → 12 * |z.re| < X := fun z X h1 h2 => by
    rcases abs_cases z.re with ⟨h, -⟩ | ⟨h, -⟩ <;> rw [h] <;> linarith
  have hab' : ∀ z : ℂ, ∀ X : ℝ, z.re < X → -z.re < X → |z.re| < X := fun z X h1 h2 => by
    rcases abs_cases z.re with ⟨h, -⟩ | ⟨h, -⟩ <;> rw [h] <;> linarith
  refine ⟨?_, ?_, ?_, ?_, fun σ => ⟨?_, ?_⟩⟩
  · have : bowtieG = ball I 1 ∩ ({z : ℂ | 0 * z.re + 1 * z.im < 1} ∩
        ({z | 12 * z.re + 5 * z.im < 5} ∩ {z | -12 * z.re + 5 * z.im < 5})) := by
      ext z
      simp only [bowtieG, mem_setOf_eq, mem_inter_iff, mem_ball, dist_eq_norm]
      constructor
      · rintro ⟨h1, h2, h3⟩; exact ⟨h1, by linarith, by linarith [ha1 z], by linarith [ha2 z]⟩
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨h1, by linarith, hab z _ (by linarith) (by linarith)⟩
    rw [this]
    exact (convex_ball _ _).inter ((convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _)))
  · have : bowtieH = ball (-I) 1 ∩ ({z : ℂ | 0 * z.re + -1 * z.im < 1} ∩
        ({z | 12 * z.re + -5 * z.im < 5} ∩ {z | -12 * z.re + -5 * z.im < 5})) := by
      ext z
      simp only [bowtieH, mem_setOf_eq, mem_inter_iff, mem_ball, dist_eq_norm, sub_neg_eq_add]
      constructor
      · rintro ⟨h1, h2, h3⟩; exact ⟨h1, by linarith, by linarith [ha1 z], by linarith [ha2 z]⟩
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨h1, by linarith, hab z _ (by linarith) (by linarith)⟩
    rw [this]
    exact (convex_ball _ _).inter ((convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _)))
  · have : bowtieCN = {z : ℂ | 1 * z.re + -1 * z.im < -1} ∩ ({z | -1 * z.re + -1 * z.im < -1} ∩ {z | 0 * z.re + 1 * z.im < 7 / 5}) := by
      ext z
      simp only [bowtieCN, mem_setOf_eq, mem_inter_iff]
      constructor
      · rintro ⟨h1, h2⟩; exact ⟨by linarith [ha1 z], by linarith [ha2 z], by linarith⟩
      · rintro ⟨h1, h2, h3⟩; exact ⟨hab' z _ (by linarith) (by linarith), by linarith⟩
    rw [this]
    exact (convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _))
  · have : bowtieCS = {z : ℂ | 1 * z.re + 1 * z.im < -1} ∩ ({z | -1 * z.re + 1 * z.im < -1} ∩ {z | 0 * z.re + -1 * z.im < 7 / 5}) := by
      ext z
      simp only [bowtieCS, mem_setOf_eq, mem_inter_iff]
      constructor
      · rintro ⟨h1, h2⟩; exact ⟨by linarith [ha1 z], by linarith [ha2 z], by linarith⟩
      · rintro ⟨h1, h2, h3⟩; exact ⟨hab' z _ (by linarith) (by linarith), by linarith⟩
    rw [this]
    exact (convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _))
  · have : bowtieX σ = {z : ℂ | (-12 * σ) * z.re + -5 * z.im < -5} ∩ ({z | -σ * z.re + 1 * z.im < 1} ∩
        ({z | σ * z.re + 0 * z.im < 2 / 5} ∩ {z | 0 * z.re + -1 * z.im < -41 / 65})) := by
      ext z
      simp only [bowtieX, mem_setOf_eq, mem_inter_iff]
      constructor
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨by linarith, by linarith, by linarith, by linarith⟩
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨by linarith, by linarith, by linarith, by linarith⟩
    rw [this]
    exact (convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _)))
  · have : bowtieY σ = {z : ℂ | (-12 * σ) * z.re + 5 * z.im < -5} ∩ ({z | -σ * z.re + -1 * z.im < 1} ∩
        ({z | σ * z.re + 0 * z.im < 2 / 5} ∩ {z | 0 * z.re + 1 * z.im < -41 / 65})) := by
      ext z
      simp only [bowtieY, mem_setOf_eq, mem_inter_iff]
      constructor
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨by linarith, by linarith, by linarith, by linarith⟩
      · rintro ⟨h1, h2, h3, h4⟩; exact ⟨by linarith, by linarith, by linarith, by linarith⟩
    rw [this]
    exact (convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter ((convex_halfPlane _ _ _).inter (convex_halfPlane _ _ _)))

/-- **The bowtie at `N = i`**: for `r ≤ 1/10` its interior points in `B(i, r)` are those of `G`, `CN`, `XR`, `XL`. -/
theorem bowtie_partition_I {r : ℝ} (hr : r ≤ 1 / 10) :
    bowtie.interiorPts ∩ ball I r = bowtieG ∩ ball I r ∪ bowtieCN ∩ ball I r ∪ bowtieX 1 ∩ ball I r ∪ bowtieX (-1) ∩ ball I r := by
  obtain ⟨tG, -, tCN, -, tX1, tXm, -, -⟩ := subset_bowtieTiles
  ext z
  simp only [mem_inter_iff, mem_union]
  constructor
  · rintro ⟨hzI, hzb⟩
    have hb : ‖z - I‖ < 1 / 10 := by rw [mem_ball, dist_eq_norm] at hzb; linarith
    have hi : |z.im - 1| < 1 / 10 := by
      have := Complex.abs_im_le_norm (z - I); simp only [Complex.sub_im, Complex.I_im] at this; linarith
    have hi' := abs_lt.mp hi
    rcases bowtie_interiorPts_cases hzI with h | h | h | h | h | h | h | h | h | h | h
    · exact Or.inl (Or.inl (Or.inl ⟨h, hzb⟩))
    · exfalso; linarith [(abs_lt.mp h.2.2.1).2]
    · exact Or.inl (Or.inl (Or.inr ⟨h, hzb⟩))
    · exfalso; linarith [h.1, abs_nonneg z.re]
    · exfalso
      have := Complex.abs_im_le_norm (z + I); simp only [Complex.add_im, Complex.I_im] at this
      linarith [h.1, (abs_le.mp this).2]
    · exact Or.inl (Or.inr ⟨h, hzb⟩)
    · exfalso; linarith [h.2.2.2]
    · exact Or.inr ⟨h, hzb⟩
    · exfalso; linarith [h.2.2.2]
    · exfalso; linarith [(abs_le.mp (show |z.im| ≤ 11 / 65 from (closure_bowtieZ_subset (Or.inl rfl) h).2)).2]
    · exfalso; linarith [(abs_le.mp (show |z.im| ≤ 11 / 65 from (closure_bowtieZ_subset (Or.inr rfl) h).2)).2]
  · have ha1 := le_abs_self z.re
    have ha2 := neg_le_abs z.re
    rintro (((⟨h, hzb⟩ | ⟨h, hzb⟩) | ⟨h, hzb⟩) | ⟨h, hzb⟩) <;>
      have hb : ‖z - I‖ < 1 / 10 := (by rw [mem_ball, dist_eq_norm] at hzb; linarith)
    · refine ⟨⟨subset_bowtie_dom isOpen_bowtieG tG h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3⟩ := h
      rcases mem_bowtieArcs_near_I hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom isOpen_bowtieCN tCN h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2⟩ := h
      rcases mem_bowtieArcs_near_I hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom (isOpen_bowtieX 1) tX1 h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3, g4⟩ := h
      rcases mem_bowtieArcs_near_I hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom (isOpen_bowtieX (-1)) tXm h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3, g4⟩ := h
      rcases mem_bowtieArcs_near_I hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith

/-- **The bowtie at `S′ = −i`**: for `r ≤ 1/10` its interior points in `B(−i, r)` are those of `H`, `CS`, `YR`, `YL`. -/
theorem bowtie_partition_negI {r : ℝ} (hr : r ≤ 1 / 10) :
    bowtie.interiorPts ∩ ball (-I) r =
      bowtieH ∩ ball (-I) r ∪ bowtieCS ∩ ball (-I) r ∪ bowtieY 1 ∩ ball (-I) r ∪ bowtieY (-1) ∩ ball (-I) r := by
  obtain ⟨-, tH, -, tCS, -, -, tY1, tYm⟩ := subset_bowtieTiles
  ext z
  simp only [mem_inter_iff, mem_union]
  constructor
  · rintro ⟨hzI, hzb⟩
    have hb : ‖z + I‖ < 1 / 10 := by rw [mem_ball, dist_eq_norm, sub_neg_eq_add] at hzb; linarith
    have hi : |z.im + 1| < 1 / 10 := by
      have := Complex.abs_im_le_norm (z + I); simp only [Complex.add_im, Complex.I_im] at this; linarith
    have hi' := abs_lt.mp hi
    rcases bowtie_interiorPts_cases hzI with h | h | h | h | h | h | h | h | h | h | h
    · exfalso
      have := Complex.abs_im_le_norm (z - I); simp only [Complex.sub_im, Complex.I_im] at this
      linarith [h.1, (abs_le.mp this).1]
    · exfalso; linarith [(abs_lt.mp h.2.2.1).1]
    · exfalso; linarith [h.1, abs_nonneg z.re]
    · exact Or.inl (Or.inl (Or.inr ⟨h, hzb⟩))
    · exact Or.inl (Or.inl (Or.inl ⟨h, hzb⟩))
    · exfalso; linarith [h.2.2.2]
    · exact Or.inl (Or.inr ⟨h, hzb⟩)
    · exfalso; linarith [h.2.2.2]
    · exact Or.inr ⟨h, hzb⟩
    · exfalso; linarith [(abs_le.mp (show |z.im| ≤ 11 / 65 from (closure_bowtieZ_subset (Or.inl rfl) h).2)).1]
    · exfalso; linarith [(abs_le.mp (show |z.im| ≤ 11 / 65 from (closure_bowtieZ_subset (Or.inr rfl) h).2)).1]
  · have ha1 := le_abs_self z.re
    have ha2 := neg_le_abs z.re
    rintro (((⟨h, hzb⟩ | ⟨h, hzb⟩) | ⟨h, hzb⟩) | ⟨h, hzb⟩) <;>
      have hb : ‖z + I‖ < 1 / 10 := (by rw [mem_ball, dist_eq_norm, sub_neg_eq_add] at hzb; linarith)
    · refine ⟨⟨subset_bowtie_dom isOpen_bowtieH tH h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3⟩ := h
      rcases mem_bowtieArcs_near_negI hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom isOpen_bowtieCS tCS h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2⟩ := h
      rcases mem_bowtieArcs_near_negI hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom (isOpen_bowtieY 1) tY1 h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3, g4⟩ := h
      rcases mem_bowtieArcs_near_negI hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith
    · refine ⟨⟨subset_bowtie_dom (isOpen_bowtieY (-1)) tYm h, fun hA => ?_⟩, hzb⟩
      obtain ⟨g1, g2, g3, g4⟩ := h
      rcases mem_bowtieArcs_near_negI hb hA with ⟨e1, e2, e3⟩ | ⟨e1, e2, e3⟩ | ⟨e1, e2⟩ | ⟨e1, e2⟩ <;> linarith

/-- **Both neighbours four-coloured, one sector per colour**: `P_cl(N) = {0, 1, 3, 4}`, `P_cl(S) = {2, 1, 3, 4}`. -/
theorem bowtie_neighbours : bowtie.coloursAt I = {0, 1, 3, 4} ∧ bowtie.coloursAt (-I) = {2, 1, 3, 4} ∧
    (∀ c ∈ bowtie.coloursAt I, bowtie.HasSectors I c 1) ∧ ∀ c ∈ bowtie.coloursAt (-I), bowtie.HasSectors (-I) c 1 := by
  obtain ⟨cG, cH, cCN, cCS, cXY⟩ := convex_bowtie_tiles
  have dj : ∀ {A B : Set ℂ}, (∀ z, z ∈ A → z ∈ B → False) → Disjoint A B := fun h => Set.disjoint_left.mpr fun z ha hb => h z ha hb
  have hn : ∀ t : ℝ, ‖(t : ℂ) * I‖ = |t| := fun t => by rw [norm_mul, Complex.norm_I, mul_one, Complex.norm_real, Real.norm_eq_abs]
  obtain ⟨h1, h2⟩ := coloursAt_hasSectors_of_four_tiles (F := bowtie) (v := I) (r₀ := 1 / 10) (by norm_num)
    (c₀ := 0) (c₁ := 1) (c₂ := 3) (c₃ := 4) (fun r _ hr => bowtie_partition_I hr)
    isOpen_bowtieG isOpen_bowtieCN (isOpen_bowtieX 1) (isOpen_bowtieX (-1)) cG cCN (cXY 1).1 (cXY (-1)).1
    (dj fun z ⟨_, g2, _⟩ ⟨c1, _⟩ => by linarith [abs_nonneg z.re])
    (dj fun z ⟨_, _, g3⟩ ⟨x1, _, _, _⟩ => by linarith [le_abs_self z.re])
    (dj fun z ⟨_, _, g3⟩ ⟨x1, _, _, _⟩ => by linarith [neg_le_abs z.re])
    (dj fun z ⟨c1, _⟩ ⟨_, x2, _, _⟩ => by linarith [le_abs_self z.re])
    (dj fun z ⟨c1, _⟩ ⟨_, x2, _, _⟩ => by linarith [neg_le_abs z.re])
    (dj fun z ⟨x1, x2, _, _⟩ ⟨y1, y2, _, _⟩ => by linarith)
    (mem_closure_of_ray (d := -I) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 => ⟨by
        rw [show I + (t : ℂ) * -I - I = ((-t : ℝ) : ℂ) * I by push_cast; ring, hn, abs_neg, abs_of_pos ht0]; linarith,
      by simp; linarith, by simp; linarith⟩)
    (mem_closure_of_ray (d := I) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 => ⟨by simp; linarith, by simp; linarith⟩)
    (mem_closure_of_ray (d := 1) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 =>
      ⟨by simp; linarith, by simp; linarith, by simp; linarith, by simp; norm_num⟩)
    (mem_closure_of_ray (d := -1) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 =>
      ⟨by simp; linarith, by simp; linarith, by simp; linarith, by simp; norm_num⟩)
    (fun z hz => bowtieCol_of_mem_G hz) (fun z hz => bowtieCol_of_mem_CN_CS (Or.inl hz))
    (fun z hz => bowtieCol_of_mem_XY.1 (Or.inl hz)) (fun z hz => bowtieCol_of_mem_XY.2 (Or.inl hz))
    (by decide) (by decide) (by decide) (by decide) (by decide) (by decide)
  obtain ⟨h3, h4⟩ := coloursAt_hasSectors_of_four_tiles (F := bowtie) (v := -I) (r₀ := 1 / 10) (by norm_num)
    (c₀ := 2) (c₁ := 1) (c₂ := 3) (c₃ := 4) (fun r _ hr => bowtie_partition_negI hr)
    isOpen_bowtieH isOpen_bowtieCS (isOpen_bowtieY 1) (isOpen_bowtieY (-1)) cH cCS (cXY 1).2 (cXY (-1)).2
    (dj fun z ⟨_, g2, _⟩ ⟨c1, _⟩ => by linarith [abs_nonneg z.re])
    (dj fun z ⟨_, _, g3⟩ ⟨x1, _, _, _⟩ => by linarith [le_abs_self z.re])
    (dj fun z ⟨_, _, g3⟩ ⟨x1, _, _, _⟩ => by linarith [neg_le_abs z.re])
    (dj fun z ⟨c1, _⟩ ⟨_, x2, _, _⟩ => by linarith [le_abs_self z.re])
    (dj fun z ⟨c1, _⟩ ⟨_, x2, _, _⟩ => by linarith [neg_le_abs z.re])
    (dj fun z ⟨x1, x2, _, _⟩ ⟨y1, y2, _, _⟩ => by linarith)
    (mem_closure_of_ray (d := I) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 => ⟨by
        rw [show -I + (t : ℂ) * I + I = ((t : ℝ) : ℂ) * I by ring, hn, abs_of_pos ht0]; linarith,
      by simp; linarith, by simp; linarith⟩)
    (mem_closure_of_ray (d := -I) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 => ⟨by simp; linarith, by simp; linarith⟩)
    (mem_closure_of_ray (d := 1) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 =>
      ⟨by simp; linarith, by simp; linarith, by simp; linarith, by simp; norm_num⟩)
    (mem_closure_of_ray (d := -1) (δ := 1 / 20) (by norm_num) fun t ht0 ht1 =>
      ⟨by simp; linarith, by simp; linarith, by simp; linarith, by simp; norm_num⟩)
    (fun z hz => bowtieCol_of_mem_H hz) (fun z hz => bowtieCol_of_mem_CN_CS (Or.inr hz))
    (fun z hz => bowtieCol_of_mem_XY.1 (Or.inr hz)) (fun z hz => bowtieCol_of_mem_XY.2 (Or.inr hz))
    (by decide) (by decide) (by decide) (by decide) (by decide) (by decide)
  exact ⟨h1, h3, h2, h4⟩

/-- Below an arc of curvature `κ` and above one of curvature `κ' ≥ κ`, through the same point with the same tangent: impossible. -/
theorem tanBelow_tanAbove_false {v : ℂ} {α κ κ' : ℝ} (hκ : κ ≤ κ') {z : ℂ} (h1 : TanBelow v α κ z) (h2 : TanAbove v α κ' z) :
    False := by
  unfold TanBelow TanAbove tanHeight at *
  nlinarith [sq_nonneg (frameX v α z), sq_nonneg (frameY v α z)]

/-- The frame coordinates of a point of the ray from `v` along `d`. -/
theorem frame_ray (v : ℂ) (α t : ℝ) (d : ℂ) :
    frameX v α (v + t * d) = t * (d * starRingEnd ℂ (e α)).re ∧ frameY v α (v + t * d) = t * (d * starRingEnd ℂ (e α)).im := by
  have : (v + (t : ℂ) * d - v) * starRingEnd ℂ (e α) = (t : ℂ) * (d * starRingEnd ℂ (e α)) := by ring
  unfold frameX frameY
  rw [this, Complex.re_ofReal_mul, Complex.im_ofReal_mul]
  exact ⟨rfl, rfl⟩

/-- **A ray off a horn's axis leaves every horn set near the vertex**: if `d` is not along `±e α`, the points `v + t d` lie in no
horn set at `v` along `e α`, for every small `t > 0` (a horn is tangent to its axis). -/
theorem eventually_ray_not_mem_hornSet (v : ℂ) (α κ₁ κ₂ : ℝ) {d : ℂ} (hd : (d * starRingEnd ℂ (e α)).im ≠ 0) :
    ∀ᶠ t : ℝ in 𝓝[>] (0 : ℝ), ∀ r, v + (t : ℂ) * d ∉ hornSet v α κ₁ κ₂ r := by
  set u := d * starRingEnd ℂ (e α) with hu
  set a := u.im
  set N := u.re ^ 2 + u.im ^ 2
  have hN : 0 ≤ N := by positivity
  set M := (|κ₁| + |κ₂|) * N + 1
  have hM : 0 < M := by positivity
  have ha : 0 < |a| := abs_pos.mpr hd
  filter_upwards [Ioo_mem_nhdsGT (show 0 < |a| / M by positivity)] with t ⟨ht0, ht1⟩ r hmem
  obtain ⟨-, -, hA, hB⟩ := hmem
  obtain ⟨hx, hy⟩ := frame_ray v α t d
  unfold TanAbove tanHeight at hA
  unfold TanBelow tanHeight at hB
  rw [hx, hy] at hA hB
  have hsq : (t * u.re) ^ 2 + (t * u.im) ^ 2 = t ^ 2 * N := by ring
  rw [hsq] at hA hB
  have htM : t * M < |a| := by rwa [lt_div_iff₀ hM] at ht1
  have hk1 : |κ₁| * (t * N) ≤ t * M := by
    have : |κ₁| * N ≤ M := by nlinarith [abs_nonneg κ₂, abs_nonneg κ₁]
    nlinarith
  have hk2 : |κ₂| * (t * N) ≤ t * M := by
    have : |κ₂| * N ≤ M := by nlinarith [abs_nonneg κ₂, abs_nonneg κ₁]
    nlinarith
  -- from `hA`, `hB` divided by `t > 0`: `κ₁ t N / 2 < a < κ₂ t N / 2`
  have hA' : κ₁ * (t * N) / 2 < a := by nlinarith
  have hB' : a < κ₂ * (t * N) / 2 := by nlinarith
  have h1 := neg_abs_le κ₁
  have h2 := le_abs_self κ₂
  have htN : 0 ≤ t * N := by positivity
  rcases lt_or_gt_of_ne hd with hneg | hpos
  · rw [abs_of_neg hneg] at htM
    nlinarith
  · rw [abs_of_pos hpos] at htM
    nlinarith

/-- **Two rays from `v` that are not parallel are never both in a horn set at `v`**, near `v`. -/
theorem eventually_not_two_rays_hornSet (v : ℂ) (α κ₁ κ₂ : ℝ) {d₁ d₂ : ℂ} (h : (d₁ * starRingEnd ℂ d₂).im ≠ 0) :
    ∀ᶠ t : ℝ in 𝓝[>] (0 : ℝ), ∀ r, ¬ (v + (t : ℂ) * d₁ ∈ hornSet v α κ₁ κ₂ r ∧ v + (t : ℂ) * d₂ ∈ hornSet v α κ₁ κ₂ r) := by
  by_cases h1 : (d₁ * starRingEnd ℂ (e α)).im = 0
  · by_cases h2 : (d₂ * starRingEnd ℂ (e α)).im = 0
    · exfalso
      apply h
      have hd : d₁ * starRingEnd ℂ d₂ = (d₁ * starRingEnd ℂ (e α)) * starRingEnd ℂ (d₂ * starRingEnd ℂ (e α)) := by
        rw [map_mul, Complex.conj_conj]
        calc d₁ * starRingEnd ℂ d₂ = d₁ * starRingEnd ℂ d₂ * (e α * starRingEnd ℂ (e α)) := by rw [conj_e_mul_e, mul_one]
          _ = _ := by ring
      rw [hd, Complex.mul_im, Complex.conj_re, Complex.conj_im, h1, h2]; ring
    · filter_upwards [eventually_ray_not_mem_hornSet v α κ₁ κ₂ h2] with t ht r hr
      exact ht r hr.2
  · filter_upwards [eventually_ray_not_mem_hornSet v α κ₁ κ₂ h1] with t ht r hr
    exact ht r hr.1

/-- **A horn set holding a whole unit ray from `v` points along it**: `e α = d`. -/
theorem eq_e_of_ray_subset_hornSet {v d : ℂ} (hd : ‖d‖ = 1) {α κ₁ κ₂ δ r : ℝ} (hδ : 0 < δ)
    (h : ∀ t : ℝ, 0 < t → t < δ → v + (t : ℂ) * d ∈ hornSet v α κ₁ κ₂ r) : e α = d := by
  set u := d * starRingEnd ℂ (e α) with hu
  have him : u.im = 0 := by
    by_contra hne
    obtain ⟨t, ht, ht0⟩ := ((eventually_ray_not_mem_hornSet v α κ₁ κ₂ hne).and (Ioo_mem_nhdsGT hδ)).exists
    exact ht r (h t ht0.1 ht0.2)
  have hre : 0 < u.re := by
    have hm := (h (δ / 2) (by linarith) (by linarith)).2.1
    rw [(frame_ray v α (δ / 2) d).1] at hm
    exact pos_of_mul_pos_right hm (by linarith)
  have hnorm : ‖u‖ = 1 := by rw [hu, norm_mul, Complex.norm_conj, norm_e, hd, mul_one]
  have hsq : u.re ^ 2 + u.im ^ 2 = 1 := by
    have := Complex.sq_norm u
    rw [hnorm, Complex.normSq_apply] at this
    nlinarith
  rw [him] at hsq
  have hre1 : u.re = 1 := by nlinarith
  have hu1 : u = 1 := Complex.ext (by simp [hre1]) (by simp [him])
  calc e α = u * e α := by rw [hu1, one_mul]
    _ = d * (e α * starRingEnd ℂ (e α)) := by rw [hu]; ring
    _ = d := by rw [conj_e_mul_e, mul_one]

section Sectors

variable {k : ℕ} {F : ArcMap k}

/-- A sector lies among the interior points of its ball. -/
theorem IsSector.subset {v : ℂ} {r : ℝ} {S : Set ℂ} (hS : F.IsSector v r S) : S ⊆ F.interiorPts ∩ ball v r := by
  obtain ⟨x, -, rfl, -⟩ := hS
  exact connectedComponentIn_subset _ _

/-- A sector is non-empty. -/
theorem IsSector.nonempty {v : ℂ} {r : ℝ} {S : Set ℂ} (hS : F.IsSector v r S) : S.Nonempty := by
  obtain ⟨x, hx, rfl, -⟩ := hS
  exact ⟨x, mem_connectedComponentIn hx⟩

/-- A preconnected set of interior points of the ball meeting a sector lies in it. -/
theorem IsSector.subset_of_isPreconnected {v : ℂ} {r : ℝ} {S A : Set ℂ} (hS : F.IsSector v r S) (hA : IsPreconnected A)
    (hAU : A ⊆ F.interiorPts ∩ ball v r) {a : ℂ} (haA : a ∈ A) (haS : a ∈ S) : A ⊆ S := by
  obtain ⟨x, -, rfl, -⟩ := hS
  rw [connectedComponentIn_eq haS]
  exact hA.subset_connectedComponentIn haA hAU

/-- A point of a ray from `v` within `r` of `v`. -/
theorem ray_mem_ball {v d : ℂ} {t r : ℝ} (ht : 0 < t) (h : t * (|d.re| + |d.im|) < r) : v + (t : ℂ) * d ∈ ball v r := by
  rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht]
  calc t * ‖d‖ ≤ t * (|d.re| + |d.im|) := mul_le_mul_of_nonneg_left (Complex.norm_le_abs_re_add_abs_im d) ht.le
    _ < r := h

/-- **A convex set holding two non-parallel rays from `v` misses every horn set that is a sector at `v`** (its part near `v`
would lie in the sector, a horn being tangent to its axis). -/
theorem IsSector.disjoint_of_rays {v : ℂ} {r α κ₁ κ₂ : ℝ} (hS : F.IsSector v r (hornSet v α κ₁ κ₂ r)) {T : Set ℂ}
    (hT : Convex ℝ T) (hTU : T ∩ ball v r ⊆ F.interiorPts) {d₁ d₂ : ℂ} (hd : (d₁ * starRingEnd ℂ d₂).im ≠ 0) {δ : ℝ}
    (hδ : 0 < δ) (hray : ∀ t : ℝ, 0 < t → t < δ → v + (t : ℂ) * d₁ ∈ T ∧ v + (t : ℂ) * d₂ ∈ T) :
    Disjoint (T ∩ ball v r) (hornSet v α κ₁ κ₂ r) := by
  obtain ⟨x, hx⟩ := hS.nonempty
  have hr : 0 < r := lt_of_le_of_lt dist_nonneg (mem_ball.mp (hS.subset hx).2)
  rw [Set.disjoint_left]
  intro a haA haS
  have hsub := hS.subset_of_isPreconnected (hT.inter (convex_ball v r)).isPreconnected
    (fun z hz => ⟨hTU hz, hz.2⟩) haA haS
  set M := |d₁.re| + |d₁.im| + |d₂.re| + |d₂.im| + 1
  have hM : 0 < M := by positivity
  obtain ⟨t, ht, ht0⟩ := ((eventually_not_two_rays_hornSet v α κ₁ κ₂ hd).and
    (Ioo_mem_nhdsGT (lt_min hδ (div_pos hr hM)))).exists
  have htδ : t < δ := ht0.2.trans_le (min_le_left _ _)
  have htM : t * M < r := by
    have := ht0.2.trans_le (min_le_right _ _); rwa [lt_div_iff₀ hM] at this
  obtain ⟨h1, h2⟩ := hray t ht0.1 htδ
  have hb1 : v + (t : ℂ) * d₁ ∈ ball v r := ray_mem_ball ht0.1 (by
    nlinarith [abs_nonneg d₂.re, abs_nonneg d₂.im, ht0.1])
  have hb2 : v + (t : ℂ) * d₂ ∈ ball v r := ray_mem_ball ht0.1 (by
    nlinarith [abs_nonneg d₁.re, abs_nonneg d₁.im, ht0.1])
  exact ht r ⟨hsub ⟨h1, hb1⟩, hsub ⟨h2, hb2⟩⟩

/-- Two counts of one colour's sectors agree. -/
theorem HasSectors.eq {v : ℂ} {c : Fin k} {n m : ℕ} (hn : F.HasSectors v c n) (hm : F.HasSectors v c m) : n = m := by
  obtain ⟨r, hr⟩ := (hn.and hm).exists
  exact_mod_cast hr.1.symm.trans hr.2

/-- A colour not carried at `v` has no sector there. -/
theorem HasSectors.eq_zero_of_not_mem {v : ℂ} {c : Fin k} {n : ℕ} (hn : F.HasSectors v c n) (hc : c ∉ F.coloursAt v) :
    n = 0 := by
  obtain ⟨r, hr⟩ := hn.exists
  have : F.sectorsOf v r c = ∅ := by
    ext S
    simp only [sectorsOf, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro hS hSc
    apply hc
    obtain ⟨x, hx, hSeq, hvS⟩ := id hS
    exact closure_mono (show S ⊆ F.region c from fun z hz => ⟨(hS.subset hz).1, hSc hz⟩) hvS
  rw [this, encard_empty] at hr
  exact_mod_cast hr.symm

end Sectors

/-! ### The bowtie's moves (FS131-I4g) -/

/-- The coordinates of a point of the ray from `v` along `pt a b`. -/
theorem ray_coords (v : ℂ) (t a b : ℝ) :
    (v + (t : ℂ) * pt a b).re = v.re + t * a ∧ (v + (t : ℂ) * pt a b).im = v.im + t * b := by
  simp [pt]

/-- `Im (pt a b · conj (pt c d)) = b c − a d`. -/
theorem im_pt_mul_conj_pt (a b c d : ℝ) : (pt a b * starRingEnd ℂ (pt c d)).im = b * c - a * d := by
  simp [pt]; ring

/-- A point of the ray from `v` along `pt a b`, for `t (|a| + |b|) < 1`, lies in `B(v, 1)`. -/
theorem norm_ray_sub_lt_one {v : ℂ} {t a b : ℝ} (ht : 0 < t) (h : t * (|a| + |b|) < 1) : ‖v + (t : ℂ) * pt a b - v‖ < 1 := by
  have := ray_mem_ball (v := v) (d := pt a b) (r := 1) ht (by simpa [pt] using h)
  rwa [mem_ball, dist_eq_norm] at this

/-- **No horn at `N = i`**: near `i` the bowtie's sectors are its four angular tiles, each holding two non-parallel rays. -/
theorem bowtie_not_isHorn_I (α κ₁ κ₂ : ℝ) (c : Fin 6) : ¬ bowtie.IsHorn I α κ₁ κ₂ c := by
  rintro ⟨-, hH⟩
  obtain ⟨r, ⟨hsec, -⟩, hr⟩ := (hH.and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num))).exists
  obtain ⟨x, hx⟩ := hsec.nonempty
  have hxU := hsec.subset hx
  have hpart := bowtie_partition_I hr.2
  obtain ⟨cG, -, cCN, -, cXY⟩ := convex_bowtie_tiles
  rw [hpart] at hxU
  have hU : ∀ T : Set ℂ, T ∩ ball I r ⊆ bowtie.interiorPts ∩ ball I r → T ∩ ball I r ⊆ bowtie.interiorPts :=
    fun T h z hz => (h hz).1
  rcases hxU with ((hxT | hxT) | hxT) | hxT
  · refine disjoint_left.mp (hsec.disjoint_of_rays cG (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 0 (-1)) (d₂ := pt (1 / 5) (-1)) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 2) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, |a| + |b| ≤ 2 → b = -1 → 12 * |a| < 5 → I + (t : ℂ) * pt a b ∈ bowtieG := by
      intro a b hab hb ha
      obtain ⟨hre, him⟩ := ray_coords I t a b
      refine ⟨norm_ray_sub_lt_one ht0 (by nlinarith), ?_, ?_⟩
      · rw [him, hb]; simp; linarith
      · rw [hre, him, hb]; simp only [Complex.I_re, Complex.I_im, zero_add, abs_mul, abs_of_pos ht0]; nlinarith
    exact ⟨hm 0 (-1) (by norm_num) rfl (by norm_num), hm (1 / 5) (-1) (by norm_num [abs_of_pos]) rfl (by norm_num [abs_of_pos])⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays cCN (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 0 1) (d₂ := pt 1 2) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, |a| < b → b ≤ 2 → I + (t : ℂ) * pt a b ∈ bowtieCN := by
      intro a b hab hb
      obtain ⟨hre, him⟩ := ray_coords I t a b
      refine ⟨?_, ?_⟩
      · rw [hre, him]; simp only [Complex.I_re, Complex.I_im, zero_add, abs_mul, abs_of_pos ht0]; nlinarith
      · rw [him]; simp; nlinarith
    exact ⟨hm 0 1 (by norm_num) (by norm_num), hm 1 2 (by norm_num) le_rfl⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays (cXY 1).1 (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 1 0) (d₂ := pt 2 1) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, 0 ≤ b → b < a → a ≤ 2 → I + (t : ℂ) * pt a b ∈ bowtieX 1 := by
      intro a b hb hab ha
      obtain ⟨hre, him⟩ := ray_coords I t a b
      refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [hre, him, Complex.I_re, Complex.I_im] <;> nlinarith
    exact ⟨hm 1 0 le_rfl (by norm_num) (by norm_num), hm 2 1 (by norm_num) (by norm_num) le_rfl⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays (cXY (-1)).1 (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt (-1) 0) (d₂ := pt (-2) 1) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, 0 ≤ b → b < -a → -a ≤ 2 → I + (t : ℂ) * pt a b ∈ bowtieX (-1) := by
      intro a b hb hab ha
      obtain ⟨hre, him⟩ := ray_coords I t a b
      refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [hre, him, Complex.I_re, Complex.I_im] <;> nlinarith
    exact ⟨hm (-1) 0 le_rfl (by norm_num) (by norm_num), hm (-2) 1 (by norm_num) (by norm_num) (by norm_num)⟩

/-- **No horn at `S′ = −i`**, the mirror. -/
theorem bowtie_not_isHorn_negI (α κ₁ κ₂ : ℝ) (c : Fin 6) : ¬ bowtie.IsHorn (-I) α κ₁ κ₂ c := by
  rintro ⟨-, hH⟩
  obtain ⟨r, ⟨hsec, -⟩, hr⟩ := (hH.and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 10 by norm_num))).exists
  obtain ⟨x, hx⟩ := hsec.nonempty
  have hxU := hsec.subset hx
  have hpart := bowtie_partition_negI hr.2
  obtain ⟨-, cH, -, cCS, cXY⟩ := convex_bowtie_tiles
  rw [hpart] at hxU
  have hU : ∀ T : Set ℂ, T ∩ ball (-I) r ⊆ bowtie.interiorPts ∩ ball (-I) r → T ∩ ball (-I) r ⊆ bowtie.interiorPts :=
    fun T h z hz => (h hz).1
  rcases hxU with ((hxT | hxT) | hxT) | hxT
  · refine disjoint_left.mp (hsec.disjoint_of_rays cH (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 0 1) (d₂ := pt (1 / 5) 1) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 2) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, |a| + |b| ≤ 2 → b = 1 → 12 * |a| < 5 → -I + (t : ℂ) * pt a b ∈ bowtieH := by
      intro a b hab hb ha
      obtain ⟨hre, him⟩ := ray_coords (-I) t a b
      refine ⟨?_, ?_, ?_⟩
      · have := norm_ray_sub_lt_one (v := -I) ht0 (show t * (|a| + |b|) < 1 by nlinarith)
        rwa [sub_neg_eq_add] at this
      · rw [him, hb]; simp; linarith
      · rw [hre, him, hb]; simp only [Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im, neg_zero, zero_add,
          abs_mul, abs_of_pos ht0]; nlinarith
    exact ⟨hm 0 1 (by norm_num) rfl (by norm_num), hm (1 / 5) 1 (by norm_num [abs_of_pos]) rfl (by norm_num [abs_of_pos])⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays cCS (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 0 (-1)) (d₂ := pt 1 (-2)) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, |a| < -b → -b ≤ 2 → -I + (t : ℂ) * pt a b ∈ bowtieCS := by
      intro a b hab hb
      obtain ⟨hre, him⟩ := ray_coords (-I) t a b
      refine ⟨?_, ?_⟩
      · rw [hre, him]; simp only [Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im, neg_zero, zero_add, abs_mul,
          abs_of_pos ht0]; nlinarith
      · rw [him]; simp; nlinarith
    exact ⟨hm 0 (-1) (by norm_num) (by norm_num), hm 1 (-2) (by norm_num) (by norm_num)⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays (cXY 1).2 (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt 1 0) (d₂ := pt 2 (-1)) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, 0 ≤ -b → -b < a → a ≤ 2 → -I + (t : ℂ) * pt a b ∈ bowtieY 1 := by
      intro a b hb hab ha
      obtain ⟨hre, him⟩ := ray_coords (-I) t a b
      refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [hre, him, Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im] <;>
        nlinarith
    exact ⟨hm 1 0 (by norm_num) (by norm_num) (by norm_num), hm 2 (-1) (by norm_num) (by norm_num) le_rfl⟩
  · refine disjoint_left.mp (hsec.disjoint_of_rays (cXY (-1)).2 (hU _ (by rw [hpart]; intro z hz; simp [hz]))
      (d₁ := pt (-1) 0) (d₂ := pt (-2) (-1)) (by rw [im_pt_mul_conj_pt]; norm_num) (δ := 1 / 5) (by norm_num) ?_) hxT hx
    intro t ht0 ht1
    have hm : ∀ a b : ℝ, 0 ≤ -b → -b < -a → -a ≤ 2 → -I + (t : ℂ) * pt a b ∈ bowtieY (-1) := by
      intro a b hb hab ha
      obtain ⟨hre, him⟩ := ray_coords (-I) t a b
      refine ⟨?_, ?_, ?_, ?_⟩ <;> simp only [hre, him, Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im] <;>
        nlinarith
    exact ⟨hm (-1) 0 (by norm_num) (by norm_num) (by norm_num), hm (-2) (-1) (by norm_num) (by norm_num) (by norm_num)⟩

/-- **A horn of the bowtie at `E = 0`** is one of the two cusp horns: its set holds the cusp's right horn and its axis is `e α = 1`,
or the left horn and `e α = −1`; and every point of it lies outside both `ω(i)` and `ω(−i)` (the disc parts hold two
non-parallel rays each, so no horn set meets them). -/
theorem bowtie_hornSet_zero {α κ₁ κ₂ r : ℝ} (hr : r ≤ 1 / 13) (hS : bowtie.IsSector 0 r (hornSet 0 α κ₁ κ₂ r)) :
    ((e α = 1 ∧ cuspPiece r 0 ⊆ hornSet 0 α κ₁ κ₂ r) ∨ (e α = -1 ∧ cuspPiece r 1 ⊆ hornSet 0 α κ₁ κ₂ r)) ∧
      ∀ z ∈ hornSet 0 α κ₁ κ₂ r, 1 < ‖z - I‖ ∧ 1 < ‖z + I‖ := by
  obtain ⟨x, hx⟩ := hS.nonempty
  have hr0 : 0 < r := lt_of_le_of_lt dist_nonneg (mem_ball.mp (hS.subset hx).2)
  have hpart := bowtie_partition hr
  obtain ⟨-, hpre, -, -, -⟩ := cuspPiece_data hr0 (by linarith)
  have hpU : ∀ i, cuspPiece r i ⊆ bowtie.interiorPts ∩ ball 0 r := fun i => by
    rw [hpart]; exact subset_iUnion (fun i => cuspPiece r i) i
  -- the disc parts miss the horn set
  have hsq : ∀ w : ℂ, ‖w‖ ^ 2 < 1 → ‖w‖ < 1 := fun w h => (sq_lt_one_iff₀ (norm_nonneg w)).mp h
  have hd2 : Disjoint (cuspPiece r 2) (hornSet 0 α κ₁ κ₂ r) := by
    have h := hS.disjoint_of_rays (convex_ball I 1) (T := ball I 1) (d₁ := pt 0 1) (d₂ := pt 1 2)
      (fun z hz => (hpU 2 (show z ∈ ball 0 r ∩ ball I 1 from ⟨hz.2, hz.1⟩)).1) (by rw [im_pt_mul_conj_pt]; norm_num)
      (δ := 1 / 2) (by norm_num) (fun t ht0 ht1 => by
        obtain ⟨a1, b1⟩ := ray_coords 0 t 0 1
        obtain ⟨a2, b2⟩ := ray_coords 0 t 1 2
        refine ⟨?_, ?_⟩ <;> rw [mem_ball, dist_eq_norm] <;> refine hsq _ ?_ <;> rw [norm_sub_I_sq]
        · rw [a1, b1]; simp only [Complex.zero_re, Complex.zero_im, zero_add, mul_zero]; nlinarith
        · rw [a2, b2]; simp only [Complex.zero_re, Complex.zero_im, zero_add]; nlinarith)
    rwa [inter_comm] at h
  have hd3 : Disjoint (cuspPiece r 3) (hornSet 0 α κ₁ κ₂ r) := by
    have h := hS.disjoint_of_rays (convex_ball (-I) 1) (T := ball (-I) 1) (d₁ := pt 0 (-1)) (d₂ := pt 1 (-2))
      (fun z hz => (hpU 3 (show z ∈ ball 0 r ∩ ball (-I) 1 from ⟨hz.2, hz.1⟩)).1) (by rw [im_pt_mul_conj_pt]; norm_num)
      (δ := 1 / 2) (by norm_num) (fun t ht0 ht1 => by
        obtain ⟨a1, b1⟩ := ray_coords 0 t 0 (-1)
        obtain ⟨a2, b2⟩ := ray_coords 0 t 1 (-2)
        refine ⟨?_, ?_⟩ <;> rw [mem_ball, dist_eq_norm, sub_neg_eq_add] <;> refine hsq _ ?_ <;> rw [norm_add_I_sq]
        · rw [a1, b1]; simp only [Complex.zero_re, Complex.zero_im, zero_add, mul_zero]; nlinarith
        · rw [a2, b2]; simp only [Complex.zero_re, Complex.zero_im, zero_add]; nlinarith)
    rwa [inter_comm] at h
  have hmem : ∀ z ∈ hornSet 0 α κ₁ κ₂ r, z ∈ cuspPiece r 0 ∨ z ∈ cuspPiece r 1 := by
    intro z hz
    have hzU := hS.subset hz
    rw [hpart, mem_iUnion] at hzU
    obtain ⟨i, hi⟩ := hzU
    fin_cases i
    · exact Or.inl hi
    · exact Or.inr hi
    · exact absurd hz (disjoint_left.mp hd2 hi)
    · exact absurd hz (disjoint_left.mp hd3 hi)
  refine ⟨?_, fun z hz => ?_⟩
  · rcases hmem x hx with hx0 | hx1
    · have hsub := hS.subset_of_isPreconnected (hpre 0) (hpU 0) hx0 hx
      refine Or.inl ⟨eq_e_of_ray_subset_hornSet (v := 0) (d := 1) (by simp) hr0 fun t ht0 htr => hsub ?_, hsub⟩
      rw [zero_add, mul_one]
      exact (hornSet_cusp_iff r _).mpr ⟨by rw [Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]; exact htr,
        by simpa using ht0, by
          refine (one_lt_sq_iff₀ (norm_nonneg _)).mp ?_; rw [norm_add_I_sq]; simp; nlinarith, by
          refine (one_lt_sq_iff₀ (norm_nonneg _)).mp ?_; rw [norm_sub_I_sq]; simp; nlinarith⟩
    · have hsub := hS.subset_of_isPreconnected (hpre 1) (hpU 1) hx1 hx
      refine Or.inr ⟨eq_e_of_ray_subset_hornSet (v := 0) (d := -1) (by simp) hr0 fun t ht0 htr => hsub ?_, hsub⟩
      rw [zero_add, mul_neg_one]
      refine mem_cuspPiece_one.mpr ⟨by rw [norm_neg, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ht0]; exact htr,
        by simpa using ht0, ?_, ?_⟩ <;> refine (one_lt_sq_iff₀ (norm_nonneg _)).mp ?_
      · rw [norm_add_I_sq]; simp; nlinarith
      · rw [norm_sub_I_sq]; simp; nlinarith
  · rcases hmem z hz with h0 | h1
    · obtain ⟨-, -, h2, h3⟩ := (hornSet_cusp_iff r z).mp h0
      exact ⟨h3, h2⟩
    · obtain ⟨-, -, h2, h3⟩ := mem_cuspPiece_one.mp h1
      exact ⟨h3, h2⟩

/-- At `E` only the horn colour `1` has two sectors (the disc parts are one sector each, of colours `0` and `2`). -/
theorem bowtie_hasSectors_zero_two {c : Fin 6} {n : ℕ} (hn : bowtie.HasSectors 0 c n) (h2 : 2 ≤ n) : c = 1 := by
  obtain ⟨r, hrn, hr⟩ := (hn.and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 13 by norm_num))).exists
  have hlt : 1 < (bowtie.sectorsOf 0 r c).encard := by rw [hrn]; exact_mod_cast h2
  obtain ⟨S₁, S₂, ⟨hS₁, hc₁⟩, ⟨hS₂, hc₂⟩, hne⟩ := Set.one_lt_encard_iff.mp hlt
  obtain ⟨ho, hp, hd, hnn, hcl⟩ := cuspPiece_data hr.1 (by linarith [hr.2])
  have hpart := bowtie_partition hr.2
  obtain ⟨j₁, rfl⟩ := (isSector_iff_of_partition hpart ho hp hd hnn hcl).mp hS₁
  obtain ⟨j₂, rfl⟩ := (isSector_iff_of_partition hpart ho hp hd hnn hcl).mp hS₂
  have hcol : ∀ j, cuspPiece r j ⊆ bowtie.col ⁻¹' {c} → c = ![1, 1, 0, 2] j := by
    intro j hj
    obtain ⟨z, hz⟩ := hnn j
    have hzc : bowtie.col z = c := hj hz
    have := bowtieCol_cuspPiece hr.2 (z := z)
    fin_cases j
    · exact hzc.symm.trans (this.1 hz)
    · exact hzc.symm.trans (this.2.1 hz)
    · exact hzc.symm.trans (this.2.2.1 hz)
    · exact hzc.symm.trans (this.2.2.2 hz)
  have e1 := hcol j₁ hc₁
  have e2 := hcol j₂ hc₂
  fin_cases j₁ <;> fin_cases j₂ <;> simp_all

/-- A tile of the horn colour `1` lies in `C`, `CN` or `CS` (the three are separated open sets). -/
theorem bowtie_tileOf_one {T : Set ℂ} (hT : bowtie.TileOf 1 T) : T ⊆ bowtieC ∨ T ⊆ bowtieCN ∨ T ⊆ bowtieCS := by
  obtain ⟨⟨x, -, rfl⟩, hcol⟩ := hT
  have hpre := isPreconnected_connectedComponentIn (F := bowtie.interiorPts) (x := x)
  have hsub : connectedComponentIn bowtie.interiorPts x ⊆ bowtieC ∪ (bowtieCN ∪ bowtieCS) := by
    intro z hz
    have := (bowtieCol_cases z).2.1 (hcol hz)
    rcases this with (h | h) | h
    exacts [Or.inl h, Or.inr (Or.inl h), Or.inr (Or.inr h)]
  have hdCN : Disjoint bowtieCN bowtieCS := disjoint_left.mpr fun z h1 h2 => by
    have := abs_nonneg z.re; linarith [h1.1, h2.1]
  have hdC : Disjoint bowtieC (bowtieCN ∪ bowtieCS) := disjoint_left.mpr fun z h1 h2 => by
    have hi := abs_lt.mp h1.2.2.1
    rcases h2 with h2 | h2
    · have := abs_nonneg z.re; linarith [h2.1]
    · have := abs_nonneg z.re; linarith [h2.1]
  rcases hpre.subset_or_subset isOpen_bowtieC (isOpen_bowtieCN.union isOpen_bowtieCS) hdC hsub with h | h
  · exact Or.inl h
  · rcases hpre.subset_or_subset isOpen_bowtieCN isOpen_bowtieCS hdCN h with h' | h'
    · exact Or.inr (Or.inl h')
    · exact Or.inr (Or.inr h')

/-- The horn colour's contacts at `N = i` and `S′ = −i` on `ω(E)` are out-type. -/
theorem bowtie_outType_one : bowtie.OutType 0 1 I ∧ bowtie.OutType 0 1 (-I) := by
  have hcl : ∀ (A : Set ℂ) (a : ℝ), (∀ z ∈ A, z.im < a) → ∀ z ∈ closure A, z.im ≤ a := fun A a h z hz =>
    closure_minimal (fun w hw => (h w hw).le) (isClosed_le Complex.continuous_im continuous_const) hz
  have hcl' : ∀ (A : Set ℂ) (a : ℝ), (∀ z ∈ A, a < z.im) → ∀ z ∈ closure A, a ≤ z.im := fun A a h z hz =>
    closure_minimal (fun w hw => (h w hw).le) (isClosed_le continuous_const Complex.continuous_im) hz
  have hC : ∀ z ∈ bowtieC, |z.im| < 1 / 13 := fun z hz => hz.2.2.1
  have hCN : ∀ z ∈ bowtieCN, 1 < z.im := fun z hz => by have := abs_nonneg z.re; linarith [hz.1]
  have hCS : ∀ z ∈ bowtieCS, z.im < -1 := fun z hz => by have := abs_nonneg z.re; linarith [hz.1]
  have him : ∀ z ∈ closedBall (0 : ℂ) 1, |z.im| ≤ 1 := fun z hz => by
    rw [mem_closedBall, dist_zero_right] at hz; exact (Complex.abs_im_le_norm z).trans hz
  refine ⟨fun T hT hIT => ?_, fun T hT hIT => ?_⟩
  · rcases bowtie_tileOf_one hT with h | h | h
    · have := hcl T (1 / 13) (fun z hz => (abs_lt.mp (hC z (h hz))).2) I hIT; simp at this; norm_num at this
    · exact disjoint_left.mpr fun z hz hz' => by have := abs_le.mp (him z hz'); linarith [hCN z (h hz)]
    · have := hcl T (-1) (fun z hz => hCS z (h hz)) I hIT; simp at this; norm_num at this
  · rcases bowtie_tileOf_one hT with h | h | h
    · have := hcl' T (-1 / 13) (fun z hz => by linarith [(abs_lt.mp (hC z (h hz))).1]) (-I) hIT
      simp at this; norm_num at this
    · have := hcl' T 1 (fun z hz => hCN z (h hz)) (-I) hIT; simp at this; norm_num at this
    · exact disjoint_left.mpr fun z hz hz' => by have := abs_le.mp (him z hz'); linarith [hCS z (h hz)]

/-- **No MERGE at `E`**: only the horn colour has two sectors, and its allowed cone lies in the line `im d = 0`, its contacts at `±i`
being out-type. -/
theorem bowtie_not_merge_zero : ¬ bowtie.MergeAvailable 0 := by
  rintro ⟨c, n, hn2, hn, d, hd⟩
  obtain rfl := bowtie_hasSectors_zero_two hn hn2
  obtain ⟨hI, hnI, -, -⟩ := bowtie_neighbours
  have h1 : (1 : Fin 6) ∈ bowtie.coloursAt 0 := by rw [bowtie_coloursAt_zero.1]; simp
  have hcI : bowtie.IsContact 0 1 I := ⟨h1, by simp, show (1 : Fin 6) ∈ bowtie.coloursAt I by rw [hI]; simp⟩
  have hcnI : bowtie.IsContact 0 1 (-I) := ⟨h1, by simp, show (1 : Fin 6) ∈ bowtie.coloursAt (-I) by rw [hnI]; simp⟩
  have hsub : bowtie.allowedCone 0 1 ⊆ {z : ℂ | 0 * z.re + 1 * z.im = 0} := by
    intro w hw
    have a := (hw I hcI).2 bowtie_outType_one.1
    have b := (hw (-I) hcnI).2 bowtie_outType_one.2
    simp only [dot, sub_zero, map_neg, Complex.conj_I, neg_neg, Complex.mul_re, Complex.neg_re, Complex.neg_im,
      Complex.I_re, Complex.I_im] at a b
    simp only [mem_setOf_eq]
    linarith
  have := interior_mono hsub hd
  rw [interior_line_eq_empty (Or.inr one_ne_zero)] at this
  exact this

/-- **No MERGE-RAY at `E`**: two disjoint horn sets along one axis would both hold the same cusp horn. -/
theorem bowtie_not_ray_zero : ¬ bowtie.RayAvailable 0 := by
  rintro ⟨c, α, κ₁, κ₂, κ₃, κ₄, h23, ⟨-, h1⟩, ⟨-, h2⟩⟩
  obtain ⟨r, ⟨⟨hs1, -⟩, ⟨hs2, -⟩⟩, hr⟩ :=
    ((h1.and h2).and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 13 by norm_num))).exists
  obtain ⟨hA, -⟩ := bowtie_hornSet_zero hr.2 hs1
  obtain ⟨hB, -⟩ := bowtie_hornSet_zero hr.2 hs2
  have hdisj : ∀ z, z ∈ hornSet 0 α κ₁ κ₂ r → z ∈ hornSet 0 α κ₃ κ₄ r → False := fun z h h' =>
    tanBelow_tanAbove_false h23.le h.2.2.2 h'.2.2.1
  obtain ⟨-, -, -, hne, -⟩ := cuspPiece_data hr.1 (by linarith [hr.2])
  rcases hA with ⟨he, hA⟩ | ⟨he, hA⟩ <;> rcases hB with ⟨he', hB⟩ | ⟨he', hB⟩
  · obtain ⟨z, hz⟩ := hne 0; exact hdisj z (hA hz) (hB hz)
  · rw [he] at he'; norm_num at he'
  · rw [he] at he'; norm_num at he'
  · obtain ⟨z, hz⟩ := hne 1; exact hdisj z (hA hz) (hB hz)

/-- At `E`, a point of the domain near `E` on the horn's side of its normal line and off the horn has colour `0` or `2` (it lies in a
disc part: the other cusp horn is on the far side). -/
theorem bowtie_flank_colour {α κ₁ κ₂ r : ℝ} (hr : r ≤ 1 / 13) (hS : bowtie.IsSector 0 r (hornSet 0 α κ₁ κ₂ r)) {z : ℂ}
    (hz : z ∈ bowtie.interiorPts) (hzr : ‖z‖ < r) (hzx : 0 < frameX 0 α z) (hzH : z ∉ hornSet 0 α κ₁ κ₂ r) :
    bowtie.col z = 0 ∨ bowtie.col z = 2 := by
  have hzU : z ∈ bowtie.interiorPts ∩ ball 0 r := ⟨hz, mem_ball_zero_iff.mpr hzr⟩
  rw [bowtie_partition hr, mem_iUnion] at hzU
  obtain ⟨i, hi⟩ := hzU
  obtain ⟨hdir, -⟩ := bowtie_hornSet_zero hr hS
  have hfx1 : e α = 1 → frameX 0 α z = z.re := fun he => by simp [frameX, he]
  have hfx2 : e α = -1 → frameX 0 α z = -z.re := fun he => by simp [frameX, he]
  have hc := bowtieCol_cuspPiece hr (z := z)
  fin_cases i
  · exfalso
    have hre := ((hornSet_cusp_iff r z).mp hi).2.1
    rcases hdir with ⟨he, hsub⟩ | ⟨he, -⟩
    · exact hzH (hsub hi)
    · rw [hfx2 he] at hzx; linarith
  · exfalso
    have hre := (mem_cuspPiece_one.mp hi).2.1
    rcases hdir with ⟨he, -⟩ | ⟨he, hsub⟩
    · rw [hfx1 he] at hzx; linarith
    · exact hzH (hsub hi)
  · exact Or.inl (hc.2.2.1 hi)
  · exact Or.inr (hc.2.2.2 hi)

/-- **No SHAVE at `E`**: a horn there is a cusp horn, its flanks are the colours `0` and `2`, and every point of it is in the shadow
of both classes (`mem_shadow_bowtie_region_zero/two`), so neither part of any split is clear for its flank. -/
theorem bowtie_not_shave_zero : ¬ bowtie.ShaveAvailable 0 := by
  rintro ⟨c, g, h, α, κ₁, κ₂, σ, ⟨-, hH⟩, ⟨κ', hκ', hfa⟩, ⟨κ'', hκ'', hfb⟩, -, -, hsh⟩
  obtain ⟨r, ⟨⟨⟨⟨hs, -⟩, hfa'⟩, hfb'⟩, hsh'⟩, hr⟩ :=
    ((((hH.and hfa).and hfb).and hsh).and (Ioc_mem_nhdsGT (show (0 : ℝ) < 1 / 20 by norm_num))).exists
  have hr13 : r ≤ 1 / 13 := by linarith [hr.2]
  obtain ⟨-, hout⟩ := bowtie_hornSet_zero hr13 hs
  obtain ⟨z₁, hz₁, -, -⟩ := exists_mem_hornSet_aboveBelow 0 α (κ₁ := κ₂) (κ₂ := κ') (s := (κ₂ + κ') / 2) (m := κ') hr.1
    (by linarith) (by linarith) (by intro h; linarith)
  obtain ⟨z₂, hz₂, -, -⟩ := exists_mem_hornSet_aboveBelow 0 α (κ₁ := κ'') (κ₂ := κ₁) (s := (κ'' + κ₁) / 2) (m := κ₁) hr.1
    (by linarith) (by linarith) (by intro h; linarith)
  have hg : g = 0 ∨ g = 2 := by
    obtain ⟨hint, hcol⟩ := hfa' hz₁
    have := bowtie_flank_colour hr13 hs hint (by simpa using hz₁.1) hz₁.2.1
      (fun hH' => tanBelow_tanAbove_false le_rfl hH'.2.2.2 hz₁.2.2.1)
    rwa [show bowtie.col z₁ = g from hcol] at this
  have hh : h = 0 ∨ h = 2 := by
    obtain ⟨hint, hcol⟩ := hfb' hz₂
    have := bowtie_flank_colour hr13 hs hint (by simpa using hz₂.1) hz₂.2.1
      (fun hH' => tanBelow_tanAbove_false le_rfl hz₂.2.2.2 hH'.2.2.1)
    rwa [show bowtie.col z₂ = h from hcol] at this
  obtain ⟨z, hz⟩ := hs.nonempty
  obtain ⟨h1, h2⟩ := hout z hz
  have hzr : ‖z‖ < 1 / 20 := by
    have := mem_ball_zero_iff.mp (hs.subset hz).2; linarith [hr.2]
  have hnc : ∀ j : Fin 6, j = 0 ∨ j = 2 → ¬ bowtie.IsClear j z := by
    rintro j (rfl | rfl) hc
    · obtain ⟨y, hy, hyd⟩ := mem_shadow_bowtie_region_zero hzr h1; exact hc y hy hyd
    · obtain ⟨y, hy, hyd⟩ := mem_shadow_bowtie_region_two hzr h2; exact hc y hy hyd
  obtain ⟨hA, hB⟩ := hsh' z hz
  by_cases hσ : TanAbove 0 α σ z
  · exact hnc g hg (hA hσ)
  · exact hnc h hh (hB hσ)

/-- At `N = i` and `S′ = −i` every colour has at most one sector. -/
theorem bowtie_hasSectors_le_one {v : ℂ} (hv : v = I ∨ v = -I) {c : Fin 6} {n : ℕ} (hn : bowtie.HasSectors v c n) : n ≤ 1 := by
  obtain ⟨-, -, hI, hnI⟩ := bowtie_neighbours
  by_cases hc : c ∈ bowtie.coloursAt v
  · rcases hv with rfl | rfl
    · exact (hn.eq (hI c hc)).le
    · exact (hn.eq (hnI c hc)).le
  · rw [hn.eq_zero_of_not_mem hc]; exact zero_le_one

/-- No move at `±i`: no colour has two sectors, and there is no horn. -/
theorem bowtie_terminal_pm_I {v : ℂ} (hv : v = I ∨ v = -I) :
    ¬ bowtie.MergeAvailable v ∧ ¬ bowtie.RayAvailable v ∧ ¬ bowtie.ShaveAvailable v := by
  have hno : ∀ α κ₁ κ₂ c, ¬ bowtie.IsHorn v α κ₁ κ₂ c := by
    rcases hv with rfl | rfl
    exacts [bowtie_not_isHorn_I, bowtie_not_isHorn_negI]
  refine ⟨?_, ?_, ?_⟩
  · rintro ⟨c, n, h2, hn, -⟩; have := bowtie_hasSectors_le_one hv hn; omega
  · rintro ⟨c, α, κ₁, κ₂, κ₃, κ₄, -, hH, -⟩; exact hno _ _ _ _ hH
  · rintro ⟨c, g, h, α, κ₁, κ₂, σ, hH, -⟩; exact hno _ _ _ _ hH

/-- **A one-vertex stuck chain**: `E` is stuck, neither neighbour is. -/
theorem bowtie_isStuck : bowtie.IsStuck 0 ∧ ¬ bowtie.IsStuck I ∧ ¬ bowtie.IsStuck (-I) := by
  refine ⟨⟨bowtie_not_merge_zero, bowtie_not_ray_zero, bowtie_not_shave_zero, 1, 2, le_rfl, bowtie_coloursAt_zero.2⟩, ?_, ?_⟩
  · rintro ⟨-, -, -, c, n, h2, hn⟩; have := bowtie_hasSectors_le_one (Or.inl rfl) hn; omega
  · rintro ⟨-, -, -, c, n, h2, hn⟩; have := bowtie_hasSectors_le_one (Or.inr rfl) hn; omega

/-- **No MERGE, MERGE-RAY or SHAVE applies at `E`, `E ± n`.** -/
theorem bowtie_terminalOn : bowtie.TerminalOn {0, I, -I} := by
  intro v hv
  simp only [mem_insert_iff, mem_singleton_iff] at hv
  rcases hv with rfl | rfl | rfl
  · exact ⟨bowtie_not_merge_zero, bowtie_not_ray_zero, bowtie_not_shave_zero⟩
  · exact bowtie_terminal_pm_I (Or.inl rfl)
  · exact bowtie_terminal_pm_I (Or.inr rfl)

/-! ### The ends of the bowtie's unit arcs lie in its domain (FS131-I4f) -/

/-- An open set lies in the closure of `S` when it does off a closed set with empty interior. -/
theorem subset_closure_of_diff_subset {B K S : Set ℂ} (hB : IsOpen B) (hK0 : interior K = ∅) (h : B \ K ⊆ S) :
    B ⊆ closure S :=
  ((interior_eq_empty_iff_dense_compl.mp hK0).open_subset_closure_inter hB).trans
    (closure_mono fun _ hz => h ⟨hz.1, hz.2⟩)

/-- A unit circle and two lines form a closed set with empty interior. -/
theorem interior_sphere_union_lines {c : ℂ} {a₁ b₁ c₁ a₂ b₂ c₂ : ℝ} (h₁ : a₁ ≠ 0 ∨ b₁ ≠ 0) (h₂ : a₂ ≠ 0 ∨ b₂ ≠ 0) :
    IsClosed (sphere c 1 ∪ {z : ℂ | a₁ * z.re + b₁ * z.im = c₁} ∪ {z | a₂ * z.re + b₂ * z.im = c₂}) ∧
      interior (sphere c 1 ∪ {z : ℂ | a₁ * z.re + b₁ * z.im = c₁} ∪ {z | a₂ * z.re + b₂ * z.im = c₂}) = ∅ := by
  refine ⟨(isClosed_sphere.union (isClosed_line _ _ _)).union (isClosed_line _ _ _), ?_⟩
  rw [interior_union_isClosed_of_interior_empty (isClosed_sphere.union (isClosed_line _ _ _)) (interior_line_eq_empty h₂),
    interior_union_isClosed_of_interior_empty isClosed_sphere (interior_line_eq_empty h₁), interior_sphere _ one_ne_zero]

/-- The unit arcs' end `(5/13, 1/13)` lies in the bowtie's domain: off `ω(i)` and the lines `x = 5/13`, `12x + 5y = 5`, the ball of
radius `1/100` about it lies in `G ∪ C ∪ ZR`. -/
theorem bowtie_dom_end_pp : pt (5 / 13) (1 / 13) ∈ bowtie.dom := by
  obtain ⟨-, hK0⟩ := interior_sphere_union_lines (c := I) (a₁ := 1) (b₁ := 0) (c₁ := 5 / 13) (a₂ := 12) (b₂ := 5) (c₂ := 5)
    (by norm_num) (by norm_num)
  refine interior_maximal (subset_closure_of_diff_subset isOpen_ball hK0 ?_) isOpen_ball
    (mem_ball_self (by norm_num : (0:ℝ) < 1 / 100))
  rintro z ⟨hz, hK'⟩
  simp only [mem_union, mem_sphere_iff_norm, mem_setOf_eq, not_or, one_mul, zero_mul, add_zero] at hK'
  obtain ⟨⟨k1, k2⟩, k3⟩ := hK'
  rw [mem_ball, dist_eq_norm] at hz
  simp only [pt] at hz
  have hx : |z.re - 5 / 13| < 1 / 100 := by
    have := Complex.abs_re_le_norm (z - pt (5 / 13) (1 / 13)); simp only [Complex.sub_re, pt] at this; linarith
  have hy : |z.im - 1 / 13| < 1 / 100 := by
    have := Complex.abs_im_le_norm (z - pt (5 / 13) (1 / 13)); simp only [Complex.sub_im, pt] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  have hre0 : 0 < z.re := by linarith
  simp only [bowtieTiles, mem_union]
  have hZ : z ∈ bowtieZ 1 ↔ 5 / 13 < z.re ∨ 5 < 12 * z.re + 5 * z.im := by
    simp only [bowtieZ, mem_setOf_eq, one_mul]
    constructor
    · rintro ⟨-, -, -, h⟩
      by_contra hc; push Not at hc
      exact h ⟨hc.1, by linarith, by linarith⟩
    · intro h
      refine ⟨by linarith, by linarith, by rw [abs_lt]; constructor <;> linarith, ?_⟩
      rintro ⟨h1, h2, -⟩
      rcases h with h | h <;> linarith
  rcases lt_or_gt_of_ne k2 with h1 | h1
  · rcases lt_or_gt_of_ne k3 with h2 | h2
    · -- inside the corner: `G` or `C`
      have hs := norm_sub_I_sq z
      rcases lt_or_gt_of_ne k1 with h3 | h3
      · left; left; left; left; left; left; left; left; left; left
        exact ⟨h3, by linarith, by rw [abs_of_pos hre0]; linarith⟩
      · left; left; left; left; left; left; left; left; right
        have e3 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h3
        have hs2 := norm_add_I_sq z
        have him : z.im < 1 / 13 := by nlinarith
        refine ⟨hre0.ne', by rw [abs_of_pos hre0]; exact h1, by rw [abs_lt]; constructor <;> linarith, h3, ?_⟩
        have : 1 < ‖z + I‖ ^ 2 := by nlinarith
        exact (one_lt_sq_iff₀ (norm_nonneg _)).mp this
    · left; right; exact hZ.mpr (Or.inr h2)
  · left; right; exact hZ.mpr (Or.inl h1)

/-- The unit arcs' end `(−5/13, 1/13)` lies in the bowtie's domain (the mirror: `G ∪ C ∪ ZL` off `ω(i)`, `x = −5/13`, `−12x + 5y = 5`). -/
theorem bowtie_dom_end_np : pt (-5 / 13) (1 / 13) ∈ bowtie.dom := by
  obtain ⟨-, hK0⟩ := interior_sphere_union_lines (c := I) (a₁ := 1) (b₁ := 0) (c₁ := -5 / 13) (a₂ := -12) (b₂ := 5) (c₂ := 5)
    (by norm_num) (by norm_num)
  refine interior_maximal (subset_closure_of_diff_subset isOpen_ball hK0 ?_) isOpen_ball
    (mem_ball_self (by norm_num : (0:ℝ) < 1 / 100))
  rintro z ⟨hz, hK'⟩
  simp only [mem_union, mem_sphere_iff_norm, mem_setOf_eq, not_or, one_mul, zero_mul, add_zero] at hK'
  obtain ⟨⟨k1, k2⟩, k3⟩ := hK'
  rw [mem_ball, dist_eq_norm] at hz
  simp only [pt] at hz
  have hx : |z.re - -5 / 13| < 1 / 100 := by
    have := Complex.abs_re_le_norm (z - pt (-5 / 13) (1 / 13)); simp only [Complex.sub_re, pt] at this; linarith
  have hy : |z.im - 1 / 13| < 1 / 100 := by
    have := Complex.abs_im_le_norm (z - pt (-5 / 13) (1 / 13)); simp only [Complex.sub_im, pt] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  have hre0 : z.re < 0 := by linarith
  simp only [bowtieTiles, mem_union]
  have hZ : z ∈ bowtieZ (-1) ↔ z.re < -5 / 13 ∨ 5 < -12 * z.re + 5 * z.im := by
    simp only [bowtieZ, mem_setOf_eq, neg_one_mul]
    constructor
    · rintro ⟨-, -, -, h⟩
      by_contra hc; push Not at hc
      exact h ⟨by linarith, by linarith, by linarith⟩
    · intro h
      refine ⟨by linarith, by linarith, by rw [abs_lt]; constructor <;> linarith, ?_⟩
      rintro ⟨h1, h2, -⟩
      rcases h with h | h <;> linarith
  rcases lt_or_gt_of_ne k2 with h1 | h1
  · right; exact hZ.mpr (Or.inl h1)
  · rcases lt_or_gt_of_ne k3 with h2 | h2
    · have hs := norm_sub_I_sq z
      rcases lt_or_gt_of_ne k1 with h3 | h3
      · left; left; left; left; left; left; left; left; left; left
        exact ⟨h3, by linarith, by rw [abs_of_neg hre0]; linarith⟩
      · left; left; left; left; left; left; left; left; right
        have e3 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h3
        have hs2 := norm_add_I_sq z
        have him : z.im < 1 / 13 := by nlinarith
        refine ⟨hre0.ne, by rw [abs_of_neg hre0]; linarith, by rw [abs_lt]; constructor <;> linarith, h3, ?_⟩
        have : 1 < ‖z + I‖ ^ 2 := by nlinarith
        exact (one_lt_sq_iff₀ (norm_nonneg _)).mp this
    · right; exact hZ.mpr (Or.inr h2)

/-- The unit arcs' end `(5/13, −1/13)` lies in the bowtie's domain (`H ∪ C ∪ ZR` off `ω(−i)`, `x = 5/13`, `12x − 5y = 5`). -/
theorem bowtie_dom_end_pn : pt (5 / 13) (-1 / 13) ∈ bowtie.dom := by
  obtain ⟨-, hK0⟩ := interior_sphere_union_lines (c := -I) (a₁ := 1) (b₁ := 0) (c₁ := 5 / 13) (a₂ := 12) (b₂ := -5) (c₂ := 5)
    (by norm_num) (by norm_num)
  refine interior_maximal (subset_closure_of_diff_subset isOpen_ball hK0 ?_) isOpen_ball
    (mem_ball_self (by norm_num : (0:ℝ) < 1 / 100))
  rintro z ⟨hz, hK'⟩
  simp only [mem_union, mem_sphere_iff_norm, mem_setOf_eq, not_or, one_mul, zero_mul, add_zero, sub_neg_eq_add] at hK'
  obtain ⟨⟨k1, k2⟩, k3⟩ := hK'
  rw [mem_ball, dist_eq_norm] at hz
  simp only [pt] at hz
  have hx : |z.re - 5 / 13| < 1 / 100 := by
    have := Complex.abs_re_le_norm (z - pt (5 / 13) (-1 / 13)); simp only [Complex.sub_re, pt] at this; linarith
  have hy : |z.im - -1 / 13| < 1 / 100 := by
    have := Complex.abs_im_le_norm (z - pt (5 / 13) (-1 / 13)); simp only [Complex.sub_im, pt] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  have hre0 : 0 < z.re := by linarith
  simp only [bowtieTiles, mem_union]
  have hZ : z ∈ bowtieZ 1 ↔ 5 / 13 < z.re ∨ 5 < 12 * z.re + -5 * z.im := by
    simp only [bowtieZ, mem_setOf_eq, one_mul]
    constructor
    · rintro ⟨-, -, -, h⟩
      by_contra hc; push Not at hc
      exact h ⟨hc.1, by linarith, by linarith⟩
    · intro h
      refine ⟨by linarith, by linarith, by rw [abs_lt]; constructor <;> linarith, ?_⟩
      rintro ⟨h1, -, h3⟩
      rcases h with h | h <;> linarith
  rcases lt_or_gt_of_ne k2 with h1 | h1
  · rcases lt_or_gt_of_ne k3 with h2 | h2
    · have hs := norm_add_I_sq z
      rcases lt_or_gt_of_ne k1 with h3 | h3
      · left; left; left; left; left; left; left; left; left; right
        exact ⟨h3, by linarith, by rw [abs_of_pos hre0]; linarith⟩
      · left; left; left; left; left; left; left; left; right
        have e3 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h3
        have hs2 := norm_sub_I_sq z
        have him : -1 / 13 < z.im := by nlinarith
        refine ⟨hre0.ne', by rw [abs_of_pos hre0]; exact h1, by rw [abs_lt]; constructor <;> linarith, ?_, h3⟩
        have : 1 < ‖z - I‖ ^ 2 := by nlinarith
        exact (one_lt_sq_iff₀ (norm_nonneg _)).mp this
    · left; right; exact hZ.mpr (Or.inr h2)
  · left; right; exact hZ.mpr (Or.inl h1)

/-- The unit arcs' end `(−5/13, −1/13)` lies in the bowtie's domain (`H ∪ C ∪ ZL` off `ω(−i)`, `x = −5/13`, `−12x − 5y = 5`). -/
theorem bowtie_dom_end_nn : pt (-5 / 13) (-1 / 13) ∈ bowtie.dom := by
  obtain ⟨-, hK0⟩ := interior_sphere_union_lines (c := -I) (a₁ := 1) (b₁ := 0) (c₁ := -5 / 13) (a₂ := -12) (b₂ := -5) (c₂ := 5)
    (by norm_num) (by norm_num)
  refine interior_maximal (subset_closure_of_diff_subset isOpen_ball hK0 ?_) isOpen_ball
    (mem_ball_self (by norm_num : (0:ℝ) < 1 / 100))
  rintro z ⟨hz, hK'⟩
  simp only [mem_union, mem_sphere_iff_norm, mem_setOf_eq, not_or, one_mul, zero_mul, add_zero, sub_neg_eq_add] at hK'
  obtain ⟨⟨k1, k2⟩, k3⟩ := hK'
  rw [mem_ball, dist_eq_norm] at hz
  simp only [pt] at hz
  have hx : |z.re - -5 / 13| < 1 / 100 := by
    have := Complex.abs_re_le_norm (z - pt (-5 / 13) (-1 / 13)); simp only [Complex.sub_re, pt] at this; linarith
  have hy : |z.im - -1 / 13| < 1 / 100 := by
    have := Complex.abs_im_le_norm (z - pt (-5 / 13) (-1 / 13)); simp only [Complex.sub_im, pt] at this; linarith
  have hx' := abs_lt.mp hx
  have hy' := abs_lt.mp hy
  have hre0 : z.re < 0 := by linarith
  simp only [bowtieTiles, mem_union]
  have hZ : z ∈ bowtieZ (-1) ↔ z.re < -5 / 13 ∨ 5 < -12 * z.re + -5 * z.im := by
    simp only [bowtieZ, mem_setOf_eq, neg_one_mul]
    constructor
    · rintro ⟨-, -, -, h⟩
      by_contra hc; push Not at hc
      exact h ⟨by linarith, by linarith, by linarith⟩
    · intro h
      refine ⟨by linarith, by linarith, by rw [abs_lt]; constructor <;> linarith, ?_⟩
      rintro ⟨h1, -, h3⟩
      rcases h with h | h <;> linarith
  rcases lt_or_gt_of_ne k2 with h1 | h1
  · right; exact hZ.mpr (Or.inl h1)
  · rcases lt_or_gt_of_ne k3 with h2 | h2
    · have hs := norm_add_I_sq z
      rcases lt_or_gt_of_ne k1 with h3 | h3
      · left; left; left; left; left; left; left; left; left; right
        exact ⟨h3, by linarith, by rw [abs_of_neg hre0]; linarith⟩
      · left; left; left; left; left; left; left; left; right
        have e3 := (one_lt_sq_iff₀ (norm_nonneg _)).mpr h3
        have hs2 := norm_sub_I_sq z
        have him : -1 / 13 < z.im := by nlinarith
        refine ⟨hre0.ne, by rw [abs_of_neg hre0]; linarith, by rw [abs_lt]; constructor <;> linarith, ?_, h3⟩
        have : 1 < ‖z - I‖ ^ 2 := by nlinarith
        exact (one_lt_sq_iff₀ (norm_nonneg _)).mp this
    · right; exact hZ.mpr (Or.inr h2)

/-- The ends of the bowtie's unit arcs: `i + e(3π/2 ∓ arcsin(5/13)) = (∓5/13, 1/13)`, `−i + e(π/2 ∓ arcsin(5/13)) = (±5/13, −1/13)`. -/
theorem bowtie_arc_ends :
    I + (1 : ℝ) * e (3 * π / 2 - bowtieAngle) = pt (-5 / 13) (1 / 13) ∧ I + (1 : ℝ) * e (3 * π / 2 + bowtieAngle) = pt (5 / 13) (1 / 13) ∧
      -I + (1 : ℝ) * e (π / 2 - bowtieAngle) = pt (5 / 13) (-1 / 13) ∧ -I + (1 : ℝ) * e (π / 2 + bowtieAngle) = pt (-5 / 13) (-1 / 13) := by
  have hs : Real.sin bowtieAngle = 5 / 13 := Real.sin_arcsin (by norm_num) (by norm_num)
  have hc : Real.cos bowtieAngle = 12 / 13 := by
    rw [bowtieAngle, Real.cos_arcsin, show (1 : ℝ) - (5 / 13) ^ 2 = (12 / 13) ^ 2 by norm_num]
    exact Real.sqrt_sq (by norm_num)
  have h1 : 3 * π / 2 - bowtieAngle = (π / 2 - bowtieAngle) + π := by ring
  have h2 : 3 * π / 2 + bowtieAngle = (bowtieAngle + π / 2) + π := by ring
  have h3 : π / 2 + bowtieAngle = bowtieAngle + π / 2 := by ring
  refine ⟨?_, ?_, ?_, ?_⟩ <;> apply Complex.ext <;>
    simp only [Complex.add_re, Complex.add_im, Complex.neg_re, Complex.neg_im, Complex.I_re, Complex.I_im, Complex.mul_re,
      Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, re_e, im_e, pt, h1, h2, h3, Real.cos_add_pi, Real.sin_add_pi,
      Real.cos_pi_div_two_sub, Real.sin_pi_div_two_sub, Real.cos_add_pi_div_two, Real.sin_add_pi_div_two, hs, hc] <;>
    norm_num

/-- **Every unit arc's end is interior** to the fragment (the arcs' ends `(±5/13, ±1/13)` lie in its domain, with their
neighbourhoods coloured). -/
theorem bowtie_unitArcEnds : ∀ a ∈ bowtie.arcs, ∀ p θ₀ θ₁, a = .circ p 1 θ₀ θ₁ →
    p + e θ₀ ∈ bowtie.dom ∧ p + e θ₁ ∈ bowtie.dom := by
  intro a ha p θ₀ θ₁ hpa
  obtain ⟨e1, e2, e3, e4⟩ := bowtie_arc_ends
  simp only [one_mul, Complex.ofReal_one] at e1 e2 e3 e4
  change a ∈ bowtieArcs at ha
  simp only [bowtieArcs, mem_setOf_eq, List.mem_cons, List.not_mem_nil, or_false] at ha
  rcases ha with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · simp only [Arc.circ.injEq] at hpa
    obtain ⟨rfl, -, rfl, rfl⟩ := hpa
    rw [e1, e2]; exact ⟨bowtie_dom_end_np, bowtie_dom_end_pp⟩
  · simp only [Arc.circ.injEq] at hpa
    obtain ⟨rfl, -, rfl, rfl⟩ := hpa
    rw [e3, e4]; exact ⟨bowtie_dom_end_pn, bowtie_dom_end_nn⟩
  all_goals exact absurd hpa (by simp)

/-- **FS112-FLANK**, its last clause, "SHAVE's criterion is incomplete there", witnessed by the bowtie: at `E = 0` neither flank colour
(`0` above the horns, `2` below) has an out-type contact at `N = i` or `S′ = −i` — so N4-FLANK's list of shadows (out-type flank tiles at
`S′` and `N` only) is empty and the criterion read from it would shave — and yet no SHAVE is available at `E`: the in-type sectors at
`N`, `S′` doubly shadow both horns (`bowtie_doublyShadowed`), whose bounds are `±1`. -/
theorem flank_incomplete_bowtie :
    (∀ j ∈ ({0, 2} : Set (Fin 6)), ∀ w ∈ ({I, -I} : Set ℂ), ¬ (bowtie.IsContact 0 j w ∧ bowtie.OutType 0 j w)) ∧
      ¬ bowtie.ShaveAvailable 0 := by
  refine ⟨?_, (bowtie_terminalOn 0 (by simp)).2.2⟩
  intro j hj w hw ⟨hcon, hout⟩
  simp only [mem_insert_iff, mem_singleton_iff] at hj hw
  obtain ⟨hI, hnI, -, -⟩ := bowtie_neighbours
  obtain ⟨⟨-, hin0⟩, ⟨-, hin2⟩⟩ := bowtie_inType
  have hcw : j ∈ bowtie.coloursAt w := hcon.2.2
  rcases hj with rfl | rfl <;> rcases hw with rfl | rfl
  · obtain ⟨T, hT, hIT⟩ := (bowtie.mem_coloursAt_iff_exists_tileOf bowtie_mem_dom.2.1).mp hcw
    obtain ⟨x, hx⟩ := hT.1.nonempty
    exact disjoint_left.mp (hout T hT hIT) hx (ball_subset_closedBall (hin0 T hT hIT hx))
  · rw [hnI] at hcw; simp at hcw
  · rw [hI] at hcw; simp at hcw
  · obtain ⟨T, hT, hIT⟩ := (bowtie.mem_coloursAt_iff_exists_tileOf bowtie_mem_dom.2.2).mp hcw
    obtain ⟨x, hx⟩ := hT.1.nonempty
    exact disjoint_left.mp (hout T hT hIT) hx (ball_subset_closedBall (hin2 T hT hIT hx))

end ArcMap

end HadwigerNelson.Plane
