# FS114-Y4 — the construction side of FS-114, round 4 (the escapes from RSTOP)

*Job FS114-Y4 (de Bruijn, Opus 5.5), 2026-09-28, from `data/fs114/briefs/Y4-114-construction-round4.md`, the cards `ROUND4-card.md`,
`ROUND3-card.md`, `ROUND2-card.md`, FS114-Y's brief `Y114-construction.md` and `STANDING-RULES.md` (all read in full, rule 0 first). Working files
`data/fs114/fs114-y4/`; exact checks `tools/fs114_y4_*.py`; my scratch `scratchpad/fs114-y4/` (regenerable only). Every statement about a valid map
is about a possible object: the class is not known to be non-empty. Notation as `plans/FS114-Y3-construction.md` (its header): `p = 0`,
`q1 = e(30°)`, `q2 = e(−30°)`, `q3 = e(210°)`, `q4 = e(150°)`, `top = (0, 1)`, `bot = (0, −1)`, `r = q1 + q2 = (√3, 0)`; `t1` the Reuleaux triangle
`(p, q1, q2)` (colour 1), `t3` its mirror (colour 3), `t2` above `p` (2), `t4` below (4); `T_i` the tactic tile of the outer colour at `q_i`; angles at
a vertex are directions from it, counter-clockwise from the positive x-axis; a tile's **sector** at a vertex is the closed cone of directions it
fills there. **The proof side's vocabulary** (the owner's message of 2026-09-28, verbatim from its records): the **ring** at `p` is `ω(p)`; a
**lune** is the region at `p` in the cone between the two Reuleaux triangles; "the top lune's ring `(30°, 150°)`"; the **degenerate member**: "the
top lune's ring `(30°, 150°)` changes colour once, at `top`"; a ring **free of `Γ`** carries no boundary arc along `ω(p)` in the lune's cone;
**simple**: "every tile an open disc whose closure meets each other tile's closure in a connected set or not at all, and does not meet itself".*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|

## Would-have-searched-here log (standing rule 3)

## Fence log (standing rule 13; the brief's § Fences)

1. At start-up `ls -la data/fs114/briefs/` listed every brief's file name (the proof side's `N*-114-*.md`, the verifiers' `NB*`, `YB*`, `CV*`,
   the advisor's `A114-advisor.md`, `L60-114-audit.md`); `ls plans/FS114-* data/fs114/ tools/fs114_*` listed by name the fenced records
   `plans/FS114-N-proof.md`, `plans/FS114-N3-proof.md`, `FS114-N4-proof.md`, `FS114-N5-proof.md`, `FS114-NB-verification.md`,
   `FS114-CV*-verification.md`, `plans/FS114-close-inventory.md`, the directories `data/fs114/fs114-n*`, `fs114-nb`, `fs114-cv*`, `reports`, and the
   proof side's tools `tools/fs114_n*_*.py`. **Names only**; nothing in them opened, listed inside or grepped.
2. The harness's start-up `git status` named FS-111's untracked `data/fs111/fs111-w/*.out` and five commit subjects. Names only.
3. The owner's message of 2026-09-28 quoted five definitions from the proof side's records (N3 header, N3 §2.2, N4 §2.2, N-proof N2-3); vocabulary,
   sent by the owner, recorded in the header above.

## Stage 1 — SAVED: reading, the quotation check, calibration

### 1.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` (rule 0 first: `CLAUDE.md` § The aim and § Counter-priors, in context from disk), my round-4 brief, the three cards, FS114-Y's
  brief: **in full**.
- `plans/FS114-Y3-construction.md`, `plans/FS114-Y2-construction.md`, `plans/FS114-YB2-verification.md`: **in full**. `plans/FS114-L60-audit.md`: the
  theorem table, fence log and §1.1–1.3(ii) **in full**; the rest not read (L60-WALK's chain is not mine to use).
- `data/fs114/claims.md`: **in full**.
- Tools, data layout first (G46): `tools/fs114_y2_k1.py` (the bowtie, every tile) and `tools/fs114_y3_rstop.py` **in full**;
  `tools/fs114_yb_exact.py` header and API (lines 1–140 and the function list), `tools/fs114_yb_run.py` `check_finite`; `tools/fs114_yb2_run.py` header.

### 1.2 Quotation check (standing rule 5)

`tools/fs114_y4_quotes.py`: **23 of 23 FOUND** (`data/fs114/fs114-y4/quotes.out`) — Kooshi's seven quotations; Question 2 against the claim list and
the paper's text; K1 on the round-4 card against the round-2 card; E1, E2 and "E2 survives" against Y3's record; YB2-EMPTY13 against YB2's record;
L60-LE, FS112-U1, FS112-SIX, C114-LOCAL-F, de Grey's Siamese, YB2-DE. Self-test PASS (`quotes-selftest.out`). **By hand:** the round-4 card's E2
("a tile at `q1` whose sector starts after 60°, and whose colour has no tile at `q2` pointing toward `r`") summarises Y3's "has its whole sector after
`60°` … no tile at `q2` pointing within 90° of `30°`" — faithful, with "toward `r`" meaning "within 90° of the direction `30°` to `r`"; the card's and
my brief's "where E2 survives" drops Y3's condition "when `λ > 60°`" (`λ` the start of `L`'s sector at `q1`), which this record keeps. The card's
N4 statements summarise fenced records; I work them as the card states them. My brief quotes nothing but its hand-back sentence.

### 1.3 Calibration (claim list §6)

Run unedited in this session under `scripts/slot.py --mem 2 --cpus 1`:
- **FS114-YB's checker**: `tools/fs114_yb_run.py selftest` → SELF-TEST PASSED, every checker plant flipping its predicted controls
  (`yb-selftest.out`); `calib` → brick, hexagonal seven-colouring, strip, disk, FS112-BOWTIE **all ACCEPT**, pairs examined printed against pairs held
  (3/17, 3/11, 24/90, 52/71, 18/21), each object plant REJECT (`yb-calib.out`).
- **FS114-YB2's checker**: `tools/fs114_yb2_run.py selftest` → SELFTEST PASSED (`yb2-selftest.out`); `calib` → the same five **all ACCEPT** (11/11,
  11/11, 82/82, 71/71, 21/21 examined), plants AS PREDICTED (`yb2-calib.out`).
- `tools/fs114_y2_k1.py all` → FS114-Y2-BOWTIE ACCEPT (46 pairs, 40 examined), plants `v5`, `wide_t1`, `wide_t1b` as in Y2's record
  (`y2-k1-rerun.out`).

## Stage 1 — SAVED
