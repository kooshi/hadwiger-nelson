import Proofs.HadwigerNelson.Plane.Saturated.LocalGraph
import Proofs.HadwigerNelson.Plane.Saturated.FanExamples

/-!
# The bridge: an isolated singular point of a saturated colouring has a fan (FS-131 wave 6: FS131-E8)

`plans/FS131-E8-derivation.md` §§ 3.2–3.7, each entry **[hand], one mind, kernel pending** until this module lands
(`plans/FS131-w6-kernel-plan.md` § 11):

* `c.IsolatedAt z R` — the setting: `0 < R ≤ 1/2`, `z` the only possible singular point of `B(z, R)`, the colouring
  saturated at the essential boundary points of the punctured disc (never at `z`). Inhabitant: `sq9_isolatedAt`.
* **FS131-E8-GAMMA** — `gamma`: a component of the essential boundary in the punctured disc is an injective
  unit-speed curve of curvature at most `1`, of length at most `π/2`, each end at `z` or on the circle.
* **FS131-E8-BETA** — `IsUnitCurve.exists_polarGraph` (no colouring: a curve of length at most `π/2` is a polar graph
  about its start, with limit direction its initial tangent) and `beta` (a component with `z` in its closure is a
  polar graph over `(0, R)`).
* **FS131-E8-ALPHA** — `alpha`: finitely many components meet the half disc, and in a smaller disc every essential
  boundary point lies on a component that ends at `z`.
