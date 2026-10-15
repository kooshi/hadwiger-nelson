# FS131-ILA1 — the five-colour chain, lane A: one admissible pair of unit vectors at every real number field

Brief: `data/fs131/briefs/FS131-ILA1-admissible-pair.md` (on `main`). Tree: `.claude/worktrees/fs132-wi1`, branch `fs131-wla`
cut from `fs131-wm12` at `e736212f2`. Working files: `data/fs131/ila1/`.

## Theorems this phase proved

- `HadwigerNelson.Rigidity.exists_admissiblePair` — [kernel], `Proofs/HadwigerNelson/Rigidity/UnitCircle.lean`;
  axioms `[propext, Classical.choice, Quot.sound]` (build 3 of `fs131-wla`, `data/fs131/ila1/axioms-after.txt`).
- `HadwigerNelson.Rigidity.exists_unitPair` — [kernel], `Proofs/HadwigerNelson/Rigidity/AdmissiblePrime.lean`;
  axioms `[propext, Classical.choice, Quot.sound]`.
- `HadwigerNelson.Rigidity.exists_residueHom_unramified` — [kernel], `Proofs/HadwigerNelson/Rigidity/AdmissiblePrime.lean`;
  axioms `[propext, Classical.choice, Quot.sound]`.

## Stage 1 — SAVED: readback, the statement as the kernel holds it, the route restated, names checked, the dump before any edit

**1.1 Readback** (`tools/fs131_ila1_readback.py`, a copy of `tools/fs131_im11_readback.py` with the brief's path changed;
`data/fs131/ila1/readback.out`): the brief's 5 quotations — W2 (`data/fs131/REQUEST-2026-10-13.md`), the dated line
of `data/fs131/claims-NF2.md`, inventory items 761, 880, 881 (`plans/FS131-close-inventory.md`) — each **IDENTICAL**, as
one whole line of its source on `main`. Control (`--plant`, one character changed in each quotation in memory;
`data/fs131/ila1/readback-plant.out`): 5 of 5 reported MISMATCH. No finding about the brief.

**1.2 The statement and the definition, as the kernel holds them** (`data/fs131/ila1/probes/Kernel.lean`, `.out`, against
the compiled library of `e736212f2`):

```
HadwigerNelson.Rigidity.exists_admissiblePair : ∀ {F : Subfield ℝ} [NumberField ↥F], Nonempty (AdmissiblePair F)
structure AdmissiblePair (F : Subfield ℝ) : Type
  u : ↥(unitCircle F)
  w : ↥(unitCircle F)
  injective : Function.Injective ⇑(zpowHom self.u self.w)
  generates : ∀ (Λ : AddSubgroup (Fin 2 → ℤ)), Λ.FiniteIndex →
      Subfield.closure ((fun n => ↑↑((zpowHom self.u self.w) (Multiplicative.ofAdd n))) '' ↑Λ) = fieldI F
AdmissiblePair.ofPow : (u w : ↥(unitCircle F)) → Function.Injective ⇑(zpowHom u w) →
  (∀ (k : ℕ), 0 < k → Subfield.closure {↑↑w ^ k} = fieldI F) → AdmissiblePair F      -- [propext, Classical.choice, Quot.sound]
zpowHom u w n = u ^ (toAdd n 0) * w ^ (toAdd n 1);   unitCircle F = {z : Circle | (z : ℂ) ∈ fieldI F}
```

`exists_admissiblePair`'s axioms before the job: `[propext, sorryAx, Classical.choice, Quot.sound]`.
*Restated:* over every real number field `F`, there are unit vectors `u, w` with coordinates in `F` (complex numbers of
modulus one in `L = F(i)`) such that `(a, b) ↦ u^a w^b` is injective on `ℤ²` and, for every finite-index subgroup
`Λ ⊆ ℤ²`, the values `u^a w^b`, `(a, b) ∈ Λ`, generate `F(i)` as a subfield of `ℂ`. Through `ofPow`, it is enough that
`u, w` are multiplicatively independent and that `w^k` generates `F(i)` for every `k ≥ 1`.

**1.3 The plan's seven leaves against the statement, and the route I take** (the plan: item 880, and
`fs131-wq1:plans/FS131-IJ3-implementation.md` § 2.5). Two of its leaves go by a shorter route, one is not needed; I say
which, as the brief asks.

