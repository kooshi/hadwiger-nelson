# M37 — the derivation file: every theorem this milestone stated outside the kernel

*Written 2026-09-22 by the FS-71 batch-2a implementer (the theorem audit, backfilling the tracking rule). Enumeration:
`plans/M37-coset-bound.md` read in full. Grades are `CLAUDE.md` § Notation's.*

## The theorems

**M37-T1 — The crude bound for a general planar lattice. [hand; the M37 implementer, "worked by hand at subplanning";
never written up]** For **any** planar lattice `Λ` (not only the triangular one) and any proper coset colouring `c` of
the plane by nearest-`Λ`-point rounding (as in the main theorem's setting, §0a): `c` uses at least 6 colours ("the crude
[Hermite-constant-plus-covering-radius] chain gives `k > 16/3`, i.e. `k ≥ 6`, for every lattice"); and for `Λ` the square
lattice specifically, `c` uses at least 9 colours. *Proof:* **not on disk — looked in** `plans/M37-coset-bound.md` §0a
(the triangular-only derivation), §R (the results section — silent on this), and the "What was NOT done" honesty ledger,
which is the only place either bound is stated: *"For a general planar lattice the same four sweeps give the shape of the
argument, but the endgame changes: the Loeschian arithmetic is replaced by the values of an arbitrary binary quadratic
form, and the bound `k ≥ 7` needs Hermite's constant plus the covering-radius optimum — both attained only by the
hexagonal lattice — so the case `k = 6` requires a near-equality rigidity argument (reduction theory). Worked by hand at
subplanning: the crude chain gives `k > 16/3`, i.e. `k ≥ 6`, for every lattice, and the square lattice needs `≥ 9`; the
missing piece is the shape-space case analysis. Not attempted tonight."* No worked steps, grid, or intermediate identity
is recorded anywhere for either number (6 or 9) — only the one-line conclusion, twice (also repeated verbatim in
`plans/STUB-generalize-the-kernel.md` §2, "the crude Hermite-plus-covering chain gives `k ≥ 6` for every planar lattice").
*Proof verdict:* **unsure — owner to re-derive** (the two numbers are plausible from Hermite's constant `γ₂ = 2/√3` and a
covering-radius argument analogous to C1–C4, but no chain from those facts to `16/3` or to `9` is written down anywhere
in the repository, so this audit cannot follow a proof that was never recorded — only the M37 subplanner's word that
"the crude chain gives" these numbers). *Rests on it:* nothing in the ledger or grokkings cites either bound; only
`plans/STUB-generalize-the-kernel.md`'s own restatement of the `k ≥ 6` half, itself unconsumed (rank "Lowest" there, no
Lean attempted). *Prior art:* the mechanism — Hermite's constant bounding a lattice's covering radius against its
minimum distance, hence bounding a coset colouring's colour count from below — is standard geometry-of-numbers, not a
citable novel result in this shape; the specific application to lattice coset colourings of the plane at exactly this
threshold was not searched in the literature (this is the general-lattice case the triangular theorem (row 34, kernel)
explicitly declines to cover). zbMATH: `ti:"lattice" & ab:"covering radius" & ab:"chromatic"` (0 hits, 2026-09-22),
`ab:"Hermite constant" & ab:"coset coloring"` (0 hits). Nearest held key: none on point — `[SokolovVoronov2025]` and
`[deGreyParts2022]` (row 34's prior art) are about the polygonal-cell family, not the lattice-coset one this claim
generalizes. *Kernel:* declined — `plans/STUB-generalize-the-kernel.md` §2 already prices and declines this at "Lowest"
priority ("mathematics we do not have" for the sharp `k = 6` case; the crude `k ≥ 6` half was never attempted in Lean
either), and no row or later milestone consumes the general-lattice statement — M37's own kernel work (row 34) is
triangular-lattice-only throughout.

## Readings and measurements that were called theorems

(none beyond row 34's own [tools] clauses, already correctly graded — row 34's "the exact value and the arbitrary-label
results" are the kernel theorems `Coset.seven_values`/`seven_le_card`/`exists_proper_coset_colouring`/
`coset_chromatic_eq_seven`, all in `Coset.lean`, none of them outside the kernel.)

## Conjectures surfaced, not claimed

- **The sharp general-lattice bound** (`k ≥ 7` for every planar lattice, matching the triangular case, via the
  "shape-space case analysis" of reduction theory): explicitly marked "the missing piece... not attempted tonight" —
  never worked, hand or otherwise. No stub exists for it beyond `STUB-generalize-the-kernel.md`'s one-line pricing; not
  minted separately here, since nothing in the corpus treats it as live (lowest-ranked, no consumer).

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M37-T1 | declined — `STUB-generalize-the-kernel.md` §2 already prices and declines the whole general-lattice direction at lowest priority; no consumer |
