import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.ValidMap.Contact
import Mathlib.Analysis.Real.Cardinality

/-!
# The seven-brick map's local structure (wave 5's brick infrastructure, job FS131-I5c)

The point classification of `sevenBrickMap` (`Plane/SVMap`) that wave 5's two seven-colour inhabitants read
(`sevenBrickMap_isTerminalMap` in `Plane/ValidMap/Terminal`, `not_row134BaseUA_seven` in `Plane/ValidMap/Dense`):

* **the cells**: the interior points are the open cells `brickCell c r` (`sevenBrick_mem_interiorPts`), open, convex and pairwise disjoint;
  the tiles are the cells (`sevenBrick_isTile_iff`);
* **the colour of a cell** is `(c + 3 r) mod 7` (`sevenBrick_col_val`), and two distinct cells whose closures share a point differ in
  colour (`brickCell_eq_of_closure`): their offsets are the six neighbours of the brick lattice, and `c + 3 r` moves by `±1`, `±2` or `±3`;
* **the cells at a point**: at most three cells have a given point in their closure (`encard_brickCellsAt_le`, by `2 c + r`, which separates them
  and spans at most three consecutive values), and the sectors at `v` of any radius are the cells at `v` cut by the ball
  (`sevenBrick_isSector_iff`) — so no colour has two sectors (`sevenBrick_sectorsOf_subsingleton`), the degree is at most three, and so is the
  number of colours (`sevenBrick_ncard_coloursAt_le`);
