# FS114-YB5 — blind verification of FS-114's construction side, round 6 (FS114-Y6: E1 and E2 of the pinwheel, and the Reuleaux half)

*Job FS114-YB5, de Bruijn on Opus 5.5, launched 2026-09-28 about 13:03 UTC. Brief: the template `data/fs114/briefs/YB114-verify-construction.md`
with the instance `data/fs114/briefs/YB5-114-instance.md` (read from disk; its changes win) and `data/fs114/briefs/STANDING-RULES.md` (rule 0 first).
Resuming check: no record, working directory, tool or report of this job existed at start. Working files `data/fs114/fs114-yb5/`; tools
`tools/fs114_yb5_*.py`; scratch `scratchpad/fs114-yb5/` (regenerable only). Every statement about a valid map is about a possible object: the class
is not known to be non-empty. Stage 1 (my verdicts) is committed before I open `plans/FS114-Y6-construction.md`, `data/fs114/fs114-y6/` or
`tools/fs114_y6_*`.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| YB5 verdicts on FS114-Y6's seven statements (stage 1, blind) | E1FORM, E1Q3, E1OMEGA, E1K1 TRUE; E1CAP TRUE but its `λ_3 = α_3 − 60°` a GAP (the wrap); E2RED's chain TRUE, survivors by my derivation one family F2, "all short of the tangent" a GAP (a full wrap of `Λ_c`); HALF TRUE when `t_2`'s cone `> 60°` and `t_4`'s `≥ 60°`, a GAP at the two boundary subcases (D2T's first clause FALSE at `t_2 = 60°`) | hand; mine, blind | stage 1b |
| YB5-E2-60 | E2 at a blade of cone `60°` holds only with E1 at one of its two edges (a width-1 Reuleaux triangle has diameter pairs only through a corner) | hand; mine | 1b item 6 |
| YB5-CAP2 | in E1 at edge 1 (edges 2–4 below `60°`, no E2 at `t_3`, `t_4`), `L_1` has no inside part: the case with one is emptied by a Jordan curve through `T_4` and `t_2` | hand; mine | 1b item 4 |
| YB5-F0 | with E2 at `t_{c+1}` and nothing at `q_c`, the cone family `(180° − b, b, c, 180° − c)`, `b + c ≤ 180°`, is killed by PXKILL at `k = c + 1` | hand; mine | 1b item 6 |
| YB5-CONE180 | every cone of a pinwheel is below `180°` (at `180°` edge `j + 1` leaves `B̄(q_j, 1)`) | hand; mine | 1b preamble |
| YB5-CHK | an exact `ℚ(√3)` named-point checker: 31 of 31 as registered, four plants each failing exactly its predicted check | tools | 1c.2 |
| YB5-HALF4 | in a Reuleaux `(2, 1, 1, 0)` pattern with `t_4`'s cone below `60°`, `X1 = t_2` or `X2 = t_4` (else the ring-arc tile at `q2` has no colour) | hand; mine | §2.3 |
| YB5 verdicts after comparison | E1FORM, E1Q3, E1OMEGA, E1K1 TRUE (two minds, one blind); E1CAP TRUE but `λ_3` GAP; E2RED's chain TRUE, survivors sharpened from S1–S6 to S6, "short of the tangent" GAP; HALF MISSTATED (true with a cone hypothesis) | hand; two minds, one blind for what agrees | §2.4 |

## Would have searched here (standing rule 3)

| stage | move I would have made by search | what I did instead |
|---|---|---|
| 1b | enumerate colour assignments at `q_4`, `q_1`, `v_2` in E1 to see which survive | derived each colour's exclusion from the tile at `p` or at a centre that points at the vertex, one colour at a time |
| 1b | enumerate cone quadruples under E2 | derived the four disjunctions and enumerated the cases by which cones equal `60°` (seven cases, by hand) |
| 1b | build an E1 fragment by formula to see where the chain breaks | none built: the residues are named in the derivation |
| 1c | scan probe radii near the Pointing boundaries | registered one probe per check; the one that sat on a boundary is recorded (run 1) |

## Fence log (standing rule 13; the template's and the instance's fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): lines naming milestone status (FS-112, FS-114 jobs) and standing rules; nothing about
   FS114-Y6's statements or proofs.
2. **The harness's start-up git snapshot** printed five commit subjects (`FS114-Y6: report`, `FS114-Y6: stage 4`, `FS111-M4: stage 1`,
   `FS114-Y6: stage 3 (the owner's ruling on the grid check)`, `FS-114 inventory`) and the untracked names `data/fs111/fs111-w/*.out` and my instance
   file. Subjects and names only.
3. My start-up `git log --oneline -15` printed one subject beyond the snapshot (`8d3468d2 FS-114 inventory; verifier instance`) and older subjects
   (`FS114-N7: stage 1`, `FS114-YB4: report / stage 2 / stage 1`, `FS-114 inventory; FS-114 brief`, …). Subjects only; no further `git log`, no
   `git log -p`.
