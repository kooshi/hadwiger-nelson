import Proofs.HadwigerNelson.Plane.ValidMap.Basic

/-!
# Contacts, the allowed cone, shadows and the local moves (FS-110's N3–N4 rounds)

Wave 4's skeleton (`plans/FS131-w4-kernel-plan.md` § 3). Conventions, read once: `F : ArcMap k` with `F.Valid` (no two interior
points of one colour at distance exactly 1); "near `v`" reads the map on a neighbourhood of `B̄(v, 1)`, stated `F.Covers v 1`
(`covers_one_iff`); the frame at `v` is `a = e α`, `n = e (α + π/2)`, `N = v + n`, `S′ = v − n`. Condition 5 is a hypothesis
exactly where a row's argument reads it; FS112-WALK's finding that N3-CONF and W-MERGE hold with unit arcs is followed.

* **FS110-N3-CONF**: `contact_inType_or_outType`, `coneAt_subset_allowedCone`, `clear_of_subset_interior_allowedCone`,
  `lens_dist_lt_one_of_up`, `lune_dist_le_of_up`.
* **FS110-N3-DEG**: `woodallCone`, `woodallCone_strict`.
* **FS110-N4-SHADOW**: `shadow_farSide_above`, `shadow_farSide_below`, `flank_shadows`.
* **FS110-N4-SHAVE**: `shaveAvailable_of_not_doublyShadowed`, `exists_shave`, `exists_rayMerge`.
* **FS110-N4-STUCK**: `stuck_structure`, `stuck_chain`.
* **FS110-W-MERGE**: `exists_merge`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- The far side, near `N`, of an arc tangent to `e α` at `N` with upward curvature `μ`, on the `+a` side: the points of
`B(N, δ)` with positive `a`-coordinate above the arc. -/
def farSideAbove (N : ℂ) (α μ δ : ℝ) : Set ℂ := {z | dist z N < δ ∧ 0 < frameX N α z ∧ TanAbove N α μ z}

/-- The mirror: the points of `B(S, δ)` with positive `a`-coordinate below the arc of upward curvature `υ` tangent at `S`. -/
def farSideBelow (S : ℂ) (α υ δ : ℝ) : Set ℂ := {z | dist z S < δ ∧ 0 < frameX S α z ∧ TanBelow S α υ z}

/-- **FS110-N4-SHADOW**, going down: the far side of an arc of upward curvature `μ > −1` tangent to `a` at `N = v + n`
shadows a point `z` near `v` with `(z − v)·a > 0` exactly when `z` lies above the circle through `v` concentric with the arc,
of curvature `f(μ) = μ/(1 + μ)`. -/
theorem shadow_farSide_above (v : ℂ) (α : ℝ) {μ δ : ℝ} (hμ : -1 < μ) (hδ : 0 < δ) :
    ∃ ε > 0, ∀ z, dist z v < ε → 0 < frameX v α z →
      (z ∈ shadow (farSideAbove (v + e (α + π / 2)) α μ δ) ↔ TanAbove v α (curvDown μ) z) := by
  sorry

/-- **FS110-N4-SHADOW**, going up (the mirror at `S′ = v − n`): an arc of upward curvature `υ < 1` shadows, from below, exactly
the points below the concentric circle of curvature `f̃(υ) = υ/(1 − υ)`. -/
theorem shadow_farSide_below (v : ℂ) (α : ℝ) {υ δ : ℝ} (hυ : υ < 1) (hδ : 0 < δ) :
    ∃ ε > 0, ∀ z, dist z v < ε → 0 < frameX v α z →
      (z ∈ shadow (farSideBelow (v - e (α + π / 2)) α υ δ) ↔ TanBelow v α (curvUp υ) z) := by
  sorry

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS110-N3-CONF -/

/-- **FS110-N3-CONF**, (i): every contact of a colour `c ∈ P_cl(v)` on `ω(v)` is in-type or out-type, and not both. -/
theorem contact_inType_or_outType (hF : F.Valid) {v w : ℂ} {c : Fin k} (hv : F.Covers v 1)
    (hw : F.IsContact v c w) : (F.InType v c w ∨ F.OutType v c w) ∧ ¬ (F.InType v c w ∧ F.OutType v c w) := by
  sorry