* **no curved boundary**: the edges lie on the lines `im ∈ (3/5)ℤ` and `re ∈ (2/5)ℤ`, which meet a circle in countably many points, so no arc of
  a circle of positive length lies in `Γ` (`sevenBrick_not_isRingArc`), and no horn exists (`sevenBrick_not_isHorn`: one of its bounding arcs is
  curved and would lie in `Γ`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Cells -/

/-- The open cell `(c, r)` of the seven-brick colouring: abscissa in `(2/5 r + 4/5 c, 2/5 r + 4/5 c + 4/5)`, height in `(3/5 r, 3/5 r + 3/5)`. -/
def brickCell (c r : ℤ) : Set ℂ :=
  Ioo (2 / 5 * (r : ℝ) + 4 / 5 * c) (2 / 5 * r + 4 / 5 * c + 4 / 5) ×ℂ Ioo (3 / 5 * (r : ℝ)) (3 / 5 * r + 3 / 5)

theorem mem_brickCell {c r : ℤ} {z : ℂ} : z ∈ brickCell c r ↔
    (2 / 5 * (r : ℝ) + 4 / 5 * c < z.re ∧ z.re < 2 / 5 * r + 4 / 5 * c + 4 / 5) ∧
      (3 / 5 * (r : ℝ) < z.im ∧ z.im < 3 / 5 * r + 3 / 5) := Iff.rfl

theorem isOpen_brickCell (c r : ℤ) : IsOpen (brickCell c r) := isOpen_Ioo.reProdIm isOpen_Ioo

theorem convex_brickCell (c r : ℤ) : Convex ℝ (brickCell c r) :=
  ((convex_Ioo _ _).linear_preimage Complex.reLm).inter ((convex_Ioo _ _).linear_preimage Complex.imLm)

theorem closure_brickCell (c r : ℤ) : closure (brickCell c r) =
    Icc (2 / 5 * (r : ℝ) + 4 / 5 * c) (2 / 5 * r + 4 / 5 * c + 4 / 5) ×ℂ Icc (3 / 5 * (r : ℝ)) (3 / 5 * r + 3 / 5) := by
  rw [brickCell, closure_reProdIm, closure_Ioo (by linarith), closure_Ioo (by linarith)]

theorem mem_closure_brickCell {c r : ℤ} {z : ℂ} : z ∈ closure (brickCell c r) ↔
    (2 / 5 * (r : ℝ) + 4 / 5 * c ≤ z.re ∧ z.re ≤ 2 / 5 * r + 4 / 5 * c + 4 / 5) ∧
      (3 / 5 * (r : ℝ) ≤ z.im ∧ z.im ≤ 3 / 5 * r + 3 / 5) := by
  rw [closure_brickCell]; exact Iff.rfl

/-- Two cells sharing a point are the same cell. -/
theorem brickCell_eq_of_mem {c r c' r' : ℤ} {z : ℂ} (h : z ∈ brickCell c r) (h' : z ∈ brickCell c' r') :
    c = c' ∧ r = r' := by
  obtain ⟨⟨a1, a2⟩, b1, b2⟩ := h
  obtain ⟨⟨a1', a2'⟩, b1', b2'⟩ := h'
  have hr1 : (r : ℝ) < r' + 1 := by linarith
  have hr2 : (r' : ℝ) < r + 1 := by linarith
  have hr1' : r < r' + 1 := by exact_mod_cast hr1
  have hr2' : r' < r + 1 := by exact_mod_cast hr2
  have hrr : r = r' := by omega
  subst hrr
  have hc1 : (c : ℝ) < c' + 1 := by linarith
  have hc2 : (c' : ℝ) < c + 1 := by linarith
  have hc1' : c < c' + 1 := by exact_mod_cast hc1
  have hc2' : c' < c + 1 := by exact_mod_cast hc2
  exact ⟨by omega, rfl⟩

theorem disjoint_brickCell {p q : ℤ × ℤ} (h : p ≠ q) : Disjoint (brickCell p.1 p.2) (brickCell q.1 q.2) := by
  rw [Set.disjoint_left]
  intro z hp hq
  obtain ⟨h1, h2⟩ := brickCell_eq_of_mem hp hq
  exact h (Prod.ext h1 h2)

/-- An open cell misses the closure of every other cell. -/
theorem brickCell_eq_of_mem_closure {c r c' r' : ℤ} {z : ℂ} (h : z ∈ brickCell c r) (h' : z ∈ closure (brickCell c' r')) :
    c = c' ∧ r = r' := by
  obtain ⟨w, hw, hw'⟩ := mem_closure_iff_nhds.mp h' _ ((isOpen_brickCell c r).mem_nhds h)
  exact brickCell_eq_of_mem hw hw'

/-! ## The interior points are the cells, and the edges lie on the grid -/

/-- The floors of a point: its row `⌊im/(3/5)⌋` and its column in that row. -/
theorem sevenBrick_floor_bounds (z : ℂ) :
    let r := ⌊z.im / (3 / 5)⌋
    let c := ⌊(z.re - 2 / 5 * r) / (4 / 5)⌋
    (3 / 5 * (r : ℝ) ≤ z.im ∧ z.im < 3 / 5 * r + 3 / 5) ∧
      (2 / 5 * (r : ℝ) + 4 / 5 * c ≤ z.re ∧ z.re < 2 / 5 * r + 4 / 5 * c + 4 / 5) := by
  intro r c
  have h1 : (r : ℝ) ≤ z.im / (3 / 5) := Int.floor_le _
  have h2 : z.im / (3 / 5) < r + 1 := Int.lt_floor_add_one _
  have h3 : (c : ℝ) ≤ (z.re - 2 / 5 * r) / (4 / 5) := Int.floor_le _
  have h4 : (z.re - 2 / 5 * r) / (4 / 5) < c + 1 := Int.lt_floor_add_one _
  rw [le_div_iff₀ (by norm_num)] at h1 h3
  rw [div_lt_iff₀ (by norm_num)] at h2 h4
  exact ⟨⟨by linarith, by linarith⟩, ⟨by linarith, by linarith⟩⟩

/-- **The interior points of the seven-brick map are the open cells.** -/
theorem sevenBrick_mem_interiorPts {z : ℂ} : z ∈ sevenBrickMap.interiorPts ↔ ∃ c r, z ∈ brickCell c r := by
  constructor
  · rintro ⟨-, hz⟩
    obtain ⟨⟨h1, h2⟩, h3, h4⟩ := sevenBrick_floor_bounds z
    set r := ⌊z.im / (3 / 5)⌋
    set c := ⌊(z.re - 2 / 5 * r) / (4 / 5)⌋
    refine ⟨c, r, ⟨lt_of_le_of_ne h3 ?_, h4⟩, lt_of_le_of_ne h1 ?_, h2⟩
    · intro he
      exact hz (mem_sevenBrickArcs_of_left (c := c) (r := r) he.symm h1 (by linarith))
    · intro he
      exact hz (mem_sevenBrickArcs_of_bottom (c := c) (r := r) he.symm h3 (by linarith))
  · rintro ⟨c, r, ⟨a1, a2⟩, b1, b2⟩
    refine ⟨mem_univ z, not_mem_sevenBrickArcs (fun n hn => ?_) (fun n hn => ?_)⟩
    · have h1 : (r : ℝ) < n := by linarith
      have h2 : (n : ℝ) < r + 1 := by linarith
      have h1' : r < n := by exact_mod_cast h1
      have h2' : n < r + 1 := by exact_mod_cast h2
      omega
    · have hfl : ⌊z.im / (3 / 5)⌋ = r := by
        rw [Int.floor_eq_iff]
        constructor
        · rw [le_div_iff₀ (by norm_num)]; linarith
        · rw [div_lt_iff₀ (by norm_num)]; linarith
      rw [hfl] at hn
      have h1 : (c : ℝ) < n := by linarith
      have h2 : (n : ℝ) < c + 1 := by linarith
      have h1' : c < n := by exact_mod_cast h1
      have h2' : n < c + 1 := by exact_mod_cast h2
      omega

/-- **The grid**: a point in no open cell has height in `(3/5)ℤ` or abscissa in `(2/5)ℤ`. -/
theorem sevenBrick_grid_of_not_mem {z : ℂ} (hz : ∀ c r, z ∉ brickCell c r) :
    (∃ n : ℤ, z.im = 3 / 5 * n) ∨ (∃ n : ℤ, z.re = 2 / 5 * n) := by
  by_contra hne
  push Not at hne
  obtain ⟨hi, hr⟩ := hne
  obtain ⟨⟨h1, h2⟩, h3, h4⟩ := sevenBrick_floor_bounds z
  set r := ⌊z.im / (3 / 5)⌋
  set c := ⌊(z.re - 2 / 5 * r) / (4 / 5)⌋
  refine hz c r ⟨⟨lt_of_le_of_ne h3 fun he => hr (r + 2 * c) ?_, h4⟩, lt_of_le_of_ne h1 fun he => hi r he.symm, h2⟩
  rw [← he]; push_cast; ring

/-- The points of `Γ` of the seven-brick map lie on the grid. -/
theorem sevenBrick_grid_of_not_mem_interiorPts {z : ℂ} (hz : z ∉ sevenBrickMap.interiorPts) :
    (∃ n : ℤ, z.im = 3 / 5 * n) ∨ (∃ n : ℤ, z.re = 2 / 5 * n) :=
  sevenBrick_grid_of_not_mem fun c r h => hz (sevenBrick_mem_interiorPts.mpr ⟨c, r, h⟩)

/-! ## The colour of a cell -/

/-- **The colour of the cell `(c, r)` is `(c + 3 r) mod 7`.** -/
theorem sevenBrick_col_val {c r : ℤ} {z : ℂ} (hz : z ∈ brickCell c r) :
    ((sevenBrickMap.col z : Fin 7) : ℕ) = ((c % 7).toNat + 3 * (r % 7).toNat) % 7 := by
  obtain ⟨⟨a1, a2⟩, b1, b2⟩ := hz
  have hr : ⌊z.im / (3 / 5)⌋ = r := by
    rw [Int.floor_eq_iff]
    constructor
    · rw [le_div_iff₀ (by norm_num)]; linarith
    · rw [div_lt_iff₀ (by norm_num)]; linarith
  have hc : ⌊(z.re - 2 / 5 * r) / (4 / 5)⌋ = c := by
    rw [Int.floor_eq_iff]
    constructor
    · rw [le_div_iff₀ (by norm_num)]; linarith
    · rw [div_lt_iff₀ (by norm_num)]; linarith
  rw [sevenBrick_color_eq hr hc]
  rfl

/-- Two points of equal colour in cells `(c, r)` and `(c', r')`: `7 ∣ (c − c') + 3 (r − r')`. -/
theorem sevenBrick_dvd_of_col_eq {c r c' r' : ℤ} {z z' : ℂ} (hz : z ∈ brickCell c r) (hz' : z' ∈ brickCell c' r')
    (h : sevenBrickMap.col z = sevenBrickMap.col z') : 7 ∣ (c - c') + 3 * (r - r') := by
  have h1 := sevenBrick_col_val hz
  have h2 := sevenBrick_col_val hz'
  rw [h] at h1
  rw [h1] at h2
  omega

/-- Two cells whose closures share a point: their rows differ by at most `1` and their values of `2 c + r` by at most `2`. -/
theorem brickCell_pair {c r c' r' : ℤ} {v : ℂ} (h : v ∈ closure (brickCell c r)) (h' : v ∈ closure (brickCell c' r')) :
    r ≤ r' + 1 ∧ 2 * c + r ≤ 2 * c' + r' + 2 := by
  rw [mem_closure_brickCell] at h h'
  obtain ⟨⟨a1, a2⟩, b1, b2⟩ := h
  obtain ⟨⟨a1', a2'⟩, b1', b2'⟩ := h'
  have hr : (r : ℝ) ≤ r' + 1 := by linarith
  have hc : (2 * c + r : ℝ) ≤ 2 * c' + r' + 2 := by linarith
  exact ⟨by exact_mod_cast hr, by exact_mod_cast hc⟩

/-- **Neighbouring cells differ in colour**: two cells whose closures share a point, with `7 ∣ (c − c') + 3 (r − r')`, are one cell. -/
theorem brickCell_eq_of_closure {c r c' r' : ℤ} {v : ℂ} (h : v ∈ closure (brickCell c r)) (h' : v ∈ closure (brickCell c' r'))
    (hd : 7 ∣ (c - c') + 3 * (r - r')) : c = c' ∧ r = r' := by
  obtain ⟨a1, a2⟩ := brickCell_pair h h'
  obtain ⟨b1, b2⟩ := brickCell_pair h' h
  obtain ⟨d, hd⟩ := hd
  rcases (show r = r' ∨ r = r' + 1 ∨ r' = r + 1 by omega) with hr | hr | hr
  · subst hr; omega
  · subst hr; omega
  · subst hr; omega

/-! ## Sectors and tiles -/

theorem sevenBrick_interiorPts_inter_ball (v : ℂ) (ρ : ℝ) :
    sevenBrickMap.interiorPts ∩ ball v ρ = ⋃ p : ℤ × ℤ, brickCell p.1 p.2 ∩ ball v ρ := by
  ext z
  simp only [mem_inter_iff, mem_iUnion, sevenBrick_mem_interiorPts, Prod.exists]
  constructor
  · rintro ⟨⟨c, r, h⟩, hb⟩; exact ⟨c, r, h, hb⟩
  · rintro ⟨c, r, h, hb⟩; exact ⟨⟨c, r, h⟩, hb⟩

theorem sevenBrick_component {v : ℂ} {ρ : ℝ} {p : ℤ × ℤ} {x : ℂ} (hx : x ∈ brickCell p.1 p.2 ∩ ball v ρ) :
    connectedComponentIn (sevenBrickMap.interiorPts ∩ ball v ρ) x = brickCell p.1 p.2 ∩ ball v ρ :=
  connectedComponentIn_eq_of_iUnion (sevenBrick_interiorPts_inter_ball v ρ)
    (fun _ => (isOpen_brickCell _ _).inter isOpen_ball)
    (fun _ => ((convex_brickCell _ _).inter (convex_ball _ _)).isPreconnected)
    (fun _ _ hq => (disjoint_brickCell hq).mono inter_subset_left inter_subset_left) hx

/-- **The sectors of the seven-brick map at `v`** (any radius `ρ > 0`) are the cells whose closure holds `v`, cut by the ball. -/
theorem sevenBrick_isSector_iff {v : ℂ} {ρ : ℝ} (hρ : 0 < ρ) {S : Set ℂ} :
    sevenBrickMap.IsSector v ρ S ↔ ∃ p : ℤ × ℤ, v ∈ closure (brickCell p.1 p.2) ∧ S = brickCell p.1 p.2 ∩ ball v ρ := by
  constructor
  · rintro ⟨x, hx, rfl, hvS⟩
    rw [sevenBrick_interiorPts_inter_ball] at hx
    obtain ⟨p, hp⟩ := mem_iUnion.mp hx
    rw [sevenBrick_component hp] at hvS ⊢
    exact ⟨p, closure_mono inter_subset_left hvS, rfl⟩
  · rintro ⟨p, hv, rfl⟩
    have hvcl : v ∈ closure (brickCell p.1 p.2 ∩ ball v ρ) := by
      have := isOpen_ball.inter_closure (show v ∈ ball v ρ ∩ closure (brickCell p.1 p.2) from ⟨mem_ball_self hρ, hv⟩)
      rwa [inter_comm] at this
    obtain ⟨x, hx⟩ : (brickCell p.1 p.2 ∩ ball v ρ).Nonempty := by
      by_contra hne
      rw [not_nonempty_iff_eq_empty] at hne
      rw [hne, closure_empty] at hvcl
      exact hvcl
    refine ⟨x, ?_, (sevenBrick_component hx).symm, hvcl⟩
    rw [sevenBrick_interiorPts_inter_ball]
    exact mem_iUnion.mpr ⟨p, hx⟩

/-- A sector of the seven-brick map contains a point of its cell. -/
theorem sevenBrick_sector_data {v : ℂ} {ρ : ℝ} {S : Set ℂ} (hS : sevenBrickMap.IsSector v ρ S) :
    ∃ p : ℤ × ℤ, v ∈ closure (brickCell p.1 p.2) ∧ S = brickCell p.1 p.2 ∩ ball v ρ ∧ (brickCell p.1 p.2 ∩ ball v ρ).Nonempty := by
  obtain ⟨x, hx, rfl, hvS⟩ := hS
  rw [sevenBrick_interiorPts_inter_ball] at hx
  obtain ⟨p, hp⟩ := mem_iUnion.mp hx
  rw [sevenBrick_component hp] at hvS ⊢
  exact ⟨p, closure_mono inter_subset_left hvS, rfl, x, hp⟩

/-- **No colour has two sectors** at any point of the seven-brick map. -/
theorem sevenBrick_sectorsOf_subsingleton {v : ℂ} {ρ : ℝ} {j : Fin 7} {S S' : Set ℂ}
    (hS : S ∈ sevenBrickMap.sectorsOf v ρ j) (hS' : S' ∈ sevenBrickMap.sectorsOf v ρ j) : S = S' := by
  obtain ⟨p, hp, rfl, x, hx⟩ := sevenBrick_sector_data hS.1
  obtain ⟨q, hq, rfl, y, hy⟩ := sevenBrick_sector_data hS'.1
  have hxj : sevenBrickMap.col x = j := hS.2 hx
  have hyj : sevenBrickMap.col y = j := hS'.2 hy
  obtain ⟨h1, h2⟩ := brickCell_eq_of_closure hp hq (sevenBrick_dvd_of_col_eq hx.1 hy.1 (hxj.trans hyj.symm))
  rw [show p = q from Prod.ext h1 h2]

theorem sevenBrick_encard_sectorsOf_le {v : ℂ} {ρ : ℝ} {j : Fin 7} : (sevenBrickMap.sectorsOf v ρ j).encard ≤ 1 :=
  Set.encard_le_one_iff.mpr fun _ _ hS hS' => sevenBrick_sectorsOf_subsingleton hS hS'

/-- No point of the seven-brick map carries a repeated colour. -/
theorem sevenBrick_not_hasRepeatedColour (v : ℂ) : ¬ sevenBrickMap.HasRepeatedColour v := by
  rintro ⟨j, hj⟩
  obtain ⟨ρ, hρ⟩ := hj.exists
  have := hρ.trans (sevenBrick_encard_sectorsOf_le (v := v) (ρ := ρ) (j := j))
  norm_num at this

/-- MERGE is available nowhere in the seven-brick map. -/
theorem sevenBrick_not_mergeAvailable (v : ℂ) : ¬ sevenBrickMap.MergeAvailable v := by
  rintro ⟨j, n, hn, hj, -⟩
  obtain ⟨ρ, hρ⟩ := hj.exists
  have h := sevenBrick_encard_sectorsOf_le (v := v) (ρ := ρ) (j := j)
  rw [hρ] at h
  have : n ≤ 1 := by exact_mod_cast h
  omega

/-- **The tiles of the seven-brick map are its cells.** -/
theorem sevenBrick_isTile_iff {T : Set ℂ} : sevenBrickMap.IsTile T ↔ ∃ c r, T = brickCell c r := by
  have hU : sevenBrickMap.interiorPts = ⋃ p : ℤ × ℤ, brickCell p.1 p.2 := by
    ext z; simp only [sevenBrick_mem_interiorPts, mem_iUnion, Prod.exists]
  have hcomp : ∀ (p : ℤ × ℤ) x, x ∈ brickCell p.1 p.2 → connectedComponentIn sevenBrickMap.interiorPts x = brickCell p.1 p.2 :=
    fun p x hx => connectedComponentIn_eq_of_iUnion hU (fun _ => isOpen_brickCell _ _)
      (fun _ => (convex_brickCell _ _).isPreconnected) (fun _ _ hq => disjoint_brickCell hq) hx
  constructor
  · rintro ⟨x, hx, rfl⟩
    obtain ⟨c, r, h⟩ := sevenBrick_mem_interiorPts.mp hx
    exact ⟨c, r, hcomp (c, r) x h⟩
  · rintro ⟨c, r, rfl⟩
    have hz : ((2 / 5 * (r : ℝ) + 4 / 5 * c + 2 / 5 : ℝ) : ℂ) + ((3 / 5 * (r : ℝ) + 3 / 10 : ℝ) : ℂ) * I ∈ brickCell c r := by
      refine ⟨⟨?_, ?_⟩, ?_, ?_⟩ <;> simp <;> linarith
    exact ⟨_, sevenBrick_mem_interiorPts.mpr ⟨c, r, hz⟩, (hcomp (c, r) _ hz).symm⟩

/-! ## At most three cells at a point -/

/-- The cells whose closure holds `v`. -/
def brickCellsAt (v : ℂ) : Set (ℤ × ℤ) := {p | v ∈ closure (brickCell p.1 p.2)}

/-- **At most three cells meet at a point**: `2 c + r` separates them and spans at most three consecutive integers (it has the parity of
`r`, which spans at most two). -/
theorem encard_brickCellsAt_le (v : ℂ) : (brickCellsAt v).encard ≤ 3 := by
  have hinj : InjOn (fun p : ℤ × ℤ => (2 * p.1 + p.2) % 3) (brickCellsAt v) := by
    intro p hp q hq hpq
    obtain ⟨a1, a2⟩ := brickCell_pair hp hq
    obtain ⟨b1, b2⟩ := brickCell_pair hq hp
    simp only at hpq
    have h1 : p.1 = q.1 := by omega
    have h2 : p.2 = q.2 := by omega
    exact Prod.ext h1 h2
  have hmaps : MapsTo (fun p : ℤ × ℤ => (2 * p.1 + p.2) % 3) (brickCellsAt v) (Ico 0 3) := by
    intro p _
    simp only [mem_Ico]
    omega
  calc (brickCellsAt v).encard = ((fun p : ℤ × ℤ => (2 * p.1 + p.2) % 3) '' brickCellsAt v).encard := (hinj.encard_image).symm
    _ ≤ (Ico (0 : ℤ) 3).encard := encard_le_encard (image_subset_iff.mpr hmaps)
    _ = 3 := by rw [← Finset.coe_Ico, Set.encard_coe_eq_coe_finsetCard, Int.card_Ico]; rfl

/-- The sectors at `v` inject into the cells at `v`, so the degree is at most three. -/
theorem sevenBrick_encard_sectors_le {v : ℂ} {ρ : ℝ} (hρ : 0 < ρ) : {S | sevenBrickMap.IsSector v ρ S}.encard ≤ 3 := by
  have hsub : {S | sevenBrickMap.IsSector v ρ S} ⊆ (fun p : ℤ × ℤ => brickCell p.1 p.2 ∩ ball v ρ) '' brickCellsAt v := by
    intro S hS
    obtain ⟨p, hp, rfl⟩ := (sevenBrick_isSector_iff hρ).mp hS
    exact ⟨p, hp, rfl⟩
  exact (encard_le_encard hsub).trans (encard_image_le _ _ |>.trans (encard_brickCellsAt_le v))

/-- **At most three colours at every point** of the seven-brick map. -/
theorem sevenBrick_ncard_coloursAt_le (v : ℂ) : (sevenBrickMap.coloursAt v).ncard ≤ 3 := by
  obtain ⟨n, hn, hdeg⟩ := ArcMap.exists_hasDegree_of_chart (F := sevenBrickMap) (mem_univ v)
  obtain ⟨ρ, hρn, hρ⟩ := (hdeg.and self_mem_nhdsWithin).exists
  have h := sevenBrick_encard_sectors_le (v := v) hρ
  rw [hρn] at h
  have : n ≤ 3 := by exact_mod_cast h
  omega

/-! ## No curved boundary -/

/-- `sin θ = y` at countably many `θ`. -/
theorem countable_setOf_sin_eq (y : ℝ) : {θ : ℝ | Real.sin θ = y}.Countable := by
  by_cases h : ∃ θ₀, Real.sin θ₀ = y
  · obtain ⟨θ₀, rfl⟩ := h
    refine (countable_range fun p : ℤ × Bool => if p.2 then 2 * p.1 * π + θ₀ else (2 * p.1 + 1) * π - θ₀).mono ?_
    intro θ hθ
    obtain ⟨k, hk | hk⟩ := Real.sin_eq_sin_iff.mp hθ.symm
    · exact ⟨(k, true), by simp [hk]⟩
    · exact ⟨(k, false), by simp [hk]⟩
  · push Not at h
    have : {θ : ℝ | Real.sin θ = y} = ∅ := eq_empty_of_forall_notMem fun θ hθ => h θ hθ
    rw [this]; exact countable_empty

/-- `cos θ = y` at countably many `θ`. -/
theorem countable_setOf_cos_eq (y : ℝ) : {θ : ℝ | Real.cos θ = y}.Countable := by
  by_cases h : ∃ θ₀, Real.cos θ₀ = y
  · obtain ⟨θ₀, rfl⟩ := h
    refine (countable_range fun p : ℤ × Bool => if p.2 then 2 * p.1 * π + θ₀ else 2 * p.1 * π - θ₀).mono ?_
    intro θ hθ
    obtain ⟨k, hk | hk⟩ := Real.cos_eq_cos_iff.mp hθ.symm
    · exact ⟨(k, true), by simp [hk]⟩
    · exact ⟨(k, false), by simp [hk]⟩
  · push Not at h
    have : {θ : ℝ | Real.cos θ = y} = ∅ := eq_empty_of_forall_notMem fun θ hθ => h θ hθ
    rw [this]; exact countable_empty

/-- A circle meets the grid at countably many angles: `A − R cos θ ∈ (3/5)ℤ` or `B + R sin θ ∈ (2/5)ℤ` (`R ≠ 0`) at countably many `θ`. -/
theorem countable_circle_grid (A B R : ℝ) (hR : R ≠ 0) :
    {θ : ℝ | (∃ n : ℤ, A - R * Real.cos θ = 3 / 5 * n) ∨ (∃ n : ℤ, B + R * Real.sin θ = 2 / 5 * n)}.Countable := by
  have hsub : {θ : ℝ | (∃ n : ℤ, A - R * Real.cos θ = 3 / 5 * n) ∨ (∃ n : ℤ, B + R * Real.sin θ = 2 / 5 * n)} ⊆
      (⋃ n : ℤ, {θ : ℝ | Real.cos θ = (A - 3 / 5 * n) / R}) ∪ ⋃ n : ℤ, {θ : ℝ | Real.sin θ = (2 / 5 * n - B) / R} := by
    rintro θ (⟨n, hn⟩ | ⟨n, hn⟩)
    · left; refine mem_iUnion.mpr ⟨n, ?_⟩; show Real.cos θ = _; field_simp; linarith
    · right; refine mem_iUnion.mpr ⟨n, ?_⟩; show Real.sin θ = _; field_simp; linarith
  exact ((countable_iUnion fun n => countable_setOf_cos_eq _).union (countable_iUnion fun n => countable_setOf_sin_eq _)).mono hsub

/-- The branch of curvature `κ ≠ 0` read on its circle: `branchPt v β κ s` has height `v.im + cos β/κ − cos θ/κ` and abscissa
`v.re − sin β/κ + sin θ/κ` at `θ = β + 2 arcsin(κ s/2)`. -/
theorem branchPt_re_im {v : ℂ} {β κ s : ℝ} (hκ : κ ≠ 0) (hs : κ * s / 2 ∈ Icc (-1 : ℝ) 1) :
    (branchPt v β κ s).im = (v.im + Real.cos β / κ) - (1 / κ) * Real.cos (β + 2 * Real.arcsin (κ * s / 2)) ∧
      (branchPt v β κ s).re = (v.re - Real.sin β / κ) + (1 / κ) * Real.sin (β + 2 * Real.arcsin (κ * s / 2)) := by
  set ψ := Real.arcsin (κ * s / 2) with hψ
  have hsin : Real.sin ψ = κ * s / 2 := Real.sin_arcsin hs.1 hs.2
  have hs' : s = 2 * Real.sin ψ / κ := by rw [hsin]; field_simp
  have h1 := Real.two_mul_sin_mul_sin ψ (β + ψ)
  have h2 := Real.two_mul_sin_mul_cos ψ (β + ψ)
  rw [show ψ - (β + ψ) = -β by ring, Real.cos_neg, show ψ + (β + ψ) = β + 2 * ψ by ring] at h1
  rw [show ψ - (β + ψ) = -β by ring, Real.sin_neg, show ψ + (β + ψ) = β + 2 * ψ by ring] at h2
  simp only [branchPt, Complex.add_im, Complex.add_re, Complex.mul_im, Complex.mul_re, Complex.ofReal_re,
    Complex.ofReal_im, re_e, im_e, zero_mul, add_zero, sub_zero]
  rw [← hψ, hs']
  constructor
  · field_simp; linear_combination h1
  · field_simp; linear_combination h2

/-- **No curved branch lies in `Γ`**: a branch of curvature `κ ≠ 0` at `v` cannot lie off the interior points of the seven-brick map for
all small arc lengths. -/
theorem sevenBrick_branch_false {v : ℂ} {β κ r : ℝ} (hκ : κ ≠ 0) (hr : 0 < r) (hκr : |κ| * r ≤ 2)
    (hΓ : ∀ s ∈ Ioo 0 r, branchPt v β κ s ∉ sevenBrickMap.interiorPts) : False := by
  set θ : ℝ → ℝ := fun s => β + 2 * Real.arcsin (κ * s / 2)
  have hI : ∀ s ∈ Ioo 0 r, κ * s / 2 ∈ Icc (-1 : ℝ) 1 := fun s hs => half_curv_mem_Icc hκr hs.1.le hs.2.le
  have hmaps : MapsTo θ (Ioo 0 r) {θ : ℝ | (∃ n : ℤ, (v.im + Real.cos β / κ) - (1 / κ) * Real.cos θ = 3 / 5 * n) ∨
      (∃ n : ℤ, (v.re - Real.sin β / κ) + (1 / κ) * Real.sin θ = 2 / 5 * n)} := by
    intro s hs
    obtain ⟨him, hre⟩ := branchPt_re_im (v := v) (β := β) hκ (hI s hs)
    rcases sevenBrick_grid_of_not_mem_interiorPts (hΓ s hs) with ⟨n, hn⟩ | ⟨n, hn⟩
    · exact Or.inl ⟨n, him ▸ hn⟩
    · exact Or.inr ⟨n, hre ▸ hn⟩
  have hinj : InjOn θ (Ioo 0 r) := by
    intro s hs s' hs' h
    have h' : Real.arcsin (κ * s / 2) = Real.arcsin (κ * s' / 2) := by simp only [θ] at h; linarith
    have h3 := Real.injOn_arcsin (hI s hs) (hI s' hs') h'
    have h4 : κ * s = κ * s' := by linarith
    exact mul_left_cancel₀ hκ h4
  have hc := hmaps.countable_of_injOn hinj (countable_circle_grid _ _ (1 / κ) (one_div_ne_zero hκ))
  rw [Cardinal.Real.Ioo_countable_iff] at hc
  linarith

/-- **No horn** exists in the seven-brick map: one of a horn's bounding arcs has non-zero curvature, and it lies off the interior
points (`not_mem_interiorPts_of_mem_closure_sector`), against `sevenBrick_branch_false`. -/
theorem sevenBrick_not_isHorn {v : ℂ} {α κ₁ κ₂ : ℝ} {c : Fin 7} : ¬ sevenBrickMap.IsHorn v α κ₁ κ₂ c := by
  rintro ⟨hlt, hev⟩
  -- a small radius at which the horn is a sector and both curvatures are tame
  have hpos : 0 < 1 / (|κ₁| + |κ₂| + 1) := by positivity
  obtain ⟨r, ⟨hsec, -⟩, hr⟩ := (hev.and (Ioo_mem_nhdsGT hpos)).exists
  have hr0 : 0 < r := hr.1
  have hb1 : |κ₁| * r ≤ 1 := by
    have := hr.2; rw [lt_div_iff₀ (by positivity)] at this; nlinarith [abs_nonneg κ₁, abs_nonneg κ₂]
  have hb2 : |κ₂| * r ≤ 1 := by
    have := hr.2; rw [lt_div_iff₀ (by positivity)] at this; nlinarith [abs_nonneg κ₁, abs_nonneg κ₂]
  by_cases h2 : κ₂ = 0
  · -- the lower arc is curved
    have h1 : κ₁ ≠ 0 := by intro h; rw [h, h2] at hlt; exact lt_irrefl _ hlt
    refine sevenBrick_branch_false (v := v) (β := α) h1 hr0 (by linarith) fun s hs => ?_
    have hs1 : |κ₁| * s ≤ 1 := le_trans (mul_le_mul_of_nonneg_left hs.2.le (abs_nonneg _)) hb1
    refine ArcMap.not_mem_interiorPts_of_mem_closure_sector hsec ?_
      (branchPt_mem_closure_hornSet_lower v α hlt hs.1 hs.2 (by linarith)) ?_
    · rw [mem_ball, dist_eq_norm, norm_branchPt_sub v α _ hs.1.le]; exact hs.2
    · rintro ⟨-, -, hA, -⟩
      have : tanHeight κ₁ (frameX v α (branchPt v α κ₁ s)) (frameY v α (branchPt v α κ₁ s)) = 0 := by
        rw [tanHeight_branchPt v α κ₁ κ₁ (by linarith) hs.1.le]; ring
      exact (ne_of_gt hA) this
  · refine sevenBrick_branch_false (v := v) (β := α) h2 hr0 (by linarith) fun s hs => ?_
    have hs2 : |κ₂| * s ≤ 1 := le_trans (mul_le_mul_of_nonneg_left hs.2.le (abs_nonneg _)) hb2
    refine ArcMap.not_mem_interiorPts_of_mem_closure_sector hsec ?_
      (branchPt_mem_closure_hornSet_upper v α hlt hs.1 hs.2 (by linarith)) ?_
    · rw [mem_ball, dist_eq_norm, norm_branchPt_sub v α _ hs.1.le]; exact hs.2
    · rintro ⟨-, -, -, hB⟩
      have : tanHeight κ₂ (frameX v α (branchPt v α κ₂ s)) (frameY v α (branchPt v α κ₂ s)) = 0 := by
        rw [tanHeight_branchPt v α κ₂ κ₂ (by linarith) hs.1.le]; ring
      exact (ne_of_lt hB) this

/-- **No arc of a unit circle of positive length lies in `Γ`** of the seven-brick map. -/
theorem sevenBrick_ringArc_not_subset {P : ℂ} {θ₁ θ₂ : ℝ} (h : θ₁ < θ₂) : ¬ ringArc P θ₁ θ₂ ⊆ sevenBrickMap.Γ := by
  intro hsub
  have hmaps : MapsTo (fun θ : ℝ => θ + π / 2) (Ioo θ₁ θ₂) {θ : ℝ | (∃ n : ℤ, P.im - 1 * Real.cos θ = 3 / 5 * n) ∨
      (∃ n : ℤ, P.re + 1 * Real.sin θ = 2 / 5 * n)} := by
    intro θ hθ
    have hΓ : ringPt P θ ∈ sevenBrickMap.Γ := hsub ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩
    have hni : ringPt P θ ∉ sevenBrickMap.interiorPts := fun hi => hi.2 hΓ.2
    simp only [mem_setOf_eq, Real.cos_add_pi_div_two, Real.sin_add_pi_div_two, one_mul, sub_neg_eq_add]
    rcases sevenBrick_grid_of_not_mem_interiorPts hni with ⟨n, hn⟩ | ⟨n, hn⟩
    · left; refine ⟨n, ?_⟩; rw [← hn]; simp [ringPt, im_e]
    · right; refine ⟨n, ?_⟩; rw [← hn]; simp [ringPt, re_e]
  have hinj : InjOn (fun θ : ℝ => θ + π / 2) (Ioo θ₁ θ₂) := fun a _ b _ hab => by simpa using hab
  have hc := hmaps.countable_of_injOn hinj (countable_circle_grid P.im P.re 1 one_ne_zero)
  rw [Cardinal.Real.Ioo_countable_iff] at hc
  linarith

/-- **The seven-brick map has no arc of `Γ` on a unit circle with constant sides.** -/
theorem sevenBrick_not_isRingArc {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin 7} : ¬ sevenBrickMap.IsRingArc P θ₁ θ₂ c c' :=
  fun h => sevenBrick_ringArc_not_subset h.1 h.2.1

/-! ## No tile encloses another -/

/-- **The complement of a closed rectangle is preconnected**: it is the union of four open half-planes, consecutive ones meeting. -/
theorem isPreconnected_compl_reProdIm_Icc (a b c d : ℝ) : IsPreconnected (Icc a b ×ℂ Icc c d)ᶜ := by
  have hH1 : IsPreconnected {z : ℂ | z.re < a} := ((convex_Iio a).linear_preimage Complex.reLm).isPreconnected
  have hH2 : IsPreconnected {z : ℂ | b < z.re} := ((convex_Ioi b).linear_preimage Complex.reLm).isPreconnected
  have hH3 : IsPreconnected {z : ℂ | z.im < c} := ((convex_Iio c).linear_preimage Complex.imLm).isPreconnected
  have hH4 : IsPreconnected {z : ℂ | d < z.im} := ((convex_Ioi d).linear_preimage Complex.imLm).isPreconnected
  have heq : (Icc a b ×ℂ Icc c d)ᶜ = (({z : ℂ | z.re < a} ∪ {z : ℂ | z.im < c}) ∪ {z : ℂ | b < z.re}) ∪ {z : ℂ | d < z.im} := by
    ext z
    simp only [mem_compl_iff, mem_reProdIm, mem_Icc, mem_union, mem_setOf_eq]
    constructor
    · intro h
      by_contra h'
      push Not at h'
      exact h ⟨⟨h'.1.1.1, h'.1.2⟩, h'.1.1.2, h'.2⟩
    · rintro (((h | h) | h) | h) ⟨⟨h1, h2⟩, h3, h4⟩ <;> linarith
  rw [heq]
  refine IsPreconnected.union (((a - 1 : ℝ) : ℂ) + ((d + 1 : ℝ) : ℂ) * I) ?_ ?_ ?_ hH4
  · left; left; simp
  · simp
  refine IsPreconnected.union (((b + 1 : ℝ) : ℂ) + ((c - 1 : ℝ) : ℂ) * I) ?_ ?_ ?_ hH2
  · right; simp
  · simp
  exact IsPreconnected.union (((a - 1 : ℝ) : ℂ) + ((c - 1 : ℝ) : ℂ) * I) (by simp) (by simp) hH1 hH3

/-- **No tile of the seven-brick map encloses a point of another tile**: the closure of a tile is a closed rectangle, whose complement is
preconnected and unbounded, so every complementary component of a point off it is unbounded. -/
theorem sevenBrick_not_isBounded_component {T : Set ℂ} (hT : sevenBrickMap.IsTile T) {y : ℂ} (hy : y ∉ closure T) :
    ¬ Bornology.IsBounded (connectedComponentIn (closure T)ᶜ y) := by
  obtain ⟨c, r, rfl⟩ := sevenBrick_isTile_iff.mp hT
  rw [closure_brickCell] at hy ⊢
  intro hb
  have hsub := (isPreconnected_compl_reProdIm_Icc _ _ _ _).subset_connectedComponentIn hy subset_rfl
  have hK : Bornology.IsBounded (Icc (2 / 5 * (r : ℝ) + 4 / 5 * c) (2 / 5 * r + 4 / 5 * c + 4 / 5) ×ℂ
      Icc (3 / 5 * (r : ℝ)) (3 / 5 * r + 3 / 5)) := (isCompact_Icc.reProdIm isCompact_Icc).isBounded
  have huniv : Bornology.IsBounded (univ : Set ℂ) := by
    rw [← union_compl_self (Icc (2 / 5 * (r : ℝ) + 4 / 5 * c) (2 / 5 * r + 4 / 5 * c + 4 / 5) ×ℂ
      Icc (3 / 5 * (r : ℝ)) (3 / 5 * r + 3 / 5))]
    exact hK.union (hb.subset hsub)
  exact (not_compactSpace_iff.mpr inferInstance) (compactSpace_iff_isBounded_univ.mpr huniv)

/-- **Every point of the seven-brick map is unenclosed** (`UnenclosedC`, FS131-E4's hypothesis): no tile encloses a tile at `v`. -/
theorem sevenBrick_unenclosedC (v : ℂ) : sevenBrickMap.UnenclosedC v :=
  fun _ _ _ _ hT _ _ _ hy => sevenBrick_not_isBounded_component hT.1 hy.2

/-- **The seven-brick map's base hypothesis holds at every point**: no point carries four colours or a repeated colour. -/
theorem sevenBrick_baseHyp (u : ℂ) : sevenBrickMap.BaseHyp u := by
  rw [ArcMap.BaseHyp, Set.disjoint_left]
  rintro x - (⟨-, h4⟩ | ⟨-, hrep⟩)
  · have := sevenBrick_ncard_coloursAt_le x; omega
  · exact sevenBrick_not_hasRepeatedColour x hrep

/-- No inert unit arc anywhere (no unit arc at all). -/
theorem sevenBrick_noInertNear (u : ℂ) : sevenBrickMap.NoInertNear u :=
  fun _ _ _ _ ⟨_, _, h, _⟩ => sevenBrick_not_isRingArc h

/-! ## Spec examples (each fails if its definition drifts) -/

/-- The cell `(0, 0)` holds its centre `2/5 + (3/10) i` and not its corner `0`, whose closure it holds. -/
example : ((2 / 5 : ℝ) : ℂ) + ((3 / 10 : ℝ) : ℂ) * I ∈ brickCell 0 0 ∧ (0 : ℂ) ∉ brickCell 0 0 ∧ (0 : ℂ) ∈ closure (brickCell 0 0) := by
  refine ⟨⟨⟨?_, ?_⟩, ?_, ?_⟩, fun h => ?_, ?_⟩
  · simp
  · simp; norm_num
  · simp
  · simp; norm_num
  · simpa using h.1.1
  · rw [mem_closure_brickCell]; norm_num

/-- The corner `0` lies in the closures of the cells `(0, 0)` and `(0, −1)` (the lower cell, sheared by `−2/5`) but not of `(1, 0)`. -/
example : ((0 : ℤ), (0 : ℤ)) ∈ brickCellsAt 0 ∧ ((0 : ℤ), (-1 : ℤ)) ∈ brickCellsAt 0 ∧ ((1 : ℤ), (0 : ℤ)) ∉ brickCellsAt 0 := by
  refine ⟨?_, ?_, ?_⟩ <;> simp only [brickCellsAt, mem_setOf_eq, mem_closure_brickCell] <;> norm_num

end HadwigerNelson.Plane
