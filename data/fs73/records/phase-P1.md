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

---

## P1b — the screens (`tools/fs73_screen.py`)

**What it is.** One driver for periodic colourings of `Cay(Λ, U)` at **any** finite-index period group `W`, not only `NΛ`: the
quotient is built from `W`'s Smith form (a unimodular `C` and invariant factors `d` with `x ∈ W ⟺ (xC)_i ≡ 0 mod d_i`; for `W = NΛ`
the class index is FS-70's big-endian one), and the Smith index is asserted equal to the Hermite index. On a colouring it computes:
- `Per(c)` **exactly**: a 64-point sampled pass proposes candidate periods, a full pass decides each;
- `KPer(c)` **exactly**: the colouring is descended to `Λ/Per(c)`, and `KPer(c)` is the intersection of the voltage groups of
  **every** component of every two-colour subgraph, at all six colour pairs (components by `scipy`'s connected components,
  potentials by a simultaneous breadth-first search, the full multiset `U` kept so parallel edges carry their own voltages);
- T10 at the origin with, for an escape, the period `W′` of the re-periodised separating colouring (R3): the least-index
  `V ⊆ W′ ⊆ W` excluding `δ − p(δ̄)`, from the Smith form of `W/V`, reported with its invariant factors and exponent.
The SAT finders pin the origin 0, its least neighbour 1 and a quotient triangle 2 when one exists; any colours still
interchangeable get a value-precedence break over **all** vertices through auxiliary variables. Aims: plain, `sep` (`c(G) ≠ c(0)`),
`gap`. Every SAT model is re-verified edge by edge; every verdict carries the CNF's sha256, wall and CPU seconds, and the machine.

**Controls** (`data/fs73/records/phase-P1b-selftest.log`; FS-70's own `selftest --plants` in `phase-P1b-fs70-selftest.log`, EXIT 0):

| control | pass condition | result |
|---|---|---|
| (i) §R0's quotient minima, `N = 2..12` | equal to 1e-6 | all eleven equal (e.g. 5: −18.034442, 11: −21.580897, 3: +24) |
| (i) §R0's continuous minimum over `T⁴` | −22.4095 | −22.409530102 (1,000 BFGS starts, analytic gradient) |
| (iii) Theorem B's residue colouring (`tools/residue_colouring.py`, `√33 ↦ S ≡ 17 mod 256`), period 2 | proper; accepted by the finder's own plain CNF (pins permuted); in the `(ℤ/2)²` additive family | all three; basis values `[3,2,0,1]`; the family has 12 members |
| (iii) `[Fischer1994]`'s ℤ/4 colouring (`tools/fischer1994_check.py`'s `v_of`), period 4 | the same, `ℤ/4` family | all three; basis values `[1,1,0,0]`; family 12 |
| (iii) row 50 | `1/2 ∉ Λ` for a nonempty family | `1/2 ∉ Λ` |
| (ii) FS-70's six committed de Grey colourings, re-read class by class through the points and re-screened by this code | `8/3` rigid at 6 of 6; `2` and `4` escape at `N = 2..10`, rigid at 12 (FS-70 1e §3.2) | exactly that |
| (ii) gap finder on L1 at `N = 5` (T6's instance) | a gapped colouring, the gap verified from the colouring | SAT, gap verified |
| (ii) paired: gap finder on de Grey at `N = 8` | UNSAT (Harder + T6 forbid a gap) | UNSAT |
| `KPer` of the `N = 12` colouring | contains `8/3`, lies in `Per` | `Per`: `Λ/Per ≅ ℤ/2 × ℤ/4`; `KPer` rank 4, `Λ/KPer ≅ ℤ/2 × ℤ/8`, `8/3 ∈ KPer` |

**Plants** (each must move the `N = 12` bed or the precedence check): `dedup_steps` (KPer rank 4 → 0), `per_sample` (a one-point
sample accepts false periods; the descended colouring then fails its properness assertion), `kper_first` (`ℤ/2 × ℤ/8 → ℤ/2 × ℤ/4`),
`prec_wrong` (on FS-61's `ℚ(√11)` shape at `N = 7`, whose quotient has no triangle: the faithful CNF accepts the found colouring,
the inverted one refuses it). **Two plants first failed to fire, and that was a defect in the controls, not a pass**: `per_sample`
still ran the 64-point sampled filter, which rejects every false period by itself, and `prec_wrong` was first tested on a
quotient with a triangle, where no precedence clause exists. Both beds were changed so the failure mode is reachable.

**Regenerate:** `python3 tools/fs73_screen.py selftest --plants` (about 1 minute) and
`python3 tools/fs70_periodic_kempe.py selftest --plants` (about 12 minutes).