| plan's leaf | here |
|---|---|
| A1 Schur: infinitely many primes divide values of an integral polynomial | **kept**: for `f ∈ ℤ[X]` nonconstant and `M ≠ 0` there are a prime `q ∤ M` and `t ∈ ℤ` with `q ∣ f(t)` (`Polynomial.sub_dvd_eval_sub`, `Nat.exists_prime_and_dvd`, finitely many roots of `(f − c)(f + c)`) |
| A2 a degree-one, unramified, odd prime | **kept, by Mathlib's Kummer–Dedekind iso** in place of the plan's residue map through `discr_mul_isIntegral_mem_adjoin`: `θ ∈ 𝓞 L` integral and primitive; `q ∤ exponent θ` gives `RingOfIntegers.ZModXQuotSpanEquivQuotSpan : (ZMod q)[X] ⧸ (f̄) ≃+* 𝓞 L ⧸ (q)`, and evaluation at `t̄` (`q ∣ f(t)`) a surjection `𝓞 L → ZMod q`; its kernel `𝔓` has `q` elements in the quotient (`QuadraticPrime.isMaximal_ker_and_card`). `exponent θ ≠ 0` from `conductor_mul_differentIdeal` (the conductor times the different is `(f′(θ)) ≠ 0`) and `Ideal.absNorm_mem`. Unramified: `q ∤ discr L` gives `Algebra.IsUnramifiedAt ℤ 𝔓` (`NumberField.not_dvd_discr_iff_forall_mem`), so `Ideal.ramificationIdx_eq_one`, `Ideal.ramificationIdx'_eq_ramificationIdx`, `Ideal.ramificationIdx'_ne_one_iff`: `q ∉ 𝔓²` |
| A3 a principal power `(z) = 𝔓ʰ` (class group finite) | **not needed**: `z ∈ 𝔓²` with `z − 1 ∈ Q`, where `q𝓞 = 𝔓·Q` (two coprime ideals, `1 = a + b`) |
| A4 `𝔓̄ ≠ 𝔓` | **kept**: the residue maps of `𝔓` and of `𝔓̄ = conj⁻¹ 𝔓` would agree (`ZMod.ringHom_eq_of_ker_eq`), so `ī ≡ i`, `2i ∈ 𝔓`, `4 = 0` in `ℤ/q`; `q` odd |
| A5 the core, `ℚ(wᵏ) = L`, through `𝓞_M` and `Ideal.sum_ramification_inertia` | **another route, by norms, with no ring of integers of a subfield**: for `α ∈ L`, `M = ℚ⟮α⟯`, `d = [L : M]` and `x ∈ M`, `N_{L/ℚ}(x) = N_{M/ℚ}(x)^d` (`Algebra.norm_norm`, `Algebra.norm_algebraMap`), so `d ∣ v_q(N_{L/ℚ}(x))` (`padicValRat.pow`). At `α = wᵏ`, `w = z/z̄`: `wᵐ − q = (zᵐ − q z̄ᵐ)/z̄ᵐ` and `zᵐ − q z̄ᵐ` lies in `𝔓`, not in `𝔓²`, and in no other prime above `q`, so `v_q(N(zᵐ − q z̄ᵐ)) = 1` (`Ideal.absNorm_span_singleton`, `Ideal.exists_isMaximal_dvd_of_dvd_absNorm`); with `B = v_q(N(z̄))`, `d ∣ 1 − kB` (`m = k`, `x = α − q`) and `d ∣ 1 − 2kB` (`m = 2k`, `x = α² − q`), so `d ∣ 1` |
| A6 independence by valuations at a second prime | **by membership only**: `u = z′/z̄′` at a degree-one prime `𝔓′` over another odd `q′`, with `z′ ∈ 𝔓′`, `z′ ∉ 𝔓̄′, 𝔓, 𝔓̄`; `u^a w^b = 1` with `b > 0` clears to an equation in `𝓞 L` whose one side is in `𝔓` and whose other is not; with `b = 0`, `a > 0`, the same at `𝔓′` |
| A7 assembly through `AdmissiblePair.ofPow` | **kept** |

The archimedean remark of the plan stands (every conjugate of a unit vector of a CM field lies on the circle), and the route
above is non-archimedean throughout.

**Where the leaves live.** A new module `Rigidity/AdmissiblePrime` (imports `SpectralChain` and the Mathlib modules
the route reads), imported by `Rigidity/UnitCircle`, with two public theorems and private helpers: a degree-one,
unramified prime above a rational prime outside any given finite set, at every number field, and the pair of complex
numbers `UnitCircle` reads. `UnitCircle` gains one import line and the proof. Whether the new import moves a stored
statement of `UnitCircle` is what the dump of 1.5 decides.

