# M18 — the derivation file: every theorem this milestone stated outside the kernel

*Written 2026-09-22 by the FS-71 batch-1 implementer (WORKFLOW 2.0 step 9's theorem-tracking rule, backfilled by the
theorem audit); T1 re-derived and its statement sharpened by the owner the same day. Enumeration:
`plans/M18-the-120-degree-class.md` read in full. Grades are `CLAUDE.md` § Notation's.*

## The theorems

**T1 — The roots of unity of the coordinate field, and the pentagon exclusion. [hand; sketched by the M18 implementer
(deferred there, never completed); re-derived by the owner 2026-09-22]** Let `F = ℚ(√3,√5,√7,√11)` (the field of every
object M18 built; the argument uses only that `F` is real multiquadratic and `2 ∉ ⟨3,5,7,11⟩` in `ℚ^×/ℚ^{×2}`). Then
`μ(F(i)) = ⟨ζ₁₂⟩`: a primitive `n`-th root of unity lies in `F(i)` iff `n ∣ 12`. **Consequences.** (a) A regular unit-sided
`n`-gon with vertices in `F²` exists iff `n ∣ 12`: the ratio of two consecutive edge vectors is `ζ_n` (up to sign) and lies in
`F(i)` when the vertices do; so the only odd order is 3 — "1/3 is the only class that closes an odd regular cycle" is a
theorem about the field. (b) In particular the classes at `r² = (5 ± √5)/10`, which close into unit pentagons over ℝ, hold no
five points of `F²` at 72° spacing (`cos 72° = (√5−1)/4 ∈ F`, but the rotation `ζ₅` is not in `F(i)`). *Not claimed:* anything
about odd cycles of the unit-distance graph that are not regular polygons (the Moser spindle in `F²` has 5-cycles). *Proof
(owner's re-derivation):* `F(i)/ℚ` is Galois with group `(ℤ/2)⁵`, so every subfield is Galois over ℚ with an elementary abelian
2-group as Galois group. `ζ_n ∈ F(i)` forces `ℚ(ζ_n) ⊆ F(i)`, hence `(ℤ/n)^× ≅ Gal(ℚ(ζ_n)/ℚ)` elementary abelian of exponent 2,
which holds iff `n ∣ 24`. Of those, `ζ₈ ∉ F(i)`: `ζ₈ = (1+i)/√2` would give `√2 = (1+i)/ζ₈ ∈ F(i) ∩ ℝ = F`, and `2` is not in the
square-class group `⟨3,5,7,11⟩`; so `ζ₂₄ ∉ F(i)` either, and `ζ₁₂ = (√3+i)/2 ∈ F(i)`. Hence `μ(F(i)) = ⟨ζ₁₂⟩`. For (a): if
`p₀, …, p_{n−1} ∈ F²` are the vertices of a regular unit `n`-gon, then in `ℂ` the edge vectors are `e_k = p_{k+1} − p_k ∈ F(i)`
with `e_{k+1}/e_k = ζ_n^{±1}`, so `ζ_n ∈ F(i)`; conversely `n ∣ 12` gives the `n`-gon `ζ_n^k/(ζ_n − 1)`, rescaled into `F²`. The
M18 sketch's route — `ℚ(sin 72°) = ℚ(√(10+2√5))` is the cyclic quartic field of conductor 20 (its conjugates `±√(10±2√5)` lie
in it since their product is `4√5`; cyclic because `(10² − 4·5)·5 = 400` is a square), and a cyclic group of order 4 is no
subquotient of `(ℤ/2)³` — is the same argument read on the real subfield, and is also correct. *Proof verdict:* **closes**
(the owner's re-derivation above; the M18 sketch at `plans/M18-the-120-degree-class.md` §0(d) states the mechanism and
deferred the statement to a §5 that never received it). *Rests on it:* the census rule in `tools/classstat.py` ("no pentagon
class carries a unit edge", row 13 — a [tools] check that stands on its own); M18's choice of the triangle identity as the
plane-level Lean statement. The same fact for `K = ℚ(√3,√11)` is row 64's `μ(K(i)) = ⟨ζ₁₂⟩` (pari). *Prior art:* the criterion
"`(ℤ/n)^×` is an elementary abelian 2-group iff `n ∣ 24`" and the roots of unity of a multiquadratic field are textbook
(Washington, *Introduction to Cyclotomic Fields*, ch. 2 exercises); the application to unit polygons over a coordinate field
is project-specific and trivial once stated. zbMATH: `ti:"cyclotomic field" & ab:"multiquadratic"` (0 hits), `ab:"Galois
group" & ab:"regular pentagon" & ab:"unit distance"` (0 hits). Nearest held key: none on point. *Kernel:* declined — a
half-page of Galois theory Mathlib holds in pieces (`IsCyclotomicExtension`, `ZMod.unitsMap`), for a statement no row
consumes; the plane-level theorem M18 needed is the unconditional triangle identity (row 6, kernel).

## Readings and measurements that were called theorems

- The row 13 ledger clause "the growth-family hunt is closed exhaustively (557M class-tests); SAT pool statistics
  measure the solver, not the colouring space" is pure [tools] negative knowledge (M17–M19), not a theorem; already
  correctly graded in `LEDGER.md`.

## Conjectures surfaced, not claimed

(none — T1 closed under the owner's re-derivation)

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| T1 | declined — textbook Galois theory; no consumer beyond a census rule |
