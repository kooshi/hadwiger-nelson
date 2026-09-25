*Brief for crunch job **J06**: the reframe and subplan of milestone M3, "colourings no periodic colouring or character gives": FS-76 in
rank one, and FS-64 at five colours over ℚ(√167). Opus 5.5, 2026-09-25. Written by the crunch planner
(`plans/CRUNCH-2026-09-25-queue.md` §2). The reframe template is J03's brief; this brief changes what is marked.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the milestone's planner**, in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. The house rules are `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md`; read all three from disk, since the
copy loaded at your start may be stale. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief; read it in full.**
**`data/crunch-2026-09-25/briefs/J03-M1-reframe.md` is your template** for how the reframe runs: its sections "What you are doing" and
"What to produce" apply here, with two verdict columns, one per question below.

## Why this milestone

Every lower bound above five must cross the four-colour wall: at four colours a colouring carries no height and no slope (G71, G73). And
every falsifier of the conjecture at the exposed fields must now be a colouring that no character gives (rows 92, 96). M3 asks two
questions about such colourings, each small enough for hours.

## The two questions

1. **FS-76 in rank one** (`plans/STUB-four-colour-inheritance.md`, read in full, with `plans/FS79-derivation.md` T3, T30 and T34–T36).
   The stub, verbatim: "the rank-1 criterion is exact (T35: `P ≠ F` iff every cyclic phase is rigid and a wall exists), and a scan to
   `max D = 14`, `|D| ≤ 5` found no counterexample (T36). **Rank 1 closes if 'every phase rigid ⟹ no wall' is proved** (the reading,
   unrefuted on 377 of 377 all-rigid sets) — the cheapest open item here." This is `[Ellenberg2018]`'s question at `k = 4` on `ℤ`.

   **Staffing, by the advisor's advice, which the planner took:** one derivation agent (J18), gated at about 2.5 hours, then a blind
   verifier (J20) with a fixed list you write now. **A second mind (J19) is launched only if J18 stalls at a named step, and then on that
   step.** The reason: rank one is one-dimensional subshift territory (the strongly connected components and transient paths of the
   window graph, with walls as transient separations), so its route is known in outline, and the protocol gives such milestones the
   seventh run's shape (`plans/PROTOCOL-competitor-and-advisor.md` §3).
2. **FS-64 at five colours over ℚ(√167)** (`plans/STUB-adelic-window-colouring.md`, read in full, with FS-86's FS86-CL1 in
   `plans/FS86-derivation.md` and `LEDGER.md` row 92). Can a measurable window colouring over finitely many places five-colour ℚ(√167)'s
   plane?
   - FS86-CL1 excluded four colours there.
   - The FS-59 stub's note says why five is untouched, verbatim: "at five colours the window count fails at the real place (Croft's
     `m₁ ≥ 0.22936 > 1/5`), so the five-colour question is untouched."
   - The conjecture predicts at least six at ℚ(√167). A five-colour window colouring would falsify it. A proof that none exists removes
     one more kind of falsifier, beside the character colourings row 96 removed.

   Staffing is one derivation (J21) plus a blind verifier (J22).

## What changes from the template

- **§G has two columns.**
- **§PA:** for question 1, symbolic dynamics in its own words (one-dimensional subshifts of finite type, periodic points, "forced
  periodicity", the MathOverflow thread `[Ellenberg2018]`, `[CGHO2025bg]` §6.2.1). For question 2, cut-and-project and model sets,
  measurable colourings, and Croft's bound.
- **§IQ for each question.**
- **The ban:** no scans. T36's scan to `max D = 14` is the kind of search the ban forbids, and it is not to be extended. Any exact check
  must verify a derived claim.

## What to produce

- **The plan, `plans/M3-exotic-colourings.md`.**
- **The briefs:** J18, J20 (its fixed list written now), J21 and J22. Also write the brief *skeleton* for J19, to be completed from
  J18's stall if one comes.
- **Your report,** standing rule 9. RESULT carries the counts and §IQ's two structural forms.

## Stages

These are J03's five stages, with the same saves.
- **Paths:** `data/m3/j06/`.
- **Budget:** about 350k in the harness's count. Hand back by 420k.
