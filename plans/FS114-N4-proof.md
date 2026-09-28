# FS114-N4 — FS-114's proof side, round 3: the Reuleaux bowtie at radius 2, K1 at radius 2, and the local NO

*Job FS114-N4, de Bruijn (Opus 5.5), launched 2026-09-28 07:31 UTC at HEAD `9c81c91b`. Brief `data/fs114/briefs/N4-114-proof-round3.md`, with the
cards `data/fs114/briefs/ROUND3-card.md` and `data/fs114/briefs/ROUND2-card.md`, FS114-N's brief `data/fs114/briefs/N114-proof.md` and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-n4/`; exact checks `tools/fs114_n4_*.py`. Notation is
FS114-N's, FS114-N2's and FS114-N3's (`plans/FS114-N-proof.md` header and § Continuation; `plans/FS114-N3-proof.md` header and §2): tiles, `ω(x)`,
`P_cl(x)`, `Γ`, `F`, `R`, close / far, a **tactic edge** (a whole unit arc on `ω(q)`, inner tile `x` with `q ∈ cl x`, and a tile of the outer tile's
colour touching `x` at `q` alone), the **ring** `ω(p)`, a **change point**, N-E0, N-E1, N-E2 (`plans/FS110-N-proof.md` §1.4), N3-FACE, N3-HALF,
N3-FLANK, N3-PAIR, N3-ODD. All statements are for **non-Siamese** valid maps (no two distinct tiles of one colour close) unless said otherwise.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| N4-QT | Every quotation my brief and the cards rely on, where its source is open to me, is found verbatim (29 of 29); the card's summaries compared by hand; one paraphrase noted (LOCAL-F loses "explicit") | [tools] | §1.2; `tools/fs114_n4_quotes.py` |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|

## Fence log (standing rule 13; brief § Fences)

1. At start-up `ls -la data/fs114/briefs/` with `wc -c` printed the **names and sizes** of every brief, among them the construction side's
   (`Y114-construction.md`, `Y2-…`, `Y3-114-construction-round3.md`, `YB114-…`), the verifiers' and the advisor's. None opened except mine, the two cards,
   FS114-N's and `STANDING-RULES.md`.
2. `ls plans/ | grep -i fs114` and `ls data/fs114/` printed the **names** `plans/FS114-Y-construction.md`, `FS114-Y2-construction.md`,
   `FS114-Y3-construction.md`, `FS114-YB-verification.md`, `FS114-close-inventory.md` and the directory names `fs114-y`, `fs114-y2`, `fs114-y3`, `fs114-yb`,
   `reports`. Contents not listed or opened.
3. The harness's start-up git status (not a command of mine) showed the untracked names `tools/fs114_y3_rstop.py`, `tools/fs111_w_*.py` and
   `data/fs111/fs111-w/*`, and the recent subjects `FS114-Y3: stage 1` and `FS111-M: …`. A `git log --oneline -1` of mine printed `543d65f2 FS111-W: stage 3`
   (one subject newer than the snapshot). Subjects and names only.

## Stage 1 — SAVED: reading, the quotation check

### 1.1 Read from disk (G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first), `CLAUDE.md` § The aim and § Counter-priors (loaded; unchanged on disk), my brief, `ROUND3-card.md`,
  `ROUND2-card.md`, `N114-proof.md` — all in full.
- `plans/FS114-N3-proof.md` in full; `plans/FS114-N-proof.md` in full (stage 1 and § Continuation — FS114-N2); `data/fs114/claims.md` in full.
- `plans/FS114-NB-verification.md` header, theorem table, logs and §1.1–1.2 item 0; `plans/FS114-CV-verification.md` and `plans/FS114-CVB-verification.md`
  headers and theorem tables (CV-EXISTS, CVB-EXISTS, CVB-PINCH, CVB-THOM).
- `plans/FS112-derivation.md` header and §§1–2 (U1, SIX, NB4P, A4SIX, L60, LOCK, BEND, N2-RED, N3-NOBOTH, N3-FAIL, N3-COR3, N3-BASE, N3-DENSE3);
  `plans/FS112-N-proof.md` header, §1.2–1.4 (N112-SIX's proof, A4SIX as walk row 1), stage 2 §2.1–2.6 (N112-NB4′, card W, L60, LOCK, BEND, RED).
- `plans/FS110-N-proof.md` theorem-table rows N-E0, N-E1, N-E2; `data/fs110/claims.md` §0's covering-pair line (as grepped). Tools read, not run:
  `tools/fs114_n3_quotes.py` (my side's).

### 1.2 The quotation check (standing rule 5)

`tools/fs114_n4_quotes.py` checks 29 statements with whitespace collapsed and `**` removed, nothing else normalised: **29 of 29 FOUND**
(`data/fs114/fs114-n4/quotes.out`). **Plant:** FS112-SIX with "at least 180°" changed to "at least 120°" is NOT FOUND and its faithful twin FOUND
(`quotes-plant.out`). The rows marked SUMMARY check the source's own words; the comparison with the card's restatement is by hand:
- The card's FS112-SIX, "a five-colour vertex whose ring lies inside a valid map carries unit arcs about it totalling at least 180°": faithful. SIX is
  stated for a vertex of a valid map; "whose ring lies inside" is the right reading for a fragment (N112-SIX's proof reads only `ω(v)`).
- The card's C114-LOCAL-F, "no valid fragment holds a disc of some radius `R` about a vertex of at least four colours": **drops "explicit"** from the
  claim list's "there are an explicit radius `R` and a derivation that no valid fragment exists on the closed disc of radius `R` about a vertex of at least
  four colours". Logged; I work the claim list's form.
- The card's N3-DR0, N3-DR1/DR2, N3-CONT, N3-PAY, K2-loc, GAP-μ, SIAM-KILL: faithful to `plans/FS114-N3-proof.md`. The card's THOM-TOP ("`M − x` stays
  connected at a pinch point and breaks at a hole"): faithful to FS114-CVB-PINCH.
- **Not checkable:** the card's statements of FS114-Y2-BOWTIE, FS114-Y2-GAPS, FS114-Y-DIAL and the 66.9° about `q1` come from the construction side's
  records, fenced from me. I use them at the card's wording and grade only.

## Stage 1 — SAVED