**1.4 Names checked at the pin** (`data/fs131/ila1/probes/Names1.lean`, `Names2.lean`, under `import Mathlib`; `.out`
beside them): `Algebra.norm_norm`, `Algebra.norm_algebraMap`, `IntermediateField.algebraMap_apply`, `padicValRat.pow`,
`.div`, `.mul`, `.of_int`, `padicValInt.of_nat`, `padicValNat.mul`, `padicValNat_self`, `padicValNat.eq_zero_of_not_dvd`,
`Algebra.coe_norm_int`, `Ideal.absNorm_span_singleton`, `Ideal.IsPrime.mul_mem_pow` (`a * b ∈ I ^ n → a ∈ I ∨ b ∈ I ^ n`),
`Ideal.dvd_iff_le`, `Ideal.absNorm_mem`, `Ideal.absNorm_eq_zero_iff`, `Ideal.exists_isMaximal_dvd_of_dvd_absNorm`,
`Int.ideal_span_absNorm_eq_self`, `Field.exists_primitive_element`, `IsAlgebraic.exists_integral_multiple` (namespaced),
`RingOfIntegers.exponent`, `RingOfIntegers.ZModXQuotSpanEquivQuotSpan`, `…_mk_apply`, `conductor_mul_differentIdeal`,
`NumberField.not_dvd_discr_iff_forall_mem`, `NumberField.discr_ne_zero`, `Ideal.ramificationIdx_eq_one`,
`Ideal.ramificationIdx'_eq_ramificationIdx`, `Ideal.ramificationIdx'_ne_one_iff`, `Ideal.liesOver_span_iff`,
`ZMod.ringHom_eq_of_ker_eq`, `Polynomial.Separable.aeval_derivative_ne_zero`, `minpoly.isIntegrallyClosed_eq_field_fractions'`,
`Polynomial.sub_dvd_eval_sub`, `Nat.exists_prime_and_dvd`, `Nat.exists_infinite_primes`, `Set.Infinite.exists_notMem_finset`,
`Set.infinite_range_of_injective`, `Polynomial.mem_roots`, `Ideal.sup_pow_eq_top`, `Ideal.IsPrime.mul_le`,
`Ideal.IsMaximal.eq_of_le`, `Subfield.toIntermediateField`, `IntermediateField.adjoin_simple_le_iff`,
`IntermediateField.finrank_top'`, `IntermediateField.eq_of_le_of_finrank_eq`, `Module.finrank_mul_finrank`,
`injective_iff_map_eq_one`, `HadwigerNelson.QuadraticPrime.isMaximal_ker_and_card`, `SpectralChain.conjO`. Not names at the
pin: `Ideal.absNorm_mul` (the norm is a `MonoidWithZeroHom`: `map_mul`), `Ideal.mem_sup`, `Ideal.IsCoprime`;
`exists_integral_multiple` is `IsAlgebraic.exists_integral_multiple`.

**1.5 The dump before any edit** (`data/fs131/ila1/lean/StatementDump.lean`, FS131-IM11's dumper aimed at the three modules
the edit can reach — `Rigidity/UnitCircle` and the two downstream of it, `Rigidity/Pieces` and `Rigidity/EntropySplitMax`,
the only ones by the import graph; `data/fs131/ila1/statements-before.txt`, 8.5 MB): 178 constants, 58 + 110 + 10, from the
compiled library as given, before any build.

## Stage 2 — SAVED: A1 and A2 proved — a degree-one, unramified prime above a rational prime outside any finite set

Written against `data/fs131/ila1/work/AdmissiblePrime.lean` (elaborated by `data/fs131/ila1/lean1.sh`: `lake env lean` with
the lakefile's two options under the slot, 2–3 s a round; rounds `data/fs131/ila1/logs/AP-0.log` … `AP-12.log`, the last
exit 0 with no warning). The public theorem of the stage:

```
theorem exists_residueHom_unramified (K : Type*) [Field K] [NumberField K] (M : ℕ) (hM : M ≠ 0) :
    ∃ (p : ℕ) (φ : 𝓞 K →+* ZMod p), p.Prime ∧ ¬ p ∣ M ∧ (p : 𝓞 K) ∉ RingHom.ker φ ^ 2
```

its axioms `[propext, Classical.choice, Quot.sound]` (`data/fs131/ila1/probes/APax.lean`, log `APax.log`). Read aloud: at
every number field, for every nonzero `M`, a prime `p ∤ M` and a ring homomorphism from the ring of integers onto `ℤ/p`
whose kernel `𝔓` does not hold `p` in its square — a prime of degree one over `p`, unramified. Five private helpers:

