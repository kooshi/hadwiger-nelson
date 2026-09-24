# FS-79 phase P3b — the exact Θ₄ tool aimed at phase 0's survivors

*The P3b implementer (de Bruijn standard, Opus 5.5), 2026-09-24, desktop (16 physical cores / 32 threads,
128 GB). Close-inventory item 98 (G72's *Do*: point a new exact decision procedure at the open instances the day it lands).
Tools: `tools/fs79_p3b_theta4.py` (new; imports last night's `tools/fs79_p3_theta4.py` and phase 0's code read-only). Data:
`data/fs79/p3b/`. Every witness is checked by the untouched phase-0 checker `tools/fs79_p0_check.py`.*

## Registration (written and committed before the first run)

**The question.** For each of phase 0's seven minimal survivors Λ_M (M = 2448, 2328, 2400, 4200, 10920, 14280, 24360; 84 to 852
unit vectors), then the five non-minimal ones containing Λ₄₂₀₀ (12600, 16800, 21000, 25200, 29400): does Θ₄ = {θ ∈ Hom(Λ, ℝ) :
θ(u) mod 1 ∈ [1/4, 3/4] for every u ∈ U} have a point, and with what margin min_u (‖θ(u)‖_{ℝ/ℤ} − 1/4)?
- margin > 0: a full-dimensional cell, so the lattice is **four-colourable and loose** (F = P = 0, P3's five-step argument);
- margin = 0: a four-colouring from a lower-dimensional cell;
- Θ₄ empty, certified only by an exhausted exact tree with Farkas leaves — **no circular colouring, not a refusal of four colours**;
- otherwise undecided at the cap. Then full quotients Λ/NΛ at N = 13–24 on whatever stays uncoloured.

**What is and is not claimed.** Four-colourability and looseness from certified witnesses only. Nothing here can show that a lattice
needs five colours, and a lattice with no Θ₄ point may still be four-colourable (a non-circular colouring).

**Predictions** (registered before any finder, tree or quotient run on a survivor):

| id | prediction | probability |
|---|---|---|
| B-1 | of the seven minimal survivors, the number coloured at four colours in this phase (Θ₄ point or quotient at N = 13–24): **0** | 0.40 |
| | **1 or 2** | 0.40 |
| | **3 or more** | 0.20 |
| B-2 | of the seven, the number found **loose** (a margin > 0 Θ₄ witness): **0** | 0.65 |
| | **1 or 2** | 0.28 |
| | **3 or more** | 0.07 |
| B-3 | at least one of the seven gets a **certified** empty Θ₄ (an exhausted exact tree within the 20-minute cap) | 0.35 |
| B-4 | a quotient at N = 13–24 colours at least one survivor | 0.25 |
| B-5 | if any survivor has a Θ₄ point, the smallest (Λ₂₄₄₈, 84 unit vectors) is among them | 0.60 |

*Why.* Phase 0's float finder stopped at its first point and found one on L21cc6506 (60 unit vectors) and on ten other lattices, so
it does detect nonempty Θ₄ at this size; its failure on the survivors is weak evidence of emptiness, weaker for the small ones (84–100
vectors) than for the large ones. A Θ₄ point of Λ_Y restricts to one of every Λ_X ⊆ Λ_Y, and the survivors have 1.4 to 14 times
L21cc6506's constraints on the same four-dimensional torus; each ± pair removes half the torus, so for the 180–852-vector lattices I
expect emptiness. Quotients at N ≤ 12 already refused the survivors at most N, and a quotient colouring at N restricts to every
sublattice, so larger N help only where the smaller ones were inadmissible or undecided.

**Controls, each with both outcomes reachable.**
1. L21cc6506 (Λ₄₂₀) through the same finder must come back **loose** (margin > 0), matching P3's witness or another. A margin ≤ 0 or no
   point means the finder is weaker than a 3-minute smoke tree and its nulls mean nothing.
2. A planted wrong θ (the found θ with one coordinate moved by 1/8) must be **refused** by the phase-0 checker. A pass means the checker
   cannot see a wrong witness of this kind.
3. At three colours: the finder cannot show emptiness, so it must simply find **no** Θ₃ point on L21cc6506 (row 79: Θ₃ = ∅, two
   certificates); a point found means a defect. The exact tree at k = 3 on the smallest survivor is run only if cheap. Λ₂₄₄₈ does not
   contain Λ₄₂₀ (420 ∤ 2448), so its Θ₃ is not known in advance: that run is a measurement, not a control (by the three-colour
   criterion, Θ₃ empty would mean Λ₂₄₄₈ is not three-colourable), and it is reported as such.

## What happened

*(written as the phase runs)*

## Theorems this phase proved

*(filled at the end)*
