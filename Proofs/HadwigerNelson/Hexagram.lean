import Proofs.HadwigerNelson.MetaLadder

/-!
# M26 — The hexagram: six pivots and the metapivot, closed under all unit chords

The **hexagram**: the M24 ladders of the six pivots of the hexagon of circumradius
1/√3 about the metapivot `m = (1+ζ₆)/3` — the triangle `{0, 1, ζ₆}` PLUS its
point-reflection through `m`, the mirror centroids `{2m, 2m−1, 2m−ζ₆}` — together
with the metapivot's own ladder (M25's).  Fourteen `outerPt`/`innerPt` families.

**The self-seeding definition.**  The six pivots ARE the meta-inner hex layer at
seam height zero: `hexPivot a := innerPt m metaAnchor a 0` runs
`2m, ζ₆, 2m−1, 0, 2m−ζ₆, 1` as `a = 0..5` — the odd addresses are the M25 triangle,
the even addresses the mirror centroids, and M23's glue-point certification becomes
an address bookkeeping fact.  The 60° rotation about `m` (`rot6`) cycles the pivots
at address `+1`, squares to M25's 120° transport, and carries every ladder family to
a ladder family — so the 21 centre pairs fall into FOUR orbits (unit, adjacent,
opposite, pivot–meta) and only the adjacent and opposite master webs are new.

Census (§0, exact, B = 30, commit-registered predictions; the rot6 relabelling
verified as an automorphism of the whole exact edge set): the two new webs carry
**sixteen chords total** — adjacent oo is EMPTY, adjacent oi/io/ii and opposite oo
are four sporadics each (all |b| ≤ 2), opposite oi/io/ii are EMPTY, and all eight
new fusion families are EMPTY (the triple tangency at `m` is invisible: `m` is
never a lattice point).  Colour probe: k = 3 UNSAT (control), k = 4 SAT, and a
rot6-**equivariant** table exists — `colour(rot6 z) = τ(colour z)` for the 3-cycle
`τ = (0 1 2)` — so properness runs on orbit representatives.

**The engine** is M25's unchanged: the new separations clear through `g = 1 + ζ₆`
(`3·(q₂ − 0) = ḡ`, `3·(q₀ − 0) = 2g`), so every new master is a `ℤ[√3]`-combination
of `hexTrace` pairs over `ℤ[ζ₆, π]` — the opposite web at REFLECTED addresses
(`Tr(g·w̄)`, the `gTrace_clear_neg` currency) with doubled coefficients.
-/

namespace HadwigerNelson
namespace Hexagram

open Complex TwoCircle Ladder MetaLadder

/-! ## §H The object -/

/-- The six hexagram pivots, indexed by their meta-inner hex address:
`a = 0..5` runs `2m, ζ₆, 2m−1, 0, 2m−ζ₆, 1` — the M25 triangle at odd addresses,
the mirror centroids at even ones. -/
noncomputable def hexPivot (a : ZMod 6) : ℂ := innerPt metaPivot metaAnchor a 0

/-- Address 3 is the pivot `0` — M25's hub fact, verbatim. -/
theorem hexPivot_three : hexPivot 3 = 0 := metaInner_hub

theorem hexPivot_five : hexPivot 5 = 1 := sorry

theorem hexPivot_one : hexPivot 1 = zeta6 := sorry

theorem hexPivot_zero : hexPivot 0 = 2 * metaPivot := sorry

theorem hexPivot_two : hexPivot 2 = 2 * metaPivot - 1 := sorry

theorem hexPivot_four : hexPivot 4 = 2 * metaPivot - zeta6 := sorry

/-- Every pivot's anchor partner sits one unit away: the six ladders are M24
families. -/
theorem dist_hexPivot_anchor (a : ZMod 6) : dist (hexPivot a) (hexPivot a + 1) = 1 :=
  sorry

/-- Second neighbours are unit-separated: the six unit pairs of the hexagram. -/
theorem dist_hexPivot_unit (a : ZMod 6) :
    dist (hexPivot a) (hexPivot (a + 2)) = 1 := sorry

