*Brief for job **FS114-Y5**, the construction side of FS-114 (the unit-arc question), round 5. Opus 5.5. Written by the product owner, 2026-09-28.
**Sized for about 400k tokens by the harness's count, as guidance** (standing rule 10).*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **Your brief is FS114-Y's, `data/fs114/briefs/Y114-construction.md`, plus
the cards `ROUND2-card.md`, `ROUND3-card.md`, `ROUND4-card.md` in `data/fs114/briefs/`, plus this file; where they differ, this file wins.** Read
`data/fs114/briefs/STANDING-RULES.md` in full, rule 0 first.

## Where K1 stands (after round 4)

K1: a degree-4 vertex of a non-Siamese valid map has at most two tactic edges.
- **The Reuleaux bowtie family is excluded at radius `√3`** (non-Siamese, simple), by two derivations blind to each other, both one mind:
  - FS114-Y4-RSTOPALL (your side; its blind check FS114-YB3 is running);
  - the proof side's N4-BOWTIE (Γ-free rings, NB4-verified) with its verifier's kill of the last residual (R-V) at `√3`.
- **Open:** the **pinwheel** (each tile at `p` inner for one tactic edge), the **`(2, 1, 1, 0)` patterns**, **three tactic edges** in general,
  **non-Reuleaux lenses** at four tactic edges, and **non-simple bowties**. The pinwheel's only held structure is the proof side's N5-PIN0, at radius
  `1 + ε`:
  - centres `q_j = p + e(θ_j + 90°)` and cones `α_j ∈ [60°, 180°]`;
  - `t_j ⊂ B̄(p, 1) ∩ B̄(q_{j−1}, 1) ∖ B(q_j, 1)`, its ring contacts within 60° of `q_{j−1}` and at least 60° from `q_j`;
  - no contradiction at that radius.

## What changes

- **Read first:** the cards; `plans/FS114-Y4-construction.md` in full (SIDES, UPDOWN, W, LUNE, DIAG: tools that may carry over) with `tools/fs114_y4_*`;
  `plans/FS114-Y2-construction.md` (the design method); `plans/FS114-YB2-verification.md` with its checker; `plans/FS114-L60-audit.md` (FS112-L60 is "at most
  60°").
- **Your record** is `plans/FS114-Y5-construction.md` (the usual headings; SAVED stages). Working files go in `data/fs114/fs114-y5/`, tools in
  `tools/fs114_y5_*.py`, the report in `data/fs114/reports/FS114-Y5.md`. Commit subjects are "FS114-Y5: stage n".
- **Fences:** FS114-Y's, plus every proof-side record, directory and tool (`plans/FS114-N*-proof.md`, `data/fs114/fs114-n*/`, `tools/fs114_n*`) and the
  proof verifiers' (`plans/FS114-NB*`, `data/fs114/fs114-nb*/`); the running construction verifier's (`plans/FS114-YB3-verification.md`,
  `data/fs114/fs114-yb3/`); FS-111's files.

## Your side, round 5: K1's other killing tests

Objects by formula, checked exactly by a calibrated checker (YB's or YB2's, unedited, beside yours, which must accept the five controls first). Every stop
is read as a statement about every valid map (G79) and sent to the owner at once. Each stage is SAVED and committed.
1. **The pinwheel.** A non-Siamese valid fragment by formula holding a degree-4 vertex whose four edges are tactic in the pinwheel arrangement.
   - Start at the 120° cone, and push the fragment's radius about `p` as far as it goes, naming where it stops.
   - Or derive the obstruction at a named radius.
   - A pinwheel fragment of radius `R` refutes any proof of K1 that reads less than `R`.
2. **Three tactic edges**: the `(2, 1, 1, 0)` patterns and the rest. The same.
3. **Non-Reuleaux lenses**, if context remains: four tactic edges whose two inner tiles are not Reuleaux triangles.

State each object's class: fragment or map, Siamese or not, simple or not, and the radius it holds about `p`.

## Rules

As FS114-Y's brief, with the paths above. **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is
Kooshi's budget decision, and the owner can only review work it knows about. If the work outgrows your context, stop at a SAVED stage and say what is
left — a good report, never a failure. Your hand-back, and your final turn's text, is exactly: "FS114-Y5 idle; no content in this hand-back; my reports
go to the owner by SendMessage".

Thank you.
