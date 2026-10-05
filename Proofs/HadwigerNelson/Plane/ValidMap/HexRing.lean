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

/-! ## The hexagon count: three contiguous cones serving the six hexagon directions (FS131-I5j, for `hex_regular` and `bv_hex`)

Pure arithmetic, no map. A cone of directions `[lo, hi]` *serves* the direction `θ` when every direction of the cone has non-positive cosine
to `θ` (the cone lies in the closed half-plane away from `θ`). Three contiguous cones `[a₀, a₁]`, `[a₁, a₂]`, `[a₂, a₀ + 2π]` serving the six
directions `ψ + jπ/3` are the regular ones (`hex_real_core`), and then no two consecutive directions are served by different cones. In
units of `π/3` the cone ends become the integers `⌊A − 3/2⌋`, `⌈A − 9/2⌉`, and the count is `hex_int_core`. -/

/-- **The integer count** (child of `hex_real_core`): three integer intervals `[Q₁, P₀]`, `[Q₂, P₁]`, `[Q₀ + 6, P₂]` (ends monotone over one
period, each `Pᵢ ≤ Qᵢ + 3`) holding six integers of the six residues mod `6` are the tight ones: `Pᵢ = Qᵢ + 3` and the `Pᵢ` two apart. Two
classes together fit an interval of length at most `3` (`≤ 4` integers each pair, so `2 · 6 ≤ 12` forces equality), and a class of two needs
an interval holding two integers. -/
theorem hex_int_core {P0 P1 P2 Q0 Q1 Q2 : ℤ} (hP : P0 ≤ P1 ∧ P1 ≤ P2 ∧ P2 ≤ P0 + 6)
    (hQ : Q0 ≤ Q1 ∧ Q1 ≤ Q2 ∧ Q2 ≤ Q0 + 6) (hd : P0 ≤ Q0 + 3 ∧ P1 ≤ Q1 + 3 ∧ P2 ≤ Q2 + 3)
    (n : ℕ → ℤ) (hn : ∀ j : ℕ, j < 6 → (n j - j) % 6 = 0) (idx : ℕ → ℕ)
    (hcov : ∀ j : ℕ, j < 6 → (idx j = 0 → Q1 ≤ n j ∧ n j ≤ P0) ∧ (idx j = 1 → Q2 ≤ n j ∧ n j ≤ P1) ∧
      (idx j = 2 → Q0 + 6 ≤ n j ∧ n j ≤ P2) ∧ idx j < 3) :
    P0 = Q0 + 3 ∧ P1 = Q1 + 3 ∧ P2 = Q2 + 3 ∧ P1 = P0 + 2 ∧ P2 = P0 + 4 := by
  classical
  set c : ℕ → ℕ := fun i => ((Finset.range 6).filter (fun j => idx j = i)).card with hc
  have hres : ∀ j ∈ Finset.range 6, ∀ j' ∈ Finset.range 6, (n j - n j') % 6 = 0 → j = j' := by
    intro j hj j' hj' h
    rw [Finset.mem_range] at hj hj'
    have := hn j hj; have := hn j' hj'
    omega
  have hsum : c 0 + c 1 + c 2 = 6 := by
    have hpart : Finset.range 6 = (Finset.range 6).filter (fun j => idx j = 0) ∪ (Finset.range 6).filter (fun j => idx j = 1) ∪
        (Finset.range 6).filter (fun j => idx j = 2) := by
      ext j; simp only [Finset.mem_union, Finset.mem_filter, Finset.mem_range]
      constructor
      · intro hj; have := (hcov j hj).2.2.2; omega
      · rintro ((h | h) | h) <;> exact h.1
    have h6 : (Finset.range 6).card = 6 := Finset.card_range 6
    rw [hpart, Finset.card_union_of_disjoint, Finset.card_union_of_disjoint] at h6
    · exact h6
    all_goals (rw [Finset.disjoint_left]; intro j; simp only [Finset.mem_filter, Finset.mem_union]; omega)
  have hpair : ∀ (a b : ℕ) (lo hi : ℤ) (g : ℕ → ℤ),
      (∀ j ∈ Finset.range 6, idx j = a ∨ idx j = b → lo ≤ g j ∧ g j ≤ hi) →
      (∀ j ∈ Finset.range 6, ∀ j' ∈ Finset.range 6, (idx j = a ∨ idx j = b) → (idx j' = a ∨ idx j' = b) → g j = g j' → j = j') →
      a ≠ b → ((c a + c b : ℕ) : ℤ) ≤ max (hi + 1 - lo) 0 := by
    intro a b lo hi g hmap hinj hab
    have hcard : ((Finset.range 6).filter (fun j => idx j = a ∨ idx j = b)).card ≤ (Finset.Icc lo hi).card := by
      apply Finset.card_le_card_of_injOn g
      · intro j hj
        simp only [Finset.coe_filter, Set.mem_setOf_eq, Finset.mem_range] at hj
        have := hmap j (Finset.mem_range.mpr hj.1) hj.2
        simp only [Finset.coe_Icc, Set.mem_Icc]; exact this
      · intro j hj j' hj' h
        simp only [Finset.coe_filter, Set.mem_setOf_eq, Finset.mem_range] at hj hj'
        exact hinj j (Finset.mem_range.mpr hj.1) j' (Finset.mem_range.mpr hj'.1) hj.2 hj'.2 h
    rw [Finset.filter_or, Finset.card_union_of_disjoint (by rw [Finset.disjoint_left]; intro j; simp only [Finset.mem_filter]; omega),
      Int.card_Icc] at hcard
    have := Int.toNat_eq_max (hi + 1 - lo)
    have ha' : c a = ((Finset.range 6).filter (fun j => idx j = a)).card := rfl
    have hb' : c b = ((Finset.range 6).filter (fun j => idx j = b)).card := rfl
    omega
  have p01 := hpair 0 1 Q1 P1 n (fun j hj h => by
      have := hcov j (Finset.mem_range.mp hj); rcases h with h | h
      · have := this.1 h; omega
      · have := this.2.1 h; omega)
    (fun j hj j' hj' _ _ h => hres j hj j' hj' (by rw [h]; simp)) (by norm_num)
  have p12 := hpair 1 2 Q2 P2 n (fun j hj h => by
      have := hcov j (Finset.mem_range.mp hj); rcases h with h | h
      · have := this.2.1 h; omega
      · have := this.2.2.1 h; omega)
    (fun j hj j' hj' _ _ h => hres j hj j' hj' (by rw [h]; simp)) (by norm_num)
  have p20 := hpair 2 0 (Q0 + 6) (P0 + 6) (fun j => if idx j = 2 then n j else n j + 6) (fun j hj h => by
      have := hcov j (Finset.mem_range.mp hj); rcases h with h | h
      · have := this.2.2.1 h; rw [if_pos h]; omega
      · have := this.1 h; rw [if_neg (by omega)]; omega)
    (fun j hj j' hj' _ _ h => hres j hj j' hj' (by
      split_ifs at h <;> omega)) (by norm_num)
  have hlen : ∀ (a : ℕ) (lo hi : ℤ), (∀ j ∈ Finset.range 6, idx j = a → lo ≤ n j ∧ n j ≤ hi) → 2 ≤ c a → lo + 1 ≤ hi := by
    intro a lo hi hmap h2
    obtain ⟨j, hj, j', hj', hne⟩ := Finset.one_lt_card.mp (show 1 < c a by omega)
    simp only [Finset.mem_filter] at hj hj'
    have h1 := hmap j hj.1 hj.2; have h2 := hmap j' hj'.1 hj'.2
    have : n j ≠ n j' := fun h => hne (hres j hj.1 j' hj'.1 (by rw [h]; simp))
    omega
  have l0 := hlen 0 Q1 P0 (fun j hj h => (hcov j (Finset.mem_range.mp hj)).1 h)
  have l1 := hlen 1 Q2 P1 (fun j hj h => (hcov j (Finset.mem_range.mp hj)).2.1 h)
  have l2 := hlen 2 (Q0 + 6) P2 (fun j hj h => (hcov j (Finset.mem_range.mp hj)).2.2.1 h)
  omega

