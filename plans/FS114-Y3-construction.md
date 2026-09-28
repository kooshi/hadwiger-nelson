# FS114-Y3 — the construction side of FS-114, round 3 (the Reuleaux bowtie to radius 2, or its stop)

*Job FS114-Y3 (de Bruijn, Opus 5.5), 2026-09-28, from `data/fs114/briefs/Y3-114-construction-round3.md`, the cards `ROUND3-card.md` and
`ROUND2-card.md`, FS114-Y's brief `Y114-construction.md` and `STANDING-RULES.md` (all read in full, rule 0 first). Working files
`data/fs114/fs114-y3/`; exact checks `tools/fs114_y3_*.py`; my scratch `scratchpad/fs114-y3/` (regenerable only). Every statement about a valid map
is about a possible object: the class is not known to be non-empty. Notation as `data/fs112/claims.md` §0 and `plans/FS114-Y2-construction.md`
§1b: `p = 0`, `q1 = e(30°)`, `q2 = e(−30°)`, `q3 = e(210°)`, `q4 = e(150°)`, `top = (0, 1)`, `bot = (0, −1)`; `t1` the Reuleaux triangle
`(p, q1, q2)` (colour 1), `t3` its mirror `(p, q4, q3)` (colour 3), `t2` above `p` (2), `t4` below (4); `T_i` the tile of the outer colour at `q_i`;
angles at a vertex are directions from it, counter-clockwise from the positive x-axis; a tile's **sector** at a vertex is the closed cone of
directions it fills there.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| FS114-Y3-RSTOP | **FS114-Y2-BOWTIE stops at `√3`**: no valid fragment (Siamese pairs allowed) that agrees with it near `q1` and `q2` contains a neighbourhood of `r = q1 + e(330°) = (√3, 0)`; so the bowtie extends to no closed disc of radius `√3` or more about `p`. The step: the ring of `q1` just above `r` has no state — a tile-interior point has colour 2 (N-E1), which straddles `T2`; a unit arc there has an outer colour that straddles its own `q1`-tile (FS112-U1) or, if 2, `T2` | [hand; tools exact at a named ring point, 11 of 11 as registered; one mind] | §2.1; `tools/fs114_y3_rstop.py`; `data/fs114/fs114-y3/rstop.out` |
| FS114-Y3-R | About every valid map with a Reuleaux bowtie at `p` that contains a neighbourhood of `r`: the ring of `q1` just above `r` carries, on it or just outside it, a colour `c` that (i) is absent at `q1`, or whose `q1`-tile lies in the open cone `(60°, 240°)` at `q1`, and (ii) has no tile at `q2` with a direction within 90° of `30°`. With five colours at `q1` this is **E1** (`T2`'s sector at `q2` inside `[240°, 300°]`) **or E2** (a tile at `q1` whose sector starts after `60°`, its colour pointing nowhere near `r` from `q2`) | [hand; one mind] | §2.2 |
| FS114-Y3-D2 | **The bowtie's symmetry class stops at `√3`, and forces five colours:** in a non-Siamese valid fragment with a Reuleaux bowtie at `p`, invariant under `x ↦ −x` with colours `(1 3)(5 6)` and `y ↦ −y` with `(2 4)(5 6)` (Y2's action) and containing a neighbourhood of `top`, each `q_i` has exactly five colours, its tiles `t1, W, T1, V, L` (FS114-Y2-BOWTIE's arrangement: `L ∋ top`, `T1` ending before `60°`, the sliver `V` between); and no such fragment contains a neighbourhood of `r`, so none holds the closed disc of radius `√3` about `p` | [hand; one mind] | §2.3 |
| FS114-Y3-FOUR | About every non-Siamese valid map with a Reuleaux bowtie at `p` containing a neighbourhood of `top`, in which `q1` and `q4` each have exactly four colours: `P_cl(q1) = {1, 3, 4, b}` with `b ∈ {5, 6}` on the single tile `X` between `T1` and `t1`, and colour 3 on the single tile between `t1` and `T1`; `X ∌ top`; the tile at `top` in the sector `(0°, 60°)` has the other colour `b̄`, absent at `q1`; and `q4`'s tile between `T4` and `t3` has colour `b` too. **So five colours at `q_i` are not forced by the bowtie**: their absence is paid for by a tile at `top` of a colour absent at `q1` | [hand; one mind] | §3.1 |
| FS114-Y3-13 | In the symmetry class with `x ↦ −x` acting as `(1 3)` (5 and 6 fixed), every non-Siamese bowtie fragment containing `top` has **exactly four colours** at each `q_i` (the sliver `V` never occurs), one tile `Y` of colour `b̄` covering the upper half of `top`'s neighbourhood, and `X`, `σ_x(X)` of one colour `b`, at mutual distance at least 1; the tiles along `t1`'s upper side are `t2`, `X`, `Y` only, and `X`'s points on `ω(p)` form a set `A` with `A ∩ (120° − A) = ∅`. FS114-Y3-R does not stop this class at `r`. Whether it holds any valid fragment is **open** (GAP: the filling of the region between `t1` and `t3` inside `B(p, 1)`) | [hand; one mind] | §3.2 |

## Would-have-searched-here log (standing rule 3)

- Stage 2: I would have tried tile layouts in the annulus `1.04 < |z| < 2` about `p`, extending the bowtie outward until one failed the checker;
  instead the ring of each `q_i` was read cone by cone (FS112-U1, N-E1) until a direction with no admissible state appeared (just above `r`), and
  only that point was probed, at one named ring point. For the symmetric class I would have enumerated colourings of the tiles at `top` and `q1`;
  instead each tile's colour was derived from the tiles at `p`, `q1`, `q4` that point toward it.
- Stage 3: I would have built trial four-colour bowties in the `(1 3)` class and run the checker on each; instead the class's forced structure was
  derived (four colours, `Y` at `top`, `X` and `X4` of one colour) and the construction is left, with its pressure point named, to a successor.

## Fence log (standing rule 13; the brief's § Fences)

1. At start-up `ls data/fs114/briefs/` listed every brief's file name (among them the proof side's `N3-114-proof-round2.md`, the verifiers'
   `CVB114-verify.md`, `NB114-*.md`, the advisor's `A114-advisor.md`), and `ls data/fs114/ plans/FS114*` listed by name the fenced directories
   `fs114-n`, `fs114-n2`, `fs114-n3`, `fs114-nb`, `reports`, and the fenced records `plans/FS114-N-proof.md`, `plans/FS114-N3-proof.md`,
   `plans/FS114-NB-verification.md`, `plans/FS114-close-inventory.md`. Names only; nothing in them opened or grepped.
2. `git log --oneline -8` at start-up showed one subject beyond the snapshot ("FS-114: round 2 compared; round-3 construction launched"). Subjects only.
3. Y2's quotation tool reads a paper text from `scratchpad/fs114-y2/`, a file this job did not create (it sits in the scratchpad directory this
   session shares); I did not run that tool or open the file, and wrote `tools/fs114_y3_quotes.py`, which regenerates the text into `scratchpad/fs114-y3/`.

