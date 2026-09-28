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

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| enumerate ring patterns (change points, (Q)/(R2) pieces) of a four-colour vertex | N6-KAPPA's straddle and CL-ring by hand (§1b.1–1b.3) |
| scan the cone patterns `(α_1, …, α_4)` of a pinwheel for survivors | reduced to multiples of 60° by N6-RING60 and killed each 60°→larger step by one lemma (§1b.4–1b.5) |
| build a fragment by formula with a (Q) arc ending 60° after a change point, to decide N6-WIN (iii) | read the strip's `P_1` (a held rebuild) as a near-instance; the sub-case left a GAP (§1b.2) |

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
