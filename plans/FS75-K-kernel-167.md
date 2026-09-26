# FS-75's minimal instance in the kernel — `χ(ℚ(√167)²) ≥ 4` (record)

*Job J52K, de Bruijn (Opus 5.5), 2026-09-25/26, kernel engineer. Brief: `data/crunch-2026-09-25/briefs/J52K-FS75-kernel-167.md`, with
`STANDING-RULES.md`; the owner's launch notes override the brief (FS-75 runs; the headline keeps the name
`four_le_chromaticNumber_planeOver_sqrt167`; ℚ(√47)'s tree only after the gate, format first). Plan: `plans/FS75-kernel-167.md` (J52).
Working files: `data/fs75/j52k/`.*

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| quotation in the brief | source | verdict |
|---|---|---|
| "**Compose:** `Θ₃(S) = ∅` ⟹ `addCayley S` not 3-colourable ⟹ `3 < χ(ℚ(√167)²)`, stated as `four_le_chromaticNumber_planeOver_sqrt167`, standard three axioms, no native purchase." | `plans/STUB-three-colour-criterion-kernel.md` lines 56–57 | verbatim (a line break in the source) |
| the headline `theorem four_le_chromaticNumber_planeOver_sqrt167 : 4 ≤ ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {167}))).chromaticNumber` | `data/fs75/j52/skeleton/ThreeColourKernel.lean` lines 369–370 | verbatim |
| `ThreeColour.nonempty_winding (s : Fin m → A) {c : A → ZMod 3} (hc : ProperAlong s c) : Nonempty (Winding s)` | skeleton line 172 | verbatim (namespace prefixed) |
| `ThetaCert.Cert.isEmpty_winding (c : Cert) (h : c.check = true) : IsEmpty (Winding c.gen)` | skeleton line 272 | verbatim |
| "**18 `sorry` sites**" | skeleton | **faithful by declarations, not by sites**: 18 declarations use `sorry`; there are 19 `sorry` tokens, because `iota` carries two (`map_zero'`, `map_add'`) |
| "§S.0 measured 19.4 s and 6.04 GB on the skeleton" | `plans/FS75-kernel-167.md` §S.0 | faithful (the source: "19.4 CPU s (18.61 + 0.82, minimum of three …), peak 6.04 GB for the file") |
| the five kernel lines ("Build only as …", "On a slot refusal …", "The gate: …", "Prose in any module …", "You are the only kernel job …") | the house kernel-brief lines, e.g. `data/crunch-2026-09-25/briefs/J14-M2-chain-kernel.md` line 49 on | verbatim for the first (checked); the others are the house's standard text |
| routes for 1e (`List.perm_iff_count` with `count j (word v) = v j`, `Finset.sum_list_map_count`) and 1g (`W r := wind 0 r⁺ r⁻ / 3` …) | plan §S.3, §M | faithful restatements of §S.3 and §M (not in quotation marks in the brief) |

No quotation fails; one count (sites against declarations) is recorded.

### 1.2 C0 — my probabilities for §P, before the work

| id | the plan's | mine | why |
|---|---|---|---|
| P-elem | 0.90 | 0.93 | I read §1.3 and §S.3 and can see every step: word permutations, `ZMod 3`, `omega`, finite sums; the one place a hidden analytic step could sit is additivity of `W` on the kernel, and `wind_eq_of_sub_eq` makes it combinatorial |
| P-tree | 0.80 | 0.70 | nested structural recursion in a `mutual` pair of *theorems* whose second function recurses on `List Tree` and a list of constraints in lockstep; the planner's scratch test elaborated, but proofs by structural recursion often hit the "cannot use structural recursion" wall when the recursive call sits under a lemma application |
| P-price | 0.70 | 0.65 | the headline within 2.5 hours of wall clock: leaf 2 is the one real cost |

### 1.3 The price from the first two open children closed