## Stage 1 — SAVED: reading, the quotation check, calibration

### 1.1 Read from disk, in this order (reading status, G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first: `CLAUDE.md` § The aim and § Counter-priors, in context from disk), my round-3 brief, the round-3
  card, the round-2 card, FS114-Y's brief, Y2's round-2 brief (for its paths): **in full**.
- `plans/FS114-Y2-construction.md`: **in full**. `tools/fs114_y2_k1.py`: **in full** (the bowtie's every tile). `data/fs114/fs114-y2/k1.out`,
  `yb-calib-rerun.out`: read.
- `plans/FS114-YB-verification.md`: its headings, stage 1b (the checker, self-test, calibration table) **in full**; stages 1c and 2 **not read**
  (their objects are the round-1 strip and disk). `tools/fs114_yb_exact.py` lines 1–120 (arithmetic, verdict, plants); `tools/fs114_yb_run.py` header.
- `data/fs114/claims.md`: **in full**. `data/fs112/claims.md` §0: **in full**; `data/fs110/claims.md` §0: **in full** (covering pair, types, cusp).
- `plans/FS112-derivation.md`: lines 1–100 **in full** (the header, FS112-WALK, U1, SIX, NB4P, A4SIX, L60, LOCK, BEND, ISO, N2-BENDS, N2-RED, FLANK);
  the rest by grep for SIX, A4SIX, DENSE3, C-PARTNERS, C-COMPOSE. `plans/FS112-N-proof.md` §1.3 (N112-U1, N112-SIX) and §2.2 (L60, LOCK, BEND):
  **in full**; the rest not read this round.
- Not read this round (my brief lists them for FS114-Y's round 1; Y2 read them and its record carries what bears): `plans/FS114-unit-arc-question.md`,
  the FS-112 construction records, `[Thomassen1999]`, `[SokolovVoronov2025]` beyond Question 2, the Google group threads, `[Mohar2002]`, Ágoston 2025.

### 1.2 Quotation check (standing rule 5)

`tools/fs114_y3_quotes.py`: **25 of 25 FOUND** (`data/fs114/fs114-y3/quotes.out`) — Kooshi's quotations in FS114-Y's brief and the standing rules;
`[SokolovVoronov2025]` Question 2 against the claim list and the paper's text; the round-3 card's summaries of open records (CV-EXISTS against
`plans/FS114-CV-verification.md`; FS114-Y2-BOWTIE's radius, the `66.9°`, and Y2's "I did not derive …" against Y2's record); three sentences of the
round-3 card; the statements this record quotes (FS112-SIX, FS112-A4SIX, FS112-U1, K1, the tactic-edge sentence, repeat (A), C114-LOCAL-F,
FS114-Y2-GAPS, de Grey's Siamese). Self-test PASS (`quotes-selftest.out`: an altered word MISSING, its faithful twin FOUND, the faithful quotation
against the wrong file MISSING). **Not checkable:** the card's statements about the proof side (N3-DR0 … N3-PAY, K2-loc, GAP-μ) summarise fenced
records; I work them as the card states them. The card's "the fragment holds … radius `3√3/5 ≈ 1.039`" rounds Y2's `≈ 1.0392` (a summary, faithful);
its "a five-colour vertex whose ring lies inside a valid map" adds to FS112-SIX's statement the scope a fragment needs (the proof reads the whole ring).

### 1.3 Calibration (claim list §6: every new checker accepts the controls before a refusal is believed)

YB's checker, unedited, re-run in this session under `scripts/slot.py --mem 2 --cpus 1`:
- `python3 tools/fs114_yb_run.py selftest` → **SELF-TEST PASSED**, every checker plant flipping exactly its predicted controls
  (`data/fs114/fs114-y3/yb-selftest.out`).
- `python3 tools/fs114_yb_run.py calib` → brick, hexagonal seven-colouring, strip, disk, FS112-BOWTIE: **all ACCEPT**, pairs examined printed against
  the pairs each object has (17/3, 11/3, 90/24, 71/52, 21/18); every object plant REJECTs exactly the pairs YB registered (`yb-calib.out`).
- `python3 tools/fs114_y2_k1.py all` → FS114-Y2-BOWTIE **ACCEPT** (46 pairs, 40 examined), its plants `v5`, `wide_t1`, `wide_t1b` rejecting exactly the
  pairs of Y2's record (`y2-k1-rerun.out`).

## Stage 1 — SAVED

## Stage 2 — SAVED: the bowtie stops at `√3` — at `r`, the ring of `q1` has no state

**Frame.** `r = q1 + e(330°) = q2 + e(30°) = (√3, 0)`: the fourth corner of the unit rhombus `p, q1, r, q2`, at distance `√3` from `p`. The rings of
`q1` and `q2` cross there. Every extension of the bowtie to a disc of radius `√3` or more about `p` must colour a neighbourhood of `r`. Facts used,
each held: **N-E1** (`ω(u)` meets no open tile of a colour of `P_cl(u)`), **FS112-U1** (quoted, `tools/fs114_y3_quotes.py`: "At a unit arc `α ⊂ ω(P)` of
angular length `ℓ`, an inner side colour in `P_cl(P)` has its sectors at `P` in the closed cone of width `π − ℓ` facing `α`, an outer one in the
closed cone facing away"), the **diameter bound** (a tile of a valid map has diameter at most 1), and the **straddle rule** (two distinct tiles of one
colour with minimum distance below 1 and maximum above 1 are invalid, Siamese or not). One computation is used throughout: a tile with `q` in its
closure and a direction `ψ` at `q` has points `q + s·e(ψ)` for small `s`; a point `z` with `|z − q| = 1 + ε` then has
`|z − q − s·e(ψ)|² = (1 + ε)² + s² − 2(1 + ε)s·cos(ψ − arg(z − q))`, below 1 for suitable small `s` when the cosine is positive and `ε ≪ s`, and above 1
as `s → 0`. So **a tile at `q` with a direction within 90° of the direction to `z` straddles every other tile of its colour containing points just
beyond distance 1 from `q` near `z`**.

### 2.1 FS114-Y3-RSTOP — FS114-Y2-BOWTIE's own stop [hand; tools exact at a named point; one mind]

In the bowtie, `P_cl(q1) = {1, 3, 4, 5, 6}` with sectors at `q1`: `t1 [180°, 300°]`, `W (3) [300°, 330°]`, `T1 (4) [330°, 53.13°]`, `V (6) [53.13°, 60°]`,
`L1 (5) [60°, 180°]`; `T2`'s sector at `q2` is `[306.87°, 30°]` (`T1`'s mirror). Take `y = q1 + e(φ)`, `φ` just above `330°`, so `|y − q2| > 1`
(`|y − q2|² = 2 + 2 sin φ`). All but finitely many such `y` are (S) interior to a tile or (Γ) interior to a unit arc about `q1`.
- **(S)** The tile's colour is not in `P_cl(q1)` (N-E1), so it is 2. `T2` has directions at `q2` within 90° of the direction to `y` (about `33°`), so it
  straddles that tile, which is not `T2` (`q2 ∈ cl T2`, `|y − q2| > 1`, diameter). Invalid.
- **(Γ)** The outer tile `Z` has colour `c`. If `c = 2`: `T2` straddles `Z` as in (S). If `c ∈ P_cl(q1)`: its `q1`-tile has a direction within 90° of
  `φ` — `t1` at `280°`, `W` at `315°`, `T1` at `0°`, `V` at `55°`, and `L1` at `60° + η` for any `η < φ − 330°` (`cos(60° + η − φ) = sin(φ − 330° − η) > 0`)
  — so it straddles `Z` (FS112-U1's cone, violated). Invalid.

No state is left, so **no valid fragment agreeing with the bowtie near `q1` and `q2` contains a neighbourhood of `r`**. The bowtie holds the disc of
radius `3√3/5`; it can be extended to no closed disc of radius `≥ √3`. Siamese pairs are not excluded by the argument (every exclusion is a straddle).

*The exact check* (`tools/fs114_y3_rstop.py`, `data/fs114/fs114-y3/rstop.out`; YB's checker and Y2's builder imported unedited), registered in the tool's
docstring before its first run, at `y = q1 + e(330°)(399/401 + 40i/401)` (`φ − 330° = 5.72°`, all coordinates in `ℚ(√3)`): an S-probe (a triangle of
size `1/100` around `y`) coloured 2 against `T2`, and an O-probe (a triangle `1/1000` to `3/1000` outside `ω(q1)` at `y`, width `2/100`) coloured
1, 3, 4, 6, 5, 2 against `t1, W, T1, V, L1, T2`: **all seven REJECT**. Controls and plants, beside their faithful twins: the O-probe moved off the ring
to `r + e(16.26°)/100`, strictly inside the sector `(330°, 60°)` at `r`, coloured 5 against `L1` → **ACCEPT** (the exclusion of colour 5 needs the
ring: there `|z − q1 − s·e(60°⁺)|² − 1` has no real root in `s`), and coloured 4 against `T1` → REJECT; a colour-2 wedge at `q2` with sector
`[240°, 300°]` against the S-probe → **ACCEPT** (escape E1 below); a colour-5 wedge at `q1` with sector `[90°, 150°]` against the colour-5 O-probe →
**ACCEPT** (escape E2). **11 of 11 as registered.** The check confirms the derivation's inequalities at named values; the proof is the derivation (for
any small probe, not the one checked).

### 2.2 FS114-Y3-R — what every map with a Reuleaux bowtie needs at `r` [hand; one mind]

The same reading at `r` for any valid map with a Reuleaux bowtie at `p` (`t1` the Reuleaux triangle `(p, q1, q2)`, so its sector at `q1` is
`[180°, 300°]`): on or just outside the ring point `q1 + e(φ)`, `φ` just above `330°`, some tile of a colour `c` sits (the (S) tile or the (Γ) outer
tile), and it is valid only if
- (i) `c ∉ P_cl(q1)`, or `c`'s tile at `q1` has its sector inside the facing-away cone `[φ + ℓ + 90°, φ + 270°]` — for `φ → 330°⁺`, inside
  `(60°, 240°)`; and
- (ii) no tile of colour `c` at `q2` has a direction within 90° of `30°` (the direction from `q2` to `r`).

**With five colours at `q1`** (`P_cl(q1) = {1, 3, 4, 5, 6}`, the only absent colour 2, because no colour-2 tile is at `q1`: `t2` cannot reach `q1` by
its diameter, and any other colour-2 tile at `q1` straddles `t2`, which contains the ring points `q1 + e(210° − δ)` near `p`), (i)–(ii) leave two
escapes, and every such map uses one:
- **E1**: `T2`'s sector at `q2` lies in `[240°, 300°]` (colour 2 then passes (ii));
- **E2**: some tile at `q1` other than `t1, T1` and the tiles between `t1` and `T1` has its whole sector after `60°` (its colour passes (i)), and that
  colour has no tile at `q2` pointing within 90° of `30°` (it passes (ii)).
The mirror statement holds at `r` for the ring of `q2` just below `r` (E1′: `T1`'s sector at `q1` inside `[60°, 120°]`; E2′: a tile at `q2` whose sector
ends before `300°`). FS114-Y2-BOWTIE has neither (hence 2.1).

### 2.3 FS114-Y3-D2 — the symmetric class: five colours forced, and the stop [hand; one mind]

*Setting:* a non-Siamese valid fragment with a Reuleaux bowtie at `p`, invariant under `σ_x : (x, y) ↦ (−x, y)` acting on colours by `(1 3)(5 6)` and
`σ_y : (x, y) ↦ (x, −y)` by `(2 4)(5 6)` (FS114-Y2-BOWTIE's action), containing neighbourhoods of `top` and `r`. At `top` the circles `ω(p)`, `ω(q1)`,
`ω(q4)` cross (tangents `0°`, `60°`, `120°`), cutting six sectors; `(0°, 60°)` is inside `B(q1, 1)` and outside `B(p, 1)`, `B(q4, 1)`; `(60°, 120°)` is
outside all three.
1. **`N`, the tile covering direction `90°` at `top`, has colour 4.** `σ_x` fixes it, so its colour is fixed by `(1 3)(5 6)`: 2 or 4. It is not 2: its
   points lie outside `B̄(p, 1)` and `t2` has directions at `p` toward `top`, so `t2` straddles it.
2. **`T1` has no direction in `(60°, 240°)` at `q1`**: such a direction points toward `top` and `T1` would straddle `N` (both colour 4; `T1 ≠ N`, since
   `N = σ_x(N)` would then contain `q1` and `q4`, `√3` apart). So `T1 ⊂ [300° + β, 60°]`.
3. **The tile `L` at `top` in the sector `(0°, 60°)` is a tile at `q1`, with `q1`-sector inside `[60°, 180°]` and colour 5 or 6.** Its colour is not 1, 2 or 3
   (the tiles `t1, t2, t3` at `p` point toward `top`); not 4 (it lies inside `B(q1, 1)`, so `T1` straddles it; `T1 ∌ top` by step 2). If its colour
   were absent at `q1`: the tile at `q1` covering direction `150°` meets `B(p, 1)`, so has colour 5 or 6 (FS114-Y2-GAPS), the other one; its `σ_x`-image
   at `q4` has `L`'s colour and direction `30°`, straight at `top`, and straddles `L` (`L` has points outside `B̄(q4, 1)`, so is not that image). If its
   colour is present at `q1` on another tile, the two are within 1 near `q1` and not Siamese — invalid. So `L` is a `q1`-tile; containing `top`, its
   sector at `q1` lies within 90° of `150°`, inside `[60°, 180°]` (the inner gap), sector `[λ, 180°]` with `λ ≥ 60°`.
4. **Five colours at `q1`.** Every tile in `top`'s sector `(60°, 120°)` has colour 4 (5 and 6 are excluded by `L` and `σ_x(L)`, which point at `top`), so
   `N` fills `[60°, 120°]` and meets `L` along an edge leaving `top` at `60°`. That edge lies on `ω(q1)`: `cl L ⊂ B̄(q1, 1)` (diameter) and `N` misses
   `B(q1, 1)` (else `T1` straddles `N`). So it is a unit arc about `q1` of positive length `ℓ`, inner `L`, outer colour 4; FS112-U1 puts `T1`'s sector in
   `[240°, 60° − ℓ]`. `T1` ends before `60°`, `L` starts at `λ ≥ 60°`: a tile `V` lies between. With `t1`, `T1`, an outer-gap tile `W`, `V` and `L` at `q1`,
   distinct colours, and 2 absent (2.2), **`P_cl(q1) = {1, 3, 4, 5, 6}` exactly**, the tiles exactly `t1, W, T1, V, L`. By the symmetry, every `q_i`.
5. **The stop at `r`.** E1 fails: `T2 = σ_y(T1)` has sector `[300° + ℓ, 60° − β]`, containing `0°`. E2's only candidate is `L` (if `λ > 60°`); its colour
   `c(L) ∈ {5, 6}`; `{c(W), c(V)} = {3, c̄(L)}`, so `σ_y` gives `q2` a tile of colour `c(L)` among `σ_y(W)` (sector `[60° − β′, 60°]`) and `σ_y(V)` (sector
   `(360° − λ, 360° − θ_T)`, `θ_T < 60°`); both have directions within 90° of `30°`, so (ii) fails. No state at `r⁺` (2.2). ∎

**What 2.3 does and does not reach.** Steps 1 and 3 use `σ_x`'s swap of 5 and 6, and step 5 uses `σ_y`'s. The other three symmetric actions are **not
covered**: with `σ_x = (1 3)` (5 and 6 fixed) step 1 allows `N` of colour 5 or 6 and step 3 fails (a tile at `q4` and its image at `q1` share a
colour), so `top` may carry a colour absent at `q1` and `q1` may have four colours (stage 3); with `σ_y = (2 4)`, step 5's E2 escape survives when
`λ > 60°`. Without symmetry, 2.2 (FS114-Y3-R) is the general statement. **Where it bears** (the round-3 card's meeting point): FS114-Y2-BOWTIE does not
extend to radius 2; its stop is `√3`, at a named step — a first piece of C114-LOCAL-F for this configuration: *no Reuleaux bowtie in Y2's symmetry
class, and no extension of Y2's own fragment, holds the closed disc of radius `√3` about its degree-4 vertex `p`*. For K1 this means: the escape DR
(N3's), realised with Y2's symmetry, cannot carry a radius-2 argument's disc — any valid bowtie that does is asymmetric or uses another colour action,
and must use E1 or E2 at `r`. The proof side's K1, read at radius 2, is **not refuted** by any object of this job.

## Stage 2 — SAVED

## Stage 3 — SAVED: is the five-colour `q_i` forced? In Y2's class yes; in general no — four colours are paid for at `top`

*Item 2 of my brief. Setting throughout: a non-Siamese valid map (or fragment containing a neighbourhood of `top`) with a Reuleaux bowtie at `p`. At
`q1` the tiles run counter-clockwise `t1 [180°, 300°]`, the **outer gap** (tiles between `t1` and `T1`, directions from `300°`), `T1`, the **inner gap**
(tiles between `T1` and `t1`, ending at `180°`); FS114-Y2-GAPS and 2.2 give: 2 is absent at `q1`; inner-gap tiles with directions in `(120°, 180°)` meet
`B(p, 1)` and have colour 5 or 6; outer-gap colours lie in `{3, 5, 6}`. Tiles at `top` are read by the sector they occupy (2.3's frame).*

### 3.1 FS114-Y3-FOUR — what four colours at `q1` force [hand; one mind]

Let `q1` and `q4` have exactly four colours, so each gap at `q1` is one tile: `W` (outer, colour `a`) and `X` (inner, colour `b ∈ {5, 6}`); at `q4`, `W4`
(`a₄`) and `X4` (`b₄`).
1. **`X ∌ top`.** Suppose `X ∋ top` (so `X`'s sector at `q1` lies in `[60°, 180°]`, and `T1` ends at `θ_T ≥ 60°`). Take `N`, the tile covering direction
   `90°` at `top`. Its colour is not 1, 2, 3 (the tiles at `p` point at `top`) nor `b` (`X` points at `top`) nor `b₄` (`X4` points at `top`: it has
   directions near `30°` at `q4`). If it is 4, `T1` must not point at `top` (2.3 step 2), so `θ_T = 60°`; the `X|N` edge at `top` then lies on `ω(q1)`
   (as 2.3 step 4) and FS112-U1 puts `T1` inside `[240°, 60° − ℓ]` — contradiction. So `N` has colour `b̄` and `b₄ = b`; but then `X4` (colour `b`, pointing
   at `top` from `q4`) straddles `X ∋ top`. Contradiction.
2. So the tile `Y` at `top` in the sector `(0°, 60°)` is not a tile at `q1`. It lies inside `B(q1, 1)`, so its colour is absent at `q1` (a colour present
   there sits on a tile within 1 of it, and the pair is not Siamese). It is not 1, 2 or 3 (tiles at `p`). Its colour is therefore in
   `{5, 6} ∖ {a, b}` — which is non-empty only if **`a = 3`** — and equals **`b̄`**; and no tile at `q4` pointing at `top` has colour `b̄`, so `b₄ = b`. ∎

**Reading against Y2's arrangement.** The fifth colour at `q1` (the sliver `V`) is forced exactly when the tile at `top` beside `q1` is a tile of `q1`
(2.3 step 3); four colours at `q1` are possible only if that tile carries a colour absent at `q1`. So **five colours at `q_i` are not forced by the
Reuleaux bowtie**; they are forced by the bowtie together with `top`'s colours.

### 3.2 FS114-Y3-13 — the symmetry class where four colours are forced [hand; one mind]

Let the fragment be invariant under `σ_x : (x, y) ↦ (−x, y)` acting on colours by `(1 3)` (5 and 6 fixed); `σ_y` plays no part until the last item.
1. **Four colours at `q1`.** The tile `L` at `top` in `(0°, 60°)` is not 4 (2.3 step 3, whose argument for 4 uses no colour action), not 1, 2, 3. If it
   were a tile at `q1`, `σ_x(L)` would be a tile at `q4` of the same colour, also containing `top`: two tiles of one colour at `top`, so one tile,
   containing `q1` and `q4` (`√3` apart). So `L` is no tile at `q1`, its colour `b̄ ∈ {5, 6}` is absent at `q1` (3.1 step 2's argument), and
   `P_cl(q1) ⊆ {1, 3, 4, b}`: with the tactic's four, **exactly four colours**, `W = 3`, `X = b`. By the symmetry, at every `q_i`.
2. **`top`.** `L` and `σ_x(L)` both have colour `b̄` and contain `top`: they are one tile `Y`, which also covers `(60°, 120°)`; `top`'s lower sectors are
   `t2` or `Y` (a tile at `q1` or `q4` there would, with its mirror image, again join `q1` to `q4`). So `P_cl(top) ⊆ {2, b̄}`.
3. **The pressure point.** `X` and `X4 = σ_x(X)` share colour `b`, so they are at least 1 apart. Every point of `t1`'s upper side (the arc of `ω(q2)` from
   `p` to `q1`) is within 1 of `top` and of `q1`, so the tiles along it are `t2`, `X` or `Y` only (a colour-`b̄` tile there is `Y`, a colour-`b` tile is `X`,
   and colours 1–4 other than `t2` cannot meet `B(p, 1)` there); likewise `t2`, `X4`, `Y` along `t3`'s. On `ω(p)` (colours 5, 6 only; points `60°` apart
   of different colours), `X`'s points form a set `A ⊂ (30°, 90°)` and `X4`'s the set `180° − A`, so **`A ∩ (120° − A) = ∅`**.
4. **At `r`** (FS114-Y3-R): the ring colours at `q1` are `{2, b̄}`; `b̄` passes (i). It passes (ii) if `σ_y` fixes 5 and 6 (`q2`'s inner tile then has
   colour `b`), and if `σ_y` swaps them provided `T1` ends at `θ_T ≥ 60°` (`q2`'s inner tile, of colour `b̄`, then points nowhere within `90°` of `30°`).
   **So this class is not stopped at `r` by the argument that stops Y2's.**

**Open (GAP, named).** Whether the class holds any valid fragment: the region between `t1` and `t3` inside `B(p, 1)` must be filled by `t2` (diameter at
most 1, containing `p`, touching `ω(p)` only along unit arcs, since 2 is a colour at `p`), `X`, `X4` (one colour, at least 1 apart) and `Y` (diameter at most 1,
containing `top`), with item 3's constraints. Two layouts tried by hand fail at named corners: (a) `t2` ending where `t1`'s upper side reaches `x = 1/2`, so
that `X ⊂ {x ≥ 1/2}`, forces `t2` or `Y` to contain two points more than 1 apart (`(−1/2, y₀)` and `e(60°)`, `y₀ = −1/2 + (√3/2)^{1/2}`); (b) `Y` meeting
both sides at `x = ±1/2` puts the `X|Y` edge on the unit circle about `(−1/2, y₀)`, which cuts `ω(p)` near `69°`, and then `X ∋ e(65°)` and `X4 ∋ e(125°)`,
exactly 1 apart. Neither is a proof that the class is empty; they locate the difficulty.

## Stage 3 — SAVED
