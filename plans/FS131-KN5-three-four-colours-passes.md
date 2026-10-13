# FS131-KN5 — three and four colours: the modeling passes, the first build, the dyadic leaves' plan

*The kernel lane's planner (de Bruijn), successor of FS131-KN4, 2026-10-13, branch `fs131-wr2`. Brief:
`data/fs131/briefs/FS131-KN5-passes-and-build.md`. The skeleton and its plan per leaf: `plans/FS131-KN4-three-four-colours-plan.md`
(this record amends it; where the two differ, this one is later). Working files: `data/fs131/kn5/`.*

## Theorems this phase proved

None in the kernel: a planning job; every leaf is `sorry`. What this job **found** is listed in each stage under "Findings", at
[hand, one mind, the planner] unless a computation is named.

## Stage 1 — SAVED: the readback

**Quotations.** `data/fs131/kn5/check_quotes.py`: the brief's five quoted blocks (Kooshi's W2 and the claim list's theorem and three
dated lines) against their sources in the coordinator's checkout, byte for byte — **5 MATCH** (exit 0;
`data/fs131/kn5/logs/check_quotes.out`). Control `--plant` alters one token of each quotation in memory: 5 of 5 then mismatch
(`check_quotes.plant.out`). **One thing for the coordinator**: this tree's own copy of `data/fs131/claims-NF4.md` ends at NF4-NC — the
three dated lines are on `main` only (the branch was cut before them). Nothing here reads the stale copy; the join brings main's.

**Definitions of the four modules** (two; everything else is the library's `band`, `bandSet`, `fieldBandSet`, `torsionBy`, `unitSet`,
`unitRing`, `planeOver`, `Winding`, `ProperAlong`, `TargetFloor`, `normOneCayley`, read where they stand):

| definition | what it is | read by |
|---|---|---|
| `TorsionExtraction.inv5 F : unitRing F` | `1/5` as an element of `ℤ[U_F]` (`coe_inv5` its simp form) | L2.3, L2.4 |
| `ThreeColourCriterion.conjR F : unitRing F →+* unitRing F` | complex conjugation on `ℤ[U_F]` (`coe_conjR`) | L3.5–L3.10, the joining text |

**Headlines, each with the claim it answers** (leaves are the plan's § Stage 2 list; I re-derived each leaf's statement by hand before
the passes — every one is true as typed; the notes are what the re-derivation saw):

| statement | claim | note from the re-derivation |
|---|---|---|
| `ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable` (L1.7, over L1.1–L1.6) | NF4-S6 | the box point is Hahn–Banach for the support function of the box; true |
| `TorsionExtraction.exists_torsion_mem_fieldBandSet` (L2.4, over L2.1–L2.3) | NF4-S7 | `(2 − i)w = 2 + i`, `1/5 = w + w̄ − 1`; a rotation from a corner has a coordinate `7/30 > 1/6`; the corner layer alternates along `5⁻ᵏ`, hence `25⁻ⁿ` |
| `colorable_two_of_inv_three_mem`, `four_le_…_of_inv_three_mem`, `…_ne_three_…` | NF4-THEOREM (c), with G-2 | compositions, proved over L2.4–L2.6 and L1.7 |
| `four_le_…_of_sqrt_mem`, `four_le_…_fieldOfRadicands`, `three_le_…_of_sqrt_mem` | NF4-THEOREM (a), lower bound, with G-1 | `|v|² = ((2n−1)² + d)/4n² = 1` exactly when `d + 1 = 4n` |
| `ThreeColourCriterion.exists_maximal_card_nine_of_colorable_three` (over L3.1–L3.9) | NF4-THEOREM (b) ⟹, as far as the ring | proved over leaves |
| `exists_maximal_conj_trivial_of_colorable_two` (L3.10) | row 99's form only (the outside model's two-colour theorem, ⟹) | **true for every subfield, with a short proof** — § Stage 2, D-2 |
| `comap_conjR_eq` (L3.6) | FS91-J02-L2(b) | **true of every ideal** — § Stage 2, D-1 |
| `DyadicQuadratic.colorable_of_ringHom` (DQ.1) | route to NF4-DYADIC-TWO, -FOUR | **already in the kernel** as `ResidueColouring.colorable_unitDistance_induce_of_residue` — § Stage 2, D-3 |
| `colorable_two_planeOver_sqrt` (DQ.2), `colorable_four_planeOver_sqrt` (DQ.3) | NF4-DYADIC-TWO, NF4-DYADIC-FOUR (kernel form) | § Stage 5 |
| joining text: `chromaticNumber_planeOver_eq_three_iff`, `colorable_three_iff`, the four rows, `localBound_le_chromaticNumber_of_le_four`, the two primes | NF4-THEOREM (b), (a)'s table, row 99, the dated lines' wording | elaborated against both lines by the first planner; re-elaborated after the passes (§ Stage 4) |
