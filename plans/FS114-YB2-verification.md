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

## Stage 1c — SAVED: verdicts on statements 2–7 (blind: no FS114-Y2/Y3 file, no ROUND3 card opened)

*Exact checks: `tools/fs114_yb2_stmts.py tactic|rstop|ring` → `stmt-tactic.out`, `stmt-rstop.out`, `stmt-ring.out` (on my object). Every verdict is
[hand; one mind, mine] unless marked. **Reading R-T, used throughout and flagged:** "a Reuleaux bowtie at `p`" is read as object 1's configuration —
`t1`, `t3` Reuleaux of width 1 corner to corner at `p`, `t2` above, `t4` below, **all four edges at `p` tactic** (colour 4 at `q1`, `qC`; colour 2 at
`q2`, `qD`, each on a tile meeting the inner tile at the centre alone) — with the fragment containing neighbourhoods of the `q_i` and covering the
regions `U`, `L` between `t1` and `t3` inside `B(p, 1)`. Labels as stage 1b (`q4` of the instance read as `qC = e(150°)`, from `e(180° − 30°)`).*

**Precondition, exact (`stmt-tactic.out`):** on my object each tactic tile and its inner tile lie in opposite closed half-planes of a line through
`q_i`, the tactic tile touching the line only at `q_i` — **they meet at `q_i` alone** (all four). This discharges stage 1b's sentence, which I wrote
before running the check (an ordering slip of mine, now closed).

### Summary

| # | statement | verdict | grade, minds |
|---|---|---|---|
| 1 | FS114-Y2-BOWTIE (object) | **REALISED** by my own fragment (stage 1b) | tools, exact; mine; two checkers |
| 2 | FS114-Y3-RSTOP | **TRUE**, with the germ condition made explicit; Siamese pairs not used | hand + exact at 10 points; mine |
| 4 | FS114-Y3-D2 | **TRUE under R-T**: five colours and Y2's arrangement forced; no neighbourhood of `r` | hand; mine. Without the tactic edges: GAP at one case (below) |
| 3 | FS114-Y3-R | **TRUE** (a necessary condition); **precision** to (i): a tile tangent to `60°` at `q1` (my `X`) lies pointwise in the open cone yet straddles every ring point just above `r` | hand + exact at 4 points; mine |
| 5 | FS114-Y3-FOUR | **not verified in general (my GAP, budget)**; its closing inference **"So five colours at `q_i` are not forced by the bowtie" does not follow** from a structure statement about a class not shown non-empty; in both symmetric classes I find no four-colour fragment (4 and 6) | hand; mine |
| 7 | FS114-Y2-GAPS | **TRUE** (part 1 over FS112-U1; part 2 immediate) | hand; mine |
| 6 | FS114-Y3-13 | **TRUE as stated, and vacuous: the class is EMPTY** — no non-Siamese fragment in it contains neighbourhoods of `top`, `q1`, `qC` and fills `U` (the open step, decided: none exists) | hand; mine, one mind |

### 2. FS114-Y3-RSTOP — TRUE