| helper | route |
|---|---|
| `schur_prime` (A1) | as planned: at `c = f(0) = 0` any prime `q > M`, `t = q`; otherwise `t` with `f(2cMt) ≠ ±c` (the roots of `(f − c)(f + c)` are finitely many, `t ↦ 2cMt` injective), `f(2cMt) = c(1 + 2Mtk)` by `sub_dvd_eval_sub`, and a prime factor of `1 + 2Mtk` |
| `exists_integral_primitive` | `Field.exists_primitive_element`, `IsFractionRing.isAlgebraic_iff ℤ ℚ`, `IsAlgebraic.exists_integral_multiple` |
| `exists_dvd_of_dvd_exponent` | `conductor_mul_differentIdeal` (`(conductor) · 𝔇 = (f′(θ))`, `f′(θ) ≠ 0` by separability), so the conductor is not `⊥`; its absolute norm `E ≠ 0` is in it (`Ideal.absNorm_mem`) and in its contraction to `ℤ`, generated by `exponent θ` (`Int.ideal_span_absNorm_eq_self`) |
| `nonempty_residueHom` (A2) | `ZModXQuotSpanEquivQuotSpan`, then evaluation at `t̄` lifted through `(f̄)` (`eval_intCast_map`, `ZMod.intCast_zmod_eq_zero_iff_dvd`) |
| `natCast_notMem_sq` (A2, unramified) | `not_dvd_discr_iff_forall_mem` → `Algebra.IsUnramifiedAt ℤ 𝔓` → `ramificationIdx_eq_one` → `ramificationIdx'_eq_ramificationIdx` (at `LiesOver` by `liesOver_span_iff`) → `ramificationIdx'_ne_one_iff` |

**Re-priced from the first two leaves** (the brief's item 2): A1 and A2 are about 150 lines with their docstrings, against
the plan's 280–380 (A1 ~80, A2 200–300). The lane is far below the brief's 1,500-line line; no message is owed for the
price. The rest (A4, the norm core, the CRT element, independence, assembly) I price at 250–350 lines from the route of
§ 1.3, so the lane at 400–500 lines against the plan's 800–1,250.

## Stage 3 — SAVED: the rest of the leaves proved, the module and the proof installed

Rounds `data/fs131/ila1/logs/AP-13.log` … `AP-22.log` on the working copy (the last exit 0, no warning), then
`data/fs131/ila1/work/UCtest.lean` — the module's text after `import Proofs.HadwigerNelson.Rigidity.UnitCircle` (built,
unchanged) and `exists_admissiblePair`'s proof as an `example` — log `UC-1.log`: exit 0, no warning;
`exists_unitPair` and `exists_residueHom_unramified` print `[propext, Classical.choice, Quot.sound]` there.

| leaf | helper(s) | route, as § 1.3 planned it unless said |
|---|---|---|
| A4 `𝔓̄ ≠ 𝔓` | `comap_conjO_ker_ne` (with `toC`, `toC_conjO`, `conjO_conjO'`, `conjO_surjective`, `iO`, `toC_iO`, `comap_conjO_isMaximal`, `natCast_mem_comap_conjO`) | `ZMod.ringHom_eq_of_ker_eq` on `φ ∘ conj` and `φ`; `4 = 4(φ(i)² + 1) + 2φ(i)(−φ(i) − φ(i))` by `linear_combination`; `p ∣ 2²` |
| the CRT element `z` | `exists_mem_sq_forall_notMem` | `p𝓞 = 𝔓R`, `R ⊄ 𝔓`, `R ⊔ 𝔓² = ⊤` (`Ideal.sup_pow_eq_top`), `1 = b + a`; a maximal `Q ∋ p` other than `𝔓` holds `R` (`Ideal.IsPrime.mul_le`) |
| A5 the core | `padicValNat_absNorm_span_eq_one`, `dvd_padicValRat_norm`, `adjoin_pow_eq_top` | `span{x} = 𝔓J`, `p ∤ N(J)` (a maximal `Q ∣ J` above `p` from `Ideal.exists_isMaximal_dvd_of_dvd_absNorm` would be `𝔓` and put `x` in `𝔓²`); `N_{L/ℚ}(y) = N_{ℚ⟮α⟯/ℚ}(y)^d`; `zᵐ − p z̄ᵐ = (wᵐ − p) z̄ᵐ` in `L`, `v_p` of its norm `1` (`Algebra.coe_norm_int`, `Ideal.absNorm_span_singleton`), so `v_p(N(wᵐ − p)) = 1 − m·v_p(N(z̄))`; at `gen − p` and `gen² − p`, `d ∣ 2(1 − kB) − (1 − 2kB) = 1`; `IntermediateField.finrank_eq_one_iff_eq_top` |
| `ℚ⟮α⟯ = ⊤` read in `ℂ` | `closure_eq_of_adjoin_eq_top` | `Subfield.toIntermediateField` of the comap of the closure; `adjoin_simple_le_iff` |
| A6 independence | `div_pow_mul_div_pow_ne_one`, `eq_zero_of_zpow_mul_zpow_eq_one`, `exists_mem_notMem_three` (`z′` by CRT against the product of the three other maximal ideals) | by the sign of `b`, then of `a`; `(y₁/y₂)ⁿ(a/ā)ᵇ = 1` clears to `y₁ⁿaᵇ = y₂ⁿāᵇ` in `𝓞`, the left side in the prime, the right not |
| A7 assembly | `exists_unitPair` (public), `norm_div_conj`; `exists_admissiblePair` in `UnitCircle` | two calls of `exists_residueHom_unramified` (`M = 2`, then `M = 2p`); `AdmissiblePair.ofPow`, injectivity by `injective_iff_map_eq_one` and the coercions of `zpow` through the subgroup and the circle |

