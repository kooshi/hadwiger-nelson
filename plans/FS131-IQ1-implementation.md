# FS131-IQ1 — the nine leaves of `Arith/QuadraticPrime.lean`

*de Bruijn, the implementer; brief `data/fs131/briefs/FS131-IQ1-leaves.md` (on `main`); branch `fs131-wq1`, worktree
`.claude/worktrees/fs131-wq1`, cut at the skeleton's commit `223241b0a`. Opened 2026-10-13. Working files: `data/fs131/iq1/`.
The plan it implements: `plans/FS131-KN2-upper-half-plan.md` on branch `fs131-wnf` (§ Stage 4 B, leaves Q1–Q9). The stages
below are saved in order; a successor resumes at the first stage not marked SAVED.*

## Theorems this phase proved

Each is in `Proofs/HadwigerNelson/Arith/QuadraticPrime.lean`, namespace `HadwigerNelson.QuadraticPrime`. **Grade of every
line: kernel-checked in a build of this branch** (stage 3: `./scripts/build.sh`, exit 0, the module compiled with no
warning), **axioms `[propext, Classical.choice, Quot.sound]`**, printed from the built module by
`data/fs131/iq1/lean/Axioms.lean` (output `data/fs131/iq1/axioms-built.txt`; both controls fired). **None has been through
the gate**: the audit, the vacuity scan, the assumptions step and the duplicate-name scan are the landing's. Each was read
against NF1-S2 and its two dated lines (`data/fs131/claims-NF1.md`, quoted in the brief and checked in stage 1).

The nine leaves this job proved:

- `isIntegral_sqrt_natCast` — `√d` is integral over `ℚ`, for every natural `d`.
- `fieldOfRadicands_eq_adjoin` — `fieldOfRadicands D` is the subfield under `IntermediateField.adjoin ℚ` of the `√d`.
- `numberField_fieldOfRadicands` — `fieldOfRadicands D` is a number field for finite `D` (the claim's "with its
  `NumberField` instance").
- `isMaximal_ker_and_card` — the kernel of a ring homomorphism to `ℤ/p` is maximal with `p` elements in the quotient.
- `exists_ringHom_zmod_of_padic` — the integers of a field that embeds in `ℚ_p` map to `ℤ/p`, by the residue of the image.
- `exists_padicInt_sq_eq` — Hensel: a natural number that is a nonzero square modulo an odd `p` is a square in `ℤ_p`.
- `nonempty_ringHom_padic` — `fieldOfRadicands D` embeds in `ℚ_p` when every radicand is a nonzero square modulo the odd `p`.
- `nonempty_ringHom_zmod_of_ramified_sqrt` — the ramified quadratic step: `K = K₀(π)`, `π² = q`, `p ∣ q`, `p² ∤ q`, `K₀`
  embedded in `ℚ_p`, `p` odd: the integers of `K` map to `ℤ/p`.
- `exists_maximal_card_eq_of_ramified` — **NF1-S2's ramified clause as corrected by the dated line**: every `d ∈ D` a
  nonzero square modulo the odd prime `p`, one more radicand `q` with `p ∣ q`, `p² ∤ q`: `𝓞 (fieldOfRadicands (insert q D))`
  has a maximal ideal with `p` elements in its quotient.

The four the skeleton had proved from those leaves, which are theorems now that the leaves are:

- `exists_maximal_card_of_padic` — a field that embeds in `ℚ_p` has a maximal ideal of its integers with `p` elements in
  the quotient.
- `exists_maximal_card_eq` — **NF1-S2's first sentence, widened by the dated line** (any set `D` of naturals, each a
  nonzero square modulo the odd prime `p`).
- `exists_maximal_card_eq_sqrt` — **NF1-S2's first sentence in the claim's own form** (`Squarefree d`, `1 < d` carried and
  unused).
- `instNumberFieldFieldOfRadicands` — the instance, for `[Finite D]`.

Eight private theorems carry the proofs' joints (stage 2); they are covered by the records of the public theorems that
use them.

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

## Stage 2 — SAVED: the nine leaves proved (elaborated; not yet built)

