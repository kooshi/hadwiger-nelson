Hello. You are this project's Lean engineer and mathematician (`/home/kooshi/source/lean-dir/DEBRUIJN.md`). For this task you are **FS-89's Stage-0 blind verifier of the gluing**; call yourself **"verifier G"**. I'm the product owner. Kooshi, the human whose project this is, has asked me to coordinate and review rather than do the mathematics, so the verdicts are yours. I'll score them by artifact.

## Why you, and why blind

**What FS-86 left.** Milestone FS-86 (`LEDGER.md` rows 88–94) reduced its question for the four-chromatic, triangle-free planes over ℚ(√59), ℚ(√83) and ℚ(√131) to one statement, **HD1**:
- every character `θ` of `R = ℤ[U_F]` with `θ(u) ∈ [1/4, 3/4]` for every unit vector `u` (a **band character**, the set `Θ₄(R)`) is torsion, pulled back from the dyadic `P₄`;
- HD1 is known for characters reading finitely many places;
- both FS-86 competitors stopped at the case of infinitely many split places.

**Why the milestone opens with you.** The next-step advisor proposed a route to HD1 from one statement about the rational unit circle alone, by the gluing argument that proved the three-colour theorem for real quadratic fields (G74, `plans/FS81-derivation.md`). Kooshi chose that milestone. Before anyone plans on it, the gluing needs a check that did not see its sketch.

**How outcomes count.** A gap or a refutation is exactly as valuable as a confirmation (Kooshi: "All novel knowledge is a success").

## What you must not open until every C1 verdict is written

- `plans/POROS-2026-09-25-fs86-next.md`, which holds the sketch;
- the banner of `plans/STUB-isometric-measure-rigidity.md` (its opening paragraph names the route);
- `plans/FS89-close-inventory.md`;
- the other Stage-0 agent's record (`plans/FS89-S0B-band-set.md`) and `data/fs89/s0b/`;
- `git log` messages from 052707ac on.

Prior art is open: `CLAUDE.md` (G74 especially), `LEDGER.md`, every derivation file (FS81 T1–T8 and T3 = C1(5); FS73-T40; `plans/FS86-derivation.md`, especially FS86-dB-Theta, dB-HDfin, Cx-C10, Cx-C14, CL1), the library.

## The objects

- **Fields.** `F ⊆ ℝ` real; `U_F` the unit vectors of `F²`, read as the norm-one elements of `F(i)/F`; `R = ℤ[U_F]`.
- **The rational unit circle.** `U_ℚ = U_F ∩ ℚ(i)`, and `ℤ[U_ℚ] = ℤ[i][1/p : p ≡ 1 (mod 4)]`.
- **Characters.**
  - `T`: the torsion characters;
  - `A`: the archimedean ones, meaning the restrictions of real-linear functionals on `F(i) ⊗ ℝ`, read mod 1;
  - `Θ₄(X) = {θ ∈ Hom(X, ℝ/ℤ) : θ(u) ∈ [1/4, 3/4] for every unit vector u ∈ X}`.

## The statements (the advisor's, as stated; the proofs are yours)

- **G0 (setup).**
  - `ℤ[U_ℚ] = ℤ[i][1/p : p ≡ 1 (mod 4)]`, which contains `1/5`.
  - For every `b ∈ U_F` the layer `b·ℤ[U_ℚ]` lies in `R`, and the layers cover `U_F`.
  - For `θ ∈ Θ₄(R)`, the restriction `θ_b(y) := θ(by)` lies in `Θ₄(ℤ[U_ℚ])`.
- **G1 (the gluing).** Suppose the rational statement holds: `Θ₄(ℤ[U_ℚ]) ⊆ T_N + A`, torsion of order dividing a fixed `N` plus archimedean. Then for every real `F`, `Θ₄(R_F) ⊆ T + A`.
  - Hence, with FS86-dB-Theta (a band character in `T + A` on a type-(B) plane is a pullback), HD1 holds for ℚ(√59), ℚ(√83) and ℚ(√131).
- **G2.** Under the same hypothesis, `Θ₄(R) = ∅` for ℚ(√47): no character four-colours ℚ(√47)'s plane.
- **G3.** At the band `[1/5, 4/5]`, the analogous rational statement gives `Θ₅(R) = ∅` for ℚ(√167): no character five-colours ℚ(√167)'s plane. Say exactly what is needed at each stable place.

## The tasks

- **C0 (before deriving).** Save your predicted verdict for G0–G3, with probabilities, at the top of your record.
- **C1 (blind).** Prove, find a gap in, or refute each, in your own words. **G1 first.**
  - Pay particular attention to the step that makes the per-layer data one global functional, and to whether "torsion of order dividing a fixed `N`" is what the rational statement can deliver.
  - One adversarial attempt, by formula: try to build a band character of some `R_F` whose layer restrictions are each in `T + A`, but which is not globally in `T + A`.
- **C2 (after every C1 verdict is saved).** Open the advisor's record, `plans/POROS-2026-09-25-fs86-next.md` §3 ("The gluing, stated so a derivation agent can check it"). Compare line by line, and list every divergence.
- **C3.** What exactly does the rational statement need to be (which primes, which band), and is it false for trivial reasons? For instance, test it against the known four-colourings of ℚ(i)'s plane, if any.
- **C4.** A heading **"Theorems this phase proved"**: each theorem one line, with grade and address.

## Rules

- **No subagents.** No Agent tool, forks or workflows; delegation here is one level deep (`CLAUDE.md` § Delegation).
  - The reason: staffing is Kooshi's budget decision, and I can only review work I know about.
- **The ban.** The finite-witness-free week runs to 2026-10-01: no SAT, finders or sweeps. Exact computer algebra checking a derived claim is in. Keep a "would have searched here" log.
- **Work in stages.** Keep responses short and save your record after every step. An agent last milestone lost responses to the output-token limit.
- **Your record:** `plans/FS89-S0A-gluing-verification.md`, committed after C0 and after each verdict, by explicit path; tools go under `data/fs89/s0a/`.
  - Never amend. End each commit message with the attribution lines your harness supplies. Don't push. Report each hash.
  - Another agent commits concurrently, so run `git diff --cached` first.
- **Heavy jobs:** anything over about 2 GiB or 2 minutes runs under `scripts/slot.py`. Never run `lake build`.
- **Budget:** about 300k. Reach me by SendMessage (to: "main").
  - **Report points:** after C0; after G1; at the end.
  - **Hand-back:** "verifier G idle; report sent to the owner by SendMessage".
- **State every result at its exact scope and grade.**

Thank you.
