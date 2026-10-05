import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.ValidMap.BaseSteps
import Proofs.HadwigerNelson.Plane.ValidMap.Cor3
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.LocalStructure

/-!
# The ring of a cubic trichromatic vertex under the base's hypothesis: N2-ROT, N2-HEX, Prop. 17, BV-HEX's four clauses

Wave 5's skeleton (`plans/FS131-w5-kernel-plan.md` § 8), the two rows the walk `row134BaseUA` reads at its Prop. 17 and Lemma 3 steps
(FS112-N3-BASE's table, `plans/FS112-NB3-verification.md` § 1.4 N3-BASE steps 8, 10). The ring `ω(u)` of a cubic trichromatic `u` is read
through CB's **pseudo-colour** `c′(z) = P_cl(z) ∖ P_cl(u)` (`pseudoColours`), which is a single colour on a germ of `ω(u)` whether the germ
runs through a tile or along an in- or out-contact arc of `Γ` — so the ring lemmas are stated with unit arcs allowed, with no ring
colouring object:

* `GermPseudo u θ s a` — the germ of `ω(u)` on side `s` of `r(θ)` has pseudo-colour `{a}`;
* `HexRing u ψ b` — the six-point rotating configuration: `x_j = r(ψ + 60°j)`, `c′(x_j) = {b j, b (j+1)}`, the germ just before `x_j`
  pseudo-coloured `b j`, just after `b (j+1)` (`b : ZMod 3 → Fin k` injective). It is BV-HEX's "regular hexagon of kept points" and the
  germ-level form of FS-110's "purely rotating ring" (every change point of type (A+, A−));
* `RingProper u` — BV-L3's "proper finite circle colouring": finitely many points of `ω(u)` on `Γ`, and property (ii) at `60°` pairs;
* `DoubleEvent u₁ φ u₂ χ α β` — BV-ND's double event on the unit-distance linkage, read at one configuration through the two germs.

Rows: **FS112-ROTHEX** (`rot_noThird`, `rot_out`, `rot_in`, `hex_regular`, `p17_ua`) and **FS114-BV-HEX** (`bv_hex`, `bv_l3`, `bv_nd`,
`bv_nd1`, with BV-ND's step 1 as `linkage_dot_ne_zero`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- The other side of a ring point. -/
def Side.flip : Side → Side
  | .cw => .ccw
  | .ccw => .cw

@[simp] theorem Side.sign_flip (s : Side) : s.flip.sign = -s.sign := by
  cases s <;> simp [Side.flip, Side.sign]

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## The vocabulary -/

/-- **The germ of `ω(u)` on side `s` of `r(θ)` has pseudo-colour `{a}`** relative to `u`: at each of its points the colours not carried
at `u` are exactly `a` (the germ runs through a tile of colour `a ∉ P_cl(u)`, or along an arc of `Γ` with one side colour in `P_cl(u)`
and the other `a`). -/
def GermPseudo (u : ℂ) (θ : ℝ) (s : Side) (a : Fin k) : Prop :=
  GermIn u θ s {z | F.pseudoColours u z = {a}}

/-- **The six-point rotating configuration** at `u` from the angle `ψ`, coloured cyclically by `b` (BV-HEX's "regular hexagon of kept
points", `plans/BASE-V-verification.md` § 1a.4; the germ form of FS110-N2-HEX's "purely rotating ring"): `b` is injective, and for
`j < 6` the point `x_j = r(ψ + 60°j)` has pseudo-colour `{b j, b (j + 1)}`, the germ of `ω(u)` just before it (clockwise) pseudo-colour
`b j` and just after it `b (j + 1)`. Every `x_j` is then a change point of type (A+, A−) in FS110-N2-ROT's table. -/
def HexRing (u : ℂ) (ψ : ℝ) (b : ZMod 3 → Fin k) : Prop :=
  Function.Injective b ∧ ∀ j : ℕ, j < 6 →
    F.pseudoColours u (ringPt u (ψ + j * (π / 3))) = {b j, b (j + 1)} ∧
      F.GermPseudo u (ψ + j * (π / 3)) .cw (b j) ∧ F.GermPseudo u (ψ + j * (π / 3)) .ccw (b (j + 1))

/-- **The ring of `u` is a proper finite circle colouring** (BV-L3's hypothesis, `plans/BASE-V-verification.md` § 1b.3, read on the map):
`ω(u)` meets `Γ` in finitely many points, and no two change points of `ω(u)` at distance `1` switch between the same pair of colours
(property (ii)). Property (i) — two points of `ω(u)` off `Γ` at distance `1` have different colours — is validity. -/
def RingProper (u : ℂ) : Prop :=
  (F.Γ ∩ sphere u 1).Finite ∧
    ∀ ψ ψ' X X' Y Y', dist (ringPt u ψ) (ringPt u ψ') = 1 → F.IsChangePoint u ψ X X' → F.IsChangePoint u ψ' Y Y' →
      ({X, X'} : Set (Fin k)) ≠ {Y, Y'}

/-- **A double event** (BV-ND, `plans/BASE-V-verification.md` § 1b.2) at `x₀ = r_{u₁}(φ)`, `y₀ = r_{u₂}(χ)` with `|x₀ − y₀| = 1`: in the
sense of the unit-distance linkage in which both points advance with positive component along `e = x₀ − y₀` (sides `s₁`, `s₂`; the
velocity of `r_u(θ)` on side `s` is `s · i e(θ)`), the colour along `ω(u₁)` switches `α → β` at `x₀` and the colour along `ω(u₂)` switches
`β → α` at `y₀` (each read on the germs, which lie in tiles). The positivity of both components is BV-ND's `μ ≠ 0`; for `1 < |u₁ − u₂| < 2`
it holds at every configuration (`linkage_dot_ne_zero`). -/
def DoubleEvent (u₁ : ℂ) (φ : ℝ) (u₂ : ℂ) (χ : ℝ) (α β : Fin k) : Prop :=
  dist (ringPt u₁ φ) (ringPt u₂ χ) = 1 ∧ α ≠ β ∧ ∃ s₁ s₂ : Side,
    0 < dot ((s₁.sign : ℂ) * (I * e φ)) (ringPt u₁ φ - ringPt u₂ χ) ∧
    0 < dot ((s₂.sign : ℂ) * (I * e χ)) (ringPt u₁ φ - ringPt u₂ χ) ∧
    GermIn u₁ φ s₁.flip (F.region α) ∧ GermIn u₁ φ s₁ (F.region β) ∧
    GermIn u₂ χ s₂.flip (F.region β) ∧ GermIn u₂ χ s₂ (F.region α)

end ArcMap

/-! ### Spec examples -/

section Spec

open ArcMap

/-- On the one-colour plane a pseudo-colour is never a singleton, so no germ carries one (a spec example for `GermPseudo`). -/
example (j : Fin 2) (u : ℂ) (θ : ℝ) (s : Side) (a : Fin 2) : ¬ (ArcMap.const univ isOpen_univ j).GermPseudo u θ s a := by
  rintro ⟨δ, hδ, hsub⟩
  have hz := hsub ⟨δ / 2, ⟨by linarith, by linarith⟩, rfl⟩
  simp only [mem_setOf_eq, ArcMap.pseudoColours, const_univ_coloursAt, sdiff_self] at hz
  exact (Set.singleton_ne_empty a) hz.symm

/-- **Adversary**: the one-colour plane carries no six-point rotating configuration (a spec example for `HexRing`). -/
example (j : Fin 2) (u : ℂ) (ψ : ℝ) (b : ZMod 3 → Fin 2) : ¬ (ArcMap.const univ isOpen_univ j).HexRing u ψ b := by
  rintro ⟨hb, h⟩
  have := (h 0 (by norm_num)).1
  simp only [ArcMap.pseudoColours, const_univ_coloursAt, sdiff_self] at this
  exact (Set.insert_nonempty _ _).ne_empty this.symm

/-- The one-colour plane's rings are proper: no point of any ring lies on `Γ` and there are no change points (a spec example for
`RingProper`). -/
example (j : Fin 2) (u : ℂ) : (ArcMap.const univ isOpen_univ j).RingProper u := by
  refine ⟨by simp [ArcMap.Γ, ArcMap.const], ?_⟩
  intro ψ ψ' X X' Y Y' _ hcp
  exact absurd hcp.1 (by simp [ArcMap.Γ, ArcMap.const])

/-- **Adversary**: the one-colour plane has no double event (both germs of a switch would need two colours). -/
example (j : Fin 2) (u₁ u₂ : ℂ) (φ χ : ℝ) (α β : Fin 2) :
    ¬ (ArcMap.const univ isOpen_univ j).DoubleEvent u₁ φ u₂ χ α β := by
  rintro ⟨-, hαβ, s₁, -, -, -, ⟨δ, hδ, hα⟩, ⟨δ', hδ', hβ⟩, -⟩
  have h1 := hα ⟨min δ δ' / 2, ⟨by positivity, by linarith [min_le_left δ δ']⟩, rfl⟩
  have h2 := hβ ⟨min δ δ' / 2, ⟨by positivity, by linarith [min_le_right δ δ']⟩, rfl⟩
  simp only [ArcMap.region, mem_inter_iff, mem_preimage, mem_singleton_iff, ArcMap.const] at h1 h2
  exact hαβ (h1.2.symm.trans h2.2)

end Spec

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## A shared child: three colours with no repeated colour -/

/-- **Three colours and no repeated colour make a cubic trichromatic vertex** (wave 5's shared child, plan § 9.1, for `n3_base`, `rot_noThird`,
`bv_hex` and the base's `cubic_of_three`): in a sector chart at `x` every sector's colour is carried at `x`, so with three colours a fourth
sector would repeat a colour at every radius of the chart; the degree is then exactly `3`. -/
theorem isCubicTrichromatic_of_three_of_noRep {x : ℂ} (hx : x ∈ F.dom) (h3 : (F.coloursAt x).ncard = 3)
    (hnr : ¬ F.HasRepeatedColour x) : F.IsCubicTrichromatic x := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hx
  have hle := hC.ncard_coloursAt_le
  rw [h3] at hle
  have hn : 0 < n := by
    by_contra h0
    push Not at h0
    have : n = 0 := by omega
    subst this
    simp at hle
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  -- the colour of each sector (constant on it, and carried at `x`)
  choose p hp using fun i => hC.sector_nonempty hr₀ i
  have hcol : ∀ i, ∀ r ∈ Ioc 0 r₀, ∀ z ∈ G.sector x r i, F.col z = F.col (p i) := fun i r hr z hz =>
    (hC.isPreconnected r₀ hr₀ i).constant (F.continuousOn_col.mono (hC.sector_subset_interiorPts hn hr₀ i))
      (G.sector_mono hr.2 i hz) (hp i)
  have hmem : ∀ i, F.col (p i) ∈ F.coloursAt x := by
    intro i
    have hsub : G.sector x r₀ i ⊆ F.region (F.col (p i)) := fun z hz =>
      ⟨hC.sector_subset_interiorPts hn hr₀ i hz, hcol i r₀ hr₀ z hz⟩
    exact closure_mono hsub (hC.mem_closure_sector hr₀ i)
  -- at most three sectors: a fourth would repeat a colour at every small radius
  have hn3 : n ≤ 3 := by
    by_contra h4
    push Not at h4
    have hcard : ((F.coloursAt x).toFinite.toFinset).card < (Finset.univ : Finset (Fin n)).card := by
      rw [← Set.ncard_eq_toFinset_card _ (F.coloursAt x).toFinite, h3, Finset.card_univ, Fintype.card_fin]; exact h4
    obtain ⟨i, -, j, -, hij, heq⟩ := Finset.exists_ne_map_eq_of_card_lt_of_maps_to hcard
      (f := fun i => F.col (p i)) (fun i _ => (Set.Finite.mem_toFinset _).mpr (hmem i))
    apply hnr
    refine ⟨F.col (p i), ?_⟩
    filter_upwards [Ioc_mem_nhdsGT hC.pos] with r hr
    have hi : G.sector x r i ∈ F.sectorsOf x r (F.col (p i)) :=
      ⟨(hC.isSector_iff hn hr).mpr ⟨i, rfl⟩, fun z hz => hcol i r hr z hz⟩
    have hj : G.sector x r j ∈ F.sectorsOf x r (F.col (p i)) :=
      ⟨(hC.isSector_iff hn hr).mpr ⟨j, rfl⟩, fun z hz => (hcol j r hr z hz).trans heq.symm⟩
    have hne : G.sector x r i ≠ G.sector x r j := by
      intro h
      obtain ⟨z, hz⟩ := hC.sector_nonempty hr i
      exact Set.disjoint_left.mp (hC.disjoint r hr i j hij) hz (h ▸ hz)
    calc (2 : ℕ∞) = ({G.sector x r i, G.sector x r j} : Set (Set ℂ)).encard := (Set.encard_pair hne).symm
      _ ≤ (F.sectorsOf x r (F.col (p i))).encard :=
          Set.encard_le_encard (Set.insert_subset hi (Set.singleton_subset_iff.mpr hj))
  have hmax : max n 1 = 3 := by omega
  exact ⟨hmax ▸ hC.hasDegree, h3⟩

/-! ## Two shared children: a germ's pseudo-colour at its point, and `|c′| ≤ 2` under H -/

/-- **A germ's pseudo-colour is a pseudo-colour of its point** (colours are closed): the germ's points carry `j`, not carried at `u`. -/
theorem GermPseudo.mem_pseudoColours {u : ℂ} {θ : ℝ} {s : Side} {j : Fin k} (h : F.GermPseudo u θ s j) :
    j ∈ F.pseudoColours u (ringPt u θ) := by
  obtain ⟨δ, hδ, hsub⟩ := h
  have hcl : ringPt u θ ∈ closure (germ u θ s δ) := ringPt_mem_closure_germ u θ s hδ
  have hz : ∀ z ∈ germ u θ s δ, j ∈ F.pseudoColours u z := fun z hz => by
    have := hsub hz
    simp only [mem_setOf_eq] at this
    rw [this]
    exact mem_singleton j
  obtain ⟨z, hz'⟩ : (germ u θ s δ).Nonempty := ⟨_, ⟨δ / 2, ⟨by linarith, by linarith⟩, rfl⟩⟩
  exact ⟨closure_minimal (fun y hy => (hz y hy).1) isClosed_closure hcl, (hz z hz').2⟩

/-- **`|c′| ≤ 2` under the base's hypothesis** (the step `BaseCtx.pseudo_ncard_le_two` and `rot_noThird` share: FS112-N3-3's `|c′| ≤ 2`, NB3
step 5; N2-ROT's "no `r`-tile at `x`"): in a valid six-coloured fragment covering `B̄(u, 2)` under H, at a cubic trichromatic `p ∈ B̄(u, 1)`, no
point `x` of `ω(p)` carries all three colours absent at `p`. It would carry exactly those (a fourth colour is a point of `F(M)` in `B̄(u, 2)`), so be
cubic trichromatic (no repeated colour, H) and complementary to `p` at distance `1`, and `cor3_local` would put four colours at a common unit point
of `p` and `x`, within `1` of `p`, inside `B̄(u, 2)`. Six colours are spent. A step inside `row134BaseUA`'s proof (`GENERIC`). -/
theorem pseudo_ncard_le_two_of_baseHyp {F : ArcMap 6} (hF : F.Valid) {u : ℂ} (hc : F.Covers u 2) (hH : F.BaseHyp u) {p : ℂ}
    (hp : p ∈ closedBall u 1) (hp3 : F.IsCubicTrichromatic p) {x : ℂ} (hx : dist x p = 1) :
    (F.pseudoColours p x).ncard ≤ 2 := by
  by_contra hlt
  push Not at hlt
  have hpu : dist p u ≤ 1 := hp
  have hxu : x ∈ closedBall u 2 := by rw [mem_closedBall]; linarith [dist_triangle x p u]
  have hxd : x ∈ F.dom := hc hxu
  have hpd : p ∈ F.dom := hc (closedBall_subset_closedBall (by norm_num) hp)
  have hcompl : (F.coloursAt p)ᶜ.ncard = 3 := by
    rw [Set.ncard_compl, Nat.card_eq_fintype_card, Fintype.card_fin, hp3.2]
  have hsub : F.pseudoColours p x ⊆ (F.coloursAt p)ᶜ := fun j hj => hj.2
  have heq : F.pseudoColours p x = (F.coloursAt p)ᶜ := Set.eq_of_subset_of_ncard_le hsub (by omega)
  have hsubx : (F.coloursAt p)ᶜ ⊆ F.coloursAt x := fun j hj => (heq.symm ▸ hj : j ∈ F.pseudoColours p x).1
  have h3le : 3 ≤ (F.coloursAt x).ncard := hcompl ▸ Set.ncard_le_ncard hsubx
  have hx3 : (F.coloursAt x).ncard = 3 := by
    by_contra hne
    exact Set.disjoint_left.mp hH hxu (Or.inl ⟨hxd, by omega⟩)
  have hxeq : (F.coloursAt p)ᶜ = F.coloursAt x := Set.eq_of_subset_of_ncard_le hsubx (by omega)
  have hdis : Disjoint (F.coloursAt p) (F.coloursAt x) := hxeq ▸ disjoint_compl_right
  have hxc : F.IsCubicTrichromatic x :=
    isCubicTrichromatic_of_three_of_noRep hxd hx3 fun hr => Set.disjoint_left.mp hH hxu (Or.inr ⟨hxd, hr⟩)
  have hcov : ∀ q, dist q p = 1 → q ∈ closedBall u 2 := fun q hq => by
    rw [mem_closedBall]; linarith [dist_triangle q p u]
  obtain ⟨qp, qm, -, hq⟩ := cor3_local hF hp3 hxc hpd hxd (fun q hq _ => hc (hcov q hq)) hdis
    (by rw [dist_comm, hx]; norm_num)
  obtain ⟨hqp, -, h4, -⟩ := hq qp (by simp)
  exact Set.disjoint_left.mp hH (hcov qp hqp) (Or.inl ⟨hc (hcov qp hqp), h4⟩)

/-! ## FS112-ROTHEX: FS-110's ring lemmas with unit arcs under the base's hypothesis -/

/-- **FS112-ROTHEX, N2-ROT's "no `r`-tile at `x`"** (FS110-N2-ROT, `plans/FS110-N-proof.md` l. 393; with unit arcs, NB3 § 1.4 N3-BASE step
10): in a valid six-coloured fragment covering `B̄(u, 2)` about a cubic trichromatic `u` under the base's hypothesis, a change point
`x = r(ψ)` of the pseudo-colouring of `ω(u)` (pseudo-colour `p` just before, `q ≠ p` just after) carries no third pseudo-colour. The
proof rests on FS112-N3-COR3 (`cor3`): a third pseudo-colour makes `(u, x)` a close complementary pair at distance `1` (or `x` a point of
at least four colours), whose rhombus corners carry four colours inside `B̄(u, 2)`. Six colours are spent (`P_cl(u) ∪ {p, q, r}` is all
of them). Inhabitant of the change-point hypotheses on a map: none under the base's hypothesis is expected (the base refutes it); the
statement is a step inside `row134BaseUA`'s proof (`GENERIC`). -/
theorem rot_noThird {F : ArcMap 6} (hF : F.Valid) {u : ℂ} (hc : F.Covers u 2) (hu : F.IsCubicTrichromatic u) (hH : F.BaseHyp u)
    {ψ : ℝ} {p q : Fin 6} (hpq : p ≠ q) (hp : F.GermPseudo u ψ .cw p) (hq : F.GermPseudo u ψ .ccw q) :
    F.pseudoColours u (ringPt u ψ) = {p, q} := by
  have hsub : ({p, q} : Set (Fin 6)) ⊆ F.pseudoColours u (ringPt u ψ) :=
    insert_subset hp.mem_pseudoColours (singleton_subset_iff.mpr hq.mem_pseudoColours)
  have hle := pseudo_ncard_le_two_of_baseHyp hF hc hH (mem_closedBall_self zero_le_one) hu (dist_ringPt u ψ)
  exact (Set.eq_of_subset_of_ncard_le hsub (by rw [Set.ncard_pair hpq]; exact hle)).symm

/-- **FS112-ROTHEX, N2-ROT's outward row (A+, A−)**: at a change point `x = r(ψ)` (`p` before, `q` after) with `c(σx−) = q` (A+) and
`c(σ⁻¹x+) = p` (A−), `σ` the rotation by `60°` about `u`, the point `x` carries `p`, `q` and one colour `g` of `P_cl(u)`; `g` fills the
**outward cone** at `x` — the points near `x` outside both `B̄(σx, 1)` and `B̄(σ⁻¹x, 1)`, the directions `(−30°, 30°)` about the outward
radial; every `g`-tile at `x` misses `B̄(u, 1)`; and `u`'s `g`-sector lies in the closed half-plane away from `x` (its tangent cone at `u`
has non-positive component along `x − u`). Under the base's hypothesis, unit arcs allowed (N2-ROT uses N-E2 only). A step inside
`row134BaseUA`'s proof (`GENERIC`). -/
theorem rot_out {F : ArcMap 6} (hF : F.Valid) {u : ℂ} (hc : F.Covers u 2) (hu : F.IsCubicTrichromatic u) (hH : F.BaseHyp u)
    {ψ : ℝ} {p q : Fin 6} (hpq : p ≠ q) (hp : F.GermPseudo u ψ .cw p) (hq : F.GermPseudo u ψ .ccw q)
    (hAp : F.GermPseudo u (ψ + π / 3) .cw q) (hAm : F.GermPseudo u (ψ - π / 3) .ccw p) :
    ∃ g ∈ F.coloursAt u, F.coloursAt (ringPt u ψ) = {p, q, g} ∧
      (∃ ρ > 0, ∀ z ∈ F.interiorPts ∩ ball (ringPt u ψ) ρ,
        1 < dist z (ringPt u (ψ + π / 3)) → 1 < dist z (ringPt u (ψ - π / 3)) → F.col z = g) ∧
      (∀ T, F.TileOf g T → ringPt u ψ ∈ closure T → Disjoint T (closedBall u 1)) ∧
      ∀ β ∈ coneAt (F.region g) u, dot (e β) (ringPt u ψ - u) ≤ 0 := by
  sorry

/-- **FS112-ROTHEX, N2-ROT's inward row (B+, B−)**: at a change point `x = r(ψ)` with `c(σx+) = p` (B+) and `c(σ⁻¹x−) = q` (B−), the point
`x` carries `p`, `q` and one colour `g` of `P_cl(u)`; `g` fills the **inward cone** at `x` — the points near `x` inside both `B(σx, 1)` and
`B(σ⁻¹x, 1)`, the directions `(150°, 210°)`; every `g`-tile at `x` lies in `B(u, 1)`; and `u`'s `g`-sector lies in the closed half-plane
toward `x`. Under the base's hypothesis, unit arcs allowed. A step inside `row134BaseUA`'s proof (`GENERIC`). -/
theorem rot_in {F : ArcMap 6} (hF : F.Valid) {u : ℂ} (hc : F.Covers u 2) (hu : F.IsCubicTrichromatic u) (hH : F.BaseHyp u)
    {ψ : ℝ} {p q : Fin 6} (hpq : p ≠ q) (hp : F.GermPseudo u ψ .cw p) (hq : F.GermPseudo u ψ .ccw q)
    (hBp : F.GermPseudo u (ψ + π / 3) .ccw p) (hBm : F.GermPseudo u (ψ - π / 3) .cw q) :
    ∃ g ∈ F.coloursAt u, F.coloursAt (ringPt u ψ) = {p, q, g} ∧
      (∃ ρ > 0, ∀ z ∈ F.interiorPts ∩ ball (ringPt u ψ) ρ,
        dist z (ringPt u (ψ + π / 3)) < 1 → dist z (ringPt u (ψ - π / 3)) < 1 → F.col z = g) ∧
      (∀ T, F.TileOf g T → ringPt u ψ ∈ closure T → T ⊆ ball u 1) ∧
      ∀ β ∈ coneAt (F.region g) u, 0 ≤ dot (e β) (ringPt u ψ - u) := by
  sorry

/-- **FS112-ROTHEX, N2-HEX** (FS110-N2-HEX, `plans/FS110-N-proof.md` § 4.4, "sector geometry at `u`"): at a cubic trichromatic `u`, if each of
the six points `x_j = r(ψ + 60°j)` is *served* — some sector of `u` lies in the closed half-plane away from `x_j` — then `u` is **regular**
(its three sectors have angle `120°`, their bounding directions `ψ + 30° + 60° j₀ + 120° j`, each sector centred between the antipodes of two
consecutive `x_j`), **or** `u` is a **double cusp whose two horns are antipodal** (two of its tangent cones single opposite directions,
the third colour filling the rest). The second disjunct is not in FS110-N2-HEX's text: its count ("a sector of angle `α` serves at most
`⌊(180° − α)/60°⌋ + 1` of the six points") gives `4 + 4 + 0` at the angles `(0°, 0°, 360°)`, which it never lists, and two antipodal
horns serve all six (finding F-HEXCUSP, plan § 8.4). Pure sector geometry: it reads only the tangent cones of `u`'s three sectors. The
hypothesis `hserve` is what N2-ROT's outward row supplies at a purely rotating ring (`rot_out`). Model of the hypotheses: the regular
vertex of the hexagonal tiling (any map with a vertex of three `120°` sectors). -/
theorem hex_regular {u : ℂ} (hu0 : u ∈ F.dom) (hu : F.IsCubicTrichromatic u) {ψ : ℝ}
    (hserve : ∀ j : ℕ, j < 6 → ∃ g ∈ F.coloursAt u, ∀ β ∈ coneAt (F.region g) u, dot (e β) (e (ψ + j * (π / 3))) ≤ 0) :
    (∃ j₀ : ℕ, j₀ < 2 ∧ ∀ g ∈ F.coloursAt u, ∃ j : ℕ, j < 3 ∧
      coneAt (F.region g) u = angleIcc (ψ + π / 6 + j₀ * (π / 3) + j * (2 * π / 3))
        (ψ + π / 6 + j₀ * (π / 3) + (j + 1) * (2 * π / 3))) ∨
    ∃ g₁ ∈ F.coloursAt u, ∃ g₂ ∈ F.coloursAt u, g₁ ≠ g₂ ∧ ∃ β,
      coneAt (F.region g₁) u = angleIcc β β ∧ coneAt (F.region g₂) u = angleIcc (β + π) (β + π) := by
  sorry

/-! ## FS114-BV-HEX: Lemma 6's `< 9` branch under H, Lemma 3 at cusps, NoDouble with unit arcs -/

/-- **FS114-BV-HEX, (BV-HEX)** (`plans/BASE-V-verification.md` § 1a.4, steps 1–6): at a cubic trichromatic `u` of a valid map (unit arcs
allowed, no Condition 5, no strip), the six-point rotating configuration ("the regular hexagon of kept points" of Lemma 6's `< 9` branch)
cannot occur when none of its six points carries four colours or a repeated colour (so each is cubic trichromatic: the row's "when
`x_1, …, x_6` are cubic"). Stated at every `k` and with the base's hypothesis read only at the six points, on a fragment covering `B̄(u, 1)`
— the class the argument reads (no step spends six colours: the cone colours lie in `P_cl(u)` because `c′(x_j)` is exactly
`{b j, b (j+1)}`); a widening, reported (G-BVHEX). Cusps and double cusps at `u` are covered (step 6's count with horn angles `0`). A
refutation: no model expected. -/
theorem bv_hex (hF : F.Valid) {u : ℂ} (hc : F.Covers u 1) (hu : F.IsCubicTrichromatic u) {ψ : ℝ} {b : ZMod 3 → Fin k}
    (hR : F.HexRing u ψ b) (hH : ∀ j : ℕ, j < 6 → ringPt u (ψ + j * (π / 3)) ∉ F.fourSet ∪ F.repSet) : False := by
  sorry

/-- **FS112-ROTHEX, Prop. 17 with unit arcs** (`[SokolovVoronov2025]` Prop. 17; FS110-N3-P17's route, `plans/FS110-N-proof.md` § 2.4;
NB3 § 1.4 N3-BASE step 10): in a valid six-coloured fragment covering `B̄(u, 2)` about a cubic trichromatic `u` under the base's
hypothesis, the six-point rotating configuration does not occur. The row's "P17's only unit-arc exception is a both-centre `x₂`" is the
proof's content on FS110-N3-P17's route: its one Condition-5 step ("the arc … leaves `x₁` tangent to `ω(x₂)` with curvature `≠ 1`") fails
only on a unit arc of `ω(x₂)` with sides `q` and `g`, both carried at `x₂` — a both-centre, excluded by FS112-N3-NOBOTH (`noBoth`) and the
base's hypothesis. A second route is FS114-BV-HEX (`bv_hex`, which needs neither N2-ROT, N2-HEX nor NOBOTH). A refutation: no model
expected. -/
theorem p17_ua {F : ArcMap 6} (hF : F.Valid) {u : ℂ} (hc : F.Covers u 2) (hu : F.IsCubicTrichromatic u) (hH : F.BaseHyp u)
    {ψ : ℝ} {b : ZMod 3 → Fin 6} (hR : F.HexRing u ψ b) : False :=
  bv_hex hF (fun z hz => hc (closedBall_subset_closedBall (by norm_num) hz)) hu hR fun j _ hmem =>
    Set.disjoint_left.mp hH (show ringPt u _ ∈ closedBall u 2 by rw [mem_closedBall, dist_ringPt]; norm_num) hmem

/-- **FS114-BV-HEX, (BV-L3)** (`[SokolovVoronov2025]` Lemma 3, `plans/BASE-V-verification.md` § 1b.3): no two points `u₁`, `u₂` of one
three-colour multicolour at distance in `(1, 2)` have rings that are proper finite circle colourings (in the complementary triple, which at
six colours is the absent colours). Read at the class the argument reads: nothing about the sectors at `u₁`, `u₂` (cusps, double cusps,
any degree); the double-event points' adjacency (BV-ND's hypothesis) supplied by the base's hypothesis on the two circles — narrower than
BV-ND's adjacency, which also admits degree-4 bichromatic points (reported, N-BVL3). A refutation: no model expected. -/
theorem bv_l3 {F : ArcMap 6} (hF : F.Valid) {u₁ u₂ : ℂ} (hc₁ : F.Covers u₁ 1) (hc₂ : F.Covers u₂ 1)
    (h3 : (F.coloursAt u₁).ncard = 3) (hsame : F.coloursAt u₁ = F.coloursAt u₂) (ht : 1 < dist u₁ u₂) (ht' : dist u₁ u₂ < 2)
    (hR₁ : F.RingProper u₁) (hR₂ : F.RingProper u₂)
    (hH : ∀ x, (dist x u₁ = 1 ∨ dist x u₂ = 1) → x ∉ F.fourSet ∪ F.repSet) : False := by
  sorry

/-- **BV-ND's step 1** (`plans/BASE-V-verification.md` § 1b.2): on the unit-distance linkage of `ω(u₁)` and `ω(u₂)` with
`|u₁ − u₂| ∉ {1, 3}`, both points move with non-zero component along `e = x₀ − y₀` — so every switch of both colours at one configuration
is a `DoubleEvent` in one of its two senses. The input `bv_nd`'s consumers (BV-L3's step 4) use to read a `±2` jump as a double event. -/
theorem linkage_dot_ne_zero {u₁ u₂ : ℂ} (ht : dist u₁ u₂ ≠ 1 ∧ dist u₁ u₂ ≠ 3) {φ χ : ℝ}
    (h1 : dist (ringPt u₁ φ) (ringPt u₂ χ) = 1) :
    dot (I * e φ) (ringPt u₁ φ - ringPt u₂ χ) ≠ 0 ∨ dot (I * e χ) (ringPt u₁ φ - ringPt u₂ χ) ≠ 0 := by
  -- both dots zero put `w = x₀ − y₀` along `e φ` and along `e χ` (`w = l e φ`, `e χ = m w`, `l, m = ±1`), so
  -- `u₁ − u₂ = w − e φ + e χ = (l − 1 + m l) e φ` has length `1` or `3`
  by_contra hcon
  push Not at hcon
  obtain ⟨hA, hB⟩ := hcon
  set w := ringPt u₁ φ - ringPt u₂ χ with hw
  have hw1 : w.re ^ 2 + w.im ^ 2 = 1 := by
    have : ‖w‖ = 1 := by rw [hw, ← dist_eq_norm]; exact h1
    have h2 := Complex.sq_norm w
    rw [this, Complex.normSq_apply] at h2; nlinarith
  have hφ : (e φ).re ^ 2 + (e φ).im ^ 2 = 1 := by
    have h2 := Complex.sq_norm (e φ); rw [norm_e, Complex.normSq_apply] at h2; nlinarith
  have hχ : (e χ).re ^ 2 + (e χ).im ^ 2 = 1 := by
    have h2 := Complex.sq_norm (e χ); rw [norm_e, Complex.normSq_apply] at h2; nlinarith
  simp only [dot, Complex.mul_re, Complex.mul_im, Complex.I_re, Complex.I_im, Complex.conj_re, Complex.conj_im] at hA hB
  set a := (e φ).re; set b := (e φ).im; set c := (e χ).re; set d := (e χ).im
  set p := w.re; set q := w.im
  have hpq : p = (p * a + q * b) * a ∧ q = (p * a + q * b) * b :=
    ⟨by linear_combination (-b) * hA - p * hφ, by linear_combination a * hA - q * hφ⟩
  have hpq' : p = (p * c + q * d) * c ∧ q = (p * c + q * d) * d :=
    ⟨by linear_combination (-d) * hB - p * hχ, by linear_combination c * hB - q * hχ⟩
  have hl : (p * a + q * b) ^ 2 = 1 := by linear_combination (a^2+b^2) * hw1 + hφ - (a*q - b*p) * hA
  have hm : (p * c + q * d) ^ 2 = 1 := by linear_combination (c^2+d^2) * hw1 + hχ - (c*q - d*p) * hB
  have hu : u₁ - u₂ = w - e φ + e χ := by rw [hw]; simp only [ringPt]; ring
  have hd : dist u₁ u₂ ^ 2 = (p - a + c) ^ 2 + (q - b + d) ^ 2 := by
    rw [dist_eq_norm, hu, Complex.sq_norm, Complex.normSq_apply]
    simp only [Complex.add_re, Complex.sub_re, Complex.add_im, Complex.sub_im]; ring
  have hd0 : 0 ≤ dist u₁ u₂ := dist_nonneg
  set l := p * a + q * b; set m := p * c + q * d
  have hl' : l = 1 ∨ l = -1 := by
    have : (l - 1) * (l + 1) = 0 := by linear_combination hl
    rcases mul_eq_zero.mp this with h | h
    · left; linarith
    · right; linarith
  have hm' : m = 1 ∨ m = -1 := by
    have : (m - 1) * (m + 1) = 0 := by linear_combination hm
    rcases mul_eq_zero.mp this with h | h
    · left; linarith
    · right; linarith
  have hc : c = m * p ∧ d = m * q :=
    ⟨by linear_combination (-m) * hpq'.1 - c * hm, by linear_combination (-m) * hpq'.2 - d * hm⟩
  have key : dist u₁ u₂ ^ 2 = 1 ∨ dist u₁ u₂ ^ 2 = 9 := by
    rw [hd, hc.1, hc.2, hpq.1, hpq.2]
    rcases hl' with h | h <;> rcases hm' with h' | h' <;> rw [h, h'] <;>
      [left; left; right; left] <;> first | linear_combination hφ | linear_combination 9 * hφ
  rcases key with h | h
  · exact ht.1 (by
      have : (dist u₁ u₂ - 1) * (dist u₁ u₂ + 1) = 0 := by linear_combination h
      rcases mul_eq_zero.mp this with h' | h' <;> linarith)
  · exact ht.2 (by
      have : (dist u₁ u₂ - 3) * (dist u₁ u₂ + 3) = 0 := by linear_combination h
      rcases mul_eq_zero.mp this with h' | h' <;> linarith)

/-- **FS114-BV-HEX, (BV-ND)** (NoDouble, `plans/BASE-V-verification.md` § 1b.2): no double event at two points neither of which carries four
colours or a repeated colour (so the two sectors each circle passes between are adjacent) — **with unit arcs**, at cusps. Read at every
`k` and for any centres: the event's definition carries BV-ND's `μ ≠ 0`, which is where `1 < |u₁ − u₂| < 2` entered (step 1,
`linkage_dot_ne_zero`); steps 2–4 read neither. A widening, reported (G-BVND), whose instance `u₁ = u₂` is BV-ND1. A refutation: no model
expected. -/
theorem bv_nd (hF : F.Valid) {u₁ u₂ : ℂ} {φ χ : ℝ} {α β : Fin k} (hx : ringPt u₁ φ ∈ F.dom) (hy : ringPt u₂ χ ∈ F.dom)
    (hD : F.DoubleEvent u₁ φ u₂ χ α β) (hH : ringPt u₁ φ ∉ F.fourSet ∪ F.repSet ∧ ringPt u₂ χ ∉ F.fourSet ∪ F.repSet) :
    False := by
  sorry

/-- **FS114-BV-HEX, (BV-ND1)** (`plans/BASE-V-verification.md` § 2.3): BV-ND under the `60°` rotation of one circle — two points `x₀ = r(φ)`,
`σx₀ = r(φ + 60°)` of `ω(u)` switching between the same pair of colours in opposite senses (`α → β` at `x₀`, `β → α` at `σx₀`, both read
counter-clockwise: a swap) are impossible at points with no four colours and no repeated colour; with unit arcs, no strip used. So BV-H1's
input (ii) holds under H with no Condition 5. A refutation: no model expected. -/
theorem bv_nd1 (hF : F.Valid) {u : ℂ} {φ : ℝ} {α β : Fin k} (hαβ : α ≠ β) (hx : ringPt u φ ∈ F.dom)
    (hy : ringPt u (φ + π / 3) ∈ F.dom)
    (h1 : GermIn u φ .cw (F.region α)) (h2 : GermIn u φ .ccw (F.region β))
    (h3 : GermIn u (φ + π / 3) .cw (F.region β)) (h4 : GermIn u (φ + π / 3) .ccw (F.region α))
    (hH : ringPt u φ ∉ F.fourSet ∪ F.repSet ∧ ringPt u (φ + π / 3) ∉ F.fourSet ∪ F.repSet) : False := by
  -- the double event `β → α` at `x₀ = r(φ)` and `α → β` at `σx₀ = r(φ + 60°)`, both read clockwise: `x₀ − σx₀ = e(φ − 60°)`, and both
  -- clockwise velocities `−i e φ`, `−i e(φ + 60°)` have component `cos 30° > 0` along it
  have hdiff : ringPt u φ - ringPt u (φ + π / 3) = e (φ - π / 3) := by
    simp only [ringPt, add_sub_add_left_eq_sub]
    apply Complex.ext
    · simp only [Complex.sub_re, re_e, Real.cos_add, Real.cos_sub, Real.cos_pi_div_three, Real.sin_pi_div_three]; ring
    · simp only [Complex.sub_im, im_e, Real.sin_add, Real.sin_sub, Real.cos_pi_div_three, Real.sin_pi_div_three]; ring
  have hdot : ∀ θ : ℝ, dot ((Side.cw.sign : ℂ) * (I * e θ)) (e (φ - π / 3)) = -Real.cos (θ + π / 2 - (φ - π / 3)) := by
    intro θ
    rw [show ((Side.cw.sign : ℝ) : ℂ) = ((-1 : ℝ) : ℂ) by simp [Side.sign]]
    rw [dot_ofReal_mul, ← e_add_pi_div_two, dot_e_e]
    ring
  have hcos1 : 0 < -Real.cos (φ + π / 2 - (φ - π / 3)) := by
    rw [show φ + π / 2 - (φ - π / 3) = π - π / 6 by ring, Real.cos_pi_sub, Real.cos_pi_div_six]
    have := Real.sqrt_nonneg 3; have : 0 < Real.sqrt 3 := by positivity
    linarith
  have hcos2 : 0 < -Real.cos (φ + π / 3 + π / 2 - (φ - π / 3)) := by
    rw [show φ + π / 3 + π / 2 - (φ - π / 3) = π / 6 + π by ring, Real.cos_add_pi, Real.cos_pi_div_six]
    have : 0 < Real.sqrt 3 := by positivity
    linarith
  refine bv_nd hF hx hy ⟨?_, hαβ.symm, Side.cw, Side.cw, ?_, ?_, h2, h1, h4, h3⟩ hH
  · rw [dist_eq_norm, hdiff, norm_e]
  · rw [hdiff, hdot]; exact hcos1
  · rw [hdiff, hdot]; exact hcos2

end ArcMap

end HadwigerNelson.Plane
