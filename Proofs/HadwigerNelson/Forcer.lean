import Proofs.HadwigerNelson.Gadget
import Proofs.HadwigerNelson.Instances.Spindle

/-!
# Forced pairs, and the spindle that closes them

Both known rungs of this problem are the same argument one colour apart.

* The **Moser spindle** (χ ≥ 4): a rhombus forces its two far corners to share a colour in every
  3-colouring; place two rhombi sharing a corner so the far corners land a unit apart; no
  3-colouring survives.
* **de Grey's graph** (χ ≥ 5): a 791-point configuration forces two of its points to share a colour
  in every 4-colouring; place two copies sharing the first point so the second points land a unit
  apart; no 4-colouring survives.

Same picture, same four rewrites. This module states it once, for any graph and any number of
colours, and re-derives the Moser spindle through it. It is also the **search's win condition**: a
candidate the search proposes is certified by exhibiting a forced pair and two placements, never by
refuting the assembled graph — which is what makes a forcer of `m` points buy a `2m−1`-point
witness for the price of refuting `m`.
-/

namespace HadwigerNelson

/-! ## The property -/

/-- Two vertices are **forced to agree** at `k` colours when no proper `k`-colouring separates them.

Stated over bare functions rather than `SimpleGraph.Coloring` for the same reason `Proper` is:
pulling one back along a placement is then function composition and costs nothing. -/
def Forces (n k : ℕ) (E : List (Fin n × Fin n)) (p q : Fin n) : Prop :=
  ∀ f : Fin n → Fin k, Proper n E f → f p = f q

/-- **A two-port gadget that rules out the ports differing is a forcer.** The bridge from the
algebra's producers — `Gadget.ofUnsat` for a certificate, `Gadget.ofExhaustion` for a small
configuration the kernel can enumerate — to the property the closing lemma consumes. -/
theorem Forces.of_gadget {n k : ℕ} {E : List (Fin n × Fin n)} {p q : Fin n}
    (g : Gadget k n 2 E ![p, q])
    (h : ∀ r : Fin 2 → Fin k, r 0 ≠ r 1 → g.admits r = false) :
    Forces n k E p q := by
  sorry

/-! ## The closing lemma -/

/-- **The spindle closes a forcer.** Two copies of a configuration in which `p` forces `q`, placed
so that the copies share `p` and their two images of `q` are adjacent: the ambient graph has no
`k`-colouring.

The placements are arbitrary functions `Fin n → Fin N`, so nothing here knows about geometry,
about `Assembly`'s index arithmetic, or about which graph is which — the hypotheses say only that
each placement carries listed edges to edges. -/
theorem not_colorable_of_spindled_forcer {n N k : ℕ}
    {E : List (Fin n × Fin n)} {F : List (Fin N × Fin N)} (φ ψ : Fin n → Fin N)
    (hφ : ∀ e ∈ E, e.1 ≠ e.2 → (edgeGraph N F).Adj (φ e.1) (φ e.2))
    (hψ : ∀ e ∈ E, e.1 ≠ e.2 → (edgeGraph N F).Adj (ψ e.1) (ψ e.2))
    {p q : Fin n} (hpiv : φ p = ψ p) (hjoin : (edgeGraph N F).Adj (φ q) (ψ q))
    (hforce : Forces n k E p q) :
    ¬ (edgeGraph N F).Colorable k := by
  sorry

/-! ## Spec — the rung the lemma re-derives, and the controls that must go red

The Moser spindle's eleven edges are exactly two copies of `rhombus` glued at vertex `0`
plus the joining edge `(3,6)`:

    rhombus            (0,1) (0,2) (1,2) (1,3) (2,3)
    rhombus, relabelled by 0,1,2,3 ↦ 0,4,5,6
                       (0,4) (0,5) (4,5) (4,6) (5,6)
    the joining edge   (3,6)

so rung A's witness costs two `Matrix.of` literals and no new certificate. -/

/-- The first rhombus, as it sits in the Moser spindle: the identity on `0,1,2,3`. -/
def spindleCopyA : Fin 4 → Fin 7 := ![0, 1, 2, 3]

/-- The second rhombus: the same four vertices carried to `0,4,5,6`, sharing the pivot `0`. -/
def spindleCopyB : Fin 4 → Fin 7 := ![0, 4, 5, 6]

/-- The two placed copies and the joining edge, as an edge list. -/
def spindleFromRhombi : List (Fin 7 × Fin 7) :=
  (rhombus.map fun e => (spindleCopyA e.1, spindleCopyA e.2)) ++
  (rhombus.map fun e => (spindleCopyB e.1, spindleCopyB e.2)) ++ [(3, 6)]

-- **The decomposition is checked, not asserted.** The Moser spindle's eleven edges are exactly
-- these eleven — a placement typo that quietly built a different graph would go red here rather
-- than prove a theorem about something else.
#guard spindleFromRhombi.length = moserSpindleEdges.length
#guard spindleFromRhombi.all (· ∈ moserSpindleEdges)
#guard moserSpindleEdges.all (· ∈ spindleFromRhombi)

-- The pivot really is shared, and the partners really are the joining edge's ends.
#guard spindleCopyA 0 == spindleCopyB 0
#guard (spindleCopyA 3, spindleCopyB 3) == ((3 : Fin 7), (6 : Fin 7))

/-- **The rhombus forces its far corners at three colours** — `rhombusGadget`, which is
kernel-decided over all `3⁴ = 81` colourings, read as a forced pair. -/
theorem rhombus_forces : Forces 4 3 rhombus 0 3 := by
  sorry

/-- **The Moser spindle has no 3-colouring, re-derived through the closing lemma.**

An independent route to `Instances/SpindleBound.lean`'s `moserSpindle_not_colorable_three`, which
decides the whole graph. This one decides a four-vertex rhombus and places it twice. -/
theorem moserSpindle_not_colorable_three_spindled :
    ¬ (edgeGraph 7 moserSpindleEdges).Colorable 3 := by
  sorry

/-! ### The controls

Every hypothesis of the closing lemma is load-bearing, and each of these is a countermodel rather
than a build failure — a claim that is *false*, exhibited, so that deleting the hypothesis it
guards could not be papered over. -/

-- **The forcer is colour-count-specific.** At *four* colours the rhombus forces nothing: its far
-- corners may differ, so `rhombus_forces` read at four colours is false.
example : ¬ Forces 4 4 rhombus 0 3 := by
  sorry

-- **The forced pair is the far corners and not any other pair.** Vertices `0` and `1` are adjacent
-- in the rhombus, so they are forced *apart*, never together.
example : ¬ Forces 4 3 rhombus 0 1 := by
  sorry

-- **The joining edge is load-bearing.** Delete `(3,6)` from the spindle and the remaining ten edges
-- are 3-colourable — here is the colouring, so the closing lemma cannot be missing `hjoin`.
example : Proper 7 (moserSpindleEdges.erase (3, 6)) ![0, 1, 2, 0, 1, 2, 0] := by
  sorry

-- **The shared pivot is load-bearing, and this is the control that is easiest to get wrong.** Place
-- the second rhombus on four *fresh* vertices instead of sharing the pivot, keep both forcers and
-- keep the joining edge — and the union is 3-colourable after all. Each copy still forces its own
-- pair; what fails is that the two forced colours are now unrelated. Here is the colouring.
example : Proper 8 [(0,1), (0,2), (1,2), (1,3), (2,3),
                    (4,5), (4,6), (5,6), (5,7), (6,7), (3,7)]
    ![0, 1, 2, 0, 1, 0, 2, 1] := by
  sorry

end HadwigerNelson
