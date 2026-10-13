# Claims EN1 — a shorter route under two number-field results, proposed by the kernel planner from the kernel proof; fixed by Keryx, 2026-10-13, before the deriver's launch

*Statements only, each one line with its id, in the proposer's words (the kernel planner's message of 2026-10-13, logged whole as item 642 of the backlog's inventory). The symbols are the record's: `F` a real number field; `U_F` its unit vectors; `T` and `A` the torsion and the archimedean characters of the dual of `ℤ[U_F]`; `E` the set the kernel's interface carries; PE-2, EF_F⁺, R-U, SP-Cor, A⁺, SI-3, SI-4, N1, N2 the entries of those names in the derivation files. A later change is a dated line at the end.*

## Statements

EN1-MRPLUS: MR⁺(F): every finite rotation-invariant measure on the dual of ℤ[U_F] that gives T + A measure 0 has every Fourier coefficient off 0 equal to 0.
EN1-FROM-TWO: MR⁺(F) follows from PE-2 and EF_F⁺ alone: EF_F⁺'s conclusion is already about T + A (a zero-entropy invariant measure is carried by T + A), so for an invariant τ null on T + A, τ = a·m + τ′ (PE-2), τ′ ≤ τ is null on T + A and, by EF_F⁺, null off it, so τ′ = 0.
EN1-SPCOR: SP-Cor at S = ∅ needs only MR⁺(F) and A⁺ at S = ∅; run at E := T + A, the hypothesis R-U is τ(∅) = 0.
EN1-APLUS: nothing in A⁺ at S = ∅ (SI-3, SI-4, N2 at S = ∅) reads E beyond T + A; N2 at S = ∅ does still need N1 (a) at S = ∅ — the characters continuous for the profinite-plus-archimedean topology are exactly T + A.
EN1-OFFPATH: the hand result R-U, with the split-place topology under it, and N1's clauses about the split places and "Haar(E) = 0", are not on the path of ledger rows 121 and 123 (the plane over the field of √47 needs five colours; the main clause through five); the split-place E stays what it was for the selection results and Theorem C at S ≠ ∅ (rows 112, 116–118).

## Not claimed

EN1-NC: that any of these is new mathematics; that R-U is false or unneeded elsewhere; anything about rows other than 121 and 123; that the kernel's present theorems already state MR⁺(F) (they are stated over an abstract interface).

## Dated lines

- 2026-10-13 16:34 UTC — **EN1-MRPLUS holds in a narrower form than written; found by the deriver (FS131-EN1, its Stage 5).** Its words: "TRUE in a narrower form than 'F a real number field' — for every real number field with R_F = O′ (no stable dyadic place ramified in F(i)/F), and with 'finite measure' read as finite positive measure. (a) Scope: EF_F⁺'s three proofs need R = O′; at row 100's exception fields MR⁺ is a GAP exactly where MR is. The class of rows 121 and 123 (L ≥ 5) lies inside R = O′, so the path loses nothing. (b) Under the literal signed reading (τ signed, τ(T + A) = 0) it is false: the difference of two archimedean circle measures." A Lean statement of MR⁺ carries both: the field's hypothesis and positivity.
