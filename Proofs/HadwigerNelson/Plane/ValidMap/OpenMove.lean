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

/-- **The merged piece** out to `r` (FS131-IO2): the new `c`-sector, from the horn's outer germ to the ray — for `up`, between germ
`idx s 0` and the ray; otherwise between the ray and germ `idx s (b + 1)`. -/
def openPiece (v : ℂ) (up : Bool) (s : Fin n) (b : ℕ) (ψ r : ℝ) : Set ℂ :=
  if up then sectorBetween v (G.lift s 0) (G.κ (idx s 0)) ψ 0 r
  else sectorBetween v ψ 0 (G.lift s (b + 1)) (G.κ (idx s (b + 1))) r

/-- **The rest of the partial sector** out to `r`, beyond the ray: for `up`, between the ray and germ `idx s (b + 1)`; otherwise
between germ `idx s 0` and the ray. -/
def openRest (v : ℂ) (up : Bool) (s : Fin n) (b : ℕ) (ψ r : ℝ) : Set ℂ :=
  if up then sectorBetween v ψ 0 (G.lift s (b + 1)) (G.κ (idx s (b + 1))) r
  else sectorBetween v (G.lift s 0) (G.κ (idx s 0)) ψ 0 r

/-- **OPEN's new arcs**: MERGE's for the gap `s, 0, b` (the germs off the gap out to `ρ/2`, the non-phantom germs' pieces between
`ρ/2` and `ρ`, the rim arc across the gap's sectors), the ray, and the rim arc across the wedge. -/
noncomputable def openArcs {k : ℕ} (v : ℂ) (col : Fin n → Fin k) (up : Bool) (s : Fin n) (b : ℕ) (ψ ρ : ℝ) : Set Arc :=
  G.mergeArcs v col s 0 b ρ ∪ {openRay v ψ ρ, G.openRim v up s b ψ ρ}

/-- The wedge in lifted directions. -/
theorem mem_openWedge {v z : ℂ} {up : Bool} {s : Fin n} {b : ℕ} {ψ ρ : ℝ} :
    z ∈ G.openWedge v up s b ψ ρ ↔ ∃ t ∈ Ioo 0 (ρ / 2), ∃ φ, (if up then G.liftDir s b t < φ ∧ φ < ψ else
      ψ < φ ∧ φ < G.liftDir s 1 t) ∧ z = v + (t : ℂ) * e φ := by
  cases up <;>
  · simp only [openWedge, Bool.false_eq_true, if_true, if_false, sectorBetween, mem_setOf_eq, mem_Ioo, zero_mul, zero_div,
      Real.arcsin_zero, add_zero, liftDir, germDir]

/-- The merged piece in lifted directions. -/
theorem mem_openPiece {v z : ℂ} {up : Bool} {s : Fin n} {b : ℕ} {ψ r : ℝ} :
    z ∈ G.openPiece v up s b ψ r ↔ ∃ t ∈ Ioo 0 r, ∃ φ, (if up then G.liftDir s 0 t < φ ∧ φ < ψ else
      ψ < φ ∧ φ < G.liftDir s (b + 1) t) ∧ z = v + (t : ℂ) * e φ := by
  cases up <;>
  · simp only [openPiece, Bool.false_eq_true, if_true, if_false, sectorBetween, mem_setOf_eq, mem_Ioo, zero_mul, zero_div,
      Real.arcsin_zero, add_zero, liftDir, germDir]

/-- The rest of the partial sector in lifted directions. -/
theorem mem_openRest {v z : ℂ} {up : Bool} {s : Fin n} {b : ℕ} {ψ r : ℝ} :
    z ∈ G.openRest v up s b ψ r ↔ ∃ t ∈ Ioo 0 r, ∃ φ, (if up then ψ < φ ∧ φ < G.liftDir s (b + 1) t else
      G.liftDir s 0 t < φ ∧ φ < ψ) ∧ z = v + (t : ℂ) * e φ := by
  cases up <;>
  · simp only [openRest, Bool.false_eq_true, if_true, if_false, sectorBetween, mem_setOf_eq, mem_Ioo, zero_mul, zero_div,
      Real.arcsin_zero, add_zero, liftDir, germDir]

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
example (G : BranchGerms 3) (v : ℂ) (s : Fin 3) (ψ r : ℝ) :
    G.openPiece v true s 2 ψ r = sectorBetween v (G.lift s 0) (G.κ (BranchGerms.idx s 0)) ψ 0 r ∧
      G.openPiece v false s 2 ψ r = sectorBetween v ψ 0 (G.lift s 3) (G.κ (BranchGerms.idx s 3)) r := ⟨rfl, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (s : Fin 3) (ψ r : ℝ) :
    G.openRest v true s 2 ψ r = sectorBetween v ψ 0 (G.lift s 3) (G.κ (BranchGerms.idx s 3)) r ∧
      G.openRest v false s 2 ψ r = sectorBetween v (G.lift s 0) (G.κ (BranchGerms.idx s 0)) ψ 0 r := ⟨rfl, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (s : Fin 3) (ψ ρ : ℝ) :
    G.openRim v true s 2 ψ ρ = .circ v (ρ / 2) (G.liftDir s 2 (ρ / 2)) ψ ∧
      G.openRim v false s 2 ψ ρ = .circ v (ρ / 2) ψ (G.liftDir s 1 (ρ / 2)) := ⟨rfl, rfl⟩
example (G : BranchGerms 3) (v : ℂ) (col : Fin 3 → Fin 2) (s : Fin 3) (ψ ρ : ℝ) :
    openRay v ψ ρ ∈ G.openArcs v col true s 2 ψ ρ ∧ G.openRim v true s 2 ψ ρ ∈ G.openArcs v col true s 2 ψ ρ ∧
      G.rimArc v s 0 2 ρ ∈ G.openArcs v col true s 2 ψ ρ :=
  ⟨Or.inr (Or.inl rfl), Or.inr (Or.inr rfl), Or.inl (Or.inr ⟨by omega, rfl⟩)⟩

/-! ## The configuration: the side, the gap, the ray, the clear radius -/

/-- A uniform bound on `arcsin (κ t / 2)` for small `t` and bounded `κ`. -/
theorem exists_small_arcsin (K : ℝ) {d : ℝ} (hd : 0 < d) :
    ∃ ρ > 0, ∀ t ∈ Ioo 0 ρ, ∀ κ, |κ| ≤ K → |Real.arcsin (κ * t / 2)| < d := by
  obtain ⟨η, hη, harc⟩ := exists_abs_arcsin_lt hd
  refine ⟨η / (|K| + 1), by positivity, fun t ht κ hκ => harc _ ?_⟩
  have hK1 : 0 < |K| + 1 := by positivity
  have ht' : t * (|K| + 1) < η := (lt_div_iff₀ hK1).mp ht.2
  rw [abs_div, abs_mul, abs_of_pos ht.1, abs_two]
  have h1 : |κ| * t ≤ |K| * t := mul_le_mul_of_nonneg_right (hκ.trans (le_abs_self K)) ht.1.le
  nlinarith [ht.1, abs_nonneg K]


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
  /-- The ray lies strictly inside the partial sector's directions at `v` (FS131-IO2, inventory item 397: without it the ray may
  run along the horn, and the merged piece is then itself a horn). -/
  ray0 : X.G.lift s (BranchGerms.rayPos up b) < ψ ∧ ψ < X.G.lift s (BranchGerms.rayPos up b + 1)
  /-- Below `ρc` every point between the horn's inner germ and the ray is clear for `c`. -/
  clear : ∀ t ∈ Ioo 0 ρc, ∀ φ, (if up then X.G.liftDir s 1 t else ψ) ≤ φ →
    φ ≤ (if up then ψ else X.G.liftDir s b t) → F.IsClear c (v + (t : ℂ) * e φ)
  /-- Below `ρc` the clear range reaches past the ray by a margin (so every point of the ray has a clear neighbourhood; FS131-IO2,
  inventory item 393: without it `open_allowedCone` fails when the clear range ends exactly at the ray). -/
  margin : ∃ η > 0, ∀ t ∈ Ioo 0 ρc, ∀ φ, (if up then ψ else ψ - η) ≤ φ → φ ≤ (if up then ψ + η else ψ) →
    F.IsClear c (v + (t : ℂ) * e φ)

/-- The colour of a chart sector is carried at `v`. -/
theorem col_mem_coloursAt (X : F.Near v) (i : Fin X.n) : X.col i ∈ F.coloursAt v :=
  closure_mono (X.hcol₀ i) (X.hC.mem_closure_sector X.hs₀ i)

/-- **OPEN's configuration on the side `σ = +1`**: from a lone cusp `p` of colour `c` whose direction is interior to `D_c(v)`
or has a direction of `D_c(v)` on its `+1` side. -/
theorem exists_openConfig_up (hF : F.Valid) (hv : F.Covers v 1) (X : F.Near v) {c : Fin k} {p : Fin X.n}
    (hcusp : X.G.nextβ p = X.G.β p) (hcp : X.col p = c) (hlone : ∀ i, X.col i = c → i = p)
    (hK : e (X.G.β p) ∈ interior (F.allowedCone v c) ∨
      (e (X.G.β p) ∈ F.allowedCone v c ∧ ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (X.G.β p + 1 * ψ) ∈ F.allowedCone v c)) :
    ∃ b ψ ρc, X.OpenConfig c true p b ψ ρc := by
  classical
  have hπ := Real.pi_pos
  have hc : c ∈ F.coloursAt v := hcp ▸ X.col_mem_coloursAt p
  have hM := X.hC.sorted.mono
  have hmono := X.G.lift_mono hM p
  have hl0 : X.G.lift p 0 = X.G.β p := X.G.lift_zero p
  have hl01 : X.G.lift p 1 = X.G.lift p 0 := by
    rw [X.G.lift_succ p 0, BranchGerms.idx_zero, hcusp, sub_self, add_zero]
  -- a sector of positive angle after the horn
  have hex : ∃ m, 1 ≤ m ∧ m < X.n ∧ X.G.lift p m < X.G.lift p (m + 1) := by
    by_contra hne
    push Not at hne
    have hall : ∀ m, 1 ≤ m → m ≤ X.n → X.G.lift p m = X.G.lift p 1 := by
      intro m hm1 hmn
      induction m with
      | zero => omega
      | succ m ih =>
        rcases Nat.eq_zero_or_pos m with rfl | hm0
        · rfl
        · rw [← ih hm0 (by omega)]
          exact (le_antisymm (hne m hm0 (by omega)) (hmono (Nat.le_succ m))).symm.symm
    have h1 := hall X.n (by have := p.pos; omega) le_rfl
    have h2 : X.G.lift p (0 + X.n) = X.G.lift p 0 + 2 * π := X.G.lift_add_n p 0
    rw [zero_add] at h2
    linarith
  set b := Nat.find hex with hbdef
  obtain ⟨hb1, hbn, hjump⟩ := Nat.find_spec hex
  have hcusps : ∀ m, 1 ≤ m → m < b → X.G.lift p m = X.G.lift p (m + 1) := fun m hm1 hmb =>
    le_antisymm (hmono (Nat.le_succ m)) (not_lt.mp fun hlt => Nat.find_min hex hmb ⟨hm1, by omega, hlt⟩)
  have hlb : ∀ m, 1 ≤ m → m ≤ b → X.G.lift p m = X.G.lift p 1 := by
    intro m hm1 hmb
    induction m with
    | zero => omega
    | succ m ih =>
      rcases Nat.eq_zero_or_pos m with rfl | hm0
      · rfl
      · rw [← ih hm0 (by omega)]; exact (hcusps m hm0 (by omega)).symm
  have hlb' : X.G.lift p b = X.G.lift p 1 := hlb b hb1 le_rfl
  -- the clear wedge at the horn's upper germ
  have hca : X.col (BranchGerms.idx p 0) = c := by rw [BranchGerms.idx_zero]; exact hcp
  have hθ : X.G.lift p (0 + 1) = X.G.β p := by rw [zero_add, hl01, hl0]
  have hK' : e (X.G.lift p (0 + 1)) ∈ interior (F.allowedCone v c) ∨
      (e (X.G.lift p (0 + 1)) ∈ F.allowedCone v c ∧
        ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (X.G.lift p (0 + 1) + 1 * ψ) ∈ F.allowedCone v c) := by
    rw [hθ]; exact hK
  obtain ⟨ε, hε, ρ₁, hρ₁, hcl⟩ := clear_near_end hF hv hc (Or.inl rfl) hK' (X.base_before hca)
  simp only [zero_add] at hcl
  set gap := X.G.lift p (b + 1) - X.G.lift p b with hgap
  have hgap0 : 0 < gap := by rw [hgap]; linarith
  set ψ₁ := min ε gap / 2 with hψ₁
  have hψ₁0 : 0 < ψ₁ := by positivity
  have hψ₁ε : ψ₁ ≤ ε / 2 := by have := min_le_left ε gap; rw [hψ₁]; linarith
  have hψ₁g : ψ₁ ≤ gap / 2 := by have := min_le_right ε gap; rw [hψ₁]; linarith
  set Kb := |X.G.κ (BranchGerms.idx p 1)| + |X.G.κ (BranchGerms.idx p b)| + |X.G.κ (BranchGerms.idx p (b + 1))|
  obtain ⟨ρa, hρa, harc⟩ := exists_small_arcsin Kb hψ₁0
  have hK1 : |X.G.κ (BranchGerms.idx p 1)| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx p b)); have := abs_nonneg (X.G.κ (BranchGerms.idx p (b + 1))); linarith
  have hKb : |X.G.κ (BranchGerms.idx p b)| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx p 1)); have := abs_nonneg (X.G.κ (BranchGerms.idx p (b + 1))); linarith
  have hKb1 : |X.G.κ (BranchGerms.idx p (b + 1))| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx p 1)); have := abs_nonneg (X.G.κ (BranchGerms.idx p b)); linarith
  set ρc := min (min ρ₁ X.s₀) ρa with hρcdef
  have hρc0 : 0 < ρc := lt_min (lt_min hρ₁ X.hs₀.1) hρa
  have hρc1 : ρc ≤ ρ₁ := (min_le_left _ _).trans (min_le_left _ _)
  have hρcs : ρc ≤ X.s₀ := (min_le_left _ _).trans (min_le_right _ _)
  have hρca : ρc ≤ ρa := min_le_right _ _
  refine ⟨b, X.G.lift p b + ψ₁, ρc, ⟨hb1, hbn, hρc0, hρcs, ?_, ?_, ?_, ?_, ?_, ?_, ?_⟩⟩
  · show X.G.lift p 0 = X.G.lift p (0 + 1)
    rw [zero_add, hl01]
  · show X.col (BranchGerms.idx p 0) = c
    exact hca
  · intro i hi
    show i = BranchGerms.idx p 0
    rw [BranchGerms.idx_zero]; exact hlone i hi
  · intro t ht
    show X.G.liftDir p b t < X.G.lift p b + ψ₁ ∧ X.G.lift p b + ψ₁ < X.G.liftDir p (b + 1) t
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have h1 := harc t hta _ hKb
    have h2 := harc t hta _ hKb1
    unfold BranchGerms.liftDir germDir
    constructor
    · linarith [(abs_lt.mp h1).2]
    · linarith [(abs_lt.mp h2).1]
  · show X.G.lift p b < X.G.lift p b + ψ₁ ∧ X.G.lift p b + ψ₁ < X.G.lift p (b + 1)
    constructor <;> linarith
  · intro t ht φ hφ1 hφ2
    simp only [if_true] at hφ1 hφ2
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have h1 := harc t hta _ hK1
    refine hcl t ⟨ht.1, ht.2.trans_le hρc1⟩ φ ?_ ?_
    · have : X.G.liftDir p 1 t = germDir (X.G.lift p 1) (X.G.κ (BranchGerms.idx p 1)) t := rfl
      linarith
    · have hφ1' : X.G.lift p 1 - ψ₁ < φ := by
        have : X.G.liftDir p 1 t = X.G.lift p 1 + Real.arcsin (X.G.κ (BranchGerms.idx p 1) * t / 2) := rfl
        linarith [(abs_lt.mp h1).1]
      rw [abs_le]; constructor <;> linarith
  · refine ⟨ψ₁, hψ₁0, fun t ht φ hφ1 hφ2 => ?_⟩
    simp only [if_true] at hφ1 hφ2
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have h1 := harc t hta _ hK1
    have hdir : X.G.liftDir p 1 t = X.G.lift p 1 + Real.arcsin (X.G.κ (BranchGerms.idx p 1) * t / 2) := rfl
    refine hcl t ⟨ht.1, ht.2.trans_le hρc1⟩ φ ?_ ?_
    · have : X.G.liftDir p 1 t = germDir (X.G.lift p 1) (X.G.κ (BranchGerms.idx p 1)) t := rfl
      linarith [(abs_lt.mp h1).2]
    · rw [abs_le]; constructor <;> linarith


/-! ### Re-basing the orbit -/

theorem _root_.HadwigerNelson.Plane.BranchGerms.idx_idx {n : ℕ} (p : Fin n) (a m : ℕ) :
    BranchGerms.idx (BranchGerms.idx p a) m = BranchGerms.idx p (a + m) := by
  apply Fin.ext
  show ((p.val + a) % n + m) % n = (p.val + (a + m)) % n
  rw [Nat.mod_add_mod, Nat.add_assoc]

theorem _root_.HadwigerNelson.Plane.BranchGerms.turns_idx {n : ℕ} (p : Fin n) (a m : ℕ) :
    BranchGerms.turns (BranchGerms.idx p a) m + (p.val + a) / n = BranchGerms.turns p (a + m) := by
  have hn : 0 < n := p.pos
  show ((p.val + a) % n + m) / n + (p.val + a) / n = (p.val + (a + m)) / n
  have h := Nat.div_add_mod (p.val + a) n
  have : p.val + (a + m) = ((p.val + a) % n + m) + n * ((p.val + a) / n) := by omega
  rw [this, Nat.add_mul_div_left _ _ hn]

theorem _root_.HadwigerNelson.Plane.BranchGerms.liftDir_idx {n : ℕ} (G : BranchGerms n) (p : Fin n) (a m : ℕ) (t : ℝ) :
    G.liftDir (BranchGerms.idx p a) m t = G.liftDir p (a + m) t - 2 * π * (((p.val + a) / n : ℕ) : ℝ) := by
  have h := BranchGerms.turns_idx p a m
  unfold BranchGerms.liftDir BranchGerms.lift germDir
  rw [BranchGerms.idx_idx, ← h]
  push_cast; ring

theorem _root_.HadwigerNelson.Plane.BranchGerms.lift_idx {n : ℕ} (G : BranchGerms n) (p : Fin n) (a m : ℕ) :
    G.lift (BranchGerms.idx p a) m = G.lift p (a + m) - 2 * π * (((p.val + a) / n : ℕ) : ℝ) := by
  have h := G.liftDir_idx p a m 0
  simpa [BranchGerms.liftDir, germDir] using h

