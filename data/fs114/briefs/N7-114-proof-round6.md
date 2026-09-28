*Brief for job **FS114-N7**, the proof side of FS-114 (the unit-arc question), round 6. Opus 5.5. Written by the product owner, 2026-09-28.
**Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS114-N's, `data/fs114/briefs/N114-proof.md`, plus the
cards `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` in `data/fs114/briefs/`, plus this file; where they differ, this file wins.** Read
`data/fs114/briefs/STANDING-RULES.md` in full, rule 0 first. **Statements are never paraphrased here.** Each result is named by its id and grade; read its
exact words in the record named.

## Where K1 stands (after round 5)

K1: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges.
- **The Reuleaux bowtie** (four tactic edges, two width-1 Reuleaux triangles corner to corner): excluded at radius `√3` in the non-Siamese simple class. Your
  side's route: N4-BOWTIE, N5-DEG, N5-R0, and NB5-RVKILL for the residual (R-V). Records: `plans/FS114-N4-proof.md`, `plans/FS114-NB4-verification.md`,
  `plans/FS114-N5-proof.md`, `plans/FS114-NB5-verification.md`. The construction side reached the same by another route, two minds, one blind.
- **The pinwheel** (four tactic edges, each tile at `p` inner for one): your side's **N6-NOQ** excludes it at `1 + ε` when its ring carries no (Q) arc (two
  minds, one blind: `plans/FS114-N6-proof.md`, `plans/FS114-NB6-verification.md`, with NB6-P60 and NB6-QSTART). The construction side excluded the (Q)
  family too, two minds, one blind, **outside two exceptions, E1 and E2**:
  - **E1**: an edge at `p` of exactly 60° (FS112-L60's equality case, a Reuleaux cap; `plans/FS114-L60-audit.md` gives the equality shape).
  - **E2**: a blade whose counter-clockwise side is a unit arc centred at its clockwise edge end.
- **Open:**
  - the pinwheel's E1 and E2;
  - the **`(2, 1, 1, 0)` patterns** and **three tactic edges** in general;
  - **non-Reuleaux lenses** at four tactic edges (N6-CENT: on a (Q)-free ring these need a (Q) arc);
  - the **non-simple** class.
- **"(Q) arc"** is FS-112's term: a boundary arc along `ω(p)` whose inner and outer colours are both carried at `p`. The NB6 instance's gloss, "outer colour
  carried at `p`", was too wide.

## What changes

- **Read first:** the records above (your side's and its verifiers'), then `plans/FS114-CV-verification.md` and `plans/FS114-CVB-verification.md`
  (CV-EXISTS: the whole NO is C114-LOCAL-F), and `plans/FS114-L60-audit.md`.
- **Your record** is `plans/FS114-N7-proof.md` (the usual headings; SAVED stages). Working files go in `data/fs114/fs114-n7/`, tools in
  `tools/fs114_n7_*.py`, the report in `data/fs114/reports/FS114-N7.md`. Subjects are "FS114-N7: stage n", neutral.
- **Fences:** FS114-N's, plus every construction-side record, directory and tool (`plans/FS114-Y*`, `data/fs114/fs114-y*/`, `tools/fs114_y*`) and the
  construction verifiers' (`plans/FS114-YB*`, `data/fs114/fs114-yb*/`) — FS114-Y6 is working the same open cases from its end now; FS-111's files.

## Your side, round 6

Each stage is SAVED and committed. Every step states its reading radius and the vertices of `F ∪ R` it reads (G83).
1. **Three tactic edges**: the `(2, 1, 1, 0)` patterns first, then every three-tactic configuration at a degree-4 vertex. Exclude each at a named radius, or
   name the survivor. N2-ENDS charges a degree-4 vertex with three tactic edges `−1` and with four `−2`, so **K1 needs both**. If three survive while four
   do not, say so plainly: route T's kill then becomes the joint payment (N3-JOINT, N3-PAY).
2. **The pinwheel's E1 and E2** from the proof side.
3. **If context remains, non-Reuleaux lenses** at four tactic edges.

## Rules

As FS114-N's brief, with the paths above. **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is
Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is
left — a good report, never a failure. Your hand-back, and your final turn's text, is exactly: "FS114-N7 idle; no content in this hand-back; my reports
go to the owner by SendMessage".

Thank you.
