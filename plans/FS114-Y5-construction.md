# FS114-Y5 — the construction side of FS-114, round 5 (K1's other killing tests: the pinwheel first)

*Job FS114-Y5 (de Bruijn, Opus 5.5), 2026-09-28, from `data/fs114/briefs/Y5-114-construction-round5.md`, the cards `ROUND2-card.md`, `ROUND3-card.md`,
`ROUND4-card.md`, FS114-Y's brief `Y114-construction.md` and `STANDING-RULES.md` (all read in full, rule 0 first). Working files
`data/fs114/fs114-y5/`; exact checks `tools/fs114_y5_*.py`; my scratch `scratchpad/fs114-y5/` (regenerable only). Resuming check: no record, working
directory, tool or report of this job existed at start. Every statement about a valid map is about a possible object: the class is not known to be
non-empty.*

*Notation (the pinwheel).* `p = 0`; `e(φ)` the unit vector at angle `φ`; angles at a point are directions from it, counter-clockwise from the positive
`x`-axis; a tile's **sector** at a vertex is the closed cone of directions it fills there; `ω(u)` the unit circle about `u`, `B(u, 1)` the open unit
disc, **the ring** is `ω(p)`. The four tactic centres are `q_j = e(φ_j)`, `j = 1 … 4` counter-clockwise, `α_{j+1} = φ_{j+1} − φ_j ∈ [60°, 180°]`
(indices mod 4). Edge `j` at `p` leaves `p` in direction `θ_j = φ_j − 90°` along `ω(q_j)`. The tile `t_{j+1}` (colour `j + 1`) is the tile at `p`
between edges `j` and `j + 1` (sector `[θ_j, θ_{j+1}]` at `p`, of width `α_{j+1}`): **inner** for edge `j` (`t_{j+1} ⊂ B̄(q_j, 1)`, `q_j ∈ cl t_{j+1}`)
and **outer** for edge `j + 1` (`t_{j+1} ∩ B(q_{j+1}, 1) = ∅`); this is the brief's pinwheel ("each tile at `p` inner for one tactic edge"), with the
brief's `q_j = p + e(θ_j + 90°)`. `T_j` is the tactic tile of colour `j` at `q_j`, meeting `t_{j+1}` at `q_j` alone. **The class:** the owner's
message of 2026-09-28 (verbatim): *"Start at the 120° cone" meant the class of pinwheels with at least one cone at `p` of exactly 120°. That is the stub
named K1-PIN120 in the round-4 record list. It does not mean one specific member.* Every result below states the class it covers.

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| FS114-Y5-QT | every quotation of my brief set and of this record is found at its source (24 of 24); the self-test's plant fires | [tools] | §1.2; `tools/fs114_y5_quotes.py` |

## Would-have-searched-here log (standing rule 3)

- (filled as moves occur)

## Fence log (standing rule 13; the brief's § Fences)

1. The harness's start-up context (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): its lines name FS-112's and FS-114's milestone status and the standing rules; no proof
   content. No file under that path was opened by me.
