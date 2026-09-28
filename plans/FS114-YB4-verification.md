# FS114-YB4 — blind verification of FS-114's construction side, round 5 (FS114-Y5: the pinwheel)

*Job FS114-YB4, de Bruijn on Opus 5.5, launched 2026-09-28 about 11:56 UTC. Brief: the template `data/fs114/briefs/YB114-verify-construction.md`
with the instance `data/fs114/briefs/YB4-114-instance.md` (read from disk; its changes win) and `data/fs114/briefs/STANDING-RULES.md` (rule 0 first).
Resuming check: no record, working directory or tool of this job existed at start. Working files `data/fs114/fs114-yb4/`; tools
`tools/fs114_yb4_*.py`; scratch `scratchpad/fs114-yb4/` (regenerable only). Every statement about a valid map is about a possible object: the class
is not known to be non-empty. Stage 1 (my verdicts) is committed before I open `plans/FS114-Y5-construction.md`, `data/fs114/fs114-y5/` or
`tools/fs114_y5_*`.*

## Theorems this phase proved

*(Filled at the end of stage 1b and after stage 2.)*

## Would have searched here (standing rule 3)

| stage | move I would have made by search | what I did instead |
|---|---|---|
| 1b | enumerate colour assignments at `q_k`, `v_{k+1}`, `r_k` for pinwheels to see which survive | derived each colour's blocking from the tile at `p` or the pocket tile that points at the vertex (Pointing), one colour at a time |
| 1b | sample cone quadruples `(α_1, …, α_4)` and test each | derived the pair-sum bound and summed the four pairs (REDUCE) |
| 1b | build a both-(B) alternating fragment by formula to see whether it survives | none built: recorded as a GAP in my derivation, to be read against the side's argument in stage 2 |
| 1c | scan `(s, s′)` for where PXKILL's pair crosses 1 | derived the closed form and checked it at three named `(s, s′)` |

## Fence log (standing rule 13; the template's and the instance's fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): lines naming milestone status and standing rules; nothing about FS114-Y5's statements
   or proofs. No file under that path was opened by me. One of my own reads (`plans/FS114-Y4-construction.md` by `cat`) was too long for the
   terminal, and the harness saved its output under that path; I did not open the saved copy and re-read the file with the Read tool instead.
2. **The harness's start-up git snapshot** printed five commit subjects (`FS114-Y5: report`, `FS-114 inventory`, `FS114-Y5: stage 4 (wording)`,
   `FS114-Y5: stage 4`, `FS114-NB6: stage 1a`) and FS-111's untracked `data/fs111/fs111-w/*.out` names. Subjects and names only.
3. My start-up `git log --oneline -8` printed one subject beyond the snapshot (`f606c30c FS-114 inventory; verifier instance`) and two older FS-111
   subjects (`FS111-M3: stage 2 …`). Subjects only; no further `git log`, no `git log -p`.
4. `ls data/fs114/ data/fs114/briefs/` listed by **name** the fenced directories (`fs114-n` … `fs114-n6`, `fs114-nb*`, `fs114-y5`, `fs114-cv*`,
   `reports`) and briefs (the proof side's, the verifiers', `Y5-114-construction-round5.md`, …). `ls tools/fs114_yb*` listed only the YB tools. Nothing
   fenced opened, listed inside or grepped.
5. `plans/FS114-L60-audit.md` (open to me by the instance) was read at its header, theorem table and fence log only (lines 1–60); its later sections
   discuss proof-side records and were not read.

## Stage 1a — SAVED: reading; the quotation check

### 1a.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` **in full**, rule 0 first (`CLAUDE.md` § The aim and § Counter-priors, in context from disk at start-up); the template and the
  instance **in full**.
