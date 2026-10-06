#!/usr/bin/env python3
"""FS131-L10B: the ruled tidies of the brief's item 3, as exact text replacements, each of which must match once.

  data/fs131/l10b/tidy.py --check     every `old` text is found exactly once; nothing is written
  data/fs131/l10b/tidy.py             the same check, then the edits are written

(i)   ruling 542: `MajorityVote.ae_eq_measurable_of_majority` loses `(hG : Measurable G)` and `(hc : ∀ x, Measurable (c x))`,
      and `[Finite K]` becomes `[Countable K]`; the proof loses the three lines that only read the dropped hypotheses and
      the one that derived countability; its one caller (the spec example) is adjusted; the docstrings say what is now held.
(ii)  ruling 555 (a) / the planner's § 15.3: `local instance` → `instance` for `NumberField standingField`.
(iii) docstrings corrected to what the kernel now holds: `involution_eq_pow` (538 (b)); `sp_if` (547 (a)); the two Bézout
      identities and `Floor128`'s module docstring (the planner's § 15.2); the four notes of § 16.2; the lines that say
      Weil's bound is "not held … never an `axiom`"; `ARCHITECTURE.md`'s five rows that say "skeleton".
(iv)  nothing else.
"""
import sys

A = 'Proofs/HadwigerNelson/Arith/'
EDITS = []


def edit(path, what, old, new):
    EDITS.append((path, what, old, new))


# ---------------------------------------------------------------- (i) the majority vote, ruling 542
MV = A + 'MajorityVote.lean'
edit(MV, '(i) the statement: two hypotheses dropped, [Finite K] -> [Countable K]',
     "    [Infinite I] [Finite K] [MeasurableSpace K] [MeasurableSingletonClass K] (G : Ω → K) (hG : Measurable G)\n"
     "    (c : I → Ω → K) (hc : ∀ x, Measurable (c x)) (E : I → Set Ω) (hE : ∀ x, MeasurableSet (E x)) {p : ℝ}\n",
     "    [Infinite I] [Countable K] [MeasurableSpace K] [MeasurableSingletonClass K] (G : Ω → K)\n"
     "    (c : I → Ω → K) (E : I → Set Ω) (hE : ∀ x, MeasurableSet (E x)) {p : ℝ}\n")
edit(MV, '(i) the proof: the three lines that only read the dropped hypotheses',
     "  classical\n"
     "  -- the measurability of `G` and of the `c x` is not read by this argument, and of `[Finite K]` only countability is\n"
     "  have _hG := hG\n"
     "  have _hc := hc\n"
     "  let x : ℕ ↪ I := Infinite.natEmbedding I\n",
     "  classical\n"
     "  let x : ℕ ↪ I := Infinite.natEmbedding I\n")
edit(MV, '(i) the proof: countability is now the hypothesis',
     "  obtain ⟨ω₀⟩ := nonempty_of_isProbabilityMeasure μ\n"
     "  haveI : Countable K := Finite.to_countable\n",
     "  obtain ⟨ω₀⟩ := nonempty_of_isProbabilityMeasure μ\n")
edit(MV, '(i) the caller: the spec example (its line, and the binder that only fed it)',
     "example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ] (G : Ω → Bool) (hG : Measurable G) :\n"
     "    ∃ g : Ω → Bool, Measurable[⨆ _x : ℕ, MeasurableSpace.comap G inferInstance] g ∧ G =ᵐ[μ] g :=\n"
     "  ae_eq_measurable_of_majority G hG (fun _ : ℕ => G) (fun _ => hG) (fun _ => ∅) (fun _ => MeasurableSet.empty)\n",
     "example {Ω : Type*} [MeasurableSpace Ω] {μ : Measure Ω} [IsProbabilityMeasure μ] (G : Ω → Bool) :\n"
     "    ∃ g : Ω → Bool, Measurable[⨆ _x : ℕ, MeasurableSpace.comap G inferInstance] g ∧ G =ᵐ[μ] g :=\n"
     "  ae_eq_measurable_of_majority G (fun _ : ℕ => G) (fun _ => ∅) (fun _ => MeasurableSet.empty)\n")
