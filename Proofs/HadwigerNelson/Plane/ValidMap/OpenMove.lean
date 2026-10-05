import Proofs.HadwigerNelson.Plane.ValidMap.Contact

/-!
# OPEN at a point: the one-sector wedge-opening (FS131-E6-OPEN; FS131-IO1)

The fifth local move of the terminal procedure (inventory items 382–385; derivation `plans/FS131-E6-derivation.md` § 4.2, E6-OPEN;
record `plans/FS131-IO-implementation.md`). At a lone horn of a colour `c` whose allowed cone `D_c(v)` has non-empty interior,
recolouring with `c` a thin wedge beside the horn, on a side where `D_c(v)` has interior directions, gives a valid map equal to `F`
off a small disc about `v`, creating no unit arc, in which `v` gains no colour, its degree does not rise and it has one horn fewer.
SHAVE cannot take such a horn when its only admissible split is a unit circle (FS131-E6-OCCURS); OPEN can.

* **The horn count** (`HasHornCount`): for every small radius, exactly `j` of the sectors at `v` are horn sets. A horn set's cone at
  `v` is one direction (`e_eq_of_mem_coneAt_hornSet`), so a sector whose cone has interior directions is never one
  (`ne_hornSet_of_interior_coneAt`).
* **The configuration** (`Near.OpenConfig`, `Near.exists_openConfig`): the horn `idx s (hornPos up b)`, the swallowed horns
  between it and the first sector of positive angle `idx s (rayPos up b)` on the side `up` (`σ = +1`) or `¬ up` (`σ = −1`), the
  new ray's direction `ψ` strictly inside that sector, and a radius `ρc` below which the ray stays inside it and every point
  between the horn and the ray is clear for `c` (`cone_side`, `clear_near_end`, as E6-OPEN's steps 1–4).
* **The map** (`BranchGerms.openWedge`, `openCol`, `openRay`, `openRim`, `openArcs`): MERGE's arcs and colouring for the gap
  `s, 0, b` (`mergeArcs`, `mergeCol`), with the wedge of the partial sector between its gap germ and the ray recoloured `c`, the
  ray out to `ρ/2` and the rim arc at `ρ/2` across the wedge added (E6-OPEN's step 5, route (a)).
* **The clauses** (`Near.open_*`) and the assembly `ArcMap.exists_open`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## The horn count -/

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-- **`v` has exactly `j` horns**: for every small radius, exactly `j` of its sectors are horn sets. -/
def HasHornCount (v : ℂ) (j : ℕ) : Prop :=
  ∀ᶠ r in 𝓝[>] (0 : ℝ), {S | F.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r}.encard = j

variable {F}

/-- The horn count is unique. -/
theorem HasHornCount.eq {v : ℂ} {j j' : ℕ} (hj : F.HasHornCount v j) (hj' : F.HasHornCount v j') : j = j' := by
  obtain ⟨r, hr⟩ := (hj.and hj').exists
  exact_mod_cast hr.1.symm.trans hr.2

/-- The degree is unique. -/
theorem HasDegree.eq {v : ℂ} {m m' : ℕ} (hm : F.HasDegree v m) (hm' : F.HasDegree v m') : m = m' := by
  obtain ⟨r, hr⟩ := (hm.and hm').exists
  exact_mod_cast hr.1.symm.trans hr.2

end ArcMap

/-- **A set approaching `v` along an open interval of directions is no horn set** (a horn set's directions at `v` are one,
`e_eq_of_mem_coneAt_hornSet`). -/
theorem ne_hornSet_of_interior_coneAt {S : Set ℂ} {v : ℂ} (hS : (interior (coneAt S v)).Nonempty) (α κ₁ κ₂ r : ℝ) :
    S ≠ hornSet v α κ₁ κ₂ r := by
  rintro rfl
  obtain ⟨β₀, hβ₀⟩ := hS
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp isOpen_interior β₀ hβ₀
  have hπ := Real.pi_pos
  set δ := min ε π / 2 with hδ
  have hδ0 : 0 < δ := by positivity
  have hδε : δ < ε := by have := min_le_left ε π; linarith
  have hδπ : δ < π := by have := min_le_right ε π; linarith
  have h1 : e β₀ = e α := e_eq_of_mem_coneAt_hornSet (interior_subset hβ₀)
  have h2 : e (β₀ + δ) = e α := e_eq_of_mem_coneAt_hornSet (interior_subset (hball (by
    rw [mem_ball, Real.dist_eq, show β₀ + δ - β₀ = δ by ring, abs_of_pos hδ0]; exact hδε)))
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp (h2.trans h1.symm)
  have hm' : δ = m * (2 * π) := by linarith
  rcases lt_trichotomy m 0 with h | h | h
  · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_of_lt h
    nlinarith
  · rw [h] at hm'; simp at hm'; linarith
  · have : (1 : ℝ) ≤ m := by exact_mod_cast h
    nlinarith

-- spec examples for `HasHornCount`

/-- The constant map of the plane has no horn at any point: its one sector is the ball, which is no horn set. -/
example (j : Fin 2) : (ArcMap.const univ isOpen_univ j).HasHornCount 0 0 := by
  filter_upwards [self_mem_nhdsWithin] with r (hr : 0 < r)
  have hI : (ArcMap.const univ isOpen_univ j).interiorPts ∩ ball 0 r = ball 0 r := by
    rw [ArcMap.const_interiorPts, univ_inter]
  have hsec : ∀ S, (ArcMap.const univ isOpen_univ j).IsSector 0 r S → S = ball 0 r := by
    rintro S ⟨x, hx, rfl, -⟩
    rw [hI] at hx ⊢
    exact (convex_ball (0 : ℂ) r).isPreconnected.connectedComponentIn hx
  have hempty : {S | (ArcMap.const univ isOpen_univ j).IsSector 0 r S ∧
      ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet 0 α κ₁ κ₂ r} = ∅ := by
    ext S
    simp only [mem_setOf_eq, mem_empty_iff_false, iff_false, not_and, not_exists]
    intro hS α κ₁ κ₂ _ hSh
    have hball := hsec S hS
    -- the point `−(r/2) e α` is in the ball but behind the horn's axis
    have hz : -(((r / 2 : ℝ) : ℂ) * e α) ∈ ball (0 : ℂ) r := by
      rw [mem_ball, dist_zero_right, norm_neg, norm_mul_e (by linarith)]; linarith
    rw [← hball, hSh] at hz
    have hx := hz.2.1
    simp only [frameX, sub_zero, neg_mul, Complex.neg_re, mul_assoc] at hx
    rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, norm_e] at hx
    simp at hx; linarith
  rw [hempty, encard_empty]; rfl

/-! ## OPEN's map: the wedge, the ray, the rim arc, the colouring -/

/-- **The new ray** out to `ρ/2` at the direction `ψ`. -/
noncomputable def openRay (v : ℂ) (ψ ρ : ℝ) : Arc := .seg v (v + ((ρ / 2 : ℝ) : ℂ) * e ψ)

namespace BranchGerms

/-- The horn's position along the orbit: `0` when the wedge opens on the side `σ = +1` (`up`), `b` when on `σ = −1`. -/
def hornPos (up : Bool) (b : ℕ) : ℕ := if up then 0 else b

/-- The partial sector's position along the orbit: `b` for `up`, `0` otherwise. -/
def rayPos (up : Bool) (b : ℕ) : ℕ := if up then b else 0

variable {n : ℕ} (G : BranchGerms n)

/-- **The wedge** out to `ρ/2`: the part of the partial sector between its gap germ and the ray — for `up`, between germ
`idx s b` and the ray at `ψ`; otherwise between the ray and germ `idx s 1`. -/
def openWedge (v : ℂ) (up : Bool) (s : Fin n) (b : ℕ) (ψ ρ : ℝ) : Set ℂ :=
  if up then sectorBetween v (G.lift s b) (G.κ (idx s b)) ψ 0 (ρ / 2)
  else sectorBetween v ψ 0 (G.lift s 1) (G.κ (idx s 1)) (ρ / 2)

/-- **OPEN's colouring**: `c` on the wedge, MERGE's colouring for the gap `s, 0, b` elsewhere (`c` on the gap out to `ρ/2`, the
colour after the germ on a branch out to `ρ`, `Fcol` elsewhere). -/
noncomputable def openCol {k : ℕ} (v : ℂ) (col : Fin n → Fin k) (Fcol : ℂ → Fin k) (up : Bool) (s : Fin n) (b : ℕ)
    (ψ : ℝ) (c : Fin k) (ρ : ℝ) : ℂ → Fin k := fun z => by
  classical
  exact if z ∈ G.openWedge v up s b ψ ρ then c else G.mergeCol v col Fcol s 0 b c ρ z

/-- **The rim arc across the wedge**, at `ρ/2`: from germ `idx s b` to the ray for `up`, from the ray to germ `idx s 1`
otherwise. -/
noncomputable def openRim (v : ℂ) (up : Bool) (s : Fin n) (b : ℕ) (ψ ρ : ℝ) : Arc :=
  if up then .circ v (ρ / 2) (G.liftDir s b (ρ / 2)) ψ else .circ v (ρ / 2) ψ (G.liftDir s 1 (ρ / 2))

/-- **OPEN's new arcs**: MERGE's for the gap `s, 0, b` (the germs off the gap out to `ρ/2`, the non-phantom germs' pieces between
`ρ/2` and `ρ`, the rim arc across the gap's sectors), the ray, and the rim arc across the wedge. -/
noncomputable def openArcs {k : ℕ} (v : ℂ) (col : Fin n → Fin k) (up : Bool) (s : Fin n) (b : ℕ) (ψ ρ : ℝ) : Set Arc :=
  G.mergeArcs v col s 0 b ρ ∪ {openRay v ψ ρ, G.openRim v up s b ψ ρ}

end BranchGerms

-- spec examples for OPEN's definitions
example : BranchGerms.hornPos true 3 = 0 ∧ BranchGerms.hornPos false 3 = 3 := ⟨rfl, rfl⟩
example : BranchGerms.rayPos true 3 = 3 ∧ BranchGerms.rayPos false 3 = 0 := ⟨rfl, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (s : Fin 3) (ψ ρ : ℝ) :
    G.openWedge v true s 2 ψ ρ = sectorBetween v (G.lift s 2) (G.κ (BranchGerms.idx s 2)) ψ 0 (ρ / 2) ∧
      G.openWedge v false s 2 ψ ρ = sectorBetween v ψ 0 (G.lift s 1) (G.κ (BranchGerms.idx s 1)) (ρ / 2) :=
  ⟨rfl, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (col : Fin 3 → Fin 2) (Fcol : ℂ → Fin 2) (s : Fin 3) (ψ : ℝ) (c : Fin 2) (ρ : ℝ) (z : ℂ)
    (hz : z ∈ G.openWedge v true s 2 ψ ρ) : G.openCol v col Fcol true s 2 ψ c ρ z = c := by
  simp [BranchGerms.openCol, hz]
example (G : BranchGerms 3) (v : ℂ) (col : Fin 3 → Fin 2) (Fcol : ℂ → Fin 2) (s : Fin 3) (ψ : ℝ) (c : Fin 2) (ρ : ℝ) (z : ℂ)
    (hz : z ∉ G.openWedge v true s 2 ψ ρ) :
    G.openCol v col Fcol true s 2 ψ c ρ z = G.mergeCol v col Fcol s 0 2 c ρ z := by
  simp [BranchGerms.openCol, hz]
example (v : ℂ) (ψ ρ : ℝ) : openRay v ψ ρ = .seg v (v + ((ρ / 2 : ℝ) : ℂ) * e ψ) := rfl
example (G : BranchGerms 3) (v : ℂ) (s : Fin 3) (ψ ρ : ℝ) :
    G.openRim v true s 2 ψ ρ = .circ v (ρ / 2) (G.liftDir s 2 (ρ / 2)) ψ ∧
      G.openRim v false s 2 ψ ρ = .circ v (ρ / 2) ψ (G.liftDir s 1 (ρ / 2)) := ⟨rfl, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (col : Fin 3 → Fin 2) (s : Fin 3) (ψ ρ : ℝ) :
    openRay v ψ ρ ∈ G.openArcs v col true s 2 ψ ρ ∧ G.openRim v true s 2 ψ ρ ∈ G.openArcs v col true s 2 ψ ρ ∧
      G.rimArc v s 0 2 ρ ∈ G.openArcs v col true s 2 ψ ρ :=
  ⟨Or.inr (Or.inl rfl), Or.inr (Or.inr rfl), Or.inl (Or.inr ⟨by omega, rfl⟩)⟩

/-! ## The configuration: the side, the gap, the ray, the clear radius -/

namespace ArcMap

namespace Near

variable {k : ℕ} {F : ArcMap k} {v : ℂ}

/-- **OPEN's configuration** at `v` (E6-OPEN's steps 1–4): along the orbit from `s`, the horn `idx s (hornPos up b)` (a cusp,
the only chart sector of colour `c`), the swallowed sectors strictly between `0` and `b`, and the partial sector
`idx s (rayPos up b)` with the ray's direction `ψ` strictly inside it below the radius `ρc`; below `ρc` every point between the
horn's inner germ and the ray (for `up`: from germ `idx s 1` up to `ψ`; otherwise from `ψ` up to germ `idx s b`) is clear for
`c`. -/
structure OpenConfig (X : F.Near v) (c : Fin k) (up : Bool) (s : Fin X.n) (b : ℕ) (ψ ρc : ℝ) : Prop where
  /-- The gap has a germ. -/
  hb1 : 1 ≤ b
  /-- The gap stays within one turn. -/
  hbn : b < X.n
  /-- The clear radius is positive. -/
  hρc : 0 < ρc
  /-- The clear radius is below the ordered radius. -/
  hρcs : ρc ≤ X.s₀
  /-- The horn is a cusp. -/
  cusp : X.G.lift s (BranchGerms.hornPos up b) = X.G.lift s (BranchGerms.hornPos up b + 1)
  /-- The horn has the colour `c`. -/
  col_horn : X.col (BranchGerms.idx s (BranchGerms.hornPos up b)) = c
  /-- It is the only chart sector of colour `c`. -/
  lone : ∀ i, X.col i = c → i = BranchGerms.idx s (BranchGerms.hornPos up b)
  /-- Below `ρc` the ray lies strictly inside the partial sector. -/
  ray : ∀ t ∈ Ioo 0 ρc, X.G.liftDir s (BranchGerms.rayPos up b) t < ψ ∧
    ψ < X.G.liftDir s (BranchGerms.rayPos up b + 1) t
  /-- Below `ρc` every point between the horn's inner germ and the ray is clear for `c`. -/
  clear : ∀ t ∈ Ioo 0 ρc, ∀ φ, (if up then X.G.liftDir s 1 t else ψ) ≤ φ →
    φ ≤ (if up then ψ else X.G.liftDir s b t) → F.IsClear c (v + (t : ℂ) * e φ)

/-- **OPEN's configuration exists** at a lone horn whose colour's allowed cone has interior (E6-OPEN's steps 1–4): the horn's
direction is allowed (N3-CONF), `cone_side` gives the side, the first sector of positive angle on that side is the partial
sector, and `clear_near_end` (N3-CLEAR with N3-UP's push) gives the clear wedge, inside which the ray is chosen. -/
theorem exists_openConfig (hF : F.Valid) (hv : F.Covers v 1) (X : F.Near v) {α κ₁ κ₂ : ℝ} {c : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : F.HasSectors v c 1) (hD : (interior (F.allowedCone v c)).Nonempty) :
    ∃ up s b ψ ρc, X.OpenConfig c up s b ψ ρc := by
  sorry

/-! ## OPEN's arcs -/

variable {X : F.Near v} {s : Fin X.n} {b : ℕ}

/-- OPEN's new arcs are finitely many. -/
theorem openArcs_finite {up : Bool} {ψ : ℝ} (ρ : ℝ) : (X.G.openArcs v X.col up s b ψ ρ).Finite :=
  (mergeArcs_finite ρ).union (toFinite _)

/-- OPEN's new arcs are non-degenerate. -/
theorem openArcs_nondegenerate {c : Fin k} {up : Bool} {ψ ρc ρ : ℝ} (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ)
    (hρc : ρ ≤ ρc) : ∀ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.Nondegenerate := by
  sorry

/-- **OPEN's colouring is locally constant** off the trimmed arcs and the new arcs. -/
theorem open_hlc {c : Fin k} {up : Bool} {ψ ρc ρ ρ' : ℝ} (cfg : X.OpenConfig c up s b ψ ρc) (h' : X.Small ρ')
    (hρρ' : ρ < ρ') (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.G.openArcs v X.col up s b ψ ρ, a.carrier →
      ∀ᶠ y in 𝓝 x, X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.openCol v X.col F.col up s b ψ c ρ x := by
  sorry

/-! ## OPEN's clauses -/

section Surgery

variable {c : Fin k} {up : Bool} {ψ ρc ρ : ℝ} {hv : v ∈ F.dom} {hρ : 0 < ρ}
  {hA : ∀ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.Nondegenerate} {hAf : (X.G.openArcs v X.col up s b ψ ρ).Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.G.openArcs v X.col up s b ψ ρ, a.carrier →
    ∀ᶠ y in 𝓝 x, X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.openCol v X.col F.col up s b ψ c ρ x}

/-- OPEN's map agrees with `F` off the closed disc. -/
theorem open_agreesOff (h : X.Small ρ) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).AgreesOff F
      (closedBall v ρ) := by
  sorry

/-- OPEN's map creates no unit arc. -/
theorem open_ringArcsWithin (h : X.Small ρ) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).RingArcsWithin
      F := by
  sorry

/-- OPEN's map keeps Condition 5. -/
theorem open_condition5 (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    F.Condition5 →
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).Condition5 := by
  sorry

/-- **OPEN's map is valid**: every recoloured point is clear for `c` (the configuration's clear wedge), and the disc is small. -/
theorem open_valid (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).Valid := by
  sorry

/-- **`v` gains no colour**: every colour of the new map near `v` is a chart sector's colour or `c`. -/
theorem open_coloursAt_self (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).coloursAt v ⊆
      F.coloursAt v := by
  sorry

/-- **The degree does not rise and a horn is lost**: below `ρ/2` the sectors of the new map at `v` are the chart sectors off the
gap, the merged piece (the horn, the swallowed horns and the wedge) and the rest of the partial sector; the last two have
directions on an open interval, so they are no horn sets, while the horn was one. -/
theorem open_degree_horns (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ)
    (hρc : ρ ≤ ρc) {m j : ℕ} (hm : F.HasDegree v m) (hj : F.HasHornCount v j) :
    ∃ m' j', m' ≤ m ∧ j' < j ∧
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).HasDegree v m' ∧
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).HasHornCount v
        j' := by
  sorry

/-- **The rim**: near a point of `∂B(v, ρ)` the new map is MERGE's (the wedge, the ray and the rim arc lie inside `B̄(v, ρ/2)`), so
the point carries at most three colours, none repeated. -/
theorem open_rim (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ)
    (hρc : ρ ≤ ρc) :
    ∀ x ∈ sphere v ρ,
      ((F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).coloursAt
        x).ncard ≤ 3 ∧
      ¬ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
        hlc).HasRepeatedColour x := by
  sorry

/-- **`D_c(v′)` is unchanged off the disc** (`merge_allowedCone`'s route): the recoloured set's closure lies in `{v}` and an open
set of points clear for `c`, so no contact of `c` moves (`dist_ne_one_of_isOpen_isClear`), and the tiles keep their types. -/
theorem open_allowedCone (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    ∀ v' ∉ closedBall v ρ,
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
        hlc).allowedCone v' c = F.allowedCone v' c := by
  sorry

end Surgery

end Near

variable {k : ℕ} {F : ArcMap k}

/-! ## FS131-E6-OPEN -/

/-- **FS131-E6-OPEN** (FS110 § 2.8's wedge-opening, derived with unit arcs allowed): at a lone `c`-horn (`c` has one sector at
`v`) whose colour's allowed cone `D_c(v)` has non-empty interior, recolouring with `c` a thin wedge beside the horn, on a side
where `D_c(v)` has interior directions, gives a valid map, equal to `F` off a small disc about `v`, creating no unit arc (so
Condition 5 is kept), in which `v` gains no colour, `v`'s degree does not rise and it has at least one horn fewer, the new points
on the rim carry at most three colours with none repeated, and no other point's allowed cone for `c` changes. -/
theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : F.HasSectors v c 1) (hD : (interior (F.allowedCone v c)).Nonempty) {m j : ℕ}
    (hm : F.HasDegree v m) (hj : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
    ∃ ρ, 0 < ρ ∧ ρ < δ ∧ ∃ F' : ArcMap k, F'.Valid ∧ F'.AgreesOff F (closedBall v ρ) ∧ F'.RingArcsWithin F ∧
      (F.Condition5 → F'.Condition5) ∧ F'.coloursAt v ⊆ F.coloursAt v ∧
      (∃ m' j', m' ≤ m ∧ j' < j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
      (∀ x ∈ sphere v ρ, (F'.coloursAt x).ncard ≤ 3 ∧ ¬ F'.HasRepeatedColour x) ∧
      ∀ v' ∉ closedBall v ρ, F'.allowedCone v' c = F.allowedCone v' c := by
  classical
  obtain ⟨X⟩ := exists_near (hv (mem_closedBall_self zero_le_one))
  obtain ⟨up, s, b, ψ, ρc, cfg⟩ := Near.exists_openConfig hF hv X hH h1 hD
  obtain ⟨ρ', h'⟩ := X.eventually_small.exists
  have hρ'0 := h'.1
  set ρ := min (min (ρ' / 2) ρc) (δ / 2) with hρdef
  have hρ0 : 0 < ρ := lt_min (lt_min (by linarith) cfg.hρc) (by linarith)
  have hρρ' : ρ < ρ' := ((min_le_left _ _).trans (min_le_left _ _)).trans_lt (by linarith)
  have hρc : ρ ≤ ρc := (min_le_left _ _).trans (min_le_right _ _)
  have hρδ : ρ < δ := (min_le_right _ _).trans_lt (by linarith)
  have h : X.Small ρ := h'.mono hρ0 hρρ'.le
  refine ⟨ρ, hρ0, hρδ, F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) X.mem_dom
    hρ0 (Near.openArcs_nondegenerate cfg h hρc) (Near.openArcs_finite ρ) (Near.open_hlc cfg h' hρρ' h hρc),
    Near.open_valid hF cfg h' hρρ' h hρc, Near.open_agreesOff h, Near.open_ringArcsWithin h, Near.open_condition5 cfg h hρc,
    Near.open_coloursAt_self cfg h hρc, Near.open_degree_horns cfg h' hρρ' h hρc hm hj, Near.open_rim cfg h' hρρ' h hρc,
    Near.open_allowedCone hF cfg h' hρρ' h hρc⟩

end ArcMap

end HadwigerNelson.Plane