/-- **OPEN's configuration on the side `σ = −1`**: from a lone cusp `p` of colour `c` with a direction of `D_c(v)` on its `−1`
side; the orbit starts at the first sector of positive angle before `p`. -/
theorem exists_openConfig_down (hF : F.Valid) (hv : F.Covers v 1) (X : F.Near v) {c : Fin k} {p : Fin X.n}
    (hcusp : X.G.nextβ p = X.G.β p) (hcp : X.col p = c) (hlone : ∀ i, X.col i = c → i = p)
    (hK : e (X.G.β p) ∈ F.allowedCone v c ∧ ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (X.G.β p + -1 * ψ) ∈ F.allowedCone v c) :
    ∃ s b ψ ρc, X.OpenConfig c false s b ψ ρc := by
  classical
  have hπ := Real.pi_pos
  have hc : c ∈ F.coloursAt v := hcp ▸ X.col_mem_coloursAt p
  have hM := X.hC.sorted.mono
  have hmono := X.G.lift_mono hM p
  have hl01 : X.G.lift p 1 = X.G.lift p 0 := by
    rw [X.G.lift_succ p 0, BranchGerms.idx_zero, hcusp, sub_self, add_zero]
  have hpn := p.pos
  -- a sector of positive angle before the horn
  have hex : ∃ m, 1 ≤ m ∧ m < X.n ∧ X.G.lift p (X.n - m) < X.G.lift p (X.n - m + 1) := by
    by_contra hne
    push Not at hne
    have hstep : ∀ j, 1 ≤ j → j < X.n → X.G.lift p (j + 1) = X.G.lift p j := fun j hj1 hjn => by
      have := hne (X.n - j) (by omega) (by omega)
      rw [show X.n - (X.n - j) = j by omega] at this
      exact le_antisymm this (hmono (Nat.le_succ j))
    have hall : ∀ m, 1 ≤ m → m ≤ X.n → X.G.lift p m = X.G.lift p 1 := by
      intro m hm1 hmn
      induction m with
      | zero => omega
      | succ m ih =>
        rcases Nat.eq_zero_or_pos m with rfl | hm0
        · rfl
        · rw [hstep m hm0 (by omega)]; exact ih hm0 (by omega)
    have h1 := hall X.n (by omega) le_rfl
    have h2 : X.G.lift p (0 + X.n) = X.G.lift p 0 + 2 * π := X.G.lift_add_n p 0
    rw [zero_add] at h2
    linarith
  set b := Nat.find hex with hbdef
  obtain ⟨hb1, hbn, hjump⟩ := Nat.find_spec hex
  have hcusps : ∀ m, 1 ≤ m → m < b → X.G.lift p (X.n - m + 1) = X.G.lift p (X.n - m) := fun m hm1 hmb =>
    le_antisymm (not_lt.mp fun hlt => Nat.find_min hex hmb ⟨hm1, by omega, hlt⟩) (hmono (Nat.le_succ _))
  set s := BranchGerms.idx p (X.n - b) with hs
  set C : ℝ := 2 * π * (((p.val + (X.n - b)) / X.n : ℕ) : ℝ) with hC
  have hL : ∀ m, X.G.lift s m = X.G.lift p (X.n - b + m) - C := fun m => X.G.lift_idx p _ m
  have hLD : ∀ m t, X.G.liftDir s m t = X.G.liftDir p (X.n - b + m) t - C := fun m t => X.G.liftDir_idx p _ m t
  have hsb : BranchGerms.idx s b = p := by
    rw [hs, BranchGerms.idx_idx, show X.n - b + b = 0 + X.n by omega, BranchGerms.idx_add_n, BranchGerms.idx_zero]
  -- the lifted facts at `s`
  have hpos0 : X.G.lift s 0 < X.G.lift s 1 := by rw [hL, hL, add_zero]; linarith
  have hcusp_s : X.G.lift s b = X.G.lift s (b + 1) := by
    rw [hL, hL, show X.n - b + b = 0 + X.n by omega, show X.n - b + (b + 1) = 1 + X.n by omega, X.G.lift_add_n,
      X.G.lift_add_n, hl01]
  have hcusps_s : ∀ m, 1 ≤ m → m < b → X.G.lift s m = X.G.lift s (m + 1) := fun m hm1 hmb => by
    rw [hL, hL]
    have := hcusps (b - m) (by omega) (by omega)
    rw [show X.n - (b - m) = X.n - b + m by omega, show X.n - b + m + 1 = X.n - b + (m + 1) by omega] at this
    linarith
  have hl1b : ∀ m, 1 ≤ m → m ≤ b → X.G.lift s m = X.G.lift s 1 := by
    intro m hm1 hmb
    induction m with
    | zero => omega
    | succ m ih =>
      rcases Nat.eq_zero_or_pos m with rfl | hm0
      · rfl
      · rw [← ih hm0 (by omega)]; exact (hcusps_s m hm0 (by omega)).symm
  have hlb : X.G.lift s b = X.G.lift s 1 := hl1b b hb1 le_rfl
  -- the clear wedge at the horn's lower germ
  have hcb : X.col (BranchGerms.idx s b) = c := by rw [hsb]; exact hcp
  have he : e (X.G.lift s b) = e (X.G.β p) := by rw [X.G.e_lift, hsb]
  have hK' : e (X.G.lift s b) ∈ interior (F.allowedCone v c) ∨
      (e (X.G.lift s b) ∈ F.allowedCone v c ∧
        ∃ ψ, 0 < ψ ∧ ψ < π ∧ e (X.G.lift s b + -1 * ψ) ∈ F.allowedCone v c) := by
    right
    obtain ⟨h1, ψ, hψ, hψπ, h2⟩ := hK
    refine ⟨he ▸ h1, ψ, hψ, hψπ, ?_⟩
    rw [e_add, he, ← e_add]; exact h2
  obtain ⟨ε, hε, ρ₁, hρ₁, hcl⟩ := clear_near_end hF hv hc (Or.inr rfl) hK' (X.base_after hcb)
  set gap := X.G.lift s 1 - X.G.lift s 0 with hgap
  have hgap0 : 0 < gap := by rw [hgap]; linarith
  set ψ₁ := min ε gap / 2 with hψ₁
  have hψ₁0 : 0 < ψ₁ := by positivity
  have hψ₁ε : ψ₁ ≤ ε / 2 := by have := min_le_left ε gap; rw [hψ₁]; linarith
  have hψ₁g : ψ₁ ≤ gap / 2 := by have := min_le_right ε gap; rw [hψ₁]; linarith
  set Kb := |X.G.κ (BranchGerms.idx s b)| + |X.G.κ (BranchGerms.idx s 0)| + |X.G.κ (BranchGerms.idx s 1)|
  obtain ⟨ρa, hρa, harc⟩ := exists_small_arcsin Kb hψ₁0
  have hKb : |X.G.κ (BranchGerms.idx s b)| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx s 0)); have := abs_nonneg (X.G.κ (BranchGerms.idx s 1)); linarith
  have hK0 : |X.G.κ (BranchGerms.idx s 0)| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx s b)); have := abs_nonneg (X.G.κ (BranchGerms.idx s 1)); linarith
  have hK1 : |X.G.κ (BranchGerms.idx s 1)| ≤ Kb := by
    have := abs_nonneg (X.G.κ (BranchGerms.idx s b)); have := abs_nonneg (X.G.κ (BranchGerms.idx s 0)); linarith
  set ρc := min (min ρ₁ X.s₀) ρa with hρcdef
  have hρc0 : 0 < ρc := lt_min (lt_min hρ₁ X.hs₀.1) hρa
  have hρc1 : ρc ≤ ρ₁ := (min_le_left _ _).trans (min_le_left _ _)
  have hρcs : ρc ≤ X.s₀ := (min_le_left _ _).trans (min_le_right _ _)
  have hρca : ρc ≤ ρa := min_le_right _ _
  have hlone' : ∀ i, X.col i = c → i = BranchGerms.idx s b := fun i hi => by rw [hsb]; exact hlone i hi
  refine ⟨s, b, X.G.lift s 1 - ψ₁, ρc, ⟨hb1, hbn, hρc0, hρcs, hcusp_s, hcb, hlone', ?_, ?_, ?_, ?_⟩⟩
  · intro t ht
    show X.G.liftDir s 0 t < X.G.lift s 1 - ψ₁ ∧ X.G.lift s 1 - ψ₁ < X.G.liftDir s (0 + 1) t
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have h0 := harc t hta _ hK0
    have h1 := harc t hta _ hK1
    rw [zero_add]
    unfold BranchGerms.liftDir germDir
    constructor
    · linarith [(abs_lt.mp h0).2]
    · linarith [(abs_lt.mp h1).1]
  · show X.G.lift s 0 < X.G.lift s 1 - ψ₁ ∧ X.G.lift s 1 - ψ₁ < X.G.lift s (0 + 1)
    rw [zero_add]; constructor <;> linarith
  · intro t ht φ hφ1 hφ2
    simp only [Bool.false_eq_true, if_false] at hφ1 hφ2
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have hb' := harc t hta _ hKb
    refine hcl t ⟨ht.1, ht.2.trans_le hρc1⟩ φ ?_ ?_
    · have : X.G.liftDir s b t = germDir (X.G.lift s b) (X.G.κ (BranchGerms.idx s b)) t := rfl
      linarith
    · have hφ2' : φ < X.G.lift s b + ψ₁ := by
        have : X.G.liftDir s b t = X.G.lift s b + Real.arcsin (X.G.κ (BranchGerms.idx s b) * t / 2) := rfl
        linarith [(abs_lt.mp hb').2]
      rw [abs_le]; constructor <;> linarith
  · refine ⟨ψ₁, hψ₁0, fun t ht φ hφ1 hφ2 => ?_⟩
    simp only [Bool.false_eq_true, if_false] at hφ1 hφ2
    have hta : t ∈ Ioo 0 ρa := ⟨ht.1, ht.2.trans_le hρca⟩
    have hb' := harc t hta _ hKb
    have hdir : X.G.liftDir s b t = X.G.lift s b + Real.arcsin (X.G.κ (BranchGerms.idx s b) * t / 2) := rfl
    refine hcl t ⟨ht.1, ht.2.trans_le hρc1⟩ φ ?_ ?_
    · have : X.G.liftDir s b t = germDir (X.G.lift s b) (X.G.κ (BranchGerms.idx s b)) t := rfl
      linarith [(abs_lt.mp hb').1]
    · rw [abs_le]; constructor <;> linarith

/-- **OPEN's configuration exists** at a lone horn whose colour's allowed cone has interior (E6-OPEN's steps 1–4): the horn's
direction is allowed (N3-CONF), `cone_side` gives the side, the first sector of positive angle on that side is the partial
sector, and `clear_near_end` (N3-CLEAR with N3-UP's push) gives the clear wedge, inside which the ray is chosen. -/
theorem exists_openConfig (hF : F.Valid) (hv : F.Covers v 1) (X : F.Near v) {α κ₁ κ₂ : ℝ} {c : Fin k}
    (hH : F.IsHorn v α κ₁ κ₂ c) (h1 : F.HasSectors v c 1) (hD : (interior (F.allowedCone v c)).Nonempty) :
    ∃ up s b ψ ρc, X.OpenConfig c up s b ψ ρc := by
  obtain ⟨p, -, hnβ, -, -, hcp, -⟩ := X.horn_index hH
  have hn0 : 0 < X.n := p.pos
  have hcnt := X.encard_col_eq hn0 h1
  have hlone : ∀ i, X.col i = c → i = p := by
    obtain ⟨x, hx⟩ := Set.encard_eq_one.mp (by exact_mod_cast hcnt)
    intro i hi
    have h1' : i ∈ ({x} : Set (Fin X.n)) := hx ▸ hi
    have h2' : p ∈ ({x} : Set (Fin X.n)) := hx ▸ hcp
    rw [mem_singleton_iff] at h1' h2'; rw [h1', h2']
  have hθ : e (X.G.β p) ∈ F.allowedCone v c :=
    e_mem_allowedCone_of_col hF hv hcp ⟨le_rfl, X.hC.sorted.mono p⟩
  have hadd : ∀ d ∈ F.allowedCone v c, ∀ d' ∈ F.allowedCone v c, d + d' ∈ F.allowedCone v c :=
    fun d hd d' hd' => add_mem_allowedCone hd hd'
  have hsmul : ∀ d ∈ F.allowedCone v c, ∀ t : ℝ, 0 ≤ t → (t : ℂ) * d ∈ F.allowedCone v c :=
    fun d hd t ht => smul_mem_allowedCone ht hd
  rcases cone_side hadd hsmul hD hθ with hint | ⟨σ, hσ, ψ, hψ, hψπ, hK⟩
  · obtain ⟨b, ψ, ρc, cfg⟩ := exists_openConfig_up hF hv X hnβ hcp hlone (Or.inl hint)
    exact ⟨true, p, b, ψ, ρc, cfg⟩
  · rcases hσ with rfl | rfl
    · obtain ⟨b, ψ, ρc, cfg⟩ := exists_openConfig_up hF hv X hnβ hcp hlone (Or.inr ⟨hθ, ψ, hψ, hψπ, hK⟩)
      exact ⟨true, p, b, ψ, ρc, cfg⟩
    · obtain ⟨s, b, ψ, ρc, cfg⟩ := exists_openConfig_down hF hv X hnβ hcp hlone ⟨hθ, ψ, hψ, hψπ, hK⟩
      exact ⟨false, s, b, ψ, ρc, cfg⟩

/-! ## OPEN's arcs -/

variable {X : F.Near v} {s : Fin X.n} {b : ℕ}

/-- The wedge lies in the ball of radius `ρ/2`. -/
theorem _root_.HadwigerNelson.Plane.BranchGerms.openWedge_subset_ball {n : ℕ} (G : BranchGerms n) (v : ℂ) (up : Bool)
    (s : Fin n) (b : ℕ) (ψ ρ : ℝ) : G.openWedge v up s b ψ ρ ⊆ ball v (ρ / 2) := by
  unfold BranchGerms.openWedge
  split_ifs <;>
  · rintro z ⟨t, ht, φ, -, rfl⟩
    rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul_e ht.1.le]; exact ht.2

/-- The ray lies in the closed ball of radius `ρ/2`. -/
theorem openRay_subset_closedBall (v : ℂ) (ψ : ℝ) {ρ : ℝ} (hρ : 0 ≤ ρ) :
    (openRay v ψ ρ).carrier ⊆ closedBall v (ρ / 2) := by
  refine (convex_closedBall v (ρ / 2)).segment_subset (mem_closedBall_self (by linarith)) ?_
  rw [mem_closedBall, dist_eq_norm, add_sub_cancel_left, norm_mul_e (by linarith)]

/-- The ray is non-degenerate. -/
theorem openRay_nondegenerate {v : ℂ} {ψ ρ : ℝ} (hρ : 0 < ρ) : (openRay v ψ ρ).Nondegenerate := by
  show v ≠ v + ((ρ / 2 : ℝ) : ℂ) * e ψ
  intro h
  have : ‖((ρ / 2 : ℝ) : ℂ) * e ψ‖ = 0 := by rw [← add_sub_cancel_left v (((ρ / 2 : ℝ) : ℂ) * e ψ), ← h, sub_self, norm_zero]
  rw [norm_mul_e (by linarith)] at this; linarith

/-- The rim arc across the wedge lies on the circle of radius `ρ/2`. -/
theorem _root_.HadwigerNelson.Plane.BranchGerms.openRim_subset_sphere {n : ℕ} (G : BranchGerms n) (v : ℂ) (up : Bool)
    (s : Fin n) (b : ℕ) (ψ : ℝ) {ρ : ℝ} (hρ : 0 ≤ ρ) : (G.openRim v up s b ψ ρ).carrier ⊆ sphere v (ρ / 2) := by
  unfold BranchGerms.openRim
  split_ifs <;>
  · rintro z ⟨θ, -, rfl⟩
    rw [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul_e (by linarith)]

/-- The rim arc across the wedge is non-degenerate: the ray lies strictly inside the partial sector, within one turn. -/
theorem openRim_nondegenerate {c : Fin k} {up : Bool} {ψ ρc ρ : ℝ} (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ)
    (hρc : ρ ≤ ρc) : (X.G.openRim v up s b ψ ρ).Nondegenerate := by
  have hπ := Real.pi_pos
  have ht : ρ / 2 ∈ Ioo 0 ρc := ⟨by linarith [h.1], by linarith [h.1]⟩
  have hts : ρ / 2 ∈ Ioo 0 X.s₀ := ⟨by linarith [h.1], by linarith [h.1, h.2.1]⟩
  have hmono := (X.G.liftDir_mono X.hord s hts).monotone
  obtain ⟨hlo, hhi⟩ := cfg.ray (ρ / 2) ht
  have hb1 := cfg.hb1
  have hbn := cfg.hbn
  cases up
  · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hlo hhi
    unfold BranchGerms.openRim
    simp only [Bool.false_eq_true, if_false]
    refine ⟨by linarith [h.1], hhi, ?_⟩
    have : X.G.liftDir s 1 (ρ / 2) ≤ X.G.liftDir s (0 + X.n) (ρ / 2) := hmono (show 1 ≤ 0 + X.n by omega)
    rw [X.G.liftDir_add_n] at this; linarith
  · simp only [BranchGerms.rayPos, if_true] at hlo hhi
    unfold BranchGerms.openRim
    simp only [if_true]
    refine ⟨by linarith [h.1], hlo, ?_⟩
    have : X.G.liftDir s (b + 1) (ρ / 2) ≤ X.G.liftDir s (b + X.n) (ρ / 2) := hmono (show b + 1 ≤ b + X.n by omega)
    rw [X.G.liftDir_add_n] at this; linarith

/-- OPEN's new arcs are finitely many. -/
theorem openArcs_finite {up : Bool} {ψ : ℝ} (ρ : ℝ) : (X.G.openArcs v X.col up s b ψ ρ).Finite :=
  (mergeArcs_finite ρ).union (toFinite _)

/-- OPEN's new arcs are non-degenerate. -/
theorem openArcs_nondegenerate {c : Fin k} {up : Bool} {ψ ρc ρ : ℝ} (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ)
    (hρc : ρ ≤ ρc) : ∀ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.Nondegenerate := by
  intro A hA
  rcases hA with hA | hA
  · exact mergeArcs_nondegenerate h cfg.hbn A hA
  rcases hA with rfl | rfl
  · exact openRay_nondegenerate h.1
  · exact openRim_nondegenerate cfg h hρc

/-! ### The wedge, the merged piece and the rest of the partial sector (FS131-IO2) -/

/-- **A sector between two germs is open**: near a point of it, the local angle and the distance move continuously (as
`BranchGerms.isOpen_sector`). -/
theorem _root_.HadwigerNelson.Plane.isOpen_sectorBetween (v : ℂ) (β₁ κ₁ β₂ κ₂ r : ℝ) :
    IsOpen (sectorBetween v β₁ κ₁ β₂ κ₂ r) := by
  rw [isOpen_iff_mem_nhds]
  rintro z₀ ⟨s₀, hs₀, φ₀, hφ₀, hz₀⟩
  have hz₀v : z₀ ≠ v := by
    intro h
    have := congrArg (fun z => ‖z - v‖) hz₀
    simp only [h, sub_self, norm_zero, add_sub_cancel_left, norm_mul_e hs₀.1.le] at this
    linarith [hs₀.1]
  set ψ : ℂ → ℝ := fun z => φ₀ + arg ((z - v) / (z₀ - v)) with hψ
  have hψc : ContinuousAt ψ z₀ := continuousAt_const.add (continuousAt_arg_div hz₀v)
  have hψ0 : ψ z₀ = φ₀ := by simp [hψ, arg_div_self hz₀v]
  have hnc : ContinuousAt (fun z : ℂ => ‖z - v‖) z₀ :=
    (continuous_norm.comp (continuous_id.sub continuous_const)).continuousAt
  have hn0 : ‖z₀ - v‖ = s₀ := by rw [hz₀, add_sub_cancel_left, norm_mul_e hs₀.1.le]
  have ev1 : ∀ᶠ z in 𝓝 z₀, ‖z - v‖ ∈ Ioo 0 r :=
    hnc.preimage_mem_nhds (by rw [hn0]; exact Ioo_mem_nhds hs₀.1 hs₀.2)
  have ev2 : ∀ᶠ z in 𝓝 z₀, germDir β₁ κ₁ ‖z - v‖ < ψ z :=
    ContinuousAt.eventually_lt ((continuous_germDir β₁ κ₁).continuousAt.comp hnc) hψc
      (by simp only [hn0, hψ0]; exact hφ₀.1)
  have ev3 : ∀ᶠ z in 𝓝 z₀, ψ z < germDir β₂ κ₂ ‖z - v‖ :=
    ContinuousAt.eventually_lt hψc ((continuous_germDir β₂ κ₂).continuousAt.comp hnc)
      (by simp only [hn0, hψ0]; exact hφ₀.2)
  filter_upwards [ev1, ev2, ev3] with z h1 h2 h3
  exact ⟨‖z - v‖, h1, ψ z, ⟨h2, h3⟩, eq_polar_local hs₀.1 hz₀ z⟩

/-- **Two polar forms of one point** at angles less than a turn apart are one. -/
theorem _root_.HadwigerNelson.Plane.polar_eq_of_abs_lt {v : ℂ} {t t' φ φ' : ℝ} (ht : 0 < t) (ht' : 0 < t')
    (h : v + (t : ℂ) * e φ = v + (t' : ℂ) * e φ') (hφ : t = t' → |φ - φ'| < 2 * π) : t = t' ∧ φ = φ' := by
  obtain ⟨rfl, he⟩ := (polar_eq_iff ht ht').mp h
  refine ⟨rfl, ?_⟩
  have hφ := hφ rfl
  obtain ⟨m, hm⟩ := e_eq_e_iff.mp he
  have hπ := Real.pi_pos
  rw [hm, add_sub_cancel_left, abs_mul, abs_of_pos (by positivity : (0 : ℝ) < 2 * π)] at hφ
  have h2 : |(m : ℝ)| < 1 := by
    by_contra hc; push Not at hc; nlinarith
  have h3 : m = 0 := Int.abs_lt_one_iff.mp (by exact_mod_cast h2)
  rw [hm, h3]; simp

/-- **The closure of a sector between two germs** lies in the image of the closed region `t ∈ [0, r]`, `φ` between the two germs'
directions at `t` (the region is compact, `arcsin` being bounded). -/
theorem _root_.HadwigerNelson.Plane.closure_sectorBetween_subset (v : ℂ) (β₁ κ₁ β₂ κ₂ r : ℝ) :
    closure (sectorBetween v β₁ κ₁ β₂ κ₂ r) ⊆
      {z | ∃ t ∈ Icc 0 r, ∃ φ, germDir β₁ κ₁ t ≤ φ ∧ φ ≤ germDir β₂ κ₂ t ∧ z = v + (t : ℂ) * e φ} := by
  have hcont : ∀ β κ : ℝ, Continuous fun t => germDir β κ t := fun β κ => continuous_germDir β κ
  set K : Set (ℝ × ℝ) := ({p | 0 ≤ p.1} ∩ {p | p.1 ≤ r}) ∩
    ({p | germDir β₁ κ₁ p.1 ≤ p.2} ∩ {p | p.2 ≤ germDir β₂ κ₂ p.1}) with hK
  have hKc : IsClosed K :=
    ((isClosed_le continuous_const continuous_fst).inter (isClosed_le continuous_fst continuous_const)).inter
      ((isClosed_le ((hcont β₁ κ₁).comp continuous_fst) continuous_snd).inter
        (isClosed_le continuous_snd ((hcont β₂ κ₂).comp continuous_fst)))
  have hKsub : K ⊆ Icc 0 r ×ˢ Icc (β₁ - π / 2) (β₂ + π / 2) := by
    rintro ⟨t, φ⟩ ⟨⟨h0, hr⟩, h1, h2⟩
    simp only [mem_setOf_eq, germDir] at h0 hr h1 h2
    refine ⟨⟨h0, hr⟩, ?_, ?_⟩
    · linarith [Real.neg_pi_div_two_le_arcsin (κ₁ * t / 2)]
    · linarith [Real.arcsin_le_pi_div_two (κ₂ * t / 2)]
  have hKk : IsCompact K := (isCompact_Icc.prod isCompact_Icc).of_isClosed_subset hKc hKsub
  have hg : Continuous fun p : ℝ × ℝ => v + (p.1 : ℂ) * e p.2 :=
    continuous_const.add ((Complex.continuous_ofReal.comp continuous_fst).mul (continuous_e.comp continuous_snd))
  have hcl : IsClosed ((fun p : ℝ × ℝ => v + (p.1 : ℂ) * e p.2) '' K) := (hKk.image hg).isClosed
  refine (closure_minimal ?_ hcl).trans ?_
  · rintro z ⟨t, ht, φ, hφ, rfl⟩
    exact ⟨(t, φ), ⟨⟨ht.1.le, ht.2.le⟩, hφ.1.le, hφ.2.le⟩, rfl⟩
  · rintro _ ⟨⟨t, φ⟩, ⟨⟨h0, hr⟩, h1, h2⟩, rfl⟩
    exact ⟨t, ⟨h0, hr⟩, φ, h1, h2, rfl⟩

theorem _root_.HadwigerNelson.Plane.BranchGerms.isOpen_openWedge {n : ℕ} (G : BranchGerms n) (v : ℂ) (up : Bool) (s : Fin n)
    (b : ℕ) (ψ ρ : ℝ) : IsOpen (G.openWedge v up s b ψ ρ) := by
  unfold BranchGerms.openWedge; split_ifs <;> exact isOpen_sectorBetween _ _ _ _ _ _

theorem _root_.HadwigerNelson.Plane.BranchGerms.isOpen_openPiece {n : ℕ} (G : BranchGerms n) (v : ℂ) (up : Bool) (s : Fin n)
    (b : ℕ) (ψ r : ℝ) : IsOpen (G.openPiece v up s b ψ r) := by
  unfold BranchGerms.openPiece; split_ifs <;> exact isOpen_sectorBetween _ _ _ _ _ _

theorem _root_.HadwigerNelson.Plane.BranchGerms.isOpen_openRest {n : ℕ} (G : BranchGerms n) (v : ℂ) (up : Bool) (s : Fin n)
    (b : ℕ) (ψ r : ℝ) : IsOpen (G.openRest v up s b ψ r) := by
  unfold BranchGerms.openRest; split_ifs <;> exact isOpen_sectorBetween _ _ _ _ _ _

/-- A point of the ray out to `ρ/2` lies on the new ray. -/
theorem mem_openRay {ψ ρ t : ℝ} (hρ : 0 < ρ) (ht : t ∈ Icc 0 (ρ / 2)) :
    v + (t : ℂ) * e ψ ∈ (openRay v ψ ρ).carrier := by
  have hρ2 : (0 : ℝ) < ρ / 2 := by linarith
  refine ⟨1 - t / (ρ / 2), t / (ρ / 2), ?_, div_nonneg ht.1 hρ2.le, by ring, ?_⟩
  · rw [sub_nonneg, div_le_one hρ2]; exact ht.2
  · simp only [Complex.real_smul]
    have : (ρ : ℂ) ≠ 0 := by exact_mod_cast hρ.ne'
    push_cast
    field_simp
    ring

/-- A point of the circle of radius `ρ/2` between the wedge's germ and the ray lies on the rim arc across the wedge. -/
theorem mem_openRim {up : Bool} {ψ ρ φ : ℝ}
    (hφ : if up then X.G.liftDir s b (ρ / 2) ≤ φ ∧ φ ≤ ψ else ψ ≤ φ ∧ φ ≤ X.G.liftDir s 1 (ρ / 2)) :
    v + ((ρ / 2 : ℝ) : ℂ) * e φ ∈ (X.G.openRim v up s b ψ ρ).carrier := by
  cases up
  · simp only [Bool.false_eq_true, if_false] at hφ
    unfold BranchGerms.openRim; simp only [Bool.false_eq_true, if_false]; exact ⟨φ, hφ, rfl⟩
  · simp only [if_true] at hφ
    unfold BranchGerms.openRim; simp only [if_true]; exact ⟨φ, hφ, rfl⟩

variable {c : Fin k} {up : Bool} {ψ ρc : ℝ}

theorem OpenConfig.two_le (cfg : X.OpenConfig c up s b ψ ρc) : 2 ≤ X.n := by
  have := cfg.hb1; have := cfg.hbn; omega

/-- Below the clear radius the lifted directions increase along the orbit, and gain less than a turn in one step. -/
theorem OpenConfig.liftDir_succ_lt (cfg : X.OpenConfig c up s b ψ ρc) {t : ℝ} (ht : t ∈ Ioo 0 X.s₀) (m : ℕ) :
    X.G.liftDir s (m + 1) t < X.G.liftDir s m t + 2 * π := by
  rw [← X.G.liftDir_add_n s m t]
  exact X.G.liftDir_mono X.hord s ht (show m + 1 < m + X.n by have := cfg.two_le; omega)

/-- **The wedge lies in the partial sector** (the ray lies strictly inside it below the clear radius). -/
theorem openWedge_subset_sector (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    X.G.openWedge v up s b ψ ρ ⊆ X.G.sector v ρ (BranchGerms.idx s (BranchGerms.rayPos up b)) := by
  intro z hz
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openWedge.mp hz
  have htc : t ∈ Ioo 0 ρc := ⟨ht.1, by linarith [ht.2, h.1]⟩
  have hray := cfg.ray t htc
  refine (X.G.mem_sector_idx s _).mpr ⟨t, ⟨ht.1, by linarith [ht.2, h.1]⟩, φ, ?_, rfl⟩
  cases up
  · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hφ hray ⊢
    exact ⟨hray.1.trans hφ.1, hφ.2⟩
  · simp only [BranchGerms.rayPos, if_true] at hφ hray ⊢
    exact ⟨hφ.1, hφ.2.trans hray.2⟩

/-- **A point at a direction between the gap's end germs, inside `ρ/2`, lies in the merged piece.** -/
theorem mem_openPiece_of_Icc (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) (hρc : ρ ≤ ρc) {t φ : ℝ}
    (ht : t ∈ Ioo 0 (ρ / 2)) (hφ : φ ∈ Icc (X.G.liftDir s 1 t) (X.G.liftDir s b t)) :
    v + (t : ℂ) * e φ ∈ X.G.openPiece v up s b ψ (ρ / 2) := by
  have htc : t ∈ Ioo 0 ρc := ⟨ht.1, by linarith [ht.2, h.1]⟩
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
  have hmono := X.G.liftDir_mono X.hord s hts
  have hray := cfg.ray t htc
  refine X.G.mem_openPiece.mpr ⟨t, ht, φ, ?_, rfl⟩
  cases up
  · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hray ⊢
    exact ⟨hray.2.trans_le hφ.1, hφ.2.trans_lt (hmono (Nat.lt_succ_self b))⟩
  · simp only [BranchGerms.rayPos, if_true] at hray ⊢
    exact ⟨(hmono Nat.zero_lt_one).trans_le hφ.1, hφ.2.trans_lt hray.1⟩

/-- **The wedge lies in the merged piece.** -/
theorem openWedge_subset_openPiece (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) :
    X.G.openWedge v up s b ψ ρ ⊆ X.G.openPiece v up s b ψ (ρ / 2) := by
  intro z hz
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openWedge.mp hz
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
  have hmono := X.G.liftDir_mono X.hord s hts
  refine X.G.mem_openPiece.mpr ⟨t, ht, φ, ?_, rfl⟩
  cases up
  · simp only [Bool.false_eq_true, if_false] at hφ ⊢
    exact ⟨hφ.1, hφ.2.trans (hmono (show 1 < b + 1 by have := cfg.hb1; omega))⟩
  · simp only [if_true] at hφ ⊢
    exact ⟨(hmono.monotone (Nat.zero_le b)).trans_lt hφ.1, hφ.2⟩

/-- **The wedge misses the rest of the partial sector** (the two lie on the two sides of the ray, within one turn). -/
theorem disjoint_openWedge_openRest (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) :
    Disjoint (X.G.openWedge v up s b ψ ρ) (X.G.openRest v up s b ψ ρ) := by
  rw [Set.disjoint_left]
  intro z hz hz'
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openWedge.mp hz
  obtain ⟨t', ht', φ', hφ', he⟩ := X.G.mem_openRest.mp hz'
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
  have hmono := X.G.liftDir_mono X.hord s hts
  have hπ := Real.pi_pos
  obtain ⟨rfl, rfl⟩ := polar_eq_of_abs_lt ht.1 ht'.1 he fun htt => by
    subst htt
    cases up
    · simp only [Bool.false_eq_true, if_false] at hφ hφ'
      have h1 := cfg.liftDir_succ_lt hts 0
      rw [zero_add] at h1
      rw [abs_lt]; constructor <;> linarith [hφ.1, hφ.2, hφ'.1, hφ'.2]
    · simp only [if_true] at hφ hφ'
      have h1 := cfg.liftDir_succ_lt hts b
      rw [abs_lt]; constructor <;> linarith [hφ.1, hφ.2, hφ'.1, hφ'.2]
  cases up
  · simp only [Bool.false_eq_true, if_false] at hφ hφ'; linarith [hφ.1, hφ'.2]
  · simp only [if_true] at hφ hφ'; linarith [hφ.2, hφ'.1]

/-- **A point of the partial sector inside `B̄(v, ρ/2)`** is in the wedge, on the ray, on the rim arc across the wedge, or in the rest
of the partial sector. -/
theorem sector_rayPos_cases (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) {x : ℂ}
    (hx : x ∈ X.G.sector v ρ (BranchGerms.idx s (BranchGerms.rayPos up b))) (hxr : ‖x - v‖ ≤ ρ / 2) :
    x ∈ X.G.openWedge v up s b ψ ρ ∨ x ∈ (openRay v ψ ρ).carrier ∨ x ∈ (X.G.openRim v up s b ψ ρ).carrier ∨
      x ∈ X.G.openRest v up s b ψ ρ := by
  obtain ⟨t, ht, φ, hφ, rfl⟩ := (X.G.mem_sector_idx s _).mp hx
  rw [add_sub_cancel_left, norm_mul_e ht.1.le] at hxr
  rcases lt_trichotomy φ ψ with hlt | rfl | hgt
  · cases up
    · right; right; right
      simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hφ
      exact X.G.mem_openRest.mpr ⟨t, ht, φ, by simp only [Bool.false_eq_true, if_false]; exact ⟨hφ.1, hlt⟩, rfl⟩
    · simp only [BranchGerms.rayPos, if_true] at hφ
      rcases eq_or_lt_of_le hxr with heq | hlt'
      · right; right; left
        subst heq
        exact mem_openRim (by simp only [if_true]; exact ⟨hφ.1.le, hlt.le⟩)
      · left
        exact X.G.mem_openWedge.mpr ⟨t, ⟨ht.1, hlt'⟩, φ, by simp only [if_true]; exact ⟨hφ.1, hlt⟩, rfl⟩
  · right; left; exact mem_openRay h.1 ⟨ht.1.le, hxr⟩
  · cases up
    · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hφ
      rcases eq_or_lt_of_le hxr with heq | hlt'
      · right; right; left
        subst heq
        exact mem_openRim (by simp only [Bool.false_eq_true, if_false]; exact ⟨hgt.le, hφ.2.le⟩)
      · left
        exact X.G.mem_openWedge.mpr ⟨t, ⟨ht.1, hlt'⟩, φ, by simp only [Bool.false_eq_true, if_false]; exact ⟨hgt, hφ.2⟩, rfl⟩
    · right; right; right
      simp only [BranchGerms.rayPos, if_true] at hφ
      exact X.G.mem_openRest.mpr ⟨t, ht, φ, by simp only [if_true]; exact ⟨hgt, hφ.2⟩, rfl⟩

/-- **OPEN's colouring is `c` on the merged piece** out to `ρ/2`: its points are in the wedge, on a gap germ, or in the horn or a gap
sector. -/
theorem openCol_of_mem_openPiece (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) {z : ℂ}
    (hz : z ∈ X.G.openPiece v up s b ψ (ρ / 2)) : X.G.openCol v X.col F.col up s b ψ c ρ z = c := by
  classical
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openPiece.mp hz
  have htρ : t ∈ Ioo 0 ρ := ⟨ht.1, by linarith [ht.2, h.1]⟩
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
  have hmono := X.G.liftDir_mono X.hord s hts
  have hgerm : ∀ m, 0 < m → m ≤ b →
      X.G.mergeCol v X.col F.col s 0 b c ρ (v + (t : ℂ) * e (X.G.liftDir s m t)) = c := by
    intro m h1 h2
    rw [← X.G.branchPt_idx, mergeCol_branchPt h _ htρ, if_pos ⟨⟨m, h1, h2, rfl⟩, ht.2⟩]
  have hsec : ∀ m, (m = BranchGerms.hornPos up b ∨ (0 < m ∧ m < b)) → ∀ φ, X.G.liftDir s m t < φ →
      φ < X.G.liftDir s (m + 1) t → X.G.mergeCol v X.col F.col s 0 b c ρ (v + (t : ℂ) * e φ) = c := by
    intro m hm φ h1 h2
    have hz : v + (t : ℂ) * e φ ∈ X.G.sector v ρ (BranchGerms.idx s m) :=
      (X.G.mem_sector_idx s m).mpr ⟨t, htρ, φ, ⟨h1, h2⟩, rfl⟩
    rw [mergeCol_of_mem_sector h hz]
    split_ifs with hg
    · rfl
    · rcases hm with rfl | hm
      · exact cfg.col_horn
      · exact absurd ⟨⟨m, hm.1, hm.2, rfl⟩, by rw [add_sub_cancel_left, norm_mul_e ht.1.le]; exact ht.2⟩ hg
  unfold BranchGerms.openCol
  split_ifs with hW
  · rfl
  cases up
  · simp only [Bool.false_eq_true, if_false] at hφ
    have h1 : X.G.liftDir s 1 t ≤ φ := by
      by_contra hlt; push Not at hlt
      exact hW (X.G.mem_openWedge.mpr ⟨t, ht, φ, by simp only [Bool.false_eq_true, if_false]; exact ⟨hφ.1, hlt⟩, rfl⟩)
    rcases exists_step_of_strictMono hmono (show 1 ≤ b + 1 by omega) h1 hφ.2.le with he | ⟨m, hm1, hm2, hm3, hm4⟩
    · exact absurd he (ne_of_lt hφ.2)
    · rcases eq_or_lt_of_le hm3 with he | hlt
      · rw [← he]; exact hgerm m (by omega) (by omega)
      · refine hsec m ?_ φ hlt hm4
        rcases eq_or_lt_of_le (show m ≤ b by omega) with rfl | hmb
        · left; rfl
        · right; exact ⟨by omega, hmb⟩
  · simp only [if_true] at hφ
    have h1 : φ ≤ X.G.liftDir s b t := by
      by_contra hlt; push Not at hlt
      exact hW (X.G.mem_openWedge.mpr ⟨t, ht, φ, by simp only [if_true]; exact ⟨hlt, hφ.2⟩, rfl⟩)
    rcases exists_step_of_strictMono hmono (Nat.zero_le b) hφ.1.le h1 with he | ⟨m, hm1, hm2, hm3, hm4⟩
    · rw [he]; exact hgerm b cfg.hb1 le_rfl
    · rcases eq_or_lt_of_le hm3 with he | hlt
      · rcases Nat.eq_zero_or_pos m with rfl | hm0
        · exact absurd he (ne_of_lt hφ.1)
        · rw [← he]; exact hgerm m hm0 (by omega)
      · refine hsec m ?_ φ hlt hm4
        rcases Nat.eq_zero_or_pos m with rfl | hm0
        · left; rfl
        · right; exact ⟨hm0, hm2⟩

/-- **OPEN's colouring is locally constant** off the trimmed arcs and the new arcs. -/
theorem open_hlc {c : Fin k} {up : Bool} {ψ ρc ρ ρ' : ℝ} (cfg : X.OpenConfig c up s b ψ ρc) (h' : X.Small ρ')
    (hρρ' : ρ < ρ') (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.G.openArcs v X.col up s b ψ ρ, a.carrier →
      ∀ᶠ y in 𝓝 x, X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.openCol v X.col F.col up s b ψ c ρ x := by
  classical
  have hn : 0 < X.n := by have := cfg.hbn; omega
  have hb0 : 0 < b := cfg.hb1
  obtain ⟨-, h2, -⟩ := F.trimArcs_spec X.mem_dom h.1
  intro x hx hxa
  have hxO : ∀ A ∈ X.G.openArcs v X.col up s b ψ ρ, x ∉ A.carrier := fun A hA hxA' =>
    hxa (mem_iUnion₂.mpr ⟨A, Or.inr hA, hxA'⟩)
  have hxA : x ∉ ⋃ A ∈ X.G.mergeArcs v X.col s 0 b ρ, A.carrier := fun hm => by
    obtain ⟨A, hA, hxA'⟩ := mem_iUnion₂.mp hm; exact hxO A (Or.inl hA) hxA'
  have hxT : x ∉ ⋃ B ∈ F.trimArcs v ρ, B.carrier := fun hm => by
    obtain ⟨B, hB, hxB⟩ := mem_iUnion₂.mp hm; exact hxa (mem_iUnion₂.mpr ⟨B, Or.inl hB, hxB⟩)
  have hxR : x ∉ (openRay v ψ ρ).carrier := hxO _ (Or.inr (Or.inl rfl))
  have hxM : x ∉ (X.G.openRim v up s b ψ ρ).carrier := hxO _ (Or.inr (Or.inr rfl))
  have hoff : ∀ y, y ∉ X.G.openWedge v up s b ψ ρ →
      X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.mergeCol v X.col F.col s 0 b c ρ y := fun y hy => by
    unfold BranchGerms.openCol; rw [if_neg hy]
  by_cases hxP : x ∈ X.G.openPiece v up s b ψ (ρ / 2)
  · -- in the merged piece: `c` throughout
    filter_upwards [(X.G.isOpen_openPiece v up s b ψ (ρ / 2)).mem_nhds hxP] with y hy
    rw [openCol_of_mem_openPiece cfg h hy, openCol_of_mem_openPiece cfg h hxP]
  rcases le_or_gt ‖x - v‖ (ρ / 2) with hxr | hxr
  · -- inside `B̄(v, ρ/2)`, off the piece: a point of a sector off the gap
    have hxv : x ≠ v := fun hxv => hxR (hxv ▸ left_mem_segment ℝ _ _)
    have hxb : x ∈ ball v ρ := by rw [mem_ball, dist_eq_norm]; linarith [h.1]
    rcases ball_cases h hn hxb hxv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
    · have hig : i ∉ BranchGerms.gapSec s 0 b := by
        intro hig
        obtain ⟨φ, hφ, hxφ⟩ := exists_dir_of_mem_gapSec h hig hi
        rcases eq_or_lt_of_le hxr with heq | hlt
        · have hab' : 0 + 1 < b := by obtain ⟨m, h3, h4, -⟩ := hig; omega
          rw [heq] at hφ hxφ
          exact hxA (hxφ ▸ mem_mergeArcs_rim hab' hφ)
        · rw [zero_add] at hφ
          exact hxP (hxφ ▸ mem_openPiece_of_Icc cfg h hρc ⟨(norm_of_mem_sector hi).1, hlt⟩ hφ)
      have hev : ∀ᶠ y in 𝓝 x, y ∉ X.G.openWedge v up s b ψ ρ := by
        by_cases hir : i = BranchGerms.idx s (BranchGerms.rayPos up b)
        · subst hir
          rcases sector_rayPos_cases cfg h hi hxr with hW | hR | hM | hRest
          · exact absurd (openWedge_subset_openPiece cfg h hW) hxP
          · exact absurd hR hxR
          · exact absurd hM hxM
          · filter_upwards [(X.G.isOpen_openRest v up s b ψ ρ).mem_nhds hRest] with y hy hyW
            exact Set.disjoint_left.mp (disjoint_openWedge_openRest cfg h) hyW hy
        · filter_upwards [(X.hC.isOpen ρ h.mem_Ioc i).mem_nhds hi] with y hy hyW
          exact hir (sector_disjoint h hy (openWedge_subset_sector cfg h hρc hyW))
      filter_upwards [hev, (X.hC.isOpen ρ h.mem_Ioc i).mem_nhds hi] with y hyW hy
      rw [hoff y hyW, hoff x hev.self_of_nhds, mergeCol_of_mem_sector h hy, mergeCol_of_mem_sector h hi,
        if_neg (fun h1 => hig h1.1), if_neg (fun h1 => hig h1.1)]
    · -- a branch point inside `ρ/2`: on an arc, or in the piece
      exfalso
      rw [norm_branchPt_sub v _ _ ht.1.le] at hxr
      by_cases hjg : j ∈ BranchGerms.gapGerm s 0 b
      · obtain ⟨m, h1, h2', rfl⟩ := hjg
        have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, ht.2.trans h.2.1⟩
        have hφ := liftDir_gap_germ (s := s) hts h1 h2'
        rw [zero_add] at hφ
        rcases eq_or_lt_of_le hxr with heq | hlt
        · rw [X.G.branchPt_idx, heq] at hxA hxM
          rw [heq] at hφ
          by_cases hb1 : 0 + 1 < b
          · exact hxA (mem_mergeArcs_rim hb1 (by rw [zero_add]; exact hφ))
          · have hb : b = 1 := by omega
            have hm : m = 1 := by omega
            subst hb hm
            have hray := cfg.ray (ρ / 2) ⟨h.half.1, by linarith [h.1]⟩
            apply hxM
            refine mem_openRim ?_
            cases up
            · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hray ⊢
              exact ⟨hray.2.le, le_rfl⟩
            · simp only [BranchGerms.rayPos, if_true] at hray ⊢
              exact ⟨le_rfl, hray.1.le⟩
        · rw [X.G.branchPt_idx] at hxP
          exact hxP (mem_openPiece_of_Icc cfg h hρc ⟨ht.1, hlt⟩ hφ)
      · exact hxA (branchPt_mem_mergeArcs_inner h hjg ⟨ht.1, hxr⟩)
  · -- beyond `ρ/2`: OPEN's colouring is MERGE's, and MERGE's argument
    have hfar : ∀ᶠ y in 𝓝 x, X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.mergeCol v X.col F.col s 0 b c ρ y := by
      filter_upwards [isClosed_closedBall.isOpen_compl.mem_nhds (show x ∉ closedBall v (ρ / 2) by
        rw [mem_closedBall, dist_eq_norm, not_le]; exact hxr)] with y hy
      exact hoff y fun hyW => hy (ball_subset_closedBall (X.G.openWedge_subset_ball v up s b ψ ρ hyW))
    suffices hm : ∀ᶠ y in 𝓝 x, X.G.mergeCol v X.col F.col s 0 b c ρ y = X.G.mergeCol v X.col F.col s 0 b c ρ x by
      filter_upwards [hfar, hm] with y hy1 hy2
      rw [hy1, hy2, hfar.self_of_nhds]
    rcases lt_trichotomy (dist x v) ρ with hlt | heq | hgt
    · have hxv : x ≠ v := fun hxv => by rw [hxv, sub_self, norm_zero] at hxr; linarith [h.1]
      rcases ball_cases h hn hlt hxv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
      · filter_upwards [(X.hC.isOpen ρ h.mem_Ioc i).mem_nhds hi, isClosed_closedBall.isOpen_compl.mem_nhds
          (show x ∉ closedBall v (ρ / 2) by rw [mem_closedBall, dist_eq_norm, not_le]; exact hxr)] with y hy hyb
        rw [mem_compl_iff, mem_closedBall, dist_eq_norm, not_le] at hyb
        rw [mergeCol_of_mem_sector h hy, mergeCol_of_mem_sector h hi, if_neg (fun h1 => (not_lt.mpr hyb.le) h1.2),
          if_neg (fun h1 => (not_lt.mpr hxr.le) h1.2)]
      · obtain ⟨p, hpj⟩ := exists_next_eq j
        obtain ⟨ε, hε, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj (r := ρ) ⟨h.1, h.2.1.le⟩ (p := p) ht
        rw [hpj] at hball
        have hev : ∀ᶠ y in 𝓝 (branchPt v (X.G.β j) (X.G.κ j) t), y ∈ X.G.sector v ρ p ∪ X.G.sector v ρ j ∪
            branchPt v (X.G.β j) (X.G.κ j) '' Ioo 0 ρ := Filter.mem_of_superset (ball_mem_nhds _ hε) hball
        rw [norm_branchPt_sub v _ _ ht.1.le] at hxr
        have hph : BranchGerms.Phantom X.col j := by
          by_contra hph; exact hxA (branchPt_mem_mergeArcs_outer h hph ⟨hxr, ht.2.le⟩)
        have hpc : X.col p = X.col j := by
          obtain ⟨i, hi, hc⟩ := hph; rw [← BranchGerms.next_injective (hi.trans hpj.symm)]; exact hc
        rw [mergeCol_branchPt h j ht, if_neg (fun h1 => (not_lt.mpr hxr.le) h1.2)]
        filter_upwards [hev, isClosed_closedBall.isOpen_compl.mem_nhds (show branchPt v (X.G.β j) (X.G.κ j) t ∉
          closedBall v (ρ / 2) by rw [mem_closedBall, dist_eq_norm, norm_branchPt_sub v _ _ ht.1.le, not_le]; exact hxr)]
          with y hy hyb
        rw [mem_compl_iff, mem_closedBall, dist_eq_norm, not_le] at hyb
        rcases hy with (hy | hy) | ⟨t', ht', rfl⟩
        · rw [mergeCol_of_mem_sector h hy, if_neg (fun h1 => (not_lt.mpr hyb.le) h1.2), hpc]
        · rw [mergeCol_of_mem_sector h hy, if_neg (fun h1 => (not_lt.mpr hyb.le) h1.2)]
        · rw [norm_branchPt_sub v _ _ ht'.1.le] at hyb
          rw [mergeCol_branchPt h j ht', if_neg (fun h1 => (not_lt.mpr hyb.le) h1.2)]
    · -- on the rim: interior to `F`, in one chart sector
      have hxv : x ≠ v := fun hxv => by rw [hxv, dist_self] at heq; linarith [h.1]
      have hxF : x ∈ F.interiorPts := by
        refine ⟨hx, fun hxF => ?_⟩
        have hxr' : x ∈ ball v X.r₀ := by rw [mem_ball, heq]; exact h.lt_r₀
        obtain ⟨j, hj⟩ := X.hC.exists_branchPt_eq hxv hxr' (fun hI => hI.2 hxF)
        rw [← dist_eq_norm, heq] at hj
        exact hxT (hj ▸ branchPt_rim_mem_trimArcs h' h.1 hρρ' j)
      obtain ⟨i, hi⟩ : ∃ i, x ∈ X.G.sector v ρ' i := by
        have : x ∈ ball v ρ' ∩ F.interiorPts := ⟨by rw [mem_ball, heq]; exact hρρ', hxF⟩
        rw [X.hC.cover ρ' h'.mem_Ioc hn] at this
        exact mem_iUnion.mp this
      filter_upwards [(X.hC.isOpen ρ' h'.mem_Ioc i).mem_nhds hi, isClosed_closedBall.isOpen_compl.mem_nhds
        (show x ∉ closedBall v (ρ / 2) by rw [mem_closedBall, dist_eq_norm, not_le]; exact hxr)] with y hy hyb
      rw [mem_compl_iff, mem_closedBall, dist_eq_norm, not_le] at hyb
      rw [mergeCol_of_mem_sector_out h' h hy hyb, mergeCol_of_mem_sector_out h' h hi hxr]
    · -- off the closed ball: `F`'s colouring
      have hxc : x ∉ closedBall v ρ := by rw [mem_closedBall, not_le]; exact hgt
      have hxF : x ∉ ⋃ a ∈ F.arcs, a.carrier := fun hF => hxT (h2 ⟨hF, hxc⟩)
      filter_upwards [F.locallyConstant x hx hxF, isClosed_closedBall.isOpen_compl.mem_nhds hxc] with y hy hyc
      rw [mergeCol_of_not_mem h (fun hb => hyc (ball_subset_closedBall hb)),
        mergeCol_of_not_mem h (fun hb => hxc (ball_subset_closedBall hb)), hy]

/-- OPEN's new arcs lie in the closed ball. -/
theorem openArcs_subset_closedBall {up : Bool} {ψ ρ : ℝ} (h : X.Small ρ) :
    ∀ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.carrier ⊆ closedBall v ρ := by
  intro A hA
  rcases hA with hA | hA
  · exact mergeArcs_subset_closedBall h A hA
  rcases hA with rfl | rfl
  · exact (openRay_subset_closedBall v ψ h.1.le).trans (closedBall_subset_closedBall (by linarith [h.1]))
  · exact (X.G.openRim_subset_sphere v up s b ψ h.1.le).trans
      (sphere_subset_closedBall.trans (closedBall_subset_closedBall (by linarith [h.1])))

/-- **The configuration's clear range covers the gap**: below `ρc`, every point at a direction between the gap's end germs is clear
for `c`. -/
theorem OpenConfig.isClear_of_Icc (cfg : X.OpenConfig c up s b ψ ρc) {t φ : ℝ} (ht : t ∈ Ioo 0 ρc)
    (hφ : φ ∈ Icc (X.G.liftDir s 1 t) (X.G.liftDir s b t)) : F.IsClear c (v + (t : ℂ) * e φ) := by
  have hray := cfg.ray t ht
  refine cfg.clear t ht φ ?_ ?_
  · cases up
    · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hray ⊢; exact hray.2.le.trans hφ.1
    · simp only [if_true]; exact hφ.1
  · cases up
    · simp only [Bool.false_eq_true, if_false]; exact hφ.2
    · simp only [BranchGerms.rayPos, if_true] at hray ⊢; exact hφ.2.trans hray.1.le

/-- **The wedge is clear for `c`.** -/
theorem OpenConfig.isClear_of_mem_openWedge (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) (hρc : ρ ≤ ρc)
    {z : ℂ} (hz : z ∈ X.G.openWedge v up s b ψ ρ) : F.IsClear c z := by
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openWedge.mp hz
  have htc : t ∈ Ioo 0 ρc := ⟨ht.1, by linarith [ht.2, h.1]⟩
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
  have hmono := (X.G.liftDir_mono X.hord s hts).monotone
  refine cfg.clear t htc φ ?_ ?_
  · cases up
    · simp only [Bool.false_eq_true, if_false] at hφ ⊢; exact hφ.1.le
    · simp only [if_true] at hφ ⊢; exact (hmono cfg.hb1).trans hφ.1.le
  · cases up
    · simp only [Bool.false_eq_true, if_false] at hφ ⊢; exact hφ.2.le.trans (hmono cfg.hb1)
    · simp only [if_true] at hφ ⊢; exact hφ.2.le

/-- OPEN's colour on the wedge is `c`. -/
theorem openCol_of_mem {ρ : ℝ} {Fcol : ℂ → Fin k} {z : ℂ} (hz : z ∈ X.G.openWedge v up s b ψ ρ) :
    X.G.openCol v X.col Fcol up s b ψ c ρ z = c := by
  unfold BranchGerms.openCol; rw [if_pos hz]

/-- Off the wedge OPEN's colour is MERGE's. -/
theorem openCol_of_not_mem {ρ : ℝ} {Fcol : ℂ → Fin k} {z : ℂ} (hz : z ∉ X.G.openWedge v up s b ψ ρ) :
    X.G.openCol v X.col Fcol up s b ψ c ρ z = X.G.mergeCol v X.col Fcol s 0 b c ρ z := by
  unfold BranchGerms.openCol; rw [if_neg hz]

/-- `v` lies on the new ray. -/
theorem v_mem_openArcs {ρ : ℝ} : v ∈ ⋃ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.carrier :=
  mem_iUnion₂.mpr ⟨openRay v ψ ρ, Or.inr (Or.inl rfl), left_mem_segment ℝ _ _⟩

/-! ### OPEN's sectors at `v` (FS131-IO2) -/

/-- A sector between two germs, cut down to a smaller radius. -/
theorem _root_.HadwigerNelson.Plane.mem_sectorBetween_of_lt {z : ℂ} {β₁ κ₁ β₂ κ₂ R r : ℝ}
    (hz : z ∈ sectorBetween v β₁ κ₁ β₂ κ₂ R) (hr : ‖z - v‖ < r) : z ∈ sectorBetween v β₁ κ₁ β₂ κ₂ r := by
  obtain ⟨t, ht, φ, hφ, rfl⟩ := hz
  rw [add_sub_cancel_left, norm_mul_e ht.1.le] at hr
  exact ⟨t, ⟨ht.1, hr⟩, φ, hφ, rfl⟩

/-- **A sector between two germs whose directions stay ordered is preconnected** (as `BranchGerms.isPreconnected_sector`). -/
theorem _root_.HadwigerNelson.Plane.isPreconnected_sectorBetween (v : ℂ) {β₁ κ₁ β₂ κ₂ r : ℝ}
    (hord : ∀ t ∈ Ioo 0 r, germDir β₁ κ₁ t < germDir β₂ κ₂ t) : IsPreconnected (sectorBetween v β₁ κ₁ β₂ κ₂ r) := by
  set f : ℝ × ℝ → ℂ := fun p => v + (p.1 : ℂ) * e (germDir β₁ κ₁ p.1 + p.2 * (germDir β₂ κ₂ p.1 - germDir β₁ κ₁ p.1))
    with hf
  have hfc : Continuous f := by
    have h1 : Continuous fun p : ℝ × ℝ => germDir β₁ κ₁ p.1 + p.2 * (germDir β₂ κ₂ p.1 - germDir β₁ κ₁ p.1) :=
      ((continuous_germDir β₁ κ₁).comp continuous_fst).add (continuous_snd.mul
        (((continuous_germDir β₂ κ₂).comp continuous_fst).sub ((continuous_germDir β₁ κ₁).comp continuous_fst)))
    exact continuous_const.add ((Complex.continuous_ofReal.comp continuous_fst).mul (continuous_e.comp h1))
  have heq : sectorBetween v β₁ κ₁ β₂ κ₂ r = f '' (Ioo 0 r ×ˢ Ioo 0 1) := by
    ext z
    constructor
    · rintro ⟨s, hs, φ, hφ, rfl⟩
      have hφ : germDir β₁ κ₁ s < φ ∧ φ < germDir β₂ κ₂ s := hφ
      have hgap : 0 < germDir β₂ κ₂ s - germDir β₁ κ₁ s := by linarith [hφ.1, hφ.2]
      refine ⟨(s, (φ - germDir β₁ κ₁ s) / (germDir β₂ κ₂ s - germDir β₁ κ₁ s)), ⟨hs, ?_, ?_⟩, ?_⟩
      · exact div_pos (by linarith [hφ.1]) hgap
      · rw [div_lt_one hgap]; linarith [hφ.2]
      · simp only [hf]; congr 3; field_simp; ring
    · rintro ⟨⟨s, t⟩, ⟨hs, ht⟩, rfl⟩
      have hgap := hord s hs
      refine ⟨s, hs, _, ⟨?_, ?_⟩, rfl⟩
      · show germDir β₁ κ₁ s < germDir β₁ κ₁ s + t * (germDir β₂ κ₂ s - germDir β₁ κ₁ s)
        nlinarith [ht.1]
      · show germDir β₁ κ₁ s + t * (germDir β₂ κ₂ s - germDir β₁ κ₁ s) < germDir β₂ κ₂ s
        nlinarith [ht.2]
  rw [heq]
  exact ((convex_Ioo 0 r).prod (convex_Ioo 0 1)).isPreconnected.image f hfc.continuousOn

/-- **Every direction strictly between two germs' tangents is a direction of the sector between them** at `v`. -/
theorem _root_.HadwigerNelson.Plane.Ioo_subset_coneAt_sectorBetween (v : ℂ) {β₁ κ₁ β₂ κ₂ r : ℝ} (hr : 0 < r) :
    Ioo β₁ β₂ ⊆ coneAt (sectorBetween v β₁ κ₁ β₂ κ₂ r) v := by
  intro δ hδ
  have h1 : ∀ᶠ t in 𝓝 (0 : ℝ), germDir β₁ κ₁ t < δ :=
    (continuous_germDir β₁ κ₁).continuousAt.eventually_lt continuousAt_const (by rw [germDir_zero]; exact hδ.1)
  have h2 : ∀ᶠ t in 𝓝 (0 : ℝ), δ < germDir β₂ κ₂ t :=
    continuousAt_const.eventually_lt (continuous_germDir β₂ κ₂).continuousAt (by rw [germDir_zero]; exact hδ.2)
  obtain ⟨η, hη, hball⟩ := Metric.eventually_nhds_iff.mp (h1.and h2)
  refine BranchGerms.mem_coneAt_of_ray fun ε hε => ?_
  set t := min (min ε r) η / 2 with ht
  have ht0 : 0 < t := by positivity
  have htε : t < ε := by have := min_le_left (min ε r) η; have := min_le_left ε r; linarith
  have htr : t < r := by have := min_le_left (min ε r) η; have := min_le_right ε r; linarith
  have htη : dist t 0 < η := by
    rw [Real.dist_eq, sub_zero, abs_of_pos ht0]; have := min_le_right (min ε r) η; linarith
  obtain ⟨ha, hb⟩ := hball htη
  exact ⟨t, ⟨ht0, htε⟩, t, ⟨ht0, htr⟩, δ, ⟨ha, hb⟩, rfl⟩

/-- A point of the new ray is `v + t e(ψ)` with `t ∈ [0, ρ/2]`. -/
theorem eq_of_mem_openRay {ψ ρ : ℝ} (hρ : 0 < ρ) {z : ℂ} (hz : z ∈ (openRay v ψ ρ).carrier) :
    ∃ t ∈ Icc 0 (ρ / 2), z = v + (t : ℂ) * e ψ := by
  obtain ⟨a, b', ha, hb, hab, rfl⟩ := hz
  obtain rfl : a = 1 - b' := by linarith
  refine ⟨b' * (ρ / 2), ⟨by positivity, by nlinarith⟩, ?_⟩
  simp only [Complex.real_smul]
  push_cast; ring

/-- **The window**: below the clear radius the ray lies between the gap's outer germs `idx s 0` and `idx s (b + 1)`, which are at
most a turn apart. -/
theorem OpenConfig.window (cfg : X.OpenConfig c up s b ψ ρc) {t : ℝ} (ht : t ∈ Ioo 0 ρc) :
    X.G.liftDir s 0 t < ψ ∧ ψ < X.G.liftDir s (b + 1) t ∧ X.G.liftDir s (b + 1) t ≤ X.G.liftDir s 0 t + 2 * π := by
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, ht.2.trans_le cfg.hρcs⟩
  have hmono := (X.G.liftDir_mono X.hord s hts).monotone
  have hray := cfg.ray t ht
  have h2 : X.G.liftDir s (b + 1) t ≤ X.G.liftDir s 0 t + 2 * π := by
    have := X.G.liftDir_add_n s 0 t
    rw [zero_add] at this
    rw [← this]; exact hmono (by have := cfg.hbn; omega)
  cases up
  · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hray
    exact ⟨hray.1, hray.2.trans_le (hmono (by omega)), h2⟩
  · simp only [BranchGerms.rayPos, if_true] at hray
    exact ⟨(hmono (Nat.zero_le b)).trans_lt hray.1, hray.2, h2⟩

/-- The merged piece's directions lie in the window, on the horn's side of the ray. -/
theorem OpenConfig.mem_openPiece_iff (cfg : X.OpenConfig c up s b ψ ρc) {r : ℝ} (hr : r ≤ ρc) {z : ℂ}
    (hz : z ∈ X.G.openPiece v up s b ψ r) :
    ∃ t ∈ Ioo 0 r, ∃ φ, X.G.liftDir s 0 t < φ ∧ φ < X.G.liftDir s (b + 1) t ∧ φ ≠ ψ ∧ z = v + (t : ℂ) * e φ := by
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openPiece.mp hz
  have hw := cfg.window ⟨ht.1, ht.2.trans_le hr⟩
  refine ⟨t, ht, φ, ?_, ?_, ?_, rfl⟩ <;> cases up <;> simp only [Bool.false_eq_true, if_false, if_true] at hφ
  all_goals linarith [hφ.1, hφ.2, hw.1, hw.2.1]

/-- The rest of the partial sector's directions lie in the window, beyond the ray. -/
theorem OpenConfig.mem_openRest_iff (cfg : X.OpenConfig c up s b ψ ρc) {r : ℝ} (hr : r ≤ ρc) {z : ℂ}
    (hz : z ∈ X.G.openRest v up s b ψ r) :
    ∃ t ∈ Ioo 0 r, ∃ φ, X.G.liftDir s 0 t < φ ∧ φ < X.G.liftDir s (b + 1) t ∧ φ ≠ ψ ∧ z = v + (t : ℂ) * e φ := by
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openRest.mp hz
  have hw := cfg.window ⟨ht.1, ht.2.trans_le hr⟩
  refine ⟨t, ht, φ, ?_, ?_, ?_, rfl⟩ <;> cases up <;> simp only [Bool.false_eq_true, if_false, if_true] at hφ
  all_goals linarith [hφ.1, hφ.2, hw.1, hw.2.1]

/-- **An index off the gap, the horn and the partial sector** is `idx s m` with `b < m < n`. -/
theorem OpenConfig.exists_other (cfg : X.OpenConfig c up s b ψ ρc) {i : Fin X.n}
    (h1 : i ≠ BranchGerms.idx s (BranchGerms.hornPos up b)) (h2 : i ≠ BranchGerms.idx s (BranchGerms.rayPos up b))
    (h3 : i ∉ BranchGerms.gapSec s 0 b) : ∃ m, b < m ∧ m < X.n ∧ BranchGerms.idx s m = i := by
  have hbn := cfg.hbn
  obtain ⟨m, hm0, hmn, rfl⟩ := BranchGerms.exists_rep s (a := 0) (by omega) i
  refine ⟨m, ?_, by omega, rfl⟩
  by_contra hmb
  push Not at hmb
  rcases Nat.eq_zero_or_pos m with rfl | hm
  · cases up
    · exact h2 rfl
    · exact h1 rfl
  rcases eq_or_lt_of_le hmb with rfl | hlt
  · cases up
    · exact h1 rfl
    · exact h2 rfl
  · exact h3 ⟨m, hm, hlt, rfl⟩

/-- **A germ off the gap** is `idx s m` with `b < m ≤ n`. -/
theorem OpenConfig.exists_germ_off (cfg : X.OpenConfig c up s b ψ ρc) {j : Fin X.n} (hj : j ∉ BranchGerms.gapGerm s 0 b) :
    ∃ m, b < m ∧ m ≤ X.n ∧ BranchGerms.idx s m = j := by
  have hn2 := cfg.two_le
  obtain ⟨m, hm1, hmn, rfl⟩ := BranchGerms.exists_rep s (a := 1) (by omega) j
  refine ⟨m, ?_, by omega, rfl⟩
  by_contra hmb
  exact hj ⟨m, by omega, by omega, rfl⟩

/-- **A point at a direction in the window, off the ray, inside `ρ/2`, is on no new arc.** -/
theorem OpenConfig.not_mem_openArcs (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) (hρc : ρ ≤ ρc) {t φ : ℝ}
    (ht : t ∈ Ioo 0 (ρ / 2)) (hφ1 : X.G.liftDir s 0 t < φ) (hφ2 : φ < X.G.liftDir s (b + 1) t) (hφψ : φ ≠ ψ) :
    v + (t : ℂ) * e φ ∉ ⋃ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.carrier := by
  have hπ := Real.pi_pos
  have htc : t ∈ Ioo 0 ρc := ⟨ht.1, by linarith [ht.2, h.1]⟩
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, by linarith [ht.2, h.1, h.2.1]⟩
  have hw := cfg.window htc
  have hmono := (X.G.liftDir_mono X.hord s hts).monotone
  have hnorm : ‖v + (t : ℂ) * e φ - v‖ = t := by rw [add_sub_cancel_left, norm_mul_e ht.1.le]
  intro hz
  obtain ⟨A, hA, hzA⟩ := mem_iUnion₂.mp hz
  rcases hA with hA | rfl | rfl
  · rcases mem_mergeArcs.mp hA with ⟨j, hj, rfl⟩ | ⟨j, -, hA'⟩ | ⟨-, rfl⟩
    · rw [carrier_germ h.half] at hzA
      obtain ⟨t', ht', he⟩ := hzA
      have htt : t' = t := by
        have := congrArg (fun z => ‖z - v‖) he
        simp only [norm_branchPt_sub v _ _ ht'.1, hnorm] at this; exact this
      rw [htt] at he
      obtain ⟨m, hm1, hm2, rfl⟩ := cfg.exists_germ_off hj
      rw [X.G.branchPt_idx] at he
      have h1 : X.G.liftDir s (b + 1) t ≤ X.G.liftDir s m t := hmono (by omega)
      have h2 : X.G.liftDir s m t ≤ X.G.liftDir s 0 t + 2 * π := by
        have := X.G.liftDir_add_n s 0 t; rw [zero_add] at this; rw [← this]; exact hmono hm2
      obtain ⟨-, he'⟩ := polar_eq_of_abs_lt ht.1 ht.1 he fun _ => by rw [abs_lt]; constructor <;> linarith
      linarith
    · obtain ⟨t', ht', he⟩ := outer_subset h j A hA' hzA
      have := congrArg (fun z => ‖z - v‖) he
      rw [norm_branchPt_sub v _ _ (by linarith [ht'.1, h.1]), hnorm] at this
      linarith [ht'.1, ht.2]
    · rw [norm_of_mem_rimArc h hzA] at hnorm; linarith [ht.2]
  · obtain ⟨t', ht', he⟩ := eq_of_mem_openRay h.1 hzA
    have ht'0 : 0 < t' := by
      rcases eq_or_lt_of_le ht'.1 with h0 | h0
      · exfalso
        rw [← h0, Complex.ofReal_zero, zero_mul, add_zero] at he
        have := congrArg (fun z => ‖z - v‖) he
        simp only [hnorm, sub_self, norm_zero] at this; linarith [ht.1]
      · exact h0
    obtain ⟨-, he'⟩ := polar_eq_of_abs_lt ht.1 ht'0 he fun _ => by
      rw [abs_lt]; constructor <;> linarith [hw.1, hw.2.1, hw.2.2]
    exact hφψ he'
  · have := X.G.openRim_subset_sphere v up s b ψ h.1.le hzA
    rw [mem_sphere, dist_eq_norm, hnorm] at this; linarith [ht.2]

/-- **A chart sector is a horn set exactly when its two germs share a direction.** -/
theorem sector_eq_hornSet_iff {r : ℝ} (hr : r ∈ Ioc 0 X.r₀) (i : Fin X.n) :
    (∃ α κ₁ κ₂, κ₁ < κ₂ ∧ X.G.sector v r i = hornSet v α κ₁ κ₂ r) ↔ X.G.β i = X.G.nextβ i := by
  constructor
  · rintro ⟨α, κ₁, κ₂, -, hS⟩
    rcases X.hC.sorted.2 i with hlt | ⟨heq, -⟩
    · refine absurd hS (ne_hornSet_of_interior_coneAt ?_ α κ₁ κ₂ r)
      rw [X.hC.cone r hr i]
      exact ⟨(X.G.β i + X.G.nextβ i) / 2, mem_interior.mpr ⟨Ioo (X.G.β i) (X.G.nextβ i),
        Ioo_subset_Icc_self.trans (Icc_subset_angleIcc _ _), isOpen_Ioo, ⟨by linarith, by linarith⟩⟩⟩
    · exact heq
  · intro heq
    rcases X.hC.sorted.2 i with hlt | ⟨-, hκ⟩
    · rw [heq] at hlt; exact absurd hlt (lt_irrefl _)
    · refine ⟨X.G.β i, X.G.κ i, X.G.nextκ i, hκ, ?_⟩
      have h1 : |X.G.κ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (X.hC.curv i).le
      have h2 : |X.G.nextκ i| * r ≤ 2 := (mul_le_mul_of_nonneg_left hr.2 (abs_nonneg _)).trans (X.hC.curv_next i).le
      show sectorBetween v (X.G.β i) (X.G.κ i) (X.G.nextβ i) (X.G.nextκ i) r = _
      rw [← heq]
      exact sectorBetween_eq_hornSet v _ _ _ r h1 h2

/-- **The horn count at a chart's point** (with at least one germ) is its number of cusps. -/
theorem hasHornCount_chart (hn : 0 < X.n) : F.HasHornCount v {i : Fin X.n | X.G.β i = X.G.nextβ i}.ncard := by
  filter_upwards [Ioc_mem_nhdsGT X.hC.pos] with r hr
  have heq : {S | F.IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r} =
      (fun i => X.G.sector v r i) '' {i | X.G.β i = X.G.nextβ i} := by
    ext S
    constructor
    · rintro ⟨hS, α, κ₁, κ₂, hκ, rfl⟩
      obtain ⟨i, hi⟩ := (X.hC.isSector_iff hn hr).mp hS
      exact ⟨i, (sector_eq_hornSet_iff hr i).mp ⟨α, κ₁, κ₂, hκ, hi.symm⟩, hi.symm⟩
    · rintro ⟨i, hi, rfl⟩
      exact ⟨(X.hC.isSector_iff hn hr).mpr ⟨i, rfl⟩, (sector_eq_hornSet_iff hr i).mpr hi⟩
  rw [heq, (injective_of_disjoint (X.hC.disjoint r hr) (X.hC.sector_nonempty hr)).encard_image,
    (Set.toFinite _).cast_ncard_eq]

/-- **Sectors from a partition with empty pieces allowed**: the sectors are the non-empty pieces. -/
theorem _root_.HadwigerNelson.Plane.ArcMap.isSector_iff_of_partition' {G : ArcMap k} {ι : Type*} {A : ι → Set ℂ} {x : ℂ}
    {r : ℝ} (hU : G.interiorPts ∩ ball x r = ⋃ i, A i) (hopen : ∀ i, IsOpen (A i)) (hpre : ∀ i, IsPreconnected (A i))
    (hdisj : ∀ i j, i ≠ j → Disjoint (A i) (A j)) (hcl : ∀ i, (A i).Nonempty → x ∈ closure (A i)) {S : Set ℂ} :
    G.IsSector x r S ↔ ∃ i, (A i).Nonempty ∧ S = A i := by
  have hcomp : ∀ i, ∀ y ∈ A i, connectedComponentIn (G.interiorPts ∩ ball x r) y = A i :=
    fun i y hy => connectedComponentIn_eq_of_iUnion hU hopen hpre hdisj hy
  constructor
  · rintro ⟨y, hy, rfl, -⟩
    rw [hU] at hy
    obtain ⟨i, hi⟩ := mem_iUnion.mp hy
    exact ⟨i, ⟨y, hi⟩, hcomp i y hi⟩
  · rintro ⟨i, ⟨y, hy⟩, rfl⟩
    refine ⟨y, ?_, (hcomp i y hy).symm, hcl i ⟨y, hy⟩⟩
    rw [hU]; exact mem_iUnion.mpr ⟨i, hy⟩

/-- Pairwise disjoint sets are injective on the non-empty ones. -/
theorem _root_.HadwigerNelson.Plane.ArcMap.injOn_of_disjoint {ι : Type*} {A : ι → Set ℂ}
    (hdisj : ∀ i j, i ≠ j → Disjoint (A i) (A j)) : Set.InjOn A {i | (A i).Nonempty} := by
  intro i hi j _ hij
  by_contra h
  obtain ⟨x, hx⟩ := hi
  exact disjoint_left.mp (hdisj i j h) hx (hij ▸ hx)

/-- **OPEN's sectors at `v`** out to `r`, indexed by the chart's: the merged piece at the horn's index, the rest of the partial sector
at its index, nothing at the swallowed sectors', the chart's sector elsewhere. -/
noncomputable def openSectors (X : F.Near v) (up : Bool) (s : Fin X.n) (b : ℕ) (ψ r : ℝ) (i : Fin X.n) : Set ℂ := by
  classical
  exact if i = BranchGerms.idx s (BranchGerms.hornPos up b) then X.G.openPiece v up s b ψ r
    else if i = BranchGerms.idx s (BranchGerms.rayPos up b) then X.G.openRest v up s b ψ r
    else if i ∈ BranchGerms.gapSec s 0 b then ∅ else X.G.sector v r i

theorem openSectors_cases (up : Bool) (ψ r : ℝ) (i : Fin X.n) :
    (i = BranchGerms.idx s (BranchGerms.hornPos up b) ∧ openSectors X up s b ψ r i = X.G.openPiece v up s b ψ r) ∨
    (i ≠ BranchGerms.idx s (BranchGerms.hornPos up b) ∧ i = BranchGerms.idx s (BranchGerms.rayPos up b) ∧
      openSectors X up s b ψ r i = X.G.openRest v up s b ψ r) ∨
    (i ≠ BranchGerms.idx s (BranchGerms.hornPos up b) ∧ i ≠ BranchGerms.idx s (BranchGerms.rayPos up b) ∧
      i ∈ BranchGerms.gapSec s 0 b ∧ openSectors X up s b ψ r i = ∅) ∨
    (i ≠ BranchGerms.idx s (BranchGerms.hornPos up b) ∧ i ≠ BranchGerms.idx s (BranchGerms.rayPos up b) ∧
      i ∉ BranchGerms.gapSec s 0 b ∧ openSectors X up s b ψ r i = X.G.sector v r i) := by
  classical
  unfold openSectors
  by_cases h1 : i = BranchGerms.idx s (BranchGerms.hornPos up b)
  · left; exact ⟨h1, by rw [if_pos h1]⟩
  by_cases h2 : i = BranchGerms.idx s (BranchGerms.rayPos up b)
  · right; left; exact ⟨h1, h2, by rw [if_neg h1, if_pos h2]⟩
  by_cases h3 : i ∈ BranchGerms.gapSec s 0 b
  · right; right; left; exact ⟨h1, h2, h3, by rw [if_neg h1, if_neg h2, if_pos h3]⟩
  · right; right; right; exact ⟨h1, h2, h3, by rw [if_neg h1, if_neg h2, if_neg h3]⟩

-- spec example: at the horn's index OPEN's sector is the merged piece
example (up : Bool) (ψ r : ℝ) :
    openSectors X up s b ψ r (BranchGerms.idx s (BranchGerms.hornPos up b)) = X.G.openPiece v up s b ψ r := by
  rcases openSectors_cases (X := X) (s := s) (b := b) up ψ r (BranchGerms.idx s (BranchGerms.hornPos up b)) with
    ⟨-, h⟩ | ⟨h, -⟩ | ⟨h, -⟩ | ⟨h, -⟩
  · exact h
  all_goals exact absurd rfl h

/-- The horn's and the partial sector's indices are distinct and off the swallowed sectors. -/
theorem OpenConfig.idx_facts (cfg : X.OpenConfig c up s b ψ ρc) :
    BranchGerms.idx s (BranchGerms.hornPos up b) ≠ BranchGerms.idx s (BranchGerms.rayPos up b) ∧
      BranchGerms.idx s (BranchGerms.hornPos up b) ∉ BranchGerms.gapSec s 0 b ∧
      BranchGerms.idx s (BranchGerms.rayPos up b) ∉ BranchGerms.gapSec s 0 b := by
  have hb1 := cfg.hb1; have hbn := cfg.hbn
  have h0 : BranchGerms.idx s 0 ∉ BranchGerms.gapSec s 0 b := by
    rw [BranchGerms.idx_mem_gapSec_iff (by omega) le_rfl (by omega)]; omega
  have hb : BranchGerms.idx s b ∉ BranchGerms.gapSec s 0 b := by
    rw [BranchGerms.idx_mem_gapSec_iff (by omega) (Nat.zero_le b) (by omega)]; omega
  have hne : BranchGerms.idx s 0 ≠ BranchGerms.idx s b := BranchGerms.idx_ne (by omega) (by omega)
  cases up
  · exact ⟨hne.symm, hb, h0⟩
  · exact ⟨hne, h0, hb⟩

/-- **The merged piece and the rest of the partial sector approach `v` along an open interval of directions** (`ray0`). -/
theorem OpenConfig.cone_piece_rest (cfg : X.OpenConfig c up s b ψ ρc) {r : ℝ} (hr : 0 < r) :
    (∃ lo hi, lo < hi ∧ Ioo lo hi ⊆ coneAt (X.G.openPiece v up s b ψ r) v) ∧
      ∃ lo hi, lo < hi ∧ Ioo lo hi ⊆ coneAt (X.G.openRest v up s b ψ r) v := by
  have hmono := X.G.lift_mono X.hC.sorted.mono s
  have h0 := cfg.ray0
  cases up
  · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at h0
    refine ⟨⟨ψ, X.G.lift s (b + 1), h0.2.trans_le (hmono (by omega)), ?_⟩, ⟨X.G.lift s 0, ψ, h0.1, ?_⟩⟩
    · unfold BranchGerms.openPiece; simp only [Bool.false_eq_true, if_false]
      exact Ioo_subset_coneAt_sectorBetween v hr
    · unfold BranchGerms.openRest; simp only [Bool.false_eq_true, if_false]
      exact Ioo_subset_coneAt_sectorBetween v hr
  · simp only [BranchGerms.rayPos, if_true] at h0
    refine ⟨⟨X.G.lift s 0, ψ, (hmono (Nat.zero_le b)).trans_lt h0.1, ?_⟩, ⟨ψ, X.G.lift s (b + 1), h0.2, ?_⟩⟩
    · unfold BranchGerms.openPiece; simp only [if_true]
      exact Ioo_subset_coneAt_sectorBetween v hr
    · unfold BranchGerms.openRest; simp only [if_true]
      exact Ioo_subset_coneAt_sectorBetween v hr

/-- A set approaching `v` along an open interval of directions has `v` in its closure, is non-empty, and is no horn set. -/
theorem facts_of_cone {S : Set ℂ} {lo hi : ℝ} (hlh : lo < hi) (hS : Ioo lo hi ⊆ coneAt S v) :
    v ∈ closure S ∧ S.Nonempty ∧ ∀ α κ₁ κ₂ r, S ≠ hornSet v α κ₁ κ₂ r := by
  have hm : (lo + hi) / 2 ∈ coneAt S v := hS ⟨by linarith, by linarith⟩
  have hcl := mem_closure_of_mem_coneAt hm
  refine ⟨hcl, ?_, fun α κ₁ κ₂ r => ne_hornSet_of_interior_coneAt ?_ α κ₁ κ₂ r⟩
  · by_contra hne
    rw [Set.not_nonempty_iff_eq_empty] at hne
    rw [hne, closure_empty] at hcl; exact hcl
  · exact ⟨(lo + hi) / 2, mem_interior.mpr ⟨Ioo lo hi, hS, isOpen_Ioo, ⟨by linarith, by linarith⟩⟩⟩

/-- The merged piece and the rest of the partial sector are preconnected. -/
theorem OpenConfig.isPreconnected_piece_rest (cfg : X.OpenConfig c up s b ψ ρc) {r : ℝ} (hr : r ≤ ρc) :
    IsPreconnected (X.G.openPiece v up s b ψ r) ∧ IsPreconnected (X.G.openRest v up s b ψ r) := by
  have hw : ∀ t ∈ Ioo 0 r, X.G.liftDir s 0 t < ψ ∧ ψ < X.G.liftDir s (b + 1) t := fun t ht =>
    ⟨(cfg.window ⟨ht.1, ht.2.trans_le hr⟩).1, (cfg.window ⟨ht.1, ht.2.trans_le hr⟩).2.1⟩
  have hz : ∀ t : ℝ, germDir ψ 0 t = ψ := fun t => by simp [germDir]
  cases up
  · unfold BranchGerms.openPiece BranchGerms.openRest; simp only [Bool.false_eq_true, if_false]
    exact ⟨isPreconnected_sectorBetween v fun t ht => by rw [hz]; exact (hw t ht).2,
      isPreconnected_sectorBetween v fun t ht => by rw [hz]; exact (hw t ht).1⟩
  · unfold BranchGerms.openPiece BranchGerms.openRest; simp only [if_true]
    exact ⟨isPreconnected_sectorBetween v fun t ht => by rw [hz]; exact (hw t ht).1,
      isPreconnected_sectorBetween v fun t ht => by rw [hz]; exact (hw t ht).2⟩

/-- **The merged piece misses the rest of the partial sector** (the two lie on the two sides of the ray, in the window). -/
theorem OpenConfig.disjoint_piece_rest (cfg : X.OpenConfig c up s b ψ ρc) {r : ℝ} (hr : r ≤ ρc) :
    Disjoint (X.G.openPiece v up s b ψ r) (X.G.openRest v up s b ψ r) := by
  rw [Set.disjoint_left]
  intro z hz hz'
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openPiece.mp hz
  obtain ⟨t', ht', φ', hφ', he⟩ := X.G.mem_openRest.mp hz'
  obtain ⟨rfl, rfl⟩ := polar_eq_of_abs_lt ht.1 ht'.1 he fun htt => by
    subst htt
    have hw := cfg.window ⟨ht.1, ht.2.trans_le hr⟩
    cases up <;> simp only [Bool.false_eq_true, if_false, if_true] at hφ hφ' <;>
      · rw [abs_lt]; constructor <;> linarith [hφ.1, hφ.2, hφ'.1, hφ'.2, hw.1, hw.2.1, hw.2.2]
  cases up <;> simp only [Bool.false_eq_true, if_false, if_true] at hφ hφ' <;> linarith [hφ.1, hφ.2, hφ'.1, hφ'.2]

/-- **The merged piece misses every chart sector off the gap, the horn and the partial sector** (their directions lie beyond the
window). -/
theorem OpenConfig.disjoint_piece_other (cfg : X.OpenConfig c up s b ψ ρc) {r : ℝ} (hr : r ≤ ρc) {m : ℕ} (hm1 : b < m)
    (hm2 : m < X.n) : Disjoint (X.G.openPiece v up s b ψ r) (X.G.sector v r (BranchGerms.idx s m)) := by
  rw [Set.disjoint_left]
  intro z hz hz'
  obtain ⟨t, ht, φ, h1, h2, -, rfl⟩ := cfg.mem_openPiece_iff hr hz
  obtain ⟨t', ht', φ', hφ', he⟩ := (X.G.mem_sector_idx s m).mp hz'
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, ht.2.trans_le (hr.trans cfg.hρcs)⟩
  have hmono := (X.G.liftDir_mono X.hord s hts).monotone
  have hπ := Real.pi_pos
  obtain ⟨rfl, rfl⟩ := polar_eq_of_abs_lt ht.1 ht'.1 he fun htt => by
    subst htt
    have h3 : X.G.liftDir s (b + 1) t ≤ X.G.liftDir s m t := hmono (by omega)
    have h4 : X.G.liftDir s (m + 1) t ≤ X.G.liftDir s 0 t + 2 * π := by
      have := X.G.liftDir_add_n s 0 t; rw [zero_add] at this; rw [← this]; exact hmono (by omega)
    rw [abs_lt]; constructor <;> linarith [hφ'.1, hφ'.2]
  have h3 : X.G.liftDir s (b + 1) t ≤ X.G.liftDir s m t := hmono (by omega)
  linarith [hφ'.1]

/-- A horn sector point inside `r` is in the merged piece. -/
theorem OpenConfig.horn_subset_piece (cfg : X.OpenConfig c up s b ψ ρc) {r : ℝ} (hr : r ≤ ρc) :
    X.G.sector v r (BranchGerms.idx s (BranchGerms.hornPos up b)) ⊆ X.G.openPiece v up s b ψ r := by
  intro z hz
  obtain ⟨t, ht, φ, hφ, rfl⟩ := (X.G.mem_sector_idx s _).mp hz
  have htc : t ∈ Ioo 0 ρc := ⟨ht.1, ht.2.trans_le hr⟩
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, htc.2.trans_le cfg.hρcs⟩
  have hmono := (X.G.liftDir_mono X.hord s hts).monotone
  have hray := cfg.ray t htc
  refine X.G.mem_openPiece.mpr ⟨t, ht, φ, ?_, rfl⟩
  cases up
  · simp only [BranchGerms.hornPos, BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hφ hray ⊢
    exact ⟨hray.2.trans_le ((hmono cfg.hb1).trans hφ.1.le), hφ.2⟩
  · simp only [BranchGerms.hornPos, BranchGerms.rayPos, if_true, zero_add] at hφ hray ⊢
    exact ⟨hφ.1, hφ.2.trans_le ((hmono cfg.hb1).trans hray.1.le)⟩

/-- A point at a direction between the gap's end germs, inside `r ≤ ρc`, lies in the merged piece. -/
theorem OpenConfig.mem_piece_of_Icc (cfg : X.OpenConfig c up s b ψ ρc) {r t φ : ℝ} (hr : r ≤ ρc) (ht : t ∈ Ioo 0 r)
    (hφ : φ ∈ Icc (X.G.liftDir s 1 t) (X.G.liftDir s b t)) : v + (t : ℂ) * e φ ∈ X.G.openPiece v up s b ψ r := by
  have htc : t ∈ Ioo 0 ρc := ⟨ht.1, ht.2.trans_le hr⟩
  have hts : t ∈ Ioo 0 X.s₀ := ⟨ht.1, htc.2.trans_le cfg.hρcs⟩
  have hmono := X.G.liftDir_mono X.hord s hts
  have hray := cfg.ray t htc
  refine X.G.mem_openPiece.mpr ⟨t, ht, φ, ?_, rfl⟩
  cases up
  · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hray ⊢
    exact ⟨hray.2.trans_le hφ.1, hφ.2.trans_lt (hmono (Nat.lt_succ_self b))⟩
  · simp only [BranchGerms.rayPos, if_true] at hray ⊢
    exact ⟨(hmono Nat.zero_lt_one).trans_le hφ.1, hφ.2.trans_lt hray.1⟩

/-- The merged piece and the rest, cut down to a smaller radius. -/
theorem _root_.HadwigerNelson.Plane.BranchGerms.mem_openPiece_of_lt {n : ℕ} (G : BranchGerms n) {v z : ℂ} {up : Bool}
    {s : Fin n} {b : ℕ} {ψ R r : ℝ} (hz : z ∈ G.openPiece v up s b ψ R) (hr : ‖z - v‖ < r) : z ∈ G.openPiece v up s b ψ r := by
  unfold BranchGerms.openPiece at hz ⊢; split_ifs at hz ⊢ <;> exact mem_sectorBetween_of_lt hz hr

theorem _root_.HadwigerNelson.Plane.BranchGerms.mem_openRest_of_lt {n : ℕ} (G : BranchGerms n) {v z : ℂ} {up : Bool}
    {s : Fin n} {b : ℕ} {ψ R r : ℝ} (hz : z ∈ G.openRest v up s b ψ R) (hr : ‖z - v‖ < r) : z ∈ G.openRest v up s b ψ r := by
  unfold BranchGerms.openRest at hz ⊢; split_ifs at hz ⊢ <;> exact mem_sectorBetween_of_lt hz hr

/-- The rest of the partial sector lies in the partial sector. -/
theorem OpenConfig.rest_subset_sector (cfg : X.OpenConfig c up s b ψ ρc) {r : ℝ} (hr : r ≤ ρc) :
    X.G.openRest v up s b ψ r ⊆ X.G.sector v r (BranchGerms.idx s (BranchGerms.rayPos up b)) := by
  intro z hz
  obtain ⟨t, ht, φ, hφ, rfl⟩ := X.G.mem_openRest.mp hz
  have hray := cfg.ray t ⟨ht.1, ht.2.trans_le hr⟩
  refine (X.G.mem_sector_idx s _).mpr ⟨t, ht, φ, ?_, rfl⟩
  cases up
  · simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hφ hray ⊢
    exact ⟨hφ.1, hφ.2.trans hray.2⟩
  · simp only [BranchGerms.rayPos, if_true] at hφ hray ⊢
    exact ⟨hray.1.trans hφ.1, hφ.2⟩

/-- **OPEN's sectors are pairwise disjoint.** -/
theorem OpenConfig.disjoint_openSectors (cfg : X.OpenConfig c up s b ψ ρc) {r : ℝ} (hr0 : 0 < r) (hr : r ≤ ρc) {i i' : Fin X.n}
    (hii' : i ≠ i') : Disjoint (openSectors X up s b ψ r i) (openSectors X up s b ψ r i') := by
  have hr₀ : r ∈ Ioc 0 X.r₀ := ⟨hr0, hr.trans (cfg.hρcs.trans X.hs₀.2)⟩
  -- the piece against any other index
  have hpiece : ∀ i', i' ≠ BranchGerms.idx s (BranchGerms.hornPos up b) →
      Disjoint (X.G.openPiece v up s b ψ r) (openSectors X up s b ψ r i') := by
    intro i' hne
    rcases openSectors_cases (X := X) (s := s) (b := b) up ψ r i' with ⟨h1, -⟩ | ⟨-, -, h2⟩ | ⟨-, -, -, h2⟩ |
      ⟨h1, h2, h3, h4⟩
    · exact absurd h1 hne
    · rw [h2]; exact cfg.disjoint_piece_rest hr
    · rw [h2]; exact disjoint_empty _
    · obtain ⟨m, hm1, hm2, rfl⟩ := cfg.exists_other h1 h2 h3
      rw [h4]; exact cfg.disjoint_piece_other hr hm1 hm2
  -- the rest against any index other than the horn's and its own
  have hrest : ∀ i', i' ≠ BranchGerms.idx s (BranchGerms.hornPos up b) → i' ≠ BranchGerms.idx s (BranchGerms.rayPos up b) →
      Disjoint (X.G.openRest v up s b ψ r) (openSectors X up s b ψ r i') := by
    intro i' hne1 hne2
    rcases openSectors_cases (X := X) (s := s) (b := b) up ψ r i' with ⟨h1, -⟩ | ⟨-, h1, -⟩ | ⟨-, -, -, h2⟩ |
      ⟨h1, h2, h3, h4⟩
    · exact absurd h1 hne1
    · exact absurd h1 hne2
    · rw [h2]; exact disjoint_empty _
    · rw [h4]
      exact (X.hC.disjoint r hr₀ _ _ (Ne.symm h2)).mono_left (cfg.rest_subset_sector hr)
  rcases openSectors_cases (X := X) (s := s) (b := b) up ψ r i with ⟨h1, h2⟩ | ⟨h1, h1', h2⟩ | ⟨-, -, -, h2⟩ |
    ⟨h1, h2, h3, h4⟩
  · rw [h2]; exact hpiece i' (h1 ▸ Ne.symm hii')
  · rw [h2]
    by_cases hi'p : i' = BranchGerms.idx s (BranchGerms.hornPos up b)
    · have := (hpiece i (by rw [h1']; exact (cfg.idx_facts).1.symm))
      rcases openSectors_cases (X := X) (s := s) (b := b) up ψ r i' with ⟨-, h3⟩ | ⟨h3, -⟩ | ⟨h3, -⟩ | ⟨h3, -⟩
      · rw [h3]; rw [h2] at this; exact this.symm
      all_goals exact absurd hi'p h3
    · exact hrest i' hi'p (h1' ▸ Ne.symm hii')
  · rw [h2]; exact empty_disjoint _
  · rw [h4]
    rcases openSectors_cases (X := X) (s := s) (b := b) up ψ r i' with ⟨-, h5⟩ | ⟨-, -, h5⟩ | ⟨-, -, -, h5⟩ |
      ⟨-, -, -, h5⟩
    · have := hpiece i h1; rw [h4] at this; rw [h5]; exact this.symm
    · have := hrest i h1 h2; rw [h4] at this; rw [h5]; exact this.symm
    · rw [h5]; exact disjoint_empty _
    · rw [h5]; exact X.hC.disjoint r hr₀ i i' hii'

/-- **OPEN's sectors at a radius inside the clear radius**: open, preconnected, with `v` in the closure of each non-empty one;
non-empty exactly off the swallowed sectors; horn sets exactly at the cusps off the gap, the horn and the partial sector. -/
theorem OpenConfig.openSectors_facts (cfg : X.OpenConfig c up s b ψ ρc) {r : ℝ} (hr0 : 0 < r) (hr : r ≤ ρc) :
    (∀ i, IsOpen (openSectors X up s b ψ r i)) ∧ (∀ i, IsPreconnected (openSectors X up s b ψ r i)) ∧
      (∀ i, (openSectors X up s b ψ r i).Nonempty → v ∈ closure (openSectors X up s b ψ r i)) ∧
      (∀ i, (openSectors X up s b ψ r i).Nonempty ↔ i ∉ BranchGerms.gapSec s 0 b) ∧
      ∀ i, ((openSectors X up s b ψ r i).Nonempty ∧
          ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ openSectors X up s b ψ r i = hornSet v α κ₁ κ₂ r) ↔
        (X.G.β i = X.G.nextβ i ∧ i ≠ BranchGerms.idx s (BranchGerms.hornPos up b) ∧
          i ≠ BranchGerms.idx s (BranchGerms.rayPos up b) ∧ i ∉ BranchGerms.gapSec s 0 b) := by
  have hr₀ : r ∈ Ioc 0 X.r₀ := ⟨hr0, hr.trans (cfg.hρcs.trans X.hs₀.2)⟩
  obtain ⟨hpr, hpg, hrg⟩ := cfg.idx_facts
  obtain ⟨⟨lo, hi, hlh, hP⟩, ⟨lo', hi', hlh', hR⟩⟩ := cfg.cone_piece_rest (s := s) hr0
  obtain ⟨hPcl, hPne, hPh⟩ := facts_of_cone hlh hP
  obtain ⟨hRcl, hRne, hRh⟩ := facts_of_cone hlh' hR
  obtain ⟨hPpre, hRpre⟩ := cfg.isPreconnected_piece_rest hr
  refine ⟨fun i => ?_, fun i => ?_, fun i => ?_, fun i => ?_, fun i => ?_⟩ <;>
    rcases openSectors_cases (X := X) (s := s) (b := b) up ψ r i with ⟨h1, h2⟩ | ⟨h1, h1', h2⟩ | ⟨h1, h1', h3, h2⟩ |
      ⟨h1, h1', h3, h2⟩ <;> rw [h2]
  · exact X.G.isOpen_openPiece v up s b ψ r
  · exact X.G.isOpen_openRest v up s b ψ r
  · exact isOpen_empty
  · exact X.hC.isOpen r hr₀ i
  · exact hPpre
  · exact hRpre
  · exact isPreconnected_empty
  · exact X.hC.isPreconnected r hr₀ i
  · exact fun _ => hPcl
  · exact fun _ => hRcl
  · exact fun hne => absurd hne Set.not_nonempty_empty
  · exact fun _ => X.hC.mem_closure_sector hr₀ i
  · exact ⟨fun _ => h1 ▸ hpg, fun _ => hPne⟩
  · exact ⟨fun _ => h1' ▸ hrg, fun _ => hRne⟩
  · exact ⟨fun hne => absurd hne Set.not_nonempty_empty, fun h => absurd h3 h⟩
  · exact ⟨fun _ => h3, fun _ => X.hC.sector_nonempty hr₀ i⟩
  · exact ⟨fun ⟨_, α, κ₁, κ₂, _, he⟩ => absurd he (hPh α κ₁ κ₂ r), fun hh => absurd h1 hh.2.1⟩
  · exact ⟨fun ⟨_, α, κ₁, κ₂, _, he⟩ => absurd he (hRh α κ₁ κ₂ r), fun hh => absurd h1' hh.2.2.1⟩
  · exact ⟨fun hh => absurd hh.1 Set.not_nonempty_empty, fun hh => absurd h3 hh.2.2.2⟩
  · rw [← sector_eq_hornSet_iff hr₀ i]
    exact ⟨fun hh => ⟨hh.2, h1, h1', h3⟩, fun hh => ⟨X.hC.sector_nonempty hr₀ i, hh.1⟩⟩

/-- **The closure of the gap out to `ρ/2`** lies in `{v}` and the gap out to `ρ` (a gap sector's closure points off `v` are in the
sector or on its two germs, both gap germs). -/
theorem closure_gapSet_subset_gapSet {a : ℕ} {ρ : ℝ} (h : X.Small ρ) :
    closure (X.G.gapSet v s a b (ρ / 2)) ⊆ {v} ∪ X.G.gapSet v s a b ρ := by
  have hsec : ∀ m, a < m → m < b → X.G.sector v ρ (BranchGerms.idx s m) ⊆ X.G.gapSet v s a b ρ := fun m h1 h2 z hz =>
    Or.inl (mem_iUnion₂.mpr ⟨_, ⟨m, h1, h2, rfl⟩, hz⟩)
  have hger : ∀ m, a < m → m ≤ b → ∀ t ∈ Ioo 0 ρ,
      branchPt v (X.G.β (BranchGerms.idx s m)) (X.G.κ (BranchGerms.idx s m)) t ∈ X.G.gapSet v s a b ρ :=
    fun m h1 h2 t ht => Or.inr (mem_iUnion₂.mpr ⟨_, ⟨m, h1, h2, rfl⟩, ⟨t, ht, rfl⟩⟩)
  unfold BranchGerms.gapSet
  rw [closure_union, (Set.toFinite _).closure_biUnion, (Set.toFinite _).closure_biUnion]
  refine union_subset (iUnion₂_subset fun i hi => ?_) (iUnion₂_subset fun j hj => ?_)
  · obtain ⟨m, h1, h2, rfl⟩ := hi
    intro z hz
    have hz' := closure_mono (sector_mono (by linarith [h.1] : ρ / 2 ≤ ρ) _) hz
    have hzle := (BranchGerms.mem_closure_sector hz).1
    by_cases hzv : z = v
    · exact Or.inl hzv
    · right
      have hz0 : 0 < ‖z - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzv)
      have hzρ : ‖z - v‖ < ρ := by linarith [h.1]
      rcases BranchGerms.closure_sector_cases hz' hz0 hzρ with h3 | h3 | h3
      · exact hsec m h1 h2 h3
      · rw [h3]; exact hger m h1 h2.le _ ⟨hz0, hzρ⟩
      · rw [BranchGerms.next_idx] at h3
        rw [h3]; exact hger (m + 1) (by omega) (by omega) _ ⟨hz0, hzρ⟩
  · obtain ⟨m, h1, h2, rfl⟩ := hj
    intro z hz
    have hz' : z ∈ branchPt v (X.G.β (BranchGerms.idx s m)) (X.G.κ (BranchGerms.idx s m)) '' Icc 0 (ρ / 2) :=
      closure_minimal (image_mono Ioo_subset_Icc_self) (isCompact_Icc.image (continuous_branchPt v _ _)).isClosed hz
    obtain ⟨t, ht, rfl⟩ := hz'
    rcases eq_or_lt_of_le ht.1 with h0 | h0
    · left; rw [← h0]; simp [branchPt]
    · right; exact hger m h1 h2 t ⟨h0, by linarith [ht.2, h.1]⟩

/-- **The open clear set about OPEN's recoloured set** (with the margin `η` of `OpenConfig.margin`): for `up`, the points between the
horn's outer germ `idx s 0` and the direction `ψ + η`; otherwise between `ψ − η` and the horn's outer germ `idx s (b + 1)`; out to `ρ`.
It is open, clear for `c` (the horn's points by validity, the rest by `clear` and `margin`), inside `B(v, ρ)`, and it holds the closures
of the recoloured gap and wedge off `v`. -/
theorem OpenConfig.exists_clearSet (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    ∃ U : Set ℂ, IsOpen U ∧ (∀ z ∈ U, F.IsClear c z) ∧ U ⊆ ball v ρ ∧
      closure (X.G.gapSet v s 0 b (ρ / 2)) ⊆ {v} ∪ U ∧ closure (X.G.openWedge v up s b ψ ρ) ⊆ {v} ∪ U := by
  obtain ⟨η, hη, hmar⟩ := cfg.margin
  have hb1 := cfg.hb1
  have hcl := cfg.clear
  have hray := cfg.ray
  have hhorn : ∀ i, ∀ z ∈ X.G.sector v ρ i, X.col i = c → F.IsClear c z := fun i z hz hic => by
    have hzr := X.hcol i ρ h.mem_Ioc hz
    have : F.col z = c := hzr.2.trans hic
    rw [← this]; exact isClear_col hF hzr.1
  have hmono : ∀ {t : ℝ}, t ∈ Ioo 0 ρ → StrictMono fun m => X.G.liftDir s m t := fun ht =>
    X.G.liftDir_mono X.hord s ⟨ht.1, ht.2.trans h.2.1⟩
  have hball : ∀ {t φ : ℝ}, t ∈ Ioo 0 ρ → v + (t : ℂ) * e φ ∈ ball v ρ := fun ht => by
    rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul_e ht.1.le]; exact ht.2
  -- the closure of the wedge, off `v`, in polar form
  have hW : ∀ z ∈ closure (X.G.openWedge v up s b ψ ρ), z = v ∨ ∃ t ∈ Ioo 0 ρ, ∃ φ,
      (if up then X.G.liftDir s b t ≤ φ ∧ φ ≤ ψ else ψ ≤ φ ∧ φ ≤ X.G.liftDir s 1 t) ∧ z = v + (t : ℂ) * e φ := by
    intro z hz
    have hz' : z ∈ closure (if up then sectorBetween v (X.G.lift s b) (X.G.κ (BranchGerms.idx s b)) ψ 0 (ρ / 2)
        else sectorBetween v ψ 0 (X.G.lift s 1) (X.G.κ (BranchGerms.idx s 1)) (ρ / 2)) := hz
    cases up
    · simp only [Bool.false_eq_true, if_false] at hz' ⊢
      obtain ⟨t, ht, φ, h1, h2, rfl⟩ := closure_sectorBetween_subset _ _ _ _ _ _ hz'
      rcases eq_or_lt_of_le ht.1 with h0 | h0
      · left; rw [← h0]; simp
      · right; refine ⟨t, ⟨h0, by linarith [ht.2, h.1]⟩, φ, ⟨?_, h2⟩, rfl⟩
        simpa [germDir] using h1
    · simp only [if_true] at hz' ⊢
      obtain ⟨t, ht, φ, h1, h2, rfl⟩ := closure_sectorBetween_subset _ _ _ _ _ _ hz'
      rcases eq_or_lt_of_le ht.1 with h0 | h0
      · left; rw [← h0]; simp
      · right; refine ⟨t, ⟨h0, by linarith [ht.2, h.1]⟩, φ, ⟨h1, ?_⟩, rfl⟩
        simpa [germDir] using h2
  -- the gap out to `ρ`, in polar form
  have hG : ∀ z ∈ X.G.gapSet v s 0 b ρ, ∃ t ∈ Ioo 0 ρ, ∃ φ ∈ Icc (X.G.liftDir s 1 t) (X.G.liftDir s b t),
      z = v + (t : ℂ) * e φ := by
    rintro z (hz | hz)
    · obtain ⟨i, hi, hzi⟩ := mem_iUnion₂.mp hz
      obtain ⟨φ, hφ, hzφ⟩ := exists_dir_of_mem_gapSec h hi hzi
      rw [zero_add] at hφ
      exact ⟨_, norm_of_mem_sector hzi, φ, hφ, hzφ⟩
    · obtain ⟨j, ⟨m, h1, h2, rfl⟩, t, ht, rfl⟩ := mem_iUnion₂.mp hz
      have hφ := liftDir_gap_germ (s := s) (⟨ht.1, ht.2.trans h.2.1⟩ : t ∈ Ioo 0 X.s₀) h1 h2
      rw [zero_add] at hφ
      exact ⟨t, ht, _, hφ, X.G.branchPt_idx v s m t⟩
  cases up
  · -- `σ = −1`: the horn is `idx s b`, the partial sector `idx s 0`
    simp only [Bool.false_eq_true, if_false, BranchGerms.rayPos, zero_add] at hcl hray hmar hW
    have hhb : X.col (BranchGerms.idx s b) = c := cfg.col_horn
    refine ⟨sectorBetween v (ψ - η) 0 (X.G.lift s (b + 1)) (X.G.κ (BranchGerms.idx s (b + 1))) ρ, isOpen_sectorBetween _ _ _ _ _ _,
      ?_, ?_, ?_, ?_⟩
    · rintro z ⟨t, ht, φ, hφ, rfl⟩
      simp only [zero_mul, zero_div, Real.arcsin_zero, add_zero, mem_Ioo] at hφ
      have hφ2 : φ < X.G.liftDir s (b + 1) t := hφ.2
      have htc : t ∈ Ioo 0 ρc := ⟨ht.1, ht.2.trans_le hρc⟩
      by_cases h1 : φ ≤ ψ
      · exact hmar t htc φ hφ.1.le h1
      by_cases h2 : φ ≤ X.G.liftDir s b t
      · exact hcl t htc φ (not_le.mp h1).le h2
      · exact hhorn _ _ ((X.G.mem_sector_idx s b).mpr ⟨t, ht, φ, ⟨not_le.mp h2, hφ2⟩, rfl⟩) hhb
    · rintro z ⟨t, ht, φ, -, rfl⟩; exact hball ht
    · intro z hz
      rcases closure_gapSet_subset_gapSet h hz with hz | hz
      · exact Or.inl hz
      · right
        obtain ⟨t, ht, φ, hφ, rfl⟩ := hG z hz
        have htc : t ∈ Ioo 0 ρc := ⟨ht.1, ht.2.trans_le hρc⟩
        refine ⟨t, ht, φ, ⟨?_, ?_⟩, rfl⟩
        · simp only [zero_mul, zero_div, Real.arcsin_zero, add_zero]; linarith [(hray t htc).2, hφ.1]
        · show φ < X.G.liftDir s (b + 1) t
          linarith [hφ.2, hmono ht (Nat.lt_succ_self b)]
    · intro z hz
      rcases hW z hz with rfl | ⟨t, ht, φ, hφ, rfl⟩
      · exact Or.inl rfl
      · right
        refine ⟨t, ht, φ, ⟨?_, ?_⟩, rfl⟩
        · simp only [zero_mul, zero_div, Real.arcsin_zero, add_zero]; linarith [hφ.1]
        · show φ < X.G.liftDir s (b + 1) t
          linarith [hφ.2, hmono ht (show 1 < b + 1 by omega)]
  · -- `σ = +1`: the horn is `idx s 0`, the partial sector `idx s b`
    simp only [if_true, BranchGerms.rayPos] at hcl hray hmar hW
    have hh0 : X.col (BranchGerms.idx s 0) = c := cfg.col_horn
    refine ⟨sectorBetween v (X.G.lift s 0) (X.G.κ (BranchGerms.idx s 0)) (ψ + η) 0 ρ, isOpen_sectorBetween _ _ _ _ _ _,
      ?_, ?_, ?_, ?_⟩
    · rintro z ⟨t, ht, φ, hφ, rfl⟩
      simp only [zero_mul, zero_div, Real.arcsin_zero, add_zero, mem_Ioo] at hφ
      have hφ1 : X.G.liftDir s 0 t < φ := hφ.1
      have htc : t ∈ Ioo 0 ρc := ⟨ht.1, ht.2.trans_le hρc⟩
      by_cases h1 : φ < X.G.liftDir s 1 t
      · exact hhorn _ _ ((X.G.mem_sector_idx s 0).mpr ⟨t, ht, φ, ⟨hφ1, h1⟩, rfl⟩) hh0
      by_cases h2 : φ ≤ ψ
      · exact hcl t htc φ (not_lt.mp h1) h2
      · exact hmar t htc φ (not_le.mp h2).le hφ.2.le
    · rintro z ⟨t, ht, φ, -, rfl⟩; exact hball ht
    · intro z hz
      rcases closure_gapSet_subset_gapSet h hz with hz | hz
      · exact Or.inl hz
      · right
        obtain ⟨t, ht, φ, hφ, rfl⟩ := hG z hz
        have htc : t ∈ Ioo 0 ρc := ⟨ht.1, ht.2.trans_le hρc⟩
        refine ⟨t, ht, φ, ⟨?_, ?_⟩, rfl⟩
        · show X.G.liftDir s 0 t < φ
          linarith [hφ.1, hmono ht zero_lt_one]
        · simp only [zero_mul, zero_div, Real.arcsin_zero, add_zero]; linarith [(hray t htc).1, hφ.2]
    · intro z hz
      rcases hW z hz with rfl | ⟨t, ht, φ, hφ, rfl⟩
      · exact Or.inl rfl
      · right
        refine ⟨t, ht, φ, ⟨?_, ?_⟩, rfl⟩
        · show X.G.liftDir s 0 t < φ
          linarith [hφ.1, hmono ht (show 0 < b by omega)]
        · simp only [zero_mul, zero_div, Real.arcsin_zero, add_zero]; linarith [hφ.2]

/-- `v` is in the closure of `F`'s class of `c` (the horn's sector). -/
theorem OpenConfig.v_mem_closure_region (cfg : X.OpenConfig c up s b ψ ρc) {ρ : ℝ} (h : X.Small ρ) :
    v ∈ closure (F.region c) :=
  closure_mono (s := X.G.sector v ρ (BranchGerms.idx s (BranchGerms.hornPos up b)))
    (fun _ hy => cfg.col_horn ▸ X.hcol _ ρ h.mem_Ioc hy) (X.hC.mem_closure_sector h.mem_Ioc _)

/-! ## OPEN's clauses -/

section Surgery

variable {c : Fin k} {up : Bool} {ψ ρc ρ : ℝ} {hv : v ∈ F.dom} {hρ : 0 < ρ}
  {hA : ∀ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.Nondegenerate} {hAf : (X.G.openArcs v X.col up s b ψ ρ).Finite}
  {hlc : ∀ x ∈ F.dom, x ∉ ⋃ a ∈ F.trimArcs v ρ ∪ X.G.openArcs v X.col up s b ψ ρ, a.carrier →
    ∀ᶠ y in 𝓝 x, X.G.openCol v X.col F.col up s b ψ c ρ y = X.G.openCol v X.col F.col up s b ψ c ρ x}

/-- Inside `B(v, ρ)`, OPEN's interior points are the points off its new arcs. -/
theorem mem_open_interiorPts_iff (h : X.Small ρ) {z : ℂ} (hz : z ∈ ball v ρ) :
    z ∈ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).interiorPts ↔
      z ∉ ⋃ A ∈ X.G.openArcs v X.col up s b ψ ρ, A.carrier := by
  have hzd : z ∈ F.dom := X.hG.subdom (ball_subset_ball h.2.2.1.le hz)
  show z ∈ F.dom \ _ ↔ _
  rw [Set.mem_sdiff, surgery_mem_arcs_iff_of_mem X.hG h.2.2.1 hz]
  exact ⟨fun h1 => h1.2, fun h1 => ⟨hzd, h1⟩⟩

/-- On the rim, OPEN's interior points are `F`'s (a germ's rim point lies on the trimmed arcs). -/
theorem mem_interiorPts_of_open_rim {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') {z : ℂ} (hz : dist z v = ρ)
    (hzI : z ∈ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
      hlc).interiorPts) : z ∈ F.interiorPts := by
  refine ⟨hzI.1, fun hzF => ?_⟩
  have hzv : z ≠ v := fun hzv => by rw [hzv, dist_self] at hz; linarith
  have hzr : z ∈ ball v X.r₀ := by rw [mem_ball, hz]; exact hρρ'.trans h'.lt_r₀
  obtain ⟨j, hj⟩ := X.hC.exists_branchPt_eq hzv hzr (fun hI => hI.2 hzF)
  rw [← dist_eq_norm, hz] at hj
  obtain ⟨B, hB, hzB⟩ := mem_iUnion₂.mp (hj ▸ branchPt_rim_mem_trimArcs h' hρ hρρ' j)
  exact hzI.2 (mem_iUnion₂.mpr ⟨B, Or.inl hB, hzB⟩)

/-- OPEN's map agrees with `F` off the closed disc. -/
theorem open_agreesOff (h : X.Small ρ) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).AgreesOff F
      (closedBall v ρ) := by
  refine surgery_agreesOff (fun A hA => openArcs_subset_closedBall h A hA) (fun z hz => ?_)
  have hz' : z ∉ ball v ρ := fun h' => hz (ball_subset_closedBall h')
  have hW : z ∉ X.G.openWedge v up s b ψ ρ := fun h' =>
    hz' (ball_subset_ball (by linarith [h.1]) (X.G.openWedge_subset_ball v up s b ψ ρ h'))
  simp only [BranchGerms.openCol, if_neg hW]
  exact mergeCol_of_not_mem h hz'

/-- OPEN's map creates no unit arc. -/
theorem open_ringArcsWithin (h : X.Small ρ) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).RingArcsWithin
      F := by
  refine surgery_ringArcsWithin fun A hA hu => ?_
  rcases hA with hA | hA
  · exact mergeArcs_unit h A hA hu
  rcases hA with rfl | rfl
  · exact absurd hu (by simp [openRay, Arc.IsUnitArc])
  · exfalso
    unfold BranchGerms.openRim at hu
    split_ifs at hu <;> · simp only [Arc.IsUnitArc] at hu; linarith [h.2.2.2]

/-- OPEN's map keeps Condition 5. -/
theorem open_condition5 (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    F.Condition5 →
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).Condition5 := by
  refine surgery_condition5 fun h5 A hA p => ?_
  rcases hA with hA | hA
  · exact mergeArcs_condition5 h cfg.hbn h5 A hA p
  rcases hA with rfl | rfl
  · rcases Arc.finite_inter_sphere_or_eq_circ _ (openRay_nondegenerate (v := v) (ψ := ψ) h.1) p with hf | ⟨θ₀, θ₁, heq⟩
    · exact hf.subset fun z hz => ⟨hz.1.1, hz.2⟩
    · simp [openRay] at heq
  · rcases Arc.finite_inter_sphere_or_eq_circ _ (openRim_nondegenerate cfg h hρc) p with hf | ⟨θ₀, θ₁, heq⟩
    · exact hf.subset fun z hz => ⟨hz.1.1, hz.2⟩
    · exfalso
      unfold BranchGerms.openRim at heq
      split_ifs at heq <;> · simp only [Arc.circ.injEq] at heq; linarith [h.2.2.2, heq.2.1]

/-- **OPEN's map is valid**: every recoloured point is clear for `c` (the configuration's clear wedge), and the disc is small. -/
theorem open_valid (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).Valid := by
  have hregion : ∀ i, ∀ y ∈ F.region i, F.IsClear i y := fun i y hy => by
    have h1 := hy.2; simp only [mem_preimage, mem_singleton_iff] at h1; rw [← h1]; exact isClear_col hF hy.1
  have hn : 0 < X.n := by have := cfg.hbn; omega
  refine Valid.of_agreesOff hF (open_agreesOff h) ?_ ?_
  · rintro z ⟨hzc, hzI⟩
    show F.IsClear (X.G.openCol v X.col F.col up s b ψ c ρ z) z
    rcases (mem_closedBall.mp hzc).lt_or_eq with hlt | heq
    · have hzv : z ≠ v := by
        rintro rfl; exact (mem_open_interiorPts_iff h hlt).mp hzI v_mem_openArcs
      by_cases hzW : z ∈ X.G.openWedge v up s b ψ ρ
      · rw [openCol_of_mem hzW]; exact cfg.isClear_of_mem_openWedge h hρc hzW
      rw [openCol_of_not_mem hzW]
      rcases ball_cases h hn hlt hzv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
      · rw [mergeCol_of_mem_sector h hi]; split_ifs with hg
        · obtain ⟨φ, hφ, hzφ⟩ := exists_dir_of_mem_gapSec h hg.1 hi
          rw [zero_add] at hφ
          rw [hzφ]; exact cfg.isClear_of_Icc ⟨(norm_of_mem_sector hi).1, by linarith [hg.2, h.1]⟩ hφ
        · exact hregion _ _ (X.hcol i ρ h.mem_Ioc hi)
      · rw [mergeCol_branchPt h j ht]; split_ifs with hg
        · obtain ⟨m, h1, h2, rfl⟩ := hg.1
          have hφ := liftDir_gap_germ (s := s) (⟨ht.1, ht.2.trans h.2.1⟩ : t ∈ Ioo 0 X.s₀) h1 h2
          rw [zero_add] at hφ
          rw [X.G.branchPt_idx]
          exact cfg.isClear_of_Icc ⟨ht.1, by linarith [hg.2, h.1]⟩ hφ
        · exact isClear_of_mem_closure (hregion _) (cutSet_subset_closure h ⟨t, ht, rfl⟩)
    · have hzF := mem_interiorPts_of_open_rim h' hρρ' heq hzI
      have hzb : z ∉ ball v ρ := by rw [mem_ball, heq]; exact lt_irrefl ρ
      rw [openCol_of_not_mem (fun hW => hzb (ball_subset_ball (by linarith [h.1])
        (X.G.openWedge_subset_ball v up s b ψ ρ hW))), mergeCol_of_not_mem h hzb]
      exact isClear_col hF hzF
  · rintro z ⟨hz, -⟩ y ⟨hy, -⟩ hzy
    exfalso
    have := dist_triangle_right z y v
    rw [mem_closedBall] at hz hy
    linarith [h.2.2.2]

/-- **`v` gains no colour**: every colour of the new map near `v` is a chart sector's colour or `c`. -/
theorem open_coloursAt_self (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (_hρc : ρ ≤ ρc) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).coloursAt v ⊆
      F.coloursAt v := by
  have hcol : ∀ i, X.col i ∈ F.coloursAt v := fun i => X.col_mem_coloursAt i
  have hc : c ∈ F.coloursAt v := cfg.col_horn ▸ hcol _
  have hn : 0 < X.n := by have := cfg.hbn; omega
  intro j hj
  have hj : v ∈ closure ((F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
    hlc).region j) := hj
  rw [mem_closure_iff_nhds] at hj
  obtain ⟨z, hzb, hzI, hzj⟩ := hj (ball v ρ) (isOpen_ball.mem_nhds (mem_ball_self h.1))
  have hzj' : X.G.openCol v X.col F.col up s b ψ c ρ z = j := hzj
  have hzv : z ≠ v := by
    intro hzv0
    exact hzI.2 (mem_iUnion₂.mpr ⟨openRay v ψ ρ, Or.inr (Or.inr (Or.inl rfl)), hzv0 ▸ left_mem_segment ℝ _ _⟩)
  rw [← hzj']
  unfold BranchGerms.openCol
  split_ifs
  · exact hc
  · rcases ball_cases h hn hzb hzv with ⟨i, hi⟩ | ⟨j', t, ht, rfl⟩
    · rw [mergeCol_of_mem_sector h hi]; split_ifs
      · exact hc
      · exact hcol i
    · rw [mergeCol_branchPt h j' ht]; split_ifs
      · exact hc
      · exact hcol j'

/-- **A point of a chart sector off the partial sector, inside `ρ/2`, is interior to OPEN's map** (it is interior to `F`, and the ray
runs through the partial sector). -/
theorem mem_open_interiorPts_of_sector (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (hρc : ρ ≤ ρc) {i : Fin X.n}
    (hi : i ≠ BranchGerms.idx s (BranchGerms.rayPos up b)) {z : ℂ} (hz : z ∈ X.G.sector v ρ i) (hzr : ‖z - v‖ < ρ / 2) :
    z ∈ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).interiorPts := by
  have hzb : z ∈ ball v ρ := by rw [mem_ball, dist_eq_norm]; linarith [h.1]
  refine (mem_open_interiorPts_iff h hzb).mpr fun hzA => ?_
  have hzF := sector_subset_interiorPts h i hz
  obtain ⟨A, hA, hzA'⟩ := mem_iUnion₂.mp hzA
  rcases hA with hA | rfl | rfl
  · rcases mergeArcs_cases h hA with ⟨j, hj⟩ | ⟨-, rfl⟩
    · exact hzF.2 (germ_subset_Γ h j (hj hzA')).2
    · rw [norm_of_mem_rimArc h hzA'] at hzr; exact lt_irrefl _ hzr
  · obtain ⟨t, ht, rfl⟩ := eq_of_mem_openRay h.1 hzA'
    have ht0 := (norm_of_mem_sector hz).1
    rw [add_sub_cancel_left, norm_mul_e ht.1] at ht0 hzr
    have hray : v + (t : ℂ) * e ψ ∈ X.G.sector v ρ (BranchGerms.idx s (BranchGerms.rayPos up b)) :=
      (X.G.mem_sector_idx s _).mpr ⟨t, ⟨ht0, by linarith [h.1]⟩, ψ, cfg.ray t ⟨ht0, by linarith [h.1]⟩, rfl⟩
    exact hi (sector_disjoint h hz hray)
  · have := X.G.openRim_subset_sphere v up s b ψ h.1.le hzA'
    rw [mem_sphere, dist_eq_norm] at this; linarith

/-- **OPEN's interior points near `v` are OPEN's sectors**: inside `ρ/2`, the merged piece, the rest of the partial sector and the chart's
sectors off the gap cover them. -/
theorem open_partition (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (hρc : ρ ≤ ρc) {r : ℝ} (hr : r ∈ Ioc 0 (ρ / 2)) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).interiorPts ∩
      ball v r = ⋃ i, openSectors X up s b ψ r i := by
  have hn : 0 < X.n := by have := cfg.hbn; omega
  have hrc : r ≤ ρc := by linarith [hr.2, h.1]
  have hrρ : r < ρ := by linarith [hr.2, h.1]
  have hpiece : ∀ z, z ∈ X.G.openPiece v up s b ψ r → z ∈ ⋃ i, openSectors X up s b ψ r i := fun z hz => by
    refine mem_iUnion.mpr ⟨BranchGerms.idx s (BranchGerms.hornPos up b), ?_⟩
    rcases openSectors_cases (X := X) (s := s) (b := b) up ψ r (BranchGerms.idx s (BranchGerms.hornPos up b)) with
      ⟨-, h1⟩ | ⟨h1, -⟩ | ⟨h1, -⟩ | ⟨h1, -⟩
    · rw [h1]; exact hz
    all_goals exact absurd rfl h1
  ext z
  constructor
  · rintro ⟨hzI, hzb⟩
    have hzr : ‖z - v‖ < r := by rw [← dist_eq_norm]; exact hzb
    have hzb' : z ∈ ball v ρ := ball_subset_ball hrρ.le hzb
    have hzA := (mem_open_interiorPts_iff h hzb').mp hzI
    have hzv : z ≠ v := by rintro rfl; exact hzA v_mem_openArcs
    rcases ball_cases h hn hzb' hzv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
    · have hi' := mem_sector_of_lt hi hzr
      rcases openSectors_cases (X := X) (s := s) (b := b) up ψ r i with ⟨h1, -⟩ | ⟨-, h1, h2⟩ | ⟨-, -, h3, -⟩ |
        ⟨-, -, -, h4⟩
      · exact hpiece z (cfg.horn_subset_piece hrc (h1 ▸ hi'))
      · rw [h1] at hi
        rcases sector_rayPos_cases cfg h hi (by linarith [hr.2]) with hW | hR | hM | hRest
        · exact hpiece z (X.G.mem_openPiece_of_lt (openWedge_subset_openPiece cfg h hW) hzr)
        · exact absurd (mem_iUnion₂.mpr ⟨openRay v ψ ρ, Or.inr (Or.inl rfl), hR⟩) hzA
        · exact absurd (mem_iUnion₂.mpr ⟨X.G.openRim v up s b ψ ρ, Or.inr (Or.inr rfl), hM⟩) hzA
        · exact mem_iUnion.mpr ⟨i, by rw [h2]; exact X.G.mem_openRest_of_lt hRest hzr⟩
      · obtain ⟨φ, hφ, hzφ⟩ := exists_dir_of_mem_gapSec h h3 hi
        rw [zero_add] at hφ
        exact hpiece z (hzφ ▸ cfg.mem_piece_of_Icc hrc ⟨(norm_of_mem_sector hi).1, hzr⟩ hφ)
      · exact mem_iUnion.mpr ⟨i, by rw [h4]; exact hi'⟩
    · rw [norm_branchPt_sub v _ _ ht.1.le] at hzr
      by_cases hjg : j ∈ BranchGerms.gapGerm s 0 b
      · obtain ⟨m, h1, h2, rfl⟩ := hjg
        have hφ := liftDir_gap_germ (s := s) (⟨ht.1, ht.2.trans h.2.1⟩ : t ∈ Ioo 0 X.s₀) h1 h2
        rw [zero_add] at hφ
        rw [X.G.branchPt_idx]
        exact hpiece _ (cfg.mem_piece_of_Icc hrc ⟨ht.1, hzr⟩ hφ)
      · obtain ⟨A, hA', hzA'⟩ := mem_iUnion₂.mp (branchPt_mem_mergeArcs_inner (s := s) h hjg ⟨ht.1, by linarith [hr.2]⟩)
        exact absurd (mem_iUnion₂.mpr ⟨A, Or.inl hA', hzA'⟩) hzA
  · intro hz
    obtain ⟨i, hi⟩ := mem_iUnion.mp hz
    rcases openSectors_cases (X := X) (s := s) (b := b) up ψ r i with ⟨-, h1⟩ | ⟨-, -, h1⟩ | ⟨-, -, -, h1⟩ |
      ⟨-, h2, -, h4⟩
    · rw [h1] at hi
      obtain ⟨t, ht, φ, h1', h2', h3', rfl⟩ := cfg.mem_openPiece_iff hrc hi
      have htn : ‖v + (t : ℂ) * e φ - v‖ = t := by rw [add_sub_cancel_left, norm_mul_e ht.1.le]
      have hzb : v + (t : ℂ) * e φ ∈ ball v ρ := by rw [mem_ball, dist_eq_norm, htn]; linarith [ht.2, hr.2]
      exact ⟨(mem_open_interiorPts_iff h hzb).mpr
        (cfg.not_mem_openArcs h hρc ⟨ht.1, by linarith [ht.2, hr.2]⟩ h1' h2' h3'), by
          rw [mem_ball, dist_eq_norm, htn]; exact ht.2⟩
    · rw [h1] at hi
      obtain ⟨t, ht, φ, h1', h2', h3', rfl⟩ := cfg.mem_openRest_iff hrc hi
      have htn : ‖v + (t : ℂ) * e φ - v‖ = t := by rw [add_sub_cancel_left, norm_mul_e ht.1.le]
      have hzb : v + (t : ℂ) * e φ ∈ ball v ρ := by rw [mem_ball, dist_eq_norm, htn]; linarith [ht.2, hr.2]
      exact ⟨(mem_open_interiorPts_iff h hzb).mpr
        (cfg.not_mem_openArcs h hρc ⟨ht.1, by linarith [ht.2, hr.2]⟩ h1' h2' h3'), by
          rw [mem_ball, dist_eq_norm, htn]; exact ht.2⟩
    · rw [h1] at hi; exact absurd hi (notMem_empty z)
    · rw [h4] at hi
      have hzr := (norm_of_mem_sector hi).2
      exact ⟨mem_open_interiorPts_of_sector cfg h hρc h2 (sector_mono hrρ.le i hi) (by linarith [hr.2]), by
        rw [mem_ball, dist_eq_norm]; exact hzr⟩

/-- **The degree does not rise and a horn is lost**: below `ρ/2` the sectors of the new map at `v` are the chart sectors off the
gap, the merged piece (the horn, the swallowed horns and the wedge) and the rest of the partial sector; the last two have
directions on an open interval, so they are no horn sets, while the horn was one. -/
theorem open_degree_horns (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (_h' : X.Small ρ') (_hρρ' : ρ < ρ') (h : X.Small ρ)
    (hρc : ρ ≤ ρc) {m j : ℕ} (hm : F.HasDegree v m) (hj : F.HasHornCount v j) :
    ∃ m' j', m' ≤ m ∧ j' < j ∧
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).HasDegree v m' ∧
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).HasHornCount v
        j' := by
  classical
  have hn2 := cfg.two_le
  have hn : 0 < X.n := by omega
  have hmn : m = X.n := by rw [hm.eq X.hC.hasDegree, max_eq_left (by omega)]
  have hjJ : j = {i : Fin X.n | X.G.β i = X.G.nextβ i}.ncard := hj.eq (hasHornCount_chart hn)
  have hpJ : X.G.β (BranchGerms.idx s (BranchGerms.hornPos up b)) = X.G.nextβ (BranchGerms.idx s (BranchGerms.hornPos up b)) := by
    have hc := cfg.cusp
    rw [X.G.lift_succ] at hc
    linarith
  set K : Set (Fin X.n) := {i | X.G.β i = X.G.nextβ i ∧ i ≠ BranchGerms.idx s (BranchGerms.hornPos up b) ∧
    i ≠ BranchGerms.idx s (BranchGerms.rayPos up b) ∧ i ∉ BranchGerms.gapSec s 0 b} with hK
  set D : Set (Fin X.n) := {i | i ∉ BranchGerms.gapSec s 0 b} with hD
  -- at each radius inside `ρ/2`, the sectors of the new map are OPEN's non-empty sectors
  have hsec : ∀ r ∈ Ioo 0 (ρ / 2), ∀ S,
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).IsSector
        v r S ↔ ∃ i, (openSectors X up s b ψ r i).Nonempty ∧ S = openSectors X up s b ψ r i := by
    intro r hr S
    have hrc : r ≤ ρc := by linarith [hr.2, h.1]
    obtain ⟨hopen, hpre, hcl, -, -⟩ := cfg.openSectors_facts hr.1 hrc
    exact isSector_iff_of_partition' (open_partition cfg h hρc ⟨hr.1, hr.2.le⟩) hopen hpre
      (fun i i' hii' => cfg.disjoint_openSectors hr.1 hrc hii') hcl
  refine ⟨D.ncard, K.ncard, ?_, ?_, ?_, ?_⟩
  · rw [hmn]
    exact (Set.ncard_le_ncard (subset_univ D)).trans (by rw [Set.ncard_univ, Nat.card_eq_fintype_card, Fintype.card_fin])
  · rw [hjJ]
    exact Set.ncard_lt_ncard ⟨fun i hi => hi.1, fun hsub => (hsub hpJ).2.1 rfl⟩
  · filter_upwards [Ioo_mem_nhdsGT h.half.1] with r hr
    have hrc : r ≤ ρc := by linarith [hr.2, h.1]
    obtain ⟨-, -, -, hne, -⟩ := cfg.openSectors_facts hr.1 hrc
    have heq : {S | (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
        hlc).IsSector v r S} = openSectors X up s b ψ r '' D := by
      ext S
      rw [mem_setOf_eq, hsec r hr S]
      exact ⟨fun ⟨i, hi, he⟩ => ⟨i, (hne i).mp hi, he.symm⟩, fun ⟨i, hi, he⟩ => ⟨i, (hne i).mpr hi, he.symm⟩⟩
    have hinj : Set.InjOn (openSectors X up s b ψ r) D :=
      (injOn_of_disjoint fun i i' hii' => cfg.disjoint_openSectors hr.1 hrc hii').mono fun i hi => (hne i).mpr hi
    rw [heq, hinj.encard_image, (Set.toFinite D).cast_ncard_eq]
  · filter_upwards [Ioo_mem_nhdsGT h.half.1] with r hr
    have hrc : r ≤ ρc := by linarith [hr.2, h.1]
    obtain ⟨-, -, -, -, hhorn⟩ := cfg.openSectors_facts hr.1 hrc
    have heq : {S | (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
        hlc).IsSector v r S ∧ ∃ α κ₁ κ₂, κ₁ < κ₂ ∧ S = hornSet v α κ₁ κ₂ r} = openSectors X up s b ψ r '' K := by
      ext S
      rw [mem_setOf_eq, hsec r hr S]
      constructor
      · rintro ⟨⟨i, hi, rfl⟩, hh⟩
        exact ⟨i, (hhorn i).mp ⟨hi, hh⟩, rfl⟩
      · rintro ⟨i, hi, rfl⟩
        obtain ⟨hne, hh⟩ := (hhorn i).mpr hi
        exact ⟨⟨i, hne, rfl⟩, hh⟩
    have hinj : Set.InjOn (openSectors X up s b ψ r) K :=
      (injOn_of_disjoint fun i i' hii' => cfg.disjoint_openSectors hr.1 hrc hii').mono fun i hi => ((hhorn i).mpr hi).1
    rw [heq, hinj.encard_image, (Set.toFinite K).cast_ncard_eq]

/-- **A point of `F`'s interior off `B̄(v, ρ/2)` is interior to OPEN's map**: OPEN's new arcs there are germ arcs of `F` (the rim arcs,
the ray and the wedge lie in `B̄(v, ρ/2)`). -/
theorem mem_open_interiorPts_of_mem (h : X.Small ρ) {z : ℂ} (hz : z ∈ F.interiorPts) (hzr : ρ / 2 < ‖z - v‖) :
    z ∈ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).interiorPts := by
  refine ⟨hz.1, fun hzA => ?_⟩
  obtain ⟨B, hB, hzB⟩ := mem_iUnion₂.mp hzA
  rcases hB with hB | hB | rfl | rfl
  · obtain ⟨-, a', ha', hsub, -⟩ := (F.trimArcs_spec hv hρ).1 B hB
    exact hz.2 (mem_iUnion₂.mpr ⟨a', ha', hsub hzB⟩)
  · rcases mergeArcs_cases h hB with ⟨j, hj⟩ | ⟨-, rfl⟩
    · exact hz.2 (germ_subset_Γ h j (hj hzB)).2
    · rw [norm_of_mem_rimArc h hzB] at hzr; exact lt_irrefl _ hzr
  · have := openRay_subset_closedBall v ψ h.1.le hzB
    rw [mem_closedBall, dist_eq_norm] at this; linarith
  · have := X.G.openRim_subset_sphere v up s b ψ h.1.le hzB
    rw [mem_sphere, dist_eq_norm] at this; linarith

/-- **A germ's point between `ρ/2` and a small `ρ' > ρ` is interior to OPEN's map** exactly when it is inside `ρ` on a phantom germ
(as for MERGE: the phantom germs are cut in the annulus; a germ's rim point is on the trimmed arcs; beyond `ρ` the map is `F`). -/
theorem branchPt_mem_open_interiorPts_iff {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (j : Fin X.n) {t : ℝ}
    (ht : t ∈ Ioo (ρ / 2) ρ') :
    branchPt v (X.G.β j) (X.G.κ j) t ∈
        (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).interiorPts ↔
      t < ρ ∧ BranchGerms.Phantom X.col j := by
  have ht0 : 0 < t := by linarith [ht.1, h.1]
  have hdist : dist (branchPt v (X.G.β j) (X.G.κ j) t) v = t := dist_branchPt j ht0.le
  constructor
  · intro hzI
    have htρ : t < ρ := by
      by_contra hge
      rcases eq_or_lt_of_le (not_lt.mp hge) with heq | hgt
      · obtain ⟨B, hB, hzB⟩ := mem_iUnion₂.mp (branchPt_rim_mem_trimArcs h' hρ hρρ' j)
        rw [heq] at hzB
        exact hzI.2 (mem_iUnion₂.mpr ⟨B, Or.inl hB, hzB⟩)
      · have hzc : branchPt v (X.G.β j) (X.G.κ j) t ∉ closedBall v ρ := by
          rw [mem_closedBall, hdist, not_le]; exact hgt
        have hzF := ((open_agreesOff (X := X) (s := s) (b := b) (c := c) (up := up) (ψ := ψ) (hv := hv) (hρ := hρ) (hA := hA)
          (hAf := hAf) (hlc := hlc) h).2 _ hzc).1.mpr hzI
        exact hzF.2 (X.hC.branchPt_mem_Γ j ⟨ht0, ht.2.trans h'.lt_r₀⟩).2
    refine ⟨htρ, ?_⟩
    by_contra hph
    have hzb : branchPt v (X.G.β j) (X.G.κ j) t ∈ ball v ρ := by rw [mem_ball, hdist]; exact htρ
    obtain ⟨A, hA', hzA'⟩ := mem_iUnion₂.mp (branchPt_mem_mergeArcs_outer (s := s) (a := 0) (b := b) h hph ⟨ht.1, htρ.le⟩)
    exact (mem_open_interiorPts_iff h hzb).mp hzI (mem_iUnion₂.mpr ⟨A, Or.inl hA', hzA'⟩)
  · rintro ⟨htρ, hph⟩
    have hzb : branchPt v (X.G.β j) (X.G.κ j) t ∈ ball v ρ := by rw [mem_ball, hdist]; exact htρ
    refine (mem_open_interiorPts_iff h hzb).mpr fun hzA => ?_
    obtain ⟨A, hA', hzA'⟩ := mem_iUnion₂.mp hzA
    rcases hA' with hA' | rfl | rfl
    · rcases mem_mergeArcs.mp hA' with ⟨j', -, rfl⟩ | ⟨j', hj', hA''⟩ | ⟨-, rfl⟩
      · rw [carrier_germ h.half] at hzA'
        obtain ⟨t', ht', he⟩ := hzA'
        have := congrArg (fun z => dist z v) he
        simp only [dist_branchPt j' ht'.1, hdist] at this
        linarith [ht'.2, ht.1]
      · obtain ⟨t', ht', he⟩ := outer_subset h j' A hA'' hzA'
        have htt : t' = t := by
          have := congrArg (fun z => dist z v) he
          simp only [dist_branchPt j' (by linarith [ht'.1, h.1] : (0 : ℝ) ≤ t'), hdist] at this
          exact this
        subst htt
        exact hj' ((eq_of_branchPt_eq X.hdisj ⟨ht0, ht.2.trans h'.2.1⟩ he) ▸ hph)
      · have := norm_of_mem_rimArc h hzA'
        rw [← dist_eq_norm, hdist] at this
        linarith [ht.1]
    · have := openRay_subset_closedBall v ψ h.1.le hzA'
      rw [mem_closedBall, hdist] at this; linarith [ht.1]
    · have := X.G.openRim_subset_sphere v up s b ψ h.1.le hzA'
      rw [mem_sphere, hdist] at this; linarith [ht.1]

/-- **OPEN's colour of a sector point off `B̄(v, ρ/2)`** (out to a small `ρ' > ρ`) is the sector's colour. -/
theorem openCol_of_mem_sector_out {ρ' : ℝ} (h' : X.Small ρ') (h : X.Small ρ) {i : Fin X.n} {z : ℂ}
    (hz : z ∈ X.G.sector v ρ' i) (hzr : ρ / 2 < ‖z - v‖) : X.G.openCol v X.col F.col up s b ψ c ρ z = X.col i := by
  rw [openCol_of_not_mem (fun hW => by
      have := X.G.openWedge_subset_ball v up s b ψ ρ hW
      rw [mem_ball, dist_eq_norm] at this; linarith), mergeCol_of_mem_sector_out h' h hz hzr]

/-- **The colours at a rim point** after OPEN are `F`'s there (as for MERGE: near the rim the new colouring is `F`'s on `F`'s interior
points, and a cut phantom branch takes the colour of the sector after its germ). -/
theorem open_coloursAt_rim {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hn : 0 < X.n) {x : ℂ}
    (hx : x ∈ sphere v ρ) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).coloursAt x ⊆
      F.coloursAt x := by
  intro j hj
  have hj : x ∈ closure ((F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA
    hAf hlc).region j) := hj
  have hxU : x ∈ (closedBall v (ρ / 2))ᶜ := by
    rw [mem_compl_iff, mem_closedBall, not_le, mem_sphere.mp hx]; linarith [h.1]
  have hoffW : ∀ z : ℂ, ρ / 2 < dist z v → X.G.openCol v X.col F.col up s b ψ c ρ z = X.G.mergeCol v X.col F.col s 0 b c ρ z :=
    fun z hz => openCol_of_not_mem fun hW => by
      have := X.G.openWedge_subset_ball v up s b ψ ρ hW; rw [mem_ball] at this; linarith
  have key : (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).region j ∩
      (closedBall v (ρ / 2))ᶜ ⊆ closure (F.region j) := by
    rintro z ⟨⟨hzI, hzj⟩, hzc⟩
    have hzj' : X.G.openCol v X.col F.col up s b ψ c ρ z = j := hzj
    rw [mem_compl_iff, mem_closedBall, not_le] at hzc
    rw [hoffW z hzc] at hzj'
    rcases lt_trichotomy (dist z v) ρ with hlt | heq | hgt
    · have hzv : z ≠ v := fun hzv => by rw [hzv, dist_self] at hzc; linarith [h.1]
      have hzn : ρ / 2 < ‖z - v‖ := by rw [← dist_eq_norm]; exact hzc
      rcases ball_cases h hn hlt hzv with ⟨i, hi⟩ | ⟨j', t, ht, rfl⟩
      · rw [mergeCol_of_mem_sector h hi, if_neg (fun h1 => (not_lt.mpr hzn.le) h1.2)] at hzj'
        exact subset_closure (hzj' ▸ X.hcol i ρ h.mem_Ioc hi)
      · rw [norm_branchPt_sub v _ _ ht.1.le] at hzn
        rw [mergeCol_branchPt h j' ht, if_neg (fun h1 => (not_lt.mpr hzn.le) h1.2)] at hzj'
        exact hzj' ▸ cutSet_subset_closure h ⟨t, ht, rfl⟩
    · have hzF := mem_interiorPts_of_open_rim h' hρρ' heq hzI
      rw [mergeCol_of_not_mem h (by rw [mem_ball, heq]; exact lt_irrefl ρ)] at hzj'
      exact subset_closure ⟨hzF, hzj'⟩
    · have hzc' : z ∉ closedBall v ρ := by rw [mem_closedBall, not_le]; exact hgt
      have hzF : z ∈ F.interiorPts :=
        ((open_agreesOff (X := X) (s := s) (b := b) (c := c) (up := up) (ψ := ψ) (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf)
          (hlc := hlc) h).2 z hzc').1.mpr hzI
      rw [mergeCol_of_not_mem h (fun hb => hzc' (ball_subset_closedBall hb))] at hzj'
      exact subset_closure ⟨hzF, hzj'⟩
  have : x ∈ closure (((F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
      hlc).region j) ∩ (closedBall v (ρ / 2))ᶜ) := by
    rw [mem_closure_iff_nhds] at hj ⊢
    intro t ht
    obtain ⟨y, hyt, hy⟩ := hj (t ∩ (closedBall v (ρ / 2))ᶜ) (inter_mem ht (isClosed_closedBall.isOpen_compl.mem_nhds hxU))
    exact ⟨y, hyt.1, hy, hyt.2⟩
  exact closure_minimal key isClosed_closure this

/-- **No repeated colour at a rim point** after OPEN (as for MERGE, `merge_not_hasRepeatedColour_rim`: near the rim OPEN's map is
MERGE's, the wedge, the ray and the rim arc lying in `B̄(v, ρ/2)`). -/
theorem open_not_hasRepeatedColour_rim (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) {x : ℂ} (hx : x ∈ sphere v ρ) :
    ¬ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
      hlc).HasRepeatedColour x := by
  classical
  set F' := F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc with hF'
  have hn : 0 < X.n := by have := cfg.hbn; omega
  have hn2 := cfg.two_le
  have hxv : dist x v = ρ := mem_sphere.mp hx
  have hxv' : x ≠ v := fun he => by rw [he, dist_self] at hxv; linarith [h.1]
  suffices hle : ∀ᶠ r in 𝓝[>] (0 : ℝ), ∀ c', (F'.sectorsOf x r c').encard ≤ 1 by
    rintro ⟨c', hc'⟩
    obtain ⟨r, hr2, hr1⟩ := (hc'.and hle).exists
    have := hr2.trans (hr1 c')
    norm_num at this
  -- a sector point off `B̄(v, ρ/2)` is interior to the new map
  have hsecI : ∀ i, ∀ z ∈ X.G.sector v ρ' i, ρ / 2 < ‖z - v‖ → z ∈ F'.interiorPts := fun i z hz hzr =>
    mem_open_interiorPts_of_mem h (sector_subset_interiorPts h' i hz) hzr
  -- points of a ball of radius `< ρ/2` about `x` are off `B̄(v, ρ/2)`
  have hfar : ∀ r, r ≤ ρ / 2 → ∀ z ∈ ball x r, ρ / 2 < ‖z - v‖ := fun r hr z hz => by
    rw [← dist_eq_norm]
    have := dist_triangle x z v
    rw [mem_ball, dist_comm] at hz
    linarith
  have hnear : ∀ r, r ≤ ρ' - ρ → ∀ z ∈ ball x r, ‖z - v‖ < ρ' := fun r hr z hz => by
    rw [← dist_eq_norm]
    have := dist_triangle z x v
    rw [mem_ball] at hz
    linarith
  by_cases hxI : x ∈ F.interiorPts
  · -- (R1) on no germ: one sector
    obtain ⟨i, hi⟩ : ∃ i, x ∈ X.G.sector v ρ' i := by
      have : x ∈ ball v ρ' ∩ F.interiorPts := ⟨by rw [mem_ball, hxv]; exact hρρ', hxI⟩
      rw [X.hC.cover ρ' h'.mem_Ioc hn] at this
      exact mem_iUnion.mp this
    obtain ⟨ε, hε, hεs⟩ := Metric.isOpen_iff.mp (X.hC.isOpen ρ' h'.mem_Ioc i) x hi
    filter_upwards [Ioo_mem_nhdsGT (lt_min hε (half_pos h.1))] with r hr c'
    have hU : F'.interiorPts ∩ ball x r = ball x r := by
      refine inter_eq_right.mpr fun z hz => hsecI i z (hεs (ball_subset_ball (hr.2.trans_le (min_le_left _ _)).le hz)) ?_
      exact hfar r (hr.2.trans_le (min_le_right _ _)).le z hz
    exact encard_sectorsOf_le_one (by rw [hU]; exact (convex_ball x r).isPreconnected) c'
  · -- on a germ `j`, with `p` the sector before it
    obtain ⟨j, hj⟩ := X.hC.exists_branchPt_eq hxv' (by rw [mem_ball, hxv]; exact hρρ'.trans h'.lt_r₀) hxI
    rw [← dist_eq_norm, hxv] at hj
    subst hj
    obtain ⟨p, hpj⟩ := exists_next_eq j
    have hpj' : p ≠ j := by
      intro he
      have h1 : BranchGerms.next (BranchGerms.idx p 0) = BranchGerms.idx p 1 := BranchGerms.next_idx p 0
      rw [BranchGerms.idx_zero, hpj, ← he] at h1
      exact BranchGerms.idx_ne (s := p) (show 0 < 1 by omega) (show 1 < 0 + X.n by omega) (by rw [BranchGerms.idx_zero]; exact h1)
    obtain ⟨ε, hε, hside⟩ := sides_preconnected h' h.1 hρρ' hpj hpj'
    obtain ⟨ε₁, hε₁, hball⟩ := X.hC.exists_ball_subset_of_branchPt X.hs₀.2 X.hdisj (r := ρ') ⟨h'.1, h'.2.1.le⟩ (p := p)
      ⟨h.1, hρρ'⟩
    rw [hpj] at hball
    have hpos : 0 < min (min ε ε₁) (min (ρ / 2) (ρ' - ρ)) :=
      lt_min (lt_min hε hε₁) (lt_min (half_pos h.1) (sub_pos.mpr hρρ'))
    filter_upwards [Ioo_mem_nhdsGT hpos] with r hr c'
    have hrε : r < ε := hr.2.trans_le ((min_le_left _ _).trans (min_le_left _ _))
    have hrε₁ : r < ε₁ := hr.2.trans_le ((min_le_left _ _).trans (min_le_right _ _))
    have hrρ : r ≤ ρ / 2 := (hr.2.trans_le ((min_le_right _ _).trans (min_le_left _ _))).le
    have hrρ' : r ≤ ρ' - ρ := (hr.2.trans_le ((min_le_right _ _).trans (min_le_right _ _))).le
    set x := branchPt v (X.G.β j) (X.G.κ j) ρ with hx
    have hB : ball x r ⊆ X.G.sector v ρ' p ∪ X.G.sector v ρ' j ∪ branchPt v (X.G.β j) (X.G.κ j) '' Ioo 0 ρ' :=
      (ball_subset_ball hrε₁.le).trans hball
    obtain ⟨hSp, hSj⟩ := hside r ⟨hr.1, hrε⟩
    -- a branch point of the ball is at distance in `(ρ/2, ρ')`
    have hbrt : ∀ t ∈ Ioo 0 ρ', branchPt v (X.G.β j) (X.G.κ j) t ∈ ball x r → t ∈ Ioo (ρ / 2) ρ' := by
      intro t ht hz
      have := hfar r hrρ _ hz
      rw [norm_branchPt_sub v _ _ ht.1.le] at this
      exact ⟨this, ht.2⟩
    -- the ball's points beside the germ, in the sectors, are interior to the new map
    have hSpI : X.G.sector v ρ' p ∩ ball x r ⊆ F'.interiorPts := fun z hz => hsecI p z hz.1 (hfar r hrρ z hz.2)
    have hSjI : X.G.sector v ρ' j ∩ ball x r ⊆ F'.interiorPts := fun z hz => hsecI j z hz.1 (hfar r hrρ z hz.2)
    -- a germ point of the ball is in the closure of the sector after it, inside the ball
    have hclj : ∀ t ∈ Ioo 0 ρ', branchPt v (X.G.β j) (X.G.κ j) t ∈ ball x r →
        branchPt v (X.G.β j) (X.G.κ j) t ∈ closure (X.G.sector v ρ' j ∩ ball x r) := by
      intro t ht hz
      have hcl := IsSectorChart.branchPt_mem_closure_sector_after (v := v) X.hord h'.2.1.le j ht
      rw [inter_comm]; exact isOpen_ball.inter_closure ⟨hz, hcl⟩
    have hclp : ∀ t ∈ Ioo 0 ρ', branchPt v (X.G.β j) (X.G.κ j) t ∈ ball x r →
        branchPt v (X.G.β j) (X.G.κ j) t ∈ closure (X.G.sector v ρ' p ∩ ball x r) := by
      intro t ht hz
      have hcl := IsSectorChart.branchPt_mem_closure_sector_before (v := v) X.hord h'.2.1.le p ht
      rw [hpj] at hcl
      rw [inter_comm]; exact isOpen_ball.inter_closure ⟨hz, hcl⟩
    by_cases hph : BranchGerms.Phantom X.col j
    · -- (R3) a phantom germ, cut inside `ρ`: one sector
      refine encard_sectorsOf_le_one ?_ c'
      obtain ⟨δ, hδ, hδc⟩ := Metric.continuousAt_iff.mp (continuous_branchPt v (X.G.β j) (X.G.κ j)).continuousAt r hr.1
      set t₀ := ρ - min δ (ρ / 2) / 2 with ht₀
      have hm : 0 < min δ (ρ / 2) := lt_min hδ (half_pos h.1)
      have hm' : min δ (ρ / 2) ≤ ρ / 2 := min_le_right _ _
      have ht₀ρ : t₀ < ρ := by linarith
      have ht₀2 : ρ / 2 < t₀ := by linarith
      have hy₀ : branchPt v (X.G.β j) (X.G.κ j) t₀ ∈ ball x r := by
        rw [mem_ball]; refine hδc ?_
        rw [Real.dist_eq, abs_of_neg (by linarith)]; linarith [min_le_left δ (ρ / 2)]
      have ht₀' : t₀ ∈ Ioo 0 ρ' := ⟨by linarith [h.1], ht₀ρ.trans hρρ'⟩
      have hy₀I : branchPt v (X.G.β j) (X.G.κ j) t₀ ∈ F'.interiorPts :=
        (branchPt_mem_open_interiorPts_iff h' hρρ' h j ⟨ht₀2, ht₀'.2⟩).mpr ⟨ht₀ρ, hph⟩
      set y₀ := branchPt v (X.G.β j) (X.G.κ j) t₀ with hy₀def
      have hS₁ : IsPreconnected (X.G.sector v ρ' p ∩ ball x r ∪ {y₀}) :=
        hSp.subset_closure subset_union_left (union_subset subset_closure (singleton_subset_iff.mpr (hclp t₀ ht₀' hy₀)))
      have hS₂ : IsPreconnected ({y₀} ∪ X.G.sector v ρ' j ∩ ball x r) :=
        hSj.subset_closure subset_union_right (union_subset (singleton_subset_iff.mpr (hclj t₀ ht₀' hy₀)) subset_closure)
      have hS := hS₁.union y₀ (Or.inr rfl) (Or.inl rfl) hS₂
      refine hS.subset_closure ?_ ?_
      · rintro z ((hz | rfl) | (rfl | hz))
        · exact ⟨hSpI hz, hz.2⟩
        · exact ⟨hy₀I, hy₀⟩
        · exact ⟨hy₀I, hy₀⟩
        · exact ⟨hSjI hz, hz.2⟩
      · rintro z ⟨-, hz⟩
        rcases hB hz with (hz' | hz') | ⟨t, ht, rfl⟩
        · exact subset_closure (Or.inl (Or.inl ⟨hz', hz⟩))
        · exact subset_closure (Or.inr (Or.inr ⟨hz', hz⟩))
        · exact closure_mono (subset_union_right.trans subset_union_right) (hclj t ht hz)
    · -- (R2) a non-phantom germ: two sectors, of the two colours beside it
      have hcol : X.col p ≠ X.col j := fun he => hph ⟨p, hpj, he⟩
      have hU : F'.interiorPts ∩ ball x r = ⋃ b' : Bool, cond b' (X.G.sector v ρ' p ∩ ball x r) (X.G.sector v ρ' j ∩ ball x r) := by
        rw [← union_eq_iUnion]
        ext z
        constructor
        · rintro ⟨hzI, hz⟩
          rcases hB hz with (hz' | hz') | ⟨t, ht, rfl⟩
          · exact Or.inl ⟨hz', hz⟩
          · exact Or.inr ⟨hz', hz⟩
          · exact absurd ((branchPt_mem_open_interiorPts_iff h' hρρ' h j (hbrt t ht hz)).mp hzI).2 hph
        · rintro (hz | hz)
          · exact ⟨hSpI hz, hz.2⟩
          · exact ⟨hSjI hz, hz.2⟩
      rw [encard_sectorsOf_of_partition (colA := fun b' => cond b' (X.col p) (X.col j)) hU ?_ ?_ ?_ ?_ ?_ c']
      · rw [Set.encard_le_one_iff]
        rintro b₁ b₂ ⟨-, h₁⟩ ⟨-, h₂⟩
        cases b₁ <;> cases b₂ <;> simp only [cond_true, cond_false] at h₁ h₂ ⊢
        · exact (hcol (h₂.trans h₁.symm)).elim
        · exact (hcol (h₁.trans h₂.symm)).elim
      · intro b'; cases b'
        · exact (X.hC.isOpen ρ' h'.mem_Ioc j).inter isOpen_ball
        · exact (X.hC.isOpen ρ' h'.mem_Ioc p).inter isOpen_ball
      · intro b'; cases b'
        · exact hSj
        · exact hSp
      · intro b₁ b₂ hb
        have hd := (X.hC.disjoint ρ' h'.mem_Ioc p j hpj').mono (inter_subset_left (t := ball x r))
          (inter_subset_left (t := ball x r))
        cases b₁ <;> cases b₂
        · exact absurd rfl hb
        · exact hd.symm
        · exact hd
        · exact absurd rfl hb
      · intro b' _; cases b'
        · exact hclj ρ ⟨h.1, hρρ'⟩ (mem_ball_self hr.1)
        · exact hclp ρ ⟨h.1, hρρ'⟩ (mem_ball_self hr.1)
      · intro b' z hz; cases b'
        · show X.G.openCol v X.col F.col up s b ψ c ρ z = X.col j
          exact openCol_of_mem_sector_out h' h hz.1 (hfar r hrρ z hz.2)
        · show X.G.openCol v X.col F.col up s b ψ c ρ z = X.col p
          exact openCol_of_mem_sector_out h' h hz.1 (hfar r hrρ z hz.2)

/-- **The rim**: near a point of `∂B(v, ρ)` the new map is MERGE's (the wedge, the ray and the rim arc lie inside `B̄(v, ρ/2)`), so
the point carries at most three colours, none repeated. -/
theorem open_rim (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ)
    (_hρc : ρ ≤ ρc) :
    ∀ x ∈ sphere v ρ,
      ((F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).coloursAt
        x).ncard ≤ 3 ∧
      ¬ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
        hlc).HasRepeatedColour x := by
  intro x hx
  have hn : 0 < X.n := by have := cfg.hbn; omega
  refine ⟨?_, open_not_hasRepeatedColour_rim cfg h' hρρ' h hx⟩
  have hxv : x ≠ v := fun hxv => by rw [hxv, mem_sphere, dist_self] at hx; linarith [h.1]
  have hxs : x ∈ ball v X.s₀ := by rw [mem_ball, mem_sphere.mp hx]; exact h.2.1
  exact (ncard_le_ncard (open_coloursAt_rim h' hρρ' h hn hx) (toFinite _)).trans
    ((X.hC.ncard_coloursAt_le_two X.hs₀ X.hdisj hxv hxs).trans (by norm_num))

/-- **A point of a chart sector off the partial sector and off the gap is interior to OPEN's map** (it is interior to `F`; the rim
arc runs through gap sectors, the ray and the wedge's rim arc through the partial sector or on its gap germ). -/
theorem mem_open_interiorPts_of_sector_off (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (hρc : ρ ≤ ρc) {i : Fin X.n}
    (hi : i ≠ BranchGerms.idx s (BranchGerms.rayPos up b)) (hig : i ∉ BranchGerms.gapSec s 0 b) {z : ℂ}
    (hz : z ∈ X.G.sector v ρ i) :
    z ∈ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).interiorPts := by
  have hzb : z ∈ ball v ρ := by rw [mem_ball, dist_eq_norm]; exact (norm_of_mem_sector hz).2
  refine (mem_open_interiorPts_iff h hzb).mpr fun hzA => ?_
  have hzF := sector_subset_interiorPts h i hz
  have hρ2 : ρ / 2 ∈ Ioo 0 ρ := ⟨by linarith [h.1], by linarith [h.1]⟩
  have hρ2c : ρ / 2 ∈ Ioo 0 ρc := ⟨hρ2.1, hρ2.2.trans_le hρc⟩
  obtain ⟨A, hA, hzA'⟩ := mem_iUnion₂.mp hzA
  rcases hA with hA | rfl | rfl
  · rcases mergeArcs_cases h hA with ⟨j, hj⟩ | ⟨-, rfl⟩
    · exact hzF.2 (germ_subset_Γ h j (hj hzA')).2
    · exact hig (gapSec_of_mem_rimArc h (by have := cfg.hb1; omega) hz hzA')
  · obtain ⟨t, ht, rfl⟩ := eq_of_mem_openRay h.1 hzA'
    have ht0 := (norm_of_mem_sector hz).1
    rw [add_sub_cancel_left, norm_mul_e ht.1] at ht0
    have hray : v + (t : ℂ) * e ψ ∈ X.G.sector v ρ (BranchGerms.idx s (BranchGerms.rayPos up b)) :=
      (X.G.mem_sector_idx s _).mpr ⟨t, ⟨ht0, by linarith [ht.2, h.1]⟩, ψ,
        cfg.ray t ⟨ht0, by linarith [ht.2, h.1, hρc]⟩, rfl⟩
    exact hi (sector_disjoint h hz hray)
  · have hray := cfg.ray (ρ / 2) hρ2c
    cases up
    · simp only [BranchGerms.openRim, Bool.false_eq_true, if_false] at hzA'
      simp only [BranchGerms.rayPos, Bool.false_eq_true, if_false, zero_add] at hray hi
      obtain ⟨θ, hθ, rfl⟩ := hzA'
      rcases eq_or_lt_of_le hθ.2 with he | hlt
      · rw [he] at hz; beta_reduce at hz; rw [← X.G.branchPt_idx] at hz
        exact branchPt_not_mem_sector h _ hρ2 i hz
      · exact hi (sector_disjoint h hz ((X.G.mem_sector_idx s 0).mpr
          ⟨ρ / 2, hρ2, θ, ⟨hray.1.trans_le hθ.1, by simpa using hlt⟩, rfl⟩))
    · simp only [BranchGerms.openRim, if_true] at hzA'
      simp only [BranchGerms.rayPos, if_true] at hray hi
      obtain ⟨θ, hθ, rfl⟩ := hzA'
      rcases eq_or_lt_of_le hθ.1 with he | hlt
      · rw [← he] at hz; beta_reduce at hz; rw [← X.G.branchPt_idx] at hz
        exact branchPt_not_mem_sector h _ hρ2 i hz
      · exact hi (sector_disjoint h hz ((X.G.mem_sector_idx s b).mpr
          ⟨ρ / 2, hρ2, θ, ⟨hlt, hθ.2.trans_lt hray.2⟩, rfl⟩))

/-- **`F`'s colour class of `c` survives OPEN**: inside `B(v, ρ)` its points are the horn's (`lone`), interior to the new map and
still coloured `c` (the horn is no gap sector and misses the wedge); outside, the maps agree. -/
theorem open_region_of_region (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (hρc : ρ ≤ ρc) {z : ℂ} (hz : z ∈ F.region c) :
    z ∈ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).region c := by
  have hn : 0 < X.n := by have := cfg.hbn; omega
  have hzc : F.col z = c := hz.2
  obtain ⟨hhr, hhg, -⟩ := cfg.idx_facts
  by_cases hzb : z ∈ ball v ρ
  · have hzv : z ≠ v := fun he => hz.1.2 (he ▸ (X.mem_Γ hn).2)
    rcases ball_cases h hn hzb hzv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
    · have hic : X.col i = c := by rw [← (X.hcol i ρ h.mem_Ioc hi).2, hzc]
      obtain rfl := cfg.lone i hic
      refine ⟨mem_open_interiorPts_of_sector_off cfg h hρc hhr hhg hi, ?_⟩
      show X.G.openCol v X.col F.col up s b ψ c ρ z = c
      have hzW : z ∉ X.G.openWedge v up s b ψ ρ := fun hW =>
        hhr (sector_disjoint h hi (openWedge_subset_sector cfg h hρc hW))
      rw [openCol_of_not_mem hzW, mergeCol_of_mem_sector h hi]
      split_ifs <;> [rfl; exact hic]
    · exact absurd (X.hC.branchPt_mem_Γ j ⟨ht.1, ht.2.trans h.lt_r₀⟩).2 hz.1.2
  · have hzr : ρ / 2 < ‖z - v‖ := by rw [mem_ball, dist_eq_norm, not_lt] at hzb; linarith [h.1]
    refine ⟨mem_open_interiorPts_of_mem h hz.1 hzr, ?_⟩
    show X.G.openCol v X.col F.col up s b ψ c ρ z = c
    rw [openCol_of_not_mem (fun hW => hzb (ball_subset_ball (by linarith [h.1])
      (X.G.openWedge_subset_ball v up s b ψ ρ hW))), mergeCol_of_not_mem h hzb]
    exact hzc

/-- **OPEN's colour class of `c`**: each of its points is in `F`'s class, in the wedge, in the gap out to `ρ/2`, or a cut branch point
inside `ρ` of a germ with `c` after it (MERGE's `merge_region_cases`, the wedge in front). -/
theorem open_region_cases (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) {z : ℂ}
    (hz : z ∈ (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).region c) :
    z ∈ F.region c ∨ z ∈ X.G.openWedge v up s b ψ ρ ∨ z ∈ X.G.gapSet v s 0 b (ρ / 2) ∨
      ∃ j, X.col j = c ∧ ∃ t ∈ Ioo 0 ρ, z = branchPt v (X.G.β j) (X.G.κ j) t := by
  have hn : 0 < X.n := by have := cfg.hbn; omega
  obtain ⟨hzI, hzc⟩ := hz
  have hzc' : X.G.openCol v X.col F.col up s b ψ c ρ z = c := hzc
  by_cases hzW : z ∈ X.G.openWedge v up s b ψ ρ
  · exact Or.inr (Or.inl hzW)
  rw [openCol_of_not_mem hzW] at hzc'
  rcases lt_trichotomy (dist z v) ρ with hlt | heq | hgt
  · have hzv : z ≠ v := by
      rintro rfl; exact (mem_open_interiorPts_iff h hlt).mp hzI v_mem_openArcs
    rcases ball_cases h hn hlt hzv with ⟨i, hi⟩ | ⟨j, t, ht, rfl⟩
    · rw [mergeCol_of_mem_sector h hi] at hzc'
      split_ifs at hzc' with hg
      · exact Or.inr (Or.inr (Or.inl ((mem_gapSet_of_mem_sector h (by linarith [h.1]) hi).mpr hg)))
      · left
        have h1 : F.col z = X.col i := (X.hcol i ρ h.mem_Ioc hi).2
        exact ⟨sector_subset_interiorPts h i hi, by show F.col z = c; rw [h1, hzc']⟩
    · rw [mergeCol_branchPt h j ht] at hzc'
      split_ifs at hzc' with hg
      · exact Or.inr (Or.inr (Or.inl ((branchPt_mem_gapSet_iff h (by linarith [h.1]) j ht).mpr hg)))
      · exact Or.inr (Or.inr (Or.inr ⟨j, hzc', t, ht, rfl⟩))
  · left
    refine ⟨mem_interiorPts_of_open_rim h' hρρ' heq hzI, ?_⟩
    show F.col z = c
    rw [← mergeCol_of_not_mem h (c := c) (s := s) (a := 0) (b := b) (by rw [mem_ball, heq]; exact lt_irrefl ρ)]
    exact hzc'
  · left
    have hzc2 : z ∉ closedBall v ρ := by rw [mem_closedBall, not_le]; exact hgt
    have hA' := (open_agreesOff (X := X) (s := s) (b := b) (c := c) (up := up) (ψ := ψ) (hv := hv) (hρ := hρ) (hA := hA)
      (hAf := hAf) (hlc := hlc) h).2 z hzc2
    refine ⟨hA'.1.mpr hzI, ?_⟩
    show F.col z = c
    rw [hA'.2]; exact hzc

/-- **OPEN's colour class of `c`** lies in the closure of `F`'s, the gap out to `ρ/2` and the wedge. -/
theorem open_region_subset (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).region c ⊆
      closure (F.region c) ∪ (X.G.gapSet v s 0 b (ρ / 2) ∪ X.G.openWedge v up s b ψ ρ) := by
  intro z hz
  rcases open_region_cases cfg h' hρρ' h hz with h1 | h1 | h1 | ⟨j, hj, t, ht, rfl⟩
  · exact Or.inl (subset_closure h1)
  · exact Or.inr (Or.inr h1)
  · exact Or.inr (Or.inl h1)
  · exact Or.inl (hj ▸ cutSet_subset_closure h ⟨t, ht, rfl⟩)

/-- **The contacts of `c` at a point off `B̄(v, ρ)` are unchanged by OPEN**: `F`'s class lies in the new one, and a closure point of
the new class off the closure of `F`'s is `v` (in the closure of `F`'s class) or a point of the open clear set
(`OpenConfig.exists_clearSet`), at distance `≠ 1` from every closure point of `F`'s class. -/
theorem open_isContact_iff (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) (hρc : ρ ≤ ρc) {v' : ℂ} (hv' : v' ∉ closedBall v ρ) (w : ℂ) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).IsContact v' c w ↔
      F.IsContact v' c w := by
  obtain ⟨U, hUo, hUc, hUb, hUg, hUw⟩ := cfg.exists_clearSet hF h hρc
  have hcl : closure ((F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
      hlc).region c) ⊆ closure (F.region c) ∪ ({v} ∪ U) := by
    refine (closure_mono (open_region_subset cfg h' hρρ' h)).trans ?_
    rw [closure_union, closure_closure, closure_union]
    exact union_subset_union_right _ (union_subset hUg hUw)
  have hvF := cfg.v_mem_closure_region h
  constructor
  · rintro ⟨hc', hd, hw'⟩
    have hc : c ∈ F.coloursAt v' := by
      rcases hcl hc' with h1 | h1 | h1
      · exact h1
      · exact absurd (by rw [mem_singleton_iff.mp h1]; exact mem_closedBall_self h.1.le) hv'
      · exact absurd (ball_subset_closedBall (hUb h1)) hv'
    refine ⟨hc, hd, ?_⟩
    rcases hcl hw' with h1 | h1 | h1
    · exact h1
    · rw [mem_singleton_iff.mp h1]; exact hvF
    · exact absurd hd (dist_ne_one_of_isOpen_isClear hUo hUc h1 hc)
  · rintro ⟨hc, hd, hw⟩
    exact ⟨closure_mono (fun z hz => open_region_of_region cfg h hρc hz) hc, hd,
      closure_mono (fun z hz => open_region_of_region cfg h hρc hz) hw⟩

/-- **Each `c`-tile of `F` lies in a `c`-tile of OPEN's map.** -/
theorem open_exists_tile (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (hρc : ρ ≤ ρc) {T : Set ℂ} (hT : F.TileOf c T) :
    ∃ T', (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).TileOf c T' ∧
      T ⊆ T' := by
  set F' := F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc with hF'
  obtain ⟨y, hy⟩ := hT.1.nonempty
  have hreg : ∀ z ∈ T, z ∈ F'.region c := fun z hz => open_region_of_region cfg h hρc (hT.subset_region hz)
  have hyI := (hreg y hy).1
  refine ⟨_, ?_, hT.1.isPreconnected.subset_connectedComponentIn hy fun z hz => (hreg z hz).1⟩
  have hT1 : F'.IsTile (connectedComponentIn F'.interiorPts y) := ⟨y, hyI, rfl⟩
  have h1 := hT1.tileOf (mem_connectedComponentIn hyI)
  rwa [show F'.col y = c from (hreg y hy).2] at h1

/-- **A `c`-tile of OPEN's map lies inside or outside the unit circle about a point of the closure of its colour class** (the new map
is valid, `open_valid`). -/
theorem open_tile_split (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) (hρc : ρ ≤ ρc) {T' : Set ℂ}
    (hT' : (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).TileOf c T')
    {v' : ℂ}
    (hv' : v' ∈ closure ((F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
      hlc).region c)) :
    T' ⊆ ball v' 1 ∨ Disjoint T' (closedBall v' 1) := by
  have hval := open_valid (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf) (hlc := hlc) hF cfg h' hρρ' h hρc
  have hne : ∀ z ∈ T', dist v' z ≠ 1 := fun z hz => by
    rw [dist_comm]; exact ne1_region hval hv' (hT'.subset_region hz)
  rcases preconnected_dist_lt_or_gt hT'.1.isPreconnected hne with h1 | h1
  · left; intro z hz; rw [mem_ball, dist_comm]; exact h1 z hz
  · right; rw [disjoint_left]; intro z hz hz'; rw [mem_closedBall, dist_comm] at hz'; linarith [h1 z hz]

/-- **A `c`-tile of OPEN's map at `v` holds the horn's sector** (so `v` is in the closure of its part in `F`'s class): near `v` its
points are in OPEN's sectors (`open_partition`) of colour `c`, which is the merged piece alone, and the piece, preconnected and in the
new interior, lies in the tile and holds the horn's sector. -/
theorem v_mem_closure_open_tile (cfg : X.OpenConfig c up s b ψ ρc) (h : X.Small ρ) (hρc : ρ ≤ ρc) {T' : Set ℂ}
    (hT' : (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).TileOf c T')
    (hvT : v ∈ closure T') : v ∈ closure (T' ∩ F.region c) := by
  have hρ2 : ρ / 2 ≤ ρ := by linarith [h.1]
  have hr : ρ / 2 ∈ Ioc 0 (ρ / 2) := ⟨h.half.1, le_rfl⟩
  have hr2 : ρ / 2 ∈ Ioc 0 X.r₀ := ⟨h.half.1, hρ2.trans h.lt_r₀.le⟩
  have hr2c : ρ / 2 ≤ ρc := hρ2.trans hρc
  obtain ⟨hhr, -, hrg⟩ := cfg.idx_facts
  have hpart := open_partition (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf) (hlc := hlc) cfg h hρc hr
  obtain ⟨z, hzb, hzT⟩ := mem_closure_iff.mp hvT (ball v (ρ / 2)) isOpen_ball (mem_ball_self h.half.1)
  have hzI := (hT'.subset_region hzT).1
  have hzc : X.G.openCol v X.col F.col up s b ψ c ρ z = c := (hT'.subset_region hzT).2
  have hzr : ‖z - v‖ < ρ / 2 := by rw [← dist_eq_norm]; exact hzb
  have hzU : z ∈ ⋃ i, openSectors X up s b ψ (ρ / 2) i := by rw [← hpart]; exact ⟨hzI, hzb⟩
  obtain ⟨i, hi⟩ := mem_iUnion.mp hzU
  -- a point of a sector of `F` off the partial sector and the gap, at colour `c`, is in the horn's sector
  have hoff : ∀ i', z ∈ X.G.sector v ρ i' → i' ≠ BranchGerms.idx s (BranchGerms.rayPos up b) →
      i' ∉ BranchGerms.gapSec s 0 b → i' = BranchGerms.idx s (BranchGerms.hornPos up b) := fun i' hi' hir hig => by
    have hzW : z ∉ X.G.openWedge v up s b ψ ρ := fun hW => hir (sector_disjoint h hi' (openWedge_subset_sector cfg h hρc hW))
    rw [openCol_of_not_mem hzW, mergeCol_of_mem_sector h hi', if_neg (fun h1 => hig h1.1)] at hzc
    exact cfg.lone i' hzc
  have hzP : z ∈ X.G.openPiece v up s b ψ (ρ / 2) := by
    rcases openSectors_cases (X := X) (s := s) (b := b) up ψ (ρ / 2) i with ⟨-, h1⟩ | ⟨h1, h2, h3⟩ | ⟨-, -, -, h3⟩ |
      ⟨h1, h2, h3, h4⟩
    · rwa [h1] at hi
    · rw [h3] at hi
      have hzs := sector_mono hρ2 _ (cfg.rest_subset_sector hr2c hi)
      have hzW : z ∉ X.G.openWedge v up s b ψ ρ := fun hW =>
        disjoint_left.mp (disjoint_openWedge_openRest cfg h) hW (X.G.mem_openRest_of_lt hi (by linarith [h.1]))
      rw [openCol_of_not_mem hzW, mergeCol_of_mem_sector h hzs, if_neg (fun h1 => hrg h1.1)] at hzc
      exact absurd (cfg.lone _ hzc) (fun he => hhr he.symm)
    · rw [h3] at hi; exact absurd hi (notMem_empty z)
    · rw [h4] at hi
      exact absurd (hoff i (sector_mono hρ2 _ hi) h2 h3) h1
  have hPI : X.G.openPiece v up s b ψ (ρ / 2) ⊆
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).interiorPts :=
    fun y hy => by
      have hy' : y ∈ ⋃ i, openSectors X up s b ψ (ρ / 2) i := by
        refine mem_iUnion.mpr ⟨BranchGerms.idx s (BranchGerms.hornPos up b), ?_⟩
        rcases openSectors_cases (X := X) (s := s) (b := b) up ψ (ρ / 2) (BranchGerms.idx s (BranchGerms.hornPos up b)) with
          ⟨-, h1⟩ | ⟨h1, -⟩ | ⟨h1, -⟩ | ⟨h1, -⟩
        · rw [h1]; exact hy
        all_goals exact absurd rfl h1
      rw [← hpart] at hy'
      exact hy'.1
  have hsub : X.G.openPiece v up s b ψ (ρ / 2) ⊆ T' :=
    hT'.1.subset_of_preconnected (cfg.isPreconnected_piece_rest hr2c).1 hPI hzP hzT
  exact closure_mono (s := X.G.sector v (ρ / 2) (BranchGerms.idx s (BranchGerms.hornPos up b))) (t := T' ∩ F.region c)
    (fun _ hy => ⟨hsub (cfg.horn_subset_piece hr2c hy), cfg.col_horn ▸ X.hcol _ (ρ / 2) hr2 hy⟩)
    (X.hC.mem_closure_sector hr2 _)

/-- **A `c`-tile of OPEN's map at a contact holds a `c`-tile of `F` at that contact** (MERGE's `merge_tile_cover` with the wedge added):
the new tile's points are in the closure of its part in `F`'s class, the gap out to `ρ/2` or the wedge; the closures of the last two lie
in `{v}` (handled by `v_mem_closure_open_tile`) and the open clear set, which meets no unit circle about a point of the class's closure;
and the new tile holds finitely many tiles of `F`. -/
theorem open_tile_cover (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) (hρc : ρ ≤ ρc) {T' : Set ℂ}
    (hT' : (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).TileOf c T')
    {v' w : ℂ} (hv' : v' ∈ closure (F.region c)) (hw : dist w v' = 1) (hwT : w ∈ closure T') :
    ∃ T, F.TileOf c T ∧ T ⊆ T' ∧ w ∈ closure T := by
  set F' := F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc with hF'
  have hreg : ∀ z ∈ F.region c, z ∈ F'.region c := fun z hz => open_region_of_region cfg h hρc hz
  -- each `c`-tile of `F` meeting `T'` lies in it
  have hsubT : ∀ T, F.TileOf c T → (T ∩ T').Nonempty → T ⊆ T' := fun T hT ⟨y, hyT, hyT'⟩ =>
    hT'.1.subset_of_preconnected hT.1.isPreconnected (fun z hz => (hreg z (hT.subset_region hz)).1) hyT hyT'
  by_cases hTB : (T' ∩ closedBall v ρ).Nonempty
  swap
  · -- `T'` misses the disc: it is a tile of `F`
    obtain ⟨y, hy⟩ := hT'.1.nonempty
    have hsubF : T' ⊆ F.region c := fun z hz => by
      have hzc : z ∉ closedBall v ρ := fun hzc => hTB ⟨z, hz, hzc⟩
      have hA' := (open_agreesOff (X := X) (s := s) (b := b) (c := c) (up := up) (ψ := ψ) (hv := hv) (hρ := hρ) (hA := hA)
        (hAf := hAf) (hlc := hlc) h).2 z hzc
      refine ⟨hA'.1.mpr (hT'.subset_region hz).1, ?_⟩
      show F.col z = c
      rw [hA'.2]; exact (hT'.subset_region hz).2
    obtain ⟨hT0, hyT0⟩ := tileOf_component (hsubF hy)
    have h1 : T' ⊆ connectedComponentIn F.interiorPts y :=
      hT0.1.subset_of_preconnected hT'.1.isPreconnected (fun z hz => (hsubF hz).1) hy hyT0
    have h2 := hsubT _ hT0 ⟨y, hyT0, hy⟩
    exact ⟨_, hT0, h2, (Subset.antisymm h1 h2) ▸ hwT⟩
  obtain ⟨U, hUo, hUc, -, hUg, hUw⟩ := cfg.exists_clearSet hF h hρc
  -- (1) the new tile lies in the closure of its part in `F`'s class, the gap and the wedge
  have hstep1 : T' ⊆ closure (T' ∩ F.region c) ∪ (X.G.gapSet v s 0 b (ρ / 2) ∪ X.G.openWedge v up s b ψ ρ) := by
    intro z hz
    rcases open_region_cases cfg h' hρρ' h (hT'.subset_region hz) with h1 | h1 | h1 | ⟨j, hj, t, ht, rfl⟩
    · exact Or.inl (subset_closure ⟨hz, h1⟩)
    · exact Or.inr (Or.inr h1)
    · exact Or.inr (Or.inl h1)
    · left
      obtain ⟨δ, hδ, hδI⟩ := Metric.isOpen_iff.mp F'.isOpen_interiorPts _ (hT'.subset_region hz).1
      have hball : ball (branchPt v (X.G.β j) (X.G.κ j) t) δ ⊆ T' :=
        hT'.1.subset_of_preconnected (convex_ball _ δ).isPreconnected hδI (mem_ball_self hδ) hz
      have hcl := IsSectorChart.branchPt_mem_closure_sector_after (v := v) X.hord h.2.1.le j ht
      refine closure_mono ?_ (isOpen_ball.inter_closure ⟨mem_ball_self hδ, hcl⟩)
      rintro y ⟨hy1, hy2⟩
      exact ⟨hball hy1, hj ▸ X.hcol j ρ h.mem_Ioc hy2⟩
  -- (2) the contact is a closure point of that part
  have hwF : w ∈ closure (T' ∩ F.region c) := by
    have hw2 : w ∈ closure (T' ∩ F.region c) ∪ (closure (X.G.gapSet v s 0 b (ρ / 2)) ∪
        closure (X.G.openWedge v up s b ψ ρ)) := by
      have := closure_mono hstep1 hwT
      rwa [closure_union, closure_closure, closure_union] at this
    rcases hw2 with hw2 | hw2
    · exact hw2
    · rcases (union_subset hUg hUw) hw2 with hwv | hwU
      · rw [mem_singleton_iff.mp hwv] at hwT ⊢
        exact v_mem_closure_open_tile cfg h hρc hT' hwT
      · exact absurd hw (dist_ne_one_of_isOpen_isClear hUo hUc hwU hv')
  -- (3) finitely many tiles of `F` cover that part
  set S := {T | F.TileOf c T ∧ T ⊆ T'} with hS
  have hcov : T' ∩ F.region c ⊆ ⋃ T ∈ S, T := by
    rintro z ⟨hzT, hzF⟩
    obtain ⟨hTz, hzTz⟩ := tileOf_component hzF
    exact mem_iUnion₂.mpr ⟨_, ⟨hTz, hsubT _ hTz ⟨z, hzTz, hzT⟩⟩, hzTz⟩
  have hr₁ : ρ < (ρ + X.ρ₀) / 2 := by linarith [h.2.2.1]
  have hfin : S.Finite := by
    refine (finite_tiles_ball_of_goodAt X.hG (r := (ρ + X.ρ₀) / 2) (by linarith [h.1]) (by linarith [h.2.2.1])).subset ?_
    rintro T ⟨hT, hTT'⟩
    refine ⟨hT.1, ?_⟩
    by_contra hTn
    have hT'U : T' ⊆ T ∪ (closure T)ᶜ := by
      intro z hz
      by_cases hzT : z ∈ T
      · exact Or.inl hzT
      · right
        intro hzc
        by_cases hzb : z ∈ ball v ((ρ + X.ρ₀) / 2)
        · obtain ⟨y, hyb, hyT⟩ := mem_closure_iff.mp hzc _ isOpen_ball hzb
          exact hTn ⟨y, hyT, hyb⟩
        · have hzcb : z ∉ closedBall v ρ := fun h1 => hzb (closedBall_subset_ball hr₁ h1)
          have hA' := (open_agreesOff (X := X) (s := s) (b := b) (c := c) (up := up) (ψ := ψ) (hv := hv) (hρ := hρ) (hA := hA)
            (hAf := hAf) (hlc := hlc) h).2 z hzcb
          exact hzT (hT.1.mem_of_mem_closure (hA'.1.mpr (hT'.subset_region hz).1) hzc)
    rcases hT'.1.isPreconnected.subset_or_subset hT.1.isOpen isClosed_closure.isOpen_compl
        (disjoint_compl_right.mono_right (compl_subset_compl.mpr subset_closure)) hT'U with h1 | h1
    · obtain ⟨z, hzT', hzc⟩ := hTB
      exact hTn ⟨z, h1 hzT', closedBall_subset_ball hr₁ hzc⟩
    · obtain ⟨y, hy⟩ := hT.1.nonempty
      exact h1 (hTT' hy) (subset_closure hy)
  have : w ∈ ⋃ T ∈ S, closure T := by rw [← hfin.closure_biUnion]; exact closure_mono hcov hwF
  obtain ⟨T, hT, hwT⟩ := mem_iUnion₂.mp this
  exact ⟨T, hT.1, hT.2, hwT⟩

/-- **The in-type contacts of `c` at a contact of `F` are unchanged by OPEN.** -/
theorem open_inType_iff (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) (hρc : ρ ≤ ρc) {v' w : ℂ} (hw : F.IsContact v' c w) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).InType v' c w ↔
      F.InType v' c w := by
  have hv'' : v' ∈ closure ((F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA
      hAf hlc).region c) :=
    closure_mono (fun z hz => open_region_of_region cfg h hρc hz) hw.1
  constructor
  · intro hin T hT hwT
    obtain ⟨T', hT', hTT'⟩ := open_exists_tile (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf) (hlc := hlc) cfg h hρc hT
    exact hTT'.trans (hin T' hT' (closure_mono hTT' hwT))
  · intro hin T' hT' hwT'
    obtain ⟨T, hT, hTT', hwT⟩ := open_tile_cover hF cfg h' hρρ' h hρc hT' hw.1 hw.2.1 hwT'
    obtain ⟨y, hy⟩ := hT.1.nonempty
    rcases open_tile_split hF cfg h' hρρ' h hρc hT' hv'' with h1 | h1
    · exact h1
    · exact absurd (ball_subset_closedBall (hin T hT hwT hy)) (disjoint_left.mp h1 (hTT' hy))

/-- **The out-type contacts of `c` at a contact of `F` are unchanged by OPEN.** -/
theorem open_outType_iff (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) (hρc : ρ ≤ ρc) {v' w : ℂ} (hw : F.IsContact v' c w) :
    (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf hlc).OutType v' c w ↔
      F.OutType v' c w := by
  have hv'' : v' ∈ closure ((F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA
      hAf hlc).region c) :=
    closure_mono (fun z hz => open_region_of_region cfg h hρc hz) hw.1
  constructor
  · intro hout T hT hwT
    obtain ⟨T', hT', hTT'⟩ := open_exists_tile (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf) (hlc := hlc) cfg h hρc hT
    exact (hout T' hT' (closure_mono hTT' hwT)).mono_left hTT'
  · intro hout T' hT' hwT'
    obtain ⟨T, hT, hTT', hwT⟩ := open_tile_cover hF cfg h' hρρ' h hρc hT' hw.1 hw.2.1 hwT'
    obtain ⟨y, hy⟩ := hT.1.nonempty
    rcases open_tile_split hF cfg h' hρρ' h hρc hT' hv'' with h1 | h1
    · exact absurd (ball_subset_closedBall (h1 (hTT' hy))) (disjoint_left.mp (hout T hT hwT) hy)
    · exact h1

/-- **`D_c(v′)` is unchanged off the disc** (`merge_allowedCone`'s route): the recoloured set's closure lies in `{v}` and an open
set of points clear for `c`, so no contact of `c` moves (`dist_ne_one_of_isOpen_isClear`), and the tiles keep their types. -/
theorem open_allowedCone (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
    (h : X.Small ρ) (hρc : ρ ≤ ρc) :
    ∀ v' ∉ closedBall v ρ,
      (F.surgery v ρ (X.G.openArcs v X.col up s b ψ ρ) (X.G.openCol v X.col F.col up s b ψ c ρ) hv hρ hA hAf
        hlc).allowedCone v' c = F.allowedCone v' c := by
  intro v' hv'
  have hci := open_isContact_iff (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf) (hlc := hlc) hF cfg h' hρρ' h hρc hv'
  have hin := fun {w : ℂ} (hw : F.IsContact v' c w) => open_inType_iff (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf)
    (hlc := hlc) hF cfg h' hρρ' h hρc hw
  have hout := fun {w : ℂ} (hw : F.IsContact v' c w) => open_outType_iff (hv := hv) (hρ := hρ) (hA := hA) (hAf := hAf)
    (hlc := hlc) hF cfg h' hρρ' h hρc hw
  ext d
  constructor
  · intro hd w hw
    obtain ⟨h1, h2⟩ := hd w ((hci w).mpr hw)
    exact ⟨fun hi => h1 ((hin hw).mpr hi), fun ho => h2 ((hout hw).mpr ho)⟩
  · intro hd w hw'
    have hw := (hci w).mp hw'
    obtain ⟨h1, h2⟩ := hd w hw
    exact ⟨fun hi => h1 ((hin hw).mp hi), fun ho => h2 ((hout hw).mp ho)⟩

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
