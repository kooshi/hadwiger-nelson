# FS114-Y6 — the construction side of FS-114, round 6 (the pinwheel's E1 and E2; the `(2, 1, 1, 0)` patterns; three tactic edges)

*Job FS114-Y6 (de Bruijn, Opus 5.5), 2026-09-28, from `data/fs114/briefs/Y6-114-construction-round6.md`, the cards `ROUND2-card.md`, `ROUND3-card.md`,
`ROUND4-card.md`, FS114-Y's brief `Y114-construction.md` and `STANDING-RULES.md` (all read in full, rule 0 first). Working files `data/fs114/fs114-y6/`;
exact checks `tools/fs114_y6_*.py`; my scratch `scratchpad/fs114-y6/` (regenerable only). Resuming check: no record, working directory, tool or report
of this job existed at start. Every statement about a valid map is about a possible object: the class is not known to be non-empty.*

*Notation.* FS114-Y5's (`plans/FS114-Y5-construction.md`, header and §3): `p = 0`, `e(φ)` the unit vector at angle `φ`, angles at a point are
directions from it, counter-clockwise from the positive `x`-axis; a tile's **sector** at a vertex is the closed cone of directions it fills there;
`ω(u)` the unit circle about `u`, `B(u, 1)` the open unit disc; **the ring** is `ω(p)`. In a pinwheel the tactic centres are `q_j = e(φ_j)`
(counter-clockwise), `α_{j+1} = φ_{j+1} − φ_j`; edge `j` leaves `p` at `θ_j = φ_j − 90°` along `ω(q_j)` and ends at `w_j`, of length `β_j` at `q_j`;
`t_{j+1}` (colour `j + 1`) has sector `[θ_j, θ_{j+1}]`, inner for edge `j`, outer for edge `j + 1`; `T_j` the tactic tile of colour `j` at `q_j`.
The blade `t_{j+1}`'s sides: `L_j` (from `w_j` to `q_j`), `M_j` (from `q_j` to `w_{j+1}`); `μ_j` the inner-gap tile at `q_j` next to `t_{j+1}`.

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| FS114-Y6-QT | every quotation of my brief set and of this record is found at its source (30 of 30); the self-test's plant fires | [tools] | §1.2; `tools/fs114_y6_quotes.py` |

## Would-have-searched-here log (standing rule 3)

(one line per move, filled as they occur)

## Fence log (standing rule 13; the brief's § Fences)

1. The harness's start-up context (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): its lines name FS-112's and FS-114's milestone status and standing rules; no proof
   content. No file under that path was opened by me.
2. The harness's start-up `git status` named FS-111's untracked `data/fs111/fs111-w/*.out` and my brief; five commit subjects. Names only.
3. At start-up `ls data/fs114/briefs/` and `wc -c data/fs114/briefs/*` listed every brief's file name and size (the proof side's `N*-114-*.md`, the
   verifiers' `NB*`, `YB*`, `CV*`, the advisor's, `L60-114-audit.md`); `ls plans/FS114-*` listed the fenced record names (`FS114-N*-proof.md`,
   `FS114-NB*-verification.md`, `FS114-CV*-verification.md`, `FS114-close-inventory.md`); `ls tools/fs114_*` listed the fenced tool names
   (`tools/fs114_n*`, `tools/fs114_nb*`). **Names only**; nothing in them opened, listed inside or grepped.
