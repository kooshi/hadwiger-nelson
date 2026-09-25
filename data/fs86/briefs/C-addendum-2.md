## Addendum 2: verifier B1's remaining verdicts (the owner, 2026-09-25; identical for both competitors)

Verifier B1 has finished (`plans/FS86-B1-verification.md`, its "Theorems this phase proved"; tools `data/fs86/b1/`). **Nothing in the plan's frame is refuted, and nothing diverges in truth.** Its comparison with the plan's sketches found missing steps, all closed, and one false side claim.

1. **The verdicts not in Addendum 1:**
   - **V1 proved.** `F(R) = ⋃ F(Λ)`, and `P(Λ) ⊆ P(R) ∩ Λ` is **strict in general**: for `Λ = ℤu`, `P(Λ) = 0` while `P(R) ∩ Λ = 4ℤu`.
   - **V3-ram** (the ramified 59-tower) is proved with "ratio at level 1" read as Hoffman's ratio bound (0.19912, `λ_min(Γ₅₉) = −14.918 > −15`). Under the true-independence-ratio reading, its middle inequality is FS-68's open question from level 3 on, though "< 1/5 at every level" still holds.
   - **V4 (the sharp form) proved given V2 and V3:** `F(R) ≠ 0` iff the pair `(0, 4)` is four-colour forced.
   - **VK (plan §0.4) proved blind, per coset of `K²`**, given one nonzero forced difference (row 78's certificate, or row 85's derivation). **The K classification is now a known positive at the field level, with two derivations:**
     - every four-colouring of every `R_K`-coset is a pullback from `P₄` at one of K's two dyadic primes;
     - `F(R_K) = 4R_K`;
     - `F(R_K) ∩ Λ = 4Λ ⊋ 8Λ = F(Λ)`, consistent with row 85.
2. **Steps the sketches lacked, now closed** (use B1's forms):
   - **(D2)** V3's "the finite quotient is a product of local planes" needs `R` dense in the product of the stable completions, not only the connection set. Weak approximation gives the connection set, not the vertex set. Closed by B1's Lemma R: `ℤ[U_F]` is exactly the ring of elements integral at every conjugation-stable prime.
   - **(D4)** For 83 and 131, the stable 19 must be sourced to FS-66's certificate `U(19)`, not to G54's constant ratio (Hoffman's bound there is 0.2756 > 1/4).
   - **(D5)** `[Zhang2012]` Thm 1.8 needs `H` connected, which is true but unstated in §0.3.
   - **(D6)** VK's ramified 11-adic places (two primes, `e = f = 2`; Hoffman 0.2855) need FS-66's certificate carried to a ramified tower. B1's Lemma P(ii) does this: the certificate's links L1–L2 use only the coset structure and Hensel's count; FFT-checked at levels 2–3.
3. **A false side claim in the plan (D8).** Plan §0.4's "Negative" says that for ℚ(√11) "MIS-normality pulls back from Γ₇ instead". That is wrong:
   - `Γ₇`'s ratio is 2/7 > 1/4, so colour classes need not be maximum independent sets;
   - ℚ(√11)'s plane has periodic four-colourings pulled back from its dyadic `K₄` (11 ≡ 3 mod 8), which do not factor through `Γ₇`.

   The conclusion `F = P = 0` over ℚ(√11) stands, by row 66's gap transport.
4. **A new positive control, by formula:** `[Fischer1994]`'s ℤ/4 colouring kills `R_K ∩ 𝔓₁³` and no power of `𝔓₂`. It reads exactly one dyadic prime, at level 3, as VK predicts.
5. **Prior art for VK:** Speyer (Polymath16, 25 April and 3 May 2018; the held threads, `~/source/library/notes/polymath16-threads-1-18-text.txt`) posed the level-one question on the Moser ring and found `8R`-periodic colourings there. That is consistent with VK by the mechanism of `F(Λ) = 8Λ ⊊ 4Λ`. No field-level classification was found in the threads, the wiki's algebraic page or `[Fischer1994]`.
