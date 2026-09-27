*Brief for job **FS110-P**: open FS-110, the tangency seam, by WORKFLOW steps 3–4. Opus 5.5, 2026-09-27. Written by the product owner.
An advisor (Poros, job FS110-A) works beside you. **Launched only after FS-107's close is committed and its gates are green.***

Hello. You are de Bruijn (`DEBRUIJN.md`), the milestone planner, in `/home/kooshi/source/lean-dir`. **`data/fs110/briefs/STANDING-RULES.md` is
part of this brief. Read it in full, rule 0 first.** Read from disk:
- `CLAUDE.md`: **§ The aim and § Counter-priors first**, then the rest (G82 as rewritten at FS-107's close);
- `LEDGER.md` in full, with rows 131–133 read closely;
- `WORKFLOW.md` steps 3–5, and `DEBRUIJN.md`;
- **the stub `plans/STUB-tangency-seam.md`** (FS-110), all of it, and the stubs it names: `plans/STUB-reg-scale.md` (FS-111),
  `plans/STUB-regular-half-residuals.md` (FS-108, item 2), `plans/STUB-hole-dial.md` (FS-109);
- FS-107's close: `plans/FS107-stability.md` §R-close, `plans/FS107-derivation.md`, `data/fs107/claims.md` (with §7's corrections);
- the records the stub quotes:
  - `plans/FS107-R-stability.md` §3;
  - `plans/FS107-W-near-colourings.md` §2;
  - `plans/FS107-V-verification.md` §4.3 (C5);
  - `plans/FS107-VW-verification.md` §2b, §4;
  - `plans/POROS-2026-09-27-fs107-competition.md` §5;
  - FS-106's `plans/FS106-TS-derivation.md` §2, §4, §5 (TS-U, C-T-TAN, C-T-IND);
- `plans/PROTOCOL-competitor-and-advisor.md`, as amended at FS-107's close.

## Kooshi's words (2026-09-26, verbatim)

> "My goal is to fully solve, and then verify in Lean, HN. Then we publish."

> "Let's see some ambition. I know we can do it."

## The question

The stub's two forms, kept apart:
- **Q-full** (decisive): does a full tight almost-everywhere-proper six-colouring of the plane by a locally finite map of bounded arc complexity exist?
  YES is `χ(ℝ²) ≤ 6` with no MR (row 133, through W-EQ-K). NO closes door (A) at every `K` and answers `[SokolovVoronov2025]` Question 2 almost
  everywhere for such maps.
- **Q-rule** (a relaxation): its necessary conditions at the vertices. Every close complementary vertex pair must be a tangent pair, a bowtie or a
  cusp, and equal-type pairs must survive.

It has four seams: tangent pairs (C5), bowties (C-AE-Q2's [G2] and [G4]), cusps, and the same-type half (SWAP-PRICE, the bicycle). Townsend's ⅔π
counterexample to Woodall already lives among maps with a unit-arc seam, so read it as a local model (`plans/FS106-V-verification.md`
§ Continuation — FS106-V3).

## What to produce: `plans/FS110-tangency-seam.md`

1. **§G** (WORKFLOW 3.1): one short line per grokking, row mechanism and method rule, with each *bears* extracted into a phase. Save it in two
   stages.
2. **§PA** (all eight questions). Cover:
   - the literature on unit-distance-avoiding maps with curved or tangent boundaries: Woodall, Townsend, Coulson, Sokolov–Voronov and their citing
     works;
   - tilings with prescribed vertex types, and circle-packing and tangency constraints on planar maps (discrete and computational geometry);
   - the local structure of partitions whose parts avoid a distance.

   The stub's provisional bearings are a start, not the list.
3. **§IQ:** what must every tight six-map carry at its vertices? W-TAN is the flip of C-T-TAN (G79); name the invariant a NO would read.
4. **The fixed claim list** `data/fs110/claims.md`. Statements only, each quoted verbatim from its source:
   - Q-full and Q-rule;
   - the types (essential against closure);
   - the four seams;
   - the shared constraints inherited from `data/fs107/claims.md` with their current grades;
   - the killing tests;
   - the failure clauses.
5. **The plan.** Choose the staffing: the stub proposes a proof side (NO) against a construction side (YES), an advisor, and a blind verifier per
   side. Draft the briefs as `data/fs110/briefs/<id>-*.md` for the owner to launch. At most three agents at once, all Opus 5.5. Register expectations
   with both outcomes reachable.
   - **The ban runs to 2026-10-01**, and Kooshi's ruling stands beyond it: *"search for a finite graph is out"*. The construction side's candidate
     maps are given by formula and checked exactly, and nothing is searched.

## Rules

- **Touch only** `plans/FS110-tangency-seam.md`, `data/fs110/claims.md`, `data/fs110/briefs/<new job briefs>` and `data/fs110/fs110-p/`. Also create
  `plans/FS110-close-inventory.md` empty from `plans/FS107-close-inventory.md`'s header; from then on the owner is its only writer.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the owner
  can only review work it knows about.
- Do not derive the seams yourself; the jobs do. State the claims exactly.
- Send the advisor your §G bears list and your claim-list draft by SendMessage (its id comes from me). You decide, and you record disagreements.
- Commit subjects "FS110-P: stage n", neutral.
- **Budget:** about 300k tokens by the harness's count. Your own count runs at 55–70 % of it, so hand back when your own count reaches about 200k.
- Report per standing rule 9 to `data/fs110/reports/FS110-P.md`: the claim ids, the phases, the expectations, and any paper still needed.

Thank you.