4. `git log --oneline -15` at start-up printed one subject past the snapshot ("FS-114, FS-111 inventories; FS-114 brief"). Subject only; no `git log -p`.
5. **A touch, disclosed:** a `grep -n` for the definition of "tactic edge" over my predecessor's round-5 brief `data/fs114/briefs/Y5-114-construction-round5.md`
   (a brief other than mine, so fenced by FS114-Y's rule) printed four of its lines: K1's statement, the round-5 list of open cases ("the pinwheel …,
   the `(2, 1, 1, 0)` patterns, three tactic edges …, non-Reuleaux lenses …, non-simple bowties") and its items 2–3. Every one repeats the round-4 card
   and my own brief; no proof content. No other line of it was read.

## Stage 1 — SAVED: reading, the quotation check, calibration

### 1.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` (rule 0 first: `CLAUDE.md` § The aim and § Counter-priors, in context from disk at start-up), my round-6 brief, the three cards,
  FS114-Y's brief: **in full**.
- `plans/FS114-Y5-construction.md`: **in full** (RAINBOW, REGION, MU, ALT, POCKET, CASE, REDUCE, PX, PXKILL, PINALL). `tools/fs114_y5_pin.py` lines
  1–150 (the wedge and probe method), `tools/fs114_y5_quotes.py` **in full**.
- `plans/FS114-Y4-construction.md`: **in full** (SIDES, UPDOWN, W, LUNE, DIAG, RSTOPALL). `plans/FS114-YB3-verification.md`: **in full**.
  `plans/FS114-YB2-verification.md`: **in full** (YB2-DE, RSTOP, RPREC, EMPTY13). `plans/FS114-Y2-construction.md`: **in full**.
- `plans/FS114-L60-audit.md`: **in full** (L60-LE, L60-EQ, L60-REAL, L60-2, L60-PROOFS, L60-WALK, L60-D5).
- `data/fs114/claims.md`: **in full**.
- `plans/FS112-Y-construction.md`: by `grep` for "midline" and "tactic" only (the strip's midline vertices: degree 4, four colours, edges segments,
  **no tactic edge at the vertex** — they are the centres of the strip's unit arcs).
- Tools, data layout first (G46): `tools/fs114_yb3_check.py` header and API, `tools/fs114_yb3_run.py` header and function list.

### 1.2 Quotation check (standing rule 5)

`tools/fs114_y6_quotes.py`: **30 of 30 FOUND** (`data/fs114/fs114-y6/quotes.out`): Kooshi's seven quotations; Question 2 against the claim list and the
paper's text; K1 in my brief against the round-2 card; E1 and E2 in FS114-Y5's own words (my brief's parenthetical glosses of them summarise that record;
"forcing a 60° cone" is Y5's words, "an empty pocket" is the owner's gloss, checked by hand in stage 2: in E1 the pocket between the cap and the next
blade is sealed); PINALL against Y5's table; repeat (A), the tactic-edge sentence and the charge sentence on the round-2 card; FS112-U1, L60-LE, L60-EQ,
FS114-Y2-GAPS (both halves), FS114-Y4-UPDOWN, YB2-DE, FS114-Y5-RAINBOW, FS112-SIX, C114-LOCAL-F, de Grey's Siamese; K1-PIN on the round-4 card; my
hand-back sentence. Self-test PASS (`quotes-selftest.out`: an altered word MISSING, its faithful twin FOUND, the faithful quotation against the wrong
file MISSING). **Not checkable:** my brief's summaries of the proof side ("the proof side excludes the pinwheel whose ring carries no (Q) arc") and of
running jobs (FS114-YB4) summarise fenced records; I work them as stated and rest nothing on them.

### 1.3 Calibration (claim list §6)

Run unedited in this session under `scripts/slot.py`:
- **FS114-YB3's checker** (intervals and minimal polynomials): `tools/fs114_yb3_run.py selftest` → ALL PASSED, six checker plants each flipping
  exactly its predicted controls (`yb3-selftest.out`); `calib` → brick, hexagonal seven-colouring, strip, disk, FS112-BOWTIE **all ACCEPT**, pairs
  examined printed against pairs held (11/11, 7/7, 82/82, 71/71, 21/21), each object plant AS PREDICTED (`yb3-calib.out`).
- **FS114-YB2's checker** (tower signs): `tools/fs114_yb2_run.py selftest` → SELFTEST PASSED (`yb2-selftest.out`); `calib` → the same five **all
  ACCEPT** (11/11, 11/11, 82/82, 71/71, 21/21), plants AS PREDICTED (`yb2-calib.out`).

Every object of this job is checked through `tools/fs114_yb3_check.py` (imported unedited) by a driver `tools/fs114_y6_*.py`, whose own run
re-checks the five controls first.

## Stage 1 — SAVED