*Derivation.* Let `z = r + s·e(θ)`, `s > 0` small, `θ ∈ (−60°, 60°)`. Then `|z − q1| > 1` and `|z − q2| > 1` (outside `B̄(q1,1)` iff
`cos(θ + 30°) > 0`, outside `B̄(q2,1)` iff `cos(θ − 30°) > 0`). A tile `W ∋ q1` with a point `q1 + ρe(φ)`, `ρ` small, `cos(φ − 330°) > 0`, **straddles
`z`**: `|z − q1| > 1` gives the maximum, and `|z − q1 − ρe(φ)|² = |z − q1|² − 2ρ⟨z − q1, e(φ)⟩ + ρ² < 1` once `s` is small against `ρ` gives the
minimum (`z − q1 → e(330°)`). Likewise at `q2` with `cos(φ − 30°) > 0`. A straddled colour cannot hold `z`: the tile holding `z` is not the
straddler (whose diameter would exceed 1), and continuity gives interior points at distance exactly 1 — **Siamese pairs change nothing**. The germs
(my object's, and forced in the D2 class, §4): at `q1`, `t1` (1) has directions up to `300°`; `V` (3) from `300°`; `T1` (4) in `(300°, 60°)`; `Z` (6)
in `[b, 60°]` with `b < 60°` — each has points with `cos(φ − 330°) > 0`; at `q2` the mirrors `t1`, `V`, `T1_y` (2), `Z_y` (5) with `cos(φ − 30°) > 0`.
So **all six colours are straddled at every `z` in the cone `(−60°, 60°)` at `r`**, and no fragment agreeing with these germs contains a
neighbourhood of `r`; a closed disc of radius `≥ √3 = |r|` about `p` contains `r`. *Exact (`stmt-rstop.out`):* at `r + (1/100)u` for `u` at
`0°, ±36.87°, ±53.13°`: **no colour free**, each blocked by exactly the tiles named above; outside the cone, colours become free (`90°`: 4;
`126.87°, 180°, −126.87°`: 2, 3, 4; `−90°`: 2) — the stop is the cone `(−60°, 60°)` at `r`. *Germ condition (the hypothesis made explicit):* at
`q1`, tiles of colours 1, 3, 4, 6 each with points in directions `(240°, 60°)` arbitrarily near `q1`; at `q2` tiles of colours 1, 3, 2, 5 with
points in `(300°, 120°)`. Stage 2 checks it against Y2's bowtie.

### 4. FS114-Y3-D2 — TRUE under R-T

In the D2 class (non-Siamese; Y2's action `x ↦ −x`: `(1 3)(5 6)`, `y ↦ −y`: `(2 4)(5 6)`; neighbourhood of `top`):
1. `t2 ∌ q1` (else `t2 ∋ qC` by symmetry, diameter `√3`); colour 2 is straddled near `q1` (stage 1b D-a). The `U`-cusp at `q1` is a tile `X` of colour
   `c₁ ∈ {5, 6}`; its mirror `X′` at `qC` has `c̄₁`; `U ⊂ B̄(top, 1)`, interior strictly inside, so **every `c₁`-tile touching `top` is `X` and every
   `c̄₁`-tile touching `top` is `X′`**.
2. **The tile `Y` at `top` in direction `0⁺` outside `ω(p)` is `X`.** Colours 1, 2, 3 are straddled there; `X′ ⊂ B̄(qC,1)` lies at `top` in
   `[120°, 300°]`; a colour-4 `Y` lies within `< 1` of `q1`, so it is the tactic tile `T1` (R-T), whose mirror would also touch `top` — excluded. So
   `Y = X ∋ top`, `X ⊂ B̄(q1,1) ∩ B̄(top,1)`, `X′ ∋ top`, and the sector `[60°, 120°]` at `top` is a colour-4 tile `Ttop` outside `B(q1,1) ∪ B(qC,1)`;
   hence `T1 ⊂ ∁B(top, 1)`.
3. At `q1`, the tile `W` at `300⁺` lies in `B(q2, 1)`: not 4 (`t4`'s arc on `ω(q1)` from `p` straddles it), not `c₁` (`X` would then cover `T1`'s
   place), not `c̄₁` (it would be `q2`'s `c̄₁`-tile, the mirror `X_y ∋ bot`: diameter `√3`); so **`W = V`, colour 3, `V ⊂ B̄(q2, 1)`**, i.e. `V` at `q1`
   lies in `[180°, 360°]`.
4. `X` starts at `60°` (it lies in `B̄(top,1)`, the tiles before it do not). The tile adjacent to `X` along `ω(top)` is not `T1` (stage 1b D-e: with
   `Ttop` on `ω(q1)`, `|x − y|² = 1 − 2tt′ + O(3)`), not `V` (confined to `[180°, 360°]`), so it has colour `c̄₁` — **five colours**, in the order
   `t1, V, T1, Z, X`: Y2's arrangement (as I reconstruct it; stage 2 compares).
5. **No neighbourhood of `r`:** `T1` must avoid the unit discs about the points of `Ttop`'s arc `q1 + e(150° − t′)`, `t′ ∈ [0, t′₀]`, all of whose
   circles pass through `q1` with the discs covering directions `(60° − t′₀, 240°)` there; so `T1` lies in directions `≤ 60° − t′₀` and `Z`'s germ
   contains directions below `60°` by a positive angle. The germ condition of §2 holds, and RSTOP's argument applies.
**GAP without R-T** (outside the verdict, stated so it is not lost): if the edges at `p` need not be tactic, step 2 leaves the case `Y` = one
x-invariant colour-4 tile spanning `top`'s outside; then colour 4 is straddled at `q1`, and my steps do not decide that case.

### 3. FS114-Y3-R — TRUE (a necessary condition), with a precision

A colour holding points of `ω(q1)` (or just outside it) arbitrarily near `r` above it is straddled by none of its tiles there; by §2's computation its
`q1`-tile has no points in directions `φ` with `cos(φ − 330° − ε) > 0` for the point's offset `ε`, and its `q2`-tile none with `cos(ψ − 30°) > 0`
(up to `O(ε)`): these are (i) and (ii). **Precision (exact, `stmt-ring.out`):** my `X` (colour 5) has sector `[60°, 180°]` at `q1`, its points at
directions `60° + ρ/2 > 60°` — pointwise in the open cone `(60°, 240°)` — yet **`X` straddles `q1 + e(330° + ε)` on the ring at `ε = 5.71°` and
`ε = 1.15°`** (points at `ρ < ε` come within 1). So (i)'s "lies in the open cone" is necessary but not sufficient; E2's "sector starts after `60°`"
is the sharp form. As an existence claim R stands. E1/E2 with five colours `{1,3,4,5,6}` at `q1`: the covering colour is 2 (absent), whose tactic
tile at `q2` must avoid directions within `90°` of `30°` and, outside `B̄(p,1)` at `q2`, lies in `[240°, 300°]` (E1), or a `q1` colour whose tile
starts after `60°` (E2). *Reading point:* "five colours" excludes 2 at `q1` only when `t2 ∌ q1` (forced by symmetry; not decided here for asymmetric
maps). Exact at the ring, 1e-6 outside: at `ε = 1.15°` **no colour free**; at `ε = 5.71°` colour 2 is free (the point is not yet "just above" `r`
for my small `T1_y`).

### 7. FS114-Y2-GAPS — TRUE

Part 1: FS112-U1 puts the inner colour's sectors at `q` in the closed cone of width `180° − β` facing the arc and the outer colour's in the closed cone
facing away; with the arc running from `p`'s direction `d_p` to `d_p + β`, the facing cone is `[d_p + β − 90°, d_p + 90°]`, the away cone
`[d_p + β + 90°, d_p + 270°]`, the two gaps `(d_p + 90°, d_p + 90° + β)` and `(d_p − 90°, d_p − 90° + β)`, the second inside `B(p, 1)` (whose cone
at `q` is `(d_p − 90°, d_p + 90°)`). On my object at `q1`: `β = 30°`, `t1` fills `120° ≤ 150°`, `T1` fills about `30°`, the gaps `(120°, 150°)` (in
`X`, inside `B(p,1)`) and `(300°, 330°)` (in `V`). Part 2: a tile `W` meeting `B(p, 1)` whose colour is carried at `p` by another tile `W_p` has
`min(W, W_p) < 1`, which a non-Siamese valid map forbids (non-Siamese forces `min ≥ 1` for distinct same-colour tiles).

### 6. FS114-Y3-13 — TRUE, and the class is empty (derived)

Class: `x ↦ −x` acts as `(1 3)`, fixing 2, 4, 5, 6; non-Siamese; R-T; neighbourhoods of `top`, `q1`, `qC`; `U` filled. Then:
(a) as §4 step 1, `t2 ∌ q1`; the `U`-cusp tile `X` at `q1` has colour `c₁ ∈ {5, 6}` and its mirror `X′` the **same** colour;
(b) the tile `Y` at `top` direction `0⁺`: not `c₁` (it would meet `X′`'s points inside `B(top, 1)`; and `Y = X` would put `X′ ∋ top` too), not 4 (R-T:
it would be `T1`, whose mirror also reaches `top`), not 1, 2, 3; so **`Y` has colour `c̄₁`, is x-invariant, and `c̄₁ ∉ P_cl(q1)`** — with `V` (colour 3)
at `300⁺` as in §4 step 3, `P_cl(q1) = {1, 3, 4, c₁}`: exactly four (the statement's first clause, TRUE);
(c) R does not stop the class at `r`: `c̄₁` is absent at `q1` and at `q2` is carried by `X_y` in `[180°, 240°]` (not within `90°` of `30°`) — TRUE;
(d) **but the class is empty.** Inside `U`: colours 1, 3, 4 excluded (tiles at `p`), 2 only `t2`, `c̄₁` only `Y` (`U ⊂ B̄(top,1)`, interior strictly
inside, `Y ∋ top`), `c₁` only `X`, `X′` (a third `c₁`-tile would avoid `B(q1,1) ∪ B(qC,1)`, which misses `int U`). `X′` is the mirror of `X`, distinct,
same colour, so `|x − x̄| = 2|x₁| ≥ 1`: **`X ⊂ {x₁ ≥ 1/2}`, `X′ ⊂ {x₁ ≤ −1/2}`**, and the strip `S = U ∩ {|x₁| < 1/2}` lies in `t2 ∪ Y`. Its closure
holds `c₁± = (±1/2, −1/2 + √(√3/2)) ≈ (±0.5, 0.4306)` (on `ω(q2)`, `ω(qD)`) and `c₂± = (±1/2, √3/2)` (on `ω(p)`), with `|c₁+ − c₂−|² = 1 +
(√3/2 + 1/2 − √(√3/2))² ≈ 1.19 > 1`. The right edge `σ+ = {1/2} × [0.4306, 0.866]` of `S` is connected and covered by the closed sets `t2`, `Y` (both
x-invariant, diameters `≤ 1`); neither covers it alone (it would hold `c₁+` and, by the mirror, `c₂−`), so they share a point `m*`. If `c₂+ ∈ t2`, then
`c₂− ∈ t2`, so `c₁± ∉ t2`, so `c₁± ∈ Y`; and `|m* − c₂−| ≤ 1` forces `m* = c₂+`, putting `c₂+` and `c₁−` in `Y`: contradiction. If `c₂+ ∉ t2`, then
`c₂± ∈ Y`, `|m* − c₂−| ≤ 1` again forces `m* = c₂+ ∈ t2`: contradiction. **No such fragment exists** — the construction side's open step is decided in
the negative (one mind; the steps (b) and (d) are where a second mind should look first).

### 5. FS114-Y3-FOUR — partial

Consistent with (6) and (4): in the `(1 3)` class the four-colour structure is `P_cl(q1) = {1, 3, 4, b}`, `b = c₁`, and the `top` tile at `(0°, 60°)` is
`b̄` (derived above) — but that class is empty; under Y2's action four colours are impossible (§4). The general (asymmetric) statement I have **not**
verified. **Its closing inference fails as stated:** "So five colours at `q_i` are not forced by the bowtie" would need a map (or fragment) with four
colours; a structure theorem about the four-colour class does not supply one, and I know none (**MISSTATED**; corrected: "the bowtie with a
neighbourhood of `top` forces five colours at `q1` under Y2's action (§4); in the `(1 3)` class it admits no fragment (§6); for asymmetric maps the
four-colour case is open").

### Theorems this phase proved (stage 1)

| id | statement (one line) | grade, minds | address |
|---|---|---|---|
| YB2-CHK | an exact segment-and-arc checker over towers (no adjoined roots; `sgn_km`), self-test, five plants firing as predicted; accepts brick, hexagonal 7-colouring, strip, disk, FS112-BOWTIE | tools | 1b.1–1b.2; `tools/fs114_yb2_exact.py` |
| YB2-BOW | a D2-symmetric non-Siamese valid 20-tile fragment over `ℚ(√3)` realising every condition of FS114-Y2-BOWTIE, holding `B̄(p, 3√3/5)` | tools, exact; mine; two checkers | 1b.4; `bowtie.out`, `second.out` |
| YB2-ARR | in the D2 class (R-T) the arrangement at `q1` is forced: `t1, V(3), T1(4), Z(c̄₁), X(c₁)`, `V ⊂ B̄(q2,1)`, `X ∋ top` | hand; mine | 1b.3, 1c §4 |
| YB2-DE | two tiles of one colour, one with an arc of `ω(top)` from `q1`, the other with an arc of `ω(q1)` from `top`, straddle (`1 − 2tt′`) | hand + exact (plants) | 1b.3 D-e; `bowtie-plant-*.out` |
| YB2-RSTOP | RSTOP with its germ condition explicit; the stop is the cone `(−60°, 60°)` at `r`; Siamese pairs irrelevant | hand + exact; mine | 1c §2 |
| YB2-D2 | D2 under R-T; a GAP at one case without tactic edges | hand; mine | 1c §4 |
| YB2-RPREC | R TRUE; (i)'s open-cone form admits a tangent tile that blocks the ring (exact) | hand + exact; mine | 1c §3 |
| YB2-GAPS | GAPS TRUE | hand over FS112-U1 | 1c §7 |
| YB2-EMPTY13 | the `(1 3)` class holds no non-Siamese fragment with neighbourhoods of `top`, `q1`, `qC` filling `U` (R-T) | hand; mine, one mind | 1c §6 |
| YB2-FOURNS | FOUR's "so five colours are not forced" is a non-sequitur without an example | hand | 1c §5 |

### Would have searched here (stage 1)

- Object 1: I would have varied the cut line, the wedge split and the outer points until a checker accepted; instead the arrangement was derived
  (D-a…D-e), the cut placed by the point-image bound (`⟨x, e60⟩ = 1/2`), the outer points chosen by formula, and one object checked.
- Statement 2: I would have scanned points around `r` for free colours; instead the straddle derivation, then ten named points.
- Statement 6: I would have tried fillings of `U` in the `(1 3)` class; instead the strip-diameter derivation.

## Stage 1c — SAVED
