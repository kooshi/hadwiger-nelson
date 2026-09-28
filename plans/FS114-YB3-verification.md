# FS114-YB3 — blind verification of FS-114's construction side, round 4 (FS114-Y4: LUNE, DIAG, RSTOPALL, SIDES, UPDOWN, W, D2ALL, E2X)

*Job FS114-YB3, de Bruijn on Opus 5.5, launched 2026-09-28 about 10:15 UTC. Brief: the template `data/fs114/briefs/YB114-verify-construction.md`
with the instance `data/fs114/briefs/YB3-114-instance.md` (read from disk; its changes win), and `data/fs114/briefs/STANDING-RULES.md` (rule 0 first).
Resuming check: no record, working directory or tool of this job existed at start. Working files `data/fs114/fs114-yb3/`; tools
`tools/fs114_yb3_*.py`; scratch `scratchpad/fs114-yb3/` (regenerable only). Every statement about a valid map is about a possible object: the class
is not known to be non-empty. Stage 1 (my verdicts) is committed before I open `plans/FS114-Y4-construction.md`, `data/fs114/fs114-y4/` or
`tools/fs114_y4_*`.*

**Notation** (the round cards' and FS114-Y3's, fixed here before any verdict). `p = 0`; `e(φ)` the unit vector at angle `φ`; `q1 = e(30°)`,
`q2 = e(−30°)`, `q3 = e(210°)`, `q4 = e(150°)`; `top = (0, 1)`, `bot = (0, −1)`; `r = q1 + q2 = (√3, 0)`. `t1 = Reul(p, q1, q2)` (colour 1),
`t3 = Reul(p, q4, q3)` (colour 3), `t2` the tile at `p` above (sector `[60°, 120°]` at `p`, colour 2), `t4` below (`[240°, 300°]`, colour 4). The sides:
`S1` = the arc of `ω(q2)` from `p` to `q1` (`t1`'s upper side), `S2` = the arc of `ω(q1)` from `p` to `q2`, `S4` = the arc of `ω(q3)` from `p` to `q4`,
`S3` = the arc of `ω(q4)` from `p` to `q3`. `X_i` = the tile along `S_i` at `q_i`, outside `t1` or `t3` (the instance's `X1…X4`). The tactic tiles
(R-T): `T1` (colour 4) at `q1`, `T2` (2) at `q2`, `T3` (2) at `q3`, `T4` (4) at `q4`, each touching the inner tile at `q_i` alone. The **upper lune**
`U` is the open region bounded by `S1`, the arc of `ω(p)` from `q1` to `q4` (its ring) and `S4`; the lower lune `L` its mirror. A tile's **sector** at a
vertex is the closed cone of directions it fills there, angles counter-clockwise from the positive `x`-axis. **Non-Siamese** is read as the project
reads it (FS114-Y2-GAPS, FS114-YB2): distinct tiles of one colour are at least 1 apart. **Straddle**: two distinct tiles of one colour with minimum
distance below 1 and maximum above 1 carry interior points at distance exactly 1 (both are connected open sets), so a valid map has none, Siamese or not.

## Theorems this phase proved

(filled at each stage's end)

## Would have searched here (standing rule 3)

| stage | move I would have made by search | what I did instead |
|---|---|---|
| 1b | enumerate colourings of the tiles at `top`, `q1`, `bot` to see which survive | derived each tile's colour from the tiles at `p`, `q_i` that point at the vertex (UPDOWN), one colour at a time |
| 1b | try fillings of a same-colour lune until one failed a checker | derived the contradiction from the two `t2`-frontiers (every cross pair at distance exactly 1) |
| 1b | probe points around `r` for a free colour | derived the straddler of each colour at the ring of `q1` just above `r` |
| 1c | build same-colour-lune fillings and asymmetric bowties by formula and run the checker on each | none built: the derivations decide the statements; the checker reads one held object (and its plants) against the structure the derivations say is forced |
| 2 | scan degenerate `T2` shapes for one that escapes DIAG step 5 | derived the one escape (a cusp along `300°` on `r`'s side of the tangent) and checked it once at named values, five registered verdicts |

## Fence log (standing rule 13; the template's and the instance's fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): lines naming milestone status (FS-112 closed, FS-114's jobs, standing rules). No line
   about FS114-Y4's statements or proofs. No file under that path was opened by me.
2. **The harness's start-up git snapshot** printed five commit subjects, among them `3de4d85a FS-114 inventory: no Reuleaux bowtie reaches root 3
   (construction side, one mind)` — a subject disclosing a grade ("one mind") for what reads as FS114-Y4-RSTOPALL — and `FS114-Y4: report`,
   `FS114-Y4: stage 4`, `FS114-NB5: stage 1a`. Subjects only.
3. My start-up `git log --oneline | head -5` printed one subject beyond the snapshot: `14111569 FS-114: construction round 4 logged; its blind
   verifier launched`. Subject only; no further `git log`, no `git log -p`.
4. `ls data/fs114/ data/fs114/briefs/` listed by **name** the fenced directories (`fs114-n` … `fs114-n5`, `fs114-nb`, `fs114-nb4`, `fs114-nb5`,
   `fs114-y4`, `fs114-cv`, `fs114-cvb`, `reports`, …) and the fenced briefs (the proof side's, the verifiers', the advisor's, Y4's). Nothing in them
   opened, listed or grepped.
5. `ls plans/ | grep -i fs114` listed by name the fenced records (`FS114-N-proof.md`, `FS114-N3/N4/N5-proof.md`, `FS114-NB*-verification.md`,
   `FS114-CV*-verification.md`, `FS114-Y4-construction.md`, `FS114-close-inventory.md`). Names only.
6. `ls tools/ | grep -E "fs112_yb|fs114"` listed by name the fenced tools `tools/fs114_n*`, `tools/fs114_nb*` and `tools/fs114_y4_diag.py`,
   `tools/fs114_y4_quotes.py`, `tools/fs114_y4_sides.py` (the Y4 names suggest exact checks called "diag" and "sides"). Not opened.
7. One `rg` for the quoted definition of "simple" ran with every fenced path excluded (`-g '!…'`); it printed nothing.
8. *Stage 2, a slip of mine (no fence):* re-running FS114-Y4's `tools/fs114_y4_diag.py` I wrote its output to a temporary file in the repository root
   (`scratch_y4diag.tmp`), not my scratch directory; it was deleted in the same command and never staged.

## Stage 1a — SAVED: reading; the quotation check

### 1a.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` **in full**, rule 0 first (`CLAUDE.md` § The aim and § Counter-priors, in context from disk at start-up); the template and the
  instance **in full**.
- `CLAUDE.md` G83, G79, G71, G46, G22, G21, G20, G51 (the session's load at start-up). `LEDGER.md` rows 133–136 **in full**.
- `data/fs114/claims.md` **in full**. `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ and stage 5b **in full**; **5.3 not read**.
- `data/fs114/briefs/Y114-construction.md` **in full** (its § Reading lists FS-112's close, the printed local NOs, the Google group and two papers:
  those sources are **not read this round**; what bears on these eight statements is in the FS-112 entries below and the round records).
- The round cards `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` **in full**.
- `plans/FS114-Y2-construction.md` **in full**; `plans/FS114-Y3-construction.md` **in full**; `plans/FS114-YB2-verification.md` **in full** (stages 1a–1c;
  it has no stage 2). Tools: `tools/fs114_yb2_run.py` **in full** (its bowtie builder, calibration conversions), `tools/fs114_yb2_exact.py` docstring and
  lines 1–80 (arithmetic), for data layout only (G46).
- `plans/FS112-derivation.md`: header, FS112-U1, FS112-SIX, FS112-NB4P, FS112-A4SIX, FS112-L60, FS112-N3-COR3 entries **in full**.
- `plans/FS114-L60-audit.md`: header and theorem table **in full** (L60-LE: "`ℓ ≤ 60°`"; L60-EQ at equality).
- **Not read:** every fenced file; `plans/FS114-YB-verification.md` beyond its size (round 1's strip and disk; its quotation tool run unedited).

### 1a.2 The quotation check (standing rule 5) — `data/fs114/fs114-yb3/quotes.tsv`, run through FS114-YB's `tools/fs114_yb_quotes.py` unedited

**17 of 17 FOUND** (`quotes.out`, exit 0): the standing rules' five Kooshi quotations (rules 0, 3, 4, 10); the instance's "at most 60°" (FS112-L60, in
`plans/FS114-L60-audit.md`); the instance's reading R-T against the round-4 card; the Siamese and valid-map definitions against the claim list; FS112-U1;
K1 and repeat (A) against the round-2 card; E1 against the round-4 card and E1, E2 against FS114-Y3's record; YB2-EMPTY13 against YB2's record; Y3-D2's
stop. The tool's self-test PASSED (`quotes-selftest.out`: an altered word turns FOUND into MISSING); my own two plants (one word changed in SR0 and in
R-T) read MISSING (`quotes-plant.out`, exit 1).

**Not checkable in stage 1:** (a) the eight statements, copied by the owner's script from `plans/FS114-Y4-construction.md` (fenced until stage 1 is
committed): stage 2's first step; (b) the instance's definition of **simple** ("every tile an open disc whose closure meets each other tile's closure in
a connected set or not at all, and does not meet itself"), and of ring, change point, lune and Γ-free: their sources (`plans/FS114-N3-proof.md`,
`plans/FS114-N-proof.md`) are fenced **always** for this job, and no unfenced file carries the sentence. I work them as the instance states them.

**Reading points recorded before any verdict.**
- The instance names `top`, `bot` "as in the round cards"; the round-3 card places them as the four-colour vertices at distance 1 from `p` whose rings
  reach radius 2, and FS114-Y3's notation fixes `top = (0, 1)`, `bot = (0, −1)`. I use those.
- "E0" (statement 3) is **not defined** in my brief, the cards or the open records (Y3 names E1 and E2 only). Its clause is checked at stage 2.
- Statements 2 and 8 do not say "non-Siamese" in their own words; statement 2's "diagonal" is the pattern statement 1 derives in non-Siamese maps, and
  statement 8's class is FS114-Y3-D2's, which is non-Siamese. I read both as non-Siamese and say where a step needs it.

## Stage 1a — SAVED

## Stage 1b — SAVED: my derivations of the eight statements (blind: no FS114-Y4 file opened)

*Every step is mine, [hand; one mind]. Two computations are used throughout.*
- **(P) Pointing.** If `|v − u| = 1 + κ` (`κ ≥ 0`) and a tile `Z` at `u` has points `u + s·e(φ)` for all small `s` with `cos(φ − arg(v − u)) ≥ c > 0`,
  then `|v − u − s·e(φ)|² = (1 + κ)² + s² − 2s(1 + κ)cos(…) < 1` once `s < c` and `κ ≪ sc`; so `Z` has points within `< 1` of every point near `v`.
- **(S) Straddle.** If moreover a tile `Y ≠ Z` of `Z`'s colour has a point `y` with `|y − u| > 1` near `v`, then `min(Y, Z) < 1 < max(Y, Z)` (the points of
  `Z` near `u` are farther than 1 from `y`): invalid, Siamese or not. In a non-Siamese map `min(Y, Z) < 1` alone forbids `Y ≠ Z` of one colour, and two
  distinct tiles at one vertex have distinct colours (their minimum is 0).
- **Diameter.** A tile of a valid map has closure of diameter at most 1 (a connected open set of diameter above 1 has interior points exactly 1 apart);
  so a tile with `u` in its closure lies in `B̄(u, 1)`.

### YB3-UPDOWN — statement 5: **TRUE**

`u + s·e(ψ)`, `|v − u| = 1`: `|v − u − s·e(ψ)|² = 1 + s² − 2s·cos(ψ − arg(v − u)) < 1` for `0 < s < 2cos(…)`. A tile at `v` has points arbitrarily near `v`,
so the tile at `u` has points within `< 1` of every tile at `v`; in a non-Siamese map it is that tile or its colour is absent at `v`. If `ψ` is an end of
the closed sector, directions just inside it satisfy the same strict inequality; a cusp at `u` tangent to `ψ` has points `u + s·e(ψ) + O(s²)`, the same
bound. ∎

### YB3-D2T — a diameter fact used below [hand; mine]

`t2` contains `p + s·e(120° − δ)` for every `δ ∈ (0°, 60°)` and every `s < ρ₀` (`ρ₀` a radius within which only `p`'s four edges meet `B(p, ρ₀)`): these
points lie outside `B̄(q3, 1)` (`|s·e(120° − δ) − q3|² = 1 + s² + 2s·sin δ`) and outside `B̄(q2, 1)` (`= 1 + s² + 2s·cos(30° + δ)`), so between `S1` and `S4`.
Then `|q1 − s·e(120° − δ)|² = 1 + s² − 2s·sin δ > 1` once `s > 2 sin δ`: **`q1 ∉ cl t2`**, likewise `q4 ∉ cl t2` and, mirrored, `q2, q3 ∉ cl t4`. With
UPDOWN (`t2` points at `q1`: direction `60°⁺` against `30°`), **2 is absent at `q1` and `q4`, and 4 at `q2` and `q3`, in a non-Siamese bowtie.** Also
`t4 ∌ q1` (`|q1 − s·e(270°)|² = 1 + s + s²`), and `t3 ⊂ {x ≤ 0}`.

### YB3-SIDES — statement 4: **TRUE** (clause 1 in every valid map; clause 2 non-Siamese)

`S1` ends at `q1 = q2 + e(90°)`, `S2` at `q2 = q1 + e(270°)`. The side points `z₁ = q2 + e(90° + ε)` and `z₂ = q1 + e(270° − ε)` differ by
`e(270°) + e(90° + ε) − e(270° − ε) = (0, 2cos ε − 1)`: `|z₁ − z₂| = 2cos ε − 1 < 1` (`0 < ε < 60°`). `X1` holds points `z₁′` just outside `B̄(q2, 1)` near
`z₁` for all small `ε`, `X2` points `z₂′` just outside `B̄(q1, 1)` near `z₂`, so `min(X1, X2) < 1`; and `|z₁′ − y| → |z₁′ − q2| > 1` as `y ∈ X2` tends
to `q2`, so `max > 1`. **One colour would straddle, Siamese pairs allowed.** `X1 = X2` would hold `q1` and `z₂′` (`|z₂′ − q1| > 1`): distinct.
*Clause 2.* `|z₁|² = 2 + 2cos(120° + ε) < 1`, so `X1` has points within `< 1` of `p`, hence of `t1…t4`; `X1` is none of them (`t1`: outside; `t2`: D2T;
`t3 ⊂ {x ≤ 0}`; `t4 ∌ q1`), so in a non-Siamese map `c(X1) ∈ {5, 6}`, likewise `c(X2)`, and **`{c(X1), c(X2)} = {5, 6}`**. ∎

### YB3-W — statement 6: **TRUE** (non-Siamese, simple; "simple" used once)

Let `W₁` be the tile along `t1`'s outer side (the arc of `ω(p)` from `q1` to `q2`) at `q1`, `W₂` at `q2`; `a = c(X1)`, `ā = c(X2)`.
1. `c(W₁) ≠ 1` (`t1` at `q1`, distinct). `≠ 2`: `t2` points from `p` at the arc point `w₀ = e(30° − κ)` (direction `60°⁺`, `cos(30° + κ) > 0`), UPDOWN,
   and `t2 ⊂ B̄(p, 1)` is not `W₁`. `≠ 4`: `t4` holds `p + s·e(300° − η)` (`η > 0`), `cos(270° + κ − η) = sin(κ − η) > 0` for `η < κ`: UPDOWN at `w₀`.
2. `c(W₁) ≠ a`: `W₁ ≠ X1` — at `q1` the tactic tile `T1` lies strictly between `W₁`'s first direction `300°` and `X1`'s last `180°` (its sector is in
   `[300° + β, 120°]`, FS114-Y2-GAPS / FS112-U1), so `W₁ = X1` would be one tile meeting `q1` in two sectors, which "simple" forbids; two distinct tiles at
   `q1` have distinct colours.
3. `c(W₁) ≠ ā`: `W₁` points at `q2` (direction `300°⁺` against `270°`), so it would be `X2`, which holds points outside `B̄(q1, 1)`: diameter.
4. So **`c(W₁) = 3`**, and by the mirror argument at `q2` (the arc point `e(−30° + κ)`: `t2` at `60°` gives `cos(90° − κ) > 0`, `t4` at `300°` gives
   `cos(30° + κ) > 0`; steps 2–3 with `X2`, `X1` exchanged) `c(W₂) = 3`; `W₁` points at
   `q2`, so `W₁` is the 3-tile at `q2`: **`W₁ = W₂ = W`**. Diameter: `W ⊂ B̄(q1, 1) ∩ B̄(q2, 1)`, so at `q1` its directions satisfy `cos(φ − 270°) > 0`, and
   starting at `300°` (one sector): `⊂ [300°, 360°]`; at `q2`, `⊂ [0°, 60°]`; every such direction is within `< 90°` of `330°` resp. `30°` (toward `r`).
5. **`t3`'s outer tile**: at `q4` the colours `3` (`t3`), `4` (`T4`), `c(X4)`, and the outer tile's colour is not 2 (`t2` direction `120°` at the arc
   point `e(150° + κ)`) nor 4 (`t4` direction `240°⁺`: `cos(90° − κ) > 0`) nor `c(X3), c(X4)` (`{c(X3), c(X4)} = {5, 6}` by SIDES on `t3`; step 3's
   argument for the one at `q3`): **colour 1, one tile at `q4` and `q3`.** ∎
*Without "simple"* step 2 fails: `W₁ = X1` (colour `a`, wrapped round `T1`) is not excluded by these steps; then `W₂ = 3` and `W₁ ≠ W₂`. The statement
assumes "simple", so this is scope, not a gap.

### YB3-LUNE — statement 1: **TRUE** (non-Siamese; "simple" not needed)

Suppose `c(X1) = c(X4) = a`. By SIDES on `t1` and `t3`, `c(X2) = c(X3) = ā`.
1. **Who meets `U`.** `U ⊂ B(p, 1)` (its boundary is `S1`, `S4` and the ring), so a tile meeting `U` has colour 5 or 6 or is a tile at `p`; `t1, t3` are
   the Reuleaux tiles and `t4` lies in the lower component of `B(p, 1) ∖ cl(t1 ∪ t3)` (`t1`, `t3` meet only at `p`), so of colours 1–4 only `t2` meets `U`.
2. **Along `S1`.** Every `z ∈ S1 ∖ {p}` is in `B(q1, 1)` (`|z − q1|² = 2 − 2cos α` at `z = q2 + e(90° + α)`, `α < 60°`), so an `a`-tile touching `S1`
   from `U` there is within `< 1` of `q1`: it is `X1`. **`X2` points at every `z ∈ S1 ∖ {q1}`**: it holds `q2 + s·e(180° + δ)` for small `δ > 0`, and
   `cos(90° + δ − α) = sin(α − δ) > 0` for `δ < α` (UPDOWN at `u = q2`, `v = z`); so an `ā`-tile touching `S1` from `U` away from `q1` is `X2`, which lies in
   `B̄(q2, 1)` and misses `U`. So **the tiles touching `S1` from `U` are `t2` and `X1` only**, and likewise along `S4`: `t2` and `X4` (`X3`, colour `ā`,
   points at every point of `S4 ∖ {q4}`).
3. **The frontiers.** `S1` is cut into finitely many arcs, each bordered from `U` by `t2` or `X1`, the first (at `p`) by `t2`, the last (at `q1`) by `X1`.
   At a vertex `m` between a `t2`-arc and an `X1`-arc, the tiles in the rotation at `m` on `U`'s side are `t2` or `X1`, so two consecutive ones are `t2`
   and `X1`: **an edge `e₁ ⊂ cl t2 ∩ cl X1` of positive length**. Likewise `e₄ ⊂ cl t2 ∩ cl X4`.
4. **The contradiction.** For `u ∈ e₁`, `v ∈ e₄`: `|u − v| ≤ diam cl t2 ≤ 1`, and `|u − v| ≥ dist(X1, X4) ≥ 1` (distinct, one colour, non-Siamese; `X1 ⊂
   B̄(q1, 1)` and `X4 ∋ q4` at `√3`). So `e₄ ⊂ ω(u) ∩ ω(u′)` for two points `u ≠ u′` of `e₁`: at most two points. ✗
So **`c(X1) ≠ c(X4)`**; with SIDES, `c(X2) = ā`, `c(X4) = ā`, `c(X3) = a`: **the lower lune differs too, and the pattern is diagonal**. The proof uses
neither "simple", nor the ring, nor Γ-freeness, nor `top`; it reads the closed lune, `q2` and `q3`. *This is the statement's sketch ("two frontier arcs
… inside `cl t2` at mutual distance exactly 1"); step 2 is what the sketch leaves implicit: that `t2` and not an `ā`-tile meets `X1` on `S1`.*

### YB3-DIAG — statement 2: **TRUE** (non-Siamese, simple; the statement's words omit both)

Diagonal: `c(X1) = c(X3) = a`, `c(X2) = c(X4) = b`, `{a, b} = {5, 6}`. At `top` the circles `ω(p)`, `ω(q1)`, `ω(q4)` cross with tangents `0°`, `60°`,
`120°`; the sector `(0°, 60°)` is inside `B(q1, 1)` only, `(60°, 120°)` outside all three discs.
1. **`N`** (the tile at `top` covering `90°`) **has colour 4.** `t1` (direction `60°`), `t2`, `t3` (`120°`) point at `top` and lie in `B̄(p, 1)`; `X1` points at
   `top` (directions `180°⁻` at `q1` against `150°`) and lies in `B̄(q1, 1)`; `X4` points at `top` (`0°⁺` at `q4` against `30°`) and lies in `B̄(q4, 1)`; `N`
   lies outside all three discs. So 1, 2, 3, `a`, `b` are excluded; 4 is left.
2. **`N` misses `B(q1, 1)` and `B(q4, 1)`**: a point there makes `N` the 4-tile `T1` (resp. `T4`), which lies in `B̄(q1, 1)`.
3. **The tile `L` at `top` in `(0°, 60°)` is `X1`.** Not 1, 2, 3 (step 1); not 4 (it would be `N`, meeting `B(q1, 1)`, against step 2); not `b` (it would
   be `X4`, but `L` has points outside `B̄(q4, 1)`); so `a`, and inside `B(q1, 1)` it is `X1`. **`top ∈ cl X1`**, and by the mirror `top ∈ cl X4`:
   **`top` carries `X1`, `N` (4), `X4`.**
4. **The arc.** At `top`, `X1` fills `(0°, 60°)` and `N` fills `(60°, 120°)` (every tile there is colour 4, so `N`), so they share an edge leaving `top` at
   `60°`; `X1 ⊂ B̄(q1, 1)`, `N ∩ B(q1, 1) = ∅`, so the edge is **a unit arc of `ω(q1)`, length `ℓ > 0`, directions `[150° − ℓ, 150°]` from `q1`**. `T1`
   has no direction within `< 90°` of an interior arc direction (it would straddle `N` just outside the arc, (P), (S)): **`T1 ⊂ [240°, 60° − ℓ]`** (FS112-U1).
5. **Five colours at `q1`.** `X1 ⊂ B̄(top, 1)` gives `X1 ⊂ [60°, 180°]` at `q1`; `W` (colour 3, YB3-W) starts at `300°`; `T1 ⊂ (300°, 60° − ℓ]`; 2 is absent
   (D2T). Between `T1`'s end and `X1`'s start (width `≥ ℓ > 0`) lie tiles of colours not in `{1, 3, 4, a}` and not 2: **one tile `V` of colour `b`, the
   sliver.** `P_cl(q1) = {1, 3, 4, a, b}`, tiles `t1, W, T1, V, X1` in that order, exactly.
6. **`X1` starts at exactly `60°`.** `V` has no direction in `(60°, 240°)` (it would point at `top` and be `X4`), so `V` ends at `≤ 60°`; nothing lies
   between `V` and `X1`; `X1` starts at `≥ 60°`: equality.
7. **At `bot`** (the mirror through the `x`-axis, colours `2 ↔ 4`): the tile `N′` covering `270°` has colour 2 (`t1` at `300°`, `t3` at `240°`, `t4` point at
   `bot`; `X2` at `180°⁺` from `q2` and `X3` at `360°⁻` from `q3` point at `bot`); `X2 ∋ bot`; the `X2 | N′` edge is a unit arc of `ω(q2)`, directions
   `[210°, 210° + ℓ′]` from `q2`, `ℓ′ > 0`, and `T2` (colour 2) avoids straddling `N′`: **`T2 ⊂ [300° + ℓ′, 120°]`**. With the tactic arc (`T2 ⊂ [240°,
   60° − ℓ₂]`, U1 at the `t1 | t2` edge): `T2 ⊂ [300° + ℓ′, 60° − ℓ₂]`. Five colours at `q2`, `q3`, `q4` likewise.
8. **The stop at `r`.** Take `y = q1 + e(330° + η)`, `0 < η` small, and a tile `Y` with points `y′ = q1 + (1 + ε)e(330° + η′)` just outside `ω(q1)` near `y`
   (it exists for all but finitely many such `y` when the fragment contains a neighbourhood of `r`). `c(Y) ∈ P_cl(q1)` is straddled by that colour's
   `q1`-tile (S): `t1` (`290°`), `W` (`300°⁺`), `T1` (inside `(240° + η, 60° + η)`), `V` (`≤ 60°`), `X1` (`60° + δ`, `δ < η`: `cos(90° + δ − η) > 0`). So
   `c(Y) = 2`, the one colour absent at `q1`, which needs `T2` to have no direction within `< 90°` of `30°`: **`T2 ⊂ [240°, 300°]` — E1, forced by the ring
   of `q1` above `r`** (E2 has no candidate: no `q1`-tile's sector starts after `60°`). Step 7's `T2 ⊂ [300° + ℓ′, 60° − ℓ₂]` is disjoint from `[240°, 300°]`;
   equivalently, under E1 the colour 2 at `bot`'s sector `(240°, 300°)` is straddled by `T2`, and every other colour is excluded there by step 7: **no
   neighbourhood of `r`.** ∎
*A point audited at the rate of a result I would want false:* under E1 a `T2` whose sector is the single direction `300°` (a cusp) is not pointed at
`bot` to first order (`cos 90° = 0`); it is still excluded, because the `X2 | N′` arc has positive length and `cos(300° − 210° − ℓ′/2) > 0` (U1's
facing-away cone, step 7). So the statement's last step holds, but through the arc, not through `bot` alone.

### YB3-RSTOPALL — statement 3: **TRUE** as to its headline; its clause "E0" **not verifiable** (E0 is undefined in my brief)

A neighbourhood of the closed unit disc about `p` contains the closed lunes, the `q_i`, `top` and `bot`. By YB3-LUNE every non-Siamese simple Reuleaux
bowtie is diagonal; by YB3-DIAG none also contains a neighbourhood of `r`; a closed disc of radius `√3` about `p` contains `r`. No step uses symmetry,
the ring's Γ-arcs or their absence. E1 is excluded (DIAG step 7–8), E2 has no candidate (DIAG step 6); "E0" is named nowhere in my brief, the cards or
the open records — if it is an escape through a colour absent at `q1` other than 2, DIAG step 5 excludes it (only 2 is absent). ∎

### YB3-D2ALL — statement 7: **TRUE** (non-Siamese)

`σ_y : (x, y) ↦ (x, −y)` fixes `t1`, `t3`, swaps `t2 ↔ t4` and maps `X1` (the tile along `S1` at `q1`) to `X2`; so its colour action `π_y` maps `c(X1)` to
`c(X2) ≠ c(X1)` (SIDES) with both in `{5, 6}`: **`π_y = (2 4)(5 6)`**, and "`y ↦ −y` acting as `(2 4)`" is empty, with no `top` used (SIDES clause 2 needs
non-Siamese). The remaining `D2` classes are `π_x ∈ {(1 3), (1 3)(5 6)}` with `π_y = (2 4)(5 6)`: the first is empty (YB2-EMPTY13, which reads `top`;
**YB3-LUNE empties it without `top`**, since `σ_x` maps `X1` to `X4` and `c(X4) ≠ c(X1)` forces `π_x` to swap 5 and 6), the second stops before `r`
(FS114-Y3-D2; also YB3-DIAG, with `bot` the `σ_y`-image of `top`). ∎

### YB3-E2X — statement 8: **TRUE** (non-Siamese, simple)

In FS114-Y3-D2's setting with `σ_x` acting as `(1 3)(5 6)` (its steps 1–4 use no `σ_y`): let `c(L) = 5`, `L ∋ top`, `L`'s sector `[λ, 180°]` at `q1`. If
`λ > 60°`, the sliver `V` between `T1` (ending `≤ 60° − ℓ`) and `L` has directions in `(60°, λ)`, pointing at `top`, so it is not 6 (it would straddle
`σ_x(L)`, colour 6, `∋ top`; `max > 1` since `|q1 − q4| = √3`), not 1, 2, 4, 5: **3**; then `W ∉ {1, 2, 4, 5, 3}` is 6 = `c(X2)` (SIDES), and points at `q2`,
so it is `X2` — diameter; or, as the statement says, it cannot reach `q2`, against YB3-W. So `λ = 60°`, and no `q1`-tile starts after `60°`: E2 is
impossible. ∎ This is YB3-DIAG step 6 in one symmetry class.

### A corollary the round needs (YB2's correction of FS114-Y3-FOUR, answered)

**YB3-FIVE** [hand; one mind]: in a non-Siamese simple valid fragment with a Reuleaux bowtie at `p` containing neighbourhoods of the closed upper lune,
of `q2`, `q3` and of `top`, **`q1` and `q4` each have exactly five colours** (DIAG steps 1–6 read nothing else). So FS114-Y3-FOUR's hypothesis (four
colours at `q1` and `q4`, with `top`) is **never met**: its class is empty, and "five colours at `q_i` are not forced by the bowtie" is FALSE as soon as
`top`'s neighbourhood is in the fragment — the corrected form YB2 asked for.

### Summary of stage 1b

| # | statement | verdict | grade, minds | hypotheses the proof uses |
|---|---|---|---|---|
| 1 | FS114-Y4-LUNE | **TRUE** | hand; one mind (mine) | non-Siamese; the closed lune, `q2`, `q3`; not "simple" |
| 2 | FS114-Y4-DIAG | **TRUE**; scope: non-Siamese and simple are used and not in its words | hand; one mind | + neighbourhoods of `top`, `bot` |
| 3 | FS114-Y4-RSTOPALL | **TRUE** (headline); **"E0" not verifiable** | hand; one mind, over 1, 2, 4, 6 | as 2 |
| 4 | FS114-Y4-SIDES | **TRUE** | hand; one mind | clause 1: any valid map; clause 2: non-Siamese |
| 5 | FS114-Y4-UPDOWN | **TRUE** | hand; one mind | — |
| 6 | FS114-Y4-W | **TRUE** | hand; one mind | non-Siamese, simple (once) |
| 7 | FS114-Y4-D2ALL | **TRUE** | hand; one mind, over YB2-EMPTY13, FS114-Y3-D2 (or 1–2) | non-Siamese |
| 8 | FS114-Y4-E2X | **TRUE** | hand; one mind | non-Siamese, simple |

## Stage 1b — SAVED

## Stage 1c — SAVED: my checker, its calibration, and the held bowtie read against the derived structure

### 1c.1 The checker `tools/fs114_yb3_check.py` (written for this job; a different method from FS114-YB2's on purpose)

*Numbers:* each is an exact sympy expression paired with a rigorous `mpmath` interval (400 bits). A sign is read from the interval when it excludes 0;
otherwise the expression's minimal polynomial over ℚ decides it (`x` means exactly 0; anything else raises `Undecided`, loudly). *Verdict* for two
tiles of one colour (a tile with itself included): **REJECT iff min < 1 < max**, from the complete list of critical pairs of `|x − y|²` on piece × piece
(endpoints; an endpoint against a segment's foot or the two points of an arc's circle on the line through its centre; a segment's foot of an arc's
centre against the arc's two points on that normal; two arcs on their line of centres, concentric included) plus exact crossing tests; each candidate
is `|√D + k|`, compared with 1 exactly. Non-Siamese test for distinct tiles: min ≥ 1. *Sectors* at a vertex are read from the tangents of the pieces
meeting there (boundaries counter-clockwise). FS-112's and FS114-YB2's builders are imported only to convert their held objects (tower numbers →
exact expressions, `tools/fs114_yb3_run.py`).

**Self-test** (`python3 tools/fs114_yb3_run.py selftest`, `data/fs114/fs114-yb3/selftest.out`, exit 0): eight arithmetic checks (nested radicals, ties at
1, a value `10⁻²⁰⁰` the interval must see); eight controls, each verdict predicted before the run (a width-1 Reuleaux triangle, a rectangle of diagonal
exactly 1 and one above, squares at gap exactly 1 and `9/10`, crossing bars, a unit cap over a bar and a cap over a cap whose nearest pairs are interior);
**six checker plants, each flipping exactly the controls predicted**: `noself`, `closed` (≤), `nocross`, `endsonly`, `nointerior`, `tieup` (a tie the
interval cannot see read as "above 1" with no exact test). *Slip, mine:* `tieup` first lived in the general sign routine and broke the arc
constructor's own exactness assertion (a crash, not a verdict); it now acts only on the distance comparison, where it was meant to.

### 1c.2 Calibration (`python3 tools/fs114_yb3_run.py calib`, `calib.out`, under `scripts/slot.py --mem 4 --cpus 1`, exit 0)

| object | built from | same-colour pairs the object has / examined exactly | verdict | tight at 1 | plant beside the faithful twin → rejected pairs (predicted before the run) |
|---|---|---|---|---|---|
| brick (row 33) | its rule in words: cells `4/5 × 3/5`, shear `2/5`, colour `(i + 3j) mod 7`; cell (0,0) against `|i|, |j| ≤ 4` | 11 / 11 | **ACCEPT** | 3 | cells `9/10` wide → exactly `(b0,0)` with itself, `(b1,2)`, `(b−1,−2)` |
| hexagonal 7-colouring | its rule: side `1/2`, centres `q·a₁ + r·a₂`, colour `(q + 3r) mod 7` | 7 / 7 | **ACCEPT** | 1 (the diameter) | side `11/20` → exactly the hexagon with itself |
| the strip | FS112-YB2's builder, unedited; columns 0–2 against −4…6 | 82 / 82 | **ACCEPT** | 54 | — |
| the disk | FS112-YB2's builder, unedited | 71 / 71 | **ACCEPT** | 46 | — |
| FS112-BOWTIE | FS112-YB3's builder, unedited | 21 / 21 | **ACCEPT** | 6 | `h_is_g` → exactly `(G, H)` |

The tight counts agree with FS114-YB2's on the strip (54), the disk (46) and FS112-BOWTIE (6), by a different arithmetic.

### 1c.3 The held Reuleaux bowtie, read by my checker against the structure my derivations say is forced (`bowtie.out`, exit 0)

*Object:* FS114-YB2's rebuild of FS114-Y2-BOWTIE (its builder `tools/fs114_yb2_run.py`, open to me, imported unedited; converted exactly). It is a
diagonal bowtie (`X` 5 at `q1`, `X_x` 6 at `q4`, `X_y` 6 at `q2`, `X_xy` 5 at `q3`) holding neighbourhoods of `top` and `bot`, so every forced item of
YB3-DIAG and YB3-W must hold on it; a failure would refute my derivation, not the object.
- **My checker: ACCEPT**, 46 same-colour pairs the object has, 46 examined, no distinct pair with min below 1 (non-Siamese), 32 tight at 1 (FS114-YB2's
  count, again by a different arithmetic).
- **The forced structure, all 13 items hold:** `q1` carries exactly five tiles of five colours, 2 absent, in the order `t1 (1) [180°, 300°]`, `W = V (3)
  [300°, 0°]`, `T1 (4) [0°, 30°]`, sliver `Z (6) [30°, 60°]`, `X1 = X (5) [60°, 180°]`; `X1` leaves `q1` at exactly `60°`; `W` is one tile at `q1` and `q2`,
  inside `[300°, 360°]` and `[0°, 60°]`; `top` carries colours `{2, 4, 5, 6}` with `X1`, a colour-4 tile and `X4`; the `X1 | N` edge is one unit arc of `ω(q1)`
  (directions `[144.28°, 150°]` from `q1`, `ℓ = 5.72°`) and `T1` lies in its facing-away cone; the sliver ends exactly at `60°`; the `X2 | N′` edge is one unit
  arc of `ω(q2)`, `T2 = T1_y (2) [330°, 0°]` lies in its facing-away cone (so it starts after `300°`) and points toward `r` — the step that closes E1.
- **Plants beside the faithful twin, predicted before the run:** `sides` (`X_y`, the tile along `S2` at `q2`, given `X1`'s colour 5) → **exactly**
  `(X, X_y)` (SIDES clause 1's straddle), `(X_xy, X_y)` (both at `bot`), `(X_y, Z_y)` (both at `q2`); `wcol` (`W` given `X1`'s colour) → **exactly** `(V, X)`
  and `(V, Z_y)` (both at a vertex of `W`); the pair `(V, X_xy)` stays accepted at min exactly 1 (`q2` against `B_xy` and `bot`), as predicted.

### 1c.4 SIDES at a named angle (`sides.out`, exit 0)

At `cos ε = 4/5`, `sin ε = 3/5`: `z₁ = q2 + (−3/5, 4/5)` and `z₂ = q1 + (−3/5, −4/5)` lie on `ω(q2)` and `ω(q1)`; `|z₁ − z₂|² = 9/25` exactly
(`= (2cos ε − 1)²`); `|z₁| < 1`.

### Theorems this phase proved (stage 1)

| id | statement (one line) | grade, minds | address |
|---|---|---|---|
| YB3-UPDOWN | FS114-Y4-UPDOWN, TRUE | hand; one mind (mine) | 1b |
| YB3-D2T | `q1, q4 ∉ cl t2`, `q2, q3 ∉ cl t4`; so 2 is absent at `q1`, `q4` and 4 at `q2`, `q3` in a non-Siamese Reuleaux bowtie | hand; mine | 1b |
| YB3-SIDES | FS114-Y4-SIDES, TRUE (clause 1 in every valid map, clause 2 non-Siamese) | hand + exact at a named angle; mine | 1b, 1c.4 |
| YB3-W | FS114-Y4-W, TRUE; "simple" used once (`W₁ ≠ X1`), and without it the step fails | hand; mine | 1b |
| YB3-LUNE | FS114-Y4-LUNE, TRUE, needing neither "simple" nor the ring; the sketch's implicit step is `X2` pointing at every point of `S1` | hand; mine | 1b |
| YB3-DIAG | FS114-Y4-DIAG, TRUE (non-Siamese, simple — not in its words); the cusp `T2 = {300°}` is closed through the `X2 | N′` arc | hand; mine; the forced structure holds on the held bowtie (13 of 13) | 1b, 1c.3 |
| YB3-RSTOPALL | FS114-Y4-RSTOPALL, TRUE as to its headline; "E0" undefined in my brief | hand; mine, over YB3-LUNE, -DIAG, -SIDES, -W | 1b |
| YB3-D2ALL | FS114-Y4-D2ALL, TRUE; YB3-LUNE empties the `(1 3)` class without `top` | hand; mine | 1b |
| YB3-E2X | FS114-Y4-E2X, TRUE; a case of YB3-DIAG step 6 | hand; mine | 1b |
| YB3-FIVE | with a neighbourhood of `top` (and the closed upper lune, `q2`, `q3`), `q1` and `q4` have exactly five colours: FS114-Y3-FOUR's class is empty | hand; mine | 1b |
| YB3-CHK | an exact checker by intervals and minimal polynomials, six plants firing as predicted, accepting the brick, the hexagonal 7-colouring, the strip, the disk and FS112-BOWTIE | tools | 1c.1–1c.2; `tools/fs114_yb3_check.py`, `tools/fs114_yb3_run.py` |

## Stage 1c — SAVED

## Stage 2 — SAVED: FS114-Y4's record read and compared (opened only after stage 1's commit `f8a9313e`)

### 2.1 The quotation check, completed

The instance's eight statements against `plans/FS114-Y4-construction.md`'s theorem table: **8 of 8 FOUND** verbatim (`quotes-stmts.out`, exit 0,
FS114-YB's tool unedited); also the definition of **simple** as Y4's header quotes it, and **E0** as Y4 §3 defines it ("E1 and E2 are both impossible, and
so is the third escape a four-colour `q1` would give (E0)"): FOUND. So my stage-1 guess at E0 was right, and RSTOPALL's E0 clause is **TRUE** (DIAG step 5:
only 2 is absent at `q1`).

**Replication, not independence:** FS114-Y4's `tools/fs114_y4_diag.py`, re-run unedited under `scripts/slot.py`, prints output identical to its committed
`diag.out` (19 of 19 as registered). Its E1 wedge `B4` has the sector `[253.74°, 286.26°]`, of positive width.

### 2.2 The two derivations compared (label map: identity — Y4's `X1…X4`, `W`, `N`, `N′`, sliver `V`, `L = X1` are mine; FS114-YB2's object: `V` = `W`,
`Z` = sliver, `X` = `X1`)

| # | item | FS114-Y4 (address) | FS114-YB3 (address) | divergence |
|---|---|---|---|---|
| 1 | LUNE's hypotheses | "simple" used: one switch point `c1 = cl t2 ∩ cl X1 ∩ S1` (§3.1 step 1); "the non-simple case is not covered" (§3.3, §4.3 item 4) | not used: any vertex of `S1` between a `t2`-arc and an `X1`-arc has a `t2 | X1` pair in its rotation (1b, YB3-LUNE step 3) | **scope**: LUNE holds without "simple"; Y4's open item 4 is answered for LUNE (not for W) |
| 2 | LUNE's frontier | semicircles about `c1`, each meeting `cl t2 ∩ cl X1` (§3.1 step 2) | the shared edge at the switch vertex (1b step 3) | route only |
| 3 | LUNE's implicit step (Y4's own audit target "LUNE item 1") | `X2` straddles points just outside `S1` (§3.1 step 1) | `X2` points at every `z ∈ S1 ∖ {q1}` (1b step 2) | **agree**, same inequality (`δ < α`); Y4's condition "`X2`'s germ reaches below `θ + 90°`" is mine written as `δ < θ − 90°` |
| 4 | SIDES and "simple" | §3.3 lists "SIDES' … `X1 ≠ W1`" under simple | SIDES uses no simplicity (Y4 §2.1's own proof uses none either) | **scope**: a wording slip in Y4 §3.3; only W needs "simple" |
| 5 | W, colour 4 excluded at `W₁` | `T1 ≠ W₁` (`T1` in the away cone `[300° + β₁, 120°]`) (§2.2) | `t4` points from `p` at the outer arc near `q1` (UPDOWN) (1b YB3-W step 1) | route only |
| 6 | W, colour 3 | two cases: `W₁ ≠ W₂` contradicts itself (§2.2) | `ā` at `W₁` would make it `X2`: diameter (1b step 3) | route only |
| 7 | DIAG step 5's reason | "`T2 ⊂ [240°, 300°]` has directions within 90° of `210°`" (§3.2 step 5) | through the `X2 | N′` unit arc at `bot`, `T2 ⊂ [300° + ℓ′, 120°]` (1b YB3-DIAG step 7) | **GAP in the written reason, statement unaffected** (2.3) |
| 8 | DIAG's "each `q_i` has exactly five colours" | derived at `q1` (§3.2 step 3); `q2, q3` not written | the mirror at `bot` written (1b step 7) | presentation; the mirror is what closes row 7 |
| 9 | DIAG's, E2X's hypotheses | carried by §2's and §3's setting paragraphs (non-Siamese, simple, R-T) | used, and absent from the statements' own words | scope, words only |
| 10 | DIAG step 4 (the tangent `X1` at `60°`) | `X1` has points `q1 + ρe(60° + g(ρ))`, `g → 0` | points `q1 + ρe(60° + δ/2)` for small `ρ` | agree |
| 11 | DIAG step 1 (colours at `top`) | as mine | as Y4 | agree, letter for letter |
| 12 | RSTOPALL, E0 | E0 = the four-colour `q1` escape, excluded by DIAG step 3 | undefined in my brief; my stage-1 reading matched | agree |
| 13 | D2ALL | four colour actions, reasons SIDES / YB2-EMPTY13 / Y3-D2 | the same four, same reasons; LUNE a second reason for `(1 3)`, needing no `top` | agree; free parameters counted alike (2 × 2) |
| 14 | grades | every statement one mind | each now **two minds, one blind** (mine), by partly different routes (rows 2, 5, 6, 7) | grade |

No divergence of truth: all eight statements are TRUE in both records.

### 2.3 The one gap, and its repair, checked exactly (`tools/fs114_yb3_cusp.py`, `cusp.out`; predictions registered in the docstring before the run)

**Where.** Y4 §3.2 step 5 blocks colour 2 in `bot`'s sector `(240°, 300°)` by "`T2 ⊂ [240°, 300°]` has directions within 90° of `210°`". E1 (step 4) allows a
`T2` whose sector at `q2` is the single direction `300°` — a cusp tile, legal in a segment-and-arc map — and `cos(300° − 210°) = 0`: first order says
nothing, and at second order a horn on `r`'s side of the tangent line stays at distance above 1 from `bot`'s sector (every point `w` there has
`(w − bot)·e(30°) < 0`, every horn point `z` has `(z − bot)·e(30°) > 1`).
**The repair** (YB3-DIAG step 7, the mirror of Y4's own steps 1–2 at `bot`): the tile `N′` in `bot`'s sector has colour 2, `X2 ∋ bot`, and the `X2 | N′`
edge is a unit arc of `ω(q2)` of length `ℓ′ > 0`, directions `[210°, 210° + ℓ′]` from `q2`; any `T2` with a direction within 90° of an interior arc
direction straddles `N′` just outside the arc — a cusp at `300°` does (`cos(300° − 210° − ℓ′/2) > 0`). So `T2 ⊂ [300° + ℓ′, 120°]`, disjoint from E1's
`[240°, 300°]`: the statement's conclusion holds, through the arc and not through `bot` alone.
**Exact, five of five as registered:** a horn `H` at `q2` between the tangent line (direction `300°`) and `ω(r)`, on `r`'s side, out to `s = 3/5`:
C1 `H` against a probe at `bot + e(270°)/100` → **ACCEPT** (the written reason does not fire); C2 `H` against a probe just outside `ω(q1)` above `r`
(`q1 + (1001/1000)e(330° + η)`, `cos η = 399/401`) → **ACCEPT** (the cusp is an E1 member there, second order included); C3 `H` against a probe just outside
`ω(q2)` at `q2 + (1001/1000)e(210° + φ)`, `cos φ = 399/401`, where `N′` lies beyond the arc → **REJECT** (the repair); C4 control, a wedge `[270°, 300°]` at `q2`
against the `bot` probe → **REJECT** (the written reason works at positive width); C5 `H` with itself → ACCEPT.

### 2.4 Verdicts after the comparison

| # | statement | verdict | grade, minds |
|---|---|---|---|
| 1 | FS114-Y4-LUNE | **TRUE**, and **without "simple"** | hand; two minds, one blind (Y4; YB3), different routes to the frontier |
| 2 | FS114-Y4-DIAG | **TRUE**; step 5's written reason a **GAP at a cusp `T2` along `300°`**, closed by the `X2 | N′` arc (exact at named values) | hand; two minds, one blind; the repair one mind (mine) |
| 3 | FS114-Y4-RSTOPALL | **TRUE**, E0 clause included | hand; two minds, one blind, over 1, 2, 4, 6 |
| 4 | FS114-Y4-SIDES | **TRUE** ("simple" not used) | hand + exact; two minds, one blind |
| 5 | FS114-Y4-UPDOWN | **TRUE** | hand; two minds, one blind |
| 6 | FS114-Y4-W | **TRUE** ("simple" used once, at `W₁ ≠ X1`, in both records) | hand; two minds, one blind, different routes |
| 7 | FS114-Y4-D2ALL | **TRUE** | hand; two minds, one blind |
| 8 | FS114-Y4-E2X | **TRUE** | hand; two minds, one blind |

### 2.5 Proposed edits for the close (standing rule 7: I edit none of these files)

- `LEDGER.md` § B / FS-114's derivation file: FS114-Y4-SIDES, -UPDOWN, -W, -D2ALL, -E2X, -LUNE, -DIAG, -RSTOPALL at **two minds, one blind** (Y4; YB3);
  LUNE's hypothesis list without "simple"; DIAG's proof with step 5 read through the `X2 | N′` arc (YB3-DIAG step 7; `tools/fs114_yb3_cusp.py`).
- FS114-Y3-FOUR (FS-114's derivation file, when filed): its closing inference "So five colours at `q_i` are not forced by the bowtie" is **FALSE** once
  the fragment contains a neighbourhood of `top` (YB3-FIVE; Y4 DIAG step 3): its class is empty; YB2's correction ("open for asymmetric maps") is answered.
- FS114-Y4 §4.3 item 4 ("the non-simple case of LUNE and W is not covered"): LUNE's is covered (row 1 above); W's stays open.

## Stage 2 — SAVED
