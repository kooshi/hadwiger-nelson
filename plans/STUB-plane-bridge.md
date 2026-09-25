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

D4 — **Route C for (ii): a valuation-theoretic descent instead of a model-theoretic one** (added 2026-09-17; `CLAUDE.md` G63).
D3's two routes both go through real closed fields. There is a third, and it uses machinery this repository already has.

> **Lemma (transcendence is free).** For any `F ⊆ ℝ` and any `t` transcendental over `F`, **`χ(F(t)²) = χ(F²)`**.

*Proof.* Take the place `t ↦ 0` of `F(t)/F`; its residue field is `F`, which is formally real, so `−1` is not a square in it. If a
unit vector `(u,v)` — `u² + v² = 1` — had a pole, the leading terms of `u²` and `v²` would have to cancel, which forces `−1` to be
a square in the residue field. So **every unit vector lies in the valuation ring** (`normOne_subset_valuationSubring`, which
exists), the plane decomposes into cosets of `O_v²` with no edge between cosets, and reduction is a graph homomorphism onto `F²`
(`colorable_unitDistance_induce_of_valuationSubring`, which also exists). Hence `χ(F(t)²) ≤ χ(F²)`; the reverse is the induced
subgraph. ∎

**Consequence, worth stating on its own:** `χ(ℚ(π)²) = χ(ℚ(e)²) = 2`. The chromatic number of a field plane cannot see
transcendence degree at all — it is an arithmetic invariant, and "other subfields of ℝ" is a much smaller category than it looks.

**What this does and does not close.** It handles one transcendental over a real base cleanly and cheaply, which is a real kernel
deliverable by itself. It does **not** yet give (ii) for an arbitrary finitely generated `F ⊆ ℝ`: descending such a field needs a
place whose residue field is again **formally real**, which is the theory of real places (Artin–Lang), not Tarski–Seidenberg.
**So Route C trades one Mathlib gap for a different one** — and that is the point: the two gaps should be priced against each
other before either route is committed to, and nobody has priced the real-places one.

***Prior art, found 2026-09-19 at FS-61's gate and read first-hand in the held PDF: the Lemma is `[Fischer1990]` Theorem 6*** —
*"`F^d` can be k-colored (has an additive k-coloring) iff `F(α)^d` can"*, any dimension, proved by clearing denominators in `F[x]`
and setting `x = 0`. **And his Remark 1 is this stub's whole bridge, with a false step:** it reduces a finitely generated `E ⊂ ℝ`
to a number field by asserting `E` is *"a purely transcendental extension of some finite algebraic extension"* of ℚ — false in
general (the function field of a curve of positive genus) — and then invokes de Bruijn–Erdős. So (ii) has been *stated* in print
since 1990 and never correctly *proved* there; this stub's product is the repair — real places, or Tarski–Seidenberg — and the
kernel form. B′ remains a fair half-day kernel theorem, credited to Fischer.

## 3a. Prior-art gate (WORKFLOW 3.2) — owed, never run

This stub predates its own gate. Before any of D2–D4 is written: search for the specialisation argument in the words of valuation
theory and of real algebraic geometry (*real place*, *Artin–Lang homomorphism theorem*, *specialisation of a semialgebraic set*),
and for the statement `χ(ℝ²) = sup over number fields` in the Hadwiger–Nelson literature — `[Madore2015]` ¶5.4 is the nearest thing
we have and is cited in prose only.

## 4. Phases

| phase | what | cost |
|---|---|---|
| A | (i) — compactness of colourings for `unitDistance ℂ`, or the citation of Mathlib's lemma. **Mathlib holds it** (found at FS-73): `Finset.rado_selection` (de Bruijn–Erdős) and `SimpleGraph.nonempty_hom_of_forall_finite_subgraph_hom`; `Kempe.lean`'s `exists_coloring_ne_of_forall_finset` and `forces_iff_exists_finite` are the pattern | an hour or two |
| B | (ii) — the algebraic-drawing lemma, or its statement with the named gap | one to two days, Mathlib-dependent |
| B′ | **D4's transcendence lemma in the kernel** — `chromaticNumber_planeOver_adjoin_transcendental_eq`, plus `χ(ℚ(π)²) = 2` as its named inhabitant | half a day; the two valuation lemmas already exist |
| C | the corollary `chromaticNumber_plane_eq_iSup_numberField` and a rewrite of the prose sentences to cite it | an hour |

**Phase order changed 2026-09-17:** run **B′ before B**, and price Route C's real-places gap against Route B's Tarski gap in the
same sitting. B′ is cheap, standalone, and lands a statement worth having whichever route wins.

## 5. Bearing on 6, honestly

None directly on finding a 6-forcer (D1). High on the honesty of every "χ(ℝ²) = …" sentence the programme writes after M58,
and required by FS-20's paper. Cheap.

**Raised 2026-09-17, and the reason withdrawn 2026-09-19.** This stub was moved from rank 8–13 to rank 3 as a prerequisite of FS-62
(`plans/STUB-six-is-not-a-value.md`), whose headline — *no subfield of ℝ has χ(F²) = 6* ⟺ *χ(ℝ²) ∈ {5, 7}* — turned out to hold in
one direction only, and that direction (ℝ is a subfield) needs no bridge at all. **What the bridge does carry is the correct form,
and it belongs here as phase C's second corollary:**

> **`χ(ℝ²) ≠ 6` ⟺ every real number field `F` with `χ(F²) = 6` has a finite real extension `F′` with `χ(F′²) = 7`.**

(⟸: a number field attaining the plane's 6 has no such extension; ⟹: take the compositum with a number field holding a 7-chromatic
graph. Both use the bridge.) The stub keeps rank 3 on phase B′ alone — a half-day kernel theorem whose two valuation lemmas exist.

## Where the 2026-09-25 work on this lives

*Addresses and titles only, added by the 2026-09-25 crunch's bookkeeper (job J30). The index of that day's work, with its results, is `plans/CRUNCH-2026-09-25-INDEX.md`; a blind verifier does not open it.*

- `plans/M2-kernel-lane.md` — the kernel lane's plan (crunch milestone M2), §2.3 and §4.1 on this stub
- `plans/M2-S2K-route-c.md` — job J15's record: route C in the kernel; module `Proofs/HadwigerNelson/Transcendental.lean`
- `plans/M2-S1D-bridge.md` — job J17's record: the bridge's hand step
- `data/crunch-2026-09-25/briefs/J17K-M2-bridge-kernel.md` — the brief of the queued kernel job on the bridge
- `data/crunch-2026-09-25/reports/J04.md`, `J15.md`, `J17.md` — the job reports
- `plans/M2-close-inventory.md` rows 1, 12–15, 29–34 — items for this stub, including a correction owed to it (row 13)
