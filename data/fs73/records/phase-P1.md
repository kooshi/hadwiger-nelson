# FS-73 phase P1 — the census: what landed

*Implementer A (Opus 5.5), 2026-09-23, desktop (16 physical cores / 32 threads, 128 GB). The specification is
`plans/FS73-rigidity-dichotomy.md` §S.2 rows P1a–P1g and P1d′, with §S.3's acceptance rows. This record is written so a fresh
implementer can resume from the repository alone: every section ends with the command that regenerates it.*

## Theorems this phase proved

*(filled as phases report; each one line, with its grade and where its proof lives)*

---

## P1a — the field-generic lattice layer (`tools/fs73_lattice.py`)

**What it is.** A lattice of unit vectors over `E = F(i)`, `F = ℚ(√a)` or `ℚ(√a,√b)`, as integer vectors over one denominator `M`,
with a reduced Hermite basis, integer coordinates, and its complete unit-vector set `U` by two independent methods:
- **trace** (default): every unit vector has trace norm `Tr_{F/ℚ}(x² + y²) = [F:ℚ]`, so PARI's `qfminim` on the integer Gram
  `M²·G` enumerates a finite superset exactly (Fincke–Pohst), and the exact norm equation decides each member. Complete for the
  lattice; cost set by the covolume, not by `M`.
- **box** (the brute-force control): every unit vector of `E` with denominator dividing `D`, kept iff in the lattice. Complete at
  `D = M`; below `M` it is labelled "INCOMPLETE" and is a subset.
- The point group: multiplication by unit vectors preserving `Λ`, complex conjugation, Galois sign flips, and composites, each kept
  iff it maps the basis to a basis (integer, determinant ±1) and `U` onto `U`.

**The four controls, each by both methods** (`data/fs73/records/phase-P1a-selftest.log`, 13 s):

| control | expected (source) | trace | box | verdict |
|---|---|---|---|---|
| de Grey's K-lattice `⟨ζ₆^m ρ^n, \|n\| ≤ 2⟩` | rank 4, 54 (G8, row 46, the owner's `po_kempe_control_K.py`) | rank 4, 54, `M = 36` | 54 | pass |
| Λ′ over `E′ = ℚ(√3,√−5)`, denominator 24 | rank 4, 46 (`fs70_lambdaprime.py`) | rank 4, 46 | 46 | pass |
| L3 = `group6:u3:2+zeta6:w4` | rank 6, 42 (FS-70 phase 1e §3.1) | rank 6, 42, `M = 72` | 42 | pass |
| FS-61's shape `Ld65c8ee8` over `ℚ(√11)` | 108 (row 74) | rank 4, 108 | 108 | pass |

Also checked: `ρ³ ∉ Λ` on de Grey's lattice (so `ρ` is no multiplier, and the transport orbit of `8/3` spans only `(8/3)ℤ[ζ₆]`, as
P1d step (3) presumes); `8/3 ∈ Λ`; the point group there has order 24 and contains conjugation and both Galois flips; the box to
`D = 12 < M` is a labelled subset (30 of 54).

**Plants** (each must move a control, and each moved it for its own reason): `sat_drop` (trace 53 ≠ box 54), `box_tight` (box 52 ≠
trace 54), `gal_sign` (point group 24 → 12), `unit_loose` (trace 486 ≠ box 54).

**Regenerate:** `python3 tools/fs73_lattice.py selftest --plants`
