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

## What FS-61 added (2026-09-20) — the input set, and four things to know

FS-61 (the census of real quadratic fields, `plans/FS61-quadratic-census.md`, ledger row 74) certified more fields in FS-58's own
`witness.json` + `witness.lrat.gz` format, under the same frozen checker. The manifest is **`data/fs61/witnesses.jsonl`** (sizes,
hashes, minimality, deletion state); the state of each field is `data/fs61/census.md`; every witness also passed the owner's
decorrelated recheck (`data/fs61/owner/recheck-all.out`, a sha256 per file).

1. **The certificate type should be parametric in `d`.** All the witnesses share one format and one checker; the fields are
   `d = 11, 23, 47, 59, 71, 95, 119, 143, 191, 311, 335, 359, 431` (and 239 if `census.md` shows it landed). Upper halves are the
   dyadic bound at `d ≡ 3 (mod 8)` (`[Fischer1990]` Thm 10(i) — *not* Thm 9, corrected 2026-09-20) and the residue planes at 7 and 11.
2. **Sizes run from 131 to 1,739 points and the variation is the deletion budget, not the field.** Seven are 1-minimal (11, 47, 71,
   119, 191, 311, 335): formalise those first. A witness that is not 1-minimal is not a weaker certificate; it is a heavier one.
3. **Certificate weight is a cliff**: 1,004 points → 19 MB of gzipped LRAT, 1,739 (`d = 59`) → 39.7 MB. `d = 95` is the expensive
   field to shrink (core rounds ~90 s with a slow tail on every ball tried), and a stopped deletion can never be finished later —
   the frozen `extract` resumes at a stale scan position — so shrinking means a from-scratch run on another ball.
4. **`d = 11` has a 189-point direct-route witness** (`data/fs61/witness-11/`) beside the 204-point chain witness the kernel already
   holds (`Instances/SqrtEleven.lean`). They are different graphs; the direct one's provenance is a single ball and it may be the
   easier object for a generic certificate type.