edit(MV, '(i) the theorem\'s docstring',
     "/-- **FS131-E8-SI5C — majority decoding.** A finite-valued `G` that every `c x` equals unless an event `E x` of\n"
     "probability at most `p < 1/2` occurs, the `E x` pairwise independent over an infinite index set, is almost surely equal to\n"
     "a function measurable for the σ-algebra the `c x` generate. -/\n",
     "/-- **FS131-E8-SI5C — majority decoding.** A `G` with values in a countable type that every `c x` equals unless an event\n"
     "`E x` of probability at most `p < 1/2` occurs, the `E x` pairwise independent over an infinite index set, is almost surely\n"
     "equal to a function measurable for the σ-algebra the `c x` generate. Neither `G` nor the `c x` is assumed measurable (the\n"
     "entry's finite-valued measurable variables are an instance). -/\n")
edit(MV, '(i) the module docstring: the statement is at the class the argument reads',
     "`exists_measurable_selector`). **The argument reads less than the statement carries**: not the measurability of `G`, not\n"
     "the measurability of the `c x`, and of `[Finite K]` only that `K` is countable.\n",
     "`exists_measurable_selector`). **The statement is at the class the argument reads** (inventory ruling 542, made at wave\n"
     "10's second landing, FS131-L10B): the proof as first written read neither the measurability of `G` nor that of the `c x`,\n"
     "and of `[Finite K]` only that `K` is countable, so the two hypotheses are gone and the class is `[Countable K]`.\n")

# ---------------------------------------------------------------- (ii) the instance
SF = A + 'StandingFive.lean'
edit(SF, '(ii) local instance -> instance, and the docstring word that said "local"',
     "/-- `F` is a number field: the instance the Dedekind-domain lemmas below read, local to this file. -/\n"
     "local instance instNumberFieldStanding : NumberField standingField := numberField_standingField\n",
     "/-- `F` is a number field: the instance the Dedekind-domain lemmas below read. Global since wave 10's second landing, so that\n"
     "no module downstream declares its own: two anonymous instances of one proposition merge in silence (`LEAN.md` § The gate). -/\n"
     "instance instNumberFieldStanding : NumberField standingField := numberField_standingField\n")

# ---------------------------------------------------------------- (iii) docstrings
NT = A + 'NormOneTarget.lean'
edit(NT, '(iii) involution_eq_pow: the proof the kernel holds (ruling 538 (b))',
     "/-- **A non-trivial involution of a field of `Q²` elements is the `Q`-th power map.** Its fixed field `k₀` has `Q` elements\n"
     "(`[k : k₀] = 2`, Artin); for `x ∈ k` the polynomial `(T − x)(T − σ x)` has coefficients in `k₀`, which `y ↦ y ^ Q` fixes, so\n"
     "`x ^ Q ∈ {x, σ x}`, and `x ^ Q = x` only for `x ∈ k₀`, where `σ x = x`. -/\n",
     "/-- **A non-trivial involution of a field of `Q²` elements is the `Q`-th power map.** As proved (FS131-I10D), with no fixed\n"
     "field: `σ` is an algebra endomorphism over the prime field `𝔽_p`, hence a power `y ↦ y ^ p ^ j`, `j < n = [k : 𝔽_p]`, of the\n"
     "Frobenius (`FiniteField.bijective_frobeniusAlgHom_pow`); `σ ∘ σ = id` gives `n ∣ 2j` and `σ ≠ id` gives `j ≠ 0`, so `2j = n`\n"
     "and `Q = p ^ j`. -/\n")

