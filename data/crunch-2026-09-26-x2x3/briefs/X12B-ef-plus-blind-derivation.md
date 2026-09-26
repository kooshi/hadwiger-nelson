*Brief for job **X12B**: a blind second derivation of one claim. Opus 5.5, 2026-09-26, 06:03. Written by the product owner. Its template is
J51V's brief (`data/crunch-2026-09-25/briefs/J51V-FS100-kronecker-verifier.md`). **Hard stop: 11:50 UTC**, whatever is left.*

Hello. You are Coxeter, a second mind, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md`
and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md` is part of this brief; read it in full.**

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-X12B-derivation.md`.

## Blind — the fences (for the whole job)

Do not open: `plans/FS100-X01D-derivation.md`; `plans/FS100-X01V-verification.md`; `plans/POROS-2026-09-26-x2x3-crunch.md`;
`data/crunch-2026-09-26-x2x3/poros/ef.txt`; anything under `data/fs100/x01d/` or `data/fs100/x01v/`; the reports
`data/crunch-2026-09-26-x2x3/reports/X01*.md`; the briefs `data/crunch-2026-09-26-x2x3/briefs/X01*.md`; any section of
`plans/CRUNCH-2026-09-26-x2x3-queue.md` except §2; the bodies of commits whose subjects start "X01D", "X01V" or "X23 advisor". Everything
else is open, including the papers below. If a search prints fenced text, stop reading it and log the touch.

## The claim (verbatim, from `plans/FS100-X01D-derivation.md` line 194; notation as in `LEDGER.md` rows 98, 113 and the queue's §2)

- **EF_F⁺.** "For every real number field `F`: every `U`-invariant finite positive Borel measure `μ` on `R̂` such that `h_μ(u*) = 0` for
  **one** non-torsion `u* ∈ U` satisfies `μ(R̂ ∖ (T + A)) = 0`. (No ergodicity; one element; the conclusion `T + A ⊆ E`.)"

And the weaker form it implies, from the queue's §2 list X01:
- **EF_F.** "For every real number field `F`: every `U`-invariant, `U`-ergodic probability measure `μ` on `R̂` such that `h_μ(u) = 0` for
  some non-torsion `u ∈ U` satisfies `μ(E) = 1`."

Notation: `F ⊆ ℝ` a real number field, `L = F(i)`, `U = U_F` the unit vectors (norm-one elements of `L/F`), `R = ℤ[U]`, `R̂` its Pontryagin
dual; `T` the torsion characters, `A` the archimedean ones, `E = ⋃_S (T + A + Fin_S)`.

## What you may use as given

Einsiedler–Fish 2010 (*Rigidity of measures invariant under the action of a multiplicative semigroup of polynomial growth on T*, ETDS 30
(2010) 151–157; arXiv:0804.3586, held at `data/crunch-2026-09-26-x2x3/poros/einsiedler-fish-0804.3586.pdf`) — read it in full; its method is
open to you, and transferring it is the natural route, but find your own way through the places of `L`. Einsiedler–Lindenstrauss 2021, held at
`~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf`. Standard entropy theory (Shannon–
McMillan–Breiman, the Abramov–Rokhlin and Ledrappier–Young facts you cite by statement), the product formula, weak approximation,
`LEDGER.md` rows 98, 105 and Lemmas C, C′ (`R = O′`).

## Stages

1. The quotation check; a C0 probability for EF_F⁺ and for EF_F before any derivation. Save.
2. The derivation: TRUE, FALSE with a counterexample, or GAP at a named step. The hard point to face squarely: a zero-entropy element thins
   neighbourhoods only at its own places, while the multipliers you would use expand other places — say exactly how your argument controls
   the other places, and count the usable multipliers up to height `M`. Save.
3. The write-up, per claim, with "Theorems this phase proved". Save. The report.

**Every outcome counts** (standing rule 4): a GAP with the step named, or a counterexample, is a complete result. **Do not lean toward TRUE.**
At 06:50, finish the sentence you are writing, save, and report whatever you have.

## Rules

- **No subagents, forks or workflows** — delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left.
- **The ban on finite-witness search runs to 2026-10-01**; keep a "would have searched here" log. Exact checks of seconds are fine, each with
  a planted fault watched firing (`tools/x12b_*.py`).
- Record `plans/FS100-X12B-derivation.md`; working files `data/fs100/x12b/`. Never edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`,
  `BIBLIOGRAPHY.md`, or another job's files.
- Commits by explicit path, subjects "X12B: stage n", never amend, push after each commit (on a ref-lock race, `sleep 4` and retry), never
  force-push; end with your harness's attribution lines.
- **Budget:** about 200k by the harness's count; hand back by 280k.
- Report (standing rule 9) to `data/crunch-2026-09-26-x2x3/reports/X12B.md`, committed, and by SendMessage to "main"; final turn text
  "X12B idle; report sent to the owner by SendMessage".

Thank you.