/-- Hexagon neighbours sit at the inner radius. -/
theorem dist_hexPivot_adjacent (a : ZMod 6) :
    dist (hexPivot a) (hexPivot (a + 1)) = Real.sqrt 3 / 3 := sorry

/-- Every pivot sits at the inner radius from the metapivot. -/
theorem dist_hexPivot_meta (a : ZMod 6) :
    dist (hexPivot a) metaPivot = Real.sqrt 3 / 3 := sorry

/-- Opposite pivots sit at twice the inner radius — the tangency distance. -/
theorem dist_hexPivot_opposite (a : ZMod 6) :
    dist (hexPivot a) (hexPivot (a + 3)) = 2 * (Real.sqrt 3 / 3) := sorry

/-- The hexagram: the six pivot ladders (outer and inner) and the metapivot's. -/
noncomputable def hexagram : Set ℂ :=
  (⋃ a : ZMod 6, ({z | ∃ x b, z = outerPt (hexPivot a) (hexPivot a + 1) x b}
    ∪ {z | ∃ x b, z = innerPt (hexPivot a) (hexPivot a + 1) x b}))
  ∪ ({z | ∃ x b, z = outerPt metaPivot metaAnchor x b}
    ∪ {z | ∃ x b, z = innerPt metaPivot metaAnchor x b})

theorem outer_mem_hexagram (a : ZMod 6) (x : ZMod 6) (b : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b ∈ hexagram :=
  Or.inl (Set.mem_iUnion.mpr ⟨a, Or.inl ⟨x, b, rfl⟩⟩)

theorem inner_mem_hexagram (a : ZMod 6) (x : ZMod 6) (b : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b ∈ hexagram :=
  Or.inl (Set.mem_iUnion.mpr ⟨a, Or.inr ⟨x, b, rfl⟩⟩)

theorem metaOuter_mem_hexagram (x : ZMod 6) (b : ℤ) :
    outerPt metaPivot metaAnchor x b ∈ hexagram := Or.inr (Or.inl ⟨x, b, rfl⟩)

theorem metaInner_mem_hexagram (x : ZMod 6) (b : ℤ) :
    innerPt metaPivot metaAnchor x b ∈ hexagram := Or.inr (Or.inr ⟨x, b, rfl⟩)

/-- M25's four-ladder object is the sub-object at pivot addresses `{3, 5, 1}` plus
the meta ladder: the χ ≥ 4 witness transports. -/
theorem fourLadder_subset_hexagram : fourLadder ⊆ hexagram := sorry

/-! ## §T Transport: the 60° rotation about the metapivot -/

/-- The 60° rotation about the metapivot — the hexagram's cyclic symmetry, the
square root of M25's 120° transport. -/
noncomputable def rot6 (z : ℂ) : ℂ := metaPivot + zeta6 * (z - metaPivot)

theorem dist_rot6 (z w : ℂ) : dist (rot6 z) (rot6 w) = dist z w := sorry

theorem rot6_inj {z w : ℂ} (h : rot6 z = rot6 w) : z = w := sorry

/-- Two steps of `rot6` are M25's 120° rotation — the transport kits compose. -/
theorem rot6_rot6 (z : ℂ) :
    rot6 (rot6 z) = metaPivot + zeta6 ^ 2 * (z - metaPivot) := sorry

/-- `rot6` cycles the pivots along the meta-inner address. -/
theorem rot6_hexPivot (a : ZMod 6) : rot6 (hexPivot a) = hexPivot (a + 1) := sorry

/-- `rot6` carries pivot `a`'s outer ladder to pivot `a+1`'s at address `+1`. -/
theorem rot6_outer (a : ZMod 6) (x : ZMod 6) (b : ℤ) :
    rot6 (outerPt (hexPivot a) (hexPivot a + 1) x b)
      = outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) (x + 1) b := sorry

theorem rot6_inner (a : ZMod 6) (x : ZMod 6) (b : ℤ) :
    rot6 (innerPt (hexPivot a) (hexPivot a + 1) x b)
      = innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) (x + 1) b := sorry

/-- `rot6` fixes the metapivot's ladder up to the `+1` shift. -/
theorem rot6_metaOuter (x : ZMod 6) (b : ℤ) :
    rot6 (outerPt metaPivot metaAnchor x b)
      = outerPt metaPivot metaAnchor (x + 1) b := sorry

