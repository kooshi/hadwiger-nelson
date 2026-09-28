# FS114-NB4 — blind verification of FS-114's proof side, round 3 (FS114-N4)

*Job FS114-NB4, de Bruijn (Opus 5.5), launched 2026-09-28 (start-up snapshot HEAD `949b1bb3`). Brief: the template
`data/fs114/briefs/NB114-verify-proof.md` with the instance `data/fs114/briefs/NB4-114-instance.md` (the instance wins) and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-nb4/`; exact checks `tools/fs114_nb4_*.py`.
Stage 1 is blind: every verdict is derived from the nine statements in the instance file alone, before `plans/FS114-N4-proof.md` is opened.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| NB4-QT | Every quotation my brief, instance and standing rules rely on that I can check is verbatim: 17 of 17 FOUND; plant fires | [tools] | §1a.2; `tools/fs114_nb4_quotes.py` |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|

## Fence log (standing rule 13; template and instance § Fences)

1. At start-up `ls data/fs114/briefs/` and `ls data/fs114/` listed file and directory **names** only (among them `N4-114-proof-round3.md`,
   `fs114-n4`, `fs114-y*`, `fs114-yb*`, `fs114-l60`, `reports`); none opened.
2. `git log --oneline -5` at start-up showed one subject beyond the start-up snapshot: `639a15df FS-114: construction verifier logged; blind check of
   the proof side's exclusion launched` (the owner's). Subject only.
3. A `grep` over `LEDGER.md` produced output large enough that the harness saved it to a file under `~/.claude/projects/…/tool-results/`; I did **not**
   open that file (it is inside the fenced transcript tree) and re-extracted the rows into my own scratch directory instead.

## Stage 1a — SAVED: reading and the quotation check

### 1a.1 Read from disk (G50)

- `data/fs114/briefs/NB114-verify-proof.md`, `NB4-114-instance.md`, `STANDING-RULES.md` in full; `CLAUDE.md` § The aim, § Counter-priors, G83, G82,
  G79, G71, G60, G21, G15, G13, G51 (loaded in context).
- `LEDGER.md` rows 131–136 in full.
- `data/fs114/claims.md` in full; `data/fs114/briefs/ROUND2-card.md`, `ROUND3-card.md` in full.
- `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ, stage 5b (not 5.3).
- `data/fs114/briefs/N114-proof.md` in full (its § Reading, as the template directs).
- `plans/FS114-N3-proof.md` in full (round 2's proof side; open to me by the instance).
- `plans/FS112-derivation.md` header and §1 through FS112-L60 (FS112-U1, -SIX, -NB4P, -A4SIX, -L60), the entry titles of §§1–4, and FS112-N3-COR3;
  `data/fs112/claims.md` §0 (notation: `Γ`, `P_cl`, `ω`, contact kinds); the N-E0/N-E1/N-E2 line of `plans/FS112-N-proof.md` (l. 6–7).
- **Not used:** FS112-L60's strict form (under audit, instance). Where a derivation below needs an arc bound it says which.

### 1a.2 The quotation check (standing rule 5)

`tools/fs114_nb4_quotes.py data/fs114/fs114-nb4/quotes.tsv` checks 17 quotations — Kooshi's five in the standing rules (rule 0, rule 4, rule 3 twice,
rule 10), N3's statement of N3-DR0 and its tactic-edge and non-Siamese definitions, the FS112 statements the instance and claim list name (SIX, A4SIX,
NB4P, N3-COR3, U1, L60, N3-DENSE3), and two claim-list definitions (Siamese, "reads radius") — with whitespace collapsed and `**` removed:
**17 of 17 FOUND** (`data/fs114/fs114-nb4/quotes.out`). **Plant:** `--plant` alters one word of the first quotation: the altered copy NOT FOUND, its
faithful twin FOUND (`quotes-plant.out`). **Not checkable at stage 1:** the nine statements of the instance are FS114-N4's, quoted from its record,
which is fenced until this stage is committed; they are checked at stage 2. The round cards' restatements of construction-side results (FS114-Y2-BOWTIE,
-GAPS) come from fenced records and are used only at the card's wording and grade, never as inputs to a derivation.

## Stage 1a — SAVED
