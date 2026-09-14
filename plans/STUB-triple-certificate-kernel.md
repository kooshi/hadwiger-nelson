# FS-52 — The triple-level certificate in the kernel: FS-50's exact bound as a Lean theorem (STUB, 2026-09-14; minted at FS-50's close)

*Read beside: `plans/STUB-ratio-bound-kernel.md` (FS-51, the pair level and the `Nat` cost model this inherits),
`plans/STUB-independence-threshold.md` §M2–§M3 (the identity, the wire form), `plans/FS50-certificate-soundness.md`,
`tools/fplane_cert_check.py`, `data/fs50/cert-p11-N29.json` (the first certificate; its kernel form is the target).*

## 1. Mission context

FS-50 proved `α(UD(𝔽₁₁, 2)) ≤ 29` exactly, with a checker of a few hundred lines of exact arithmetic — and, if phase E lands,
the bound at 83 that makes `χ(UD(𝔽₈₃, 2)) ≥ 7` on that checker's word. The kernel form replaces the checker by Lean: the
orbit algebra's structure constants as literals, the identity as a `decide`-able coefficient check, the PSD blocks as Gram
factors `BᵀB` checked by GMP `Nat` arithmetic, and the soundness page as a theorem — `indepNum_le_of_triple_certificate`.
Then `seven_le_chromaticNumber_finitePlane83_of_indepNum_le`'s hypothesis is discharged and χ ≥ 7 at 83 is kernel.

## 2. What is hard

The soundness theorem (§M2) quantifies over every independent set and every `G`-invariant averaging: the primal
construction `Y_S = (1/s) Σ x^z x^zᵀ`, the averaging over `O(2, p)`, and weak duality — real algebra over ℚ, Mathlib-shaped
(`Matrix.PosSemidef`, `Finset.sum` over the group). The orbit structure constants at 83 are `≈ 49k × (blocks)` literals — the
olean cost model (`≈ 2.3 KB per Nat literal`) says pack them. The Gram check at 83: blocks `≤ 166`, `B` rational with a common
denominator — `≈ 86 × 166² × 166 ≈ 4·10⁸` multiplications: measure.

## 3. Phases

| phase | what | stop rule |
|---|---|---|
| A | the soundness theorem in the kernel, generic in `p` and the certificate data; the instance at 11 from `cert-p11-N29.json` (`α ≤ 29`, consistent with the existing `chromaticNumber_finitePlane11 = 5`) | green; `#print axioms` clean |
| B | the instance at 83 from the phase-E certificate (if it exists) — `seven_le_chromaticNumber_finitePlane83` unconditional | the ledger row's `[kernel]` level for the first digit |

## 4. Bearing on 6, honestly

**None; high as a certificate discipline.** It is the SOS analogue of the LRAT replay this project built for SAT: the proof
system that carries spectral arguments, checked by the kernel.
