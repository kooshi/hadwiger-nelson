import Proofs.HadwigerNelson.PlaneRotation
import Proofs.HadwigerNelson.Instances.LocalGlobal19

/-!
# The record's four measured primes, re-derived from one theorem

`CLAUDE.md`'s ledger row 55 records, of M60, that *"the sealing planes at 3, 7, 11, 19 are ALL pairwise
free at their own chromatic number"* — four instances, each established by exhibiting a colouring table
and checking a decidable property of it. `PlaneRotation.finitePlane_forces_iff` proves that for **every**
prime `≡ 3 (mod 4)` at **every** colour count the plane admits, so the four are now corollaries. This
module is the evidence: all four, re-derived through the public surface, with no table beyond the
colouring each needs to be non-vacuous.

Two of the four instances were already kernel theorems and stay: `finitePlane3_forces_iff`
(`Instances/LocalGlobal19`, M61 — from **two** tables with no common period) and
`finitePlane11_forces_iff` (`Instances/ResidueObstruction11`, M60 — from one aperiodic table). At `7`
and `19` the record had measurements only.

Three of the four colourings were already in the kernel — `finitePlane3_colorable_three`
(`PlaneRotation`), `finitePlane11_colorable_five` (`Instances/FinitePlane11`, whose lower bound comes
from Heule-510's certified refusal), `finitePlane19_colorable_five` (`Instances/LocalGlobal19`). The
fourth, at `7`, is built here by the same periodic-quotient recipe: the line through `(1, 2)` has
quadrance `5`, a non-residue mod `7`, so the circle misses it, and the eight circle points project onto
`{1, 2, 5, 6} ⊆ ZMod 7`, along which the seven-entry table `[0,1,2,0,1,2,3]` is proper.

**What is new here and what is not.** The forces-freeness at `11` was already a kernel theorem
(`finitePlane11_forces_iff`, M60) — from a *table* with two decidable properties, at that one prime.
At `3`, `7` and `19` it was measured and not proved. All four now follow from the general theorem, and
so does every prime `≡ 3 (mod 4)` whose plane anyone ever colours.
-/

namespace HadwigerNelson

open SimpleGraph

instance : Fact (Nat.Prime 7) := ⟨by decide⟩
instance : Fact (Nat.Prime 19) := ⟨by decide⟩

/-! ### The missing colouring: `UD(𝔽₇, 2)` in four colours -/

/-- The circle's projections along `(1, 2)` at `7`: four residues, symmetric, without `0`. -/
def circ7D : Finset (ZMod 7) := {1, 2, 5, 6}

/-- The circle misses the kernel of the projection at `7`: the line through `(1, 2)` has quadrance `5`,
a non-residue, so it meets no point of quadrance `1`. -/
theorem circ7_ker : ∀ s ∈ unitCircle (ZMod 7), projAlong ((1 : ZMod 7), (2 : ZMod 7)) s ≠ 0 := by decide

/-- The circle projects into `circ7D`. -/
theorem circ7_image : ∀ s ∈ unitCircle (ZMod 7), projAlong ((1 : ZMod 7), (2 : ZMod 7)) s ∈ circ7D := by
  decide

/-- A 4-colouring of the circulant `Cay(ZMod 7, circ7D)`: its independent sets have at most two
elements (`⌊7/3⌋`), so four colours are also the fewest. -/
def circ7Table : ZMod 7 → Fin 4 := ![0, 1, 2, 0, 1, 2, 3]

/-- The table is proper along `circ7D`. -/
theorem circ7_proper : ∀ d ∈ circ7D, ∀ x : ZMod 7, circ7Table (x + d) ≠ circ7Table x := by decide

/-- **`UD(𝔽₇, 2)` is 4-colourable, periodically** — the seven-entry certificate. (Vinh 2005 computed
`χ = 4` here; the refusal of three is not in the kernel.) -/
theorem finitePlane7_colorable_four : (finitePlane 7).Colorable 4 :=
  unitQuadrance_colorable_of_quotient (projAlong (1, 2)) circ7_ker circ7_image circ7Table circ7_proper

/-! ### The four instances -/

/-- `UD(𝔽₃, 2)` has no forced pair at three colours. M61 proved this at `Instances/LocalGlobal19` by
exhibiting **two** tables with no common period (`finitePlane3_no_common_period`); it is now an instance
of the general theorem, and both statements stand — the derivation reproduces the measurement rather
than erasing it. -/
theorem finitePlane3_forces_eq : ∀ u v : ZMod 3 × ZMod 3, Forces (finitePlane 3) 3 u v → u = v :=
  finitePlane_forces_eq (by decide) finitePlane3_colorable_three

/-- `UD(𝔽₇, 2)` has no forced pair at four colours — measured at M60, now proved. -/
theorem finitePlane7_forces_eq : ∀ u v : ZMod 7 × ZMod 7, Forces (finitePlane 7) 4 u v → u = v :=
  finitePlane_forces_eq (by decide) finitePlane7_colorable_four

/-- `UD(𝔽₁₁, 2)` has no forced pair at five colours. M60 proved this from a table with two decidable
properties (`finitePlane11_forces_iff`); it is now an instance of the general theorem, and the two
agree — the derivation reproduces the measurement rather than replacing it. -/
theorem finitePlane11_forces_eq : ∀ u v : ZMod 11 × ZMod 11, Forces (finitePlane 11) 5 u v → u = v :=
  finitePlane_forces_eq (by decide) finitePlane11_colorable_five

/-- `UD(𝔽₁₉, 2)` has no forced pair at five colours — measured at M60, now proved. -/
theorem finitePlane19_forces_eq : ∀ u v : ZMod 19 × ZMod 19, Forces (finitePlane 19) 5 u v → u = v :=
  finitePlane_forces_eq (by decide) finitePlane19_colorable_five

-- M61's two-table theorem at `3` and the general one give the same statement.
example {x y : ZMod 3 × ZMod 3} : Forces (finitePlane 3) 3 x y ↔ x = y := finitePlane3_forces_iff
example {x y : ZMod 3 × ZMod 3} : Forces (finitePlane 3) 3 x y ↔ x = y :=
  finitePlane_forces_iff (by decide) finitePlane3_colorable_three

-- The table-based theorem of M60 and the general one give the same statement at `11`.
example {x y : ZMod 11 × ZMod 11} : Forces (finitePlane 11) 5 x y ↔ x = y := finitePlane11_forces_iff
example {x y : ZMod 11 × ZMod 11} : Forces (finitePlane 11) 5 x y ↔ x = y :=
  finitePlane_forces_iff (by decide) finitePlane11_colorable_five

-- The freedom is not a property of the chromatic number: `UD(𝔽₁₁, 2)` is also free at SIX colours,
-- where no table was ever computed, through the periodic six-colouring of `Instances/LocalGlobal19`.
example : ∀ u v : ZMod 11 × ZMod 11, Forces (finitePlane 11) 6 u v → u = v :=
  finitePlane_forces_eq (by decide) finitePlane11_colorable_six_periodic

end HadwigerNelson