SI = A + 'SpectralInputs.lean'
edit(SI, '(iii) sp_if: its model, and the one named classical hypothesis still assumed (ruling 547 (a))',
     "the open zero-entropy question; at `Interface.trivial` it is met by the point mass at the trivial character. **`hcirc :\n"
     "I.NegCircle` has no Lean model on file**: `Interface.trivial` meets `MulStable` (its `E` is empty) and, with that point mass\n"
     "for `ν`, the measure hypotheses, and no declaration proves `NegCircle` of it or of any interface — one is planned at `F = ℚ` by\n"
     "the parity character (`negCircle_trivial_bot`, `Arith/NegCircleModel`, on the wave's second pass and not on this line), and\n"
     "until it lands this theorem is an open gate item under the inhabitant rule (`LEAN.md` § The gate). `hBH` is the named\n"
     "classical hypothesis `BochnerHerglotz`, with no kernel model. -/\n",
     "the open zero-entropy question; at `Interface.trivial` it is met by the point mass at the trivial character. MODEL: given\n"
     "`hBH`, every other hypothesis holds at once at `F = ℚ` with `Interface.trivial` (`sp_if_hypotheses_trivial_bot`,\n"
     "`Arith/NegCircleModel`, whose spec example applies this theorem to it; its `hcirc` is `negCircle_trivial_bot`, the point mass\n"
     "at the parity character). **One named classical hypothesis is still assumed**: `hBH` is the Herglotz–Bochner theorem for\n"
     "the countable discrete group `unitRing ⊥` — a classical theorem named as a hypothesis from outside the backlog\n"
     "(`plans/FS131-kernel-plan.md` § 7.4), true, not in the kernel; it is a statement to prove, not a structure to inhabit, and\n"
     "no smaller group serves (`unitRing ⊥ ⊇ ℤ`). Until it is proved this theorem stays an open gate item under the inhabitant\n"
     "rule (`LEAN.md` § The gate): open by one classical theorem. -/\n")
edit(SI, '(iii) si4: the note of the planner\'s § 16.2',
     "`𝒜`-measurable, almost surely proper, and `c(x) ∈ M(x)` almost surely (SI-2). The equivariance clause is\n"
     "`plans/FS131-w10-kernel-plan.md` § 3's child `si4_equivariant`. -/\n",
     "`𝒜`-measurable, almost surely proper, and `c(x) ∈ M(x)` almost surely (SI-2). The equivariance clause is\n"
     "`plans/FS131-w10-kernel-plan.md` § 3's child `si4_equivariant`. MODEL (the planner's note, `plans/FS131-w10-kernel-plan.md`\n"
     "§ 16.2; described, **not a Lean declaration**): a deterministic proper colouring — `μ` a point mass, `c ω = c₀` with\n"
     "`c₀ x ≠ c₀ y` across `adj`: each conditional law is a point mass and `hdisj` holds for every `𝒜`. A model with a non-trivial\n"
     "`𝒜` is J45-SI-C's noisy colouring with `𝒜 = σ(Φ)` (`GapSeven.supp_disjoint` is its `hdisj` on the finite plane), not built.\n"
     "Until one is a declaration this theorem is an open gate item under the inhabitant rule (`LEAN.md` § The gate). -/\n")
edit(SI, '(iii) si4_equivariant: the note of § 16.2',
     "selection `f ∘ M` is equivariant. With Mathlib's fixed version of the conditional expectation the identity is almost sure;\n"
     "the derivation chooses versions that make it sure. -/\n",
     "selection `f ∘ M` is equivariant. With Mathlib's fixed version of the conditional expectation the identity is almost sure;\n"
     "the derivation chooses versions that make it sure. MODEL: any additive action with `T 0 = id`, `𝒜` its factor σ-algebra —\n"
     "`comap_factorSigma_eq_of_action` supplies `hS𝒜`, and `si4_equivariant_factorSigma` is this theorem there\n"
     "(`Arith/FactorAction`). -/\n")
edit(SI, '(iii) spectral_carried_iff: the note of § 16.2',
     "`t` on `R` satisfying Bochner's theorem and an action by measure-preserving maps of any measure space (`σ` carries `‖f‖²`: that\n"
     "`μ` is a probability measure is not read). -/\n",
     "`t` on `R` satisfying Bochner's theorem and an action by measure-preserving maps of any measure space (`σ` carries `‖f‖²`: that\n"
     "`μ` is a probability measure is not read). MODEL (the planner's note, `plans/FS131-w10-kernel-plan.md` § 16.2; described,\n"
     "**not a Lean declaration**): the discrete topology (`bochnerOn_bot`), the trivial action `T y = id`, and `σ = ‖f‖² • δ₁`, the\n"
     "point mass at the trivial character — then both sides hold. At `τ′_S` the hypothesis `BochnerOn` is Bochner's theorem on\n"
     "`G′_S` with J45-N1 (b), not in the kernel. Until the model is a declaration this theorem is an open gate item under the\n"
     "inhabitant rule (`LEAN.md` § The gate). -/\n")
