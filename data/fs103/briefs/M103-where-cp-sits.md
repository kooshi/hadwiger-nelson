*Brief for job **FS103-M**: the plan's Phase 3 — where `χ_CP(ℝ²)` sits against `χ_m⁰(ℝ²)`, `χ_m(ℝ²)` and `χ_B(ℝ²)`. Opus 5.5, 2026-09-26.
Written by the product owner. **Sized for about 250k harness tokens.** A blind check of your result may follow; write for it.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`, deriving. **`data/fs103/briefs/STANDING-RULES.md` is part of this
brief; read it in full.** You are not blind: every file is open to you.

## Why

Two blind verifiers found FS-103's load-bearing step TRUE. So, given MR (`LEDGER.md` row 120, [hand]), at [hand, two blind]:
**`χ(ℝ²) = χ_CP(ℝ²) = χ(ℚ(√635087)²) = χ(F_dG²)`** (`plans/FS103-V1-verification.md`, `plans/FS103-V2-verification.md`, stage 3 of each).
That is a result about the plane's *random-colouring* number, `χ_CP` (definition: `data/fs103/claims.md` D-CP (b), verbatim there).
Which known open problem it collapses Hadwiger–Nelson to depends on where `χ_CP` sits against the measurable chromatic numbers. Kooshi:
*"If we end up at a wall which collapses HN to another known open problem, that in itself would be a writeup."*

What the two verifiers found (both, independently):
- **C-FMT (a), (b) TRUE:** every CP colouring has a jointly measurable version, hence `χ_m⁰ ≤ χ_CP`.
- **(c) GAP:** in V1's words, "the Følner limit of random translates need not be continuous in probability".
- **(d) GAP:** V1: "colouring the null set of non-density points (the rest proved: density-point classes avoid distance 1 everywhere)".
- **C-CPM (`χ_CP ≤ χ_m`) GAP** without MR.

The advisor's sketch `χ_CP = χ_m⁰` (A-E5, one mind, unreviewed; `plans/POROS-2026-09-26-fs103-collapse.md`) needs exactly the direction
that (c) says is open. The definitions of `χ_m`, `χ_m⁰` and `χ_B` are `data/fs103/claims.md` D-M.

## Read first

- **`[Falconer1981]` first-hand** — now held, at `~/source/library/papers/falconer-1981-realization-distances-measurable-subsets-covering-Rn-jcta-31-184-189.pdf`
  (Kooshi's upload). Record exactly what it proves and whether its classes must be proper everywhere or only almost everywhere. The gate
  read it second-hand (`plans/FS103-G-prior-art.md` §3); compare the two.
- The C-FMT and C-CPM sections of both verifiers' records; the advisor's A-E5; the gate's record §2.3 (Payne 2009's "ambiguous chromatic
  number"; `[BachocEtAl2014]`'s null-set-tolerant chromatic number; Shelah–Soifer 2003; Soifer 2024 Open AC Problem 62.14).

## Questions

1. **(c) `χ_CP(ℝ²) ≤ χ_m⁰(ℝ²)`**: from a measurable `k`-colouring proper at almost every edge, build a CP `k`-colouring. Derive, or name the
   exact obstruction with a counterexample to the naive Følner route. Try at least these three:
   - choosing a better colouring, one with a uniform modulus of `L¹`-continuity under translation;
   - regularising the limit;
   - Bachoc et al.'s operator framework.

   **Positive control:** the randomly translated hexagonal 7-colouring. **Negative control:** the advisor's one-dimensional A-E3,
   `Cay(ℝ, {±1, ±√2})` with `χ = 2 < 3 = χ_CP`. Before trusting any argument for (c), check that it does not prove `χ_CP ≤ 2` there.
2. **(d) `χ_m⁰(ℝ²) = χ_m(ℝ²)`**: colour the null set. V1 proved the density-point step; finish it or name the obstruction.
3. **(e) `χ_B(ℝ²)`** against the others, only as far as (1) and (2) reach.
4. **The statement the collapse then makes, given MR, at the grade reached.** Name the known problem precisely and cite where it is posed.
   If (1) and (2) close: `χ(ℝ²) = χ_m(ℝ²)` given MR. That reads as the plane not being ambiguous (Payne); say what it answers, what it does
   not (Shelah–Soifer's axiom question; MR is [hand]), and state it at the grade reached.

## Stages

1. Falconer first-hand; the quotation check of every text above. Save.
2. Question 1 (controls first). Save.
3. Questions 2–4. Save; the report.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- The ban (standing rule 3). **Do not lean toward the flattering answer** (G21): a named obstruction is as valuable as a proof.
- **Touch only** `plans/FS103-M-derivation.md` (record, with "Theorems this phase proved"), `data/fs103/fs103-m/`, `tools/fs103_m_*.py`.
- **Commits:** by explicit path, subjects "FS103-M: stage n"; never amend; push; never force-push.
- **Report** (standing rule 9) to `data/fs103/reports/FS103-M.md`, committed, and by SendMessage to "main". Final turn text: "FS103-M idle;
  report sent to the owner by SendMessage".

Thank you.
