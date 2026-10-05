import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.LocalStructure
import Proofs.HadwigerNelson.Plane.ValidMap.RadialPush
import Proofs.HadwigerNelson.Plane.ValidMap.Pushforward

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

/-! ## The collar's fit to the map (FS131-KP2's skeleton; `plans/FS131-collar-kernel-plan.md` § 3)

The construction (KB2's D1): three radii `1/2 < R' < R < 1 < R''`. The lens boundary `β = lensCurve P θ₁ θ₂ R` is made of the circles of
radius `R` internally tangent to `ω(P)` at the ends (`collarArcA`, `collarArcB`); the collar `K = collarK P θ₁ θ₂ R' R''` lies between the
circles of radius `R'` (inside) and `R''` (enclosing), tangent at the ends — so at a horn end each has a germ of the arc's direction and
curvature near `1`, and fits inside the horn. The homeomorphism is the radial push about `P` across `K` sending `α` onto `β`
(`pushHomeo`); the bent map is `F`'s image under it (`pushforward`), its arcs `F`'s with the open arc cut out (`cutArcs`) and the two arcs
of `β`. Everything the map-level proofs read about `F` is in `CollarFit`, which `exists_collarFit` supplies. -/

section Collar

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-- **The collar fits the map**: the radii are ordered; the arc is a constant-sided unit arc of at most `60°` with `Γ` free near each
interior point (`hfree`); the collar lies in the `ε`-neighbourhood of the arc and in the domain, and meets `Γ` only on the arc; and the
open lens is clear for the outer colour. Inhabitant: `exists_collarFit`, at any map satisfying `bend_toward_collar`'s hypotheses (a model
map for those is the plan's child `collarModel`, § 4). -/
structure CollarFit (F : ArcMap k) (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) (ε R' R R'' : ℝ) : Prop where
  /-- The arc is a constant-sided unit arc. -/
  ring : F.IsRingArc P θ₁ θ₂ c c'
  /-- It is at most `60°` long (`l60_le`). -/
  short : θ₂ - θ₁ ≤ π / 3
  /-- The radii. -/
  params : 1 / 2 < R' ∧ R' < R ∧ R < 1 ∧ 1 < R''
  /-- Near each interior point of the arc, `Γ` is `ω(P)`. -/
  free_open : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1
  /-- The collar lies within `ε` of the arc. -/
  sub_thick : collarK P θ₁ θ₂ R' R'' ⊆ thickening ε (ringArc P θ₁ θ₂)
  /-- The collar lies in the domain. -/
  sub_dom : collarK P θ₁ θ₂ R' R'' ⊆ F.dom
  /-- The collar meets `Γ` only on the arc. -/
  free : F.Γ ∩ collarK P θ₁ θ₂ R' R'' ⊆ ringArc P θ₁ θ₂
  /-- The open lens is clear for the outer colour. -/
  clear : ∀ z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (lensProf θ₁ θ₂ R θ) 1), F.IsClear c' z

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

/-- **The inner collar has the inner colour**: `{a(θ) ≤ t < 1}` over `(θ₁, θ₂)` is connected, `Γ`-free (`free`), inside `B(P, 1)`, and
its closure meets the open arc, whose inner colour is `c` alone. -/
theorem CollarFit.kin_subset (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (lensProf θ₁ θ₂ R' θ) 1) ⊆ F.region c := by
  sorry

/-- **The outer collar has the outer colour** (the same argument outside `B̄(P, 1)`). -/
theorem CollarFit.kout_subset (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (outerProf θ₁ θ₂ R'' θ)) ⊆ F.region c' := by
  sorry

/-- The collar's profiles are push profiles. -/
theorem CollarFit.pushProfiles (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    PushProfiles θ₁ θ₂ (lensProf θ₁ θ₂ R') (lensProf θ₁ θ₂ R) (outerProf θ₁ θ₂ R'') :=
  pushProfiles_collar hfit.params.1 hfit.params.2.1 hfit.params.2.2.1 hfit.params.2.2.2 hfit.ring.1 hfit.short

/-- **The collar's homeomorphism**: the radial push about `P` across the collar, sending `α` onto `β`. -/
noncomputable def CollarFit.homeo (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') : ℂ ≃ₜ ℂ :=
  pushHomeo P θ₁ θ₂ (lensProf θ₁ θ₂ R') (lensProf θ₁ θ₂ R) (outerProf θ₁ θ₂ R'') hfit.pushProfiles

/-- **The homeomorphism is the identity off the collar** (`pushHomeo_eq_self`; the open collar lies in `K`). -/
theorem CollarFit.homeo_eq_self (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ} (hz : z ∉ collarK P θ₁ θ₂ R' R'') :
    hfit.homeo z = z ∧ hfit.homeo.symm z = z := by
  sorry

/-- **The arc goes to the lens boundary**: `ringPt P θ ↦ P + lensProf θ₁ θ₂ R θ · e(θ)` (`pushHomeo_polar`, `push1_mid`). -/
theorem CollarFit.homeo_ringPt (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    hfit.homeo (ringPt P θ) = P + (lensProf θ₁ θ₂ R θ : ℂ) * e θ := by
  sorry

/-- **The homeomorphism fixes `Γ` off the open arc**: such a point is off the collar (`free`) or an end (`a = b = 1` there). -/
theorem CollarFit.homeo_fix_Γ (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ} (hz : z ∈ F.Γ)
    (hzO : z ∉ ringPt P '' Ioo θ₁ θ₂) : hfit.homeo z = z := by
  sorry

/-- The homeomorphism keeps the domain (the identity off the collar, which lies in the domain and is carried onto itself). -/
theorem CollarFit.homeo_image_dom (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') : hfit.homeo '' F.dom = F.dom := by
  sorry

/-- **The bent map's arcs**: `F`'s with the open arc cut out, and the lens boundary's two arcs. -/
def collarArcs (F : ArcMap k) (P : ℂ) (θ₁ θ₂ R : ℝ) : Set Arc :=
  F.cutArcs P θ₁ θ₂ ∪ {collarArcA P θ₁ θ₂ R, collarArcB P θ₁ θ₂ R}

/-- The bent map's arcs are non-degenerate (`cutArcs_nondegenerate`, `germArc_nondegenerate`: `X ≠ A`, `X ≠ B`). -/
theorem CollarFit.collarArcs_nondegenerate (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    ∀ a ∈ collarArcs F P θ₁ θ₂ R, a.Nondegenerate := by
  sorry

/-- The bent map's arcs are locally finite on the domain (the cut's, and two more). -/
theorem collarArcs_locallyFinite :
    ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {a | a ∈ collarArcs F P θ₁ θ₂ R ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  intro x hx
  obtain ⟨t, ht, hfin⟩ := F.cutArcs_locallyFinite (P := P) (θ₁ := θ₁) (θ₂ := θ₂) x hx
  refine ⟨t, ht, (hfin.union ((Set.finite_singleton (collarArcB P θ₁ θ₂ R)).insert (collarArcA P θ₁ θ₂ R))).subset ?_⟩
  rintro b ⟨hb | hb, hbt⟩
  · exact Or.inl ⟨hb, hbt⟩
  · exact Or.inr hb

/-- **The new arcs carry `h(Γ)`**: inside the domain, the cut's arcs are `Γ` off the open arc (`mem_cutArcs_iff` off `α°` and the ends;
on `α°` no arc of `F` but `ω(P)`'s passes, by `free_open`, so the cut leaves nothing there), and the two arcs are `β`
(`collarArcs_carrier`), which holds the ends; `h(Γ) = (Γ ∖ α°) ∪ h(α°)` (`homeo_fix_Γ`) and `h(α°) = β°` (`homeo_ringPt`). -/
theorem CollarFit.collarArcs_Γ (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    F.dom ∩ ⋃ a ∈ collarArcs F P θ₁ θ₂ R, a.carrier = hfit.homeo '' F.Γ := by
  sorry

/-- **The bent map**: `F`'s image under the collar's homeomorphism, with the arcs `collarArcs`. -/
noncomputable def CollarFit.map (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') : ArcMap k :=
  F.pushforward hfit.homeo hfit.homeo_image_dom (collarArcs F P θ₁ θ₂ R) hfit.collarArcs_nondegenerate collarArcs_locallyFinite
    hfit.collarArcs_Γ

/-- **The bent map's `Γ`**: `F`'s off the open arc, and the lens boundary. -/
theorem CollarFit.map_Γ (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.map.Γ = (F.Γ \ ringPt P '' Ioo θ₁ θ₂) ∪ lensCurve P θ₁ θ₂ R := by
  sorry

/-- **The lens is the outer colour's**: the lens with the open arc is interior in the bent map, of colour `c'` (it is `h`'s image of part
of the outer collar, `kout_subset`). -/
theorem CollarFit.map_lens (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ} (hz : z ∈ lensSet P θ₁ θ₂ R) :
    z ∈ hfit.map.interiorPts ∧ hfit.map.col z = c' := by
  sorry

/-- **The bent map agrees with `F` off the closed lens** (`lensSet ∪ lensCurve`): off the collar `h` is the identity; on the collar off
the closed lens, `h` moves points within the inner collar (colour `c`) or within the outer collar (colour `c'`). -/
theorem CollarFit.map_agreesOff (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.map.AgreesOff F (lensSet P θ₁ θ₂ R ∪ lensCurve P θ₁ θ₂ R) := by
  sorry

/-- **The bent map is valid** (clause 1). Route: `Valid.of_agreesOff` on the closed lens (`map_agreesOff`); its interior points in the bent
map are `lensSet`, of colour `c'` (`map_lens`), clear for `c'` in `F` (`clear` inside, `ne1_region` on the open arc), and no two of them
are `1` apart (`dist_lt_one_of_mem_polarSet`). -/
theorem CollarFit.map_valid (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') : hfit.map.Valid := by
  sorry

/-- **`F` at a point of the open arc**: degree `2`, its sectors coloured `c` (inside) and `c'` (outside). Route: `Γ` near the point is
`ω(P)` (`free_open`), a two-germ sector chart (`isSectorChart_of` with the germs `(θ + π/2, 1)`, `(θ − π/2, −1)`; branches by
`exists_eq_branchPt_curveGerm`, `branchPt_curveGerm_mem`), `IsSectorChart.hasDegree`, `IsSectorChart.encard_sectorsOf`. -/
theorem CollarFit.degree_openArc (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    (∀ n, F.HasDegree (ringPt P θ) n ↔ n = 2) ∧ (F.HasRepeatedColour (ringPt P θ) ↔ c = c') := by
  sorry

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
