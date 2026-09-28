# FS114-N7 — FS-114's proof side, round 6: three tactic edges, the `(2, 1, 1, 0)` patterns, the pinwheel's E1 and E2

*Job FS114-N7, de Bruijn (Opus 5.5), launched 2026-09-28 12:40 UTC at HEAD `df67fa5f`. Brief `data/fs114/briefs/N7-114-proof-round6.md`, with the
cards `data/fs114/briefs/ROUND4-card.md`, `ROUND3-card.md`, `ROUND2-card.md`, FS114-N's brief `data/fs114/briefs/N114-proof.md` and
`data/fs114/briefs/STANDING-RULES.md` (rule 0 read first). Working files `data/fs114/fs114-n7/`; exact checks `tools/fs114_n7_*.py`; scratch
`scratchpad/fs114-n7/` (my own subdirectory). Resuming check: no record existed at start. Notation is FS114-N's, N2's, N3's, N4's, N5's and N6's
(`plans/FS114-N-proof.md` header; `plans/FS114-N3-proof.md` header and §2; `plans/FS114-N4-proof.md` header; `plans/FS114-N5-proof.md` header;
`plans/FS114-N6-proof.md` header and §2), with NB6's corrections (`plans/FS114-NB6-verification.md`): tiles, `ω(x)`, `P_cl(x)`, `Γ`, `F`, `R`, close / far
(N114-FAR), a **tactic edge**, its inner tile, outer tile, centre and partner, the **ring** `ω(p)`, `κ`, change points, a tile's **cone** at a vertex, the
patterns `+`/`−` and inner counts (N3-SEC), CL and CL-p (NB6 §1b.0), N-E0, N-E1, N-E2, FS112-U1, N3-FACE, N3-HALF, N3-SEC, N3-FLANK, N3-PAIR, N4-LENS,
N4-OPP (NB4's corrected form), N5-SIGHT, N5-BENDG, N6-KAPPA, N6-WIN, N6-RING60, NB6-P60, N6-QOUT. `e(φ)` is the unit vector at angle `φ`. All statements are
for **non-Siamese** valid maps (no two distinct tiles of one colour close) in the **simple class** (a tile's cone at a vertex is one closed interval; a tile
never touches itself) unless said otherwise. FS112-L60 is used only in its corrected form (L60-LE, L60-EQ).*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| N7-QT | Every quotation my brief relies on, where its source is open to me, is found (16 of 16); the brief's restatements compared by hand, all faithful; E1 and E2 (construction side) not checkable | [tools] | §1.2; `tools/fs114_n7_quotes.py` |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|

## Fence log (standing rule 13; brief § Fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under `~/.claude/projects/-home-kooshi-source-lean-dir/`
   (fenced): milestone status lines, no proof content. The start-up git status printed the untracked names `data/fs111/fs111-w/*` (FS-111) and
   `data/fs114/briefs/N7-114-proof-round6.md`, and five commit subjects (FS-114 inventory, FS114-YB4 stages and report). Names and subjects only.
2. At start-up `ls -la data/fs114/briefs/` with `wc -c` printed the **names and sizes** of every brief, the construction side's (`Y…`, `YB…`), the
   verifiers' (`NB…`, `CV…`, `CVB…`), the advisor's and the planner's among them. None opened except mine, the three cards, FS114-N's and
   `STANDING-RULES.md`.
3. `ls plans/FS114-* data/fs114/ data/fs114/reports/` printed the **names** `plans/FS114-Y-construction.md`, `FS114-Y2…Y6-construction.md`,
   `FS114-YB-verification.md`, `FS114-YB2…YB4-verification.md`, `FS114-NB-verification.md`, `FS114-close-inventory.md`, the directory names `fs114-y`,
   `fs114-y2…y6`, `fs114-yb`, `fs114-yb2…yb4`, and **the file names in `data/fs114/reports/`** (a fenced directory; every job's report name). Contents not
   listed or opened.
4. `git log --oneline -15` at start-up showed ten subjects older than the start-up snapshot's five (among them `FS114-Y6: stage 1`, `FS114-YB4: stage 1a`,
   `FS114-NB6: stage …`, `FS111-M3: report (14 lines)`). Subjects only.

## Stage 1 — SAVED: reading, the quotation check

### 1.1 Read from disk (G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (loaded at start-up as the project's instructions); my
  brief, `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md`, `N114-proof.md` — all in full.
- `data/fs114/claims.md` in full.
- `plans/FS114-N6-proof.md` in full; `plans/FS114-NB6-verification.md` header, theorem table, logs, §1b and §1c in full; `plans/FS114-N5-proof.md` theorem
  table, §2 and §4 in full; `plans/FS114-NB5-verification.md` theorem table; `plans/FS114-N4-proof.md` theorem table and §2–§5 in full;
  `plans/FS114-NB4-verification.md` N4-OPP's corrected form; `plans/FS114-N3-proof.md` header, theorem table, §2 and §3 in full; `plans/FS114-N-proof.md`
  theorem table and N2-KILL.
- `plans/FS114-L60-audit.md` header and theorem table; `plans/FS114-CV-verification.md`, `plans/FS114-CVB-verification.md`: the CV-EXISTS rows.
- `plans/FS110-N-proof.md` theorem rows of N-E0, N-E1, N-E2; `plans/FS112-derivation.md` the statement of FS112-U1.

### 1.2 The quotation check (standing rule 5)

`tools/fs114_n7_quotes.py` checks 16 statements with whitespace collapsed and `**` removed, nothing else normalised: **16 of 16 FOUND**
(`data/fs114/fs114-n7/quotes.out`, exit 0). **Plant:** N2-ENDS's degree-4 charge `(n − 2)` changed to `(n − 1)` is NOT FOUND and its faithful twin FOUND
(`quotes-plant.out`, exit 0). By hand, the brief's restatements against the sources' words:
- K1, "a degree-4 vertex of a non-Siamese valid map has at most two tactic edges": faithful to N2-KILL's K1.
- "N2-ENDS charges a degree-4 vertex with three tactic edges `−1` and with four `−2`": N2-ENDS's degree-4 charge is `n − 2`, `n` the non-tactic edges; with
  `n = 1, 0` it is `−1, −2`. Faithful.
- "(Q) arc is FS-112's term: a boundary arc along `ω(p)` whose inner and outer colours are both carried at `p`": FS-112's header says "an arc whose centre
  carries both side colours and at least four colours". The brief drops "at least four colours", automatic at the four-colour vertex `p`. Faithful in the
  setting.
- "your side's N6-NOQ excludes it at `1 + ε` when its ring carries no (Q) arc": faithful to N6-NOQ (and NB6-NOQ).
- "N6-CENT: on a (Q)-free ring these need a (Q) arc": faithful to N6-CENT's last clause in NB6-CENT's reading (`0° < γ < 60°`).
- **Not checkable:** E1 and E2 are the construction side's (fenced). I use them at the brief's wording only, and state my reading of E2 where I use it (§3).

## Stage 1 — SAVED
