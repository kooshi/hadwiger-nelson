import Proofs.HadwigerNelson.LocalGlobal
import Proofs.HadwigerNelson.Instances.ResidueObstruction11
import Proofs.HadwigerNelson.Instances.OneDefectSpec

/-!
# Instances: the 19-plane's periodic 5-colouring, the 3-plane forces-free, and the spindle theorem at 11

* **`χ(UD(𝔽₁₉, 2)) ≤ 5` by a nineteen-entry table.** The projection along the null direction `(1, 1)` (norm `2`, a
  non-residue mod `19`) carries the circle to ten residues `circ19D` and never to `0`; a 5-colouring of the circulant
  `Cay(ZMod 19, circ19D)` — the table found by SAT and checked here along `circ19D` — pulls back to a periodic
  5-colouring of the plane (`unitQuadrance_colorable_of_quotient`). The 361-entry table of `data/fplane/chi-p19-k5.json`
  is not needed. The lower half (`19` refuses four colours) stays the solver's. The four null lines `y = x + c`,
  `c ∈ {0, 5, 8, 16}`, are an independent set of `76 = 4 · 19` points (`lines19_isIndepSet`), the fractional face's
  measured `α(19) ≥ 76` in the kernel.
* **The control at 11**: the same quotient carries the circle to `circ11D`, whose circulant needs SIX colours
  (`tools/fplane.py periodic`); the six-colouring is checked here, and the certified 5-colouring of the plane (M58) is
  aperiodic (M60) — the 11-plane's five is carried by non-periodic colourings only.
* **The 3-plane is forces-free at three colours** — every nonzero difference fails to be a period of one of two tables
  (`Forces.eq_of_forall_exists_not_periodic`) — so `Forces.no_hom_of_spindle_radicand` has a model below `11`: the
  rhombus drawn in `UD(𝔽₃, 2)` with its far corners at ONE point (their residues coincide, as the theorem's first step
  says they must), forcing them equal at three colours; the radicand hypothesis is then the only one a hom could fail,
  and it does (`√11` at `3`).
* **At 11, five colours**: the instance with `finitePlane11_forces_iff` — no graph forcing a pair equal at five colours
  reduces at `11` once its ring holds the pair's spindle radicand. No unit-distance graph is known to force a pair at
  five colours; the theorem says where such a pair's spindle must live (`plans/M61-local-global-tightness.md` §S5).
-/

namespace HadwigerNelson

open SimpleGraph

set_option maxRecDepth 100000

/-! ### The quotient at 19 -/

instance : Fact (1 < 19) := ⟨by decide⟩

/-- The circle's projections along `(1, 1)` at `19`: ten residues, symmetric, without `0`. -/
def circ19D : Finset (ZMod 19) := {1, 2, 4, 6, 9, 10, 13, 15, 17, 18}

/-- The circle misses the kernel of the projection at `19`: the direction `(1, 1)` is null. -/
theorem circ19_ker : ∀ s ∈ unitCircle (ZMod 19), projAlong ((1 : ZMod 19), (1 : ZMod 19)) s ≠ 0 := by decide

/-- The circle projects into `circ19D`. -/
theorem circ19_image : ∀ s ∈ unitCircle (ZMod 19), projAlong ((1 : ZMod 19), (1 : ZMod 19)) s ∈ circ19D := by
  decide

/-- The 5-colouring of the circulant `Cay(ZMod 19, circ19D)` (`tools/fplane.py periodic`; untrusted data). -/
def circ19Table : ZMod 19 → Fin 5 := ![0, 4, 3, 2, 4, 3, 2, 1, 0, 4, 3, 0, 4, 3, 2, 1, 0, 2, 1]

/-- The table is proper along `circ19D`. -/
theorem circ19_proper : ∀ d ∈ circ19D, ∀ x : ZMod 19, circ19Table (x + d) ≠ circ19Table x := by decide

/-- **`UD(𝔽₁₉, 2)` is 5-colourable, periodically** — the nineteen-entry certificate. -/
theorem finitePlane19_colorable_five : (finitePlane 19).Colorable 5 :=
  unitQuadrance_colorable_of_quotient (projAlong (1, 1)) circ19_ker circ19_image circ19Table circ19_proper

/-- **`χ(UD(𝔽₁₉, 2)) ≤ 5`.** The equality (four colours refused) is the solver's claim, `data/fplane/chi-p19-k4.json`. -/
theorem chromaticNumber_finitePlane19_le_five : (finitePlane 19).chromaticNumber ≤ 5 :=
  finitePlane19_colorable_five.chromaticNumber_le

/-- The pulled-back colouring has the period `(1, 1)` — a periodic colouring, unlike the certified table at `11`. -/
example : Function.Periodic (fun v : ZMod 19 × ZMod 19 => circ19Table (projAlong (1, 1) v)) (1, 1) :=
  periodic_comp_of_mem_ker _ circ19Table (projAlong_self _)

