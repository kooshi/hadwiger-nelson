# FS114-NB6 — blind verification of FS-114's proof side, round 5 (FS114-N6)

*Job FS114-NB6, de Bruijn (Opus 5.5), launched 2026-09-28 11:42 UTC (start-up snapshot HEAD `2bbcb058`). Brief: the template
`data/fs114/briefs/NB114-verify-proof.md` with the instance `data/fs114/briefs/NB6-114-instance.md` (the instance wins) and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-nb6/`; exact checks `tools/fs114_nb6_*.py`; scratch
`scratchpad/fs114-nb6/` (my own subdirectory). Resuming check: no record existed at start. Stage 1 is blind: every verdict is derived from the thirteen
statements in the instance file alone, before `plans/FS114-N6-proof.md` is opened. Notation is the one the instance and its sources fix (FS114-N's,
N3's, N4's and N5's: tiles, `ω(x)`, `P_cl(x)`, `Γ`, close / far, a **tactic edge**, the **ring** `ω(p)`, a **change point**, a tile's **cone**, N-E0,
N-E1, N-E2, N3-FACE, N3-HALF, N3-SEC, N3-FLANK, N3-PAIR, N4-LENS, N5-SIGHT, N5-BENDG, N5-PIN0's frame); `e(φ)` is the unit vector at angle `φ`.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| NB6-QT | Every quotation my brief, instance and standing rules rely on, where its source is open to me, is verbatim: 13 of 13; plant fires | [tools] | §1a.2; `tools/fs114_nb6_quotes.py` |
| NB6-KAPPA | N6-KAPPA: TRUE (N-E0 alone; no non-Siamese, no simple class) | [hand, one mind] | §1b.1 |
| NB6-WIN | N6-WIN: (i) no `Ā`-tile's closure meets the open window, (ii) one `A`-tile, (iv) TRUE; (iii) "reaches `y + 60°`" TRUE when `κ` is defined just before it, a GAP when a (Q) arc ends there (the strip's `P_1` shows the reach is not automatic at a (Q) end) | [hand, one mind] | §1b.2 |
| NB6-RING60 | N6-RING60: TRUE after the bends (the statement omits the clause; needed) | [hand, one mind] | §1b.3 |
| **NB6-P60** | In a pinwheel with `α_{j+1} = 60°`, `q_j` a change point and `κ` defined just before `q_j − 60°`: `t_{j+2}` reaches `q_j`, lies in `Reul(p, q_j, q_{j+1})`, alone borders the side from `p` to `q_j`, and `α_{j+2} < 120°` — the kill is the cone `(240°, 300°)` at `q_j`, which no colour can hold unless `t_{j+2}` does | [hand, one mind; tools exact at named points] | §1b.4; `tools/fs114_nb6_check.py` |
| NB6-ADJ | N6-ADJ: TRUE | [hand, one mind] | §1b.4 |
| **NB6-NOQ** | N6-NOQ: TRUE at `1 + ε`, by N6-RING60, N3-FLANK and NB6-P60 (N6-PIN180 not needed) | [hand, one mind] | §1b.5 |
| NB6-QOUT | N6-QOUT: TRUE; with `α_{j+1} = 60°` no (Q) arc ends at `q_j − 60°` from below | [hand, one mind; tools at named cones] | §1c.1 |
| NB6-P60P | N6-P60′: TRUE (over NB6-P60, NB6-QOUT); the side is all of `e_{j+1}` | [hand, one mind] | §1c.2 |
| NB6-QE1, -PIN180 | N6-QE1, N6-PIN180: TRUE | [hand, one mind; tools] | §1c.4, 1c.5 |
| NB6-CENT | N6-CENT: TRUE with its last clause read as `0° < γ < 60°` (literally it also covers `γ = 0°`, which its previous clause allows) | [hand, one mind] | §1c.6 |
| NB6-COV | N6-COV: first clause GAP as stated — the windows alone let the ring tiles hold the cone about the direction of `p`; TRUE with `κ` defined just beyond both windows; second clause TRUE in the pinwheel | [hand, one mind] | §1c.7 |
| NB6-PIN | N6-PIN: TRUE as a status | [hand, one mind] | §1c.8 |
| **NB6-MTP** | N6-MTP: the stationary hull member, its unimodular Palm version and hyperfiniteness TRUE (printed: `[AldousLyons2007]` Ex. 9.5, Thm 8.5; a nested random grid); "so of average curvature zero" **GAP** as stated — a hole-free map's hull can hold maps with annular faces or collapsed tiles, outside `[AngelHutchcroftNachmiasRay2018]` Thm 1's maps; it needs GAP-μ in the hull | [hand, one mind; over the printed theorems read] | §1d.2 |
| **NB6-FOLNER** | For a valid map of bounded complexity whose tiles are open discs (pinch points allowed), route T's aperiodic averaging step closes by Euler's formula on large discs (boundary `O(R)`, a local surplus `≥ cR²`): no hull, no unimodularity needed | [hand, one mind] | §1d.2 |
| NB6-QT2 | The instance's thirteen statements are verbatim in N6's record (13 of 13); the instance's gloss of "(Q) arc" widens FS-112's term (it would count (R2) arcs) | [tools] | §2.2; `quotes-n6.out` |
| **NB6-COVFIX** | N6-COV as stated is MISSTATED: its proof needs `κ` defined just beyond both windows (N6's own RCONE line uses an `X`-tile at `q − 60°`); corrected, TRUE | [hand; two minds, one blind] | §1c.7, §2.3 row 6 |
| **NB6-WINFIX** | N6-WIN's table sentence is MISSTATED (the reach of `y + 60°` is unconditional there, conditional in N6's §2.2 and in my derivation); §2.2's form TRUE | [hand; two minds, one blind] | §1b.2, §2.3 row 1 |
| **NB6-QSTART** | N6's §2.3 consequence "(Q) arcs never start at a centre from the counter-clockwise side" rests on the withdrawn N6-P60 step; after N6-P60′ a (Q) arc of `T_{j+2}` from `q_j` (outer tile `z_j`) is admitted by N6-QOUT's zone when `α_{j+1} = 60°`, `α_{j+2} ≤ 120°`: GAP | [hand, one mind] | §2.3 row 8 |
| NB6-MTP2 | N6-MTP's route: GAP (hull limits of simple hole-free maps can be non-simple); its conclusion TRUE by N2-AVG, which NB6-FOLNER re-derived blind | [hand; two minds, one blind for the conclusion] | §2.3 rows 9–10 |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| enumerate ring patterns (change points, (Q)/(R2) pieces) of a four-colour vertex | N6-KAPPA's straddle and CL-ring by hand (§1b.1–1b.3) |
| scan the cone patterns `(α_1, …, α_4)` of a pinwheel for survivors | reduced to multiples of 60° by N6-RING60 and killed each 60°→larger step by one lemma (§1b.4–1b.5) |
| build a fragment by formula with a (Q) arc ending 60° after a change point, to decide N6-WIN (iii) | read the strip's `P_1` (a held rebuild) as a near-instance; the sub-case left a GAP (§1b.2) |
| construct a map whose hull holds an annular face, to test N6-MTP's step 4 | described one by formula in words (C-shaped tiles, channel width `1/n` on the dyadic annuli) and argued the limit; not built (§1d.2) |

## Fence log (standing rule 13; template and instance § Fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): milestone status lines, no proof content. The start-up git status printed the untracked
   **names** `data/fs111/fs111-w/*` (FS-111's, fenced) and my instance file, and five commit subjects (`FS111-M3: stage 1`, `FS114-N6: report`,
   `FS114-N6: stage 5`, `FS114-N6: stage 4`, `FS-114 inventory`). Names and subjects only.
2. At start-up, `ls data/fs114/briefs/ plans/ | grep -i fs114; ls data/fs114/` (sizing the reading) printed the **names** of every `plans/FS114*` file —
   the construction side's `FS114-Y*-construction.md` and `FS114-YB*-verification.md`, `FS114-CV-verification.md`, `FS114-CVB-verification.md`,
   `FS114-close-inventory.md` and `FS114-N6-proof.md` (fenced until my stage 1) among them — and the working-directory names under `data/fs114/`
   (`fs114-n6`, `fs114-y*`, `fs114-yb*`, `fs114-cv*`, `reports`). None opened.
3. `ls` of my own record, working directory, tools and report path (the resuming check) touched only paths that are mine.
4. `grep -n '^#' plans/FS114-unit-arc-question.md` printed the **heading line** of stage 5.3 (the registered expectations, fenced until my stage 1 is
   committed). Heading only; the section not read.

## Stage 1a — SAVED: reading and the quotation check

### 1a.1 Read from disk (G50)

- `data/fs114/briefs/NB114-verify-proof.md`, `NB6-114-instance.md`, `STANDING-RULES.md` in full; `CLAUDE.md` § The aim, § Counter-priors, G83, G82,
  G79, G71, G60, G21, G15, G13, G51 (loaded in context).
- `LEDGER.md` rows 131–136 in full.
- `data/fs114/claims.md` in full; `data/fs114/briefs/ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` in full.
- `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ, stage 5b (not 5.3).
- `data/fs114/briefs/N114-proof.md` in full (its § Reading, as the template directs).
- `plans/FS114-N5-proof.md` in full; `plans/FS114-NB5-verification.md` in full (N5-PIN0, N5-SIGHT, N5-BENDG open to me by the instance).
- `plans/FS114-N3-proof.md` header, theorem table and stage 2 (N3-FACE, N3-HALF, N3-SEC, N3-FLANK, N3-PAIR, N3-ODD, N3-DR); `plans/FS114-N4-proof.md`
  header and theorem table (N4-LENS, N4-OWN, N4-OPP, N4-TANG, N4-L60); `plans/FS110-N-proof.md` §1.4 (N-E0, N-E1, N-E2).
- `plans/FS112-derivation.md` header, FS112-U1, FS112-L60, FS112-LOCK, FS112-BEND; `plans/FS114-L60-audit.md` header, theorem table, logs, §3.4.
- `plans/FS107-derivation.md` header (for `𝓜_K`) and W-EQ-K's statement line. The N6-MTP reading (Aldous–Lyons; Angel–Hutchcroft–Nachmias–Ray) is
  stage 1d's.

### 1a.2 The quotation check (standing rule 5)

`tools/fs114_nb6_quotes.py data/fs114/fs114-nb6/quotes.tsv` (copied from `tools/fs114_nb5_quotes.py`, not edited; whitespace collapsed, `**` removed,
nothing else normalised) checks 13 quotations: Kooshi's five in the standing rules; the instance's "at most 60°" against the L60 audit; N5-PIN0's frame
"centres `q_j = p + e(θ_j + 90°)`" against N5's record; the (Q), (R2) definitions against `plans/FS112-derivation.md`; `𝓜_K` against
`plans/FS107-derivation.md`; C114-FIVE-COUNT against the Google-group thread; the round-4 card's K1-PIN clause; L60-LE. **13 of 13 FOUND**
(`data/fs114/fs114-nb6/quotes.out`, exit 0). **Plant** (`--plant`: one word of the first quotation altered): the altered copy NOT FOUND, its faithful twin
FOUND (`quotes-plant.out`, exit 0). By hand: the instance's description of the pinwheel ("each tile at `p` inner for one edge") is faithful to the round-4
card's "(each tile inner for one edge)" and to N3-SEC's `++++`. **Not checkable at stage 1:** the thirteen statements of the instance are FS114-N6's,
copied by a script from its record, which is fenced until this stage is committed; they are checked at stage 2.

## Stage 1a — SAVED

## Stage 1b — SAVED: blind derivations, part 1 (the priority claims N6-KAPPA, N6-WIN, N6-RING60, N6-NOQ, and the pinwheel lemma)

*Derived from the instance's statements alone; `plans/FS114-N6-proof.md` not opened. "One mind" is mine. Metric facts: `tools/fs114_nb6_check.py`
(`data/fs114/fs114-nb6/check.out`, 38 of 38 OK, exact in `ℚ(√2, √3)`); plant `--plant` sets `α_{j+1} = 75°` and fails exactly the five unit-gap identities
(`|q_j − q_{j+1}| = 1`, `q_{j+1} − q_j = e(210°)`, the side's tangent at `q_j`, `|q_j − q_{j+2}|² ≥ 3` at `α_{j+2} = 180°`, the two points of `ω(w₀) ∩ ω(q_{j+1})`),
no other line (`check-plant.out`).*

### 1b.0 Setting and the tools I use

- **Class.** Non-Siamese valid maps: distinct tiles of one colour are far (all cross distances `> 1`, N-E2), a tile's closure has diameter `≤ 1`; the
  simple class where N3's lemmas need it (a tile's cone at a vertex is one closed interval; no tile touches itself). A **four-colour vertex** here carries
  exactly four colours (two absent colours `A`, `Ā`, so that `κ̄` means something); non-Siamese, it has degree 4.
- **CL (closeness).** Two tiles of one colour with points less than 1 apart are one tile. Two uses: (CL-p) a tile of a colour of `P_cl(p)` with a point in
  `B(p, 1)` is `p`'s own tile of that colour; (CL-ring) two contacts of one colour with the ring (tiles whose closures meet ring points `e(ψ)`, `e(ψ′)`) with
  `|ψ − ψ′| < 60°` belong to one tile (their points near `e(ψ)`, `e(ψ′)` are less than 1 apart).
- **`κ` and the bends.** After the bends every `Γ`-arc of the ring is (Q) or (R2) (N5-BENDG, two minds, one blind: N5; NB5). `κ(θ)` is the colour of `e(θ)`
  when it is interior to a tile, the inner colour when `e(θ)` is in the relative interior of an (R2) piece, undefined otherwise; by N-E1 at `p`, `κ ∈ {A, Ā}`.
  Off (Q) pieces `κ` is undefined at finitely many points only (local finiteness). **Bends on a fragment:** run on a fragment on a neighbourhood of
  `B̄(p, 1 + ε)`, N2-AWAY sees no radius-2 witness, so every ring arc but the (Q) arcs is removed (NB5 §1b.3's radius note); "after the bends" then costs no
  radius, and the ring of a fragment bent so is `Γ`-arc-free off its (Q) arcs.
- **Two readings of "(Q)".** N6's statements use FS-112's (Q) (an arc whose centre carries both side colours — N6-QOUT's "inner `T_{j+1}`" is a `p`-tile).
  The instance's gloss, "a boundary arc along `ω(p)` whose outer colour is carried at `p`", also counts (R2) arcs (a paraphrase that widens the term;
  standing rule 5, to be compared with N6's own definition at stage 2). Every verdict below holds under both readings; where one matters I say so.

### 1b.1 N6-KAPPA — TRUE [hand, one mind]

*Derivation.* Both values lie in `{A, Ā}`, so the claim is `κ(θ + 60°) ≠ κ(θ)`; suppose both equal `c`. `|e(θ) − e(θ + 60°)| = 1` (tools).
(a) Both points interior to `c`-tiles: N-E0. (b) `e(θ)` interior to `T`, `e(θ + 60°)` in an (R2) piece with inner `T′` (both colour `c`): `T′` holds
`x_s = (1 − s)e(θ + 60°)` for small `s`, and `|e(θ) − x_s|² = 1 − s + s² < 1`, while a ball `B(e(θ), δ) ⊂ T` with `δ > s` holds points farther than 1 from `x_s`:
a point of `T` at distance exactly 1 from `x_s` — N-E0. (c) Both in (R2) pieces with inner tiles `T, T′`: the points `(1 − s)e(θ)`, `(1 − s)e(θ + 60° + η)` have
squared distance `1 − s + s² + √3η(1 − s)² + O(η²)`, which takes both signs as `η` ranges over a small interval (both points stay in the relative interiors):
N-E0 (tools, `η = ±1/20`, `s = 1/1000`). ∎ It uses only N-E0: no non-Siamese hypothesis, no simple class. *Reads:* `B̄(p, 1 + ε)`.

### 1b.2 N6-WIN — (i), (ii), (iv) TRUE; (iii) TRUE when `κ` is defined just before `y + 60°`, a GAP in my derivation when a (Q) arc ends there [hand, one mind]

*Derivation.* `y = e(φ)`, `κ = Ā` on `(φ − δ, φ)` (carried by `V0`), `A` on `(φ, φ + δ)` (carried by `U`); `κ` defined on `(φ + 60°, φ + 60° + δ)`. By N6-KAPPA
`κ = Ā` there (carried by `V1`), and `κ = A` on `(φ + 60° − δ, φ + 60°)` wherever defined.
- **(i) No `Ā` in the window, in the strong sense: no `Ā`-tile's closure meets the open window.** Such a tile `V`, meeting `e(ψ)`, `φ < ψ < φ + 60°`, has points
  less than 1 from `V0`'s points near `e(φ − η)` (angle `ψ − φ + η < 60°`) and from `V1`'s near `e(φ + 60° + η)`: by CL, `V = V0 = V1`, a tile holding points near
  `e(φ − η)` and `e(φ + 60° + η)`, more than 1 apart (tools: chords of 58° and 62°). Diameter.
- **(ii) One `A`-tile.** Any two `A`-contacts in the open window are less than 60° apart: CL-ring. It is `U`.
- **(iv) and (iii) when `κ` is defined just before `y + 60°`.** Then `κ = A` there, carried by `U` (by (ii)), so `e(φ + 60°) ∈ cl U`, and `y + 60°` is an `(A | Ā)` change
  point. ✓
- **(iii) when a (Q) arc ends at `y + 60°` from below.** Then `U`'s ring contacts stop at the (Q) arc's start `e(φ + β)`, `β < 60°`; its inner tile is `p`'s own
  tile `t_i` (CL-p), with `p, e(φ + β), e(φ + 60°)` in its closure. `U` can reach `e(φ + 60°)` only around the outer tile `O` (not through `t_i`: `t_i` joins `p` to
  the arc, and a detour round `p` needs diameter near 2). Nothing I hold forces it (N-E1 at `y`, `y + 60°` and N3-FACE at the pair `(y, y + 60°)` leave `U`'s reach
  free). **Near-instance:** the strip's midline vertex `P_1` (row 136; `plans/FS112-Y-construction.md` §1.3: ring `3 | Γ | 6 | Γ | 3 | 6 | Γ | 3 | Γ | 6`, (Q) arcs
  `[60°, arccos ¼]`, `[180° − arccos ¼, 120°]` and mirrors) has the stretch `(arccos ¼, 180° − arccos ¼)` of colour 6 (the tile `C_1`, `x ∈ [¼, ¾]`) closed by a (Q) arc
  ending at `120°` with colour 3 beyond, and `C_1` does not reach `e(120°) = (0, √3/2)`. Its stretch starts at a (Q) end, not at a change point, so it is not a
  counterexample; it shows only that the reach is not automatic at a (Q) end. **The sub-case is outside every use below** (N6-RING60, N6-NOQ and the lemma read
  `κ` defined on both sides of `y + 60°`). *Reads:* `B̄(p, 1 + ε)`. **Mirror:** the same with the roles of the two sides exchanged.

### 1b.3 N6-RING60 — TRUE after the bends [hand, one mind]

*Derivation.* With no (Q) arc, `κ` is defined off finitely many points; by N6-KAPPA it is not constant, so a change point `y` exists, say `(Ā | A)`. N6-WIN at `y`
(its hypothesis holds: `κ` is defined just beyond `y + 60°`) gives the window `(y, y + 60°)` all `A` off finitely many points, one tile `U`, `cl U ⊇` the closed arc
(the contacts are dense in it), and `y + 60°` an `(A | Ā)` change point; the mirror of N6-WIN at `y + 60°` gives the next window, and so on six times round. No
other change point exists (each open window is one colour). The six tiles are distinct: tiles of windows two apart would hold `e(y + 60°k)` and
`e(y + 60°(k + 3))`, antipodal. ∎ *Reads:* `B̄(p, 1 + ε)`. **Scope:** the statement omits "after the bends", which N6-KAPPA and N6-NOQ carry. It is needed: before
the bends a ring arc with inner colour at `p` and outer colour absent (removed by N2-TOWARD) makes `κ` undefined on an interval across which the colour can change
without a change point, and "change points exactly `y + 60°ℤ`" is then not even well posed. *(An arc with both sides absent cannot sit on a (Q)-free ring: the
straddle of 1b.1 (c), run across the arc and its 60° rotations, forces arcs with both sides at `p` at `±60°`.)* Wording, if N6's text carries the context.

### 1b.4 NB6-P60 — the pinwheel lemma [hand, one mind; tools exact at named points]

*Frame (N5-PIN0's, `θ_j = 0`):* `p = 0`; `t_j` has cone `[θ_{j−1}, θ_j]` of width `α_j`; `e_j` leaves `p` at `θ_j`, on `ω(q_j)`, `q_j = e(θ_j + 90°) = e(φ_j)`, inner
`t_{j+1}`, outer `t_j`, partner `z_j` (colour `c_j`) at `q_j`. So `q_j = e(90°)`; with `α_{j+1} = 60°`, `q_{j+1} = e(150°)`, and `w₀ = e(30°)` is the ring point `q_j − 60°`.

**Statement.** *In a pinwheel (non-Siamese, simple), if `α_{j+1} = 60°`, `q_j` is a change point and `κ` is defined just before `w₀ = q_j − 60°`, then `t_{j+2}` reaches
`q_j`, lies in `Reul(p, q_j, q_{j+1})`, is the only tile bordering the side of that Reuleaux triangle from `p` to `q_j` from inside, and `α_{j+2} < 120°`.*
1. **Ring tiles at `q_j`.** `κ = Ā` just before `q_j` (tile `U′`), `A` just after (tile `U`); by N6-KAPPA `κ = A` just before `w₀` (tile `U3`, `w₀ ∈ cl U3`). `U ≠ U3` (a
   tile holding `q_j` and points just before `e(30°)` has diameter above 1). `|q_j − w₀| = 1`, so by N-E2 **`U ∩ B(w₀, 1) = ∅`**: `U`'s cone at `q_j` lies in `[60°, 240°]`
   (tools: `w₀ − q_j = e(−30°)`; directions 255°, 270°, 285° face `w₀`).
2. **`t_{j+1}` at `q_j`.** `t_{j+1} ⊂ B̄(p, 1)` and `t_{j+1} ∩ B(q_{j+1}, 1) = ∅` (far from `z_{j+1}`; `t_{j+1} ∌ q_{j+1}`, else it would lie in `ω(q_{j+1})`), with
   `q_{j+1} − q_j = e(210°)`: its cone at `q_j` lies in `[300°, 360°]`.
3. **The cone `(240°, 300°)` at `q_j`** points into `B(p, 1)` (tools). Which tiles can hold it: colour `A` only `U` (CL), excluded by 1; `Ā` only `U′`, excluded because
   `U′`'s cone contains the ring's clockwise branch at `0°` and would have to pass `t_{j+1}`'s cone or `U`'s; `c_{j+1}` only `t_{j+1}` (CL-p), excluded by 2; `c_j` only
   `t_j` (CL-p), which misses `B(q_j, 1)` (far from `z_j`), or `z_j`, whose cone faces away from `p` (N3-HALF (c)); so **only `t_{j+2}` or `t_{j+3}`**.
4. **`t_{j+3}` never reaches `q_j`:** it is inner to `e_{j+2}`, so `q_{j+2} ∈ cl t_{j+3}`, and `|q_j − q_{j+2}| = 2 sin((60° + α_{j+2})/2) ≥ √3` (tools at 60°, 120°, 180°).
   So **`t_{j+2}` reaches `q_j`**, with cone `⊇ [240°, 300°]` there; `t_{j+2} ∋ p, q_j, q_{j+1}` gives `t_{j+2} ⊂ Reul(p, q_j, q_{j+1})` (diameter).
5. **`α_{j+2} < 120°`** (this is NB6-ADJ below): the Reuleaux corner at `p` is `[θ_j + 60°, θ_j + 180°]`, so `α_{j+2} ≤ 120°`; at `α_{j+2} = 120°` the branch of `ω(q_j)`
   leaving `p` along `θ_j + 180°` bends toward `q_j` into `t_{j+2}`'s interior (tools: its point `q_j + e(255°)` has direction in `(120°, 180°)` from `p`), so by N-E1 at `q_j`
   (N4-OPP) `c_{j+2} ∉ P_cl(q_j)` — against 4.
6. **The side from `p` to `q_j`** (the arc of `ω(q_{j+1})`) lies in `B(w₀, 1)` off its ends (`ω(w₀) ∩ ω(q_{j+1}) = {p, q_j}`, midpoint inside: tools), so `U` does not
   touch it; it lies outside `B̄(q_{j+2}, 1)` off `p` (midpoint test at `α_{j+2} = 60°, 120°`), so `t_{j+3}` does not; `U′` never enters the Reuleaux triangle (from its
   ring window it would have to cross `t_{j+1}`, `U`, or leave `B̄(q_j, 1)`). By CL the triangle's interior holds only `t_{j+2}`, `t_{j+3}`, `U`: **`t_{j+2}` borders the whole
   open side.** ∎ *Reads:* `B̄(p, 1 + ε)` — the points `p, q_j, q_{j+1}, q_{j+2}, w₀` and the triangle.

**NB6-ADJ** *(N6-ADJ, derived here because the lemma uses it):* if `t_{j+2}` reaches `q_j`, then `t_{j+2} ∋ q_j, q_{j+1}` gives `|q_j − q_{j+1}| ≤ 1`, so `α_{j+1} ≤ 60°`, hence
`= 60°` (N3-SEC (ii)); its cone at `p` lies in `{v · q_j ≥ 0}`, so `α_{j+2} ≤ 120°`; and step 5 excludes 120°. ∎

### 1b.5 N6-NOQ — TRUE at radius `1 + ε` [hand, one mind; a route that needs neither N6-PIN180 nor N6-P60′'s hypothesis]

*Derivation.* Run the bends on the fragment (1b.0): the ring is `Γ`-arc-free off finitely many points. `p` is a four-colour vertex, so N6-RING60 puts the change
points at `y + 60°ℤ`. Each centre `q_j` is a change point: N3-FLANK (simple class; both branches of the ring at `q_j` lie in tiles, of the two absent colours). So
every `α_j` is a multiple of 60°, and `α_j ∈ [60°, 180°]` (N3-SEC; N5-PIN0's clause, two minds) leaves `{60°, 120°, 180°}` with sum 360°: the patterns
`(60, 60, 60, 180)` and `(60, 60, 120, 120)`, `(60, 120, 60, 120)` up to rotation. Each has a 60° cone followed by a larger one, which NB6-P60 forbids (its hypotheses
hold: `q_j` is a change point, `κ` is defined everywhere off finitely many points). **No pinwheel has a (Q)-free ring.** ∎ *Reads:* `B̄(p, 1 + ε)` (a Γ-free ring needs no
bend; otherwise the bends on the fragment). Under the instance's wider gloss of (Q) the hypothesis is only stronger. **Where six is spent:** the two absent colours
alternate (N-E0 with exactly two colours for the ring) and the cone `(240°, 300°)` at `q_j` finds no colour among six (NB6-P60 step 3); with a seventh colour both
steps are silent, as the hexagonal seven-colouring requires. **The controls:** the strip's and the disk's four-colour vertices carry no tactic edges (their arcs
are centred at them), so no pinwheel lives there and no step is refuted by them. **G21 audit** — this is the verdict that flatters the NO most; a second mind
should check first NB6-P60's step 1 (`U3` exists and `U ∩ B(w₀, 1) = ∅`) and step 3 (the colour exhaustion of the cone `(240°, 300°)`).

## Stage 1b — SAVED

## Stage 1c — SAVED: blind derivations, part 2 (N6-P60′, N6-QOUT, N6-QE1, N6-PIN180, N6-CENT, N6-COV, N6-PIN); the stage-1 table

*Frame and tools as in §1b; tools lines QOUT and QE1 added (`check.out`, 45 of 45 OK; the plant unchanged, 5 unit-gap lines fail, no other).*

### 1c.1 N6-QOUT — TRUE [hand, one mind; tools at named cones]

*Derivation.* A (Q) arc `[a, b]` of the ring has inner colour at `p`, so its inner tile is a `p`-tile (CL-p); call it `T_{j+1}` (the index is the arc's).
Its closure holds the arc, `p` and `q_j`, so `T_{j+1} ⊂ B̄(e(θ), 1)` for every arc point: (1) `|e(θ) − q_j| ≤ 1`, so `θ ≥ φ_j − 60°`; (2) its cone
`[θ_j, θ_j + α_{j+1}]` lies in every `{v · e(θ) ≥ 0}`: `b ≤ φ_j` and `a ≥ φ_j − 180° + α_{j+1}`. **Outer colour** `o ∈ P_cl(p) ∖ {c_{j+1}}`; `p`'s `o`-tile is far from the
outer tile, whose closure holds the arc, so its cone lies in `[b + 90°, a + 270°]` (U1's outer half): `c_j` fails (`t_j`'s cone ends at `θ_j = φ_j + 270°`, beyond
`a + 270°` since `a < φ_j`); `c_{j+2}` fails (`t_{j+2}`'s cone starts at `θ_{j+1}`, which would need `b ≤ φ_j − 180° + α_{j+1} ≤ a`); so **`o = c_{j+3}`**, and `t_{j+3}`'s
cone start `θ_{j+2} ≥ b + 90°` gives (3) `b ≤ φ_j + α_{j+1} + α_{j+2} − 180°`. (1)–(3) are the stated zone
`[φ_j − min(60°, 180° − α_{j+1}), φ_j + min(0, α_{j+1} + α_{j+2} − 180°)]`. ∎ *Reads:* `B̄(p, 1 + ε)`. **Consequence used below:** with `α_{j+1} = α_{j+2} = 60°` the zone
is a point (no (Q) arc has inner `T_{j+1}`), and **no (Q) arc ends at `q_j − 60°` from below when `α_{j+1} = 60°`** (checked against the zones of `T_j`, `T_{j−1}`,
`T_{j+1}`, `T_{j+2}`: each lies wholly above or below `q_j − 60°`).

### 1c.2 N6-P60′ — TRUE [hand, one mind; over NB6-P60 and NB6-QOUT]

*Derivation.* `κ` defined on both windows beside `q_j` makes `q_j` a change point: were the two branches one colour, CL would give one tile holding both, whose cone
(one interval, containing both tangents of the ring at `q_j`) would contain `t_{j+1}`'s cone or `z_j`'s — N3-FLANK's argument, with "holding a branch" read to include
being the inner tile of an (R2) piece along it. `κ` is defined just before `q_j − 60°` by 1c.1's consequence. NB6-P60 then gives the four clauses: `T_{j+2}`
reaches `q_j`, lies in `Reul(p, q_j, q_{j+1})`, borders the whole open side from inside, and `α_{j+1} + α_{j+2} < 180°`. **The side is all of `e_{j+1}`:** outside it,
the region `Λ = B̄(p, 1) ∩ B̄(q_j, 1) ∖ B(q_{j+1}, 1)` holds only `t_{j+1}` and the `Ā`-tile `U′` (an `A`-tile there would be close to both `U` (via `q_j`) and `U3` (via `w₀`),
two distinct tiles; `c_j`, `c_{j+2}`, `c_{j+3}` excluded by CL-p and the far-from-partner discs); `t_{j+1}` borders the side at both ends, so `U′`, which holds the ring
near `q_j`, cannot reach the side's middle without crossing `t_{j+1}` or the side. ∎ *Reads:* `B̄(p, 1 + ε)`.

### 1c.3 N6-ADJ — TRUE [hand, one mind] (NB6-ADJ, §1b.4). *Reads:* `p, q_j, q_{j+1}`.

### 1c.4 N6-QE1 — TRUE [hand, one mind]

*Derivation.* By 1c.1 at index `j + 1`, a (Q) arc with inner `T_{j+2}` has outer colour `c_{j+4} = c_j` (the parenthesis is right). `u = e(φ_j + 60°)` is on `ω(q_j)`,
which crosses the ring at `u` at 60° (tools); if `u` is interior to such an arc, `ω(q_j)` enters its outer tile (colour `c_j`) near `u`, and `q_j` carries `c_j` by `z_j`:
N-E1 at `q_j`. ∎ The hypothesis `α_{j+1} ∈ (60°, 120°)` is not used by the exclusion; it is where `T_{j+2}`'s zone can hold `u` in its interior. At `α ≡ 90°` that zone
is `[φ_j + 30°, φ_j + 90°]` (tools), so a full-zone (Q) arc of `T_{j+2}` holds `u` and dies. ✓ *Reads:* `B̄(p, 1 + ε)`.

### 1c.5 N6-PIN180 — TRUE [hand, one mind; tools]

*Derivation.* `60° ≤ α_{j+1}` is N3-SEC (ii). If `α_{j+1} = 180°`, `e_{j+1}` leaves `p` at `θ_j + 180°` on `ω(q_{j+1})`, `q_{j+1} = e(θ_j + 270°)`, curving to directions
`θ_j + 180° + r/2` at radius `r`; `T_{j+1}` lies between `e_j` and `e_{j+1}`, so it holds points beside `e_{j+1}` at directions in `(θ_j + 180°, θ_j + 180° + r/2)`, which are
outside `B̄(q_j, 1)` (tools at 181°, 185°): against `T_{j+1} ⊂ B̄(q_j, 1)` (inner to `e_j`). ∎ *Reads:* `B̄(p, ε)`. (N6-NOQ does not need it: §1b.5.)

### 1c.6 N6-CENT — TRUE, the last clause read as `0° < γ < 60°` [hand, one mind]

*Derivation.* Degree 4, non-Siamese: four colours. After the bends on the fragment the ring is `Γ`-arc-free off its (Q) arcs, so with none, N6-RING60 applies; every
tactic centre is a change point (N3-FLANK); so all centres lie in `y + 60°ℤ`. A tactic edge leaves `p` at 90° from its centre's direction, on the inner tile's side
(N3-HALF (a)), so every tactic edge's direction lies in `y + 30° + 60°ℤ`, and the angle between any two is a multiple of 60°. A lens has `γ ≤ 60°` (N3-SEC (iii)), so
`γ ∈ {0°, 60°}`; at 60° its closure holds `p` and both centres, and it lies in their Reuleaux triangle. ∎ *Reads:* `B̄(p, 1 + ε)`. **Wording:** "non-Reuleaux lenses need
a (Q) arc", read literally, covers `γ = 0°` too, which the statement's own previous clause allows on a (Q)-free ring; I find no argument excluding a `γ = 0°` lens (a tile
inner to both branches of one `ω(q)` at `p`, cone 180°) at this radius. Read as "lenses with `0° < γ < 60°` need a (Q) arc", TRUE.

### 1c.7 N6-COV — first clause GAP as stated (TRUE with κ defined just beyond both windows); second clause TRUE in the pinwheel [hand, one mind]

*Derivation.* At a change point `q` (frame `q = e(90°)`, ring tile `U` of colour `A` counter-clockwise, `U′` of `Ā` clockwise) with `κ` defined on both windows, the windows
are one colour each (a change `z` inside one would put a change point at `z ∓ 60°` in the other window, and N6-WIN there would forbid `κ = Ā` just before `q`), so
`U ⊂ B̄(q + 60°, 1)` and `U′ ⊂ B̄(q − 60°, 1)`: their cones at `q` lie in `[120°, 300°]` and `[240°, 60°]`. **Both admit directions of the cone `(240°, 300°)` about the direction
of `p`**, so "the directions toward `p` are covered only by `p`'s own tiles" does not follow from the windows alone. It follows when `κ` is also defined just beyond both
windows: then an `A`-tile holds `q − 60°` and an `Ā`-tile holds `q + 60°`, N-E2 puts `U`'s cone in `[60°, 240°]` and `U′`'s in `[300°, 120°]`, and by CL and CL-p the cone
`(240°, 300°)` is held only by `p`-tiles reaching `q`. In the pinwheel at a centre with `α_{j+1} = 60°`, 1c.1 supplies the clockwise half (no (Q) arc ends at `q_j − 60°`),
and NB6-P60 needs no more. **Second clause** ("a unit gap between consecutive centres of one tile pushes that tile aside and forces a neighbour into a Reuleaux triangle on
`p`"): NB6-P60 steps 2 and 4 (`t_{j+1}`'s cone at `q_j` in `[300°, 360°]`; `t_{j+2} ⊂ Reul(p, q_j, q_{j+1})`), TRUE in the pinwheel under NB6-P60's hypotheses. *Reads:*
`B̄(p, 1 + ε)`.

### 1c.8 N6-PIN — TRUE as a status [hand, one mind]

A pinwheel with a (Q)-free ring is excluded at `1 + ε` (N6-NOQ, §1b.5); every (Q) arc on a pinwheel's ring is of N6-QOUT's kind (1c.1), so "unless its ring carries (Q)
arcs of N6-QOUT's kind" is "unless its ring carries (Q) arcs", and there it is a GAP (I derive no exclusion there either; N6-QE1 removes only (Q) arcs holding
`e(φ_j + 60°)` inside). *Reads:* `B̄(p, 1 + ε)`.

### 1c.9 The stage-1 table (radii read; the controls; six)

| claim | verdict (stage 1) | radius it reads (derived) |
|---|---|---|
| N6-KAPPA | TRUE (N-E0 alone) | `1 + ε` |
| N6-WIN | (i), (ii), (iv) TRUE; (iii) TRUE when `κ` is defined just before `y + 60°`, GAP at a (Q) end there | `1 + ε` |
| N6-RING60 | TRUE after the bends (clause omitted in the statement) | `1 + ε` |
| N6-NOQ | TRUE (my route: RING60, FLANK, NB6-P60) | `1 + ε` (bends on the fragment) |
| N6-PIN | TRUE as a status | `1 + ε` |
| N6-P60′ | TRUE (over NB6-P60 and N6-QOUT's zones) | `1 + ε` |
| N6-ADJ | TRUE | `p, q_j, q_{j+1}` |
| N6-QOUT | TRUE | `1 + ε` |
| N6-QE1 | TRUE (its interval hypothesis locates the point; the exclusion needs none) | `1 + ε` |
| N6-PIN180 | TRUE | `ε` |
| N6-CENT | TRUE, the last clause read as `0° < γ < 60°` | `1 + ε` |
| N6-COV | first clause GAP as stated (TRUE with `κ` defined just beyond both windows); second clause TRUE in the pinwheel | `1 + ε` |
| N6-MTP | stage 1d | — |

**The local controls (template item 3).** No step above reads beyond `1 + ε` about `p` (the bends are run on the fragment). The strip (radius `≈ 1.834` about a midline
four-colour vertex) and the disk refute none of them: their four-colour vertices carry no tactic edges (every unit arc is centred at them), so the pinwheel and centre
statements fail there at their hypotheses; N6-KAPPA and N6-WIN hold on the strip's `P_1` (its ring checked by hand against FS112-Y §1.3's arcs: 3 on `(0°, 60°)`, 6 on
`(arccos ¼, 180° − arccos ¼)`, 3 on `(120°, 180°)`, 6 on `(180°, 240°)`, …, alternating wherever defined 60° apart), and N6-RING60's hypothesis fails there (four (Q) arcs).
**Six** is spent at N6-KAPPA's alternation (exactly two absent colours), at the colour exhaustion of the cone `(240°, 300°)` (NB6-P60), at N6-QOUT's outer-colour exhaustion
and at N-E1 in N6-QE1; the hexagonal seven-colouring has three absent colours at every vertex and no step closes. **C114-FIVE-COUNT:** not applicable to these claims (none
counts); it is run through N6-MTP at stage 1d.

## Stage 1c — SAVED

## Stage 1d — SAVED: N6-MTP, the separate question (reading and verdict)

### 1d.1 Read (G50), section by section

- **`[AngelHutchcroftNachmiasRay2018]`** (O. Angel, T. Hutchcroft, A. Nachmias, G. Ray, *Hyperbolic and parabolic unimodular random maps*, arXiv:1612.08693v2,
  held `~/source/library/pdf/arXiv-1612.08693-…pdf`; journal data not checked here): **read** — abstract, §1 (Theorem 1, the Dichotomy Theorem, statement), §2.1
  (maps: a connected locally finite graph, every face an open disc, faces counted with multiplicity at a vertex), §2.2 (unimodularity, the MTP), §3.2–3.3 (invariant
  Cheeger constant; Theorem 3.4 with its proof), Example 4.11 (Euclidean Delaunay and Voronoi maps are parabolic). **Not read:** §§4–7 otherwise.
- **`[AldousLyons2007]`** (D. Aldous, R. Lyons, *Processes on unimodular random networks*, Electron. J. Probab. 12, Paper 54 (2007), 1454–1508; arXiv:math/0603062v6,
  held): **read** — Theorem 8.5 (amenability criteria, statement), Example 9.5 (tilings; the Palm measure of an isometry-invariant embedded graph is unimodular, with the
  proof's first half). **Not read:** the rest.
- Neither is in `BIBLIOGRAPHY.md` (grepped by author and arXiv id); rows proposed at stage 2's end.

### 1d.2 N6-MTP — TRUE in its printed steps; GAP at "so of average curvature zero" as stated (the hull's member need not be a proper map); its conclusion for the averaging step TRUE for hole-free maps by a direct argument [hand, one mind; over the printed theorems read]

*The statement's chain, step by step.*
1. **A stationary random valid map in the hull.** The translates of a map with `𝓜_K`'s bounds (at most `K` arcs per tile, radii at least `1/K`, at most `K` tiles per unit
   disc) have compact closure in the local topology; `ℝ²` is amenable, so empirical averages over growing squares have translation-invariant limit points
   (Krylov–Bogolyubov). Validity is closed under these limits: two interior points of one colour at distance 1 in a limit would give, nearby in the approximants, open sets
   of one colour whose distances straddle 1 (N-E0); non-Siamese is closed too (cross distances stay `≥ 1`, and `= 1` is excluded as just said). ✓
2. **Its Palm version is unimodular.** `[AldousLyons2007]` Example 9.5, stated for laws invariant under the full isometry group; its proof uses only that the diagonal
   measure `ρ(B × C)` has equal marginals, which translation invariance gives on `ℝ²` (a unimodular group acting simply transitively). The map's rotation system and
   geometry ride as marks (`[AngelHutchcroftNachmiasRay2018]` §2.2). ✓
3. **Hyperfinite.** An independent translation-invariant nested dyadic grid (offset Haar-distributed on the inverse limit of `ℝ²/2ⁿℤ²`) gives finitary percolations
   `ω_n` = edges inside one level-`n` square, increasing, with finite clusters (at most `K` tiles per unit disc), exhausting every edge almost surely (an edge of length
   `≤ 1` crosses a level-`n` line with probability `O(2^{−n})`): `[AldousLyons2007]` Theorem 8.5 (iv). ✓
4. **"So of average curvature zero."** `[AngelHutchcroftNachmiasRay2018]` Theorem 1 ((1) ⟺ (2)) with Theorem 3.4 gives it for an infinite ergodic unimodular random rooted
   **planar map** with `E[deg ρ] < ∞` (ergodic components otherwise). A planar map there has a **connected** graph and **every face an open disc** (§2.1); pinch points are
   allowed and counted by multiplicity, as the statement says. **The GAP:** step 1's limits need not be such maps even when the map is. A C-shaped tile whose two tips
   close around a pocket, the channel between them narrowing along the map (allowed in `𝓜_K`: the bounds cap arcs, radii and tiles per disc, not widths), converges to a
   tile that surrounds the pocket — an annular face, and the pocket's boundary a separate component; a sliver tile collapses to a curve. A stationary measure can
   concentrate on such limits (let the channel widths shrink along the map, e.g. width `1/n` in the annulus `2ⁿ ≤ |x| < 2ⁿ⁺¹`). So "`μ = 0` in the map" does not give
   "`μ = 0` in the hull", and the scope line "GAP-μ … untouched" must read **GAP-μ in the hull**; the kill's local statements must also hold on the limits (degenerate
   realizations are not valid maps in the strict sense). *Where it holds:* when the chosen stationary measure charges only maps whose faces are discs.
5. **Intensity identities.** Given a proper Palm map, route T's counts (Euler in expectation: `E[κ(ρ)] = 0` is `E[deg ρ] − 2 = 2E[Σ_{f ∋ ρ} 1/deg f]`) and N3-JOINT's
   assignment (a finite-range mass transport) hold in expectation by the MTP. ✓

*A direct route, with no hull (derived here).* **For a valid map of bounded complexity whose tiles are open discs (pinch points allowed), the aperiodic averaging step
closes by Euler's formula on large discs.** The tiles meeting `B(0, R)` form a finite connected plane map; Euler's formula for it, and each local identity of route T,
hold up to a boundary term bounded by `C(K)` times the number of tiles meeting the annulus `R − 1 ≤ |x| ≤ R + 1`, which is `O(R)`; a local strict inequality ("a unit unused
in every disc of radius `R₀`") gives at least `cR²/R₀²`. Contradiction for large `R`. This needs no unimodularity, no hyperfiniteness and no curvature theorem (it is the
single-map, Følner form of the same count), and it keeps `μ = 0` in the map itself. **So N6-MTP's conclusion — "the aperiodic averaging step for Q-full_K closes" — is TRUE for
hole-free maps**, by this route; by N6-MTP's own route it closes only under GAP-μ in the hull.

*The positive control (C114-FIVE-COUNT), run through it.* Averaging adds nothing that depends on `k`: N114-EULER's identity
`Σ_f (deg_M(f) − (k − 1)) = (7 − k)F + Σ_v (d − 2)(d − 3) − μ` holds on `B(0, R)` up to `O(R)`, so wherever the torus five-colour argument closes, the plane version at bounded
complexity closes by the direct route (and by N6-MTP's route under the same GAP), and six's room enters at the same place: `(7 − k)F` drops from `2F` to `F` and the unit-arc
repeats of the rainbow deficit (N114-RD's (A), (B)) are what allow map-degree above five. **Scope:** `𝓜_K` only (the `O(R)` boundary bound uses the tiles-per-disc cap);
GAP-μ, K1, K2-loc, the Siamese class and unbounded complexity untouched, as the statement says.

## Stage 1d — SAVED

## Stage 2 — SAVED: FS114-N6's record read; divergences; verdicts after reading

### 2.1 Read (after stage 1's last commit `764dbc69`)

`plans/FS114-N6-proof.md` in full (header, theorem table, logs, stages 1–5, proposals); `tools/fs114_n6_pin.py` re-run by me: output identical to
`data/fs114/fs114-n6/pin.out` (20 lines), its `--plant` identical to `pin-plant.out` (exit 1, as recorded); `plans/FS114-N-proof.md` N2-AVG (l. 455–470, to
compare with my NB6-FOLNER). Copies in `scratchpad/fs114-nb6/`.

### 2.2 The quotation check of the instance against N6's record (standing rule 5)

`tools/fs114_nb6_quotes.py data/fs114/fs114-nb6/quotes-n6.tsv` (the thirteen statements, extracted from the instance by script): **13 of 13 FOUND** verbatim in
`plans/FS114-N6-proof.md` (`quotes-n6.out`, exit 0). **One paraphrase, in the instance's own gloss:** "A (Q) arc of the ring `ω(p)` is a boundary arc along `ω(p)`
whose outer colour is carried at `p` (FS-112's (Q) type; N5-BENDG)" drops FS-112's "and the inner colour too"; N6 uses FS-112's (Q) (its §1.2 and §2.2: "(Q) or
(R2)"). Read literally, the gloss makes (R2) arcs (Q) arcs, and then N6-QOUT's "inner `T_{j+1}`" and N6-QE1 are false for them. **My slip, disclosed:** §1b.0's
"every verdict below holds under both readings" is right for §1b's claims (KAPPA, WIN, RING60, NOQ, the lemma) but not for §1c's N6-QOUT, N6-QE1 and N6-PIN, whose
verdicts are for FS-112's (Q), N6's own.

### 2.3 Divergences from my stage-1 verdicts (each with both addresses)

| # | claim | kind | mine (stage 1) | N6 | changes a verdict? |
|---|---|---|---|---|---|
| 1 | N6-WIN | **scope, in the table sentence** | §1b.2: the reach of `y + 60°` TRUE only when `κ` is defined just before it; GAP at a (Q) end | table: "…one tile, which reaches `y + 60°`" unconditional; its own §2.2 (i): "if moreover `κ(y + 60° − δ)` is defined, `y + 60°` is a change point … and `R_A` has it in its closure" | **yes for the table sentence: MISSTATED**, corrected to §2.2 (i)'s form; §2.2's form TRUE, two minds, one blind |
| 2 | N6-RING60 | wording | "after the bends" needed (§1b.3) | table omits it; §2.2's corollary carries it | no |
| 3 | N6-P60′ | hypothesis | the table's "`κ` defined on the two 60° windows" suffices: the clockwise `δ` beyond `q_j − 60°` follows from N6-QOUT's zones, the counter-clockwise `δ` is not needed (`U′` is ordered behind `t_{j+1}`'s cone) (§1c.2, §1b.4) | §3.1 assumes `κ` on `(φ_j − 60° − δ, φ_j + 60° + δ)` and uses `R_− ⊂ [210°, 330°]` rel | no — both TRUE; mine proves the statement as tabled |
| 4 | N6-P60′ | route | "the whole side": the region `Λ` holds only `t_{j+1}` and `U′`, `U′` separated from the side's middle (§1c.2) | §3.1: "simple class: the common boundary of two tiles is connected" | no — N6's is shorter |
| 5 | N6-NOQ | route | no N6-PIN180: NB6-P60 also kills `(60, 60, 60, 180)` (§1b.5) | §2.4/§3.1: N6-PIN180 restricts to `{60°, 120°}`, then N6-P60′ | no |
| 6 | **N6-COV** | **truth at the stated hypothesis** | §1c.7: GAP — with `κ` on the two windows only, the ring tiles' cones at `q` are `[30°, 210°]` and `[150°, 330°]` rel `φ`, both meeting `(150°, 210°)` | §Stage 4: TRUE, "(N6-WIN, as in N6-P60′)" — importing P60′'s `δ`-extended hypothesis; N6's own tool line RCONE "direction 180 (toward p) faces w_- strictly (so R_+ cannot hold it)" rests on an `X`-tile at `w_−`, outside the windows | **yes: MISSTATED**, corrected: "…with `κ` defined on `(φ − 60° − δ, φ + 60° + δ)` …", then TRUE (two minds, one blind); the second clause TRUE in the pinwheel |
| 7 | N6-CENT | wording | the last clause needs `0° < γ < 60°` (§1c.6) | §Stage 4's body: "K1's "non-Reuleaux lenses" (`0 < γ < 60°`) reduce to rings with (Q) arcs" | no |
| 8 | N6-QOUT's §2.3 consequence (not a table claim) | **truth of an unfiled step** | QOUT's zone for `T_{j+2}` starts at `q_j` when `α_{j+1} = 60°`, `α_{j+2} ≤ 120°`, and N6-ADJ/P60′ allow `T_{j+2} ∋ q_j`: a (Q) arc of `T_{j+2}` (outer tile `z_j`, by CL) starting at `q_j` counter-clockwise passes every constraint I hold | §2.3: "**(Q) arcs never start at a centre from the counter-clockwise side** (… needs `α_{j+1} = 60°` and `T_{j+2} ∋ q_j`, excluded in §2.4)" — §2.4's step was withdrawn at §3.1 and this consequence was not re-derived | not a table verdict; **GAP owed**: §2.3's dichotomy at centres gains a third case (the counter-clockwise branch a (Q) arc of `T_{j+2}` from `q_j`); N6-NOQ does not use it, the (Q)-pinwheel's residual (N6-PIN, K1-PINQ) does |
| 9 | **N6-MTP** | **truth of the route** | §1d.2: the printed steps TRUE; "so of average curvature zero" GAP — the hull of a simple, hole-free map can hold non-simple members (a C-shaped tile's channel closing: a pinch point or an annular face; slivers collapsing), outside AHNR's maps and outside the simple class every kill statement assumes | §5.2: "closes … by printed theorems, with no Følner estimate"; holes bridged ("add a bridge edge … local, colour-free"), which settles the Euler side and turns a hole into `μ`, "GAP-μ … untouched" | **yes: the route is GAP** (it needs GAP-μ *and the simple class* in the hull, not only in the map); **the conclusion is TRUE by the direct route**, N2-AVG (FS114-N2, one mind) = NB6-FOLNER (mine, derived blind to N2-AVG): two minds, one blind, and with no complexity bound in N2's form |
| 10 | N6-MTP | wording | translation invariance suffices for `[AldousLyons2007]` Ex. 9.5's proof on `ℝ²` | "Rotations are optional (SO(2) is compact)": average over rotations and apply Ex. 9.5 verbatim | no — both right |
| 11 | grades | grade | — | every N6 row "one mind" | every row I confirm is now **two minds, one blind** (list in 2.4) |

### 2.4 Verdicts after stage 2

| claim | verdict | grade (minds) | radius read |
|---|---|---|---|
| N6-KAPPA | TRUE | hand; two, one blind | `1 + ε` |
| N6-WIN | §2.2's form TRUE; the **table sentence MISSTATED** (the reach needs `κ` defined just before `y + 60°`; at a (Q) end it is a GAP) | hand; two, one blind | `1 + ε` |
| N6-RING60 | TRUE (after the bends) | hand; two, one blind | `1 + ε` |
| **N6-NOQ** | **TRUE** | hand; two, one blind, different routes at the 180° case | `1 + ε` (bends on the fragment) |
| N6-PIN | TRUE as a status (the (Q) residual larger than §2.3 says: divergence 8) | hand; two, one blind | `1 + ε` |
| N6-P60′ | TRUE as tabled (the proof's `δ`-extension not needed) | hand; two, one blind | `1 + ε` |
| N6-ADJ | TRUE | hand; two, one blind | `p, q_j, q_{j+1}` |
| N6-QOUT | TRUE (for FS-112's (Q)); its §2.3 second consequence GAP | hand; two, one blind | `1 + ε` |
| N6-QE1 | TRUE | hand; two, one blind | `1 + ε` |
| N6-PIN180 | TRUE | hand; two, one blind | `ε` |
| N6-CENT | TRUE (last clause for `0 < γ < 60°`, as N6's body says) | hand; two, one blind | `1 + ε` |
| **N6-COV** | **MISSTATED**: TRUE with `κ` defined on `(φ − 60° − δ, φ + 60° + δ)`; GAP with the windows only | hand; two, one blind (corrected form) | `1 + ε` |
| **N6-MTP** | printed steps TRUE; **"closes by printed theorems" GAP** (the simple class and `μ = 0` are not inherited by the hull); the conclusion for Q-full_K TRUE by N2-AVG / NB6-FOLNER | hand; the printed steps two, one blind; the direct route two, one blind | — |

**Controls (template item 3).** No step of N6's or mine reads beyond `1 + ε` about `p` (the bends on the fragment; N6's "at radius `1 + ε`" is attached to the `Γ`-free
case, where no bend is needed). Neither the strip nor the disk refutes a step: their four-colour vertices carry arcs centred at them, not four tactic edges, so the pinwheel
statements fail there at their hypotheses; N6-KAPPA and N6-WIN (§2.2's form) hold on the strip's `P_1`. *A consistency note, not checked exactly:* the disk's central
Reuleaux pentagon has, at each corner, its two sides on unit circles about the opposite corners, `36°` apart as seen from the corner (a lens-like corner of cone 144° =
`180° − 36°`), and its corners' rings carry arcs (row 136) — the shape N6-CENT's necessity direction predicts; whether both sides are tactic there was not checked.
**Six** is spent where §1c.9 says, in both records. **C114-FIVE-COUNT** through N6-MTP: §1d.2 (the control passes through the direct route; through N6's route under
the same GAP).

## Stage 2 — SAVED
