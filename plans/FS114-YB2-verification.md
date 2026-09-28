# FS114-YB2 — blind verification of FS-114's construction side, rounds 2 and 3 (the Reuleaux bowtie; RSTOP, R, D2, FOUR, 13, GAPS)

*Job FS114-YB2, de Bruijn on Opus 5.5, launched 2026-09-28 about 07:40 UTC. Brief: the template `data/fs114/briefs/YB114-verify-construction.md`
with the instance `data/fs114/briefs/YB2-114-instance.md` (read from disk, uncommitted at start; its changes win), and
`data/fs114/briefs/STANDING-RULES.md`. Every object is rebuilt from its rule in words and checked by my own exact checker (`tools/fs114_yb2_*.py`),
written without reading any FS114-Y2 or FS114-Y3 file. Stage 1 (my verdicts) is committed before I open `plans/FS114-Y2-construction.md`,
`plans/FS114-Y3-construction.md`, `data/fs114/fs114-y2/`, `data/fs114/fs114-y3/`, `tools/fs114_y2_*`, `tools/fs114_y3_*` or
`data/fs114/briefs/ROUND3-card.md`.*

## Theorems this phase proved

(filled at each stage's end)

## Would have searched here (standing rule 3)

(one line per move, filled as they occur)

## Fence log (standing rule 13; brief § Rules)

- Start-up: `ls data/fs114/ data/fs114/briefs/` listed directory and brief **names** only (among them the fenced `fs114-n*`, `fs114-y2`, `fs114-y3`,
  `reports`, and the fenced briefs); nothing inside a fenced directory was listed, opened or grepped, and no fenced brief was opened.
- `git log --oneline -8` at start-up showed two subjects past the harness's start-up snapshot ("FS111-W: stage 4", "FS-114: round-3 construction
  logged; its blind verifier launched") — subjects only; no further `git log`, no `git log -p`.
- The harness's `git status` snapshot named the untracked `data/fs111/fs111-w/*.out` (FS-111's, fenced) and my instance file — names only.

## Stage 1a — SAVED: reading; the quotation check

### 1a.1 Read from disk

`STANDING-RULES.md` (rule 0 first); the template and the instance; `CLAUDE.md` § The aim, § Counter-priors, G83, G79, G71, G46, G22, G21, G20, G51 (the
session's load at start-up); `LEDGER.md` rows 133–136 in full; `data/fs114/claims.md` in full; `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ
and stage 5b (**not 5.3**); `data/fs114/briefs/Y114-construction.md` in full; `data/fs114/briefs/ROUND2-card.md` in full; `plans/FS112-derivation.md`
header, §1 through FS112-L60, and FS112-BOWTIE; `data/fs112/claims.md` §0 (the contact kinds, `P_cl`, `ω`); `plans/FS114-YB-verification.md` in full
(stages 1a–2); the header and API of `tools/fs114_yb_exact.py`; the builder `bowtie` of `tools/fs112_yb3_frags.py` (data layout only).

### 1a.2 The quotation check (standing rule 5) — `data/fs114/fs114-yb2/quotes.tsv`, run through FS114-YB's `tools/fs114_yb_quotes.py` unedited

13 quotations: the standing rules' five Kooshi quotations; the definitions and statements my verdicts rest on (the valid map, de Grey's Siamese
definition, FS112-U1, FS112-SIX, FS112-A4SIX, FS112-N3-DENSE3); K1 on the round-2 card; Question 2. **13 of 13 FOUND** (`quotes.out`); the tool's
self-test turns an altered word into MISSING (`quotes-selftest.out`). **The instance's statements are quoted from FS114-Y2's and FS114-Y3's records,
fenced until stage 1 is committed; their check is stage 2's first step.** No paraphrase found in my brief.

**Reading points recorded before any verdict.**
- The instance's object 1 names the disc radius `3√3/5`, the vertex `p` "of colours 1–4", `t1 = (p, e(30°), e(−30°))` — a Reuleaux triangle of width 1
  with a corner at `p` (the three corners are pairwise at distance 1: `|e(30°) − e(−30°)| = 1`). I read `p = (0,0)`, `q1 = e(30°)`, `q2 = e(−30°)`,
  `q3, q4` the mirrors `e(150°)`, `e(210°)` (the instance's "`q_i = e(±30°), e(180° ± 30°)`"; which is `q3` and which `q4` is fixed below).
- Statement 2 names `r = q1 + e(330°) = (√3, 0)`: `e(30°) + e(−30°) = (√3, 0)` — so `r = q1 + q2`, the fourth corner of the unit rhombus `p, q1, r, q2`.
- Statement 4 names "`top`", undefined in the instance; I read it as the top point of the bowtie's upper region (`t2`'s side), and fix it at stage 1b
  from the rule (a guess, flagged; stage 2 checks it).

