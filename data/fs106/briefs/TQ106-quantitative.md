*Brief for job **FS106-TQ**: the quantitative route — is Hadwiger–Nelson's measurable form the stability of Voronov's theorem? Opus 5.5. Drafted by the
planner (FS106-P) for the product owner to launch in wave 2. Not blind to the print or to wave 1; blind to FS106-TS until your verdict stage is saved.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs106/briefs/STANDING-RULES.md` is part of this brief; read it in
full — rule 0 first.** Read from disk: `CLAUDE.md` § The aim and § Counter-priors; `plans/FS106-regular-half.md`; `data/fs106/claims.md` (§0, §1, §6);
`plans/FS103-M-derivation.md` §2 (the weak-* compactness M1) and §3 (D1–D5); `LEDGER.md` row 130; `[Voronov2023]`; `[SokolovVoronov2025]` §9; and the
advisor's record `plans/POROS-2026-09-26-fs106-regular-half.md` with `data/fs106/fs106-a/`.

## The question

`[SokolovVoronov2025]` §9: "if any upper bound µ(C1 ∪ · · · ∪ C6 ) ≤ µ∗6 < 1 on the fraction of the plane that can be correctly colored in 6 colors with
forbidden interval [1− ε, 1 + ε], ε > 0 were established, it would follow definitively that χmap (R2 ) = 7." The planner and the advisor, independently
and at one mind each, read more into it: deleting a vanishing fraction turns any almost-everywhere-proper colouring into one with a band forbidden
(C-Q-REM), and M1's compactness turns partial six-colourings with vanishing holes into a stationary six-colouring (C-Q-COMP); if both hold,
`χ_m⁰(ℝ²) ≥ 7` exactly when `lim_{ε→0} µ₆(ε) < 1` (C-Q-EQ) — Hadwiger–Nelson's measurable form, given MR, would be one stability statement about
Voronov's theorem (C-Q-STAB), whose named step is Voronov's Lemmas 2.2 and 6.1 with holes (C-Q-HOLE). `[Parts2020c]` six-colours more than
99.985698 % of the plane, so any `δ` is small. **A FALSE on C-Q-STAB is a construction and gives `χ(ℝ²) ≤ 6` with no MR; a TRUE gives `χ(ℝ²) = 7`
given MR.** Aim at the answer.

## What I'd like from you, in this order

1. C-Q-REM (both halves, the pointwise core its own line), C-Q-COMP (i) and (ii), C-Q-EQ — derivations at [hand], each with its control (the tight
   hexagonal 7-colouring; a colouring whose `L¹` modulus degrades at infinity, as in `plans/FS103-M-derivation.md` §2.4).
2. C-Q-STAB and C-Q-HOLE: where Voronov's argument meets a hole of small density, what survives, and what a hole must swallow to stop it. A route
   that never locates a trichromatic point is allowed.

Every claim: verdict (TRUE / FALSE / GAP-at-step / MISSTATED), count of minds, grade. Audit a TRUE at the rate of a FALSE (G21): the flattering result
here is "the equivalence holds and makes the problem easy"; it moves the difficulty, it does not remove it.

## Rules

- **Touch only** `plans/FS106-TQ-derivation.md`, `data/fs106/fs106-tq/`, `tools/fs106_tq_*.py`.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- Do not open `plans/FS106-TS-derivation.md` or `data/fs106/fs106-ts/` until your verdict stage for item 1 is committed.
- Stages: 1 quotation check and controls; 2 C-Q-REM; 3 C-Q-COMP and C-Q-EQ; 4 C-Q-STAB and C-Q-HOLE; 5 TS's record read, divergences. Commit subjects
  "FS106-TQ: stage n". **Budget:** about 300k by the harness's count; hand back by 400k.
- Send the advisor (its id comes from the owner) a short note after each saved stage.
- Report per standing rule 9 to `data/fs106/reports/FS106-TQ.md`.

Thank you.
