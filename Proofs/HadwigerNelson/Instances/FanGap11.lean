import Proofs.HadwigerNelson.FanGap
import Proofs.HadwigerNelson.Instances.ResidueObstruction11
import Proofs.HadwigerNelson.LocalGlobal
import Proofs.HadwigerNelson.PlaneRotation
import Mathlib.NumberTheory.Padics.RingHoms

/-!
# The plane at `11` is slack and doubly slack: no pair compulsion at five colours over any field it seals

Two `decide`s on two 121-entry tables. **The gap**: the certified 5-colouring `finitePlane11Colouring` shows only three
colours on the twelve neighbours of `(2, 4)` (own colour `1`, neighbours `{0, 3, 4}`, gap `2`); by translation every
vertex has a gapped colouring (`finitePlane11_slack`). **The shared gap**: a second table (`finitePlane11DoubleGapTable`,
found by SAT, `data/fs38/doublegap-p11-k5.json`) has colour `4` absent from `N[(0,0)] ∪ N[(1,0)]`; translation and
rotation (`rotHom`) carry every edge onto that one, and M60's coincidences cover the non-adjacent pairs, so every pair
of the plane is fusable (`finitePlane11_pairwiseFusable`).

**What follows, for every graph `G` with a homomorphism into the plane** (`FanGap.lean`): `Forces G 5 u u' ↔ u = u'`
and `Separated G 5 u u' ↔ G.Adj u u'` — the plane's whole arity-2 compulsion structure at five colours pulls back. The
instances here: `unitQuadrance R` for every ring `R` mapping to `ZMod 11` — the tower `ZMod (11 ^ m)`, the completion
`ℤ_[11]`, the ramified integers `Adjoin 11 ℤ_[11]` of Heule's completion; every `Valid` `√7`-free certificate with
`11 ∤ D` (M60's hypothesis, through `Q4.sevenFree.res11`); and **Heule-510**, where the same-residue pair `(0, 475)` that
M60's residue law could not refute is refuted here, and the `5/3` pair `(19, 59)` on which M60 and this agree.

**What is not claimed.** The field-level sentence (every unit-distance graph over Heule's field is such a certificate:
translate, then unit vectors are `𝔭`-integral) is the hand step of M58/M60 and is not formalized. Nothing about fields
where no plane at a usable prime is 5-colourable (de Grey's, at `131`). Arity 2 only: a fan whose class has a partner on
the gap colour in every gapped colouring is not touched (`not_fan_of_fanGap`'s hypothesis).
-/

set_option maxRecDepth 100000

namespace HadwigerNelson

open SimpleGraph

/-! ### The gap in the certified table -/

/-- **The gap**: colour `2` is absent from `N[(2, 4)]` in the certified table — twelve lookups. -/
theorem finitePlane11_fanGap : FanGap finitePlane11Colouring.toColoring (2, 4) 2 := by
  decide +kernel

/-- Red: a colour that IS on the neighbourhood is refused as a gap (`0` is on `N(2, 4)`). -/
theorem finitePlane11_not_fanGap_zero : ¬ FanGap finitePlane11Colouring.toColoring (2, 4) 0 := by
  decide +kernel

/-- **`UD(𝔽₁₁, 2)` is slack at five colours.** -/
theorem finitePlane11_slack : Slack (finitePlane 11) 5 :=
  slack_addCayley_of_fanGap finitePlane11_fanGap

/-! ### The shared gap -/

/-- The 5-colouring with colour `4` absent from `N[(0,0)] ∪ N[(1,0)]`, found by SAT and verified
(`data/fs38/doublegap-p11-k5.json`): row `x`, column `y`. Untrusted data; the two `decide`s below are the check. -/
def finitePlane11DoubleGapTable : Fin 11 → Fin 11 → Fin 5 :=
  ![![0,2,0,1,4,3,0,3,1,4,3],
    ![3,0,1,2,3,4,3,0,2,1,2],
    ![0,4,3,0,2,0,4,3,1,2,1],
    ![1,2,4,3,0,1,3,4,3,0,2],
    ![2,1,3,0,3,0,1,2,0,4,1],
    ![3,2,4,3,4,3,2,0,1,3,4],
    ![4,0,1,2,1,4,0,1,2,1,2],
    ![3,4,3,1,2,0,3,4,1,2,4],
    ![4,1,4,2,1,2,1,3,2,0,1],
    ![1,2,3,4,0,1,2,4,3,4,0],
    ![2,1,2,0,3,2,1,2,4,3,1]]

/-- The shared-gap table as a function on the plane. -/
def finitePlane11DoubleGapColouring (v : ZMod 11 × ZMod 11) : Fin 5 :=
  finitePlane11DoubleGapTable v.1 v.2

-- The data, pinned.
#guard finitePlane11DoubleGapTable 0 0 = 0
#guard finitePlane11DoubleGapTable 1 0 = 3
#guard finitePlane11DoubleGapTable 10 10 = 1

/-- Proper: decided over every pair of points. -/
theorem finitePlane11_doubleGap_proper :
    ∀ {u v : ZMod 11 × ZMod 11}, (finitePlane 11).Adj u v →
      finitePlane11DoubleGapColouring u ≠ finitePlane11DoubleGapColouring v := by
  decide +kernel

/-- The shared-gap colouring, bundled with its properness — the inhabitant the vacuity gate reads. -/
def finitePlane11DoubleGapColoring : (finitePlane 11).Coloring (Fin 5) :=
  Coloring.mk finitePlane11DoubleGapColouring finitePlane11_doubleGap_proper

/-- **The shared gap at the base edge**: colour `4` is absent from both closed neighbourhoods — `22` lookups. -/
theorem finitePlane11_sharedGap : SharedGap finitePlane11DoubleGapColoring (0, 0) (1, 0) 4 :=
  -- One `decide` per closed neighbourhood, through `FanGap`'s own instance: `SharedGap` is left
  -- without a `Decidable` instance of its own, so nothing global is minted for this one table.
  ⟨by decide +kernel, by decide +kernel⟩

/-- Red: the base table with `(0, 0)` overwritten by the gap colour is refused as a shared gap (the M04 "corrupted
table" control, on this table). -/
theorem finitePlane11_sharedGap_corrupt_refused :
    ¬ ∃ C : (finitePlane 11).Coloring (Fin 5),
      (∀ v, v ≠ (0, 0) → C v = finitePlane11DoubleGapColouring v) ∧ C (0, 0) = 4 ∧
        SharedGap C (0, 0) (1, 0) 4 := by
  rintro ⟨C, -, h00, hSG⟩
  exact hSG.1.1 h00.symm

/-- **Every pair of `UD(𝔽₁₁, 2)` is fusable at five colours**: adjacent pairs by the shared gap transported
(`unitQuadrance_fusable_of_sharedGap_base`), the rest by M60's coincidences (`finitePlane11_separated_iff` read as
`¬ Separated`). -/
theorem finitePlane11_pairwiseFusable : PairwiseFusable (finitePlane 11) 5 := by
  intro v w
  by_cases hadj : (finitePlane 11).Adj v w
  · exact unitQuadrance_fusable_of_sharedGap_base finitePlane11_sharedGap hadj
  · exact fusable_of_not_separated fun hS => hadj (finitePlane11_separated_iff.mp hS)

/-! ### Every graph mapping into the plane -/

section Hom

variable {V : Type*} {G : SimpleGraph V}

theorem forces_eq_of_hom_finitePlane11 (f : G →g finitePlane 11) {u u' : V} (h : Forces G 5 u u') :
    u = u' :=
  finitePlane11_slack.forces_eq_of_hom f h

theorem forces_iff_of_hom_finitePlane11 (f : G →g finitePlane 11) {u u' : V} :
    Forces G 5 u u' ↔ u = u' :=
  finitePlane11_slack.forces_iff_of_hom f

/-- **Virtual edges are edges** for every graph mapping into the plane at `11`. -/
theorem separated_iff_adj_of_hom_finitePlane11 (f : G →g finitePlane 11) {u u' : V} :
    Separated G 5 u u' ↔ G.Adj u u' :=
  finitePlane11_pairwiseFusable.separated_iff_adj_of_hom f

end Hom

/-! ### The tower and the completions -/

/-- The level-`m` plane `UD(ℤ/11^m, 2)`, every `m ≥ 1`: forced equal is equal. An instance, not an induction. -/
theorem zmodPow11_forces_eq {m : ℕ} (hm : m ≠ 0) {u v : ZMod (11 ^ m) × ZMod (11 ^ m)}
    (h : Forces (unitQuadrance (ZMod (11 ^ m))) 5 u v) : u = v :=
  unitQuadrance_forces_eq_of_ringHom (ZMod.castHom (dvd_pow_self 11 hm) (ZMod 11)) finitePlane11_slack h

/-- The integral `11`-adic plane, through Mathlib's `PadicInt.toZMod` — no hand step. -/
theorem padicInt11_forces_eq {u v : ℤ_[11] × ℤ_[11]} (h : Forces (unitQuadrance ℤ_[11]) 5 u v) : u = v :=
  unitQuadrance_forces_eq_of_ringHom PadicInt.toZMod finitePlane11_slack h

theorem padicInt11_separated_iff_adj {u v : ℤ_[11] × ℤ_[11]} :
    Separated (unitQuadrance ℤ_[11]) 5 u v ↔ (unitQuadrance ℤ_[11]).Adj u v :=
  separated_iff_adj_of_hom_finitePlane11 (unitQuadrance.map PadicInt.toZMod)

noncomputable instance : NatScalar ℤ_[11] := ⟨fun n x => (n : ℤ_[11]) * x, fun _ _ => rfl⟩

/-- The residue map of Heule's completion's integers `ℤ₁₁[√11]`: `√11 ↦ 0`. -/
noncomputable def adjoin11PadicRes : Adjoin 11 ℤ_[11] →+* ZMod 11 :=
  Adjoin.lift PadicInt.toZMod 0 (by decide)

theorem adjoin11_padicInt11_forces_eq {u v : Adjoin 11 ℤ_[11] × Adjoin 11 ℤ_[11]}
    (h : Forces (unitQuadrance (Adjoin 11 ℤ_[11])) 5 u v) : u = v :=
  unitQuadrance_forces_eq_of_ringHom adjoin11PadicRes finitePlane11_slack h

/-! ### Certificates -/

variable {n : ℕ}

/-- **Corollary 2, certificate form**: every `Valid` `√7`-free certificate with `11 ∤ D` has no two vertices forced
equal at five colours — M60's hypotheses exactly, and every pair. -/
theorem UDCert.forces_eq_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {i j : Fin n}
    (h : Forces (edgeGraph n c.edges) 5 i j) : i = j :=
  c.forces_eq_of_slack Q4.sevenFree.res11 hS hu hv finitePlane11_slack h

theorem UDCert.separated_iff_adj_11 (c : UDCert n) (hS : c.CoordsIn Q4.sevenFree) {u : ZMod 11}
    (hu : u * c.denom = 1) (hv : c.Valid = true) {i j : Fin n} :
    Separated (edgeGraph n c.edges) 5 i j ↔ (edgeGraph n c.edges).Adj i j :=
  c.separated_iff_adj_of_fusable Q4.sevenFree.res11 hS hu hv finitePlane11_pairwiseFusable

/-! ### Heule-510: the measured null of M63 phase H4, as a theorem -/

theorem heule510_forces_eq {i j : Fin 510} (h : Forces (edgeGraph 510 heule510.edges) 5 i j) : i = j :=
  forces_eq_of_hom_finitePlane11 heule510Reduce11 h

theorem heule510_forces_iff {i j : Fin 510} : Forces (edgeGraph 510 heule510.edges) 5 i j ↔ i = j :=
  forces_iff_of_hom_finitePlane11 heule510Reduce11

theorem heule510_separated_iff_adj {i j : Fin 510} :
    Separated (edgeGraph 510 heule510.edges) 5 i j ↔ (edgeGraph 510 heule510.edges).Adj i j :=
  separated_iff_adj_of_hom_finitePlane11 heule510Reduce11

/-- No pair compulsion at five colours, and 5-colourable: the arity floor is at least `3`. -/
theorem three_le_arityFloor_heule510 : 3 ≤ arityFloor (edgeGraph 510 heule510.edges) 5 :=
  three_le_arityFloor_of_forces_eq_of_separated_adj heule510_colorable_five (fun _ _ h => heule510_forces_eq h)
    (fun _ _ h => heule510_separated_iff_adj.mp h)

/-- The pair M60 was silent on: vertices `0` and `475` have the SAME residue (`(0, 0)`), so their squared distance is
`≡ 0 (mod 11)` and the residue law says nothing. -/
theorem heule510_residue_zero_eq_475 : heule510Reduce11 0 = heule510Reduce11 475 := by
  decide +kernel

example : ¬ Forces (edgeGraph 510 heule510.edges) 5 0 475 :=
  fun h => absurd (heule510_forces_eq h) (by decide)

/-- The control on which M60 (`not_forces_five_thirds_11`) and this agree: the `5/3` pair `(19, 59)`. -/
example : ¬ Forces (edgeGraph 510 heule510.edges) 5 19 59 :=
  fun h => absurd (heule510_forces_eq h) (by decide)

end HadwigerNelson
