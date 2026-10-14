
## Drafts for the landing (files this job does not write; each names its slot)

**DC1. `scripts/Axioms.lean`, under CLEAN** — the block `data/fs133/ib2/axioms-block.txt`, appended where the waves
append their CLEAN records (above the PURCHASED banner, after FS133-IB1's block DB1): its header comment and 25
`#print axioms` lines, one per public declaration of `Plane/OneClass/Defs` (16 theorems, 6 definitions, 3
structures). **FS133-IB1's block DB1 (`data/fs133/ib1/axioms-block.txt`) then loses its line
`#print axioms HadwigerNelson.OneClass.countable_algPlane`** (the declaration is now `Defs`'s and in this block; its
header's count reads 18 records, 17 theorems and the definition, for the two modules it names). No line goes under
IMPORTED: no record of `Defs` rests on the declared outside theorem (stage 3; the plan's § 5.5).

**DC2. The model for each hypothesis** (`LEAN.md` § The gate). No model was added as a declaration: a public
declaration is outside this job's touches, and the file already ships two (`isInvariantLaw_dirac`,
`IsInvariantLaw.isPlaneSystem`). Each note names a library theorem or a term that inhabits the hypotheses all at
once, at a parameter nothing refutes.
- **`IsPlaneSystem P τ ρ` — the hypothesis of the field theorem `OneClass.exists_field` (`Plane/OneClass/Field`)**:
  **`IsInvariantLaw.isPlaneSystem`** is its model in the kernel, on the standard three — the labellings of the
  algebraic plane with `shiftLab`, `turnLab` and any invariant law. The law that exercises the field theorem's clause
  (c) (FS133-IA1's draft D2) is **the law of `exists_isInvariantLaw_unitDistance`** (`Plane/OneClass/InvariantLaw`,
  kernel, standard three): with `ι := Unit` and `f ℓ := if ℓ 0 then 1 else 0` (measurable, `[0, 1]`-valued, fixed by
  `turnLab u` because `kCoeff u * 0 = 0`), the premise of clause (c) holds at `z := 1` (`‖1‖ = 1`, so the law's
  independent sets never hold both `0` and `1`), and the observable is not almost surely `0`: its mean is the law's
  density, the ratio of `unitDistance E`, at least that of `unitDistance ℂ` (`finIndepRatio_le_of_embedding` at
  `algPlaneEmbedding`) and so at least `1/7` (`inv_le_finIndepRatio_of_colorable` at `HadwigerNelson.plane_colorable_seven`,
  `Instances/Seven`). The point mass at the empty labelling (`isInvariantLaw_dirac`) is
  a model of the fields where clause (c) is met only trivially (its observable is `0`).
- `IsShiftInvariantLaw G P`, `IsInvariantLaw G P`: `isInvariantLaw_dirac G` (every graph, density `0`) and, at
  `G := unitDistance E`, the law of `exists_isInvariantLaw_unitDistance` (density the ratio, positive).
- `finIndepRatio_le_of_embedding` (`f : G ↪g G'`): `algPlaneEmbedding` (this file).
- `inv_le_finIndepRatio_of_colorable` (`h : G.Colorable k`): `unitDistance ℂ` at `k := 7`
  (`HadwigerNelson.plane_colorable_seven`, `Instances/Seven`).
- `finIndepRatio_le_of_forall_card_le` (`hS`, `h`): `S := {0, 1}` in `unitDistance ℂ`, `a := 1` (the two points are
  at distance one, so an independent subset has at most one); and any singleton at `a := 1`, which is the proof of
  `finIndepRatio_le_one`.
- `finIndepRatio_le_one` (`[Nonempty V]`): any graph on a nonempty type.
- `upperDensity_le_mOne` (`hA`, `hind`): `Metric.ball 0 (1/2)` with `measurableSet_ball` and `isIndepSet_ball_half`.
- `le_finIndepRatio_iff`, `inv_finIndepRatio_le_iSup_fractionalChromaticNumber`, `isIndepSet_unitDistance_iff`,
  `mOne_le_iff`, `mOne_le_one`, `mOne_eq_iSup_nullMeasurableSet`, `minIndepNum_one`, `countable_algPlane`: no
  hypothesis that is a structure.
- The vacuity scan will read the binders `GENERIC` (no colouring binder of a tracked predicate; the law structures
  are this file's). The assumptions step: no hypothesis of this file stands for an outside theorem or a hand result.

**DC3. `data/fs133/claims-K1.md`** (the coordinator's file; the dated line for Amendment 1) — one constant moved:

| constant | from | to | stored type | ruling |
|---|---|---|---|---|
| `HadwigerNelson.OneClass.countable_algPlane` | `Plane/OneClass/InvariantLaw` | `Plane/OneClass/Defs` | identical in the full print (stage 3) | Amendment 1, option (a) |

**DC4. `ARCHITECTURE.md` § 3**, the rows of the two modules:
- `Plane/OneClass/Defs`: "**FS-133 (FS133-K1; a skeleton).**" → "**FS-133 (FS133-K1's statements, FS133-IB2's
  proofs; no `sorry`).**"; and the row gains "`countable_algPlane` (the algebraic plane is countable; moved here from
  `InvariantLaw`, FS133-IB2)". Its imports cell is unchanged: no import was added.
- `Plane/OneClass/InvariantLaw`: its row does not name `countable_algPlane`, so the move changes nothing in it
  (FS133-IB1's draft DB5 for that row stands).

**DC5. `LEAN.md` § Searching — Lean**, new bullets:
- "A point mass on `E → Bool` sees single labellings only when the index set is countable: `ae_dirac_eq` asks
  `MeasurableSingletonClass`, which `Pi.instMeasurableSingletonClass` gives from `Countable E`; with an uncountable
  index set a product-measurable set depends on countably many coordinates and `{I | ∃ z, I z = true}` has
  point-mass one at the empty labelling. `Countable` of the algebraic numbers with no `Mathlib.Algebra.AlgebraicCard`:
  `ℚ[X]` injects into `List ℚ` by the first `natDegree + 1` coefficients, and each algebraic number is in
  `p.rootSet ℂ` for a nonzero `p` (`Polynomial.rootSet_finite`, `Polynomial.mem_rootSet`;
  `OneClass.countable_algPlane`, FS133-IB2)."
- "`fun J => G.IsIndepSet (J : Set E)` as a `Finset.filter` predicate on `S.powerset` elaborates `J : Set E` from the
  ascription and the filter then fails ('expected `Finset (Set E)`'): annotate the binder, `fun J : Finset E => …`
  (FS133-IB2)."
- "An implementer's working module that imports a module it has just changed cannot be elaborated by `lake env lean`
  until the build recompiles the import; a farm (a symlink copy of the tree's `.lake/build/lib/lean`, the changed
  module compiled with `lean -o` over its removed symlink) elaborates it in seconds with the build's own library
  untouched (`data/fs133/ib2/farm1.sh`, FS133-IB2)."