**Installed** (the working copy over the new file; `UnitCircle`: one import line and the proof, nothing else — its
docstring, which still describes the plan's route, is left as it was and a reworded one is drafted for the landing;
`Proofs.lean`: one import line; `ARCHITECTURE.md`: the new row and `UnitCircle`'s state and imports cells;
`tools/check_architecture.py` exit 0, RESULT: PASS, `data/fs131/ila1/arch.out`). The module is 572 lines with its
docstrings: 2 public theorems (`exists_residueHom_unramified`, `exists_unitPair`), 2 private definitions, 23 private
theorems; `UnitCircle` gains 15 lines. **The lane is about 590 lines** against the plan's 800–1,250 and stage 2's
re-price of 400–500 (the independence and the conjugation leaves took more than I priced).

Tools written for the gate, not yet run: `data/fs131/ila1/lean/Axioms.lean` with `tools/fs131_ila1_axioms.py` (every
record of the two modules this job writes CLEAN; a planted record, a leaf of `Rigidity/EntropySplitMax` that rests on
`sorry` in this tree, must show), and `tools/fs131_ila1_statements.py` (the dumps before and after; eight planted
faults). Build 1 (`./scripts/build.sh` under the slot, `MEMMAX=10G BATCH=8`; `data/fs131/ila1/build1.log`) started.

## Stage 4 — SAVED: the gate items of the brief, from the built tree

