#!/usr/bin/env python3
"""FS131-L10A, stage 3: ARCHITECTURE.md's rows for wave 10's four first-pass modules ("skeleton" no longer).
Exact replacements, each of which must match once; every backticked declaration name in a new row is
then looked up in the module's source. usage: data/fs131/l10a/arch_rows.py ARCHITECTURE.md"""
import re, sys

EDITS = [
 ("Skeleton leaf: `mem_archimedean_unitRing_iff`. |",
  "`mem_archimedean_unitRing_iff` (the erratum's `A` read back as `Hom_ℚ(F(i), ℝ) mod 1`; over `exists_ratLinear_extension`, by Mathlib's Baer criterion; proved by FS131-I10A). No `sorry`. |"),
 ("| `Arith/SpectralInputs` | **FS-131 wave 10 (FS131-K10), skeleton.** J45's lemmas at the class each argument reads: `IsHaarFourier`; `sp_only_if`, `sp_only_if_interface` (J45-SP-oi, proved); `Interface.MulStable`, `Interface.NegCircle`, `sp_if` (J45-SP-if); `contVec`, `factorSets`, `factorSigma`, `measurableSet_factorSigma_iff`, `contVec_eq_lpMeas`, `measurableSet_preimage_factorSigma` (J45-N2, the factor of a filter); `contChars`, `BochnerOn` (a named classical hypothesis), `IsSpectralMeasureOf`, `spectral_carried_iff` (J45-N2, spectral half); `contChars_haar_null` (J45-N1 (c)); `condSupport`, `si4` (J45-SI-4). |",
  "| `Arith/SpectralInputs` | **FS-131 wave 10 (FS131-K10; proved by FS131-I10A), no `sorry`.** J45's lemmas at the class each argument reads: `IsHaarFourier` (`exists_isHaarFourier`, given `BochnerHerglotz`), `ext_of_fourier`; `sp_only_if`, `sp_only_if_interface` (J45-SP-oi); `Interface.MulStable`, `Interface.NegCircle`, `sp_if` (J45-SP-if, over `BochnerHerglotz` and those two; **`NegCircle` has no Lean model on file: an open gate item**); `contVec`, `factorSets`, `factorSigma`, `measurableSet_factorSigma_iff`, `contVec_eq_lpMeas`, `measurableSet_preimage_factorSigma`, `condExpL2_mem_contVec`, `condExpL2_eq_self_iff`, `inner_sub_condExpL2_eq_zero` (J45-N2, the factor of a filter, no hypothesis from outside); `contChars`, `BochnerOn` (a named classical hypothesis), `IsSpectralMeasureOf`, `spectral_carried_iff` (J45-N2, spectral half, over `BochnerOn`); `contChars_haar_null` (J45-N1 (c), over `BochnerHerglotz`); `condSupport`, `si4`, `si4_equivariant` (J45-SI-4, no hypothesis from outside). |"),
 ("| `Arith/StationaryRatio` | **FS-131 wave 10 (FS131-K10), skeleton.** `StationarySet` (a probability-preserving jointly measurable action with an event; inhabitant `StationarySet.empty`), `StationarySet.AEIndependent`, `StationarySet.nbhd`, `ratio`, `cosetAverage`; `StationarySet.prob_le_ratio_mul` (X25B-P), `ratio_prod_le` (X25B-PZ), `ratio_prod_le_iSup_levels` (X25B-L1, the levels pulled back to `X × Y`). Mathlib only. |",
  "| `Arith/StationaryRatio` | **FS-131 wave 10 (FS131-K10; proved by FS131-I10B), no `sorry`.** `StationarySet` (a probability-preserving jointly measurable action with an event; inhabitants `StationarySet.empty` and `StationarySet.parity` — `ZMod 2`, `P(B) = 1/2`, with `ratio_dirac_one_zmod_two : ratio δ₁ = 2⁻¹`), `StationarySet.AEIndependent`, `StationarySet.nbhd`, `ratio`, `cosetAverage`, `cantorLevel` (X25B-L1's levels on `ℕ → ZMod 2`); each row at the class its proof reads, with no hypothesis from outside Mathlib: `StationarySet.prob_le_ratio_mul` (X25B-P), `ratio_prod_le` (X25B-PZ), `ratio_prod_le_iSup_levels` (X25B-L1, the levels pulled back to `X × Y`; the comparison with the finite graphs on `X × Y/K_k` is not stated). Mathlib only. |"),
 ("| `Arith/StandingFive` | **FS-131 wave 10 (FS131-K10), skeleton.** `eta`, `E7`, `standingField` (`K·E₇ = ℚ(√3, √11, η)`); the unconditional clauses of TC1-STANDING-FIVE (`numberField_standingField`, `finrank_standingField`, `isTotallyReal_standingField`, `ncard_primes_above_two`, `comap_conj_of_two_mem`, `card_quotient_of_two_mem`, `usable_card_ge`, `no_small_usable`, `stablePrime_card`); `normOneCayley`,",
  "| `Arith/StandingFive` | **FS-131 wave 10 (FS131-K10; proved by FS131-I10C), no `sorry`.** `eta`, `E7`, `standingField` (`K·E₇ = ℚ(√3, √11, η)`; `g_eta`, `cev_hvec`, `minpoly_eta`, `irreducible_gPoly`, `finrank_E7_and_K`); the unconditional clauses of TC1-STANDING-FIVE (`numberField_standingField`, `finrank_standingField` (28), `isTotallyReal_standingField`, `ncard_primes_above_two`, `comap_conj_of_two_mem`, `card_quotient_of_two_mem`, `usable_card_ge` (every usable residue field has at least 347 elements), `no_small_usable`, `stablePrime_card`, `exists_stablePrime_two`); the finite-field layer (`card_ge_of_usable`, `fourteen_dvd_of_char_two`, `card_fixed_of_involution`; `usableBelow_347` by `decide +kernel`); `normOneCayley`,"),
]
MOD = {"Arith/SpectralInputs": "SpectralInputs", "Arith/StationaryRatio": "StationaryRatio",
       "Arith/StandingFive": "StandingFive", "Arith/CharacterColouring": "CharacterColouring"}
