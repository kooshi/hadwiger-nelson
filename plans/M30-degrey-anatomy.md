# M30 — The de Grey anatomy: the field jump's opening measurement (PRE-SUBPLAN STUB)

*Written 2026-08-09, at the field-jump decision (Kooshi: "I'm losing interest in this
field when the temptation to jump to de Grey's is there… We can do anything").
This stub carries everything the decision session knew, so a fresh session can
subplan it with zero conversation memory. Read it whole before subplanning.*

## Why this milestone exists (the field-wall thesis)

The construction ladder (M24 pair → M25 four-ladder → M26 hexagram) proved three
infinite, genuinely-coupled unit-distance objects **exactly 4-chromatic**, on axioms
exactly `[propext, Classical.choice, Quot.sound]`, with the census machinery finding
~10⁶ edges of SAT evidence that the wider seam-field closure stays 4. The colouring
never shifted; every rung's tables had slack. The reason, found at the jump decision
and not yet written into Lean:

> **The Moser spindle's twist rotation lies inside the seam group.** With
> σ = (√3 + i√33)/6 the seam, direct computation gives σ² = (−5 + i√11)/6, so the
> spindle rotation ρ (cos θ = 5/6, sin θ = √11/6, the twist that makes two rhombi a
> 4-forcer) is **ρ = −σ̄² = ζ₆³ · σ⁻²**.

So the classical 4-forcers are *native* to ⟨ζ₆, σ⟩ — which is why 4 is always
needed — and three milestones of exact classification say 4 always suffices there.
Meanwhile the only known 5-forcers (de Grey 1581; Heule 553/510, both **kernel-
certified in this repository** as `Instances/DeGrey`, `Instances/Heule510/553`) have
coordinates in ℚ(√3, √5, √7, √11): **√5 and √7 are not in the seam field. The
5-wall is a field wall.** The hunt moves fields; the method (script-verified design →
master-identity engine → kernel-checked exactness, M24–M26) is the asset being
carried over.

One theorem transfers for free and should be cited, not re-proved: the two-circle
theorem (M19) and the one-pivot cap (M20) are stated for **all** circle points —
uncountably — so ANY field's densification of a one-pivot system is a subgraph and
inherits χ = 4 exactly. **There is no one-pivot 5-forcer in any field.** The new
ladder starts at pairs. (Registered side-question, cheap: can a single centre with
MANY concentric circles force 5? Nobody has probed k-circle concentric systems.
Expectation: no — concentricity is the geometry the coverage theorems showed weak.)

## Registered expectations (write §0 predictions BEFORE instruments, per WORKFLOW)

These are the session's best guesses, recorded so the instruments can confirm or
refute them *by name*:

* **E1 — the group.** M13 (see `ARCHITECTURE.md` § 4, M13 row) proved de Grey's
  construction is four primitive moves, with both rotations **spindles about a
  vertex at radicands 15 and 63 = 9·7**. A spindle over distance d twists by
  cos θ = 1 − 1/(2d²): d = 2 gives ρ₁₅ = (7 + i√15)/8, d = 4 gives
  ρ₆₃ = (31 + i√63)/32. Prediction: the edge-difference units of the 1581-vertex
  graph factor as words in **⟨ζ₆, σ, ρ₁₅, ρ₆₃⟩** (with lattice translations), and
  √5 enters only through √15 = √3·√5, √7 only through √63 = 3√7.
* **E2 — the seam algebra one field up.** The seam's algebraic integer is
  π = (1 + i√11)/2 with π² = π − 3 (norm 3 — hence M24's 3-adic kills). The
  analogues: (1 + i√15)/2 satisfies x² = x − 4 (**norm 4 = 2²**) and
  (1 + i√63)/2 satisfies x² = x − 16 (**norm 16 = 2⁴**). Prediction: the new webs
  clear **2-adically**, not 3-adically — the single biggest research risk for the
  Lean rungs (M32), and the thing the census must characterize first.
* **E3 — concentration.** The coupling-strength gating (M23: ambient kills gated by
  cross-chord count) predicts the 5-forcing concentrates in few chord families.
  Prediction: ≥ 70% of the 1581-graph's edges fall in ≤ 6 (centre-pair-class,
  family) classes once classified in group currency.
* **E4 — rigidity.** The hexagram's 4-colouring space, quotiented by its symmetries
  (rot6 × palette), is SMALL (order tens, not thousands), and every 4-colouring
  forces colour-equality on the fused triples. (This calibrates the rigidity
  instrument on known ground before it is pointed at the new field.)

## The work items

1. **The rigidity instrument** (~half a day, seam-field testbed only). Enumerate a
   finite closure chunk's full proper-k-colouring space (SAT with blocking clauses
   or DPLL-count), quotient by a supplied symmetry group, extract the pairwise
   colour-agreements every colouring shares ("forced equalities" — the transmissible
   currency of gadgets). Validate on the hexagram (E4) with planted controls: a
   deleted edge must loosen the space; a planted forced pair must be found. This is
   new-field equipment; the hexagram run is its calibration, not seam-field science.
2. **Group extraction.** From the repo's exact coordinates (the certified vertex
   tables of 1581/553/510 — `tools/degrey.py` knows the field arithmetic), factor
   every edge difference as (unit) × (word candidate); identify the minimal rotation
   group; confirm/refute E1. Deliverable: the generator list with exact values, and
   the word-length distribution of the edges.
3. **The anatomy.** Classify every edge of the 1581 (and 510/553) by
   (centre-pair-class, family, address) in group currency — the way
   `tools/hexagram-viz.html` classifies the hexagram's. Confirm/refute E3.
   Deliverable: the anatomy table + a written reading of which families carry the
   5-forcing (cross-checked between the three witnesses).
4. **The anatomy visualizer** (deliverable, committed like `tools/hexagram-viz.html`):
   the 5-chromatic graph rendered with edges coloured by class, per-class toggles,
   the forced-equality overlay from item 1's instrument run on it, pan/zoom,
   address tooltips. *The first picture of the 5-forcing organs anyone has seen.*
5. **Closure candidates.** From the anatomy, rank the smallest closed objects
   (fewest centres/generators) containing the concentrated families — M31's input.
6. **Optional, small, certified:** the lemma ρ = ζ₆³σ⁻² in Lean (one
   `linear_combination`; makes the field-wall thesis kernel-checked) and the
   concentric-k-circle probe (census + SAT, one evening).

## What "landed" means

The generator list confirmed against all three witnesses; the anatomy table with
E3's verdict stated at face value; the rigidity instrument validated both ways on
the hexagram; the visualizer committed; M31's candidate list ranked with measured
sizes. **No Lean obligations beyond the optional lemma — this is an instruments
milestone**, and the standing rule applies: nothing in `tools/` is trusted; every
claim that matters later gets re-derived in Lean at M32.

## Failure clauses (registered)

* If the edge units do NOT factor in ⟨ζ₆, σ, ρ₁₅, ρ₆₃⟩ (E1 false), the group is
  bigger than M13's reading implied — report the actual factorization; the
  milestone's value survives (the anatomy just uses the true group).
* If the forcing does NOT concentrate (E3 false — edges spread thinly over many
  classes), the minimal-closure strategy weakens; report at face value and re-rank:
  M31 would then target the smallest closure containing a whole witness rather
  than a family bundle.
