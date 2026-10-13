# Claims EN2 — two questions from the planner of the five-colour chain to the derive lane; fixed by Keryx, 2026-10-13 21:09 UTC, before the deriver's launch

*Statements only, each one line with its id, in the asker's words: the kernel planner's record `plans/FS131-KN3-chain-plan.md` on branch `fs131-wch`, § Stage 6, its lines 396–399 and 400–402, copied by script with the line breaks joined. The names are the record's: "Lemma 3.1′" and "Steps 4–5" are in `plans/FS100-X01D-derivation.md` (its § 3.3 to § 3.6; a second derivation is `plans/FS100-X12B-derivation.md`); "X02D § 3.2" is `plans/FS100-X02D-derivation.md` § 3.2; "EN1 § 7.2" is `plans/FS131-EN1-derivation.md` § 7.2; "the release" is the outside Lean library at `~/source/math` (read only); M7 and M8 are the planner's names for two modules of the chain not yet planned.*

## Statements

EN2-MEAN: *M8, Lemma 3.1′.* Can Steps 4–5 (X01D ll. 226–246) run on convergence in mean — `μ{I_n > εn} ≤ H_n/(εn)` by Markov's inequality on the information function, along a subsequence of scales chosen so that the bad sets are summable — with no almost-everywhere theorem? The deriver left this open (EN1 § 7.2); Shannon–McMillan–Breiman is in neither Mathlib nor the release, so the answer decides whether a classical theorem is formalized or dropped.
EN2-DECOMP: *M7, § 3.2.* The ergodic decomposition's *uniqueness* is cited at X02D ll. 205, 209 and 225. The release proves existence in canonical form (the conditional measures on the invariant σ-algebra). Does § 3.2 go through on the canonical decomposition, where "`u` permutes the components" is a computation and no uniqueness theorem is read?

## Not claimed

EN2-NC: that the answer to either is yes — the exact step that reads the almost-everywhere theorem, or the uniqueness theorem, is an answer of the same worth; any change to what the two deductions conclude (the statements EF_F⁺ and PE-2 as `plans/FS100-derivation.md` has them); that a printed theorem is wrong; anything about the declared printed theorem (Einsiedler–Lindenstrauss, Theorem 1.3); that an argument found here is new mathematics.

## Dated lines