- `CLAUDE.md` G83, G79, G71, G46, G22, G21, G20, G51 (the session's load at start-up). `LEDGER.md` rows 133–136 **in full**.
- `data/fs114/claims.md` **in full**. `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ and stage 5b **in full**; **5.3 not read**.
- `data/fs114/briefs/Y114-construction.md` **in full** (its § Reading's sources — FS-112's close, the printed local NOs, the Google group, two papers —
  are **not re-read this round**; what bears on the pinwheel is in the FS-112 entries and round records below).
- The round cards `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` **in full**.
- `plans/FS114-Y4-construction.md` **in full**; `plans/FS114-YB3-verification.md` header, theorem table, fence log, stage 1a and stage 1b through
  YB3-W (lines 1–160); `plans/FS114-YB2-verification.md` by headings only (its content reaches me through YB3 and Y4, which cite it).
  Tools: `tools/fs114_yb_quotes.py` header (run unedited).
- `plans/FS112-derivation.md`: header, FS112-WALK, FS112-U1, FS112-SIX, FS112-NB4P, FS112-A4SIX, FS112-L60, FS112-LOCK's statement, FS112-N3-NOBOTH,
  N3-FAIL, N3-ANTI, **FS112-N3-COR3**, N3-PAIRS entries **in full** (lines 1–70, 140–168).
- `plans/FS114-L60-audit.md`: header, theorem table and fence log (lines 1–60).
- **Not read:** every fenced file.

### 1a.2 The quotation check (standing rule 5) — `data/fs114/fs114-yb4/quotes.tsv`, through FS114-YB's `tools/fs114_yb_quotes.py` unedited

**16 of 16 FOUND** (`quotes.out`, exit 0): the standing rules' five Kooshi quotations (rules 0, 3, 4, 10); the instance's "at most 60°" and L60-LE in
`plans/FS114-L60-audit.md`; the instance's definition of **simple** against `plans/FS114-Y4-construction.md`'s header (the one unfenced file carrying it);
the Siamese and valid-map definitions, C114-LOCAL-F and the claim list's "possible object" sentence against `data/fs114/claims.md`; FS112-U1 against
`plans/FS112-derivation.md`; K1-PIN against the round-4 card; K1 against the round-2 card; Y2-GAPS against the round-3 card. The tool's self-test PASSED
(`quotes-selftest.out`); my two plants (one word changed in SIMPLE; FS112-L60 read as "at most" in FS-112's own file, which says "below") read
**MISSING** (`quotes-plant.out`, exit 1).

**Not checkable in stage 1:** the twelve statements, copied by the owner's script from `plans/FS114-Y5-construction.md` (fenced until stage 1 is
committed): stage 2's first step. The instance's glosses of **tactic edge**, **pinwheel**, **ring** and **non-Siamese** have fenced sources (the proof
side's records) or none; I work them as the instance states them. **Non-Siamese** is read as the instance glosses it (closures at distance at least 1),
the reading FS114-YB2 and FS114-YB3 used; de Grey's words ("tiles that lie entirely within each other's annulus of exclusion") are the same condition.

### 1a.3 Reading points fixed before any verdict (my notation; the instance leaves them implicit)

- `p = 0`; `e(φ)` the unit vector at angle `φ`, counter-clockwise. The pinwheel's edges `e_1, …, e_4` leave `p` counter-clockwise at directions
  `d_1 < d_2 < d_3 < d_4`; blade `t_k` fills the sector `[d_{k−1}, d_k]` at `p` and has colour `k` (four tiles at a vertex of a non-Siamese map have four
  colours). **Orientation:** "blade `t_{j+1}` whose clockwise edge `j`" and "each tile at `p` inner for one edge" force every edge's inner side to be its
  counter-clockwise side (the mirror pinwheel is the reflection): edge `k` is a unit arc of `ω(q_k)`, `q_k = e(d_k + 90°)`, with inner tile `t_{k+1}` and
  outer tile `t_k`; so the tactic tile `T_k` at `q_k` has colour `k` (the outer colour), matching the instance's "`T_k` (`k`)" and "`O_k` (colour `k − 1`)".
- **Cones.** `α_k` is read as blade `t_k`'s sector at `p`, `α_k = d_k − d_{k−1}`, `Σα_k = 360°` ("blade `t_j`, … cones `α_j`"). Centre `q_k` sits between
  `t_k` (cone `α_k`) and `t_{k+1}` (cone `α_{k+1}`); so `|q_{k−1} − q_k| = 2 sin(α_k/2)` and `arg q_k = arg q_{k−1} + α_k`. `φ_k := arg q_k`.
- **Edge ends and sides.** `ℓ_k ∈ (0°, 60°]` is edge `k`'s angular length about `q_k` (L60-LE); `w_k` its far end, `|w_k| = 2 sin(ℓ_k/2)`. Blade
  `t_{k+1}`'s boundary: edge `k` (clockwise), then its clockwise side `L_k` from `w_k` to `q_k` — an **inside part** `L_k^in` from `w_k` to the ring
  point `r_k` where it meets `ω(p)`, then the ring from `r_k` counter-clockwise to `q_k` (angle `λ_k`, "borders the ring clockwise from `q_k` for
  `λ_k`") — and its counter-clockwise side `M_k` from `q_k` to `w_{k+1}`, then edge `k + 1` (where `t_{k+1}` is the outer tile) back to `p`.
- **Pockets.** `P_k` is the region inside `B(p, 1)` bounded by `M_k`, `L_{k+1}^in` and the ring from `q_k` to `r_{k+1}`; `μ_k` (colour `m_k`) the 5/6 tile
  along `M_k`, `Λ_{k+1}` the one along `L_{k+1}^in`. **E1**: some `ℓ_k = 60°`. **E2**: some `M_{k+1} ⊂ ω(w_{k+1})`. **Bordering** means sharing a boundary
  arc of positive length. `v_{k+1}` is read as `e(φ_k + 60°)`, the ring point `60°` counter-clockwise of `q_k`, as the statement writes it; `β_k`, `t`,
  `t′` are not defined in my brief and are read where they occur.

## Stage 1a — SAVED

## Stage 1b — SAVED: my derivations of the twelve statements (blind: no FS114-Y5 file opened)

*Every step is mine, [hand; one mind]. Setting: a non-Siamese valid map (closures of distinct same-coloured tiles at distance at least 1), **simple**
where said, containing a neighbourhood of `B̄(p, 1)`, with a pinwheel at `p` in the orientation of 1a.3. Tools used throughout:*
- **Diameter (TS-C).** A tile's closure has diameter at most 1; so `u ∈ cl Z` gives `Z ⊂ B̄(u, 1)`.
- **Pointing.** If `u ∈ cl Z` and `Z` has the direction `ψ` at `u`, then for `|v − u| = 1` and `cos(ψ − arg(v − u)) > 0`, `Z` has points within `< 1` of every
  point near `v`. At `v` on the ring: **a colour `c ∈ {1…4}` is blocked near the ring point `e(θ)` (both sides) unless its tile is `t_c` itself, whenever
  `t_c`'s open sector at `p` has a direction within `90°` of `θ`** (first order; boundary directions are second order and are only ever used where a
  blocking is not claimed).
- **Tiles at `p` and inside.** Distinct tiles at a vertex have distinct colours; every tile meeting `B(p, 1)` is a tile at `p` or has colour 5 or 6
  (Y2-GAPS). `T_k ∩ B(p, 1) = ∅` (colour `k`, against `t_k ∋ p`), and **`t_k ∩ B(q_k, 1) = ∅`** (against `T_k ∋ q_k`; `T_k ≠ t_k` since `T_k` touches `t_{k+1}`
  at `q_k` alone).
- **U1 at `q_k`** (FS112-U1): `t_{k+1}`'s sector at `q_k` lies in the cone facing edge `k` (width `180° − ℓ_k`), `T_k`'s in the cone facing away; the two side
  cones hold neither. So `t_{k+1}` does not border the ring counter-clockwise of `q_k`, and `M_k` leaves `q_k` into `B(p, 1)`.
- **Simple ⇒ one sector.** In a simple map a tile meets each vertex in one sector, and `cl U ∩ cl t` is connected; a 5/6 tile never has `p` in its closure.
  Hence **(SEP)**: no tile borders both `M_k` and `L_k^in` (the path in `∂t_{k+1}` joining them avoids `p`, so runs through `q_k`, and the tile would have one
  sector at `q_k` containing both the direction just counter-clockwise of `t_{k+1}` and the clockwise ring direction — through `T_k`'s sector, which is
  non-empty); likewise no tile borders `M_k` and `M_{k+1}`.

### 1. FS114-Y5-RAINBOW — **TRUE** [hand; mine]
If `Y ≠ Z` of one colour share arcs `A_Y`, `A_Z` of positive length with a tile `x` (`x` of that colour is excluded at once: it touches `Y`), then for
`y ∈ A_Y`, `z ∈ A_Z`: `|y − z| ≤ 1` (both in `cl x`) and `≥ 1` (non-Siamese), so every point of `A_Y` lies on `ω(z)` for every `z ∈ A_Z` — two distinct
circles meet in at most two points. ∎ No "simple" needed.

### 2. FS114-Y5-REGION — **TRUE** [hand; mine]
`p, q_j ∈ cl t_{j+1}` gives `t_{j+1} ⊂ B̄(p, 1) ∩ B̄(q_j, 1)`; `t_{j+1}` is the outer tile of edge `j + 1`, so `T_{j+1}` has its colour and `q_{j+1} ∈ cl T_{j+1}`,
`T_{j+1} ≠ t_{j+1}` (it touches `t_{j+2}` at `q_{j+1}` alone; `t_{j+1}` borders `t_{j+2}` along edge `j + 1`), so `cl t_{j+1} ∩ B(q_{j+1}, 1) = ∅`. ∎
**Consequence used below (REG60):** `q_j ∈ cl t_{j+1}` needs `|q_j − q_{j+1}| = 2 sin(α_{j+1}/2) ≥ 1`: **every cone is at least 60°**, hence at most 180°.
And `t_{j+1}`'s ring contact lies in `[φ_j − 60°, φ_j + α_{j+1} − 60°]`, so `λ_j ≤ 60°`.

### 3. FS114-Y5-MU — **TRUE, with two precisions** [hand; mine]
*Proof.* Edge `j < 60°` puts `w_j` in `B(p, 1)`, so `L_j^in` has positive length; every tile bordering it at a point of `B(p, 1)` is 5/6 (not `t_j`: the
common boundary of `t_j, t_{j+1}` is edge `j` in a simple map; not `t_{j+2}`, `t_{j+3}`). By U1, `M_k` leaves `q_j` inside `B(p, 1)`, so a 5/6 tile borders
`M_j` near `q_j`. By (SEP) the tiles along `M_j` and along `L_j^in` are different tiles, and by RAINBOW each colour borders `t_{j+1}` through one tile only;
two colours, both sides used: **one colour on each side, one tile each** (if two colours bordered `M_j`, `L_j^in` would have none). A 5/6 tile touching
the ring part of `M_j` is covered too: a second 5/6 tile along `M_j` would be a second colour. ∎
*Precisions.* (i) **"Simple" is used** ((SEP)); the statement's words omit it. (ii) `M_j` must be non-degenerate: it is empty exactly when
`w_{j+1} = q_j`, i.e. `α_{j+1} = ℓ_{j+1} = 60°` (E1 at edge `j + 1`), and then `μ_j` is undefined; and the last clause `w_{j+1} ∈ cl μ_j` needs `M_j` to reach
`w_{j+1}` from inside `B(p, 1)`, which holds when edge `j + 1 < 60°` (at `ℓ_{j+1} = 60°`, `w_{j+1}` is on the ring and `M_j` may arrive along it, bordered
outside). **MU holds as stated when edges `j` and `j + 1` are both shorter than 60°** — always the case in the chain, which runs outside E1.

### 4. FS114-Y5-ALT — **TRUE** (simple; edges `j, j + 1, j + 2` below 60°) [hand; mine]
Suppose `m_j = m_{j+1}`. `μ_j ≠ μ_{j+1}` ((SEP)'s second clause). `w_{j+1} ∈ cl μ_j` (MU at `t_{j+1}`). `M_{j+1} ⊂ cl t_{j+2}` and `w_{j+1} ∈ cl t_{j+2}`, so every
point of `M_{j+1}` is within 1 of `w_{j+1}`; every point of `M_{j+1}` is in `cl μ_{j+1}` (MU at `t_{j+2}`; a ring-running piece of `M_{j+1}` between inside pieces is
bordered by `μ_{j+1}` too, since `cl μ_{j+1} ∩ cl t_{j+2}` is connected), so at distance `≥ 1` from `w_{j+1}`: **`M_{j+1} ⊂ ω(w_{j+1})`, which is E2.** ∎

### 5. FS114-Y5-POCKET — **TRUE** (simple; outside E1 at edges `j, j + 1, j + 2`; outside E2 at `M_{j+1}`) [hand; mine]
**The step at `w_{j+1}`**: by MU at `t_{j+2}`, `L_{j+1}^in` is bordered by one tile `Λ_{j+1}` of colour `≠ m_{j+1}`; by ALT, `m_j ≠ m_{j+1}`; two colours, so
`c(Λ_{j+1}) = m_j`. Both `μ_j` (MU's last clause) and `Λ_{j+1}` (it borders `L_{j+1}^in`, which starts at `w_{j+1}`) have `w_{j+1}` in their closures; two
tiles of one colour sharing a closure point are one tile (non-Siamese). Any tiles between them in the pocket's corner at `w_{j+1}` are irrelevant. ∎

### 6. FS114-Y5-CASE — **TRUE**, with a reading of "the outside tile there" [hand; mine]
Frame: `q_k = e(90°)`, `d_k = 0`; `t_k` fills `[−α_k, 0]`, `t_{k+1}` `[0, α_{k+1}]`, `t_{k+2}` `[α_{k+1}, α_{k+1} + α_{k+2}]`, `t_{k−1}` `[−α_k − α_{k−1}, −α_k]`.
- **(B).** If `λ_k = 0`, POCKET at `P_{k−1}` makes `μ_{k−1}` border `L_k^in` up to `q_k`: `μ_{k−1} ∋ q_k`. Whenever `μ_{k−1} ∋ q_k`: `μ_{k−1} ∋ q_{k−1}` too (MU:
  `M_{k−1}` starts there), so `2 sin(α_k/2) ≤ 1` and REG60 gives **`α_k = 60°`**.
- **(A).** Otherwise `λ_k > 0` and the tile `Z` at `q_k` in the outside direction just past the clockwise ring tangent has colour: not `k + 1` (only `t_{k+1}`,
  inside); not `k` (U1's side cone); not `m_k` (`μ_k ∋ q_k`, and `Z ≠ μ_k` by one-sector); not `m_{k−1}` unless `Z = μ_{k−1}` (then (B)) — `μ_{k−1} ∋ r_k`
  (POCKET) and `Z`'s points near `q_k` are within `< 1` of `r_k` for every `λ_k ≤ 60°` (at `λ_k = 60°`, `(q_k − r_k)·e(δ) = cos(150° − δ) < 0` for
  `δ ∈ (0°, 60°)`); not `k + 2` when `α_{k+1} < 180° − λ_k` (blocked by `t_{k+2}` via Pointing: unblocked only for `θ ≤ α_{k+1} − 90°`). So **`c(Z) = k − 1`**,
  and colour `k − 1` near `q_k` outside needs `α_{k−1} + α_k ≤ 180°` (else `t_{k−1}`'s open sector has a direction within 90° of `90°`). **`λ_k ≥ α_k − 60°`**: `μ_{k−1}`
  holds `q_{k−1}` and `r_k`, `α_k − λ_k` apart. **`λ_k ≤ 60°`**: REG.
- **Every cone ≤ 120°, non-circularly.** Suppose `α_i > 120°`. Then `α_{i−1} + α_i > 180°` blocks `i − 1` at `q_i`, and `α_{i+1} ≤ 360° − α_i − 120° < 120° ≤ 180° − λ_i`
  blocks `i + 2`; so `Z` has no colour, `λ_i = 0`, and (B) gives `α_i = 60°`: contradiction. With every cone ≤ 120°, the `k + 2` exclusion above holds at every
  centre (at `α_{k+1} = 120°`, `λ_k = 60°` the unblocked set is `θ ≤ 30° = 90° − λ_k`, outside the open contact). ∎
- **The reading.** "The outside tile there has colour `k − 1`" is TRUE for the tile at `q_k`, which borders the contact from `q_k` down to at least
  `v_k := e(φ_{k−1} + 60°)` (it cannot come within 1 of `q_{k−1} ∈ cl T_{k−1}`, colour `k − 1`). **Between `r_k` and `v_k` the contact may be bordered outside by
  `μ_{k−1}` itself** — a *wrap* round `t_{k+1}`'s corner `r_k` (`μ_{k−1}`'s sector at `r_k` runs from `L_k^in` clockwise over the ring to the contact, one
  sector, simple) — and nothing in (A)'s derivation excludes it; then `λ_k > α_k − 60°`. (A) holds as stated if its colour clause is read at `q_k`.
- **Where E1/E2 enter:** MU at `t_k` and `t_{k+1}`, POCKET at `P_{k−1}` (edges `k − 1, k, k + 1` below 60°; `M_k` not E2).

### 7. FS114-Y5-REDUCE — **TRUE** given CASE and PIN120-60 (for the open interval) [hand; mine]
Every pair sum `α_{k−1} + α_k ≤ 180°`: in (A) by CASE; in (B) `α_k = 60°` and `α_{k−1} ≤ 120°`. The four pair sums total `720°`, so **each is exactly
`180°`**: the cones alternate `(x, 180° − x, x, 180° − x)` with `x ∈ [60°, 120°]` (REG60, CASE). A (B) centre forces `x ∈ {60°, 120°}`, the alternating member;
so `60° < x < 120°` exactly when the member is excluded (PIN120-60), and then every centre is (A).

### 8. FS114-Y5-PIN120-60 — **partly re-derived; GAP in my derivation at two named places** [hand; mine]
Take `α_1 = 120°`, `α_2 = 60°` (frame `q_1 = e(90°)`, `d_1 = 0`; `t_2 ⊂ B̄(p,1) ∩ B̄(q_1,1) ∖ B(e(150°),1) ⊂ Reul(p, e(30°), e(90°))`, sector `[300°, 360°]` at
`q_1`), `α_3 + α_4 = 180°`.
- **Non-alternating (`α_3 < 120°`), outside E1/E2: excluded** — CASE at `q_1`: (B) needs `α_1 = 60°`; (A) needs `α_4 + α_1 ≤ 180°`, so `α_4 = 60°`, `α_3 = 120°`.
- **The alternating member, outside E1/E2, when some 60° centre (`q_2` or `q_4`) is in case (A): excluded** by the PXKILL pair (item 10) at that centre. At
  `q_4` (A): the clockwise outside tile is the colour-3 tile, which must be `T_3` (its points near `q_4` are within 1 of `q_3`, `|q_3 − q_4| = 1`); colour `m_3` is
  blocked at `q_4` (`μ_3 ∋ r_4`, `λ_4 < 60°` since `λ_4 = 60°` would put `q_3` in `cl t_1 ∩ cl t_4`, so edge 4 = 60°, E1); so no tile sits between `T_4` and
  `μ_4`, `T_4` meets `μ_4` along `ω(e(30°))` outward, and at `e(30°) = v_1` the tiles are exactly `t_2`, `O_1` (colour 4, bordering the whole contact
  `[30°, 90°]`: `λ_1 = 60°` is forced) and `μ_4` (colours 1, 3 blocked by `t_1`, `t_3`; `m_1` by `μ_1`, whose directions at `q_1` just below `t_2`'s start `≥ 300°`
  point within 90° of `e(30°)`). Then item 10's second-order computation applies.
- **Not closed by my steps (1): both 60° centres in case (B)** (`μ_1 ∋ q_1, q_2` and `μ_3 ∋ q_3, q_4`). Then a tile `X` of the colour of the next blade (colour 1
  at `q_2`, colour 3 at `q_4`) may sit at the centre between `T_k` and `μ_k`: at `q_2` every other colour is blocked or already present, and colour 1 is not
  blocked there (`t_1`'s sector `[−120°, 0°]` meets `e(150°)` only at its boundary direction; `T_1`, confined to `[ℓ_1, 120°]` at `q_1`, does not reach it).
  Then `T_2` need not reach the tangent direction `180°`, and the PXKILL pair gives nothing (to first order the two sectors are more than 1 apart,
  `P.rays` in 1c). I found no other contradiction; stage 2 reads the side's argument for this subcase.
- **Not re-derived (2): the E1 and E2 subcases** (the statement claims no exceptions): my steps use MU and POCKET throughout.
- **One more consistency fact** (used in (1)): at a (B) centre `q_2` with `α_2 = 60°`, `μ_1 ⊂ B̄(q_2, 1)` and `t_2 ∩ B(q_2, 1) = ∅`, so `M_1 ⊂ ω(q_2)`: `t_2`'s whole
  counter-clockwise boundary is the arc of `ω(q_2)` from `p` to `q_1`.

### 9. FS114-Y5-PX — **TRUE but for one clause (a GAP)** [hand; mine; P_x has `60° < x < 120°`, every centre in (A), outside E2]
- **"each `q_k` is a degree-4 vertex with exactly the tiles `O_k` (`k − 1`), `T_k` (`k`), `μ_k` (`m_k`), `t_{k+1}`"**: TRUE. Near `q_k` outside, colours `k + 1`, `k + 2`
  are blocked (1c: `B.*.q_k.out`), `m_{k−1}` is blocked (`μ_{k−1}` holds `r_k` or, under a wrap, `v_k`, both within `< 1` of `q_k` since `α_k > 60°`); inside, only
  `t_{k+1}` and 5/6 tiles, and a second 5/6 colour inside at `q_k` would be `m_{k−1}`, blocked. One sector per colour: four tiles.
- **"`μ_k` crosses the ring at `q_k`"**: TRUE (`T_k`'s sector ends at `φ_k + 30°`, below the ring tangent `φ_k + 90°`; `μ_k` fills the rest to `t_{k+1}`).
- **"`T_k`'s sector lies in `[φ_k − 90° + β_k, φ_k + 30°]`"**: TRUE reading `β_k ≥ ℓ_k` (U1 gives `[φ_k − 90° + ℓ_k, φ_k + 90°]`; `T_k ∩ B(v_{k+1}, 1) = ∅` against
  `O_{k+1} ∋ v_{k+1}`, colour `k`, `O_{k+1} ≠ T_k` since `|q_k − q_{k+1}| > 1`, gives the upper end). `β_k` is undefined in my brief.
- **"the pocket colours alternate"**: TRUE (ALT).
- **"`v_{k+1} = e(φ_k + 60°)`"**: TRUE as the point where `O_{k+1}`'s border ends (CASE's reading).
- **"`λ_k = α_k − 60°`"**: **GAP** — it holds exactly when `μ_{k−1}` does not wrap round `r_k` (CASE's reading), and I find nothing in the chain that excludes
  the wrap. It does not matter for PXKILL, which needs only `μ_k ∋ q_k, v_{k+1}` and holds in both cases.

### 10. FS114-Y5-PXKILL — **TRUE** (both the no-wrap and the wrap case) [hand; mine; tools exact at named values]
In `P_x`: `μ_k ∋ q_k` (MU) and `μ_k ∋ v_{k+1}` (POCKET; under a wrap, as the end of `μ_k`'s outside border). **At `v_{k+1}`** the tiles are exactly `t_{k+2}`,
`O_{k+1}`, `μ_k`: colour `k + 1` is blocked (`t_{k+1}` has directions in `(60°, α_{k+1})` in the frame `d_k = 0`, `v_{k+1} = e(150°)`), `k − 1` blocked (`t_{k−1}`'s
directions just past `180°`), `k + 2` is `t_{k+2}` itself, `m_{k+1}` blocked (`μ_{k+1} ∋ q_{k+1}`, `|v_{k+1} − q_{k+1}| = 2 sin((α_{k+1} − 60°)/2) < 1`). **At `q_k`**:
item 9's four tiles. `T_k ∩ B(v_{k+1}, 1) = ∅` and `μ_k ⊂ B̄(v_{k+1}, 1)`, so their common boundary, which leaves `q_k` (they are adjacent), lies on `ω(v_{k+1})`
and leaves outward (tangent `φ_k + 30°`); likewise `O_{k+1}|μ_k` lies on `ω(q_k)` from `v_{k+1}`, outward. With `q = q_k`, `v = v_{k+1}` the points
`A = v + e(φ_k − 60° + s)` (on `T_k`'s arc) and `B = q + e(φ_k + 120° − s′)` (on `O_{k+1}`'s arc) satisfy
**`|A − B|² = 1 + 2(1 − cos s)(1 − cos s′) − 2 sin s sin s′ < 1`** for small `s, s′ > 0`, and interior points `η` off the arcs stay below 1 while
`η + η′ ≲ ss′`: `T_k` and `O_{k+1}`, both colour `k`, are within `< 1` (and, `T_k` having directions within 90° of `v_{k+1} − q_k`, more than 1 too: a straddle,
Siamese or not). ∎ **The contradiction is second order**: along straight rays in the two sectors the points are more than 1 apart (1c `P.rays`);
only the arcs' curvature brings them within 1. The statement's `√(1 − 2tt′)` is this quantity to leading order (`t, t′` undefined in my brief).

### 11. FS114-Y5-PINALL — **TRUE outside E1 and E2, except the one subcase of item 8 (1) that I could not close** [hand; mine]
CASE at every centre (outside E1/E2) → REDUCE → the member `x ∈ (60°, 120°)` dies by PXKILL, the alternating member by PIN120-60 (my derivation covers it
unless both 60° centres are in case (B)). **Are E1 and E2 exactly the cases the chain misses?** In my derivation the chain uses, beyond "non-Siamese"
and "simple" (both in the statement): edges below 60° (MU's `L^in`, MU's non-degenerate `M` and its last clause — all E1) and ALT (E2). **Nothing else,
except the both-(B) alternating subcase if PIN120-60 does not cover it.** The wrap of CASE's reading changes no step PINALL uses.

### 12. FS114-Y5-PIN120 — **TRUE outside E1 and E2 (modulo item 8 (1)); its stronger form not re-derived** [hand; mine]
A 120° cone forces, by REDUCE, the alternating member, which PIN120-60 excludes. The statement claims more (E1 allowed, E2 only "at the blade two past the
120° tile"); "K1-PIN120" is not defined in my brief. I did not derive the E1 case.

### Summary of stage 1b

| # | statement | my verdict | what it uses that its words omit |
|---|---|---|---|
| 1 | RAINBOW | TRUE | — |
| 2 | REGION | TRUE (and REG60: every cone ≥ 60°) | — |
| 3 | MU | TRUE with precisions | simple; `M_j` non-degenerate and its last clause need edge `j + 1 < 60°` |
| 4 | ALT | TRUE | simple; edges `j, j + 1, j + 2` below 60° |
| 5 | POCKET | TRUE | simple; outside E1 at those edges |
| 6 | CASE | TRUE (colour clause read at `q_k`) | the wrap between `r_k` and `v_k` |
| 7 | REDUCE | TRUE given CASE and PIN120-60 | — |
| 8 | PIN120-60 | partly; GAP in my derivation at the both-(B) alternating subcase and at E1/E2 | — |
| 9 | PX | TRUE but `λ_k = α_k − 60°` a GAP (the wrap) | `β_k` undefined |
| 10 | PXKILL | TRUE (second order; wrap included) | — |
| 11 | PINALL | TRUE outside E1/E2 but for item 8's subcase | — |
| 12 | PIN120 | TRUE outside E1/E2 (modulo item 8); stronger form not derived | — |

## Stage 1b — SAVED

## Stage 1c — SAVED: my exact checks, their calibration, and the plants

### 1c.1 Calibration of the object checker this round leans on (`yb3-calib-rerun.out`, exit 0)

FS114-YB3's checker, **run unedited** (`python3 tools/fs114_yb3_run.py calib` under `scripts/slot.py --mem 4 --cpus 1`): brick ACCEPT 11/11 pairs examined,
hexagonal seven-colouring 7/7, the strip 82/82, the disk 71/71, FS112-BOWTIE 21/21; each plant beside its faithful twin rejected exactly the predicted
pairs. No object is given by formula this round (the twelve statements are theorems), so no rebuild is checked by it.

### 1c.2 My named-point checker `tools/fs114_yb4_pin.py` (`pin.out`, exit 0; first run `pin-run1.out`)

*Method:* exact arithmetic in `ℚ(√3)` only (`a + b√3`, Fractions; sign decided exactly), small angles as rational rotations — a different method from
FS114-YB3's (intervals and minimal polynomials) and FS114-YB2's (towers). *Controls:* the brick's cell diagonal and the hexagon's diameter exactly 1,
the Reuleaux width, YB3's SIDES identity `9/25`, four signs of the form `a − b√3`. **Run 2: 53 of 53 as registered**:
- REG60 at named cones (`α = 60°`: `= 1`; `11.4°`: `< 1`; `90°`: `> 1`).
- PXKILL at three `(s, s′)`: points **on** the two arcs `< 1`; the formula `1 + 2(1 − c)(1 − c′) − 2ss′` exact; interior points pushed off by `ss′/4` each
  `< 1` and lying outside `B(v, 1)`, `B(q, 1)` as `T_k`, `O_{k+1}` must; **straight rays in the two sectors `> 1`** (the conflict is second order).
- Blocking at `q_k` and `v_{k+1}` at `x = 90°` and at `α_k = 90° ± θ`, `cos θ = 12/13`: colours `k + 1`, `k + 2` blocked outside `q_k`, `t_k`'s near-`p` points do not
  block there; colours `k + 1`, `k − 1` blocked at `v_{k+1}`; `|v_{k+1} − q_{k+1}| < 1`, `|v_k − q_k| < 1`; colour `k − 1` blocked at `q_k` when the pair sum
  exceeds 180°.
- **Plants, each flipping exactly its predicted set:** `firstorder` (the pair along straight rays: every arcs/formula/interior verdict flips), `far` (O's
  arc pushed out by `1/20`: the same nine), `wrongv` (`v` 90° from `q`: those nine and `|q − v|`), `signflip` (the mixed-sign branch reversed: exactly the
  13 verdicts whose decisive sign went through that branch, the four sign controls among them).

**Run 1, recorded (`pin-run1.out`): 48 of 53, and two plants NOT AS PREDICTED — all mine, none the statements'.** Five probe-design errors: at `x = 90°` I
used a `t_{k+1}` witness direction (53.1°) outside the blocking window `(60°, α_{k+1})`; four probes sat `1/50` off the ring, more than the first-order margin
of their witnesses (`2s cos(…) ≈ 0.003`–`0.02`), and one witness direction was a sector boundary. Run 2 moved the probes to `1/2000` and `1/20000` and the
directions inside their windows, registered before the run. The `signflip` prediction named only the four sign controls although the branch decides
other verdicts too (run 2 predicts structurally: exactly the verdicts decided in that branch), and `far`'s prediction omitted that the plant moves the
on-arc point as well as the interior one.

### Theorems this phase proved (stage 1)

| id | statement (one line) | grade, minds | address |
|---|---|---|---|
| YB4-RAINBOW, -REGION, -MU, -ALT, -POCKET, -CASE, -REDUCE, -PX, -PXKILL | the nine statements as verdicted in 1b (MU with two precisions; CASE's colour clause at `q_k`; PX's `λ` clause a GAP) | hand; mine, blind | 1b items 1–7, 9, 10 |
| YB4-REG60 | every cone of a non-Siamese pinwheel is at least 60°, and `λ_k ≤ 60°` | hand; mine | 1b item 2 |
| YB4-SEP | in a simple map no tile borders both `M_k` and `L_k^in`, nor both `M_k` and `M_{k+1}` | hand; mine | 1b preamble |
| YB4-CONE120 | every cone ≤ 120°, by an argument at the centre after the large cone (no circularity with CASE's colour clause) | hand; mine | 1b item 6 |
| YB4-WRAP | outside E1/E2, `O_k` borders `t_{k+1}`'s ring contact exactly from `q_k` down to `v_k = e(φ_{k−1} + 60°)`; `μ_{k−1}` may border `[r_k, v_k]` from outside, and then `λ_k > α_k − 60°` | hand; mine | 1b items 6, 9 |
| YB4-2ND | PXKILL's contradiction is second order: `|A − B|² = 1 + 2(1 − cos s)(1 − cos s′) − 2 sin s sin s′` on the arcs, `> 1` along straight rays | hand + tools exact (1c.2) | 1b item 10; `tools/fs114_yb4_pin.py` |
| YB4-P120 | PIN120-60 outside E1/E2 except when both 60° centres are in case (B) | hand; mine | 1b item 8 |
| YB4-CHK | an exact `ℚ(√3)` named-point checker: 53 of 53 as registered, four plants each flipping exactly its predicted set | tools | 1c.2 |

## Stage 1c — SAVED
