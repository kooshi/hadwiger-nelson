# FS131-IU1 — the residue upper half, `Arith/UpperHalf.lean`: the twelve leaves

*de Bruijn, the implementer; brief `data/fs131/briefs/FS131-IU1-leaves.md` (on `main`); branch `fs131-wnf`, worktree
`.claude/worktrees/fs131-wnf`, from `223241b0a`. Opened 2026-10-13. Working files: `data/fs131/iu1/`. The plan this job
implements is `plans/FS131-KN2-upper-half-plan.md` § Stage 4 A (U1–U12). The stages below are saved in order; a successor
resumes at the first stage not marked SAVED.*

## Theorems this phase proved

*(filled as leaves close; the final list is in the last stage)*

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
