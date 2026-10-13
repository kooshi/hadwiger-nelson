# FS131-IU1 — the residue upper half, `Arith/UpperHalf.lean`: the twelve leaves

*de Bruijn, the implementer; brief `data/fs131/briefs/FS131-IU1-leaves.md` (on `main`); branch `fs131-wnf`, worktree
`.claude/worktrees/fs131-wnf`, from `223241b0a`. Opened 2026-10-13. Working files: `data/fs131/iu1/`. The plan this job
implements is `plans/FS131-KN2-upper-half-plan.md` § Stage 4 A (U1–U12). The stages below are saved in order; a successor
resumes at the first stage not marked SAVED.*

## Theorems this phase proved

All in `Proofs/HadwigerNelson/Arith/UpperHalf.lean`, namespace `HadwigerNelson.UpperHalf`. **Grade of each line: kernel-checked
in a build of this branch (stage 5), axioms `[propext, Classical.choice, Quot.sound]` read from the compiled module
(`data/fs131/iu1/axioms.txt`); not through the gate** — no audit, no vacuity scan, no assumptions step was run by this job.
Statements are FS131-KN2's, unchanged (stage 5's comparison from the kernel's side).

**The twelve leaves** (each was `sorry` at `223241b0a`):
- `mem_localRing` — `x ∈ 𝓞_P ↔ ∃ a s : 𝓞, s ∉ P ∧ x = a / s`.
- `conj_mem_localRing` — `𝓞_P` is conjugation-stable.
- `isUnit_mk_pow` — an integer outside `P` is a unit of `𝓞 ⧸ P^m`.
- `residue_div` — `res(a / s) · s̄ = ā`.
- `residue_conj` — `res(z̄) = (res z)‾`.
- `coe_mem_nonunits_localRing_iff` — an integer is a non-unit of `𝓞_P` exactly when it lies in `P`.
- `localRing_ne_top` — `𝓞_P ≠ F(i)`.
- `exists_hom_levelTarget` — **NF1-S1B's homomorphism at every level `m ≥ 1`**, with its formula on cosets of `𝓞_P`.
- `two_mem_of_conj_trivial` — a stable prime modulo which conjugation is the identity holds 2.
- `colorable_two_planeOver_of_ramified` — two colours at such a prime (row 63's theorem at a real number field).
- `exists_stablePrime_of_valuationSubring` — **NF1-S1B's converse half**.
- `inv_natCast_mem_unitRingOver_iff_forall_stablePrime` — row 105 over the stable primes.

**Theorems of the skeleton that were proved from those leaves and are theorems now** (their proofs are the planner's):
`mem_localRing_of_mul_conj_eq_one`, `residue_algebraMap` (through the definition `StablePrime.residue`, whose proof
argument is `isUnit_mk_pow`), `nonempty_hom_levelTarget_one` (**NF1-S1B, first clause as claimed**),
`chromaticNumber_planeOver_le_levelTarget`, `chromaticNumber_planeOver_le_localBound` (**NF1-S1B, second clause:
`χ(F²) ≤ L(F)`**), `chromaticNumber_eq_localBound_of_chain` (the chain's headline with `hUpper` discharged; its other
hypotheses are assumptions, unchanged).

**Private helpers this job added** (six; same grade, axioms from `data/fs131/iu1/axioms-footer.txt`):
`sub_mul_conj_eq_one`, `residue_mul_conj_eq_one`, `exists_I_integer`, `integer_mem_valuationSubring`, `exists_centre`
(the centre of a valuation subring of any number field on its integers is a maximal ideal), `conj_mem_nonunits_iff`.

Not this job's, already theorems at `223241b0a` and unchanged: the five NF1-S1A declarations, `heightOne_asIdeal`,
`coe_conjO`, `conjO_conjO`, `conjO_mem_iff`.

## Stage 1 — SAVED: the readback

**The brief's quotations.** Five blocks — `W2` against `data/fs131/REQUEST-2026-10-13.md`; `NF1-S1A`, `NF1-S1B` and the two
dated lines of 2026-10-13 16:36 UTC against `data/fs131/claims-NF1.md` — compared character for character by
`data/fs131/iu1/readback.py`, **against the copies on `main`** (this branch's claim list predates the dated lines): five
`IDENTICAL` (`data/fs131/iu1/logs/readback.out`). Control (`--control`: one word changed in every quotation): five `DIFFERS`
(`logs/readback.control.out`). **No mismatch.**

**The skeleton's statements as the kernel holds them, before any edit.** `data/fs131/iu1/lean/StatementDump.lean` prints
every constant stored in the compiled data of `Proofs.HadwigerNelson.Arith.UpperHalf` (the planner's build 3 of `223241b0a`:
`.olean` of Oct 13 12:47) — kind, full name, stored type, a definition's stored value: 45 constants,
`data/fs131/iu1/statements-before.txt`. The reader is `data/fs131/iu1/statement_diff.py` (stage 2 runs it with its control).

**Each leaf, read in the source (`Proofs/HadwigerNelson/Arith/UpperHalf.lean` at `223241b0a`) and against the plan.**
Notation: `K = fieldI F`, `𝓞 = 𝓞 (fieldI F)`, `B = P.localRing`, `σ = conjOn (fieldI_conj F)`, `mk = Ideal.Quotient.mk (P.P ^ m)`.

| leaf | the statement, in one line | the plan's route (§ Stage 4 A) | agree? |
|---|---|---|---|
| U1 `mem_localRing` | `x ∈ B ↔ ∃ a s : 𝓞, s ∉ P.P ∧ x = (a : K) / (s : K)` | `ValuationSubring.mem_ofSubring`, then `show` the subalgebra's membership; `div_eq_mul_inv` both ways (`Arith/PlaceHom.lean:113–117`) | yes |
| U2 `conj_mem_localRing` | `∀ z ∈ B, σ z ∈ B` | U1; `⟨conjO F a, conjO F s, mt (conjO_mem_iff P).1 hs, map_div₀ …⟩` | yes |
| U3 `isUnit_mk_pow` | for `y : P.heightOne.asIdeal.primeCompl`, `IsUnit (mk (y : 𝓞))` (every `m`, `m = 0` included: the zero ring) | `Ideal.IsMaximal.exists_inv_pow`, `IsUnit.of_mul_eq_one` | yes |
| U4 `residue_div` | `P.residue m ⟨a / s, _⟩ * mk s = mk a` for `s ∉ P.P` | `PlaceHom.lean:149–157` with `residue_algebraMap` | yes |
| U5 `residue_conj` | `P.residue m ⟨σ z, _⟩ = Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) (P.residue m z)` | two ring homs `B →+* 𝓞 ⧸ P^m` agreeing on `algebraMap 𝓞 B`; `IsLocalization.ringHom_ext` | yes |
| U6 `coe_mem_nonunits_localRing_iff` | `(a : K) ∈ B.nonunits ↔ a ∈ P.P` for `a : 𝓞` | `ValuationSubring.mem_nonunits_iff_or` with U1, or `IsLocalization.AtPrime.to_map_mem_maximal_iff` | yes |
| U7 `localRing_ne_top` | `B ≠ ⊤` | `valuationSubringAtPrime_eq_valuationSubring`, or a nonzero `a ∈ P.P` and U6 | yes |
| U8 `exists_hom_levelTarget` | for `1 ≤ m`: `∃ h : (unitDistance ℂ).induce (planeOver F) →g levelTarget P m, ∀ x y (hd : ⟨x, x.2⟩ - ⟨y, y.2⟩ ∈ B), h x - h y = P.residue m ⟨_, hd⟩` | `cosetResidue` of `r ∘ e.symm` on the image of `B` in `ℂ`; adjacency by U5 and `mem_localRing_of_mul_conj_eq_one` | yes |
| U9 `two_mem_of_conj_trivial` | `(∀ x : 𝓞, conjO F x - x ∈ P.P) → (2 : 𝓞) ∈ P.P` — stated under `omit [NumberField F]` | `i ∈ 𝓞`, `conjO i − i = −2i`, primality, `i² = −1` | yes |
| U10 `colorable_two_planeOver_of_ramified` | `(∀ x : 𝓞, conjO F x - x ∈ P.P) → ((unitDistance ℂ).induce (planeOver F)).Colorable 2` | `colorable_two_unitDistance_induce_of_valuationSubring` at `B`, `P.residue 1`, the field `𝓞 ⧸ P^1` of characteristic 2 | yes |
| U11 `exists_stablePrime_of_valuationSubring` | `A : ValuationSubring K`, `A ≠ ⊤`, `∀ z ∈ A, σ z ∈ A` ⟹ `∃ P : StablePrime F, P.localRing = A` | the centre of `A` on `𝓞` is a nonzero prime fixed by conjugation; `ValuationSubring.eq_of_le_of_ne_top` | yes |
| U12 `inv_natCast_mem_unitRingOver_iff_forall_stablePrime` | for `n ≠ 0`: `(n : ℂ)⁻¹ ∈ UnitRing.unitRingOver F ↔ ∀ P : StablePrime F, (n : 𝓞) ∉ P.P` | `UnitRing.inv_natCast_mem_unitRingOver_iff`, U2, U6, U11 | yes |

No leaf's statement disagrees with its plan; none reads false or vacuous on reading (each is checked again when proved).
Order taken: the plan's — U1, U2, U3, U4, U5, U6, U7, U9, U10, U8, U11, U12.

**The between-builds form of the statement check** (`data/fs131/iu1/statements.sh`): the skeleton (`git show 223241b0a:…`)
and the working module, each with `lean/StatementFooter.lean` appended (the same print, of the constants the file itself
declares), elaborated **at one path in turn** and compared by `statement_diff.py`, then its control (three plants: one token
of one stored statement, one definition's value, one declaration removed — three reported). On the untouched file: `PASS`,
30 named constants compared (27 theorems, 3 definitions), control `3 of 3`. A first version elaborated the two copies at two
paths and reported 29 false differences on an untouched file: an instance binder's stored name carries the file's module
name (`inst._@.<module>.<n>._hygCtx._hyg.6`). The control said so itself (`29 of 3 … DID NOT FIRE AS PLANTED`).

## Stage 2 — SAVED: U1–U7 proved

`mem_localRing`, `conj_mem_localRing`, `isUnit_mk_pow`, `residue_div`, `residue_conj`, `coe_mem_nonunits_localRing_iff`,
`localRing_ne_top` — each by the plan's route, one iteration (`lake env lean`: exit 0, five `sorry` left; 4.4 s, 3.6 GB).
Statement check (`data/fs131/iu1/logs/statements-stage2.out`): `PASS`, control `3 of 3`.

What differed from the plan's text, for the next reader:
- U1 needs no `ValuationSubring.mem_ofSubring`: `show x ∈ HeightOneSpectrum.valuationSubringAtPrime (fieldI F) P.heightOne ↔ _`
  and the membership destructs directly (`rintro ⟨a, s, hs, rfl⟩`, as Mathlib does).
- The coercion `𝓞 K → K` is `RingOfIntegers.val`, an `abbrev` for `algebraMap`: `rw [map_one]` / `rw [map_mul]` do not see
  through it (the head symbol is `val`); `simp` does, and so does a term `(map_mul (algebraMap _ _) a b).symm`.
  `RingOfIntegers.coe_eq_zero_iff` is the injectivity at `0`.
- U5: the restricted conjugation is named by a `let σB : P.localRing →+* P.localRing := (conjOn _).restrict
  P.localRing.toSubring P.localRing.toSubring _` — without the ascription `algebraMap (𝓞 K) P.localRing` is asked for an
  `Algebra (𝓞 K) ↥P.localRing.toSubring` instance, which does not exist (the instance is on `↥P.localRing`).
- U7 by the elementary alternative (a nonzero `a ∈ P.P` and U6), four lines.

## Stage 3 — SAVED: U9, U10, U8 proved

`two_mem_of_conj_trivial`, `colorable_two_planeOver_of_ramified`, `exists_hom_levelTarget` — the plan's routes
(`lake env lean`: exit 0, two `sorry` left — U11, U12; 5.6 s, 3.7 GB). Statement check
(`data/fs131/iu1/logs/statements-stage3.out`): `PASS`, control `3 of 3`; three new named constants, the private helpers.

Three private helpers, each a typed joint of its parent:
- `exists_I_integer : ∃ i : 𝓞 (fieldI F), i ^ 2 = -1 ∧ conjO F i = -i` (no number-field hypothesis; `IsIntegral.of_pow`) — U9.
- `sub_mul_conj_eq_one {x y : planeOver F} (h : dist (x : ℂ) (y : ℂ) = 1) : (⟨x, x.2⟩ - ⟨y, y.2⟩ : fieldI F) * conjOn
  (fieldI_conj F) (⟨x, x.2⟩ - ⟨y, y.2⟩) = 1` — the geometry of U8, by `Subtype.ext (sub_mem_normOne_conj_iff.mpr h)`; the
  library's `simpa [mem_normOne, map_sub]` (`ResidueColouring.lean:612`) does not close it here: `simp` rewrites
  `⟨↑x, _⟩ - ⟨↑y, _⟩` to `↑(x - y)` and leaves a goal it cannot match.
- `residue_mul_conj_eq_one (P) (m) (hu : u * conjOn (fieldI_conj F) u = 1) (hd : u ∈ P.localRing) : P.residue m ⟨u, hd⟩ *
  Ideal.quotientMap (P.P ^ m) (conjO F) (P.le_comap m) (P.residue m ⟨u, hd⟩) = 1` — U8's arithmetic, by U5.

What differed from the plan's text:
- U10 needs no `Ideal.Quotient.field`: `(P.P ^ 1).IsPrime` (from `pow_one`) gives `IsDomain`, hence `IsReduced`, by instance,
  and `one_ne_zero` for `CharTwo.of_one_ne_zero_of_two_eq_zero`. `hψσ` is `(residue_conj P 1 z).trans (hid _)` as a term: the
  two spellings of the restricted conjugation unify by unfolding.
- U8 as planned; `Ideal.pow_le_self` takes `m ≠ 0`.

## Stage 4 — SAVED: U11, U12 proved; the file has no `sorry`; every declaration prints the standard three

`exists_stablePrime_of_valuationSubring` and `inv_natCast_mem_unitRingOver_iff_forall_stablePrime` — the plan's routes, one
iteration. `lake env lean` with the lakefile's three options (`autoImplicit`, `relaxedAutoImplicit` off, `linter.missingDocs`
on): exit 0, **no message at all** — no error, no warning, no `sorry` (6.0 s, 3.7 GB). `grep -c sorry` on the file: 0.
Statement check (`data/fs131/iu1/logs/statements-stage4.out`): `PASS`, control `3 of 3`; the six private helpers listed by
name. (Stage 3's line "three new named constants" was wrong as worded: a private declaration's stored name is flagged
internal by the dumper, so the reader's count of new *named* constants stays 0; it now lists the private ones separately.)

**Axioms, before the build** (`data/fs131/iu1/lean/AxiomsFooter.lean` appended to a copy of the file: `collectAxioms` on every
theorem and definition the file declares; `data/fs131/iu1/axioms-footer.txt`): 36 declarations — 30 public, 6 private — each
`[Classical.choice, Quot.sound, propext]`; `sorryAx` on none. Control (`axioms-footer.control.txt`): the same footer on the
skeleton at `223241b0a` prints `sorryAx` on 19 of its 30 declarations — the 12 leaves, the definition `StablePrime.residue`
(its proof argument is the leaf `isUnit_mk_pow`), and the six theorems proved from them.

Three more private helpers, for U11:
- `integer_mem_valuationSubring {K} [Field K] (A : ValuationSubring K) (x : 𝓞 K) : (x : K) ∈ A` — any field, no finiteness.
- `exists_centre {K} [Field K] [NumberField K] (A : ValuationSubring K) (hA : A ≠ ⊤) : ∃ Q : Ideal (𝓞 K), Q.IsMaximal ∧
  ∀ a : 𝓞 K, a ∈ Q ↔ (a : K) ∈ A.nonunits` — the centre of a valuation subring of a number field on its integers; `Q` is
  `(IsLocalRing.maximalIdeal A).comap ι`, `ι := (algebraMap (𝓞 K) K).codRestrict A _`, and the membership clause is
  `ValuationSubring.mem_nonunits_iff_exists_mem_maximalIdeal` read both ways. No conjugation enters: it is a statement
  about any number field.
- `conj_mem_nonunits_iff (A) (hσ) (z) : conjOn (fieldI_conj F) z ∈ A.nonunits ↔ z ∈ A.nonunits`.

With them U11 is eight lines: the centre, its stability (`Ideal.mem_comap`, the membership clause twice, `coe_conjO`, the
helper), `𝓞_Q ≤ A` (a denominator outside `Q` is a unit of `A`), and `ValuationSubring.eq_of_le_of_ne_top`.

## Stage 5 — SAVED: the build, the statements and the axioms from the kernel's side, the models

**The one build.** `env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 scripts/slot.py --mem 10 --cpus 4 --name iu1-build -- env
MEMMAX=10G BATCH=8 ./scripts/build.sh`, from the worktree (four cores, not eight: a landing's build held the other eight).
**Exit 0**: `build: OK — 249 of 249 batches, 3 module(s) rebuilt, 2 module(s) with warnings, 7m24s` — `Arith.UpperHalf`
(4.6 s), `Instances.UpperHalfValues` (2.2 s), `Proofs` (2.1 s); 7 m 28 s wall with the slot, 4.53 GB peak, 2026-10-13
18:03:26–18:10:54 UTC (`data/fs131/iu1/logs/build1.{out,exit,time,start,end}`; the build's own log
`build/gate/build/20261013T180327Z-382598.log`). **Warnings naming `Arith/UpperHalf.lean`: 0** in both logs. The two
modules with warnings are `Arith/QuadraticPrime` (nine `declaration uses sorry`, replayed, not rebuilt) and
`Instances/UpperHalfValues` (three): other jobs' leaves. `grep -c sorry Proofs/HadwigerNelson/Arith/UpperHalf.lean`: 0.

**No statement changed, from the kernel's side.** `data/fs131/iu1/lean/StatementDump.lean` on the rebuilt module:
56 constants (45 before). `statement_diff.py statements-before.txt statements-after.txt`
(`logs/statements-final.compact.out`): **`PASS` — 30 named constants (27 theorems, 3 definitions) of the skeleton's compiled
module, each in the rebuilt module with the same kind, the same stored type and, for a definition, the same stored value**;
no new public constant; six new private theorems, listed by name; internal constants 15 → 26 (not compared: they move with
a proof). Control (`logs/statements-final.compact.control.out`): three planted faults, three reported. From the file's side
(`logs/module.diff`, `git diff 223241b0a`): the only lines removed are twelve `  sorry`; 207 lines added; no other file
under `Proofs/` differs.

*The two dumps as kept.* The dumper writes every instance term out: the raw prints are 18,519,297 bytes (before; SHA-256
`7694cd78…b7d2c`, the file committed at `a370cf2f3`) and 20,913,804 bytes (after; `327daabc…fa449`;
`logs/full-dump-sha256.txt`). `data/fs131/iu1/compact_dump.py` keeps, for each stored term, Lean's hash, the SHA-256 of
its raw text, its length and its first 160 characters; `statements-before.txt` and `statements-after.txt` are now those
(17 kB and 21 kB), and the raw files are not kept in the tree (before: `git show a370cf2f3:data/fs131/iu1/statements-before.txt`;
after: `data/fs131/iu1/lean1.sh data/fs131/iu1/lean/StatementDump.lean` on this build). The comparison was run on both
forms and printed one report (`logs/statements-final.raw.out`, `…compact.out`); and a change planted in a copy of the raw
after-dump — one constant renamed 400 characters or more into `localRing_ne_top`'s stored type, past the kept head — is
reported after compaction (`logs/statements-planted-file.out`: `FAIL: 1 difference(s)`, exit 1).

**The axioms, from the compiled module.** `data/fs131/iu1/lean/Axioms.lean` (`#print axioms` on the 30 public declarations,
generated with the audit block by `make_audit.py` from `statements-after.txt`): `data/fs131/iu1/axioms.txt`.
`read_axioms.py axioms.txt 30 --names audit-block.txt`: **30 records, each `[propext, Classical.choice, Quot.sound]` or
fewer; none beyond the standard three; the same names as the block, in order**. Control: a planted `sorryAx` record and a
planted undeclared axiom, both reported. The private helpers' prints are stage 4's (`axioms-footer.txt`).

**The models, from the compiled modules** (`data/fs131/iu1/lean/Models.lean`, `models.txt`): exit 0, no message but the
prints; eight records on the standard three — `StandingFive.exists_stablePrime_two`, `StandingFive.instNumberFieldStanding`
and the six model theorems of the drafts' § 2 (`stablePrime_model`, `hom_model`, `converse_model`, `wall_model`,
`one_model`, `hram_fails_at_standingField`).

**Run once, not as a gate** (the landing's to run and to control): `lake lint --no-build -- --no-build --trace` under the
slot on this tree's build — exit 0, `-- Linting passed for Proofs.`, 14 linters, 14 `(2/2) Passed!` (15 s, 5.1 GB;
`logs/lint.out`); `tools/check_architecture.py` — `RESULT: PASS` (`logs/check_architecture.out`; this job added no import
and no public declaration). No negative control was planted in either by this job.

**What this job did not run**: `scripts/axioms.sh`, `scripts/dupnames.sh`, `scripts/vacuity.sh`, `scripts/assumptions.sh`,
`lean4checker`. No companion skill was invoked: no leaf took a third attempt (U1–U7 closed on the second elaboration, the
others on the first or second).

**The machine, as measured here**: `lake env lean` on the finished module 4.4–6.0 s (once 10.7 s), 3.6–3.7 GB,
under `--mem 4`; a check file importing the module 2.6–3.2 s, 3.7–3.8 GB; the build 7 m 24 s at `BATCH=8` on four cores
beside another build (6 m 35 s alone on ten, the planner's); nothing was refused by the slot.

**Process left running: none.** The slot ledger holds no entry of this job.

## Drafts for the landing (saved with stage 5)

*This job ran no gate: no audit, no vacuity scan, no assumptions step, no `dupnames`. What follows is for the landing
(FS131's NF1 landing, with `Arith/QuadraticPrime` and `Instances/UpperHalfValues`).*

### 1. The audit block — `scripts/Axioms.lean`, in the landing's CLEAN block for the module

`data/fs131/iu1/audit-block.txt`: 30 records, one `#print axioms` line per public declaration of `Arith/UpperHalf` a person
typed (27 theorems, 3 definitions), in the file's order; generated by `data/fs131/iu1/make_audit.py` from the compiled
module's own list of named constants, and it fails if the source writes a public declaration the dump does not hold or the
dump holds a named constant the source does not write. The same lines under the module's import are
`data/fs131/iu1/lean/Axioms.lean`; its print after the build is `data/fs131/iu1/axioms.txt` (stage 5). **Every record
CLEAN**: no declared outside theorem is read by the module (`Arith/UpperHalf` does not import `Arith/WeilKloosterman` or
`Outside/OAI158`, and no record's print holds an axiom beyond the standard three).

The six private helpers (`sub_mul_conj_eq_one`, `residue_mul_conj_eq_one`, `exists_I_integer`,
`integer_mem_valuationSubring`, `exists_centre`, `conj_mem_nonunits_iff`) cannot be named from `scripts/Axioms.lean`. Each
is read by a public record (`exists_hom_levelTarget`, `two_mem_of_conj_trivial`, `exists_stablePrime_of_valuationSubring`),
whose print therefore contains theirs; their own prints, by `collectAxioms` on the private names, are in
`data/fs131/iu1/axioms-footer.txt`.

### 2. A model for each hypothesis of the headlines

`data/fs131/iu1/lean/Models.lean` (never part of the library: `Arith/UpperHalf` does not import `Arith/StandingFive`)
applies the headlines at the one model the kernel holds on `main` today — the standing field
`StandingFive.standingField = ℚ(√3, √11, η)`, a number field (`StandingFive.instNumberFieldStanding`), with a stable prime
of its `F(i)` above 2 (`StandingFive.exists_stablePrime_two`). Its print is `data/fs131/iu1/models.txt` (stage 5).

| hypothesis | where it is taken | model | does the kernel hold it? |
|---|---|---|---|
| `[NumberField F]`, `P : StablePrime F` | every NF1-S1B statement: `mem_localRing` … `exists_hom_levelTarget`, `chromaticNumber_planeOver_le_levelTarget` | the standing field with `StandingFive.exists_stablePrime_two` (`Models.stablePrime_model`, `hom_model`); `ℚ` with `UpperHalf.exists_stablePrime_rat` | at the standing field: yes (stage 5's print). At `ℚ`: not until leaf I3 of `Instances/UpperHalfValues` is proved (`sorry` in this tree) |
| `1 ≤ m` | `exists_hom_levelTarget`, `chromaticNumber_planeOver_le_levelTarget` | every `m ≥ 1` (`Models.hom_model`); at `m = 0` the statement would be false — the docstring says why | yes |
| `hd : ⟨x, _⟩ - ⟨y, _⟩ ∈ P.localRing` | the formula of `exists_hom_levelTarget` | any two points at distance 1 (`mem_localRing_of_mul_conj_eq_one` — the proof uses the formula exactly there), and `x = y` | yes |
| `hram : ∀ x, conjO F x - x ∈ P.P` | `two_mem_of_conj_trivial`, `colorable_two_planeOver_of_ramified` | **only at `ℚ`**: `UpperHalf.exists_stablePrime_rat` (leaf I3). At the standing field it is **refuted** at every stable prime (`StandingFive.exists_conjO_sub_notMem`; `Models.hram_fails_at_standingField`) | **no, not until leaf I3 is proved.** Until then the two-colour theorem has no inhabitant of its hypotheses in the kernel |
| `A ≠ ⊤`, `hσ : ∀ z ∈ A, conjOn _ z ∈ A` | `exists_stablePrime_of_valuationSubring` | `P.localRing` for any stable `P` (`localRing_ne_top`, `conj_mem_localRing` — same file); `Models.converse_model` | yes, at the standing field |
| `n ≠ 0` | `inv_natCast_mem_unitRingOver_iff_forall_stablePrime` | `n = 2` at the standing field, where the right side fails and so `1/2 ∉ ℤ[U_F]` (`Models.wall_model`); `n = 1`, where both sides hold (`Models.one_model`) — both sides of the iff occur | yes |
| `IsUsablePrime 𝔭` (with `Nat.card (𝓞 F ⧸ 𝔭) = p`, `p.Prime`) | the five NF1-S1A statements (the planner's proofs; not this job's leaves) | `ℚ(√11)` at 7: the `example` at the end of `Instances/UpperHalfValues`, through `QuadraticPrime.exists_maximal_card_eq` | not until leaves Q4–Q7 of `Arith/QuadraticPrime` are proved (FS131-IQ1). **The library held no model of `IsUsablePrime` before this module** (`Arith/PlaceHom` names none) |
| `BochnerHerglotz (unitRing F)`, `InvariantMeasureOnClosed F`, `I : Interface F` with `I.Count`, `I.APlusOfR88`, `I.RU`, `hMR`, `hCLS`, `hRow99`, `hL`, `[IsTotallyReal F]` | `chromaticNumber_eq_localBound_of_chain` | the hypotheses of `SpectralChain.chromaticNumber_eq_localBound`, verbatim, less `hUpper`: assumptions declared to the gate there, not conditions with a model here | as on `main` for the headline; the plan's § D (4) has what the assumptions step must change |

### 3. What a reader of the statements should be told that the docstrings do not say

1. **"Into", not "onto".** `exists_hom_levelTarget` gives a homomorphism *into* `levelTarget P m`; no surjectivity is stated
   or proved (the module docstring's "Not claimed" says the target is every norm-one element of the quotient, not the image
   of the unit vectors). The brief's title for this job says "maps homomorphically onto its residue target"; the claim
   NF1-S1B and the statement say "into".
2. **The homomorphism is not canonical.** It is `cosetResidue` of the residue map: on each coset of `𝓞_P` in `F(i)` it is
   the residue map up to an additive constant chosen by `Classical.choice`. The formula `h x − h y = res(x − y)` is all a
   consumer may use, and it speaks only of pairs in one coset.
3. **`hram` reads "ramified", and its only model is `ℚ` so far.** `∀ x, conjO F x - x ∈ P.P` says conjugation is the identity
   on `𝓞 ⧸ P`; for a stable prime of the quadratic extension `F(i)/F` that is ramification, and it forces `2 ∈ P`
   (`two_mem_of_conj_trivial`). The converse — a stable prime holding 2 is ramified — is false: the standing field's
   stable primes above 2 are inert (`StandingFive.exists_conjO_sub_notMem` with `exists_stablePrime_two`).
4. **`localBound F` may be `⊤`.** `chromaticNumber_planeOver_le_localBound` says nothing at a field whose `F(i)` has no stable
   prime; the docstring says so. That every real number field has one is classical (a prime of `F` not split in `F(i)`;
   recalled, not derived here) and is **not in the kernel**; the kernel holds one at the standing field, and at `ℚ` once
   leaf I3 lands.
5. **`isUnit_mk_pow` and `StablePrime.residue` at `m = 0`** are about the zero ring `𝓞 ⧸ ⊤`: true and empty of content.
6. **`exists_stablePrime_of_valuationSubring` is existence only.** The prime is unique — it is `{a | (a : K) ∈ A.nonunits}`,
   by `coe_mem_nonunits_localRing_iff` — but uniqueness is not stated.
7. **`two_mem_of_conj_trivial` carries no `[NumberField F]`** (the planner's `omit`); the other statements about `P.localRing`
   or `P.residue` do, because Mathlib's `valuationSubringAtPrime` asks a Dedekind domain.

### 4. Generalizations seen (the skeleton's forms kept; none added to the public surface)

- **Every valuation subring of a number field other than the field is the localization at a maximal ideal of its integers**
  — for any `K` with `[NumberField K]`, no conjugation, no real subfield. The file proves it in two private pieces:
  `exists_centre` (the centre is a maximal ideal `Q` with `a ∈ Q ↔ (a : K) ∈ A.nonunits`) and the last five lines of
  `exists_stablePrime_of_valuationSubring` (`𝓞_Q ≤ A`, then `ValuationSubring.eq_of_le_of_ne_top`). As a public statement it
  would read `∀ A : ValuationSubring K, A ≠ ⊤ → ∃ v : HeightOneSpectrum (𝓞 K), HeightOneSpectrum.valuationSubringAtPrime K v = A`.
  Not found in Mathlib at the pin by name
  (`ValuationSubring.primeSpectrumEquiv` classifies the overrings of one valuation subring, not the valuation subrings of
  a number field); not searched by shape. A second reader would be row 57's general form.
- **`integer_mem_valuationSubring`**: an integer of any field (`𝓞 K`, no finiteness) lies in every valuation subring.
- **`isUnit_mk_pow`** holds for any maximal ideal of any commutative ring (`Ideal.IsMaximal.exists_inv_pow` asks no more);
  Mathlib has no `Ideal.Quotient.isUnit_mk_pow` (the planner's probe).

## Drafts for the front page, and for the other files this job does not write

*Each names its slot. Keryx files; the landing decides when.*

- **`ARCHITECTURE.md` § 3, the row `Arith/UpperHalf`** — replace the words "(FS131-KN2; a skeleton: twelve leaves are `sorry`
  until its implementer lands)" by "(statements FS131-KN2's; the twelve leaves' proofs FS131-IU1's)". Nothing else in the
  row changes: no import was added, no public declaration added or removed.
- **`LEAN.md` § Searching — Lean**, four lines:
  - The coercion `𝓞 K → K` is `RingOfIntegers.val`, an `abbrev` for `algebraMap (𝓞 K) K`: `rw [map_mul]`, `rw [map_one]` do not
    fire on `↑(a * b)`, `↑1` (the head symbol is `val`); `simp` does, `RingOfIntegers.coe_injective` gives a goal stated with
    `algebraMap` where they fire, and a term `(map_mul (algebraMap _ _) a b).symm` is accepted for `↑a * ↑b = ↑(a * b)`.
    `RingOfIntegers.coe_eq_zero_iff` is injectivity at `0` (FS131-IU1).
  - A footer that prints stored types gives two texts for one statement when the two copies are elaborated at two paths:
    an instance binder's stored name carries the file's module name (`inst._@.<module>.<n>._hygCtx._hyg.6`). Elaborate the
    skeleton and the candidate at one path in turn (`data/fs131/iu1/statements.sh`); and a private declaration's stored name
    (`_private.<module>.0.<name>`) is `Name.isInternalDetail`, so a reader that skips internal names skips the private
    helpers — list them through `privateToUserName?` (FS131-IU1).
  - In a subfield of `ℂ` whose carrier is a set of the library (`fieldI F`, carrier `planeOver F`), `simp` rewrites
    `(⟨↑x, _⟩ - ⟨↑y, _⟩ : fieldI F)` for `x y : planeOver F` to the coercion of `x - y` and then cannot use a hypothesis
    about `↑x - ↑y`; state the fact in `ℂ` and close with `Subtype.ext` (`UpperHalf.sub_mul_conj_eq_one`; FS131-IU1).
  - `(conjOn hL).restrict A.toSubring A.toSubring hσ` has type `↥A.toSubring →+* ↥A.toSubring`; an `algebraMap R ↥A` applied
    under it is then asked for `Algebra R ↥A.toSubring`, which Mathlib's `valuationSubringAtPrime` does not declare. Name the
    map by a `let` ascribed `A →+* A` (`UpperHalf.residue_conj`; FS131-IU1).
- **`LEDGER.md`**: the planner's drafts stand (`plans/FS131-KN2-upper-half-plan.md` § Stage 5, rows 52, 57, 63, 73, 99, 105,
  119, 121, 123, 127). Of the declarations they name, this job's leaves now carry: row 57 (`exists_hom_levelTarget`,
  `exists_stablePrime_of_valuationSubring`), row 63's theorem (`colorable_two_planeOver_of_ramified`; its instance
  `χ(ℚ²) = 2` waits on leaves I1–I3), row 105 (`inv_natCast_mem_unitRingOver_iff_forall_stablePrime`), rows 99, 123, 127
  (`chromaticNumber_planeOver_le_localBound`, `chromaticNumber_eq_localBound_of_chain`). Rows 52, 73, 119, 121 wait on
  `Arith/QuadraticPrime` and the instances. Each is to be filed only when the module is through the gate.
- **The front page** (`CLAUDE.md` § The gate, § Trust ledger, § Frontier; the Proof Atlas): this job ran no gate and has no
  count to draft. What the landing's counts will move, from the plan's § D: the audit's clean count by the module's
  records (30 from this file); the assumptions step loses `inline:UpperHalf` at `chromaticNumber_eq_localBound`'s `hUpper`
  (`ours` 23 → 22, `inline` 16 → 15) and gains the takers of `chromaticNumber_eq_localBound_of_chain`.
