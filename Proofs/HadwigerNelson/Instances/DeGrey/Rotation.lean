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

This module says exactly that, and the kernel checks it: 791 exact coordinate identities in
`ℚ(√3,√5,√7,√11)`. Everything else follows — the second half's *geometry* from `Motion.distSq_eq`,
and its *colouring property* from `Gadget.transport`.

## What that replaces

Before this module, de Grey's second half was a second SAT certificate: 1,043 generated modules,
180 MB of source, and **12.8 hours of processor time** (`plans/M06-chi-ge-five.md` § 4.6). It is now
86 seconds of kernel arithmetic, and there is nothing generated at all — the index map below is a
closed form, not a table.

## The index map, and why it is arithmetic

`tools/degrey.py` builds the point list as `dedup(Ya ++ Yb)`, so the first copy occupies **exactly
indices 0–790** and the second occupies `{14} ∪ [791, 1580]` — the one overlap being the rotation
centre, which is its own image. Hence

```
φ i = 14        at the centre
      791 + i   below it
      790 + i   above it        -- one index skipped, because the centre is shared
```

Nothing about that is trusted: `deGrey_rotation` re-derives every one of the 791 correspondences from
the coordinates themselves.

## This module is settled, and separate for that reason

It costs **95 CPU seconds** and will not be edited again. Lake's traces are content-based, so
anything written beside these checks would re-run them on every rewording; what follows from them
lives in `Rotated.lean`, which costs five. Same discipline as `Sat/Diagnose.lean` and
`PackedDiagnose.lean`.
-/

set_option maxRecDepth 1000000
set_option maxHeartbeats 4000000

namespace HadwigerNelson

/-! ## The rotation -/

/-- **The motion carrying de Grey's first copy onto his second**: rotation about `(−2, 0)` by
`(cos, sin) = (31/32, −3√7/32)`, with the denominator cleared and the rotation identity
`31² + (3√7)² = 32²` carried as a field.

The coordinates are written as nested pairs rather than as `31`, `32`, … so that the kernel meets
tower elements rather than casts it has to unfold: this data is multiplied by twice per vertex, 791
times over. -/
def deGreyMotion : Motion where
  a := ⟨⟨⟨⟨31,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩
  b := ⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨-3,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩
  c := ⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨3,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩
  d := ⟨⟨⟨⟨31,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩
  -- The translation that fixes the centre `(−1536, 0)` — which is vertex 14 at this denominator:
  -- `t = M·centre − A·centre`, so `e = 32·(−1536) − 31·(−1536) = −1536` and
  -- `f = 0 − (−3√7)·(−1536) = −4608√7`.
  e := ⟨⟨⟨⟨-1536,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩
  f := ⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨-4608,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩
  M := ⟨⟨⟨⟨32,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩
  scale := 1024
  scale_ne := by decide
  sq := by decide +kernel
  col₁ := by decide +kernel
  col₂ := by decide +kernel
  orth := by decide +kernel

/-! ## The index map -/

/-- **The index map of the rotation**, on raw indices: the first copy's vertex `i` is carried to the
second copy's vertex `φ i`. Arithmetic, not a table — see the module docstring for why the first copy
is exactly `[0, 791)`. -/
def deGreyPhiNat (i : ℕ) : ℕ := if i = 14 then 14 else if i < 14 then 791 + i else 790 + i

/-- The map lands in range on the first copy. -/
theorem deGreyPhiNat_lt {i : ℕ} (h : i < 791) : deGreyPhiNat i < 1581 := by
  unfold deGreyPhiNat; split_ifs <;> omega

/-- **The map is injective on the first copy** — by arithmetic, with no data to check. This is what
stops the transported half from collapsing two vertices onto one, which is the one thing that would
make `Gadget.transport` inapplicable. -/
theorem deGreyPhiNat_inj {i j : ℕ} (hi : i < 791) (hj : j < 791)
    (h : deGreyPhiNat i = deGreyPhiNat j) : i = j := by
  unfold deGreyPhiNat at h; split_ifs at h <;> omega

/-- The index map as a vertex map.

**Outside the first copy this is the identity, and that value means nothing** — no theorem here
constrains it, and `deGreyHalfA_lt` below is what confines every use to the range where the rotation
speaks. The guard sits at the `Fin` boundary rather than inside `deGreyPhiNat` because it is a
*bound*, not a fact about the construction; and the map is total rather than partial because
`List.map` cannot carry a per-element side condition. -/
def deGreyPhi (i : Fin 1581) : Fin 1581 :=
  if h : i.val < 791 then ⟨deGreyPhiNat i.val, deGreyPhiNat_lt h⟩ else i

/-! ## What the kernel checks -/

/-- **The construction, verified.** Each of the 791 points of de Grey's first copy is carried to its
partner in the second by one rotation about `(−2, 0)` — 791 exact identities in `ℚ(√3,√5,√7,√11)`,
decided by the kernel. Measured at 93.6 + 6.3 CPU seconds on the desktop. -/
theorem deGrey_rotation :
    ((List.range 791).all fun i =>
      deGreyMotion.Maps (deGreyTable.get i) (deGreyTable.get (deGreyPhiNat i))) = true := by
  decide +kernel

/-- Every edge of the first half has both endpoints inside the first copy — which is what confines
the index map to the range where `deGrey_rotation` speaks. -/
theorem deGreyHalfA_lt :
    (deGreyHalfAEdges.all fun e => decide (e.1.val < 791) && decide (e.2.val < 791)) = true := by
  decide +kernel

/-- No listed edge of the first half is a loop — needed for the transported edges to be edges. -/
theorem deGreyHalfA_ne :
    (deGreyHalfAEdges.all fun e => decide (e.1.val < e.2.val)) = true := by decide +kernel

/-! ## The lemma API — so nothing downstream walks the `List.range`

`deGrey_rotation` is a `Bool` over 791 indices. No consumer should ever destructure it; these two are
the forms every consumer wants, and the reason `deGreyPhi`'s guard never has to be unfolded twice. -/

/-- **The rotation, in the form its consumers use.** Every vertex of de Grey's first copy is carried
by `deGreyMotion` to its partner in the second. -/
theorem deGreyMotion_maps {i : ℕ} (h : i < 791) :
    deGreyMotion.Maps (deGreyTable.get i) (deGreyTable.get (deGreyPhiNat i)) = true :=
  List.all_eq_true.mp deGrey_rotation i (List.mem_range.mpr h)

/-- Inside the first copy the vertex map *is* the index map — the guard discharged, once. -/
theorem deGreyPhi_val {i : Fin 1581} (h : i.val < 791) :
    (deGreyPhi i).val = deGreyPhiNat i.val := by simp [deGreyPhi, h]

/-- **The map is injective on the first copy**, as vertices. What stops the transported half from
collapsing an edge, which is the one thing `Gadget.transport` cannot survive. -/
theorem deGreyPhi_inj {i j : Fin 1581} (hi : i.val < 791) (hj : j.val < 791)
    (h : deGreyPhi i = deGreyPhi j) : i = j := by
  refine Fin.val_inj.mp (deGreyPhiNat_inj hi hj ?_)
  rw [← deGreyPhi_val hi, ← deGreyPhi_val hj, h]

/-! ## Spec

The rotation is de Grey's construction only if it lands on the vertices it is supposed to. -/

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