/-- **FS110-N3-CONF**, (ii): the directions along which `c`'s class approaches `v` (the union of its sectors' cones) lie in the
allowed cone `D_c(v)`. -/
theorem coneAt_subset_allowedCone (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) {β : ℝ}
    (hβ : β ∈ coneAt (F.region c) v) : e β ∈ F.allowedCone v c := by
  sorry

/-- **FS110-N3-CONF**, (iii) (N3-CLEAR): a compact set of directions inside the interior of `D_c(v)` is clear for `c` near `v`. -/
theorem clear_of_subset_interior_allowedCone (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) (hc : c ∈ F.coloursAt v)
    {Λ : Set ℝ} (hΛ : IsCompact Λ) (hΛD : e '' Λ ⊆ interior (F.allowedCone v c)) :
    ∃ ρ > 0, ∀ β ∈ Λ, ∀ t : ℝ, 0 < t → t < ρ → F.IsClear c (v + (t : ℂ) * e β) := by
  sorry

end ArcMap

/-- **FS110-N3-CONF**, (iv) (N3-UP, the lens `|p|² ≤ 2p_y`, check C1): near `v`, moving a point in the `+n` direction keeps it
within distance `1` of every point of the lens `B(v, 1) ∩ B̄(N, 1)` it was within `1` of — so a point clear of an in-type tile at
`N` (all of whose distances are below `1`) stays clear. -/
theorem lens_dist_lt_one_of_up (v : ℂ) (α : ℝ) :
    ∃ r > 0, ∀ z, dist z v < r → ∀ t : ℝ, 0 ≤ t → dist (z + t * e (α + π / 2)) v < r →
      ∀ p ∈ ball v 1 ∩ closedBall (v + e (α + π / 2)) 1, dist z p < 1 → dist (z + t * e (α + π / 2)) p < 1 := by
  refine ⟨1 / 8, by norm_num, fun z hz t ht hz' p hp hd => ?_⟩
  obtain ⟨hpv, hpN⟩ := hp
  rw [mem_ball] at hpv
  rw [mem_closedBall] at hpN
  set z' := z + (t : ℂ) * e (α + π / 2) with hz'def
  have hx' : frameX v α z' = frameX v α z := frameX_add_normal v α t z
  have hy' : frameY v α z' = frameY v α z + t := frameY_add_normal v α t z
  have hdz : dist z' p ^ 2 = (frameX v α z - frameX v α p) ^ 2 + (frameY v α z + t - frameY v α p) ^ 2 := by
    rw [sq_dist_frame v α z' p, hx', hy']
  have hdz0 : dist z p ^ 2 = (frameX v α z - frameX v α p) ^ 2 + (frameY v α z - frameY v α p) ^ 2 :=
    sq_dist_frame v α z p
  have hpN2 : dist p (v + e (α + π / 2)) ^ 2 = frameX v α p ^ 2 + (frameY v α p - 1) ^ 2 := by
    rw [sq_dist_frame v α p, frameX_N, frameY_N]; ring
  have hpv2 : dist p v ^ 2 = frameX v α p ^ 2 + frameY v α p ^ 2 := by
    rw [sq_dist_frame v α p v, frameX_self, frameY_self]; ring
  have hz'v : frameX v α z' ^ 2 + frameY v α z' ^ 2 = dist z' v ^ 2 := by
    rw [sq_dist_frame v α z' v, frameX_self, frameY_self]; ring
  have hzv : frameX v α z ^ 2 + frameY v α z ^ 2 = dist z v ^ 2 := by
    rw [sq_dist_frame v α z v, frameX_self, frameY_self]; ring
  set a := frameX v α p
  set b := frameY v α p
  set x := frameX v α z
  set y := frameY v α z
  have hpN' : a ^ 2 + (b - 1) ^ 2 ≤ 1 := by
    have := pow_le_pow_left₀ dist_nonneg hpN 2
    rw [hpN2] at this; linarith
  have hzr : dist z v ^ 2 < 1 / 64 := by
    have := pow_lt_pow_left₀ hz dist_nonneg (two_ne_zero); nlinarith
  have hz'r : dist z' v ^ 2 < 1 / 64 := by
    have := pow_lt_pow_left₀ hz' dist_nonneg (two_ne_zero); nlinarith
  have hd2 : dist z p ^ 2 < 1 := by
    have := pow_lt_pow_left₀ hd dist_nonneg (two_ne_zero); simpa using this
  rw [← sq_lt_one_iff₀ dist_nonneg]
  by_cases hcase : 1 / 4 ≤ a ^ 2 + b ^ 2
  · -- the point `p` is ahead of both: moving up only approaches it
    have hpN'' : a ^ 2 + b ^ 2 ≤ 2 * b := by
      have : (b - 1) ^ 2 = b ^ 2 - 2 * b + 1 := by ring
      linarith
    have hb : 1 / 8 ≤ b := by linarith
    have hy2 : y + t < 1 / 8 := by
      have h1 : (y + t) ^ 2 < (1 / 8) ^ 2 := by
        rw [← hy']; nlinarith [sq_nonneg (frameX v α z')]
      exact (abs_lt.mp (abs_lt_of_sq_lt_sq h1 (by norm_num))).2
    have hy1 : y ≤ y + t := by linarith
    have hle : t * (y + (y + t) - 2 * b) ≤ 0 := mul_nonpos_of_nonneg_of_nonpos ht (by linarith)
    have : dist z' p ^ 2 ≤ dist z p ^ 2 := by rw [hdz, hdz0]; nlinarith [hle]
    linarith
  · -- the point `p` is within `1/2` of `v`
    push Not at hcase
    have hpv' : dist p v < 1 / 2 := by
      have h1 : dist p v ^ 2 < (1 / 2) ^ 2 := by nlinarith
      exact lt_of_pow_lt_pow_left₀ 2 (by norm_num) h1
    have hz'v' : dist z' v < 1 / 8 := hz'
    have : dist z' p < 1 := by
      calc dist z' p ≤ dist z' v + dist v p := dist_triangle _ _ _
        _ < 1 / 8 + 1 / 2 := by rw [dist_comm v p]; linarith
        _ < 1 := by norm_num
    exact pow_lt_one₀ dist_nonneg this two_ne_zero

/-- **FS110-N3-CONF**, (iv) (N3-UP, the lune `p_y ≤ −1/2`, check C2): moving a point near `v` in the `+n` direction moves it
away from every point of the lune `B̄(S′, 1) ∖ B(v, 1)` — so a point clear of an out-type tile at `S′` (all of whose distances
exceed `1`) stays clear. -/
theorem lune_dist_le_of_up (v : ℂ) (α : ℝ) {z : ℂ} (hz : dist z v < 1 / 2) {t : ℝ} (ht : 0 ≤ t)
    {p : ℂ} (hp : p ∈ closedBall (v - e (α + π / 2)) 1 \ ball v 1) : dist z p ≤ dist (z + t * e (α + π / 2)) p := by
  obtain ⟨hpS, hpv⟩ := hp
  rw [mem_closedBall] at hpS
  rw [mem_ball, not_lt] at hpv
  have hdz : dist (z + (t : ℂ) * e (α + π / 2)) p ^ 2 =
      (frameX v α z - frameX v α p) ^ 2 + (frameY v α z + t - frameY v α p) ^ 2 := by
    rw [sq_dist_frame v α _ p, frameX_add_normal, frameY_add_normal]
  have hdz0 : dist z p ^ 2 = (frameX v α z - frameX v α p) ^ 2 + (frameY v α z - frameY v α p) ^ 2 :=
    sq_dist_frame v α z p
  have hpS2 : dist p (v - e (α + π / 2)) ^ 2 = frameX v α p ^ 2 + (frameY v α p + 1) ^ 2 := by
    rw [sq_dist_frame v α p, frameX_S, frameY_S]; ring
  have hpv2 : dist p v ^ 2 = frameX v α p ^ 2 + frameY v α p ^ 2 := by
    rw [sq_dist_frame v α p v, frameX_self, frameY_self]; ring
  have hzv : frameX v α z ^ 2 + frameY v α z ^ 2 = dist z v ^ 2 := by
    rw [sq_dist_frame v α z v, frameX_self, frameY_self]; ring
  set a := frameX v α p
  set b := frameY v α p
  set y := frameY v α z
  have hpS' : a ^ 2 + (b + 1) ^ 2 ≤ 1 := by
    have := pow_le_pow_left₀ dist_nonneg hpS 2
    rw [hpS2] at this; linarith
  have hpv' : 1 ≤ a ^ 2 + b ^ 2 := by
    have := pow_le_pow_left₀ zero_le_one hpv 2
    rw [hpv2] at this; linarith
  have hb : b ≤ -1 / 2 := by
    have : (b + 1) ^ 2 = b ^ 2 + 2 * b + 1 := by ring
    linarith
  have hy : -(1 / 2) < y := by
    have h1 : y ^ 2 < (1 / 2) ^ 2 := by
      have := pow_lt_pow_left₀ hz dist_nonneg two_ne_zero
      nlinarith [sq_nonneg (frameX v α z)]
    exact (abs_lt.mp (abs_lt_of_sq_lt_sq h1 (by norm_num))).1
  have hle : 0 ≤ t * (2 * (y - b) + t) := mul_nonneg ht (by linarith)
  have : dist z p ^ 2 ≤ dist (z + (t : ℂ) * e (α + π / 2)) p ^ 2 := by rw [hdz, hdz0]; nlinarith [hle]
  exact (pow_le_pow_iff_left₀ dist_nonneg dist_nonneg two_ne_zero).mp this

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## FS110-N3-DEG -/

/-- **FS110-N3-DEG**, the cone with unit arcs allowed: if `int D_c(v)` is empty then for some axis `α` the colour `c` has
out-type contacts at both `v ± n`, and every `c`-sector at `v` is a cusp horn along `±a` with bounding curvatures in
`[−1, 1]`. -/
theorem woodallCone (hF : F.Valid) {v : ℂ} {c : Fin k} (hv : F.Covers v 1) (hc : c ∈ F.coloursAt v)
    (hD : interior (F.allowedCone v c) = ∅) :
    ∃ α : ℝ, (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) ∧
      ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ S ∈ F.sectorsOf v r c, ∃ β ∈ ({α, α + π} : Set ℝ), ∃ κ₁ κ₂,
        -1 ≤ κ₁ ∧ κ₁ < κ₂ ∧ κ₂ ≤ 1 ∧ S = hornSet v β κ₁ κ₂ r := by
  sorry

/-- **FS110-N3-DEG** as filed (Condition 5): the bounding curvatures of Woodall's cone lie in the open interval `(−1, 1)`. -/
theorem woodallCone_strict (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} {c : Fin k} (hv : F.Covers v 1)
    (hc : c ∈ F.coloursAt v) (hD : interior (F.allowedCone v c) = ∅) :
    ∃ α : ℝ, (F.IsContact v c (v + e (α + π / 2)) ∧ F.OutType v c (v + e (α + π / 2))) ∧
      (F.IsContact v c (v - e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2))) ∧
      ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ S ∈ F.sectorsOf v r c, ∃ β ∈ ({α, α + π} : Set ℝ), ∃ κ₁ κ₂,
        -1 < κ₁ ∧ κ₁ < κ₂ ∧ κ₂ < 1 ∧ S = hornSet v β κ₁ κ₂ r := by
  sorry

