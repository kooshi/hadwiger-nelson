# FS131-IC1 — `Arith/ThreeColourCharacter`: the eight leaves

*The kernel lane's implementer (de Bruijn), 2026-10-13, branch `fs131-wc1` (cut at the skeleton's commit `34d9113b2`). Brief:
`data/fs131/briefs/FS131-IC1-leaves.md`. The plans read: `plans/FS131-KN4-three-four-colours-plan.md` (its dated last section, then
§ 4.1) and `plans/FS131-KN5-three-four-colours-passes.md` (§§ Stage 3, 5, 7). Working files: `data/fs131/ic1/`.*

## Theorems this phase proved

*(filled at each stage; one line per kernel theorem, its declaration and its axioms)*

## Stage 1 — SAVED: the readback

**Quotations.** `data/fs131/ic1/readback.py`: the brief's five quoted blocks (Kooshi's W2; the claim list's theorem and its three
dated lines) against their sources in the coordinator's checkout — **5 IDENTICAL**, exit 0 (`data/fs131/ic1/logs/readback.out`).
Control `--control` changes one word of each quotation in memory: 5 of 5 then DIFFER (`logs/readback.control.out`). The module's
docstring quotes NF4-S6; read against `data/fs131/claims-NF4.md:20` by eye: the same words.

**The instruments, each watched failing before it is believed.**

| instrument | what it reads | its control |
|---|---|---|
| `data/fs131/ic1/lean1.sh <file>` | one file through `lake env lean` with `-DautoImplicit=false -DrelaxedAutoImplicit=false`, under the slot; lean's exit status, messages, wall clock, peak memory | — (a wrapper; the skeleton reads exit 0, eight `declaration uses sorry`, 2.7 s, 3.6 GB) |
| `data/fs131/ic1/statements.sh [file]` with `statement_diff.py`, `lean/StatementFooter.lean` | the skeleton at `34d9113b2` and the working file, each elaborated **at one path** with a footer that prints every constant's kind, name and stored type; every named constant of the skeleton must be in the working file's print with the same kind and type; every `example` of the skeleton must be in the working file as text | `--control` plants three faults in the second print (a statement changed by one character, a declaration removed, a theorem made an axiom): 3 of 3 reported. **On a file**: a copy with `(_hk : 0 < k)` added to `isClosed_band` reads `TYPE THM …isClosed_band: the stored statement differs`, exit 1 (`logs/statements-planted-file.out`) |
| `data/fs131/ic1/probes/NameCheck.lean` | 47 library names the routes read, under the module's own four imports | one name I guessed without its namespace (`planeOverSubring`, which is `Chain.planeOverSubring`) is the one error line: an unknown name is reported |

On the untouched skeleton the statement check reads 9 theorems compared (the eight leaves and `exists_character_one_two`), 2
`example`s, PASS (`logs/statements-stage1.out`). **The tool defect FS131-IU1 names** — a statement printed from two paths differs in
an instance binder's stored name — is why both prints are made at `stmt/Copy.lean`, in turn. This module has no compiled data in
this tree (its `.olean` was never built here), so the comparison is made from the two source texts as the elaborator stores them,
not from two builds; after the build at the end the stored types are printed once more from the compiled module.

**The eight leaves: each statement read in the source, restated in one line, with the plan's route.** I derived each by hand
before reading its route; every one is true as typed, and no statement disagrees with its plan.