SKIP = {"sorry", "decide +kernel", "ZMod 2", "P(B) = 1/2", "X × Y", "X × Y/K_k", "ℕ → ZMod 2", "A", "Hom_ℚ(F(i), ℝ) mod 1",
        "K·E₇ = ℚ(√3, √11, η)", "BochnerHerglotz", "ratio_dirac_one_zmod_two : ratio δ₁ = 2⁻¹", "M →+ ℝ/ℤ", "A(R_F)", "U₀",
        "StandingFloor 5"}

path = sys.argv[1]
s = open(path, encoding="utf-8").read()
for i, (old, new) in enumerate(EDITS, 1):
    if s.count(old) != 1:
        sys.exit(f"edit {i}: expected one occurrence, found {s.count(old)}")
    s = s.replace(old, new)
open(path, "w", encoding="utf-8").write(s)
bad = 0
for line in s.split("\n"):
    for key, mod in MOD.items():
        if line.startswith(f"| `{key}` |"):
            src = open(f"Proofs/HadwigerNelson/Arith/{mod}.lean", encoding="utf-8").read()
            names = [n for n in re.findall(r"`([^`]+)`", line.split("|")[2]) if n not in SKIP and not n.startswith("Arith/")]
            miss = []
            for n in names:
                short = n.split(".")[-1]
                if not re.search(r"\b(theorem|def|abbrev|structure|instance|lemma)\s+(\S*\.)?" + re.escape(short) + r"\b", src) \
                   and not re.search(r"\b(theorem|def|abbrev|structure|instance|lemma)\s+\S*" + re.escape(n) + r"\b", src):
                    miss.append(n)
            print(f"{key}: {len(names)} names cited, {len(miss)} not declared in the module: {miss}")
            bad += len(miss)
print("arch rows: PASS" if bad == 0 else "arch rows: FAIL")
sys.exit(1 if bad else 0)
