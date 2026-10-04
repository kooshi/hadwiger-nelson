import Proofs.HadwigerNelson.Plane.ValidMap.Basic
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

end Spec

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS112-N3-PAIRS -/

/-- **FS112-N3-PAIRS** (i), N3-I (CB's (i) never fails): for cubic trichromatic `u₁`, `u₂` and a unit pair `x ∈ ω(u₁)`,
`y ∈ ω(u₂)`, the pseudo-colours `c′(x) = c′(y) = {a}` are impossible (no transversality hypothesis; `u₁ = u₂` allowed). -/
theorem pair_i (hF : F.Valid) {u₁ u₂ x y : ℂ} (h₁ : F.IsCubicTrichromatic u₁) (h₂ : F.IsCubicTrichromatic u₂)
    (hc₁ : F.Covers u₁ 1) (hc₂ : F.Covers u₂ 1) (hx : dist x u₁ = 1) (hy : dist y u₂ = 1) (hxy : dist x y = 1) {a : Fin k}
    (hax : F.pseudoColours u₁ x = {a}) (hay : F.pseudoColours u₂ y = {a}) : False := by
  sorry

/-- **FS112-N3-PAIRS** (ii), N3-II: for a unit pair `x ∈ ω(u₁)`, `y ∈ ω(u₂)` with `c′(x) = c′(y) = {a, b}` and `ω(y)` transversal
to `ω(u₁)` at `x` (`y ≠ u₁`, `|y − u₁| ≠ 2`), `x` carries at least four colours or `y` is the centre of a both-kind unit arc. -/
theorem pair_ii (hF : F.Valid) {u₁ u₂ x y : ℂ} (h₁ : F.IsCubicTrichromatic u₁) (h₂ : F.IsCubicTrichromatic u₂)
    (hc₁ : F.Covers u₁ 1) (hc₂ : F.Covers u₂ 1) (hx : dist x u₁ = 1) (hy : dist y u₂ = 1) (hxy : dist x y = 1)
    (htr : y ≠ u₁ ∧ dist y u₁ ≠ 2) {a b : Fin k} (hab : a ≠ b) (hax : F.pseudoColours u₁ x = {a, b})
    (hay : F.pseudoColours u₂ y = {a, b}) :
    4 ≤ (F.coloursAt x).ncard ∨ ∃ θ₁ θ₂, F.BothKind y θ₁ θ₂ := by
  sorry

/-- **FS112-N3-PAIRS**, N3-P′: two cubic trichromatic vertices with one multicolour are never at distance `1`. -/
theorem pair_P' (hF : F.Valid) {u u' : ℂ} (h : F.IsCubicTrichromatic u) (h' : F.IsCubicTrichromatic u') (hu : u ∈ F.dom)
    (hu' : u' ∈ F.dom) (hcol : F.coloursAt u = F.coloursAt u') : dist u u' ≠ 1 := by
  sorry

/-! ## FS112-N3-FAIL -/

/-- **FS112-N3-FAIL**, the place: at a cubic trichromatic `u`, the strip fails at `q ∈ ω(u)` only when `q` is a leaving centre of
`u`. -/
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
are both M-in. -/
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
  sorry

/-- The bowtie has finitely many boundary pieces. -/
theorem bowtieArcs_locallyFinite : ∀ x ∈ interior (closure bowtieTiles), ∃ t ∈ 𝓝 x,
    {a | a ∈ bowtieArcs ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  sorry

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

/-- **FS112-BOWTIE**: the fragment is valid (YB3: 21 of 21 same-colour tile pairs, exact). -/
theorem bowtie_valid : bowtie.Valid := by
  sorry

/-- `E = 0`, `N = i`, `S = −i` lie in the fragment's domain. -/
theorem bowtie_mem_dom : (0 : ℂ) ∈ bowtie.dom ∧ I ∈ bowtie.dom ∧ -I ∈ bowtie.dom := by
  sorry

/-- `E` carries three colours: `0` (`G`), `1` (the horns), `2` (`H`); the horn colour has two sectors. -/
theorem bowtie_coloursAt_zero : bowtie.coloursAt 0 = {0, 1, 2} ∧ bowtie.HasSectors 0 1 2 := by
  sorry

/-- **The horns**: colour `1` along `±a` (`a = e 0`), each between `ω(S)` (curvature `−1` in its frame) and `ω(N)` (curvature `1`) —
bounded by unit arcs on both sides. -/
theorem bowtie_isHorn : bowtie.IsHorn 0 0 (-1) 1 1 ∧ bowtie.IsHorn 0 π (-1) 1 1 := by
  sorry

/-- The horns' flanks: `G` (colour `0`) above and `H` (colour `2`) below (in the frame along `π`, `H` above and `G` below). -/
theorem bowtie_flanks : bowtie.IsFlankAbove 0 0 1 0 ∧ bowtie.IsFlankBelow 0 0 (-1) 2 ∧
    bowtie.IsFlankAbove 0 π 1 2 ∧ bowtie.IsFlankBelow 0 π (-1) 0 := by
  sorry

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
