# J23bd — `Transcendental.lean` attribution fix (M2 close, inventory row 68)

*Crunch job J23bd, 2026-09-25, de Bruijn (Opus 5.5). Brief: `data/crunch-2026-09-25/briefs/J23bd-M2-docstring-attribution.md`.*

## Theorems this phase proved

None. This job edits one module-doc paragraph (prose only; no declaration changes).

## "Would have searched here" log

None: no move in this job would have been a search.

## Stage 1 — SAVED: the two checks against the sources, and the brief's quotations

**Check 1 — Fischer's volume.** The held PDF `~/source/library/papers/1-s2.0-0012365X9090324B-main.pdf`, page header of p. 181:
"Discrete Mathematics    82 (1990) 181-195". Theorem 6 is on p. 188 (the running head "188 K. G. Fischer" precedes it). `BIBLIOGRAPHY.md`
line 120: "Discrete Math. 82 (1990) 181–195". The module doc (line 23) says "Discrete Math. 81": **wrong; it is 82**. The page, 188, is right.
The quoted statement in the module doc — *"Let α be a real number transcendental over the field F ⊂ ℝ. Then F^d can be k-colored (has an
additive k-coloring) iff F(α)^d can be k-colored"* — matches the PDF's Theorem 6 (it stops before the second "(has an additive k-coloring)").
"Setting x = 0" is the PDF's words (its line "Setting x = 0, one sees that if c(0) = 0, …").

**Check 2 — Madore's Prop. 3.2.** The held PDF `~/source/library/pdf/arXiv-1509.07023-madore-hadwiger-nelson-over-fields.pdf`, p. 6:
"Proposition 3.2. Let A be a valuation ring with valuation v: write m := {x ∈ A : v(x) > 0} for its (unique) maximal ideal, κ := A/m the
residue field, and K := Frac(A) for the field of fractions of A. Assume that the quadratic form z1² + · · · + zd² is anisotropic over κ
(that is, z1² + · · · + zd² = 0 has no solution in κ other than the trivial (z1, . . . , zd) = (0, . . . , 0)). Then there is a graph
homomorphism ψ : Γ(K^d) → Γ(A^d). […] we have: χ(K^d) = χ(A^d) ≤ χ(κ^d)." Its proof opens: "First observe the following fact: if
x1² + · · · + xd² = 1 with xi ∈ K, then in fact xi ∈ A for all i." At d = 2, anisotropy of z1² + z2² over the field κ is exactly "−1 is
not a square in κ". The Lean lemma `mem_valuationSubring_of_sq_add_sq_eq_one` (`Transcendental.lean:141`) assumes
`∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits`, i.e. `1 + x̄² ≠ 0` for every `x̄` in the residue field — the same hypothesis — and concludes the proof's
first paragraph; `unitQuadrance_colorable_of_valuationSubring` (line 177) composes it with the coset step, which is the rest of
Madore's proof. A residue hom into a ring `S` with `1 + s² ≠ 0` factors through `κ`, which embeds in `S`, so the target ring adds
nothing beyond Prop. 3.2. **So the generality the module doc calls ours ("the valuation lemma stated for any valuation subring whose
residue ring has no square root of `−1`") is Madore's Prop. 3.2 at d = 2**, as inventory rows 67–68 say (`plans/M2-close-inventory.md`).

**The brief's quotations, checked verbatim against their sources.**
- "stated for any valuation subring whose residue ring has no square root of −1" — the module doc, line 27–28, reads "the valuation lemma
  stated for any valuation subring whose residue ring has no square root of `−1`": matches (backticks aside).
- "the kernel form … is ours" — the module doc, line 26, reads "What is ours is the kernel form, stated for any formally real `F`, and …":
  the brief's ellipsis form is a rearrangement, not a verbatim quotation; the sense (keep the kernel form credited to us) is unambiguous.
- "about lines 20–28" — the paragraph is lines 23–28.
- J23b's gate counts in the brief (1,130 clean / 11 axiom-free / 5 purchases; declarations 7051, refutations 304, sites 279, generic 257):
  match `data/m2/j23b/axioms-stage0-after.out` line 41 and `data/m2/j23b/vacuity-stage0.out` lines 3–4 (which also give vacuous=0 stale=0
  declared=3 witnessed=17 unknown=2).
- `scripts/vacuity-baseline.txt`'s header **does** record counts: "declarations=6795  refutations-skipped=278  sites=275" and
  "vacuous=0 stale=0 declared=3 witnessed=17 generic=253 unknown=2" — so it is brought to the gate's current counts in stage 2.
- No other Lean file carries "Discrete Math. 81" (`grep -rn "Math\. 81" --include="*.lean" Proofs scripts`: the one line).