/-- The four null lines `y = x + c`, `c ∈ {0, 5, 8, 16}` — the lift of the circulant's independent set `{0, 5, 8, 16}`
(pairwise differences `3, 5, 8, 11, 14, 16`, none in `circ19D`). -/
def lines19 : Finset (ZMod 19 × ZMod 19) :=
  Finset.univ.filter fun v => v.2 - v.1 ∈ ({0, 5, 8, 16} : Finset (ZMod 19))

theorem lines19_card : lines19.card = 76 := by decide

/-- **`α(UD(𝔽₁₉, 2)) ≥ 76`**: the four lines are independent. -/
theorem lines19_isIndepSet : (finitePlane 19).IsIndepSet (lines19 : Set (ZMod 19 × ZMod 19)) := by
  decide +kernel

theorem indepNum_finitePlane19_ge : 76 ≤ (finitePlane 19).indepNum :=
  lines19_card ▸ lines19_isIndepSet.card_le_indepNum

/-! ### The control at 11: the quotient needs six -/

/-- The circle's projections along `(1, 1)` at `11`. -/
def circ11D : Finset (ZMod 11) := {1, 2, 3, 8, 9, 10}

theorem circ11_ker : ∀ s ∈ unitCircle (ZMod 11), projAlong ((1 : ZMod 11), (1 : ZMod 11)) s ≠ 0 := by decide

theorem circ11_image : ∀ s ∈ unitCircle (ZMod 11), projAlong ((1 : ZMod 11), (1 : ZMod 11)) s ∈ circ11D := by
  decide

