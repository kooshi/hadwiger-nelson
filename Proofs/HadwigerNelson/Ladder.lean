import Proofs.HadwigerNelson.Triangle

/-!
# M24 — The matched ladder pair: chord completeness and χ = 4 (skeleton)

The countable object at the heart of the two-pivot system: each pivot's **ladder** — the
`⟨ζ₆, σ⟩`-lattice on its two circles, anchored along the axis — and the matched pair of
both pivots' ladders. The M23 census measured this object through a window; M24 makes the
chord list *exact* by completeness theorems and lands the colouring unconditionally:

* **the master identities**: every distance between parametrized points of the pair is
  `‖q−p‖·‖1 − x − v‖` (cross) or `‖q−p‖·‖x − v‖` (intra) — one equation family carries
  every chord and every fusion of this milestone and its successors (M25–M27);
* **completeness**: the cross-chord families are exactly matching ∪ hub ∪ twelve sporadic
  ∪ finitely many glue-incident chords — the ii branch through the Möbius involution
  `μ(z) = (z−√3)/(√3z−1)` (norm form `(√3u−1)(√3v−1) = −2` ⟺ `v = μ(u)`), the oi branch
  through the finite solution set of `‖√3(1−x) − v‖² = 3`;
* **the colouring**: a single b-independent table (§0 experiment E6 — no splice, no
  defect window) colours the whole pair; with the nine-point witness the chromatic
  number is exactly 4.

The address group is `ZMod 6 × ℤ` — torsion times free is exactly the backbone theorem
(`σ` of infinite order, `ζ₆` of order six), so addresses are *canonical names*: the
completeness statements are equalities in `ZMod 6`, never divisibilities in `ℤ`.
Everything is anchored at the pair `(0, 1)` where the statements are consumed, and
stated for a general unit pair where generality is free. §0 ground truth:
`plans/M24-completeness.md`, `build/m24-derive.py`.
-/

namespace HadwigerNelson
namespace Ladder

open Complex TwoCircle Compulsion Coupled

/-! ## §A The lattice words -/

/-- The ladder word `ζ₆^a · σ^b`: the direction of the lattice point at address `(a, b)`.
`σ = TwoCircle.seam` has infinite order (M19) and `ζ₆` order six, so `ZMod 6 × ℤ` is the
true address group and `word` is injective on it (`word_inj`). -/
noncomputable def word (a : ZMod 6) (b : ℤ) : ℂ := zeta6 ^ a.val * seam ^ b

theorem word_add (a c : ZMod 6) (b d : ℤ) :
    word (a + c) (b + d) = word a b * word c d := by
  sorry

theorem word_normSq (a : ZMod 6) (b : ℤ) : normSq (word a b) = 1 := by
  sorry

theorem word_ne_zero (a : ZMod 6) (b : ℤ) : word a b ≠ 0 := by
  sorry

theorem word_conj (a : ZMod 6) (b : ℤ) :
    (starRingEnd ℂ) (word a b) = word (-a) (-b) := by
  sorry

