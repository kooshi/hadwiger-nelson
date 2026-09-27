# FS110-NB — blind verification of the proof side (FS110-N with FS110-N2)

*Job FS110-NB (de Bruijn, Opus 5.5), 2026-09-27. Brief `data/fs110/briefs/NB110-verify-proof.md` with its instance block
`data/fs110/briefs/NB110-instance.md` and `data/fs110/briefs/STANDING-RULES.md`. Read from disk before anything else: `CLAUDE.md` § The aim,
§ Counter-priors, G82, G21 (G71, G79 as loaded). Then `LEDGER.md` rows 131–133, `data/fs110/claims.md` in full, `plans/FS107-derivation.md` in full,
`plans/FS106-TS-derivation.md` in full, `plans/FS107-V-verification.md` §2.2 and §4.3, `plans/FS107-VW-verification.md` §2b.4 and §4 item 4,
`plans/FS106-V-verification.md` l. 355–380, `plans/STUB-tangency-seam.md` (the stub, not the fenced plan). Blind: the proof side's record, directory
and tools stay closed until my stage 3 is committed; every other fence of the brief holds. Working files `data/fs110/fs110-nb/`; exact checks
`tools/fs110_nb_*.py`.*

**Fence disclosure.** At stage 1 I ran `git log --oneline -1` once to confirm the repository; it printed one commit subject newer than my start-up
snapshot ("FS-110: inventory", a neutral subject). Nothing else fenced was opened, listed or grepped; every grep below excluded the fenced paths.

## Theorems this phase proved

*(one line each, grade and address; filled stage by stage)*

## Would have searched here

- Stage 1: none (a quotation check by a tool, the rest by hand).

## Stage 1 — quotation check, definitions, restatements, registered expectations

### 1.1 Quotation check (standing rule 5)

**Instrument.** `tools/fs110_nb_quotes.py`: each row is a quotation, its source and the verdict expected; a quotation is split at "…", each piece must
occur in the source after deleting whitespace, backticks and asterisks. **Plant** (`--plant`): one present quotation with its longest word reversed, and
an invented sentence — both read MISS, the other rows unchanged (`data/fs110/fs110-nb/quotes-plant.out`, exit 0). **Recorded run: 30 rows, 0 unexpected
(exit 0)**, `data/fs110/fs110-nb/quotes.out`.

| quotation (where handed to me) | source | verdict |
|---|---|---|
| Standing rules 0, 3 (both Kooshi quotations), 4 | `CLAUDE.md` | verbatim |
| claims §0: `𝓜_K`, Tight, K-C6, tangent pair and bowtie, ring junction, sliver's source sentence, fat junction and blocking | `plans/FS107-derivation.md`, `data/fs106/claims.md`, `plans/FS106-TS-derivation.md` | verbatim |
| claims §0 **Siamese**: "two distinct tiles of one colour have all cross-distances `≥ 1`, or all `≤ 1`" | cited as `plans/FS107-stability.md` l. 348 | **wrong address**: absent from that file; verbatim at `plans/FS106-TQ-derivation.md` l. 348. Correction owed to `data/fs110/claims.md` |
| claims §0 **Cusp** (VW §4 item 4) | `plans/FS107-VW-verification.md` l. 285–286 | verbatim bar one dropped list bullet ("0**:" then "- its colour …"); harmless |
| claims §0 **Types** (the stub, § Types) | `plans/STUB-tangency-seam.md` | verbatim |
| claims §2–§3: V-C5 and its killing test, W-TAN, C-T-TAN (with its ellipses), "all six classes are in `P(u) ∪ P(v)`", TS-U, K-KILL's second half, C-T-BIKE, K-CHR4, Townsend ⅔π, VW §2b.4, FS106-IND-X, AE-Q2's [G2] | as cited | verbatim |
| claims §1b and §2's advisor quotations (A-EXACT, A-CIRC, A-SIX, C-TAN-POS, C-BOW-K, C-TAN-K, the advisor's hunch) | `plans/POROS-2026-09-27-fs110-tangency-seam.md` and FS110-A's messages | **not checkable: fenced**. I state each from its content where I use it |
| the instance block's thirteen statements | the side's record (fenced until stage 3) | checked at stage 4. **Item 13 (N-X) is truncated in the instance block**: part (d) ends mid-sentence ("alternating along"); I verify (a)–(c) and the visible part of (d) |

