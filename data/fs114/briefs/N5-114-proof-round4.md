*Brief for job **FS114-N5**, the proof side of FS-114 (the unit-arc question), round 4. Opus 5.5. Written by the product owner, 2026-09-28.
**Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS114-N's, `data/fs114/briefs/N114-proof.md`, plus the
cards `ROUND2-card.md`, `ROUND3-card.md` and `ROUND4-card.md` in `data/fs114/briefs/`, plus this file; where they differ, this file wins, then the
round-4 card.** Read `data/fs114/briefs/STANDING-RULES.md` in full, rule 0 first.

## What changes

- **Read first:** the three cards; then `plans/FS114-N4-proof.md` in full (round 3: N4-D, N4-G, N4-FIVE, N4-OWN, N4-LENS, N4-OPP, N4-TOP, and its §5.3–5.4
  on what is left) with its tools; `plans/FS114-N3-proof.md` (DR, N3-DR1/DR2, N3-CONT, N3-JOINT, N3-PAY); `plans/FS114-L60-audit.md` (L60 corrected);
  `plans/FS114-CV-verification.md` and `plans/FS114-CVB-verification.md`.
- **Your record** is `plans/FS114-N5-proof.md` (the usual headings; SAVED stages). Working files go in `data/fs114/fs114-n5/`, tools in
  `tools/fs114_n5_*.py`, the report in `data/fs114/reports/FS114-N5.md`. Commit subjects are "FS114-N5: stage n".
- **Fences:** FS114-N's, plus every construction-side record, directory and tool (`plans/FS114-Y*`, `data/fs114/fs114-y*/`, `tools/fs114_y*`), including
  the construction verifiers' (`plans/FS114-YB*`, `data/fs114/fs114-yb*/`); `plans/FS114-NB4-verification.md` and `data/fs114/fs114-nb4/` (a blind check of
  N4, running); FS-111's files. The cards give the other side's results.
- **FS112-L60 is corrected to "at most 60°"**: never use the strict form.

## Your side, round 4: finish K1

Every step states its reading radius and the vertices of `F ∪ R` it reads (G83). Each stage is SAVED and committed.
1. **K1-ΓRING**: the Reuleaux bowtie with a lune ring carrying arcs of `ω(p)`. Exclude it at `R ≤ 2` by N4's three moves (sector orders, the lens N4-LENS
   empties, a diameter), or name what survives. N4 registered p 0.6 that the moves suffice.
2. **K1-PIN**: every other degree-4 vertex with three or four tactic edges.
   - The shapes are: non-Reuleaux lenses at four tactic edges, the pinwheel (each tile inner for one edge), the `(2, 1, 1, 0)` patterns, and three
     tactic edges in general.
   - FS114-Y2-GAPS gives their local shape (on the round-3 card).
   - Exclude each at a named radius, or name the survivor.
3. **If K1 lands at a uniform radius:** state what route T then needs (K2, the extreme's shape; GAP-μ) and what C114-LOCAL-F still needs beyond K1, since the
   whole NO is a local exclusion about every four-colour vertex, not only the degree-4 ones with three or more tactic edges.

## Rules

As FS114-N's brief, with the paths above. **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is
Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is
left — a good report, never a failure. Your hand-back, and your final turn's text, is exactly: "FS114-N5 idle; no content in this hand-back; my reports
go to the owner by SendMessage".

Thank you.