theorem rot6_metaInner (x : ZMod 6) (b : ℤ) :
    rot6 (innerPt metaPivot metaAnchor x b)
      = innerPt metaPivot metaAnchor (x + 1) b := sorry

/-! ## §A The adjacent master web — hexagon neighbours, separation `ḡ/3`

Master frame `(hexPivot 3, hexPivot 4) = (0, 2m−ζ₆)`; every web `(a, a+1)` is its
`rot6^(a−3)` image, so the tables read at the shift `a − 3`.  Census-exact:
oo is EMPTY, oi/io/ii carry four sporadics each, every fusion is EMPTY. -/

/-- oi sporadics, master frame: `outer(0) ↔ inner(2m−ζ₆)`. -/
def adjOITable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(2, -2, 4, -1), (2, 2, 4, 1), (3, -2, 1, -1), (3, 2, 1, 1)]

/-- io sporadics, master frame. -/
def adjIOTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(1, -1, 5, -2), (1, 1, 5, 2), (4, -1, 0, -2), (4, 1, 0, 2)]

/-- ii sporadics, master frame. -/
def adjIITable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(0, -1, 2, -1), (0, 1, 2, 1), (5, -1, 3, -1), (5, 1, 3, 1)]

/-- **Adjacent oo is empty**: no unit chord joins the outer circles of hexagon
neighbours' lattices. -/
theorem adj_oo_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) ≠ 1 := sorry

/-- **Adjacent oi completeness, all six webs**: exactly the four table chords. -/
theorem adj_oi_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ adjOITable := sorry

/-- **Adjacent io completeness, all six webs.** -/
theorem adj_io_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ adjIOTable := sorry

/-- **Adjacent ii completeness, all six webs.** -/
theorem adj_ii_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ adjIITable := sorry

