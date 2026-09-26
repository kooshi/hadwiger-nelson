*Brief for job **X22D** (wave 3): the type-(B) fields ℚ(√59), ℚ(√83), ℚ(√131) given MR, and the reduction SEL-k. Opus 5.5. Written by the
crunch planner (`plans/CRUNCH-2026-09-26-x2x3-queue.md` §7, list X22). **Sized for about 45 minutes and 220k harness tokens.** A blind
verifier, X22V, works on the same claims; never contact it.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`. `CLAUDE.md` is in your context (G76, G79 bear). **`data/crunch-2026-09-26-x2x3/briefs/STANDING-RULES.md`
is part of this brief; read it in full.** Its clock is replaced here: **your stop time is 12:30 UTC.**

**If your record already exists, you are resuming:** check the last SAVED stage against `git log -- plans/FS100-X22D-derivation.md`.

## The question

J38's poster reduced row 88's rigidity question over the type-(B) fields to the isolation statement T-B1, "given MR(F)". MR now holds (§7's
first paragraph). **What moves?** Planner's claim C-1 is that MR alone gives Q-μ (every invariant random four-colouring is a pullback)
without T-B1, so that row 88 becomes the transience question Q-tr alone. The advisor's reading (F3, one mind) is that "only the conditional
moves": T-B1 is about a single non-invariant colouring, which invariant-measure results do not touch. **Decide between these.** Cap C-4
(no transient colouring over ℚ(√59)) at 20 minutes; a GAP there is the expected outcome. SEL-k (the advisor's F2) is a reduction for every
field. Check it, and check X03D's FL-K under it, as a second mind. Every verdict counts.

## The claims

Copy §7's first paragraph and **list X22** (C-0 to C-4, SEL-k, with the quoted inputs) into your record first, verbatim.

## Read first

- The stub `plans/STUB-measure-rigidity-three-fields.md` §2 (J38 block: T-J38-1 to -3 and J48's corrections); J38's poster
  `plans/POROS-2026-09-25-wanted-poster-59.md` §3.5–§3.6, §4.7.
- `LEDGER.md` rows 67, 88, 90–92, 111, 112; `plans/R88-derivation.md` (R88-TA, CL, TA1, TA2, B2-1 to B2-3; Theorem C, R88-TC).
- X03D's FL-K (`plans/FS100-X03D-derivation.md` §3.2) for SEL-k; X12B's Lemma Z (`plans/FS100-X12B-derivation.md` §2.1) for C-4.

## Stages

1. Quotation check; C0 per claim. Save.
2. C-0, C-1 (the key claim: which step of T-J38-2 used T-B1, and whether Theorem C with MR makes it unnecessary for invariant measures). Save.
3. C-2, C-3; C-4 (20 minutes). Save.
4. SEL-k. Save; the report.

**Stop rule:** at 200k harness tokens or 12:30 UTC, finish the current claim, save, report. Do not lean toward TRUE.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about. If the work outgrows your context, stop at a saved stage and say what is left.
- **The ban** (standing rule 3); keep a "would have searched here" log. Exact arithmetic of seconds that checks a derived claim is in.
- **Record** `plans/FS100-X22D-derivation.md` with "Theorems this phase proved"; working files `data/fs100/x22d/`; checks `tools/x22d_*.py` with plants watched firing.
  Do not edit `CLAUDE.md`, `LEDGER.md`, `plans/FRONTIER-STUBS.md`, `BIBLIOGRAPHY.md`, the stub or the queue; propose edits in your record.
- **Commits:** by explicit path, subjects "X22D: stage n"; never amend; push after each commit; never force-push.
- **Report** (standing rule 9) to `data/crunch-2026-09-26-x2x3/reports/X22D.md`, committed, and by SendMessage to "main". Final turn text:
  "X22D idle; report sent to the owner by SendMessage".

Thank you.

## Addendum (06:24, the advisor's sketch for C-1; one mind — write it out or refute it; X22V does not have it)

Poros, relayed verbatim: "Every finite U-invariant measure on E sits on T + A (R-U, X03D-Z, X12B-Z). So given MR, σ = a·m + (a part on T + A).
By FL-K, the set-valued E-factor colouring is proper. Hoffman-tightness at the dyadic place (χ_f = 4 exactly, balanced) forces those sets to
be singletons almost surely. That gives a = 0, so the colouring is measurable over the E-factor, and row 112's stationary count makes it a
pullback. The step to watch: passing from 'the E-factor colouring is a pullback' to 'the colouring itself is a pullback' requires a = 0, and
that is exactly where tightness enters."

**The advisor's correction to that sketch (06:25, relayed verbatim; one mind):** "Hoffman-tightness alone does not give a = 0. Let I_j = {y :
colour j ∈ S(y)}. These are invariant independent sets of the E-factor graph, and they satisfy Σ_j density(I_j) = E|S|. To get E|S| = 1, and
hence a = 0, every such set must have density ≤ 1/4. … The bound comes from a max-over-factors principle for these products, as in Zhang or
in M3's spectral version, which is row 112's 'stationary count' or an input close to it. The trap: First moments give only Λ/(1+Λ) ≈ 0.287 >
1/4 at the real place. The archimedean bound has to be a genuine measurable-density bound, for example `[AmbrusEtAl2023]`'s m₁(ℝ²) ≤ 0.247,
and its extension to the product of the two real places has to be argued, not assumed. What X22D should do: Name the density bound as
C-1's load-bearing input, cite row 112's statement if it supplies it, and otherwise mark GAP at that step."