4. `ls data/fs114/ data/fs114/briefs/` and `ls plans/ | grep -i fs114` listed by **name** the fenced directories (`fs114-n` … `fs114-n7`, `fs114-nb*`,
   `fs114-y6`, `fs114-cv*`, `reports`), the fenced briefs (the proof side's, the verifiers', the advisor's, `Y6-114-construction-round6.md`) and the fenced
   records (`FS114-N*-proof.md`, `FS114-NB*`, `FS114-CV*`, `FS114-Y6-construction.md`, `FS114-close-inventory.md`). Names only.
5. **A touch, disclosed.** My `cat plans/FS114-Y5-construction.md` (open to me) was too long for the terminal; the harness saved the output under
   `~/.claude/projects/-home-kooshi-source-lean-dir/…/tool-results/` (a fenced path), and **I opened that saved file** with the Read tool. Its content is
   exactly `plans/FS114-Y5-construction.md`, an open record; nothing else under that path was opened. (FS114-YB4 met the same situation and re-read the
   source instead; I did not.)
6. **A touch, disclosed.** An `ls` of the shared harness scratchpad's root (meant only to create my own subdirectory) printed the **names** of every
   file and directory other jobs keep there (among them `fs114-y6`, `fs114-n7`, `fs114-nb6`, …). Names only; nothing in them opened, listed inside or
   grepped. Also a slip of mine: before that I had copied `plans/FS114-YB4-verification.md` (open to me) to `scratchpad/yb4.txt`, outside my
   subdirectory; it was deleted unread in the same command that made `scratchpad/fs114-yb5/`.

## Stage 1a — SAVED: reading; the quotation check

### 1a.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` **in full**, rule 0 first (`CLAUDE.md` § The aim and § Counter-priors, in context from disk at start-up); the template and the
  instance **in full**; `data/fs114/briefs/YB4-114-instance.md` (the vocabulary) **in full**.
- `CLAUDE.md` G83, G79, G71, G46, G22, G21, G20, G51 (the session's load at start-up). `LEDGER.md` rows 133–136 **in full**.
- `data/fs114/claims.md` **in full**. `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ and stage 5b **in full**; **5.3 not read**.
- `data/fs114/briefs/Y114-construction.md` **in full**; its § Reading's sources (FS-112's close, the printed local NOs, the Google group, two papers) are
  **not re-read this round** — what bears on E1, E2 and the Reuleaux half is in the round records below.
- The round cards `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` **in full**.
- `plans/FS114-Y5-construction.md` **in full** (the pinwheel chain: RAINBOW, REGION, MU, ALT, POCKET, CASE, REDUCE, PIN120-60, PX, PXKILL, PINALL);
  `plans/FS114-YB4-verification.md` **in full** (its verdicts, YB4-WRAP, YB4-P120GAP).
- `plans/FS114-Y4-construction.md` **in full** (SIDES, UPDOWN, W, LUNE, DIAG, RSTOPALL); `plans/FS114-YB3-verification.md` **in full** (D2T, the cusp).
- `plans/FS114-L60-audit.md` **in full**, §1.3 (ii) L60-EQ closely (E1 is its equality case).
- FS-112's checkers and records (`plans/FS112-YB*-verification.md`): **by name and size only this round**; the object checker I lean on for calibration is
  FS114-YB3's (`tools/fs114_yb3_check.py`, `tools/fs114_yb3_run.py`, run unedited), which imports FS-112's builders for the strip, the disk and
  FS112-BOWTIE.
- **Not read:** every fenced file.

### 1a.2 The quotation check (standing rule 5) — `data/fs114/fs114-yb5/quotes.tsv`, through FS114-YB's `tools/fs114_yb_quotes.py` unedited

**24 of 24 FOUND** (`quotes.out`, exit 0): the standing rules' five Kooshi quotations (rules 0, 3, 4, 10); Y5's E1 and E2 (both its PINALL wording and
its §3 definition of E2); the definition of **simple** against `plans/FS114-Y4-construction.md`'s header; de Grey's Siamese against the claim list;
L60-LE and L60-EQ against `plans/FS114-L60-audit.md`; Y5's MU, ALT, POCKET, CASE, PXKILL and PINALL against its theorem table; the tactic-edge gloss
against `YB4-114-instance.md`; Y4-SIDES, Y4-W, Y4-DIAG against Y4's table; YB3-D2T against YB3's table; K1-PIN against the round-4 card. The tool's
self-test PASSED (`quotes-selftest.out`); my plants (`quotes-plant.tsv`): one word changed in SR0 and `B̄` turned into `B` in L60-EQ's outer clause
read **MISSING**, the faithful twin **FOUND** (`quotes-plant.out`, exit 1 as it must).

**By hand.** The instance's glosses — "**E1** is an edge at `p` of exactly 60°" and "**E2** is a blade whose counter-clockwise side is a unit arc centred at
its clockwise edge end" — are faithful to Y5's "E1 (an edge at `p` of length exactly `60°`)" and "E2 (a blade's counter-clockwise side a unit arc centred at
its clockwise edge end)"; the first drops the word "length" (the edge's angular length about its centre), which I restore.

**Not checkable in stage 1:** the seven statements, copied by the owner's script from `plans/FS114-Y6-construction.md` (fenced until stage 1 is
committed): stage 2's first step. The glosses of **tactic edge**, **pinwheel**, **ring** and **non-Siamese** have fenced sources (the proof side's
records); I work them as `YB4-114-instance.md` states them, and read **non-Siamese** as closures of distinct same-coloured tiles at distance at least 1.

### 1a.3 Reading points fixed before any verdict (my notation; Y5's where it is open)

- **The pinwheel** (Y5's header, verified by YB4 to agree with its own): `p = 0`; `q_j = e(φ_j)`, `j = 1 … 4` counter-clockwise; edge `j` leaves `p` in
  direction `θ_j = φ_j − 90°` along `ω(q_j)`; blade `t_{j+1}` (colour `j + 1`) has sector `[θ_j, θ_{j+1}]` at `p`, cone `α_{j+1} = φ_{j+1} − φ_j`; it is
  **inner** for edge `j` (`q_j ∈ cl t_{j+1}`) and **outer** for edge `j + 1`; `T_j` is the tactic tile of colour `j` at `q_j`. Edge `j` runs about `q_j` from
  `p` (angle `φ_j + 180°` about `q_j`) with increasing angle, length `ℓ_j` (Y5's `β_j`), to `w_j = q_j + e(φ_j + 180° + ℓ_j)`. Blade `t_{j+1}`'s boundary:
  edge `j`, then its clockwise side `L_j` from `w_j` to `q_j` (an inside part, then a ring part from `v_j = e(φ_j − λ_j)` to `q_j`), then its
  counter-clockwise side `M_j` from `q_j` to `w_{j+1}`, then edge `j + 1` back to `p`. `μ_j` (colour `m_j`) is the 5/6 tile along `M_j`, `Λ_j` the one along
  `L_j`'s inside part; `m̄` is the other of `{5, 6}`.
- **E1 at edge 1**: `ℓ_1 = 60°`, so `w_1 = q_1 + e(φ_1 + 240°) = e(φ_1 − 60°)`, a point of the ring. **E2 at blade `t_{c+1}`**: `M_c ⊂ ω(w_c)`.
- **Frame for E1** (used in every E1 item below; stated before reading any E1 text of Y6's): `φ_1 = 0°`, so `q_1 = (1, 0)`, and `q_4 = e(−60°)`,
  `C := e(−120°) = p + q_4 − q_1`. Angles at a vertex are directions from it, counter-clockwise from the positive `x`-axis. **The statements' own frame is
  not given in my brief**: E1OMEGA's "directions just above `270°`" at `q_4` is read in this frame (where `270°` is the tangent of `ω(C)` at `q_4`), and the
  reading is checked against Y6's frame at stage 2.
- **`(2, 1, 1, 0)` pattern** (HALF): counting, for each tile at `p`, the tactic edges it is inner for, in cyclic order (Y5 §4.3's G79 reading). A tile
  inner for both its edges is the "two-edge tile"; HALF takes it to be a width-1 Reuleaux triangle.

## Stage 1a — SAVED

## Stage 1b — SAVED: my derivations of the seven statements (blind: no FS114-Y6 file opened)

*Every step is mine, [hand; one mind]. Setting: a non-Siamese (closures of distinct same-coloured tiles at distance at least 1), simple valid
fragment containing a neighbourhood of `B̄(p, 1)`, with a pinwheel at `p` in 1a.3's notation, E1 at edge 1 (frame `φ_1 = 0°`: `q_1 = e(0°)`,
`w_1 = e(300°)`, `C = e(240°)`) where said. Tools, as FS114-YB4 used them (its 1b preamble) and I re-derive them where they carry weight:*
- **Diameter.** A tile's closure has diameter at most 1; `u ∈ cl Z` gives `Z ⊂ B̄(u, 1)`; an open tile disjoint from `B(u, 1)` misses `B̄(u, 1)`.
- **Pointing.** A colour `c ∈ {1…4}` is blocked near the ring point `e(θ)` (both sides) unless its tile there is `t_c`, whenever `t_c`'s open sector at `p`
  has a direction within `90°` of `θ`; near a point `v` with `|v − u| = 1`, a tile at `u` with a direction `ψ`, `cos(ψ − arg(v − u)) > 0`, has points within
  `< 1` of every point near `v` (UPDOWN).
- **REGION, REG60, U1** (Y5 §2.1; YB4 1b item 2; FS112-U1): `t_{j+1} ⊂ B̄(p, 1) ∩ B̄(q_j, 1) ∖ B(q_{j+1}, 1)`; every cone `≥ 60°`; at `q_k` the inner tile lies
  in the cone facing edge `k` (`[φ_k + 90° + ℓ_k, φ_k + 270°]`), `T_k` in the cone facing away (`[φ_k + 270° + ℓ_k, φ_k + 90°]`), the two side cones hold
  neither. **Every cone is below `180°`**: at `α_{j+1} = 180°`, `q_{j+1} = −q_j` and the points `q_{j+1} + e(φ_j + s)` of edge `j + 1` (`0 < s ≤ ℓ_{j+1}`) are
  `√(5 − 4cos s) > 1` from `q_j ∈ cl t_{j+1}`.
- **RAINBOW, MU, ALT, POCKET, CASE** as FS114-YB4 verdicted them (its §2.5): MU at `t_{j+1}` needs edges `j` and `j + 1` below `60°`; ALT(`μ_j`, `μ_{j+1}`)
  fails only under E2 at `t_{j+2}`; **SEP** (YB4): no tile borders both `M_k` and `L_k`'s inside part.

### 1. FS114-Y6-E1FORM — **TRUE** [hand; mine]

Edge 1 is an arc of `ω(q_1)` of length `60°` with constant sides (inner `t_2`, outer `t_1`), from `A = p` to `B = w_1`. **L60-EQ** (P = `q_1`):
`t_2 ⊆ Reul(q_1, p, w_1)` and `t_1 ⊆ Reul(p, w_1, p + w_1 − q_1) ∖ B̄(q_1, 1)`, with `p + w_1 − q_1 = e(240°) = e(φ_1 − 120°)`; both ends lie in both
closures. The cap's corner cone at `p` is `[210°, 330°] ∩ [270°, 90°]ᶜ = [210°, 270°]` (the Reuleaux corner cone, cut by `ω(q_1)`'s tangent), so
`t_1`'s sector `[θ_4, 270°]` gives `θ_4 ≥ 210°`, i.e. `α_1 ≤ 60°`; REG60 (`q_4 ∈ cl t_1`, `t_1 ∩ B(q_1, 1) = ∅`) gives `α_1 ≥ 60°`. So **`α_1 = 60°`,
`q_4 = e(300°) = w_1`**, `t_1 ⊆ Reul(p, q_4, e(φ_1 − 120°)) ∖ B(q_1, 1)`, `t_2 ⊆ Reul(p, q_4, q_1)`, `q_4 ∈ cl t_2`. **`α_2 < 120°`:** `Reul(p, q_4, q_1)`'s
corner cone at `p` is `[270°, 30°]`, so `α_2 ≤ 120°`; at `α_2 = 120°` edge 2 leaves `p` at `30°` along `ω(q_2)`, `q_2 = e(120°) = −q_4`, and its points
`q_2 + e(300° + s)` are `√(5 − 4cos s) > 1` from `q_4 ∈ cl t_2`: diameter. ∎

### 2. FS114-Y6-E1Q3 — **TRUE** (and "no E2 at `t_3`" is not used) [hand; mine]

CASE at `q_3` reads MU at `t_3` (edges 2, 3) and at `t_4` (edges 3, 4), POCKET at `w_3` (ALT(`μ_2`, `μ_3`): no E2 at `t_4`), and in (A) the Pointing
block of colour `k + 2 = 1` at `q_3` by `t_1`, which needs `α_4 < 180°` (true: every cone is below `180°`); edge 1 enters none of them. So CASE holds at
`q_3`: (B) `α_3 = 60°`, and then `α_4 = 240° − α_2 > 120°` (E1FORM); or (A) `α_2 + α_3 ≤ 180°`, so `α_4 = 300° − α_2 − α_3 ≥ 120°`. ∎ E2 at `t_3` breaks
ALT(`μ_1`, `μ_2`), which CASE at `q_3` does not read; the statement's hypothesis is stronger than its proof needs.

### 3. FS114-Y6-E1OMEGA — **TRUE**, reading "just above `270°`" as the tile at `q_4` just outside the ring, clockwise of `q_4` [hand; mine]

*Reading:* in a frame with `q_4 = e(0°)` (`φ_4 = 0°`) the ring's clockwise tangent at `q_4` is `270°`, and "just above `270°`" is CASE's tile `Z` at `q_4`
(just outside the ring, just past its clockwise tangent); in my frame (`q_4 = e(300°)`) that direction is `210°⁺`. Stage 2 checks the frame.
Let `Ω` be that tile. Its colour is not:
- 1 (`t_1` is at `q_4`; one tile per colour at a vertex) nor 2 (`t_2 ∋ q_4`, E1FORM);
- 4: `210°⁺` lies in edge 4's side cone `(210°, 210° + ℓ_4)` at `q_4`, which holds neither `t_1` nor `T_4` (U1), and `T_4` is the colour-4 tile at `q_4`;
- 3: `t_3`'s sector at `p` starts at `270° + α_2 < 390°` (E1FORM), a direction within `90°` of `300°` (Pointing at `q_4`);
- `m_3`: MU at `t_4` (edges 3, 4 below `60°`) gives `w_4 ∈ cl μ_3`, and `|q_4 + s·e(210° + δ) − w_4|² = 1 + s² − 2s·sin(ℓ_4 − δ) < 1`
  (`w_4 = q_4 + e(120° + ℓ_4)`); `Ω ≠ μ_3` since `μ_3 ∋ q_3` and `|q_3 − q_4| = 2sin(α_4/2) > 1`.
So **`c(Ω) = m̄_3`**, and `m̄_3 = m_2` by ALT(`μ_2`, `μ_3`) (no E2 at `t_4`). ∎ **One more fact used below:** `Ω` has points `q_4 + s·e(210° + δ)`,
at squared distance `1 + s² + √3·s + O(sδ) > 1` from `q_1`, so **`q_1 ∉ cl Ω`**.

### 4. FS114-Y6-E1CAP — **TRUE but for one clause: `λ_3 = α_3 − 60°` is a GAP (the wrap)** [hand; mine]

Hypotheses as E1Q3's (E1 at edge 1 only; no E2 at `t_3`, `t_4`); `μ_1` is the inner-gap tile at `q_1` adjacent to `t_2` (GAPS).
1. **Colours near the ring arc `(300°, 360°)`, outside.** 1, 2, 3 are blocked (Pointing: `t_1`'s `270°⁻`, `t_2`, and `t_3`'s start `270° + α_2 < 390°` are
   within `90°`); 4, 5, 6 are free. Every point near that arc (and every interior point of `Reul(p, q_4, q_1)`) is within `< 1` of both `q_4` and `q_1`,
   so an outside or inside tile there of colour 4 is `T_4`, of colour `m_2` is `Ω`, of colour `m_1` is `μ_1` (non-Siamese).
2. **The tile `Z_1` at `q_1` just outside the ring, clockwise** (direction `270°⁺`, edge 1's side cone at `q_1`): not 1 (`T_1` is in the away cone
   `[330°, 90°]`), not 2, not 3 (Pointing), not `m_1` (`μ_1`'s one sector at `q_1` is in the inner gap, `t_2` on one side and `T_1` on the other);
   so `c(Z_1) ∈ {4, m̄_1}`. Its points `q_1 + s·e(270° + δ)` are within `< 1` of `q_4` (`|e(60°) + s·e(270° + δ)|² = 1 + s² + 2s·cos(210° + δ)`).
3. **Case (i): `L_1` has an inside part.** It is bordered by a 5/6 tile `Π ≠ μ_1` (SEP), so `c(Π) = m̄_1` (RAINBOW), so every 5/6 neighbour along
   `M_1` is `μ_1` and `w_2 ∈ cl μ_1` (MU's argument); ALT(`μ_1`, `μ_2`) (no E2 at `t_3`) gives `m_1 ≠ m_2`, so `m̄_1 = m_2`. Then `Z_1` of colour `m_2`
   would be `Ω` (step 1), but `q_1 ∉ cl Ω` (item 3): so **`Z_1 = T_4`, `T_4 ∋ q_1`**. Let `γ_T ⊂ T_4 ∪ {q_4, q_1}` and `δ ⊂ t_2 ∪ {q_1, q_4}` be paths
   from `q_4` to `q_1`, and `Γ = γ_T ∪ δ` (a Jordan curve; `T_4 ∩ B̄(p, 1) = ∅`, `t_2 ⊂ B(p, 1)`, so `Γ` meets the ring only at `q_4`, `q_1`). In the cyclic
   order of tiles at `q_4` the ring arc's germ lies between `T_4` and `t_2` on the side away from `t_1`, and `Ω` on the side of `t_1`: so `Ω` lies outside
   the component of `ℝ² ∖ Γ` holding the open ring arc and the region `R_0` between `L_1` and the ring. `Π` has points in `R_0 ⊂ int Reul(p, q_4, q_1)`,
   within `< 1` of `q_4`, and colour `m_2`: `Π = Ω`, which is outside. **Contradiction: case (i) is empty.**
4. **Case (ii): `L_1` is the ring arc from `q_4` to `q_1`** — `t_2` borders the whole arc (the statement's first clause). If a 5/6 tile `ν ≠ μ_1` borders
   `M_1` (colour `m̄_1`), RAINBOW leaves colour 4 as the only outside colour along the arc: every outside tile there is `T_4`, so `T_4` borders the
   whole arc and `T_4 ∋ q_1`. If `μ_1` borders all of `M_1`, then as in case (i) `m̄_1 = m_2`, `Z_1 = T_4 ∋ q_1`, and with `Γ` as above every outside
   tile along the arc lies inside `Γ`, where `Ω` and `μ_1` (its germ at `q_1` lies between `T_4` and `t_2` on the far side) are not: colour 4, so `T_4`.
   (An outside `μ_1` along the arc would meet `cl t_2` in a set joining `M_1` to the ring, forcing a second sector at `q_1`: SEP's argument.)
5. **The cap.** `T_4 ∋ q_4, q_1`, so `T_4 ⊂ B̄(q_4, 1) ∩ B̄(q_1, 1)`; `T_4 ∩ B(p, 1) = ∅` (colour 4 against `t_4 ∋ p`, `T_4 ≠ t_4`); and
   `B̄(q_4, 1) ∩ B̄(q_1, 1) ∖ B(p, 1) ⊆ B̄(q_4 + q_1, 1)` (FS114-L60 §1.3 (ii)): **`T_4 ⊂ Reul(q_4, q_1, q_1 + q_4) ∖ B(p, 1)`**. The ring arc from `q_4`
   to `q_1` is a unit arc of `60°` about `p` with constant sides (`t_2` in, `T_4` out): **a second 60° arc**, L60-EQ's equality case again.
6. **`α_4 = 120°`.** `t_4 ∩ B(q_1, 1) = ∅` (against `T_4 ∋ q_1`) and `t_4 ∩ B(q_4, 1) = ∅` (REGION), so `t_4`'s sector at `p` avoids `(270°, 90°) ∪ (210°, 30°)`:
   it lies in `[90°, 210°]`, so `θ_3 ≥ 90°`, `φ_3 ≥ 180°`, `α_4 ≤ 120°`; with E1Q3, **`α_4 = 120°`, `φ_3 = 180° = φ_1 + 180°`, `α_2 + α_3 = 180°`**.
7. **CASE at `q_3` is (A)**: (B) would give `α_3 = 60°`, `α_2 = 120°`, against E1FORM. CASE (A) gives `λ_3 ≥ α_3 − 60°` and the outside tile at `q_3`
   of colour 2, bordering `t_4`'s ring contact down to `e(φ_2 + 60°)`. **`λ_3 = α_3 − 60°` is not derived**: between `r_3` and `e(φ_2 + 60°)` the
   pocket tile `μ_2` may wrap round `t_4`'s ring corner and border the contact from outside (FS114-YB4-WRAP), and nothing here excludes it — **GAP**.
∎ (clauses 1–6 and CASE (A)); the `λ_3` clause GAP.

### 5. FS114-Y6-E1K1 — **TRUE**; its first "unless" condition is implied by its second [hand; mine]

Hypotheses: E1Q3's, `μ_1` borders all of `M_1`, `α_2 > 60°`. PXKILL at `k = 1` needs: (a) CASE (A) at `q_2` — POCKET at `w_2` holds (ALT(`μ_1`, `μ_2`),
`w_2 ∈ cl μ_1`), (B) needs `α_2 = 60°`, and the Pointing block of colour 4 at `q_2` holds (`t_4`'s sector `[90°, 210°]`); so the tile `O_2` at `q_2` has
colour 1 and borders `t_3`'s contact to `v_2 = e(60°) ∈ cl O_2 ∩ cl μ_1`; (b) `O_2 ≠ T_1` (`|q_1 − q_2| = 2sin(α_2/2) > 1`), so `T_1 ∩ B(v_2, 1) = ∅`
and `T_1 ⊂ [330°, 30°]` at `q_1`; (c) the tile at `q_1` adjacent to `T_1`'s counter-clockwise end is `μ_1`; (d) at `v_2` the sectors as in PXKILL, where
colour `m_2` is excluded by `μ_2 ∋ q_2` (`|v_2 − q_2| = 2sin((α_2 − 60°)/2) < 1`; `μ_2 ∌ v_2` since `μ_2 ∋ v_3 = e(φ_2 + 60°)`, `|v_2 − v_3| > 1`, CASE (A)
at `q_3`, item 4); (e) the two arcs, second order (FS114-YB4-2ND). Only (c) can fail: at `q_1` between `T_1` and `μ_1` (directions `(30°, 90°)`) colours
1 (`T_1`), 2, 3 (Pointing), 4 (`T_4` holds `(270°, 330°)`; a second sector) are excluded, `m_1` is `μ_1`; **colour `m_2` is not excluded** (`Ω`'s points
near `q_4` are more than 1 away: `|e(60°) + s·e(ψ)| > 1` for `ψ ∈ (30°, 90°)`). So the kill runs **unless a tile `X` of colour `m_2` sits at `q_1` between
`T_1` and `μ_1`**. **`X` forces `T_4` to fill the cap's corner** `[330°, 30°]` at `q_4`: if `T_4` starts at `a > 330°`, the tile before it at `q_4` has a
direction in `(330°, a)`, within `< 1` of `q_1`; its colour is `m_2` (then it is `Ω`, within `< 1` of `X`, `X ≠ Ω` since `q_1 ∉ cl Ω`: excluded) or `m_1`
(then it is `μ_1`, so `μ_1 ⊂ B̄(q_4, 1) ∩ B̄(q_1, 1)` with germs on both sides of the cross-cut `γ_T ⊂ T_4` of that lens: excluded); 1, 2, 3, 4 are taken or
blocked. ∎ So the statement's "unless … and …" is exactly "unless `X` exists".

### 6. FS114-Y6-E2RED — **the chain TRUE; the survivor set, as I derive it, is one family**, and **"all with `t_{c+1}` short of the tangent" is a GAP (a wrap of `Λ_c`)** [hand; mine]

E2 at `t_{c+1}`: `M_c ⊂ ω(w_c)`; no E1. ALT's proof fails only for the pair (`μ_{c−1}`, `μ_c`) (its E2 is at `t_{(c−1)+2}`). ALT(`μ_{c−1}`, `μ_c`) is read by
POCKET at `w_c` only, POCKET at `w_c` by CASE at `q_c` only; MU, RAINBOW, SEP, REGION, U1 and the other ALTs read no E2. **At `q_c`:** (B) (`λ_c = 0`) loses
its conclusion `α_c = 60°` (the inside tile there is `Λ_c`, which need not be `μ_{c−1}`); (A) (`λ_c > 0`) loses `α_c − λ_c ≤ 60°` but keeps
`α_{c−1} + α_c ≤ 180°` **provided the outside tile `Z` at `q_c` is not `Λ_c` itself**: `Z` is not `c + 1`, `c` (side cone), `m_c` (`μ_c`'s one sector),
`c + 2` (Pointing, cones below `180°`), and not `m̄_c` unless `Z = Λ_c` (`Λ_c ∋ r_c`, within `< 1`). Without POCKET, **`Λ_c` may wrap round `r_c` all the
way to `q_c`** — then `λ_c > 0`, `Z = Λ_c`, and neither (A)'s pair sum nor (B)'s `α_c = 60°` follows (outside E2 this wrap gives `μ_{c−1} ∋ q_{c−1}, q_c`, so
`α_c = 60°`, FS114-YB4 §2.2 row 6; here `Λ_c ≠ μ_{c−1}`). I find nothing excluding it. With (A) at `q_c`: all four centres give their conditions, REDUCE
applies (`α_c ≤ 180° − α_{c−1} ≤ 120°`), and PXKILL at `k = c + 1` reads CASE at `q_{c+1}`, `q_{c+2}`, ALT(`μ_c`, `μ_{c+1}`), ALT(`μ_{c+1}`, `μ_{c+2}`) and
`v_{c+1} ∈ cl μ_c` (POCKET at `w_{c+1}`), none broken: `P_x` excluded ✓. (Precision: it does read `μ_c`, the pocket on `t_{c+1}`'s counter-clockwise side;
it reads nothing on its clockwise side, where E2 breaks.)
**The survivors** (no constraint at `q_c`; `c = 1`, cones `(α_1, α_2, α_3, α_4)`, `α_2 … α_4 ∈ [60°, 120°]`, `α_1 < 180°`, each of `q_2, q_3, q_4` giving
`α_k = 60°` or `α_{k−1} + α_k ≤ 180°`), enumerated by which of `α_2, α_3, α_4` are `60°`:
- F0 `(180° − b, b, c, 180° − c)`, `b, c ∈ (60°, 120°)`, `b + c ≤ 180°` (no `60°` cone) — **killed by PXKILL at `k = 2`**: it needs only CASE (A) at `q_2`, `q_3`,
  `60° < α_3`, `α_2 < 120°`, and colour 1 blocked on the arc `(φ_2, φ_3)` (it is, since `α_3 + α_4 = 180°`), not the whole `P_x` shape;
- F1 `(300° − c − d, 60°, c, d)`, F3 `(240° − d, 60°, 60°, d)`, F4 `(240° − c, 60°, c, 60°)` — every one has **`α_2 = 60°`: E2 at a 60° blade, which needs E1**
  (YB5-E2-60 below): **excluded**;
- **F2 `(180° − b, b, 60°, 120°)`, `b ∈ (60°, 120°)`** — the one survivor family: in indices from `c`, `α_c = 180° − b`, `α_{c+1} = b`, `α_{c+2} = 60°`,
  `α_{c+3} = 120°`. It is exactly Y5-PIN120's exception (E2 at the blade two past the `120°` tile).
(`α_3 = α_4 = 60°`, `α_4 = 60°` alone and all three `60°` are empty.) Whether Y6's S1–S6 are these, or F0, F1, F3, F4 unexcluded, is stage 2's question.

**YB5-E2-60** [hand; mine]. *E2 at a blade `t_{c+1}` of cone `60°` holds only with E1 at edge `c` or edge `c + 1`.* `|q_c − q_{c+1}| = 1`, so REGION puts
`t_{c+1}` in the crescent `B̄(p, 1) ∩ B̄(q_c, 1) ∖ B(q_{c+1}, 1) ⊂ Reul(p, q_c, r)`, `r = e(φ_c − 60°)` (Y5 §2.2 step 10; YB4 walked it). In a width-1
Reuleaux triangle two points are exactly 1 apart only if one is a corner. E2 puts every point of the arc `M_c` (positive length unless E1 at edge `c + 1`)
at distance exactly 1 from `w_c`, all in `cl t_{c+1}`: so `w_c ∈ {p, q_c, r}`; `w_c ≠ p, q_c`, and `w_c = r` is `ℓ_c = 60°`, E1 at edge `c`. ∎

### 7. FS114-Y6-HALF — **TRUE outside two boundary subcases; "unchanged" is a GAP there (and D2T's first clause is FALSE in one)** [hand; mine]

Frame (Y4's): `t_1 = Reul(p, q1, q2)`, `q1 = e(30°)`, `q2 = e(−30°)`; its sides `S1` (arc of `ω(q2)`, `p → q1`) and `S2` (arc of `ω(q1)`, `p → q2`) are tactic,
`t_1` inner for both; `(2, 1, 1, 0)` counter-clockwise: `t_2` (sector `[60°, θ_2]`) outer for `S1` (so `T2`, colour 2, at `q2`, and `t_2 ∩ B(q2, 1) = ∅`) and
inner for its counter-clockwise edge, centre `q_{23} = e(θ_2 − 90°)`; `t_3` inner for its counter-clockwise edge, centre `q_{34} = e(θ_3 − 90°)`; `t_4`
(sector `[θ_3, 300°]`) outer for both its edges (`T1`, colour 4, at `q1`). The mirror pattern is the reflection. REG60's argument gives `θ_2 ≥ 120°`
(`q_{23} ∈ cl t_2`, `|q_{23} − q2| ≥ 1`), `θ_3 ≥ θ_2 + 60°`; `t_4`'s cone `300° − θ_3` has no lower bound of that kind (it is inner for no edge).
- **SIDES clause 1** reads only `t_1` and the tiles along its two sides at its corners: **unchanged, TRUE**.
- **D2T.** `q1 ∈ cl t_2` needs `t_2 ⊂ B̄(q1, 1)`, i.e. `θ_2 ≤ 120°`: so `q1 ∉ cl t_2` **iff `t_2`'s cone exceeds `60°`**; at `θ_2 = 120°`, `q_{23} = q1` and
  `q1 ∈ cl t_2` is **forced** (inner centre): D2T's first clause is **FALSE** in that subcase, and colour 2 is present at `q1`. (In the bowtie `t_2`'s cone is
  also `60°`, but its counter-clockwise edge is an arc of `ω(q3)` with `t_2` outer, which curves away and keeps `t_2`'s points `s·e(120° − δ)`, `s > 2 sin δ`,
  more than 1 from `q1`: YB3-D2T; here the edge is an arc of `ω(q1)` with `t_2` inner, and curves the other way.) `q2 ∈ cl t_4` needs `t_4 ⊂ B̄(q2, 1)`: excluded
  when `θ_3 < 240°` (a direction of `t_4` in `(θ_3, 240°)`) and at `θ_3 = 240°` (`q_{34} = e(150°)`, `t_4` outer, its points `s·e(240° + δ)`, `s > 2 sin δ`,
  more than 1 from `q2`); **not excluded when `t_4`'s cone is below `60°`**. With `q1 ∉ cl t_2`, `q2 ∉ cl t_4`, UPDOWN gives "2 absent at `q1`, 4 absent at
  `q2`" (`t_2` has `60°⁺`, `t_4` has `300°⁻`).
- **SIDES clause 2.** `X1 ≠ t_3, t_4` and `X2 ≠ t_2, t_3` always (diameter and REGION); `X1 = t_2` iff `t_2` borders all of `S1` (E1 on `S1`, possible only when
  `t_2`'s cone is `60°`), `X2 = t_4` iff `t_4` borders all of `S2` (E1 on `S2`, only when `t_4`'s cone is at most `60°`). Outside those, `X1, X2` have points
  within `< 1` of `p` and are not tiles at `p`: `{c(X1), c(X2)} = {5, 6}` **TRUE**.
- **W.** YB3-W's steps 1–4 run unchanged when `{c(X1), c(X2)} = {5, 6}` (`t_2` has `60°⁺` and `t_4` has `300°⁻`, which is all the Pointing they use; "simple"
  separates `W1` from `X1` across `T1`): **one tile `W` of colour 3, the colour of `t_3`, the tile opposite `t_1`** — **TRUE** there. In the subcase `t_4`'s cone
  below `60°`, `t_3` has directions in `(240°, θ_3)`, within `90°` of the arc point `e(−30° + κ)`, so colour 3 is blocked near `q2` and W's conclusion
  cannot hold as stated.
- **"The stop at `√3` is not inherited"** — a reading about a proof, **TRUE as such**: FS114-Y4-DIAG's steps 1–3 (the colours at `top`, the forced sliver `V`
  at `q1`, `X1` starting at `60°`) read `X4` along the second Reuleaux triangle's side and that triangle's pointing at `top`; without it no step forces the
  sliver, and the germ condition at `r` (Y3-R with YB2-RPREC) then leaves more than one colour. It is not a claim that the pattern extends past `√3`.

So: **SIDES, D2T and W hold unchanged whenever `t_2`'s cone exceeds `60°` and `t_4`'s is at least `60°`**; the two boundary subcases (`t_2`'s cone exactly
`60°`, where D2T's first clause is false; `t_4`'s cone below `60°`) are not covered by the "unchanged" proofs — **GAP** unless excluded elsewhere.

### Summary of stage 1b

| # | statement | my verdict | what the proof uses that the words omit |
|---|---|---|---|
| 1 | E1FORM | **TRUE** | L60-EQ; REG60; simple not used |
| 2 | E1Q3 | **TRUE** (no E2 at `t_3` not used) | every cone below `180°` (edge curvature) |
| 3 | E1OMEGA | **TRUE**, "just above `270°`" read as CASE's `Z` at `q_4` | edges 3, 4 below `60°`; no E2 at `t_4`; simple |
| 4 | E1CAP | **TRUE** but `λ_3 = α_3 − 60°`: **GAP** (the wrap of `μ_2`) | a Jordan curve through `T_4` and `t_2`; no E2 at `t_3`, `t_4` |
| 5 | E1K1 | **TRUE**; "`T_4` fills the corner" is implied by "a tile of colour `m_2` at `q_1`" | ALT(`μ_1`, `μ_2`); CASE (A) at `q_3` |
| 6 | E2RED | chain **TRUE**; survivors by my derivation: **F2 alone**; "all with `t_{c+1}` short of the tangent": **GAP** (a full wrap of `Λ_c`) | YB5-E2-60; PXKILL at `k = c + 1` on F0 |
| 7 | HALF | **TRUE** when `t_2`'s cone `> 60°` and `t_4`'s `≥ 60°`; **GAP** at the two boundary subcases (D2T's first clause FALSE at `t_2 = 60°`) | — |

**Residues** (the instance's question, answered from my side before reading Y6): the E1 chain misses exactly (i) `α_2 = 60°` (then PIN120-60's step 2 is YB4's
GAP: `(60°, 60°, 120°, 120°)`), (ii) `M_1` bordered by two tiles (`μ_1` and a `ν` of colour `m̄_1`, where `m_1 = m_2`), (iii) a tile of colour `m_2` at `q_1`
between `T_1` and `μ_1`, and, outside the kill, (iv) the wrap of `μ_2` at `q_3` (E1CAP's `λ_3`); plus E1 at two or more edges, and E1 with E2. E2's chain misses F2
and, inside it, the full wrap of `Λ_c` at `q_c`.

## Stage 1b — SAVED

## Stage 1c — SAVED: my exact checks, their calibration, and the plants

### 1c.1 Calibration of the object checker this round leans on (`yb3-calib-rerun.out`, exit 0)

FS114-YB3's checker, **run unedited** (`python3 tools/fs114_yb3_run.py calib` under `scripts/slot.py --mem 4 --cpus 1`): brick **ACCEPT** 11/11 pairs
examined, hexagonal seven-colouring 7/7, the strip 82/82, the disk 71/71, FS112-BOWTIE 21/21; each plant beside its faithful twin rejected exactly the
predicted pairs; CALIBRATION PASSED. **No object is given by formula in my instance** (the seven statements are theorems about every valid map), so no
rebuild is checked by it; the template's "rebuild it from its stated rule" has nothing to act on this round.

### 1c.2 My named-point checker `tools/fs114_yb5_check.py` (`check.out`, exit 0; first run `check-run1.out`)

*Method:* exact arithmetic in `ℚ(√3)` (`a + b√3`, Fractions, the sign decided by `a²` against `3b²`), directions as `e(30k°)` times rational
Pythagorean rotations (`5.72°`, `11.42°`, `36.87°`); every verdict is a squared distance against 1, printed `<1`, `=1` or `>1`; predictions registered in
the docstring before the first run. **Run 2: 31 of 31 as registered:**
- controls: the brick's cell diagonal, the side-`1/2` hexagon's diameter and the Reuleaux width, each `=1`;
- E1FORM: points of the cap's corner cone at `p` outside `B(q_1, 1)` (F1a, F1b), a direction past `ω(q_1)`'s tangent inside it (F1c), one past the Reuleaux
  corner outside `B̄(q_4, 1)` (F1d); at `α_2 = 120°` edge 2's point `> 1` from `q_4` (F2);
- E1OMEGA: `Z` within `< 1` of `w_4` (O1) and of `t_3`'s point (O2), `> 1` from `q_1` (O3);
- E1CAP: `Z_1` within `< 1` of `q_4` (K1); a point of the lens outside the ring inside `B̄(q_1 + q_4, 1)` (K2a–c); `t_4`'s directions `84.28°` and `215.72°`
  inside `B(q_1, 1)`, `B(q_4, 1)` (K3a, K3b), and `150°` outside both (K3c, control);
- E1K1: a point at `q_1` in direction `60°` more than 1 from `q_4` and from `Ω`'s point (X1a, X1b: colour `m_2` not blocked there); the corner direction
  `335.72°` at `q_4` within `< 1` of `q_1` (X2); `|v_2 − q_2| < 1`, `|v_2 − v_3| > 1` at `α_2 = 90°` (X3a, X3b);
- YB5-E2-60: two non-corner boundary points of a width-1 Reuleaux triangle `< 1` apart (R1), a corner against the opposite arc `=1` (R2);
- HALF: at `t_2`'s cone `60°` the point `(1/4)e(114.28°)` is outside `B̄(q1, 1)` and outside `B̄(q3, 1)` — the curvature flip between the two patterns (H1a,
  H1b); at `θ_3 = 240°` `t_4`'s point `(1/4)e(245.72°)` is `> 1` from `q2` (H2); at `θ_3 > 240°` a point of `t_4` is `< 1` from `q2` (H3); `t_3`'s point
  `(1/10)e(245.72°)` is `< 1` from `W`'s point near `q2` (H4).
**Plants, each failing exactly its predicted check for its own reason** (`check-plant-*.out`, exit 0): `ell0` (w4 at `Z`'s own angle, distance²
`1 + s²`) fails O1; `q4wrong` (`α_1 = 71.42°`) fails K1; `near` (`s = 1/20 < 2 sin 5.72°`) fails H1a; `side` (`t_4`'s direction on the wrong side of edge
4's tangent) fails K3b.
**Run 1, recorded (`check-run1.out`): 30 of 31, mine, not the statements':** H4's probe `(101/100)e(335.72°)` sat exactly `90°` from `t_3`'s direction
`245.72°` (the boundary of the Pointing window), so it read `>1`; run 2's probe (a direction of `W` at `q2`) was registered before the run. The checks
confirm the inequalities at named values; the proofs are stage 1b's derivations.

## Stage 1c — SAVED

## Stage 2 — SAVED: FS114-Y6's record read and compared (opened only after stage 1's commit `ffdd1cdf`)

### 2.1 The quotation check, completed; the side's check re-run

- **The seven statements: 7 of 7 FOUND** verbatim in `plans/FS114-Y6-construction.md`'s theorem table (`quotes-stage2.tsv`, `quotes-stage2.out`, exit 0,
  FS114-YB's tool unedited).
- `tools/fs114_y6_e1.py`, re-run unedited under `scripts/slot.py` (faithful and `--plant`): **outputs identical** to the committed `e1.out` and
  `e1-plant.out` but for the slot's admission line (`y6-e1-rerun.out`, `y6-e1-plant-rerun.out`). Replication, not independence.
- **Label map** (the side's → mine): the side's frame is `q_4 = e(0°)`, `q_1 = e(60°)` — mine rotated by `+60°`; so the side's "directions just above
  `270°`" at `q_4` are my `210°⁺`, **my stage-1 reading of E1OMEGA was right** (edge 4's side cone, just outside the ring clockwise). The side's `Y` (at `q_1`,
  just above `330°`) is my `Z_1`; its `K⁺` is my `Reul(q_4, q_1, q_1 + q_4) ∖ B(p, 1)`; its cases (a)/(b) on `M_1` are my case (ii)'s two branches; its `Z` (E1K1) is
  my `X`. **E2:** the side takes `c = 2` (E2 at `t_3`), I took `c = 1`; my cones `(α_1, α_2, α_3, α_4)` are its `(α_2, α_3, α_4, α_1)`. So my F0 is its **S1**,
  F1 its **S2**, F4 its **S3**, F3 its **S4**, F2 its **S6**; its **S5** `(60°, 180°, 60°, 60°)` is my excluded all-three-`60°` case with a `180°` cone.
- **Ban touch (the side's, disclosed in its log, ruled by the owner):** a 5° grid check of the E2 case split; nothing rests on it, and nothing of mine does.

### 2.2 The two derivations compared

| # | statement | the side's route (address) | mine (address) | divergence |
|---|---|---|---|---|
| 1 | E1FORM | L60-EQ, the cap's corner cone, `α_1 ≥ 60°`; `α_2 < 120°` by edge 2 against `q_4` (§2.1) | the same (1b item 1) | **none**; two routes agree letter for letter |
| 2 | E1Q3 | MU, ALT, POCKET read nothing of edge 1; the colour-1 block needs `φ_3 > 180°`, by `|q_3 − w_4| > 1` (§2.2) | the same, the colour-1 block by YB5-CONE180 (1b item 2) | **none of truth**; the side's proof text also asserts `λ_3 = α_3 − 60°` in (A) (not in E1Q3's statement): the wrap GAP (row 4) |
| 3 | E1OMEGA | `Ω` points at `w_4 ∈ cl μ_3`; if `Ω ∋ w_4` then `Ω ≠ μ_3` since `q_3, q_4 ∈ cl μ_3` would give `α_4 ≤ 60°` (§2.3) | `Ω` within `< 1` of `w_4`; `Ω ≠ μ_3` since `|q_3 − q_4| > 1` (1b item 3) | **none**; the same inequality, two phrasings |
| 4 | E1CAP | `Y` (my `Z_1`) is `T_4` in both cases on `M_1`; `α_4 = 120°` from `4 ∈ P_cl(q_1)`; the whole arc from `cl T_4 ∩ cl t_2` connected (simple) and meeting both ends (§2.4 steps 1–6) | the same `Z_1` step; the whole arc by a Jordan curve through `T_4` and `t_2` (case (i) empty) (1b item 4) | **route** at the whole-arc step: the side's is shorter (the contact of an inside and an outside tile lies on `ω(p)`, and a connected subset of the arc meeting both ends is the arc); both valid. **Truth: `λ_3 = α_3 − 60°` is a GAP** — the side pins it by `O_3 ≠ T_2` (§2.2), which bounds the part of the contact `O_3` borders, not the contact: the pocket tile `μ_2` may wrap round `t_4`'s ring corner (FS114-YB4-WRAP). The side's step 7 (at `q_1`: `T_4` exactly `[330°, 30°]`, `T_1` from `30°`, `T_4 \| T_1` a both-kind arc of `ω(q_4)`) is not in the statement; I re-derived it (the only other candidate in `q_1`'s outer gap has colour `m̄_1 = m_2` and points at `q_4`, so it is `Ω`, which misses `q_1`): **TRUE** in case (a) |
| 5 | E1K1 | PXKILL at `k = 1`; "if `T_4`'s sector starts after `30°`, the tile before it points at `q_1`, is not `μ_1`, so has colour `m_2`: no `Z`" (§2.5) | the same kill; "is not `μ_1`" by the cross-cut `γ_T ⊂ T_4` of the lens `B̄(q_4, 1) ∩ B̄(q_1, 1)` (1b item 5) | **reason incomplete, statement unaffected**: the side's "is not `μ_1`" is unargued at this step (its step-6 reason — `μ_1` bordering `L_1` — does not apply to a tile on the far side of `T_4`); my lens cross-cut supplies it. Both records read the exception as "a tile `Z` of colour `m_2` at `q_1`", the corner condition implied |
| 6 | E2RED | what E2 breaks (§3.1); (A) keeps its colour clause because `t_{c+1}`'s two 5/6 neighbours are `μ_c` and `Λ_c`; REDUCE with `q_c` weakened gives S1–S6 (§3.2) | the same breaks; survivors F2 alone (1b item 6) | **(i) truth, the survivor list:** S1 (my F0) is **killed by PXKILL at `k = c + 1`** — the side left it "needs rechecking" (§3.3); its colour step holds (colour `k − 1` blocked on the arc since `α_{k+1} + α_{k+2} = 180°`; colour `k` free on it since `a + b > 180°`), and its other inputs (CASE (A) at `q_{c+1}`, `q_{c+2}`; POCKET at `w_{c+1}`, `w_{c+2}`, `w_{c+3}`, which the side's own §3.2 lists as all it reads) hold. **S2, S3, S4, S5 have `α_{c+1} = 60°`: E2 at a 60° blade, which needs E1 (YB5-E2-60)** — empty; S5 also has a `180°` cone (YB5-CONE180). **Only S6 survives** — Y5-PIN120's exception. "The survivors are S1–S6" is TRUE as a containment, not as a list of survivors. **(ii) truth, "all with `t_{c+1}` short of the tangent": GAP** — the side's (A) colour clause rests on RAINBOW, which forbids a *second* 5/6 tile, not `Λ_c` itself wrapping round `r_c` to `q_c`; that full wrap imposes no cone condition (the cone list is unchanged) but has `λ_c > 0`. **(iii) wording:** "PXKILL at `k = c + 1` reads no pocket beside `t_{c+1}`" — it reads POCKET at `w_{c+1}` (`μ_c`, the pocket on `t_{c+1}`'s counter-clockwise side); it reads none on its clockwise side, where E2 breaks POCKET. The side's own §3.2 says it correctly |
| 7 | HALF | "They read only `t_1`, its two tactic tiles and the sectors at `p` of the tiles beside it. Every tile at `p` has a cone of at least `60°`, so `t_2`'s sector contains the directions near `120°` and `t_4`'s those near `270°`, which is all D2T uses." (§4.2) | TRUE when `t_2`'s cone `> 60°` and `t_4`'s `≥ 60°`; GAP at the boundary subcases (1b item 7) | **truth:** (a) "every tile at `p` has a cone of at least `60°`" is REG60's, which holds for tiles **inner** for an edge; `t_4` is inner for none, and nothing held bounds its cone below; (b) D2T does not use only first-order directions: its step (`s·e(120° − δ)` with `s > 2 sin δ` inside the tile) needs the edge at `120°` to curve **away** from `q1`. At `t_2`'s cone exactly `60°` the edge is an arc of `ω(q1)` with `t_2` inner, the curvature flips (my H1a/H1b), and **`q1 ∈ cl t_2` is forced** — D2T's first clause is FALSE there. At `t_4`'s cone below `60°`, `q2 ∈ cl t_4` is not excluded, and (a new step, below) the configuration with `{c(X1), c(X2)} = {5, 6}` is **empty**: `W`'s tile at `q2` has no colour. "The stop at `√3` is not inherited": both records read it as a statement about the proof's reach — agree |

### 2.3 One step added at stage 2: HALF's second boundary subcase [hand; mine]

**YB5-HALF4.** *In a Reuleaux `(2, 1, 1, 0)` pattern (1b item 7's frame), if `t_4`'s cone is below `60°` then `X1 = t_2` or `X2 = t_4`* — so SIDES' clause 2 fails, or
no such fragment exists. *Proof.* Suppose `X1, X2` are 5/6 tiles. `t_3`'s sector reaches `θ_3 > 240°`, so `t_3` has directions within `90°` of `330°`: colour
3 is blocked near `q2` (my H4) and `t_3 ∌ q2`. The tile `W2` at `q2` just outside the ring arc (direction `60°⁻`): not 1 (`t_1`), not 2 (`t_2` has `60°⁺`, within `90°`
of `−30° + κ`), not 3 (blocked), not 4 (`t_4` has `300°⁻`), not `c(X1)` (it points at `q1`, so it would be `X1`, which has points more than 1 from `q2`), not
`c(X2)` (`X2` is at `q2` in another sector, `t_1` and `T2` between). No colour. ∎ With `X2 = t_4` (E1 on `S2`) the tile `W` has the 5/6 colour `c̄(X1)`, not 3.

### 2.4 Verdicts after the comparison

| # | statement | verdict | minds |
|---|---|---|---|
| 1 | E1FORM | **TRUE** | two, one blind (Y6; YB5) |
| 2 | E1Q3 | **TRUE** (its "no E2 at `t_3`" is not used) | two, one blind |
| 3 | E1OMEGA | **TRUE** | two, one blind |
| 4 | E1CAP | **TRUE except `λ_3 = α_3 − 60°`: GAP** (the wrap of `μ_2` round `t_4`'s ring corner, FS114-YB4-WRAP, not excluded by either record); every other clause TRUE by two routes at the whole-arc step | two, one blind; the GAP mine |
| 5 | E1K1 | **TRUE**; its "and `T_4` fills the corner" is implied by the other condition (both records); the side's "is not `μ_1`" step completed by the lens cross-cut | two, one blind |
| 6 | E2RED | **TRUE** as to what E2 breaks and the exclusion of `P_x`; **"the survivors are S1–S6": TRUE as a containment, sharpened to S6 alone** (S1 by PXKILL at `k = c + 1`; S2–S5 by YB5-E2-60; S5 also by YB5-CONE180); **"all with `t_{c+1}` short of the ring's clockwise tangent at `q_c`": GAP** (a full wrap of `Λ_c`) | the chain two minds, one blind; the sharpening and both GAPs one mind (mine) |
| 7 | HALF | **MISSTATED**: TRUE with the hypothesis "`t_2`'s cone exceeds `60°` and `t_4`'s is at least `60°`"; at `t_2`'s cone `60°` D2T's first clause is FALSE; at `t_4`'s below `60°` the configuration with SIDES' clause 2 is empty (YB5-HALF4); the side's justification ("every tile at `p` has a cone of at least `60°`"; "the directions near `120°` … is all D2T uses") does not hold for `t_4` and misses D2T's curvature step | two, one blind, for the corrected statement; the correction mine |

**Are the residues Y6 names exactly what its chain misses?** **E1:** E1-Z, E1-60, E1-ν match my (iii), (i), (ii) exactly, and both records list E1 at two
edges and E1 with E2 as untreated; **one more**, outside the kill: the wrap at `q_3` (E1CAP's `λ_3`), which the side treats as derived. **E2:** the chain misses
**S6 alone**, not S1–S6; and inside S6 (and in every E2 case) the full wrap of `Λ_c` at `q_c`, which the side's "(B′) only" does not name.

### 2.5 A family that failed (template item 3)

No family was constructed this round (Y6 built nothing; its "would-have-searched" log says so). S1–S6 are derived normal forms, not a search image: their free
parameters are the cones (one or two per family) and, unconstrained by either derivation, the edge lengths and pocket shapes. **The reasons each fails, where
it fails:** S1 by one reason for every member (PXKILL at `k = c + 1`: `T_{c+1}` and `O_{c+2}` straddle beside `μ_{c+1}`), S2–S5 by one reason for every member
(YB5-E2-60), neither the side's; S6 fails for no reason either record has.

### 2.6 Proposed edits for the close (standing rule 7: I edit none of these files)

- `LEDGER.md` § B and FS-114's derivation file: FS114-Y6-E1FORM, -E1Q3, -E1OMEGA, -E1K1 at **two minds, one blind** (Y6; YB5); -E1CAP likewise **with
  `λ_3 = α_3 − 60°` marked GAP** (the wrap); -E2RED with its survivor list **sharpened to S6** and "short of the tangent" marked GAP; -HALF **corrected** to
  "when `t_2`'s cone exceeds `60°` and `t_4`'s is at least `60°`"; YB5-E2-60, YB5-CONE180, YB5-CAP2, YB5-F0 (= S1's kill), YB5-HALF4, YB5-CHK.
- `plans/FRONTIER-STUBS.md`, FS-114's row: the pinwheel's residues are E1-Z, E1-60, E1-ν (plus E1 at edges `{1, 2}`, `{1, 4}`, E1 with E2) and, under E2, the one
  family S6 `(120°, b, 180° − b, 60°)` (E2 at the blade two past the `120°` tile, Y5-PIN120's exception); the wrap at a (A)-centre is a standing GAP of the
  chain (YB4-WRAP), now in E1CAP's `λ_3` and in E2's "short of the tangent" too.
- FS114-Y4-SIDES / YB3-D2T / Y4-W as used for the Reuleaux `(2, 1, 1, 0)`: cite them with the cone hypothesis.
- No bibliography rows: nothing new was read.

## Stage 2 — SAVED
