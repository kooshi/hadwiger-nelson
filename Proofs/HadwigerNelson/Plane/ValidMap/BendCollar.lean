import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.LocalStructure
import Proofs.HadwigerNelson.Plane.ValidMap.RadialPush
import Proofs.HadwigerNelson.Plane.ValidMap.Pushforward
import Proofs.HadwigerNelson.Plane.ValidMap.CollarMap

/-!
# The collar bend (FS131-KB2)

`bend_toward_collar`, the strengthened toward bend `exists_preBend` iterates (FS131-E4's E4-BEND-UN with R1–R3 and no new inert arc;
FS131-I5o's statement, moved verbatim from `data/fs131/i5o/BendCollar.lean`, rulings 360, 366, 370 (d)). Its construction: a lens
bounded by circles internally tangent to the arc at its two ends (so a horn-shaped tip fits a horn), the push of the arc across a collar
along the rays from its centre, and the bent map as the image of the old one under that homeomorphism (`plans/FS131-I5-implementation.md`
§ 44).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

section Collar

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-- **The collar exists** (the F-dependent choice; plan § 4, child C1). Route: `R` close to `1` puts the lens under `bend_toward`'s
profile (`one_sub_lensProf_le` against `n2_env_toward`, `n2_env_near` with `r` from `hout`), so `toward_clear` gives `clear`; `R'`, `R''`
close to `1` make the collar thin (`one_sub_tangRad_le`, `tangRad_sub_one_le`): within `ε`, inside the domain (a compact arc in an open
set), and `Γ`-free off the arc — in the middle by `hfree` and a Lebesgue number on a compact sub-arc, at each end by the end's sector
chart (`localSectors_disj`): the collar near `A` is the horn between the germs `(θ₁ + π/2, 1/R'')` and `(θ₁ + π/2, 1/R')`, which holds no
germ of `F` but `α`'s once both curvatures are nearer `1` than every other germ of that direction. `l60_le` gives `short`. -/
theorem exists_collarFit (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hout : c' ∉ F.coloursAt P)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) (hε : 0 < ε) :
    ∃ R' R R'', CollarFit F P θ₁ θ₂ c c' ε R' R R'' := by
  sorry

/-- **`F` at a point of the open arc**: degree `2`, its sectors coloured `c` (inside) and `c'` (outside). Route: `Γ` near the point is
`ω(P)` (`free_open`), a two-germ sector chart (`isSectorChart_of` with the germs `(θ + π/2, 1)`, `(θ − π/2, −1)`; branches by
`exists_eq_branchPt_curveGerm`, `branchPt_curveGerm_mem`), `IsSectorChart.hasDegree`, `IsSectorChart.encard_sectorsOf`. -/
theorem CollarFit.degree_openArc (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    (∀ n, F.HasDegree (ringPt P θ) n ↔ n = 2) ∧ (F.HasRepeatedColour (ringPt P θ) ↔ c = c') := by
  obtain ⟨r₁, hr₁, hfr⟩ := hfit.free_open θ hθ
  have hvΓ : ringPt P θ ∈ F.Γ := hfit.ring.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩
  obtain ⟨r₂, hr₂, hdom⟩ := Metric.isOpen_iff.mp F.isOpen_dom _ hvΓ.1
  obtain ⟨r₃, hr₃, hsph⟩ := exists_sphere_inter_ball_subset_openArc (p := P) hθ
  set r₀ := min (min r₁ r₂) (min r₃ 1) with hr₀
  have h0 : 0 < r₀ := lt_min (lt_min hr₁ hr₂) (lt_min hr₃ one_pos)
  have h1 : r₀ ≤ r₁ := (min_le_left _ _).trans (min_le_left _ _)
  have h2 : r₀ ≤ r₂ := (min_le_left _ _).trans (min_le_right _ _)
  have h3 : r₀ ≤ r₃ := (min_le_right _ _).trans (min_le_left _ _)
  have h4 : r₀ ≤ 1 := (min_le_right _ _).trans (min_le_right _ _)
  refine degree_of_circle (q := P) (φ := θ) one_pos (by simp [ringPt]) h0 (by linarith) ((ball_subset_ball h2).trans hdom) ?_
    (fun d hd => ?_) (fun d hd => ?_)
  · apply Subset.antisymm
    · rintro z ⟨hzΓ, hzb⟩
      exact ⟨hfr ⟨hzΓ, ball_subset_ball h1 hzb⟩, hzb⟩
    · rintro z ⟨hzs, hzb⟩
      obtain ⟨t, ht, rfl⟩ := hsph ⟨hzs, ball_subset_ball h3 hzb⟩
      exact ⟨hfit.ring.2.1 ⟨t, Ioo_subset_Icc_self ht, rfl⟩, hzb⟩
  · have : d ∈ F.innerColours P (ringPt P θ) := hd
    rw [(hfit.ring.2.2 θ hθ).1] at this
    exact this
  · have : d ∈ F.outerColours P (ringPt P θ) := hd
    rw [(hfit.ring.2.2 θ hθ).2] at this
    exact this

/-- **The bent map at a point of the lens boundary**: degree `2`, sectors `c` (inside `β`) and `c'` (the lens). Route: `Γ` near the point
is one circle of radius `R` (`map_Γ`, the collar `Γ`-free), or at `X` the two arcs meeting transversally — a two-germ chart either way. -/
theorem CollarFit.map_degree_lensCurve (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    (∀ n, hfit.map.HasDegree (P + (lensProf θ₁ θ₂ R θ : ℂ) * e θ) n ↔ n = 2) ∧
      (hfit.map.HasRepeatedColour (P + (lensProf θ₁ θ₂ R θ : ℂ) * e θ) ↔ c = c') := by
  sorry

/-- **At the arc's ends the sectors are kept** (KB2's chart surgery). Route: `F`'s chart at `A` (`localSectors_disj`) has `α`'s germ
`(θ₁ + π/2, 1)` at some index `i` (`α`'s points near `A` are its branch); the bent map's chart is the same germs with `κ i := 1/R`
(`isSectorChart_of`: sorted, since the collar horn holds no other germ — `free`; branches by `map_Γ`; apart by `exists_germDir_ne_of_ne`);
the sector before `i` gains the lens (colour `c'`, as before), the sector from `i` loses it (colour `c`, as before), the others are
untouched — so the colour of every sector is kept (`IsSectorChart.encard_sectorsOf`, `IsSectorChart.hasDegree`). At `B` the same with
`(θ₂ − π/2, −1)` and `−1/R`. -/
theorem CollarFit.map_degree_end (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {v : ℂ}
    (hv : v = ringPt P θ₁ ∨ v = ringPt P θ₂) :
    (∀ n, hfit.map.HasDegree v n ↔ F.HasDegree v n) ∧ (hfit.map.HasRepeatedColour v ↔ F.HasRepeatedColour v) := by
  sorry

/-- **Degrees are carried** (clause 6). Route, by the place of `z`: off the collar the maps agree near `z` (`homeo_eq_self` on a ball,
`hasDegree_iff_of_agree`); at interior points of the collar both are interior (`hasDegree_iff_of_mem_interiorPts`); on the open arc
`degree_openArc` and `map_degree_lensCurve` at `h z` (`homeo_ringPt`); at the ends `map_degree_end` (`h` fixes them). -/
theorem CollarFit.map_hasDegree (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') (z : ℂ) (n : ℕ) :
    hfit.map.HasDegree (hfit.homeo z) n ↔ F.HasDegree z n := by
  sorry

/-- **Repeated colours are carried** (clause 7; the same cases, with `not_hasRepeatedColour_of_mem_interiorPts` at interior points). -/
theorem CollarFit.map_hasRepeatedColour (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') (z : ℂ) :
    hfit.map.HasRepeatedColour (hfit.homeo z) ↔ F.HasRepeatedColour z := by
  sorry

/-- **No unit arc is created**: the bent map's `Γ` lies in `F`'s and the lens boundary's two arcs, of radius `R ≠ 1`
(`ringArcsWithin_of_Γ_subset`, `germArc_isUnitArc_iff`). -/
theorem CollarFit.map_ringArcsWithin (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') : hfit.map.RingArcsWithin F := by
  sorry

/-- **The sides of a unit circle through an end are kept**: near `A` the two maps differ only on the collar's horn (with `α`), which misses
`ω(Q)` for `Q ≠ P` (its germs at `A` are `α`'s direction with curvature near `1`; `ω(Q)`'s there have another direction or curvature
`−1`) and so lies on one side of it; on that side both maps carry `c` and `c'` up to `A`. -/
theorem CollarFit.sides_end (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q x : ℂ} (hQ : Q ≠ P)
    (hx : x = ringPt P θ₁ ∨ x = ringPt P θ₂) :
    hfit.map.innerColours Q x = F.innerColours Q x ∧ hfit.map.outerColours Q x = F.outerColours Q x := by
  sorry

/-- **R1** (clause 8). Route: the arc lies in `F`'s `Γ` (`map_ringArcsWithin`); its interior points are off `α°` (`α° ∩ M.Γ = ∅`) and off
`β°` (`β° ⊆ F`'s interior points), so off the collar — where the maps agree near the point — or at an end (`sides_end`; `Q ≠ P`, since a
ring arc of `ω(P)` in the bent map misses `α°` and lies in `F`'s). -/
theorem CollarFit.map_R1 (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
    (h : hfit.map.IsRingArc Q a b d d') : F.IsRingArc Q a b d d' := by
  sorry

/-- **R2** (clause 9). Route: the closed arc misses `α°` (its open part by hypothesis; an end on `α°` would put an arc of `ω(Q) ≠ ω(P)` in
`Γ` near a point of `α°`, against `free_open`), so it lies in the bent map's `Γ` (`map_Γ`); sides as in `map_R1`. -/
theorem CollarFit.map_R2 (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
    (h : F.IsRingArc Q a b d d') (hd : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) :
    hfit.map.IsRingArc Q a b d d' := by
  sorry

/-- **R3** (clause 10): the open arc lies in the lens, interior in the bent map (`map_lens`), so off its `Γ`. -/
theorem CollarFit.map_R3 (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    ¬ hfit.map.OnRingArc P (ringPt P θ) := by
  sorry

/-- **Only `c` is lost, and only on the lens**: every colour `F` carries at `Q` the bent map carries, but `c`, which it can lose only at a
point of `lensSet` (the open lens or the open arc). -/
theorem CollarFit.coloursAt_subset (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') (Q : ℂ) :
    F.coloursAt Q ⊆ hfit.map.coloursAt Q ∪ {c} ∧ (c ∈ F.coloursAt Q → c ∉ hfit.map.coloursAt Q → Q ∈ lensSet P θ₁ θ₂ R) := by
  sorry

/-- **A unit arc centred on the lens carries no `c` on a side**: centred on the open arc by `lock` (the class of `c` meets `ω(Q)` in at
most two points); centred in the open lens, an open subset of `c`'s class, by `Valid.dist_ne_one_of_isOpen_subset_closure`. -/
theorem CollarFit.side_ne_inner_of_mem_lens (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ}
    (hQ : Q ∈ lensSet P θ₁ θ₂ R) {a b : ℝ} {d d' : Fin k} (h : F.IsRingArc Q a b d d') : d ≠ c ∧ d' ≠ c := by
  sorry

/-- **No inert arc is created** (clause 11): an inert arc of the bent map is a ring arc of `F` with the same sides (`map_R1`), neither side
`c` where `c` was lost (`coloursAt_subset`, `side_ne_inner_of_mem_lens`), so neither side is carried at its centre in `F`. -/
theorem CollarFit.map_inert (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ}
    (h : hfit.map.Inert Q a b) : F.Inert Q a b := by
  sorry

end Collar

/-- **The collar bend** (E4-BEND-UN with R1–R3; FS131-I5o's form): a whole maximal arc `α = r([θ₁, θ₂])` of `Γ` on `ω(P)` with constant
sides `c` (inner), `c'` (outer), `c'` not carried at `P`, shorter than the circle, whose open arc meets no other arc of `Γ` (`hfree`: near
each interior point `Γ` is `ω(P)`), bends toward `P` inside a collar of `α` in its inner tile. The bent map `M` is the image of `F` under a
homeomorphism `h` of the plane supported in `thickening ε α`, fixing every point of `Γ` off `α°` (so the ends `A`, `B` and every vertex),
carrying interior points to interior points of the same colour; so colours, degrees and repeated colours are carried point by point.
Metrically: `M` is valid, on `F`'s domain; its constant-sided unit arcs are `F`'s with the same sides (R1); `F`'s whose open arc misses `α°`
survive in `M` (R2); no point of `α°` is on a unit arc of `M` centred at `P` (R3); and no inert arc is created (validity forbids a unit
arc centred on `α°` or in the lens to carry `c` on a side, so the colours lost there make nothing inert). -/
theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hout : c' ∉ F.coloursAt P) (hlen : θ₂ - θ₁ < 2 * π)
    (hmax : ∀ θ₁' θ₂', ringArc P θ₁ θ₂ ⊆ ringArc P θ₁' θ₂' → F.IsRingArc P θ₁' θ₂' c c' →
      ringArc P θ₁' θ₂' = ringArc P θ₁ θ₂)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) {ε : ℝ} (hε : 0 < ε) :
    ∃ (M : ArcMap k) (h : ℂ ≃ₜ ℂ), M.Valid ∧ M.dom = F.dom ∧
      (∀ z ∉ thickening ε (ringArc P θ₁ θ₂), h z = z) ∧
      (∀ z ∈ F.Γ, z ∉ ringPt P '' Ioo θ₁ θ₂ → h z = z) ∧
      (∀ z, (h z ∈ M.interiorPts ↔ z ∈ F.interiorPts) ∧ (z ∈ F.interiorPts → M.col (h z) = F.col z)) ∧
      (∀ z, M.coloursAt (h z) = F.coloursAt z) ∧
      (∀ z n, M.HasDegree (h z) n ↔ F.HasDegree z n) ∧
      (∀ z, M.HasRepeatedColour (h z) ↔ F.HasRepeatedColour z) ∧
      (∀ Q a b d d', M.IsRingArc Q a b d d' → F.IsRingArc Q a b d d') ∧
      (∀ Q a b d d', F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
        M.IsRingArc Q a b d d') ∧
      (∀ θ ∈ Ioo θ₁ θ₂, ¬ M.OnRingArc P (ringPt P θ)) ∧
      (∀ Q a b, M.Inert Q a b → F.Inert Q a b) := by
  -- `hlen` follows from `l60_le` and `hmax` is not read: the construction bends any constant-sided arc with a free interior (plan § 2)
  have _ := hlen
  have _ := hmax
  obtain ⟨R', R, R'', hfit⟩ := exists_collarFit hF hA hout hfree hε
  refine ⟨hfit.map, hfit.homeo, hfit.map_valid hF, rfl, fun z hz => (hfit.homeo_eq_self fun hK => hz (hfit.sub_thick hK)).1,
    fun z hz hzO => hfit.homeo_fix_Γ hz hzO, fun z => ⟨pushforward_mem_interiorPts_iff z, fun _ => pushforward_col_apply z⟩,
    fun z => pushforward_coloursAt z, fun z n => hfit.map_hasDegree hF z n, fun z => hfit.map_hasRepeatedColour hF z,
    fun Q a b d d' h => hfit.map_R1 hF h, fun Q a b d d' h hd => hfit.map_R2 hF h hd, fun θ hθ => hfit.map_R3 hθ,
    fun Q a b h => hfit.map_inert hF h⟩

end ArcMap

end HadwigerNelson.Plane