/-- **The integer count, with no two consecutive residues in one class** (child of `bv_hex`'s step 6): impossible, since the tight intervals
are `[P₀ − 1, P₀]`, `[P₀ + 1, P₀ + 2]`, `[P₀ + 3, P₀ + 4]` and the residues of `P₀ − 1` and `P₀` both fall in the first. -/
theorem hex_int_noAdj {P0 P1 P2 Q0 Q1 Q2 : ℤ} (hP : P0 ≤ P1 ∧ P1 ≤ P2 ∧ P2 ≤ P0 + 6)
    (hQ : Q0 ≤ Q1 ∧ Q1 ≤ Q2 ∧ Q2 ≤ Q0 + 6) (hd : P0 ≤ Q0 + 3 ∧ P1 ≤ Q1 + 3 ∧ P2 ≤ Q2 + 3)
    (n : ℕ → ℤ) (hn : ∀ j : ℕ, j < 6 → (n j - j) % 6 = 0) (idx : ℕ → ℕ)
    (hcov : ∀ j : ℕ, j < 6 → (idx j = 0 → Q1 ≤ n j ∧ n j ≤ P0) ∧ (idx j = 1 → Q2 ≤ n j ∧ n j ≤ P1) ∧
      (idx j = 2 → Q0 + 6 ≤ n j ∧ n j ≤ P2) ∧ idx j < 3)
    (hne : ∀ j : ℕ, j < 6 → idx j ≠ idx ((j + 1) % 6)) : False := by
  obtain ⟨e0, e1, e2, e3, e4⟩ := hex_int_core hP hQ hd n hn idx hcov
  obtain ⟨j₁, hj₁, hr⟩ : ∃ j₁ : ℕ, j₁ < 6 ∧ ((j₁ : ℤ) - (P0 - 1)) % 6 = 0 :=
    ⟨((P0 - 1) % 6).toNat, by omega, by omega⟩
  have hj₂ : (j₁ + 1) % 6 < 6 := Nat.mod_lt _ (by norm_num)
  have c1 := hcov j₁ hj₁; have c2 := hcov ((j₁ + 1) % 6) hj₂
  have r1 := hn j₁ hj₁; have r2 := hn ((j₁ + 1) % 6) hj₂
  have := hne j₁ hj₁
  push_cast at r2
  omega

/-- **An interval of directions at non-positive cosine to `θ` lies in one closed half-turn about `θ + π`** (child of `hex_real_core`). -/
theorem exists_halfTurn_of_cos_nonpos {a b θ : ℝ} (hab : a ≤ b) (h : ∀ β ∈ Icc a b, Real.cos (β - θ) ≤ 0) :
    ∃ m : ℤ, θ + π / 2 + 2 * π * m ≤ a ∧ b ≤ θ + 3 * π / 2 + 2 * π * m := by
  have hπ := Real.pi_pos
  set m : ℤ := ⌊(a - θ - π / 2) / (2 * π)⌋ with hm
  have h1 : (m : ℝ) ≤ (a - θ - π / 2) / (2 * π) := Int.floor_le _
  have h2 : (a - θ - π / 2) / (2 * π) < m + 1 := Int.lt_floor_add_one _
  rw [le_div_iff₀ (by positivity)] at h1
  rw [div_lt_iff₀ (by positivity)] at h2
  have hpos : ∀ x, θ + 3 * π / 2 + 2 * π * m < x → x < θ + 5 * π / 2 + 2 * π * m → 0 < Real.cos (x - θ) := by
    intro x hx1 hx2
    have hc : Real.cos (x - θ) = Real.cos (x - θ - ((m + 1 : ℤ) : ℝ) * (2 * π)) := (Real.cos_sub_int_mul_two_pi _ _).symm
    rw [hc]; push_cast
    apply Real.cos_pos_of_mem_Ioo; constructor <;> nlinarith
  have ha : a ≤ θ + 3 * π / 2 + 2 * π * m := by
    by_contra ha; push Not at ha
    exact absurd (h a ⟨le_rfl, hab⟩) (not_le.mpr (hpos a ha (by nlinarith)))
  refine ⟨m, by nlinarith, ?_⟩
  by_contra hb; push Not at hb
  have hx1 : θ + 3 * π / 2 + 2 * π * m < min b (θ + 2 * π + 2 * π * m) := lt_min hb (by linarith)
  have hx2 : min b (θ + 2 * π + 2 * π * m) < θ + 5 * π / 2 + 2 * π * m := lt_of_le_of_lt (min_le_right _ _) (by linarith)
  exact absurd (h _ ⟨by linarith, min_le_left _ _⟩) (not_le.mpr (hpos _ hx1 hx2))

/-- `⌊x⌋ = ⌈x⌉` only at an integer. -/
theorem eq_floor_of_floor_eq_ceil {x : ℝ} (h : ⌊x⌋ = ⌈x⌉) : x = ⌊x⌋ := by
  have h1 := Int.floor_le x
  have h2 := Int.le_ceil x
  rw [← h] at h2
  linarith

/-- **The real count** (`hex_int_core` and `hex_int_noAdj` read in the directions): three contiguous cones `[a₀, a₁]`, `[a₁, a₂]`,
`[a₂, a₀ + 2π]` whose chosen members `idx j` serve the six directions `ψ + jπ/3` have width `2π/3` each, with ends at `ψ + π/2 + Nπ/3`;
and no assignment gives consecutive directions different cones throughout. -/
theorem hex_real_core {a0 a1 a2 ψ : ℝ} (h01 : a0 ≤ a1) (h12 : a1 ≤ a2) (h20 : a2 ≤ a0 + 2 * π) (idx : ℕ → ℕ)
    (hserve : ∀ j : ℕ, j < 6 → idx j < 3 ∧
      (idx j = 0 → ∀ β ∈ Icc a0 a1, Real.cos (β - (ψ + j * (π / 3))) ≤ 0) ∧
      (idx j = 1 → ∀ β ∈ Icc a1 a2, Real.cos (β - (ψ + j * (π / 3))) ≤ 0) ∧
      (idx j = 2 → ∀ β ∈ Icc a2 (a0 + 2 * π), Real.cos (β - (ψ + j * (π / 3))) ≤ 0)) :
    (a1 = a0 + 2 * π / 3 ∧ a2 = a0 + 4 * π / 3 ∧ ∃ N : ℤ, a0 = ψ + π / 2 + N * (π / 3)) ∧
      ¬ ∀ j : ℕ, j < 6 → idx j ≠ idx ((j + 1) % 6) := by
  have hπ := Real.pi_pos
  set A : ℝ → ℝ := fun a => 3 * (a - ψ) / π with hA
  have hAmono : ∀ a a', a ≤ a' → A a ≤ A a' := fun a a' h => by
    simp only [hA]; exact div_le_div_of_nonneg_right (by linarith) hπ.le
  have hA2 : A (a0 + 2 * π) = A a0 + 6 := by simp only [hA]; field_simp; ring
  have key : ∀ j : ℕ, ∀ lo hi : ℝ, lo ≤ hi → (∀ β ∈ Icc lo hi, Real.cos (β - (ψ + j * (π / 3))) ≤ 0) →
      ∃ n : ℤ, (n - j) % 6 = 0 ∧ ⌈A hi - 9 / 2⌉ ≤ n ∧ n ≤ ⌊A lo - 3 / 2⌋ := by
    intro j lo hi hlh hc
    obtain ⟨m, hm1, hm2⟩ := exists_halfTurn_of_cos_nonpos hlh hc
    refine ⟨j + 6 * m, by omega, ?_, ?_⟩
    · rw [Int.ceil_le]; push_cast; simp only [hA]
      rw [sub_le_iff_le_add, div_le_iff₀ hπ]; nlinarith
    · rw [Int.le_floor]; push_cast; simp only [hA]
      rw [le_sub_iff_add_le, le_div_iff₀ hπ]; nlinarith
  have hm : ∀ j : ℕ, ∃ n : ℤ, j < 6 → (n - j) % 6 = 0 ∧
      (idx j = 0 → ⌈A a1 - 9 / 2⌉ ≤ n ∧ n ≤ ⌊A a0 - 3 / 2⌋) ∧ (idx j = 1 → ⌈A a2 - 9 / 2⌉ ≤ n ∧ n ≤ ⌊A a1 - 3 / 2⌋) ∧
      (idx j = 2 → ⌈A a0 - 9 / 2⌉ + 6 ≤ n ∧ n ≤ ⌊A a2 - 3 / 2⌋) ∧ idx j < 3 := by
    intro j
    by_cases hj : j < 6
    · obtain ⟨hi3, h0, h1, h2⟩ := hserve j hj
      rcases (show idx j = 0 ∨ idx j = 1 ∨ idx j = 2 by omega) with h | h | h
      · obtain ⟨n, hn, k1, k2⟩ := key j a0 a1 h01 (h0 h)
        exact ⟨n, fun _ => ⟨hn, fun _ => ⟨k1, k2⟩, fun h' => by omega, fun h' => by omega, hi3⟩⟩
      · obtain ⟨n, hn, k1, k2⟩ := key j a1 a2 h12 (h1 h)
        exact ⟨n, fun _ => ⟨hn, fun h' => by omega, fun _ => ⟨k1, k2⟩, fun h' => by omega, hi3⟩⟩
      · obtain ⟨n, hn, k1, k2⟩ := key j a2 (a0 + 2 * π) h20 (h2 h)
        have hc6 : ⌈A (a0 + 2 * π) - 9 / 2⌉ = ⌈A a0 - 9 / 2⌉ + 6 := by
          rw [hA2, show A a0 + 6 - 9 / 2 = (A a0 - 9 / 2) + ((6 : ℤ) : ℝ) by push_cast; ring, Int.ceil_add_intCast]
        exact ⟨n, fun _ => ⟨hn, fun h' => by omega, fun h' => by omega, fun _ => ⟨hc6 ▸ k1, k2⟩, hi3⟩⟩
    · exact ⟨0, fun h => absurd h hj⟩
  choose n hn using hm
  have hfl : ∀ x : ℝ, ⌊x - 3 / 2⌋ ≤ ⌈x - 9 / 2⌉ + 3 := fun x => by
    have : ⌈x - 9 / 2⌉ = ⌈x - 3 / 2⌉ - 3 := by
      rw [show x - 9 / 2 = (x - 3 / 2) - ((3 : ℤ) : ℝ) by push_cast; ring, Int.ceil_sub_intCast]
    rw [this]; have := Int.floor_le_ceil (x - 3 / 2); omega
  have hP2 : ⌊A a2 - 3 / 2⌋ ≤ ⌊A a0 - 3 / 2⌋ + 6 := by
    have := Int.floor_mono (show A a2 - 3 / 2 ≤ (A a0 - 3 / 2) + ((6 : ℤ) : ℝ) by
      have := hAmono _ _ h20; rw [hA2] at this; push_cast; linarith)
    rwa [Int.floor_add_intCast] at this
  have hQ2 : ⌈A a2 - 9 / 2⌉ ≤ ⌈A a0 - 9 / 2⌉ + 6 := by
    have := Int.ceil_mono (show A a2 - 9 / 2 ≤ (A a0 - 9 / 2) + ((6 : ℤ) : ℝ) by
      have := hAmono _ _ h20; rw [hA2] at this; push_cast; linarith)
    rwa [Int.ceil_add_intCast] at this
  have hPm : ⌊A a0 - 3 / 2⌋ ≤ ⌊A a1 - 3 / 2⌋ ∧ ⌊A a1 - 3 / 2⌋ ≤ ⌊A a2 - 3 / 2⌋ ∧ ⌊A a2 - 3 / 2⌋ ≤ ⌊A a0 - 3 / 2⌋ + 6 :=
    ⟨Int.floor_mono (by linarith [hAmono _ _ h01]), Int.floor_mono (by linarith [hAmono _ _ h12]), hP2⟩
  have hQm : ⌈A a0 - 9 / 2⌉ ≤ ⌈A a1 - 9 / 2⌉ ∧ ⌈A a1 - 9 / 2⌉ ≤ ⌈A a2 - 9 / 2⌉ ∧ ⌈A a2 - 9 / 2⌉ ≤ ⌈A a0 - 9 / 2⌉ + 6 :=
    ⟨Int.ceil_mono (by linarith [hAmono _ _ h01]), Int.ceil_mono (by linarith [hAmono _ _ h12]), hQ2⟩
  have hd := And.intro (hfl (A a0)) (And.intro (hfl (A a1)) (hfl (A a2)))
  have hres : ∀ j : ℕ, j < 6 → (n j - j) % 6 = 0 := fun j hj => (hn j hj).1
  have hcov := fun j hj => (hn j hj).2
  refine ⟨?_, fun hne => hex_int_noAdj hPm hQm hd n hres idx hcov hne⟩
  obtain ⟨e0, e1, e2, e3, e4⟩ := hex_int_core hPm hQm hd n hres idx hcov
  have hint : ∀ x : ℝ, ⌊x - 3 / 2⌋ = ⌈x - 9 / 2⌉ + 3 → x = ⌊x - 3 / 2⌋ + 3 / 2 := fun x h => by
    have hc : ⌈x - 9 / 2⌉ = ⌈x - 3 / 2⌉ - 3 := by
      rw [show x - 9 / 2 = (x - 3 / 2) - ((3 : ℤ) : ℝ) by push_cast; ring, Int.ceil_sub_intCast]
    have := eq_floor_of_floor_eq_ceil (x := x - 3 / 2) (by omega)
    linarith
  have r0 := hint _ e0; have r1 := hint _ e1; have r2 := hint _ e2
  have hA' : ∀ a, a = ψ + A a * (π / 3) := fun a => by simp only [hA]; field_simp; ring
  have q3 : ((⌊A a1 - 3 / 2⌋ : ℤ) : ℝ) = ⌊A a0 - 3 / 2⌋ + 2 := by exact_mod_cast e3
  have q4 : ((⌊A a2 - 3 / 2⌋ : ℤ) : ℝ) = ⌊A a0 - 3 / 2⌋ + 4 := by exact_mod_cast e4
  have h0 := hA' a0; have h1 := hA' a1; have h2 := hA' a2
  rw [r0] at h0; rw [r1, q3] at h1; rw [r2, q4] at h2
  exact ⟨by linear_combination h1 - h0, by linear_combination h2 - h0, ⌊A a0 - 3 / 2⌋, by linear_combination h0⟩

/-- **The angular interval is `2π`-periodic in both ends together.** -/
theorem angleIcc_add_int_mul (a b : ℝ) (n : ℤ) : angleIcc (a + 2 * π * n) (b + 2 * π * n) = angleIcc a b := by
  ext x
  simp only [angleIcc, mem_iUnion, mem_Icc]
  constructor
  · rintro ⟨m, h1, h2⟩; exact ⟨m + n, by push_cast; linarith, by push_cast; linarith⟩
  · rintro ⟨m, h1, h2⟩; exact ⟨m - n, by push_cast; linarith, by push_cast; linarith⟩

/-! ## The tangent cones of a cubic trichromatic vertex -/

/-- **The three tangent cones of a cubic trichromatic vertex** (wave 5's shared child `coneAt_of_cubic`, plan § 9.1, for `hex_regular` and
`bv_hex`): the colour classes at `u` are the three sectors of its chart, so their cones at `u` are the sectors' cones — three closed angular
intervals `[β₀, β₁]`, `[β₁, β₂]`, `[β₂, β₀ + 2π]`, contiguous, total `2π` (a horn has angle `0`). Model of the hypotheses: the brick corner
(`sevenBrick_corner_isCubicTrichromatic`), the example below. -/
theorem coneAt_of_cubic {u : ℂ} (hu0 : u ∈ F.dom) (hu : F.IsCubicTrichromatic u) :
    ∃ (β : Fin 3 → ℝ) (f : Fin 3 → Fin k), β 0 ≤ β 1 ∧ β 1 ≤ β 2 ∧ β 2 ≤ β 0 + 2 * π ∧
      Function.Injective f ∧ F.coloursAt u = Set.range f ∧
      coneAt (F.region (f 0)) u = angleIcc (β 0) (β 1) ∧
      coneAt (F.region (f 1)) u = angleIcc (β 1) (β 2) ∧
      coneAt (F.region (f 2)) u = angleIcc (β 2) (β 0 + 2 * π) := by
  obtain ⟨r₀, G, hC, -, f, hf, hsec, hsub⟩ := hu.chart hu0
  have hr₀ : r₀ ∈ Ioc 0 r₀ := ⟨hC.pos, le_rfl⟩
  have hn : (0 : ℕ) < 3 := by norm_num
  have hcone : ∀ i, coneAt (F.region (f i)) u = angleIcc (G.β i) (G.nextβ i) := by
    intro i
    rw [← hC.cone r₀ hr₀ i]
    refine Subset.antisymm (fun β hβ => ?_) (coneAt_mono (hsec i) u)
    obtain ⟨j, hj, hjsub⟩ := hC.exists_sector_of_mem_coneAt_region hn hr₀ hβ
    obtain ⟨z, hz⟩ := hC.sector_nonempty hr₀ j
    have : f j = f i := by rw [← (hsec j hz).2, (hjsub hz).2]
    rwa [hf this] at hj
  have hle : ∀ i, G.β i ≤ G.nextβ i := fun i => by
    rcases hC.sorted.2 i with h | h
    · exact h.le
    · exact h.1.le
  have n0 : G.nextβ 0 = G.β 1 := by simp [BranchGerms.nextβ]
  have n1 : G.nextβ 1 = G.β 2 := by simp [BranchGerms.nextβ]
  have n2 : G.nextβ 2 = G.β 0 + 2 * π := by simp [BranchGerms.nextβ]
  refine ⟨G.β, f, n0 ▸ hle 0, n1 ▸ hle 1, n2 ▸ hle 2, hf, ?_, n0 ▸ hcone 0, n1 ▸ hcone 1, n2 ▸ hcone 2⟩
  refine Subset.antisymm (fun c hc => ?_) ?_
  · obtain ⟨i, hi⟩ := hsub c hc; exact ⟨i, hi⟩
  · rintro c ⟨i, rfl⟩
    exact mem_closure_of_mem_coneAt (β := G.β i) (by rw [hcone i]; exact Icc_subset_angleIcc _ _ ⟨le_rfl, hle i⟩)

/-- `coneAt_of_cubic` applies at the brick corner, a cubic trichromatic vertex of a valid map of the plane (its model). -/
example : ∃ (β : Fin 3 → ℝ) (f : Fin 3 → Fin 7), β 0 ≤ β 1 ∧ β 1 ≤ β 2 ∧ β 2 ≤ β 0 + 2 * π ∧
    Function.Injective f ∧ sevenBrickMap.coloursAt 0 = Set.range f ∧
    coneAt (sevenBrickMap.region (f 0)) 0 = angleIcc (β 0) (β 1) ∧
    coneAt (sevenBrickMap.region (f 1)) 0 = angleIcc (β 1) (β 2) ∧
    coneAt (sevenBrickMap.region (f 2)) 0 = angleIcc (β 2) (β 0 + 2 * π) :=
  coneAt_of_cubic (mem_univ 0) sevenBrick_corner_isCubicTrichromatic

/-- **The six hexagon directions read through the cones of a cubic vertex** (child of `hex_regular` and `bv_hex`): if each direction
`ψ + jπ/3` is served by the cone of the colour `g j` of `u`, the cones are regular — `[a, a + 2π/3]`, `[a + 2π/3, a + 4π/3]`,
`[a + 4π/3, a + 2π]` with `a = ψ + π/2 + Nπ/3` — and some two consecutive directions are served by one colour. -/
theorem hex_cones_of_serve {u : ℂ} (hu0 : u ∈ F.dom) (hu : F.IsCubicTrichromatic u) {ψ : ℝ} (g : ℕ → Fin k)
    (hg : ∀ j : ℕ, j < 6 → g j ∈ F.coloursAt u ∧ ∀ β ∈ coneAt (F.region (g j)) u, dot (e β) (e (ψ + j * (π / 3))) ≤ 0) :
    (∃ (β : Fin 3 → ℝ) (f : Fin 3 → Fin k) (N : ℤ), F.coloursAt u = Set.range f ∧
      β 0 = ψ + π / 2 + N * (π / 3) ∧ β 1 = β 0 + 2 * π / 3 ∧ β 2 = β 0 + 4 * π / 3 ∧
      coneAt (F.region (f 0)) u = angleIcc (β 0) (β 1) ∧
      coneAt (F.region (f 1)) u = angleIcc (β 1) (β 2) ∧
      coneAt (F.region (f 2)) u = angleIcc (β 2) (β 0 + 2 * π)) ∧
    ∃ j : ℕ, j < 6 ∧ g j = g ((j + 1) % 6) := by
  classical
  obtain ⟨β, f, h01, h12, h20, hf, hrange, hc0, hc1, hc2⟩ := coneAt_of_cubic hu0 hu
  have hidx : ∀ j : ℕ, ∃ i : ℕ, j < 6 → i < 3 ∧ (∀ i' : Fin 3, (i' : ℕ) = i → f i' = g j) := by
    intro j
    by_cases hj : j < 6
    · have hg' := (hg j hj).1
      rw [hrange] at hg'
      obtain ⟨i, hi⟩ := hg'
      exact ⟨i, fun _ => ⟨i.isLt, fun i' h => by rw [Fin.ext h, hi]⟩⟩
    · exact ⟨0, fun h => absurd h hj⟩
  choose idx hidx using hidx
  have hcos : ∀ j : ℕ, j < 6 → ∀ (i : Fin 3) (lo hi : ℝ), coneAt (F.region (f i)) u = angleIcc lo hi → (i : ℕ) = idx j →
      ∀ β' ∈ Icc lo hi, Real.cos (β' - (ψ + j * (π / 3))) ≤ 0 := by
    intro j hj i lo hi hci hi' β' hβ'
    rw [← dot_e_e]
    have := (hg j hj).2 β' (by rw [← (hidx j hj).2 i hi', hci]; exact Icc_subset_angleIcc _ _ hβ')
    exact this
  have hserve : ∀ j : ℕ, j < 6 → idx j < 3 ∧
      (idx j = 0 → ∀ β' ∈ Icc (β 0) (β 1), Real.cos (β' - (ψ + j * (π / 3))) ≤ 0) ∧
      (idx j = 1 → ∀ β' ∈ Icc (β 1) (β 2), Real.cos (β' - (ψ + j * (π / 3))) ≤ 0) ∧
      (idx j = 2 → ∀ β' ∈ Icc (β 2) (β 0 + 2 * π), Real.cos (β' - (ψ + j * (π / 3))) ≤ 0) :=
    fun j hj => ⟨(hidx j hj).1, fun h => hcos j hj 0 _ _ hc0 h.symm, fun h => hcos j hj 1 _ _ hc1 h.symm,
      fun h => hcos j hj 2 _ _ hc2 h.symm⟩
  obtain ⟨⟨e1, e2, N, e0⟩, hno⟩ := hex_real_core h01 h12 h20 idx hserve
  refine ⟨⟨β, f, N, hrange, e0, e1, e2, hc0, hc1, hc2⟩, ?_⟩
  push Not at hno
  obtain ⟨j, hj, heq⟩ := hno
  have hj' : (j + 1) % 6 < 6 := Nat.mod_lt _ (by norm_num)
  refine ⟨j, hj, ?_⟩
  have h1 := (hidx j hj).2 ⟨idx j, (hidx j hj).1⟩ rfl
  have h2 := (hidx _ hj').2 ⟨idx j, (hidx j hj).1⟩ heq
  rw [← h1, ← h2]

/-! ## FS114-BV-HEX's steps (FS131-I5j): the side bound, the outward cone, the polar bound, consecutive cones -/

/-- **An open set of the domain whose interior points carry one colour lies in that colour's closure** (child of `bv_hex`: interior points
are dense, `dense_interiorPts`). -/
theorem subset_closure_region_of_isOpen {O : Set ℂ} (hO : IsOpen O) (hOd : O ⊆ F.dom) {c : Fin k}
    (hcol : ∀ z ∈ O, z ∈ F.interiorPts → F.col z = c) : O ⊆ closure (F.region c) := by
  intro z hz
  rw [Metric.mem_closure_iff]
  intro ε hε
  obtain ⟨r, hr, hrO⟩ := Metric.isOpen_iff.mp hO z hz
  obtain ⟨w, hw, hwz⟩ := Metric.mem_closure_iff.mp (dense_interiorPts F (hOd hz)) (min ε r) (lt_min hε hr)
  have hwO : w ∈ O := hrO (by rw [mem_ball, dist_comm]; exact lt_of_lt_of_le hwz (min_le_right _ _))
  exact ⟨w, ⟨hw, hcol w hwO hw⟩, lt_of_lt_of_le hwz (min_le_left _ _)⟩