/-- The circulant at `11` six-coloured (`tools/fplane.py periodic`: five is refused — the solver's claim). -/
def circ11Table : ZMod 11 → Fin 6 := ![0, 1, 2, 4, 3, 5, 1, 0, 3, 2, 4]

theorem circ11_proper : ∀ d ∈ circ11D, ∀ x : ZMod 11, circ11Table (x + d) ≠ circ11Table x := by decide

/-- Six colours periodically at `11` — one more than the plane needs (`chromaticNumber_finitePlane11 = 5`, M58), so
the plane's five is non-periodic: exactly what `finitePlane11_aperiodic` (M60) recorded of the certified table. -/
theorem finitePlane11_colorable_six_periodic : (finitePlane 11).Colorable 6 :=
  unitQuadrance_colorable_of_quotient (projAlong (1, 1)) circ11_ker circ11_image circ11Table circ11_proper

-- Red: a table that is NOT proper along the set is refused — the same table with one entry moved.
example : ¬ ∀ d ∈ circ11D, ∀ x : ZMod 11, (![0, 1, 2, 4, 3, 5, 1, 0, 3, 2, 0] : ZMod 11 → Fin 6) (x + d) ≠
    (![0, 1, 2, 4, 3, 5, 1, 0, 3, 2, 0] : ZMod 11 → Fin 6) x := by decide

/-! ### The 3-plane is forces-free at three colours -/

/-- The second table at `3`: `(x − y) mod 3`, a period at `(1, 1)`; M60's `finitePlane3Colouring` is `(x + y) mod 3`,
a period at `(1, 2)`. Together the two tables have no common nonzero period. -/
def finitePlane3ColouringDiff (v : ZMod 3 × ZMod 3) : Fin 3 :=
  (![![0, 2, 1], ![1, 0, 2], ![2, 1, 0]] : Fin 3 → Fin 3 → Fin 3) v.1 v.2

theorem finitePlane3Colouring_proper : ∀ {u v : ZMod 3 × ZMod 3}, (finitePlane 3).Adj u v →
    finitePlane3Colouring u ≠ finitePlane3Colouring v := by decide

theorem finitePlane3ColouringDiff_proper : ∀ {u v : ZMod 3 × ZMod 3}, (finitePlane 3).Adj u v →
    finitePlane3ColouringDiff u ≠ finitePlane3ColouringDiff v := by decide

/-- The two tables as colourings of the plane. -/
def finitePlane3Colouring.toColoring : (finitePlane 3).Coloring (Fin 3) :=
  Coloring.mk finitePlane3Colouring finitePlane3Colouring_proper

def finitePlane3ColouringDiff.toColoring : (finitePlane 3).Coloring (Fin 3) :=
  Coloring.mk finitePlane3ColouringDiff finitePlane3ColouringDiff_proper

/-- No nonzero difference is a period of both tables. -/
theorem finitePlane3_no_common_period : ∀ d : ZMod 3 × ZMod 3, d ≠ 0 →
    ¬ Function.Periodic finitePlane3Colouring d ∨ ¬ Function.Periodic finitePlane3ColouringDiff d := by
  decide

/-- **The 3-plane forces no pair equal at three colours** — two tables refute every candidate period; the shape of
M60's `finitePlane11_forces_iff`. -/
theorem finitePlane3_forces_iff {u v : ZMod 3 × ZMod 3} : Forces (finitePlane 3) 3 u v ↔ u = v :=
  ⟨Forces.eq_of_forall_exists_not_periodic fun d hd => (finitePlane3_no_common_period d hd).elim
      (fun h => ⟨finitePlane3Colouring.toColoring, h⟩) (fun h => ⟨finitePlane3ColouringDiff.toColoring, h⟩),
   fun h => h ▸ fun _ => rfl⟩

/-- M60's singleton case, re-derived through the family lemma: the 11 table alone. -/
example : ∀ u v : ZMod 11 × ZMod 11, Forces (finitePlane 11) 5 u v → u = v :=
  fun _ _ hf => Forces.eq_of_forall_exists_not_periodic
    (fun d hd => ⟨finitePlane11Colouring.toColoring, fun hper => hd (finitePlane11_aperiodic d hper)⟩) hf

/-! ### The spindle theorem's model: the rhombus in `UD(𝔽₃, 2)` -/

/-- Every listed edge of the rhombus lands on the circle (`edgeGraph` has no decidable adjacency by design; its
unfolding does). -/
theorem rhombusIn3_adj : ∀ a b : Fin 4, a ≠ b ∧ ((a, b) ∈ rhombus ∨ (b, a) ∈ rhombus) →
    (finitePlane 3).Adj ((![(2, 0), (0, 0), (1, 0), (2, 0)] : Fin 4 → ZMod 3 × ZMod 3) a)
      ((![(2, 0), (0, 0), (1, 0), (2, 0)] : Fin 4 → ZMod 3 × ZMod 3) b) := by
  decide

/-- The rhombus (`Gadget.rhombus`: the shared edge `1, 2`, the far corners `0, 3`) drawn in the 3-plane with its far
corners at one point: `1 ↦ (0,0)`, `2 ↦ (1,0)`, `0, 3 ↦ (2,0)` — the reduction of `rhombusCert` at `3`
(`√3 ↦ 0`, `1/2 ↦ 2`), written directly. -/
def rhombusIn3 : edgeGraph 4 rhombus →g finitePlane 3 where
  toFun i := (![(2, 0), (0, 0), (1, 0), (2, 0)] : Fin 4 → ZMod 3 × ZMod 3) i
  map_rel' {a b} h := rhombusIn3_adj a b (edgeGraph_adj.mp h)

/-- The far corners' residues coincide — the theorem's first step, seen on the model. -/
example : rhombusIn3 0 = rhombusIn3 3 := rfl

/-- **The rhombus at 3, the model of every hypothesis but the radicand**: the pair is forced
(`rhombus_forces_of_gadget`), the plane is forces-free, the drawing is a hom. With `R = ZMod 3` itself the radicand
hypothesis is then unsatisfiable — `x² = (4·0 − 1)·e² = −e²` has no solution with `e ≠ 0` — which is the theorem's
content: the spindle over the rhombus's pair (`√11`) cannot be drawn where the rhombus reduces. -/
theorem rhombus_spindle_no_hom_3 {x e : ZMod 3}
    (hx : x ^ 2 = (4 * quadrance (rhombusIn3 0 - rhombusIn3 3) - 1) * e ^ 2) (he : e ≠ 0) : False :=
  Forces.no_hom_of_spindle_radicand (by decide) (fun _ _ hf => finitePlane3_forces_iff.mp hf) rhombusIn3 (RingHom.id _)
    rhombus_forces_of_gadget hx he

-- And directly: in `ZMod 3` the radicand equation has no solution with `e ≠ 0` — the theorem is not vacuous by accident.
#guard decide (∀ x e : ZMod 3, x ^ 2 = -(e ^ 2) → e = 0)

/-! ### At 11, five colours -/

/-- **A pair forced equal at five colours has a spindle that no reduction at 11 survives**, for any graph drawn in a
ring `R` and any `φ : R →+* ZMod 11`. -/
theorem Forces.no_hom_of_spindle_radicand_11 {V R : Type*} {G : SimpleGraph V} [CommRing R]
    (g : G →g unitQuadrance R) (φ : R →+* ZMod 11) {u v : V} (h : Forces G 5 u v) {x e : R}
    (hx : x ^ 2 = (4 * quadrance (g u - g v) - 1) * e ^ 2) (he : φ e ≠ 0) : False :=
  Forces.no_hom_of_spindle_radicand (by decide) (fun _ _ hf => finitePlane11_forces_iff.mp hf) g φ h hx he

/-- The field-level reading at `11`: such a ring has no reduction at `11` at all. -/
theorem Forces.isEmpty_ringHom_of_spindle_radicand_11 {V R : Type*} {G : SimpleGraph V} [CommRing R]
    (g : G →g unitQuadrance R) {u v : V} (h : Forces G 5 u v) {x e : R}
    (hx : x ^ 2 = (4 * quadrance (g u - g v) - 1) * e ^ 2) (he : IsUnit e) : IsEmpty (R →+* ZMod 11) :=
  Forces.isEmpty_ringHom_of_spindle_radicand (by decide) (fun _ _ hf => finitePlane11_forces_iff.mp hf) g h hx he

end HadwigerNelson
