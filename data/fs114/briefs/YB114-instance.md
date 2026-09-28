*Instance file for job **FS114-YB** (the brief is `data/fs114/briefs/YB114-verify-construction.md`). Written by the product owner, 2026-09-27 night, at
FS114-Y's hand-back. The objects and statements below are FS114-Y's, quoted from its record with its grades, verdicts and proofs withheld, apart
from the construction rule each object needs. Rebuild each object from its rule, check it exactly with your own tool, and give your own verdict:
TRUE, FALSE (a counterexample), GAP at a named step, or MISSTATED (the corrected statement).*

## Objects to rebuild (from their rules; the side's data only at your stage 2)

1. **The capped strip.** `[AxenovichEtAl2014]`'s strip as FS-112 rebuilt it (FS112-CAL-STRIP), with each top (and bottom) tile capped by the unit arc
   about its own valley, drawn between the tile's two top corners. **Statement:** it is a valid fragment, and it holds the closed disc `B̄(P_j, R)`
   about every midline four-colour vertex `P_j` for every `R` with `R² < (7 + 3√5)/4`; no valid extension of the strip holds that disc at
   `R ≥ φ²/√2` (the disc would then hold the stop point `Q`). **An ACCEPT here is the suspect verdict**: print the pairs examined against the pairs the
   fragment has, and check the capped self-pairs first.
2. **The disk** (`[Polymath2021]` Fig. 10, FS112-CAL-DISK, 26 tiles). **Statement (PENT):** `B_k`'s two close complementary partners `Z^R_k`, `Z^L_{k+1}`
   meet `ω(B_k)` at four distinct points `A_k, C_k, A_{k+1}, D_{k+1}`, so no valid map agrees with the disk near `B_k, Z^R_k, Z^L_{k+1}`, and no third
   unit-arc boundary at `B_k`, nor any choice of arcs, repairs it; and `A_k + A_{k+1} − B_k` is the central corner `A_{k+3}`.
3. **The moved disk** (FS112-MOVE). **Statement (ROUTES):** the blue and orange routes to a fourth colour at `C_0` fail with the rest of the disk
   unchanged: the only blue tile straddling `ω(C_0 + e(72°)/100)` is `T2_0`, the only orange one `T1_0`, and at named points of `T2_0 ∩ B(C_0, 1)` and
   `T1_0 ∩ B(C_0, 1)` the free set, with the cut tile ignored, is exactly the tile's own colour. Choose your own points.

## Statements about the printed geometries (any colouring)

4. **STRIPK6.** In the strip's geometry the six tiles at a valley `V_m` (the arches `U_{m−1}`, `U_m` and the top tile `T_m`) and at the apex of
   `U_{m+1}` (`U_{m+1}`, `T_{m+1}`, `T_{m+2}`) pairwise straddle distance 1, so the two vertices are complementary under every colouring; `V_m`'s three
   boundary curves lie on `ω(P_{m−1})`, `ω(P_{m+1})` and a segment, none on `ω(Q_m)`; so, by FS112-N3-COR3, no valid map contains these six tiles
   under any colouring.
5. **STRIPRIGID.** Every valid colouring of the strip's geometry is `[AxenovichEtAl2014]`'s, up to a permutation of the six colours.
6. **DISKRIGID.** Every valid colouring of the disk's geometry is the printed one up to a permutation (its central tile and five ring-1 tiles pairwise
   straddle distance 1); so PENT holds under every colouring, and no valid map contains the disk's geometry near any `B_k`.

## Statements about every valid map

7. **PAIRSHARE.** In a valid map, any two close complementary cubic trichromatic partners `u′`, `u″` of a cubic trichromatic vertex `u` share a common
   unit point with `u`: `(ω(u) ∩ ω(u′)) ∩ (ω(u) ∩ ω(u″)) ≠ ∅`.
8. **K6 (a design screen).** If two cubic vertices `u`, `u′` at distance `< 2` have six incident tiles that pairwise straddle distance 1, they are
   complementary under every colouring, and each common unit point of `ω(u)` and `ω(u′)` must be a leaving centre of both.
9. **C114-DUAL-COUNT**, as the claim list states it (a quad "emits" four curved edges, `2n` edges, 80 %), on doubly periodic non-Siamese maps with five
   edge-neighbours per tile. Say exactly what "emits" must mean for the statement to be TRUE, and whether each emitted edge is a unit arc.
10. **C114-RAINBOW**, as the claim list states it; if MISSTATED, your corrected form.
11. **C114-EDGE-RAINBOW** and **C114-REDBLOCK**'s first clause (in a non-Siamese valid map where every tile has five edge-neighbours, the red tiles'
    closed edge-neighbourhoods partition the tiles), as the claim list states them.

**Controls first** (the brief): every tool you write accepts the brick, the hexagonal seven-colouring, the strip, the disk and FS112-BOWTIE before any
refusal is believed, with a planted fault beside a faithful twin.
