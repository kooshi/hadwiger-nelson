*Brief for crunch job **J09v**, milestone M1 (FS-91): a blind second reading of J09's "no mixing" theorem and its two corollaries.
Opus 5.5, 2026-09-25. Written by the product owner.*

Hello. You are de Bruijn (`DEBRUIJN.md`), acting as **a blind verifier** in the Lean 4 Hadwiger–Nelson workspace
`/home/kooshi/source/lean-dir`. Read `CLAUDE.md`, `WORKFLOW.md` and `DEBRUIJN.md` from disk. **`data/crunch-2026-09-25/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** I'm the product owner; the verdicts are yours.

**If your record already exists, you are resuming:** read it and this brief, check the last SAVED stage against
`git log -- plans/FS91-S1V-no-mixing.md`, and continue at the first stage not SAVED.

## Why

M1's three-colour theorem (S1–S3: for every real number field, `χ(F²) ≤ 3 ⟺ L(F) ≤ 3`, and the conjecture's `L ≤ 4` clause) has two
independent derivations, J02 and J09. But J09 proved something sharper, by one mind only — a classification of **every** three-colour
band character — and M1's close is about to file it. Its report says: *"a second reading before a ledger row rests on them alone."*
You are that reading. **Every verdict counts, and none is preferred** (Kooshi: *"All novel knowledge is a success"*); a FALSE with a
counterexample or a GAP with the step named is as valuable as TRUE. Audit it as hard as a result you would dislike (`CLAUDE.md` G21).

## The claims, verbatim

From J09's record `plans/FS91-S0FV-three-colours-blind.md`, its "Theorems this phase proved" list (lines 364–367; the record itself is
fenced from you):

> - **J4** — no mixing: for a real number field with no ramified stable dyadic prime, `Θ₃(R_F)` is exactly the `4N₃` additive characters,
>   one quadruple per prime above 3 of residue field `𝔽₃`. [hand, one mind; Weil external] — §2.5.
> - **J4-C** — S1 for every real number field; `χ(F²) = 3 ⟺` non-bipartite and a prime above 3 of residue field `𝔽₃`. [hand, one mind] — §2.6.
> - **J4-A** — S1 for every algebraic subfield of ℝ and every purely transcendental extension of one (places; König; G63). [hand, one mind] — §2.6.

Notation is `CLAUDE.md` § Notation and FS-89's (`plans/FS89-derivation.md`, "Notation, fixed once"): `R_F = ℤ[U_F]` the ring the unit
vectors of `F(i)` generate; `Θ_k(R) = {θ ∈ Hom(R, ℝ/ℤ) : θ(U) ⊆ [1/k, 1 − 1/k]}`; "stable" = conjugation-stable prime of `F(i)`;
"additive character" = one factoring through a residue map to `𝔽₃` (read J09's "additive" in `[Fischer1990]`'s sense, and say which
reading you use). `N₃` is the number of primes above 3 of residue field `𝔽₃` (read the claim's "one quadruple per prime" as fixing it).
Where a term is ambiguous, state your reading and verdict under it.

## Verified inputs you may use (statements only)

- **CLG** (M1's class theorem; J07's derivation, blind-checked by J10): for every real number field and every `k ≥ 2`, a band
  `k`-character of `R_F` exists iff some stable place carries one at some level. Its lemma statements: `data/fs91/j07/lemma-statements.md`.
- **Lemma C/C′** (J07, re-derived blind by J10): `R_F/NR_F ≅ ∏_{p|N} R̄_p/NR̄_p`; equal to `∏ O_𝔓/N` except possibly at a ramified
  stable dyadic place — in the same file.
- **J01-7** (two blind readings): `Θ_k(R_F) ⊆ T_{N_k} + A(R_F)` for every `F ⊆ ℝ` and `k`, with `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`.
- `[Fischer1990]` (held; Thms 8–10), `[Krebs2022]`, `plans/FS81-derivation.md` (T3, T4, T8), `plans/FS89-derivation.md` §1–§9a.

## Fenced until your verdicts (stage 3) are committed

- J09's record `plans/FS91-S0FV-three-colours-blind.md` (beyond the quoted lines), `data/fs91/j09/`, `tools/crunch_j09_*`, J09's report;
- J02's record `plans/FS91-S0F-three-colours.md`, `data/fs91/j02/`, `tools/crunch_j02_*`, J02's report (the other three-colour route);
- `plans/FS91-character-local-global.md`, `plans/FS91-derivation.md`, `plans/FS91-close-inventory.md`, `plans/FS91-PA-close.md`,
  `plans/CRUNCH-2026-09-25-INDEX.md`; every other crunch record and report; every scratch directory but your own.
After stage 3 you may open J09's and J02's records to write the divergence table.

## Stages

1. **Quotation check and C0 (≈ 20k):** check the quotations you may check; a probability per claim before any derivation. Save.
2. **J4 blind (≈ 100k):** derive or refute it. Test it on named fields with exact arithmetic of seconds (`tools/crunch_j09v_*.py`, with a
   planted fault that fires for its own reason): at least ℚ(√3) (a prime above 3 of residue field 𝔽₃?), ℚ(√7), ℚ(√11), ℚ(√2,√3), and one
   field with two such primes if you can name one; and one field with a ramified stable dyadic prime, to see what the hypothesis excludes.
   Save.
3. **J4-C and J4-A (≈ 60k):** from J4 (as you found it) and the inputs; for J4-A say exactly what "place" argument reaches an algebraic
   or purely transcendental field, and whether the bipartite case is handled. Save; report to me (STAGE 3 SAVED).
4. **Divergence table (≈ 30k):** open J09's and J02's records; every difference of truth, scope or route. Save and report.

## Rules

- **No subagents.** You may not spawn subagents, forks or workflows — delegation here is one level deep (`CLAUDE.md` § Delegation).
  Reason: staffing is Kooshi's budget decision, and I can only review work I know about. If the work outgrows your context, stop at a
  saved stage and tell me what is left.
- **No finite-witness search** (the ban to 2026-10-01): exact arithmetic that checks a derived claim is in; keep the "would have searched
  here" log.
- **Record:** `plans/FS91-S1V-no-mixing.md`, with C0, one section per claim quoted verbatim, the divergence table, the log, and a heading
  "Theorems this phase proved". Data `data/fs91/j09v/`; tools `tools/crunch_j09v_*.py`.
- **Commits by explicit path** (`git diff -- <path>` first; `git commit <paths> -m …`, never a bare `git commit`). Neutral subjects
  "J09v: stage n". End commit messages with your harness's attribution lines. Push; never force-push.
- **Budget:** about 220k by the harness's count; hand back by 300k.
- **Reports** in the fixed ≤ 12-line form (standing rule 9) to `data/crunch-2026-09-25/reports/J09v.md`, committed, and by SendMessage
  `to: "main"`, after stage 3 and at the end. Keep your turn's final text content-free: "J09v idle; report sent to the owner by SendMessage".

Thank you.
