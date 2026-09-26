# FS-63 — the crystallography gate: coincidence site lattices, Moiré superlattices, aperiodic order

**At the 2026-09-26 re-rank (job R3; `plans/RERANK-2026-09-26.md` § Application — R3): rank 23 → 11 in `plans/FRONTIER-STUBS.md`.** **Re-aimed:** the aperiodic-order gate for `Y` with `p`-adic factors — the product-locality cluster (FS-67, FS-59, FS-96, FS-64). It is **not** `χ_CP(ℝ²)`'s home: with `N_k = ∅` there is no `p`-adic factor and no model set (the advisor; FS-103's gate runs in the measurable and harmonic-analysis words). Provisional bearings add: FS-103 (the collapse — F1, a candidate composition, not a result), FS-104 (`χ_CP(ℝ²)` at six), FS-105 (harden MR).

*Minted 2026-09-17, after Kooshi asked whether any of this connects to Moiré patterns and the answer turned out to be that the
project's rotation family IS the coincidence-rotation family, an identification already derived at M63 phase H3 and left in an
appendix. Read beside: `CLAUDE.md` G62 (the frame), G7 (the type-M family), G46 and G49 (the recognition and prior-art rules),
`plans/M63-phaseH3-prior-art.md` §PA.1 and §PA.4 (what has already been checked), `plans/M63-phaseH2-prior-art.md` §PA.9,
`BIBLIOGRAPHY.md` rows `[BaakeZeiner2017]`, `[BaakeGrimm2003]`, `[BaakeGrimm2004]`, `[PleasantsBaakeRoth1996]`,
`[BaakeScharlauZeiner2011]`.*

---

## 1. Why this gate, and why now

G62 records the identification: with `w = (1 + i√(4n−1))/2`, `|w|² = n` and `w̄/w = −ρ_n`, so **the type-M rotation family is the
coincidence rotation of index `Σ = n` of the imaginary quadratic order of discriminant `1 − 4n`** — verified symbolically for
general `n` and at `n = 3, 4, 16`. Every 5-chromatic witness this project holds is a **twisted bilayer**: a point set plus a rotated
copy, joined at unit distance. That is a Moiré pattern, in the exact technical sense, and the commensurate/incommensurate
distinction is the field wall.

**This project has therefore been doing crystallography in its own coined vocabulary for five milestones.** G49's rule says a
private vocabulary is a perfect filter against finding out you are not first. Two gates have already run partially against this
literature and both were scoped to one narrow question (shelling counts at M63 phase H2, submodule structure at phase H3). **The
frame itself has never been gated.**

---

## 2. What is already checked — do NOT redo these

From `plans/M63-phaseH3-prior-art.md` §PA.4 and `plans/M63-phaseH2-prior-art.md` §PA.9, read at the source:

| already established | consequence |
|---|---|
| `[BaakeZeiner2017]` §6 defines a **submodule** to have the **same rank** (footnote 8 disclaims the general notion) | rank-halving submodules are outside that framework **by definition**, not by oversight |
| `[BaakeGrimm2004]` Definition 1: a **Bravais colouring**'s distinguished class is a *similarity submodule* (`z ↦ az` or `z ↦ az̄`) | our Galois-twisted reality condition is neither map, and it *lowers* symmetry where that programme preserves it |
| The twisted-bilayer-graphene commensurate family is `cos θ = (m²+n²+4mn)/(2(m²+n²+mn))` — the **hexagonal lattice** case | a different one-parameter shape; ours is not in it |
| `[PleasantsBaakeRoth1996]` tabulates Euler factors of `ζ_K(s)`, not indices by angle, and its objects are `ℤ[ζ_n]` | `ρ_n ∈ ℚ(√−(4n−1))` cannot appear; phase H2's item 3 closed |
| Three passes: **no source joins coincidence-site theory to unit-distance colouring** | the bridge is unclaimed ground |
| `[BaakeZeiner2017]` Remark 7.12's four-item shelling inventory holds **no planar module over a non-cyclotomic field** | phase H2's negative, with a denominator |

**And the citation-database trap that fired here** (G49): both OpenAlex and Semantic Scholar report zero citing works for
`[BaakeZeiner2017]`, and their agreement is not independent — same MAG identifier, both the *preprint* record, while OpenAlex holds
the **published chapter** separately with four citing works. Compare identifiers and versions, never counts.

---

## 3. The questions this gate must answer