/-- **The half-plane lemma along a connected set** (child of `bv_hex`'s step 5; `Valid.cone_re_nonneg_of_germ` with the germ replaced by any
preconnected set in the closure of the class of `c` that has `w₀` in its closure and a point farther than `1` from `y`): with `|y − w₀| = 1`,
the class approaches `y` only along directions `β` with `Re((y − w₀) conj e β) ≥ 0`. -/
theorem Valid.cone_re_nonneg_of_preconnected (hF : F.Valid) {c : Fin k} {S : Set ℂ} (hS : IsPreconnected S)
    (hSc : S ⊆ closure (F.region c)) {w₀ y : ℂ} (hw₀ : w₀ ∈ closure S) (hy : ‖y - w₀‖ = 1)
    (hfar : ∃ w₁ ∈ S, 1 < dist y w₁) :
    ∀ β ∈ coneAt (F.region c) y, 0 ≤ ((y - w₀) * (starRingEnd ℂ) (e β)).re := by
  intro β hβ
  by_contra hneg
  push Not at hneg
  obtain ⟨w₁, hw₁S, hm⟩ := hfar
  set κ := -((y - w₀) * (starRingEnd ℂ) (e β)).re with hκ
  have hκ0 : 0 < κ := by rw [hκ]; linarith
  set ε := min (dist y w₁ - 1) (κ / 2) with hε
  have hε0 : 0 < ε := lt_min (by linarith) (by linarith)
  obtain ⟨z, hz, hzy, hzd, hzu⟩ := hβ ε hε0
  have hh : z - y ≠ 0 := sub_ne_zero.mpr hzy
  have hhn : ‖z - y‖ < ε := by rwa [← dist_eq_norm]
  rcases hF.dist_lt_or_gt_of_isPreconnected hz hS hSc with hlt | hgt
  · have h1 := hlt w₁ hw₁S
    have h2 := dist_triangle y z w₁
    have h3 : dist y z < ε := by rw [dist_comm]; exact hzd
    have : ε ≤ dist y w₁ - 1 := min_le_left _ _
    linarith
  · have hz0 : 1 ≤ dist z w₀ := by
      have hcl : closure S ⊆ {s : ℂ | 1 ≤ dist z s} :=
        closure_minimal (fun s hs => (hgt s hs).le) (isClosed_le continuous_const (continuous_const.dist continuous_id))
      exact hcl hw₀
    have hexp := cone_expand (d := y - w₀) (h := z - y) hy hh hzu
    have hsum : y - w₀ + (z - y) = z - w₀ := by ring
    rw [hsum] at hexp
    obtain ⟨hA, hB⟩ := hexp
    have hz1 : 1 ≤ ‖z - w₀‖ ^ 2 := by rw [← dist_eq_norm]; nlinarith
    have hpos : 0 < ‖z - y‖ := norm_pos_iff.mpr hh
    have h0 : 0 ≤ 2 * ((y - w₀) * (starRingEnd ℂ) ((z - y) / (‖z - y‖ : ℂ))).re + ‖z - y‖ := by
      by_contra hn; push Not at hn
      have := mul_neg_of_pos_of_neg hpos hn
      linarith
    have hε' : ε ≤ κ / 2 := min_le_right _ _
    have hB' := (abs_le.mp hB).2
    linarith

