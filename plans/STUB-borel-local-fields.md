# Stub — the Borel bound at every anisotropic local field

*Minted 2026-10-16 by Keryx from FS131-IQP3's draft D9 (`plans/FS131-IQP3-padic.md` § Drafts for the front page), the planner's § 5.5 brought to what is proved; inventory item 1032. Unranked: the asking lane ranks it at its next job.*

**The Borel bound at every anisotropic local field — a reading.** *Claim (one mind, not checked line by line):* for every
non-archimedean local field `K` of odd residue characteristic whose residue field `𝔽_q` has `q ≡ 3 (mod 4)` — the fields over
which `x² + y²` is anisotropic — `χ_Bor(K²) ≥ 1 + (q + 1)/(2√q)`, and with the certificates `χ_Bor(K²) = 4, 5, 5` and `≥ 6`
whenever `𝔽_q = 𝔽₇, 𝔽₁₁, 𝔽₁₉, 𝔽₂₃` (at `𝔽₂₃` the kernel's route gives `≥ 5` from the circle's cosine sums alone; `≥ 6` needs
FS-66's certificate, [cert]), ramified extensions of `ℚ_p` and `𝔽_q((t))` included. *Why:* the route reads `ℚ_p` only as a
complete discrete valuation ring with odd residue characteristic: Lemma P's square-zero algebra (`Rigidity/ClassRatio`'s
`SqZeroInvT`) never reads the ramification; Madore's Prop. 3.2 (any valuation ring) makes unit vectors integral; Hensel lifts
the circle; Haar on `𝓞_K²` is regular. *Killing test:* a level of `UD(𝓞_K/𝔪^k, 2)` at a ramified `K` with an independent set
above `2√q/(q + 1 + 2√q)` of its points. *Bearing on the answer:* none on `χ(ℝ²)`; it widens the answer to the posers'
question from `ℚ_p` to every local field they consider (their Theorem 1.1 is for characteristic zero; their Rem. 1.5 asks for
positive characteristic). *Lean:* Mathlib at the pin has no general local field API this would read; `ℚ_p(√p)` or `𝔽_q((t))`
as instances would each be a job. *The kernel's `ℚ_p` case is `PadicPlane/Values` (FS-131), whose proof reads `ℚ_p` through
`ℤ_[p]`, `PadicInt.toZModPow` and Mathlib's Hensel.*
