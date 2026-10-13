# FS131-IV1 — the first number-field module joined, and the three leaves of `Instances/UpperHalfValues.lean`

*de Bruijn, the implementer; brief `data/fs131/briefs/FS131-IV1-instances.md` (on `main`); branch `fs131-wnf`, worktree
`.claude/worktrees/fs131-wnf`, from `41e5e379e`. Opened 2026-10-13. Working files: `data/fs131/iv1/`. The plan this job
implements is `plans/FS131-KN2-upper-half-plan.md` § Stage 4 C (I1–I3) and § D. The stages below are saved in order; a
successor resumes at the first stage not marked SAVED.*

## Theorems this phase proved

All in `Proofs/HadwigerNelson/Instances/UpperHalfValues.lean`, namespace `HadwigerNelson.UpperHalf`. Statements are
FS131-KN2's, unchanged (stage 2's comparison from the elaborator's side; stage 3's from the compiled modules).
**Grade of each line: see stage 3** — until that stage is saved these are elaborated by `lake env lean` and not built.
**None has been through the gate**: no audit, no vacuity scan, no assumptions step, no duplicate-name scan was run by
this job.

**The three leaves** (each was `sorry` at `41e5e379e`):
- `numberField_bot` — `ℚ ⊂ ℝ`, the least subfield of `ℝ`, is a number field.
- `two_le_chromaticNumber_planeOver` — the plane over any subfield of `ℝ` needs two colours.
- `exists_stablePrime_rat` — `𝓞 (ℚ(i))` has a maximal ideal that holds 2, is fixed by conjugation, and modulo which
  conjugation is the identity. **The inhabitant of `StablePrime ⊥` and of the hypothesis `hram` of the two two-colour
  theorems of `Arith/UpperHalf`** (`two_mem_of_conj_trivial`, `colorable_two_planeOver_of_ramified`).

