# FS114-YB2 — blind verification of FS-114's construction side, rounds 2 and 3 (the Reuleaux bowtie; RSTOP, R, D2, FOUR, 13, GAPS)

*Job FS114-YB2, de Bruijn on Opus 5.5, launched 2026-09-28 about 07:40 UTC. Brief: the template `data/fs114/briefs/YB114-verify-construction.md`
with the instance `data/fs114/briefs/YB2-114-instance.md` (read from disk, uncommitted at start; its changes win), and
`data/fs114/briefs/STANDING-RULES.md`. Every object is rebuilt from its rule in words and checked by my own exact checker (`tools/fs114_yb2_*.py`),
written without reading any FS114-Y2 or FS114-Y3 file. Stage 1 (my verdicts) is committed before I open `plans/FS114-Y2-construction.md`,
`plans/FS114-Y3-construction.md`, `data/fs114/fs114-y2/`, `data/fs114/fs114-y3/`, `tools/fs114_y2_*`, `tools/fs114_y3_*` or
`data/fs114/briefs/ROUND3-card.md`.*

## Theorems this phase proved

(filled at each stage's end)

## Would have searched here (standing rule 3)

(one line per move, filled as they occur)

## Fence log (standing rule 13; brief § Rules)

- Start-up: `ls data/fs114/ data/fs114/briefs/` listed directory and brief **names** only (among them the fenced `fs114-n*`, `fs114-y2`, `fs114-y3`,
  `reports`, and the fenced briefs); nothing inside a fenced directory was listed, opened or grepped, and no fenced brief was opened.
- `git log --oneline -8` at start-up showed two subjects past the harness's start-up snapshot ("FS111-W: stage 4", "FS-114: round-3 construction
  logged; its blind verifier launched") — subjects only; no further `git log`, no `git log -p`.
- The harness's `git status` snapshot named the untracked `data/fs111/fs111-w/*.out` (FS-111's, fenced) and my instance file — names only.

## Stage 1a — SAVED: reading; the quotation check

### 1a.1 Read from disk

`STANDING-RULES.md` (rule 0 first); the template and the instance; `CLAUDE.md` § The aim, § Counter-priors, G83, G79, G71, G46, G22, G21, G20, G51 (the
session's load at start-up); `LEDGER.md` rows 133–136 in full; `data/fs114/claims.md` in full; `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ
and stage 5b (**not 5.3**); `data/fs114/briefs/Y114-construction.md` in full; `data/fs114/briefs/ROUND2-card.md` in full; `plans/FS112-derivation.md`
header, §1 through FS112-L60, and FS112-BOWTIE; `data/fs112/claims.md` §0 (the contact kinds, `P_cl`, `ω`); `plans/FS114-YB-verification.md` in full
(stages 1a–2); the header and API of `tools/fs114_yb_exact.py`; the builder `bowtie` of `tools/fs112_yb3_frags.py` (data layout only).

### 1a.2 The quotation check (standing rule 5) — `data/fs114/fs114-yb2/quotes.tsv`, run through FS114-YB's `tools/fs114_yb_quotes.py` unedited

13 quotations: the standing rules' five Kooshi quotations; the definitions and statements my verdicts rest on (the valid map, de Grey's Siamese
definition, FS112-U1, FS112-SIX, FS112-A4SIX, FS112-N3-DENSE3); K1 on the round-2 card; Question 2. **13 of 13 FOUND** (`quotes.out`); the tool's
self-test turns an altered word into MISSING (`quotes-selftest.out`). **The instance's statements are quoted from FS114-Y2's and FS114-Y3's records,
fenced until stage 1 is committed; their check is stage 2's first step.** No paraphrase found in my brief.

**Reading points recorded before any verdict.**
- The instance's object 1 names the disc radius `3√3/5`, the vertex `p` "of colours 1–4", `t1 = (p, e(30°), e(−30°))` — a Reuleaux triangle of width 1
  with a corner at `p` (the three corners are pairwise at distance 1: `|e(30°) − e(−30°)| = 1`). I read `p = (0,0)`, `q1 = e(30°)`, `q2 = e(−30°)`,
  `q3, q4` the mirrors `e(150°)`, `e(210°)` (the instance's "`q_i = e(±30°), e(180° ± 30°)`"; which is `q3` and which `q4` is fixed below).
- Statement 2 names `r = q1 + e(330°) = (√3, 0)`: `e(30°) + e(−30°) = (√3, 0)` — so `r = q1 + q2`, the fourth corner of the unit rhombus `p, q1, r, q2`.
- Statement 4 names "`top`", undefined in the instance; I read it as the top point of the bowtie's upper region (`t2`'s side), and fix it at stage 1b
  from the rule (a guess, flagged; stage 2 checks it).

## Stage 1a — SAVED
