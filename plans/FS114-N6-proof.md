# FS114-N6 — FS-114's proof side, round 5: the pinwheel (K1-PIN), the `(2, 1, 1, 0)` patterns, three tactic edges

*Job FS114-N6, de Bruijn (Opus 5.5), launched 2026-09-28 10:32 UTC at HEAD `ac5fc592`. Brief `data/fs114/briefs/N6-114-proof-round5.md`, with the
cards `data/fs114/briefs/ROUND4-card.md`, `ROUND3-card.md`, `ROUND2-card.md`, FS114-N's brief `data/fs114/briefs/N114-proof.md` and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-n6/`; exact checks `tools/fs114_n6_*.py`; scratch
`scratchpad/fs114-n6/` (my own subdirectory). Resuming check: no record existed at start. Notation is FS114-N's, N2's, N3's, N4's and N5's
(`plans/FS114-N-proof.md` header; `plans/FS114-N3-proof.md` header and §2; `plans/FS114-N4-proof.md` header; `plans/FS114-N5-proof.md` header): tiles,
`ω(x)`, `P_cl(x)`, `Γ`, `F`, `R`, close / far (N114-FAR), a **tactic edge** (a whole unit arc on `ω(q)`, inner tile `x` with `q ∈ cl x`, and a tile of the
outer tile's colour — the **partner** — touching `x` at `q` alone), the **ring** `ω(p)`, a tile's **cone** at a vertex, the patterns `+`/`−` and inner
counts (N3-SEC), N-E0, N-E1, N-E2 (`plans/FS110-N-proof.md` §1.4), FS112-U1, N3-FACE, N3-HALF, N3-SEC, N3-FLANK, N3-PAIR, N3-ODD, N4-OWN, N4-LENS,
N4-OPP (in NB4's corrected form), N4-TANG, N5-SIGHT, N5-UP, N5-BENDG. `e(φ)` is the unit vector at angle `φ`. All statements are for **non-Siamese**
valid maps (no two distinct tiles of one colour close) in the **simple class** (a tile's cone at a vertex is one closed interval; a tile never touches
itself) unless said otherwise. **FS112-L60 is used only in its corrected form, "at most 60°"** (FS114-L60).*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| N6-QT | Every quotation my brief and the cards rely on, where its source is open to me, is found (18 of 18); the brief's restatements compared by hand, all faithful | [tools] | §1.2; `tools/fs114_n6_quotes.py` |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|

## Fence log (standing rule 13; brief § Fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under `~/.claude/projects/-home-kooshi-source-lean-dir/`
   (fenced). Its lines name milestone status and standing rules; no proof content. The start-up git status printed the untracked names
   `data/fs111/fs111-w/*` (FS-111) and `data/fs114/briefs/N6-114-proof-round5.md`, and five commit subjects (FS111-VM2, FS-114, FS114-Y4). Names and subjects
   only.
2. At start-up `ls -la data/fs114/briefs/` with `wc -c` printed the **names and sizes** of every brief, the construction side's among them (`Y114-…`, `Y2-…`,
   `Y3-…`, `Y4-…`, `YB…`, `YB3-114-instance.md`), the verifiers' (`NB…`, `NB5-114-instance.md`, `CV…`, `CVB…`) and the advisor's. None opened except mine,
   the three cards, FS114-N's and `STANDING-RULES.md`.
3. `ls plans/ | grep -i fs114` and `ls data/fs114/` printed the **names** `plans/FS114-Y-construction.md`, `FS114-Y2-construction.md`,
   `FS114-Y3-construction.md`, `FS114-Y4-construction.md`, `FS114-YB-verification.md`, `FS114-YB2-verification.md`, `FS114-NB5-verification.md`,
   `FS114-close-inventory.md` and the directory names `fs114-y`, `fs114-y2`, `fs114-y3`, `fs114-y4`, `fs114-yb`, `fs114-yb2`, `fs114-yb3`, `fs114-nb5`,
   `reports`. Contents not listed or opened.

## Stage 1 — SAVED: reading, the quotation check

### 1.1 Read from disk (G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (loaded at start-up as the project's instructions); my
  brief, `ROUND4-card.md`, `ROUND3-card.md`, `ROUND2-card.md`, `N114-proof.md` — all in full.
- `plans/FS114-N5-proof.md` in full; `plans/FS114-N4-proof.md` in full; `plans/FS114-N3-proof.md` in full; `data/fs114/claims.md` in full.
- `plans/FS114-NB4-verification.md`: header, theorem table, logs, §1a, §1b.2 (N4-OWN, N4-LENS, **N4-OPP's corrected form**, N4-FIVE, N4-TOP, N4-D).
- `plans/FS114-L60-audit.md`: header, theorem table, logs, the proposed statement (§1.3's end).
- `plans/FS114-N-proof.md`: header and theorem table (FS114-N and N2 rows).
- `plans/FS110-N-proof.md` §1.4: N-E0, N-E1, N-E2 in full. `plans/FS112-derivation.md`: the statements of FS112-U1, -SIX, -L60, -N2-BENDS.

### 1.2 The quotation check (standing rule 5)

`tools/fs114_n6_quotes.py` checks 18 statements with whitespace collapsed and `**` removed, nothing else normalised: **18 of 18 FOUND**
(`data/fs114/fs114-n6/quotes.out`, exit 0). **Plant:** N5-PIN0's cone range `[60°, 180°]` changed to `[60°, 120°]` is NOT FOUND and its faithful twin FOUND
(`quotes-plant.out`, exit 0). By hand, the brief's restatements against the sources' words:
- "FS112's bends leave only (Q) and (R2) ring arcs at any degree-4 vertex (N5-BENDG)": faithful (at a non-Siamese degree-4 vertex, "outer colour carried at
  `p` and inner colour carried at `p`" is (Q)'s "centre carries both side colours and at least four colours").
- "N4-BOWTIE (Γ-free lune rings; two minds, the general member's kill step sighted)": faithful to NB4-G2.
- N5-PIN0's centres and cones, "no contradiction there", "the 120° cone (K1-PIN120) is N5's first target": faithful to N5 §4.2 and §4.5.
- "The collapse gives `χ_CP = χ_m⁰` with no MR (row 130)": faithful to `CLAUDE.md` § Where the problem stands, item 30.
- **Not checkable:** FS114-Y4-RSTOPALL, FS114-YB3 and every construction-side statement are fenced from me; I use them at the cards' and brief's wording and
  grade only, and **build nothing on RSTOPALL** (brief).

## Stage 1 — SAVED
