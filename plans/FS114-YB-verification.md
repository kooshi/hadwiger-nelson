# FS114-YB — blind verification of FS-114's construction side (the capped strip, the disk, the moved disk; the printed geometries' rigidity; statements about every valid map)

*Job FS114-YB, de Bruijn on Opus 5.5, launched early on 2026-09-28 (UTC) at HEAD `d96e60e4`. Brief: `data/fs114/briefs/YB114-verify-construction.md`;
instance `data/fs114/briefs/YB114-instance.md` (read from disk, uncommitted at start); `data/fs114/briefs/STANDING-RULES.md`. Every object is rebuilt from
its rule in words and checked by my own exact checker (`tools/fs114_yb_exact.py`), written without reading any FS114-Y file; FS-112's tools are run as
they are, never edited. Stage 1 (my verdicts) is committed before I open `plans/FS114-Y-construction.md`, `data/fs114/fs114-y/` or `tools/fs114_y_*`.*

## Theorems this phase proved

(Filled at the end of stage 1; one line per theorem, grade and address.)

## Would have searched here (standing rule 3)

- (stage 1) none yet.

## Fence log (standing rule 13; brief § Rules)

- Start-up: `ls data/fs114/` listed directory **names**, among them the fenced `fs114-n`, `fs114-nb`, `fs114-y`, `reports`, and `ls data/fs114/briefs/`
  listed the brief **file names** (among them fenced briefs); nothing in any fenced directory was listed, opened or grepped, and no fenced brief was
  opened. The start-up `git status` (harness snapshot) showed the untracked names `data/fs114/fs114-nb/`, `tools/fs114_nb_count.py`,
  `tools/fs114_nb_quotes.py` — names only, not opened.
- `git log --oneline -5` at start-up (the snapshot's own five subjects); no further `git log`.

## Stage 1a — SAVED: reading; the quotation check

### 1a.1 Read from disk, in this order

`STANDING-RULES.md` (rule 0 first); my brief and instance file; `CLAUDE.md` § The aim, § Counter-priors, G83, G79, G71, G46, G22, G21, G20, G51 (from the
session's load of the file at start-up); `LEDGER.md` rows 133–136 in full; `data/fs114/claims.md` in full; `plans/FS114-unit-arc-question.md` §G part 3,
§PA, §IQ and stage 5b (**not 5.3**); the construction side's brief `data/fs114/briefs/Y114-construction.md` in full (its § Reading's sources: FS-112's
§4 and records as below; the Google group thread `Z50mmulkXCQ` at the posts of 2020-09-13, 2020-10-17, 2021-06-27 and 2022-05-01, and the claim
list's `J_Tw1_hUxQI` sentences by grep); `plans/FS112-derivation.md` §4 in full; `plans/FS112-YB-verification.md` stages 3–4 (the strip's rebuild);
`plans/FS112-YB2-verification.md` stages 1–4 (the disk's transcription and formula, YB2 labels); `plans/FS112-Y-construction.md` §§4–5.3 and 6.2–6.3
lines 400–600 (the disk's rules and tiles in **Y2's labels**, which the instance uses: `T1_k`, `T2_k`, `R_k`, `U_k`, `U′_k`, `Z^L_k`, `Z^R_k`); the data
layout (constructors only) of `tools/fs112_yb2_check.py` (`Seg`, `Arc`), `tools/fs112_yb2_objects.py` (`Strip`, `Disk` docstring) and
`tools/fs112_yb3_frags.py` (`bowtie`), so that held objects can be converted and compared; `Proofs/HadwigerNelson/Instances/Seven.lean`'s header (the
brick). Not read: FS-112's checker logic (pair and sign code), which my checker does not borrow.

**Labels used below.** The strip: YB's (`P_j = (j/2, 0)`, arch `U_j` over `[j/2, (j+1)/2]`, valley `V_m = (m/2, √3/2)`, apex `A_j = (j/2 + 1/4, √15/4)`,
top tile `T_m` over `V_m`, inverted arch `D_j`, bottom tile `B_m`), with the instance's `Q_m = (m/2 + 1/4, Y)`, `Y = √3/2 + √15/4`, the top corner
shared by `T_m` and `T_{m+1}`. The disk: Y2's (`plans/FS112-Y-construction.md` §4.1–4.4).

### 1a.2 The quotation check (standing rule 5) — `tools/fs114_yb_quotes.py`, `data/fs114/fs114-yb/quotes.tsv`, output `quotes.out`

20 quotations: the standing rules' five Kooshi quotations; the claim list's Sirgedas quotations I verify (C114-DUAL-COUNT, C114-EDGE-RAINBOW's
"Degree 6 …", C114-REDBLOCK's four, the degree-4 sentence), de Grey's Siamese definition, and the FS-112 statements my verdicts rest on (FS112-N3-COR3,
FS112-C-PARTNERS, FS112-N3-NOBOTH, the definition of a valid map, FS112-N3-DENSE3, FS112-DISC) and `[Polymath2021]` p. 194's tactic (PDF p. 30, text
layer). **20 of 20 FOUND** under the tool's stated normalisation (typographic quotes unified; backticks and `**` dropped; whitespace collapsed).
`--self-test`: an altered word turns FOUND into MISSING (`quotes-selftest.out`). One punctuation point, not a paraphrase: standing rule 4's Kooshi
quotation ends "a success." with a period inside the quotation marks; `CLAUDE.md` (Frontier item 23) has none — the words are exact.

**The instance file's statements** are quoted from FS114-Y's record, which is fenced until my stage 1 is committed; their quotation check is stage 2's
first step. **No paraphrase found in my brief.** One reading point, recorded before any verdict: the instance's statement 3 names `C_0 + e(72°)/100`;
with Y2's placement the colourless cone at `C_0` after the move is `(54°, 90°)` (FS112-MOVE), so 72° lies in it.

## Stage 1a — SAVED