* **FS131-E8-FAN** — `fan_of_isolated`: a fan at `z` (for every `z` with `Σ ∩ B(z, R) ⊆ {z}`, singular or not);
  `Fan.two_le_n`, `Fan.col_ne` (at least two branches at a singular point; neighbouring regions differ — from the
  fan's fields alone).
* **FS131-E8-BRIDGE** — `regJFan_of_saturated` (**proved** from `fan_of_isolated`), `regJFan_iff_singLocallyFinite`:
  under saturation the fan form of REG-J′ is equivalent to `Σ` being locally finite.
* **FS131-E8-CLAUSE2** — `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`.
* The two facts FS-121's rows read at a branch, for **any** fan under saturation in its punctured disc:
  `Fan.branch_outside_discs` (the lens) and `Fan.branch_contacts` (FS121-V2's Lemma T (ii)).
* **FS121-V2-SECTOR** — `Fan.sector_alone`; **FS121-DB1-L3** (with FS111-W-NOREP) — `Fan.sector_unique`, its case
  (proved from it).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

namespace AeColouring

/-- **The setting of FS131-E8 §§ 3.2–3.4**: `z` is the only possible singular point of `B(z, R)`, `R ≤ 1/2`, and the
colouring is saturated at the essential boundary points of the punctured disc. -/
structure IsolatedAt (c : AeColouring k) (z : ℂ) (R : ℝ) : Prop where
  /-- The radius is positive. -/
  pos : 0 < R
  /-- The radius is at most `1/2` (a unit circle of interface fits in no such disc). -/
  le : R ≤ 1 / 2
  /-- `z` is the only possible singular point of the disc. -/
  sing : c.singularSet ∩ ball z R ⊆ {z}
  /-- Saturated at the essential boundary points of the punctured disc. -/
  sat : SaturatedOn c.cls (ball z R \ {z})

end AeColouring

/-- **Inhabitant of `IsolatedAt`**: `sq9` at the grid vertex, `R = 1/4`. -/
theorem sq9_isolatedAt : sq9.IsolatedAt sqVertex (1 / 4) :=
  ⟨by norm_num, by norm_num, sq9_singular_near_vertex, sq9_tight_saturated.2.1.saturatedOn _⟩

namespace AeColouring

variable {c : AeColouring k} {z : ℂ} {R : ℝ}

/-! ## FS131-E8-GAMMA, -BETA, -ALPHA -/

/-- **FS131-E8-GAMMA.** In the setting `IsolatedAt`, the connected component of the essential boundary in the
punctured disc through `y` is the image of `(0, L)` under an injective unit-speed curve of curvature at most `1` on
`[0, L]`, `0 < L ≤ π/2`; each of its two ends is `z` or a point of the circle `∂B(z, R)`. (The tangent has a limit at
each end: `IsUnitCurve` on the closed interval. Not closed: `γ` is injective on `[0, L]`.) -/
theorem gamma (h : c.IsolatedAt z R) {y : ℂ} (hy : y ∈ c.essBdry ∩ (ball z R \ {z})) :
    ∃ (L : ℝ) (γ : ℝ → ℂ) (ψ : ℝ → ℝ), 0 < L ∧ L ≤ Real.pi / 2 ∧ IsUnitCurve γ ψ (Icc 0 L) ∧ InjOn γ (Icc 0 L) ∧
      connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y = γ '' Ioo 0 L ∧
      (γ 0 = z ∨ γ 0 ∈ sphere z R) ∧ (γ L = z ∨ γ L ∈ sphere z R) := by
  sorry

end AeColouring

/-- **FS131-E8-BETA**, the curve's part (no colouring): a unit-speed curve of curvature at most `1` and length
`L ≤ π/2` is, off its start, a polar graph about its start out to the distance of its far end, with a continuous
angle that tends to the initial tangent angle. -/
theorem IsUnitCurve.exists_polarGraph {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {L : ℝ} (h : IsUnitCurve γ ψ (Icc 0 L)) (hL : 0 < L)
    (hLπ : L ≤ Real.pi / 2) :
    ∃ φ : ℝ → ℝ, ContinuousOn φ (Ioo 0 (dist (γ L) (γ 0))) ∧ Tendsto φ (𝓝[>] 0) (𝓝 (ψ 0)) ∧
      γ '' Ioo 0 L = polarGraph (γ 0) (dist (γ L) (γ 0)) φ := by
  sorry

namespace AeColouring

variable {c : AeColouring k} {z : ℂ} {R : ℝ}

/-- **FS131-E8-BETA.** In the setting `IsolatedAt`, a component of the essential boundary in the punctured disc with
`z` in its closure is a polar graph over `(0, R)` with a continuous angle that has a limit at `0` (its other end is
on the circle; no component has both ends at `z`). -/
theorem beta (h : c.IsolatedAt z R) {y : ℂ} (hy : y ∈ c.essBdry ∩ (ball z R \ {z}))
    (hz : z ∈ closure (connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y)) :
    ∃ (φ : ℝ → ℝ) (d : ℝ), ContinuousOn φ (Ioo 0 R) ∧ Tendsto φ (𝓝[>] 0) (𝓝 d) ∧
      connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y = polarGraph z R φ := by
  sorry

/-- **FS131-E8-ALPHA.** In the setting `IsolatedAt`, finitely many components of the essential boundary in the
punctured disc meet the closed disc of radius `R/2`, and there is `r ∈ (0, R/2]` such that every essential boundary
point of `B(z, r)` other than `z` lies on a component with `z` in its closure. -/
theorem alpha (h : c.IsolatedAt z R) :
    {K : Set ℂ | ∃ y ∈ c.essBdry ∩ (ball z R \ {z}),
        K = connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) y ∧ (K ∩ closedBall z (R / 2)).Nonempty}.Finite ∧
      ∃ r, 0 < r ∧ r ≤ R / 2 ∧ ∀ w ∈ c.essBdry ∩ (ball z r \ {z}),
        z ∈ closure (connectedComponentIn (c.essBdry ∩ (ball z R \ {z})) w) := by
  sorry

/-! ## FS131-E8-FAN, -BRIDGE, -CLAUSE2 -/

/-- **FS131-E8-FAN.** If `z` is the only possible singular point of `B(z, R)` and the colouring is saturated at the
essential boundary points of the punctured disc, then `z` has a fan. Not read: saturation at `z` or outside the
punctured disc; any clause about arcs meeting `z`; that `z` is singular; the number of colours. -/
theorem fan_of_isolated (c : AeColouring k) {z : ℂ} {R : ℝ} (hR : 0 < R) (hS : c.singularSet ∩ ball z R ⊆ {z})
    (hsat : SaturatedOn c.cls (ball z R \ {z})) : Nonempty (c.Fan z) := by
  sorry

/-- **FS131-E8-BRIDGE.** A saturated colouring whose singular set is locally finite satisfies REG-J′ in its fan form:
every singular point has a fan with end tangents. The frozen words' second clause is not read. -/
theorem regJFan_of_saturated (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) : c.RegJFan :=
  ⟨hS, fun z _ => by
    obtain ⟨R, hR, hsub⟩ := hS.exists_ball_subset z
    exact fan_of_isolated c hR hsub (hsat.saturatedOn _)⟩

/-- **Under saturation the fan form of REG-J′ is `Σ` locally finite** (FS131-E8-BRIDGE). -/
theorem regJFan_iff_singLocallyFinite (c : AeColouring k) (hsat : Saturated c.cls) :
    c.RegJFan ↔ c.SingLocallyFinite :=
  ⟨fun h => h.1, regJFan_of_saturated c hsat⟩

/-- **FS131-E8-CLAUSE2**, first clause: under saturation the frozen words of REG-J′ follow from their first clause —
every singular point lies in the closure of finitely many components of the interface set. -/
theorem regJLiteral_of_saturated (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) :
    c.RegJLiteral := by
  sorry

/-- **FS131-E8-CLAUSE2**, second clause: in a saturated colouring with locally finite singular set, a bounded set
meets finitely many components of the interface set. -/
theorem finite_arcs_of_isBounded (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
    {K : Set ℂ} (hK : Bornology.IsBounded K) :
    {A : Set ℂ | (∃ y ∈ c.interfaceSet, A = connectedComponentIn c.interfaceSet y) ∧ (A ∩ K).Nonempty}.Finite := by
  sorry

/-! ## What every fan carries under saturation -/

namespace Fan

variable (F : c.Fan z)

/-- **At a singular point a fan has at least two branches** (FS131-E8-FAN). Saturation is not read: with no branch
the punctured disc is of one colour and `z` is a density point; with one, its points are density points. -/
theorem two_le_n (hz : z ∈ c.singularSet) : 2 ≤ F.n := by
  sorry

/-- **The regions on the two sides of a branch have different colours** (FS131-E8-FAN): `j` is the region clockwise
of branch `i`. Saturation is not read. -/
theorem col_ne {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) : F.col j ≠ F.col i := by
  sorry

/-- **The lens**: under saturation in the punctured disc, within distance `1/2` of `z` each branch stays outside the
two open unit discs tangent to its limit direction at `z` — the comparison FS121-V2-SECTOR and FS121-V3's (F-c)
make (`IsUnitCurve.one_le_dist` on the branch's arclength parametrization). -/
theorem branch_outside_discs (hsat : SaturatedOn c.cls (ball z F.r \ {z})) (i : Fin F.n) {t : ℝ}
    (ht : t ∈ Ioo 0 (min F.r (1 / 2))) :
    1 ≤ dist (polarPt z t (F.φ i t)) (z + I * e (F.dir i)) ∧
      1 ≤ dist (polarPt z t (F.φ i t)) (z - I * e (F.dir i)) := by
  sorry

/-- **The contacts at a branch** (FS121-V2-verification § 2.1, Lemma T (ii), with FS111-M-C11 (iii) along the branch):
under saturation in the punctured disc, branch `i` — with the region `j` clockwise of it and the region `i`
counter-clockwise — is either an arc of the unit circle about a point `y = z ± i e(dir i)` in the supports of both
colours (split type, a unit arc of kind both), or of tangent type: `z + i e(dir i)`, across the counter-clockwise
side, is in the support of the clockwise colour, and `z − i e(dir i)` in the support of the counter-clockwise one. -/
theorem branch_contacts (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i j : Fin F.n}
    (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) :
    (∃ y, (y = z + I * e (F.dir i) ∨ y = z - I * e (F.dir i)) ∧ y ∈ essSupport (c.cls (F.col j)) ∧
        y ∈ essSupport (c.cls (F.col i)) ∧ ∀ t ∈ Ioo 0 (min F.r (1 / 2)), dist (polarPt z t (F.φ i t)) y = 1) ∨
      (z + I * e (F.dir i) ∈ essSupport (c.cls (F.col j)) ∧ z - I * e (F.dir i) ∈ essSupport (c.cls (F.col i))) := by
  sorry

/-- **FS121-V2-SECTOR.** Under saturation in the fan's punctured disc, a colour that occupies a sector of positive
angle at `z` occupies no other region there, of positive or of zero angle
(`plans/FS121-V2-verification.md` §§ 2.1–2.3: Lemmas C, H, T — `half_dichotomy`, `branch_contacts`,
`branch_outside_discs`). Read: the fan at `z` and saturation at the branch points; not read: saturation at `z`, local
finiteness of `Σ`, the number of colours. Under saturation the hypothesis "a fan at `z`" is equivalent to `Σ` being
locally finite near `z`, by FS131-E8-BRIDGE ([hand], one mind, until `fan_of_isolated` is proved). Inhabitant:
`sq9Fan` with `sq9_tight_saturated` (four regions of four colours). -/
theorem sector_alone (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i i' : Fin F.n} (hi : F.dir i < F.nextDir i)
    (hcol : F.col i = F.col i') : i = i' := by
  sorry

/-- **FS121-DB1-L3** (carrying FS111-W-NOREP): under saturation in the fan's punctured disc no colour occupies two
sectors of positive angle at `z`, whatever zero-angle regions are present. A case of `sector_alone`. -/
theorem sector_unique (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i i' : Fin F.n} (hi : F.dir i < F.nextDir i)
    (_hi' : F.dir i' < F.nextDir i') (hcol : F.col i = F.col i') : i = i' :=
  F.sector_alone hsat hi hcol

end Fan

end AeColouring

end HadwigerNelson.Plane