*In the discipline's words, never ours. The vocabulary: **coincidence site lattice (CSL)**, **coincidence site module (CSM)**,
**coincidence index Σ**, **multiplier ring**, **similar sublattice**, **Moiré superlattice**, **commensurate twist angle**,
**twist boundary**, **grain boundary**, **aperiodic order**, **cut-and-project scheme**, **model set**, **internal space**,
**window**.*

1. **Is the `Σ = n` family tabulated anywhere as a family?** §PA.4 calls our identification "a recognition, not a citation" on the
   strength of one sweep. Confirm or overturn it. The natural homes: `[BaakeScharlauZeiner2011]` (**not held — fetch ask**),
   Zeiner's thesis and papers on coincidence indices of planar lattices, and the generating-function literature (Dirichlet series
   for `Σ`-counts).
2. **Do they have colouring theorems we can use?** Bravais colourings are the known programme and they are symmetry-*preserving*.
   Is there *any* colouring theory for planar modules that would bound a chromatic number — as opposed to classifying invariant
   partitions? This is the question with a free theorem behind it if the answer is yes.
3. **Incommensurate bilayers: what does that literature prove?** Ours are all incommensurate (G62). Crystallography classifies the
   commensurate ones; the incommensurate regime belongs to aperiodic order and to the physics of moiré materials. **Is there a
   structure theory for the union of a module and an incommensurate rotate of it?** That union is exactly our arena.
4. **Cut-and-project / model sets.** An incommensurate Moiré is the projection of a higher-dimensional periodic object, and for a
   number field the internal space is the conjugate embedding. **Has anyone coloured a model set to avoid a distance?** This is
   FS-64's literature and the two stubs should share the sweep.
5. **The `Σ7` reading.** `Instances/Seven.lean`'s 7-colouring is by cosets of the norm-7 Eisenstein ideal, i.e. the `Σ7`
   coincidence site lattice, i.e. the 21.79° twist. Is the hexagonal 7-colouring of the plane described that way anywhere in the
   Hadwiger–Nelson literature? If not, the observation is ours and belongs in FS-20.
6. **Does the coincidence-index arithmetic say anything about the value 6?** Coincidence indices of the triangular lattice are the
   Loeschian numbers coprime to 3 (1, 4, 7, 13, 16, 19, …) and of the square lattice the odd sums of two coprime squares; **6 is
   neither**, for the same reason it is no ideal norm (G64's reading). The literature has generating functions for these sets —
   are they strong enough to say anything about which colour counts a lattice-quotient colouring can realise?

---

## 4. Method and scope

* **Half a day to a day**, per WORKFLOW 3.2, with §PA-shaped output committed whatever the verdict.
* Search under **at least two disciplines** (G49): mathematical crystallography / aperiodic order, and condensed-matter physics
  (moiré materials, twisted bilayers). The physics literature is enormous and mostly electronic-structure; filter on
  *commensurate*, *superlattice period*, *coincidence*, and ignore band structure.
* **Look outside arXiv**: Acta Crystallographica, Zeitschrift für Kristallographie, the *Aperiodic Order* volumes, and theses.
* **Walk the citation graph of the paper that POSED each question**, not only of the nearest theorem.
* **Open every citing work whose title is in the neighbourhood**; an abstract is not a reading (G50).
* Everything found goes into `BIBLIOGRAPHY.md` the same day, with what of ours rests on it and how much was read, per section.

---

## 5. Expectations, and the failure clause

* **Most likely outcome: a rich negative with a denominator** (medium-high). The two existing partial gates both returned
  exclusions-by-definition, which is a pattern: this literature studies *commensurate, equal-rank, symmetry-preserving* structure,
  and every object we care about is *incommensurate, and colour-bearing*. If that holds up, the finding is that **the bridge
  between coincidence theory and unit-distance colouring is unbuilt in both directions**, and FS-20 gets a translation table.
* **Jackpot:** a classification of coincidence rotations for planar modules over non-cyclotomic fields that subsumes the field
  screen, or any colouring theorem for planar modules.
* **The correction risk, and it is real:** G62 asserts that a commensurate twist cannot raise the colour count because the bilayer
  is periodic. If the literature's notion of commensurate is coarser than "shares a finite-index sublattice in the same field",
  the grokking needs rewording. **Check the definition against ours before citing anything.**
* **What this gate cannot do:** it will not produce a forcing mechanism. G62 records that the Moiré frame reaches construction and
  classification and says nothing about compulsion; a sweep that comes back claiming otherwise should be read twice.
