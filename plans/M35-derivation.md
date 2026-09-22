# M35 — the derivation file: every theorem this milestone stated and proved outside the kernel

*Written 2026-09-22 by the FS-71 batch-1 implementer. Enumeration: `plans/M35-k5-transfer.md` read in full;
`plans/M35-certified-union.md` (a demoted stub, never run — no theorem) skimmed.
Grades are `CLAUDE.md` § Notation's.*

## The theorems

**T1 — The coset ladder on the triangular lattice: an exact enumeration at index ≤ 5. [tools; exact enumeration,
the M35 implementer]** Sublattices of `ℤ[ζ₆]` of index `N` correspond exactly to the Hermite-normal-form bases
`{(a,0), (b,d)}` with `a·d = N`, `0 ≤ b < a` (hex coordinates `a + bζ₆`, norm `a² + ab + b²`). Over the complete
enumeration of such bases at `N = 4` and `N = 5`: every index-4 sublattice contains a lattice vector of norm 1 or 4
(so no coset 4-colouring of the triangular lattice avoids the distance pair `{1, 2}`); every index-5 sublattice
contains a vector of norm 1 or 3 (so no coset 5-colouring avoids `{1, √3}`, hence none avoids the compound
`{1, √3, 2}`); but exactly three of the five index-5 sublattices (the `(5,1)`-type at `b = 1, 2, 3`, e.g.
`⟨(5,0), (1,1)⟩`) avoid norms `{1, 4}` with minimum norm 3, so coset 5-colourings of the LATTICE avoiding `{1, 2}` DO
exist. *Proof:* `plans/M35-k5-transfer.md` §0a, C4 ("The coset ladder on the lattice (Hermite-normal-form
enumeration, exact and complete)") — exact and complete by construction, a finite enumeration of integer
factorisations `a·d = N` with `0 ≤ b < a`, each basis's minimum norm computed exactly. *Proof verdict:* closes (a
finite, exhaustive, exact computation; no sampling). *Rests on it:* the phase-2 search-design decision that `d = 2`
is the "most promising class" for a `k = 5` avoider hunt (the lattice already 5-avoids `{1, 2}`); not consumed by any
kernel Lean development found in this audit, and not restated in `LEDGER.md` row 32. *Prior art:* the object (index-N
sublattices of the Eisenstein/hexagonal lattice, norm form `a² + ab + b²`) is classical ideal theory of `ℤ[ω]`; a
LATER milestone (M37, row 34, outside this batch) cites `[SokolovVoronov2025]`, `[Ivanov2007]`, `[deGreyParts2022]`
for the general coset-chromatic-number-of-the-plane question, but this is a narrower, earlier, unpublished-elsewhere
enumeration (avoidance of one specific two-distance set on the bare LATTICE, not the plane's coset chromatic number)
used only to steer a search — a different question from row 34's. zbMATH: `ti:"sublattice" & ab:"hexagonal lattice" &
ab:"coloring"` (0 hits), `ab:"Eisenstein integers" & ab:"ideal" & ab:"coloring"` (0 hits). Nearest held key:
`[SokolovVoronov2025]` / `[deGreyParts2022]` (§ A, read) — a different question, noted for orientation only.
*Kernel:* declined — used only to steer a search; M35's actual kernel deliverable is the hex-shell clique
(`Instances/HexShell.lean`, row 32) and `mono_pair_of_clique` (row 31/M34's `Pigeonhole.lean`), neither of which
needs the coset ladder.

## Readings and measurements that were called theorems

- C3 ("the hex-shell clique") and C5 (A1, `not_colorable_iff_covers`) are restated in M35 §0a but were already proved
  as kernel theorems at M34 (row 31, `Pigeonhole.lean`, `Instances/HexShell.lean`) — not re-filed here; M34 holds no
  separate derivation file (see the batch-1 census table).
- C1 (the `de Bruijn–Erdős` compactness reduction: a class `D` firing at `k` colours on some finite region
  `⟺ χ(ℝ²; {1} ∪ D) ≥ k+1`), C6 (the covering-radius arithmetic ruling out a fine-pixel brick route, `N ≥ 12`) and
  C4's sibling C2 (the organizing bound: single-class avoidance forces at most 3 pairwise-distinct points on a
  circle, `= 3` iff `d = √3`) are hand a-priori arguments used to aim the search, not independently load-bearing
  theorems; not filed.

## Conjectures surfaced, not claimed

(none)

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| T1 | declined — used only to steer a search |