| leaf | the statement, in one line | the plan's route |
|---|---|---|
| `exists_int_vector_of_forall_neg` (C3) | finitely many real-linear functionals `ℓ k` on `ι → ℝ` (`ι` a fintype, `κ` finite), all negative at one real vector `c`, are all negative at the cast of one integer vector `N : ι → ℤ` | KN5 § Stage 3, C3: the set is open (a finite intersection of open half-spaces), rational vectors are dense (`Rat.denseRange_cast`, `DenseRange.piMap`), scale by a common denominator |
| `ThreeColour.Winding.exists_box_point` (L1.1) | a winding `W` of `s : Fin m → A` has a real point `x ∈ [1/3, 2/3]^m` with `Σ_j r_j x_j = W r` for every relation `r` | KN5 § Stage 3, C1–C4 (replacing KN4 § 4.1's step (v)): generators `r_1 … r_n` of the relation lattice; were no box point a solution on generators, a functional separates the image of the box from the target (`geometric_hahn_banach_closed_point`); C3 at the `2^m` vertices makes its coefficients integers, giving a relation `r` with `r·v < W r` at every vertex; `W.minRise_le` at `−r` gives a vertex with `W r ≤ r·v` |
| `exists_character_of_box_point` (L1.2) | if `Σ_j r_j x_j` is an integer for every relation `r` of `s`, some character `θ : A →+ ℝ/ℤ` has `θ (s j) = x j mod 1` for every `j` | KN4 § 4.1: `r ↦ ↑(Σ r_j x_j)` on `ℤ^m` kills the relations, so descends to the range of `relMap s`; extend to `A` by Baer (`Module.Baer.of_divisible`, the pattern of `CharacterColouring.exists_ratLinear_extension`) |
| `exists_character_of_properAlong` (L1.3) | a colouring `c : A → ZMod 3` proper along `s` gives a character with every `θ (s j)` in `band 3` | KN4 § 4.1: `nonempty_winding`, L1.1, L1.2 with `n := W.toHom r`; `band 3` is the image of `Icc (1/3) (1 − 1/3)` |
| `isClosed_band` (L1.4) | `band k` is closed in `ℝ/ℤ`, for every `k : ℕ` | KN4 § 4.1: a compact interval's image under the continuous quotient map, in a Hausdorff space |
| `bandSet_nonempty_of_finite` (L1.5) | for closed `B ⊆ ℝ/ℤ` and `U ⊆ M`: if every finite subset of `U` has a character of `M` with values in `B` on it, so has `U` | KN4 § 4.1: closed sets in the compact space `M → ℝ/ℤ` with the finite intersection property |
| `bandSet_three_nonempty_of_proper` (L1.6) | a colouring `c : A → ZMod 3` with `c (a + u) ≠ c a` for every `a` and every `u ∈ U` gives a character of `A` with values in `band 3` on `U` | KN4 § 4.1: L1.5 at `band 3` (L1.4); a finite `S ⊆ U` is `s : Fin m → A` by `S.equivFin`; L1.3 |
| `fieldBandSet_three_nonempty_of_colorable` (L1.7) | for a subfield `F ⊆ ℝ`, a proper 3-colouring of the unit-distance graph on `planeOver F` gives a point of `fieldBandSet F (band 3)`: a character of `unitRing F` with values in `band 3` on the unit vectors of `F²` | KN4 § 4.1: the colouring restricted to `unitRing F ⊆ planeOver F`, read in `ZMod 3`; `dist (a + u) a = ‖u‖ = 1` at a unit vector; L1.6 |

**What the hand derivation saw** (nothing that changes a statement). C3 at `κ` empty is the zero vector; at `ι` empty its hypothesis
forces `κ` empty. L1.1 is true with no hypothesis beyond the winding: `minRise_le` at `r` and at `−r` puts `W r` between the least
and the greatest value of `r·x` on the box, which is the whole content. L1.2's hypothesis names no box (KN5 § Stage 4 weighed it).
L1.5 is true at `U = ∅` (the zero character), which the route's intersection over the empty family must still produce: the
compact set is the additive maps, not the whole space. L1.7 reads `ZMod 3` as `Fin 3` by unfolding, as
`ThreeColour.nonempty_winding_of_colorable` already does.

**Plan of work**, in the plan's dependency order: C3 → L1.1 (with two private children: the vertex bound C1, and the real-linear
statement "if every integer combination is non-negative at some vertex, a box point solves the equations") → L1.2 → L1.3 → L1.4 →
L1.5 → L1.6 → L1.7. Saved stages: after L1.1; after L1.5; at the end.
