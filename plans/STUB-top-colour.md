# FS-128 — the six-colour rungs of the map step: can the top colour of a Grundy six-colouring be bound, and does NO-PAR hold under Condition 5? (stub)

*Minted 2026-10-03 by FS-121's close (FS121-Z1, stage 5). It holds FS-121's two rungs that are at six by nature: honest saturation's upper colour
(TOP₆, the honest route) and the cover route's own NO (C121-NOPAR-C5), parked behind FS-116 (inventory items 51, 63). **Solver column: in-ban.**
Read first: `plans/FS121-derivation.md` rounds 2–3; `plans/FS121-D3-proof.md` §§ 3.1–3.5; `plans/FS121-C1-proof.md` §§ 1.2, 2.5–2.6.*

## The question, in plain language

Honesty is free: every a.e.-proper `k`-colouring becomes, without raising any point's colour index, a measurable Grundy colouring, in which every
boundary point is bound (has a point at distance exactly 1) for every colour present there except the largest (FS121-D3-GRUNDY, held). **TOP₆:** can
some Grundy six-colouring, obtained from a tight one, have its largest colour bound too? That is honest saturation at six (C121-SAT6). On the cover
route, the map such a colouring would be is in the class `𝒫_6` (FS121-C1-GMAP, held), and **C121-NOPAR** says `𝒫_6` is empty; its part under Condition 5
(every boundary meets every unit circle in finitely many points) is **C121-NOPAR-C5**, where row 134's chain stops at the vertex data and at N4-FIN's
strictness, which smooth horns lack (FS121-C1-FLAT, held).

## What FS-121 established

- C121-SAT6 is implied by seven and its failure is `χ(ℝ²) ≤ 6` with no MR; given a NO for every honest saturated colouring with at most six colours it
  *is* the answer (FS121-D3-EQ, one mind). TOP₆ implies it; three attempts stalled (variational, idomatic, re-maximising), and the idomatic reading is
  strictly stronger (FS121-D3-SWAP1D).
- The cover route in Grundy form: G-FIN₆ ∧ C121-NOPAR ⟹ seven (FS121-C1-GMAP, held); C121-NOPAR contains the honest route's saturated segment-and-arc NO
  (FS121-C1-SAT, held), so it contains FS-116's NO-SAT (`data/fs116/claims.md` § 4; C1's commentary, one mind).

## Bearing on the answer

**At six, and next to the answer.** TOP₆ is not a rung below the answer once a NO for honest saturated colourings is held (FS121-D3-EQ); its value is
a procedure that spends six. NOPAR-C5 is a new NO for a class of maps, smaller than the answer, decided at six by nature; it un-parks the cover route
when FS-116's NO-SAT lands or a jet argument at N4 appears. Kooshi may overturn the parking.

## Owed second minds

FS121-D3-EQ, -SWAP1D; FS121-NOPAR and -NOPAR-C5's GAP locations; C1's containment commentary.

## Registered expectations (provisional)

- NOPAR-C5 decided at one mind: 0.15. TOP₆ reduced to a statement strictly smaller than C121-SAT6: 0.2.

## Failure clauses

- A sentence reading TOP₆ or G-FIN₆ as progress toward seven without its NO is a statement defect (the answer restated).
- A proof of NOPAR-C5 that reads only germs at the chain's points fails on FS121-C1-FLAT.

## Provisional bearings

G89 (drafted: honesty is free, binding the top colour is the content), G13 (binding is coverage; FS-121's §G miss), G82, G24/G60. Stubs: FS-116,
FS-126, FS-127; FS-104 (`χ_CP(ℝ²)` at six).
