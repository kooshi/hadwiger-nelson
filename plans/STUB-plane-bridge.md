# FS-39 — The bridge: χ(ℝ²) is the supremum of χ(F²) over real number fields (STUB, 2026-09-13; minted by the Poros wall-breaking pass, card 3 of `plans/POROS-2026-09-13-wall-breaking.md`)

## 1. Mission context, in plain language

Since M58 every result of the programme is a statement about the unit-distance graph of a number field's plane F², and the
record turns them into statements about ℝ² by two classical facts stated in prose and nowhere proved, cited or formalized:
(i) de Bruijn–Erdős — χ(ℝ²) is the supremum of the chromatic numbers of its finite subgraphs; (ii) every finite
unit-distance graph in ℝ² has a drawing with all coordinates in some real number field. Together they give
χ(ℝ²) = sup_F χ(F²), which is what makes the local–global conjecture's bold form (`plans/M61-local-global-tightness.md:67-68`:
"since de Grey's field has L = 8, T2 is equivalent to χ(ℝ²) = 7") and the programme's upper-bound assessment
(`plans/PROGRAMME-ALGEBRAIC-PROOF.md` §4, first line) meaningful. A stranger reading the conjecture cannot get from the
fields to the plane without them. (ii) is not free: the drawing constraints form a real algebraic variety defined over ℚ,
and a real point yields a real-algebraic point by the completeness of the theory of real closed fields (Tarski–Seidenberg);
an injective drawing is not needed, since a non-injective one is still a homomorphism into the plane's graph.

## 2. What we know

| fact | trust | where |
|---|---|---|
| the field results: Theorem B, the finite-plane bound, the sieve, M60, M61 | kernel / hand | rows 52–61 |
| "de Bruijn–Erdős" invoked as prose | prose only | `plans/M61-local-global-tightness.md:13`, `plans/M35-k5-transfer.md:12`, `plans/M29-uncountable-pair.md:4`, `plans/PROGRAMME-ALGEBRAIC-PROOF.md` §4 |
| the algebraic-drawing step | never stated | grep 2026-09-13 |
| the lower-bound direction needs neither: a finite graph drawn in F ⊂ ℝ IS a subgraph of the plane's graph (`Instances/DeGrey`, `chromaticNumber_le_of_drawing` genre) | kernel | `Lift.lean` |

## 3. Derivations first

D1 — the direction that matters for a 6-forcer needs nothing new: a finite unit-distance graph over any real number field is
literally a finite subgraph of `unitDistance ℂ`, so χ(ℝ²) ≥ χ(F²)'s finite witnesses is already how rungs A and B were
certified. The bridge is needed only for the UPPER direction and for the equality χ(ℝ²) = sup_F χ(F²): if some field had
χ(F²) = 7 the plane would too (trivial), and conversely if every field plane is ≤ 6 then so is ℝ² — that converse is (i) + (ii).

D2 — (i) in Lean: for `V = ℂ`, `chromaticNumber (unitDistance ℂ) = ⨆ over finite S, chromaticNumber (induce S)`; this is the
compactness theorem for graph colourings (de Bruijn–Erdős 1951; for countable graphs an elementary König argument, for
uncountable ones a Tychonoff/ultrafilter argument — Mathlib may hold `SimpleGraph.Colorable` compactness; check
`Mathlib.Combinatorics.SimpleGraph.Coloring` and any `chromaticNumber_eq_iSup` before writing).

D3 — (ii) in Lean: given `S : Finset ℂ` with the unit-edge relation, produce `T : Finset ℂ` with coordinates in a number field
(or simply in the real algebraic numbers, `AlgebraicClosure`/`IsAlgebraic ℚ`) and an edge-preserving map `S → T`. The honest
route is model-theoretic (Tarski's theorem, which Mathlib does not hold) or an explicit one: the unit-edge system is a
finite polynomial system over ℚ; a real solution exists; by the real Nullstellensatz / elimination the solution set is a
semialgebraic set defined over ℚ, nonempty, so it has a point over the real algebraic numbers (the real closure of ℚ is
existentially closed in ℝ). Price the Mathlib support first; if it is absent, the stub's deliverable is the statement with
`sorry` at that leaf, labelled, so the record has the bridge's SHAPE and one named gap.

## 4. Phases

| phase | what | cost |
|---|---|---|
| A | (i) — compactness of colourings for `unitDistance ℂ`, or the citation of Mathlib's lemma | half a day |
| B | (ii) — the algebraic-drawing lemma, or its statement with the named gap | one to two days, Mathlib-dependent |
| C | the corollary `chromaticNumber_plane_eq_iSup_numberField` and a rewrite of the prose sentences to cite it | an hour |

## 5. Bearing on 6, honestly

None directly on finding a 6-forcer (D1). High on the honesty of every "χ(ℝ²) = …" sentence the programme writes after M58,
and required by FS-20's paper. Cheap.
