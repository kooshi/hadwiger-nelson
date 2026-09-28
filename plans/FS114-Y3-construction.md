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

## Would-have-searched-here log (standing rule 3)

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