/-- A germ of pseudo-colour `{a}` lies in the closure of the class of `a`. -/
theorem GermPseudo.germIn_closure {u : ℂ} {θ : ℝ} {s : Side} {a : Fin k} (h : F.GermPseudo u θ s a) :
    GermIn u θ s (closure (F.region a)) := by
  obtain ⟨δ, hδ, hsub⟩ := h
  refine ⟨δ, hδ, fun z hz => ?_⟩
  have hz' := hsub hz
  simp only [mem_setOf_eq] at hz'
  exact (show a ∈ F.pseudoColours u z by rw [hz']; exact mem_singleton a).1

/-- The germ is `2π`-periodic in its point. -/
theorem germPseudo_add_two_pi {u : ℂ} {θ : ℝ} {s : Side} {a : Fin k} :
    F.GermPseudo u (θ + 2 * π) s a ↔ F.GermPseudo u θ s a := by
  have hg : ∀ δ, germ u (θ + 2 * π) s δ = germ u θ s δ := fun δ => by
    ext z
    simp only [germ, mem_image]
    constructor <;> rintro ⟨t, ht, rfl⟩ <;> refine ⟨t, ht, ?_⟩ <;> simp only [ringPt] <;>
      rw [show θ + 2 * π + s.sign * t = (θ + s.sign * t) + 2 * π by ring, e_add_two_pi]
  simp only [GermPseudo, GermIn, hg]

/-- The ring point is `2π`-periodic. -/
theorem ringPt_add_two_pi' (u : ℂ) (θ : ℝ) : ringPt u (θ + 2 * π) = ringPt u θ := by
  simp only [ringPt, e_add_two_pi]

/-- **BV-HEX step 1, the side bound** (`plans/BASE-V-verification.md` § 1a.4 step 1): if the germ of `ω(u)` on side `s` of `y = r(θ′)` lies in
the closure of the class of `q`, and its points are nearer than `1` to `x`, then near `x` the class of `q` lies in `B̄(y, 1)`: a point `z` of
colour `q` near `x` with `|z − y| > 1` sees the germ's points both nearer and farther than `1`, and the germ is connected. -/
theorem hex_side (hF : F.Valid) {u : ℂ} {θ' : ℝ} {s : Side} {q : Fin k}
    (hg : GermIn u θ' s (closure (F.region q))) {x : ℂ} {δ₁ : ℝ} (hδ₁ : 0 < δ₁)
    (hnear : ∀ t ∈ Ioo 0 δ₁, dist x (ringPt u (θ' + s.sign * t)) < 1) :
    ∃ ρ > 0, ∀ z ∈ F.region q, dist z x < ρ → dist z (ringPt u θ') ≤ 1 := by
  obtain ⟨δ, hδ, hsub⟩ := hg
  have hδ'0 : 0 < min δ δ₁ := lt_min hδ hδ₁
  have hw₁x : dist x (ringPt u (θ' + s.sign * (min δ δ₁ / 2))) < 1 :=
    hnear _ ⟨by linarith, lt_of_lt_of_le (show min δ δ₁ / 2 < min δ δ₁ by linarith) (min_le_right _ _)⟩
  refine ⟨1 - dist x (ringPt u (θ' + s.sign * (min δ δ₁ / 2))), by linarith, fun z hz hzx => ?_⟩
  by_contra hfar
  push Not at hfar
  have hS : germ u θ' s (min δ δ₁) ⊆ closure (F.region q) := (germ_mono (min_le_left _ _)).trans hsub
  rcases hF.dist_lt_or_gt_of_isPreconnected hz (isPreconnected_germ u θ' s _) hS with hlt | hgt
  · have ht0 : 0 < min (min δ δ₁ / 2) ((dist z (ringPt u θ') - 1) / 2) := lt_min (by linarith) (by linarith)
    have htδ : min (min δ δ₁ / 2) ((dist z (ringPt u θ') - 1) / 2) ∈ Ioo 0 (min δ δ₁) :=
      ⟨ht0, lt_of_le_of_lt (min_le_left _ _) (by linarith)⟩
    have h1 := hlt _ ⟨_, htδ, rfl⟩
    have h2 := dist_triangle z (ringPt u (θ' + s.sign * min (min δ δ₁ / 2) ((dist z (ringPt u θ') - 1) / 2)))
      (ringPt u θ')
    have h3 := dist_ringPt_germ_le u θ' s ht0.le
    rw [dist_comm] at h3
    have : min (min δ δ₁ / 2) ((dist z (ringPt u θ') - 1) / 2) ≤ (dist z (ringPt u θ') - 1) / 2 := min_le_right _ _
    linarith
  · have h1 := hgt _ ⟨min δ δ₁ / 2, ⟨by linarith, by linarith⟩, rfl⟩
    have h2 := dist_triangle z x (ringPt u (θ' + s.sign * (min δ δ₁ / 2)))
    linarith

/-- Distances in the frame of `e φ` at `u`. -/
theorem dist_frame (u : ℂ) (φ : ℝ) (w w' : ℂ) : dist (u + e φ * w) (u + e φ * w') = ‖w - w'‖ := by
  rw [dist_eq_norm, add_sub_add_left_eq_sub, ← mul_sub, norm_mul, norm_e, one_mul]

theorem ringPt_frame (u : ℂ) (φ α : ℝ) : ringPt u (φ + α) = u + e φ * e α := by simp only [ringPt, e_add]

theorem norm_sq_eq_re_im (w : ℂ) : ‖w‖ ^ 2 = w.re ^ 2 + w.im ^ 2 := by
  rw [Complex.sq_norm, Complex.normSq_apply]; ring

/-- The `e` values of the hexagon's angles, in coordinates. -/
theorem e_hex_re_im : (e (π / 3)).re = 1 / 2 ∧ (e (π / 3)).im = √3 / 2 ∧ (e (-(π / 3))).re = 1 / 2 ∧
    (e (-(π / 3))).im = -(√3 / 2) ∧ (e (π / 6)).re = √3 / 2 ∧ (e (π / 6)).im = 1 / 2 ∧
    (e (π / 3 + π / 3)).re = -(1 / 2) ∧ (e (π / 3 + π / 3)).im = √3 / 2 := by
  have h23c : Real.cos (π / 3 + π / 3) = -(1 / 2) := by
    rw [show π / 3 + π / 3 = π - π / 3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three]
  have h23s : Real.sin (π / 3 + π / 3) = √3 / 2 := by
    rw [show π / 3 + π / 3 = π - π / 3 by ring, Real.sin_pi_sub, Real.sin_pi_div_three]
  simp only [re_e, im_e, Real.cos_neg, Real.sin_neg, Real.cos_pi_div_three, Real.sin_pi_div_three, Real.cos_pi_div_six,
    Real.sin_pi_div_six, h23c, h23s, and_self]

/-- **BV-HEX steps 1–3 and 5 at one point** (`plans/BASE-V-verification.md` § 1a.4): at `x = r(φ)` with pseudo-colour `{p, q}`, the germ
just clockwise of `r(φ + 60°)` pseudo-coloured `q` and the germ just counter-clockwise of `r(φ − 60°)` pseudo-coloured `p`, and fewer than
four colours at `x`: near `x`, outside `B̄(r(φ ± 60°), 1)` (the outward cone, which holds the outward radial), every interior point has one
colour `c`, a colour of `u` (steps 1–3: `q` near `x` lies in `B̄(r(φ + 60°), 1)`, `p` in `B̄(r(φ − 60°), 1)`, and the third colour at `x` is the
only other); and `c`'s cone at `u` lies in the closed half-plane away from `x` (step 5, along the radial). -/
theorem hex_point (hF : F.Valid) {u : ℂ} {φ : ℝ} {p q : Fin k} (hpq : p ≠ q) (hxd : ringPt u φ ∈ F.dom)
    (hps : F.pseudoColours u (ringPt u φ) = {p, q})
    (hq : F.GermPseudo u (φ + π / 3) .cw q) (hp : F.GermPseudo u (φ - π / 3) .ccw p)
    (h4 : ringPt u φ ∉ F.fourSet) :
    ∃ c ∈ F.coloursAt u, ∃ ρ > 0, ball (ringPt u φ) ρ ⊆ F.dom ∧
      (∀ z ∈ F.interiorPts, dist z (ringPt u φ) < ρ → 1 < dist z (ringPt u (φ + π / 3)) →
        1 < dist z (ringPt u (φ - π / 3)) → F.col z = c) ∧
      ∀ β ∈ coneAt (F.region c) u, dot (e β) (e φ) ≤ 0 := by
  have hπ := Real.pi_pos
  set x := ringPt u φ with hx
  -- step 1 on both sides
  have hchord : ∀ t ∈ Ioo (0 : ℝ) (π / 3), ∀ θ : ℝ, |φ - θ| = π / 3 - t → dist x (ringPt u θ) < 1 := by
    intro t ht θ hθ
    exact ((dist_ringPt_ringPt_cmp_one u (by rw [hθ]; linarith [ht.1])).2.1).mpr (by rw [hθ]; linarith [ht.1])
  obtain ⟨ρ₁, hρ₁, hside₁⟩ := hex_side hF hq.germIn_closure (by positivity : (0 : ℝ) < π / 3) fun t ht =>
    hchord t ht _ (by simp only [Side.sign]; rw [show φ - (φ + π / 3 + -1 * t) = -(π / 3 - t) by ring, abs_neg,
      abs_of_pos (by linarith [ht.2])])
  obtain ⟨ρ₂, hρ₂, hside₂⟩ := hex_side hF hp.germIn_closure (by positivity : (0 : ℝ) < π / 3) fun t ht =>
    hchord t ht _ (by simp only [Side.sign]; rw [show φ - (φ - π / 3 + 1 * t) = π / 3 - t by ring,
      abs_of_pos (by linarith [ht.2])])
  obtain ⟨r₀, hr₀, hr₀d, hr₀c⟩ := exists_ball_col_mem_coloursAt hxd
  set ρ := min (min ρ₁ ρ₂) r₀ with hρ
  have hρ0 : 0 < ρ := lt_min (lt_min hρ₁ hρ₂) hr₀
  have hρd : ball x ρ ⊆ F.dom := (ball_subset_ball (min_le_right _ _)).trans hr₀d
  -- the colours of the outward cone near `x`: colours of `x`, neither `p` nor `q`, hence colours of `u`
  have hcone : ∀ z ∈ F.interiorPts, dist z x < ρ → 1 < dist z (ringPt u (φ + π / 3)) →
      1 < dist z (ringPt u (φ - π / 3)) → F.col z ∈ F.coloursAt x ∧ F.col z ∈ F.coloursAt u := by
    intro z hzI hzx h1 h2
    have hzx₀ : F.col z ∈ F.coloursAt x := hr₀c z ⟨hzI, lt_of_lt_of_le hzx (min_le_right _ _)⟩
    refine ⟨hzx₀, ?_⟩
    by_contra hcu
    have hmem : F.col z ∈ F.pseudoColours u x := ⟨hzx₀, hcu⟩
    rw [hps] at hmem
    rcases hmem with h | h
    · have := hside₂ z ⟨hzI, h⟩ (lt_of_lt_of_le hzx ((min_le_left _ _).trans (min_le_right _ _))); linarith
    · have := hside₁ z ⟨hzI, h⟩ (lt_of_lt_of_le hzx ((min_le_left _ _).trans (min_le_left _ _))); linarith
  -- the outward radial lies in the cone
  have hrad : ∀ s : ℝ, 0 < s → ∀ α : ℝ, (α = π / 3 ∨ α = -(π / 3)) → 1 < dist (x + s * e φ) (ringPt u (φ + α)) := by
    intro s hs α hα
    have hxs : x + s * e φ = u + e φ * ((1 + s : ℝ) : ℂ) := by rw [hx]; simp only [ringPt]; push_cast; ring
    rw [hxs, ringPt_frame, dist_frame]
    have hsq : ‖((1 + s : ℝ) : ℂ) - e α‖ ^ 2 = 1 + s + s ^ 2 := by
      rw [norm_sq_eq_re_im]
      obtain ⟨a1, a2, a3, a4, -, -, -, -⟩ := e_hex_re_im
      rcases hα with rfl | rfl <;> simp only [Complex.sub_re, Complex.sub_im, Complex.ofReal_re, Complex.ofReal_im, a1, a2, a3, a4] <;>
        nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 3 by norm_num)]
    have h1 : 1 < ‖((1 + s : ℝ) : ℂ) - e α‖ ^ 2 := by rw [hsq]; nlinarith
    nlinarith [norm_nonneg (((1 + s : ℝ) : ℂ) - e α)]
  have hradx : ∀ s : ℝ, dist (x + s * e φ) x = |s| := fun s => by
    rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs]
  set K : Set ℂ := {z | dist z x < ρ ∧ 1 < dist z (ringPt u (φ + π / 3)) ∧ 1 < dist z (ringPt u (φ - π / 3))} with hK
  have hKo : IsOpen K := by
    refine (isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter
      ((isOpen_lt continuous_const (continuous_id.dist continuous_const)).inter
        (isOpen_lt continuous_const (continuous_id.dist continuous_const)))
  have hKd : K ⊆ F.dom := fun z hz => hρd hz.1
  have hradK : ∀ s ∈ Ioo 0 ρ, x + s * e φ ∈ K := fun s hs => by
    refine ⟨by rw [hradx, abs_of_pos hs.1]; exact hs.2, hrad s hs.1 _ (Or.inl rfl), ?_⟩
    have := hrad s hs.1 _ (Or.inr rfl); rwa [← sub_eq_add_neg] at this
  -- an interior point of the cone, and its colour `c`
  obtain ⟨z₁, hz₁I, hz₁K⟩ : ∃ z₁ ∈ F.interiorPts, z₁ ∈ K := by
    have hm := hradK (ρ / 2) ⟨by linarith, by linarith⟩
    obtain ⟨r, hr, hrK⟩ := Metric.isOpen_iff.mp hKo _ hm
    obtain ⟨w, hw, hwd⟩ := Metric.mem_closure_iff.mp (dense_interiorPts F (hKd hm)) r hr
    exact ⟨w, hw, hrK (by rw [mem_ball, dist_comm]; exact hwd)⟩
  obtain ⟨hc1, hc2⟩ := hcone z₁ hz₁I hz₁K.1 hz₁K.2.1 hz₁K.2.2
  set c := F.col z₁
  -- the colours of `x` are `p`, `q`, `c`, so the cone has one colour
  have hpx : p ∈ F.coloursAt x ∧ p ∉ F.coloursAt u := by
    have : p ∈ F.pseudoColours u x := by rw [hps]; exact mem_insert p _
    exact this
  have hqx : q ∈ F.coloursAt x ∧ q ∉ F.coloursAt u := by
    have : q ∈ F.pseudoColours u x := by rw [hps]; simp
    exact this
  have hone : ∀ c' ∈ F.coloursAt x, c' ∈ F.coloursAt u → c' = c := by
    intro c' hc'x hc'u
    by_contra hne
    have hsub : ({p, q, c, c'} : Set (Fin k)) ⊆ F.coloursAt x := by
      intro y hy; simp only [mem_insert_iff, mem_singleton_iff] at hy
      rcases hy with rfl | rfl | rfl | rfl
      exacts [hpx.1, hqx.1, hc1, hc'x]
    have hpc : p ≠ c := fun h => hpx.2 (h ▸ hc2)
    have hqc : q ≠ c := fun h => hqx.2 (h ▸ hc2)
    have hpc' : p ≠ c' := fun h => hpx.2 (h ▸ hc'u)
    have hqc' : q ≠ c' := fun h => hqx.2 (h ▸ hc'u)
    have h4' : ({p, q, c, c'} : Set (Fin k)).ncard = 4 := by
      rw [Set.ncard_insert_of_notMem (by simp [hpq, hpc, hpc']), Set.ncard_insert_of_notMem (by simp [hqc, hqc']),
        Set.ncard_pair (Ne.symm hne)]
    exact h4 ⟨hxd, h4' ▸ Set.ncard_le_ncard hsub⟩
  have hKc : ∀ z ∈ K, z ∈ F.interiorPts → F.col z = c := fun z hz hzI => by
    obtain ⟨h1, h2⟩ := hcone z hzI hz.1 hz.2.1 hz.2.2
    exact hone _ h1 h2
  refine ⟨c, hc2, ρ, hρ0, hρd, fun z hzI hzx h1 h2 => hKc z ⟨hzx, h1, h2⟩ hzI, ?_⟩
  -- step 5: the polar bound, along the radial
  have hKcl := subset_closure_region_of_isOpen hKo hKd hKc
  set R : Set ℂ := (fun s : ℝ => x + s * e φ) '' Ioo 0 ρ with hR
  have hRc : IsPreconnected R :=
    isPreconnected_Ioo.image _ (by fun_prop : Continuous fun s : ℝ => x + s * e φ).continuousOn
  have hRK : R ⊆ closure (F.region c) := by
    rintro _ ⟨s, hs, rfl⟩; exact hKcl (hradK s hs)
  have hxR : x ∈ closure R := by
    rw [Metric.mem_closure_iff]
    intro ε hε
    refine ⟨x + (min (ε / 2) (ρ / 2)) * e φ, ⟨_, ⟨lt_min (by linarith) (by linarith), by
      linarith [min_le_right (ε / 2) (ρ / 2)]⟩, rfl⟩, ?_⟩
    rw [dist_comm, hradx, abs_of_pos (lt_min (by linarith) (by linarith))]
    linarith [min_le_left (ε / 2) (ρ / 2)]
  have hux : ‖u - x‖ = 1 := by rw [← dist_eq_norm, dist_comm, hx, dist_ringPt]
  have hfar : ∃ w₁ ∈ R, 1 < dist u w₁ := by
    refine ⟨x + ((ρ / 2 : ℝ) : ℂ) * e φ, ⟨ρ / 2, ⟨by linarith, by linarith⟩, rfl⟩, ?_⟩
    have : u - (x + (ρ / 2 : ℝ) * e φ) = -(((1 + ρ / 2 : ℝ) : ℂ) * e φ) := by rw [hx]; simp only [ringPt]; push_cast; ring
    rw [dist_eq_norm, this, norm_neg, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (by linarith)]
    linarith
  intro β hβ
  have h := hF.cone_re_nonneg_of_preconnected hRc hRK hxR hux hfar β hβ
  have hux' : u - x = -e φ := by rw [hx]; simp only [ringPt]; ring
  rw [hux', neg_mul, Complex.neg_re] at h
  have : dot (e φ) (e β) = dot (e β) (e φ) := by rw [dot_e_e, dot_e_e, ← Real.cos_neg]; ring_nf
  rw [← this]
  show (e φ * (starRingEnd ℂ) (e β)).re ≤ 0
  linarith

/-- **BV-HEX step 4, consecutive cones** (`plans/BASE-V-verification.md` § 1a.4 step 4): the outward cones at two consecutive points
`r(φ)`, `r(φ + 60°)` have different colours — `x + s t` and `x′ + s t` (`t = e(φ + 30°)`, `s` small) lie in the two cones and are exactly
`1` apart, and each cone is an open set in the closure of its colour. -/
theorem hex_adjacent (hF : F.Valid) {u : ℂ} {φ : ℝ} {c c' : Fin k} {ρ ρ' : ℝ} (hρ : 0 < ρ) (hρ' : 0 < ρ')
    (hd : ball (ringPt u φ) ρ ⊆ F.dom) {y y₁ : ℂ} (hy : ringPt u (φ + π / 3) = y) (hy₁ : ringPt u (φ + π / 3 + π / 3) = y₁)
    (hd' : ball y ρ' ⊆ F.dom)
    (hK : ∀ z ∈ F.interiorPts, dist z (ringPt u φ) < ρ → 1 < dist z (ringPt u (φ + π / 3)) →
        1 < dist z (ringPt u (φ - π / 3)) → F.col z = c)
    (hK' : ∀ z ∈ F.interiorPts, dist z y < ρ' → 1 < dist z y₁ → 1 < dist z (ringPt u φ) → F.col z = c') : c ≠ c' := by
  intro hcc
  subst hcc
  subst hy hy₁
  have hπ := Real.pi_pos
  obtain ⟨a1, a2, a3, a4, a5, a6, a7, a8⟩ := e_hex_re_im
  have h3 := Real.sq_sqrt (show (0 : ℝ) ≤ 3 by norm_num)
  have h3' : 0 < √3 := by positivity
  set s := min ρ ρ' / 2 with hs
  have hs0 : 0 < s := by positivity
  have hsρ : s < ρ := by have := min_le_left ρ ρ'; linarith
  have hsρ' : s < ρ' := by have := min_le_right ρ ρ'; linarith
  have h3s : √3 ^ 2 * s ^ 2 = 3 * s ^ 2 := by rw [h3]
  set O : Set ℂ := {z | dist z (ringPt u φ) < ρ ∧ 1 < dist z (ringPt u (φ + π / 3)) ∧ 1 < dist z (ringPt u (φ - π / 3))}
  set O' : Set ℂ := {z | dist z (ringPt u (φ + π / 3)) < ρ' ∧ 1 < dist z (ringPt u (φ + π / 3 + π / 3)) ∧
    1 < dist z (ringPt u φ)}
  have hopen : ∀ (a b d : ℂ) (r : ℝ), IsOpen {z : ℂ | dist z a < r ∧ 1 < dist z b ∧ 1 < dist z d} := fun a b d r =>
    (isOpen_lt (continuous_id.dist continuous_const) continuous_const).inter
      ((isOpen_lt continuous_const (continuous_id.dist continuous_const)).inter
        (isOpen_lt continuous_const (continuous_id.dist continuous_const)))
  have hO := subset_closure_region_of_isOpen (hopen _ _ _ _) (fun z hz => hd hz.1) (fun z hz hzI => hK z hzI hz.1 hz.2.1 hz.2.2)
  have hO' := subset_closure_region_of_isOpen (hopen _ _ _ _) (fun z hz => hd' hz.1)
    (fun z hz hzI => hK' z hzI hz.1 hz.2.1 hz.2.2)
  -- the two points, in the frame of `e φ`
  set w₁ : ℂ := 1 + (s : ℂ) * e (π / 6)
  set w₂ : ℂ := e (π / 3) + (s : ℂ) * e (π / 6)
  have hlt : ∀ w : ℂ, ∀ α : ℝ, 1 < ‖w - e α‖ ^ 2 → 1 < dist (u + e φ * w) (ringPt u (φ + α)) := fun w α h => by
    rw [ringPt_frame, dist_frame]; nlinarith [norm_nonneg (w - e α)]
  have hm : ringPt u (φ - π / 3) = ringPt u (φ + -(π / 3)) := by rw [sub_eq_add_neg]
  have hz₁ : u + e φ * w₁ ∈ O := by
    refine ⟨?_, hlt _ _ ?_, hm ▸ hlt _ _ ?_⟩
    · have : ringPt u φ = u + e φ * 1 := by simp [ringPt]
      rw [this, dist_frame]; simp only [w₁, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real,
        Real.norm_eq_abs, abs_of_pos hs0]; exact hsρ
    · rw [norm_sq_eq_re_im]; simp only [w₁, Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.mul_re,
        Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.one_re, Complex.one_im, a1, a2, a5, a6]; nlinarith [h3, h3s, hs0]
    · rw [norm_sq_eq_re_im]; simp only [w₁, Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.mul_re,
        Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.one_re, Complex.one_im, a3, a4, a5, a6]; nlinarith [h3, h3s, hs0]
  have hz₂ : u + e φ * w₂ ∈ O' := by
    refine ⟨?_, ?_, ?_⟩
    · rw [ringPt_frame, dist_frame]; simp only [w₂, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real,
        Real.norm_eq_abs, abs_of_pos hs0]; exact hsρ'
    · rw [add_assoc]; apply hlt
      rw [norm_sq_eq_re_im]; simp only [w₂, Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.mul_re,
        Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, a1, a2, a5, a6, a7, a8]; nlinarith [h3, h3s, hs0]
    · have : ringPt u φ = u + e φ * 1 := by simp [ringPt]
      rw [this, dist_frame]
      have : 1 < ‖w₂ - 1‖ ^ 2 := by
        rw [norm_sq_eq_re_im]; simp only [w₂, Complex.sub_re, Complex.sub_im, Complex.add_re, Complex.add_im, Complex.mul_re,
          Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.one_re, Complex.one_im, a1, a2, a5, a6]; nlinarith [h3, h3s, hs0]
      nlinarith [norm_nonneg (w₂ - 1)]
  have h1 : dist (u + e φ * w₁) (u + e φ * w₂) = 1 := by
    rw [dist_frame]
    have : w₁ - w₂ = 1 - e (π / 3) := by simp only [w₁, w₂]; ring
    rw [this]
    have hsq : ‖(1 : ℂ) - e (π / 3)‖ ^ 2 = 1 := by
      rw [norm_sq_eq_re_im]; simp only [Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im, a1, a2]; nlinarith
    nlinarith [norm_nonneg ((1 : ℂ) - e (π / 3))]
  exact hF.dist_ne_one_of_isOpen_subset_closure (hO hz₁) (hopen _ _ _ _) hO' hz₂ h1

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
vertex of the hexagonal tiling (any map with a vertex of three `120°` sectors). **The proof establishes the first disjunct always**
(FS131-I5j): at a cubic vertex the three cones are contiguous (`coneAt_of_cubic`), so two horns share their boundary direction and point
the same way — the antipodal double cusp needs four branches; the count is `hex_cones_of_serve`. -/
theorem hex_regular {u : ℂ} (hu0 : u ∈ F.dom) (hu : F.IsCubicTrichromatic u) {ψ : ℝ}
    (hserve : ∀ j : ℕ, j < 6 → ∃ g ∈ F.coloursAt u, ∀ β ∈ coneAt (F.region g) u, dot (e β) (e (ψ + j * (π / 3))) ≤ 0) :
    (∃ j₀ : ℕ, j₀ < 2 ∧ ∀ g ∈ F.coloursAt u, ∃ j : ℕ, j < 3 ∧
      coneAt (F.region g) u = angleIcc (ψ + π / 6 + j₀ * (π / 3) + j * (2 * π / 3))
        (ψ + π / 6 + j₀ * (π / 3) + (j + 1) * (2 * π / 3))) ∨
    ∃ g₁ ∈ F.coloursAt u, ∃ g₂ ∈ F.coloursAt u, g₁ ≠ g₂ ∧ ∃ β,
      coneAt (F.region g₁) u = angleIcc β β ∧ coneAt (F.region g₂) u = angleIcc (β + π) (β + π) := by
  classical
  left
  obtain ⟨g₀, -, -⟩ := hserve 0 (by norm_num)
  have hs : ∀ j : ℕ, ∃ g : Fin k, j < 6 → g ∈ F.coloursAt u ∧
      ∀ β ∈ coneAt (F.region g) u, dot (e β) (e (ψ + j * (π / 3))) ≤ 0 := by
    intro j
    by_cases hj : j < 6
    · obtain ⟨g, hg, hgs⟩ := hserve j hj; exact ⟨g, fun _ => ⟨hg, hgs⟩⟩
    · exact ⟨g₀, fun h => absurd h hj⟩
  choose g hg using hs
  obtain ⟨⟨β, f, N, hrange, e0, e1, e2, hc0, hc1, hc2⟩, -⟩ := hex_cones_of_serve hu0 hu g hg
  have hshift : ∀ (b : ℝ) (L : ℤ), ∃ j : ℕ, j < 3 ∧ angleIcc (b + L * (2 * π / 3)) (b + (L + 1) * (2 * π / 3)) =
      angleIcc (b + j * (2 * π / 3)) (b + (j + 1) * (2 * π / 3)) := by
    intro b L
    refine ⟨(L % 3).toNat, by omega, ?_⟩
    have hL : (L : ℝ) = ((L % 3).toNat : ℕ) + 3 * ((L / 3 : ℤ) : ℝ) := by
      have : L = ((L % 3).toNat : ℤ) + 3 * (L / 3) := by omega
      exact_mod_cast this
    rw [show b + L * (2 * π / 3) = (b + ((L % 3).toNat : ℕ) * (2 * π / 3)) + 2 * π * ((L / 3 : ℤ) : ℝ) by rw [hL]; ring,
      show b + (L + 1) * (2 * π / 3) = (b + (((L % 3).toNat : ℕ) + 1) * (2 * π / 3)) + 2 * π * ((L / 3 : ℤ) : ℝ) by
        rw [hL]; ring, angleIcc_add_int_mul]
  refine ⟨((N + 1) % 2).toNat, by omega, ?_⟩
  have hM : ((N : ℝ) + 1) = (((N + 1) % 2).toNat : ℕ) + 2 * (((N + 1) / 2 : ℤ) : ℝ) := by
    have : N + 1 = (((N + 1) % 2).toNat : ℤ) + 2 * ((N + 1) / 2) := by omega
    exact_mod_cast this
  have hβ0 : β 0 = (ψ + π / 6 + (((N + 1) % 2).toNat : ℕ) * (π / 3)) + (((N + 1) / 2 : ℤ) : ℝ) * (2 * π / 3) := by
    rw [e0]; linear_combination (π / 3) * hM
  intro c hc
  rw [hrange] at hc
  obtain ⟨i, rfl⟩ := hc
  fin_cases i
  · obtain ⟨j, hj, hjeq⟩ := hshift (ψ + π / 6 + (((N + 1) % 2).toNat : ℕ) * (π / 3)) ((N + 1) / 2)
    refine ⟨j, hj, ?_⟩
    rw [← hjeq]
    convert hc0 using 2 <;> [rfl; rw [hβ0]; (rw [e1, hβ0]; ring)]
  · obtain ⟨j, hj, hjeq⟩ := hshift (ψ + π / 6 + (((N + 1) % 2).toNat : ℕ) * (π / 3)) ((N + 1) / 2 + 1)
    refine ⟨j, hj, ?_⟩
    rw [← hjeq]
    convert hc1 using 2 <;> [rfl; (rw [e1, hβ0]; push_cast; ring); (rw [e2, hβ0]; push_cast; ring)]
  · obtain ⟨j, hj, hjeq⟩ := hshift (ψ + π / 6 + (((N + 1) % 2).toNat : ℕ) * (π / 3)) ((N + 1) / 2 + 2)
    refine ⟨j, hj, ?_⟩
    rw [← hjeq]
    convert hc2 using 2 <;> [rfl; (rw [e2, hβ0]; push_cast; ring); (rw [hβ0]; push_cast; ring)]

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
  classical
  have hπ := Real.pi_pos
  obtain ⟨hb, hR⟩ := hR
  have hu0 : u ∈ F.dom := hc (mem_closedBall_self zero_le_one)
  have hxd : ∀ θ : ℝ, ringPt u θ ∈ F.dom := fun θ => hc (by rw [mem_closedBall, dist_ringPt])
  have hper : ∀ (m : ℤ) (θ : ℝ), ringPt u (θ + 2 * π * m) = ringPt u θ := fun m θ => by
    apply Complex.ext <;> simp only [ringPt, Complex.add_re, Complex.add_im, re_e, im_e]
    · rw [show θ + 2 * π * m = θ + m * (2 * π) by ring, Real.cos_add_int_mul_two_pi]
    · rw [show θ + 2 * π * m = θ + m * (2 * π) by ring, Real.sin_add_int_mul_two_pi]
  -- the germs at the two neighbours of each point
  have hcw : ∀ j : ℕ, j < 6 → F.GermPseudo u (ψ + j * (π / 3) + π / 3) .cw (b ((j : ZMod 3) + 1)) := by
    intro j hj
    rcases Nat.lt_or_ge (j + 1) 6 with h | h
    · have := (hR (j + 1) h).2.1
      rw [show ψ + ((j + 1 : ℕ) : ℝ) * (π / 3) = ψ + j * (π / 3) + π / 3 by push_cast; ring,
        show (((j + 1 : ℕ) : ZMod 3)) = (j : ZMod 3) + 1 by push_cast; rfl] at this
      exact this
    · obtain rfl : j = 5 := by omega
      have := (hR 0 (by norm_num)).2.1
      rw [← germPseudo_add_two_pi, show ψ + ((0 : ℕ) : ℝ) * (π / 3) + 2 * π = ψ + ((5 : ℕ) : ℝ) * (π / 3) + π / 3 by
        push_cast; ring, show (((0 : ℕ) : ZMod 3)) = ((5 : ℕ) : ZMod 3) + 1 from rfl] at this
      exact this
  have hccw : ∀ j : ℕ, j < 6 → F.GermPseudo u (ψ + j * (π / 3) - π / 3) .ccw (b j) := by
    intro j hj
    rcases Nat.eq_zero_or_pos j with h | h
    · subst h
      have := (hR 5 (by norm_num)).2.2
      rw [← germPseudo_add_two_pi (θ := ψ + ((0 : ℕ) : ℝ) * (π / 3) - π / 3),
        show ψ + ((0 : ℕ) : ℝ) * (π / 3) - π / 3 + 2 * π = ψ + ((5 : ℕ) : ℝ) * (π / 3) by push_cast; ring,
        show (((0 : ℕ) : ZMod 3)) = ((5 : ℕ) : ZMod 3) + 1 from rfl]
      exact this
    · have := (hR (j - 1) (by omega)).2.2
      rw [show ψ + ((j - 1 : ℕ) : ℝ) * (π / 3) = ψ + j * (π / 3) - π / 3 by rw [Nat.cast_sub (by omega)]; push_cast; ring,
        show (((j - 1 : ℕ) : ZMod 3)) + 1 = (j : ZMod 3) by rw [Nat.cast_sub (by omega)]; push_cast; ring] at this
      exact this
  have hpt : ∀ j : ℕ, ∃ c : Fin k, ∃ ρ : ℝ, j < 6 → c ∈ F.coloursAt u ∧ 0 < ρ ∧ ball (ringPt u (ψ + j * (π / 3))) ρ ⊆ F.dom ∧
      (∀ z ∈ F.interiorPts, dist z (ringPt u (ψ + j * (π / 3))) < ρ → 1 < dist z (ringPt u (ψ + j * (π / 3) + π / 3)) →
        1 < dist z (ringPt u (ψ + j * (π / 3) - π / 3)) → F.col z = c) ∧
      ∀ β ∈ coneAt (F.region c) u, dot (e β) (e (ψ + j * (π / 3))) ≤ 0 := by
    intro j
    by_cases hj : j < 6
    · have hne : b j ≠ b ((j : ZMod 3) + 1) := hb.ne (by intro h; have := congrArg (· - (j : ZMod 3)) h; simp at this)
      obtain ⟨c, hc', ρ, hρ, hρd, hK, hcone⟩ := hex_point hF hne (hxd _) (hR j hj).1 (hcw j hj) (hccw j hj)
        (fun h => hH j hj (Or.inl h))
      exact ⟨c, ρ, fun _ => ⟨hc', hρ, hρd, hK, hcone⟩⟩
    · exact ⟨b 0, 1, fun h => absurd h hj⟩
  choose c ρ hcρ using hpt
  have hne : ∀ j : ℕ, j < 6 → c j ≠ c ((j + 1) % 6) := by
    intro j hj
    obtain ⟨-, hρj, hdj, hKj, -⟩ := hcρ j hj
    have hj' : (j + 1) % 6 < 6 := Nat.mod_lt _ (by norm_num)
    obtain ⟨-, hρj', hdj', hKj', -⟩ := hcρ _ hj'
    obtain ⟨m, hm⟩ : ∃ m : ℤ, ψ + (((j + 1) % 6 : ℕ) : ℝ) * (π / 3) = ψ + j * (π / 3) + π / 3 + 2 * π * m := by
      rcases Nat.lt_or_ge (j + 1) 6 with h | h
      · exact ⟨0, by rw [Nat.mod_eq_of_lt h]; push_cast; ring⟩
      · obtain rfl : j = 5 := by omega
        exact ⟨-1, by norm_num; ring⟩
    refine hex_adjacent hF hρj hρj' hdj (y := ringPt u (ψ + (((j + 1) % 6 : ℕ) : ℝ) * (π / 3)))
      (y₁ := ringPt u (ψ + (((j + 1) % 6 : ℕ) : ℝ) * (π / 3) + π / 3)) (by rw [hm, hper]) ?_ hdj' hKj ?_
    · rw [hm, show ψ + j * (π / 3) + π / 3 + 2 * π * m + π / 3 = (ψ + j * (π / 3) + π / 3 + π / 3) + 2 * π * m by ring,
        hper]
    · intro z hz h1 h2 h3
      apply hKj' z hz h1 h2
      rwa [hm, show ψ + j * (π / 3) + π / 3 + 2 * π * m - π / 3 = (ψ + j * (π / 3)) + 2 * π * m by ring, hper]
  obtain ⟨-, j, hj, heq⟩ := hex_cones_of_serve hu0 hu c fun j hj => ⟨(hcρ j hj).1, (hcρ j hj).2.2.2.2⟩
  exact hne j hj heq

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
`|u₁ − u₂| ∉ {1, 3}`, at least one of the two points moves with non-zero component along `e = x₀ − y₀`; at a switch of both colours (no
turning point, `λ₁, λ₂ ≠ 0`) the two components are equal, so both are non-zero — so every switch of both colours at one configuration is a
`DoubleEvent` in one of its two senses. The input `bv_nd`'s consumers (BV-L3's step 4) use to read a `±2` jump as a double event. -/
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
