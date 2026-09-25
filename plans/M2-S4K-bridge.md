# M2-S4K — the bridge in the kernel, conditional on real algebraic descent; `ℝ` and `R_alg` real closed (crunch job J17K)

*Kernel job J17K of the 2026-09-25 crunch, milestone M2 (FS-39 phases B0–B1 and C). Brief:
`data/crunch-2026-09-25/briefs/J17K-M2-bridge-kernel.md` (with `STANDING-RULES.md`). Opus 5.5, de Bruijn. Started 22:30 UTC
from the green gate at `b1ec47a9`.*

## Theorems this phase proved

*(filled at each stage; grades per `CLAUDE.md` § Notation)*

## Stage 1 — SAVED

### 1.1 The quotation check (standing rule 5)

| quotation in the brief | source | verdict |
|---|---|---|
| C1 "For every finite graph `H` … on every edge." | `plans/M2-kernel-lane.md` line 436 | verbatim |
| C2 "`χ(ℝ²) = sup { χ(F²) : F ⊂ ℝ a number field }`, …" | same, line 438 | verbatim |
| C4 "`χ(ℝ²) ≠ 6` if and only if every real number field …" | same, line 441, citing `plans/STUB-plane-bridge.md` §5 | verbatim at the kernel lane; the stub's own words are "`χ(ℝ²) ≠ 6` ⟺ every real number field `F` with `χ(F²) = 6` has a finite real extension `F′` with `χ(F′²) = 7`" — same claim, different words |
| B0, B1 ("**B0 — (RC)**, … needed by every route.", "**B1 — the bridge as a conditional theorem**: …") | `plans/M2-S1D-bridge.md` §3.2 items 1–2 | verbatim; the "`VACUITY DECLARED`" clause is marked corrected in the source itself |
| (∃T) "a system of polynomial equations over a real closed `R` …" | same, §2.1 | verbatim |
| Lemma NP, its proof skeleton, "`α⁴ = β⁴ + (γδ)²`", "`deg γ + deg δ … ≤ 2D`" | same, §2.3 | verbatim; the ellipsis stands for "`= (deg(p − q) + deg(p + q))/2`" |
| "Any real transcendental `x > 1` in place of `π` works — e.g. `x = 2 + L`" | same, §2.3 | verbatim |
| "every term is at most 7, `S` is finite, and **the supremum is a maximum**" | same, §2.2 step 1 | verbatim |
| `CLAUDE.md` § The gate: "`DECLARED` (deliberate emptiness, named with its reason in the docstring as `VACUITY DECLARED:` and printed every run)" | `CLAUDE.md` | verbatim |
| J14: "the gate reads `VACUITY DECLARED:` as a checked claim that a hypothesis's domain is **provably empty** … `G4` is unproved, not empty" | `plans/M2-S1K-chain.md` lines 144–146 | verbatim |
| Mathlib TODO "TODO (Artie Khovanov) : real numbers, real algebraic numbers, hyperreals form a real closed field" | `FieldTheory/IsRealClosed/Basic.lean:26` | verbatim, line correct |
| `IsRealClosed.of_linearOrderedField …` | same file, line 60 | verbatim (the file is a `module` file) |
| `protected theorem Polynomial.abc …` | `NumberTheory/FLT/MasonStothers.lean:55` | verbatim, line correct |
| `nonempty_hom_of_forall_finite_subgraph_hom` (`Finsubgraph.lean:154`), `Finset.rado_selection` (`Compactness.lean:64`), `ENat.exists_eq_iSup_of_lt_top` / `sSup_mem_of_nonempty_of_lt_top` (`Data/ENat/Lattice.lean:108–118`), `algebraicClosure` (`AlgebraicClosure.lean:40`), `exists_associated_pow_of_mul_eq_pow'` (`PrincipalIdealDomain.lean:482`) | Mathlib at the pin | all present at the stated lines |
| `Instances/Interval.lean:35`, `Reduction.lean:51`, `SquareClass.lean:63`, `Chain.lean:182`, `Kempe.lean` ~131, `SevenConditional.lean` | the repository | present; `SquareClass.lean`'s `planeOver` is at line 63 |
| the brief's `Mathlib.Data.Real.Irrational` (implicit, `irrational_sqrt_two`) | — | the module is `Mathlib.NumberTheory.Real.Irrational` at this pin |

No quotation was found paraphrased in a way that changes a claim.

### 1.2 C0 — the order, stated honestly

The brief asks for C0 before the leaves. **Slip, mine:** I priced the skeleton's first two leaves by writing them, and both closed
at once — the whole of B1, C4 and both B0 instances elaborated under `lake env lean` (17:38–17:42) before C0 was written. So
probabilities for those products would be post hoc and are not given. C0 for the products not yet attempted, written before any
attempt:

| product | p |
|---|---|
| the real build accepts `Bridge.lean` and `RealClosed.lean` unchanged or with lint-only edits | 0.85 |
| Lemma NP via `Polynomial.abc` in this job's budget | 0.35 |
| C3 one-variable form | 0.25 |
| C3⁺ | 0.05 |

### 1.3 The price, from the first two leaves

| leaf | `plans/M2-S1D-bridge.md` §3.2's price | measured |
|---|---|---|
| C1's encoding (`exists_numberField_drawing_of_descent`: a drawing as a `Finset` of rational `MvPolynomial`s in variables `ι ⊕ ι`, renamed to `Fin n`; the generated field a number field by `IntermediateField.finiteDimensional_adjoin`) | inside B1's "~1 day" | ~6 minutes of elaboration cycles, first try up to three one-line fixes |
| `IsRealClosed ℝ` | inside B0's "~1 day" | ~3 minutes: Mathlib's `Analysis/Polynomial/Order.lean` (2026) gives the eventual sign below and above all roots; a root-free odd-degree polynomial would have opposite signs at `0` |

**§3.2's day-prices for B0 and B1 were high by about two orders of magnitude**, because Mathlib at this pin already holds
the two non-obvious inputs (the eventual-sign lemmas, and `algebraicClosure_eq_bot`'s tower integrality). Iteration peak:
3.4 GB per `lake env lean` of `Bridge.lean` (2.4 s wall), so `--mem 10` is honest.
