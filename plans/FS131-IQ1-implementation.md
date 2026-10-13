# FS131-IQ1 — the nine leaves of `Arith/QuadraticPrime.lean`

*de Bruijn, the implementer; brief `data/fs131/briefs/FS131-IQ1-leaves.md` (on `main`); branch `fs131-wq1`, worktree
`.claude/worktrees/fs131-wq1`, cut at the skeleton's commit `223241b0a`. Opened 2026-10-13. Working files: `data/fs131/iq1/`.
The plan it implements: `plans/FS131-KN2-upper-half-plan.md` on branch `fs131-wnf` (§ Stage 4 B, leaves Q1–Q9). The stages
below are saved in order; a successor resumes at the first stage not marked SAVED.*

## Theorems this phase proved

*Filled at each stage; the grade of every line is "elaborated by `lake env lean` in this worktree" until stage 5's build,
and "kernel-checked in a build of this branch" after it. None has been through the gate: that is the landing's.*

(see the stages below; the final list is under the last SAVED stage)

## Stage 1 — SAVED: the readback, and the instruments

**The brief's quotations.** Four blocks — `W2` against `data/fs131/REQUEST-2026-10-13.md`; `NF1-S2` and the two dated lines
of 2026-10-13 16:36 UTC against `data/fs131/claims-NF1.md` — each required to be one whole line of its source, character for
character, read on `main` (the dated lines are on `main`, not in this tree's copy of the claim list):
`data/fs131/iq1/readback.py` — four `IDENTICAL`, `compared=4 differing=0`. Control (`--control`, one word changed in every
quotation): four `DIFFERS`. **No mismatch.**

**The nine leaves, each read in the source (`Proofs/HadwigerNelson/Arith/QuadraticPrime.lean` at `223241b0a`) and as the
elaborator stores it (`data/fs131/iq1/statements-skeleton.txt`), with the plan's route.** The plan's names are Q1–Q9.

| leaf | the statement, in one line | the plan's route | statement against plan |
|---|---|---|---|
| Q1 `isIntegral_sqrt_natCast` | for every natural `d`, the real number `√d` is integral over `ℚ` | `IsIntegral.of_pow` at `n = 2`, `Real.sq_sqrt`, `isIntegral_algebraMap` | agree |
| Q2 `fieldOfRadicands_eq_adjoin` | `fieldOfRadicands D`, the closure of the `√d` (`d ∈ D`) as a subfield of `ℝ`, equals the subfield under `IntermediateField.adjoin ℚ` of the same set | `IntermediateField.adjoin_toSubfield`, two inclusions; `ℚ`'s image lies in every subfield | agree |
| Q3 `numberField_fieldOfRadicands` | for a finite set `D` of naturals, `fieldOfRadicands D` is a number field | the inclusion into the adjoin is injective and `ℚ`-linear; `Module.Finite.of_injective` with `IntermediateField.finiteDimensional_adjoin` and Q1 | agree |
| Q4 `isMaximal_ker_and_card` | for a commutative ring `R`, a prime `p` and a ring homomorphism `f : R → ℤ/p`: `ker f` is maximal and `R ⧸ ker f` has `p` elements | compiled by the planner: `ZMod.ringHom_surjective`, `RingHom.ker_isMaximal_of_surjective`, `RingHom.quotientKerEquivOfSurjective` | agree |
| Q5 `exists_ringHom_zmod_of_padic` | for any field `K` and ring homomorphism `ι : K → ℚ_p` there is `f : 𝓞 K → ℤ/p` with `f x = toZMod z` whenever `z : ℤ_p` has image `ι x` | an integer of `K` maps to an element of `ℚ_p` integral over `ℤ`, hence in `ℤ_p` (integrally closed); the map into `ℤ_p` written by its fields; compose with `PadicInt.toZMod` | agree. `𝓞 K` is Mathlib's `integralClosure ℤ K`, defined for every field |
| Q6 `exists_padicInt_sq_eq` | `p` an odd prime, `d` a natural whose class modulo `p` is a nonzero square: some `r : ℤ_p` has `r² = d` | `hensels_lemma` for `X² − d` at a lift of the square root | agree |
| Q7 `nonempty_ringHom_padic` | `p` an odd prime, every `d ∈ D` a nonzero square modulo `p` (`D` any set, finite or not): a ring homomorphism `fieldOfRadicands D → ℚ_p` exists | `IntermediateField.nonempty_algHom_adjoin_of_splits`: each generator's minimal polynomial divides `X² − d = (X − r)(X + r)` over `ℚ_p` (Q6); compose with the inclusion of Q2 | agree |
| Q8 `nonempty_ringHom_zmod_of_ramified_sqrt` | `K` a field, `K₀` a subfield with a ring homomorphism `ι₀ : K₀ → ℚ_p`, `p` odd, `π ∈ K` with `π² = q`, `q` a natural with `p ∣ q`, `p² ∤ q`, and `K₀ ∪ {π}` generating `K` as a field: a ring homomorphism `𝓞 K → ℤ/p` exists | children (a)–(e): no square root of `q` in `K₀`; coordinates `a + bπ` exist and are unique; conjugation is a ring homomorphism; an integer's coordinates land in `ℤ_p` (trace, norm, parity of the valuation); `x ↦ a mod p` | agree. Read for truth by hand before starting: `q ≠ 0` follows from `p² ∤ q`; `K` has characteristic 0 because `K₀` embeds in `ℚ_p` |
| Q9 `exists_maximal_card_eq_of_ramified` | `p` an odd prime, every `d ∈ D` a nonzero square modulo `p`, `q` a natural with `p ∣ q`, `p² ∤ q`: `𝓞 (fieldOfRadicands (insert q D))` has a maximal ideal with `p` elements in its quotient | Q8 at `K = fieldOfRadicands (insert q D)`, `K₀` the comap of `fieldOfRadicands D`, `π = √q`, `ι₀` from Q7; then Q4 | agree |

No leaf's statement disagrees with its plan; no message was owed.

**The instruments, each with its control watched.**

- `data/fs131/iq1/lean1.sh <file>` — one file through `lake env lean` with the lakefile's two options, under the slot at
  `--mem 4 --cpus 2`. The skeleton: 2.8 s, 3.36 GB, nine `declaration uses sorry` and nothing else.
- `data/fs131/iq1/statements.sh [candidate]` — the no-statement-changed check, from the elaborator's side (pattern:
  `data/fs124/i5/statements.sh`). It elaborates the skeleton as committed at `223241b0a` and the candidate, each with one
  footer (`data/fs131/iq1/lean/StatementDump.footer`) that prints every public constant under
  `HadwigerNelson.QuadraticPrime` — kind, name, hash of the stored type, the type — and requires every line of the
  skeleton's print in the candidate's; the six `example`s, which are not stored, are compared as text. Its own reader is
  checked first: the 13 names written in the skeleton's source (12 `theorem`s and the `Prop`-valued instance) must each be
  in the print, which must hold 14 lines (the fourteenth is the matcher the skeleton's own proof of
  `exists_maximal_card_of_padic` generates). On the untouched skeleton: `RESULT: PASS`. **Three controls, each `RESULT:
  FAIL` naming the planted line**: a hypothesis added to Q1 (`(_h : 0 < d)`); an exponent changed in Q8 (`p ^ 3`); an
  example's numeral changed (`2` to `6`). The skeleton's print is kept as `data/fs131/iq1/statements-skeleton.txt`.

**The machine.** Two builds of other jobs held the slot's whole budget (20 of 22 GiB, twelve of twelve cores) from the
first edit: a one-file run at 4 GiB waits behind them. Proofs were drafted on paper against Mathlib's source meanwhile.
