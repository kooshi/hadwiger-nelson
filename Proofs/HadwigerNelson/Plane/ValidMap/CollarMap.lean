import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.LocalStructure
import Proofs.HadwigerNelson.Plane.ValidMap.RadialPush
import Proofs.HadwigerNelson.Plane.ValidMap.Pushforward

/-!
# The collar bend's map (FS131-CG1, lane G)

The collar's fit to the map (`CollarFit`), its homeomorphism, the bent map `CollarFit.map`, and the geometric clauses of
`bend_toward_collar` read off it (`map_Γ`, `map_lens`, `map_agreesOff`, `map_valid`): moved verbatim from `BendCollar` (FS131-KP2's
skeleton; inventory ruling 395 (a)), so the collar bend's two lanes never share a file. The charts, the sides, `exists_collarFit` and the
assembly stay in `BendCollar`.
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

end Collar

end ArcMap

end HadwigerNelson.Plane
