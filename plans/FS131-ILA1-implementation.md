# FS131-ILA1 — the five-colour chain, lane A: one admissible pair of unit vectors at every real number field

Brief: `data/fs131/briefs/FS131-ILA1-admissible-pair.md` (on `main`). Tree: `.claude/worktrees/fs132-wi1`, branch `fs131-wla`
cut from `fs131-wm12` at `e736212f2`. Working files: `data/fs131/ila1/`.

## Theorems this phase proved

(none yet)

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
