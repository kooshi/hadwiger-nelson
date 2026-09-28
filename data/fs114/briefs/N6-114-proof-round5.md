*Brief for job **FS114-N6**, the proof side of FS-114 (the unit-arc question), round 5. Opus 5.5. Written by the product owner, 2026-09-28.
**Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS114-N's, `data/fs114/briefs/N114-proof.md`, plus the
cards `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` in `data/fs114/briefs/`, plus this file; where they differ, this file wins.** Read
`data/fs114/briefs/STANDING-RULES.md` in full, rule 0 first.

## Where K1 stands (after round 4)

K1: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges.
- **The Reuleaux bowtie family is excluded at radius `√3`, by two routes, one per side:**
  - **N4-BOWTIE** (Γ-free lune rings; two minds, the general member's kill step sighted).
  - **FS114-Y4-RSTOPALL**, from the construction side: every Reuleaux bowtie, lune rings Γ-free or carrying arcs of `ω(p)`, the residual (R-V) included.
    It is one mind, and its blind check FS114-YB3 is running. Build nothing on it until that check reports; the owner will tell you.
- **N5** (your side, round 4): FS112's bends leave only (Q) and (R2) ring arcs at any degree-4 vertex (N5-BENDG); N5-UP and N5-DEG. Its blind check FS114-NB5
  is running.
- **Open:** the pinwheel, the `(2, 1, 1, 0)` patterns, three tactic edges in general, non-Reuleaux lenses and non-simple bowties. Only N5-PIN0 exists, the
  pinwheel's structure at radius `1 + ε`, with no contradiction there.

## What changes

- **Read first:** the cards; `plans/FS114-N5-proof.md` in full (N5-PIN0, N5-SIGHT, N5-BENDG, N5-UP: your tools); `plans/FS114-N4-proof.md`;
  `plans/FS114-NB4-verification.md`; `plans/FS114-L60-audit.md` (FS112-L60 is "at most 60°": never use the strict form).
- **Your record** is `plans/FS114-N6-proof.md` (the usual headings; SAVED stages). Working files go in `data/fs114/fs114-n6/`, tools in
  `tools/fs114_n6_*.py`, the report in `data/fs114/reports/FS114-N6.md`. Commit subjects are "FS114-N6: stage n".
- **Fences:** FS114-N's, plus every construction-side record, directory and tool (`plans/FS114-Y*`, `data/fs114/fs114-y*/`, `tools/fs114_y*`) and the
  construction verifiers' (`plans/FS114-YB*`, `data/fs114/fs114-yb*/`); the running proof verifier's (`plans/FS114-NB5-verification.md`,
  `data/fs114/fs114-nb5/`); FS-111's files.

## Your side, round 5

Each stage is SAVED and committed. Every step states its reading radius and the vertices of `F ∪ R` it reads (G83).
1. **K1-PIN: the pinwheel** (each tile at `p` inner for one tactic edge; N5-PIN0's centres `q_j = p + e(θ_j + 90°)`, cones `α_j ∈ [60°, 180°]`). Take it
   past radius `1 + ε`, toward 2, with N5-SIGHT, N5-UP's up-tile move, and N5-BENDG. Exclude it at a named radius, or name the member that survives. The
   120° cone (K1-PIN120) is N5's first target.
2. **The `(2, 1, 1, 0)` patterns and three tactic edges**: the same.
3. **If context remains, a prior-art lead for route T's aperiodic step** (Kooshi approved this lead, 2026-09-28; check it, it is not a directive).
   - The collapse gives `χ_CP = χ_m⁰` with no MR (row 130), so one may assume a random colouring invariant under rigid motions.
   - For random planar maps that are stationary, or unimodular after rooting at a typical vertex (the Palm measure), the **mass-transport principle** gives
     Euler's formula in expectation. That could replace N2-3's Følner averaging and bear on GAP-μ.
   - Read Benjamini–Schramm, Aldous–Lyons (*Processes on unimodular random networks*), and Angel–Hutchcroft–Nachmias–Ray on unimodular random planar
     maps. Fetch what is open; reading is in.
   - Say whether a stationary valid map, averaged over its rigid-motion orbit, gives a unimodular random map whose Euler count is route T's identity in
     expectation, and what that would close.

## Rules

As FS114-N's brief, with the paths above. **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is
Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is
left — a good report, never a failure. Your hand-back, and your final turn's text, is exactly: "FS114-N6 idle; no content in this hand-back; my reports
go to the owner by SendMessage".

Thank you.