### 1.2 The statements against the claim list's definitions

Every statement reads **closure types** `P_cl` (the claim list's working form, Q-rule_cl); none mixes in `P_ess`. N-HORN says "closure types" in words;
the others write `P_cl` or speak of tiles whose closure holds a point. **Covering pair** is used in the list's sense (disjoint types, all six colours),
including sizes (2, 4) (N2-V4, N2-SWAP). **The object** is LIM in `𝓜_K` throughout ("tight six-map"): a full tight a.e.-proper six-colouring by a map
of at most `K` circular or straight arcs per tile, radii `≥ 1/K`, `≤ K` tiles per unit disc, no periodicity. Notation the statements use that the list
does not define, as I reconstruct it (I work with these; stage 4 compares):

- `ω(x)` the unit circle about `x`; `σ_x` (or `σ` when `x = u`) the rotation by `+60°` about `x`; `Γ` the union of the map's boundary arcs.
- **"`ω(u)` carries no arc of `Γ`"**: no boundary arc lies along `ω(u)`; then `ω(u) ∩ Γ` is finite (each circle or line of radius `≠ 1` about a
  different centre meets `ω(u)` in `≤ 2` points; local finiteness). **Condition 5** (S–V, quoted in the list): no boundary arc lies on any unit
  circle; "without unit arcs" is the same.
- **The ring of `u`** (`|P_cl(u)| = 3`, `ω(u)` free of `Γ`-arcs): the colouring of `ω(u) ∖ Γ`; its colours lie in `P_cl(u)^c` (A-CIRC). **`W(u)`**: the
  degree of the ring as a map to `K₃` with the stated orientation of its three colours (the lift to `K₃`'s universal cover gains `3W` once round).
  **Swap point** `x`: `(c(x⁻), c(σx⁻)) = (a, b)` and `(c(x⁺), c(σx⁺)) = (b, a)` — the pair at distance 1 exchanges its colours at one parameter.
- **Act One** (C-ACT1's NO): every tight six-map in `𝓜_K` has a close covering pair (or an equal-type pair in `(1, 2)`), so that the seam kills have
  something to kill. The side's statements establish covering pairs at distance exactly 1 — stronger than "close". **Act-One-free**: no close
  covering pair.
- **(S1), (S2)** (N2-S1, N-X): labels from the side's record, undefined in my brief. From the statements: (S1) is "`w₀` a non-vertex seam point on a
  unit arc of `ω(u)`"; (S2) is read as "a covering pair `(u, v)`, `|u − v| < 2`, and a common unit point `w₀`, with no unit-arc seam at `w₀`".
- N2-S1's "bowtie colour `γ`", N2-ROT's patterns "(A+, A−)", "(B+, B−)" and "ring change point": undefined in my brief; reconstructed at their items.

**Definition mismatches found:** none of substance — every type is a closure type and every pair a covering pair. Two scope notes for stage 2:
(i) N2-ACT1-W0's "under Condition 5 unconditionally" can be read as dropping the hypothesis "having a vertex of four colours or a trivalent vertex with a
swap" or only the arc exceptions; the side's claimed C-ACT1 verdict (GAP, open where every trivalent ring winds `|W| ≥ 2`) fixes the second reading,
which I adopt. (ii) N-E2 needs tiles with connected interiors (`𝓜_K`'s tiles; VW-ERODE's hypothesis).

### 1.3 Each statement in my own words

1. **N2-RING.** A trivalent vertex's ring is a three-colouring of the unit circle in which points `60°` apart differ; its degree to the triangle is
   `≥ 2` in size unless the ring has a swap. So a ring of degree 0 (or ±1) has a swap.
2. **N2-SWAP.** At a swap point `x` of `u`'s ring there is a covering pair at distance exactly 1 — `u` with `x`, or `x` with a point of its own unit
   circle — unless the boundary runs along `ω(σx)` at `x` or along `ω(x)`.
3. **N2-ACT1-W0.** A map with a four-colour vertex, or a trivalent vertex whose ring swaps, has Act One, bar the unit arcs of items 2 and 6; under
   Condition 5 with no exception.
4. **N2-TRANS.** Along an edge `uu′` (colours `a, b`) of an Act-One-free map without unit arcs, the ring degrees agree once `u`'s ring colour `d` (the
   third colour of `u′`) is identified with `u′`'s ring colour `c` (the third colour of `u`).
5. **N2-FLIP.** Transporting the ring orientation around a tile by item 4 returns it reversed iff an odd number of consecutive boundary-vertex pairs have
   the same type; then `W = 0`, a swap (item 1) and Act One (item 2), under Condition 5.
6. **N2-V4.** No vertex whose unit circle is free of boundary arcs has five colours or more; with four, some point `y` of its unit circle has type
   exactly the other two colours.
7. **N-SEAM.** At a common unit point `w₀` of a close covering pair: `w₀ ∈ Γ`; each tile at `w₀` lies on one side of `ω(x)` for the `x ∈ {u, v}` holding
   its colour; at a non-vertex `w₀` the boundary arc through it is an arc of `ω(x)` for one `x`, both side colours are `x`'s, and `x`'s other colours
   fill both of `x`'s side cones (one colour in both if `x` is trivalent).
8. **N2-S1.** At a non-vertex seam point on a unit arc of `ω(u)`, with `v` a (3,3) partner at a generic distance and `ω(v)` free of boundary arcs at
   `σ_v^{±1}w₀`: `v`'s ring may change colour at `w₀`, and both hexagon neighbours `σ_v^{±1}w₀` carry `u`'s bowtie colour on both sides along `ω(v)`.
9. **N2-HEX.** A ring of six `60°` arcs cycling (`W = ±2`) forces `u`'s three sectors to be exactly `120°`, each facing away from two consecutive
   rotation points.
10. **N2-ROT.** At a ring change point, the patterns (A±) force a colour of `u` into the outward `60°` cone at `x` and `u`'s sector of that colour into
    the half-plane away from `x`; (B±) the inward cone and the half-plane toward `x`; nothing else forces a colour at `x`.
11. **N-E2.** Two same-colour tiles at the ends of a unit segment are Siamese (each inside the closed unit disc about the other's point) or outer.
12. **N-HORN.** A cusp horn at `u` meets every nearby unit circle about points near `w₀` from the proper side — transversal horns like rays,
    tangent horns because their two curvatures differ — so C-T-TAN's cone kill runs with closure types (C-CUSP-K).
13. **N-X.** At a (S2) point with no unit arcs and disjoint types: `w₀` carries four colours or more in the pattern `v, u, v, u`; the two `u`-colours
    there are distinct and on opposite sides; a trivalent `u` with exactly two colours at `w₀` has a strong escape (a bowtie) in its third colour
    unless `ω(w₀)` leaves `u` along `Γ`; (d) truncated.

### 1.4 Registered expectations (before derivation; both outcomes reachable)

*Disclosure:* while reading the sources I thought through items 1, 2, 4, 5, 6 and 11 far enough to form a view; these rows record that view, the rest a
prior. FALSE and GAP are reachable for every item (a counterexample ring or local configuration for 1, 2, 6, 9, 10; a missing hypothesis for 3–5, 7, 8,
12, 13); TRUE is reachable for every item.

| item | TRUE | GAP / MISSTATED | FALSE |
|---|---|---|---|
| 1 N2-RING | 0.9 | 0.05 | 0.05 |
| 2 N2-SWAP | 0.35 | 0.55 (inherits item 6's second step) | 0.1 |
| 3 N2-ACT1-W0 | 0.55 (under Condition 5) | 0.4 (arc exceptions) | 0.05 |
| 4 N2-TRANS | 0.45 | 0.45 (the nerve step) | 0.1 |
| 5 N2-FLIP | 0.6 (the parity) | 0.35 (the chain) | 0.05 |
| 6 N2-V4 | 0.35 | 0.6 (the second step's arc cases) | 0.05 |
| 7 N-SEAM | 0.6 | 0.3 | 0.1 |
| 8 N2-S1 | 0.45 | 0.35 | 0.2 |
| 9 N2-HEX | 0.6 | 0.15 | 0.25 |
| 10 N2-ROT | 0.5 | 0.3 | 0.2 |
| 11 N-E2 | 0.95 | 0.05 | 0 |
| 12 N-HORN / C-CUSP-K | 0.4 | 0.5 | 0.1 |
| 13 N-X (a)–(c) | 0.5 | 0.35 | 0.15 |

## Stage 1 — SAVED