/-! ## FS110-N4-SHADOW: N4-FLANK -/

/-- **FS110-N4-SHADOW**, N4-FLANK: for a `c`-horn along `a` with curvatures in `(−1, 1)`, upper flank `g` and lower flank `h`
(both `≠ c`), the points of the horn near `v` in the shadow of `g`'s class are exactly those below a tangent circle of some
curvature `σ_g ≤ κ₂`, and those in the shadow of `h`'s class exactly those above one of curvature `σ_h ≥ κ₁` (an absent shadow
is `σ_g = κ₁`, `σ_h = κ₂`). -/
theorem flank_shadows (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c g h : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 < κ₁) (h2 : κ₂ < 1) (hg : F.IsFlankAbove v α κ₂ g)
    (hh : F.IsFlankBelow v α κ₁ h) (hgc : g ≠ c) (hhc : h ≠ c) :
    ∃ σg σh, κ₁ ≤ σg ∧ σg ≤ κ₂ ∧ κ₁ ≤ σh ∧ σh ≤ κ₂ ∧ ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (z ∈ shadow (F.region g) ↔ TanBelow v α σg z) ∧ (z ∈ shadow (F.region h) ↔ TanAbove v α σh z) := by
  sorry

/-! ## FS110-N4-SHAVE -/

/-- **FS110-N4-SHAVE**, the criterion: a horn with curvatures in `(−1, 1)` that is not doubly shadowed by its flanks can be
shaved (SHAVE is available at `v`). -/
theorem shaveAvailable_of_not_doublyShadowed (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 1)
    {α κ₁ κ₂ : ℝ} {c g h : Fin k} (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 < κ₁) (h2 : κ₂ < 1)
    (hg : F.IsFlankAbove v α κ₂ g) (hh : F.IsFlankBelow v α κ₁ h) (hgc : g ≠ c) (hhc : h ≠ c)
    (hnot : ¬ F.DoublyShadowed v α κ₁ κ₂ g h) : F.ShaveAvailable v := by
  sorry

