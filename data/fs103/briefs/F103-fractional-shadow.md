*Brief for job **FS103-F**: the fractional shadow — do our field-level arguments run one colour class at a time? Opus 5.5, 2026-09-26.
Written by the product owner. **Sized for about 250k harness tokens.** Two blind verifiers are running on FS-103; never contact them.*

Hello. You are de Bruijn (`DEBRUIJN.md`), in `/home/kooshi/source/lean-dir`, deriving. **`data/fs103/briefs/STANDING-RULES.md` is part of this
brief; read it in full.** Read from disk `CLAUDE.md` (G21, G24, G54, G60, G76, G80 above all), `LEDGER.md` rows 92, 110, 119–127, and
`plans/FS103-G-prior-art.md` §2.3 (the recognition this job tests). You are **not** blind: every file is open to you.

## Why

The prior-art reader found this (`plans/FS103-G-prior-art.md` §2.3 item 2, its words, a reading of one mind): "**if the chain's direction "a
colouring of `F²` gives a CP colouring of `ℝ²`" runs on one colour class at a time** — one random independent set of density `δ`, with
thickness at `λ* < δ/(1−δ)` — then at `F_dG` (every stable place has `λ* ≤ 0.1734 < 1/3`) it proves `α₁(ℝ²) ≤ m₁(ℝ²) < 1/4`, i.e. a finite
unit-distance graph with `χ_f > 4.04`, refuting the published conjecture". The conjecture: `[MatolcsiEtAl2025]` "Conjecture 1. χf,0(R²) = 4, and
for all finite unit distance graphs G ⊆ R² we have χf(G) < 4" (also `[AmbrusEtAl2023]` §4 Remark).

**The owner's worry, which widens it:** the same question applies to results already in the ledger. Row 123 reads "every stable place of
`F(i)` has all-levels four-colour ratio `< 1/4` ⟺ no stable residue target is four-colourable ⟺ `L(F) ≥ 5`". If row 123's lower bound
`χ(F²) ≥ 5` (given MR) runs on one colour class, a random independent set of density `≥ 1/4`, then it already gives, at every `L ≥ 5` field
(ℚ(√47) first), a finite unit-distance graph with `χ_f > 4`. So one of three things holds:
- the arguments use integrality at a step that can be named;
- they refute a published conjecture, given MR;
- one of our [hand] results has an error.

All three are findings. **The second is the flattering one; audit it hardest** (G21).

## Questions

1. **Row 123's lower bound** (the class theorem, CLS, SP-Cor in every degree; find the derivations through row 123's addresses and
   `plans/FS100-derivation.md`): replace "a translation-invariant random `k`-colouring" by "a translation-invariant random independent set of
   density `δ`". Does each step still go through? Name, verbatim, the first step that uses a second colour class, the simplex embedding's
   `−1/(k−1)`, or the count `Σ δ_j = 1`. Or state the per-class theorem it proves, with its hypotheses.
2. **T-J39-3's forward direction** (`plans/POROS-2026-09-25-wanted-poster-167.md` §3.2; `plans/FS100-BC-verification.md`) and the extension it
   uses (`plans/R88-derivation.md` R88-TC-ext): the same question, with the thickness threshold written as a function of `δ`.
3. **If some argument runs per class:** write the consequence as a theorem statement — which fields, which density bound, which finite-graph
   `χ_f` bound, given MR. Check each link on its own:
   - that `m₁(ℝ²) ≤ 0.2470` (`[AmbrusEtAl2023]` Thm 1) bounds the density of a stationary random independent set continuous in probability
     (their Lemma 1 works with finite-dimensional distributions; say whether it needs more);
   - that the invariant density of an independent set of `F²` is at least `α₁(ℝ²)` (Følner sets);
   - that fractional colouring passes from the countable graph to finite subgraphs.

   Then read `[MatolcsiEtAl2025]` (held, arXiv:2311.10069) §§1–3 and say exactly what it would contradict.
4. **Controls, before you conclude.** K = ℚ(√3,√11) has `χ_f(K²) = 4` (G60). Its dyadic place is tight at four colours (ratio exactly
   `1/4`, row 78), so a per-class argument must stop there: at which step, and why? ℚ(√11) and ℚ(√2,√3) likewise. A per-class argument that would
   also bound `χ_f(K²) > 4` is wrong.

## Stages

1. Quotation check; question 4's controls written first, with what a wrong-reason "per class" would look like. Save.
2. Questions 1 and 2. Save.
3. Question 3 (only if 1 or 2 runs per class; otherwise the named integrality step for each, with why no per-class weakening survives, or the
   weaker per-class bound that does). Save; the report.

**If you reach a per-class theorem implying `χ_f > 4` for some finite unit-distance graph**, send the owner one line at once. Keep deriving,
since it needs a second mind before anything is claimed.

## Rules

- **No subagents, forks or workflows.** Delegation is one level deep (`CLAUDE.md` § Delegation): staffing is Kooshi's budget decision, and
  the owner can only review work it knows about.
- The ban (standing rule 3); keep a "would have searched here" log. Do not lean toward the exciting answer.
- **Touch only** `plans/FS103-F-fractional-shadow.md` (your record, with "Theorems this phase proved"), `data/fs103/fs103-f/`, `tools/fs103_f_*.py`.
- **Commits:** by explicit path, subjects "FS103-F: stage n"; never amend; push; never force-push.
- **Report** (standing rule 9) to `data/fs103/reports/FS103-F.md`, committed, and by SendMessage to "main". Final turn text: "FS103-F idle;
  report sent to the owner by SendMessage".

Thank you.
