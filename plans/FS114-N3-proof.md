# FS114-N3 — FS-114's proof side, round 2: the kills (K1 first)

*Job FS114-N3, de Bruijn (Opus 5.5), launched 2026-09-28 at HEAD `9b226434`. Brief `data/fs114/briefs/N3-114-proof-round2.md`, with the round-2
card `data/fs114/briefs/ROUND2-card.md`, FS114-N's brief `data/fs114/briefs/N114-proof.md` and `data/fs114/briefs/STANDING-RULES.md` (rule 0 read
first). Working files `data/fs114/fs114-n3/`; exact checks `tools/fs114_n3_*.py`. Notation is FS114-N's and FS114-N2's (`plans/FS114-N-proof.md`
header and § Continuation): tiles, `ω(x)`, `P_cl`, `F`, `R`, close / far, `N[x]`, a **tactic edge** (a whole unit arc on `ω(q)`, inner tile `x` with
`q ∈ cl x`, and a tile of the outer tile's colour touching `x` at `q` alone), `n(p)` the non-tactic edges at `p`. New here: at a vertex `p`, the **ring**
is `ω(p)`; a **change point** of the ring is a point of `Γ ∩ ω(p)` where the colour of the ring off `Γ` differs on its two sides; `σ` is the rotation by
`60°` about `p`. All statements are for **non-Siamese** valid maps unless said otherwise; there every vertex carries distinct colours on its tiles.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| N3-QT | Every quotation this record and its brief rely on is verbatim: 27 of 27 FOUND (two needed a single-asterisk emphasis kept, named) | [tools] | §1.2; `tools/fs114_n3_quotes.py` |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|

## Fence log (standing rule 13; brief § Fences)

1. At start-up `ls plans/FS114* data/fs114/` listed the **names** `plans/FS114-Y-construction.md`, `plans/FS114-YB-verification.md`,
   `plans/FS114-close-inventory.md` and the directory names `fs114-y`, `fs114-yb`, `reports` (contents not listed); `ls data/fs114/briefs/` with `wc -c`
   listed the other briefs' names and sizes. None opened or grepped.
2. `git log --oneline -8` at start-up showed three subjects older than the start-up snapshot (`06a8c395 FS114-YB: stage 2`, `6f906407 FS114-N2: stage 2`,
   `8ac5aa39 FS114-YB: stage 1`); a later `git log --oneline -3` showed `4d342ef8 FS114-Y2: stage 1a` (the construction side's round-2 subject). Subjects
   only.
3. The owner's mid-stage message (FS114-CV's result) unfenced `plans/FS114-CV-verification.md`; I read its theorem table lines 20–24 and its §1.5 rows
   for GS-1, C-COMPOSE (3) and C114-LOCAL-FR (grep hits), nothing else yet.

## Stage 1 — SAVED: reading, the quotation check, and where FS114-CV's result bears

### 1.1 Read from disk (G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (loaded); `data/fs114/briefs/N3-114-proof-round2.md`,
  `ROUND2-card.md`, `N114-proof.md` in full.
- `plans/FS114-N-proof.md` in full (stage 1, § Continuation — FS114-N2, stages N2-2 and N2-3); `plans/FS114-NB-verification.md` in full.
- `plans/FS114-unit-arc-question.md` §G part 3, §IQ, 5.0–5.4 (5.3 included); `data/fs114/claims.md` in full.
- `plans/FS112-derivation.md` header, §1 through FS112-A4SIX, and every entry title of §§1–4; `data/fs110/claims.md` §0 (covering pair, types) and the
  ring notation (the setting before N2-TRANS); `plans/FS112-Y-construction.md` §1.3 (the strip) and stage 4 (the disk's tiles, edges, colours).

### 1.2 The quotation check (standing rule 5)

`tools/fs114_n3_quotes.py` checks 27 statements — the card's restatements of FS114-N2's lemmas (K1, K2-loc, GAP-μ, N2-ENDS, N2-DIAM, N2-SLACK, N2-VCAP,
N2-SIAM, N2-REFINE, the extreme's shape), N114-RD and NB's reading radius, the tactic-edge definition, NB-A1, FS112-NB4P, -U1, -A4SIX, -N3-COR3, -SIX,
C114-LOCAL-F, GS-D, CV-EXISTS as the owner's message states it, and Kooshi's two quotations in the standing rules — with whitespace collapsed and `**`
removed: **27 of 27 FOUND** (`data/fs114/fs114-n3/quotes.out`). Two failed on a first run because the source keeps single-asterisk emphasis
(`*(a claim)*`, `*(this list)*`); the quotations were corrected to the source's form, nothing normalised further. **Plant:** K1 with "at most two" changed to
"at most three" is NOT FOUND and its faithful twin FOUND (`quotes-plant.out`). The card's statements of FS114-Y-DIAL, -PAIRSHARE and -K6 come from the
construction side's round-1 record, fenced from me: **not checked** (I use them only at the card's grade and wording). **No quotation in my brief or the
card differs from its source** among those I could check; the card's "`n` (degree 3)" is N2's "`n` (cubic)", a rewording with no change of content.

### 1.3 Where FS114-CV's result bears (the owner's message, 2026-09-28)

CV-EXISTS (one mind; "every valid map has a vertex of at least four colours — in the map itself, no modification needed, no residue, no ray step") makes
C114-LOCAL-F alone the NO. It bears here in three places:
1. **K1's object is C114-LOCAL-F's object.** In the non-Siamese class a degree-4 vertex carries four colours, so a K1-escaping vertex is a four-colour vertex,
   and a valid fragment about it of radius `R` is exactly what C114-LOCAL-F must exclude at its `R`. Any configuration I derive as K1's escape is therefore
   also a candidate for the radius dial (FS114-Y-DIAL's `φ²/√2 ≈ 1.8512` is the strip's).
2. **Route T and the local route meet at one vertex type.** Route T needs K1 (at most two tactic edges at a degree-4 vertex) because the count's only negative
   charge sits there; the local route needs every four-colour vertex excluded at some radius. A local exclusion of the degree-4 vertices with three or four
   tactic edges would serve both.
3. **The Siamese half.** CV-EXISTS holds Siamese or not; route T does not. If CV-EXISTS is confirmed, SIAM-KILL (my stage 4) is subsumed by C114-LOCAL-F
   about a four-colour vertex of a Siamese map — the count need not reach it.

## Stage 1 — SAVED