2. The harness's start-up `git status` named FS-111's untracked `data/fs111/fs111-w/*.out` and my brief; five commit subjects. Names only.
3. At start-up `ls data/fs114/briefs/` listed every brief's file name (the proof side's `N*-114-*.md`, the verifiers' `NB*`, `YB*`, `CV*`, the advisor's,
   `L60-114-audit.md`); `ls data/fs114/` listed the fenced directory names `fs114-n*`, `fs114-nb*`, `fs114-yb3`, `fs114-cv*`, `reports`; `ls tools/fs114_y*`
   listed the names `tools/fs114_yb3_check.py`, `fs114_yb3_cusp.py`, `fs114_yb3_run.py` (the running verifier's). **Names only**; nothing in them opened,
   listed inside or grepped.
4. `git log --oneline -8` at start-up printed one subject past the snapshot ("FS-114: the Reuleaux bowtie family closed at root 3 by two blind routes;
   construction round 5 launched"). Subject only; no `git log -p`.

## Stage 1 — SAVED: reading, the quotation check, calibration, the owner's clarification

### 1.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` (rule 0 first: `CLAUDE.md` § The aim and § Counter-priors, in context from disk at start-up), my round-5 brief, the three cards,
  FS114-Y's brief: **in full**.
- `plans/FS114-Y4-construction.md`: **in full** (SIDES, UPDOWN, W, LUNE, DIAG, RSTOPALL, CHK). `plans/FS114-Y2-construction.md`: **in full** (the design
  method). `plans/FS114-Y3-construction.md`: **in full**. `plans/FS114-YB2-verification.md`: **in full** (stages 1a–1c; its checker's header).
  `plans/FS114-L60-audit.md`: the header, theorem table, logs and §1.1–1.3(ii) **in full** (L60-LE, L60-EQ); the rest not read.
- `data/fs114/claims.md`: **in full**.
- Tools, data layout first (G46): `tools/fs114_y4_quotes.py` **in full**; `tools/fs114_yb_exact.py` lines 1–340 and 470–720 (arithmetic, pieces, the
  pair verdict, points, consistency); `tools/fs114_y2_k1.py` header and builder signatures.

### 1.2 Quotation check (standing rule 5)

`tools/fs114_y5_quotes.py`: **24 of 24 FOUND** (`data/fs114/fs114-y5/quotes.out`): Kooshi's seven quotations; Question 2 against the claim list and the
paper's text; K1 on the round-4 card against the round-2 card; K1-PIN on the round-4 card; repeat (A) and the tactic-edge sentence on the round-2 card;
FS112-U1, L60-LE, FS114-Y2-GAPS (both halves), FS114-Y4-UPDOWN, N-E1, FS114-Y4-RSTOPALL, FS112-SIX, C114-LOCAL-F, de Grey's Siamese. Self-test PASS
(`quotes-selftest.out`: an altered word MISSING, its faithful twin FOUND, the faithful quotation against the wrong file MISSING). **Not checkable:** my
brief's summary of N5-PIN0 (centres, cones `α_j ∈ [60°, 180°]`, "`t_j ⊂ B̄(p, 1) ∩ B̄(q_{j−1}, 1) ∖ B(q_j, 1)`, its ring contacts within 60° of `q_{j−1}`
and at least 60° from `q_j`") summarises a fenced record; I work it as stated (my indexing: `t_{j+1}` inner at `q_j`). My brief quotes nothing else but
its hand-back sentence.

### 1.3 Calibration (claim list §6)

Run unedited in this session under `scripts/slot.py --mem 2 --cpus 1`:
- **FS114-YB's checker**: `tools/fs114_yb_run.py selftest` → SELF-TEST PASSED, every checker plant flipping its predicted controls (`yb-selftest.out`);
  `calib` → brick, hexagonal seven-colouring, strip, disk, FS112-BOWTIE **all ACCEPT**, pairs examined printed against pairs held (3/17, 3/11, 24/90,
  52/71, 18/21), each object plant REJECT (`yb-calib.out`).
- **FS114-YB2's checker**: `tools/fs114_yb2_run.py selftest` → SELFTEST PASSED (`yb2-selftest.out`); `calib` → the same five **all ACCEPT** (11/11, 11/11,
  82/82, 71/71, 21/21 examined), plants AS PREDICTED (`yb2-calib.out`).
- `tools/fs114_y2_k1.py all` → FS114-Y2-BOWTIE ACCEPT (46 pairs, 40 examined), plants `v5`, `wide_t1`, `wide_t1b` as in Y2's record (`y2-k1-rerun.out`).

### 1.4 The owner's clarification (asked, answered)

I asked what "Start at the 120° cone" meant, proposing the member with cones `60°, 120°, 60°, 120°` (centres at `0°, 60°, 180°, 240°`). Answer (verbatim
in the header): the class **K1-PIN120**, every pinwheel with at least one cone of exactly `120°`; my member lies in it; state the class each result covers.

## Stage 1 — SAVED
