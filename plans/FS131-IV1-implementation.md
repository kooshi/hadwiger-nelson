# FS131-IV1 — the first number-field module joined, and the three leaves of `Instances/UpperHalfValues.lean`

*de Bruijn, the implementer; brief `data/fs131/briefs/FS131-IV1-instances.md` (on `main`); branch `fs131-wnf`, worktree
`.claude/worktrees/fs131-wnf`, from `41e5e379e`. Opened 2026-10-13. Working files: `data/fs131/iv1/`. The plan this job
implements is `plans/FS131-KN2-upper-half-plan.md` § Stage 4 C (I1–I3) and § D. The stages below are saved in order; a
successor resumes at the first stage not marked SAVED.*

## Theorems this phase proved

All in `Proofs/HadwigerNelson/Instances/UpperHalfValues.lean`, namespace `HadwigerNelson.UpperHalf`. Statements are
FS131-KN2's, unchanged (stage 2's comparison from the elaborator's side; stage 3's from the compiled modules).
**Grade of each line: kernel-checked in a build of this branch (stage 3), axioms
`[propext, Classical.choice, Quot.sound]` read from the compiled modules (`data/fs131/iv1/axioms.txt`, 52 records;
the private helpers' in `data/fs131/iv1/axioms-footer.txt`). None has been through the gate**: no audit, no vacuity
scan, no assumptions step, no duplicate-name scan was run by this job. Each was read against NF1-MODULE and NF1-NC
(`data/fs131/claims-NF1.md`, quoted in the brief and checked in stage 1): the four values are the claim's four, two of
them bounds; none is claimed as new mathematics.

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

## Stage 3 — SAVED: the one build, and what the built modules say

**The build.** `data/fs131/iv1/build.sh build1`, which is
`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 scripts/slot.py --mem 10 --cpus 4 --wait 7200 --name iv1 -- env
MEMMAX=10G BATCH=8 ./scripts/build.sh` from the worktree, on the committed text of stage 2 (`14990e5a8`; no module file
was edited after that commit). Launched 2026-10-13 19:07:15 UTC; it waited on the slot behind a landing's gate steps
(three `slot: waiting` lines in `logs/build1.err`) and was admitted at 19:11:05; ended 19:17:34. **Exit 0**, read from
the script's own status (`logs/build1.exit`), and its last line: `==> build: OK — 249 of 249 batches, 3 module(s)
rebuilt, 0 module(s) with warnings, 6m26s` (`logs/build1.out`; the complete Lake output `logs/build1-full.log`, a copy
of `build/gate/build/20261013T191105Z-612560.log`). Largest process 4.54 GB. Had it died, the relaunch is the same
command and redoes only the batch in progress.
- Rebuilt: `Arith.QuadraticPrime` (5.0 s), `Instances.UpperHalfValues` (2.8 s), `Proofs` (1.9 s). `Arith/UpperHalf` was
  not rebuilt — its source and its imports are unchanged since FS131-IU1's build, and its `.olean` is that build's.
- **Warnings: none, in any module.** The word occurs once in `build1.out`, in the summary line, and nowhere in the full
  log; the full log's one `error:` line is the up-to-date probe's answer (`lake build --no-build`: "target is
  out-of-date"), which is how the script learns it has to walk.
- `grep -c sorry` on the three files after the build: 0, 0, 0.

**Everything below is read from the built modules by one script**, `data/fs131/iv1/after-build.sh`
(`logs/after-build.out`: exit 0, `ALL STEPS AS EXPECTED`).

**No statement changed, from the kernel's side.** `lean/StatementDump.lean` on the rebuilt library: 56 + 25 + 18 = 99
constants (81 before), 25,759,838 bytes raw (SHA-256 `6d73a923…91d09e`), kept compact as
`data/fs131/iv1/statements-after.txt`.
- `statement_diff.py statements-before.txt statements-after.txt --scope module` (`logs/statements-final.out`):
  **`PASS` — 52 named constants (49 theorems, 3 definitions) of the three modules as this tree held them before the
  build, each in the rebuilt library with the same kind, the same stored type and, for a definition, the same stored
  value; the nine `example`s of the three files identical as text to the skeleton's** (0, 6, 3). No new public
  constant; ten new private theorems, listed by name (FS131-IQ1's eight and this job's two); internal constants 29 → 47
  (not compared: they move with a proof). For the instances file that is its nine stored statements against the
  skeleton's compiled module; for `Arith/QuadraticPrime` its thirteen against the skeleton's compiled module (this tree
  had never compiled FS131-IQ1's text); for `Arith/UpperHalf` FS131-IU1's build against itself.
- `Arith/UpperHalf` against the *skeleton's* compiled module (`--scope upperhalf`, with FS131-IU1's
  `data/fs131/iu1/statements-before.txt` as the first dump; `logs/statements-final.upperhalf.out`): `PASS`, 30 named
  constants. So each of the 52 is compared with the skeleton as compiled.
- Controls. The reader's (`--control`, `logs/statements-final.control.out`): five planted faults — one character of
  `exists_stablePrime_rat`'s stored type, `numberField_bot` removed, `two_le_chromaticNumber_planeOver`'s kind,
  `StablePrime.residue`'s stored value, one `example`'s text — `5 of 5 planted faults reported`. The file's
  (`logs/statements-planted-file.out`): in a copy of the raw after-dump one constant renamed at character 256,123 of
  `exists_stablePrime_rat`'s stored type of 257,340 characters — far past the 160 the compact form keeps — then
  compacted and compared: `FAIL: 1 difference(s)`, naming that theorem. And stage 2's plant in the source
  (`statements.sh --plant`).
- From the files' side: against `223241b0a` the lines removed from the three files are `  sorry` and nothing else
  (12, 9 and 3); `#check` of the three leaves and eight neighbouring theorems prints the same text before and
  after the build (`logs/p3.before-build.out`, `logs/p3.out`: `cmp`, identical).

**The axioms of every public declaration of the three files, from the compiled modules.**
`data/fs131/iv1/lean/Axioms.lean` (`#print axioms` on the 52 public declarations, generated with the audit block by
`make_audit.py` from `statements-after.txt`): `data/fs131/iv1/axioms.txt`.
`read_axioms.py axioms.txt 52 --names audit-block.txt` (`logs/read_axioms.out`): **52 records, each exactly
`[propext, Classical.choice, Quot.sound]`; none beyond the standard three; none axiom-free; the same names as the
block, in order.** Among them the instances file's nine: `colorable_planeOver_fieldOfRadicands`,
`chromaticNumber_planeOver_eleven`, `chromaticNumber_planeOver_sqrt167_le_eight`,
`chromaticNumber_planeOver_sqrt47_le_five_of_prime`, `numberField_bot`, `instNumberFieldBot`,
`two_le_chromaticNumber_planeOver`, `exists_stablePrime_rat`, `chromaticNumber_planeOver_rat`.
- Controls. The reader's (`--control`): a planted `sorryAx` record and a planted undeclared axiom, `2 of 2` reported.
  **The pipeline's, not planted**: the same file run before the build, when this tree's compiled `Arith/QuadraticPrime`
  and instances file were still the skeleton's (`data/fs131/iv1/axioms.before-build.txt`,
  `logs/read_axioms.before-build.out`): `FAIL`, **22 of 52 on `sorryAx`** — the thirteen of `Arith/QuadraticPrime` and
  the nine of the instances file, and none of `Arith/UpperHalf`'s thirty. After the build: 0.
