import Proofs.HadwigerNelson.FanGap
import Proofs.HadwigerNelson.Instances.LocalGlobal19
import Proofs.HadwigerNelson.LocalGlobal
import Mathlib.NumberTheory.Padics.RingHoms

/-!
# The plane at `19` is slack at five colours

The kernel's own 5-colouring of `UD(𝔽₁₉, 2)` — `circ19Table` composed with the projection along `(1, 1)`
(`Instances/LocalGlobal19.lean`), which sends `(x, y)` to `y − x` — has a gap: on the class `y − x = 4`, witnessed by the
vertex `(0, 4)`, the colour is `4` and the ten neighbour classes show `{0, 2, 3}`, so colour `1` is absent (ten lookups).
Hence every graph with a homomorphism into the plane at `19` is free of five-colour forced pairs: the tower
`ZMod (19 ^ m)`, the completion `ℤ_[19]`. Exactly two of the nineteen classes are gapped — `4` and `10`, each with the
single gap colour `1` — so the witness is not generic and the vertex matters: at `(4, 0)`, whose class is `y − x = −4 = 15`,
all five colours appear on the closed neighbourhood and there is no gap at all.

`19` is of residue degree one only over fields without `√3` (`3` is a non-residue mod `19`; e.g. `ℚ(√5, √11)`), where no
object of this repository lives. The virtual-edge half (`Separated ↔ Adj`) is NOT stated at `19`: this colouring fails
`CoincidesAtNonedges` at the shifts `7` and `12`, and a coinciding table is not held (FS-38 §S8, decision 10).
-/

set_option maxRecDepth 100000

namespace HadwigerNelson

open SimpleGraph

instance fanGap19_factPrime : Fact (Nat.Prime 19) := ⟨by decide⟩

/-- The periodic 5-colouring, as a function on the plane. -/
def finitePlane19QuotColouring (v : ZMod 19 × ZMod 19) : Fin 5 :=
  circ19Table (projAlong (1, 1) v)

#guard circ19Table 4 = 4

/-- Proper — DERIVED, not decided: an edge's difference lies on the circle, so its projection along `(1, 1)` is nonzero
(`circ19_ker`) and in `circ19D` (`circ19_image`), where `circ19Table` never repeats (`circ19_proper`); `map_sub` turns the
projection of the difference into the difference of projections. The argument inside `unitQuadrance_colorable_of_quotient`,
replayed for this named colouring. -/
theorem finitePlane19QuotColouring_proper :
    ∀ {u v : ZMod 19 × ZMod 19}, (finitePlane 19).Adj u v →
      finitePlane19QuotColouring u ≠ finitePlane19QuotColouring v := by
  intro u v h
  rw [unitQuadrance_adj] at h
  obtain ⟨-, hq⟩ := h
  have hmem : u - v ∈ unitCircle (ZMod 19) := by
    show (u - v).1 ^ 2 + (u - v).2 ^ 2 = 1
    simpa only [Prod.fst_sub, Prod.snd_sub] using hq
  have hD : projAlong ((1 : ZMod 19), (1 : ZMod 19)) (u - v) ∈ circ19D := circ19_image _ hmem
  have hkey := circ19_proper _ hD (projAlong ((1 : ZMod 19), (1 : ZMod 19)) v)
  have he : projAlong ((1 : ZMod 19), (1 : ZMod 19)) v
      + projAlong ((1 : ZMod 19), (1 : ZMod 19)) (u - v)
      = projAlong ((1 : ZMod 19), (1 : ZMod 19)) u := by
    rw [map_sub]
    abel
  rw [he] at hkey
  exact hkey

/-- The periodic colouring, bundled with its properness. -/
def finitePlane19QuotColoring : (finitePlane 19).Coloring (Fin 5) :=
  Coloring.mk finitePlane19QuotColouring finitePlane19QuotColouring_proper

/-- **The gap at `19`**: colour `1` is absent from `N[(0, 4)]` — the class `y − x = 4`. -/
theorem finitePlane19_fanGap : FanGap finitePlane19QuotColoring (0, 4) 1 := by
  decide +kernel

/-- Red: a present colour is refused as a gap (`0` is on `N(0, 4)`). -/
theorem finitePlane19_not_fanGap_zero : ¬ FanGap finitePlane19QuotColoring (0, 4) 0 := by
  decide +kernel

theorem finitePlane19_slack : Slack (finitePlane 19) 5 :=
  slack_addCayley_of_fanGap finitePlane19_fanGap

section Hom

variable {V : Type*} {G : SimpleGraph V}

theorem forces_eq_of_hom_finitePlane19 (f : G →g finitePlane 19) {u u' : V} (h : Forces G 5 u u') :
    u = u' :=
  finitePlane19_slack.forces_eq_of_hom f h

end Hom

theorem zmodPow19_forces_eq {m : ℕ} (hm : m ≠ 0) {u v : ZMod (19 ^ m) × ZMod (19 ^ m)}
    (h : Forces (unitQuadrance (ZMod (19 ^ m))) 5 u v) : u = v :=
  unitQuadrance_forces_eq_of_ringHom (ZMod.castHom (dvd_pow_self 19 hm) (ZMod 19)) finitePlane19_slack h

theorem padicInt19_forces_eq {u v : ℤ_[19] × ℤ_[19]} (h : Forces (unitQuadrance ℤ_[19]) 5 u v) : u = v :=
  unitQuadrance_forces_eq_of_ringHom PadicInt.toZMod finitePlane19_slack h

end HadwigerNelson
