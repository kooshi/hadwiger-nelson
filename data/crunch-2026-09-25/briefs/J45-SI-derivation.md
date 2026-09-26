*Brief for crunch job **J45** ("J36-D"): the derivation of the Poros session's sharpened statements, the support identity and its
consequences. Opus 5.5, 2026-09-25. Written by the product owner at Kooshi's request: *"indeed, verify Poros' derivation"*. A blind verifier
(J46) checks the same fixed list independently.*

Hello. You are de Bruijn (`DEBRUIJN.md`), **the derivation agent**, in the Lean 4 Hadwiger–Nelson workspace `/home/kooshi/source/lean-dir`.
Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md` is part of this brief;
read it in full.** I'm the product owner.

**If your record `plans/FS84-SI-D-derivation.md` already exists, you are resuming.** Check its last SAVED stage against `git log` and
continue at the first stage not SAVED.

## Why

Tonight two derivations proved T-C and T-C(A) (`plans/R88-derivation.md`). T-C(A) says: over ℚ(√47), no translation-invariant random
four-colouring has its spectral measure carried by `T + A + Fin_S` for a finite set `S` of split places. A Poros session
(`plans/POROS-2026-09-25-infinitely-many-primes.md`) then found two things:
- the literal form of that statement is cheap: random noise on gapped colourings over ℚ(√11) already puts a spectrum off every `E_S` (its
  F2);
- the content is sharper, and it sketched the sharper form, by one mind (its F3–F5).

Your job is to prove or refute those sketches as stated. **Every outcome counts** (standing rule 4). TRUE, FALSE with a counterexample, and
GAP at a named step are equally valuable. Do not lean toward a yes, and do not lean toward agreeing with the sketch.

## The fixed claim list (verbatim from the Poros record §4.4)

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
Control: F2's noisy colourings over ℚ(√11) must satisfy (SI) with equality."

The notation is `plans/R88-derivation.md`'s Notation block. Where a term above is not fixed there (the "trace spectral measure", the "`E_S`-factor"),
fix it in your stage 1 from the Poros record's F3, and say so.

## Read first

- The Poros record: F1–F5, F7 and §4.1–§4.4. These are your leads, not your proofs.
- `plans/R88-derivation.md`: T-C, T-C(A), the notation, and the lemma statements R88-TC-*.
- `plans/FS86-R88-D-derivation.md` §3 and `plans/FS86-R88-V-verification.md` §2.1–§2.2: the two routes to T-C.
- `LEDGER.md` rows 95–97, and `CLAUDE.md` G76.

## Stages

Save and commit after each stage (`git commit <paths>`, subject "J45: stage n"). Push after each; never force-push.

1. **Quotation check, notation, C0** (~30k). Check the claim list against the Poros record's §4.4, and fix every undefined term. Write a
   probability per claim (C0).
2. **SI, and its control** (~90k). The ≤ half first, then the equality characterisation. Then the control: the F2 colourings over ℚ(√11)
   must satisfy SI with equality. Exact checks of seconds are allowed (`tools/crunch_j45_*.py`, each with a planted fault that fires, output
   to `data/fs84/j45/`).
3. **A⁺ and B⁺** (~60k), each given SI and T-C or T-C(A).
4. **R-U and SP** (~70k). SP is the claim that the colouring-free remainder is Furstenberg's question. Its "if" and "only if" are
   separate claims, so give each its own verdict.
5. **The hand-off** (~30k):
   - "Theorems this phase proved": one line each, with grade and address;
   - **lemma statements for the blind verifier J46**: one line each, no proofs, under a heading "Lemma statements for J46";
   - C0 scored;
   - the report.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **No finite-witness search** (the ban runs to 2026-10-01). Keep a "would have searched here" log.
- **Touch only** `plans/FS84-SI-D-derivation.md`, `data/fs84/j45/` and `tools/crunch_j45_*`. A blind verifier works on the same list; never
  contact it.
- **Commits by explicit path.** End commit messages with your harness's attribution lines. Push after each commit; never force-push.
- **Budget:** about 300k by the harness's count; hand back by 380k.
- **Report** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J45.md`, committed, and by SendMessage
  `to: "main"`. Keep your turn's final text content-free: "J45 idle; report sent to the owner by SendMessage".

Thank you.