/-- The adjacent oo fusion is empty. -/
theorem adj_fusion_oo (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := sorry

/-- The adjacent oi fusion is empty (mutual inner-circle membership is a fact about
the CENTRES, which are never lattice points of the partner's ladder). -/
theorem adj_fusion_oi (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := sorry

theorem adj_fusion_io (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := sorry

theorem adj_fusion_ii (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 1)) (hexPivot (a + 1) + 1) y d := sorry

/-! ## §O The opposite master web — the tangent pairs, separation `2g/3`

Master frame `(hexPivot 3, hexPivot 0) = (0, 2m)`.  The masters carry doubled
`g`-coefficients at REFLECTED addresses (`Tr(g·w̄)` — the §0 orientation
correction).  Census-exact: oo carries four sporadics, oi/io/ii are EMPTY, every
fusion is EMPTY — the triple tangency at `m` never touches the lattice. -/

/-- oo sporadics, master frame: `outer(0) ↔ outer(2m)`. -/
def oppOOTable : List (ZMod 6 × ℤ × ZMod 6 × ℤ) :=
  [(3, -2, 1, -2), (3, 2, 1, 2), (4, -2, 0, -2), (4, 2, 0, 2)]

/-- **Opposite oo completeness, all webs**: exactly the four table chords. -/
theorem opp_oo_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ oppOOTable := sorry

/-- **Opposite oi is empty.** -/
theorem opp_oi_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) ≠ 1 := sorry

/-- **Opposite io is empty** — the oi statement at `a + 3`, roles flipped. -/
theorem opp_io_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) ≠ 1 := sorry

/-- **Opposite ii is empty**: the tangent inner circles' lattices carry no unit
chord (and, by `opp_fusion_ii`, no coincidence — the tangency is invisible). -/
theorem opp_ii_empty (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d) ≠ 1 := sorry

/-- The opposite oo fusion is empty. -/
theorem opp_fusion_oo (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := sorry

/-- The opposite oi fusion is empty. -/
theorem opp_fusion_oi (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := sorry

/-- The opposite io fusion is empty — the oi statement at `a + 3`, flipped. -/
theorem opp_fusion_io (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := sorry

/-- The opposite ii fusion is empty: the tangency point `m` is never a lattice
word (M24's empty `Re = √3/2` fibre, at the κ = 6√3 spine). -/
theorem opp_fusion_ii (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt (hexPivot (a + 3)) (hexPivot (a + 3) + 1) y d := sorry

/-! ## §W The transported webs: pivot–meta at all six pivots, unit pairs

The pivot–meta statements extend M25's `Fin 3` quantifier to the full hexagon
(M25's shift `webShift j = 2j` is the restriction of `a − 3` to the odd
addresses); the unit-pair oo statement is M24's matching-∨-hub in hexagram
currency. -/

/-- **oo completeness at the metapivot axis, all SIX webs** (extends M25's
`meta_oo_complete`). -/
theorem hexMeta_oo_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt metaPivot metaAnchor y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ metaOOTable := sorry

/-- **oi completeness at the metapivot axis, all six webs**: the hub pencil
through the fused pivot plus the four sporadics. -/
theorem hexMeta_oi_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt metaPivot metaAnchor y d) = 1 ↔
      ((y = a ∧ d = 0) ∨ (x - (a - 3), b, y - (a - 3), d) ∈ metaOITable) := sorry

/-- **io completeness at the metapivot axis, all six webs.** -/
theorem hexMeta_io_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt metaPivot metaAnchor y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ metaIOTable := sorry

/-- **ii completeness at the metapivot axis, all six webs.** -/
theorem hexMeta_ii_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (innerPt (hexPivot a) (hexPivot a + 1) x b)
      (innerPt metaPivot metaAnchor y d) = 1 ↔
      (x - (a - 3), b, y - (a - 3), d) ∈ metaIITable := sorry

/-- **The oi fusion at all six webs**: pivot `a`'s outer lattice meets the
meta-inner lattice at exactly the two second-neighbour pivots. -/
theorem hexMeta_fusion_oi (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b = innerPt metaPivot metaAnchor y d ↔
      ((x = a - 2 ∧ b = 0 ∧ y = a - 2 ∧ d = 0)
        ∨ (x = a - 3 ∧ b = 0 ∧ y = a + 2 ∧ d = 0)) := sorry

/-- The oo fusion at the metapivot axis is empty at every pivot. -/
theorem hexMeta_fusion_oo (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    outerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt metaPivot metaAnchor y d := sorry

/-- The io fusion at the metapivot axis is empty at every pivot. -/
theorem hexMeta_fusion_io (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ outerPt metaPivot metaAnchor y d := sorry

/-- The ii fusion at the metapivot axis is empty at every pivot. -/
theorem hexMeta_fusion_ii (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    innerPt (hexPivot a) (hexPivot a + 1) x b
      ≠ innerPt metaPivot metaAnchor y d := sorry

/-- **Unit-pair oo, all six pairs, in hexagram currency**: the translation
matching or one of the two hub pencils (M24's `oo_complete` re-addressed —
`x = a−3, b = 0` is the point AT the far centre, `y = a, d = 0` the point at the
near one). -/
theorem unit_oo_complete (a : ZMod 6) (x : ZMod 6) (b : ℤ) (y : ZMod 6) (d : ℤ) :
    dist (outerPt (hexPivot a) (hexPivot a + 1) x b)
      (outerPt (hexPivot (a + 2)) (hexPivot (a + 2) + 1) y d) = 1 ↔
      ((y = x ∧ d = b) ∨ (x = a - 3 ∧ b = 0) ∨ (y = a ∧ d = 0)) := sorry

/-! ## §C The colouring: χ(hexagram) = 4

The rot6-equivariant table measured by the §0 probe (54 fused collapsed classes,
no self-loop; `colour(rot6 z) = τ(colour z)` with `τ` the 3-cycle `0→1→2→0`
fixing colour 3).  Row index: the pivot's meta-inner address `a`; column: the hex
address `x`; `b` never enters. -/

/-- The equivariance permutation: the 3-cycle `0 → 1 → 2 → 0`, colour 3 fixed. -/
def tau : Fin 4 → Fin 4 := ![1, 2, 0, 3]

/-- The pivot-ladder colour table, `false` = outer, `true` = inner; row `a`
(the pivot's address), column `x` (the hex address). -/
def hexColTab (circ : Bool) : ZMod 6 → ZMod 6 → Fin 4 :=
  if circ then
    ![![1, 2, 3, 3, 0, 1], ![2, 2, 0, 3, 3, 1], ![2, 0, 0, 1, 3, 3],
      ![3, 0, 1, 1, 2, 3], ![3, 3, 1, 2, 2, 0], ![1, 3, 3, 2, 0, 0]]
  else
    ![![2, 3, 2, 0, 2, 0], ![1, 0, 3, 0, 1, 0], ![1, 2, 1, 3, 1, 2],
      ![0, 2, 0, 2, 3, 2], ![0, 1, 0, 1, 0, 3], ![3, 1, 2, 1, 2, 1]]

/-- The metapivot-ladder colour table — τ-periodic by construction. -/
def hexMetaColTab (circ : Bool) : ZMod 6 → Fin 4 :=
  if circ then ![1, 2, 0, 1, 2, 0] else ![0, 1, 2, 0, 1, 2]

/-- The table is rot6-equivariant: the transported entry is the τ-image.  The fact
that collapses properness to one web per orbit. -/
theorem hexColTab_equivariant (circ : Bool) (a x : ZMod 6) :
    hexColTab circ (a + 1) (x + 1) = tau (hexColTab circ a x) := sorry

theorem hexMetaColTab_equivariant (circ : Bool) (x : ZMod 6) :
    hexMetaColTab circ (x + 1) = tau (hexMetaColTab circ x) := sorry

open Classical in
/-- The hexagram colouring: decode any address in priority order (pivot outer,
pivot inner, meta outer, meta inner), read the table.  Well-defined on fused
points because the table equalizes every coincidence the fusion classifications
allow.  Junk value `0` off the object. -/
noncomputable def hexColor (z : ℂ) : Fin 4 :=
  if h : ∃ n : ZMod 6 × ZMod 6 × ℤ,
      outerPt (hexPivot n.1) (hexPivot n.1 + 1) n.2.1 n.2.2 = z then
    hexColTab false h.choose.1 h.choose.2.1
  else if h : ∃ n : ZMod 6 × ZMod 6 × ℤ,
      innerPt (hexPivot n.1) (hexPivot n.1 + 1) n.2.1 n.2.2 = z then
    hexColTab true h.choose.1 h.choose.2.1
  else if h : ∃ n : ZMod 6 × ℤ, outerPt metaPivot metaAnchor n.1 n.2 = z then
    hexMetaColTab false h.choose.1
  else if h : ∃ n : ZMod 6 × ℤ, innerPt metaPivot metaAnchor n.1 n.2 = z then
    hexMetaColTab true h.choose.1
  else 0

/-- **Properness**: the table separates every unit chord of the hexagram. -/
theorem hexColor_valid {z w : ℂ} (hz : z ∈ hexagram) (hw : w ∈ hexagram)
    (h : dist z w = 1) : hexColor z ≠ hexColor w := sorry

theorem colorable_four_hexagram :
    ((unitDistance ℂ).induce hexagram).Colorable 4 := sorry

/-- The lower bound: M25's four-ladder object (hence M24's nine-point witness)
sits inside the hexagram. -/
theorem not_colorable_three_hexagram :
    ¬ ((unitDistance ℂ).induce hexagram).Colorable 3 := sorry

/-- **The M26 headline**: the hexagram is exactly 4-chromatic. -/
theorem chromaticNumber_hexagram :
    ((unitDistance ℂ).induce hexagram).chromaticNumber = 4 := sorry

/-! ## Spec examples — the statement-level gate at skeleton time -/

example : hexColTab false 3 0 = 0 := rfl
example : hexColTab true 0 0 = 1 := rfl
example : hexMetaColTab false 4 = 1 := rfl
example : tau 2 = 0 := rfl
example : ((2 : ZMod 6), (-2 : ℤ), (4 : ZMod 6), (-1 : ℤ)) ∈ adjOITable := by decide
example : ((0 : ZMod 6), (0 : ℤ), (0 : ZMod 6), (0 : ℤ)) ∉ oppOOTable := by decide

end Hexagram
end HadwigerNelson