edit(SI, '(iii) contChars_haar_null: the note of § 16.2',
     "points), so `1_H·m = m(H)·m` by Herglotz–Bochner's uniqueness, `m(H) = 1`, and a second coset would have measure `1` too. -/\n",
     "points), so `1_H·m = m(H)·m` by Herglotz–Bochner's uniqueness, `m(H) = 1`, and a second coset would have measure `1` too.\n"
     "MODEL (the planner's note, `plans/FS131-w10-kernel-plan.md` § 16.2; described, **not a Lean declaration**): given `hBH`,\n"
     "`R = ℤ` with the profinite topology — the continuous characters are those of finite order, a countable (so measurable) proper\n"
     "subgroup separating the points of `ℤ`; `m` from `exists_isHaarFourier`. `hBH` is Herglotz's theorem, classical and not in the\n"
     "kernel: as for `sp_if`, a statement to prove and not a structure to inhabit. No finite `R` is a model (a separating group of\n"
     "characters of a finite group is the whole dual, against `hproper`). Until the model is a declaration this theorem is an open\n"
     "gate item under the inhabitant rule (`LEAN.md` § The gate). -/\n")

FP = A + 'FloorPlanes.lean'
edit(FP, '(iii) FloorPlanes, module docstring: Weil\'s bound is now imported',
     "**The one outside theorem, a named hypothesis in this pass** (ruled mid-job: no `axiom` until a held source's page is read\n"
     "back against it): `KloostermanBound F` — for every non-trivial additive character `ψ` of the finite field `F` and\n",
     "**The one outside theorem, a named hypothesis in this module** (its import is in `Arith/WeilKloosterman`, below):\n"
     "`KloostermanBound F` — for every non-trivial additive character `ψ` of the finite field `F` and\n")
edit(FP, '(iii) FloorPlanes, module docstring: the source is held and read back',
     "power — so at **prime powers** `p^f` with `p ≡ 3 (mod 4)`, `f` odd, not only at primes. `[Weil1948]` is the classical\n"
     "source (not held; its row states the bound at a prime); `[MMST1996]` Theorem 3 (p. 231, held and read) states the\n"
     "circle-sum bound directly but is **false as printed at `a = 0`** and is not what is assumed here.\n",
     "power — so at **prime powers** `p^f` with `p ≡ 3 (mod 4)`, `f` odd, not only at primes. `[Weil1948]` p. 207 is the classical\n"
     "source, held and read back against the Lean statement by wave 10's third planning pass: **the import is\n"
     "`StandingFive.kloosterman_bound` (`Arith/WeilKloosterman`), at characteristic not 2**, and\n"
     "`kloostermanBound_of_ringChar_ne_two` proves `KloostermanBound F` from it there; the theorems of this module keep the\n"
     "hypothesis form. `[MMST1996]` Theorem 3 (p. 231, held and read) states the circle-sum bound directly but is **false as\n"
     "printed at `a = 0`** and is not what is assumed here.\n")
edit(FP, '(iii) KloostermanBound\'s docstring',
     "additive character `ψ` of `F` and `a, b ≠ 0`: `|Σ_{x ∈ Fˣ} ψ(a x + b x⁻¹)| ≤ 2√|F|`. (`[Weil1948]`; for a general finite\n"
     "field the textbook form is Lidl–Niederreiter, *Finite Fields*, Theorem 5.45 — neither held, so this is a `Prop`, never an\n"
     "`axiom`, until a page is read back against it.) -/\n",
     "additive character `ψ` of `F` and `a, b ≠ 0`: `|Σ_{x ∈ Fˣ} ψ(a x + b x⁻¹)| ≤ 2√|F|`. (`[Weil1948]` p. 207; for a general\n"
     "finite field the textbook form is Lidl–Niederreiter, *Finite Fields*, Theorem 5.45, not held. This `Prop` is the hypothesis\n"
     "form the floor's modules were proved over; the import is `StandingFive.kloosterman_bound` (`Arith/WeilKloosterman`), at\n"
     "characteristic not 2, and `kloostermanBound_of_ringChar_ne_two` proves this `Prop` from it.) -/\n")

