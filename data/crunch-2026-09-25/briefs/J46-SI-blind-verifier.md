*Brief for crunch job **J46**: a blind verifier of a fixed claim list about random four-colourings and their spectral measures.
Opus 5.5, 2026-09-25. Written by the product owner, before any proof of these claims exists in the repository.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **a blind verifier**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief;
read it in full.** I'm the product owner.

**If your record `plans/FS84-SI-V-verification.md` already exists, you are resuming.** Check its last SAVED stage against `git log` and
continue at the first stage not SAVED.

## Your job

Decide each claim below **by your own route**: TRUE with a proof, FALSE with a counterexample, or GAP at a named step. **Every verdict
counts equally** (standing rule 4). Do not lean toward a yes, and do not lean toward agreeing with anyone. A derivation job (J45) is working
on the same claims now. Your value is that you have not seen its route or anyone's sketch.

## Fenced until your blind phase (stage 2) is committed

Do not open:
- `plans/POROS-2026-09-25-infinitely-many-primes.md`, the whole file;
- `plans/FS84-SI-D-derivation.md`;
- `data/fs84/j45/`, and `tools/crunch_j45_*` and `tools/crunch_j36_*`;
- the J45 brief;
- the reports `data/crunch-2026-09-25/reports/J36.md`, `J37.md`, `J45.md`;
- any `plans/POROS-2026-09-2*-wanted-poster-*.md`;
- `plans/FS84-close-inventory.md`;
- the crunch index `plans/CRUNCH-2026-09-25-INDEX.md`;
- the body of any commit whose subject starts "J36", "J37" or "J45".

**You may read:**
- `CLAUDE.md` and `LEDGER.md`;
- `plans/R88-derivation.md` (the notation, T-C, T-C(A), and the lemma statements filed there);
- the two routes to T-C (`plans/FS86-R88-D-derivation.md`, `plans/FS86-R88-V-verification.md`);
- `plans/FS86-derivation.md`, `plans/FS89-derivation.md`, `plans/FS91-derivation.md`;
- the cited papers.

## The fixed claim list

"Let `F` be a real number field, `R = ℤ[U_F]`, and let `σ_μ` be the trace spectral measure of the tetrahedral embedding of a
translation-invariant random proper four-colouring `μ` of `Cay(R, U_F)`. For a finite set `S` of split places let `E_S = T + A + Fin_S`,
and let `E = ⋃_S E_S`. Prove or refute:
**(SI)** `∫_{R̂∖E_S} Re χ(u) dσ_μ(χ) ≤ 0` for every `u ∈ U_F`, with equality for every `u` if and only if the `E_S`-factor of `μ` carries
a translation-equivariant proper four-colouring `c′` with `c(x) ∈ supp P(c(x) = · | E_S-factor)` almost surely;
**(A⁺)** over ℚ(√47), given T-C(A): for every `μ` and every finite `S`, some `u` gives strict inequality;
**(B⁺)** over a type-(B) field, given T-C: if equality holds for every `u`, then `μ` is carried by Pull;
**(R-U)** every `U_F`-invariant finite measure on `R̂` gives `E_S ∖ (T + A)` measure 0;
**(SP)** a `U_F`-invariant finite positive measure `τ` on `R̂` with `τ(E) = 0` and `∫ Re χ(1) dτ < 0` exists if and only if some
`U_F`-invariant finite measure on `R̂` with `τ(E) = 0` is not a multiple of Haar measure.
Control: noisy colourings over ℚ(√11) — a four-colouring pulled back from the plane at 7, with its gapped points recoloured independently at
random — must satisfy (SI) with equality."

*(Quoted verbatim from its source, except the control line: the source reads "F2's noisy colourings over ℚ(√11)", naming a
section of a fenced file, and the owner has replaced that name with a description of those colourings. Log this in your quotation check.)*

The notation is the Notation block of `plans/R88-derivation.md`. Some terms are not fixed there: the "trace spectral measure" (the sum
over the three coordinates of the tetrahedral embedding's spectral measures) and the "`E_S`-factor" (the factor σ-algebra of the vectors
whose spectral measure is carried by `E_S`). Fix each such term yourself in stage 1 and say how you read it. **If a claim is false or
ill-posed as written, say so with the reason**; that is a verdict, not a failure.

## Stages

Save and commit after each stage (`git commit <paths>`, subject "J46: stage n"). Push after each; never force-push.

1. **Readings and C0** (~30k). Fix every term. Write a probability per claim before deriving.
2. **The blind phase** (~170k, at most 60% of your budget). Give a verdict per claim, each with its proof, counterexample or named gap.
   Exact checks of seconds are allowed (`tools/crunch_j46_*.py`, each with a planted fault that fires). Save and commit **before opening
   anything fenced**.
3. **The comparison** (~60k). Open J45's record once its hand-off is committed (`git log -- plans/FS84-SI-D-derivation.md`). For each
   claim, record a divergence of truth, route or wording, and say whether the routes are independent. If your blind route stalled on a
   claim, re-derive J45's lemma statements from their statements alone. If J45's record is not complete when you get here, save and report
   the comparison rows as pending; never wait or poll.
4. **The report.**

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **No finite-witness search** (the ban runs to 2026-10-01). Keep a "would have searched here" log.
- **Touch only** `plans/FS84-SI-V-verification.md`, `data/fs84/j46/` and `tools/crunch_j46_*`. Never contact J45.
- **Commits by explicit path.** End commit messages with your harness's attribution lines. Push after each commit; never force-push.
- **Budget:** about 300k by the harness's count; hand back by 380k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J46.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J46 idle; report sent to the owner by SendMessage".

Thank you.
