# FS-37 — The 2-adic colouring criteria at the field level, in the kernel (stub)

**At the 2026-09-26 consolidation (2026-09-26, consolidation job C3b; `LEDGER.md` row 127).** Row 57's gap, shared with FS-47, is FS-101's named upper half `hUpper` (row 127).

**From M2's close (2026-09-25):** row 57's gap is the one lemma under three results — Theorem A's field-level form, prime inversion's number-field reading (in the kernel in valuation form, `UnitRing.inv_natCast_mem_unitRingOver_iff`, row 105), and ASTRA T7 beyond `K(√7)`; closing it closes all three.

*Minted 2026-09-11 by FS-36's planning (`plans/FS36-multiquadratic-decomposition.md` §3 D3), as that milestone's
carry-forward. A pre-subplan stub under WORKFLOW's stub rule: written so a session with no memory of FS-36 can
subplan it.*

## What this is, in plain language

The project holds two 2-adic colouring criteria for planes over real multiquadratic fields as hand theorems.
Let `V` be the image of the field's square classes in the 2-adic square-class group.
- **Four colours:** if `[−1] ∉ V`, the plane is 4-colourable (`plans/FIELD-WALL-THEOREM.md` §6.2).
- **Two colours:** if also `[3] ∉ V`, it is 2-colourable (the same note's §10.2).

The kernel holds each criterion's **mechanism** for an explicitly given valuation subring:
- four colours by Theorem A, `ResidueColouring.lean`;
- two colours by `TwoColourResidue.lean` (FS-36);
- one field is done concretely, `ℚ(√3, √11)`, by an explicit order and a parity descent (`FieldWall4.lean`,
  Theorem B).

What the kernel does not hold is the step between. **A real multiquadratic field meeting a criterion actually
supplies such a valuation subring, with residue field of the right size and conjugation acting as the criterion
says.** Without that step, FS-36's decomposition carries `χ ≥ 4` for its pieces but not `χ ≤ 4`. The same step is
the gap `plans/A1-theorem-A-kernel.md` §R2 names for Theorem A.

## The question

Can the kernel prove, for a real multiquadratic field `F`:
- **(a)** that `[−1] ∉ V₂(F)` gives `χ(F²) ≤ 4`?
- **(b)** that `[−1], [3] ∉ V₂(F)` gives `χ(F²) = 2`?

If not in general, can it prove the concrete instances FS-36's decomposition names?
- `χ(ℚ(√2,√3,√11,√35)²) = 4`
- `χ(ℚ(√3,√10,√11,√35)²) = 4`
- `χ(ℚ(√3,√11,√35)²) = 4`
- `χ(ℚ(√3,√11,√14)²) = χ(ℚ(√3,√11,√70)²) = 4`. The kernel already holds that both fields pass the test and that the
  plane over their compositum needs five colours (`Instances/CompositumFive.lean`, FS-36 Phase C). These two values
  would finish the statement "no combining rule for test-passing fields gives four" in the kernel.

## Two routes, as priced at minting

1. **Generic** (`plans/A1-theorem-A-kernel.md` §R2's route). Take a number field `L = F(i)` inside `ℂ`, and a
   height-one prime `𝔭` of its ring of integers fixed by conjugation (stability is already proved,
   `conj_mem_valuationSubringAtPrime`). Then:
   - its localization is a valuation subring with residue field `O/𝔭`, finite of size `Ideal.absNorm 𝔭`;
   - for multiquadratic `F`, the prime above 2 has residue degree 2 exactly when `[5]` lies in the image;
   - conjugation lies in inertia exactly when `[3]` does not.

   **The last two steps are the hard part**: Mathlib's decomposition and inertia groups exist, but computing them
   for a Kummer extension is not in the library as of 2026-07. **First action: check whether it has arrived.**
2. **Concrete** (`FieldWall4`'s route). Build an explicit order for the field and a descent.
   - For `ℚ(√2,√3,√11,√35)(i)` the order has rank 32 and the prime above 2 has ramification index 4 (`√2` and `i`
     both ramify), against rank 8 and index 2 for `FieldWall4`. So the parity descent becomes a four-step
     valuation descent, and every kernel product is sixteen times larger.
   - **Priced at a week or more.**
   - **Trap, from the main session:** at that prime `√2` has positive valuation and `√3`, `√11`, `√35`, `i` all
     reduce to 1. The residue field's fourth element comes from `ζ₃ = (−1 + i√3)/2`, so a residue map defined on
     the generators alone only reaches `𝔽₂`.
   - `FieldWall4` solves the analogous problem for `ℚ(√3,√11)`; read its §1–§5 before pricing again.

## Bearing on χ ≥ 6

**None.** Upper bounds on multiquadratic planes below five do not touch the six-level. It feeds FS-20 (the
Theorem A section of the paper), where a field-level statement is worth more than a subring-level one. It would
also turn FS-36's decomposition into a kernel statement about four-chromatic planes.

## Registered expectation

Route 1 is the one worth doing if Mathlib has the inertia computation; otherwise neither route pays for itself
before FS-20 is written.

## Failure clause

If the first action finds no Kummer-extension inertia computation in Mathlib, and FS-20 does not need a field-level
statement, **demote with a banner**; do not start route 2 for its own sake.
