*Brief for job **FS105-P**: open milestone FS-105, harden MR, by WORKFLOW 3–4. Opus 5.5, 2026-09-26. Written by the product owner. An advisor
(Poros, job FS105-A) works beside you.*

Hello. You are de Bruijn (`DEBRUIJN.md`), the milestone planner, in `/home/kooshi/source/lean-dir`. **`data/fs105/briefs/STANDING-RULES.md` is
part of this brief; read it in full.** Read from disk, not from a loaded copy (FS-103 closed today and changed them):
- `CLAUDE.md`, `LEDGER.md` in full, `WORKFLOW.md` steps 3–5, `DEBRUIJN.md`;
- the stub, **`plans/STUB-harden-mr.md`**;
- MR's records: row 120's addresses; `plans/FS100-derivation.md` §3; `plans/FS100-X01D-derivation.md`, `FS100-X01V-verification.md`,
  `FS100-X02D-derivation.md`, `FS100-X02V-verification.md`, `FS100-X12B-derivation.md`;
- the ×2×3 crunch's advisor record `plans/POROS-2026-09-26-x2x3-crunch.md`;
- FS-103's close, `plans/FS103-collapse-cp-plane.md` §R-close, for rows 128–130, which now rest on MR too.

## Kooshi's words (verbatim)

> (2026-09-26, on FS-103's report) "I agree with hardening the lemma next. Can I get the paper with the proof for you? What do we need?"

The owner's answer: the paper is held. `[EinsiedlerLindenstrauss2022]` (arXiv:2101.11120) is at
`~/source/library/pdf/EinsiedlerLindenstrauss2022-rigidity-commuting-automorphisms-tori-solenoids.pdf`, and its §§3, 5–9 are unread. If the
reading needs a paper we do not hold, name it in your plan with its full citation and why it is needed; Kooshi offered to fetch.

## The question

MR (`LEDGER.md` row 120, verbatim there) carries every headline of rows 121–130 and FS-103's collapse. Its grade names four soft places:
- EL2021's Thm 1.2 is used by statement, its proof unread;
- EF_F⁺ has two blind derivations and a withdrawn checking reading;
- MR at degree 16 (de Grey's field) was never walked;
- row 129 made MR testable against finite graphs: "any proof that `α₁(ℝ²) > m₁(ℝ²)` refutes MR at ℚ(√635087)".

The milestone hardens MR, or breaks it. **Both outcomes are findings; a break is corrected before anything else is built.**

## What to produce: `plans/FS105-harden-mr.md`, in this order

1. **§G, the re-grokking** (WORKFLOW 3.1): every grokking, every row's mechanism, every method rule — **one short line each** (verdict and
   reason), extracted into phases. Keep it terse: the last planner spent about 250k on §G alone. Save in two stages.
2. **§PA**: MR's prior-art position is in its records (X24R; FS-103's gate). Add only what hardening needs:
   - the works EL2021's proof cites for the steps PE-2 relies on;
   - whether anyone has stated MR's form, invariance under a norm-one torus's rational points, since.
   Run the searches yourself, briefly.
3. **§IQ** (WORKFLOW 3.3) for the EF_F⁺ derivation.
4. **The fixed claim list** `data/fs105/claims.md`, statements only, verbatim with sources:
   - (a) PE-2 applies EL2021 Thm 1.2 within its hypotheses: admissibility and every other hypothesis the theorem states, written out at
     ℚ(√635087) and at de Grey's field;
   - (b) EF_F⁺ at ℚ(√635087);
   - (c) MR at degree 16 (FS-103's C-MR16);
   - (d) row 129's finite-graph test: what a refutation would need, and whether anything in print or held comes near it.
5. **The plan**: phases with budgets, stop rules and checkpoints. Draft the job briefs as `data/fs105/briefs/<id>-*.md` for the owner to
   review and launch, at most three agents at once:
   - a **reader** of EL2021 §§3, 5–9 against (a);
   - a **blind** third derivation of EF_F⁺ for (b), fenced from X01D, X12B and X01V exactly as FS-103's verifier briefs fenced their inputs;
     model it on `data/fs103/briefs/V1-collapse-verifier.md`;
   - whatever (c) and (d) need.

   Register expectations with both outcomes reachable.

## Rules

- **Touch only** `plans/FS105-harden-mr.md`, `data/fs105/claims.md`, `data/fs105/briefs/<new job briefs>`, `data/fs105/fs105-p/`,
  `tools/fs105_p_*.py`.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- **Do not derive EF_F⁺ yourself** (the blind job does); reading EL2021 is the reader's job, but skim enough to write (a) exactly.
- Send the advisor your §G bears list and your claim-list draft by SendMessage (its id comes from me); you decide and record disagreements.
- Commit subjects "FS105-P: stage n". **Budget:** about 300k by the harness's count; hand back by 400k.
- Report per standing rule 9 to `data/fs105/reports/FS105-P.md`: the claim ids, the phases, the expectations, any paper Kooshi should fetch.

Thank you.