## Stage 1a — SAVED

## Stage 1b — SAVED: my checker, its controls and plants; calibration on five held objects; my Reuleaux bowtie, built and checked

### 1b.1 The checker `tools/fs114_yb2_exact.py` (written for this job; FS-112's builders imported only to convert held objects)

*Arithmetic:* towers `ℚ(√d₁)…(√d_n)`, a value of level i a pair `a + b√d_i`; the sign exact by recursion (`sign(a)·sign(a² − b²d)` when the
parts disagree). No square root is ever adjoined for a test: every crossing, span and candidate test reduces to the sign of `k + m√E` with `k, m, E`
in the tower (`sgn_km`). *Verdict* for two tiles of one colour, a tile with itself included: **REJECT iff min < 1 < max**, from a complete list of
realised candidates (endpoint pairs; endpoint against a segment's foot or an arc circle's two points on the line through its centre; a segment's
foot of an arc's centre against the arc's two normal points; two arcs on their line of centres, concentric included) plus exact crossing tests;
every candidate is `|√D + k|`, compared with 1 exactly. For distinct tiles the **non-Siamese test is min ≥ 1**. Distinct tiles are assumed to have
disjoint interiors (the map check below supplies it). *Points:* exact ray count (slope changed on degeneracy), straddle iff min < 1 < max.

**Self-test** (`python3 tools/fs114_yb2_run.py selftest`, `data/fs114/fs114-yb2/selftest.out`, exit 0): eleven arithmetic checks (a two-level
tower `ℚ(√3)(√(2+√3))` included); eight controls (a Reuleaux triangle of width 1; rectangles of diagonal 1 and above 1; squares at gap exactly 1 and
9/10; crossing bars whose every candidate is ≥ 1.49; a unit cap over a bar and a cap over a cap, each nearest only at an interior pair, 0.9); six
point tests; **five checker plants, each flipping exactly the controls predicted**: `noself`, `closed`, `nocross`, `endsonly`, `nointerior`.
**Erratum, mine:** on the first run three control *predictions* were wrong, not the checker — the bars (length 3) and the bar (length 4) are
REJECTED against themselves (diameter > 1), the cap's chord is exactly 1 (so `closed` flips it), and `(0, −1)` is straddled by the Reuleaux triangle
(its corner's cone is `[−30°, 90°]`, not `[0°, 60°]`); each verdict was re-derived by hand before the predictions were corrected, and the
control `(−1, 0)` (min exactly 1) added.

### 1b.2 Calibration (`python3 tools/fs114_yb2_run.py calib`, `calib.out`, under `scripts/slot.py --mem 2 --cpus 1`)

| object | built from | same-colour pairs the object has / examined exactly | verdict | tight at 1 | plant beside the faithful twin → rejected pairs |
|---|---|---|---|---|---|
| brick (row 33) | `Seven.lean`'s words (`4/5 × 3/5`, shear `2/5`, colour `(i + 3j) mod 7`), cell (0,0) against `|i|, |j| ≤ 4` | 11 / 11 | **ACCEPT** | 3 | cells `9/10` wide → exactly `(0,0)` with itself, `(1,2)`, `(−1,−2)`, as predicted |
| hexagonal 7-colouring | side 1/2, centres `q a₁ + r a₂`, colour `(q + 3r) mod 7`, in `ℚ(√3)` | 11 / 11 | **ACCEPT** | 1 (the diameter) | side `11/20` → exactly the hexagon with itself |
| the strip | FS112-YB2's builder (imported, never edited), columns 0–2 against −4…6 | 82 / 82 | **ACCEPT** | 54 | — (its plants are FS112-YB2's and FS114-YB's) |
| the disk | FS112-YB2's builder | 71 / 71 | **ACCEPT** | 46 (26 self-maxima + 20 arc contacts, FS114-YB's count) | — |
| FS112-BOWTIE | FS112-YB3's builder | 21 / 21 | **ACCEPT** | 6 (FS112-YB3's six) | `h_is_g` → exactly `(G, H)` |
**Erratum, mine (a driver slip, caught by the plant):** on the first run the `h_is_g` plant read ACCEPT because my driver took the plant's pair list
from the faithful twin's colours, so the recoloured pair was never examined; the driver now builds each object's own pair list, and the plant fires.

### 1b.3 The design — derived, not searched (the conditions force almost all of it)

