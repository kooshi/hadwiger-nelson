# FS114-YB5 — blind verification of FS-114's construction side, round 6 (FS114-Y6: E1 and E2 of the pinwheel, and the Reuleaux half)

*Job FS114-YB5, de Bruijn on Opus 5.5, launched 2026-09-28 about 13:03 UTC. Brief: the template `data/fs114/briefs/YB114-verify-construction.md`
with the instance `data/fs114/briefs/YB5-114-instance.md` (read from disk; its changes win) and `data/fs114/briefs/STANDING-RULES.md` (rule 0 first).
Resuming check: no record, working directory, tool or report of this job existed at start. Working files `data/fs114/fs114-yb5/`; tools
`tools/fs114_yb5_*.py`; scratch `scratchpad/fs114-yb5/` (regenerable only). Every statement about a valid map is about a possible object: the class
is not known to be non-empty. Stage 1 (my verdicts) is committed before I open `plans/FS114-Y6-construction.md`, `data/fs114/fs114-y6/` or
`tools/fs114_y6_*`.*

## Theorems this phase proved

*(Filled at the end of stage 1c; stage 2's verdicts after comparison are §2.)*

## Would have searched here (standing rule 3)

| stage | move I would have made by search | what I did instead |
|---|---|---|

## Fence log (standing rule 13; the template's and the instance's fences)

1. **The harness's start-up context** (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): lines naming milestone status (FS-112, FS-114 jobs) and standing rules; nothing about
   FS114-Y6's statements or proofs.
2. **The harness's start-up git snapshot** printed five commit subjects (`FS114-Y6: report`, `FS114-Y6: stage 4`, `FS111-M4: stage 1`,
   `FS114-Y6: stage 3 (the owner's ruling on the grid check)`, `FS-114 inventory`) and the untracked names `data/fs111/fs111-w/*.out` and my instance
   file. Subjects and names only.
3. My start-up `git log --oneline -15` printed one subject beyond the snapshot (`8d3468d2 FS-114 inventory; verifier instance`) and older subjects
   (`FS114-N7: stage 1`, `FS114-YB4: report / stage 2 / stage 1`, `FS-114 inventory; FS-114 brief`, …). Subjects only; no further `git log`, no
   `git log -p`.
4. `ls data/fs114/ data/fs114/briefs/` and `ls plans/ | grep -i fs114` listed by **name** the fenced directories (`fs114-n` … `fs114-n7`, `fs114-nb*`,
   `fs114-y6`, `fs114-cv*`, `reports`), the fenced briefs (the proof side's, the verifiers', the advisor's, `Y6-114-construction-round6.md`) and the fenced
   records (`FS114-N*-proof.md`, `FS114-NB*`, `FS114-CV*`, `FS114-Y6-construction.md`, `FS114-close-inventory.md`). Names only.
5. **A touch, disclosed.** My `cat plans/FS114-Y5-construction.md` (open to me) was too long for the terminal; the harness saved the output under
   `~/.claude/projects/-home-kooshi-source-lean-dir/…/tool-results/` (a fenced path), and **I opened that saved file** with the Read tool. Its content is
   exactly `plans/FS114-Y5-construction.md`, an open record; nothing else under that path was opened. (FS114-YB4 met the same situation and re-read the
   source instead; I did not.)
6. **A touch, disclosed.** An `ls` of the shared harness scratchpad's root (meant only to create my own subdirectory) printed the **names** of every
   file and directory other jobs keep there (among them `fs114-y6`, `fs114-n7`, `fs114-nb6`, …). Names only; nothing in them opened, listed inside or
   grepped. Also a slip of mine: before that I had copied `plans/FS114-YB4-verification.md` (open to me) to `scratchpad/yb4.txt`, outside my
   subdirectory; it was deleted unread in the same command that made `scratchpad/fs114-yb5/`.

## Stage 1a — SAVED: reading; the quotation check

### 1a.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` **in full**, rule 0 first (`CLAUDE.md` § The aim and § Counter-priors, in context from disk at start-up); the template and the
  instance **in full**; `data/fs114/briefs/YB4-114-instance.md` (the vocabulary) **in full**.
- `CLAUDE.md` G83, G79, G71, G46, G22, G21, G20, G51 (the session's load at start-up). `LEDGER.md` rows 133–136 **in full**.
- `data/fs114/claims.md` **in full**. `plans/FS114-unit-arc-question.md` §G part 3, §PA, §IQ and stage 5b **in full**; **5.3 not read**.
- `data/fs114/briefs/Y114-construction.md` **in full**; its § Reading's sources (FS-112's close, the printed local NOs, the Google group, two papers) are
  **not re-read this round** — what bears on E1, E2 and the Reuleaux half is in the round records below.
- The round cards `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` **in full**.
- `plans/FS114-Y5-construction.md` **in full** (the pinwheel chain: RAINBOW, REGION, MU, ALT, POCKET, CASE, REDUCE, PIN120-60, PX, PXKILL, PINALL);
  `plans/FS114-YB4-verification.md` **in full** (its verdicts, YB4-WRAP, YB4-P120GAP).
- `plans/FS114-Y4-construction.md` **in full** (SIDES, UPDOWN, W, LUNE, DIAG, RSTOPALL); `plans/FS114-YB3-verification.md` **in full** (D2T, the cusp).
- `plans/FS114-L60-audit.md` **in full**, §1.3 (ii) L60-EQ closely (E1 is its equality case).
- FS-112's checkers and records (`plans/FS112-YB*-verification.md`): **by name and size only this round**; the object checker I lean on for calibration is
  FS114-YB3's (`tools/fs114_yb3_check.py`, `tools/fs114_yb3_run.py`, run unedited), which imports FS-112's builders for the strip, the disk and
  FS112-BOWTIE.
- **Not read:** every fenced file.

### 1a.2 The quotation check (standing rule 5) — `data/fs114/fs114-yb5/quotes.tsv`, through FS114-YB's `tools/fs114_yb_quotes.py` unedited

**24 of 24 FOUND** (`quotes.out`, exit 0): the standing rules' five Kooshi quotations (rules 0, 3, 4, 10); Y5's E1 and E2 (both its PINALL wording and
its §3 definition of E2); the definition of **simple** against `plans/FS114-Y4-construction.md`'s header; de Grey's Siamese against the claim list;
L60-LE and L60-EQ against `plans/FS114-L60-audit.md`; Y5's MU, ALT, POCKET, CASE, PXKILL and PINALL against its theorem table; the tactic-edge gloss
against `YB4-114-instance.md`; Y4-SIDES, Y4-W, Y4-DIAG against Y4's table; YB3-D2T against YB3's table; K1-PIN against the round-4 card. The tool's
self-test PASSED (`quotes-selftest.out`); my plants (`quotes-plant.tsv`): one word changed in SR0 and `B̄` turned into `B` in L60-EQ's outer clause
read **MISSING**, the faithful twin **FOUND** (`quotes-plant.out`, exit 1 as it must).

**By hand.** The instance's glosses — "**E1** is an edge at `p` of exactly 60°" and "**E2** is a blade whose counter-clockwise side is a unit arc centred at
its clockwise edge end" — are faithful to Y5's "E1 (an edge at `p` of length exactly `60°`)" and "E2 (a blade's counter-clockwise side a unit arc centred at
its clockwise edge end)"; the first drops the word "length" (the edge's angular length about its centre), which I restore.

**Not checkable in stage 1:** the seven statements, copied by the owner's script from `plans/FS114-Y6-construction.md` (fenced until stage 1 is
committed): stage 2's first step. The glosses of **tactic edge**, **pinwheel**, **ring** and **non-Siamese** have fenced sources (the proof side's
records); I work them as `YB4-114-instance.md` states them, and read **non-Siamese** as closures of distinct same-coloured tiles at distance at least 1.

