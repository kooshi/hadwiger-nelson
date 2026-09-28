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

## Would-have-searched-here log (standing rule 3)

- Stage 2: I would have tried tile layouts in the annulus `1.04 < |z| < 2` about `p`, extending the bowtie outward until one failed the checker;
  instead the ring of each `q_i` was read cone by cone (FS112-U1, N-E1) until a direction with no admissible state appeared (just above `r`), and
  only that point was probed, at one named ring point. For the symmetric class I would have enumerated colourings of the tiles at `top` and `q1`;
  instead each tile's colour was derived from the tiles at `p`, `q1`, `q4` that point toward it.

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