/-- **FS110-N4-SHAVE**, the move: where SHAVE is available at `v` for a colour `c` with `n ≥ 1` sectors, recolouring the horn's
tip gives a valid map, agreeing with `F` off a small disc about `v` and creating no unit arc (Condition 5 kept when `F` has it),
in which `c` has `n − 1` sectors at `v`, no colour is added at `v`, and the new points on the disc's rim carry at most three
colours. Unit arcs are allowed (FS112-WALK, row 7: the split circle has curvature `σ ∈ [κ₁, κ₂] ⊆ [−1, 1]`, and `σ = ±1` puts it on
the horn's own bounding arc); the curvature bounds are what keeps the move from creating a unit arc. -/
theorem exists_shave (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ σ : ℝ} {c g h : Fin k}
    {n : ℕ} (hn : F.HasSectors v c (n + 1)) (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : -1 ≤ κ₁) (h2 : κ₂ ≤ 1)
    (hg : F.IsFlankAbove v α κ₂ g) (hh : F.IsFlankBelow v α κ₁ h) (hσ₁ : κ₁ ≤ σ) (hσ₂ : σ ≤ κ₂)
    (hclear : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₁ κ₂ r,
      (TanAbove v α σ z → F.IsClear g z) ∧ (¬ TanAbove v α σ z → F.IsClear h z)) :
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 := by
  sorry

/-- **FS110-N4-SHAVE**, N4-RAY: two `c`-horns along one ray merge — the region between them is `c`-clear near `v`, and
recolouring it gives a valid map, agreeing with `F` off a small disc about `v` and creating no unit arc, in which `c` has one
sector fewer at `v`. Unit arcs are allowed and the outer bounds may be `±1` (FS112-WALK W3: the region between the horns is bounded
by their inner arcs, of curvatures strictly inside `(−1, 1)`). -/
theorem exists_rayMerge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c : Fin k}
    {n : ℕ} (hn : F.HasSectors v c (n + 1)) (h23 : κ₂ < κ₃) (hH : F.IsHorn v α κ₁ κ₂ c) (hH' : F.IsHorn v α κ₃ κ₄ c)
    (h1 : -1 ≤ κ₁) (h4 : κ₄ ≤ 1) :
    (∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ z ∈ hornSet v α κ₂ κ₃ r, F.IsClear c z) ∧
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧
      F'.HasSectors v c n ∧ F'.coloursAt v ⊆ F.coloursAt v ∧ ∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 := by
  sorry

/-! ## FS110-W-MERGE -/

/-- **FS110-W-MERGE**, Woodall's step 3 almost everywhere for curved arcs: if `int D_c(v)` is non-empty and `c` has `n + 1 ≥ 2`
sectors at `v`, recolouring a gap inside `D_c(v)` near `v` gives a valid map, equal to `F` off a small disc about `v`, in which
`c` has `n` sectors at `v`, no point off the disc's rim gains a colour, the new points on the rim carry at most three colours
with none repeated, no other point's allowed cone for `c` changes, and no unit arc is created (so Condition 5 is kept). Condition 5 is not assumed
(FS112-WALK). -/
theorem exists_merge (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
    (hn : F.HasSectors v c (n + 1)) (hD : (interior (F.allowedCone v c)).Nonempty) :
    ∃ ρ > 0, ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧ F'.HasSectors v c n ∧ (∀ x ∉ sphere v ρ, F'.coloursAt x ⊆ F.coloursAt x) ∧
      (∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 ∧ ¬ F'.HasRepeatedColour x) ∧
      ∀ v' ∉ closedBall v ρ, F'.allowedCone v' c = F.allowedCone v' c := by
  sorry

/-! ## FS110-N4-STUCK -/

/-- **FS110-N4-STUCK**, the structure (N4-STUCK (i)–(iv)), stated over "at most three colours at every point of `B̄(v, 1)`"
(the class its argument reads; FS110-NB-4 supplies it under Condition 5): at a stuck vertex the colour `c` with two or more
sectors has exactly two, cusp horns along `±a` with curvatures in `(−1, 1)`; `P_cl(v) = {c, g, h}` and `v` has degree `4`, the
interior points near `v` above the axis of colour `g` or `c` and below it of colour `h` or `c`; `g`'s contacts on `ω(v)` are
out-type at `S′` only, `h`'s out-type at `N` only, `c`'s out-type at both; `P_cl(N) = {c, h, r}` with `r ∉ P_cl(v)` and `h`
with at least two sectors at `N`, and `P_cl(S′) = {c, g, r′}` with `r′ ∉ P_cl(v)` and `g` with at least two sectors at `S′`. -/
theorem stuck_structure (hF : F.Valid) (h5 : F.Condition5) {v : ℂ} (hv : F.Covers v 2)
    (h3 : ∀ x ∈ closedBall v 1, (F.coloursAt x).ncard ≤ 3) (hst : F.IsStuck v) {c : Fin k} {m : ℕ} (hm : 2 ≤ m)
    (hc : F.HasSectors v c m) :
    ∃ α κ₁ κ₂ κ₃ κ₄ : ℝ, ∃ g h r r' : Fin k,
      F.IsHorn v α κ₁ κ₂ c ∧ F.IsHorn v (α + π) κ₃ κ₄ c ∧ -1 < κ₁ ∧ κ₂ < 1 ∧ -1 < κ₃ ∧ κ₄ < 1 ∧
      F.HasSectors v c 2 ∧ F.HasDegree v 4 ∧ F.coloursAt v = {c, g, h} ∧ g ≠ h ∧ g ≠ c ∧ h ≠ c ∧
      (∀ᶠ ρ in 𝓝[>] (0 : ℝ), ∀ z ∈ F.interiorPts ∩ ball v ρ,
        (0 < frameY v α z → F.col z = g ∨ F.col z = c) ∧ (frameY v α z < 0 → F.col z = h ∨ F.col z = c)) ∧
      (∀ w, F.IsContact v g w → w = v - e (α + π / 2) ∧ F.OutType v g w) ∧
      (∀ w, F.IsContact v h w → w = v + e (α + π / 2) ∧ F.OutType v h w) ∧
      F.OutType v c (v + e (α + π / 2)) ∧ F.OutType v c (v - e (α + π / 2)) ∧
      F.coloursAt (v + e (α + π / 2)) = {c, h, r} ∧ r ∉ F.coloursAt v ∧
      (∀ᶠ ρ in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (v + e (α + π / 2)) ρ h).encard) ∧
      F.coloursAt (v - e (α + π / 2)) = {c, g, r'} ∧ r' ∉ F.coloursAt v ∧
      (∀ᶠ ρ in 𝓝[>] (0 : ℝ), 2 ≤ (F.sectorsOf (v - e (α + π / 2)) ρ g).encard) := by
  sorry

/-- **FS110-N4-STUCK**, N4-PROP: in a terminal valid map of the plane with Condition 5 and at most three colours at every point,
a stuck vertex whose stuck colour has a horn along `e α` forces stuck vertices at every point `v + jn`, `j ∈ ℤ`, of its normal
line. -/
theorem stuck_chain (hF : F.Valid) (h5 : F.Condition5) (hP : F.IsPlaneMap) (hT : F.Terminal)
    (h3 : ∀ x, (F.coloursAt x).ncard ≤ 3) {v : ℂ} (hst : F.IsStuck v) {α κ₁ κ₂ : ℝ} {c : Fin k} {m : ℕ} (hm : 2 ≤ m)
    (hc : F.HasSectors v c m) (hH : F.IsHorn v α κ₁ κ₂ c) :
    ∀ j : ℤ, F.IsStuck (v + (j : ℂ) * e (α + π / 2)) := by
  sorry

end ArcMap

end HadwigerNelson.Plane
