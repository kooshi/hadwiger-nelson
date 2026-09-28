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

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|

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
