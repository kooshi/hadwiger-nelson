# FS-60 — the quadratic four-colour witnesses in the kernel

*Minted 2026-09-17 at FS-58's close. Read beside: `plans/FS58-four-colours.md` §R-D2, §R-B5; `Proofs/HadwigerNelson/Instances/SqrtEleven.lean`;
`data/fs58/witness-{23,47,71,95,191}/`; `tools/fs58_emit_witness.py`.*

## 1. The question

FS-58 put `χ(ℚ(√11)²) ≥ 4` in the kernel (32.8 CPU seconds, standard three axioms) through the `UDCert` pipeline over the tower
`Q4 = ℚ(√3,√5,√7,√11)`, using only its `1` and `√11` slots. Five more fields have tools-certified witnesses — ℚ(√23) (297 points),
ℚ(√47) (169), ℚ(√71) (148), ℚ(√95) (1,068), ℚ(√191) (483) — but `Q4` has no `√23`, `√47`, … slot. **Put them in the kernel.**

## 2. Shape

* A certificate type over `Adjoin d ℤ` (one quadratic level; `Field/Quadratic.lean`'s `Adjoin` already towers) with the same geometry
  check, or a generic `UDCert` parametrised by the coordinate ring. Price both on the ℚ(√23) witness before choosing (WORKFLOW 3:
  measure where cost decides the shape). Do not edit `Field/Quadratic.lean` or the settled `Sat/` modules casually: they are imported by
  certificates whose rebuild costs hours.
* The generic transfer already exists: `UDCert.point_mem_planeOver` and `UDCert.chromaticNumber_le_planeOver` take any subring whose
  evaluations lie in `F`.
* Statements: `four_le_chromaticNumber_planeOver_of_sqrt_mem (h : √d ∈ F)` per `d`, and the `fieldOfRadicands {d}` instances.

## 3. Also owed

* **The upper halves**, `χ(ℚ(√d)²) ≤ 4` for `d ∈ {11, 23, 71, 95, 191}` via the residue plane at 7 (and `≤ 5` for 47 via 11): the kernel
  has `chromaticNumber_finitePlane7`-type facts and Theorem A's ring form, but the number-field step (row 57's hand gap, FS-37/FS-47) is
  not closed; the exact values `= 4` enter the kernel only with it.

## 4. Expectations and clauses

* Each witness costs under two minutes of kernel time (high, from ℚ(√11)'s 32.8 s and the LRAT sizes).
* **Not a failure:** a field whose LRAT is too large for the kernel pattern at this size — report the price.

**Bearing on χ(ℝ²) ≥ 6:** none; it moves six field values from the checker's word to the kernel's.
