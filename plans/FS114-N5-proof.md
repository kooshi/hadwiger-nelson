# FS114-N5 — FS-114's proof side, round 4: finishing K1 (K1-ΓRING, K1-PIN)

*Job FS114-N5, de Bruijn (Opus 5.5), launched 2026-09-28 09:03 UTC at HEAD `07af44a0`. Brief `data/fs114/briefs/N5-114-proof-round4.md`, with the
cards `data/fs114/briefs/ROUND4-card.md`, `ROUND3-card.md`, `ROUND2-card.md`, FS114-N's brief `data/fs114/briefs/N114-proof.md` and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-n5/`; exact checks `tools/fs114_n5_*.py`; scratch
`scratchpad/fs114-n5/` (my own subdirectory). Resuming check: no record existed at start. Notation is FS114-N's, N2's, N3's and N4's
(`plans/FS114-N-proof.md` header and § Continuation; `plans/FS114-N3-proof.md` header and §2; `plans/FS114-N4-proof.md` header): tiles, `ω(x)`,
`P_cl(x)`, `Γ`, `F`, `R`, close / far (N114-FAR), a **tactic edge** (a whole unit arc on `ω(q)`, inner tile `x` with `q ∈ cl x`, and a tile of the
outer tile's colour — the **partner** — touching `x` at `q` alone), the **ring** `ω(p)`, a **change point**, a tile's **cone** at a vertex, the
patterns `+`/`−` and the inner counts (N3-SEC), N-E0, N-E1, N-E2 (`plans/FS110-N-proof.md` §1.4), N3-FACE, N3-HALF, N3-SEC, N3-FLANK, N3-PAIR, N3-ODD,
N4-OWN, N4-LENS, N4-OPP, N4-TANG. `e(φ)` is the unit vector at angle `φ`. All statements are for **non-Siamese** valid maps (no two distinct tiles of
one colour close) unless said otherwise, in the **simple class** where N3's lemmas need it (a tile's cone at a vertex is one closed interval; a tile
never touches itself). **FS112-L60 is used only in its corrected form, "at most 60°"** (FS114-L60).*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| N5-QT | Every quotation my brief and the round-4 card rely on, where its source is open to me, is found (19 of 19); the card's summaries compared by hand, one scope clause dropped (N4-FIVE's "with the lune rings free of `Γ`") | [tools] | §1.2; `tools/fs114_n5_quotes.py` |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|

## Fence log (standing rule 13; brief § Fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under `~/.claude/projects/-home-kooshi-source-lean-dir/`
   (fenced). Its lines name milestone status and standing rules; no proof content. The start-up git status printed the untracked names
   `data/fs114/briefs/Y4-114-construction-round4.md`, `data/fs111/fs111-m2/*`, `data/fs111/fs111-w/*`, `tools/fs111_m2_disck7.py` and five commit
   subjects (FS114-L60, FS111-M2). Names and subjects only.
2. At start-up `ls data/fs114/briefs/` with `wc -c` printed the **names and sizes** of every brief, the construction side's among them (`Y114-…`,
   `Y2-…`, `Y3-…`, `Y4-114-construction-round4.md`, `YB…`, `NB4-114-instance.md`), the verifiers' and the advisor's. None opened except mine, the three
   cards, FS114-N's and `STANDING-RULES.md`.
3. `ls plans/FS114*` and `ls data/fs114/` printed the **names** `plans/FS114-Y-construction.md`, `FS114-Y2-construction.md`, `FS114-Y3-construction.md`,
   `FS114-YB-verification.md`, `FS114-YB2-verification.md`, `FS114-NB-verification.md`, `FS114-close-inventory.md` and the directory names `fs114-y`,
   `fs114-y2`, `fs114-y3`, `fs114-yb`, `fs114-yb2`, `fs114-nb`, `reports`. Contents not listed or opened. (No `FS114-NB4` record or directory existed then.)

## Stage 1 — SAVED: reading, the quotation check

### 1.1 Read from disk (G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (loaded at start-up; the file is the project's
  instructions); my brief, `ROUND4-card.md`, `ROUND3-card.md`, `ROUND2-card.md`, `N114-proof.md` — all in full.
- `plans/FS114-N4-proof.md` in full; `plans/FS114-N3-proof.md` in full; `data/fs114/claims.md` in full.
- `plans/FS114-N-proof.md`: header, theorem table (FS114-N and N2 rows), logs, §1.3 (N114-FAR, anchoring), §N2-2.1 to §N2-2.3 (N2-ABS, N2-SLACK,
  N2-ENDS, N2-VCAP, N2-DIAM, N2-KILL).
- `plans/FS114-L60-audit.md`: header, theorem table, logs, the proposed statement (§1.3's end), L60-WALK's verdict line.
- `plans/FS114-CV-verification.md` and `plans/FS114-CVB-verification.md`: theorem tables and the CV/CVB reconciliation table (A-1 to A-12, B-1, B-2).
- `plans/FS110-N-proof.md` §1.4: N-E0, N-E1, N-E2 in full.
- `plans/FS112-derivation.md`: header and the entry titles of §§1–4; U1, SIX, NB4P, A4SIX, L60, LOCK in full.
- `LEDGER.md` rows 134–136 (statements and grades).
- Tools read, not run: `tools/fs114_n4_quotes.py` (my side's, as a model).

### 1.2 The quotation check (standing rule 5)

`tools/fs114_n5_quotes.py` checks 19 statements with whitespace collapsed and `**` removed, nothing else normalised: **19 of 19 FOUND**
(`data/fs114/fs114-n5/quotes.out`, exit 0). **Plant:** the corrected L60 statement with "at most 60°" changed to "below 60°" is NOT FOUND and its faithful
twin FOUND (`quotes-plant.out`, exit 0) — the plant is the old, false form of L60, which my brief forbids. By hand, the card's restatements against the
sources' words:
- Card 4's L60 ("at most 60°, not below; at 60° both side tiles lie in the lens of its ends"): faithful to FS114-L60's proposed statement.
- Card 4's "The chain N2-RED → COR3 → N3-BASE → DENSE3 → CV-EXISTS is intact (one mind)": faithful to L60-WALK (one mind).
- Card 4's N4-BOWTIE: faithful. **Card 4's N4-FIVE** ("five colours at a corner iff the lune's ring is degenerate, otherwise four") drops the source's scope
  "With the lune rings free of `Γ`"; the card carries that scope one line earlier (N4-BOWTIE). Noted; I use the source's form.
- My brief's "N4's three moves (sector orders, the lens N4-LENS empties, a diameter)": faithful to N4 §5.2. "The pinwheel (each tile inner for one edge)" and
  "the `(2, 1, 1, 0)` patterns": faithful to N3-SEC's pattern list (`++++` four rotational; `+++−`, `++−−` one lens, two rotational, one anti-lens).
- **Not checkable:** FS114-Y2-GAPS, FS114-Y2-BOWTIE, FS114-Y3-RSTOP, Y3-R's E1/E2, Y3-D2, YB2-EMPTY13 come from the construction side's records, fenced from me.
  I use them at the cards' wording and grade only.

## Stage 1 — SAVED