**Build 1** (`data/fs131/ila1/build1.log`; gate log `build/gate/build/20261014T173423Z-4070515.log`): OK — 256 of 256
batches, 5 modules rebuilt (`AdmissiblePrime`, `UnitCircle`, `Pieces`, `EntropySplitMax`, `Proofs`), 7 m 10 s, no warning
from this job's files. Its dump with the new module (`data/fs131/ila1/statements-build1.txt`) showed **two generated
equation lemmas** this job's proofs had asked for: `zpowHom.eq_1` in `UnitCircle` (from `simpa only [zpowHom, …]`) and
`Ideal.under.eq_1` in `AdmissiblePrime` (from `rw [Ideal.under, …]`, Mathlib's definition). Both removed — `change` to
the unfolded form in `UnitCircle` (tested first in `data/fs131/ila1/work/UCtest2.lean`, log `UC-2.log`), `Ideal.mem_under`
in the module's two readings of `under` (log `AP-23.log`) — so `UnitCircle`'s compiled data is again its 58 constants.
Its axiom print (`axioms-build1.txt`) was already all clean; the one-line message went to the coordinator from it.

**Build 2** (`data/fs131/ila1/build2.log`; gate log `build/gate/build/20261014T174330Z-4102978.log`): **OK — 256 of 256
batches, 5 modules rebuilt, 8 m 11 s, exit 0; no warning from `AdmissiblePrime` or `UnitCircle`** (the build's 95
warnings are all `declaration uses 'sorry'`, in 17 other modules, as before the job).

**Statements** (`tools/fs131_ila1_statements.py` on `statements-before.txt` (§ 1.5) and `statements-after.txt`, base
`e736212f2`; `data/fs131/ila1/statements-verdict.out`): **PASS** — 108 named constants of `UnitCircle`, `Pieces` and
`EntropySplitMax` compared (kind, stored type, module), 32 data definitions' stored values, no `example` in the three
files; every stored type identical, so the new import moved no instance in any stored statement. New: exactly the two
allowed public theorems (`data/fs131/ila1/allow-new.txt`), 25 private constants and 6 internal ones (generated
`_proof_n`), all in `AdmissiblePrime`. **Control** (`statements-control.out`): 8 of 8 planted faults reported (a stored
statement of the leaf, a definition's value, a constant gone, a downstream statement, a move, an unlisted public
constant, an axiom, a theorem become a definition). The dumper's module list gained `AdmissiblePrime` after the first
dump and nothing else (the module did not exist before the edit; recorded in the dumper's docstring).

**Axioms** (`data/fs131/ila1/lean/Axioms.lean` → `axioms-after.txt`; `tools/fs131_ila1_axioms.py` →
`axioms-verdict.out`): **PASS — 60 records, all CLEAN**: `AdmissiblePrime` 27 (2 public theorems, 2 private
definitions, 23 private theorems), `UnitCircle` 33, among them `exists_admissiblePair`,
`exists_unitPair` and `exists_residueHom_unramified`, each `[propext, Classical.choice, Quot.sound]`. The planted record,
`EntropySplitMax`'s `rotInv_sub_maxMultiple`, a skeleton leaf in this tree, **reported** as resting on `sorryAx`.
**Control** (`axioms-control.out`): 4 of 4 planted faults reported.

**A docstring corrected after build 2**: the module's **Models** paragraph called `NumberField ↥(⊥ : Subfield ℝ)` an
instance; it is the theorem `UpperHalf.numberField_bot`. Reworded (docstring only), with two more docstring corrections of
the module made before build 3 read it: "no valuation enter" → "no valuation of `L` enter (only the `p`-adic valuation
of rational norms)", and `exists_unitPair`'s attribution "(FS100-X02D's Lemma W construction …)" → "(FS100-X02D l. 146's
admissible `Γ`, by FS131-ILA1's route in place of Lemma W's completely split prime)".

**Build 3** (`data/fs131/ila1/build3.log`; gate log `build/gate/build/20261014T180733Z-19285.log`): **OK — 256 of 256
batches, 5 modules rebuilt, 8 m 12 s, exit 0; no warning from this job's files** (95 `sorry` warnings, 17 other modules).
**The receipts above are re-run on build 3, and are the ones that stand**: dump 33 + 58 + 110 + 10 constants;
statements PASS (108 constants, 32 values; 2 allowed public, 25 private, 6 internal, all in `AdmissiblePrime`), control
8/8; axioms 60 of 60 CLEAN, planted record reported, control 4/4; the three public theorems on the standard three. The
lint and the doubled-name scan below were run on build 2; build 3 differs from it only in the module's docstrings.

**Lint** (`lake lint --no-build -- --no-build --trace` under the slot; `data/fs131/ila1/lint.out`): exit 1 on **one**
finding, `archTop`'s unused `[NumberField ↥F]` (`ContinuityGroup` l. 42), the pre-existing one IM11 recorded (inventory
item 863); **no finding in `AdmissiblePrime` or `UnitCircle`**; 13 of 14 linters `(2/2) Passed!`.

**Doubled names** (`./scripts/dupnames.sh` under the slot; `data/fs131/ila1/dupnames.out`): OK — no name declared by two
modules, 24 generated on demand, none in this job's modules. Its "changed since the previous complete run" lists two
generated names gone since the 07:31 run in this tree (`Measure.addHaar.congr_simp`, from `Arith/StationaryRatio`;
`measureUnivNNReal.eq_1`, from `Outside/OAI158Palette`), modules this job did not touch.

**Architecture**: `tools/check_architecture.py` PASS (§ Stage 3; `data/fs131/ila1/arch.out`).

**Not run here, and why**: `scripts/axioms.sh`, `scripts/vacuity.sh`, `scripts/assumptions.sh` and their self-tests read
the whole library, which on this branch still holds other lanes' `sorry` (95 warnings in 17 modules), so their verdict
belongs to the landing. For the landing's vacuity and assumptions reading: the two new public theorems take only
`[Field K] [NumberField K] (M : ℕ) (hM : M ≠ 0)` and `[NumberField F]` — no structure, no colouring, no named
hypothesis — and are inhabited at `ℚ` (`NumberField ℚ` an instance; `NumberField ↥(⊥ : Subfield ℝ)` the theorem
`UpperHalf.numberField_bot`); `hM` is a condition on a parameter.

