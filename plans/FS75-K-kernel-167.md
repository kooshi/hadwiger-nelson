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

## Stage 3 — SAVED

**`Proofs/HadwigerNelson/ThetaCert.lean`, sorry-free: leaf 2 in the kernel.** `Cert.isEmpty_winding` (statement verbatim) and
`Cert.not_properAlong`; the control `tinyK4` passes by `decide +kernel` and its three plants each return `false` by `decide +kernel`; a
named corollary `tinyK4_isEmpty_winding`; one spec example per definition. Two elaborations to green: the first had six small errors
(`simp` normalises `getD` to `getElem?` before a supplied lemma can fire, so the list lemmas close by `exact`; a missing
`BigOperators.Pi` import; `Winding.eval` needs `Classical` decidability of kernel membership and is `noncomputable`; `Fin` numerals over
`tinyK4.units.length`), the second one (the default of a `getD` left undetermined).

- **The walk is mutual structural recursion on the nested `Tree`** (`checkTree_sound` on the tree, `checkKids_sound` on the list of
  children), now pinned with `termination_by structural`; no `Tree.rec` fallback. `checkKids_sound` carries "some constraint in the
  remaining list holds", as §M said.
- **Departures from §S.3, each a simplification:**
  1. *Defaults instead of range guards.* A leaf's cited constraint is `cite path i = path.getD i ⟨[], 0, true⟩`, and the default — the
     equation `W 0 = 0` — holds for every winding (`holds_dflt`); a relation index past the list names `[]`, the zero relation, in the
     lattice with length 0. So one lemma, `getD_induction` ("a property of every entry and of the default holds of every `getD`"),
     replaces every membership-by-index argument. **The checker's guards `pm.1 < path.length`, `ri < rels.length` and `lo − 1 ≤ hi`
     are well-formedness only; the proof uses none of them.** Coverage (`exists_holds_childCons`) holds for every `lo, hi`. The guards
     stay in the checker (the emitter mirrors them; they make a malformed certificate fail loudly), and the module docstring says so.
  2. *`leafOk` restated through named pieces* `cite`, `leafQ`, `leafP` (same `Bool`, same semantics as the skeleton's `let`s), so the
     leaf's tupled induction (`leaf_bound`: `Q` in the lattice ∧ `Q.length ≤ m` ∧ `W Q ≤ P`) is stated about definitions, not `let`s.
     `tinyK4` and its plants re-pass unchanged.
  3. *The relation check needs no length hypothesis for membership*: `relMap c.gen (vecOf r) k = (lincomb r c.units).getD k 0` holds
     for every `r` (`sum_getD_lincomb`, induction on the unit list), because `lincomb` and `vecOf` both drop entries past the units.
     The length check `r.length ≤ c.units.length` is used once, for `minRiseL Q = minRise (vecOf Q)` at a leaf.
  4. *The walk is generic over the group*: `Soundness.checkTree_sound` is stated for any `s : Fin m → A` and any relation list whose
     entries lie in the lattice; the certificate's units enter only in `Cert.isEmpty_winding`.
- **The total extension** is `ThreeColour.Winding.eval` (named so, not `ext`, which reads as an extensionality lemma), with
  `eval_zero`, `eval_add`, `eval_smul`, `minRise_le_eval`.
- **The build**: exit 0, "178 of 178 batches, 2 module(s) rebuilt, 0 module(s) with warnings, 3m28s"
  (`build/gate/build/20260926T050322Z-776316.log`); the first build of the module flagged two constructors without docstrings, fixed.
- **Price**: about 15 minutes of wall clock, three elaborations and two builds; §S.0 had 90 minutes and named it the one real risk.
- **P-tree scored: met** (structural, no fallback).

### Would have searched here (stage 3)

- None.

## Stage 4 — SAVED

**The headline is in the kernel.** `four_le_chromaticNumber_planeOver_sqrt167` (statement verbatim from the skeleton) builds sorry-free:

- `Proofs/HadwigerNelson/Instances/SqrtOneSixSeven/Cert.lean` — the literal `Sqrt167.cert`, emitted by `python3 tools/j52_intcert.py
  --emit-lean … data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz` (source sha256 `d67ffaea…6e78`, recorded in the module), renamed
  `cert` in namespace `HadwigerNelson.Sqrt167`; provenance in `--` comments.
- `Proofs/HadwigerNelson/ThetaPlane.lean` — §4: `iota` (additive by `Complex.ext`, `simp`, `ring`), `iota_re`, `iota_im`, `iota_mem`
  (subfield closure), `unitOk`, `norm_iota` (`Chain.norm_eq_one_of_sq`, `field_simp`, then `linear_combination h1' + 2√d·h2' +
  (v₁² + v₃²)·(√d·√d = d)`), `properAlong_of_colorable` (the colouring read at `iota`; the unit test from `hu` by `List.getD_eq_getElem`),
  and the consumer `four_le_chromaticNumber_of_cert`, verbatim.
- `Proofs/HadwigerNelson/Instances/SqrtOneSixSeven.lean` — §5: `Sqrt167.cert_units` and `Sqrt167.cert_check` by `decide +kernel`, the
  headline, and one corollary, `four_le_chromaticNumber_planeOver_of_sqrt167_mem` (every real field holding `√167`), which is the
  consumer applied once more.
- **The build**: exit 0, "179 of 179 batches, 4 module(s) rebuilt, 0 module(s) with warnings, 3m47s"
  (`build/gate/build/20260926T050935Z-796951.log`); the instance module "rebuilt … (11s)". ThetaPlane elaborated at the second attempt
  (a missing `Mathlib.Data.List.GetD` import); the instance module at the first.

**The cost, measured** (desktop; `scripts/slot.py --mem 12 --cpus 2 -- /usr/bin/time … lake env lean <file>`; CPU seconds
= user + sys; three runs each):

| module | runs (user + sys) | min | peak RSS |
|---|---|---|---|
| `Instances/SqrtOneSixSeven.lean` (`cert_units`, `cert_check`, headline) | 11.48 + 0.75, 11.46 + 0.76, 11.45 + 0.78 | **12.22 s** | 5.49 GiB (5,753,076 KB) |
| `Instances/SqrtOneSixSeven/Cert.lean` (the literal) | 6.64 + 0.49, 6.66 + 0.46, 6.65 + 0.48 | **7.12 s** | 2.09 GiB (2,194,352 KB) |

Together 19.34 s against §S.0's 19.4 s for the skeleton's single file (same checker, same literal, now split in two). **P-check scored:
met** (within ±25 %, under 8 GB).

**The planted faults on the real certificate, watched red** (`tools/j52k_plant.py`, under `scripts/slot.py --mem 12 --cpus 2`): three
copies of the committed literal, each followed by `example : cert.check = true := by decide +kernel`, elaborated with `lake env lean`:
- `faithful` (no change): **elaborates**, exit 0 — the partner that must pass;
- `relation` (relation 0's entry 7 changed from 1 to 2): **refused**, exit 1, "Tactic `decide` proved that the proposition … is false";
- `leaf` (the first leaf's multiplier `(0, 1)` set to `(0, 0)`, so `3P < minRise Q` reads `0 < 0`): **refused**, exit 1, same message.

Each plant's anchor text is asserted to occur exactly once before it is changed (a plant that cannot fire aborts the run), the committed
literal's sha256 is compared before and after (unchanged, `1265f2d3…`), and the generated copies were deleted after the run. The plants
never touched `Proofs/`; "removed" is therefore the restore check.

**Decisions this stage** (each: the choice · the alternative · why · confidence):
- *§4 in its own module `ThetaPlane.lean`*, not inside `Instances/SqrtOneSixSeven.lean` as the brief's stage 4 placed it · the brief's
  placement · the consumer `four_le_chromaticNumber_of_cert` is generic in `(d, D, F)`, and the next instances (ℚ(√47) if in format, the
  60-vector control, FS-60's quadratic witnesses) should not import ℚ(√167)'s 81 KB literal to reach it · high.
- *One docstring in the literal module* (on `cert`), the rest `--` comments · `--` comments only, with `set_option linter.missingDocs
  false in` · the linter must stay silent without being switched off, a docstring edit there rebuilds one 12 s module, and the house's
  literal modules (`Instances/SqrtEleven/Edges.lean`) carry docstrings · high.
- *The extra corollary for every field holding `√167`* · the headline alone · it is the consumer applied once, costs one line, and is
  the form `SqrtEleven` also exports (`four_le_chromaticNumber_planeOver_of_sqrt_eleven_mem`) · high.

### Would have searched here (stage 4)

- None. The certificate was transformed exactly (integer scaling per leaf) and checked; no new certificate was produced.
