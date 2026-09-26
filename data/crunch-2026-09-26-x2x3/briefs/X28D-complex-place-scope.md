*Brief for job **X28D**: how much of the complex-place case of `χ(F²) ≥ min(L(F), 5)` is real. Opus 5.5, 2026-09-26, 06:59. Written by the
product owner on Kooshi's remark. **Stop at 12:50 UTC**, whatever is left.*

Hello. You are de Bruijn (`DEBRUIJN.md`), a derivation agent, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read
`CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read it
in full** (its clock is replaced by the stop above). If your record exists, you are resuming: continue at the first stage not SAVED.

## Kooshi's words (2026-09-26, verbatim)

> "iirc we have a previous proof about cube roots that they're fairly impotent on the chromatic number"

## Context

Wave 3 derived, given MR, `χ(F²) ≥ min(L(F), 5)` for every real number field `F` (X23D, X23V; `plans/FS100-X23D-derivation.md` §3.3). Its
complex-place step (a real field with a non-real embedding, like ℚ(∛2)) was disputed by X25B (`X25B-G1`) and ruled answered by X29C (an
independence-ratio bound survives removing edges, so the complex place's factor is bounded by its circle subgraph's `m₁`). The held result
Kooshi recalls is **FS54-T2**: "the 2-adic trichotomy (split/ramified/inert at a prime above 2) and its corollary: every odd-degree real number
field is 2-colourable" (`LEDGER.md` § B; `plans/FS54-derivation.md` T2; `[Moorhouse2010]` §7.1), so ℚ(∛2)'s plane is bipartite. The question is
how much of the complex-place case survives it. Two further held facts: `χ(F²)` is monotone in `F` (a subfield's plane is an induced subgraph),
and G35/G56's parity arguments.

## The claims (posed by the owner; decide each)

- **CP-1.** "Every real number field `F` with a non-real embedding and `L(F) ≥ 5` has even degree `≥ 4`." (From FS54-T2 and the definition of
  `L`.)
- **CP-2.** "Every real number field `F` with a non-real embedding and `L(F) ≥ 5` contains a totally real subfield `F₀` with `L(F₀) ≥ 5`" — so
  its `χ(F²) ≥ 5` would follow from the totally real case by monotonicity. TRUE, FALSE with an explicit field (for example a compositum of a
  cubic with a quadratic, as in G56's 27 example), or GAP.
- **CP-3.** "For an extension `E/F` of odd degree of real number fields, `L(E) = L(F)` (and, given MR, `χ(E²) = χ(F²)` wherever `L(F) ≤ 5`)." The
  general form of "cube roots are impotent". TRUE, FALSE with a counterexample, or GAP at a named step.

Exact arithmetic of seconds (PARI: splitting of primes, residue degrees, stable places) is allowed, each check with a planted fault watched firing
(`tools/x28d_*.py`); a complete enumeration of a finite set whose extent a derivation fixed first is at the ban's edge and logged as such; "try
fields until one works" is out.

## Stages

1. The quotation check (FS54-T2's statement and its proof's parity step); a C0 probability per claim. Save.
2. CP-1, CP-2. Save.
3. CP-3; the write-up with "Theorems this phase proved"; the report.

**Every outcome counts** (standing rule 4). **Do not lean toward TRUE**: a field that is not totally real, has `L ≥ 5`, and has no totally real
subfield with `L ≥ 5` is as valuable as a proof.

## Rules

- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- The ban on finite-witness search holds (to 2026-10-01): keep a "would have searched here" log.
- Record `plans/FS100-X28D-derivation.md`; working files `data/fs100/x28d/`. Never edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`,
  `BIBLIOGRAPHY.md` or another job's files. Neutral commit subjects ("X28D: stage n"); never amend; push after each commit (on a ref-lock race,
  `sleep 4` and retry); never force-push; end with your harness's attribution lines.
- **Budget:** about 150k by the harness's count; hand back by 220k.
- Report (standing rule 9) to `data/crunch-2026-09-26-x2x3/reports/X28D.md`, committed, and by SendMessage to "main"; final turn text "X28D idle;
  report sent to the owner by SendMessage".

Thank you.