**Read aloud, the three kernel theorems against their informal statements.**
- `exists_admissiblePair : ∀ {F : Subfield ℝ} [NumberField ↥F], Nonempty (AdmissiblePair F)` — over every real number
  field there are unit vectors `u, w` of `F²` with `ℤ² → ⟨u, w⟩` injective and every finite-index subgroup generating
  `F(i)`: X02D l. 146's admissible `Γ` exists, as § 1.2 restated it.
- `exists_unitPair (F) [NumberField F] : ∃ u w : ℂ, u ∈ fieldI F ∧ ‖u‖ = 1 ∧ w ∈ fieldI F ∧ ‖w‖ = 1 ∧
  (∀ a b : ℤ, u ^ a * w ^ b = 1 → a = 0 ∧ b = 0) ∧ ∀ k : ℕ, 0 < k → Subfield.closure {w ^ k} = fieldI F` — two complex
  numbers of modulus one in `F(i)`, multiplicatively independent, every positive power of `w` generating `F(i)`: X02D's
  "in particular" form (l. 146–147) with independence.
- `exists_residueHom_unramified (K) [Field K] [NumberField K] (M) (hM : M ≠ 0) : ∃ (p : ℕ) (φ : 𝓞 K →+* ZMod p),
  p.Prime ∧ ¬ p ∣ M ∧ (p : 𝓞 K) ∉ RingHom.ker φ ^ 2` — infinitely many rational primes have a prime of `K` of degree one
  above them, unramified (a classical fact, a weak form of Chebotarev's density theorem; the kernel proof ours).

## Drafts for the landing

**D1. The audit's block** (`scripts/Axioms.lean`, CLEAN section; every public declaration of the two modules this job
writes whose axioms are the standard three at build 1 of `fs131-wla`):

```
-- FS131-ILA1: Rigidity/AdmissiblePrime (new), and lane A's leaf of Rigidity/UnitCircle
#print axioms HadwigerNelson.Rigidity.exists_residueHom_unramified
#print axioms HadwigerNelson.Rigidity.exists_unitPair
#print axioms HadwigerNelson.Rigidity.exists_admissiblePair
```

**D2. `UnitCircle`'s docstrings, which still describe the plan's route** (not mine to edit: the brief gave me the proof,
helpers and imports only). Slot: `Proofs/HadwigerNelson/Rigidity/UnitCircle.lean`.
- Module title (l. 7), the words "proved by FS131-IDG1 but `exists_admissiblePair`" → "proved by FS131-IDG1;
  `exists_admissiblePair` by FS131-ILA1".
- Module doc, l. 26, "`exists_admissiblePair` (X02D's Lemma W construction at one `u`)" → "`exists_admissiblePair`
  (from `Rigidity.exists_unitPair`: one degree-one unramified prime for `w`, a second for `u`)".
- **Models**, ll. 28–29, "(`exists_admissiblePair`, a leaf) — at `ℚ` by `u = (3 + 4i)/5`, `w = (5 + 12i)/13` (the
  leaf's plan)" → "(`exists_admissiblePair`) — at `ℚ`, for instance, by `u = (3 + 4i)/5`, `w = (5 + 12i)/13`".
- `exists_admissiblePair`'s docstring, the sentences from "Plan: a rational prime `p` splitting completely" to the end →
  "Proved from `exists_unitPair` (`Rigidity/AdmissiblePrime`): `w = z/z̄` at a degree-one unramified prime `𝔓` above an
  odd `p` (`z ∈ 𝔓²`, in no other prime above `p`), `ℚ(wᵏ) = F(i)` for every `k ≥ 1` by the `p`-adic valuations of the
  norms of `wᵏ − p` and `w²ᵏ − p`; `u = z′/z̄′` at a second such prime, independent by membership;
  `AdmissiblePair.ofPow`. No completely split prime and no principal power is needed."

**D3. Bibliography** (`BIBLIOGRAPHY.md`; Keryx files). One proposed row, and one reading line:
- New row: `| **[Schur1912]** | I. Schur, *Über die Existenz unendlich vieler Primzahlen in einigen speziellen
  arithmetischen Progressionen*, Sitzungsber. Berl. Math. Ges. 11 (1912) 40–50 — **cited from memory: title, venue and
  pages unchecked** | the classical fact that a nonconstant integral polynomial has prime divisors of its values outside
  any finite set; proved in the kernel here by the textbook argument (`Rigidity/AdmissiblePrime`, private `schur_prime`,
  FS131-ILA1); nothing rests on the paper, and the module's docstrings name it as "Schur's argument" with no key | not
  held | **recalled, not read** |`. If the landing prefers no row for a fact proved with its argument, the docstrings carry no
  key and nothing breaks.