/-- The backbone, re-addressed: the lattice is free over `ZMod 6 × ℤ`
(Triangle's `zeta6_zpow_mul_seam_zpow_eq_one_iff`). -/
theorem word_eq_one_iff (a : ZMod 6) (b : ℤ) : word a b = 1 ↔ (a = 0 ∧ b = 0) := by
  sorry

theorem word_inj (a c : ZMod 6) (b d : ℤ) :
    word a b = word c d ↔ (a = c ∧ b = d) := by
  sorry

/-- The matching branch in address form: `−1 = ζ₆³`. -/
theorem word_neg_iff (a c : ZMod 6) (b d : ℤ) :
    word c d = -word a b ↔ (c = a + 3 ∧ d = b) := by
  sorry

/-! ## §B The ladder points and the pair -/

/-- The outer-circle lattice point of the pivot `p` (partner `q`) at address `(a, b)`. -/
noncomputable def outerPt (p q : ℂ) (a : ZMod 6) (b : ℤ) : ℂ := p + word a b * (q - p)

/-- The inner-circle lattice point: same direction, radius `1/√3`. -/
noncomputable def innerPt (p q : ℂ) (a : ZMod 6) (b : ℤ) : ℂ :=
  p + ((Real.sqrt 3 / 3 : ℝ) : ℂ) * word a b * (q - p)

/-- The matched ladder pair at the `(0, 1)` anchor: both pivots' outer and inner
lattices. The pivots are members automatically — each is the other side's
`outerPt _ _ 0 0` — so no vertex is special-cased. -/
noncomputable def LadderSet : Set ℂ :=
  (Set.range fun n : ZMod 6 × ℤ => outerPt 0 1 n.1 n.2) ∪
    (Set.range fun n : ZMod 6 × ℤ => innerPt 0 1 n.1 n.2) ∪
    ((Set.range fun n : ZMod 6 × ℤ => outerPt 1 0 n.1 n.2) ∪
      (Set.range fun n : ZMod 6 × ℤ => innerPt 1 0 n.1 n.2))

/-! ## §C The master identities (E1) -/

/-- **The cross identity**: the distance between parametrized points of the two systems.
Pure algebra — no torus hypothesis, no unit axis. Every cross family of M24–M27 is an
instance. -/
theorem cross_dist (p q x v : ℂ) :
    dist (p + x * (q - p)) (q + v * (p - q)) = ‖q - p‖ * ‖1 - x - v‖ := by
  sorry

/-- **The intra identity**: the distance between parametrized points of one system. -/
theorem intra_dist (p q x v : ℂ) :
    dist (p + x * (q - p)) (p + v * (q - p)) = ‖q - p‖ * ‖x - v‖ := by
  sorry

/-! ## §D The cross-chord bridges (general unit pair) -/

/-- **Outer–outer completeness**: matching translate, or one endpoint is the other
pivot (the hub branches). The factorization `(x+v)(x−1)(v−1) = 0` in address form —
no sporadics exist on this family. -/
theorem oo_complete {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    dist (outerPt p q a b) (outerPt q p c d) = 1 ↔
      ((c = a + 3 ∧ d = b) ∨ (a = 0 ∧ b = 0) ∨ (c = 0 ∧ d = 0)) := by
  sorry

/-- **The inner–inner bridge**: matching, or the Möbius norm form
`v·(√3u − 1) = u − √3` (division-free form of `(√3u−1)(√3v−1) = −2`, i.e. `v = μ(u)`). -/
theorem ii_chord_iff {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    dist (innerPt p q a b) (innerPt q p c d) = 1 ↔
      (word c d = -word a b ∨
        word c d * ((Real.sqrt 3 : ℂ) * word a b - 1) = word a b - (Real.sqrt 3 : ℂ)) := by
  sorry

/-- **The outer–inner bridge**: the unfactorable branch, as the norm equation of
`A = √3(1−x) − v` (E1: identical to M23's three-term identity). The io family is this
bridge read at the swapped anchor — no separate theorem. -/
theorem oi_chord_iff {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    dist (outerPt p q a b) (innerPt q p c d) = 1 ↔
      normSq ((Real.sqrt 3 : ℂ) * (1 - word a b) - word c d) = 3 := by
  sorry

/-! ## §E Intra completeness -/

/-- Outer–outer chords within one system are exactly the hex steps. -/
theorem intra_outer_complete {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ)
    (c : ZMod 6) (d : ℤ) :
    dist (outerPt p q a b) (outerPt p q c d) = 1 ↔
      ((c = a + 1 ∨ c = a - 1) ∧ d = b) := by
  sorry

/-- Inner–inner chords within one system are exactly the rot3 steps. -/
theorem intra_inner_complete {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ)
    (c : ZMod 6) (d : ℤ) :
    dist (innerPt p q a b) (innerPt p q c d) = 1 ↔
      ((c = a + 2 ∨ c = a - 2) ∧ d = b) := by
  sorry

/-- Outer–inner chords within one system are exactly the seam steps. -/
theorem intra_seam_complete {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ)
    (c : ZMod 6) (d : ℤ) :
    dist (outerPt p q a b) (innerPt p q c d) = 1 ↔
      (c = a ∧ (d = b + 1 ∨ d = b - 1)) := by
  sorry

/-! ## §F Fusion completeness (which addresses name the same point) -/

theorem outerPt_inj {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    outerPt p q a b = outerPt p q c d ↔ (a = c ∧ b = d) := by
  sorry

theorem innerPt_inj {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    innerPt p q a b = innerPt p q c d ↔ (a = c ∧ b = d) := by
  sorry

theorem outer_ne_inner {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    outerPt p q a b ≠ innerPt p q c d := by
  sorry

/-- The two shared outer points: `word a b + word c d = 1` pins `{ζ₆, ζ₆⁻¹}`. -/
theorem fusion_oo {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    outerPt p q a b = outerPt q p c d ↔
      ((a = 1 ∧ b = 0 ∧ c = 5 ∧ d = 0) ∨ (a = 5 ∧ b = 0 ∧ c = 1 ∧ d = 0)) := by
  sorry

/-- The oi glue points: `p`'s inner σ-points are `q`'s outer `word(3, ±2)`-points. -/
theorem fusion_oi {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    innerPt p q a b = outerPt q p c d ↔
      ((a = 0 ∧ b = 1 ∧ c = 3 ∧ d = 2) ∨ (a = 0 ∧ b = -1 ∧ c = 3 ∧ d = -2)) := by
  sorry

/-- The io glue points — `fusion_oi` mirrored. -/
theorem fusion_io {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    outerPt p q a b = innerPt q p c d ↔
      ((a = 3 ∧ b = 2 ∧ c = 0 ∧ d = 1) ∨ (a = 3 ∧ b = -2 ∧ c = 0 ∧ d = -1)) := by
  sorry

/-- The ii gluing needs `u = ζ₁₂` — torsion of order 12, never a lattice word. The two
systems' inner lattices share no point (the metapivot blind spot, M23). -/
theorem fusion_ii {p q : ℂ} (h : dist p q = 1) (a : ZMod 6) (b : ℤ) (c : ZMod 6)
    (d : ℤ) :
    innerPt p q a b ≠ innerPt q p c d := by
  sorry

/-! ## §G The completeness core (E2/E3/E5) -/

/-- The complete solution set of the ii norm form on the lattice, as address tuples:
the two matching-crossing points, the four sporadics, and the four glue-incident
solutions `(σ, −σ³)` (conjugates and swaps included). -/
def iiNormTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(0, 0, 3, 0), (3, 0, 0, 0),
   (1, 1, 5, 1), (5, 1, 1, 1), (1, -1, 5, -1), (5, -1, 1, -1),
   (0, 1, 3, 3), (3, 3, 0, 1), (0, -1, 3, -3), (3, -3, 0, -1)]

/-- **The ii bound** (the valuation core): away from the boundary rows, the Möbius
image of a lattice word can only be lattice at seam height one. Two-prime π/π̄
bookkeeping in `ℤ[ζ₆, π]`, `π = √3σ = (1+i√11)/2`, `π² = π − 3`. -/
theorem ii_norm_bound (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ)
    (hm : word c d * ((Real.sqrt 3 : ℂ) * word a b - 1) = word a b - (Real.sqrt 3 : ℂ))
    (hb : 2 ≤ |b|) : |d| = 1 := by
  sorry

/-- **ii completeness**: every lattice solution of the norm form is in the table. -/
theorem ii_norm_complete (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ)
    (hm : word c d * ((Real.sqrt 3 : ℂ) * word a b - 1) = word a b - (Real.sqrt 3 : ℂ)) :
    (a, b, c, d) ∈ iiNormTable := by
  sorry

/-- The complete solution set of the oi chord equation: four sporadics and twelve
glue-incident chords — sixteen chords EVER, no infinite family (E3/E5: no growth from
window 8 to window 200; the theorem removes the window). -/
def oiTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(2, 2, 5, 1), (2, -2, 5, -1), (4, 2, 1, 1), (4, -2, 1, -1),
   (1, 0, 5, 1), (1, 0, 5, -1), (5, 0, 1, 1), (5, 0, 1, -1),
   (2, 2, 0, 1), (2, -2, 0, -1), (4, 2, 0, 1), (4, -2, 0, -1),
   (3, 2, 2, 1), (3, -2, 2, -1), (3, 2, 4, 1), (3, -2, 4, -1)]

/-- **oi completeness**: every lattice solution of the outer–inner chord equation is in
the table. -/
theorem oi_complete (a : ZMod 6) (b : ℤ) (c : ZMod 6) (d : ℤ)
    (h : normSq ((Real.sqrt 3 : ℂ) * (1 - word a b) - word c d) = 3) :
    (a, b, c, d) ∈ oiTable := by
  sorry

/-! ## §H The colouring (E6: one b-independent table, no splice) -/

/-- The colour tables, by (side, circle): side `false` = the pivot at 0, side `true` =
the pivot at 1; circle `false` = outer, `true` = inner. Found by the E6 SAT probe with
every family imposed; the pivot colours are the opposite side's `outer 0` entries by
the fusion equalities, so no pivot casing exists. -/
def colTab : Bool → Bool → ZMod 6 → Fin 4
  | false, false => ![0, 1, 0, 1, 0, 1]
  | false, true => ![1, 0, 2, 2, 3, 3]
  | true, false => ![2, 1, 2, 1, 2, 1]
  | true, true => ![1, 2, 0, 0, 3, 3]

open Classical in
/-- The colouring of the plane restricted to the ladder pair: decode any address, read
the table (`b` never enters — the colouring is b-independent). Well-defined on fused
points because the table equalizes every fusion (`ladderColour_outerP` and siblings).
Junk value `0` off the ladder. -/
noncomputable def ladderColour (z : ℂ) : Fin 4 :=
  if h : ∃ n : ZMod 6 × ℤ, outerPt 0 1 n.1 n.2 = z then colTab false false h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, innerPt 0 1 n.1 n.2 = z then colTab false true h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, outerPt 1 0 n.1 n.2 = z then colTab true false h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, innerPt 1 0 n.1 n.2 = z then colTab true true h.choose.1
  else 0

theorem ladderColour_outerP (a : ZMod 6) (b : ℤ) :
    ladderColour (outerPt 0 1 a b) = colTab false false a := by
  sorry

theorem ladderColour_innerP (a : ZMod 6) (b : ℤ) :
    ladderColour (innerPt 0 1 a b) = colTab false true a := by
  sorry

theorem ladderColour_outerQ (a : ZMod 6) (b : ℤ) :
    ladderColour (outerPt 1 0 a b) = colTab true false a := by
  sorry

theorem ladderColour_innerQ (a : ZMod 6) (b : ℤ) :
    ladderColour (innerPt 1 0 a b) = colTab true true a := by
  sorry

/-- **Properness**: the table separates every chord family the completeness theorems
allow. -/
theorem ladderColour_valid {z w : ℂ} (hz : z ∈ LadderSet) (hw : w ∈ LadderSet)
    (h : dist z w = 1) : ladderColour z ≠ ladderColour w := by
  sorry

theorem colorable_four_ladder : ((unitDistance ℂ).induce LadderSet).Colorable 4 := by
  sorry

/-- The nine-point witness (pivot, five consecutive outer hex points, the seam-image
rot3 triangle — all ladder addresses) refuses three colours. -/
theorem not_colorable_three_ladder :
    ¬ ((unitDistance ℂ).induce LadderSet).Colorable 3 := by
  sorry

/-- **The headline: the matched ladder pair is exactly 4-chromatic** — the countable
two-pivot object, all chord families exact, no census window, no conditional clause. -/
theorem chromaticNumber_ladderPair :
    ((unitDistance ℂ).induce LadderSet).chromaticNumber = 4 := by
  sorry

/-! ## §I Specification -/

-- the tables are the E6 artifact, verbatim
example : iiNormTable.length = 10 := rfl
example : oiTable.length = 16 := rfl
example : colTab false false 0 = 0 ∧ colTab true false 0 = 2 := ⟨rfl, rfl⟩

-- the pivots are lattice members with no special casing
example : (0 : ℂ) ∈ LadderSet := by
  sorry

example : (1 : ℂ) ∈ LadderSet := by
  sorry

-- a sporadic chord, concretely: the ii sporadic (1,1) → (5,1)
example : dist (innerPt 0 1 1 1) (innerPt 1 0 5 1) = 1 := by
  sorry

-- the adversarial member: the neighbouring ii pair is NOT a chord (the table's
-- discriminating example — colour equality here must not matter)
example : dist (innerPt 0 1 2 1) (innerPt 1 0 4 1) ≠ 1 := by
  sorry

-- the matching translate at inner height 1 is a chord
example : dist (innerPt 0 1 0 1) (innerPt 1 0 3 1) = 1 := by
  sorry

end Ladder
end HadwigerNelson
