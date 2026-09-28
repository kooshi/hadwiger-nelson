# FS114-YB3 — blind verification of FS-114's construction side, round 4 (FS114-Y4: LUNE, DIAG, RSTOPALL, SIDES, UPDOWN, W, D2ALL, E2X)

*Job FS114-YB3, de Bruijn on Opus 5.5, launched 2026-09-28 about 10:15 UTC. Brief: the template `data/fs114/briefs/YB114-verify-construction.md`
with the instance `data/fs114/briefs/YB3-114-instance.md` (read from disk; its changes win), and `data/fs114/briefs/STANDING-RULES.md` (rule 0 first).
Resuming check: no record, working directory or tool of this job existed at start. Working files `data/fs114/fs114-yb3/`; tools
`tools/fs114_yb3_*.py`; scratch `scratchpad/fs114-yb3/` (regenerable only). Every statement about a valid map is about a possible object: the class
is not known to be non-empty. Stage 1 (my verdicts) is committed before I open `plans/FS114-Y4-construction.md`, `data/fs114/fs114-y4/` or
`tools/fs114_y4_*`.*

**Notation** (the round cards' and FS114-Y3's, fixed here before any verdict). `p = 0`; `e(φ)` the unit vector at angle `φ`; `q1 = e(30°)`,
`q2 = e(−30°)`, `q3 = e(210°)`, `q4 = e(150°)`; `top = (0, 1)`, `bot = (0, −1)`; `r = q1 + q2 = (√3, 0)`. `t1 = Reul(p, q1, q2)` (colour 1),
`t3 = Reul(p, q4, q3)` (colour 3), `t2` the tile at `p` above (sector `[60°, 120°]` at `p`, colour 2), `t4` below (`[240°, 300°]`, colour 4). The sides:
`S1` = the arc of `ω(q2)` from `p` to `q1` (`t1`'s upper side), `S2` = the arc of `ω(q1)` from `p` to `q2`, `S4` = the arc of `ω(q3)` from `p` to `q4`,
`S3` = the arc of `ω(q4)` from `p` to `q3`. `X_i` = the tile along `S_i` at `q_i`, outside `t1` or `t3` (the instance's `X1…X4`). The tactic tiles
(R-T): `T1` (colour 4) at `q1`, `T2` (2) at `q2`, `T3` (2) at `q3`, `T4` (4) at `q4`, each touching the inner tile at `q_i` alone. The **upper lune**
`U` is the open region bounded by `S1`, the arc of `ω(p)` from `q1` to `q4` (its ring) and `S4`; the lower lune `L` its mirror. A tile's **sector** at a
vertex is the closed cone of directions it fills there, angles counter-clockwise from the positive `x`-axis. **Non-Siamese** is read as the project
reads it (FS114-Y2-GAPS, FS114-YB2): distinct tiles of one colour are at least 1 apart. **Straddle**: two distinct tiles of one colour with minimum
distance below 1 and maximum above 1 carry interior points at distance exactly 1 (both are connected open sets), so a valid map has none, Siamese or not.

## Theorems this phase proved

(filled at each stage's end)

## Would have searched here (standing rule 3)

| stage | move I would have made by search | what I did instead |
|---|---|---|

## Fence log (standing rule 13; the template's and the instance's fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): lines naming milestone status (FS-112 closed, FS-114's jobs, standing rules). No line
   about FS114-Y4's statements or proofs. No file under that path was opened by me.
2. **The harness's start-up git snapshot** printed five commit subjects, among them `3de4d85a FS-114 inventory: no Reuleaux bowtie reaches root 3
   (construction side, one mind)` — a subject disclosing a grade ("one mind") for what reads as FS114-Y4-RSTOPALL — and `FS114-Y4: report`,
   `FS114-Y4: stage 4`, `FS114-NB5: stage 1a`. Subjects only.
3. My start-up `git log --oneline | head -5` printed one subject beyond the snapshot: `14111569 FS-114: construction round 4 logged; its blind
   verifier launched`. Subject only; no further `git log`, no `git log -p`.
4. `ls data/fs114/ data/fs114/briefs/` listed by **name** the fenced directories (`fs114-n` … `fs114-n5`, `fs114-nb`, `fs114-nb4`, `fs114-nb5`,
   `fs114-y4`, `fs114-cv`, `fs114-cvb`, `reports`, …) and the fenced briefs (the proof side's, the verifiers', the advisor's, Y4's). Nothing in them
   opened, listed or grepped.
5. `ls plans/ | grep -i fs114` listed by name the fenced records (`FS114-N-proof.md`, `FS114-N3/N4/N5-proof.md`, `FS114-NB*-verification.md`,
   `FS114-CV*-verification.md`, `FS114-Y4-construction.md`, `FS114-close-inventory.md`). Names only.
6. `ls tools/ | grep -E "fs112_yb|fs114"` listed by name the fenced tools `tools/fs114_n*`, `tools/fs114_nb*` and `tools/fs114_y4_diag.py`,
   `tools/fs114_y4_quotes.py`, `tools/fs114_y4_sides.py` (the Y4 names suggest exact checks called "diag" and "sides"). Not opened.
7. One `rg` for the quoted definition of "simple" ran with every fenced path excluded (`-g '!…'`); it printed nothing.

## Stage 1a — SAVED: reading; the quotation check

### 1a.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` **in full**, rule 0 first (`CLAUDE.md` § The aim and § Counter-priors, in context from disk at start-up); the template and the
  instance **in full**.
- `CLAUDE.md` G83, G79, G71, G46, G22, G21, G20, G51 (the session's load at start-up). `LEDGER.md` rows 133–136 **in full**.
- `data/fs114/claims.md` **in full**. `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ and stage 5b **in full**; **5.3 not read**.
- `data/fs114/briefs/Y114-construction.md` **in full** (its § Reading lists FS-112's close, the printed local NOs, the Google group and two papers:
  those sources are **not read this round**; what bears on these eight statements is in the FS-112 entries below and the round records).
- The round cards `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` **in full**.
- `plans/FS114-Y2-construction.md` **in full**; `plans/FS114-Y3-construction.md` **in full**; `plans/FS114-YB2-verification.md` **in full** (stages 1a–1c;
  it has no stage 2). Tools: `tools/fs114_yb2_run.py` **in full** (its bowtie builder, calibration conversions), `tools/fs114_yb2_exact.py` docstring and
  lines 1–80 (arithmetic), for data layout only (G46).
- `plans/FS112-derivation.md`: header, FS112-U1, FS112-SIX, FS112-NB4P, FS112-A4SIX, FS112-L60, FS112-N3-COR3 entries **in full**.
- `plans/FS114-L60-audit.md`: header and theorem table **in full** (L60-LE: "`ℓ ≤ 60°`"; L60-EQ at equality).
- **Not read:** every fenced file; `plans/FS114-YB-verification.md` beyond its size (round 1's strip and disk; its quotation tool run unedited).

### 1a.2 The quotation check (standing rule 5) — `data/fs114/fs114-yb3/quotes.tsv`, run through FS114-YB's `tools/fs114_yb_quotes.py` unedited

**17 of 17 FOUND** (`quotes.out`, exit 0): the standing rules' five Kooshi quotations (rules 0, 3, 4, 10); the instance's "at most 60°" (FS112-L60, in
`plans/FS114-L60-audit.md`); the instance's reading R-T against the round-4 card; the Siamese and valid-map definitions against the claim list; FS112-U1;
K1 and repeat (A) against the round-2 card; E1 against the round-4 card and E1, E2 against FS114-Y3's record; YB2-EMPTY13 against YB2's record; Y3-D2's
stop. The tool's self-test PASSED (`quotes-selftest.out`: an altered word turns FOUND into MISSING); my own two plants (one word changed in SR0 and in
R-T) read MISSING (`quotes-plant.out`, exit 1).

**Not checkable in stage 1:** (a) the eight statements, copied by the owner's script from `plans/FS114-Y4-construction.md` (fenced until stage 1 is
committed): stage 2's first step; (b) the instance's definition of **simple** ("every tile an open disc whose closure meets each other tile's closure in
a connected set or not at all, and does not meet itself"), and of ring, change point, lune and Γ-free: their sources (`plans/FS114-N3-proof.md`,
`plans/FS114-N-proof.md`) are fenced **always** for this job, and no unfenced file carries the sentence. I work them as the instance states them.

**Reading points recorded before any verdict.**
- The instance names `top`, `bot` "as in the round cards"; the round-3 card places them as the four-colour vertices at distance 1 from `p` whose rings
  reach radius 2, and FS114-Y3's notation fixes `top = (0, 1)`, `bot = (0, −1)`. I use those.
- "E0" (statement 3) is **not defined** in my brief, the cards or the open records (Y3 names E1 and E2 only). Its clause is checked at stage 2.
- Statements 2 and 8 do not say "non-Siamese" in their own words; statement 2's "diagonal" is the pattern statement 1 derives in non-Siamese maps, and
  statement 8's class is FS114-Y3-D2's, which is non-Siamese. I read both as non-Siamese and say where a step needs it.

## Stage 1a — SAVED