**Theorems of the skeleton that were proved from those leaves and from the other two files' leaves, and are theorems
now** (their proofs are the planner's): `instNumberFieldBot`, `chromaticNumber_planeOver_rat` (**`χ(ℚ²) = 2`**),
`colorable_planeOver_fieldOfRadicands`, `chromaticNumber_planeOver_eleven` (**`χ(ℚ(√11)²) = 4`**),
`chromaticNumber_planeOver_sqrt167_le_eight` (**`χ(ℚ(√167)²) ≤ 8`**),
`chromaticNumber_planeOver_sqrt47_le_five_of_prime` (**`χ(ℚ(√47)²) ≤ 5`**, the control).

**Private helpers this job added** (two): `exists_intCast_eq_of_isIntegral` (a rational number that is an algebraic
integer of `ℂ` is an integer), `exists_intCast_eq_re_of_isIntegral` (the real part of an algebraic integer of `ℂ` with
rational coordinates is an integer).

## Stage 1 — SAVED: the readback, the kernel's statements before any rebuild, and the merge

**The brief's quotations.** Three blocks — `W2` against `data/fs131/REQUEST-2026-10-13.md`; `NF1-MODULE` and `NF1-NC`
against `data/fs131/claims-NF1.md` — compared character for character by `data/fs131/iv1/readback.py` against the copies
on `main`: three `IDENTICAL` (`data/fs131/iv1/logs/readback.out`). Control (`--control`: one word changed in every
quotation): three `DIFFERS` (`logs/readback.control.out`). **No mismatch.**

**The three modules as the kernel held them before this job built anything.** `data/fs131/iv1/lean/StatementDump.lean`
prints every constant stored in the compiled data of `Arith/UpperHalf`, `Arith/QuadraticPrime` and
`Instances/UpperHalfValues` (kind, full name, stored type, a definition's stored value), from this tree's build as given
(FS131-IU1's build of `a27fa7111`: `Arith/UpperHalf` filled, the other two the skeleton's): 56 + 14 + 11 = 81 constants,
25,719,146 bytes raw (SHA-256 `409dad23…84e40c`), kept in compact form as `data/fs131/iv1/statements-before.txt`
(`compact_dump.py`: each stored term as Lean's hash, the SHA-256 of its text, its length and its head). Its
`Arith/UpperHalf` part is byte for byte FS131-IU1's `data/fs131/iu1/statements-after.txt` (`diff`, exit 0) — the two
jobs' dumpers print one format.

**The merge.** Trial: `git merge-tree --write-tree fs131-wnf fs131-wq1` — exit 0, tree `fc1c4896db1d`, no conflict
named. The two branches' base is `223241b0a` (the skeleton); since it `fs131-wnf` changed one file under `Proofs/`
(`Arith/UpperHalf.lean`) and `fs131-wq1` one (`Arith/QuadraticPrime.lean`); neither touched `Proofs.lean`, `scripts/` or
`ARCHITECTURE.md`. Merged: `git merge --no-ff fs131-wq1`, commit `5b86bf418` ("Merge made by the 'ort' strategy"; 23
files from `fs131-wq1`, all under `data/fs131/iq1/`, `data/fs131/reports/` and `plans/` but the one module). After it:
`grep -c sorry` reads 0, 0 and 3 on `Arith/UpperHalf.lean`, `Arith/QuadraticPrime.lean` and
`Instances/UpperHalfValues.lean`. **This tree's compiled `Arith/QuadraticPrime` is still the skeleton's until stage 3's
build** (the statements are the same, so `lake env lean` on the instances file reads the right types and the wrong
axioms).

**Each leaf, read in the source and as the compiled skeleton stores it** (`data/fs131/iv1/probes/p3.lean`,
`logs/p3.before-build.out`; the file has no `variable`, so no binder can enter or leave a statement unseen), against the
plan (§ Stage 4 C).

| leaf | the statement, in one line | the plan's route | agree? |
|---|---|---|---|
| I1 `numberField_bot` | `NumberField ↥(⊥ : Subfield ℝ)` — the least subfield of `ℝ` is a number field | `fieldOfRadicands ∅ = ⊥` (`Set.image_empty`, `Subfield.closure_empty`), then `QuadraticPrime.numberField_fieldOfRadicands Set.finite_empty` carried across | yes |
| I2 `two_le_chromaticNumber_planeOver` | `∀ F : Subfield ℝ, 2 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber` | `0, 1 ∈ planeOver F`, `dist 0 1 = 1`, `SimpleGraph.two_le_chromaticNumber_of_adj` | yes |
| I3 `exists_stablePrime_rat` | `∃ P : StablePrime ⊥, (2 : 𝓞 (fieldI ⊥)) ∈ P.P ∧ ∀ x : 𝓞 (fieldI ⊥), conjO ⊥ x - x ∈ P.P` — a maximal ideal of `𝓞 (ℚ(i))` fixed by conjugation (the structure's two fields), holding 2, with conjugation the identity modulo it | (1) 2 is not a unit of `𝓞`, so a maximal `P ∋ 2`; (2) `Im x ∈ ℤ` for `x : 𝓞` — trace and norm are rational integers, parity modulo 4; (3) `x̄ − x = 2·(−Im x · i) ∈ P`; (4) `P.comap conjO = P` from (3) | yes. Read for truth: `𝓞 (ℚ(i)) = ℤ[i]`, the prime is `(1 + i)`, `x̄ − x = −2bi`; the statement asks existence only |

No leaf's statement disagrees with its plan; none reads false or vacuous. `StablePrime ⊥` takes no `NumberField`
instance (`SpectralChain.lean:279`), so I3 does not read I1; `chromaticNumber_planeOver_rat` reads all three.

## Stage 2 — SAVED: the three leaves proved (elaborated; not yet built)

**State.** `Proofs/HadwigerNelson/Instances/UpperHalfValues.lean` has no `sorry`; neither has either of the module's
other two files (`grep -c sorry`: 0, 0, 0). Under `lake env lean` with the lakefile's three options (`autoImplicit`,
`relaxedAutoImplicit` off; `linter.missingDocs` on) the file elaborates with **no message at all** (exit 0; 3.7 s,
3.64 GB; `data/fs131/iv1/logs/UpperHalfValues.{out,time}`). Against the skeleton (`git diff 223241b0a`): the only lines
removed are three `  sorry`; 105 lines added. **This is not a build.**

**No statement changed, from the elaborator's side** (`data/fs131/iv1/statements.sh`,
`logs/statements-stage2.out`): the skeleton's file (`git show 223241b0a:…`) and the working file, each with
`lean/StatementFooter.lean` appended, elaborated at one path in turn; `statement_diff.py --scope instances` on the two
prints: **`PASS` — 9 named constants of the skeleton (9 theorems: the eight written `theorem`s and the `Prop`-valued
instance), each in the working file with the same kind and the same stored type; the three `example`s identical as
text**; two new private theorems, listed by name; no new public constant. Two controls, both watched:
- the reader's (`--control`): four faults planted in the second print — one character of `exists_stablePrime_rat`'s
  stored type, `numberField_bot` removed, `two_le_chromaticNumber_planeOver`'s kind changed, one `example`'s text
  changed — `4 of 4 planted faults reported`;
- the file's (`statements.sh --plant`, `logs/statements-stage2.plant.out`): a hypothesis `(_h : F ≠ ⊥)` added to
  `two_le_chromaticNumber_planeOver` in the candidate copy only — `FAIL: 1 difference(s)`, naming that theorem.

**How each leaf was proved, against the plan.** Four elaboration runs: the first with four errors (all in I3), the
second green with two linter warnings, the third and fourth tidying, each with no message. No leaf took three attempts
and no companion skill was invoked.

| leaf | the proof | against the plan |
|---|---|---|
| I1 | `unfold fieldOfRadicands; rw [Set.image_empty, Subfield.closure_empty]`, then `h ▸ QuadraticPrime.numberField_fieldOfRadicands Set.finite_empty` | the plan's, verbatim |
| I2 | `⟨0, _⟩`, `⟨1, _⟩` in `planeOver F`; `SimpleGraph.two_le_chromaticNumber_of_adj`; the adjacency is `dist (0 : ℂ) 1 = 1` by `show` and `simp` | the plan's |
| I3 | two private lemmas and the theorem (below) | the plan's steps (1), (3), (4) with one change in (2)–(3): **`Re x ∈ ℤ` is read in place of `Im x ∈ ℤ`**, and no integer `i` of `𝓞` is built |

**I3 as proved.**
- `exists_intCast_eq_of_isIntegral {q : ℚ} (h : IsIntegral ℤ (q : ℂ)) : ∃ n : ℤ, (n : ℚ) = q` —
  `isIntegral_algebraMap_iff` down to `ℚ`, `IsIntegrallyClosed.isIntegral_iff` for `ℤ ⊂ ℚ`.
- `exists_intCast_eq_re_of_isIntegral {z : ℂ} (hz : IsIntegral ℤ z) {a b : ℚ} (ha : z.re = a) (hb : z.im = b) :
  ∃ m : ℤ, (m : ℚ) = a` — `t = z + z̄ = 2a` (`Complex.add_conj`), `s = (z̄ − z)·i = 2b` (`Complex.sub_conj`; `i` is
  integral in `ℂ` by `IsIntegral.of_pow`) and `n = z·z̄ = a² + b²` (`Complex.mul_conj`) are rational algebraic integers,
  so integers; `t² + s² = 4n` in `ℤ` by `exact_mod_cast`; the four parities of `(t, s)` by `Int.even_or_odd'`, the two
  with `t` odd closed by `ring` and `omega` (the squares are atoms to `omega`). A statement about `ℂ`, with no subfield
  and no ring of integers in it.
- In the theorem: `hbot` (an element of `⊥ : Subfield ℝ` is a rational: `Subfield.bot_eq_of_charZero`, stated for a
  real number so that the rewrite has no dependent motive); `hre` (`Re x` is an integer `m` for `x : 𝓞 (fieldI ⊥)`:
  `map_isIntegral_int` along the subfield's inclusion, then the lemma); `hdvd` (`conjO x − x ∈ span {2}`: from
  `x + conjO x = m + m`, which is `Complex.add_conj` read in `𝓞`, the witness is `m − x` — **`x̄ − x = 2 (Re x − x)`**,
  closed by `linear_combination`); `h2` (`span {2} ≠ ⊤`: a right inverse `u` of 2 has `Re u + Re u = 1` with `Re u` an
  integer; `omega`); `Ideal.exists_le_maximal` gives the maximal `P ⊇ span {2}`; conjugation fixes it because
  `conjO x` and `x` differ by an element of `P` (`sub_sub_cancel`, `sub_add_cancel` — `conjO_conjO` is not needed).

**What differed from the plan's text, for the next reader.**
- The plan's (2)–(3) show `Im x ∈ ℤ` and write `x̄ − x = 2·(−Im x · i)`, which needs `i` as an element of `𝓞` (the
  sibling file's `exists_I_integer` is private) and a second parity. `x̄ − x = (x + x̄) − 2x = 2 (Re x − x)` needs only
  `Re x ∈ ℤ` and the integer `Re x` of `𝓞`. The mathematics is the same computation of half of `𝓞 (ℚ(i)) = ℤ[i]`.
- **The prime is not exhibited as `(1 + i)`**: it is any maximal ideal over `(2)` (`Ideal.exists_le_maximal`, so
  `Classical.choice` through Zorn). The statement asks existence only. The theorem's docstring (the planner's, not
  edited: the brief gives this job proofs and private helpers) says "the ideal `(1 + i)`; `x̄ − x = −2·Im(x)·i` and
  `Im(x) ∈ ℤ`" — true of the object, and not the route the proof takes.
- `rw [Subfield.bot_eq_of_charZero] at hx` on `hx : (↑↑x).re ∈ ⊥ ∧ …` with `x : 𝓞 (fieldI ⊥)` fails ("motive is not
  type correct": `x`'s type mentions `⊥`); state the fact for a real number first (`hbot`).
- `simp` leaves `((2 : 𝓞 K) : K)` under two coercions unsimplified (`LEAN.md`, FS131-I10C, on numerals out of a
  subfield): `rw [two_mul]` before taking coordinates, or keep the numeral out of the coerced equation
  (`x + conjO x = m + m`, then `linear_combination`).
- `Complex.isIntegral_int_I` is not a name at the pin; `IsIntegral.of_pow (n := 2)` on `Complex.I_sq` is two lines.
