# FS-131, wave 10 — the kernel plan: the fourteen arithmetic rows

*Job FS131-K10 (de Bruijn, the planner), 2026-10-06, branch `fs131-w10`. Brief: `data/fs131/briefs/FS131-K10-wave10.md`. The milestone's
plan is `plans/FS131-kernel-plan.md` (§§ 7.1–7.5 bind this job); the claim list is `plans/LEAN-BACKLOG.md`. Nothing in this milestone is
blind (inventory ruling 1), so the derivations are read from the start.*

## Theorems this phase proved

*(filled at each saved stage; a planning job proves the foundation and the leaves it found short)*

## Stage 1 — SAVED: the readback, the build as given, the registered expectations

### 1.1 The brief's quotations against their sources (standing rule 3)

Checked by script (`grep -F` of each quoted string in the file the brief names; the script's text is in this job's log,
`data/fs131/k10/logs/quotations.txt`): **eleven of eleven match.**

| quotation (first words) | source | result |
|---|---|---|
| "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | match (the brief stops before "Your predecessor formalized …") |
| "### 7.3 What each wave's planning job must hold" | `plans/FS131-kernel-plan.md:556` | match |
| "1. **Reads its rows' derivation entries in full** …" | `:560` | match (the brief's line ends at the source's line break) |
| "3. **States every row at the class its argument reads** …" | `:568` | match (same) |
| "4. **Names every hypothesis from outside the backlog** …" | `:570` | match (same) |
| "**Wave 10** (14 rows):" and its four module lines | `:550–554` | match, all five |
| "\| `Row123Chain` \| row 123's chain …" | `:584` | match |

The CSV (`data/fs131/k1/dispositions.csv`, lines 179 and 248–260) gives all fourteen rows `formalize`, wave 10, with one ruling mark
(TC1-STANDING-FIVE: "its unconditional clauses (the field, its places above 2, no usable residue field of size <= 47, so L(F) >= 7) in
wave 10; 'given MR, chi(F^2) >= 5' as an implication from row 123's chain") and the C109 reason on the three FS-89 rows.

### 1.2 The branch as given

`scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` in this worktree, 2026-10-06: exit 0, "all 1767 modules
already up to date, nothing built, 0 module(s) with warnings" (`data/fs131/k10/logs/build-0-as-given.log`).

### 1.3 What `Proofs/HadwigerNelson/Arith/` and its neighbours already hold (read before the derivations)

- `Arith/NoAffine`, `Arith/FalconerFan` (wave 1), `Arith/PlaceHom`, `Arith/FalconerField`, `Arith/Dyadic` (wave 2): none defines a
  character group, a band set or a spectral measure. `Arith/Dyadic` holds `sqrt3_dyadic` (TC1-SQRT3-DYADIC, merged), TC1-STANDING-FIVE's one
  upstream id.
- `UnitRing`: `unitRingOver F : Subring ℂ` (`R_F = ℤ[U_F]`), `planeOverSubfield F` (`F(i)`), `exists_sum_eq_of_mem_unitRingOver` (every
  element a finite sum of unit vectors), `inv_five_mem_unitRing_conj`.
- `SpectralChain` (FS-100): `unitVectors`, `unitRing`, `Dual F = AddChar (unitRing F) Circle` with the cylinder σ-algebra, `rot`, `RotInv`,
  `InvariantColouring`, `IsTraceSpectral`, `BochnerHerglotz`, the `Interface` (`E`, `TA`, `h` as data; R-U, A⁺, PE-2, EF_F⁺, MR as named
  `Prop`s), SP-Cor (`Interface.x4_eq_empty`), `StablePrime`, `levelTarget`, `localBound`, and the headline
  `min_localBound_five_le_chromaticNumber` — **row 123's chain already stands in the kernel over named hypotheses**, so `Row123Chain`'s
  Lean form is that theorem's conclusion, `min (localBound F) 5 ≤ χ(F²)`.

### 1.4 Registered expectations (written after reading the fourteen backlog entries and the modules above, before reading any derivation)

- **X1** rows I can state as theorems with no named hypothesis from outside the backlog: median 6 of 14, 80 % interval [3, 10].
- **X2** at least one statement defect beyond the known C109 (the Notation's `A`): 0.7.
- **X3** TC1-STANDING-FIVE's "so `L(F) ≥ 7`" needs more than `Row123Chain` — lower bounds for the finite targets, held outside the kernel:
  0.8. (Reason: `L(F)` is an infimum of chromatic numbers over every stable prime, an infinite family of finite graphs, and nothing in the
  backlog bounds them.)
- **X4** J45-N1, -N2, -SI-J need a foundation Mathlib lacks at the pin (spectral measures on the dual of a countable discrete ring,
  Bochner): 0.85; they are stated over `SpectralChain`'s `Dual` with Bochner as a named hypothesis: 0.6.
- **X5** leaves I prove in this job: J45-SP-oi 0.9; FS89-S0A-10 as a composition 0.6; FS89-CL2 as a composition over named hypotheses
  0.6; X25B-PZ 0.3.
- **X6** at least two rows "are one theorem" or belong elsewhere (SP-if and SP-oi read as one iff): 0.7.
- **X7** the wave's close (all fourteen sorry-free): median three implementer jobs, 80 % interval [1.5, 8]. Short: SP-oi, SP-if, S0A-10,
  CL2, S0A-2. Long: N1, N2, SI-J, TC1-STANDING-FIVE's arithmetic.