- **Every typed theorem and definition, the private helpers included** (`axioms-footer.sh`: each file copied with
  `lean/AxiomsFooter.lean` appended, `collectAxioms` on every theorem and definition the file declares;
  `data/fs131/iv1/axioms-footer.txt`): 36 + 21 + 11 = **68 rows — 52 public and 16 private — each on the standard
  three**. Control (`--control`, `axioms-footer.control.txt`): the same footer on the instances file as the skeleton
  had it prints `sorryAx` on exactly five — the three leaves, `instNumberFieldBot`, `chromaticNumber_planeOver_rat` —
  and on none of the four that never rested on this file's leaves.

**The hypothesis-shaped headlines at their inhabitants, from the compiled modules** (`lean/Models.lean`,
`data/fs131/iv1/models.txt`): exit 0; eleven records on the standard three — `exists_stablePrime_rat`,
`instNumberFieldBot`, and nine model theorems, among them **`two_colour_model`
(`colorable_two_planeOver_of_ramified` at `ℚ`'s stable prime) and `two_mem_model` (`two_mem_of_conj_trivial` at it)**.
The same file before the build printed `sorryAx` on all eleven (`data/fs131/iv1/models.before-build.txt`). The table is
in the drafts, § 2.

**`ARCHITECTURE.md`.** The three rows of § 3 brought to what is true (drafts § 5); `tools/check_architecture.py` after
the build: `RESULT: PASS`, exit 0 (`logs/check_architecture.out`).

**Run once, not as a gate** (the landing's to run and to control): `lake lint --no-build -- --no-build --trace` under
the slot on this build — exit 0, `-- Linting passed for Proofs.`, fourteen linters, fourteen `Passed!` (13.8 s, 5.15 GB;
`logs/lint.out`). No control was planted in it by this job.

**What this job did not run**: `scripts/axioms.sh`, `scripts/dupnames.sh`, `scripts/vacuity.sh`,
`scripts/assumptions.sh`, their self-tests, `lean4checker`. This branch is not joined with `main`: the landing's gate is
on the joined tree.

**The machine, as measured here**: `lake env lean` on the instances file 3.6–8.8 s (the longest behind a slot wait),
3.64 GB, under `--mem 4`; a check file importing the module 2.3–4.0 s, 3.6–3.7 GB; the three-module dump 4.0 s, 3.73 GB,
26 MB of text; the build 6 m 26 s at `BATCH=8` on four cores, 4.54 GB, after 3 m 50 s waiting on the slot; nothing was
refused by the slot.

**Process left running: none.** The slot ledger holds no entry of this job.

## Drafts for the landing (saved with stage 3)

*This job ran no gate: no audit, no vacuity scan, no assumptions step, no duplicate-name scan, and its one linter run is
a pre-check. What follows is gathered for the landing of the module's three files from FS131-KN2's plan (§ D),
FS131-IU1's and FS131-IQ1's records, and this job. Each draft names its slot.*

### 1. The audit block — `scripts/Axioms.lean`, CLEAN section, just above the PURCHASED banner

`data/fs131/iv1/audit-block.txt`: a banner and **52 records**, one `#print axioms` line per public declaration a person
typed in the three files, each file in its own order — `Arith/UpperHalf` 30 (27 theorems, 3 definitions),
`Arith/QuadraticPrime` 13 (12 theorems and the `Prop`-valued instance), `Instances/UpperHalfValues` 9 (8 theorems and the
`Prop`-valued instance). Generated by `data/fs131/iv1/make_audit.py` from the compiled modules' own lists of named
constants (`statements-after.txt`); it fails if a source writes a public declaration its module's dump does not hold, or
a dump holds a named constant its source does not write, and it fails unless its lists for the first two files are
FS131-IU1's and FS131-IQ1's own blocks name for name (`data/fs131/iu1/audit-block.txt`,
`data/fs131/iq1/audit-block.lean`; the latter writes its names relative to `HadwigerNelson`). The same lines under the
module's import are `data/fs131/iv1/lean/Axioms.lean`; their print from the built modules is `data/fs131/iv1/axioms.txt`
(stage 3). **Every record CLEAN**: none of the three modules imports `Arith/WeilKloosterman` or `Outside/OAI158`, and no
record's print holds an axiom beyond the standard three.

**What a person typed and the block cannot name**: 16 private theorems (6, 8 and 2) and 9 `example`s (0, 6 and 3). Each
private theorem is read by a public record — this file's two by `exists_stablePrime_rat`; the others as FS131-IU1's and
FS131-IQ1's records list — and each has its own print in `data/fs131/iv1/axioms-footer.txt` (68 rows: 52 public and 16
private; stage 3). An `example` is not stored; each elaborates in the build from public records.

No `axiom`, no `native_decide`, no `sorry`, no `partial`, no `unsafe`, no `@[implemented_by]`, no `@[simp]` or `@[ext]`
attribute in the three files. **Two global named instances**, both `Prop`-valued and both the planner's:
`QuadraticPrime.instNumberFieldFieldOfRadicands (D) [Finite D]` and `UpperHalf.instNumberFieldBot`. They are instances of
`NumberField` on two types that are propositionally one at `D = ∅` (`fieldOfRadicands ∅ = ⊥`, the proof of
`numberField_bot`) and not definitionally; `NumberField` is a proposition, so no diamond can carry data.

**`scripts/dupnames.sh` is the landing's to run on the joined tree.** This job added no public name; its two private
names are stored under the module's own prefix. `Arith/UpperHalf` and `Instances/UpperHalfValues` share the namespace
`HadwigerNelson.UpperHalf` and the second imports the first, so a doubled name between them would have failed the build.

### 2. A model for each hypothesis of the headlines — for the vacuity reading (`LEAN.md` § The gate)

No binder in the three files is a colouring structure; one headline takes a colourability hypothesis
(`colorable_planeOver_fieldOfRadicands`'s `hk`). The scan is expected silent or nearly so, and silence is not evidence, so
by hand. `data/fs131/iv1/lean/Models.lean` (never part of the library) applies the headlines at the inhabitants below from
the compiled modules; its print is `data/fs131/iv1/models.txt` (stage 3).

| hypothesis | where it is taken | the inhabitant, named | does the kernel hold it? |
|---|---|---|---|
| **`hram : ∀ x : 𝓞 (fieldI F), conjO F x - x ∈ P.P`** | **`two_mem_of_conj_trivial`, `colorable_two_planeOver_of_ramified`** (`Arith/UpperHalf`) | **`UpperHalf.exists_stablePrime_rat`** (`Instances/UpperHalfValues`: its third clause, at `F = ⊥`, with `UpperHalf.instNumberFieldBot` for `[NumberField F]`). The theorem that applies the two-colour theorem at it is **`UpperHalf.chromaticNumber_planeOver_rat`** (`χ(ℚ²) = 2`); `Models.two_colour_model`, `Models.two_mem_model` apply each of the two at it | **yes, since this job** (leaf I3). It is the only inhabitant the library holds: at the standing field `hram` is refuted at every stable prime (`StandingFive.exists_conjO_sub_notMem`; FS131-IU1's `Models.hram_fails_at_standingField`) |
| `[NumberField F]`, `P : StablePrime F` | every NF1-S1B statement of `Arith/UpperHalf` (`mem_localRing` … `exists_hom_levelTarget`, `chromaticNumber_planeOver_le_levelTarget`) | at `ℚ`: `UpperHalf.exists_stablePrime_rat` and the second `example` of `Instances/UpperHalfValues` § Spec (`Nonempty (StablePrime ⊥)`); at the standing field: `StandingFive.exists_stablePrime_two` | yes, both (`Models.stablePrime_rat_model`, `hom_rat_model`; FS131-IU1's `models.txt`) |
| `1 ≤ m` | `exists_hom_levelTarget`, `chromaticNumber_planeOver_le_levelTarget` | every `m ≥ 1`; at `m = 0` the statement would be false | yes (`Models.hom_rat_model`) |
| `hd : ⟨x, _⟩ - ⟨y, _⟩ ∈ P.localRing` | the formula of `exists_hom_levelTarget` | any two points at distance 1 (`mem_localRing_of_mul_conj_eq_one`), and `x = y` | yes |
| `A ≠ ⊤`, `hσ : ∀ z ∈ A, conjOn _ z ∈ A` | `exists_stablePrime_of_valuationSubring` | `P.localRing` for any stable `P` (`localRing_ne_top`, `conj_mem_localRing`) | yes, at `ℚ` and at the standing field (`Models.converse_rat_model`) |
| `n ≠ 0` | `inv_natCast_mem_unitRingOver_iff_forall_stablePrime` | `n = 2` at `ℚ`, where the right side fails, so `1/2 ∉ ℤ[U_ℚ]` (`Models.wall_rat_model`); `n = 1`, where both sides hold (FS131-IU1's `one_model`) | yes |
| `IsUsablePrime 𝔭`, `Nat.card (𝓞 F ⧸ 𝔭) = p`, `p.Prime` | the five NF1-S1A statements of `Arith/UpperHalf` | `ℚ(√11)` at 7: the third `example` of `Instances/UpperHalfValues` § Spec, through `QuadraticPrime.exists_maximal_card_eq`; used by `chromaticNumber_planeOver_eleven` through `colorable_planeOver_fieldOfRadicands` | **yes, since FS131-IQ1's leaves** (`Models.usablePrime_model`). The library held no model of `IsUsablePrime` before this module |
| `D` finite, `p` prime, `p % 4 = 3`, `hD` (every radicand a nonzero square modulo `p`), `hk : (finitePlane p).Colorable k` | `colorable_planeOver_fieldOfRadicands` | `({11}, 7, 4)` with `finitePlane7_colorable_four`; `({167}, 23, 8)` with `CayleyCert.colorable_finitePlane23_eight`; `({47}, 11, 5)` with `chromaticNumber_finitePlane11` — the three instance theorems | yes |
| `ι : K →+* ℚ_[p]` | `exists_ringHom_zmod_of_padic`, `exists_maximal_card_of_padic` | `algebraMap ℚ ℚ_[5]` — the first `example` of `Arith/QuadraticPrime` | yes |
| `p` an odd prime, `hD` | `exists_padicInt_sq_eq`, `nonempty_ringHom_padic`, `exists_maximal_card_eq`, `exists_maximal_card_eq_sqrt` | `({11}, 7)`, `(47, 11, s = 5)` — its second and third `example`s | yes |
| the split hypotheses and `p ∣ q`, `¬ p ^ 2 ∣ q` | `exists_maximal_card_eq_of_ramified`; `nonempty_ringHom_zmod_of_ramified_sqrt` (its model is built inside the former's proof) | `D = {3}`, `q = 11`, `p = 11`: `K = ℚ(√3, √11)` — its fourth `example` | yes (`Models.ramified_model`) |
| `BochnerHerglotz (unitRing F)`, `InvariantMeasureOnClosed F`, `I : Interface F` with `I.Count`, `I.APlusOfR88`, `I.RU`, `hMR`, `hCLS`, `hRow99`, `hL`, `[IsTotallyReal F]` | `chromaticNumber_eq_localBound_of_chain` | the hypotheses of `SpectralChain.chromaticNumber_eq_localBound`, verbatim, less `hUpper`: assumptions declared to the gate, not conditions with a model here | as on `main` for the headline; § 3 below |

`localBound ⊥` is now an infimum over an inhabited family, so `chromaticNumber_planeOver_le_localBound ⊥` (the first
`example` of the instances file) is not the empty bound `χ ≤ ⊤`. **Not in the kernel**: that `localBound ⊥` is a number
by a statement (`localBound ⊥ ≠ ⊤` or its value) — no theorem colours `levelTarget P 1` at `ℚ`'s prime; and that every
real number field has a stable prime.

### 3. The assumptions step moves — `scripts/Assumptions.lean`, `scripts/assumptions-ledger.txt`, `CLAUDE.md` § Trust ledger

The planner's note (`plans/FS131-KN2-upper-half-plan.md` § D (4)), checked against this tree's files (`main`'s lines are
the same today): a hand result this library assumed in a binder is now a theorem over the same variables, so its entry
has to leave.

- **Leaves**: `scripts/Assumptions.lean:799–800`,
  `.site ``HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound `hUpper "UpperHalf" .ours "row 52 (the upper half χ(F²) ≤ L(F), at ring level; the field step is row 57's gap)",`
  — `UpperHalf.chromaticNumber_planeOver_le_localBound` proves that binder over the theorem's own variables, and the step
  fails on a declared hypothesis a theorem proves over its own variables (`LEAN.md` § The gate). It is the label's only
  site, so the inline hypothesis `UpperHalf` leaves with it, and so does `scripts/assumptions-ledger.txt:129`
  (`TAKES inline:UpperHalf HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound`).
- **Enters**: `UpperHalf.chromaticNumber_eq_localBound_of_chain` takes the headline's other hypotheses. Two are written
  out in binders and are declared on the landing's word, with the label's source character for character:
  `.site ``HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain `hRow99 "Row99" .ours "row 99 (χ(F²) = L(F) at L(F) ≤ 4)",`
  and
  `.site ``HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain `hCLS "CLS" .ours "X23D-CLS (L(F) ≥ 5 ⟹ T-C(A) at S = ∅; X23V § 2.2)",`.
  The seven named ones the scan finds by itself, as it does for the headline (the ledger's rows 47, 61, 64, 69, 78, 84,
  90): `BochnerHerglotz`, `Interface.APlusOfR88`, `Interface.Count`, `Interface.EFPlus`, `Interface.PE2`,
  `Interface.RU`, `InvariantMeasureOnClosed`. `./scripts/assumptions.sh --write-ledger` then adds nine `TAKES` rows for
  the new theorem.
- **The nine counts, predicted, not run**: `axioms=3 rests=23 named=19 inline=15 outside=7 ours=22 open=5 takes=106
  mentions=1` (today `inline=16 ours=23 takes=98`: one inline hypothesis of ours gone; one pair gone and nine entered).
  In words, for `CLAUDE.md` § Trust ledger: thirty-four hypotheses, nineteen named and fifteen written out in a binder —
  seven outside, twenty-two ours, five open — taken in 106 pairs by 52 statements. **This job did not run the step; the
  landing's run decides.** The derivation: the headline holds ten `TAKES` rows today, and the new theorem has its
  binders less `hUpper`.
- **Docstrings to reword at the landing** (not statements; this job edited none): `SpectralChain.lean:624–625` says "given
  the headline's inputs and the upper half `χ(F²) ≤ L(F)` (row 52 at ring level; the field step is row 57's gap), named
  `hUpper`" — the upper half is now `UpperHalf.chromaticNumber_planeOver_le_localBound`, and the form with it discharged
  is `UpperHalf.chromaticNumber_eq_localBound_of_chain`; `SpectralChain.lean:240` likewise.
- No other declared hypothesis is proved by the module (`grep UpperHalf scripts/Assumptions.lean`: the one site).

### 4. What a reader of the statements should be told that the docstrings do not say

For `Arith/UpperHalf` and `Arith/QuadraticPrime`: FS131-IU1's § 3 (seven items) and FS131-IQ1's list (six items) stand,
with one line changed by this job — FS131-IU1's item 3 and 4 say `hram`'s only model and `ℚ`'s stable prime wait on leaf
I3; **they are in the kernel now**. For `Instances/UpperHalfValues`:

1. **`exists_stablePrime_rat` is existence only, and its proof exhibits no ideal.** The docstring names `(1 + i)`; the
   proof takes any maximal ideal over `(2)` and shows more than is stated on the way: conjugation is the identity on
   `𝓞 (ℚ(i))` modulo `2` (`conjO ⊥ x − x ∈ span {2}` for every `x`), so *every* maximal ideal holding 2 is stable and
   has `hram`. Uniqueness of the prime is not stated and not proved.
2. **`χ(ℚ²) = 2` is Woodall's value** (the docstring says so); the kernel proof goes through the stable prime above 2 and
   `colorable_two_unitDistance_induce_of_valuationSubring`, not through his parity colouring written out.
3. **Two of the four values are bounds, not values**: `χ(ℚ(√167)²) ≤ 8` (with row 119's `4 ≤`) and `χ(ℚ(√47)²) ≤ 5` (the
   statement of `SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five`, proved a second way). Neither claims
   exactness; `χ(ℚ(√47)²) = 5` is row 121's, at [hand] over MR.
4. **`two_le_chromaticNumber_planeOver` asks nothing of `F`**: any subfield of `ℝ`, no number field. `2 ≤ χ` is in `ℕ∞`.
5. **`colorable_planeOver_fieldOfRadicands` needs `[Finite D]` and `p % 4 = 3`**; the prime it uses is
   `QuadraticPrime.exists_maximal_card_eq`'s, at which every radicand is a nonzero square — no ramified radicand
   (`exists_maximal_card_eq_of_ramified` has no instance in this file; the two values it would close are a planner's to
   state, FS131-IQ1's draft for row 52).
6. **`numberField_bot` is about the type `↥(⊥ : Subfield ℝ)`**, a field isomorphic to `ℚ`; it is proved by carrying
   `numberField_fieldOfRadicands` across `fieldOfRadicands ∅ = ⊥`.

**A generalization seen, not typed** (a reading, not a theorem): the private lemma
`exists_intCast_eq_re_of_isIntegral` with its symmetric half (`Im z ∈ ℤ`, by the second parity) is
`𝓞 (ℚ(i)) ⊆ ℤ[i]` stated in `ℂ`; with it `exists_stablePrime_rat` would hold with the ideal `span {1 + i}` exhibited and
`𝓞 ⧸ P ≃ 𝔽₂`. No consumer asks.

### 5. `ARCHITECTURE.md` — done on this branch (the brief gives this job the three rows)

The three rows of § 3 no longer say "a skeleton": each opens "**FS-131, NF1 (statements FS131-KN2's; the `<n>` leaves'
proofs `<job>`'s; no `sorry`).**" with FS131-IU1, FS131-IQ1 and FS131-IV1; nothing else in a row changed (no import
added, no public declaration added or removed). `tools/check_architecture.py`: `RESULT: PASS`, exit 0
(`data/fs131/iv1/logs/check_architecture.out`). Its control, on copies: an import dropped from the instances row's
imports cell — exit 1, `FAIL imports of Instances/UpperHalfValues: … real-only ['Arith/QuadraticPrime']`
(`logs/check_architecture.plant-import.out`); an identifier misnamed in the row's description — **exit 0**, the wrong
name listed among "not declared anywhere in `Proofs/`" and not failed (`logs/check_architecture.plant-name.out`): the
checker fails on the map's structure and reports names as information. The rows' 46 backticked spans were read against
that list by hand: the eight it holds are `sorry` (three times), three dotted names declared under `_root_`
(`StablePrime.heightOne`, `.localRing`, `.residue`), Mathlib's `valuationSubringAtPrime` and the binder `hUpper` — none
a misnamed declaration. If `main`'s map moved near these rows, the merge will say so; the rows' text is this branch's.

### 6. `LEDGER.md` (Keryx's; each to be filed when the module is through the gate)

The planner's drafts stand (`plans/FS131-KN2-upper-half-plan.md` § Stage 5: rows 52, 57, 63, 73, 99, 105, 119, 121,
123, 127), with FS131-IQ1's amendment of row 52's last sentence ("The ramified clause is in the kernel
(`QuadraticPrime.exists_maximal_card_eq_of_ramified`); the two values stay [hand] until it is applied at 11 to `K(√5)`
and `K(√247)`."). **Every declaration those drafts name is now proved and built on this branch.** What this job's
leaves carry: row 63's instance (`UpperHalf.chromaticNumber_planeOver_rat`, `χ(ℚ²) = 2`, the value Woodall's) and the
first inhabitant of its two-colour theorem at a real field (`UpperHalf.exists_stablePrime_rat`); row 73's upper half
and the equality (`UpperHalf.chromaticNumber_planeOver_eleven`; the lower half was held); rows 119 and 121's upper
ends (`…_sqrt167_le_eight`, `…_sqrt47_le_five_of_prime`). Regraded rows, each with what it rests on by name:
- row 73, `χ(ℚ(√11)²) = 4` → **[kernel]**, both halves: `UpperHalf.chromaticNumber_planeOver_eleven`, on the standard
  three; no assumption. The upper bound is `[Fischer1990]` Thm 9's and `[Moorhouse2010]` Thm 8.1's (`Instances/SqrtEleven.lean:29`; the
  library's attribution, not re-read by this job).
- row 63's instance, `χ(ℚ²) = 2` → **[kernel]**: `UpperHalf.chromaticNumber_planeOver_rat`, on the standard three; no
  assumption. The value is Woodall's.
- row 119's upper end, `χ(ℚ(√167)²) ≤ 8` → **[kernel]**: `UpperHalf.chromaticNumber_planeOver_sqrt167_le_eight`.
- rows 52 and 57 in the forms the planner's drafts give; rows 99, 123, 127: the upper half
  `UpperHalf.chromaticNumber_planeOver_le_localBound` on the standard three, and
  `UpperHalf.chromaticNumber_eq_localBound_of_chain` on the standard three **and on every hypothesis of the chain but
  `hUpper`** (§ 3).

### 7. `LEAN.md` § Searching — Lean (Keryx's; new lines, after the planner's four and the two implementers')

- `rw [Subfield.bot_eq_of_charZero] at hx` fails with "motive is not type correct" when `hx` speaks of an element whose
  type mentions `⊥` (`x : 𝓞 (fieldI ⊥)`): state "an element of `⊥ : Subfield ℝ` is a rational" for a real number once
  (`∀ r : ℝ, r ∈ (⊥ : Subfield ℝ) → ∃ q : ℚ, (q : ℝ) = r`) and apply it (FS131-IV1).
- `simp` does not reduce `((2 : 𝓞 K) : K)` read in `ℂ` through a subfield's coercion (the line of FS131-I10C, one coercion
  further): `rw [two_mul]` before taking coordinates, or state the fact without the numeral (`x + conjO x = m + m`) and
  finish in the commutative ring with `linear_combination` (`UpperHalf.exists_stablePrime_rat`; FS131-IV1).
- `Complex.isIntegral_int_I` is not a name at the pin; `IsIntegral.of_pow (n := 2) (by norm_num) (by rw [Complex.I_sq];
  exact isIntegral_one.neg)`. A rational that is integral over `ℤ` in `ℂ` is an integer by `isIntegral_algebraMap_iff`
  and `IsIntegrallyClosed.isIntegral_iff`; trace, norm and `(z̄ − z)·i` are `Complex.add_conj`, `Complex.mul_conj`,
  `Complex.sub_conj` (FS131-IV1).
- `omega` takes a square as an atom: a parity contradiction such as `(2m+1)² + (2k)² = 4n` closes with one `ring`
  identity stated as a `have` and `omega` (FS131-IV1).
- `tools/check_architecture.py` fails on a row's imports cell and on module coverage; a misnamed identifier in a row's
  description is listed under `[3]` and does not fail (FS131-IV1, two plants on copies).
- Before the build that joins two branches, the compiled modules of one of them are the skeleton's: a `#print axioms`
  file run then prints `sorryAx` on every record that reads them — kept as the pipeline's control
  (`data/fs131/iv1/axioms.before-build.txt`: 22 of 52; FS131-IV1).

## Drafts for the front page

*Each names its slot. Keryx files; the landing decides when. This job ran no gate, so it has no gate count of its own:
what follows is what the landing's counts will move by, from the built modules, and the lines to file once the module
is through the gate.*

- **`CLAUDE.md` § Trust ledger, the audit sentence** ("the current audit reads 7364 clean and 5 declared purchases, and
  23 imported (and 28 axiom-free; 7,420 records …)", as `main` reads today): the module adds **52 records, all CLEAN,
  none axiom-free, none imported, no purchase** — 7,416 clean and 7,472 records if nothing else lands first; the
  landing's audit gives the numbers.
- **`CLAUDE.md` § Trust ledger, the nine counts** — in place of
  `axioms=3 rests=23 named=19 inline=16 outside=7 ours=23 open=5 takes=98 mentions=1`, **predicted, not run**:
  `axioms=3 rests=23 named=19 inline=15 outside=7 ours=22 open=5 takes=106 mentions=1`, and in the sentence after it
  "thirty-four hypotheses, nineteen named and fifteen written out in a binder — seven standing for outside theorems,
  twenty-two for hand results of ours and five declared as open questions — taken in 106 (hypothesis, statement) pairs
  by 52 statements" (drafts for the landing, § 3, has the derivation and the three edits that produce it).
- **`CLAUDE.md` § The gate, the vacuity counts**: the landing's scan gives them; this job has none to draft. By hand:
  no binder of the three files is a colouring structure, one headline takes a `Colorable` hypothesis
  (`colorable_planeOver_fieldOfRadicands`, inhabited three times in its own file), and no statement of the three files
  is a candidate for the baseline (drafts for the landing, § 2, names each hypothesis's model).
- **`CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval"** — after "**χ(ℚ(√11)²) ≥ 4**
  and the 3-adic barrier (rows 72–73);" a clause for the landing to file: "**the residue upper half at every real
  number field** — `χ(F²) ≤ χ(Γ_q)` at a usable prime and `χ(F²) ≤ L(F)` (`UpperHalf.chromaticNumber_planeOver_le_finitePlane`,
  `UpperHalf.chromaticNumber_planeOver_le_localBound`), a degree-one prime at every field of square roots whose
  radicands are nonzero squares modulo an odd prime (`QuadraticPrime.exists_maximal_card_eq`), and with them
  **`χ(ℚ(√11)²) = 4`** and **`χ(ℚ²) = 2`** exactly, `χ(ℚ(√167)²) ≤ 8`, and `χ(ℚ(√47)²) ≤ 5` a second way (rows 52, 57,
  63, 73, 119, 121; known values — attributions as `LEDGER.md` § The claim list and the rows give them — the kernel
  proofs ours);".
- **The Frontier line** (`CLAUDE.md` § Frontier, "Last filed"), for the landing: "**FS-131's first number-field module,
  the residue upper half**, through the gate (`Arith/UpperHalf`, `Arith/QuadraticPrime`, `Instances/UpperHalfValues`;
  52 public declarations on the standard three; no value moved: `χ(ℚ(√11)²) = 4` and `χ(ℚ²) = 2` are known values, now
  kernel-checked in both halves; the chain's headline loses its hypothesis `hUpper`)".
- **The Proof Atlas, grade changes** (each when the module is through the gate): row 73's value `χ(ℚ(√11)²) = 4`
  (kernel below, the plane at 7 by citation above) → **[kernel]** in both halves,
  `UpperHalf.chromaticNumber_planeOver_eleven`; row 63's instance
  `χ(ℚ²) = 2` → **[kernel]**, `UpperHalf.chromaticNumber_planeOver_rat`; row 52's bound (not its two values) →
  **[kernel]**, `UpperHalf.chromaticNumber_planeOver_le_unitQuadrance`, `…_le_finitePlane`,
  `QuadraticPrime.exists_maximal_card_eq`; row 57's "Not proved" clause → **[kernel]**,
  `UpperHalf.exists_hom_levelTarget`, `UpperHalf.exists_stablePrime_of_valuationSubring`; row 105's number-field
  reading → **[kernel]**, `UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime`; row 119's upper end `≤ 8` →
  **[kernel]**; rows 99, 123, 127: the hypothesis `inline:UpperHalf` discharged
  (`UpperHalf.chromaticNumber_planeOver_le_localBound`), every other hypothesis of the chain standing. Each of these
  rests on the standard three and on no assumption, except `UpperHalf.chromaticNumber_eq_localBound_of_chain`, which
  rests on the chain's nine remaining hypotheses by name: `BochnerHerglotz`, `InvariantMeasureOnClosed`,
  `Interface.Count`, `Interface.APlusOfR88`, `Interface.RU`, `Interface.PE2`, `Interface.EFPlus`, `inline:CLS`,
  `inline:Row99`.
- **`LEDGER.md`, `LEAN.md`**: drafts for the landing, §§ 6 and 7.