**State.** `Proofs/HadwigerNelson/Arith/QuadraticPrime.lean` has no `sorry`. Under `lake env lean` with the lakefile's
three options (`autoImplicit`, `relaxedAutoImplicit` off; `linter.missingDocs` on) it elaborates with **no message at all**
— no error, no warning (`data/fs131/iq1/logs/QuadraticPrime.out`, empty; exit 0; 8.5–15.6 s wall, 3.49 GB). The statement
check after the last edit: `RESULT: PASS` (14 of the skeleton's 14 stored types found unchanged; the six examples' text
identical; exit 0). The interim axiom print (the module's source with one `#print axioms` per public theorem appended,
`data/fs131/iq1/axioms.py gen --copy`; output `data/fs131/iq1/axioms-interim.txt`): **13 of 13 on
`[propext, Classical.choice, Quot.sound]`**; both controls fired (a theorem closed by `sorry` prints `sorryAx`; a theorem
on a planted axiom prints it); exit 0. **This is not a build**: `lake env lean` is not the lakefile's build, and the
print reads a copy, not the compiled module — stage 3 repeats both on the built library.

**How each leaf was proved, against the plan.** Order as the plan's, Q1–Q7, Q9, Q8; all nine were drafted against Mathlib's
source while two other builds held the slot, then elaborated together; three first-run errors, all in Q3–Q7, none in Q8–Q9.

| leaf | the proof | against the plan |
|---|---|---|
| Q1 | `IsIntegral.of_pow`, `Real.sq_sqrt`, `isIntegral_algebraMap` | the plan's route, three lines |
| Q2 | `IntermediateField.adjoin_toSubfield`, `Subfield.closure_mono`, `Subfield.closure_le`, `SubfieldClass.ratCast_mem` | the plan's route |
| Q3 | the inclusion into the adjoin as a `ℚ`-linear map (`coe_mem_adjoin`, private), `Module.Finite.of_injective`, `IntermediateField.finiteDimensional_adjoin`, Q1 | the plan's route |
| Q4 | the planner's compiled proof, verbatim | — |
| Q5 | `norm_le_one_of_isIntegral` (private: `IsIntegral.tower_top`, `IsIntegrallyClosed.isIntegral_iff`), `map_isIntegral_int`, the map into `ℤ_p` by its fields, `PadicInt.toZMod` | the plan's route; `map_isIntegral_int` in place of `IsIntegral.map` on `ι.toIntAlgHom` (one lemma for two) |
| Q6 | `hensels_lemma` for `X² − d` over `ℤ_p` itself at a natural lift `n` of the root; `PadicInt.norm_int_lt_one_iff_dvd`, `PadicInt.norm_natCast_eq_one_iff` | the plan's route, with the polynomial in `ℤ_p[X]` rather than `ℤ[X]` (no cast of `d` through `ℤ`) |
| Q7 | `IntermediateField.nonempty_algHom_adjoin_of_splits`; `minpoly.dvd`, `Polynomial.map_dvd`, `Polynomial.Splits.of_dvd` on `(X − r)(X + r)`; the inclusion written by its fields over `coe_mem_adjoin` | the plan's route; its fallback for the composition (the ring homomorphism by fields) was the form used |
| Q8 | six private lemmas, then the theorem (below) | the plan's children (a)–(e), by its first route |
| Q9 | `K₀ := (fieldOfRadicands D).comap _`, `π := ⟨√q, _⟩`, `ι₀` = Q7's map after `K₀ → fieldOfRadicands D`; generation by `Subfield.closure_le` into the image under `Subfield.map`; Q8, then Q4 | the plan's route (its second option for `hgen`) |

**Q8's children, as private lemmas of the file** (each a `private theorem`, `--` comments, no docstring; none is named in the
plan, so none is public):

- `valuation_natCast_eq_one` — `p ∣ q`, `p² ∤ q` give `(q : ℚ_p) ≠ 0` and valuation `1` (`Padic.valuation_natCast`,
  `padicValNat_dvd_iff_le`, `omega`).
- `padic_sq_ne_natCast` — no `y : ℚ_p` has `y² = q` (`Padic.valuation_pow`: `2·v(y) = 1`). This is child (a).
- `norm_le_one_of_sq_mul_natCast` — `‖β² q‖ ≤ 1` gives `‖β‖ ≤ 1` (`Padic.norm_le_one_iff_val_nonneg`,
  `Padic.valuation_mul`: `0 ≤ 2·v(β) + 1`). The parity step of child (d).
- `norm_le_one_of_two_mul` — `‖2α‖ ≤ 1` gives `‖α‖ ≤ 1` for odd `p` (`Padic.norm_natCast_eq_one_iff`).
- `exists_coords` — every `x : K` is `a + bπ` with `a b : K₀` (`Subfield.closure_induction` on `hgen`; the inverse case by
  `a² − b²q ≠ 0`). Child (b). **No subfield structure is built**: the induction principle's six cases are the six closure
  properties.
