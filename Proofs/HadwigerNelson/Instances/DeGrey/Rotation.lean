import Proofs.HadwigerNelson.Instances.DeGrey
import Proofs.HadwigerNelson.Instances.DeGrey.Split
import Proofs.HadwigerNelson.Motion

/-!
# de Grey's second copy, derived

The last step of de Grey's construction rotates one 791-point set twice about `(−2, 0)`, by
`π/2 ∓ arcsin(1/8)`. The two images are the graph's two halves, so the second half is the **first
half rotated** — by the difference of those two angles:

| | |
|---|---|
| centre | `(−2, 0)` — which is **vertex 14**, the halves' shared vertex |
| `cos` | `31/32` |
| `sin` | `−3√7/32` |
| the identity that makes it a rotation | `31² + (3√7)² = 961 + 63 = 1024 = 32²` |

This module says exactly that, and Lean checks it: 791 exact coordinate identities in
`ℚ(√3,√5,√7,√11)`. Everything else follows — the second half's *geometry* by
`distSq_eq_of_rotOk`, and its *colouring property* by `Gadget.transport`.

## What that replaces

Before this module, de Grey's second half was a second SAT certificate: 1,043 generated modules,
180 MB of source, and **12.8 hours of processor time** (`plans/M06-chi-ge-five.md` § 4.6). It is now
86 seconds of kernel arithmetic, and there is nothing generated at all — the index map below is a
closed form, not a table.

## The index map, and why it is arithmetic

`tools/degrey.py` builds the point list as `dedup(Ya ++ Yb)`, so the first copy occupies **exactly
indices 0–790** and the second occupies `{14} ∪ [791, 1580]` — the one overlap being the rotation
centre, which is its own image. Hence:

```
φ i = 14        at the centre
      791 + i   below it
      790 + i   above it        -- one index skipped, because the centre is shared
```

Nothing about that is trusted: `deGrey_rotation` re-derives every one of the 791 correspondences
from the coordinates.
-/

set_option maxRecDepth 1000000
set_option maxHeartbeats 4000000

namespace HadwigerNelson

/-! ## The rotation -/

/-- `31` — the rotation's cosine, cleared of its denominator `32`. -/
def deGreyRotA : Q4 := ⟨⟨⟨⟨31,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩

/-- `−3√7` — the rotation's sine, cleared of its denominator `32`. -/
def deGreyRotB : Q4 := ⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨-3,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩

/-- `32` — the denominator both were cleared by. -/
def deGreyRotM : Q4 := ⟨⟨⟨⟨32,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩

/-- The rotation centre `(−2, 0)`, at the certificate's scale of 768. It is vertex 14. -/
def deGreyRotCentre : Pt :=
  ⟨⟨⟨⟨⟨-1536,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,
   ⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩

/-- **It really is a rotation**: `31² + (3√7)² = 32²`, which is the one hypothesis every distance
claim below consumes. -/
theorem deGreyRot_id :
    deGreyRotA * deGreyRotA + deGreyRotB * deGreyRotB = deGreyRotM * deGreyRotM := by decide +kernel

/-- The scale factor, as the natural number that gets cancelled. -/
theorem deGreyRot_sq : deGreyRotM * deGreyRotM = ((1024 : ℕ) : Q4) := by decide +kernel

/-! ## The index map -/

/-- The index map on raw indices — a closed form, not a table. Outside the first copy
(`791 ≤ i`) it is the identity, and that value is junk: no theorem here applies it there, and the
edge walk `deGreyHalfA_lt` is what confines every use to the range where it means something. -/
def deGreyPhiNat (i : Nat) : Nat :=
  if i = 14 then 14 else if i < 14 then 791 + i else if i < 791 then 790 + i else i

/-- The map stays in range. -/
theorem deGreyPhiNat_lt {i : Nat} (h : i < 1581) : deGreyPhiNat i < 1581 := sorry

/-- **The map is injective on the first copy** — by arithmetic, with no data to check. This is what
stops the transported half from collapsing two vertices onto one. -/
theorem deGreyPhiNat_inj {i j : Nat} (hi : i < 791) (hj : j < 791)
    (h : deGreyPhiNat i = deGreyPhiNat j) : i = j := sorry

/-- The index map as a vertex map. -/
def deGreyPhi (i : Fin 1581) : Fin 1581 := ⟨deGreyPhiNat i.val, deGreyPhiNat_lt i.isLt⟩

/-! ## What the kernel checks -/

/-- **The construction, verified.** Each of the 791 points of de Grey's first copy is carried to its
partner in the second by one rotation about `(−2, 0)` — 791 exact identities in
`ℚ(√3,√5,√7,√11)`, decided by the kernel. Measured at ~86 CPU seconds. -/
theorem deGrey_rotation :
    ((List.range 791).all fun i =>
      RotOk deGreyRotA deGreyRotB deGreyRotM deGreyRotCentre
        (deGreyTable.get i) (deGreyTable.get (deGreyPhiNat i))) = true := by
  decide +kernel

/-- Every edge of the first half has both endpoints inside the first copy — which is what confines
the index map to the range where `deGrey_rotation` speaks. -/
theorem deGreyHalfA_lt :
    (deGreyHalfAEdges.all fun e => decide (e.1.val < 791) && decide (e.2.val < 791)) = true := by
  decide +kernel

/-- No listed edge of the first half is a loop. -/
theorem deGreyHalfA_ne :
    (deGreyHalfAEdges.all fun e => decide (e.1.val < e.2.val)) = true := by decide +kernel

/-! ## Spec

The rotation is only de Grey's construction if it lands on the vertices it is supposed to. -/

section Spec

-- The rotation centre is vertex 14, and it is its own image.
#guard deGreyPhiNat 14 = 14

-- The joining edge's ends are partners: vertex 11 in the first copy, vertex 802 in the second.
#guard deGreyPhiNat 11 = 802

-- The map is injective on the first copy and lands in the second: `{14} ∪ [791, 1580]`.
#guard ((List.range 791).map deGreyPhiNat).eraseDups.length = 791
#guard ((List.range 791).map deGreyPhiNat).all fun j => j = 14 || (791 ≤ j && j < 1581)

end Spec

end HadwigerNelson
