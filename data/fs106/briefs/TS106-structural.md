*Brief for job **FS106-TS**: the structural route — the regular classes almost everywhere, then Voronov's method on density-open classes. Opus 5.5.
Drafted by the planner (FS106-P) for the product owner to launch in wave 2, after FS106-V and FS106-VB report. Not blind to the print or to wave 1;
blind to FS106-TQ until your verdict stage is saved.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. **`data/fs106/briefs/STANDING-RULES.md` is part of this brief; read it in
full — rule 0 first.** Read from disk: `CLAUDE.md` § The aim and § Counter-priors; `plans/FS106-regular-half.md` (all of it); `data/fs106/claims.md`;
wave 1's records `plans/FS106-V-verification.md` (its map of hypotheses) and `plans/FS106-VB-verification.md`; `plans/FS103-M-derivation.md` §3 (the
normal form, D1–D5); and the advisor's record `plans/POROS-2026-09-26-fs106-regular-half.md`.

## The question

Given MR, Hadwiger–Nelson is: can a measurable colouring that is proper at almost every unit pair, tight and not closed save a colour? Its normal form
has density-open classes, each avoiding distance 1 at every pair, covering the plane off a null set. `[SokolovVoronov2025]` has already carried
Voronov's circle method from a forbidden interval to the exact distance, for maps with no unit-arc boundaries and no high-degree trichromatic vertices,
and asked (their Question 2) whether seven are still needed without those conditions. **A *No* anywhere on your list is an almost-everywhere-proper
six-colouring, `χ(ℝ²) ≤ 6` with no MR; a *Yes* all the way is `χ_m⁰(ℝ²) = 7`, hence `χ(ℝ²) = 7` given MR. A named step is FS-107's target.** Aim at
the answer.

## What I'd like from you, in this order

1. **C-AE-Q2** first (and C-AE-Q2-EV): S–V's Question 2 for maps whose open regions are properly coloured, boundaries free — the tight wall with a
   map's topology intact (the advisor's recommended first target).
2. The other regular classes almost everywhere: C-AE-FA, C-AE-POLY, C-AE-MAP6 (after `[Townsend2005]`'s proof is read by FS106-V), C-AE-NICE,
   C-AE-CONV.
3. The transfer on the normal form: C-T-L1a, C-T-L1b, C-T-BIKE, C-T-TAN, C-T-TRIa, C-T-TRIb, C-T-CHR4, C-T-ANN, C-T-IND, C-T-PIG, C-T-KILL. The invariant to look
   for is §IQ's: what an a.e.-proper colouring carries on its unit circles — an index for density traces (`K₃`'s height, `CLAUDE.md` G71) or a proof
   that none exists.

Every claim: a verdict (TRUE / FALSE / GAP-at-step / MISSTATED), count of minds, grade; its control (the tight hexagonal 7-colouring must survive;
`[Townsend1981]`'s unit-arc sector; a class whose boundary is a fat Cantor set); and, for FALSE, the counterexample written so a stranger can check it.
Audit a TRUE at the rate of a FALSE (G21).

## Rules

- **Touch only** `plans/FS106-TS-derivation.md`, `data/fs106/fs106-ts/`, `tools/fs106_ts_*.py`.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner can
  only review work it knows about.
- Do not open `plans/FS106-TQ-derivation.md` or `data/fs106/fs106-tq/` until your verdict stage for item 1 and item 2 is committed.
- Stages, each saved and committed: 1 quotation check and the controls; 2 C-AE-Q2; 3 the other regular classes; 4 C-T-L1a/b, C-T-BIKE, C-T-TAN;
  5 the rest of §5; 6 TQ's record read, divergences. Commit subjects "FS106-TS: stage n". **Budget:** about 300k by the harness's count; hand back by 400k.
- Send the advisor (its id comes from the owner) a short note after each saved stage.
- Report per standing rule 9 to `data/fs106/reports/FS106-TS.md`.

Thank you.