- `FS100-X02D` is a derivation entry, not a bibliography row: read by this job at `plans/FS100-X02D-derivation.md`
  ll. 144–166 (PE-1′'s admissible `Γ`, l. 146, and Lemma W, ll. 156–163), in full.

**D4. `LEAN.md` lines** (§ Searching — Lean, appended at its end; each measured in this job's rounds, `data/fs131/ila1/logs/`):
- A prime of degree one above `p`, unramified, at every number field needs no Chebotarev and no residue map built by
  hand: an integral primitive `θ` (`Field.exists_primitive_element`, then `(IsFractionRing.isAlgebraic_iff ℤ ℚ K).mpr …
  |>.exists_integral_multiple`), Mathlib's Kummer–Dedekind isomorphism `RingOfIntegers.ZModXQuotSpanEquivQuotSpan`
  (at `¬ p ∣ RingOfIntegers.exponent θ`) followed by evaluation at a root of `minpoly ℤ θ` modulo `p`
  (`Ideal.Quotient.lift`, `eval_intCast_map`, `Int.cast_id`); the exponent is nonzero because the conductor times the
  different is `(f′(θ))` (`conductor_mul_differentIdeal`) and `(absNorm C : 𝓞) ∈ C` (`Ideal.absNorm_mem`,
  `Int.ideal_span_absNorm_eq_self`); `p ∉ 𝔓²` from `p ∤ discr K` through `NumberField.not_dvd_discr_iff_forall_mem`,
  `Ideal.ramificationIdx_eq_one`, `Ideal.ramificationIdx'_eq_ramificationIdx` (its `LiesOver` by
  `Ideal.liesOver_span_iff`) and `Ideal.ramificationIdx'_ne_one_iff` (`Rigidity.exists_residueHom_unramified`, FS131-ILA1).
- `ℚ⟮α⟯ = L` with no ring of integers of the subfield: for `y : ℚ⟮α⟯`, `N_{L/ℚ}(y) = N_{ℚ⟮α⟯/ℚ}(y)^d` by
  `rw [← IntermediateField.algebraMap_apply, ← Algebra.norm_norm (S := ℚ⟮α⟯), Algebra.norm_algebraMap, map_pow]`, so `d`
  divides `padicValRat p (N y)` (`padicValRat.pow`); `IntermediateField.finrank_eq_one_iff_eq_top` closes. The `p`-adic
  valuation of the norm of an integral `x` is `padicValNat p (absNorm (span {x}))` through `Algebra.coe_norm_int`,
  `padicValRat.of_int`, `padicValInt` (a definition: unfold it by `rw`) and `Ideal.absNorm_span_singleton` (FS131-ILA1).
- `Algebra.IsAlgebraic ℤ K` is not an instance at the pin for a number field `K`; `IsFractionRing.isAlgebraic_iff ℤ ℚ K`
  gives `IsAlgebraic ℤ x`. `Algebra.norm R` is a `MonoidHom`: `map_zero` does not rewrite `Algebra.norm ℤ 0` ("failed to
  synthesize `ZeroHomClass`"); `Algebra.norm_zero` does. `padicValNat.zero` is deprecated for `padicValNat_zero_right`.
  `rw [pow_succ]` on `z ^ (n + 1) ∈ P ^ 2` rewrites `P ^ 2` first: name the base, `pow_succ z` (FS131-ILA1).

**D5. The front page** (`CLAUDE.md`; Keryx files). No ledger row was filed for lane A when Derived, so none is regraded.
- § Frontier, the paragraph on the chain's lanes, or wherever lane A is named open: "lane A, `exists_admissiblePair`"
  → "lane A, `exists_admissiblePair` — [kernel] on the standard three since FS131-ILA1 (`Rigidity/AdmissiblePrime`, on
  `fs131-wla`): an admissible pair exists over every real number field, by two degree-one unramified primes and the
  `p`-adic valuations of norms; no Chebotarev".
- § The gate and § Trust ledger: no counts from this job — the whole-library steps are the landing's (Stage 4). The axiom
  audit gains three CLEAN records with D1, and no purchase or import.
- Proof Atlas: lane A's leaf moves from open to [kernel].
