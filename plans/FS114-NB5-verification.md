# FS114-NB5 — blind verification of FS-114's proof side, round 4 (FS114-N5)

*Job FS114-NB5, de Bruijn (Opus 5.5), launched 2026-09-28 10:06 UTC (start-up snapshot HEAD `28946790`). Brief: the template
`data/fs114/briefs/NB114-verify-proof.md` with the instance `data/fs114/briefs/NB5-114-instance.md` (the instance wins) and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-nb5/`; exact checks `tools/fs114_nb5_*.py`; scratch
`scratchpad/fs114-nb5/`. Resuming check: no record existed at start. Stage 1 is blind: every verdict is derived from the thirteen statements in the
instance file alone, before `plans/FS114-N5-proof.md` is opened.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| NB5-QT | Every quotation my brief, instance and standing rules rely on whose source is open to me at stage 1 is verbatim: 20 of 20 FOUND; plant fires | [tools] | §1a.2; `tools/fs114_nb5_quotes.py` |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|

## Fence log (standing rule 13; template and instance § Fences)

1. The harness's start-up context (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): milestone status lines, no proof content. No file under that path opened by me.
2. `ls data/fs114/briefs/` and `ls data/fs114/` (sizing the reading) printed the **names** of every brief and working directory, among them
   `N5-114-proof-round4.md`, `Y4-114-construction-round4.md`, `fs114-n5`, `fs114-y4`, `fs114-yb2`; none opened.
3. `git log --oneline -8` at start-up showed one subject beyond the start-up snapshot: `645ecd06 FS-114: proof round 4 logged; its blind verifier
   launched` (the owner's). Subject only.
4. `grep -n '^#' plans/FS114-unit-arc-question.md` printed the **heading line** of stage 5.3 (the registered expectations, fenced until my stage 1 is
   committed). Heading only; the section not read.

## Stage 1a — SAVED: reading and the quotation check

### 1a.1 Read from disk (G50)

- `data/fs114/briefs/NB114-verify-proof.md`, `NB5-114-instance.md`, `STANDING-RULES.md` in full; `CLAUDE.md` § The aim, § Counter-priors, G83, G82,
  G79, G71, G60, G21, G15, G13, G51 (loaded in context).
- `LEDGER.md` rows 131–136 (134–136 in full; 131–133 to their Not-claimed clauses).
- `data/fs114/claims.md` in full; `data/fs114/briefs/ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` in full.
- `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ, stage 5b (not 5.3).
- `data/fs114/briefs/N114-proof.md` in full (its § Reading, as the template directs).
- `plans/FS114-N4-proof.md`, `plans/FS114-NB4-verification.md`, `plans/FS114-N3-proof.md` in full (open to me by the instance).
- `plans/FS112-derivation.md` header and §1 (U1, SIX, NB4P, A4SIX, L60, LOCK, BEND, ISO, N2-BENDS, N2-RED, FLANK, END, N2-FLANK-Q, N2-RAY, N2-TERM,
  N2-DENSE, DISC1) and FS112-N3-COR3's statement; `plans/FS112-N-proof.md` stage N2-3 (N2-SIGN, N2-ENV, N2-TOWARD, N2-AWAY, N2-TAN, N2-RED) and its
  header's N-E0/N-E1/N-E2 line.
- `plans/FS114-L60-audit.md` header, theorem table, logs and §1.1–1.3 (ii).

### 1a.2 The quotation check (standing rule 5)

`tools/fs114_nb5_quotes.py data/fs114/fs114-nb5/quotes.tsv` (whitespace collapsed, `**` removed, nothing else normalised) checks 20 quotations: Kooshi's
five in the standing rules; the instance's N4-FIVE scope clause "with the lune rings free of `Γ`" against `plans/FS114-N4-proof.md`; FS112-L60 as printed;
the L60 audit's corrected bound; FS112-N3-COR3, the (Q)/(R2) definitions and FS112-N2-RED against `plans/FS112-derivation.md`; the one-line statements of
N2-TOWARD, N2-AWAY, N2-TAN against `plans/FS112-N-proof.md`; the round-4 card's N4-BOWTIE and L60 sentences; N4-D's and N4-G's headlines; N3-DR1's and
N3-FACE's statements. **20 of 20 FOUND** (`data/fs114/fs114-nb5/quotes.out`, exit 0). The first run had row 20 at a wording of my own guess (NOT FOUND);
replaced by the card's sentence — a defect of my TSV, not of a source. **Plant** (`--plant`: one word of the first quotation altered): the altered copy
NOT FOUND, its faithful twin FOUND (`quotes-plant.out`, exit 0). By hand: the card's L60 summary ("at most 60°, not below; at 60° both side tiles lie in
the lens of its ends") is faithful to the audit's L60-LE and L60-EQ. **Not checkable at stage 1:** the thirteen statements of the instance are FS114-N5's,
copied by a script from its record, which is fenced until this stage is committed; they are checked at stage 2.

## Stage 1a — SAVED