F8 = A + 'Floor128.lean'
edit(F8, '(iii) Floor128, module docstring: the Bézout pair is an independent witness',
     "  **`bezout4` and `bezout128` are not read**: the exact period already says that `P` is primitive.\n",
     "  **`bezout4` and `bezout128` are not read by the bridge**: the exact period already says that `P` is primitive. They stay\n"
     "  as an independent witness of `P`'s irreducibility — with `clmul_P_qBig`, coprimality to `x⁴ + x` and to `x¹²⁸ + x` leaves\n"
     "  no factor of degree dividing 2 or 7 — which a reviewer can check without the 16,383-step orbit.\n")
edit(F8, '(iii) bezout4\'s docstring',
     "/-- `a4·P + b4·(x⁴ + x) = 1`: no root of `P` lies in `𝔽₄`. -/\n",
     "/-- `a4·P + b4·(x⁴ + x) = 1`: no root of `P` lies in `𝔽₄`. Not read by the bridge: an independent witness of `P`'s\n"
     "irreducibility (with `bezout128` and `clmul_P_qBig`, Rabin's test). -/\n")
edit(F8, '(iii) bezout128\'s docstring',
     "/-- `a128·P + b128·(x¹²⁸ + x) = 1`: no root of `P` lies in `𝔽₁₂₈`. -/\n",
     "/-- `a128·P + b128·(x¹²⁸ + x) = 1`: no root of `P` lies in `𝔽₁₂₈`. Not read by the bridge: an independent witness of `P`'s\n"
     "irreducibility (with `bezout4` and `clmul_P_qBig`, Rabin's test). -/\n")

AR = 'ARCHITECTURE.md'
edit(AR, '(iii) ARCHITECTURE.md, Arith/NormOneTarget: proved',
     "| `Arith/NormOneTarget` | **FS-131 wave 10 (FS131-K10b), skeleton.** The level-one target",
     "| `Arith/NormOneTarget` | **FS-131 wave 10 (FS131-K10b; every leaf proved by FS131-I10D, no `sorry`).** The level-one target")
edit(AR, '(iii) ARCHITECTURE.md, Arith/NormOneTarget: its two leaves are theorems',
     "`targetFloor_of_charSum` (the ratio bound at `StandingFive.TargetFloor`; proved over the two). | `Arith/StandingFive`, `Arith/RatioBound` |",
     "`targetFloor_of_charSum` (the ratio bound at `StandingFive.TargetFloor`), over `card_filter_pow_eq_one` (`u ^ d = 1` has `d` solutions when `d` divides the order of `kˣ`). | `Arith/StandingFive`, `Arith/RatioBound` |")
edit(AR, '(iii) ARCHITECTURE.md, Arith/FloorPlanes: proved; the object; the import',
     "| `Arith/FloorPlanes` | **FS-131 wave 10 (FS131-K10b), skeleton.** `χ(Γ_Q) ≥ 7` for `Q ≡ 3 (mod 4)`, `Q ≥ 98`, over Weil's bound for Kloosterman sums as the named hypothesis `KloostermanBound F` (a `Prop`, never an `axiom`; model `kloostermanBound_of_card_le_five`): the completion `sum_quadratic_eq`, `circle_sum_eq_kloosterman` (`[MMST1996]` (11) at `n = 2`; FS-20's item R4), `circle_sum_le`, `normOne_charSum_ge`, `targetFloor_seven_of_kloosterman` (proved over them). | `Arith/NormOneTarget` |",
     "| `Arith/FloorPlanes` | **FS-131 wave 10 (FS131-K10b; every leaf proved by FS131-I10D, no `sorry`).** The floor at seven of the norm-one target of `𝔽_{Q²}` (`TargetFloor 7 Q`) for `Q ≡ 3 (mod 4)`, `Q ≥ 98` — G56's \"`χ(Γ_Q) ≥ 7`\" once the target is linked to the plane `Γ_Q`, which no declaration does yet — over Weil's bound for Kloosterman sums in the hypothesis form `KloostermanBound F` (a `Prop`; model `kloostermanBound_of_card_le_five`; the import that proves it at characteristic not 2 is `StandingFive.kloosterman_bound`, `Arith/WeilKloosterman`): the completion `sum_quadratic_eq`, `circle_sum_eq_kloosterman` (`[MMST1996]` (11) at `n = 2`; FS-20's item R4), `circle_sum_le`, `normOne_charSum_ge`, `targetFloor_seven_of_kloosterman`; where the printed bound holds and fails: `circle_sum_le_of_ne`, `circle_sum_zero_of_isotropic`, `two_sqrt_lt_circle_sum_zero`. | `Arith/NormOneTarget` |")