Children 1e (`wsum_word`, `length_word`, `word_add_perm`, with helpers `wsum_append`, `wsum_flatMap`, `count_word`) and 1f (`wind_shift`,
`wind_add_diag`, `wind_add`, `wind_cast`, `minRise_le_wind`, with helpers `height_add_gen`, `wind_add_gen`) **closed on the first
elaboration**, eight skeleton lemmas and five helpers, in about two minutes of wall clock from copying the skeleton to a clean elaboration
(`data/fs75/j52k/Work.lean`; `lake env lean` 3.2 CPU s user, peak 3.41 GB). Against §S.0's estimate for 1e + 1f (25 + 30 = 55 implementer
minutes) that is more than 20× faster, in line with M2's 5–30× (`CLAUDE.md` § What compute actually helps). **Re-priced total:** leaf 1's
packaging (1g) 10–15 min, leaf 2 (the nested walk) 30–60 min, leaf 3 15 min, leaf 4 and gate 30 min: about 1.5–2 hours, well under the
three-hour stop line. The budget in tokens is the binding one, not the clock.

Two small departures from §S.3's routes, both simpler: `wsum_word` goes through a local `wsum_flatMap` (Mathlib at this pin has no
`List.sum_flatMap`), and `wind_shift` goes through a one-generator lemma `height_add_gen` (`i :: L ~ L ++ [i]`), as §S.3 said, then an
induction on `l`. `count_word` is the `count j (word v) = v j` of §S.3, by `List.count_flatMap`, `Fin.sum_univ_def` backwards and `simp`.

### Would have searched here (stage 1)

- None.

## Stage 2 — SAVED

**`Proofs/HadwigerNelson/ThreeColour.lean`, sorry-free: leaf 1 in the kernel.** §1–§2 of the skeleton, statements verbatim, plus seven
helpers. 1g closed on the first elaboration by §M's route: `wind_eq_of_sub_eq` (balanced pairs with `u + v' = u' + v` have one winding, by
`wind_add_diag` twice), `wsum_word_add`, and `wsum_word_posPart` (a relation's positive and negative parts are balanced, through
`Int.toNat_sub_toNat_neg` and `natCast_zsmul`); then `W r := wind 0 r⁺ r⁻ / 3` with `3 * (w r / 3) = w r` from `wind_cast` and
`ZMod.intCast_zmod_eq_zero_iff_dvd`, `map_zero'` and `map_add'` by `omega` over the additivity equation, the bound from `minRise_le_wind`.
`nonempty_winding_of_colorable` reads the colouring `Fin 3`-valued as `ZMod 3` and gets adjacency `a ~ a + s j` from `addCayley_adj'`,
where `hs j` supplies `a ≠ a + s j`.

- **Imports**: Mathlib only (`SimpleGraph.Cayley`, `SimpleGraph.Coloring.Vertex`, `ZMod.Basic`, `BigOperators.Fin`, and the `Linarith`,
  `FinCases`, `Ring`, `NormNum` tactics). The plan's "`LocalGlobal`" import (§S.1) is not needed.
- **Spec examples**, one per definition, on the inhabitant `x ↦ x mod 3` along `(1, 2)` with the relation `(2, −1)`, each by `decide`:
  `relMap` (two), `minRise` (two), `posPart`/`negPart`, `word`, `wsum`, `step`, `height` (`= 4` along `[0, 0, 1]`), `wind` (`= 0`), and
  `Nonempty (Winding ![1, 2])` through the theorem.
- **The build**: `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh`, exit 0, "178 of 178 batches, 2 module(s)
  rebuilt, 0 module(s) with warnings, 3m26s" (`build/gate/build/20260926T045134Z-737547.log`). Added to `Proofs.lean`.
- **Decision — docstrings in the checker modules.** The brief's kernel line says "Prose in any module a certificate imports is written as
  `--` comments"; `ThreeColour` (and `ThetaCert`) will be ancestors of the literal module. *Choice:* keep `/-- … -/` docstrings in
  `ThreeColour` and `ThetaCert` (DEBRUIJN: every public declaration) and hold the literal module to `--` comments only. *Alternative:*
  `--` comments everywhere upstream, so a docstring edit never rebuilds the literal. *Why:* the rule protects multi-hour certificates; this
  literal re-checks in about 20 s, so a docstring edit upstream costs 20 s, while `--` comments would strip the API of its documentation;
  the house's `CayleyCertificate` makes the same choice. *Confidence: high*; it would change if a 30,344-leaf certificate (P-60) came to
  sit below these modules.
- **Price**: leaf 1's packaging, about 5 minutes of wall clock, first elaboration; §S.0 had 45 + 10 minutes.

### Would have searched here (stage 2)

- None.
