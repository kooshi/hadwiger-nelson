*Brief for job **FS107-P**: open FS-107, stability: can vanishing holes save a colour? It follows WORKFLOW steps 3–4. Opus 5.5,
2026-09-27. Written by the product owner. An advisor (Poros, job FS107-A) works beside you. **Launched only after FS-106's close is committed
and its gates are green.***

Hello. You are de Bruijn (`DEBRUIJN.md`), the milestone planner, in `/home/kooshi/source/lean-dir`. **`data/fs107/briefs/STANDING-RULES.md` is
part of this brief. Read it in full, rule 0 first.** Read from disk:
- `CLAUDE.md`: **§ The aim and § Counter-priors first**, then the rest;
- `LEDGER.md` in full, with rows 128–130 and FS-106's new rows or addendum read closely;
- `WORKFLOW.md` steps 3–5, and `DEBRUIJN.md`;
- the stub `plans/STUB-regularity-wall.md`, as FS-106's close re-aimed it;
- FS-106's close: `plans/FS106-regular-half.md` §R-close and `plans/FS106-derivation.md`;
- the design this brief rests on: `plans/POROS-2026-09-27-fs106-close-and-fs107.md` §3, all of it;
- the records it quotes: `plans/FS106-TQ-derivation.md` (§3.5, §4, §5), `plans/FS106-QB-verification.md`, and `plans/FS106-TS-derivation.md`
  (§2, §4, §5), together with `plans/FS106-SB-verification.md`;
- `plans/PROTOCOL-competitor-and-advisor.md`.

## Kooshi's words (2026-09-26, verbatim)

> "My goal is to fully solve, and then verify in Lean, HN. Then we publish."

> "Let's see some ambition. I know we can do it."

## The question

FS-106 proved TQ-EQ at two minds, one of them blind:
`χ_m⁰(ℝ²) ≤ 6` exactly when, for every `δ > 0`, there are `ε > 0` and a periodic partial six-colouring by half-open grid squares with no
monochromatic pair at any distance in `[1 − ε, 1 + ε]` that leaves density at most `δ` uncovered. The one-way hard step needs no MR and no
Voronov. So Hadwiger–Nelson's measurable form is a **stability** question: does the uncovered fraction of band-proper six-colourings stay
bounded below as the band closes?
- **Competitor R (stability):** C-Q-STAB in its exact disc form. Some radius `R` and some `δ₀ > 0` work for every `ε`. With TQ-EQ this is
  `χ_m⁰ ≥ 7`, and given MR, `χ(ℝ²) = 7`.
- **Competitor W (near-colourings):** TQ-EQ (e). Regular periodic families, given by formula and checked exactly, whose holes vanish. Success
  is `χ(ℝ²) ≤ 6` **with no MR**.

Both outcomes decide the problem. A named obstruction on either side is a result in itself.

## What to produce: `plans/FS107-stability.md`

1. **§G** (WORKFLOW 3.1): one short line per grokking, row mechanism and method rule. Extract each *bears* into a phase. G21, G30, G51, G60,
   G72, G79 and row 129 will bear. Save in two stages.
2. **§PA** (WORKFLOW 3.2, all eight questions):
   - the literature on partial unit-distance colourings: the largest fraction of the plane `k` colours can cover (Croft, Pritikin, Parts,
     Townsend's and Woodall's map lines);
   - stability forms of Voronov's and Sokolov–Voronov's theorems, and the citing works of each;
   - the compactness step (weak-* limit, the Rajchman property of the circle measure) in the `m₁(ℝ²)` literature (FS-106 close inventory
     item 66: Bachoc, Oliveira, Vallentin, DeCorte, Ambrus and others);
   - whether "µ₆(ε) → 1?" or its dual has been asked in print.
3. **§IQ:** the structural form. What must every band-proper partial six-colouring carry that forces holes? TQ-HIT and the pixel lemma say
   what it cannot be: no hitting-form count, and no trichromatic *coloured* point. A2's PD-EQ (the pair form) names one candidate.
4. **The fixed claim list** `data/fs107/claims.md`. Statements only, each quoted verbatim from its source record:
   - R's and W's questions;
   - A2's §3.4 constraint table, each constraint with its object (sequence or limit) and its grade as FS-106's close left it;
   - the killing tests (§3.5);
   - the break table (§3.6).
5. **The plan:** the competitor protocol with an advisor. Draft these briefs as `data/fs107/briefs/<id>-*.md` for the owner to launch:
   - R and W, with identical mathematics, each side told what the other is for;
   - the advisor's hand-over;
   - a blind verifier for whichever side finishes first.

   Each brief names its object. Register the expectations with both outcomes reachable; per the counter-priors they are instruments, not
   caps. Staffing is at most three agents at once, all Opus 5.5.

   **The ban runs to 2026-10-01**, and FS-107 will cross that date. Plan W's constructions as derivation by formula until then. Name what the
   joint dial (§3.5) needs after the ban, and remember that Kooshi's ruling stands beyond it: *"search for a finite graph is out"*.

## Rules

- **Touch only** `plans/FS107-stability.md`, `data/fs107/claims.md`, `data/fs107/briefs/<new job briefs>` and `data/fs107/fs107-p/`. Also
  `plans/FS107-close-inventory.md`, created empty from `plans/FS106-close-inventory.md`'s header; after that the owner is its only writer.
- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and the
  owner can only review work it knows about.
- Do not derive R's or W's mathematics yourself; the competitors do. State the claims exactly.
- Send the advisor your §G bears list and your claim-list draft by SendMessage (its id comes from me). You decide, and you record every
  disagreement.
- Commit subjects are "FS107-P: stage n", and neutral.
- **Budget:** about 300k tokens by the harness's count. Your own count runs at 55–70 % of the harness's, so hand back when your own count
  reaches about 220k.
- Report per standing rule 9 to `data/fs107/reports/FS107-P.md`: the claim ids, the phases, the expectations, and any paper still needed.

Thank you.