edit(AR, '(iii) ARCHITECTURE.md, Arith/ProductFactor: proved',
     "| `Arith/ProductFactor` | **FS-131 wave 10 (FS131-K10b), skeleton.** J45-SI-J at the class its argument reads (any filter not eventually finite; no spectral measure): `preimage_mem_factorSets`, `comap_factorSigma_le` (the factor of a factor system, proved), `prodMap₃`, `prodFactorSigma`, `contVec_prod_eq` (the leaf). | `Arith/SpectralInputs` |",
     "| `Arith/ProductFactor` | **FS-131 wave 10 (FS131-K10b; the leaf proved by FS131-I10F, no `sorry`).** J45-SI-J at the class its argument reads (any filter not eventually finite; no spectral measure): `preimage_mem_factorSets`, `comap_factorSigma_le` (the factor of a factor system), `prodMap₃`, `prodFactorSigma`, `contVec_prod_eq` (by the mean variance of sections on events: `fibre_mem_factorSets`, the cylinders `cylMap`, `cylSets`), and its model `contVec_prod_eq_coin`. | `Arith/SpectralInputs` |")
edit(AR, '(iii) ARCHITECTURE.md, Arith/MajorityVote: proved, at the class of ruling 542',
     "| `Arith/MajorityVote` | **FS-131 wave 10 (FS131-K10b), skeleton.** FS131-E8-SI5C, majority decoding, under J45-SI-5 (c): `ae_eq_measurable_of_majority` (events of probability at most `p < 1/2`, pairwise independent, over an infinite index set). | Mathlib |",
     "| `Arith/MajorityVote` | **FS-131 wave 10 (FS131-K10b; proved by FS131-I10F, no `sorry`).** FS131-E8-SI5C, majority decoding, under J45-SI-5 (c): `ae_eq_measurable_of_majority` (events of probability at most `p < 1/2`, pairwise independent, over an infinite index set; values in a countable type, no measurability of the variables assumed — inventory ruling 542), over `measure_half_le_sum_indicator_le`, `eq_of_lt_two_mul_card_filter`, `exists_measurable_selector`. | Mathlib |")
edit(AR, '(iii) ARCHITECTURE.md, Arith/NegCircleModel: proved',
     "| `Arith/NegCircleModel` | **FS-131 wave 10 (FS131-K10b), skeleton.** A model of `Interface.NegCircle` at `F = ℚ`, the point mass at the parity character: `exists_parityHom`, `negCircle_trivial_bot`. | `Arith/SpectralInputs` |",
     "| `Arith/NegCircleModel` | **FS-131 wave 10 (FS131-K10b; every leaf proved by FS131-I10F, no `sorry`).** A model of `Interface.NegCircle` at `F = ℚ`, the point mass at the parity character: `exists_parityHom`, `negCircle_trivial_bot`; and `sp_if_hypotheses_trivial_bot` — given `BochnerHerglotz`, every other hypothesis of `sp_if` at once. | `Arith/SpectralInputs` |")


def main():
    check_only = '--check' in sys.argv
    texts, bad = {}, 0
    for path, what, old, new in EDITS:
        t = texts.setdefault(path, open(path, encoding='utf-8').read())
        n = t.count(old)
        print(f'{"OK  " if n == 1 else "BAD "} n={n}  {path}: {what}')
        if n != 1:
            bad += 1
            continue
        texts[path] = t.replace(old, new)
    print(f'edits={len(EDITS)} bad={bad} files={len(texts)}')
    if bad:
        print('tidy: REFUSED (an edit does not match exactly once); nothing written')
        return 1
    if check_only:
        print('tidy --check: PASS; nothing written')
        return 0
    for path, t in texts.items():
        open(path, 'w', encoding='utf-8').write(t)
    print('tidy: written')
    return 0


if __name__ == '__main__':
    sys.exit(main())