Labels: `p = 0`; `q1 = e(30°)`, `q2 = e(−30°)` (the instance's: `r = q1 + e(330°) = (√3, 0)` fixes `q1 = e(30°)`); `qC = e(150°)`, `qD = e(210°)`;
`top = (0, 1)`, `bot = (0, −1)`; `t1 = Reuleaux(p, q1, q2)` colour 1, `t3` its mirror colour 3, `t2` above (cone `(60°, 120°)` at `p`), `t4` below. The
edges at `p`: `t1|t2` on `ω(q2)`, `t2|t3` on `ω(qD)`, `t3|t4` on `ω(qC)`, `t4|t1` on `ω(q1)`; so the tactic tiles are colour 4 at `q1` and `qC`,
colour 2 at `q2` and `qD`. **Derivations used to shape the object** (each [hand; mine]; the checker then confirmed the object):
- **D-a.** Colour 2 is straddled by `t2` in a whole neighbourhood of `q1` (points of `t2` near `p` in direction `60°` come within `< 1`, points in
  direction `120°` stay beyond 1), and `t2` cannot reach `q1` (it would reach `qC` by the symmetry, diameter `√3`). So **five colours at `q1` means
  `P_cl(q1) = {1, 3, 4, 5, 6}`**.
- **D-b.** Let `U` be the open region of `B(p, 1)` above `t1 ∪ t3`. In a non-Siamese fragment every tile meeting `U` other than `t2` has colour 5 or
  6 (tiles of colours 1–4 contain `p`, and `U ⊂ B̄(p, 1)`); such a tile is the colour-5 or colour-6 tile at `q1` or at `qC`, because
  `U ∖ (B(q1, 1) ∪ B(qC, 1))` meets `U` only at `p` and `top` (polar check: `r ≥ 2cos(θ − 30°)` and `r ≥ 2cos(θ − 150°)` with `r < 1` hold only at
  `θ = 90°, r = 1`). With both 5 and 6 at `qC`, a `q1`-tile avoids `B(qC, 1)`: **`t2` contains the lens `Λ = U ∩ B(q1,1) ∩ B(qC,1)` from `p` to `top`**,
  so `top ∈ t2` (its diameter pair).
- **D-c.** At `top` outside `ω(p)`: colours 1 and 3 are straddled (`t1`, `t3` reach toward `top` from `p`), 2 lies in `B̄(p, 1)`; the tile in
  directions `0⁺` lies in `B(q1, 1)`, so it is the `q1`-tile of its colour (5 or 6; the colour-4 tile at `q1` cannot reach `top`, its mirror would
  too); by the symmetry the tile at `180⁻` is the mirror; a `q1`-tile lies in `B̄(q1, 1)`, i.e. at `top` in directions `[−120°, 60°]`, so the sector
  `[60°, 120°]` at `top` is **colour 4, outside `B(q1,1) ∪ B(qC,1)`**, and the colour-4 tile at `q1` lies outside `B(top, 1)`.
- **D-d.** Right of `t1`'s outer arc at `q1` (direction `300⁺`, inside `B(q2, 1)`) the tile is shared with `q2`; colour 4 is straddled there by
  `t4` (first order: directions `[ψ₂ − 270°, 120°]` only), and the colour-5/6 tiles at `q2` are the `U`-tiles' mirrors, which reach `bot`; so it is
  **colour 3, one tile `V` through `q1` and `q2`, inside the vesica `B̄(q1,1) ∩ B̄(q2,1)`**, hence `V` at `q1` lies in `[300°, 360°]`.
- **D-e (the conflict that fixes the order at `q1`).** If the colour-4 tile at `q1` were adjacent to the `U`-tile `X` along `ω(top)` (from `q1`),
  while the colour-4 tile at `top` is adjacent to `X` along `ω(q1)` (from `top`, D-c), then for `x = top + e(−30° + t)`, `y = q1 + e(150° − t′)`,
  `|x − y|² = |−1 + e^{it} + e^{−it′}|² = 1 − 2tt′ + O(3) < 1`: the two colour-4 tiles straddle. **So between the colour-4 tile at `q1` and `X`
  lies the colour-6 tile `Z`, adjacent to `X` along `ω(top)`** (kind both: `top` carries 5 and 6). Checked exactly: the plant `wedge_swap` (4 and 6
  exchanged in the wedge) is REJECTED at exactly the four predicted pairs, by both checkers (below).

### 1b.4 My object (`Bowtie` in `tools/fs114_yb2_run.py`; `python3 tools/fs114_yb2_run.py bowtie`, `bowtie.out`), over `ℚ(√3)`

Base tiles (the rest by the reflections, colours by `(1 3)(5 6)` and `(2 4)(5 6)`): `t1`; `t2` = `p →ω(q2)→ A → B →ω(qC)→ top →ω(q1)→ B′ → A′
→ω(qD)→ p` with `A = ((√3−1)/2)(1, 1)` on `ω(q2)` and `B = (1 − √3/2, 1/2)` on `ω(qC)`, both on the line `⟨x, e(60°)⟩ = 1/2` (so `X` and its point
image are ≥ 1 apart, tight at `|A + B| = 1`); `X` (5) = `A →ω(q2)→ q1 →ω(top)→ F3 → FM → F4 →ω(q1)→ top →ω(qC)→ B → A`; `V` (3) = `q2 →ω(q1)→ F1_y →
OUT → F1 →ω(q2)→ q1 →ω(p)→ q2`; `T1` (4) = `q1 →ω(q2)→ F1 → F2 → q1`; `Z` (6) = `q1 → F2 → F3 →ω(top)→ q1`; `Ttop` (4) = `top →ω(q1)→ F4 → F4′ →ω(qC)→
top`. Outer points: `F1 = q2 + (40/401, 399/401)`, `F2 = (11/10)e(30°)`, `F3 = ((399√3 + 40)/802, (403 + 40√3)/802) = top + e(−30°)·(399 + 40i)/401`,
`FM = (11/10)e(60°)`, `F4 = ((√3 + 20)/401, (400 + 20√3)/401)`, `OUT = (11/10, 0)`. **Twenty tiles**, colour classes `1: t1, V′`; `2: t2, T1_y, T1_xy,
Tbot`; `3: t3, V`; `4: t4, T1, T1_x, Ttop`; `5: X, X_xy, Z_x, Z_y`; `6: X_x, X_y, Z, Z_xy`.

**Results (exact).** Map consistency: every tile a closed chain, every inner piece shared by exactly two tiles in opposite directions, 22 outer
pieces, all segments; float guard: every tile counter-clockwise, area sum 3.623021. **The outer boundary is farther than `3√3/5` from `p` at every
point** (exact, per segment against `27/25`), so the fragment holds `B̄(p, 3√3/5)` (and every disc up to ≈ 1.054). At `p`: `t1, t2, t3, t4`, colours
1–4 (degree 4); at each `q_i`: five tiles, five colours (`q1`: `t1 V T1 Z X` = 1, 3, 4, 6, 5); at `top`: `X, t2, X_x, Ttop` (5, 2, 6, 4). **Same-colour
pairs the object has: 46 (20 self); examined exactly: 46; REJECT: none; distinct pairs with min < 1: none (non-Siamese); tight at 1: 32** (12 self
maxima, 20 minima). Each tactic tile meets the inner tile at `q_i` alone (`T1` and `t1` lie on opposite sides of a line through `q1`, cones `[≈0°, 30°]`
and `[180°, 300°]`; exact at the vertices, the separating line of direction `135°`).

**The ACCEPT audited.** (i) **FS114-YB's checker, unedited** (`tools/fs114_yb2_second.py`, my tiles converted exactly): 46 pairs, no reject, no
distinct pair with min < 1 (`second.out`); on the plant `wedge_swap` it rejects exactly my four (`second-wedge_swap.out`). (ii) Float guard (400
points per piece): least sampled distance between distinct same-colour tiles 1.000000000, greatest sampled diameter 1.000000000; under
`wedge_swap` 0.990025 (the D-e formula at `t = t′ = β ≈ 0.0998`: `√(1 − 2β²) = 0.9900`). (iii) **Plants beside the faithful twin**
(`bowtie-plant-*.out`): `wedge_swap` → exactly `(Ttop, Z), (Ttop, Z_x), (Tbot, Z_y), (Tbot, Z_xy)`, as predicted; `cut_low` (the cut at
`⟨x, e(60°)⟩ = 5/13`) → exactly `(X, X_xy), (X_x, X_y)`, as predicted; `ttop_six` (`Ttop` recoloured 6) → the predicted `(Ttop, X_x), (Tbot, X_xy)`
**and** `(Ttop, Z), (Tbot, Z_y)`, which I had not predicted — the same D-e conflict (`Z`'s arc on `ω(top)` against `Ttop`'s on `ω(q1)`), checked by
hand; a misprediction of mine, not a checker fault.

**Verdict on object 1 (FS114-Y2-BOWTIE's conditions): REALISED — my own fragment meets every condition the instance names** (non-Siamese, valid,
twenty tiles over `ℚ(√3)`, D2-symmetric with the stated action, holds `B̄(p, 3√3/5)`, `p` of degree 4 with colours 1–4, `t1`, `t3` Reuleaux of
width 1 corner to corner, all four edges at `p` tactic with centres `q_i` of five colours and tactic tiles meeting the inner tile at `q_i` alone).
[tools, exact; one mind (mine); two checkers]. Whether it is *the same* object as Y2's is stage 2's comparison.

## Stage 1b — SAVED
