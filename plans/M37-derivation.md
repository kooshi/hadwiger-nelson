# M37 — the derivation file: every theorem this milestone stated outside the kernel

*Written 2026-09-22 by the FS-71 batch-2a implementer (the theorem audit, backfilling the tracking rule). Enumeration:
`plans/M37-coset-bound.md` read in full. Grades are `CLAUDE.md` § Notation's.*

## The theorems

(none — the one candidate, M37-T1, is demoted below: the owner's re-derivation found its recorded chain does not close.)

## Readings and measurements that were called theorems

(none beyond row 34's own [tools] clauses, already correctly graded — row 34's "the exact value and the arbitrary-label
results" are the kernel theorems `Coset.seven_values`/`seven_le_card`/`exists_proper_coset_colouring`/
`coset_chromatic_eq_seven`, all in `Coset.lean`, none of them outside the kernel.)

## Conjectures surfaced, not claimed

- **M37-T1, demoted 2026-09-22 by the owner's re-derivation — the crude bound for a general planar lattice is a conjecture, not
  a theorem.** *The claim, as recorded:* for any planar lattice `Λ` a proper nearest-point coset colouring uses `k ≥ 6` colours
  ("the crude Hermite-plus-covering chain gives `k > 16/3`") and the square lattice needs `k ≥ 9`. *What the chain actually
  proves.* Write `μ` for `Λ`'s covering radius, `λ₁` its minimum, `w_v` the width of its Voronoi cell in the direction of `v`
  (`λ₁ ≤ w_v ≤ 2μ`: the cell contains the disc of radius `λ₁/2` and lies in the disc of radius `μ`), and `s` the scale. Properness
  needs the cell diameter `2μs < 1`, and for every `v ∈ Λ'∖0` (same-colour cells `C`, `C + sv`, whose distance set is the interval
  `s[|v| − w_v, |v| + w_v]`) either **(a)** `s(|v| − w_v) > 1`, giving `|v| > 1/s + w_v > 2μ + λ₁`, or **(b)** `s(|v| + w_v) < 1`,
  in which case the multiples `nv` have distance intervals of width `2 s w_v` spaced `s|v|` apart, and 1 must fall in a gap between
  consecutive ones, forcing `|v| > 2w_v ≥ 2λ₁`. So the chain proves **`λ₁(Λ') > 2λ₁(Λ)`** (case (b) is the weaker), and with
  Hermite (`λ₁(Λ')² ≤ (2/√3)·k·det Λ`) it gives `k > 2√3·λ₁(Λ)²/det Λ`: **at the hexagonal lattice `k > 4`, so `k ≥ 5`** (then the
  norm-form argument of row 34 excludes 5 and 6, and the kernel's 7 follows — consistent). The recorded `16/3` substitutes the
  cell *diameter* `2μ` for the width `w_v` in the direction of the shortest same-colour vector and takes case (a) only
  (`|v| > 4μ`, then `k > 16/3` by Hermite and the hexagonal covering optimum `det Λ ≤ (3√3/2)μ²`); neither substitution is
  justified — a Voronoi hexagon's width across the flats is `√3μ`, not `2μ`, and case (b) exists. For an elongated lattice
  `λ₁²/det Λ → 0`, so the chain gives no universal constant at all; the square lattice's `≥ 9` would need, beyond the chain
  (`λ₁(Λ')² > 4` in `ℤ²`, so `k ≥ 4` by Hermite), an enumeration of the sublattices of index 4–8 that nobody wrote (the owner
  checked by Hermite normal form that no sublattice of `ℤ²` of index ≤ 8 has minimum norm ≥ 9, but the chain does not deliver
  `≥ 9` as the threshold in the first place, only `> 4`). **Conjecture C1:** every planar lattice's proper nearest-point coset
  colouring needs at least 6 colours, and the square lattice's at least 9 — plausible (elongated lattices need many colours along
  their short axis, by a different argument), unproved, no consumer; it stays with `plans/STUB-generalize-the-kernel.md` §2,
  whose "the crude chain gives `k ≥ 6` for every planar lattice" is corrected by this record. *The original entry, kept for the
  audit trail:*

  > **M37-T1 — The crude bound for a general planar lattice. [hand; the M37 implementer, "worked by hand at subplanning";
  > never written up]** For **any** planar lattice `Λ` (not only the triangular one) and any proper coset colouring `c` of
  > the plane by nearest-`Λ`-point rounding (as in the main theorem's setting, §0a): `c` uses at least 6 colours ("the crude
  > [Hermite-constant-plus-covering-radius] chain gives `k > 16/3`, i.e. `k ≥ 6`, for every lattice"); and for `Λ` the square
  > lattice specifically, `c` uses at least 9 colours. *Proof:* **not on disk — looked in** `plans/M37-coset-bound.md` §0a
  > (the triangular-only derivation), §R (the results section — silent on this), and the "What was NOT done" honesty ledger,
  > which is the only place either bound is stated: *"For a general planar lattice the same four sweeps give the shape of the
  > argument, but the endgame changes: the Loeschian arithmetic is replaced by the values of an arbitrary binary quadratic
  > form, and the bound `k ≥ 7` needs Hermite's constant plus the covering-radius optimum — both attained only by the
  > hexagonal lattice — so the case `k = 6` requires a near-equality rigidity argument (reduction theory). Worked by hand at
  > subplanning: the crude chain gives `k > 16/3`, i.e. `k ≥ 6`, for every lattice, and the square lattice needs `≥ 9`; the
  > missing piece is the shape-space case analysis. Not attempted tonight."* No worked steps, grid, or intermediate identity
  > is recorded anywhere for either number (6 or 9) — only the one-line conclusion, twice (also repeated verbatim in
  > `plans/STUB-generalize-the-kernel.md` §2, "the crude Hermite-plus-covering chain gives `k ≥ 6` for every planar lattice").
  > *Proof verdict:* **unsure — owner to re-derive** (the two numbers are plausible from Hermite's constant `γ₂ = 2/√3` and a
  > covering-radius argument analogous to C1–C4, but no chain from those facts to `16/3` or to `9` is written down anywhere
  > in the repository, so this audit cannot follow a proof that was never recorded — only the M37 subplanner's word that
  > "the crude chain gives" these numbers). *Rests on it:* nothing in the ledger or grokkings cites either bound; only
  > `plans/STUB-generalize-the-kernel.md`'s own restatement of the `k ≥ 6` half, itself unconsumed (rank "Lowest" there, no
  > Lean attempted). *Prior art:* the mechanism — Hermite's constant bounding a lattice's covering radius against its
  > minimum distance, hence bounding a coset colouring's colour count from below — is standard geometry-of-numbers, not a
  > citable novel result in this shape; the specific application to lattice coset colourings of the plane at exactly this
  > threshold was not searched in the literature (this is the general-lattice case the triangular theorem (row 34, kernel)
  > explicitly declines to cover). zbMATH: `ti:"lattice" & ab:"covering radius" & ab:"chromatic"` (0 hits, 2026-09-22),
  > `ab:"Hermite constant" & ab:"coset coloring"` (0 hits). Nearest held key: none on point — `[SokolovVoronov2025]` and
  > `[deGreyParts2022]` (row 34's prior art) are about the polygonal-cell family, not the lattice-coset one this claim
  > generalizes. *Kernel:* declined — `plans/STUB-generalize-the-kernel.md` §2 already prices and declines this at "Lowest"
  > priority ("mathematics we do not have" for the sharp `k = 6` case; the crude `k ≥ 6` half was never attempted in Lean
  > either), and no row or later milestone consumes the general-lattice statement — M37's own kernel work (row 34) is
  > triangular-lattice-only throughout.
  >

- **The sharp general-lattice bound** (`k ≥ 7` for every planar lattice, matching the triangular case, via the
  "shape-space case analysis" of reduction theory): explicitly marked "the missing piece... not attempted tonight" —
  never worked, hand or otherwise. No stub exists for it beyond `STUB-generalize-the-kernel.md`'s one-line pricing; not
  minted separately here, since nothing in the corpus treats it as live (lowest-ranked, no consumer).

## Prior art re-attributed

(none)

## Kernel decisions, summarised

| theorem | decision |
|---|---|
| M37-T1 | demoted to conjecture C1 (proof does not close; owner's re-derivation above) — nothing to kernel-check |