- `coords_unique` — `a + bπ = a' + b'π` gives `a = a'`, `b = b'`. Child (c).

In the theorem: `choose re im hrep` on `exists_coords`; additivity, multiplicativity and the values at `0`, `1` from
`coords_unique`; `conj : K →+* K`, `x ↦ re x − im x·π`, written by its fields; for an integer `x`, `x + conj x = re x + re x`
and `x · conj x = (re x)² − (im x)² q` are integral over `ℤ` and lie in `K₀`, so their images under `ι₀` have norm at most
`1` (`isIntegral_algebraMap_iff`, `map_isIntegral_int`, `norm_le_one_of_isIntegral`); the two norm lemmas give
`‖ι₀ (re x)‖ ≤ 1` and `‖ι₀ (im x)‖ ≤ 1`; the homomorphism is `x ↦ toZMod ⟨ι₀ (re x), _⟩`, multiplicative because
`toZMod q = 0`.

**Re-priced from the first child, as the brief asks**: the plan calls Q8 "the largest leaf"; drafted it is 185 lines with
its six helpers (93 of them the theorem with its docstring), and it elaborated on the first run. No dispatch to a companion skill was needed: no
leaf took three attempts.

**What the first runs found** (for the next implementer of this shape):

- `rw [h] at hx` with `hx : ↑x ∈ S` and `x : ↥S` fails ("motive is not type correct": `x`'s type mentions `S`). Read the
  equation of subfields at a point instead: `(SetLike.ext_iff.1 h (x : ℝ)).1 x.2`.
- `simp only [Polynomial.map_C, map_natCast]` on `(C (d : ℚ)).map f` rewrites the inner `C ↑d` to the cast `(d : ℚ[X])`
  first (`map_natCast` at the ring homomorphism `C`), and `Polynomial.map_C` never fires; a `rw` chain in the order
  `Polynomial.map_C, map_natCast` does what was meant.
- `Polynomial.Splits.of_dvd hg hg₀ ?_` with `hg` built inline leaves `g` a metavariable; state `hg` as a `have` with its
  polynomial.
- `rw [map_one]` does not see `((1 : 𝓞 K) : K)`: the coercion is the abbreviation `RingOfIntegers.val`, whose head is not
  `DFunLike.coe`. `show … (algebraMap (𝓞 K) K 1) …` first (they are definitionally the same), or use `simp`.
- `((2 * a : K₀) : K)` is avoided by writing `a + a`: no numeral crosses the subfield coercion (`LEAN.md`, FS131-I10C).

## Stage 3 — SAVED: the one build, and the checks on the built module

**The build** (`data/fs131/iq1/logs/build1.*`; the complete Lake output `data/fs131/iq1/logs/build1-full.log`, a copy of
`build/gate/build/20261013T184229Z-518792.log`):
`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 scripts/slot.py --mem 10 --cpus 8 --wait 7200 --name iq1-build -- env
MEMMAX=10G BATCH=8 ./scripts/build.sh`, from this worktree, on the committed text of stage 2 (`0827d448a`; the module was
not edited after that commit). 2026-10-13 18:42:27 → 18:51:58 UTC. **Exit 0**, read from the script's own status
(`build1.exit`), and its last line: `==> build: OK — 249 of 249 batches, 38 module(s) rebuilt, 2 module(s) with warnings,
9m26s`. Largest process 4.54 GB. Had it died, the relaunch is the same command and redoes only the batch in progress.

- `Arith.QuadraticPrime`: `✔ … Built Proofs.HadwigerNelson.Arith.QuadraticPrime (8.6s)` — **no warning** (the log's 42
  `warning` lines are all in the two files below; `grep -v` of them is empty).
- The two modules with warnings are the module's other two files, on their own leaves: `Arith.UpperHalf` (12
  `declaration uses sorry`: FS131-IU1's) and `Instances.UpperHalfValues` (3). `Instances/UpperHalfValues` imports this
  file and compiled against it as filled.
- 38 rebuilt, not 4 (the module's three files and the root): this worktree's copied build was an older landing's — 34
  modules of `Plane/` and `Outside/` were stale — as the launch note said. Nothing of theirs was edited.

**No statement changed — from the built module.** `data/fs131/iq1/statements-built.sh`: a file importing the compiled
module prints every public constant it declares under `HadwigerNelson.QuadraticPrime` (kind, name, hash of the stored
type, the type; `data/fs131/iq1/lean/BuiltDump.lean`), and every line of the skeleton's print of stage 1
(`statements-skeleton.txt`, elaborated from `223241b0a`) must be among them: **14 of 14, `RESULT: PASS`**, exit 0
(`data/fs131/iq1/statements-built.txt`). Control (`--control`: one hash altered in a copy of the reference): fired, naming
the altered line. The source-side check of stage 1 (`statements.sh`) run again after the build: `RESULT: PASS`, the six
`example`s' text identical. From git: against `223241b0a` the file's removed lines are nine, each `  sorry`; nothing else
under `Proofs/` differs.

**The axioms, from the built module.** `python3 data/fs131/iq1/axioms.py gen` (the check file now *imports* the module),
`data/fs131/iq1/lean1.sh data/fs131/iq1/lean/Axioms.lean`, `axioms.py check`: **13 of 13 public theorems on
`[propext, Classical.choice, Quot.sound]`**; control one (a theorem closed by `sorry`) printed `sorryAx`; control two (a
theorem on a planted axiom) printed the planted axiom; exit 0 (`data/fs131/iq1/axioms-built.txt`).

**The environment linters, run once as a pre-check, not as the gate**: `lake lint --no-build -- --no-build --trace` under
the slot (`--mem 6`): exit 0, `-- Linting passed for Proofs.`, fourteen linters each `(2/2) Passed!`
(`data/fs131/iq1/logs/lint.out`). No control was planted (a planted unused argument needs a second build, and the brief
allows one); the landing's gate has its own.

**Not run by this job** (the landing's, on the joined tree): `scripts/axioms.sh`, `scripts/dupnames.sh`,
`scripts/vacuity.sh`, `scripts/assumptions.sh`, their self-tests, `tools/check_architecture.py`.

**Counts, for whoever prices the next leaf of this kind**: nine leaves, one job; three elaboration runs to green after the
drafts (errors in Q3's helper, Q6, Q7 — none in Q8 or Q9); one build. The file is 458 lines (162 as a skeleton). The
wall clock went mostly to the slot: 19 m 45 s waiting behind two other builds for the first 3-second run.

## Drafts for the front page

*(the brief's "drafts for the landing")*

*This job ran no gate: the audit, the vacuity scan, the assumptions step, the duplicate-name scan and the environment
linters are the landing's, on the joined tree. What follows is what the landing will need from this file, each draft
naming its slot.*

### The audit block — `scripts/Axioms.lean`, CLEAN section (one record per declaration a person typed in the file)

The file holds 21 hand-typed declarations: 12 public theorems, 1 public instance (`Prop`-valued, so a theorem to the
kernel) and 8 private theorems. The 13 public ones are the records; the block is generated at
`data/fs131/iq1/audit-block.lean` (`data/fs131/iq1/axioms.py block`), banner and thirteen `#print axioms` lines, to follow
the last CLEAN block of `scripts/Axioms.lean`. Each printed `[propext, Classical.choice, Quot.sound]` from the built
module (stage 3). **The 8 private theorems have no record of their own** (a private name is not addressable from the
audit file); each is used by a public theorem whose record covers it: `coe_mem_adjoin` by `numberField_fieldOfRadicands`
and `nonempty_ringHom_padic`; `norm_le_one_of_isIntegral` by `exists_ringHom_zmod_of_padic` and
`nonempty_ringHom_zmod_of_ramified_sqrt`; `valuation_natCast_eq_one`, `padic_sq_ne_natCast`,
`norm_le_one_of_sq_mul_natCast`, `norm_le_one_of_two_mul`, `exists_coords`, `coords_unique` by
`nonempty_ringHom_zmod_of_ramified_sqrt`. No `axiom`, no `native_decide`, no `sorry`, no `partial`, no `unsafe`, no
`@[implemented_by]`, no `@[simp]` or `@[ext]` attribute, and no instance beyond the skeleton's one.

The audit's count moves by these thirteen, all clean; with the sibling files' records the landing has the total.

### A model for each hypothesis of the headlines — for the vacuity reading (`LEAN.md` § The gate)

No binder in the file is a colouring; the scan is expected silent here, and silence is not evidence, so by hand:

| theorem | its hypotheses | the model, and where the kernel holds it |
|---|---|---|
| `exists_ringHom_zmod_of_padic`, `exists_maximal_card_of_padic` | a ring homomorphism `ι : K →+* ℚ_[p]` | `algebraMap ℚ ℚ_[5]` — the file's first `example` |
| `isMaximal_ker_and_card` | `p` prime, `f : R →+* ZMod p` | `R = 𝓞 ℚ`, `p = 5`, through the first `example`; the smallest model is `RingHom.id (ZMod p)` |
| `exists_padicInt_sq_eq`, `nonempty_ringHom_padic`, `exists_maximal_card_eq` | `p` an odd prime; every `d ∈ D` with `(d : ZMod p) ≠ 0` and a square there | `D = {11}`, `p = 7` (`11 ≡ 2²`) — the second `example` |
| `exists_maximal_card_eq_sqrt` | the same with `Squarefree d`, `1 < d`, `d ≡ s²`, `s ≢ 0` | `d = 47`, `p = 11`, `s = 5` — the third `example` |
| `exists_maximal_card_eq_of_ramified` | the split hypotheses on `D`, and `p ∣ q`, `p² ∤ q` | `D = {3}`, `q = 11`, `p = 11` (`3 ≡ 5²`), the field `K = ℚ(√3, √11)` — the fourth `example` |
| `nonempty_ringHom_zmod_of_ramified_sqrt` | a subfield `K₀` of `K`, `ι₀ : K₀ →+* ℚ_[p]`, `p` odd, `π² = q`, `p ∣ q`, `p² ∤ q`, `K₀ ∪ {π}` generating `K` | **no `example` of its own; the model is built inside the proof of `exists_maximal_card_eq_of_ramified`** (`K = fieldOfRadicands (insert q D)`, `K₀` the comap of `fieldOfRadicands D`, `π = ⟨√q, _⟩`, `ι₀` from `nonempty_ringHom_padic`) and instantiated by the fourth `example` at `K₀ = ℚ(√3) ⊂ K = ℚ(√3, √11)`, `π = √11`, `p = 11`. The planner's note that its hypotheses "have no model in the kernel until Q9 builds one" is discharged by that proof |
| `numberField_fieldOfRadicands`, `instNumberFieldFieldOfRadicands` | `D` finite | `{3, 11, 5}` — the sixth `example` |
| the fifth `example` | — | `¬ IsSquare ((2 : ℕ) : ZMod 11)`: the split hypothesis refuses `{2}` at `11`, which is why `ℚ(√11, √22)` is no model of the ramified clause |

**Hypotheses that are jointly unsatisfiable at some parameters, each satisfiable alone** — for the reader, not a defect:
in `exists_maximal_card_eq_of_ramified`, `q ∈ D` contradicts `hD` and `hq` together (`hD` makes `q` nonzero modulo `p`,
`hq` makes it zero), so the statement is about `q ∉ D` without saying so; `q = 0` is excluded by `hq2`; `0 ∈ D` is
excluded by `hD`.

### What a reader of the statements should be told that the docstrings do not say

1. **`𝓞 K` without a number field.** `exists_ringHom_zmod_of_padic`, `exists_maximal_card_of_padic` and
   `nonempty_ringHom_zmod_of_ramified_sqrt` take any field `K`; `𝓞 K` there is Mathlib's `integralClosure ℤ K`. For an
   infinite `D`, `exists_maximal_card_eq` and `exists_maximal_card_eq_of_ramified` speak of the ring of all algebraic
   integers of an infinite extension of `ℚ`: true, and not a statement about a Dedekind domain. The consumers in
   `Arith/UpperHalf` need `[NumberField F]`, which `instNumberFieldFieldOfRadicands` supplies for finite `D` only.
2. **`exists_maximal_card_eq` at `D = ∅`** is the statement that `𝓞 ℚ` (as `𝓞 (fieldOfRadicands ∅)`) has a maximal
   ideal with `p` elements in its quotient, for every odd prime `p`. `1 ∈ D` is allowed (`√1 = 1` adds nothing).
3. **The ramified clause's `q` need not be squarefree or prime**: `q = 44` at `p = 11` satisfies `hq`, `hq2`
   (`ℚ(√44) = ℚ(√11)`). It need not exceed `p`.
4. **`nonempty_ringHom_zmod_of_ramified_sqrt` concludes `Nonempty` only.** Its proof builds the map `a + bπ ↦ (ι₀ a) mod p`
   and could state so, as `exists_ringHom_zmod_of_padic` does for its map; no consumer asks for it. Its docstring calls the
   conjugation "a ring automorphism": the proof uses, and proves, only that `a + bπ ↦ a − bπ` is a ring homomorphism
   `K → K`.
5. **The stored hypotheses carry casts the source hides**: `hD` is about `Nat.cast d : ZMod p`; `hπ` is
   `π ^ 2 = Nat.cast q` in `K`; `hgen` is about the coercion of `K₀` to a set of `K`. The stored types are in
   `data/fs131/iq1/statements-skeleton.txt` (the skeleton's) and are the built module's, hash for hash (stage 3).
6. **Nothing here is at `p = 2`**, and `exists_ringHom_zmod_of_padic` alone would allow it (it has no `hp2`).

### Strengthenings seen and not made (the skeleton's forms are kept; another file reads them; **neither wider form was typed**, so each is a reading, not a theorem)

- `exists_padicInt_sq_eq` should hold with `d : ℤ` (or `d : ℤ_[p]` whose residue is a nonzero square) by the same proof —
  the natural number enters only through its residue; the natural-number form is the only one read.
- `nonempty_ringHom_zmod_of_ramified_sqrt` should hold with `π ^ 2 = c` for any `c : K₀` whose image under `ι₀` has
  valuation exactly `1` — the proof's `ℚ_p` lemmas read `(q : ℚ_[p])` only through its valuation. (At a larger odd
  valuation the conclusion is still true but not by this proof: `π = p·√p` has integers `a + bπ` with `b ∉ ℤ_p`.)
- `isMaximal_ker_and_card` is stated with `p.Prime` explicit and needs no `Fact`; fine as it is.

### For `ARCHITECTURE.md` § 3, the row `Arith/QuadraticPrime` (Keryx's; the words it replaces)

Replace "**FS-131, NF1 (FS131-KN2; a skeleton: nine leaves are `sorry`).**" by "**FS-131, NF1 (planned by FS131-KN2,
proved by FS131-IQ1; no `sorry`).**" — the rest of the row stands as written (its imports cell `SquareClass` is unchanged:
no import was added).

### For `LEDGER.md` row 52 (Keryx's; amends the planner's draft in `plans/FS131-KN2-upper-half-plan.md` § Stage 5)

The planner's draft ends "The two values stay [hand] until the ramified clause
(`QuadraticPrime.exists_maximal_card_eq_of_ramified`) lands and is applied at 11." The clause is proved in this file
(stage 3: built, standard three axioms). What is still missing for the two values is its **application**: an instance at
`p = 11` for `K(√5) = ℚ(√3, √5, √11)` and `K(√247)` — `D ∋ 3, 5` (or `3, 247`) nonzero squares modulo 11 and `q = 11` —
composed with `UpperHalf.colorable_planeOver_of_finitePlane` and `chromaticNumber_finitePlane11`, and the lower halves.
No file of this module states those two instances; they are a line each once `Arith/UpperHalf` lands. Suggested wording
in place of the draft's last sentence: "The ramified clause is in the kernel
(`QuadraticPrime.exists_maximal_card_eq_of_ramified`); the two values stay [hand] until it is applied at 11 to
`K(√5)` and `K(√247)`."

### For `LEAN.md` § Searching — Lean (Keryx's; new lines, after the planner's four)

- `rw [h] at hx` where `hx : ↑x ∈ S` and `x : ↥S` fails with "motive is not type correct"; read an equation of subfields at
  a point: `(SetLike.ext_iff.1 h (x : ℝ)).1 x.2` (FS131-IQ1).
- `rw [map_one]` (and `map_mul`, `map_add`) does not see `((1 : 𝓞 K) : K)`: the coercion is the abbreviation
  `RingOfIntegers.val`; `show … (algebraMap (𝓞 K) K 1) …` first, or use `simp` (FS131-IQ1).
- A quadratic extension `K₀(π)` given only by `Subfield.closure (↑K₀ ∪ {π}) = ⊤` gets its coordinates from
  `Subfield.closure_induction` with no subfield built, and `choose` turns existence into the two coordinate functions
  (`QuadraticPrime.exists_coords`, private; FS131-IQ1).
- The `p`-adic valuation of a natural number divisible by `p` exactly once is `1` by `Padic.valuation_natCast` and
  `padicValNat_dvd_iff_le`; parity arguments on `ℚ_p` go through `Padic.valuation_mul`, `Padic.valuation_pow`,
  `Padic.norm_le_one_iff_val_nonneg` and `omega` (FS131-IQ1).