### 1a.3 Reading points fixed before any verdict (my notation; Y5's where it is open)

- **The pinwheel** (Y5's header, verified by YB4 to agree with its own): `p = 0`; `q_j = e(φ_j)`, `j = 1 … 4` counter-clockwise; edge `j` leaves `p` in
  direction `θ_j = φ_j − 90°` along `ω(q_j)`; blade `t_{j+1}` (colour `j + 1`) has sector `[θ_j, θ_{j+1}]` at `p`, cone `α_{j+1} = φ_{j+1} − φ_j`; it is
  **inner** for edge `j` (`q_j ∈ cl t_{j+1}`) and **outer** for edge `j + 1`; `T_j` is the tactic tile of colour `j` at `q_j`. Edge `j` runs about `q_j` from
  `p` (angle `φ_j + 180°` about `q_j`) with increasing angle, length `ℓ_j` (Y5's `β_j`), to `w_j = q_j + e(φ_j + 180° + ℓ_j)`. Blade `t_{j+1}`'s boundary:
  edge `j`, then its clockwise side `L_j` from `w_j` to `q_j` (an inside part, then a ring part from `v_j = e(φ_j − λ_j)` to `q_j`), then its
  counter-clockwise side `M_j` from `q_j` to `w_{j+1}`, then edge `j + 1` back to `p`. `μ_j` (colour `m_j`) is the 5/6 tile along `M_j`, `Λ_j` the one along
  `L_j`'s inside part; `m̄` is the other of `{5, 6}`.
- **E1 at edge 1**: `ℓ_1 = 60°`, so `w_1 = q_1 + e(φ_1 + 240°) = e(φ_1 − 60°)`, a point of the ring. **E2 at blade `t_{c+1}`**: `M_c ⊂ ω(w_c)`.
- **Frame for E1** (used in every E1 item below; stated before reading any E1 text of Y6's): `φ_1 = 0°`, so `q_1 = (1, 0)`, and `q_4 = e(−60°)`,
  `C := e(−120°) = p + q_4 − q_1`. Angles at a vertex are directions from it, counter-clockwise from the positive `x`-axis. **The statements' own frame is
  not given in my brief**: E1OMEGA's "directions just above `270°`" at `q_4` is read in this frame (where `270°` is the tangent of `ω(C)` at `q_4`), and the
  reading is checked against Y6's frame at stage 2.
- **`(2, 1, 1, 0)` pattern** (HALF): counting, for each tile at `p`, the tactic edges it is inner for, in cyclic order (Y5 §4.3's G79 reading). A tile
  inner for both its edges is the "two-edge tile"; HALF takes it to be a width-1 Reuleaux triangle.

## Stage 1a — SAVED
