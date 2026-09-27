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

- **NB-4** — in a tight six-map in `𝓜_K` (connected tiles), a vertex `v` with `|P_cl(v)| = 4` needs a `Γ`-arc of `ω(y)` or `ω(σ_v^{±1}y)` through some change
  point `y` of every `σ_v`-orbit of its ring; so **under Condition 5 no vertex has four colours** (and none five, N2-V4's first step) — [hand, one mind], §2.3.
- **NB-5** — under Condition 5 a tight six-map in `𝓜_K` has **no close covering pair**: its common unit point would be a vertex of exactly four colours —
  [hand, one mind, over N-SEAM, N-X (a)–(b) and NB-4, each re-derived here], §2.4.
- N2-RING strengthened: `|W| ≤ 1` forces a swap — [hand, one mind], §2.2.
- N2-FLIP's parity: the transport around a tile is odd on `R_1` iff `s` is odd — [hand + exact check on five tiles, `tools/fs110_nb_ring.py`], §2.8.
- N2-S1's exceptional distances are exactly `|u − v| ∈ {1, √3}` — [hand, one mind], §2.9.
- N2-HEX needs TS-C (cluster diameter) to exclude rotation points that are bichromatic degree-4 vertices, which pass every pairwise test — [hand, one mind], §2.9.
- Re-derived, one mind each: N2-RING, N2-SWAP (given N2-V4), N2-TRANS (bar `d = 2`), N-SEAM, N2-S1, N2-HEX, N2-ROT (swap-free), N-E2, N-HORN, N-X (a)–(c), A-CIRC
  (cusps included), N2-V4's first step.

## Would have searched here

- Stage 1: none (a quotation check by a tool, the rest by hand).
- Stage 2: a search for a local configuration realising a four-colour vertex whose ring change points are all four-coloured (a counterexample to N2-V4's second step) — instead the constraints were derived, and they closed into the `240°` count (NB-4). A search over rotation-point types for N2-HEX — instead TS-C and a counting.

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

## Stage 2 — derivations from the statements alone, and the killing tests

*Standing facts used (each re-derived here, [hand, one mind]):* **A-EXACT** (interior points of same-colour tiles are never exactly 1 apart; open
tiles, null unit pairs). **A-CIRC**: if `u ∈ cl T`, `T` open connected of colour `j`, then no tile-interior point `z ∈ ω(u)` has colour `j` — move `z`
radially by `±δ` inside its tile; the distance to points of `T` near `u` takes values near `1 ± δ`, so by connectedness the value 1: holds for a cusp
tile (no angle is used). **TS-C** (cluster diameter `≤ 1`, `plans/FS106-TS-derivation.md` §2.4). Coordinates: the centre at 0, the point `x = (1, 0)`,
`σx = (½, √3/2)`; at `x` the tangents of `ω(0)` are `90°`/`270°`, of `ω(σx)` are `30°` (outside `B(0,1)`) and `210°` (inside), of `ω(σ⁻¹x)` are
`330°` (outside) and `150°` (inside).

### 2.1 Item 11, N-E2 — TRUE [hand, one mind]
The distance map on `T × T′` (open, connected) avoids 1 (A-EXACT), so all values `< 1` or all `> 1`; letting `q → u′ ∈ cl T′` gives `T ⊆ B̄(u′, 1)`, or
`T ∩ B(u′, 1) = ∅`, and symmetrically. Needs connected tile interiors (`𝓜_K`). Used below as: a tile at `y` meeting `B(x, 1)` is Siamese with every
same-colour tile at `x`, so those lie in the closed half-plane at `x` facing `y`; a tile at `y` meeting the outside of `B̄(x, 1)` is outer, so those face away.

### 2.2 Item 1, N2-RING — TRUE [hand, one mind]
Lift the ring to `L : ℝ → ℤ` (steps `±1`), `L(θ + 2π) = L(θ) + 3W`; `h(θ) = L(θ + π/3) − L(θ) ≢ 0 (mod 3)` off finitely many `θ` (A-EXACT). A change
of one endpoint moves `h` by `±1` and keeps it in its class `{3m+1, 3m+2}`; a simultaneous change moves it by `0` or `±2`, and `±2` (the only class
change) is exactly the exchange `(a, b) → (b, a)`, a swap. With no swap `h ∈ {3m+1, 3m+2}` throughout, and `3W = Σ_{k=0}^{5} h(θ + kπ/3) ∈
[6(3m+1), 6(3m+2)]`, so `W ∈ [6m+2, 6m+4]`: `|W| ≥ 2`. So `|W| ≤ 1` (not only `W = 0`) forces a swap. The six-colour step: the ring has exactly three
colours (`P_cl(u)^c`); with seven colours (K1) it has four and the degree to `K₃` is undefined — six is spent there. Checked on named rings by
`tools/fs110_nb_ring.py` (§2.10).

### 2.3 Item 6, N2-V4 — first step TRUE; second step GAP, and under Condition 5 vacuous [hand, one mind]
*First step:* `|P_cl(v)| ≥ 5` leaves one colour for `ω(v) ∖ Γ` (finite `Γ`-trace), and points `60°` apart share it — against A-EXACT. TRUE.
*Second step.* With `|P_cl(v)| = 4` the ring is two-coloured `{e, f}` with `c(θ + 60°) ≠ c(θ)`, so every change point `y` is a swap with `σ_v y` and
`σ_v^{-1}y`. At `y` the four directions of `ω(σ_v^{±1}y)` must avoid `P_cl(σ_v^{±1}y) ⊇ {e, f}` (A-CIRC), unless `Γ` runs along them. Hence:
- `P_cl(y) = {e, f}` (the covering pair the statement asks for) **only if `Γ` carries arcs of `ω(σ_v y)` and `ω(σ_v^{-1}y)` at `y`**;
- otherwise `y` has an inner colour `i` (inside `B(v,1)`, Siamese) and an outer colour `o` (outer), both in `P_cl(v)`, and `i ≠ o` (a tile of `v` of that
  colour cannot be both inside `B̄(y,1)` and outside `B(y,1)`).
**NB-4 (theorem, [hand, one mind]): if in one `σ_v`-orbit `y₀, …, y₅` of change points no `Γ`-arc of `ω(y_k)` or `ω(y_{k±1})` passes through `y_k`, then
`|P_cl(v)| = 4` is impossible.** *Proof.* Then `|P_cl(y_k)| ≤ 4` (first step at `y_k`), so `P_cl(y_k) = {e, f, i_k, o_k}`, and `i_k, o_k ∉ P_cl(y_{k+1})`
(they sit on `ω(y_{k+1})`): consecutive pairs `{i_k, o_k}` are disjoint 2-subsets of the 4-set `P_cl(v)`, so they alternate `{A, B}`, `{C, D}`. For each
even `k`, `A`'s sectors at `v` lie in the closed half-plane facing `y_k` (if `A = i_k`) or facing away (if `A = o_k`); three half-planes whose lines
are `60°` apart meet in a closed `60°` arc or nothing. So each of the four colours owns at most `60°` at `v`: `240° < 360°`. ∎ So the second step's
content lies entirely in the configurations with unit arcs at the change points, which the statement does not name (its proviso names only arcs on
`ω(v)`). **Verdict: GAP at "some change point is exactly bichromatic" when `Γ` carries arcs of `ω(y)` or `ω(σ_v^{±1}y)` at a change point `y`;
vacuously TRUE otherwise (NB-4).** Under Condition 5 there is no four-colour vertex at all — S–V's Lemma 2 (chromaticity `≤ 3`) re-proved
region-only for `𝓜_K`; K-CHR4's `|P(x)| = 4` closed for such maps under Condition 5.

### 2.4 Item 13, N-X — (a)–(c) TRUE, (d) TRUE as far as quoted [hand, one mind]; and a corollary the side may not state
(a) The half-arcs of `ω(u)` at `w₀` lie in tiles of colours `∉ P_cl(u)`, hence of `v` (A-CIRC; the types cover `[6]`; no unit arc there); likewise for
`ω(v)`; the four tangents alternate. (b) The `u`-colour tile on `ω(v)`'s inner half-arc meets `B(u,1)` (Siamese), the outer one lies outside
(outer); one colour cannot be both (N-E2). (c) `ω(w₀)`'s half-arcs at `u` must avoid `P_cl(w₀) ⊇ {a, b}`, so lie in `a′` (or along `Γ`); if `a′` were one
sector holding both `±τ` in its interior, `a` and `b` would share an interval of `< 180°` missing `±τ`, i.e. one open half-plane — against `a` facing
`w₀` and `b` facing away. So two `a′` sectors straddle the tangent line. (d) as quoted is A-CIRC with the two-colour ring.
**NB-5 (corollary, [hand, one mind]): under Condition 5 no tight six-map in `𝓜_K` has a close covering pair.** At a common unit point `w₀`
(two exist for `0 < |u − v| < 2`), `w₀ ∈ Γ` and is a vertex (N-SEAM: a non-vertex seam needs a unit arc), `|P_cl(w₀)| ≥ 4` (N-X (a), (b)), `≤ 4`
(item 6's first step), and `≠ 4` (NB-4). So under Condition 5 **every** escape of C-SEAMLIST dies at `w₀` — the tangent interface and the bowtie at `u`
or `v` included — and the tangency seam is exactly the unit-arc seam. Controls: K1 and the slack hexagonal colouring have no covering pairs (seven
colours; six is spent at "the half-arcs of `ω(u)` carry `v`'s colours" and at "the third colours at `y_k` lie in `P_cl(v)`"); Townsend's ⅔π sector is
outside Condition 5.

### 2.5 Item 2, N2-SWAP — TRUE given item 6's second step, which it inherits; under Condition 5 TRUE outright [hand, one mind]
At a swap point `x` (`a | b` at `x`, `b | a` at `σx`): the half-arcs of `ω(σx)` at `x` (`30°` outer, `210°` inner) avoid `P_cl(σx) ⊇ {a, b}`. Unless
`Γ` runs along them, `x` has an outer colour `o` and an inner colour `i` outside `{a, b}`. If `o = i = g`: `g ∉ P_cl(u)` (Siamese and outer at once), so
`g = c`, the third ring colour; if `P_cl(x) = {a, b, c}`, `(u, x)` is a covering pair at distance 1. Otherwise `|P_cl(x)| ≥ 4`: `= 4` if `ω(x)` carries no
`Γ`-arc, and item 6's second step gives the pair `(x, y)`. The route matches the statement's shape. Under Condition 5, NB-4 removes the four-colour case,
so a swap gives `(u, x)` directly. Note: a swap may also give `(u, σx)` (the same argument at `σx`); the statement's parenthesis lists `(u, x)` and
`(x, y)` — harmless if "swap point" names either end.

### 2.6 Item 3, N2-ACT1-W0 — TRUE under Condition 5; GAP otherwise, inheriting item 6 [hand, one mind]
Under Condition 5: a four-colour vertex does not exist (NB-4, so that clause is vacuous) and a swap gives `(u, x)` (§2.5). Without it, "bar the named unit
arcs" names arcs of `ω(σx)` at `x`, of `ω(x)` and of `ω(v)`, but not the arcs at the change points of a four-colour vertex's ring that item 6's second
step needs. **Scope note (divergence of consequence):** by NB-5, under Condition 5 a close covering pair is impossible, so N2-ACT1-W0 under Condition 5
reads: *a tight six-map in `𝓜_K` under Condition 5 has no swap anywhere and no four-colour vertex* — every trivalent ring has `|W| ≥ 2`. Act One under
Condition 5 is then equivalent to the non-existence of such maps.

### 2.7 Item 4, N2-TRANS — TRUE at the nerve step under its hypotheses, bar `d = 2` [hand, one mind, a sketch at genericity]
For `z` on the edge (type `{a, b}`) colour `ω(z) ∖ Γ` by `{c, d, e, f}` (A-CIRC) and collapse `c, d ↦ ∗`; `W_∗(z)` is defined (finite trace: no unit
arcs) and changes only when `ω(z)` sweeps across a vertex `p`, by the degree of `p`'s collapsed sector cycle (tangency births change nothing). All of
`p`'s sectors are crossed on one side or the other, so `P_cl(p) ⊆ {c, d, e, f}`, and a non-zero jump needs `P_cl(p) ⊇ {e, f}` plus `c` or `d`:
`{c, e, f}` is complementary to `u′`, `{d, e, f}` to `u`, at distance `≤ |p − z| + |z − u| ≤ 2` (equality only in the collinear `d = 2` configuration);
`{c, d, e, f}` makes `(z, p)` a covering pair at distance 1. All excluded in an Act-One-free map, bar `d = 2`. The ends: as `z → u`, `ω(z)` passes a change
point `q` of `u`'s ring on one side; a jump there needs `q ⊇ {c, e, f}` — complementary to `u′`, or with `d`, covering with `z`, or with `a`/`b` a
four-colour vertex (item 6; none under Condition 5 by NB-4). So the identification holds; the residue is the `d = 2` configuration and a four-colour
`q` without Condition 5.

### 2.8 Item 5, N2-FLIP — the parity TRUE; the chain TRUE under Condition 5 given item 4 [hand, one mind]
Around a tile `T` of colour `a` with neighbours `b₁, …, b_n` (consecutive distinct), `u_i = {a, b_{i−1}, b_i}`, ring `R_i = S ∖ {b_{i−1}, b_i}`,
`S = [6] ∖ {a}`. Item 4's transport `R_i → R_{i+1}` is the restriction of the transposition `t_i = (b_{i−1} b_{i+1})` of `S` (identity when `b_{i−1} =
b_{i+1}`, i.e. `u_i`, `u_{i+1}` of one type). `Π = t_n ⋯ t_1` preserves `R_1`; `sgn Π = (−1)^{n − s}` (`s` the same-type steps), and `Π` swaps
`{b_n, b_1}` iff `n` is odd (each step exchanges the older and newer neighbour). So `sgn(Π|R_1) = (−1)^s`: **reversed iff `s` is odd.** Instances:
the pentagon `b₁ b₂ b₃ b₄ b₂` has `s = 1` (reversed); the pentagon with five distinct neighbours, the triangle and the squares `b₁b₂b₁b₂`, `b₁b₂b₃b₂`
have `s` even (checked in `tools/fs110_nb_ring.py`). Then `W(u₁) = −W(u₁) = 0`, a swap (item 1), a covering pair (§2.5) — under Condition 5 with no
other input. Needs every boundary vertex of `T` trivalent (true under Condition 5 by NB-4, bar bichromatic vertices of degree `≥ 4`, through which the
transport of item 4 runs unchanged since `z` keeps type `{a, b}`).

### 2.9 Items 7–10, 12
- **Item 7, N-SEAM — TRUE [hand, one mind].** `w₀ ∉` a tile of colour `j ∈ P_cl(x)` (A-CIRC), so `w₀ ∈ Γ`; each tile at `w₀` is Siamese or outer to `x`'s
  same-colour tile (N-E2), i.e. on one side of `ω(x)`. At a non-vertex `w₀` with sides `T₁, T₂`: a side constrained by `ω(x)` forces the arc tangent to
  `ω(x)` at `w₀`; constraints from both `ω(u)` and `ω(v)` would need both tangents, impossible for `0 < |u − v| < 2`; so both side colours are one `x`'s,
  one side Siamese and one outer, and the arc lies on `ω(x)`. TS-U then fills `x`'s side cones with its other colours: one colour in two sectors (a
  cusp of `c′` cannot merge them) when `|P_cl(x)| = 3`. Needs only `P_cl(u) ∪ P_cl(v) = [6]`, as stated.
- **Item 8, N2-S1 — TRUE, with the exceptional distances exact [hand, one mind].** The `c`-tile at `w₀` is locally `B(u,1)`'s side of the arc; a
  `c`-tile at `p = σ_v^{±1}w₀` (`|p − w₀| = 1`) must be Siamese or outer to it, which needs `ω(p)` tangent to `ω(u)` at `w₀`: `p = u` or `p = 2w₀ − u`;
  likewise for `c′`. `p = u` iff `|u − v| = 1`; `p = 2w₀ − u` iff `|u − v|² = |(w₀ − v) + (w₀ − p)|² = 2 + 2cos 60° = 3`. Otherwise `p`'s tiles avoid `c, c′`,
  and `v`'s ring (colours `P_cl(u) = {c, c′, γ}`) is `γ` on both sides of `p`. The side located `{1, √3}` numerically; they are exact.
- **Item 9, N2-HEX — TRUE given no `Γ`-arc of `ω(x_{k±1})` at the six rotation points (e.g. Condition 5) [hand, one mind].** At a rotation point
  `x_k` (`d | e`, partners `e | f` and `f | d`) the directions `330°`, `30°` must avoid `{f, d}`, `{e, f}`; a second `d`- or `e`-sector there is excluded by
  **TS-C** (it would be `> 1` from the same-colour cluster reaching `x_{k∓1}`: `|x + t e_φ − x_{k−1}|² = 1 + 2t cos(φ − 60°) + t² > 1` on the cone). So an
  outer colour `g ∈ P_cl(u)` sits at `x_k`, and `g`'s sectors at `u` face away from `x_k` (N-E2). With `S_g` the rotation points `g` serves, `g` owns at
  most `180° − spread(S_g)`; covering six points `60°` apart forces `Σ spread ≥ 180°`, so equality, and the only tiling is three consecutive pairs:
  sectors of exactly `120°`, each facing away from two consecutive rotation points. **Without TS-C the statement fails locally**: rotation points that are
  bichromatic degree-4 vertices `d, e, d, e` satisfy every pairwise constraint; TS-C is what kills them.
- **Item 10, N2-ROT — TRUE for swap-free patterns under Condition 5; "no other pattern forces a colour at `x`" is FALSE if a swap partner counts as a
  pattern [hand, one mind].** Partners at `σx`: `e→f` (rotation with `x`), `f→d` (the other rotation), `e→d` (swap), constant `f`; at `σ⁻¹x` likewise.
  (A+, A−) = both rotating as in item 9: outward cone forced (colour in `P_cl(u)` by TS-C; one colour only under Condition 5 by NB-4), `u`'s sector away
  from `x`; (B+, B−): inward, toward `x`; mixed rotations and constant partners force nothing (`d` or `e` can span the cone). **A swap partner forces
  colours at `x` on both sides** (§2.5). Reconstruction of the patterns is mine; stage 4 checks the side's definitions.
- **Item 12, N-HORN — (i) and (ii) TRUE; C-CUSP-K TRUE at LIM (a cusp is a zero-width sector of the tangent or bowtie kind), the transfer to R-CP only in
  V-CP's projection reading [hand, one mind].** (ii): `ω(z)` near `u` is `y = t + x²/2`; it enters `κ₁x²/2 < y < κ₂x²/2` for small `t > 0` iff `κ₂ > 1`,
  for `t < 0` iff `κ₁ < 1`; missed both ways iff `κ₂ ≤ 1 ≤ κ₁`, impossible. `κ₁ ≠ κ₂` holds because two circular arcs with one tangent and one curvature
  coincide. At LIM the kill is exact (A-EXACT on the open horn), so the pigeonhole `B_u ∩ B_v = ∅` runs with the horn counted as a ray. For SEQ, a horn
  contains no cone of positive angle, so R's fatness (`K(x, I_j; r, s) ⊆ C_j`) does not apply; V-CP's projection form (`A_j` open connected, projection
  containing `(r, sσ)`) does. A cusp that saves a pair makes a degenerate bowtie (`b, c_horn, b, a`) or a tangent horn (a T1 tangent seam).

### 2.10 Tool
`tools/fs110_nb_ring.py` (exact, `Fraction` angles in degrees): for rings given by formula (lists of arcs) it computes `W` and the swap points and checks
`|W| ≥ 2` when swap-free; for tiles given by their neighbour sequences it computes `s` and the parity of `Π|R_1` by the permutation product. Named
rings: the hexagonal ring `d e f d e f` and its reverse (`W = ±2`, no swap); two-coloured `60°` arcs (`W = 0`, six swaps); `d e d e f f`, three `120°`
arcs and a hexagonal ring with arcs `50°/70°` are refused as improper (an arc over `60°` holds a unit pair — why N2-HEX's arcs are exactly `60°`); five
tiles (`s` parity equals the transport parity on `R_1` in all five, the pentagon `b₁b₂b₃b₄b₂` odd). Recorded run exit 0,
`data/fs110/fs110-nb/ring.out`; plant (an improper ring declared proper) goes red for that row alone, `ring-plant.out`, exit 1 as intended.

### 2.11 The killing tests
- **Seven-colour control** (tight and slack hexagonal): every item spends six at a named step — item 1 at "three ring colours", NB-4 at "the third
  colours at `y_k` lie in `P_cl(v)`", N-X and NB-5 at "the half-arcs carry the partner's colours", items 7–8 at `P_cl(u) ∪ P_cl(v) = [6]`; K1 has no
  four-colour vertex and no covering pair, as the items require. Pass.
- **Townsend's ⅔π sector:** a unit-arc model; every Condition-5 result above is silent on it, and items 7, 8 (unit-arc seams) have no covering pair
  there (two colours). Pass.
- **Strip, pinhole, Parts:** the thirteen statements are exact statements about LIM, not area arguments; N-HORN's R-CP transfer is the only area
  claim, and in V-CP's form it inherits V-CP's scale bound. Parts's tiling has voids, so it is outside LIM. No test fires.
- **C-SEAMLIST completeness.** At a vertex of `𝓜_K` every blow-up is a cone; `T_u` is null iff two colours of `P(u)` lie in opposite closed
  half-planes: with three sectors a shared ray on `e_u^⊥` (tangent, T1 or T2); with a colour in two or more sectors, a bowtie; a zero-angle sector
  (cusp, item 12); or the hypothesis fails by size (cusp's `|P_ess| = 2`, V5's two- and four-sets) or `d = 2`. The list is complete **as a list of
  C-T-TAN's failures**; "sliver" is a positive-scale notion with no LIM content. **But completeness is the wrong question:** by NB-5, surviving
  C-T-TAN at `u` and `v` is not enough — `w₀` must itself be a unit-arc seam or a vertex with four or more colours, and without unit arcs neither
  survives. The seam list should be read at `w₀`, not at `u` and `v`.
- **Act One apart from the kills.** Items 1–3 and 5 produce a covering pair at distance exactly 1 using only A-EXACT, A-CIRC, N-E2 and (item 5)
  item 4's transport; no kill is used. Proved apart from the kills: yes, in the cases they cover. **But** NB-5 turns this round under Condition 5:
  the kills are total there, so Act One is not needed to finish — any covering pair is a contradiction — and what is open is only whether a
  Condition-5 map can avoid every swap (every trivalent ring `|W| ≥ 2`, every tile with even `s`).

## Stage 2 — SAVED

## Stage 3 — verdicts (committed before opening the side's record)

| # | statement | my verdict | minds / grade | the step that decides it |
|---|---|---|---|---|
| 1 | N2-RING | **TRUE**, and stronger: `|W| ≤ 1` forces a swap | 1 / [hand] + exact check | §2.2 |
| 2 | N2-SWAP | **TRUE given N2-V4's second step** (inherits its GAP); **TRUE outright under Condition 5** (NB-4) | 1 / [hand] | §2.5 |
| 3 | N2-ACT1-W0 | **TRUE under Condition 5** (the four-colour clause vacuous there); **GAP without it**: the arc exceptions named omit the arcs at a four-colour ring's change points | 1 / [hand] | §2.6 |
| 4 | N2-TRANS | **TRUE at the nerve step**, bar the collinear `d = 2` configuration and, without Condition 5, a four-colour change point of `u`'s ring (item 6) | 1 / [hand, a sketch at genericity] | §2.7 |
| 5 | N2-FLIP | **parity TRUE** (exact on five tiles); **the chain TRUE under Condition 5** given item 4 | 1 / [hand] + exact check | §2.8 |
| 6 | N2-V4 | first step **TRUE**; second step **GAP** at change points carrying unit arcs of `ω(y)`, `ω(σ_v^{±1}y)` (unnamed in the statement), and **vacuous elsewhere: no four-colour vertex exists there (NB-4)** | 1 / [hand] | §2.3 |
| 7 | N-SEAM | **TRUE** | 1 / [hand] | §2.9 |
| 8 | N2-S1 | **TRUE**; the exceptional distances are exactly `{1, √3}` | 1 / [hand] | §2.9 |
| 9 | N2-HEX | **TRUE** given no unit arc of `ω(x_{k±1})` at the rotation points, **through TS-C** (without it a bichromatic degree-4 rotation point defeats every pairwise test) | 1 / [hand] | §2.9 |
| 10 | N2-ROT | **TRUE for swap-free patterns** (one colour in the cone needs Condition 5 or NB-4's hypothesis); "**no other pattern forces a colour**" **FALSE if a swap partner counts** — it forces colours at `x` on both sides | 1 / [hand]; the pattern names reconstructed | §2.9 |
| 11 | N-E2 | **TRUE** (connected tiles) | 1 / [hand] | §2.1 |
| 12 | N-HORN; C-CUSP-K | (i), (ii) **TRUE**; **C-CUSP-K TRUE at LIM** (a horn is a zero-width sector; a cusp that saves a pair is a degenerate bowtie or a tangent horn); the transfer to R-CP holds in V-CP's projection reading, not R's cone reading | 1 / [hand] | §2.9 |
| 13 | N-X | (a)–(c) **TRUE**; (d) TRUE as far as quoted (truncated in my brief) | 1 / [hand] | §2.4 |

**On the side's claimed verdicts on the claims** (instance block): **C-ACT1 GAP** — agree, and under Condition 5 its open case is exactly "every
trivalent ring `|W| ≥ 2` and every tile with even `s`" (NB-5 makes any covering pair contradictory there). **C-CUSP-K TRUE** — agree. **C-TAN-POS: TRUE at a
non-vertex `w₀`, GAP at a vertex `w₀`** — under Condition 5 the vertex case is closed by NB-5 (a close covering pair does not exist), so the GAP is only
the unit-arc case. **C-SEAMLIST MISSTATED** — agree in substance: complete as a list of C-T-TAN's failures at `u` and `v` (§2.11), but the seam must
survive at `w₀`, where only unit arcs let it (NB-5). **C-T2 (ii), C-BOW-K (ii), S2 with unit arcs GAP** — consistent: every live case carries a unit arc.

**Registered expectations scored (G21):** items 1, 7, 11 as expected (TRUE); 6 GAP as expected; 2, 3 GAP-inheriting as expected; 4 came TRUE bar edge
cases (I gave 0.45); 9 and 8 TRUE; 10 split (TRUE and a FALSE clause), inside my 0.3 + 0.2; 12, 13 TRUE. The unexpected product is NB-4/NB-5, which no
row predicted.

## Stage 3 — SAVED

## Stage 4 — the side's record read (after `2af3fe01`); divergences

*Read: `plans/FS110-N-proof.md` §2.4 (N-X), §4.2–4.4, §6 in full; its heading list. Not read (budget): §1.4, §2.1–2.3, §2.5–2.6, §3, §5, the theorem
tables line by line, `data/fs110/fs110-n/`, `tools/fs110_n_*`. So the thirteen quotations were compared with their sections (items 1–5, 9, 10, 13), not
with the table lines character by character — left for the close.*

| # | kind | divergence | resolution |
|---|---|---|---|
| D1 | **definition** | The side reads **covering pair as `P_cl(v) ∪ P_cl(y) = [6]`** (§4.2: "`P_cl(y) ⊇ {e, f}` and `P_cl(v) ∪ P_cl(y) = [6]`"; §4.3 (ii) "`r ∈ P_cl(x)` and `(u, x)` is a covering pair"); `data/fs110/claims.md` §0 defines it as **disjoint** types covering all six. | Under the union reading N2-V4's second step is TRUE as the side proves it (a change point has both ring colours), and my GAP (item 6) is against the claim list's definition only. The union form is enough for C-T-TAN (its proof uses only "all six classes are in `P(u) ∪ P(v)`") and for N-SEAM; **N-X assumes disjoint types**, so a union pair from N2-V4 feeds C-T-TAN but not N-X. Correction owed: one definition, stated in the claim list, and N-X's use checked against it. |
| D2 | **result, beyond the side** | The side leaves "whether N-X's cascade closes at bounded `K`" a GAP (§2.4) and C-TAN-POS at a vertex `w₀` a GAP. | **NB-4/NB-5 close both under Condition 5**, with no bound on `K`: a four-colour vertex's ring change points carry inner and outer colours whose pairs alternate, and each of its four colours is squeezed into `60°` (`240° < 360°`). So under Condition 5 there is no four-colour vertex and **no close covering pair at all**; the seam question is then exactly the side's C-ACT1 residue (every trivalent ring swap-free, `|W| ≥ 2`, every tile even), and every live seam carries a unit arc. One mind (mine); a second mind owed. |
| D3 | scope (table line) | N2-ROT's table line (my item 10) says "no other pattern forces a colour at `x`"; §4.3 names the swap patterns `(A+, B+)`, `(A−, B−)` first. | Agree with §4.3; the **table line drops the swap clause — MISSTATED as a line** (FS-107's M3 kind). "One colour" in the cone holds in an Act-One-free map (else a four-colour `x`), or under Condition 5 by NB-4. |
| D4 | route | N2-HEX and N2-ROT: the side excludes a second `p`/`q` sector at a rotation point by N-E2 against the partner's ring tile; I used TS-C. | Same content (a tile reaching the partner is Siamese with it); no divergence of truth. |
| D5 | route | N2-TRANS: the side's nerve is `K₄` on `{c, d, e, f}` with faces `cde`, `cdf` and a homology identity; mine collapses `c, d ↦ ∗` and counts jumps at sweep events. | Same exclusions (three-colour points must hold `c` and `d`; four-colour points excluded), same `d = 2` residue. Agree. |
| D6 | agree | N2-RING, N2-SWAP, N2-FLIP (the leapfrog parity is the same argument), N2-HEX's counting, N-X (a)–(c), C-ACT1's GAP and its narrowed step. | — |
| D7 | quotation | Item 13 was truncated in my instance block; the record's (d) continues "… alternating along `ω(w₀)` in arcs whose interior points `60°` apart differ (N-E0), and every point `y ∈ ω(w₀)` in the closure of both an `a′`-tile and a `c′`-tile makes `(w₀, y)` a covering pair at distance 1 — the cascade." | TRUE in the union reading; in the disjoint reading it is item 6's step, vacuous under Condition 5 (NB-4). |

**Proposed edits for the close** (I edit none of these files):
- `data/fs110/claims.md` §0: the Siamese quotation's address is `plans/FS106-TQ-derivation.md` l. 348, not `plans/FS107-stability.md` l. 348; fix
  "covering pair" to one reading (the side's union form, or disjoint) and state which the kills need (C-T-TAN: union; N-X: disjoint).
- The derivation file: NB-4 and NB-5 as theorems at [hand, one mind: FS110-NB], each needing a second mind before any ledger use; N2-ROT's table line
  with its swap clause restored; N2-S1's exceptional distances exact (`{1, √3}`).
- `LEDGER.md` (at the close, if a second mind holds): "under Condition 5 a tight six-map in `𝓜_K` has no vertex of four colours and no close covering
  pair; the tangency seam there is the Act-One residue" — the four-colour half is S–V's Lemma 2 in a region-only, a.e. form for `𝓜_K`
  (`[SokolovVoronov2025]`; prior art for the conclusion, not the route).

## Stage 4 — SAVED
